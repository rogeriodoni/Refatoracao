# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH THIS.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Dados.RecordSource).

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES FUNCIONAIS
- [CONTAINER-VISIVEL] TornarControlesVisiveis nao filtra containers ocultos (Visible=.F.). Adicionar INLIST
- [BUSCA-CURSOR] FormBuscaAuxiliar sem this_cCursorDestino no Modo 2
- [OPTIONGROUP-LEFT] Buttons sobrepostos - definir .Left, .Top, .AutoSize em CADA Button
- [CARGA-DADOS] Validar* sem chamada de carga / OptionGroup sem InteractiveChange
- [BINDEVENT-PARAMS] Handler sem LPARAMETERS (AfterRowColChange(par_nColIndex), KeyPress(par_nKeyCode, par_nShift))
- [STUB-MSGAVISO] Btn*Click com MsgAviso placeholder ao inves de logica real
- [LOSTFOCUS-SEM-GUARDIA] Handler abre busca sem verificar se valor mudou
- [INIT-DUPLICADO] Init() chama DODEFAULT() + InicializarForm() (duplicado)
- [METODO-INEXISTENTE] THIS.Metodo() chamado mas nao definido no Form. LLM pode ter inventado. IMPLEMENTAR ou REMOVER.

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPDVM.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1456 linhas total):

