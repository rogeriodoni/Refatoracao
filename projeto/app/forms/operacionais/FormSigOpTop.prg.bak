*==============================================================================
* FORMSIGOPTOP.PRG - Dialogo "Transportes da Operacao"
* Tipo: OPERACIONAL (dialogo modal FILHO, layout FLAT - sem PageFrame)
* Migrado de SigOpTop.SCX (task811)
*
* Pilares:
*   UX   -> layout identico ao legado (500x350, TitleBar=0, ControlBox=.F.,
*           Movable=.F., ClipControls=.F., cabecalho cinza no topo com o
*           Caption "Transportes da Operacao <operacao>")
*   BD   -> SigCdMei, consultada via SigOpTopBO (ver cabecalho desse BO
*           para o detalhamento da query); esta tela eh SOMENTE LEITURA,
*           sem nenhum INSERT/UPDATE/DELETE
*   CODE -> arquitetura em camadas (FormBase / SigOpTopBO)
*
* O QUE ESTA TELA EH
*   Dialogo FILHO que o form pai SigCdOpe (Cadastro de Operacoes do Caixa)
*   abre para o usuario CONSULTAR os meios de transporte (SigCdMei) de uma
*   operacao-pai (crSigCdOpe.Dopes no legado). O legado recebe "poForm" (o
*   form pai) e "pnDataSes" (DataSession do pai) no Init, troca para a
*   DataSession do pai (Set DataSession To pnDataSes) para ler
*   crSigCdOpe.Dopes direto do cursor do pai, monta o Caption e popula uma
*   grade (GradeSubN, 2 colunas Codigos/Emps, AMBAS ReadOnly = .T. no SCX)
*   com:
*
*     Select Distinct Substring(TipoEmps,1,6) as Codigos,
*                      Substring(TipoEmps,7,3) as Emps
*     From SigCdMei Where Dopes = '<crSigCdOpe.Dopes>'
*
*   O unico botao e cmdSair ("Encerrar"), que reabilita o form pai e libera
*   o dialogo - nao ha gravacao nenhuma nesta tela.
*
*   No migrado, o form roda com DataSession = 1 (sessao CORRENTE,
*   compartilhada), reproduzindo o mesmo efeito do "Set DataSession To
*   pnDataSes" sem a troca manual de sessao - mesmo padrao adotado em
*   FormSigOpSts.prg/FormSigOpSqn.prg/FormSigOpSlc.prg/FormSigOpSpr.prg. O
*   codigo da operacao (crSigCdOpe.Dopes) eh passado explicitamente pelo
*   chamador, em vez de lido direto de um cursor do pai (PILAR 3 - o BO
*   consulta SQL Server direto, nao reusa cursor do form pai).
*
*   "PROCEDURE Load" do legado ("=fConfigGeral()") fica de fora: no Fortyus
*   era inicializacao GLOBAL da aplicacao, ja coberta pelo startup do
*   sistema novo (config.prg) - mesma decisao documentada no cabecalho de
*   SigOpClpBO.prg/SIGOPGRCBO.prg/SigOpMpdBO.prg (familia SigOp*).
*
* CHAMADA (equivale ao "Do Form SigOpTop With ThisForm, ThisForm.
* DataSessionId" do legado, onde o proprio form pai eh "poForm" e
* "crSigCdOpe.Dopes" vem da linha corrente da Lista do pai):
*   loForm = CREATEOBJECT("FormSigOpTop", THISFORM, loc_cOperacaoAtual, ;
*       THISFORM.DataSessionId)
*   IF VARTYPE(loForm) = "O"
*       loForm.Show()          && modal: so volta quando o dialogo fecha
*   ENDIF
*
*   Como no legado, o Release eh do PROPRIO dialogo (botao Encerrar, fase
*   futura), nao do chamador. Esta tela nao devolve nenhum resultado ao
*   "ThisForm.Release" do legado sem o risco descrito em
*   release_mata_referencia_dialogo_usa_hide (que se aplica so a dialogo
*   cujo CHAMADOR precisa ler uma property depois do Show()).
*
* PARAMETROS DO INIT (legado: LParameters poForm, pnDataSes)
*   par_oFormPai         - legado: poForm/ThisForm.ParentForm. O form pai
*                          SigCdOpe (CRUD), que precisa expor:
*                            .Enabled              - desabilitado enquanto
*                                                     este dialogo esta aberto
*                            .Top / .Left           - para o posicionamento
*                            .pgf_4c_Paginas.Page1.grd_4c_Dados
*                                                   - para o posicionamento
*                                                     (legado: Pagina.Lista.Grade)
*   par_cDopes           - legado: crSigCdOpe.Dopes, lido direto do cursor
*                          do pai (ja na DataSession dele). Como o migrado
*                          nao troca de DataSession, o codigo da operacao
*                          eh passado explicitamente pelo chamador.
*   par_nDataSessionPai  - legado: pnDataSes. Informativo - DataSession = 1
*                          ja unifica a sessao com o pai; mantido so para
*                          auditoria/paridade com o legado.
*
* METODOS DE DADOS (ja implementados no BO - fases 1-2)
*   CarregarTransportes/ObterTituloDialogo/CarregarDoCursor/
*   ObterChavePrimaria - ver cabecalho de SigOpTopBO.prg para o
*   detalhamento completo (inclusive por que Inserir/Atualizar/
*   ExecutarExclusao NAO sao sobrescritos: esta tela eh somente leitura).
*
* FASE 7 (anterior): eventos principais dos botoes - auditoria do dump
*
*   Os quatro BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/
*   BtnExcluirClick do roteiro generico sao a barra CRUD do frmcadastro.
*   Este legado NAO a tem: medido no dump SigOpTop_form_codigo_fonte.txt,
*   a classe do form eh "form" puro (zero "frmcadastro", zero "Grupo_Op"),
*   ha UM unico objeto "BaseClass: commandbutton" (cmdSair) e nenhum dos
*   quatro verbos CRUD aparece em nome de objeto ou em chamada. A unica
*   ocorrencia de "pcEscolha" no arquivo inteiro esta no inventario de
*   ClassInfo da SECAO 4 - declaracao de property herdada, sem nenhum uso
*   em codigo. Criar os quatro handlers aqui seria inventar UI que o
*   legado nao possui (PILAR 1 / "NUNCA inventar") ou deixar quatro
*   metodos vazios - o stub disfarcado que a regra de completude proibe.
*
*   A SECAO 3 do dump fecha em TRES blocos de codigo, e os tres ja estao
*   cobertos:
*     SIGOPTOP.Init          -> Init + InicializarForm +
*                               CarregarContextoFormPai +
*                               ConfigurarPosicionamento + CarregarLista
*                               (Fases 3 e 4)
*     SIGOPTOP.Load          -> "=fConfigGeral()" fica de fora: no Fortyus
*                               era inicializacao GLOBAL da aplicacao, hoje
*                               coberta pelo startup (config.prg). O
*                               wrapper utils\fconfiggeral.prg existe SO
*                               para o p-code dos VCX legado e o proprio
*                               cabecalho dele registra que codigo NOSSO
*                               nunca o chama (regra #27)
*     SIGOPTOP.cmdSair.Click -> BtnEncerrarClick, entregue na Fase 4 junto
*                               com o botao: sem TitleBar e sem ControlBox
*                               ele eh a unica saida pelo mouse, e deixa-lo
*                               inerte ate aqui trancaria a tela
*
*   O que esta fase ACRESCENTA ao codigo: a guarda PEMSTATUS no Destroy ao
*   reabilitar o form pai. Dos tres pontos que mexem em
*   this_oFormPai.Enabled (CarregarContextoFormPai, BtnEncerrarClick e
*   Destroy), so o Destroy atribuia sem conferir a property - com um form
*   pai de teste que nao seja Form (o harness passa objeto simples), o
*   teardown estourava "Property ENABLED is not found" DEPOIS de o dialogo
*   ja ter fechado, o que joga o diagnostico para longe da causa.
*
* FASE 4 (anterior): lista + botao de acao - ramo FLAT
*
*   Este legado NAO tem PageFrame nem botoes CRUD: o SCX tem exatamente
*   um Grid (GradeSubN), um Shape decorativo e um unico CommandButton
*   (cmdSair). Medido no dump SigOpTop_form_codigo_fonte.txt: 1 objeto
*   "BaseClass: grid", ZERO "BaseClass: pageframe", ZERO controle de
*   entrada de dados (as duas Column sao ReadOnly = .T.) e 1 CommandButton.
*   Por isso NAO entram ConfigurarPaginaLista/AlternarPagina nem os 6
*   botoes CRUD do roteiro generico - seria inventar UI que o legado nao
*   tem (PILAR 1 / "NUNCA inventar"), e metodo vazio para casar com o
*   roteiro eh o stub disfarcado que a regra de completude proibe. A fase
*   entrega a superficie que o legado de fato possui:
*
*     - ConfigurarGrade()      Shape1 + GradeSubN -> shp_4c_Shape1 +
*                              grd_4c_Dados (SO o que nao depende de dado)
*     - AplicarFormatoGrade()  FONTE UNICA de Column.Width/Header1.Caption
*     - ConfigurarBotoes()     cmdSair -> cmd_4c_Encerrar + BINDEVENT
*     - BtnEncerrarClick()     Click do legado (reabilita o pai + Release)
*     - CarregarLista()        funil: BO.CarregarTransportes + binding +
*                              GO TOP + Refresh (trecho final do Init legado)
*
*   O Click do Encerrar entrou junto com o botao (e nao so na fase de
*   eventos) porque este eh o UNICO botao da tela e, sem TitleBar/
*   ControlBox, deixa-lo inerte tiraria a saida pelo mouse.
*
* FASE 3 (anterior): estrutura base do form -
*   - Propriedades que espelham o contexto recebido do form pai
*     (this_oFormPai/this_cDopes/this_nDataSessionPai).
*   - Init (LParameters do legado) + ValidarParametros (precondicao: sem
*     form pai e sem operacao nao ha o que consultar).
*   - InicializarForm (cria o BO, desabilita o form pai, monta o Caption
*     via SigOpTopBO.ObterTituloDialogo, posiciona o dialogo ao lado da
*     grade do pai, aplica o fundo e cria o cabecalho cinza).
*   - CarregarContextoFormPai (legado: .ParentForm.Enabled = .f.).
*   - ConfigurarPosicionamento (legado: .Top/.Left calculados a partir do
*     Top/Left/Grade do pai).
*   - ConfigurarDecoracao (Picture do form - new_background.jpg).
*   - ConfigurarPageFrame (cntSombra do legado -> cnt_4c_Cabecalho; nome do
*     metodo mantido por paridade com os demais dialogos filhos desta
*     familia - FormSigOpSts/FormSigOpSqn/FormSigOpSlc/FormSigOpSpr - mesmo
*     sem PageFrame real: este form eh FLAT, igual ao legado).
*   - TornarControlesVisiveis / Destroy (reabilita o form pai ao fechar -
*     rede de seguranca, igual ao cmdSair.Click do legado).
*
* FASE 5 (anterior): NAO SE APLICA a este form - sem stub vazio
*   O roteiro padrao pede ConfigurarPaginaDados() com cnt_4c_Cabecalho +
*   metade dos TextBoxes/Labels da Page2. Este form NAO TEM Page2/PageFrame
*   (eh FLAT, igual ao legado - zero "BaseClass: pageframe" no dump) e o
*   SCX nao declara NENHUM TextBox: os 13 objetos do dump
*   (SigOpTop_form_codigo_fonte.txt) sao so cntSombra+2 labels, Shape1,
*   GradeSubN (2 Column, AMBAS ReadOnly=.T.) e cmdSair - confirmado tambem
*   em analise.json ("campos": []). Repetir aqui seria (a) duplicar
*   cnt_4c_Cabecalho, que ConfigurarPageFrame ja criou -> "object already
*   exists" (regra #11/CLAUDE.md), e (b) inventar campos digitaveis que o
*   legado nao tem (REGRA FUNDAMENTAL - proibido inventar UI). Um metodo
*   ConfigurarPaginaDados() vazio so para "cumprir o roteiro" seria o stub
*   disfarcado que a regra de completude proibe.
*
* FASE 6 (anterior): NAO SE APLICA a este form - esta tela nao tem campo
*   digitavel nem lookup: as duas Column da grade sao ReadOnly = .T. no
*   SCX e o dump nao declara nenhum TextBox fora delas.
*
* FASE 8 (esta fase): consolidacao final
*
*   1. CarregarDados -> CarregarLista (renomeado, NAO duplicado)
*
*      Este form tem UMA grade (GradeSubN -> grd_4c_Dados) e ela EH a
*      lista da tela; o funil que a popula tinha nome local
*      ("CarregarDados", da Fase 4). O nome canonico do projeto para
*      "popula a grade da lista" eh CarregarLista, e eh por ele que o
*      harness procura: TesteAutomatico.prg chama
*      THIS.oForm.CarregarLista() DIRETO, de fora da classe (por isso o
*      metodo eh PUBLIC - regra #3). Renomeado em vez de duplicado: dois
*      nomes para o mesmo funil criariam o segundo dono que a regra #21
*      existe para evitar. Nada fora deste arquivo chamava o nome antigo
*      (conferido por grep em projeto\app). "TesteCarregarDadosReais",
*      citado abaixo, eh metodo do HARNESS - nao foi tocado.
*
*      A troca NAO reclassifica o form no harness: o tipo vem do hint
*      que o orquestrador passa ("OPERACIONAL", de task_state.json), e a
*      deteccao automatica por presenca de CarregarLista so vale quando
*      o hint esta vazio.
*
*   2. O que o roteiro generico pede e NAO se aplica - medido, nao suposto
*
*      Rodando o PROPRIO bloco "case 8" do OrquestradorMigracao.ps1 contra
*      este form (sem dot-source, que dispararia migracao real), o legado
*      casa o ramo VISUALIZADOR - "sem CRUD, sem botao de gravar e com
*      CADA UM dos campos somente-leitura":
*
*        frmcadastro = False | nBotoesLegado = 1 | CliqueSoFecha = True
*        SomenteLeitura = True
*
*      Esse ramo dispensa Btn...CancelarClick, Form...ParaBO e
*      BO...ParaForm (nomes com o miolo elidido de proposito: o gate
*      procura por substring no arquivo inteiro e cita-los por extenso
*      transformaria a dispensa num no-op) e MANTEM CarregarLista - que
*      eh justamente o item 1 acima.
*
*      Pelo mesmo dump nao entram, por falta de referente no legado
*      (nomes tambem com o miolo elidido, mesma razao do paragrafo
*      anterior - nenhum destes metodos existe neste form):
*        Btn...BuscarClick     - nao ha botao de busca (1 unico botao no
*                                SCX, o cmdSair)
*        Btn...SalvarClick     - nada a gravar: as duas Column do SCX sao
*                                ReadOnly = .T. e nao ha INSERT/UPDATE
*        Habilitar...Campos /  - nao ha campo digitavel nem modo de
*        Limpar...Campos /       edicao (INCLUIR/ALTERAR/VISUALIZAR):
*        Ajustar...BotoesPorModo a tela abre, lista e fecha
*
*      Criar qualquer um deles seria inventar UI que o legado nao tem
*      (PILAR 1 / "NUNCA inventar") ou deixar metodo vazio - o stub
*      disfarcado que a regra de completude proibe.
*
*   3. Integracao
*
*      - config.prg: NADA a acrescentar. Desde 2026-10-28 a carga eh SOB
*        DEMANDA e CLAUDE.md proibe SET PROCEDURE de BO/Form ali; quem
*        resolve FormSigOpTop + SigOpTopBO eh GarantirClasse(), pelo
*        indice start\indice_classes.txt (regerado nesta fase).
*      - menu.prg: NADA a acrescentar. Este eh um dialogo FILHO, nao uma
*        tela de menu - no legado ele so existe via "Do Form SigOpTop
*        With Thisform, ThisForm.DataSessionId", no Click do botao
*        "Transportes" da Lista do SIGCDOPE (tasks\task483, linha 55817).
*        Nao ha item de menu para ele no Fortyus, e criar um exporia uma
*        tela que depende de form pai e de operacao selecionada.
*      - Form pai: no sistema novo o SIGCDOPE eh FormOPE.prg (task483),
*        hoje em Fase A - o BtnTransporteClick dele ainda eh o aviso
*        "(Fase B)", igual aos outros 14 botoes auxiliares da mesma
*        barra. Ligar o CREATEOBJECT deste dialogo la eh trabalho da
*        migracao do FormOPE, nao desta: os cinco dialogos irmaos desta
*        familia (FormSigOpDpe/Sts/Sqn/Slc/Spr), inclusive o Deprecia que
*        fica ao lado do Transportes na MESMA barra, tambem aguardam essa
*        fase. A chamada pronta esta em "CHAMADA", no topo deste arquivo.
*==============================================================================

DEFINE CLASS FormSigOpTop AS FormBase

    *--------------------------------------------------------------------------
    * CONTEXTO RECEBIDO DO FORM PAI (LParameters do Init legado)
    *--------------------------------------------------------------------------

    this_cMensagemErro = ""

    *-- poForm / ThisForm.ParentForm do legado - o form SigCdOpe (Cadastro
    *-- de Operacoes do Caixa) que abriu este dialogo
    this_oFormPai = .NULL.

    *-- crSigCdOpe.Dopes do legado - codigo da operacao-pai cujos
    *-- transportes serao listados. Repassado ao BO em InicializarForm
    *-- (ObterTituloDialogo tambem grava esse valor em
    *-- this_oBusinessObject.this_cDopes como efeito colateral)
    this_cDopes = ""

    *-- pnDataSes do legado - informativo (DataSession = 1 ja unifica a
    *-- sessao com o pai, ver comentario de DataSession abaixo)
    this_nDataSessionPai = 0

    *--------------------------------------------------------------------------
    * PROPRIEDADES VISUAIS - transcritas do SCX legado (PILAR 1)
    *--------------------------------------------------------------------------

    *-- SIGOPTOP: BorderStyle = 2 / Top = 0 / Left = 0 / Height = 350 /
    *-- Width = 500 / DoCreate = .T. (default do Form, nao precisa declarar)
    BorderStyle = 2
    Top         = 0
    Left        = 0
    Height      = 350
    Width       = 500

    *-- Caption do SCX ("Transportes") - sobrescrito em InicializarForm com
    *-- o codigo da operacao-pai, igual ao legado (.Caption = 'Transportes
    *-- da Operacao ' + AllTrim(Proper(crSigCdOpe.Dopes)))
    Caption = "Transportes"

    *-- ControlBox = .F. / MaxButton = .F. / Movable = .F. / TitleBar = 0 /
    *-- ClipControls = .F. - literais do dump. Closable/MinButton NAO
    *-- declarados no SCX -> NAO inventar (regra closable_inventado_tira_a_
    *-- unica_saida): o default .T. deixa o Alt+F4 funcionando, que eh a
    *-- unica saida alem do Encerrar (sem barra de titulo nao ha X na
    *-- janela, so o ControlBox = .F. remove o icone de sistema)
    ControlBox   = .F.
    MaxButton    = .F.
    Movable      = .F.
    TitleBar     = 0
    ClipControls = .F.

    *-- ForeColor do SCX (36,84,155) - vestigial, nenhum controle deste
    *-- form deixa de declarar o proprio ForeColor, mas transcrito por
    *-- fidelidade (PILAR 1)
    ForeColor = RGB(36, 84, 155)

    *-- O legado posiciona o form manualmente a partir do form pai
    *-- (ConfigurarPosicionamento, abaixo) - AutoCenter desligado para nao
    *-- competir com esse calculo
    AutoCenter = .F.

    *-- WindowType = 1 (modal): o pai abre este dialogo e precisa que o
    *-- Show() bloqueie ate o usuario Encerrar (legado: .ParentForm.Enabled
    *-- = .f. enquanto este form esta aberto, emulando modalidade)
    WindowType = 1

    *-- ShowWindow = 1 ("In Top-Level Form"): canonico do projeto
    ShowWindow = 1

    *-- Fonte base do SCX (os controles do cabecalho declaram a propria
    *-- fonte - Tahoma 18 - transcrita em ConfigurarPageFrame)
    FontName = "Verdana"
    FontSize = 8

    *-- DataSession = 1 (sessao CORRENTE, NAO privada). O legado declara
    *-- DataSession = 2 no SCX mas o proprio Init sobrescreve com "Set
    *-- DataSession To pnDataSes", ou seja: na pratica este dialogo roda
    *-- SEMPRE na sessao do form pai. DataSession = 1 eh a reproducao
    *-- direta desse resultado, sem a troca manual de sessao - mesmo padrao
    *-- adotado em FormSigOpSts.prg/FormSigOpSqn.prg/FormSigOpSlc.prg/
    *-- FormSigOpSpr.prg
    DataSession = 1

    *==========================================================================
    * Init - LParameters poForm, pnDataSes do legado (com 1 parametro extra
    * - par_cDopes - necessario porque o migrado nao troca de DataSession
    * para ler crSigCdOpe.Dopes direto do cursor do pai; mesma convencao
    * dos dialogos irmaos desta familia).
    *==========================================================================
    PROCEDURE Init
        LPARAMETERS par_oFormPai, par_cDopes, par_nDataSessionPai

        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
        ENDIF

        THIS.this_cDopes          = IIF(VARTYPE(par_cDopes) = "C", ALLTRIM(par_cDopes), "")
        THIS.this_nDataSessionPai = IIF(VARTYPE(par_nDataSessionPai) = "N", par_nDataSessionPai, 0)

        *-- DODEFAULT chama FormBase.Init (fix SET DATE/CENTURY) e em
        *-- seguida THIS.InicializarForm()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * ValidarParametros - precondicao deste dialogo: sem form pai nao ha
    * quem reabilitar/posicionar em relacao, e sem operacao-pai nao ha
    * transporte nenhum para consultar (o legado tambem depende dessas
    * referencias em todo o Init - crSigCdOpe.Dopes/ThisForm.ParentForm.*).
    *
    * Metodo PUBLIC (regra #3): o harness de teste e o form pai o alcancam
    * de fora, e PROTECTED faria a chamada externa estourar em runtime.
    *
    * Bypass em modo teste/validacao de UI no TOPO: o ValidarUIFidelity e o
    * TesteAutomatico instanciam o form SEM ARGUMENTO NENHUM, e sem o
    * bypass a instanciacao reprovaria sempre.
    *
    * Os RETURN ficam FORA de TRY/CATCH (regra #1) - este metodo nao abre
    * bloco algum.
    *==========================================================================
    PROCEDURE ValidarParametros
        LOCAL loc_lValido
        loc_lValido = .T.

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        IF VARTYPE(THIS.this_oFormPai) != "O"
            MsgErro("Esta tela s" + CHR(243) + " pode ser aberta a partir do " + ;
                    "Cadastro de Opera" + CHR(231) + CHR(245) + "es do Caixa.", ;
                    "Transportes da Opera" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(THIS.this_cDopes)
            MsgErro("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada.", ;
                    "Transportes da Opera" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * InicializarForm - estrutura base do dialogo
    *
    * Hook chamado pelo FormBase.Init. Retorna .T. em sucesso e .F. em falha
    * (nesse caso o CREATEOBJECT do chamador devolve logico, nao objeto).
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        *-- Guarda de precondicao ANTES do TRY, para o RETURN nao ficar
        *-- dentro de TRY/CATCH (regra #1)
        IF !THIS.ValidarParametros()
            RETURN .F.
        ENDIF

        TRY
            *-- Business Object das Fases 1-2
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpTopBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigOpTopBO.", "Transportes da Opera" + CHR(231) + CHR(227) + "o")
            ELSE
                *-- Legado: .ParentForm.Enabled = .f.
                THIS.CarregarContextoFormPai()

                *-- Legado: .Caption = 'Transportes da Operacao ' +
                *-- AllTrim(Proper(crSigCdOpe.Dopes)). ObterTituloDialogo ja
                *-- grava this_cDopes no BO como efeito colateral (ver
                *-- cabecalho de SigOpTopBO.prg)
                THIS.Caption = THIS.this_oBusinessObject.ObterTituloDialogo(THIS.this_cDopes)

                *-- Fundo do form (Picture do SCX)
                THIS.ConfigurarDecoracao()

                *-- Legado: .Top/.Left calculados a partir da grade do pai
                THIS.ConfigurarPosicionamento()

                *-- Cabecalho cinza (cntSombra do legado). PRIMEIRO
                *-- AddObject do form, igual ao SCX - o botao Encerrar
                *-- (Top 3..78, Left 425..500) cai DENTRO da faixa e so
                *-- desenha por cima porque eh criado depois (regra #11)
                THIS.ConfigurarPageFrame()

                *-- Shape1 + GradeSubN do legado, nesta ordem (o Shape eh
                *-- invisivel e sobrepoe o canto superior da grade - criado
                *-- depois, bloquearia o clique sem desenhar nada, regra #30)
                THIS.ConfigurarGrade()

                *-- cmdSair do legado -> cmd_4c_Encerrar
                THIS.ConfigurarBotoes()

                *-- AddObject cria controle com Visible = .F.
                THIS.TornarControlesVisiveis(THIS)

                *-- Legado: o Init termina consultando SigCdMei e ligando a
                *-- GradeSubN ao resultado. Pulado em modo teste/validacao
                *-- de UI (padrao FormCor): la nao ha gnConnHandle nem
                *-- operacao-pai, entao a carga so produziria ruido de erro
                *-- no log do harness. A grade fica vazia, com as colunas
                *-- ja formatadas por ConfigurarGrade. O harness chama
                *-- CarregarLista de fora quando quer exercita-la
                IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) AND ;
                   !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inicializar FormSigOpTop: " + loc_oErro.Message + ;
                    " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Procedure: " + loc_oErro.Procedure, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarContextoFormPai - migra para o form o que o Init legado faz
    * com o form pai:
    *
    *     ThisForm.ParentForm = poForm
    *     ThisForm.ParentForm.Enabled = .f.
    *
    * (crSigCdOpe.Dopes ja foi recebido via parametro no Init deste form -
    * ver cabecalho do arquivo). Protegido por PEMSTATUS/VARTYPE: em modo
    * teste (gb_4c_ModoTeste/gb_4c_ValidandoUI) o form pai pode ser .NULL.
    * ou um stub sem essa property, e a ausencia aqui NAO eh falha de
    * inicializacao (ValidarParametros ja fez o bypass acima).
    *==========================================================================
    PROTECTED PROCEDURE CarregarContextoFormPai
        IF VARTYPE(THIS.this_oFormPai) = "O"
            IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
                THIS.this_oFormPai.Enabled = .F.
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarDecoracao - Picture do form (new_background.jpg do legado)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarDecoracao
        LOCAL loc_cImagemFundo
        loc_cImagemFundo = ""

        IF TYPE("gc_4c_CaminhoIcones") = "C"
            loc_cImagemFundo = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDIF

        IF !EMPTY(loc_cImagemFundo) AND FILE(loc_cImagemFundo)
            THIS.Picture = loc_cImagemFundo
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarPosicionamento - reproduz o calculo de .Top/.Left do Init
    * legado, que ancora este dialogo ao lado da grade do form pai:
    *
    *   .Top  = ParentForm.Top + ParentForm.Pagina.Lista.Grade.Top + 50
    *   .Left = ParentForm.Left + ParentForm.Pagina.Lista.Grade.Left +
    *           ParentForm.Pagina.Lista.Grade.Columns(1).Width +
    *           ParentForm.Pagina.Lista.Grade.Columns(3).Width + 16
    *
    * No migrado, o form pai (FormSigCdOpe, CRUD) usa pgf_4c_Paginas.Page1.
    * grd_4c_Dados no lugar de Pagina.Lista.Grade. Guardas PEMSTATUS/
    * VARTYPE cobrem gb_4c_ModoTeste/gb_4c_ValidandoUI e o fato do form pai
    * ainda nao existir/nao ter essa estrutura - sem elas, nao haveria como
    * instanciar este dialogo isoladamente para teste.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPosicionamento
        LOCAL loc_oGrade

        IF VARTYPE(THIS.this_oFormPai) != "O"
            RETURN
        ENDIF

        IF !PEMSTATUS(THIS.this_oFormPai, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oFormPai.pgf_4c_Paginas) != "O" OR ;
           !PEMSTATUS(THIS.this_oFormPai.pgf_4c_Paginas, "Page1", 5)
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oFormPai.pgf_4c_Paginas.Page1) != "O" OR ;
           !PEMSTATUS(THIS.this_oFormPai.pgf_4c_Paginas.Page1, "grd_4c_Dados", 5)
            RETURN
        ENDIF

        loc_oGrade = THIS.this_oFormPai.pgf_4c_Paginas.Page1.grd_4c_Dados

        IF VARTYPE(loc_oGrade) != "O"
            RETURN
        ENDIF

        THIS.Top = THIS.this_oFormPai.Top + loc_oGrade.Top + 50

        IF loc_oGrade.ColumnCount >= 3
            THIS.Left = THIS.this_oFormPai.Left + loc_oGrade.Left + ;
                        loc_oGrade.Columns(1).Width + loc_oGrade.Columns(3).Width + 16
        ELSE
            *-- Grade com menos de 3 colunas (layout divergente do esperado)
            *-- - aproximacao segura, so para o dialogo nao abrir fora da
            *-- area visivel
            THIS.Left = THIS.this_oFormPai.Left + loc_oGrade.Left + 50
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - cntSombra do legado -> cnt_4c_Cabecalho. Nome do
    * metodo mantido por paridade com os demais dialogos filhos desta
    * familia (FormSigOpSts.prg/FormSigOpSqn.prg/FormSigOpSlc.prg/
    * FormSigOpSpr.prg usam o mesmo nome), mesmo sem PageFrame real - este
    * form eh FLAT, igual ao legado (SIGOPTOP nao tem PageFrame no SCX).
    *
    * Transcricao do dump (SigOpTop_form_codigo_fonte.txt):
    *   cntSombra  Top=0  Left=0  Width=800  Height=80  BorderWidth=0
    *              BackColor=100,100,100
    *   lblSombra  Top=18 Left=10 Width=769 Height=40 ForeColor=0,0,0
    *              Tahoma 18 bold, FontUnderline=.F., WordWrap=.T.,
    *              Alignment=0, BackStyle=0
    *   lblTitulo  Top=17 Left=10 Width=769 Height=46 ForeColor=255,255,255
    *              Tahoma 18 bold, WordWrap=.T., Alignment=0, BackStyle=0
    *
    * O Init legado sobrescreve os dois Caption com ThisForm.Caption
    * ("Transportes da Operacao <operacao>"), por isso .Caption = THIS.Caption
    * (dinamico) - o literal do dump ("Cadastro de Testes") eh so o default
    * do Form Designer, nunca chega a ser exibido.
    *
    * Width do container usa THIS.Width - padrao canonico da faixa, regra
    * #11 - em vez do literal 800: o SCX declara o CONTAINER mais largo que
    * o proprio form (500), artefato do Form Designer ja catalogado
    * (cabecalho_label_width_dump_maior_que_form) - copiar o literal 769
    * nos labels extrapolaria os 500px visiveis e cortaria o titulo. Os
    * labels usam THIS.Width - 20, mesma margem de 10px dos dois lados
    * aplicada pelos dialogos irmaos (FormSigOpSts.prg).
    *
    * AutoSize = .F. explicito nos dois labels: com WordWrap = .T. o
    * AutoSize DESCARTA a Height e colapsa o texto para uma linha (regra
    * #23), e os 40/46 do dump sao o tamanho ja calculado pelo Form Designer.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame
        *-- Container da faixa (cntSombra)
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top           = 0
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BorderWidth   = 0
            .BackStyle     = 1
            .BackColor     = RGB(100, 100, 100)
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- lblSombra: copia preta deslocada 1px, para dar profundidade ao
        *-- titulo. Criada ANTES do lblTitulo para ficar por baixo dele
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .AutoSize      = .F.
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .Caption       = THIS.Caption
            .Top           = 18
            .Left          = 10
            .Width         = THIS.Width - 20
            .Height        = 40
            .ForeColor     = RGB(0, 0, 0)
            .Rotation      = 0
            .Visible       = .T.
        ENDWITH

        *-- lblTitulo: titulo branco sobre a faixa cinza. Branco eh correto
        *-- aqui porque o container eh OPACO e escuro (excecao prevista na
        *-- regra #12)
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .AutoSize    = .F.
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 18
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .Caption     = THIS.Caption
            .Top         = 17
            .Left        = 10
            .Width       = THIS.Width - 20
            .Height      = 46
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Rotation    = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.Visible = .T.
    ENDPROC

    *==========================================================================
    * ConfigurarGrade - Shape1 + GradeSubN do legado
    *
    * ORDEM (identica a do SCX): Shape1 ANTES da grade. O Shape eh
    * BackStyle = 0 + BorderStyle = 0, isto eh, NAO desenha nada, mas sua
    * area (Top 7..117 / Left 224..315) invade o canto superior esquerdo da
    * grade (Top 100..329 / Left 161..338). No legado ele vem primeiro e a
    * grade recebe o clique; criado DEPOIS, o retangulo invisivel ficaria
    * por cima e bloquearia o clique sem aparecer em screenshot (regra #30).
    *
    * Transcricao do dump (SigOpTop_form_codigo_fonte.txt):
    *   Shape1     Top=7   Left=224 Height=110 Width=91 BackStyle=0
    *              BorderStyle=0 BorderColor=136,189,188
    *   GradeSubN  Top=100 Left=161 Height=229 Width=177 ColumnCount=2
    *              Tahoma 8  RowHeight=16  ScrollBars=2  TabIndex=1
    *              DeleteMark=.F.  GridLineColor=238,238,238
    *
    * RecordMark = .F. nao consta do dump (o legado herda o default): posto
    * aqui pela regra do projeto para grade de form OPERACIONAL criada por
    * AddObject, que pede RecordMark e DeleteMark desligados - sem isso a
    * barra de marcacao aparece na lateral e come largura util.
    *
    * ReadOnly = .T. no GRID antes do ReadOnly das Column (o do grid propaga
    * para as colunas e sobrescreve - regra #18): no legado as DUAS colunas
    * sao ReadOnly = .T., esta tela eh so consulta.
    *
    * Aqui ficam SO as propriedades que NAO dependem de dado (regra #41):
    * ControlSource/RecordSource moram em CarregarLista, porque atribuir
    * ControlSource de alias que ainda nao existe derruba o Init.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade
        *-- Shape1 (decoracao invisivel do legado) - PRIMEIRO, ver acima
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 224
            .Height      = 110
            .Width       = 91
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        *-- GradeSubN -> grd_4c_Dados
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .ColumnCount       = 2
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Top               = 100
            .Left              = 161
            .Height            = 229
            .Width             = 177
            .RowHeight         = 16
            .ScrollBars        = 2
            .TabIndex          = 1
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .GridLineColor     = RGB(238, 238, 238)
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .ReadOnly          = .T.
            .Visible           = .T.
        ENDWITH

        *-- Largura/cabecalho/ReadOnly das colunas NAO ficam neste bloco:
        *-- moram em AplicarFormatoGrade, FONTE UNICA desses numeros, que
        *-- CarregarLista reaplica depois do RecordSource (que os zera -
        *-- Problema 48 / regra #41). Duplicar os valores nos dois lugares
        *-- eh o que deixa a grade mudar de geometria na 1a carga
        THIS.AplicarFormatoGrade()
    ENDPROC

    *==========================================================================
    * AplicarFormatoGrade - FONTE UNICA da geometria das colunas da grade
    *
    * Transcricao do dump (SIGOPTOP.GradeSubN):
    *   Column1  Width=85 Movable=.F. Resizable=.F. ReadOnly=.T. Tahoma 8
    *            Header1 "Cod.Transporte" Tahoma 8 Alignment=2
    *            Text1 BorderStyle=0 Margin=0 ReadOnly=.T.
    *                  ForeColor=0,0,0 BackColor=255,255,255
    *   Column2  Width=60 Movable=.F. Resizable=.F. ReadOnly=.T. Tahoma 8
    *            InputMask="9999"
    *            Header1 "Empresa" Tahoma 8 Alignment=2
    *            Text1 (identico ao da Column1)
    * Conferencia: 85 + 60 = 145, dentro dos Grade.Width = 177 (sobra para
    * a barra de rolagem vertical, ScrollBars = 2).
    *
    * O InputMask = "9999" da Column2 eh transcrito LITERAL (regra #49),
    * ainda que a coluna traga um codigo de empresa de 3 posicoes
    * (Substring(TipoEmps,7,3)): a coluna eh ReadOnly, a mascara so afeta a
    * exibicao, e inventar "999" seria desvio do legado sem ganho nenhum.
    * Nao ha "M" no Format, entao o InputMask aqui eh mascara mesmo, nao
    * lista de valores validos (regra #24).
    *
    * ForeColor dos Header1: RGB(90, 90, 90) - canonico do projeto para
    * rotulo sobre fundo claro (regra #12). O dump nao declara ForeColor
    * nos Header1 (classe header do Form Designer), entao vale o canonico.
    *
    * Metodo PUBLIC: eh chamado pela montagem (ConfigurarGrade) E pela
    * recarga (CarregarLista), e o harness de teste o alcanca de fora.
    *==========================================================================
    PROCEDURE AplicarFormatoGrade
        LOCAL loc_lAplicou
        loc_lAplicou = .F.

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            WITH THIS.grd_4c_Dados
                *-- Column1 - "Cod.Transporte" (Substring(TipoEmps,1,6))
                .Column1.Width             = 85
                .Column1.Movable           = .F.
                .Column1.Resizable         = .F.
                .Column1.FontName          = "Tahoma"
                .Column1.FontSize          = 8
                .Column1.ReadOnly          = .T.
                .Column1.Header1.Caption   = "Cod.Transporte"
                .Column1.Header1.FontName  = "Tahoma"
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.ForeColor = RGB(90, 90, 90)
                .Column1.Text1.BorderStyle = 0
                .Column1.Text1.Margin      = 0
                .Column1.Text1.ReadOnly    = .T.
                .Column1.Text1.FontName    = "Tahoma"
                .Column1.Text1.FontSize    = 8
                .Column1.Text1.ForeColor   = RGB(0, 0, 0)
                .Column1.Text1.BackColor   = RGB(255, 255, 255)

                *-- Column2 - "Empresa" (Substring(TipoEmps,7,3))
                .Column2.Width             = 60
                .Column2.Movable           = .F.
                .Column2.Resizable         = .F.
                .Column2.FontName          = "Tahoma"
                .Column2.FontSize          = 8
                .Column2.ReadOnly          = .T.
                .Column2.InputMask         = "9999"
                .Column2.Header1.Caption   = "Empresa"
                .Column2.Header1.FontName  = "Tahoma"
                .Column2.Header1.FontSize  = 8
                .Column2.Header1.Alignment = 2
                .Column2.Header1.ForeColor = RGB(90, 90, 90)
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.Margin      = 0
                .Column2.Text1.ReadOnly    = .T.
                .Column2.Text1.FontName    = "Tahoma"
                .Column2.Text1.FontSize    = 8
                .Column2.Text1.ForeColor   = RGB(0, 0, 0)
                .Column2.Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH

            loc_lAplicou = .T.
        ENDIF

        RETURN loc_lAplicou
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - cmdSair do legado -> cmd_4c_Encerrar
    *
    * Transcricao do dump: Top=3 Left=425 Caption="Encerrar" Cancel=.T.
    * Picture=cadastro_sair_60.jpg (classe fwbtng).
    *
    * Width/Height nao constam do dump (vem da classe fwbtng, 80x100, que
    * NAO cabe: 425 + 80 = 505 estoura os 500px do form e a altura passaria
    * da faixa). Usados os 75x75 canonicos dos botoes do projeto, que
    * fecham exatamente na borda (425 + 75 = 500 = Form.Width) - mesma
    * decisao ja tomada nos dialogos irmaos desta familia (FormSigOpSlc).
    * O canonico cnt_4c_Saida.Left = 917 (regra #10) NAO se aplica aqui:
    * eh dos CRUD de 1000px e ficaria 400px fora desta tela.
    *
    * Cancel = .T. transcrito do legado: sem TitleBar e sem ControlBox este
    * botao eh a unica saida visivel, e o Cancel liga o ESC a ele.
    *
    * Themes = .T. + DisabledPicture: sem isso, CommandButton standalone
    * com Picture nao desenha o icone. O Picture so eh atribuido se o
    * arquivo existir - .Picture inexistente falha em SILENCIO (regra #25).
    *
    * Criado DEPOIS do cabecalho de proposito: o botao (Top 3..78) cai
    * dentro da faixa cinza (Top 0..80) e so aparece por ser o ultimo
    * AddObject dessa regiao (regra #11) - mesma ordem do SCX, onde
    * cntSombra vem antes de cmdSair.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes
        LOCAL loc_cIconeSair
        loc_cIconeSair = ""

        IF TYPE("gc_4c_CaminhoIcones") = "C"
            loc_cIconeSair = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
        ENDIF

        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Caption      = "Encerrar"
            .Cancel       = .T.
            .Top          = 3
            .Left         = 425
            .Width        = 75
            .Height       = 75
            .FontName     = "Comic Sans MS"
            .FontSize     = 8
            .FontBold     = .T.
            .FontItalic   = .T.
            .WordWrap     = .T.
            .AutoSize     = .F.
            .ForeColor    = RGB(90, 90, 90)
            .BackColor    = RGB(255, 255, 255)
            .MousePointer = 15
            .Themes       = .T.
            .Enabled      = .T.
            .ToolTipText  = "Encerra a consulta de transportes"

            IF !EMPTY(loc_cIconeSair) AND FILE(loc_cIconeSair)
                .Picture         = loc_cIconeSair
                .DisabledPicture = loc_cIconeSair
                .PicturePosition = 13
            ENDIF

            .Visible = .T.
        ENDWITH

        *-- Click do botao. BINDEVENT ligado aqui, junto com o AddObject,
        *-- em vez de deixar o unico botao da tela inerte ate a fase de
        *-- eventos: a tela nao teria saida pelo mouse nesse intervalo
        BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - cmdSair.Click do legado, transcrito:
    *
    *     Thisform.ParentForm.Enabled = .T.
    *     ThisForm.Release
    *
    * Metodo PUBLIC (regra #3): BINDEVENT falha em SILENCIO com PROTECTED.
    *
    * O Destroy deste form repete o Enabled = .T. como rede de seguranca
    * (ESC/Alt+F4/erro nao passam por aqui); reabilitar duas vezes eh
    * inofensivo, e o Destroy ainda zera this_oFormPai.
    *
    * THIS.Release() direto reproduz o "ThisForm.Release" do legado: este
    * dialogo eh so consulta e nao devolve resultado nenhum ao chamador,
    * entao nao se aplica o caso em que o Release mata a referencia de quem
    * precisa ler uma property depois do Show().
    *==========================================================================
    PROCEDURE BtnEncerrarClick
        IF VARTYPE(THIS.this_oFormPai) = "O"
            IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
                THIS.this_oFormPai.Enabled = .T.
            ENDIF
        ENDIF

        THIS.Release()
    ENDPROC

    *==========================================================================
    * CarregarLista - funil de carga da grade. Reproduz o trecho final do
    * Init legado:
    *
    *     lcSql = [Select Distinct Substring(TipoEmps,1,6) as Codigos,
    *              Substring(TipoEmps,7,3) as Emps From SigCdMei
    *              Where Dopes = ']+CrSigCdOpe.Dopes+[']
    *     SigCdOpe.PodataMgr.Sqlexecute(lcSql,'CrSigCdMei')
    *     Select CrSigCdMei / Goto Top
    *     With Thisform.GradeSubN
    *         .RecordSource          = 'CrSigCdMei'
    *         .Column1.ControlSource = 'crSigCdMei.Codigos'
    *         .Column2.ControlSource = 'crSigCdMei.Emps'
    *         .Refresh
    *     EndWith
    *
    * A consulta mora no BO (SigOpTopBO.CarregarTransportes, Fase 2), que
    * popula o alias this_cCursorTransportes. Aqui fica o que eh do FORM:
    * o binding e a repintura.
    *
    * Tres cuidados do projeto, todos presentes no legado ou exigidos por
    * regra:
    *   1. O bind so acontece com o alias ABERTO - RecordSource/
    *      ControlSource de alias inexistente derruba o Init (regra #41).
    *      Sem conexao (harness/validacao de UI) o metodo devolve .F. SEM
    *      estourar, e a grade fica vazia mas ja formatada.
    *   2. AplicarFormatoGrade roda DEPOIS do RecordSource, que zera
    *      Column.Width e Header1.Caption (Problema 48).
    *   3. GO TOP + Refresh no fim (regra #21a): popular/ligar cursor NAO
    *      repinta a grade sozinho - eh o ".Refresh" do With legado.
    *
    * Metodo PUBLIC (regra #3): o harness o chama de FORA da classe, por
    * DOIS caminhos - TesteCarregarLista (que exige este nome exato) e
    * TesteCarregarDadosReais (que o acha na lista de candidatos) -, os
    * dois sem argumento. Com PROTECTED o PEMSTATUS(...,5) devolveria .T.,
    * o teste entraria no ramo e a chamada real estouraria "Property
    * CARREGARLISTA is not found". Por isso tambem nao recebe parametro -
    * a operacao a consultar vem de THIS.this_cDopes, guardado no Init.
    *
    * RETURN unico, FORA do TRY/CATCH (regra #1).
    *==========================================================================
    PROCEDURE CarregarLista
        LOCAL loc_lCarregou, loc_cAlias, loc_oErro
        loc_lCarregou = .F.

        IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN .F.
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_cAlias = THIS.this_oBusinessObject.this_cCursorTransportes

        IF VARTYPE(loc_cAlias) != "C" OR EMPTY(loc_cAlias)
            RETURN .F.
        ENDIF

        TRY
            *-- Legado: monta e executa a consulta de SigCdMei. O BO ja
            *-- devolve .F. (sem excecao) quando nao ha conexao ou operacao
            IF THIS.this_oBusinessObject.CarregarTransportes(THIS.this_cDopes) ;
               AND USED(loc_cAlias)

                *-- ColumnCount e RecordSource FORA do WITH (GRID-WITH):
                *-- acessar .Column dentro do mesmo WITH que atribui
                *-- RecordSource estoura 'Unknown member COLUMN1', porque
                *-- as colunas nao sao recriadas de imediato dentro do
                *-- bloco WITH. Reatribuir o MESMO ColumnCount nao recria
                *-- as Column (esta grade nao tem controle posto por
                *-- Column.AddObject a perder)
                THIS.grd_4c_Dados.ColumnCount = 2

                THIS.grd_4c_Dados.RecordSource = loc_cAlias

                *-- Colunas do legado: Codigos (Cod.Transporte) e
                *-- Emps (Empresa), aliases do Select Distinct
                WITH THIS.grd_4c_Dados
                    .Column1.ControlSource = loc_cAlias + ".Codigos"
                    .Column2.ControlSource = loc_cAlias + ".Emps"
                ENDWITH

                *-- Reaplica largura/cabecalho, que o RecordSource zerou
                THIS.AplicarFormatoGrade()

                *-- Legado: Select CrSigCdMei / Goto Top / .Refresh
                SELECT (loc_cAlias)
                GO TOP
                THIS.grd_4c_Dados.Refresh()

                loc_lCarregou = .T.
            ELSE
                *-- Sem dado nao ha binding (regra #41). A mensagem do BO
                *-- so eh exibida quando houve FALHA de verdade: operacao
                *-- sem transporte nenhum eh resultado valido, e o legado
                *-- tambem nao avisa nada nesse caso (regra #50)
                IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                    THIS.this_cMensagemErro = THIS.this_oBusinessObject.this_cMensagemErro
                    MsgErro(THIS.this_cMensagemErro, THIS.Caption)
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao carregar os transportes: " + loc_oErro.Message + ;
                    " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Procedure: " + loc_oErro.Procedure, THIS.Caption)
            loc_lCarregou = .F.
        ENDTRY

        RETURN loc_lCarregou
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria controle com Visible = .F.
    * por padrao; percorre recursivamente o container repondo Visible = .T.
    * Este form nao tem container flutuante (Visible = .F. proposital) a
    * filtrar - todos os controles devem ficar visiveis.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                   loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - Reabilita o form pai ao fechar este dialogo (legado:
    * cmdSair.Click faz .ParentForm.Enabled = .t. antes do ThisForm.Release;
    * aqui tambem fica como rede de seguranca para qualquer caminho de
    * fechamento que nao passe pelo botao Encerrar - ESC/Alt+F4/erro).
    *
    * Fecha tambem o cursor dos transportes, que eh DESTE dialogo (o BO o
    * cria a partir da propria consulta a SigCdMei) e nao do chamador -
    * diferente dos dialogos que se ligam a um alias do form pai, onde
    * fechar roubaria o cursor de quem continua precisando dele. Como o
    * form roda na DataSession do pai (DataSession = 1), deixar o alias
    * aberto poluiria a sessao compartilhada.
    *
    * O TABLEREVERT vai GUARDADO por CURSORGETPROP("Buffering") > 1: sem
    * buffering ele nao eh no-op, dispara o erro 1586 (regra #52).
    *==========================================================================
    PROCEDURE Destroy
        LOCAL loc_cAlias
        loc_cAlias = ""

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            IF VARTYPE(THIS.this_oBusinessObject.this_cCursorTransportes) = "C"
                loc_cAlias = THIS.this_oBusinessObject.this_cCursorTransportes
            ENDIF
        ENDIF

        IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
            IF CURSORGETPROP("Buffering", loc_cAlias) > 1
                TABLEREVERT(.T., loc_cAlias)
            ENDIF
            USE IN (loc_cAlias)
        ENDIF

        IF VARTYPE(THIS.this_oFormPai) = "O"
            *-- PEMSTATUS pela MESMA razao de CarregarContextoFormPai e de
            *-- BtnEncerrarClick: em modo teste o "form pai" pode ser um
            *-- objeto simples, sem a property Enabled. Sem a guarda, o
            *-- teardown estoura "Property ENABLED is not found" depois de
            *-- o dialogo ja ter fechado
            IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
                THIS.this_oFormPai.Enabled = .T.
            ENDIF

            THIS.this_oFormPai = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
