# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [METODO-INEXISTENTE] Metodo 'THIS.SolicitarLiberacaoPrazo()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarPrazoNovo()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.GarantirPrazoNovoValidado()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpEnt.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2133 linhas total):

*-- Linhas 12 a 112:
12: *   Lparameters pEmp, pDop, pNum, pPrz, pFor, pMin, pDat, pBlqAlt, pMax
13: * Ela exibe o historico de datas de entrega da operacao (grade Gradevenc
14: * ligada a SigOpMvv), a data vigente (getAtual, somente leitura pelo
15: * "Procedure When / Return .f." do legado) e aceita a data nova (getNova).
16: * Confirmar arquiva a data que SAI em SigOpMvv e atualiza SigMvCab.PrazoEnts.
17: *
18: * FASE 3/8 - ESTRUTURA BASE. Entrega:
19: *   - DEFINE CLASS sobre FormBase com as propriedades visuais transcritas do
20: *     dump do SCX (Width/Height/BorderStyle/TitleBar/ControlBox/MaxButton/
21: *     MinButton/AlwaysOnTop/WindowType/DataSession/AutoCenter/ShowTips/Caption)
22: *   - Init() completo: recebe e guarda os 9 parametros do form pai na MESMA
23: *     ordem posicional do Lparameters legado, e delega a FormBase.Init() por
24: *     DODEFAULT(), que chama InicializarForm()
25: *   - InicializarForm(): instancia o SigOpEntBO das Fases 1-2, repassa-lhe os
26: *     parametros de negocio e monta a casca visual
27: *   - ConfigurarCabecalho(): a faixa cinza do topo (cntSombra do legado) com o
28: *     titulo duplicado - sombra preta atras, texto branco por cima
29: *   - SincronizarEscolhaPai(): le o pcEscolha do form PAI (o legado o consulta
30: *     em altera.Valid para decidir se atualiza SigMvCab)
31: *   - TornarControlesVisiveis() e Destroy()
32: *
33: * FASE 4/8 - GRADE DO HISTORICO E BOTOES DE ACAO. Entrega:
34: *   - ConfigurarGradeHistorico(): grd_4c_Dados, a Gradevenc do legado, com as
35: *     duas colunas Historico/Usuario transcritas do dump. O cursor vazio eh
36: *     criado ANTES do bind, pelo BO, que eh a fonte unica da estrutura
37: *   - ConfigurarBotoesAcao(): cmd_4c_Confirmar ("altera") e cmd_4c_Cancelar
38: *     ("sair"), os dois CommandButton soltos do legado
39: *   - CarregarLista(): funil UNICO de carga e repinte da grade, equivalente
40: *     ao bloco AddCursor + Requery + RecordSource + Refresh do Init legado
41: *   - no SigOpEntBO, as duas pecas de dados que faltavam para a grade:
42: *     CriarCursorHistorico() (CREATE CURSOR, fonte unica da estrutura) e
43: *     CarregarHistorico() (a consulta de SigOpMvv por EmpDopNcs)
44: *
45: * FASE 5/8 - CAMPOS DE DADOS E ORDEM DE TABULACAO. Entrega:
46: *   - ConfigurarCamposPrazo(): os QUATRO controles de dados que faltavam, que
47: *     sao TODOS os que o SCX tem fora da grade - lbl_4c_PrazoAtual (Say1),
48: *     txt_4c_PrazoAtual (getAtual), lbl_4c_PrazoNovo (Say2) e txt_4c_PrazoNovo
49: *     (getNova). O "Procedure When / Return .f." do getAtual legado vira
50: *     ReadOnly = .T. + TabStop = .F.
51: *   - SincronizarCamposPrazo(): funil UNICO de valores entre o BO e os dois
52: *     campos, reproduzindo o par que o legado repete no Init e no altera.Valid
53: *     (.getAtual.Value = .pPrz / .getNova.Value = Ctod(''))
54: *   - AplicarBloqueioAlteracao(): a metade "Enabled" do If ThisForm.Bloquear
55: *     do Init legado (getNova e Confirmar desligados quando pBlqAlt = .T.)
56: *   - Activate(): a outra metade daquele IF - o SetFocus inicial, que nesta
57: *     arquitetura nao pode ficar no InicializarForm porque ele roda DENTRO do
58: *     CREATEOBJECT, antes de qualquer Show()
59: *   - AplicarOrdemTabulacao(): o passe de TabIndex do dump, que so pode rodar
60: *     depois de TODOS os AddObject do form
61: *
62: * Com isso a superficie de dados do legado esta COMPLETA: o SCX nao tem nenhum
63: * outro controle de entrada (a arvore de objetos do dump traz exatamente dois
64: * BaseClass: textbox fora das colunas da grade). Por isso nao ha "parte 2" de
65: * campos para a Fase 6 - ela fica com as validacoes do getNova.Valid (faixa de
66: * prazo minimo/maximo contra SigCdOpe.DtEntrs e a autorizacao LIBPRZENT).
67: *
68: * FASE 7/8 - EVENTOS PRINCIPAIS DOS BOTOES. Entrega os TRES unicos eventos de
69: * controle que o legado tem (o dump traz 7 metodos com codigo: 2 do Form -
70: * Init/Load/Release -, 1 When do getAtual e os 3 destes controles):
71: *   - VincularEventos(): os BINDEVENT dos dois botoes ("Click") e do campo
72: *     da data nova ("LostFocus", porque BINDEVENT em "Valid" nao funciona em
73: *     TextBox e "KeyPress" perderia o caminho do mouse - regra #47)
74: *   - BtnConfirmarClick(): o corpo de altera.Valid - valida, leva os valores
75: *     dos campos ao BO, rele o modo do pai, manda gravar, devolve o resultado
76: *     a tela chamadora e repinta campos e grade. A tela NAO fecha, como no
77: *     legado
78: *   - BtnCancelarClick() + FecharDialogo(): o "ThisForm.Release" de
79: *     sair.Valid, fechando com Hide() para o resultado continuar legivel pelo
80: *     chamador (contrato de dialogo desta arquitetura - ver FecharDialogo)
81: *   - PrazoNovoLostFocus() e GarantirPrazoNovoValidado(): o encadeamento que
82: *     o VFP nativo dava de graca no legado (o Valid do campo TabIndex 1 roda
83: *     antes do Click do botao TabIndex 2 e, recusando, impede o clique), sem
84: *     validar duas vezes o mesmo valor - o que abriria DOIS pedidos de
85: *     autorizacao LIBPRZENT no mesmo clique
86: *   - NotificarFormPai() e ObterPrazoConfirmado(): as duas vias de devolucao
87: *     do novo prazo ao form pai (a escrita direta do legado, guardada por
88: *     PEMSTATUS, e a leitura pos-Show desta arquitetura)
89: *   - no SigOpEntBO, GravarAlteracaoPrazo(): a cadeia INSERT + UPDATE +
90: *     Commit/RollBack que o legado controla com a flag llOks. O Commit eh
91: *     passo com caminho de falha proprio, nao detalhe de infra - a conexao
92: *     deste ambiente nasce em transacao MANUAL e sem ele o gravado nao
93: *     persiste
94: *
95: * FASE 8/8 - CONSOLIDACAO FINAL. Entrega os hooks CANONICOS da arquitetura
96: * que ainda faltavam, com conteudo REAL - nenhum deles eh invencao: o corpo
97: * de cada um SAIU de onde estava escrito em linha nas fases anteriores, de
98: * modo que nao existem duas copias da mesma transferencia para divergirem em
99: * silencio (CLAUDE.md #44, item 6 - fonte unica):
100: *   - FormParaBO(): as duas primeiras linhas de altera.Valid, que leem os
101: *     campos antes de gravar (ldAnt = getAtual.Value / ldNew =
102: *     getNova.Value). Saiu de dentro de BtnConfirmarClick, que agora o chama
103: *     e NAO grava se ele recusar
104: *   - BOParaForm(): a volta - o "getAtual.Value = pPrz" do legado mais os
105: *     dois Refresh. Saiu de SincronizarCamposPrazo
106: *   - LimparCampos(): a UNICA limpeza de campo do legado (getNova zerado no
107: *     fim do Init e no fim do altera.Valid). Saiu do mesmo metodo
108: *   - HabilitarCampos(): o efeito na TELA do "If ThisForm.Bloquear" do Init
109: *     legado. Saiu de AplicarBloqueioAlteracao, que continua sendo quem LE o
110: *     criterio no BO e agora delega o efeito
111: *
112: * Os TRES primeiros sao declarados PROTECTED EXPLICITAMENTE, e isso nao eh

*-- Linhas 158 a 227:
158: * cnt_4c_Saida/Encerrar): este form NAO eh cadastro - eh um dialogo filho
159: * modal que recebe 9 parametros, mostra o historico e grava UMA troca de
160: * prazo. O legado tem exatamente DOIS botoes, e sao esses dois que a Fase 4
161: * cria; os handlers (BtnConfirmarClick/BtnCancelarClick) e os BINDEVENT
162: * saem na Fase 7, junto com o corpo dos dois Valid.
163: *
164: * Por isso NAO ha aqui os quatro nomes canonicos do form CRUD - o
165: * Btn...Incluir...Click e seus tres irmaos de Alterar/Visualizar/Excluir,
166: * grafados com o miolo ELIDIDO de proposito porque o gate casa o
167: * identificador no .prg INTEIRO, comentario incluido: escreve-los por
168: * extenso daria "PRESENTE" a partir deste texto. O SCX declara exatamente
169: * DOIS CommandButton (altera e sair) e nenhum outro botao, grupo ou
170: * pcEscolha proprio; criar handler para botao que a tela nao tem seria
171: * inventar UX (PILAR 1) ou escrever metodo vazio.
172: *
173: * Os campos (getAtual/getNova/Say1/Say2) e o passe de TabIndex entraram na
174: * Fase 5. O TabIndex so pode rodar DEPOIS de todos os AddObject do form (o VFP
175: * numera pela ordem de criacao e atribuir TabIndex EMPURRA os demais), por isso
176: * ele vive num metodo proprio chamado no fim do InicializarForm, e nao em cada
177: * bloco de criacao: Gradevenc 3, altera 2, sair 7, getNova 1, Say1 4,
178: * getAtual 5 e Say2 6.
179: *
180: * O "Procedure Load" do legado (=fConfigGeral()) fica de fora pela mesma
181: * decisao ja documentada em FormSigOpEnc.prg/FormSIGPRMEI.prg: fConfigGeral
182: * era funcao GLOBAL do legado (sig.prg/SIGFUNCS.PRG) que nao veio no acervo;
183: * o wrapper NO-OP em projeto\app\utils\fconfiggeral.prg existe so para o
184: * p-code dos VCX legado continuar resolvendo o nome, e em codigo NOSSO nunca
185: * se chama fConfigGeral.
186: *
187: * O "Procedure Release" do legado (ThisForm.poDataMgr.Release + DoDefault)
188: * corresponde ao Destroy() daqui: o poDataMgr do Fortyus era o dono dos
189: * cursores remotos, papel que nesta arquitetura e do SigOpEntBO - por isso
190: * Destroy() fecha os tres cursores declarados no BO e termina em DODEFAULT().
191: *==============================================================================
192: 
193: DEFINE CLASS FormSigOpEnt AS FormBase
194: 
195:     *--------------------------------------------------------------------------
196:     * PROPRIEDADES VISUAIS - transcritas LITERALMENTE do dump do SCX
197:     * (tasks\task731\SigOpEnt_form_codigo_fonte.txt, secao "PROPRIEDADES DE:
198:     * SIGOPENT"). MaxButton/MinButton tem de ser declarados aqui porque o
199:     * FormBase os deixa em .T. e o legado os declara .F.
200:     *
201:     * Closable NAO e declarado: o dump nao o traz, e TitleBar = 0 /
202:     * ControlBox = .F. NAO implicam Closable = .F. (sao propriedades
203:     * distintas - sem barra de titulo o botao nao DESENHA, mas o Alt+F4
204:     * continua valendo). Inventar Closable = .F. tiraria uma via de saida que
205:     * o legado tem. Pelo mesmo motivo nao se declara ShowWindow, Themes nem
206:     * ClipControls, ausentes do dump.
207:     *
208:     * DoCreate = .T. do dump tambem nao vem: e metadado de design-time do
209:     * Form Designer, nao propriedade de runtime da classe Form.
210:     *
211:     * DataSession = 2 (sessao PRIVADA) e transcrito do legado. O FormBase.Init
212:     * compensa o efeito colateral conhecido: datasession privada nasce com os
213:     * SETs no default do VFP (AMERICAN / CENTURY OFF), e e ele quem repoe
214:     * SET DATE TO BRITISH + SET CENTURY ON - por isso o Init() daqui tem de
215:     * chamar DODEFAULT().
216:     *--------------------------------------------------------------------------
217:     Width       = 500
218:     Height      = 300
219:     AutoCenter  = .T.
220:     BorderStyle = 2
221:     ShowTips    = .T.
222:     ShowWindow = 1
223:     ControlBox  = .F.
224:     MaxButton   = .F.
225:     MinButton   = .F.
226:     TitleBar    = 0
227:     WindowType  = 1

*-- Linhas 252 a 295:
252:     * this_dDataMovimento, this_lBloquear, this_nPrazoMaximo).
253:     *
254:     * Estas propriedades this_*Param* existem SO como carregador entre o
255:     * Init() - que recebe os argumentos - e o InicializarForm() - que cria o
256:     * BO e os repassa a ele: o BO ainda nao existe quando o Init() roda. Uma
257:     * vez feito o repasse em TransferirParametrosParaBO(), o BO passa a ser a
258:     * FONTE UNICA desses valores, e as fases seguintes devem le-los de
259:     * THIS.this_oBusinessObject.this_<x>, nunca daqui - duas copias do mesmo
260:     * dado divergem em silencio.
261:     *--------------------------------------------------------------------------
262:     this_cParamEmps          = ""   && pEmp    -> BO.this_cEmps
263:     this_cParamDopcs         = ""   && pDop    -> BO.this_cDopcs
264:     this_nParamNoTitulos     = 0    && pNum    -> BO.this_nNoTitulos
265:     this_dParamPrazoAtual    = {}   && pPrz    -> BO.this_dPrazoAtual
266:     this_nParamPrazoMinimo   = 0    && pMin    -> BO.this_nPrazoMinimo
267:     this_dParamDataMovimento = {}   && pDat    -> BO.this_dDataMovimento
268:     this_lParamBloquear      = .F.  && pBlqAlt -> BO.this_lBloquear
269:     this_nParamPrazoMaximo   = 0    && pMax    -> BO.this_nPrazoMaximo
270: 
271:     *--------------------------------------------------------------------------
272:     * CONTROLE DE FOCO INICIAL (one-shot do Activate)
273:     *
274:     * O legado estabelece o foco no FIM do seu Init; nesta arquitetura isso tem
275:     * de acontecer no Activate (ver comentario do metodo), que dispara TODA vez
276:     * que a janela volta a ser a ativa. Esta flag garante que o posicionamento
277:     * aconteca UMA unica vez, na primeira exibicao.
278:     *--------------------------------------------------------------------------
279:     this_lFocoInicialAplicado = .F.
280: 
281:     *--------------------------------------------------------------------------
282:     * GUARDA DE REENTRANCIA de ValidarPrazoNovo (regras #37/#47)
283:     *
284:     * SolicitarLiberacaoPrazo abre SigOpSen, que eh MODAL: o Show() bloqueia,
285:     * o foco sai e volta, e isso pode redisparar o mesmo handler de validacao
286:     * que VincularEventos liga a "LostFocus". Sem a guarda, a segunda
287:     * entrada abriria um SEGUNDO dialogo de autorizacao empilhado.
288:     *--------------------------------------------------------------------------
289:     this_lValidandoPrazoNovo = .F.
290: 
291:     *--------------------------------------------------------------------------
292:     * VEREDICTO DA ULTIMA VALIDACAO DO CAMPO "Nova Data"
293:     *
294:     * Em VFP nativo o getNova.Valid (TabIndex 1) roda ANTES do Click do botao
295:     * altera (TabIndex 2) e, recusando, nem deixa o Click acontecer. Aqui o

*-- Linhas 329 a 595:
329:     * A ordem posicional e IDENTICA ao Lparameters do legado
330:     *   (pEmp, pDop, pNum, pPrz, pFor, pMin, pDat, pBlqAlt, pMax)
331:     * para que a chamada da tela de movimentacao
332:     *   CREATEOBJECT("FormSigOpEnt", <emp>, <dop>, <num>, <prz>, THIS, ...)
333:     * seja transcricao direta do "Do Form SigOpEnt With ..." legado.
334:     *
335:     * Guardar os valores ANTES do DODEFAULT() e obrigatorio: e o DODEFAULT()
336:     * e criado e alimentado com estes parametros.
337:     *
338:     * Todos os argumentos sao OPCIONAIS: o harness de teste e os probes
339:     * headless instanciam o form sem nenhum deles, e nesse caso cada
340:     * propriedade mantem o default declarado acima.
341:     *
342:     * par_lBloquear usa PCOUNT() no guard, nao VARTYPE: em VFP9 parametro
343:     * declarado e NAO passado chega como .F. LOGICO, de modo que
344:     * VARTYPE(par_lBloquear) = "L" e verdade tanto para "nao passou" quanto
345:     * para "passou .F." - com default .F. o resultado coincide, mas o PCOUNT
346:     * deixa a intencao explicita e protege de uma futura troca de default.
347:     *
348:     * As duas datas passam por ConverterParaData(): elas chegam ora como DATE
349:     * (TextBox do pai criado com .Value = {}), ora como DATETIME (coluna
350:     * datetime lida por SQLEXEC), ora como CHAR - e TTOD() com DATE dispara
351:     * erro 11 em runtime.
352:     *==========================================================================
353:     PROCEDURE Init(par_cEmps, par_cDopcs, par_nNoTitulos, par_dPrazoAtual, ;
354:                    par_oFormPai, par_nPrazoMinimo, par_dDataMovimento, ;
355:                    par_lBloquear, par_nPrazoMaximo)
356: 
357:         IF VARTYPE(par_cEmps) = "C"
358:             THIS.this_cParamEmps = ALLTRIM(par_cEmps)
359:         ENDIF
360: 
361:         IF VARTYPE(par_cDopcs) = "C"
362:             THIS.this_cParamDopcs = ALLTRIM(par_cDopcs)
363:         ENDIF
364: 
365:         IF VARTYPE(par_nNoTitulos) = "N"
366:             THIS.this_nParamNoTitulos = par_nNoTitulos
367:         ENDIF
368: 
369:         IF INLIST(VARTYPE(par_dPrazoAtual), "D", "T", "C")
370:             THIS.this_dParamPrazoAtual = ConverterParaData(par_dPrazoAtual)
371:         ENDIF
372: 
373:         IF VARTYPE(par_oFormPai) = "O"
374:             THIS.this_oFormPai = par_oFormPai
375:         ENDIF
376: 
377:         IF VARTYPE(par_nPrazoMinimo) = "N"
378:             THIS.this_nParamPrazoMinimo = par_nPrazoMinimo
379:         ENDIF
380: 
381:         IF INLIST(VARTYPE(par_dDataMovimento), "D", "T", "C")
382:             THIS.this_dParamDataMovimento = ConverterParaData(par_dDataMovimento)
383:         ENDIF
384: 
385:         IF PCOUNT() >= 8 AND VARTYPE(par_lBloquear) = "L"
386:             THIS.this_lParamBloquear = par_lBloquear
387:         ENDIF
388: 
389:         IF VARTYPE(par_nPrazoMaximo) = "N"
390:             THIS.this_nParamPrazoMaximo = par_nPrazoMaximo
391:         ENDIF
392: 
393:         *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
394:         RETURN DODEFAULT()
395:     ENDPROC
396: 
397:     *==========================================================================
398:     * InicializarForm - Cria o Business Object e monta a estrutura visual base
399:     *
400:     * Equivale ao bloco "With ThisForm / .poDataMgr = CreateObject(...)" do
401:     * Init legado: ali o form criava o gerenciador de dados e so prosseguia
402:     * com pnIdconn > 0; aqui o papel e do SigOpEntBO, e a falha de criacao
403:     * devolve .F. para o FormBase.Init() abortar a abertura da tela.
404:     *
405:     * RETURN unico DEPOIS do ENDTRY, com flag loc_lSucesso: RETURN dentro de
406:     * TRY/CATCH e proibido em VFP9.
407:     *==========================================================================
408:     PROTECTED PROCEDURE InicializarForm()
409:         LOCAL loc_lSucesso, loc_lModoSemBanco, loc_oErro
410:         loc_lSucesso = .F.
411: 
412:         TRY
413:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpEntBO")
414: 
415:             IF VARTYPE(THIS.this_oBusinessObject) <> "O"
416:                 MsgErro("Erro ao criar SigOpEntBO. VARTYPE retornou: " + ;
417:                     VARTYPE(THIS.this_oBusinessObject), "FormSigOpEnt.InicializarForm")
418:             ELSE
419:                 *-- Textura de fundo do legado (..\framework\imagens\
420:                 *-- new_background.jpg), servida pelo caminho de icones do
421:                 *-- projeto, onde o arquivo tambem existe.
422:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
423: 
424:                 *-- Os parametros vao para o BO ANTES de qualquer carga: a
425:                 *-- consulta do historico e as validacoes de prazo das fases
426:                 *-- seguintes dependem deles.
427:                 THIS.TransferirParametrosParaBO()
428: 
429:                 *-- Equivalente as duas CursorQuery do Init legado
430:                 *-- (crSigCdOpe/DtEntrs e crSigOpCdd/chkUteis), que sao
431:                 *-- requisito de ABERTURA: falhando qualquer uma, o legado
432:                 *-- devolve .f. e o "Do Form" inteiro nao chega a abrir. Por
433:                 *-- isso o restante do metodo fica DENTRO do IF - sem a
434:                 *-- configuracao de apoio, loc_lSucesso permanece .F. e o
435:                 *-- CREATEOBJECT do chamador eh abortado, com a falha ja
436:                 *-- reportada pelo BO via MsgErro.
437:                 IF !THIS.this_oBusinessObject.CarregarConfiguracaoOperacao()
438:                     *-- Mensagem ja exibida dentro do BO
439:                 ELSE
440:                     THIS.ConfigurarCabecalho()
441: 
442:                     *-- Grade do historico (Gradevenc) e os dois botoes soltos
443:                     *-- do legado (altera/sair). A grade vem antes dos botoes
444:                     *-- so por seguir a ordem dos registros do SCX; os tres
445:                     *-- sao filhos diretos do Form e nao se sobrepoem.
446:                     THIS.ConfigurarGradeHistorico()
447:                     THIS.ConfigurarCamposPrazo()
448:                     THIS.ConfigurarBotoesAcao()
449: 
450:                     *-- Os dois passes que exigem TODOS os controles ja
451:                     *-- criados.
452:                     *--
453:                     *-- AplicarBloqueioAlteracao eh a metade "Enabled" do
454:                     *-- "If ThisForm.Bloquear" do Init legado, e toca um
455:                     *-- campo (getNova) e um botao (Confirmar) - nascidos em
456:                     *-- metodos DIFERENTES, por isso nao cabe dentro de
457:                     *-- nenhum deles.
458:                     *--
459:                     *-- AplicarOrdemTabulacao vem por ultimo porque atribuir
460:                     *-- TabIndex INSERE o controle naquela posicao e empurra
461:                     *-- os demais: feito no meio da criacao, cada AddObject
462:                     *-- seguinte entraria no fim e desfaria a ordem do dump.
463:                     THIS.AplicarBloqueioAlteracao()
464:                     THIS.AplicarOrdemTabulacao()
465: 
466:                     *-- Eventos dos tres controles que o legado dota de
467:                     *-- codigo (os dois botoes e o campo da data nova). Vem
468:                     *-- aqui pelo mesmo motivo dos dois passes acima: os
469:                     *-- controles nascem em metodos diferentes, e vincular de
470:                     *-- dentro de um deles estouraria "Unknown member" no
471:                     *-- outro.
472:                     THIS.VincularEventos()
473: 
474:                     *-- Modo do form pai, lido como o legado faz em
475:                     *-- altera.Valid
476:                     THIS.SincronizarEscolhaPai()
477: 
478:                     THIS.TornarControlesVisiveis(THIS)
479: 
480:                     *-- Carga inicial da grade, como o Init legado faz logo
481:                     *-- depois do AddCursor/Requery. Pulada em validacao de UI
482:                     *-- e em modo de teste, onde nao ha conexao (gnConnHandle
483:                     *-- = -1): nesses modos a grade abre vazia, e um probe que
484:                     *-- precise exercitar o bind chama THIS.CarregarLista() a
485:                     *-- mao.
486:                     loc_lModoSemBanco = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) ;
487:                         OR (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
488: 
489:                     IF !loc_lModoSemBanco
490:                         THIS.CarregarLista()
491:                     ENDIF
492: 
493:                     loc_lSucesso = .T.
494:                 ENDIF
495:             ENDIF
496:         CATCH TO loc_oErro
497:             MsgErro(loc_oErro.Message + CHR(13) + ;
498:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
499:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnt.InicializarForm")
500:         ENDTRY
501: 
502:         RETURN loc_lSucesso
503:     ENDPROC
504: 
505:     *==========================================================================
506:     * TransferirParametrosParaBO - Repassa ao SigOpEntBO os 8 parametros de
507:     * negocio recebidos do form pai, espelhando o bloco do Init legado
508:     *   .pEmp = pEmp / .pDop = pDop / .pNum = pNum / .pPrz = pPrz
509:     *   .pMin = pMin / .pMax = pMax / .pDat = pDat / .Bloquear = pBlqAlt
510:     *
511:     * Depois deste metodo o BO e a fonte unica desses valores (ver comentario
512:     * das propriedades this_*Param*). LEFT() aplica a largura das colunas de
513:     * SigOpMvv no schema - emps char(3) e dopcs char(20) - para o valor nunca
514:     * chegar ao INSERT maior do que a coluna aceita.
515:     *==========================================================================
516:     PROTECTED PROCEDURE TransferirParametrosParaBO()
517:         WITH THIS.this_oBusinessObject
518:             .this_cEmps          = LEFT(THIS.this_cParamEmps, .this_nLarguraEmps)
519:             .this_cDopcs         = LEFT(THIS.this_cParamDopcs, .this_nLarguraDopcs)
520:             .this_nNoTitulos     = THIS.this_nParamNoTitulos
521:             .this_dPrazoAtual    = THIS.this_dParamPrazoAtual
522:             .this_nPrazoMinimo   = THIS.this_nParamPrazoMinimo
523:             .this_dDataMovimento = THIS.this_dParamDataMovimento
524:             .this_lBloquear      = THIS.this_lParamBloquear
525:             .this_nPrazoMaximo   = THIS.this_nParamPrazoMaximo
526:         ENDWITH
527:     ENDPROC
528: 
529:     *==========================================================================
530:     * ConfigurarCabecalho - Faixa cinza do topo (cntSombra do legado) com o
531:     * titulo do form desenhado duas vezes: lblSombra em preto atras e
532:     * lblTitulo em branco por cima, 1px acima, o que produz o relevo.
533:     *
534:     * Geometria transcrita do dump, com UMA correcao deliberada de Width: o
535:     * SCX declara cntSombra.Width = 800 e os dois labels com Width = 769,
536:     * enquanto o proprio Form tem Width = 500 - o container do cabecalho foi
537:     * desenhado no Form Designer 300px mais largo que a janela. Copiar os
538:     * literais faria os labels ultrapassarem a borda direita e o titulo
539:     * (Tahoma 18 bold) sair cortado. Por isso o container acompanha
540:     * THIS.Width e os labels ficam em THIS.Width - 20, que com Left = 10
541:     * fecha exatamente na borda. Top/Height/Font/ForeColor/Alignment/
542:     * BackStyle seguem o dump sem alteracao.
543:     *
544:     * AutoSize = .F. explicito: o dump declara WordWrap = .T. nos dois labels,
545:     * e AutoSize em Label criado por AddObject e no-op para a largura e, com
546:     * WordWrap, chega a DESCARTAR a Height - a legenda colapsaria para uma
547:     * linha. Width e Height vem do dump, que ja sao o auto-size calculado
548:     * pelo Form Designer.
549:     *
550:     * As duas Caption recebem THIS.Caption, como o legado faz nas duas
551:     * primeiras linhas do seu Init
552:     *   ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
553:     *   ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
554:     *==========================================================================
555:     PROTECTED PROCEDURE ConfigurarCabecalho()
556:         LOCAL loc_oCnt
557: 
558:         THIS.AddObject("cnt_4c_Sombra", "Container")
559:         loc_oCnt = THIS.cnt_4c_Sombra
560:         WITH loc_oCnt
561:             .Top         = 0
562:             .Left        = 0
563:             .Width       = THIS.Width
564:             .Height      = 80
565:             .BorderWidth = 0
566:             .BackColor   = RGB(100, 100, 100)
567:             .Visible     = .T.
568:         ENDWITH
569: 
570:         loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
571:         WITH loc_oCnt.lbl_4c_Sombra
572:             .FontBold      = .T.
573:             .FontName      = "Tahoma"
574:             .FontSize      = 18
575:             .FontUnderline = .F.
576:             .WordWrap      = .T.
577:             .Alignment     = 0
578:             .BackStyle     = 0
579:             .AutoSize      = .F.
580:             .Caption       = THIS.Caption
581:             .Left          = 10
582:             .Top           = 18
583:             .Width         = THIS.Width - 20
584:             .Height        = 40
585:             .ForeColor     = RGB(0, 0, 0)
586:             .Visible       = .T.
587:         ENDWITH
588: 
589:         loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
590:         WITH loc_oCnt.lbl_4c_Titulo
591:             .FontBold    = .T.
592:             .FontName    = "Tahoma"
593:             .FontSize    = 18
594:             .WordWrap    = .T.
595:             .Alignment   = 0

*-- Linhas 648 a 697:
648:     * TabIndex do dump: Gradevenc = 3 (aplicado no passe da Fase 5, depois de
649:     * todos os AddObject do form).
650:     *==========================================================================
651:     PROTECTED PROCEDURE ConfigurarGradeHistorico()
652:         LOCAL loc_cCursor
653:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorHistorico
654: 
655:         *-- Cursor vazio ANTES do bind: ligar RecordSource/ControlSource a um
656:         *-- alias que ainda nao existe estoura "Alias ... is not found" DENTRO
657:         *-- do TRY do InicializarForm - o CREATEOBJECT devolve .F., o
658:         *-- VARTYPE(loForm) = "O" do chamador nao entra e a tela simplesmente
659:         *-- nao abre, sem erro visivel.
660:         *
661:         *-- A chamada eh INCONDICIONAL de proposito (CriarCursorHistorico faz
662:         *-- USE IN antes do CREATE CURSOR): garante que a estrutura ligada a
663:         *-- grade eh a NOSSA. O nome cursor_4c_Dados eh compartilhado por
664:         *-- muitos BOs do projeto, e ZAP preserva a estrutura de quem criou o
665:         *-- alias antes - aqui a DataSession = 2 ja isola o alias nesta sessao
666:         *-- privada, e recriar fecha o que sobrar de qualquer jeito.
667:         *
668:         *-- A estrutura mora SO no BO (CriarCursorHistorico), porque a recarga
669:         *-- eh por ZAP + APPEND FROM DBF(), que casa coluna por NOME: duas
670:         *-- declaracoes do mesmo cursor divergem em silencio.
671:         THIS.this_oBusinessObject.CriarCursorHistorico()
672: 
673:         THIS.AddObject("grd_4c_Dados", "Grid")
674: 
675:         THIS.grd_4c_Dados.ColumnCount  = 2
676:         THIS.grd_4c_Dados.RecordSource = loc_cCursor
677: 
678:         WITH THIS.grd_4c_Dados
679:             .Top                = 99
680:             .Left               = 105
681:             .Width              = 173
682:             .Height             = 184
683:             .FontName           = "Tahoma"
684:             .FontSize           = 8
685:             .AllowHeaderSizing  = .F.
686:             .AllowRowSizing     = .F.
687:             .DeleteMark         = .F.
688:             .RecordMark         = .F.
689:             .RowHeight          = 16
690:             .ScrollBars         = 2
691:             .GridLineColor      = RGB(238, 238, 238)
692:             .HighlightBackColor = RGB(90, 90, 90)
693:             .ReadOnly           = .T.
694: 
695:             *-- Column1 "Historico" - a data de entrega arquivada
696:             .Column1.ControlSource     = "TTOD(" + loc_cCursor + ".vencs)"
697:             .Column1.Width             = 70

*-- Linhas 762 a 813:
762:     *
763:     * Os handlers dos dois Valid legado (sair -> ThisForm.Release; altera ->
764:     * INSERT + UPDATE + devolucao do novo prazo ao form pai) sao
765:     * BtnCancelarClick e BtnConfirmarClick, e os BINDEVENT("Click") que os
766:     * acionam ficam em VincularEventos - chamado pelo InicializarForm depois
767:     * de TODOS os AddObject, e nao aqui, porque o campo da data nova (que
768:     * tambem eh vinculado la) nasce em outro metodo.
769:     *
770:     * TabIndex do dump: altera = 2, sair = 7 (aplicados no passe da Fase 5,
771:     * depois de todos os AddObject do form).
772:     *==========================================================================
773:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
774:         LOCAL loc_lBloqueado
775:         loc_lBloqueado = THIS.this_oBusinessObject.this_lBloquear
776: 
777:         THIS.AddObject("cmd_4c_Confirmar", "CommandButton")
778:         WITH THIS.cmd_4c_Confirmar
779:             .Top             = 3
780:             .Left            = 350
781:             .Width           = 75
782:             .Height          = 75
783:             .Caption         = "\<Confirmar"
784:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
785:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
786:             .FontBold        = .T.
787:             .FontItalic      = .T.
788:             .FontName        = "Comic Sans MS"
789:             .FontSize        = 8
790:             .ForeColor       = RGB(90, 90, 90)
791:             .BackColor       = RGB(255, 255, 255)
792:             .Themes          = .T.
793:             .SpecialEffect   = 0
794:             .PicturePosition = 13
795:             .MousePointer    = 15
796:             .WordWrap        = .T.
797:             .AutoSize        = .F.
798:             .Enabled         = !loc_lBloqueado
799:             .Visible         = .T.
800:         ENDWITH
801: 
802:         THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
803:         WITH THIS.cmd_4c_Cancelar
804:             .Top             = 3
805:             .Left            = 425
806:             .Width           = 75
807:             .Height          = 75
808:             .Caption         = "Encerrar"
809:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
810:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
811:             .Cancel          = .T.
812:             .FontBold        = .T.
813:             .FontItalic      = .T.

*-- Linhas 875 a 930:
875:     *     por binding). O trafego de valores passa por SincronizarCamposPrazo().
876:     *
877:     * getAtual EH SOMENTE-LEITURA. O legado faz isso com
878:     *   PROCEDURE When / Return .f.
879:     * que impede o campo de receber foco - logo o usuario nem entra nele. Aqui
880:     * isso vira ReadOnly = .T. (nao da para digitar) + TabStop = .F. (o Tab nao
881:     * para nele), que eh o par de propriedades equivalente. NAO se usa
882:     * BINDEVENT em "When": BINDEVENT DESCARTA o retorno do delegate, entao um
883:     * When ligado por BINDEVENT nao bloquearia nada. Tambem NAO se usa
884:     * Enabled = .F.: isso pintaria o valor com a cor de desabilitado, enquanto
885:     * o legado exibe o prazo vigente em preto normal (ForeColor 0,0,0 do dump).
886:     *
887:     * TabIndex do dump (Say1 4, getAtual 5, Say2 6, getNova 1) eh aplicado em
888:     * AplicarOrdemTabulacao(), depois de todos os AddObject do form.
889:     *==========================================================================
890:     PROTECTED PROCEDURE ConfigurarCamposPrazo()
891: 
892:         *-- Say1 "Data Atual" -----------------------------------------------
893:         THIS.AddObject("lbl_4c_PrazoAtual", "Label")
894:         WITH THIS.lbl_4c_PrazoAtual
895:             .FontBold  = .T.
896:             .FontName  = "Tahoma"
897:             .FontSize  = 8
898:             .AutoSize  = .F.
899:             .Alignment = 0
900:             .BackStyle = 0
901:             .WordWrap  = .F.
902:             .Caption   = "Data Atual"
903:             .Left      = 315
904:             .Top       = 110
905:             .Width     = 70
906:             .Height    = 15
907:             .ForeColor = RGB(90, 90, 90)
908:             .Visible   = .T.
909:         ENDWITH
910: 
911:         *-- getAtual - prazo de entrega VIGENTE, somente leitura ------------
912:         THIS.AddObject("txt_4c_PrazoAtual", "TextBox")
913:         WITH THIS.txt_4c_PrazoAtual
914:             .FontName  = "Tahoma"
915:             .FontSize  = 8
916:             .Alignment = 3
917:             .Themes    = .F.
918:             .Value     = {}
919:             .Left      = 315
920:             .Top       = 124
921:             .Width     = 80
922:             .Height    = 23
923:             .ForeColor = RGB(0, 0, 0)
924:             .ReadOnly  = .T.
925:             .TabStop   = .F.
926:             .Visible   = .T.
927:         ENDWITH
928: 
929:         *-- Say2 "Nova Data" -----------------------------------------------
930:         THIS.AddObject("lbl_4c_PrazoNovo", "Label")

*-- Linhas 968 a 1376:
968:         *-- A outra ponta (o par Enabled do "If ThisForm.Bloquear") NAO pode
969:         *-- ser aplicada aqui: ela toca tambem o Confirmar, que so nasce em
970:         *-- ConfigurarBotoesAcao(), chamado DEPOIS deste metodo. Medido no
971:         *-- VFP9: chamando AplicarBloqueioAlteracao() daqui, o InicializarForm
972:         *-- estourava "Unknown member CMD_4C_CONFIRMAR" dentro do seu TRY, o
973:         *-- CREATEOBJECT devolvia .F. e a tela simplesmente nao abria. Por isso
974:         *-- ela roda no InicializarForm, depois de TODOS os AddObject.
975:     ENDPROC
976: 
977:     *==========================================================================
978:     * SincronizarCamposPrazo - Funil UNICO de valores entre o BO e os dois
979:     * campos de data
980:     *
981:     * Reproduz as duas pontas em que o legado mexe nesses campos:
982:     *   Init         -> .getAtual.Value = .pPrz
983:     *                   .getNova.Value  = Ctod('')
984:     *   altera.Valid -> ThisForm.getAtual.Value = ThisForm.pPrz   (apos gravar)
985:     *                   ThisForm.getNova.Value  = Ctod('')
986:     *                   ThisForm.getAtual.Refresh / .getNova.Refresh
987:     *
988:     * Como o legado repete o MESMO par nas duas pontas, ele vira um metodo so:
989:     * BtnConfirmarClick torna a chama-lo depois de gravar, e o campo "Data
990:     * Atual" passa a exibir o prazo recem-confirmado sem a tela ser fechada.
991:     *
992:     * FASE 8: o CORPO saiu daqui e foi para os dois hooks canonicos da
993:     * arquitetura, porque o par do legado eh exatamente a soma deles - zerar
994:     * getNova eh LimparCampos, e escrever getAtual mais os dois Refresh eh
995:     * BOParaForm. Este metodo continua existindo e continua sendo o nome que o
996:     * resto do form chama, mas agora como a COMPOSICAO dos dois: assim nao ha
997:     * duas copias da mesma transferencia para divergirem em silencio no
998:     * primeiro campo novo (CLAUDE.md #44, item 6 - fonte unica).
999:     *
1000:     * A ordem importa e eh a do legado: zera-se a data nova ANTES de empurrar
1001:     * o BO para a tela, de modo que BOParaForm ja encontre o campo "Nova Data"
1002:     * vazio dos dois lados.
1003:     *
1004:     * A grade do historico NAO eh repintada aqui, apesar de o legado chamar
1005:     * GradeVenc.Refresh na mesma sequencia: ela tem funil proprio
1006:     * (CarregarLista), que recarrega o cursor e so depois repinta - repintar
1007:     * aqui exibiria o historico antigo.
1008:     *
1009:     * PUBLIC de proposito: quem chama eh BtnConfirmarClick, que roda de FORA
1010:     * desta classe quando acionado por BINDEVENT. Os dois hooks que ele compoe
1011:     * sao PROTECTED e NAO poderiam ser chamados de fora (ver o comentario de
1012:     * cada um) - por isso os call sites nao foram trocados pelos hooks, e sim
1013:     * este metodo passou a delega-los.
1014:     *==========================================================================
1015:     PROCEDURE SincronizarCamposPrazo()
1016:         *-- a limpeza de getNova que o legado faz nas duas pontas
1017:         THIS.LimparCampos()
1018: 
1019:         *-- "getAtual.Value = pPrz" + os dois Refresh
1020:         THIS.BOParaForm()
1021:     ENDPROC
1022: 
1023:     *==========================================================================
1024:     * LimparCampos - hook canonico da arquitetura (FormBase), aqui com o
1025:     * conteudo real desta tela: zerar o campo "Nova Data"
1026:     *
1027:     * Porta da linha que o legado escreve nas DUAS pontas (fim do Init e fim
1028:     * do altera.Valid, depois de gravar):
1029:     *   ThisForm.getNova.Value = Ctod('')
1030:     * E a UNICA limpeza de campo que o SCX faz.
1031:     *
1032:     * "Data Atual" NAO entra: ela nao eh campo de digitacao e sim a exibicao
1033:     * do prazo vigente (getAtual tem "Procedure When / Return .f." no legado,
1034:     * que aqui virou ReadOnly = .T. + TabStop = .F.). Limpa-la apagaria da
1035:     * tela um dado que continua valendo - quem a atualiza eh BOParaForm, a
1036:     * partir do BO.
1037:     *
1038:     * As DUAS copias do valor sao zeradas no MESMO passo - o controle e a
1039:     * propriedade do BO. Zerar so o controle deixaria o BO com a data digitada
1040:     * antes, e o Confirmar seguinte gravaria uma troca de prazo que o usuario
1041:     * nao pediu.
1042:     *
1043:     * PROTECTED EXPLICITO, e nao por estilo: FormBase.prg declara
1044:     * "PROTECTED PROCEDURE LimparCampos" e em VFP9 a subclasse NAO alarga o
1045:     * escopo herdado - escrever sem PROTECTED nao tornaria o metodo publico,
1046:     * so esconderia de quem le que ele continua protegido. Por isso ele eh
1047:     * chamado por THIS., de dentro da classe, e nunca de fora.
1048:     *==========================================================================
1049:     PROTECTED PROCEDURE LimparCampos()
1050:         THIS.txt_4c_PrazoNovo.Value = {}
1051:         THIS.this_oBusinessObject.this_dPrazoNovo = {}
1052:     ENDPROC
1053: 
1054:     *==========================================================================
1055:     * BOParaForm - hook canonico da arquitetura (FormBase): leva ao
1056:     * formulario os valores que estao no SigOpEntBO
1057:     *
1058:     * Cobre os DOIS campos de data desta tela, que sao TODOS os controles de
1059:     * dados que o SCX tem fora da grade (a arvore de objetos do dump traz
1060:     * exatamente dois "BaseClass: textbox" fora das colunas da Gradevenc):
1061:     *   txt_4c_PrazoAtual (getAtual) <- BO.this_dPrazoAtual  (pPrz do legado)
1062:     *   txt_4c_PrazoNovo  (getNova)  <- BO.this_dPrazoNovo
1063:     *
1064:     * Nesta direcao o legado so escreve getAtual ("getAtual.Value = pPrz"),
1065:     * porque getNova ele ZERA no mesmo passo. Aqui os dois sao espelhados do
1066:     * BO, que eh a fonte unica: depois de LimparCampos o this_dPrazoNovo ja
1067:     * esta vazio, logo o efeito final eh identico ao do legado; e numa chamada
1068:     * fora dessa sequencia (o Cancelar que FormBase.Cancelar dispara por
1069:     * THIS.BOParaForm) a tela volta a refletir o BO INTEIRO, em vez de manter
1070:     * exibido um valor que o BO nao tem mais.
1071:     *
1072:     * ConverterParaData eh aplicado nos dois: o valor pode chegar de coluna
1073:     * datetime (SQLEXEC) e atribuir DATETIME a um TextBox que nasceu com
1074:     * Value = {} TROCA o tipo do controle - dai a exibicao e qualquer TTOD a
1075:     * jusante divergem. Com DATE o resultado eh identico ao do valor cru, e
1076:     * TTOD() puro com DATE dispararia erro 11 em runtime (regra #16).
1077:     *
1078:     * Os dois Refresh do fim sao os do legado
1079:     * ("ThisForm.getAtual.Refresh / ThisForm.getNova.Refresh") e sao o que faz
1080:     * o valor novo APARECER - atribuir .Value nao repinta o controle.
1081:     *
1082:     * PROTECTED EXPLICITO pelo mesmo motivo de LimparCampos: o escopo vem da
1083:     * heranca de FormBase e nao da para alargar na subclasse.
1084:     *==========================================================================
1085:     PROTECTED PROCEDURE BOParaForm()
1086:         LOCAL loc_oBO
1087:         loc_oBO = THIS.this_oBusinessObject
1088: 
1089:         THIS.txt_4c_PrazoAtual.Value = ConverterParaData(loc_oBO.this_dPrazoAtual)
1090:         THIS.txt_4c_PrazoNovo.Value  = ConverterParaData(loc_oBO.this_dPrazoNovo)
1091: 
1092:         THIS.txt_4c_PrazoAtual.Refresh()
1093:         THIS.txt_4c_PrazoNovo.Refresh()
1094:     ENDPROC
1095: 
1096:     *==========================================================================
1097:     * FormParaBO - hook canonico da arquitetura (FormBase): leva ao
1098:     * SigOpEntBO o que esta nos campos da tela
1099:     *
1100:     * Porta das duas primeiras linhas de altera.Valid, que sao justamente a
1101:     * leitura dos dois campos ANTES de gravar:
1102:     *   ldAnt = ThisForm.getAtual.Value   ->  BO.this_dPrazoAtual
1103:     *   ldNew = ThisForm.getNova.Value    ->  BO.this_dPrazoNovo
1104:     *
1105:     * Cobre os DOIS campos, que sao TODOS os controles de dados do legado fora
1106:     * da grade - nao ha terceiro campo nesta tela para ficar de fora. O
1107:     * defeito classico de FormParaBO que cobre so parte da superficie nao tem
1108:     * onde acontecer aqui, e por isso mesmo o metodo tem de ser revisto se
1109:     * algum campo vier a ser acrescentado.
1110:     *
1111:     * getAtual tambem eh transferido, apesar de ser somente leitura: o legado
1112:     * le o .Value DELE (nao a propriedade pPrz) exatamente nesta linha, e eh
1113:     * esse valor que vai para a coluna SigOpMvv.Vencs - a data que SAI de
1114:     * vigor, arquivada no historico. Ler a propriedade em vez do controle
1115:     * daria o mesmo resultado hoje, mas deixaria de ser transcricao do que o
1116:     * legado faz.
1117:     *
1118:     * As duas conversoes passam por ConverterParaData pelo mesmo motivo
1119:     * descrito em BOParaForm, e aqui o risco eh maior: txt_4c_PrazoNovo nasce
1120:     * com Value = {} (DATE) e pode receber DATETIME quando o valor vem do
1121:     * banco - exatamente o par de tipos que faz TTOD() estourar erro 11 em so
1122:     * um dos caminhos (regra #16).
1123:     *
1124:     * FUNCTION, nao PROCEDURE, e com flag: devolve .F. quando a transferencia
1125:     * nao pode ser feita, para quem chama nao prosseguir gravando com o BO
1126:     * pela metade - nunca fabricar sucesso (regra #20). RETURN unico DEPOIS do
1127:     * ENDTRY: RETURN dentro de TRY/CATCH eh proibido em VFP9 (regra #1).
1128:     *
1129:     * PROTECTED EXPLICITO pelo mesmo motivo de LimparCampos/BOParaForm: o
1130:     * escopo vem da heranca de FormBase. Quem precisa disto de fora passa por
1131:     * BtnConfirmarClick, que eh publico e o chama por THIS.
1132:     *==========================================================================
1133:     PROTECTED FUNCTION FormParaBO()
1134:         LOCAL loc_oBO, loc_lSucesso, loc_oErro
1135:         loc_lSucesso = .F.
1136: 
1137:         TRY
1138:             loc_oBO = THIS.this_oBusinessObject
1139: 
1140:             *-- "ldAnt = ThisForm.getAtual.Value"
1141:             loc_oBO.this_dPrazoAtual = ConverterParaData(THIS.txt_4c_PrazoAtual.Value)
1142: 
1143:             *-- "ldNew = ThisForm.getNova.Value"
1144:             loc_oBO.this_dPrazoNovo = ConverterParaData(THIS.txt_4c_PrazoNovo.Value)
1145: 
1146:             loc_lSucesso = .T.
1147:         CATCH TO loc_oErro
1148:             MsgErro(loc_oErro.Message + CHR(13) + ;
1149:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1150:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnt.FormParaBO")
1151:         ENDTRY
1152: 
1153:         RETURN loc_lSucesso
1154:     ENDFUNC
1155: 
1156:     *==========================================================================
1157:     * ValidarPrazoNovo - porta de SIGOPENT.getNova.Valid (linhas 443-502 do
1158:     * dump legado): a UNICA validacao de negocio deste dialogo.
1159:     *
1160:     * O legado valida no Valid, isto e ao SAIR do campo por QUALQUER via -
1161:     * Tab, Enter ou clique de mouse em outro controle. Como BINDEVENT em
1162:     * "Valid" nao funciona em TextBox (regra geral do projeto) e este NAO eh
1163:     * um campo de lookup (nao abre FormBuscaAuxiliar - a unica tela que abre
1164:     * eh o SigOpSen de autorizacao, condicional), VincularEventos liga este
1165:     * metodo a "LostFocus", nao a "KeyPress": LostFocus dispara tambem quando o
1166:     * usuario clica direto no botao Confirmar, sem passar pelo teclado - um
1167:     * BINDEVENT em "KeyPress" perderia exatamente esse caminho.
1168:     *
1169:     * Sequencia, na ordem do dump:
1170:     *   1) normaliza o valor digitado - "ldDat = Ttod(fDtoSQL(This.Value))" -
1171:     *      so quando preenchido; ConverterParaData cobre o mesmo caso de
1172:     *      DATE/DATETIME/CHAR sem o erro 11 do TTOD puro com DATE (regra #16)
1173:     *   2) com SigCdOpe.DtEntrs em (1,4,6): campo nao pode ficar vazio
1174:     *   3) nao pode ser MENOR que a data da movimentacao (pDat)
1175:     *   4) tem de estar dentro da faixa pDat+pMin .. pDat+pMax - fora dela,
1176:     *      SolicitarLiberacaoPrazo pede autorizacao LIBPRZENT; sem
1177:     *      autorizacao, recusa
1178:     *
1179:     * As duas primeiras linhas do Valid legado (ldEnt = ThisForm.pDat +
1180:     * ThisForm.pMin / ldEntm = ThisForm.pDat + ThisForm.pMax) NAO sao
1181:     * transcritas: ldEnt e reatribuido DENTRO de cada bloco antes de ser
1182:     * lido, e ldEntm nunca e lido em lugar nenhum do metodo - sao calculos
1183:     * mortos do legado, nao regra de negocio (regra CLAUDE.md #17 cobre a
1184:     * FORMULA viva, nao obriga reproduzir atribuicao cujo valor jamais e
1185:     * usado).
1186:     *
1187:     * Em qualquer reprovacao o campo NAO eh limpo e o foco volta para ele -
1188:     * exatamente o que "Return .f." faz num Valid nativo (regra #50: nunca
1189:     * apagar o que o usuario digitou). Como esta classe nao tem Valid nativo,
1190:     * o SetFocus de volta fica por conta deste metodo mesmo, e nao de quem o
1191:     * aciona.
1192:     *
1193:     * FUNCTION (nao PROCEDURE): devolve .T./.F. para o fluxo de Confirmar
1194:     * decidir se prossegue - nunca fabricar sucesso quando a validacao recusou
1195:     * (regra #50/#20). O veredicto tambem fica guardado nas propriedades
1196:     * this_*PrazoNovoValidado*, para o clique em Confirmar nao validar o mesmo
1197:     * valor uma segunda vez (ver GarantirPrazoNovoValidado).
1198:     *
1199:     * PUBLIC de proposito: eh alvo do BINDEVENT("LostFocus") montado em
1200:     * VincularEventos - via PrazoNovoLostFocus -, que roda de FORA desta
1201:     * classe, e eh alcancado tambem pelo caminho de BtnConfirmarClick (o
1202:     * Confirmar eh TabIndex 2, logo em VFP nativo o Valid do campo 1 roda
1203:     * antes do Click do campo 2 - aqui isso tem de ser explicito).
1204:     *==========================================================================
1205:     FUNCTION ValidarPrazoNovo()
1206:         LOCAL loc_oBO, loc_dValor, loc_dDataMovimento, loc_nMin, loc_nMax
1207:         LOCAL loc_dLimiteMin, loc_dLimiteMax, loc_lAprovado, loc_oErro
1208: 
1209:         IF THIS.this_lValidandoPrazoNovo
1210:             RETURN .F.
1211:         ENDIF
1212:         THIS.this_lValidandoPrazoNovo = .T.
1213: 
1214:         loc_lAprovado = .T.
1215: 
1216:         TRY
1217:             loc_oBO = THIS.this_oBusinessObject
1218: 
1219:             *-- "If Not IsEmpty(This.Value) / ldDat = Ttod(fDtoSQL(This.Value))
1220:             *-- / This.Value = ldDat / This.Refresh"
1221:             IF !EMPTY(THIS.txt_4c_PrazoNovo.Value)
1222:                 THIS.txt_4c_PrazoNovo.Value = ConverterParaData(THIS.txt_4c_PrazoNovo.Value)
1223:                 THIS.txt_4c_PrazoNovo.Refresh()
1224:             ENDIF
1225: 
1226:             loc_dValor         = THIS.txt_4c_PrazoNovo.Value
1227:             loc_dDataMovimento = ConverterParaData(loc_oBO.this_dDataMovimento)
1228:             loc_nMin           = loc_oBO.this_nPrazoMinimo
1229:             loc_nMax           = loc_oBO.this_nPrazoMaximo
1230: 
1231:             *-- "If InList(crSigCdOpe.DtEntrs, 1, 4, 6)"
1232:             IF INLIST(loc_oBO.this_nDtEntrs, 1, 4, 6)
1233: 
1234:                 *-- "If IsEmpty(This.Value) / Messagebox(...) / Return .f."
1235:                 IF EMPTY(loc_dValor)
1236:                     MsgAviso("Prazo de Entrega Deve Ser Informado...", "")
1237:                     loc_lAprovado = .F.
1238:                 ENDIF
1239: 
1240:                 *-- "If (Ttod(fDtoSQL(This.Value)) < ThisForm.pDat) / ... / Return .f."
1241:                 IF loc_lAprovado AND loc_dValor < loc_dDataMovimento
1242:                     MsgAviso("Prazo de Entrega Deve Ser Maior Que a Data da " + ;
1243:                         "Movimenta" + CHR(231) + CHR(227) + "o...", "")
1244:                     loc_lAprovado = .F.
1245:                 ENDIF
1246: 
1247:                 *-- "If (ThisForm.pMin > 0) / ldEnt = pDat + pMin / If This.Value < ldEnt"
1248:                 IF loc_lAprovado AND loc_nMin > 0
1249:                     loc_dLimiteMin = loc_dDataMovimento + loc_nMin
1250:                     IF loc_dValor < loc_dLimiteMin
1251:                         loc_lAprovado = THIS.SolicitarLiberacaoPrazo(loc_dLimiteMin, ;
1252:                             loc_dValor, "M" + CHR(237) + "nimo")
1253:                     ENDIF
1254:                 ENDIF
1255: 
1256:                 *-- "If (ThisForm.pMax > 0) / ldEnt = pDat + pMax / If This.Value > ldEnt"
1257:                 IF loc_lAprovado AND loc_nMax > 0
1258:                     loc_dLimiteMax = loc_dDataMovimento + loc_nMax
1259:                     IF loc_dValor > loc_dLimiteMax
1260:                         loc_lAprovado = THIS.SolicitarLiberacaoPrazo(loc_dLimiteMax, ;
1261:                             loc_dValor, "M" + CHR(225) + "ximo")
1262:                     ENDIF
1263:                 ENDIF
1264:             ENDIF
1265: 
1266:             IF !loc_lAprovado
1267:                 THIS.txt_4c_PrazoNovo.SetFocus()
1268:             ENDIF
1269:         CATCH TO loc_oErro
1270:             MsgErro(loc_oErro.Message + CHR(13) + ;
1271:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1272:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnt.ValidarPrazoNovo")
1273:             loc_lAprovado = .F.
1274:         ENDTRY
1275: 
1276:         *-- Veredicto fresco, pronto para ser CONSUMIDO pelo clique em
1277:         *-- Confirmar que costuma vir logo depois (ver as propriedades
1278:         *-- this_*PrazoNovoValidado*). Gravado tambem na reprovacao: eh o
1279:         *-- que impede o segundo pedido de autorizacao LIBPRZENT no mesmo
1280:         *-- clique.
1281:         THIS.this_dPrazoNovoValidado = ConverterParaData(THIS.txt_4c_PrazoNovo.Value)
1282:         THIS.this_lPrazoNovoAprovado = loc_lAprovado
1283:         THIS.this_lPrazoNovoValidado = .T.
1284: 
1285:         THIS.this_lValidandoPrazoNovo = .F.
1286:         RETURN loc_lAprovado
1287:     ENDFUNC
1288: 
1289:     *==========================================================================
1290:     * PrazoNovoLostFocus - porta do EVENTO em que o getNova.Valid legado roda:
1291:     * a saida do campo por qualquer via (Tab, Enter ou clique do mouse em
1292:     * outro controle).
1293:     *
1294:     * BINDEVENT em "Valid" nao funciona em TextBox, e "KeyPress" perderia
1295:     * justamente o caminho do mouse - o usuario que digita a data e clica
1296:     * direto em Confirmar nunca passaria pela validacao. Por isso o evento eh
1297:     * "LostFocus" (regra #47), e por isso este handler NAO declara
1298:     * par_nKeyCode/par_nShiftAltCtrl: LostFocus nao passa parametro nenhum.
1299:     *
1300:     * Nao abre picker nenhum - o campo eh de data, nao de lookup -, logo nao
1301:     * cabe aqui o guard de tecla que a regra #47 exige de handler ligado a
1302:     * KeyPress.
1303:     *
1304:     * Valida SEMPRE (nao consome cache): cada saida do campo torna a rodar o
1305:     * Valid no legado. Quem evita a validacao em duplicidade eh o lado do
1306:     * botao, em GarantirPrazoNovoValidado().
1307:     *
1308:     * PUBLIC: eh alvo de BINDEVENT, que so alcanca metodo PUBLIC (regra #3).
1309:     *==========================================================================
1310:     PROCEDURE PrazoNovoLostFocus()
1311:         = THIS.ValidarPrazoNovo()
1312:     ENDPROC
1313: 
1314:     *==========================================================================
1315:     * GarantirPrazoNovoValidado - devolve o veredicto da validacao do campo
1316:     * "Nova Data" para o caminho de CONFIRMACAO, sem validar duas vezes o
1317:     * mesmo valor no mesmo clique.
1318:     *
1319:     * Reproduz o encadeamento que o VFP nativo dava de graca no legado
1320:     * (getNova.Valid em TabIndex 1 roda antes do altera.Click em TabIndex 2 e,
1321:     * recusando, impede o clique). Aqui:
1322:     *   - se o LostFocus do campo acabou de julgar ESTE valor, o veredicto eh
1323:     *     consumido e o cache zerado;
1324:     *   - caso contrario - foco nunca passou pelo campo, valor alterado por
1325:     *     codigo, ou segundo clique sobre o mesmo valor -, valida na hora.
1326:     *
1327:     * Zerar o cache ao consumir eh o que mantem a fidelidade: clicar Confirmar
1328:     * de novo com a mesma data recusada torna a validar e a exibir a mensagem,
1329:     * como o legado faz a cada saida do campo.
1330:     *
1331:     * FUNCTION: devolve .T./.F. para o chamador decidir se prossegue - nunca
1332:     * fabricar sucesso quando a validacao recusou (regras #20/#50).
1333:     *
1334:     * PUBLIC pelo mesmo motivo dos demais metodos deste caminho: eh chamado
1335:     * de BtnConfirmarClick(), que roda de FORA desta classe quando acionado
1336:     * por BINDEVENT.
1337:     *==========================================================================
1338:     FUNCTION GarantirPrazoNovoValidado()
1339:         LOCAL loc_lAprovado
1340: 
1341:         IF THIS.this_lPrazoNovoValidado ;
1342:            AND ConverterParaData(THIS.txt_4c_PrazoNovo.Value) = THIS.this_dPrazoNovoValidado
1343:             loc_lAprovado = THIS.this_lPrazoNovoAprovado
1344:             THIS.this_lPrazoNovoValidado = .F.
1345:         ELSE
1346:             loc_lAprovado = THIS.ValidarPrazoNovo()
1347:             THIS.this_lPrazoNovoValidado = .F.
1348:         ENDIF
1349: 
1350:         RETURN loc_lAprovado
1351:     ENDFUNC
1352: 
1353:     *==========================================================================
1354:     * SolicitarLiberacaoPrazo - pede autorizacao LIBPRZENT via "Do Form
1355:     * SigOpSen" quando a data digitada caiu fora da faixa minima ou maxima,
1356:     * espelhando o bloco que o getNova.Valid legado repete DUAS vezes (so o
1357:     * rotulo e o limite mudam entre Minimo e Maximo):
1358:     *
1359:     *   Do Form SigOpSen With 'LIBPRZENT', 'Libera Prazo de Entrega' To _Retorno
1360:     *   llOk = ( Left( _Retorno, 1 ) = "*" )
1361:     *   lcUsuLib = Substr( _Retorno, 2 )
1362:     *   If !llOk
1363:     *       Messagebox('Prazo de Entrega <Minimo|Maximo> e ' + Dtoc(ldEnt) + '...', 32, '')
1364:     *       Return .f.
1365:     *   Else
1366:     *       lcTransacao = 'Emp: '+_Empr+' No Oper: '+Str(pnum,6)+' - '+'Prazo <X>: '+Dtoc(ldEnt)+' Prazo Liberado '+Dtoc(This.Value)
1367:     *       =fGravarLog('T', pDop, 'LIBPRZENT', lcTransacao, lcUsuLib)
1368:     *   EndIf
1369:     *
1370:     * SigOpSen NAO EXISTE na nova arquitetura - o sigopsen.SCX so existe na
1371:     * pasta do legado (C:\4install\FortyusMC\Fortyus\), fora do SET PATH
1372:     * montado pelo config.prg (ver memoria
1373:     * feedback_sigopsen_ausente_gate_autorizacao). "Do Form SigOpSen" dispara
1374:     * erro 1 "File ... does not exist." em runtime.
1375:     *
1376:     * Por ser gate de AUTORIZACAO, a falha e tratada FAIL-CLOSED: dialogo

*-- Linhas 1428 a 1687:
1428:             loc_oBO.this_cUsuarioLiberacao = loc_cUsuarioLib
1429:         ELSE
1430:             IF loc_lDialogoAbriu
1431:                 MsgAviso("Prazo de Entrega " + par_cRotulo + " " + CHR(233) + " " + ;
1432:                     DTOC(par_dLimite) + "...", "")
1433:             ELSE
1434:                 *-- FAIL-CLOSED: sem o dialogo de senha nao se libera prazo
1435:                 *-- fora da faixa minima/maxima.
1436:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir a " + ;
1437:                     "tela de autoriza" + CHR(231) + CHR(227) + "o (SigOpSen)." + CHR(13) + ;
1438:                     "O prazo de entrega N" + CHR(195) + "O foi liberado." + CHR(13) + CHR(13) + ;
1439:                     "Detalhe: " + loc_cFalhaDialogo, "Libera Prazo de Entrega")
1440:             ENDIF
1441:         ENDIF
1442: 
1443:         RETURN loc_lAutorizado
1444:     ENDFUNC
1445: 
1446:     *==========================================================================
1447:     * AplicarBloqueioAlteracao - Metade "Enabled" do If ThisForm.Bloquear do
1448:     * Init legado
1449:     *
1450:     *   If ThisForm.Bloquear
1451:     *       .GetNova.Enabled = .f.
1452:     *       .altera.Enabled  = .f.
1453:     *
1454:     * pBlqAlt = .T. significa que o pai abriu a tela apenas para CONSULTA do
1455:     * historico: a data nova nao pode ser digitada e o Confirmar nao pode ser
1456:     * acionado.
1457:     *
1458:     * O Confirmar ja nasce com este mesmo Enabled em ConfigurarBotoesAcao()
1459:     * (Fase 4), e aqui ele eh reafirmado de proposito: as duas atribuicoes leem
1460:     * a MESMA fonte unica (BO.this_lBloquear), e este metodo passa a ser o
1461:     * ponto por onde qualquer reavaliacao do bloqueio tem de passar - em vez de
1462:     * cada chamador tocar o Enabled de cada controle por conta propria.
1463:     *
1464:     * Chamado pelo InicializarForm DEPOIS de ConfigurarCamposPrazo E de
1465:     * ConfigurarBotoesAcao, nunca de dentro de um deles: os dois controles que
1466:     * ele toca nascem em metodos diferentes, e chamado cedo demais o metodo
1467:     * estoura "Unknown member CMD_4C_CONFIRMAR" (medido no VFP9).
1468:     *
1469:     * PUBLIC de proposito, pelo mesmo motivo de SincronizarCamposPrazo.
1470:     *==========================================================================
1471:     PROCEDURE AplicarBloqueioAlteracao()
1472:         *-- O bloqueio eh o INVERSO da habilitacao: pBlqAlt = .T. significa
1473:         *-- "so consulta", isto eh, campos e acao DESLIGADOS.
1474:         THIS.HabilitarCampos(!THIS.this_oBusinessObject.this_lBloquear)
1475:     ENDPROC
1476: 
1477:     *==========================================================================
1478:     * HabilitarCampos - liga ou desliga os controles de entrada desta tela
1479:     *
1480:     * Contem o que AplicarBloqueioAlteracao fazia em linha, e eh o nome
1481:     * canonico da arquitetura para esta responsabilidade. A separacao nao eh
1482:     * cosmetica: AplicarBloqueioAlteracao responde a pergunta do LEGADO
1483:     * ("ThisForm.Bloquear esta ligado?"), que eh regra de negocio lida do BO,
1484:     * enquanto HabilitarCampos executa o efeito na TELA. Mantidos juntos, todo
1485:     * chamador que quisesse apenas reavaliar o estado dos controles teria de
1486:     * reler a propriedade do BO por conta propria - e seria a segunda copia do
1487:     * mesmo criterio (CLAUDE.md #44, item 6).
1488:     *
1489:     * Os controles tocados sao os DOIS que o legado desliga, e sao todos os de
1490:     * entrada que a tela tem:
1491:     *   txt_4c_PrazoNovo (getNova)  - o unico campo digitavel
1492:     *   cmd_4c_Confirmar (altera)   - a unica acao que grava
1493:     *
1494:     * NAO entram, e nao eh omissao:
1495:     *   txt_4c_PrazoAtual - nasce ReadOnly = .T. + TabStop = .F. (o
1496:     *                       "Procedure When / Return .f." do legado). Habilitar
1497:     *                       ou desabilitar nao muda nada, e um Enabled = .F.
1498:     *                       deixaria o valor CINZA, divergindo do legado, que
1499:     *                       mostra a data vigente legivel nos dois modos.
1500:     *   grd_4c_Dados      - o legado faz o CONTRARIO com a grade: no caminho
1501:     *                       bloqueado eh justamente nela que ele poe o foco
1502:     *                       (".Gradevenc.SetFocus"), porque consultar o
1503:     *                       historico eh o que resta ao usuario. Desliga-la
1504:     *                       seria inverter a intencao do legado.
1505:     *   cmd_4c_Cancelar   - "sair" tem Cancel = .T. e eh a unica via de saida
1506:     *                       da tela, que nao tem barra de titulo
1507:     *                       (TitleBar = 0 / ControlBox = .F.). Desabilita-lo
1508:     *                       trancaria o usuario na janela.
1509:     *
1510:     * PUBLIC (sem PROTECTED): ao contrario de LimparCampos/BOParaForm/
1511:     * FormParaBO, este nome NAO existe em FormBase, logo nao ha escopo herdado
1512:     * a respeitar - e eh chamado por AplicarBloqueioAlteracao, que roda de
1513:     * FORA desta classe quando o InicializarForm ja devolveu o controle, alem
1514:     * de ser o ponto de entrada do harness para alternar o estado da tela.
1515:     *==========================================================================
1516:     PROCEDURE HabilitarCampos(par_lHabilitar)
1517:         LOCAL loc_lHabilitar
1518: 
1519:         *-- PCOUNT, nao VARTYPE: parametro LOGICO declarado e nao passado
1520:         *-- chega como .F., indistinguivel de um .F. passado de proposito.
1521:         *-- Omitido, o default eh HABILITAR - ligar a tela eh o estado normal.
1522:         loc_lHabilitar = IIF(PCOUNT() >= 1, par_lHabilitar, .T.)
1523: 
1524:         THIS.txt_4c_PrazoNovo.Enabled = loc_lHabilitar
1525:         THIS.cmd_4c_Confirmar.Enabled = loc_lHabilitar
1526:     ENDPROC
1527: 
1528:     *==========================================================================
1529:     * AplicarOrdemTabulacao - Transcreve os TabIndex declarados no dump
1530:     *
1531:     *   getNova  1  |  altera (Confirmar) 2  |  Gradevenc 3  |  Say1 4
1532:     *   getAtual 5  |  Say2 6                |  sair (Cancelar) 7
1533:     *
1534:     * cntSombra e seus dois labels nao tem TabIndex no dump - ficam com o que o
1535:     * VFP atribuir pela ordem de criacao, e nao afetam a navegacao porque
1536:     * Container e Label nao recebem foco.
1537:     *
1538:     * Atribuicao em ordem CRESCENTE do valor final, nao na ordem em que os
1539:     * controles foram criados: em VFP9 atribuir TabIndex INSERE o controle
1540:     * naquela posicao e EMPURRA os demais, de modo que percorrer 1..7 na ordem
1541:     * do valor desejado eh o que produz exatamente a ordem do dump.
1542:     *
1543:     * O unico campo digitavel (getNova) eh TabIndex 1, como no legado: o
1544:     * usuario entra na tela direto nele. getAtual aparece na ordem (5) por
1545:     * fidelidade ao dump, mas tem TabStop = .F. - o Tab nao para nele, igual ao
1546:     * "When / Return .f." do legado.
1547:     *==========================================================================
1548:     PROTECTED PROCEDURE AplicarOrdemTabulacao()
1549:         THIS.txt_4c_PrazoNovo.TabIndex  = 1    && getNova
1550:         THIS.cmd_4c_Confirmar.TabIndex  = 2    && altera
1551:         THIS.grd_4c_Dados.TabIndex      = 3    && Gradevenc
1552:         THIS.lbl_4c_PrazoAtual.TabIndex = 4    && Say1
1553:         THIS.txt_4c_PrazoAtual.TabIndex = 5    && getAtual
1554:         THIS.lbl_4c_PrazoNovo.TabIndex  = 6    && Say2
1555:         THIS.cmd_4c_Cancelar.TabIndex   = 7    && sair
1556:     ENDPROC
1557: 
1558:     *==========================================================================
1559:     * CarregarLista - Funil UNICO de carga e repinte da grade do historico.
1560:     *
1561:     * Equivale ao bloco do Init legado
1562:     *   .poDataMgr.AddCursor('SigOpMvv', 'cIdChaves', 'crSigOpMvv', '', '', lcQrySigOpMvv)
1563:     *   .poDataMgr.Requery('crSigOpMvv')
1564:     *   .GradeVenc.RecordSource = 'crSigOpMvv'
1565:     *   .GradeVenc.Column1.ControlSource = 'ttod(crSigOpMvv.Vencs)'
1566:     *   .GradeVenc.Column2.ControlSource = 'crSigOpMvv.Usuars'
1567:     *   .GradeVenc.Refresh
1568:     *
1569:     * O legado REBINDA a grade porque o AddCursor/Requery FECHA e RECRIA o
1570:     * cursor. Aqui nao se rebinda: o BO recarrega por ZAP + APPEND FROM DBF(),
1571:     * entao RecordSource, ControlSource, Width e Header1.Caption sobrevivem -
1572:     * repetir o bind mexeria em RecordSource sem necessidade e APAGARIA as
1573:     * larguras e as legendas postas em ConfigurarGradeHistorico.
1574:     *
1575:     * GO TOP + Refresh sao OBRIGATORIOS: popular o cursor NAO repinta a grade.
1576:     * Sem eles a grade fica visualmente vazia com o cursor cheio, e o sintoma
1577:     * ("a tela nao traz o historico") manda o diagnostico para SQL/permissao.
1578:     *
1579:     * Devolve o resultado do BO, nunca sucesso fabricado - mas ZERO LINHA eh
1580:     * resultado VALIDO (operacao que nunca teve troca de prazo), entao quem
1581:     * precisa aferir carga olha RECCOUNT do cursor, nao este retorno.
1582:     *
1583:     * PUBLIC (sem PROTECTED) de proposito: o harness de teste chama os metodos
1584:     * de carga direto no objeto do form, de FORA da classe, e
1585:     * BtnConfirmarClick torna a chamar este metodo depois de gravar, para a
1586:     * linha nova aparecer no historico sem fechar a tela.
1587:     *
1588:     * RETURN unico DEPOIS do ENDTRY, com flag loc_lSucesso: RETURN dentro de
1589:     * TRY/CATCH eh proibido em VFP9.
1590:     *==========================================================================
1591:     PROCEDURE CarregarLista()
1592:         LOCAL loc_cCursor, loc_lSucesso, loc_oErro
1593:         loc_lSucesso = .F.
1594: 
1595:         TRY
1596:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorHistorico
1597: 
1598:             IF !USED(loc_cCursor)
1599:                 THIS.this_oBusinessObject.CriarCursorHistorico()
1600:             ENDIF
1601: 
1602:             loc_lSucesso = THIS.this_oBusinessObject.CarregarHistorico()
1603: 
1604:             IF USED(loc_cCursor)
1605:                 SELECT (loc_cCursor)
1606:                 GO TOP
1607:             ENDIF
1608: 
1609:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1610:                 THIS.grd_4c_Dados.Refresh()
1611:             ENDIF
1612:         CATCH TO loc_oErro
1613:             MsgErro(loc_oErro.Message + CHR(13) + ;
1614:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1615:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnt.CarregarLista")
1616:         ENDTRY
1617: 
1618:         RETURN loc_lSucesso
1619:     ENDPROC
1620: 
1621:     *==========================================================================
1622:     * SincronizarEscolhaPai - Le o modo de trabalho do form PAI e o repassa ao
1623:     * BO, que o usa para decidir se o UPDATE de SigMvCab.PrazoEnts acontece.
1624:     *
1625:     * No legado: If llOks And (ThisForm.ParentForm.pcEscolha <> [ALTERAR]) -
1626:     * em modo ALTERAR e o proprio pai que grava o cabecalho, e este dialogo
1627:     * so arquiva o historico.
1628:     *
1629:     * Este form nao DECIDE modo nenhum: ele apenas RECEBE/LE o do pai (nao ha
1630:     * Incluir/Alterar/Visualizar/Excluir aqui). Por isso o valor nao e
1631:     * cacheado na abertura e esquecido: este metodo e o FUNIL de leitura, e
1632:     * BtnConfirmarClick torna a chama-lo imediatamente antes de gravar, para
1633:     * o dialogo nunca gravar com um modo que o pai ja trocou - o form legado
1634:     * era modal e de vida curta, este pode ficar aberto enquanto o pai muda de
1635:     * estado.
1636:     *
1637:     * Duas grafias sao aceitas, nesta ordem de precedencia: pcEscolha (a do
1638:     * frmcadastro legado e dos forms wrapper de VCX) e, se ela nao existir,
1639:     * this_cModoAtual (a do FormBase nesta arquitetura). Sem pai, ou sem
1640:     * nenhuma das duas, o BO fica com string vazia - que e diferente de
1641:     * ALTERAR e portanto NAO suprime o UPDATE, exatamente como o legado se
1642:     * comporta quando o pai nao esta em ALTERAR.
1643:     *
1644:     * PUBLIC de proposito: quem chama eh BtnConfirmarClick, que roda fora
1645:     * desta classe quando acionado por BINDEVENT.
1646:     *==========================================================================
1647:     PROCEDURE SincronizarEscolhaPai()
1648:         LOCAL loc_cEscolha, loc_oErro
1649:         loc_cEscolha = ""
1650: 
1651:         TRY
1652:             IF VARTYPE(THIS.this_oFormPai) = "O"
1653:                 IF PEMSTATUS(THIS.this_oFormPai, "pcEscolha", 5)
1654:                     IF VARTYPE(THIS.this_oFormPai.pcEscolha) = "C"
1655:                         loc_cEscolha = UPPER(ALLTRIM(THIS.this_oFormPai.pcEscolha))
1656:                     ENDIF
1657:                 ELSE
1658:                     IF PEMSTATUS(THIS.this_oFormPai, "this_cModoAtual", 5)
1659:                         IF VARTYPE(THIS.this_oFormPai.this_cModoAtual) = "C"
1660:                             loc_cEscolha = UPPER(ALLTRIM(THIS.this_oFormPai.this_cModoAtual))
1661:                         ENDIF
1662:                     ENDIF
1663:                 ENDIF
1664:             ENDIF
1665: 
1666:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1667:                 THIS.this_oBusinessObject.this_cEscolhaPai = loc_cEscolha
1668:             ENDIF
1669:         CATCH TO loc_oErro
1670:             MsgErro(loc_oErro.Message + CHR(13) + ;
1671:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1672:                 "Erro em FormSigOpEnt.SincronizarEscolhaPai")
1673:         ENDTRY
1674:     ENDPROC
1675: 
1676:     *==========================================================================
1677:     * VincularEventos - Liga os eventos dos TRES controles que o legado dota
1678:     * de codigo, e so eles:
1679:     *
1680:     *   altera.Valid   (botao Confirmar) -> BtnConfirmarClick
1681:     *   sair.Valid     (botao Cancelar)  -> BtnCancelarClick
1682:     *   getNova.Valid  (campo Nova Data) -> PrazoNovoLostFocus
1683:     *
1684:     * Nos dois botoes o legado usa "Valid", que em CommandButton do Framework
1685:     * Fortyus eh o evento que roda ao ser acionado (a classe fwbtng nao
1686:     * implementa Click proprio); o equivalente nativo aqui eh "Click", que
1687:     * tambem atende o ESC pelo Cancel = .T. do Cancelar. No campo, "Valid"

*-- Linhas 1693 a 1750:
1693:     *
1694:     * O getAtual tambem nao recebe evento: o "When / Return .f." dele ja foi
1695:     * traduzido em ReadOnly + TabStop = .F. na criacao do controle, e
1696:     * BINDEVENT em "When" nao funcionaria de todo modo (BINDEVENT DESCARTA o
1697:     * retorno do delegate, entao o bloqueio nunca aconteceria).
1698:     *
1699:     * Chamado pelo InicializarForm DEPOIS de todos os AddObject - os tres
1700:     * controles nascem em metodos diferentes (ConfigurarCamposPrazo e
1701:     * ConfigurarBotoesAcao), e vincular de dentro de um deles estouraria
1702:     * "Unknown member" no outro.
1703:     *
1704:     * Os tres delegates sao PUBLIC: BINDEVENT so alcanca metodo PUBLIC -
1705:     * PROTECTED falha em SILENCIO (regra #3).
1706:     *==========================================================================
1707:     PROTECTED PROCEDURE VincularEventos()
1708:         BINDEVENT(THIS.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
1709:         BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
1710:         BINDEVENT(THIS.txt_4c_PrazoNovo, "LostFocus", THIS, "PrazoNovoLostFocus")
1711:     ENDPROC
1712: 
1713:     *==========================================================================
1714:     * BtnConfirmarClick - porta de SIGOPENT.altera.Valid (linhas 545-599 do
1715:     * dump legado): a UNICA via de gravacao desta tela.
1716:     *
1717:     *   ldAnt = ThisForm.getAtual.Value
1718:     *   ldNew = ThisForm.getNova.Value
1719:     *   If Not Empty(ldNew)
1720:     *       Insert Into crSigOpMvv (...)  Values (..., fDtoSQL(ldAnt), ...)
1721:     *       llOks = .t.
1722:     *       pDtp = fDtoSQL(ldNew)
1723:     *       If llOks And (ThisForm.ParentForm.pcEscolha <> 'ALTERAR')
1724:     *           Update SigMvCab Set PrazoEnts = ?pDtp Where EmpDopNums = ...
1725:     *       EndIf
1726:     *       If llOks ... poDataMgr.Update('crSigOpMvv')  ... EndIf
1727:     *       If llOks ... poDataMgr.Commit()              ... EndIf
1728:     *       If Not llOks
1729:     *           ThisForm.poDataMgr.RollBack()
1730:     *       Else
1731:     *           ThisForm.pPrz = ldNew
1732:     *           thisform.parentform.validOk = .t.
1733:     *           ThisForm.ParentForm.cntEntregas.getEntregas.Value = ThisForm.pPrz
1734:     *           ThisForm.getAtual.Value = ThisForm.pPrz
1735:     *           ThisForm.getNova.Value  = Ctod('')
1736:     *       EndIf
1737:     *       ThisForm.getAtual.Refresh
1738:     *       ThisForm.getNova.Refresh
1739:     *       ThisForm.GradeVenc.Refresh
1740:     *   EndIf
1741:     *
1742:     * A sequencia INSERT + UPDATE + Commit/RollBack mora no BO
1743:     * (GravarAlteracaoPrazo), que eh onde esta a regra; aqui fica o que eh de
1744:     * TELA: validar, levar os valores dos campos ao BO, reler o modo do pai,
1745:     * devolver o resultado e repintar.
1746:     *
1747:     * CINCO pontos que o legado determina e que nao se devem "melhorar":
1748:     *
1749:     * 1) A tela NAO fecha ao confirmar. O legado nao chama Release aqui: ele
1750:     *    repoe "Data Atual" com o prazo recem-gravado, limpa "Nova Data" e

*-- Linhas 1775 a 1821:
1775:     * Os dois RETURN de guarda ficam FORA do TRY, e o corpo usa flag em vez
1776:     * de RETURN antecipado: RETURN dentro de TRY/CATCH eh proibido em VFP9.
1777:     *
1778:     * PUBLIC: eh alvo de BINDEVENT("Click") e tambem eh chamado direto, de
1779:     * fora da classe, pelo harness de teste (regra #3).
1780:     *==========================================================================
1781:     PROCEDURE BtnConfirmarClick()
1782:         LOCAL loc_oBO, loc_dNovo, loc_oErro
1783: 
1784:         *-- Reentrancia: os dialogos deste caminho devolvem o foco e podem
1785:         *-- redisparar o Click, o que gravaria o historico duas vezes.
1786:         IF THIS.this_lConfirmandoPrazo
1787:             RETURN
1788:         ENDIF
1789: 
1790:         *-- Com pBlqAlt = .T. o legado desliga o botao (.altera.Enabled = .f.)
1791:         *-- e nao ha como acionar a gravacao. O teste explicito existe porque
1792:         *-- o harness chama este metodo direto, sem passar pelo controle.
1793:         IF !THIS.cmd_4c_Confirmar.Enabled
1794:             RETURN
1795:         ENDIF
1796: 
1797:         THIS.this_lConfirmandoPrazo = .T.
1798: 
1799:         TRY
1800:             loc_oBO = THIS.this_oBusinessObject
1801: 
1802:             *-- O getNova.Valid (TabIndex 1) roda ANTES do altera.Click
1803:             *-- (TabIndex 2) em VFP nativo; aqui o encadeamento eh explicito,
1804:             *-- consumindo o veredicto que o LostFocus acabou de produzir.
1805:             IF !THIS.GarantirPrazoNovoValidado()
1806:                 *-- "Return .f." num Valid nativo deixa o foco preso no campo
1807:                 THIS.txt_4c_PrazoNovo.SetFocus()
1808:             ELSE
1809:                 *-- "ldAnt = getAtual.Value / ldNew = getNova.Value"
1810:                 *--
1811:                 *-- As duas leituras agora passam pelo hook canonico
1812:                 *-- FormParaBO, que eh a fonte UNICA desta transferencia (o
1813:                 *-- corpo saiu daqui na Fase 8, nao foi duplicado). Recusando,
1814:                 *-- ele ja reportou o motivo e loc_dNovo permanece vazio - o
1815:                 *-- "If Not Empty" abaixo barra a gravacao, de modo que nada
1816:                 *-- eh gravado com o BO pela metade (regra #20).
1817:                 loc_dNovo = {}
1818:                 IF THIS.FormParaBO()
1819:                     loc_dNovo = loc_oBO.this_dPrazoNovo
1820:                 ENDIF
1821: 

*-- Linhas 1854 a 2133:
1854:         CATCH TO loc_oErro
1855:             MsgErro(loc_oErro.Message + CHR(13) + ;
1856:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1857:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnt.BtnConfirmarClick")
1858:         ENDTRY
1859: 
1860:         THIS.this_lConfirmandoPrazo = .F.
1861:     ENDPROC
1862: 
1863:     *==========================================================================
1864:     * NotificarFormPai - devolve a tela chamadora o resultado da confirmacao,
1865:     * espelhando as duas linhas do altera.Valid legado:
1866:     *
1867:     *   thisform.parentform.validOk = .t.
1868:     *   ThisForm.ParentForm.cntEntregas.getEntregas.Value = ThisForm.pPrz
1869:     *
1870:     * A primeira linha eh a flag de sucesso que o pai consulta; a segunda
1871:     * escreve o novo prazo no campo "Entregas" do pai, para a tela de
1872:     * movimentacao exibir o valor atualizado sem recarregar.
1873:     *
1874:     * As DUAS sao guardadas por PEMSTATUS porque o PILAR 3 renomeia os objetos
1875:     * do form migrado: "cntEntregas.getEntregas" so existe no pai que ainda
1876:     * seja wrapper do VCX legado. Na flag aceita-se a grafia legado (validOk)
1877:     * e, se ela nao existir, a convencao desta arquitetura (this_lValidOk) -
1878:     * mesmo criterio de duas grafias ja usado em SincronizarEscolhaPai.
1879:     *
1880:     * Pai inexistente, ou pai sem nenhum desses membros, NAO eh erro: o
1881:     * resultado continua disponivel ao chamador por ObterPrazoConfirmado(),
1882:     * que eh o contrato de retorno desta arquitetura (o dialogo fecha com
1883:     * Hide e seus dados seguem legiveis). Por isso nao ha mensagem aqui -
1884:     * avisar o usuario sobre o layout do form pai nao o ajudaria em nada.
1885:     *
1886:     * Escrever no Value do pai pode disparar eventos dele, e o CATCH existe
1887:     * para que uma falha LA nao derrube a confirmacao que JA foi gravada aqui.
1888:     *
1889:     * PUBLIC pelo mesmo motivo de SincronizarEscolhaPai: eh chamado de
1890:     * BtnConfirmarClick, que roda de fora desta classe via BINDEVENT.
1891:     *==========================================================================
1892:     PROCEDURE NotificarFormPai()
1893:         LOCAL loc_oPai, loc_dPrazo, loc_oErro
1894: 
1895:         IF VARTYPE(THIS.this_oFormPai) <> "O"
1896:             RETURN
1897:         ENDIF
1898: 
1899:         loc_oPai   = THIS.this_oFormPai
1900:         loc_dPrazo = ConverterParaData(THIS.this_oBusinessObject.this_dPrazoAtual)
1901: 
1902:         TRY
1903:             *-- "thisform.parentform.validOk = .t."
1904:             IF PEMSTATUS(loc_oPai, "validOk", 5)
1905:                 loc_oPai.validOk = .T.
1906:             ELSE
1907:                 IF PEMSTATUS(loc_oPai, "this_lValidOk", 5)
1908:                     loc_oPai.this_lValidOk = .T.
1909:                 ENDIF
1910:             ENDIF
1911: 
1912:             *-- "ParentForm.cntEntregas.getEntregas.Value = ThisForm.pPrz"
1913:             IF PEMSTATUS(loc_oPai, "cntEntregas", 5)
1914:                 IF VARTYPE(loc_oPai.cntEntregas) = "O"
1915:                     IF PEMSTATUS(loc_oPai.cntEntregas, "getEntregas", 5)
1916:                         IF VARTYPE(loc_oPai.cntEntregas.getEntregas) = "O"
1917:                             loc_oPai.cntEntregas.getEntregas.Value = loc_dPrazo
1918:                             loc_oPai.cntEntregas.getEntregas.Refresh()
1919:                         ENDIF
1920:                     ENDIF
1921:                 ENDIF
1922:             ENDIF
1923:         CATCH TO loc_oErro
1924:             MsgErro(loc_oErro.Message + CHR(13) + ;
1925:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1926:                 "Erro em FormSigOpEnt.NotificarFormPai")
1927:         ENDTRY
1928:     ENDPROC
1929: 
1930:     *==========================================================================
1931:     * ObterPrazoConfirmado - contrato de retorno do dialogo: o prazo de
1932:     * entrega que ficou vigente, ou data vazia quando nada foi gravado.
1933:     *
1934:     * Existe porque o legado devolvia o resultado escrevendo DIRETO num
1935:     * controle do pai (cntEntregas.getEntregas), caminho que so sobrevive
1936:     * enquanto esse pai for o wrapper do VCX - o PILAR 3 renomeia os objetos
1937:     * do form migrado. Quem abrir este dialogo por CREATEOBJECT + Show() le
1938:     * aqui o valor, depois do Show() e ANTES do Release(), do mesmo modo que
1939:     * o projeto ja faz com FormBuscaAuxiliar.
1940:     *
1941:     * Eh LEITURA do estado do BO, nao uma segunda copia dele: a fonte unica
1942:     * continua sendo this_dPrazoAtual, e this_lGravouPrazo (o validOk do
1943:     * legado) eh o que distingue "confirmou" de "fechou sem gravar".
1944:     *
1945:     * PUBLIC: eh justamente o metodo que o form chamador le de fora.
1946:     *==========================================================================
1947:     FUNCTION ObterPrazoConfirmado()
1948:         LOCAL loc_dPrazo
1949:         loc_dPrazo = {}
1950: 
1951:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1952:             IF THIS.this_oBusinessObject.this_lGravouPrazo
1953:                 loc_dPrazo = ConverterParaData(THIS.this_oBusinessObject.this_dPrazoAtual)
1954:             ENDIF
1955:         ENDIF
1956: 
1957:         RETURN loc_dPrazo
1958:     ENDFUNC
1959: 
1960:     *==========================================================================
1961:     * BtnCancelarClick - porta de SIGOPENT.sair.Valid, que eh uma linha so:
1962:     *
1963:     *   ThisForm.Release
1964:     *
1965:     * Fecha a tela sem gravar nada. Com Cancel = .T. no botao (transcrito do
1966:     * dump), o ESC tambem desemboca aqui - era assim no legado e continua
1967:     * sendo a via de saida do teclado.
1968:     *
1969:     * PUBLIC: alvo de BINDEVENT("Click") e chamado direto pelo harness de
1970:     * teste (regra #3).
1971:     *==========================================================================
1972:     PROCEDURE BtnCancelarClick()
1973:         THIS.FecharDialogo()
1974:     ENDPROC
1975: 
1976:     *==========================================================================
1977:     * FecharDialogo - funil UNICO de fechamento da tela.
1978:     *
1979:     * Fecha com Hide(), NAO com Release(), apesar de o legado escrever
1980:     * "ThisForm.Release": medido no VFP9, Release() DESTROI o objeto mesmo com
1981:     * o chamador segurando a referencia (loForm passa a VARTYPE "X" e a
1982:     * leitura seguinte estoura "is not an object") - form object nao segue
1983:     * refcount. Como este dialogo tem resultado a devolver
1984:     * (ObterPrazoConfirmado, e o estado do BO que o pai consulta), fechar com
1985:     * Release deixaria esse resultado INALCANCAVEL, que eh o defeito ja
1986:     * catalogado no projeto.
1987:     *
1988:     * Para o usuario nada muda - Hide() em form modal tambem devolve do
1989:     * Show() e a janela desaparece do mesmo jeito (PILAR 1 preservado); muda
1990:     * so o tempo de vida do objeto, que eh PILAR 3. Eh o desenho que o
1991:     * FormBuscaAuxiliar desta arquitetura ja adota, e por isso os chamadores
1992:     * do projeto ja esperam chamar Release() eles mesmos depois de ler.
1993:     *
1994:     * Nao ha efeito externo a antecipar antes do Hide: o unico valor que o
1995:     * legado empurrava para o pai (validOk e o campo de entregas) ja foi
1996:     * escrito em NotificarFormPai, no instante da confirmacao, e o Destroy
1997:     * daqui so fecha cursores desta sessao privada.
1998:     *
1999:     * PROTECTED: so os botoes desta classe fecham a tela. Quem abriu o
2000:     * dialogo encerra com Release(), nao por este metodo.
2001:     *==========================================================================
2002:     PROTECTED PROCEDURE FecharDialogo()
2003:         THIS.Hide()
2004:     ENDPROC
2005: 
2006:     *==========================================================================
2007:     * TornarControlesVisiveis - Torna visiveis os controles criados via
2008:     * AddObject (nascem com Visible = .F.), percorrendo Pages e Controls
2009:     * recursivamente.
2010:     *==========================================================================
2011:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2012:         LOCAL loc_nI, loc_nP, loc_oObjeto
2013: 
2014:         IF VARTYPE(par_oContainer) <> "O"
2015:             RETURN
2016:         ENDIF
2017: 
2018:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2019:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2020: 
2021:             IF VARTYPE(loc_oObjeto) = "O"
2022:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2023:                     loc_oObjeto.Visible = .T.
2024:                 ENDIF
2025: 
2026:                 IF UPPER(loc_oObjeto.BaseClass) == "PAGEFRAME"
2027:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2028:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2029:                     ENDFOR
2030:                 ENDIF
2031: 
2032:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2033:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2034:                 ENDIF
2035:             ENDIF
2036:         ENDFOR
2037:     ENDPROC
2038: 
2039:     *==========================================================================
2040:     * Activate - Foco inicial da tela: a outra metade do "If ThisForm.Bloquear"
2041:     * que encerra o Init legado
2042:     *
2043:     *   If ThisForm.Bloquear
2044:     *       .GetNova.Enabled = .f.
2045:     *       .altera.Enabled  = .f.
2046:     *       .Gradevenc.SetFocus
2047:     *   Else
2048:     *       .getNova.SetFocus
2049:     *   Endif
2050:     *
2051:     * Os dois Enabled moram em AplicarBloqueioAlteracao(), que roda junto com a
2052:     * criacao dos controles. Aqui fica SO o SetFocus, por um motivo concreto:
2053:     * no legado o Init roda com a janela ja criada pelo "Do Form", mas nesta
2054:     * arquitetura o InicializarForm roda DENTRO do CREATEOBJECT, antes de
2055:     * qualquer Show() - e SetFocus em form que ainda nao apareceu nao posiciona
2056:     * nada. O Activate dispara quando a janela se torna ativa, isto e no
2057:     * primeiro Show(), que eh exatamente o instante em que o foco do legado se
2058:     * estabelecia.
2059:     *
2060:     * Por isso tambem o par Enabled NAO pode morar aqui: em modo de teste e em
2061:     * validacao de UI o form nunca eh exibido, o Activate nao roda, e o
2062:     * bloqueio vindo de pBlqAlt = .T. seria silenciosamente perdido.
2063:     *
2064:     * One-shot pela flag: Activate dispara TODA vez que a janela volta a ser a
2065:     * ativa - por exemplo quando o dialogo de autorizacao de prazo (SigOpSen)
2066:     * fecha. Sem a flag, o foco seria puxado de volta para o campo da data nova
2067:     * no meio do fluxo de confirmacao, desfazendo o posicionamento que o proprio
2068:     * handler acabou de fazer.
2069:     *
2070:     * O VARTYPE do BO vem em IF SEPARADO, nao num AND: VFP9 nao faz
2071:     * short-circuit, entao a segunda metade seria avaliada de qualquer jeito.
2072:     *==========================================================================
2073:     PROCEDURE Activate()
2074:         LOCAL loc_lBloqueado
2075: 
2076:         IF !THIS.this_lFocoInicialAplicado
2077:             THIS.this_lFocoInicialAplicado = .T.
2078: 
2079:             loc_lBloqueado = .F.
2080:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2081:                 loc_lBloqueado = THIS.this_oBusinessObject.this_lBloquear
2082:             ENDIF
2083: 
2084:             IF loc_lBloqueado
2085:                 *-- Alteracao bloqueada: o legado joga o foco na grade do
2086:                 *-- historico, que eh tudo o que resta ao usuario
2087:                 THIS.grd_4c_Dados.SetFocus()
2088:             ELSE
2089:                 THIS.txt_4c_PrazoNovo.SetFocus()
2090:             ENDIF
2091:         ENDIF
2092: 
2093:         DODEFAULT()
2094:     ENDPROC
2095: 
2096:     *==========================================================================
2097:     * Destroy - Fecha os cursores de trabalho do BO (equivalente ao
2098:     * ThisForm.poDataMgr.Release do "Procedure Release" legado) e solta a
2099:     * referencia ao form pai, para o dialogo filho nao manter vivo quem o
2100:     * abriu.
2101:     *
2102:     * USE IN basta e nao precisa de TABLEREVERT antes: USE IN fecha o alias
2103:     * mesmo com buffer sujo, enquanto TABLEREVERT em cursor sem buffering
2104:     * (que e como CREATE CURSOR e SQLEXEC os criam) dispara erro 1586.
2105:     *
2106:     * DODEFAULT() na ULTIMA linha e obrigatorio: e o FormBase.Destroy que
2107:     * libera o Business Object e reconstroi os popups do menu principal.
2108:     *==========================================================================
2109:     PROCEDURE Destroy()
2110:         LOCAL loc_oErro
2111: 
2112:         TRY
2113:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2114:                 IF USED(THIS.this_oBusinessObject.this_cCursorHistorico)
2115:                     USE IN (THIS.this_oBusinessObject.this_cCursorHistorico)
2116:                 ENDIF
2117:                 IF USED(THIS.this_oBusinessObject.this_cCursorOperacao)
2118:                     USE IN (THIS.this_oBusinessObject.this_cCursorOperacao)
2119:                 ENDIF
2120:                 IF USED(THIS.this_oBusinessObject.this_cCursorConfigDoc)
2121:                     USE IN (THIS.this_oBusinessObject.this_cCursorConfigDoc)
2122:                 ENDIF
2123:             ENDIF
2124: 
2125:             THIS.this_oFormPai = .NULL.
2126:         CATCH TO loc_oErro
2127:             MsgErro(loc_oErro.Message, "Erro em FormSigOpEnt.Destroy")
2128:         ENDTRY
2129: 
2130:         DODEFAULT()
2131:     ENDPROC
2132: 
2133: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpEntBO.prg):
*==============================================================================
* SigOpEntBO.prg
*
* Business Object para SigOpEnt - "Alteracao de Data de Entrega", dialogo
* filho aberto pela tela de movimentacao (form OPERACIONAL, WindowType = 1).
*
* Tabela principal: SigOpMvv - historico das datas de entrega de UMA
* movimentacao. Cada troca de prazo grava em SigOpMvv a data que esta SAINDO
* (coluna vencs) e atualiza SigMvCab.PrazoEnts com a data nova.
*
* Origem legado: tasks\task731\SigOpEnt_form_codigo_fonte.txt
*   SIGOPENT.Init          - recebe pEmp, pDop, pNum, pPrz, pFor, pMin, pDat,
*                            pBlqAlt, pMax do form pai e carrega 3 cursores
*                            (crSigOpMvv, crSigCdOpe, crSigOpCdd)
*   SIGOPENT.getNova.Valid - valida a data digitada contra pDat / pMin / pMax
*   SIGOPENT.altera.Valid  - grava o historico e atualiza SigMvCab
*
* Esta tela NAO eh um cadastro CRUD: nao tem lista com Incluir/Alterar/
* Excluir. O unico caminho de gravacao eh o botao Confirmar, que INSERE uma
* linha de historico em SigOpMvv e faz o UPDATE de SigMvCab.PrazoEnts.
*==============================================================================

DEFINE CLASS SigOpEntBO AS BusinessBase

    *--------------------------------------------------------------------------
    * COLUNAS DE SigOpMvv - grafia EXATA do docs\schema.sql (PILAR 2)
    *
    *   cidchaves  char(20)      NOT NULL   PK (sigopmvv_cidchaves)
    *   emps       char(3)       NOT NULL
    *   dopcs      char(20)      NOT NULL
    *   notitulos  numeric(6,0)  NOT NULL
    *   empdopncs  char(29)      NOT NULL
    *   vencs      datetime      NULL
    *   datas      datetime      NULL
    *   usuars     char(10)      NOT NULL
    *
    * As 6 colunas NOT NULL tem propriedade propria aqui (regra #22): a PK
    * cidchaves vem de fUniqueIds() - NUNCA string vazia, senao a segunda
    * linha de historico colide no indice unico - e usuars vem de
    * gc_4c_UsuarioLogado. O legado grava exatamente estas 8 colunas
    * (Emps, Dopcs, NoTitulos, Vencs, EmpDopNcs, cIdChaves, Usuars, Datas),
    * ou seja a lista do schema e a do legado coincidem.
    *--------------------------------------------------------------------------
    this_cCidChaves = ""            && cidchaves  char(20)     - PK, fUniqueIds()
    this_cEmps = ""                 && emps       char(3)      - empresa (pEmp)
    this_cDopcs = ""                && dopcs      char(20)     - documento/operacao (pDop)
    this_nNoTitulos = 0             && notitulos  numeric(6,0) - numero da operacao (pNum)
    this_cEmpDopNcs = ""            && empdopncs  char(29)     - chave posicional
    this_dVencs = {}                && vencs      datetime     - data de entrega ARQUIVADA
    this_dDatas = {}                && datas      datetime     - data/hora do registro
    this_cUsuars = ""               && usuars     char(10)     - usuario que alterou

    *--------------------------------------------------------------------------
    * CHAVE POSICIONAL empdopncs char(29) - regra #42
    *
    * O legado monta a chave concatenando SEM ALLTRIM:
    *   ThisForm.pEmp + ThisForm.pDop + Str(ThisForm.pNum, 6)
    * As larguras vem das COLUNAS: emps char(3) + dopcs char(20) + STR(,6)
    * = 29 = empdopncs char(29). O padding FAZ PARTE da chave: encurtar
    * qualquer parte com ALLTRIM devolve ZERO linha em silencio. A montagem
    * usa PADR explicito sobre as larguras do schema, porque as propriedades
    * deste BO recebem os valores do form pai ja com ALLTRIM.
    *
    * A MESMA chave de 29 caracteres eh o filtro do UPDATE de SigMvCab
    * (Where EmpDopNums = ...), por isso uma unica propriedade atende aos
    * dois usos.
    *--------------------------------------------------------------------------
    this_nLarguraEmps = 3           && largura de SigOpMvv.emps  no schema
    this_nLarguraDopcs = 20         && largura de SigOpMvv.dopcs no schema
    this_nLarguraNoTitulos = 6      && digitos de STR(notitulos, 6) na chave

    *--------------------------------------------------------------------------
    * PARAMETROS RECEBIDOS DO FORM PAI
    *
    * O legado guarda estes valores em propriedades do proprio form (pEmp,
    * pDop, pNum, pPrz, pMin, pMax, pDat, Bloquear - ver RESERVED3 ClassInfo
    * do dump). Aqui eles vivem no BO, porque sao o insumo da validacao e da
    * gravacao. pFor (a referencia ao form pai) NAO vem para o BO: continua
    * sendo assunto do Form.
    *
    * As datas sao declaradas como DATE ({}) porque chegam de TextBox e de
    * propriedade do form pai, nao de coluna datetime do SQL Server - por
    * isso toda normalizacao usa ConverterParaData(), nunca TTOD(), que com
    * DATE dispara erro 11 em runtime (regra #16).
    *--------------------------------------------------------------------------
    this_dPrazoAtual = {}           && pPrz    - data de entrega vigente (SigMvCab.PrazoEnts)
    this_dPrazoNovo = {}            && valor digitado em getNova
    this_dDataMovimento = {}        && pDat    - data da movimentacao
    this_nPrazoMinimo = 0           && pMin    - dias minimos contados de pDat
    this_nPrazoMaximo = 0           && pMax    - dias maximos contados de pDat
    this_lBloquear = .F.            && pBlqAlt - .T. bloqueia a alteracao (so consulta)

    *--------------------------------------------------------------------------
    * CONTEXTO DO FORM PAI QUE DECIDE O UPDATE DE SigMvCab
    *
    * No legado: If llOks And (ThisForm.ParentForm.pcEscolha <> 'ALTERAR').
    * O UPDATE de SigMvCab.PrazoEnts SO acontece quando o pai NAO esta em
    * modo ALTERAR - nesse modo o proprio pai grava o cabecalho. O historico
    * em SigOpMvv, ao contrario, eh gravado nos dois casos.
    *--------------------------------------------------------------------------
    this_cEscolhaPai = ""           && ParentForm.pcEscolha ("INSERIR"/"ALTERAR"/...)
    this_cModoNaoAtualizaCabecalho = "ALTERAR"   && valor que SUPRIME o UPDATE de SigMvCab

    *--------------------------------------------------------------------------
    * CONFIGURACAO LIDA DOS CURSORES DE APOIO (CursorQuery do Init legado)
    *
    * Ambas sao numeric(1,0) NOT NULL no schema, portanto chegam ao VFP como
    * NUMERICO - propriedade this_n*, comparada com numero.
    *
    *   SigCdOpe.dtentrs  - regra de exigencia do prazo de entrega. O legado
    *                       so exige/valida a data quando InList(DtEntrs, 1, 4, 6).
    *   SigOpCdd.chkuteis - indica se a contagem de dias considera dias uteis.
    *--------------------------------------------------------------------------
    this_nDtEntrs = 0               && SigCdOpe.dtentrs  numeric(1,0)
    this_nChkUteis = 0              && SigOpCdd.chkuteis numeric(1,0)

    *--------------------------------------------------------------------------
    * ALIASES DOS CURSORES
    *
    * Equivalencia com o legado:
    *   crSigOpMvv  -> cursor_4c_Dados      (alimenta a grade Gradevenc)
    *   crSigCdOpe  -> cursor_4c_Operacao   (CursorQuery SigCdOpe / Dopes / DtEntrs)
    *   crSigOpCdd  -> cursor_4c_ConfigDoc  (CursorQuery SigOpCdd / Dopes / chkUteis)
    *--------------------------------------------------------------------------
    this_cCursorHistorico = "cursor_4c_Dados"
    this_cCursorOperacao = "cursor_4c_Operacao"
    this_cCursorConfigDoc = "cursor_4c_ConfigDoc"

    *--------------------------------------------------------------------------
    * LIBERACAO POR SENHA (Do Form SigOpSen With 'LIBPRZENT', ...)
    *
    * Quando a data digitada fica fora da faixa pMin..pMax, o legado pede
    * autorizacao pelo programa LIBPRZENT e, autorizado, registra a liberacao
    * com fGravarLog('T', pDop, 'LIBPRZENT', <transacao>, <usuario liberador>).
    * O codigo do programa eh constante no legado e fica aqui para o texto do
    * log e a chamada da autorizacao usarem a MESMA grafia.
    *--------------------------------------------------------------------------
    this_cProgramaLiberacao = "LIBPRZENT"
    this_cTituloLiberacao = "Libera Prazo de Entrega"
    this_cUsuarioLiberacao = ""     && usuario que autorizou (retorno do SigOpSen)
    this_lPrazoLiberado = .F.       && .T. quando a autorizacao foi concedida

    *--------------------------------------------------------------------------
    * ESTADO DA ULTIMA GRAVACAO
    *
    * O legado controla commit/rollback com a flag local llOks e avisa o pai
    * do sucesso com thisform.parentform.validOk = .t. - o Form le esta
    * propriedade para decidir se repassa o novo prazo ao pai.
    *--------------------------------------------------------------------------
    this_lGravouPrazo = .F.         && .T. quando historico e cabecalho gravaram

    *====================================================================
    * Init - Inicializa Business Object
    *
    * this_cCampoChave usa a grafia do schema (cidchaves), que eh a PK
    * declarada em CONSTRAINT [sigopmvv_cidchaves].
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela = "SigOpMvv"
        THIS.this_cCampoChave = "cidchaves"

        *-- usuars eh NOT NULL char(10): nasce com o usuario logado, o mesmo
        *-- Usuar global que o INSERT do legado usa. O guard de TYPE existe
        *-- porque probe/teste headless pode instanciar o BO antes do startup
        *-- ter definido a variavel publica.
        IF TYPE("gc_4c_UsuarioLogado") = "C"
            THIS.this_cUsuars = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)
        ELSE
            THIS.this_cUsuars = ""
        ENDIF

        *-- Nenhuma gravacao nem liberacao aconteceu nesta instancia ainda.
        THIS.this_lGravouPrazo = .F.
        THIS.this_lPrazoLiberado = .F.
        THIS.this_cUsuarioLiberacao = ""

        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - PK da linha de historico gravada por Inserir()
    *
    * Fica PROTECTED pela heranca de BusinessBase (regra #51 do CLAUDE.md:
    * PROTECTED declarado em QUALQUER classe da cadeia prevalece) - quem
    * usa isto eh RegistrarAuditoria(), chamado de dentro do proprio BO.
    *====================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega uma linha de SigOpMvv (cursor_4c_Dados,
    * equivalente ao crSigOpMvv do legado) para as propriedades do BO.
    *
    * Esta tela NUNCA altera uma linha de historico existente - cada
    * confirmacao sempre INSERE uma linha nova (ver cabecalho da classe).
    * Este metodo serve para inspecionar uma linha ja gravada (detalhe da
    * grade Gradevenc), nao para reabrir edicao; this_lNovoRegistro = .F.
    * segue o padrao canonico do projeto (BlqBO.CarregarDoCursor e
    * similares), mesmo que esta tela nao tenha fluxo de ALTERAR.
    *
    * Uso de SELECT (par_cAliasCursor) + campo direto, nunca
    * campo (regra #9 - sintaxe invalida em VFP9).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_cEmps      = TratarNulo(emps, "C")
            THIS.this_cDopcs     = TratarNulo(dopcs, "C")
            THIS.this_nNoTitulos = TratarNulo(notitulos, 0)
            THIS.this_cEmpDopNcs = TratarNulo(empdopncs, "C")
            THIS.this_dVencs     = TratarNulo(vencs, {})
            THIS.this_dDatas     = TratarNulo(datas, {})
            THIS.this_cUsuars    = TratarNulo(usuars, "C")
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * MontarChaveEmpDopNums - Chave POSICIONAL de 29 caracteres, usada
    * tanto no INSERT de SigOpMvv.empdopncs quanto no WHERE do UPDATE de
    * SigMvCab.empdopnums (mesmo VALOR, nomes de coluna diferentes - o
    * legado monta os dois com a mesma expressao).
    *
    * Regra #42: o legado monta SEM ALLTRIM -
    *   ThisForm.pEmp + ThisForm.pDop + Str(ThisForm.pNum, 6)
    * - e o padding FAZ PARTE da chave: emps char(3) + dopcs char(20) +
    * STR(,6) = 29 caracteres = largura EXATA das colunas empdopncs e
    * empdopnums no schema. Usa PADR explicito sobre as larguras do
    * SCHEMA (this_nLarguraEmps/Dopcs/NoTitulos), porque this_cEmps e
    * this_cDopcs chegam a este BO ja com ALLTRIM (vindos do form pai) -
    * encurtar qualquer parte faz a chave NUNCA casar, sem erro nenhum.
    *====================================================================
    PROTECTED FUNCTION MontarChaveEmpDopNums()
        RETURN PADR(THIS.this_cEmps, THIS.this_nLarguraEmps) + ;
               PADR(THIS.this_cDopcs, THIS.this_nLarguraDopcs) + ;
               STR(THIS.this_nNoTitulos, THIS.this_nLarguraNoTitulos)
    ENDFUNC

    *====================================================================
    * CarregarConfiguracaoOperacao - Carrega as duas configuracoes de apoio
    * que o Init legado busca com CursorQuery, ANTES de liberar a tela:
    *
    *   .poDataMgr.CursorQuery('SigCdOpe', 'crSigCdOpe', 'Dopes', .pDop, 'DtEntrs')
    *   If Not Used('crSigCdOpe')
    *       =MessageBox('Favor Reinicializar o Processo!!!', 16, ...)
    *       Return .f.
    *   EndIf
    *   .poDataMgr.CursorQuery('SigOpCdd', 'crSigOpCdd', 'Dopes', .pDop, 'chkUteis')
    *   If Not Used('crSigOpCdd')
    *       ... Return .f.
    *   EndIf
    *
    * As DUAS consultas sao requisito de ABERTURA no legado: falhando
    * qualquer uma, o Init devolve .f. e o "Do Form" inteiro nao chega a
    * abrir. Aqui o mesmo efeito vem do RETURN .F. deste metodo, que o
    * InicializarForm do Form usa para abortar o CREATEOBJECT.
    *
    * this_nDtEntrs eh o que ValidarPrazoNovo (Form) usa depois
    * (InList(DtEntrs,1,4,6) do getNova.Valid legado). this_nChkUteis eh
    * carregado pelo mesmo motivo do legado - a abertura da tela depende
    * das DUAS consultas terem sucesso -, mas nenhum dos 7 metodos com
    * codigo do dump chega a LER o valor depois de carregado: fica
    * disponivel sem logica adicional inventada (regra CLAUDE.md
    * REGRA FUNDAMENTAL - nao omitir, mas tambem nao inventar uso que o
    * legado nao tem).
    *
    * Sem conexao (gnConnHandle invalido - probe headless, validacao de UI)
    * os dois valores ficam no default 0 e o metodo devolve .T.: nao ha
    * banco para consultar, e abortar a tela nesse modo impediria qualquer
    * teste automatizado de instanciar o form.
    *
    * EVALUATE(<alias> + ".<campo>") para LEITURA eh seguro (regra #15) -
    * so a ATRIBUICAO com "=" dentro da string eh que nao funciona.
    *
    * RETURN unico DEPOIS do ENDTRY, com flag loc_lSucesso: RETURN dentro
    * de TRY/CATCH eh proibido em VFP9.
    *
    * PUBLIC (sem PROTECTED) de proposito: quem chama eh o
    * InicializarForm() do Form, de FORA da classe.
    *====================================================================
    PROCEDURE CarregarConfiguracaoOperacao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                *-- Sem conexao: mesmo criterio de CarregarHistorico - nao
                *-- ha banco para consultar, e isso nao e falha.
                loc_lSucesso = .T.
            ELSE
                IF USED(THIS.this_cCursorOperacao)
                    USE IN (THIS.this_cCursorOperacao)
                ENDIF

                loc_cSQL = "SELECT DtEntrs FROM SigCdOpe" + ;
                    " WHERE Dopes = " + EscaparSQL(THIS.this_cDopcs)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOperacao)

                IF loc_nResult >= 0 AND USED(THIS.this_cCursorOperacao) ;
                        AND !EOF(THIS.this_cCursorOperacao)

                    THIS.this_nDtEntrs = NVL(EVALUATE(THIS.this_cCursorOperacao + ".DtEntrs"), 0)

                    IF USED(THIS.this_cCursorConfigDoc)
                        USE IN (THIS.this_cCursorConfigDoc)
                    ENDIF

                    loc_cSQL = "SELECT chkUteis FROM SigOpCdd" + ;
                        " WHERE Dopes = " + EscaparSQL(THIS.this_cDopcs)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorConfigDoc)

                    IF loc_nResult >= 0 AND USED(THIS.this_cCursorConfigDoc) ;
                            AND !EOF(THIS.this_cCursorConfigDoc)
                        THIS.this_nChkUteis = NVL(EVALUATE(THIS.this_cCursorConfigDoc + ".chkUteis"), 0)
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                        MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + ;
                            "o (CursorQuery - SigOpCdd)")
                        THIS.this_lErroExibido = .T.
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + ;
                        "o (CursorQuery - SigCdOpe)")
                    THIS.this_lErroExibido = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpEntBO.CarregarConfiguracaoOperacao")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CriarCursorHistorico - Cria o cursor VAZIO que alimenta a grade do
    * historico (this_cCursorHistorico, o crSigOpMvv do legado).
    *
    * Este metodo eh a FONTE UNICA da estrutura desse cursor: nomes, tipos e
    * ORDEM aqui tem de ser os MESMOS da lista do SELECT de
    * CarregarHistorico(), porque a recarga eh por ZAP + APPEND FROM DBF(),
    * que casa coluna por NOME. Por isso o Form CHAMA este metodo e NUNCA
    * declara a estrutura de novo - duas declaracoes com ordem ou grafia
    * diferentes eh o defeito classico dos forms OPERACIONAIS.
    *
    * Tipos conforme docs\schema.sql (SIGOPMVV): cidchaves char(20),
    * emps char(3), dopcs char(20), notitulos numeric(6,0),
    * empdopncs char(29), vencs datetime, datas datetime, usuars char(10).
    *
    * SET NULL ON em volta do CREATE CURSOR: vencs e datas sao NULL-aveis no
    * SQL Server, e sem campos NULL-aveis o APPEND FROM de uma linha com
    * NULL falha.
    *
    * O alias eh fechado com USE IN e SEM TABLEREVERT antes: USE IN fecha
    * mesmo com buffer sujo, enquanto TABLEREVERT em cursor sem buffering -
    * que eh como CREATE CURSOR e SQLEXEC os criam - dispara erro 1586.
    *
    * PUBLIC (sem PROTECTED) de proposito: quem chama eh o Form, de FORA da
    * classe, antes de ligar a grade.
    *====================================================================
    PROCEDURE CriarCursorHistorico()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_cCursorHistorico

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        SET NULL ON
        CREATE CURSOR (loc_cCursor) ;
            (cidchaves C(20), emps C(3), dopcs C(20), notitulos N(6, 0), ;
             empdopncs C(29), vencs T, datas T, usuars C(10))
        SET NULL OFF

        RETURN USED(loc_cCursor)
    ENDPROC

    *====================================================================
    * LimparCursorHistorico - Esvazia o cursor da grade PRESERVANDO a
    * estrutura e, com ela, o RecordSource/ControlSource que o Form ligou no
    * InicializarForm. Eh o Zap In <cursor> do legado Fortyus.
    *
    * SET SAFETY OFF em volta do ZAP eh OBRIGATORIO, nao precaucao: o form
    * que consome este BO eh DataSession = 2, e SET SAFETY eh escopado por
    * DATA SESSION - medido no VFP9, dentro da datasession privada o SAFETY
    * vale ON mesmo com o SET SAFETY OFF do main.prg (mesmo mecanismo que
    * reseta SET DATE/CENTURY ali). Com SAFETY ON o ZAP abre o dialogo modal
    * "Zap ... Are you sure?" e CONGELA a tela esperando um clique que
    * ninguem ve - num teste headless isso aparece como timeout sem
    * resultado nenhum, nao como erro.
    *
    * SELECT antes do ZAP: ZAP IN nao muda a work area corrente, e quem
    * chama este metodo segue com APPEND FROM, que vai para a work area
    * CORRENTE.
    *====================================================================
    PROTECTED PROCEDURE LimparCursorHistorico()
        LOCAL loc_cCursor, loc_cSafety
        loc_cCursor = THIS.this_cCursorHistorico

        IF USED(loc_cCursor)
            loc_cSafety = SET("SAFETY")
            SET SAFETY OFF
            SELECT (loc_cCursor)
            ZAP IN (loc_cCursor)
            IF loc_cSafety == "ON"
                SET SAFETY ON
            ENDIF
        ENDIF
    ENDPROC

    *====================================================================
    * CarregarHistorico - Popula a grade com o historico de datas de entrega
    * desta operacao (uma linha por troca de prazo ja arquivada).
    *
    * Transcreve a consulta que o Init legado monta e manda ao AddCursor:
    *   lcQrySigOpMvv = [Select * ] + ;
    *                    [From SigOpMvv ] + ;
    *                   [Where EmpDopNcs = '] + pEmp + pDop + Str(pNum, 6) + [' ] + ;
    *                   [Order By Vencs]
    * As colunas sao listadas explicitamente no lugar do SELECT *, para a
    * lista do SELECT ser a MESMA do CREATE CURSOR de CriarCursorHistorico()
    * - APPEND FROM DBF() casa coluna por NOME.
    *
    * A chave vem de MontarChaveEmpDopNums(): 29 caracteres COM o padding,
    * porque empdopncs eh char(29) POSICIONAL (emps char(3) + dopcs char(20)
    * + STR(,6)) e encurtar qualquer parte com ALLTRIM faz o WHERE nunca
    * casar - devolvendo ZERO linha em SILENCIO, sem erro e sem log.
    *
    * Sem os parametros do form pai (probe headless, harness) a chave fica
    * em branco e o SELECT devolve ZERO linha: grade vazia, SEM erro - o
    * mesmo que o legado exibe para uma operacao que nunca teve troca de
    * prazo. Por isso zero linha NAO eh falha, e quem precisa aferir carga
    * tem de olhar RECCOUNT, nao o retorno deste metodo.
    *
    * O SQLEXEC vai para um cursor TEMPORARIO e o alias da grade eh
    * recarregado por ZAP + APPEND FROM DBF(). SQLEXEC direto sobre o alias
    * da grade FECHA e RECRIA o alias: o Grid perde RecordSource e
    * ControlSource e cai para ColumnCount = 0 - vira um retangulo branco
    * sem cabecalho e sem coluna, sem erro, sem log e sem excecao.
    *
    * O guard do TABLEREVERT olha o BUFFERING, nao o USED: TABLEREVERT em
    * cursor sem buffering (como SQLEXEC cria) dispara erro 1586.
    *
    * Sem conexao (gnConnHandle invalido - validacao de UI, probe headless)
    * a grade fica VAZIA e o metodo devolve .T.: nao houve falha, so nao
    * havia banco para consultar.
    *
    * RETURN unico DEPOIS do ENDTRY, com flag loc_lSucesso: RETURN dentro de
    * TRY/CATCH eh proibido em VFP9.
    *
    * PUBLIC (sem PROTECTED) de proposito: quem chama eh o CarregarLista()
    * do Form, de FORA da classe.
    *====================================================================
    PROCEDURE CarregarHistorico()
        LOCAL loc_cSQL, loc_cCursor, loc_cTmp, loc_cChave
        LOCAL loc_nResult, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.
        loc_cCursor  = THIS.this_cCursorHistorico
        loc_cTmp     = "cursor_4c_HistoricoTmp"

        TRY
            IF !USED(loc_cCursor)
                THIS.CriarCursorHistorico()
            ENDIF

            IF !USED(loc_cCursor)
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel criar o cursor do hist" + CHR(243) + "rico (" + loc_cCursor + ")."
                MsgErro(THIS.this_cMensagemErro, "SigOpEntBO.CarregarHistorico")
                THIS.this_lErroExibido = .T.
            ELSE
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    *-- Sem conexao: grade vazia, mesmo resultado visual de uma
                    *-- operacao sem historico
                    THIS.LimparCursorHistorico()
                    loc_lSucesso = .T.
                ELSE
                    loc_cChave = THIS.MontarChaveEmpDopNums()

                    loc_cSQL = "SELECT cidchaves, emps, dopcs, notitulos," + ;
                        " empdopncs, vencs, datas, usuars" + ;
                        " FROM SigOpMvv" + ;
                        " WHERE EmpDopNcs = " + EscaparSQL(loc_cChave) + ;
                        " ORDER BY Vencs"

                    IF USED(loc_cTmp)
                        IF CURSORGETPROP("Buffering", loc_cTmp) > 1
                            TABLEREVERT(.T., loc_cTmp)
                        ENDIF
                        USE IN (loc_cTmp)
                    ENDIF

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cTmp)

                    IF loc_nResult >= 0
                        THIS.LimparCursorHistorico()
                        SELECT (loc_cCursor)
                        SET NULL ON
                        APPEND FROM DBF(loc_cTmp)
                        SET NULL OFF
                        loc_lSucesso = .T.
                    ELSE
                        *-- Mensagem do legado nas falhas de carga deste form:
                        *-- MessageBox([Favor Reinicializar o Processo!!!], 16,
                        *--            [Falha na Conexao (...)])
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                        MsgErro(THIS.this_cMensagemErro + CHR(13) + CapturarErroSQL(), ;
                            "Falha na Conex" + CHR(227) + "o (" + loc_cCursor + ")")
                        THIS.this_lErroExibido = .T.
                    ENDIF

                    IF USED(loc_cTmp)
                        USE IN (loc_cTmp)
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    SELECT (loc_cCursor)
                    GO TOP
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpEntBO.CarregarHistorico")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT de uma linha de HISTORICO em SigOpMvv.
    *
    * Espelha SIGOPENT.altera.Valid (linhas 550-553 do dump legado):
    *   Insert Into crSigOpMvv (Emps, Dopcs, NoTitulos, Vencs, EmpDopNcs,
    *                           cIdChaves, Usuars, Datas)
    *          Values (pEmp, pDop, pNum, fDtoSQL(ldAnt),
    *                  pEmp + pDop + Str(pNum,6), fUniqueIds(), Usuar,
    *                  Datetime())
    *
    * ATENCAO (nao inverter): Vencs recebe this_dPrazoAtual - o prazo que
    * esta SAINDO (ldAnt no legado) - NUNCA this_dPrazoNovo. O historico
    * arquiva a data ANTIGA, a nova vai para SigMvCab em Atualizar().
    *
    * O legado so executa o bloco inteiro (insert+update+commit) quando a
    * data nova nao esta vazia (If Not Empty(ldNew)); com o campo vazio o
    * clique em Confirmar nao faz nada, sem erro nenhum - por isso aqui
    * tambem devolve .T. (nada a gravar) e nao falha.
    *====================================================================
    FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        THIS.this_lGravouPrazo = .F.

        IF EMPTY(THIS.this_dPrazoNovo)
            RETURN .T.
        ENDIF

        TRY
            THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
            THIS.this_cEmpDopNcs = THIS.MontarChaveEmpDopNums()

            IF TYPE("gc_4c_UsuarioLogado") = "C"
                THIS.this_cUsuars = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)
            ENDIF

            loc_cSQL = "INSERT INTO SigOpMvv" + ;
                       " (Emps, Dopcs, NoTitulos, Vencs, EmpDopNcs," + ;
                       "  cIdChaves, Usuars, Datas)" + ;
                       " VALUES (" + ;
                       EscaparSQL(LEFT(THIS.this_cEmps, THIS.this_nLarguraEmps)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cDopcs, THIS.this_nLarguraDopcs)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNoTitulos, 0) + ", " + ;
                       FormatarDataSQL(THIS.this_dPrazoAtual) + ", " + ;
                       EscaparSQL(THIS.this_cEmpDopNcs) + ", " + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cUsuars) + ", " + ;
                       "GETDATE())"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao gravar hist" + CHR(243) + "rico de entrega:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpEntBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * Atualizar - UPDATE de SigMvCab.PrazoEnts com a data NOVA.
    *
    * Espelha SIGOPENT.altera.Valid (linhas 559-568 do dump legado):
    *   If llOks And (ThisForm.ParentForm.pcEscolha <> 'ALTERAR')
    *       Update SigMvCab Set PrazoEnts = ?pDtp
    *       Where EmpDopNums = pEmp + pDop + Str(pNum,6)
    *   EndIf
    *
    * Quando o form pai esta em modo ALTERAR (this_cEscolhaPai igual a
    * this_cModoNaoAtualizaCabecalho), o PROPRIO pai grava o cabecalho e
    * este UPDATE tem de ser PULADO - essa condicao eh regra de negocio
    * do legado (CLAUDE.md regra #21b: a condicao que cerca a validacao
    * faz parte dela), por isso devolve .T. (nada a atualizar) em vez de
    * executar o UPDATE, exatamente como o legado nao executa a query.
    *
    * Depende de this_cEmpDopNcs e this_dPrazoNovo ja estarem calculados
    * - chamar DEPOIS de Inserir() ter devolvido .T., nunca isolado.
    *====================================================================
    FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        IF EMPTY(THIS.this_dPrazoNovo)
            RETURN .T.
        ENDIF

        IF THIS.this_cEscolhaPai = THIS.this_cModoNaoAtualizaCabecalho
            *-- Modo ALTERAR: o form pai grava o proprio cabecalho - nada a
            *-- fazer aqui (fiel ao guard do legado em altera.Valid).
            THIS.this_lGravouPrazo = .T.
            RETURN .T.
        ENDIF

        TRY
            IF EMPTY(THIS.this_cEmpDopNcs)
                THIS.this_cEmpDopNcs = THIS.MontarChaveEmpDopNums()
            ENDIF

            loc_cSQL = "UPDATE SigMvCab SET" + ;
                       " PrazoEnts = " + FormatarDataSQL(THIS.this_dPrazoNovo) + ;
                       " WHERE EmpDopNums = " + EscaparSQL(THIS.this_cEmpDopNcs)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                THIS.this_lGravouPrazo = .T.
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar o prazo de entrega do movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpEntBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * GravarAlteracaoPrazo - UNICA via de gravacao desta tela: encadeia
    * Inserir() + Atualizar() e fecha a transacao, espelhando o corpo de
    * SIGOPENT.altera.Valid com a flag llOks do legado:
    *
    *   Insert Into crSigOpMvv (...)            -> Inserir()
    *   llOks = .t.
    *   If llOks And (pcEscolha <> 'ALTERAR')
    *       Update SigMvCab Set PrazoEnts ...   -> Atualizar()
    *   EndIf
    *   If llOks
    *       If Not poDataMgr.Update('crSigOpMvv')  -> (ver nota abaixo)
    *   EndIf
    *   If llOks
    *       If (poDataMgr.Commit() < 1)
    *           =MessageBox('Favor Reinicializar o Processo!!!', 16,
    *                       'Falha na Conexao (Commit)')
    *           llOks = .f.
    *       EndIf
    *   EndIf
    *   If Not llOks
    *       poDataMgr.RollBack()
    *   EndIf
    *
    * O "poDataMgr.Update('crSigOpMvv')" do legado NAO tem linha propria
    * aqui: ele era o passo que mandava ao servidor as linhas em aberto do
    * cursor remoto do Fortyus (o INSERT legado grava no CURSOR, nao na
    * tabela). Nesta arquitetura Inserir() emite o INSERT direto em
    * SigOpMvv por SQLEXEC, de modo que o envio ja aconteceu - o passo
    * esta cumprido, nao descartado.
    *
    * O Commit(), ao contrario, NAO se descarta: medido neste ambiente,
    * SQLGETPROP(gnConnHandle, "Transactions") = 2 (MANUAL) e a conexao
    * nasce com @@TRANCOUNT = 1, isto eh o gravado fica preso na transacao
    * aberta e SOME se o processo cair - foi assim que um UPDATE migrado
    * sem o Commit do legado deixou de persistir sem erro na tela. O par
    * loc_lManual + SQLCOMMIT/SQLROLLBACK eh a forma segura usada no
    * projeto (SIGPRCNBBO): com a conexao em auto-commit o par fica
    * inerte, em vez de comitar a transacao de outra tela.
    *
    * IF ANINHADO, nunca "IF loc_lManual AND SQLCOMMIT(...)": VFP9 nao faz
    * curto-circuito e chamaria o SQLCOMMIT de qualquer jeito.
    *
    * Campo vazio devolve .F. sem mensagem nenhuma: o legado embrulha o
    * bloco inteiro em "If Not Empty(ldNew)", logo clicar Confirmar com a
    * data nova em branco nao faz nada - nem grava, nem avisa. Quem decide
    * se ha o que gravar eh o Form, que ja testa isso antes de chamar;
    * este guard existe para o metodo nunca gravar meia operacao se for
    * chamado isolado.
    *
    * this_lGravouPrazo (o "thisform.parentform.validOk = .t." do legado)
    * so permanece .T. quando TODA a cadeia passou - inclusive o commit.
    *
    * RETURN unico DEPOIS do ENDTRY, com flag loc_lSucesso: RETURN dentro
    * de TRY/CATCH eh proibido em VFP9. Os dois RETURN antecipados ficam
    * FORA do bloco.
    *
    * PUBLIC (sem PROTECTED) de proposito: quem chama eh o
    * BtnConfirmarClick() do Form, de FORA da classe - metodo que o Form
    * chama nunca pode ser PROTECTED em nenhum nivel da heranca
    * (regra #51).
    *====================================================================
    FUNCTION GravarAlteracaoPrazo()
        LOCAL loc_lSucesso, loc_lManual, loc_oErro
        loc_lSucesso = .F.

        THIS.this_lGravouPrazo  = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        IF EMPTY(THIS.this_dPrazoNovo)
            RETURN .F.
        ENDIF

        *-- Conexao em transacao MANUAL (2) exige commit explicito; em
        *-- auto-commit (1) o par commit/rollback fica inerte.
        loc_lManual = .F.
        IF TYPE("gnConnHandle") = "N"
            IF gnConnHandle > 0
                loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
            ENDIF
        ENDIF

        TRY
            *-- Historico: arquiva a data que esta SAINDO (this_dPrazoAtual)
            loc_lSucesso = THIS.Inserir()

            *-- Cabecalho do movimento: recebe a data NOVA. Pulado quando o
            *-- form pai esta em ALTERAR - ali eh ele que grava SigMvCab
            *-- (guard do legado, ja dentro de Atualizar()).
            IF loc_lSucesso
                loc_lSucesso = THIS.Atualizar()
            ENDIF

            IF loc_lManual
                IF loc_lSucesso
                    IF SQLCOMMIT(gnConnHandle) < 1
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                        MsgErro(THIS.this_cMensagemErro + CHR(13) + CapturarErroSQL(), ;
                            "Falha na Conex" + CHR(227) + "o (Commit)")
                        THIS.this_lErroExibido = .T.
                        = SQLROLLBACK(gnConnHandle)
                        loc_lSucesso = .F.
                    ENDIF
                ELSE
                    *-- "If Not llOks / ThisForm.poDataMgr.RollBack()"
                    = SQLROLLBACK(gnConnHandle)
                ENDIF
            ENDIF

            IF !loc_lSucesso
                THIS.this_lGravouPrazo = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpEntBO.GravarAlteracaoPrazo")
            THIS.this_lErroExibido = .T.
            THIS.this_lGravouPrazo = .F.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