*-- Linhas 50 a 254:
50: * ESCOPO JA ENTREGUE
51: *
52: * Fase 3/8 - estrutura base: DEFINE CLASS + propriedades visuais do dump,
53: * Init (contexto do pai + BO + InicializarForm), cabecalho cinza
54: * (cntSombra -> cnt_4c_Sombra com os dois labels) e Destroy.
55: *
56: * Fase 4/8 - Grid1 -> grd_4c_Dados (ConfigurarGrid: 7 colunas, headers,
57: * fonte e cores do dump - AINDA SEM RecordSource/ControlSource, que dependem
58: * do cursor_4c_Dados so criado na Fase 8), Shape1 -> shp_4c_Shape1 decorativo
59: * e CmdCat -> cmd_4c_Encerrar (ConfigurarBotoes), nesta ordem de AddObject
60: * (identica ao dump: cabecalho, Grid1, Shape1, CmdCat).
61: *
62: * NAO existem aqui PageFrame nem pagina Lista/Dados: o SCX legado nao tem
63: * Page nenhuma (layout FLAT) e tem apenas 1 botao (CmdCat, "Encerrar") -
64: * nunca os 5 botoes CRUD do padrao frmcadastro. Inventar PageFrame Lista/
65: * Dados e botoes CRUD canonicos violaria o PILAR 1.
66: *
67: * Fase 5/8 - superficie de DADOS. Esta tela NAO tem campo solto algum: a
68: * unica superficie de dados sao as 7 celulas da grade (todas ReadOnly = .T.
69: * no dump), entao "metade dos campos da Page2" e vazio aqui por construcao -
70: * inventar campos ou uma Page2 violaria o PILAR 1. O trabalho real desta
71: * fase foi:
72: *   (a) AUDITORIA das propriedades do dump que a Fase 4 deixou passar, por
73: *       criar muitos controles de uma vez - 15 atribuicoes acrescentadas:
74: *       Grid1.Panel = 1 e ColumnN.FontName/FontSize ("Tahoma"/8) nas 7
75: *       colunas (o dump declara a fonte na Column ALEM do Header1/Text1);
76: *   (b) ConfigurarPaginaDados() com corpo REAL, chamado no InicializarForm
77: *       DEPOIS de todos os AddObject: confere que as 7 colunas do dump
78: *       existem e delega o vinculo;
79: *   (c) VincularColunasGrade() - as 7 linhas de ControlSource do Init legado,
80: *       guardadas por USED() para nao derrubar a tela antes do cursor existir
81: *       (regra #41). Column5/Column6 sao EXPRESSOES, transcritas literalmente.
82: *
83: * Fase 6/8 - CAMPOS RESTANTES E LOOKUPS: esta tela nao tem NENHUM dos dois,
84: * e isso foi MEDIDO no dump, nao presumido.
85: *
86: *   (a) CAMPOS - metade de zero continua zero. Os 7 "BaseClass: textbox" do
87: *       dump sao os Text1 NATIVOS das 7 Column do Grid1 (regra #18), ja
88: *       entregues com a propria grade nas Fases 4/5; o dump nao tem UM
89: *       controle de entrada fora da grade (nenhum textbox/editbox/combobox/
90: *       listbox/checkbox/optiongroup/spinner cujo Parent nao seja uma
91: *       Column). E todos sao somente-leitura no legado: Grid1.ReadOnly=.T.,
92: *       Column1..Column7.ReadOnly=.T. e Text1.ReadOnly=.T. em Column1..6
93: *       (Column7.Text1 nao declara, herda do Grid/Column - por isso o
94: *       migrado tambem nao declara la). Campo ReadOnly nao recebe lookup por
95: *       definicao: nao ha onde o usuario digitar codigo para o picker
96: *       resolver.
97: *
98: *   (b) LOOKUPS - o dump nao casa NENHUMA assinatura de busca do Framework
99: *       Fortyus: nenhum fwBusca* (as TRES variantes Ext/Sel/Int), nenhum
100: *       mAddColuna (a API de colunas do picker legado, que cobre variante
101: *       futura da classe), nenhum sigacess(), nenhuma funcao da familia
102: *       Acesso<X>() e nenhum FormBuscaAuxiliar. comportamento.json confirma
103: *       pela via INDEPENDENTE da analise comportamental: nos 3 metodos com
104: *       codigo do SCX (Load, Init, CmdCat.Click) o campo "temLookup" sai
105: *       .F. nos tres, e a unica funcaoExterna de toda a tela e fConfigGeral
106: *       (do Load).
107: *
108: *       Inventar um lookup para "ter o que entregar" violaria o PILAR 1 e a
109: *       regra explicita "NUNCA inventar tabelas de lookup que nao existem no
110: *       original"; um AbrirLookup* de corpo vazio violaria a regra de
111: *       completude. Mesma decisao, mesmo motivo, dos precedentes SIGOPCLP ->
112: *       FormSigOpClp (task704: grade de 7 colunas + UM botao Encerrar, o
113: *       analogo exato desta tela) e SIGMVCHV -> FormSigMvChv.
114: *
115: *   (c) O QUE ESTA FASE ENTREGA DE VERDADE - a Fase 4 criou cmd_4c_Encerrar
116: *       (CmdCat do legado) SEM handler e SEM BINDEVENT: o unico botao da
117: *       tela estava inerte, e o usuario clicava nele sem nada acontecer. O
118: *       unico evento de controle que o dump tem - CmdCat.Click, de uma linha
119: *       so ("Release Windows") - passou a existir aqui, em BtnEncerrarClick
120: *       + BINDEVENT no fim de ConfigurarBotoes. Deixar o botao morto para
121: *       mais tarde seria fechar esta fase com um defeito ja conhecido. Com
122: *       isso a Fase 7 (eventos de botao) fica sem item NOVO nesta tela: o
123: *       legado tem UM botao e UM Click, e nenhum botao CRUD.
124: *
125: * Fase 7/8 - EVENTOS PRINCIPAIS DOS BOTOES: ja entregues, e a ausencia dos
126: * quatro nomes CRUD foi MEDIDA no dump, nao presumida.
127: *
128: *   (a) O QUE O LEGADO TEM DE BOTAO - exatamente UM. Contado no dump: 1
129: *       objeto com "BaseClass: commandbutton" (CmdCat, classe fwbtng) e ZERO
130: *       objeto com "BaseClass: commandgroup" (logo nao ha ButtonCount algum a
131: *       somar). O dump inteiro declara 3 metodos com codigo - Load
132: *       ("=fConfigGeral()"), Init (a comparacao) e CmdCat.Click - e um unico
133: *       "PROCEDURE Click".
134: *
135: *   (b) O QUE O LEGADO NAO TEM - zero evidencia de CRUD, nas tres vias
136: *       independentes, todas medidas em 2026-10-31 sobre
137: *       tasks\task726\SIGOPDVM_form_codigo_fonte.txt:
138: *
139: *         ESTRUTURAL : "frmcadastro" 0, "frmrelatorio" 0, "Grupo_Op" 0 e
140: *                      "pcEscolha" 0 - o form e "Class: form" PURO, sem Page
141: *                      Lista/Dados (layout FLAT).
142: *         NOME       : "Incluir" 0, "Alterar" 0, "Visualizar" 0 - e tambem
143: *                      "Excluir" 0 e "Inserir" 0, entao nem a barra CRUD do
144: *                      frmcadastro nem a toolbar de LINHA de grade (cujo
145: *                      unico verbo compartilhado seria "Excluir") existem.
146: *         CHAMADA    : nenhum "<X>.Click" com X em Incluir/Alterar/
147: *                      Visualizar/Excluir - o unico .Click do dump e o do
148: *                      proprio CmdCat.
149: *
150: *       Por isso NAO existem aqui BtnIncluirClick/BtnAlterarClick/
151: *       BtnVisualizarClick/BtnExcluirClick: criar os quatro violaria o
152: *       PILAR 1 (inventa botao que o usuario do legado nunca teve) e, com
153: *       corpo vazio, violaria a regra de completude. Mesma decisao e mesmo
154: *       motivo do precedente SIGOPCLP -> FormSigOpClp (task704: grade de 7
155: *       colunas + UM botao Encerrar, o analogo exato desta tela).
156: *
157: *   (c) O UNICO EVENTO DE BOTAO QUE EXISTE JA ESTA PORTADO - CmdCat.Click ->
158: *       BtnEncerrarClick, mais o BINDEVENT no fim de ConfigurarBotoes,
159: *       escritos na Fase 6 para o botao nao ficar inerte (item (c) do bloco
160: *       da Fase 6 acima). Esta fase RE-AUDITOU esse par, e os cinco pontos
161: *       conferem:
162: *         1. BtnEncerrarClick e PUBLIC (sem PROTECTED) - BINDEVENT em metodo
163: *            PROTECTED falha EM SILENCIO (regra #3) e PEMSTATUS devolveria
164: *            .T. mesmo assim, escondendo o defeito;
165: *         2. o delegate EXISTE com o nome exato passado ao BINDEVENT - nome
166: *            inexistente estoura no proprio bind;
167: *         3. o BINDEVENT vem DEPOIS do AddObject do botao, no fim do metodo -
168: *            antes dele o objeto nem existe;
169: *         4. THIS.Release() (nao Hide()) e a traducao certa AQUI porque esta
170: *            tela nao devolve NADA ao chamador: nao ha property de retorno,
171: *            nao ha PROCEDURE Unload no dump e o legado nao e aberto com
172: *            "DO FORM ... TO <var>". Onde ha resultado a ler, Release()
173: *            mataria a referencia do chamador (licao do FormSigOpCtd,
174: *            task715) - nao e o caso desta tela;
175: *         5. o ESC nao precisa de segundo handler - cmd_4c_Encerrar tem
176: *            Cancel = .T. transcrito do dump, e a tecla de cancelamento
177: *            dispara o Click do proprio botao, que e justamente o evento
178: *            interceptado pelo BINDEVENT.
179: *
180: *   (d) NAO ha outro evento a portar. O dump nao tem evento algum de Grid
181: *       (nenhum AfterRowColChange e nenhum Header1.Click que reordene a
182: *       grade), nem KeyPress, nem Valid/LostFocus - as 7 celulas sao
183: *       ReadOnly e nao existe UM controle de entrada fora da grade (medido
184: *       na Fase 6). O "Load" ("=fConfigGeral()") segue NAO PORTADO:
185: *       fConfigGeral era inicializacao GLOBAL da aplicacao Fortyus, e
186: *       utils\fconfiggeral.prg e um wrapper NO-OP que existe apenas para o
187: *       p-code dos VCX legado - precedente registrado em FormSigMvExp,
188: *       FormSigMvMen, FormSigMvPdt e no proprio SigOpClpBO.
189: *
190: *   (e) Entrega desta fase, em uma linha: NENHUMA linha de codigo nova -
191: *       cada evento de botao que o legado tem ja existe e foi reconferido.
192: *       O que entra e o registro da medicao acima, para que a proxima
193: *       leitura (ou o proximo sweep) nao conclua que faltam handlers.
194: *
195: * Fase 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL. Esta fase fecha o
196: * unico buraco funcional que sobrava: ate a Fase 7 a tela ABRIA, mas a grade
197: * nunca recebia dado nenhum - ConfigurarPaginaDados() chamava
198: * VincularColunasGrade(), que e GUARDADO por USED() (regra #41), e em tempo de
199: * Init o cursor da comparacao ainda nao existia, entao o vinculo nunca
200: * acontecia e ninguem chamava SIGOPDVMBO.GerarComparacao(). O usuario abria o
201: * dialogo e via a grade VAZIA, sem erro nenhum.
202: *
203: *   (a) CarregarLista() - o FUNIL unico de dado desta tela, e o NOME que o
204: *       gate desta fase cobra com referente de verdade aqui (o legado popula
205: *       a grade no proprio Init). Faz, na ordem do legado: GerarComparacao()
206: *       (os dois SCAN + Index + Go Top, ja no BO desde a Fase 2) e so DEPOIS
207: *       VincularColunasGrade() (RecordSource/ControlSource) - regra #41, que
208: *       e justamente o motivo de este par nao poder ter nascido na Fase 5.
209: *       PUBLIC de proposito: o harness de teste chama
210: *       THIS.oForm.CarregarLista() de FORA da classe, e PEMSTATUS devolveria
211: *       .T. para metodo PROTECTED enquanto a chamada real falharia so em
212: *       runtime (regras #3 e #51).
213: *
214: *   (b) InicializarForm() passou a chamar CarregarLista() - DEPOIS de todos os
215: *       AddObject e de ConfigurarPaginaDados(). Falha de DADO nao aborta a
216: *       tela (loc_lSucesso nao depende do retorno): o legado tambem abre o
217: *       dialogo com crImpressao vazio quando nao ha divergencia, e lista
218: *       vazia e resultado VALIDO desta tela, nao erro.
219: *
220: *   (c) AplicarColunasDoDump() - largura e caption das 7 colunas, extraidas de
221: *       dentro de VincularColunasGrade para virarem FONTE UNICA: atribuir
222: *       RecordSource/ControlSource reseta Column.Width para 90 e
223: *       Header1.Caption para "Header1" (Problema 48 / regra #41), e agora ha
224: *       DOIS caminhos que mexem em RecordSource - o vinculo e o
225: *       desligamento do ramo de falha. Duas copias divergiriam em silencio na
226: *       primeira coluna que mudasse (CLAUDE.md #44, item 6).
227: *
228: *   (d) Destroy() fecha o cursor da comparacao - mas SO se foi este dialogo
229: *       que o criou (this_lCursorProprio). A distincao e regra, nao zelo: no
230: *       legado o crImpressao e do form PAI (o Init legado so faz "Select
231: *       crImpressao / Zap", nunca o cria), e com DataSession = 1 um USE IN
232: *       incondicional aqui FECHARIA o cursor do pai ao sair do dialogo,
233: *       quebrando a tela que nos abriu. CarregarLista mede a posse olhando
234: *       USED() ANTES de GerarComparacao: nao existia antes e existe depois =
235: *       nos criamos. Sem TABLEREVERT antes do USE IN - ele exige buffering e
236: *       com Buffering = 1 ERRA (regra #52); USE IN fecha o alias de qualquer
237: *       jeito.
238: *
239: *   (e) O QUE NAO ENTRA, e por que - medido, nao presumido. O gate desta fase
240: *       cobra tambem BtnCancelarClick, FormParaBO e BOParaForm, e a lista de
241: *       verbos de botao de acao
242: *       Btn(Salvar|Confirmar|Gravar|Processa|Aplicar|Executar|OK)Click.
243: *       NENHUM deles tem referente neste SCX:
244: *
245: *         BtnCancelarClick  - nao ha Page2 de Dados nem modo de edicao a
246: *                             cancelar (layout FLAT, zero Page no dump).
247: *         FormParaBO        - sentido CAMPO -> BO. Nao existe UM campo
248: *                             editavel: os 7 "BaseClass: textbox" do dump sao
249: *                             os Text1 NATIVOS das 7 Column (regra #18) e o
250: *                             dump declara ReadOnly = .T. no Grid1 E nas sete
251: *                             Column1..Column7. Nao ha o que ler da tela.
252: *         BOParaForm        - sentido BO -> CAMPO. A grade le o cursor DIRETO
253: *                             por ControlSource, como no legado; as 5
254: *                             properties de linha do BO (CarregarDoCursor)

*-- Linhas 295 a 338:
295:     * crCaixaFIN/crSigFiMpi nao existem.
296:     *
297:     * ShowWindow = 1: nao vem do dump (o legado abria com "Do Form" e o
298:     * default 0 bastava); aqui o form e criado com CREATEOBJECT + Show() e o
299:     * canonico do projeto e 1 (modal) - regra "WindowType 0 mata a tela".
300:     *
301:     * DoCreate do dump NAO entra: flag de design-time do SCX, nao property
302:     * de runtime da classe Form (regra #33 - nunca chutar lista de
303:     * propriedades).
304:     *
305:     * NAO declarada no dump e portanto NAO inventada (regra #25): Closable
306:     * fica no default .T. - sem barra de titulo ele nao desenha nada, mas
307:     * Closable = .F. mataria o Alt+F4, que aqui e o unico jeito de fechar a
308:     * tela fora do botao Encerrar (regra "Closable inventado tira a saida").
309:     *==========================================================================
310:     this_cMensagemErro = ""
311:     DataSession = 1
312:     BorderStyle = 2
313:     Height      = 200
314:     Width       = 800
315:     ControlBox  = .F.
316:     TitleBar    = 0
317:     WindowType  = 1
318:     ShowWindow  = 1
319:     AutoCenter  = .T.
320: 
321:     Caption = "Diferen" + CHR(231) + "as Vendas x Mapa Resumo"
322: 
323:     *==========================================================================
324:     * PROPRIEDADES DE ESTADO
325:     *==========================================================================
326: 
327:     *-- Form PAI (pcForm do legado) - guardado so por referencia; esta tela
328:     *-- NAO desabilita/reabilita o pai (o legado nao faz isso no Init, ao
329:     *-- contrario de outros dialogos filho da mesma familia - nao inventar
330:     *-- comportamento que o dump nao tem).
331:     this_oFormPai = .NULL.
332: 
333:     *-- Aliases dos 4 cursores de origem, na mesma data session do pai
334:     *-- (crCaixa/crCaixaI/crCaixaFIN/crSigFiMpi no legado - ver contrato em
335:     *-- SIGOPDVMBO.DefinirCursoresOrigem)
336:     this_cCursorCaixa      = ""
337:     this_cCursorCaixaItens = ""
338:     this_cCursorCaixaFin   = ""

*-- Linhas 361 a 681:
361:     * Init - recebe o contexto do form PAI
362:     *
363:     * A ORDEM aqui e regra, nao estilo: FormBase.Init() chama
364:     * InicializarForm(), logo o contexto recebido por parametro tem de
365:     * estar guardado ANTES do DODEFAULT() - senao InicializarForm cria o BO
366:     * sem saber quais cursores comparar.
367:     *
368:     * par_oFormPai          - form que abriu o dialogo (pcForm do legado)
369:     * par_cCursorCaixa       - alias do cursor de totais de caixa
370:     * par_cCursorCaixaItens  - alias do cursor de totais por item
371:     * par_cCursorCaixaFin    - alias do cursor de totais financeiros
372:     * par_cCursorMapaResumo  - alias do cursor do mapa resumo fiscal
373:     * par_cEmps              - codigo da empresa (Get_emps.Value no legado)
374:     * par_dDatas             - data do movimento (Get_datas.Value no legado)
375:     *
376:     * Todos os parametros APOS par_oFormPai sao opcionais: o que nao vier
377:     * explicito e completado por ResolverContextoDoPai() lendo candidatos
378:     * defensivos do proprio par_oFormPai. Sem nenhum dos dois, a tela ainda
379:     * abre (falha de dado nunca impede a UI de aparecer) e
380:     * SIGOPDVMBO.GerarComparacao() simplesmente nao encontra o que comparar.
381:     *==========================================================================
382:     PROCEDURE Init(par_oFormPai, par_cCursorCaixa, par_cCursorCaixaItens, ;
383:             par_cCursorCaixaFin, par_cCursorMapaResumo, par_cEmps, par_dDatas)
384: 
385:         IF VARTYPE(par_oFormPai) = "O"
386:             THIS.this_oFormPai = par_oFormPai
387:         ENDIF
388: 
389:         IF VARTYPE(par_cCursorCaixa) = "C" AND !EMPTY(ALLTRIM(par_cCursorCaixa))
390:             THIS.this_cCursorCaixa = ALLTRIM(par_cCursorCaixa)
391:         ENDIF
392:         IF VARTYPE(par_cCursorCaixaItens) = "C" AND !EMPTY(ALLTRIM(par_cCursorCaixaItens))
393:             THIS.this_cCursorCaixaItens = ALLTRIM(par_cCursorCaixaItens)
394:         ENDIF
395:         IF VARTYPE(par_cCursorCaixaFin) = "C" AND !EMPTY(ALLTRIM(par_cCursorCaixaFin))
396:             THIS.this_cCursorCaixaFin = ALLTRIM(par_cCursorCaixaFin)
397:         ENDIF
398:         IF VARTYPE(par_cCursorMapaResumo) = "C" AND !EMPTY(ALLTRIM(par_cCursorMapaResumo))
399:             THIS.this_cCursorMapaResumo = ALLTRIM(par_cCursorMapaResumo)
400:         ENDIF
401: 
402:         IF VARTYPE(par_cEmps) = "C" AND !EMPTY(ALLTRIM(par_cEmps))
403:             THIS.this_cEmps = ALLTRIM(par_cEmps)
404:         ENDIF
405:         IF INLIST(VARTYPE(par_dDatas), "D", "T")
406:             THIS.this_dDatas = ConverterParaData(par_dDatas)
407:         ENDIF
408: 
409:         *-- Completa o que faltou lendo do form pai (defensivo - PILAR 3
410:         *-- renomeia os objetos do pai, entao nada aqui pode estourar so
411:         *-- porque o pai usa outro nome de property)
412:         THIS.ResolverContextoDoPai()
413: 
414:         RETURN DODEFAULT()
415:     ENDPROC
416: 
417: 
418:     *==========================================================================
419:     * ResolverContextoDoPai - completa cursores/filtro a partir do form pai
420:     *
421:     * So entra em acao para o que NAO veio por parametro explicito de Init
422:     * (par_c* / par_d* tem precedencia). Cada leitura e guardada por
423:     * PEMSTATUS/TYPE - ausencia simplesmente mantem o default, nunca
424:     * estoura.
425:     *==========================================================================
426:     PROCEDURE ResolverContextoDoPai()
427:         LOCAL loc_cValor, loc_dValor
428: 
429:         IF VARTYPE(THIS.this_oFormPai) != "O"
430:             RETURN .F.
431:         ENDIF
432: 
433:         IF EMPTY(ALLTRIM(THIS.this_cCursorCaixa))
434:             THIS.this_cCursorCaixa = THIS.LerTextoDoPai("this_cCursorCaixa")
435:         ENDIF
436:         IF EMPTY(ALLTRIM(THIS.this_cCursorCaixaItens))
437:             THIS.this_cCursorCaixaItens = THIS.LerTextoDoPai("this_cCursorCaixaItens")
438:         ENDIF
439:         IF EMPTY(ALLTRIM(THIS.this_cCursorCaixaFin))
440:             THIS.this_cCursorCaixaFin = THIS.LerTextoDoPai("this_cCursorCaixaFin")
441:         ENDIF
442:         IF EMPTY(ALLTRIM(THIS.this_cCursorMapaResumo))
443:             THIS.this_cCursorMapaResumo = THIS.LerTextoDoPai("this_cCursorMapaResumo")
444:         ENDIF
445: 
446:         IF EMPTY(ALLTRIM(THIS.this_cEmps))
447:             loc_cValor = THIS.LerTextoDoPai("this_cEmps")
448:             IF EMPTY(loc_cValor)
449:                 loc_cValor = THIS.LerTextoDoPai("this_cCodEmpresa")
450:             ENDIF
451:             THIS.this_cEmps = loc_cValor
452:         ENDIF
453: 
454:         IF EMPTY(THIS.this_dDatas)
455:             loc_dValor = THIS.LerDataDoPai("this_dDatas")
456:             IF EMPTY(loc_dValor)
457:                 loc_dValor = THIS.LerDataDoPai("this_dData")
458:             ENDIF
459:             THIS.this_dDatas = loc_dValor
460:         ENDIF
461: 
462:         RETURN .T.
463:     ENDPROC
464: 
465: 
466:     *==========================================================================
467:     * LerTextoDoPai - leitura DEFENSIVA de uma property texto do form pai
468:     *
469:     * Acesso por NOME via EVALUATE - nunca Controls(<nome>), que e indexado
470:     * por NUMERO (regra #34). Sem TRY/CATCH de proposito: os guards
471:     * (PEMSTATUS + TYPE) ja cobrem ausencia e referencia morta, e um CATCH
472:     * aqui seria silencioso - engolir erro sem avisar e proibido (regra #9).
473:     *==========================================================================
474:     PROCEDURE LerTextoDoPai(par_cProperty)
475:         LOCAL loc_cRetorno, loc_cExpr
476: 
477:         loc_cRetorno = ""
478: 
479:         IF VARTYPE(THIS.this_oFormPai) != "O" OR VARTYPE(par_cProperty) != "C"
480:             RETURN ""
481:         ENDIF
482: 
483:         IF PEMSTATUS(THIS.this_oFormPai, ALLTRIM(par_cProperty), 5)
484:             loc_cExpr = "THIS.this_oFormPai." + ALLTRIM(par_cProperty)
485:             IF TYPE(loc_cExpr) = "C"
486:                 loc_cRetorno = ALLTRIM(NVL(EVALUATE(loc_cExpr), ""))
487:             ENDIF
488:         ENDIF
489: 
490:         RETURN loc_cRetorno
491:     ENDPROC
492: 
493: 
494:     *==========================================================================
495:     * LerDataDoPai - leitura DEFENSIVA de uma property data do form pai
496:     *==========================================================================
497:     PROCEDURE LerDataDoPai(par_cProperty)
498:         LOCAL loc_dRetorno, loc_cExpr
499: 
500:         loc_dRetorno = {}
501: 
502:         IF VARTYPE(THIS.this_oFormPai) != "O" OR VARTYPE(par_cProperty) != "C"
503:             RETURN {}
504:         ENDIF
505: 
506:         IF PEMSTATUS(THIS.this_oFormPai, ALLTRIM(par_cProperty), 5)
507:             loc_cExpr = "THIS.this_oFormPai." + ALLTRIM(par_cProperty)
508:             IF INLIST(TYPE(loc_cExpr), "D", "T")
509:                 loc_dRetorno = ConverterParaData(EVALUATE(loc_cExpr))
510:             ENDIF
511:         ENDIF
512: 
513:         RETURN loc_dRetorno
514:     ENDPROC
515: 
516: 
517:     *==========================================================================
518:     * InicializarForm - monta a estrutura base do dialogo
519:     *
520:     * RETURN de bloqueio FORA do TRY (regra #1: nunca RETURN dentro de
521:     * TRY/CATCH).
522:     *==========================================================================
523:     PROTECTED PROCEDURE InicializarForm()
524:         LOCAL loc_lSucesso, loc_oErro
525: 
526:         loc_lSucesso = .F.
527: 
528:         TRY
529:             *-- DataSession = 1 ja compartilha a sessao do pai (ver nota no
530:             *-- cabecalho do arquivo); os SETs de DATE/CENTURY ja foram
531:             *-- repostos por FormBase.Init() antes deste metodo rodar.
532: 
533:             THIS.this_oBusinessObject = CREATEOBJECT("SIGOPDVMBO")
534: 
535:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
536:                 *-- Contexto da comparacao (cursores + Empresa/Data). Falha
537:                 *-- aqui NAO aborta a tela - so fica sem o que comparar, e
538:                 *-- CarregarLista mostra a grade vazia (ver mais abaixo).
539:                 THIS.this_oBusinessObject.DefinirCursoresOrigem( ;
540:                     THIS.this_cCursorCaixa, THIS.this_cCursorCaixaItens, ;
541:                     THIS.this_cCursorCaixaFin, THIS.this_cCursorMapaResumo)
542:                 THIS.this_oBusinessObject.DefinirParametrosComparacao( ;
543:                     THIS.this_cEmps, THIS.this_dDatas)
544: 
545:                 *-- Fundo do form (new_background.jpg do dump)
546:                 THIS.ConfigurarPageFrame()
547: 
548:                 *-- Cabecalho cinza (cntSombra do legado)
549:                 THIS.ConfigurarCabecalho()
550: 
551:                 *-- Grid1 -> grd_4c_Dados (ainda SEM RecordSource/ControlSource -
552:                 *-- cursor_4c_Dados so existe apos GerarComparacao(), chamado
553:                 *-- por CarregarLista no fim deste metodo - regra #41)
554:                 THIS.ConfigurarGrid()
555: 
556:                 *-- Shape1 decorativo + CmdCat -> cmd_4c_Encerrar (mesma ordem
557:                 *-- de criacao do dump: Grid1 antes, Shape1 e CmdCat depois)
558:                 THIS.ConfigurarBotoes()
559: 
560:                 *-- AddObject cria tudo com Visible = .F.
561:                 THIS.TornarControlesVisiveis()
562: 
563:                 *-- Superficie de DADOS: confere as 7 colunas do dump e liga
564:                 *-- a grade ao cursor da comparacao. Roda DEPOIS de todos os
565:                 *-- AddObject (as colunas tem de existir) e e inerte quanto ao
566:                 *-- ControlSource enquanto o cursor nao existir (regra #41).
567:                 THIS.ConfigurarPaginaDados()
568: 
569:                 *-- Dado da tela. No legado isto roda DENTRO do proprio Init
570:                 *-- (os dois SCAN, o Index/Go Top e as 7 linhas de
571:                 *-- ControlSource), por isso tambem roda aqui e nao em evento
572:                 *-- de botao - esta tela nao tem botao que carregue nada.
573:                 *-- O retorno NAO entra em loc_lSucesso de proposito: falha de
574:                 *-- DADO nunca impede a UI de aparecer, e grade vazia e
575:                 *-- resultado valido (o legado abre igual quando nao ha
576:                 *-- divergencia entre caixa, itens e mapa resumo).
577:                 THIS.CarregarLista()
578: 
579:                 loc_lSucesso = .T.
580:             ELSE
581:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
582:                         "vel criar o objeto de neg" + CHR(243) + "cio SIGOPDVMBO.", ;
583:                         "Erro ao Inicializar")
584:             ENDIF
585: 
586:         CATCH TO loc_oErro
587:             THIS.this_cMensagemErro = loc_oErro.Message
588:             MsgErro(loc_oErro.Message + ;
589:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
590:                     " | Proc: " + loc_oErro.Procedure, ;
591:                     "Erro ao inicializar FormSIGOPDVM")
592:             loc_lSucesso = .F.
593:         ENDTRY
594: 
595:         RETURN loc_lSucesso
596:     ENDPROC
597: 
598: 
599:     *==========================================================================
600:     * ConfigurarPageFrame - aparencia base do form
601:     *
602:     * O nome e o do contrato do pipeline; NAO ha PageFrame a criar porque o
603:     * SCX legado nao tem Page nenhuma (layout FLAT - ver cabecalho do
604:     * arquivo). O que este metodo faz e o que de fato existe no dump: o
605:     * fundo do form.
606:     *
607:     * Picture = ..\framework\imagens\new_background.jpg no dump. O caminho
608:     * NUNCA se reconstroi a partir de gc_4c_CaminhoBase (regra #156/#170); o
609:     * canonico do projeto e gc_4c_CaminhoIcones (o arquivo existe em
610:     * vbmp\). Picture inexistente falha em SILENCIO (regra #25), por isso o
611:     * nome e transcrito do dump e nao chutado.
612:     *==========================================================================
613:     PROTECTED PROCEDURE ConfigurarPageFrame()
614:         THIS.Picture    = gc_4c_CaminhoIcones + "new_background.jpg"
615:         THIS.ScrollBars = 0
616: 
617:         RETURN .T.
618:     ENDPROC
619: 
620: 
621:     *==========================================================================
622:     * ConfigurarCabecalho - faixa cinza do topo (cntSombra do legado)
623:     *
624:     * Dump: cntSombra Top=0 Left=0 Width=800 Height=80 BackColor=100,100,100
625:     *       lblSombra Top=18 Height=40 Left=10 Width=769 ForeColor=0,0,0
626:     *       lblTitulo Top=17 Height=46 Left=10 Width=769 ForeColor=255,255,255
627:     *       ambos Tahoma 18 bold, BackStyle=0, Alignment=0, WordWrap=.T.
628:     *
629:     * Width=800 do container bate com o Width=800 do form - diferente de
630:     * outros dialogos da familia (onde o dump tinha 800 num form menor e
631:     * precisava de ajuste); aqui Left=10+Width=769=779 < 800, cabe sem
632:     * ajuste (regra #30 - controle fora da area do pai e recortado).
633:     *
634:     * Caption dos dois labels = THIS.Caption, nunca o literal "Cadastro de
635:     * Testes" do dump (placeholder do extrator) - mesmo padrao das demais
636:     * telas (regra #11).
637:     *
638:     * O cabecalho e o PRIMEIRO AddObject da tela (regra #11), para que
639:     * Shape/Grid/botao criados na Fase 4 desenhem POR CIMA dele.
640:     *==========================================================================
641:     PROTECTED PROCEDURE ConfigurarCabecalho()
642:         THIS.AddObject("cnt_4c_Sombra", "Container")
643:         WITH THIS.cnt_4c_Sombra
644:             .Top           = 0
645:             .Left          = 0
646:             .Width         = THIS.Width
647:             .Height        = 80
648:             .BorderWidth   = 0
649:             .BackStyle     = 1
650:             .BackColor     = RGB(100, 100, 100)
651:             .SpecialEffect = 0
652:             .Visible       = .T.
653:         ENDWITH
654: 
655:         *-- Label de sombra: preto, efeito de relevo 1px abaixo do titulo
656:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
657:         WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
658:             *-- AutoSize = .F. explicito: AutoSize e NO-OP em Label criado
659:             *-- por AddObject e, com WordWrap = .T., DESCARTA a Height e
660:             *-- corta o texto (regra #23).
661:             .AutoSize      = .F.
662:             .FontName      = "Tahoma"
663:             .FontSize      = 18
664:             .FontBold      = .T.
665:             .FontUnderline = .F.
666:             .WordWrap      = .T.
667:             .Alignment     = 0
668:             .BackStyle     = 0
669:             .Caption       = THIS.Caption
670:             .Top           = 18
671:             .Left          = 10
672:             .Width         = 769
673:             .Height        = 40
674:             .ForeColor     = RGB(0, 0, 0)
675:             *-- Rotation = 0 esta no dump; e o DEFAULT, atribuicao inerte,
676:             *-- transcrita por fidelidade literal (regra #49: diferente de
677:             *-- Format/InputMask vazios, aqui o dump declara um VALOR).
678:             .Rotation      = 0
679:             .Visible       = .T.
680:         ENDWITH
681: 

*-- Linhas 704 a 724:
704:         RETURN .T.
705:     ENDPROC
706: 
707: 
708:     *==========================================================================
709:     * ConfigurarGrid - Grid1 -> grd_4c_Dados (7 colunas do dump)
710:     *
711:     * Dump: Grid1 Top=94 Left=94 Width=611 Height=92 ColumnCount=7
712:     *       FontName=Tahoma FontSize=8 AllowHeaderSizing=.F.
713:     *       AllowRowSizing=.F. DeleteMark=.F. ReadOnly=.T. RowHeight=16
714:     *       ScrollBars=2. RecordMark=.F. nao esta no dump mas e a
715:     *       convencao de grid manual em form OPERACIONAL (ver memoria
716:     *       CLAUDE.md sobre Grid RecordMark/DeleteMark).
717:     *
718:     * ColumnOrder visual (NAO e a ordem de declaracao Column1..Column7):
719:     *   Column7 (Caixa, Width=33) aparece PRIMEIRO (ColumnOrder=1), depois
720:     *   Column1 (Valor) .. Column6 (Diferenca IT) na ordem 2..7.
721:     *
722:     * NAO atribuir RecordSource nem Column.ControlSource aqui - o cursor de
723:     * destino (cursor_4c_Dados) so existe apos SIGOPDVMBO.GerarComparacao()
724:     * rodar, na Fase 8 (regra #41 - ControlSource de cursor inexistente

*-- Linhas 731 a 775:
731:     * property de design-time Comment="999,999.99" (nao e InputMask - regra
732:     * #49, transcrever o que o dump declara, nunca completar por analogia).
733:     * Column7 (Caixa) e texto, sem InputMask.
734:     *==========================================================================
735:     PROTECTED PROCEDURE ConfigurarGrid()
736:         THIS.AddObject("grd_4c_Dados", "Grid")
737:         WITH THIS.grd_4c_Dados
738:             .Top               = 94
739:             .Left              = 94
740:             .Width             = 611
741:             .Height            = 92
742:             .ColumnCount       = 7
743:             .FontName          = "Tahoma"
744:             .FontSize          = 8
745:             .AllowHeaderSizing = .F.
746:             .AllowRowSizing    = .F.
747:             .DeleteMark        = .F.
748:             .RecordMark        = .F.
749:             .Panel             = 1
750:             .ReadOnly          = .T.
751:             .RowHeight         = 16
752:             .ScrollBars        = 2
753:             .Visible           = .T.
754:         ENDWITH
755: 
756:         *-- Column1 (Valor) - ColumnOrder=2
757:         WITH THIS.grd_4c_Dados.Column1
758:             .FontName    = "Tahoma"
759:             .FontSize    = 8
760:             .ColumnOrder = 2
761:             .Width       = 90
762:             .Movable     = .F.
763:             .Resizable   = .F.
764:             .ReadOnly    = .T.
765:             .InputMask   = "999,999.99"
766:             WITH .Header1
767:                 .FontName  = "Tahoma"
768:                 .FontSize  = 8
769:                 .Alignment = 2
770:                 .Caption   = "Valor"
771:                 .ForeColor = RGB(36, 84, 155)
772:             ENDWITH
773:             WITH .Text1
774:                 .FontName  = "Tahoma"
775:                 .FontSize  = 8

*-- Linhas 781 a 801:
781:                 .BackColor = RGB(255, 255, 255)
782:             ENDWITH
783:         ENDWITH
784: 
785:         *-- Column2 (Itens) - ColumnOrder=3
786:         WITH THIS.grd_4c_Dados.Column2
787:             .FontName    = "Tahoma"
788:             .FontSize    = 8
789:             .ColumnOrder = 3
790:             .Width       = 90
791:             .Movable     = .F.
792:             .Resizable   = .F.
793:             .ReadOnly    = .T.
794:             .InputMask   = "999,999.99"
795:             WITH .Header1
796:                 .FontName  = "Tahoma"
797:                 .FontSize  = 8
798:                 .Alignment = 2
799:                 .Caption   = "Itens"
800:                 .ForeColor = RGB(36, 84, 155)
801:             ENDWITH

*-- Linhas 810 a 830:
810:                 .BackColor = RGB(255, 255, 255)
811:             ENDWITH
812:         ENDWITH
813: 
814:         *-- Column3 (Mapa) - ColumnOrder=4
815:         WITH THIS.grd_4c_Dados.Column3
816:             .FontName    = "Tahoma"
817:             .FontSize    = 8
818:             .ColumnOrder = 4
819:             .Width       = 90
820:             .Movable     = .F.
821:             .Resizable   = .F.
822:             .ReadOnly    = .T.
823:             .InputMask   = "999,999.99"
824:             WITH .Header1
825:                 .FontName  = "Tahoma"
826:                 .FontSize  = 8
827:                 .Alignment = 2
828:                 .Caption   = "Mapa"
829:                 .ForeColor = RGB(36, 84, 155)
830:             ENDWITH

*-- Linhas 839 a 859:
839:                 .BackColor = RGB(255, 255, 255)
840:             ENDWITH
841:         ENDWITH
842: 
843:         *-- Column4 (Nao Fiscal) - ColumnOrder=5
844:         WITH THIS.grd_4c_Dados.Column4
845:             .FontName    = "Tahoma"
846:             .FontSize    = 8
847:             .ColumnOrder = 5
848:             .Width       = 90
849:             .Movable     = .F.
850:             .Resizable   = .F.
851:             .ReadOnly    = .T.
852:             .InputMask   = "999,999.99"
853:             WITH .Header1
854:                 .FontName  = "Tahoma"
855:                 .FontSize  = 8
856:                 .Alignment = 2
857:                 .Caption   = "N" + CHR(227) + "o Fiscal"
858:                 .ForeColor = RGB(36, 84, 155)
859:             ENDWITH

*-- Linhas 868 a 888:
868:                 .BackColor = RGB(255, 255, 255)
869:             ENDWITH
870:         ENDWITH
871: 
872:         *-- Column5 (Diferenca Mr) - ColumnOrder=6
873:         WITH THIS.grd_4c_Dados.Column5
874:             .FontName    = "Tahoma"
875:             .FontSize    = 8
876:             .ColumnOrder = 6
877:             .Width       = 90
878:             .Movable     = .F.
879:             .Resizable   = .F.
880:             .ReadOnly    = .T.
881:             .InputMask   = "999,999.99"
882:             WITH .Header1
883:                 .FontName  = "Tahoma"
884:                 .FontSize  = 8
885:                 .Alignment = 2
886:                 .Caption   = "Diferen" + CHR(231) + "a Mr"
887:                 .ForeColor = RGB(36, 84, 155)
888:             ENDWITH

*-- Linhas 898 a 918:
898:             ENDWITH
899:         ENDWITH
900: 
901:         *-- Column6 (Diferenca IT) - ColumnOrder=7 - SEM InputMask no dump
902:         *-- (ver nota no cabecalho do metodo)
903:         WITH THIS.grd_4c_Dados.Column6
904:             .FontName    = "Tahoma"
905:             .FontSize    = 8
906:             .ColumnOrder = 7
907:             .Width       = 90
908:             .Movable     = .F.
909:             .Resizable   = .F.
910:             .ReadOnly    = .T.
911:             WITH .Header1
912:                 .FontName  = "Tahoma"
913:                 .FontSize  = 8
914:                 .Alignment = 2
915:                 .Caption   = "Diferen" + CHR(231) + "a IT"
916:                 .ForeColor = RGB(36, 84, 155)
917:             ENDWITH
918:             WITH .Text1

*-- Linhas 925 a 945:
925:                 .BackColor   = RGB(255, 255, 255)
926:             ENDWITH
927:         ENDWITH
928: 
929:         *-- Column7 (Caixa) - ColumnOrder=1 (primeira visualmente), texto
930:         WITH THIS.grd_4c_Dados.Column7
931:             .FontName    = "Tahoma"
932:             .FontSize    = 8
933:             .ColumnOrder = 1
934:             .Width       = 33
935:             .Movable     = .F.
936:             .Resizable   = .F.
937:             .ReadOnly    = .T.
938:             WITH .Header1
939:                 .FontName  = "Tahoma"
940:                 .FontSize  = 8
941:                 .Alignment = 2
942:                 .Caption   = "Caixa"
943:                 .ForeColor = RGB(36, 84, 155)
944:             ENDWITH
945:             WITH .Text1

*-- Linhas 976 a 1019:
976:     * Acesso a membro por NOME montado em runtime: EVALUATE para LEITURA
977:     * (regra #15/#34) - NUNCA Controls(<nome>), que e indexado por numero.
978:     *==========================================================================
979:     PROTECTED PROCEDURE ConfigurarPaginaDados()
980:         LOCAL loc_nI, loc_cCol, loc_lEstruturaOk
981: 
982:         loc_lEstruturaOk = .F.
983: 
984:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
985:             loc_lEstruturaOk = (THIS.grd_4c_Dados.ColumnCount = 7)
986: 
987:             FOR loc_nI = 1 TO 7
988:                 loc_cCol = "THIS.grd_4c_Dados.Column" + TRANSFORM(loc_nI)
989:                 IF EVALUATE("VARTYPE(" + loc_cCol + ")") != "O"
990:                     loc_lEstruturaOk = .F.
991:                 ENDIF
992:             ENDFOR
993:         ENDIF
994: 
995:         IF loc_lEstruturaOk
996:             *-- Vinculo das 7 colunas. GUARDADO por USED() la dentro: em tempo
997:             *-- de Init o cursor da comparacao ainda nao existe e atribuir
998:             *-- ControlSource aqui derrubaria a tela (regra #41). O vinculo
999:             *-- real acontece em CarregarLista, que chama VincularColunasGrade
1000:             *-- DEPOIS de SIGOPDVMBO.GerarComparacao() popular o cursor.
1001:             THIS.VincularColunasGrade()
1002:         ELSE
1003:             MsgErro("A grade de compara" + CHR(231) + CHR(227) + "o n" + ;
1004:                     CHR(227) + "o foi criada com as 7 colunas do cadastro.", ;
1005:                     "Erro na Superf" + CHR(237) + "cie de Dados")
1006:         ENDIF
1007: 
1008:         RETURN loc_lEstruturaOk
1009:     ENDPROC
1010: 
1011: 
1012:     *==========================================================================
1013:     * VincularColunasGrade - liga as 7 colunas ao cursor da comparacao
1014:     *
1015:     * Transcricao das 7 linhas de ControlSource que o Init legado executa
1016:     * depois de montar crImpressao:
1017:     *
1018:     *    Grid1.Column1.ControlSource = 'crImpressao.ValCxs'
1019:     *    Grid1.Column2.ControlSource = 'crImpressao.ValItens'

*-- Linhas 1054 a 1170:
1054:     * Fecha com GO TOP + Refresh: popular/religar cursor NAO repinta a grade
1055:     * sozinho (regra #21a) - o legado tambem faz "Go Top" antes de vincular.
1056:     *==========================================================================
1057:     PROCEDURE VincularColunasGrade()
1058:         LOCAL loc_cCursor, loc_lVinculou, loc_oErro
1059: 
1060:         loc_lVinculou = .F.
1061:         loc_cCursor   = "cursor_4c_Dados"
1062: 
1063:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1064:             IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cCursorDestino))
1065:                 loc_cCursor = ALLTRIM(THIS.this_oBusinessObject.this_cCursorDestino)
1066:             ENDIF
1067:         ENDIF
1068: 
1069:         IF USED(loc_cCursor)
1070:             TRY
1071:                 WITH THIS.grd_4c_Dados
1072:                     .ColumnCount  = 7
1073:                     .RecordSource = loc_cCursor
1074: 
1075:                     .Column1.ControlSource = loc_cCursor + ".ValCxs"
1076:                     .Column2.ControlSource = loc_cCursor + ".ValItens"
1077:                     .Column3.ControlSource = loc_cCursor + ".ValMrs"
1078:                     .Column4.ControlSource = loc_cCursor + ".ValNfs"
1079:                     .Column5.ControlSource = loc_cCursor + ".ValCxs-" + loc_cCursor + ".ValMrs"
1080:                     .Column6.ControlSource = loc_cCursor + ".ValCxs-" + loc_cCursor + ".ValItens"
1081:                     .Column7.ControlSource = loc_cCursor + ".Caixas"
1082:                 ENDWITH
1083: 
1084:                 *-- Largura e caption DEPOIS do RecordSource/ControlSource, que
1085:                 *-- os resetam para 90 / "Header1" (Problema 48 / regra #41).
1086:                 *-- Fonte UNICA, compartilhada com o ramo de falha de
1087:                 *-- CarregarLista - ver AplicarColunasDoDump.
1088:                 THIS.AplicarColunasDoDump()
1089: 
1090:                 *-- Repinta a grade (regra #21a)
1091:                 SELECT (loc_cCursor)
1092:                 GO TOP
1093:                 THIS.grd_4c_Dados.Refresh()
1094: 
1095:                 loc_lVinculou = .T.
1096: 
1097:             CATCH TO loc_oErro
1098:                 THIS.this_cMensagemErro = loc_oErro.Message
1099:                 MsgErro(loc_oErro.Message + ;
1100:                         " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
1101:                         " | Proc: " + loc_oErro.Procedure, ;
1102:                         "Erro ao vincular a grade")
1103:             ENDTRY
1104:         ENDIF
1105: 
1106:         RETURN loc_lVinculou
1107:     ENDPROC
1108: 
1109: 
1110:     *==========================================================================
1111:     * AplicarColunasDoDump - largura e caption das 7 colunas
1112:     *
1113:     * Extraido de dentro de VincularColunasGrade para ser FONTE UNICA: existem
1114:     * DOIS caminhos que mexem em RecordSource (o vinculo e o desligamento do
1115:     * ramo de falha de CarregarLista), e atribuir RecordSource/ControlSource
1116:     * reseta Column.Width para o default 90 e Header1.Caption para "Header1"
1117:     * (Problema 48 / regra #41). Duas copias destes 14 valores divergiriam em
1118:     * silencio na primeira coluna que mudasse (CLAUDE.md #44, item 6).
1119:     *
1120:     * Valores transcritos do dump: Column7 (Caixa) Width = 33, as outras seis
1121:     * Width = 90. Reaplicar e seguro e inocuo - nenhuma destas propriedades
1122:     * depende de o cursor existir, por isso este metodo tambem serve ao ramo
1123:     * em que nao ha dado nenhum a exibir.
1124:     *
1125:     * ColumnOrder NAO e reaplicado aqui: ele e ordem VISUAL, nao dependente
1126:     * do RecordSource, e ja foi definido em ConfigurarGrid (Column7 = 1,
1127:     * Column1..Column6 = 2..7). Medido que RecordSource nao o altera -
1128:     * reaplica-lo seria assumir um reset que nao acontece.
1129:     *==========================================================================
1130:     PROTECTED PROCEDURE AplicarColunasDoDump()
1131:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
1132:             RETURN .F.
1133:         ENDIF
1134: 
1135:         WITH THIS.grd_4c_Dados
1136:             *-- Larguras do dump (Column7 = 33, as outras 6 = 90)
1137:             .Column1.Width = 90
1138:             .Column2.Width = 90
1139:             .Column3.Width = 90
1140:             .Column4.Width = 90
1141:             .Column5.Width = 90
1142:             .Column6.Width = 90
1143:             .Column7.Width = 33
1144: 
1145:             *-- Captions do dump
1146:             .Column1.Header1.Caption = "Valor"
1147:             .Column2.Header1.Caption = "Itens"
1148:             .Column3.Header1.Caption = "Mapa"
1149:             .Column4.Header1.Caption = "N" + CHR(227) + "o Fiscal"
1150:             .Column5.Header1.Caption = "Diferen" + CHR(231) + "a Mr"
1151:             .Column6.Header1.Caption = "Diferen" + CHR(231) + "a IT"
1152:             .Column7.Header1.Caption = "Caixa"
1153:         ENDWITH
1154: 
1155:         RETURN .T.
1156:     ENDPROC
1157: 
1158: 
1159:     *==========================================================================
1160:     * CarregarLista - funil UNICO de dado da tela
1161:     *
1162:     * Reproduz, na ORDEM do legado, o que o Init do SCX faz depois de receber
1163:     * pcForm:
1164:     *
1165:     *    1. Select crImpressao / Zap              -> GerarComparacao (BO)
1166:     *    2. os DOIS Scan da comparacao            -> GerarComparacao (BO)
1167:     *    3. Index On Caixas / Set Order / Go Top  -> GerarComparacao (BO)
1168:     *    4. Grid1.RecordSource + os 7 ControlSource -> VincularColunasGrade
1169:     *
1170:     * A ORDEM aqui e regra, nao estilo (regra #41): ControlSource de cursor

*-- Linhas 1183 a 1411:
1183:     * GerarComparacao RECUSOU a comparacao (faltou Empresa/Data ou faltou
1184:     * cursor de origem) - e so UMA vez por tela (this_lFalhaComparacaoAvisada),
1185:     * nunca em modo de teste, que nao tem os cursores do pai por construcao.
1186:     * MsgAviso, nao MsgErro: faltar o contexto do chamador e condicao de uso,
1187:     * nao excecao tecnica (o CATCH de GerarComparacao e que reporta erro real).
1188:     *
1189:     * PUBLIC (sem PROTECTED) de proposito: o harness de teste chama
1190:     * THIS.oForm.CarregarLista() de FORA da classe - PEMSTATUS devolveria .T.
1191:     * para metodo PROTECTED e a chamada real falharia so em runtime, com
1192:     * "Property CARREGARLISTA is not found" (regras #3 e #51).
1193:     *==========================================================================
1194:     PROCEDURE CarregarLista()
1195:         LOCAL loc_lSucesso, loc_cCursor, loc_lModoTeste, loc_lExistiaAntes
1196:         LOCAL loc_cMensagem
1197: 
1198:         loc_lSucesso = .F.
1199:         loc_cCursor  = "cursor_4c_Dados"
1200: 
1201:         loc_lModoTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
1202:                          (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)
1203: 
1204:         IF VARTYPE(THIS.this_oBusinessObject) != "O" OR !PEMSTATUS(THIS, "grd_4c_Dados", 5)
1205:             RETURN .F.
1206:         ENDIF
1207: 
1208:         *-- Alias vem do BO, nunca hardcoded, para nao divergir de quem o cria
1209:         IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cCursorDestino))
1210:             loc_cCursor = ALLTRIM(THIS.this_oBusinessObject.this_cCursorDestino)
1211:         ENDIF
1212: 
1213:         loc_lExistiaAntes = USED(loc_cCursor)
1214: 
1215:         IF THIS.this_oBusinessObject.GerarComparacao()
1216:             *-- Nao existia antes e existe agora = fomos NOS que criamos, logo
1217:             *-- somos nos que podemos fechar no Destroy.
1218:             IF !loc_lExistiaAntes AND USED(loc_cCursor)
1219:                 THIS.this_lCursorProprio = .T.
1220:             ENDIF
1221: 
1222:             loc_lSucesso = THIS.VincularColunasGrade()
1223:         ELSE
1224:             *-- Sem fonte, a grade fica SEM RecordSource - nunca apontando
1225:             *-- para o alias de uma abertura anterior. Exibir linha velha como
1226:             *-- se fosse o resultado desta consulta e pior que exibir vazio.
1227:             THIS.grd_4c_Dados.RecordSource = ""
1228: 
1229:             *-- Desligar o RecordSource tambem reseta largura/caption
1230:             *-- (Problema 48) - repor pela mesma fonte unica do vinculo.
1231:             THIS.AplicarColunasDoDump()
1232: 
1233:             loc_cMensagem = ALLTRIM(THIS.this_oBusinessObject.this_cMensagemErro)
1234: 
1235:             IF !loc_lModoTeste AND !THIS.this_lFalhaComparacaoAvisada ;
1236:                     AND !EMPTY(loc_cMensagem)
1237:                 THIS.this_lFalhaComparacaoAvisada = .T.
1238:                 MsgAviso(loc_cMensagem, "Diferen" + CHR(231) + ;
1239:                          "as Vendas x Mapa Resumo")
1240:             ENDIF
1241:         ENDIF
1242: 
1243:         *-- Repintar e OBRIGATORIO nos DOIS ramos: popular ou religar cursor
1244:         *-- nao redesenha a grade sozinho (regra #21a).
1245:         THIS.grd_4c_Dados.Refresh()
1246: 
1247:         RETURN loc_lSucesso
1248:     ENDPROC
1249: 
1250: 
1251:     *==========================================================================
1252:     * ConfigurarBotoes - Shape1 decorativo + CmdCat -> cmd_4c_Encerrar
1253:     *
1254:     * Dump: Shape1 Top=7 Left=698 Width=90 Height=110 BackStyle=0
1255:     *       BorderStyle=0 BorderColor=136,189,188. Left+Width=788 < 800
1256:     *       (regra #30 - controle fora do pai e recortado - cabe sem
1257:     *       ajuste).
1258:     *
1259:     * CmdCat Top=3 Left=725 Picture=cadastro_sair_60.jpg Cancel=.T.
1260:     *       Caption="Encerrar". Left+Width(725+75)=800 = Form.Width, encosta
1261:     *       exatamente na borda direita sem exceder. O botao fica dentro da
1262:     *       faixa do cabecalho (Top 0..80) de proposito - e desenhado DEPOIS
1263:     *       do cnt_4c_Sombra, logo aparece por cima (regra #11, mesmo
1264:     *       principio do bloco Saida dos forms CRUD).
1265:     *
1266:     * Width/Height=75x75 e Themes=.T.+DisabledPicture: nao vem do dump (a
1267:     * classe fwbtng do legado ja traz o tamanho via VCX), mas e o padrao
1268:     * canonico confirmado em outros dialogos OPERACIONAIS com botao
1269:     * standalone fora de container (FormSigPrGmi e demais - regra "standalone
1270:     * CommandButton com Picture precisa de Themes=.T. + DisabledPicture").
1271:     *
1272:     * Nome: o legado chama o metodo CmdCat.Click, mas o PILAR 3 pede nome
1273:     * NOVO e semantico - cmd_4c_Encerrar segue o canonico do projeto para
1274:     * botao de saida (nao cmd_4c_CmdCat, nome generico do mapeamento
1275:     * automatico).
1276:     *
1277:     * Fecha ligando o UNICO evento de controle do dump (CmdCat.Click) ao
1278:     * handler BtnEncerrarClick. O BINDEVENT fica no FIM deste metodo, depois
1279:     * do AddObject - antes dele o objeto nem existe e o bind estouraria.
1280:     *==========================================================================
1281:     PROTECTED PROCEDURE ConfigurarBotoes()
1282:         THIS.AddObject("shp_4c_Shape1", "Shape")
1283:         WITH THIS.shp_4c_Shape1
1284:             .Top         = 7
1285:             .Left        = 698
1286:             .Width       = 90
1287:             .Height      = 110
1288:             .BackStyle   = 0
1289:             .BorderStyle = 0
1290:             .BorderColor = RGB(136, 189, 188)
1291:             .Visible     = .T.
1292:         ENDWITH
1293: 
1294:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
1295:         WITH THIS.cmd_4c_Encerrar
1296:             .Top             = 3
1297:             .Left            = 725
1298:             .Height          = 75
1299:             .Width           = 75
1300:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1301:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1302:             .Cancel          = .T.
1303:             .Caption         = "Encerrar"
1304:             .FontName        = "Tahoma"
1305:             .FontBold        = .T.
1306:             .FontItalic      = .T.
1307:             .FontSize        = 8
1308:             .ForeColor       = RGB(90, 90, 90)
1309:             .BackColor       = RGB(255, 255, 255)
1310:             .Themes          = .T.
1311:             .SpecialEffect   = 0
1312:             .PicturePosition = 13
1313:             .MousePointer    = 15
1314:             .WordWrap        = .T.
1315:             .AutoSize        = .F.
1316:             .Visible         = .T.
1317:         ENDWITH
1318: 
1319:         *-- CmdCat.Click do legado. Alvo PUBLIC (regra #3): em metodo
1320:         *-- PROTECTED o BINDEVENT falha EM SILENCIO e o botao ficaria inerte
1321:         *-- sem erro nenhum.
1322:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
1323: 
1324:         RETURN .T.
1325:     ENDPROC
1326: 
1327: 
1328:     *==========================================================================
1329:     * BtnEncerrarClick - CmdCat.Click do legado
1330:     *
1331:     * O Click legado tem UMA linha, e esta e ela:
1332:     *
1333:     *     PROCEDURE Click
1334:     *     Release Windows
1335:     *
1336:     * "Release Windows" e o idioma Fortyus para FECHAR a tela - este SCX
1337:     * nunca escreve "ThisForm.Release" (e o unico Click do dump inteiro).
1338:     *
1339:     * A traducao fiel e THIS.Release(), nao THIS.Hide(): Hide() serve a
1340:     * dialogo cujo RESULTADO o chamador precisa ler DEPOIS do Show(), porque
1341:     * Release() destroi o objeto mesmo com variavel externa apontando para
1342:     * ele. Esta tela nao devolve nada - o SCX nao tem PROCEDURE Unload, nao
1343:     * tem property de retorno e o legado nao e aberto com "DO FORM ... TO
1344:     * <var>"; inventar um retorno (ou um Unload) seria caminho que o legado
1345:     * nao tem. Mesma decisao do precedente SIGOPCLP -> FormSigOpClp.
1346:     *
1347:     * NAO reabilita o form pai: outros dialogos filho desta familia fazem
1348:     * "ParentForm.Enabled = .t." aqui porque o legado DELES desabilita o pai
1349:     * no Init. Este nao desabilita (ver o contrato no cabecalho do arquivo),
1350:     * entao nao ha o que reabilitar - e mexer no Enabled de uma tela que nem
1351:     * foi migrada seria inventar comportamento.
1352:     *
1353:     * Atende tambem o ESC sem segundo handler: cmd_4c_Encerrar tem
1354:     * Cancel = .T. (transcrito do dump), e a tecla de cancelamento dispara o
1355:     * evento Click do proprio botao - o MESMO evento que o BINDEVENT acima
1356:     * intercepta.
1357:     *
1358:     * PUBLIC de proposito (sem PROTECTED): alvo de BINDEVENT (regra #3).
1359:     *==========================================================================
1360:     PROCEDURE BtnEncerrarClick()
1361:         THIS.Release()
1362:     ENDPROC
1363: 
1364: 
1365:     *==========================================================================
1366:     * TornarControlesVisiveis - AddObject cria tudo com Visible = .F.
1367:     *
1368:     * Mesmo padrao recursivo (1 nivel de filhos de container) usado no resto
1369:     * do projeto.
1370:     *==========================================================================
1371:     PROTECTED PROCEDURE TornarControlesVisiveis()
1372:         LOCAL loc_nI, loc_nJ, loc_oControle, loc_oFilho
1373: 
1374:         FOR loc_nI = 1 TO THIS.ControlCount
1375:             loc_oControle = THIS.Controls(loc_nI)
1376: 
1377:             IF VARTYPE(loc_oControle) = "O"
1378:                 IF PEMSTATUS(loc_oControle, "Visible", 5)
1379:                     loc_oControle.Visible = .T.
1380:                 ENDIF
1381: 
1382:                 IF PEMSTATUS(loc_oControle, "ControlCount", 5)
1383:                     FOR loc_nJ = 1 TO loc_oControle.ControlCount
1384:                         loc_oFilho = loc_oControle.Controls(loc_nJ)
1385:                         IF VARTYPE(loc_oFilho) = "O" AND PEMSTATUS(loc_oFilho, "Visible", 5)
1386:                             loc_oFilho.Visible = .T.
1387:                         ENDIF
1388:                     ENDFOR
1389:                 ENDIF
1390:             ENDIF
1391:         ENDFOR
1392: 
1393:         RETURN .T.
1394:     ENDPROC
1395: 
1396: 
1397:     *==========================================================================
1398:     * Destroy - fecha o cursor que esta tela criou e libera BO/form pai
1399:     *
1400:     * O cursor da comparacao e fechado SO quando this_lCursorProprio diz que
1401:     * foi este dialogo que o criou. A distincao e regra, nao zelo: no legado o
1402:     * crImpressao pertence ao form PAI (o Init legado so faz "Select
1403:     * crImpressao / Zap", nunca o cria) e, com DataSession = 1, um USE IN
1404:     * incondicional aqui fecharia o cursor do pai ao sair do dialogo -
1405:     * quebrando a tela que nos abriu, depois de o dialogo ja ter desaparecido.
1406:     * Quem mede a posse e CarregarLista (USED() antes de GerarComparacao
1407:     * contra USED() depois).
1408:     *
1409:     * RecordSource = "" ANTES do USE IN: a grade esta ligada ao alias e
1410:     * fecha-lo com o vinculo ativo e pedir problema. Os cursores de TRABALHO
1411:     * (crTotCaixa_4c e irmaos) nao aparecem aqui - GerarComparacao ja os fecha

*-- Linhas 1421 a 1456:
1421:     * reconstroi os popups do menu principal, e omiti-lo faz o menu encolher
1422:     * visualmente (regra do Destroy).
1423:     *==========================================================================
1424:     PROCEDURE Destroy()
1425:         LOCAL loc_cCursor
1426: 
1427:         IF THIS.this_lCursorProprio
1428:             loc_cCursor = "cursor_4c_Dados"
1429: 
1430:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1431:                 IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cCursorDestino))
1432:                     loc_cCursor = ALLTRIM(THIS.this_oBusinessObject.this_cCursorDestino)
1433:                 ENDIF
1434:             ENDIF
1435: 
1436:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1437:                 THIS.grd_4c_Dados.RecordSource = ""
1438:             ENDIF
1439: 
1440:             IF USED(loc_cCursor)
1441:                 USE IN (loc_cCursor)
1442:             ENDIF
1443: 
1444:             THIS.this_lCursorProprio = .F.
1445:         ENDIF
1446: 
1447:         THIS.this_oFormPai = .NULL.
1448: 
1449:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1450:             THIS.this_oBusinessObject = .NULL.
1451:         ENDIF
1452: 
1453:         DODEFAULT()
1454:     ENDPROC
1455: 
1456: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGOPDVMBO.prg):
*==============================================================================
* SIGOPDVMBO.prg
*
* Business Object para SIGOPDVM (Diferencas Vendas x Mapa Resumo)
*
* Este form NAO persiste em tabela propria: ele compara, para a empresa/data
* informados, os cursores ja carregados na data session do form pai
* (crCaixa, crCaixaI, crCaixaFIN, crSigFiMpi) e grava as diferencas no
* cursor crImpressao, que alimenta o Grid1.
*==============================================================================

DEFINE CLASS SIGOPDVMBO AS BusinessBase

    *-- Parametros recebidos do form pai (filtro da comparacao)
    this_cEmps = ""                 && Codigo da empresa (SigFiMpi.emps - char(3))
    this_dDatas = {}                && Data do movimento comparado

    *-- Propriedades do registro corrente de crImpressao (uma linha do Grid)
    this_cCaixas = ""               && Codigo do caixa (SigFiMpi.ncaixa - char(3))
    this_nValCxs = 0                && Valor apurado no caixa (crCaixa/crCaixaFIN)
    this_nValItens = 0              && Valor apurado nos itens (crCaixaI)
    this_nValMrs = 0                && Valor do mapa resumo (crSigFiMpi.VlContabil + Iss)
    this_nValNfs = 0                && Valor nao fiscal

    *-- Cursores de origem: aliases que o form/BO pai ja carregou na mesma
    *-- data session (crCaixa/crCaixaI/crCaixaFIN/crSigFiMpi no legado).
    *-- Ficam vazios por padrao - DefinirCursoresOrigem() os recebe do
    *-- chamador antes de GerarComparacao() rodar.
    this_cCursorCaixa = ""          && Totais por caixa  (Emps, Datas, Ecfs, Valos)
    this_cCursorCaixaItens = ""     && Totais por caixa, itens (mesmas 4 colunas)
    this_cCursorCaixaFin = ""       && Totais por caixa, financeiro (mesmas 4 colunas)
    this_cCursorMapaResumo = ""     && Mapa resumo fiscal (NCaixa, VlContabil, Iss, Isento)

    *-- Cursor de saida que alimenta o Grid1 (crImpressao no legado) -
    *-- este sim eh nosso, por isso tem nome e valor padrao proprios.
    this_cCursorDestino = "cursor_4c_Dados"

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        *-- Sem tabela persistida: a comparacao roda sobre cursores
        *-- ja presentes na data session do form pai.
        THIS.this_cTabela = ""
        THIS.this_cCampoChave = "Caixas"

        RETURN .T.
    ENDPROC

    *====================================================================
    * FASE 2/8 - METODOS DE ACESSO AO REGISTRO E GERACAO DA COMPARACAO
    *
    * ESCOPO DESTA FASE NESTE BO
    * --------------------------
    * O trio canonico de um BO de cadastro eh CarregarDoCursor() para ler a
    * linha, Inserir() para o INSERT e Atualizar() para o UPDATE. Este BO
    * nao tem tabela propria (THIS.this_cTabela = "" no Init, de proposito):
    * conferido no dump tasks\task726\SIGOPDVM_form_codigo_fonte.txt, o SCX
    * legado nao tem UMA LINHA de gravacao - zero TABLEUPDATE(, zero
    * .AddCursor(, zero Insert/Update/Delete contra tabela do SQL Server. O
    * UNICO "Insert Into" do legado grava no cursor crImpressao, que eh
    * resultado de CALCULO (comparacao Caixa x Itens x Mapa Resumo), nao
    * persistencia de cadastro.
    *
    * Por isso:
    *   - Inserir(), Atualizar() e ExecutarExclusao() ficam SEM override: o
    *     comportamento herdado de BusinessBase (recusar a operacao e
    *     reportar pelo ExibirFalha do Salvar - regra #20) ja eh o correto,
    *     porque nao existe tabela de destino para gravar. Escrever um
    *     INSERT/UPDATE aqui exigiria adivinhar colunas de uma tabela que
    *     nao existe.
    *   - RegistrarAuditoria() segue herdado pelo mesmo motivo: a base so a
    *     chama em operacao de ESCRITA (Inserir/Atualizar/ExecutarExclusao),
    *     e esta tela nao executa nenhuma.
    *   - ObterChavePrimaria() EH sobrescrito, porque a linha corrente da
    *     grade tem identidade (o codigo do caixa).
    *   - GerarComparacao() EH o metodo que de fato produz dados nesta
    *     tela: transcricao literal do SCAN em dois passos do Init legado
    *     (regra de formula/logica legado - transcrever, nunca reescrever),
    *     substituindo as referencias a pcForm.Pagina.Dados... por
    *     THIS.this_cEmps/this_dDatas e os cursores literais crCaixa/
    *     crCaixaI/crCaixaFIN/crSigFiMpi pelos aliases recebidos via
    *     DefinirCursoresOrigem().
    *
    * ESCOPO DE CADA METODO
    * ---------------------
    *   DefinirCursoresOrigem   recebe os 4 aliases do chamador
    *   DefinirParametrosComparacao  recebe Empresa/Data do chamador
    *   GerarComparacao         transcricao do Init legado - popula o cursor
    *                           de destino com as linhas divergentes
    *   CarregarDoCursor        le a linha corrente do cursor de destino
    *   LimparDados             zera as 5 propriedades de linha
    *   ObterChavePrimaria      codigo do caixa da linha corrente
    *====================================================================

    *====================================================================
    * DefinirCursoresOrigem - recebe os aliases dos cursores de origem
    *
    * par_cCursorCaixa       - crCaixa no legado (Emps, Datas, Ecfs, Valos)
    * par_cCursorCaixaItens  - crCaixaI no legado (mesmas 4 colunas)
    * par_cCursorCaixaFin    - crCaixaFIN no legado (mesmas 4 colunas)
    * par_cCursorMapaResumo  - crSigFiMpi no legado (NCaixa, VlContabil,
    *                          Iss, Isento), ja filtrado por Empresa/Data
    *                          por quem o carregou - este BO so faz SCAN
    *                          nele, igual ao legado.
    *
    * Os 4 parametros sao OBRIGATORIOS (sem eles GerarComparacao nao tem o
    * que comparar). VARTYPE eh conferido porque um alias ausente chega
    * como .F. (logico), nunca como string vazia.
    *
    * Retorno: .T. quando os 4 vieram como texto nao vazio; .F. caso
    * contrario, com this_cMensagemErro preenchido.
    *====================================================================
    PROCEDURE DefinirCursoresOrigem(par_cCursorCaixa, par_cCursorCaixaItens, ;
            par_cCursorCaixaFin, par_cCursorMapaResumo)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        THIS.this_cCursorCaixa = IIF(VARTYPE(par_cCursorCaixa) = "C", ;
            ALLTRIM(par_cCursorCaixa), "")
        THIS.this_cCursorCaixaItens = IIF(VARTYPE(par_cCursorCaixaItens) = "C", ;
            ALLTRIM(par_cCursorCaixaItens), "")
        THIS.this_cCursorCaixaFin = IIF(VARTYPE(par_cCursorCaixaFin) = "C", ;
            ALLTRIM(par_cCursorCaixaFin), "")
        THIS.this_cCursorMapaResumo = IIF(VARTYPE(par_cCursorMapaResumo) = "C", ;
            ALLTRIM(par_cCursorMapaResumo), "")

        IF EMPTY(THIS.this_cCursorCaixa) OR EMPTY(THIS.this_cCursorCaixaItens) OR ;
                EMPTY(THIS.this_cCursorCaixaFin) OR EMPTY(THIS.this_cCursorMapaResumo)
            THIS.this_cMensagemErro = "Os cursores de caixa, itens, financeiro e " + ;
                "mapa resumo s" + CHR(227) + "o obrigat" + CHR(243) + "rios."
        ELSE
            THIS.this_cMensagemErro = ""
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * DefinirParametrosComparacao - recebe Empresa e Data do chamador
    *
    * par_cEmps  - pcForm.Pagina.Dados.PageFrame1.Page1.Get_emps.Value no
    *              legado (char(3))
    * par_dDatas - pcForm.Pagina.Dados.PageFrame1.Page1.Get_datas.Value no
    *              legado (data do movimento comparado)
    *
    * VARTYPE eh conferido em par_cEmps porque TextBox.Value pode chegar
    * como .F. quando o controle nasceu sem inicializacao, e ALLTRIM de
    * logico dispara o erro 11 do VFP9. par_dDatas aceita DATE ou DATETIME
    * (ConverterParaData normaliza os dois - regra #16, TTOD so aceita
    * DATETIME).
    *
    * Retorno: .T. quando os dois vieram preenchidos; .F. caso contrario,
    * com this_cMensagemErro preenchido.
    *====================================================================
    PROCEDURE DefinirParametrosComparacao(par_cEmps, par_dDatas)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        THIS.this_cEmps = IIF(VARTYPE(par_cEmps) = "C", ALLTRIM(par_cEmps), "")
        THIS.this_dDatas = ConverterParaData(par_dDatas)

        IF EMPTY(THIS.this_cEmps) OR EMPTY(THIS.this_dDatas)
            THIS.this_cMensagemErro = "Informe Empresa e Data antes de comparar " + ;
                "Vendas x Mapa Resumo."
        ELSE
            THIS.this_cMensagemErro = ""
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * GerarComparacao - transcricao do Init legado (os dois SCAN)
    *
    * PASSO 1 (SCAN em crSigFiMpi): para cada caixa do mapa resumo, soma
    * Valos de crCaixa/crCaixaI/crCaixaFIN filtrados por Empresa + Data +
    * SUBSTR(Ecfs,1,3) = NCaixa. Se o total contabil (VlContabil + Iss +
    * Isento) nao bate com o total do caixa, OU o total do caixa nao bate
    * com o total dos itens, grava uma linha em crImpressao com
    * ValCxs = TotalCaixa - TotalFinanceiro (regra do legado: o financeiro
    * eh DESCONTADO do caixa, nao somado - regra #17, transcrever sem
    * reescrever).
    *
    * PASSO 2 (SCAN no total geral de crCaixa por caixa): cobre o caso
    * oposto - caixa com movimento mas SEM nenhuma linha no mapa resumo
    * (Locate For NCaixa = Caixa / Eof()). Aqui ValCxs eh o total do caixa
    * SEM descontar o financeiro (o legado nao desconta neste ramo - essa
    * assimetria eh regra de negocio, nao erro de transcricao) e ValMrs
    * fica 0.
    *
    * Os cursores de trabalho (equivalentes a crTotCaixa/crTotCaixaI/
    * crTotCaixaFIN do legado) usam sufixo _4c_ proprio e sao fechados no
    * fim do metodo - nao sao cursores que sobrevivem ao form.
    *
    * SELECT (loc_cMapa) + SCAN leem os campos pelo nome NU (NCaixa,
    * VlContabil, Iss, Isento) porque a area de trabalho corrente eh a do
    * cursor - a sintaxe campo nao existe em VFP9. Dentro das
    * SELECT...INTO CURSOR as variaveis locais entram com o prefixo "m."
    * (regra: SELECT VFP local referenciando var local sem "m." estoura
    * "Column ... is not found").
    *
    * Retorno: .T. quando a comparacao rodou (mesmo que zero linhas
    * divergentes tenham sido encontradas - lista vazia eh resultado
    * valido, nao erro); .F. quando faltou parametro/cursor de origem ou
    * SELECT/SCAN estourou, com this_cMensagemErro preenchido.
    *====================================================================
    PROCEDURE GerarComparacao()
        LOCAL loc_lSucesso, loc_cCaixa, loc_cItens, loc_cFin, loc_cMapa, loc_cDestino
        LOCAL loc_cAliasAnterior, loc_dData, loc_cEmps
        LOCAL loc_cCaixaAtual, loc_nVlContabil, loc_nIss, loc_nIsento
        LOCAL loc_nValCxs, loc_nValCxsFin, loc_nValItens
        LOCAL loc_oErro

        loc_lSucesso = .F.
        loc_cAliasAnterior = ALIAS()

        loc_cCaixa   = ALLTRIM(THIS.this_cCursorCaixa)
        loc_cItens   = ALLTRIM(THIS.this_cCursorCaixaItens)
        loc_cFin     = ALLTRIM(THIS.this_cCursorCaixaFin)
        loc_cMapa    = ALLTRIM(THIS.this_cCursorMapaResumo)
        loc_cDestino = ALLTRIM(THIS.this_cCursorDestino)
        loc_cEmps    = ALLTRIM(THIS.this_cEmps)
        loc_dData    = THIS.this_dDatas

        TRY
            DO CASE
                CASE EMPTY(loc_cEmps) OR EMPTY(loc_dData)
                    THIS.this_cMensagemErro = "Informe Empresa e Data antes de " + ;
                        "comparar Vendas x Mapa Resumo."

                CASE EMPTY(loc_cCaixa) OR !USED(loc_cCaixa) OR ;
                     EMPTY(loc_cItens) OR !USED(loc_cItens) OR ;
                     EMPTY(loc_cFin) OR !USED(loc_cFin) OR ;
                     EMPTY(loc_cMapa) OR !USED(loc_cMapa)
                    THIS.this_cMensagemErro = "Os cursores de caixa e mapa " + ;
                        "resumo n" + CHR(227) + "o foram recebidos da tela de origem."

                CASE EMPTY(loc_cDestino)
                    THIS.this_cMensagemErro = "Cursor de destino da compara" + ;
                        CHR(231) + CHR(227) + "o n" + CHR(227) + "o definido."

                OTHERWISE
                    *-- Select crImpressao / Zap do legado - recria se nao
                    *-- existir, esvazia se ja existir (mesma estrutura em
                    *-- cada ponto de criacao - regra de CREATE CURSOR).
                    IF USED(loc_cDestino)
                        SELECT (loc_cDestino)
                        ZAP
                    ELSE
                        CREATE CURSOR (loc_cDestino) ;
                            (Datas T, Emps C(3), Caixas C(3), ValCxs N(14,2), ;
                             ValItens N(14,2), ValMrs N(14,2), ValNfs N(14,2))
                    ENDIF

                    IF USED("crTotCaixa_4c")
                        USE IN crTotCaixa_4c
                    ENDIF
                    IF USED("crTotCaixaI_4c")
                        USE IN crTotCaixaI_4c
                    ENDIF
                    IF USED("crTotCaixaFIN_4c")
                        USE IN crTotCaixaFIN_4c
                    ENDIF
                    IF USED("crTotCaixaGeral_4c")
                        USE IN crTotCaixaGeral_4c
                    ENDIF
                    IF USED("crTotCaixaI2_4c")
                        USE IN crTotCaixaI2_4c
                    ENDIF

                    *-- PASSO 1 - Scan crSigFiMpi (legado: "Select crSigFiMpi / Scan")
                    SELECT (loc_cMapa)
                    SCAN
                        loc_cCaixaAtual = NCaixa
                        loc_nVlContabil = TratarNulo(VlContabil, 0)
                        loc_nIss = TratarNulo(Iss, 0)
                        loc_nIsento = TratarNulo(Isento, 0)

                        SELECT SUBSTR(Ecfs, 1, 3) AS cCaixas, SUM(Valos) AS Valos ;
                            FROM (loc_cCaixa) ;
                            WHERE Emps = m.loc_cEmps ;
                              AND Datas = m.loc_dData ;
                              AND SUBSTR(Ecfs, 1, 3) = m.loc_cCaixaAtual ;
                            GROUP BY 1 INTO CURSOR crTotCaixa_4c READWRITE
                        loc_nValCxs = TratarNulo(crTotCaixa_4c.Valos, 0)

                        SELECT SUBSTR(Ecfs, 1, 3) AS cCaixas, SUM(Valos) AS Valos ;
                            FROM (loc_cItens) ;
                            WHERE Emps = m.loc_cEmps ;
                              AND Datas = m.loc_dData ;
                              AND SUBSTR(Ecfs, 1, 3) = m.loc_cCaixaAtual ;
                            GROUP BY 1 INTO CURSOR crTotCaixaI_4c READWRITE
                        loc_nValItens = TratarNulo(crTotCaixaI_4c.Valos, 0)

                        SELECT SUBSTR(Ecfs, 1, 3) AS cCaixas, SUM(Valos) AS Valos ;
                            FROM (loc_cFin) ;
                            WHERE Emps = m.loc_cEmps ;
                              AND Datas = m.loc_dData ;
                              AND SUBSTR(Ecfs, 1, 3) = m.loc_cCaixaAtual ;
                            GROUP BY 1 INTO CURSOR crTotCaixaFIN_4c READWRITE
                        loc_nValCxsFin = TratarNulo(crTotCaixaFIN_4c.Valos, 0)

                        IF ROUND(loc_nVlContabil, 2) + ROUND(loc_nIss, 2) + ;
                                ROUND(loc_nIsento, 2) <> ROUND(loc_nValCxs, 2) OR ;
                                ROUND(loc_nValCxs, 2) <> ROUND(loc_nValItens, 2)
                            INSERT INTO (loc_cDestino) ;
                                (Datas, Emps, Caixas, ValCxs, ValItens, ValMrs) ;
                                VALUES (loc_dData, loc_cEmps, loc_cCaixaAtual, ;
                                    loc_nValCxs - loc_nValCxsFin, loc_nValItens, ;
                                    loc_nVlContabil + loc_nIss)
                        ENDIF

                        SELECT (loc_cMapa)
                    ENDSCAN

                    *-- PASSO 2 - total geral de crCaixa por caixa (legado repete
                    *-- o mesmo Select, sem o filtro de NCaixa, antes do 2o Scan)
                    SELECT SUBSTR(Ecfs, 1, 3) AS cCaixas, SUM(Valos) AS Valos ;
                        FROM (loc_cCaixa) ;
                        WHERE Emps = m.loc_cEmps ;
                          AND Datas = m.loc_dData ;
                        GROUP BY 1 INTO CURSOR crTotCaixaGeral_4c READWRITE

                    SELECT crTotCaixaGeral_4c
                    SCAN
                        loc_cCaixaAtual = cCaixas
                        loc_nValCxs = TratarNulo(Valos, 0)

                        SELECT (loc_cMapa)
                        LOCATE FOR NCaixa = loc_cCaixaAtual

                        IF EOF()
                            SELECT SUBSTR(Ecfs, 1, 3) AS cCaixas, SUM(Valos) AS Valos ;
                                FROM (loc_cItens) ;
                                WHERE Emps = m.loc_cEmps ;
                                  AND Datas = m.loc_dData ;
                                  AND SUBSTR(Ecfs, 1, 3) = m.loc_cCaixaAtual ;
                                GROUP BY 1 INTO CURSOR crTotCaixaI2_4c READWRITE
                            loc_nValItens = TratarNulo(crTotCaixaI2_4c.Valos, 0)

                            INSERT INTO (loc_cDestino) ;
                                (Datas, Emps, Caixas, ValCxs, ValItens, ValMrs) ;
                                VALUES (loc_dData, loc_cEmps, loc_cCaixaAtual, ;
                                    loc_nValCxs, loc_nValItens, 0)
                        ENDIF

                        SELECT crTotCaixaGeral_4c
                    ENDSCAN

                    *-- Select crImpressao / Index On Caixas Tag Caixas / Go Top
                    SELECT (loc_cDestino)
                    IF TAGNO("Caixas", "", loc_cDestino) = 0
                        INDEX ON Caixas TAG Caixas
                    ENDIF
                    SET ORDER TO TAG Caixas
                    GO TOP

                    IF USED("crTotCaixa_4c")
                        USE IN crTotCaixa_4c
                    ENDIF
                    IF USED("crTotCaixaI_4c")
                        USE IN crTotCaixaI_4c
                    ENDIF
                    IF USED("crTotCaixaFIN_4c")
                        USE IN crTotCaixaFIN_4c
                    ENDIF
                    IF USED("crTotCaixaGeral_4c")
                        USE IN crTotCaixaGeral_4c
                    ENDIF
                    IF USED("crTotCaixaI2_4c")
                        USE IN crTotCaixaI2_4c
                    ENDIF

                    THIS.this_cMensagemErro = ""
                    loc_lSucesso = .T.
            ENDCASE
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em GerarComparacao")
        ENDTRY

        *-- Devolve a area de trabalho de quem chamou (sessao compartilhada)
        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - le a linha corrente do cursor de destino
    *
    * par_cAliasCursor - alias a ler. Normalmente THIS.this_cCursorDestino,
    *                    mas fica parametrizado para manter a assinatura da
    *                    base (BusinessBase.CarregarDoCursor(pcCursor)).
    *
    * SELECT (alias) antes de tocar nos campos - a sintaxe campo
    * nao existe em VFP9. A area de trabalho anterior eh restaurada no fim
    * (sessao compartilhada com o chamador). A existencia de cada coluna eh
    * conferida com TYPE(alias + ".campo"), nunca com PEMSTATUS (que exige
    * objeto no 1o argumento e estoura com alias de cursor).
    *
    * Retorno: .T. quando havia linha e as 5 propriedades foram
    * preenchidas; .F. quando o alias nao existe, esta em EOF/BOF ou nao
    * tem a estrutura esperada - nesse caso as propriedades sao zeradas.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_cAliasAnterior, loc_oErro

        loc_lSucesso = .F.
        loc_cAliasAnterior = ALIAS()
        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "")

        IF EMPTY(loc_cAlias)
            loc_cAlias = ALLTRIM(THIS.this_cCursorDestino)
        ENDIF

        TRY
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias) ;
                    AND TYPE(loc_cAlias + ".Caixas") != "U" ;
                    AND TYPE(loc_cAlias + ".ValCxs") != "U" ;
                    AND TYPE(loc_cAlias + ".ValItens") != "U" ;
                    AND TYPE(loc_cAlias + ".ValMrs") != "U" ;
                    AND TYPE(loc_cAlias + ".ValNfs") != "U"

                SELECT (loc_cAlias)

                IF !EOF() AND !BOF()
                    THIS.this_cCaixas = ALLTRIM(TratarNulo(Caixas, ""))
                    THIS.this_nValCxs = TratarNulo(ValCxs, 0)
                    THIS.this_nValItens = TratarNulo(ValItens, 0)
                    THIS.this_nValMrs = TratarNulo(ValMrs, 0)
                    THIS.this_nValNfs = TratarNulo(ValNfs, 0)

                    loc_lSucesso = .T.
                ENDIF
            ENDIF

            IF !loc_lSucesso
                *-- Sem linha para ler: zera, para a tela nao exibir o resto
                *-- de uma leitura anterior como se fosse a linha atual.
                THIS.this_cCaixas = ""
                THIS.this_nValCxs = 0
                THIS.this_nValItens = 0
                THIS.this_nValMrs = 0
                THIS.this_nValNfs = 0
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDoCursor")
        ENDTRY

        *-- Devolve a area de trabalho de quem chamou (sessao compartilhada)
        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * LimparDados - zera as propriedades de linha
    *
    * DODEFAULT() limpa this_cMensagemErro na base. Os parametros da
    * comparacao (this_cEmps/this_dDatas) e os aliases dos cursores de
    * origem/destino NAO sao limpos aqui de proposito: eles identificam a
    * CONSULTA aberta na tela, nao a linha selecionada.
    *====================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCaixas = ""
        THIS.this_nValCxs = 0
        THIS.this_nValItens = 0
        THIS.this_nValMrs = 0
        THIS.this_nValNfs = 0
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - identidade da linha corrente da grade
    *
    * Sobrescreve o hook de BusinessBase. Continua PROTECTED porque na base
    * ele eh PROTECTED: de fora ninguem chama este metodo (regra #51).
    *
    * A chave eh o codigo do caixa (coluna unica, nao composta - diferente
    * da regra #42 de chave posicional concatenada, que nao se aplica aqui
    * porque so ha UM campo).
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCaixas)
    ENDPROC

ENDDEFINE

