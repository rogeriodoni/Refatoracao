*==============================================================================
* FormSIGOPins.prg - Selecao de Finalidades / Observacoes
* Migrado de: SIGOPins.SCX  (Tipo: OPERACIONAL - dialogo modal, layout FLAT)
* Herda de: FormBase
*
* Dialogo de selecao chamado por quatro fluxos do legado:
*   - SIGOPINF (informacoes da operacao)  -> pLista informada, pTipo ausente
*   - cadastro de grupos                  -> pTipo = "GRP"
*   - itens da operacao (SIGOPPRO)        -> pTipo = "ITN"
*   - operacao sem lista                  -> observacoes da faixa de SigCdOpe
*
* Legado: Init(pCnx, pLista, pTipo, pCaption, pEdn) publicava pcLista / pcTipo /
* pcChv / pcEDN como variaveis PUBLIC. Aqui os parametros chegam ao Init deste
* form e sao repassados ao SIGOPinsBO (PILAR 3 - sem variavel global).
*
* Layout FLAT: o SCX legado NAO tem PageFrame nem Page. cntSombra (cabecalho),
* cntBotoes (CommandGroup Confirmar/Cancelar), Grade, getObs e chkPular
* penduram DIRETO no form - por isso nao ha PageFrame a configurar aqui.
*==============================================================================

