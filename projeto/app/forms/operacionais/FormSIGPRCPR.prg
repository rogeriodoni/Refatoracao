*==============================================================================
* FormSIGPRCPR.prg - Formulario Operacional: Conferencia e Reserva de Producao
* Herda de: FormBase
* Origem:  SIGPRCPR.SCX (dialogo modal chamado por um form pai de Ordem de
*          Producao - recebe o form pai via parametro, igual ao legado
*          "LParameters _Form")
* BO:      SIGPRCPRBO (ver classes\SIGPRCPRBO.prg)
*
* Fase 3/8: Estrutura base.
*   - DEFINE CLASS + propriedades visuais/estado
*   - Init / InicializarForm / Destroy
*   - ConfigurarCabecalho (cnt_4c_Sombra + lbl_4c_LblSombra/lbl_4c_LblTitulo)
*   - TornarControlesVisiveis recursivo
*
* Fase 4/8: Grid e botoes.
*   - ConfigurarGrid (grd_4c_Dados - equivalente a Grade/TmpBaixa, com o
*     cursor_4c_Baixa pre-criado com a MESMA estrutura que
*     o metodo de carga de etiquetas do SIGPRCPRBO usa)
*   - VincularGrid (bind do cursor + larguras + headers, na ordem canonica
*     RecordSource -> ControlSource -> Width -> Header1.Caption)
*   - CarregarDados (equivalente a "PROCEDURE carregabars" do legado:
*     carga do cursor da grade + GO TOP + Refresh + visibilidade dos
*     controles conforme Eof())
*   - AjustarVisibilidadePorEtiquetas (Grade/Txt_Leitura/Get_Leitura/Ok/
*     Conferencia .Visible = Not Eof(), igual ao fim do carregabars legado)
*   - ConfigurarBotoes (cmd_4c_Conferencia/cmd_4c_Ok/cmd_4c_Sair) + handlers
*     Click (delegam a SIGPRCPRBO.ConferenciaAutomatica()/
*     ConfirmarConferencia())
*
* Fase 5/8: Campo Data (1a metade dos campos principais).
*   - ConfigurarCampoData (lbl_4c_Label2 + txt_4c_Data - equivalente a
*     Label2/Get_Data do legado: TextBox READONLY que so exibe a data
*     recebida do form pai, igual ao "Get_Data.When = Return .f." +
*     "ThisForm.Get_Data.Value = ThisForm.ParentForm.Get_Data.Value" do
*     Init legado)
*   - ObterDataDoFormPai (le a data do form pai por nome; o form pai -
*     Ordem de Producao - ainda nao foi migrado, entao cai para DATE()
*     se a property nao existir, para o campo nunca abrir vazio)
*
* Fase 6/8: Campo de leitura de codigo de barra (2a metade dos campos -
* NAO HA LOOKUP neste form: o codigo-fonte original nao tem nenhum
* fwbuscaext/sigacess/CreateObject de busca, entao nenhum foi inventado).
*   - ConfigurarCampoLeitura (lbl_4c_Txt_Leitura + txt_4c_Leitura -
*     equivalente a Txt_Leitura/Get_Leitura do legado: label + TextBox
*     NUMERICO de leitura de codigo de barra, Visible=.F. ate haver
*     etiqueta em aberto - AjustarVisibilidadePorEtiquetas, ja escrito na
*     Fase 4, controla a visibilidade dos dois)
*   - LeituraKeyPress/ValidarLeituraCodigoBarra (equivalente ao Valid do
*     Get_Leitura: delega a SIGPRCPRBO.ProcessarLeituraCodigoBarra()
*     (Fase 2), traduz o resultado nas MESMAS mensagens do legado,
*     repinta a grade e zera o campo para a proxima leitura - igual a
*     "This.Value = 0" no fim do Valid legado, em AMBOS os caminhos)
*
* Fase 7/8: Eventos principais dos botoes.
*   O template generico desta fase pede BtnIncluirClick/BtnAlterarClick/
*   BtnVisualizarClick/BtnExcluirClick, que sao a barra CRUD do frmcadastro.
*   Este legado NAO TEM CRUD: o SCX herda de "form" puro (nao de frmcadastro),
*   nao tem Grupo_Op, nao tem pcEscolha e tem EXATAMENTE 3 botoes - Sair, Ok e
*   Conferencia, todos commandbutton soltos. Criar os 4 nomes aqui seria
*   INVENTAR botao que o legado nao tem (viola o PILAR 1) ou gerar metodo vazio
*   (proibido pela regra de completude). Os eventos dos botoes que o legado
*   REALMENTE tem sao BtnConferenciaClick/BtnOkClick/BtnSairClick, escritos na
*   Fase 4 e conferidos aqui contra os Click do dump legado.
*
*   O que esta fase ACRESCENTOU, por serem eventos do legado que a traducao
*   anterior nao cobria:
*   - LeituraWhen (Get_Leitura.When = "Set Confirm On") e LeituraLostFocus
*     (Get_Leitura.LostFocus = "Set Confirm Off"). Sem CONFIRM ON o TextBox
*     de mascara "99999999999999" sai do campo sozinho no 14o digito e o ENTER
*     do leitor de codigo de barra vaza para outro controle.
*   - o caminho do Valid legado que o KeyPress nao alcanca: sair do campo com o
*     MOUSE (clique em Ok/Conf. Auto) tambem processa a leitura em aberto, com
*     guarda de reentrancia (this_lProcessandoLeitura).
*   - SET CONFIRM OFF no Destroy: este form nao tem DataSession = 2, entao o
*     SET vale para a sessao CORRENTE e nao pode vazar para a aplicacao.
*
* Fase 8/8: Consolidacao final.
*   O template generico desta fase pede BtnBuscarClick/BtnEncerrarClick/
*   BtnSalvarClick/BtnCancelarClick, FormParaBO/BOParaForm, HabilitarCampos/
*   LimparCampos, CarregarLista/AjustarBotoesPorModo - vocabulario do
*   frmcadastro (Lista+Dados, modos INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR). Este
*   dialogo NAO tem PageFrame, NAO tem modo de edicao por registro e NAO
*   persiste campo-a-campo via FormParaBO/BOParaForm - ele confere etiquetas
*   por leitura de codigo de barra e grava tudo em LOTE em
*   SIGPRCPRBO.ConfirmarConferencia(). Gerar esses 9 metodos aqui seria
*   inventar funcionalidade que o legado nao tem (viola o PILAR 1) ou gerar
*   stub vazio (proibido pela regra de completude). Equivalentes REAIS ja
*   escritos nas fases anteriores:
*     BtnEncerrarClick -> BtnSairClick (Fase 4)
*     BtnSalvarClick   -> BtnOkClick (Fase 4)
*     CarregarLista    -> CarregarDados (Fase 4)
*   BtnBuscarClick/BtnCancelarClick/FormParaBO/BOParaForm/HabilitarCampos/
*   LimparCampos/AjustarBotoesPorModo nao tem equivalente: o legado nao tem
*   busca, nao tem Cancelar (so Ok/Conf. Auto/Sair), nao tem campos de
*   cadastro persistidos por registro e nao alterna "modo" de tela.
*
*   Idem para o item "Integracao" (menu.prg): o SCX legado NAO aparece em
*   nenhum popup - eh aberto so pelo botao de conferencia da Ordem de
*   Producao (form pai ainda nao migrado), via "LParameters _Form". Registrar
*   um item de menu aqui inventaria uma rota de navegacao que o usuario do
*   legado nunca teve (viola o PILAR 1). SET PROCEDURE de BO/Form nao precisa
*   de entrada manual: config.prg ja varre classes\*BO.prg e
*   forms\operacionais\Form*.prg via ADIR (secao "Dynamic Loading").
*
*   O que esta fase efetivamente corrigiu, por ser uma lacuna real na
*   consolidacao das fases anteriores: Init() criava o BO mas nunca
*   preenchia this_cEmpresa/this_cUsuario (propriedades declaradas e usadas
*   no carregamento de etiquetas e em ConfirmarConferencia para montar
*   EmpDopNums/EmpGruEsts e para Usuars de SigMvCab/SigMvItn/SigMvHst, mas
*   sem nenhum ponto no form que as atribuisse). Sem isso, this_cEmpresa
*   ficaria "" a sessao inteira: MontarEmpDopNums(THIS.this_cEmpresa, ...)
*   geraria uma chave com os 3 primeiros caracteres em branco (PADR(""),3))
*   e o SEEK/ConsultarRegistro contra SigOpEtq.EmpDopNums NUNCA casaria - a
*   tela abriria sempre com "Nenhuma Etiqueta Selecionada", mascarando
*   qualquer etiqueta real em aberto. Corrigido lendo os globais que o
*   startup novo ja mantem (go_4c_Sistema.cCodEmpresa/gc_4c_UsuarioLogado -
*   equivalentes a _EMPR/Usuar do legado, que este form nao recebe do form
*   pai) logo apos criar o BO.
*
* Layout OPERACIONAL flat (800x400, igual ao legado) - dialogo modal SEM
* PageFrame Lista/Dados do padrao CRUD.
*==============================================================================

