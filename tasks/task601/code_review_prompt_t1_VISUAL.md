# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Produtos' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrDsc.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1384 linhas total):

*-- Linhas 7 a 34:
7: *       SigPrPrt), monta a descricao (Grupo + Cor) via SigCdGrp/SigCdCor,
8: *       traduz via dicionario (SigCdDic) e grava de volta em SigCdPro
9: *       (DscCompras/ObsCompras/DPros).
10: *
11: * FASE 4/8 - Grid e Botoes: alem da estrutura base (Fase 3), acrescenta o
12: * cursor local (cursor_4c_Produtos), a grade (grd_4c_Dados) e os 3 botoes de
13: * acao (cmd_4c_BtnSelecionar/cmd_4c_BtnAtualizar/cmd_4c_BtnSair). Atualizar e
14: * Sair ja estao funcionais (handlers renomeados na Fase 8 para BtnGravarClick
15: * e BtnCancelarClick); Selecionar so recebe o Click quando os campos de filtro
16: * getCProsI/getCProsF/getCGrus entrarem no form, numa fase seguinte do
17: * pipeline (Campos).
18: *
19: * FASE 5/8 - Campos Principais (Parte 1): acrescenta a primeira metade dos
20: * campos de filtro do legado (Say3/getCProsI e Say1/getCProsF - a faixa
21: * "Produtos de : ___ ate ___"), mapeados para lbl_4c_ProdutosDe/
22: * txt_4c_CProsI e lbl_4c_Ate/txt_4c_CProsF. Sao apenas os controles
23: * (Left/Top/Width identicos ao SCX legado) - o campo Grupo (Say2/getCGrus)
24: * e o BINDEVENT de KeyPress/lookup de todos os tres entram nas fases
25: * seguintes do pipeline (Campos Parte 2 / Eventos).
26: *
27: * FASE 6/8 - Campos Restantes e Lookups: acrescenta o ultimo campo de
28: * filtro do legado (Say2/getCGrus - "Grupo de Produto :"), mapeado para
29: * lbl_4c_Grupo/txt_4c_CGrus, e liga os TRES lookups (fwbuscaext no legado)
30: * via BINDEVENT KeyPress (Enter/Tab/F4) + DblClick.
31: *
32: * Os pickers ficam em AbrirLookupProduto() (SigCdPro) e AbrirLookupGrupo()
33: * (SigCdGrp), pela API MANUAL do FormBuscaAuxiliar (Pattern A: cursor
34: * populado no caller + mAddColuna + Show). NAO se usa o helper

*-- Linhas 93 a 113:
93: * limpeza geral - os Valid limpam SUBCONJUNTOS de filtro, ja implementados em
94: * ValidarCProsI/ValidarCProsF/ValidarCGrus). Cria-los vazios ou como apelido
95: * de metodo existente seria stub disfarcado.
96: *
97: * No BO, a gravacao segue linha-a-linha: BtnGravarClick faz o SCAN de
98: * cursor_4c_Produtos chamando EditarRegistro + CarregarDoCursor + Salvar por
99: * produto - a mesma topologia N-linhas do PROCEDURE gravacao legado (Scan
100: * While llOks), e o motivo de FormParaBO cuidar dos filtros e nao das colunas
101: * da grade (que o legado deixa ReadOnly). SigPrDscBO ganhou TemFiltro() e
102: * NormalizarFiltros() (criterio da guarda de filtro vazio e espelhamento da
103: * faixa, transcritos do Click do btnSelecionar) e a chamada a fGravarLog()
104: * (wrapper no-op, utils\fgravarlog.prg) no ramo em que o Delete SigPrPrt
105: * falha, reproduzindo a linha "=fGravarLog([T], Upper(ThisForm.Name), Usuar,
106: * [Falha na Conexao (Traducao)])" do PROCEDURE gravacao original que faltava.
107: *==============================================================================
108: 
109: DEFINE CLASS FormSigPrDsc AS FormBase
110: 
111:     Width        = 800
112:     Height       = 600
113:     AutoCenter   = .T.

*-- Linhas 140 a 148:
140:     * Init - define Caption com CHR() antes de delegar ao FormBase.Init()
141:     *--------------------------------------------------------------------------
142:     PROCEDURE Init()
143:         THIS.Caption = "Montagem de Descri" + CHR(231) + CHR(227) + "o de Produtos"
144:         *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
145:         RETURN DODEFAULT()
146:     ENDPROC
147: 
148:     *--------------------------------------------------------------------------

*-- Linhas 191 a 200:
191: 
192:                     THIS.ConfigurarPageFrame()
193: 
194:                     THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
195:                     THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
196: 
197:                     THIS.TornarControlesVisiveis(THIS)
198:                 ENDIF
199:             ENDIF
200:         CATCH TO loc_oErro

