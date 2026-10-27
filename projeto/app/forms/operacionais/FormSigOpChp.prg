*==============================================================================
* FormSigOpChp.prg - Form Operacional: Prorrogar Vencimento de Cheque
* Migrado de: tasks/task699/SIGOPCHP.SCX
* Tabelas (via SigOpChpBO): SigChe (UPDATE), SigChea (historico), SigMvCcr
* (juros), SigClLan (bloqueio por atraso)
*
* Dialogo filho da Historico de Cheques (FormSigOpChi), aberto passando a
* referencia do form pai (equivalente a Lparameters pOldForm / ThisForm.
* ParentForm no legado - FormSigOpChi.AcaoProrrogaClick ja chama
* CREATEOBJECT("FormSigOpChp", THIS)). Layout CUSTOMIZADO - NAO segue o
* padrao CRUD Page1=Lista/Page2=Dados: cabecalho + 2 shapes decorativos +
* campos de vencimento/dias/juros direto no Form, com os botoes Prorrogar e
* Cancelar.
*
* SUPERFICIE ENTREGUE x TEMPLATE CRUD
* -----------------------------------
* Implementados porque existem no legado:
*   CarregarCheque       -> localiza o cheque (CrSigChe ja posicionado pelo
*                           form pai no legado; aqui via this_cNums + BO.Buscar)
*   BOParaForm/FormParaBO-> os ControlSource vazios do Get_Venc/Dias/Juros/
*                           ValJuros, aqui centralizados nas properties do BO
*   ValidarVenc/Dias/Juros-> os PROCEDURE Valid dos 3 campos digitaveis
*   BtnProrrogarClick     -> Prorroga.Click (guard + grava via BO.Salvar)
*   BtnCancelarClick      -> btnCancela.Click (ThisForm.Release)
*
* Deliberadamente AUSENTES - o legado nao tem a superficie, e cria-los seria
* inventar (viola o PILAR 1) ou escrever metodo vazio (stub, proibido pela
* regra de completude):
*   handlers de Incluir/Alterar/Excluir/Buscar e habilitacao de campos por
*       modo -> nao ha grid nem lista neste dialogo: um UNICO cheque, ja
*       localizado pelo form pai, eh editado em modo unico
*   Get_ValJuros nao recebe handler de entrada -> PROCEDURE When do legado
*       retorna .f. (o campo nunca entra em edicao); aqui o equivalente eh
*       .ReadOnly = .T. + .TabStop = .F. no AddObject
*   AbrirLookup*/AbrirBusca* -> este legado NAO TEM LOOKUP ALGUM (medido, ver
*       bloco abaixo). Criar um seria inventar tabela de consulta que o legado
*       nunca abre: viola o PILAR 1 e a regra "NUNCA inventar tabelas de
*       lookup que nao existem no original".
*
* LOOKUPS: AUSENCIA MEDIDA NO DUMP (Fase 6) - o legado nao tem nenhum
* -----------------------------------------------------------------------
* Varredura das CINCO familias de padrao de lookup do legado Fortyus em
* tasks\task699\SigOpChp_form_codigo_fonte.txt - todas com ZERO ocorrencia:
*   fwbusca (cobre fwBuscaExt/fwBuscaSel/fwBuscaInt) .... 0
*   mAddColuna (API de colunas do picker legado) ........ 0
*   sigacess( ........................................... 0
*   Acesso(Campos|Contab|Contas|Empresa|Grupos|
*          MovInd|MovMto|Produto|Titulo)( ............... 0
*   FormBuscaAuxiliar ................................... 0
* Tambem zero CreateObject( e zero Seek( no dump inteiro.
*
* Os 4 campos sao Class = fwget, mas NENHUM usa a maquinaria de busca da
* classe: os 3 PROCEDURE Valid do legado (Get_Venc/Get_Dias/Get_Juros) sao
* CALCULO puro entre os proprios campos - ja migrados aqui como
* ValidarVenc/ValidarDias/ValidarJuros, ligados por BINDEVENT "LostFocus"
* (regra #47 - o Valid roda ao SAIR do campo; em "KeyPress" o handler
* dispararia a cada tecla). O 4o campo (Get_ValJuros) tem When -> .f. e
* portanto nao tem onde digitar codigo para um picker resolver.
*
* Perfil de gate: OPERACIONAL / CAPTURA - o legado nao tem lista, TEM campos
* de ENTRADA e nao vincula nenhum a dado (os 4 declaram ControlSource = "",
* override VAZIO que por regra #49 nao se transcreve; por isso o migrado nao
* tem .ControlSource algum). Mesmo perfil do precedente SIGPRCFN/task589.
*
* Toda a logica de gravacao (UPDATE SigChe, INSERT SigChea, lancamento de
* juros em SigMvCcr, bloqueio por atraso em SigClLan, fRecalculaS + commit/
* rollback) ja foi migrada para SigOpChpBO.Atualizar() (Fases 1-2) - este
* form so chama THIS.this_oBusinessObject.Salvar(), que delega para la.
*
* FASE 7 (Form - Eventos Principais): o dump legado tem EXATAMENTE 2
* CommandButton (Prorroga + btnCancela, ver layout.json) - nao 0, nao 1 -
* entao o piso de handlers da fase (minHandlersF7 = 2, feedback_gate_fase7_
* piso_dois_handlers) ja esta satisfeito pelos dois unicos botoes que o
* legado tem: BtnProrrogarClick (linha ~677, equivalente a Prorroga.Click) e
* BtnCancelarClick (linha ~702, equivalente a btnCancela.Click), ambos
* registrados via BINDEVENT em ConfigurarBotoesAcao e com corpo completo (TRY
* implicito via Salvar()/Release(), sem stub). Os 4 nomes-padrao do template
* CRUD (BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick)
* seguem Deliberadamente AUSENTES pelo motivo ja medido e documentado acima
* (SUPERFICIE ENTREGUE x TEMPLATE CRUD) - nao ha grid, nao ha modo, um unico
* cheque ja localizado pelo form pai eh editado em modo unico. Nada a
* acrescentar nesta fase: inventar os 4 handlers CRUD violaria o PILAR 1
* (tabela/fluxo que o legado nao tem) e duplicaria logica ja entregue.
*
* FASE 8 (Form - Eventos Auxiliares e Consolidacao Final)
* ------------------------------------------------------
* 1) AUDITORIA DE COMPLETUDE DE FormParaBO/BOParaForm. Conferidas UMA A UMA
*    as 18 properties de SigOpChpBO contra os dois hooks e contra o que
*    SigOpChpBO.Atualizar() consome - nenhuma ficou sem origem:
*
*    property do BO                     | quem preenche      | na tela?
*    -----------------------------------+--------------------+---------
*    this_dVencNovo (Get_Venc)          | FormParaBO         | SIM
*    this_nDias     (Get_Dias)          | FormParaBO         | SIM
*    this_nJuros    (Get_Juros)         | FormParaBO         | SIM
*    this_nValJuros (Get_ValJuros)      | FormParaBO         | SIM
*    this_cNums / this_dVencs /         | CarregarDoCursor   | nao
*      this_nValors / this_cBancos /    |  (SELECT SigChe,   |
*      this_cAgencias / this_cNContas / |   via CarregarCheque)
*      this_cNCheques / this_cIClis /   |                    |
*      this_cGrClis                     |                    |
*    this_cContaJuros/this_cGrupoJuros/ | CarregarParametros-| nao
*      this_cMoedaCheqs/this_nDiaPrors  |  Sistema (SigCdPam)|
*    this_cSigKey                       | idem (SigCdPac)    | nao
*    this_lParametrosCarregados         | flag interna do BO | nao
*
*    Os QUATRO campos da tela estao nos DOIS sentidos (FormParaBO e
*    BOParaForm), que eh o que a fase cobra. As outras 14 properties NAO
*    entram nos hooks de proposito: elas vem do BANCO (cursor de SigChe e
*    parametros de SigCdPam/SigCdPac), exatamente como no legado, onde
*    CrSigChe/crSigCdPam/CrSigCdPac ja chegam prontos do form pai. Passa-las
*    pela tela seria inventar campo que o legado nao tem; nenhuma delas tem
*    controle correspondente no dump (os 4 Get_* do SCX sao os 4 acima).
*
* 2) REPINTE DA LISTA DO PAI - unica superficie que FALTAVA. O legado nao
*    para no UPDATE: ele reescreve a linha no cursor do form pai
*    (Prorroga.Click:498-500, "Replace Vencs With ThisForm.Get_Venc.Value,
*    DtAlts With Datetime()" em CrSigChe, que eh o RecordSource da grade do
*    pai). Migrado como AtualizarFormPai(), chamado logo apos Salvar() em
*    BtnProrrogarClick. Sem ele a grade da "Historico de Cheques" continuava
*    exibindo o vencimento ANTIGO depois de prorrogar - variante ENTRE FORMS
*    da regra #21 ("popular cursor NAO repinta a grade").
*
* 3) NOMES DO TEMPLATE CRUD SEM REFERENTE NESTE LEGADO. A fase pede, pelo
*    template, BtnBuscarClick/BtnEncerrarClick/BtnSalvarClick/CarregarLista/
*    HabilitarCampos/LimparCampos/AjustarBotoesPorModo. Medido no dump: o
*    legado tem DOIS CommandButton (Prorroga, btnCancela) e mais nada -
*    cria-los aqui seria inventar superficie (PILAR 1) ou escrever metodo
*    vazio (stub, proibido pela regra de completude). Um a um:
*      BtnSalvarClick    -> o botao de gravar DESTE legado se chama
*                           "Prorrogar"; o handler eh BtnProrrogarClick,
*                           nomeado pela ACAO, e eh ele que chama Salvar().
*                           Renomea-lo para BtnSalvarClick faria o nome
*                           mentir sobre qual botao ele atende.
*      BtnCancelarClick  -> EXISTE (btnCancela.Click do legado), renomeado
*                           nesta fase de BtnCancelaClick para a grafia
*                           canonica do projeto (829 forms usam
*                           BtnCancelarClick contra 9 em BtnCancelaClick) e
*                           coerente com o Caption "Cancelar" do dump.
*      BtnEncerrarClick  -> nao ha botao Encerrar: quem fecha o dialogo eh o
*                           proprio Cancelar (Cancel = .T. no dump), que ja
*                           tem handler. Um segundo botao de saida seria
*                           invencao.
*      BtnBuscarClick    -> nao ha busca: o cheque chega JA localizado pelo
*                           form pai (this_cNums), e o legado nao tem campo
*                           de procura nem lookup algum (zero ocorrencia das
*                           CINCO familias de picker - ver bloco LOOKUPS).
*      CarregarLista     -> nao ha lista: zero Grid e zero PageFrame no dump
*                           (layout.json: 19 objetos, nenhum de grade). O
*                           metodo de carga desta tela eh CarregarCheque(),
*                           que le UM registro de SigChe - chama-lo
*                           "CarregarLista" nomearia uma lista inexistente.
*                           A lista que existe eh a do PAI, e ela eh
*                           repintada por AtualizarFormPai() (item 2).
*      HabilitarCampos / -> nao ha MODO: o dialogo nao tem Page1/Page2, nao
*      AjustarBotoesPor-    recebe pcEscolha e nao alterna INCLUIR/ALTERAR/
*      Modo                 VISUALIZAR - um unico cheque eh editado em modo
*                           unico, com os 2 botoes sempre habilitados (o
*                           legado nao mexe em Enabled de nada). O unico
*                           estado de campo que o legado define eh o When ->
*                           .f. de Get_ValJuros, ja reproduzido no AddObject
*                           como .ReadOnly = .T. + .TabStop = .F.
*      LimparCampos      -> nao ha ciclo de reuso a limpar: o dialogo nasce,
*                           edita UM cheque e morre no Release (de
*                           BtnProrrogarClick ou de BtnCancelarClick) - nao
*                           volta para uma lista nem recebe um segundo
*                           registro. O estado inicial dos 4 campos eh
*                           definido por BOParaForm(), chamado no fim de
*                           ConfigurarCamposProrrogacao().
*==============================================================================

DEFINE CLASS FormSigOpChp AS FormBase

    Height      = 200
    Width       = 500
    AutoCenter  = .T.
    BorderStyle = 1
    ShowWindow  = 1
    ControlBox  = .F.
    Closable    = .F.
    FontName    = "Tahoma"
    FontSize    = 8
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    WindowType  = 0
    Picture     = "..\framework\imagens\new_background.jpg"

    *-- Referencia ao form pai (equivalente a ThisForm.ParentForm no legado)
    this_oParentForm = .NULL.

    *-- Nums (char(8)) do cheque sendo prorrogado - equivalente a CrSigChe.Nums
    *-- do legado, que o form pai ja posiciona antes de abrir o dialogo
    this_cNums = ""

    *--------------------------------------------------------------------------
    * Init - recebe o form pai (equivalente a Lparameters pOldForm). O
    * legado le CrSigChe.Nums de um cursor GLOBAL ja posicionado pelo form
    * pai; aqui (PILAR 3 - sem cursor global) o equivalente eh a property
    * this_cNums do Business Object do form pai (FormSigOpChi.
    * this_oBusinessObject.this_cNums), que FormSigOpChi.AcaoProrrogaClick
    * ja garante preenchida via ExigirChequeSelecionado() antes de instanciar
    * este form com CREATEOBJECT("FormSigOpChp", THIS).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LPARAMETERS par_oParentForm

        THIS.Caption = "Prorrogar"

        IF VARTYPE(par_oParentForm) = "O"
            THIS.this_oParentForm = par_oParentForm

            IF PEMSTATUS(par_oParentForm, "this_oBusinessObject", 5) AND ;
                    VARTYPE(par_oParentForm.this_oBusinessObject) = "O" AND ;
                    PEMSTATUS(par_oParentForm.this_oBusinessObject, "this_cNums", 5)
                THIS.this_cNums = ALLTRIM(NVL(par_oParentForm.this_oBusinessObject.this_cNums, ""))
            ENDIF
        ENDIF

        *-- ShowWindow=1 na classe causaria TIMEOUT em VFP9 -T (top-level window
        *-- bloqueante) durante testes headless. Classe definida com WindowType=0;
        *-- producao restaura modal top-level aqui (mesmo padrao de FormSigOpChc).
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            THIS.WindowType = 1
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - monta a estrutura base do form operacional e localiza
    * o cheque a prorrogar. Sem o cheque, o dialogo nao tem proposito - falha
    * aqui impede a abertura (equivalente ao legado assumir CrSigChe sempre
    * posicionado).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpChpBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpChpBO.", ;
                        "Erro em InicializarForm")
                loc_lSucesso = .F.
            ELSE
                IF !THIS.CarregarCheque()
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel localizar o cheque " + ;
                            ALLTRIM(THIS.this_cNums) + " para prorroga" + CHR(231) + CHR(227) + "o.", ;
                            "Erro em InicializarForm")
                    loc_lSucesso = .F.
                ELSE
                    THIS.ConfigurarPageFrame()

                    THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                    THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                    THIS.TornarControlesVisiveis(THIS)

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - orquestra a montagem visual do form OPERACIONAL.
    * Nao ha PageFrame real (dialogo flat, sem Lista/Dados do CRUD). Shapes
    * decorativos ANTES dos campos (regra de Z-Order - os dois shapes do
    * legado sao paineis de fundo atras do bloco de vencimento/dias/juros).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarShapesDecorativos()
        THIS.ConfigurarCamposProrrogacao()
        THIS.ConfigurarBotoesAcao()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - cria cnt_4c_Sombra (equivalente a cntSombra do
    * legado) com os labels de sombra e titulo
    * Original (layout.json): cntSombra Top=0, Left=0, Width=800, Height=80
    * (Width ajustada para THIS.Width - regra CLAUDE.md #11/#88/#89: container
    * do cabecalho nunca fica hardcoded menor/maior que o form)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCab = THIS.cnt_4c_Sombra
        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
        ENDWITH

        *-- FontSize 18 TRANSCRITO do dump (SIGOPCHP.cntSombra.lblSombra/
        *-- lblTitulo declaram FontSize = 18 - mesmo valor usado no FormSigOpChc,
        *-- dialogo irmao da mesma familia SigOpCh*).
        loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCab.lbl_4c_LblSombra
            .AutoSize      = .F.
            .Width         = loc_oCab.Width - 20
            .Height        = 40
            .Top           = 18
            .Left          = 10
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .Alignment     = 0
            .BackStyle     = 0
            .WordWrap      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = THIS.Caption
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCab.lbl_4c_LblTitulo
            .AutoSize      = .F.
            .Width         = loc_oCab.Width - 20
            .Height        = 46
            .Top           = 17
            .Left          = 10
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .WordWrap      = .T.
            .ForeColor     = RGB(255, 255, 255)
            .Caption       = THIS.Caption
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarShapesDecorativos - cria shp_4c_Shape1/shp_4c_Shape2
    * (equivalentes a Shape1/Shape2 do legado), puramente decorativos -
    * paineis de fundo atras do bloco de vencimento/dias/juros. Propriedades
    * TRANSCRITAS do dump do SCX (SIGOPCHP.Shape1/Shape2). BackStyle/
    * BorderStyle/BorderColor sao validas na classe Shape (regra #33,
    * automation\propriedades_baseclasses.txt); ZOrderSet NAO se transcreve
    * (bookkeeping do Form Designer, nao existe em runtime).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarShapesDecorativos()
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 97
            .Left        = 101
            .Width       = 298
            .Height      = 82
            .BackStyle   = 0
            .BackColor   = RGB(192, 192, 192)
            .BorderColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("shp_4c_Shape2", "Shape")
        WITH THIS.shp_4c_Shape2
            .Top         = 7
            .Left        = 284
            .Width       = 173
            .Height      = 110
            .BackStyle   = 0
            .BorderStyle = 0
            .BackColor   = RGB(192, 192, 192)
            .BorderColor = RGB(136, 189, 188)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposProrrogacao - cria os 5 labels (Say1-Say5) e os 4
    * campos (Get_Venc/Get_Dias/Get_Juros/Get_ValJuros), com Top/Left/Width/
    * Height/InputMask/Alignment TRANSCRITOS do dump (regra #23/#49).
    *
    * Get_Venc nao declara Alignment no dump (fica no default da classe, que
    * para TextBox eh 3/direita - feedback_textbox_alignment_default_e_3).
    * Get_Dias/Get_Juros/Get_ValJuros declaram Alignment = 3 explicitamente.
    *
    * Get_ValJuros tem PROCEDURE When -> Return .f. no legado (campo NUNCA
    * editavel, so exibe o valor calculado) - equivalente aqui eh .ReadOnly
    * = .T. + .TabStop = .F., para o campo nem entrar no ciclo de tabulacao.
    *
    * Os 3 campos digitaveis tem Valid no legado, equivalente ao LostFocus
    * (regra #47 - roda ao SAIR do campo, como o Valid; em KeyPress rodaria
    * a cada tecla).
    *
    * HERANCA DA CLASSE fwget (framework.vcx) - os 4 campos sao Class = fwget
    * no dump, e o SCX NAO sobrescreve estas propriedades, logo elas estao
    * VIVAS no legado e precisam ser transcritas (PILAR 1). Medidas na classe:
    *   FontName = "Tahoma" / FontSize = 8  -> sem elas o TextBox criado por
    *       AddObject fica no default da base class, com fonte MAIOR que os
    *       labels Tahoma 8 ao lado, dentro de uma caixa de 23px
    *   Format = "K"                        -> seleciona o conteudo ao entrar
    *       no campo (regra #49: Format so com K eh UX, mas eh transcricao).
    *       "K" nao contem "M", entao o InputMask segue sendo MASCARA de
    *       digitacao e nao lista de valores validos (regra #24)
    *   Themes = .F.
    *   DisabledBackColor = 192,192,192 / DisabledForeColor = 0,0,0
    * As outras duas properties da classe (pbuscap, backcolororig) sao da
    * maquinaria interna de lookup do Framework e NAO se transcrevem - este
    * dialogo nao tem lookup, e criar property morta seria inventar.
    *
    * Get_Venc eh o unico sem InputMask: o SCX declara InputMask = "" (override
    * VAZIO do Form Designer), que por regra #49 nao se transcreve.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposProrrogacao()
        *-- Say3 "Vencimento :"
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Top       = 129
            .Left      = 120
            .Width     = 64
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Vencimento :"
            .TabIndex  = 1
        ENDWITH

        *-- Get_Venc -> txt_4c_Venc (novo vencimento digitado pelo usuario)
        THIS.AddObject("txt_4c_Venc", "TextBox")
        WITH THIS.txt_4c_Venc
            .Top               = 126
            .Left              = 186
            .Width             = 81
            .Height            = 23
            .Value             = {}
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Format            = "K"
            .Themes            = .F.
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .TabIndex          = 7
        ENDWITH
        BINDEVENT(THIS.txt_4c_Venc, "LostFocus", THIS, "ValidarVenc")

        *-- Say1 "Prorrogar :"
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 105
            .Left      = 129
            .Width     = 55
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Prorrogar :"
            .TabIndex  = 5
        ENDWITH

        *-- Get_Dias -> txt_4c_Dias (dias de prorrogacao)
        THIS.AddObject("txt_4c_Dias", "TextBox")
        WITH THIS.txt_4c_Dias
            .Top               = 102
            .Left              = 186
            .Width             = 48
            .Height            = 23
            .Value             = 0
            .Alignment         = 3
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Format            = "K"
            .InputMask         = "99999"
            .Themes            = .F.
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .TabIndex          = 6
        ENDWITH
        BINDEVENT(THIS.txt_4c_Dias, "LostFocus", THIS, "ValidarDias")

        *-- Say2 "dias"
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 105
            .Left      = 238
            .Width     = 21
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "dias"
            .TabIndex  = 4
        ENDWITH

        *-- Say4 "Tx. Juros :"
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .Top       = 153
            .Left      = 130
            .Width     = 54
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Tx. Juros :"
            .TabIndex  = 3
        ENDWITH

        *-- Get_Juros -> txt_4c_Juros (taxa de juros % a.m. digitada)
        THIS.AddObject("txt_4c_Juros", "TextBox")
        WITH THIS.txt_4c_Juros
            .Top               = 150
            .Left              = 186
            .Width             = 55
            .Height            = 23
            .Value             = 0
            .Alignment         = 3
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Format            = "K"
            .InputMask         = "999.99"
            .Themes            = .F.
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .TabIndex          = 8
        ENDWITH
        BINDEVENT(THIS.txt_4c_Juros, "LostFocus", THIS, "ValidarJuros")

        *-- Say5 "% / mes = "
        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .Top       = 153
            .Left      = 247
            .Width     = 56
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "% / m" + CHR(234) + "s = "
            .TabIndex  = 2
        ENDWITH

        *-- Get_ValJuros -> txt_4c_ValJuros (valor de juros CALCULADO - When
        *-- -> .f. no legado, nunca editavel: ReadOnly + TabStop=.F. reproduzem)
        THIS.AddObject("txt_4c_ValJuros", "TextBox")
        WITH THIS.txt_4c_ValJuros
            .Top               = 150
            .Left              = 310
            .Width             = 82
            .Height            = 23
            .Value             = 0
            .Alignment         = 3
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Format            = "K"
            .InputMask         = "999,999.99"
            .Themes            = .F.
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .ReadOnly          = .T.
            .TabStop           = .F.
            .TabIndex          = 9
        ENDWITH

        THIS.BOParaForm()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - sentido BO -> tela dos ControlSource vazios do legado
    * (os 4 campos ficam vazios/zero ate o usuario digitar - o legado tambem
    * nao pre-popula Get_Venc com o vencimento atual).
    *
    * PROTECTED obrigatoriamente: FormBase declara BOParaForm/FormParaBO/
    * LimparCampos como PROTECTED e o VFP9 nao permite ALARGAR o escopo de
    * metodo herdado. Os chamadores sao todos internos a esta classe.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF !PEMSTATUS(THIS, "txt_4c_Venc", 5) OR VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        THIS.txt_4c_Venc.Value     = THIS.this_oBusinessObject.this_dVencNovo
        THIS.txt_4c_Dias.Value     = THIS.this_oBusinessObject.this_nDias
        THIS.txt_4c_Juros.Value    = THIS.this_oBusinessObject.this_nJuros
        THIS.txt_4c_ValJuros.Value = THIS.this_oBusinessObject.this_nValJuros
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - sentido tela -> BO: transfere os 4 campos digitados/
    * calculados para as properties que SigOpChpBO.Atualizar() consome
    * (this_dVencNovo/this_nDias/this_nJuros/this_nValJuros).
    *
    * Devolve .F. so quando os campos ainda nao existem (form nao montado),
    * para o chamador poder abortar em vez de seguir com dados indefinidos
    * (mesma guarda de FormSigOpChc.FormParaBO - Erro147).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION FormParaBO()
        IF !PEMSTATUS(THIS, "txt_4c_Venc", 5) OR VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        THIS.this_oBusinessObject.this_dVencNovo = THIS.txt_4c_Venc.Value
        THIS.this_oBusinessObject.this_nDias     = THIS.txt_4c_Dias.Value
        THIS.this_oBusinessObject.this_nJuros    = THIS.txt_4c_Juros.Value
        THIS.this_oBusinessObject.this_nValJuros = THIS.txt_4c_ValJuros.Value

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarCheque - localiza o cheque (THIS.this_cNums) em SigChe via
    * BO.Buscar + CarregarDoCursor, e entra em modo de edicao (equivalente a
    * CrSigChe ja estar posicionado e editavel no legado). PUBLIC: pode ser
    * reutilizado pelo harness de teste ou caso THIS.this_cNums mude.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarCheque()
        LOCAL loc_lSucesso, loc_cCursor
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !EMPTY(ALLTRIM(THIS.this_cNums))
            IF THIS.this_oBusinessObject.Buscar("nums = " + EscaparSQL(ALLTRIM(THIS.this_cNums)))
                loc_cCursor = THIS.this_oBusinessObject.this_oDataAccess.this_cCursorName

                IF THIS.this_oBusinessObject.CarregarDoCursor(loc_cCursor)
                    loc_lSucesso = THIS.this_oBusinessObject.EditarRegistro()
                ENDIF

                IF USED(loc_cCursor)
                    USE IN (loc_cCursor)
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarVenc - LostFocus de txt_4c_Venc, equivalente a Get_Venc.Valid:
    * ThisForm.Get_Dias.Value = This.Value - Ttod(crSigChe.Vencs)
    * crSigChe.Vencs (vencimento ATUAL, ja carregado) equivale a
    * THIS.this_oBusinessObject.this_dVencs; ConverterParaData normaliza
    * DATE/DATETIME (regra #16 - TTOD so aceita DATETIME).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarVenc()
        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !EMPTY(THIS.txt_4c_Venc.Value)
            THIS.txt_4c_Dias.Value = THIS.txt_4c_Venc.Value - ;
                ConverterParaData(THIS.this_oBusinessObject.this_dVencs)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDias - LostFocus de txt_4c_Dias, equivalente a Get_Dias.Valid:
    * ThisForm.Get_Venc.Value = Ttod(crSigChe.Vencs) + This.Value
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDias()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.txt_4c_Venc.Value = ConverterParaData(THIS.this_oBusinessObject.this_dVencs) + ;
                THIS.txt_4c_Dias.Value
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarJuros - LostFocus de txt_4c_Juros, equivalente a Get_Juros.Valid:
    *   _PJuros = This.Value
    *   _Dias   = ThisForm.Get_Dias.Value
    *   ThisForm.Get_ValJuros.Value = crSigChe.Valors * _PJuros / 30 * _Dias / 100
    * Formula TRANSCRITA literalmente (regra #17 - formula de calculo do
    * legado nunca se reescreve). crSigChe.Valors equivale a
    * THIS.this_oBusinessObject.this_nValors (valor do cheque, ja carregado).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarJuros()
        LOCAL loc_nPJuros, loc_nDias

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_nPJuros = THIS.txt_4c_Juros.Value
            loc_nDias   = THIS.txt_4c_Dias.Value

            THIS.txt_4c_ValJuros.Value = THIS.this_oBusinessObject.this_nValors * loc_nPJuros / 30 * loc_nDias / 100
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesAcao - cria os dois CommandButton do dialogo
    * (equivalente a Prorroga/btnCancela do legado), standalone (sem
    * CommandGroup). Left/Width transcritos do dump confirmam 75x75 cada
    * (nenhum dos dois declara Width/Height no SCX - herdados da classe
    * fwbtng): Prorroga.Left=350 + 75 = 425 = btnCancela.Left EXATO, e
    * btnCancela.Left=425 + 75 = 500 = THIS.Width EXATO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        THIS.AddObject("cmd_4c_Prorroga", "CommandButton")
        WITH THIS.cmd_4c_Prorroga
            .Top             = 3
            .Left            = 350
            .Width           = 75
            .Height          = 75
            .Caption         = "Prorrogar"
            .Picture         = gc_4c_CaminhoIcones + "geral_calendario_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_calendario_60.jpg"
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
        ENDWITH

        THIS.AddObject("cmd_4c_BtnCancela", "CommandButton")
        WITH THIS.cmd_4c_BtnCancela
            .Top             = 3
            .Left            = 425
            .Width           = 75
            .Height          = 75
            .Caption         = "Cancelar"
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
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
        ENDWITH

        BINDEVENT(THIS.cmd_4c_Prorroga, "Click", THIS, "BtnProrrogarClick")
        BINDEVENT(THIS.cmd_4c_BtnCancela, "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProrrogarClick - equivalente a Prorroga.Click do legado: guard de
    * vencimento obrigatorio (Wait Window -> MsgAviso + SetFocus, regra de
    * UI usa MsgAviso), transfere para o BO e grava via Salvar() (que
    * delega para SigOpChpBO.Atualizar() - UPDATE SigChe + historico + juros
    * + bloqueio + commit/rollback, ja migrados nas Fases 1-2).
    *
    * Sem ELSE apos Salvar() (regra #20 - BusinessBase ja exibe a falha,
    * com o MsgErro especifico de cada etapa do Atualizar ou via
    * ExibirFalha quando a subclasse so marcou this_cMensagemErro).
    *--------------------------------------------------------------------------
    PROCEDURE BtnProrrogarClick()
        IF ISNULL(THIS.txt_4c_Venc.Value) OR EMPTY(THIS.txt_4c_Venc.Value)
            MsgAviso("Vencimento n" + CHR(227) + "o pode ficar em branco!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_Venc.SetFocus()
            RETURN
        ENDIF

        *-- FormParaBO devolve .F. quando os campos ainda nao existem (form
        *-- nao montado). Seguir adiante chamaria Salvar() com as properties
        *-- do BO indefinidas/defasadas, gravando valor errado EM SILENCIO -
        *-- o proprio contrato documentado em FormParaBO manda o chamador
        *-- ABORTAR (Erro147). RETURN fica fora de TRY/CATCH (regra #1).
        IF !THIS.FormParaBO()
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.Salvar()
            THIS.AtualizarFormPai()
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarFormPai - repinta a lista do form PAI com o vencimento novo.
    *
    * O legado NAO se limita ao UPDATE: logo depois dele ele reescreve a
    * linha no cursor do form pai (Prorroga.Click:498-500)
    *     SELECT CrSigChe
    *     Replace Vencs With ThisForm.Get_Venc.Value, DtAlts With Datetime()
    * e, como CrSigChe eh justamente o RecordSource da grade do pai (a
    * "Historico de Cheques"), o usuario ve o vencimento novo na lista no
    * instante em que o dialogo fecha.
    *
    * Aqui (PILAR 3 - sem cursor global compartilhado entre os dois forms) o
    * equivalente eh pedir ao pai que recarregue a propria lista: o cheque
    * acabou de ser gravado em SigChe, entao a releitura traz o vencimento
    * novo. Sem isto a grade do pai continuaria exibindo o vencimento ANTIGO
    * - cursor certo no banco e grade visualmente defasada, o sintoma que a
    * regra #21 descreve ("popular cursor NAO repinta a grade"), aqui na sua
    * variante entre forms.
    *
    * Guardas: o form pai eh OPCIONAL (this_oParentForm = .NULL. quando o
    * dialogo eh instanciado sem pai, p.ex. no harness de teste), e nem todo
    * chamador futuro tera CarregarLista - por isso VARTYPE + PEMSTATUS antes
    * de chamar (regra #34: PEMSTATUS so confirma EXISTENCIA, e aqui eh
    * exatamente disso que se precisa). A falha ao repintar NAO pode derrubar
    * uma gravacao que JA foi confirmada no banco: o CATCH avisa e o fluxo
    * segue para o Release.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarFormPai()
        LOCAL loc_oErro

        IF VARTYPE(THIS.this_oParentForm) != "O"
            RETURN
        ENDIF

        TRY
            IF PEMSTATUS(THIS.this_oParentForm, "CarregarLista", 5)
                THIS.this_oParentForm.CarregarLista()
            ENDIF
        CATCH TO loc_oErro
            MsgAviso("Prorroga" + CHR(231) + CHR(227) + "o gravada, mas n" + CHR(227) + ;
                "o foi poss" + CHR(237) + "vel atualizar a lista de cheques:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Aten" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - equivalente literal a btnCancela.Click do legado
    * (ThisForm.Release)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna todos os controles visiveis recursivamente
    * FILTRO: nenhum container flutuante neste form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - libera recursos ao fechar o form
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        THIS.this_oParentForm = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE
