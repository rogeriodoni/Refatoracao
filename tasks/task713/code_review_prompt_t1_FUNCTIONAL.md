# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH Thisform.GradeSubN define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: Thisform.GradeSubN.RecordSource).
- [GRID-WITH] Bloco WITH loc_oGrade define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrade.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCrd.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2297 linhas total):

*-- Linhas 52 a 95:
52: * ESCOPO JA ENTREGUE
53: *
54: * Fase 3/8 - estrutura base: DEFINE CLASS + propriedades visuais do dump, Init
55: * completo (contexto do pai + BO + InicializarForm), cabecalho cinza
56: * (cntSombra -> cnt_4c_Sombra com os dois labels) e Destroy.
57: *
58: * Fase 4/8 - corpo da tela: Shape1 decorativo, a grade de 4 colunas
59: * (GradeSubN -> grd_4c_Dados) com o bind do cursor, e os DOIS botoes do dump
60: * (cmdExcluir -> cmd_4c_Excluir, cmdSair -> cmd_4c_Encerrar) com os Click
61: * transcritos do legado.
62: *
63: * Fase 5/8 - auditoria de propriedades + ordem de tabulacao. Esta tela NAO
64: * tem campo solto algum: os unicos controles de ENTRADA do SCX sao os quatro
65: * Text1 das colunas da grade, que vieram com ela na Fase 4. Como nao ha
66: * "metade dos campos" a acrescentar (e inventar campo violaria o PILAR 1), a
67: * fase foi gasta no que de fato sobra num form FLAT - conferir, propriedade
68: * por propriedade, o que a criacao em massa da Fase 4 derrubou. As 150
69: * propriedades do dump foram cruzadas uma a uma com o .prg; faltavam tres:
70: *
71: *   TitleBar = 0 (form)   - estava SO no comentario, sem declaracao. Com o
72: *                           default 1 a tela desenhava barra de titulo que o
73: *                           legado nao tem (PILAR 1), sem erro nem log.
74: *   Rotation = 0 (2 labels do cabecalho) - default, atribuicao inerte;
75: *                           transcrita por fidelidade literal.
76: *
77: * e o TabIndex saiu do WITH da grade para ConfigurarPaginaDados(), chamado
78: * depois do ULTIMO AddObject. Nao entram, com motivo medido: DoCreate (flag
79: * de design-time, nao eh property de Form), Column<N>.Name (renomear Column
80: * quebra toda referencia .ColumnN) e o Dataenvironment inteiro (a nova
81: * arquitetura usa BO + SQLEXEC).
82: *
83: * NAO existem aqui PageFrame, pagina Lista/Dados nem os cinco botoes CRUD
84: * canonicos: o dump tem 2 botoes, em Left 450 e 525, e nenhuma Page. Os
85: * metodos ConfigurarPageFrame / ConfigurarPaginaLista / ConfigurarPaginaDados
86: * mantem os nomes do contrato do pipeline, mas montam o que a tela de fato
87: * tem.
88: *
89: * EVENTOS DE CELULA DA GRADE (todos os do dump, nenhum a mais)
90: *
91: * O legado nao tem lookup algum - nenhum fwBuscaExt / fwBuscaSel / fwBuscaInt,
92: * nenhum sigacess, nenhum mAddColuna no dump inteiro. Os unicos handlers de
93: * campo sao dois LostFocus de celula, e estao transcritos:
94: *
95: *   Column2.Text1.LostFocus -> ValidarFaixaFinal : Faixa Final em branco manda

