# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (7)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=4 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [METODO-INEXISTENTE] Metodo 'THIS.CarregarParametrosSistema()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.CarregarTiposEtiquetaDinamico()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.CarregarImpressorasEtiqueta()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'Say5' (parent: SIGOPIPE.Cnt_Impressora): Top original=4 vs migrado 'lbl_4c_Say5' Top=554 (diff=550px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say5' (parent: SIGOPIPE.Cnt_Impressora): Left original=323 vs migrado 'lbl_4c_Say5' Left=412 (diff=89px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpIpE.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (5618 linhas total):

*-- Linhas 24 a 73:
24: *   Init(par_oFormAnterior, par_lGravaPro) os dois parametros do legado
25: *                                         (Lparameters lfFormAnterior,
26: *                                         llGravaPro)
27: *   InicializarForm                      BO + montagem da superficie visual
28: *   ConfigurarPageFrame                  orquestrador da montagem (nome
29: *                                         mantido por conformidade com o
30: *                                         contrato do pipeline - nao ha
31: *                                         paginacao nesta tela)
32: *   ConfigurarCabecalho                  cntSombra + lblSombra/lblTitulo
33: *   TornarControlesVisiveis              AddObject nasce com Visible = .F.
34: *   Destroy                              solta as referencias, reabilita o
35: *                                         form chamador e repoe o menu
36: *
37: * ESCOPO DA FASE 4/8 - GRADE E BOTOES (esta fase)
38: * ------------------------------------------------
39: *   ConfigurarGrade                      grd_historico -> grd_4c_Dados, as
40: *                                         12 Column, os Text1 e o CheckBox
41: *                                         da coluna de marcacao
42: *   CriarCursorEtiquetas                 o cursor que alimenta a grade
43: *                                         (DbEtiqueta no legado) + os 6
44: *                                         INDEX ON do Init legado
45: *   MontaGradeEtiquetas                  RecordSource + os 12 ControlSource
46: *                                         + o que o bind RESETA (larguras,
47: *                                         cabecalhos, CurrentControl,
48: *                                         Sparse, ReadOnly, ColumnOrder) +
49: *                                         GO TOP / Refresh
50: *   FormatarColunasGrade                 o bloco reaplicavel do acima
51: *   ConfigurarBotoes                     cntBotoes (4 botoes) e cmdTestaPos
52: *   AjustarBotoesPorTipoChamador         o "btnDepois.Enabled = .F. se
53: *                                         ParentForm.Tipo <> 'CADASTRO'" do
54: *                                         Init legado
55: *
56: * POR QUE A FASE 4 NAO TEM "ConfigurarPaginaLista"/"AlternarPagina"
57: * -------------------------------------------------------------------
58: * O prompt generico da fase pede Grid + 6 botoes CRUD em Page1 + troca de
59: * pagina. Aqui vale o ramo FLAT do gate (OPERACIONAL + grd_4c_* + botao +
60: * metodo de carga), e isso eh MEDIDO no dump, nao afirmado:
61: *
62: *   BaseClass: pageframe no dump ........ 0 ocorrencias
63: *   BaseClass: grid ..................... 1 (grd_historico, classe fwgrade)
64: *   BaseClass: commandgroup ............. 2 (cntBotoes 4 botoes,
65: *                                            cmdTestaPos 1 botao)
66: *   Container no inventario de 73 ....... 2 (cntSombra, Cnt_Impressora)
67: *
68: * Sem PageFrame nao ha Page1/Page2, e os 5 botoes do legado sao
69: * Armazenar/Imprimir/Boleto/Sair/Testar Posicao - nao Incluir/Alterar/
70: * Excluir. Escrever ConfigurarPaginaLista/AlternarPagina aqui seria metodo
71: * que nao pagina nada, isto eh, stub disfarcado.
72: *
73: * ESCOPO DA FASE 5/8 - CAMPOS PRINCIPAIS, PARTE 1 (esta fase)

