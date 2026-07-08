# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (5)
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Analitico' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Impressao' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Cabecalho' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Excel' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecmm.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (840 linhas total):

*-- Linhas 31 a 140:
31:     Themes      = .F.
32:     ShowTips    = .T.
33: 
34:     *-- BO de relatorio (instanciado em InicializarForm)
35:     this_oRelatorio    = .NULL.
36:     this_cMensagemErro = ""
37: 
38:     *--------------------------------------------------------------------------
39:     * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
40:     *--------------------------------------------------------------------------
41:     PROCEDURE Init()
42:         RETURN DODEFAULT()
43:     ENDPROC
44: 
45:     *--------------------------------------------------------------------------
46:     * InicializarForm - Cria estrutura visual do formulario de relatorio
47:     *--------------------------------------------------------------------------
48:     PROTECTED PROCEDURE InicializarForm()
49:         LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
50:         loc_lSucesso   = .F.
51:         loc_lContinuar = .T.
52: 
53:         TRY
54:             THIS.Caption = "Relat" + CHR(243) + "rio de Mapa de Comiss" + CHR(227) + ;
55:                            "o Por Vendedor"
56: 
57:             IF TYPE("gc_4c_CaminhoIcones") = "U"
58:                 gc_4c_CaminhoIcones = ""
59:             ENDIF
60:             IF TYPE("gc_4c_CaminhoReports") = "U"
61:                 gc_4c_CaminhoReports = ""
62:             ENDIF
63:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
64: 
65:             THIS.this_oRelatorio = CREATEOBJECT("sigrecmmBO")
66:             IF VARTYPE(THIS.this_oRelatorio) != "O"
67:                 MsgErro("Erro ao criar sigrecmmBO" + CHR(13) + ;
68:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
69:                 loc_lContinuar = .F.
70:             ENDIF
71: 
72:             IF loc_lContinuar
73:                 THIS.ConfigurarCabecalho()
74:                 THIS.ConfigurarPageFrame()
75:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
76:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
77:                 THIS.ConfigurarPaginaLista()
78:                 THIS.ConfigurarPaginaDados()
79:                 THIS.LimparCampos()
80:                 loc_lSucesso = .T.
81:             ENDIF
82: 
83:         CATCH TO loc_oErro
84:             THIS.this_cMensagemErro = loc_oErro.Message
85:             MsgErro(loc_oErro.Message + CHR(13) + ;
86:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
87:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
88:         ENDTRY
89: 
90:         RETURN loc_lSucesso
91:     ENDPROC
92: 
93:     *--------------------------------------------------------------------------
94:     * ConfigurarCabecalho - Container escuro superior com titulo e botoes REPORT
95:     *   Width = THIS.Width (700) para cobrir toda a faixa superior.
96:     *   BackColor=RGB(100,100,100) = cinza medio do framework (cntSombra).
97:     *   cmg_4c_Botoes: CommandGroup com 4 botoes (Visualizar/Imprimir/DocExcel/Sair)
98:     *   Posicoes dos botoes conforme btnReport original: Left=430, Lefts=2,68,134,200
99:     *--------------------------------------------------------------------------
100:     PROTECTED PROCEDURE ConfigurarCabecalho()
101:         LOCAL loc_oCab, loc_oCmg
102:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
103:         loc_oCab = THIS.cnt_4c_Cabecalho
104: 
105:         WITH loc_oCab
106:             .Top         = 0
107:             .Left        = 0
108:             .Width       = THIS.Width
109:             .Height      = 80
110:             .BackStyle   = 1
111:             .BackColor   = RGB(100, 100, 100)
112:             .BorderWidth = 0
113:             .Visible     = .T.
114: 
115:             .AddObject("lbl_4c_Sombra", "Label")
116:             WITH .lbl_4c_Sombra
117:                 .Top       = 22
118:                 .Left      = 22
119:                 .Width     = THIS.Width
120:                 .Height    = 30
121:                 .Caption   = "Relat" + CHR(243) + "rio de Mapa de Comiss" + CHR(227) + "o"
122:                 .FontName  = "Tahoma"
123:                 .FontSize  = 14
124:                 .FontBold  = .T.
125:                 .ForeColor = RGB(0, 0, 0)
126:                 .BackStyle = 0
127:                 .Visible   = .T.
128:             ENDWITH
129: 
130:             .AddObject("lbl_4c_Titulo", "Label")
131:             WITH .lbl_4c_Titulo
132:                 .Top       = 20
133:                 .Left      = 20
134:                 .Width     = THIS.Width
135:                 .Height    = 30
136:                 .Caption   = "Relat" + CHR(243) + "rio de Mapa de Comiss" + CHR(227) + "o"
137:                 .FontName  = "Tahoma"
138:                 .FontSize  = 14
139:                 .FontBold  = .T.
140:                 .ForeColor = RGB(255, 255, 255)

*-- Linhas 236 a 840:
236:         ENDWITH
237: 
238:         loc_oCmg = loc_oCab.cmg_4c_Botoes
239:         BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnVisualizarClick")
240:         BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnImprimirClick")
241:         BINDEVENT(loc_oCmg.Buttons(3), "Click", THIS, "BtnGerarExcelClick")
242:         BINDEVENT(loc_oCmg.Buttons(4), "Click", THIS, "BtnCancelarClick")
243:     ENDPROC
244: 
245:     *--------------------------------------------------------------------------
246:     * ConfigurarPageFrame - PageFrame com 1 pagina (Filtros)
247:     *   Form: Width=700, Height=300
248:     *   Cabecalho Height=80; PageFrame.Top=85, Height=215, Width=702
249:     *--------------------------------------------------------------------------
250:     PROTECTED PROCEDURE ConfigurarPageFrame()
251:         LOCAL loc_oPgf
252: 
253:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
254:         loc_oPgf = THIS.pgf_4c_Paginas
255: 
256:         loc_oPgf.PageCount = 1
257:         loc_oPgf.Top       = 85
258:         loc_oPgf.Left      = -1
259:         loc_oPgf.Width     = THIS.Width + 2
260:         loc_oPgf.Height    = THIS.Height - 85
261:         loc_oPgf.Tabs      = .F.
262: 
263:         loc_oPgf.Page1.Caption   = "Filtros"
264:         loc_oPgf.Page1.FontName  = "Tahoma"
265:         loc_oPgf.Page1.FontSize  = 8
266:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
267:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
268:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
269: 
270:         loc_oPgf.Visible    = .T.
271:         loc_oPgf.ActivePage = 1
272:     ENDPROC
273: 
274:     *--------------------------------------------------------------------------
275:     * AlternarPagina - Ativa a pagina informada (form REPORT tem so Page1).
276:     *--------------------------------------------------------------------------
277:     PROCEDURE AlternarPagina(par_nPagina)
278:         LOCAL loc_nPagina, loc_oErro
279:         TRY
280:             loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
281:             IF loc_nPagina < 1 OR loc_nPagina > THIS.pgf_4c_Paginas.PageCount
282:                 loc_nPagina = 1
283:             ENDIF
284:             THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
285:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_Codigo", 5)
286:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Codigo.SetFocus()
287:             ENDIF
288:         CATCH TO loc_oErro
289:             MsgErro(loc_oErro.Message, "Erro ao Alternar P" + CHR(225) + "gina")
290:         ENDTRY
291:     ENDPROC
292: 
293:     *--------------------------------------------------------------------------
294:     * ConfigurarPaginaLista - Adiciona controles de filtro na Page1
295:     *   Say1 ("Codigo do Relatorio :"): orig Top=160, Left=156 -> Page1 Top=75, Left=156
296:     *   getCods (txt_4c_Codigo)       : orig Top=156, Left=264 -> Page1 Top=71, Left=264
297:     *   Say2 ("Vendedor :")           : orig Top=186, Left=204 -> Page1 Top=101, Left=204
298:     *   getCodVens (txt_4c_CodVens)   : orig Top=182, Left=264 -> Page1 Top=97,  Left=264
299:     *--------------------------------------------------------------------------
300:     PROTECTED PROCEDURE ConfigurarPaginaLista()
301:         LOCAL loc_oPagina
302:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
303: 
304:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
305:         WITH loc_oPagina.lbl_4c_Label1
306:             .Top       = 75
307:             .Left      = 156
308:             .Width     = 106
309:             .Height    = 18
310:             .Caption   = "C" + CHR(243) + "digo do Relat" + CHR(243) + "rio :"
311:             .FontName  = "Tahoma"
312:             .FontSize  = 8
313:             .ForeColor = RGB(90, 90, 90)
314:             .BackStyle = 0
315:             .Visible   = .T.
316:         ENDWITH
317: 
318:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
319:         WITH loc_oPagina.txt_4c_Codigo
320:             .Top           = 71
321:             .Left          = 264
322:             .Width         = 290
323:             .Height        = 23
324:             .Value         = ""
325:             .MaxLength     = 40
326:             .SpecialEffect = 1
327:             .FontName      = "Tahoma"
328:             .FontSize      = 8
329:             .ForeColor     = RGB(0, 0, 0)
330:             .BorderStyle   = 1
331:             .Visible       = .T.
332:         ENDWITH
333:         BINDEVENT(loc_oPagina.txt_4c_Codigo, "KeyPress", THIS, "TeclaLookupCodigo")
334: 
335:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
336:         WITH loc_oPagina.lbl_4c_Label2
337:             .Top       = 101
338:             .Left      = 204
339:             .Width     = 58
340:             .Height    = 18
341:             .Caption   = "Vendedor :"
342:             .FontName  = "Tahoma"
343:             .FontSize  = 8
344:             .ForeColor = RGB(90, 90, 90)
345:             .BackStyle = 0
346:             .Visible   = .T.
347:         ENDWITH
348: 
349:         loc_oPagina.AddObject("txt_4c_CodVens", "TextBox")
350:         WITH loc_oPagina.txt_4c_CodVens
351:             .Top           = 97
352:             .Left          = 264
353:             .Width         = 80
354:             .Height        = 23
355:             .Value         = ""
356:             .MaxLength     = 10
357:             .SpecialEffect = 1
358:             .FontName      = "Tahoma"
359:             .FontSize      = 8
360:             .ForeColor     = RGB(0, 0, 0)
361:             .BorderStyle   = 1
362:             .Visible       = .T.
363:         ENDWITH
364:         BINDEVENT(loc_oPagina.txt_4c_CodVens, "KeyPress", THIS, "TeclaVendedor")
365:     ENDPROC
366: 
367:     *--------------------------------------------------------------------------
368:     * ConfigurarPaginaDados - Form REPORT: pre-inicializa cursores de trabalho do BO
369:     *   Sem Page2 de edicao; filtros estao em ConfigurarPaginaLista().
370:     *   Pre-criar os cursores aqui garante que estejam prontos antes do primeiro
371:     *   clique em Visualizar/Imprimir/DocExcel, sem espera extra no momento da acao.
372:     *--------------------------------------------------------------------------
373:     PROTECTED PROCEDURE ConfigurarPaginaDados()
374:         LOCAL loc_oErro
375:         TRY
376:             IF VARTYPE(THIS.this_oRelatorio) = "O"
377:                 THIS.this_oRelatorio.InicializarCursores()
378:             ENDIF
379:         CATCH TO loc_oErro
380:             MsgErro(loc_oErro.Message, "Erro ao inicializar cursores do relat" + CHR(243) + "rio")
381:         ENDTRY
382:         RETURN .T.
383:     ENDPROC
384: 
385:     *--------------------------------------------------------------------------
386:     * LimparCampos - Inicializa filtros com valores em branco
387:     *--------------------------------------------------------------------------
388:     PROCEDURE LimparCampos()
389:         LOCAL loc_oPagina
390:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
391:         WITH loc_oPagina
392:             .txt_4c_Codigo.Value  = ""
393:             .txt_4c_CodVens.Value = ""
394:         ENDWITH
395:     ENDPROC
396: 
397:     *--------------------------------------------------------------------------
398:     * FormParaRelatorio - Copia valores do form para o BO antes de processar
399:     *--------------------------------------------------------------------------
400:     PROTECTED PROCEDURE FormParaRelatorio()
401:         LOCAL loc_oPagina
402:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
403:         WITH THIS.this_oRelatorio
404:             .this_cCodMapa = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
405:             .this_cCodVens = ALLTRIM(loc_oPagina.txt_4c_CodVens.Value)
406:         ENDWITH
407:     ENDPROC
408: 
409:     *--------------------------------------------------------------------------
410:     * BtnVisualizarClick - Preview do relatorio na tela
411:     *--------------------------------------------------------------------------
412:     PROCEDURE BtnVisualizarClick()
413:         LOCAL loc_oErro, loc_lContinuar
414:         loc_lContinuar = .T.
415:         TRY
416:             IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Codigo.Value))
417:                 MsgAviso("Informe o C" + CHR(243) + "digo do Relat" + CHR(243) + "rio.", ;
418:                          "Valida" + CHR(231) + CHR(227) + "o")
419:                 loc_lContinuar = .F.
420:             ENDIF
421:             IF loc_lContinuar
422:                 THIS.FormParaRelatorio()
423:                 IF !THIS.this_oRelatorio.Visualizar()
424:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
425:                             "Erro ao Visualizar")
426:                 ENDIF
427:             ENDIF
428:         CATCH TO loc_oErro
429:             MsgErro(loc_oErro.Message + CHR(13) + ;
430:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
431:         ENDTRY
432:     ENDPROC
433: 
434:     *--------------------------------------------------------------------------
435:     * BtnImprimirClick - Imprime relatorio com dialogo de impressora
436:     *--------------------------------------------------------------------------
437:     PROCEDURE BtnImprimirClick()
438:         LOCAL loc_oErro, loc_lContinuar
439:         loc_lContinuar = .T.
440:         TRY
441:             IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Codigo.Value))
442:                 MsgAviso("Informe o C" + CHR(243) + "digo do Relat" + CHR(243) + "rio.", ;
443:                          "Valida" + CHR(231) + CHR(227) + "o")
444:                 loc_lContinuar = .F.
445:             ENDIF
446:             IF loc_lContinuar
447:                 THIS.FormParaRelatorio()
448:                 IF !THIS.this_oRelatorio.Imprimir()
449:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
450:                             "Erro ao Imprimir")
451:                 ENDIF
452:             ENDIF
453:         CATCH TO loc_oErro
454:             MsgErro(loc_oErro.Message + CHR(13) + ;
455:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
456:         ENDTRY
457:     ENDPROC
458: 
459:     *--------------------------------------------------------------------------
460:     * BtnGerarExcelClick - Gera documento Excel com os dados do relatorio
461:     *   Equivalente ao PROCEDURE documentoexcel do original
462:     *--------------------------------------------------------------------------
463:     PROCEDURE BtnGerarExcelClick()
464:         LOCAL loc_oErro, loc_lContinuar
465:         loc_lContinuar = .T.
466:         TRY
467:             IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Codigo.Value))
468:                 MsgAviso("Informe o C" + CHR(243) + "digo do Relat" + CHR(243) + "rio.", ;
469:                          "Valida" + CHR(231) + CHR(227) + "o")
470:                 loc_lContinuar = .F.
471:             ENDIF
472:             IF loc_lContinuar
473:                 THIS.FormParaRelatorio()
474:                 IF !THIS.this_oRelatorio.GerarExcel()
475:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
476:                             "Erro ao Gerar Documento Excel")
477:                 ENDIF
478:             ENDIF
479:         CATCH TO loc_oErro
480:             MsgErro(loc_oErro.Message + CHR(13) + ;
481:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
482:         ENDTRY
483:     ENDPROC
484: 
485:     *--------------------------------------------------------------------------
486:     * BtnCancelarClick - Fecha o formulario (ESC via Buttons(4).Cancel=.T.)
487:     *--------------------------------------------------------------------------
488:     PROCEDURE BtnCancelarClick()
489:         THIS.Release()
490:     ENDPROC
491: 
492:     *--------------------------------------------------------------------------
493:     * Aliases de interface CRUD exigidos pelo pipeline multi-fase
494:     *   Form REPORT nao tem CRUD; cada alias delega para a acao de relatorio
495:     *   equivalente (Visualizar/Imprimir/Cancelar) preservando contrato FormBase.
496:     *--------------------------------------------------------------------------
497:     PROCEDURE BtnIncluirClick()
498:         *-- Em forms REPORT "Incluir" = gerar nova saida impressa
499:         THIS.BtnImprimirClick()
500:     ENDPROC
501: 
502:     PROCEDURE BtnAlterarClick()
503:         *-- Em forms REPORT "Alterar" = revisar/visualizar dados na tela
504:         THIS.BtnVisualizarClick()
505:     ENDPROC
506: 
507:     PROCEDURE BtnExcluirClick()
508:         *-- Em forms REPORT "Excluir" = limpar filtros antes de nova consulta
509:         THIS.LimparCampos()
510:         IF VARTYPE(THIS.this_oRelatorio) = "O"
511:             THIS.this_oRelatorio.this_cCodMapa = ""
512:             THIS.this_oRelatorio.this_cCodVens = ""
513:         ENDIF
514:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_Codigo", 5)
515:             THIS.pgf_4c_Paginas.Page1.txt_4c_Codigo.SetFocus()
516:         ENDIF
517:     ENDPROC
518: 
519:     PROCEDURE BtnBuscarClick()
520:         THIS.BtnVisualizarClick()
521:     ENDPROC
522: 
523:     PROCEDURE BtnEncerrarClick()
524:         THIS.Release()
525:     ENDPROC
526: 
527:     PROCEDURE BtnSalvarClick()
528:         THIS.BtnImprimirClick()
529:     ENDPROC
530: 
531:     PROCEDURE BtnConsultarClick()
532:         THIS.BtnVisualizarClick()
533:     ENDPROC
534: 
535:     *--------------------------------------------------------------------------
536:     * FormParaBO / BOParaForm - Aliases para a interface generica FormBase
537:     *--------------------------------------------------------------------------
538:     PROTECTED PROCEDURE FormParaBO()
539:         THIS.FormParaRelatorio()
540:     ENDPROC
541: 
542:     PROTECTED PROCEDURE BOParaForm()
543:         LOCAL loc_oPg, loc_oErro
544:         TRY
545:             IF VARTYPE(THIS.this_oRelatorio) = "O"
546:                 loc_oPg = THIS.pgf_4c_Paginas.Page1
547:                 WITH THIS.this_oRelatorio
548:                     loc_oPg.txt_4c_Codigo.Value  = ALLTRIM(NVL(.this_cCodMapa, ""))
549:                     loc_oPg.txt_4c_CodVens.Value = ALLTRIM(NVL(.this_cCodVens, ""))
550:                 ENDWITH
551:             ENDIF
552:         CATCH TO loc_oErro
553:             MsgErro(loc_oErro.Message, "Erro em BOParaForm")
554:         ENDTRY
555:     ENDPROC
556: 
557:     *--------------------------------------------------------------------------
558:     * HabilitarCampos - Habilita ou desabilita os campos de filtro
559:     *--------------------------------------------------------------------------
560:     PROCEDURE HabilitarCampos(par_lHabilitar)
561:         LOCAL loc_oPg, loc_lHab, loc_oErro
562:         TRY
563:             loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
564:             loc_oPg  = THIS.pgf_4c_Paginas.Page1
565:             IF VARTYPE(loc_oPg) = "O"
566:                 IF PEMSTATUS(loc_oPg, "txt_4c_Codigo", 5)
567:                     loc_oPg.txt_4c_Codigo.ReadOnly = !loc_lHab
568:                 ENDIF
569:                 IF PEMSTATUS(loc_oPg, "txt_4c_CodVens", 5)
570:                     loc_oPg.txt_4c_CodVens.ReadOnly = !loc_lHab
571:                 ENDIF
572:             ENDIF
573:         CATCH TO loc_oErro
574:             MsgErro(loc_oErro.Message, "Erro em HabilitarCampos")
575:         ENDTRY
576:     ENDPROC
577: 
578:     *--------------------------------------------------------------------------
579:     * CarregarLista - Stub de compatibilidade (forms REPORT nao tem grid CRUD)
580:     *--------------------------------------------------------------------------
581:     PROCEDURE CarregarLista()
582:         RETURN .T.
583:     ENDPROC
584: 
585:     *--------------------------------------------------------------------------
586:     * AjustarBotoesPorModo - Todos os botoes ficam sempre habilitados em REPORT
587:     *--------------------------------------------------------------------------
588:     PROCEDURE AjustarBotoesPorModo()
589:         LOCAL loc_oCmg, loc_oErro, loc_nI
590:         TRY
591:             IF VARTYPE(THIS.cnt_4c_Cabecalho) = "O" AND ;
592:                PEMSTATUS(THIS.cnt_4c_Cabecalho, "cmg_4c_Botoes", 5)
593:                 loc_oCmg = THIS.cnt_4c_Cabecalho.cmg_4c_Botoes
594:                 FOR loc_nI = 1 TO loc_oCmg.ButtonCount
595:                     loc_oCmg.Buttons(loc_nI).Enabled = .T.
596:                 ENDFOR
597:             ENDIF
598:         CATCH TO loc_oErro
599:             MsgErro(loc_oErro.Message, "Erro em AjustarBotoesPorModo")
600:         ENDTRY
601:     ENDPROC
602: 
603:     *--------------------------------------------------------------------------
604:     * TeclaLookupCodigo - KeyPress em txt_4c_Codigo (getCods)
605:     *   F4(115): abre lookup de mapa de comissao (SigCmCab)
606:     *   ENTER(13)/TAB(9): valida codigo digitado
607:     *--------------------------------------------------------------------------
608:     PROCEDURE TeclaLookupCodigo(par_nKeyCode, par_nShift)
609:         IF par_nKeyCode = 115
610:             THIS.AbrirBuscaCodigo()
611:         ENDIF
612:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
613:             THIS.ValidarCodigo()
614:         ENDIF
615:     ENDPROC
616: 
617:     *--------------------------------------------------------------------------
618:     * AbrirBuscaCodigo - Lookup de mapa de comissao (SigCmCab)
619:     *   Equivalente ao getCods.Valid com fwBuscaInt do original.
620:     *   Filtra por empresa (go_4c_Sistema.cCodEmpresa), substituindo fAcessoEmpresa.
621:     *   Colunas: Cods, Emps, DtInis, DtFims
622:     *--------------------------------------------------------------------------
623:     PROCEDURE AbrirBuscaCodigo()
624:         LOCAL loc_oPagina, loc_cSQL, loc_nResult, loc_oBusca, loc_oErro
625:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
626:         TRY
627:             loc_cSQL = "SELECT Cods, Emps, DtInis, DtFims FROM SigCmCab " + ;
628:                        "WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
629:                        " ORDER BY Cods"
630:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MapaBusca")
631: 
632:             IF loc_nResult > 0
633:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
634:                 IF VARTYPE(loc_oBusca) = "O"
635:                     loc_oBusca.this_cCursorDestino = "cursor_4c_MapaBusca"
636:                     loc_oBusca.this_cTitulo = "Selecionar Mapa de Comiss" + CHR(227) + "o"
637:                     loc_oBusca.mAddColuna("Cods",   "", ;
638:                         "C" + CHR(243) + "digo do Relat" + CHR(243) + "rio")
639:                     loc_oBusca.mAddColuna("Emps",   "", "Emp")
640:                     loc_oBusca.mAddColuna("DtInis", "99/99/9999", "Dt.Inicial")
641:                     loc_oBusca.mAddColuna("DtFims", "99/99/9999", "Dt.Final")
642:                     loc_oBusca.Show()
643: 
644:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_MapaBusca")
645:                         SELECT cursor_4c_MapaBusca
646:                         loc_oPagina.txt_4c_Codigo.Value  = ALLTRIM(Cods)
647:                         loc_oPagina.txt_4c_CodVens.Value = ""
648:                     ENDIF
649:                     loc_oBusca.Release()
650:                 ELSE
651:                     MsgErro("Erro ao criar janela de busca de Mapa.", "Erro")
652:                 ENDIF
653:             ELSE
654:                 MsgErro("Erro ao buscar mapas de comiss" + CHR(227) + "o.", "Erro")
655:             ENDIF
656: 
657:             IF USED("cursor_4c_MapaBusca")
658:                 USE IN cursor_4c_MapaBusca
659:             ENDIF
660: 
661:         CATCH TO loc_oErro
662:             MsgErro(loc_oErro.Message, "Erro ao Buscar Mapa de Comiss" + CHR(227) + "o")
663:             IF USED("cursor_4c_MapaBusca")
664:                 USE IN cursor_4c_MapaBusca
665:             ENDIF
666:         ENDTRY
667:     ENDPROC
668: 
669:     *--------------------------------------------------------------------------
670:     * ValidarCodigo - Valida codigo do mapa digitado (ENTER/TAB)
671:     *   Se o mapa nao existir para a empresa corrente, limpa e abre lookup
672:     *--------------------------------------------------------------------------
673:     PROCEDURE ValidarCodigo()
674:         LOCAL loc_oPagina, loc_cValor, loc_cSQL, loc_nResult, loc_lEncontrou, loc_oErro
675:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
676:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
677: 
678:         IF EMPTY(loc_cValor)
679:             loc_oPagina.txt_4c_CodVens.Value = ""
680:             RETURN
681:         ENDIF
682: 
683:         TRY
684:             loc_cSQL = "SELECT Cods FROM SigCmCab " + ;
685:                        "WHERE Cods = " + EscaparSQL(PADR(loc_cValor, 40)) + ;
686:                        " AND Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
687:             loc_nResult   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CodVal")
688:             loc_lEncontrou = loc_nResult > 0 AND RECCOUNT("cursor_4c_CodVal") > 0
689:             IF USED("cursor_4c_CodVal")
690:                 USE IN cursor_4c_CodVal
691:             ENDIF
692:             IF !loc_lEncontrou
693:                 loc_oPagina.txt_4c_Codigo.Value  = ""
694:                 loc_oPagina.txt_4c_CodVens.Value = ""
695:                 THIS.AbrirBuscaCodigo()
696:             ENDIF
697:         CATCH TO loc_oErro
698:             MsgErro(loc_oErro.Message, "Erro ao Validar C" + CHR(243) + "digo")
699:             IF USED("cursor_4c_CodVal")
700:                 USE IN cursor_4c_CodVal
701:             ENDIF
702:         ENDTRY
703:     ENDPROC
704: 
705:     *--------------------------------------------------------------------------
706:     * TeclaVendedor - KeyPress em txt_4c_CodVens (getCodVens)
707:     *   Equivalente ao getCodVens.When + getCodVens.Valid do original.
708:     *   Bloqueia interacao quando getCods esta vazio (como getCodVens.When original).
709:     *   F4(115): abre lookup de vendedor
710:     *   ENTER(13)/TAB(9): valida codigo digitado
711:     *--------------------------------------------------------------------------
712:     PROCEDURE TeclaVendedor(par_nKeyCode, par_nShift)
713:         IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Codigo.Value))
714:             MsgAviso("Selecione primeiro o C" + CHR(243) + "digo do Relat" + CHR(243) + "rio.", ;
715:                      "Aten" + CHR(231) + CHR(227) + "o")
716:             RETURN
717:         ENDIF
718:         IF par_nKeyCode = 115
719:             THIS.AbrirBuscaVendedor()
720:         ENDIF
721:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
722:             THIS.ValidarVendedor()
723:         ENDIF
724:     ENDPROC
725: 
726:     *--------------------------------------------------------------------------
727:     * AbrirBuscaVendedor - Lookup de vendedor do mapa selecionado
728:     *   Equivalente ao getCodVens.Valid com fwBuscaInt do original.
729:     *   Carrega join SigCmCab/SigCmItn/SigCdCli filtrado pelo Cods selecionado.
730:     *   Colunas: CodVens, RClis, VMetas, CodResps
731:     *--------------------------------------------------------------------------
732:     PROCEDURE AbrirBuscaVendedor()
733:         LOCAL loc_oPagina, loc_cCodMapa, loc_cSQL, loc_nResult, loc_oBusca, loc_oErro
734:         loc_oPagina  = THIS.pgf_4c_Paginas.Page1
735:         loc_cCodMapa = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
736: 
737:         IF EMPTY(loc_cCodMapa)
738:             MsgAviso("Selecione primeiro o C" + CHR(243) + "digo do Relat" + CHR(243) + "rio.", ;
739:                      "Aten" + CHR(231) + CHR(227) + "o")
740:             RETURN
741:         ENDIF
742: 
743:         TRY
744:             loc_cSQL = "Select b.CodVens, c.RClis, b.VMetas, b.CodResps " + ;
745:                        "From SigCmCab a, SigCmItn b, SigCdCli c " + ;
746:                        "Where a.Cods = " + EscaparSQL(PADR(loc_cCodMapa, 40)) + " And " + ;
747:                        "a.pkChaves = b.fkChaves And b.Tipos = 'VEN' And b.CodVens = c.IClis"
748:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VenBusca")
749: 
750:             IF loc_nResult > 0
751:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
752:                 IF VARTYPE(loc_oBusca) = "O"
753:                     loc_oBusca.this_cCursorDestino = "cursor_4c_VenBusca"
754:                     loc_oBusca.this_cTitulo = "Selecionar Vendedor"
755:                     loc_oBusca.mAddColuna("CodVens",  "",             "Vendedor")
756:                     loc_oBusca.mAddColuna("RClis",    "",             "Nome")
757:                     loc_oBusca.mAddColuna("VMetas",   "99999,999.99", "Meta")
758:                     loc_oBusca.mAddColuna("CodResps", "",             "Respons" + CHR(225) + "vel")
759:                     loc_oBusca.Show()
760: 
761:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_VenBusca")
762:                         SELECT cursor_4c_VenBusca
763:                         loc_oPagina.txt_4c_CodVens.Value = ALLTRIM(CodVens)
764:                     ENDIF
765:                     loc_oBusca.Release()
766:                 ELSE
767:                     MsgErro("Erro ao criar janela de busca de Vendedor.", "Erro")
768:                 ENDIF
769:             ELSE
770:                 MsgErro("Erro ao buscar vendedores do mapa.", "Erro")
771:             ENDIF
772: 
773:             IF USED("cursor_4c_VenBusca")
774:                 USE IN cursor_4c_VenBusca
775:             ENDIF
776: 
777:         CATCH TO loc_oErro
778:             MsgErro(loc_oErro.Message, "Erro ao Buscar Vendedor")
779:             IF USED("cursor_4c_VenBusca")
780:                 USE IN cursor_4c_VenBusca
781:             ENDIF
782:         ENDTRY
783:     ENDPROC
784: 
785:     *--------------------------------------------------------------------------
786:     * ValidarVendedor - Valida codigo do vendedor digitado (ENTER/TAB)
787:     *   Verifica se o vendedor pertence ao mapa de comissao selecionado.
788:     *   Se nao encontrar, limpa o campo e abre o lookup.
789:     *--------------------------------------------------------------------------
790:     PROCEDURE ValidarVendedor()
791:         LOCAL loc_oPagina, loc_cCodMapa, loc_cCodVens
792:         LOCAL loc_cSQL, loc_nResult, loc_lEncontrou, loc_oErro
793:         loc_oPagina  = THIS.pgf_4c_Paginas.Page1
794:         loc_cCodMapa = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
795:         loc_cCodVens = ALLTRIM(loc_oPagina.txt_4c_CodVens.Value)
796: 
797:         IF EMPTY(loc_cCodMapa)
798:             loc_oPagina.txt_4c_CodVens.Value = ""
799:             RETURN
800:         ENDIF
801:         IF EMPTY(loc_cCodVens)
802:             RETURN
803:         ENDIF
804: 
805:         TRY
806:             loc_cSQL = "Select b.CodVens " + ;
807:                        "From SigCmCab a, SigCmItn b, SigCdCli c " + ;
808:                        "Where a.Cods = " + EscaparSQL(PADR(loc_cCodMapa, 40)) + " And " + ;
809:                        "a.pkChaves = b.fkChaves And b.Tipos = 'VEN' And " + ;
810:                        "b.CodVens = c.IClis And b.CodVens = " + ;
811:                        EscaparSQL(PADR(loc_cCodVens, 10))
812:             loc_nResult   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VenVal")
813:             loc_lEncontrou = loc_nResult > 0 AND RECCOUNT("cursor_4c_VenVal") > 0
814:             IF USED("cursor_4c_VenVal")
815:                 USE IN cursor_4c_VenVal
816:             ENDIF
817:             IF !loc_lEncontrou
818:                 loc_oPagina.txt_4c_CodVens.Value = ""
819:                 THIS.AbrirBuscaVendedor()
820:             ENDIF
821:         CATCH TO loc_oErro
822:             MsgErro(loc_oErro.Message, "Erro ao Validar Vendedor")
823:             IF USED("cursor_4c_VenVal")
824:                 USE IN cursor_4c_VenVal
825:             ENDIF
826:         ENDTRY
827:     ENDPROC
828: 
829:     *--------------------------------------------------------------------------
830:     * Destroy - Libera referencia ao BO
831:     *   RelatorioBase herda de Custom (sem Release()) - usar .NULL. para liberar
832:     *--------------------------------------------------------------------------
833:     PROCEDURE Destroy()
834:         IF VARTYPE(THIS.this_oRelatorio) = "O"
835:             THIS.this_oRelatorio = .NULL.
836:         ENDIF
837:         DODEFAULT()
838:     ENDPROC
839: 
840: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigrecmmBO.prg):
*==============================================================================
* SIGRECMMBO.PRG
* Business Object para Relatorio de Mapa de Comissao Por Vendedor
*
* Herda de RelatorioBase
* Formulario original: SIGRECMM.SCX (frmrelatorio)
* Tabelas: SigCmCab, SigCmItn, SigMvCab, SigMvItn, SigCdOpe,
*           SigCdPro, SigMvPar, SigOpFp, SigCdCli, SigCdTom
*==============================================================================