*-- Linhas 236 a 285:
236:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
237:         loc_oCab = THIS.cnt_4c_Cabecalho
238:         WITH loc_oCab
239:             .Top         = 0
240:             .Left        = 0
241:             .Width       = THIS.Width
242:             .Height      = 80
243:             .BackColor   = RGB(100,100,100)
244:             .BackStyle   = 1
245:             .BorderWidth = 0
246:         ENDWITH
247: 
248:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
249:         WITH loc_oCab.lbl_4c_Sombra
250:             .AutoSize      = .F.
251:             .Width         = loc_oCab.Width - 20
252:             .Height        = 40
253:             .Top           = 18
254:             .Left          = 10
255:             .FontName      = "Tahoma"
256:             .FontSize      = 18
257:             .FontBold      = .T.
258:             .FontUnderline = .F.
259:             .Alignment     = 0
260:             .BackStyle     = 0
261:             .WordWrap      = .T.
262:             .ForeColor     = RGB(0,0,0)
263:             .Caption       = THIS.Caption
264:         ENDWITH
265: 
266:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
267:         WITH loc_oCab.lbl_4c_Titulo
268:             .AutoSize  = .F.
269:             .Width     = loc_oCab.Width - 20
270:             .Height    = 46
271:             .Top       = 17
272:             .Left      = 10
273:             .FontName  = "Tahoma"
274:             .FontSize  = 18
275:             .FontBold  = .T.
276:             .Alignment = 0
277:             .BackStyle = 0
278:             .WordWrap  = .T.
279:             .ForeColor = RGB(255,255,255)
280:             .Caption   = THIS.Caption
281:         ENDWITH
282:     ENDPROC
283: 
284:     *--------------------------------------------------------------------------
285:     * ConfigurarGrid - cria o cursor local de produtos traduzidos (equivalente

*-- Linhas 297 a 425:
297:     * Init - nunca alterado depois em lugar nenhum do codigo original).
298:     *--------------------------------------------------------------------------
299:     PROTECTED PROCEDURE ConfigurarGrid()
300:         LOCAL loc_oGrid
301: 
302:         IF !USED("cursor_4c_Produtos")
303:             CREATE CURSOR cursor_4c_Produtos (CPros C(14), Portugues C(254), ;
304:                 Traduzido C(254), DscCompras M, ObsCompras M)
305:         ENDIF
306: 
307:         THIS.AddObject("grd_4c_Dados", "Grid")
308:         loc_oGrid = THIS.grd_4c_Dados
309:         WITH loc_oGrid
310:             .Top               = 164
311:             .Left              = 15
312:             .Width             = 769
313:             .Height            = 343
314:             .ColumnCount       = 3
315:             .FontSize          = 8
316:             .AllowHeaderSizing = .F.
317:             .AllowRowSizing    = .F.
318:             .DeleteMark        = .F.
319:             .RecordMark        = .F.
320:             .HeaderHeight      = 17
321:             .RowHeight         = 17
322:             .ScrollBars        = 2
323:             .RecordSource      = "cursor_4c_Produtos"
324:             .ReadOnly          = .T.
325:         ENDWITH
326: 
327:         WITH loc_oGrid.Column1
328:             .Width         = 108
329:             .FontSize      = 8
330:             .ControlSource = "cursor_4c_Produtos.CPros"
331:         ENDWITH
332:         WITH loc_oGrid.Column1.Header1
333:             .FontName  = "Tahoma"
334:             .FontSize  = 8
335:             .Alignment = 2
336:             .Caption   = "C" + CHR(243) + "digo"
337:         ENDWITH
338:         WITH loc_oGrid.Column1.Text1
339:             .FontSize    = 8
340:             .BorderStyle = 0
341:             .Margin      = 0
342:             .ForeColor   = RGB(0, 0, 0)
343:             .BackColor   = RGB(255, 255, 255)
344:         ENDWITH
345: 
346:         WITH loc_oGrid.Column2
347:             .Width         = 290
348:             .FontSize      = 8
349:             .ControlSource = "cursor_4c_Produtos.Portugues"
350:         ENDWITH
351:         WITH loc_oGrid.Column2.Header1
352:             .FontName  = "Tahoma"
353:             .FontSize  = 8
354:             .Alignment = 2
355:             .Caption   = "Portugu" + CHR(234) + "s"
356:         ENDWITH
357:         WITH loc_oGrid.Column2.Text1
358:             .FontSize    = 8
359:             .BorderStyle = 0
360:             .Margin      = 0
361:             .ForeColor   = RGB(0, 0, 0)
362:             .BackColor   = RGB(255, 255, 255)
363:         ENDWITH
364: 
365:         WITH loc_oGrid.Column3
366:             .Width         = 339
367:             .FontSize      = 8
368:             .ControlSource = "cursor_4c_Produtos.Traduzido"
369:         ENDWITH
370:         WITH loc_oGrid.Column3.Header1
371:             .FontName  = "Tahoma"
372:             .FontSize  = 8
373:             .Alignment = 2
374:             .Caption   = "Traduzido"
375:         ENDWITH
376:         WITH loc_oGrid.Column3.Text1
377:             .FontSize    = 8
378:             .BorderStyle = 0
379:             .Margin      = 0
380:             .ForeColor   = RGB(0, 0, 0)
381:             .BackColor   = RGB(255, 255, 255)
382:         ENDWITH
383:     ENDPROC
384: 
385:     *--------------------------------------------------------------------------
386:     * ConfigurarBotoes - cria os 3 botoes de acao do form (todos filhos diretos
387:     * da Form no legado, sem CommandGroup): btnSelecionar/btnAtualizar/btnSair
388:     * mapeados para cmd_4c_BtnSelecionar/cmd_4c_BtnAtualizar/cmd_4c_BtnSair
389:     * (mapeamento.json). O Commandgroup3 do legado (ButtonCount=0, BorderStyle=0,
390:     * BackStyle=0) nao desenha nada em runtime - eh um retangulo de guia deixado
391:     * no Form Designer sem nenhum botao dentro - por isso nao tem equivalente
392:     * aqui (nada a reproduzir: o legado tambem nao mostra nada nesse ponto).
393:     *
394:     * cmd_4c_BtnSelecionar (equivalente ao PROCEDURE processamento do legado)
395:     * tem o Click ligado a BtnSelecionarClick/Processamento() (ver mais abaixo),
396:     * ja que os campos de filtro getCProsI/getCProsF/getCGrus foram acrescentados
397:     * na Fase 5/6.
398:     *--------------------------------------------------------------------------
399:     PROTECTED PROCEDURE ConfigurarBotoes()
400:         THIS.AddObject("cmd_4c_BtnSelecionar", "CommandButton")
401:         WITH THIS.cmd_4c_BtnSelecionar
402:             .Top             = 116
403:             .Left            = 744
404:             .Width           = 40
405:             .Height          = 40
406:             .Caption         = ""
407:             .Picture         = gc_4c_CaminhoIcones + "a_arrow6.bmp"
408:             .DisabledPicture = gc_4c_CaminhoIcones + "a_arrow6.bmp"
409:             .ToolTipText     = "Selecionar"
410:             .Themes          = .T.
411:         ENDWITH
412:         BINDEVENT(THIS.cmd_4c_BtnSelecionar, "Click", THIS, "BtnSelecionarClick")
413: 
414:         THIS.AddObject("cmd_4c_BtnAtualizar", "CommandButton")
415:         WITH THIS.cmd_4c_BtnAtualizar
416:             .Top        = 3
417:             .Left       = 650
418:             .Width      = 75
419:             .Height     = 75
420:             .Caption    = "\<Atualizar"
421:             .Picture    = gc_4c_CaminhoIcones + "geral_relogio_60.jpg"
422:             .FontName   = "Comic Sans MS"
423:             .FontBold   = .T.
424:             .FontItalic = .T.
425:             .FontSize   = 8

