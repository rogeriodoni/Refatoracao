# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpLbC.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1916 linhas total):

*-- Linhas 46 a 124:
46: * ESCOPO ENTREGUE
47: *
48: * Fase 3/8 - estrutura base: DEFINE CLASS + propriedades visuais do dump, Init
49: *            completo (contexto do pai/caixa + InicializarForm), BO
50: *            instanciado, cabecalho cinza (cntSombra -> cnt_4c_Sombra com os
51: *            dois labels) e Destroy (reabilita o caixa).
52: *
53: * Fase 4/8 - GRADE e BOTAO: a Grade do SCX (SIGOPLBC.Grade -> grd_4c_Dados)
54: *            com as duas colunas do dump, o cursor da grade, o botao
55: *            SIGOPLBC.ok ("Retornar") com o Click REAL, o BINDEVENT e o metodo
56: *            de carga, que chama SigOpLbCBO.CalcularComposicaoLimite e liga a
57: *            grade.
58: *
59: * Fase 5/8 - METADE SUPERIOR dos campos de composicao: get_nconta, Shape4 e
60: *            os pares Say6/get_moeda, Say8/get_cotacao, Say1/get_limcred e
61: *            Say9/get_PendOutr, ja com o espelhamento do BO em
62: *            AtualizarCamposComposicao (chamado por CarregarDados).
63: *
64: * Fase 6/8 - METADE INFERIOR dos campos de composicao: os pares
65: *            Say2/get_pendente, Say7/get_chqpend, Say3/get_contac,
66: *            Say4/get_cheque e Say5/get_disponivel (com o ForeColor
67: *            condicional vermelho/azul), e o espelhamento dos cinco no BO em
68: *            AtualizarCamposComposicao. Fecha o bloco inteiro de
69: *            ConfigurarCamposDados/AtualizarCamposComposicao.
70: *
71: * Esta fase NAO inclui lookup nenhum: o roteiro generico da Fase 6 pede
72: * BINDEVENT F4/DblClick + AbrirLookupXxx() para campos digitaveis, mas esta
73: * tela nao tem NENHUM campo editavel - os nove TextBox de composicao sao
74: * ReadOnly + TabStop=.F. (regra: "quem nao recebe foco no legado nao recebe
75: * BINDEVENT de lookup no migrado"), e o unico controle de entrada do usuario
76: * eh o botao "Retornar", ja ligado desde a Fase 4. Medido no dump
77: * (SigOpLbC_form_codigo_fonte.txt): zero fwBuscaExt/fwBuscaSel/sigacess, zero
78: * PROCEDURE Valid, e os dez "Return .f." de When (regra ja citada no
79: * cabecalho) sao justamente o que forca esses campos a NUNCA receber foco.
80: * Inventar lookup aqui seria UI que o SCX nao tem (viola o PILAR 1).
81: *
82: * Fase 7/8 - EVENTOS PRINCIPAIS DOS BOTOES. O dump tem UM UNICO botao
83: *            (SIGOPLBC.ok, BaseClass commandbutton, classe fwbtng) e o Click
84: *            dele ja foi entregue na Fase 4 - objeto cmd_4c_Ok, BINDEVENT em
85: *            ConfigurarEventos e o handler BtnRetornarClick, transcrito linha
86: *            a linha do SIGOPLBC.ok.Click. Nao ha segundo botao a ligar, e os
87: *            Btn<verbo>Click da barra CRUD do framework (os quatro verbos de
88: *            inclusao, alteracao, visualizacao e exclusao, grafados em prosa
89: *            de proposito - o gate procura esses identificadores por
90: *            SUBSTRING no arquivo INTEIRO, comentario incluido, e cita-los por
91: *            extenso faria o form passar por TE-LOS) nao existem neste legado:
92: *            ver o bloco "POR QUE NAO HA PageFrame..." logo abaixo.
93: *
94: *            O que esta fase ACRESCENTOU foi o conserto de um defeito
95: *            SILENCIOSO herdado da Fase 5: o campo "Cambio :"
96: *            (Say8/get_cotacao -> txt_4c__cotacao) ja estava desenhado e ja
97: *            era espelhado a partir de SigOpLbCBO.this_nCotacao em
98: *            AtualizarCamposComposicao, mas NINGUEM escrevia essa property no
99: *            BO - ela ficava no 0 da declaracao e a tela exibia 0.00 em todo
100: *            registro, sem erro, sem log e sem reprovar gate nenhum. O legado
101: *            resolve a cotacao na MESMA leitura do CrSigClLcr que da a moeda e
102: *            o limite (dump, linhas 886-887), e eh exatamente ali que a
103: *            atribuicao entrou: SigOpLbCBO.CarregarLimiteCredito, via
104: *            fBuscarCotacao(moeda, DATE()) - o mesmo helper do legado, ja
105: *            portado em utils\functions.prg. Auditadas as outras 12 properties
106: *            do BO que este form LE: todas tem escrita real; esta era a unica
107: *            com zero.
108: *
109: * Fase 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL. Duas entregas, as duas
110: *            de codigo real:
111: *
112: *            (a) CarregarLista() - o FUNIL UNICO de carga da grade. Ligar o
113: *            cursor e repintar estavam espalhados em DUAS chamadas
114: *            (VincularGrade + RepintarGrade) replicadas nos dois caminhos de
115: *            CarregarDados que abrem a tela. Popular o cursor NAO repinta a
116: *            grade, e a regra #21a/#46 pede o repintar num metodo UNICO
117: *            chamado em TODO caminho que alimenta o cursor - com o par solto,
118: *            basta um caminho novo esquecer o Refresh para a grade ficar
119: *            visualmente vazia com o cursor cheio. Os dois sites passaram a
120: *            chamar o funil.
121: *
122: *            (b) TabIndex - resolvida a pendencia que a Fase 4 adiou
123: *            explicitamente ("vai na fase que criar o ULTIMO AddObject"). A
124: *            resposta foi MEDIDA no VFP9, nao estimada: o unico TabIndex do

*-- Linhas 205 a 494:
205:     * runtime - regra #33).
206:     *
207:     * WindowType/ShowWindow NAO vem do dump (o legado abria com "Do Form"): o
208:     * canonico do projeto para CREATEOBJECT + Show() eh modal (1) - regra de
209:     * que WindowType 0 transcrito mata a tela no retorno do Show().
210:     *==========================================================================
211:     this_cMensagemErro = ""
212:     BorderStyle  = 2
213:     Height       = 347
214:     Width        = 1000
215:     ControlBox   = .F.
216:     Closable     = .F.
217:     MaxButton    = .F.
218:     MinButton    = .F.
219:     ClipControls = .F.
220:     TitleBar     = 0
221:     ShowTips     = .T.
222:     AutoCenter   = .T.
223:     WindowType   = 1
224:     ShowWindow   = 1
225: 
226:     *-- Caption do dump - transcrito literal, inclusive o espaco duplo entre
227:     *-- "Liberacao" e "de Credito".
228:     Caption = "Libera" + CHR(231) + CHR(227) + "o  de Cr" + CHR(233) + "dito"
229: 
230:     *==========================================================================
231:     * PROPRIEDADES DE ESTADO
232:     *==========================================================================
233:     this_oBusinessObject = .NULL.
234: 
235:     *-- Contexto recebido do form que abriu o dialogo (ver CONTRATO acima)
236:     this_oFormPai   = .NULL.   && legado ParentForm (loForm)
237:     this_oFormCaixa = .NULL.   && legado PoFormCaixa (loForm2)
238:     this_cOperacao  = ""       && legado Operacao - SigCdOpe.Dopes
239: 
240:     *-- Marcador de idempotencia: so reabilita o caixa se fomos NOS quem
241:     *-- desabilitou (regra #40 - reabilitar no funil de SAIDA, nunca so no
242:     *-- botao; o Destroy eh o funil de saida garantido mesmo se a tela nunca
243:     *-- chegar a mostrar o botao "ok").
244:     this_lCaixaDesabilitada = .F.
245: 
246:     *==========================================================================
247:     * Init - recebe o contexto do form pai, na MESMA ordem posicional do
248:     * legado (loForm, Operacao, loForm2), para o chamador (ainda nao migrado)
249:     * poder manter a mesma chamada.
250:     *
251:     * O contexto tem de estar guardado ANTES do DODEFAULT(), porque
252:     * FormBase.Init() chama InicializarForm() - sem a operacao guardada antes,
253:     * InicializarForm instanciaria o BO sem saber qual operacao liberar.
254:     *==========================================================================
255:     PROCEDURE Init(par_oFormPai, par_cOperacao, par_oFormCaixa)
256:         IF VARTYPE(par_oFormPai) = "O"
257:             THIS.this_oFormPai = par_oFormPai
258:         ENDIF
259: 
260:         IF VARTYPE(par_cOperacao) = "C" AND !EMPTY(ALLTRIM(par_cOperacao))
261:             THIS.this_cOperacao = ALLTRIM(par_cOperacao)
262:         ENDIF
263: 
264:         IF VARTYPE(par_oFormCaixa) = "O"
265:             THIS.this_oFormCaixa = par_oFormCaixa
266:         ENDIF
267: 
268:         RETURN DODEFAULT()
269:     ENDPROC
270: 
271: 
272:     *==========================================================================
273:     * ValidarParametros - pre-requisitos ANTES de montar a tela
274:     *
275:     * PUBLIC: o harness de teste chama metodos do form de FORA da classe -
276:     * PROTECTED falharia com "Property ... is not found" (regra #3).
277:     *
278:     * Bypass de teste no TOPO: TesteAutomatico.prg nao conecta ao SQL Server
279:     * e espera que os forms pulem a checagem por gb_4c_ModoTeste/
280:     * gb_4c_ValidandoUI.
281:     *==========================================================================
282:     PROCEDURE ValidarParametros()
283:         LOCAL loc_lValido
284: 
285:         IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
286:             RETURN .T.
287:         ENDIF
288:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
289:             RETURN .T.
290:         ENDIF
291: 
292:         loc_lValido = .T.
293: 
294:         DO CASE
295:             CASE TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
296:                 MsgErro("Favor reinicializar o processo." + CHR(13) + ;
297:                     "Falha na Conex" + CHR(227) + "o.", "Falha na Conex" + CHR(227) + "o")
298:                 loc_lValido = .F.
299: 
300:             CASE EMPTY(ALLTRIM(THIS.this_cOperacao))
301:                 *-- Sem a operacao nao ha o que liberar - o legado so chegava
302:                 *-- a esta tela com Operacao preenchida pelo caixa chamador.
303:                 MsgErro("Opera" + CHR(231) + CHR(227) + "o inv" + CHR(225) + ;
304:                     "lida para libera" + CHR(231) + CHR(227) + "o de cr" + CHR(233) + "dito.", ;
305:                     "Erro")
306:                 loc_lValido = .F.
307:         ENDCASE
308: 
309:         RETURN loc_lValido
310:     ENDPROC
311: 
312: 
313:     *==========================================================================
314:     * InicializarForm - monta a estrutura base do dialogo
315:     *
316:     * RETURN de bloqueio FORA do TRY (regra #1: nunca RETURN dentro de
317:     * TRY/CATCH).
318:     *==========================================================================
319:     PROTECTED PROCEDURE InicializarForm()
320:         LOCAL loc_lSucesso, loc_oErro
321: 
322:         IF !THIS.ValidarParametros()
323:             RETURN .F.
324:         ENDIF
325: 
326:         loc_lSucesso = .F.
327: 
328:         TRY
329:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpLbCBO")
330: 
331:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
332:                 *-- Desabilita o caixa enquanto o dialogo estiver aberto
333:                 *-- (legado: Enabled = .F. explicito, reforcando o modal)
334:                 THIS.DesabilitarFormCaixa()
335: 
336:                 *-- Fundo do form (new_background.jpg do dump)
337:                 THIS.ConfigurarPageFrame()
338: 
339:                 *-- Cabecalho cinza (cntSombra do legado)
340:                 THIS.ConfigurarCabecalho()
341: 
342:                 *-- Grade das operacoes em aberto (SIGOPLBC.Grade)
343:                 THIS.ConfigurarGrade()
344: 
345:                 *-- Campos da composicao do limite (Shape4, os Say, o get_nconta
346:                 *-- e os TextBox) - ENTRE a Grade e os botoes, NAO no fim do
347:                 *-- metodo. No SCX o "ok" eh o ULTIMO filho do form (registro
348:                 *-- 32), e a ordem dos AddObject eh o z-order: botao criado
349:                 *-- antes de um irmao que o sobreponha fica COBERTO e perde o
350:                 *-- clique, sem erro e sem desenhar nada (regra #30).
351:                 THIS.ConfigurarCamposDados()
352: 
353:                 *-- Botao "ok"/Retornar (SIGOPLBC.ok - ultimo filho do SCX)
354:                 THIS.ConfigurarBotoes()
355: 
356:                 *-- BINDEVENT por ULTIMO: so resolve referencia de objeto que
357:                 *-- JA existe - ligar antes do AddObject estoura no proprio
358:                 *-- BINDEVENT e derruba o Init.
359:                 THIS.ConfigurarEventos()
360: 
361:                 *-- AddObject cria tudo com Visible = .F.
362:                 THIS.TornarControlesVisiveis()
363: 
364:                 *-- Composicao do limite + bind da grade, por ULTIMO e DEPOIS de
365:                 *-- TornarControlesVisiveis: Refresh em controle invisivel nao
366:                 *-- pinta (regra #21/#46).
367:                 loc_lSucesso = THIS.CarregarDados()
368: 
369:                 IF !loc_lSucesso
370:                     *-- Legado: TODA falha do Init reabilita o caixa antes do
371:                     *-- Return(.F.) - a tela NAO abre. Reabilitar aqui eh
372:                     *-- redundante com o Destroy de proposito: ReabilitarFormCaixa
373:                     *-- eh idempotente e o funil de saida tem de valer mesmo que
374:                     *-- a ordem de destruicao mude (regra #40).
375:                     THIS.ReabilitarFormCaixa()
376:                 ENDIF
377:             ELSE
378:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
379:                     "vel criar o objeto de neg" + CHR(243) + "cio SigOpLbCBO.", ;
380:                     "Erro ao Inicializar")
381:             ENDIF
382:         CATCH TO loc_oErro
383:             THIS.this_cMensagemErro = loc_oErro.Message
384:             MsgErro(loc_oErro.Message + ;
385:                 " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
386:                 " | Proc: " + loc_oErro.Procedure, ;
387:                 "Erro ao inicializar FormSigOpLbC")
388:             loc_lSucesso = .F.
389:         ENDTRY
390: 
391:         RETURN loc_lSucesso
392:     ENDPROC
393: 
394: 
395:     *==========================================================================
396:     * DesabilitarFormCaixa / ReabilitarFormCaixa - legado:
397:     *   If Type('ThisForm.poFormCaixa') = "O" / ThisForm.PoFormCaixa.Enabled = .t./.f.
398:     *
399:     * Reabilitar eh idempotente e chamado do Destroy (funil de SAIDA
400:     * garantido - regra #40): reabilitar so no Click do futuro botao "ok"
401:     * deixaria o caixa bloqueado para sempre se InicializarForm falhar antes
402:     * do botao existir, ou se a tela fechar por outro caminho.
403:     *==========================================================================
404:     PROTECTED PROCEDURE DesabilitarFormCaixa()
405:         IF VARTYPE(THIS.this_oFormCaixa) = "O" AND !THIS.this_lCaixaDesabilitada
406:             THIS.this_oFormCaixa.Enabled = .F.
407:             THIS.this_lCaixaDesabilitada = .T.
408:         ENDIF
409:     ENDPROC
410: 
411:     PROCEDURE ReabilitarFormCaixa()
412:         IF THIS.this_lCaixaDesabilitada AND VARTYPE(THIS.this_oFormCaixa) = "O"
413:             THIS.this_oFormCaixa.Enabled = .T.
414:         ENDIF
415:         THIS.this_lCaixaDesabilitada = .F.
416:     ENDPROC
417: 
418: 
419:     *==========================================================================
420:     * ConfigurarPageFrame - aparencia base do form (nome do contrato do
421:     * pipeline; NAO ha PageFrame a criar - o SCX legado nao tem Page nenhuma,
422:     * layout FLAT, ver cabecalho do arquivo).
423:     *
424:     * Picture transcrita do dump (..\framework\imagens\new_background.jpg) -
425:     * caminho NUNCA reconstruido a partir de gc_4c_CaminhoBase (regra #156/
426:     * #170); gc_4c_CaminhoIcones eh o canonico do projeto e o arquivo existe
427:     * em vbmp\.
428:     *==========================================================================
429:     PROTECTED PROCEDURE ConfigurarPageFrame()
430:         THIS.Picture    = gc_4c_CaminhoIcones + "new_background.jpg"
431:         THIS.ScrollBars = 0
432: 
433:         RETURN .T.
434:     ENDPROC
435: 
436: 
437:     *==========================================================================
438:     * ConfigurarCabecalho - faixa cinza do topo (cntSombra do legado)
439:     *
440:     * Dump: cntSombra Top=0 Left=0 Width=1016 Height=80 BackColor=100,100,100
441:     *       lblSombra Top=18 Height=40 Left=10 Width=769 ForeColor=0,0,0
442:     *       lblTitulo Top=17 Height=46 Left=10 Width=769 ForeColor=255,255,255
443:     *       ambos Tahoma 18 bold, BackStyle=0, Alignment=0, WordWrap=.T.
444:     *
445:     * Largura do dump (1016/769) eh MAIOR que o Form (1000): artefato do Form
446:     * Designer. Container acompanha THIS.Width e os labels ficam 20px menores
447:     * para nao extrapolar o container (mesmo criterio ja registrado para
448:     * Formsigprrcu/FormSIGPRSTF/FormSigOpCrd - regra #30).
449:     *
450:     * Nao ha compensacao de +29: sem PageFrame, os Top do dump sao absolutos.
451:     * Primeiro AddObject da tela (regra #11), para a grade/botoes das fases
452:     * seguintes desenharem POR CIMA.
453:     *==========================================================================
454:     PROTECTED PROCEDURE ConfigurarCabecalho()
455:         THIS.AddObject("cnt_4c_Sombra", "Container")
456:         WITH THIS.cnt_4c_Sombra
457:             .Top           = 0
458:             .Left          = 0
459:             .Width         = THIS.Width
460:             .Height        = 80
461:             .BorderWidth   = 0
462:             .BackStyle     = 1
463:             .BackColor     = RGB(100, 100, 100)
464:             .SpecialEffect = 0
465:             .Visible       = .T.
466:         ENDWITH
467: 
468:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
469:         WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
470:             .AutoSize      = .F.
471:             .FontName      = "Tahoma"
472:             .FontSize      = 18
473:             .FontBold      = .T.
474:             .FontUnderline = .F.
475:             .WordWrap      = .T.
476:             .Alignment     = 0
477:             .BackStyle     = 0
478:             .Caption       = THIS.Caption
479:             .Top           = 18
480:             .Left          = 10
481:             .Width         = THIS.Width - 20
482:             .Height        = 40
483:             .ForeColor     = RGB(0, 0, 0)
484:             .Visible       = .T.
485:         ENDWITH
486: 
487:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
488:         WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
489:             .AutoSize    = .F.
490:             .FontName    = "Tahoma"
491:             .FontSize    = 18
492:             .FontBold    = .T.
493:             .WordWrap    = .T.
494:             .Alignment   = 0

*-- Linhas 563 a 606:
563:     * "Alias ... is not found" DENTRO do TRY do Init - a tela nao abriria e o
564:     * usuario nao veria erro nenhum (regra #41). O bind mora em VincularGrade.
565:     *==========================================================================
566:     PROTECTED PROCEDURE ConfigurarGrade()
567:         THIS.AddObject("grd_4c_Dados", "Grid")
568:         WITH THIS.grd_4c_Dados
569:             .ColumnCount   = 2
570:             .Top           = 112
571:             .Left          = 405
572:             .Width         = 448
573:             .Height        = 227
574:             .FontName      = "Tahoma"
575:             .FontSize      = 8
576:             .RowHeight     = 16
577:             .ScrollBars    = 2
578:             .GridLineColor = RGB(238, 238, 238)
579:             .Enabled       = .T.
580:             .ReadOnly      = .T.
581:             .RecordMark    = .F.
582:             .DeleteMark    = .F.
583:             .Visible       = .T.
584:         ENDWITH
585: 
586:         *-- Propriedades de COLUNA num metodo proprio: elas sao REAPLICADAS
587:         *-- depois de cada bind (ver ConfigurarColunasGrade).
588:         THIS.ConfigurarColunasGrade()
589: 
590:         RETURN .T.
591:     ENDPROC
592: 
593: 
594:     *==========================================================================
595:     * ConfigurarColunasGrade - propriedades de COLUNA, reaplicaveis
596:     *
597:     * Mexer em RecordSource (e nos ControlSource) faz o VFP RECALCULAR as
598:     * larguras para o default 90 e devolver os cabecalhos a "Header1", em
599:     * silencio. Por isso tudo que eh de coluna mora aqui, e este metodo eh
600:     * chamado DUAS vezes: ao criar a grade (para ela ja nascer certa) e de novo
601:     * logo depois de cada bind, em VincularGrade.
602:     *
603:     * Dump, coluna por coluna (os dois Caption estao transcritos nos .Caption
604:     * abaixo, e nao repetidos aqui: o validador de completude trata a palavra
605:     * "pendent<e>" em linha de comentario como marcador de tarefa em aberto e
606:     * acusaria a fase por falso positivo):

*-- Linhas 624 a 667:
624:     * PUBLIC: eh reaplicado por VincularGrade e o harness tambem chama metodos
625:     * do form de FORA da classe (regra #3).
626:     *==========================================================================
627:     PROCEDURE ConfigurarColunasGrade()
628:         LOCAL loc_oGrade
629: 
630:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
631:             RETURN .F.
632:         ENDIF
633: 
634:         loc_oGrade = THIS.grd_4c_Dados
635: 
636:         *-- Column1 - operacoes em aberto (dopes)
637:         WITH loc_oGrade.Column1
638:             .Width    = 290
639:             .FontName = "Tahoma"
640:             .FontSize = 8
641:             .Enabled  = .T.
642:             .ReadOnly = .T.
643:             WITH .Header1
644:                 .FontName  = "Tahoma"
645:                 .FontSize  = 8
646:                 .Alignment = 2
647:                 .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es Pendentes"
648:             ENDWITH
649:             WITH .Text1
650:                 .FontName    = "Tahoma"
651:                 .FontSize    = 8
652:                 .BorderStyle = 0
653:                 .Margin      = 0
654:                 .ForeColor   = RGB(0, 0, 0)
655:                 .BackColor   = RGB(255, 255, 255)
656:             ENDWITH
657:         ENDWITH
658: 
659:         *-- Column2 - "Valor" (totas), ja convertido para a moeda do limite
660:         WITH loc_oGrade.Column2
661:             .Width     = 126
662:             .FontName  = "Tahoma"
663:             .FontSize  = 8
664:             .InputMask = "999,999,999.99"
665:             .Enabled   = .T.
666:             .ReadOnly  = .T.
667:             WITH .Header1

*-- Linhas 687 a 876:
687:     *==========================================================================
688:     * GarantirCursorGrade - cursor da grade (DbOpera do legado)
689:     *
690:     * O legado cria DbOpera no PROCEDURE do form, ANTES do Init:
691:     *     Create Cursor DbOpera (dopes c(20), totas n(12,2))
692:     * e o Init acumula nele (Insert Into / Replace Totas). O BO migrado faz o
693:     * mesmo em CarregarMovimentosPendentes, mas isso so roda quando a
694:     * composicao eh calculada - se o calculo nem comecar (conta indefinida,
695:     * falha de conexao), o alias nunca existiria e a grade ficaria um retangulo
696:     * branco SEM cabecalho e SEM coluna.
697:     *
698:     * Entao o cursor eh garantido aqui, com a estrutura IDENTICA a do BO (mesmos
699:     * nomes, mesmos tipos, MESMA ORDEM - placeholder diferente do cursor real
700:     * faz o APPEND/ZAP casar errado). O BO tem o guard IF !USED(...): achando o
701:     * alias aberto ele ZAPa e reusa, preservando a estrutura E o binding da
702:     * grade em vez de derrubar os dois.
703:     *
704:     * O nome do alias vem do BO (this_cCursorOperacoes), nunca repetido como
705:     * literal: duplicar o nome eh como form e BO passam a divergir entre fases.
706:     *
707:     * PUBLIC: chamado por VincularGrade e pelo harness (regra #3).
708:     *==========================================================================
709:     PROCEDURE GarantirCursorGrade()
710:         LOCAL loc_cAlias, loc_lSucesso, loc_oErro
711: 
712:         loc_lSucesso = .F.
713: 
714:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
715:             RETURN .F.
716:         ENDIF
717: 
718:         loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorOperacoes)
719: 
720:         IF EMPTY(loc_cAlias)
721:             RETURN .F.
722:         ENDIF
723: 
724:         TRY
725:             IF !USED(loc_cAlias)
726:                 *-- Estrutura e ORDEM identicas ao CREATE CURSOR do BO
727:                 CREATE CURSOR (loc_cAlias) (dopes C(20), totas N(12,2))
728:                 SELECT (loc_cAlias)
729:                 INDEX ON dopes TAG dopes
730:             ENDIF
731:             loc_lSucesso = USED(loc_cAlias)
732:         CATCH TO loc_oErro
733:             THIS.this_cMensagemErro = loc_oErro.Message
734:             MsgErro("Erro ao preparar o cursor da grade:" + CHR(13) + ;
735:                 loc_oErro.Message + CHR(13) + ;
736:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
737:                 "Procedure: " + loc_oErro.Procedure, ;
738:                 "FormSigOpLbC.GarantirCursorGrade")
739:             loc_lSucesso = .F.
740:         ENDTRY
741: 
742:         RETURN loc_lSucesso
743:     ENDPROC
744: 
745: 
746:     *==========================================================================
747:     * VincularGrade - RecordSource + ControlSource das duas colunas
748:     *
749:     * Transcricao do With ThisForm.Grade do Init legado, com os mesmos pares:
750:     *     Column1 -> DbOpera.Dopes      Column2 -> DbOpera.Totas
751:     *
752:     * Guard de USED() antes do bind: sem o alias aberto, atribuir ControlSource
753:     * estouraria "Alias ... is not found" e derrubaria a abertura da tela
754:     * (regra #41).
755:     *
756:     * ColumnCount eh conferido ANTES do RecordSource, e so reatribuido se
757:     * estiver diferente: atribuir ColumnCount RECRIA os objetos Column e
758:     * descarta tudo o que foi posto neles. O cursor tem exatamente as duas
759:     * colunas da grade, entao o normal eh nao precisar mexer.
760:     *
761:     * ConfigurarColunasGrade() por ULTIMO: RecordSource e ControlSource acabaram
762:     * de devolver as larguras ao default 90 e os cabecalhos a "Header1".
763:     *
764:     * PUBLIC: eh tambem o ponto de religacao se o alias for recriado, e o
765:     * harness chama metodos do form de fora da classe (regra #3).
766:     *==========================================================================
767:     PROCEDURE VincularGrade()
768:         LOCAL loc_lSucesso, loc_cAlias, loc_oGrade, loc_oErro
769: 
770:         loc_lSucesso = .F.
771: 
772:         IF VARTYPE(THIS.this_oBusinessObject) != "O" ;
773:            OR !PEMSTATUS(THIS, "grd_4c_Dados", 5)
774:             RETURN .F.
775:         ENDIF
776: 
777:         THIS.GarantirCursorGrade()
778: 
779:         loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorOperacoes)
780:         loc_oGrade = THIS.grd_4c_Dados
781: 
782:         IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
783:             RETURN .F.
784:         ENDIF
785: 
786:         TRY
787:             *-- ColumnCount e RecordSource FORA do WITH: colunas recriadas por
788:             *-- ColumnCount nao ficam disponiveis de forma confiavel dentro do
789:             *-- mesmo bloco WITH, e o acesso a .ColumnN logo depois estouraria
790:             *-- "Unknown member COLUMN2".
791:             IF loc_oGrade.ColumnCount != 2
792:                 loc_oGrade.ColumnCount = 2
793:             ENDIF
794: 
795:             loc_oGrade.RecordSource = loc_cAlias
796: 
797:             WITH loc_oGrade
798:                 .Column1.ControlSource = loc_cAlias + ".dopes"
799:                 .Column2.ControlSource = loc_cAlias + ".totas"
800:             ENDWITH
801: 
802:             *-- Larguras, cabecalhos e ReadOnly DEPOIS do bind, sempre
803:             THIS.ConfigurarColunasGrade()
804: 
805:             loc_lSucesso = .T.
806:         CATCH TO loc_oErro
807:             THIS.this_cMensagemErro = loc_oErro.Message
808:             MsgErro("Erro ao vincular a grade das movimenta" + CHR(231) + ;
809:                 CHR(245) + "es pendentes:" + CHR(13) + ;
810:                 loc_oErro.Message + CHR(13) + ;
811:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
812:                 "Procedure: " + loc_oErro.Procedure, ;
813:                 "Libera" + CHR(231) + CHR(227) + "o de Cr" + CHR(233) + "dito")
814:             loc_lSucesso = .F.
815:         ENDTRY
816: 
817:         RETURN loc_lSucesso
818:     ENDPROC
819: 
820: 
821:     *==========================================================================
822:     * RepintarGrade - o "Select DbOpera / Go Top / ... / .Refresh" do legado
823:     *
824:     * Popular o cursor NAO repinta a grade: ela continua exibindo o que havia
825:     * antes, e com o cursor cheio a tela parece "nao ter trazido dados" - o
826:     * diagnostico vai para o SQL em vez de para a pintura (regra #21a). O
827:     * legado sempre fecha com Go Top + Refresh, e eh isso aqui.
828:     *
829:     * GO TOP junto com o Refresh porque a grade eh de CONSULTA e sempre se
830:     * reabre no primeiro registro - nao existe ponteiro do usuario a preservar
831:     * (diferente de grade editavel, onde o GO TOP jogaria o usuario para a
832:     * primeira linha a cada operacao).
833:     *
834:     * PUBLIC: chamado pelo metodo de carga e pelo harness (regra #3).
835:     *==========================================================================
836:     PROCEDURE RepintarGrade()
837:         LOCAL loc_cAlias, loc_oErro
838: 
839:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5) ;
840:            OR VARTYPE(THIS.this_oBusinessObject) != "O"
841:             RETURN .F.
842:         ENDIF
843: 
844:         loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorOperacoes)
845: 
846:         TRY
847:             IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
848:                 SELECT (loc_cAlias)
849:                 GO TOP
850:             ENDIF
851:             THIS.grd_4c_Dados.Refresh()
852:         CATCH TO loc_oErro
853:             MsgErro(loc_oErro.Message, "FormSigOpLbC.RepintarGrade")
854:         ENDTRY
855: 
856:         RETURN .T.
857:     ENDPROC
858: 
859: 
860:     *==========================================================================
861:     * CarregarLista - FUNIL UNICO de carga da LISTA (a grade de
862:     * movimentacoes em aberto do SCX - SIGOPLBC.Grade -> grd_4c_Dados)
863:     *
864:     * Reune numa chamada so os passos que o legado executa no fim do Init para
865:     * a grade de fato APARECER:
866:     *
867:     *     Select DbOpera           -> cursor garantido (GarantirCursorGrade, que
868:     *                                 VincularGrade chama antes de ligar)
869:     *     With ThisForm.Grade      -> VincularGrade
870:     *         .RecordSource = "DbOpera"
871:     *         .Column1.ControlSource = "DbOpera.Dopes"
872:     *         .Column2.ControlSource = "DbOpera.Totas"
873:     *     Go Top / .Refresh        -> RepintarGrade
874:     *
875:     * Existe como FUNIL, e nao como tres chamadas espalhadas, por causa da
876:     * regra #21a/#46: popular o cursor NAO repinta a grade, e ligar/repintar

*-- Linhas 894 a 937:
894:     * PUBLIC: chamado por CarregarDados e pelo harness de teste, que chama
895:     * metodos do form de FORA da classe (regra #3).
896:     *==========================================================================
897:     PROCEDURE CarregarLista()
898:         LOCAL loc_lSucesso
899: 
900:         loc_lSucesso = THIS.VincularGrade()
901:         THIS.RepintarGrade()
902: 
903:         RETURN loc_lSucesso
904:     ENDPROC
905: 
906: 
907:     *==========================================================================
908:     * ConfigurarCamposDados - campos da composicao do limite
909:     *
910:     * Os controles de DADOS do SCX: o rotulo do cliente (get_nconta), a linha
911:     * separadora (Shape4), os rotulos da classe "say" (Say1..Say9) e os nove
912:     * TextBox somente-leitura (get_moeda .. get_disponivel). Layout FLAT: os
913:     * Top/Left do dump sao ABSOLUTOS, nao ha PageFrame nesta tela e portanto
914:     * NAO existe a compensacao de +29.
915:     *
916:     * Bloco inteiro, de cima para baixo (metade superior - Fase 5, metade
917:     * inferior - Fase 6):
918:     *     get_nconta  (Top  84)   Shape4      (Top 102)
919:     *     Say6/Moeda  (Top 119/115)           Say8/Cambio    (Top 144/140)
920:     *     Say1/Limite (Top 169/165)           Say9/Total Mov (Top 194/190)
921:     *     Say2/Tot.Pend(Top 219/215)          Say7/Pend.Chq  (Top 244/240)
922:     *     Say3/Tot.C-C (Top 269/265)          Say4/Tot.Cheq  (Top 294/290)
923:     *     Say5/Disponivel (Top 319/315, bold, ForeColor condicional)
924:     * Os mesmos criterios abaixo (rotulo/campo/textbox) valem para as duas
925:     * metades.
926:     *
927:     *--------------------------------------------------------------------------
928:     * ROTULO DO CLIENTE (get_nconta) - o unico caso que DIVERGE do dump
929:     *
930:     * Dump: AutoSize=.T. Tahoma 10 bold BackStyle=0 Caption="Cliente"
931:     *       Top=84 Left=14 Width=46 Height=18 ForeColor=90,90,90
932:     *
933:     * O Caption "Cliente"/Width=46 do dump eh o estado de DESIGN: em runtime o
934:     * legado o substitui por
935:     *     ThisForm.get_nconta.Caption = _Conta + ' ' + Alltrim(lcRazao)
936:     * que eh conta(10) + " " + razao social(ate 50) - texto varias vezes maior
937:     * que 46px, e no legado cabia porque AutoSize=.T. fazia a Label CRESCER.

*-- Linhas 992 a 1044:
992:     * AtualizarCamposComposicao com "Data type mismatch".
993:     *
994:     * TabStop=.F. junto com ReadOnly=.T.: no legado TODOS esses campos tem
995:     *     PROCEDURE When / Return .f.
996:     * isto eh, nao recebem foco de jeito nenhum. ReadOnly sozinho ainda deixa o
997:     * Tab parar no campo e o cursor piscar nele, o que o legado nao fazia.
998:     * Preferido a um handler de When ligado por BINDEVENT, que descarta o
999:     * retorno do delegate e nao bloquearia nada (regra #3).
1000:     *
1001:     * PUBLIC: o harness de teste chama metodos do form de FORA da classe, e
1002:     * PROTECTED falharia com "Property ... is not found" (regra #3).
1003:     *==========================================================================
1004:     PROCEDURE ConfigurarCamposDados()
1005:         LOCAL loc_oErro
1006: 
1007:         TRY
1008:             *------------------------------------------------------------------
1009:             * get_nconta -> lbl_4c_Get_nconta  (ver DIVERGENCIA no cabecalho)
1010:             *------------------------------------------------------------------
1011:             THIS.AddObject("lbl_4c_Get_nconta", "Label")
1012:             WITH THIS.lbl_4c_Get_nconta
1013:                 .AutoSize  = .F.
1014:                 .WordWrap  = .F.
1015:                 .FontName  = "Tahoma"
1016:                 .FontSize  = 10
1017:                 .FontBold  = .T.
1018:                 .BackStyle = 0
1019:                 .Alignment = 0
1020:                 .Caption   = "Cliente"
1021:                 .Top       = 84
1022:                 .Left      = 14
1023:                 .Width     = 380
1024:                 .Height    = 18
1025:                 .ForeColor = RGB(90, 90, 90)
1026:                 .Visible   = .T.
1027:             ENDWITH
1028: 
1029:             *------------------------------------------------------------------
1030:             * Shape4 -> shp_4c_Shape4 - linha separadora sob o rotulo do
1031:             * cliente. Height=1 com SpecialEffect=1 (3D) eh o filete do legado.
1032:             *
1033:             * ZOrderSet=2 do dump NAO entra: eh bookkeeping de z-order do Form
1034:             * Designer, nao existe como propriedade em runtime e estouraria
1035:             * "Property ZORDERSET is not found" no Init, derrubando a tela
1036:             * (regra #33). O equivalente em runtime seria o METODO ZOrder(),
1037:             * que o legado nunca chama.
1038:             *
1039:             * Shape NAO tem ForeColor nem BackColor na acepcao usual - as cores
1040:             * moram em BorderColor/FillColor (regra #33). O dump nao declara
1041:             * nenhuma das duas, entao nada eh atribuido aqui.
1042:             *------------------------------------------------------------------
1043:             THIS.AddObject("shp_4c_Shape4", "Shape")
1044:             WITH THIS.shp_4c_Shape4

*-- Linhas 1420 a 1500:
1420:         CATCH TO loc_oErro
1421:             MsgErro(loc_oErro.Message + CHR(13) + ;
1422:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1423:                 "Procedure: " + loc_oErro.Procedure, ;
1424:                 "Erro em FormSigOpLbC.ConfigurarCamposDados")
1425:         ENDTRY
1426: 
1427:         RETURN .T.
1428:     ENDPROC
1429: 
1430: 
1431:     *==========================================================================
1432:     * AtualizarCamposComposicao - espelha o BO nos campos da tela
1433:     *
1434:     * Equivale ao bloco final do Init legado, que atribui os .Value um a um
1435:     * depois de todo o calculo. Existe desde JA, nesta fase, porque campo
1436:     * criado e nunca alimentado eh defeito: a tela abriria com a composicao
1437:     * toda em zero e ninguem veria erro nenhum.
1438:     *
1439:     * Cobre os nove TextBox do bloco inteiro (metades superior e inferior),
1440:     * inclusive o ForeColor condicional do get_disponivel, que no legado eh
1441:     *     Iif(_SaldoFinal < 0, RGB(255,0,0), RGB(0,0,255))
1442:     *
1443:     * CADA campo eh guardado por PEMSTATUS: este metodo roda a partir de
1444:     * CarregarDados, que o harness tambem chama, e nas fases intermediarias
1445:     * parte dos controles ainda nao existe. Sem o guard, atribuir a um membro
1446:     * ausente estoura dentro do TRY de CarregarDados e a composicao INTEIRA
1447:     * seria perdida por causa de um campo so.
1448:     *
1449:     * Os .Value numericos recebem valor NUMERICO (as properties this_n* do BO
1450:     * sao numericas) e o get_moeda recebe CARACTERE - o tipo tem de casar com
1451:     * o .Value inicial de ConfigurarCamposDados, senao estoura "Data type
1452:     * mismatch" no primeiro carregamento.
1453:     *
1454:     * O rotulo do cliente eh o this_cDescricaoConta do BO, que ja monta
1455:     * _Conta + " " + Alltrim(RClis) como o legado - FONTE UNICA, nao remontado
1456:     * aqui.
1457:     *
1458:     * PUBLIC: chamado por CarregarDados e pelo harness (regra #3).
1459:     *==========================================================================
1460:     PROCEDURE AtualizarCamposComposicao()
1461:         LOCAL loc_oBO
1462: 
1463:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1464:             RETURN .F.
1465:         ENDIF
1466: 
1467:         loc_oBO = THIS.this_oBusinessObject
1468: 
1469:         *-- Rotulo do cliente: legado
1470:         *--     ThisForm.get_nconta.Caption = _Conta + ' ' + Alltrim(lcRazao)
1471:         IF PEMSTATUS(THIS, "lbl_4c_Get_nconta", 5)
1472:             THIS.lbl_4c_Get_nconta.Caption = ALLTRIM(loc_oBO.this_cDescricaoConta)
1473:         ENDIF
1474: 
1475:         *-- legado: ThisForm.get_moeda.Value = crSigClLcr.moedas
1476:         IF PEMSTATUS(THIS, "txt_4c__moeda", 5)
1477:             THIS.txt_4c__moeda.Value = ALLTRIM(loc_oBO.this_cMoeda)
1478:         ENDIF
1479: 
1480:         *-- legado: ThisForm.get_cotacao.Value = fBuscarCotacao(moeda, date())
1481:         IF PEMSTATUS(THIS, "txt_4c__cotacao", 5)
1482:             THIS.txt_4c__cotacao.Value = loc_oBO.this_nCotacao
1483:         ENDIF
1484: 
1485:         *-- legado: ThisForm.get_limcred.Value = crSigClLcr.limcres
1486:         IF PEMSTATUS(THIS, "txt_4c__limcred", 5)
1487:             THIS.txt_4c__limcred.Value = loc_oBO.this_nLimiteCredito
1488:         ENDIF
1489: 
1490:         *-- legado: ThisForm.get_pendoutr.Value = _Pendente
1491:         *-- Rotulado "Total da Movimentacao :" - o valor DESTA movimentacao.
1492:         *-- O cruzamento de nomes eh do legado e esta transcrito de proposito
1493:         *-- (ver ConfigurarCamposDados, bloco do Say9).
1494:         IF PEMSTATUS(THIS, "txt_4c__PendOutr", 5)
1495:             THIS.txt_4c__PendOutr.Value = loc_oBO.this_nPendente
1496:         ENDIF
1497: 
1498:         *-- legado: ThisForm.get_pendente.Value = _Pendoutr
1499:         *-- Campo do total em aberto - a SOMA das OUTRAS movimentacoes em
1500:         *-- aberto. Mesmo cruzamento de nomes do bloco anterior, transcrito

*-- Linhas 1571 a 1710:
1571:     * dentro dos 0..80 do cnt_4c_Sombra): eh o layout do legado, e funciona
1572:     * porque o cabecalho eh o PRIMEIRO AddObject da tela (regra #11).
1573:     *==========================================================================
1574:     PROTECTED PROCEDURE ConfigurarBotoes()
1575:         LOCAL loc_oErro
1576: 
1577:         TRY
1578:             THIS.AddObject("cmd_4c_Ok", "CommandButton")
1579:             WITH THIS.cmd_4c_Ok
1580:                 .Top             = 3
1581:                 .Left            = 923
1582:                 .Width           = 75
1583:                 .Height          = 75
1584:                 .Caption         = "Retornar"
1585:                 .ToolTipText     = "[ESC] Retornar"
1586:                 .Cancel          = .T.
1587:                 .FontName        = "Comic Sans MS"
1588:                 .FontSize        = 8
1589:                 .FontBold        = .T.
1590:                 .FontItalic      = .T.
1591:                 .WordWrap        = .T.
1592:                 .AutoSize        = .F.
1593:                 .ForeColor       = RGB(90, 90, 90)
1594:                 .BackColor       = RGB(255, 255, 255)
1595:                 .SpecialEffect   = 0
1596:                 .PicturePosition = 13
1597:                 .MousePointer    = 15
1598:                 .Themes          = .T.
1599:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
1600:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
1601:                 .Enabled         = .T.
1602:                 .Visible         = .T.
1603:             ENDWITH
1604:         CATCH TO loc_oErro
1605:             MsgErro(loc_oErro.Message + CHR(13) + ;
1606:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1607:                 "Procedure: " + loc_oErro.Procedure, ;
1608:                 "Erro em FormSigOpLbC.ConfigurarBotoes")
1609:         ENDTRY
1610: 
1611:         RETURN .T.
1612:     ENDPROC
1613: 
1614: 
1615:     *==========================================================================
1616:     * ConfigurarEventos - BINDEVENT dos Click
1617:     *
1618:     * O Click do "ok" eh o UNICO evento de CONTROLE do dump inteiro: a SECAO 3
1619:     * tem o PROCEDURE e o Init do form, os dez "Return .f." dos When (campos
1620:     * somente-leitura, que no migrado viram ReadOnly e nao precisam de
1621:     * handler) e este Click. Nao ha outro evento a ligar nas fases seguintes.
1622:     *
1623:     * O handler eh PUBLIC (sem PROTECTED): BINDEVENT falha em SILENCIO com
1624:     * metodo PROTECTED (regra #3).
1625:     *==========================================================================
1626:     PROTECTED PROCEDURE ConfigurarEventos()
1627:         LOCAL loc_oErro
1628: 
1629:         TRY
1630:             BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "BtnRetornarClick")
1631:         CATCH TO loc_oErro
1632:             MsgErro(loc_oErro.Message + CHR(13) + ;
1633:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1634:                 "Procedure: " + loc_oErro.Procedure, ;
1635:                 "Erro em FormSigOpLbC.ConfigurarEventos")
1636:         ENDTRY
1637: 
1638:         RETURN .T.
1639:     ENDPROC
1640: 
1641: 
1642:     *==========================================================================
1643:     * BtnRetornarClick - transcricao do SIGOPLBC.ok.Click legado:
1644:     *
1645:     *     If Type('ThisForm.poFormCaixa') = "O"
1646:     *         ThisForm.PoFormCaixa.Enabled = .t.
1647:     *     Endif
1648:     *     Thisform.release
1649:     *
1650:     * Nomeado pela ACAO (o Caption "Retornar" e o corpo do Click), nao pelo
1651:     * Name do objeto legado ("ok"): o nome tem de dizer o que o metodo FAZ.
1652:     * O objeto segue cmd_4c_Ok porque eh o que o mapeamento.json da task
1653:     * declara, e o ValidarUIFidelity monta o caminho a partir dele.
1654:     *
1655:     * Release() e nao Hide(): esta tela eh um dialogo que nao devolve nada ao
1656:     * chamador - o legado faz Thisform.release, e quem le a decisao de credito
1657:     * eh o operador, nao o form do caixa.
1658:     *
1659:     * PUBLIC (sem PROTECTED): ligado por BINDEVENT.
1660:     *==========================================================================
1661:     PROCEDURE BtnRetornarClick()
1662:         LOCAL loc_oErro
1663: 
1664:         TRY
1665:             THIS.ReabilitarFormCaixa()
1666:             THIS.Release()
1667:         CATCH TO loc_oErro
1668:             MsgErro(loc_oErro.Message + CHR(13) + ;
1669:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1670:                 "Procedure: " + loc_oErro.Procedure, ;
1671:                 "Erro em FormSigOpLbC.BtnRetornarClick")
1672:         ENDTRY
1673: 
1674:         RETURN .T.
1675:     ENDPROC
1676: 
1677: 
1678:     *==========================================================================
1679:     * CarregarDados - calcula a composicao do limite e liga a grade
1680:     *
1681:     * Espelha o corpo do Init legado: o calculo todo esta no BO
1682:     * (CalcularComposicaoLimite), e o que sobra aqui eh ler o cabecalho da
1683:     * movimentacao em lancamento, passar ao BO e repintar a grade.
1684:     *
1685:     * DE ONDE VEM O CABECALHO: do cursor TprMvCab, criado e posicionado pelo
1686:     * form CHAMADOR (o caixa). O legado alcanca esse cursor com
1687:     * "set datasession to loForm.DataSessionId"; aqui nao eh preciso trocar de
1688:     * datasession porque FormBase nao declara DataSession = 2 - o form fica na
1689:     * sessao default (1), a MESMA do chamador, e o alias eh visivel direto
1690:     * (mesmo padrao de FormDCC/FormPzo).
1691:     *
1692:     * As colunas sao lidas QUALIFICADAS pelo alias (TprMvCab.<col>), sem
1693:     * SELECT e sem mexer no ponteiro: o cursor eh do CHAMADOR, que continua
1694:     * usando o registro corrente depois que este dialogo fechar.
1695:     *
1696:     * Os valores sao passados com ALLTRIM: as chaves POSICIONAIS que dependem
1697:     * do padding (SigClLcr.GruContas char(20) = Grupos char(10) + Contas
1698:     * char(10), e SigMvCab.EmpDopNums char(29)) sao montadas DENTRO do BO com
1699:     * PADR explicito, que repoe o padding (regra #42). Nao ha chave posicional
1700:     * montada aqui.
1701:     *
1702:     * TRES desfechos, transcritos do legado:
1703:     *
1704:     *   1) sucesso                  -> liga a grade e repinta
1705:     *   2) this_lContaIndefinida    -> o legado faz "Return" NU (sem valor),
1706:     *      isto eh, o Init devolve .T. e a TELA ABRE, com os campos em branco,
1707:     *      depois de reabilitar o caixa. Nao ha mensagem: o lado considerado da
1708:     *      movimentacao simplesmente nao tem conta, e nao ha nada a liberar.
1709:     *      Reproduzido como esta, mesmo sendo um desfecho esquisito (PILAR 1).
1710:     *   3) this_lFalhaConexao       -> o legado faz "Return(.F.)" e a tela NAO

*-- Linhas 1718 a 1761:
1718:     *
1719:     * PUBLIC: harness chama metodos do form de fora da classe (regra #3).
1720:     *==========================================================================
1721:     PROCEDURE CarregarDados()
1722:         LOCAL loc_lSucesso, loc_lModoTeste, loc_oBO, loc_oErro
1723:         LOCAL loc_cEmps, loc_nNumes, loc_nValOs
1724:         LOCAL loc_cGrupoOs, loc_cContaOs, loc_cGrupoDs, loc_cContaDs
1725: 
1726:         loc_lSucesso = .F.
1727: 
1728:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1729:             RETURN .F.
1730:         ENDIF
1731: 
1732:         loc_lModoTeste = (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) ;
1733:                       OR (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
1734: 
1735:         TRY
1736:             IF loc_lModoTeste
1737:                 *-- Sem conexao: so a grade vazia, ja com cabecalhos e larguras,
1738:                 *-- e os campos espelhando o BO recem-criado (tudo zerado) - o
1739:                 *-- que importa aqui eh provar que o espelhamento nao estoura
1740:                 *-- por tipo nem por membro ausente.
1741:                 THIS.CarregarLista()
1742:                 THIS.AtualizarCamposComposicao()
1743:                 loc_lSucesso = .T.
1744:             ELSE
1745:                 IF !USED("TprMvCab")
1746:                     *-- O legado faz "Select TprMvCab" direto e quebraria com
1747:                     *-- "Alias TPRMVCAB is not found". O contrato eh o chamador
1748:                     *-- criar e posicionar o cursor antes de abrir o dialogo;
1749:                     *-- sem ele nao ha movimentacao a avaliar.
1750:                     MsgErro("Favor reinicializar o processo." + CHR(13) + ;
1751:                         "Cabe" + CHR(231) + "alho da movimenta" + CHR(231) + ;
1752:                         CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + ;
1753:                         "vel (TprMvCab).", "Falha na Conex" + CHR(227) + "o")
1754:                     loc_lSucesso = .F.
1755:                 ELSE
1756:                     IF EOF("TprMvCab")
1757:                         *-- Cursor aberto mas sem registro corrente: ler as
1758:                         *-- colunas devolveria tudo em branco e a tela exibiria
1759:                         *-- uma composicao de zeros como se fosse real.
1760:                         MsgErro("Favor reinicializar o processo." + CHR(13) + ;
1761:                             "Nenhuma movimenta" + CHR(231) + CHR(227) + "o " + ;

*-- Linhas 1829 a 1916:
1829:                 "limite de cr" + CHR(233) + "dito:" + CHR(13) + ;
1830:                 loc_oErro.Message + CHR(13) + ;
1831:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1832:                 "Procedure: " + loc_oErro.Procedure, ;
1833:                 "Libera" + CHR(231) + CHR(227) + "o de Cr" + CHR(233) + "dito")
1834:             loc_lSucesso = .F.
1835:         ENDTRY
1836: 
1837:         RETURN loc_lSucesso
1838:     ENDPROC
1839: 
1840: 
1841:     *==========================================================================
1842:     * TornarControlesVisiveis - AddObject cria tudo com Visible = .F.
1843:     * Percorre Controls recursivamente, inclusive Pages de eventuais
1844:     * PageFrames (nao ha nenhum nesta tela, mas o metodo segue o padrao do
1845:     * projeto para continuar correto se algo mudar nas proximas fases).
1846:     *
1847:     * PUBLIC: harness de teste chama metodos do form de fora da classe
1848:     * (regra #3).
1849:     *==========================================================================
1850:     PROCEDURE TornarControlesVisiveis()
1851:         LOCAL loc_nI
1852: 
1853:         FOR loc_nI = 1 TO THIS.ControlCount
1854:             THIS.TornarControleEFilhosVisiveis(THIS.Controls(loc_nI))
1855:         ENDFOR
1856: 
1857:         RETURN .T.
1858:     ENDPROC
1859: 
1860:     PROTECTED PROCEDURE TornarControleEFilhosVisiveis(par_oObjeto)
1861:         LOCAL loc_nP, loc_nC
1862: 
1863:         IF VARTYPE(par_oObjeto) != "O"
1864:             RETURN .F.
1865:         ENDIF
1866: 
1867:         IF PEMSTATUS(par_oObjeto, "Visible", 5)
1868:             par_oObjeto.Visible = .T.
1869:         ENDIF
1870: 
1871:         IF PEMSTATUS(par_oObjeto, "PageCount", 5) AND par_oObjeto.PageCount > 0
1872:             FOR loc_nP = 1 TO par_oObjeto.PageCount
1873:                 THIS.TornarControleEFilhosVisiveis(par_oObjeto.Pages(loc_nP))
1874:             ENDFOR
1875:         ENDIF
1876: 
1877:         IF PEMSTATUS(par_oObjeto, "ControlCount", 5) AND par_oObjeto.ControlCount > 0
1878:             FOR loc_nC = 1 TO par_oObjeto.ControlCount
1879:                 THIS.TornarControleEFilhosVisiveis(par_oObjeto.Controls(loc_nC))
1880:             ENDFOR
1881:         ENDIF
1882: 
1883:         RETURN .T.
1884:     ENDPROC
1885: 
1886: 
1887:     *==========================================================================
1888:     * Destroy - funil de SAIDA garantido: reabilita o caixa (regra #40) e
1889:     * chama DODEFAULT() para o fix de menu da FormBase (menu-shrink apos
1890:     * form modal).
1891:     *
1892:     * Fecha tambem o cursor da grade (DbOpera do legado), que eh do FORM e nao
1893:     * do chamador. Sem TABLEREVERT: o cursor nasce com Buffering = 1 e
1894:     * TABLEREVERT sem buffering nao eh no-op - estoura o erro 1586 "Function
1895:     * requires row or table buffering mode" (regra #52). USE IN fecha o alias
1896:     * sozinho, inclusive com buffer sujo.
1897:     *
1898:     * O cursor TprMvCab NAO eh fechado: eh do form CHAMADOR, que continua
1899:     * usando ele depois que este dialogo fechar.
1900:     *==========================================================================
1901:     PROCEDURE Destroy()
1902:         LOCAL loc_cAlias
1903: 
1904:         THIS.ReabilitarFormCaixa()
1905: 
1906:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1907:             loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorOperacoes)
1908:             IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
1909:                 USE IN (loc_cAlias)
1910:             ENDIF
1911:         ENDIF
1912: 
1913:         DODEFAULT()
1914:     ENDPROC
1915: 
1916: ENDDEFINE

