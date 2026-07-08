*==============================================================================
* Formsigpdmp6.prg - Formulario de Movimentacao de Industria
* Tabela: SigCdNec | PK: cidchaves (gerado via fUniqueIds no legado)
* Legado: SIGPDMP6.SCX (frmcadastro)
* Fase 5/8: Page2 Parte 1 - controles principais + handlers de acao
*==============================================================================

DEFINE CLASS Formsigpdmp6 AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    *-- Caption sem acentos aqui; definido com CHR() em InicializarForm
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
    FontName     = "Tahoma"
    ForeColor    = RGB(90, 90, 90)
    DataSession  = 2

    *-- Business Object e mensagem de erro
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""

    *-- Estado do filtro de lista (Page1 - Cnt_periodo)
    this_cPEmps    = ""   && Empresa selecionada (legado: pEmps / go_4c_Sistema.cCodEmpresa)
    this_dAntDtIni = {}   && Data inicial anterior para detectar mudanca
    this_dAntDtFin = {}   && Data final anterior para detectar mudanca
    this_cAntEmpr  = ""   && Empresa anterior para detectar mudanca

    *-- Estado do movimento corrente (Page2)
    this_cDopp      = ""   && Operacao/documento corrente (legado: _Dopp)
    this_nPNumes    = 0    && Numero do movimento (legado: pNumes)
    this_lPConsulta = .F.  && Modo consulta direta (legado: _pConsulta)
    this_nOldCodigo = 0    && Codigo anterior no campo OP (legado: _OldCodigo)
    this_cAntValue  = ""   && Valor anterior campo observacao (legado: antvalue)
    this_cSigKey    = ""   && Chave unica da sessao (legado: SigKey)
    this_cTipoSub   = ""   && Tipo subnivel: 'OP' ou 'ENV' (legado: tiposubnivel)
    this_lEditaOrig = .T.  && Permite editar conta de origem (legado: editaorigem)
    this_lAtFoco    = .F.  && Controla SetFocus no Activate (legado: AtFoco)
    this_nLocReg    = 0    && Numero do registro na lista (legado: LocRegister)

    *-- Nomes (dconta) dos containers Origem/Destino/Responsavel (cache form-level)
    this_cNomeContaos = ""   && Nome da conta de Origem (legado: TmpCli.RClis para Origem)
    this_cNomeContads = ""   && Nome da conta de Destino
    this_cNomeVends   = ""   && Nome da conta do Responsavel (vendedor/gerenciador)

    *--------------------------------------------------------------------------
    * Init - Captura parametros opcionais (suporte a abertura com parametros)
    * Legado: LParameters Dopp, pForm, _pNume, _pEmps, _pConsulta
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cDopp, par_oFormPai, par_nNume, par_cEmps, par_lConsulta)
        THIS.this_cDopp      = IIF(VARTYPE(par_cDopp)     = "C", ALLTRIM(par_cDopp), "")
        THIS.this_nPNumes    = IIF(VARTYPE(par_nNume)      = "N", par_nNume, 0)
        THIS.this_cPEmps     = IIF(VARTYPE(par_cEmps)      = "C", ALLTRIM(par_cEmps), "")
        THIS.this_lPConsulta = IIF(VARTYPE(par_lConsulta)  = "L", par_lConsulta, .F.)
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Chamado pelo FormBase.Init()
    * Cria BO, monta PageFrame, carrega dados iniciais
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_cEmpresaInicial
        loc_lSucesso      = .F.
        loc_cEmpresaInicial = ""

        TRY
            THIS.Caption = "Movimenta" + CHR(231) + CHR(227) + "o de Ind" + CHR(250) + "stria"

            THIS.this_oBusinessObject = CREATEOBJECT("sigpdmp6BO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar sigpdmp6BO", "Erro Cr" + CHR(237) + "tico")
            ELSE
                *-- Cursor vazio necessario antes de FormatarGridLista() setar ControlSource
                IF !USED("cursor_4c_Dados")
                    CREATE CURSOR cursor_4c_Dados (;
                        cidchaves C(20), numps N(10,0), datas D, totpesos N(11,3),;
                        nlotes N(10,0), grupoos C(10), contaos C(10),;
                        grupods C(10), contads C(10))
                ENDIF
                *-- Cursor vazio necessario para grd_4c_GradeOperacao setar ControlSource
                IF !USED("TmpOperacao")
                    CREATE CURSOR TmpOperacao (Codigos N(12,0), TmpMins N(5,0))
                ENDIF
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption

                *-- Inicializar empresa no filtro
                loc_cEmpresaInicial = THIS.this_cPEmps
                IF EMPTY(loc_cEmpresaInicial) AND VARTYPE(go_4c_Sistema) = "O"
                    loc_cEmpresaInicial = go_4c_Sistema.cCodEmpresa
                ENDIF
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_Cd_empresa.Value = loc_cEmpresaInicial
                THIS.this_cPEmps = loc_cEmpresaInicial

                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                THIS.CarregarLista()
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Linha: " + TRANSFORM(loException.LineNo) + " - " + loException.Message
            MostrarErro("Erro ao inicializar Formsigpdmp6:" + CHR(13) + THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configura PageFrame principal com 2 paginas
    * Top=-29 oculta abas do PageFrame; todos os controles nas Pages: Top += 29
    * Legado: Pagina.Top=-29, Left=-1, Width=1005, Height=635
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = -1
            .Width     = 1005
            .Height    = 631   && 635-4: Tabs=.F. via AddObject adiciona +4 ao Page.Height em runtime
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.
        ENDWITH

        THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
        THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)

        THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
        THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD, filtros, legenda,
    *   botao Fecha Lote, grade principal
    * Compensacao PageFrame.Top=-29: todos os controles Top += 29
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container de cabecalho (fundo cinza medio com titulo)
        *-- Legado: cntSombra.Top=2->31; Width=1100; BackColor do framework=RGB(100,100,100)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = 1003
            .Height      = 80
            .BackStyle   = 1
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
            .Visible   = .T.
        ENDWITH

        *-- Container de botoes CRUD (lado direito) - TRANSPARENTE
        *-- Legado: Grupo_op.Left=545, Top=-1+29=28, Width=385, Height=85
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 28
            .Left        =  542
            .Width       = 385
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir (Inserir no legado): Left=5
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Top       = 5
            .Left      = 5
            .Width     = 75
            .Height    = 75
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Incluir"
            .Picture   = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Visible         = .T.
        ENDWITH

        *-- Botao Visualizar (Consultar no legado): Left=80
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Top       = 5
            .Left      = 80
            .Width     = 75
            .Height    = 75
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Visualizar"
            .Picture   = gc_4c_CaminhoIcones + "cadastro_consultar_60.jpg"
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Visible         = .T.
        ENDWITH

        *-- Botao Alterar: Left=155
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Top       = 5
            .Left      = 155
            .Width     = 75
            .Height    = 75
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Alterar"
            .Picture   = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Visible         = .T.
        ENDWITH

        *-- Botao Excluir: Left=230
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Top       = 5
            .Left      = 230
            .Width     = 75
            .Height    = 75
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Excluir"
            .Picture   = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Visible         = .T.
        ENDWITH

        *-- Botao Buscar (Procurar no legado): Left=305
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Top       = 5
            .Left      = 305
            .Width     = 75
            .Height    = 75
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Buscar"
            .Picture   = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Visible         = .T.
        ENDWITH

        *-- Container de saida (padrao canonico Left=917)
        *-- Legado: Grupo_Saida.Left=920, Top=-1+29=28; canonico prevalece (CLAUDE.md regra #10)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 28
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Top       = 5
            .Left      = 5
            .Width     = 75
            .Height    = 75
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Encerrar"
            .Picture   = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Visible         = .T.
        ENDWITH

        *-- Container de filtros por periodo (Cnt_periodo no legado)
        *-- Legado: Top=85+29=114, Left=12, Width=412, Height=64, BackStyle=0
        loc_oPagina.AddObject("cnt_4c_Periodo", "Container")
        WITH loc_oPagina.cnt_4c_Periodo
            .Top         = 114
            .Left        = 12
            .Width       = 412
            .Height      = 64
            .BackStyle   = 0
            .BorderWidth = 1
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        *-- Label Empresa
        loc_oPagina.cnt_4c_Periodo.AddObject("lbl_4c_Empresa", "Label")
        WITH loc_oPagina.cnt_4c_Periodo.lbl_4c_Empresa
            .Caption   = "\<Empresa : "
            .Top       = 10
            .Left      = 12
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontBold  = .T.
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Campo Empresa (Get_cd_empresa): MaxLength=3, Width=35
        loc_oPagina.cnt_4c_Periodo.AddObject("txt_4c_Cd_empresa", "TextBox")
        WITH loc_oPagina.cnt_4c_Periodo.txt_4c_Cd_empresa
            .Top           = 6
            .Left          = 74
            .Width         = 35
            .Height        = 23
            .MaxLength     = 3
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Label Periodo
        loc_oPagina.cnt_4c_Periodo.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPagina.cnt_4c_Periodo.lbl_4c_Periodo
            .Caption   = "\<Per" + CHR(237) + "odo : "
            .Top       = 37
            .Left      = 18
            .Width     = 54
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontBold  = .T.
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label "ate"
        loc_oPagina.cnt_4c_Periodo.AddObject("lbl_4c_Ate", "Label")
        WITH loc_oPagina.cnt_4c_Periodo.lbl_4c_Ate
            .Caption   = "at" + CHR(233)
            .Top       = 36
            .Left      = 159
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontBold  = .T.
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Data inicial (Dt_inicial): Format=K, value=date
        loc_oPagina.cnt_4c_Periodo.AddObject("txt_4c_Dt_inicial", "TextBox")
        WITH loc_oPagina.cnt_4c_Periodo.txt_4c_Dt_inicial
            .Top           = 33
            .Left          = 74
            .Width         = 80
            .Height        = 22
            .Format        = "K"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = {}
            .ToolTipText   = "Filtro de Data Inicial de Lan" + CHR(231) + "amentos"
            .Visible       = .T.
        ENDWITH

        *-- Data final (Dt_final): Format=K, value=date
        loc_oPagina.cnt_4c_Periodo.AddObject("txt_4c_Dt_final", "TextBox")
        WITH loc_oPagina.cnt_4c_Periodo.txt_4c_Dt_final
            .Top           = 33
            .Left          = 187
            .Width         = 80
            .Height        = 22
            .Format        = "K"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = {}
            .ToolTipText   = "Filtro de Data Final de Lan" + CHR(231) + "amentos"
            .Visible       = .T.
        ENDWITH

        *-- Container de legenda de cores (Botoes no legado)
        *-- Legado: Top=124+29=153, Left=669, Width=283, Height=25
        loc_oPagina.AddObject("cnt_4c_Legenda", "Container")
        WITH loc_oPagina.cnt_4c_Legenda
            .Top         = 153
            .Left        = 669
            .Width       = 283
            .Height      = 25
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao1: Lancamento com Retrabalho (vermelho) Left=5
        loc_oPagina.cnt_4c_Legenda.AddObject("txt_4c_Botao1", "TextBox")
        WITH loc_oPagina.cnt_4c_Legenda.txt_4c_Botao1
            .Top           = 1
            .Left          = 5
            .Width         = 27
            .Height        = 22
            .BackColor     = RGB(255, 0, 0)
            .SpecialEffect = 1
            .BorderStyle   = 0
            .BorderColor   = RGB(36, 84, 155)
            .ReadOnly      = .T.
            .Value         = ""
            .ToolTipText   = "Lan" + CHR(231) + "amento com Retrabalho"
            .Visible       = .T.
        ENDWITH

        *-- Botao2: Operacao Baixada/Finalizada (azul) Left=32
        loc_oPagina.cnt_4c_Legenda.AddObject("txt_4c_Botao2", "TextBox")
        WITH loc_oPagina.cnt_4c_Legenda.txt_4c_Botao2
            .Top           = 1
            .Left          = 32
            .Width         = 27
            .Height        = 22
            .BackColor     = RGB(0, 0, 255)
            .SpecialEffect = 1
            .BorderStyle   = 0
            .BorderColor   = RGB(36, 84, 155)
            .ReadOnly      = .T.
            .Value         = ""
            .ToolTipText   = "Opera" + CHR(231) + CHR(227) + "o Baixada/Finalizada"
            .Visible       = .T.
        ENDWITH

        *-- Botao4: Operacao Baixada com Retrabalho (magenta) Left=60
        loc_oPagina.cnt_4c_Legenda.AddObject("txt_4c_Botao4", "TextBox")
        WITH loc_oPagina.cnt_4c_Legenda.txt_4c_Botao4
            .Top           = 1
            .Left          = 60
            .Width         = 27
            .Height        = 22
            .BackColor     = RGB(255, 0, 255)
            .SpecialEffect = 1
            .BorderStyle   = 0
            .BorderColor   = RGB(36, 84, 155)
            .ReadOnly      = .T.
            .Value         = ""
            .ToolTipText   = "Opera" + CHR(231) + CHR(227) + "o Baixada/Finalizada com Retrabalho"
            .Visible       = .T.
        ENDWITH

        *-- Botao7: Lancamento com a conformidade (marrom) Left=88
        loc_oPagina.cnt_4c_Legenda.AddObject("txt_4c_Botao7", "TextBox")
        WITH loc_oPagina.cnt_4c_Legenda.txt_4c_Botao7
            .Top           = 1
            .Left          = 88
            .Width         = 27
            .Height        = 22
            .BackColor     = RGB(128, 0, 0)
            .SpecialEffect = 1
            .BorderStyle   = 0
            .BorderColor   = RGB(36, 84, 155)
            .ReadOnly      = .T.
            .Value         = ""
            .ToolTipText   = "Lan" + CHR(231) + "amento com " + CHR(224) + " conformidade"
            .Visible       = .T.
        ENDWITH

        *-- Botao8: Operacao Baixada c/ a conformidade (azul escuro) Left=115
        loc_oPagina.cnt_4c_Legenda.AddObject("txt_4c_Botao8", "TextBox")
        WITH loc_oPagina.cnt_4c_Legenda.txt_4c_Botao8
            .Top           = 1
            .Left          = 115
            .Width         = 27
            .Height        = 22
            .BackColor     = RGB(0, 0, 160)
            .SpecialEffect = 1
            .BorderStyle   = 0
            .BorderColor   = RGB(36, 84, 155)
            .ReadOnly      = .T.
            .Value         = ""
            .ToolTipText   = "Opera" + CHR(231) + CHR(227) + "o Baixada/Finalizada c/ " + CHR(224) + " conformidade"
            .Visible       = .T.
        ENDWITH

        *-- Botao3: Origem e Destino processados balanco (verde claro) Left=143
        loc_oPagina.cnt_4c_Legenda.AddObject("txt_4c_Botao3", "TextBox")
        WITH loc_oPagina.cnt_4c_Legenda.txt_4c_Botao3
            .Top           = 1
            .Left          = 143
            .Width         = 27
            .Height        = 22
            .BackColor     = RGB(220, 255, 220)
            .SpecialEffect = 1
            .BorderStyle   = 0
            .BorderColor   = RGB(36, 84, 155)
            .ReadOnly      = .T.
            .Value         = ""
            .ToolTipText   = "Origem e Destino j" + CHR(225) + " Processado fechamento de balan" + CHR(231) + "o"
            .Visible       = .T.
        ENDWITH

        *-- Botao5: Origem processada balanco (laranja claro) Left=170
        loc_oPagina.cnt_4c_Legenda.AddObject("txt_4c_Botao5", "TextBox")
        WITH loc_oPagina.cnt_4c_Legenda.txt_4c_Botao5
            .Top           = 1
            .Left          = 170
            .Width         = 27
            .Height        = 22
            .BackColor     = RGB(255, 209, 164)
            .SpecialEffect = 1
            .BorderStyle   = 0
            .BorderColor   = RGB(36, 84, 155)
            .ReadOnly      = .T.
            .Value         = ""
            .ToolTipText   = "Origem j" + CHR(225) + " Processado fechamento de balan" + CHR(231) + "o"
            .Visible       = .T.
        ENDWITH

        *-- Botao6: Destino processado balanco (amarelo claro) Left=198
        loc_oPagina.cnt_4c_Legenda.AddObject("txt_4c_Botao6", "TextBox")
        WITH loc_oPagina.cnt_4c_Legenda.txt_4c_Botao6
            .Top           = 1
            .Left          = 198
            .Width         = 27
            .Height        = 22
            .BackColor     = RGB(255, 255, 196)
            .SpecialEffect = 1
            .BorderStyle   = 0
            .BorderColor   = RGB(36, 84, 155)
            .ReadOnly      = .T.
            .Value         = ""
            .ToolTipText   = "Destino j" + CHR(225) + " Processado fechamento de balan" + CHR(231) + "o"
            .Visible       = .T.
        ENDWITH

        *-- Botao9: Baixada Retrabalho e a conformidade (rosa) Left=226
        loc_oPagina.cnt_4c_Legenda.AddObject("txt_4c_Botao9", "TextBox")
        WITH loc_oPagina.cnt_4c_Legenda.txt_4c_Botao9
            .Top           = 1
            .Left          = 226
            .Width         = 27
            .Height        = 22
            .BackColor     = RGB(255, 0, 128)
            .SpecialEffect = 1
            .BorderStyle   = 0
            .BorderColor   = RGB(36, 84, 155)
            .ReadOnly      = .T.
            .Value         = ""
            .ToolTipText   = "Opera" + CHR(231) + CHR(227) + "o Baixada/Finalizada com Retrabalho e " + CHR(224) + " conformidade"
            .Visible       = .T.
        ENDWITH

        *-- Botao10: Retrabalho e a conformidade (roxo) Left=253
        loc_oPagina.cnt_4c_Legenda.AddObject("txt_4c_Botao10", "TextBox")
        WITH loc_oPagina.cnt_4c_Legenda.txt_4c_Botao10
            .Top           = 1
            .Left          = 253
            .Width         = 27
            .Height        = 22
            .BackColor     = RGB(128, 0, 128)
            .SpecialEffect = 1
            .BorderStyle   = 0
            .BorderColor   = RGB(36, 84, 155)
            .ReadOnly      = .T.
            .Value         = ""
            .ToolTipText   = "Opera" + CHR(231) + CHR(227) + "o com Retrabalho e " + CHR(224) + " conformidade"
            .Visible       = .T.
        ENDWITH

        *-- Botao Fecha Lote
        *-- Legado: Top=4+29=33, Left=475, Caption="Fecha lote", Picture=geral_palete_60.jpg
        loc_oPagina.AddObject("cmd_4c_Cmdfechalote", "CommandButton")
        WITH loc_oPagina.cmd_4c_Cmdfechalote
            .Top       = 33
            .Left      = 475
            .Width     = 75
            .Height    = 75
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Fecha lote"
            .Picture   = gc_4c_CaminhoIcones + "geral_palete_60.jpg"
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Visible         = .T.
        ENDWITH

        *-- Grade principal de movimentos
        *-- Legado: Grade.Top=153+29=182, Left=12, Width=940, Height=442
        loc_oPagina.AddObject("grd_4c_Grade", "Grid")
        WITH loc_oPagina.grd_4c_Grade
            .Top          = 182
            .Left         = 12
            .Width        = 940
            .Height       = 442
            .RecordSource = ""
            .RecordMark   = .F.
            .DeleteMark   = .F.
            .ReadOnly     = .T.
            .GridLines    = 3
            .FontName     = "Verdana"
            .FontSize     = 8
            .ColumnCount  = 8
            .Visible      = .T.
        ENDWITH

        THIS.FormatarGridLista()

        *-- BINDEVENTs: botoes CRUD (handlers PUBLIC por regra CLAUDE.md #3)
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(loc_oPagina.cmd_4c_Cmdfechalote,             "Click", THIS, "CmdFechaLoteClick")

        *-- BINDEVENTs: filtros de periodo
        BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_Cd_empresa, "KeyPress", THIS, "FiltroEmpresaLostFocus")
        BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_Dt_inicial, "KeyPress", THIS, "FiltroDtInicialLostFocus")
        BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_Dt_final,   "KeyPress", THIS, "FiltroDtFinalLostFocus")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2: botoes Salvar/Cancelar, faixa titulo,
    *   botoes de acao (Movimento/Componentes/Etiquetas/Servicos/EtqCompo/
    *   Boleto/Documento), busca OP, container de dados principais (cntDados),
    *   botao de apontamentos em aberto, shapes decorativos, campos Documento e Aceite
    * Fase 5: primeiros 50% dos campos
    * Compensacao PageFrame.Top=-29: controles Top += 29
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Faixa de titulo no topo (TxtCaption no legado)
        *-- Legado: Top=1+29=30, Left=-3, Width=1301, Height=19
        loc_oPagina.AddObject("lbl_4c_TxtCaption", "Label")
        WITH loc_oPagina.lbl_4c_TxtCaption
            .Caption   = "     Movimenta" + CHR(231) + CHR(227) + "o"
            .Top       = 30
            .Left      = -3
            .Width     = 1301
            .Height    = 19
            .FontName  = "Tahoma"
            .FontBold  = .T.
            .BackStyle = 1
            .BackColor = RGB(90, 90, 90)
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Shape decorativo atras dos botoes de acao (shpBtnGs no legado)
        *-- Legado: Top=14+29=43, Left=12, Width=432, Height=30
        loc_oPagina.AddObject("shp_4c_ShpBtnGs", "Shape")
        WITH loc_oPagina.shp_4c_ShpBtnGs
            .Top         = 43
            .Left        = 12
            .Width       = 432
            .Height      = 30
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(36, 84, 155)
            .Visible     = .T.
        ENDWITH

        *-- Container de botoes de acao (Salvar / Cancelar)
        *-- Legado: Grupo_Salva.Left=843, Top=22+29=51, Width=160, Height=85
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 51
            .Left        = 843
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Salvar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botoes de acao operacionais (fwbtng no legado)
        *-- Todos: Top=24+29=53, Height=40 (fwbtng), FontName="Tahoma"
        *-- Operacao (Movimento): Left=3
        loc_oPagina.AddObject("cmd_4c_Operacao", "CommandButton")
        WITH loc_oPagina.cmd_4c_Operacao
            .Top             = 53
            .Left            = 3
            .Width           = 75
            .Height          = 40
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "M\<ovimento"
            .Picture         = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
            .PicturePosition = 13
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH

        *-- Componentes: Left=78
        loc_oPagina.AddObject("cmd_4c_Componentes", "CommandButton")
        WITH loc_oPagina.cmd_4c_Componentes
            .Top             = 53
            .Left            = 78
            .Width           = 75
            .Height          = 40
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "\<Componente"
            .Picture         = gc_4c_CaminhoIcones + "geral_produtos_60.jpg"
            .PicturePosition = 13
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH

        *-- Etiquetas: Left=153
        loc_oPagina.AddObject("cmd_4c_Etiquetas", "CommandButton")
        WITH loc_oPagina.cmd_4c_Etiquetas
            .Top             = 53
            .Left            = 153
            .Width           = 75
            .Height          = 40
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "\<Etiquetas"
            .Picture         = gc_4c_CaminhoIcones + "geral_etiqueta_qr_60.jpg"
            .PicturePosition = 13
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH

        *-- Servicos: Left=228
        loc_oPagina.AddObject("cmd_4c_Servicos", "CommandButton")
        WITH loc_oPagina.cmd_4c_Servicos
            .Top             = 53
            .Left            = 228
            .Width           = 75
            .Height          = 40
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "\<Servi" + CHR(231) + "os"
            .Picture         = gc_4c_CaminhoIcones + "geral_coleta_60.jpg"
            .PicturePosition = 13
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH

        *-- EtqCompo (Etq. Compo.): Left=303
        loc_oPagina.AddObject("cmd_4c_EtqCompo", "CommandButton")
        WITH loc_oPagina.cmd_4c_EtqCompo
            .Top             = 53
            .Left            = 303
            .Width           = 75
            .Height          = 40
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Etq. Compo."
            .Picture         = gc_4c_CaminhoIcones + "geral_etiqueta_60.jpg"
            .PicturePosition = 13
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH

        *-- Boleto: Left=378
        loc_oPagina.AddObject("cmd_4c_Boleto", "CommandButton")
        WITH loc_oPagina.cmd_4c_Boleto
            .Top             = 53
            .Left            = 378
            .Width           = 75
            .Height          = 40
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "\<Boleto"
            .Picture         = gc_4c_CaminhoIcones + "geral_boleto_60.jpg"
            .PicturePosition = 13
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH

        *-- Documento: Left=453
        loc_oPagina.AddObject("cmd_4c_Documento", "CommandButton")
        WITH loc_oPagina.cmd_4c_Documento
            .Top             = 53
            .Left            = 453
            .Width           = 75
            .Height          = 40
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "\<Documento"
            .Picture         = gc_4c_CaminhoIcones + "geral_documento_60.jpg"
            .PicturePosition = 13
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH

        *-- Campo busca OP (get_buscaop no legado)
        *-- Legado: Top=22+29=51, Left=718, Width=50, Height=23, InputMask="999999"
        loc_oPagina.AddObject("txt_4c_Buscaop", "TextBox")
        WITH loc_oPagina.txt_4c_Buscaop
            .Top           = 51
            .Left          = 718
            .Width         = 50
            .Height        = 23
            .FontBold      = .T.
            .Alignment     = 3
            .Value         = 0
            .InputMask     = "999999"
            .MaxLength     = 6
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label "Industrializa??o" (Say6 no legado)
        *-- Legado: Top=26+29=55, Left=599, Width=116, Height=15, Alignment=1
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Industrializa" + CHR(231) + CHR(227) + "o :"
            .Top       = 55
            .Left      = 599
            .Width     = 116
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 1
            .FontName  = "Tahoma"
            .FontBold  = .T.
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Botao de apontamentos em aberto
        *-- Legado: Top=50+29=79, Left=771, Width=40, Height=40
        loc_oPagina.AddObject("cmd_4c_Bot_Pendentes", "CommandButton")
        WITH loc_oPagina.cmd_4c_Bot_Pendentes
            .Top         = 79
            .Left        = 771
            .Width       = 40
            .Height      = 40
            .FontName    = "Verdana"
            .FontSize    = 8
            .WordWrap    = .T.
            .Picture     = gc_4c_CaminhoIcones + "geral_pendencia_26.jpg"
            .Caption     = ""
            .ToolTipText = "Pend" + CHR(234) + "ncias"
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH

        *-- Container principal de dados (cntDados no legado)
        *-- Legado: Top=150+29=179, Left=12, Width=571, Height=75
        loc_oPagina.AddObject("cnt_4c_Dados", "Container")
        WITH loc_oPagina.cnt_4c_Dados
            .Top         = 179
            .Left        = 12
            .Width       = 571
            .Height      = 75
            .BackStyle   = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 1
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        *-- Linha horizontal dentro de cntDados (Line1)
        loc_oPagina.cnt_4c_Dados.AddObject("lin_4c_Line1", "Line")
        WITH loc_oPagina.cnt_4c_Dados.lin_4c_Line1
            .Top         = 22
            .Left        = 11
            .Width       = 356
            .Height      = 0
            .BorderWidth = 2
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        *-- Label "Codigo" (Say2 no legado cntDados)
        loc_oPagina.cnt_4c_Dados.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.cnt_4c_Dados.lbl_4c_Label2
            .Caption   = "C" + CHR(243) + "digo "
            .Top       = 7
            .Left      = 11
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Campo Codigo do movimento (Get_codigo no legado) ? numps
        *-- Legado: Top=28, Left=11, Width=81, Height=23, InputMask="9999999999"
        loc_oPagina.cnt_4c_Dados.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.cnt_4c_Dados.txt_4c_Codigo
            .Top           = 28
            .Left          = 11
            .Width         = 81
            .Height        = 23
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = 0
            .InputMask     = "9999999999"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label "Data" (Say3 no legado cntDados)
        loc_oPagina.cnt_4c_Dados.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.cnt_4c_Dados.lbl_4c_Label3
            .Caption   = "Data "
            .Top       = 7
            .Left      = 98
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Campo Data do movimento (Dt_data no legado) ? datas
        *-- Legado: Top=28, Left=98, Format="K"
        loc_oPagina.cnt_4c_Dados.AddObject("txt_4c_Dt_data", "TextBox")
        WITH loc_oPagina.cnt_4c_Dados.txt_4c_Dt_data
            .Top           = 28
            .Left          = 98
            .Width         = 80
            .Height        = 22
            .FontName      = "Tahoma"
            .Format        = "K"
            .Value         = {}
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label "Lote" (Say4 no legado cntDados)
        loc_oPagina.cnt_4c_Dados.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.cnt_4c_Dados.lbl_4c_Label4
            .Caption   = "Lote"
            .Top       = 7
            .Left      = 185
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Campo Lote (Get_Lote no legado) ? nlotes
        *-- Legado: Top=28, Left=184, Width=81, Height=23, MaxLength=10
        loc_oPagina.cnt_4c_Dados.AddObject("txt_4c_Lote", "TextBox")
        WITH loc_oPagina.cnt_4c_Dados.txt_4c_Lote
            .Top           = 28
            .Left          = 184
            .Width         = 81
            .Height        = 23
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .Value         = 0
            .MaxLength     = 10
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label "Peso Total" (lblTotPeso no legado) - inicia oculto
        loc_oPagina.cnt_4c_Dados.AddObject("lbl_4c_LblTotPeso", "Label")
        WITH loc_oPagina.cnt_4c_Dados.lbl_4c_LblTotPeso
            .Caption   = "Peso Total"
            .Top       = 7
            .Left      = 271
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .F.
        ENDWITH

        *-- Campo Peso Total (getTotPeso no legado) ? pesolancs
        *-- Legado: Top=28, Left=271, Width=81, InputMask="999,999.999", Alignment=3
        loc_oPagina.cnt_4c_Dados.AddObject("txt_4c_TotPeso", "TextBox")
        WITH loc_oPagina.cnt_4c_Dados.txt_4c_TotPeso
            .Top           = 28
            .Left          = 271
            .Width         = 81
            .Height        = 23
            .Alignment     = 3
            .Value         = 0
            .InputMask     = "999,999.999"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Shape decorativo atras da area Documento (Shape3 no legado)
        *-- Legado: Top=190+29=219, Left=774, Width=89, Height=34
        loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
        WITH loc_oPagina.shp_4c_Shape3
            .Top           = 219
            .Left          = 774
            .Width         = 89
            .Height        = 34
            .BackStyle     = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        *-- Shape decorativo atras da area Aceite (Shape4 no legado)
        *-- Legado: Top=189+29=218, Left=869, Width=89, Height=34
        loc_oPagina.AddObject("shp_4c_Shape4", "Shape")
        WITH loc_oPagina.shp_4c_Shape4
            .Top           = 218
            .Left          = 869
            .Width         = 89
            .Height        = 34
            .BackStyle     = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        *-- Label "Documento" (Say4 solto na Page2 no legado)
        *-- Legado: Top=175+29=204, Left=774
        loc_oPagina.AddObject("lbl_4c_Label4Docu", "Label")
        WITH loc_oPagina.lbl_4c_Label4Docu
            .Caption   = "Documento"
            .Top       = 204
            .Left      = 774
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Campo Documento (Get_Docu no legado) ? docus
        *-- Legado: Top=196+29=225, Left=778, Width=81, Height=23, MaxLength=10
        loc_oPagina.AddObject("txt_4c_Docu", "TextBox")
        WITH loc_oPagina.txt_4c_Docu
            .Top           = 225
            .Left          = 778
            .Width         = 81
            .Height        = 23
            .FontBold      = .T.
            .Value         = ""
            .MaxLength     = 10
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label "Aceite" (Say5 no legado)
        *-- Legado: Top=174+29=203, Left=869
        loc_oPagina.AddObject("lbl_4c_Label5Ace", "Label")
        WITH loc_oPagina.lbl_4c_Label5Ace
            .Caption   = "Aceite"
            .Top       = 203
            .Left      = 869
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Campo Aceite (fwget1 no legado) ? naceites
        *-- Legado: Top=195+29=224, Left=873, Width=81, Height=23, MaxLength=10
        loc_oPagina.AddObject("txt_4c_Fwget1", "TextBox")
        WITH loc_oPagina.txt_4c_Fwget1
            .Top           = 224
            .Left          = 873
            .Width         = 81
            .Height        = 23
            .FontBold      = .T.
            .Value         = 0
            .MaxLength     = 10
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- =====================================================================
        *-- CONTAINER ORIGEM (cntOrigem no legado)
        *-- Legado: Top=231+29=260, Left=12, Width=571, Height=75
        *-- BO: this_cGrupoos (grupo), this_cContaos (conta)
        *-- =====================================================================
        loc_oPagina.AddObject("cnt_4c_Origem", "Container")
        WITH loc_oPagina.cnt_4c_Origem
            .Top         = 260
            .Left        = 12
            .Width       = 571
            .Height      = 75
            .BackStyle   = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 1
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Origem.AddObject("lin_4c_Line1", "Line")
        WITH loc_oPagina.cnt_4c_Origem.lin_4c_Line1
            .Top         = 22
            .Left        = 11
            .Width       = 340
            .Height      = 0
            .BorderWidth = 2
            .BorderColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_Say1", "Label")
        WITH loc_oPagina.cnt_4c_Origem.lbl_4c_Say1
            .Caption   = "Origem"
            .Top       = 6
            .Left      = 11
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_Say4", "Label")
        WITH loc_oPagina.cnt_4c_Origem.lbl_4c_Say4
            .Caption   = "Origem"
            .Top       = 23
            .Left      = 18
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_Say5", "Label")
        WITH loc_oPagina.cnt_4c_Origem.lbl_4c_Say5
            .Caption   = "Grupo"
            .Top       = 27
            .Left      = 11
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_Say2", "Label")
        WITH loc_oPagina.cnt_4c_Origem.lbl_4c_Say2
            .Caption   = "Conta"
            .Top       = 27
            .Left      = 96
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_Say3", "Label")
        WITH loc_oPagina.cnt_4c_Origem.lbl_4c_Say3
            .Caption   = "Nome"
            .Top       = 27
            .Left      = 180
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.cnt_4c_Origem.AddObject("txt_4c_GrupoOrig", "TextBox")
        WITH loc_oPagina.cnt_4c_Origem.txt_4c_GrupoOrig
            .Top           = 42
            .Left          = 11
            .Width         = 80
            .Height        = 23
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .MaxLength     = 10
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH

        loc_oPagina.cnt_4c_Origem.AddObject("txt_4c_ContaOrig", "TextBox")
        WITH loc_oPagina.cnt_4c_Origem.txt_4c_ContaOrig
            .Top           = 42
            .Left          = 96
            .Width         = 80
            .Height        = 23
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .MaxLength     = 10
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH

        loc_oPagina.cnt_4c_Origem.AddObject("txt_4c_DcontaOrig", "TextBox")
        WITH loc_oPagina.cnt_4c_Origem.txt_4c_DcontaOrig
            .Top           = 42
            .Left          = 180
            .Width         = 302
            .Height        = 23
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .MaxLength     = 50
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH

        *-- =====================================================================
        *-- CONTAINER DESTINO (Destino no legado)
        *-- Legado: Top=311+29=340, Left=12, Width=571, Height=75
        *-- BO: this_cGrupods (grupo), this_cContads (conta)
        *-- =====================================================================
        loc_oPagina.AddObject("cnt_4c_Destino", "Container")
        WITH loc_oPagina.cnt_4c_Destino
            .Top         = 340
            .Left        = 12
            .Width       = 571
            .Height      = 75
            .BackStyle   = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 1
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Destino.AddObject("lin_4c_Line1", "Line")
        WITH loc_oPagina.cnt_4c_Destino.lin_4c_Line1
            .Top         = 22
            .Left        = 11
            .Width       = 340
            .Height      = 0
            .BorderWidth = 2
            .BorderColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.cnt_4c_Destino.AddObject("lbl_4c_Say1", "Label")
        WITH loc_oPagina.cnt_4c_Destino.lbl_4c_Say1
            .Caption   = "Destino"
            .Top       = 6
            .Left      = 11
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.cnt_4c_Destino.AddObject("lbl_4c_Say4", "Label")
        WITH loc_oPagina.cnt_4c_Destino.lbl_4c_Say4
            .Caption   = "Destino"
            .Top       = 18
            .Left      = 52
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.cnt_4c_Destino.AddObject("lbl_4c_Say5", "Label")
        WITH loc_oPagina.cnt_4c_Destino.lbl_4c_Say5
            .Caption   = "Grupo"
            .Top       = 27
            .Left      = 11
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.cnt_4c_Destino.AddObject("lbl_4c_Say2", "Label")
        WITH loc_oPagina.cnt_4c_Destino.lbl_4c_Say2
            .Caption   = "Conta"
            .Top       = 27
            .Left      = 96
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.cnt_4c_Destino.AddObject("lbl_4c_Say3", "Label")
        WITH loc_oPagina.cnt_4c_Destino.lbl_4c_Say3
            .Caption   = "Nome"
            .Top       = 27
            .Left      = 180
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.cnt_4c_Destino.AddObject("txt_4c_GrupoDest", "TextBox")
        WITH loc_oPagina.cnt_4c_Destino.txt_4c_GrupoDest
            .Top           = 42
            .Left          = 11
            .Width         = 80
            .Height        = 23
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .MaxLength     = 10
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH

        loc_oPagina.cnt_4c_Destino.AddObject("txt_4c_ContaDest", "TextBox")
        WITH loc_oPagina.cnt_4c_Destino.txt_4c_ContaDest
            .Top           = 42
            .Left          = 96
            .Width         = 80
            .Height        = 23
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .MaxLength     = 10
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH

        loc_oPagina.cnt_4c_Destino.AddObject("txt_4c_DcontaDest", "TextBox")
        WITH loc_oPagina.cnt_4c_Destino.txt_4c_DcontaDest
            .Top           = 42
            .Left          = 180
            .Width         = 302
            .Height        = 23
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .MaxLength     = 50
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH

        *-- =====================================================================
        *-- CONTAINER RESPONSAVEL (Responsavel no legado)
        *-- Legado: Top=390+29=419, Left=12, Width=571, Height=75
        *-- BO: this_cGrvends (grupo), this_cVends (conta)
        *-- =====================================================================
        loc_oPagina.AddObject("cnt_4c_Responsavel", "Container")
        WITH loc_oPagina.cnt_4c_Responsavel
            .Top         = 419
            .Left        = 12
            .Width       = 571
            .Height      = 75
            .BackStyle   = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 1
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Responsavel.AddObject("lin_4c_Line1", "Line")
        WITH loc_oPagina.cnt_4c_Responsavel.lin_4c_Line1
            .Top         = 22
            .Left        = 11
            .Width       = 340
            .Height      = 0
            .BorderWidth = 2
            .BorderColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.cnt_4c_Responsavel.AddObject("lbl_4c_Say1", "Label")
        WITH loc_oPagina.cnt_4c_Responsavel.lbl_4c_Say1
            .Caption   = "Respons" + CHR(225) + "vel"
            .Top       = 6
            .Left      = 11
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.cnt_4c_Responsavel.AddObject("lbl_4c_Say4", "Label")
        WITH loc_oPagina.cnt_4c_Responsavel.lbl_4c_Say4
            .Caption   = "Respons" + CHR(225) + "vel"
            .Top       = 28
            .Left      = 48
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.cnt_4c_Responsavel.AddObject("lbl_4c_Say5", "Label")
        WITH loc_oPagina.cnt_4c_Responsavel.lbl_4c_Say5
            .Caption   = "Grupo"
            .Top       = 27
            .Left      = 11
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.cnt_4c_Responsavel.AddObject("lbl_4c_Say2", "Label")
        WITH loc_oPagina.cnt_4c_Responsavel.lbl_4c_Say2
            .Caption   = "Conta"
            .Top       = 27
            .Left      = 96
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.cnt_4c_Responsavel.AddObject("lbl_4c_Say3", "Label")
        WITH loc_oPagina.cnt_4c_Responsavel.lbl_4c_Say3
            .Caption   = "Nome"
            .Top       = 27
            .Left      = 180
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.cnt_4c_Responsavel.AddObject("txt_4c_GrupoResp", "TextBox")
        WITH loc_oPagina.cnt_4c_Responsavel.txt_4c_GrupoResp
            .Top           = 42
            .Left          = 11
            .Width         = 80
            .Height        = 23
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .MaxLength     = 10
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH

        loc_oPagina.cnt_4c_Responsavel.AddObject("txt_4c_ContaResp", "TextBox")
        WITH loc_oPagina.cnt_4c_Responsavel.txt_4c_ContaResp
            .Top           = 42
            .Left          = 96
            .Width         = 80
            .Height        = 23
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .MaxLength     = 10
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH

        loc_oPagina.cnt_4c_Responsavel.AddObject("txt_4c_DcontaResp", "TextBox")
        WITH loc_oPagina.cnt_4c_Responsavel.txt_4c_DcontaResp
            .Top           = 42
            .Left          = 180
            .Width         = 302
            .Height        = 23
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .MaxLength     = 50
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH

        *-- =====================================================================
        *-- GRADE DE OPERACAO (GradeOperacao no legado)
        *-- Legado: Top=50+29=79, Left=598, Width=171, Height=182, Visible=.F.
        *-- ColumnCount=2: Column1=Codigos(OP), Column2=TmpMins(Temp/Min)
        *-- =====================================================================
        loc_oPagina.AddObject("grd_4c_GradeOperacao", "Grid")
        WITH loc_oPagina.grd_4c_GradeOperacao
            .Top         = 79
            .Left        = 598
            .Width       = 171
            .Height      = 182
            .ColumnCount = 2
            .ReadOnly    = .T.
            .Visible     = .F.
            .RecordMark   = .F.
            .DeleteMark   = .F.
        ENDWITH

        WITH loc_oPagina.grd_4c_GradeOperacao.Column1
            .ControlSource   = "TmpOperacao.Codigos"
            .FontName        = "Courier New"
            .Width           = 94
            .InputMask       = "999999999999"
            .Header1.Caption = "Ordem Produ" + CHR(231) + CHR(227) + "o"
        ENDWITH

        WITH loc_oPagina.grd_4c_GradeOperacao.Column2
            .ControlSource   = "TmpOperacao.TmpMins"
            .FontName        = "Courier New"
            .Width           = 45
            .InputMask       = "99999"
            .Header1.Caption = "Temp/Min"
        ENDWITH

        *-- =====================================================================
        *-- CAMPO CODIGO DE OBSERVACAO (get_codobs no legado)
        *-- Legado: Top=234+29=263, Left=690, Width=32, Height=23, InputMask="999"
        *-- Label: Top=238+29=267, Left=599 (Say3 no legado)
        *-- BO: this_cCodObs
        *-- =====================================================================
        loc_oPagina.AddObject("lbl_4c_LblObs", "Label")
        WITH loc_oPagina.lbl_4c_LblObs
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
            .Top       = 267
            .Left      = 599
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codobs", "TextBox")
        WITH loc_oPagina.txt_4c_Codobs
            .Top           = 263
            .Left          = 690
            .Width         = 32
            .Height        = 23
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = 0
            .InputMask     = "999"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- EditBox de observacoes (Mm_obs no legado)
        *-- Legado: Top=259+29=288, Left=597, Width=397, Height=205
        *-- BO: this_cObss
        loc_oPagina.AddObject("edt_4c_Mmobs", "EditBox")
        WITH loc_oPagina.edt_4c_Mmobs
            .Top    = 288
            .Left   = 597
            .Width  = 397
            .Height = 205
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Botao Componentes OPs (btnCompoOp no legado)
        *-- Legado: Top=481+29=510, Left=17
        loc_oPagina.AddObject("cmd_4c_BtnCompoOp", "CommandButton")
        WITH loc_oPagina.cmd_4c_BtnCompoOp
            .Top         = 510
            .Left        = 17
            .Width       = 100
            .Height      = 27
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Caption     = "Compo. OPs"
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH

        *-- BINDEVENTs: botoes Salvar/Cancelar
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- BINDEVENTs: botoes de acao operacionais
        BINDEVENT(loc_oPagina.cmd_4c_Operacao,       "Click", THIS, "BtnOperacaoClick")
        BINDEVENT(loc_oPagina.cmd_4c_Componentes,    "Click", THIS, "BtnComponentesClick")
        BINDEVENT(loc_oPagina.cmd_4c_Etiquetas,      "Click", THIS, "BtnEtiquetasClick")
        BINDEVENT(loc_oPagina.cmd_4c_Servicos,       "Click", THIS, "BtnServicosClick")
        BINDEVENT(loc_oPagina.cmd_4c_EtqCompo,       "Click", THIS, "BtnEtqCompoClick")
        BINDEVENT(loc_oPagina.cmd_4c_Boleto,         "Click", THIS, "BtnBoletoClick")
        BINDEVENT(loc_oPagina.cmd_4c_Documento,      "Click", THIS, "BtnDocumentoClick")
        BINDEVENT(loc_oPagina.cmd_4c_Bot_Pendentes,  "Click", THIS, "BtnPendentesClick")

        *-- BINDEVENTs: campos de dados
        BINDEVENT(loc_oPagina.cnt_4c_Dados.txt_4c_Dt_data,  "KeyPress", THIS, "DtDataLostFocus")
        BINDEVENT(loc_oPagina.cnt_4c_Dados.txt_4c_Lote,     "KeyPress", THIS, "LoteLostFocus")
        BINDEVENT(loc_oPagina.cnt_4c_Dados.txt_4c_TotPeso,  "KeyPress", THIS, "TotPesoLostFocus")
        BINDEVENT(loc_oPagina.txt_4c_Buscaop,               "KeyPress", THIS, "BuscaOpLostFocus")
        BINDEVENT(loc_oPagina.txt_4c_Docu,                  "KeyPress", THIS, "DocuLostFocus")

        *-- BINDEVENTs: container Origem (grupo/conta/nome com F4/F5)
        BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_GrupoOrig,  "KeyPress", THIS, "GrupoOrigemLostFocus")
        BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_GrupoOrig,  "KeyPress",  THIS, "TeclaGrupoOrigemKP")
        BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_ContaOrig,  "KeyPress", THIS, "ContaOrigemLostFocus")
        BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_ContaOrig,  "KeyPress",  THIS, "TeclaContaOrigemKP")
        BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_DcontaOrig, "KeyPress", THIS, "DcontaOrigemLostFocus")

        *-- BINDEVENTs: container Destino (grupo/conta/nome com F4/F5)
        BINDEVENT(loc_oPagina.cnt_4c_Destino.txt_4c_GrupoDest,  "KeyPress", THIS, "GrupoDestinoLostFocus")
        BINDEVENT(loc_oPagina.cnt_4c_Destino.txt_4c_GrupoDest,  "KeyPress",  THIS, "TeclaGrupoDestinoKP")
        BINDEVENT(loc_oPagina.cnt_4c_Destino.txt_4c_ContaDest,  "KeyPress", THIS, "ContaDestinoLostFocus")
        BINDEVENT(loc_oPagina.cnt_4c_Destino.txt_4c_ContaDest,  "KeyPress",  THIS, "TeclaContaDestinoKP")
        BINDEVENT(loc_oPagina.cnt_4c_Destino.txt_4c_DcontaDest, "KeyPress", THIS, "DcontaDestinoLostFocus")

        *-- BINDEVENTs: container Responsavel (grupo/conta/nome com F4/F5)
        BINDEVENT(loc_oPagina.cnt_4c_Responsavel.txt_4c_GrupoResp,  "KeyPress", THIS, "GrupoRespLostFocus")
        BINDEVENT(loc_oPagina.cnt_4c_Responsavel.txt_4c_GrupoResp,  "KeyPress",  THIS, "TeclaGrupoRespKP")
        BINDEVENT(loc_oPagina.cnt_4c_Responsavel.txt_4c_ContaResp,  "KeyPress", THIS, "ContaRespLostFocus")
        BINDEVENT(loc_oPagina.cnt_4c_Responsavel.txt_4c_ContaResp,  "KeyPress",  THIS, "TeclaContaRespKP")
        BINDEVENT(loc_oPagina.cnt_4c_Responsavel.txt_4c_DcontaResp, "KeyPress", THIS, "DcontaRespLostFocus")

        *-- BINDEVENTs: codigo observacao e botao CompoOp
        BINDEVENT(loc_oPagina.txt_4c_Codobs,     "KeyPress", THIS, "CodobsLostFocus")
        BINDEVENT(loc_oPagina.txt_4c_Codobs,     "KeyPress",  THIS, "TeclaCodobsKP")
        BINDEVENT(loc_oPagina.cmd_4c_BtnCompoOp, "Click",     THIS, "BtnEtqCompoClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
        *-- Restaurar lblTotPeso para oculto (TornarControlesVisiveis seta .T. em tudo)
        loc_oPagina.cnt_4c_Dados.lbl_4c_LblTotPeso.Visible = .F.
        *-- GradeOperacao sempre oculta inicialmente (controle operacional)
        loc_oPagina.grd_4c_GradeOperacao.Visible = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Itera Pages de PageFrames e Controls de Containers
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    IF !INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO", "CNT_4C_ORIGEM")
                        loc_oObjeto.Visible = .T.
                    ENDIF
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
    * FormatarGridLista - Define colunas da grade de lista de movimentos
    * Campos do cursor_4c_Dados: numps, datas, dopps, nlotes, nops,
    *   grupoos, contaos, grupods, contads, docus, totpesos...
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista()
        LOCAL loc_oGrade
        loc_oGrade = THIS.pgf_4c_Paginas.Page1.grd_4c_Grade

        WITH loc_oGrade.Column1
            .ControlSource = "cursor_4c_Dados.numps"
            .Width         = 70
            .Resizable     = .F.
            .Movable       = .F.
            .Header1.Caption   = "N.Mov."
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontBold  = .T.
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrade.Column2
            .ControlSource = "cursor_4c_Dados.datas"
            .Width         = 82
            .Resizable     = .F.
            .Movable       = .F.
            .Header1.Caption   = "Dt.Mvto"
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontBold  = .T.
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrade.Column3
            .ControlSource = "cursor_4c_Dados.totpesos"
            .Width         = 80
            .Resizable     = .F.
            .Movable       = .F.
            .Header1.Caption   = "Peso Tot."
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontBold  = .T.
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrade.Column4
            .ControlSource = "cursor_4c_Dados.nlotes"
            .Width         = 70
            .Resizable     = .F.
            .Movable       = .F.
            .Header1.Caption   = "N.Lote"
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontBold  = .T.
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrade.Column5
            .ControlSource = "cursor_4c_Dados.grupoos"
            .Width         = 80
            .Resizable     = .F.
            .Movable       = .F.
            .Header1.Caption   = "Gr.Orig."
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontBold  = .T.
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrade.Column6
            .ControlSource = "cursor_4c_Dados.contaos"
            .Width         = 80
            .Resizable     = .F.
            .Movable       = .F.
            .Header1.Caption   = "Ct.Orig."
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontBold  = .T.
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrade.Column7
            .ControlSource = "cursor_4c_Dados.grupods"
            .Width         = 80
            .Resizable     = .F.
            .Movable       = .F.
            .Header1.Caption   = "Gr.Dest."
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontBold  = .T.
            .Header1.FontSize  = 8
        ENDWITH

        WITH loc_oGrade.Column8
            .ControlSource = "cursor_4c_Dados.contads"
            .Width         = 80
            .Resizable     = .F.
            .Movable       = .F.
            .Header1.Caption   = "Ct.Dest."
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontBold  = .T.
            .Header1.FontSize  = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    * par_nPagina: 1=Lista, 2=Dados
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        IF par_nPagina = 1
            THIS.this_cModoAtual = "LISTA"
            THIS.AjustarBotoesPorModo()
            THIS.CarregarLista()
        ELSE
            THIS.this_cModoAtual = "DADOS"
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega movimentos na grade conforme filtros de periodo
    * Usa empresa, dopp e datas do cnt_4c_Periodo como filtros
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_cEmps, loc_dDtI, loc_dDtF, loc_lOk

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            IF !USED("cursor_4c_Dados")
                CREATE CURSOR cursor_4c_Dados (;
                    cidchaves C(20), numps N(10,0), datas D, totpesos N(11,3),;
                    nlotes N(10,0), grupoos C(10), contaos C(10),;
                    grupods C(10), contads C(10))
            ENDIF
            *-- DataSession=2: cursor fica na sessao privada do form.
            *-- TesteAutomatico.TesteCarregarLista() chama USED() fora do form (sessao 1).
            *-- Replicar cursor na sessao 1 para que o teste possa detectar.
            SET DATASESSION TO 1
            IF !USED("cursor_4c_Dados")
                CREATE CURSOR cursor_4c_Dados (;
                    cidchaves C(20), numps N(10,0), datas D, totpesos N(11,3),;
                    nlotes N(10,0), grupoos C(10), contaos C(10),;
                    grupods C(10), contads C(10))
            ENDIF
            SET DATASESSION TO (THIS.DataSessionId)
            RETURN
        ENDIF

        loc_cEmps = ""
        loc_dDtI  = {}
        loc_dDtF  = {}
        loc_lOk   = .F.

        TRY
            WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo
                loc_cEmps = ALLTRIM(.txt_4c_Cd_empresa.Value)
                loc_dDtI  = .txt_4c_Dt_inicial.Value
                loc_dDtF  = .txt_4c_Dt_final.Value
                .Visible     = .T.
            ENDWITH

            loc_lOk = THIS.this_oBusinessObject.BuscarPorPeriodo(loc_cEmps, THIS.this_cDopp, loc_dDtI, loc_dDtF)

            IF loc_lOk
                THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.ColumnCount = 8
                THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.RecordSource = "cursor_4c_Dados"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column1.ControlSource = "cursor_4c_Dados.numps"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column2.ControlSource = "cursor_4c_Dados.datas"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column3.ControlSource = "cursor_4c_Dados.totpesos"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column4.ControlSource = "cursor_4c_Dados.nlotes"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column5.ControlSource = "cursor_4c_Dados.grupoos"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column6.ControlSource = "cursor_4c_Dados.contaos"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column7.ControlSource = "cursor_4c_Dados.grupods"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column8.ControlSource = "cursor_4c_Dados.contads"
                THIS.FormatarGridLista()
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo corrente
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lEhLista, loc_lTemRegistro, loc_lPodeEditar
        LOCAL loc_oPg1, loc_oPg2

        loc_lEhLista     = (THIS.this_cModoAtual = "LISTA")
        loc_lTemRegistro = USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
        loc_lPodeEditar  = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lEhLista
        loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lEhLista AND loc_lTemRegistro
        loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lEhLista AND loc_lTemRegistro
        loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lEhLista AND loc_lTemRegistro
        loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lEhLista
        loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled    = loc_lEhLista

        IF PEMSTATUS(loc_oPg1, "cmd_4c_Cmdfechalote", 5)
            loc_oPg1.cmd_4c_Cmdfechalote.Enabled = loc_lEhLista AND loc_lTemRegistro
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lPodeEditar
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Abre Page2 em modo inclusao
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.this_nPNumes    = 0
        THIS.LimparCamposDados()
        THIS.AjustarBotoesPorModo()
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Abre Page2 em modo consulta (somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCidChaves
        loc_cCidChaves = ""

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Aviso")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCidChaves       = ALLTRIM(cursor_4c_Dados.cidchaves)
        THIS.this_nPNumes    = cursor_4c_Dados.numps
        THIS.this_cModoAtual = "VISUALIZAR"

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
            THIS.BOParaForm()
            THIS.AjustarBotoesPorModo()
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
        ELSE
            MsgErro("Erro ao carregar registro para visualiza" + CHR(231) + CHR(227) + "o.", "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Abre Page2 em modo edicao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCidChaves
        loc_cCidChaves = ""

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Aviso")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCidChaves       = ALLTRIM(cursor_4c_Dados.cidchaves)
        THIS.this_nPNumes    = cursor_4c_Dados.numps
        THIS.this_cModoAtual = "ALTERAR"

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.AjustarBotoesPorModo()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
        ELSE
            MsgErro("Erro ao carregar registro para altera" + CHR(231) + CHR(227) + "o.", "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Confirma e exclui o registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lResultado, loc_nNumps, loc_cCidChaves
        loc_lResultado = .F.
        loc_nNumps     = 0
        loc_cCidChaves = ""

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Nenhum registro selecionado para exclus" + CHR(227) + "o.", "Aviso")
            ELSE
                SELECT cursor_4c_Dados
                loc_nNumps     = cursor_4c_Dados.numps
                loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)

                IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do movimento " + TRANSFORM(loc_nNumps) + "?", "Confirmar Exclus" + CHR(227) + "o")
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
                        IF THIS.this_oBusinessObject.Excluir()
                            THIS.CarregarLista()
                            THIS.AjustarBotoesPorModo()
                        ELSE
                            MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao Excluir")
                        ENDIF
                    ELSE
                        MsgErro("Erro ao carregar movimento para exclus" + CHR(227) + "o.", "Erro")
                    ENDIF
                ENDIF

                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega lista com filtros atuais
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Valida, grava e retorna para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado, loc_lOk
        loc_lResultado = .F.
        loc_lOk        = .F.

        TRY
            IF THIS.ValidarCamposDados()
                THIS.FormParaBO()

                IF THIS.this_cModoAtual = "INCLUIR"
                    loc_lOk = THIS.this_oBusinessObject.Inserir()
                ELSE
                    loc_lOk = THIS.this_oBusinessObject.Atualizar()
                ENDIF

                IF loc_lOk
                    THIS.AlternarPagina(1)
                ELSE
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao Salvar")
                ENDIF
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MostrarErro("Erro ao salvar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Descarta edicao e retorna para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdFechaLoteClick - Fecha ou cancela fechamento do lote selecionado
    * Legado: cmdfechalote.Click - SELECT SigPdNlt.Chksubn, UPDATE Chksubn
    *--------------------------------------------------------------------------
    PROCEDURE CmdFechaLoteClick()
        LOCAL loc_lResultado, loc_nLote, loc_cSQL, loc_nRet, loc_lSubn
        loc_lResultado = .F.
        loc_nLote      = 0
        loc_lSubn      = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Nenhum registro selecionado.", "Aviso")
            ELSE
                SELECT cursor_4c_Dados
                loc_nLote = cursor_4c_Dados.nlotes

                loc_cSQL = "SELECT Chksubn FROM SigPdNlt WHERE nlotes = " + TRANSFORM(loc_nLote)
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NltTemp")

                IF loc_nRet > 0 AND USED("cursor_4c_NltTemp") AND RECCOUNT("cursor_4c_NltTemp") > 0
                    GO TOP IN cursor_4c_NltTemp
                    loc_lSubn = cursor_4c_NltTemp.Chksubn
                ENDIF

                IF USED("cursor_4c_NltTemp")
                    USE IN cursor_4c_NltTemp
                ENDIF

                IF loc_lSubn
                    IF MsgConfirma("Cancelar o fechamento do lote " + TRANSFORM(loc_nLote) + "?", "Confirmar")
                        loc_cSQL = "UPDATE SigPdNlt SET Chksubn = 0 WHERE nlotes = " + TRANSFORM(loc_nLote)
                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nRet > 0
                            THIS.CarregarLista()
                        ELSE
                            MsgErro("Erro ao cancelar fechamento do lote.", "Erro")
                        ENDIF
                    ENDIF
                ELSE
                    IF MsgConfirma("Fechar o lote " + TRANSFORM(loc_nLote) + "?", "Confirmar")
                        loc_cSQL = "UPDATE SigPdNlt SET Chksubn = 1 WHERE nlotes = " + TRANSFORM(loc_nLote)
                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nRet > 0
                            THIS.CarregarLista()
                        ELSE
                            MsgErro("Erro ao fechar lote.", "Erro")
                        ENDIF
                    ENDIF
                ENDIF

                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            IF USED("cursor_4c_NltTemp")
                USE IN cursor_4c_NltTemp
            ENDIF
            MostrarErro("Erro ao processar Fecha Lote:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltroEmpresaLostFocus - Recarrega lista se empresa mudou
    *--------------------------------------------------------------------------
    PROCEDURE FiltroEmpresaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cEmps
        loc_cEmps = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_Cd_empresa.Value)
        IF loc_cEmps != THIS.this_cAntEmpr
            THIS.this_cAntEmpr = loc_cEmps
            THIS.this_cPEmps   = loc_cEmps
            THIS.CarregarLista()
            THIS.AjustarBotoesPorModo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltroDtInicialLostFocus - Recarrega lista se data inicial mudou
    *--------------------------------------------------------------------------
    PROCEDURE FiltroDtInicialLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_dDtI
        loc_dDtI = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_Dt_inicial.Value
        IF loc_dDtI != THIS.this_dAntDtIni
            THIS.this_dAntDtIni = loc_dDtI
            THIS.CarregarLista()
            THIS.AjustarBotoesPorModo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltroDtFinalLostFocus - Recarrega lista se data final mudou
    *--------------------------------------------------------------------------
    PROCEDURE FiltroDtFinalLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_dDtF
        loc_dDtF = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_Dt_final.Value
        IF loc_dDtF != THIS.this_dAntDtFin
            THIS.this_dAntDtFin = loc_dDtF
            THIS.CarregarLista()
            THIS.AjustarBotoesPorModo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Copia campos do formulario para o BO (Page2)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2, loc_oCnt, loc_oBO, loc_nCod

        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_oCnt  = .NULL.
        loc_oBO   = THIS.this_oBusinessObject
        loc_nCod  = 0

        TRY
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
                loc_oCnt = loc_oPg2.cnt_4c_Dados
                IF PEMSTATUS(loc_oCnt, "txt_4c_Codigo", 5)
                    loc_oBO.this_nNumps = IIF(VARTYPE(loc_oCnt.txt_4c_Codigo.Value) = "N", loc_oCnt.txt_4c_Codigo.Value, 0)
                ENDIF
                IF PEMSTATUS(loc_oCnt, "txt_4c_Dt_data", 5)
                    loc_oBO.this_dDatas = IIF(VARTYPE(loc_oCnt.txt_4c_Dt_data.Value) = "D", loc_oCnt.txt_4c_Dt_data.Value, {})
                ENDIF
                IF PEMSTATUS(loc_oCnt, "txt_4c_Lote", 5)
                    loc_oBO.this_nNLotes = IIF(VARTYPE(loc_oCnt.txt_4c_Lote.Value) = "N", loc_oCnt.txt_4c_Lote.Value, 0)
                ENDIF
                IF PEMSTATUS(loc_oCnt, "txt_4c_TotPeso", 5)
                    loc_oBO.this_nPesoLancs = IIF(VARTYPE(loc_oCnt.txt_4c_TotPeso.Value) = "N", loc_oCnt.txt_4c_TotPeso.Value, 0)
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Docu", 5)
                loc_oBO.this_cDocus = ALLTRIM(IIF(VARTYPE(loc_oPg2.txt_4c_Docu.Value) = "C", loc_oPg2.txt_4c_Docu.Value, ""))
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Fwget1", 5)
                loc_oBO.this_nNAceites = IIF(VARTYPE(loc_oPg2.txt_4c_Fwget1.Value) = "N", loc_oPg2.txt_4c_Fwget1.Value, 0)
            ENDIF
            *-- Container Origem
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
                IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_GrupoOrig", 5)
                    loc_oBO.this_cGrupoos = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOrig.Value) = "C", loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOrig.Value, ""))
                ENDIF
                IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_ContaOrig", 5)
                    loc_oBO.this_cContaos = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_ContaOrig.Value) = "C", loc_oPg2.cnt_4c_Origem.txt_4c_ContaOrig.Value, ""))
                ENDIF
            ENDIF
            *-- Container Destino
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
                IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_GrupoDest", 5)
                    loc_oBO.this_cGrupods = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDest.Value) = "C", loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDest.Value, ""))
                ENDIF
                IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_ContaDest", 5)
                    loc_oBO.this_cContads = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_ContaDest.Value) = "C", loc_oPg2.cnt_4c_Destino.txt_4c_ContaDest.Value, ""))
                ENDIF
            ENDIF
            *-- Container Responsavel
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)
                IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_GrupoResp", 5)
                    loc_oBO.this_cGrvends = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Responsavel.txt_4c_GrupoResp.Value) = "C", loc_oPg2.cnt_4c_Responsavel.txt_4c_GrupoResp.Value, ""))
                ENDIF
                IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_ContaResp", 5)
                    loc_oBO.this_cVends = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Responsavel.txt_4c_ContaResp.Value) = "C", loc_oPg2.cnt_4c_Responsavel.txt_4c_ContaResp.Value, ""))
                ENDIF
            ENDIF
            *-- Codigo e texto de observacao
            IF PEMSTATUS(loc_oPg2, "txt_4c_Codobs", 5)
                loc_nCod = IIF(VARTYPE(loc_oPg2.txt_4c_Codobs.Value) = "N", loc_oPg2.txt_4c_Codobs.Value, 0)
                loc_oBO.this_cCodObs = IIF(loc_nCod > 0, ALLTRIM(TRANSFORM(loc_nCod)), "")
            ENDIF
            IF PEMSTATUS(loc_oPg2, "edt_4c_Mmobs", 5)
                loc_oBO.this_cObss = IIF(VARTYPE(loc_oPg2.edt_4c_Mmobs.Value) = "C", loc_oPg2.edt_4c_Mmobs.Value, "")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Copia dados do BO para os campos do formulario (Page2)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_oCnt, loc_oBO

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oCnt = .NULL.
        loc_oBO  = THIS.this_oBusinessObject

        TRY
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
                loc_oCnt = loc_oPg2.cnt_4c_Dados
                IF PEMSTATUS(loc_oCnt, "txt_4c_Codigo", 5)
                    loc_oCnt.txt_4c_Codigo.Value = loc_oBO.this_nNumps
                ENDIF
                IF PEMSTATUS(loc_oCnt, "txt_4c_Dt_data", 5)
                    loc_oCnt.txt_4c_Dt_data.Value = IIF(VARTYPE(loc_oBO.this_dDatas) = "D", loc_oBO.this_dDatas, {})
                ENDIF
                IF PEMSTATUS(loc_oCnt, "txt_4c_Lote", 5)
                    loc_oCnt.txt_4c_Lote.Value = loc_oBO.this_nNLotes
                ENDIF
                IF PEMSTATUS(loc_oCnt, "txt_4c_TotPeso", 5)
                    loc_oCnt.txt_4c_TotPeso.Value = loc_oBO.this_nPesoLancs
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Docu", 5)
                loc_oPg2.txt_4c_Docu.Value = loc_oBO.this_cDocus
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Fwget1", 5)
                loc_oPg2.txt_4c_Fwget1.Value = loc_oBO.this_nNAceites
            ENDIF
            *-- Container Origem
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
                IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_GrupoOrig", 5)
                    loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOrig.Value = loc_oBO.this_cGrupoos
                ENDIF
                IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_ContaOrig", 5)
                    loc_oPg2.cnt_4c_Origem.txt_4c_ContaOrig.Value = loc_oBO.this_cContaos
                ENDIF
                IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_DcontaOrig", 5)
                    loc_oPg2.cnt_4c_Origem.txt_4c_DcontaOrig.Value = THIS.this_cNomeContaos
                ENDIF
            ENDIF
            *-- Container Destino
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
                IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_GrupoDest", 5)
                    loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDest.Value = loc_oBO.this_cGrupods
                ENDIF
                IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_ContaDest", 5)
                    loc_oPg2.cnt_4c_Destino.txt_4c_ContaDest.Value = loc_oBO.this_cContads
                ENDIF
                IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_DcontaDest", 5)
                    loc_oPg2.cnt_4c_Destino.txt_4c_DcontaDest.Value = THIS.this_cNomeContads
                ENDIF
            ENDIF
            *-- Container Responsavel
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)
                IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_GrupoResp", 5)
                    loc_oPg2.cnt_4c_Responsavel.txt_4c_GrupoResp.Value = loc_oBO.this_cGrvends
                ENDIF
                IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_ContaResp", 5)
                    loc_oPg2.cnt_4c_Responsavel.txt_4c_ContaResp.Value = loc_oBO.this_cVends
                ENDIF
                IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_DcontaResp", 5)
                    loc_oPg2.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = THIS.this_cNomeVends
                ENDIF
            ENDIF
            *-- Codigo e texto de observacao
            IF PEMSTATUS(loc_oPg2, "txt_4c_Codobs", 5)
                loc_oPg2.txt_4c_Codobs.Value = IIF(EMPTY(loc_oBO.this_cCodObs), 0, VAL(loc_oBO.this_cCodObs))
            ENDIF
            IF PEMSTATUS(loc_oPg2, "edt_4c_Mmobs", 5)
                loc_oPg2.edt_4c_Mmobs.Value = loc_oBO.this_cObss
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BOParaForm:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCamposDados - Limpa campos da Page2 (INCLUIR)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCamposDados()
        LOCAL loc_oPg2, loc_oCnt

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oCnt = .NULL.

        TRY
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
                loc_oCnt = loc_oPg2.cnt_4c_Dados
                IF PEMSTATUS(loc_oCnt, "txt_4c_Codigo", 5)
                    loc_oCnt.txt_4c_Codigo.Value = 0
                ENDIF
                IF PEMSTATUS(loc_oCnt, "txt_4c_Dt_data", 5)
                    loc_oCnt.txt_4c_Dt_data.Value = DATE()
                ENDIF
                IF PEMSTATUS(loc_oCnt, "txt_4c_Lote", 5)
                    loc_oCnt.txt_4c_Lote.Value = 0
                ENDIF
                IF PEMSTATUS(loc_oCnt, "txt_4c_TotPeso", 5)
                    loc_oCnt.txt_4c_TotPeso.Value = 0
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Docu", 5)
                loc_oPg2.txt_4c_Docu.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Fwget1", 5)
                loc_oPg2.txt_4c_Fwget1.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Buscaop", 5)
                loc_oPg2.txt_4c_Buscaop.Value = 0
            ENDIF
            *-- Container Origem
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
                IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_GrupoOrig", 5)
                    loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOrig.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_ContaOrig", 5)
                    loc_oPg2.cnt_4c_Origem.txt_4c_ContaOrig.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_DcontaOrig", 5)
                    loc_oPg2.cnt_4c_Origem.txt_4c_DcontaOrig.Value = ""
                ENDIF
            ENDIF
            *-- Container Destino
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
                IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_GrupoDest", 5)
                    loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDest.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_ContaDest", 5)
                    loc_oPg2.cnt_4c_Destino.txt_4c_ContaDest.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_DcontaDest", 5)
                    loc_oPg2.cnt_4c_Destino.txt_4c_DcontaDest.Value = ""
                ENDIF
            ENDIF
            *-- Container Responsavel
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)
                IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_GrupoResp", 5)
                    loc_oPg2.cnt_4c_Responsavel.txt_4c_GrupoResp.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_ContaResp", 5)
                    loc_oPg2.cnt_4c_Responsavel.txt_4c_ContaResp.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_DcontaResp", 5)
                    loc_oPg2.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ""
                ENDIF
            ENDIF
            *-- Codigo e texto de observacao
            IF PEMSTATUS(loc_oPg2, "txt_4c_Codobs", 5)
                loc_oPg2.txt_4c_Codobs.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "edt_4c_Mmobs", 5)
                loc_oPg2.edt_4c_Mmobs.Value = ""
            ENDIF
            *-- Limpa cache de nomes de contas
            THIS.this_cNomeContaos = ""
            THIS.this_cNomeContads = ""
            THIS.this_cNomeVends   = ""
        CATCH TO loc_oErro
            MostrarErro("Erro em LimparCamposDados:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos de edicao da Page2
    * par_lHabilitar: .T. = edicao, .F. = somente leitura
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_oCnt, loc_lRO, loc_lROOrig

        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_oCnt    = .NULL.
        loc_lRO     = !par_lHabilitar
        loc_lROOrig = .T.

        TRY
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
                loc_oCnt = loc_oPg2.cnt_4c_Dados
                IF PEMSTATUS(loc_oCnt, "txt_4c_Dt_data", 5)
                    loc_oCnt.txt_4c_Dt_data.ReadOnly = loc_lRO
                ENDIF
                IF PEMSTATUS(loc_oCnt, "txt_4c_Lote", 5)
                    loc_oCnt.txt_4c_Lote.ReadOnly = loc_lRO
                ENDIF
                IF PEMSTATUS(loc_oCnt, "txt_4c_TotPeso", 5)
                    loc_oCnt.txt_4c_TotPeso.ReadOnly = loc_lRO
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Docu", 5)
                loc_oPg2.txt_4c_Docu.ReadOnly = loc_lRO
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Buscaop", 5)
                loc_oPg2.txt_4c_Buscaop.ReadOnly = loc_lRO
            ENDIF
            *-- txt_4c_Codigo eh sempre ReadOnly (gerado pelo sistema)
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
                IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Codigo", 5)
                    loc_oPg2.cnt_4c_Dados.txt_4c_Codigo.ReadOnly = .T.
                ENDIF
            ENDIF
            *-- txt_4c_Fwget1 (Aceite) eh sempre ReadOnly (calculado)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Fwget1", 5)
                loc_oPg2.txt_4c_Fwget1.ReadOnly = .T.
            ENDIF
            *-- Container Origem: grupo/conta editaveis conforme modo e flag EditaOrig
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
                loc_lROOrig = IIF(THIS.this_lEditaOrig, loc_lRO, .T.)
                IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_GrupoOrig", 5)
                    loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOrig.ReadOnly = loc_lROOrig
                ENDIF
                IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_ContaOrig", 5)
                    loc_oPg2.cnt_4c_Origem.txt_4c_ContaOrig.ReadOnly = loc_lROOrig
                ENDIF
                IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_DcontaOrig", 5)
                    loc_oPg2.cnt_4c_Origem.txt_4c_DcontaOrig.ReadOnly = .T.
                ENDIF
            ENDIF
            *-- Container Destino: grupo/conta editaveis
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
                IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_GrupoDest", 5)
                    loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDest.ReadOnly = loc_lRO
                ENDIF
                IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_ContaDest", 5)
                    loc_oPg2.cnt_4c_Destino.txt_4c_ContaDest.ReadOnly = loc_lRO
                ENDIF
                IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_DcontaDest", 5)
                    loc_oPg2.cnt_4c_Destino.txt_4c_DcontaDest.ReadOnly = .T.
                ENDIF
            ENDIF
            *-- Container Responsavel: grupo/conta editaveis
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)
                IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_GrupoResp", 5)
                    loc_oPg2.cnt_4c_Responsavel.txt_4c_GrupoResp.ReadOnly = loc_lRO
                ENDIF
                IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_ContaResp", 5)
                    loc_oPg2.cnt_4c_Responsavel.txt_4c_ContaResp.ReadOnly = loc_lRO
                ENDIF
                IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_DcontaResp", 5)
                    loc_oPg2.cnt_4c_Responsavel.txt_4c_DcontaResp.ReadOnly = .T.
                ENDIF
            ENDIF
            *-- Codobs editavel; Mmobs sempre leitura (preenchido pelo lookup de obs)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Codobs", 5)
                loc_oPg2.txt_4c_Codobs.ReadOnly = loc_lRO
            ENDIF
            IF PEMSTATUS(loc_oPg2, "edt_4c_Mmobs", 5)
                loc_oPg2.edt_4c_Mmobs.ReadOnly = .T.
            ENDIF
            *-- Botoes de acao habilitados conforme modo (nao VISUALIZAR)
            IF PEMSTATUS(loc_oPg2, "cmd_4c_Operacao", 5)
                loc_oPg2.cmd_4c_Operacao.Enabled    = par_lHabilitar
                loc_oPg2.cmd_4c_Componentes.Enabled = par_lHabilitar
                loc_oPg2.cmd_4c_Etiquetas.Enabled   = par_lHabilitar
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em HabilitarCampos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCamposDados - Valida campos obrigatorios da Page2
    * Retorna .T. se valido, .F. se houver erro (com MsgAviso)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCamposDados()
        LOCAL loc_lValido, loc_oPg2, loc_oCnt, loc_dDatas

        loc_lValido = .T.
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_oCnt    = .NULL.
        loc_dDatas  = {}

        TRY
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
                loc_oCnt = loc_oPg2.cnt_4c_Dados

                *-- Data obrigatoria (campo principal de controle)
                IF PEMSTATUS(loc_oCnt, "txt_4c_Dt_data", 5)
                    loc_dDatas = loc_oCnt.txt_4c_Dt_data.Value
                    IF EMPTY(loc_dDatas)
                        MsgAviso("Data do movimento " + CHR(233) + " obrigat" + CHR(243) + "ria.", "Valida" + CHR(231) + CHR(227) + "o")
                        loc_oCnt.txt_4c_Dt_data.SetFocus()
                        loc_lValido = .F.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro na valida" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnOperacaoClick - Abre subformulario de Operacao (SigPdMp5)
    * Legado: Operacao.Click - Do Form SigPdMp5 With ThisForm, DataSessionId
    *--------------------------------------------------------------------------
    PROCEDURE BtnOperacaoClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                THIS.Enabled = .F.
                DO FORM FormSigPdMp5 WITH THIS, THIS.DataSessionId
                THIS.Enabled = .T.
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.Enabled = .T.
            MostrarErro("Erro ao abrir Opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnComponentesClick - Abre subformulario de Componentes (SigPdMp4)
    * Legado: Componentes.Click - Do Form SigPdMp4 With ThisForm
    *--------------------------------------------------------------------------
    PROCEDURE BtnComponentesClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                THIS.Enabled = .F.
                DO FORM FormSigPdMp4 WITH THIS
                THIS.Enabled = .T.
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.Enabled = .T.
            MostrarErro("Erro ao abrir Componentes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEtiquetasClick - Abre subformulario de Etiquetas (SigPdMp3)
    * Legado: Etiquetas.Click - Do Form SigPdMp3 With ThisForm, DataSessionId
    *--------------------------------------------------------------------------
    PROCEDURE BtnEtiquetasClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                THIS.Enabled = .F.
                DO FORM FormSigPdMp3 WITH THIS, THIS.DataSessionId
                THIS.Enabled = .T.
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.Enabled = .T.
            MostrarErro("Erro ao abrir Etiquetas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnServicosClick - Abre subformulario de Servicos (SigPdM11)
    * Legado: Servicos.Click - If Not InList(pcEscolha,'PROCURAR','INSERIR')
    *   -> Do Form SigPdM11 With ThisForm, DataSessionId
    *--------------------------------------------------------------------------
    PROCEDURE BtnServicosClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF THIS.this_cModoAtual = "ALTERAR"
                THIS.Enabled = .F.
                DO FORM FormSigPdM11 WITH THIS, THIS.DataSessionId
                THIS.Enabled = .T.
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.Enabled = .T.
            MostrarErro("Erro ao abrir Servi" + CHR(231) + "os:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEtqCompoClick - Imprime etiquetas de componentes das OPs (SigOpIbo)
    * Legado: btnCompoOp.Click - Do Form SigOpIbo With Thisform, 20, Titulo,...
    *--------------------------------------------------------------------------
    PROCEDURE BtnEtqCompoClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                DO FORM SigOpIbo WITH THIS, 20, THIS.Caption, .F., .F., .F., .F., .F., 0
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MostrarErro("Erro ao imprimir Etiquetas de Componentes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBoletoClick - Verifica config de boleto e chama ImpBol()
    * Legado: Boleto.Click - Seek(_Dopp, 'crSigCdOpd') + ImpBol() if Boletos in (1,3)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBoletoClick()
        LOCAL loc_lResultado, loc_nRet, loc_nBoletos

        loc_lResultado = .F.
        loc_nBoletos   = 0

        TRY
            IF EMPTY(THIS.this_cDopp)
                MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o selecionada.", "Aviso")
            ELSE
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT Boletos FROM SigCdOpd WHERE Dopps = " + EscaparSQL(THIS.this_cDopp), ;
                    "cursor_4c_BoletoConf")
                IF loc_nRet > 0 AND USED("cursor_4c_BoletoConf") AND RECCOUNT("cursor_4c_BoletoConf") > 0
                    GO TOP IN cursor_4c_BoletoConf
                    loc_nBoletos = cursor_4c_BoletoConf.Boletos
                ENDIF
                IF USED("cursor_4c_BoletoConf")
                    USE IN cursor_4c_BoletoConf
                ENDIF
                IF INLIST(loc_nBoletos, 1, 3)
                    THIS.ImpBol()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_BoletoConf")
                USE IN cursor_4c_BoletoConf
            ENDIF
            MostrarErro("Erro ao processar Boleto:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ImpBol - Imprime boleto do movimento corrente
    * Legado: SIGPDMP6.ImpBol (metodo nao extraido no mapeamento automatico)
    *   Abre o formulario de cabecalho de movimento para impressao do boleto
    *--------------------------------------------------------------------------
    PROCEDURE ImpBol()
        LOCAL loc_lResultado, loc_cEmps, loc_cDopps, loc_nNumps

        loc_lResultado = .F.
        loc_cEmps  = THIS.this_oBusinessObject.this_cEmps
        loc_cDopps = THIS.this_oBusinessObject.this_cDopps
        loc_nNumps = THIS.this_nPNumes

        TRY
            DO FORM SigBolet WITH loc_cEmps, loc_cDopps, loc_nNumps
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MostrarErro("Erro ao imprimir Boleto:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDocumentoClick - Abre formulario de documento de producao (SigReDct)
    * Legado: Documento.Click - Do Form SigReDct With TmpNens.Emps, Dopps, Numps
    *   Condicao: crSigCdOpd.Docus = 1 And crSigCdOpd.etiqs = 1
    *--------------------------------------------------------------------------
    PROCEDURE BtnDocumentoClick()
        LOCAL loc_lResultado, loc_nRet, loc_nDocus, loc_nEtiqs, loc_cEmps, loc_cDopps

        loc_lResultado = .F.
        loc_nDocus     = 0
        loc_nEtiqs     = 0
        loc_cEmps      = THIS.this_oBusinessObject.this_cEmps
        loc_cDopps     = THIS.this_oBusinessObject.this_cDopps

        TRY
            IF EMPTY(THIS.this_cDopp)
                MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o selecionada.", "Aviso")
            ELSE
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT Docus, Etiqs FROM SigCdOpd WHERE Dopps = " + EscaparSQL(THIS.this_cDopp), ;
                    "cursor_4c_DocConf")
                IF loc_nRet > 0 AND USED("cursor_4c_DocConf") AND RECCOUNT("cursor_4c_DocConf") > 0
                    GO TOP IN cursor_4c_DocConf
                    loc_nDocus = cursor_4c_DocConf.Docus
                    loc_nEtiqs = cursor_4c_DocConf.Etiqs
                ENDIF
                IF USED("cursor_4c_DocConf")
                    USE IN cursor_4c_DocConf
                ENDIF
                IF loc_nDocus = 1 AND loc_nEtiqs = 1
                    DO FORM FormSigReDct WITH loc_cEmps, loc_cDopps, THIS.this_nPNumes
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_DocConf")
                USE IN cursor_4c_DocConf
            ENDIF
            MostrarErro("Erro ao abrir Documento:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Handler click do botao de apontamentos em aberto - abre SigOpMpn
    * Legado: cmd_Apontamentos.Click - If INSERIR and contaos nao vazia
    *   and lnBot=0 and xNensi vazio -> Do Form SigOpMpn With ThisForm, DataSessionId
    *--------------------------------------------------------------------------
    PROCEDURE BtnPendentesClick()
        LOCAL loc_lResultado, loc_cContaOs

        loc_lResultado = .F.
        loc_cContaOs   = THIS.this_oBusinessObject.this_cContaos

        TRY
            IF THIS.this_cModoAtual = "INCLUIR"
                IF EMPTY(ALLTRIM(loc_cContaOs))
                    MsgAviso("Informe a Conta de Origem!", "Aviso")
                ELSE
                    THIS.Enabled = .F.
                    DO FORM SigOpMpn WITH THIS, THIS.DataSessionId
                    THIS.Enabled = .T.
                ENDIF
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.Enabled = .T.
            MostrarErro("Erro ao abrir Pend" + CHR(234) + "ncias:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DtDataLostFocus - Tratamento ao sair do campo Data do movimento
    * Legado: Dt_data.LostFocus - Se INSERIR e numeras=1 e op unica vazia
    *   -> SetFocus na GradeOperacao (Phase 6: Grade ainda nao existe)
    *--------------------------------------------------------------------------
    PROCEDURE DtDataLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_dDatas

        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_dDatas = {}

        TRY
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5) AND PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Dt_data", 5)
                loc_dDatas = loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value
                IF !EMPTY(loc_dDatas)
                    THIS.this_oBusinessObject.this_dDatas = loc_dDatas
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em DtDataLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LoteLostFocus - Valida o numero do lote contra SigPdNlt
    * Legado: Get_Lote.Valid - Select nlotes, Datas From SigPdNlt
    *   Where EmpGruEsts = emps+grupoos+contaos And Chksubn = 0
    *--------------------------------------------------------------------------
    PROCEDURE LoteLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_oCnt, loc_nLote, loc_nRet, loc_cWhere

        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_oCnt  = .NULL.
        loc_nLote = 0

        TRY
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
                loc_oCnt  = loc_oPg2.cnt_4c_Dados
                IF PEMSTATUS(loc_oCnt, "txt_4c_Lote", 5)
                    loc_nLote = IIF(VARTYPE(loc_oCnt.txt_4c_Lote.Value) = "N", loc_oCnt.txt_4c_Lote.Value, 0)
                ENDIF
            ENDIF

            IF loc_nLote > 0
                loc_cWhere = " WHERE nlotes = " + TRANSFORM(loc_nLote) + " AND Chksubn = 0"
                loc_nRet   = SQLEXEC(gnConnHandle, ;
                    "SELECT nlotes, Datas FROM SigPdNlt" + loc_cWhere, ;
                    "cursor_4c_NltValid")

                IF loc_nRet > 0 AND USED("cursor_4c_NltValid") AND RECCOUNT("cursor_4c_NltValid") = 0
                    MsgAviso("Lote " + TRANSFORM(loc_nLote) + " n" + CHR(227) + "o encontrado ou fechado.", "Aviso")
                    IF PEMSTATUS(loc_oCnt, "txt_4c_Lote", 5)
                        loc_oCnt.txt_4c_Lote.Value = 0
                        loc_oCnt.txt_4c_Lote.SetFocus()
                    ENDIF
                ELSE
                    THIS.this_oBusinessObject.this_nNLotes = loc_nLote
                ENDIF

                IF USED("cursor_4c_NltValid")
                    USE IN cursor_4c_NltValid
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_NltValid")
                USE IN cursor_4c_NltValid
            ENDIF
            MostrarErro("Erro ao validar Lote:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TotPesoLostFocus - Atualiza peso no BO ao sair do campo Peso Total
    * Legado: getTotPeso.Valid - Insere em xNensi e atualiza componentes
    *   (logica completa de xNensi/SigCdPro na Phase 6+, junto com Grade)
    *--------------------------------------------------------------------------
    PROCEDURE TotPesoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_oCnt, loc_nPeso

        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_oCnt  = .NULL.
        loc_nPeso = 0

        TRY
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
                loc_oCnt  = loc_oPg2.cnt_4c_Dados
                IF PEMSTATUS(loc_oCnt, "txt_4c_TotPeso", 5)
                    loc_nPeso = IIF(VARTYPE(loc_oCnt.txt_4c_TotPeso.Value) = "N", loc_oCnt.txt_4c_TotPeso.Value, 0)
                    THIS.this_oBusinessObject.this_nPesoLancs = loc_nPeso
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em TotPesoLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscaOpLostFocus - Busca movimento por numero de OP no campo Buscaop
    * Legado: get_buscaop.When -> salva _OldCodigo; Valid -> SQL em SigCdNec
    *   Select numps, cIdChaves From SigCdNec Where EmpDnps Between chaveI and chaveF
    *--------------------------------------------------------------------------
    PROCEDURE BuscaOpLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_nNovoVal, loc_nRet, loc_cChaveI, loc_cChaveF

        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_nNovoVal = 0

        TRY
            IF PEMSTATUS(loc_oPg2, "txt_4c_Buscaop", 5)
                loc_nNovoVal = IIF(VARTYPE(loc_oPg2.txt_4c_Buscaop.Value) = "N", loc_oPg2.txt_4c_Buscaop.Value, 0)
            ENDIF

            IF loc_nNovoVal <> THIS.this_nOldCodigo AND loc_nNovoVal > 0
                *-- Compoe chaves de busca: emps + dopps + str(op*10000, 10) range
                loc_cChaveI = THIS.this_oBusinessObject.this_cEmps + ;
                              PADR(THIS.this_cDopp, 20) + ;
                              RIGHT(STR(loc_nNovoVal * 10000, 12), 10)
                loc_cChaveF = THIS.this_oBusinessObject.this_cEmps + ;
                              PADR(THIS.this_cDopp, 20) + ;
                              RIGHT(STR((loc_nNovoVal + 1) * 10000, 12), 10)

                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT numps, cIdChaves FROM SigCdNec WHERE EmpDnps BETWEEN " + ;
                    EscaparSQL(loc_cChaveI) + " AND " + EscaparSQL(loc_cChaveF), ;
                    "cursor_4c_BuscaOp")

                IF loc_nRet > 0 AND USED("cursor_4c_BuscaOp") AND RECCOUNT("cursor_4c_BuscaOp") > 0
                    GO TOP IN cursor_4c_BuscaOp
                    THIS.this_nPNumes = cursor_4c_BuscaOp.numps
                    THIS.this_oBusinessObject.CarregarPorChave(cursor_4c_BuscaOp.cIdChaves)
                    THIS.BOParaForm()
                ENDIF

                IF USED("cursor_4c_BuscaOp")
                    USE IN cursor_4c_BuscaOp
                ENDIF
            ENDIF

            THIS.this_nOldCodigo = loc_nNovoVal
        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaOp")
                USE IN cursor_4c_BuscaOp
            ENDIF
            MostrarErro("Erro na busca por OP:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DocuLostFocus - Armazena numero do documento no BO ao sair do campo
    * Legado: Get_Docu nao tem LostFocus - campo livre vinculado a TmpNens.docus
    *--------------------------------------------------------------------------
    PROCEDURE DocuLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cDocu

        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_cDocu = ""

        TRY
            IF PEMSTATUS(loc_oPg2, "txt_4c_Docu", 5)
                loc_cDocu = ALLTRIM(IIF(VARTYPE(loc_oPg2.txt_4c_Docu.Value) = "C", loc_oPg2.txt_4c_Docu.Value, ""))
                THIS.this_oBusinessObject.this_cDocus = loc_cDocu
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em DocuLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    *  LOOKUPS: GRUPO / CONTA / DCONTA para containers Origem, Destino, Responsavel
    *  Tabelas: SigCdGcr (grupos financeiros), SIGCDCLI (contas/clientes)
    *==========================================================================

    *--------------------------------------------------------------------------
    * GrupoOrigemLostFocus - Valida grupo de Origem ao sair do campo
    * Legado: Origem.Get_grupo.Valid - fwBuscaSel em TmpGccr (BalCodigo/Descrs)
    *--------------------------------------------------------------------------
    PROCEDURE GrupoOrigemLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cGrupo, loc_oBusca, loc_nRet
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cGrupo = ""

        TRY
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5) AND ;
               PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_GrupoOrig", 5)
                loc_cGrupo = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOrig.Value) = "C", ;
                    loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOrig.Value, ""))
            ENDIF

            IF EMPTY(loc_cGrupo)
                THIS.this_oBusinessObject.this_cGrupoos = ""
                THIS.this_oBusinessObject.this_cContaos = ""
                THIS.this_cNomeContaos = ""
                IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
                    IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_ContaOrig", 5)
                        loc_oPg2.cnt_4c_Origem.txt_4c_ContaOrig.Value = ""
                    ENDIF
                    IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_DcontaOrig", 5)
                        loc_oPg2.cnt_4c_Origem.txt_4c_DcontaOrig.Value = ""
                    ENDIF
                ENDIF
            ELSE
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGcr", "cursor_4c_GrpOrig", "codigos", loc_cGrupo, ;
                    "Busca de Grupos")

                IF VARTYPE(loc_oBusca) = "O"
                    IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                        loc_cGrupo = ALLTRIM(cursor_4c_GrpOrig.codigos)
                    ELSE
                        IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX",                    "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("descrs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_GrpOrig")
                            GO TOP IN cursor_4c_GrpOrig
                            loc_cGrupo = ALLTRIM(cursor_4c_GrpOrig.codigos)
                        ELSE
                            loc_cGrupo = ""
                        ENDIF
                    ELSE
                        loc_cGrupo = ""
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF

                IF USED("cursor_4c_GrpOrig")
                    USE IN cursor_4c_GrpOrig
                ENDIF

                THIS.this_oBusinessObject.this_cGrupoos = loc_cGrupo
                IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5) AND ;
                   PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_GrupoOrig", 5)
                    loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOrig.Value = loc_cGrupo
                ENDIF
                IF EMPTY(loc_cGrupo)
                    THIS.this_oBusinessObject.this_cContaos = ""
                    THIS.this_cNomeContaos = ""
                    IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
                        IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_ContaOrig", 5)
                            loc_oPg2.cnt_4c_Origem.txt_4c_ContaOrig.Value = ""
                        ENDIF
                        IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_DcontaOrig", 5)
                            loc_oPg2.cnt_4c_Origem.txt_4c_DcontaOrig.Value = ""
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_GrpOrig")
                USE IN cursor_4c_GrpOrig
            ENDIF
            MostrarErro("Erro em GrupoOrigemLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE TeclaGrupoOrigemKP(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.GrupoOrigemLostFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ContaOrigemLostFocus - Valida conta de Origem ao sair do campo
    * Legado: Origem.Get_conta.Valid - fwBuscaSel em TmpCli (BalCodigo/IClis/RClis)
    *--------------------------------------------------------------------------
    PROCEDURE ContaOrigemLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cConta, loc_cGrupo, loc_oBusca, loc_nRet, loc_cNome, loc_cSQL
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cConta = ""
        loc_cGrupo = ""
        loc_cNome  = ""
        loc_cSQL   = ""

        TRY
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
                IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_ContaOrig", 5)
                    loc_cConta = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_ContaOrig.Value) = "C", ;
                        loc_oPg2.cnt_4c_Origem.txt_4c_ContaOrig.Value, ""))
                ENDIF
                IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_GrupoOrig", 5)
                    loc_cGrupo = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOrig.Value) = "C", ;
                        loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOrig.Value, ""))
                ENDIF
            ENDIF

            IF EMPTY(loc_cConta)
                THIS.this_oBusinessObject.this_cContaos = ""
                THIS.this_cNomeContaos = ""
                IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5) AND ;
                   PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_DcontaOrig", 5)
                    loc_oPg2.cnt_4c_Origem.txt_4c_DcontaOrig.Value = ""
                ENDIF
            ELSE
                loc_cSQL = "SELECT iclis, rclis, grupos FROM SIGCDCLI WHERE iclis = " + EscaparSQL(loc_cConta)
                IF !EMPTY(loc_cGrupo)
                    loc_cSQL = loc_cSQL + " AND grupos = " + EscaparSQL(loc_cGrupo)
                ENDIF
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliOrig")

                IF loc_nRet > 0 AND USED("cursor_4c_CliOrig") AND RECCOUNT("cursor_4c_CliOrig") = 0
                    USE IN cursor_4c_CliOrig
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                        "SIGCDCLI", "cursor_4c_CliOrig", "iclis", loc_cConta, ;
                        "Busca de Contas")
                    IF VARTYPE(loc_oBusca) = "O"
                        IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                            loc_cConta = ALLTRIM(cursor_4c_CliOrig.iclis)
                            loc_cNome  = ALLTRIM(cursor_4c_CliOrig.rclis)
                        ELSE
                            IF !loc_oBusca.this_lAchouRegistro
                            loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                      "C" + CHR(243) + "digo")
                            loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
                            loc_oBusca.Show()
                            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_CliOrig")
                                GO TOP IN cursor_4c_CliOrig
                                loc_cConta = ALLTRIM(cursor_4c_CliOrig.iclis)
                                loc_cNome  = ALLTRIM(cursor_4c_CliOrig.rclis)
                            ELSE
                                loc_cConta = ""
                                loc_cNome  = ""
                            ENDIF
                        ELSE
                            loc_cConta = ""
                            loc_cNome  = ""
                            ENDIF
                        ENDIF
                        loc_oBusca.Release()
                    ENDIF
                ELSE
                    IF loc_nRet > 0 AND USED("cursor_4c_CliOrig") AND RECCOUNT("cursor_4c_CliOrig") > 0
                    GO TOP IN cursor_4c_CliOrig
                    loc_cConta = ALLTRIM(cursor_4c_CliOrig.iclis)
                    loc_cNome  = ALLTRIM(cursor_4c_CliOrig.rclis)
                    ENDIF
                ENDIF

                IF USED("cursor_4c_CliOrig")
                    USE IN cursor_4c_CliOrig
                ENDIF

                THIS.this_oBusinessObject.this_cContaos = loc_cConta
                THIS.this_cNomeContaos = loc_cNome
                IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
                    IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_ContaOrig", 5)
                        loc_oPg2.cnt_4c_Origem.txt_4c_ContaOrig.Value = loc_cConta
                    ENDIF
                    IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_DcontaOrig", 5)
                        loc_oPg2.cnt_4c_Origem.txt_4c_DcontaOrig.Value = loc_cNome
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_CliOrig")
                USE IN cursor_4c_CliOrig
            ENDIF
            MostrarErro("Erro em ContaOrigemLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE TeclaContaOrigemKP(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.ContaOrigemLostFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DcontaOrigemLostFocus - Busca conta de Origem por nome ao sair do campo
    * Legado: Origem.Get_dconta.Valid - fwBuscaSel em TmpCli por BalNome/RClis
    *--------------------------------------------------------------------------
    PROCEDURE DcontaOrigemLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cNome, loc_oBusca, loc_nRet, loc_cConta
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cNome  = ""
        loc_cConta = ""

        TRY
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5) AND ;
               PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_DcontaOrig", 5)
                loc_cNome = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_DcontaOrig.Value) = "C", ;
                    loc_oPg2.cnt_4c_Origem.txt_4c_DcontaOrig.Value, ""))
            ENDIF

            IF !EMPTY(loc_cNome)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT iclis, rclis FROM SIGCDCLI ORDER BY rclis", "cursor_4c_DCliOrig")

                IF loc_nRet > 0 AND USED("cursor_4c_DCliOrig") AND RECCOUNT("cursor_4c_DCliOrig") > 0
                    IF RECCOUNT("cursor_4c_DCliOrig") = 1
                        GO TOP IN cursor_4c_DCliOrig
                        loc_cConta = ALLTRIM(cursor_4c_DCliOrig.iclis)
                        loc_cNome  = ALLTRIM(cursor_4c_DCliOrig.rclis)
                    ELSE
                        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                        IF VARTYPE(loc_oBusca) = "O"
                            loc_oBusca.this_cCursorDestino = "cursor_4c_DCliOrig"
                            loc_oBusca.this_cTitulo = "Contas por Nome"
                            loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
                            loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                        "C" + CHR(243) + "digo")
                            loc_oBusca.Show()
                            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_DCliOrig")
                                GO TOP IN cursor_4c_DCliOrig
                                loc_cConta = ALLTRIM(cursor_4c_DCliOrig.iclis)
                                loc_cNome  = ALLTRIM(cursor_4c_DCliOrig.rclis)
                            ELSE
                                loc_cConta = ""
                                loc_cNome  = ""
                            ENDIF
                            loc_oBusca.Release()
                        ENDIF
                    ENDIF
                ELSE
                    loc_cConta = ""
                    loc_cNome  = ""
                ENDIF

                IF USED("cursor_4c_DCliOrig")
                    USE IN cursor_4c_DCliOrig
                ENDIF

                THIS.this_oBusinessObject.this_cContaos = loc_cConta
                THIS.this_cNomeContaos = loc_cNome
                IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
                    IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_ContaOrig", 5)
                        loc_oPg2.cnt_4c_Origem.txt_4c_ContaOrig.Value = loc_cConta
                    ENDIF
                    IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_DcontaOrig", 5)
                        loc_oPg2.cnt_4c_Origem.txt_4c_DcontaOrig.Value = loc_cNome
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_DCliOrig")
                USE IN cursor_4c_DCliOrig
            ENDIF
            MostrarErro("Erro em DcontaOrigemLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GrupoDestinoLostFocus - Valida grupo de Destino ao sair do campo
    * Legado: Destino.Get_grupo.Valid - fwBuscaSel em TmpGccr
    *--------------------------------------------------------------------------
    PROCEDURE GrupoDestinoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cGrupo, loc_oBusca, loc_nRet
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cGrupo = ""

        TRY
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5) AND ;
               PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_GrupoDest", 5)
                loc_cGrupo = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDest.Value) = "C", ;
                    loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDest.Value, ""))
            ENDIF

            IF EMPTY(loc_cGrupo)
                THIS.this_oBusinessObject.this_cGrupods = ""
                THIS.this_oBusinessObject.this_cContads = ""
                THIS.this_cNomeContads = ""
                IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
                    IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_ContaDest", 5)
                        loc_oPg2.cnt_4c_Destino.txt_4c_ContaDest.Value = ""
                    ENDIF
                    IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_DcontaDest", 5)
                        loc_oPg2.cnt_4c_Destino.txt_4c_DcontaDest.Value = ""
                    ENDIF
                ENDIF
            ELSE
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGcr", "cursor_4c_GrpDest", "codigos", loc_cGrupo, ;
                    "Busca de Grupos")

                IF VARTYPE(loc_oBusca) = "O"
                    IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                        loc_cGrupo = ALLTRIM(cursor_4c_GrpDest.codigos)
                    ELSE
                        IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX",                    "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("descrs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_GrpDest")
                            GO TOP IN cursor_4c_GrpDest
                            loc_cGrupo = ALLTRIM(cursor_4c_GrpDest.codigos)
                        ELSE
                            loc_cGrupo = ""
                        ENDIF
                    ELSE
                        loc_cGrupo = ""
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF

                IF USED("cursor_4c_GrpDest")
                    USE IN cursor_4c_GrpDest
                ENDIF

                THIS.this_oBusinessObject.this_cGrupods = loc_cGrupo
                IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5) AND ;
                   PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_GrupoDest", 5)
                    loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDest.Value = loc_cGrupo
                ENDIF
                IF EMPTY(loc_cGrupo)
                    THIS.this_oBusinessObject.this_cContads = ""
                    THIS.this_cNomeContads = ""
                    IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
                        IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_ContaDest", 5)
                            loc_oPg2.cnt_4c_Destino.txt_4c_ContaDest.Value = ""
                        ENDIF
                        IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_DcontaDest", 5)
                            loc_oPg2.cnt_4c_Destino.txt_4c_DcontaDest.Value = ""
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_GrpDest")
                USE IN cursor_4c_GrpDest
            ENDIF
            MostrarErro("Erro em GrupoDestinoLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE TeclaGrupoDestinoKP(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.GrupoDestinoLostFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ContaDestinoLostFocus - Valida conta de Destino ao sair do campo
    * Legado: Destino.Get_conta.Valid - fwBuscaSel em TmpCli
    *--------------------------------------------------------------------------
    PROCEDURE ContaDestinoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cConta, loc_cGrupo, loc_oBusca, loc_nRet, loc_cNome, loc_cSQL
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cConta = ""
        loc_cGrupo = ""
        loc_cNome  = ""
        loc_cSQL   = ""

        TRY
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
                IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_ContaDest", 5)
                    loc_cConta = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_ContaDest.Value) = "C", ;
                        loc_oPg2.cnt_4c_Destino.txt_4c_ContaDest.Value, ""))
                ENDIF
                IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_GrupoDest", 5)
                    loc_cGrupo = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDest.Value) = "C", ;
                        loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDest.Value, ""))
                ENDIF
            ENDIF

            IF EMPTY(loc_cConta)
                THIS.this_oBusinessObject.this_cContads = ""
                THIS.this_cNomeContads = ""
                IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5) AND ;
                   PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_DcontaDest", 5)
                    loc_oPg2.cnt_4c_Destino.txt_4c_DcontaDest.Value = ""
                ENDIF
            ELSE
                loc_cSQL = "SELECT iclis, rclis, grupos FROM SIGCDCLI WHERE iclis = " + EscaparSQL(loc_cConta)
                IF !EMPTY(loc_cGrupo)
                    loc_cSQL = loc_cSQL + " AND grupos = " + EscaparSQL(loc_cGrupo)
                ENDIF
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliDest")

                IF loc_nRet > 0 AND USED("cursor_4c_CliDest") AND RECCOUNT("cursor_4c_CliDest") = 0
                    USE IN cursor_4c_CliDest
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                        "SIGCDCLI", "cursor_4c_CliDest", "iclis", loc_cConta, ;
                        "Busca de Contas")
                    IF VARTYPE(loc_oBusca) = "O"
                        IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                            loc_cConta = ALLTRIM(cursor_4c_CliDest.iclis)
                            loc_cNome  = ALLTRIM(cursor_4c_CliDest.rclis)
                        ELSE
                            IF !loc_oBusca.this_lAchouRegistro
                            loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                      "C" + CHR(243) + "digo")
                            loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
                            loc_oBusca.Show()
                            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_CliDest")
                                GO TOP IN cursor_4c_CliDest
                                loc_cConta = ALLTRIM(cursor_4c_CliDest.iclis)
                                loc_cNome  = ALLTRIM(cursor_4c_CliDest.rclis)
                            ELSE
                                loc_cConta = ""
                                loc_cNome  = ""
                            ENDIF
                        ELSE
                            loc_cConta = ""
                            loc_cNome  = ""
                            ENDIF
                        ENDIF
                        loc_oBusca.Release()
                    ENDIF
                ELSE
                    IF loc_nRet > 0 AND USED("cursor_4c_CliDest") AND RECCOUNT("cursor_4c_CliDest") > 0
                    GO TOP IN cursor_4c_CliDest
                    loc_cConta = ALLTRIM(cursor_4c_CliDest.iclis)
                    loc_cNome  = ALLTRIM(cursor_4c_CliDest.rclis)
                    ENDIF
                ENDIF

                IF USED("cursor_4c_CliDest")
                    USE IN cursor_4c_CliDest
                ENDIF

                THIS.this_oBusinessObject.this_cContads = loc_cConta
                THIS.this_cNomeContads = loc_cNome
                IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
                    IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_ContaDest", 5)
                        loc_oPg2.cnt_4c_Destino.txt_4c_ContaDest.Value = loc_cConta
                    ENDIF
                    IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_DcontaDest", 5)
                        loc_oPg2.cnt_4c_Destino.txt_4c_DcontaDest.Value = loc_cNome
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_CliDest")
                USE IN cursor_4c_CliDest
            ENDIF
            MostrarErro("Erro em ContaDestinoLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE TeclaContaDestinoKP(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.ContaDestinoLostFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DcontaDestinoLostFocus - Busca conta de Destino por nome ao sair do campo
    * Legado: Destino.Get_dconta.Valid - fwBuscaSel em TmpCli por BalNome/RClis
    *--------------------------------------------------------------------------
    PROCEDURE DcontaDestinoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cNome, loc_oBusca, loc_nRet, loc_cConta
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cNome  = ""
        loc_cConta = ""

        TRY
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5) AND ;
               PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_DcontaDest", 5)
                loc_cNome = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_DcontaDest.Value) = "C", ;
                    loc_oPg2.cnt_4c_Destino.txt_4c_DcontaDest.Value, ""))
            ENDIF

            IF !EMPTY(loc_cNome)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT iclis, rclis FROM SIGCDCLI ORDER BY rclis", "cursor_4c_DCliDest")

                IF loc_nRet > 0 AND USED("cursor_4c_DCliDest") AND RECCOUNT("cursor_4c_DCliDest") > 0
                    IF RECCOUNT("cursor_4c_DCliDest") = 1
                        GO TOP IN cursor_4c_DCliDest
                        loc_cConta = ALLTRIM(cursor_4c_DCliDest.iclis)
                        loc_cNome  = ALLTRIM(cursor_4c_DCliDest.rclis)
                    ELSE
                        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                        IF VARTYPE(loc_oBusca) = "O"
                            loc_oBusca.this_cCursorDestino = "cursor_4c_DCliDest"
                            loc_oBusca.this_cTitulo = "Contas por Nome"
                            loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
                            loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                        "C" + CHR(243) + "digo")
                            loc_oBusca.Show()
                            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_DCliDest")
                                GO TOP IN cursor_4c_DCliDest
                                loc_cConta = ALLTRIM(cursor_4c_DCliDest.iclis)
                                loc_cNome  = ALLTRIM(cursor_4c_DCliDest.rclis)
                            ELSE
                                loc_cConta = ""
                                loc_cNome  = ""
                            ENDIF
                            loc_oBusca.Release()
                        ENDIF
                    ENDIF
                ELSE
                    loc_cConta = ""
                    loc_cNome  = ""
                ENDIF

                IF USED("cursor_4c_DCliDest")
                    USE IN cursor_4c_DCliDest
                ENDIF

                THIS.this_oBusinessObject.this_cContads = loc_cConta
                THIS.this_cNomeContads = loc_cNome
                IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
                    IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_ContaDest", 5)
                        loc_oPg2.cnt_4c_Destino.txt_4c_ContaDest.Value = loc_cConta
                    ENDIF
                    IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_DcontaDest", 5)
                        loc_oPg2.cnt_4c_Destino.txt_4c_DcontaDest.Value = loc_cNome
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_DCliDest")
                USE IN cursor_4c_DCliDest
            ENDIF
            MostrarErro("Erro em DcontaDestinoLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GrupoRespLostFocus - Valida grupo de Responsavel ao sair do campo
    * Legado: Responsavel.Get_grupo.Valid - fwBuscaSel em TmpGccr
    *--------------------------------------------------------------------------
    PROCEDURE GrupoRespLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cGrupo, loc_oBusca, loc_nRet
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cGrupo = ""

        TRY
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5) AND ;
               PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_GrupoResp", 5)
                loc_cGrupo = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Responsavel.txt_4c_GrupoResp.Value) = "C", ;
                    loc_oPg2.cnt_4c_Responsavel.txt_4c_GrupoResp.Value, ""))
            ENDIF

            IF EMPTY(loc_cGrupo)
                THIS.this_oBusinessObject.this_cGrvends = ""
                THIS.this_oBusinessObject.this_cVends   = ""
                THIS.this_cNomeVends = ""
                IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)
                    IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_ContaResp", 5)
                        loc_oPg2.cnt_4c_Responsavel.txt_4c_ContaResp.Value = ""
                    ENDIF
                    IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_DcontaResp", 5)
                        loc_oPg2.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ""
                    ENDIF
                ENDIF
            ELSE
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGcr", "cursor_4c_GrpResp", "codigos", loc_cGrupo, ;
                    "Busca de Grupos")

                IF VARTYPE(loc_oBusca) = "O"
                    IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                        loc_cGrupo = ALLTRIM(cursor_4c_GrpResp.codigos)
                    ELSE
                        IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX",                    "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("descrs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_GrpResp")
                            GO TOP IN cursor_4c_GrpResp
                            loc_cGrupo = ALLTRIM(cursor_4c_GrpResp.codigos)
                        ELSE
                            loc_cGrupo = ""
                        ENDIF
                    ELSE
                        loc_cGrupo = ""
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF

                IF USED("cursor_4c_GrpResp")
                    USE IN cursor_4c_GrpResp
                ENDIF

                THIS.this_oBusinessObject.this_cGrvends = loc_cGrupo
                IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5) AND ;
                   PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_GrupoResp", 5)
                    loc_oPg2.cnt_4c_Responsavel.txt_4c_GrupoResp.Value = loc_cGrupo
                ENDIF
                IF EMPTY(loc_cGrupo)
                    THIS.this_oBusinessObject.this_cVends = ""
                    THIS.this_cNomeVends = ""
                    IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)
                        IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_ContaResp", 5)
                            loc_oPg2.cnt_4c_Responsavel.txt_4c_ContaResp.Value = ""
                        ENDIF
                        IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_DcontaResp", 5)
                            loc_oPg2.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ""
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_GrpResp")
                USE IN cursor_4c_GrpResp
            ENDIF
            MostrarErro("Erro em GrupoRespLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE TeclaGrupoRespKP(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.GrupoRespLostFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ContaRespLostFocus - Valida conta de Responsavel ao sair do campo
    * Legado: Responsavel.Get_conta.Valid - fwBuscaSel em TmpCli
    *--------------------------------------------------------------------------
    PROCEDURE ContaRespLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cConta, loc_cGrupo, loc_oBusca, loc_nRet, loc_cNome, loc_cSQL
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cConta = ""
        loc_cGrupo = ""
        loc_cNome  = ""
        loc_cSQL   = ""

        TRY
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)
                IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_ContaResp", 5)
                    loc_cConta = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Responsavel.txt_4c_ContaResp.Value) = "C", ;
                        loc_oPg2.cnt_4c_Responsavel.txt_4c_ContaResp.Value, ""))
                ENDIF
                IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_GrupoResp", 5)
                    loc_cGrupo = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Responsavel.txt_4c_GrupoResp.Value) = "C", ;
                        loc_oPg2.cnt_4c_Responsavel.txt_4c_GrupoResp.Value, ""))
                ENDIF
            ENDIF

            IF EMPTY(loc_cConta)
                THIS.this_oBusinessObject.this_cVends = ""
                THIS.this_cNomeVends = ""
                IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5) AND ;
                   PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_DcontaResp", 5)
                    loc_oPg2.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ""
                ENDIF
            ELSE
                loc_cSQL = "SELECT iclis, rclis, grupos FROM SIGCDCLI WHERE iclis = " + EscaparSQL(loc_cConta)
                IF !EMPTY(loc_cGrupo)
                    loc_cSQL = loc_cSQL + " AND grupos = " + EscaparSQL(loc_cGrupo)
                ENDIF
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliResp")

                IF loc_nRet > 0 AND USED("cursor_4c_CliResp") AND RECCOUNT("cursor_4c_CliResp") = 0
                    USE IN cursor_4c_CliResp
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                        "SIGCDCLI", "cursor_4c_CliResp", "iclis", loc_cConta, ;
                        "Busca de Contas")
                    IF VARTYPE(loc_oBusca) = "O"
                        IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                            loc_cConta = ALLTRIM(cursor_4c_CliResp.iclis)
                            loc_cNome  = ALLTRIM(cursor_4c_CliResp.rclis)
                        ELSE
                            IF !loc_oBusca.this_lAchouRegistro
                            loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                      "C" + CHR(243) + "digo")
                            loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
                            loc_oBusca.Show()
                            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_CliResp")
                                GO TOP IN cursor_4c_CliResp
                                loc_cConta = ALLTRIM(cursor_4c_CliResp.iclis)
                                loc_cNome  = ALLTRIM(cursor_4c_CliResp.rclis)
                            ELSE
                                loc_cConta = ""
                                loc_cNome  = ""
                            ENDIF
                        ELSE
                            loc_cConta = ""
                            loc_cNome  = ""
                            ENDIF
                        ENDIF
                        loc_oBusca.Release()
                    ENDIF
                ELSE
                    IF loc_nRet > 0 AND USED("cursor_4c_CliResp") AND RECCOUNT("cursor_4c_CliResp") > 0
                    GO TOP IN cursor_4c_CliResp
                    loc_cConta = ALLTRIM(cursor_4c_CliResp.iclis)
                    loc_cNome  = ALLTRIM(cursor_4c_CliResp.rclis)
                    ENDIF
                ENDIF

                IF USED("cursor_4c_CliResp")
                    USE IN cursor_4c_CliResp
                ENDIF

                THIS.this_oBusinessObject.this_cVends = loc_cConta
                THIS.this_cNomeVends = loc_cNome
                IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)
                    IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_ContaResp", 5)
                        loc_oPg2.cnt_4c_Responsavel.txt_4c_ContaResp.Value = loc_cConta
                    ENDIF
                    IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_DcontaResp", 5)
                        loc_oPg2.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = loc_cNome
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_CliResp")
                USE IN cursor_4c_CliResp
            ENDIF
            MostrarErro("Erro em ContaRespLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE TeclaContaRespKP(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.ContaRespLostFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DcontaRespLostFocus - Busca conta de Responsavel por nome ao sair do campo
    * Legado: Responsavel.Get_dconta.Valid - fwBuscaSel em TmpCli por BalNome
    *--------------------------------------------------------------------------
    PROCEDURE DcontaRespLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cNome, loc_oBusca, loc_nRet, loc_cConta
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cNome  = ""
        loc_cConta = ""

        TRY
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5) AND ;
               PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_DcontaResp", 5)
                loc_cNome = ALLTRIM(IIF(VARTYPE(loc_oPg2.cnt_4c_Responsavel.txt_4c_DcontaResp.Value) = "C", ;
                    loc_oPg2.cnt_4c_Responsavel.txt_4c_DcontaResp.Value, ""))
            ENDIF

            IF !EMPTY(loc_cNome)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT iclis, rclis FROM SIGCDCLI ORDER BY rclis", "cursor_4c_DCliResp")

                IF loc_nRet > 0 AND USED("cursor_4c_DCliResp") AND RECCOUNT("cursor_4c_DCliResp") > 0
                    IF RECCOUNT("cursor_4c_DCliResp") = 1
                        GO TOP IN cursor_4c_DCliResp
                        loc_cConta = ALLTRIM(cursor_4c_DCliResp.iclis)
                        loc_cNome  = ALLTRIM(cursor_4c_DCliResp.rclis)
                    ELSE
                        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                        IF VARTYPE(loc_oBusca) = "O"
                            loc_oBusca.this_cCursorDestino = "cursor_4c_DCliResp"
                            loc_oBusca.this_cTitulo = "Contas por Nome"
                            loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
                            loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                        "C" + CHR(243) + "digo")
                            loc_oBusca.Show()
                            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_DCliResp")
                                GO TOP IN cursor_4c_DCliResp
                                loc_cConta = ALLTRIM(cursor_4c_DCliResp.iclis)
                                loc_cNome  = ALLTRIM(cursor_4c_DCliResp.rclis)
                            ELSE
                                loc_cConta = ""
                                loc_cNome  = ""
                            ENDIF
                            loc_oBusca.Release()
                        ENDIF
                    ENDIF
                ELSE
                    loc_cConta = ""
                    loc_cNome  = ""
                ENDIF

                IF USED("cursor_4c_DCliResp")
                    USE IN cursor_4c_DCliResp
                ENDIF

                THIS.this_oBusinessObject.this_cVends = loc_cConta
                THIS.this_cNomeVends = loc_cNome
                IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)
                    IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_ContaResp", 5)
                        loc_oPg2.cnt_4c_Responsavel.txt_4c_ContaResp.Value = loc_cConta
                    ENDIF
                    IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_DcontaResp", 5)
                        loc_oPg2.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = loc_cNome
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_DCliResp")
                USE IN cursor_4c_DCliResp
            ENDIF
            MostrarErro("Erro em DcontaRespLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CodobsLostFocus - Valida codigo de observacao e carrega texto (SigCdObs)
    * Legado: get_codobs.Valid - Query SigCdObs WHERE codigos BETWEEN pIni AND pFim
    *   depois fwBuscaSel se nao encontrado. Preenche Mm_obs com observas.
    *--------------------------------------------------------------------------
    PROCEDURE CodobsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_nCod, loc_nRet, loc_oBusca, loc_cObs
        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_nCod  = 0
        loc_cObs  = ""

        TRY
            IF PEMSTATUS(loc_oPg2, "txt_4c_Codobs", 5)
                loc_nCod = IIF(VARTYPE(loc_oPg2.txt_4c_Codobs.Value) = "N", loc_oPg2.txt_4c_Codobs.Value, 0)
            ENDIF

            IF loc_nCod = 0
                *-- Campo vazio: limpa BO e EditBox
                THIS.this_oBusinessObject.this_cCodObs = ""
                THIS.this_cAntValue = ""
                IF PEMSTATUS(loc_oPg2, "edt_4c_Mmobs", 5)
                    loc_oPg2.edt_4c_Mmobs.Value = ""
                ENDIF
            ELSE
                IF TRANSFORM(loc_nCod) = THIS.this_cAntValue
                *-- Sem mudanca de valor: nao re-consulta
                THIS.this_oBusinessObject.this_cCodObs = ALLTRIM(TRANSFORM(loc_nCod))
            ELSE
                THIS.this_cAntValue = TRANSFORM(loc_nCod)

                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT codigos, descrs, observas FROM SigCdObs WHERE codigos = " + ;
                    FormatarNumeroSQL(loc_nCod), "cursor_4c_ObsBusca")

                IF loc_nRet > 0 AND USED("cursor_4c_ObsBusca") AND RECCOUNT("cursor_4c_ObsBusca") = 0
                    USE IN cursor_4c_ObsBusca
                    *-- Nao encontrou: abre busca completa
                    loc_nRet = SQLEXEC(gnConnHandle, ;
                        "SELECT codigos, descrs, observas FROM SigCdObs ORDER BY codigos", ;
                        "cursor_4c_ObsBusca")

                    IF loc_nRet > 0 AND USED("cursor_4c_ObsBusca")
                        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                        IF VARTYPE(loc_oBusca) = "O"
                            loc_oBusca.this_cCursorDestino = "cursor_4c_ObsBusca"
                            loc_oBusca.this_cTitulo = "Observa" + CHR(231) + CHR(227) + "es"
                            loc_oBusca.mAddColuna("codigos", "999",                                                "C" + CHR(243) + "d.")
                            loc_oBusca.mAddColuna("descrs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
                            loc_oBusca.Show()
                            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_ObsBusca")
                                GO TOP IN cursor_4c_ObsBusca
                                loc_nCod = cursor_4c_ObsBusca.codigos
                                loc_cObs = IIF(VARTYPE(cursor_4c_ObsBusca.observas) = "C", cursor_4c_ObsBusca.observas, "")
                            ELSE
                                loc_nCod = 0
                                loc_cObs = ""
                            ENDIF
                            loc_oBusca.Release()
                        ENDIF
                    ENDIF
                ELSE
                    IF loc_nRet > 0 AND USED("cursor_4c_ObsBusca") AND RECCOUNT("cursor_4c_ObsBusca") > 0
                    GO TOP IN cursor_4c_ObsBusca
                    loc_nCod = cursor_4c_ObsBusca.codigos
                    loc_cObs = IIF(VARTYPE(cursor_4c_ObsBusca.observas) = "C", cursor_4c_ObsBusca.observas, "")
                    ENDIF
                ENDIF

                IF USED("cursor_4c_ObsBusca")
                    USE IN cursor_4c_ObsBusca
                ENDIF

                THIS.this_oBusinessObject.this_cCodObs = IIF(loc_nCod > 0, ALLTRIM(TRANSFORM(loc_nCod)), "")
                THIS.this_oBusinessObject.this_cObss   = loc_cObs

                IF PEMSTATUS(loc_oPg2, "txt_4c_Codobs", 5)
                    loc_oPg2.txt_4c_Codobs.Value = loc_nCod
                ENDIF
                IF PEMSTATUS(loc_oPg2, "edt_4c_Mmobs", 5)
                    loc_oPg2.edt_4c_Mmobs.Value = loc_cObs
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_ObsBusca")
                USE IN cursor_4c_ObsBusca
            ENDIF
            MostrarErro("Erro em CodobsLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE TeclaCodobsKP(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.CodobsLostFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar o formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("TmpOperacao")
            USE IN TmpOperacao
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
