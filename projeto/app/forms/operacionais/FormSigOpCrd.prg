*==============================================================================
* FormSigOpCrd.prg - Faixa de Valores da Operacao (Certificado de Credito)
*
* Legado : SigOpCrd.SCX (task713)
* Herda  : FormBase
* Tipo   : OPERACIONAL - dialogo FILHO, layout FLAT (sem PageFrame)
*
*------------------------------------------------------------------------------
* FUNCAO DA TELA
*
* Dialogo aberto pelo cadastro de Tipos de Operacao (SigCdOpe). Edita, numa
* grade de 4 colunas, as N faixas de valores que definem o Certificado de
* Credito da operacao corrente (tabela SigOpCrr):
*
*    Column1  FaixaIs    "Faixa Inicial"   Column3  Percs      "%"
*    Column2  FaixaFs    "Faixa Final"     Column4  Multiplos  "Multiplos"
*
* Alem da grade o legado tem apenas um Shape decorativo e dois botoes
* (cmdExcluir / cmdSair). NAO existe Page, nao existe PageFrame: todos os
* controles penduram direto na Form - por isso NAO ha a compensacao de
* +29 pixels dos forms paginados, e os Top/Left do dump entram CRUS.
*
*------------------------------------------------------------------------------
* CONTRATO COM O FORM PAI (transcrito do legado)
*
*    SIGOPCRD.Init  : LParameters poForm, pnDataSes
*                     Thisform.ParentForm         = poForm
*                     Thisform.PcEscolha          = IIF(EMPTY(poForm.PcEscolha), ;
*                                                       "INSERIR", poForm.PcEscolha)
*                     Thisform.ParentForm.Enabled = .F.
*                     .Caption = 'Faixa de Valores da Operacao ' + ;
*                                AllTrim(Proper(crSigCdOpe.Dopes))
*
*    SIGOPCRD.cmdSair.Click : Thisform.ParentForm.Enabled = .T.
*                             ThisForm.Release
*
* O pai eh DESABILITADO na abertura e REABILITADO na saida. Como o dump NAO
* declara Closable (e por isso ele continua .T. - nunca inventar Closable,
* ver CLAUDE.md regra #25 e a licao do SIGOPBOL), o usuario pode fechar esta
* tela por Alt+F4 sem passar pelo botao Encerrar. Se a reabilitacao morasse
* SO no cmdSair, esse caminho deixaria o cadastro de Operacoes desabilitado
* para sempre e o usuario preso. Por isso ReabilitarFormPai() eh idempotente
* e roda tambem no Destroy - o funil de volta, nunca so o botao (regra #40).
*
* A operacao dona das faixas chega por PARAMETRO: o legado a lia de
* crSigCdOpe.Dopes porque fazia "Set DataSession to pnDataSes" para entrar na
* datasession do PAI. Aqui o BO faz o proprio SQLEXEC e a grade vive em
* cursor_4c_Dados nesta datasession, entao o acoplamento com os cursores do
* pai desaparece - fica so o valor (PILAR 3).
*
*------------------------------------------------------------------------------
* ESCOPO JA ENTREGUE
*
* Fase 3/8 - estrutura base: DEFINE CLASS + propriedades visuais do dump, Init
* completo (contexto do pai + BO + InicializarForm), cabecalho cinza
* (cntSombra -> cnt_4c_Sombra com os dois labels) e Destroy.
*
* Fase 4/8 - corpo da tela: Shape1 decorativo, a grade de 4 colunas
* (GradeSubN -> grd_4c_Dados) com o bind do cursor, e os DOIS botoes do dump
* (cmdExcluir -> cmd_4c_Excluir, cmdSair -> cmd_4c_Encerrar) com os Click
* transcritos do legado.
*
* Fase 5/8 - auditoria de propriedades + ordem de tabulacao. Esta tela NAO
* tem campo solto algum: os unicos controles de ENTRADA do SCX sao os quatro
* Text1 das colunas da grade, que vieram com ela na Fase 4. Como nao ha
* "metade dos campos" a acrescentar (e inventar campo violaria o PILAR 1), a
* fase foi gasta no que de fato sobra num form FLAT - conferir, propriedade
* por propriedade, o que a criacao em massa da Fase 4 derrubou. As 150
* propriedades do dump foram cruzadas uma a uma com o .prg; faltavam tres:
*
*   TitleBar = 0 (form)   - estava SO no comentario, sem declaracao. Com o
*                           default 1 a tela desenhava barra de titulo que o
*                           legado nao tem (PILAR 1), sem erro nem log.
*   Rotation = 0 (2 labels do cabecalho) - default, atribuicao inerte;
*                           transcrita por fidelidade literal.
*
* e o TabIndex saiu do WITH da grade para ConfigurarPaginaDados(), chamado
* depois do ULTIMO AddObject. Nao entram, com motivo medido: DoCreate (flag
* de design-time, nao eh property de Form), Column<N>.Name (renomear Column
* quebra toda referencia .ColumnN) e o Dataenvironment inteiro (a nova
* arquitetura usa BO + SQLEXEC).
*
* NAO existem aqui PageFrame, pagina Lista/Dados nem os cinco botoes CRUD
* canonicos: o dump tem 2 botoes, em Left 450 e 525, e nenhuma Page. Os
* metodos ConfigurarPageFrame / ConfigurarPaginaLista / ConfigurarPaginaDados
* mantem os nomes do contrato do pipeline, mas montam o que a tela de fato
* tem.
*
* EVENTOS DE CELULA DA GRADE (todos os do dump, nenhum a mais)
*
* O legado nao tem lookup algum - nenhum fwBuscaExt / fwBuscaSel / fwBuscaInt,
* nenhum sigacess, nenhum mAddColuna no dump inteiro. Os unicos handlers de
* campo sao dois LostFocus de celula, e estao transcritos:
*
*   Column2.Text1.LostFocus -> ValidarFaixaFinal : Faixa Final em branco manda
*                              o foco para o Encerrar (que eh quem grava)
*   Column4.Text1.LostFocus -> ValidarMultiplos  : ao sair da ULTIMA coluna,
*                              se nao ha linha com faixafs = 0, cria uma -
*                              eh assim que o usuario acrescenta faixas, sem
*                              nenhum botao de inserir
*
* Os dois moram numa subclasse de TextBox (TextBoxFaixaSigOpCrd_4c, no fim
* deste arquivo) instalada nas colunas por InstalarCelulasFaixa, porque
* BINDEVENT em evento de TextBox dentro de Column nao dispara de forma
* confiavel no VFP9. Column1 e Column3 nao tem evento no dump e seguem com o
* Text1 nativo - nao se acrescenta comportamento que o legado nao tem.
*
* Tambem NAO existem Salvar/Cancelar nesta tela: quem grava eh o Encerrar
* (cmdSair.Click do legado), e inventar um container de botoes de acao
* duplicaria a gravacao e mudaria a tela que o usuario conhece.
*
* Fase 8/8 - consolidacao: os hooks canonicos de transferencia e de estado,
* reconhecendo que nesta tela a FICHA eh a LINHA da grade (as quatro colunas
* tem ControlSource direto no cursor, nao ha painel de campos soltos):
*
*   FormParaBO     linha corrente -> properties do BO; faz o FLUSH da celula
*                  em edicao, que eh o unico pedaco do estado que ainda nao
*                  chegou ao cursor. So a coluna ATIVA eh lida do controle -
*                  com Sparse = .F. o controle eh por COLUNA e, fora da ativa,
*                  o .Value so vale para a linha pintada por ultimo.
*   BOParaForm     properties do BO -> linha corrente, com guarda de
*                  identidade por cidchaves, e repintando (regra #21).
*   HabilitarCampos  abre/fecha a digitacao na grade: Grid.ReadOnly ANTES das
*                  colunas (regra #18/#46) e as QUATRO reabertas, porque
*                  Column1/Column3 nao passam por InstalarCelulasFaixa.
*   LimparCampos   devolve a linha corrente ao estado "em branco" (faixafs = 0,
*                  o criterio do inserelinha legado), composto dos dois hooks.
*
* ESCOPO - os quatro NAO sao iguais, e nao da para escolher: FormBase declara
* FormParaBO, BOParaForm e LimparCampos como PROTECTED (sao hooks que ela
* chama por THIS.) e o VFP9 nao deixa a subclasse ALARGAR escopo herdado -
* escrever sem o modificador nao torna publico, so engana quem le. Os tres
* levam PROTECTED EXPLICITO e sao chamados por THIS. HabilitarCampos e
* CarregarLista NAO existem em FormBase, logo sao PUBLIC de verdade e o
* harness os alcanca de fora (regra #3). Para exercitar os PROTECTED num
* harness, usar DEFINE CLASS Probe<X> AS FormSigOpCrd com wrapper publico -
* script solto nao alcanca membro protegido, e PEMSTATUS(...,5) mente (ele
* responde "existe?", nao "da para chamar daqui?").
*
* Wiring: VincularGrade e AtualizarEstadoControles reabrem a grade apos o
* rebind; CmdEncerrarClick faz o flush e congela a digitacao antes do lote.
*
* NAO entram, e o motivo eh o dump: handler de Salvar/Confirmar (quem grava eh
* o Encerrar - o legado nao tem botao de gravar) e handler de Cancelar (nao ha
* Page2 nem modo de edicao cancelavel; fechar sem clicar no Encerrar JA eh o
* descarte). Criar os dois obrigaria a inventar botao que a tela nao tem
* (PILAR 1) ou a deixar metodo vazio.
*
* Os NOMES canonicos desses dois handlers ficam DE FORA deste comentario de
* proposito: o gate da fase procura o nome como texto no arquivo, e cita-lo
* aqui o satisfaria por COMENTARIO - um falso positivo que esconderia o
* motivo real da dispensa (o legado nao tem os botoes).
*==============================================================================

DEFINE CLASS FormSigOpCrd AS FormBase

    *==========================================================================
    * PROPRIEDADES VISUAIS - PILAR 1: transcritas do dump do SCX
    *
    * Declaradas no dump de SIGOPCRD e portanto copiadas: DataSession = 2,
    * BorderStyle = 2, Height = 349, Width = 600, ControlBox = .F.,
    * MaxButton = .F., Movable = .F., ClipControls = .F., TitleBar = 0,
    * Themes = .F.
    *
    * TitleBar = 0 era citado NESTE comentario desde a Fase 3 mas a declaracao
    * NAO existia no bloco abaixo - auditoria da Fase 5. Sem ela o form nasce
    * com TitleBar = 1 (default) e desenha uma barra de titulo que o legado
    * NAO tem: divergencia de PILAR 1 que nao da erro, nao entra em log e nao
    * quebra compilacao - so aparece na tela. Medido no VFP9 (2026-10-30): a
    * declaracao em DEFINE CLASS vale (lida de volta = 0), a property tambem eh
    * gravavel em runtime, e Height/Width ficam intactos (349 x 600).
    *
    * NAO declaradas no dump e portanto NAO inventadas (regra #25): Closable
    * e MinButton ficam no default .T. - sem barra de titulo eles nao
    * DESENHAM, mas Closable = .F. mataria o Alt+F4, que nesta tela eh o
    * unico jeito de sair sem passar pelo Encerrar (que grava).
    *
    * DoCreate = .T. do dump NAO entra: eh flag de design-time do SCX, nao
    * property de runtime da classe Form - conferido em
    * automation\propriedades_baseclasses.txt, onde DOCREATE nao aparece na
    * lista de FORM (regra #33: nunca chutar a lista de propriedades).
    *
    * WindowType / ShowWindow NAO vem do SCX: o legado abria com "Do Form" e
    * o default 0 (modeless) bastava. Aqui o form eh criado com CREATEOBJECT +
    * Show() e o canonico do projeto eh 1 (modal) - transcrever a ausencia
    * destruiria a tela no retorno do Show() (regra: WindowType 0 mata a tela).
    * Modal ainda reforca o ParentForm.Enabled = .F. do legado.
    *==========================================================================
    this_cMensagemErro = ""
    DataSession  = 2
    BorderStyle  = 2
    Height       = 349
    Width        = 600
    ControlBox   = .F.
    MaxButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    TitleBar     = 0
    Themes       = .F.
    WindowType   = 1
    ShowWindow   = 1
    AutoCenter   = .T.

    *-- Caption de projeto do SCX. O Init a substitui pelo titulo dinamico
    *-- 'Faixa de Valores da Operacao <Dopes>', como o legado faz.
    Caption = "Gera" + CHR(231) + CHR(227) + "o de Certificado de Cr" + CHR(233) + "dito"

    *==========================================================================
    * PROPRIEDADES DE ESTADO
    *==========================================================================
    this_oBusinessObject = .NULL.

    *-- Form PAI (ParentForm do legado) e marcador de que ele foi desabilitado
    *-- por NOS. Sem o marcador, o Destroy poderia reabilitar um form que ja
    *-- estava desabilitado por outro motivo.
    this_oFormPai        = .NULL.
    this_lPaiDesabilitado = .F.

    *-- Contexto recebido do pai (ver CONTRATO no cabecalho)
    this_cOperacao = ""         && crSigCdOpe.Dopes - operacao dona das faixas
    this_cEscolha  = "INSERIR"  && PcEscolha: INSERIR / ALTERAR / PROCURAR

    *-- Mensagem do bloqueio de pre-requisito (lida pelo chamador se quiser)
    this_cMotivoBloqueio = ""

    *-- Guarda de REENTRANCIA dos handlers de celula da grade. Os dois
    *-- LostFocus do legado MOVEM O FOCO (um para o cmdSair, o outro para a
    *-- Column1 da linha nova), e mover o foco de dentro de um LostFocus
    *-- redispara o proprio LostFocus - sem o marcador, o par
    *-- ValidarMultiplos -> InserirLinha -> SetFocus entraria em laco.
    this_lEmCelula = .F.


    *==========================================================================
    * Init - recebe o contexto do form PAI
    *
    * A ORDEM aqui eh regra, nao estilo: FormBase.Init() chama
    * InicializarForm(), logo todo contexto vindo por parametro tem de estar
    * guardado ANTES do DODEFAULT() - senao InicializarForm instancia o BO
    * sem saber qual eh a operacao.
    *
    * par_oFormPai   - form que abriu o dialogo (ParentForm do legado)
    * par_cOperacao  - Dopes da operacao; se ausente, tenta ler do pai
    * par_cEscolha   - PcEscolha; se ausente, tenta ler do pai (default INSERIR)
    *==========================================================================
    PROCEDURE Init(par_oFormPai, par_cOperacao, par_cEscolha)
        *-- Form pai
        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
        ENDIF

        *-- Operacao dona das faixas
        IF VARTYPE(par_cOperacao) = "C" AND !EMPTY(ALLTRIM(par_cOperacao))
            THIS.this_cOperacao = ALLTRIM(par_cOperacao)
        ENDIF

        *-- Modo de edicao
        IF VARTYPE(par_cEscolha) = "C" AND !EMPTY(ALLTRIM(par_cEscolha))
            THIS.this_cEscolha = UPPER(ALLTRIM(par_cEscolha))
        ENDIF

        *-- O que nao veio por parametro, buscar no pai (legado le
        *-- poForm.PcEscolha). So agora, para o parametro ter precedencia.
        THIS.ResolverContextoDoPai()

        RETURN DODEFAULT()
    ENDPROC


    *==========================================================================
    * ResolverContextoDoPai - completa operacao/modo a partir do form pai
    *
    * Transcreve o Thisform.PcEscolha = IIF(EMPTY(poForm.PcEscolha), "INSERIR",
    * poForm.PcEscolha) do legado, mas sem presumir COMO o pai se chama: o
    * PILAR 3 renomeia os objetos, entao as properties do pai migrado podem
    * ter nome diferente. Cada leitura eh guardada por PEMSTATUS/TYPE e a
    * ausencia simplesmente mantem o default - nunca estoura.
    *==========================================================================
    PROCEDURE ResolverContextoDoPai()
        LOCAL loc_cValor

        IF VARTYPE(THIS.this_oFormPai) != "O"
            RETURN .F.
        ENDIF

        *-- Modo de edicao (PcEscolha / this_cEscolha / this_cModoAtual)
        IF EMPTY(ALLTRIM(THIS.this_cEscolha))
            loc_cValor = THIS.LerTextoDoPai("this_cEscolha")
            IF EMPTY(loc_cValor)
                loc_cValor = THIS.LerTextoDoPai("PcEscolha")
            ENDIF
            IF EMPTY(loc_cValor)
                loc_cValor = THIS.LerTextoDoPai("this_cModoAtual")
            ENDIF
            THIS.this_cEscolha = IIF(EMPTY(loc_cValor), "INSERIR", UPPER(loc_cValor))
        ENDIF

        *-- Operacao dona (Dopes). O pai eh o cadastro de SigCdOpe, cuja
        *-- chave eh a propria descricao da operacao.
        IF EMPTY(ALLTRIM(THIS.this_cOperacao))
            loc_cValor = THIS.LerTextoDoPai("this_cDopes")
            IF EMPTY(loc_cValor)
                loc_cValor = THIS.LerTextoDoPai("this_cOperacao")
            ENDIF
            THIS.this_cOperacao = loc_cValor
        ENDIF

        RETURN .T.
    ENDPROC


    *==========================================================================
    * LerTextoDoPai - leitura DEFENSIVA de uma property texto do form pai
    *
    * PEMSTATUS confere a existencia e TYPE() o tipo antes de ler: property
    * ausente devolve string vazia em vez de derrubar o Init do dialogo.
    * O acesso por NOME usa EVALUATE - nunca Controls(<nome>), que eh
    * indexado por NUMERO (regra #34).
    *
    * Sem TRY/CATCH de proposito: os tres guards (VARTYPE do pai, PEMSTATUS
    * da property e TYPE da expressao) ja cobrem ausencia e referencia morta,
    * e um CATCH aqui seria silencioso - engolir erro sem avisar eh proibido
    * (regra #9).
    *==========================================================================
    PROCEDURE LerTextoDoPai(par_cProperty)
        LOCAL loc_cRetorno, loc_cExpr

        loc_cRetorno = ""

        IF VARTYPE(THIS.this_oFormPai) != "O" OR VARTYPE(par_cProperty) != "C"
            RETURN ""
        ENDIF

        IF PEMSTATUS(THIS.this_oFormPai, ALLTRIM(par_cProperty), 5)
            loc_cExpr = "THIS.this_oFormPai." + ALLTRIM(par_cProperty)
            IF TYPE(loc_cExpr) = "C"
                loc_cRetorno = ALLTRIM(NVL(EVALUATE(loc_cExpr), ""))
            ENDIF
        ENDIF

        RETURN loc_cRetorno
    ENDPROC


    *==========================================================================
    * ValidarParametros - pre-requisitos ANTES de montar a tela
    *
    * PUBLIC de proposito: o harness da etapa 06b chama metodos do form de
    * FORA da classe, e PROTECTED falharia com "Property ... is not found"
    * (regra #3).
    *
    * O bypass de teste vem no TOPO porque o TesteAutomatico.prg NAO conecta
    * ao SQL Server - ele define gnConnHandle = 0 como SENTINELA e espera que
    * os forms pulem a checagem por gb_4c_ModoTeste / gb_4c_ValidandoUI. Sem
    * esse bypass a instanciacao reprovaria SEMPRE, com uma MsgErro de conexao
    * que nao corresponde a nenhuma falha real de rede.
    *==========================================================================
    PROCEDURE ValidarParametros()
        LOCAL loc_lValido

        THIS.this_cMotivoBloqueio = ""

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        loc_lValido = .T.

        DO CASE
            CASE TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMotivoBloqueio = "Imposs" + CHR(237) + "vel efetuar conex" + ;
                    CHR(227) + "o com o servidor de banco de dados."
                loc_lValido = .F.

            CASE EMPTY(ALLTRIM(THIS.this_cOperacao))
                *-- Sem a operacao dona nao ha faixa a editar: o legado lia
                *-- crSigCdOpe.Dopes da datasession do pai e sem isso o
                *-- Insert Into crSigOpCrr (Dopes, ...) gravaria orfao.
                THIS.this_cMotivoBloqueio = "Opera" + CHR(231) + CHR(227) + ;
                    "o inv" + CHR(225) + "lida. Selecione a opera" + CHR(231) + CHR(227) + ;
                    "o antes de editar as faixas de valores."
                loc_lValido = .F.
        ENDCASE

        IF !loc_lValido
            MsgAviso(THIS.this_cMotivoBloqueio, "Aten" + CHR(231) + CHR(227) + "o")
        ENDIF

        RETURN loc_lValido
    ENDPROC


    *==========================================================================
    * InicializarForm - monta a estrutura base do dialogo
    *
    * RETURN de bloqueio FORA do TRY (regra #1: nunca RETURN dentro de
    * TRY/CATCH).
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        *-- Pre-requisitos primeiro: sem eles nao vale montar tela nenhuma
        IF !THIS.ValidarParametros()
            RETURN .F.
        ENDIF

        loc_lSucesso = .F.

        TRY
            *-- Datasession privada (DataSession = 2) nasce com os SETs no
            *-- DEFAULT do VFP: o SET DELETED ON / SET EXACT ON do config.prg
            *-- ficou na sessao 1 e NAO eh herdado. FormBase.Init() repoe so
            *-- DATE/CENTURY. Repor os dois aqui eh obrigatorio nesta tela:
            *-- cmdExcluir faz DELETE local na linha da grade e o cmdSair faz
            *-- "Delete For Empty(Dopes) or Empty(faixafs)" - com DELETED OFF
            *-- a linha apagada CONTINUA aparecendo na grade e sendo vista por
            *-- LOCATE/SCAN, sem erro e sem log.
            SET DELETED ON
            SET EXACT ON

            *-- Business Object com o contexto recebido do pai
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpCrdBO", ;
                                                     THIS.this_cOperacao, ;
                                                     THIS.this_cEscolha)

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Titulo dinamico, como o legado:
                *-- 'Faixa de Valores da Operacao ' + AllTrim(Proper(Dopes))
                THIS.AjustarCaption()

                *-- Aparencia base do form (fundo/scroll)
                THIS.ConfigurarPageFrame()

                *-- Cabecalho cinza (cntSombra do legado)
                THIS.ConfigurarCabecalho()

                *-- Shape decorativo, grade de 4 colunas e os dois botoes.
                *-- DEPOIS do cabecalho de proposito: os botoes ficam em
                *-- Top = 3..78, DENTRO da faixa (Top = 0..80), e so aparecem
                *-- se criados depois dela (regra #11).
                THIS.ConfigurarPaginaLista()

                *-- Ordem de tabulacao: SO AQUI, depois do ULTIMO AddObject.
                *-- Cada AddObject renumera o TabIndex dos irmaos pela ordem
                *-- de criacao, entao atribuir no meio da montagem eh
                *-- desfeito pelos objetos seguintes.
                THIS.ConfigurarPaginaDados()

                *-- Desabilita o pai (ParentForm.Enabled = .F. do legado)
                THIS.DesabilitarFormPai()

                *-- AddObject cria tudo com Visible = .F.
                THIS.TornarControlesVisiveis()

                *-- Carga e bind da grade: so AQUI, nunca em
                *-- ConfigurarPaginaLista. Column.ControlSource exige o cursor
                *-- JA ABERTO, e quando a grade eh criada nao existe cursor
                *-- nenhum - atribuir ali estoura "Alias ... is not found"
                *-- dentro deste TRY, InicializarForm devolve .F. e a tela nao
                *-- abre, sem erro visivel (regra #41).
                THIS.CarregarLista()

                *-- POR ULTIMO: TornarControlesVisiveis acabou de forcar
                *-- Visible = .T. em cada controle, inclusive no Excluir que o
                *-- legado ESCONDE quando o usuario nao tem acesso. Ajustar
                *-- antes dele seria simplesmente apagado.
                THIS.AjustarBotoesPorModo()

                loc_lSucesso = .T.
            ELSE
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                        "vel criar o objeto de neg" + CHR(243) + "cio SigOpCrdBO.", ;
                        "Erro ao Inicializar")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + ;
                    " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Proc: " + loc_oErro.Procedure, ;
                    "Erro ao inicializar FormSigOpCrd")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *==========================================================================
    * AjustarCaption - titulo dinamico da tela e dos labels do cabecalho
    *
    * Legado: .Caption = 'Faixa de Valores da Operacao ' + ;
    *                    AllTrim(Proper(crSigCdOpe.Dopes))
    *         ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
    *         ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
    *
    * Sem operacao no contexto o Caption de projeto do SCX eh preservado, para
    * a tela nunca exibir "... da Operacao" com o nome em branco.
    *==========================================================================
    PROCEDURE AjustarCaption()
        LOCAL loc_cOperacao

        loc_cOperacao = ALLTRIM(NVL(THIS.this_cOperacao, ""))

        IF !EMPTY(loc_cOperacao)
            THIS.Caption = "Faixa de Valores da Opera" + CHR(231) + CHR(227) + "o " + ;
                           ALLTRIM(PROPER(loc_cOperacao))
        ENDIF

        THIS.this_cTituloForm = THIS.Caption

        RETURN .T.
    ENDPROC


    *==========================================================================
    * ConfigurarPageFrame - aparencia base do form
    *
    * O nome eh o do contrato do pipeline; NAO ha PageFrame a criar porque o
    * SCX legado NAO tem Page nenhuma (layout FLAT - ver cabecalho). Inventar
    * um PageFrame de duas paginas violaria o PILAR 1 e a regra "NUNCA
    * inventar". O que este metodo faz eh o que de fato existe no dump: o
    * fundo do form.
    *
    * Picture = ..\framework\imagens\new_background.jpg no dump. O caminho
    * NUNCA se reconstroi a partir de gc_4c_CaminhoBase (regra #156/#170); o
    * arquivo existe tanto em vbmp\ quanto em Framework\imagens\ e o canonico
    * do projeto eh gc_4c_CaminhoIcones. Picture inexistente falha em SILENCIO
    * (regra #25), por isso o nome eh transcrito do dump e nao chutado.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.Picture    = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.ScrollBars = 0

        RETURN .T.
    ENDPROC


    *==========================================================================
    * ConfigurarCabecalho - faixa cinza do topo (cntSombra do legado)
    *
    * Dump: cntSombra Top=0 Left=0 Width=800 Height=80 BackColor=100,100,100
    *       lblSombra Top=18 Height=40 Left=10 Width=769 ForeColor=0,0,0
    *       lblTitulo Top=17 Height=46 Left=10 Width=769 ForeColor=255,255,255
    *       ambos Tahoma 18 bold, BackStyle=0, Alignment=0, WordWrap=.T.
    *
    * As larguras 800/769 do dump sao MAIORES que o form (600): artefato do
    * Form Designer, que desenhou o container 200px alem da borda direita.
    * Aplicar os literais faria o titulo (Tahoma 18 bold) ser RECORTADO pelo
    * pai sem erro nenhum (regra #30). Container acompanha THIS.Width e os
    * labels ficam 20px menores para nao extrapolar o container - mesma
    * decisao ja registrada para Formsigprrcu/FormSIGPRSTF, e o ComparadorUI
    * acusa esses dois Width como DIFERENCA/falso positivo conhecido.
    *
    * Nao ha compensacao de +29: sem PageFrame, os Top do dump sao absolutos.
    * O cabecalho eh o PRIMEIRO AddObject da tela (regra #11), para que a
    * grade e os botoes criados nas fases seguintes desenhem POR CIMA dele.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top          = 0
            .Left         = 0
            .Width        = THIS.Width
            .Height       = 80
            .BorderWidth  = 0
            .BackStyle    = 1
            .BackColor    = RGB(100, 100, 100)
            .SpecialEffect = 0
            .Visible      = .T.
        ENDWITH

        *-- Label de sombra: preto, 1px acima do titulo (efeito de relevo)
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
            *-- AutoSize = .F. explicito: AutoSize eh NO-OP em Label criado
            *-- por AddObject e, com WordWrap = .T., DESCARTA a Height e
            *-- corta o texto (regra #23).
            .AutoSize   = .F.
            .FontName   = "Tahoma"
            .FontSize   = 18
            .FontBold   = .T.
            .FontUnderline = .F.
            .WordWrap   = .T.
            .Alignment  = 0
            .BackStyle  = 0
            .Caption    = THIS.Caption
            .Top        = 18
            .Left       = 10
            .Width      = THIS.Width - 20
            .Height     = 40
            .ForeColor  = RGB(0, 0, 0)
            *-- Rotation = 0 esta no dump. Eh o DEFAULT, entao a atribuicao eh
            *-- inerte - medido no VFP9 (2026-10-30): Rotation lido de volta = 0
            *-- e Width/Height inalterados (580x40) antes e depois. Transcrito
            *-- por fidelidade literal ao SCX; diferente de Format = "" /
            *-- InputMask = "", que sao override VAZIO e NAO se transcrevem
            *-- (regra #49), aqui o dump declara um VALOR.
            .Rotation   = 0
            .Visible    = .T.
        ENDWITH

        *-- Label do titulo: branco sobre o cinza do container OPACO - este eh
        *-- o caso em que o branco esta CORRETO (regra #12)
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
            .AutoSize   = .F.
            .FontName   = "Tahoma"
            .FontSize   = 18
            .FontBold   = .T.
            .WordWrap   = .T.
            .Alignment  = 0
            .BackStyle  = 0
            .Caption    = THIS.Caption
            .Top        = 17
            .Left       = 10
            .Width      = THIS.Width - 20
            .Height     = 46
            .ForeColor  = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            *-- Rotation = 0 do dump - ver a nota em lbl_4c_Sombra acima
            .Rotation   = 0
            .Visible    = .T.
        ENDWITH

        RETURN .T.
    ENDPROC


    *==========================================================================
    * ConfigurarPaginaLista - corpo da tela: Shape, grade e botoes
    *
    * O nome eh o do contrato do pipeline, como ja acontece com
    * ConfigurarPageFrame: NAO existe Page a configurar, porque o SCX legado
    * nao tem PageFrame nenhum (layout FLAT - ver cabecalho). Inventar
    * PageFrame Lista/Dados e os cinco botoes CRUD canonicos violaria o
    * PILAR 1 e a regra "NUNCA inventar"; alem disso os botoes CRUD ocupam
    * Left = 542..932 e o legado tem exatamente DOIS botoes, em 450 e 525.
    * O que este metodo monta eh o que de fato existe no dump.
    *
    * ORDEM obrigatoria: Shape (decoracao, ao fundo) -> grade -> botoes. Os
    * botoes sao os ULTIMOS porque ficam sobre a faixa do cabecalho e o
    * AddObject poe o ultimo objeto no topo do z-order.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarShapeDecorativo()
        THIS.ConfigurarGrade()
        THIS.ConfigurarBotoes()

        RETURN .T.
    ENDPROC


    *==========================================================================
    * ConfigurarPaginaDados - ordem de tabulacao (TabIndex do dump)
    *
    * O nome eh o do contrato do pipeline. NAO existe pagina Dados a montar:
    * o SCX eh FLAT (sem PageFrame) e seus unicos controles de ENTRADA sao os
    * quatro Text1 das colunas da grade, entregues junto com ela na Fase 4 -
    * nao ha "metade dos campos" a acrescentar porque nao ha campo solto
    * nenhum. Inventar campos violaria o PILAR 1; deixar o metodo com corpo
    * THIS.Refresh() seria stub disfarcado. O trabalho que de fato sobra num
    * form FLAT eh a propriedade que a criacao em massa da Fase 4 derruba: o
    * TabIndex.
    *
    * Chamado DEPOIS de todos os AddObject, de proposito: cada AddObject
    * renumera o TabIndex dos irmaos pela ordem de criacao, entao atribuicao
    * feita no meio da montagem eh reembaralhada pelos objetos seguintes.
    *
    * ORDEM-ALVO: a EFETIVA do legado, nao o literal do dump. O VFP aplica o
    * TabIndex gravado no instante em que CRIA cada objeto e CLAMPA no total
    * de tab-ables existentes ali; por isso o alvo se obtem simulando o load
    * na ordem dos REGISTROS do SCX, nunca lendo o numero cru.
    *
    * Simulado e medido no VFP9 (2026-10-30), recriando na ordem do SCX
    * (cntSombra, Shape1, GradeSubN com o TabIndex = 1 do dump, cmdExcluir,
    * cmdSair):
    *
    *     grade = 1   cabecalho = 2   Excluir = 3   Encerrar = 4
    *
    * O 1 da grade SOBREVIVE ao load (1 <= 2 tab-ables criados ate ali) e
    * empurra o cabecalho para 2 - ou seja o Tab do legado comeca na GRADE,
    * que eh o unico lugar onde se digita. Shape NAO entra na conta: medido,
    * Shape nem TEM TabIndex (PEMSTATUS = .F.).
    *
    * Sao escritos os ordinais EFETIVOS (1/2/3/4) e nao o literal do dump,
    * para o codigo nao afirmar um valor que o objeto nunca guarda. Como a
    * ordem de criacao daqui coincide com a do SCX, a atribuicao ascendente
    * da o MESMO resultado que o form ja tinha - medido lado a lado:
    * atribuindo dentro do WITH da grade (como estava) e atribuindo aqui no
    * fim, os quatro TabIndex saem identicos. Entao isto nao muda
    * comportamento: torna a ordem EXPLICITA e protege contra alguem
    * reordenar os AddObject depois, que era o unico motivo de ela estar
    * certa antes.
    *
    * Ascendente tambem eh regra medida, nao estilo: em ordem DESCENDENTE o
    * VFP troca grade e botao de lugar.
    *
    * PUBLIC: o harness das etapas de teste chama metodos do form de FORA da
    * classe, e PROTECTED falharia com "Property ... is not found" - PEMSTATUS
    * devolve .T. mesmo para metodo protegido, entao o teste entra no branch e
    * so quebra na chamada real (regra #3).
    *==========================================================================
    PROCEDURE ConfigurarPaginaDados()
        *-- Grade primeiro: eh onde o usuario digita as faixas (SCX:
        *-- GradeSubN.TabIndex = 1 - o unico TabIndex declarado no dump)
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.TabIndex = 1
        ENDIF

        *-- Cabecalho: so tem Label dentro, nao para o Tab. Fica em 2 porque
        *-- eh o que o load do legado produz, nao por escolha.
        IF PEMSTATUS(THIS, "cnt_4c_Sombra", 5)
            THIS.cnt_4c_Sombra.TabIndex = 2
        ENDIF

        *-- Botoes, na ordem dos registros do SCX (Left 450, depois 525)
        IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
            THIS.cmd_4c_Excluir.TabIndex = 3
        ENDIF

        IF PEMSTATUS(THIS, "cmd_4c_Encerrar", 5)
            THIS.cmd_4c_Encerrar.TabIndex = 4
        ENDIF

        RETURN .T.
    ENDPROC


    *==========================================================================
    * ConfigurarShapeDecorativo - Shape1 do legado
    *
    * Dump: Top=7 Left=205 Height=110 Width=173
    *       BackStyle=0 BorderStyle=0 BorderColor=136,189,188
    *
    * BackStyle = 0 (transparente) com BorderStyle = 0 (sem borda) deixa o
    * objeto SEM pintura alguma: ele nao aparece na tela. Transcrito mesmo
    * assim porque esta no dump (PILAR 1) e porque BorderColor declarado
    * indica que o desenhista pretendia uma moldura - mexer em BorderStyle
    * para "fazer aparecer" seria inventar UI que o usuario nunca viu.
    *
    * Shape NAO tem ForeColor (so BorderColor/FillColor) nem ShapeType (essa
    * eh do VB; no VFP o equivalente eh Curvature) - nenhuma das duas eh
    * atribuida aqui, senao o Init estouraria "Property ... is not found" e a
    * tela nao abriria (regra #33).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarShapeDecorativo()
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 205
            .Height      = 110
            .Width       = 173
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        RETURN .T.
    ENDPROC


    *==========================================================================
    * ConfigurarGrade - GradeSubN do legado (grd_4c_Dados)
    *
    * Dump: ColumnCount=4 FontName="Tahoma" FontSize=8 DeleteMark=.F.
    *       Top=103 Left=118 Width=363 Height=227 RowHeight=16
    *       ScrollBars=2 TabIndex=1 GridLineColor=238,238,238
    *
    * O TabIndex = 1 do dump NAO eh atribuido aqui: TabIndex tem de ser
    * aplicado DEPOIS de todos os AddObject, senao cada AddObject seguinte
    * renumera os irmaos. Mora em ConfigurarPaginaDados().
    *
    * Tahoma, e nao Verdana: Verdana eh o canonico da grade de LISTA do
    * frmcadastro, e esta tela nao eh um cadastro paginado - o dump declara
    * Tahoma 8 no proprio Grid.
    *
    * Sem compensacao de +29 no Top: sem PageFrame, os Top do dump sao
    * absolutos (os -29 do pgf_4c_Paginas nao existem aqui).
    *
    * RecordMark: o dump declara DeleteMark = .F. e eh SILENCIOSO sobre
    * RecordMark, que na BaseClass grid vale .T. - ou seja, a seta de registro
    * corrente aparecia no legado, e as larguras fecham com ela (100+100+48+80
    * = 328, mais a marca e a barra de rolagem, nos 363 do Grid). Mesmo assim
    * fica .F.: eh a regra do projeto para grade de form OPERACIONAL, e o
    * CorretorAutomatico (#58/GridRecordMarkDeleteMark) INJETA .F. quando a
    * propriedade esta ausente. Declarar explicitamente deixa a decisao
    * visivel no codigo em vez de ser acrescentada em silencio no proximo
    * sweep. As larguras das colunas seguem as do dump, intocadas.
    *
    * Nada de RecordSource / ControlSource aqui - ver CarregarLista.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .ColumnCount    = 4
            .Top            = 103
            .Left           = 118
            .Width          = 363
            .Height         = 227
            .FontName       = "Tahoma"
            .FontSize       = 8
            .RowHeight      = 16
            .ScrollBars     = 2
            .GridLineColor  = RGB(238, 238, 238)
            .RecordMark     = .F.
            .DeleteMark     = .F.
            .Visible        = .T.
        ENDWITH

        *-- Propriedades de COLUNA num metodo proprio: elas sao reaplicadas
        *-- depois de cada RecordSource (ver ConfigurarColunasGrade).
        THIS.ConfigurarColunasGrade()

        RETURN .T.
    ENDPROC


    *==========================================================================
    * ConfigurarColunasGrade - propriedades de COLUNA, reaplicaveis
    *
    * Mexer em RecordSource (e nos ControlSource) faz o VFP RECALCULAR as
    * larguras para o default 90 e devolver os cabecalhos a "Header1" -
    * silenciosamente. Por isso tudo que eh de coluna mora aqui e este metodo
    * eh chamado DUAS vezes: ao criar a grade (para ela ja nascer certa) e de
    * novo logo depois de cada bind, em VincularGrade.
    *
    * Dump, coluna por coluna:
    *   Column1 "Faixa Inicial" Width=100 Movable=.F. Resizable=.F.
    *           InputMask="999,999,999.99"
    *   Column2 "Faixa Final"   Width=100 Movable=.F. Resizable=.F.
    *           InputMask="999,999,999.99"   Text1.ReadOnly=.F.
    *   Column3 "%"             Width=48  InputMask="999.99"
    *           (NAO declara Movable/Resizable - ficam no default .T.)
    *   Column4 "Multiplos"     Width=80  Movable=.F. Resizable=.F.
    *           InputMask="999,999,999.99"
    *   Header1 de todas: Tahoma 8, Alignment=2 (centralizado)
    *   Text1   de todas: Tahoma 8, BorderStyle=0, Margin=0,
    *                     ForeColor=0,0,0, BackColor=255,255,255
    *
    * "Multiplos" vai SEM acento porque eh assim que esta no dump - o rotulo
    * que o usuario conhece eh esse, nao "Multiplos" com o til (PILAR 1).
    *
    * Os InputMask sao transcritos do SCX e NAO sao palpite de largura:
    * "999,999,999.99" sao 9 digitos + 2 decimais = numeric(11,2) de faixais /
    * faixafs / multiplos, e "999.99" sao 3 + 2 = numeric(5,2) de percs. Eles
    * valem como mascara normal (nenhuma coluna tem Format com "M", que
    * transformaria o InputMask em lista de valores validos - regra #24).
    *
    * ReadOnly NAO eh atribuido em coluna nenhuma: a grade eh editavel e o
    * legado so declara ReadOnly = .F. explicito na Column2.Text1, que ja eh o
    * default. Travar coluna aqui tiraria do usuario a digitacao das faixas.
    *==========================================================================
    PROCEDURE ConfigurarColunasGrade()
        LOCAL loc_oGrade

        IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN .F.
        ENDIF

        loc_oGrade = THIS.grd_4c_Dados

        *-- Column1 - "Faixa Inicial" (faixais)
        WITH loc_oGrade.Column1
            .Width     = 100
            .Movable   = .F.
            .Resizable = .F.
            .InputMask = "999,999,999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            WITH .Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .Caption   = "Faixa Inicial"
            ENDWITH
            WITH .Text1
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
        ENDWITH

        *-- Column2 - "Faixa Final" (faixafs)
        WITH loc_oGrade.Column2
            .Width     = 100
            .Movable   = .F.
            .Resizable = .F.
            .InputMask = "999,999,999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            WITH .Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .Caption   = "Faixa Final"
            ENDWITH
            WITH .Text1
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .F.
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
        ENDWITH

        *-- Column3 - "%" (percs). Movable/Resizable ausentes no dump.
        WITH loc_oGrade.Column3
            .Width     = 48
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            WITH .Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .Caption   = "%"
            ENDWITH
            WITH .Text1
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
        ENDWITH

        *-- Column4 - "Multiplos" (multiplos)
        WITH loc_oGrade.Column4
            .Width     = 80
            .Movable   = .F.
            .Resizable = .F.
            .InputMask = "999,999,999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            WITH .Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .Caption   = "Multiplos"
            ENDWITH
            WITH .Text1
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
        ENDWITH

        RETURN .T.
    ENDPROC


    *==========================================================================
    * ConfigurarBotoes - cmdExcluir e cmdSair do legado
    *
    * Dump: cmdExcluir Top=3 Left=450 Picture=cadastro_excluir_60.jpg
    *                  Caption="Excluir"
    *       cmdSair    Top=3 Left=525 Picture=cadastro_sair_60.jpg
    *                  Caption="Encerrar" Cancel=.T.
    *
    * Os dois sao da classe fwbtng do framework.vcx, que nao veio portada: a
    * geometria sai do proprio dump (o vao de 75 entre os dois Left, e 525+75
    * = 600 = Width do form, confirmam Width = 75) e as demais propriedades
    * sao as canonicas de botao do projeto (Comic Sans MS 8 bold italic,
    * ForeColor 90,90,90 sobre BackColor branco, Themes, PicturePosition 13).
    *
    * Nomes canonicos do projeto (cmd_4c_Excluir / cmd_4c_Encerrar), nao os
    * cmd_4c_CmdExcluir / cmd_4c_CmdSair do mapeamento gerado: o mapeamento de
    * validacao de UI eh regerado a partir DESTE .prg, e os patterns do
    * CorretorAutomatico e a regra #10 falam de cmd_4c_Encerrar.
    *
    * .Themes = .T. + .DisabledPicture obrigatorios: botao standalone com
    * .Picture e Themes = .F. NAO desenha o icone quando fica .Enabled = .F.,
    * e o Excluir eh justamente o que o legado desabilita por falta de acesso.
    *
    * Picture TRANSCRITO do dump, nao escolhido por semelhanca: o legado usa
    * cadastro_sair_60.jpg no Encerrar, e em outras telas o mesmo botao de
    * "fechar" usa o icone de SALVAR - palpite semantico erra (regra #25). Os
    * dois arquivos foram conferidos em vbmp\; Picture inexistente nao da erro
    * nenhum, o botao so fica sem icone.
    *
    * Cancel = .T. no Encerrar eh do dump: eh o que faz o ESC fechar a tela.
    * Como o form nao tem barra de titulo, ele e o Alt+F4 sao as unicas saidas
    * alem do clique - por isso ReabilitarFormPai tambem roda no Destroy.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH THIS.cmd_4c_Excluir
            .Top             = 3
            .Left            = 450
            .Width           = 75
            .Height          = 75
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .ToolTipText     = "Excluir a faixa de valores selecionada"
            .Visible         = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top             = 3
            .Left            = 525
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Cancel          = .T.
            .ToolTipText     = "Gravar as faixas de valores e encerrar"
            .Visible         = .T.
        ENDWITH

        *-- BINDEVENT so DEPOIS de os dois objetos existirem, e apontando para
        *-- metodos que JA estao definidos nesta classe: delegate inexistente
        *-- estoura no proprio BINDEVENT e derruba o Init.
        BINDEVENT(THIS.cmd_4c_Excluir,  "Click", THIS, "CmdExcluirClick")
        BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")

        RETURN .T.
    ENDPROC


    *==========================================================================
    * AjustarBotoesPorModo - espelha a permissao resolvida pelo BO
    *
    * Legado (Init):
    *     .cmdExcluir.Visible = fChecaAcesso('SigOpCrr','EXCLUIR') And ;
    *                           Iif( Type('Thisform.PcEscolha') # 'C', .T., ;
    *                           InList( Thisform.PcEscolha, 'INSERIR','ALTERAR' ) )
    *     .cmdExcluir.Enabled = .cmdExcluir.Visible
    *
    * As duas condicoes ja foram resolvidas uma vez no Init do BO e moram em
    * this_lPodeExcluir - aqui so se espelha, para a permissao ter fonte
    * UNICA. O Encerrar nao tem gate no legado: eh a saida da tela e fica
    * sempre ativo (desabilita-lo prenderia o usuario, porque o form nao tem
    * barra de titulo).
    *
    * PUBLIC de proposito: o harness da etapa 06b chama AjustarBotoesPorModo()
    * de FORA da classe e PROTECTED falharia com "Property ... is not found"
    * (regra #3) - PEMSTATUS(...,5) devolve .T. mesmo para metodo protegido,
    * entao o teste entra no branch e so quebra na chamada real.
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lPodeExcluir

        loc_lPodeExcluir = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_lPodeExcluir = THIS.this_oBusinessObject.this_lPodeExcluir
        ENDIF

        IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
            THIS.cmd_4c_Excluir.Visible = loc_lPodeExcluir
            THIS.cmd_4c_Excluir.Enabled = loc_lPodeExcluir
        ENDIF

        IF PEMSTATUS(THIS, "cmd_4c_Encerrar", 5)
            THIS.cmd_4c_Encerrar.Visible = .T.
            THIS.cmd_4c_Encerrar.Enabled = .T.
        ENDIF

        RETURN .T.
    ENDPROC


    *==========================================================================
    * CarregarLista - carrega as faixas e LIGA a grade ao cursor
    *
    * Transcricao do trecho de carga do Init legado:
    *     With SigCdOpe.poDatamgr
    *         .ReQuery('crSigOpCrr') / SELECT crSigOpCrr / Go Top
    *     EndWith
    *     Select CrSigOpCrr / Goto Top
    *     If Reccount() = 0 And InList(Thisform.PcEscolha,'INSERIR','ALTERAR')
    *         ThisForm.inserelinha()
    *     Endif
    *     With Thisform.GradeSubN
    *         .RecordSource          = 'crSigOpCrr'
    *         .Column1.ControlSource = 'crSigOpCrr.FaixaIs'
    *         ... .Refresh
    *     EndWith
    *
    * A ordem eh regra: carregar -> garantir a linha de digitacao -> LIGAR a
    * grade -> repintar. Ligar antes de o cursor existir estoura o Init
    * (regra #41), e repintar sem o GO TOP deixa a grade visualmente vazia com
    * o cursor cheio (regra #21).
    *
    * Sem SetFocus na Column1 aqui, embora o inserelinha legado o faca: este
    * caminho roda dentro do Init, com o form ainda invisivel, e SetFocus em
    * controle de form nao mostrado falha. O foco inicial eh assunto do fluxo
    * interativo de insercao de linha.
    *
    * PUBLIC: o harness chama THIS.oForm.CarregarLista() de fora (regra #3).
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_cAlias, loc_oBO, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_oBO    = THIS.this_oBusinessObject
        loc_cAlias = ALLTRIM(loc_oBO.this_cCursorDados)

        TRY
            *-- CarregarFaixas prepara o cursor, traz as faixas da operacao e
            *-- deixa o ponteiro no topo. Sem conexao (modo de teste) ou sem
            *-- operacao no contexto ele devolve .T. com o cursor VAZIO, e a
            *-- grade tem de ser ligada do mesmo jeito - senao ela fica um
            *-- retangulo branco sem cabecalho.
            loc_lSucesso = loc_oBO.CarregarFaixas()

            *-- Linha em branco de digitacao, como o legado faz no Init - e
            *-- so nos modos editaveis.
            IF USED(loc_cAlias)
                IF RECCOUNT(loc_cAlias) = 0 ;
                   AND INLIST(UPPER(ALLTRIM(THIS.this_cEscolha)), "INSERIR", "ALTERAR")
                    loc_oBO.InserirLinhaCursor()
                ENDIF
            ENDIF

            *-- Bind + reaplicacao das propriedades de coluna
            THIS.VincularGrade()

            *-- GO TOP + Refresh: popular o cursor NAO repinta a grade.
            IF USED(loc_cAlias)
                SELECT (loc_cAlias)
                GO TOP
            ENDIF
            THIS.RepintarGrade()
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao carregar as faixas de valores:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Faixas de Valores")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *==========================================================================
    * VincularGrade - RecordSource + ControlSource das 4 colunas
    *
    * Transcricao do With Thisform.GradeSubN do Init legado, com os mesmos
    * pares coluna/campo:
    *     Column1 -> FaixaIs    Column3 -> Percs
    *     Column2 -> FaixaFs    Column4 -> Multiplos
    *
    * ColumnCount eh reposto ANTES do RecordSource porque o cursor tem SETE
    * colunas (as seis de SigOpCrr mais o marcador lnovos) e sem ele a grade
    * se auto-expande para todas - o usuario veria cidchaves, dopes e lnovos
    * na tela. O guard IF != 4 existe porque atribuir ColumnCount RECRIA os
    * objetos Column, descartando tudo o que foi posto neles; reatribuir o
    * mesmo valor sem necessidade so cria risco.
    *
    * ConfigurarColunasGrade() por ULTIMO: RecordSource e ControlSource
    * acabaram de devolver as larguras ao default 90 e os cabecalhos a
    * "Header1".
    *
    * PUBLIC porque tambem eh o ponto de religacao quando o BO avisa, por
    * this_lCursorRecriado, que FECHOU e recriou o alias - fechar o alias
    * derruba o binding da grade EM SILENCIO.
    *==========================================================================
    PROCEDURE VincularGrade()
        LOCAL loc_lSucesso, loc_cAlias, loc_oGrade, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O" ;
           OR !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN .F.
        ENDIF

        loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorDados)
        loc_oGrade = THIS.grd_4c_Dados

        IF !USED(loc_cAlias)
            *-- Sem cursor nao ha o que ligar, e atribuir ControlSource agora
            *-- estouraria "Alias ... is not found".
            RETURN .F.
        ENDIF

        TRY
            *-- ColumnCount e RecordSource FORA do WITH: colunas recriadas por
            *-- ColumnCount nao ficam disponiveis de forma confiavel dentro do
            *-- mesmo bloco WITH que acabou de abrir, e o acesso a .ColumnN
            *-- logo depois estouraria "Unknown member COLUMNN".
            IF loc_oGrade.ColumnCount != 4
                loc_oGrade.ColumnCount = 4
            ENDIF

            loc_oGrade.RecordSource = loc_cAlias

            WITH loc_oGrade
                .Column1.ControlSource = loc_cAlias + ".faixais"
                .Column2.ControlSource = loc_cAlias + ".faixafs"
                .Column3.ControlSource = loc_cAlias + ".percs"
                .Column4.ControlSource = loc_cAlias + ".multiplos"
            ENDWITH

            *-- Larguras e cabecalhos DEPOIS do bind, sempre
            THIS.ConfigurarColunasGrade()

            *-- Celulas com evento DEPOIS de ConfigurarColunasGrade: o
            *-- ColumnCount acima pode ter RECRIADO os objetos Column, e com
            *-- eles o CurrentControl e o TextBox instalado.
            THIS.InstalarCelulasFaixa(loc_oGrade)

            *-- Reabre a digitacao nas QUATRO colunas. O bloco acima mexeu em
            *-- RecordSource/ControlSource e pode ter reatribuido ColumnCount,
            *-- e Grid.ReadOnly propaga para as colunas (regra #18/#46):
            *-- Column1 e Column3, que seguem com o Text1 nativo, nao passam
            *-- por InstalarCelulasFaixa e ficariam com o que o grid propagou.
            THIS.HabilitarCampos(.T.)

            THIS.this_oBusinessObject.this_lCursorRecriado = .F.

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao vincular a grade das faixas de valores:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Faixas de Valores")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *==========================================================================
    * RepintarGrade - ThisForm.GradeSubN.Refresh do legado
    *
    * Refresh PURO, sem GO TOP: quem precisa do topo (a carga) faz o GO TOP
    * antes de chamar. O Excluir, ao contrario, acabou de reposicionar o
    * ponteiro com o par Skip / Skip -1 do legado e um GO TOP aqui jogaria o
    * usuario para a primeira linha a cada exclusao.
    *
    * PUBLIC: chamado pelos handlers e pelo harness.
    *==========================================================================
    PROCEDURE RepintarGrade()
        LOCAL loc_oErro

        IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN .F.
        ENDIF

        TRY
            THIS.grd_4c_Dados.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSigOpCrd.RepintarGrade")
        ENDTRY

        RETURN .T.
    ENDPROC


    *==========================================================================
    * InstalarCelulasFaixa - poe TextBoxFaixaSigOpCrd_4c nas colunas que o
    * legado dota de evento: Column2 (Faixa Final) e Column4 (Multiplos)
    *
    * O legado tem LostFocus em DUAS celulas da grade, e so nessas duas:
    *     SIGOPCRD.GradeSubN.Column2.Text1.LostFocus
    *     SIGOPCRD.GradeSubN.Column4.Text1.LostFocus
    * Column1 (Faixa Inicial) e Column3 (%) nao tem evento algum no dump -
    * instalar celula nelas seria acrescentar comportamento que o legado nao
    * tem (PILAR 1), entao elas seguem com o Text1 nativo.
    *
    * POR QUE SUBCLASSE E NAO BINDEVENT: BINDEVENT em evento de TextBox dentro
    * de Column nao dispara de forma confiavel no VFP9 - eh a razao de existir
    * classes\TextBoxGridLookup.prg, que documenta isso no proprio cabecalho.
    * O caminho canonico do projeto (regra #46, referencia FormLpr) eh um
    * TextBox subclasse com o evento EMBUTIDO delegando a metodo PUBLIC do
    * form, posto na coluna com AddObject + CurrentControl + Sparse = .F.
    *
    * As TRES linhas finais sao obrigatorias juntas (regra #18):
    *     AddObject         - cria o objeto, mas a coluna segue desenhando o Text1
    *     CurrentControl    - eh o que faz a coluna DESENHAR o novo controle
    *     Sparse = .F.      - senao ele so aparece na linha ATIVA
    * Faltando CurrentControl o controle existe, responde a PEMSTATUS e NUNCA
    * aparece - e o LostFocus nunca roda, sem erro e sem log.
    *
    * As propriedades de Text1 do dump sao reaplicadas AQUI porque
    * ConfigurarColunasGrade configura o .Text1, que nestas duas colunas
    * deixou de ser o controle exibido - sem repetir, as duas celulas sairiam
    * com borda, margem e fonte diferentes das outras duas. InputMask tambem
    * entra no controle: a mascara da COLUNA nao chega ao TextBox instalado.
    *
    * IDEMPOTENTE (guard PEMSTATUS): eh chamado de VincularGrade, que roda em
    * toda carga, e AddObject com nome repetido estoura "Object ... is already
    * defined" e derruba o Init.
    *==========================================================================
    PROTECTED PROCEDURE InstalarCelulasFaixa(par_oGrade)
        LOCAL loc_nI, loc_nCol, loc_oColuna, loc_cCampo, loc_oErro

        IF VARTYPE(par_oGrade) != "O"
            RETURN .F.
        ENDIF

        TRY
            FOR loc_nI = 1 TO 2
                *-- Column2 -> faixafs ; Column4 -> multiplos
                loc_nCol   = IIF(loc_nI = 1, 2, 4)
                loc_cCampo = IIF(loc_nI = 1, "faixafs", "multiplos")

                IF par_oGrade.ColumnCount < loc_nCol
                    LOOP
                ENDIF

                loc_oColuna = par_oGrade.Columns(loc_nCol)

                IF !PEMSTATUS(loc_oColuna, "txt_4c_Faixa", 5)
                    loc_oColuna.AddObject("txt_4c_Faixa", "TextBoxFaixaSigOpCrd_4c")
                ENDIF

                WITH loc_oColuna.txt_4c_Faixa
                    .this_cCampo = loc_cCampo

                    *-- Text1 do dump, celula por celula
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)

                    *-- Dump: Column2.InputMask e Column4.InputMask
                    .InputMask   = "999,999,999.99"

                    *-- Dump: so a Column2.Text1 declara ReadOnly = .F.
                    *-- explicito; na Column4 o default .F. ja eh esse valor.
                    .ReadOnly    = .F.

                    .Visible     = .T.
                ENDWITH

                *-- Sem estas duas a celula nao aparece / aparece so na linha ativa
                loc_oColuna.CurrentControl = "txt_4c_Faixa"
                loc_oColuna.Sparse         = .F.

                *-- Column.ReadOnly DEPOIS do Grid.ReadOnly: o do grid propaga
                *-- para as colunas e sobrescreveria este (regra #18).
                loc_oColuna.ReadOnly       = .F.
            ENDFOR
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao instalar as c" + CHR(233) + "lulas da grade:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Faixas de Valores")
        ENDTRY

        RETURN .T.
    ENDPROC


    *==========================================================================
    * ValidarFaixaFinal - LostFocus da Column2.Text1 (Faixa Final) do legado
    *
    * Legado, LITERAL:
    *     PROCEDURE LostFocus
    *     If IsEmpty(This.Value)
    *         Thisform.cmdSair.SetFocus
    *     EndIf
    *
    * Faixa Final em branco significa "acabei de preencher": o legado leva o
    * usuario direto ao Encerrar, que eh o botao que grava. NAO eh validacao
    * com mensagem - nao existe aviso nenhum aqui, e inventar um mudaria o
    * fluxo da tela (PILAR 1).
    *
    * O valor lido eh par_oTxt.Value, NAO a coluna do cursor: dentro do evento
    * da celula o cursor ainda NAO recebeu o que foi digitado, entao ler do
    * cursor validaria o valor ANTIGO (regra #46).
    *
    * IsEmpty do Fortyus trata .NULL. como vazio, ao contrario do EMPTY nativo
    * do VFP (medido: EMPTY(.NULL.) devolve .F.). Daqui sai o ISNULL em IF
    * SEPARADO - VFP9 nao faz short-circuit em OR, entao ISNULL(x) OR EMPTY(x)
    * avaliaria EMPTY(.NULL.) de qualquer jeito.
    *
    * PUBLIC: chamado pela classe da celula (THISFORM.ValidarFaixaFinal) e
    * pelo harness.
    *==========================================================================
    PROCEDURE ValidarFaixaFinal(par_oTxt)
        *-- Wrapper fino da guarda de reentrancia. O corpo fica no ...Exec
        *-- porque este metodo tem RETURN antecipado: liberar a flag "no fim
        *-- do corpo" a deixaria travada ligada e MATARIA o handler pelo resto
        *-- da vida do form.
        IF THIS.this_lEmCelula
            RETURN .T.
        ENDIF

        THIS.this_lEmCelula = .T.
        THIS.ValidarFaixaFinalExec(par_oTxt)
        THIS.this_lEmCelula = .F.

        RETURN .T.
    ENDPROC


    *==========================================================================
    * ValidarFaixaFinalExec - corpo de ValidarFaixaFinal
    *==========================================================================
    PROTECTED PROCEDURE ValidarFaixaFinalExec(par_oTxt)
        LOCAL loc_lVazio, loc_uValor, loc_oErro

        IF VARTYPE(par_oTxt) != "O"
            RETURN .F.
        ENDIF

        TRY
            loc_uValor = par_oTxt.Value
            loc_lVazio = .F.

            *-- IF separado, nunca ISNULL(x) OR EMPTY(x)
            IF ISNULL(loc_uValor)
                loc_lVazio = .T.
            ELSE
                IF EMPTY(loc_uValor)
                    loc_lVazio = .T.
                ENDIF
            ENDIF

            IF loc_lVazio
                IF PEMSTATUS(THIS, "cmd_4c_Encerrar", 5)
                    *-- SetFocus falha em controle que nao esta visivel e
                    *-- habilitado (caminho de carga, form ainda nao mostrado).
                    IF THIS.cmd_4c_Encerrar.Visible AND THIS.cmd_4c_Encerrar.Enabled
                        THIS.cmd_4c_Encerrar.SetFocus()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao sair do campo Faixa Final:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Faixas de Valores")
        ENDTRY

        RETURN .T.
    ENDPROC


    *==========================================================================
    * ValidarMultiplos - LostFocus da Column4.Text1 (Multiplos) do legado
    *
    * Legado, LITERAL:
    *     PROCEDURE LostFocus
    *     Select CrSigOpCrr
    *     Locate for faixafs = 0
    *     If Eof()
    *         Thisform.Inserelinha()
    *     EndIf
    *     Select CrSigOpCrr
    *
    * Multiplos eh a ULTIMA coluna: ao sair dela o legado garante que exista
    * sempre UMA linha em branco esperando digitacao - se nenhuma linha tem
    * faixafs = 0, ele cria. Eh assim que o usuario acrescenta faixas sem
    * nenhum botao de "inserir": preenche a linha e a proxima aparece.
    *
    * Esse LOCATE eh tambem o que, na pratica, liga o marcador de alteracao
    * a gravar que o Encerrar consulta - as linhas vindas do servidor nunca
    * tem faixafs = 0, entao InserirLinha roda e marca this_lHouveInsercao
    * (ver HaAlteracaoPendente no BO). Por isso adiar este handler deixaria a
    * tela gravando MENOS do que o legado grava.
    *
    * O LOCATE roda sobre o CURSOR (nao sobre par_oTxt.Value): aqui a pergunta
    * eh "existe linha em branco na grade?", nao "o que foi digitado?".
    *
    * PUBLIC: chamado pela classe da celula e pelo harness.
    *==========================================================================
    PROCEDURE ValidarMultiplos(par_oTxt)
        IF THIS.this_lEmCelula
            RETURN .T.
        ENDIF

        THIS.this_lEmCelula = .T.
        THIS.ValidarMultiplosExec(par_oTxt)
        THIS.this_lEmCelula = .F.

        RETURN .T.
    ENDPROC


    *==========================================================================
    * ValidarMultiplosExec - corpo de ValidarMultiplos
    *==========================================================================
    PROTECTED PROCEDURE ValidarMultiplosExec(par_oTxt)
        LOCAL loc_cAlias, loc_lPrecisaLinha, loc_oErro

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_cAlias       = ALLTRIM(THIS.this_oBusinessObject.this_cCursorDados)
        loc_lPrecisaLinha = .F.

        IF !USED(loc_cAlias)
            RETURN .F.
        ENDIF

        TRY
            SELECT (loc_cAlias)
            LOCATE FOR faixafs = 0

            IF EOF()
                loc_lPrecisaLinha = .T.
            ENDIF

            IF loc_lPrecisaLinha
                THIS.InserirLinha()
            ENDIF

            *-- Select final do legado: o LOCATE pode ter deixado o alias
            *-- corrente em outro lugar e o resto da tela conta com este.
            IF USED(loc_cAlias)
                SELECT (loc_cAlias)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao sair do campo M" + CHR(250) + "ltiplos:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Faixas de Valores")
        ENDTRY

        RETURN .T.
    ENDPROC


    *==========================================================================
    * InserirLinha - parte de TELA do inserelinha legado
    *
    * Legado COMPLETO:
    *     PROCEDURE inserelinha
    *     Thisform.lHouveIns = .T.
    *     Select crSigOpCrr
    *     Locate for faixafs=0
    *     If Eof()
    *         Insert Into crSigOpCrr (Dopes, CidChaves) ;
    *             Values (crSigCdOpe.Dopes, fUniqueIds())
    *     EndIf
    *     Select crSigOpCrr
    *     Keyboard '{DNARROW}'
    *     ThisForm.GradeSubN.Refresh
    *     Thisform.GradeSubN.Column1.SetFocus
    *
    * A parte de DADOS (marcador lHouveIns, LOCATE, INSERT com a chave de
    * fUniqueIds) esta em InserirLinhaCursor, no BO - inclusive o marcador
    * ligado INCONDICIONALMENTE na primeira linha, como no legado: ele vale
    * mesmo quando a linha em branco ja existia e o INSERT nao roda.
    *
    * Aqui ficam as TRES ultimas linhas, que sao de tela e que o migrador
    * costuma descartar junto com o resto do handler - e sao elas que tornam a
    * linha nova USAVEL: sem o Refresh a grade continua mostrando o cursor
    * antigo (popular cursor NAO repinta a grade, regra #21a) e sem o SetFocus
    * o usuario tem de ir com o mouse ate a primeira coluna da linha nova.
    *
    * O Keyboard '{DNARROW}' eh transcrito como esta: ele enfileira a tecla
    * para DEPOIS deste metodo, e eh o que leva o cursor da grade para a linha
    * recem-criada.
    *
    * SetFocus so com o form MOSTRADO: este metodo tambem eh alcancavel pelo
    * caminho de carga (grade vazia), onde o form ainda nao foi exibido e o
    * SetFocus falharia. Eh a mesma razao pela qual CarregarLista chama
    * InserirLinhaCursor direto, sem passar por aqui.
    *
    * PUBLIC: chamado por ValidarMultiplos e pelo harness.
    *==========================================================================
    PROCEDURE InserirLinha()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        *-- Dados: marcador + LOCATE + INSERT (transcritos no BO)
        loc_lSucesso = THIS.this_oBusinessObject.InserirLinhaCursor()

        IF !loc_lSucesso
            *-- InserirLinhaCursor ja exibiu o motivo; sem linha nova nao ha
            *-- navegacao a fazer.
            RETURN .F.
        ENDIF

        TRY
            *-- Keyboard do legado: leva a grade para a linha nova
            KEYBOARD "{DNARROW}"

            THIS.RepintarGrade()

            IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND THIS.Visible
                IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled
                    THIS.grd_4c_Dados.Column1.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            *-- Navegacao que falha NAO invalida a linha ja inserida: o
            *-- resultado segue .T. e o usuario so perde o posicionamento
            *-- automatico. Avisar em vez de engolir (regra #9).
            MsgErro("Erro ao posicionar a grade na linha nova:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Faixas de Valores")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *==========================================================================
    * CmdExcluirClick - cmdExcluir.Click do legado
    *
    * Legado:
    *     Select crSigOpCrr
    *     If Not Eof()
    *         Thisform.lHouveExcl = .T.
    *         Delete / Skip / Skip - 1
    *     Endif
    *     ThisForm.GradeSubN.Refresh
    *
    * A parte de DADOS (marcador, DELETE e reposicionamento do ponteiro) mora
    * em ExcluirLinhaCursor, no BO; aqui fica o que eh da TELA. O Refresh vem
    * FORA do IF, como no legado: ele repinta tambem quando nada foi excluido.
    *
    * A remocao eh LOCAL - no legado o DELETE so chega ao servidor junto com a
    * gravacao do Encerrar, e eh isso que GravarFaixas reproduz. Nao ha
    * confirmacao porque o legado nao pede nenhuma, e o Encerrar eh a ultima
    * chance de desistir (fechar sem clicar nele descarta tudo).
    *==========================================================================
    PROCEDURE CmdExcluirClick()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_lSucesso = THIS.this_oBusinessObject.ExcluirLinhaCursor()
        ENDIF

        THIS.RepintarGrade()

        RETURN loc_lSucesso
    ENDPROC


    *==========================================================================
    * CmdEncerrarClick - cmdSair.Click do legado
    *
    * Legado:
    *     If ( Thisform.lHouveExcl Or Thisform.lHouveIns )
    *         ... Delete For Empty(Dopes) or Empty(faixafs)
    *         ... Replace CidChaves with fUniqueIds() For Empty(CidChaves)
    *         ... poDataMgr.UpDate / Commit / RollBack
    *         If Not m.lnErro1>0
    *             = MessageBox('Erro na Gravacao dos Dados do Cadastro de Operacoes.',48)
    *         EndIf
    *     EndIf
    *     Thisform.ParentForm.Enabled = .T.
    *     ThisForm.Release
    *
    * Tudo o que esta dentro do If (guard de alteracao a gravar, descarte das
    * linhas em branco, geracao das chaves e o lote atomico) esta em
    * GravarFaixas; aqui fica a sequencia da TELA.
    *
    * TRANSCRICAO FIEL, inclusive no ponto incomodo: o legado LIBERA O PAI E
    * FECHA A TELA MESMO QUANDO A GRAVACAO FALHA - o RollBack desfaz no
    * servidor, a MessageBox avisa, e o que foi digitado se perde. Fica igual
    * de proposito (PILAR 1). GravarFaixas sempre exibe o motivo real do SQL
    * Server antes de devolver .F., entao a falha nunca eh muda.
    *
    * Release() eh a ULTIMA linha, e nada eh lido do form depois dele: o
    * Release destroi o objeto e qualquer acesso seguinte cairia em referencia
    * morta. ReabilitarFormPai vem antes e eh idempotente - o Destroy, que o
    * proprio Release dispara, chama de novo sem efeito.
    *==========================================================================
    PROCEDURE CmdEncerrarClick()
        LOCAL loc_lGravou

        loc_lGravou = .T.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            *-- Flush da celula em edicao ANTES do lote: GravarFaixas le cada
            *-- linha do CURSOR, e o que esta no controle da coluna ativa pode
            *-- nao ter chegado nele. FormParaBO escreve so essa celula (ver o
            *-- cabecalho dele) - sem isto o ultimo valor digitado poderia ser
            *-- gravado com o conteudo anterior, sem erro e sem aviso.
            THIS.FormParaBO()

            *-- Fecha a digitacao enquanto o lote roda, que eh o mesmo que o
            *-- legado faz com o form PAI (ParentForm.Enabled = .F.). A tela
            *-- fecha em seguida nos dois caminhos, entao nao ha reabertura a
            *-- fazer - e o Encerrar continua ativo de proposito.
            THIS.HabilitarCampos(.F.)

            *-- GravarFaixas ja carrega o guard do legado: sem alteracao
            *-- a gravar ele nao toca no banco e devolve .T.
            loc_lGravou = THIS.this_oBusinessObject.GravarFaixas()
        ENDIF

        THIS.ReabilitarFormPai()
        THIS.Release()

        RETURN loc_lGravou
    ENDPROC


    *==========================================================================
    * BtnEncerrarClick - alias PUBLIC para o harness de teste automatizado
    *
    * O handler real chama-se CmdEncerrarClick (nomeado pelo objeto
    * cmd_4c_Encerrar, convencao deste form - regra do PILAR 3). O teste
    * 'BtnEncerrarExiste' da etapa 06b procura, por PEMSTATUS, um metodo
    * chamado BtnEncerrarClick/BtnFecharClick/BtnSairClick/FecharDialogo -
    * sem nenhum deles presente, o teste reprova mesmo com o encerramento
    * funcionando. Mesmo padrao de FormFop.BtnEncerrarClick: wrapper fino que
    * so delega, sem duplicar logica de gravacao/fechamento.
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        RETURN THIS.CmdEncerrarClick()
    ENDPROC


    *==========================================================================
    * DesabilitarFormPai - ParentForm.Enabled = .F. do legado
    *==========================================================================
    PROCEDURE DesabilitarFormPai()
        LOCAL loc_oErro

        IF VARTYPE(THIS.this_oFormPai) != "O"
            RETURN .F.
        ENDIF

        TRY
            IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
                IF THIS.this_oFormPai.Enabled
                    THIS.this_oFormPai.Enabled = .F.
                    *-- Marca que o bloqueio eh NOSSO: so assim a reabilitacao
                    *-- pode acontecer sem risco de reabilitar um form que ja
                    *-- estava desabilitado por outro motivo.
                    THIS.this_lPaiDesabilitado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSigOpCrd.DesabilitarFormPai")
        ENDTRY

        RETURN THIS.this_lPaiDesabilitado
    ENDPROC


    *==========================================================================
    * ReabilitarFormPai - ParentForm.Enabled = .T. do legado
    *
    * IDEMPOTENTE e chamado pelo FUNIL de volta (aqui o Destroy; na fase do
    * botao Encerrar, tambem o cmdSair). Dialogo sem barra de titulo ainda
    * fecha por Alt+F4 - se a reabilitacao morasse so no botao, esse caminho
    * deixaria o cadastro de Operacoes desabilitado para sempre.
    *==========================================================================
    PROCEDURE ReabilitarFormPai()
        LOCAL loc_oErro

        IF !THIS.this_lPaiDesabilitado OR VARTYPE(THIS.this_oFormPai) != "O"
            RETURN .F.
        ENDIF

        TRY
            IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
                THIS.this_oFormPai.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            *-- O guard de VARTYPE acima ja absorve o caso NORMAL de o pai ter
            *-- sido liberado antes, entao chegar aqui eh de fato inesperado -
            *-- e a consequencia eh grave: o cadastro de Operacoes continuaria
            *-- desabilitado e o usuario ficaria preso. Por isso avisa em vez
            *-- de engolir (regra #9).
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel reabilitar a tela de origem: " + ;
                    loc_oErro.Message, "FormSigOpCrd.ReabilitarFormPai")
        ENDTRY

        *-- Marcador cai nos dois caminhos, para o Destroy nao repetir a
        *-- tentativa (e, no caminho de erro, nao repetir o aviso).
        THIS.this_lPaiDesabilitado = .F.

        RETURN .T.
    ENDPROC


    *==========================================================================
    * FormParaBO - transfere a LINHA CORRENTE da grade para o BO
    *
    * Nesta tela a "ficha" nao eh um painel de campos soltos: eh a LINHA da
    * grade. As quatro colunas tem ControlSource ligado direto ao cursor
    * (VincularGrade), entao o estado dos campos JA mora no cursor - o que
    * este hook acrescenta eh o unico pedaco que ainda nao chegou nele: a
    * celula que o usuario esta digitando AGORA.
    *
    * POR QUE SO A COLUNA ATIVA EH LIDA DO CONTROLE
    *
    * Com Sparse = .F. a coluna desenha o MESMO objeto de controle em todas as
    * linhas (eh um controle por COLUNA, nao por celula). Na coluna ATIVA esse
    * controle guarda o valor em edicao, que pode ainda nao ter chegado ao
    * cursor - eh a mesma razao pela qual os handlers de celula leem
    * par_oTxt.Value e nao a coluna do cursor (regra #46). Nas OUTRAS colunas o
    * .Value so eh garantido para a linha que foi PINTADA por ultimo; copiar
    * dali para o cursor poderia gravar na linha corrente um valor de OUTRA
    * linha. Por isso o flush eh cirurgico: coluna ATIVA, e so ela.
    *
    * ActiveColumn devolve 0 enquanto a grade nunca recebeu foco (property
    * conferida em automation\propriedades_baseclasses.txt, regra #33) - o
    * guard de 1..4 cobre esse caso e tambem um ColumnCount diferente de 4.
    *
    * DO CASE com nomes de campo LITERAIS, de proposito: REPLACE com nome
    * montado funcionaria, mas aqui sao quatro pares fixos e escrever os nomes
    * elimina qualquer duvida sobre o campo atingido - esta eh a unica escrita
    * que este metodo faz no cursor.
    *
    * Depois do flush, CarregarDoCursor le as SEIS colunas da linha (as quatro
    * da tela mais cidchaves e dopes, que nao aparecem) para as properties do
    * BO. A lista de colunas fica, assim, em UM lugar so - o BO.
    *
    * PROTECTED EXPLICITO, e nao eh escolha de estilo: FormBase declara
    * PROTECTED PROCEDURE FormParaBO (eh um dos hooks que Salvar/Novo/Cancelar
    * chamam por THIS.) e o VFP9 NAO deixa a subclasse ALARGAR o escopo -
    * escrever sem o modificador nao torna publico, so esconde que continua
    * protegido. Medido nesta tela em 2026-10-30: chamado de um script solto,
    * estoura "Property FORMPARABO is not found"; chamado por THIS. de dentro
    * da classe, ou de uma SUBCLASSE de teste, funciona. PEMSTATUS(...,5) nao
    * ajuda a descobrir isso - ele responde "existe?", nao "da para chamar
    * daqui?" (mesma armadilha da regra #3).
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lSucesso, loc_cAlias, loc_oGrade, loc_nAtiva
        LOCAL loc_oColuna, loc_cControle, loc_oCelula, loc_uValor, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O" ;
           OR !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN .F.
        ENDIF

        loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorDados)

        IF !USED(loc_cAlias)
            *-- Sem cursor nao ha linha corrente a transferir. Nao eh erro:
            *-- acontece em modo de teste, antes da primeira carga.
            RETURN .F.
        ENDIF

        loc_oGrade = THIS.grd_4c_Dados

        TRY
            SELECT (loc_cAlias)

            IF !EOF()
                loc_nAtiva = loc_oGrade.ActiveColumn

                IF loc_nAtiva >= 1 AND loc_nAtiva <= 4 ;
                   AND loc_nAtiva <= loc_oGrade.ColumnCount
                    loc_oColuna   = loc_oGrade.Columns(loc_nAtiva)
                    loc_cControle = ALLTRIM(NVL(loc_oColuna.CurrentControl, ""))
                    loc_oCelula   = .NULL.

                    *-- Membro alcancado por NOME: EVALUATE na LEITURA, nunca
                    *-- Controls(<nome>) - Controls eh indexado por NUMERO e o
                    *-- nome estoura em runtime (regra #34).
                    IF !EMPTY(loc_cControle) ;
                       AND PEMSTATUS(loc_oColuna, loc_cControle, 5)
                        loc_oCelula = EVALUATE("loc_oColuna." + loc_cControle)
                    ENDIF

                    IF VARTYPE(loc_oCelula) = "O"
                        loc_uValor = loc_oCelula.Value

                        *-- So valor NUMERICO entra: as quatro colunas sao
                        *-- numericas no schema e atribuir outro tipo ao campo
                        *-- estouraria "Data type mismatch".
                        IF VARTYPE(loc_uValor) = "N"
                            DO CASE
                            CASE loc_nAtiva = 1
                                IF faixais != loc_uValor
                                    REPLACE faixais WITH loc_uValor IN (loc_cAlias)
                                ENDIF

                            CASE loc_nAtiva = 2
                                IF faixafs != loc_uValor
                                    REPLACE faixafs WITH loc_uValor IN (loc_cAlias)
                                ENDIF

                            CASE loc_nAtiva = 3
                                IF percs != loc_uValor
                                    REPLACE percs WITH loc_uValor IN (loc_cAlias)
                                ENDIF

                            CASE loc_nAtiva = 4
                                IF multiplos != loc_uValor
                                    REPLACE multiplos WITH loc_uValor IN (loc_cAlias)
                                ENDIF
                            ENDCASE
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            *-- Linha -> properties do BO. Devolve .F. em cursor vazio, e esta
            *-- certo em fazer isso: nao ha linha corrente para transferir.
            loc_lSucesso = THIS.this_oBusinessObject.CarregarDoCursor(loc_cAlias)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao transferir a faixa de valores da tela:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Faixas de Valores")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *==========================================================================
    * BOParaForm - escreve as properties do BO na LINHA CORRENTE da grade
    *
    * Sentido inverso do FormParaBO, com o MESMO par coluna/campo de
    * VincularGrade. Como as colunas tem ControlSource, escrever no CURSOR eh
    * escrever "no campo da tela" - nao existe .Value avulso a atualizar; o que
    * falta depois eh so repintar, porque mexer no cursor NAO repinta a grade
    * (regra #21).
    *
    * SO as QUATRO colunas visiveis sao escritas. cidchaves e dopes ficam de
    * fora de proposito: eles sao a IDENTIDADE da linha (a chave gerada por
    * fUniqueIds no InserirLinhaCursor e a operacao dona das faixas), nao
    * campos de tela. Sobrescreve-los aqui trocaria a linha de registro - ou,
    * pior, a deixaria com dopes vazio, que eh justamente o que o
    * "Delete For Empty(Dopes)" do Encerrar legado joga fora.
    *
    * GUARDA DE IDENTIDADE: com this_cCidchaves preenchido, a escrita so
    * acontece se a linha corrente for essa mesma. O BO eh carregado linha a
    * linha pelo SCAN de GravarFaixas, entao sem essa conferencia uma chamada
    * fora de hora escreveria os valores de uma faixa sobre outra. Com
    * this_cCidchaves VAZIO (o que LimparDados produz) a guarda nao se aplica:
    * ali a intencao eh justamente zerar a linha corrente.
    *
    * PROTECTED EXPLICITO pelo mesmo motivo do FormParaBO: FormBase declara
    * PROTECTED PROCEDURE BOParaForm e o escopo vem da HERANCA - omitir o
    * modificador nao alarga nada. Chamado por THIS. de dentro da classe
    * (LimparCampos e o funil do Encerrar).
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lSucesso, loc_cAlias, loc_oBO, loc_cChaveBO, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_oBO      = THIS.this_oBusinessObject
        loc_cAlias   = ALLTRIM(loc_oBO.this_cCursorDados)
        loc_cChaveBO = ALLTRIM(NVL(loc_oBO.this_cCidchaves, ""))

        IF !USED(loc_cAlias)
            RETURN .F.
        ENDIF

        TRY
            SELECT (loc_cAlias)

            DO CASE
            CASE EOF()
                *-- Sem linha corrente nao ha o que escrever.
                loc_lSucesso = .F.

            CASE !EMPTY(loc_cChaveBO) ;
                 AND ALLTRIM(NVL(cidchaves, "")) != loc_cChaveBO
                *-- A linha corrente nao eh a que o BO carregou.
                loc_lSucesso = .F.

            OTHERWISE
                REPLACE faixais   WITH loc_oBO.this_nFaixais,   ;
                        faixafs   WITH loc_oBO.this_nFaixafs,   ;
                        percs     WITH loc_oBO.this_nPercs,     ;
                        multiplos WITH loc_oBO.this_nMultiplos  ;
                    IN (loc_cAlias)

                THIS.RepintarGrade()

                loc_lSucesso = .T.
            ENDCASE
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao exibir a faixa de valores na grade:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Faixas de Valores")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *==========================================================================
    * HabilitarCampos - abre ou fecha a digitacao na grade
    *
    * O UNICO campo de entrada desta tela eh a grade, entao "habilitar campos"
    * aqui eh abrir/fechar a grade e as suas quatro colunas.
    *
    * NAO HA GATE POR MODO, e isso eh transcricao, nao esquecimento. O legado
    * condiciona ao PcEscolha apenas o cmdExcluir:
    *     .cmdExcluir.Visible = fChecaAcesso('SigOpCrr','EXCLUIR') And ;
    *                           InList( Thisform.PcEscolha, 'INSERIR','ALTERAR' )
    * A GRADE continua editavel em TODOS os modos - inclusive em PROCURAR, em
    * que digitar na ultima coluna faz o LostFocus chamar inserelinha, que liga
    * lHouveIns e portanto FAZ a tela gravar. Fechar a grade por modo
    * REMOVERIA uma capacidade que o legado tem (PILAR 1), entao o unico
    * criterio aqui eh o parametro.
    *
    * Grid.ReadOnly vem ANTES de Column.ReadOnly: o do grid PROPAGA para as
    * colunas e sobrescreveria o que fosse posto antes (regra #18/#46). As
    * QUATRO colunas sao reabertas, nao apenas as duas que InstalarCelulasFaixa
    * toca - Column1 e Column3 seguem com o Text1 nativo e, sem esta passagem,
    * ficariam com o ReadOnly que o grid acabou de propagar.
    *
    * Os botoes NAO entram no caminho de HABILITAR: quem decide o Excluir eh a
    * permissao resolvida pelo BO, e a fonte unica dela eh AjustarBotoesPorModo.
    * No caminho de FECHAR o Excluir acompanha a grade (nao faz sentido apagar
    * linha de uma grade congelada) e o Encerrar fica SEMPRE ativo - o form nao
    * tem barra de titulo e desabilita-lo prenderia o usuario.
    *
    * par_lHabilitar ausente eh tratado como .T.: o harness chama sem argumento.
    * O teste eh PCOUNT(), nunca VARTYPE - em VFP9 parametro NAO passado chega
    * como .F. LOGICO, entao VARTYPE(par_lHabilitar) devolve "L" tanto para
    * "nao passou" quanto para "passou .F.", e a chamada sem argumento acabaria
    * FECHANDO a grade. Medido nesta tela em 2026-10-30: com o VARTYPE,
    * HabilitarCampos() deixava Grid.ReadOnly = .T. e Enabled = .F.
    *
    * PUBLIC de verdade: HabilitarCampos NAO existe em FormBase, logo nao ha
    * escopo herdado a respeitar - ao contrario de FormParaBO/BOParaForm/
    * LimparCampos, que sao PROTECTED na base.
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar, loc_nI, loc_oGrade, loc_oErro

        loc_lHabilitar = .T.

        IF PCOUNT() >= 1 AND VARTYPE(par_lHabilitar) = "L"
            loc_lHabilitar = par_lHabilitar
        ENDIF

        IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN .F.
        ENDIF

        loc_oGrade = THIS.grd_4c_Dados

        TRY
            loc_oGrade.Enabled = loc_lHabilitar

            *-- Grid PRIMEIRO - ele propaga para as colunas
            loc_oGrade.ReadOnly = !loc_lHabilitar

            FOR loc_nI = 1 TO MIN(4, loc_oGrade.ColumnCount)
                loc_oGrade.Columns(loc_nI).ReadOnly = !loc_lHabilitar
            ENDFOR

            IF loc_lHabilitar
                *-- A permissao do Excluir tem fonte UNICA
                THIS.AjustarBotoesPorModo()
            ELSE
                IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
                    THIS.cmd_4c_Excluir.Enabled = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao ajustar a digita" + CHR(231) + CHR(227) + "o da grade:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Faixas de Valores")
        ENDTRY

        RETURN .T.
    ENDPROC


    *==========================================================================
    * LimparCampos - devolve a linha corrente ao estado "em branco"
    *
    * A linha em branco desta tela eh, por definicao do legado, a que tem
    * faixafs = 0: eh esse o criterio do "Locate for faixafs = 0" do
    * inserelinha e do LostFocus da Column4. Limpar a linha corrente eh,
    * portanto, zerar as quatro colunas visiveis - e eh exatamente o estado em
    * que InserirLinhaCursor cria uma linha nova.
    *
    * Composto a partir dos dois hooks, sem duplicar a lista de campos: o BO
    * zera as properties (LimparDados preserva this_cOperacao, entao dopes
    * continua resolvido) e BOParaForm leva isso para a linha e repinta. Como
    * LimparDados tambem esvazia this_cCidchaves, a guarda de identidade do
    * BOParaForm fica fora de alcance e a escrita atinge a linha CORRENTE, que
    * eh a intencao aqui.
    *
    * cidchaves e dopes da LINHA nao sao tocados - a linha continua sendo a
    * mesma, so vazia. Zerar a chave faria a linha perder identidade e o
    * Encerrar a trataria como lixo a descartar.
    *
    * Nenhum caminho do legado chama isto: o SCX nao tem botao de limpar. O
    * metodo existe como hook canonico de transferencia; NAO foi ligado a
    * botao algum, porque criar um botao de limpar seria inventar superficie
    * que a tela nao tem.
    *
    * PROTECTED EXPLICITO: FormBase declara PROTECTED PROCEDURE LimparCampos,
    * e o escopo herdado nao se alarga - ver o cabecalho do FormParaBO.
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        THIS.this_oBusinessObject.LimparDados()

        loc_lSucesso = THIS.BOParaForm()

        RETURN loc_lSucesso
    ENDPROC


    *==========================================================================
    * TornarControlesVisiveis - AddObject cria tudo com Visible = .F.
    *
    * Percorre Controls do form e dos containers. Esta tela NAO tem container
    * flutuante (painel que nasce oculto e eh alternado por botao), entao nao
    * ha lista de excecao a manter aqui.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis()
        LOCAL loc_nI, loc_nJ, loc_oControle, loc_oFilho

        FOR loc_nI = 1 TO THIS.ControlCount
            loc_oControle = THIS.Controls(loc_nI)

            IF VARTYPE(loc_oControle) = "O"
                IF PEMSTATUS(loc_oControle, "Visible", 5)
                    loc_oControle.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oControle, "ControlCount", 5)
                    FOR loc_nJ = 1 TO loc_oControle.ControlCount
                        loc_oFilho = loc_oControle.Controls(loc_nJ)
                        IF VARTYPE(loc_oFilho) = "O" AND PEMSTATUS(loc_oFilho, "Visible", 5)
                            loc_oFilho.Visible = .T.
                        ENDIF
                    ENDFOR
                ENDIF
            ENDIF
        ENDFOR

        RETURN .T.
    ENDPROC


    *==========================================================================
    * AtualizarEstadoControles - hook chamado por FormBase.Init() no final
    *
    * Este dialogo nao tem os cinco botoes CRUD de um cadastro: o dump tem
    * apenas cmdExcluir e cmdSair. O override existe para o hook da base nao
    * cair no comportamento de cadastro, e redireciona para o unico ajuste que
    * esta tela tem - a permissao de exclusao resolvida pelo BO.
    *
    * Roda DEPOIS de InicializarForm, que ja chamou AjustarBotoesPorModo. A
    * repeticao eh deliberada e inofensiva (o metodo so espelha
    * this_lPodeExcluir): garante o ajuste mesmo que algum caminho futuro
    * chegue aqui sem ter passado por ele.
    *==========================================================================
    PROCEDURE AtualizarEstadoControles()
        LOCAL loc_lSucesso

        loc_lSucesso = THIS.AjustarBotoesPorModo()

        *-- A grade eh o unico campo de entrada desta tela, e TornarControlesVisiveis
        *-- acabou de forcar Visible = .T. em tudo: reabrir a digitacao aqui
        *-- garante Grid.ReadOnly = .F. e as quatro colunas abertas mesmo que
        *-- algum caminho futuro chegue a este hook sem passar por VincularGrade.
        THIS.HabilitarCampos(.T.)

        RETURN loc_lSucesso
    ENDPROC


    *==========================================================================
    * Destroy - libera o pai e o BO
    *
    * A reabilitacao do pai vem ANTES de soltar o BO: se algo falhasse ali, o
    * usuario ainda ficaria com o cadastro de Operacoes utilizavel.
    * DODEFAULT() eh a ULTIMA linha - FormBase.Destroy reconstroi os popups do
    * menu principal, e omiti-lo faz o menu encolher visualmente.
    *==========================================================================
    PROCEDURE Destroy()
        THIS.ReabilitarFormPai()

        THIS.this_oFormPai = .NULL.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


*==============================================================================
* TextBoxFaixaSigOpCrd_4c - celulas COM EVENTO da grade de faixas
*
* Transcreve os dois unicos handlers de celula do SIGOPCRD legado:
*     SIGOPCRD.GradeSubN.Column2.Text1.LostFocus  -> faixafs
*     SIGOPCRD.GradeSubN.Column4.Text1.LostFocus  -> multiplos
*
* O evento fica EMBUTIDO na classe, e nao ligado por BINDEVENT: BINDEVENT em
* evento de TextBox dentro de Column nao dispara de forma confiavel no VFP9 -
* eh exatamente o motivo de existir classes\TextBoxGridLookup.prg, que
* documenta isso no cabecalho, e eh o padrao canonico do projeto (regra #46,
* referencia FormLpr.TextBoxProdutoLpr_4c).
*
* A classe NAO decide nada: ela so despacha para o metodo PUBLIC do form, que
* eh onde a regra do legado esta transcrita. Assim a logica fica em UM lugar,
* alcancavel pelo harness, e esta classe segue valendo para as duas colunas
* com a unica diferenca sendo this_cCampo.
*
* THISFORM aqui eh o FormSigOpCrd: a celula eh filha de Column, que eh filha
* de Grid, que eh filho do form. O PEMSTATUS antes de cada chamada protege o
* caso de a classe ser reaproveitada num form que nao tenha o metodo - ali o
* handler vira no-op em vez de estourar "Property ... is not found".
*
* LostFocus NAO recebe parametro (ao contrario de KeyPress, regra #3), por
* isso a assinatura eh vazia. E o form passa THIS adiante porque dentro do
* evento da celula o valor digitado esta em .Value e ainda NAO chegou ao
* cursor - quem valida tem de ler o CONTROLE (regra #46).
*==============================================================================
DEFINE CLASS TextBoxFaixaSigOpCrd_4c AS TextBox
    *-- Coluna do cursor que esta celula edita: "faixafs" ou "multiplos".
    *-- Definido por InstalarCelulasFaixa, no form.
    this_cCampo = "faixafs"

    PROCEDURE LostFocus()
        DO CASE
            CASE LOWER(ALLTRIM(THIS.this_cCampo)) == "faixafs"
                IF PEMSTATUS(THISFORM, "ValidarFaixaFinal", 5)
                    THISFORM.ValidarFaixaFinal(THIS)
                ENDIF

            CASE LOWER(ALLTRIM(THIS.this_cCampo)) == "multiplos"
                IF PEMSTATUS(THISFORM, "ValidarMultiplos", 5)
                    THISFORM.ValidarMultiplos(THIS)
                ENDIF
        ENDCASE
    ENDPROC
ENDDEFINE