*-- Linhas 101 a 144:
101: *
102: * Os dois moram numa subclasse de TextBox (TextBoxFaixaSigOpCrd_4c, no fim
103: * deste arquivo) instalada nas colunas por InstalarCelulasFaixa, porque
104: * BINDEVENT em evento de TextBox dentro de Column nao dispara de forma
105: * confiavel no VFP9. Column1 e Column3 nao tem evento no dump e seguem com o
106: * Text1 nativo - nao se acrescenta comportamento que o legado nao tem.
107: *
108: * Tambem NAO existem Salvar/Cancelar nesta tela: quem grava eh o Encerrar
109: * (cmdSair.Click do legado), e inventar um container de botoes de acao
110: * duplicaria a gravacao e mudaria a tela que o usuario conhece.
111: *
112: * Fase 8/8 - consolidacao: os hooks canonicos de transferencia e de estado,
113: * reconhecendo que nesta tela a FICHA eh a LINHA da grade (as quatro colunas
114: * tem ControlSource direto no cursor, nao ha painel de campos soltos):
115: *
116: *   FormParaBO     linha corrente -> properties do BO; faz o FLUSH da celula
117: *                  em edicao, que eh o unico pedaco do estado que ainda nao
118: *                  chegou ao cursor. So a coluna ATIVA eh lida do controle -
119: *                  com Sparse = .F. o controle eh por COLUNA e, fora da ativa,
120: *                  o .Value so vale para a linha pintada por ultimo.
121: *   BOParaForm     properties do BO -> linha corrente, com guarda de
122: *                  identidade por cidchaves, e repintando (regra #21).
123: *   HabilitarCampos  abre/fecha a digitacao na grade: Grid.ReadOnly ANTES das
124: *                  colunas (regra #18/#46) e as QUATRO reabertas, porque
125: *                  Column1/Column3 nao passam por InstalarCelulasFaixa.
126: *   LimparCampos   devolve a linha corrente ao estado "em branco" (faixafs = 0,
127: *                  o criterio do inserelinha legado), composto dos dois hooks.
128: *
129: * ESCOPO - os quatro NAO sao iguais, e nao da para escolher: FormBase declara
130: * FormParaBO, BOParaForm e LimparCampos como PROTECTED (sao hooks que ela
131: * chama por THIS.) e o VFP9 nao deixa a subclasse ALARGAR escopo herdado -
132: * escrever sem o modificador nao torna publico, so engana quem le. Os tres
133: * levam PROTECTED EXPLICITO e sao chamados por THIS. HabilitarCampos e
134: * CarregarLista NAO existem em FormBase, logo sao PUBLIC de verdade e o
135: * harness os alcanca de fora (regra #3). Para exercitar os PROTECTED num
136: * harness, usar DEFINE CLASS Probe<X> AS FormSigOpCrd com wrapper publico -
137: * script solto nao alcanca membro protegido, e PEMSTATUS(...,5) mente (ele
138: * responde "existe?", nao "da para chamar daqui?").
139: *
140: * Wiring: VincularGrade e AtualizarEstadoControles reabrem a grade apos o
141: * rebind; CmdEncerrarClick faz o flush e congela a digitacao antes do lote.
142: *
143: * NAO entram, e o motivo eh o dump: handler de Salvar/Confirmar (quem grava eh
144: * o Encerrar - o legado nao tem botao de gravar) e handler de Cancelar (nao ha

*-- Linhas 181 a 224:
181:     * lista de FORM (regra #33: nunca chutar a lista de propriedades).
182:     *
183:     * WindowType / ShowWindow NAO vem do SCX: o legado abria com "Do Form" e
184:     * o default 0 (modeless) bastava. Aqui o form eh criado com CREATEOBJECT +
185:     * Show() e o canonico do projeto eh 1 (modal) - transcrever a ausencia
186:     * destruiria a tela no retorno do Show() (regra: WindowType 0 mata a tela).
187:     * Modal ainda reforca o ParentForm.Enabled = .F. do legado.
188:     *==========================================================================
189:     this_cMensagemErro = ""
190:     DataSession  = 2
191:     BorderStyle  = 2
192:     Height       = 349
193:     Width        = 600
194:     ControlBox   = .F.
195:     MaxButton    = .F.
196:     Movable      = .F.
197:     ClipControls = .F.
198:     TitleBar     = 0
199:     Themes       = .F.
200:     WindowType   = 1
201:     ShowWindow   = 1
202:     AutoCenter   = .T.
203: 
204:     *-- Caption de projeto do SCX. O Init a substitui pelo titulo dinamico
205:     *-- 'Faixa de Valores da Operacao <Dopes>', como o legado faz.
206:     Caption = "Gera" + CHR(231) + CHR(227) + "o de Certificado de Cr" + CHR(233) + "dito"
207: 
208:     *==========================================================================
209:     * PROPRIEDADES DE ESTADO
210:     *==========================================================================
211:     this_oBusinessObject = .NULL.
212: 
213:     *-- Form PAI (ParentForm do legado) e marcador de que ele foi desabilitado
214:     *-- por NOS. Sem o marcador, o Destroy poderia reabilitar um form que ja
215:     *-- estava desabilitado por outro motivo.
216:     this_oFormPai        = .NULL.
217:     this_lPaiDesabilitado = .F.
218: 
219:     *-- Contexto recebido do pai (ver CONTRATO no cabecalho)
220:     this_cOperacao = ""         && crSigCdOpe.Dopes - operacao dona das faixas
221:     this_cEscolha  = "INSERIR"  && PcEscolha: INSERIR / ALTERAR / PROCURAR
222: 
223:     *-- Mensagem do bloqueio de pre-requisito (lida pelo chamador se quiser)
224:     this_cMotivoBloqueio = ""

*-- Linhas 235 a 602:
235:     * Init - recebe o contexto do form PAI
236:     *
237:     * A ORDEM aqui eh regra, nao estilo: FormBase.Init() chama
238:     * InicializarForm(), logo todo contexto vindo por parametro tem de estar
239:     * guardado ANTES do DODEFAULT() - senao InicializarForm instancia o BO
240:     * sem saber qual eh a operacao.
241:     *
242:     * par_oFormPai   - form que abriu o dialogo (ParentForm do legado)
243:     * par_cOperacao  - Dopes da operacao; se ausente, tenta ler do pai
244:     * par_cEscolha   - PcEscolha; se ausente, tenta ler do pai (default INSERIR)
245:     *==========================================================================
246:     PROCEDURE Init(par_oFormPai, par_cOperacao, par_cEscolha)
247:         *-- Form pai
248:         IF VARTYPE(par_oFormPai) = "O"
249:             THIS.this_oFormPai = par_oFormPai
250:         ENDIF
251: 
252:         *-- Operacao dona das faixas
253:         IF VARTYPE(par_cOperacao) = "C" AND !EMPTY(ALLTRIM(par_cOperacao))
254:             THIS.this_cOperacao = ALLTRIM(par_cOperacao)
255:         ENDIF
256: 
257:         *-- Modo de edicao
258:         IF VARTYPE(par_cEscolha) = "C" AND !EMPTY(ALLTRIM(par_cEscolha))
259:             THIS.this_cEscolha = UPPER(ALLTRIM(par_cEscolha))
260:         ENDIF
261: 
262:         *-- O que nao veio por parametro, buscar no pai (legado le
263:         *-- poForm.PcEscolha). So agora, para o parametro ter precedencia.
264:         THIS.ResolverContextoDoPai()
265: 
266:         RETURN DODEFAULT()
267:     ENDPROC
268: 
269: 
270:     *==========================================================================
271:     * ResolverContextoDoPai - completa operacao/modo a partir do form pai
272:     *
273:     * Transcreve o Thisform.PcEscolha = IIF(EMPTY(poForm.PcEscolha), "INSERIR",
274:     * poForm.PcEscolha) do legado, mas sem presumir COMO o pai se chama: o
275:     * PILAR 3 renomeia os objetos, entao as properties do pai migrado podem
276:     * ter nome diferente. Cada leitura eh guardada por PEMSTATUS/TYPE e a
277:     * ausencia simplesmente mantem o default - nunca estoura.
278:     *==========================================================================
279:     PROCEDURE ResolverContextoDoPai()
280:         LOCAL loc_cValor
281: 
282:         IF VARTYPE(THIS.this_oFormPai) != "O"
283:             RETURN .F.
284:         ENDIF
285: 
286:         *-- Modo de edicao (PcEscolha / this_cEscolha / this_cModoAtual)
287:         IF EMPTY(ALLTRIM(THIS.this_cEscolha))
288:             loc_cValor = THIS.LerTextoDoPai("this_cEscolha")
289:             IF EMPTY(loc_cValor)
290:                 loc_cValor = THIS.LerTextoDoPai("PcEscolha")
291:             ENDIF
292:             IF EMPTY(loc_cValor)
293:                 loc_cValor = THIS.LerTextoDoPai("this_cModoAtual")
294:             ENDIF
295:             THIS.this_cEscolha = IIF(EMPTY(loc_cValor), "INSERIR", UPPER(loc_cValor))
296:         ENDIF
297: 
298:         *-- Operacao dona (Dopes). O pai eh o cadastro de SigCdOpe, cuja
299:         *-- chave eh a propria descricao da operacao.
300:         IF EMPTY(ALLTRIM(THIS.this_cOperacao))
301:             loc_cValor = THIS.LerTextoDoPai("this_cDopes")
302:             IF EMPTY(loc_cValor)
303:                 loc_cValor = THIS.LerTextoDoPai("this_cOperacao")
304:             ENDIF
305:             THIS.this_cOperacao = loc_cValor
306:         ENDIF
307: 
308:         RETURN .T.
309:     ENDPROC
310: 
311: 
312:     *==========================================================================
313:     * LerTextoDoPai - leitura DEFENSIVA de uma property texto do form pai
314:     *
315:     * PEMSTATUS confere a existencia e TYPE() o tipo antes de ler: property
316:     * ausente devolve string vazia em vez de derrubar o Init do dialogo.
317:     * O acesso por NOME usa EVALUATE - nunca Controls(<nome>), que eh
318:     * indexado por NUMERO (regra #34).
319:     *
320:     * Sem TRY/CATCH de proposito: os tres guards (VARTYPE do pai, PEMSTATUS
321:     * da property e TYPE da expressao) ja cobrem ausencia e referencia morta,
322:     * e um CATCH aqui seria silencioso - engolir erro sem avisar eh proibido
323:     * (regra #9).
324:     *==========================================================================
325:     PROCEDURE LerTextoDoPai(par_cProperty)
326:         LOCAL loc_cRetorno, loc_cExpr
327: 
328:         loc_cRetorno = ""
329: 
330:         IF VARTYPE(THIS.this_oFormPai) != "O" OR VARTYPE(par_cProperty) != "C"
331:             RETURN ""
332:         ENDIF
333: 
334:         IF PEMSTATUS(THIS.this_oFormPai, ALLTRIM(par_cProperty), 5)
335:             loc_cExpr = "THIS.this_oFormPai." + ALLTRIM(par_cProperty)
336:             IF TYPE(loc_cExpr) = "C"
337:                 loc_cRetorno = ALLTRIM(NVL(EVALUATE(loc_cExpr), ""))
338:             ENDIF
339:         ENDIF
340: 
341:         RETURN loc_cRetorno
342:     ENDPROC
343: 
344: 
345:     *==========================================================================
346:     * ValidarParametros - pre-requisitos ANTES de montar a tela
347:     *
348:     * PUBLIC de proposito: o harness da etapa 06b chama metodos do form de
349:     * FORA da classe, e PROTECTED falharia com "Property ... is not found"
350:     * (regra #3).
351:     *
352:     * O bypass de teste vem no TOPO porque o TesteAutomatico.prg NAO conecta
353:     * ao SQL Server - ele define gnConnHandle = 0 como SENTINELA e espera que
354:     * os forms pulem a checagem por gb_4c_ModoTeste / gb_4c_ValidandoUI. Sem
355:     * esse bypass a instanciacao reprovaria SEMPRE, com uma MsgErro de conexao
356:     * que nao corresponde a nenhuma falha real de rede.
357:     *==========================================================================
358:     PROCEDURE ValidarParametros()
359:         LOCAL loc_lValido
360: 
361:         THIS.this_cMotivoBloqueio = ""
362: 
363:         IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
364:             RETURN .T.
365:         ENDIF
366:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
367:             RETURN .T.
368:         ENDIF
369: 
370:         loc_lValido = .T.
371: 
372:         DO CASE
373:             CASE TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
374:                 THIS.this_cMotivoBloqueio = "Imposs" + CHR(237) + "vel efetuar conex" + ;
375:                     CHR(227) + "o com o servidor de banco de dados."
376:                 loc_lValido = .F.
377: 
378:             CASE EMPTY(ALLTRIM(THIS.this_cOperacao))
379:                 *-- Sem a operacao dona nao ha faixa a editar: o legado lia
380:                 *-- crSigCdOpe.Dopes da datasession do pai e sem isso o
381:                 *-- Insert Into crSigOpCrr (Dopes, ...) gravaria orfao.
382:                 THIS.this_cMotivoBloqueio = "Opera" + CHR(231) + CHR(227) + ;
383:                     "o inv" + CHR(225) + "lida. Selecione a opera" + CHR(231) + CHR(227) + ;
384:                     "o antes de editar as faixas de valores."
385:                 loc_lValido = .F.
386:         ENDCASE
387: 
388:         IF !loc_lValido
389:             MsgAviso(THIS.this_cMotivoBloqueio, "Aten" + CHR(231) + CHR(227) + "o")
390:         ENDIF
391: 
392:         RETURN loc_lValido
393:     ENDPROC
394: 
395: 
396:     *==========================================================================
397:     * InicializarForm - monta a estrutura base do dialogo
398:     *
399:     * RETURN de bloqueio FORA do TRY (regra #1: nunca RETURN dentro de
400:     * TRY/CATCH).
401:     *==========================================================================
402:     PROTECTED PROCEDURE InicializarForm()
403:         LOCAL loc_lSucesso, loc_oErro
404: 
405:         *-- Pre-requisitos primeiro: sem eles nao vale montar tela nenhuma
406:         IF !THIS.ValidarParametros()
407:             RETURN .F.
408:         ENDIF
409: 
410:         loc_lSucesso = .F.
411: 
412:         TRY
413:             *-- Datasession privada (DataSession = 2) nasce com os SETs no
414:             *-- DEFAULT do VFP: o SET DELETED ON / SET EXACT ON do config.prg
415:             *-- ficou na sessao 1 e NAO eh herdado. FormBase.Init() repoe so
416:             *-- DATE/CENTURY. Repor os dois aqui eh obrigatorio nesta tela:
417:             *-- cmdExcluir faz DELETE local na linha da grade e o cmdSair faz
418:             *-- "Delete For Empty(Dopes) or Empty(faixafs)" - com DELETED OFF
419:             *-- a linha apagada CONTINUA aparecendo na grade e sendo vista por
420:             *-- LOCATE/SCAN, sem erro e sem log.
421:             SET DELETED ON
422:             SET EXACT ON
423: 
424:             *-- Business Object com o contexto recebido do pai
425:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpCrdBO", ;
426:                                                      THIS.this_cOperacao, ;
427:                                                      THIS.this_cEscolha)
428: 
429:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
430:                 *-- Titulo dinamico, como o legado:
431:                 *-- 'Faixa de Valores da Operacao ' + AllTrim(Proper(Dopes))
432:                 THIS.AjustarCaption()
433: 
434:                 *-- Aparencia base do form (fundo/scroll)
435:                 THIS.ConfigurarPageFrame()
436: 
437:                 *-- Cabecalho cinza (cntSombra do legado)
438:                 THIS.ConfigurarCabecalho()
439: 
440:                 *-- Shape decorativo, grade de 4 colunas e os dois botoes.
441:                 *-- DEPOIS do cabecalho de proposito: os botoes ficam em
442:                 *-- Top = 3..78, DENTRO da faixa (Top = 0..80), e so aparecem
443:                 *-- se criados depois dela (regra #11).
444:                 THIS.ConfigurarPaginaLista()
445: 
446:                 *-- Ordem de tabulacao: SO AQUI, depois do ULTIMO AddObject.
447:                 *-- Cada AddObject renumera o TabIndex dos irmaos pela ordem
448:                 *-- de criacao, entao atribuir no meio da montagem eh
449:                 *-- desfeito pelos objetos seguintes.
450:                 THIS.ConfigurarPaginaDados()
451: 
452:                 *-- Desabilita o pai (ParentForm.Enabled = .F. do legado)
453:                 THIS.DesabilitarFormPai()
454: 
455:                 *-- AddObject cria tudo com Visible = .F.
456:                 THIS.TornarControlesVisiveis()
457: 
458:                 *-- Carga e bind da grade: so AQUI, nunca em
459:                 *-- ConfigurarPaginaLista. Column.ControlSource exige o cursor
460:                 *-- JA ABERTO, e quando a grade eh criada nao existe cursor
461:                 *-- nenhum - atribuir ali estoura "Alias ... is not found"
462:                 *-- dentro deste TRY, InicializarForm devolve .F. e a tela nao
463:                 *-- abre, sem erro visivel (regra #41).
464:                 THIS.CarregarLista()
465: 
466:                 *-- POR ULTIMO: TornarControlesVisiveis acabou de forcar
467:                 *-- Visible = .T. em cada controle, inclusive no Excluir que o
468:                 *-- legado ESCONDE quando o usuario nao tem acesso. Ajustar
469:                 *-- antes dele seria simplesmente apagado.
470:                 THIS.AjustarBotoesPorModo()
471: 
472:                 loc_lSucesso = .T.
473:             ELSE
474:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
475:                         "vel criar o objeto de neg" + CHR(243) + "cio SigOpCrdBO.", ;
476:                         "Erro ao Inicializar")
477:             ENDIF
478: 
479:         CATCH TO loc_oErro
480:             THIS.this_cMensagemErro = loc_oErro.Message
481:             MsgErro(loc_oErro.Message + ;
482:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
483:                     " | Proc: " + loc_oErro.Procedure, ;
484:                     "Erro ao inicializar FormSigOpCrd")
485:             loc_lSucesso = .F.
486:         ENDTRY
487: 
488:         RETURN loc_lSucesso
489:     ENDPROC
490: 
491: 
492:     *==========================================================================
493:     * AjustarCaption - titulo dinamico da tela e dos labels do cabecalho
494:     *
495:     * Legado: .Caption = 'Faixa de Valores da Operacao ' + ;
496:     *                    AllTrim(Proper(crSigCdOpe.Dopes))
497:     *         ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
498:     *         ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
499:     *
500:     * Sem operacao no contexto o Caption de projeto do SCX eh preservado, para
501:     * a tela nunca exibir "... da Operacao" com o nome em branco.
502:     *==========================================================================
503:     PROCEDURE AjustarCaption()
504:         LOCAL loc_cOperacao
505: 
506:         loc_cOperacao = ALLTRIM(NVL(THIS.this_cOperacao, ""))
507: 
508:         IF !EMPTY(loc_cOperacao)
509:             THIS.Caption = "Faixa de Valores da Opera" + CHR(231) + CHR(227) + "o " + ;
510:                            ALLTRIM(PROPER(loc_cOperacao))
511:         ENDIF
512: 
513:         THIS.this_cTituloForm = THIS.Caption
514: 
515:         RETURN .T.
516:     ENDPROC
517: 
518: 
519:     *==========================================================================
520:     * ConfigurarPageFrame - aparencia base do form
521:     *
522:     * O nome eh o do contrato do pipeline; NAO ha PageFrame a criar porque o
523:     * SCX legado NAO tem Page nenhuma (layout FLAT - ver cabecalho). Inventar
524:     * um PageFrame de duas paginas violaria o PILAR 1 e a regra "NUNCA
525:     * inventar". O que este metodo faz eh o que de fato existe no dump: o
526:     * fundo do form.
527:     *
528:     * Picture = ..\framework\imagens\new_background.jpg no dump. O caminho
529:     * NUNCA se reconstroi a partir de gc_4c_CaminhoBase (regra #156/#170); o
530:     * arquivo existe tanto em vbmp\ quanto em Framework\imagens\ e o canonico
531:     * do projeto eh gc_4c_CaminhoIcones. Picture inexistente falha em SILENCIO
532:     * (regra #25), por isso o nome eh transcrito do dump e nao chutado.
533:     *==========================================================================
534:     PROTECTED PROCEDURE ConfigurarPageFrame()
535:         THIS.Picture    = gc_4c_CaminhoIcones + "new_background.jpg"
536:         THIS.ScrollBars = 0
537: 
538:         RETURN .T.
539:     ENDPROC
540: 
541: 
542:     *==========================================================================
543:     * ConfigurarCabecalho - faixa cinza do topo (cntSombra do legado)
544:     *
545:     * Dump: cntSombra Top=0 Left=0 Width=800 Height=80 BackColor=100,100,100
546:     *       lblSombra Top=18 Height=40 Left=10 Width=769 ForeColor=0,0,0
547:     *       lblTitulo Top=17 Height=46 Left=10 Width=769 ForeColor=255,255,255
548:     *       ambos Tahoma 18 bold, BackStyle=0, Alignment=0, WordWrap=.T.
549:     *
550:     * As larguras 800/769 do dump sao MAIORES que o form (600): artefato do
551:     * Form Designer, que desenhou o container 200px alem da borda direita.
552:     * Aplicar os literais faria o titulo (Tahoma 18 bold) ser RECORTADO pelo
553:     * pai sem erro nenhum (regra #30). Container acompanha THIS.Width e os
554:     * labels ficam 20px menores para nao extrapolar o container - mesma
555:     * decisao ja registrada para Formsigprrcu/FormSIGPRSTF, e o ComparadorUI
556:     * acusa esses dois Width como DIFERENCA/falso positivo conhecido.
557:     *
558:     * Nao ha compensacao de +29: sem PageFrame, os Top do dump sao absolutos.
559:     * O cabecalho eh o PRIMEIRO AddObject da tela (regra #11), para que a
560:     * grade e os botoes criados nas fases seguintes desenhem POR CIMA dele.
561:     *==========================================================================
562:     PROTECTED PROCEDURE ConfigurarCabecalho()
563:         THIS.AddObject("cnt_4c_Sombra", "Container")
564:         WITH THIS.cnt_4c_Sombra
565:             .Top          = 0
566:             .Left         = 0
567:             .Width        = THIS.Width
568:             .Height       = 80
569:             .BorderWidth  = 0
570:             .BackStyle    = 1
571:             .BackColor    = RGB(100, 100, 100)
572:             .SpecialEffect = 0
573:             .Visible      = .T.
574:         ENDWITH
575: 
576:         *-- Label de sombra: preto, 1px acima do titulo (efeito de relevo)
577:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
578:         WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
579:             *-- AutoSize = .F. explicito: AutoSize eh NO-OP em Label criado
580:             *-- por AddObject e, com WordWrap = .T., DESCARTA a Height e
581:             *-- corta o texto (regra #23).
582:             .AutoSize   = .F.
583:             .FontName   = "Tahoma"
584:             .FontSize   = 18
585:             .FontBold   = .T.
586:             .FontUnderline = .F.
587:             .WordWrap   = .T.
588:             .Alignment  = 0
589:             .BackStyle  = 0
590:             .Caption    = THIS.Caption
591:             .Top        = 18
592:             .Left       = 10
593:             .Width      = THIS.Width - 20
594:             .Height     = 40
595:             .ForeColor  = RGB(0, 0, 0)
596:             *-- Rotation = 0 esta no dump. Eh o DEFAULT, entao a atribuicao eh
597:             *-- inerte - medido no VFP9 (2026-10-30): Rotation lido de volta = 0
598:             *-- e Width/Height inalterados (580x40) antes e depois. Transcrito
599:             *-- por fidelidade literal ao SCX; diferente de Format = "" /
600:             *-- InputMask = "", que sao override VAZIO e NAO se transcrevem
601:             *-- (regra #49), aqui o dump declara um VALOR.
602:             .Rotation   = 0

*-- Linhas 645 a 688:
645:     * botoes sao os ULTIMOS porque ficam sobre a faixa do cabecalho e o
646:     * AddObject poe o ultimo objeto no topo do z-order.
647:     *==========================================================================
648:     PROTECTED PROCEDURE ConfigurarPaginaLista()
649:         THIS.ConfigurarShapeDecorativo()
650:         THIS.ConfigurarGrade()
651:         THIS.ConfigurarBotoes()
652: 
653:         RETURN .T.
654:     ENDPROC
655: 
656: 
657:     *==========================================================================
658:     * ConfigurarPaginaDados - ordem de tabulacao (TabIndex do dump)
659:     *
660:     * O nome eh o do contrato do pipeline. NAO existe pagina Dados a montar:
661:     * o SCX eh FLAT (sem PageFrame) e seus unicos controles de ENTRADA sao os
662:     * quatro Text1 das colunas da grade, entregues junto com ela na Fase 4 -
663:     * nao ha "metade dos campos" a acrescentar porque nao ha campo solto
664:     * nenhum. Inventar campos violaria o PILAR 1; deixar o metodo com corpo
665:     * THIS.Refresh() seria stub disfarcado. O trabalho que de fato sobra num
666:     * form FLAT eh a propriedade que a criacao em massa da Fase 4 derruba: o
667:     * TabIndex.
668:     *
669:     * Chamado DEPOIS de todos os AddObject, de proposito: cada AddObject
670:     * renumera o TabIndex dos irmaos pela ordem de criacao, entao atribuicao
671:     * feita no meio da montagem eh reembaralhada pelos objetos seguintes.
672:     *
673:     * ORDEM-ALVO: a EFETIVA do legado, nao o literal do dump. O VFP aplica o
674:     * TabIndex gravado no instante em que CRIA cada objeto e CLAMPA no total
675:     * de tab-ables existentes ali; por isso o alvo se obtem simulando o load
676:     * na ordem dos REGISTROS do SCX, nunca lendo o numero cru.
677:     *
678:     * Simulado e medido no VFP9 (2026-10-30), recriando na ordem do SCX
679:     * (cntSombra, Shape1, GradeSubN com o TabIndex = 1 do dump, cmdExcluir,
680:     * cmdSair):
681:     *
682:     *     grade = 1   cabecalho = 2   Excluir = 3   Encerrar = 4
683:     *
684:     * O 1 da grade SOBREVIVE ao load (1 <= 2 tab-ables criados ate ali) e
685:     * empurra o cabecalho para 2 - ou seja o Tab do legado comeca na GRADE,
686:     * que eh o unico lugar onde se digita. Shape NAO entra na conta: medido,
687:     * Shape nem TEM TabIndex (PEMSTATUS = .F.).
688:     *

*-- Linhas 704 a 837:
704:     * devolve .T. mesmo para metodo protegido, entao o teste entra no branch e
705:     * so quebra na chamada real (regra #3).
706:     *==========================================================================
707:     PROCEDURE ConfigurarPaginaDados()
708:         *-- Grade primeiro: eh onde o usuario digita as faixas (SCX:
709:         *-- GradeSubN.TabIndex = 1 - o unico TabIndex declarado no dump)
710:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
711:             THIS.grd_4c_Dados.TabIndex = 1
712:         ENDIF
713: 
714:         *-- Cabecalho: so tem Label dentro, nao para o Tab. Fica em 2 porque
715:         *-- eh o que o load do legado produz, nao por escolha.
716:         IF PEMSTATUS(THIS, "cnt_4c_Sombra", 5)
717:             THIS.cnt_4c_Sombra.TabIndex = 2
718:         ENDIF
719: 
720:         *-- Botoes, na ordem dos registros do SCX (Left 450, depois 525)
721:         IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
722:             THIS.cmd_4c_Excluir.TabIndex = 3
723:         ENDIF
724: 
725:         IF PEMSTATUS(THIS, "cmd_4c_Encerrar", 5)
726:             THIS.cmd_4c_Encerrar.TabIndex = 4
727:         ENDIF
728: 
729:         RETURN .T.
730:     ENDPROC
731: 
732: 
733:     *==========================================================================
734:     * ConfigurarShapeDecorativo - Shape1 do legado
735:     *
736:     * Dump: Top=7 Left=205 Height=110 Width=173
737:     *       BackStyle=0 BorderStyle=0 BorderColor=136,189,188
738:     *
739:     * BackStyle = 0 (transparente) com BorderStyle = 0 (sem borda) deixa o
740:     * objeto SEM pintura alguma: ele nao aparece na tela. Transcrito mesmo
741:     * assim porque esta no dump (PILAR 1) e porque BorderColor declarado
742:     * indica que o desenhista pretendia uma moldura - mexer em BorderStyle
743:     * para "fazer aparecer" seria inventar UI que o usuario nunca viu.
744:     *
745:     * Shape NAO tem ForeColor (so BorderColor/FillColor) nem ShapeType (essa
746:     * eh do VB; no VFP o equivalente eh Curvature) - nenhuma das duas eh
747:     * atribuida aqui, senao o Init estouraria "Property ... is not found" e a
748:     * tela nao abriria (regra #33).
749:     *==========================================================================
750:     PROTECTED PROCEDURE ConfigurarShapeDecorativo()
751:         THIS.AddObject("shp_4c_Shape1", "Shape")
752:         WITH THIS.shp_4c_Shape1
753:             .Top         = 7
754:             .Left        = 205
755:             .Height      = 110
756:             .Width       = 173
757:             .BackStyle   = 0
758:             .BorderStyle = 0
759:             .BorderColor = RGB(136, 189, 188)
760:             .Visible     = .T.
761:         ENDWITH
762: 
763:         RETURN .T.
764:     ENDPROC
765: 
766: 
767:     *==========================================================================
768:     * ConfigurarGrade - GradeSubN do legado (grd_4c_Dados)
769:     *
770:     * Dump: ColumnCount=4 FontName="Tahoma" FontSize=8 DeleteMark=.F.
771:     *       Top=103 Left=118 Width=363 Height=227 RowHeight=16
772:     *       ScrollBars=2 TabIndex=1 GridLineColor=238,238,238
773:     *
774:     * O TabIndex = 1 do dump NAO eh atribuido aqui: TabIndex tem de ser
775:     * aplicado DEPOIS de todos os AddObject, senao cada AddObject seguinte
776:     * renumera os irmaos. Mora em ConfigurarPaginaDados().
777:     *
778:     * Tahoma, e nao Verdana: Verdana eh o canonico da grade de LISTA do
779:     * frmcadastro, e esta tela nao eh um cadastro paginado - o dump declara
780:     * Tahoma 8 no proprio Grid.
781:     *
782:     * Sem compensacao de +29 no Top: sem PageFrame, os Top do dump sao
783:     * absolutos (os -29 do pgf_4c_Paginas nao existem aqui).
784:     *
785:     * RecordMark: o dump declara DeleteMark = .F. e eh SILENCIOSO sobre
786:     * RecordMark, que na BaseClass grid vale .T. - ou seja, a seta de registro
787:     * corrente aparecia no legado, e as larguras fecham com ela (100+100+48+80
788:     * = 328, mais a marca e a barra de rolagem, nos 363 do Grid). Mesmo assim
789:     * fica .F.: eh a regra do projeto para grade de form OPERACIONAL, e o
790:     * CorretorAutomatico (#58/GridRecordMarkDeleteMark) INJETA .F. quando a
791:     * propriedade esta ausente. Declarar explicitamente deixa a decisao
792:     * visivel no codigo em vez de ser acrescentada em silencio no proximo
793:     * sweep. As larguras das colunas seguem as do dump, intocadas.
794:     *
795:     * Nada de RecordSource / ControlSource aqui - ver CarregarLista.
796:     *==========================================================================
797:     PROTECTED PROCEDURE ConfigurarGrade()
798:         THIS.AddObject("grd_4c_Dados", "Grid")
799:         WITH THIS.grd_4c_Dados
800:             .ColumnCount    = 4
801:             .Top            = 103
802:             .Left           = 118
803:             .Width          = 363
804:             .Height         = 227
805:             .FontName       = "Tahoma"
806:             .FontSize       = 8
807:             .RowHeight      = 16
808:             .ScrollBars     = 2
809:             .GridLineColor  = RGB(238, 238, 238)
810:             .RecordMark     = .F.
811:             .DeleteMark     = .F.
812:             .Visible        = .T.
813:         ENDWITH
814: 
815:         *-- Propriedades de COLUNA num metodo proprio: elas sao reaplicadas
816:         *-- depois de cada RecordSource (ver ConfigurarColunasGrade).
817:         THIS.ConfigurarColunasGrade()
818: 
819:         RETURN .T.
820:     ENDPROC
821: 
822: 
823:     *==========================================================================
824:     * ConfigurarColunasGrade - propriedades de COLUNA, reaplicaveis
825:     *
826:     * Mexer em RecordSource (e nos ControlSource) faz o VFP RECALCULAR as
827:     * larguras para o default 90 e devolver os cabecalhos a "Header1" -
828:     * silenciosamente. Por isso tudo que eh de coluna mora aqui e este metodo
829:     * eh chamado DUAS vezes: ao criar a grade (para ela ja nascer certa) e de
830:     * novo logo depois de cada bind, em VincularGrade.
831:     *
832:     * Dump, coluna por coluna:
833:     *   Column1 "Faixa Inicial" Width=100 Movable=.F. Resizable=.F.
834:     *           InputMask="999,999,999.99"
835:     *   Column2 "Faixa Final"   Width=100 Movable=.F. Resizable=.F.
836:     *           InputMask="999,999,999.99"   Text1.ReadOnly=.F.
837:     *   Column3 "%"             Width=48  InputMask="999.99"

*-- Linhas 855 a 898:
855:     * legado so declara ReadOnly = .F. explicito na Column2.Text1, que ja eh o
856:     * default. Travar coluna aqui tiraria do usuario a digitacao das faixas.
857:     *==========================================================================
858:     PROCEDURE ConfigurarColunasGrade()
859:         LOCAL loc_oGrade
860: 
861:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
862:             RETURN .F.
863:         ENDIF
864: 
865:         loc_oGrade = THIS.grd_4c_Dados
866: 
867:         *-- Column1 - "Faixa Inicial" (faixais)
868:         WITH loc_oGrade.Column1
869:             .Width     = 100
870:             .Movable   = .F.
871:             .Resizable = .F.
872:             .InputMask = "999,999,999.99"
873:             .FontName  = "Tahoma"
874:             .FontSize  = 8
875:             WITH .Header1
876:                 .FontName  = "Tahoma"
877:                 .FontSize  = 8
878:                 .Alignment = 2
879:                 .Caption   = "Faixa Inicial"
880:             ENDWITH
881:             WITH .Text1
882:                 .FontName    = "Tahoma"
883:                 .FontSize    = 8
884:                 .BorderStyle = 0
885:                 .Margin      = 0
886:                 .ForeColor   = RGB(0, 0, 0)
887:                 .BackColor   = RGB(255, 255, 255)
888:             ENDWITH
889:         ENDWITH
890: 
891:         *-- Column2 - "Faixa Final" (faixafs)
892:         WITH loc_oGrade.Column2
893:             .Width     = 100
894:             .Movable   = .F.
895:             .Resizable = .F.
896:             .InputMask = "999,999,999.99"
897:             .FontName  = "Tahoma"
898:             .FontSize  = 8

*-- Linhas 996 a 1039:
996:     * Como o form nao tem barra de titulo, ele e o Alt+F4 sao as unicas saidas
997:     * alem do clique - por isso ReabilitarFormPai tambem roda no Destroy.
998:     *==========================================================================
999:     PROTECTED PROCEDURE ConfigurarBotoes()
1000:         THIS.AddObject("cmd_4c_Excluir", "CommandButton")
1001:         WITH THIS.cmd_4c_Excluir
1002:             .Top             = 3
1003:             .Left            = 450
1004:             .Width           = 75
1005:             .Height          = 75
1006:             .Caption         = "Excluir"
1007:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
1008:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
1009:             .PicturePosition = 13
1010:             .FontName        = "Comic Sans MS"
1011:             .FontSize        = 8
1012:             .FontBold        = .T.
1013:             .FontItalic      = .T.
1014:             .ForeColor       = RGB(90, 90, 90)
1015:             .BackColor       = RGB(255, 255, 255)
1016:             .Themes          = .T.
1017:             .SpecialEffect   = 0
1018:             .MousePointer    = 15
1019:             .WordWrap        = .T.
1020:             .AutoSize        = .F.
1021:             .ToolTipText     = "Excluir a faixa de valores selecionada"
1022:             .Visible         = .T.
1023:         ENDWITH
1024: 
1025:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
1026:         WITH THIS.cmd_4c_Encerrar
1027:             .Top             = 3
1028:             .Left            = 525
1029:             .Width           = 75
1030:             .Height          = 75
1031:             .Caption         = "Encerrar"
1032:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1033:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1034:             .PicturePosition = 13
1035:             .FontName        = "Comic Sans MS"
1036:             .FontSize        = 8
1037:             .FontBold        = .T.
1038:             .FontItalic      = .T.
1039:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 1048 a 1121:
1048:             .Visible         = .T.
1049:         ENDWITH
1050: 
1051:         *-- BINDEVENT so DEPOIS de os dois objetos existirem, e apontando para
1052:         *-- metodos que JA estao definidos nesta classe: delegate inexistente
1053:         *-- estoura no proprio BINDEVENT e derruba o Init.
1054:         BINDEVENT(THIS.cmd_4c_Excluir,  "Click", THIS, "CmdExcluirClick")
1055:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
1056: 
1057:         RETURN .T.
1058:     ENDPROC
1059: 
1060: 
1061:     *==========================================================================
1062:     * AjustarBotoesPorModo - espelha a permissao resolvida pelo BO
1063:     *
1064:     * Legado (Init):
1065:     *     .cmdExcluir.Visible = fChecaAcesso('SigOpCrr','EXCLUIR') And ;
1066:     *                           Iif( Type('Thisform.PcEscolha') # 'C', .T., ;
1067:     *                           InList( Thisform.PcEscolha, 'INSERIR','ALTERAR' ) )
1068:     *     .cmdExcluir.Enabled = .cmdExcluir.Visible
1069:     *
1070:     * As duas condicoes ja foram resolvidas uma vez no Init do BO e moram em
1071:     * this_lPodeExcluir - aqui so se espelha, para a permissao ter fonte
1072:     * UNICA. O Encerrar nao tem gate no legado: eh a saida da tela e fica
1073:     * sempre ativo (desabilita-lo prenderia o usuario, porque o form nao tem
1074:     * barra de titulo).
1075:     *
1076:     * PUBLIC de proposito: o harness da etapa 06b chama AjustarBotoesPorModo()
1077:     * de FORA da classe e PROTECTED falharia com "Property ... is not found"
1078:     * (regra #3) - PEMSTATUS(...,5) devolve .T. mesmo para metodo protegido,
1079:     * entao o teste entra no branch e so quebra na chamada real.
1080:     *==========================================================================
1081:     PROCEDURE AjustarBotoesPorModo()
1082:         LOCAL loc_lPodeExcluir
1083: 
1084:         loc_lPodeExcluir = .F.
1085: 
1086:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1087:             loc_lPodeExcluir = THIS.this_oBusinessObject.this_lPodeExcluir
1088:         ENDIF
1089: 
1090:         IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
1091:             THIS.cmd_4c_Excluir.Visible = loc_lPodeExcluir
1092:             THIS.cmd_4c_Excluir.Enabled = loc_lPodeExcluir
1093:         ENDIF
1094: 
1095:         IF PEMSTATUS(THIS, "cmd_4c_Encerrar", 5)
1096:             THIS.cmd_4c_Encerrar.Visible = .T.
1097:             THIS.cmd_4c_Encerrar.Enabled = .T.
1098:         ENDIF
1099: 
1100:         RETURN .T.
1101:     ENDPROC
1102: 
1103: 
1104:     *==========================================================================
1105:     * CarregarLista - carrega as faixas e LIGA a grade ao cursor
1106:     *
1107:     * Transcricao do trecho de carga do Init legado:
1108:     *     With SigCdOpe.poDatamgr
1109:     *         .ReQuery('crSigOpCrr') / SELECT crSigOpCrr / Go Top
1110:     *     EndWith
1111:     *     Select CrSigOpCrr / Goto Top
1112:     *     If Reccount() = 0 And InList(Thisform.PcEscolha,'INSERIR','ALTERAR')
1113:     *         ThisForm.inserelinha()
1114:     *     Endif
1115:     *     With Thisform.GradeSubN
1116:     *         .RecordSource          = 'crSigOpCrr'
1117:     *         .Column1.ControlSource = 'crSigOpCrr.FaixaIs'
1118:     *         ... .Refresh
1119:     *     EndWith
1120:     *
1121:     * A ordem eh regra: carregar -> garantir a linha de digitacao -> LIGAR a

*-- Linhas 1130 a 1248:
1130:     *
1131:     * PUBLIC: o harness chama THIS.oForm.CarregarLista() de fora (regra #3).
1132:     *==========================================================================
1133:     PROCEDURE CarregarLista()
1134:         LOCAL loc_lSucesso, loc_cAlias, loc_oBO, loc_oErro
1135: 
1136:         loc_lSucesso = .F.
1137: 
1138:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1139:             RETURN .F.
1140:         ENDIF
1141: 
1142:         loc_oBO    = THIS.this_oBusinessObject
1143:         loc_cAlias = ALLTRIM(loc_oBO.this_cCursorDados)
1144: 
1145:         TRY
1146:             *-- CarregarFaixas prepara o cursor, traz as faixas da operacao e
1147:             *-- deixa o ponteiro no topo. Sem conexao (modo de teste) ou sem
1148:             *-- operacao no contexto ele devolve .T. com o cursor VAZIO, e a
1149:             *-- grade tem de ser ligada do mesmo jeito - senao ela fica um
1150:             *-- retangulo branco sem cabecalho.
1151:             loc_lSucesso = loc_oBO.CarregarFaixas()
1152: 
1153:             *-- Linha em branco de digitacao, como o legado faz no Init - e
1154:             *-- so nos modos editaveis.
1155:             IF USED(loc_cAlias)
1156:                 IF RECCOUNT(loc_cAlias) = 0 ;
1157:                    AND INLIST(UPPER(ALLTRIM(THIS.this_cEscolha)), "INSERIR", "ALTERAR")
1158:                     loc_oBO.InserirLinhaCursor()
1159:                 ENDIF
1160:             ENDIF
1161: 
1162:             *-- Bind + reaplicacao das propriedades de coluna
1163:             THIS.VincularGrade()
1164: 
1165:             *-- GO TOP + Refresh: popular o cursor NAO repinta a grade.
1166:             IF USED(loc_cAlias)
1167:                 SELECT (loc_cAlias)
1168:                 GO TOP
1169:             ENDIF
1170:             THIS.RepintarGrade()
1171:         CATCH TO loc_oErro
1172:             THIS.this_cMensagemErro = loc_oErro.Message
1173:             MsgErro("Erro ao carregar as faixas de valores:" + CHR(13) + ;
1174:                     loc_oErro.Message + CHR(13) + ;
1175:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1176:                     "Procedure: " + loc_oErro.Procedure, ;
1177:                     "Faixas de Valores")
1178:             loc_lSucesso = .F.
1179:         ENDTRY
1180: 
1181:         RETURN loc_lSucesso
1182:     ENDPROC
1183: 
1184: 
1185:     *==========================================================================
1186:     * VincularGrade - RecordSource + ControlSource das 4 colunas
1187:     *
1188:     * Transcricao do With Thisform.GradeSubN do Init legado, com os mesmos
1189:     * pares coluna/campo:
1190:     *     Column1 -> FaixaIs    Column3 -> Percs
1191:     *     Column2 -> FaixaFs    Column4 -> Multiplos
1192:     *
1193:     * ColumnCount eh reposto ANTES do RecordSource porque o cursor tem SETE
1194:     * colunas (as seis de SigOpCrr mais o marcador lnovos) e sem ele a grade
1195:     * se auto-expande para todas - o usuario veria cidchaves, dopes e lnovos
1196:     * na tela. O guard IF != 4 existe porque atribuir ColumnCount RECRIA os
1197:     * objetos Column, descartando tudo o que foi posto neles; reatribuir o
1198:     * mesmo valor sem necessidade so cria risco.
1199:     *
1200:     * ConfigurarColunasGrade() por ULTIMO: RecordSource e ControlSource
1201:     * acabaram de devolver as larguras ao default 90 e os cabecalhos a
1202:     * "Header1".
1203:     *
1204:     * PUBLIC porque tambem eh o ponto de religacao quando o BO avisa, por
1205:     * this_lCursorRecriado, que FECHOU e recriou o alias - fechar o alias
1206:     * derruba o binding da grade EM SILENCIO.
1207:     *==========================================================================
1208:     PROCEDURE VincularGrade()
1209:         LOCAL loc_lSucesso, loc_cAlias, loc_oGrade, loc_oErro
1210: 
1211:         loc_lSucesso = .F.
1212: 
1213:         IF VARTYPE(THIS.this_oBusinessObject) != "O" ;
1214:            OR !PEMSTATUS(THIS, "grd_4c_Dados", 5)
1215:             RETURN .F.
1216:         ENDIF
1217: 
1218:         loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorDados)
1219:         loc_oGrade = THIS.grd_4c_Dados
1220: 
1221:         IF !USED(loc_cAlias)
1222:             *-- Sem cursor nao ha o que ligar, e atribuir ControlSource agora
1223:             *-- estouraria "Alias ... is not found".
1224:             RETURN .F.
1225:         ENDIF
1226: 
1227:         TRY
1228:             WITH loc_oGrade
1229:                 IF .ColumnCount != 4
1230:                     .ColumnCount = 4
1231:                 ENDIF
1232: 
1233:                 .RecordSource = loc_cAlias
1234: 
1235:                 .Column1.ControlSource = loc_cAlias + ".faixais"
1236:                 .Column2.ControlSource = loc_cAlias + ".faixafs"
1237:                 .Column3.ControlSource = loc_cAlias + ".percs"
1238:                 .Column4.ControlSource = loc_cAlias + ".multiplos"
1239:             ENDWITH
1240: 
1241:             *-- Larguras e cabecalhos DEPOIS do bind, sempre
1242:             THIS.ConfigurarColunasGrade()
1243: 
1244:             *-- Celulas com evento DEPOIS de ConfigurarColunasGrade: o
1245:             *-- ColumnCount acima pode ter RECRIADO os objetos Column, e com
1246:             *-- eles o CurrentControl e o TextBox instalado.
1247:             THIS.InstalarCelulasFaixa(loc_oGrade)
1248: 

*-- Linhas 1261 a 1375:
1261:             MsgErro("Erro ao vincular a grade das faixas de valores:" + CHR(13) + ;
1262:                     loc_oErro.Message + CHR(13) + ;
1263:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1264:                     "Procedure: " + loc_oErro.Procedure, ;
1265:                     "Faixas de Valores")
1266:             loc_lSucesso = .F.
1267:         ENDTRY
1268: 
1269:         RETURN loc_lSucesso
1270:     ENDPROC
1271: 
1272: 
1273:     *==========================================================================
1274:     * RepintarGrade - ThisForm.GradeSubN.Refresh do legado
1275:     *
1276:     * Refresh PURO, sem GO TOP: quem precisa do topo (a carga) faz o GO TOP
1277:     * antes de chamar. O Excluir, ao contrario, acabou de reposicionar o
1278:     * ponteiro com o par Skip / Skip -1 do legado e um GO TOP aqui jogaria o
1279:     * usuario para a primeira linha a cada exclusao.
1280:     *
1281:     * PUBLIC: chamado pelos handlers e pelo harness.
1282:     *==========================================================================
1283:     PROCEDURE RepintarGrade()
1284:         LOCAL loc_oErro
1285: 
1286:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
1287:             RETURN .F.
1288:         ENDIF
1289: 
1290:         TRY
1291:             THIS.grd_4c_Dados.Refresh()
1292:         CATCH TO loc_oErro
1293:             MsgErro(loc_oErro.Message, "FormSigOpCrd.RepintarGrade")
1294:         ENDTRY
1295: 
1296:         RETURN .T.
1297:     ENDPROC
1298: 
1299: 
1300:     *==========================================================================
1301:     * InstalarCelulasFaixa - poe TextBoxFaixaSigOpCrd_4c nas colunas que o
1302:     * legado dota de evento: Column2 (Faixa Final) e Column4 (Multiplos)
1303:     *
1304:     * O legado tem LostFocus em DUAS celulas da grade, e so nessas duas:
1305:     *     SIGOPCRD.GradeSubN.Column2.Text1.LostFocus
1306:     *     SIGOPCRD.GradeSubN.Column4.Text1.LostFocus
1307:     * Column1 (Faixa Inicial) e Column3 (%) nao tem evento algum no dump -
1308:     * instalar celula nelas seria acrescentar comportamento que o legado nao
1309:     * tem (PILAR 1), entao elas seguem com o Text1 nativo.
1310:     *
1311:     * POR QUE SUBCLASSE E NAO BINDEVENT: BINDEVENT em evento de TextBox dentro
1312:     * de Column nao dispara de forma confiavel no VFP9 - eh a razao de existir
1313:     * classes\TextBoxGridLookup.prg, que documenta isso no proprio cabecalho.
1314:     * O caminho canonico do projeto (regra #46, referencia FormLpr) eh um
1315:     * TextBox subclasse com o evento EMBUTIDO delegando a metodo PUBLIC do
1316:     * form, posto na coluna com AddObject + CurrentControl + Sparse = .F.
1317:     *
1318:     * As TRES linhas finais sao obrigatorias juntas (regra #18):
1319:     *     AddObject         - cria o objeto, mas a coluna segue desenhando o Text1
1320:     *     CurrentControl    - eh o que faz a coluna DESENHAR o novo controle
1321:     *     Sparse = .F.      - senao ele so aparece na linha ATIVA
1322:     * Faltando CurrentControl o controle existe, responde a PEMSTATUS e NUNCA
1323:     * aparece - e o LostFocus nunca roda, sem erro e sem log.
1324:     *
1325:     * As propriedades de Text1 do dump sao reaplicadas AQUI porque
1326:     * ConfigurarColunasGrade configura o .Text1, que nestas duas colunas
1327:     * deixou de ser o controle exibido - sem repetir, as duas celulas sairiam
1328:     * com borda, margem e fonte diferentes das outras duas. InputMask tambem
1329:     * entra no controle: a mascara da COLUNA nao chega ao TextBox instalado.
1330:     *
1331:     * IDEMPOTENTE (guard PEMSTATUS): eh chamado de VincularGrade, que roda em
1332:     * toda carga, e AddObject com nome repetido estoura "Object ... is already
1333:     * defined" e derruba o Init.
1334:     *==========================================================================
1335:     PROTECTED PROCEDURE InstalarCelulasFaixa(par_oGrade)
1336:         LOCAL loc_nI, loc_nCol, loc_oColuna, loc_cCampo, loc_oErro
1337: 
1338:         IF VARTYPE(par_oGrade) != "O"
1339:             RETURN .F.
1340:         ENDIF
1341: 
1342:         TRY
1343:             FOR loc_nI = 1 TO 2
1344:                 *-- Column2 -> faixafs ; Column4 -> multiplos
1345:                 loc_nCol   = IIF(loc_nI = 1, 2, 4)
1346:                 loc_cCampo = IIF(loc_nI = 1, "faixafs", "multiplos")
1347: 
1348:                 IF par_oGrade.ColumnCount < loc_nCol
1349:                     LOOP
1350:                 ENDIF
1351: 
1352:                 loc_oColuna = par_oGrade.Columns(loc_nCol)
1353: 
1354:                 IF !PEMSTATUS(loc_oColuna, "txt_4c_Faixa", 5)
1355:                     loc_oColuna.AddObject("txt_4c_Faixa", "TextBoxFaixaSigOpCrd_4c")
1356:                 ENDIF
1357: 
1358:                 WITH loc_oColuna.txt_4c_Faixa
1359:                     .this_cCampo = loc_cCampo
1360: 
1361:                     *-- Text1 do dump, celula por celula
1362:                     .FontName    = "Tahoma"
1363:                     .FontSize    = 8
1364:                     .BorderStyle = 0
1365:                     .Margin      = 0
1366:                     .ForeColor   = RGB(0, 0, 0)
1367:                     .BackColor   = RGB(255, 255, 255)
1368: 
1369:                     *-- Dump: Column2.InputMask e Column4.InputMask
1370:                     .InputMask   = "999,999,999.99"
1371: 
1372:                     *-- Dump: so a Column2.Text1 declara ReadOnly = .F.
1373:                     *-- explicito; na Column4 o default .F. ja eh esse valor.
1374:                     .ReadOnly    = .F.
1375: 

*-- Linhas 1389 a 1831:
1389:             MsgErro("Erro ao instalar as c" + CHR(233) + "lulas da grade:" + CHR(13) + ;
1390:                     loc_oErro.Message + CHR(13) + ;
1391:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1392:                     "Procedure: " + loc_oErro.Procedure, ;
1393:                     "Faixas de Valores")
1394:         ENDTRY
1395: 
1396:         RETURN .T.
1397:     ENDPROC
1398: 
1399: 
1400:     *==========================================================================
1401:     * ValidarFaixaFinal - LostFocus da Column2.Text1 (Faixa Final) do legado
1402:     *
1403:     * Legado, LITERAL:
1404:     *     PROCEDURE LostFocus
1405:     *     If IsEmpty(This.Value)
1406:     *         Thisform.cmdSair.SetFocus
1407:     *     EndIf
1408:     *
1409:     * Faixa Final em branco significa "acabei de preencher": o legado leva o
1410:     * usuario direto ao Encerrar, que eh o botao que grava. NAO eh validacao
1411:     * com mensagem - nao existe aviso nenhum aqui, e inventar um mudaria o
1412:     * fluxo da tela (PILAR 1).
1413:     *
1414:     * O valor lido eh par_oTxt.Value, NAO a coluna do cursor: dentro do evento
1415:     * da celula o cursor ainda NAO recebeu o que foi digitado, entao ler do
1416:     * cursor validaria o valor ANTIGO (regra #46).
1417:     *
1418:     * IsEmpty do Fortyus trata .NULL. como vazio, ao contrario do EMPTY nativo
1419:     * do VFP (medido: EMPTY(.NULL.) devolve .F.). Daqui sai o ISNULL em IF
1420:     * SEPARADO - VFP9 nao faz short-circuit em OR, entao ISNULL(x) OR EMPTY(x)
1421:     * avaliaria EMPTY(.NULL.) de qualquer jeito.
1422:     *
1423:     * PUBLIC: chamado pela classe da celula (THISFORM.ValidarFaixaFinal) e
1424:     * pelo harness.
1425:     *==========================================================================
1426:     PROCEDURE ValidarFaixaFinal(par_oTxt)
1427:         *-- Wrapper fino da guarda de reentrancia. O corpo fica no ...Exec
1428:         *-- porque este metodo tem RETURN antecipado: liberar a flag "no fim
1429:         *-- do corpo" a deixaria travada ligada e MATARIA o handler pelo resto
1430:         *-- da vida do form.
1431:         IF THIS.this_lEmCelula
1432:             RETURN .T.
1433:         ENDIF
1434: 
1435:         THIS.this_lEmCelula = .T.
1436:         THIS.ValidarFaixaFinalExec(par_oTxt)
1437:         THIS.this_lEmCelula = .F.
1438: 
1439:         RETURN .T.
1440:     ENDPROC
1441: 
1442: 
1443:     *==========================================================================
1444:     * ValidarFaixaFinalExec - corpo de ValidarFaixaFinal
1445:     *==========================================================================
1446:     PROTECTED PROCEDURE ValidarFaixaFinalExec(par_oTxt)
1447:         LOCAL loc_lVazio, loc_uValor, loc_oErro
1448: 
1449:         IF VARTYPE(par_oTxt) != "O"
1450:             RETURN .F.
1451:         ENDIF
1452: 
1453:         TRY
1454:             loc_uValor = par_oTxt.Value
1455:             loc_lVazio = .F.
1456: 
1457:             *-- IF separado, nunca ISNULL(x) OR EMPTY(x)
1458:             IF ISNULL(loc_uValor)
1459:                 loc_lVazio = .T.
1460:             ELSE
1461:                 IF EMPTY(loc_uValor)
1462:                     loc_lVazio = .T.
1463:                 ENDIF
1464:             ENDIF
1465: 
1466:             IF loc_lVazio
1467:                 IF PEMSTATUS(THIS, "cmd_4c_Encerrar", 5)
1468:                     *-- SetFocus falha em controle que nao esta visivel e
1469:                     *-- habilitado (caminho de carga, form ainda nao mostrado).
1470:                     IF THIS.cmd_4c_Encerrar.Visible AND THIS.cmd_4c_Encerrar.Enabled
1471:                         THIS.cmd_4c_Encerrar.SetFocus()
1472:                     ENDIF
1473:                 ENDIF
1474:             ENDIF
1475:         CATCH TO loc_oErro
1476:             THIS.this_cMensagemErro = loc_oErro.Message
1477:             MsgErro("Erro ao sair do campo Faixa Final:" + CHR(13) + ;
1478:                     loc_oErro.Message + CHR(13) + ;
1479:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1480:                     "Procedure: " + loc_oErro.Procedure, ;
1481:                     "Faixas de Valores")
1482:         ENDTRY
1483: 
1484:         RETURN .T.
1485:     ENDPROC
1486: 
1487: 
1488:     *==========================================================================
1489:     * ValidarMultiplos - LostFocus da Column4.Text1 (Multiplos) do legado
1490:     *
1491:     * Legado, LITERAL:
1492:     *     PROCEDURE LostFocus
1493:     *     Select CrSigOpCrr
1494:     *     Locate for faixafs = 0
1495:     *     If Eof()
1496:     *         Thisform.Inserelinha()
1497:     *     EndIf
1498:     *     Select CrSigOpCrr
1499:     *
1500:     * Multiplos eh a ULTIMA coluna: ao sair dela o legado garante que exista
1501:     * sempre UMA linha em branco esperando digitacao - se nenhuma linha tem
1502:     * faixafs = 0, ele cria. Eh assim que o usuario acrescenta faixas sem
1503:     * nenhum botao de "inserir": preenche a linha e a proxima aparece.
1504:     *
1505:     * Esse LOCATE eh tambem o que, na pratica, liga o marcador de alteracao
1506:     * a gravar que o Encerrar consulta - as linhas vindas do servidor nunca
1507:     * tem faixafs = 0, entao InserirLinha roda e marca this_lHouveInsercao
1508:     * (ver HaAlteracaoPendente no BO). Por isso adiar este handler deixaria a
1509:     * tela gravando MENOS do que o legado grava.
1510:     *
1511:     * O LOCATE roda sobre o CURSOR (nao sobre par_oTxt.Value): aqui a pergunta
1512:     * eh "existe linha em branco na grade?", nao "o que foi digitado?".
1513:     *
1514:     * PUBLIC: chamado pela classe da celula e pelo harness.
1515:     *==========================================================================
1516:     PROCEDURE ValidarMultiplos(par_oTxt)
1517:         IF THIS.this_lEmCelula
1518:             RETURN .T.
1519:         ENDIF
1520: 
1521:         THIS.this_lEmCelula = .T.
1522:         THIS.ValidarMultiplosExec(par_oTxt)
1523:         THIS.this_lEmCelula = .F.
1524: 
1525:         RETURN .T.
1526:     ENDPROC
1527: 
1528: 
1529:     *==========================================================================
1530:     * ValidarMultiplosExec - corpo de ValidarMultiplos
1531:     *==========================================================================
1532:     PROTECTED PROCEDURE ValidarMultiplosExec(par_oTxt)
1533:         LOCAL loc_cAlias, loc_lPrecisaLinha, loc_oErro
1534: 
1535:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1536:             RETURN .F.
1537:         ENDIF
1538: 
1539:         loc_cAlias       = ALLTRIM(THIS.this_oBusinessObject.this_cCursorDados)
1540:         loc_lPrecisaLinha = .F.
1541: 
1542:         IF !USED(loc_cAlias)
1543:             RETURN .F.
1544:         ENDIF
1545: 
1546:         TRY
1547:             SELECT (loc_cAlias)
1548:             LOCATE FOR faixafs = 0
1549: 
1550:             IF EOF()
1551:                 loc_lPrecisaLinha = .T.
1552:             ENDIF
1553: 
1554:             IF loc_lPrecisaLinha
1555:                 THIS.InserirLinha()
1556:             ENDIF
1557: 
1558:             *-- Select final do legado: o LOCATE pode ter deixado o alias
1559:             *-- corrente em outro lugar e o resto da tela conta com este.
1560:             IF USED(loc_cAlias)
1561:                 SELECT (loc_cAlias)
1562:             ENDIF
1563:         CATCH TO loc_oErro
1564:             THIS.this_cMensagemErro = loc_oErro.Message
1565:             MsgErro("Erro ao sair do campo M" + CHR(250) + "ltiplos:" + CHR(13) + ;
1566:                     loc_oErro.Message + CHR(13) + ;
1567:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1568:                     "Procedure: " + loc_oErro.Procedure, ;
1569:                     "Faixas de Valores")
1570:         ENDTRY
1571: 
1572:         RETURN .T.
1573:     ENDPROC
1574: 
1575: 
1576:     *==========================================================================
1577:     * InserirLinha - parte de TELA do inserelinha legado
1578:     *
1579:     * Legado COMPLETO:
1580:     *     PROCEDURE inserelinha
1581:     *     Thisform.lHouveIns = .T.
1582:     *     Select crSigOpCrr
1583:     *     Locate for faixafs=0
1584:     *     If Eof()
1585:     *         Insert Into crSigOpCrr (Dopes, CidChaves) ;
1586:     *             Values (crSigCdOpe.Dopes, fUniqueIds())
1587:     *     EndIf
1588:     *     Select crSigOpCrr
1589:     *     Keyboard '{DNARROW}'
1590:     *     ThisForm.GradeSubN.Refresh
1591:     *     Thisform.GradeSubN.Column1.SetFocus
1592:     *
1593:     * A parte de DADOS (marcador lHouveIns, LOCATE, INSERT com a chave de
1594:     * fUniqueIds) esta em InserirLinhaCursor, no BO - inclusive o marcador
1595:     * ligado INCONDICIONALMENTE na primeira linha, como no legado: ele vale
1596:     * mesmo quando a linha em branco ja existia e o INSERT nao roda.
1597:     *
1598:     * Aqui ficam as TRES ultimas linhas, que sao de tela e que o migrador
1599:     * costuma descartar junto com o resto do handler - e sao elas que tornam a
1600:     * linha nova USAVEL: sem o Refresh a grade continua mostrando o cursor
1601:     * antigo (popular cursor NAO repinta a grade, regra #21a) e sem o SetFocus
1602:     * o usuario tem de ir com o mouse ate a primeira coluna da linha nova.
1603:     *
1604:     * O Keyboard '{DNARROW}' eh transcrito como esta: ele enfileira a tecla
1605:     * para DEPOIS deste metodo, e eh o que leva o cursor da grade para a linha
1606:     * recem-criada.
1607:     *
1608:     * SetFocus so com o form MOSTRADO: este metodo tambem eh alcancavel pelo
1609:     * caminho de carga (grade vazia), onde o form ainda nao foi exibido e o
1610:     * SetFocus falharia. Eh a mesma razao pela qual CarregarLista chama
1611:     * InserirLinhaCursor direto, sem passar por aqui.
1612:     *
1613:     * PUBLIC: chamado por ValidarMultiplos e pelo harness.
1614:     *==========================================================================
1615:     PROCEDURE InserirLinha()
1616:         LOCAL loc_lSucesso, loc_oErro
1617: 
1618:         loc_lSucesso = .F.
1619: 
1620:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1621:             RETURN .F.
1622:         ENDIF
1623: 
1624:         *-- Dados: marcador + LOCATE + INSERT (transcritos no BO)
1625:         loc_lSucesso = THIS.this_oBusinessObject.InserirLinhaCursor()
1626: 
1627:         IF !loc_lSucesso
1628:             *-- InserirLinhaCursor ja exibiu o motivo; sem linha nova nao ha
1629:             *-- navegacao a fazer.
1630:             RETURN .F.
1631:         ENDIF
1632: 
1633:         TRY
1634:             *-- Keyboard do legado: leva a grade para a linha nova
1635:             KEYBOARD "{DNARROW}"
1636: 
1637:             THIS.RepintarGrade()
1638: 
1639:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND THIS.Visible
1640:                 IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled
1641:                     THIS.grd_4c_Dados.Column1.SetFocus()
1642:                 ENDIF
1643:             ENDIF
1644:         CATCH TO loc_oErro
1645:             *-- Navegacao que falha NAO invalida a linha ja inserida: o
1646:             *-- resultado segue .T. e o usuario so perde o posicionamento
1647:             *-- automatico. Avisar em vez de engolir (regra #9).
1648:             MsgErro("Erro ao posicionar a grade na linha nova:" + CHR(13) + ;
1649:                     loc_oErro.Message + CHR(13) + ;
1650:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1651:                     "Procedure: " + loc_oErro.Procedure, ;
1652:                     "Faixas de Valores")
1653:         ENDTRY
1654: 
1655:         RETURN loc_lSucesso
1656:     ENDPROC
1657: 
1658: 
1659:     *==========================================================================
1660:     * CmdExcluirClick - cmdExcluir.Click do legado
1661:     *
1662:     * Legado:
1663:     *     Select crSigOpCrr
1664:     *     If Not Eof()
1665:     *         Thisform.lHouveExcl = .T.
1666:     *         Delete / Skip / Skip - 1
1667:     *     Endif
1668:     *     ThisForm.GradeSubN.Refresh
1669:     *
1670:     * A parte de DADOS (marcador, DELETE e reposicionamento do ponteiro) mora
1671:     * em ExcluirLinhaCursor, no BO; aqui fica o que eh da TELA. O Refresh vem
1672:     * FORA do IF, como no legado: ele repinta tambem quando nada foi excluido.
1673:     *
1674:     * A remocao eh LOCAL - no legado o DELETE so chega ao servidor junto com a
1675:     * gravacao do Encerrar, e eh isso que GravarFaixas reproduz. Nao ha
1676:     * confirmacao porque o legado nao pede nenhuma, e o Encerrar eh a ultima
1677:     * chance de desistir (fechar sem clicar nele descarta tudo).
1678:     *==========================================================================
1679:     PROCEDURE CmdExcluirClick()
1680:         LOCAL loc_lSucesso
1681: 
1682:         loc_lSucesso = .F.
1683: 
1684:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1685:             loc_lSucesso = THIS.this_oBusinessObject.ExcluirLinhaCursor()
1686:         ENDIF
1687: 
1688:         THIS.RepintarGrade()
1689: 
1690:         RETURN loc_lSucesso
1691:     ENDPROC
1692: 
1693: 
1694:     *==========================================================================
1695:     * CmdEncerrarClick - cmdSair.Click do legado
1696:     *
1697:     * Legado:
1698:     *     If ( Thisform.lHouveExcl Or Thisform.lHouveIns )
1699:     *         ... Delete For Empty(Dopes) or Empty(faixafs)
1700:     *         ... Replace CidChaves with fUniqueIds() For Empty(CidChaves)
1701:     *         ... poDataMgr.UpDate / Commit / RollBack
1702:     *         If Not m.lnErro1>0
1703:     *             = MessageBox('Erro na Gravacao dos Dados do Cadastro de Operacoes.',48)
1704:     *         EndIf
1705:     *     EndIf
1706:     *     Thisform.ParentForm.Enabled = .T.
1707:     *     ThisForm.Release
1708:     *
1709:     * Tudo o que esta dentro do If (guard de alteracao a gravar, descarte das
1710:     * linhas em branco, geracao das chaves e o lote atomico) esta em
1711:     * GravarFaixas; aqui fica a sequencia da TELA.
1712:     *
1713:     * TRANSCRICAO FIEL, inclusive no ponto incomodo: o legado LIBERA O PAI E
1714:     * FECHA A TELA MESMO QUANDO A GRAVACAO FALHA - o RollBack desfaz no
1715:     * servidor, a MessageBox avisa, e o que foi digitado se perde. Fica igual
1716:     * de proposito (PILAR 1). GravarFaixas sempre exibe o motivo real do SQL
1717:     * Server antes de devolver .F., entao a falha nunca eh muda.
1718:     *
1719:     * Release() eh a ULTIMA linha, e nada eh lido do form depois dele: o
1720:     * Release destroi o objeto e qualquer acesso seguinte cairia em referencia
1721:     * morta. ReabilitarFormPai vem antes e eh idempotente - o Destroy, que o
1722:     * proprio Release dispara, chama de novo sem efeito.
1723:     *==========================================================================
1724:     PROCEDURE CmdEncerrarClick()
1725:         LOCAL loc_lGravou
1726: 
1727:         loc_lGravou = .T.
1728: 
1729:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1730:             *-- Flush da celula em edicao ANTES do lote: GravarFaixas le cada
1731:             *-- linha do CURSOR, e o que esta no controle da coluna ativa pode
1732:             *-- nao ter chegado nele. FormParaBO escreve so essa celula (ver o
1733:             *-- cabecalho dele) - sem isto o ultimo valor digitado poderia ser
1734:             *-- gravado com o conteudo anterior, sem erro e sem aviso.
1735:             THIS.FormParaBO()
1736: 
1737:             *-- Fecha a digitacao enquanto o lote roda, que eh o mesmo que o
1738:             *-- legado faz com o form PAI (ParentForm.Enabled = .F.). A tela
1739:             *-- fecha em seguida nos dois caminhos, entao nao ha reabertura a
1740:             *-- fazer - e o Encerrar continua ativo de proposito.
1741:             THIS.HabilitarCampos(.F.)
1742: 
1743:             *-- GravarFaixas ja carrega o guard do legado: sem alteracao
1744:             *-- a gravar ele nao toca no banco e devolve .T.
1745:             loc_lGravou = THIS.this_oBusinessObject.GravarFaixas()
1746:         ENDIF
1747: 
1748:         THIS.ReabilitarFormPai()
1749:         THIS.Release()
1750: 
1751:         RETURN loc_lGravou
1752:     ENDPROC
1753: 
1754: 
1755:     *==========================================================================
1756:     * DesabilitarFormPai - ParentForm.Enabled = .F. do legado
1757:     *==========================================================================
1758:     PROCEDURE DesabilitarFormPai()
1759:         LOCAL loc_oErro
1760: 
1761:         IF VARTYPE(THIS.this_oFormPai) != "O"
1762:             RETURN .F.
1763:         ENDIF
1764: 
1765:         TRY
1766:             IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
1767:                 IF THIS.this_oFormPai.Enabled
1768:                     THIS.this_oFormPai.Enabled = .F.
1769:                     *-- Marca que o bloqueio eh NOSSO: so assim a reabilitacao
1770:                     *-- pode acontecer sem risco de reabilitar um form que ja
1771:                     *-- estava desabilitado por outro motivo.
1772:                     THIS.this_lPaiDesabilitado = .T.
1773:                 ENDIF
1774:             ENDIF
1775:         CATCH TO loc_oErro
1776:             MsgErro(loc_oErro.Message, "FormSigOpCrd.DesabilitarFormPai")
1777:         ENDTRY
1778: 
1779:         RETURN THIS.this_lPaiDesabilitado
1780:     ENDPROC
1781: 
1782: 
1783:     *==========================================================================
1784:     * ReabilitarFormPai - ParentForm.Enabled = .T. do legado
1785:     *
1786:     * IDEMPOTENTE e chamado pelo FUNIL de volta (aqui o Destroy; na fase do
1787:     * botao Encerrar, tambem o cmdSair). Dialogo sem barra de titulo ainda
1788:     * fecha por Alt+F4 - se a reabilitacao morasse so no botao, esse caminho
1789:     * deixaria o cadastro de Operacoes desabilitado para sempre.
1790:     *==========================================================================
1791:     PROCEDURE ReabilitarFormPai()
1792:         LOCAL loc_oErro
1793: 
1794:         IF !THIS.this_lPaiDesabilitado OR VARTYPE(THIS.this_oFormPai) != "O"
1795:             RETURN .F.
1796:         ENDIF
1797: 
1798:         TRY
1799:             IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
1800:                 THIS.this_oFormPai.Enabled = .T.
1801:             ENDIF
1802:         CATCH TO loc_oErro
1803:             *-- O guard de VARTYPE acima ja absorve o caso NORMAL de o pai ter
1804:             *-- sido liberado antes, entao chegar aqui eh de fato inesperado -
1805:             *-- e a consequencia eh grave: o cadastro de Operacoes continuaria
1806:             *-- desabilitado e o usuario ficaria preso. Por isso avisa em vez
1807:             *-- de engolir (regra #9).
1808:             MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel reabilitar a tela de origem: " + ;
1809:                     loc_oErro.Message, "FormSigOpCrd.ReabilitarFormPai")
1810:         ENDTRY
1811: 
1812:         *-- Marcador cai nos dois caminhos, para o Destroy nao repetir a
1813:         *-- tentativa (e, no caminho de erro, nao repetir o aviso).
1814:         THIS.this_lPaiDesabilitado = .F.
1815: 
1816:         RETURN .T.
1817:     ENDPROC
1818: 
1819: 
1820:     *==========================================================================
1821:     * FormParaBO - transfere a LINHA CORRENTE da grade para o BO
1822:     *
1823:     * Nesta tela a "ficha" nao eh um painel de campos soltos: eh a LINHA da
1824:     * grade. As quatro colunas tem ControlSource ligado direto ao cursor
1825:     * (VincularGrade), entao o estado dos campos JA mora no cursor - o que
1826:     * este hook acrescenta eh o unico pedaco que ainda nao chegou nele: a
1827:     * celula que o usuario esta digitando AGORA.
1828:     *
1829:     * POR QUE SO A COLUNA ATIVA EH LIDA DO CONTROLE
1830:     *
1831:     * Com Sparse = .F. a coluna desenha o MESMO objeto de controle em todas as

*-- Linhas 1851 a 1903:
1851:     * BO. A lista de colunas fica, assim, em UM lugar so - o BO.
1852:     *
1853:     * PROTECTED EXPLICITO, e nao eh escolha de estilo: FormBase declara
1854:     * PROTECTED PROCEDURE FormParaBO (eh um dos hooks que Salvar/Novo/Cancelar
1855:     * chamam por THIS.) e o VFP9 NAO deixa a subclasse ALARGAR o escopo -
1856:     * escrever sem o modificador nao torna publico, so esconde que continua
1857:     * protegido. Medido nesta tela em 2026-10-30: chamado de um script solto,
1858:     * estoura "Property FORMPARABO is not found"; chamado por THIS. de dentro
1859:     * da classe, ou de uma SUBCLASSE de teste, funciona. PEMSTATUS(...,5) nao
1860:     * ajuda a descobrir isso - ele responde "existe?", nao "da para chamar
1861:     * daqui?" (mesma armadilha da regra #3).
1862:     *==========================================================================
1863:     PROTECTED PROCEDURE FormParaBO()
1864:         LOCAL loc_lSucesso, loc_cAlias, loc_oGrade, loc_nAtiva
1865:         LOCAL loc_oColuna, loc_cControle, loc_oCelula, loc_uValor, loc_oErro
1866: 
1867:         loc_lSucesso = .F.
1868: 
1869:         IF VARTYPE(THIS.this_oBusinessObject) != "O" ;
1870:            OR !PEMSTATUS(THIS, "grd_4c_Dados", 5)
1871:             RETURN .F.
1872:         ENDIF
1873: 
1874:         loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorDados)
1875: 
1876:         IF !USED(loc_cAlias)
1877:             *-- Sem cursor nao ha linha corrente a transferir. Nao eh erro:
1878:             *-- acontece em modo de teste, antes da primeira carga.
1879:             RETURN .F.
1880:         ENDIF
1881: 
1882:         loc_oGrade = THIS.grd_4c_Dados
1883: 
1884:         TRY
1885:             SELECT (loc_cAlias)
1886: 
1887:             IF !EOF()
1888:                 loc_nAtiva = loc_oGrade.ActiveColumn
1889: 
1890:                 IF loc_nAtiva >= 1 AND loc_nAtiva <= 4 ;
1891:                    AND loc_nAtiva <= loc_oGrade.ColumnCount
1892:                     loc_oColuna   = loc_oGrade.Columns(loc_nAtiva)
1893:                     loc_cControle = ALLTRIM(NVL(loc_oColuna.CurrentControl, ""))
1894:                     loc_oCelula   = .NULL.
1895: 
1896:                     *-- Membro alcancado por NOME: EVALUATE na LEITURA, nunca
1897:                     *-- Controls(<nome>) - Controls eh indexado por NUMERO e o
1898:                     *-- nome estoura em runtime (regra #34).
1899:                     IF !EMPTY(loc_cControle) ;
1900:                        AND PEMSTATUS(loc_oColuna, loc_cControle, 5)
1901:                         loc_oCelula = EVALUATE("loc_oColuna." + loc_cControle)
1902:                     ENDIF
1903: 

*-- Linhas 1942 a 2297:
1942:             MsgErro("Erro ao transferir a faixa de valores da tela:" + CHR(13) + ;
1943:                     loc_oErro.Message + CHR(13) + ;
1944:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1945:                     "Procedure: " + loc_oErro.Procedure, ;
1946:                     "Faixas de Valores")
1947:             loc_lSucesso = .F.
1948:         ENDTRY
1949: 
1950:         RETURN loc_lSucesso
1951:     ENDPROC
1952: 
1953: 
1954:     *==========================================================================
1955:     * BOParaForm - escreve as properties do BO na LINHA CORRENTE da grade
1956:     *
1957:     * Sentido inverso do FormParaBO, com o MESMO par coluna/campo de
1958:     * VincularGrade. Como as colunas tem ControlSource, escrever no CURSOR eh
1959:     * escrever "no campo da tela" - nao existe .Value avulso a atualizar; o que
1960:     * falta depois eh so repintar, porque mexer no cursor NAO repinta a grade
1961:     * (regra #21).
1962:     *
1963:     * SO as QUATRO colunas visiveis sao escritas. cidchaves e dopes ficam de
1964:     * fora de proposito: eles sao a IDENTIDADE da linha (a chave gerada por
1965:     * fUniqueIds no InserirLinhaCursor e a operacao dona das faixas), nao
1966:     * campos de tela. Sobrescreve-los aqui trocaria a linha de registro - ou,
1967:     * pior, a deixaria com dopes vazio, que eh justamente o que o
1968:     * "Delete For Empty(Dopes)" do Encerrar legado joga fora.
1969:     *
1970:     * GUARDA DE IDENTIDADE: com this_cCidchaves preenchido, a escrita so
1971:     * acontece se a linha corrente for essa mesma. O BO eh carregado linha a
1972:     * linha pelo SCAN de GravarFaixas, entao sem essa conferencia uma chamada
1973:     * fora de hora escreveria os valores de uma faixa sobre outra. Com
1974:     * this_cCidchaves VAZIO (o que LimparDados produz) a guarda nao se aplica:
1975:     * ali a intencao eh justamente zerar a linha corrente.
1976:     *
1977:     * PROTECTED EXPLICITO pelo mesmo motivo do FormParaBO: FormBase declara
1978:     * PROTECTED PROCEDURE BOParaForm e o escopo vem da HERANCA - omitir o
1979:     * modificador nao alarga nada. Chamado por THIS. de dentro da classe
1980:     * (LimparCampos e o funil do Encerrar).
1981:     *==========================================================================
1982:     PROTECTED PROCEDURE BOParaForm()
1983:         LOCAL loc_lSucesso, loc_cAlias, loc_oBO, loc_cChaveBO, loc_oErro
1984: 
1985:         loc_lSucesso = .F.
1986: 
1987:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1988:             RETURN .F.
1989:         ENDIF
1990: 
1991:         loc_oBO      = THIS.this_oBusinessObject
1992:         loc_cAlias   = ALLTRIM(loc_oBO.this_cCursorDados)
1993:         loc_cChaveBO = ALLTRIM(NVL(loc_oBO.this_cCidchaves, ""))
1994: 
1995:         IF !USED(loc_cAlias)
1996:             RETURN .F.
1997:         ENDIF
1998: 
1999:         TRY
2000:             SELECT (loc_cAlias)
2001: 
2002:             DO CASE
2003:             CASE EOF()
2004:                 *-- Sem linha corrente nao ha o que escrever.
2005:                 loc_lSucesso = .F.
2006: 
2007:             CASE !EMPTY(loc_cChaveBO) ;
2008:                  AND ALLTRIM(NVL(cidchaves, "")) != loc_cChaveBO
2009:                 *-- A linha corrente nao eh a que o BO carregou.
2010:                 loc_lSucesso = .F.
2011: 
2012:             OTHERWISE
2013:                 REPLACE faixais   WITH loc_oBO.this_nFaixais,   ;
2014:                         faixafs   WITH loc_oBO.this_nFaixafs,   ;
2015:                         percs     WITH loc_oBO.this_nPercs,     ;
2016:                         multiplos WITH loc_oBO.this_nMultiplos  ;
2017:                     IN (loc_cAlias)
2018: 
2019:                 THIS.RepintarGrade()
2020: 
2021:                 loc_lSucesso = .T.
2022:             ENDCASE
2023:         CATCH TO loc_oErro
2024:             THIS.this_cMensagemErro = loc_oErro.Message
2025:             MsgErro("Erro ao exibir a faixa de valores na grade:" + CHR(13) + ;
2026:                     loc_oErro.Message + CHR(13) + ;
2027:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2028:                     "Procedure: " + loc_oErro.Procedure, ;
2029:                     "Faixas de Valores")
2030:             loc_lSucesso = .F.
2031:         ENDTRY
2032: 
2033:         RETURN loc_lSucesso
2034:     ENDPROC
2035: 
2036: 
2037:     *==========================================================================
2038:     * HabilitarCampos - abre ou fecha a digitacao na grade
2039:     *
2040:     * O UNICO campo de entrada desta tela eh a grade, entao "habilitar campos"
2041:     * aqui eh abrir/fechar a grade e as suas quatro colunas.
2042:     *
2043:     * NAO HA GATE POR MODO, e isso eh transcricao, nao esquecimento. O legado
2044:     * condiciona ao PcEscolha apenas o cmdExcluir:
2045:     *     .cmdExcluir.Visible = fChecaAcesso('SigOpCrr','EXCLUIR') And ;
2046:     *                           InList( Thisform.PcEscolha, 'INSERIR','ALTERAR' )
2047:     * A GRADE continua editavel em TODOS os modos - inclusive em PROCURAR, em
2048:     * que digitar na ultima coluna faz o LostFocus chamar inserelinha, que liga
2049:     * lHouveIns e portanto FAZ a tela gravar. Fechar a grade por modo
2050:     * REMOVERIA uma capacidade que o legado tem (PILAR 1), entao o unico
2051:     * criterio aqui eh o parametro.
2052:     *
2053:     * Grid.ReadOnly vem ANTES de Column.ReadOnly: o do grid PROPAGA para as
2054:     * colunas e sobrescreveria o que fosse posto antes (regra #18/#46). As
2055:     * QUATRO colunas sao reabertas, nao apenas as duas que InstalarCelulasFaixa
2056:     * toca - Column1 e Column3 seguem com o Text1 nativo e, sem esta passagem,
2057:     * ficariam com o ReadOnly que o grid acabou de propagar.
2058:     *
2059:     * Os botoes NAO entram no caminho de HABILITAR: quem decide o Excluir eh a
2060:     * permissao resolvida pelo BO, e a fonte unica dela eh AjustarBotoesPorModo.
2061:     * No caminho de FECHAR o Excluir acompanha a grade (nao faz sentido apagar
2062:     * linha de uma grade congelada) e o Encerrar fica SEMPRE ativo - o form nao
2063:     * tem barra de titulo e desabilita-lo prenderia o usuario.
2064:     *
2065:     * par_lHabilitar ausente eh tratado como .T.: o harness chama sem argumento.
2066:     * O teste eh PCOUNT(), nunca VARTYPE - em VFP9 parametro NAO passado chega
2067:     * como .F. LOGICO, entao VARTYPE(par_lHabilitar) devolve "L" tanto para
2068:     * "nao passou" quanto para "passou .F.", e a chamada sem argumento acabaria
2069:     * FECHANDO a grade. Medido nesta tela em 2026-10-30: com o VARTYPE,
2070:     * HabilitarCampos() deixava Grid.ReadOnly = .T. e Enabled = .F.
2071:     *
2072:     * PUBLIC de verdade: HabilitarCampos NAO existe em FormBase, logo nao ha
2073:     * escopo herdado a respeitar - ao contrario de FormParaBO/BOParaForm/
2074:     * LimparCampos, que sao PROTECTED na base.
2075:     *==========================================================================
2076:     PROCEDURE HabilitarCampos(par_lHabilitar)
2077:         LOCAL loc_lHabilitar, loc_nI, loc_oGrade, loc_oErro
2078: 
2079:         loc_lHabilitar = .T.
2080: 
2081:         IF PCOUNT() >= 1 AND VARTYPE(par_lHabilitar) = "L"
2082:             loc_lHabilitar = par_lHabilitar
2083:         ENDIF
2084: 
2085:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
2086:             RETURN .F.
2087:         ENDIF
2088: 
2089:         loc_oGrade = THIS.grd_4c_Dados
2090: 
2091:         TRY
2092:             loc_oGrade.Enabled = loc_lHabilitar
2093: 
2094:             *-- Grid PRIMEIRO - ele propaga para as colunas
2095:             loc_oGrade.ReadOnly = !loc_lHabilitar
2096: 
2097:             FOR loc_nI = 1 TO MIN(4, loc_oGrade.ColumnCount)
2098:                 loc_oGrade.Columns(loc_nI).ReadOnly = !loc_lHabilitar
2099:             ENDFOR
2100: 
2101:             IF loc_lHabilitar
2102:                 *-- A permissao do Excluir tem fonte UNICA
2103:                 THIS.AjustarBotoesPorModo()
2104:             ELSE
2105:                 IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
2106:                     THIS.cmd_4c_Excluir.Enabled = .F.
2107:                 ENDIF
2108:             ENDIF
2109:         CATCH TO loc_oErro
2110:             THIS.this_cMensagemErro = loc_oErro.Message
2111:             MsgErro("Erro ao ajustar a digita" + CHR(231) + CHR(227) + "o da grade:" + CHR(13) + ;
2112:                     loc_oErro.Message + CHR(13) + ;
2113:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2114:                     "Procedure: " + loc_oErro.Procedure, ;
2115:                     "Faixas de Valores")
2116:         ENDTRY
2117: 
2118:         RETURN .T.
2119:     ENDPROC
2120: 
2121: 
2122:     *==========================================================================
2123:     * LimparCampos - devolve a linha corrente ao estado "em branco"
2124:     *
2125:     * A linha em branco desta tela eh, por definicao do legado, a que tem
2126:     * faixafs = 0: eh esse o criterio do "Locate for faixafs = 0" do
2127:     * inserelinha e do LostFocus da Column4. Limpar a linha corrente eh,
2128:     * portanto, zerar as quatro colunas visiveis - e eh exatamente o estado em
2129:     * que InserirLinhaCursor cria uma linha nova.
2130:     *
2131:     * Composto a partir dos dois hooks, sem duplicar a lista de campos: o BO
2132:     * zera as properties (LimparDados preserva this_cOperacao, entao dopes
2133:     * continua resolvido) e BOParaForm leva isso para a linha e repinta. Como
2134:     * LimparDados tambem esvazia this_cCidchaves, a guarda de identidade do
2135:     * BOParaForm fica fora de alcance e a escrita atinge a linha CORRENTE, que
2136:     * eh a intencao aqui.
2137:     *
2138:     * cidchaves e dopes da LINHA nao sao tocados - a linha continua sendo a
2139:     * mesma, so vazia. Zerar a chave faria a linha perder identidade e o
2140:     * Encerrar a trataria como lixo a descartar.
2141:     *
2142:     * Nenhum caminho do legado chama isto: o SCX nao tem botao de limpar. O
2143:     * metodo existe como hook canonico de transferencia; NAO foi ligado a
2144:     * botao algum, porque criar um botao de limpar seria inventar superficie
2145:     * que a tela nao tem.
2146:     *
2147:     * PROTECTED EXPLICITO: FormBase declara PROTECTED PROCEDURE LimparCampos,
2148:     * e o escopo herdado nao se alarga - ver o cabecalho do FormParaBO.
2149:     *==========================================================================
2150:     PROTECTED PROCEDURE LimparCampos()
2151:         LOCAL loc_lSucesso
2152: 
2153:         loc_lSucesso = .F.
2154: 
2155:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
2156:             RETURN .F.
2157:         ENDIF
2158: 
2159:         THIS.this_oBusinessObject.LimparDados()
2160: 
2161:         loc_lSucesso = THIS.BOParaForm()
2162: 
2163:         RETURN loc_lSucesso
2164:     ENDPROC
2165: 
2166: 
2167:     *==========================================================================
2168:     * TornarControlesVisiveis - AddObject cria tudo com Visible = .F.
2169:     *
2170:     * Percorre Controls do form e dos containers. Esta tela NAO tem container
2171:     * flutuante (painel que nasce oculto e eh alternado por botao), entao nao
2172:     * ha lista de excecao a manter aqui.
2173:     *==========================================================================
2174:     PROTECTED PROCEDURE TornarControlesVisiveis()
2175:         LOCAL loc_nI, loc_nJ, loc_oControle, loc_oFilho
2176: 
2177:         FOR loc_nI = 1 TO THIS.ControlCount
2178:             loc_oControle = THIS.Controls(loc_nI)
2179: 
2180:             IF VARTYPE(loc_oControle) = "O"
2181:                 IF PEMSTATUS(loc_oControle, "Visible", 5)
2182:                     loc_oControle.Visible = .T.
2183:                 ENDIF
2184: 
2185:                 IF PEMSTATUS(loc_oControle, "ControlCount", 5)
2186:                     FOR loc_nJ = 1 TO loc_oControle.ControlCount
2187:                         loc_oFilho = loc_oControle.Controls(loc_nJ)
2188:                         IF VARTYPE(loc_oFilho) = "O" AND PEMSTATUS(loc_oFilho, "Visible", 5)
2189:                             loc_oFilho.Visible = .T.
2190:                         ENDIF
2191:                     ENDFOR
2192:                 ENDIF
2193:             ENDIF
2194:         ENDFOR
2195: 
2196:         RETURN .T.
2197:     ENDPROC
2198: 
2199: 
2200:     *==========================================================================
2201:     * AtualizarEstadoControles - hook chamado por FormBase.Init() no final
2202:     *
2203:     * Este dialogo nao tem os cinco botoes CRUD de um cadastro: o dump tem
2204:     * apenas cmdExcluir e cmdSair. O override existe para o hook da base nao
2205:     * cair no comportamento de cadastro, e redireciona para o unico ajuste que
2206:     * esta tela tem - a permissao de exclusao resolvida pelo BO.
2207:     *
2208:     * Roda DEPOIS de InicializarForm, que ja chamou AjustarBotoesPorModo. A
2209:     * repeticao eh deliberada e inofensiva (o metodo so espelha
2210:     * this_lPodeExcluir): garante o ajuste mesmo que algum caminho futuro
2211:     * chegue aqui sem ter passado por ele.
2212:     *==========================================================================
2213:     PROCEDURE AtualizarEstadoControles()
2214:         LOCAL loc_lSucesso
2215: 
2216:         loc_lSucesso = THIS.AjustarBotoesPorModo()
2217: 
2218:         *-- A grade eh o unico campo de entrada desta tela, e TornarControlesVisiveis
2219:         *-- acabou de forcar Visible = .T. em tudo: reabrir a digitacao aqui
2220:         *-- garante Grid.ReadOnly = .F. e as quatro colunas abertas mesmo que
2221:         *-- algum caminho futuro chegue a este hook sem passar por VincularGrade.
2222:         THIS.HabilitarCampos(.T.)
2223: 
2224:         RETURN loc_lSucesso
2225:     ENDPROC
2226: 
2227: 
2228:     *==========================================================================
2229:     * Destroy - libera o pai e o BO
2230:     *
2231:     * A reabilitacao do pai vem ANTES de soltar o BO: se algo falhasse ali, o
2232:     * usuario ainda ficaria com o cadastro de Operacoes utilizavel.
2233:     * DODEFAULT() eh a ULTIMA linha - FormBase.Destroy reconstroi os popups do
2234:     * menu principal, e omiti-lo faz o menu encolher visualmente.
2235:     *==========================================================================
2236:     PROCEDURE Destroy()
2237:         THIS.ReabilitarFormPai()
2238: 
2239:         THIS.this_oFormPai = .NULL.
2240: 
2241:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2242:             THIS.this_oBusinessObject = .NULL.
2243:         ENDIF
2244: 
2245:         DODEFAULT()
2246:     ENDPROC
2247: 
2248: ENDDEFINE
2249: 
2250: 
2251: *==============================================================================
2252: * TextBoxFaixaSigOpCrd_4c - celulas COM EVENTO da grade de faixas
2253: *
2254: * Transcreve os dois unicos handlers de celula do SIGOPCRD legado:
2255: *     SIGOPCRD.GradeSubN.Column2.Text1.LostFocus  -> faixafs
2256: *     SIGOPCRD.GradeSubN.Column4.Text1.LostFocus  -> multiplos
2257: *
2258: * O evento fica EMBUTIDO na classe, e nao ligado por BINDEVENT: BINDEVENT em
2259: * evento de TextBox dentro de Column nao dispara de forma confiavel no VFP9 -
2260: * eh exatamente o motivo de existir classes\TextBoxGridLookup.prg, que
2261: * documenta isso no cabecalho, e eh o padrao canonico do projeto (regra #46,
2262: * referencia FormLpr.TextBoxProdutoLpr_4c).
2263: *
2264: * A classe NAO decide nada: ela so despacha para o metodo PUBLIC do form, que
2265: * eh onde a regra do legado esta transcrita. Assim a logica fica em UM lugar,
2266: * alcancavel pelo harness, e esta classe segue valendo para as duas colunas
2267: * com a unica diferenca sendo this_cCampo.
2268: *
2269: * THISFORM aqui eh o FormSigOpCrd: a celula eh filha de Column, que eh filha
2270: * de Grid, que eh filho do form. O PEMSTATUS antes de cada chamada protege o
2271: * caso de a classe ser reaproveitada num form que nao tenha o metodo - ali o
2272: * handler vira no-op em vez de estourar "Property ... is not found".
2273: *
2274: * LostFocus NAO recebe parametro (ao contrario de KeyPress, regra #3), por
2275: * isso a assinatura eh vazia. E o form passa THIS adiante porque dentro do
2276: * evento da celula o valor digitado esta em .Value e ainda NAO chegou ao
2277: * cursor - quem valida tem de ler o CONTROLE (regra #46).
2278: *==============================================================================
2279: DEFINE CLASS TextBoxFaixaSigOpCrd_4c AS TextBox
2280:     *-- Coluna do cursor que esta celula edita: "faixafs" ou "multiplos".
2281:     *-- Definido por InstalarCelulasFaixa, no form.
2282:     this_cCampo = "faixafs"
2283: 
2284:     PROCEDURE LostFocus()
2285:         DO CASE
2286:             CASE LOWER(ALLTRIM(THIS.this_cCampo)) == "faixafs"
2287:                 IF PEMSTATUS(THISFORM, "ValidarFaixaFinal", 5)
2288:                     THISFORM.ValidarFaixaFinal(THIS)
2289:                 ENDIF
2290: 
2291:             CASE LOWER(ALLTRIM(THIS.this_cCampo)) == "multiplos"
2292:                 IF PEMSTATUS(THISFORM, "ValidarMultiplos", 5)
2293:                     THISFORM.ValidarMultiplos(THIS)
2294:                 ENDIF
2295:         ENDCASE
2296:     ENDPROC
2297: ENDDEFINE