*-- Linhas 436 a 452:
436:         *-- eh o botao de GRAVAR desta tela. O objeto e a Caption continuam
437:         *-- "Atualizar" (PILAR 1 - o usuario ve o mesmo botao de antes); so o
438:         *-- nome interno do metodo descreve o que ele faz (PILAR 3).
439:         BINDEVENT(THIS.cmd_4c_BtnAtualizar, "Click", THIS, "BtnGravarClick")
440: 
441:         THIS.AddObject("cmd_4c_BtnSair", "CommandButton")
442:         WITH THIS.cmd_4c_BtnSair
443:             .Top        = 3
444:             .Left       = 725
445:             .Width      = 75
446:             .Height     = 75
447:             .Caption    = "Encerrar"
448:             .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
449:             .Cancel     = .T.
450:             .FontName   = "Comic Sans MS"
451:             .FontBold   = .T.
452:             .FontItalic = .T.

*-- Linhas 460 a 566:
460:         *-- ESC e o clique caem no MESMO handler. Por isso o metodo se chama
461:         *-- BtnCancelarClick - eh o cancelamento da tela -, enquanto o objeto
462:         *-- e a Caption continuam "Encerrar" (PILAR 1 + CLAUDE.md #10).
463:         BINDEVENT(THIS.cmd_4c_BtnSair, "Click", THIS, "BtnCancelarClick")
464: 
465:         *-- Estado inicial do botao de gravar pelo MESMO funil que todas as
466:         *-- transicoes seguintes usam (ver AjustarBotoesPorModo). O legado faz
467:         *-- isso no PROCEDURE Init (.btnAtualizar.Enabled = .f.); aqui o
468:         *-- cursor_4c_Produtos ja existe (criado em ConfigurarGrid, que roda
469:         *-- antes deste metodo) e esta vazio, entao o funil chega ao mesmo .F.
470:         THIS.AjustarBotoesPorModo()
471:     ENDPROC
472: 
473:     *--------------------------------------------------------------------------
474:     * ConfigurarCampos - cria a faixa de filtro do legado (Say3/getCProsI,
475:     * Say1/getCProsF e Say2/getCGrus - "Produtos de : ___ ate ___  Grupo
476:     * de Produto : ___"), controles diretos da Form (sem PageFrame), com
477:     * Left/Top/Width identicos ao dump do SCX.
478:     *
479:     * Say3/Say1/Say2 sao classe "say" pura no dump (nao declaram Width nem
480:     * Alignment) - AutoSize = .T. + Alignment = 0, sem inventar caixa (regra
481:     * #23). Format = "K" do legado equivale a SelectOnEntry = .T. em VFP9
482:     * (substitui o texto ao entrar no campo, nao restringe o que pode ser
483:     * digitado - por isso NAO e o Format = "M" da regra #24).
484:     *
485:     * FASE 6/8: acrescenta lbl_4c_Grupo/txt_4c_CGrus (Say2/getCGrus) e liga
486:     * os 3 lookups via BINDEVENT (ver ValidarCProsI/ValidarCProsF/
487:     * ValidarCGrus mais abaixo).
488:     *--------------------------------------------------------------------------
489:     PROTECTED PROCEDURE ConfigurarCampos()
490:         THIS.AddObject("lbl_4c_ProdutosDe", "Label")
491:         WITH THIS.lbl_4c_ProdutosDe
492:             .AutoSize  = .T.
493:             .Alignment = 0
494:             .FontName  = "Tahoma"
495:             .FontSize  = 8
496:             .FontBold  = .T.
497:             .BackStyle = 0
498:             .ForeColor = RGB(90, 90, 90)
499:             .Left      = 155
500:             .Top       = 138
501:             .Caption   = "Produtos de :"
502:         ENDWITH
503: 
504:         THIS.AddObject("txt_4c_CProsI", "TextBox")
505:         WITH THIS.txt_4c_CProsI
506:             .FontName      = "Tahoma"
507:             .FontSize      = 8
508:             .Left          = 233
509:             .Top           = 135
510:             .Width         = 108
511:             .MaxLength     = 14
512:             .SelectOnEntry = .T.
513:             .Value         = ""
514:         ENDWITH
515: 
516:         THIS.AddObject("lbl_4c_Ate", "Label")
517:         WITH THIS.lbl_4c_Ate
518:             .AutoSize  = .T.
519:             .Alignment = 0
520:             .FontName  = "Tahoma"
521:             .FontSize  = 8
522:             .FontBold  = .T.
523:             .BackStyle = 0
524:             .ForeColor = RGB(90, 90, 90)
525:             .Left      = 345
526:             .Top       = 138
527:             .Caption   = "at" + CHR(233)
528:         ENDWITH
529: 
530:         THIS.AddObject("txt_4c_CProsF", "TextBox")
531:         WITH THIS.txt_4c_CProsF
532:             .FontName      = "Tahoma"
533:             .FontSize      = 8
534:             .Left          = 370
535:             .Top           = 135
536:             .Width         = 108
537:             .MaxLength     = 14
538:             .SelectOnEntry = .T.
539:             .Value         = ""
540:         ENDWITH
541: 
542:         THIS.AddObject("lbl_4c_Grupo", "Label")
543:         WITH THIS.lbl_4c_Grupo
544:             .AutoSize  = .T.
545:             .Alignment = 0
546:             .FontName  = "Tahoma"
547:             .FontSize  = 8
548:             .FontBold  = .T.
549:             .BackStyle = 0
550:             .ForeColor = RGB(90, 90, 90)
551:             .Left      = 505
552:             .Top       = 138
553:             .Caption   = "Grupo de Produto :"
554:         ENDWITH
555: 
556:         THIS.AddObject("txt_4c_CGrus", "TextBox")
557:         WITH THIS.txt_4c_CGrus
558:             .FontName      = "Tahoma"
559:             .FontSize      = 8
560:             .Left          = 614
561:             .Top           = 135
562:             .Width         = 31
563:             .MaxLength     = 3
564:             .SelectOnEntry = .T.
565:             .Value         = ""
566:         ENDWITH

*-- Linhas 784 a 792:
784:                             loc_oBusca.this_cCampoDescricao = "dpros"
785:                             loc_oBusca.this_cTitulo         = loc_cTitulo
786:                             IF VARTYPE(loc_oBusca.cnt_4c_Cabecalho) = "O"
787:                                 loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
788:                             ENDIF
789: 
790:                             *-- as TRES colunas do legado, na ordem do mAddColuna
791:                             loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
792:                             loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")

*-- Linhas 893 a 901:
893:                             loc_oBusca.this_cCampoDescricao = "dgrus"
894:                             loc_oBusca.this_cTitulo         = loc_cTitulo
895:                             IF VARTYPE(loc_oBusca.cnt_4c_Cabecalho) = "O"
896:                                 loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
897:                             ENDIF
898: 
899:                             loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
900:                             loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
901: 

*-- Linhas 962 a 987:
962:     ENDPROC
963: 
964:     *--------------------------------------------------------------------------
965:     * CarregarLista - reposiciona o cursor local e repinta a grade (equivalente
966:     * ao ThisForm.Grade.Refresh do legado, chamado no PROCEDURE processamento a
967:     * cada linha inserida em crProdutos). A populacao real do cursor_4c_Produtos
968:     * entra junto com o botao Selecionar, numa fase seguinte do pipeline.
969:     *--------------------------------------------------------------------------
970:     PROCEDURE CarregarLista()
971:         IF USED("cursor_4c_Produtos")
972:             SELECT cursor_4c_Produtos
973:             GO TOP
974:         ENDIF
975: 
976:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
977:             THIS.grd_4c_Dados.Refresh()
978:         ENDIF
979:     ENDPROC
980: 
981:     *--------------------------------------------------------------------------
982:     * BtnSelecionarClick - equivalente ao PROCEDURE Click do btnSelecionar
983:     * legado. Desabilita o botao de gravar, valida que ao menos um filtro foi
984:     * informado, completa a faixa de produto quando so uma ponta foi digitada
985:     * (o legado espelha o inicio no fim e vice-versa) e dispara
986:     * THIS.Processamento().
987:     *

*-- Linhas 1026 a 1056:
1026:     * partir do LEFT JOIN) nao alimentam lcDes em lugar nenhum do codigo
1027:     * fonte extraido (SigPrDsc_form_codigo_fonte.txt, metodo completo, sem
1028:     * truncamento). Ou seja, o bloco de traducao e o "Insert Into crProdutos"
1029:     * sao CODIGO MORTO no proprio legado - o processamento sempre roda (monta
1030:     * cursor_4c_PrdTraduz, consulta Grupo/Cor de cada produto) mas nunca insere
1031:     * linha em cursor_4c_Produtos, e por isso cmd_4c_BtnAtualizar nunca fica
1032:     * habilitado por este caminho. Mantido identico ao legado (PILAR 1) -
1033:     * "reescrever" essa lacuna inventaria regra de negocio que nao existe em
1034:     * lugar nenhum do sistema original.
1035:     *--------------------------------------------------------------------------
1036:     PROTECTED PROCEDURE Processamento()
1037:         LOCAL loc_cPrI, loc_cPrF, loc_cGru, loc_cSQL, loc_nResultado, loc_oProg
1038:         LOCAL loc_cPro, loc_cDes, loc_cIni, loc_nGrD, loc_cIng, loc_oErro
1039: 
1040:         IF USED("cursor_4c_Produtos")
1041:             SELECT cursor_4c_Produtos
1042:             ZAP
1043:         ENDIF
1044: 
1045:         *-- Filtros vem do BO (postos la por FormParaBO e ja espelhados por
1046:         *-- NormalizarFiltros), nao relidos da tela. O PADR eh aplicado SO
1047:         *-- aqui, na montagem do SQL, exatamente como o legado
1048:         *-- (lcPrI = Padr(getCProsI.Value, 14) / lcGru = Padr(getCGrus.Value, 3));
1049:         *-- as properties do BO ficam sem padding para que BOParaForm nao
1050:         *-- devolva espacos a direita para dentro dos TextBox.
1051:         loc_cPrI = PADR(ALLTRIM(THIS.this_oBusinessObject.this_cCProsI), 14)
1052:         loc_cPrF = PADR(ALLTRIM(THIS.this_oBusinessObject.this_cCProsF), 14)
1053:         loc_cGru = PADR(ALLTRIM(THIS.this_oBusinessObject.this_cCGrus), 3)
1054: 
1055:         IF !EMPTY(loc_cGru)
1056:             loc_cSQL = "SELECT cpros FROM SigCdPro WHERE cgrus = " + EscaparSQL(loc_cGru) + ;

*-- Linhas 1130 a 1150:
1130:                         ENDIF
1131: 
1132:                         loc_cDes = STRTRAN(STRTRAN(loc_cDes, "'", " "), '"', " ")
1133:                         loc_cIng = STRTRAN(STRTRAN(loc_cIng, "'", " "), '"', " ")
1134: 
1135:                         INSERT INTO cursor_4c_Produtos (CPros, Portugues, Traduzido, DscCompras, ObsCompras) ;
1136:                             VALUES (loc_cPro, loc_cDes, loc_cIng, loc_cIng, loc_cDes)
1137: 
1138:                         THIS.grd_4c_Dados.Refresh()
1139:                     ENDIF
1140:                 ENDIF
1141:             ENDSCAN
1142: 
1143:             loc_oProg.Complete(.T.)
1144:             loc_oProg.Release()
1145: 
1146:             IF USED("cursor_4c_LocalPro")
1147:                 USE IN SELECT("cursor_4c_LocalPro")
1148:             ENDIF
1149:             IF USED("cursor_4c_PrdTraduz")
1150:                 USE IN SELECT("cursor_4c_PrdTraduz")

*-- Linhas 1175 a 1223:
1175:     * nao pelo rotulo do botao: o objeto e a Caption continuam "Atualizar"
1176:     * (PILAR 1), o nome do metodo descreve o efeito (PILAR 3).
1177:     *
1178:     * Grava as descricoes traduzidas de volta em SigCdPro e
1179:     * remove cada produto da fila SigPrPrt (equivalente ao PROCEDURE gravacao
1180:     * do legado). Percorre cursor_4c_Produtos linha a linha, delegando a
1181:     * gravacao de cada uma ao Business Object (EditarRegistro+CarregarDoCursor+
1182:     * Salvar) - a UPDATE/DELETE/COMMIT/ROLLBACK real esta em
1183:     * SigPrDscBO.Atualizar(). Interrompe no primeiro erro, como o legado
1184:     * (Scan While llOks).
1185:     *--------------------------------------------------------------------------
1186:     PROCEDURE BtnGravarClick()
1187:         LOCAL loc_lOk, loc_oProg, loc_cPro, loc_nTotal, loc_oErro
1188: 
1189:         IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
1190:             RETURN
1191:         ENDIF
1192: 
1193:         loc_lOk = .T.
1194:         loc_nTotal = RECCOUNT("cursor_4c_Produtos")
1195: 
1196:         TRY
1197:             loc_oProg = CREATEOBJECT("fwprogressbar", "Gravando Produtos...", loc_nTotal)
1198:             loc_oProg.Show()
1199: 
1200:             SELECT cursor_4c_Produtos
1201:             GO TOP
1202:             SCAN WHILE loc_lOk
1203:                 loc_cPro = ALLTRIM(cursor_4c_Produtos.CPros)
1204: 
1205:                 loc_oProg.Update("Produto : " + loc_cPro, .T.)
1206: 
1207:                 THIS.this_oBusinessObject.EditarRegistro()
1208:                 THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Produtos")
1209: 
1210:                 IF !THIS.this_oBusinessObject.Salvar()
1211:                     loc_lOk = .F.
1212:                     IF !THIS.this_oBusinessObject.this_lErroExibido
1213:                         MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o produto " + ;
1214:                             loc_cPro + ".", "Erro")
1215:                     ENDIF
1216:                 ENDIF
1217:             ENDSCAN
1218: 
1219:             loc_oProg.Complete(.T.)
1220:             loc_oProg.Release()
1221: 
1222:             IF loc_lOk
1223:                 MsgInfo("Foram Gravados " + ALLTRIM(STR(loc_nTotal, 10)) + " Produtos!!!", ;

*-- Linhas 1247 a 1255:
1247:     * O nome vem da propria declaracao do legado: btnSair tem Cancel = .T. no
1248:     * dump, ou seja eh o botao de CANCELAR do form - ESC e o clique executam o
1249:     * mesmo caminho, e nao ha um segundo botao de fechar de que este precise se
1250:     * distinguir. O objeto (cmd_4c_BtnSair) e a Caption ("Encerrar") seguem
1251:     * identicos ao legado e ao canonico da CLAUDE.md #10.
1252:     *
1253:     * PUBLIC de proposito: alem do BINDEVENT (que ignora metodo PROTECTED),
1254:     * o harness TesteAutomatico.prg chama THIS.oForm.BtnCancelarClick() de
1255:     * fora da classe, e PEMSTATUS(...,5) nao enxerga escopo (CLAUDE.md #3).

*-- Linhas 1286 a 1306:
1286:     * mantido porque eh o que o harness TesteAutomatico.prg procura.
1287:     *--------------------------------------------------------------------------
1288:     PROCEDURE AjustarBotoesPorModo()
1289:         LOCAL loc_lTemLinha
1290: 
1291:         loc_lTemLinha = USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
1292: 
1293:         IF PEMSTATUS(THIS, "cmd_4c_BtnAtualizar", 5)
1294:             THIS.cmd_4c_BtnAtualizar.Enabled = THIS.this_lListaPronta AND loc_lTemLinha
1295:         ENDIF
1296:     ENDPROC
1297: 
1298:     *--------------------------------------------------------------------------
1299:     * FormParaBO - leva os tres filtros da tela para o Business Object
1300:     * (getCProsI/getCProsF/getCGrus do legado). Sao os unicos dados que o
1301:     * usuario digita nesta tela: as colunas da grade nao sao editaveis (o
1302:     * legado faz .Grade.ReadOnly = .t. no Init) e cada linha a gravar vai para
1303:     * o BO por CarregarDoCursor(), dentro do SCAN de BtnGravarClick.
1304:     *
1305:     * PROTECTED obrigatoriamente: FormBase declara este hook como PROTECTED e
1306:     * VFP9 nao permite alargar o escopo na subclasse.

*-- Linhas 1363 a 1384:
1363:     * Destroy - libera o cursor local de produtos traduzidos (equivalente ao
1364:     * crProdutos do legado, populado pelas fases seguintes) antes de
1365:     * delegar ao FormBase.Destroy() (restaura menu / libera BO).
1366:     *--------------------------------------------------------------------------
1367:     PROCEDURE Destroy()
1368:         IF USED("cursor_4c_Produtos")
1369:             USE IN cursor_4c_Produtos
1370:         ENDIF
1371:         IF USED("cursor_4c_Dicionario")
1372:             USE IN cursor_4c_Dicionario
1373:         ENDIF
1374:         IF USED("cursor_4c_PrdTraduz")
1375:             USE IN cursor_4c_PrdTraduz
1376:         ENDIF
1377:         IF USED("cursor_4c_LocalPro")
1378:             USE IN cursor_4c_LocalPro
1379:         ENDIF
1380: 
1381:         DODEFAULT()
1382:     ENDPROC
1383: 
1384: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrDscBO.prg):
*====================================================================
* SigPrDscBO.prg
*
* Business Object para SigPrDsc (Montagem de Descricao de Produtos)
* Tabela principal atualizada: SigCdPro (DscCompras, ObsCompras, DPros)
* Tabelas auxiliares: SigCdGrp, SigCdCor, SigCdDic, SigPrPrt
*
* Form OPERACIONAL: processa produtos sem traducao (fila em SigPrPrt),
* monta a descricao concatenando Grupo + Cor, traduz via dicionario
* (SigCdDic) e grava DscCompras/ObsCompras/DPros de volta em SigCdPro.
*====================================================================

DEFINE CLASS SigPrDscBO AS BusinessBase

	*-- Tabela principal e chave (para auditoria/BusinessBase)
	this_cTabela = "SigCdPro"
	this_cCampoChave = "CPros"

	*-- Filtro de faixa de produtos (telas getCProsI / getCProsF)
	this_cCProsI = ""
	this_cCProsF = ""

	*-- Filtro de grupo de produtos (tela getCGrus)
	this_cCGrus = ""

	*-- Produto corrente sendo processado/gravado (crProdutos.CPros)
	this_cCPros = ""

	*-- Descricao em portugues montada (Grupo + Cor) - crProdutos.Portugues
	this_cPortugues = ""

	*-- Descricao traduzida (ingles) - crProdutos.Traduzido
	this_cTraduzido = ""

	*-- Campos gravados de volta em SigCdPro.DscCompras / ObsCompras
	this_cDscCompras = ""
	this_cObsCompras = ""

	*-- Descricao final formatada gravada em SigCdPro.DPros
	this_cDPros = ""

	*-- Total de produtos processados/gravados (para mensagens de resumo)
	this_nTotalProcessados = 0

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		THIS.this_cTabela = "SigCdPro"
		THIS.this_cCampoChave = "CPros"

		THIS.this_cCProsI = ""
		THIS.this_cCProsF = ""
		THIS.this_cCGrus = ""
		THIS.this_cCPros = ""
		THIS.this_cPortugues = ""
		THIS.this_cTraduzido = ""
		THIS.this_cDscCompras = ""
		THIS.this_cObsCompras = ""
		THIS.this_cDPros = ""
		THIS.this_nTotalProcessados = 0

		RETURN .T.
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Carrega as propriedades do produto corrente a
	* partir de uma linha do cursor crProdutos (estrutura do legado:
	* CPros c(14), Portugues c(254), Traduzido c(254), DscCompras m,
	* ObsCompras m). THIS.this_cDPros e recalculado aqui pela MESMA
	* formula do PROCEDURE gravacao legado (Padr(Alltrim(Portugues),40)),
	* pois DPros nao existe como coluna no cursor - e sempre derivado.
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)

			THIS.this_cCPros      = ALLTRIM(TratarNulo(CPros, ""))
			THIS.this_cPortugues  = TratarNulo(Portugues, "")
			THIS.this_cTraduzido  = TratarNulo(Traduzido, "")
			THIS.this_cDscCompras = TratarNulo(DscCompras, "")
			THIS.this_cObsCompras = TratarNulo(ObsCompras, "")
			THIS.this_cDPros      = PADR(ALLTRIM(THIS.this_cPortugues), 40)

			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* TemFiltro - .T. quando ao menos um dos tres filtros da tela foi
	* informado. Eh o criterio da primeira guarda do PROCEDURE Click do
	* btnSelecionar legado:
	*
	*   If Empty(getCProsI.Value) And Empty(getCProsF.Value) And
	*      Empty(getCGrus.Value) ... Return .f.
	*
	* So o CRITERIO vem para ca - a mensagem e o SetFocus continuam no
	* Form, que eh onde moram (sao UI).
	*====================================================================
	FUNCTION TemFiltro()
		RETURN !EMPTY(ALLTRIM(THIS.this_cCProsI)) OR ;
		       !EMPTY(ALLTRIM(THIS.this_cCProsF)) OR ;
		       !EMPTY(ALLTRIM(THIS.this_cCGrus))
	ENDFUNC

	*====================================================================
	* NormalizarFiltros - completa a faixa de produto quando o usuario
	* digitou apenas uma das pontas. TRANSCRICAO LITERAL do PROCEDURE
	* Click do btnSelecionar legado (regra #17 - criterio do legado nao
	* se reescreve):
	*
	*   If Not Empty(getCProsI.Value) And Empty(getCProsF.Value)
	*       getCProsF.Value = getCProsI.Value
	*   If Empty(getCProsI.Value) And Not Empty(getCProsF.Value)
	*       getCProsI.Value = getCProsF.Value
	*
	* NAO mexe no grupo: a exclusividade faixa-x-grupo eh feita pelos
	* PROCEDURE Valid dos campos (Form.ValidarCProsI/ValidarCProsF/
	* ValidarCGrus), NAO pelo botao Selecionar - o legado tambem nao a
	* aplica aqui, e aplicar limparia filtro que o usuario informou.
	*
	* Guarda os valores SEM padding de proposito: quem monta o SQL aplica
	* o Padr(...,14) / Padr(...,3) do legado. Padded aqui, o BOParaForm
	* devolveria espacos a direita para dentro dos TextBox da tela.
	*====================================================================
	PROCEDURE NormalizarFiltros()
		THIS.this_cCProsI = ALLTRIM(THIS.this_cCProsI)
		THIS.this_cCProsF = ALLTRIM(THIS.this_cCProsF)
		THIS.this_cCGrus  = ALLTRIM(THIS.this_cCGrus)

		*-- legado: If Not Empty(getCProsI.Value) And Empty(getCProsF.Value)
		IF !EMPTY(THIS.this_cCProsI) AND EMPTY(THIS.this_cCProsF)
			THIS.this_cCProsF = THIS.this_cCProsI
		ENDIF

		*-- legado: If Empty(getCProsI.Value) And Not Empty(getCProsF.Value)
		IF EMPTY(THIS.this_cCProsI) AND !EMPTY(THIS.this_cCProsF)
			THIS.this_cCProsI = THIS.this_cCProsF
		ENDIF
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Chave primaria do produto em processamento
	* (usada por RegistrarAuditoria).
	*====================================================================
	FUNCTION ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCPros)
	ENDFUNC

	*====================================================================
	* Inserir - Este form OPERACIONAL nunca cria produto novo em SigCdPro
	* (o cadastro de produtos e feito em outra tela; aqui so se traduz e
	* regrava a descricao de um produto JA existente, apontado pela fila
	* SigPrPrt). "Gravar" e sempre um UPDATE - o proprio PROCEDURE
	* gravacao do legado roda o mesmo par Update/Delete em qualquer
	* contexto -, entao Inserir delega para Atualizar.
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		RETURN THIS.Atualizar()
	ENDPROC

	*====================================================================
	* Atualizar - Grava a descricao (portugues/traduzido) de volta em
	* SigCdPro e remove o produto da fila SigPrPrt. Espelha
	* literalmente o PROCEDURE gravacao do legado:
	*
	*   Update SigCdPro Set DscCompras = ..., ObsCompras = ..., DPros = ...
	*                   Where CPros = ...
	*   Delete From SigPrPrt Where CPros = ...
	*
	* tratando as duas instrucoes como uma unidade: se o Delete falhar
	* apos o Update ter sido aplicado, o legado reverte tudo (RollBack).
	* Conexao nasce em modo transacional manual (Transactions=2, memoria
	* feedback_conexao_sql_transactions_2_sem_commit) - commit/rollback
	* explicitos, no mesmo padrao de SigPrChrBO.ExecutarExclusao.
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
		loc_lSucesso = .F.

		IF EMPTY(ALLTRIM(THIS.this_cCPros))
			THIS.this_cMensagemErro = "Produto sem c" + CHR(243) + "digo (CPros) para grava" + CHR(231) + CHR(227) + "o."
			RETURN .F.
		ENDIF

		THIS.this_cDPros = PADR(ALLTRIM(THIS.this_cPortugues), 40)

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigCdPro
				SET DscCompras = <<EscaparSQL(THIS.this_cDscCompras)>>,
					ObsCompras = <<EscaparSQL(THIS.this_cObsCompras)>>,
					DPros = <<EscaparSQL(THIS.this_cDPros)>>
				WHERE CPros = <<EscaparSQL(THIS.this_cCPros)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				loc_cSQL = "DELETE FROM SigPrPrt WHERE CPros = " + EscaparSQL(THIS.this_cCPros)
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

				IF loc_nResultado >= 0
					SQLCOMMIT(gnConnHandle)
					THIS.RegistrarAuditoria("UPDATE")
					THIS.this_nTotalProcessados = THIS.this_nTotalProcessados + 1
					loc_lSucesso = .T.
				ELSE
					SQLROLLBACK(gnConnHandle)
					*-- legado: =fGravarLog([T], Upper(ThisForm.Name), Usuar,
					*-- [Falha na Conexao (Traducao)]) - wrapper no-op
					*-- (utils\fgravarlog.prg, Erro163_Aba1); retorno descartado
					*-- igual ao original, so para reproduzir a chamada.
					=fGravarLog("T", "SIGPRDSC", gc_4c_UsuarioLogado, ;
						"Falha na Conex" + CHR(227) + "o (Traducao)")
					*-- this_cMensagemErro fica preenchida; quem EXIBE eh
					*-- BusinessBase.Salvar()->ExibirFalha() - MsgErro aqui
					*-- duplicaria a mensagem (regra: falha nunca eh muda, mas
					*-- tambem nunca eh mostrada duas vezes)
					THIS.this_cMensagemErro = "Falha ao remover o produto " + ALLTRIM(THIS.this_cCPros) + ;
						" da fila de tradu" + CHR(231) + CHR(227) + "o (SigPrPrt):" + CHR(13) + CapturarErroSQL()
				ENDIF
			ELSE
				SQLROLLBACK(gnConnHandle)
				THIS.this_cMensagemErro = "Falha ao gravar a descri" + CHR(231) + CHR(227) + "o do produto " + ;
					ALLTRIM(THIS.this_cCPros) + " em SigCdPro:" + CHR(13) + CapturarErroSQL()
			ENDIF

		CATCH TO loc_oErro
			SQLROLLBACK(gnConnHandle)
			THIS.this_cMensagemErro = loc_oErro.Message
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

