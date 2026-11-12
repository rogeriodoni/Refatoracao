*==============================================================================
* FORMSIGOPPEC.PRG
* Form de Selecao de Pecas / Imagens de Produtos (SigOpPec)
* Migracao de SIGOPPEC.SCX (task778)
*
* Form OPERACIONAL de layout proprio: o objeto raiz do legado eh "form"
* generico (nao frmcadastro), WindowType = 0 (modeless, NAO dialogo modal) e
* ControlBox/Closable = .F. + TitleBar = 0 - sem X e sem barra de titulo, a
* saida fica a cargo dos botoes de navegacao/fechamento criados pelo form
* pai ou pelos proprios botoes da tela (fases seguintes). Nao existe
* PageFrame nem Page1=Lista/Page2=Dados: a tela eh uma grade de 15 "slots"
* de imagem (containers Imagem1..Imagem15, cada um com Image + Label +
* CheckBox), um container de paginacao (Cnt_Pag) e um CommandGroup de
* navegacao (BOTOES_CONSULTA) - ver tasks\task778\layout.json.
*
* Aberto pelo form de consulta/selecao de produtos via "Do Form SigOpPec
* With ThisForm[, lAuto]" ("Parameters oObjForm, plAuto" no Init legado -
* ver comportamento.json, evento Init de SIGOPPEC). oObjForm eh a
* referencia ao form pai (usada em fase posterior para ler o filtro de
* promocao em Get_Promo quando plAuto = .F.); plAuto indica modo automatico
* (acionado por rotina em lote, sem UI do form pai disponivel).
*
* DataSession = 1 (CORRENTE/compartilhada, NUNCA 2/privada): o legado
* trabalha direto sobre os cursores locais do form pai (CrProdutos,
* Tmp_Imagens, CrImagens - ver cabecalho de SigOpPecBO.prg) por SELECT/SCAN
* sem qualificar sessao; em sessao privada esses cursores ficariam
* invisiveis e a paginacao/selecao nao acharia produto nenhum.
*
* Caption/acentos sempre por CHR() - nunca literal acentuado em .PRG.
*
* Herda de: FormBase          BO associado: SigOpPecBO
* Criado em: Fase 3 - Estrutura base (classe, Init, cabecalho)
*
* Fase 3/8: estrutura base e o cabecalho (cntSombra + lblSombra + lblTitulo).
* Fase 4/8: grade de 15 slots de imagem (Imagem1..Imagem15, cada um com
* Image + Label + CheckBox), o label de contagem de paginas (Pagina), o
* container de paginacao Cnt_Pag (flutuante - Visible = .F., so aparece via
* BOTOES_CONSULTA.Buttons(4)) e o CommandGroup de navegacao BOTOES_CONSULTA
* (Proxima Pagina/Pagina Anterior/Encerrar/Selecionar Pagina).
* Fase 5/8: primeiros 4 dos 7 botoes de acao standalone do topo
* (cmd_4c_GeraArquivo/cmd_4c_Command2/cmd_4c_Command1/cmd_4c_Exporta).
* Fase 6/8: os 3 botoes restantes (cmd_4c_Relpecas/cmd_4c_Command3/
* cmd_4c_Command4 - "Imprimir Produtos"/"Desmarcar Todos"/"Selecionar
* Todos") e os eventos dos CAMPOS da tela, ligados por BINDEVENT em
* VincularEventosCampos:
*   - Cnt_Pag.Text1.LostFocus -> ValidarPaginaSelecionada (validacao do
*     numero de pagina digitado + posicionamento de CrProdutos/Tmp_Imagens)
*   - Cnt_Pag.Command4.Click  -> FecharPainelPaginacao
*   - Imagem<N>.Check1.Click  -> ChkImagem<N>Click -> ChkImp(slot, N)
*     (marca/desmarca o produto no cursor de selecao CrImagens)
* NAO existe lookup nesta tela: o dump do legado nao tem fwBuscaExt/
* fwBuscaSel/fwBuscaInt/sigacess/mAddColuna em lugar nenhum, e o unico campo
* digitavel (Cnt_Pag.Text1, numero de pagina) nao consulta tabela de apoio -
* inventar um FormBuscaAuxiliar aqui violaria o PILAR 1 e a regra "NUNCA
* inventar tabelas de lookup que nao existem no original". Por isso a Fase 6
* entrega a validacao do campo em vez de um picker.
* Fase 7/8: eventos principais dos botoes. O prompt padrao do pipeline
* (template multi-fase) presume form CRUD e pede BtnIncluirClick/
* BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick - esta tela NAO tem
* esse conceito (o dump do legado nao tem Incluir/Alterar/Excluir em lugar
* nenhum: SIGOPPEC so navega paginas de produtos e marca/desmarca selecao).
* Os "eventos principais dos botoes" REAIS desta tela, pelo proprio
* roteiro das fases anteriores (comentario acima, Fase 6), sao os 7 botoes
* de acao do topo + os 4 botoes de BOTOES_CONSULTA, com a paginacao
* (PagInicial/MostFig) como suporte - entregues nesta fase:
*   - cmd_4c_GeraArquivo.Click  -> CmdGeraArquivoClick   (Do Form SigOpGar)
*   - cmd_4c_Command2.Click     -> CmdDesmarcarTelaClick  (Desmarcar Tela)
*   - cmd_4c_Command1.Click     -> CmdSelecionarTelaClick (Selecionar Tela)
*   - cmd_4c_Exporta.Click      -> CmdExportaClick        (Exportar Imagens)
*   - cmd_4c_Relpecas.Click     -> CmdRelPecasClick        (Imprimir Produtos)
*   - cmd_4c_Command3.Click     -> CmdDesmarcarTodosClick (Desmarcar Todos)
*   - cmd_4c_Command4.Click     -> CmdSelecionarTodosClick (Selecionar Todos)
*   - BOTOES_CONSULTA.Buttons(1) "PROXPAG" -> BotoesConsultaProxPagClick
*   - BOTOES_CONSULTA.Buttons(2) "ANTPAG"  -> BotoesConsultaAntPagClick
*   - BOTOES_CONSULTA.Buttons(3) "sair"    -> BotoesConsultaSairClick
*   - BOTOES_CONSULTA.Buttons(4) "Command1"-> BotoesConsultaSelPaginaClick
* Metodos de suporte (transcricao de paginicial/mostfig do legado + blocos
* repetidos de redesenho/paginacao, fatorados em metodos unicos por serem
* IDENTICOS em varios Click do dump - "a chamada mora no FUNIL"):
*   PagInicial, MontarSQLImagens, MostFig, RedesenharPaginaAtual,
*   FinalizarPaginacao, ReiniciarPaginacao, ReposicionarTmpImagens,
*   AtualizarCaptionPagina, ObterFiltroPromocao.
* Fase 8/8: consolidacao final - a orquestracao de abertura do Init legado
* inteiro (de "If fChecaAcesso" ate "ThisForm.cnt_Pag.Visible = .F."), que
* a Fase 7 anunciou para esta fase, e os metodos de apoio que a fecham:
*   - AjustarBotoesPorAcesso         <- "If fChecaAcesso('SigOpPec','EXPORTA')
*     / ThisForm.Exporta.Visible = .T. / Else ..." e os dois irmaos
*     (GERACAO -> GeraArquivo, IMPRIMIR -> RelPecas)
*   - PrepararProdutosModoAutomatico <- "If plAuto / Select * From
*     crCatalogo Into Cursor crProdutos ReadWrite / Index On Cpros Tag Cpros"
*   - CarregarLista                  <- "Select CrProdutos / Go Top /
*     If !Eof() / ThisForm.PagInicial()" mais o bloco "If !ThisForm.TelaInic"
*     (contagem, redesenho dos 15 slots, Primeira/Pag1/TotPag/NumPag e
*     caption). Funil UNICO de carga + repintura desta tela.
*   - FormParaBO / BOParaForm        <- sincronizacao do estado de paginacao
*     e do filtro de promocao entre a tela e SigOpPecBO (ver abaixo)
*   - BtnCancelarClick               <- Click de Cnt_Pag.Command4, o botao
*     com Cancel = .T. do painel "Selecione a Pagina :" (abandona a selecao
*     de pagina sem navegar); delega ao funil FecharPainelPaginacao, que as
*     duas recusas de ValidarPaginaSelecionada tambem usam - as mesmas tres
*     copias do bloco de 3 linhas do legado.
*
* FONTE UNICA do estado de paginacao: SigOpPecBO ja declarava (Fases 1/2)
* this_nTotalProdutos/this_nTotalPaginas/this_nPaginaAtual/this_nOrdena/
* this_lModoAutomatico/this_cPromocao/this_lFiltroPromocao para este exato
* proposito. FormParaBO EMPURRA o estado da tela para la (antes de cada
* consulta e no fecho de cada paginacao) e BOParaForm o TRAZ de volta,
* repintando o unico lugar em que esse estado aparece para o usuario - o
* caption "Pagina : NNN/NNN" (AtualizarCaptionPagina). Assim o numero
* exibido vem sempre do BO, nunca de uma segunda contagem feita na tela.
*
* O prompt padrao do pipeline (template multi-fase) presume form CRUD
* tambem nesta fase e pede, alem dos nomes acima, Btn(Buscar|Salvar)Click,
* HabilitarCampos, LimparCampos e AjustarBotoesPorModo. Esta tela nao tem o
* conceito correspondente e inventa-los violaria o PILAR 1 ("NUNCA
* inventar"): o dump do legado nao tem botao de busca, de gravacao, de modo
* de edicao nem campo a habilitar/limpar por modo - o unico campo digitavel
* eh o numero de pagina (Cnt_Pag.Text1), que o proprio painel zera ao abrir
* (BotoesConsultaSelPaginaClick). Os equivalentes REAIS do legado,
* entregues nesta fase e na anterior, sao: habilitacao por PERMISSAO em vez
* de por modo (AjustarBotoesPorAcesso), saida pelo botao "[ESC] Encerrar"
* do CommandGroup (BotoesConsultaSairClick) e, no lugar de gravar em
* tabela, as tres acoes que a tela de fato tem - exportar os JPG
* (CmdExportaClick), gerar arquivo (CmdGeraArquivoClick) e imprimir a
* relacao de pecas (CmdRelPecasClick).
*
* O "With ThisForm / .poDataMgr = CreateObject('fSqlConector') / With
* .poDataMgr / .AddCursor('SigOpGcp','CIdCHaves','CrSigOpGcp','','')" do
* Init legado NAO eh transcrito: na nova arquitetura a conexao eh
* gnConnHandle (config.prg) e o cursor CrSigOpGcp aberto por esse AddCursor
* nao eh lido em NENHUM ponto do dump - reproduzi-lo custaria um SELECT na
* abertura de toda tela sem nada que o consuma (decisao ja registrada no
* cabecalho de SigOpPecBO.prg).
*==============================================================================

DEFINE CLASS FormSigOpPec AS FormBase

    *==========================================================================
    * Propriedades visuais - transcritas do dump do SCX legado (secao
    * "PROPRIEDADES DE: SIGOPPEC"). WindowType = 0 (modeless): este form NAO
    * eh dialogo modal como os wrappers CREATEOBJECT + Show(1) - a instancia
    * eh aberta com "Do Form SigOpPec With <oPai>[, lAuto]" e fica junto com
    * o form chamador. ControlBox/Closable = .F. + TitleBar = 0: sem X e sem
    * barra de titulo, nenhum botao de sistema desenha.
    *==========================================================================
    Height       = 675
    Width        = 1000
    DataSession  = 1
    ShowWindow = 1
    BorderStyle  = 2
    AutoCenter   = .T.
    ShowTips     = .T.
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    TitleBar     = 0
    WindowType   = 0
    Themes       = .F.

    *==========================================================================
    * this_oFormPai - equivale a propriedade customizada poObjForm do legado
    * ("Parameters oObjForm" + "ThisForm.poObjForm = oObjForm" no Init).
    * Referencia ao form de consulta/selecao de produtos que abriu esta tela
    * - usada em fase posterior para ler o filtro de promocao
    * (poObjForm.Fld_Principal.Pag_Consulta.Filtro.Principal.Get_Promo.Value)
    * e para acessar o cursor de produtos filtrados (CrProdutos) por onde
    * este form navega.
    *==========================================================================
    this_oFormPai = .NULL.

    *==========================================================================
    * this_lAuto - equivale a propriedade customizada plauto do legado
    * ("Parameters oObjForm, plAuto" + "Thisform.plauto = plAuto" no Init).
    * .T. quando a tela eh aberta em modo automatico (sem UI do form pai
    * disponivel - rotina em lote): nesse caso o filtro de promocao fica
    * vazio (ver Init legado, "If thisform.plAuto / lcPromo = [] / Else...").
    *==========================================================================
    this_lAuto = .F.

    *==========================================================================
    * Estado de paginacao lido/escrito pelos handlers de campo desta fase -
    * equivale as properties customizadas homonimas do form legado:
    *
    *   this_nPrimeira -> Primeira : RECNO() de Tmp_Imagens UMA posicao DEPOIS
    *                     do ultimo produto desenhado na pagina corrente
    *                     ("ThisForm.Primeira = Recno()" no fim de PagInicial
    *                     do legado). ChkImp parte dela e volta para tras
    *                     (SKIP -Item) para achar a linha do slot clicado.
    *   this_nItem     -> Item     : quantos slots a pagina corrente de fato
    *                     preencheu (MostFig incrementa a cada imagem exibida;
    *                     a ultima pagina pode ter menos de 15).
    *   this_nTotReg   -> TotReg   : indice do registro de CrProdutos que
    *                     delimita a pagina (ver o LostFocus de Cnt_Pag.Text1 e
    *                     os Click de BOTOES_CONSULTA no legado).
    *
    * Zeradas aqui de proposito: quem as preenche eh a carga/paginacao
    * (PagInicial/MostFig e os Click de navegacao, fases seguintes) - que DEVE
    * reusar estas properties em vez de declarar outras. Os handlers desta
    * fase conferem o valor antes de usar: com this_nPrimeira ainda em 0 nao
    * existe pagina desenhada e nao ha slot para marcar.
    *==========================================================================
    this_nPrimeira = 0
    this_nItem     = 0
    this_nTotReg   = 0

    *==========================================================================
    * this_lValidandoPagina - guarda de reentrancia do handler ligado ao
    * LostFocus de Cnt_Pag.Text1. O proprio handler esconde o container do
    * campo (Cnt_Pag.Visible = .F.) e move o foco para outro controle
    * (BOTOES_CONSULTA), o que pode redisparar o LostFocus do mesmo TextBox;
    * sem a flag a validacao da pagina rodaria duas vezes e a navegacao
    * dispararia em duplicidade.
    *==========================================================================
    this_lValidandoPagina = .F.

    *==========================================================================
    * Estado de paginacao usado pelos eventos desta fase - equivalente as
    * properties customizadas homonimas do form legado (ver RESERVED3 do
    * dump: totpro/totpag/numpag/pag1/pag2/telainic):
    *   this_nTotPro -> TotPro   : total de produtos no filtro corrente.
    *   this_nTotPag -> TotPag   : total de paginas (Ceiling(TotPro/15)).
    *   this_nNumPag -> NumPag   : numero da pagina exibida, p/ o caption.
    *   this_lPag1   -> Pag1     : .T. quando a pagina corrente preencheu os
    *                   15 slots E ha produto depois (existe PROXIMA pagina).
    *   this_lPag2   -> Pag2     : mantida por fidelidade ao dump - nenhum
    *                   Click do legado LE o valor dela depois de escrito.
    *   this_lTelaInic -> TelaInic : .T. apos a primeira pagina ser montada.
    *==========================================================================
    this_nTotPro   = 0
    this_nTotPag   = 0
    this_nNumPag   = 0
    this_lPag1     = .F.
    this_lPag2     = .F.
    this_lTelaInic = .F.

    *==========================================================================
    * this_nOrdena - equivale a property customizada Ordena do legado
    * (declarada na lista de properties do SCX e escrita no Init:
    * "ThisForm.Ordena = 1"). Transcrita por fidelidade: nenhum metodo do
    * dump LE o valor dela depois de escrito - mesma situacao, ja
    * documentada acima, de this_lPag2. Vai para o BO em FormParaBO
    * (this_nOrdena), onde o estado da tela fica centralizado.
    *==========================================================================
    this_nOrdena   = 0

    *==========================================================================
    * Init - replica "Parameters oObjForm, plAuto" do legado. par_oObjForm e
    * par_lAuto sao OPCIONAIS: o harness de teste e a validacao de UI
    * instanciam o form sem parametro nenhum (CREATEOBJECT("FormSigOpPec")).
    * NUNCA chamar InicializarForm aqui tambem - DODEFAULT() -> FormBase.Init
    * object with this name already exists" nos AddObject.
    *==========================================================================
    PROCEDURE Init(par_oObjForm, par_lAuto)
        THIS.Caption = "Sele" + CHR(231) + CHR(227) + "o de Pe" + CHR(231) + "as"

        IF VARTYPE(par_oObjForm) = "O"
            THIS.this_oFormPai = par_oObjForm
        ENDIF

        IF VARTYPE(par_lAuto) = "L"
            THIS.this_lAuto = par_lAuto
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - monta a estrutura base: fundo do form, Business
    * Object e o cabecalho (unico bloco visual entregue nesta fase). Os
    * demais blocos (Cnt_Pag, Imagem1..15, BOTOES_CONSULTA, botoes de acao)
    * entram em ConfigurarPageFrame nas fases seguintes, na mesma ordem do
    * dump do SCX.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lModoValidacaoOuTeste, loc_oErro
        loc_lSucesso = .F.

        *-- Modo validacao de UI / teste automatizado: nao ha conexao SQL
        *-- disponivel, e a orquestracao de abertura do Init legado depende
        *-- dela em DOIS pontos - fChecaAcesso (que consulta SigCdAcu) e a
        *-- consulta das imagens da primeira pagina. Mesmo padrao de
        *-- FormSIGPRCOT.InicializarForm.
        loc_lModoValidacaoOuTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                                    (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)

        TRY
            *-- Fundo do form (legado: Picture = ..\framework\imagens\new_background.jpg)
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.this_oBusinessObject = CREATEOBJECT("SigOpPecBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpPecBO.", ;
                    "Erro em InicializarForm")
            ELSE
                *-- Copia o modo (automatico/interativo) recebido no Init para
                *-- o BO, que usa essa flag para decidir se consulta o filtro
                *-- de promocao do form pai (fase posterior).
                THIS.this_oBusinessObject.this_lModoAutomatico = THIS.this_lAuto

                THIS.CriarCursorImagens()
                THIS.ConfigurarPageFrame()

                THIS.TornarControlesVisiveis(THIS)

                *-- "ThisForm.Ordena = 1" do Init legado
                THIS.this_nOrdena = 1

                *-- Estado inicial da tela (modo automatico, filtro de
                *-- promocao do form pai e paginacao zerada) para o BO.
                THIS.FormParaBO()

                loc_lSucesso = .T.

                *-- Orquestracao de abertura do Init legado, na ordem do dump.
                *-- AjustarBotoesPorAcesso roda DEPOIS de
                *-- TornarControlesVisiveis, senao a visibilidade generica
                *-- sobrescreveria o Visible calculado por permissao.
                IF !loc_lModoValidacaoOuTeste
                    THIS.AjustarBotoesPorAcesso()
                    THIS.PrepararProdutosModoAutomatico()

                    IF THIS.CarregarLista()
                        *-- "ThisForm.Command1.Click()" do Init legado: a tela
                        *-- abre com TODOS os produtos da primeira pagina ja
                        *-- marcados. No legado essa chamada fica ENTRE a
                        *-- consulta e o bloco "If !TelaInic"; aqui vem depois
                        *-- do funil de carga porque CarregarLista tem de
                        *-- terminar repintando os slots (regra #21 - popular
                        *-- cursor NAO repinta a grade). O estado final eh o
                        *-- mesmo: os dois caminhos deixam flag = 1 em
                        *-- Tmp_Imagens, o produto em CrImagens, os 15 slots
                        *-- desenhados a partir do topo do cursor e
                        *-- this_nPrimeira no mesmo registro (RECNO() depois
                        *-- das 15 leituras).
                        THIS.CmdSelecionarTelaClick()
                    ELSE
                        *-- Legado: "Wait Window 'Produtos Nao Encontrados!!!
                        *-- Pressione <ENTER>...' / Return 0" - o Init legado
                        *-- ABORTA e a tela nao abre. MsgAviso em vez de WAIT
                        *-- WINDOW por regra do projeto (dialogo unico, e
                        *-- suprimido em modo de teste); loc_lSucesso = .F.
                        *-- faz InicializarForm devolver .F., que eh o
                        *-- equivalente do "Return 0" nesta arquitetura.
                        MsgAviso("Produtos N" + CHR(227) + "o Encontrados!!!", ;
                            "Sele" + CHR(231) + CHR(227) + "o de Pe" + CHR(231) + "as")
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF

                *-- "ThisForm.cnt_Pag.Visible = .F." - ultima linha do Init
                *-- legado. TornarControlesVisiveis ja deixa este container
                *-- fora da varredura (filtro de container flutuante), mas a
                *-- linha eh transcrita porque qualquer caminho acima pode
                *-- ter exibido o painel.
                THIS.cnt_4c__Pag.Visible = .F.
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
    * CriarCursorImagens - transcricao de PROCEDURE Load do legado:
    *   Create Cursor CrImagens (cpros c(14), dpros c(40), ... cBars c(10))
    * No SCX, Load() dispara ANTES do Init() - o cursor de selecao de
    * imagens precisa existir durante toda a vida do form, nao so quando
    * algum Click roda. Chamado no INICIO de InicializarForm (equivalente
    * mais proximo de "antes do Init" nesta arquitetura).
    *
    * SEM esta criacao, TODOS os metodos que leem/gravam em CrImagens
    * (ChkImp, CmdDesmarcarTelaClick, CmdSelecionarTelaClick, CmdExportaClick,
    * CmdRelPecasClick, CmdDesmarcarTodosClick, CmdSelecionarTodosClick,
    * BotoesConsultaProxPagClick, BotoesConsultaAntPagClick) ficariam mudos -
    * os helpers do BO (AdicionarAoCursorSelecao/RemoverDoCursorSelecao/
    * ExisteNoCursorSelecao) ja testam USED() e devolvem .F. em silencio, e
    * nenhum produto jamais seria marcado para a Relacao de Pecas.
    *
    * SET NULL ON antes do CREATE CURSOR (figjpgs eh M NULL no dump) - regra
    * CLAUDE.md: coluna NULL em cursor local precisa do SET explicito,
    * revertido logo depois para nao vazar para o resto do form.
    *==========================================================================
    PROTECTED PROCEDURE CriarCursorImagens()
        IF USED("CrImagens")
            USE IN CrImagens
        ENDIF

        SET NULL ON
        CREATE CURSOR CrImagens (cpros C(14), dpros C(40), linhas C(10), ;
            colecoes C(10), pvens N(12,2), moevs C(3), pesoms N(9,2), moepvs C(3), ;
            fvendas N(8,3), pcuss N(12,2), moecs C(3), reffs C(40), ifors C(10), ;
            datas D, cgrus C(3), cunis C(3), figjpgs M NULL, flag N(1), tconvs N(12,2), ;
            mconvs C(3), imppreco N(1), custofs N(12,2), moecusfs C(3), impcusto N(1), ;
            impcompo N(1), impreffor N(1), tpconvs N(12,2), mpconvs C(3), ImpFor N(1), ;
            dFors C(40), cBars C(10))
        SET NULL OFF
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - orquestra a montagem visual. Nao existe PageFrame
    * real neste form (objeto raiz do legado eh "Class: form" generico, sem
    * frmcadastro/Page1=Lista/Page2=Dados) - o nome eh mantido so por
    * convencao com o restante do pipeline (mesmo padrao de FormSigOpGar.prg,
    * outro form OPERACIONAL sem PageFrame). Ordem de criacao conforme o
    * dump (ver SECAO 1 do codigo fonte e layout.json): Cnt_Pag ->
    * Imagem1..Imagem15 -> Pagina -> GeraArquivo/Command1-4/Exporta/
    * relpecas (fase seguinte) -> cntSombra -> BOTOES_CONSULTA. O cabecalho
    * (cntSombra) foi criado ANTES (Fase 3) por conveniencia, mas isso nao
    * produz sobreposicao: os slots de imagem comecam em Top = 162 e
    * Cnt_Pag/Pagina em Top >= 82, fora da faixa Top = 0..80 da sombra.
    * BOTOES_CONSULTA (Top = -2, Left = 695) EH criado depois da sombra, de
    * proposito - ele se sobrepoe a faixa do cabecalho (legado: navegacao
    * flutua sobre a faixa, no canto superior direito).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarPaginacao()
        THIS.ConfigurarGradeImagens()
        THIS.ConfigurarBotoesAcao()
        THIS.ConfigurarBotoesNavegacao()
        THIS.VincularEventosCampos()
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - faixa cinza superior com o titulo da tela
    * (cntSombra do legado) e os dois labels sobrepostos que produzem o
    * efeito de sombra: lblSombra em preto (Top = 25) sob lblTitulo em
    * branco (Top = 24). Width/Height/Font/ForeColor transcritos do dump
    * (secao "PROPRIEDADES DE: SIGOPPEC.cntSombra" e dos dois labels
    * filhos). cntSombra.Width = 1008 (8px mais largo que o Form, que tem
    * Width = 1000) - valor do proprio dump, transcrito sem ajuste.
    *
    * Os dois labels declaram WordWrap = .T. no dump: AutoSize = .F. + Width/
    * Height explicitos (regra CLAUDE.md #23 - AutoSize eh no-op em Label
    * criado por AddObject e, com WordWrap, descarta a Height).
    *
    * Caption = THIS.Caption transcreve o "ThisForm.cntSombra.lblSombra.
    * Caption = ThisForm.Caption" / "...lblTitulo.Caption = ThisForm.Caption"
    * do Init legado - "Cadastro de Testes" no dump e' so o default generico
    * do Form Designer, sobrescrito em runtime pelo proprio legado.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCab = THIS.cnt_4c_Sombra
        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = 1008
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCab.lbl_4c_LblSombra
            .AutoSize      = .F.
            .Top           = 25
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
            .Top         = 24
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
    * ConfigurarPaginacao - Cnt_Pag do legado: painel de selecao de pagina
    * por numero digitado, acionado pelo botao "Selecionar Pagina" de
    * BOTOES_CONSULTA (fase seguinte implementa o Click que faz .Visible =
    * .T. aqui e .F. em obj_4c_BOTOES_CONSULTA). CONTAINER FLUTUANTE -
    * nasce com Visible = .F. (dump nao declara Visible explicito, mas o
    * comportamento legado - "BOTOES_CONSULTA.Visible = .F. / Cnt_Pag.
    * Visible = .T." no Click do botao - so faz sentido se Cnt_Pag comecar
    * oculto) e DEVE ser filtrado em TornarControlesVisiveis.
    *
    * Text1.InputMask = "9999999" (7 digitos) transcrito do dump - o
    * usuario digita o numero da pagina. Command4 eh o "Cancelar" deste
    * painel (Cancel = .T., Picture = cadastro_salvar_32.jpg - mesmo icone
    * usado por engano no legado, transcrito fielmente) que fecha o painel
    * sem navegar (fase seguinte implementa o Click). Como eh CommandButton
    * standalone com .Picture definido, aplica Themes = .T. + DisabledPicture
    * (regra CLAUDE.md sobre icone-only button nao renderizar com
    * Themes = .F. + Enabled = .F. futuro).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginacao()
        LOCAL loc_oPag

        THIS.AddObject("cnt_4c__Pag", "Container")
        loc_oPag = THIS.cnt_4c__Pag
        WITH loc_oPag
            .Top          = 82
            .Left         = 696
            .Width        = 292
            .Height       = 60
            .BackStyle    = 0
            .BorderWidth  = 0
            .SpecialEffect = 2
            .BackColor    = RGB(255, 255, 255)
            .Visible      = .F.
        ENDWITH

        loc_oPag.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPag.lbl_4c_Label1
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Selecione a P" + CHR(225) + "gina :"
            .Top       = 24
            .Left      = 66
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Text1", "TextBox")
        WITH loc_oPag.txt_4c_Text1
            .FontSize  = 8
            .Height    = 23
            .Width     = 52
            .Top       = 21
            .Left      = 166
            .InputMask = "9999999"
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("cmd_4c_Command4", "CommandButton")
        WITH loc_oPag.cmd_4c_Command4
            .Top             = 12
            .Left            = 223
            .Height          = 40
            .Width           = 40
            .FontName        = "Verdana"
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_32.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_32.jpg"
            .Cancel          = .T.
            .Caption         = ""
            .ToolTipText     = "Encerrar"
            .ForeColor       = RGB(36, 84, 155)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGradeImagens - os 15 slots de imagem (Imagem1..Imagem15 do
    * legado), dispostos em grade 5x3 (Left por coluna, Top por linha -
    * transcrito do dump), e o label de contagem de paginas (Pagina). Cada
    * slot eh um Container com Image (foto do produto), Label (codigo do
    * produto, preenchido em runtime por MostFig - fase seguinte) e um
    * CheckBox grafico (Style = 1, Picture/DownPicture do dump) que marca o
    * produto para a Relacao de Pecas (ChkImp - fase seguinte).
    *
    * .Caption do Label e .Picture/.Value do Check1 ficam vazios/default
    * aqui ("12345678901234" no dump eh dado de teste do Form Designer, nao
    * texto real) - MostFig() os preenche a cada pagina exibida.
    *
    * Imagem10.Visible = .F. no dump (unico dos 15): transcrito fielmente,
    * mas sem efeito pratico - TornarControlesVisiveis torna todos os 15
    * visiveis no Init, e a visibilidade real por pagina (menos de 15
    * produtos na ultima pagina) eh controlada em runtime por PagInicial/
    * MostFig (fase seguinte), nao neste metodo de montagem.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGradeImagens()
        LOCAL loc_nI, loc_nLinha, loc_nColuna, loc_cNome, loc_oImg
        LOCAL ARRAY loc_aLeftCol(5), loc_aTopLin(3)

        loc_aLeftCol(1) = 9
        loc_aLeftCol(2) = 207
        loc_aLeftCol(3) = 405
        loc_aLeftCol(4) = 603
        loc_aLeftCol(5) = 800

        loc_aTopLin(1) = 162
        loc_aTopLin(2) = 317
        loc_aTopLin(3) = 472

        FOR loc_nI = 1 TO 15
            loc_nLinha  = INT((loc_nI - 1) / 5) + 1
            loc_nColuna = MOD(loc_nI - 1, 5) + 1
            loc_cNome   = "cnt_4c_Imagem" + TRANSFORM(loc_nI)

            THIS.AddObject(loc_cNome, "Container")
            loc_oImg = EVALUATE("THIS." + loc_cNome)
            WITH loc_oImg
                .Top         = loc_aTopLin(loc_nLinha)
                .Left        = loc_aLeftCol(loc_nColuna)
                .Width       = 190
                .Height      = 150
                .BackStyle   = 1
                .BorderWidth = 1
                .BackColor   = RGB(207, 241, 241)
                .Visible     = IIF(loc_nI = 10, .F., .T.)
            ENDWITH

            loc_oImg.AddObject("img_4c_IMG", "Image")
            WITH loc_oImg.img_4c_IMG
                .Stretch = 1
                .Top     = 1
                .Left    = 1
                .Width   = 188
                .Height  = 109
                .Visible = .T.
            ENDWITH

            loc_oImg.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oImg.lbl_4c_Label1
                .AutoSize   = .F.
                .FontBold   = .T.
                .FontItalic = .F.
                .FontName   = "Tahoma"
                .FontSize   = 10
                .Alignment  = 2
                .BackStyle  = 0
                .Caption    = ""
                .Top        = 122
                .Left       = 2
                .Width      = 148
                .Height     = 18
                .ForeColor  = RGB(90, 90, 90)
                .Visible    = .T.
            ENDWITH

            loc_oImg.AddObject("chk_4c_Check1", "CheckBox")
            WITH loc_oImg.chk_4c_Check1
                .Top         = 112
                .Left        = 152
                .Width       = 38
                .Height      = 38
                .Style       = 1
                .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_32.jpg"
                .DownPicture = gc_4c_CaminhoIcones + "cadastro_salvar_32.jpg"
                .Alignment   = 0
                .Caption     = ""
                .Value       = 0
                .ToolTipText = "Seleciona p/ Rela" + CHR(231) + CHR(227) + "o de Pe" + CHR(231) + "as"
                .Visible     = .T.
            ENDWITH
        ENDFOR

        THIS.AddObject("lbl_4c_Pagina", "Label")
        WITH THIS.lbl_4c_Pagina
            .AutoSize = .F.
            .FontBold = .T.
            .FontSize = 12
            .FontName = "Tahoma"
            .BackStyle = 0
            .Caption  = "P" + CHR(225) + "gina : 000/000"
            .Top      = 130
            .Left     = 10
            .Width    = 143
            .Height   = 21
            .ForeColor = RGB(90, 90, 90)
            .Visible  = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesAcao - botoes de acao standalone do topo da tela
    * (GeraArquivo/Command2/Command1/Exporta/relpecas/Command3/Command4 do
    * legado), filhos diretos de SIGOPPEC, Top = 82 (mesma faixa de
    * Cnt_Pag, mas Left+Width de todos eles fica < 696 - nao ha sobreposicao
    * com o painel de paginacao). Transcritos do dump (secao "PROPRIEDADES
    * DE: SIGOPPEC.<Nome>") na MESMA ordem em que aparecem no SCX.
    *
    * Fase 5/8: primeiros 4 dos 7 botoes (GeraArquivo/Command2/Command1/
    * Exporta). Os 3 restantes (relpecas/Command3/Command4) e os Click de
    * TODOS os 7 entram na fase seguinte.
    *
    * CommandButton standalone com .Picture + Caption (nao icone-only) -
    * Themes = .F. transcrito fielmente do dump (mesmo padrao dos Buttons(N)
    * de BOTOES_CONSULTA); a regra de Themes = .T. + DisabledPicture (CLAUDE.
    * md) so se aplica quando o botao eh alternado por .Enabled em runtime, o
    * que nao ocorre aqui - GeraArquivo/Exporta/relpecas sao alternados por
    * .Visible (fChecaAcesso, Init legado linhas 1997-2010), e essa logica
    * de acesso fica para fase posterior (comportamento, nao estrutura).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        THIS.AddObject("cmd_4c_GeraArquivo", "CommandButton")
        WITH THIS.cmd_4c_GeraArquivo
            .Top             = 82
            .Left            = 3
            .Height          = 40
            .Width           = 105
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .Caption         = "Gerar Arquivo"
            .ToolTipText     = "Gera Arquivo"
            .SpecialEffect   = 0
            .PicturePosition = 1
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible         = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Command2", "CommandButton")
        WITH THIS.cmd_4c_Command2
            .Top             = 82
            .Left            = 423
            .Height          = 40
            .Width           = 105
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "simbolosl_erro_60.jpg"
            .Caption         = "Desmarcar Tela"
            .Enabled         = .T.
            .ToolTipText     = "Desmarcar Tudo Nesta Tela"
            .SpecialEffect   = 0
            .PicturePosition = 1
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible         = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Command1", "CommandButton")
        WITH THIS.cmd_4c_Command1
            .Top             = 82
            .Left            = 318
            .Height          = 40
            .Width           = 105
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "geral_selecionar_60.jpg"
            .Caption         = "Selecionar Tela"
            .Enabled         = .T.
            .ToolTipText     = "Marcar Tudo Nesta Tela"
            .SpecialEffect   = 0
            .PicturePosition = 1
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible         = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Exporta", "CommandButton")
        WITH THIS.cmd_4c_Exporta
            .Top             = 82
            .Left            = 213
            .Height          = 40
            .Width           = 105
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "exportar_48.png"
            .Caption         = "Exportar Imagens"
            .Enabled         = .T.
            .ToolTipText     = "Exporta Imagem"
            .SpecialEffect   = 0
            .PicturePosition = 1
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible         = .T.
        ENDWITH

        *-- relpecas: "Imprimir Produtos" (dump: Top=82 Left=108, TabIndex=2 -
        *-- entre GeraArquivo e Exporta na ordem de tabulacao do legado,
        *-- apesar de Left maior que Exporta).
        THIS.AddObject("cmd_4c_Relpecas", "CommandButton")
        WITH THIS.cmd_4c_Relpecas
            .Top             = 82
            .Left            = 108
            .Height          = 40
            .Width           = 105
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
            .Caption         = "Imprimir Produtos"
            .ToolTipText     = "Impress" + CHR(227) + "o"
            .SpecialEffect   = 0
            .PicturePosition = 1
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible         = .T.
        ENDWITH

        *-- Command4: "Selecionar Todos" (dump: Top=82 Left=528) - marca
        *-- TODOS os produtos do filtro corrente (crProdutos inteiro, nao so
        *-- a pagina visivel) - distinto de cmd_4c_Command1 "Selecionar
        *-- Tela", que marca so os 15 slots exibidos. Nome igual ao
        *-- cmd_4c_Command4 de cnt_4c__Pag (mapeamento.json mapeia os dois
        *-- "Command4" do dump para o mesmo nome migrado) - sem colisao em
        *-- VFP9 porque sao filhos de PAIS diferentes (THIS vs cnt_4c__Pag).
        THIS.AddObject("cmd_4c_Command4", "CommandButton")
        WITH THIS.cmd_4c_Command4
            .Top             = 82
            .Left            = 528
            .Height          = 40
            .Width           = 105
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "geral_marcar_60.jpg"
            .Caption         = "Selecionar Todos"
            .Enabled         = .T.
            .ToolTipText     = "Marcar Tudo Neste Filtro"
            .SpecialEffect   = 0
            .PicturePosition = 1
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible         = .T.
        ENDWITH

        *-- Command3: "Desmarcar Todos" (dump: Top=82 Left=633) - desmarca
        *-- TODOS os produtos do filtro corrente, distinto de cmd_4c_Command2
        *-- "Desmarcar Tela", que desmarca so os 15 slots exibidos.
        THIS.AddObject("cmd_4c_Command3", "CommandButton")
        WITH THIS.cmd_4c_Command3
            .Top             = 82
            .Left            = 633
            .Height          = 40
            .Width           = 105
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
            .Caption         = "Desmarcar Todos"
            .Enabled         = .T.
            .ToolTipText     = "Desmarcar Tudo Neste Filtro"
            .SpecialEffect   = 0
            .PicturePosition = 1
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesNavegacao - BOTOES_CONSULTA do legado: CommandGroup de
    * 4 botoes para navegar entre paginas de produtos. Ordem/geometria/
    * Picture/Caption transcritos do dump (secao "PROPRIEDADES DE:
    * SIGOPPEC.BOTOES_CONSULTA"). Mapeamento Buttons(N) -> nome legado ->
    * acao (Click implementado em fase seguinte):
    *   Buttons(1) "PROXPAG" -> Proxima Pagina
    *   Buttons(2) "ANTPAG"  -> Pagina Anterior
    *   Buttons(3) "sair"    -> [ESC] Encerrar (Cancel = .T.)
    *   Buttons(4) "Command1" (nome colidido no legado - mantido so como
    *              referencia do dump) -> Selecionar Pagina (abre Cnt_Pag)
    *
    * CommandGroup NAO tem ForeColor/BackColor proprios (regra CLAUDE.md
    * #33) - cor e fonte vao nos Buttons(N) individualmente, como o dump ja
    * declara. WITH .Buttons(N) aninhado dentro do WITH do grupo eh seguro
    * (1 nivel de nesting - regra CLAUDE.md sobre OptionGroup/CommandGroup).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesNavegacao()
        THIS.AddObject("obj_4c_BOTOES_CONSULTA", "CommandGroup")
        WITH THIS.obj_4c_BOTOES_CONSULTA
            .Top         = -2
            .Left        = 695
            .Width       = 310
            .Height      = 85
            .AutoSize    = .T.
            .ButtonCount = 4
            .BackStyle   = 0
            .BorderStyle = 0
            .Themes      = .F.
            .Visible     = .T.

            WITH .Buttons(1)
                .Top         = 5
                .Left        = 80
                .Height      = 75
                .Width       = 75
                .FontName    = "Comic Sans MS"
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontSize    = 8
                .WordWrap    = .T.
                .Picture     = gc_4c_CaminhoIcones + "geral_seta_dir_60.jpg"
                .Caption     = "\<Pr" + CHR(243) + "xima P" + CHR(225) + "gina"
                .ToolTipText = "Pr" + CHR(243) + "xima P" + CHR(225) + "gina"
                .PicturePosition = 7
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
            ENDWITH

            WITH .Buttons(2)
                .Top         = 5
                .Left        = 5
                .Height      = 75
                .Width       = 75
                .FontName    = "Comic Sans MS"
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontSize    = 8
                .WordWrap    = .T.
                .Picture     = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
                .Caption     = "P" + CHR(225) + "gina \<Anterior"
                .ToolTipText = "P" + CHR(225) + "gina Anterior"
                .PicturePosition = 7
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
            ENDWITH

            WITH .Buttons(3)
                .Top         = 5
                .Left        = 230
                .Height      = 75
                .Width       = 75
                .FontName    = "Comic Sans MS"
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontSize    = 8
                .WordWrap    = .T.
                .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel      = .T.
                .Caption     = "[ESC] Encerrar"
                .PicturePosition = 7
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
            ENDWITH

            WITH .Buttons(4)
                .Top         = 5
                .Left        = 155
                .Height      = 75
                .Width       = 75
                .FontName    = "Comic Sans MS"
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontSize    = 8
                .WordWrap    = .T.
                .Picture     = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                .Caption     = "Selecionar P" + CHR(225) + "gi\<na"
                .PicturePosition = 7
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * VincularEventosCampos - liga por BINDEVENT os eventos dos CAMPOS desta
    * tela (os controles com que o usuario interage dentro dos containers):
    *
    *   Cnt_Pag.Text1.LostFocus  -> ValidarPaginaSelecionada
    *   Cnt_Pag.Command4.Click   -> FecharPainelPaginacao
    *   Imagem<N>.Check1.Click   -> ChkImagem<N>Click -> ChkImp(slot, N)
    *
    * Os handlers sao PUBLIC (sem PROTECTED): BINDEVENT falha em SILENCIO com
    * metodo PROTECTED (regra CLAUDE.md #3).
    *
    * O evento do TextBox eh "LostFocus" porque o legado tem a validacao no
    * LostFocus de Cnt_Pag.Text1 (nao no Valid, nao no KeyPress) - ligar em
    * "KeyPress" faria a validacao rodar a cada digito e a tela trocaria de
    * pagina antes de o usuario terminar de digitar o numero (regra
    * CLAUDE.md #47).
    *
    * Os Click dos 7 botoes de acao do topo e dos 4 botoes de
    * BOTOES_CONSULTA (navegacao entre paginas) - entregues nesta fase (7/8) -
    * sao ligados aqui tambem. O BINDEVENT dos botoes do CommandGroup eh feito
    * em CADA .Buttons(N) (nao no grupo): o legado tem o codigo no Click de
    * cada botao - PROXPAG/ANTPAG/sair/Command1 -, e ValidarPaginaSelecionada
    * aciona Buttons(1)/Buttons(2) por chamada direta de .Click(), que so
    * dispara o delegate ligado ao PROPRIO botao.
    *==========================================================================
    PROTECTED PROCEDURE VincularEventosCampos()
        LOCAL loc_nI, loc_oChk

        BINDEVENT(THIS.cnt_4c__Pag.txt_4c_Text1, "LostFocus", THIS, "ValidarPaginaSelecionada")

        *-- Cnt_Pag.Command4 eh o botao de ABANDONO do painel de selecao de
        *-- pagina (Cancel = .T. no dump, ToolTipText "Encerrar"): o Click
        *-- dele fecha o painel sem navegar. O handler se chama
        *-- BtnCancelarClick por isso, e delega ao funil
        *-- FecharPainelPaginacao - que as duas recusas de
        *-- ValidarPaginaSelecionada tambem chamam, igual as tres copias do
        *-- mesmo bloco de 3 linhas no legado.
        BINDEVENT(THIS.cnt_4c__Pag.cmd_4c_Command4, "Click", THIS, "BtnCancelarClick")

        *-- Um handler por slot, igual ao legado: cada Imagem<N>.Check1 tem
        *-- seu proprio "ThisForm.ChkImp(This.Parent, N)". O delegate do
        *-- BINDEVENT nao recebe o objeto de origem, por isso o numero do
        *-- slot vem do NOME do handler, nao de um parametro.
        FOR loc_nI = 1 TO 15
            loc_oChk = EVALUATE("THIS.cnt_4c_Imagem" + TRANSFORM(loc_nI) + ".chk_4c_Check1")
            BINDEVENT(loc_oChk, "Click", THIS, "ChkImagem" + TRANSFORM(loc_nI) + "Click")
        ENDFOR

        *-- Botoes de acao standalone do topo (SECAO 3 do dump: GeraArquivo/
        *-- Command2/Command1/Exporta/relpecas/Command3/Command4 - filhos
        *-- diretos de SIGOPPEC).
        BINDEVENT(THIS.cmd_4c_GeraArquivo, "Click", THIS, "CmdGeraArquivoClick")
        BINDEVENT(THIS.cmd_4c_Command2,    "Click", THIS, "CmdDesmarcarTelaClick")
        BINDEVENT(THIS.cmd_4c_Command1,    "Click", THIS, "CmdSelecionarTelaClick")
        BINDEVENT(THIS.cmd_4c_Exporta,     "Click", THIS, "CmdExportaClick")
        BINDEVENT(THIS.cmd_4c_Relpecas,    "Click", THIS, "CmdRelPecasClick")
        BINDEVENT(THIS.cmd_4c_Command3,    "Click", THIS, "CmdDesmarcarTodosClick")
        BINDEVENT(THIS.cmd_4c_Command4,    "Click", THIS, "CmdSelecionarTodosClick")

        *-- BOTOES_CONSULTA (CommandGroup de navegacao) - Buttons(N), nome
        *-- legado entre parenteses (ver dump, secao BOTOES_CONSULTA).
        BINDEVENT(THIS.obj_4c_BOTOES_CONSULTA.Buttons(1), "Click", THIS, "BotoesConsultaProxPagClick")  && PROXPAG
        BINDEVENT(THIS.obj_4c_BOTOES_CONSULTA.Buttons(2), "Click", THIS, "BotoesConsultaAntPagClick")   && ANTPAG
        BINDEVENT(THIS.obj_4c_BOTOES_CONSULTA.Buttons(3), "Click", THIS, "BotoesConsultaSairClick")     && sair
        BINDEVENT(THIS.obj_4c_BOTOES_CONSULTA.Buttons(4), "Click", THIS, "BotoesConsultaSelPaginaClick") && Command1
    ENDPROC

    *==========================================================================
    * ValidarPaginaSelecionada - transcricao do LostFocus de
    * SIGOPPEC.Cnt_Pag.Text1 (secao 3 do dump): o usuario digita o numero da
    * pagina no painel "Selecione a Pagina :" e, ao sair do campo, a tela
    * posiciona CrProdutos/Tmp_Imagens no inicio dessa pagina, fecha o painel
    * e deixa a navegacao de BOTOES_CONSULTA desenhar as 15 imagens.
    *
    * Fidelidade ao legado, linha a linha:
    *   - Value menor ou igual a 0 -> so fecha o painel (sem mensagem)
    *   - (Value-1)*15 maior que RecCount(CrProdutos) -> avisa e fecha o painel
    *   - Value = 1 -> GO 16 e TotReg = 30 quando ha 16 ou mais produtos;
    *                  senao GO BOTTOM e TotReg = RecCount()
    *   - Value maior que 1 -> GO (Value-1)*15 e TotReg = (Value-1)*15
    *   - Tmp_Imagens -> GO TOP (pagina 1) ou GO BOTTOM, e grava cpros do
    *                    produto corrente de CrProdutos
    *   - Value = 1 -> aciona ANTPAG (Buttons(2)); senao PROXPAG (Buttons(1))
    *
    * O 15 e o 16/30 sao os literais do legado (tamanho da pagina = 15
    * slots), transcritos como estao - nao derivados de outra property.
    *
    * MsgAviso (nao MsgErro) para "Numero de Pagina Superior a Ultima": eh
    * validacao de entrada do usuario, nao falha tecnica. O texto eh o do
    * legado, que nao tem acento - transcrito como esta.
    *
    * Guarda a mais que o legado nao precisava: se CrProdutos nao estiver
    * aberto (painel acionado antes de qualquer carga de produtos), apenas
    * fecha o painel - no legado o cursor eh criado pelo form pai antes de a
    * tela abrir, aqui o SELECT estouraria "Alias not found".
    *==========================================================================
    PROCEDURE ValidarPaginaSelecionada()
        LOCAL loc_oTxt, loc_nPagina, loc_nRegistro, loc_lProsseguir
        LOCAL loc_lPaginaAnterior, loc_oErro

        *-- Guarda de reentrancia ANTES do TRY (regra CLAUDE.md #1: nenhum
        *-- RETURN dentro de TRY/CATCH).
        IF THIS.this_lValidandoPagina
            RETURN
        ENDIF

        THIS.this_lValidandoPagina = .T.

        loc_oTxt            = THIS.cnt_4c__Pag.txt_4c_Text1
        loc_nPagina         = loc_oTxt.Value
        loc_lProsseguir     = .T.
        loc_lPaginaAnterior = .F.

        TRY
            IF loc_nPagina <= 0
                THIS.FecharPainelPaginacao()
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND !USED("CrProdutos")
                THIS.FecharPainelPaginacao()
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                SELECT CrProdutos

                IF (loc_nPagina - 1) * 15 > RECCOUNT()
                    MsgAviso("Numero de Pagina Superior a Ultima !!!")
                    THIS.FecharPainelPaginacao()
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF loc_nPagina = 1
                    IF RECCOUNT() >= 16
                        GO 16
                        THIS.this_nTotReg = 30
                    ELSE
                        GO BOTTOM
                        THIS.this_nTotReg = RECCOUNT()
                    ENDIF
                ELSE
                    loc_nRegistro = (loc_nPagina - 1) * 15
                    GO loc_nRegistro
                    THIS.this_nTotReg = loc_nRegistro
                ENDIF

                IF USED("Tmp_Imagens")
                    SELECT Tmp_Imagens

                    IF loc_nPagina = 1
                        GO TOP
                    ELSE
                        GO BOTTOM
                    ENDIF

                    REPLACE cpros WITH CrProdutos.cpros
                ENDIF

                THIS.cnt_4c__Pag.Visible            = .F.
                THIS.obj_4c_BOTOES_CONSULTA.Visible = .T.

                loc_lPaginaAnterior = (loc_nPagina = 1)
            ENDIF
        CATCH TO loc_oErro
            loc_lProsseguir = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao selecionar p" + CHR(225) + "gina")
        ENDTRY

        *-- Flag liberada ANTES de acionar a navegacao: o Click do botao de
        *-- navegacao redesenha a pagina e mexe no foco, e com a flag ainda
        *-- ligada o LostFocus seguinte ficaria mudo para sempre.
        THIS.this_lValidandoPagina = .F.

        IF loc_lProsseguir
            IF loc_lPaginaAnterior
                THIS.obj_4c_BOTOES_CONSULTA.Buttons(2).Click()
            ELSE
                THIS.obj_4c_BOTOES_CONSULTA.Buttons(1).Click()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * FecharPainelPaginacao - transcricao do Click de
    * SIGOPPEC.Cnt_Pag.Command4: fecha o painel "Selecione a Pagina :" sem
    * navegar, devolve a barra de navegacao e poe o foco no botao
    * "Selecionar Pagina" (no legado "BOTOES_CONSULTA.Command1.SetFocus" -
    * Command1 eh o NOME do 4o botao do grupo, ver a secao de propriedades do
    * dump: Command4.Name = "Command1").
    *
    * Tambem eh o caminho de saida das duas recusas de
    * ValidarPaginaSelecionada, exatamente como no legado (as tres copias do
    * mesmo bloco de 3 linhas).
    *
    * O SetFocus fica em TRY proprio: ele roda com o container do campo
    * sendo escondido no mesmo instante (o legado faz igual) e em VFP9 mover
    * o foco de dentro de um LostFocus pode ser recusado em casos de borda -
    * foco recusado nao pode derrubar o fechamento do painel.
    *==========================================================================
    PROCEDURE FecharPainelPaginacao()
        LOCAL loc_oErro

        THIS.cnt_4c__Pag.Visible            = .F.
        THIS.obj_4c_BOTOES_CONSULTA.Visible = .T.

        TRY
            THIS.obj_4c_BOTOES_CONSULTA.Buttons(4).SetFocus()
        CATCH TO loc_oErro
            *-- Foco recusado (o controle acabou de ficar invisivel): o painel
            *-- ja esta fechado e a barra de navegacao ja esta visivel, nada a
            *-- desfazer. Sem MsgErro de proposito - o legado nao avisa nada
            *-- aqui, e um dialogo a cada fechamento de painel seria ruido.
        ENDTRY
    ENDPROC

    *==========================================================================
    * ChkImp - transcricao do PROCEDURE chkimp do legado
    * ("LParameters Imag, nShape"). Marca/desmarca o produto do slot clicado:
    *
    *   1. posiciona Tmp_Imagens em this_nPrimeira (1 registro DEPOIS do
    *      ultimo produto desenhado) e volta (this_nItem - nShape + 1)
    *      registros - a linha do slot clicado;
    *   2. inverte a coluna flag (0 para 1, 1 para 0) e espelha o valor no
    *      CheckBox do slot (o clique nativo do CheckBox alterna sozinho, e o
    *      legado sobrescreve com o valor que de fato ficou no cursor);
    *   3. flag = 0 -> remove o produto do cursor de selecao (CrImagens);
    *      flag = 1 -> insere com o layout de CrImagens (incluindo o codigo
    *      de barras por fAltBar2de5, dentro de AdicionarAoCursorSelecao);
    *   4. reposiciona Tmp_Imagens em this_nPrimeira (o legado repete o mesmo
    *      bloco de posicionamento no fim, para a proxima marcacao partir do
    *      mesmo ponto).
    *
    * O INSERT/DELETE em CrImagens fica no BO (AdicionarAoCursorSelecao com
    * par_lBuscarFornecedor = .F. - o chkimp do legado NAO consulta SigCdCli,
    * diferente de Command1/Command4.Click - e RemoverDoCursorSelecao).
    * CarregarDoCursor eh chamado DEPOIS do REPLACE para que this_nFlag leve
    * ao INSERT o valor novo (1), como no legado, que insere Tmp_Imagens.flag
    * ja invertido.
    *
    * Duas guardas que o legado nao tinha e aqui sao necessarias:
    *   - Tmp_Imagens fechado ou vazio: no legado os 15 slots so aparecem
    *     depois de PagInicial popular o cursor; aqui os containers nascem
    *     visiveis, entao o CheckBox pode ser clicado antes de qualquer
    *     carga. Nada a marcar - sai sem mexer em nada.
    *   - this_nPrimeira maior ou igual a 1: "GO 0" estoura "Record is out of
    *     range". O legado so testa "menor ou igual a RecCount()" porque
    *     nunca chega aqui com Primeira = 0 (PagInicial a define antes de a
    *     tela aparecer).
    *==========================================================================
    PROCEDURE ChkImp(par_oSlot, par_nShape)
        LOCAL loc_nItem, loc_nImp, loc_cCpros, loc_lProsseguir, loc_oErro

        loc_lProsseguir = .T.

        IF !USED("Tmp_Imagens")
            loc_lProsseguir = .F.
        ELSE
            IF RECCOUNT("Tmp_Imagens") = 0
                loc_lProsseguir = .F.
            ENDIF
        ENDIF

        IF loc_lProsseguir AND VARTYPE(par_oSlot) != "O"
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir
            TRY
                SELECT Tmp_Imagens

                IF THIS.this_nPrimeira >= 1 AND THIS.this_nPrimeira <= RECCOUNT()
                    GO THIS.this_nPrimeira
                ELSE
                    GO BOTTOM
                    IF !EOF()
                        SKIP
                    ENDIF
                ENDIF

                loc_nItem = THIS.this_nItem - par_nShape
                loc_nItem = loc_nItem + 1
                SKIP -loc_nItem

                loc_nImp = IIF(Tmp_Imagens.flag = 0, 1, 0)
                REPLACE Tmp_Imagens.flag WITH loc_nImp

                par_oSlot.chk_4c_Check1.Value = loc_nImp

                loc_cCpros = ALLTRIM(TratarNulo(Tmp_Imagens.cpros, ""))

                IF loc_nImp = 0
                    THIS.this_oBusinessObject.RemoverDoCursorSelecao("CrImagens", loc_cCpros)
                ELSE
                    SELECT Tmp_Imagens
                    THIS.this_oBusinessObject.CarregarDoCursor("Tmp_Imagens")
                    THIS.this_oBusinessObject.AdicionarAoCursorSelecao("CrImagens", .F.)
                ENDIF

                SELECT Tmp_Imagens

                IF THIS.this_nPrimeira >= 1 AND THIS.this_nPrimeira <= RECCOUNT()
                    GO THIS.this_nPrimeira
                ELSE
                    GO BOTTOM
                    IF !EOF()
                        SKIP
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao marcar produto")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * ChkImagem<N>Click - um handler por slot, espelhando o Click de cada
    * SIGOPPEC.Imagem<N>.Check1 do legado ("ThisForm.ChkImp(This.Parent, N)").
    * O container do slot entra como parametro porque o ChkImp espelha o
    * valor final no CheckBox daquele slot.
    *==========================================================================
    PROCEDURE ChkImagem1Click()
        THIS.ChkImp(THIS.cnt_4c_Imagem1, 1)
    ENDPROC

    PROCEDURE ChkImagem2Click()
        THIS.ChkImp(THIS.cnt_4c_Imagem2, 2)
    ENDPROC

    PROCEDURE ChkImagem3Click()
        THIS.ChkImp(THIS.cnt_4c_Imagem3, 3)
    ENDPROC

    PROCEDURE ChkImagem4Click()
        THIS.ChkImp(THIS.cnt_4c_Imagem4, 4)
    ENDPROC

    PROCEDURE ChkImagem5Click()
        THIS.ChkImp(THIS.cnt_4c_Imagem5, 5)
    ENDPROC

    PROCEDURE ChkImagem6Click()
        THIS.ChkImp(THIS.cnt_4c_Imagem6, 6)
    ENDPROC

    PROCEDURE ChkImagem7Click()
        THIS.ChkImp(THIS.cnt_4c_Imagem7, 7)
    ENDPROC

    PROCEDURE ChkImagem8Click()
        THIS.ChkImp(THIS.cnt_4c_Imagem8, 8)
    ENDPROC

    PROCEDURE ChkImagem9Click()
        THIS.ChkImp(THIS.cnt_4c_Imagem9, 9)
    ENDPROC

    PROCEDURE ChkImagem10Click()
        THIS.ChkImp(THIS.cnt_4c_Imagem10, 10)
    ENDPROC

    PROCEDURE ChkImagem11Click()
        THIS.ChkImp(THIS.cnt_4c_Imagem11, 11)
    ENDPROC

    PROCEDURE ChkImagem12Click()
        THIS.ChkImp(THIS.cnt_4c_Imagem12, 12)
    ENDPROC

    PROCEDURE ChkImagem13Click()
        THIS.ChkImp(THIS.cnt_4c_Imagem13, 13)
    ENDPROC

    PROCEDURE ChkImagem14Click()
        THIS.ChkImp(THIS.cnt_4c_Imagem14, 14)
    ENDPROC

    PROCEDURE ChkImagem15Click()
        THIS.ChkImp(THIS.cnt_4c_Imagem15, 15)
    ENDPROC

    *==========================================================================
    * ObterFiltroPromocao - transcricao do trecho repetido em quase todo
    * metodo do legado:
    *   If thisform.plAuto
    *       lcPromo = []
    *   Else
    *       lcPromo = ThisForm.poObjForm.Fld_Principal.Pag_Consulta.Filtro.
    *                 Principal.Get_Promo.Value
    *   Endif
    *
    * THIS.this_oFormPai eh a referencia ao form de consulta/selecao de
    * produtos (SigOpXxx) que abriu esta tela - fora do escopo desta
    * migracao (task778 eh so SIGOPPEC). Enquanto esse form pai nao existir
    * na nova arquitetura com a MESMA hierarquia de containers do legado
    * (Fld_Principal.Pag_Consulta.Filtro.Principal.Get_Promo), o caminho
    * profundo nao resolve - TRY/CATCH devolve "" exatamente como o ramo
    * plAuto = .T. do legado (sem filtro de promocao), sem fabricar
    * comportamento novo: EVALUATE com caminho pontuado inexistente estoura,
    * o CATCH pega e o resultado eh o MESMO de "nao ha promocao".
    *==========================================================================
    PROTECTED PROCEDURE ObterFiltroPromocao()
        LOCAL loc_cPromo, loc_oErro
        loc_cPromo = ""

        IF !THIS.this_lAuto AND VARTYPE(THIS.this_oFormPai) = "O"
            TRY
                loc_cPromo = TratarNulo(EVALUATE("THIS.this_oFormPai.Fld_Principal." + ;
                    "Pag_Consulta.Filtro.Principal.Get_Promo.Value"), "")
            CATCH TO loc_oErro
                loc_cPromo = ""
            ENDTRY
        ENDIF

        RETURN ALLTRIM(loc_cPromo)
    ENDPROC

    *==========================================================================
    * MontarSQLImagens - monta o SELECT usado por PagInicial/PROXPAG/ANTPAG/
    * CmdSelecionarTodosClick (paginicial/PROXPAG.Click/ANTPAG.Click/
    * Command4.Click do legado - os quatro repetem a MESMA lista de colunas,
    * so o WHERE e o "From SigCdPro a[,SigPrPmi p]" com o filtro de promocao
    * mudam). par_cWhereImg ja vem pronto (com os parenteses) de quem chama.
    *
    * Duas transcricoes NAO-literais, documentadas:
    *   1. "a.reffs" aparece DUAS VEZES no SELECT original (coluna Reffs e,
    *      mais adiante, de novo a.reffs no lugar que antecede "0 as flag").
    *      Nenhum ponto do form/BO le a segunda ocorrencia (CarregarDoCursor
    *      so tem THIS.this_cReffs = TratarNulo(reffs,"") UMA vez) - repetir
    *      o nome geraria coluna duplicada na resposta do SQL Server sem
    *      efeito nenhum, por isso nao se repete aqui.
    *   2. impcusto/impcompo/impreffor/tpconvs/mpconvs/ImpFor/dFors NAO estao
    *      no SELECT legado de Tmp_Imagens (ele so tem ate "imppreco" e
    *      "dfors" em branco) - mas SigOpPecBO.CarregarDoCursor() (Fase 1/2)
    *      le TODAS essas colunas de QUALQUER alias que receber, porque o
    *      mesmo metodo atende tanto CrImagens (31 colunas) quanto
    *      Tmp_Imagens. Sem elas aqui, CarregarDoCursor("Tmp_Imagens") (usado
    *      em ChkImp e em CmdSelecionarTelaClick) estouraria "Variable
    *      IMPCUSTO is not found" na PRIMEIRA vez que alguem marcasse um
    *      produto - o cursor nunca tinha sido montado de verdade antes desta
    *      fase para isso aparecer. Os valores adicionados sao EXATAMENTE os
    *      que o legado ja hardcodeia 0/branco no INSERT INTO CrImagens
    *      (chkimp: "...,0,0,0,lcBarra)" para impcusto/impcompo/impreffor) -
    *      nao eh regra de negocio nova, eh completar o layout que o proprio
    *      legado so preenche depois, no destino.
    *==========================================================================
    PROTECTED PROCEDURE MontarSQLImagens(par_cWhereImg, par_lPromo, par_cPromo)
        LOCAL loc_cSQL

        loc_cSQL = "SELECT a.cpros, a.dpros, a.linhas, a.colecoes, a.pvens, a.moevs, " + ;
            "a.pesoms, a.moepvs, a.fvendas, a.pcuss, a.cbars, a.moecs, a.reffs, " + ;
            "a.ifors, a.datas, a.cgrus, a.cunis, a.figjpgs, a.custofs, a.moecusfs, " + ;
            "0 AS flag, CAST(0 AS NUMERIC(12,2)) AS tconvs, SPACE(3) AS mconvs, " + ;
            "0 AS imppreco, 0 AS impcusto, 0 AS impcompo, 0 AS impreffor, " + ;
            "CAST(0 AS NUMERIC(12,2)) AS tpconvs, SPACE(3) AS mpconvs, 0 AS ImpFor, " + ;
            "SPACE(40) AS dfors" + IIF(par_lPromo, ", p.pecas", "") + ;
            " FROM SigCdPro a " + IIF(par_lPromo, ", SigPrPmi p", "") + ;
            " WHERE " + par_cWhereImg + ;
            IIF(par_lPromo, " AND p.CPros = a.CPros AND p.Promos = " + EscaparSQL(par_cPromo), "") + ;
            " ORDER BY " + IIF(par_lPromo, "p.Pecas, a.CPros", "a.CPros")

        RETURN loc_cSQL
    ENDPROC

    *==========================================================================
    * PagInicial - transcricao de PROCEDURE paginicial do legado: monta a
    * janela de ATE 15 produtos a partir da posicao CORRENTE de CrProdutos
    * (quem chama faz GO TOP antes, exatamente como no legado - Init/
    * CmdDesmarcarTodosClick/CmdSelecionarTodosClick) e recarrega Tmp_Imagens
    * com o resultado. NAO reposiciona CrProdutos para o inicio - responsa-
    * bilidade de quem chama, igual ao legado.
    *==========================================================================
    PROCEDURE PagInicial()
        LOCAL loc_cPromo, loc_lPromo, loc_cWhere, loc_nI, loc_cSQL, loc_nResultado, loc_oErro

        IF !USED("CrProdutos")
            RETURN
        ENDIF

        loc_cPromo = THIS.ObterFiltroPromocao()
        loc_lPromo = !EMPTY(loc_cPromo)

        loc_cWhere = "("
        SELECT CrProdutos
        FOR loc_nI = 1 TO 15
            IF !EOF("CrProdutos")
                loc_cWhere = loc_cWhere + "a.cpros = " + EscaparSQL(CrProdutos.cpros) + " OR "
                SKIP IN CrProdutos
            ENDIF
        ENDFOR
        loc_cWhere = SUBSTR(loc_cWhere, 1, LEN(loc_cWhere) - 3) + ")"

        TRY
            IF USED("Tmp_Imagens")
                USE IN Tmp_Imagens
            ENDIF

            loc_cSQL = THIS.MontarSQLImagens(loc_cWhere, loc_lPromo, loc_cPromo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "Tmp_Imagens")

            IF loc_nResultado < 0
                MsgErro("Erro ao consultar produtos para exibi" + CHR(231) + CHR(227) + "o." + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao montar p" + CHR(225) + "gina de produtos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * MostFig - transcricao de PROCEDURE mostfig do legado (a variante COM
    * "Clear Resources", que eh a chamada em TODO call site do dump -
    * "mosfig", sem o 't', esta declarada mas nunca referenciada: dead code).
    * Exibe o slot par_nNum (1 a 15) com o registro CORRENTE de Tmp_Imagens e
    * avanca (SKIP) para o proximo - por isso FOR Cnt = 1 TO 15 chamando
    * MostFig(Cnt) em sequencia percorre os ate-15 produtos da pagina.
    *
    * lcImg/xMac do legado (Sys(2015) + numero do slot) viram o nome do
    * arquivo temporario JPG decodificado do base64 - mantido via SYS(2015)
    * (identificador unico por sessao) + SYS(2023) (pasta temp do VFP), para
    * nao colidir nome de arquivo entre instancias/paginas.
    *==========================================================================
    PROCEDURE MostFig(par_nNum)
        LOCAL loc_cMac, loc_cArquivo, loc_cFoto, loc_oImg

        IF !USED("Tmp_Imagens")
            RETURN
        ENDIF

        loc_cMac = ALLTRIM(STR(par_nNum, 2))
        loc_oImg = EVALUATE("THIS.cnt_4c_Imagem" + loc_cMac)

        SELECT Tmp_Imagens
        IF !EOF()
            THIS.this_nItem = THIS.this_nItem + 1
            loc_cArquivo = SYS(2023) + "\" + ALLTRIM(SYS(2015)) + loc_cMac + ".jpg"

            IF !ISNULL(Tmp_Imagens.figjpgs) AND !EMPTY(Tmp_Imagens.figjpgs)
                CLEAR RESOURCES
                loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(Tmp_Imagens.figjpgs, ;
                    "data:image/png;base64,", ""), "data:image/jpeg;base64,", ""), ;
                    "data:image/jpg;base64,", ""), 14)
                STRTOFILE(loc_cFoto, loc_cArquivo)
                loc_oImg.Visible         = .T.
                loc_oImg.img_4c_IMG.Picture = loc_cArquivo
            ELSE
                loc_oImg.Visible         = .T.
                loc_oImg.img_4c_IMG.Picture = ""
            ENDIF

            loc_oImg.lbl_4c_Label1.Caption  = ALLTRIM(TratarNulo(Tmp_Imagens.cpros, ""))
            loc_oImg.chk_4c_Check1.Value    = Tmp_Imagens.flag
            SKIP
        ELSE
            loc_oImg.Visible = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * RedesenharPaginaAtual - bloco repetido em CmdDesmarcarTelaClick/
    * CmdSelecionarTelaClick e dentro dos blocos maiores (Init/Command2-4/
    * PROXPAG/ANTPAG do legado): "Select Tmp_Imagens / Go Top / Pag1=.F. /
    * Pag2=.F. / Item=0 / For Cnt=1 to 15 / MostFig(Cnt)". So redesenha os
    * slots com o conteudo ATUAL de Tmp_Imagens - nao reconsulta nada.
    *==========================================================================
    PROTECTED PROCEDURE RedesenharPaginaAtual()
        LOCAL loc_nCnt

        IF !USED("Tmp_Imagens")
            RETURN
        ENDIF

        SELECT Tmp_Imagens
        GO TOP
        THIS.this_lPag1 = .F.
        THIS.this_lPag2 = .F.
        THIS.this_nItem = 0

        FOR loc_nCnt = 1 TO 15
            THIS.MostFig(loc_nCnt)
        ENDFOR
    ENDPROC

    *==========================================================================
    * FinalizarPaginacao - fecho comum a Init/PROXPAG/ANTPAG/Command3/
    * Command4 do legado, executado IMEDIATAMENTE depois de
    * RedesenharPaginaAtual() e de this_nNumPag (e, quando aplicavel,
    * this_nTotPag) ja estarem atualizados pelo chamador:
    *   ThisForm.Primeira = Recno()
    *   ThisForm.Pag1 = (ThisForm.Item = 15 And Not Eof())
    *   ThisForm.Pagina.Caption = 'Pagina : '+Transf(NumPag,'@ 999')+'/'+...
    *   ThisForm.TelaInic = .T.
    *==========================================================================
    PROTECTED PROCEDURE FinalizarPaginacao()
        IF !USED("Tmp_Imagens")
            RETURN
        ENDIF

        THIS.this_nPrimeira = RECNO("Tmp_Imagens")
        THIS.this_lPag1     = (THIS.this_nItem = 15 AND !EOF("Tmp_Imagens"))
        THIS.this_lTelaInic = .T.

        *-- O caption da pagina ("Pagina : NNN/NNN") eh a UNICA projecao
        *-- visivel do estado de paginacao, e ele sai do BO: FormParaBO
        *-- empurra os totais recem-calculados e BOParaForm os traz de volta
        *-- e chama AtualizarCaptionPagina. Fonte unica - a tela nunca
        *-- recalcula o numero por conta propria.
        THIS.FormParaBO()
        THIS.BOParaForm()
    ENDPROC

    *==========================================================================
    * ReiniciarPaginacao - bloco "primeira pagina" repetido em Init/
    * CmdDesmarcarTodosClick/CmdSelecionarTodosClick do legado:
    *   Select CrProdutos / lTotReg = RecCount() / TotPro = lTotReg /
    *   TotReg = 15 / <redesenha a pagina> / Primeira = Recno() /
    *   Pag1 = (Item=15 And !Eof()) / TotPag = Ceiling(lTotReg/15) /
    *   NumPag = 1 / Pagina.Caption = ... / TelaInic = .T.
    *==========================================================================
    PROTECTED PROCEDURE ReiniciarPaginacao()
        LOCAL loc_nTotReg

        IF !USED("CrProdutos")
            RETURN
        ENDIF

        loc_nTotReg = RECCOUNT("CrProdutos")
        THIS.this_nTotPro = loc_nTotReg
        THIS.this_nTotReg = 15

        THIS.RedesenharPaginaAtual()

        THIS.this_nTotPag = CEILING(loc_nTotReg / 15)
        THIS.this_nNumPag = 1
        THIS.FinalizarPaginacao()
    ENDPROC

    *==========================================================================
    * AtualizarCaptionPagina - transcricao de
    *   ThisForm.Pagina.Caption = 'Pagina : '+Transf(NumPag,'@ 999')+'/'+
    *                              AllTrim(Transf(TotPag,'@ 999'))
    * NumPag SEM Alltrim (fica com espacos a esquerda, '@ 999'); TotPag COM
    * Alltrim - transcrito como esta, nao eh inconsistencia de migracao.
    *==========================================================================
    PROTECTED PROCEDURE AtualizarCaptionPagina()
        THIS.lbl_4c_Pagina.Caption = "P" + CHR(225) + "gina : " + ;
            TRANSFORM(THIS.this_nNumPag, "@ 999") + "/" + ;
            ALLTRIM(TRANSFORM(THIS.this_nTotPag, "@ 999"))
    ENDPROC

    *==========================================================================
    * ReposicionarTmpImagens - bloco repetido ao fim de GeraArquivo/Exporta/
    * relpecas.Click do legado:
    *   Select Tmp_Imagens / If Primeira<=RecCount() / Go Primeira / Else /
    *   Go Bottom / If !Eof() / Skip / EndIf / EndIf
    * Guarda this_nPrimeira >= 1 (igual ao ChkImp) porque "GO 0" estoura
    * "Record is out of range" - o legado nunca chega aqui com Primeira = 0
    * porque PagInicial sempre roda antes; aqui os botoes podem ser clicados
    * antes de qualquer pagina carregada.
    *==========================================================================
    PROTECTED PROCEDURE ReposicionarTmpImagens()
        IF !USED("Tmp_Imagens")
            RETURN
        ENDIF

        SELECT Tmp_Imagens
        IF THIS.this_nPrimeira >= 1 AND THIS.this_nPrimeira <= RECCOUNT()
            GO THIS.this_nPrimeira
        ELSE
            GO BOTTOM
            IF !EOF()
                SKIP
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdGeraArquivoClick - transcricao de SIGOPPEC.GeraArquivo.Click:
    *   Do Form SigOpGar With ThisForm
    *   <reposiciona Tmp_Imagens>
    * SigOpGar JA foi migrado (task738) como classe "Formsigopgar", que
    * aceita o form pai como 1o parametro opcional (Init(par_oFormPai)) -
    * equivalente exato do "With ThisForm" do legado. CREATEOBJECT dentro do
    * TRY, Show() FORA dele (regra CLAUDE.md #29 - Show() de form dentro de
    * TRY faz qualquer erro de runtime do dialogo fechar esta tela).
    *==========================================================================
    PROCEDURE CmdGeraArquivoClick()
        LOCAL loc_oForm, loc_oErro
        loc_oForm = .NULL.

        TRY
            loc_oForm = CREATEOBJECT("Formsigopgar", THIS)
        CATCH TO loc_oErro
            MsgErro("Erro ao abrir Gera" + CHR(231) + CHR(227) + "o de Arquivo:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
            loc_oForm = .NULL.
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF

        THIS.ReposicionarTmpImagens()
    ENDPROC

    *==========================================================================
    * CmdDesmarcarTelaClick - transcricao de SIGOPPEC.Command2.Click
    * ("Desmarcar Tela"): zera flag de TODOS os produtos da pagina CORRENTE
    * em Tmp_Imagens e remove cada um do cursor de selecao (CrImagens),
    * depois redesenha a pagina. Usa RemoverDoCursorSelecao, ja escrito no
    * BO para este exato proposito (ver cabecalho do SigOpPecBO.prg).
    *==========================================================================
    PROCEDURE CmdDesmarcarTelaClick()
        LOCAL loc_cCpros, loc_oErro

        IF !USED("Tmp_Imagens")
            RETURN
        ENDIF

        TRY
            SELECT Tmp_Imagens
            GO TOP
            SCAN
                REPLACE Tmp_Imagens.flag WITH 0
                loc_cCpros = ALLTRIM(TratarNulo(Tmp_Imagens.cpros, ""))
                THIS.this_oBusinessObject.RemoverDoCursorSelecao("CrImagens", loc_cCpros)
                SELECT Tmp_Imagens
            ENDSCAN

            THIS.RedesenharPaginaAtual()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao desmarcar produtos da tela")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdSelecionarTelaClick - transcricao de SIGOPPEC.Command1.Click
    * ("Selecionar Tela"): marca flag=1 de TODOS os produtos da pagina
    * CORRENTE e adiciona ao cursor de selecao (CrImagens) os que ainda nao
    * estavam la, buscando o fornecedor (par_lBuscarFornecedor = .T., como o
    * legado - unica diferenca do ChkImp, que nunca busca fornecedor).
    *==========================================================================
    PROCEDURE CmdSelecionarTelaClick()
        LOCAL loc_cCpros, loc_oErro

        IF !USED("Tmp_Imagens")
            RETURN
        ENDIF

        TRY
            SELECT Tmp_Imagens
            GO TOP
            SCAN
                REPLACE Tmp_Imagens.flag WITH 1
                loc_cCpros = ALLTRIM(TratarNulo(Tmp_Imagens.cpros, ""))

                IF !THIS.this_oBusinessObject.ExisteNoCursorSelecao("CrImagens", loc_cCpros)
                    SELECT Tmp_Imagens
                    THIS.this_oBusinessObject.CarregarDoCursor("Tmp_Imagens")
                    THIS.this_oBusinessObject.AdicionarAoCursorSelecao("CrImagens", .T.)
                ENDIF

                SELECT Tmp_Imagens
            ENDSCAN

            THIS.RedesenharPaginaAtual()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao selecionar produtos da tela")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdExportaClick - transcricao de SIGOPPEC.Exporta.Click ("Exportar
    * Imagens"): confirma com o usuario (MsgConfirma, NAO MessageBox - regra
    * CLAUDE.md), pede o diretorio destino (GetDir - funcao nativa VFP),
    * confere que o diretorio existe e grava um .JPG por produto de
    * CrImagens decodificando a figjpgs base64 (mesma rotina de MostFig).
    *
    * O legado repete a checagem Directory() a CADA iteracao do Scan - aqui
    * ela sai do loop (checagem invariante, nao regra de negocio) porque o
    * resultado NAO muda entre produtos.
    *==========================================================================
    PROCEDURE CmdExportaClick()
        LOCAL loc_cDirImagem, loc_cCodigo, loc_cArquivo, loc_cFoto, loc_oErro

        IF !MsgConfirma("Confirma Exporta" + CHR(231) + CHR(227) + "o das Imagens " + ;
                "Selecionadas ?", "")
            RETURN
        ENDIF

        loc_cDirImagem = GETDIR()

        IF !DIRECTORY(loc_cDirImagem)
            MsgErro("O Diret" + CHR(243) + "rio de Imagens [" + ALLTRIM(loc_cDirImagem) + "]" + ;
                CHR(13) + "N" + CHR(227) + "o Foi Encontrado ou o Acesso Foi Negado!!! " + ;
                "Verifique!!!", "")
            RETURN
        ENDIF

        IF !USED("CrImagens")
            RETURN
        ENDIF

        WAIT WINDOW "Aguarde Exportando Imagens !" NOWAIT

        TRY
            SELECT CrImagens
            GO TOP
            SCAN
                loc_cCodigo  = STRTRAN(STRTRAN(CrImagens.cpros, "/", ""), " ", "")
                loc_cArquivo = loc_cDirImagem + ALLTRIM(loc_cCodigo) + ".JPG"

                IF !ISNULL(CrImagens.figjpgs) AND !EMPTY(CrImagens.figjpgs)
                    loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(CrImagens.figjpgs, ;
                        "data:image/png;base64,", ""), "data:image/jpeg;base64,", ""), ;
                        "data:image/jpg;base64,", ""), 14)
                    STRTOFILE(loc_cFoto, loc_cArquivo)
                ENDIF
            ENDSCAN

            THIS.ReposicionarTmpImagens()

            WAIT CLEAR
            MsgInfo("Imagens Exportadas com Sucesso!!!" + CHR(13) + ;
                "Em " + ALLTRIM(loc_cDirImagem), "Exporta" + CHR(231) + CHR(227) + "o")
        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao exportar imagens")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdRelPecasClick - transcricao de SIGOPPEC.relpecas.Click ("Imprimir
    * Produtos"): le o filtro Operacao/OperacaoI/Empresa do form pai (so
    * quando NAO estiver em modo automatico - igual ao legado), completa
    * dFors em branco em CrImagens via ObterDescricaoFornecedor (ja escrito
    * no BO) e abre o relatorio "SigRePca".
    *
    * "SigRePca" (Relacao de Pecas) esta FORA do escopo desta task (task778
    * eh so SIGOPPEC) e ainda nao foi migrado - diferente de SigOpGar
    * (task738, ja existe como "Formsigopgar"). CREATEOBJECT fica dentro do
    * TRY; se a classe nao existir ainda, o erro cai no CATCH e MsgErro
    * avisa - caminho de erro PADRAO do projeto para dependencia ausente,
    * nao um stub: quando "FormSigRePca" for migrado, este Click passa a
    * abri-lo sem precisar de nenhuma mudanca aqui.
    *==========================================================================
    PROCEDURE CmdRelPecasClick()
        LOCAL loc_cOpe, loc_nNum, loc_cEmp, loc_cDesc, loc_oForm, loc_oErro, loc_lProsseguir
        loc_cOpe = ""
        loc_nNum = 0
        loc_cEmp = ""
        loc_oForm = .NULL.
        loc_lProsseguir = .T.

        IF !THIS.this_lAuto AND VARTYPE(THIS.this_oFormPai) = "O"
            TRY
                loc_cOpe = TratarNulo(EVALUATE("THIS.this_oFormPai.Fld_Principal." + ;
                    "Pag_Consulta.Filtro.Principal.Get_Opera" + CHR(231) + CHR(227) + "o.Value"), "")
                loc_nNum = TratarNulo(EVALUATE("THIS.this_oFormPai.Fld_Principal." + ;
                    "Pag_Consulta.Filtro.Principal.Get_Opera" + CHR(231) + CHR(227) + "oI.Value"), 0)
                loc_cEmp = TratarNulo(EVALUATE("THIS.this_oFormPai.Fld_Principal." + ;
                    "Pag_Consulta.Filtro.Principal.getEmps.Value"), "")
            CATCH TO loc_oErro
                loc_cOpe = ""
                loc_nNum = 0
                loc_cEmp = ""
            ENDTRY
        ENDIF

        IF USED("CrImagens")
            TRY
                SELECT CrImagens
                GO TOP
                SCAN
                    IF EMPTY(TratarNulo(CrImagens.dFors, ""))
                        loc_cDesc = THIS.this_oBusinessObject.ObterDescricaoFornecedor(CrImagens.ifors)
                        REPLACE dFors WITH loc_cDesc
                    ENDIF
                ENDSCAN
                GO TOP IN CrImagens
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ao preparar impress" + CHR(227) + "o")
                loc_lProsseguir = .F.
            ENDTRY
        ENDIF

        IF loc_lProsseguir
            TRY
                loc_oForm = CREATEOBJECT("FormSigRePca", loc_cOpe, loc_nNum, loc_cEmp)
            CATCH TO loc_oErro
                MsgErro("Erro ao abrir Relat" + CHR(243) + "rio de Rela" + CHR(231) + CHR(227) + ;
                    "o de Pe" + CHR(231) + "as:" + CHR(13) + loc_oErro.Message, "Erro")
                loc_oForm = .NULL.
            ENDTRY

            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.Show()
            ENDIF

            THIS.ReposicionarTmpImagens()
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdDesmarcarTodosClick - transcricao de SIGOPPEC.Command3.Click
    * ("Desmarcar Todos"): zera flag em Tmp_Imagens E CrImagens (UPDATE ...
    * SET Flag = 0 - os dois cursores LOCAIS do legado, nao tabela do SQL
    * Server), recarrega a primeira pagina do filtro corrente e redesenha.
    * O bloco grande comentado com "*!*" no dump (Scan produto a produto
    * reconsultando e removendo de CrImagens) esta DESATIVADO no legado -
    * nao transcrito, igual ao original comentado.
    *==========================================================================
    PROCEDURE CmdDesmarcarTodosClick()
        LOCAL loc_oErro

        TRY
            IF USED("Tmp_Imagens")
                UPDATE Tmp_Imagens SET flag = 0
            ENDIF
            IF USED("CrImagens")
                UPDATE CrImagens SET flag = 0
            ENDIF

            IF USED("CrProdutos")
                SELECT CrProdutos
                GO TOP
                IF !EOF()
                    THIS.PagInicial()
                ENDIF
            ENDIF

            THIS.CmdDesmarcarTelaClick()
            THIS.ReiniciarPaginacao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao desmarcar todos os produtos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdSelecionarTodosClick - transcricao de SIGOPPEC.Command4.Click
    * ("Selecionar Todos"): percorre TODOS os produtos de CrProdutos (nao so
    * a pagina visivel), um a um - consulta individual via MontarSQLImagens
    * com WHERE de UM produto, igual ao legado -, insere em CrImagens quando
    * ainda nao existe (par_lBuscarFornecedor = .T.) ou so marca flag = 1
    * quando ja existia. Por fim recarrega e redesenha a primeira pagina.
    *==========================================================================
    PROCEDURE CmdSelecionarTodosClick()
        LOCAL loc_cPromo, loc_lPromo, loc_cCodigo, loc_cWhere, loc_cSQL, loc_nResultado, loc_oErro

        IF !USED("CrProdutos")
            RETURN
        ENDIF

        loc_cPromo = THIS.ObterFiltroPromocao()
        loc_lPromo = !EMPTY(loc_cPromo)

        TRY
            SELECT CrProdutos
            GO TOP
            SCAN
                loc_cCodigo = ALLTRIM(TratarNulo(CrProdutos.cpros, ""))
                loc_cWhere  = "(a.cpros = " + EscaparSQL(loc_cCodigo) + ")"
                loc_cSQL    = THIS.MontarSQLImagens(loc_cWhere, loc_lPromo, loc_cPromo)

                IF USED("cursor_4c_LocalImg")
                    USE IN cursor_4c_LocalImg
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalImg")

                IF loc_nResultado >= 0 AND USED("cursor_4c_LocalImg") AND RECCOUNT("cursor_4c_LocalImg") > 0
                    IF !THIS.this_oBusinessObject.ExisteNoCursorSelecao("CrImagens", loc_cCodigo)
                        SELECT cursor_4c_LocalImg
                        THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_LocalImg")
                        THIS.this_oBusinessObject.this_nFlag = 1
                        THIS.this_oBusinessObject.AdicionarAoCursorSelecao("CrImagens", .T.)
                    ELSE
                        SELECT CrImagens
                        GO TOP
                        LOCATE FOR ALLTRIM(cpros) == loc_cCodigo
                        IF FOUND()
                            REPLACE flag WITH 1
                        ENDIF
                    ENDIF
                ENDIF

                IF USED("cursor_4c_LocalImg")
                    USE IN cursor_4c_LocalImg
                ENDIF

                SELECT CrProdutos
            ENDSCAN

            SELECT CrProdutos
            GO TOP
            IF !EOF()
                THIS.PagInicial()
            ENDIF

            THIS.CmdSelecionarTelaClick()
            THIS.ReiniciarPaginacao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao selecionar todos os produtos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BotoesConsultaProxPagClick - transcricao de BOTOES_CONSULTA.PROXPAG.
    * Click (Buttons(1), "Proxima Pagina"): avanca a janela de 15 produtos a
    * partir do ULTIMO cpros exibido em Tmp_Imagens. Se nao houver proximo
    * produto em CrProdutos (fim da lista), reposiciona Tmp_Imagens no
    * produto que estava sendo exibido e nao faz mais nada - igual ao legado.
    *==========================================================================
    PROCEDURE BotoesConsultaProxPagClick()
        LOCAL loc_cPromo, loc_lPromo, loc_cCodAtual, loc_cCodIni, loc_cWhere
        LOCAL loc_cSQL, loc_nResultado, loc_nI, loc_cCpros, loc_oErro

        IF !USED("Tmp_Imagens") OR !USED("CrProdutos")
            RETURN
        ENDIF

        TRY
            loc_cPromo = THIS.ObterFiltroPromocao()
            loc_lPromo = !EMPTY(loc_cPromo)

            THIS.this_nTotReg = IIF((THIS.this_nTotReg / 15) = THIS.this_nTotPag, ;
                THIS.this_nTotReg, THIS.this_nTotReg + 15)

            SELECT Tmp_Imagens
            loc_cCodAtual = Tmp_Imagens.cpros
            GO BOTTOM
            loc_cCodIni = Tmp_Imagens.cpros

            loc_cWhere = "("
            SELECT CrProdutos
            GO TOP
            LOCATE FOR ALLTRIM(cpros) == ALLTRIM(loc_cCodIni)

            IF FOUND()
                SKIP
                IF !EOF()
                    FOR loc_nI = 1 TO 15
                        IF !EOF("CrProdutos")
                            loc_cWhere = loc_cWhere + "a.cpros = " + EscaparSQL(CrProdutos.cpros) + " OR "
                            SKIP IN CrProdutos
                        ENDIF
                    ENDFOR
                    loc_cWhere = SUBSTR(loc_cWhere, 1, LEN(loc_cWhere) - 3) + ")"

                    IF USED("Tmp_Imagens")
                        USE IN Tmp_Imagens
                    ENDIF

                    loc_cSQL = THIS.MontarSQLImagens(loc_cWhere, loc_lPromo, loc_cPromo)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "Tmp_Imagens")

                    IF loc_nResultado >= 0
                        SELECT Tmp_Imagens
                        GO TOP
                        SCAN
                            loc_cCpros = ALLTRIM(TratarNulo(Tmp_Imagens.cpros, ""))
                            IF THIS.this_oBusinessObject.ExisteNoCursorSelecao("CrImagens", loc_cCpros)
                                REPLACE Tmp_Imagens.flag WITH 1
                            ENDIF
                            SELECT Tmp_Imagens
                        ENDSCAN

                        THIS.RedesenharPaginaAtual()

                        THIS.this_nNumPag = THIS.this_nTotReg / 15
                        THIS.FinalizarPaginacao()
                    ENDIF
                ELSE
                    SELECT Tmp_Imagens
                    GO TOP
                    LOCATE FOR ALLTRIM(cpros) == ALLTRIM(loc_cCodAtual)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao avan" + CHR(231) + "ar de p" + CHR(225) + "gina")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BotoesConsultaAntPagClick - transcricao de BOTOES_CONSULTA.ANTPAG.Click
    * (Buttons(2), "Pagina Anterior"): se o primeiro produto exibido JA eh o
    * primeiro de CrProdutos, nao ha pagina anterior - sai sem fazer nada
    * (igual ao legado, "Return(.T.)"). Senao volta 15 posicoes a partir do
    * produto atual e reconstroi a janela.
    *==========================================================================
    PROCEDURE BotoesConsultaAntPagClick()
        LOCAL loc_cPromo, loc_lPromo, loc_cCodAtual, loc_cWhere
        LOCAL loc_cSQL, loc_nResultado, loc_nI, loc_cCpros, loc_oErro

        IF !USED("Tmp_Imagens") OR !USED("CrProdutos")
            RETURN
        ENDIF

        SELECT Tmp_Imagens
        GO TOP
        loc_cCodAtual = Tmp_Imagens.cpros

        SELECT CrProdutos
        GO TOP
        IF ALLTRIM(CrProdutos.cpros) == ALLTRIM(loc_cCodAtual)
            RETURN
        ENDIF

        TRY
            loc_cPromo = THIS.ObterFiltroPromocao()
            loc_lPromo = !EMPTY(loc_cPromo)

            THIS.this_nTotReg = IIF((THIS.this_nTotReg - 15) < 0, THIS.this_nTotReg, ;
                THIS.this_nTotReg - 15)

            loc_cWhere = "("
            SELECT CrProdutos
            LOCATE FOR ALLTRIM(cpros) == ALLTRIM(loc_cCodAtual)

            IF FOUND()
                SKIP -15 IN CrProdutos

                FOR loc_nI = 1 TO 15
                    SELECT CrProdutos
                    loc_cWhere = loc_cWhere + "a.cpros = " + EscaparSQL(CrProdutos.cpros) + " OR "
                    SKIP IN CrProdutos
                ENDFOR
                loc_cWhere = SUBSTR(loc_cWhere, 1, LEN(loc_cWhere) - 3) + ")"

                IF USED("Tmp_Imagens")
                    USE IN Tmp_Imagens
                ENDIF

                loc_cSQL = THIS.MontarSQLImagens(loc_cWhere, loc_lPromo, loc_cPromo)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "Tmp_Imagens")

                IF loc_nResultado >= 0
                    SELECT Tmp_Imagens
                    GO TOP
                    SCAN
                        loc_cCpros = ALLTRIM(TratarNulo(Tmp_Imagens.cpros, ""))
                        IF THIS.this_oBusinessObject.ExisteNoCursorSelecao("CrImagens", loc_cCpros)
                            REPLACE Tmp_Imagens.flag WITH 1
                        ENDIF
                        SELECT Tmp_Imagens
                    ENDSCAN

                    THIS.RedesenharPaginaAtual()

                    THIS.this_nNumPag = THIS.this_nTotReg / 15
                    THIS.FinalizarPaginacao()
                ENDIF
            ELSE
                SELECT Tmp_Imagens
                GO TOP
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao voltar de p" + CHR(225) + "gina")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BotoesConsultaSairClick - transcricao de BOTOES_CONSULTA.sair.Click
    * (Buttons(3), "[ESC] Encerrar", Cancel = .T.): restaura a ordem de
    * CrProdutos e encerra a tela. THIS.Release() eh o metodo nativo de Form
    * (herdado via FormBase) - equivalente exato de "ThisForm.Release" no
    * legado; FormBase.Destroy() (ja implementado nesta classe, chama
    * DODEFAULT()) roda na sequencia normal de destruicao.
    *==========================================================================
    PROCEDURE BotoesConsultaSairClick()
        IF USED("CrProdutos")
            SELECT CrProdutos
            SET ORDER TO Cpros
        ENDIF

        THIS.Release()
    ENDPROC

    *==========================================================================
    * BotoesConsultaSelPaginaClick - transcricao de BOTOES_CONSULTA.
    * Command1.Click (Buttons(4), "Selecionar Pagina" - nome do botao no
    * dump eh "Command1", colidido com o cmd_4c_Command1 standalone, mas sao
    * objetos DIFERENTES - um eh Buttons(4) do grupo, outro filho direto do
    * form): abre o painel "Selecione a Pagina :" (cnt_4c__Pag), esconde a
    * barra de navegacao e poe o foco no campo. SetFocus em TRY proprio
    * (mesma razao do FecharPainelPaginacao - o controle acabou de virar
    * visivel e o foco pode ser recusado em casos de borda).
    *==========================================================================
    PROCEDURE BotoesConsultaSelPaginaClick()
        LOCAL loc_oErro

        THIS.obj_4c_BOTOES_CONSULTA.Visible  = .F.
        THIS.cnt_4c__Pag.Visible             = .T.
        THIS.cnt_4c__Pag.txt_4c_Text1.Value   = 0

        TRY
            THIS.cnt_4c__Pag.txt_4c_Text1.SetFocus()
        CATCH TO loc_oErro
            *-- Foco recusado - o painel ja esta correto (visivel, barra de
            *-- navegacao oculta); sem MsgErro de proposito, mesmo criterio
            *-- do FecharPainelPaginacao.
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Click de SIGOPPEC.Cnt_Pag.Command4, o botao do
    * painel "Selecione a Pagina :" que o dump declara com Cancel = .T.
    * (ESC do painel) e ToolTipText "Encerrar":
    *   ThisForm.Cnt_Pag.Visible = .F.
    *   ThisForm.BOTOES_CONSULTA.Visible = .T.
    *   ThisForm.BOTOES_CONSULTA.Command1.SetFocus
    *   Return
    * Abandona a selecao de pagina SEM navegar - nenhuma das tres linhas
    * mexe em CrProdutos/Tmp_Imagens. O corpo mora em FecharPainelPaginacao
    * porque ValidarPaginaSelecionada chama o MESMO bloco nas suas duas
    * recusas (pagina menor ou igual a 0 e pagina acima da ultima), do mesmo
    * jeito que o legado repete as 3 linhas nos tres lugares.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.FecharPainelPaginacao()
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorAcesso - transcricao do bloco de permissoes do Init
    * legado:
    *   If fChecaAcesso('SigOpPec','EXPORTA')  -> Exporta.Visible    = .T./.F.
    *   If fChecaAcesso('SigOpPec','GERACAO')  -> GeraArquivo.Visible= .T./.F.
    *   If fChecaAcesso('SigOpPec','IMPRIMIR') -> RelPecas.Visible   = .T./.F.
    * Os tres If/Else do legado atribuem exatamente o resultado da funcao,
    * entao a atribuicao direta eh a mesma coisa escrita uma vez.
    *
    * fChecaAcesso eh chamada com DOIS argumentos, como o legado - os tres
    * parametros restantes da funcao de Framework\sigacess.PRG tem fallback
    * proprio (o usuario cai em Usuar). NUNCA chamada em modo validacao de
    * UI / teste: ela consulta SigCdAcu no SQL Server (ver o guard em
    * InicializarForm).
    *
    * Este form NAO tem cascata de Left dependendo de quem ficou visivel (ao
    * contrario de outros forms OPERACIONAIS): no dump os sete botoes do topo
    * tem Left fixo e o legado nao reposiciona nenhum deles.
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorAcesso()
        THIS.cmd_4c_Exporta.Visible     = fChecaAcesso("SigOpPec", "EXPORTA")
        THIS.cmd_4c_GeraArquivo.Visible = fChecaAcesso("SigOpPec", "GERACAO")
        THIS.cmd_4c_Relpecas.Visible    = fChecaAcesso("SigOpPec", "IMPRIMIR")
    ENDPROC

    *==========================================================================
    * PrepararProdutosModoAutomatico - transcricao do ramo plAuto do Init
    * legado:
    *   If plAuto
    *       Select * From crCatalogo Into Cursor crProdutos ReadWrite
    *       Index On Cpros Tag Cpros
    *   Endif
    * Em modo automatico (rotina em lote) nao existe form pai com a consulta
    * de produtos montada: a lista vem do cursor crCatalogo deixado pelo
    * processo que chamou esta tela, e eh copiada para CrProdutos - o cursor
    * por onde TODA a paginacao desta tela navega.
    *
    * Duas guardas que o legado nao tinha: crCatalogo fechado (o legado
    * estouraria "Alias CRCATALOGO is not found") e CrProdutos ja aberto
    * (SELECT ... INTO CURSOR sobre alias em uso eh recusado pelo VFP). Nos
    * dois casos a tela segue para a carga, que trata CrProdutos ausente.
    *==========================================================================
    PROTECTED PROCEDURE PrepararProdutosModoAutomatico()
        LOCAL loc_oErro

        IF !THIS.this_lAuto
            RETURN
        ENDIF

        IF !USED("crCatalogo")
            RETURN
        ENDIF

        TRY
            IF USED("CrProdutos")
                USE IN CrProdutos
            ENDIF

            SELECT * FROM crCatalogo INTO CURSOR CrProdutos READWRITE
            INDEX ON Cpros TAG Cpros
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao preparar a lista de produtos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - funil UNICO de carga da "lista" desta tela: os ATE 15
    * produtos da pagina corrente (cursor Tmp_Imagens) e a repintura dos 15
    * slots de imagem. Transcricao do bloco de carga do Init legado:
    *
    *   lcWhereImg = '('
    *   Select CrProdutos
    *   Go Top
    *   If !Eof()
    *       ThisForm.PagInicial()
    *   EndIf
    *   ...
    *   If !ThisForm.TelaInic
    *       If !Used('Tmp_Imagens')  -> Wait Window / Return 0
    *       Select CrProdutos / lTotReg = RecCount() / TotPro = lTotReg /
    *       TotReg = 15 / <redesenha os 15 slots> / Primeira = Recno() /
    *       Pag1 = (Item=15 And !Eof()) / TotPag = Ceiling(lTotReg/15) /
    *       NumPag = 1 / Pagina.Caption = ... / TelaInic = .T.
    *   EndIf
    *
    * A segunda metade eh exatamente ReiniciarPaginacao (Fase 7), que ja
    * fatorou esse bloco porque CmdDesmarcarTodosClick e
    * CmdSelecionarTodosClick o repetem. "lcWhereImg = '('" nao eh
    * transcrito: PagInicial monta o proprio WHERE em variavel local.
    *
    * DIFERENCA de proposito em relacao ao legado: aqui a repintura NAO fica
    * sob "If !TelaInic". Como funil, CarregarLista precisa SEMPRE terminar
    * repintando (regra #21 - popular cursor nao repinta a grade; o legado
    * sempre fecha com Go Top + redesenho). Na ABERTURA o comportamento eh
    * identico, porque TelaInic ainda esta .F. na primeira passada - o guard
    * do legado existe para o caso de a tela ja ter sido montada antes, que
    * eh justamente quando repintar eh o certo.
    *
    * Devolve .F. quando nao houve o que exibir (CrProdutos ausente/vazio,
    * ou a consulta nao trouxe produto nenhum - Tmp_Imagens inexistente):
    * eh o caminho do "Wait Window 'Produtos Nao Encontrados!!!' / Return 0"
    * do legado, tratado por quem chama (InicializarForm aborta a abertura).
    *
    * PUBLIC (sem PROTECTED): o harness de teste automatizado chama
    * THIS.oForm.CarregarLista() de FORA da classe (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF !USED("CrProdutos")
            RETURN loc_lSucesso
        ENDIF

        TRY
            *-- Estado da tela (modo automatico + filtro de promocao do form
            *-- pai) para o BO ANTES da consulta - PagInicial le o mesmo
            *-- filtro por ObterFiltroPromocao.
            THIS.FormParaBO()

            SELECT CrProdutos
            GO TOP
            IF !EOF()
                THIS.PagInicial()
            ENDIF

            IF USED("Tmp_Imagens")
                THIS.ReiniciarPaginacao()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao carregar a p" + CHR(225) + "gina de produtos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * FormParaBO - leva o estado da TELA para SigOpPecBO, que eh quem guarda
    * o estado de paginacao e o filtro desta migracao (properties declaradas
    * nas Fases 1/2 para este proposito):
    *
    *   this_lAuto    -> this_lModoAutomatico   (plauto do legado)
    *   <filtro pai>  -> this_cPromocao / this_lFiltroPromocao
    *                    (lcPromo/llPromo, recalculados por
    *                    ObterFiltroPromocao - o form pai pode ter mudado o
    *                    Get_Promo entre duas paginas)
    *   this_nOrdena  -> this_nOrdena           (Ordena do legado)
    *   this_nTotPro  -> this_nTotalProdutos    (TotPro)
    *   this_nTotPag  -> this_nTotalPaginas     (TotPag)
    *   this_nNumPag  -> this_nPaginaAtual      (NumPag)
    *
    * Chamado em tres pontos: no fim da montagem (InicializarForm), antes de
    * cada consulta de pagina (CarregarLista) e no fecho de CADA paginacao
    * (FinalizarPaginacao, que atende Init/PROXPAG/ANTPAG/Desmarcar Todos/
    * Selecionar Todos) - o funil, nunca o botao (regra #40).
    *
    * PROTECTED EXPLICITO: FormBase declara "PROTECTED PROCEDURE FormParaBO"
    * e o VFP9 nao deixa a subclasse ALARGAR o escopo - omitir o modificador
    * nao torna o metodo publico, so esconde que ele continua protegido.
    * Por isso toda chamada eh por THIS. de dentro da classe.
    *
    * NAO escreve nada na tela: a volta eh BOParaForm.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lSucesso, loc_cPromo
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cPromo = THIS.ObterFiltroPromocao()

            THIS.this_oBusinessObject.this_lModoAutomatico = THIS.this_lAuto
            THIS.this_oBusinessObject.this_cPromocao       = loc_cPromo
            THIS.this_oBusinessObject.this_lFiltroPromocao = !EMPTY(loc_cPromo)
            THIS.this_oBusinessObject.this_nOrdena         = THIS.this_nOrdena
            THIS.this_oBusinessObject.this_nTotalProdutos  = THIS.this_nTotPro
            THIS.this_oBusinessObject.this_nTotalPaginas   = THIS.this_nTotPag
            THIS.this_oBusinessObject.this_nPaginaAtual    = THIS.this_nNumPag

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BOParaForm - traz de volta do BO o estado que FormParaBO empurrou e
    * repinta o unico lugar em que ele aparece para o usuario: o label
    * "Pagina : NNN/NNN" (AtualizarCaptionPagina, transcricao literal do
    * formato do legado). Com isso o numero exibido tem FONTE UNICA - sai
    * sempre do BO, nunca de uma segunda contagem feita na tela.
    *
    * Nao mexe em Primeira/Item/Pag1/Pag2/TelaInic: esses sao estado de
    * NAVEGACAO do cursor (posicao do ponteiro e quantos slots a pagina
    * preencheu), vivem na tela e nao tem par no BO.
    *
    * O caption so eh escrito se o label ja existir: BOParaForm roda a cada
    * paginacao, mas quem o chama primeiro (FinalizarPaginacao) pode ser
    * alcancado por um caminho em que a montagem visual ainda nao terminou.
    *
    * PROTECTED EXPLICITO pela mesma razao de FormParaBO (FormBase declara
    * "PROTECTED PROCEDURE BOParaForm" e o escopo vem da heranca).
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_lAuto   = THIS.this_oBusinessObject.this_lModoAutomatico
            THIS.this_nOrdena = THIS.this_oBusinessObject.this_nOrdena
            THIS.this_nTotPro = THIS.this_oBusinessObject.this_nTotalProdutos
            THIS.this_nTotPag = THIS.this_oBusinessObject.this_nTotalPaginas
            THIS.this_nNumPag = THIS.this_oBusinessObject.this_nPaginaAtual

            IF TYPE("THIS.lbl_4c_Pagina") = "O"
                THIS.AtualizarCaptionPagina()
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - torna visiveis, recursivamente, os controles
    * criados por AddObject (que nascem com Visible = .F.). FILTRO de
    * container flutuante: cnt_4c__Pag (Cnt_Pag do legado) NAO recebe
    * Visible = .T. aqui - permanece oculto ate o usuario clicar "Selecionar
    * Pagina" (BOTOES_CONSULTA.Buttons(4), fase seguinte). A recursao para
    * dentro dele AINDA ocorre (regra CLAUDE.md sobre LOOP ter de recursar
    * em containers flutuantes) para que Label1/Text1/Command4 fiquem
    * visiveis assim que o container for exibido.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl, loc_lFlutuante

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControl) = "O"
                loc_lFlutuante = (UPPER(loc_oControl.Name) == "CNT_4C__PAG")

                IF !loc_lFlutuante
                    IF PEMSTATUS(loc_oControl, "Visible", 5)
                        loc_oControl.Visible = .T.
                    ENDIF
                ENDIF

                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - delega ao FormBase (regra CLAUDE.md: Destroy SEMPRE termina
    * com DODEFAULT(), senao o menu do sistema fica com os popups em cache
    * visual stale). Fecha os cursores locais proprios desta tela -
    * CrImagens (CriarCursorImagens, DataSession = 1/CORRENTE/compartilhada,
    * entao sobrevive ao Form se nao for fechado aqui) e os temporarios que
    * os eventos desta fase podem deixar abertos se o form fechar no meio de
    * um Click. Tmp_Imagens e' do form PAI (CrProdutos/Tmp_Imagens vem dele,
    * ver cabecalho do arquivo) - nao fechado aqui, do mesmo jeito que o
    * legado tambem nao fecha no Release.
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("CrImagens")
            USE IN CrImagens
        ENDIF
        IF USED("cursor_4c_LocalImg")
            USE IN cursor_4c_LocalImg
        ENDIF
        IF USED("cursor_4c_Fornecedor")
            USE IN cursor_4c_Fornecedor
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