DEFINE CLASS FormSIGOPins AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais - transcritas do dump do legado, secao
    * "PROPRIEDADES DE: SIGOPINS" (tasks\task752\SIGOPins_form_codigo_fonte.txt)
    *
    * DataSession = 1 eh CONTRATO, nao default copiado por descuido: este
    * dialogo le e grava nos cursores do formulario CHAMADOR (crSigOpFnl,
    * TprMvCab, crTpmMvItn). Com datasession privada (2) esses aliases ficariam
    * invisiveis e a confirmacao nao teria onde gravar.
    *
    * Closable = .F. eh transcricao do dump - e a tela continua tendo saida,
    * porque o botao Cancelar do grupo tem Cancel = .T. (atende ESC).
    *--------------------------------------------------------------------------
    this_cMensagemErro = ""
    DataSession  = 1
    ShowWindow = 1
    Width        = 800
    Height       = 600
    BorderStyle  = 2
    AutoCenter   = .T.
    ShowTips     = .T.
    Caption      = "Sele" + CHR(231) + CHR(227) + "o de Finalidades"
    ControlBox   = .F.
    Closable     = .F.
    FontName     = "Verdana"
    FontSize     = 8
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    KeyPreview   = .T.
    TitleBar     = 0
    WindowType   = 1
    AlwaysOnTop  = .T.
    Themes       = .F.

    *--------------------------------------------------------------------------
    * Business Object (SIGOPinsBO)
    *--------------------------------------------------------------------------
    this_oBusinessObject = .NULL.

    *--------------------------------------------------------------------------
    * Parametros recebidos do formulario chamador - equivalentes a pLista /
    * pTipo / pCaption / pEdn do Init legado. Os quatro sao OPCIONAIS: o
    * dialogo tambem eh aberto sem argumento nenhum.
    *
    * As flags this_lPar*Informado reproduzem o Type([pX]) = "C" do legado.
    * Elas sao necessarias porque lista VAZIA ("") ainda eh modo FINALIDADES -
    * so a AUSENCIA do argumento cai no fluxo de observacoes da operacao.
    *--------------------------------------------------------------------------
    this_cParLista   = ""
    this_cParTipo    = ""
    this_cParTitulo  = ""
    this_cParEdn     = ""

    this_lParListaInformada  = .F.
    this_lParTipoInformado   = .F.
    this_lParTituloInformado = .F.
    this_lParEdnInformado    = .F.

    *--------------------------------------------------------------------------
    * Resultado devolvido ao formulario chamador (equivalente as PUBLIC
    * pcChv/listaObs do legado, agora no NIVEL DO FORM).
    *
    * CONTRATO COM O CHAMADOR: o dialogo fecha com Hide(), nao com Release()
    * (ver FecharDialogo()), entao estas duas properties continuam legiveis
    * depois do Show() retornar. Quem abre a tela eh quem libera:
    *
    *   loc_oDlg = CREATEOBJECT("FormSIGOPins", loc_cLista, "GRP")
    *   loc_oDlg.Show()
    *   IF loc_oDlg.this_lConfirmado
    *       loc_cSelecionadas = loc_oDlg.this_cListaSelecionadas
    *   ENDIF
    *
    * this_lConfirmado em .F. depois do Show() significa que o usuario
    * cancelou - eh por isso que o Cancelar tambem fecha por Hide().
    *--------------------------------------------------------------------------
    this_lConfirmado        = .F.
    this_cListaSelecionadas = ""

    *==========================================================================
    * Init - Recebe os parametros do chamador e dispara a inicializacao
    *
    * par_cLista  : lista de codigos ja selecionados (",1,7," ou "")
    * par_cTipo   : "GRP", "ITN" ou ausente
    * par_cTitulo : complemento do Caption do dialogo
    * par_cEdn    : chave Emps+Dopes+Numes (char(29)) da operacao
    *
    * PCOUNT() eh lido AQUI porque este eh o unico lugar onde ele reflete os
    * argumentos deste Init - eh o que distingue argumento AUSENTE de argumento
    * vazio. Os valores sao guardados ANTES do DODEFAULT() porque eh
    * com eles.
    *==========================================================================
    PROCEDURE Init(par_cLista, par_cTipo, par_cTitulo, par_cEdn)
        LOCAL loc_nArgumentos

        loc_nArgumentos = PCOUNT()

        THIS.this_lParListaInformada = (loc_nArgumentos >= 1 AND VARTYPE(par_cLista) = "C")
        IF THIS.this_lParListaInformada
            THIS.this_cParLista = par_cLista
        ENDIF

        THIS.this_lParTipoInformado = (loc_nArgumentos >= 2 AND VARTYPE(par_cTipo) = "C")
        IF THIS.this_lParTipoInformado
            THIS.this_cParTipo = par_cTipo
        ENDIF

        THIS.this_lParTituloInformado = (loc_nArgumentos >= 3 AND VARTYPE(par_cTitulo) = "C")
        IF THIS.this_lParTituloInformado
            THIS.this_cParTitulo = par_cTitulo
        ENDIF

        THIS.this_lParEdnInformado = (loc_nArgumentos >= 4 AND VARTYPE(par_cEdn) = "C")
        IF THIS.this_lParEdnInformado
            THIS.this_cParEdn = par_cEdn
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Instancia o BO e monta a estrutura base do dialogo
    *
    * Legado: "This.poDataMgr = pCnx". Na arquitetura nova a conexao eh o handle
    * global gnConnHandle e todo o SQL fica encapsulado no SIGOPinsBO.
    *
    * Os argumentos ausentes sao repassados como .F. (logico) ao BO: eh
    * exatamente o que o legado via em Type([pLista]) para um parametro nao
    * informado, e eh assim que SIGOPinsBO.Init distingue ausente de vazio.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SIGOPinsBO", ;
                IIF(THIS.this_lParListaInformada,  THIS.this_cParLista,  .F.), ;
                IIF(THIS.this_lParTipoInformado,   THIS.this_cParTipo,   .F.), ;
                IIF(THIS.this_lParTituloInformado, THIS.this_cParTitulo, .F.), ;
                IIF(THIS.this_lParEdnInformado,    THIS.this_cParEdn,    .F.))

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Fundo do form (legado: Picture = ..\framework\imagens\...)
                THIS.ConfigurarAparenciaBase()

                *-- Faixa cinza do cabecalho (cntSombra do legado). Criada como
                *-- PRIMEIRO AddObject: o grupo de botoes fica em Top = -2,
                *-- dentro da area da faixa, e precisa ser desenhado por cima.
                THIS.ConfigurarCabecalho()

                *-- Grupo de botoes do dialogo (cntBotoes do legado)
                THIS.ConfigurarContainerBotoes()

                *-- Grade de observacoes (Grade do legado). Criada DEPOIS do
                *-- grupo de botoes, na mesma ordem do SCX (cntSombra,
                *-- cntBotoes, Grade, getObs, chkPular).
                THIS.ConfigurarGradeObservacoes()

                *-- Campo de texto da observacao corrente (getObs do legado).
                *-- Criado DEPOIS da grade, na mesma ordem do SCX.
                THIS.ConfigurarCampoObservacao()

                *-- CheckBox "Pular Linhas" (chkPular do legado). Criado por
                *-- ULTIMO, na mesma ordem do SCX (cntSombra, cntBotoes,
                *-- Grade, getObs, chkPular).
                THIS.ConfigurarCheckBoxPular()

                *-- BINDEVENTs dos botoes e da grade - todos os controles ja
                *-- existem neste ponto (cmg_4c_Botoes/grd_4c_Dados/
                *-- chk_4c_Pular foram criados acima).
                THIS.VincularEventos()

                *-- Estado do BO -> controles: Caption do form, os dois labels
                *-- da faixa e a opcao "Pular Linhas". Roda DEPOIS do
                *-- ConfigurarCheckBoxPular() (que cria o controle) e ANTES do
                *-- CarregarLista(), igual a ordem do Init legado, que resolve
                *-- o titulo antes de consultar as observacoes.
                THIS.BOParaForm()

                *-- Carga da lista: no legado isso esta DENTRO do Init e um
                *-- SELECT que falha devolve .F., fechando a tela. Mesma
                *-- semantica aqui.
                IF THIS.CarregarLista()
                    loc_lSucesso = .T.
                ELSE
                    loc_lSucesso = .F.
                ENDIF

                THIS.TornarControlesVisiveis()

                *-- Legado, fim do Init: This.Refresh / Grade.Column1.SetFocus
                *-- / Grade.Column1.fwcheckbox1.SetFocus / Grade.AfterRowColChange().
                *-- So depois do TornarControlesVisiveis(): os controles criados
                *-- por AddObject nascem Visible = .F., e SetFocus em controle
                *-- invisivel estoura.
                IF loc_lSucesso
                    THIS.PosicionarAberturaInicial()
                ENDIF
            ELSE
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel criar o objeto " + ;
                    "de neg" + CHR(243) + "cio SIGOPinsBO.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inicializar FormSIGOPins: " + loc_oErro.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarAparenciaBase - Fundo do dialogo
    * Legado: Picture = ..\framework\imagens\new_background.jpg
    * O caminho sai de gc_4c_CaminhoFramework (config.prg), nunca montado a
    * partir de gc_4c_CaminhoBase.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAparenciaBase()
        THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Faixa cinza do titulo (cntSombra do legado)
    *
    * Dump: cntSombra  Top = 0, Left = 0, Width = 800, Height = 80,
    *                  BorderWidth = 0, BackColor = 100,100,100
    *       lblSombra  Tahoma 18 bold, WordWrap, Alignment = 0, BackStyle = 0,
    *                  Top = 18, Left = 10, Width = 769, Height = 40,
    *                  ForeColor = 0,0,0        (sombra preta, desenhada antes)
    *       lblTitulo  idem, Top = 17, Height = 46, ForeColor = 255,255,255
    *
    * Branco no lblTitulo esta CORRETO: a faixa eh container OPACO escuro.
    * AutoSize = .F. nos dois labels porque AutoSize eh no-op em Label criado
    * por AddObject - a largura real vem do Width transcrito do dump.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .AutoSize      = .F.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .Top           = 18
            .Left          = 10
            .Width         = 769
            .Height        = 40
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = THIS.Caption
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .AutoSize    = .F.
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .Top         = 17
            .Left        = 10
            .Width       = 769
            .Height      = 46
            .ForeColor   = RGB(255, 255, 255)
            .Caption     = THIS.Caption
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainerBotoes - Grupo de botoes do dialogo (cntBotoes)
    *
    * Dump: cntBotoes  CommandGroup, ButtonCount = 2, AutoSize = .T.,
    *                  BackStyle = 0, BorderStyle = 0, Value = 0,
    *                  Top = -2, Left = 643, Width = 160, Height = 85,
    *                  SpecialEffect = 1, BorderColor = 136,189,188,
    *                  Themes = .F., TabIndex = 2
    *
    * ButtonCount vem PRIMEIRO para os Buttons(1..2) existirem antes de
    * qualquer ajuste, e a geometria vem por ULTIMO para prevalecer sobre o
    * recalculo do AutoSize.
    *
    * O nome eh cmg_4c_Botoes - canonico do projeto para CommandGroup. O
    * obj_4c_ do mapeamento.json vem do prefixo generico que o
    * GeradorMapeamento usa para tipo nao reconhecido, nao do padrao.
    *
    * O grupo NAO recebe ForeColor: CommandGroup nao possui essa propriedade
    * (atribuir derrubaria o Init). A cor fica em cada Buttons(N).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerBotoes()
        LOCAL loc_oGrupo

        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")

        *-- Variavel local em vez de WITH THIS.cmg_4c_Botoes: o grupo foi
        *-- criado por AddObject, e configurar membro dele por caminho
        *-- relativo dentro de WITH aninhado faz o VFP9 DESCARTAR em
        *-- silencio as propriedades dos Buttons (Caption/Picture ficam sem
        *-- efeito). Com o caminho explicito numa variavel, o WITH aninhado
        *-- de .Buttons(N) eh seguro - Buttons eh collection, nao AddObject.
        loc_oGrupo = THIS.cmg_4c_Botoes

        WITH loc_oGrupo
            *-- ButtonCount PRIMEIRO: os Buttons(1..2) precisam existir
            *-- antes de qualquer ajuste neles.
            .ButtonCount   = 2

            *--------------------------------------------------------------
            * Buttons(1) = Command1 do dump = btnSair ("Cancelar")
            *
            * Cancel = .T. eh o que da saida a tela, porque o form tem
            * Closable = .F. e TitleBar = 0 (o ESC cai aqui).
            * O "\<" do Caption eh o marcador de tecla de acesso do VFP.
            *
            * Fica a DIREITA (Left = 80) e o Confirmar a esquerda (Left = 5)
            * - eh a ordem do SCX, nao descuido de transcricao.
            *--------------------------------------------------------------
            WITH .Buttons(1)
                .Top           = 5
                .Left          = 80
                .Height        = 75
                .Width         = 75
                .FontName      = "Comic Sans MS"
                .FontSize      = 8
                .FontBold      = .T.
                .FontItalic    = .T.
                .WordWrap      = .T.
                .Caption       = "\<Cancelar"
                .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel        = .T.
                .MousePointer  = 15
                .TabIndex      = 2
                .ToolTipText   = "[Esc] Encerrar"
                .SpecialEffect = 0
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
                .Visible       = .T.
            ENDWITH

            *--------------------------------------------------------------
            * Buttons(2) = Command2 do dump = btnConfirmar ("Confirmar")
            * Dump nao declara SpecialEffect neste botao (so no btnSair).
            *--------------------------------------------------------------
            WITH .Buttons(2)
                .Top          = 5
                .Left         = 5
                .Height       = 75
                .Width        = 75
                .FontName     = "Comic Sans MS"
                .FontSize     = 8
                .FontBold     = .T.
                .FontItalic   = .T.
                .WordWrap     = .T.
                .Caption      = "\<Confirmar"
                .Picture      = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .MousePointer = 15
                .TabIndex     = 1
                .ToolTipText  = "Confirmar a Sele" + CHR(231) + CHR(227) + "o"
                .ForeColor    = RGB(90, 90, 90)
                .BackColor    = RGB(255, 255, 255)
                .Themes       = .F.
                .Visible      = .T.
            ENDWITH

            *-- Propriedades do GRUPO. Vem depois dos Buttons porque
            *-- AutoSize = .T. recalcula a caixa a partir da geometria dos
            *-- botoes internos; a geometria explicita do dump fecha o bloco
            *-- e prevalece.
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = 0
            .TabIndex      = 2
            .AutoSize      = .T.
            .Top           = -2
            .Left          = 643
            .Width         = 160
            .Height        = 85
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGradeObservacoes - Grade de observacoes (Grade do legado)
    *
    * Dump: Grade  fwgrade, ColumnCount = 2, Tahoma 8, HeaderHeight = 22,
    *              Top = 88, Left = 54, Width = 608, Height = 297,
    *              ReadOnly = .F., RecordMark = .F., RowHeight = 16,
    *              ScrollBars = 2, TabIndex = 1, Visible = .T.
    *
    *       Column1 (marcacao)  Tahoma 8, Alignment = 2, ColumnOrder = 1,
    *              Width = 23, Movable = .F., Resizable = .F.,
    *              ReadOnly = .F., Sparse = .F., Format = "K!",
    *              ForeColor = 0,0,0
    *       Column1.Header1  Tahoma 8, Alignment = 2, Caption = "",
    *              ForeColor = 90,90,90, Picture = checkbx.bmp
    *       Column1.fwcheckbox1  Alignment = 0, Centered = .T.,
    *              BackStyle = 0, Caption = "", Visible = .T.,
    *              ReadOnly = .F.
    *
    *       Column2 (descricao)  Tahoma 8, ColumnOrder = 2, Width = 562,
    *              Movable = .F., Resizable = .F., ReadOnly = .F.
    *       Column2.Header1  Tahoma 8, Alignment = 2,
    *              Caption = "Observacoes", ForeColor = 90,90,90
    *       Column2.Text1  Tahoma 8, BorderStyle = 0, Margin = 0,
    *              ReadOnly = .F., ForeColor = 0,0,0, BackColor = 255,255,255
    *
    * NAO transcritos: Column2.InputMask = "" e Column2.Text1.InputMask = ""
    * sao override VAZIO do Form Designer, nao mascara.
    *
    * Aqui ficam SO as propriedades que nao dependem de dado. O bind
    * (RecordSource / ControlSource / Width / Header1.Caption) fica em
    * VincularGrade(), chamado por CarregarLista() com o cursor ja
    * populado: Column.ControlSource de cursor inexistente derruba o Init.
    *
    * ColumnCount eh definido UMA vez, aqui - esta grade nunca troca de
    * numero de colunas, e reduzir ColumnCount depois destruiria o CheckBox
    * criado por AddObject na Column1.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGradeObservacoes()
        LOCAL loc_oGrade

        THIS.AddObject("grd_4c_Dados", "Grid")

        loc_oGrade = THIS.grd_4c_Dados

        WITH loc_oGrade
            .ColumnCount  = 2
            .FontName     = "Tahoma"
            .FontSize     = 8
            .HeaderHeight = 22
            .RowHeight    = 16
            .ScrollBars   = 2
            .Top          = 88
            .Left         = 54
            .Width        = 608
            .Height       = 297
            .TabIndex     = 1

            *-- Grid.ReadOnly propaga para as colunas e sobrescreve o
            *-- ReadOnly delas: tem de vir ANTES de Column<N>.ReadOnly.
            .ReadOnly     = .F.

            *-- RecordMark do dump; DeleteMark nao aparece no dump mas as
            *-- grades criadas por AddObject em form OPERACIONAL ficam com
            *-- as duas barras laterais desligadas.
            .RecordMark   = .F.
            .DeleteMark   = .F.

            .Visible      = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Column1 - marcacao (CheckBox)
        *
        * Column.AddObject CRIA o controle e NAO o exibe: sem
        * CurrentControl a coluna continua desenhando o Text1 dela e o
        * usuario ve 0/1 como texto, sem como marcar. Sparse = .F. eh o que
        * faz o CheckBox aparecer em TODAS as linhas, nao so na corrente.
        *
        * As 7 propriedades explicitas do CheckBox (Alignment/ReadOnly/
        * Visible/Top/Left/Height/Width) sao o padrao do projeto: sem elas o
        * controle desenha o estado certo mas a area clicavel nao coincide
        * com o retangulo visual e o clique nao pega.
        *----------------------------------------------------------------------
        WITH loc_oGrade.Column1
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Alignment   = 2
            .ColumnOrder = 1
            .Movable     = .F.
            .Resizable   = .F.
            .Sparse      = .F.
            .Format      = "K!"
            .ForeColor   = RGB(0, 0, 0)
            .ReadOnly    = .F.
            .Visible     = .T.

            .AddObject("chk_4c_Selecao", "CheckBox")
            .chk_4c_Selecao.Caption   = ""
            .chk_4c_Selecao.Alignment = 0
            .chk_4c_Selecao.Centered  = .T.
            .chk_4c_Selecao.BackStyle = 0
            .chk_4c_Selecao.ReadOnly  = .F.
            .chk_4c_Selecao.Visible   = .T.
            .chk_4c_Selecao.Top       = 9
            .chk_4c_Selecao.Left      = 2
            .chk_4c_Selecao.Height    = 17
            .chk_4c_Selecao.Width     = 22

            .CurrentControl = "chk_4c_Selecao"
        ENDWITH

        WITH loc_oGrade.Column1.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = ""
            .ForeColor = RGB(90, 90, 90)
            .Picture   = gc_4c_CaminhoIcones + "CHECKBX.BMP"
        ENDWITH

        *----------------------------------------------------------------------
        * Column2 - descricao da observacao
        *
        * ReadOnly = .F. eh transcricao do dump: no legado o bloqueio de
        * digitacao desta celula nao vem de ReadOnly, vem do
        * "Return .f." no When do Column2.Text1 (com o GotFocus devolvendo o
        * foco ao CheckBox) - comportamento que entra junto com os eventos.
        *----------------------------------------------------------------------
        WITH loc_oGrade.Column2
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ColumnOrder = 2
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .F.
            .Visible     = .T.
        ENDWITH

        WITH loc_oGrade.Column2.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Observa" + CHR(231) + CHR(245) + "es"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Text1 ja nasce com a Column: so configurar, nunca AddObject.
        WITH loc_oGrade.Column2.Text1
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .F.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCampoObservacao - Campo de texto da observacao corrente
    *
    * Legado: objeto "getObs", Class = fwmemo, BaseClass = editbox, filho
    * DIRETO da Form (SIGOPINS nao tem PageFrame nem Page - layout FLAT), com
    * ControlSource = [LocalObs.Observas].
    *
    * Nao eh campo de digitacao: eh a VISTA do texto completo da observacao
    * da linha corrente da grade. Por isso o legado o liga ao MESMO cursor da
    * grade e manda "ThisForm.getObs.Refresh" no AfterRowColChange - andar na
    * grade troca o texto exibido aqui.
    *
    * Propriedades transcritas do dump, secao "PROPRIEDADES DE:
    * SIGOPINS.getObs" (tasks\task752\SIGOPins_form_codigo_fonte.txt):
    *   FontName = "Tahoma", Format = "K!", Height = 180, Left = 54,
    *   SpecialEffect = 1, TabIndex = 4, Top = 391, Width = 608,
    *   NullDisplay = "  "
    *
    * Top/Left sao transcritos CRUS, sem a compensacao +29 dos forms CRUD:
    * aqui nao ha PageFrame com Top = -29, o controle pendura direto na Form.
    * Confere com o form 800x600: 54+608 = 662 e 391+180 = 571.
    *
    * FontSize / DisabledBackColor / DisabledForeColor / Themes vem da CLASSE
    * fwmemo (docs\FRAMEWORK_class_codigo_fonte.txt) - o SCX nao os sobrescreve,
    * entao ficam explicitos aqui porque AddObject cria EditBox puro, que nao
    * herda nada do framework legado.
    *
    * NAO transcritos: BackColor / ForeColor / ScrollBars / ReadOnly - nem o
    * SCX nem a classe fwmemo os declaram, e inventar valor para eles seria
    * desviar do legado.
    *
    * O ControlSource NAO entra aqui: o cursor da lista ainda nao existe
    * quando este metodo roda (ConfigurarCampoObservacao vem antes de
    * CarregarLista) e ControlSource de alias inexistente derruba o Init com
    * "Alias not found". O bind fica em VincularGrade(), junto com o da grade,
    * exatamente como no Init legado.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCampoObservacao()
        THIS.AddObject("obj_4c_GetObs", "EditBoxMemoSIGOPins_4c_")

        WITH THIS.obj_4c_GetObs
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Top               = 391
            .Left              = 54
            .Width             = 608
            .Height            = 180
            .SpecialEffect     = 1
            .Format            = "K!"
            .NullDisplay       = "  "
            .TabIndex          = 4
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .Themes            = .F.
            .Visible           = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCheckBoxPular - CheckBox "Pular Linhas" (chkPular do legado)
    *
    * Dump, secao "PROPRIEDADES DE: SIGOPINS.chkPular":
    *   Top = 220, Left = 671, AutoSize = .T., Alignment = 0,
    *   Caption = "Pular Linhas", Value = .T., TabIndex = 3,
    *   ForeColor = 90,90,90
    *
    * AutoSize = .T. NAO entra - eh no-op em CheckBox criado por
    * AddObject (fica no 100x17 do default), entao Width/Height vem
    * explicito para a legenda nao ficar cortada.
    *
    * Sem ControlSource: eh lido direto por valor em BtnConfirmarClick
    * (equivalente a "Thisform.chkPular.Value" do legado), nao precisa
    * de bind nem de conversao numerica (regra de CheckBox.Value
    * numerico vale para checkbox ligado a coluna - este eh toggle puro
    * de UI).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCheckBoxPular()
        THIS.AddObject("chk_4c_Pular", "CheckBox")

        WITH THIS.chk_4c_Pular
            .Top       = 220
            .Left      = 671
            .Width     = 150
            .Height    = 17
            .Alignment = 0
            .Caption   = "Pular Linhas"
            .Value     = 1
            .TabIndex  = 3
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * VincularEventos - BINDEVENTs dos botoes e da grade
    *
    * Legado:
    *   cntBotoes.btnSair.Click / cntBotoes.btnConfirmar.Click (cada
    *       botao do CommandGroup tem handler PROPRIO)
    *   Grade.AfterRowColChange -> ThisForm.getObs.Refresh
    *   Grade.Column1.Header1.Click -> toggle (ver HeaderSelecaoClick)
    *   Grade.Column2.Text1.When -> Return .f. / GotFocus -> devolve
    *       foco ao CheckBox da Column1
    *
    * Buttons(N) sao objetos de COLECAO (nao AddObject): BINDEVENT neles
    * eh seguro, diferente de WITH aninhado (regra sobre ForeColor de
    * grupo descartado em silencio).
    *==========================================================================
    PROTECTED PROCEDURE VincularEventos()
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnCancelarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnConfirmarClick")

        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
        BINDEVENT(THIS.grd_4c_Dados.Column1.Header1, "Click", THIS, "HeaderSelecaoClick")

        *----------------------------------------------------------------------
        * CheckBox de marcacao da Column1 - os QUATRO eventos do toggle manual.
        *
        * CheckBox que eh CurrentControl de uma Column NAO alterna pelo binding
        * nativo: ele desenha em todas as linhas e ate recebe foco, mas clicar
        * ou teclar Espaco/Enter nao muda o valor. Como marcar observacao eh a
        * UNICA funcao deste dialogo, sem estes handlers a tela fica inutil.
        *
        * MouseDown e Click existem para SUPRIMIR o toggle nativo (sem eles o
        * valor pode alternar duas vezes e nada muda na tela); quem de fato
        * grava eh o ChkSelecaoKeyPress, chamado pelo MouseUp com a tecla 13.
        *
        * O legado nao precisava disso: a fwcheckbox do framework.vcx declara
        * so When e GotFocus, e a coluna Selecao do LocalObs alternava pelo
        * binding da classe. Aqui o controle eh CheckBox puro criado por
        * AddObject sobre coluna NUMERICA (selecao N(1,0)) - o caso em que o
        * toggle manual eh a forma segura.
        *
        * Registrado aqui porque ConfigurarGradeObservacoes() eh o UNICO ponto
        * que cria o chk_4c_Selecao: VincularGrade() apenas reafirma
        * CurrentControl/Sparse e nunca reatribui ColumnCount, entao o controle
        * (e com ele estes vinculos) sobrevive a cada recarga da lista.
        *----------------------------------------------------------------------
        IF PEMSTATUS(THIS.grd_4c_Dados.Column1, "chk_4c_Selecao", 5)
            BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Selecao, "KeyPress", ;
                THIS, "ChkSelecaoKeyPress")
            BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Selecao, "MouseUp", ;
                THIS, "ChkSelecaoMouseUp")
            BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Selecao, "MouseDown", ;
                THIS, "ChkSelecaoMouseDown")
            BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Selecao, "Click", ;
                THIS, "ChkSelecaoClick")
        ENDIF

        BINDEVENT(THIS.grd_4c_Dados.Column2.Text1, "When", THIS, "ColDescricaoWhen")
        BINDEVENT(THIS.grd_4c_Dados.Column2.Text1, "GotFocus", THIS, "ColDescricaoGotFocus")
    ENDPROC

    *==========================================================================
    * EVENTOS PRINCIPAIS DOS BOTOES
    *
    * Este dialogo NAO tem barra CRUD, e por isso nao existem aqui os
    * BtnIncluirClick / BtnAlterarClick / BtnVisualizarClick / BtnExcluirClick
    * dos forms de cadastro. O dump do legado prova a ausencia por cinco
    * caminhos independentes (tasks\task752\SIGOPins_form_codigo_fonte.txt):
    *
    *   - Class/BaseClass do form eh "form" PURO, nao frmcadastro
    *   - nao existe Grupo_Op (a barra CRUD do framework)
    *   - nao existe pcEscolha (a variavel de MODO do frmcadastro)
    *   - nenhum objeto chamado btn/cmd/Command + Incluir|Alterar|Visualizar|
    *     Excluir
    *   - nenhuma chamada <X>.Click com esses verbos
    *
    * A superficie de botao do legado sao os DOIS membros do CommandGroup
    * cntBotoes - Command1 "btnSair" (\<Cancelar) e Command2 "btnConfirmar"
    * (\<Confirmar) -, e cada um tem o seu handler abaixo, nomeado pela ACAO
    * que o Caption anuncia e o corpo do Click confirma: BtnCancelarClick
    * (so fecha) e BtnConfirmarClick (grava). Criar os quatro nomes CRUD
    * exigiria inventar botao que o legado nao tem (viola o PILAR 1) ou deixar
    * metodo sem corpo (viola a regra de completude do projeto).
    *
    * Pelo mesmo motivo nao existem aqui BtnBuscarClick nem BtnEncerrarClick:
    * o dump nao tem botao de busca (quem filtra a lista eh o parametro
    * recebido do chamador, nao a tela) e o botao de saida eh o Cancelar acima.
    * Tambem nao ha AjustarBotoesPorModo / HabilitarCampos: este dialogo nao
    * tem MODO - os dois botoes ficam habilitados do inicio ao fim, nao ha
    * pcEscolha no SCX e nenhum controle troca de Enabled/ReadOnly em runtime.
    * E nao ha LimparCampos porque a tela nunca volta ao estado inicial: ela
    * abre com a lista carregada, o usuario marca e ela fecha.
    *
    * Os demais eventos desta secao sao os do SCX, objeto a objeto:
    *   Grade.AfterRowColChange          -> GrdDadosAfterRowColChange
    *   Grade.Column1.Header1.Click      -> HeaderSelecaoClick
    *   Grade.Column2.Text1.When         -> ColDescricaoWhen
    *   Grade.Column2.Text1.GotFocus     -> ColDescricaoGotFocus
    * mais o toggle manual do CheckBox da Column1 (ChkSelecao*), que o
    * binding nativo do VFP9 nao entrega - ver VincularEventos().
    *==========================================================================

    *==========================================================================
    * BtnCancelarClick - Command1 do dump, "\<Cancelar"
    *
    * Legado: "PROCEDURE btnSair.Click / ThisForm.Release"
    *
    * O handler leva o nome da ACAO, nao o Name do objeto legado: o SCX chama
    * esse botao de "btnSair", mas o Caption que o usuario LE eh "\<Cancelar"
    * (e o ToolTipText eh "[Esc] Encerrar"). O corpo do Click confirma a
    * leitura - "ThisForm.Release" e mais nada, sem gravar e sem devolver valor
    * ao chamador -, entao este eh o Cancelar do dialogo: abandona a selecao
    * feita na grade e fecha, deixando this_lConfirmado em .F. para o
    * formulario CHAMADOR distinguir cancelamento de confirmacao.
    *
    * Eh tambem a UNICA saida da tela, porque o form tem Closable = .F. e
    * TitleBar = 0: quem atende o ESC eh o Cancel = .T. deste botao.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.FecharDialogo()
    ENDPROC

    *==========================================================================
    * FecharDialogo - Funil de fechamento dos DOIS botoes
    *
    * Legado: "ThisForm.Release" no fim do btnSair.Click E do btnConfirmar.Click.
    *
    * Aqui fecha por Hide(), e nao por Release(), porque form object do VFP9
    * NAO segue refcount: Release() destroi o objeto mesmo com o chamador
    * segurando a referencia, e a leitura seguinte estoura "<var> is not an
    * object". Medido neste proprio dialogo (automation\tmp752\probe752f8b):
    * com Release() no Confirmar, ler this_cListaSelecionadas depois do
    * BtnConfirmarClick falha - o dialogo se destruia ANTES de entregar o
    * resultado que ele existe para produzir.
    *
    * Hide() em form modal tambem devolve o Show(), entao para o usuario a tela
    * fecha igual: o PILAR 1 fica preservado e muda so o tempo de vida do
    * objeto, que eh PILAR 3. Quem abre a tela chama Release() depois de ler
    * (ver o contrato declarado nas properties de resultado) - eh o mesmo
    * desenho que o FormBuscaAuxiliar do projeto ja adota.
    *
    * Os dois botoes compartilham este funil para a decisao e o motivo dela
    * ficarem em UM lugar so: o Cancelar tambem precisa do objeto vivo, porque
    * eh por this_lConfirmado = .F. que o chamador reconhece o cancelamento.
    *==========================================================================
    PROCEDURE FecharDialogo()
        THIS.Hide()
    ENDPROC

    *==========================================================================
    * ValidarSelecao - Guarda de tela do btnConfirmar.Click legado
    *
    * Legado (btnConfirmar.Click):
    *   Thisform.Grade.Refresh
    *   Select LocalObs / Go Top In LocalObs
    *   Thisform.Grade.Refresh
    *   If Vartype(pcLista) <> 'C'
    *       Locate For Selecao = 1
    *       If Eof([LocalObs])
    *           =Messagebox([Nenhuma Observac-cedilhaa-tildeo Foi Selecionada!], 0+48, [Atenc-cedilhaa-tildeo])
    *           Go Top In LocalObs
    *           Thisform.Grade.Column1.SetFocus
    *           Return .F.
    *       Endif
    *
    * A CONDICAO QUE CERCA A VALIDACAO EH PARTE DELA: o legado so exige linha
    * marcada no fluxo de OPERACAO (pLista AUSENTE, Vartype(pcLista) <> 'C').
    * No fluxo de FINALIDADES (GRP/ITN/SIGOPINF, pLista informado) nao ha
    * validacao nenhuma - zero linha marcada significa "remover todas as
    * associacoes", que eh exatamente o que ConfirmarFluxoGrupo /
    * ConfirmarFluxoItem do BO gravam ao apagar o que sobrou no cursor de
    * finalidades. Validar ali bloquearia uma gravacao legitima.
    *
    * Mora no FORM, e nao no BO, porque o que ela faz quando recusa eh de
    * TELA: reposicionar o cursor no topo e devolver o foco a coluna de
    * marcacao, para o usuario corrigir e tentar de novo sem o dialogo
    * fechar. O guard equivalente de ConfirmarFluxoOperacao continua no BO
    * como defesa para quem chamar o BO sem passar por esta tela.
    *
    * SetFocus eh pulado em modo de teste pelo mesmo motivo de
    * PosicionarAberturaInicial: controle sem tela real estoura no SetFocus.
    *
    * Devolve .T. quando nao ha o que validar ou quando ha ao menos uma
    * observacao marcada; .F. (ja com o aviso exibido) quando o fluxo de
    * operacao nao tem nenhuma.
    *==========================================================================
    PROCEDURE ValidarSelecao()
        LOCAL loc_cCursor, loc_lTemSelecao

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Refresh()
        ENDIF

        loc_cCursor = "cursor_4c_Lista"
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cCursor = THIS.this_oBusinessObject.this_cCursorLista
        ENDIF

        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
            GO TOP
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Refresh()
        ENDIF

        *-- Fluxo de FINALIDADES: o legado nao valida - nada a recusar.
        IF THIS.this_lParListaInformada
            RETURN .T.
        ENDIF

        *-- Sem o cursor da lista nao ha como afirmar que falta selecao: a
        *-- falha tecnica eh reportada por ConfirmarSelecao() do BO, que tem
        *-- a mensagem certa para cursor indisponivel.
        IF !USED(loc_cCursor)
            RETURN .T.
        ENDIF

        SELECT (loc_cCursor)
        LOCATE FOR selecao = 1
        loc_lTemSelecao = !EOF()

        IF loc_lTemSelecao
            RETURN .T.
        ENDIF

        MsgAviso("Nenhuma Observa" + CHR(231) + CHR(227) + "o Foi Selecionada!", ;
            "Aten" + CHR(231) + CHR(227) + "o")

        SELECT (loc_cCursor)
        GO TOP

        IF !THIS.EstaEmModoTeste() AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.SetFocus()
        ENDIF

        RETURN .F.
    ENDPROC

    *==========================================================================
    * BtnConfirmarClick - Command2 do dump (btnConfirmar, "\<Confirmar")
    *
    * Legado:
    *   Thisform.Grade.Refresh / Select LocalObs / Go Top In LocalObs /
    *       Thisform.Grade.Refresh
    *   <toda a logica de gravacao, delegada a SIGOPinsBO.ConfirmarSelecao()>
    *   Thisform.Release
    *
    * this_lFalhaValidacao do BO distingue a UNICA validacao deste
    * dialogo ("Nenhuma Observacao Foi Selecionada!", MsgAviso no
    * legado) de falha tecnica (cursor do chamador indisponivel,
    * MsgErro) - regra do projeto sobre MsgAviso vs MsgErro.
    *
    * So libera o dialogo (Release) quando ConfirmarSelecao() devolve
    * .T.: em caso de falha o legado "Return .F." sem fechar a tela, e
    * o usuario corrige a selecao e tenta de novo.
    *==========================================================================
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_oErro, loc_lSucesso, loc_cCursor

        *-- Guarda de tela do legado. Fica FORA do TRY porque RETURN dentro
        *-- de TRY/CATCH eh proibido (regra #1). ValidarSelecao() ja faz o
        *-- Grade.Refresh / Select / Go Top que abre o btnConfirmar.Click
        *-- legado, por isso o bloco nao se repete dentro do TRY.
        IF !THIS.ValidarSelecao()
            RETURN
        ENDIF

        *-- Transfere a opcao da tela para o BO ANTES de confirmar. Fica FORA
        *-- do TRY pelo mesmo motivo do ValidarSelecao(): o RETURN de guarda
        *-- nao pode morar dentro de TRY/CATCH (regra #1). Falhando aqui nao
        *-- se grava nada - o separador de linhas sairia errado no texto.
        IF !THIS.FormParaBO()
            RETURN
        ENDIF

        TRY
            loc_cCursor = THIS.this_oBusinessObject.this_cCursorLista

            loc_lSucesso = THIS.this_oBusinessObject.ConfirmarSelecao()

            IF loc_lSucesso
                *-- Cachear o resultado ANTES de fechar: o Destroy libera o BO,
                *-- e com Hide() ele passa a rodar so quando o chamador der o
                *-- Release - entao a copia tem de estar feita aqui.
                THIS.this_lConfirmado        = .T.
                THIS.this_cListaSelecionadas = THIS.this_oBusinessObject.this_cListaSelecionadas

                THIS.FecharDialogo()
            ELSE
                IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemFalha)
                    IF THIS.this_oBusinessObject.this_lFalhaValidacao
                        MsgAviso(THIS.this_oBusinessObject.this_cMensagemFalha, ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        MsgErro(THIS.this_oBusinessObject.this_cMensagemFalha, ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                    ENDIF
                ENDIF

                *-- Legado: "Go Top In LocalObs / Thisform.Grade.Column1.SetFocus"
                IF USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    GO TOP
                ENDIF
                THIS.grd_4c_Dados.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao confirmar a sele" + CHR(231) + CHR(227) + "o: " + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Aten" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GrdDadosAfterRowColChange - Legado: "ThisForm.getObs.Refresh"
    * A caixa de observacao acompanha a linha corrente da grade.
    *==========================================================================
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        IF PEMSTATUS(THIS, "obj_4c_GetObs", 5)
            THIS.obj_4c_GetObs.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * HeaderSelecaoClick - Column1.Header1.Click do legado
    *
    * Legado:
    *   If Used([LocalBusLin])
    *       Select LocalBusLin
    *       If (ThisForm.Grade.Seleciona.Header1.Tag = [X]) ...
    *   EndIf
    *   ThisForm.Grade.Refresh
    *
    * "LocalBusLin" e o membro "Seleciona" (a Grade so tem Column1/
    * Column2) NUNCA sao criados em lugar nenhum deste SCX - e vestigio
    * de outro template copiado para este form. O guard USED() sempre
    * falha, entao o UNICO efeito observavel, nos dois sistemas, eh o
    * Refresh final. Transcrito fielmente: nada alem dele executa.
    *==========================================================================
    PROCEDURE HeaderSelecaoClick()
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * ChkSelecaoKeyPress - Marca/desmarca a observacao da linha corrente
    *
    * Este eh o metodo que de fato grava a marcacao: o MouseUp delega a ele
    * com a tecla 13, e MouseDown/Click so suprimem o toggle nativo.
    *
    * Alterna a coluna "selecao" (N(1,0)) do cursor da lista, que eh o
    * "0 as Selecao" do SELECT legado e o campo que BtnConfirmarClick le
    * depois em "Locate For Selecao = 1".
    *
    * 13 (Enter) e 32 (Espaco) sao as teclas que o VFP usa para acionar
    * CheckBox; qualquer outra sai SEM NODEFAULT, para a navegacao normal
    * da grade (setas, Tab, PgDn) continuar funcionando.
    *
    * O cursor eh READWRITE por construcao - SIGOPinsBO.CriarCursorLista()
    * usa CREATE CURSOR e a recarga eh ZAP + APPEND FROM DBF(), nunca
    * SQLEXEC sobre o alias da grade. Fosse cursor de SQLEXEC, o REPLACE
    * estouraria.
    *
    * Sem TRY/CATCH de proposito: os RETURN de guarda sao early-exit, e
    * RETURN dentro de TRY eh proibido (regra #1). Nao ha operacao que
    * possa lancar - as tres pre-condicoes (cursor aberto, linha valida,
    * tecla certa) ja estao cobertas pelos guards.
    *==========================================================================
    PROCEDURE ChkSelecaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCursor

        IF !INLIST(par_nKeyCode, 13, 32)
            RETURN
        ENDIF

        loc_cCursor = "cursor_4c_Lista"
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cCursor = THIS.this_oBusinessObject.this_cCursorLista
        ENDIF

        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        SELECT (loc_cCursor)

        IF EOF() OR BOF()
            RETURN
        ENDIF

        REPLACE selecao WITH IIF(NVL(selecao, 0) = 0, 1, 0)

        THIS.grd_4c_Dados.Refresh()

        NODEFAULT
    ENDPROC

    *==========================================================================
    * ChkSelecaoMouseUp - Clique do mouse sobre o CheckBox da grade
    * Delega ao KeyPress com a tecla 13 (mesma marcacao do teclado) e
    * suprime o toggle nativo, que alternaria o valor uma segunda vez.
    *==========================================================================
    PROCEDURE ChkSelecaoMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.ChkSelecaoKeyPress(13, 0)
        NODEFAULT
    ENDPROC

    *==========================================================================
    * ChkSelecaoMouseDown - Suprime a metade de "descida" do toggle nativo.
    * Quem marca eh o MouseUp; sem este NODEFAULT o par descida/subida
    * alterna duas vezes e a tela nao muda.
    *==========================================================================
    PROCEDURE ChkSelecaoMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    *==========================================================================
    * ChkSelecaoClick - Suprime o Click nativo do CheckBox pelo mesmo motivo
    * do MouseDown: a marcacao ja foi feita no MouseUp.
    *==========================================================================
    PROCEDURE ChkSelecaoClick()
        NODEFAULT
    ENDPROC

    *==========================================================================
    * ColDescricaoWhen - Column2.Text1.When do legado: "Return .f."
    * Bloqueia o foco na celula de descricao - ela eh so EXIBICAO.
    *==========================================================================
    PROCEDURE ColDescricaoWhen()
        RETURN .F.
    ENDPROC

    *==========================================================================
    * ColDescricaoGotFocus - Column2.Text1.GotFocus do legado:
    * "ThisForm.Grade.Column1.fwcheckbox1.SetFocus"
    * Inalcancavel em condicoes normais (When ja devolve .F.), mas
    * transcrito pelo mesmo motivo do ColDescricaoWhen - eh o par que o
    * dump declara.
    *==========================================================================
    PROCEDURE ColDescricaoGotFocus()
        IF PEMSTATUS(THIS.grd_4c_Dados.Column1, "chk_4c_Selecao", 5)
            THIS.grd_4c_Dados.Column1.chk_4c_Selecao.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * PosicionarAberturaInicial - Legado, fim do Init:
    *   This.Refresh / This.Grade.Column1.SetFocus /
    *   This.Grade.Column1.fwcheckbox1.SetFocus /
    *   ThisForm.Grade.AfterRowColChange()
    *
    * Pulado em modo de teste: SetFocus em controle headless (sem tela
    * real) estoura, e nenhum teste automatizado depende do foco inicial.
    *==========================================================================
    PROTECTED PROCEDURE PosicionarAberturaInicial()
        IF THIS.EstaEmModoTeste()
            RETURN
        ENDIF

        IF PEMSTATUS(THIS.grd_4c_Dados.Column1, "chk_4c_Selecao", 5)
            THIS.grd_4c_Dados.Column1.chk_4c_Selecao.SetFocus()
        ENDIF

        THIS.GrdDadosAfterRowColChange(1)
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere para o BO o que o usuario escolheu na TELA
    *
    * Legado (btnConfirmar.Click, dentro do Scan que monta o texto):
    *   Iif(llPri, [], Chr(13) + Iif(Thisform.chkPular.Value, Chr(13), []))
    *
    * Este dialogo tem UM unico controle de entrada que nao esta ligado ao
    * cursor: o chk_4c_Pular ("Pular Linhas"). Tudo o mais que o usuario mexe
    * - a marcacao de cada observacao - vai DIRETO para o cursor da lista pelo
    * ControlSource da Column1, entao nao ha o que transferir dali: o BO le a
    * coluna "selecao" do mesmo cursor em ConfirmarSelecao(). Por isso este
    * hook eh curto, e nao porque esteja incompleto.
    *
    * Era um bloco inline no BtnConfirmarClick; passou a metodo proprio para
    * haver UM ponto de leitura da tela, que eh o que o nome do hook promete.
    *
    * this_lPularLinhas eh LOGICO no BO porque ConfirmarFluxoOperacao() a usa
    * como condicao de IIF, e IIF com numerico estoura erro 11. O chk_4c_Pular
    * nasce com .Value = .T. (transcricao do dump), mas CheckBox criado por
    * AddObject assume o TIPO do que lhe for atribuido: o teste de VARTYPE
    * garante property logica nos dois casos, em vez de deixar o tipo do
    * controle vazar para o BO.
    *
    * Devolve .F. sem gravar quando o BO ou o controle nao estao disponiveis -
    * seguir adiante produziria o separador de linhas errado no texto final.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + ;
                "vel para confirmar a sele" + CHR(231) + CHR(227) + "o.", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF !PEMSTATUS(THIS, "chk_4c_Pular", 5)
            *-- CHR(34) para as aspas: o VFP9 nao tem escape de " dentro de
            *-- string delimitada por " (barra-aspas fecha a string e quebra
            *-- a compilacao).
            MsgErro("Op" + CHR(231) + CHR(227) + "o " + CHR(34) + "Pular Linhas" + ;
                CHR(34) + " indispon" + CHR(237) + "vel na tela.", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF VARTYPE(THIS.chk_4c_Pular.Value) = "L"
            THIS.this_oBusinessObject.this_lPularLinhas = THIS.chk_4c_Pular.Value
        ELSE
            THIS.this_oBusinessObject.this_lPularLinhas = (THIS.chk_4c_Pular.Value = 1)
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere para a TELA o que o BO resolveu
    *
    * Legado (Init), as duas transferencias que o bloco de dados NAO faz pelo
    * ControlSource do cursor:
    *   ThisForm.Caption = 'Selecao de ' + Iif(<pCaption>, pCaption, 'Finalidades')
    *   ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
    *   ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
    *   chkPular com Value = .T. (declarado no SCX)
    *
    * O titulo continua sendo montado por AplicarTitulo(), que delega a
    * SIGOPinsBO.ObterTituloDialogo() - este hook apenas passou a ser o ponto
    * UNICO por onde o estado do BO chega aos controles, em vez de o
    * InicializarForm chamar cada pedaco solto.
    *
    * A marcacao da grade e o texto do getObs NAO entram aqui: os dois estao
    * ligados ao cursor da lista por ControlSource (ver VincularGrade), entao
    * quem os atualiza eh o proprio cursor, nao uma atribuicao de property.
    *
    * Sobre o chk_4c_Pular: o .T. que ConfigurarCheckBoxPular() atribui eh a
    * transcricao fiel do dump, e o default this_lPularLinhas = .T. do BO eh o
    * MESMO valor - os dois concordam por construcao, nao se contradizem.
    * Reaplicar a partir do BO aqui torna o BO a fonte depois da abertura:
    * numa segunda tentativa de confirmar (a primeira recusada por
    * ConfirmarSelecao) a tela volta exibindo a opcao que o BO carrega, em vez
    * de reverter ao default do SCX.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        *-- Caption do form e os dois labels da faixa do cabecalho
        THIS.AplicarTitulo()

        *-- Opcao "Pular Linhas". Atribuida como LOGICO (o tipo que o dump
        *-- declara e o tipo da property no BO), para o CheckBox criado por
        *-- AddObject nao mudar de tipo no meio do caminho.
        IF PEMSTATUS(THIS, "chk_4c_Pular", 5)
            THIS.chk_4c_Pular.Value = THIS.this_oBusinessObject.this_lPularLinhas
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarLista - Carga da grade de observacoes
    *
    * Reproduz o bloco de dados do Init legado delegando TODO o SQL ao
    * SIGOPinsBO (PILAR 3) e cuidando aqui apenas do que eh de tela: criar
    * o cursor que a grade exibe, ligar a grade a ele e repintar.
    *
    * Em modo de teste / validacao de UI nao ha conexao (gnConnHandle eh
    * sentinela do harness, nao "servidor fora do ar"): a grade eh ligada a
    * estrutura VAZIA, que eh o suficiente para a tela abrir e o bind ser
    * exercitado. Pular a ligacao deixaria a grade como retangulo branco.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            DO CASE
                CASE VARTYPE(THIS.this_oBusinessObject) != "O"
                    MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + ;
                        "vel para carregar as observa" + CHR(231) + CHR(245) + "es.", ;
                        "Aten" + CHR(231) + CHR(227) + "o")

                CASE !THIS.this_oBusinessObject.CriarCursorLista()
                    *-- Sem o cursor nao ha o que ligar na grade; a falha
                    *-- de criacao ja foi exibida pelo proprio BO.
                    loc_lSucesso = .F.

                OTHERWISE
                    IF THIS.EstaEmModoTeste()
                        loc_lSucesso = .T.
                    ELSE
                        loc_lSucesso = THIS.this_oBusinessObject.CarregarListaObservacoes()

                        IF !loc_lSucesso
                            MsgErro(IIF(EMPTY(THIS.this_oBusinessObject.this_cMensagemFalha), ;
                                "Favor Reinicializar o Processo!!!", ;
                                THIS.this_oBusinessObject.this_cMensagemFalha), ;
                                "Falha na Conex" + CHR(227) + "o")
                        ENDIF
                    ENDIF

                    *-- A grade eh ligada mesmo quando a carga falhou: o
                    *-- cursor existe (vazio) e o bind evita grade sem
                    *-- coluna na tela de erro.
                    THIS.VincularGrade()
            ENDCASE

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao carregar as observa" + CHR(231) + CHR(245) + "es: " + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * VincularGrade - Liga a grade ao cursor da lista e repinta
    *
    * Legado:
    *   This.Grade.RecordSource          = [LocalObs]
    *   This.Grade.Column1.ControlSource = [LocalObs.Selecao]
    *   This.Grade.Column2.ControlSource = [LocalObs.Descrs]
    *   Go Top In LocalObs
    *
    * Ordem obrigatoria: RecordSource -> ControlSource -> Header1.Caption ->
    * Width. Trocar a fonte da grade faz o VFP recalcular as larguras para
    * o default e devolver os headers a "Header1", entao caption e largura
    * sao reaplicados DEPOIS do bind, com a largura por ultimo.
    *
    * Sparse e CurrentControl sao reafirmados aqui porque sem eles o
    * CheckBox da Column1 deixa de ser desenhado (ou aparece so na linha
    * corrente) - e a reafirmacao eh barata.
    *
    * Fecha com GO TOP + Refresh: popular o cursor NAO repinta a grade
    * sozinho, e sem isso a tela abre visualmente vazia com o cursor cheio.
    *==========================================================================
    PROCEDURE VincularGrade()
        LOCAL loc_oGrade, loc_cCursor, loc_lSucesso

        loc_lSucesso = .F.

        IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN loc_lSucesso
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN loc_lSucesso
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorLista

        IF !USED(loc_cCursor)
            RETURN loc_lSucesso
        ENDIF

        loc_oGrade = THIS.grd_4c_Dados

        loc_oGrade.RecordSource = loc_cCursor

        loc_oGrade.Column1.ControlSource = loc_cCursor + ".selecao"
        loc_oGrade.Column2.ControlSource = loc_cCursor + ".descrs"

        loc_oGrade.Column1.Header1.Caption = ""
        loc_oGrade.Column2.Header1.Caption = "Observa" + CHR(231) + CHR(245) + "es"

        loc_oGrade.Column1.Sparse = .F.
        IF PEMSTATUS(loc_oGrade.Column1, "chk_4c_Selecao", 5)
            loc_oGrade.Column1.CurrentControl = "chk_4c_Selecao"
        ENDIF

        *-- Largura por ULTIMO (o bind acima a devolve para o default)
        loc_oGrade.Column1.Width = 23
        loc_oGrade.Column2.Width = 562

        *-- Legado: "This.getObs.ControlSource = [LocalObs.Observas]", na
        *-- MESMA sequencia e no MESMO cursor da grade - eh o que faz o campo
        *-- acompanhar a linha corrente. Fica aqui, e nao em
        *-- ConfigurarCampoObservacao, porque ali o cursor ainda nao existe.
        IF PEMSTATUS(THIS, "obj_4c_GetObs", 5)
            THIS.obj_4c_GetObs.ControlSource = loc_cCursor + ".observas"
        ENDIF

        SELECT (loc_cCursor)
        GO TOP
        loc_oGrade.Refresh()

        *-- Popular o cursor NAO repinta o campo ligado a ele: sem este
        *-- Refresh o texto da 1a linha nao aparece ao abrir a tela. Eh o
        *-- "This.Refresh" + "ThisForm.Grade.AfterRowColChange()" com que o
        *-- Init legado fecha.
        IF PEMSTATUS(THIS, "obj_4c_GetObs", 5)
            THIS.obj_4c_GetObs.Refresh()
        ENDIF

        loc_lSucesso = .T.

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * EstaEmModoTeste - Informa se o dialogo roda sem conexao ao banco
    *
    * O harness de teste automatizado define gnConnHandle = 0 de PROPOSITO
    * (tentar SQLSTRINGCONNECT contra servidor inacessivel bloqueia pelo
    * timeout TCP do SO) e espera que os forms pulem as consultas por estas
    * flags, nao por checagem de handle.
    *==========================================================================
    PROCEDURE EstaEmModoTeste()
        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        RETURN .F.
    ENDPROC

    *==========================================================================
    * AplicarTitulo - Reproduz o bloco de titulo do Init legado:
    *   ThisForm.Caption = 'Selecao de ' + Iif(<pCaption>, pCaption, 'Finalidades')
    *   ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
    *   ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
    *
    * O texto eh montado por SIGOPinsBO.ObterTituloDialogo(), que ja guarda o
    * parametro de titulo recebido do chamador.
    *==========================================================================
    PROTECTED PROCEDURE AplicarTitulo()
        LOCAL loc_cTitulo

        loc_cTitulo = THIS.this_oBusinessObject.ObterTituloDialogo()

        IF VARTYPE(loc_cTitulo) = "C" AND !EMPTY(loc_cTitulo)
            THIS.Caption = loc_cTitulo
        ENDIF

        THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
        THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis os controles criados por
    * AddObject (que nascem com Visible = .F.)
    *
    * Sem lista de excecao: no dump deste legado nenhum controle nasce oculto -
    * cntSombra, cntBotoes, Grade, getObs e chkPular estao todos visiveis, e
    * este dialogo nao tem painel flutuante alternado por botao.
    *
    * Controls(N) eh indexado por NUMERO. CommandGroup nao expoe ControlCount,
    * entao a recursao nao entra nele - seus Buttons(N) ja nascem visiveis.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_oPai

        IF PCOUNT() >= 1 AND VARTYPE(par_oContainer) = "O"
            loc_oPai = par_oContainer
        ELSE
            loc_oPai = THIS
        ENDIF

        FOR loc_nI = 1 TO loc_oPai.ControlCount
            loc_oObjeto = loc_oPai.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    IF loc_oObjeto.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - Equivalente ao Release do legado:
    *   This.Grade.RecordSource          = []
    *   This.Grade.Column1.ControlSource = []
    *   This.Grade.Column2.ControlSource = []
    *   Use In LocalObs
    *
    * Desliga o bind da grade ANTES de fechar o cursor da lista, para o VFP nao
    * ficar com alias preso ao RecordSource. O PEMSTATUS cerca a grade porque o
    * Destroy tambem roda quando o Init falhou antes de ela existir.
    *
    * Fecha SO os cursores deste dialogo. Os cursores do formulario CHAMADOR
    * (crSigOpFnl, TprMvCab, crTpmMvItn) chegam abertos e continuam abertos -
    * fecha-los aqui destruiria o trabalho de quem abriu a tela.
    *
    * USE IN fecha o alias mesmo com buffer sujo, entao nao ha TABLEREVERT:
    * sem buffering ligado ele dispararia erro 1586.
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_cLista, loc_cSelecionadas, loc_cGrupo, loc_cOperacao, loc_cProduto

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.RecordSource = ""
        ENDIF

        *-- getObs esta ligado ao MESMO cursor da grade (VincularGrade), entao
        *-- o bind dele tambem sai ANTES do USE IN. O legado nao precisava
        *-- disso porque a tela morria junto com a datasession do chamador.
        IF PEMSTATUS(THIS, "obj_4c_GetObs", 5)
            THIS.obj_4c_GetObs.ControlSource = ""
        ENDIF

        loc_cLista        = "cursor_4c_Lista"
        loc_cSelecionadas = "cursor_4c_Selecionadas"
        loc_cGrupo        = "cursor_4c_Grupo"
        loc_cOperacao     = "cursor_4c_Operacao"
        loc_cProduto      = "cursor_4c_Produto"

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cLista        = THIS.this_oBusinessObject.this_cCursorLista
            loc_cSelecionadas = THIS.this_oBusinessObject.this_cCursorSelecionadas
            loc_cGrupo        = THIS.this_oBusinessObject.this_cCursorGrupo
            loc_cOperacao     = THIS.this_oBusinessObject.this_cCursorOperacao
            loc_cProduto      = THIS.this_oBusinessObject.this_cCursorProduto

            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED(loc_cLista)
            USE IN (loc_cLista)
        ENDIF
        IF USED(loc_cSelecionadas)
            USE IN (loc_cSelecionadas)
        ENDIF
        IF USED(loc_cGrupo)
            USE IN (loc_cGrupo)
        ENDIF
        IF USED(loc_cOperacao)
            USE IN (loc_cOperacao)
        ENDIF
        IF USED(loc_cProduto)
            USE IN (loc_cProduto)
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

*==============================================================================
* EditBoxMemoSIGOPins_4c_ - EditBox do campo getObs
*
* O getObs do legado eh da classe fwmemo (framework.vcx), cujo When decide se
* o controle aceita foco a partir de ThisForm.pcEscolha
* (docs\FRAMEWORK_class_codigo_fonte.txt, "OBJETO: fwmemo"):
*
*   PROCEDURE When
*   If Type('ThisForm.pcEscolha')='C'
*       Do Case
*           Case Inlist(ThisForm.pcEscolha,'INSERIR','ALTERAR')  && editavel
*           Case Inlist(ThisForm.pcEscolha,'CONSULTAR','EXCLUIR') && so leitura
*           Case ThisForm.pcEscolha = 'PROCURAR'                  && sem foco
*       EndCase
*   Else
*       m.llRead    = This.ReadOnly
*       m.llRetorno = This.ReadOnly
*   EndIf
*   This.ReadOnly = m.llRead
*   Return(m.llRetorno)
*
* SIGOPINS eh dialogo modal de selecao, NAO frmcadastro: ele nao tem a
* propriedade pcEscolha. Logo o DO CASE eh inalcancavel aqui e o legado cai
* SEMPRE no ELSE, onde o retorno eh This.ReadOnly - e o dump declara
* "ReadOnly = .F." no getObs. Ou seja: o When devolve .F. e o campo NUNCA
* recebe foco, nem por Tab nem por clique. Eh por isso que ele eh um painel
* de EXIBICAO do texto da linha corrente, e eh por isso que o legado precisa
* do "ThisForm.getObs.Refresh" no AfterRowColChange da grade para atualiza-lo.
*
* Transcrever so o ramo que de fato roda (RETURN .F.) - reproduzir o DO CASE
* inteiro criaria referencia a uma propriedade que este form nao tem, que eh
* justamente o que estoura "Property PCESCOLHA is not found" em runtime.
*
* O GotFocus do fwmemo ("This.peAntvalue = This.Value") nao vem junto: com o
* When devolvendo .F. o controle nunca recebe foco, entao o GotFocus eh
* inalcancavel e peAntvalue nao tem leitor nenhum neste dialogo.
*
* Vive no mesmo .prg do form porque eh usado SO por ele - o
* indice_classes.txt resolve a dependencia pelo arquivo, e GarantirClasse()
* carrega as duas classes de uma vez.
*==============================================================================
DEFINE CLASS EditBoxMemoSIGOPins_4c_ AS EditBox

    *--------------------------------------------------------------------------
    * When - Ramo ELSE do fwmemo.When para form sem pcEscolha
    *
    * Devolve .F. (o ReadOnly = .F. do dump): campo de exibicao, sem foco.
    * A atribuicao "This.ReadOnly = m.llRead" do legado eh no-op neste ramo
    * (llRead recebe o proprio This.ReadOnly), por isso nao aparece aqui.
    *--------------------------------------------------------------------------
    FUNCTION When()
        RETURN .F.
    ENDFUNC

ENDDEFINE