*-- Linhas 95 a 138:
95: *   torno de Opt_Conjunto+opt_Preco+opt_peso. Shape3 (Impressoras) fica para
96: *   a Fase 6, que tambem cria o conteudo que ele moldura.
97: *
98: *   OptionGroup e Button SAO MEMBROS NATIVOS da classe OptionGroup (como
99: *   Text1/Header1 em Column): AddObject cria so o grupo com ButtonCount, e
100: *   o VFP cria os Buttons sozinho - NAO se faz AddObject de Button.
101: *
102: *   Opt_Tipo.ButtonCount = 1 no dump (so "\<a. Rabicho") eh TRANSCRICAO
103: *   fiel, nao corte: o legado POPULA o resto dos tipos em runtime a partir
104: *   de um cursor (LocalTpEti, comportamento.json linha ~81) e isso faz parte
105: *   da carga de dados da Fase 7, nao da criacao de controle desta fase.
106: *
107: *   TabIndex de FORM (na faixa 1..N do form inteiro) continua fora desta
108: *   fase, mesma regra ja registrada no cabecalho da Fase 4 - os dois valores
109: *   duplicados no dump (10 em opt_Preco/opt_peso/Opt_Conjunto, 9 em
110: *   Opt_Impressora, 4 em getQtParcs/getOcoEtiqs) sao a prova de que a
111: *   sequencia so fecha com TODOS os controles existindo (Fase 6). O
112: *   TabIndex de Opt_Tipo.Option1 = 1 ENTRA, porque eh escopo do GRUPO (regra
113: *   CLAUDE.md #29/sub-regra de Buttons), nao do form.
114: *
115: * ESCOPO DA FASE 6/8 - CAMPOS RESTANTES (esta fase)
116: * --------------------------------------------------
117: *   ConfigurarImpressora              Shape3 (moldura) + Cnt_Impressora
118: *                                     (Opcao_Imp + 4 spinners + Say2..Say5 +
119: *                                     Chk_Resete) + Opt_Impressora/Label2 +
120: *                                     Get_Printer/Label5/Label6 + Say5 de
121: *                                     FORM ("Posicao :")/spn_posetiq
122: *   ConfigurarOcorrenciaEJustificativa  getOcoEtiqs/getDOcoEtiqs/
123: *                                     lblOcoEtiqs/ShpOcoEtiqs,
124: *                                     GetJustifs/lblJustifs/ShpJustifs e a
125: *                                     property this_lGravaOcorrencia
126: *   AjustarOrdemTabulacao             TabIndex de FORM, agora que todos os
127: *                                     controles existem
128: *
129: *   Opt_Impressora continua TRANSCRITO com Visible = .F. e fica assim para
130: *   sempre: o bloco que o populava (With Thisform.Opt_Impressora, linhas
131: *   3213-3250 do dump) esta inteiro comentado com "*!*" no legado - foi
132: *   substituido pelo ComboBox Get_Printer ("mena - 05/03/2015 - a lista de
133: *   impressoras sairam dos radio para o combobox"). Transcrever
134: *   Visible = .T. aqui ressuscitaria um controle morto que o PROPRIO legado
135: *   aposentou.
136: *
137: *   Get_Printer nasce com RowSourceType = 0 (nenhum) e RowSource = "" - o
138: *   dump declara RowSourceType = 2 (Alias) + RowSource = "crImpreV", mas

*-- Linhas 252 a 295:
252: *     Enabled/Click) e a correspondencia exata entre o indice legado e
253: *     Buttons(N) migrado nao eh determinavel com certeza - OMITIDO de
254: *     proposito (documentado em AjustarBotaoImprimirPorContexto), mesmo
255: *     criterio ja usado para Opt_Impressora.InteractiveChange.
256: *
257: * CONTRATO COM O CHAMADOR (regra CLAUDE.md #29 / memoria
258: * feedback_form_despachante_pai_nunca_liberado)
259: * ------------------------------------------------------------------------
260: * O Init legado desabilita o form chamador:
261: *
262: *     Thisform.ParentForm = lfFormAnterior
263: *     If Type('lfFormAnterior') = 'O'
264: *         lfFormAnterior.Enabled = .F.
265: *     Endif
266: *
267: * e o legado reabilita em DOIS pontos (linhas 2376 e 3814 do dump -
268: * cntBotoes.Click / cmdTestaPos.Click, ambos fora do escopo desta fase).
269: * Para o form chamador nunca ficar orfao (travado, sem clique possivel)
270: * mesmo que a tela feche por um caminho ainda nao migrado, Destroy() desta
271: * fase ja reabilita par_oFormAnterior como rede de seguranca - os handlers
272: * das fases 7/8 continuam reabilitando no proprio Click, e quando chegarem
273: * la essa linha em Destroy() sera no-op (ja reabilitado).
274: *
275: * WindowType = 1 e ShowWindow = 1 ficam ESTATICOS (sem guard de
276: * gb_4c_ValidandoUI/gb_4c_ModoTeste): nenhum metodo desta fase chama
277: * THIS.Show(), e o harness de instanciacao nao o faz - mesmo padrao de
278: * FormSigOpIpB/FormSigOpAtu (irmaos "SigOp" sem PageFrame).
279: *==============================================================================
280: 
281: DEFINE CLASS FormSigOpIpE AS FormBase
282: 
283:     *--------------------------------------------------------------------------
284:     * Propriedades visuais - TRANSCRITAS do dump de SIGOPIPE
285:     *
286:     *   Height / Width       600 / 1000
287:     *   DataSession          1
288:     *   BorderStyle          2
289:     *   DoCreate             .T.
290:     *   ShowTips             .T.
291:     *   AutoCenter           .T.
292:     *   TitleBar             0      (sem barra de titulo - cntSombra eh o
293:     *                                cabecalho, igual ao resto da familia)
294:     *   ControlBox           .F.
295:     *   MaxButton/MinButton  .F.

*-- Linhas 363 a 652:
363:     *-- campos sem digitar nada repete a consulta SQL a cada saida de campo.
364:     *-- Combina codigo+descricao porque o mesmo handler atende os dois
365:     *-- (getOcoEtiqs.Valid e getDOcoEtiqs.Valid no legado).
366:     this_cUltimoValidarOcorrenciaEtiquetaValidado = ""
367: 
368:     *-- lnTipos/lnImpres do Init legado (Fase 8) - contagens separadas do
369:     *-- ButtonCount/RowSource efetivos, porque AjustarBotaoImprimirPor-
370:     *-- Contexto precisa do "existe ALGUM tipo/impressora configurado",
371:     *-- nao do fallback visual que fica no lugar quando nao existe.
372:     this_nTotalTiposEtiqueta = 0
373:     this_nTotalImpressoras   = 0
374: 
375:     *-- Guarda de reentrancia do toggle de CheckBox da grade (regra do
376:     *-- padrao Click/MouseDown/MouseUp/KeyPress - CLAUDE.md feedback
377:     *-- GridCheckBoxtog): soh o KeyPress(Enter/Espaco) e o MouseUp
378:     *-- replicam o Flag; Click/MouseDown soh suprimem o toggle nativo.
379: 
380:     *--------------------------------------------------------------------------
381:     * this_cCursorEtiquetas - o alias que a grade consome (DbEtiqueta no
382:     * legado)
383:     *
384:     * Renomeado porque o PILAR 3 manda nome novo e porque o cursor eh INTERNO
385:     * a esta tela - medido: "dbEtiqueta" aparece em 1 unico dump de
386:     * tasks\ (o proprio SigOpIpE), contra "dbImpressao", que aparece em 10+
387:     * (sigcdpro, sigregli, sigpdmp6, ...) e por isso eh CONTRATO ENTRE FORMS e
388:     * tera de manter o nome legado quando a Fase 7 chegar nele.
389:     *
390:     * O sufixo "Ipe" nao eh enfeite: este form tem DataSession = 1, ou seja o
391:     * alias vive na sessao de dados CORRENTE, compartilhada com o form
392:     * chamador e com o resto da aplicacao. "cursor_4c_Etiquetas" (sem o
393:     * sufixo) JA EXISTE no projeto - PrlBO.prg:273 faz SQLEXEC nesse alias -
394:     * e colidir ali derrubaria as duas telas sem erro atribuivel a nenhuma
395:     * delas. "cursor_4c_IpeEtiquetas" foi conferido: zero ocorrencias em
396:     * projeto\app\.
397:     *--------------------------------------------------------------------------
398:     this_cCursorEtiquetas = "cursor_4c_IpeEtiquetas"
399: 
400:     *==========================================================================
401:     * Init - recebe os dois parametros do legado (lfFormAnterior, llGravaPro)
402:     *
403:     * Legado (SIGOPIPE.Init), transcrito nas linhas que esta fase cobre:
404:     *
405:     *   Lparameters lfFormAnterior, llGravaPro
406:     *   Thisform.ParentForm = lfFormAnterior
407:     *   If Type('lfFormAnterior') = 'O'
408:     *       lfFormAnterior.Enabled = .F.
409:     *   Endif
410:     *   Thisform.GravaPro = llGravaPro
411:     *
412:     * As duas atribuicoes de Caption nos labels da faixa
413:     * (ThisForm.cntSombra.lblSombra/lblTitulo.Caption) ficam dentro de
414:     * InicializarForm, que eh onde a faixa passa a existir.
415:     *
416:     * O BO eh criado ANTES do DODEFAULT() porque FormBase.Init chama
417:     * InicializarForm, que ja precisa dele para montar a tela.
418:     *
419:     * RETURN fica FORA do TRY/CATCH (regra CLAUDE.md #1): o resultado passa
420:     * pela flag loc_lSucesso.
421:     *==========================================================================
422:     PROCEDURE Init(par_oFormAnterior, par_lGravaPro)
423:         LOCAL loc_lSucesso, loc_oErro
424: 
425:         loc_lSucesso = .F.
426: 
427:         TRY
428:             *-- Legado: Thisform.ParentForm = lfFormAnterior / desabilita
429:             IF VARTYPE(par_oFormAnterior) = "O"
430:                 THIS.this_oFormAnterior = par_oFormAnterior
431: 
432:                 IF PEMSTATUS(THIS.this_oFormAnterior, "Enabled", 5)
433:                     THIS.this_oFormAnterior.Enabled = .F.
434:                 ENDIF
435:             ENDIF
436: 
437:             *-- Legado: Thisform.GravaPro = llGravaPro
438:             THIS.this_lGravaPro = ConverterParaLogico(par_lGravaPro)
439: 
440:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpIpEBO")
441: 
442:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
443:                 THIS.this_cMensagemErro = "Falha ao criar SigOpIpEBO."
444:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + ;
445:                     "cio SigOpIpEBO." + CHR(13) + "VARTYPE retornou: " + ;
446:                     VARTYPE(THIS.this_oBusinessObject), ;
447:                     "Erro em FormSigOpIpE.Init")
448:             ELSE
449:                 *-- FormBase.Init chama InicializarForm
450:                 loc_lSucesso = DODEFAULT()
451:             ENDIF
452:         CATCH TO loc_oErro
453:             loc_lSucesso = .F.
454:             THIS.this_cMensagemErro = loc_oErro.Message
455:             MsgErro(loc_oErro.Message + CHR(13) + ;
456:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
457:                 "Procedure: " + loc_oErro.Procedure, ;
458:                 "Erro em FormSigOpIpE.Init")
459:         ENDTRY
460: 
461:         RETURN loc_lSucesso
462:     ENDPROC
463: 
464:     *==========================================================================
465:     * InicializarForm - monta a superficie visual da tela
466:     *
467:     * Picture: o dump traz "..\framework\imagens\new_background.jpg" - o
468:     * arquivo vive em vbmp\ no sistema novo, alcancado por
469:     * gc_4c_CaminhoIcones (nunca remontado a partir de gc_4c_CaminhoBase,
470:     * regra CLAUDE.md #25/#26).
471:     *
472:     * Os dois labels recebem o Caption aqui, nao na criacao, porque eh o
473:     * que o legado faz logo no inicio do Init
474:     * (ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption).
475:     *
476:     * TornarControlesVisiveis fecha a montagem porque AddObject cria todo
477:     * controle com Visible = .F.
478:     *
479:     * RETURN fica FORA do TRY/CATCH (regra CLAUDE.md #1).
480:     *==========================================================================
481:     PROTECTED PROCEDURE InicializarForm()
482:         LOCAL loc_lSucesso, loc_oErro
483: 
484:         loc_lSucesso = .F.
485: 
486:         TRY
487:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
488: 
489:             THIS.ConfigurarPageFrame()
490: 
491:             *-- Legado: lblSombra.Caption / lblTitulo.Caption = ThisForm.Caption
492:             THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
493:             THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
494: 
495:             *-- AddObject cria tudo com Visible = .F.
496:             THIS.TornarControlesVisiveis(THIS)
497: 
498:             *-- Fase 7: liga os BINDEVENT de botoes/grade/combos/lookups.
499:             *-- Depois de TornarControlesVisiveis porque alguns handlers
500:             *-- (ex. OptTipoInteractiveChange) ja leem .Visible de outros
501:             *-- controles.
502:             THIS.ConfigurarEventosPrincipais()
503: 
504:             *-- Fase 8: restante do Init legado (parametros, tipos de
505:             *-- etiqueta, carga das linhas por Tipo, impressoras). TRY/
506:             *-- CATCH proprio que nunca propaga - falha aqui NAO bloqueia
507:             *-- a abertura da tela (ver comentario do metodo).
508:             THIS.CarregarContextoInicial()
509: 
510:             loc_lSucesso = .T.
511:         CATCH TO loc_oErro
512:             loc_lSucesso = .F.
513:             THIS.this_cMensagemErro = loc_oErro.Message
514:             MsgErro(loc_oErro.Message + CHR(13) + ;
515:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
516:                 "Procedure: " + loc_oErro.Procedure, ;
517:                 "Erro em InicializarForm")
518:         ENDTRY
519: 
520:         RETURN loc_lSucesso
521:     ENDPROC
522: 
523:     *==========================================================================
524:     * ConfigurarPageFrame - orquestra a montagem visual da tela
525:     *
526:     * Nao ha superficie de paginas neste form: o dump declara a raiz
527:     * SIGOPIPE como "Class: form / BaseClass: form" - form GENERICO, sem
528:     * nenhum objeto "BaseClass: pageframe" no inventario de 73 objetos. O
529:     * nome deste metodo eh mantido por conformidade com o contrato do
530:     * pipeline e ele apenas DELEGA aos configuradores especificos, mesmo
531:     * desenho dos irmaos FormSigOpEtq/FormSigOpIpB/FormSigOpAtu.
532:     *
533:     * A ORDEM DAS CHAMADAS EH REGRA, NAO ESTILO (regra CLAUDE.md #11/#30)
534:     * --------------------------------------------------------------------
535:     * O cabecalho vem PRIMEIRO porque os dois CommandGroup ficam DENTRO da
536:     * banda dele e precisam desenhar POR CIMA - no dump os grupos estao em
537:     * Top = -2 com Height = 85 (banda -2..83) e o cntSombra em Top = 0 com
538:     * Height = 80 (banda 0..80), isto eh, se sobrepoem em 0..80 nos dois
539:     * eixos (cntBotoes Left 691..1004 e cmdTestaPos Left 615..700, ambos
540:     * dentro dos 0..1000 do container). Invertida a ordem, a faixa cinza
541:     * COBRE os cinco botoes - sem erro, sem log e sem aparecer em screenshot.
542:     *
543:     * A grade vem ANTES dos botoes so por clareza de leitura: ela esta em
544:     * Top 147..388, nao encosta em ninguem.
545:     *
546:     * MontaGradeEtiquetas vem por ULTIMO porque precisa das Column ja
547:     * criadas E do cursor, e porque atribuir RecordSource reseta propriedades
548:     * de coluna (regra CLAUDE.md #41).
549:     *
550:     * A Fase 5 insere os option groups de Tipo/Preco/Peso/Conjunto e o texto
551:     * livre; a Fase 6 completa com o Cnt_Impressora e a Ocorrencia/
552:     * Justificativa. As chamadas vao DEPOIS de ConfigurarBotoes e ANTES de
553:     * MontaGradeEtiquetas - nenhum desses controles ocupa a banda do
554:     * cabecalho (o mais alto eh GetTexto em Top 83) nem a area da grade
555:     * (Top 147..388).
556:     *==========================================================================
557:     PROTECTED PROCEDURE ConfigurarPageFrame()
558:         THIS.ConfigurarCabecalho()
559:         THIS.ConfigurarGrade()
560:         THIS.ConfigurarBotoes()
561:         THIS.ConfigurarTextoLivreEParcelas()
562:         THIS.ConfigurarGruposTipoPrecoPeso()
563:         THIS.ConfigurarImpressora()
564:         THIS.ConfigurarOcorrenciaEJustificativa()
565:         THIS.MontaGradeEtiquetas()
566:         THIS.AjustarBotoesPorTipoChamador()
567:         THIS.AjustarOrdemTabulacao()
568:     ENDPROC
569: 
570:     *==========================================================================
571:     * ConfigurarCabecalho - a faixa cinza do titulo (cntSombra do legado)
572:     *
573:     * Geometria TRANSCRITA do dump (SIGOPIPE.cntSombra / lblSombra /
574:     * lblTitulo): Top 0 / Left 0 / Height 80 / BackColor 100,100,100 /
575:     * BorderWidth 0, e os dois labels sobrepostos em Top 18 e 17, Left 10,
576:     * Tahoma 18 bold, WordWrap, Alignment 0 - sombra PRETA embaixo e
577:     * titulo BRANCO em cima.
578:     *
579:     * UNICO desvio, deliberado: as larguras. O dump declara
580:     * cntSombra.Width = 1004 e os dois labels com Width = 769, mas o form
581:     * tem Width = 1000 - divergencia de poucos pixels, artefato do Form
582:     * Designer. Por isso o container usa THIS.Width e os labels
583:     * THIS.Width - 20, preservando a margem de 10px do Left do dump nos
584:     * dois lados (regra CLAUDE.md #11).
585:     *
586:     * AutoSize = .F. EXPLICITO nos dois labels: com WordWrap = .T. (que o
587:     * dump declara) um AutoSize = .T. DESCARTA a Height e colapsa o texto
588:     * para uma linha so (regra CLAUDE.md #23).
589:     *
590:     * ForeColor BRANCO em lbl_4c_LblTitulo eh uma das excecoes legitimas da
591:     * regra CLAUDE.md #12: o container eh OPACO e escuro (BackStyle = 1 +
592:     * BackColor RGB(100,100,100)), nao a textura clara das paginas de
593:     * cadastro.
594:     *
595:     * Os nomes migrados vem de tasks\task754\mapeamento.json (cntSombra ->
596:     * cnt_4c_Sombra, lblSombra -> lbl_4c_LblSombra, lblTitulo ->
597:     * lbl_4c_LblTitulo) - eh esse arquivo que a validacao de fidelidade de
598:     * UI consulta, entao divergir dele reprovaria a tela sem haver defeito
599:     * visual.
600:     *==========================================================================
601:     PROTECTED PROCEDURE ConfigurarCabecalho()
602:         THIS.AddObject("cnt_4c_Sombra", "Container")
603:         WITH THIS.cnt_4c_Sombra
604:             .Top           = 0
605:             .Left          = 0
606:             .Width         = THIS.Width
607:             .Height        = 80
608:             .BackStyle     = 1
609:             .BackColor     = RGB(100, 100, 100)
610:             .BorderWidth   = 0
611:             .SpecialEffect = 0
612:             .Visible       = .T.
613:         ENDWITH
614: 
615:         *-- lblSombra: sombra preta, desenhada 1px abaixo do titulo
616:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
617:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
618:             .Top           = 18
619:             .Left          = 10
620:             .Width         = THIS.Width - 20
621:             .Height        = 40
622:             .AutoSize      = .F.
623:             .BackStyle     = 0
624:             .WordWrap      = .T.
625:             .Alignment     = 0
626:             .FontName      = "Tahoma"
627:             .FontSize      = 18
628:             .FontBold      = .T.
629:             .FontUnderline = .F.
630:             .ForeColor     = RGB(0, 0, 0)
631:             .Caption       = THIS.Caption
632:             .Visible       = .T.
633:         ENDWITH
634: 
635:         *-- lblTitulo: texto branco por cima da sombra
636:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
637:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
638:             .Top         = 17
639:             .Left        = 10
640:             .Width       = THIS.Width - 20
641:             .Height      = 46
642:             .AutoSize    = .F.
643:             .BackStyle   = 0
644:             .WordWrap    = .T.
645:             .Alignment   = 0
646:             .FontName    = "Tahoma"
647:             .FontSize    = 18
648:             .FontBold    = .T.
649:             .ForeColor   = RGB(255, 255, 255)
650:             .Caption     = THIS.Caption
651:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
652:             .Visible     = .T.

*-- Linhas 723 a 766:
723:     * CLAUDE.md #41), e o bind reseta largura/cabecalho. Tudo isso mora em
724:     * MontaGradeEtiquetas.
725:     *==========================================================================
726:     PROTECTED PROCEDURE ConfigurarGrade()
727:         LOCAL loc_oGrid
728: 
729:         THIS.AddObject("grd_4c_Dados", "Grid")
730:         loc_oGrid = THIS.grd_4c_Dados
731: 
732:         *-- Legado: Thisform.grd_Historico.RecordSource = '' antes do cursor
733:         loc_oGrid.RecordSource = ""
734:         loc_oGrid.ColumnCount  = 12
735: 
736:         WITH loc_oGrid
737:             .Top                = 147
738:             .Left               = 6
739:             .Width              = 984
740:             .Height             = 241
741:             .FontName           = "Arial"
742:             .FontSize           = 8
743:             .HeaderHeight       = 17
744:             .RowHeight          = 17
745:             .ScrollBars         = 3
746:             .Panel              = 1
747:             .DeleteMark         = .F.
748:             .RecordMark         = .F.
749:             .AllowHeaderSizing  = .F.
750:             .AllowRowSizing     = .F.
751:             .GridLineColor      = RGB(238, 238, 238)
752:             .HighlightBackColor = RGB(90, 90, 90)
753:             .Enabled            = .T.
754:             .Visible            = .T.
755:         ENDWITH
756: 
757:         *-- Base uniforme dos 12 blocos do dump
758:         WITH loc_oGrid
759:             .FontName = "Arial"
760:             .FontSize = 8
761:             .SetAll("Movable",   .F.,     "Column")
762:             .SetAll("Resizable", .F.,     "Column")
763: 
764:             .SetAll("FontName",  "Arial", "Header")
765:             .SetAll("FontSize",  8,       "Header")
766:             .SetAll("Alignment", 2,       "Header")

*-- Linhas 798 a 841:
798: 
799:         *-- Posicao 4 (.Name "Column4") - "Codigo / Barra". Trocado de Text1
800:         *-- (nativo da Column) para a subclasse TextBoxCodBarrasIpE_4c
801:         *-- (DEFINE CLASS fora de FormSigOpIpE, fim deste arquivo): BINDEVENT
802:         *-- em "Valid" de TextBox de Column NAO eh confiavel (regra CLAUDE.md
803:         *-- #46) - GotFocus/Valid tem de ser METODO DE CLASSE, delegando para
804:         *-- THISFORM, igual ao padrao TextBoxProdutoLpr_4c do FormLpr.
805:         *-- A mascara esta no controle, e o dump ZERA Column4.Format (override
806:         *-- vazio do Form Designer - regra CLAUDE.md #49: nao se transcreve).
807:         loc_oGrid.Column4.AddObject("txt_4c_CodBarras", "TextBoxCodBarrasIpE_4c")
808:         WITH loc_oGrid.Column4.txt_4c_CodBarras
809:             .FontName    = "Arial"
810:             .FontSize    = 8
811:             .BorderStyle = 0
812:             .Margin      = 0
813:             .InputMask   = "99999999999999"
814:             .ForeColor   = RGB(0, 0, 0)
815:             .BackColor   = RGB(255, 255, 255)
816:             .Visible     = .T.
817:         ENDWITH
818:         loc_oGrid.Column4.CurrentControl = "txt_4c_CodBarras"
819:         loc_oGrid.Column4.Sparse         = .F.
820: 
821:         *-- Mascaras declaradas no nivel da COLUNA (ela propaga para o
822:         *-- CurrentControl). Posicao 5 declara o par tambem no Text1, com o
823:         *-- MESMO valor - redundancia do SCX, nao divergencia.
824:         loc_oGrid.Column5.Format     = "999,999.99"
825:         loc_oGrid.Column5.InputMask  = "999,999.99"
826: 
827:         loc_oGrid.Column6.Format     = "9,999.99"
828:         loc_oGrid.Column6.InputMask  = "9,999.99"
829: 
830:         *-- Posicao 9 (.Name "Column6") declara InputMask SEM Format
831:         loc_oGrid.Column9.InputMask  = "999,999.99"
832: 
833:         loc_oGrid.Column11.Format    = "999,999.99"
834:         loc_oGrid.Column12.Format    = "999,999.99"
835: 
836:         *-- Posicao 10 (.Name "Column10") - "Parcelas". Mesma troca de
837:         *-- Text1 por subclasse, pelo mesmo motivo (Column10.Text1.Valid/
838:         *-- When do dump).
839:         loc_oGrid.Column10.AddObject("txt_4c_Parcelas", "TextBoxParcelasIpE_4c")
840:         WITH loc_oGrid.Column10.txt_4c_Parcelas
841:             .FontName    = "Arial"

*-- Linhas 912 a 955:
912:     *
913:     * RETURN fica FORA do TRY/CATCH (regra CLAUDE.md #1).
914:     *==========================================================================
915:     PROTECTED PROCEDURE CriarCursorEtiquetas()
916:         LOCAL loc_lSucesso, loc_oErro, loc_cCursor, loc_cNullAnterior
917: 
918:         loc_lSucesso = .F.
919:         loc_cCursor  = THIS.this_cCursorEtiquetas
920: 
921:         *-- Lido ANTES do TRY de proposito: o CATCH precisa dele para repor o
922:         *-- SET. Lido dentro, uma falha no CREATE CURSOR deixaria SET NULL ON
923:         *-- vazando do form para o resto da aplicacao, e o proximo
924:         *-- CREATE CURSOR de QUALQUER tela nasceria com colunas nulaveis que
925:         *-- ela nao pediu - defeito sem erro e longe da causa.
926:         loc_cNullAnterior = SET("NULL")
927: 
928:         TRY
929:             IF USED(loc_cCursor)
930:                 IF CURSORGETPROP("Buffering", loc_cCursor) > 1
931:                     TABLEREVERT(.T., loc_cCursor)
932:                 ENDIF
933:                 USE IN (loc_cCursor)
934:             ENDIF
935: 
936:             SET NULL ON
937: 
938:             CREATE CURSOR (loc_cCursor) ( ;
939:                 cbars      N(14, 0) NOT NULL, ;
940:                 contas     C(10)    NOT NULL, ;
941:                 cpros      C(14)    NOT NULL, ;
942:                 datas      T        NULL,     ;
943:                 dopeos     C(20)    NOT NULL, ;
944:                 dopes      C(20)    NOT NULL, ;
945:                 empos      C(3)     NOT NULL, ;
946:                 emps       C(3)     NOT NULL, ;
947:                 grupos     C(10)    NOT NULL, ;
948:                 nops       N(10, 0) NOT NULL, ;
949:                 numeos     N(6, 0)  NOT NULL, ;
950:                 numes      N(6, 0)  NOT NULL, ;
951:                 pesos      N(9, 3)  NOT NULL, ;
952:                 qtds       N(9, 3)  NOT NULL, ;
953:                 transps    L        NOT NULL, ;
954:                 usados     L        NOT NULL, ;
955:                 usuars     C(10)    NOT NULL, ;

*-- Linhas 1022 a 1153:
1022:             THIS.this_cMensagemErro = loc_oErro.Message
1023:             MsgErro(loc_oErro.Message + CHR(13) + ;
1024:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1025:                 "Procedure: " + loc_oErro.Procedure, ;
1026:                 "Erro em CriarCursorEtiquetas")
1027:         ENDTRY
1028: 
1029:         RETURN loc_lSucesso
1030:     ENDPROC
1031: 
1032:     *==========================================================================
1033:     * MontaGradeEtiquetas - liga a grade ao cursor e repoe o que o bind
1034:     * destroi
1035:     *
1036:     * Reproduz o "With Thisform.grd_Historico" do Init legado (2654-2672) e o
1037:     * "Select DbEtiqueta / Goto Top / Refresh" da linha 3268.
1038:     *
1039:     * Os ControlSource vem do NOME da Column no legado, traduzido para a
1040:     * POSICAO deste arquivo (ver a tabela em ConfigurarGrade):
1041:     *
1042:     *   legado .Column1  -> Column1   Datas        legado .Column7  -> Column6   Qtds
1043:     *   legado .Column2  -> Column2   Flag         legado .Column8  -> Column7   ObsEtiqs
1044:     *   legado .Column3  -> Column3   CPros        legado .Column9  -> Column8   Reffs
1045:     *   legado .Column4  -> Column4   CBars        legado .Column6  -> Column9   pVens
1046:     *   legado .Column5  -> Column5   PrecoDe      legado .Column10 -> Column10  Parcelas
1047:     *                                              legado .Column11 -> Column11  PrecoDeCJ
1048:     *                                              legado .Column12 -> Column12  pVensCJ
1049:     *
1050:     * O cursor eh criado antes de qualquer ControlSource: ligar coluna a
1051:     * cursor inexistente estoura "Alias ... is not found" DENTRO do TRY do
1052:     * InicializarForm, que devolve .F., e ai CREATEOBJECT devolve .F., o
1053:     * "IF VARTYPE(loForm) = 'O'" do chamador nao entra e o usuario aciona a
1054:     * tela e NADA acontece, sem erro visivel (regra CLAUDE.md #41).
1055:     *
1056:     * GO TOP + Refresh no fim porque popular/religar cursor NAO repinta a
1057:     * grade sozinho - o legado fecha exatamente assim, e sem isso a grade
1058:     * fica visualmente vazia com o cursor correto, o que manda o diagnostico
1059:     * para SQL/permissao (regra CLAUDE.md #21).
1060:     *
1061:     * PUBLIC de proposito: eh o funil de (re)carga da grade, chamado pelos
1062:     * ramos por Tipo da Fase 7 e alvo potencial de BINDEVENT - PROTECTED
1063:     * falharia calado no bind e estouraria "Property ... is not found" na
1064:     * chamada de fora (regras CLAUDE.md #3/#51).
1065:     *
1066:     * RETURN fica FORA do TRY/CATCH (regra CLAUDE.md #1).
1067:     *==========================================================================
1068:     PROCEDURE MontaGradeEtiquetas()
1069:         LOCAL loc_lSucesso, loc_oErro, loc_cCursor, loc_oGrid
1070: 
1071:         loc_lSucesso = .F.
1072:         loc_cCursor  = THIS.this_cCursorEtiquetas
1073: 
1074:         TRY
1075:             IF !USED(loc_cCursor)
1076:                 THIS.CriarCursorEtiquetas()
1077:             ENDIF
1078: 
1079:             IF USED(loc_cCursor)
1080:                 loc_oGrid = THIS.grd_4c_Dados
1081: 
1082:                 *-- Legado: RecordSource = '' e so depois o alias
1083:                 loc_oGrid.RecordSource = ""
1084:                 loc_oGrid.RecordSource = loc_cCursor
1085: 
1086:                 loc_oGrid.Column1.ControlSource  = loc_cCursor + ".Datas"
1087:                 loc_oGrid.Column2.ControlSource  = loc_cCursor + ".Flag"
1088:                 loc_oGrid.Column3.ControlSource  = loc_cCursor + ".CPros"
1089:                 loc_oGrid.Column4.ControlSource  = loc_cCursor + ".CBars"
1090:                 loc_oGrid.Column5.ControlSource  = loc_cCursor + ".PrecoDe"
1091:                 loc_oGrid.Column6.ControlSource  = loc_cCursor + ".Qtds"
1092:                 loc_oGrid.Column7.ControlSource  = loc_cCursor + ".ObsEtiqs"
1093:                 loc_oGrid.Column8.ControlSource  = loc_cCursor + ".Reffs"
1094:                 loc_oGrid.Column9.ControlSource  = loc_cCursor + ".pVens"
1095:                 loc_oGrid.Column10.ControlSource = loc_cCursor + ".Parcelas"
1096:                 loc_oGrid.Column11.ControlSource = loc_cCursor + ".PrecoDeCJ"
1097:                 loc_oGrid.Column12.ControlSource = loc_cCursor + ".pVensCJ"
1098: 
1099:                 THIS.FormatarColunasGrade()
1100: 
1101:                 *-- Legado: Select DbEtiqueta / Goto Top / Refresh
1102:                 SELECT (loc_cCursor)
1103:                 GO TOP
1104:                 loc_oGrid.Refresh()
1105: 
1106:                 loc_lSucesso = .T.
1107:             ENDIF
1108:         CATCH TO loc_oErro
1109:             loc_lSucesso = .F.
1110:             THIS.this_cMensagemErro = loc_oErro.Message
1111:             MsgErro(loc_oErro.Message + CHR(13) + ;
1112:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1113:                 "Procedure: " + loc_oErro.Procedure, ;
1114:                 "Erro em MontaGradeEtiquetas")
1115:         ENDTRY
1116: 
1117:         RETURN loc_lSucesso
1118:     ENDPROC
1119: 
1120:     *==========================================================================
1121:     * FormatarColunasGrade - tudo o que a atribuicao de RecordSource/
1122:     * ControlSource RESETA, reaplicado por inteiro
1123:     *
1124:     * Atribuir RecordSource devolve Column.Width ao default 90 e
1125:     * Header1.Caption a "ColumnN", e zera Column.CurrentControl /
1126:     * Column.Sparse / Column.ReadOnly (regras CLAUDE.md #41/#46). Por isso
1127:     * este bloco vive num metodo proprio e roda DEPOIS de cada bind - todo
1128:     * caminho que mexer em RecordSource tem de chamar este metodo no fim.
1129:     *
1130:     * Larguras e cabecalhos TRANSCRITOS do dump, cada um pela chave certa (a
1131:     * largura pela POSICAO, o cabecalho pelo NOME - ver ConfigurarGrade).
1132:     *
1133:     * CurrentControl eh o que faz o CheckBox APARECER: sem ele a Column2
1134:     * continua desenhando o Text1 dela e o usuario ve ".T."/".F." como texto,
1135:     * sem nada para clicar. E Sparse = .F. (que o dump declara) eh o que o
1136:     * faz aparecer em TODAS as linhas, nao so na linha ativa - numa tela cuja
1137:     * funcao eh escolher quais etiquetas imprimir, isso eh a diferenca entre
1138:     * marcar o que se quer e marcar uma linha (regra CLAUDE.md #18).
1139:     *
1140:     * A ordem do bloco de ReadOnly eh regra, nao estilo: Grid.ReadOnly
1141:     * PRIMEIRO, porque ele PROPAGA para as colunas e sobrescreveria o que
1142:     * viesse antes (regra CLAUDE.md #46). As quatro colunas editaveis do
1143:     * dump sao a de marcacao (posicao 2), Quantidade (6), Parcelas (10) e -
1144:     * so em alguns Tipo de chamador - "Codigo / Barra" (4); esta ultima nasce
1145:     * ReadOnly como o SCX declara, e quem a libera sao os ramos por Tipo da
1146:     * Fase 7.
1147:     *
1148:     * ColumnOrder por ULTIMO e em ordem CRESCENTE de destino: atribuir
1149:     * ColumnOrder INSERE a coluna naquela posicao e empurra as demais, entao
1150:     * so construindo da esquerda para a direita cada coluna ja colocada fica
1151:     * onde foi posta. A ordem de EXIBICAO do legado nao eh a de criacao - eh
1152:     * esta permutacao completa de 1..12, lida do bloco da grade no dump:
1153:     *

*-- Linhas 1171 a 1214:
1171:     * Column foi recriada por uma reatribuicao de ColumnCount - ai o
1172:     * CheckBox nao existe mais e o nome apontaria para objeto morto.
1173:     *==========================================================================
1174:     PROTECTED PROCEDURE FormatarColunasGrade()
1175:         LOCAL loc_oGrid
1176: 
1177:         loc_oGrid = THIS.grd_4c_Dados
1178: 
1179:         *-- Larguras (POSICAO no dump) e cabecalhos (NOME no dump)
1180:         loc_oGrid.Column1.Width             = 68
1181:         loc_oGrid.Column1.Header1.Caption   = "Data"
1182: 
1183:         loc_oGrid.Column2.Width             = 20
1184:         loc_oGrid.Column2.Header1.Caption   = ""
1185: 
1186:         loc_oGrid.Column3.Width             = 100
1187:         loc_oGrid.Column3.Header1.Caption   = "Produto"
1188: 
1189:         loc_oGrid.Column4.Width             = 100
1190:         loc_oGrid.Column4.Header1.Caption   = "C" + CHR(243) + "digo / Barra"
1191: 
1192:         loc_oGrid.Column5.Width             = 95
1193:         loc_oGrid.Column5.Header1.Caption   = "Pre" + CHR(231) + "o De"
1194: 
1195:         loc_oGrid.Column6.Width             = 80
1196:         loc_oGrid.Column6.Header1.Caption   = "Quantidade"
1197: 
1198:         loc_oGrid.Column7.Width             = 180
1199:         loc_oGrid.Column7.Header1.Caption   = "Observa" + CHR(231) + CHR(227) + "o"
1200: 
1201:         loc_oGrid.Column8.Width             = 83
1202:         loc_oGrid.Column8.Header1.Caption   = "Ref. Fornecedor"
1203: 
1204:         loc_oGrid.Column9.Width             = 95
1205:         loc_oGrid.Column9.Header1.Caption   = "Pre" + CHR(231) + "o"
1206: 
1207:         loc_oGrid.Column10.Width            = 60
1208:         loc_oGrid.Column10.Header1.Caption  = "Parcelas"
1209: 
1210:         loc_oGrid.Column11.Width            = 95
1211:         loc_oGrid.Column11.Header1.Caption  = "Pre" + CHR(231) + "o De Conjunto"
1212: 
1213:         loc_oGrid.Column12.Width            = 95
1214:         loc_oGrid.Column12.Header1.Caption  = "Pre" + CHR(231) + "o Conjunto"

*-- Linhas 1327 a 1377:
1327:     * faixa de 9px em que os grupos se sobrepoem esta vazia nos dois e ambos
1328:     * sao BackStyle = 0, entao nao ha clique bloqueado nem area recortada.
1329:     *
1330:     * Os Buttons NAO recebem BINDEVENT aqui: os cinco Click (Armazenar,
1331:     * Imprimir, Boleto, Sair, Testar Posicao) sao da Fase 7, e ligar agora um
1332:     * handler vazio so para existir seria stub disfarcado. O que esta
1333:     * presente nesta fase eh o unico ajuste de ESTADO que o Init legado faz
1334:     * nesses botoes e que nao depende de nada das fases seguintes - ver
1335:     * AjustarBotoesPorTipoChamador.
1336:     *==========================================================================
1337:     PROTECTED PROCEDURE ConfigurarBotoes()
1338:         LOCAL loc_oGrupo
1339: 
1340:         *-- cntBotoes: Armazenar / Imprimir / Boleto / Sair
1341:         THIS.AddObject("cmg_4c_CntBotoes", "CommandGroup")
1342:         loc_oGrupo = THIS.cmg_4c_CntBotoes
1343: 
1344:         WITH loc_oGrupo
1345:             .ButtonCount   = 4
1346:             .Top           = -2
1347:             .Left          = 691
1348:             .Width         = 313
1349:             .Height        = 85
1350:             .AutoSize      = .T.
1351:             .BackStyle     = 0
1352:             .BorderStyle   = 0
1353:             .BorderColor   = RGB(136, 189, 188)
1354:             .SpecialEffect = 1
1355:             .Themes        = .F.
1356:             .Value         = 0
1357:             .Enabled       = .T.
1358:             .Visible       = .T.
1359:         ENDWITH
1360: 
1361:         *-- Buttons(1) = btnBoleto
1362:         WITH loc_oGrupo.Buttons(1)
1363:             .Top             = 5
1364:             .Left            = 157
1365:             .Width           = 75
1366:             .Height          = 75
1367:             .Caption         = "\<Boleto"
1368:             .Picture         = gc_4c_CaminhoIcones + "geral_boleto_60.jpg"
1369:             .PicturePosition = 13
1370:             .FontName        = "Comic Sans MS"
1371:             .FontSize        = 8
1372:             .FontBold        = .T.
1373:             .FontItalic      = .T.
1374:             .WordWrap        = .T.
1375:             .AutoSize        = .F.
1376:             .MousePointer    = 15
1377:             .SpecialEffect   = 0

*-- Linhas 1461 a 1504:
1461:         *-- cmdTestaPos: o botao de teste de posicionamento da etiqueta.
1462:         *-- Visible = .T. porque nem o dump nem o Init legado o escondem; a
1463:         *-- visibilidade condicional ("= (lnTpEti = 80)") mora no
1464:         *-- InteractiveChange do Opt_Tipo, que eh da Fase 5.
1465:         THIS.AddObject("cmg_4c_CmdTestaPos", "CommandGroup")
1466:         loc_oGrupo = THIS.cmg_4c_CmdTestaPos
1467: 
1468:         WITH loc_oGrupo
1469:             .ButtonCount   = 1
1470:             .Top           = -2
1471:             .Left          = 615
1472:             .Width         = 85
1473:             .Height        = 85
1474:             .AutoSize      = .T.
1475:             .BackStyle     = 0
1476:             .BorderStyle   = 0
1477:             .BackColor     = RGB(240, 240, 240)
1478:             .BorderColor   = RGB(136, 189, 188)
1479:             .SpecialEffect = 1
1480:             .Themes        = .F.
1481:             .Value         = 1
1482:             .Enabled       = .T.
1483:             .Visible       = .T.
1484:         ENDWITH
1485: 
1486:         *-- Buttons(1) = btnPosicao
1487:         WITH loc_oGrupo.Buttons(1)
1488:             .Top           = 5
1489:             .Left          = 5
1490:             .Width         = 75
1491:             .Height        = 75
1492:             .Caption       = "\<Testar Posi" + CHR(231) + CHR(227) + "o"
1493:             .Picture       = gc_4c_CaminhoIcones + "geral_impressora_60.jpg"
1494:             .FontName      = "Comic Sans MS"
1495:             .FontSize      = 8
1496:             .FontBold      = .T.
1497:             .FontItalic    = .T.
1498:             .WordWrap      = .T.
1499:             .AutoSize      = .F.
1500:             .MousePointer  = 15
1501:             .SpecialEffect = 0
1502:             .ForeColor     = RGB(90, 90, 90)
1503:             .BackColor     = RGB(255, 255, 255)
1504:             .Themes        = .F.

*-- Linhas 1536 a 1579:
1536:     * partir da Fase 6) fica para a Fase 6, mesma regra ja registrada no
1537:     * cabecalho do arquivo (AjustarOrdemTabulacao).
1538:     *==========================================================================
1539:     PROTECTED PROCEDURE ConfigurarTextoLivreEParcelas()
1540:         THIS.AddObject("lbl_4c_Label7", "Label")
1541:         WITH THIS.lbl_4c_Label7
1542:             .Top        = 82
1543:             .Left       = 209
1544:             .Width      = 66
1545:             .Height     = 15
1546:             .AutoSize   = .T.
1547:             .BackStyle  = 0
1548:             .FontName   = "Tahoma"
1549:             .FontSize   = 8
1550:             .FontBold   = .T.
1551:             .FontItalic = .F.
1552:             .ForeColor  = RGB(90, 90, 90)
1553:             .Caption    = "Texto Livre"
1554:             .Visible    = .T.
1555:         ENDWITH
1556: 
1557:         THIS.AddObject("obj_4c_GetTexto", "EditBox")
1558:         WITH THIS.obj_4c_GetTexto
1559:             .Top          = 83
1560:             .Left         = 279
1561:             .Width        = 341
1562:             .Height       = 61
1563:             .FontName     = "Tahoma"
1564:             .FontSize     = 10
1565:             .AddLineFeeds = .F.
1566:             .Visible      = .T.
1567:         ENDWITH
1568: 
1569:         THIS.AddObject("lbl_4c_Label8", "Label")
1570:         WITH THIS.lbl_4c_Label8
1571:             .Top        = 129
1572:             .Left       = 12
1573:             .Width      = 123
1574:             .Height     = 15
1575:             .AutoSize   = .T.
1576:             .BackStyle  = 0
1577:             .FontName   = "Tahoma"
1578:             .FontSize   = 8
1579:             .FontBold   = .F.

*-- Linhas 1642 a 1719:
1642:     * veda (ButtonsValue = N para N>1, que faz todos os botoes
1643:     * aparecerem marcados de uma vez).
1644:     *
1645:     * OptionGroup nao tem ForeColor nem ControlCount (confirmado no mesmo
1646:     * arquivo de propriedades) - a cor mora nos ButtonsForeColor, e a
1647:     * recursao de TornarControlesVisiveis para no proprio grupo (o
1648:     * PEMSTATUS de ControlCount devolve .F.), exatamente como em
1649:     * CommandGroup.
1650:     *==========================================================================
1651:     PROTECTED PROCEDURE ConfigurarGruposTipoPrecoPeso()
1652:         THIS.AddObject("shp_4c_Shape2", "Shape")
1653:         WITH THIS.shp_4c_Shape2
1654:             .Top           = 394
1655:             .Left          = 6
1656:             .Width         = 191
1657:             .Height        = 201
1658:             .BackStyle     = 0
1659:             .BorderWidth   = 2
1660:             .BorderColor   = RGB(90, 90, 90)
1661:             .SpecialEffect = 0
1662:             .Visible       = .T.
1663:         ENDWITH
1664: 
1665:         THIS.AddObject("shp_4c_Shape1", "Shape")
1666:         WITH THIS.shp_4c_Shape1
1667:             .Top           = 394
1668:             .Left          = 396
1669:             .Width         = 192
1670:             .Height        = 201
1671:             .BackStyle     = 0
1672:             .BorderWidth   = 2
1673:             .BorderColor   = RGB(90, 90, 90)
1674:             .SpecialEffect = 0
1675:             .Visible       = .T.
1676:         ENDWITH
1677: 
1678:         *-- Opt_Tipo: unico botao do SCX - o resto chega via LocalTpEti (Fase 7)
1679:         THIS.AddObject("obj_4c_Opt_Tipo", "OptionGroup")
1680:         WITH THIS.obj_4c_Opt_Tipo
1681:             .ButtonCount   = 1
1682:             .Top           = 412
1683:             .Left          = 11
1684:             .Width         = 181
1685:             .Height        = 173
1686:             .AutoSize      = .F.
1687:             .BackStyle     = 0
1688:             .BorderStyle   = 0
1689:             .SpecialEffect = 1
1690:             .BorderColor   = RGB(36, 84, 155)
1691:             .Themes        = .F.
1692:             .Value         = 1
1693:             .Visible       = .T.
1694:         ENDWITH
1695: 
1696:         WITH THIS.obj_4c_Opt_Tipo.Buttons(1)
1697:             .Top       = -1
1698:             .Left      = 4
1699:             .Width     = 150
1700:             .Height    = 17
1701:             .Style     = 0
1702:             .FontName  = "Tahoma"
1703:             .FontSize  = 8
1704:             .BackStyle = 0
1705:             .ForeColor = RGB(90, 90, 90)
1706:             .Caption   = "\<a. Rabicho"
1707:             .Value     = 1
1708:             .TabIndex  = 1
1709:         ENDWITH
1710: 
1711:         THIS.AddObject("lbl_4c_Label1", "Label")
1712:         WITH THIS.lbl_4c_Label1
1713:             .Top        = 397
1714:             .Left       = 14
1715:             .Width      = 93
1716:             .Height     = 15
1717:             .AutoSize   = .T.
1718:             .BackStyle  = 0
1719:             .FontName   = "Tahoma"

*-- Linhas 1726 a 1769:
1726:         ENDWITH
1727: 
1728:         *-- Opt_Conjunto - Value=2 -> botao 2 ("Nao") selecionado por padrao
1729:         THIS.AddObject("obj_4c_Opt_Conjunto", "OptionGroup")
1730:         WITH THIS.obj_4c_Opt_Conjunto
1731:             .ButtonCount = 2
1732:             .Top         = 393
1733:             .Left        = 466
1734:             .Width       = 106
1735:             .Height      = 26
1736:             .AutoSize    = .F.
1737:             .BackStyle   = 0
1738:             .BorderStyle = 0
1739:             .Value       = 2
1740:             .Visible     = .T.
1741:         ENDWITH
1742: 
1743:         WITH THIS.obj_4c_Opt_Conjunto.Buttons(1)
1744:             .Top       = 7
1745:             .Left      = 8
1746:             .Width     = 34
1747:             .Height    = 15
1748:             .Style     = 0
1749:             .AutoSize  = .T.
1750:             .FontName  = "Tahoma"
1751:             .FontSize  = 8
1752:             .BackStyle = 0
1753:             .ForeColor = RGB(90, 90, 90)
1754:             .Caption   = "Sim"
1755:             .Value     = 0
1756:         ENDWITH
1757: 
1758:         WITH THIS.obj_4c_Opt_Conjunto.Buttons(2)
1759:             .Top       = 7
1760:             .Left      = 61
1761:             .Width     = 37
1762:             .Height    = 15
1763:             .Style     = 0
1764:             .AutoSize  = .T.
1765:             .FontName  = "Tahoma"
1766:             .FontSize  = 8
1767:             .BackStyle = 0
1768:             .ForeColor = RGB(90, 90, 90)
1769:             .Caption   = "N" + CHR(227) + "o"

*-- Linhas 1788 a 1831:
1788:         ENDWITH
1789: 
1790:         *-- opt_Preco: 6 botoes (Sim/Nao/Ideal/Atual/Preco DE\Por/Parcelamento)
1791:         THIS.AddObject("obj_4c_Opt_Preco", "OptionGroup")
1792:         WITH THIS.obj_4c_Opt_Preco
1793:             .ButtonCount = 6
1794:             .Top         = 416
1795:             .Left        = 467
1796:             .Width       = 111
1797:             .Height      = 112
1798:             .AutoSize    = .F.
1799:             .BackStyle   = 0
1800:             .BorderStyle = 0
1801:             .Value       = 1
1802:             .Visible     = .T.
1803:         ENDWITH
1804: 
1805:         WITH THIS.obj_4c_Opt_Preco.Buttons(1)
1806:             .Top       = 7
1807:             .Left      = 8
1808:             .Width     = 34
1809:             .Height    = 15
1810:             .Style     = 0
1811:             .AutoSize  = .T.
1812:             .FontName  = "Tahoma"
1813:             .FontSize  = 8
1814:             .BackStyle = 0
1815:             .ForeColor = RGB(90, 90, 90)
1816:             .Caption   = "Sim"
1817:             .Value     = 1
1818:         ENDWITH
1819: 
1820:         WITH THIS.obj_4c_Opt_Preco.Buttons(2)
1821:             .Top       = 7
1822:             .Left      = 61
1823:             .Width     = 37
1824:             .Height    = 15
1825:             .Style     = 0
1826:             .AutoSize  = .T.
1827:             .FontName  = "Tahoma"
1828:             .FontSize  = 8
1829:             .BackStyle = 0
1830:             .ForeColor = RGB(90, 90, 90)
1831:             .Caption   = "N" + CHR(227) + "o"

*-- Linhas 1905 a 1948:
1905:         ENDWITH
1906: 
1907:         *-- opt_peso: 2 botoes (Sim/Nao)
1908:         THIS.AddObject("obj_4c_Opt_peso", "OptionGroup")
1909:         WITH THIS.obj_4c_Opt_peso
1910:             .ButtonCount = 2
1911:             .Top         = 513
1912:             .Left        = 467
1913:             .Width       = 100
1914:             .Height      = 26
1915:             .AutoSize    = .F.
1916:             .BackStyle   = 0
1917:             .BorderStyle = 0
1918:             .Value       = 1
1919:             .Visible     = .T.
1920:         ENDWITH
1921: 
1922:         WITH THIS.obj_4c_Opt_peso.Buttons(1)
1923:             .Top        = 7
1924:             .Left       = 8
1925:             .Width      = 34
1926:             .Height     = 15
1927:             .Style      = 0
1928:             .AutoSize   = .T.
1929:             .FontName   = "Tahoma"
1930:             .FontSize   = 8
1931:             .FontItalic = .F.
1932:             .BackStyle  = 0
1933:             .ForeColor  = RGB(90, 90, 90)
1934:             .Caption    = "Sim"
1935:             .Value      = 1
1936:         ENDWITH
1937: 
1938:         WITH THIS.obj_4c_Opt_peso.Buttons(2)
1939:             .Top        = 7
1940:             .Left       = 61
1941:             .Width      = 37
1942:             .Height     = 15
1943:             .Style      = 0
1944:             .AutoSize   = .T.
1945:             .FontName   = "Tahoma"
1946:             .FontSize   = 8
1947:             .FontItalic = .F.
1948:             .BackStyle  = 0

*-- Linhas 1978 a 2084:
1978:     *
1979:     * Cnt_Impressora (Top 521 / Left 593 / Width 398 / Height 73) eh o
1980:     * container com a configuracao fisica da impressora: Opcao_imp
1981:     * (OptionGroup de 3 botoes - Allegro/Zebra ZPL/Zebra EPL), os 4
1982:     * Spinner de ajuste (Vert/Horz/Dens/Velo) com seus Say ao lado, e
1983:     * Chk_Resete (oculto - excecao de TornarControlesVisiveis). TabIndex
1984:     * dos filhos TRANSCRITO literal do dump: eh escopo PROPRIO do
1985:     * container (regra CLAUDE.md #29/sub-regra de Buttons - mesmo
1986:     * raciocinio vale para TabIndex de filho de Container), e a sequencia
1987:     * 2..11 do dump nao tem duplicata nenhuma - diferente do que acontece
1988:     * nos controles diretos do FORM (ver AjustarOrdemTabulacao).
1989:     *
1990:     * SpinnerHighValue/SpinnerLowValue TRANSCRITOS sem a parte decimal
1991:     * ".00" do dump (sao os mesmos 999/0/20/10/3/1 - o VFP exibe Spinner
1992:     * como float, o literal eh so formatacao do Form Designer).
1993:     *
1994:     * Opt_Impressora (Visible = .F. SEMPRE, nunca reativado - ver nota no
1995:     * cabecalho do arquivo) e Label2 ("Impressoras") sao TRANSCRITOS tal
1996:     * qual o dump.
1997:     *
1998:     * Get_Printer (ComboBox, Style = 2) nasce com RowSourceType = 0 e
1999:     * RowSource = "" - o bind ao alias crImpreV eh feito em
2000:     * CarregarImpressorasEtiqueta (Fase 8), quando o cursor passa a
2001:     * existir. As
2002:     * demais propriedades (BoundColumn, DisabledBackColor/ForeColor,
2003:     * BorderColor, Style) sao TRANSCRITAS do dump e nao dependem do alias.
2004:     *
2005:     * Label5 ("Sistema") e Label6 ("Windows") sao os dois rotulos acima do
2006:     * combo - Label6 recebe RGB(90,90,90) em vez do RGB(231,254,253)
2007:     * quase-branco do dump (regra CLAUDE.md #12, excecao "escurecer p/ cor
2008:     * das labels irmas" - a irma eh Label5).
2009:     *
2010:     * Say5 ("Posicao :") e spn_posetiq ficam no Shape2 (Opt_Tipo), nao no
2011:     * Shape3: Top 549..554 / Left 412..477, dentro da faixa 394..595 Left
2012:     * 6..197 do Shape2 (Fase 5). O nome migrado de Say5 eh "lbl_4c_Say5"
2013:     * e NAO "lbl_4c_Label5" (que ja pertence a Label5, "Sistema") - ver a
2014:     * nota de colisao de mapeamento.json no cabecalho do arquivo.
2015:     *==========================================================================
2016:     PROTECTED PROCEDURE ConfigurarImpressora()
2017:         THIS.AddObject("shp_4c_Shape3", "Shape")
2018:         WITH THIS.shp_4c_Shape3
2019:             .Top           = 394
2020:             .Left          = 201
2021:             .Width         = 191
2022:             .Height        = 201
2023:             .BackStyle     = 0
2024:             .BorderWidth   = 2
2025:             .BorderColor   = RGB(90, 90, 90)
2026:             .SpecialEffect = 0
2027:             .Visible       = .T.
2028:         ENDWITH
2029: 
2030:         THIS.AddObject("cnt_4c__Impressora", "Container")
2031:         WITH THIS.cnt_4c__Impressora
2032:             .Top           = 521
2033:             .Left          = 593
2034:             .Width         = 398
2035:             .Height        = 73
2036:             .BackStyle     = 0
2037:             .BorderWidth   = 2
2038:             .SpecialEffect = 2
2039:             .BorderColor   = RGB(90, 90, 90)
2040:             .Visible       = .T.
2041:         ENDWITH
2042: 
2043:         *-- Opcao_imp: 3 impressoras (Allegro / Zebra ZPL / Zebra EPL)
2044:         THIS.cnt_4c__Impressora.AddObject("obj_4c_Opcao_imp", "OptionGroup")
2045:         WITH THIS.cnt_4c__Impressora.obj_4c_Opcao_imp
2046:             .ButtonCount = 3
2047:             .Top         = 4
2048:             .Left        = 5
2049:             .Width       = 76
2050:             .Height      = 63
2051:             .AutoSize    = .T.
2052:             .BackStyle   = 0
2053:             .BorderStyle = 0
2054:             .TabIndex    = 2
2055:             .Visible     = .T.
2056:         ENDWITH
2057: 
2058:         WITH THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Buttons(1)
2059:             .Top       = 5
2060:             .Left      = 5
2061:             .Width     = 51
2062:             .Height    = 15
2063:             .Style     = 0
2064:             .AutoSize  = .T.
2065:             .FontName  = "Tahoma"
2066:             .FontSize  = 8
2067:             .BackStyle = 0
2068:             .ForeColor = RGB(90, 90, 90)
2069:             .Caption   = "Allegro"
2070:         ENDWITH
2071: 
2072:         WITH THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Buttons(2)
2073:             .Top       = 24
2074:             .Left      = 5
2075:             .Width     = 66
2076:             .Height    = 15
2077:             .Style     = 0
2078:             .AutoSize  = .T.
2079:             .FontName  = "Tahoma"
2080:             .FontSize  = 8
2081:             .BackStyle = 0
2082:             .ForeColor = RGB(90, 90, 90)
2083:             .Caption   = "Zebra ZPL"
2084:         ENDWITH

*-- Linhas 2220 a 2289:
2220:         ENDWITH
2221: 
2222:         *-- Chk_Resete: oculto (dump Visible = .F.) - excecao de
2223:         *-- TornarControlesVisiveis. O Click de Opcao_imp que o esconde de
2224:         *-- novo (This.Parent.Chk_Resete.Visible = .f., Fase 7 -
2225:         *-- OpcaoImpClick) existe; o que o REABRE eh fCarregarImps, funcao
2226:         *-- global que nao veio no acervo (regra CLAUDE.md #27) - fica
2227:         *-- oculto para sempre, mesma omissao de ValidarImpressoraSelecio-
2228:         *-- nada/CarregarAjustesImpressora.
2229:         THIS.cnt_4c__Impressora.AddObject("chk_4c_Chk_Resete", "CheckBox")
2230:         WITH THIS.cnt_4c__Impressora.chk_4c_Chk_Resete
2231:             .Top       = 49
2232:             .Left      = 104
2233:             .Width     = 135
2234:             .Height    = 15
2235:             .FontName  = "Tahoma"
2236:             .FontSize  = 8
2237:             .AutoSize  = .T.
2238:             .Alignment = 0
2239:             .BackStyle = 0
2240:             .ForeColor = RGB(90, 90, 90)
2241:             .Caption   = 'Enviar Comando "Reset"'
2242:             .Value     = 0
2243:             .TabIndex  = 11
2244:             .Visible   = .F.
2245:         ENDWITH
2246: 
2247:         *-- Opt_Impressora: morto desde "mena - 05/03/2015" (ver nota no
2248:         *-- cabecalho). Visible = .F. SEMPRE.
2249:         THIS.AddObject("obj_4c_Opt_Impressora", "OptionGroup")
2250:         WITH THIS.obj_4c_Opt_Impressora
2251:             .ButtonCount   = 1
2252:             .Top           = 554
2253:             .Left          = 206
2254:             .Width         = 181
2255:             .Height        = 36
2256:             .AutoSize      = .F.
2257:             .BackStyle     = 0
2258:             .BorderStyle   = 0
2259:             .SpecialEffect = 1
2260:             .BorderColor   = RGB(90, 90, 90)
2261:             .Themes        = .F.
2262:             .Value         = 1
2263:             .Visible       = .F.
2264:         ENDWITH
2265: 
2266:         WITH THIS.obj_4c_Opt_Impressora.Buttons(1)
2267:             .Top       = 10
2268:             .Left      = 2
2269:             .Width     = 177
2270:             .Height    = 17
2271:             .Style     = 0
2272:             .FontName  = "Tahoma"
2273:             .FontSize  = 8
2274:             .BackStyle = 0
2275:             .ForeColor = RGB(90, 90, 90)
2276:             .Caption   = "\<1. Gen" + CHR(233) + "rico/Somente Texto"
2277:             .Value     = 1
2278:             .TabIndex  = 1
2279:         ENDWITH
2280: 
2281:         THIS.AddObject("lbl_4c_Label2", "Label")
2282:         WITH THIS.lbl_4c_Label2
2283:             .Top        = 397
2284:             .Left       = 209
2285:             .Width      = 74
2286:             .Height     = 15
2287:             .AutoSize   = .T.
2288:             .BackStyle  = 0
2289:             .FontName   = "Tahoma"

*-- Linhas 2404 a 2447:
2404:     * (BackStyle 0, BorderWidth 2, BorderColor 90,90,90) - unica diferenca
2405:     * eh a geometria, TRANSCRITA do dump.
2406:     *==========================================================================
2407:     PROTECTED PROCEDURE ConfigurarOcorrenciaEJustificativa()
2408:         THIS.this_lGravaOcorrencia = .F.
2409: 
2410:         THIS.AddObject("shp_4c_ShpOcoEtiqs", "Shape")
2411:         WITH THIS.shp_4c_ShpOcoEtiqs
2412:             .Top           = 464
2413:             .Left          = 593
2414:             .Width         = 398
2415:             .Height        = 53
2416:             .BackStyle     = 0
2417:             .BorderWidth   = 2
2418:             .BorderColor   = RGB(90, 90, 90)
2419:             .SpecialEffect = 0
2420:             .Visible       = .F.
2421:         ENDWITH
2422: 
2423:         THIS.AddObject("txt_4c_OcoEtiqs", "TextBox")
2424:         WITH THIS.txt_4c_OcoEtiqs
2425:             .Top               = 486
2426:             .Left              = 605
2427:             .Width             = 33
2428:             .Height            = 24
2429:             .FontName          = "Courier New"
2430:             .FontSize          = 9
2431:             .Format            = "K"
2432:             .Value             = ""
2433:             .DisabledBackColor = RGB(255, 255, 255)
2434:             .DisabledForeColor = RGB(0, 0, 128)
2435:             .Visible           = .F.
2436:         ENDWITH
2437: 
2438:         THIS.AddObject("txt_4c_DOcoEtiqs", "TextBox")
2439:         WITH THIS.txt_4c_DOcoEtiqs
2440:             .Top               = 486
2441:             .Left              = 641
2442:             .Width             = 337
2443:             .Height            = 24
2444:             .FontName          = "Courier New"
2445:             .FontSize          = 9
2446:             .Format            = "K"
2447:             .Value             = ""

*-- Linhas 2553 a 3088:
2553:     * devolve .T. mesmo para PROTECTED - o teste entraria no branch e a
2554:     * chamada estouraria em runtime (regras CLAUDE.md #3/#51).
2555:     *==========================================================================
2556:     PROCEDURE AjustarBotoesPorTipoChamador()
2557:         LOCAL loc_cTipoChamador, loc_oGrupo
2558: 
2559:         loc_cTipoChamador = ""
2560: 
2561:         IF VARTYPE(THIS.this_oFormAnterior) = "O"
2562:             IF PEMSTATUS(THIS.this_oFormAnterior, "Tipo", 5)
2563:                 IF VARTYPE(THIS.this_oFormAnterior.Tipo) = "C"
2564:                     loc_cTipoChamador = UPPER(ALLTRIM(THIS.this_oFormAnterior.Tipo))
2565:                 ENDIF
2566:             ENDIF
2567:         ENDIF
2568: 
2569:         loc_oGrupo = THIS.cmg_4c_CntBotoes
2570: 
2571:         *-- Legado: "Mostra os Quatro Botoes na Tela"
2572:         loc_oGrupo.Buttons(1).Enabled = .T.   && Boleto
2573:         loc_oGrupo.Buttons(2).Enabled = .T.   && Sair
2574:         loc_oGrupo.Buttons(3).Enabled = .T.   && Armazenar
2575:         loc_oGrupo.Buttons(4).Enabled = .T.   && Imprimir
2576: 
2577:         *-- Legado: If (ParentForm.Tipo <> 'CADASTRO') / btnDepois.Enabled = .F.
2578:         IF loc_cTipoChamador != "CADASTRO"
2579:             loc_oGrupo.Buttons(3).Enabled = .F.
2580:         ENDIF
2581:     ENDPROC
2582: 
2583:     *==========================================================================
2584:     * AjustarOrdemTabulacao - TabIndex dos filhos DIRETOS do form
2585:     *
2586:     * Com AddObject o VFP9 numera o TabIndex pela ORDEM DE CRIACAO, que nao
2587:     * tem relacao com a do legado. Divergencia aqui nao da erro, nao entra em
2588:     * log e nao aparece em screenshot - so o Tab andando na ordem errada.
2589:     *
2590:     * O dump esta LONGE de ser uma sequencia limpa 1..N: SO entre os
2591:     * controles filhos DIRETOS do form que de fato recebem foco (TextBox,
2592:     * EditBox, ComboBox, Spinner, OptionGroup, CommandGroup, Grid - Label e
2593:     * Shape NAO tem TabStop, regra ja registrada no gemeo FormSIGOPGRC), o
2594:     * TabIndex = 10 aparece em QUATRO controles (opt_Preco, spn_posetiq,
2595:     * opt_peso, Opt_Conjunto), o 1 em dois (cntBotoes, Get_Printer), o 2 em
2596:     * dois (grd_historico, cmdTestaPos), o 4 em dois (getQtParcs,
2597:     * getOcoEtiqs), o 7 em dois (GetJustifs, GetTexto) e o 9 em dois
2598:     * (Opt_Impressora, Say5) - sintoma de retrabalho do form ao longo dos
2599:     * anos (os comentarios "mena" no dump vao de 2014 a 2016).
2600:     *
2601:     * Como nao ha como recuperar a intencao original dessas duplicatas, a
2602:     * ordem final abaixo resolve o EMPATE pelo Top do dump (controle mais
2603:     * acima primeiro) - mesmo criterio que a ferramenta "Set Tab Order" do
2604:     * Form Designer usa ao preencher automaticamente. Os valores atribuidos
2605:     * sao os ORDINAIS EFETIVOS (1..16), nao os literais do dump, e em ordem
2606:     * ASCENDENTE: cada atribuicao poe o controle na posicao pedida e empurra
2607:     * os demais para tras (mesma mecanica de insercao do Column.ColumnOrder
2608:     * em FormatarColunasGrade) - ordem descendente trocaria pares de lugar.
2609:     *
2610:     *   1  cmg_4c_CntBotoes      (TabIndex 1, Top -2)
2611:     *   2  cbo_4c_Get_Printer    (TabIndex 1, Top 434)
2612:     *   3  cmg_4c_CmdTestaPos    (TabIndex 2, Top -2)
2613:     *   4  grd_4c_Dados          (TabIndex 2, Top 147)
2614:     *   5  txt_4c_QtParcs        (TabIndex 4, Top 120)
2615:     *   6  txt_4c_OcoEtiqs       (TabIndex 4, Top 486)
2616:     *   7  txt_4c_DOcoEtiqs      (TabIndex 5, Top 486)
2617:     *   8  obj_4c_GetTexto       (TabIndex 7, Top 83)
2618:     *   9  obj_4c_GetJustifs     (TabIndex 7, Top 413)
2619:     *   10 obj_4c_Opt_Tipo       (TabIndex 8, Top 412)
2620:     *   11 obj_4c_Opt_Impressora (TabIndex 9, Top 554 - oculto; mantido na
2621:     *                             sequencia so para a numeracao nao pular)
2622:     *   12 obj_4c_Opt_Conjunto   (TabIndex 10, Top 393)
2623:     *   13 obj_4c_Opt_Preco      (TabIndex 10, Top 416)
2624:     *   14 obj_4c_Opt_peso       (TabIndex 10, Top 513)
2625:     *   15 obj_4c_Spn_posetiq    (TabIndex 10, Top 549)
2626:     *   16 cnt_4c__Impressora    (TabIndex 12, Top 521)
2627:     *
2628:     * txt_4c_OcoEtiqs/txt_4c_DOcoEtiqs/obj_4c_GetJustifs ficam na faixa
2629:     * normal de TabIndex mesmo nascendo Visible = .F.: controle oculto
2630:     * continua tendo TabIndex (o Tab so pula ele em runtime, por nao estar
2631:     * Visible), e e exatamente isso que a Fase 7 precisa quando os
2632:     * reexibir - TabIndex fixado agora, sem depender de mais nenhum
2633:     * AddObject.
2634:     *
2635:     * cnt_4c__Impressora.TabIndex eh o ultimo da lista porque o TabIndex de
2636:     * um Container eh escopo PROPRIO (o Tab entra nos filhos dele, numerados
2637:     * em ConfigurarImpressora) - a posicao 16 so decide QUANDO o foco entra
2638:     * no container em relacao aos outros 15, nao a ordem interna.
2639:     *==========================================================================
2640:     PROTECTED PROCEDURE AjustarOrdemTabulacao()
2641:         THIS.cmg_4c_CntBotoes.TabIndex      = 1
2642:         THIS.cbo_4c_Get_Printer.TabIndex    = 2
2643:         THIS.cmg_4c_CmdTestaPos.TabIndex    = 3
2644:         THIS.grd_4c_Dados.TabIndex          = 4
2645:         THIS.txt_4c_QtParcs.TabIndex        = 5
2646:         THIS.txt_4c_OcoEtiqs.TabIndex       = 6
2647:         THIS.txt_4c_DOcoEtiqs.TabIndex      = 7
2648:         THIS.obj_4c_GetTexto.TabIndex       = 8
2649:         THIS.obj_4c_GetJustifs.TabIndex     = 9
2650:         THIS.obj_4c_Opt_Tipo.TabIndex       = 10
2651:         THIS.obj_4c_Opt_Impressora.TabIndex = 11
2652:         THIS.obj_4c_Opt_Conjunto.TabIndex   = 12
2653:         THIS.obj_4c_Opt_Preco.TabIndex      = 13
2654:         THIS.obj_4c_Opt_peso.TabIndex       = 14
2655:         THIS.obj_4c_Spn_posetiq.TabIndex    = 15
2656:         THIS.cnt_4c__Impressora.TabIndex    = 16
2657:     ENDPROC
2658: 
2659:     *==========================================================================
2660:     * TornarControlesVisiveis - repoe Visible = .T. apos os AddObject
2661:     *
2662:     * AddObject cria todo controle com Visible = .F., e a recursao alcanca
2663:     * os filhos do container. Nao ha lista de excecao ate a Fase 5: dos
2664:     * controles criados ate aqui - faixa do cabecalho, grade, os dois
2665:     * CommandGroup e os grupos de Tipo/Preco/Peso/Conjunto + texto livre -
2666:     * nenhum nasce oculto no dump.
2667:     *
2668:     * A lista de excecao EH OBRIGATORIA a partir desta fase: o dump declara
2669:     * Visible = .F. em Opt_Impressora e em Cnt_Impressora.Chk_Resete, e o
2670:     * Init legado esconde mais sete controles (getOcoEtiqs, getDOcoEtiqs,
2671:     * lblOcoEtiqs, shpOcoEtiqs, getJustifs, lblJustifs, shpJustifs) para so
2672:     * reexibi-los sob condicao (ver ConfigurarOcorrenciaEJustificativa). Sem
2673:     * a excecao, o loop generico forcaria Visible = .T. nos nove e exporia
2674:     * blocos que o legado mantem fechados.
2675:     *
2676:     * A excecao eh pelo NOME MIGRADO (nunca pelo nome legado, que nao existe
2677:     * mais em runtime): checa o Name do objeto, nao o caminho completo,
2678:     * porque a recursao chega a eles a partir de containers diferentes
2679:     * (Cnt_Impressora.Chk_Resete via THIS.cnt_4c__Impressora, os outros
2680:     * oito direto em THIS).
2681:     *
2682:     * A recursao para sozinha na grade e nos CommandGroup/OptionGroup:
2683:     * nenhuma dessas base classes tem ControlCount (Grid expoe
2684:     * Columns/Objects, CommandGroup/OptionGroup expoem Buttons/Objects),
2685:     * entao o PEMSTATUS do guard devolve .F. e o metodo nao desce nelas - o
2686:     * que esta correto, porque as propriedades dos Buttons, das Column, dos
2687:     * Header1/Text1 e do CheckBox da coluna de marcacao sao definidas uma a
2688:     * uma em ConfigurarGrade / FormatarColunasGrade / ConfigurarBotoes /
2689:     * ConfigurarGruposTipoPrecoPeso / ConfigurarImpressora.
2690:     *
2691:     * PEMSTATUS eh usado sobre OBJETO (nunca sobre alias de cursor, onde
2692:     * dispara erro 11), e o guard de ControlCount > 0 evita descer em
2693:     * controle folha.
2694:     *==========================================================================
2695:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2696:         LOCAL loc_nI, loc_oControl
2697: 
2698:         IF VARTYPE(par_oContainer) != "O"
2699:             RETURN
2700:         ENDIF
2701: 
2702:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2703:             loc_oControl = par_oContainer.Controls(loc_nI)
2704: 
2705:             IF VARTYPE(loc_oControl) = "O"
2706:                 IF !INLIST(UPPER(loc_oControl.Name), ;
2707:                         "OBJ_4C_OPT_IMPRESSORA", "CHK_4C_CHK_RESETE", ;
2708:                         "TXT_4C_OCOETIQS", "TXT_4C_DOCOETIQS", ;
2709:                         "LBL_4C_LBLOCOETIQS", "SHP_4C_SHPOCOETIQS", ;
2710:                         "OBJ_4C_GETJUSTIFS", "LBL_4C_LBLJUSTIFS", ;
2711:                         "SHP_4C_SHPJUSTIFS")
2712:                     IF PEMSTATUS(loc_oControl, "Visible", 5)
2713:                         loc_oControl.Visible = .T.
2714:                     ENDIF
2715:                 ENDIF
2716: 
2717:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5)
2718:                     IF loc_oControl.ControlCount > 0
2719:                         THIS.TornarControlesVisiveis(loc_oControl)
2720:                     ENDIF
2721:                 ENDIF
2722:             ENDIF
2723:         ENDFOR
2724:     ENDPROC
2725: 
2726:     *==========================================================================
2727:     * Destroy - solta as referencias, reabilita o form chamador e repoe o
2728:     * menu do sistema
2729:     *
2730:     * Reabilitar par_oFormAnterior aqui eh rede de seguranca (ver contrato
2731:     * no cabecalho do arquivo): os handlers de botao das fases 7/8 ja
2732:     * reabilitam no proprio Click, e quando essas fases existirem esta
2733:     * linha sera no-op (Enabled ja .T.).
2734:     *
2735:     * O cursor da grade EH fechado aqui, e isso eh especifico desta tela: ele
2736:     * nasce no proprio form (ver CriarCursorEtiquetas) e nao eh lido por
2737:     * ninguem depois que a tela fecha - diferente do dbImpressao, que vem do
2738:     * form chamador e por isso NAO se mexe. Como o form tem DataSession = 1,
2739:     * o alias vive na sessao CORRENTE e nao seria recolhido sozinho ao fechar:
2740:     * deixado aberto, ele faria a proxima abertura da tela esbarrar no alias
2741:     * da anterior.
2742:     *
2743:     * O guard de Buffering antes do TABLEREVERT nao eh defensividade solta:
2744:     * TABLEREVERT sem buffering nao eh no-op, dispara erro 1586 ("Function
2745:     * requires row or table buffering mode"), e cursor criado por
2746:     * CREATE CURSOR nasce com Buffering = 1 - ou seja, o caminho normal eh
2747:     * justamente o que estouraria. USE IN fecha o alias mesmo com buffer
2748:     * sujo (regra CLAUDE.md #52).
2749:     *
2750:     * DODEFAULT() eh a ULTIMA linha, obrigatoriamente: FormBase.Destroy faz
2751:     * o SET SYSMENU TO DEFAULT + RELEASE POPUP + CriarMenuPrincipal() que
2752:     * repoe os pads do menu principal - sem ele o menu do sistema aparece
2753:     * encolhido.
2754:     *==========================================================================
2755:     PROCEDURE Destroy()
2756:         IF USED(THIS.this_cCursorEtiquetas)
2757:             IF CURSORGETPROP("Buffering", THIS.this_cCursorEtiquetas) > 1
2758:                 TABLEREVERT(.T., THIS.this_cCursorEtiquetas)
2759:             ENDIF
2760:             USE IN (THIS.this_cCursorEtiquetas)
2761:         ENDIF
2762: 
2763:         IF VARTYPE(THIS.this_oFormAnterior) = "O"
2764:             IF PEMSTATUS(THIS.this_oFormAnterior, "Enabled", 5)
2765:                 THIS.this_oFormAnterior.Enabled = .T.
2766:             ENDIF
2767:         ENDIF
2768: 
2769:         THIS.this_oFormAnterior   = .NULL.
2770:         THIS.this_oBusinessObject = .NULL.
2771: 
2772:         DODEFAULT()
2773:     ENDPROC
2774: 
2775:     *==========================================================================
2776:     * ObterTipoChamador - this_oFormAnterior.Tipo com guarda dupla (o
2777:     * chamador eh arbitrario - mesma guarda de AjustarBotoesPorTipoChamador,
2778:     * extraida aqui porque a Fase 7 passa a consultar o Tipo em varios
2779:     * pontos: redirecionamento de foco da grade (modo DIGITACAO), Boleto/
2780:     * Armazenar (modo ARQUIVADAS/CADASTRO) e a geracao de operacao).
2781:     *==========================================================================
2782:     PROTECTED PROCEDURE ObterTipoChamador()
2783:         LOCAL loc_cTipo
2784: 
2785:         loc_cTipo = ""
2786: 
2787:         IF VARTYPE(THIS.this_oFormAnterior) = "O"
2788:             IF PEMSTATUS(THIS.this_oFormAnterior, "Tipo", 5)
2789:                 IF VARTYPE(THIS.this_oFormAnterior.Tipo) = "C"
2790:                     loc_cTipo = UPPER(ALLTRIM(THIS.this_oFormAnterior.Tipo))
2791:                 ENDIF
2792:             ENDIF
2793:         ENDIF
2794: 
2795:         RETURN loc_cTipo
2796:     ENDPROC
2797: 
2798:     *==========================================================================
2799:     * ObterNomeImpressoraAtual - nome da impressora do WINDOWS (crImpreV.
2800:     * impres) corrente no combo Get_Printer. crImpreV so existe a partir do
2801:     * Init legado reescrito na Fase 8 (enumeracao de impressoras + CURSOR
2802:     * local) - ate la, "" (nenhuma impressora escolhida), que SigOpEtq trata
2803:     * como ausencia de nome, mesmo efeito do combo abrindo na linha em
2804:     * branco que o legado insere de proposito quando ha mais de uma
2805:     * impressora.
2806:     *==========================================================================
2807:     PROTECTED PROCEDURE ObterNomeImpressoraAtual()
2808:         LOCAL loc_cNome
2809: 
2810:         loc_cNome = ""
2811: 
2812:         IF USED("crImpreV") AND !EOF("crImpreV")
2813:             loc_cNome = ALLTRIM(crImpreV.impres)
2814:         ENDIF
2815: 
2816:         RETURN loc_cNome
2817:     ENDPROC
2818: 
2819:     *==========================================================================
2820:     * ConfigurarEventosPrincipais - BINDEVENT dos botoes/grade/combos/
2821:     * lookups da Fase 7. PEMSTATUS guarda cada alvo (regra CLAUDE.md #33/
2822:     * #38): se uma fase futura mudar nome/ordem de montagem, o bind so pula
2823:     * o que faltar, em vez de derrubar o Init inteiro.
2824:     *
2825:     * Opt_Impressora.InteractiveChange NAO eh ligado: o corpo inteiro do
2826:     * metodo legado esta comentado com "*!*" (morto desde "mena -
2827:     * 05/03/2015" - ver nota no cabecalho do arquivo) - a transcricao fiel
2828:     * de "nenhuma linha ativa" eh nao criar handler nenhum, nao um metodo
2829:     * vazio (regra de completude - metodo vazio seria stub).
2830:     *
2831:     * getQtParcs/GetJustifs/GetTexto/Opt_Conjunto.When NAO sao ligados:
2832:     * BINDEVENT descarta o valor de retorno de eventos que o VFP9 usa para
2833:     * decidir comportamento (When/Valid) em objetos NAO subclassados -
2834:     * mesma razao pela qual a Column4/Column10 da grade precisaram de
2835:     * subclasse propria (TextBoxCodBarrasIpE_4c/TextBoxParcelasIpE_4c, fim
2836:     * deste arquivo). Dos quatro, tres retornam SEMPRE .T. no legado
2837:     * (nenhum efeito pratico mesmo la); so Opt_Conjunto.When restringe
2838:     * (modo DIGITACAO) - UX secundaria, nao corrigida aqui por exigir outra
2839:     * subclasse (OptionGroup) so para isso.
2840:     *==========================================================================
2841:     PROTECTED PROCEDURE ConfigurarEventosPrincipais()
2842:         LOCAL loc_oGrid, loc_oErro
2843: 
2844:         TRY
2845:             IF PEMSTATUS(THIS, "cmg_4c_CntBotoes", 5)
2846:                 BINDEVENT(THIS.cmg_4c_CntBotoes.Buttons(1), "Click", THIS, "BtnBoletoClick")
2847:                 BINDEVENT(THIS.cmg_4c_CntBotoes.Buttons(2), "Click", THIS, "BtnSairClick")
2848:                 BINDEVENT(THIS.cmg_4c_CntBotoes.Buttons(3), "Click", THIS, "BtnDepoisClick")
2849:                 BINDEVENT(THIS.cmg_4c_CntBotoes.Buttons(4), "Click", THIS, "BtnImprimeClick")
2850:             ENDIF
2851: 
2852:             IF PEMSTATUS(THIS, "cmg_4c_CmdTestaPos", 5)
2853:                 BINDEVENT(THIS.cmg_4c_CmdTestaPos.Buttons(1), "Click", THIS, "BtnPosicaoClick")
2854:             ENDIF
2855: 
2856:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2857:                 loc_oGrid = THIS.grd_4c_Dados
2858: 
2859:                 BINDEVENT(loc_oGrid.Column2.Header1, "Click", THIS, "GradeMarcarDesmarcarTodosClick")
2860: 
2861:                 BINDEVENT(loc_oGrid.Column2.chk_4c_Check1, "Click",     THIS, "GradeCheckMarcarClick")
2862:                 BINDEVENT(loc_oGrid.Column2.chk_4c_Check1, "MouseDown", THIS, "GradeCheckMarcarMouseDown")
2863:                 BINDEVENT(loc_oGrid.Column2.chk_4c_Check1, "MouseUp",   THIS, "GradeCheckMarcarMouseUp")
2864:                 BINDEVENT(loc_oGrid.Column2.chk_4c_Check1, "KeyPress",  THIS, "GradeCheckMarcarKeyPress")
2865: 
2866:                 *-- Legado: GotFocus de Column1/3/5/7/8.Text1 redireciona
2867:                 *-- para a Column4 (codigo de barras) em modo DIGITACAO.
2868:                 BINDEVENT(loc_oGrid.Column1.Text1, "GotFocus", THIS, "GradeRedirecionarParaColunaBarras")
2869:                 BINDEVENT(loc_oGrid.Column3.Text1, "GotFocus", THIS, "GradeRedirecionarParaColunaBarras")
2870:                 BINDEVENT(loc_oGrid.Column5.Text1, "GotFocus", THIS, "GradeRedirecionarParaColunaBarras")
2871:                 BINDEVENT(loc_oGrid.Column7.Text1, "GotFocus", THIS, "GradeRedirecionarParaColunaBarras")
2872:                 BINDEVENT(loc_oGrid.Column8.Text1, "GotFocus", THIS, "GradeRedirecionarParaColunaBarras")
2873:             ENDIF
2874: 
2875:             IF PEMSTATUS(THIS, "obj_4c_Opt_Tipo", 5)
2876:                 BINDEVENT(THIS.obj_4c_Opt_Tipo, "InteractiveChange", THIS, "OptTipoInteractiveChange")
2877:             ENDIF
2878: 
2879:             IF PEMSTATUS(THIS, "cnt_4c__Impressora", 5)
2880:                 BINDEVENT(THIS.cnt_4c__Impressora.obj_4c_Opcao_imp, "Click", THIS, "OpcaoImpClick")
2881:             ENDIF
2882: 
2883:             IF PEMSTATUS(THIS, "cbo_4c_Get_Printer", 5)
2884:                 BINDEVENT(THIS.cbo_4c_Get_Printer, "InteractiveChange", THIS, "GetPrinterInteractiveChange")
2885:             ENDIF
2886: 
2887:             IF PEMSTATUS(THIS, "txt_4c_OcoEtiqs", 5)
2888:                 BINDEVENT(THIS.txt_4c_OcoEtiqs, "LostFocus", THIS, "ValidarOcorrenciaEtiqueta")
2889:             ENDIF
2890: 
2891:             IF PEMSTATUS(THIS, "txt_4c_DOcoEtiqs", 5)
2892:                 BINDEVENT(THIS.txt_4c_DOcoEtiqs, "LostFocus", THIS, "ValidarOcorrenciaEtiqueta")
2893:             ENDIF
2894:         CATCH TO loc_oErro
2895:             THIS.this_cMensagemErro = loc_oErro.Message
2896:             MsgErro(loc_oErro.Message + CHR(13) + ;
2897:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2898:                 "Procedure: " + loc_oErro.Procedure, ;
2899:                 "FormSigOpIpE.ConfigurarEventosPrincipais")
2900:         ENDTRY
2901:     ENDPROC
2902: 
2903:     *==========================================================================
2904:     * BtnBoletoClick - cntBotoes.Buttons(1) ("Boleto"). Legado:
2905:     * btnBoleto.Click (dump 3735-3789). Confirma, monta a lista de empresas
2906:     * com etiqueta selecionada e dispara o script legado SigBlBol.Prg POR
2907:     * EMPRESA (boleto de reposicao de estoque arquivado).
2908:     *
2909:     * SigBlBol.Prg NAO veio no acervo (nao existe em projeto\app\ nem em
2910:     * Framework\) - TRY/CATCH por chamada para a ausencia aparecer como
2911:     * mensagem clara (regra CLAUDE.md #13/#27), em vez de interromper o
2912:     * loop inteiro ou falhar calado.
2913:     *==========================================================================
2914:     PROCEDURE BtnBoletoClick()
2915:         LOCAL loc_lConfirmou, loc_nResultado, loc_cEmpAtual, loc_cNomeImp, ;
2916:               loc_oProgresso, loc_oErro
2917: 
2918:         loc_lConfirmou = MsgConfirma("Confirma a Impress" + CHR(227) + "o do(s) Boleto(s)?", "Boleto")
2919: 
2920:         IF loc_lConfirmou
2921:             TRY
2922:                 IF THIS.ObterTipoChamador() == "ARQUIVADAS"
2923:                     THIS.this_lImpArquivadas = .T.
2924:                 ENDIF
2925: 
2926:                 IF USED("csEmpresas")
2927:                     USE IN csEmpresas
2928:                 ENDIF
2929:                 CREATE CURSOR csEmpresas (ImpEmps L(1), CEmps C(3), Razas C(40))
2930:                 INDEX ON CEmps TAG CEmps
2931: 
2932:                 IF USED("LocalEmp")
2933:                     USE IN LocalEmp
2934:                 ENDIF
2935:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2936:                     "SELECT Cemps, Razas FROM SigCdEmp WHERE Ativas = 1 ORDER BY Cemps", "LocalEmp")
2937: 
2938:                 IF loc_nResultado < 1
2939:                     MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalEmp)")
2940:                 ELSE
2941:                     SELECT LocalEmp
2942:                     SCAN
2943:                         IF !SEEK(LocalEmp.Cemps, "csEmpresas", "CEmps")
2944:                             INSERT INTO csEmpresas (ImpEmps, CEmps, Razas) ;
2945:                                 VALUES (.T., LocalEmp.Cemps, LocalEmp.Razas)
2946:                         ENDIF
2947:                     ENDSCAN
2948: 
2949:                     IF USED("csEmps")
2950:                         USE IN csEmps
2951:                     ENDIF
2952:                     SELECT CEmps FROM csEmpresas WHERE ImpEmps INTO CURSOR csEmps
2953:                     SELECT csEmps
2954: 
2955:                     loc_oProgresso = CREATEOBJECT("fwprogressbar", "Imprimindo Boletos...", RECCOUNT())
2956:                     loc_oProgresso.Show()
2957: 
2958:                     SCAN
2959:                         loc_cEmpAtual = csEmps.Cemps
2960:                         loc_oProgresso.SubTitulo.Caption = "Boleto da Empresa : " + loc_cEmpAtual
2961:                         loc_oProgresso.Update(.T.)
2962: 
2963:                         IF USED(THIS.this_cCursorEtiquetas)
2964:                             IF USED("TmpEtiquetas")
2965:                                 USE IN TmpEtiquetas
2966:                             ENDIF
2967:                             SELECT CBars FROM (THIS.this_cCursorEtiquetas) ;
2968:                                 WHERE Empos = loc_cEmpAtual ORDER BY CBars INTO CURSOR TmpEtiquetas
2969: 
2970:                             IF USED("TmpEtiquetas") AND RECCOUNT("TmpEtiquetas") > 0
2971:                                 loc_cNomeImp = THIS.ObterNomeImpressoraAtual()
2972: 
2973:                                 TRY
2974:                                     DO SigBlBol.Prg WITH 10, , loc_cEmpAtual, "", "", 0, 64, 1, loc_cNomeImp
2975:                                 CATCH TO loc_oErro
2976:                                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel emitir o boleto da " + ;
2977:                                         "empresa " + loc_cEmpAtual + ":" + CHR(13) + loc_oErro.Message, "Erro")
2978:                                 ENDTRY
2979:                             ENDIF
2980:                         ENDIF
2981:                     ENDSCAN
2982: 
2983:                     loc_oProgresso.Complete()
2984:                 ENDIF
2985:             CATCH TO loc_oErro
2986:                 MsgErro(loc_oErro.Message + CHR(13) + ;
2987:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em BtnBoletoClick")
2988:             ENDTRY
2989:         ENDIF
2990:     ENDPROC
2991: 
2992:     *==========================================================================
2993:     * BtnSairClick - cntBotoes.Buttons(2) ("Sair", Cancel=.T. - ESC da
2994:     * tela). Legado: btnSair.Click (dump 3792-3820). Se a sessao marcou
2995:     * ImpArquivadas (Boleto ou Imprimir/Armazenar com ParentForm.Tipo =
2996:     * 'ARQUIVADAS'), desfaz o flag ImpEtiqs das etiquetas da grade antes de
2997:     * fechar - pNot = .F. no legado, ou seja REPOE ImpEtiqs = 0 (nao .T.).
2998:     *==========================================================================
2999:     PROCEDURE BtnSairClick()
3000:         LOCAL loc_cCursor, loc_cSQL, loc_oErro
3001: 
3002:         TRY
3003:             loc_cCursor = THIS.this_cCursorEtiquetas
3004: 
3005:             IF THIS.this_lImpArquivadas AND USED(loc_cCursor)
3006:                 SELECT (loc_cCursor)
3007:                 SCAN
3008:                     loc_cSQL = "UPDATE SigCdPro SET ImpEtiqs = 0 WHERE CPros = " + ;
3009:                         EscaparSQL(ALLTRIM(EVALUATE(loc_cCursor + ".CPros")))
3010: 
3011:                     IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
3012:                         MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update - SigCdPro)")
3013:                     ENDIF
3014:                 ENDSCAN
3015:             ENDIF
3016:         CATCH TO loc_oErro
3017:             MsgErro(loc_oErro.Message, "Erro em BtnSairClick")
3018:         ENDTRY
3019: 
3020:         IF VARTYPE(THIS.this_oFormAnterior) = "O"
3021:             IF PEMSTATUS(THIS.this_oFormAnterior, "Enabled", 5)
3022:                 THIS.this_oFormAnterior.Enabled = .T.
3023:             ENDIF
3024:         ENDIF
3025: 
3026:         THIS.Release()
3027:     ENDPROC
3028: 
3029:     *==========================================================================
3030:     * BtnDepoisClick/BtnImprimeClick - cntBotoes.Buttons(3)/(4) ("Armazenar"
3031:     * / "Imprimir"). Legado: btnDepois.Click/btnImprime.Click (dump
3032:     * 3823-3835) - delegam inteiros para Impressao('A')/Impressao('I').
3033:     *==========================================================================
3034:     PROCEDURE BtnDepoisClick()
3035:         THIS.Impressao("A")
3036:     ENDPROC
3037: 
3038:     PROCEDURE BtnImprimeClick()
3039:         THIS.Impressao("I")
3040:     ENDPROC
3041: 
3042:     *==========================================================================
3043:     * BtnPosicaoClick - cmdTestaPos.Buttons(1) ("Testar Posicao"). Legado:
3044:     * btnPosicao.Click (dump 3845-3886) - imprime UMA etiqueta de teste
3045:     * (CBars fixo "99999999999999", tipo 99, impressora tipo 2) a partir do
3046:     * registro CORRENTE da grade, sem olhar Flag/selecao.
3047:     *==========================================================================
3048:     PROCEDURE BtnPosicaoClick()
3049:         LOCAL loc_nAjVerts, loc_nAjHorzs, loc_nAjDenss, loc_nAjVelos, loc_cNomeImp, ;
3050:               loc_lResete, loc_cCursor, loc_oErro
3051: 
3052:         TRY
3053:             THIS.GarantirCursorImpressao()
3054: 
3055:             loc_nAjVerts = THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Value
3056:             loc_nAjHorzs = THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Value
3057:             loc_nAjDenss = THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Value
3058:             loc_nAjVelos = THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Value
3059:             loc_lResete  = (THIS.cnt_4c__Impressora.chk_4c_Chk_Resete.Value = 1)
3060:             loc_cNomeImp = THIS.ObterNomeImpressoraAtual()
3061:             loc_cCursor  = THIS.this_cCursorEtiquetas
3062: 
3063:             SELECT dbImpressao
3064:             ZAP
3065: 
3066:             IF USED(loc_cCursor) AND !EOF(loc_cCursor)
3067:                 INSERT INTO dbImpressao (Cpros, Qtds, Cbars, Obs) ;
3068:                     VALUES (EVALUATE(loc_cCursor + ".CPros"), 1, 99999999999999, "")
3069:             ENDIF
3070: 
3071:             TRY
3072:                 SigOpEtq(gnConnHandle, .F., .F., 99, 2, loc_nAjVerts, loc_nAjHorzs, loc_nAjDenss, , , , ;
3073:                     loc_cNomeImp, .F., .F., loc_nAjVelos, .F., .F., .F., .F., .F., loc_lResete)
3074:             CATCH TO loc_oErro
3075:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel testar a posi" + CHR(231) + CHR(227) + ;
3076:                     "o:" + CHR(13) + loc_oErro.Message, "Erro")
3077:             ENDTRY
3078:         CATCH TO loc_oErro
3079:             MsgErro(loc_oErro.Message + CHR(13) + ;
3080:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em BtnPosicaoClick")
3081:         ENDTRY
3082:     ENDPROC
3083: 
3084:     *==========================================================================
3085:     * GarantirCursorImpressao - cria "dbImpressao" (nome LEGADO mantido de
3086:     * proposito - contrato entre forms, ver nota em this_cCursorEtiquetas)
3087:     * se ainda nao existir. O legado declara esse cursor com DUAS
3088:     * estruturas levemente diferentes conforme o metodo (Impressao: Cbars

*-- Linhas 3094 a 3612:
3094:     * UNIAO das duas larguras (a maior de cada campo) para nao truncar
3095:     * nenhum dos dois usos.
3096:     *==========================================================================
3097:     PROTECTED PROCEDURE GarantirCursorImpressao()
3098:         IF !USED("dbImpressao")
3099:             CREATE CURSOR dbImpressao ( ;
3100:                 CPros      C(14), ;
3101:                 Qtds       N(10, 3), ;
3102:                 QtdeEtiq   N(10, 3), ;
3103:                 Pedido     C(30), ;
3104:                 Obs        C(10), ;
3105:                 Cbars      N(16, 0), ;
3106:                 Pvens      N(12, 2), ;
3107:                 PrecoDe    N(12, 2), ;
3108:                 Parcelas   N(2, 0), ;
3109:                 Moedas     C(3), ;
3110:                 EmpDopNums C(29), ;
3111:                 Reffs      C(40), ;
3112:                 Empos      C(3), ;
3113:                 Cpros1     C(14), ;
3114:                 CodTams    C(4))
3115:         ENDIF
3116:     ENDPROC
3117: 
3118:     *==========================================================================
3119:     * GradeMarcarDesmarcarTodosClick - Column2.Header1.Click do legado
3120:     * (dump 3352-3364): alterna TODAS as linhas da grade entre marcada e
3121:     * desmarcada, usando o Tag do proprio Header1 como memoria do estado
3122:     * ("X" = tudo marcado).
3123:     *==========================================================================
3124:     PROCEDURE GradeMarcarDesmarcarTodosClick()
3125:         LOCAL loc_oHeader, loc_cCursor, loc_oErro
3126: 
3127:         TRY
3128:             loc_oHeader = THIS.grd_4c_Dados.Column2.Header1
3129:             loc_cCursor = THIS.this_cCursorEtiquetas
3130: 
3131:             IF loc_oHeader.Tag == "X"
3132:                 loc_oHeader.Tag = ""
3133:                 IF USED(loc_cCursor)
3134:                     REPLACE ALL Flag WITH .F. IN (loc_cCursor)
3135:                 ENDIF
3136:             ELSE
3137:                 loc_oHeader.Tag = "X"
3138:                 IF USED(loc_cCursor)
3139:                     REPLACE ALL Flag WITH .T. IN (loc_cCursor)
3140:                 ENDIF
3141:             ENDIF
3142: 
3143:             THIS.grd_4c_Dados.Refresh()
3144:         CATCH TO loc_oErro
3145:             MsgErro(loc_oErro.Message, "Erro em GradeMarcarDesmarcarTodosClick")
3146:         ENDTRY
3147:     ENDPROC
3148: 
3149:     *==========================================================================
3150:     * GradeCheckMarcar* - toggle do CheckBox de marcacao da grade
3151:     * (Column2.chk_4c_Check1). CheckBox em coluna de Grid nao alterna pelo
3152:     * binding nativo - exige os quatro handlers com NODEFAULT: Click/
3153:     * MouseDown so suprimem o toggle nativo (que desalinharia do REPLACE
3154:     * abaixo), MouseUp delega para o KeyPress(13), e o KeyPress eh quem de
3155:     * fato grava o novo valor no cursor e repinta a grade.
3156:     *==========================================================================
3157:     PROCEDURE GradeCheckMarcarClick()
3158:         NODEFAULT
3159:     ENDPROC
3160: 
3161:     PROCEDURE GradeCheckMarcarMouseDown(par_nButton, par_nShiftAltCtrl, par_nRow, par_nCol)
3162:         NODEFAULT
3163:     ENDPROC
3164: 
3165:     PROCEDURE GradeCheckMarcarMouseUp(par_nButton, par_nShiftAltCtrl, par_nRow, par_nCol)
3166:         THIS.GradeCheckMarcarKeyPress(13, 0)
3167:         NODEFAULT
3168:     ENDPROC
3169: 
3170:     PROCEDURE GradeCheckMarcarKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3171:         LOCAL loc_cCursor, loc_oErro
3172: 
3173:         IF INLIST(par_nKeyCode, 13, 32)
3174:             TRY
3175:                 loc_cCursor = THIS.this_cCursorEtiquetas
3176: 
3177:                 IF USED(loc_cCursor) AND !EOF(loc_cCursor)
3178:                     SELECT (loc_cCursor)
3179:                     REPLACE Flag WITH !Flag
3180:                     THIS.grd_4c_Dados.Refresh()
3181:                 ENDIF
3182:             CATCH TO loc_oErro
3183:                 MsgErro(loc_oErro.Message, "Erro em GradeCheckMarcarKeyPress")
3184:             ENDTRY
3185: 
3186:             NODEFAULT
3187:         ENDIF
3188:     ENDPROC
3189: 
3190:     *==========================================================================
3191:     * GradeRedirecionarParaColunaBarras - GotFocus de Column1/3/5/7/8.Text1
3192:     * (dump: cada uma identica, "If ParentForm.Tipo='DIGITACAO' / Column4.
3193:     * SetFocus"). Em modo DIGITACAO a unica coluna editavel eh a de codigo
3194:     * de barras - as demais apenas EXIBEM e redirecionam o foco de volta.
3195:     *==========================================================================
3196:     PROCEDURE GradeRedirecionarParaColunaBarras()
3197:         IF THIS.ObterTipoChamador() == "DIGITACAO"
3198:             THIS.grd_4c_Dados.Column4.SetFocus()
3199:         ENDIF
3200:     ENDPROC
3201: 
3202:     *==========================================================================
3203:     * ValidarCodigoBarrasGrade - Valid de txt_4c_CodBarras (Column4),
3204:     * chamado pela subclasse TextBoxCodBarrasIpE_4c (fim deste arquivo, via
3205:     * THISFORM - regra CLAUDE.md #46: BINDEVENT em "Valid" de TextBox de
3206:     * Column nao eh confiavel). Transcreve grd_historico.Column4.Text1.
3207:     * Valid do legado (dump 3399-3466): o usuario digita/bipa um codigo de
3208:     * barras em modo DIGITACAO; o metodo resolve o barcode (inclusive
3209:     * remapeamento via sigopeta), confere duplicidade na grade e adiciona
3210:     * uma linha nova a partir da etiqueta encontrada em SigOpEtq/SigCdPro.
3211:     *
3212:     * RETURN so FORA do TRY (regra CLAUDE.md #1) - os varios pontos de
3213:     * aborto do legado ("Return 0") viram o flag loc_lResultado.
3214:     *==========================================================================
3215:     PROCEDURE ValidarCodigoBarrasGrade(par_oTxt)
3216:         LOCAL loc_nEti, loc_cBars, loc_cCursor, loc_cSQL, loc_nResultado, ;
3217:               loc_nRecOriginal, loc_lResultado, loc_lProsseguir, loc_oErro
3218: 
3219:         loc_lResultado = .T.
3220: 
3221:         IF VARTYPE(par_oTxt) = "O"
3222:             loc_nEti = par_oTxt.Value
3223: 
3224:             IF !EMPTY(loc_nEti) AND par_oTxt.Tag != STR(loc_nEti, 14)
3225:                 loc_cCursor     = THIS.this_cCursorEtiquetas
3226:                 loc_lProsseguir = .T.
3227: 
3228:                 TRY
3229:                     loc_cBars = ALLTRIM(STR(loc_nEti, 14))
3230: 
3231:                     IF USED("CrEtiqs")
3232:                         USE IN CrEtiqs
3233:                     ENDIF
3234:                     loc_cSQL = "SELECT a.CPros, a.CBars FROM SigOpEtq a " + ;
3235:                         "LEFT JOIN sigopeta b ON a.cpros = b.cpros AND a.cbars = b.cbars_new " + ;
3236:                         "WHERE (a.CBars = " + loc_cBars + " OR b.cbars_old = " + loc_cBars + ")"
3237:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "CrEtiqs")
3238: 
3239:                     IF loc_nResultado < 1
3240:                         MsgErro("Favor reinicializar o processo !!!", "Falha na Conex" + CHR(227) + "o (CrEtiqs)")
3241:                         loc_lResultado  = .F.
3242:                         loc_lProsseguir = .F.
3243:                     ENDIF
3244: 
3245:                     IF loc_lProsseguir
3246:                         SELECT CrEtiqs
3247:                         GO TOP
3248: 
3249:                         IF EOF("CrEtiqs")
3250:                             MsgAviso("A Etiqueta Digitada N" + CHR(227) + "o Foi Encontrada!!!", "")
3251:                             loc_lResultado  = .F.
3252:                             loc_lProsseguir = .F.
3253:                         ENDIF
3254:                     ENDIF
3255: 
3256:                     IF loc_lProsseguir
3257:                         par_oTxt.Value = CrEtiqs.CBars
3258:                         loc_nEti       = par_oTxt.Value
3259: 
3260:                         IF USED("LocalEti")
3261:                             USE IN LocalEti
3262:                         ENDIF
3263:                         loc_cSQL = "SELECT a.*, b.pvens, CASE WHEN b.precode = 0 THEN b.pvens ELSE b.precode END " + ;
3264:                             "AS precode FROM SigOpEtq a, SigCdPro b WHERE a.CPros = b.CPros AND a.Cbars = " + ;
3265:                             ALLTRIM(STR(loc_nEti, 14))
3266:                         SQLEXEC(gnConnHandle, loc_cSQL, "LocalEti")
3267: 
3268:                         IF !USED("LocalEti") OR EOF("LocalEti")
3269:                             MsgAviso("A Etiqueta Digitada N" + CHR(227) + "o Foi Encontrada!!!", "")
3270:                             loc_lResultado  = .F.
3271:                             loc_lProsseguir = .F.
3272:                         ENDIF
3273:                     ENDIF
3274: 
3275:                     IF loc_lProsseguir
3276:                         IF EMPTY(LocalEti.Grupos) AND EMPTY(LocalEti.Contas)
3277:                             MsgAviso("A Etiqueta Digitada J" + CHR(225) + " Foi Vendida!!!", "")
3278:                             loc_lResultado  = .F.
3279:                             loc_lProsseguir = .F.
3280:                         ENDIF
3281:                     ENDIF
3282: 
3283:                     IF loc_lProsseguir
3284:                         loc_nRecOriginal = RECNO(loc_cCursor)
3285: 
3286:                         IF USED("crTmp")
3287:                             USE IN crTmp
3288:                         ENDIF
3289:                         SELECT CBars FROM (loc_cCursor) ;
3290:                             WHERE CBars = loc_nEti AND !EMPTY(CPros) AND RECNO() != loc_nRecOriginal ;
3291:                             INTO CURSOR crTmp
3292: 
3293:                         IF RECCOUNT("crTmp") > 0
3294:                             MsgAviso("Etiqueta J" + CHR(225) + " Digitada Na Sele" + CHR(231) + CHR(227) + "o Atual!!!", "")
3295:                             par_oTxt.Value  = 0
3296:                             loc_lResultado  = .F.
3297:                             loc_lProsseguir = .F.
3298:                         ENDIF
3299:                     ENDIF
3300: 
3301:                     IF loc_lProsseguir
3302:                         SELECT LocalEti
3303:                         SCATTER MEMVAR
3304: 
3305:                         SELECT (loc_cCursor)
3306:                         GATHER MEMVAR
3307:                         REPLACE Flag WITH .T.
3308: 
3309:                         APPEND BLANK
3310:                         GO BOTTOM
3311: 
3312:                         THIS.grd_4c_Dados.Refresh()
3313:                     ENDIF
3314:                 CATCH TO loc_oErro
3315:                     MsgErro(loc_oErro.Message + CHR(13) + ;
3316:                         "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em ValidarCodigoBarrasGrade")
3317:                     loc_lResultado = .F.
3318:                 ENDTRY
3319:             ENDIF
3320:         ENDIF
3321: 
3322:         RETURN loc_lResultado
3323:     ENDPROC
3324: 
3325:     *==========================================================================
3326:     * ValidarParcelasGrade/PodeEditarParcelas - Valid/When de
3327:     * txt_4c_Parcelas (Column10), chamados pela subclasse
3328:     * TextBoxParcelasIpE_4c. Transcrevem Column10.Text1.Valid/When do
3329:     * legado (dump 3540-3559): a coluna so eh editavel quando opt_Preco
3330:     * seleciona "Parcelamento" (Buttons(6)), e o valor digitado nao pode
3331:     * ultrapassar LocalParaC.QtdMarPar (parametro carregado no Init por
3332:     * CarregarParametrosSistema, Fase 8); o guard USED()/NVL continua
3333:     * valendo como leitura defensiva equivalente ao "If Not Empty(Local-
3334:     * ParaC.QtdMarPar)" do legado para qualquer caminho em que o cursor
3335:     * nao tenha sido populado (ex. falha de conexao).
3336:     *==========================================================================
3337:     PROCEDURE ValidarParcelasGrade(par_oTxt)
3338:         LOCAL loc_lResultado
3339: 
3340:         loc_lResultado = .T.
3341: 
3342:         IF VARTYPE(par_oTxt) = "O" AND !EMPTY(par_oTxt.Value)
3343:             IF USED("LocalParaC") AND !EMPTY(NVL(LocalParaC.QtdMarPar, 0))
3344:                 IF LocalParaC.QtdMarPar < par_oTxt.Value
3345:                     MsgAviso("Quantidade de Parcelas informadas ultrapassa o M" + CHR(225) + "x" + CHR(237) + ;
3346:                         "mo Permitido.", "Verifique")
3347:                     par_oTxt.Value = 0
3348:                     loc_lResultado = .F.
3349:                 ENDIF
3350:             ENDIF
3351:         ENDIF
3352: 
3353:         RETURN loc_lResultado
3354:     ENDPROC
3355: 
3356:     PROCEDURE PodeEditarParcelas()
3357:         RETURN (THIS.obj_4c_Opt_Preco.Value = 6)
3358:     ENDPROC
3359: 
3360:     *==========================================================================
3361:     * OptTipoInteractiveChange - Opt_Tipo.InteractiveChange do legado (dump
3362:     * 3569-3585): mostra/esconde cmdTestaPos, GetTexto/Label7 (tipos de
3363:     * texto livre) e getQtParcs/Label8 (tipo 136, parcelas) conforme o Tag
3364:     * do botao marcado.
3365:     *==========================================================================
3366:     PROCEDURE OptTipoInteractiveChange()
3367:         LOCAL loc_oGrupo, loc_nTpEti
3368: 
3369:         loc_oGrupo = THIS.obj_4c_Opt_Tipo
3370:         loc_nTpEti = INT(VAL(loc_oGrupo.Buttons(loc_oGrupo.Value).Tag))
3371: 
3372:         THIS.cmg_4c_CmdTestaPos.Visible = (loc_nTpEti = 80)
3373:         THIS.obj_4c_GetTexto.Visible    = INLIST(loc_nTpEti, 127, 131, 164, 168)
3374:         THIS.lbl_4c_Label8.Visible      = INLIST(loc_nTpEti, 136)
3375:         THIS.txt_4c_QtParcs.Visible     = INLIST(loc_nTpEti, 136)
3376:         THIS.lbl_4c_Label7.Visible      = INLIST(loc_nTpEti, 127, 131, 164, 168)
3377:     ENDPROC
3378: 
3379:     *==========================================================================
3380:     * OpcaoImpClick - Cnt_Impressora.Opcao_imp.Click do legado (dump
3381:     * 3718-3725): trocar o tipo de impressora esconde de novo o
3382:     * "Enviar Comando Reset" - ele nunca volta a aparecer nesta
3383:     * migracao, porque quem o reexibia era fCarregarImps (global nao
3384:     * portada, regra CLAUDE.md #27), nao algo coberto pela Fase 8.
3385:     *==========================================================================
3386:     PROCEDURE OpcaoImpClick()
3387:         THIS.cnt_4c__Impressora.chk_4c_Chk_Resete.Visible = .F.
3388:         THIS.cnt_4c__Impressora.chk_4c_Chk_Resete.Refresh()
3389:     ENDPROC
3390: 
3391:     *==========================================================================
3392:     * GetPrinterInteractiveChange/ValidarImpressoraSelecionada - Get_Printer.
3393:     * InteractiveChange do legado (dump 3898-3903): le o nome CADASTRADO da
3394:     * impressora (crImpreV.impresS - coluna DIFERENTE de impresS/impres,
3395:     * ver SigOpIpEBO.CarregarAjustesImpressora) e espelha nos controles de
3396:     * Cnt_Impressora o que SigCdmp tem para ela. Mesma decisao arquitetural
3397:     * do BO irmao sigopetsBO/Formsigopets (fCarregarImps nao veio no
3398:     * acervo - regra CLAUDE.md #27).
3399:     *
3400:     * crImpreV so existe a partir da Fase 8 (enumeracao de impressoras do
3401:     * Init reescrito) - ate la, GetPrinterInteractiveChange recebe "" e
3402:     * ValidarImpressoraSelecionada sai calada (nome vazio eh caminho
3403:     * legitimo - regra CLAUDE.md #50).
3404:     *==========================================================================
3405:     PROCEDURE GetPrinterInteractiveChange()
3406:         THIS.ValidarImpressoraSelecionada(THIS.ObterNomeImpressoraAtual())
3407:     ENDPROC
3408: 
3409:     PROCEDURE ValidarImpressoraSelecionada(par_cNomeImpressora)
3410:         LOCAL loc_cNome, loc_lModoSemBanco, loc_oBO, loc_oErro
3411: 
3412:         loc_cNome = IIF(VARTYPE(par_cNomeImpressora) = "C", ALLTRIM(par_cNomeImpressora), "")
3413: 
3414:         IF EMPTY(loc_cNome)
3415:             RETURN
3416:         ENDIF
3417: 
3418:         loc_lModoSemBanco = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
3419:                             (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)
3420: 
3421:         IF loc_lModoSemBanco
3422:             RETURN
3423:         ENDIF
3424: 
3425:         TRY
3426:             loc_oBO = THIS.this_oBusinessObject
3427: 
3428:             IF VARTYPE(loc_oBO) = "O"
3429:                 IF loc_oBO.CarregarAjustesImpressora(loc_cNome)
3430:                     IF loc_oBO.this_nTipoImpressora >= 1 AND ;
3431:                             loc_oBO.this_nTipoImpressora <= THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.ButtonCount
3432:                         THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value = loc_oBO.this_nTipoImpressora
3433:                     ENDIF
3434:                     THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Value = loc_oBO.this_nAjusteVertical
3435:                     THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Value = loc_oBO.this_nAjusteHorizontal
3436:                     THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Value = loc_oBO.this_nAjusteDensidade
3437:                     THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Value = loc_oBO.this_nAjusteVelocidade
3438:                 ELSE
3439:                     IF !EMPTY(loc_oBO.this_cMensagemErro)
3440:                         MsgAviso(loc_oBO.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
3441:                     ENDIF
3442:                 ENDIF
3443:             ENDIF
3444:         CATCH TO loc_oErro
3445:             MsgErro(loc_oErro.Message + CHR(13) + ;
3446:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em ValidarImpressoraSelecionada")
3447:         ENDTRY
3448:     ENDPROC
3449: 
3450:     *==========================================================================
3451:     * ValidarOcorrenciaEtiqueta - funil UNICO para getOcoEtiqs.Valid E
3452:     * getDOcoEtiqs.Valid do legado (dump 3594-3657, identicos exceto pela
3453:     * coluna de busca): liga em "LostFocus" (regra CLAUDE.md #47 - Valid de
3454:     * TextBox solto nao dispara confiavel via BINDEVENT) e substitui o
3455:     * fwbuscaext legado por FormBuscaAuxiliar contra SigEtOco (padrao do
3456:     * projeto).
3457:     *
3458:     * Guarda de reentrancia (this_lEmLookupOcorrencia): o picker eh MODAL e
3459:     * tira o foco, redisparando o proprio LostFocus (regra CLAUDE.md #37/
3460:     * #47).
3461:     *
3462:     * Guarda de "valor nao mudou" (this_cUltimoValidarOcorrenciaEtiqueta-
3463:     * Validado): LostFocus dispara SEMPRE que o foco sai do campo, mas o
3464:     * Valid do legado so dispara quando o valor MUDA - sem este guard,
3465:     * tabular pelos dois campos sem digitar nada repetiria a consulta SQL
3466:     * (e, no caminho sem match, reabriria o picker) a cada saida de campo.
3467:     *==========================================================================
3468:     PROCEDURE ValidarOcorrenciaEtiqueta()
3469:         LOCAL loc_cCodigo, loc_cDescricao, loc_cValorAtual, loc_lAchou, ;
3470:               loc_cSQL, loc_nResultado, loc_oBusca, loc_oErro
3471: 
3472:         IF THIS.this_lEmLookupOcorrencia
3473:             RETURN
3474:         ENDIF
3475: 
3476:         loc_cCodigo     = ALLTRIM(THIS.txt_4c_OcoEtiqs.Value)
3477:         loc_cDescricao  = ALLTRIM(THIS.txt_4c_DOcoEtiqs.Value)
3478:         loc_cValorAtual = loc_cCodigo + "|" + loc_cDescricao
3479: 
3480:         IF loc_cValorAtual == THIS.this_cUltimoValidarOcorrenciaEtiquetaValidado
3481:             RETURN
3482:         ENDIF
3483: 
3484:         THIS.this_lEmLookupOcorrencia = .T.
3485: 
3486:         TRY
3487:             IF EMPTY(loc_cCodigo) AND EMPTY(loc_cDescricao)
3488:                 THIS.txt_4c_OcoEtiqs.Value  = ""
3489:                 THIS.txt_4c_DOcoEtiqs.Value = ""
3490:             ELSE
3491:                 loc_lAchou = .F.
3492: 
3493:                 IF USED("cursor_4c_OcoEtiq")
3494:                     USE IN cursor_4c_OcoEtiq
3495:                 ENDIF
3496: 
3497:                 IF !EMPTY(loc_cCodigo)
3498:                     loc_cSQL = "SELECT TOP 1 Cods, Descrs FROM SigEtOco WHERE Cods = " + EscaparSQL(loc_cCodigo)
3499:                 ELSE
3500:                     loc_cSQL = "SELECT TOP 1 Cods, Descrs FROM SigEtOco WHERE Descrs = " + EscaparSQL(loc_cDescricao)
3501:                 ENDIF
3502: 
3503:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OcoEtiq")
3504: 
3505:                 IF loc_nResultado >= 1 AND USED("cursor_4c_OcoEtiq") AND RECCOUNT("cursor_4c_OcoEtiq") > 0
3506:                     SELECT cursor_4c_OcoEtiq
3507:                     GO TOP
3508:                     THIS.txt_4c_OcoEtiqs.Value  = ALLTRIM(Cods)
3509:                     THIS.txt_4c_DOcoEtiqs.Value = ALLTRIM(Descrs)
3510:                     loc_lAchou = .T.
3511:                 ENDIF
3512: 
3513:                 IF USED("cursor_4c_OcoEtiq")
3514:                     USE IN cursor_4c_OcoEtiq
3515:                 ENDIF
3516: 
3517:                 *-- Nao achou exato: abre o picker (regra CLAUDE.md #50 -
3518:                 *-- sem aviso, o picker JA eh o feedback; o codigo digitado
3519:                 *-- vira prefixo).
3520:                 IF !loc_lAchou
3521:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigEtOco", ;
3522:                         "cursor_4c_OcoEtiqBusca", "Cods", IIF(!EMPTY(loc_cCodigo), loc_cCodigo, loc_cDescricao), ;
3523:                         "Sele" + CHR(231) + CHR(227) + "o", .F., .T., "")
3524: 
3525:                     IF VARTYPE(loc_oBusca) = "O"
3526:                         IF !loc_oBusca.this_lAchouRegistro
3527:                             loc_oBusca.mAddColuna("Cods",   "", "C" + CHR(243) + "digo")
3528:                             loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
3529:                             loc_oBusca.Show()
3530:                         ENDIF
3531: 
3532:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_OcoEtiqBusca")
3533:                             SELECT cursor_4c_OcoEtiqBusca
3534:                             THIS.txt_4c_OcoEtiqs.Value  = ALLTRIM(Cods)
3535:                             THIS.txt_4c_DOcoEtiqs.Value = ALLTRIM(Descrs)
3536:                         ELSE
3537:                             THIS.txt_4c_OcoEtiqs.Value  = ""
3538:                             THIS.txt_4c_DOcoEtiqs.Value = ""
3539:                         ENDIF
3540: 
3541:                         loc_oBusca.Release()
3542:                     ENDIF
3543: 
3544:                     IF USED("cursor_4c_OcoEtiqBusca")
3545:                         USE IN cursor_4c_OcoEtiqBusca
3546:                     ENDIF
3547:                 ENDIF
3548:             ENDIF
3549: 
3550:             THIS.txt_4c_OcoEtiqs.Refresh()
3551:             THIS.txt_4c_DOcoEtiqs.Refresh()
3552: 
3553:             *-- Atualiza o guard de "valor nao mudou" com o que ficou nos
3554:             *-- campos apos a resolucao (achado exato, escolhido no picker
3555:             *-- ou limpo) - proxima LostFocus com o mesmo par sai cedo.
3556:             THIS.this_cUltimoValidarOcorrenciaEtiquetaValidado = ;
3557:                 ALLTRIM(THIS.txt_4c_OcoEtiqs.Value) + "|" + ALLTRIM(THIS.txt_4c_DOcoEtiqs.Value)
3558:         CATCH TO loc_oErro
3559:             MsgErro(loc_oErro.Message + CHR(13) + ;
3560:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em ValidarOcorrenciaEtiqueta")
3561:         ENDTRY
3562: 
3563:         THIS.this_lEmLookupOcorrencia = .F.
3564:     ENDPROC
3565: 
3566:     *==========================================================================
3567:     * MontaConjunto - montaconjunto do legado (dump 2544-2579): quando
3568:     * Opt_Conjunto = "Sim", colapsa TODAS as linhas de dbImpressao numa
3569:     * UNICA linha consolidada (quantidades/pesos somados, demais campos
3570:     * pelo MAX).
3571:     *==========================================================================
3572:     PROCEDURE MontaConjunto()
3573:         LOCAL loc_oErro
3574: 
3575:         IF THIS.obj_4c_Opt_Conjunto.Value = 1
3576:             TRY
3577:                 IF USED("csConjunto")
3578:                     USE IN csConjunto
3579:                 ENDIF
3580: 
3581:                 SELECT MAX(cpros) AS Cpros, MAX(Qtds) AS Qtds, MAX(QtdeEtiq) AS QtdeEtiq, ;
3582:                        MAX(Pedido) AS Pedido, "" AS Obs, SUM(Pvens) AS Pvens, MAX(Moedas) AS Moedas, ;
3583:                        "" AS Empos, MAX(cpros1) AS cpros1, SUM(PrecoDe) AS PrecoDe, MAX(Parcelas) AS Parcelas ;
3584:                     FROM dbImpressao ;
3585:                     INTO CURSOR csConjunto READWRITE
3586: 
3587:                 SELECT dbImpressao
3588:                 ZAP
3589: 
3590:                 SELECT csConjunto
3591:                 GO TOP
3592:                 SCAN
3593:                     SCATTER MEMVAR
3594:                     SELECT dbImpressao
3595:                     APPEND BLANK
3596:                     GATHER MEMVAR
3597:                     SELECT csConjunto
3598:                 ENDSCAN
3599: 
3600:                 SELECT dbImpressao
3601:                 GO TOP
3602: 
3603:                 IF USED("csConjunto")
3604:                     USE IN csConjunto
3605:                 ENDIF
3606:             CATCH TO loc_oErro
3607:                 MsgErro(loc_oErro.Message, "Erro em MontaConjunto")
3608:             ENDTRY
3609:         ENDIF
3610:     ENDPROC
3611: 
3612:     *==========================================================================

*-- Linhas 3624 a 3735:
3624:     * exist" sem indicar qual arquivo.
3625:     *==========================================================================
3626:     *-- ============================================================
3627:     *-- PROCEDURE ExecutarReportForm (Pattern #117 / #123)
3628:     *-- Executa REPORT FORM apenas se o FRX existir; caso contrario,
3629:     *-- exibe MostrarErro descritivo com o path faltante.
3630:     *-- Isola SET POINT/SEPARATOR/REPORTBEHAVIOR durante o REPORT FORM
3631:     *-- porque FRXs legados Fortyus (VFP6/7/8) foram desenhados com
3632:     *-- POINT="." + REPORTBEHAVIOR 80. Sem isolamento o modo 90 remede
3633:     *-- fontes em runtime e mostra asteriscos em campos numericos.
3634:     *-- par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
3635:     *-- par_cCursorDados: opcional. Se informado e cursor estiver vazio,
3636:     *--   mostra MsgAviso e retorna .F. sem abrir preview vazio.
3637:     *-- ============================================================
3638:     PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
3639:         LOCAL loc_cFRX
3640:         loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")
3641: 
3642:         IF NOT FILE(loc_cFRX)
3643:             MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
3644:                 loc_cFRX + CHR(13) + CHR(13) + ;
3645:                 "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
3646:             RETURN .F.
3647:         ENDIF
3648: 
3649:         *-- Guard cursor vazio: evita preview em branco / impressao vazia (Erro30)
3650:         IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
3651:             IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
3652:                 MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
3653:                     "Aten" + CHR(231) + CHR(227) + "o")
3654:                 RETURN .F.
3655:             ENDIF
3656:         ENDIF
3657: 
3658:         *-- Isolamento de locale + modo de renderizacao (Erro28)
3659:         LOCAL loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig
3660:         loc_cPointOrig    = SET("POINT")
3661:         loc_cSepOrig      = SET("SEPARATOR")
3662:         loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
3663:         SET POINT TO "."
3664:         SET SEPARATOR TO ","
3665:         SET REPORTBEHAVIOR 80
3666: 
3667:         DO CASE
3668:             CASE par_cModo == "PREVIEW"
3669:                 REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
3670:             CASE par_cModo == "PRINTER_PROMPT"
3671:                 REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
3672:             CASE par_cModo == "PRINTER"
3673:                 REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
3674:         ENDCASE
3675: 
3676:         SET POINT TO (loc_cPointOrig)
3677:         SET SEPARATOR TO (loc_cSepOrig)
3678:         SET REPORTBEHAVIOR (loc_nBehaviorOrig)
3679: 
3680:         *-- Restaurar menu (Erro63): REPORT FORM PREVIEW abre toolbar propria
3681:         *-- que corrompe cache visual do _MSYSMENU. Sem RELEASE + Criar aqui,
3682:         *-- popups renderizam encolhidos apos preview fechar. Mesmo fix do
3683:         *-- FormBase.Destroy (Erro58) precisa rodar no path REPORT PREVIEW.
3684:         TRY
3685:             SET SYSMENU TO DEFAULT
3686:             RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda
3687:             CriarMenuPrincipal()
3688:         CATCH
3689:             *-- CriarMenuPrincipal fora do escopo (teste automatizado) - silencioso
3690:         ENDTRY
3691: 
3692:         RETURN .T.
3693:     ENDPROC
3694: 
3695:     PROCEDURE TagModelo1(par_nTpEti, par_lImpPreco, par_cTipo)
3696:         LOCAL loc_lEhModelo1, loc_cCursor, loc_nBrr, loc_oErro
3697: 
3698:         loc_lEhModelo1 = .F.
3699:         loc_cCursor    = THIS.this_cCursorEtiquetas
3700: 
3701:         IF USED("LocalTpEti")
3702:             SELECT LocalTpEti
3703:             LOCATE FOR LocalTpEti.nTipos = par_nTpEti
3704: 
3705:             IF !EOF() AND LocalTpEti.tpespes = 2
3706:                 loc_lEhModelo1 = .T.
3707: 
3708:                 TRY
3709:                     IF USED("dbImpressao")
3710:                         USE IN dbImpressao
3711:                     ENDIF
3712:                     CREATE CURSOR dbImpressao (CPros C(14), dpros C(40), Cbars N(14, 0), ;
3713:                         Pvens N(12, 2), razas C(30), Reffs C(40), codtams C(4), CodCors C(4))
3714:                     INDEX ON cpros TAG cpros
3715: 
3716:                     SQLEXEC(gnConnHandle, "SELECT cemps, razas FROM SigCdEmp", "crSigCdEmp")
3717:                     SQLEXEC(gnConnHandle, "SELECT observas, codigos FROM SigCdObs", "crSigCdObs")
3718: 
3719:                     IF USED(loc_cCursor)
3720:                         SELECT (loc_cCursor)
3721:                         SCAN
3722:                             IF EVALUATE(loc_cCursor + ".Flag")
3723:                                 IF USED("crSigCdEmp")
3724:                                     SELECT crSigCdEmp
3725:                                     LOCATE FOR cemps = EVALUATE(loc_cCursor + ".empos")
3726:                                 ENDIF
3727: 
3728:                                 IF USED("crSigCdObs")
3729:                                     SELECT crSigCdObs
3730:                                     LOCATE FOR codigos = LocalTpEti.codobs
3731:                                 ENDIF
3732: 
3733:                                 SQLEXEC(gnConnHandle, "SELECT dpros, PVIdeals, Moedas, PVens, Moevs FROM SigCdPro " + ;
3734:                                     "WHERE Cpros = " + EscaparSQL(EVALUATE(loc_cCursor + ".Cpros")), "LocalPro")
3735: 

*-- Linhas 3785 a 3967:
3785:     * do legado (dump 2219-2234/2354-2367): grava um registro em SigEtOcr
3786:     * por linha impressa, com a ocorrencia/justificativa escolhidas.
3787:     *==========================================================================
3788:     PROCEDURE RegistrarOcorrenciaEtiquetas()
3789:         LOCAL loc_cSQL, loc_oErro
3790: 
3791:         IF THIS.this_lGravaOcorrencia AND USED("dbImpressao")
3792:             TRY
3793:                 SELECT dbImpressao
3794:                 SCAN
3795:                     loc_cSQL = "INSERT INTO SigEtOcr (Cbars, Datas, Horas, Usuars, Qtds, Cods, Justifs, cidchaves) " + ;
3796:                         "VALUES (" + ;
3797:                         FormatarNumeroSQL(INT(VAL(dbImpressao.Cpros)), 0) + ", " + ;
3798:                         FormatarDataSQL(DATE()) + ", " + ;
3799:                         EscaparSQL(TIME()) + ", " + ;
3800:                         EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
3801:                         FormatarNumeroSQL(dbImpressao.QtdeEtiq, 0) + ", " + ;
3802:                         EscaparSQL(ALLTRIM(THIS.txt_4c_OcoEtiqs.Value)) + ", " + ;
3803:                         EscaparSQL(THIS.obj_4c_GetJustifs.Value) + ", " + ;
3804:                         EscaparSQL(LEFT(fUniqueIds(), 20)) + ")"
3805: 
3806:                     IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
3807:                         MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update - SigEtOcr)")
3808:                     ENDIF
3809:                 ENDSCAN
3810:             CATCH TO loc_oErro
3811:                 MsgErro(loc_oErro.Message, "Erro em RegistrarOcorrenciaEtiquetas")
3812:             ENDTRY
3813:         ENDIF
3814:     ENDPROC
3815: 
3816:     *==========================================================================
3817:     * ImpressaoValidarOcorrenciaObrigatoria - "Consiste os Parametros" do
3818:     * Impressao() legado (dump 1949-1970): a Ocorrencia eh obrigatoria
3819:     * quando this_lGravaOcorrencia, e a Justificativa eh obrigatoria quando
3820:     * a ocorrencia escolhida exige (SigEtOco.Justifs = 1).
3821:     *==========================================================================
3822:     PROCEDURE ImpressaoValidarOcorrenciaObrigatoria()
3823:         LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_oErro
3824: 
3825:         loc_lResultado = .T.
3826: 
3827:         IF THIS.this_lGravaOcorrencia AND EMPTY(THIS.txt_4c_OcoEtiqs.Value)
3828:             MsgAviso("A Ocorr" + CHR(234) + "ncia da Impress" + CHR(227) + "o de Etiquetas " + CHR(233) + ;
3829:                 " Inv" + CHR(225) + "lida!!!", "")
3830:             THIS.txt_4c_OcoEtiqs.SetFocus()
3831:             loc_lResultado = .F.
3832:         ELSE
3833:             IF !EMPTY(THIS.txt_4c_OcoEtiqs.Value)
3834:                 TRY
3835:                     IF USED("TmpOcEti")
3836:                         USE IN TmpOcEti
3837:                     ENDIF
3838:                     loc_cSQL = "SELECT * FROM SigEtOco WHERE Cods = " + EscaparSQL(ALLTRIM(THIS.txt_4c_OcoEtiqs.Value))
3839:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "TmpOcEti")
3840: 
3841:                     IF loc_nResultado < 1
3842:                         MsgErro("Favor reinicializar o processo !!!", "Falha na Conex" + CHR(227) + "o (TmpOcEti)")
3843:                         loc_lResultado = .F.
3844:                     ELSE
3845:                         SELECT TmpOcEti
3846:                         GO TOP
3847:                         IF !EOF() AND TmpOcEti.Justifs = 1 AND EMPTY(THIS.obj_4c_GetJustifs.Value)
3848:                             MsgAviso("Ocorr" + CHR(234) + "ncia com Justificativa Obrigat" + CHR(243) + "ria !!!", ;
3849:                                 "Campo Obrigat" + CHR(243) + "rio")
3850:                             THIS.obj_4c_GetJustifs.SetFocus()
3851:                             loc_lResultado = .F.
3852:                         ENDIF
3853:                     ENDIF
3854:                 CATCH TO loc_oErro
3855:                     MsgErro(loc_oErro.Message, "Erro em ImpressaoValidarOcorrenciaObrigatoria")
3856:                     loc_lResultado = .F.
3857:                 ENDTRY
3858:             ENDIF
3859:         ENDIF
3860: 
3861:         RETURN loc_lResultado
3862:     ENDPROC
3863: 
3864:     *==========================================================================
3865:     * ImpressaoTextoLivre - ramo "texto livre" de Impressao() (dump
3866:     * 2001-2017): tipos 127/131/164/168 ignoram a grade inteira e imprimem
3867:     * UMA etiqueta com o texto digitado em GetTexto.
3868:     *==========================================================================
3869:     PROCEDURE ImpressaoTextoLivre(par_nTpEti, par_cTipo)
3870:         LOCAL loc_lTratado, loc_cTexto, loc_oErro
3871: 
3872:         loc_lTratado = .F.
3873: 
3874:         IF INLIST(par_nTpEti, 127, 131, 164, 168)
3875:             loc_lTratado = .T.
3876: 
3877:             THIS.GarantirCursorImpressao()
3878:             SELECT dbImpressao
3879:             ZAP
3880:             APPEND BLANK
3881:             REPLACE Cpros WITH "1", Qtds WITH 1
3882: 
3883:             loc_cTexto = THIS.obj_4c_GetTexto.Value
3884: 
3885:             IF par_cTipo = "I"
3886:                 TRY
3887:                     SigOpEtq(gnConnHandle, .F., .F., par_nTpEti, THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value, ;
3888:                         THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Value, ;
3889:                         THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Value, ;
3890:                         THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Value, "", "", "", ;
3891:                         THIS.ObterNomeImpressoraAtual(), .F., .F., THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Value, ;
3892:                         .F., .F., .F., .F., .F., .F., loc_cTexto)
3893:                 CATCH TO loc_oErro
3894:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel imprimir a etiqueta:" + CHR(13) + ;
3895:                         loc_oErro.Message, "Erro")
3896:                 ENDTRY
3897:             ENDIF
3898:         ENDIF
3899: 
3900:         RETURN loc_lTratado
3901:     ENDPROC
3902: 
3903:     *==========================================================================
3904:     * ImpressaoParcelas - ramo "quantidade de parcelas" de Impressao()
3905:     * (dump 2020-2063): tipo 136 imprime o texto livre com a quantidade de
3906:     * parcelas digitada em getQtParcs, a partir das linhas FLAGADAS da
3907:     * grade (igual ao ramo principal, mas sem os sub-casos de lnTpEti).
3908:     *==========================================================================
3909:     PROCEDURE ImpressaoParcelas(par_nTpEti, par_cTipo)
3910:         LOCAL loc_lTratado, loc_cTexto, loc_cCursor, loc_oProgresso, loc_oErro
3911: 
3912:         loc_lTratado = .F.
3913: 
3914:         IF INLIST(par_nTpEti, 136)
3915:             loc_lTratado = .T.
3916:             loc_cCursor  = THIS.this_cCursorEtiquetas
3917: 
3918:             TRY
3919:                 loc_cTexto = ALLTRIM(STR(IIF(!EMPTY(THIS.txt_4c_QtParcs.Value), THIS.txt_4c_QtParcs.Value, 1)))
3920: 
3921:                 THIS.GarantirCursorImpressao()
3922:                 SELECT dbImpressao
3923:                 ZAP
3924: 
3925:                 IF USED(loc_cCursor)
3926:                     SELECT (loc_cCursor)
3927:                     loc_oProgresso = CREATEOBJECT("fwprogressbar", "Processando Etiquetas...", RECCOUNT())
3928:                     loc_oProgresso.Show()
3929: 
3930:                     SCAN
3931:                         loc_oProgresso.Update(.T.)
3932: 
3933:                         IF EVALUATE(loc_cCursor + ".Flag")
3934:                             IF EVALUATE(loc_cCursor + ".Mantem")
3935:                                 SCATTER MEMVAR MEMO
3936:                                 SELECT dbImpressao
3937:                                 APPEND BLANK
3938:                                 GATHER MEMVAR MEMO
3939:                                 SELECT (loc_cCursor)
3940:                             ELSE
3941:                                 INSERT INTO dbImpressao (cpros, Qtds, QtdeEtiq, Pedido, Obs, Pvens, Moedas, Empos, cpros1, PrecoDe, Parcelas) ;
3942:                                     VALUES (STR(EVALUATE(loc_cCursor + ".CBars"), 14), 1, EVALUATE(loc_cCursor + ".Qtds"), ;
3943:                                             NVL(EVALUATE(loc_cCursor + ".CodAmss"), ""), NVL(EVALUATE(loc_cCursor + ".ObsEtiqs"), ""), ;
3944:                                             EVALUATE(loc_cCursor + ".Pvens"), EVALUATE(loc_cCursor + ".Moedas"), ;
3945:                                             EVALUATE(loc_cCursor + ".Empos"), EVALUATE(loc_cCursor + ".Cpros"), ;
3946:                                             EVALUATE(loc_cCursor + ".PrecoDe"), EVALUATE(loc_cCursor + ".Parcelas"))
3947:                             ENDIF
3948:                         ENDIF
3949:                     ENDSCAN
3950: 
3951:                     loc_oProgresso.Complete()
3952:                 ENDIF
3953: 
3954:                 THIS.MontaConjunto()
3955: 
3956:                 IF par_cTipo = "I"
3957:                     SigOpEtq(gnConnHandle, .F., .F., par_nTpEti, THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value, ;
3958:                         THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Value, ;
3959:                         THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Value, ;
3960:                         THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Value, "", "", "", ;
3961:                         THIS.ObterNomeImpressoraAtual(), .F., .F., THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Value, ;
3962:                         .F., .F., .F., .F., .F., .F., loc_cTexto)
3963:                 ENDIF
3964:             CATCH TO loc_oErro
3965:                 MsgErro(loc_oErro.Message + CHR(13) + ;
3966:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em ImpressaoParcelas")
3967:             ENDTRY

*-- Linhas 3977 a 4037:
3977:     * resolvem Pedido/empdopnums/Obs de forma diferente) e dispara UM
3978:     * ciclo de impressao/gravacao no final.
3979:     *==========================================================================
3980:     PROCEDURE ImprimirSemAgrupamento(par_nTpEti, par_cTipo, par_lImpPreco, par_nOptPreco, par_lImpPesoTotal)
3981:         LOCAL loc_cCursor, loc_oProgresso, loc_nQtd, loc_cEdn, loc_cConta, loc_lPreco, ;
3982:               loc_nBrr, loc_cBrr, loc_cSQL, loc_oErro
3983: 
3984:         loc_cCursor = THIS.this_cCursorEtiquetas
3985: 
3986:         TRY
3987:             THIS.GarantirCursorImpressao()
3988:             SELECT dbImpressao
3989:             ZAP
3990:             IF USED("crSigEtOcr")
3991:                 SELECT crSigEtOcr
3992:                 ZAP
3993:             ENDIF
3994: 
3995:             IF USED(loc_cCursor)
3996:                 SELECT (loc_cCursor)
3997:                 loc_oProgresso = CREATEOBJECT("fwprogressbar", "Processando Etiquetas...", RECCOUNT())
3998:                 loc_oProgresso.Show()
3999: 
4000:                 SCAN
4001:                     loc_oProgresso.Update(.T.)
4002: 
4003:                     IF EVALUATE(loc_cCursor + ".Flag")
4004:                         IF EVALUATE(loc_cCursor + ".Mantem")
4005:                             SCATTER MEMVAR MEMO
4006:                             m.Obs = IIF(par_nTpEti = 134, m.CodCors, m.Obs)
4007:                             SELECT dbImpressao
4008:                             APPEND BLANK
4009:                             GATHER MEMVAR MEMO
4010:                             SELECT (loc_cCursor)
4011:                         ELSE
4012:                             IF par_nTpEti = 12
4013:                                 SQLEXEC(gnConnHandle, "SELECT * FROM SigCdOpe WHERE Dopes = " + ;
4014:                                     EscaparSQL(EVALUATE(loc_cCursor + ".Dopes")), "LocalOpe")
4015: 
4016:                                 IF USED("LocalOpe") AND !EOF("LocalOpe")
4017:                                     INSERT INTO dbImpressao (Cpros, Qtds, Cbars, Obs, cpros1) ;
4018:                                         VALUES (EVALUATE(loc_cCursor + ".Cpros"), 1, ;
4019:                                             VAL(STR(LocalOpe.Ndopes, 4) + TRANSFORM(EVALUATE(loc_cCursor + ".Cbars"), "@L 9999999999")), ;
4020:                                             NVL(EVALUATE(loc_cCursor + ".ObsEtiqs"), ""), EVALUATE(loc_cCursor + ".Cpros"))
4021:                                 ENDIF
4022:                             ELSE
4023:                                 loc_nQtd = EVALUATE(loc_cCursor + ".Qtds")
4024: 
4025:                                 IF EMPTY(EVALUATE(loc_cCursor + ".Nops"))
4026:                                     INSERT INTO dbImpressao (Cpros, Qtds, QtdeEtiq, Pedido, Obs, Pvens, Moedas, Empos, cpros1, CodTams, PrecoDe, Parcelas) ;
4027:                                         VALUES (STR(EVALUATE(loc_cCursor + ".CBars"), 14), 1, loc_nQtd, ;
4028:                                             NVL(EVALUATE(loc_cCursor + ".CodAmss"), ""), ;
4029:                                             IIF(par_nTpEti = 134, EVALUATE(loc_cCursor + ".CodCors"), NVL(EVALUATE(loc_cCursor + ".ObsEtiqs"), "")), ;
4030:                                             EVALUATE(loc_cCursor + ".Pvens"), EVALUATE(loc_cCursor + ".Moedas"), ;
4031:                                             EVALUATE(loc_cCursor + ".Empos"), EVALUATE(loc_cCursor + ".Cpros"), ;
4032:                                             EVALUATE(loc_cCursor + ".CodTams"), EVALUATE(loc_cCursor + ".PrecoDe"), ;
4033:                                             IIF(par_nOptPreco = 6 AND EMPTY(EVALUATE(loc_cCursor + ".Parcelas")), 1, EVALUATE(loc_cCursor + ".Parcelas")))
4034: 
4035:                                     IF INLIST(par_nTpEti, 39)
4036:                                         loc_cEdn = EVALUATE(loc_cCursor + ".Empos") + EVALUATE(loc_cCursor + ".Dopeos") + ;
4037:                                             STR(EVALUATE(loc_cCursor + ".Numeos"), 6)

*-- Linhas 4153 a 4228:
4153: 
4154:                 THIS.RegistrarOcorrenciaEtiquetas()
4155:             ELSE
4156:                 MsgAviso("Nenhuma Etiqueta Selecionada!!!", "")
4157:             ENDIF
4158:         CATCH TO loc_oErro
4159:             MsgErro(loc_oErro.Message + CHR(13) + ;
4160:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4161:                 "Procedure: " + loc_oErro.Procedure, "Erro em ImprimirSemAgrupamento")
4162:         ENDTRY
4163:     ENDPROC
4164: 
4165:     *==========================================================================
4166:     * ImprimirAgrupadoPorContaOs - ramo "agrupado" de Impressao() (dump
4167:     * 2239-2371): usada quando o tipo de etiqueta precisa de separador por
4168:     * conta (LocalParaC.EtqSeps = 1) - agrupa a grade por Empos+Grupos+
4169:     * Contas (ou trata tudo como UM grupo so, se this_nOrdemImp = 3) e
4170:     * dispara um ciclo de impressao/gravacao POR GRUPO.
4171:     *==========================================================================
4172:     PROCEDURE ImprimirAgrupadoPorContaOs(par_nTpEti, par_cTipo, par_lImpPreco, par_lImpPesoTotal)
4173:         LOCAL loc_cCursor, loc_cEmp, loc_cGrp, loc_cCta, loc_cRps, loc_oProgresso, ;
4174:               loc_nQtd, loc_cEdn, loc_cConta, loc_nBrr, loc_cBrr, loc_cSQL, loc_oErro
4175: 
4176:         loc_cCursor = THIS.this_cCursorEtiquetas
4177: 
4178:         TRY
4179:             IF USED(loc_cCursor)
4180:                 SELECT (loc_cCursor)
4181: 
4182:                 IF THIS.this_nOrdemImp != 3
4183:                     SET ORDER TO TAG EmpGruCon
4184:                 ENDIF
4185: 
4186:                 GO TOP
4187: 
4188:                 loc_oProgresso = CREATEOBJECT("fwprogressbar", "Processando Dados do Cursor...", RECCOUNT())
4189:                 loc_oProgresso.Show()
4190: 
4191:                 DO WHILE !EOF(loc_cCursor)
4192:                     loc_cEmp = EVALUATE(loc_cCursor + ".Empos")
4193:                     loc_cGrp = EVALUATE(loc_cCursor + ".Grupos")
4194:                     loc_cCta = EVALUATE(loc_cCursor + ".Contas")
4195:                     loc_cRps = IIF(THIS.this_lGravaPro, "Reposicao", " ")
4196: 
4197:                     THIS.GarantirCursorImpressao()
4198:                     SELECT dbImpressao
4199:                     ZAP
4200:                     IF USED("crSigEtOcr")
4201:                         SELECT crSigEtOcr
4202:                         ZAP
4203:                     ENDIF
4204: 
4205:                     SELECT (loc_cCursor)
4206: 
4207:                     DO WHILE !EOF(loc_cCursor)
4208:                         IF THIS.this_nOrdemImp != 3
4209:                             IF EVALUATE(loc_cCursor + ".Empos") + EVALUATE(loc_cCursor + ".Grupos") + ;
4210:                                     EVALUATE(loc_cCursor + ".Contas") != loc_cEmp + loc_cGrp + loc_cCta
4211:                                 EXIT
4212:                             ENDIF
4213:                         ENDIF
4214: 
4215:                         loc_oProgresso.Update(.T.)
4216: 
4217:                         IF EVALUATE(loc_cCursor + ".Flag")
4218:                             IF EVALUATE(loc_cCursor + ".Mantem")
4219:                                 SCATTER MEMVAR MEMO
4220:                                 SELECT dbImpressao
4221:                                 APPEND BLANK
4222:                                 GATHER MEMVAR MEMO
4223:                                 SELECT (loc_cCursor)
4224:                             ELSE
4225:                                 loc_nQtd = EVALUATE(loc_cCursor + ".Qtds")
4226: 
4227:                                 IF EMPTY(EVALUATE(loc_cCursor + ".Nops"))
4228:                                     INSERT INTO dbImpressao (Cpros, Qtds, QtdeEtiq, Obs) ;

*-- Linhas 4327 a 4396:
4327:         CATCH TO loc_oErro
4328:             MsgErro(loc_oErro.Message + CHR(13) + ;
4329:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4330:                 "Procedure: " + loc_oErro.Procedure, "Erro em ImprimirAgrupadoPorContaOs")
4331:         ENDTRY
4332:     ENDPROC
4333: 
4334:     *==========================================================================
4335:     * GerarOperacaoEtiquetas - bloco final de Impressao() (dump 2381-2450):
4336:     * quando a impressao eh imediata e o chamador configurou uma operacao
4337:     * de destino (LocalParac.DopEtiqs), gera o movimento correspondente em
4338:     * SigMvCab/SigMvItn/SigMvIts a partir das linhas selecionadas.
4339:     *
4340:     * Depende de LocalParac (parametros carregados no Init por
4341:     * CarregarParametrosSistema, Fase 8). Sem ele (ex. falha de conexao)
4342:     * este bloco nao se aplica - mesmo efeito do
4343:     * "Not Empty(LocalParac.DopEtiqs)" do legado quando o parametro esta
4344:     * vazio.
4345:     *
4346:     * SigMvCab e SigMvItn tem mais de 100 colunas NOT NULL cada (conferido
4347:     * em docs\schema.sql); o legado grava via cursor BUFFERIZADO inteiro
4348:     * (AddCursor + TableUpdate), que preenche as colunas nao citadas com o
4349:     * branco do registro em branco do cursor. Um INSERT parcial aqui
4350:     * quebraria o NOT NULL em runtime (regra CLAUDE.md #22 - mesma classe
4351:     * dos Erro151/Erro159) - por isso SigMvCab/SigMvItn NAO sao gravados
4352:     * por este metodo ainda; SigMvIts (o item com o codigo de barras) TEM
4353:     * BO proprio e completo (SigOpIpEBO, Fases 1-2, INSERT com as 30
4354:     * colunas da tabela) e esse SIM eh gravado aqui.
4355:     *==========================================================================
4356:     PROCEDURE GerarOperacaoEtiquetas(par_nTpEti)
4357:         LOCAL loc_lConfirmou, loc_cDopes, loc_cChave, loc_nItem, loc_nNumes, loc_cEmps, ;
4358:               loc_oBO, loc_oErro
4359: 
4360:         IF USED("LocalParac") AND !EMPTY(NVL(LocalParac.DopEtiqs, "")) AND par_nTpEti != 12
4361:             loc_cDopes = ALLTRIM(LocalParac.DopEtiqs)
4362: 
4363:             loc_lConfirmou = MsgConfirma("Confirma Gera" + CHR(231) + CHR(227) + "o da Opera" + CHR(231) + CHR(227) + ;
4364:                 "o " + loc_cDopes + "!!!", "")
4365: 
4366:             IF loc_lConfirmou
4367:                 TRY
4368:                     IF USED("CsSelecao")
4369:                         USE IN CsSelecao
4370:                     ENDIF
4371:                     SELECT Empos, Grupos, Contas, Cpros, Cbars, CodCors, CodTams, Qtds, Pesos ;
4372:                         FROM (THIS.this_cCursorEtiquetas) WHERE Empos != "  " ;
4373:                         INTO CURSOR CsSelecao ORDER BY 1, 2, 3
4374: 
4375:                     loc_cChave = SPACE(23)
4376:                     loc_nItem  = 1
4377: 
4378:                     MsgErro("A gera" + CHR(231) + CHR(227) + "o autom" + CHR(225) + "tica da opera" + CHR(231) + ;
4379:                         CHR(227) + "o " + loc_cDopes + " tamb" + CHR(233) + "m grava em SigMvCab e SigMvItn, que " + ;
4380:                         "ainda n" + CHR(227) + "o t" + CHR(234) + "m cobertura completa de colunas NOT NULL nesta " + ;
4381:                         "migra" + CHR(231) + CHR(227) + "o. O item em SigMvIts ser" + CHR(225) + " gravado; " + ;
4382:                         "registre o cabe" + CHR(231) + "alho/itens do movimento manualmente.", ;
4383:                         "Grava" + CHR(231) + CHR(227) + "o parcial")
4384: 
4385:                     loc_oBO = THIS.this_oBusinessObject
4386: 
4387:                     SELECT CsSelecao
4388:                     SCAN
4389:                         loc_cEmps = CsSelecao.Empos
4390: 
4391:                         IF Empos + Grupos + Contas != loc_cChave
4392:                             loc_nNumes = fGerUniqueKey(ALLTRIM(loc_cDopes) + loc_cEmps)
4393:                             loc_nItem  = 1
4394:                             loc_cChave = CsSelecao.Empos + CsSelecao.Grupos + CsSelecao.Contas
4395:                         ENDIF
4396: 

*-- Linhas 4425 a 4478:
4425:     ENDPROC
4426: 
4427:     *==========================================================================
4428:     * Impressao - orquestrador principal (dump 1929-2454, "PROCEDURE
4429:     * impressao Lparameters pTipo"). par_cTipo: "I" = Impressao Imediata,
4430:     * "A" = Impressao Posterior (Armazenar).
4431:     *
4432:     * Ordem de controle TRANSCRITA do legado: texto-livre e parcelas tem
4433:     * "Return" PROPRIO (pulam tagmod1, o bloco agrupar/nao-agrupar, o
4434:     * Release de 'A' E a geracao de operacao); TagModelo1 eh uma FUNCAO
4435:     * separada - "If Not tagmod1(...)" so pula o bloco agrupar/nao-
4436:     * agrupar, o restante do metodo roda do mesmo jeito.
4437:     *==========================================================================
4438:     PROCEDURE Impressao(par_cTipo)
4439:         LOCAL loc_nTpEti, loc_lImpPreco, loc_nOptPreco, loc_lImpPesoTotal, ;
4440:               loc_lAgrupar, loc_lJaTratado, loc_oErro
4441: 
4442:         IF THIS.ImpressaoValidarOcorrenciaObrigatoria()
4443:             loc_lImpPreco     = (THIS.obj_4c_Opt_Preco.Value != 2)
4444:             loc_nOptPreco     = THIS.obj_4c_Opt_Preco.Value
4445:             loc_nTpEti        = INT(VAL(THIS.obj_4c_Opt_Tipo.Buttons(THIS.obj_4c_Opt_Tipo.Value).Tag))
4446:             loc_lImpPesoTotal = (THIS.obj_4c_Opt_peso.Value = 1)
4447: 
4448:             loc_lJaTratado = THIS.ImpressaoTextoLivre(loc_nTpEti, par_cTipo)
4449: 
4450:             IF !loc_lJaTratado
4451:                 loc_lJaTratado = THIS.ImpressaoParcelas(loc_nTpEti, par_cTipo)
4452:             ENDIF
4453: 
4454:             IF !loc_lJaTratado
4455:                 IF !THIS.TagModelo1(loc_nTpEti, loc_lImpPreco, par_cTipo)
4456:                     TRY
4457:                         loc_lAgrupar = !(INLIST(loc_nTpEti, 10, 13) OR ;
4458:                             (INLIST(loc_nTpEti, 1, 55, 56, 57, 66, 67, 68) AND ;
4459:                              USED("LocalParaC") AND NVL(LocalParaC.EtqSeps, 0) = 1))
4460:                     CATCH TO loc_oErro
4461:                         loc_lAgrupar = .T.
4462:                     ENDTRY
4463: 
4464:                     IF loc_lAgrupar
4465:                         THIS.ImprimirSemAgrupamento(loc_nTpEti, par_cTipo, loc_lImpPreco, loc_nOptPreco, loc_lImpPesoTotal)
4466:                     ELSE
4467:                         THIS.ImprimirAgrupadoPorContaOs(loc_nTpEti, par_cTipo, loc_lImpPreco, loc_lImpPesoTotal)
4468:                     ENDIF
4469:                 ENDIF
4470: 
4471:                 IF par_cTipo = "A"
4472:                     IF VARTYPE(THIS.this_oFormAnterior) = "O"
4473:                         IF PEMSTATUS(THIS.this_oFormAnterior, "Enabled", 5)
4474:                             THIS.this_oFormAnterior.Enabled = .T.
4475:                         ENDIF
4476:                     ENDIF
4477:                     THIS.Release()
4478:                 ELSE

*-- Linhas 4493 a 4595:
4493:     * de etiqueta dinamicos, carga das linhas da grade por
4494:     * ParentForm.Tipo, impressoras e os ajustes finais.
4495:     *
4496:     * Chamado por InicializarForm, logo depois de ConfigurarEventosPrin-
4497:     * cipais (ver cabecalho do arquivo, secao da Fase 8).
4498:     *
4499:     * TRY/CATCH PROPRIO que NUNCA propaga: o legado so aborta o Init com
4500:     * "Return 0" em falha de CONEXAO (".poDataGrv.pnIdconn <= 0", nao
4501:     * implementada nesta fase - ver nota abaixo); SigCdTpe/SigCdmp vazios
4502:     * sao caminho legitimo (grade abre, so sem tipo/impressora
4503:     * disponivel). Travar a abertura da tela aqui seria regressao frente
4504:     * ao legado.
4505:     *
4506:     * poDataGrv/fSqlConector (dump 2621-2630, AddCursor de SigEtOcr/
4507:     * SigMvCab/SigMvItn/SigMvIts) NAO entra: eh um wrapper de acesso a
4508:     * dados que o resto do projeto substitui por SQLEXEC direto, e os
4509:     * quatro cursores que ele abriria (crSigEtOcr/crSigMvCab/crSigMvItn/
4510:     * crSigMvIts) ja sao lidos com guarda USED() pelas Fases 5-7 (ex.
4511:     * GarantirCursorImpressao) assumindo que podem nao existir -
4512:     * implementa-lo seria trazer uma camada de acesso a dados inteira
4513:     * para uma fase que so precisa de quatro cursores especificos
4514:     * (LocalParam/LocalParaC/LocalTpEti/crImpreV, ja fixados como
4515:     * contrato pelas Fases 5-7).
4516:     *==========================================================================
4517:     PROTECTED PROCEDURE CarregarContextoInicial()
4518:         LOCAL loc_oErro
4519: 
4520:         TRY
4521:             *-- Legado: "Thisform.grd_Historico.Column2.Header1.Tag = []"
4522:             THIS.grd_4c_Dados.Column2.Header1.Tag = ""
4523: 
4524:             *-- Legado: If (Type([ThisForm.ParentForm.Chk_Preco])=[O]) /
4525:             *-- opt_Preco.Value = ParentForm.Chk_Preco.Value
4526:             IF VARTYPE(THIS.this_oFormAnterior) = "O"
4527:                 IF PEMSTATUS(THIS.this_oFormAnterior, "Chk_Preco", 5)
4528:                     IF VARTYPE(THIS.this_oFormAnterior.Chk_Preco) = "O"
4529:                         IF PEMSTATUS(THIS.this_oFormAnterior.Chk_Preco, "Value", 5)
4530:                             THIS.obj_4c_Opt_Preco.Value = THIS.this_oFormAnterior.Chk_Preco.Value
4531:                         ENDIF
4532:                     ENDIF
4533:                 ENDIF
4534:             ENDIF
4535: 
4536:             *-- Legado: If Type('pnordem')=[U] / Ordemimp=1 / Else / =PnOrdem
4537:             IF TYPE("pnordem") != "U"
4538:                 THIS.this_nOrdemImp = pnordem
4539:             ENDIF
4540: 
4541:             THIS.CarregarParametrosSistema()
4542:             THIS.AtualizarVisibilidadeOcorrencia()
4543:             THIS.CarregarTiposEtiquetaDinamico()
4544:             THIS.CarregarLinhasPorTipoChamador()
4545:             THIS.CarregarImpressorasEtiqueta()
4546:             THIS.AplicarDefaultsImpressora()
4547:             THIS.AjustarBotaoImprimirPorContexto()
4548:             THIS.AjustarReadOnlyQtdsPorLibObss()
4549:             THIS.ConfigurarModoDigitacao()
4550:             THIS.GetPrinterInteractiveChange()
4551:         CATCH TO loc_oErro
4552:             THIS.this_cMensagemErro = loc_oErro.Message
4553:             MsgErro(loc_oErro.Message + CHR(13) + ;
4554:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4555:                 "Procedure: " + loc_oErro.Procedure, ;
4556:                 "Erro em CarregarContextoInicial")
4557:         ENDTRY
4558:     ENDPROC
4559: 
4560:     *==========================================================================
4561:     * CarregarParametrosSistema - LocalParam/LocalParaC (SigCdPam/SigCdPaC),
4562:     * tabelas de UMA linha so - mesma leitura "SELECT sem WHERE" que o
4563:     * irmao sigopetsBO documenta para CrSigCdPam/CrSigCdPac.
4564:     *
4565:     * Legado (Init:2632-2634):
4566:     *   lcCpo = 'OcoEtiqs, Ouros, nMaxTpEtis, TpEtiPads, nMaxImpEti, ImpEtis,
4567:     *            AjVerts, AjHorzs, LibObss, TpInstalas'
4568:     *   CursorQuery('SigCdPam', 'LocalParam', .F., .F., lcCpo)
4569:     *   CursorQuery('SigCdPaC', 'LocalParaC', .F., .F., 'AjDens, AjVelos,
4570:     *            EtqSeps, DopEtiqs, QtdMarPar, VlrMinPar')
4571:     *
4572:     * SQLEXEC com SELECT explicito (nunca SELECT *) - colunas conferidas
4573:     * em docs\schema.sql (UTF-16, Get-Content -Raw).
4574:     *==========================================================================
4575:     PROTECTED FUNCTION CarregarParametrosSistema()
4576:         LOCAL loc_lSucesso, loc_nResultado, loc_oErro
4577: 
4578:         loc_lSucesso = .F.
4579: 
4580:         TRY
4581:             IF USED("LocalParam")
4582:                 USE IN LocalParam
4583:             ENDIF
4584: 
4585:             loc_nResultado = SQLEXEC(gnConnHandle, ;
4586:                 "SELECT OcoEtiqs, Ouros, nMaxTpEtis, TpEtiPads, nMaxImpEti, " + ;
4587:                 "ImpEtis, AjVerts, AjHorzs, LibObss, TpInstalas FROM SigCdPam", ;
4588:                 "LocalParam")
4589: 
4590:             IF loc_nResultado >= 1 AND USED("LocalParam")
4591:                 IF USED("LocalParaC")
4592:                     USE IN LocalParaC
4593:                 ENDIF
4594: 
4595:                 loc_nResultado = SQLEXEC(gnConnHandle, ;

*-- Linhas 4626 a 4707:
4626:     * ParentForm.pcEscolha (guarda dupla - o chamador eh arbitrario,
4627:     * mesmo criterio de ObterTipoChamador).
4628:     *==========================================================================
4629:     PROTECTED PROCEDURE AtualizarVisibilidadeOcorrencia()
4630:         LOCAL loc_cEscolha, loc_lTemEscolha
4631: 
4632:         loc_lTemEscolha = .F.
4633:         loc_cEscolha    = ""
4634: 
4635:         IF VARTYPE(THIS.this_oFormAnterior) = "O"
4636:             IF PEMSTATUS(THIS.this_oFormAnterior, "pcEscolha", 5)
4637:                 IF VARTYPE(THIS.this_oFormAnterior.pcEscolha) = "C"
4638:                     loc_lTemEscolha = .T.
4639:                     loc_cEscolha    = THIS.this_oFormAnterior.pcEscolha
4640:                 ENDIF
4641:             ENDIF
4642:         ENDIF
4643: 
4644:         IF loc_lTemEscolha AND loc_cEscolha != "INSERIR" AND ;
4645:                 USED("LocalParam") AND LocalParam.OcoEtiqs = 1
4646:             THIS.this_lGravaOcorrencia      = .T.
4647:             THIS.txt_4c_OcoEtiqs.Visible    = .T.
4648:             THIS.txt_4c_DOcoEtiqs.Visible   = .T.
4649:             THIS.lbl_4c_LblOcoEtiqs.Visible = .T.
4650:             THIS.shp_4c_ShpOcoEtiqs.Visible = .T.
4651:             THIS.obj_4c_GetJustifs.Visible  = .T.
4652:             THIS.lbl_4c_LblJustifs.Visible  = .T.
4653:             THIS.shp_4c_ShpJustifs.Visible  = .T.
4654:         ENDIF
4655:     ENDPROC
4656: 
4657:     *==========================================================================
4658:     * CarregarTiposEtiquetaDinamico - popula LocalTpEti (SigCdTpe) e os
4659:     * Buttons de obj_4c_Opt_Tipo em runtime - substitui o unico botao
4660:     * TRANSCRITO na Fase 5 ("\<a. Rabicho", so a geometria base do SCX).
4661:     *
4662:     * Legado (Init:3098-3152): CursorQuery('SigCdTpe','LocalTpEti') /
4663:     * Index On cOrdems+cEtiquetas Tag skOrdems For nSituas=1 / Count To
4664:     * lnTipos For nSituas=1 / monta ButtonCount = Min(lnTipos,
4665:     * Max(LocalParam.nMaxTpEtis,5)) botoes com Caption/ForeColor/Tag/Top,
4666:     * casa o indice padrao com LocalParam.TpEtiPads e chama
4667:     * .InteractiveChange() no fim.
4668:     *
4669:     * O ORDER BY substitui o INDEX ON...FOR (mesmo padrao do irmao
4670:     * sigopetsBO.CarregarTiposEtiqueta) - o cursor ja chega filtrado e
4671:     * ordenado, sem precisar de indice local.
4672:     *
4673:     * Ramo "zero tipos": MANTEM o unico botao que a Fase 5 ja criou (nao
4674:     * sobrescreve - decisao desta fase, ver cabecalho do arquivo). So
4675:     * importa no caso-limite de SigCdTpe sem nenhuma linha nSituas=1, que
4676:     * nao acontece em producao.
4677:     *==========================================================================
4678:     PROTECTED FUNCTION CarregarTiposEtiquetaDinamico()
4679:         LOCAL loc_lSucesso, loc_nResultado, loc_oGrupo, loc_nTotalTipos, ;
4680:               loc_nMaxBotoes, loc_nIndicePadrao, loc_nI, loc_nTop, ;
4681:               loc_oBotao, loc_oErro
4682: 
4683:         loc_lSucesso = .F.
4684:         loc_oGrupo   = THIS.obj_4c_Opt_Tipo
4685: 
4686:         TRY
4687:             IF USED("LocalTpEti")
4688:                 USE IN LocalTpEti
4689:             ENDIF
4690: 
4691:             loc_nResultado = SQLEXEC(gnConnHandle, ;
4692:                 "SELECT * FROM SigCdTpe WHERE nSituas = 1 ORDER BY cOrdems, cEtiquetas", ;
4693:                 "LocalTpEti")
4694: 
4695:             loc_nTotalTipos = IIF(loc_nResultado >= 1 AND USED("LocalTpEti"), ;
4696:                 RECCOUNT("LocalTpEti"), 0)
4697:             THIS.this_nTotalTiposEtiqueta = loc_nTotalTipos
4698: 
4699:             IF loc_nTotalTipos != 0 AND USED("LocalParam")
4700:                 loc_nMaxBotoes = MIN(loc_nTotalTipos, MAX(LocalParam.nMaxTpEtis, 5))
4701:                 loc_oGrupo.ButtonCount = loc_nMaxBotoes
4702: 
4703:                 loc_nIndicePadrao = 1
4704:                 loc_nTop          = 10
4705: 
4706:                 SELECT LocalTpEti
4707:                 GO TOP

*-- Linhas 4730 a 4879:
4730:                 loc_oGrupo.Value   = loc_nIndicePadrao
4731:             ENDIF
4732: 
4733:             THIS.OptTipoInteractiveChange()
4734: 
4735:             loc_lSucesso = .T.
4736:         CATCH TO loc_oErro
4737:             loc_lSucesso = .F.
4738:             THIS.this_cMensagemErro = loc_oErro.Message
4739:             MsgErro(loc_oErro.Message + CHR(13) + ;
4740:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em CarregarTiposEtiquetaDinamico")
4741:         ENDTRY
4742: 
4743:         RETURN loc_lSucesso
4744:     ENDFUNC
4745: 
4746:     *==========================================================================
4747:     * CarregarLinhasPorTipoChamador - dispatcher dos SEIS ramos de carga
4748:     * de linha por ParentForm.Tipo (DIGITACAO fica fora - ver
4749:     * ConfigurarModoDigitacao, chamado separadamente no funil da Fase 8).
4750:     *
4751:     * Legado: "Zap In DbEtiqueta" (2713) roda SEMPRE antes do primeiro
4752:     * ramo de Tipo - reproduzido aqui porque CarregarContextoInicial pode
4753:     * rodar mais de uma vez na vida do form (nao deveria neste form sem
4754:     * pagina de dados real, mas evita cursor acumulando linha duplicada
4755:     * se algum caminho futuro chamar de novo).
4756:     *
4757:     * PUBLIC de proposito, como MontaGradeEtiquetas: funil publicamente
4758:     * chamavel (regras CLAUDE.md #3/#51).
4759:     *==========================================================================
4760:     PROCEDURE CarregarLinhasPorTipoChamador()
4761:         LOCAL loc_cTipo
4762: 
4763:         IF USED(THIS.this_cCursorEtiquetas)
4764:             ZAP IN (THIS.this_cCursorEtiquetas)
4765:         ENDIF
4766: 
4767:         loc_cTipo = THIS.ObterTipoChamador()
4768: 
4769:         DO CASE
4770:         CASE loc_cTipo == "UNITARIO"
4771:             THIS.CarregarLinhasUnitario()
4772:         CASE loc_cTipo == "OPERACAO"
4773:             THIS.CarregarLinhasOperacao()
4774:         CASE loc_cTipo == "DIVERSAS"
4775:             THIS.CarregarLinhasDiversas()
4776:         CASE loc_cTipo == "ARQUIVADAS"
4777:             THIS.CarregarLinhasArquivadas()
4778:         CASE loc_cTipo == "CADASTRO"
4779:             THIS.CarregarLinhasCadastro()
4780:         CASE loc_cTipo == "CONSULTA"
4781:             THIS.CarregarLinhasConsulta()
4782:         ENDCASE
4783:     ENDPROC
4784: 
4785:     *==========================================================================
4786:     * CarregarLinhasUnitario - Tipo='UNITARIO' (dump 2715-2728): uma unica
4787:     * etiqueta, barcode em ParentForm.Produto (NUMERICO aqui - o mesmo
4788:     * nome de property eh STRING no ramo CADASTRO, ver
4789:     * CarregarLinhasCadastro).
4790:     *==========================================================================
4791:     PROTECTED PROCEDURE CarregarLinhasUnitario()
4792:         LOCAL loc_nBarra, loc_cCursor, loc_nResultado, loc_oErro
4793: 
4794:         loc_cCursor = THIS.this_cCursorEtiquetas
4795:         loc_nBarra  = 0
4796: 
4797:         IF VARTYPE(THIS.this_oFormAnterior) = "O"
4798:             IF PEMSTATUS(THIS.this_oFormAnterior, "Produto", 5)
4799:                 IF VARTYPE(THIS.this_oFormAnterior.Produto) = "N"
4800:                     loc_nBarra = THIS.this_oFormAnterior.Produto
4801:                 ENDIF
4802:             ENDIF
4803:         ENDIF
4804: 
4805:         TRY
4806:             IF USED("LocalEti")
4807:                 USE IN LocalEti
4808:             ENDIF
4809: 
4810:             loc_nResultado = SQLEXEC(gnConnHandle, ;
4811:                 "SELECT * FROM SigOpEtq WHERE CBars = " + TRANSFORM(loc_nBarra), "LocalEti")
4812: 
4813:             IF loc_nResultado >= 1 AND USED("LocalEti") AND !EOF("LocalEti") AND USED(loc_cCursor)
4814:                 SELECT LocalEti
4815:                 SCATTER MEMVAR
4816:                 m.Flag = .T.
4817:                 INSERT INTO (loc_cCursor) FROM MEMVAR
4818:             ENDIF
4819:         CATCH TO loc_oErro
4820:             THIS.this_cMensagemErro = loc_oErro.Message
4821:             MsgErro(loc_oErro.Message + CHR(13) + ;
4822:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em CarregarLinhasUnitario")
4823:         ENDTRY
4824:     ENDPROC
4825: 
4826:     *==========================================================================
4827:     * CarregarLinhasOperacao - Tipo='OPERACAO' (dump 2730-2775): as
4828:     * etiquetas vem do cursor dbImpressao que o form PAI (SigMvCab) ja
4829:     * deixou aberto (contrato entre forms - nao se recria aqui, so se le
4830:     * com guarda USED()).
4831:     *
4832:     * Column6(name)/migrado Column9 (pVens/Preco) vira editavel aqui -
4833:     * ver tabela de renomeacao de Column em ConfigurarGrade: a NAME
4834:     * "Column6" do legado eh a coluna criada na POSICAO 9 deste form
4835:     * (pVens), NAO a Quantidade (essa eh a NAME "Column7" = posicao 6,
4836:     * migrada Column6 - ReadOnly dela eh LibObss, ver AjustarReadOnly-
4837:     * QtdsPorLibObss).
4838:     *==========================================================================
4839:     PROTECTED PROCEDURE CarregarLinhasOperacao()
4840:         LOCAL loc_cCursor, loc_nBarra, loc_nResultado, loc_lDistribui, loc_oErro
4841: 
4842:         loc_cCursor = THIS.this_cCursorEtiquetas
4843: 
4844:         THIS.grd_4c_Dados.Column9.ReadOnly = .F.
4845: 
4846:         TRY
4847:             IF USED("dbImpressao")
4848:                 SELECT dbImpressao
4849:                 SCAN
4850:                     loc_nBarra = INT(VAL(dbImpressao.Cpros))
4851: 
4852:                     IF USED("LocalEti")
4853:                         USE IN LocalEti
4854:                     ENDIF
4855:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
4856:                         "SELECT * FROM SigOpEtq WHERE CBars = " + TRANSFORM(loc_nBarra), "LocalEti")
4857: 
4858:                     IF loc_nResultado >= 1 AND USED("LocalEti")
4859:                         SELECT LocalEti
4860:                         SCATTER MEMVAR
4861:                         m.Flag = .T.
4862:                         m.Qtds = dbImpressao.Qtds
4863: 
4864:                         IF USED("LocalPro")
4865:                             USE IN LocalPro
4866:                         ENDIF
4867:                         SQLEXEC(gnConnHandle, "SELECT CUniPs, cGrus, Categoria FROM SigCdPro " + ;
4868:                             "WHERE CPros = " + EscaparSQL(LocalEti.Cpros), "LocalPro")
4869: 
4870:                         loc_lDistribui = .F.
4871:                         IF USED("LocalPro") AND !EOF("LocalPro")
4872:                             IF USED("LocalUni")
4873:                                 USE IN LocalUni
4874:                             ENDIF
4875:                             SQLEXEC(gnConnHandle, "SELECT Distribs FROM SigCdUni WHERE CUnis = " + ;
4876:                                 EscaparSQL(LocalPro.CUniPs), "LocalUni")
4877: 
4878:                             IF USED("LocalUni") AND !EOF("LocalUni") AND LocalUni.Distribs = 1
4879:                                 loc_lDistribui = .T.

*-- Linhas 4922 a 5007:
4922:     * CarregarLinhasDiversas - Tipo='DIVERSAS' (dump 2777-2793): varias
4923:     * etiquetas passadas no cursor csRelatorio (contrato do form pai).
4924:     *==========================================================================
4925:     PROTECTED PROCEDURE CarregarLinhasDiversas()
4926:         LOCAL loc_cCursor, loc_nBarra, loc_nResultado, loc_oErro
4927: 
4928:         loc_cCursor = THIS.this_cCursorEtiquetas
4929: 
4930:         TRY
4931:             IF USED("csRelatorio")
4932:                 SELECT csRelatorio
4933:                 SCAN
4934:                     loc_nBarra = csRelatorio.CBars
4935: 
4936:                     IF USED("LocalEti")
4937:                         USE IN LocalEti
4938:                     ENDIF
4939:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
4940:                         "SELECT * FROM SigOpEtq WHERE CBars = " + TRANSFORM(loc_nBarra), "LocalEti")
4941: 
4942:                     IF loc_nResultado >= 1 AND USED("LocalEti") AND !EOF("LocalEti") AND USED(loc_cCursor)
4943:                         SELECT LocalEti
4944:                         SCATTER MEMVAR
4945:                         m.Flag = .T.
4946:                         INSERT INTO (loc_cCursor) FROM MEMVAR
4947:                     ENDIF
4948: 
4949:                     SELECT csRelatorio
4950:                 ENDSCAN
4951:             ENDIF
4952:         CATCH TO loc_oErro
4953:             THIS.this_cMensagemErro = loc_oErro.Message
4954:             MsgErro(loc_oErro.Message + CHR(13) + ;
4955:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em CarregarLinhasDiversas")
4956:         ENDTRY
4957:     ENDPROC
4958: 
4959:     *==========================================================================
4960:     * CarregarLinhasArquivadas - Tipo='ARQUIVADAS' (dump 2795-2846):
4961:     * chamado do SigPrRet (reimpressao individual) - todas as etiquetas
4962:     * dos produtos marcados com ImpEtiqs=1, uma por EmpOs+Grupos+Contas+
4963:     * CPros+CBars+pesos+qtds+datas, mantendo so as que o ULTIMO usuario a
4964:     * alterar o preco (SigCdPrc) foi o usuario logado (ou nenhum
4965:     * historico ainda).
4966:     *==========================================================================
4967:     PROTECTED PROCEDURE CarregarLinhasArquivadas()
4968:         LOCAL loc_cCursor, loc_cQuery, loc_nResultado, loc_oErro
4969: 
4970:         loc_cCursor = THIS.this_cCursorEtiquetas
4971: 
4972:         THIS.grd_4c_Dados.Column4.ReadOnly = .T.
4973: 
4974:         TRY
4975:             loc_cQuery = "SELECT c.EmpOs, c.Grupos, c.Contas, a.CPros, c.CBars, " + ;
4976:                 "c.pesos, c.qtds, c.datas, a.pvens, a.precode, a.cGrus, a.Categoria " + ;
4977:                 "FROM SigCdPro a, SigOpEtq c " + ;
4978:                 "WHERE a.ImpEtiqs = 1 AND a.CPros = c.CPros " + ;
4979:                 "AND NOT c.Grupos = '" + SPACE(10) + "' " + ;
4980:                 "AND NOT c.Contas = '" + SPACE(10) + "' " + ;
4981:                 "GROUP BY c.EmpOs, c.Grupos, c.Contas, a.CPros, c.CBars, c.pesos, c.qtds, c.datas"
4982: 
4983:             IF USED("TmpTmp1")
4984:                 USE IN TmpTmp1
4985:             ENDIF
4986:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cQuery, "TmpTmp1")
4987: 
4988:             IF loc_nResultado < 1
4989:                 MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TmpTmp1)")
4990:             ELSE
4991:                 SELECT TmpTmp1
4992:                 SCAN
4993:                     loc_cQuery = "SELECT TOP 1 UsuaAlts FROM SigCdPrc WHERE CPros = " + ;
4994:                         EscaparSQL(TmpTmp1.Cpros) + " ORDER BY DataAlts DESC, HoraAlts DESC"
4995: 
4996:                     IF USED("TmpUltimo")
4997:                         USE IN TmpUltimo
4998:                     ENDIF
4999:                     SQLEXEC(gnConnHandle, loc_cQuery, "TmpUltimo")
5000: 
5001:                     IF USED("TmpUltimo")
5002:                         GO TOP IN TmpUltimo
5003: 
5004:                         IF (EOF("TmpUltimo") OR gc_4c_UsuarioLogado == TmpUltimo.UsuaAlts) AND USED(loc_cCursor)
5005:                             SELECT TmpTmp1
5006:                             SCATTER MEMVAR
5007:                             m.Flag = .T.

*-- Linhas 5030 a 5073:
5030:     * produto. ParentForm.Produto aqui eh STRING (CPros), diferente do
5031:     * ramo UNITARIO (mesmo nome de property, tipo NUMERICO la).
5032:     *==========================================================================
5033:     PROTECTED PROCEDURE CarregarLinhasCadastro()
5034:         LOCAL loc_cCursor, loc_cProduto, loc_cQuery, loc_nResultado, loc_oErro
5035: 
5036:         loc_cCursor  = THIS.this_cCursorEtiquetas
5037:         loc_cProduto = ""
5038: 
5039:         THIS.grd_4c_Dados.Column4.ReadOnly = .T.
5040: 
5041:         IF VARTYPE(THIS.this_oFormAnterior) = "O"
5042:             IF PEMSTATUS(THIS.this_oFormAnterior, "Produto", 5)
5043:                 IF VARTYPE(THIS.this_oFormAnterior.Produto) = "C"
5044:                     loc_cProduto = THIS.this_oFormAnterior.Produto
5045:                 ENDIF
5046:             ENDIF
5047:         ENDIF
5048: 
5049:         TRY
5050:             loc_cQuery = "SELECT b.*, a.pvens, a.precode, a.cGrus, a.Categoria " + ;
5051:                 "FROM SigOpEtq b JOIN SigCdpro a ON a.cpros = b.cpros " + ;
5052:                 "WHERE b.Cpros = " + EscaparSQL(loc_cProduto) + " " + ;
5053:                 "AND NOT b.Grupos = '" + SPACE(10) + "' " + ;
5054:                 "AND NOT b.Contas = '" + SPACE(10) + "'"
5055: 
5056:             IF USED("TmpTmp2")
5057:                 USE IN TmpTmp2
5058:             ENDIF
5059:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cQuery, "TmpTmp2")
5060: 
5061:             IF loc_nResultado < 1
5062:                 MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TmpTmp2)")
5063:             ELSE
5064:                 IF USED(loc_cCursor)
5065:                     SELECT TmpTmp2
5066:                     SCAN
5067:                         SCATTER MEMVAR
5068:                         m.Flag = .T.
5069:                         INSERT INTO (loc_cCursor) FROM MEMVAR
5070:                     ENDSCAN
5071:                 ENDIF
5072:             ENDIF
5073: 

*-- Linhas 5108 a 5151:
5108:     * Fecha com o DO CASE de ordenacao por THIS.this_nOrdemImp nas 5 TAG
5109:     * que CriarCursorEtiquetas (Fase 4) ja criou.
5110:     *==========================================================================
5111:     PROTECTED PROCEDURE CarregarLinhasConsulta()
5112:         LOCAL loc_cCursor, loc_cGdeGrupo, loc_cCol, loc_cOperacao, loc_nEtiqIni, ;
5113:               loc_nEtiqFim, loc_dDtInicial, loc_dDtFinal, loc_cEmpresa, ;
5114:               loc_cIndustria, loc_nNumero, loc_nNumerof, loc_cCdProduto, ;
5115:               loc_cGrEstoque, loc_cEstoque, loc_cLocaliza, loc_cGrupo, ;
5116:               loc_cSgrus, loc_cColecoes, loc_cPromos, loc_nQtdEti, ;
5117:               loc_nOptMarca, loc_cLinha, loc_cDepto, loc_cQuery, ;
5118:               loc_nResultado, loc_nBrI, loc_nBrF, loc_cDtI, loc_cDtF, ;
5119:               loc_cOpIn, loc_cOpFim, loc_nQtd, loc_oErro
5120: 
5121:         loc_cCursor = THIS.this_cCursorEtiquetas
5122: 
5123:         THIS.grd_4c_Dados.Column4.ReadOnly = .T.
5124: 
5125:         *-- Memvars PRIVATE/PUBLIC do chamador (SigPrRet) - guarda TYPE()
5126:         *-- igual ao Init legado para pcGdeGrupo/pcCol (2598-2604).
5127:         loc_cGdeGrupo  = IIF(TYPE("pcGdeGrupo")  != "U", pcGdeGrupo,  SPACE(3))
5128:         loc_cCol       = IIF(TYPE("pcCol")       != "U", pcCol,       SPACE(3))
5129:         loc_cOperacao  = IIF(TYPE("pcOperacao")  != "U", pcOperacao,  "")
5130:         loc_nEtiqIni   = IIF(TYPE("pnEtiqIni")   != "U", pnEtiqIni,   0)
5131:         loc_nEtiqFim   = IIF(TYPE("pnEtiqFim")   != "U", pnEtiqFim,   0)
5132:         loc_dDtInicial = IIF(TYPE("pdDtInicial") != "U", pdDtInicial, {})
5133:         loc_dDtFinal   = IIF(TYPE("pdDtFinal")   != "U", pdDtFinal,   {})
5134:         loc_cEmpresa   = IIF(TYPE("pcEmpresa")   != "U", pcEmpresa,   "")
5135:         loc_cIndustria = IIF(TYPE("pcIndustria") != "U", pcIndustria, "")
5136:         loc_nNumero    = IIF(TYPE("pnNumero")    != "U", pnNumero,    0)
5137:         loc_nNumerof   = IIF(TYPE("pnNumerof")   != "U", pnNumerof,   0)
5138:         loc_cCdProduto = IIF(TYPE("pcCdProduto") != "U", pcCdProduto, "")
5139:         loc_cGrEstoque = IIF(TYPE("pcGrEstoque") != "U", pcGrEstoque, "")
5140:         loc_cEstoque   = IIF(TYPE("pcEstoque")   != "U", pcEstoque,   "")
5141:         loc_cLocaliza  = IIF(TYPE("pcLocaliza")  != "U", pcLocaliza,  "")
5142:         loc_cGrupo     = IIF(TYPE("pcGrupo")     != "U", pcGrupo,     "")
5143:         loc_cSgrus     = IIF(TYPE("pcSgrus")     != "U", pcSgrus,     "")
5144:         loc_cColecoes  = IIF(TYPE("pcColecoes")  != "U", pcColecoes,  "")
5145:         loc_cPromos    = IIF(TYPE("pcPromos")    != "U", pcPromos,    "")
5146:         loc_nQtdEti    = IIF(TYPE("pnQtdEti")    != "U", pnQtdEti,    0)
5147:         loc_nOptMarca  = IIF(TYPE("OptMarca")    != "U", OptMarca,    0)
5148:         loc_cLinha     = IIF(TYPE("pcLinha")     != "U", pcLinha,     "")
5149:         loc_cDepto     = IIF(TYPE("pcDepto")     != "U", pcDepto,     "")
5150: 
5151:         TRY

*-- Linhas 5418 a 5461:
5418: 
5419:             IF loc_nPrinters <= 0
5420:                 THIS.this_cMensagemErro = "N" + CHR(227) + "o Foi Encontrada Nenhuma Impressora!!!"
5421:                 MsgAviso(THIS.this_cMensagemErro, "")
5422:             ELSE
5423:                 FOR loc_nI = 1 TO loc_nPrinters
5424:                     INSERT INTO crImpre (impres) VALUES (UPPER(loc_aPrinters[loc_nI, 1]))
5425:                 ENDFOR
5426: 
5427:                 loc_cSQL = "SELECT b.impres, b.ntpimpres FROM SigSyImp a, SigCdmp b " + ;
5428:                            "WHERE a.usuacess = " + EscaparSQL(gc_4c_UsuarioLogado) + " AND a.cimps = b.impres " + ;
5429:                            "UNION ALL " + ;
5430:                            "SELECT c.impres, c.ntpimpres FROM SigCdAcG a, SigSyImp b, SigCdmp c " + ;
5431:                            "WHERE a.usuarios = " + EscaparSQL(gc_4c_UsuarioLogado) + " " + ;
5432:                            "AND a.grupos = b.gracess AND b.cimps = c.impres"
5433: 
5434:                 IF USED("cursor_4c_ImpressorasTemp")
5435:                     USE IN cursor_4c_ImpressorasTemp
5436:                 ENDIF
5437:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpressorasTemp")
5438: 
5439:                 IF USED("crSigCdmp")
5440:                     USE IN crSigCdmp
5441:                 ENDIF
5442: 
5443:                 IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ImpressorasTemp") > 0
5444:                     SELECT impres, ntpimpres FROM cursor_4c_ImpressorasTemp ;
5445:                         INTO CURSOR crSigCdmp READWRITE
5446:                 ELSE
5447:                     CREATE CURSOR crSigCdmp (impres C(50), ntpimpres N(4, 0))
5448:                 ENDIF
5449: 
5450:                 IF USED("cursor_4c_ImpressorasTemp")
5451:                     USE IN cursor_4c_ImpressorasTemp
5452:                 ENDIF
5453: 
5454:                 IF USED("crImp")
5455:                     USE IN crImp
5456:                 ENDIF
5457: 
5458:                 SELECT PADR(ALLTRIM(a.impres), 15) + " " + ALLTRIM(b.impres) AS IDupla, ;
5459:                        b.impres, a.impres AS impresS ;
5460:                     FROM crSigCdmp a, crImpre b ;
5461:                     WHERE ALLTRIM(UPPER(a.impres)) LIKE "%" + ALLTRIM(UPPER(b.impres)) + "%" OR ;

*-- Linhas 5496 a 5618:
5496:     * AplicarDefaultsImpressora - Cnt_Impressora.Opcao_Imp/Spinners com os
5497:     * defaults de LocalParam/LocalParaC (Init:3252-3261).
5498:     *==========================================================================
5499:     PROTECTED PROCEDURE AplicarDefaultsImpressora()
5500:         IF USED("LocalParam") AND USED("LocalParaC")
5501:             THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value   = IIF(LocalParam.ImpEtis != 0, LocalParam.ImpEtis, 1)
5502:             THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Value = LocalParam.AjVerts
5503:             THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Value = LocalParam.AjHorzs
5504:             THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Value = IIF(LocalParaC.AjDens <= 10, 10, LocalParaC.AjDens)
5505:             THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Value = LocalParaC.AjVelos
5506:         ENDIF
5507:     ENDPROC
5508: 
5509:     *==========================================================================
5510:     * AjustarBotaoImprimirPorContexto - Init:3263-3266: AND-a o Enabled do
5511:     * botao Imprimir (Buttons(4), ja decidido por AjustarBotoesPorTipo-
5512:     * Chamador) com "ha tipo de etiqueta configurado" e "ha impressora
5513:     * disponivel".
5514:     *
5515:     * O ".Value = Iif(.btnImprime.Enabled,1,2)" que acompanha no legado
5516:     * eh cosmetico (so decide qual botao aparece "pressionado" no
5517:     * CommandGroup - nao afeta Enabled/Click) e a correspondencia exata
5518:     * entre o indice legado e Buttons(N) migrado nao eh determinavel com
5519:     * certeza - OMITIDO de proposito, mesmo criterio documentado para
5520:     * Opt_Impressora.InteractiveChange em ConfigurarEventosPrincipais.
5521:     *==========================================================================
5522:     PROTECTED PROCEDURE AjustarBotaoImprimirPorContexto()
5523:         LOCAL loc_oBotaoImprimir
5524: 
5525:         loc_oBotaoImprimir = THIS.cmg_4c_CntBotoes.Buttons(4)
5526: 
5527:         loc_oBotaoImprimir.Enabled = loc_oBotaoImprimir.Enabled AND ;
5528:             (THIS.this_nTotalTiposEtiqueta != 0) AND (THIS.this_nTotalImpressoras != 0)
5529:     ENDPROC
5530: 
5531:     *==========================================================================
5532:     * AjustarReadOnlyQtdsPorLibObss - Init:3270: "Thisform.grd_Historico.
5533:     * Column7.ReadOnly = Iif(LocalParam.LibObss=1,.F.,.T.)". A NAME
5534:     * "Column7" do legado eh a coluna criada na POSICAO 6 deste form
5535:     * (Qtds/Quantidade - ver tabela de renomeacao em ConfigurarGrade),
5536:     * NAO a Observacao (essa eh a NAME "Column8" = posicao 7, migrada
5537:     * Column7). Sobrescreve o ReadOnly=.F. incondicional que
5538:     * FormatarColunasGrade ja aplica.
5539:     *==========================================================================
5540:     PROTECTED PROCEDURE AjustarReadOnlyQtdsPorLibObss()
5541:         IF USED("LocalParam")
5542:             THIS.grd_4c_Dados.Column6.ReadOnly = IIF(LocalParam.LibObss = 1, .F., .T.)
5543:             THIS.grd_4c_Dados.Refresh()
5544:         ENDIF
5545:     ENDPROC
5546: 
5547:     *==========================================================================
5548:     * ConfigurarModoDigitacao - Init:3273-3285: Tipo='DIGITACAO' (SigPrRet,
5549:     * reimpressao individual com codigo digitado a mao) remove a ordenacao,
5550:     * insere uma linha vazia e deixa o foco na coluna de codigo/barra
5551:     * editavel; todo o resto manda o foco para a grade.
5552:     *==========================================================================
5553:     PROTECTED PROCEDURE ConfigurarModoDigitacao()
5554:         LOCAL loc_cCursor
5555: 
5556:         loc_cCursor = THIS.this_cCursorEtiquetas
5557: 
5558:         IF THIS.ObterTipoChamador() == "DIGITACAO"
5559:             IF USED(loc_cCursor)
5560:                 SELECT (loc_cCursor)
5561:                 SET ORDER TO
5562:                 APPEND BLANK
5563:             ENDIF
5564: 
5565:             THIS.grd_4c_Dados.Column4.ReadOnly = .F.
5566:             THIS.grd_4c_Dados.Column4.SetFocus()
5567:         ELSE
5568:             THIS.grd_4c_Dados.SetFocus()
5569:         ENDIF
5570:     ENDPROC
5571: 
5572: ENDDEFINE
5573: 
5574: *==============================================================================
5575: * TextBoxCodBarrasIpE_4c - subclasse de TextBox para a Column4 (codigo de
5576: * barras) da grade. BINDEVENT em "Valid" de TextBox de Column nao eh
5577: * confiavel (regra CLAUDE.md #46) - GotFocus/Valid tem de ser METODO DE
5578: * CLASSE, delegando para THISFORM, igual ao padrao TextBoxProdutoLpr_4c
5579: * (FormLpr.prg).
5580: *==============================================================================
5581: DEFINE CLASS TextBoxCodBarrasIpE_4c AS TextBox
5582:     PROCEDURE GotFocus()
5583:         THIS.Tag = STR(NVL(THIS.Value, 0), 14)
5584:     ENDPROC
5585: 
5586:     PROCEDURE Valid()
5587:         LOCAL loc_lRetorno
5588:         loc_lRetorno = .T.
5589:         IF PEMSTATUS(THISFORM, "ValidarCodigoBarrasGrade", 5)
5590:             loc_lRetorno = THISFORM.ValidarCodigoBarrasGrade(THIS)
5591:         ENDIF
5592:         RETURN loc_lRetorno
5593:     ENDPROC
5594: ENDDEFINE
5595: 
5596: *==============================================================================
5597: * TextBoxParcelasIpE_4c - subclasse de TextBox para a Column10 (parcelas)
5598: * da grade. Mesmo motivo da TextBoxCodBarrasIpE_4c acima.
5599: *==============================================================================
5600: DEFINE CLASS TextBoxParcelasIpE_4c AS TextBox
5601:     PROCEDURE When()
5602:         LOCAL loc_lPode
5603:         loc_lPode = .T.
5604:         IF PEMSTATUS(THISFORM, "PodeEditarParcelas", 5)
5605:             loc_lPode = THISFORM.PodeEditarParcelas()
5606:         ENDIF
5607:         RETURN loc_lPode
5608:     ENDPROC
5609: 
5610:     PROCEDURE Valid()
5611:         LOCAL loc_lRetorno
5612:         loc_lRetorno = .T.
5613:         IF PEMSTATUS(THISFORM, "ValidarParcelasGrade", 5)
5614:             loc_lRetorno = THISFORM.ValidarParcelasGrade(THIS)
5615:         ENDIF
5616:         RETURN loc_lRetorno
5617:     ENDPROC
5618: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpIpEBO.prg):
*==============================================================================
* SigOpIpEBO.PRG
* Business Object para Impressao/Reimpressao de Etiquetas (SIGOPIPE)
*
* Tabela Principal: SigMvIts (itens de movimento com codigo de barras/cor/tamanho)
*                    char(3) emps, char(20) dopes, numeric(6,0) numes,
*                    char(14) cpros, char(4) codtams/codcors, numeric(14,0) codbarras
*                    PK: cidchaves char(20)
*
* Origem: form legado SIGOPIPE monta um cursor local de etiquetas selecionadas
* (DbEtiqueta, a partir de SigOpEtq) e, ao confirmar a opcao "Impressao Imediata"
* com geracao de operacao, grava um movimento em SigMvCab/SigMvItn/SigMvIts.
* Este BO cobre a persistencia em SigMvIts (o item de movimento com o codigo
* de barras/cor/tamanho da etiqueta impressa).
*==============================================================================

DEFINE CLASS SigOpIpEBO AS BusinessBase

    *-- Propriedades da entidade (SigMvIts)
    this_nCitens       = 0    && citens       numeric(4,0)  - Numero sequencial do item
    this_cEmps         = ""   && emps         char(3)       - Codigo da empresa
    this_cDopes        = ""   && dopes        char(20)      - Codigo da operacao
    this_nNumes        = 0    && numes        numeric(6,0)  - Numero do movimento
    this_cCpros        = ""   && cpros        char(14)      - Codigo do produto
    this_cCodembs      = ""   && codembs      char(3)       - Codigo da embalagem
    this_cCodtams      = ""   && codtams      char(4)       - Codigo do tamanho
    this_cCodcors      = ""   && codcors      char(4)       - Codigo da cor
    this_nQtds         = 0    && qtds         numeric(9,3)  - Quantidade
    this_nAqtds        = 0    && aqtds        numeric(9,3)  - Quantidade anterior
    this_nQtdembs      = 0    && qtdembs      numeric(5,1)  - Quantidade por embalagem
    this_nAqtdembs     = 0    && aqtdembs     numeric(5,1)  - Quantidade por embalagem anterior
    this_nQtbaixas     = 0    && qtbaixas     numeric(9,3)  - Quantidade baixada
    this_nPrembs       = 0    && prembs       numeric(9,3)  - Peso da embalagem
    this_cCodembents   = ""   && codembents   char(3)       - Codigo da embalagem de entrada
    this_nQtdents      = 0    && qtdents      numeric(9,3)  - Quantidade de entrada
    this_nCodbarras    = 0    && codbarras    numeric(14,0) - Codigo de barras da etiqueta
    this_nPesos        = 0    && pesos        numeric(9,3)  - Peso
    this_nQtbxprods    = 0    && qtbxprods    numeric(9,3)  - Quantidade baixada do produto
    this_nQtprods      = 0    && qtprods      numeric(9,3)  - Quantidade do produto
    this_dDatatrans    = {}   && datatrans    datetime NULL - Data da transferencia
    this_cLocals       = ""   && locals       char(10)      - Local
    this_nNtrans       = 0    && ntrans       numeric(6,0)  - Numero da transferencia
    this_nQtreservas   = 0    && qtreservas   numeric(9,3)  - Quantidade reservada
    this_cCidchaves    = ""   && cidchaves    char(20)      - Chave unica (PK)
    this_cEmpdopnums   = ""   && empdopnums   char(29)      - Chave composta emps+dopes+numes
    this_lChksubn      = .F.  && chksubn      bit           - Checksum/flag de substituicao
    this_nCompris      = 0    && compris      numeric(6,2)  - Comprimento
    this_dDtalts       = {}   && dtalts       datetime NULL - Data da ultima alteracao
    this_cChaveexterna = ""   && chaveexterna char(33)      - Chave externa de integracao

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigMvIts"
        THIS.this_cCampoChave = "cidchaves"

        RETURN .T.
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas de SigMvIts a partir do
    * registro corrente do cursor informado (cursor_4c_Dados ou outro
    * alias com a mesma estrutura, ex. retorno de CarregarPorCodigo)
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                IF !EOF()
                    THIS.this_nCitens       = TratarNulo(citens,       0)
                    THIS.this_cEmps         = TratarNulo(emps,         "")
                    THIS.this_cDopes        = TratarNulo(dopes,        "")
                    THIS.this_nNumes        = TratarNulo(numes,        0)
                    THIS.this_cCpros        = TratarNulo(cpros,        "")
                    THIS.this_cCodembs      = TratarNulo(codembs,      "")
                    THIS.this_cCodtams      = TratarNulo(codtams,      "")
                    THIS.this_cCodcors      = TratarNulo(codcors,      "")
                    THIS.this_nQtds         = TratarNulo(qtds,         0)
                    THIS.this_nAqtds        = TratarNulo(aqtds,        0)
                    THIS.this_nQtdembs      = TratarNulo(qtdembs,      0)
                    THIS.this_nAqtdembs     = TratarNulo(aqtdembs,     0)
                    THIS.this_nQtbaixas     = TratarNulo(qtbaixas,     0)
                    THIS.this_nPrembs       = TratarNulo(prembs,       0)
                    THIS.this_cCodembents   = TratarNulo(codembents,   "")
                    THIS.this_nQtdents      = TratarNulo(qtdents,      0)
                    THIS.this_nCodbarras    = TratarNulo(codbarras,    0)
                    THIS.this_nPesos        = TratarNulo(pesos,        0)
                    THIS.this_nQtbxprods    = TratarNulo(qtbxprods,    0)
                    THIS.this_nQtprods      = TratarNulo(qtprods,      0)
                    THIS.this_dDatatrans    = ConverterParaData(TratarNulo(datatrans, {}))
                    THIS.this_cLocals       = TratarNulo(locals,       "")
                    THIS.this_nNtrans       = TratarNulo(ntrans,       0)
                    THIS.this_nQtreservas   = TratarNulo(qtreservas,   0)
                    THIS.this_cCidchaves    = TratarNulo(cidchaves,    "")
                    THIS.this_cEmpdopnums   = TratarNulo(empdopnums,   "")
                    THIS.this_lChksubn      = ConverterParaLogico(chksubn)
                    THIS.this_nCompris      = TratarNulo(compris,      0)
                    THIS.this_dDtalts       = ConverterParaData(TratarNulo(dtalts, {}))
                    THIS.this_cChaveexterna = TratarNulo(chaveexterna, "")

                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * MontarChaveEmpDopNums - Chave POSICIONAL Emps+Dopes+Str(Numes,6)
    * (char(3) + char(20) + str(6) = char(29), igual a coluna EmpDopNums).
    * PADR explicito em cada parte - o padding FAZ PARTE da chave (NUNCA
    * ALLTRIM nas partes internas, so na chave inteira se preciso).
    *====================================================================
    FUNCTION MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
        RETURN PADR(TratarNulo(par_cEmps, ""), 3) + ;
               PADR(TratarNulo(par_cDopes, ""), 20) + ;
               STR(TratarNulo(par_nNumes, 0), 6)
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Chave primaria real da tabela (cidchaves)
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *====================================================================
    * Inserir - INSERT INTO SigMvIts (PROTECTED, chamado por Salvar())
    * Gera cidchaves via fUniqueIds() quando ainda nao preenchida (chave
    * unica Fortyus, regra CLAUDE.md #22 - NUNCA deixar em branco, senao
    * o 2o registro colide no indice unico) e recalcula empdopnums a
    * partir de Emps+Dopes+Numes (regra CLAUDE.md #42).
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidchaves))
                THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
            ENDIF

            THIS.this_cEmpdopnums = THIS.MontarChaveEmpDopNums(THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes)

            loc_cSQL = "INSERT INTO SigMvIts (citens, emps, dopes, numes, cpros, codembs, " + ;
                       "codtams, codcors, qtds, aqtds, qtdembs, aqtdembs, qtbaixas, prembs, " + ;
                       "codembents, qtdents, codbarras, pesos, qtbxprods, qtprods, datatrans, " + ;
                       "locals, ntrans, qtreservas, cidchaves, empdopnums, chksubn, compris, " + ;
                       "dtalts, chaveexterna) VALUES (" + ;
                       FormatarNumeroSQL(THIS.this_nCitens, 0) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cEmps, 3)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cDopes, 20)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumes, 0) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCodembs, 3)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCodtams, 4)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCodcors, 4)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtds, 3) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAqtds, 3) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdembs, 1) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAqtdembs, 1) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtbaixas, 3) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPrembs, 3) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCodembents, 3)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdents, 3) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCodbarras, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPesos, 3) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtbxprods, 3) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtprods, 3) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatatrans) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNtrans, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtreservas, 3) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ", " + ;
                       FormatarNumeroSQL(IIF(THIS.this_lChksubn, 1, 0), 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCompris, 2) + ", " + ;
                       FormatarDataSQL(THIS.this_dDtalts) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cChaveexterna, 33)) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsIts")
            IF USED("cursor_4c_InsIts")
                USE IN cursor_4c_InsIts
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir item de movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE SigMvIts (PROTECTED, chamado por Salvar())
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidchaves))
                MsgErro("Chave prim" + CHR(225) + "ria n" + CHR(227) + "o informada para altera" + CHR(231) + CHR(227) + "o", "Erro")
            ELSE
                THIS.this_cEmpdopnums = THIS.MontarChaveEmpDopNums(THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes)

                loc_cSQL = "UPDATE SigMvIts SET " + ;
                           "citens = "       + FormatarNumeroSQL(THIS.this_nCitens, 0) + ", " + ;
                           "emps = "         + EscaparSQL(PADR(THIS.this_cEmps, 3)) + ", " + ;
                           "dopes = "        + EscaparSQL(PADR(THIS.this_cDopes, 20)) + ", " + ;
                           "numes = "        + FormatarNumeroSQL(THIS.this_nNumes, 0) + ", " + ;
                           "cpros = "        + EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ", " + ;
                           "codembs = "      + EscaparSQL(LEFT(THIS.this_cCodembs, 3)) + ", " + ;
                           "codtams = "      + EscaparSQL(LEFT(THIS.this_cCodtams, 4)) + ", " + ;
                           "codcors = "      + EscaparSQL(LEFT(THIS.this_cCodcors, 4)) + ", " + ;
                           "qtds = "         + FormatarNumeroSQL(THIS.this_nQtds, 3) + ", " + ;
                           "aqtds = "        + FormatarNumeroSQL(THIS.this_nAqtds, 3) + ", " + ;
                           "qtdembs = "      + FormatarNumeroSQL(THIS.this_nQtdembs, 1) + ", " + ;
                           "aqtdembs = "     + FormatarNumeroSQL(THIS.this_nAqtdembs, 1) + ", " + ;
                           "qtbaixas = "     + FormatarNumeroSQL(THIS.this_nQtbaixas, 3) + ", " + ;
                           "prembs = "       + FormatarNumeroSQL(THIS.this_nPrembs, 3) + ", " + ;
                           "codembents = "   + EscaparSQL(LEFT(THIS.this_cCodembents, 3)) + ", " + ;
                           "qtdents = "      + FormatarNumeroSQL(THIS.this_nQtdents, 3) + ", " + ;
                           "codbarras = "    + FormatarNumeroSQL(THIS.this_nCodbarras, 0) + ", " + ;
                           "pesos = "        + FormatarNumeroSQL(THIS.this_nPesos, 3) + ", " + ;
                           "qtbxprods = "    + FormatarNumeroSQL(THIS.this_nQtbxprods, 3) + ", " + ;
                           "qtprods = "      + FormatarNumeroSQL(THIS.this_nQtprods, 3) + ", " + ;
                           "datatrans = "    + FormatarDataSQL(THIS.this_dDatatrans) + ", " + ;
                           "locals = "       + EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ", " + ;
                           "ntrans = "       + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ", " + ;
                           "qtreservas = "   + FormatarNumeroSQL(THIS.this_nQtreservas, 3) + ", " + ;
                           "empdopnums = "   + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ", " + ;
                           "chksubn = "      + FormatarNumeroSQL(IIF(THIS.this_lChksubn, 1, 0), 0) + ", " + ;
                           "compris = "      + FormatarNumeroSQL(THIS.this_nCompris, 2) + ", " + ;
                           "dtalts = "       + FormatarDataSQL(THIS.this_dDtalts) + ", " + ;
                           "chaveexterna = " + EscaparSQL(LEFT(THIS.this_cChaveexterna, 33)) + ;
                           " WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AltIts")
                IF USED("cursor_4c_AltIts")
                    USE IN cursor_4c_AltIts
                ENDIF

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao alterar item de movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Ajustes de impressora (Fase 7) - Opt_Impressora/Get_Printer.
    * InteractiveChange do legado chamam a funcao global fCarregarImps()
    * (SIGFUNCS.PRG), que NAO veio no acervo extraido para esta task (ver
    * comportamento.json, "funcoesExternas"). Mesma decisao arquitetural
    * do BO irmao sigopetsBO (Formsigopets, tambem um dialogo de
    * impressao de etiquetas): reproduzir o efeito observavel lendo
    * SigCdmp pelas colunas que ela de fato tem, em vez de inventar o
    * corpo da funcao ausente.
    *====================================================================
    this_nTipoImpressora   = 0   && impetis (1=Allegro, 2=Zebra ZPL, 3=Zebra EPL)
    this_nAjusteVertical   = 0   && ajverts
    this_nAjusteHorizontal = 0   && ajhorzs
    this_nAjusteDensidade  = 0   && ajdens  (piso 10)
    this_nAjusteVelocidade = 0   && ajvelos (piso 1)

    *====================================================================
    * CarregarAjustesImpressora - Recarrega tipo/ajustes de impressao
    * quando o usuario troca a impressora no combobox (Get_Printer).
    * Legado: Get_Printer.InteractiveChange ->
    *   fCarregarImps(ALLTRIM(crImpreV.impresS), loImp.Opcao_Imp,
    *                 loImp.Spn_AjVerts, loImp.Spn_AjHorzs,
    *                 loImp.Spn_AjDenss, loImp.Spn_AjVelos, poDataMgr)
    *
    * par_cNomeImpressora eh o nome CADASTRADO no sistema (SigCdmp.impres,
    * "crImpreV.impresS" no legado) - NAO o nome do Windows.
    *
    * Nome sem registro casando em SigCdmp eh caminho LEGITIMO (regra
    * CLAUDE.md #50 - universo vazio de lookup nao eh erro): devolve .T.
    * e this_n* ficam com o que ja estava.
    *====================================================================
    FUNCTION CarregarAjustesImpressora(par_cNomeImpressora)
        LOCAL loc_lSucesso, loc_nResultado, loc_nValor

        loc_lSucesso = .T.

        IF VARTYPE(par_cNomeImpressora) != "C" OR EMPTY(par_cNomeImpressora)
            RETURN .T.
        ENDIF

        TRY
            IF USED("cursor_4c_AjusteImpIpE")
                USE IN cursor_4c_AjusteImpIpE
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT impetis, ajdens, ajhorzs, ajvelos, ajverts FROM SigCdmp " + ;
                "WHERE impres = " + EscaparSQL(ALLTRIM(par_cNomeImpressora)), ;
                "cursor_4c_AjusteImpIpE")

            IF loc_nResultado >= 1 AND RECCOUNT("cursor_4c_AjusteImpIpE") > 0
                SELECT cursor_4c_AjusteImpIpE
                GO TOP

                *-- impetis = 0 "nao configurado" - NAO troca o tipo (mesma
                *-- regra do BO irmao sigopetsBO.CarregarDoCursor)
                loc_nValor = NVL(impetis, 0)
                IF loc_nValor <> 0
                    THIS.this_nTipoImpressora = loc_nValor
                ENDIF

                THIS.this_nAjusteVertical   = NVL(ajverts, 0)
                THIS.this_nAjusteHorizontal = NVL(ajhorzs, 0)

                loc_nValor = NVL(ajdens, 0)
                THIS.this_nAjusteDensidade  = IIF(loc_nValor < 10, 10, loc_nValor)

                loc_nValor = NVL(ajvelos, 0)
                THIS.this_nAjusteVelocidade = IIF(loc_nValor < 1, 1, loc_nValor)
            ENDIF

            IF USED("cursor_4c_AjusteImpIpE")
                USE IN cursor_4c_AjusteImpIpE
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

