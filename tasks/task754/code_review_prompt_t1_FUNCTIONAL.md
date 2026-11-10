# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (9)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=4 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarOcorrenciaEtiqueta' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarOcorrenciaEtiquetaValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarOcorrenciaEtiqueta' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarOcorrenciaEtiquetaValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpIpE.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (5593 linhas total):

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

*-- Linhas 403 a 644:
403:     *
404:     * As duas atribuicoes de Caption nos labels da faixa
405:     * (ThisForm.cntSombra.lblSombra/lblTitulo.Caption) ficam dentro de
406:     * InicializarForm, que eh onde a faixa passa a existir.
407:     *
408:     * O BO eh criado ANTES do DODEFAULT() porque FormBase.Init chama
409:     * InicializarForm, que ja precisa dele para montar a tela.
410:     *
411:     * RETURN fica FORA do TRY/CATCH (regra CLAUDE.md #1): o resultado passa
412:     * pela flag loc_lSucesso.
413:     *==========================================================================
414:     PROCEDURE Init(par_oFormAnterior, par_lGravaPro)
415:         LOCAL loc_lSucesso, loc_oErro
416: 
417:         loc_lSucesso = .F.
418: 
419:         TRY
420:             *-- Legado: Thisform.ParentForm = lfFormAnterior / desabilita
421:             IF VARTYPE(par_oFormAnterior) = "O"
422:                 THIS.this_oFormAnterior = par_oFormAnterior
423: 
424:                 IF PEMSTATUS(THIS.this_oFormAnterior, "Enabled", 5)
425:                     THIS.this_oFormAnterior.Enabled = .F.
426:                 ENDIF
427:             ENDIF
428: 
429:             *-- Legado: Thisform.GravaPro = llGravaPro
430:             THIS.this_lGravaPro = ConverterParaLogico(par_lGravaPro)
431: 
432:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpIpEBO")
433: 
434:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
435:                 THIS.this_cMensagemErro = "Falha ao criar SigOpIpEBO."
436:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + ;
437:                     "cio SigOpIpEBO." + CHR(13) + "VARTYPE retornou: " + ;
438:                     VARTYPE(THIS.this_oBusinessObject), ;
439:                     "Erro em FormSigOpIpE.Init")
440:             ELSE
441:                 *-- FormBase.Init chama InicializarForm
442:                 loc_lSucesso = DODEFAULT()
443:             ENDIF
444:         CATCH TO loc_oErro
445:             loc_lSucesso = .F.
446:             THIS.this_cMensagemErro = loc_oErro.Message
447:             MsgErro(loc_oErro.Message + CHR(13) + ;
448:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
449:                 "Procedure: " + loc_oErro.Procedure, ;
450:                 "Erro em FormSigOpIpE.Init")
451:         ENDTRY
452: 
453:         RETURN loc_lSucesso
454:     ENDPROC
455: 
456:     *==========================================================================
457:     * InicializarForm - monta a superficie visual da tela
458:     *
459:     * Picture: o dump traz "..\framework\imagens\new_background.jpg" - o
460:     * arquivo vive em vbmp\ no sistema novo, alcancado por
461:     * gc_4c_CaminhoIcones (nunca remontado a partir de gc_4c_CaminhoBase,
462:     * regra CLAUDE.md #25/#26).
463:     *
464:     * Os dois labels recebem o Caption aqui, nao na criacao, porque eh o
465:     * que o legado faz logo no inicio do Init
466:     * (ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption).
467:     *
468:     * TornarControlesVisiveis fecha a montagem porque AddObject cria todo
469:     * controle com Visible = .F.
470:     *
471:     * RETURN fica FORA do TRY/CATCH (regra CLAUDE.md #1).
472:     *==========================================================================
473:     PROTECTED PROCEDURE InicializarForm()
474:         LOCAL loc_lSucesso, loc_oErro
475: 
476:         loc_lSucesso = .F.
477: 
478:         TRY
479:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
480: 
481:             THIS.ConfigurarPageFrame()
482: 
483:             *-- Legado: lblSombra.Caption / lblTitulo.Caption = ThisForm.Caption
484:             THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
485:             THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
486: 
487:             *-- AddObject cria tudo com Visible = .F.
488:             THIS.TornarControlesVisiveis(THIS)
489: 
490:             *-- Fase 7: liga os BINDEVENT de botoes/grade/combos/lookups.
491:             *-- Depois de TornarControlesVisiveis porque alguns handlers
492:             *-- (ex. OptTipoInteractiveChange) ja leem .Visible de outros
493:             *-- controles.
494:             THIS.ConfigurarEventosPrincipais()
495: 
496:             *-- Fase 8: restante do Init legado (parametros, tipos de
497:             *-- etiqueta, carga das linhas por Tipo, impressoras). TRY/
498:             *-- CATCH proprio que nunca propaga - falha aqui NAO bloqueia
499:             *-- a abertura da tela (ver comentario do metodo).
500:             THIS.CarregarContextoInicial()
501: 
502:             loc_lSucesso = .T.
503:         CATCH TO loc_oErro
504:             loc_lSucesso = .F.
505:             THIS.this_cMensagemErro = loc_oErro.Message
506:             MsgErro(loc_oErro.Message + CHR(13) + ;
507:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
508:                 "Procedure: " + loc_oErro.Procedure, ;
509:                 "Erro em InicializarForm")
510:         ENDTRY
511: 
512:         RETURN loc_lSucesso
513:     ENDPROC
514: 
515:     *==========================================================================
516:     * ConfigurarPageFrame - orquestra a montagem visual da tela
517:     *
518:     * Nao ha superficie de paginas neste form: o dump declara a raiz
519:     * SIGOPIPE como "Class: form / BaseClass: form" - form GENERICO, sem
520:     * nenhum objeto "BaseClass: pageframe" no inventario de 73 objetos. O
521:     * nome deste metodo eh mantido por conformidade com o contrato do
522:     * pipeline e ele apenas DELEGA aos configuradores especificos, mesmo
523:     * desenho dos irmaos FormSigOpEtq/FormSigOpIpB/FormSigOpAtu.
524:     *
525:     * A ORDEM DAS CHAMADAS EH REGRA, NAO ESTILO (regra CLAUDE.md #11/#30)
526:     * --------------------------------------------------------------------
527:     * O cabecalho vem PRIMEIRO porque os dois CommandGroup ficam DENTRO da
528:     * banda dele e precisam desenhar POR CIMA - no dump os grupos estao em
529:     * Top = -2 com Height = 85 (banda -2..83) e o cntSombra em Top = 0 com
530:     * Height = 80 (banda 0..80), isto eh, se sobrepoem em 0..80 nos dois
531:     * eixos (cntBotoes Left 691..1004 e cmdTestaPos Left 615..700, ambos
532:     * dentro dos 0..1000 do container). Invertida a ordem, a faixa cinza
533:     * COBRE os cinco botoes - sem erro, sem log e sem aparecer em screenshot.
534:     *
535:     * A grade vem ANTES dos botoes so por clareza de leitura: ela esta em
536:     * Top 147..388, nao encosta em ninguem.
537:     *
538:     * MontaGradeEtiquetas vem por ULTIMO porque precisa das Column ja
539:     * criadas E do cursor, e porque atribuir RecordSource reseta propriedades
540:     * de coluna (regra CLAUDE.md #41).
541:     *
542:     * A Fase 5 insere os option groups de Tipo/Preco/Peso/Conjunto e o texto
543:     * livre; a Fase 6 completa com o Cnt_Impressora e a Ocorrencia/
544:     * Justificativa. As chamadas vao DEPOIS de ConfigurarBotoes e ANTES de
545:     * MontaGradeEtiquetas - nenhum desses controles ocupa a banda do
546:     * cabecalho (o mais alto eh GetTexto em Top 83) nem a area da grade
547:     * (Top 147..388).
548:     *==========================================================================
549:     PROTECTED PROCEDURE ConfigurarPageFrame()
550:         THIS.ConfigurarCabecalho()
551:         THIS.ConfigurarGrade()
552:         THIS.ConfigurarBotoes()
553:         THIS.ConfigurarTextoLivreEParcelas()
554:         THIS.ConfigurarGruposTipoPrecoPeso()
555:         THIS.ConfigurarImpressora()
556:         THIS.ConfigurarOcorrenciaEJustificativa()
557:         THIS.MontaGradeEtiquetas()
558:         THIS.AjustarBotoesPorTipoChamador()
559:         THIS.AjustarOrdemTabulacao()
560:     ENDPROC
561: 
562:     *==========================================================================
563:     * ConfigurarCabecalho - a faixa cinza do titulo (cntSombra do legado)
564:     *
565:     * Geometria TRANSCRITA do dump (SIGOPIPE.cntSombra / lblSombra /
566:     * lblTitulo): Top 0 / Left 0 / Height 80 / BackColor 100,100,100 /
567:     * BorderWidth 0, e os dois labels sobrepostos em Top 18 e 17, Left 10,
568:     * Tahoma 18 bold, WordWrap, Alignment 0 - sombra PRETA embaixo e
569:     * titulo BRANCO em cima.
570:     *
571:     * UNICO desvio, deliberado: as larguras. O dump declara
572:     * cntSombra.Width = 1004 e os dois labels com Width = 769, mas o form
573:     * tem Width = 1000 - divergencia de poucos pixels, artefato do Form
574:     * Designer. Por isso o container usa THIS.Width e os labels
575:     * THIS.Width - 20, preservando a margem de 10px do Left do dump nos
576:     * dois lados (regra CLAUDE.md #11).
577:     *
578:     * AutoSize = .F. EXPLICITO nos dois labels: com WordWrap = .T. (que o
579:     * dump declara) um AutoSize = .T. DESCARTA a Height e colapsa o texto
580:     * para uma linha so (regra CLAUDE.md #23).
581:     *
582:     * ForeColor BRANCO em lbl_4c_LblTitulo eh uma das excecoes legitimas da
583:     * regra CLAUDE.md #12: o container eh OPACO e escuro (BackStyle = 1 +
584:     * BackColor RGB(100,100,100)), nao a textura clara das paginas de
585:     * cadastro.
586:     *
587:     * Os nomes migrados vem de tasks\task754\mapeamento.json (cntSombra ->
588:     * cnt_4c_Sombra, lblSombra -> lbl_4c_LblSombra, lblTitulo ->
589:     * lbl_4c_LblTitulo) - eh esse arquivo que a validacao de fidelidade de
590:     * UI consulta, entao divergir dele reprovaria a tela sem haver defeito
591:     * visual.
592:     *==========================================================================
593:     PROTECTED PROCEDURE ConfigurarCabecalho()
594:         THIS.AddObject("cnt_4c_Sombra", "Container")
595:         WITH THIS.cnt_4c_Sombra
596:             .Top           = 0
597:             .Left          = 0
598:             .Width         = THIS.Width
599:             .Height        = 80
600:             .BackStyle     = 1
601:             .BackColor     = RGB(100, 100, 100)
602:             .BorderWidth   = 0
603:             .SpecialEffect = 0
604:             .Visible       = .T.
605:         ENDWITH
606: 
607:         *-- lblSombra: sombra preta, desenhada 1px abaixo do titulo
608:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
609:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
610:             .Top           = 18
611:             .Left          = 10
612:             .Width         = THIS.Width - 20
613:             .Height        = 40
614:             .AutoSize      = .F.
615:             .BackStyle     = 0
616:             .WordWrap      = .T.
617:             .Alignment     = 0
618:             .FontName      = "Tahoma"
619:             .FontSize      = 18
620:             .FontBold      = .T.
621:             .FontUnderline = .F.
622:             .ForeColor     = RGB(0, 0, 0)
623:             .Caption       = THIS.Caption
624:             .Visible       = .T.
625:         ENDWITH
626: 
627:         *-- lblTitulo: texto branco por cima da sombra
628:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
629:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
630:             .Top         = 17
631:             .Left        = 10
632:             .Width       = THIS.Width - 20
633:             .Height      = 46
634:             .AutoSize    = .F.
635:             .BackStyle   = 0
636:             .WordWrap    = .T.
637:             .Alignment   = 0
638:             .FontName    = "Tahoma"
639:             .FontSize    = 18
640:             .FontBold    = .T.
641:             .ForeColor   = RGB(255, 255, 255)
642:             .Caption     = THIS.Caption
643:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
644:             .Visible     = .T.

*-- Linhas 715 a 758:
715:     * CLAUDE.md #41), e o bind reseta largura/cabecalho. Tudo isso mora em
716:     * MontaGradeEtiquetas.
717:     *==========================================================================
718:     PROTECTED PROCEDURE ConfigurarGrade()
719:         LOCAL loc_oGrid
720: 
721:         THIS.AddObject("grd_4c_Dados", "Grid")
722:         loc_oGrid = THIS.grd_4c_Dados
723: 
724:         *-- Legado: Thisform.grd_Historico.RecordSource = '' antes do cursor
725:         loc_oGrid.RecordSource = ""
726:         loc_oGrid.ColumnCount  = 12
727: 
728:         WITH loc_oGrid
729:             .Top                = 147
730:             .Left               = 6
731:             .Width              = 984
732:             .Height             = 241
733:             .FontName           = "Arial"
734:             .FontSize           = 8
735:             .HeaderHeight       = 17
736:             .RowHeight          = 17
737:             .ScrollBars         = 3
738:             .Panel              = 1
739:             .DeleteMark         = .F.
740:             .RecordMark         = .F.
741:             .AllowHeaderSizing  = .F.
742:             .AllowRowSizing     = .F.
743:             .GridLineColor      = RGB(238, 238, 238)
744:             .HighlightBackColor = RGB(90, 90, 90)
745:             .Enabled            = .T.
746:             .Visible            = .T.
747:         ENDWITH
748: 
749:         *-- Base uniforme dos 12 blocos do dump
750:         WITH loc_oGrid
751:             .FontName = "Arial"
752:             .FontSize = 8
753:             .SetAll("Movable",   .F.,     "Column")
754:             .SetAll("Resizable", .F.,     "Column")
755: 
756:             .SetAll("FontName",  "Arial", "Header")
757:             .SetAll("FontSize",  8,       "Header")
758:             .SetAll("Alignment", 2,       "Header")

*-- Linhas 790 a 833:
790: 
791:         *-- Posicao 4 (.Name "Column4") - "Codigo / Barra". Trocado de Text1
792:         *-- (nativo da Column) para a subclasse TextBoxCodBarrasIpE_4c
793:         *-- (DEFINE CLASS fora de FormSigOpIpE, fim deste arquivo): BINDEVENT
794:         *-- em "Valid" de TextBox de Column NAO eh confiavel (regra CLAUDE.md
795:         *-- #46) - GotFocus/Valid tem de ser METODO DE CLASSE, delegando para
796:         *-- THISFORM, igual ao padrao TextBoxProdutoLpr_4c do FormLpr.
797:         *-- A mascara esta no controle, e o dump ZERA Column4.Format (override
798:         *-- vazio do Form Designer - regra CLAUDE.md #49: nao se transcreve).
799:         loc_oGrid.Column4.AddObject("txt_4c_CodBarras", "TextBoxCodBarrasIpE_4c")
800:         WITH loc_oGrid.Column4.txt_4c_CodBarras
801:             .FontName    = "Arial"
802:             .FontSize    = 8
803:             .BorderStyle = 0
804:             .Margin      = 0
805:             .InputMask   = "99999999999999"
806:             .ForeColor   = RGB(0, 0, 0)
807:             .BackColor   = RGB(255, 255, 255)
808:             .Visible     = .T.
809:         ENDWITH
810:         loc_oGrid.Column4.CurrentControl = "txt_4c_CodBarras"
811:         loc_oGrid.Column4.Sparse         = .F.
812: 
813:         *-- Mascaras declaradas no nivel da COLUNA (ela propaga para o
814:         *-- CurrentControl). Posicao 5 declara o par tambem no Text1, com o
815:         *-- MESMO valor - redundancia do SCX, nao divergencia.
816:         loc_oGrid.Column5.Format     = "999,999.99"
817:         loc_oGrid.Column5.InputMask  = "999,999.99"
818: 
819:         loc_oGrid.Column6.Format     = "9,999.99"
820:         loc_oGrid.Column6.InputMask  = "9,999.99"
821: 
822:         *-- Posicao 9 (.Name "Column6") declara InputMask SEM Format
823:         loc_oGrid.Column9.InputMask  = "999,999.99"
824: 
825:         loc_oGrid.Column11.Format    = "999,999.99"
826:         loc_oGrid.Column12.Format    = "999,999.99"
827: 
828:         *-- Posicao 10 (.Name "Column10") - "Parcelas". Mesma troca de
829:         *-- Text1 por subclasse, pelo mesmo motivo (Column10.Text1.Valid/
830:         *-- When do dump).
831:         loc_oGrid.Column10.AddObject("txt_4c_Parcelas", "TextBoxParcelasIpE_4c")
832:         WITH loc_oGrid.Column10.txt_4c_Parcelas
833:             .FontName    = "Arial"

*-- Linhas 904 a 947:
904:     *
905:     * RETURN fica FORA do TRY/CATCH (regra CLAUDE.md #1).
906:     *==========================================================================
907:     PROTECTED PROCEDURE CriarCursorEtiquetas()
908:         LOCAL loc_lSucesso, loc_oErro, loc_cCursor, loc_cNullAnterior
909: 
910:         loc_lSucesso = .F.
911:         loc_cCursor  = THIS.this_cCursorEtiquetas
912: 
913:         *-- Lido ANTES do TRY de proposito: o CATCH precisa dele para repor o
914:         *-- SET. Lido dentro, uma falha no CREATE CURSOR deixaria SET NULL ON
915:         *-- vazando do form para o resto da aplicacao, e o proximo
916:         *-- CREATE CURSOR de QUALQUER tela nasceria com colunas nulaveis que
917:         *-- ela nao pediu - defeito sem erro e longe da causa.
918:         loc_cNullAnterior = SET("NULL")
919: 
920:         TRY
921:             IF USED(loc_cCursor)
922:                 IF CURSORGETPROP("Buffering", loc_cCursor) > 1
923:                     TABLEREVERT(.T., loc_cCursor)
924:                 ENDIF
925:                 USE IN (loc_cCursor)
926:             ENDIF
927: 
928:             SET NULL ON
929: 
930:             CREATE CURSOR (loc_cCursor) ( ;
931:                 cbars      N(14, 0) NOT NULL, ;
932:                 contas     C(10)    NOT NULL, ;
933:                 cpros      C(14)    NOT NULL, ;
934:                 datas      T        NULL,     ;
935:                 dopeos     C(20)    NOT NULL, ;
936:                 dopes      C(20)    NOT NULL, ;
937:                 empos      C(3)     NOT NULL, ;
938:                 emps       C(3)     NOT NULL, ;
939:                 grupos     C(10)    NOT NULL, ;
940:                 nops       N(10, 0) NOT NULL, ;
941:                 numeos     N(6, 0)  NOT NULL, ;
942:                 numes      N(6, 0)  NOT NULL, ;
943:                 pesos      N(9, 3)  NOT NULL, ;
944:                 qtds       N(9, 3)  NOT NULL, ;
945:                 transps    L        NOT NULL, ;
946:                 usados     L        NOT NULL, ;
947:                 usuars     C(10)    NOT NULL, ;

*-- Linhas 1014 a 1145:
1014:             THIS.this_cMensagemErro = loc_oErro.Message
1015:             MsgErro(loc_oErro.Message + CHR(13) + ;
1016:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1017:                 "Procedure: " + loc_oErro.Procedure, ;
1018:                 "Erro em CriarCursorEtiquetas")
1019:         ENDTRY
1020: 
1021:         RETURN loc_lSucesso
1022:     ENDPROC
1023: 
1024:     *==========================================================================
1025:     * MontaGradeEtiquetas - liga a grade ao cursor e repoe o que o bind
1026:     * destroi
1027:     *
1028:     * Reproduz o "With Thisform.grd_Historico" do Init legado (2654-2672) e o
1029:     * "Select DbEtiqueta / Goto Top / Refresh" da linha 3268.
1030:     *
1031:     * Os ControlSource vem do NOME da Column no legado, traduzido para a
1032:     * POSICAO deste arquivo (ver a tabela em ConfigurarGrade):
1033:     *
1034:     *   legado .Column1  -> Column1   Datas        legado .Column7  -> Column6   Qtds
1035:     *   legado .Column2  -> Column2   Flag         legado .Column8  -> Column7   ObsEtiqs
1036:     *   legado .Column3  -> Column3   CPros        legado .Column9  -> Column8   Reffs
1037:     *   legado .Column4  -> Column4   CBars        legado .Column6  -> Column9   pVens
1038:     *   legado .Column5  -> Column5   PrecoDe      legado .Column10 -> Column10  Parcelas
1039:     *                                              legado .Column11 -> Column11  PrecoDeCJ
1040:     *                                              legado .Column12 -> Column12  pVensCJ
1041:     *
1042:     * O cursor eh criado antes de qualquer ControlSource: ligar coluna a
1043:     * cursor inexistente estoura "Alias ... is not found" DENTRO do TRY do
1044:     * InicializarForm, que devolve .F., e ai CREATEOBJECT devolve .F., o
1045:     * "IF VARTYPE(loForm) = 'O'" do chamador nao entra e o usuario aciona a
1046:     * tela e NADA acontece, sem erro visivel (regra CLAUDE.md #41).
1047:     *
1048:     * GO TOP + Refresh no fim porque popular/religar cursor NAO repinta a
1049:     * grade sozinho - o legado fecha exatamente assim, e sem isso a grade
1050:     * fica visualmente vazia com o cursor correto, o que manda o diagnostico
1051:     * para SQL/permissao (regra CLAUDE.md #21).
1052:     *
1053:     * PUBLIC de proposito: eh o funil de (re)carga da grade, chamado pelos
1054:     * ramos por Tipo da Fase 7 e alvo potencial de BINDEVENT - PROTECTED
1055:     * falharia calado no bind e estouraria "Property ... is not found" na
1056:     * chamada de fora (regras CLAUDE.md #3/#51).
1057:     *
1058:     * RETURN fica FORA do TRY/CATCH (regra CLAUDE.md #1).
1059:     *==========================================================================
1060:     PROCEDURE MontaGradeEtiquetas()
1061:         LOCAL loc_lSucesso, loc_oErro, loc_cCursor, loc_oGrid
1062: 
1063:         loc_lSucesso = .F.
1064:         loc_cCursor  = THIS.this_cCursorEtiquetas
1065: 
1066:         TRY
1067:             IF !USED(loc_cCursor)
1068:                 THIS.CriarCursorEtiquetas()
1069:             ENDIF
1070: 
1071:             IF USED(loc_cCursor)
1072:                 loc_oGrid = THIS.grd_4c_Dados
1073: 
1074:                 *-- Legado: RecordSource = '' e so depois o alias
1075:                 loc_oGrid.RecordSource = ""
1076:                 loc_oGrid.RecordSource = loc_cCursor
1077: 
1078:                 loc_oGrid.Column1.ControlSource  = loc_cCursor + ".Datas"
1079:                 loc_oGrid.Column2.ControlSource  = loc_cCursor + ".Flag"
1080:                 loc_oGrid.Column3.ControlSource  = loc_cCursor + ".CPros"
1081:                 loc_oGrid.Column4.ControlSource  = loc_cCursor + ".CBars"
1082:                 loc_oGrid.Column5.ControlSource  = loc_cCursor + ".PrecoDe"
1083:                 loc_oGrid.Column6.ControlSource  = loc_cCursor + ".Qtds"
1084:                 loc_oGrid.Column7.ControlSource  = loc_cCursor + ".ObsEtiqs"
1085:                 loc_oGrid.Column8.ControlSource  = loc_cCursor + ".Reffs"
1086:                 loc_oGrid.Column9.ControlSource  = loc_cCursor + ".pVens"
1087:                 loc_oGrid.Column10.ControlSource = loc_cCursor + ".Parcelas"
1088:                 loc_oGrid.Column11.ControlSource = loc_cCursor + ".PrecoDeCJ"
1089:                 loc_oGrid.Column12.ControlSource = loc_cCursor + ".pVensCJ"
1090: 
1091:                 THIS.FormatarColunasGrade()
1092: 
1093:                 *-- Legado: Select DbEtiqueta / Goto Top / Refresh
1094:                 SELECT (loc_cCursor)
1095:                 GO TOP
1096:                 loc_oGrid.Refresh()
1097: 
1098:                 loc_lSucesso = .T.
1099:             ENDIF
1100:         CATCH TO loc_oErro
1101:             loc_lSucesso = .F.
1102:             THIS.this_cMensagemErro = loc_oErro.Message
1103:             MsgErro(loc_oErro.Message + CHR(13) + ;
1104:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1105:                 "Procedure: " + loc_oErro.Procedure, ;
1106:                 "Erro em MontaGradeEtiquetas")
1107:         ENDTRY
1108: 
1109:         RETURN loc_lSucesso
1110:     ENDPROC
1111: 
1112:     *==========================================================================
1113:     * FormatarColunasGrade - tudo o que a atribuicao de RecordSource/
1114:     * ControlSource RESETA, reaplicado por inteiro
1115:     *
1116:     * Atribuir RecordSource devolve Column.Width ao default 90 e
1117:     * Header1.Caption a "ColumnN", e zera Column.CurrentControl /
1118:     * Column.Sparse / Column.ReadOnly (regras CLAUDE.md #41/#46). Por isso
1119:     * este bloco vive num metodo proprio e roda DEPOIS de cada bind - todo
1120:     * caminho que mexer em RecordSource tem de chamar este metodo no fim.
1121:     *
1122:     * Larguras e cabecalhos TRANSCRITOS do dump, cada um pela chave certa (a
1123:     * largura pela POSICAO, o cabecalho pelo NOME - ver ConfigurarGrade).
1124:     *
1125:     * CurrentControl eh o que faz o CheckBox APARECER: sem ele a Column2
1126:     * continua desenhando o Text1 dela e o usuario ve ".T."/".F." como texto,
1127:     * sem nada para clicar. E Sparse = .F. (que o dump declara) eh o que o
1128:     * faz aparecer em TODAS as linhas, nao so na linha ativa - numa tela cuja
1129:     * funcao eh escolher quais etiquetas imprimir, isso eh a diferenca entre
1130:     * marcar o que se quer e marcar uma linha (regra CLAUDE.md #18).
1131:     *
1132:     * A ordem do bloco de ReadOnly eh regra, nao estilo: Grid.ReadOnly
1133:     * PRIMEIRO, porque ele PROPAGA para as colunas e sobrescreveria o que
1134:     * viesse antes (regra CLAUDE.md #46). As quatro colunas editaveis do
1135:     * dump sao a de marcacao (posicao 2), Quantidade (6), Parcelas (10) e -
1136:     * so em alguns Tipo de chamador - "Codigo / Barra" (4); esta ultima nasce
1137:     * ReadOnly como o SCX declara, e quem a libera sao os ramos por Tipo da
1138:     * Fase 7.
1139:     *
1140:     * ColumnOrder por ULTIMO e em ordem CRESCENTE de destino: atribuir
1141:     * ColumnOrder INSERE a coluna naquela posicao e empurra as demais, entao
1142:     * so construindo da esquerda para a direita cada coluna ja colocada fica
1143:     * onde foi posta. A ordem de EXIBICAO do legado nao eh a de criacao - eh
1144:     * esta permutacao completa de 1..12, lida do bloco da grade no dump:
1145:     *

*-- Linhas 1163 a 1206:
1163:     * Column foi recriada por uma reatribuicao de ColumnCount - ai o
1164:     * CheckBox nao existe mais e o nome apontaria para objeto morto.
1165:     *==========================================================================
1166:     PROTECTED PROCEDURE FormatarColunasGrade()
1167:         LOCAL loc_oGrid
1168: 
1169:         loc_oGrid = THIS.grd_4c_Dados
1170: 
1171:         *-- Larguras (POSICAO no dump) e cabecalhos (NOME no dump)
1172:         loc_oGrid.Column1.Width             = 68
1173:         loc_oGrid.Column1.Header1.Caption   = "Data"
1174: 
1175:         loc_oGrid.Column2.Width             = 20
1176:         loc_oGrid.Column2.Header1.Caption   = ""
1177: 
1178:         loc_oGrid.Column3.Width             = 100
1179:         loc_oGrid.Column3.Header1.Caption   = "Produto"
1180: 
1181:         loc_oGrid.Column4.Width             = 100
1182:         loc_oGrid.Column4.Header1.Caption   = "C" + CHR(243) + "digo / Barra"
1183: 
1184:         loc_oGrid.Column5.Width             = 95
1185:         loc_oGrid.Column5.Header1.Caption   = "Pre" + CHR(231) + "o De"
1186: 
1187:         loc_oGrid.Column6.Width             = 80
1188:         loc_oGrid.Column6.Header1.Caption   = "Quantidade"
1189: 
1190:         loc_oGrid.Column7.Width             = 180
1191:         loc_oGrid.Column7.Header1.Caption   = "Observa" + CHR(231) + CHR(227) + "o"
1192: 
1193:         loc_oGrid.Column8.Width             = 83
1194:         loc_oGrid.Column8.Header1.Caption   = "Ref. Fornecedor"
1195: 
1196:         loc_oGrid.Column9.Width             = 95
1197:         loc_oGrid.Column9.Header1.Caption   = "Pre" + CHR(231) + "o"
1198: 
1199:         loc_oGrid.Column10.Width            = 60
1200:         loc_oGrid.Column10.Header1.Caption  = "Parcelas"
1201: 
1202:         loc_oGrid.Column11.Width            = 95
1203:         loc_oGrid.Column11.Header1.Caption  = "Pre" + CHR(231) + "o De Conjunto"
1204: 
1205:         loc_oGrid.Column12.Width            = 95
1206:         loc_oGrid.Column12.Header1.Caption  = "Pre" + CHR(231) + "o Conjunto"

*-- Linhas 1319 a 1369:
1319:     * faixa de 9px em que os grupos se sobrepoem esta vazia nos dois e ambos
1320:     * sao BackStyle = 0, entao nao ha clique bloqueado nem area recortada.
1321:     *
1322:     * Os Buttons NAO recebem BINDEVENT aqui: os cinco Click (Armazenar,
1323:     * Imprimir, Boleto, Sair, Testar Posicao) sao da Fase 7, e ligar agora um
1324:     * handler vazio so para existir seria stub disfarcado. O que esta
1325:     * presente nesta fase eh o unico ajuste de ESTADO que o Init legado faz
1326:     * nesses botoes e que nao depende de nada das fases seguintes - ver
1327:     * AjustarBotoesPorTipoChamador.
1328:     *==========================================================================
1329:     PROTECTED PROCEDURE ConfigurarBotoes()
1330:         LOCAL loc_oGrupo
1331: 
1332:         *-- cntBotoes: Armazenar / Imprimir / Boleto / Sair
1333:         THIS.AddObject("cmg_4c_CntBotoes", "CommandGroup")
1334:         loc_oGrupo = THIS.cmg_4c_CntBotoes
1335: 
1336:         WITH loc_oGrupo
1337:             .ButtonCount   = 4
1338:             .Top           = -2
1339:             .Left          = 691
1340:             .Width         = 313
1341:             .Height        = 85
1342:             .AutoSize      = .T.
1343:             .BackStyle     = 0
1344:             .BorderStyle   = 0
1345:             .BorderColor   = RGB(136, 189, 188)
1346:             .SpecialEffect = 1
1347:             .Themes        = .F.
1348:             .Value         = 0
1349:             .Enabled       = .T.
1350:             .Visible       = .T.
1351:         ENDWITH
1352: 
1353:         *-- Buttons(1) = btnBoleto
1354:         WITH loc_oGrupo.Buttons(1)
1355:             .Top             = 5
1356:             .Left            = 157
1357:             .Width           = 75
1358:             .Height          = 75
1359:             .Caption         = "\<Boleto"
1360:             .Picture         = gc_4c_CaminhoIcones + "geral_boleto_60.jpg"
1361:             .PicturePosition = 13
1362:             .FontName        = "Comic Sans MS"
1363:             .FontSize        = 8
1364:             .FontBold        = .T.
1365:             .FontItalic      = .T.
1366:             .WordWrap        = .T.
1367:             .AutoSize        = .F.
1368:             .MousePointer    = 15
1369:             .SpecialEffect   = 0

*-- Linhas 1453 a 1496:
1453:         *-- cmdTestaPos: o botao de teste de posicionamento da etiqueta.
1454:         *-- Visible = .T. porque nem o dump nem o Init legado o escondem; a
1455:         *-- visibilidade condicional ("= (lnTpEti = 80)") mora no
1456:         *-- InteractiveChange do Opt_Tipo, que eh da Fase 5.
1457:         THIS.AddObject("cmg_4c_CmdTestaPos", "CommandGroup")
1458:         loc_oGrupo = THIS.cmg_4c_CmdTestaPos
1459: 
1460:         WITH loc_oGrupo
1461:             .ButtonCount   = 1
1462:             .Top           = -2
1463:             .Left          = 615
1464:             .Width         = 85
1465:             .Height        = 85
1466:             .AutoSize      = .T.
1467:             .BackStyle     = 0
1468:             .BorderStyle   = 0
1469:             .BackColor     = RGB(240, 240, 240)
1470:             .BorderColor   = RGB(136, 189, 188)
1471:             .SpecialEffect = 1
1472:             .Themes        = .F.
1473:             .Value         = 1
1474:             .Enabled       = .T.
1475:             .Visible       = .T.
1476:         ENDWITH
1477: 
1478:         *-- Buttons(1) = btnPosicao
1479:         WITH loc_oGrupo.Buttons(1)
1480:             .Top           = 5
1481:             .Left          = 5
1482:             .Width         = 75
1483:             .Height        = 75
1484:             .Caption       = "\<Testar Posi" + CHR(231) + CHR(227) + "o"
1485:             .Picture       = gc_4c_CaminhoIcones + "geral_impressora_60.jpg"
1486:             .FontName      = "Comic Sans MS"
1487:             .FontSize      = 8
1488:             .FontBold      = .T.
1489:             .FontItalic    = .T.
1490:             .WordWrap      = .T.
1491:             .AutoSize      = .F.
1492:             .MousePointer  = 15
1493:             .SpecialEffect = 0
1494:             .ForeColor     = RGB(90, 90, 90)
1495:             .BackColor     = RGB(255, 255, 255)
1496:             .Themes        = .F.

*-- Linhas 1528 a 1571:
1528:     * partir da Fase 6) fica para a Fase 6, mesma regra ja registrada no
1529:     * cabecalho do arquivo (AjustarOrdemTabulacao).
1530:     *==========================================================================
1531:     PROTECTED PROCEDURE ConfigurarTextoLivreEParcelas()
1532:         THIS.AddObject("lbl_4c_Label7", "Label")
1533:         WITH THIS.lbl_4c_Label7
1534:             .Top        = 82
1535:             .Left       = 209
1536:             .Width      = 66
1537:             .Height     = 15
1538:             .AutoSize   = .T.
1539:             .BackStyle  = 0
1540:             .FontName   = "Tahoma"
1541:             .FontSize   = 8
1542:             .FontBold   = .T.
1543:             .FontItalic = .F.
1544:             .ForeColor  = RGB(90, 90, 90)
1545:             .Caption    = "Texto Livre"
1546:             .Visible    = .T.
1547:         ENDWITH
1548: 
1549:         THIS.AddObject("obj_4c_GetTexto", "EditBox")
1550:         WITH THIS.obj_4c_GetTexto
1551:             .Top          = 83
1552:             .Left         = 279
1553:             .Width        = 341
1554:             .Height       = 61
1555:             .FontName     = "Tahoma"
1556:             .FontSize     = 10
1557:             .AddLineFeeds = .F.
1558:             .Visible      = .T.
1559:         ENDWITH
1560: 
1561:         THIS.AddObject("lbl_4c_Label8", "Label")
1562:         WITH THIS.lbl_4c_Label8
1563:             .Top        = 129
1564:             .Left       = 12
1565:             .Width      = 123
1566:             .Height     = 15
1567:             .AutoSize   = .T.
1568:             .BackStyle  = 0
1569:             .FontName   = "Tahoma"
1570:             .FontSize   = 8
1571:             .FontBold   = .F.

*-- Linhas 1634 a 1711:
1634:     * veda (ButtonsValue = N para N>1, que faz todos os botoes
1635:     * aparecerem marcados de uma vez).
1636:     *
1637:     * OptionGroup nao tem ForeColor nem ControlCount (confirmado no mesmo
1638:     * arquivo de propriedades) - a cor mora nos ButtonsForeColor, e a
1639:     * recursao de TornarControlesVisiveis para no proprio grupo (o
1640:     * PEMSTATUS de ControlCount devolve .F.), exatamente como em
1641:     * CommandGroup.
1642:     *==========================================================================
1643:     PROTECTED PROCEDURE ConfigurarGruposTipoPrecoPeso()
1644:         THIS.AddObject("shp_4c_Shape2", "Shape")
1645:         WITH THIS.shp_4c_Shape2
1646:             .Top           = 394
1647:             .Left          = 6
1648:             .Width         = 191
1649:             .Height        = 201
1650:             .BackStyle     = 0
1651:             .BorderWidth   = 2
1652:             .BorderColor   = RGB(90, 90, 90)
1653:             .SpecialEffect = 0
1654:             .Visible       = .T.
1655:         ENDWITH
1656: 
1657:         THIS.AddObject("shp_4c_Shape1", "Shape")
1658:         WITH THIS.shp_4c_Shape1
1659:             .Top           = 394
1660:             .Left          = 396
1661:             .Width         = 192
1662:             .Height        = 201
1663:             .BackStyle     = 0
1664:             .BorderWidth   = 2
1665:             .BorderColor   = RGB(90, 90, 90)
1666:             .SpecialEffect = 0
1667:             .Visible       = .T.
1668:         ENDWITH
1669: 
1670:         *-- Opt_Tipo: unico botao do SCX - o resto chega via LocalTpEti (Fase 7)
1671:         THIS.AddObject("obj_4c_Opt_Tipo", "OptionGroup")
1672:         WITH THIS.obj_4c_Opt_Tipo
1673:             .ButtonCount   = 1
1674:             .Top           = 412
1675:             .Left          = 11
1676:             .Width         = 181
1677:             .Height        = 173
1678:             .AutoSize      = .F.
1679:             .BackStyle     = 0
1680:             .BorderStyle   = 0
1681:             .SpecialEffect = 1
1682:             .BorderColor   = RGB(36, 84, 155)
1683:             .Themes        = .F.
1684:             .Value         = 1
1685:             .Visible       = .T.
1686:         ENDWITH
1687: 
1688:         WITH THIS.obj_4c_Opt_Tipo.Buttons(1)
1689:             .Top       = -1
1690:             .Left      = 4
1691:             .Width     = 150
1692:             .Height    = 17
1693:             .Style     = 0
1694:             .FontName  = "Tahoma"
1695:             .FontSize  = 8
1696:             .BackStyle = 0
1697:             .ForeColor = RGB(90, 90, 90)
1698:             .Caption   = "\<a. Rabicho"
1699:             .Value     = 1
1700:             .TabIndex  = 1
1701:         ENDWITH
1702: 
1703:         THIS.AddObject("lbl_4c_Label1", "Label")
1704:         WITH THIS.lbl_4c_Label1
1705:             .Top        = 397
1706:             .Left       = 14
1707:             .Width      = 93
1708:             .Height     = 15
1709:             .AutoSize   = .T.
1710:             .BackStyle  = 0
1711:             .FontName   = "Tahoma"

*-- Linhas 1718 a 1761:
1718:         ENDWITH
1719: 
1720:         *-- Opt_Conjunto - Value=2 -> botao 2 ("Nao") selecionado por padrao
1721:         THIS.AddObject("obj_4c_Opt_Conjunto", "OptionGroup")
1722:         WITH THIS.obj_4c_Opt_Conjunto
1723:             .ButtonCount = 2
1724:             .Top         = 393
1725:             .Left        = 466
1726:             .Width       = 106
1727:             .Height      = 26
1728:             .AutoSize    = .F.
1729:             .BackStyle   = 0
1730:             .BorderStyle = 0
1731:             .Value       = 2
1732:             .Visible     = .T.
1733:         ENDWITH
1734: 
1735:         WITH THIS.obj_4c_Opt_Conjunto.Buttons(1)
1736:             .Top       = 7
1737:             .Left      = 8
1738:             .Width     = 34
1739:             .Height    = 15
1740:             .Style     = 0
1741:             .AutoSize  = .T.
1742:             .FontName  = "Tahoma"
1743:             .FontSize  = 8
1744:             .BackStyle = 0
1745:             .ForeColor = RGB(90, 90, 90)
1746:             .Caption   = "Sim"
1747:             .Value     = 0
1748:         ENDWITH
1749: 
1750:         WITH THIS.obj_4c_Opt_Conjunto.Buttons(2)
1751:             .Top       = 7
1752:             .Left      = 61
1753:             .Width     = 37
1754:             .Height    = 15
1755:             .Style     = 0
1756:             .AutoSize  = .T.
1757:             .FontName  = "Tahoma"
1758:             .FontSize  = 8
1759:             .BackStyle = 0
1760:             .ForeColor = RGB(90, 90, 90)
1761:             .Caption   = "N" + CHR(227) + "o"

*-- Linhas 1780 a 1823:
1780:         ENDWITH
1781: 
1782:         *-- opt_Preco: 6 botoes (Sim/Nao/Ideal/Atual/Preco DE\Por/Parcelamento)
1783:         THIS.AddObject("obj_4c_Opt_Preco", "OptionGroup")
1784:         WITH THIS.obj_4c_Opt_Preco
1785:             .ButtonCount = 6
1786:             .Top         = 416
1787:             .Left        = 467
1788:             .Width       = 111
1789:             .Height      = 112
1790:             .AutoSize    = .F.
1791:             .BackStyle   = 0
1792:             .BorderStyle = 0
1793:             .Value       = 1
1794:             .Visible     = .T.
1795:         ENDWITH
1796: 
1797:         WITH THIS.obj_4c_Opt_Preco.Buttons(1)
1798:             .Top       = 7
1799:             .Left      = 8
1800:             .Width     = 34
1801:             .Height    = 15
1802:             .Style     = 0
1803:             .AutoSize  = .T.
1804:             .FontName  = "Tahoma"
1805:             .FontSize  = 8
1806:             .BackStyle = 0
1807:             .ForeColor = RGB(90, 90, 90)
1808:             .Caption   = "Sim"
1809:             .Value     = 1
1810:         ENDWITH
1811: 
1812:         WITH THIS.obj_4c_Opt_Preco.Buttons(2)
1813:             .Top       = 7
1814:             .Left      = 61
1815:             .Width     = 37
1816:             .Height    = 15
1817:             .Style     = 0
1818:             .AutoSize  = .T.
1819:             .FontName  = "Tahoma"
1820:             .FontSize  = 8
1821:             .BackStyle = 0
1822:             .ForeColor = RGB(90, 90, 90)
1823:             .Caption   = "N" + CHR(227) + "o"

*-- Linhas 1897 a 1940:
1897:         ENDWITH
1898: 
1899:         *-- opt_peso: 2 botoes (Sim/Nao)
1900:         THIS.AddObject("obj_4c_Opt_peso", "OptionGroup")
1901:         WITH THIS.obj_4c_Opt_peso
1902:             .ButtonCount = 2
1903:             .Top         = 513
1904:             .Left        = 467
1905:             .Width       = 100
1906:             .Height      = 26
1907:             .AutoSize    = .F.
1908:             .BackStyle   = 0
1909:             .BorderStyle = 0
1910:             .Value       = 1
1911:             .Visible     = .T.
1912:         ENDWITH
1913: 
1914:         WITH THIS.obj_4c_Opt_peso.Buttons(1)
1915:             .Top        = 7
1916:             .Left       = 8
1917:             .Width      = 34
1918:             .Height     = 15
1919:             .Style      = 0
1920:             .AutoSize   = .T.
1921:             .FontName   = "Tahoma"
1922:             .FontSize   = 8
1923:             .FontItalic = .F.
1924:             .BackStyle  = 0
1925:             .ForeColor  = RGB(90, 90, 90)
1926:             .Caption    = "Sim"
1927:             .Value      = 1
1928:         ENDWITH
1929: 
1930:         WITH THIS.obj_4c_Opt_peso.Buttons(2)
1931:             .Top        = 7
1932:             .Left       = 61
1933:             .Width      = 37
1934:             .Height     = 15
1935:             .Style      = 0
1936:             .AutoSize   = .T.
1937:             .FontName   = "Tahoma"
1938:             .FontSize   = 8
1939:             .FontItalic = .F.
1940:             .BackStyle  = 0

*-- Linhas 1970 a 2076:
1970:     *
1971:     * Cnt_Impressora (Top 521 / Left 593 / Width 398 / Height 73) eh o
1972:     * container com a configuracao fisica da impressora: Opcao_imp
1973:     * (OptionGroup de 3 botoes - Allegro/Zebra ZPL/Zebra EPL), os 4
1974:     * Spinner de ajuste (Vert/Horz/Dens/Velo) com seus Say ao lado, e
1975:     * Chk_Resete (oculto - excecao de TornarControlesVisiveis). TabIndex
1976:     * dos filhos TRANSCRITO literal do dump: eh escopo PROPRIO do
1977:     * container (regra CLAUDE.md #29/sub-regra de Buttons - mesmo
1978:     * raciocinio vale para TabIndex de filho de Container), e a sequencia
1979:     * 2..11 do dump nao tem duplicata nenhuma - diferente do que acontece
1980:     * nos controles diretos do FORM (ver AjustarOrdemTabulacao).
1981:     *
1982:     * SpinnerHighValue/SpinnerLowValue TRANSCRITOS sem a parte decimal
1983:     * ".00" do dump (sao os mesmos 999/0/20/10/3/1 - o VFP exibe Spinner
1984:     * como float, o literal eh so formatacao do Form Designer).
1985:     *
1986:     * Opt_Impressora (Visible = .F. SEMPRE, nunca reativado - ver nota no
1987:     * cabecalho do arquivo) e Label2 ("Impressoras") sao TRANSCRITOS tal
1988:     * qual o dump.
1989:     *
1990:     * Get_Printer (ComboBox, Style = 2) nasce com RowSourceType = 0 e
1991:     * RowSource = "" - o bind ao alias crImpreV eh feito em
1992:     * CarregarImpressorasEtiqueta (Fase 8), quando o cursor passa a
1993:     * existir. As
1994:     * demais propriedades (BoundColumn, DisabledBackColor/ForeColor,
1995:     * BorderColor, Style) sao TRANSCRITAS do dump e nao dependem do alias.
1996:     *
1997:     * Label5 ("Sistema") e Label6 ("Windows") sao os dois rotulos acima do
1998:     * combo - Label6 recebe RGB(90,90,90) em vez do RGB(231,254,253)
1999:     * quase-branco do dump (regra CLAUDE.md #12, excecao "escurecer p/ cor
2000:     * das labels irmas" - a irma eh Label5).
2001:     *
2002:     * Say5 ("Posicao :") e spn_posetiq ficam no Shape2 (Opt_Tipo), nao no
2003:     * Shape3: Top 549..554 / Left 412..477, dentro da faixa 394..595 Left
2004:     * 6..197 do Shape2 (Fase 5). O nome migrado de Say5 eh "lbl_4c_Say5"
2005:     * e NAO "lbl_4c_Label5" (que ja pertence a Label5, "Sistema") - ver a
2006:     * nota de colisao de mapeamento.json no cabecalho do arquivo.
2007:     *==========================================================================
2008:     PROTECTED PROCEDURE ConfigurarImpressora()
2009:         THIS.AddObject("shp_4c_Shape3", "Shape")
2010:         WITH THIS.shp_4c_Shape3
2011:             .Top           = 394
2012:             .Left          = 201
2013:             .Width         = 191
2014:             .Height        = 201
2015:             .BackStyle     = 0
2016:             .BorderWidth   = 2
2017:             .BorderColor   = RGB(90, 90, 90)
2018:             .SpecialEffect = 0
2019:             .Visible       = .T.
2020:         ENDWITH
2021: 
2022:         THIS.AddObject("cnt_4c__Impressora", "Container")
2023:         WITH THIS.cnt_4c__Impressora
2024:             .Top           = 521
2025:             .Left          = 593
2026:             .Width         = 398
2027:             .Height        = 73
2028:             .BackStyle     = 0
2029:             .BorderWidth   = 2
2030:             .SpecialEffect = 2
2031:             .BorderColor   = RGB(90, 90, 90)
2032:             .Visible       = .T.
2033:         ENDWITH
2034: 
2035:         *-- Opcao_imp: 3 impressoras (Allegro / Zebra ZPL / Zebra EPL)
2036:         THIS.cnt_4c__Impressora.AddObject("obj_4c_Opcao_imp", "OptionGroup")
2037:         WITH THIS.cnt_4c__Impressora.obj_4c_Opcao_imp
2038:             .ButtonCount = 3
2039:             .Top         = 4
2040:             .Left        = 5
2041:             .Width       = 76
2042:             .Height      = 63
2043:             .AutoSize    = .T.
2044:             .BackStyle   = 0
2045:             .BorderStyle = 0
2046:             .TabIndex    = 2
2047:             .Visible     = .T.
2048:         ENDWITH
2049: 
2050:         WITH THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Buttons(1)
2051:             .Top       = 5
2052:             .Left      = 5
2053:             .Width     = 51
2054:             .Height    = 15
2055:             .Style     = 0
2056:             .AutoSize  = .T.
2057:             .FontName  = "Tahoma"
2058:             .FontSize  = 8
2059:             .BackStyle = 0
2060:             .ForeColor = RGB(90, 90, 90)
2061:             .Caption   = "Allegro"
2062:         ENDWITH
2063: 
2064:         WITH THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Buttons(2)
2065:             .Top       = 24
2066:             .Left      = 5
2067:             .Width     = 66
2068:             .Height    = 15
2069:             .Style     = 0
2070:             .AutoSize  = .T.
2071:             .FontName  = "Tahoma"
2072:             .FontSize  = 8
2073:             .BackStyle = 0
2074:             .ForeColor = RGB(90, 90, 90)
2075:             .Caption   = "Zebra ZPL"
2076:         ENDWITH

*-- Linhas 2212 a 2281:
2212:         ENDWITH
2213: 
2214:         *-- Chk_Resete: oculto (dump Visible = .F.) - excecao de
2215:         *-- TornarControlesVisiveis. O Click de Opcao_imp que o esconde de
2216:         *-- novo (This.Parent.Chk_Resete.Visible = .f., Fase 7 -
2217:         *-- OpcaoImpClick) existe; o que o REABRE eh fCarregarImps, funcao
2218:         *-- global que nao veio no acervo (regra CLAUDE.md #27) - fica
2219:         *-- oculto para sempre, mesma omissao de ValidarImpressoraSelecio-
2220:         *-- nada/CarregarAjustesImpressora.
2221:         THIS.cnt_4c__Impressora.AddObject("chk_4c_Chk_Resete", "CheckBox")
2222:         WITH THIS.cnt_4c__Impressora.chk_4c_Chk_Resete
2223:             .Top       = 49
2224:             .Left      = 104
2225:             .Width     = 135
2226:             .Height    = 15
2227:             .FontName  = "Tahoma"
2228:             .FontSize  = 8
2229:             .AutoSize  = .T.
2230:             .Alignment = 0
2231:             .BackStyle = 0
2232:             .ForeColor = RGB(90, 90, 90)
2233:             .Caption   = 'Enviar Comando "Reset"'
2234:             .Value     = 0
2235:             .TabIndex  = 11
2236:             .Visible   = .F.
2237:         ENDWITH
2238: 
2239:         *-- Opt_Impressora: morto desde "mena - 05/03/2015" (ver nota no
2240:         *-- cabecalho). Visible = .F. SEMPRE.
2241:         THIS.AddObject("obj_4c_Opt_Impressora", "OptionGroup")
2242:         WITH THIS.obj_4c_Opt_Impressora
2243:             .ButtonCount   = 1
2244:             .Top           = 554
2245:             .Left          = 206
2246:             .Width         = 181
2247:             .Height        = 36
2248:             .AutoSize      = .F.
2249:             .BackStyle     = 0
2250:             .BorderStyle   = 0
2251:             .SpecialEffect = 1
2252:             .BorderColor   = RGB(90, 90, 90)
2253:             .Themes        = .F.
2254:             .Value         = 1
2255:             .Visible       = .F.
2256:         ENDWITH
2257: 
2258:         WITH THIS.obj_4c_Opt_Impressora.Buttons(1)
2259:             .Top       = 10
2260:             .Left      = 2
2261:             .Width     = 177
2262:             .Height    = 17
2263:             .Style     = 0
2264:             .FontName  = "Tahoma"
2265:             .FontSize  = 8
2266:             .BackStyle = 0
2267:             .ForeColor = RGB(90, 90, 90)
2268:             .Caption   = "\<1. Gen" + CHR(233) + "rico/Somente Texto"
2269:             .Value     = 1
2270:             .TabIndex  = 1
2271:         ENDWITH
2272: 
2273:         THIS.AddObject("lbl_4c_Label2", "Label")
2274:         WITH THIS.lbl_4c_Label2
2275:             .Top        = 397
2276:             .Left       = 209
2277:             .Width      = 74
2278:             .Height     = 15
2279:             .AutoSize   = .T.
2280:             .BackStyle  = 0
2281:             .FontName   = "Tahoma"

*-- Linhas 2396 a 2439:
2396:     * (BackStyle 0, BorderWidth 2, BorderColor 90,90,90) - unica diferenca
2397:     * eh a geometria, TRANSCRITA do dump.
2398:     *==========================================================================
2399:     PROTECTED PROCEDURE ConfigurarOcorrenciaEJustificativa()
2400:         THIS.this_lGravaOcorrencia = .F.
2401: 
2402:         THIS.AddObject("shp_4c_ShpOcoEtiqs", "Shape")
2403:         WITH THIS.shp_4c_ShpOcoEtiqs
2404:             .Top           = 464
2405:             .Left          = 593
2406:             .Width         = 398
2407:             .Height        = 53
2408:             .BackStyle     = 0
2409:             .BorderWidth   = 2
2410:             .BorderColor   = RGB(90, 90, 90)
2411:             .SpecialEffect = 0
2412:             .Visible       = .F.
2413:         ENDWITH
2414: 
2415:         THIS.AddObject("txt_4c_OcoEtiqs", "TextBox")
2416:         WITH THIS.txt_4c_OcoEtiqs
2417:             .Top               = 486
2418:             .Left              = 605
2419:             .Width             = 33
2420:             .Height            = 24
2421:             .FontName          = "Courier New"
2422:             .FontSize          = 9
2423:             .Format            = "K"
2424:             .Value             = ""
2425:             .DisabledBackColor = RGB(255, 255, 255)
2426:             .DisabledForeColor = RGB(0, 0, 128)
2427:             .Visible           = .F.
2428:         ENDWITH
2429: 
2430:         THIS.AddObject("txt_4c_DOcoEtiqs", "TextBox")
2431:         WITH THIS.txt_4c_DOcoEtiqs
2432:             .Top               = 486
2433:             .Left              = 641
2434:             .Width             = 337
2435:             .Height            = 24
2436:             .FontName          = "Courier New"
2437:             .FontSize          = 9
2438:             .Format            = "K"
2439:             .Value             = ""

*-- Linhas 2545 a 3080:
2545:     * devolve .T. mesmo para PROTECTED - o teste entraria no branch e a
2546:     * chamada estouraria em runtime (regras CLAUDE.md #3/#51).
2547:     *==========================================================================
2548:     PROCEDURE AjustarBotoesPorTipoChamador()
2549:         LOCAL loc_cTipoChamador, loc_oGrupo
2550: 
2551:         loc_cTipoChamador = ""
2552: 
2553:         IF VARTYPE(THIS.this_oFormAnterior) = "O"
2554:             IF PEMSTATUS(THIS.this_oFormAnterior, "Tipo", 5)
2555:                 IF VARTYPE(THIS.this_oFormAnterior.Tipo) = "C"
2556:                     loc_cTipoChamador = UPPER(ALLTRIM(THIS.this_oFormAnterior.Tipo))
2557:                 ENDIF
2558:             ENDIF
2559:         ENDIF
2560: 
2561:         loc_oGrupo = THIS.cmg_4c_CntBotoes
2562: 
2563:         *-- Legado: "Mostra os Quatro Botoes na Tela"
2564:         loc_oGrupo.Buttons(1).Enabled = .T.   && Boleto
2565:         loc_oGrupo.Buttons(2).Enabled = .T.   && Sair
2566:         loc_oGrupo.Buttons(3).Enabled = .T.   && Armazenar
2567:         loc_oGrupo.Buttons(4).Enabled = .T.   && Imprimir
2568: 
2569:         *-- Legado: If (ParentForm.Tipo <> 'CADASTRO') / btnDepois.Enabled = .F.
2570:         IF loc_cTipoChamador != "CADASTRO"
2571:             loc_oGrupo.Buttons(3).Enabled = .F.
2572:         ENDIF
2573:     ENDPROC
2574: 
2575:     *==========================================================================
2576:     * AjustarOrdemTabulacao - TabIndex dos filhos DIRETOS do form
2577:     *
2578:     * Com AddObject o VFP9 numera o TabIndex pela ORDEM DE CRIACAO, que nao
2579:     * tem relacao com a do legado. Divergencia aqui nao da erro, nao entra em
2580:     * log e nao aparece em screenshot - so o Tab andando na ordem errada.
2581:     *
2582:     * O dump esta LONGE de ser uma sequencia limpa 1..N: SO entre os
2583:     * controles filhos DIRETOS do form que de fato recebem foco (TextBox,
2584:     * EditBox, ComboBox, Spinner, OptionGroup, CommandGroup, Grid - Label e
2585:     * Shape NAO tem TabStop, regra ja registrada no gemeo FormSIGOPGRC), o
2586:     * TabIndex = 10 aparece em QUATRO controles (opt_Preco, spn_posetiq,
2587:     * opt_peso, Opt_Conjunto), o 1 em dois (cntBotoes, Get_Printer), o 2 em
2588:     * dois (grd_historico, cmdTestaPos), o 4 em dois (getQtParcs,
2589:     * getOcoEtiqs), o 7 em dois (GetJustifs, GetTexto) e o 9 em dois
2590:     * (Opt_Impressora, Say5) - sintoma de retrabalho do form ao longo dos
2591:     * anos (os comentarios "mena" no dump vao de 2014 a 2016).
2592:     *
2593:     * Como nao ha como recuperar a intencao original dessas duplicatas, a
2594:     * ordem final abaixo resolve o EMPATE pelo Top do dump (controle mais
2595:     * acima primeiro) - mesmo criterio que a ferramenta "Set Tab Order" do
2596:     * Form Designer usa ao preencher automaticamente. Os valores atribuidos
2597:     * sao os ORDINAIS EFETIVOS (1..16), nao os literais do dump, e em ordem
2598:     * ASCENDENTE: cada atribuicao poe o controle na posicao pedida e empurra
2599:     * os demais para tras (mesma mecanica de insercao do Column.ColumnOrder
2600:     * em FormatarColunasGrade) - ordem descendente trocaria pares de lugar.
2601:     *
2602:     *   1  cmg_4c_CntBotoes      (TabIndex 1, Top -2)
2603:     *   2  cbo_4c_Get_Printer    (TabIndex 1, Top 434)
2604:     *   3  cmg_4c_CmdTestaPos    (TabIndex 2, Top -2)
2605:     *   4  grd_4c_Dados          (TabIndex 2, Top 147)
2606:     *   5  txt_4c_QtParcs        (TabIndex 4, Top 120)
2607:     *   6  txt_4c_OcoEtiqs       (TabIndex 4, Top 486)
2608:     *   7  txt_4c_DOcoEtiqs      (TabIndex 5, Top 486)
2609:     *   8  obj_4c_GetTexto       (TabIndex 7, Top 83)
2610:     *   9  obj_4c_GetJustifs     (TabIndex 7, Top 413)
2611:     *   10 obj_4c_Opt_Tipo       (TabIndex 8, Top 412)
2612:     *   11 obj_4c_Opt_Impressora (TabIndex 9, Top 554 - oculto; mantido na
2613:     *                             sequencia so para a numeracao nao pular)
2614:     *   12 obj_4c_Opt_Conjunto   (TabIndex 10, Top 393)
2615:     *   13 obj_4c_Opt_Preco      (TabIndex 10, Top 416)
2616:     *   14 obj_4c_Opt_peso       (TabIndex 10, Top 513)
2617:     *   15 obj_4c_Spn_posetiq    (TabIndex 10, Top 549)
2618:     *   16 cnt_4c__Impressora    (TabIndex 12, Top 521)
2619:     *
2620:     * txt_4c_OcoEtiqs/txt_4c_DOcoEtiqs/obj_4c_GetJustifs ficam na faixa
2621:     * normal de TabIndex mesmo nascendo Visible = .F.: controle oculto
2622:     * continua tendo TabIndex (o Tab so pula ele em runtime, por nao estar
2623:     * Visible), e e exatamente isso que a Fase 7 precisa quando os
2624:     * reexibir - TabIndex fixado agora, sem depender de mais nenhum
2625:     * AddObject.
2626:     *
2627:     * cnt_4c__Impressora.TabIndex eh o ultimo da lista porque o TabIndex de
2628:     * um Container eh escopo PROPRIO (o Tab entra nos filhos dele, numerados
2629:     * em ConfigurarImpressora) - a posicao 16 so decide QUANDO o foco entra
2630:     * no container em relacao aos outros 15, nao a ordem interna.
2631:     *==========================================================================
2632:     PROTECTED PROCEDURE AjustarOrdemTabulacao()
2633:         THIS.cmg_4c_CntBotoes.TabIndex      = 1
2634:         THIS.cbo_4c_Get_Printer.TabIndex    = 2
2635:         THIS.cmg_4c_CmdTestaPos.TabIndex    = 3
2636:         THIS.grd_4c_Dados.TabIndex          = 4
2637:         THIS.txt_4c_QtParcs.TabIndex        = 5
2638:         THIS.txt_4c_OcoEtiqs.TabIndex       = 6
2639:         THIS.txt_4c_DOcoEtiqs.TabIndex      = 7
2640:         THIS.obj_4c_GetTexto.TabIndex       = 8
2641:         THIS.obj_4c_GetJustifs.TabIndex     = 9
2642:         THIS.obj_4c_Opt_Tipo.TabIndex       = 10
2643:         THIS.obj_4c_Opt_Impressora.TabIndex = 11
2644:         THIS.obj_4c_Opt_Conjunto.TabIndex   = 12
2645:         THIS.obj_4c_Opt_Preco.TabIndex      = 13
2646:         THIS.obj_4c_Opt_peso.TabIndex       = 14
2647:         THIS.obj_4c_Spn_posetiq.TabIndex    = 15
2648:         THIS.cnt_4c__Impressora.TabIndex    = 16
2649:     ENDPROC
2650: 
2651:     *==========================================================================
2652:     * TornarControlesVisiveis - repoe Visible = .T. apos os AddObject
2653:     *
2654:     * AddObject cria todo controle com Visible = .F., e a recursao alcanca
2655:     * os filhos do container. Nao ha lista de excecao ate a Fase 5: dos
2656:     * controles criados ate aqui - faixa do cabecalho, grade, os dois
2657:     * CommandGroup e os grupos de Tipo/Preco/Peso/Conjunto + texto livre -
2658:     * nenhum nasce oculto no dump.
2659:     *
2660:     * A lista de excecao EH OBRIGATORIA a partir desta fase: o dump declara
2661:     * Visible = .F. em Opt_Impressora e em Cnt_Impressora.Chk_Resete, e o
2662:     * Init legado esconde mais sete controles (getOcoEtiqs, getDOcoEtiqs,
2663:     * lblOcoEtiqs, shpOcoEtiqs, getJustifs, lblJustifs, shpJustifs) para so
2664:     * reexibi-los sob condicao (ver ConfigurarOcorrenciaEJustificativa). Sem
2665:     * a excecao, o loop generico forcaria Visible = .T. nos nove e exporia
2666:     * blocos que o legado mantem fechados.
2667:     *
2668:     * A excecao eh pelo NOME MIGRADO (nunca pelo nome legado, que nao existe
2669:     * mais em runtime): checa o Name do objeto, nao o caminho completo,
2670:     * porque a recursao chega a eles a partir de containers diferentes
2671:     * (Cnt_Impressora.Chk_Resete via THIS.cnt_4c__Impressora, os outros
2672:     * oito direto em THIS).
2673:     *
2674:     * A recursao para sozinha na grade e nos CommandGroup/OptionGroup:
2675:     * nenhuma dessas base classes tem ControlCount (Grid expoe
2676:     * Columns/Objects, CommandGroup/OptionGroup expoem Buttons/Objects),
2677:     * entao o PEMSTATUS do guard devolve .F. e o metodo nao desce nelas - o
2678:     * que esta correto, porque as propriedades dos Buttons, das Column, dos
2679:     * Header1/Text1 e do CheckBox da coluna de marcacao sao definidas uma a
2680:     * uma em ConfigurarGrade / FormatarColunasGrade / ConfigurarBotoes /
2681:     * ConfigurarGruposTipoPrecoPeso / ConfigurarImpressora.
2682:     *
2683:     * PEMSTATUS eh usado sobre OBJETO (nunca sobre alias de cursor, onde
2684:     * dispara erro 11), e o guard de ControlCount > 0 evita descer em
2685:     * controle folha.
2686:     *==========================================================================
2687:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2688:         LOCAL loc_nI, loc_oControl
2689: 
2690:         IF VARTYPE(par_oContainer) != "O"
2691:             RETURN
2692:         ENDIF
2693: 
2694:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2695:             loc_oControl = par_oContainer.Controls(loc_nI)
2696: 
2697:             IF VARTYPE(loc_oControl) = "O"
2698:                 IF !INLIST(UPPER(loc_oControl.Name), ;
2699:                         "OBJ_4C_OPT_IMPRESSORA", "CHK_4C_CHK_RESETE", ;
2700:                         "TXT_4C_OCOETIQS", "TXT_4C_DOCOETIQS", ;
2701:                         "LBL_4C_LBLOCOETIQS", "SHP_4C_SHPOCOETIQS", ;
2702:                         "OBJ_4C_GETJUSTIFS", "LBL_4C_LBLJUSTIFS", ;
2703:                         "SHP_4C_SHPJUSTIFS")
2704:                     IF PEMSTATUS(loc_oControl, "Visible", 5)
2705:                         loc_oControl.Visible = .T.
2706:                     ENDIF
2707:                 ENDIF
2708: 
2709:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5)
2710:                     IF loc_oControl.ControlCount > 0
2711:                         THIS.TornarControlesVisiveis(loc_oControl)
2712:                     ENDIF
2713:                 ENDIF
2714:             ENDIF
2715:         ENDFOR
2716:     ENDPROC
2717: 
2718:     *==========================================================================
2719:     * Destroy - solta as referencias, reabilita o form chamador e repoe o
2720:     * menu do sistema
2721:     *
2722:     * Reabilitar par_oFormAnterior aqui eh rede de seguranca (ver contrato
2723:     * no cabecalho do arquivo): os handlers de botao das fases 7/8 ja
2724:     * reabilitam no proprio Click, e quando essas fases existirem esta
2725:     * linha sera no-op (Enabled ja .T.).
2726:     *
2727:     * O cursor da grade EH fechado aqui, e isso eh especifico desta tela: ele
2728:     * nasce no proprio form (ver CriarCursorEtiquetas) e nao eh lido por
2729:     * ninguem depois que a tela fecha - diferente do dbImpressao, que vem do
2730:     * form chamador e por isso NAO se mexe. Como o form tem DataSession = 1,
2731:     * o alias vive na sessao CORRENTE e nao seria recolhido sozinho ao fechar:
2732:     * deixado aberto, ele faria a proxima abertura da tela esbarrar no alias
2733:     * da anterior.
2734:     *
2735:     * O guard de Buffering antes do TABLEREVERT nao eh defensividade solta:
2736:     * TABLEREVERT sem buffering nao eh no-op, dispara erro 1586 ("Function
2737:     * requires row or table buffering mode"), e cursor criado por
2738:     * CREATE CURSOR nasce com Buffering = 1 - ou seja, o caminho normal eh
2739:     * justamente o que estouraria. USE IN fecha o alias mesmo com buffer
2740:     * sujo (regra CLAUDE.md #52).
2741:     *
2742:     * DODEFAULT() eh a ULTIMA linha, obrigatoriamente: FormBase.Destroy faz
2743:     * o SET SYSMENU TO DEFAULT + RELEASE POPUP + CriarMenuPrincipal() que
2744:     * repoe os pads do menu principal - sem ele o menu do sistema aparece
2745:     * encolhido.
2746:     *==========================================================================
2747:     PROCEDURE Destroy()
2748:         IF USED(THIS.this_cCursorEtiquetas)
2749:             IF CURSORGETPROP("Buffering", THIS.this_cCursorEtiquetas) > 1
2750:                 TABLEREVERT(.T., THIS.this_cCursorEtiquetas)
2751:             ENDIF
2752:             USE IN (THIS.this_cCursorEtiquetas)
2753:         ENDIF
2754: 
2755:         IF VARTYPE(THIS.this_oFormAnterior) = "O"
2756:             IF PEMSTATUS(THIS.this_oFormAnterior, "Enabled", 5)
2757:                 THIS.this_oFormAnterior.Enabled = .T.
2758:             ENDIF
2759:         ENDIF
2760: 
2761:         THIS.this_oFormAnterior   = .NULL.
2762:         THIS.this_oBusinessObject = .NULL.
2763: 
2764:         DODEFAULT()
2765:     ENDPROC
2766: 
2767:     *==========================================================================
2768:     * ObterTipoChamador - this_oFormAnterior.Tipo com guarda dupla (o
2769:     * chamador eh arbitrario - mesma guarda de AjustarBotoesPorTipoChamador,
2770:     * extraida aqui porque a Fase 7 passa a consultar o Tipo em varios
2771:     * pontos: redirecionamento de foco da grade (modo DIGITACAO), Boleto/
2772:     * Armazenar (modo ARQUIVADAS/CADASTRO) e a geracao de operacao).
2773:     *==========================================================================
2774:     PROTECTED PROCEDURE ObterTipoChamador()
2775:         LOCAL loc_cTipo
2776: 
2777:         loc_cTipo = ""
2778: 
2779:         IF VARTYPE(THIS.this_oFormAnterior) = "O"
2780:             IF PEMSTATUS(THIS.this_oFormAnterior, "Tipo", 5)
2781:                 IF VARTYPE(THIS.this_oFormAnterior.Tipo) = "C"
2782:                     loc_cTipo = UPPER(ALLTRIM(THIS.this_oFormAnterior.Tipo))
2783:                 ENDIF
2784:             ENDIF
2785:         ENDIF
2786: 
2787:         RETURN loc_cTipo
2788:     ENDPROC
2789: 
2790:     *==========================================================================
2791:     * ObterNomeImpressoraAtual - nome da impressora do WINDOWS (crImpreV.
2792:     * impres) corrente no combo Get_Printer. crImpreV so existe a partir do
2793:     * Init legado reescrito na Fase 8 (enumeracao de impressoras + CURSOR
2794:     * local) - ate la, "" (nenhuma impressora escolhida), que SigOpEtq trata
2795:     * como ausencia de nome, mesmo efeito do combo abrindo na linha em
2796:     * branco que o legado insere de proposito quando ha mais de uma
2797:     * impressora.
2798:     *==========================================================================
2799:     PROTECTED PROCEDURE ObterNomeImpressoraAtual()
2800:         LOCAL loc_cNome
2801: 
2802:         loc_cNome = ""
2803: 
2804:         IF USED("crImpreV") AND !EOF("crImpreV")
2805:             loc_cNome = ALLTRIM(crImpreV.impres)
2806:         ENDIF
2807: 
2808:         RETURN loc_cNome
2809:     ENDPROC
2810: 
2811:     *==========================================================================
2812:     * ConfigurarEventosPrincipais - BINDEVENT dos botoes/grade/combos/
2813:     * lookups da Fase 7. PEMSTATUS guarda cada alvo (regra CLAUDE.md #33/
2814:     * #38): se uma fase futura mudar nome/ordem de montagem, o bind so pula
2815:     * o que faltar, em vez de derrubar o Init inteiro.
2816:     *
2817:     * Opt_Impressora.InteractiveChange NAO eh ligado: o corpo inteiro do
2818:     * metodo legado esta comentado com "*!*" (morto desde "mena -
2819:     * 05/03/2015" - ver nota no cabecalho do arquivo) - a transcricao fiel
2820:     * de "nenhuma linha ativa" eh nao criar handler nenhum, nao um metodo
2821:     * vazio (regra de completude - metodo vazio seria stub).
2822:     *
2823:     * getQtParcs/GetJustifs/GetTexto/Opt_Conjunto.When NAO sao ligados:
2824:     * BINDEVENT descarta o valor de retorno de eventos que o VFP9 usa para
2825:     * decidir comportamento (When/Valid) em objetos NAO subclassados -
2826:     * mesma razao pela qual a Column4/Column10 da grade precisaram de
2827:     * subclasse propria (TextBoxCodBarrasIpE_4c/TextBoxParcelasIpE_4c, fim
2828:     * deste arquivo). Dos quatro, tres retornam SEMPRE .T. no legado
2829:     * (nenhum efeito pratico mesmo la); so Opt_Conjunto.When restringe
2830:     * (modo DIGITACAO) - UX secundaria, nao corrigida aqui por exigir outra
2831:     * subclasse (OptionGroup) so para isso.
2832:     *==========================================================================
2833:     PROTECTED PROCEDURE ConfigurarEventosPrincipais()
2834:         LOCAL loc_oGrid, loc_oErro
2835: 
2836:         TRY
2837:             IF PEMSTATUS(THIS, "cmg_4c_CntBotoes", 5)
2838:                 BINDEVENT(THIS.cmg_4c_CntBotoes.Buttons(1), "Click", THIS, "BtnBoletoClick")
2839:                 BINDEVENT(THIS.cmg_4c_CntBotoes.Buttons(2), "Click", THIS, "BtnSairClick")
2840:                 BINDEVENT(THIS.cmg_4c_CntBotoes.Buttons(3), "Click", THIS, "BtnDepoisClick")
2841:                 BINDEVENT(THIS.cmg_4c_CntBotoes.Buttons(4), "Click", THIS, "BtnImprimeClick")
2842:             ENDIF
2843: 
2844:             IF PEMSTATUS(THIS, "cmg_4c_CmdTestaPos", 5)
2845:                 BINDEVENT(THIS.cmg_4c_CmdTestaPos.Buttons(1), "Click", THIS, "BtnPosicaoClick")
2846:             ENDIF
2847: 
2848:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2849:                 loc_oGrid = THIS.grd_4c_Dados
2850: 
2851:                 BINDEVENT(loc_oGrid.Column2.Header1, "Click", THIS, "GradeMarcarDesmarcarTodosClick")
2852: 
2853:                 BINDEVENT(loc_oGrid.Column2.chk_4c_Check1, "Click",     THIS, "GradeCheckMarcarClick")
2854:                 BINDEVENT(loc_oGrid.Column2.chk_4c_Check1, "MouseDown", THIS, "GradeCheckMarcarMouseDown")
2855:                 BINDEVENT(loc_oGrid.Column2.chk_4c_Check1, "MouseUp",   THIS, "GradeCheckMarcarMouseUp")
2856:                 BINDEVENT(loc_oGrid.Column2.chk_4c_Check1, "KeyPress",  THIS, "GradeCheckMarcarKeyPress")
2857: 
2858:                 *-- Legado: GotFocus de Column1/3/5/7/8.Text1 redireciona
2859:                 *-- para a Column4 (codigo de barras) em modo DIGITACAO.
2860:                 BINDEVENT(loc_oGrid.Column1.Text1, "GotFocus", THIS, "GradeRedirecionarParaColunaBarras")
2861:                 BINDEVENT(loc_oGrid.Column3.Text1, "GotFocus", THIS, "GradeRedirecionarParaColunaBarras")
2862:                 BINDEVENT(loc_oGrid.Column5.Text1, "GotFocus", THIS, "GradeRedirecionarParaColunaBarras")
2863:                 BINDEVENT(loc_oGrid.Column7.Text1, "GotFocus", THIS, "GradeRedirecionarParaColunaBarras")
2864:                 BINDEVENT(loc_oGrid.Column8.Text1, "GotFocus", THIS, "GradeRedirecionarParaColunaBarras")
2865:             ENDIF
2866: 
2867:             IF PEMSTATUS(THIS, "obj_4c_Opt_Tipo", 5)
2868:                 BINDEVENT(THIS.obj_4c_Opt_Tipo, "InteractiveChange", THIS, "OptTipoInteractiveChange")
2869:             ENDIF
2870: 
2871:             IF PEMSTATUS(THIS, "cnt_4c__Impressora", 5)
2872:                 BINDEVENT(THIS.cnt_4c__Impressora.obj_4c_Opcao_imp, "Click", THIS, "OpcaoImpClick")
2873:             ENDIF
2874: 
2875:             IF PEMSTATUS(THIS, "cbo_4c_Get_Printer", 5)
2876:                 BINDEVENT(THIS.cbo_4c_Get_Printer, "InteractiveChange", THIS, "GetPrinterInteractiveChange")
2877:             ENDIF
2878: 
2879:             IF PEMSTATUS(THIS, "txt_4c_OcoEtiqs", 5)
2880:                 BINDEVENT(THIS.txt_4c_OcoEtiqs, "LostFocus", THIS, "ValidarOcorrenciaEtiqueta")
2881:             ENDIF
2882: 
2883:             IF PEMSTATUS(THIS, "txt_4c_DOcoEtiqs", 5)
2884:                 BINDEVENT(THIS.txt_4c_DOcoEtiqs, "LostFocus", THIS, "ValidarOcorrenciaEtiqueta")
2885:             ENDIF
2886:         CATCH TO loc_oErro
2887:             THIS.this_cMensagemErro = loc_oErro.Message
2888:             MsgErro(loc_oErro.Message + CHR(13) + ;
2889:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2890:                 "Procedure: " + loc_oErro.Procedure, ;
2891:                 "FormSigOpIpE.ConfigurarEventosPrincipais")
2892:         ENDTRY
2893:     ENDPROC
2894: 
2895:     *==========================================================================
2896:     * BtnBoletoClick - cntBotoes.Buttons(1) ("Boleto"). Legado:
2897:     * btnBoleto.Click (dump 3735-3789). Confirma, monta a lista de empresas
2898:     * com etiqueta selecionada e dispara o script legado SigBlBol.Prg POR
2899:     * EMPRESA (boleto de reposicao de estoque arquivado).
2900:     *
2901:     * SigBlBol.Prg NAO veio no acervo (nao existe em projeto\app\ nem em
2902:     * Framework\) - TRY/CATCH por chamada para a ausencia aparecer como
2903:     * mensagem clara (regra CLAUDE.md #13/#27), em vez de interromper o
2904:     * loop inteiro ou falhar calado.
2905:     *==========================================================================
2906:     PROCEDURE BtnBoletoClick()
2907:         LOCAL loc_lConfirmou, loc_nResultado, loc_cEmpAtual, loc_cNomeImp, ;
2908:               loc_oProgresso, loc_oErro
2909: 
2910:         loc_lConfirmou = MsgConfirma("Confirma a Impress" + CHR(227) + "o do(s) Boleto(s)?", "Boleto")
2911: 
2912:         IF loc_lConfirmou
2913:             TRY
2914:                 IF THIS.ObterTipoChamador() == "ARQUIVADAS"
2915:                     THIS.this_lImpArquivadas = .T.
2916:                 ENDIF
2917: 
2918:                 IF USED("csEmpresas")
2919:                     USE IN csEmpresas
2920:                 ENDIF
2921:                 CREATE CURSOR csEmpresas (ImpEmps L(1), CEmps C(3), Razas C(40))
2922:                 INDEX ON CEmps TAG CEmps
2923: 
2924:                 IF USED("LocalEmp")
2925:                     USE IN LocalEmp
2926:                 ENDIF
2927:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2928:                     "SELECT Cemps, Razas FROM SigCdEmp WHERE Ativas = 1 ORDER BY Cemps", "LocalEmp")
2929: 
2930:                 IF loc_nResultado < 1
2931:                     MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalEmp)")
2932:                 ELSE
2933:                     SELECT LocalEmp
2934:                     SCAN
2935:                         IF !SEEK(LocalEmp.Cemps, "csEmpresas", "CEmps")
2936:                             INSERT INTO csEmpresas (ImpEmps, CEmps, Razas) ;
2937:                                 VALUES (.T., LocalEmp.Cemps, LocalEmp.Razas)
2938:                         ENDIF
2939:                     ENDSCAN
2940: 
2941:                     IF USED("csEmps")
2942:                         USE IN csEmps
2943:                     ENDIF
2944:                     SELECT CEmps FROM csEmpresas WHERE ImpEmps INTO CURSOR csEmps
2945:                     SELECT csEmps
2946: 
2947:                     loc_oProgresso = CREATEOBJECT("fwprogressbar", "Imprimindo Boletos...", RECCOUNT())
2948:                     loc_oProgresso.Show()
2949: 
2950:                     SCAN
2951:                         loc_cEmpAtual = csEmps.Cemps
2952:                         loc_oProgresso.SubTitulo.Caption = "Boleto da Empresa : " + loc_cEmpAtual
2953:                         loc_oProgresso.Update(.T.)
2954: 
2955:                         IF USED(THIS.this_cCursorEtiquetas)
2956:                             IF USED("TmpEtiquetas")
2957:                                 USE IN TmpEtiquetas
2958:                             ENDIF
2959:                             SELECT CBars FROM (THIS.this_cCursorEtiquetas) ;
2960:                                 WHERE Empos = loc_cEmpAtual ORDER BY CBars INTO CURSOR TmpEtiquetas
2961: 
2962:                             IF USED("TmpEtiquetas") AND RECCOUNT("TmpEtiquetas") > 0
2963:                                 loc_cNomeImp = THIS.ObterNomeImpressoraAtual()
2964: 
2965:                                 TRY
2966:                                     DO SigBlBol.Prg WITH 10, , loc_cEmpAtual, "", "", 0, 64, 1, loc_cNomeImp
2967:                                 CATCH TO loc_oErro
2968:                                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel emitir o boleto da " + ;
2969:                                         "empresa " + loc_cEmpAtual + ":" + CHR(13) + loc_oErro.Message, "Erro")
2970:                                 ENDTRY
2971:                             ENDIF
2972:                         ENDIF
2973:                     ENDSCAN
2974: 
2975:                     loc_oProgresso.Complete()
2976:                 ENDIF
2977:             CATCH TO loc_oErro
2978:                 MsgErro(loc_oErro.Message + CHR(13) + ;
2979:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em BtnBoletoClick")
2980:             ENDTRY
2981:         ENDIF
2982:     ENDPROC
2983: 
2984:     *==========================================================================
2985:     * BtnSairClick - cntBotoes.Buttons(2) ("Sair", Cancel=.T. - ESC da
2986:     * tela). Legado: btnSair.Click (dump 3792-3820). Se a sessao marcou
2987:     * ImpArquivadas (Boleto ou Imprimir/Armazenar com ParentForm.Tipo =
2988:     * 'ARQUIVADAS'), desfaz o flag ImpEtiqs das etiquetas da grade antes de
2989:     * fechar - pNot = .F. no legado, ou seja REPOE ImpEtiqs = 0 (nao .T.).
2990:     *==========================================================================
2991:     PROCEDURE BtnSairClick()
2992:         LOCAL loc_cCursor, loc_cSQL, loc_oErro
2993: 
2994:         TRY
2995:             loc_cCursor = THIS.this_cCursorEtiquetas
2996: 
2997:             IF THIS.this_lImpArquivadas AND USED(loc_cCursor)
2998:                 SELECT (loc_cCursor)
2999:                 SCAN
3000:                     loc_cSQL = "UPDATE SigCdPro SET ImpEtiqs = 0 WHERE CPros = " + ;
3001:                         EscaparSQL(ALLTRIM(EVALUATE(loc_cCursor + ".CPros")))
3002: 
3003:                     IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
3004:                         MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update - SigCdPro)")
3005:                     ENDIF
3006:                 ENDSCAN
3007:             ENDIF
3008:         CATCH TO loc_oErro
3009:             MsgErro(loc_oErro.Message, "Erro em BtnSairClick")
3010:         ENDTRY
3011: 
3012:         IF VARTYPE(THIS.this_oFormAnterior) = "O"
3013:             IF PEMSTATUS(THIS.this_oFormAnterior, "Enabled", 5)
3014:                 THIS.this_oFormAnterior.Enabled = .T.
3015:             ENDIF
3016:         ENDIF
3017: 
3018:         THIS.Release()
3019:     ENDPROC
3020: 
3021:     *==========================================================================
3022:     * BtnDepoisClick/BtnImprimeClick - cntBotoes.Buttons(3)/(4) ("Armazenar"
3023:     * / "Imprimir"). Legado: btnDepois.Click/btnImprime.Click (dump
3024:     * 3823-3835) - delegam inteiros para Impressao('A')/Impressao('I').
3025:     *==========================================================================
3026:     PROCEDURE BtnDepoisClick()
3027:         THIS.Impressao("A")
3028:     ENDPROC
3029: 
3030:     PROCEDURE BtnImprimeClick()
3031:         THIS.Impressao("I")
3032:     ENDPROC
3033: 
3034:     *==========================================================================
3035:     * BtnPosicaoClick - cmdTestaPos.Buttons(1) ("Testar Posicao"). Legado:
3036:     * btnPosicao.Click (dump 3845-3886) - imprime UMA etiqueta de teste
3037:     * (CBars fixo "99999999999999", tipo 99, impressora tipo 2) a partir do
3038:     * registro CORRENTE da grade, sem olhar Flag/selecao.
3039:     *==========================================================================
3040:     PROCEDURE BtnPosicaoClick()
3041:         LOCAL loc_nAjVerts, loc_nAjHorzs, loc_nAjDenss, loc_nAjVelos, loc_cNomeImp, ;
3042:               loc_lResete, loc_cCursor, loc_oErro
3043: 
3044:         TRY
3045:             THIS.GarantirCursorImpressao()
3046: 
3047:             loc_nAjVerts = THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Value
3048:             loc_nAjHorzs = THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Value
3049:             loc_nAjDenss = THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Value
3050:             loc_nAjVelos = THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Value
3051:             loc_lResete  = (THIS.cnt_4c__Impressora.chk_4c_Chk_Resete.Value = 1)
3052:             loc_cNomeImp = THIS.ObterNomeImpressoraAtual()
3053:             loc_cCursor  = THIS.this_cCursorEtiquetas
3054: 
3055:             SELECT dbImpressao
3056:             ZAP
3057: 
3058:             IF USED(loc_cCursor) AND !EOF(loc_cCursor)
3059:                 INSERT INTO dbImpressao (Cpros, Qtds, Cbars, Obs) ;
3060:                     VALUES (EVALUATE(loc_cCursor + ".CPros"), 1, 99999999999999, "")
3061:             ENDIF
3062: 
3063:             TRY
3064:                 SigOpEtq(gnConnHandle, .F., .F., 99, 2, loc_nAjVerts, loc_nAjHorzs, loc_nAjDenss, , , , ;
3065:                     loc_cNomeImp, .F., .F., loc_nAjVelos, .F., .F., .F., .F., .F., loc_lResete)
3066:             CATCH TO loc_oErro
3067:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel testar a posi" + CHR(231) + CHR(227) + ;
3068:                     "o:" + CHR(13) + loc_oErro.Message, "Erro")
3069:             ENDTRY
3070:         CATCH TO loc_oErro
3071:             MsgErro(loc_oErro.Message + CHR(13) + ;
3072:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em BtnPosicaoClick")
3073:         ENDTRY
3074:     ENDPROC
3075: 
3076:     *==========================================================================
3077:     * GarantirCursorImpressao - cria "dbImpressao" (nome LEGADO mantido de
3078:     * proposito - contrato entre forms, ver nota em this_cCursorEtiquetas)
3079:     * se ainda nao existir. O legado declara esse cursor com DUAS
3080:     * estruturas levemente diferentes conforme o metodo (Impressao: Cbars

*-- Linhas 3086 a 3587:
3086:     * UNIAO das duas larguras (a maior de cada campo) para nao truncar
3087:     * nenhum dos dois usos.
3088:     *==========================================================================
3089:     PROTECTED PROCEDURE GarantirCursorImpressao()
3090:         IF !USED("dbImpressao")
3091:             CREATE CURSOR dbImpressao ( ;
3092:                 CPros      C(14), ;
3093:                 Qtds       N(10, 3), ;
3094:                 QtdeEtiq   N(10, 3), ;
3095:                 Pedido     C(30), ;
3096:                 Obs        C(10), ;
3097:                 Cbars      N(16, 0), ;
3098:                 Pvens      N(12, 2), ;
3099:                 PrecoDe    N(12, 2), ;
3100:                 Parcelas   N(2, 0), ;
3101:                 Moedas     C(3), ;
3102:                 EmpDopNums C(29), ;
3103:                 Reffs      C(40), ;
3104:                 Empos      C(3), ;
3105:                 Cpros1     C(14), ;
3106:                 CodTams    C(4))
3107:         ENDIF
3108:     ENDPROC
3109: 
3110:     *==========================================================================
3111:     * GradeMarcarDesmarcarTodosClick - Column2.Header1.Click do legado
3112:     * (dump 3352-3364): alterna TODAS as linhas da grade entre marcada e
3113:     * desmarcada, usando o Tag do proprio Header1 como memoria do estado
3114:     * ("X" = tudo marcado).
3115:     *==========================================================================
3116:     PROCEDURE GradeMarcarDesmarcarTodosClick()
3117:         LOCAL loc_oHeader, loc_cCursor, loc_oErro
3118: 
3119:         TRY
3120:             loc_oHeader = THIS.grd_4c_Dados.Column2.Header1
3121:             loc_cCursor = THIS.this_cCursorEtiquetas
3122: 
3123:             IF loc_oHeader.Tag == "X"
3124:                 loc_oHeader.Tag = ""
3125:                 IF USED(loc_cCursor)
3126:                     REPLACE ALL Flag WITH .F. IN (loc_cCursor)
3127:                 ENDIF
3128:             ELSE
3129:                 loc_oHeader.Tag = "X"
3130:                 IF USED(loc_cCursor)
3131:                     REPLACE ALL Flag WITH .T. IN (loc_cCursor)
3132:                 ENDIF
3133:             ENDIF
3134: 
3135:             THIS.grd_4c_Dados.Refresh()
3136:         CATCH TO loc_oErro
3137:             MsgErro(loc_oErro.Message, "Erro em GradeMarcarDesmarcarTodosClick")
3138:         ENDTRY
3139:     ENDPROC
3140: 
3141:     *==========================================================================
3142:     * GradeCheckMarcar* - toggle do CheckBox de marcacao da grade
3143:     * (Column2.chk_4c_Check1). CheckBox em coluna de Grid nao alterna pelo
3144:     * binding nativo - exige os quatro handlers com NODEFAULT: Click/
3145:     * MouseDown so suprimem o toggle nativo (que desalinharia do REPLACE
3146:     * abaixo), MouseUp delega para o KeyPress(13), e o KeyPress eh quem de
3147:     * fato grava o novo valor no cursor e repinta a grade.
3148:     *==========================================================================
3149:     PROCEDURE GradeCheckMarcarClick()
3150:         NODEFAULT
3151:     ENDPROC
3152: 
3153:     PROCEDURE GradeCheckMarcarMouseDown(par_nButton, par_nShiftAltCtrl, par_nRow, par_nCol)
3154:         NODEFAULT
3155:     ENDPROC
3156: 
3157:     PROCEDURE GradeCheckMarcarMouseUp(par_nButton, par_nShiftAltCtrl, par_nRow, par_nCol)
3158:         THIS.GradeCheckMarcarKeyPress(13, 0)
3159:         NODEFAULT
3160:     ENDPROC
3161: 
3162:     PROCEDURE GradeCheckMarcarKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3163:         LOCAL loc_cCursor, loc_oErro
3164: 
3165:         IF INLIST(par_nKeyCode, 13, 32)
3166:             TRY
3167:                 loc_cCursor = THIS.this_cCursorEtiquetas
3168: 
3169:                 IF USED(loc_cCursor) AND !EOF(loc_cCursor)
3170:                     SELECT (loc_cCursor)
3171:                     REPLACE Flag WITH !Flag
3172:                     THIS.grd_4c_Dados.Refresh()
3173:                 ENDIF
3174:             CATCH TO loc_oErro
3175:                 MsgErro(loc_oErro.Message, "Erro em GradeCheckMarcarKeyPress")
3176:             ENDTRY
3177: 
3178:             NODEFAULT
3179:         ENDIF
3180:     ENDPROC
3181: 
3182:     *==========================================================================
3183:     * GradeRedirecionarParaColunaBarras - GotFocus de Column1/3/5/7/8.Text1
3184:     * (dump: cada uma identica, "If ParentForm.Tipo='DIGITACAO' / Column4.
3185:     * SetFocus"). Em modo DIGITACAO a unica coluna editavel eh a de codigo
3186:     * de barras - as demais apenas EXIBEM e redirecionam o foco de volta.
3187:     *==========================================================================
3188:     PROCEDURE GradeRedirecionarParaColunaBarras()
3189:         IF THIS.ObterTipoChamador() == "DIGITACAO"
3190:             THIS.grd_4c_Dados.Column4.SetFocus()
3191:         ENDIF
3192:     ENDPROC
3193: 
3194:     *==========================================================================
3195:     * ValidarCodigoBarrasGrade - Valid de txt_4c_CodBarras (Column4),
3196:     * chamado pela subclasse TextBoxCodBarrasIpE_4c (fim deste arquivo, via
3197:     * THISFORM - regra CLAUDE.md #46: BINDEVENT em "Valid" de TextBox de
3198:     * Column nao eh confiavel). Transcreve grd_historico.Column4.Text1.
3199:     * Valid do legado (dump 3399-3466): o usuario digita/bipa um codigo de
3200:     * barras em modo DIGITACAO; o metodo resolve o barcode (inclusive
3201:     * remapeamento via sigopeta), confere duplicidade na grade e adiciona
3202:     * uma linha nova a partir da etiqueta encontrada em SigOpEtq/SigCdPro.
3203:     *
3204:     * RETURN so FORA do TRY (regra CLAUDE.md #1) - os varios pontos de
3205:     * aborto do legado ("Return 0") viram o flag loc_lResultado.
3206:     *==========================================================================
3207:     PROCEDURE ValidarCodigoBarrasGrade(par_oTxt)
3208:         LOCAL loc_nEti, loc_cBars, loc_cCursor, loc_cSQL, loc_nResultado, ;
3209:               loc_nRecOriginal, loc_lResultado, loc_lProsseguir, loc_oErro
3210: 
3211:         loc_lResultado = .T.
3212: 
3213:         IF VARTYPE(par_oTxt) = "O"
3214:             loc_nEti = par_oTxt.Value
3215: 
3216:             IF !EMPTY(loc_nEti) AND par_oTxt.Tag != STR(loc_nEti, 14)
3217:                 loc_cCursor     = THIS.this_cCursorEtiquetas
3218:                 loc_lProsseguir = .T.
3219: 
3220:                 TRY
3221:                     loc_cBars = ALLTRIM(STR(loc_nEti, 14))
3222: 
3223:                     IF USED("CrEtiqs")
3224:                         USE IN CrEtiqs
3225:                     ENDIF
3226:                     loc_cSQL = "SELECT a.CPros, a.CBars FROM SigOpEtq a " + ;
3227:                         "LEFT JOIN sigopeta b ON a.cpros = b.cpros AND a.cbars = b.cbars_new " + ;
3228:                         "WHERE (a.CBars = " + loc_cBars + " OR b.cbars_old = " + loc_cBars + ")"
3229:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "CrEtiqs")
3230: 
3231:                     IF loc_nResultado < 1
3232:                         MsgErro("Favor reinicializar o processo !!!", "Falha na Conex" + CHR(227) + "o (CrEtiqs)")
3233:                         loc_lResultado  = .F.
3234:                         loc_lProsseguir = .F.
3235:                     ENDIF
3236: 
3237:                     IF loc_lProsseguir
3238:                         SELECT CrEtiqs
3239:                         GO TOP
3240: 
3241:                         IF EOF("CrEtiqs")
3242:                             MsgAviso("A Etiqueta Digitada N" + CHR(227) + "o Foi Encontrada!!!", "")
3243:                             loc_lResultado  = .F.
3244:                             loc_lProsseguir = .F.
3245:                         ENDIF
3246:                     ENDIF
3247: 
3248:                     IF loc_lProsseguir
3249:                         par_oTxt.Value = CrEtiqs.CBars
3250:                         loc_nEti       = par_oTxt.Value
3251: 
3252:                         IF USED("LocalEti")
3253:                             USE IN LocalEti
3254:                         ENDIF
3255:                         loc_cSQL = "SELECT a.*, b.pvens, CASE WHEN b.precode = 0 THEN b.pvens ELSE b.precode END " + ;
3256:                             "AS precode FROM SigOpEtq a, SigCdPro b WHERE a.CPros = b.CPros AND a.Cbars = " + ;
3257:                             ALLTRIM(STR(loc_nEti, 14))
3258:                         SQLEXEC(gnConnHandle, loc_cSQL, "LocalEti")
3259: 
3260:                         IF !USED("LocalEti") OR EOF("LocalEti")
3261:                             MsgAviso("A Etiqueta Digitada N" + CHR(227) + "o Foi Encontrada!!!", "")
3262:                             loc_lResultado  = .F.
3263:                             loc_lProsseguir = .F.
3264:                         ENDIF
3265:                     ENDIF
3266: 
3267:                     IF loc_lProsseguir
3268:                         IF EMPTY(LocalEti.Grupos) AND EMPTY(LocalEti.Contas)
3269:                             MsgAviso("A Etiqueta Digitada J" + CHR(225) + " Foi Vendida!!!", "")
3270:                             loc_lResultado  = .F.
3271:                             loc_lProsseguir = .F.
3272:                         ENDIF
3273:                     ENDIF
3274: 
3275:                     IF loc_lProsseguir
3276:                         loc_nRecOriginal = RECNO(loc_cCursor)
3277: 
3278:                         IF USED("crTmp")
3279:                             USE IN crTmp
3280:                         ENDIF
3281:                         SELECT CBars FROM (loc_cCursor) ;
3282:                             WHERE CBars = loc_nEti AND !EMPTY(CPros) AND RECNO() != loc_nRecOriginal ;
3283:                             INTO CURSOR crTmp
3284: 
3285:                         IF RECCOUNT("crTmp") > 0
3286:                             MsgAviso("Etiqueta J" + CHR(225) + " Digitada Na Sele" + CHR(231) + CHR(227) + "o Atual!!!", "")
3287:                             par_oTxt.Value  = 0
3288:                             loc_lResultado  = .F.
3289:                             loc_lProsseguir = .F.
3290:                         ENDIF
3291:                     ENDIF
3292: 
3293:                     IF loc_lProsseguir
3294:                         SELECT LocalEti
3295:                         SCATTER MEMVAR
3296: 
3297:                         SELECT (loc_cCursor)
3298:                         GATHER MEMVAR
3299:                         REPLACE Flag WITH .T.
3300: 
3301:                         APPEND BLANK
3302:                         GO BOTTOM
3303: 
3304:                         THIS.grd_4c_Dados.Refresh()
3305:                     ENDIF
3306:                 CATCH TO loc_oErro
3307:                     MsgErro(loc_oErro.Message + CHR(13) + ;
3308:                         "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em ValidarCodigoBarrasGrade")
3309:                     loc_lResultado = .F.
3310:                 ENDTRY
3311:             ENDIF
3312:         ENDIF
3313: 
3314:         RETURN loc_lResultado
3315:     ENDPROC
3316: 
3317:     *==========================================================================
3318:     * ValidarParcelasGrade/PodeEditarParcelas - Valid/When de
3319:     * txt_4c_Parcelas (Column10), chamados pela subclasse
3320:     * TextBoxParcelasIpE_4c. Transcrevem Column10.Text1.Valid/When do
3321:     * legado (dump 3540-3559): a coluna so eh editavel quando opt_Preco
3322:     * seleciona "Parcelamento" (Buttons(6)), e o valor digitado nao pode
3323:     * ultrapassar LocalParaC.QtdMarPar (parametro carregado no Init por
3324:     * CarregarParametrosSistema, Fase 8); o guard USED()/NVL continua
3325:     * valendo como leitura defensiva equivalente ao "If Not Empty(Local-
3326:     * ParaC.QtdMarPar)" do legado para qualquer caminho em que o cursor
3327:     * nao tenha sido populado (ex. falha de conexao).
3328:     *==========================================================================
3329:     PROCEDURE ValidarParcelasGrade(par_oTxt)
3330:         LOCAL loc_lResultado
3331: 
3332:         loc_lResultado = .T.
3333: 
3334:         IF VARTYPE(par_oTxt) = "O" AND !EMPTY(par_oTxt.Value)
3335:             IF USED("LocalParaC") AND !EMPTY(NVL(LocalParaC.QtdMarPar, 0))
3336:                 IF LocalParaC.QtdMarPar < par_oTxt.Value
3337:                     MsgAviso("Quantidade de Parcelas informadas ultrapassa o M" + CHR(225) + "x" + CHR(237) + ;
3338:                         "mo Permitido.", "Verifique")
3339:                     par_oTxt.Value = 0
3340:                     loc_lResultado = .F.
3341:                 ENDIF
3342:             ENDIF
3343:         ENDIF
3344: 
3345:         RETURN loc_lResultado
3346:     ENDPROC
3347: 
3348:     PROCEDURE PodeEditarParcelas()
3349:         RETURN (THIS.obj_4c_Opt_Preco.Value = 6)
3350:     ENDPROC
3351: 
3352:     *==========================================================================
3353:     * OptTipoInteractiveChange - Opt_Tipo.InteractiveChange do legado (dump
3354:     * 3569-3585): mostra/esconde cmdTestaPos, GetTexto/Label7 (tipos de
3355:     * texto livre) e getQtParcs/Label8 (tipo 136, parcelas) conforme o Tag
3356:     * do botao marcado.
3357:     *==========================================================================
3358:     PROCEDURE OptTipoInteractiveChange()
3359:         LOCAL loc_oGrupo, loc_nTpEti
3360: 
3361:         loc_oGrupo = THIS.obj_4c_Opt_Tipo
3362:         loc_nTpEti = INT(VAL(loc_oGrupo.Buttons(loc_oGrupo.Value).Tag))
3363: 
3364:         THIS.cmg_4c_CmdTestaPos.Visible = (loc_nTpEti = 80)
3365:         THIS.obj_4c_GetTexto.Visible    = INLIST(loc_nTpEti, 127, 131, 164, 168)
3366:         THIS.lbl_4c_Label8.Visible      = INLIST(loc_nTpEti, 136)
3367:         THIS.txt_4c_QtParcs.Visible     = INLIST(loc_nTpEti, 136)
3368:         THIS.lbl_4c_Label7.Visible      = INLIST(loc_nTpEti, 127, 131, 164, 168)
3369:     ENDPROC
3370: 
3371:     *==========================================================================
3372:     * OpcaoImpClick - Cnt_Impressora.Opcao_imp.Click do legado (dump
3373:     * 3718-3725): trocar o tipo de impressora esconde de novo o
3374:     * "Enviar Comando Reset" - ele nunca volta a aparecer nesta
3375:     * migracao, porque quem o reexibia era fCarregarImps (global nao
3376:     * portada, regra CLAUDE.md #27), nao algo coberto pela Fase 8.
3377:     *==========================================================================
3378:     PROCEDURE OpcaoImpClick()
3379:         THIS.cnt_4c__Impressora.chk_4c_Chk_Resete.Visible = .F.
3380:         THIS.cnt_4c__Impressora.chk_4c_Chk_Resete.Refresh()
3381:     ENDPROC
3382: 
3383:     *==========================================================================
3384:     * GetPrinterInteractiveChange/ValidarImpressoraSelecionada - Get_Printer.
3385:     * InteractiveChange do legado (dump 3898-3903): le o nome CADASTRADO da
3386:     * impressora (crImpreV.impresS - coluna DIFERENTE de impresS/impres,
3387:     * ver SigOpIpEBO.CarregarAjustesImpressora) e espelha nos controles de
3388:     * Cnt_Impressora o que SigCdmp tem para ela. Mesma decisao arquitetural
3389:     * do BO irmao sigopetsBO/Formsigopets (fCarregarImps nao veio no
3390:     * acervo - regra CLAUDE.md #27).
3391:     *
3392:     * crImpreV so existe a partir da Fase 8 (enumeracao de impressoras do
3393:     * Init reescrito) - ate la, GetPrinterInteractiveChange recebe "" e
3394:     * ValidarImpressoraSelecionada sai calada (nome vazio eh caminho
3395:     * legitimo - regra CLAUDE.md #50).
3396:     *==========================================================================
3397:     PROCEDURE GetPrinterInteractiveChange()
3398:         THIS.ValidarImpressoraSelecionada(THIS.ObterNomeImpressoraAtual())
3399:     ENDPROC
3400: 
3401:     PROCEDURE ValidarImpressoraSelecionada(par_cNomeImpressora)
3402:         LOCAL loc_cNome, loc_lModoSemBanco, loc_oBO, loc_oErro
3403: 
3404:         loc_cNome = IIF(VARTYPE(par_cNomeImpressora) = "C", ALLTRIM(par_cNomeImpressora), "")
3405: 
3406:         IF EMPTY(loc_cNome)
3407:             RETURN
3408:         ENDIF
3409: 
3410:         loc_lModoSemBanco = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
3411:                             (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)
3412: 
3413:         IF loc_lModoSemBanco
3414:             RETURN
3415:         ENDIF
3416: 
3417:         TRY
3418:             loc_oBO = THIS.this_oBusinessObject
3419: 
3420:             IF VARTYPE(loc_oBO) = "O"
3421:                 IF loc_oBO.CarregarAjustesImpressora(loc_cNome)
3422:                     IF loc_oBO.this_nTipoImpressora >= 1 AND ;
3423:                             loc_oBO.this_nTipoImpressora <= THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.ButtonCount
3424:                         THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value = loc_oBO.this_nTipoImpressora
3425:                     ENDIF
3426:                     THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Value = loc_oBO.this_nAjusteVertical
3427:                     THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Value = loc_oBO.this_nAjusteHorizontal
3428:                     THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Value = loc_oBO.this_nAjusteDensidade
3429:                     THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Value = loc_oBO.this_nAjusteVelocidade
3430:                 ELSE
3431:                     IF !EMPTY(loc_oBO.this_cMensagemErro)
3432:                         MsgAviso(loc_oBO.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
3433:                     ENDIF
3434:                 ENDIF
3435:             ENDIF
3436:         CATCH TO loc_oErro
3437:             MsgErro(loc_oErro.Message + CHR(13) + ;
3438:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em ValidarImpressoraSelecionada")
3439:         ENDTRY
3440:     ENDPROC
3441: 
3442:     *==========================================================================
3443:     * ValidarOcorrenciaEtiqueta - funil UNICO para getOcoEtiqs.Valid E
3444:     * getDOcoEtiqs.Valid do legado (dump 3594-3657, identicos exceto pela
3445:     * coluna de busca): liga em "LostFocus" (regra CLAUDE.md #47 - Valid de
3446:     * TextBox solto nao dispara confiavel via BINDEVENT) e substitui o
3447:     * fwbuscaext legado por FormBuscaAuxiliar contra SigEtOco (padrao do
3448:     * projeto).
3449:     *
3450:     * Guarda de reentrancia (this_lEmLookupOcorrencia): o picker eh MODAL e
3451:     * tira o foco, redisparando o proprio LostFocus (regra CLAUDE.md #37/
3452:     * #47).
3453:     *==========================================================================
3454:     PROCEDURE ValidarOcorrenciaEtiqueta()
3455:         LOCAL loc_cCodigo, loc_cDescricao, loc_lAchou, loc_cSQL, loc_nResultado, ;
3456:               loc_oBusca, loc_oErro
3457: 
3458:         IF THIS.this_lEmLookupOcorrencia
3459:             RETURN
3460:         ENDIF
3461: 
3462:         THIS.this_lEmLookupOcorrencia = .T.
3463: 
3464:         TRY
3465:             loc_cCodigo    = ALLTRIM(THIS.txt_4c_OcoEtiqs.Value)
3466:             loc_cDescricao = ALLTRIM(THIS.txt_4c_DOcoEtiqs.Value)
3467: 
3468:             IF EMPTY(loc_cCodigo) AND EMPTY(loc_cDescricao)
3469:                 THIS.txt_4c_OcoEtiqs.Value  = ""
3470:                 THIS.txt_4c_DOcoEtiqs.Value = ""
3471:             ELSE
3472:                 loc_lAchou = .F.
3473: 
3474:                 IF USED("cursor_4c_OcoEtiq")
3475:                     USE IN cursor_4c_OcoEtiq
3476:                 ENDIF
3477: 
3478:                 IF !EMPTY(loc_cCodigo)
3479:                     loc_cSQL = "SELECT TOP 1 Cods, Descrs FROM SigEtOco WHERE Cods = " + EscaparSQL(loc_cCodigo)
3480:                 ELSE
3481:                     loc_cSQL = "SELECT TOP 1 Cods, Descrs FROM SigEtOco WHERE Descrs = " + EscaparSQL(loc_cDescricao)
3482:                 ENDIF
3483: 
3484:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OcoEtiq")
3485: 
3486:                 IF loc_nResultado >= 1 AND USED("cursor_4c_OcoEtiq") AND RECCOUNT("cursor_4c_OcoEtiq") > 0
3487:                     SELECT cursor_4c_OcoEtiq
3488:                     GO TOP
3489:                     THIS.txt_4c_OcoEtiqs.Value  = ALLTRIM(Cods)
3490:                     THIS.txt_4c_DOcoEtiqs.Value = ALLTRIM(Descrs)
3491:                     loc_lAchou = .T.
3492:                 ENDIF
3493: 
3494:                 IF USED("cursor_4c_OcoEtiq")
3495:                     USE IN cursor_4c_OcoEtiq
3496:                 ENDIF
3497: 
3498:                 *-- Nao achou exato: abre o picker (regra CLAUDE.md #50 -
3499:                 *-- sem aviso, o picker JA eh o feedback; o codigo digitado
3500:                 *-- vira prefixo).
3501:                 IF !loc_lAchou
3502:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigEtOco", ;
3503:                         "cursor_4c_OcoEtiqBusca", "Cods", IIF(!EMPTY(loc_cCodigo), loc_cCodigo, loc_cDescricao), ;
3504:                         "Sele" + CHR(231) + CHR(227) + "o", .F., .T., "")
3505: 
3506:                     IF VARTYPE(loc_oBusca) = "O"
3507:                         IF !loc_oBusca.this_lAchouRegistro
3508:                             loc_oBusca.mAddColuna("Cods",   "", "C" + CHR(243) + "digo")
3509:                             loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
3510:                             loc_oBusca.Show()
3511:                         ENDIF
3512: 
3513:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_OcoEtiqBusca")
3514:                             SELECT cursor_4c_OcoEtiqBusca
3515:                             THIS.txt_4c_OcoEtiqs.Value  = ALLTRIM(Cods)
3516:                             THIS.txt_4c_DOcoEtiqs.Value = ALLTRIM(Descrs)
3517:                         ELSE
3518:                             THIS.txt_4c_OcoEtiqs.Value  = ""
3519:                             THIS.txt_4c_DOcoEtiqs.Value = ""
3520:                         ENDIF
3521: 
3522:                         loc_oBusca.Release()
3523:                     ENDIF
3524: 
3525:                     IF USED("cursor_4c_OcoEtiqBusca")
3526:                         USE IN cursor_4c_OcoEtiqBusca
3527:                     ENDIF
3528:                 ENDIF
3529:             ENDIF
3530: 
3531:             THIS.txt_4c_OcoEtiqs.Refresh()
3532:             THIS.txt_4c_DOcoEtiqs.Refresh()
3533:         CATCH TO loc_oErro
3534:             MsgErro(loc_oErro.Message + CHR(13) + ;
3535:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em ValidarOcorrenciaEtiqueta")
3536:         ENDTRY
3537: 
3538:         THIS.this_lEmLookupOcorrencia = .F.
3539:     ENDPROC
3540: 
3541:     *==========================================================================
3542:     * MontaConjunto - montaconjunto do legado (dump 2544-2579): quando
3543:     * Opt_Conjunto = "Sim", colapsa TODAS as linhas de dbImpressao numa
3544:     * UNICA linha consolidada (quantidades/pesos somados, demais campos
3545:     * pelo MAX).
3546:     *==========================================================================
3547:     PROCEDURE MontaConjunto()
3548:         LOCAL loc_oErro
3549: 
3550:         IF THIS.obj_4c_Opt_Conjunto.Value = 1
3551:             TRY
3552:                 IF USED("csConjunto")
3553:                     USE IN csConjunto
3554:                 ENDIF
3555: 
3556:                 SELECT MAX(cpros) AS Cpros, MAX(Qtds) AS Qtds, MAX(QtdeEtiq) AS QtdeEtiq, ;
3557:                        MAX(Pedido) AS Pedido, "" AS Obs, SUM(Pvens) AS Pvens, MAX(Moedas) AS Moedas, ;
3558:                        "" AS Empos, MAX(cpros1) AS cpros1, SUM(PrecoDe) AS PrecoDe, MAX(Parcelas) AS Parcelas ;
3559:                     FROM dbImpressao ;
3560:                     INTO CURSOR csConjunto READWRITE
3561: 
3562:                 SELECT dbImpressao
3563:                 ZAP
3564: 
3565:                 SELECT csConjunto
3566:                 GO TOP
3567:                 SCAN
3568:                     SCATTER MEMVAR
3569:                     SELECT dbImpressao
3570:                     APPEND BLANK
3571:                     GATHER MEMVAR
3572:                     SELECT csConjunto
3573:                 ENDSCAN
3574: 
3575:                 SELECT dbImpressao
3576:                 GO TOP
3577: 
3578:                 IF USED("csConjunto")
3579:                     USE IN csConjunto
3580:                 ENDIF
3581:             CATCH TO loc_oErro
3582:                 MsgErro(loc_oErro.Message, "Erro em MontaConjunto")
3583:             ENDTRY
3584:         ENDIF
3585:     ENDPROC
3586: 
3587:     *==========================================================================

*-- Linhas 3599 a 3710:
3599:     * exist" sem indicar qual arquivo.
3600:     *==========================================================================
3601:     *-- ============================================================
3602:     *-- PROCEDURE ExecutarReportForm (Pattern #117 / #123)
3603:     *-- Executa REPORT FORM apenas se o FRX existir; caso contrario,
3604:     *-- exibe MostrarErro descritivo com o path faltante.
3605:     *-- Isola SET POINT/SEPARATOR/REPORTBEHAVIOR durante o REPORT FORM
3606:     *-- porque FRXs legados Fortyus (VFP6/7/8) foram desenhados com
3607:     *-- POINT="." + REPORTBEHAVIOR 80. Sem isolamento o modo 90 remede
3608:     *-- fontes em runtime e mostra asteriscos em campos numericos.
3609:     *-- par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
3610:     *-- par_cCursorDados: opcional. Se informado e cursor estiver vazio,
3611:     *--   mostra MsgAviso e retorna .F. sem abrir preview vazio.
3612:     *-- ============================================================
3613:     PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
3614:         LOCAL loc_cFRX
3615:         loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")
3616: 
3617:         IF NOT FILE(loc_cFRX)
3618:             MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
3619:                 loc_cFRX + CHR(13) + CHR(13) + ;
3620:                 "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
3621:             RETURN .F.
3622:         ENDIF
3623: 
3624:         *-- Guard cursor vazio: evita preview em branco / impressao vazia (Erro30)
3625:         IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
3626:             IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
3627:                 MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
3628:                     "Aten" + CHR(231) + CHR(227) + "o")
3629:                 RETURN .F.
3630:             ENDIF
3631:         ENDIF
3632: 
3633:         *-- Isolamento de locale + modo de renderizacao (Erro28)
3634:         LOCAL loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig
3635:         loc_cPointOrig    = SET("POINT")
3636:         loc_cSepOrig      = SET("SEPARATOR")
3637:         loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
3638:         SET POINT TO "."
3639:         SET SEPARATOR TO ","
3640:         SET REPORTBEHAVIOR 80
3641: 
3642:         DO CASE
3643:             CASE par_cModo == "PREVIEW"
3644:                 REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
3645:             CASE par_cModo == "PRINTER_PROMPT"
3646:                 REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
3647:             CASE par_cModo == "PRINTER"
3648:                 REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
3649:         ENDCASE
3650: 
3651:         SET POINT TO (loc_cPointOrig)
3652:         SET SEPARATOR TO (loc_cSepOrig)
3653:         SET REPORTBEHAVIOR (loc_nBehaviorOrig)
3654: 
3655:         *-- Restaurar menu (Erro63): REPORT FORM PREVIEW abre toolbar propria
3656:         *-- que corrompe cache visual do _MSYSMENU. Sem RELEASE + Criar aqui,
3657:         *-- popups renderizam encolhidos apos preview fechar. Mesmo fix do
3658:         *-- FormBase.Destroy (Erro58) precisa rodar no path REPORT PREVIEW.
3659:         TRY
3660:             SET SYSMENU TO DEFAULT
3661:             RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda
3662:             CriarMenuPrincipal()
3663:         CATCH
3664:             *-- CriarMenuPrincipal fora do escopo (teste automatizado) - silencioso
3665:         ENDTRY
3666: 
3667:         RETURN .T.
3668:     ENDPROC
3669: 
3670:     PROCEDURE TagModelo1(par_nTpEti, par_lImpPreco, par_cTipo)
3671:         LOCAL loc_lEhModelo1, loc_cCursor, loc_nBrr, loc_oErro
3672: 
3673:         loc_lEhModelo1 = .F.
3674:         loc_cCursor    = THIS.this_cCursorEtiquetas
3675: 
3676:         IF USED("LocalTpEti")
3677:             SELECT LocalTpEti
3678:             LOCATE FOR LocalTpEti.nTipos = par_nTpEti
3679: 
3680:             IF !EOF() AND LocalTpEti.tpespes = 2
3681:                 loc_lEhModelo1 = .T.
3682: 
3683:                 TRY
3684:                     IF USED("dbImpressao")
3685:                         USE IN dbImpressao
3686:                     ENDIF
3687:                     CREATE CURSOR dbImpressao (CPros C(14), dpros C(40), Cbars N(14, 0), ;
3688:                         Pvens N(12, 2), razas C(30), Reffs C(40), codtams C(4), CodCors C(4))
3689:                     INDEX ON cpros TAG cpros
3690: 
3691:                     SQLEXEC(gnConnHandle, "SELECT cemps, razas FROM SigCdEmp", "crSigCdEmp")
3692:                     SQLEXEC(gnConnHandle, "SELECT observas, codigos FROM SigCdObs", "crSigCdObs")
3693: 
3694:                     IF USED(loc_cCursor)
3695:                         SELECT (loc_cCursor)
3696:                         SCAN
3697:                             IF EVALUATE(loc_cCursor + ".Flag")
3698:                                 IF USED("crSigCdEmp")
3699:                                     SELECT crSigCdEmp
3700:                                     LOCATE FOR cemps = EVALUATE(loc_cCursor + ".empos")
3701:                                 ENDIF
3702: 
3703:                                 IF USED("crSigCdObs")
3704:                                     SELECT crSigCdObs
3705:                                     LOCATE FOR codigos = LocalTpEti.codobs
3706:                                 ENDIF
3707: 
3708:                                 SQLEXEC(gnConnHandle, "SELECT dpros, PVIdeals, Moedas, PVens, Moevs FROM SigCdPro " + ;
3709:                                     "WHERE Cpros = " + EscaparSQL(EVALUATE(loc_cCursor + ".Cpros")), "LocalPro")
3710: 

*-- Linhas 3760 a 3942:
3760:     * do legado (dump 2219-2234/2354-2367): grava um registro em SigEtOcr
3761:     * por linha impressa, com a ocorrencia/justificativa escolhidas.
3762:     *==========================================================================
3763:     PROCEDURE RegistrarOcorrenciaEtiquetas()
3764:         LOCAL loc_cSQL, loc_oErro
3765: 
3766:         IF THIS.this_lGravaOcorrencia AND USED("dbImpressao")
3767:             TRY
3768:                 SELECT dbImpressao
3769:                 SCAN
3770:                     loc_cSQL = "INSERT INTO SigEtOcr (Cbars, Datas, Horas, Usuars, Qtds, Cods, Justifs, cidchaves) " + ;
3771:                         "VALUES (" + ;
3772:                         FormatarNumeroSQL(INT(VAL(dbImpressao.Cpros)), 0) + ", " + ;
3773:                         FormatarDataSQL(DATE()) + ", " + ;
3774:                         EscaparSQL(TIME()) + ", " + ;
3775:                         EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
3776:                         FormatarNumeroSQL(dbImpressao.QtdeEtiq, 0) + ", " + ;
3777:                         EscaparSQL(ALLTRIM(THIS.txt_4c_OcoEtiqs.Value)) + ", " + ;
3778:                         EscaparSQL(THIS.obj_4c_GetJustifs.Value) + ", " + ;
3779:                         EscaparSQL(LEFT(fUniqueIds(), 20)) + ")"
3780: 
3781:                     IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
3782:                         MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update - SigEtOcr)")
3783:                     ENDIF
3784:                 ENDSCAN
3785:             CATCH TO loc_oErro
3786:                 MsgErro(loc_oErro.Message, "Erro em RegistrarOcorrenciaEtiquetas")
3787:             ENDTRY
3788:         ENDIF
3789:     ENDPROC
3790: 
3791:     *==========================================================================
3792:     * ImpressaoValidarOcorrenciaObrigatoria - "Consiste os Parametros" do
3793:     * Impressao() legado (dump 1949-1970): a Ocorrencia eh obrigatoria
3794:     * quando this_lGravaOcorrencia, e a Justificativa eh obrigatoria quando
3795:     * a ocorrencia escolhida exige (SigEtOco.Justifs = 1).
3796:     *==========================================================================
3797:     PROCEDURE ImpressaoValidarOcorrenciaObrigatoria()
3798:         LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_oErro
3799: 
3800:         loc_lResultado = .T.
3801: 
3802:         IF THIS.this_lGravaOcorrencia AND EMPTY(THIS.txt_4c_OcoEtiqs.Value)
3803:             MsgAviso("A Ocorr" + CHR(234) + "ncia da Impress" + CHR(227) + "o de Etiquetas " + CHR(233) + ;
3804:                 " Inv" + CHR(225) + "lida!!!", "")
3805:             THIS.txt_4c_OcoEtiqs.SetFocus()
3806:             loc_lResultado = .F.
3807:         ELSE
3808:             IF !EMPTY(THIS.txt_4c_OcoEtiqs.Value)
3809:                 TRY
3810:                     IF USED("TmpOcEti")
3811:                         USE IN TmpOcEti
3812:                     ENDIF
3813:                     loc_cSQL = "SELECT * FROM SigEtOco WHERE Cods = " + EscaparSQL(ALLTRIM(THIS.txt_4c_OcoEtiqs.Value))
3814:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "TmpOcEti")
3815: 
3816:                     IF loc_nResultado < 1
3817:                         MsgErro("Favor reinicializar o processo !!!", "Falha na Conex" + CHR(227) + "o (TmpOcEti)")
3818:                         loc_lResultado = .F.
3819:                     ELSE
3820:                         SELECT TmpOcEti
3821:                         GO TOP
3822:                         IF !EOF() AND TmpOcEti.Justifs = 1 AND EMPTY(THIS.obj_4c_GetJustifs.Value)
3823:                             MsgAviso("Ocorr" + CHR(234) + "ncia com Justificativa Obrigat" + CHR(243) + "ria !!!", ;
3824:                                 "Campo Obrigat" + CHR(243) + "rio")
3825:                             THIS.obj_4c_GetJustifs.SetFocus()
3826:                             loc_lResultado = .F.
3827:                         ENDIF
3828:                     ENDIF
3829:                 CATCH TO loc_oErro
3830:                     MsgErro(loc_oErro.Message, "Erro em ImpressaoValidarOcorrenciaObrigatoria")
3831:                     loc_lResultado = .F.
3832:                 ENDTRY
3833:             ENDIF
3834:         ENDIF
3835: 
3836:         RETURN loc_lResultado
3837:     ENDPROC
3838: 
3839:     *==========================================================================
3840:     * ImpressaoTextoLivre - ramo "texto livre" de Impressao() (dump
3841:     * 2001-2017): tipos 127/131/164/168 ignoram a grade inteira e imprimem
3842:     * UMA etiqueta com o texto digitado em GetTexto.
3843:     *==========================================================================
3844:     PROCEDURE ImpressaoTextoLivre(par_nTpEti, par_cTipo)
3845:         LOCAL loc_lTratado, loc_cTexto, loc_oErro
3846: 
3847:         loc_lTratado = .F.
3848: 
3849:         IF INLIST(par_nTpEti, 127, 131, 164, 168)
3850:             loc_lTratado = .T.
3851: 
3852:             THIS.GarantirCursorImpressao()
3853:             SELECT dbImpressao
3854:             ZAP
3855:             APPEND BLANK
3856:             REPLACE Cpros WITH "1", Qtds WITH 1
3857: 
3858:             loc_cTexto = THIS.obj_4c_GetTexto.Value
3859: 
3860:             IF par_cTipo = "I"
3861:                 TRY
3862:                     SigOpEtq(gnConnHandle, .F., .F., par_nTpEti, THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value, ;
3863:                         THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Value, ;
3864:                         THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Value, ;
3865:                         THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Value, "", "", "", ;
3866:                         THIS.ObterNomeImpressoraAtual(), .F., .F., THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Value, ;
3867:                         .F., .F., .F., .F., .F., .F., loc_cTexto)
3868:                 CATCH TO loc_oErro
3869:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel imprimir a etiqueta:" + CHR(13) + ;
3870:                         loc_oErro.Message, "Erro")
3871:                 ENDTRY
3872:             ENDIF
3873:         ENDIF
3874: 
3875:         RETURN loc_lTratado
3876:     ENDPROC
3877: 
3878:     *==========================================================================
3879:     * ImpressaoParcelas - ramo "quantidade de parcelas" de Impressao()
3880:     * (dump 2020-2063): tipo 136 imprime o texto livre com a quantidade de
3881:     * parcelas digitada em getQtParcs, a partir das linhas FLAGADAS da
3882:     * grade (igual ao ramo principal, mas sem os sub-casos de lnTpEti).
3883:     *==========================================================================
3884:     PROCEDURE ImpressaoParcelas(par_nTpEti, par_cTipo)
3885:         LOCAL loc_lTratado, loc_cTexto, loc_cCursor, loc_oProgresso, loc_oErro
3886: 
3887:         loc_lTratado = .F.
3888: 
3889:         IF INLIST(par_nTpEti, 136)
3890:             loc_lTratado = .T.
3891:             loc_cCursor  = THIS.this_cCursorEtiquetas
3892: 
3893:             TRY
3894:                 loc_cTexto = ALLTRIM(STR(IIF(!EMPTY(THIS.txt_4c_QtParcs.Value), THIS.txt_4c_QtParcs.Value, 1)))
3895: 
3896:                 THIS.GarantirCursorImpressao()
3897:                 SELECT dbImpressao
3898:                 ZAP
3899: 
3900:                 IF USED(loc_cCursor)
3901:                     SELECT (loc_cCursor)
3902:                     loc_oProgresso = CREATEOBJECT("fwprogressbar", "Processando Etiquetas...", RECCOUNT())
3903:                     loc_oProgresso.Show()
3904: 
3905:                     SCAN
3906:                         loc_oProgresso.Update(.T.)
3907: 
3908:                         IF EVALUATE(loc_cCursor + ".Flag")
3909:                             IF EVALUATE(loc_cCursor + ".Mantem")
3910:                                 SCATTER MEMVAR MEMO
3911:                                 SELECT dbImpressao
3912:                                 APPEND BLANK
3913:                                 GATHER MEMVAR MEMO
3914:                                 SELECT (loc_cCursor)
3915:                             ELSE
3916:                                 INSERT INTO dbImpressao (cpros, Qtds, QtdeEtiq, Pedido, Obs, Pvens, Moedas, Empos, cpros1, PrecoDe, Parcelas) ;
3917:                                     VALUES (STR(EVALUATE(loc_cCursor + ".CBars"), 14), 1, EVALUATE(loc_cCursor + ".Qtds"), ;
3918:                                             NVL(EVALUATE(loc_cCursor + ".CodAmss"), ""), NVL(EVALUATE(loc_cCursor + ".ObsEtiqs"), ""), ;
3919:                                             EVALUATE(loc_cCursor + ".Pvens"), EVALUATE(loc_cCursor + ".Moedas"), ;
3920:                                             EVALUATE(loc_cCursor + ".Empos"), EVALUATE(loc_cCursor + ".Cpros"), ;
3921:                                             EVALUATE(loc_cCursor + ".PrecoDe"), EVALUATE(loc_cCursor + ".Parcelas"))
3922:                             ENDIF
3923:                         ENDIF
3924:                     ENDSCAN
3925: 
3926:                     loc_oProgresso.Complete()
3927:                 ENDIF
3928: 
3929:                 THIS.MontaConjunto()
3930: 
3931:                 IF par_cTipo = "I"
3932:                     SigOpEtq(gnConnHandle, .F., .F., par_nTpEti, THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value, ;
3933:                         THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Value, ;
3934:                         THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Value, ;
3935:                         THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Value, "", "", "", ;
3936:                         THIS.ObterNomeImpressoraAtual(), .F., .F., THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Value, ;
3937:                         .F., .F., .F., .F., .F., .F., loc_cTexto)
3938:                 ENDIF
3939:             CATCH TO loc_oErro
3940:                 MsgErro(loc_oErro.Message + CHR(13) + ;
3941:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em ImpressaoParcelas")
3942:             ENDTRY

*-- Linhas 3952 a 4012:
3952:     * resolvem Pedido/empdopnums/Obs de forma diferente) e dispara UM
3953:     * ciclo de impressao/gravacao no final.
3954:     *==========================================================================
3955:     PROCEDURE ImprimirSemAgrupamento(par_nTpEti, par_cTipo, par_lImpPreco, par_nOptPreco, par_lImpPesoTotal)
3956:         LOCAL loc_cCursor, loc_oProgresso, loc_nQtd, loc_cEdn, loc_cConta, loc_lPreco, ;
3957:               loc_nBrr, loc_cBrr, loc_cSQL, loc_oErro
3958: 
3959:         loc_cCursor = THIS.this_cCursorEtiquetas
3960: 
3961:         TRY
3962:             THIS.GarantirCursorImpressao()
3963:             SELECT dbImpressao
3964:             ZAP
3965:             IF USED("crSigEtOcr")
3966:                 SELECT crSigEtOcr
3967:                 ZAP
3968:             ENDIF
3969: 
3970:             IF USED(loc_cCursor)
3971:                 SELECT (loc_cCursor)
3972:                 loc_oProgresso = CREATEOBJECT("fwprogressbar", "Processando Etiquetas...", RECCOUNT())
3973:                 loc_oProgresso.Show()
3974: 
3975:                 SCAN
3976:                     loc_oProgresso.Update(.T.)
3977: 
3978:                     IF EVALUATE(loc_cCursor + ".Flag")
3979:                         IF EVALUATE(loc_cCursor + ".Mantem")
3980:                             SCATTER MEMVAR MEMO
3981:                             m.Obs = IIF(par_nTpEti = 134, m.CodCors, m.Obs)
3982:                             SELECT dbImpressao
3983:                             APPEND BLANK
3984:                             GATHER MEMVAR MEMO
3985:                             SELECT (loc_cCursor)
3986:                         ELSE
3987:                             IF par_nTpEti = 12
3988:                                 SQLEXEC(gnConnHandle, "SELECT * FROM SigCdOpe WHERE Dopes = " + ;
3989:                                     EscaparSQL(EVALUATE(loc_cCursor + ".Dopes")), "LocalOpe")
3990: 
3991:                                 IF USED("LocalOpe") AND !EOF("LocalOpe")
3992:                                     INSERT INTO dbImpressao (Cpros, Qtds, Cbars, Obs, cpros1) ;
3993:                                         VALUES (EVALUATE(loc_cCursor + ".Cpros"), 1, ;
3994:                                             VAL(STR(LocalOpe.Ndopes, 4) + TRANSFORM(EVALUATE(loc_cCursor + ".Cbars"), "@L 9999999999")), ;
3995:                                             NVL(EVALUATE(loc_cCursor + ".ObsEtiqs"), ""), EVALUATE(loc_cCursor + ".Cpros"))
3996:                                 ENDIF
3997:                             ELSE
3998:                                 loc_nQtd = EVALUATE(loc_cCursor + ".Qtds")
3999: 
4000:                                 IF EMPTY(EVALUATE(loc_cCursor + ".Nops"))
4001:                                     INSERT INTO dbImpressao (Cpros, Qtds, QtdeEtiq, Pedido, Obs, Pvens, Moedas, Empos, cpros1, CodTams, PrecoDe, Parcelas) ;
4002:                                         VALUES (STR(EVALUATE(loc_cCursor + ".CBars"), 14), 1, loc_nQtd, ;
4003:                                             NVL(EVALUATE(loc_cCursor + ".CodAmss"), ""), ;
4004:                                             IIF(par_nTpEti = 134, EVALUATE(loc_cCursor + ".CodCors"), NVL(EVALUATE(loc_cCursor + ".ObsEtiqs"), "")), ;
4005:                                             EVALUATE(loc_cCursor + ".Pvens"), EVALUATE(loc_cCursor + ".Moedas"), ;
4006:                                             EVALUATE(loc_cCursor + ".Empos"), EVALUATE(loc_cCursor + ".Cpros"), ;
4007:                                             EVALUATE(loc_cCursor + ".CodTams"), EVALUATE(loc_cCursor + ".PrecoDe"), ;
4008:                                             IIF(par_nOptPreco = 6 AND EMPTY(EVALUATE(loc_cCursor + ".Parcelas")), 1, EVALUATE(loc_cCursor + ".Parcelas")))
4009: 
4010:                                     IF INLIST(par_nTpEti, 39)
4011:                                         loc_cEdn = EVALUATE(loc_cCursor + ".Empos") + EVALUATE(loc_cCursor + ".Dopeos") + ;
4012:                                             STR(EVALUATE(loc_cCursor + ".Numeos"), 6)

*-- Linhas 4128 a 4203:
4128: 
4129:                 THIS.RegistrarOcorrenciaEtiquetas()
4130:             ELSE
4131:                 MsgAviso("Nenhuma Etiqueta Selecionada!!!", "")
4132:             ENDIF
4133:         CATCH TO loc_oErro
4134:             MsgErro(loc_oErro.Message + CHR(13) + ;
4135:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4136:                 "Procedure: " + loc_oErro.Procedure, "Erro em ImprimirSemAgrupamento")
4137:         ENDTRY
4138:     ENDPROC
4139: 
4140:     *==========================================================================
4141:     * ImprimirAgrupadoPorContaOs - ramo "agrupado" de Impressao() (dump
4142:     * 2239-2371): usada quando o tipo de etiqueta precisa de separador por
4143:     * conta (LocalParaC.EtqSeps = 1) - agrupa a grade por Empos+Grupos+
4144:     * Contas (ou trata tudo como UM grupo so, se this_nOrdemImp = 3) e
4145:     * dispara um ciclo de impressao/gravacao POR GRUPO.
4146:     *==========================================================================
4147:     PROCEDURE ImprimirAgrupadoPorContaOs(par_nTpEti, par_cTipo, par_lImpPreco, par_lImpPesoTotal)
4148:         LOCAL loc_cCursor, loc_cEmp, loc_cGrp, loc_cCta, loc_cRps, loc_oProgresso, ;
4149:               loc_nQtd, loc_cEdn, loc_cConta, loc_nBrr, loc_cBrr, loc_cSQL, loc_oErro
4150: 
4151:         loc_cCursor = THIS.this_cCursorEtiquetas
4152: 
4153:         TRY
4154:             IF USED(loc_cCursor)
4155:                 SELECT (loc_cCursor)
4156: 
4157:                 IF THIS.this_nOrdemImp != 3
4158:                     SET ORDER TO TAG EmpGruCon
4159:                 ENDIF
4160: 
4161:                 GO TOP
4162: 
4163:                 loc_oProgresso = CREATEOBJECT("fwprogressbar", "Processando Dados do Cursor...", RECCOUNT())
4164:                 loc_oProgresso.Show()
4165: 
4166:                 DO WHILE !EOF(loc_cCursor)
4167:                     loc_cEmp = EVALUATE(loc_cCursor + ".Empos")
4168:                     loc_cGrp = EVALUATE(loc_cCursor + ".Grupos")
4169:                     loc_cCta = EVALUATE(loc_cCursor + ".Contas")
4170:                     loc_cRps = IIF(THIS.this_lGravaPro, "Reposicao", " ")
4171: 
4172:                     THIS.GarantirCursorImpressao()
4173:                     SELECT dbImpressao
4174:                     ZAP
4175:                     IF USED("crSigEtOcr")
4176:                         SELECT crSigEtOcr
4177:                         ZAP
4178:                     ENDIF
4179: 
4180:                     SELECT (loc_cCursor)
4181: 
4182:                     DO WHILE !EOF(loc_cCursor)
4183:                         IF THIS.this_nOrdemImp != 3
4184:                             IF EVALUATE(loc_cCursor + ".Empos") + EVALUATE(loc_cCursor + ".Grupos") + ;
4185:                                     EVALUATE(loc_cCursor + ".Contas") != loc_cEmp + loc_cGrp + loc_cCta
4186:                                 EXIT
4187:                             ENDIF
4188:                         ENDIF
4189: 
4190:                         loc_oProgresso.Update(.T.)
4191: 
4192:                         IF EVALUATE(loc_cCursor + ".Flag")
4193:                             IF EVALUATE(loc_cCursor + ".Mantem")
4194:                                 SCATTER MEMVAR MEMO
4195:                                 SELECT dbImpressao
4196:                                 APPEND BLANK
4197:                                 GATHER MEMVAR MEMO
4198:                                 SELECT (loc_cCursor)
4199:                             ELSE
4200:                                 loc_nQtd = EVALUATE(loc_cCursor + ".Qtds")
4201: 
4202:                                 IF EMPTY(EVALUATE(loc_cCursor + ".Nops"))
4203:                                     INSERT INTO dbImpressao (Cpros, Qtds, QtdeEtiq, Obs) ;

*-- Linhas 4302 a 4371:
4302:         CATCH TO loc_oErro
4303:             MsgErro(loc_oErro.Message + CHR(13) + ;
4304:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4305:                 "Procedure: " + loc_oErro.Procedure, "Erro em ImprimirAgrupadoPorContaOs")
4306:         ENDTRY
4307:     ENDPROC
4308: 
4309:     *==========================================================================
4310:     * GerarOperacaoEtiquetas - bloco final de Impressao() (dump 2381-2450):
4311:     * quando a impressao eh imediata e o chamador configurou uma operacao
4312:     * de destino (LocalParac.DopEtiqs), gera o movimento correspondente em
4313:     * SigMvCab/SigMvItn/SigMvIts a partir das linhas selecionadas.
4314:     *
4315:     * Depende de LocalParac (parametros carregados no Init por
4316:     * CarregarParametrosSistema, Fase 8). Sem ele (ex. falha de conexao)
4317:     * este bloco nao se aplica - mesmo efeito do
4318:     * "Not Empty(LocalParac.DopEtiqs)" do legado quando o parametro esta
4319:     * vazio.
4320:     *
4321:     * SigMvCab e SigMvItn tem mais de 100 colunas NOT NULL cada (conferido
4322:     * em docs\schema.sql); o legado grava via cursor BUFFERIZADO inteiro
4323:     * (AddCursor + TableUpdate), que preenche as colunas nao citadas com o
4324:     * branco do registro em branco do cursor. Um INSERT parcial aqui
4325:     * quebraria o NOT NULL em runtime (regra CLAUDE.md #22 - mesma classe
4326:     * dos Erro151/Erro159) - por isso SigMvCab/SigMvItn NAO sao gravados
4327:     * por este metodo ainda; SigMvIts (o item com o codigo de barras) TEM
4328:     * BO proprio e completo (SigOpIpEBO, Fases 1-2, INSERT com as 30
4329:     * colunas da tabela) e esse SIM eh gravado aqui.
4330:     *==========================================================================
4331:     PROCEDURE GerarOperacaoEtiquetas(par_nTpEti)
4332:         LOCAL loc_lConfirmou, loc_cDopes, loc_cChave, loc_nItem, loc_nNumes, loc_cEmps, ;
4333:               loc_oBO, loc_oErro
4334: 
4335:         IF USED("LocalParac") AND !EMPTY(NVL(LocalParac.DopEtiqs, "")) AND par_nTpEti != 12
4336:             loc_cDopes = ALLTRIM(LocalParac.DopEtiqs)
4337: 
4338:             loc_lConfirmou = MsgConfirma("Confirma Gera" + CHR(231) + CHR(227) + "o da Opera" + CHR(231) + CHR(227) + ;
4339:                 "o " + loc_cDopes + "!!!", "")
4340: 
4341:             IF loc_lConfirmou
4342:                 TRY
4343:                     IF USED("CsSelecao")
4344:                         USE IN CsSelecao
4345:                     ENDIF
4346:                     SELECT Empos, Grupos, Contas, Cpros, Cbars, CodCors, CodTams, Qtds, Pesos ;
4347:                         FROM (THIS.this_cCursorEtiquetas) WHERE Empos != "  " ;
4348:                         INTO CURSOR CsSelecao ORDER BY 1, 2, 3
4349: 
4350:                     loc_cChave = SPACE(23)
4351:                     loc_nItem  = 1
4352: 
4353:                     MsgErro("A gera" + CHR(231) + CHR(227) + "o autom" + CHR(225) + "tica da opera" + CHR(231) + ;
4354:                         CHR(227) + "o " + loc_cDopes + " tamb" + CHR(233) + "m grava em SigMvCab e SigMvItn, que " + ;
4355:                         "ainda n" + CHR(227) + "o t" + CHR(234) + "m cobertura completa de colunas NOT NULL nesta " + ;
4356:                         "migra" + CHR(231) + CHR(227) + "o. O item em SigMvIts ser" + CHR(225) + " gravado; " + ;
4357:                         "registre o cabe" + CHR(231) + "alho/itens do movimento manualmente.", ;
4358:                         "Grava" + CHR(231) + CHR(227) + "o parcial")
4359: 
4360:                     loc_oBO = THIS.this_oBusinessObject
4361: 
4362:                     SELECT CsSelecao
4363:                     SCAN
4364:                         loc_cEmps = CsSelecao.Empos
4365: 
4366:                         IF Empos + Grupos + Contas != loc_cChave
4367:                             loc_nNumes = fGerUniqueKey(ALLTRIM(loc_cDopes) + loc_cEmps)
4368:                             loc_nItem  = 1
4369:                             loc_cChave = CsSelecao.Empos + CsSelecao.Grupos + CsSelecao.Contas
4370:                         ENDIF
4371: 

*-- Linhas 4400 a 4453:
4400:     ENDPROC
4401: 
4402:     *==========================================================================
4403:     * Impressao - orquestrador principal (dump 1929-2454, "PROCEDURE
4404:     * impressao Lparameters pTipo"). par_cTipo: "I" = Impressao Imediata,
4405:     * "A" = Impressao Posterior (Armazenar).
4406:     *
4407:     * Ordem de controle TRANSCRITA do legado: texto-livre e parcelas tem
4408:     * "Return" PROPRIO (pulam tagmod1, o bloco agrupar/nao-agrupar, o
4409:     * Release de 'A' E a geracao de operacao); TagModelo1 eh uma FUNCAO
4410:     * separada - "If Not tagmod1(...)" so pula o bloco agrupar/nao-
4411:     * agrupar, o restante do metodo roda do mesmo jeito.
4412:     *==========================================================================
4413:     PROCEDURE Impressao(par_cTipo)
4414:         LOCAL loc_nTpEti, loc_lImpPreco, loc_nOptPreco, loc_lImpPesoTotal, ;
4415:               loc_lAgrupar, loc_lJaTratado, loc_oErro
4416: 
4417:         IF THIS.ImpressaoValidarOcorrenciaObrigatoria()
4418:             loc_lImpPreco     = (THIS.obj_4c_Opt_Preco.Value != 2)
4419:             loc_nOptPreco     = THIS.obj_4c_Opt_Preco.Value
4420:             loc_nTpEti        = INT(VAL(THIS.obj_4c_Opt_Tipo.Buttons(THIS.obj_4c_Opt_Tipo.Value).Tag))
4421:             loc_lImpPesoTotal = (THIS.obj_4c_Opt_peso.Value = 1)
4422: 
4423:             loc_lJaTratado = THIS.ImpressaoTextoLivre(loc_nTpEti, par_cTipo)
4424: 
4425:             IF !loc_lJaTratado
4426:                 loc_lJaTratado = THIS.ImpressaoParcelas(loc_nTpEti, par_cTipo)
4427:             ENDIF
4428: 
4429:             IF !loc_lJaTratado
4430:                 IF !THIS.TagModelo1(loc_nTpEti, loc_lImpPreco, par_cTipo)
4431:                     TRY
4432:                         loc_lAgrupar = !(INLIST(loc_nTpEti, 10, 13) OR ;
4433:                             (INLIST(loc_nTpEti, 1, 55, 56, 57, 66, 67, 68) AND ;
4434:                              USED("LocalParaC") AND NVL(LocalParaC.EtqSeps, 0) = 1))
4435:                     CATCH TO loc_oErro
4436:                         loc_lAgrupar = .T.
4437:                     ENDTRY
4438: 
4439:                     IF loc_lAgrupar
4440:                         THIS.ImprimirSemAgrupamento(loc_nTpEti, par_cTipo, loc_lImpPreco, loc_nOptPreco, loc_lImpPesoTotal)
4441:                     ELSE
4442:                         THIS.ImprimirAgrupadoPorContaOs(loc_nTpEti, par_cTipo, loc_lImpPreco, loc_lImpPesoTotal)
4443:                     ENDIF
4444:                 ENDIF
4445: 
4446:                 IF par_cTipo = "A"
4447:                     IF VARTYPE(THIS.this_oFormAnterior) = "O"
4448:                         IF PEMSTATUS(THIS.this_oFormAnterior, "Enabled", 5)
4449:                             THIS.this_oFormAnterior.Enabled = .T.
4450:                         ENDIF
4451:                     ENDIF
4452:                     THIS.Release()
4453:                 ELSE

*-- Linhas 4468 a 4570:
4468:     * de etiqueta dinamicos, carga das linhas da grade por
4469:     * ParentForm.Tipo, impressoras e os ajustes finais.
4470:     *
4471:     * Chamado por InicializarForm, logo depois de ConfigurarEventosPrin-
4472:     * cipais (ver cabecalho do arquivo, secao da Fase 8).
4473:     *
4474:     * TRY/CATCH PROPRIO que NUNCA propaga: o legado so aborta o Init com
4475:     * "Return 0" em falha de CONEXAO (".poDataGrv.pnIdconn <= 0", nao
4476:     * implementada nesta fase - ver nota abaixo); SigCdTpe/SigCdmp vazios
4477:     * sao caminho legitimo (grade abre, so sem tipo/impressora
4478:     * disponivel). Travar a abertura da tela aqui seria regressao frente
4479:     * ao legado.
4480:     *
4481:     * poDataGrv/fSqlConector (dump 2621-2630, AddCursor de SigEtOcr/
4482:     * SigMvCab/SigMvItn/SigMvIts) NAO entra: eh um wrapper de acesso a
4483:     * dados que o resto do projeto substitui por SQLEXEC direto, e os
4484:     * quatro cursores que ele abriria (crSigEtOcr/crSigMvCab/crSigMvItn/
4485:     * crSigMvIts) ja sao lidos com guarda USED() pelas Fases 5-7 (ex.
4486:     * GarantirCursorImpressao) assumindo que podem nao existir -
4487:     * implementa-lo seria trazer uma camada de acesso a dados inteira
4488:     * para uma fase que so precisa de quatro cursores especificos
4489:     * (LocalParam/LocalParaC/LocalTpEti/crImpreV, ja fixados como
4490:     * contrato pelas Fases 5-7).
4491:     *==========================================================================
4492:     PROTECTED PROCEDURE CarregarContextoInicial()
4493:         LOCAL loc_oErro
4494: 
4495:         TRY
4496:             *-- Legado: "Thisform.grd_Historico.Column2.Header1.Tag = []"
4497:             THIS.grd_4c_Dados.Column2.Header1.Tag = ""
4498: 
4499:             *-- Legado: If (Type([ThisForm.ParentForm.Chk_Preco])=[O]) /
4500:             *-- opt_Preco.Value = ParentForm.Chk_Preco.Value
4501:             IF VARTYPE(THIS.this_oFormAnterior) = "O"
4502:                 IF PEMSTATUS(THIS.this_oFormAnterior, "Chk_Preco", 5)
4503:                     IF VARTYPE(THIS.this_oFormAnterior.Chk_Preco) = "O"
4504:                         IF PEMSTATUS(THIS.this_oFormAnterior.Chk_Preco, "Value", 5)
4505:                             THIS.obj_4c_Opt_Preco.Value = THIS.this_oFormAnterior.Chk_Preco.Value
4506:                         ENDIF
4507:                     ENDIF
4508:                 ENDIF
4509:             ENDIF
4510: 
4511:             *-- Legado: If Type('pnordem')=[U] / Ordemimp=1 / Else / =PnOrdem
4512:             IF TYPE("pnordem") != "U"
4513:                 THIS.this_nOrdemImp = pnordem
4514:             ENDIF
4515: 
4516:             THIS.CarregarParametrosSistema()
4517:             THIS.AtualizarVisibilidadeOcorrencia()
4518:             THIS.CarregarTiposEtiquetaDinamico()
4519:             THIS.CarregarLinhasPorTipoChamador()
4520:             THIS.CarregarImpressorasEtiqueta()
4521:             THIS.AplicarDefaultsImpressora()
4522:             THIS.AjustarBotaoImprimirPorContexto()
4523:             THIS.AjustarReadOnlyQtdsPorLibObss()
4524:             THIS.ConfigurarModoDigitacao()
4525:             THIS.GetPrinterInteractiveChange()
4526:         CATCH TO loc_oErro
4527:             THIS.this_cMensagemErro = loc_oErro.Message
4528:             MsgErro(loc_oErro.Message + CHR(13) + ;
4529:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4530:                 "Procedure: " + loc_oErro.Procedure, ;
4531:                 "Erro em CarregarContextoInicial")
4532:         ENDTRY
4533:     ENDPROC
4534: 
4535:     *==========================================================================
4536:     * CarregarParametrosSistema - LocalParam/LocalParaC (SigCdPam/SigCdPaC),
4537:     * tabelas de UMA linha so - mesma leitura "SELECT sem WHERE" que o
4538:     * irmao sigopetsBO documenta para CrSigCdPam/CrSigCdPac.
4539:     *
4540:     * Legado (Init:2632-2634):
4541:     *   lcCpo = 'OcoEtiqs, Ouros, nMaxTpEtis, TpEtiPads, nMaxImpEti, ImpEtis,
4542:     *            AjVerts, AjHorzs, LibObss, TpInstalas'
4543:     *   CursorQuery('SigCdPam', 'LocalParam', .F., .F., lcCpo)
4544:     *   CursorQuery('SigCdPaC', 'LocalParaC', .F., .F., 'AjDens, AjVelos,
4545:     *            EtqSeps, DopEtiqs, QtdMarPar, VlrMinPar')
4546:     *
4547:     * SQLEXEC com SELECT explicito (nunca SELECT *) - colunas conferidas
4548:     * em docs\schema.sql (UTF-16, Get-Content -Raw).
4549:     *==========================================================================
4550:     PROTECTED FUNCTION CarregarParametrosSistema()
4551:         LOCAL loc_lSucesso, loc_nResultado, loc_oErro
4552: 
4553:         loc_lSucesso = .F.
4554: 
4555:         TRY
4556:             IF USED("LocalParam")
4557:                 USE IN LocalParam
4558:             ENDIF
4559: 
4560:             loc_nResultado = SQLEXEC(gnConnHandle, ;
4561:                 "SELECT OcoEtiqs, Ouros, nMaxTpEtis, TpEtiPads, nMaxImpEti, " + ;
4562:                 "ImpEtis, AjVerts, AjHorzs, LibObss, TpInstalas FROM SigCdPam", ;
4563:                 "LocalParam")
4564: 
4565:             IF loc_nResultado >= 1 AND USED("LocalParam")
4566:                 IF USED("LocalParaC")
4567:                     USE IN LocalParaC
4568:                 ENDIF
4569: 
4570:                 loc_nResultado = SQLEXEC(gnConnHandle, ;

*-- Linhas 4601 a 4682:
4601:     * ParentForm.pcEscolha (guarda dupla - o chamador eh arbitrario,
4602:     * mesmo criterio de ObterTipoChamador).
4603:     *==========================================================================
4604:     PROTECTED PROCEDURE AtualizarVisibilidadeOcorrencia()
4605:         LOCAL loc_cEscolha, loc_lTemEscolha
4606: 
4607:         loc_lTemEscolha = .F.
4608:         loc_cEscolha    = ""
4609: 
4610:         IF VARTYPE(THIS.this_oFormAnterior) = "O"
4611:             IF PEMSTATUS(THIS.this_oFormAnterior, "pcEscolha", 5)
4612:                 IF VARTYPE(THIS.this_oFormAnterior.pcEscolha) = "C"
4613:                     loc_lTemEscolha = .T.
4614:                     loc_cEscolha    = THIS.this_oFormAnterior.pcEscolha
4615:                 ENDIF
4616:             ENDIF
4617:         ENDIF
4618: 
4619:         IF loc_lTemEscolha AND loc_cEscolha != "INSERIR" AND ;
4620:                 USED("LocalParam") AND LocalParam.OcoEtiqs = 1
4621:             THIS.this_lGravaOcorrencia      = .T.
4622:             THIS.txt_4c_OcoEtiqs.Visible    = .T.
4623:             THIS.txt_4c_DOcoEtiqs.Visible   = .T.
4624:             THIS.lbl_4c_LblOcoEtiqs.Visible = .T.
4625:             THIS.shp_4c_ShpOcoEtiqs.Visible = .T.
4626:             THIS.obj_4c_GetJustifs.Visible  = .T.
4627:             THIS.lbl_4c_LblJustifs.Visible  = .T.
4628:             THIS.shp_4c_ShpJustifs.Visible  = .T.
4629:         ENDIF
4630:     ENDPROC
4631: 
4632:     *==========================================================================
4633:     * CarregarTiposEtiquetaDinamico - popula LocalTpEti (SigCdTpe) e os
4634:     * Buttons de obj_4c_Opt_Tipo em runtime - substitui o unico botao
4635:     * TRANSCRITO na Fase 5 ("\<a. Rabicho", so a geometria base do SCX).
4636:     *
4637:     * Legado (Init:3098-3152): CursorQuery('SigCdTpe','LocalTpEti') /
4638:     * Index On cOrdems+cEtiquetas Tag skOrdems For nSituas=1 / Count To
4639:     * lnTipos For nSituas=1 / monta ButtonCount = Min(lnTipos,
4640:     * Max(LocalParam.nMaxTpEtis,5)) botoes com Caption/ForeColor/Tag/Top,
4641:     * casa o indice padrao com LocalParam.TpEtiPads e chama
4642:     * .InteractiveChange() no fim.
4643:     *
4644:     * O ORDER BY substitui o INDEX ON...FOR (mesmo padrao do irmao
4645:     * sigopetsBO.CarregarTiposEtiqueta) - o cursor ja chega filtrado e
4646:     * ordenado, sem precisar de indice local.
4647:     *
4648:     * Ramo "zero tipos": MANTEM o unico botao que a Fase 5 ja criou (nao
4649:     * sobrescreve - decisao desta fase, ver cabecalho do arquivo). So
4650:     * importa no caso-limite de SigCdTpe sem nenhuma linha nSituas=1, que
4651:     * nao acontece em producao.
4652:     *==========================================================================
4653:     PROTECTED FUNCTION CarregarTiposEtiquetaDinamico()
4654:         LOCAL loc_lSucesso, loc_nResultado, loc_oGrupo, loc_nTotalTipos, ;
4655:               loc_nMaxBotoes, loc_nIndicePadrao, loc_nI, loc_nTop, ;
4656:               loc_oBotao, loc_oErro
4657: 
4658:         loc_lSucesso = .F.
4659:         loc_oGrupo   = THIS.obj_4c_Opt_Tipo
4660: 
4661:         TRY
4662:             IF USED("LocalTpEti")
4663:                 USE IN LocalTpEti
4664:             ENDIF
4665: 
4666:             loc_nResultado = SQLEXEC(gnConnHandle, ;
4667:                 "SELECT * FROM SigCdTpe WHERE nSituas = 1 ORDER BY cOrdems, cEtiquetas", ;
4668:                 "LocalTpEti")
4669: 
4670:             loc_nTotalTipos = IIF(loc_nResultado >= 1 AND USED("LocalTpEti"), ;
4671:                 RECCOUNT("LocalTpEti"), 0)
4672:             THIS.this_nTotalTiposEtiqueta = loc_nTotalTipos
4673: 
4674:             IF loc_nTotalTipos != 0 AND USED("LocalParam")
4675:                 loc_nMaxBotoes = MIN(loc_nTotalTipos, MAX(LocalParam.nMaxTpEtis, 5))
4676:                 loc_oGrupo.ButtonCount = loc_nMaxBotoes
4677: 
4678:                 loc_nIndicePadrao = 1
4679:                 loc_nTop          = 10
4680: 
4681:                 SELECT LocalTpEti
4682:                 GO TOP

*-- Linhas 4705 a 4854:
4705:                 loc_oGrupo.Value   = loc_nIndicePadrao
4706:             ENDIF
4707: 
4708:             THIS.OptTipoInteractiveChange()
4709: 
4710:             loc_lSucesso = .T.
4711:         CATCH TO loc_oErro
4712:             loc_lSucesso = .F.
4713:             THIS.this_cMensagemErro = loc_oErro.Message
4714:             MsgErro(loc_oErro.Message + CHR(13) + ;
4715:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em CarregarTiposEtiquetaDinamico")
4716:         ENDTRY
4717: 
4718:         RETURN loc_lSucesso
4719:     ENDFUNC
4720: 
4721:     *==========================================================================
4722:     * CarregarLinhasPorTipoChamador - dispatcher dos SEIS ramos de carga
4723:     * de linha por ParentForm.Tipo (DIGITACAO fica fora - ver
4724:     * ConfigurarModoDigitacao, chamado separadamente no funil da Fase 8).
4725:     *
4726:     * Legado: "Zap In DbEtiqueta" (2713) roda SEMPRE antes do primeiro
4727:     * ramo de Tipo - reproduzido aqui porque CarregarContextoInicial pode
4728:     * rodar mais de uma vez na vida do form (nao deveria neste form sem
4729:     * pagina de dados real, mas evita cursor acumulando linha duplicada
4730:     * se algum caminho futuro chamar de novo).
4731:     *
4732:     * PUBLIC de proposito, como MontaGradeEtiquetas: funil publicamente
4733:     * chamavel (regras CLAUDE.md #3/#51).
4734:     *==========================================================================
4735:     PROCEDURE CarregarLinhasPorTipoChamador()
4736:         LOCAL loc_cTipo
4737: 
4738:         IF USED(THIS.this_cCursorEtiquetas)
4739:             ZAP IN (THIS.this_cCursorEtiquetas)
4740:         ENDIF
4741: 
4742:         loc_cTipo = THIS.ObterTipoChamador()
4743: 
4744:         DO CASE
4745:         CASE loc_cTipo == "UNITARIO"
4746:             THIS.CarregarLinhasUnitario()
4747:         CASE loc_cTipo == "OPERACAO"
4748:             THIS.CarregarLinhasOperacao()
4749:         CASE loc_cTipo == "DIVERSAS"
4750:             THIS.CarregarLinhasDiversas()
4751:         CASE loc_cTipo == "ARQUIVADAS"
4752:             THIS.CarregarLinhasArquivadas()
4753:         CASE loc_cTipo == "CADASTRO"
4754:             THIS.CarregarLinhasCadastro()
4755:         CASE loc_cTipo == "CONSULTA"
4756:             THIS.CarregarLinhasConsulta()
4757:         ENDCASE
4758:     ENDPROC
4759: 
4760:     *==========================================================================
4761:     * CarregarLinhasUnitario - Tipo='UNITARIO' (dump 2715-2728): uma unica
4762:     * etiqueta, barcode em ParentForm.Produto (NUMERICO aqui - o mesmo
4763:     * nome de property eh STRING no ramo CADASTRO, ver
4764:     * CarregarLinhasCadastro).
4765:     *==========================================================================
4766:     PROTECTED PROCEDURE CarregarLinhasUnitario()
4767:         LOCAL loc_nBarra, loc_cCursor, loc_nResultado, loc_oErro
4768: 
4769:         loc_cCursor = THIS.this_cCursorEtiquetas
4770:         loc_nBarra  = 0
4771: 
4772:         IF VARTYPE(THIS.this_oFormAnterior) = "O"
4773:             IF PEMSTATUS(THIS.this_oFormAnterior, "Produto", 5)
4774:                 IF VARTYPE(THIS.this_oFormAnterior.Produto) = "N"
4775:                     loc_nBarra = THIS.this_oFormAnterior.Produto
4776:                 ENDIF
4777:             ENDIF
4778:         ENDIF
4779: 
4780:         TRY
4781:             IF USED("LocalEti")
4782:                 USE IN LocalEti
4783:             ENDIF
4784: 
4785:             loc_nResultado = SQLEXEC(gnConnHandle, ;
4786:                 "SELECT * FROM SigOpEtq WHERE CBars = " + TRANSFORM(loc_nBarra), "LocalEti")
4787: 
4788:             IF loc_nResultado >= 1 AND USED("LocalEti") AND !EOF("LocalEti") AND USED(loc_cCursor)
4789:                 SELECT LocalEti
4790:                 SCATTER MEMVAR
4791:                 m.Flag = .T.
4792:                 INSERT INTO (loc_cCursor) FROM MEMVAR
4793:             ENDIF
4794:         CATCH TO loc_oErro
4795:             THIS.this_cMensagemErro = loc_oErro.Message
4796:             MsgErro(loc_oErro.Message + CHR(13) + ;
4797:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em CarregarLinhasUnitario")
4798:         ENDTRY
4799:     ENDPROC
4800: 
4801:     *==========================================================================
4802:     * CarregarLinhasOperacao - Tipo='OPERACAO' (dump 2730-2775): as
4803:     * etiquetas vem do cursor dbImpressao que o form PAI (SigMvCab) ja
4804:     * deixou aberto (contrato entre forms - nao se recria aqui, so se le
4805:     * com guarda USED()).
4806:     *
4807:     * Column6(name)/migrado Column9 (pVens/Preco) vira editavel aqui -
4808:     * ver tabela de renomeacao de Column em ConfigurarGrade: a NAME
4809:     * "Column6" do legado eh a coluna criada na POSICAO 9 deste form
4810:     * (pVens), NAO a Quantidade (essa eh a NAME "Column7" = posicao 6,
4811:     * migrada Column6 - ReadOnly dela eh LibObss, ver AjustarReadOnly-
4812:     * QtdsPorLibObss).
4813:     *==========================================================================
4814:     PROTECTED PROCEDURE CarregarLinhasOperacao()
4815:         LOCAL loc_cCursor, loc_nBarra, loc_nResultado, loc_lDistribui, loc_oErro
4816: 
4817:         loc_cCursor = THIS.this_cCursorEtiquetas
4818: 
4819:         THIS.grd_4c_Dados.Column9.ReadOnly = .F.
4820: 
4821:         TRY
4822:             IF USED("dbImpressao")
4823:                 SELECT dbImpressao
4824:                 SCAN
4825:                     loc_nBarra = INT(VAL(dbImpressao.Cpros))
4826: 
4827:                     IF USED("LocalEti")
4828:                         USE IN LocalEti
4829:                     ENDIF
4830:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
4831:                         "SELECT * FROM SigOpEtq WHERE CBars = " + TRANSFORM(loc_nBarra), "LocalEti")
4832: 
4833:                     IF loc_nResultado >= 1 AND USED("LocalEti")
4834:                         SELECT LocalEti
4835:                         SCATTER MEMVAR
4836:                         m.Flag = .T.
4837:                         m.Qtds = dbImpressao.Qtds
4838: 
4839:                         IF USED("LocalPro")
4840:                             USE IN LocalPro
4841:                         ENDIF
4842:                         SQLEXEC(gnConnHandle, "SELECT CUniPs, cGrus, Categoria FROM SigCdPro " + ;
4843:                             "WHERE CPros = " + EscaparSQL(LocalEti.Cpros), "LocalPro")
4844: 
4845:                         loc_lDistribui = .F.
4846:                         IF USED("LocalPro") AND !EOF("LocalPro")
4847:                             IF USED("LocalUni")
4848:                                 USE IN LocalUni
4849:                             ENDIF
4850:                             SQLEXEC(gnConnHandle, "SELECT Distribs FROM SigCdUni WHERE CUnis = " + ;
4851:                                 EscaparSQL(LocalPro.CUniPs), "LocalUni")
4852: 
4853:                             IF USED("LocalUni") AND !EOF("LocalUni") AND LocalUni.Distribs = 1
4854:                                 loc_lDistribui = .T.

*-- Linhas 4897 a 4982:
4897:     * CarregarLinhasDiversas - Tipo='DIVERSAS' (dump 2777-2793): varias
4898:     * etiquetas passadas no cursor csRelatorio (contrato do form pai).
4899:     *==========================================================================
4900:     PROTECTED PROCEDURE CarregarLinhasDiversas()
4901:         LOCAL loc_cCursor, loc_nBarra, loc_nResultado, loc_oErro
4902: 
4903:         loc_cCursor = THIS.this_cCursorEtiquetas
4904: 
4905:         TRY
4906:             IF USED("csRelatorio")
4907:                 SELECT csRelatorio
4908:                 SCAN
4909:                     loc_nBarra = csRelatorio.CBars
4910: 
4911:                     IF USED("LocalEti")
4912:                         USE IN LocalEti
4913:                     ENDIF
4914:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
4915:                         "SELECT * FROM SigOpEtq WHERE CBars = " + TRANSFORM(loc_nBarra), "LocalEti")
4916: 
4917:                     IF loc_nResultado >= 1 AND USED("LocalEti") AND !EOF("LocalEti") AND USED(loc_cCursor)
4918:                         SELECT LocalEti
4919:                         SCATTER MEMVAR
4920:                         m.Flag = .T.
4921:                         INSERT INTO (loc_cCursor) FROM MEMVAR
4922:                     ENDIF
4923: 
4924:                     SELECT csRelatorio
4925:                 ENDSCAN
4926:             ENDIF
4927:         CATCH TO loc_oErro
4928:             THIS.this_cMensagemErro = loc_oErro.Message
4929:             MsgErro(loc_oErro.Message + CHR(13) + ;
4930:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em CarregarLinhasDiversas")
4931:         ENDTRY
4932:     ENDPROC
4933: 
4934:     *==========================================================================
4935:     * CarregarLinhasArquivadas - Tipo='ARQUIVADAS' (dump 2795-2846):
4936:     * chamado do SigPrRet (reimpressao individual) - todas as etiquetas
4937:     * dos produtos marcados com ImpEtiqs=1, uma por EmpOs+Grupos+Contas+
4938:     * CPros+CBars+pesos+qtds+datas, mantendo so as que o ULTIMO usuario a
4939:     * alterar o preco (SigCdPrc) foi o usuario logado (ou nenhum
4940:     * historico ainda).
4941:     *==========================================================================
4942:     PROTECTED PROCEDURE CarregarLinhasArquivadas()
4943:         LOCAL loc_cCursor, loc_cQuery, loc_nResultado, loc_oErro
4944: 
4945:         loc_cCursor = THIS.this_cCursorEtiquetas
4946: 
4947:         THIS.grd_4c_Dados.Column4.ReadOnly = .T.
4948: 
4949:         TRY
4950:             loc_cQuery = "SELECT c.EmpOs, c.Grupos, c.Contas, a.CPros, c.CBars, " + ;
4951:                 "c.pesos, c.qtds, c.datas, a.pvens, a.precode, a.cGrus, a.Categoria " + ;
4952:                 "FROM SigCdPro a, SigOpEtq c " + ;
4953:                 "WHERE a.ImpEtiqs = 1 AND a.CPros = c.CPros " + ;
4954:                 "AND NOT c.Grupos = '" + SPACE(10) + "' " + ;
4955:                 "AND NOT c.Contas = '" + SPACE(10) + "' " + ;
4956:                 "GROUP BY c.EmpOs, c.Grupos, c.Contas, a.CPros, c.CBars, c.pesos, c.qtds, c.datas"
4957: 
4958:             IF USED("TmpTmp1")
4959:                 USE IN TmpTmp1
4960:             ENDIF
4961:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cQuery, "TmpTmp1")
4962: 
4963:             IF loc_nResultado < 1
4964:                 MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TmpTmp1)")
4965:             ELSE
4966:                 SELECT TmpTmp1
4967:                 SCAN
4968:                     loc_cQuery = "SELECT TOP 1 UsuaAlts FROM SigCdPrc WHERE CPros = " + ;
4969:                         EscaparSQL(TmpTmp1.Cpros) + " ORDER BY DataAlts DESC, HoraAlts DESC"
4970: 
4971:                     IF USED("TmpUltimo")
4972:                         USE IN TmpUltimo
4973:                     ENDIF
4974:                     SQLEXEC(gnConnHandle, loc_cQuery, "TmpUltimo")
4975: 
4976:                     IF USED("TmpUltimo")
4977:                         GO TOP IN TmpUltimo
4978: 
4979:                         IF (EOF("TmpUltimo") OR gc_4c_UsuarioLogado == TmpUltimo.UsuaAlts) AND USED(loc_cCursor)
4980:                             SELECT TmpTmp1
4981:                             SCATTER MEMVAR
4982:                             m.Flag = .T.

*-- Linhas 5005 a 5048:
5005:     * produto. ParentForm.Produto aqui eh STRING (CPros), diferente do
5006:     * ramo UNITARIO (mesmo nome de property, tipo NUMERICO la).
5007:     *==========================================================================
5008:     PROTECTED PROCEDURE CarregarLinhasCadastro()
5009:         LOCAL loc_cCursor, loc_cProduto, loc_cQuery, loc_nResultado, loc_oErro
5010: 
5011:         loc_cCursor  = THIS.this_cCursorEtiquetas
5012:         loc_cProduto = ""
5013: 
5014:         THIS.grd_4c_Dados.Column4.ReadOnly = .T.
5015: 
5016:         IF VARTYPE(THIS.this_oFormAnterior) = "O"
5017:             IF PEMSTATUS(THIS.this_oFormAnterior, "Produto", 5)
5018:                 IF VARTYPE(THIS.this_oFormAnterior.Produto) = "C"
5019:                     loc_cProduto = THIS.this_oFormAnterior.Produto
5020:                 ENDIF
5021:             ENDIF
5022:         ENDIF
5023: 
5024:         TRY
5025:             loc_cQuery = "SELECT b.*, a.pvens, a.precode, a.cGrus, a.Categoria " + ;
5026:                 "FROM SigOpEtq b JOIN SigCdpro a ON a.cpros = b.cpros " + ;
5027:                 "WHERE b.Cpros = " + EscaparSQL(loc_cProduto) + " " + ;
5028:                 "AND NOT b.Grupos = '" + SPACE(10) + "' " + ;
5029:                 "AND NOT b.Contas = '" + SPACE(10) + "'"
5030: 
5031:             IF USED("TmpTmp2")
5032:                 USE IN TmpTmp2
5033:             ENDIF
5034:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cQuery, "TmpTmp2")
5035: 
5036:             IF loc_nResultado < 1
5037:                 MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TmpTmp2)")
5038:             ELSE
5039:                 IF USED(loc_cCursor)
5040:                     SELECT TmpTmp2
5041:                     SCAN
5042:                         SCATTER MEMVAR
5043:                         m.Flag = .T.
5044:                         INSERT INTO (loc_cCursor) FROM MEMVAR
5045:                     ENDSCAN
5046:                 ENDIF
5047:             ENDIF
5048: 

*-- Linhas 5083 a 5126:
5083:     * Fecha com o DO CASE de ordenacao por THIS.this_nOrdemImp nas 5 TAG
5084:     * que CriarCursorEtiquetas (Fase 4) ja criou.
5085:     *==========================================================================
5086:     PROTECTED PROCEDURE CarregarLinhasConsulta()
5087:         LOCAL loc_cCursor, loc_cGdeGrupo, loc_cCol, loc_cOperacao, loc_nEtiqIni, ;
5088:               loc_nEtiqFim, loc_dDtInicial, loc_dDtFinal, loc_cEmpresa, ;
5089:               loc_cIndustria, loc_nNumero, loc_nNumerof, loc_cCdProduto, ;
5090:               loc_cGrEstoque, loc_cEstoque, loc_cLocaliza, loc_cGrupo, ;
5091:               loc_cSgrus, loc_cColecoes, loc_cPromos, loc_nQtdEti, ;
5092:               loc_nOptMarca, loc_cLinha, loc_cDepto, loc_cQuery, ;
5093:               loc_nResultado, loc_nBrI, loc_nBrF, loc_cDtI, loc_cDtF, ;
5094:               loc_cOpIn, loc_cOpFim, loc_nQtd, loc_oErro
5095: 
5096:         loc_cCursor = THIS.this_cCursorEtiquetas
5097: 
5098:         THIS.grd_4c_Dados.Column4.ReadOnly = .T.
5099: 
5100:         *-- Memvars PRIVATE/PUBLIC do chamador (SigPrRet) - guarda TYPE()
5101:         *-- igual ao Init legado para pcGdeGrupo/pcCol (2598-2604).
5102:         loc_cGdeGrupo  = IIF(TYPE("pcGdeGrupo")  != "U", pcGdeGrupo,  SPACE(3))
5103:         loc_cCol       = IIF(TYPE("pcCol")       != "U", pcCol,       SPACE(3))
5104:         loc_cOperacao  = IIF(TYPE("pcOperacao")  != "U", pcOperacao,  "")
5105:         loc_nEtiqIni   = IIF(TYPE("pnEtiqIni")   != "U", pnEtiqIni,   0)
5106:         loc_nEtiqFim   = IIF(TYPE("pnEtiqFim")   != "U", pnEtiqFim,   0)
5107:         loc_dDtInicial = IIF(TYPE("pdDtInicial") != "U", pdDtInicial, {})
5108:         loc_dDtFinal   = IIF(TYPE("pdDtFinal")   != "U", pdDtFinal,   {})
5109:         loc_cEmpresa   = IIF(TYPE("pcEmpresa")   != "U", pcEmpresa,   "")
5110:         loc_cIndustria = IIF(TYPE("pcIndustria") != "U", pcIndustria, "")
5111:         loc_nNumero    = IIF(TYPE("pnNumero")    != "U", pnNumero,    0)
5112:         loc_nNumerof   = IIF(TYPE("pnNumerof")   != "U", pnNumerof,   0)
5113:         loc_cCdProduto = IIF(TYPE("pcCdProduto") != "U", pcCdProduto, "")
5114:         loc_cGrEstoque = IIF(TYPE("pcGrEstoque") != "U", pcGrEstoque, "")
5115:         loc_cEstoque   = IIF(TYPE("pcEstoque")   != "U", pcEstoque,   "")
5116:         loc_cLocaliza  = IIF(TYPE("pcLocaliza")  != "U", pcLocaliza,  "")
5117:         loc_cGrupo     = IIF(TYPE("pcGrupo")     != "U", pcGrupo,     "")
5118:         loc_cSgrus     = IIF(TYPE("pcSgrus")     != "U", pcSgrus,     "")
5119:         loc_cColecoes  = IIF(TYPE("pcColecoes")  != "U", pcColecoes,  "")
5120:         loc_cPromos    = IIF(TYPE("pcPromos")    != "U", pcPromos,    "")
5121:         loc_nQtdEti    = IIF(TYPE("pnQtdEti")    != "U", pnQtdEti,    0)
5122:         loc_nOptMarca  = IIF(TYPE("OptMarca")    != "U", OptMarca,    0)
5123:         loc_cLinha     = IIF(TYPE("pcLinha")     != "U", pcLinha,     "")
5124:         loc_cDepto     = IIF(TYPE("pcDepto")     != "U", pcDepto,     "")
5125: 
5126:         TRY

*-- Linhas 5393 a 5436:
5393: 
5394:             IF loc_nPrinters <= 0
5395:                 THIS.this_cMensagemErro = "N" + CHR(227) + "o Foi Encontrada Nenhuma Impressora!!!"
5396:                 MsgAviso(THIS.this_cMensagemErro, "")
5397:             ELSE
5398:                 FOR loc_nI = 1 TO loc_nPrinters
5399:                     INSERT INTO crImpre (impres) VALUES (UPPER(loc_aPrinters[loc_nI, 1]))
5400:                 ENDFOR
5401: 
5402:                 loc_cSQL = "SELECT b.impres, b.ntpimpres FROM SigSyImp a, SigCdmp b " + ;
5403:                            "WHERE a.usuacess = " + EscaparSQL(gc_4c_UsuarioLogado) + " AND a.cimps = b.impres " + ;
5404:                            "UNION ALL " + ;
5405:                            "SELECT c.impres, c.ntpimpres FROM SigCdAcG a, SigSyImp b, SigCdmp c " + ;
5406:                            "WHERE a.usuarios = " + EscaparSQL(gc_4c_UsuarioLogado) + " " + ;
5407:                            "AND a.grupos = b.gracess AND b.cimps = c.impres"
5408: 
5409:                 IF USED("cursor_4c_ImpressorasTemp")
5410:                     USE IN cursor_4c_ImpressorasTemp
5411:                 ENDIF
5412:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpressorasTemp")
5413: 
5414:                 IF USED("crSigCdmp")
5415:                     USE IN crSigCdmp
5416:                 ENDIF
5417: 
5418:                 IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ImpressorasTemp") > 0
5419:                     SELECT impres, ntpimpres FROM cursor_4c_ImpressorasTemp ;
5420:                         INTO CURSOR crSigCdmp READWRITE
5421:                 ELSE
5422:                     CREATE CURSOR crSigCdmp (impres C(50), ntpimpres N(4, 0))
5423:                 ENDIF
5424: 
5425:                 IF USED("cursor_4c_ImpressorasTemp")
5426:                     USE IN cursor_4c_ImpressorasTemp
5427:                 ENDIF
5428: 
5429:                 IF USED("crImp")
5430:                     USE IN crImp
5431:                 ENDIF
5432: 
5433:                 SELECT PADR(ALLTRIM(a.impres), 15) + " " + ALLTRIM(b.impres) AS IDupla, ;
5434:                        b.impres, a.impres AS impresS ;
5435:                     FROM crSigCdmp a, crImpre b ;
5436:                     WHERE ALLTRIM(UPPER(a.impres)) LIKE "%" + ALLTRIM(UPPER(b.impres)) + "%" OR ;

*-- Linhas 5471 a 5593:
5471:     * AplicarDefaultsImpressora - Cnt_Impressora.Opcao_Imp/Spinners com os
5472:     * defaults de LocalParam/LocalParaC (Init:3252-3261).
5473:     *==========================================================================
5474:     PROTECTED PROCEDURE AplicarDefaultsImpressora()
5475:         IF USED("LocalParam") AND USED("LocalParaC")
5476:             THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value   = IIF(LocalParam.ImpEtis != 0, LocalParam.ImpEtis, 1)
5477:             THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Value = LocalParam.AjVerts
5478:             THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Value = LocalParam.AjHorzs
5479:             THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Value = IIF(LocalParaC.AjDens <= 10, 10, LocalParaC.AjDens)
5480:             THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Value = LocalParaC.AjVelos
5481:         ENDIF
5482:     ENDPROC
5483: 
5484:     *==========================================================================
5485:     * AjustarBotaoImprimirPorContexto - Init:3263-3266: AND-a o Enabled do
5486:     * botao Imprimir (Buttons(4), ja decidido por AjustarBotoesPorTipo-
5487:     * Chamador) com "ha tipo de etiqueta configurado" e "ha impressora
5488:     * disponivel".
5489:     *
5490:     * O ".Value = Iif(.btnImprime.Enabled,1,2)" que acompanha no legado
5491:     * eh cosmetico (so decide qual botao aparece "pressionado" no
5492:     * CommandGroup - nao afeta Enabled/Click) e a correspondencia exata
5493:     * entre o indice legado e Buttons(N) migrado nao eh determinavel com
5494:     * certeza - OMITIDO de proposito, mesmo criterio documentado para
5495:     * Opt_Impressora.InteractiveChange em ConfigurarEventosPrincipais.
5496:     *==========================================================================
5497:     PROTECTED PROCEDURE AjustarBotaoImprimirPorContexto()
5498:         LOCAL loc_oBotaoImprimir
5499: 
5500:         loc_oBotaoImprimir = THIS.cmg_4c_CntBotoes.Buttons(4)
5501: 
5502:         loc_oBotaoImprimir.Enabled = loc_oBotaoImprimir.Enabled AND ;
5503:             (THIS.this_nTotalTiposEtiqueta != 0) AND (THIS.this_nTotalImpressoras != 0)
5504:     ENDPROC
5505: 
5506:     *==========================================================================
5507:     * AjustarReadOnlyQtdsPorLibObss - Init:3270: "Thisform.grd_Historico.
5508:     * Column7.ReadOnly = Iif(LocalParam.LibObss=1,.F.,.T.)". A NAME
5509:     * "Column7" do legado eh a coluna criada na POSICAO 6 deste form
5510:     * (Qtds/Quantidade - ver tabela de renomeacao em ConfigurarGrade),
5511:     * NAO a Observacao (essa eh a NAME "Column8" = posicao 7, migrada
5512:     * Column7). Sobrescreve o ReadOnly=.F. incondicional que
5513:     * FormatarColunasGrade ja aplica.
5514:     *==========================================================================
5515:     PROTECTED PROCEDURE AjustarReadOnlyQtdsPorLibObss()
5516:         IF USED("LocalParam")
5517:             THIS.grd_4c_Dados.Column6.ReadOnly = IIF(LocalParam.LibObss = 1, .F., .T.)
5518:             THIS.grd_4c_Dados.Refresh()
5519:         ENDIF
5520:     ENDPROC
5521: 
5522:     *==========================================================================
5523:     * ConfigurarModoDigitacao - Init:3273-3285: Tipo='DIGITACAO' (SigPrRet,
5524:     * reimpressao individual com codigo digitado a mao) remove a ordenacao,
5525:     * insere uma linha vazia e deixa o foco na coluna de codigo/barra
5526:     * editavel; todo o resto manda o foco para a grade.
5527:     *==========================================================================
5528:     PROTECTED PROCEDURE ConfigurarModoDigitacao()
5529:         LOCAL loc_cCursor
5530: 
5531:         loc_cCursor = THIS.this_cCursorEtiquetas
5532: 
5533:         IF THIS.ObterTipoChamador() == "DIGITACAO"
5534:             IF USED(loc_cCursor)
5535:                 SELECT (loc_cCursor)
5536:                 SET ORDER TO
5537:                 APPEND BLANK
5538:             ENDIF
5539: 
5540:             THIS.grd_4c_Dados.Column4.ReadOnly = .F.
5541:             THIS.grd_4c_Dados.Column4.SetFocus()
5542:         ELSE
5543:             THIS.grd_4c_Dados.SetFocus()
5544:         ENDIF
5545:     ENDPROC
5546: 
5547: ENDDEFINE
5548: 
5549: *==============================================================================
5550: * TextBoxCodBarrasIpE_4c - subclasse de TextBox para a Column4 (codigo de
5551: * barras) da grade. BINDEVENT em "Valid" de TextBox de Column nao eh
5552: * confiavel (regra CLAUDE.md #46) - GotFocus/Valid tem de ser METODO DE
5553: * CLASSE, delegando para THISFORM, igual ao padrao TextBoxProdutoLpr_4c
5554: * (FormLpr.prg).
5555: *==============================================================================
5556: DEFINE CLASS TextBoxCodBarrasIpE_4c AS TextBox
5557:     PROCEDURE GotFocus()
5558:         THIS.Tag = STR(NVL(THIS.Value, 0), 14)
5559:     ENDPROC
5560: 
5561:     PROCEDURE Valid()
5562:         LOCAL loc_lRetorno
5563:         loc_lRetorno = .T.
5564:         IF PEMSTATUS(THISFORM, "ValidarCodigoBarrasGrade", 5)
5565:             loc_lRetorno = THISFORM.ValidarCodigoBarrasGrade(THIS)
5566:         ENDIF
5567:         RETURN loc_lRetorno
5568:     ENDPROC
5569: ENDDEFINE
5570: 
5571: *==============================================================================
5572: * TextBoxParcelasIpE_4c - subclasse de TextBox para a Column10 (parcelas)
5573: * da grade. Mesmo motivo da TextBoxCodBarrasIpE_4c acima.
5574: *==============================================================================
5575: DEFINE CLASS TextBoxParcelasIpE_4c AS TextBox
5576:     PROCEDURE When()
5577:         LOCAL loc_lPode
5578:         loc_lPode = .T.
5579:         IF PEMSTATUS(THISFORM, "PodeEditarParcelas", 5)
5580:             loc_lPode = THISFORM.PodeEditarParcelas()
5581:         ENDIF
5582:         RETURN loc_lPode
5583:     ENDPROC
5584: 
5585:     PROCEDURE Valid()
5586:         LOCAL loc_lRetorno
5587:         loc_lRetorno = .T.
5588:         IF PEMSTATUS(THISFORM, "ValidarParcelasGrade", 5)
5589:             loc_lRetorno = THISFORM.ValidarParcelasGrade(THIS)
5590:         ENDIF
5591:         RETURN loc_lRetorno
5592:     ENDPROC
5593: ENDDEFINE


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