DEFINE CLASS sigrecmmBO AS RelatorioBase

    *-- Filtros do relatorio
    this_cCodMapa    = ""   && getCods  - Codigo do Relatorio (SigCmCab.Cods) MaxLength=40
    this_cCodVens    = ""   && getCodVens - Codigo do Vendedor filtro MaxLength=10

    *-- Nomes dos cursores de trabalho
    this_cCursorAnalitico  = "cursor_4c_Analitico"
    this_cCursorImpressao  = "cursor_4c_Impressao"
    this_cCursorCabecalho  = "cursor_4c_Cabecalho"
    this_cCursorExcel      = "cursor_4c_Excel"

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro da ultima operacao
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursores - Cria os cursores de trabalho do relatorio
    * Equivalente ao Load do frmrelatorio original
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursores()
        LOCAL loc_oErro
        TRY
            IF USED(THIS.this_cCursorAnalitico)
                USE IN (THIS.this_cCursorAnalitico)
            ENDIF
            IF USED(THIS.this_cCursorImpressao)
                USE IN (THIS.this_cCursorImpressao)
            ENDIF
            IF USED(THIS.this_cCursorCabecalho)
                USE IN (THIS.this_cCursorCabecalho)
            ENDIF
            IF USED(THIS.this_cCursorExcel)
                USE IN (THIS.this_cCursorExcel)
            ENDIF

            CREATE CURSOR cursor_4c_Analitico ;
                (CodVens   C(10), Datas     D(8),    EmpDopNums C(29), ;
                 Cpros      C(14), Mercs     C(3),    CGrus      C(3),  ;
                 SGrus      C(6),  FPags     C(12),   ValVdaCom  N(12,2), ;
                 ValComiss  N(12,2), TpComiss C(3),   PctComiss  N(12,2), ;
                 CodFaixas  N(2),   Apagar   C(1))

            CREATE CURSOR cursor_4c_Impressao ;
                (Datas C(10), V01 N(12,2), V02 N(12,2), V03 N(12,2), V04 N(12,2), ;
                 V05 N(12,2), V06 N(12,2), V07 N(12,2), V08 N(12,2), V09 N(12,2), ;
                 V10 N(12,2), V11 N(12,2), V12 N(12,2), V13 N(13,2), TotalV N(12,2))

            CREATE CURSOR cursor_4c_Cabecalho ;
                (V01 M(4), V02 M(4), V03 M(4), V04 M(4), V05 M(4), V06 M(4), ;
                 V07 M(4), V08 M(4), V09 M(4), V10 M(4), V11 M(4), V12 M(4), ;
                 V13 M(4), TotalV M(4), Titulo C(254), Subtitulo C(254), ;
                 Periodo C(254), Datas M(4))

            CREATE CURSOR cursor_4c_Excel ;
                (Datas C(10), V01 C(12), V02 C(12), V03 C(12), V04 C(12), ;
                 V05 C(12), V06 C(12), V07 C(12), V08 C(12), V09 C(12), ;
                 V10 C(12), V11 C(12), V12 C(12), V13 C(12), TotalV C(12))

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FecharCursores - Fecha todos os cursores de trabalho
    *--------------------------------------------------------------------------
    PROCEDURE FecharCursores()
        IF USED(THIS.this_cCursorAnalitico)
            USE IN (THIS.this_cCursorAnalitico)
        ENDIF
        IF USED(THIS.this_cCursorImpressao)
            USE IN (THIS.this_cCursorImpressao)
        ENDIF
        IF USED(THIS.this_cCursorCabecalho)
            USE IN (THIS.this_cCursorCabecalho)
        ENDIF
        IF USED(THIS.this_cCursorExcel)
            USE IN (THIS.this_cCursorExcel)
        ENDIF
        IF USED("crVendas")
            USE IN crVendas
        ENDIF
        IF USED("crSintetico")
            USE IN crSintetico
        ENDIF
        IF USED("crResps")
            USE IN crResps
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa o mapa de comissao por vendedor
    * Equivalente ao PROCEDURE processamento do frmrelatorio original
    * Popula: cursor_4c_Analitico, cursor_4c_Impressao, cursor_4c_Cabecalho
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cSQL, loc_nResult
        LOCAL loc_lcPrc, loc_lcFvd
        LOCAL loc_pDtI, loc_pDtF
        LOCAL loc_lnPro, loc_lnPct, loc_lnTtl, loc_lnPag, loc_lnCpg
        LOCAL loc_lnPg1, loc_lnCm1, loc_lcTip, loc_lcTip2
        LOCAL loc_lnGe1, loc_lnGe2, loc_lnDif
        LOCAL loc_lcEdn, loc_lcVen, loc_lnVal, loc_lnCmR
        LOCAL loc_lcCol, loc_lcNom, loc_lcSub, loc_lcTit, loc_lcPer
        LOCAL loc_lnVvd, loc_lnVmt, loc_lnAti, loc_lnDia, loc_ldDat
        LOCAL loc_lnCnt, loc_llAti, loc_nI
        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cCodMapa)
                THIS.this_cMensagemErro = "Informe o C" + CHR(243) + "digo do Relat" + CHR(243) + "rio"
                loc_lResultado = .F.
            ENDIF

            THIS.InicializarCursores()

            SELECT cursor_4c_Analitico
            ZAP
            SELECT cursor_4c_Impressao
            ZAP
            SELECT cursor_4c_Cabecalho
            ZAP

            loc_lcPrc = PADR(THIS.this_cCodMapa, 40)
            loc_lcFvd = PADR(THIS.this_cCodVens, 10)

            *-- Cabecalho da Tabela de Comissao Selecionada
            loc_cSQL = "Select a.* " + ;
                       "From SigCmCab a " + ;
                       "Where a.Cods = " + EscaparSQL(loc_lcPrc)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalCmCab")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar cabe" + CHR(231) + CHR(227) + "lho do mapa (LocalCmCab)"
                MsgErro(THIS.this_cMensagemErro, "Erro")
                loc_lResultado = .F.
            ENDIF
            SELECT LocalCmCab
            GO TOP

            loc_pDtI = FormatarDataSQL(LocalCmCab.DtInis)
            loc_pDtF = FormatarDataSQL(LocalCmCab.DtFims)

            *-- Todas as Vendas do Periodo Selecionadas que Pagam Comissao
            loc_cSQL = "Select a.Datas, a.EmpDopNums, a.Valos, a.ValVars, a.Vends, a.Resps, " + ;
                       "b.CPros, b.Moedas, b.MoeVals, b.Opers, b.Totas, c.Mercs, c.CGrus, c.SGrus " + ;
                       "From SigCdOpe d " + ;
                       "Inner Join SigMvCab a On d.Dopes = a.Dopes " + ;
                       "Left Join SigMvItn b On a.EmpDopNums = b.EmpDopNums " + ;
                       "Left Join SigCdPro c On b.Cpros = c.CPros " + ;
                       "Where a.Datas Between " + loc_pDtI + " And " + loc_pDtF + " And " + ;
                       "a.Emps = '" + ALLTRIM(LocalCmCab.Emps) + "' And " + ;
                       "a.LCancelas = 0 And a.Valos <> 0 And " + ;
                       "(b.Opers = 'S' Or (b.Opers = 'E' And d.CalcFecs = 1)) And " + ;
                       "d.Dopes In (" + ;
                       "Select o.Dopes From SigCdTom t, SigCdOpe o " + ;
                       "Where t.nChkSdfs = 1 And t.Codigos = o.TipoOps) " + ;
                       "Order By a.EmpDopNums"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalVendas")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar vendas do per" + CHR(237) + "odo (LocalVendas)"
                MsgErro(THIS.this_cMensagemErro, "Erro")
                IF USED("LocalCmCab")
                    USE IN LocalCmCab
                ENDIF
                loc_lResultado = .F.
            ENDIF

            SELECT LocalVendas
            INDEX ON EmpDopNums TAG EmpDopNums
            UPDATE LocalVendas ;
                SET Valos = Valos * IIF(Opers = "E", -1, 1), ;
                    Totas = Totas * IIF(Opers = "E", -1, 1)

            *-- EmpDopNums das Movimentacoes a Serem Processadas
            SELECT DISTINCT EmpDopNums, ValVars, Opers ;
              FROM LocalVendas ;
              INTO CURSOR LocalEdns READWRITE
            SELECT LocalEdns
            INDEX ON EmpDopNums TAG EmpDopNums

            *-- Loop principal: calcula comissao por movimentacao
            SELECT LocalEdns
            GO TOP
            SCAN
                loc_lcEdn = LocalEdns.EmpDopNums
                loc_lnGe1 = 0
                loc_lnGe2 = 0

                IF LocalEdns.ValVars <> 0
                    SELECT SUM(Totas) AS TotProds ;
                      FROM LocalVendas ;
                     WHERE EmpDopNums = loc_lcEdn ;
                      INTO CURSOR LocalTotProds
                    SELECT LocalTotProds
                    GO TOP
                    loc_lnPro = IIF(EOF(), 0, LocalTotProds.TotProds)
                    USE IN LocalTotProds

                    SELECT LocalVendas
                    SET ORDER TO TAG EmpDopNums
                    SEEK loc_lcEdn
                    SCAN WHILE EmpDopNums = loc_lcEdn
                        loc_lnPct = IIF(loc_lnPro = 0, 0, (LocalVendas.Totas * 100) / loc_lnPro)
                        loc_lnTtl = (LocalEdns.ValVars * loc_lnPct) / 100
                        REPLACE Totas WITH Totas + loc_lnTtl IN LocalVendas
                    ENDSCAN
                ENDIF

                SELECT SUM(Totas) AS TotProds ;
                  FROM LocalVendas ;
                 WHERE EmpDopNums = loc_lcEdn ;
                  INTO CURSOR LocalTotProds
                SELECT LocalTotProds
                GO TOP
                loc_lnPro = IIF(EOF(), 0, LocalTotProds.TotProds)
                USE IN LocalTotProds

                *-- Formas de Pagamento que Pagam Comissao
                loc_cSQL = "Select b.FPags, b.Trocos, Sum(a.Valos * a.CotFpgs) as Valos, b.FPComiss " + ;
                           "From SigMvPar a, SigOpFp b " + ;
                           "Where a.EmpDopNums = " + EscaparSQL(loc_lcEdn) + " And " + ;
                           "a.FPags = b.FPags And Not b.BxComis = 2 " + ;
                           "Group by b.FPags, b.Trocos, b.FPComiss"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalPagtos1")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao carregar pagamentos (LocalPagtos1)"
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    IF USED("LocalCmCab")
                        USE IN LocalCmCab
                    ENDIF
                    IF USED("LocalVendas")
                        USE IN LocalVendas
                    ENDIF
                    IF USED("LocalEdns")
                        USE IN LocalEdns
                    ENDIF
                    loc_lResultado = .F.
                ENDIF
                UPDATE LocalPagtos1 SET Valos = Valos * IIF(LocalEdns.Opers = "E", -1, 1)

                SELECT LocalVendas
                SET ORDER TO TAG EmpDopNums
                SEEK loc_lcEdn
                SCAN WHILE EmpDopNums = loc_lcEdn
                    loc_lnPct = IIF(loc_lnPro = 0, 0, (LocalVendas.Totas * 100) / loc_lnPro)

                    SELECT LocalPagtos1
                    GO TOP
                    IF EOF()
                        loc_lnPag = ((LocalPagtos1.Valos * IIF(LocalPagtos1.Trocos = 1, -1, 1)) * loc_lnPct) / 100

                        IF !EMPTY(LocalVendas.Vends) AND !EMPTY(LocalCmCab.PctVd1)
                            loc_lnPg1 = (loc_lnPag * LocalCmCab.PctVd1) / 100
                            IF EMPTY(LocalVendas.Resps) OR EMPTY(LocalCmCab.PctVd2)
                                loc_lnPg1 = loc_lnPag
                            ENDIF

                            INSERT INTO cursor_4c_Analitico ;
                                (CodVens, Datas, EmpDopNums, Cpros, Mercs, CGrus, SGrus, ;
                                 FPags, ValVdaCom, ValComiss, TpComiss, PctComiss, Apagar) ;
                                VALUES (LocalVendas.Vends, LocalVendas.Datas, LocalVendas.EmpDopNums, ;
                                        LocalVendas.CPros, LocalVendas.Mercs, LocalVendas.CGrus, ;
                                        LocalVendas.SGrus, "NENHUMA", loc_lnPg1, 0, "", 0, "S")
                            loc_lnGe1 = loc_lnGe1 + loc_lnPg1
                            loc_lnGe2 = loc_lnGe2 + cursor_4c_Analitico.ValVdaCom
                        ENDIF

                        IF !EMPTY(LocalVendas.Resps) AND !EMPTY(LocalCmCab.PctVd2)
                            loc_lnPg1 = (loc_lnPag * LocalCmCab.PctVd2) / 100
                            IF EMPTY(LocalVendas.Vends) OR EMPTY(LocalCmCab.PctVd1)
                                loc_lnPg1 = loc_lnPag
                            ENDIF

                            INSERT INTO cursor_4c_Analitico ;
                                (CodVens, Datas, EmpDopNums, Cpros, Mercs, CGrus, SGrus, ;
                                 FPags, ValVdaCom, ValComiss, TpComiss, PctComiss, Apagar) ;
                                VALUES (LocalVendas.Resps, LocalVendas.Datas, LocalVendas.EmpDopNums, ;
                                        LocalVendas.CPros, LocalVendas.Mercs, LocalVendas.CGrus, ;
                                        LocalVendas.SGrus, "NENHUMA", loc_lnPg1, 0, "", 0, "S")
                            loc_lnGe1 = loc_lnGe1 + loc_lnPg1
                            loc_lnGe2 = loc_lnGe2 + cursor_4c_Analitico.ValVdaCom
                        ENDIF
                    ELSE
                        SELECT LocalPagtos1
                        SCAN
                            loc_lnPag = ((LocalPagtos1.Valos * IIF(LocalPagtos1.Trocos = 1, -1, 1)) * loc_lnPct) / 100
                            loc_lnCpg = (loc_lnPag * LocalPagtos1.FPComiss) / 100

                            IF !EMPTY(LocalVendas.Vends) AND !EMPTY(LocalCmCab.PctVd1)
                                loc_lnPg1 = (loc_lnPag * LocalCmCab.PctVd1) / 100
                                loc_lnCm1 = (loc_lnCpg * LocalCmCab.PctVd1) / 100
                                IF EMPTY(LocalVendas.Resps) OR EMPTY(LocalCmCab.PctVd2)
                                    loc_lnPg1 = loc_lnPag
                                    loc_lnCm1 = loc_lnCpg
                                ENDIF
                                loc_lcTip = IIF(EMPTY(loc_lnCm1), "", "PAG")

                                INSERT INTO cursor_4c_Analitico ;
                                    (CodVens, Datas, EmpDopNums, Cpros, Mercs, CGrus, SGrus, ;
                                     FPags, ValVdaCom, ValComiss, TpComiss, PctComiss, Apagar) ;
                                    VALUES (LocalVendas.Vends, LocalVendas.Datas, LocalVendas.EmpDopNums, ;
                                            LocalVendas.CPros, LocalVendas.Mercs, LocalVendas.CGrus, ;
                                            LocalVendas.SGrus, LocalPagtos1.FPags, ;
                                            loc_lnPg1, loc_lnCm1, loc_lcTip, LocalPagtos1.FPComiss, "S")
                                loc_lnGe1 = loc_lnGe1 + loc_lnPg1
                                loc_lnGe2 = loc_lnGe2 + cursor_4c_Analitico.ValVdaCom
                            ENDIF

                            IF !EMPTY(LocalVendas.Resps) AND !EMPTY(LocalCmCab.PctVd2)
                                loc_lnPg1 = (loc_lnPag * LocalCmCab.PctVd2) / 100
                                loc_lnCm1 = (loc_lnCpg * LocalCmCab.PctVd2) / 100
                                IF EMPTY(LocalVendas.Vends) OR EMPTY(LocalCmCab.PctVd1)
                                    loc_lnPg1 = loc_lnPag
                                    loc_lnCm1 = loc_lnCpg
                                ENDIF
                                loc_lcTip = IIF(EMPTY(loc_lnCm1), "", "PAG")

                                INSERT INTO cursor_4c_Analitico ;
                                    (CodVens, Datas, EmpDopNums, Cpros, Mercs, CGrus, SGrus, ;
                                     FPags, ValVdaCom, ValComiss, TpComiss, PctComiss, Apagar) ;
                                    VALUES (LocalVendas.Resps, LocalVendas.Datas, LocalVendas.EmpDopNums, ;
                                            LocalVendas.CPros, LocalVendas.Mercs, LocalVendas.CGrus, ;
                                            LocalVendas.SGrus, LocalPagtos1.FPags, ;
                                            loc_lnPg1, loc_lnCm1, loc_lcTip, LocalPagtos1.FPComiss, "S")
                                loc_lnGe1 = loc_lnGe1 + loc_lnPg1
                                loc_lnGe2 = loc_lnGe2 + cursor_4c_Analitico.ValVdaCom
                            ENDIF
                        ENDSCAN
                    ENDIF
                    SELECT LocalVendas
                ENDSCAN

                IF ROUND(loc_lnGe1, 2) <> loc_lnGe2
                    loc_lnDif = ROUND(loc_lnGe1, 2) - loc_lnGe2
                    SELECT cursor_4c_Analitico
                    GO BOTTOM
                    REPLACE ValVdaCom WITH ValVdaCom + loc_lnDif IN cursor_4c_Analitico
                ENDIF

                IF USED("LocalPagtos1")
                    USE IN LocalPagtos1
                ENDIF
            ENDSCAN

            *-- Produtos da Tabela de Comissao Selecionada
            loc_cSQL = "Select a.Mercs, a.CGrus, a.SGrus, a.PPctFixs " + ;
                       "From SigCmItn a " + ;
                       "Where a.fkChaves = '" + ALLTRIM(LocalCmCab.pkChaves) + "' And a.Tipos = 'PRO'"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalCmPro")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar produtos do mapa (LocalCmPro)"
                MsgErro(THIS.this_cMensagemErro, "Erro")
                IF USED("LocalCmCab")
                    USE IN LocalCmCab
                ENDIF
                IF USED("LocalVendas")
                    USE IN LocalVendas
                ENDIF
                IF USED("LocalEdns")
                    USE IN LocalEdns
                ENDIF
                loc_lResultado = .F.
            ENDIF

            *-- Aplica produtos configurados no mapa (mantendo ou calculando % fixo)
            SELECT LocalCmPro
            SCAN
                DO CASE
                    CASE !EMPTY(LocalCmPro.Mercs) AND !EMPTY(LocalCmPro.CGrus) AND !EMPTY(LocalCmPro.SGrus)
                        UPDATE cursor_4c_Analitico ;
                           SET Apagar   = "N", ;
                               ValComiss = IIF(EMPTY(LocalCmPro.PPctFixs), ValComiss, (ValVdaCom * LocalCmPro.PPctFixs) / 100), ;
                               PctComiss = IIF(EMPTY(LocalCmPro.PPctFixs), PctComiss, LocalCmPro.PPctFixs), ;
                               TpComiss  = IIF(EMPTY(LocalCmPro.PPctFixs), TpComiss, "PRO") ;
                         WHERE Mercs = LocalCmPro.Mercs AND CGrus = LocalCmPro.CGrus AND !SGrus = LocalCmPro.SGrus

                    CASE !EMPTY(LocalCmPro.Mercs) AND !EMPTY(LocalCmPro.CGrus)
                        UPDATE cursor_4c_Analitico ;
                           SET Apagar   = "N", ;
                               ValComiss = IIF(EMPTY(LocalCmPro.PPctFixs), ValComiss, (ValVdaCom * LocalCmPro.PPctFixs) / 100), ;
                               PctComiss = IIF(EMPTY(LocalCmPro.PPctFixs), PctComiss, LocalCmPro.PPctFixs), ;
                               TpComiss  = IIF(EMPTY(LocalCmPro.PPctFixs), TpComiss, "PRO") ;
                         WHERE Mercs = LocalCmPro.Mercs AND CGrus = LocalCmPro.CGrus

                    CASE !EMPTY(LocalCmPro.Mercs)
                        UPDATE cursor_4c_Analitico ;
                           SET Apagar   = "N", ;
                               ValComiss = IIF(EMPTY(LocalCmPro.PPctFixs), ValComiss, (ValVdaCom * LocalCmPro.PPctFixs) / 100), ;
                               PctComiss = IIF(EMPTY(LocalCmPro.PPctFixs), PctComiss, LocalCmPro.PPctFixs), ;
                               TpComiss  = IIF(EMPTY(LocalCmPro.PPctFixs), TpComiss, "PRO") ;
                         WHERE Mercs = LocalCmPro.Mercs
                ENDCASE
            ENDSCAN

            DELETE FROM cursor_4c_Analitico WHERE Apagar = "S"

            *-- Faixas de Metas da Tabela de Comissao Selecionada
            loc_cSQL = "Select a.CodFaixas, a.FxaInis, a.FxaFims, a.PctFaixas, a.Bonus " + ;
                       "From SigCmItn a " + ;
                       "Where a.fkChaves = '" + ALLTRIM(LocalCmCab.pkChaves) + "' And a.Tipos = 'MET'"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalCmFxa")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar faixas do mapa (LocalCmFxa)"
                MsgErro(THIS.this_cMensagemErro, "Erro")
                IF USED("LocalCmCab")
                    USE IN LocalCmCab
                ENDIF
                IF USED("LocalVendas")
                    USE IN LocalVendas
                ENDIF
                IF USED("LocalEdns")
                    USE IN LocalEdns
                ENDIF
                IF USED("LocalCmPro")
                    USE IN LocalCmPro
                ENDIF
                loc_lResultado = .F.
            ENDIF

            *-- Totais de venda por vendedor para calculo de faixas
            SELECT CodVens, SUM(ValVdaCom) AS ValVendas ;
              FROM cursor_4c_Analitico ;
             GROUP BY CodVens ;
             ORDER BY CodVens ;
              INTO CURSOR crVendas READWRITE

            SELECT crVendas
            SCAN
                loc_lcVen = crVendas.CodVens
                loc_lnVal = crVendas.ValVendas

                SELECT LocalCmFxa
                GO TOP
                LOCATE FOR BETWEEN(loc_lnVal, LocalCmFxa.FxaInis, LocalCmFxa.FxaFims)
                IF !EOF()
                    UPDATE cursor_4c_Analitico ;
                       SET CodFaixas = LocalCmFxa.CodFaixas ;
                     WHERE CodVens = loc_lcVen

                    IF !EMPTY(LocalCmFxa.PctFaixas)
                        UPDATE cursor_4c_Analitico ;
                           SET TpComiss  = "MET", ;
                               PctComiss = IIF(EMPTY(LocalCmFxa.PctFaixas), PctComiss, LocalCmFxa.PctFaixas), ;
                               ValComiss = (ValVdaCom * LocalCmFxa.PctFaixas) / 100 ;
                         WHERE CodVens = loc_lcVen AND !TpComiss = "PRO"
                    ENDIF
                ENDIF
            ENDSCAN

            *-- Vendedores da Tabela de Comissao para calculo de Responsaveis e Bonus
            loc_cSQL = "Select a.CodVens, a.VMetas, a.SalBases, a.CodResps, a.RPctFixs " + ;
                       "From SigCmItn a " + ;
                       "Where a.fkChaves = '" + ALLTRIM(LocalCmCab.pkChaves) + "' And a.Tipos = 'VEN'"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalCmVen")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar vendedores do mapa (LocalCmVen)"
                MsgErro(THIS.this_cMensagemErro, "Erro")
                IF USED("LocalCmCab")
                    USE IN LocalCmCab
                ENDIF
                IF USED("LocalVendas")
                    USE IN LocalVendas
                ENDIF
                IF USED("LocalEdns")
                    USE IN LocalEdns
                ENDIF
                IF USED("LocalCmPro")
                    USE IN LocalCmPro
                ENDIF
                IF USED("LocalCmFxa")
                    USE IN LocalCmFxa
                ENDIF
                loc_lResultado = .F.
            ENDIF

            *-- Lanca registros de responsaveis no cursor analitico
            SELECT LocalCmVen
            SCAN
                IF !EMPTY(LocalCmVen.CodResps) AND !EMPTY(LocalCmVen.RPctFixs)
                    SELECT crVendas
                    GO TOP
                    LOCATE FOR CodVens = LocalCmVen.CodVens
                    IF !EOF()
                        loc_lnCmR = (crVendas.ValVendas * LocalCmVen.RPctFixs) / 100

                        INSERT INTO cursor_4c_Analitico ;
                            (CodVens, Datas, EmpDopNums, Cpros, Mercs, CGrus, SGrus, ;
                             FPags, ValVdaCom, ValComiss, TpComiss, PctComiss, Apagar) ;
                            VALUES (LocalCmVen.CodResps, LocalCmCab.DtFims, ;
                                    "Vendedor " + ALLTRIM(LocalCmVen.CodVens), ;
                                    "", "", "", "", "", crVendas.ValVendas, loc_lnCmR, "REP", ;
                                    LocalCmVen.RPctFixs, "N")
                    ENDIF
                ENDIF
            ENDSCAN

            *-- Cursor de responsaveis para subtitulo
            SELECT CodVens, SUM(ValVdaCom) AS ValVdaCom, SUM(ValComiss) AS ValComiss ;
              FROM cursor_4c_Analitico ;
             WHERE TpComiss = "REP" ;
             GROUP BY CodVens ;
             ORDER BY CodVens ;
              INTO CURSOR crResps READWRITE

            SET POINT TO ","
            SET SEPARATOR TO "."

            loc_lcSub = ""
            SELECT crResps
            SCAN
                loc_lcNom = ""
                loc_cSQL = "Select RClis From SigCdCli Where IClis = '" + ALLTRIM(crResps.CodVens) + "'"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalNomVen")
                IF loc_nResult > 0
                    SELECT LocalNomVen
                    GO TOP
                    IF !EOF()
                        loc_lcNom = ALLTRIM(LocalNomVen.RClis)
                    ENDIF
                    USE IN LocalNomVen
                ENDIF

                loc_lcSub = loc_lcSub + ;
                    IIF(EMPTY(loc_lcSub), "", " / ") + ALLTRIM(crResps.CodVens) + ;
                    IIF(EMPTY(loc_lcNom), "", " (" + loc_lcNom + ")") + ;
                    " - V: " + ALLTRIM(TRANSFORM(crResps.ValVdaCom, "999,999,999.99")) + ;
                    " - C: " + ALLTRIM(TRANSFORM(crResps.ValComiss, "999,999,999.99"))
            ENDSCAN

            SET POINT TO "."
            SET SEPARATOR TO ","

            loc_lcTit = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + "o Por Vendedores - " + ;
                        ALLTRIM(PROPER(loc_lcPrc))
            loc_lcPer = "Per" + CHR(237) + "odo: " + DTOC(LocalCmCab.DtInis) + ;
                        " at" + CHR(233) + " " + DTOC(LocalCmCab.DtFims)

            INSERT INTO cursor_4c_Cabecalho (TotalV, Titulo, Subtitulo, Periodo) ;
                VALUES ("TOTAL", loc_lcTit, loc_lcSub, loc_lcPer)

            *-- Cursor sintetico: vendas por vendedor/data (filtrado por getCodVens)
            SELECT CodVens, Datas, SUM(ValVdaCom) AS ValVdaCom ;
              FROM cursor_4c_Analitico ;
             WHERE IIF(EMPTY(loc_lcFvd), .T., CodVens = loc_lcFvd) ;
             GROUP BY CodVens, Datas ;
             ORDER BY CodVens, Datas ;
              INTO CURSOR crSintetico READWRITE

            *-- Cursor de vendedores com totais (filtrado por getCodVens)
            SELECT 99 AS Ordem, a.CodVens, SUM(a.ValVdaCom) AS ValVdaCom, SUM(a.ValComiss) AS ValComiss ;
              FROM cursor_4c_Analitico a, LocalCmVen b ;
             WHERE a.CodVens = b.CodVens AND ;
                   IIF(EMPTY(loc_lcFvd), .T., a.CodVens = loc_lcFvd) ;
             GROUP BY a.CodVens ;
             ORDER BY a.CodVens ;
              INTO CURSOR crVends READWRITE

            *-- Garante que todos os vendedores do mapa estejam em crVends
            SELECT LocalCmVen
            SCAN
                IF EMPTY(loc_lcFvd) OR (!EMPTY(loc_lcFvd) AND CodVens = loc_lcFvd)
                    SELECT crVends
                    LOCATE FOR CodVens = LocalCmVen.CodVens
                    IF EOF()
                        INSERT INTO crVends (CodVens) VALUES (LocalCmVen.CodVens)
                    ENDIF
                ENDIF
            ENDSCAN

            SELECT crVends
            INDEX ON CodVens TAG CodVens
            loc_lnCnt = 0
            SCAN
                loc_lnCnt = loc_lnCnt + 1
                REPLACE Ordem WITH loc_lnCnt IN crVends
            ENDSCAN

            *-- Intervalo de datas do periodo (linhas de cursor_4c_Impressao)
            loc_lnDia = (LocalCmCab.DtFims - LocalCmCab.DtInis) + 1
            loc_ldDat = LocalCmCab.DtInis
            FOR loc_nI = 1 TO loc_lnDia
                INSERT INTO cursor_4c_Impressao (Datas) VALUES (DTOC(loc_ldDat))
                loc_ldDat = loc_ldDat + 1
            NEXT
            INSERT INTO cursor_4c_Impressao (Datas) VALUES ("VENDAS    ")
            INSERT INTO cursor_4c_Impressao (Datas) VALUES ("COMISS" + CHR(195) + "O  ")
            INSERT INTO cursor_4c_Impressao (Datas) VALUES ("BONUS     ")
            INSERT INTO cursor_4c_Impressao (Datas) VALUES ("METAS     ")
            INSERT INTO cursor_4c_Impressao (Datas) VALUES ("ATINGIDO  ")

            *-- Preenche colunas V01..V13 no cursor de impressao por vendedor
            SELECT crVends
            SCAN
                loc_lcCol = "V" + PADL(crVends.Ordem, 2, "0")

                loc_lcNom = ""
                loc_cSQL = "Select RClis From SigCdCli Where IClis = '" + ALLTRIM(crVends.CodVens) + "'"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalNomVen")
                IF loc_nResult > 0
                    SELECT LocalNomVen
                    GO TOP
                    IF !EOF()
                        loc_lcNom = PADR(ALLTRIM(LocalNomVen.RClis), 10)
                    ENDIF
                    USE IN LocalNomVen
                ENDIF

                SELECT cursor_4c_Cabecalho
                GO TOP
                REPLACE &loc_lcCol. WITH ALLTRIM(crVends.CodVens) + CHR(13) + loc_lcNom ;
                    IN cursor_4c_Cabecalho

                loc_lnVvd = crVends.ValVdaCom
                loc_lnVmt = 0

                SELECT cursor_4c_Impressao
                GO TOP
                LOCATE FOR Datas = "VENDAS    "
                IF !EOF()
                    REPLACE &loc_lcCol. WITH loc_lnVvd IN cursor_4c_Impressao
                ENDIF

                SELECT cursor_4c_Impressao
                GO TOP
                LOCATE FOR Datas = "COMISS" + CHR(195) + "O  "
                IF !EOF()
                    REPLACE &loc_lcCol. WITH crVends.ValComiss IN cursor_4c_Impressao
                    SELECT LocalCmVen
                    GO TOP
                    IF !EOF() AND LocalCmVen.SalBases > 0 AND crVends.ValComiss < LocalCmVen.SalBases
                        REPLACE &loc_lcCol. WITH crVends.ValComiss IN cursor_4c_Impressao
                    ENDIF
                ENDIF

                loc_llAti = .F.
                SELECT cursor_4c_Impressao
                GO TOP
                LOCATE FOR Datas = "METAS     "
                IF !EOF()
                    SELECT LocalCmVen
                    GO TOP
                    LOCATE FOR CodVens = crVends.CodVens
                    IF !EOF()
                        loc_lnVmt = LocalCmVen.VMetas
                        REPLACE &loc_lcCol. WITH loc_lnVmt IN cursor_4c_Impressao
                        loc_llAti = (loc_lnVvd >= loc_lnVmt)
                    ENDIF
                ENDIF

                IF loc_llAti
                    SELECT cursor_4c_Impressao
                    GO TOP
                    LOCATE FOR Datas = "BONUS     "
                    IF !EOF()
                        SELECT LocalCmFxa
                        GO TOP
                        LOCATE FOR BETWEEN(loc_lnVvd, LocalCmFxa.FxaInis, LocalCmFxa.FxaFims)
                        IF !EOF() AND crVends.ValComiss > 0 AND LocalCmFxa.Bonus > 0
                            REPLACE &loc_lcCol. WITH (crVends.ValComiss * LocalCmFxa.Bonus) / 100 ;
                                IN cursor_4c_Impressao
                        ENDIF
                    ENDIF
                ENDIF

                SELECT cursor_4c_Impressao
                GO TOP
                LOCATE FOR Datas = "ATINGIDO  "
                IF !EOF()
                    loc_lnAti = IIF(loc_lnVmt = 0, 0, IIF(EMPTY(loc_lnVmt), 100, (loc_lnVvd * 100) / loc_lnVmt))
                    REPLACE &loc_lcCol. WITH loc_lnAti IN cursor_4c_Impressao
                ENDIF

                SELECT crSintetico
                LOCATE FOR CodVens = crVends.CodVens
                SCAN WHILE CodVens = crVends.CodVens
                    loc_ldDat = crSintetico.Datas
                    SELECT cursor_4c_Impressao
                    GO TOP
                    LOCATE FOR Datas = PADR(DTOC(loc_ldDat), 10)
                    IF !EOF()
                        REPLACE &loc_lcCol. WITH &loc_lcCol. + crSintetico.ValVdaCom ;
                            IN cursor_4c_Impressao
                    ENDIF
                    SELECT crSintetico
                ENDSCAN
            ENDSCAN

            *-- Totaliza coluna TotalV
            UPDATE cursor_4c_Impressao ;
               SET TotalV = V01 + V02 + V03 + V04 + V05 + V06 + V07 + V08 + ;
                            V09 + V10 + V11 + V12 + V13 ;
             WHERE !Datas = "ATINGIDO  "

            *-- Corrige total da meta da empresa
            loc_lnVmt = LocalCmCab.MetaEmps
            loc_lnVvd = 0
            SELECT cursor_4c_Impressao
            GO TOP
            LOCATE FOR Datas = "VENDAS    "
            IF !EOF()
                loc_lnVvd = cursor_4c_Impressao.TotalV
            ENDIF

            SELECT cursor_4c_Impressao
            GO TOP
            LOCATE FOR Datas = "METAS     "
            IF !EOF()
                REPLACE TotalV WITH loc_lnVmt IN cursor_4c_Impressao
            ENDIF

            SELECT cursor_4c_Impressao
            GO TOP
            LOCATE FOR Datas = "ATINGIDO  "
            IF !EOF()
                loc_lnAti = IIF(loc_lnVmt = 0, 0, IIF(EMPTY(loc_lnVmt), 100, (loc_lnVvd * 100) / loc_lnVmt))
                REPLACE TotalV WITH loc_lnAti IN cursor_4c_Impressao
            ENDIF

            SELECT cursor_4c_Cabecalho
            GO TOP
            SELECT cursor_4c_Impressao
            GO TOP

            *-- Limpa cursores temporarios de SQL
            IF USED("LocalCmCab")
                USE IN LocalCmCab
            ENDIF
            IF USED("LocalVendas")
                USE IN LocalVendas
            ENDIF
            IF USED("LocalEdns")
                USE IN LocalEdns
            ENDIF
            IF USED("LocalCmPro")
                USE IN LocalCmPro
            ENDIF
            IF USED("LocalCmFxa")
                USE IN LocalCmFxa
            ENDIF
            IF USED("LocalCmVen")
                USE IN LocalCmVen
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Prepara cursor_4c_Excel para exportacao
    * Equivalente ao PROCEDURE documentoexcel do original
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lResultado = .F.
            ENDIF

            SELECT cursor_4c_Excel
            ZAP

            SET POINT TO ","
            SET SEPARATOR TO "."

            SELECT cursor_4c_Impressao
            SCAN
                INSERT INTO cursor_4c_Excel ;
                    (V01, V02, V03, V04, V05, V06, V07, V08, V09, V10, V11, V12, V13, TotalV, Datas) ;
                    VALUES ( ;
                        TRANSFORM(cursor_4c_Impressao.V01, "999999999.99"), ;
                        TRANSFORM(cursor_4c_Impressao.V02, "999999999.99"), ;
                        TRANSFORM(cursor_4c_Impressao.V03, "999999999.99"), ;
                        TRANSFORM(cursor_4c_Impressao.V04, "999999999.99"), ;
                        TRANSFORM(cursor_4c_Impressao.V05, "999999999.99"), ;
                        TRANSFORM(cursor_4c_Impressao.V06, "999999999.99"), ;
                        TRANSFORM(cursor_4c_Impressao.V07, "999999999.99"), ;
                        TRANSFORM(cursor_4c_Impressao.V08, "999999999.99"), ;
                        TRANSFORM(cursor_4c_Impressao.V09, "999999999.99"), ;
                        TRANSFORM(cursor_4c_Impressao.V10, "999999999.99"), ;
                        TRANSFORM(cursor_4c_Impressao.V11, "999999999.99"), ;
                        TRANSFORM(cursor_4c_Impressao.V12, "999999999.99"), ;
                        TRANSFORM(cursor_4c_Impressao.V13, "999999999.99"), ;
                        TRANSFORM(cursor_4c_Impressao.TotalV, "999999999.99"), ;
                        cursor_4c_Impressao.Datas)
            ENDSCAN

            SET POINT TO "."
            SET SEPARATOR TO ","

            SELECT cursor_4c_Excel
            GO TOP

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime o relatorio para impressora
    * Equivalente ao PROCEDURE impressao do original
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lResultado, loc_oErro, loc_cFrx
        loc_lResultado = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lResultado = .F.
            ENDIF

            loc_cFrx = gc_4c_CaminhoBase + "reports\SigReCmm.frx"
            IF !FILE(loc_cFrx)
                THIS.this_cMensagemErro = "Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                                          "o encontrado: " + loc_cFrx
                MsgErro(THIS.this_cMensagemErro, "Erro")
                loc_lResultado = .F.
            ENDIF

            REPORT FORM (loc_cFrx) TO PRINTER PROMPT NOCONSOLE

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe o relatorio em preview na tela
    * Equivalente ao PROCEDURE visualizacao do original
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lResultado, loc_oErro, loc_cFrx
        loc_lResultado = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lResultado = .F.
            ENDIF

            loc_cFrx = gc_4c_CaminhoBase + "reports\SigReCmm.frx"
            IF !FILE(loc_cFrx)
                THIS.this_cMensagemErro = "Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                                          "o encontrado: " + loc_cFrx
                MsgErro(THIS.this_cMensagemErro, "Erro")
                loc_lResultado = .F.
            ENDIF

            REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta dos filtros do relatorio
    * Usada pela auditoria para identificar a execucao do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "MAPA=" + ALLTRIM(THIS.this_cCodMapa) + ;
                     ";VEN=" + ALLTRIM(THIS.this_cCodVens)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros a partir de cursor de preset
    * Para BO de relatorio, o cursor pode armazenar parametros previamente usados
    * par_cAliasCursor: nome do cursor com colunas dos filtros
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de preset n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel: " + ALLTRIM(NVL(loc_cAlias, ""))
            ELSE
                SELECT (loc_cAlias)
                IF EOF()
                    THIS.this_cMensagemErro = "Cursor de preset vazio: " + loc_cAlias
                ELSE
                    SCATTER MEMVAR

                    IF TYPE("m.cCodMapa") = "C"
                        THIS.this_cCodMapa = ALLTRIM(m.cCodMapa)
                    ENDIF
                    IF TYPE("m.cCodVens") = "C"
                        THIS.this_cCodVens = ALLTRIM(m.cCodVens)
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Semantica para BO de relatorio: produzir documento impresso
    * Delega para Imprimir e registra auditoria de IMPRESSAO
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.Imprimir()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("IMPRESSAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Semantica para BO de relatorio: recalcular e visualizar
    * Delega para Visualizar e registra auditoria de VISUALIZACAO
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.Visualizar()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("VISUALIZACAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do relatorio em LogAuditoria
    * par_cOperacao: tipo de operacao (IMPRESSAO, VISUALIZACAO)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult
        LOCAL loc_cUsuario, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF
            loc_cChave = THIS.ObterChavePrimaria()

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReCmm") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper geracao do relatorio
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.FecharCursores()
        DODEFAULT()
    ENDPROC

ENDDEFINE

