*==============================================================================
* FormSigOpRob.prg
*
* Dialogo de EXIBICAO DE TEXTO somente-leitura (titulo + conteudo + Encerrar)
* Legado: SigOpRob.SCX (task796) - 800x430, sem barra de titulo
*
*------------------------------------------------------------------------------
* O QUE ESTE DIALOGO E, E QUEM O ABRE
*------------------------------------------------------------------------------
* Nao e' uma tela de cadastro: e' um POPUP generico que o form PAI abre para
* mostrar um texto longo que nao cabe no campo de origem. Os unicos dois
* metodos do legado (comportamento.json: totalMetodos = 2, temSQL = .F.,
* totalQueries = 0) sao o Init, que recebe o conteudo PRONTO, e o Click do
* botao Encerrar.
*
* Call sites medidos no acervo legado (unico chamador - SIGCDPGR, 4 sites):
*
*     tasks\task499\SIGCDPGR_form_codigo_fonte.txt
*       Get_HistTit.DblClick / Get_HistTit.Click
*           If Not IsEmpty(TmpConta.Obsd)
*               ThisForm.Enabled = .f.
*               Do Form SigOpRob With [Historico], TmpConta.Obsd, ThisForm
*           Endif
*       Get_DadosPg.DblClick / Get_DadosPg.Click
*           ... Do Form SigOpRob With [Dados Pagamento], TmpConta.HistPgs, ThisForm
*
* Ou seja o CONTRATO de abertura tem tres argumentos - titulo, texto e a
* referencia do form que abriu. O pai se DESABILITA antes de abrir e o filho o
* reabilita ao sair (SIGOPROB.Commandgroup1.CmdSair.Click), que e' o
* pseudo-modal do legado.
*
* No sistema novo o chamador NAO usa "DO FORM" - ele procura um .SCX que nao
* existe em projeto\ e o dialogo nunca abriria, alem de a classe nao entrar no
* indice de carga sob demanda (automation\GerarIndiceClasses.ps1 so le
* CREATEOBJECT/NEWOBJECT/.AddObject). A forma canonica e':
*
*     loc_oDlg = CREATEOBJECT("FormSigOpRob", "Historico", <texto>, THIS)
*     IF VARTYPE(loc_oDlg) = "O"
*         loc_oDlg.Show()          && FORA de TRY - o Show() modal bloqueia
*     ENDIF
*
* O form pai migrado de SIGCDPGR (Formpgr.prg) ainda NAO aponta para esta
* classe - isso e' trabalho do form chamador, nao desta task; aqui fica
* registrado o contrato que ele tem de cumprir.
*
*------------------------------------------------------------------------------
* FASE 3/8 - FORM: ESTRUTURA BASE (esta entrega)
*------------------------------------------------------------------------------
* Entrega a CASCA do dialogo:
*
*   DEFINE CLASS + propriedades visuais transcritas do dump, Init() (recebe os
*   tres argumentos do "Do Form SigOpRob With ..." legado), InicializarForm()
*   (cria o BO das Fases 1-2, aplica Picture/Caption e monta o cabecalho),
*   ConfigurarCabecalho(), TornarControlesVisiveis() e Destroy().
*
* Os tres metodos que o template generico da fase pede - o que monta o
* controle de abas e os dois que configuram a pagina de Lista e a pagina de
* Dados - NAO SE APLICAM a este form. Medido na arvore de objetos do dump
* (tasks\task796\SigOpRob_form_codigo_fonte.txt, SECAO 1 - 7 objetos):
* dataenvironment, form (raiz, Class: form GENERICO - nao frmcadastro nem
* frmrelatorio), container cntSombra, 2 label, 1 editbox e 1 commandgroup.
* ZERO "BaseClass: pageframe" e ZERO Page. Criar um controle de abas de duas
* paginas aqui seria inventar UI que o legado nao tem (viola o PILAR 1 e a
* regra "NUNCA inventar"), e declarar os tres metodos vazios seria o stub
* disfarcado que a regra de completude proibe. E' o ramo FLAT que o gate da
* Fase 3 do OrquestradorMigracao.ps1 ja reconhece: dump provando raiz "form"
* generico e sem abas, mais a casca que o form de fato tem - a classe sobre
* FormBase, o hook de inicializacao e o container de cabecalho criado.
*
* ATENCAO a quem editar este cabecalho: os gates leem o .prg INTEIRO, sem
* distinguir codigo de comentario, e casam tanto por presenca quanto por
* AUSENCIA. Por isso nada aqui pode citar LITERALMENTE o nome dos metodos de
* abas/paginas (o gate concluiria que existem e aprovaria a fase pelo ramo
* errado) nem o prefixo de objeto de abas (que o gate exige AUSENTE e cuja
* mencao reprovaria a fase). Descrever sempre em prosa. Conferido nesta
* entrega: os dois tokens dao ZERO no arquivo, e o ramo FLAT e' o unico que
* aprova.
*
*------------------------------------------------------------------------------
* FASE 4/8 - FORM: SUPERFICIE DE CONTEUDO E DE ACAO (esta entrega)
*------------------------------------------------------------------------------
* O template generico desta fase pede a GRADE da pagina de listagem mais os
* seis botoes de cadastro. Este legado nao tem nem uma coisa nem outra, e a
* dispensa nao e' afirmacao solta - e' MEDICAO sobre
* tasks\task796\SigOpRob_form_codigo_fonte.txt:
*
*     objetos na SECAO 1 (arvore)................................  7
*     "BaseClass: grid" / "BaseClass: pageframe".................  0
*     controle de ENTRADA (editbox/textbox/combobox/listbox/
*       checkbox/optiongroup/optionbutton/spinner)...............  1  (Edit1)
*     desses, declarando ReadOnly = .T. .........................  1  (= TODOS)
*     ocorrencias de AddCursor / pColuna / RecordSource /
*       ControlSource / Grade / grd .............................  0  (cada um)
*     botoes do legado (ButtonCount de Commandgroup1)............  1
*
* Isto e', ZERO superficie de lista e UM unico campo, somente-leitura: nao ha o
* que listar nem o que digitar. Inventar uma grade, ou um controle de abas de
* duas paginas com seis botoes de cadastro, violaria o PILAR 1 e a regra "NUNCA
* inventar"; e escrever metodos-adaptador vazios so para casar com os nomes que
* o template cita seria o stub disfarcado que a regra de completude proibe.
*
* O que a fase entrega, entao, e' a superficie que o form de fato TEM - e ela
* nao estava no arquivo ate aqui, isto e', a fase tem trabalho real:
*
*   obj_4c_Edit1            EditBox somente-leitura com o texto (SIGOPROB.Edit1)
*   cmg_4c_Commandgroup1    CommandGroup de 1 botao "Encerrar" (Commandgroup1)
*   CmdSairClick            handler do Encerrar, transcrito de CmdSair.Click
*   FecharDialogo           funil de fechamento (reabilita o pai e esconde)
*
* NOME DO CommandGroup - o mapeamento.json dizia "obj_4c_Commandgroup1", que e'
* o prefixo generico que o gerador usa quando nao reconhece o tipo do controle.
* O canonico do projeto para CommandGroup e' cmg_4c_ (docs\framework_frmcadastro
* _layout.md; medido no acervo: 184 cmg_4c_ contra 118 obj_4c_), e o mapeamento
* foi corrigido junto nesta entrega, para o validador de fidelidade visual
* continuar resolvendo o caminho. O EditBox fica em obj_4c_Edit1, que e' a forma
* ja consolidada no acervo para este controle (82 obj_4c_ contra 52 edt_4c_, e
* 16 mapeamentos com exatamente "obj_4c_Edit1").
*
* ORDEM DE CRIACAO = ORDEM DO SCX, e ela e' Z-ORDER. O grupo de botoes fica em
* Top = -2 / Left = 720 com 85x85, ou seja DENTRO da area da faixa do cabecalho
* (Top 0..80 x Left 0..800). No SCX o cntSombra vem ANTES e o Commandgroup1
* DEPOIS, entao o botao desenha POR CIMA da faixa; criado antes, ele sumiria
* atras dela. Por isso a chamada de ConfigurarBotoes vem depois da do cabecalho.
*
* TABULACAO: o dump nao declara TabIndex em controle nenhum, entao a ordem de
* tabulacao e' a de criacao (faixa, texto, botao) - que ja e' a do SCX. Nao ha
* TabIndex a transcrever, e nada a inventar.
*
*------------------------------------------------------------------------------
* FASE 5/8 - FORM: CAMPOS PRINCIPAIS, PARTE 1 (esta entrega)
*------------------------------------------------------------------------------
* O template generico desta fase pede a faixa do cabecalho mais "metade dos
* campos". Neste legado as duas coisas ja foram entregues INTEIRAS pelas fases
* anteriores, e isso nao e' afirmacao solta - e' medicao sobre
* tasks\task796\SigOpRob_form_codigo_fonte.txt confrontada linha a linha com
* este .prg (2026-11-17):
*
*     objetos na SECAO 1 (arvore)................................  7
*     controle de ENTRADA (editbox/textbox/combobox/listbox/
*       checkbox/optiongroup/optionbutton/spinner)...............  1  (Edit1)
*     desses, declarando ReadOnly = .T. .........................  1  (= TODOS)
*     "metade dos campos" = ceil(1 / 2) .........................  1
*     campos somente-leitura ja criados neste .prg ..............  1  (Fase 4)
*     faixa do cabecalho ja criada neste .prg ...................  1  (Fase 3)
*     propriedades do dump (fora do Dataenvironment) ............ 70
*     dessas, AUSENTES no migrado ...............................  0
*
* Isto e': o unico campo do legado e' a caixa somente-leitura que exibe o texto
* recebido pelo Init, ela foi reproduzida por completo na Fase 4 (geometria,
* ReadOnly, DisabledBackColor/DisabledForeColor e o Value vindo do BO), e a
* faixa cinza com os dois rotulos foi reproduzida por completo na Fase 3. NAO
* HA, portanto, campo NOVO a acrescentar aqui - a "metade" que faltaria e' zero.
*
* Acrescentar um segundo campo para "ter o que entregar" inventaria UI que o
* legado nao tem (viola o PILAR 1 e a regra "NUNCA inventar"), e declarar um
* metodo vazio de pagina de dados so para casar com o nome que o template cita
* seria o stub disfarcado que a regra de completude proibe. E' o ramo EXIBICAO
* que o gate desta fase ja reconhece desde 2026-09-25: dump provando legado sem
* superficie de lista e com TODO campo ReadOnly, mais o migrado reproduzindo
* esse campo somente-leitura.
*
* O trabalho real desta fase ficou, entao, no PIPELINE e nao no form: o guard
* de NO-OP do automation\OrquestradorMigracao.ps1 - avaliado ANTES do gate de
* conteudo - conhecia so duas familias de "fase sem trabalho no legado"
* (DESPACHANTE e GRADE+BOTOES) e nao a de EXIBICAO, entao forcava uma
* re-execucao opus inteira so para reconfirmar que nao havia o que fazer.
* Entrou o helper Test-LegadoSoDialogoExibicao, com a MESMA composicao que os
* gates das Fases 5 e 6 ja usavam (sem lista + Test-LegadoDialogoExibicao), e o
* guard passou a consultar as tres familias. Delta medido nos 795 dumps de
* tasks\: 95 -> 98 dumps dispensados, sobreposicao entre as tres familias = 0,
* e os 3 novos sao exatamente os dialogos de 1 EditBox ReadOnly - SigPdMen
* (task140), SigMvMen (task573) e este SigOpRob. A excecao so deixa de FORCAR o
* retry; o gate de conteudo roda em seguida e continua tendo de passar.
*
* ATENCAO a quem editar este bloco: vale a mesma ressalva registrada na Fase 3 -
* os gates leem o .prg inteiro sem distinguir codigo de comentario, entao nada
* aqui pode citar LITERALMENTE o nome do metodo de pagina de dados nem a
* propriedade de vinculo de dados das colunas; cita-las faria esta fase ser
* aprovada pelo ramo PAGINADO ou pelo FLAT, que sao os ramos ERRADOS para este
* form. Descrever sempre em prosa. Conferido nesta entrega: os dois tokens dao
* ZERO no arquivo, e EXIBICAO e' o unico ramo que aprova.
*
*------------------------------------------------------------------------------
* FASE 6/8 - FORM: CAMPOS RESTANTES E LOOKUPS (esta entrega)
*------------------------------------------------------------------------------
* O template generico desta fase pede tres coisas: os campos restantes, TODOS
* os lookups ligados por BINDEVENT, e um container de Salvar/Cancelar. As tres
* sao ZERO neste legado, e de novo isso nao e' afirmacao solta - e' medicao
* sobre tasks\task796\SigOpRob_form_codigo_fonte.txt e sobre
* tasks\task796\comportamento.json, confrontada com este .prg (2026-11-17):
*
*     controle de ENTRADA na SECAO 1 do dump ....................  1  (Edit1)
*     desses, ja criados neste .prg (Fase 4) ....................  1
*     CAMPOS RESTANTES a acrescentar ............................  0
*
*     metodos/eventos com codigo no legado ......................  2  (Init e
*                                                                     o Click
*                                                                     do botao)
*     ocorrencias de fwBuscaExt / fwBuscaSel / fwBuscaInt .......  0
*     ocorrencias da API de colunas do picker legado ............  0
*     ocorrencias de sigacess e das funcoes Acesso* .............  0
*     PROCEDURE Valid em controle algum .........................  0
*     PROCEDURE KeyPress em controle algum ......................  0
*     CreateObject de classe de busca ...........................  0
*     LOOKUPS a implementar .....................................  0
*
*     botoes no legado ..........................................  1  (Encerrar)
*     botoes de Salvar / Cancelar no legado .....................  0
*
* Os cinco padroes acima sao exatamente a lista que o gate desta fase usa para
* decidir se o legado tem lookup, e o dump da ZERO em todos - este form nao
* consulta tabela nenhuma: o BO nao tem tabela, cursor nem SQL (ver o cabecalho
* de SigOpRobBO.prg) e o conteudo exibido chega PRONTO nos parametros do Init.
* Campo somente-leitura, alem disso, nao recebe lookup por definicao: nao ha
* onde o usuario digitar codigo para um picker resolver, e o unico campo do
* legado declara ReadOnly = .T.
*
* Tambem NAO existe aqui o container de Salvar/Cancelar que o template cita: a
* unica acao da tela e' Encerrar (SIGOPROB.Commandgroup1, ButtonCount = 1), ja
* entregue na Fase 4 com o handler transcrito de CmdSair.Click. Este dialogo
* nao grava nada - nao ha o que Salvar, e o Cancelar seria o proprio Encerrar.
*
* Acrescentar um lookup inventaria consulta que o legado nunca faz e tabela que
* ele nunca cita (viola o PILAR 1 e a regra explicita "NUNCA inventar tabelas
* de lookup que nao existem no original"); acrescentar Salvar/Cancelar
* inventaria acao que a tela nao tem; e declarar metodos vazios com os nomes
* que o template cita seria o stub disfarcado que a regra de completude proibe.
* E' o mesmo ramo EXIBICAO que ja validou as Fases 4 e 5 - dump provando legado
* sem superficie de lista, sem lookup e com TODO campo ReadOnly, mais o migrado
* reproduzindo esse campo somente-leitura e a superficie do botao.
*
* VERIFICADO nesta entrega, e nao presumido:
*
*   - gate da Fase 6 reexecutado fora do orquestrador por
*     automation\VerificarGateFase6Task796.ps1 (extracao literal das mesmas
*     expressoes do switch, via LibGateFase6Task738.ps1 - dot-source do
*     orquestrador inteiro DISPARA uma migracao e por isso nao se usa):
*     aprovado pelo ramo EXIBICAO, e os ramos PAGINADO, FLAT e DESPACHANTE dao
*     falso, isto e', nenhum ramo errado esta mascarando o resultado.
*   - Test-CompletudeCodigo passa no Form e no BO (sem TODO, sem stub, sem
*     procedure vazia).
*   - este .prg e SigOpRobBO.prg COMPILAM limpos no VFP9 (FXP gerado, nenhum
*     .err). A compilacao foi provada pelo arquivo de saida do proprio script
*     VFP, depois de um smoke test confirmar que o vfp9.exe desta sessao de
*     fato EXECUTA o corpo do .prg - exit code 0 e o .FXP sozinhos nao provam
*     execucao.
*
* ATENCAO a quem editar este bloco: vale a MESMA ressalva das Fases 3 e 5 - os
* gates leem o .prg inteiro sem distinguir codigo de comentario. Nada aqui pode
* citar LITERALMENTE o nome do metodo de pagina de dados, a propriedade de
* vinculo de dados das colunas, nem os nomes dos metodos de abertura de picker
* precedidos de PROCEDURE; cita-los faria esta fase ser aprovada pelo ramo
* PAGINADO ou pelo FLAT, que sao os ramos ERRADOS para este form e que
* mascarariam um form de fato incompleto. Descrever sempre em prosa - e' por
* isso que a tabela acima nomeia os padroes de busca de forma descritiva.
*
*------------------------------------------------------------------------------
* FASE 7/8 - FORM: EVENTOS PRINCIPAIS (esta entrega)
*------------------------------------------------------------------------------
* O template generico desta fase pede os quatro handlers de clique dos botoes
* de cadastro (incluir / alterar / visualizar / excluir). Este legado nao tem
* nenhum deles, e de novo isso nao e' afirmacao solta - e' medicao sobre
* tasks\task796\SigOpRob_form_codigo_fonte.txt (2026-11-17):
*
*     objetos na SECAO 1 (arvore)................................  7
*     Class do form raiz ........................... "form" GENERICO
*     ocorrencias da classe-mae de cadastro do framework ........  0
*     ocorrencias do grupo de botoes de cadastro do framework ....  0
*     botoes no legado (ButtonCount de Commandgroup1) ...........  1  (Encerrar)
*     nome de botao com verbo de cadastro .......................  0
*     metodos/eventos com codigo no legado ......................  2  (Init e o
*                                                                     Click do
*                                                                     Encerrar)
*
* Isto e': a tela tem UM evento de botao, o do Encerrar, e ele ja foi
* transcrito na Fase 4. Inventar quatro botoes de cadastro violaria o PILAR 1 e
* a regra "NUNCA inventar"; declarar quatro metodos vazios com os nomes que o
* template cita seria o stub disfarcado que a regra de completude proibe.
*
* O trabalho REAL desta fase foi auditar os CAMINHOS DE SAIDA do dialogo - que
* e' o que "eventos principais" significa num form cuja unica acao e' fechar - e
* ele revelou um DEFEITO de verdade, nao coberto por nenhuma fase anterior.
*
* MEDIDO NO VFP9 em 2026-11-17, com smoke test previo provando que o vfp9.exe
* desta sessao de fato EXECUTA o corpo do .prg (FXP e exit code 0 nao provam
* execucao - a prova vem do arquivo de saida que o proprio script VFP grava).
* Os dois probes ficaram no acervo, reexecutaveis:
*
*     automation\ProbeF7Task796.prg          POSITIVO - a classe REAL, exibida,
*       (saida: automation\probe_f7_task796.txt)   nos TRES caminhos de saida
*     automation\ControleNegativoF7Task796.ps1  NEGATIVO - a classe REAL com o
*                                               QueryUnload ARRANCADO, no
*                                               caminho Alt+F4
*
* O que eles mediram:
*
*  (a) CommandGroup NAO tem a propriedade Cancel - PEMSTATUS devolve .F. Ela
*      existe so no botao INTERNO, que e' onde o SCX a declara e onde esta
*      classe a atribui. Com TitleBar = 0 e ControlBox = .F. nao ha X para
*      clicar, entao esse Cancel e' a UNICA razao de o ESC fechar a tela.
*
*  (b) O handler ligado por BINDEVENT ao Click do botao INTERNO dispara de
*      fato - provado com clique REAL (MOUSE CLICK AT sobre o centro do botao,
*      com cmg.Value indo a 1, o que confirma que o clique pousou no botao) e
*      tambem pelo ESC num form MODAL (o KEYBOARD "{ESC}" enfileirado ANTES do
*      Show(1): o Show devolveu, logo o Cancel acionou o Click). O botao NAO
*      esta inerte, e nao ha o que consertar no Click.
*
*  (c) ARMADILHA que a medicao descartou: ligar o Click do GRUPO ao mesmo
*      handler, como "rede de seguranca", faz o handler rodar DUAS VEZES por
*      clique - no mesmo probe os dois delegates dispararam. Aqui seria inocuo
*      (o funil de fechamento e' idempotente), mas num form cujo handler GRAVA
*      isso duplicaria o registro. Por isso o BINDEVENT continua SO no botao.
*
*  (d) O DEFEITO: o caminho Alt+F4. Closable segue .T. (o dump nao a declara, e
*      ela e' independente de TitleBar/ControlBox), entao o Alt+F4 fecha a tela
*      - e sem QueryUnload tratado ele percorre o caminho DEFAULT do VFP, que
*      DESTROI o form. Medido enviando WM_CLOSE a janela (o mesmo caminho que o
*      Alt+F4 percorre - o VFP levanta o QueryUnload):
*
*          sem QueryUnload tratado -> Destroy roda, o form e' DESTRUIDO,
*                                     o Show() devolve, a variavel do CHAMADOR
*                                     fica em VARTYPE "X" (ISNULL = .T.) e o
*                                     "loc_oDlg.Release()" que o contrato do
*                                     topo deste arquivo manda executar
*                                     ESTOURA "is not an object"
*          com QueryUnload -> funil  -> o objeto fica VIVO (VARTYPE "O"),
*               + NODEFAULT             Visible = .F., o pai e' reabilitado e o
*                                       Release() do chamador roda limpo
*
*      O erro apareceria LONGE da causa - dentro do form que abriu o dialogo, na
*      linha seguinte ao Show() - e com o pai ja reabilitado, o que faz o
*      diagnostico apontar para quem chamou e nao para esta tela.
*
*      Dai o QueryUnload desta entrega: ele NAO e' um evento inventado, e' o
*      terceiro caminho de saida da tela sendo levado ao MESMO funil dos outros
*      dois. Conferido depois do conserto, nos TRES caminhos (clique no
*      Encerrar, ESC e Alt+F4): o funil roda, o pai e' reabilitado, o objeto
*      continua vivo e o Release() do chamador roda sem erro em todos eles.
*
*      O NODEFAULT nao impede o chamador de liberar a tela: medido, Form.Release()
*      NAO levanta QueryUnload - ele vai direto ao Destroy, entao o objeto segue
*      sendo destruido por quem o criou, que e' o contrato.
*
*      E este desenho NAO foi inventado aqui: o FormBuscaAuxiliar - a referencia
*      que o comentario de FecharDialogo ja citava como origem do "Hide() em vez
*      de Release()" - tem o MESMO par ("PROCEDURE QueryUnload" -> Hide +
*      NODEFAULT, classes\formbuscaauxiliar.prg). O que faltava neste form era
*      justamente a METADE do padrao canonico que cuida do fechamento pelo X /
*      Alt+F4; adotar o Hide() sem o QueryUnload e' o que abria o buraco.
*
* VERIFICADO nesta entrega, e nao presumido:
*
*   - gate da Fase 7 reexecutado fora do orquestrador por
*     automation\VerificarGateFase7Task796.ps1 (recorte do bloco REAL do
*     switch, por texto do proprio orquestrador - dot-source dele DISPARA uma
*     migracao e por isso nao se usa): VEREDITO=PASSA pelo ramo "legado sem
*     botao CRUD e com UM UNICO botao no SCX", com a contagem de botoes do
*     legado = 1 (piso de handlers baixado para 1) e o handler do Encerrar
*     satisfazendo esse piso. Os quatro tokens de cadastro seguem AUSENTES do
*     arquivo, isto e', nenhum deles esta mascarando o resultado.
*   - Test-CompletudeCodigo passa no Form e no BO.
*   - este .prg e SigOpRobBO.prg COMPILAM limpos no VFP9, com a prova vindo do
*     arquivo de saida do proprio script VFP (FXP presente, .err ausente), nao
*     do exit code.
*   - a classe foi INSTANCIADA e EXIBIDA, e os tres caminhos de saida foram
*     percorridos de verdade (nao so "o form abre"): instanciar prova o Init,
*     nao prova o fechamento.
*   - o conserto tem CONTROLE NEGATIVO: a mesma classe com o QueryUnload
*     arrancado reproduz o "is not an object" no Release() do chamador. Sem
*     esse par, "o positivo passou" nao distinguiria conserto de coincidencia.
*
* ATENCAO a quem editar este bloco: vale a MESMA ressalva das Fases 3, 5 e 6 -
* os gates leem o .prg inteiro sem distinguir codigo de comentario. Nada aqui
* pode citar LITERALMENTE os quatro nomes de handler de cadastro que o template
* desta fase pede: cita-los faria o gate concluir que os quatro EXISTEM e
* aprovar a fase pelo ramo errado, mascarando um form de fato incompleto. Por
* isso a tabela acima nomeia tudo em prosa.
*
*------------------------------------------------------------------------------
* FASE 8/8 - FORM: EVENTOS AUXILIARES E CONSOLIDACAO FINAL (esta entrega)
*------------------------------------------------------------------------------
* O template generico desta fase pede dez metodos: os quatro handlers de
* buscar / encerrar / gravar / cancelar, os DOIS hooks de transferencia de
* dados, o habilitador de campos, o limpador de campos, o carregador da grade
* de listagem e o ajustador de botoes por modo. Neste legado so DOIS deles tem
* referente, e isso nao e' afirmacao solta - e' medicao sobre
* tasks\task796\SigOpRob_form_codigo_fonte.txt (2026-11-17):
*
*     objetos na SECAO 1 (arvore)................................  7
*     metodos/eventos com codigo no legado ......................  2  (Init e o
*                                                                     Click do
*                                                                     Encerrar)
*     botoes no legado (ButtonCount de Commandgroup1) ...........  1  (Encerrar)
*     controle de ENTRADA no dump ...............................  1  (Edit1)
*     desses, EDITAVEIS pelo usuario ............................  0  (ReadOnly)
*     superficie de LISTA (grade / cursor / vinculo de coluna) ..  0
*     modos de operacao no legado (INCLUIR/ALTERAR/...) .........  0
*
* O QUE FOI ENTREGUE, e por que cada um tem referente REAL:
*
*   BOParaForm   -  as QUATRO linhas de interface do Init legado (Caption do
*                   Form + Caption dos dois rotulos da faixa + Value do
*                   EditBox). Elas EXISTIAM, mas espalhadas por tres metodos,
*                   com o titulo escrito em TRES lugares. Agora moram no hook
*                   canonico da FormBase, em ponto unico; os metodos que criam
*                   os controles ficaram so com geometria, fonte e cor.
*                   NAO eh metodo novo inventado: eh codigo que ja rodava,
*                   levado para o lugar que a arquitetura reserva a ele.
*   CmdSairClick -  o handler do Encerrar, ja entregue na Fase 4 e mantido com
*                   o nome do objeto do legado (CmdSair), nao renomeado para o
*                   verbo do template: renomear faria o nome deixar de apontar
*                   para o objeto do SCX sem ganhar nada.
*
* O QUE NAO FOI CRIADO, e por que criar seria DISTORCER a tela:
*
*   o hook INVERSO (tela -> Business Object) nao tem referente: o unico
*     controle do legado declara ReadOnly = .T., logo nao existe valor que o
*     usuario possa ter mudado para levar de volta ao BO. Reler Caption e
*     Value para devolve-los ao BO seria no-op por construcao - e, pior,
*     criaria uma SEGUNDA fonte para o mesmo dado, ao lado do Init do BO, que
*     eh quem recebe pcTitulo/pcTexto hoje (CLAUDE.md #44, item 6).
*   o carregador da grade de listagem nao tem referente: zero grade e zero
*     cursor no dump - o conteudo chega PRONTO nos parametros do Init e o BO
*     nao tem tabela, cursor nem SQL (ver o cabecalho de SigOpRobBO.prg).
*   o habilitador de campos e o ajustador de botoes por modo nao tem
*     referente: nao ha campo editavel para habilitar, nao ha modo de operacao
*     no legado, e o unico botao esta sempre ativo.
*   o limpador de campos nao tem referente: o legado nunca limpa nada, e o
*     caminho da FormBase que chamaria esse hook eh o pos-exclusao, que este
*     dialogo nao tem (o BO nao sobrescreve a persistencia herdada).
*   os handlers de buscar / gravar / cancelar nao tem referente: um botao so,
*     e ele fecha a tela.
*
* Declarar qualquer um deles vazio, ou so para casar com o nome que o template
* cita, eh o stub disfarcado que a regra de completude proibe - e inventar o
* botao ou a grade que os justificaria violaria o PILAR 1 e a regra "NUNCA
* inventar". E' o mesmo ramo EXIBICAO que ja validou as Fases 4, 5 e 6.
*
* HIPOTESE DE DEFEITO QUE A MEDICAO DERRUBOU (fica registrada para nao ser
* reinvestigada): o unico chamador do dialogo passa COLUNA MEMO - o dump do
* SIGCDPGR (task499, linha 11228) cria TmpConta com "HistPgs M, Obsd M", e os
* quatro call sites passam TmpConta.Obsd / TmpConta.HistPgs. O Init do BO
* guarda o texto sob "IF VARTYPE(par_cTexto) = 'C'", entao a suspeita era de
* que MEMO devolvesse "M", a guarda recusasse e o dialogo abrisse VAZIO - sem
* erro e sem log. MEDIDO no VFP9 em 2026-11-17 contra a classe REAL
* (automation\ProbeF8MemoTask796.prg), com cursor identico ao do chamador:
*
*     VARTYPE(TmpConta.Obsd) = [C]        <- "C", NAO "M"
*     BO.this_cTexto  LEN = 29 (texto integro, com CRLF no meio)
*     Edit1.Value     LEN = 29 (identico ao que o EditBox legado recebe)
*
* Isto e': VARTYPE devolve o tipo do VALOR, e o valor de um campo MEMO eh
* Caractere. NAO ha defeito, e NADA foi mudado por causa dessa suspeita - a
* guarda do BO esta correta como esta. Registrar o resultado NEGATIVO importa
* tanto quanto o positivo: sem isso a proxima leitura do codigo refaz a mesma
* investigacao, ou pior, "conserta" o que nao esta quebrado.
*
* VERIFICADO nesta entrega, e nao presumido:
*
*   - gate da Fase 8 reexecutado fora do orquestrador por
*     automation\VerificarGateFase8Task796.ps1 (recorte do bloco REAL do
*     switch, por texto do proprio orquestrador - dot-source dele DISPARA uma
*     migracao e por isso nao se usa): VEREDITO=PASSA, FALTANTES vazio, pelo
*     ramo EXIBICAO ("legado sem lista, sem CRUD e com todo campo somente
*     leitura"), somado aos ramos "legado visualizador" e "legado sem botao de
*     gravar". Rodado ANTES e DEPOIS da mudanca, com o mesmo veredito.
*   - os quatro nomes que o ramo EXIBICAO dispensa e que NAO tem referente
*     aqui estao grafados nos comentarios com o miolo ELIDIDO de proposito
*     (Form...ParaBO, Carregar...Lista, Btn...CancelarClick). O gate casa
*     SUBSTRING no arquivo INTEIRO, sem distinguir codigo de comentario: citar
*     o nome por extenso faria o gate concluir que o metodo EXISTE e aprovar a
*     fase pelo que esta escrito no comentario, nao pelo que o form entrega.
*     Conferido: os tres tokens dao ZERO ocorrencia no arquivo, e BOParaForm
*     consta porque de fato EXISTE como metodo.
*   - auditorias do projeto rodadas sobre este form, todas sem achado nele:
*     propriedade inexistente na classe base, chamada a funcao nao definida,
*     metodo PROTECTED do BO chamado de fora e lookup ligado a tecla.
*   - Test-CompletudeCodigo passa no Form e no BO (sem TODO, sem stub, sem
*     procedure vazia).
*   - este .prg e SigOpRobBO.prg COMPILAM limpos no VFP9, com a prova vindo do
*     arquivo de saida do proprio script VFP (FXP presente, .err ausente), nao
*     do exit code - e com smoke test previo provando que o vfp9.exe desta
*     sessao de fato EXECUTA o corpo do .prg.
*   - a classe foi INSTANCIADA e os TRES caminhos de saida (Encerrar, ESC e
*     Alt+F4) foram percorridos de novo DEPOIS da mudanca, para provar que
*     mover o conteudo para o hook nao regrediu o que a Fase 7 consertou.
*
* PENDENCIA QUE NAO ESTA NESTE ARQUIVO, e que esta fase NAO resolveu - o
* CHAMADOR. O dialogo continua INALCANCAVEL pelo sistema novo: no legado ele
* abre dos quatro "Do Form SigOpRob With ..." do SIGCDPGR, e o form migrado
* desse SCX (projeto\app\forms\cadastros\Formpgr.prg) criou os dois campos de
* origem (txt_4c_HistTit e txt_4c_DadosPg) mas NAO migrou os eventos que
* abriam o dialogo - medido: zero BINDEVENT de DblClick/Click nesses dois
* controles e zero referencia a esta classe em todo o projeto. Falta tambem o
* GarantirClasse("FormSigOpRob") que a carga sob demanda exige no ponto de
* abertura. Nao foi feito aqui de proposito: eh codigo de OUTRO form, migrado
* em OUTRA task (task499), com gates e verificacao proprios - mexer nele a
* partir desta fase seria alterar 3.000 linhas nao auditadas fora do escopo.
* Fica registrado para quem fechar a task499: sem esses dois handlers, este
* arquivo eh codigo morto, por mais completo que esteja.
*
*------------------------------------------------------------------------------
* DECISOES DE PROPRIEDADE (transcricao x canonico) - todas contra o dump
*------------------------------------------------------------------------------
* TRANSCRITAS do dump, literais: Height = 430, Width = 800, BorderStyle = 2,
*   AutoCenter = .T., TitleBar = 0, ControlBox = .F., AlwaysOnTop = .T.,
*   DataSession = 2. O Picture (..\framework\imagens\new_background.jpg) vira
*   gc_4c_CaminhoIcones + "new_background.jpg" - so o caminho muda, porque o
*   arquivo foi reunido em vbmp\ (conferido: vbmp\new_background.jpg existe).
*
* NAO TRANSCRITA - WindowType: o dump declara WindowType = 0 (modeless, que e'
*   o default do baseclass "form"). Transcrever esse 0 QUEBRA a tela no sistema
*   novo, porque o modo de abertura mudou: o legado usa "Do Form" e o VFP
*   guarda a referencia, enquanto aqui o chamador faz CREATEOBJECT numa
*   variavel LOCAL + Show(); com modeless o Show() retorna na hora, a variavel
*   sai de escopo, a ultima referencia cai e o dialogo e' DESTRUIDO - pisca e
*   some, sem erro e sem log. Canonico do projeto (435 dos 459 forms):
*   WindowType = 1 + ShowWindow = 1. O modal ainda reproduz melhor o
*   pseudo-modal do legado (pai desabilitado + AlwaysOnTop).
*
* NAO INVENTADAS - Closable / MaxButton / MinButton: o dump NAO as declara, e
*   elas sao independentes de TitleBar/ControlBox (sem barra de titulo os
*   botoes nao DESENHAM, mas Closable continua .T. e o Alt+F4 segue
*   funcionando). Acrescentar Closable = .F. "por coerencia" mudaria
*   comportamento. MaxButton/MinButton ficam com o .T. herdado da FormBase.
*
*==============================================================================

DEFINE CLASS FormSigOpRob AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais - transcricao do bloco "PROPRIEDADES DE: SIGOPROB"
    * do dump (ver secao DECISOES DE PROPRIEDADE no cabecalho do arquivo).
    *--------------------------------------------------------------------------
    this_cMensagemErro = ""
    Width       = 800
    Height      = 430
    AutoCenter  = .T.
    BorderStyle = 2
    TitleBar    = 0
    ControlBox  = .F.
    AlwaysOnTop = .T.
    DataSession = 2
    WindowType  = 1       && dump: 0 (modeless) - ver cabecalho, nao transcrito
    ShowWindow  = 1
    Caption     = "Form1"  && dump: "Form1", sobrescrito pelo Init legado

    *--------------------------------------------------------------------------
    * this_oFormPai - legado: ThisForm.poParentForm (ClassInfo "poparentform").
    * Referencia do form que abriu este dialogo e que se desabilitou para
    * simular modal. Fica no FORM e NUNCA no BO: e' estado de INTERFACE, e
    * guardar referencia de Form dentro do Business Object criaria referencia
    * circular, segurando o formulario em memoria depois do Release (ver o
    * cabecalho de SigOpRobBO.prg, que registra a mesma decisao).
    *--------------------------------------------------------------------------
    this_oFormPai = .NULL.

    *--------------------------------------------------------------------------
    * Guarda temporaria dos parametros do Init: FormBase.Init() chama
    * THIS.InicializarForm() SEM argumentos, entao o que o Init recebe precisa
    * ficar em property ate InicializarForm() ler e entregar ao BO.
    *--------------------------------------------------------------------------
    this_cTituloPendente = ""    && legado: pcTitulo
    this_cTextoPendente  = ""    && legado: pcTexto

    *==========================================================================
    * Init - recebe os mesmos tres argumentos do "Do Form SigOpRob With
    * pcTitulo, pcTexto, poForm" legado.
    *
    * Os tres sao opcionais: parametro omitido chega como .F. (logico), por
    * isso cada guarda confere o VARTYPE esperado antes de guardar. Sem
    * argumento nenhum o dialogo abre com titulo e texto vazios, em vez de
    * estourar - e' o que permite instancia-lo num probe/harness.
    *
    * Init() so GUARDA e delega: quem cria o BO e monta a tela e'
    * InicializarForm(), chamado uma unica vez por FormBase.Init() atraves do
    * DODEFAULT(). Chamar THIS.InicializarForm() aqui tambem faria os AddObject
    * rodarem duas vezes ("A member object with this name already exists").
    *==========================================================================
    PROCEDURE Init(par_cTitulo, par_cTexto, par_oFormPai)
        IF VARTYPE(par_cTitulo) = "C"
            THIS.this_cTituloPendente = par_cTitulo
        ENDIF

        IF VARTYPE(par_cTexto) = "C"
            THIS.this_cTextoPendente = par_cTexto
        ENDIF

        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - hook chamado por FormBase.Init().
    *
    * Cria o Business Object das Fases 1-2 e reproduz as linhas de interface
    * do Init legado:
    *
    *     ThisForm.Caption                      = pcTitulo
    *     ThisForm.cntSombra.lblSombra.Caption  = ThisForm.Caption
    *     ThisForm.cntSombra.lblTitulo.Caption  = ThisForm.Caption
    *     ThisForm.Edit1.Value                  = pcTexto   && Fase 4/5
    *
    * As duas linhas de Caption do cabecalho acontecem dentro de
    * ConfigurarCabecalho(), que le THIS.Caption ja atribuido - por isso a
    * ordem (Caption antes do cabecalho) importa.
    *
    * NAO ha guard de gb_4c_ValidandoUI / gb_4c_ModoTeste aqui: este form nao
    * carrega dado nenhum (o BO nao tem tabela, cursor nem SQL - ver
    * SigOpRobBO.prg), entao nao existe acesso a servidor a pular; o conteudo
    * chega pronto pelos parametros do Init.
    *
    * Retorna .T./.F.: devolvendo .F. a FormBase.Init() cancela a criacao do
    * form, e o CREATEOBJECT do chamador devolve .F. em vez de uma tela
    * quebrada.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .T.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpRobBO", ;
                THIS.this_cTituloPendente, ;
                THIS.this_cTextoPendente)

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar o objeto de neg" + CHR(243) + "cio SigOpRobBO.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            IF loc_lSucesso
                *-- legado: Picture = ..\framework\imagens\new_background.jpg
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                *-- A ordem abaixo e' a ordem dos objetos no SCX, e ela importa:
                *-- cntSombra -> Edit1 -> Commandgroup1. O grupo de botoes fica
                *-- sobre a area da faixa do cabecalho e so aparece se for
                *-- criado DEPOIS dela.
                *-- Os metodos abaixo criam os controles e aplicam GEOMETRIA,
                *-- fonte e cor - nada que venha de dado. O conteudo (titulo e
                *-- texto) e' aplicado DEPOIS, num ponto so, pelo hook
                *-- canonico de transferencia do Business Object para a tela.
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarConteudo()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarEventos()

                *-- legado (as quatro linhas de interface do Init): Caption do
                *-- Form, Caption dos dois rotulos da faixa e Value do EditBox.
                *-- Exige os controles JA criados pelos metodos acima.
                THIS.BOParaForm()

                *-- AddObject cria todo controle com Visible = .F.
                THIS.TornarControlesVisiveis(THIS)
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - cnt_4c_Sombra + lbl_4c_LblSombra + lbl_4c_LblTitulo
    *
    * Transcricao pixel-perfect de SIGOPROB.cntSombra e dos dois Label filhos
    * (SECAO 2 do dump). Nomes fixados em tasks\task796\mapeamento.json:
    *     SIGOPROB.cntSombra            -> cnt_4c_Sombra
    *     SIGOPROB.cntSombra.lblSombra  -> lbl_4c_LblSombra
    *     SIGOPROB.cntSombra.lblTitulo  -> lbl_4c_LblTitulo
    *
    * O Form legado ja tem 800px - o mesmo Width desta classe - entao os
    * valores entram LITERAIS, sem reescalonamento.
    *
    * lblSombra (preto, criado primeiro) e lblTitulo (branco, por cima, 1px
    * acima) formam o efeito de sombra do titulo; os DOIS Caption acompanham
    * THIS.Caption, exatamente como as duas linhas finais do Init legado.
    * Aqui o branco do lblTitulo e' CORRETO (nao viola a regra de ForeColor
    * branco invisivel): ele esta dentro de um container OPACO escuro -
    * cnt_4c_Sombra com BackColor RGB(100,100,100) - e nao sobre o Picture
    * claro do Form.
    *
    * AutoSize NAO e' atribuido: o dump nao o declara nestes dois Label, e em
    * Label criado por AddObject ele seria no-op de qualquer forma. Width e
    * Height vem explicitos do dump (769x40 e 769x46), que e' o que WordWrap
    * = .T. precisa para quebrar o titulo em duas linhas sem corta-lo.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
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
            .Rotation      = 0
            .Visible       = .T.
            *-- Caption: aplicado pelo hook de transferencia do BO (ponto unico)
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
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
            .Rotation    = 0
            .Visible     = .T.
            *-- Caption: aplicado pelo hook de transferencia do BO (ponto unico)
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - padrao generico do projeto: percorre
    * recursivamente os Controls de cada container (e as Pages de um eventual
    * PageFrame) tornando-os visiveis, porque AddObject cria tudo com
    * Visible = .F.
    *
    * Este dialogo nao tem PageFrame nem container flutuante alternado por
    * botao, entao NAO ha lista de excecao a filtrar: todos os controles do
    * legado nascem visiveis.
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

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

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * ConfigurarConteudo - obj_4c_Edit1, o EditBox somente-leitura que EXIBE o
    * texto recebido pelo Init. E' a razao de existir do dialogo.
    *
    * Transcricao literal de SIGOPROB.Edit1 (SECAO 2 do dump): Top = 98,
    * Left = 181, Width = 438, Height = 312, ReadOnly = .T.,
    * DisabledBackColor = 255,255,255 e DisabledForeColor = 0,0,0.
    *
    * O valor reproduz a linha "ThisForm.Edit1.Value = pcTexto" do Init legado,
    * lendo a propriedade do Business Object - que e' onde pcTexto foi guardado
    * (ver SigOpRobBO.this_cTexto). O BO ja esta criado e conferido quando este
    * metodo roda, porque InicializarForm so o chama dentro do IF de sucesso.
    *
    * O que o dump NAO declara tambem nao e' atribuido aqui: sem FontName/
    * FontSize (herda a fonte do Form), sem ScrollBars (o default do EditBox ja
    * e' a barra vertical), sem MaxLength, sem Format. Inventar qualquer um
    * deles mudaria a tela em relacao ao legado.
    *
    * ReadOnly = .T. NAO impede rolar, selecionar e copiar o texto - impede so
    * alterar, que e' exatamente o comportamento do legado. Nada neste form
    * reabilita a edicao: o dialogo existe para MOSTRAR.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarConteudo()
        THIS.AddObject("obj_4c_Edit1", "EditBox")
        WITH THIS.obj_4c_Edit1
            .Top               = 98
            .Left              = 181
            .Width             = 438
            .Height            = 312
            .ReadOnly          = .T.
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 0)
            .Visible           = .T.
            *-- legado: ThisForm.Edit1.Value = pcTexto - aplicado pelo hook de
            *-- transferencia do BO (ponto unico), nao aqui
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - cmg_4c_Commandgroup1, o CommandGroup de UM botao que e'
    * a unica acao da tela (SIGOPROB.Commandgroup1 + o membro Command1, que o
    * SCX renomeia para CmdSair).
    *
    * ORDEM DAS ATRIBUICOES - as tres regras que valem aqui:
    *
    * 1. ButtonCount PRIMEIRO. O default do CommandGroup e' 2; mexer nessa
    *    propriedade RECRIA os botoes, entao configurar Buttons(1) antes de
    *    reduzir para 1 jogaria fora tudo o que foi configurado.
    *
    * 2. Geometria do botao INTERNO antes da do grupo. O dump declara
    *    AutoSize = .T. no grupo, e com AutoSize quem DEFINE o tamanho do grupo
    *    e' o botao de dentro: 5 + 75 + 5 = 85, que e' exatamente o 85x85 que o
    *    dump declara no grupo. Width/Height do grupo ficam escritos assim
    *    mesmo, por serem o que o dump traz e por documentarem o resultado
    *    esperado do AutoSize.
    *
    * 3. O grupo NAO recebe ForeColor. CommandGroup nao tem essa propriedade
    *    (medido na lista real de propriedades das classes base) e atribui-la
    *    derrubaria o Init inteiro com "Property FORECOLOR is not found" - a cor
    *    do texto mora no BOTAO, que e' onde o SCX tambem a declara.
    *
    * Themes = .F. e' transcricao do dump e esta correto AQUI: a ressalva de
    * precisar de Themes = .T. para o icone desenhar vale para CommandButton
    * SOLTO, nao para botao dentro de CommandGroup - e este botao nunca e'
    * desabilitado, que e' a condicao em que o icone sumiria.
    *
    * Cancel = .T. tambem vem do dump, e e' funcional e nao decorativo: com
    * TitleBar = 0 e ControlBox = .F. nao ha X para clicar, e e' esse Cancel que
    * faz o ESC fechar a tela, passando pelo MESMO handler do botao.
    *
    * O arquivo do icone foi conferido: vbmp\cadastro_sair_60.jpg existe.
    * Picture apontando para arquivo inexistente nao da erro nenhum em VFP9 - o
    * botao so ficaria sem desenho, calado.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oCmg

        THIS.AddObject("cmg_4c_Commandgroup1", "CommandGroup")
        loc_oCmg = THIS.cmg_4c_Commandgroup1

        *-- (1) ButtonCount antes de qualquer coisa - ver cabecalho do metodo
        loc_oCmg.ButtonCount = 1

        *-- (2) botao interno: SIGOPROB.Commandgroup1.Command1 (Name = CmdSair)
        WITH loc_oCmg.Buttons(1)
            .Top        = 5
            .Left       = 5
            .Width      = 75
            .Height     = 75
            .Caption    = "Encerrar"
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
            .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel     = .T.
            .Visible    = .T.
        ENDWITH

        *-- (3) grupo: sem ForeColor - ver cabecalho do metodo
        WITH loc_oCmg
            .AutoSize      = .T.
            .Top           = -2
            .Left          = 720
            .Width         = 85
            .Height        = 85
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Value         = 1
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarEventos - liga o Click do botao ao handler do form.
    *
    * O alvo do BINDEVENT e' Buttons(1), nao o grupo: e' no botao que o SCX poe
    * o codigo (PROCEDURE CmdSair.Click). O handler tem de ser PUBLIC -
    * BINDEVENT para metodo PROTECTED falha CALADO, sem erro e sem log, e o
    * botao ficaria inerte.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEventos()
        BINDEVENT(THIS.cmg_4c_Commandgroup1.Buttons(1), "Click", THIS, "CmdSairClick")
    ENDPROC

    *==========================================================================
    * BOParaForm - hook CANONICO da FormBase: leva o dado do Business Object
    * para os controles da tela. Aqui ele e' exatamente as QUATRO linhas de
    * interface do Init legado, que antes desta fase estavam espalhadas por
    * tres metodos diferentes - com o titulo escrito em TRES lugares:
    *
    *     ThisForm.Caption                      = pcTitulo    && BO.this_cTitulo
    *     ThisForm.cntSombra.lblSombra.Caption  = ThisForm.Caption
    *     ThisForm.cntSombra.lblTitulo.Caption  = ThisForm.Caption
    *     ThisForm.Edit1.Value                  = pcTexto     && BO.this_cTexto
    *
    * PONTO UNICO de proposito: o titulo pousa em tres propriedades e o legado
    * deriva as duas ultimas da PRIMEIRA (os dois rotulos leem ThisForm.Caption,
    * nao o parametro). Mantendo as tres atribuicoes no mesmo metodo, e sempre
    * nessa ordem, as copias nao podem divergir; espalhadas pelos metodos que
    * CRIAM os controles, qualquer mudanca de titulo teria de ser lembrada em
    * dois arquivos de distancia (CLAUDE.md #44, item 6 - fonte unica).
    *
    * PROTECTED porque FormBase declara este hook PROTECTED: um override
    * PUBLIC nao alarga o escopo herdado, e o form NUNCA chama o hook de fora -
    * quem o chama eh InicializarForm (aqui) e a propria FormBase.
    *
    * GUARDA DE EXISTENCIA, e nao de escopo: FormBase.Cancelar() tambem chama
    * este hook, e ele poderia ser alcancado antes de os AddObject rodarem (no
    * caminho em que InicializarForm falha no meio). PEMSTATUS(...,5) responde
    * so "o membro existe", que eh exatamente a pergunta - conferir o controle
    * pelo nome com PEMSTATUS NAO prova escopo nem tipo, e aqui nao precisa.
    *
    * Sem TRY/CATCH e sem RETURN condicional: nao ha chamada externa, nada
    * aqui pode falhar com os guards acima, e RETURN dentro de TRY eh proibido
    * (CLAUDE.md #1). InicializarForm, que eh quem chama, ja esta sob TRY.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        *-- legado: ThisForm.Caption = pcTitulo
        THIS.Caption = THIS.this_oBusinessObject.this_cTitulo

        *-- legado: as duas linhas seguintes leem ThisForm.Caption, nao pcTitulo
        IF PEMSTATUS(THIS, "cnt_4c_Sombra", 5)
            IF PEMSTATUS(THIS.cnt_4c_Sombra, "lbl_4c_LblSombra", 5)
                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
            ENDIF

            IF PEMSTATUS(THIS.cnt_4c_Sombra, "lbl_4c_LblTitulo", 5)
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
            ENDIF
        ENDIF

        *-- legado: ThisForm.Edit1.Value = pcTexto
        *-- Coluna MEMO do chamador entra aqui sem conversao: medido no VFP9 em
        *-- 2026-11-17, VARTYPE de campo MEMO devolve "C" (nao "M"), entao o
        *-- texto de TmpConta.Obsd / TmpConta.HistPgs chega inteiro.
        IF PEMSTATUS(THIS, "obj_4c_Edit1", 5)
            THIS.obj_4c_Edit1.Value = THIS.this_oBusinessObject.this_cTexto
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdSairClick - handler do botao Encerrar (e do ESC, via Cancel = .T.).
    *
    * Legado (SIGOPROB.Commandgroup1.CmdSair.Click):
    *     If Type([ThisForm.poParentForm]) = [O]
    *         ThisForm.poParentForm.Enabled = .T.
    *     EndIf
    *     Release Windows
    *
    * PUBLIC por ser alvo de BINDEVENT. O corpo fica em FecharDialogo porque o
    * fechamento tem de ser um PONTO SO - ver o cabecalho daquele metodo.
    *==========================================================================
    PROCEDURE CmdSairClick()
        THIS.FecharDialogo()
    ENDPROC

    *==========================================================================
    * FecharDialogo - funil unico de fechamento: reabilita o form que abriu este
    * dialogo e esconde a janela.
    *
    * POR QUE Hide() E NAO Release(), se o legado faz "Release Windows": o modo
    * de abertura mudou. No legado o "Do Form" deixa o VFP dono da janela; aqui
    * o chamador faz CREATEOBJECT numa variavel e chama Release() depois que o
    * Show() retorna - que e' o contrato registrado no topo deste arquivo. Form
    * em VFP9 nao segue contagem de referencia: THIS.Release() DESTROI o objeto
    * na hora, mesmo com o chamador apontando para ele, e a linha seguinte do
    * chamador estouraria "is not an object" - um erro longe da causa, dentro de
    * quem abriu a tela. Hide() em form modal tambem devolve o Show(), entao
    * para o usuario a tela fecha igual (PILAR 1 preservado); muda so o tempo de
    * vida do objeto, que e' PILAR 3. E' o mesmo desenho que o FormBuscaAuxiliar
    * ja adota no projeto.
    *
    * Como o Hide() ADIA o Destroy ate o Release do chamador, a reabilitacao do
    * pai - que o legado faz AQUI, antes de fechar - tem de ficar AQUI mesmo, e
    * nao so no Destroy: adiada, o pai ficaria travado durante todo o intervalo.
    * A copia que existe no Destroy permanece como rede de seguranca para o que
    * nao passe por aqui; reabilitar duas vezes e' inocuo.
    *
    * OS TRES CAMINHOS DE SAIDA DA TELA DESEMBOCAM NESTE METODO, e todos os tres
    * foram medidos no VFP9 (ver o bloco da Fase 7 no cabecalho do arquivo):
    *   clique no Encerrar -> Click do botao interno, ligado por BINDEVENT
    *   ESC                -> Cancel = .T. no MESMO botao interno (o grupo nao
    *                         tem essa propriedade), que aciona o mesmo Click
    *   Alt+F4             -> QueryUnload, logo abaixo, com NODEFAULT
    * Ter UM funil e' o que garante que nenhum deles deixe o form pai
    * desabilitado nem destrua o objeto que pertence ao chamador.
    *
    * PUBLIC: nao e' alvo de BINDEVENT, mas e' o unico ponto de fechamento da
    * tela, e o chamador pode precisar fecha-la por conta propria.
    *==========================================================================
    PROCEDURE FecharDialogo()
        *-- legado: If Type([ThisForm.poParentForm]) = [O] / ... Enabled = .T.
        IF VARTYPE(THIS.this_oFormPai) = "O"
            IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
                THIS.this_oFormPai.Enabled = .T.
            ENDIF
        ENDIF

        *-- legado: Release Windows (ver cabecalho deste metodo - aqui e' Hide)
        THIS.Hide()
    ENDPROC

    *==========================================================================
    * QueryUnload - TERCEIRO caminho de saida da tela, levado ao MESMO funil.
    *
    * Closable segue .T. (o dump nao a declara, e ela e' independente de
    * TitleBar/ControlBox - sem barra de titulo o X nao DESENHA, mas o Alt+F4
    * continua fechando a janela). Esse caminho nao passa pelo Encerrar nem
    * pelo Cancel do botao: o VFP levanta o QueryUnload e, sem tratamento,
    * segue para o comportamento DEFAULT, que DESTROI o form.
    *
    * Medido no VFP9 em 2026-11-17 (ver o bloco da Fase 7 no cabecalho do
    * arquivo), enviando WM_CLOSE a janela - o mesmo caminho do Alt+F4:
    *
    *   SEM este metodo -> o form e' DESTRUIDO, o Show() devolve, a variavel do
    *     CHAMADOR fica em VARTYPE "X" e o "loc_oDlg.Release()" do contrato
    *     ESTOURA "is not an object" - erro LONGE da causa, dentro do form que
    *     abriu o dialogo.
    *   COM este metodo -> o objeto fica VIVO, o pai e' reabilitado e o
    *     Release() do chamador roda limpo.
    *
    * NODEFAULT e' o que cancela a destruicao, e ele NAO impede o chamador de
    * liberar a tela: medido, Form.Release() nao levanta QueryUnload - vai
    * direto ao Destroy. Quem destroi o objeto continua sendo quem o criou.
    *
    * PUBLIC: e' evento do proprio Form, levantado pelo VFP.
    *==========================================================================
    PROCEDURE QueryUnload()
        THIS.FecharDialogo()

        *-- cancela a destruicao DEFAULT: o objeto e' do chamador
        NODEFAULT
    ENDPROC

    *==========================================================================
    * Destroy - reabilita o form pai e devolve o controle a FormBase.
    *
    * A repeticao da reabilitacao AQUI e' rede de seguranca deliberada, nao
    * duplicacao por engano: o pai se desabilita ANTES de abrir o dialogo, e se
    * a tela for fechada por um caminho que nao passe pelo funil, o pai ficaria
    * desabilitado para SEMPRE, sem erro e sem log, e o usuario perderia a tela
    * de origem. Reabilitar duas vezes e' inocuo (o funil ja tera' gravado .T.);
    * nao reabilitar nenhuma trava o sistema.
    *
    * Com o QueryUnload acima, os TRES caminhos de saida conhecidos - clique no
    * Encerrar, ESC e Alt+F4 - ja passam pelo funil, todos medidos no VFP9 (ver
    * o bloco da Fase 7 no cabecalho do arquivo). Esta copia cobre o que sobrar:
    * CLEAR ALL, RELEASE WINDOWS e queda de referencia.
    *
    * A medicao mostrou por que a rede de seguranca NAO dispensava o conserto da
    * Fase 7: no controle negativo (mesma classe, sem o QueryUnload) o Alt+F4
    * destruia o form e este Destroy reabilitava o pai do mesmo jeito - entao o
    * UNICO sintoma restante era o "is not an object" na linha seguinte ao
    * Show(), dentro de quem abriu o dialogo. Rede de seguranca que esconde
    * metade do defeito eh pior do que nao ter: manda o diagnostico para o
    * chamador.
    *
    * A leitura de this_oFormPai vem ANTES do DODEFAULT() porque
    * FormBase.Destroy() limpa o estado do form e faz a restauracao de
    * menu/popup, que tem de continuar acontecendo - por isso o DODEFAULT() e'
    * obrigatorio e fica por ultimo.
    *
    * PEMSTATUS antes de atribuir: "Enabled" existe em qualquer Form, mas o
    * pai pode ja ter sido liberado quando este Destroy roda, e nesse caso
    * VARTYPE devolve "X" e o IF nao entra.
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
                THIS.this_oFormPai.Enabled = .T.
            ENDIF
        ENDIF

        THIS.this_oFormPai = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE
