*==============================================================================
* FORMSIGOPPED.PRG
* Form de Informar Pedido (SigOpPed)
* Migracao de SIGOPPED.SCX (task779)
*
* Form OPERACIONAL de layout proprio: o objeto raiz do legado eh "form"
* generico (nao frmcadastro), WindowType = 1 (dialogo MODAL - Show() sempre
* bloqueia, independente de parametro), ControlBox = .F. + TitleBar = 0 - sem
* X e sem barra de titulo - e AlwaysOnTop = .T. + AutoCenter = .T.. Nao existe
* PageFrame nem Page1=Lista/Page2=Dados: a tela eh um unico painel com o
* cabecalho (cntSombra), uma moldura decorativa (Shape1), 9 campos (get_prod/
* getDPros/getCor/getTam/GetPedido/GetQtde/getRepetir/Get_Peso/getTamanho) e
* um CommandGroup de acao (OK: Gravar/Retornar) - ver tasks\task779\
* layout.json e mapeamento.json.
*
* Aberto pelo form PAI de movimentacao (que mantem o cursor crTpmMvItn - item
* ainda sem abreviacao de pedido) via "Do Form SigOpPed With ThisForm,
* <DataSessionId do pai>" ("LParameters pform, datses" no Init legado - ver
* comportamento.json). O 2o parametro (par_nDataSessionPai) eh o
* DataSessionId do form pai: o legado declara DataSession = 2 (privada) na
* CLASSE, mas o Init logo chama "Set Datasession To DatSes" para REBINDAR a
* sessao corrente para a do form pai - sem isso os cursores crTpmMvItn/
* CsTmpPed do pai ficariam invisiveis para este dialogo (sessao privada
* isolada) e nenhum metodo de BtnSalvarClick/Init funcionaria. Transcrito
* fielmente: SET DATASESSION TO (par_nDataSessionPai) dentro do Init, ANTES
* de DODEFAULT() (que dispara InicializarForm).
*
* this_oFormPai equivale a property customizada "parentform" do legado
* (RESERVED3 ClassInfo: antvalue/parentform/podatamgr/*calctotais).
* this_cAntValu equivale a "AntValu" (usada em GetPedido.Valid, fase
* posterior, para detectar troca de abreviacao digitada). poDataMgr nao tem
* equivalente nesta arquitetura (gnConnHandle compartilhado via config.prg).
*
* Caption/acentos sempre por CHR() - nunca literal acentuado em .PRG.
*
* Herda de: FormBase          BO associado: sigoppedBO
* Criado em: Fase 3 - Estrutura base (classe, Init, cabecalho)
*
* Fase 3/8: estrutura base e o cabecalho (cntSombra + lblSombra + lblTitulo).
* Fase 4/8: CommandGroup de acao "OK" (obj_4c_OK: btnSair/"Retornar" +
* btnGravar/"Gravar") - unico bloco de "botoes" real desta tela (nao ha
* cnt_4c_Botoes/cnt_4c_BotoesAcao genericos: o legado nao os tem, e
* inventa-los violaria o PILAR 1). BtnSalvarClick ja referencia os 8 campos
* txt_4c_* que entram na Fase 5 (forward reference resolvida quando aquela
* fase adicionar os controles via AddObject).
* Fase 5/8: Shape1 (moldura decorativa) + a PRIMEIRA linha de campos
* (Produto/Descricao/Cor/Tam./Qtde - getDPros/Say10/get_prod/Say1/getCor/
* Say2/getTam/Say4/GetQtde), transcritos do dump com compensacao NENHUMA de
* PageFrame (nao existe PageFrame aqui - os Tops do dump sao absolutos).
* TabIndex do dump confirma o agrupamento por linha (Say10=1 .. GetQtde=9
* na 1a linha; Say3=10 .. getTamanho=17 na 2a).
* Fase 6/8: a SEGUNDA linha de campos (Pedido/Repetir/Peso/Tam. -
* Say3/GetPedido/Say5/getRepetir/Say6/Get_Peso/Say7/getTamanho) + lookups
* completos: ValidarPedido/AbrirBuscaPedido (fwbuscasel sobre o cursor
* LOCAL CsTmpPed - FormBuscaAuxiliar.DefinirCursor()/.Mostrar(), regra
* CLAUDE.md #36/#37, pois NAO ha SQL Server envolvido),
* ValidarTamanho/AbrirLookupTamanho (fwbuscaext/SigCdTam via gnConnHandle,
* padrao canonico do projeto) e ValidarRepetir (limite contra
* GetQtde.Value, sem lookup). Todos ligados via BINDEVENT "LostFocus"
* (regra CLAUDE.md #47 - Valid do legado equivale a validar na SAIDA do
* campo, nunca KeyPress sem testar a tecla).
* Fase 7/8: a orquestracao completa do Init legado, que nao faz sentido
* fatiar em "visibilidade" (fase 7) e "SQL" (fase 8) porque no legado sao o
* MESMO bloco - a visibilidade de Say7/getTamanho depende diretamente do
* resultado da consulta de crTmpGru. Implementado em dois metodos chamados
* no fim de InicializarForm, apos TornarControlesVisiveis (que forca
* Visible=.T. em todo AddObject e precisa ser desfeito explicitamente para
* os dois controles condicionais):
*   - CarregarPedidosDisponiveis(): "lcSql = [Select a.cDopes, ...]" + 2
*     INDEX ON do Init - popula CsTmpPed (consumido por ValidarPedido/
*     AbrirBuscaPedido, ja implementados na Fase 6). Fonte de cDopes eh o
*     cursor TprMvCab do form PAI (visivel aqui via SET DATASESSION TO
*     par_nDataSessionPai, no Init).
*   - CarregarDadosProduto(): leitura de crTpmMvItn (Qtde via Count For Not
*     Empty + Get_Peso.Value = Pesos), as duas consultas de verificacao de
*     conexao (crTmpUni/crTmpGru) e a visibilidade condicional de Say7/
*     getTamanho (regra: Empty(lcTam) AND crTmpGru.TipoEstos em 3,4).
* Em ambos os metodos, falha de SQLEXEC (com conexao disponivel) aborta a
* abertura do form - "Return 0" do Init legado equivale a
* loc_lSucesso = .F. em InicializarForm (CREATEOBJECT devolve .F.). Sem
* conexao/parent form (harness de teste, ValidarUIFidelity) os dois metodos
* sao no-op bem-sucedido - mesmo padrao de FormSigOpPec.InicializarForm
* (loc_lModoValidacaoOuTeste).
*
* O "Load" do legado (=fConfigGeral()) NAO eh portado, de proposito: eh o
* mesmo caso ja decidido e documentado em FormSigOpOpe.prg/
* projeto\app\utils\fconfiggeral.prg - fConfigGeral era funcao GLOBAL da
* aplicacao legado que nao veio no acervo, e o que ela fazia (configuracao
* global) ja acontece antes: config.prg (SETs/paths/aliases), main.prg
* (conexao) e os proprios metodos de carga deste form. Chama-la aqui
* mascararia a ausencia em vez de mostra-la - regra #2 do CLAUDE.md: em
* codigo NOSSO nunca se chama fConfigGeral.
*
* "Release" do legado (so chamava ThisForm.poDataMgr.Release + DoDefault) -
* ja implementado em Destroy() desde a Fase 4 (poDataMgr nao existe nesta
* arquitetura).
*
* Fase 8/8: consolidacao final. Este form OPERACIONAL nao segue o roteiro
* generico de form CRUD (sem Page1=Lista/Page2=Dados, sem BtnBuscar/
* BtnEncerrar/BtnCancelar/CarregarLista/HabilitarCampos/LimparCampos/
* AjustarBotoesPorModo - o legado nao tem nenhum desses: sao DOIS botoes
* no SCX (btnGravar e btnSair), nao ha grade nem modo de edicao
* cancelavel, o unico "Buscar" eh o lookup de pedido/tamanho ja entregue
* na Fase 6 e o unico "Encerrar" eh BtnSairClick, na Fase 4) - inventa-los
* violaria o PILAR 1 e cria-los vazios violaria a regra de completude.
* O que esta fase fez:
*   - FormParaBO(): THIS.this_oBusinessObject era criado em
*     InicializarForm (Fase 3) e nunca usado - o handler do Gravar (Fase 7)
*     duplicava inline a mesma logica que
*     sigoppedBO.GravarAbreviacaoNosItens ja implementava desde a Fase 2.
*     FormParaBO() + THIS.this_oBusinessObject.Atualizar() substituem a
*     duplicacao (PILAR 3 - Form nao manipula o cursor de persistencia
*     direto).
*   - BOParaForm(): contrapartida da transferencia, consumida por
*     CarregarDadosProduto - a carga da tela passou a ser cursor -> BO
*     (CarregarDoCursor) -> tela, em vez de o Form ler coluna de cursor
*     para pintar campo.
*   - BtnSalvarClick: o handler do botao "Gravar" usa o NOME canonico do
*     projeto (BtnSalvarClick), nao o nome do objeto legado (btnGravar) -
*     o Caption continua "Gravar", transcrito do dump (PILAR 1), e o
*     handler do botao de abandono segue BtnSairClick, do Caption
*     "Retornar". Dentro dele: (a) as 5 leituras vestigiais do legado
*     passaram a ser GUARDADAS por USED()/PEMSTATUS - sem guarda, um alias
*     ausente estourava e caia no CATCH ANTES da gravacao, isto eh, codigo
*     morto matava o unico trabalho real do botao; (b) a falha de gravacao
*     deixou de ser muda (regra CLAUDE.md #20 - Atualizar() eh chamado
*     direto, fora do Salvar() que chama ExibirFalha()) e o dialogo so
*     fecha quando GRAVOU.
*   - ReadOnly = .T. nos 5 campos que o legado declara com
*     "When / Return .F." (get_prod/getDPros/getCor/getTam/GetQtde) -
*     estavam digitaveis no migrado, e produto/cor/tamanho sao justamente
*     as 3 chaves que FormParaBO entrega ao BO para localizar o item a
*     gravar.
*==============================================================================

DEFINE CLASS Formsigopped AS FormBase

    *==========================================================================
    * Propriedades visuais - transcritas do dump do SCX legado (secao
    * "PROPRIEDADES DE: SIGOPPED"). WindowType = 1: Show() desta classe
    * SEMPRE roda modal, mesmo sem parametro. ControlBox/TitleBar: sem X e
    * sem barra de titulo - nenhum botao de sistema desenha. AlwaysOnTop +
    * AutoCenter: dialogo flutuante centralizado sobre a tela do form pai.
    *==========================================================================
    Height      = 211
    Width       = 773
    DataSession = 2
    ShowWindow = 1
    BorderStyle = 2
    AutoCenter  = .T.
    ShowTips    = .T.
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    Movable     = .T.
    TitleBar    = 0
    WindowType  = 1
    AlwaysOnTop = .T.
    Caption     = "Informar Pedido"

    *==========================================================================
    * this_oFormPai - equivale a property customizada "parentform" do legado
    * ("LParameters pform,datses" + "Thisform.parentform = pform" no Init).
    * Referencia ao form de movimentacao que abriu este dialogo - usado em
    * fase posterior para localizar/alterar o cursor crTpmMvItn e para
    * reabilitar o form pai ao fechar ("ThisForm.ParentForm.Enabled = .t.").
    *==========================================================================
    this_oFormPai = .NULL.

    *==========================================================================
    * this_cAntValu - equivale a property customizada "AntValu" do legado
    * (RESERVED3 ClassInfo: "antvalue"). Usada no Valid de GetPedido (fase
    * posterior) para detectar se a abreviacao digitada mudou em relacao a
    * tentativa anterior ("If Type('This.Value') <> Type('ThisForm.AntValu')
    * Or This.Value <> ThisForm.AntValu / Replace UsuLibSal With ' ' ...").
    *==========================================================================
    this_cAntValu = ""

    *==========================================================================
    * Guardas de reentrancia dos lookups (regra CLAUDE.md #37/#47): o picker
    * modal tira o foco do campo, o que redispara o proprio LostFocus - sem
    * a guarda, um segundo dialogo seria empilhado por cima do primeiro.
    *==========================================================================
    this_lEmLookupPedido  = .F.
    this_lEmLookupTamanho = .F.

    *==========================================================================
    * Guardas de valor-nao-mudou (regra CLAUDE.md #47 - "Diferente do guard
    * de reentrancia acima: complementares"): LostFocus dispara SEMPRE que o
    * foco sai do campo, mesmo sem o usuario ter alterado o valor digitado,
    * enquanto o Valid do legado so disparava quando o valor MUDAVA. Sem
    * esta guarda, tabular pelo campo sem digitar nada reabriria o lookup
    * (ou repetiria a validacao de estoque) a cada passagem.
    *==========================================================================
    this_cUltimoValidarPedidoValidado  = ""
    this_cUltimoValidarTamanhoValidado = ""

    *==========================================================================
    * Init - replica "LParameters pform, datses" do legado. par_oFormPai e
    * par_nDataSessionPai sao OPCIONAIS: o harness de teste e a validacao de
    * UI instanciam o form sem parametro nenhum (CREATEOBJECT("Formsigopped")).
    * SET DATASESSION TO roda ANTES de DODEFAULT() (que dispara
    * InicializarForm via FormBase.Init), replicando a ordem exata do Init
    * legado ("Set Datasession To DatSes" eh a 1a linha executavel, antes de
    * qualquer SQL). NUNCA chamar InicializarForm aqui tambem - DODEFAULT()
    * chamar duas vezes estoura "member object already exists" nos AddObject).
    *==========================================================================
    PROCEDURE Init(par_oFormPai, par_nDataSessionPai)
        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
        ENDIF

        IF VARTYPE(par_nDataSessionPai) = "N" AND par_nDataSessionPai > 0
            SET DATASESSION TO (par_nDataSessionPai)
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - monta a estrutura base: fundo do form, Business
    * Object e o cabecalho (unico bloco visual entregue nesta fase). Os
    * demais blocos (CommandGroup OK, Shape1, campos) entram em
    * ConfigurarPageFrame nas fases seguintes, na mesma ordem do dump do SCX.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Fundo do form (legado: Picture = ..\framework\imagens\new_background.jpg)
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            *-- Garantir crTpmMvItn para o .ControlSource dos campos de
            *-- Produto/Descricao/Cor/Tam. (ConfigurarCamposProduto). Em
            *-- producao o cursor ja existe (mantido pelo form PAI, visivel
            *-- aqui via SET DATASESSION TO par_nDataSessionPai no Init);
            *-- sem form pai (harness de teste/ValidarUIFidelity instancia
            *-- sem parametro nenhum, na DataSession PRIVADA desta classe)
            *-- o placeholder evita "Alias 'CRTPMMVITN' is not found" ao
            *-- vincular o ControlSource. Padrao idem FormEnd.ConfigurarCampos.
            IF !USED("crTpmMvItn")
                CREATE CURSOR crTpmMvItn (cItens N(9,0), cPros C(14), DPros C(65), ;
                    CodCors C(14), CodTams C(14), Abrevis C(14), cItem2 N(9,0), ;
                    Opers C(14), Pesos N(9,3))
            ENDIF

            THIS.this_oBusinessObject = CREATEOBJECT("sigoppedBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio sigoppedBO.", ;
                    "Erro em InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.TornarControlesVisiveis(THIS)

                *-- Orquestracao do Init legado (ver comentario de cabecalho -
                *-- "Fase 7/8"). Falha de SQLEXEC com conexao disponivel
                *-- aborta a abertura do form, equivalente ao "Return 0" do
                *-- Init legado.
                IF THIS.CarregarPedidosDisponiveis() AND THIS.CarregarDadosProduto()
                    loc_lSucesso = .T.
                ELSE
                    loc_lSucesso = .F.
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

    *==========================================================================
    * ConfigurarPageFrame - orquestra a montagem visual. Nao existe PageFrame
    * real neste form (objeto raiz do legado eh "Class: form" generico, sem
    * frmcadastro/Page1=Lista/Page2=Dados) - o nome eh mantido so por
    * convencao com o restante do pipeline (mesmo padrao de FormSigOpPec.prg/
    * FormSigOpGar.prg, outros forms OPERACIONAIS sem PageFrame). Ordem de
    * criacao conforme o dump (ver SECAO 1 do codigo fonte): cntSombra ->
    * Shape1 -> OK -> campos (fases seguintes).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotaoAcao()
        THIS.ConfigurarCamposProduto()
        THIS.ConfigurarCamposPedido()
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - faixa cinza superior com o titulo da tela
    * (cntSombra do legado) e os dois labels sobrepostos que produzem o
    * efeito de sombra: lblSombra em preto (Top = 18) sob lblTitulo em branco
    * (Top = 17). Width/Height/Font/ForeColor transcritos do dump (secao
    * "PROPRIEDADES DE: SIGOPPED.cntSombra" e dos dois labels filhos).
    *
    * Os dois labels declaram WordWrap = .T. no dump: AutoSize = .F. + Width/
    * Height explicitos (regra CLAUDE.md #23 - AutoSize eh no-op em Label
    * criado por AddObject e, com WordWrap, descarta a Height).
    *
    * Caption = THIS.Caption transcreve o "ThisForm.cntSombra.lblSombra.
    * Caption = ThisForm.Caption" / "...lblTitulo.Caption = ThisForm.Caption"
    * do Init legado.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCab = THIS.cnt_4c_Sombra
        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCab.lbl_4c_LblSombra
            .AutoSize      = .F.
            .Top           = 18
            .Left          = 10
            .Width         = 769
            .Height        = 40
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = THIS.Caption
            .Visible       = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCab.lbl_4c_LblTitulo
            .AutoSize    = .F.
            .Top         = 17
            .Left        = 10
            .Width       = 769
            .Height      = 46
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Caption     = THIS.Caption
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotaoAcao - cria obj_4c_OK (CommandGroup "OK" do legado),
    * unico bloco de botoes desta tela: Buttons(1) = btnSair ("Retornar",
    * Cancel=.T.) e Buttons(2) = btnGravar ("Gravar"). Posicao/propriedades
    * EXATAS do dump (secao "PROPRIEDADES DE: SIGOPPED.OK"). BINDEVENT em
    * ButtonsClick delegando para metodo PUBLIC (regra CLAUDE.md #3 -
    * BINDEVENT exige metodo PUBLIC, PROTECTED falha em silencio).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotaoAcao()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("obj_4c_OK", "CommandGroup")
            WITH THIS.obj_4c_OK
                .Top          = -2
                .Left         = 616
                .Width        = 160
                .Height       = 85
                .ButtonCount  = 2
                .BackStyle    = 0
                .BorderStyle  = 0
                .SpecialEffect = 1
                .BorderColor  = RGB(136, 189, 188)
                .Themes       = .F.
                .Value        = 0
                .Visible      = .T.

                WITH .Buttons(1)
                    .Top         = 5
                    .Left        = 80
                    .Width       = 75
                    .Height      = 75
                    .FontBold    = .T.
                    .FontItalic  = .T.
                    .FontName    = "Comic Sans MS"
                    .FontSize    = 8
                    .WordWrap    = .T.
                    .Picture     = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                    .Caption     = "Retornar"
                    .MousePointer = 15
                    .ToolTipText = "[Esc] Voltar Para a Tela Principal da " + ;
                        "Opera" + CHR(231) + CHR(227) + "o"
                    .SpecialEffect = 0
                    .ForeColor   = RGB(90, 90, 90)
                    .BackColor   = RGB(255, 255, 255)
                    .Themes      = .F.
                    .Cancel      = .T.
                ENDWITH

                WITH .Buttons(2)
                    .Top         = 5
                    .Left        = 5
                    .Width       = 75
                    .Height      = 75
                    .FontBold    = .T.
                    .FontItalic  = .T.
                    .FontName    = "Comic Sans MS"
                    .FontSize    = 8
                    .Picture     = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                    .Caption     = "Gravar"
                    .MousePointer = 15
                    .ForeColor   = RGB(90, 90, 90)
                    .BackColor   = RGB(255, 255, 255)
                    .Themes      = .F.
                ENDWITH
            ENDWITH

            BINDEVENT(THIS.obj_4c_OK.Buttons(1), "Click", THIS, "BtnSairClick")
            BINDEVENT(THIS.obj_4c_OK.Buttons(2), "Click", THIS, "BtnSalvarClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotaoAcao")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarCamposProduto - Shape1 (moldura decorativa que emoldura toda
    * a area de campos - secao "PROPRIEDADES DE: SIGOPPED.Shape1" do dump,
    * BackStyle = 0 e sem BorderColor/FillColor customizados) + a PRIMEIRA
    * linha de campos do dump, na ordem do TabIndex (1 a 9): Say10/get_prod/
    * getDPros (Produto + descricao), Say1/getCor (Cor), Say2/getTam (Tam.)
    * e Say4/GetQtde (Qtde).
    *
    * Nao ha PageFrame neste form (objeto raiz do legado = "form" generico) -
    * os Top/Left sao os ABSOLUTOS do dump, sem qualquer compensacao.
    *
    * Os labels (classe "say" do legado) declaram Width/sem Alignment no
    * dump - transcritos com .Alignment = 0 e a Width EXATA declarada
    * (regra CLAUDE.md #23: Width presente no dump e legitima, nao
    * inventada). Format/InputMask = "" no dump de get_prod/getCor/getTam
    * sao override VAZIO do Form Designer - NAO transcritos (regra #49).
    * getDPros declara Format = "K!" (seleciona tudo ao focar + forca
    * maiuscula) - transcrito literalmente.
    *
    * get_prod/getDPros/getCor/getTam replicam o .ControlSource do dump
    * legado ("crTpmMvItn.<coluna>") - leitura em tempo real do cursor
    * mantido pelo form PAI (visivel aqui via SET DATASESSION TO
    * par_nDataSessionPai, no Init). Padrao idem FormEnd.prg/
    * FormSigReJur.prg: cursor placeholder garantido em InicializarForm
    * (IF !USED("crTpmMvItn") CREATE CURSOR ...) ANTES desta chamada, para
    * o binding nao estourar "Alias is not found" quando o form eh
    * instanciado sem o pai (harness de teste/ValidarUIFidelity). GetQtde
    * NAO tem ControlSource no dump - o legado atribui o .Value por codigo
    * (Count For ... + ThisForm.getQtde.Value = lnQtde), o que entra na
    * Fase 8 (orquestracao do Init); aqui recebe so o Value inicial 0.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposProduto()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("shp_4c_Shape1", "Shape")
            WITH THIS.shp_4c_Shape1
                .Top       = 89
                .Left      = 5
                .Width     = 585
                .Height    = 110
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label10", "Label")
            WITH THIS.lbl_4c_Label10
                .Top       = 92
                .Left      = 11
                .Width     = 40
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Produto"
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c__prod", "TextBox")
            WITH THIS.txt_4c__prod
                .Top               = 107
                .Left              = 11
                .Width             = 123
                .Height            = 23
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Alignment         = 3
                .MaxLength         = 14
                .SpecialEffect     = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .Visible           = .T.
                .ControlSource     = "crTpmMvItn.cPros"
                *-- "PROCEDURE When / Return .F." do legado (SECAO 3 do dump,
                *-- objetos get_prod/getDPros/getCor/getTam/GetQtde): estes 5
                *-- campos NAO sao digitaveis - exibem o item corrente de
                *-- crTpmMvItn e a quantidade a abreviar, calculados pelo Init.
                *-- ReadOnly = .T. eh a reproducao canonica de "When -> .f."
                *-- no sistema novo e PRESERVA a aparencia do legado, ao
                *-- contrario de Enabled = .F., que acinzentaria o campo
                *-- (violaria o PILAR 1). NUNCA BINDEVENT(..., "When", ...):
                *-- BINDEVENT DESCARTA o retorno do delegate, entao o campo
                *-- continuaria digitavel (regra CLAUDE.md #3) e o usuario
                *-- poderia trocar produto/cor/tamanho - justamente as 3
                *-- chaves que FormParaBO entrega ao BO para localizar o item
                *-- a gravar.
                .ReadOnly          = .T.
            ENDWITH

            THIS.AddObject("txt_4c_DPros", "TextBox")
            WITH THIS.txt_4c_DPros
                .Top               = 107
                .Left              = 137
                .Width             = 288
                .Height            = 23
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Format            = "K!"
                .SpecialEffect     = 1
                .BackColor         = RGB(255, 255, 255)
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(192, 192, 192)
                .ToolTipText       = "Descri" + CHR(231) + CHR(227) + "o do Produto"
                .Visible           = .T.
                .ControlSource     = "crTpmMvItn.DPros"
                *-- When -> .F. no legado (ver txt_4c__prod)
                .ReadOnly          = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.lbl_4c_Label1
                .Top       = 92
                .Left      = 428
                .Width     = 19
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Cor"
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Cor", "TextBox")
            WITH THIS.txt_4c_Cor
                .Top               = 107
                .Left              = 428
                .Width             = 45
                .Height            = 23
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Alignment         = 3
                .MaxLength         = 14
                .SpecialEffect     = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .Visible           = .T.
                .ControlSource     = "crTpmMvItn.CodCors"
                *-- When -> .F. no legado (ver txt_4c__prod)
                .ReadOnly          = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .Top       = 92
                .Left      = 476
                .Width     = 26
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Tam."
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Tam", "TextBox")
            WITH THIS.txt_4c_Tam
                .Top               = 107
                .Left              = 476
                .Width             = 45
                .Height            = 23
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Alignment         = 3
                .MaxLength         = 14
                .SpecialEffect     = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .Visible           = .T.
                .ControlSource     = "crTpmMvItn.CodTams"
                *-- When -> .F. no legado (ver txt_4c__prod)
                .ReadOnly          = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label4", "Label")
            WITH THIS.lbl_4c_Label4
                .Top       = 92
                .Left      = 524
                .Width     = 26
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Qtde"
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Qtde", "TextBox")
            WITH THIS.txt_4c_Qtde
                .Top               = 107
                .Left              = 524
                .Width             = 45
                .Height            = 23
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Alignment         = 3
                .MaxLength         = 14
                .SpecialEffect     = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .Value             = 0
                .Visible           = .T.
                *-- When -> .F. no legado (ver txt_4c__prod)
                .ReadOnly          = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCamposProduto")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarCamposPedido - a SEGUNDA linha de campos do dump (TabIndex
    * 10 a 17): Say3/GetPedido (abreviacao de pedido), Say5/getRepetir
    * (quantas vezes repetir a gravacao - a Caption do Say5 no dump legado
    * EH "Qtde", igual ao Say4 da 1a linha, mesmo rotulando um campo
    * diferente - transcrito literalmente, nao eh erro de digitacao desta
    * migracao), Say6/Get_Peso (peso, com InputMask "999999.999" do dump) e
    * Say7/getTamanho (tamanho alternativo, visibilidade condicional
    * adiada para a Fase 7 - aqui nasce Visible = .T., igual aos demais
    * controles criados via AddObject).
    *
    * GetPedido declara ControlSource = "" no dump (override VAZIO do Form
    * Designer, regra CLAUDE.md #49) - NAO transcrito. getTamanho nao
    * declara ControlSource/InputMask/Value no dump - sem override.
    *
    * BINDEVENT em "LostFocus" para os 3 campos com validacao (regra
    * CLAUDE.md #47) - ValidarPedido/ValidarTamanho abrem lookup quando o
    * valor digitado nao bate com o cursor/tabela de referencia;
    * ValidarRepetir so faz a checagem de limite (sem lookup).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposPedido()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("lbl_4c_Label3", "Label")
            WITH THIS.lbl_4c_Label3
                .Top       = 136
                .Left      = 11
                .Width     = 34
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Pedido"
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Pedido", "TextBox")
            WITH THIS.txt_4c_Pedido
                .Top               = 150
                .Left              = 11
                .Width             = 49
                .Height            = 23
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Alignment         = 3
                .MaxLength         = 14
                .SpecialEffect     = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .Value             = ""
                .Visible           = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label5", "Label")
            WITH THIS.lbl_4c_Label5
                .Top       = 136
                .Left      = 63
                .Width     = 26
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Qtde"
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Repetir", "TextBox")
            WITH THIS.txt_4c_Repetir
                .Top               = 150
                .Left              = 63
                .Width             = 45
                .Height            = 23
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Alignment         = 3
                .MaxLength         = 14
                .SpecialEffect     = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .Value             = 0
                .Visible           = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label6", "Label")
            WITH THIS.lbl_4c_Label6
                .Top       = 136
                .Left      = 110
                .Width     = 25
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Peso"
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Peso", "TextBox")
            WITH THIS.txt_4c_Peso
                .Top               = 150
                .Left              = 110
                .Width             = 118
                .Height            = 23
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Alignment         = 3
                .InputMask         = "999999.999"
                .MaxLength         = 14
                .SpecialEffect     = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .Value             = 0
                .Visible           = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label7", "Label")
            WITH THIS.lbl_4c_Label7
                .Top       = 136
                .Left      = 231
                .Width     = 26
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Tam."
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Tamanho", "TextBox")
            WITH THIS.txt_4c_Tamanho
                .Top               = 150
                .Left              = 231
                .Width             = 45
                .Height            = 23
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Alignment         = 3
                .MaxLength         = 14
                .SpecialEffect     = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .Value             = ""
                .Visible           = .T.
            ENDWITH

            BINDEVENT(THIS.txt_4c_Pedido,  "LostFocus", THIS, "ValidarPedido")
            BINDEVENT(THIS.txt_4c_Repetir, "LostFocus", THIS, "ValidarRepetir")
            BINDEVENT(THIS.txt_4c_Tamanho, "LostFocus", THIS, "ValidarTamanho")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCamposPedido")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarPedidosDisponiveis - transcricao do bloco inicial do Init
    * legado:
    *   lcSql = [Select a.cDopes, a.cnivels, a.nCors, a.padraos, a.Mercs,
    *       a.opers, b.abrevs, b.CadProds, b.Desmembs from SigCdMop a,
    *       SigCdOpe b, SigOpCdc c, SigOpCdi d
    *       Where a.cDopes = '<Dopes>' And a.cnivels = b.dopes And
    *       b.Abrevs <> ' ' And b.Dopes = c.Dopes And b.Dopes = d.Dopes And
    *       c.OpeInatvs <> 1]
    *   If Thisform.PodataMgr.SqlExecute(lcSql,'CsTmpPed') < 1 / Messagebox(
    *       'Favor Reinicializar o Processo!!!') / Return 0 / Endif
    *   Select CsTmpPed / Index On nCors Tag nCors / Index On Abrevs Tag Abrevs
    *
    * Popula CsTmpPed - cursor LOCAL consumido por ValidarPedido/
    * AbrirBuscaPedido (Fase 6, fwbuscasel). "TprMvCab.Dopes" eh o cursor do
    * form PAI de movimentacao (visivel aqui via SET DATASESSION TO
    * par_nDataSessionPai, no Init) - sem ele (harness de teste/
    * ValidarUIFidelity, instanciado sem form pai) a consulta eh pulada sem
    * erro, mesmo padrao das demais chamadas a THIS.this_oFormPai neste
    * arquivo. SqlExecute do legado mapeia para SQLEXEC(gnConnHandle, ...)
    * direto (regra do projeto - sem fSqlConector nesta arquitetura), mesmo
    * padrao de AbrirLookupTamanho.
    *
    * Retorna .F. somente quando a consulta FOI tentada (conexao e
    * TprMvCab disponiveis) e falhou - equivalente ao "Return 0" do Init
    * legado, que aborta a abertura do form inteiro.
    *==========================================================================
    PROTECTED PROCEDURE CarregarPedidosDisponiveis()
        LOCAL loc_cDopes, loc_cSQL, loc_nResultado, loc_lResultado, loc_oErro

        loc_lResultado = .T.

        IF !USED("TprMvCab") OR TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN loc_lResultado
        ENDIF

        TRY
            loc_cDopes = TratarNulo(TprMvCab.Dopes, "")

            loc_cSQL = "SELECT a.cDopes, a.cnivels, a.nCors, a.padraos, a.Mercs, " + ;
                "a.opers, b.abrevs, b.CadProds, b.Desmembs " + ;
                "FROM SigCdMop a, SigCdOpe b, SigOpCdc c, SigOpCdi d " + ;
                "WHERE a.cDopes = " + EscaparSQL(loc_cDopes) + " " + ;
                "AND a.cnivels = b.dopes AND b.Abrevs <> ' ' " + ;
                "AND b.Dopes = c.Dopes AND b.Dopes = d.Dopes AND c.OpeInatvs <> 1"

            IF USED("CsTmpPed")
                USE IN CsTmpPed
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "CsTmpPed")

            IF loc_nResultado < 1
                MsgAviso("Favor Reinicializar o Processo!!!", ;
                    "Falha na Conex" + CHR(227) + "o (CsTmpPed)")
                loc_lResultado = .F.
            ELSE
                SELECT CsTmpPed
                INDEX ON nCors  TAG nCors
                INDEX ON Abrevs TAG Abrevs
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarPedidosDisponiveis")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDadosProduto - transcricao do restante do Init legado:
    *   Select crTpmMvItn / lcCod=Cpros / lcCor=CodCors / lcTam=CodTams
    *   Select * from crTpmMvItn Where Cpros=lcCod And CodCors=lcCor And
    *       CodTams=lcTam And Empty(Abrevis) Into Cursor csItemAbr ReadWrite
    *   Count For Not Empty(Cpros) to lnQtde / getQtde.Value = lnQtde
    *   get_Peso.Value = crTpmMvItn.Pesos
    *   Say7.Visible=.F. / getTamanho.Visible=.F. / getTamanho.Value=lcTam
    *   SqlExecute(Select ... SigCdUni ..., 'crTmpUni') < 1 -> aborta
    *   SqlExecute(Select ... SigCdGrp ..., 'crTmpGru') < 1 -> aborta
    *   If Empty(lcTam) / If Inlist(crTmpGru.TipoEstos,3,4) / Say7.Visible=.T.
    *       / getTamanho.Visible=.T. / Endif / EndIf
    *
    * Say7/getTamanho nascem ocultos (regra acima) - reaplicado aqui porque
    * THIS.TornarControlesVisiveis (chamado antes desta rotina, em
    * InicializarForm) forca Visible=.T. em todo controle criado via
    * AddObject, inclusive estes dois.
    *
    * As consultas de SigCdUni/SigCdGrp servem no legado so para abortar a
    * tela com "Favor Reinicializar o Processo!!!" se a conexao falhar -
    * crTmpUni nunca eh lido depois (unica outra referencia no dump esta
    * dentro do bloco de desmembramento, comentado com "*!*" no SCX e NAO
    * transcrito - ver cabecalho de BtnSalvarClick); crTmpGru so fornece
    * TipoEstos para a visibilidade acima. Por isso os dois sao fechados
    * (USE IN) ao final deste metodo.
    *
    * Puladas (sem erro) em modo de teste/validacao de UI ou sem
    * gnConnHandle - mesmo padrao de FormSigOpPec.InicializarForm
    * (loc_lModoValidacaoOuTeste). Retorna .F. somente quando a consulta FOI
    * tentada e falhou - equivalente ao "Return 0" do Init legado.
    *==========================================================================
    PROTECTED PROCEDURE CarregarDadosProduto()
        LOCAL loc_cCod, loc_cCor, loc_cTam, loc_cSQL, loc_nResultado, ;
            loc_nQtdePendente, loc_lResultado, loc_lModoValidacaoOuTeste, ;
            loc_oErro

        loc_lResultado = .T.

        THIS.lbl_4c_Label7.Visible  = .F.
        THIS.txt_4c_Tamanho.Visible = .F.

        IF !USED("crTpmMvItn")
            RETURN loc_lResultado
        ENDIF

        loc_lModoValidacaoOuTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                                    (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)

        TRY
            SELECT crTpmMvItn
            loc_cCod = TratarNulo(cPros, "")
            loc_cCor = TratarNulo(CodCors, "")
            loc_cTam = TratarNulo(CodTams, "")

            IF USED("csItemAbr")
                USE IN csItemAbr
            ENDIF

            *-- m. explicito nas variaveis locais (regra do projeto - SELECT
            *-- VFP local sem m. resolve o identificador como COLUNA e
            *-- estoura "Column 'LOC_CXXX' is not found"), mesmo padrao do
            *-- SELECT identico em BtnSalvarClick.
            SELECT cItens FROM crTpmMvItn ;
                WHERE cPros = m.loc_cCod AND CodCors = m.loc_cCor AND CodTams = m.loc_cTam ;
                    AND EMPTY(Abrevis) ;
                INTO CURSOR csItemAbr READWRITE

            loc_nQtdePendente = RECCOUNT("csItemAbr")

            IF USED("csItemAbr")
                USE IN csItemAbr
            ENDIF

            *-- Transferencia cursor -> BO -> tela (PILAR 3 - o Form nao le
            *-- coluna de cursor para pintar campo). O BO carrega o item
            *-- corrente de crTpmMvItn (equivale a "lcCod = crTpmMvItn.Cpros /
            *-- lcCor = ... / lcTam = ..." e a "get_Peso.Value =
            *-- crTpmMvItn.Pesos" do Init legado) e BOParaForm pinta a tela.
            *-- A quantidade a abreviar e o tamanho inicial NAO sao coluna do
            *-- cursor - o legado os CALCULA ("Count For Not Empty(Cpros) to
            *-- lnQtde" e "ThisForm.getTamanho.Value = lcTam") -, por isso
            *-- entram nas properties do BO aqui, antes do BOParaForm.
            SELECT crTpmMvItn
            THIS.this_oBusinessObject.CarregarDoCursor("crTpmMvItn")
            THIS.this_oBusinessObject.this_nQtde        = loc_nQtdePendente
            THIS.this_oBusinessObject.this_cTamanhoNovo = loc_cTam

            THIS.BOParaForm()

            IF !loc_lModoValidacaoOuTeste AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED("crTmpUni")
                    USE IN crTmpUni
                ENDIF

                loc_cSQL = "SELECT a.* FROM SigCdUni a JOIN SigCdPro b ON a.Cunis = b.Cunis " + ;
                    "WHERE b.Cpros = " + EscaparSQL(loc_cCod)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crTmpUni")

                IF loc_nResultado < 1
                    MsgAviso("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (crTmpUni)")
                    loc_lResultado = .F.
                ELSE
                    IF USED("crTmpGru")
                        USE IN crTmpGru
                    ENDIF

                    loc_cSQL = "SELECT a.* FROM SigCdGrp a JOIN SigCdPro b ON a.CGrus = b.CGrus " + ;
                        "WHERE b.Cpros = " + EscaparSQL(loc_cCod)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crTmpGru")

                    IF loc_nResultado < 1
                        MsgAviso("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (crTmpGru)")
                        loc_lResultado = .F.
                    ELSE
                        IF EMPTY(loc_cTam)
                            SELECT crTmpGru
                            IF INLIST(crTmpGru.TipoEstos, 3, 4)
                                THIS.lbl_4c_Label7.Visible  = .T.
                                THIS.txt_4c_Tamanho.Visible = .T.
                            ENDIF
                        ENDIF

                        IF USED("crTmpGru")
                            USE IN crTmpGru
                        ENDIF
                    ENDIF
                ENDIF

                IF USED("crTmpUni")
                    USE IN crTmpUni
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDadosProduto")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarPedido - equivale ao "PROCEDURE Valid" de GetPedido do legado:
    * valida a abreviacao de pedido digitada contra o cursor LOCAL CsTmpPed
    * (populado pelo Init deste form - Fase 8). fwbuscasel pesquisa um
    * cursor VFP ja em memoria, NUNCA SQL Server - por isso o lookup usa
    * AbrirBuscaPedido/FormBuscaAuxiliar.DefinirCursor() (Pattern A, regra
    * CLAUDE.md #36/#37), nao o Init(gnConnHandle, ...) canonico de tabela.
    *
    * PUBLIC - exigido pelo BINDEVENT (regra #3). Ligado a "LostFocus", nao
    * "KeyPress" (regra #47). Guarda this_lEmLookupPedido evita picker
    * duplicado quando o Show() modal do lookup redispara este LostFocus.
    *
    * SEEK(..., "CsTmpPed", "Abrevs") exige o INDEX ON Abrevs TAG Abrevs do
    * Init legado (ver Fase 8) - aqui so consome, sem recriar o indice.
    *
    * THIS.this_oFormPai.ValidaEstoque()/Calc_valite() sao metodos do form
    * de movimentacao que abre este dialogo - fora do escopo de task779 -
    * chamados so quando o objeto e o metodo existem (regra CLAUDE.md sobre
    * chamada de property/metodo de objeto que o migrado local nao
    * declara), para o form nao estourar "Property X is not found" quando
    * instanciado sem pai (harness de teste/ValidarUIFidelity). O legado
    * referencia "CsPedidos.cNivels" nesta chamada - unica ocorrencia desse
    * nome em todo o dump (provavel residuo de copia de form irmao, ex.
    * SIGOPPRM) - transcrito como "CsTmpPed.cNivels" (cursor e coluna que
    * REALMENTE existem neste form, alimentados pelo mesmo Init que
    * dispara este Valid), guardado por USED("CsTmpPed").
    *
    * Sem RETURN dentro do TRY (regra CLAUDE.md #1) - loc_lEstoqueOk
    * substitui o "Return .f." do meio do metodo legado.
    *==========================================================================
    PROCEDURE ValidarPedido()
        LOCAL loc_cValor, loc_lEstoqueOk, loc_oErro

        IF THIS.this_lEmLookupPedido
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(THIS.txt_4c_Pedido.Value)

        *-- Guarda de valor-nao-mudou (regra CLAUDE.md #47): LostFocus
        *-- dispara sempre, mesmo sem o usuario ter alterado o campo -
        *-- sem isto o lookup/validacao de estoque repetiria a cada
        *-- passagem pelo campo, mesmo sem digitacao nova.
        IF loc_cValor == THIS.this_cUltimoValidarPedidoValidado
            RETURN
        ENDIF

        loc_lEstoqueOk = .T.

        TRY
            IF !EMPTY(loc_cValor)
                IF USED("CsTmpPed")
                    SELECT CsTmpPed
                    IF !SEEK(loc_cValor, "CsTmpPed", "Abrevs")
                        THIS.this_lEmLookupPedido = .T.
                        THIS.AbrirBuscaPedido()
                        THIS.this_lEmLookupPedido = .F.
                    ENDIF
                ENDIF

                IF USED("crTpmMvItn")
                    SELECT crTpmMvItn

                    IF TYPE("THIS.txt_4c_Pedido.Value") != TYPE("THIS.this_cAntValu") OR ;
                            THIS.txt_4c_Pedido.Value != THIS.this_cAntValu
                        REPLACE UsuLibSal WITH " " IN crTpmMvItn
                    ENDIF

                    IF VARTYPE(THIS.this_oFormPai) = "O" AND USED("CsTmpPed") AND ;
                            PEMSTATUS(THIS.this_oFormPai, "ValidaEstoque", 5)
                        loc_lEstoqueOk = THIS.this_oFormPai.ValidaEstoque(CsTmpPed.cNivels)
                    ENDIF

                    IF loc_lEstoqueOk
                        REPLACE ChkAbrevs WITH .F. IN crTpmMvItn
                    ELSE
                        THIS.txt_4c_Pedido.Value = ""
                    ENDIF
                ENDIF

                IF loc_lEstoqueOk
                    THIS.this_cAntValu = THIS.txt_4c_Pedido.Value
                ENDIF
            ELSE
                IF VARTYPE(THIS.this_oFormPai) = "O" AND ;
                        PEMSTATUS(THIS.this_oFormPai, "Calc_valite", 5)
                    THIS.this_oFormPai.Calc_valite()
                ENDIF
            ENDIF

            *-- Guarda de valor-nao-mudou (regra CLAUDE.md #47): registrada
            *-- so apos a validacao ter rodado sem excecao. Le o valor ATUAL
            *-- do campo (nao loc_cValor) porque o lookup/estoque invalido
            *-- pode te-lo alterado dentro deste mesmo TRY.
            THIS.this_cUltimoValidarPedidoValidado = ALLTRIM(THIS.txt_4c_Pedido.Value)
        CATCH TO loc_oErro
            THIS.this_lEmLookupPedido = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ValidarPedido")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirBuscaPedido - replica "CreateObject('fwbuscasel', 'CsTmpPed',
    * 'Abrevs', This.Value, 'Sele??o')" + AddColuna('Abrevs','','Abrev') +
    * AddColuna('cNivels','','Opera??o') do legado. fwbuscasel busca num
    * CURSOR LOCAL ja em memoria - usa FormBuscaAuxiliar.DefinirCursor()/
    * .Mostrar() (Pattern A) em vez do Init(gnConnHandle, <tabela>, ...)
    * canonico de SQL Server (regra CLAUDE.md #36/#37).
    *
    * DefinirCursor() ja chama mAddColuna() internamente com o nome do
    * campo como titulo (Cods/Abrevs) - resetar this_nColunas = 0 e chamar
    * mAddColuna() de novo para usar os titulos reais do legado ("Abrev"/
    * "Opera??o"), sem reimplementar o resto da configuracao do grid.
    *==========================================================================
    PROCEDURE AbrirBuscaPedido()
        LOCAL loc_oBusca, loc_oErro

        IF !USED("CsTmpPed")
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            loc_oBusca.DefinirCursor("CsTmpPed", "Abrevs", "cNivels", ;
                "Sele" + CHR(231) + CHR(227) + "o")
            loc_oBusca.this_nColunas = 0
            loc_oBusca.mAddColuna("Abrevs", "", "Abrev")
            loc_oBusca.mAddColuna("cNivels", "", "Opera" + CHR(231) + CHR(227) + "o")

            IF loc_oBusca.Mostrar()
                THIS.txt_4c_Pedido.Value = loc_oBusca.cCodigoSelecionado
            ENDIF

            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em AbrirBuscaPedido")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarTamanho - equivale ao "PROCEDURE Valid" de getTamanho do
    * legado: valida o codigo de tamanho digitado contra SigCdTam (tabela
    * SQL Server, via gnConnHandle - lookup canonico FormBuscaAuxiliar,
    * regra CLAUDE.md #36/#37). PUBLIC (regra #3), ligado a "LostFocus"
    * (regra #47). Guarda this_lEmLookupTamanho evita picker duplicado.
    *==========================================================================
    PROCEDURE ValidarTamanho()
        LOCAL loc_cValor, loc_oErro

        IF THIS.this_lEmLookupTamanho
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(THIS.txt_4c_Tamanho.Value)

        *-- Guarda de valor-nao-mudou (regra CLAUDE.md #47): LostFocus
        *-- dispara sempre, mesmo sem o usuario ter alterado o campo -
        *-- sem isto o lookup reabriria a cada passagem pelo campo.
        IF loc_cValor == THIS.this_cUltimoValidarTamanhoValidado
            RETURN
        ENDIF

        TRY
            IF !EMPTY(loc_cValor)
                THIS.this_lEmLookupTamanho = .T.
                THIS.AbrirLookupTamanho()
                THIS.this_lEmLookupTamanho = .F.
            ELSE
                THIS.txt_4c_Tamanho.Value = ""
            ENDIF

            *-- Registrada so apos a validacao ter rodado sem excecao.
            THIS.this_cUltimoValidarTamanhoValidado = ALLTRIM(THIS.txt_4c_Tamanho.Value)
        CATCH TO loc_oErro
            THIS.this_lEmLookupTamanho = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ValidarTamanho")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirLookupTamanho - replica "CreateObject('fwbuscaext',
    * Thisform.PodataMgr.pnIdConn, 'SigCdTam', 'crListaRemota', 'Cods',
    * Padr(this.Value,4), 'Sele??o', .T.)" + AddColuna('Cods','','C?digo')
    * + AddColuna('Descs','','Descri??o') do legado, no contrato canonico
    * do projeto (regra CLAUDE.md #37): Init ja tenta o match exato
    * (this_lAchouRegistro) - Show() so roda se NAO achou, e a atribuicao
    * so ocorre sob this_lSelecionou AND USED(cursor).
    *==========================================================================
    PROCEDURE AbrirLookupTamanho()
        LOCAL loc_oBusca, loc_oErro

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdTam", ;
                "cursor_4c_BuscaTamanho", "Cods", PADR(THIS.txt_4c_Tamanho.Value, 4), ;
                "Sele" + CHR(231) + CHR(227) + "o")

            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTamanho")
                SELECT cursor_4c_BuscaTamanho
                THIS.txt_4c_Tamanho.Value = ALLTRIM(cursor_4c_BuscaTamanho.Cods)
            ENDIF

            IF USED("cursor_4c_BuscaTamanho")
                USE IN cursor_4c_BuscaTamanho
            ENDIF

            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupTamanho")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarRepetir - equivale ao "PROCEDURE Valid" de getRepetir do
    * legado: nao eh lookup, apenas limita o valor digitado a GetQtde.Value
    * (quantidade de itens sem abreviacao). MESSAGEBOX do legado substituido por
    * MsgAviso (regra CLAUDE.md - MESSAGEBOX PROIBIDO; validacao de UI usa
    * MsgAviso, nao MsgErro). PUBLIC (regra #3), ligado a "LostFocus".
    *==========================================================================
    PROCEDURE ValidarRepetir()
        IF !EMPTY(THIS.txt_4c_Repetir.Value) AND !EMPTY(THIS.txt_4c_Qtde.Value)
            IF THIS.txt_4c_Repetir.Value > THIS.txt_4c_Qtde.Value
                MsgAviso("Quantidade Maior que a Quantidade de Itens.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                THIS.txt_4c_Repetir.Value = THIS.txt_4c_Qtde.Value
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnSairClick - equivale a "PROCEDURE btnSair.Click" do legado: reabilita
    * o form pai (ficava Enabled=.F. enquanto este dialogo modal estava aberto
    * - ver comportamento.json/this_oFormPai) e fecha o dialogo. PUBLIC -
    * exigido pelo BINDEVENT em ConfigurarBotaoAcao (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE BtnSairClick()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
        ENDIF

        THIS.Release()
    ENDPROC

    *==========================================================================
    * FormParaBO - transfere para o Business Object os campos digitados
    * neste dialogo (Pedido/Repetir/Peso/Tamanho novo - txt_4c_Pedido/
    * txt_4c_Repetir/txt_4c_Peso/txt_4c_Tamanho) junto com o produto/cor/
    * tamanho ATUAL do item (txt_4c__prod/txt_4c_Cor/txt_4c_Tam, ligados por
    * .ControlSource a crTpmMvItn - ver ConfigurarCamposProduto), usados pelo
    * BO para localizar o(s) item(ns) sem abreviacao em crTpmMvItn. Chamado por
    * BtnSalvarClick antes de THIS.this_oBusinessObject.Atualizar() (PILAR 3 -
    * a gravacao passa pela camada de negocio em vez de manipular o cursor
    * direto no Form).
    *==========================================================================
    PROCEDURE FormParaBO()
        WITH THIS.this_oBusinessObject
            .this_cProduto     = ALLTRIM(THIS.txt_4c__prod.Value)
            .this_cCor         = ALLTRIM(THIS.txt_4c_Cor.Value)
            .this_cTamanho     = ALLTRIM(THIS.txt_4c_Tam.Value)
            .this_cTamanhoNovo = ALLTRIM(THIS.txt_4c_Tamanho.Value)
            .this_cPedido      = ALLTRIM(THIS.txt_4c_Pedido.Value)
            .this_nQtde        = THIS.txt_4c_Qtde.Value
            .this_nRepetir     = THIS.txt_4c_Repetir.Value
            .this_nPeso        = THIS.txt_4c_Peso.Value
        ENDWITH
    ENDPROC

    *==========================================================================
    * BOParaForm - contrapartida de FormParaBO: pinta na tela o que o Business
    * Object carregou do cursor crTpmMvItn (CarregarDoCursor) mais os dois
    * valores que o Init legado CALCULA em vez de ler ("Count For Not
    * Empty(Cpros) to lnQtde" -> this_nQtde e "ThisForm.getTamanho.Value =
    * lcTam" -> this_cTamanhoNovo). Chamado por CarregarDadosProduto, que eh
    * a porta de entrada unica da carga desta tela.
    *
    * NAO toca txt_4c__prod/txt_4c_DPros/txt_4c_Cor/txt_4c_Tam: os quatro tem
    * .ControlSource = "crTpmMvItn.<coluna>" (transcrito do dump - ver
    * ConfigurarCamposProduto) e portanto se pintam sozinhos a partir do
    * cursor; atribuir .Value por cima brigaria com o binding e GRAVARIA no
    * cursor do form PAI o valor atribuido. As properties equivalentes do BO
    * (this_cProduto/this_cDescProduto/this_cCor/this_cTamanho) seguem sendo
    * carregadas - sao elas que FormParaBO entrega de volta ao BO como chave
    * de localizacao do item a gravar.
    *
    * Refresh() explicito nos dois campos pintados por codigo, como o legado
    * faz ("ThisForm.getQtde.Refresh" / "ThisForm.get_Peso.Refresh").
    *==========================================================================
    PROCEDURE BOParaForm()
        WITH THIS.this_oBusinessObject
            THIS.txt_4c_Qtde.Value    = .this_nQtde
            THIS.txt_4c_Peso.Value    = .this_nPeso
            THIS.txt_4c_Tamanho.Value = .this_cTamanhoNovo
        ENDWITH

        THIS.txt_4c_Qtde.Refresh()
        THIS.txt_4c_Peso.Refresh()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - equivale a "PROCEDURE btnGravar.Click" do legado:
    * aplica a abreviacao/peso/tamanho digitados neste dialogo nos itens
    * sem abreviacao do cursor crTpmMvItn (mantido pelo form pai, visivel aqui via
    * SET DATASESSION TO par_nDataSessionPai - ver Init), repetindo a
    * operacao THIS.txt_4c_Repetir.Value vezes (um item por repeticao). A
    * gravacao em si (o laco FOR 1 TO Repetir + localizacao do proximo item
    * sem abreviacao + REPLACE Abrevis/Pesos/CodTams, incluindo a replicacao
    * para o item-pai cItem2=0 e para o operador via CsTmpPed.Opers) esta em
    * sigoppedBO.GravarAbreviacaoNosItens() (regra CLAUDE.md PILAR 3 - Form
    * nao manipula cursor de persistencia direto, delega ao Business
    * Object); aqui so FormParaBO() + THIS.this_oBusinessObject.Atualizar()
    * (metodo PUBLIC do BO chamado direto pelo Form, regra CLAUDE.md #51 -
    * nao precisa passar por EditarRegistro()/Salvar() porque este dialogo
    * nao tem o ciclo classico "carregar um registro, editar, salvar": cada
    * clique em Gravar localiza dinamicamente, a cada repeticao, o PROXIMO
    * item ainda sem abreviacao - BusinessBase.Atualizar()/Inserir() sao
    * identicos aqui de proposito, ver Init do BO).
    *
    * Os 5 flags (_CarregaItens, _ChecaQtde, _ChecaOper, _ValidaGrade,
    * _SubNiv) que o legado calcula mas NUNCA consome no restante do metodo
    * em SIGOPPED.SCX sao vestigios de validacao ja removida, sem efeito
    * observavel - mantidos aqui so por fidelidade (leitura pura, sem
    * side-effect, transcrita LITERALMENTE do dump - regra CLAUDE.md #17).
    *
    * O bloco de insercao em crTpmMvIts (desmembramento por Qtds, linhas
    * comentadas com "*!*" no SCX legado) estava DESATIVADO no legado e NAO
    * eh transcrito - reativa-lo seria inventar comportamento que a producao
    * atual nao tem.
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lCarregaItens, loc_lChecaQtde, loc_lChecaOper, ;
            loc_lValidaGrade, loc_lSubNiv, loc_lGravou, loc_oErro

        loc_lGravou = .F.

        TRY
            *-- Flags vestigiais do legado (ver cabecalho): a leitura fica
            *-- GUARDADA por USED()/PEMSTATUS porque, sem guarda, um alias
            *-- ausente estoura e cai no CATCH ANTES da gravacao - codigo
            *-- morto mataria o unico trabalho real do botao. As expressoes
            *-- seguem LITERAIS (regra CLAUDE.md #17); so o acesso eh
            *-- condicionado.
            IF USED("crSigCdOpe") AND USED("crSigOpCdc") AND USED("crSigOpCdi") ;
                    AND USED("crTpmMvItn") AND VARTYPE(THIS.this_oFormPai) = "O" ;
                    AND PEMSTATUS(THIS.this_oFormPai, "Op_escolha", 5)
                loc_lCarregaItens = INLIST(crSigCdOpe.ItAutos, 1, 3, 4, 5) AND ;
                    THIS.this_oFormPai.Op_escolha = "INSERIR"
                loc_lChecaQtde = INLIST(crSigCdOpe.ChkQtdss, 1, 3, 4)
                loc_lChecaOper = (EMPTY(crSigOpCdc.ChkOpers) OR ;
                    crTpmMvItn.Opers = crSigOpCdc.ChkOpers)
                loc_lValidaGrade = (THIS.this_oFormPai.Op_escolha = "INSERIR" AND ;
                    crSigOpCdi.ValQtdSup = 1)
            ENDIF

            IF USED("TmpOperacao")
                SELECT TmpOperacao
                loc_lSubNiv = .F.
                SCAN FOR !EMPTY(Codigos)
                    loc_lSubNiv = .T.
                ENDSCAN
            ENDIF

            THIS.FormParaBO()

            *-- Falha de gravacao NUNCA eh muda (regra CLAUDE.md #20): aqui o
            *-- BO eh chamado por Atualizar() direto - fora do Salvar() da
            *-- BusinessBase, que eh quem chama ExibirFalha() -, entao a
            *-- mensagem fica por conta deste chamador quando o BO nao a
            *-- exibiu (this_lErroExibido = .F.). E o dialogo so fecha quando
            *-- GRAVOU: com erro ele permanece aberto para o usuario corrigir
            *-- (o legado fechava em qualquer caso, mas la a falha de cursor
            *-- interrompia o metodo com erro de runtime na cara do usuario em
            *-- vez de fechar calado).
            IF THIS.this_oBusinessObject.Atualizar()
                loc_lGravou = .T.
            ELSE
                IF !THIS.this_oBusinessObject.this_lErroExibido
                    IF !EMPTY(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cMensagemErro, "")))
                        MsgErro(ALLTRIM(THIS.this_oBusinessObject.this_cMensagemErro), "Gravar")
                    ELSE
                        MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                            "vel gravar o pedido nos itens.", "Gravar")
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lGravou
                IF VARTYPE(THIS.this_oFormPai) = "O"
                    THIS.this_oFormPai.Enabled = .T.
                ENDIF

                THIS.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnSalvarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - torna visiveis, recursivamente, os controles
    * criados via AddObject (que nascem com Visible = .F.). Percorre Pages de
    * PageFrame (nao ha nenhum neste form, mas o metodo fica generico/
    * reutilizavel para as fases seguintes) e Controls de Container.
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

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - equivale a "PROCEDURE Release" do legado (que so chamava
    * "ThisForm.poDataMgr.Release" + DoDefault). poDataMgr nao existe nesta
    * arquitetura (gnConnHandle eh compartilhado via config.prg, nao
    * instanciado por form) - nada a liberar alem do que FormBase.Destroy()
    * ja faz. DODEFAULT() OBRIGATORIO (regra CLAUDE.md Pattern #145 - sem
    * ele os popups do menu principal ficam com cache visual encolhido apos
    * este dialogo modal fechar).
    *==========================================================================
    PROCEDURE Destroy()
        RETURN DODEFAULT()
    ENDPROC

ENDDEFINE