DEFINE CLASS FormSIGPRCPR AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais do form
    *--------------------------------------------------------------------------
    this_cMensagemErro = ""
    Width        = 800
    Height       = 400
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    WindowType   = 1
    FontName     = "Tahoma"
    FontSize     = 8
    ForeColor    = RGB(36, 84, 155)
    Caption      = "Confer" + CHR(234) + "ncia e Reserva de Produ" + CHR(231) + CHR(227) + "o"
    Picture      = "..\framework\imagens\new_background.jpg"

    *--------------------------------------------------------------------------
    * Propriedades de estado
    *--------------------------------------------------------------------------
    this_oBusinessObject = .NULL.
    this_oParent         = .NULL.

    *-- Guarda de reentrancia da leitura de codigo de barra: ValidarLeitura-
    *-- CodigoBarra exibe MsgAviso e devolve o foco ao campo, e as duas coisas
    *-- disparam LostFocus de novo - sem a flag o handler se empilharia.
    this_lProcessandoLeitura = .F.

    *==========================================================================
    * Init - Cria o BO e guarda referencia ao form pai (equivalente ao
    * "LParameters _Form" + "ThisForm.ParentForm = _Form" do legado).
    * par_oParent : form pai (Ordem de Producao) que abriu este dialogo
    *==========================================================================
    FUNCTION Init(par_oParent)
        IF VARTYPE(par_oParent) = "O"
            THIS.this_oParent = par_oParent
        ENDIF

        THIS.this_oBusinessObject = CREATEOBJECT("SIGPRCPRBO")
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Erro ao criar SIGPRCPRBO.", "Erro")
            RETURN .F.
        ENDIF

        *-- Equivalente a _Empr/Usuar do legado (cursores/globais Fortyus que o
        *-- startup novo NAO pre-carrega mais - CLAUDE.md: "_EMPR: LEGACY -
        *-- NUNCA usar -> go_4c_Sistema.cCodEmpresa"). Sem isto, EmpDopNums/
        *-- EmpGruEsts nasceriam com a empresa em branco (MontarEmpDopNums/
        *-- MontarEmpGruEsts nunca fariam ALLTRIM - regra de chave posicional -
        *-- e o SEEK contra SigOpEtq.EmpDopNums nunca casaria) e SigMvCab/
        *-- SigMvItn/SigMvHst gravariam Usuars em branco.
        THIS.this_oBusinessObject.this_cEmpresa = go_4c_Sistema.cCodEmpresa
        THIS.this_oBusinessObject.this_cUsuario = gc_4c_UsuarioLogado

        RETURN DODEFAULT()
    ENDFUNC

    *==========================================================================
    * InicializarForm - Monta a estrutura base do form
    * Deve retornar .T. em sucesso e .F. em falha (contrato do FormBase.Init)
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_lModoValidacaoOuTeste

        loc_lSucesso = .F.
        loc_lModoValidacaoOuTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                                    (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)

        *-- Fundo do form (new_background.jpg do legado - property estatica
        *-- acima so guarda o literal do SCX para fidelidade de UI; o caminho
        *-- resolvido em runtime usa a variavel global de icones do sistema novo)
        THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

        TRY
            THIS.ConfigurarCabecalho()

            THIS.ConfigurarCampoData()

            THIS.ConfigurarCampoLeitura()

            THIS.ConfigurarGrid()

            THIS.ConfigurarBotoes()

            THIS.TornarControlesVisiveis(THIS)

            *-- Carga da grade: o Init legado chama "ThisForm.CarregaBars"
            *-- ANTES de vincular a Grade. Sem etiqueta em aberto o legado
            *-- apenas avisa e esconde Grade/leitura/Ok/Conferencia - a tela
            *-- CONTINUA abrindo (so com o Encerrar), por isso o retorno de
            *-- CarregarDados NAO entra em loc_lSucesso.
            *-- Em validacao de UI / modo teste nao existe form pai nem
            *-- conexao SQL: a carga eh pulada e o form abre so com o layout.
            IF !loc_lModoValidacaoOuTeste
                THIS.CarregarDados()
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSIGPRCPR.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container cinza com titulo (cntSombra legado)
    * cnt_4c_Sombra: Top=0 Left=0 Width=800 Height=80 BackColor=RGB(100,100,100)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .Top        = 18
            .Left       = 10
            .Width      = THIS.Width - 20
            .Height     = 40
            .FontName   = "Tahoma"
            .FontSize   = 16
            .FontBold   = .T.
            .ForeColor  = RGB(0, 0, 0)
            .BackStyle  = 0
            .WordWrap   = .T.
            .AutoSize   = .F.
            .Caption    = THIS.Caption
            .Visible    = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top        = 17
            .Left       = 10
            .Width      = THIS.Width - 20
            .Height     = 46
            .FontName   = "Tahoma"
            .FontSize   = 16
            .FontBold   = .T.
            .ForeColor  = RGB(255, 255, 255)
            .BackStyle  = 0
            .WordWrap   = .T.
            .AutoSize   = .F.
            .Caption    = THIS.Caption
            .Visible    = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCampoData - Label2 + Get_Data do legado (lbl_4c_Label2 +
    * txt_4c_Data). Get_Data eh READONLY no SCX (ReadOnly=.T. +
    * When retorna .f.) - o campo so EXIBE a data recebida do form pai, o
    * usuario nunca digita nela. Posicoes/propriedades EXATAS do SCX
    * legado (Label2/Get_Data).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCampoData()
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 110
            .Left      = 133
            .Width     = 35
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Data : "
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Data", "TextBox")
        WITH THIS.txt_4c_Data
            .Top               = 107
            .Left              = 170
            .Width             = 80
            .Height            = 23
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Alignment         = 3
            .ReadOnly          = .T.
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(255, 255, 255)
            .BorderColor       = RGB(100, 100, 100)
            .Value             = THIS.ObterDataDoFormPai()
            .Visible           = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ObterDataDoFormPai - Equivalente a "ThisForm.Get_Data.Value =
    * ThisForm.ParentForm.Get_Data.Value" do Init legado. O form pai (Ordem
    * de Producao) ainda nao foi migrado para a nova arquitetura; ate la,
    * tenta ler a data pelo nome novo (txt_4c_Data) e depois pelo nome
    * legado (Get_Data), e cai para DATE() se nenhum existir ou vier vazio -
    * o campo nunca abre em branco/invalido.
    *==========================================================================
    PROTECTED FUNCTION ObterDataDoFormPai()
        LOCAL loc_dData

        loc_dData = {}

        IF VARTYPE(THIS.this_oParent) = "O"
            IF PEMSTATUS(THIS.this_oParent, "txt_4c_Data", 5) AND ;
               VARTYPE(THIS.this_oParent.txt_4c_Data) = "O"
                loc_dData = ConverterParaData(THIS.this_oParent.txt_4c_Data.Value)
            ELSE
                IF PEMSTATUS(THIS.this_oParent, "Get_Data", 5) AND ;
                   VARTYPE(THIS.this_oParent.Get_Data) = "O"
                    loc_dData = ConverterParaData(THIS.this_oParent.Get_Data.Value)
                ENDIF
            ENDIF
        ENDIF

        IF EMPTY(loc_dData)
            loc_dData = DATE()
        ENDIF

        RETURN loc_dData
    ENDFUNC

    *==========================================================================
    * ConfigurarCampoLeitura - Txt_Leitura/Get_Leitura do legado
    * (lbl_4c_Txt_Leitura + txt_4c_Leitura): label + TextBox NUMERICO de
    * leitura de codigo de barra. Posicoes/propriedades EXATAS do SCX
    * legado. Visible = .F. nos dois (igual ao legado - so ficam visiveis
    * quando ha etiqueta em aberto; ver AjustarVisibilidadePorEtiquetas,
    * escrito na Fase 4, e o skip em TornarControlesVisiveis abaixo).
    *
    * lbl_4c_Txt_Leitura: o SCX declara AutoSize=.T. mas NAO WordWrap - regra
    * do projeto (#23): AutoSize=.T. eh no-op em Label criado por AddObject,
    * entao usar AutoSize=.F. + Width/Height EXATOS do dump (86x15), que ja
    * sao o auto-size calculado pelo Form Designer legado.
    *
    * txt_4c_Leitura: InputMask="99999999999999" (14 digitos, igual ao SCX) e
    * .Value = 0 (NUMERICO) - o Valid legado termina com "This.Value = 0" e a
    * BO (SIGPRCPRBO.ProcessarLeituraCodigoBarra) exige par_nCodigoBarra
    * numerico, entao o campo tem de nascer numerico, nao "".
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCampoLeitura()
        THIS.AddObject("lbl_4c_Txt_Leitura", "Label")
        WITH THIS.lbl_4c_Txt_Leitura
            .Top       = 359
            .Left      = 133
            .Width     = 86
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "C" + CHR(243) + "digo de barra :"
            .Visible   = .F.
        ENDWITH

        THIS.AddObject("txt_4c_Leitura", "TextBox")
        WITH THIS.txt_4c_Leitura
            .Top         = 355
            .Left        = 221
            .Width       = 108
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .InputMask   = "99999999999999"
            .BorderColor = RGB(100, 100, 100)
            .Value       = 0
            .Visible     = .F.
        ENDWITH
        BINDEVENT(THIS.txt_4c_Leitura, "KeyPress",  THIS, "LeituraKeyPress")
        BINDEVENT(THIS.txt_4c_Leitura, "When",      THIS, "LeituraWhen")
        BINDEVENT(THIS.txt_4c_Leitura, "KeyPress", THIS, "LeituraLostFocus")
    ENDPROC

    *==========================================================================
    * LeituraWhen - equivalente ao When do Get_Leitura legado, que eh
    * "Set Confirm On" e MAIS NADA.
    *
    * Com SET CONFIRM OFF (default do VFP9) um TextBox sai do campo SOZINHO no
    * instante em que a mascara enche - e aqui a mascara eh "99999999999999",
    * 14 digitos, exatamente o tamanho de um codigo de barra. O leitor digita
    * os 14 digitos e SO DEPOIS manda o ENTER: sem CONFIRM ON o campo ja saiu
    * no 14o digito e o ENTER solto vai para o controle que ficou com o foco.
    * Por isso o legado liga CONFIRM ao ENTRAR no campo e desliga ao SAIR
    * (LeituraLostFocus) - nao eh detalhe de estilo, eh o que faz a leitura
    * por scanner funcionar.
    *==========================================================================
    PROCEDURE LeituraWhen()
        SET CONFIRM ON
        RETURN .T.
    ENDPROC

    *==========================================================================
    * LeituraLostFocus - equivalente ao LostFocus do Get_Leitura legado
    * ("Set Confirm Off"), MAIS o caminho do Valid legado que o KeyPress nao
    * cobre.
    *
    * O Valid legado dispara ao sair do campo por QUALQUER meio, inclusive
    * clique do mouse em Ok/Conf. Auto. Traduzir o Valid so em KeyPress
    * (ENTER/TAB) perde o codigo digitado quando o usuario sai com o mouse -
    * ele digita a etiqueta, clica em Ok e a leitura nunca eh processada.
    *
    * O "Return 0" do Valid legado (com valor preenchido) mantem o foco no
    * campo: o clique em Ok eh engolido e o usuario clica de novo. Isso eh
    * reproduzido pelo SetFocus do fim de ValidarLeituraCodigoBarra.
    *
    * SEM chamar CarregarDados/SQLEXEC aqui (regra do projeto: LostFocus
    * dispara sempre e nao serve para recarga) - so o processamento da leitura
    * em aberto, com a guarda de reentrancia.
    *==========================================================================
    PROCEDURE LeituraLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        SET CONFIRM OFF

        IF THIS.this_lProcessandoLeitura
            RETURN
        ENDIF

        IF VARTYPE(THIS.txt_4c_Leitura) != "O" OR THIS.txt_4c_Leitura.Value = 0
            RETURN
        ENDIF

        THIS.ValidarLeituraCodigoBarra()
    ENDPROC

    *==========================================================================
    * LeituraKeyPress - dispara a validacao em ENTER/TAB (BINDEVENT "Valid"
    * NAO funciona em TextBox - regra do projeto). O scanner de codigo de
    * barra tipicamente envia ENTER apos o codigo.
    *==========================================================================
    PROCEDURE LeituraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarLeituraCodigoBarra()
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarLeituraCodigoBarra - equivalente ao Valid do Get_Leitura legado:
    * delega a SIGPRCPRBO.ProcessarLeituraCodigoBarra() (Fase 2 - ja faz o
    * SEEK/REPLACE no cursor_4c_Baixa) e traduz o status devolvido nas
    * MESMAS mensagens do legado. "This.Value = 0" do legado roda em AMBOS
    * os caminhos (achou ou nao achou) - aqui tambem, fora do DO CASE.
    *==========================================================================
    PROCEDURE ValidarLeituraCodigoBarra()
        LOCAL loc_nCodigo, loc_cResultado

        loc_nCodigo = THIS.txt_4c_Leitura.Value

        IF loc_nCodigo = 0
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        *-- Guarda de reentrancia: o MsgAviso e o SetFocus abaixo tiram e
        *-- devolvem o foco, e os dois disparam LostFocus outra vez. A flag eh
        *-- ligada APOS os RETURN de guarda acima (nenhum RETURN entre ligar e
        *-- desligar, senao ela ficaria presa em .T.).
        THIS.this_lProcessandoLeitura = .T.

        loc_cResultado = THIS.this_oBusinessObject.ProcessarLeituraCodigoBarra(loc_nCodigo)

        DO CASE
            CASE loc_cResultado = "JA_LIDO"
                MsgAviso("C" + CHR(243) + "digo de Barras J" + CHR(225) + " Foi Lido!!!", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            CASE loc_cResultado = "NAO_CADASTRADO"
                MsgAviso("C" + CHR(243) + "digo de Barras N" + CHR(227) + "o Cadastrado!!!", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            CASE loc_cResultado = "SEM_CURSOR"
                MsgAviso("Nenhuma etiqueta carregada para conferir.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
        ENDCASE

        *-- Popular/alterar o cursor da grade NAO repinta sozinho
        THIS.grd_4c_Dados.Refresh()

        THIS.txt_4c_Leitura.Value = 0

        IF THIS.Visible AND THIS.txt_4c_Leitura.Visible
            THIS.txt_4c_Leitura.SetFocus()
        ENDIF

        THIS.this_lProcessandoLeitura = .F.
    ENDPROC

    *==========================================================================
    * ConfigurarGrid - Grade legado (grd_4c_Dados): 5 colunas (CodBarra,
    * CPros, Dopes, Numes, QtdeLido), ligadas ao MESMO cursor que
    * o metodo de carga de etiquetas do SIGPRCPRBO cria (this_cCursorBaixa,
    * default "cursor_4c_Baixa" - equivalente a TmpBaixa do legado).
    *
    * O cursor eh pre-criado AQUI, vazio, com a estrutura EXATA da
    * CREATE CURSOR do BO (regra do projeto: Column.ControlSource antes do
    * cursor existir derruba o Init - erro176/regra #41) - sem isso o
    * ColumnN.ControlSource abaixo estouraria "Alias is not found" e o
    * CREATEOBJECT("FormSIGPRCPR") devolveria .F. antes de qualquer etiqueta
    * ser carregada.
    *
    * Grid.Visible = .F. (legado: Grade.Visible = .F. no SCX, so vira .T.
    * quando ha etiquetas em aberto - equivalente a "ThisForm.Grade.Visible
    * = Not Eof()" no fim do CarregaBars legado). TornarControlesVisiveis
    * tem de IGNORAR este controle (ver skip abaixo).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_cCursor

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorBaixa

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
        CREATE CURSOR (loc_cCursor) ;
            (CodBarra N(14,0), CPros C(14), Dopes C(20), Numes N(6,0), ;
             Qtde N(9,3), QtdeLido N(9,3), Nops N(10,0), Grupods C(10), Contads C(10))

        *-- Os MESMOS dois indices que o metodo de carga de etiquetas do SIGPRCPRBO
        *-- cria. Nao eh enfeite: o cursor placeholder tem de ser IDENTICO ao do
        *-- BO (campos E tags). SIGPRCPRBO.ProcessarLeituraCodigoBarra() e
        *-- ConferenciaAutomatica() fazem "SET ORDER TO TAG CodBarra" antes do
        *-- SEEK (igual ao "Set Order to CodBarra" do Valid legado) e
        *-- ConfirmarConferencia() usa "TAG GruConta" (o "Set Order to GruConta"
        *-- do Ok legado). Sem as tags aqui, o SET ORDER estoura "Table has no
        *-- index order set" FORA de qualquer TRY/CATCH - o usuario ve o
        *-- Program Error CRU do VFP no lugar do dialogo do sistema.
        INDEX ON CodBarra TAG CodBarra
        INDEX ON Grupods + Contads TAG GruConta

        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top               = 140
            .Left              = 133
            .Width             = 534
            .Height            = 207
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .RowHeight         = 17
            .ScrollBars        = 2
            .ReadOnly          = .T.
            .ColumnCount       = 5
            .Visible           = .F.
        ENDWITH

        *-- Propriedades que NAO dependem do cursor (nao sao perdidas quando o
        *-- RecordSource eh reatribuido). Column.ReadOnly vem DEPOIS do
        *-- Grid.ReadOnly acima, senao o do grid sobrescreve o das colunas.
        WITH THIS.grd_4c_Dados.Column1
            .FontSize          = 8
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
        ENDWITH

        WITH THIS.grd_4c_Dados.Column2
            .FontSize          = 8
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
        ENDWITH

        WITH THIS.grd_4c_Dados.Column3
            .FontSize          = 8
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
        ENDWITH

        WITH THIS.grd_4c_Dados.Column4
            .FontSize          = 8
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
        ENDWITH

        WITH THIS.grd_4c_Dados.Column5
            .FontSize          = 8
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
        ENDWITH

        THIS.VincularGrid()
    ENDPROC

    *==========================================================================
    * VincularGrid - Liga a grade ao cursor de baixa. Equivalente ao bloco
    * "with ThisForm.Grade / .RecordSource = 'TmpBaixa' / .ColumnN.ControlSource
    * = 'TmpBaixa.<col>' / .Refresh / EndWith" que o Init legado executa DEPOIS
    * do CarregaBars.
    *
    * Tem de ser um metodo separado (e nao ficar so dentro do ConfigurarGrid)
    * porque o metodo de carga de etiquetas do SIGPRCPRBO faz USE IN + CREATE CURSOR
    * no cursor da grade: o cursor eh DESTRUIDO e recriado a cada carga, o que
    * derruba o binding do Grid. Por isso CarregarDados() chama este metodo
    * depois de cada carga.
    *
    * ORDEM CANONICA obrigatoria: RecordSource -> ControlSource -> Width ->
    * Header1.Caption. Atribuir RecordSource/ControlSource RECALCULA as larguras
    * das colunas para o default (~90) e reseta os captions dos headers, entao
    * Width e Header1.Caption tem de ser reaplicados DEPOIS - senao a grade
    * abre com colunas quadradas e headers "Header1".
    *
    * Larguras/captions/DynamicForeColor EXATOS do SCX legado (Column1..5:
    * 108/108/154/61/75; regra do DynamicForeColor: azul quando QtdeLido <> 0,
    * que eh o "Iif( TmpBaixa.QtdeLido#0, Rgb(0,0,255), Rgb(0,0,0) )" legado).
    *==========================================================================
    PROCEDURE VincularGrid()
        LOCAL loc_cCursor, loc_cCorDinamica

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorBaixa

        IF !USED(loc_cCursor)
            RETURN .F.
        ENDIF

        loc_cCorDinamica = "IIF(" + loc_cCursor + ".QtdeLido <> 0, RGB(0,0,255), RGB(0,0,0))"

        *-- ColumnCount so eh reatribuido se estiver diferente: REDUZIR
        *-- ColumnCount recria os objetos de coluna e destroi configuracao.
        IF THIS.grd_4c_Dados.ColumnCount != 5
            THIS.grd_4c_Dados.ColumnCount = 5
        ENDIF

        THIS.grd_4c_Dados.RecordSource = loc_cCursor

        THIS.grd_4c_Dados.Column1.ControlSource = loc_cCursor + ".CodBarra"
        THIS.grd_4c_Dados.Column2.ControlSource = loc_cCursor + ".CPros"
        THIS.grd_4c_Dados.Column3.ControlSource = loc_cCursor + ".Dopes"
        THIS.grd_4c_Dados.Column4.ControlSource = loc_cCursor + ".Numes"
        THIS.grd_4c_Dados.Column5.ControlSource = loc_cCursor + ".QtdeLido"

        THIS.grd_4c_Dados.Column1.DynamicForeColor = loc_cCorDinamica
        THIS.grd_4c_Dados.Column2.DynamicForeColor = loc_cCorDinamica
        THIS.grd_4c_Dados.Column3.DynamicForeColor = loc_cCorDinamica
        THIS.grd_4c_Dados.Column4.DynamicForeColor = loc_cCorDinamica
        THIS.grd_4c_Dados.Column5.DynamicForeColor = loc_cCorDinamica

        *-- Width DEPOIS do RecordSource/ControlSource (ordem obrigatoria)
        THIS.grd_4c_Dados.Column1.Width = 108
        THIS.grd_4c_Dados.Column2.Width = 108
        THIS.grd_4c_Dados.Column3.Width = 154
        THIS.grd_4c_Dados.Column4.Width = 61
        THIS.grd_4c_Dados.Column5.Width = 75

        *-- Header1.Caption DEPOIS do RecordSource (senao volta a "Header1")
        THIS.grd_4c_Dados.Column1.Header1.Caption = "C" + CHR(243) + "d. Barra"
        THIS.grd_4c_Dados.Column2.Header1.Caption = "Produto"
        THIS.grd_4c_Dados.Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
        THIS.grd_4c_Dados.Column4.Header1.Caption = "N" + CHR(250) + "mero"
        THIS.grd_4c_Dados.Column5.Header1.Caption = "Qtde."

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarDados - Carga da grade. Equivalente a "PROCEDURE carregabars" do
    * legado (SIGPRCPR.SCX), chamado pelo Init legado e por todo caminho que
    * precise repopular a grade.
    *
    * O legado monta TmpBaixa varrendo TmpEnc -> SigOpEtq -> SigMvCab/SigCdOpe;
    * essa logica INTEIRA vive no metodo de carga de etiquetas do SIGPRCPRBO
    * (Fases 1-2), entao aqui o form so: delega a carga, RE-VINCULA a grade (o
    * BO recria o cursor e o binding cai - ver VincularGrid), posiciona no
    * primeiro registro, repinta e ajusta a visibilidade dos controles.
    *
    * Fim do carregabars legado, reproduzido fielmente:
    *   Select TmpBaixa / Go Top
    *   If Eof() / =Messagebox('Nenhuma Etiqueta Selecionada Nesta Operacao!!!', 32, '')
    *   ThisForm.Grade.Visible = Not Eof()   (idem Txt_Leitura/Get_Leitura/Ok/Conferencia)
    *   ThisForm.Get_Leitura.SetFocus
    *
    * O legado NAO aborta a tela quando nao ha etiqueta: apenas avisa e esconde
    * os controles de conferencia, deixando so o Encerrar. Retorna .T. quando
    * ha pelo menos uma etiqueta em aberto.
    *==========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_lTemEtiquetas, loc_cCursor, loc_oErro, loc_lAvisoExibido

        loc_lTemEtiquetas = .F.
        loc_lAvisoExibido = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cCursor = THIS.this_oBusinessObject.this_cCursorBaixa

                *-- A carga pode falhar por parametro/operacao ausente. O BO
                *-- deixa o motivo em this_cMensagemErro; aqui vale MsgAviso
                *-- (validacao de uso, nao erro tecnico) e o fluxo segue para
                *-- esconder os controles, igual ao legado.
                IF !THIS.this_oBusinessObject.CarregarEtiquetasPendentes()
                    IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                        MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lAvisoExibido = .T.
                    ENDIF
                ENDIF

                *-- Re-vincula SEMPRE: a carga de etiquetas fez
                *-- USE IN + CREATE CURSOR e o binding do Grid caiu.
                THIS.VincularGrid()

                IF USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    GO TOP
                    loc_lTemEtiquetas = !EOF(loc_cCursor)
                ENDIF

                *-- Aviso do legado. Suprimido quando o BO ja explicou o
                *-- motivo acima, para nao empilhar dois dialogos (o legado
                *-- exibe UMA mensagem).
                IF !loc_lTemEtiquetas AND !loc_lAvisoExibido
                    MsgAviso("Nenhuma Etiqueta Selecionada Nesta Opera" + ;
                             CHR(231) + CHR(227) + "o!!!", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                ENDIF

                THIS.AjustarVisibilidadePorEtiquetas(loc_lTemEtiquetas)

                *-- Popular o cursor NAO repinta a grade sozinho
                THIS.grd_4c_Dados.Refresh()

                *-- "ThisForm.Get_Leitura.SetFocus" do legado. So com o form JA
                *-- visivel: na primeira carga (dentro do InicializarForm) o
                *-- form ainda nao foi exibido e SetFocus estouraria.
                IF loc_lTemEtiquetas AND THIS.Visible AND ;
                   PEMSTATUS(THIS, "txt_4c_Leitura", 5)
                    IF VARTYPE(THIS.txt_4c_Leitura) = "O" AND THIS.txt_4c_Leitura.Visible
                        THIS.txt_4c_Leitura.SetFocus()
                    ENDIF
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Business Object n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel para carregar as etiquetas."
                MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF

        CATCH TO loc_oErro
            loc_lTemEtiquetas = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSIGPRCPR.CarregarDados")
        ENDTRY

        RETURN loc_lTemEtiquetas
    ENDPROC

    *==========================================================================
    * AjustarVisibilidadePorEtiquetas - reproduz o bloco final do carregabars
    * legado: Grade, Txt_Leitura, Get_Leitura, Ok e Conferencia ficam visiveis
    * SOMENTE quando existe etiqueta em aberto (Visible = Not Eof()). O Sair/
    * Encerrar permanece sempre visivel (o legado nao o esconde), para o
    * usuario poder fechar o dialogo mesmo sem nada a conferir.
    *
    * lbl_4c_Txt_Leitura / txt_4c_Leitura sao criados na Fase 6
    * (ConfigurarCampoLeitura) - o PEMSTATUS antes de tocar cada um foi
    * escrito aqui na Fase 4, antes deles existirem, e continua valendo.
    *==========================================================================
    PROCEDURE AjustarVisibilidadePorEtiquetas(par_lTemEtiquetas)
        LOCAL loc_lVisivel

        loc_lVisivel = par_lTemEtiquetas

        THIS.grd_4c_Dados.Visible = loc_lVisivel

        IF PEMSTATUS(THIS, "cmd_4c_Ok", 5)
            THIS.cmd_4c_Ok.Visible = loc_lVisivel
        ENDIF

        IF PEMSTATUS(THIS, "cmd_4c_Conferencia", 5)
            THIS.cmd_4c_Conferencia.Visible = loc_lVisivel
        ENDIF

        IF PEMSTATUS(THIS, "lbl_4c_Txt_Leitura", 5)
            THIS.lbl_4c_Txt_Leitura.Visible = loc_lVisivel
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_Leitura", 5)
            THIS.txt_4c_Leitura.Visible = loc_lVisivel
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - 3 botoes standalone do legado (Conferencia/Ok/Sair),
    * mesmo padrao de dialogo OPERACIONAL do projeto (ver FormGrupo: Top=3,
    * Width/Height=75, Themes=.T.+DisabledPicture para icone renderizar com
    * Enabled=.F. - regra do projeto sobre standalone CommandButton).
    * Posicoes EXATAS do SCX legado: Conferencia Left=575, Ok Left=650,
    * Sair Left=725.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmd_4c_Conferencia", "CommandButton")
        WITH THIS.cmd_4c_Conferencia
            .Top             = 3
            .Left            = 575
            .Width           = 75
            .Height          = 75
            .Caption         = "\<Conf. Auto"
            .Picture         = gc_4c_CaminhoIcones + "geral_servicos_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_servicos_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Conferencia, "Click", THIS, "BtnConferenciaClick")

        THIS.AddObject("cmd_4c_Ok", "CommandButton")
        WITH THIS.cmd_4c_Ok
            .Top             = 3
            .Left            = 650
            .Width           = 75
            .Height          = 75
            .Caption         = "\<Ok"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "BtnOkClick")

        THIS.AddObject("cmd_4c_Sair", "CommandButton")
        WITH THIS.cmd_4c_Sair
            .Top             = 3
            .Left            = 725
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel          = .T.
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Sair, "Click", THIS, "BtnSairClick")
    ENDPROC

    *==========================================================================
    * BtnConferenciaClick - equivalente ao Click do "Conf. Auto" legado:
    * marca TODAS as etiquetas em aberto como conferidas (delega a
    * SIGPRCPRBO.ConferenciaAutomatica()) e repinta a grade (regra do
    * projeto: popular/alterar cursor da grade NUNCA repinta sozinho).
    *==========================================================================
    PROCEDURE BtnConferenciaClick()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            IF THIS.this_oBusinessObject.ConferenciaAutomatica()
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnOkClick - equivalente ao Click do Ok legado: confirma com o usuario,
    * delega a gravacao em lote a SIGPRCPRBO.ConfirmarConferencia() e, em
    * sucesso, reabilita o form pai e encerra o dialogo (equivalente a
    * "ThisForm.ParentForm.Enabled = .t." + "ThisForm.Release" do legado).
    * Em falha sem exception (ex.: nenhuma etiqueta conferida), o BO deixa a
    * mensagem em this_cMensagemErro e o form exibe via MsgAviso.
    *==========================================================================
    PROCEDURE BtnOkClick()
        LOCAL loc_lSucesso

        IF !MsgConfirma("Confirma a Confer" + CHR(234) + "ncia das Etiquetas?", "Confirmar")
            IF PEMSTATUS(THIS, "txt_4c_Leitura", 5) AND VARTYPE(THIS.txt_4c_Leitura) = "O"
                THIS.txt_4c_Leitura.SetFocus()
            ENDIF
            RETURN
        ENDIF

        loc_lSucesso = .F.
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_lSucesso = THIS.this_oBusinessObject.ConfirmarConferencia()
        ENDIF

        IF loc_lSucesso
            IF VARTYPE(THIS.this_oParent) = "O"
                THIS.this_oParent.Enabled = .T.
            ENDIF
            THIS.Release()
        ELSE
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnSairClick - equivalente ao Click do Sair legado: reabilita o form
    * pai e encerra o dialogo SEM gravar nada.
    *==========================================================================
    PROCEDURE BtnSairClick()
        IF VARTYPE(THIS.this_oParent) = "O"
            THIS.this_oParent.Enabled = .T.
        ENDIF
        THIS.Release()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Recursivo, aplica Visible=.T. em toda
    * hierarquia. Skip: grd_4c_Dados/lbl_4c_Txt_Leitura/txt_4c_Leitura ficam
    * Visible=.F. (legado: so aparecem quando ha etiquetas em aberto - ver
    * ConfigurarGrid/ConfigurarCampoLeitura e AjustarVisibilidadePorEtiquetas,
    * chamado por CarregarDados logo depois desta varredura).
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) = "O"
                IF INLIST(UPPER(loc_oControl.Name), "GRD_4C_DADOS", "LBL_4C_TXT_LEITURA", "TXT_4C_LEITURA")
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - Libera referencias. DODEFAULT no fim (rebuild menu).
    *==========================================================================
    PROCEDURE Destroy()
        *-- Rede de seguranca do SET CONFIRM ON ligado por LeituraWhen: este
        *-- form NAO tem DataSession = 2, entao o SET vale para a sessao
        *-- CORRENTE e ficaria ligado no resto da aplicacao se a tela fosse
        *-- fechada com o foco ainda no campo de leitura (o LostFocus que o
        *-- desliga nao teria rodado).
        SET CONFIRM OFF

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND USED(THIS.this_oBusinessObject.this_cCursorBaixa)
            USE IN (THIS.this_oBusinessObject.this_cCursorBaixa)
        ENDIF

        THIS.this_oBusinessObject = .NULL.
        THIS.this_oParent         = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE
