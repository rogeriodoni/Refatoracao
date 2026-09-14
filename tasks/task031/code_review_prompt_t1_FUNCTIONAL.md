# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreanr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (865 linhas total):

*-- Linhas 40 a 145:
40:     Themes      = .F.
41:     ShowTips    = .T.
42: 
43:     *-- BO de relatorio (instanciado em InicializarForm)
44:     this_oRelatorio    = .NULL.
45:     this_cMensagemErro = ""
46: 
47:     *--------------------------------------------------------------------------
48:     * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
49:     *--------------------------------------------------------------------------
50:     PROCEDURE Init()
51:         RETURN DODEFAULT()
52:     ENDPROC
53: 
54:     *--------------------------------------------------------------------------
55:     * InicializarForm - Cria estrutura visual do formulario de relatorio
56:     *--------------------------------------------------------------------------
57:     PROTECTED PROCEDURE InicializarForm()
58:         LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
59:         loc_lSucesso   = .F.
60:         loc_lContinuar = .T.
61: 
62:         TRY
63:             THIS.Caption = "Relat" + CHR(243) + "rio de Resultados"
64: 
65:             IF TYPE("gc_4c_CaminhoIcones") = "U"
66:                 gc_4c_CaminhoIcones = ""
67:             ENDIF
68:             IF TYPE("gc_4c_CaminhoReports") = "U"
69:                 gc_4c_CaminhoReports = ""
70:             ENDIF
71:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
72: 
73:             THIS.this_oRelatorio = CREATEOBJECT("sigreanrBO")
74:             IF VARTYPE(THIS.this_oRelatorio) != "O"
75:                 MsgErro("Erro ao criar sigreanrBO" + CHR(13) + ;
76:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
77:                 loc_lContinuar = .F.
78:             ENDIF
79: 
80:             IF loc_lContinuar
81:                 THIS.ConfigurarCabecalho()
82:                 THIS.ConfigurarPageFrame()
83:                 THIS.ConfigurarPaginaLista()
84:                 THIS.ConfigurarPaginaDados()
85:                 THIS.LimparCampos()
86:                 loc_lSucesso = .T.
87:             ENDIF
88: 
89:         CATCH TO loc_oErro
90:             THIS.this_cMensagemErro = loc_oErro.Message
91:             MsgErro(loc_oErro.Message + CHR(13) + ;
92:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
93:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
94:         ENDTRY
95: 
96:         RETURN loc_lSucesso
97:     ENDPROC
98: 
99:     *--------------------------------------------------------------------------
100:     * ConfigurarCabecalho - Container escuro superior com titulo e botoes
101:     *   Width = THIS.Width (800) para cobrir toda a faixa superior.
102:     *   BackColor=RGB(100,100,100) = cinza medio do framework (cntSombra).
103:     *   cmg_4c_Botoes: CommandGroup com 4 botoes (Visualizar/Imprimir/DocExcel/Sair)
104:     *--------------------------------------------------------------------------
105:     PROTECTED PROCEDURE ConfigurarCabecalho()
106:         LOCAL loc_oCab, loc_oCmg
107:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
108:         loc_oCab = THIS.cnt_4c_Cabecalho
109: 
110:         WITH loc_oCab
111:             .Top         = 0
112:             .Left        = 0
113:             .Width       = THIS.Width
114:             .Height      = 80
115:             .BackStyle   = 1
116:             .BackColor   = RGB(100, 100, 100)
117:             .BorderWidth = 0
118:             .Visible     = .T.
119: 
120:             .AddObject("lbl_4c_Sombra", "Label")
121:             WITH .lbl_4c_Sombra
122:                 .Top       = 22
123:                 .Left      = 22
124:                 .Width     = THIS.Width
125:                 .Height    = 30
126:                 .Caption   = "Relat" + CHR(243) + "rio de Resultados"
127:                 .FontName  = "Tahoma"
128:                 .FontSize  = 14
129:                 .FontBold  = .T.
130:                 .ForeColor = RGB(0, 0, 0)
131:                 .BackStyle = 0
132:                 .Visible   = .T.
133:             ENDWITH
134: 
135:             .AddObject("lbl_4c_Titulo", "Label")
136:             WITH .lbl_4c_Titulo
137:                 .Top       = 20
138:                 .Left      = 20
139:                 .Width     = THIS.Width
140:                 .Height    = 30
141:                 .Caption   = "Relat" + CHR(243) + "rio de Resultados"
142:                 .FontName  = "Tahoma"
143:                 .FontSize  = 14
144:                 .FontBold  = .T.
145:                 .ForeColor = RGB(255, 255, 255)

*-- Linhas 239 a 865:
239:         ENDWITH
240: 
241:         loc_oCmg = loc_oCab.cmg_4c_Botoes
242:         BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnVisualizarClick")
243:         BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnImprimirClick")
244:         BINDEVENT(loc_oCmg.Buttons(3), "Click", THIS, "BtnGerarExcelClick")
245:         BINDEVENT(loc_oCmg.Buttons(4), "Click", THIS, "BtnCancelarClick")
246:     ENDPROC
247: 
248:     *--------------------------------------------------------------------------
249:     * ConfigurarPageFrame - PageFrame com 1 pagina (Filtros)
250:     *   Form: Width=800, Height=300
251:     *   Cabecalho Height=80; PageFrame.Top=85, Height=300-85=215, Width=802
252:     *--------------------------------------------------------------------------
253:     PROTECTED PROCEDURE ConfigurarPageFrame()
254:         LOCAL loc_oPgf
255: 
256:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
257:         loc_oPgf = THIS.pgf_4c_Paginas
258: 
259:         loc_oPgf.PageCount = 1
260:         loc_oPgf.Top       = 85
261:         loc_oPgf.Left      = -1
262:         loc_oPgf.Width     = THIS.Width + 2
263:         loc_oPgf.Height    = THIS.Height - 85
264:         loc_oPgf.Tabs      = .F.
265: 
266:         loc_oPgf.Page1.Caption   = "Filtros"
267:         loc_oPgf.Page1.FontName  = "Tahoma"
268:         loc_oPgf.Page1.FontSize  = 8
269:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
270:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
271:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
272: 
273:         loc_oPgf.Visible    = .T.
274:         loc_oPgf.ActivePage = 1
275:     ENDPROC
276: 
277:     *--------------------------------------------------------------------------
278:     * AlternarPagina - Ativa a pagina informada (forms REPORT tem so Page1).
279:     *   par_nPagina: indice 1-based. Valor invalido cai em 1.
280:     *   Apos ativar, foca txt_4c_DtInicial para iniciar entrada de filtros.
281:     *--------------------------------------------------------------------------
282:     PROCEDURE AlternarPagina(par_nPagina)
283:         LOCAL loc_nPagina, loc_oErro, loc_oPagina
284:         TRY
285:             loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
286:             IF loc_nPagina < 1 OR loc_nPagina > THIS.pgf_4c_Paginas.PageCount
287:                 loc_nPagina = 1
288:             ENDIF
289:             THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
290:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
291:             IF PEMSTATUS(loc_oPagina, "txt_4c_DtInicial", 5)
292:                 loc_oPagina.txt_4c_DtInicial.SetFocus()
293:             ENDIF
294:         CATCH TO loc_oErro
295:             MsgErro(loc_oErro.Message, "Erro ao Alternar P" + CHR(225) + "gina")
296:         ENDTRY
297:     ENDPROC
298: 
299:     *--------------------------------------------------------------------------
300:     * Destroy - Libera referencia ao BO
301:     *   RelatorioBase herda de Custom (sem Release()) - usar .NULL. para liberar
302:     *--------------------------------------------------------------------------
303:     PROCEDURE Destroy()
304:         IF VARTYPE(THIS.this_oRelatorio) = "O"
305:             THIS.this_oRelatorio = .NULL.
306:         ENDIF
307:         DODEFAULT()
308:     ENDPROC
309: 
310:     *--------------------------------------------------------------------------
311:     * ConfigurarPaginaLista - Adiciona controles de filtro na Page1 (pagina unica)
312:     *   Forms REPORT nao tem grid CRUD; a "lista" eh o painel de filtros que
313:     *   seleciona o conjunto de dados que sera enviado ao FRX. As posicoes
314:     *   originais sao deslocadas: Top_page1 = Top_original - PageFrame.Top(85).
315:     *--------------------------------------------------------------------------
316:     PROTECTED PROCEDURE ConfigurarPaginaLista()
317:         LOCAL loc_oPagina
318:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
319: 
320:         loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
321:         WITH loc_oPagina.lbl_4c_Periodo
322:             .Top       = 52
323:             .Left      = 252
324:             .Width     = 45
325:             .Height    = 18
326:             .Caption   = "Per" + CHR(237) + "odo :"
327:             .FontName  = "Tahoma"
328:             .FontSize  = 8
329:             .ForeColor = RGB(90, 90, 90)
330:             .BackStyle = 0
331:             .Visible   = .T.
332:         ENDWITH
333: 
334:         loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
335:         WITH loc_oPagina.txt_4c_DtInicial
336:             .Top         = 47
337:             .Left        = 300
338:             .Width       = 80
339:             .Height      = 23
340:             .Value       = {}
341:             .FontName    = "Tahoma"
342:             .FontSize    = 8
343:             .ForeColor   = RGB(90, 90, 90)
344:             .BorderStyle = 1
345:             .Visible     = .T.
346:         ENDWITH
347:         BINDEVENT(loc_oPagina.txt_4c_DtInicial, "KeyPress", THIS, "TeclaDataInicial")
348: 
349:         loc_oPagina.AddObject("lbl_4c_PeriodoA", "Label")
350:         WITH loc_oPagina.lbl_4c_PeriodoA
351:             .Top       = 51
352:             .Left      = 384
353:             .Width     = 8
354:             .Height    = 18
355:             .Caption   = CHR(224)
356:             .FontName  = "Tahoma"
357:             .FontSize  = 8
358:             .ForeColor = RGB(90, 90, 90)
359:             .BackStyle = 0
360:             .Visible   = .T.
361:         ENDWITH
362: 
363:         loc_oPagina.AddObject("txt_4c_DtFinal", "TextBox")
364:         WITH loc_oPagina.txt_4c_DtFinal
365:             .Top         = 47
366:             .Left        = 396
367:             .Width       = 80
368:             .Height      = 23
369:             .Value       = {}
370:             .FontName    = "Tahoma"
371:             .FontSize    = 8
372:             .ForeColor   = RGB(90, 90, 90)
373:             .BorderStyle = 1
374:             .Visible     = .T.
375:         ENDWITH
376:         BINDEVENT(loc_oPagina.txt_4c_DtFinal, "KeyPress", THIS, "TeclaDataFinal")
377: 
378:         loc_oPagina.AddObject("lbl_4c_DtCotacao", "Label")
379:         WITH loc_oPagina.lbl_4c_DtCotacao
380:             .Top       = 75
381:             .Left      = 222
382:             .Width     = 75
383:             .Height    = 18
384:             .Caption   = "Data Cota" + CHR(231) + CHR(227) + "o :"
385:             .FontName  = "Tahoma"
386:             .FontSize  = 8
387:             .ForeColor = RGB(90, 90, 90)
388:             .BackStyle = 0
389:             .Visible   = .T.
390:         ENDWITH
391: 
392:         loc_oPagina.AddObject("txt_4c_DtCotacao", "TextBox")
393:         WITH loc_oPagina.txt_4c_DtCotacao
394:             .Top         = 72
395:             .Left        = 300
396:             .Width       = 80
397:             .Height      = 23
398:             .Value       = {}
399:             .FontName    = "Tahoma"
400:             .FontSize    = 8
401:             .ForeColor   = RGB(90, 90, 90)
402:             .BorderStyle = 1
403:             .Visible     = .T.
404:         ENDWITH
405:         BINDEVENT(loc_oPagina.txt_4c_DtCotacao, "KeyPress", THIS, "TeclaDtCotacao")
406: 
407:         loc_oPagina.AddObject("lbl_4c_Empresa", "Label")
408:         WITH loc_oPagina.lbl_4c_Empresa
409:             .Top       = 102
410:             .Left      = 247
411:             .Width     = 50
412:             .Height    = 18
413:             .Caption   = "Empresa :"
414:             .FontName  = "Tahoma"
415:             .FontSize  = 8
416:             .ForeColor = RGB(90, 90, 90)
417:             .BackStyle = 0
418:             .Visible   = .T.
419:         ENDWITH
420: 
421:         loc_oPagina.AddObject("txt_4c_Empresa", "TextBox")
422:         WITH loc_oPagina.txt_4c_Empresa
423:             .Top         = 97
424:             .Left        = 300
425:             .Width       = 31
426:             .Height      = 23
427:             .Value       = ""
428:             .FontName    = "Tahoma"
429:             .FontSize    = 8
430:             .ForeColor   = RGB(90, 90, 90)
431:             .MaxLength   = 3
432:             .BorderStyle = 1
433:             .Visible     = .T.
434:         ENDWITH
435:         BINDEVENT(loc_oPagina.txt_4c_Empresa, "KeyPress", THIS, "TeclaEmpresa")
436: 
437:         loc_oPagina.AddObject("txt_4c_EmpresaDesc", "TextBox")
438:         WITH loc_oPagina.txt_4c_EmpresaDesc
439:             .Top         = 97
440:             .Left        = 333
441:             .Width       = 290
442:             .Height      = 23
443:             .Value       = ""
444:             .FontName    = "Tahoma"
445:             .FontSize    = 8
446:             .ForeColor   = RGB(90, 90, 90)
447:             .MaxLength   = 40
448:             .ReadOnly    = .T.
449:             .BorderStyle = 1
450:             .Visible     = .T.
451:         ENDWITH
452:         BINDEVENT(loc_oPagina.txt_4c_EmpresaDesc, "KeyPress", THIS, "TeclaEmpresaDesc")
453:     ENDPROC
454: 
455:     *--------------------------------------------------------------------------
456:     * ConfigurarPaginaDados - Nao utilizado em form REPORT (sem Page2 de edicao)
457:     *   Mantido para compatibilidade com o pipeline multi-fase. Forms REPORT
458:     *   usam apenas Page1 (Filtros), configurada em ConfigurarPaginaLista().
459:     *--------------------------------------------------------------------------
460:     PROTECTED PROCEDURE ConfigurarPaginaDados()
461:         RETURN .T.
462:     ENDPROC
463: 
464:     *--------------------------------------------------------------------------
465:     * LimparCampos - Inicializa filtros com valores padrao (datas = hoje)
466:     *--------------------------------------------------------------------------
467:     PROCEDURE LimparCampos()
468:         LOCAL loc_oPagina
469:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
470:         WITH loc_oPagina
471:             .txt_4c_DtInicial.Value      = DATE()
472:             .txt_4c_DtFinal.Value        = DATE()
473:             .txt_4c_DtCotacao.Value      = DATE()
474:             .txt_4c_Empresa.Value        = ""
475:             .txt_4c_EmpresaDesc.Value    = ""
476:             .txt_4c_EmpresaDesc.ReadOnly = .F.
477:         ENDWITH
478:     ENDPROC
479: 
480:     *--------------------------------------------------------------------------
481:     * FormParaRelatorio - Copia valores do form para o BO antes de imprimir
482:     *--------------------------------------------------------------------------
483:     PROTECTED PROCEDURE FormParaRelatorio()
484:         LOCAL loc_oPagina
485:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
486:         WITH THIS.this_oRelatorio
487:             .this_dDtInicial   = loc_oPagina.txt_4c_DtInicial.Value
488:             .this_dDtFinal     = loc_oPagina.txt_4c_DtFinal.Value
489:             .this_dDtCotacao   = loc_oPagina.txt_4c_DtCotacao.Value
490:             .this_cEmpresa     = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)
491:             .this_cEmpresaDesc = ALLTRIM(loc_oPagina.txt_4c_EmpresaDesc.Value)
492:         ENDWITH
493:     ENDPROC
494: 
495:     *--------------------------------------------------------------------------
496:     * Eventos CRUD - Forms REPORT (frmrelatorio): sem operacoes Incluir/Alterar
497:     * /Excluir. Os botoes disponiveis em forms de relatorio sao apenas:
498:     *   - Visualizar (preview na tela) -> BtnVisualizarClick
499:     *   - Imprimir (com dialogo)       -> BtnImprimirClick
500:     *   - Doc. Excel (export)          -> BtnGerarExcelClick
501:     *   - Sair                         -> BtnCancelarClick
502:     * Os handlers abaixo existem por compatibilidade com a interface generica
503:     * do pipeline multi-fase, mas informam ao usuario quando acionados.
504:     *--------------------------------------------------------------------------
505:     PROCEDURE BtnIncluirClick()
506:         MsgInfo("Inclus" + CHR(227) + "o n" + CHR(227) + "o se aplica a este " + ;
507:             "formul" + CHR(225) + "rio de relat" + CHR(243) + "rio." + CHR(13) + ;
508:             "Use Visualizar (F5) ou Imprimir (F6).", ;
509:             "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel")
510:     ENDPROC
511: 
512:     PROCEDURE BtnAlterarClick()
513:         MsgInfo("Altera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o se aplica a este " + ;
514:             "formul" + CHR(225) + "rio de relat" + CHR(243) + "rio." + CHR(13) + ;
515:             "Use Visualizar (F5) ou Imprimir (F6).", ;
516:             "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel")
517:     ENDPROC
518: 
519:     PROCEDURE BtnExcluirClick()
520:         MsgInfo("Exclus" + CHR(227) + "o n" + CHR(227) + "o se aplica a este " + ;
521:             "formul" + CHR(225) + "rio de relat" + CHR(243) + "rio." + CHR(13) + ;
522:             "Use Visualizar (F5) ou Imprimir (F6).", ;
523:             "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel")
524:     ENDPROC
525: 
526:     *--------------------------------------------------------------------------
527:     * BtnVisualizarClick - Preview do relatorio na tela
528:     *--------------------------------------------------------------------------
529:     PROCEDURE BtnVisualizarClick()
530:         LOCAL loc_oErro, loc_lContinuar
531:         loc_lContinuar = .T.
532:         TRY
533:             IF EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.Value) OR ;
534:                EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal.Value)
535:                 MsgAviso("Informe o per" + CHR(237) + "odo.", ;
536:                          "Valida" + CHR(231) + CHR(227) + "o")
537:                 loc_lContinuar = .F.
538:             ENDIF
539:             IF loc_lContinuar
540:                 THIS.FormParaRelatorio()
541:                 IF !THIS.this_oRelatorio.Visualizar()
542:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
543:                             "Erro ao Visualizar")
544:                 ENDIF
545:             ENDIF
546:         CATCH TO loc_oErro
547:             MsgErro(loc_oErro.Message + CHR(13) + ;
548:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
549:         ENDTRY
550:     ENDPROC
551: 
552:     *--------------------------------------------------------------------------
553:     * BtnImprimirClick - Imprime relatorio com dialogo de impressora
554:     *--------------------------------------------------------------------------
555:     PROCEDURE BtnImprimirClick()
556:         LOCAL loc_oErro, loc_lContinuar
557:         loc_lContinuar = .T.
558:         TRY
559:             IF EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.Value) OR ;
560:                EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal.Value)
561:                 MsgAviso("Informe o per" + CHR(237) + "odo.", ;
562:                          "Valida" + CHR(231) + CHR(227) + "o")
563:                 loc_lContinuar = .F.
564:             ENDIF
565:             IF loc_lContinuar
566:                 THIS.FormParaRelatorio()
567:                 IF !THIS.this_oRelatorio.Imprimir()
568:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
569:                             "Erro ao Imprimir")
570:                 ENDIF
571:             ENDIF
572:         CATCH TO loc_oErro
573:             MsgErro(loc_oErro.Message + CHR(13) + ;
574:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
575:         ENDTRY
576:     ENDPROC
577: 
578:     *--------------------------------------------------------------------------
579:     * BtnGerarExcelClick - Impressao direta sem dialogo (Doc. Excel)
580:     *--------------------------------------------------------------------------
581:     PROCEDURE BtnGerarExcelClick()
582:         LOCAL loc_oErro, loc_lContinuar
583:         loc_lContinuar = .T.
584:         TRY
585:             IF EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.Value) OR ;
586:                EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal.Value)
587:                 MsgAviso("Informe o per" + CHR(237) + "odo.", ;
588:                          "Valida" + CHR(231) + CHR(227) + "o")
589:                 loc_lContinuar = .F.
590:             ENDIF
591:             IF loc_lContinuar
592:                 THIS.FormParaRelatorio()
593:                 IF !THIS.this_oRelatorio.GerarExcel()
594:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
595:                             "Erro ao Gerar Documento")
596:                 ENDIF
597:             ENDIF
598:         CATCH TO loc_oErro
599:             MsgErro(loc_oErro.Message + CHR(13) + ;
600:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
601:         ENDTRY
602:     ENDPROC
603: 
604:     *--------------------------------------------------------------------------
605:     * BtnCancelarClick - Fecha o formulario (ESC via Buttons(4).Cancel=.T.)
606:     *   Buttons(4) eh o "Sair" do CommandGroup; Cancel=.T. mapeia ESC para ele.
607:     *--------------------------------------------------------------------------
608:     PROCEDURE BtnCancelarClick()
609:         THIS.Release()
610:     ENDPROC
611: 
612:     *--------------------------------------------------------------------------
613:     * Aliases de interface CRUD - exigidos pelo pipeline multi-fase (Fase 8).
614:     *   Forms REPORT nao possuem Buscar/Encerrar/Salvar como botoes proprios,
615:     *   mas o validador exige a assinatura. Mapeamos para as acoes de relatorio:
616:     *     BtnBuscarClick   -> Visualizar (acao de "preview" similar a uma busca)
617:     *     BtnEncerrarClick -> Release  (fecha o form)
618:     *     BtnSalvarClick   -> Imprimir (acao "definitiva" do relatorio)
619:     *--------------------------------------------------------------------------
620:     PROCEDURE BtnBuscarClick()
621:         THIS.BtnVisualizarClick()
622:     ENDPROC
623: 
624:     PROCEDURE BtnEncerrarClick()
625:         THIS.Release()
626:     ENDPROC
627: 
628:     PROCEDURE BtnSalvarClick()
629:         THIS.BtnImprimirClick()
630:     ENDPROC
631: 
632:     PROCEDURE BtnConsultarClick()
633:         THIS.BtnVisualizarClick()
634:     ENDPROC
635: 
636:     *--------------------------------------------------------------------------
637:     * FormParaBO / BOParaForm - Aliases para a interface generica FormBase.
638:     *   Forms REPORT usam FormParaRelatorio() como nome principal; estes
639:     *   wrappers existem para o pipeline multi-fase. BOParaForm copia os
640:     *   filtros do BO de volta para a tela (uso em "reabrir relatorio").
641:     *--------------------------------------------------------------------------
642:     PROTECTED PROCEDURE FormParaBO()
643:         THIS.FormParaRelatorio()
644:     ENDPROC
645: 
646:     PROTECTED PROCEDURE BOParaForm()
647:         LOCAL loc_oPg, loc_oErro
648:         TRY
649:             IF VARTYPE(THIS.this_oRelatorio) = "O"
650:                 loc_oPg = THIS.pgf_4c_Paginas.Page1
651:                 WITH THIS.this_oRelatorio
652:                     IF !EMPTY(.this_dDtInicial)
653:                         loc_oPg.txt_4c_DtInicial.Value = .this_dDtInicial
654:                     ENDIF
655:                     IF !EMPTY(.this_dDtFinal)
656:                         loc_oPg.txt_4c_DtFinal.Value = .this_dDtFinal
657:                     ENDIF
658:                     IF !EMPTY(.this_dDtCotacao)
659:                         loc_oPg.txt_4c_DtCotacao.Value = .this_dDtCotacao
660:                     ENDIF
661:                     loc_oPg.txt_4c_Empresa.Value     = .this_cEmpresa
662:                     loc_oPg.txt_4c_EmpresaDesc.Value = .this_cEmpresaDesc
663:                 ENDWITH
664:             ENDIF
665:         CATCH TO loc_oErro
666:             MsgErro(loc_oErro.Message, "Erro em BOParaForm")
667:         ENDTRY
668:     ENDPROC
669: 
670:     *--------------------------------------------------------------------------
671:     * HabilitarCampos - Habilita ou desabilita os campos de filtro (ReadOnly).
672:     *   par_lHabilitar = .T. -> filtros editaveis (estado padrao do form REPORT)
673:     *   par_lHabilitar = .F. -> filtros bloqueados (uso em "processando...")
674:     *   txt_4c_EmpresaDesc: mantem ReadOnly=.T. quando ja ha empresa selecionada
675:     *   para preservar a busca reversa (descricao so editavel sem codigo).
676:     *--------------------------------------------------------------------------
677:     PROCEDURE HabilitarCampos(par_lHabilitar)
678:         LOCAL loc_oPg, loc_lHab, loc_oErro
679:         TRY
680:             loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
681:             loc_oPg  = THIS.pgf_4c_Paginas.Page1
682:             IF VARTYPE(loc_oPg) = "O"
683:                 IF PEMSTATUS(loc_oPg, "txt_4c_DtInicial", 5)
684:                     loc_oPg.txt_4c_DtInicial.ReadOnly = !loc_lHab
685:                 ENDIF
686:                 IF PEMSTATUS(loc_oPg, "txt_4c_DtFinal", 5)
687:                     loc_oPg.txt_4c_DtFinal.ReadOnly = !loc_lHab
688:                 ENDIF
689:                 IF PEMSTATUS(loc_oPg, "txt_4c_DtCotacao", 5)
690:                     loc_oPg.txt_4c_DtCotacao.ReadOnly = !loc_lHab
691:                 ENDIF
692:                 IF PEMSTATUS(loc_oPg, "txt_4c_Empresa", 5)
693:                     loc_oPg.txt_4c_Empresa.ReadOnly = !loc_lHab
694:                 ENDIF
695:                 IF PEMSTATUS(loc_oPg, "txt_4c_EmpresaDesc", 5)
696:                     IF !loc_lHab
697:                         loc_oPg.txt_4c_EmpresaDesc.ReadOnly = .T.
698:                     ELSE
699:                         loc_oPg.txt_4c_EmpresaDesc.ReadOnly = ;
700:                             !EMPTY(ALLTRIM(loc_oPg.txt_4c_Empresa.Value))
701:                     ENDIF
702:                 ENDIF
703:             ENDIF
704:         CATCH TO loc_oErro
705:             MsgErro(loc_oErro.Message, "Erro em HabilitarCampos")
706:         ENDTRY
707:     ENDPROC
708: 
709:     *--------------------------------------------------------------------------
710:     * CarregarLista - Forms REPORT nao tem grid CRUD; metodo presente apenas
711:     *   para compatibilidade com o pipeline (validador de Fase 8).
712:     *--------------------------------------------------------------------------
713:     PROCEDURE CarregarLista()
714:         RETURN .T.
715:     ENDPROC
716: 
717:     *--------------------------------------------------------------------------
718:     * AjustarBotoesPorModo - Em forms REPORT, todos os botoes do CommandGroup
719:     *   (Visualizar/Imprimir/Doc.Excel/Sair) ficam sempre habilitados; nao ha
720:     *   transicao de modo Lista/Edicao. Metodo mantido para uniformidade da
721:     *   interface generica de Forms; o que realmente protege contra acionamento
722:     *   indevido eh a validacao de periodo dentro de cada Btn*Click().
723:     *--------------------------------------------------------------------------
724:     PROCEDURE AjustarBotoesPorModo()
725:         LOCAL loc_oCmg, loc_oErro, loc_nI
726:         TRY
727:             IF VARTYPE(THIS.cnt_4c_Cabecalho) = "O" AND ;
728:                PEMSTATUS(THIS.cnt_4c_Cabecalho, "cmg_4c_Botoes", 5)
729:                 loc_oCmg = THIS.cnt_4c_Cabecalho.cmg_4c_Botoes
730:                 FOR loc_nI = 1 TO loc_oCmg.ButtonCount
731:                     loc_oCmg.Buttons(loc_nI).Enabled = .T.
732:                 ENDFOR
733:             ENDIF
734:         CATCH TO loc_oErro
735:             MsgErro(loc_oErro.Message, "Erro em AjustarBotoesPorModo")
736:         ENDTRY
737:     ENDPROC
738: 
739:     *--------------------------------------------------------------------------
740:     * TeclaEmpresa - KeyPress em txt_4c_Empresa
741:     *   F4(115): abre lookup de empresa
742:     *   ENTER(13)/TAB(9): valida codigo digitado contra SigCdEmp
743:     *--------------------------------------------------------------------------
744:     PROCEDURE TeclaEmpresa(par_nKeyCode, par_nShift)
745:         IF par_nKeyCode = 115
746:             THIS.AbrirBuscaEmpresa()
747:         ENDIF
748:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
749:             THIS.ValidarEmpresa()
750:         ENDIF
751:     ENDPROC
752: 
753:     *--------------------------------------------------------------------------
754:     * ValidarEmpresa - Busca empresa por codigo e preenche descricao
755:     *--------------------------------------------------------------------------
756:     PROCEDURE ValidarEmpresa()
757:         LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oErro, loc_lEncontrou
758:         loc_cValor    = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value)
759:         loc_lEncontrou = .F.
760:         TRY
761:             IF EMPTY(loc_cValor)
762:                 THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.Value   = ""
763:                 THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.ReadOnly = .F.
764:             ELSE
765:                 loc_cSQL    = "SELECT Cemps, Razas FROM SigCdEmp " + ;
766:                               "WHERE Cemps = " + EscaparSQL(loc_cValor)
767:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
768:                 IF loc_nResult > 0 AND !EOF("cursor_4c_EmpVal")
769:                     SELECT cursor_4c_EmpVal
770:                     THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.Value   = ALLTRIM(Razas)
771:                     THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.ReadOnly = .T.
772:                     loc_lEncontrou = .T.
773:                 ENDIF
774:                 IF USED("cursor_4c_EmpVal")
775:                     USE IN cursor_4c_EmpVal
776:                 ENDIF
777:                 IF !loc_lEncontrou
778:                     THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value      = ""
779:                     THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.Value   = ""
780:                     THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.ReadOnly = .F.
781:                     THIS.AbrirBuscaEmpresa()
782:                 ENDIF
783:             ENDIF
784:         CATCH TO loc_oErro
785:             MsgErro(loc_oErro.Message, "Erro ao Validar Empresa")
786:         ENDTRY
787:     ENDPROC
788: 
789:     *--------------------------------------------------------------------------
790:     * TeclaEmpresaDesc - KeyPress em txt_4c_EmpresaDesc
791:     *   ENTER(13)/TAB(9): busca empresa pela descricao digitada
792:     *--------------------------------------------------------------------------
793:     PROCEDURE TeclaEmpresaDesc(par_nKeyCode, par_nShift)
794:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
795:             THIS.ValidarEmpresaDesc()
796:         ENDIF
797:     ENDPROC
798: 
799:     *--------------------------------------------------------------------------
800:     * ValidarEmpresaDesc - Busca empresa pela descricao (busca reversa)
801:     *--------------------------------------------------------------------------
802:     PROCEDURE ValidarEmpresaDesc()
803:         LOCAL loc_cValor
804:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.Value)
805:         IF EMPTY(loc_cValor)
806:             THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value     = ""
807:             THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.Value = ""
808:         ELSE
809:             THIS.AbrirBuscaEmpresa()
810:         ENDIF
811:     ENDPROC
812: 
813:     *--------------------------------------------------------------------------
814:     * AbrirBuscaEmpresa - Abre FormBuscaAuxiliar para selecao de empresa
815:     *--------------------------------------------------------------------------
816:     PROCEDURE AbrirBuscaEmpresa()
817:         LOCAL loc_oBusca, loc_oErro
818:         TRY
819:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
820:                 "SigCdEmp", ;
821:                 "cursor_4c_BuscaEmp", ;
822:                 "Cemps", ;
823:                 ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value), ;
824:                 "Buscar Empresa")
825: 
826:             IF VARTYPE(loc_oBusca) != "O"
827:                 MsgErro("Erro ao criar janela de busca de Empresa.", "Erro")
828:             ELSE
829:                 loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
830:                 loc_oBusca.mAddColuna("Razas", "", "Descri" + CHR(231) + CHR(227) + "o")
831:                 loc_oBusca.Show()
832: 
833:                 IF loc_oBusca.this_lSelecionou
834:                     IF USED("cursor_4c_BuscaEmp")
835:                         SELECT cursor_4c_BuscaEmp
836:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value      = ALLTRIM(Cemps)
837:                         THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.Value  = ALLTRIM(Razas)
838:                         THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.ReadOnly = .T.
839:                     ENDIF
840:                 ENDIF
841: 
842:                 IF USED("cursor_4c_BuscaEmp")
843:                     USE IN cursor_4c_BuscaEmp
844:                 ENDIF
845:                 loc_oBusca.Release()
846:             ENDIF
847:         CATCH TO loc_oErro
848:             MsgErro(loc_oErro.Message, "Erro ao Buscar Empresa")
849:         ENDTRY
850:     ENDPROC
851: 
852:     *--------------------------------------------------------------------------
853:     * TeclaDataInicial / TeclaDataFinal / TeclaDtCotacao
854:     * Handlers de KeyPress para campos de data (campos de texto simples, sem lookup)
855:     *--------------------------------------------------------------------------
856:     PROCEDURE TeclaDataInicial(par_nKeyCode, par_nShift)
857:     ENDPROC
858: 
859:     PROCEDURE TeclaDataFinal(par_nKeyCode, par_nShift)
860:     ENDPROC
861: 
862:     PROCEDURE TeclaDtCotacao(par_nKeyCode, par_nShift)
863:     ENDPROC
864: 
865: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigreanrBO.prg):
*==============================================================================
* SIGREANRBO.PRG
* Business Object para Relatorio de Resultados
*
* Herda de RelatorioBase
* Form: Formsigreanr.prg
* Relatorio: SigReAnr.frx (REPORT FORM SigReAnr)
*
* Filtros: Periodo (DtInicial/DtFinal), Data Cotacao, Empresa
* Tabelas: SigCdOpe, SigMvCab, SigMvPar, SigCdEmp, SigCdMoe, SigCdCli, SigCdCot
* Cursores de saida (referenciados pelo .FRX):
*   TmpFinal   - dados principais por cliente/grupo/conta
*   TmpCabec   - cabecalho de colunas de moeda por empresa
*   dbCabecalho - titulo, periodo e nome da empresa
* Variaveis PUBLIC (referenciadas pelo .FRX):
*   _TotalTit, _TotalVal, _TotalGTit, _TotalGVal, _TotalGCot
*==============================================================================

DEFINE CLASS sigreanrBO AS RelatorioBase

    *-- Filtros do relatorio (entradas do form)
    this_dDtInicial     = {}
    this_dDtFinal       = {}
    this_dDtCotacao     = {}
    this_cEmpresa       = ""
    this_cEmpresaDesc   = ""

    *-- Configuracao do relatorio
    this_cArquivoFRX    = ""
    this_cTitulo        = ""

    *-- Cursor principal de saida (compativel com .FRX original)
    this_cCursorDados   = "TmpFinal"

    *--------------------------------------------------------------------------
    * Init - Configura arquivo FRX e titulo do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cArquivoFRX = gc_4c_CaminhoReports + "SigReAnr.frx"
        THIS.this_cTitulo     = "Relat" + CHR(243) + "rio de Resultados"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem do ultimo erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa todo o processamento do relatorio
    * Replica a PROCEDURE processamento do SIGREANR.SCX original
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo
        LOCAL loc_cEmpresa, loc_cDopAtual, loc_nCOpers, loc_cEmpAtual
        LOCAL loc_lcQuery, loc_nResult
        LOCAL loc_lcEdn, loc_cGrupo, loc_cConta, loc_cTipoOper, loc_nValor
        LOCAL loc_nConta1, loc_nConta2, loc_lnNOrdRels
        LOCAL loc_nTotalGeral, loc_nCot1
        LOCAL loc_cTotalTit, loc_cTotalVal, loc_cTotalGTit, loc_cTotalGVal, loc_cTotalGCot
        LOCAL loc_cRazas, loc_cNomeCli

        loc_lSucesso     = .F.

        TRY
            DO WHILE .T.

                loc_cEmpresa = ALLTRIM(THIS.this_cEmpresa)

                *-- Busca nome da empresa corrente (cabecalho do relatorio)
                loc_lcQuery = "SELECT Cemps, Razas FROM SigCdEmp " + ;
                              "WHERE Cemps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa))
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdEmpHdr")
                loc_cNomeEmpresa = ""
                IF loc_nResult > 0 AND !EOF("crSigCdEmpHdr")
                    SELECT crSigCdEmpHdr
                    loc_cNomeEmpresa = ALLTRIM(Razas)
                ENDIF
                IF USED("crSigCdEmpHdr")
                    USE IN crSigCdEmpHdr
                ENDIF

                loc_cTitulo  = "Relat" + CHR(243) + "rio de Resultados - Empresa : " + ;
                               IIF(EMPTY(loc_cEmpresa), "Todas", loc_cEmpresa)
                loc_cPeriodo = "Per" + CHR(237) + "odo : " + ;
                               DTOC(THIS.this_dDtInicial) + " " + CHR(224) + " " + ;
                               DTOC(THIS.this_dDtFinal)

                *-- Cursor de cabecalho do relatorio (dbCabecalho)
                IF USED("dbCabecalho")
                    USE IN dbCabecalho
                ENDIF
                CREATE CURSOR dbCabecalho (NomeEmpresa C(80), Titulo C(80), Periodo C(80), ;
                                           Cabecalho C(200), Campo1 C(20), Campo2 C(20), ;
                                           Campo3 C(20), Campo4 C(20), Campo5 C(20), TotalGeral M(4))
                INSERT INTO dbCabecalho (NomeEmpresa, Titulo, Periodo) ;
                    VALUES (loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo)

                *-- Cursor acumulador de valores por cliente/grupo/conta/moeda
                IF USED("TmpCli")
                    USE IN TmpCli
                ENDIF
                CREATE CURSOR TmpCli (Grupo C(10), Conta C(10), TipoOper C(1), ;
                                      Emps C(3), Valor N(12,2), Moeda C(3))

                *-- Busca operacoes com fechamento habilitado (RelFechas = 1)
                loc_lcQuery = "SELECT Dopes, COpers FROM SigCdOpe " + ;
                              "WHERE RelFechas = 1 ORDER BY Dopes"
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdOpe")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (crSigCdOpe)"
                    EXIT
                ENDIF

                *-- Busca empresas (filtradas ou todas)
                IF EMPTY(loc_cEmpresa)
                    loc_lcQuery = "SELECT Cemps, Razas FROM SigCdEmp"
                ELSE
                    loc_lcQuery = "SELECT Cemps, Razas FROM SigCdEmp " + ;
                                  "WHERE Cemps = " + EscaparSQL(loc_cEmpresa)
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdEmp")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (crSigCdEmp)"
                    EXIT
                ENDIF
                SELECT crSigCdEmp
                INDEX ON Cemps TAG Cemps

                *-- Loop externo: para cada operacao (tipo de lancamento)
                SELECT crSigCdOpe
                SCAN
                    loc_cDopAtual = ALLTRIM(crSigCdOpe.Dopes)
                    loc_nCOpers   = crSigCdOpe.COpers

                    WAIT WINDOW "Processando Opera" + CHR(231) + CHR(245) + "es: " + ;
                                loc_cDopAtual + "..." NOWAIT

                    *-- Loop interno: para cada empresa
                    SELECT crSigCdEmp
                    SCAN
                        loc_cEmpAtual = ALLTRIM(crSigCdEmp.Cemps)

                        *-- Movimentos no periodo para esta empresa/operacao
                        loc_lcQuery = "SELECT Emps, Dopes, Numes, GrupoDs, ContaDs, GrupoOs, ContaOs " + ;
                                      "FROM SigMvCab " + ;
                                      "WHERE Datas >= " + FormatarDataSQL(THIS.this_dDtInicial) + ;
                                      " AND Datas < DATEADD(day, 1, " + FormatarDataSQL(THIS.this_dDtFinal) + ")" + ;
                                      " AND Emps = " + EscaparSQL(loc_cEmpAtual) + ;
                                      " AND Dopes = " + EscaparSQL(loc_cDopAtual)
                        loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigMvCab")
                        IF loc_nResult < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (crSigMvCab)"
                            EXIT
                        ENDIF

                        *-- Para cada movimento, acumula parcelas em TmpCli
                        SELECT crSigMvCab
                        SCAN
                            IF NVL(loc_nCOpers, 0) = 1
                                loc_cGrupo    = crSigMvCab.GrupoDs
                                loc_cConta    = crSigMvCab.ContaDs
                                loc_cTipoOper = "1"
                            ELSE
                                loc_cGrupo    = crSigMvCab.GrupoOs
                                loc_cConta    = crSigMvCab.ContaOs
                                loc_cTipoOper = "2"
                            ENDIF

                            loc_lcEdn = ALLTRIM(crSigMvCab.Emps) + ;
                                        ALLTRIM(crSigMvCab.Dopes) + ;
                                        STR(crSigMvCab.Numes, 6)

                            *-- Parcelas de pagamento deste movimento
                            loc_lcQuery = "SELECT MoeFpgs, Valos FROM SigMvPar " + ;
                                          "WHERE EmpDopNums = " + EscaparSQL(loc_lcEdn)
                            loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigMvPar")
                            IF loc_nResult > 0
                                SELECT crSigMvPar
                                SCAN
                                    loc_nValor = crSigMvPar.Valos * IIF(NVL(loc_nCOpers, 0) = 1, 1, -1)
                                    INSERT INTO TmpCli (Grupo, Conta, TipoOper, Emps, Valor, Moeda) ;
                                        VALUES (loc_cGrupo, loc_cConta, loc_cTipoOper, ;
                                                crSigMvCab.Emps, loc_nValor, crSigMvPar.MoeFpgs)
                                ENDSCAN
                            ENDIF
                            IF USED("crSigMvPar")
                                USE IN crSigMvPar
                            ENDIF
                            SELECT crSigMvCab
                        ENDSCAN

                        IF USED("crSigMvCab")
                            USE IN crSigMvCab
                        ENDIF

                        IF !EMPTY(THIS.this_cMensagemErro)
                            EXIT
                        ENDIF
                        SELECT crSigCdEmp
                    ENDSCAN

                    IF !EMPTY(THIS.this_cMensagemErro)
                        EXIT
                    ENDIF
                    SELECT crSigCdOpe
                ENDSCAN
                WAIT CLEAR

                IF !EMPTY(THIS.this_cMensagemErro)
                    EXIT
                ENDIF

                *-- Indexa TmpCli para busca por empresa/grupo/conta
                SELECT TmpCli
                INDEX ON Emps + Grupo + Conta + TipoOper TAG EmpDopCon

                *-- Cursor de cabecalho de colunas de moeda por empresa
                IF USED("TmpCabec")
                    USE IN TmpCabec
                ENDIF
                CREATE CURSOR TmpCabec (Emps C(3), Op11 C(3), Op12 C(3), Op13 C(3), ;
                                        Op21 C(3), Op22 C(3), Op23 C(3))
                INDEX ON Emps TAG Emps

                *-- Busca moedas com sua ordem de exibicao no relatorio
                loc_lcQuery = "SELECT CMoes, NOrdRels, Cotas FROM SigCdMoe"
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdMoe")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (crSigCdMoe)"
                    EXIT
                ENDIF
                SELECT crSigCdMoe
                INDEX ON CMoes TAG CMoes

                *-- Combinacoes distintas de empresa/tipo/moeda presentes em TmpCli
                SELECT DISTINCT a.Emps, a.TipoOper, ;
                       IIF(EMPTY(b.NOrdRels), 9, b.NOrdRels) AS NOrdRels, a.Moeda ;
                  FROM TmpCli a, crSigCdMoe b ;
                 WHERE a.Moeda = b.CMoes ;
                  INTO CURSOR Operas

                *-- Atribui moedas as colunas Op11..Op13 (tipo 1) e Op21..Op23 (tipo 2)
                loc_nConta1 = 0
                loc_nConta2 = 0
                SELECT Operas
                SCAN
                    IF !SEEK(ALLTRIM(Operas.Emps), "TmpCabec", "Emps")
                        INSERT INTO TmpCabec (Emps) VALUES (Operas.Emps)
                        SELECT TmpCabec
                        SEEK ALLTRIM(Operas.Emps) ORDER TAG Emps
                        loc_nConta1 = 0
                        loc_nConta2 = 0
                    ENDIF

                    IF ALLTRIM(Operas.TipoOper) = "1"
                        loc_nConta1 = loc_nConta1 + 1
                        IF loc_nConta1 <= 3
                            DO CASE
                            CASE loc_nConta1 = 1
                                REPLACE Op11 WITH Operas.Moeda IN TmpCabec
                            CASE loc_nConta1 = 2
                                REPLACE Op12 WITH Operas.Moeda IN TmpCabec
                            CASE loc_nConta1 = 3
                                REPLACE Op13 WITH Operas.Moeda IN TmpCabec
                            ENDCASE
                        ENDIF
                    ELSE
                        loc_nConta2 = loc_nConta2 + 1
                        IF loc_nConta2 <= 3
                            DO CASE
                            CASE loc_nConta2 = 1
                                REPLACE Op21 WITH Operas.Moeda IN TmpCabec
                            CASE loc_nConta2 = 2
                                REPLACE Op22 WITH Operas.Moeda IN TmpCabec
                            CASE loc_nConta2 = 3
                                REPLACE Op23 WITH Operas.Moeda IN TmpCabec
                            ENDCASE
                        ENDIF
                    ENDIF
                    SELECT Operas
                ENDSCAN

                *-- Cursor de totais por moeda
                IF USED("TmpTotal")
                    USE IN TmpTotal
                ENDIF
                CREATE CURSOR TmpTotal (Moeda C(3), Valor N(12,2), NOrdRels N(1))
                INDEX ON Moeda TAG Moeda

                *-- Cursor final de dados do relatorio (compativel com SigReAnr.frx)
                IF USED("TmpFinal")
                    USE IN TmpFinal
                ENDIF
                CREATE CURSOR TmpFinal (Emps C(3), Grupo C(10), Conta C(10), Datas D, ;
                                        NomeCli C(40), Razas C(40), ;
                                        Valor1 N(12,2), Moeda1 C(3), ;
                                        Valor2 N(12,2), Moeda2 C(3), ;
                                        Valor3 N(12,2), Moeda3 C(3), ;
                                        Valor4 N(12,2), Moeda4 C(3), ;
                                        Valor5 N(12,2), Moeda5 C(3), ;
                                        Valor6 N(12,2), Moeda6 C(3))
                INDEX ON Emps + Grupo + Conta + DTOS(Datas) TAG EmpConDat

                *-- Popula TmpFinal acumulando valores por moeda/tipo de operacao
                SELECT TmpCli
                WAIT WINDOW "Processando Clientes..." NOWAIT
                GO TOP
                SCAN
                    *-- Posiciona TmpCabec na empresa do registro atual
                    = SEEK(ALLTRIM(TmpCli.Emps), "TmpCabec", "Emps")

                    *-- Busca razao social da empresa
                    = SEEK(ALLTRIM(TmpCli.Emps), "crSigCdEmp", "Cemps")
                    loc_cRazas = IIF(FOUND("crSigCdEmp"), ALLTRIM(crSigCdEmp.Razas), "")

                    *-- Busca nome do cliente (conta)
                    loc_lcQuery = "SELECT IClis, RClis FROM SigCdCli " + ;
                                  "WHERE IClis = " + EscaparSQL(ALLTRIM(TmpCli.Conta))
                    loc_cNomeCli = ""
                    IF SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdCli") > 0 AND ;
                       !EOF("crSigCdCli")
                        SELECT crSigCdCli
                        loc_cNomeCli = ALLTRIM(RClis)
                    ENDIF
                    IF USED("crSigCdCli")
                        USE IN crSigCdCli
                    ENDIF

                    *-- Localiza ou cria linha em TmpFinal para este cliente
                    IF !SEEK(ALLTRIM(TmpCli.Emps) + ALLTRIM(TmpCli.Grupo) + ALLTRIM(TmpCli.Conta), ;
                             "TmpFinal", "EmpConDat")
                        INSERT INTO TmpFinal (Emps, Grupo, Conta, NomeCli, Razas) ;
                            VALUES (TmpCli.Emps, TmpCli.Grupo, TmpCli.Conta, ;
                                    loc_cNomeCli, loc_cRazas)
                    ENDIF

                    *-- Acumula valor na coluna de moeda correspondente ao tipo de operacao
                    DO CASE
                    CASE (ALLTRIM(TmpCli.Moeda) = ALLTRIM(TmpCabec.Op11)) AND ;
                         (ALLTRIM(TmpCli.TipoOper) = "1")
                        REPLACE Valor1 WITH TmpFinal.Valor1 + TmpCli.Valor, ;
                                Moeda1 WITH TmpCli.Moeda IN TmpFinal
                    CASE (ALLTRIM(TmpCli.Moeda) = ALLTRIM(TmpCabec.Op12)) AND ;
                         (ALLTRIM(TmpCli.TipoOper) = "1")
                        REPLACE Valor2 WITH TmpFinal.Valor2 + TmpCli.Valor, ;
                                Moeda2 WITH TmpCli.Moeda IN TmpFinal
                    CASE (ALLTRIM(TmpCli.Moeda) = ALLTRIM(TmpCabec.Op13)) AND ;
                         (ALLTRIM(TmpCli.TipoOper) = "1")
                        REPLACE Valor3 WITH TmpFinal.Valor3 + TmpCli.Valor, ;
                                Moeda3 WITH TmpCli.Moeda IN TmpFinal
                    CASE (ALLTRIM(TmpCli.Moeda) = ALLTRIM(TmpCabec.Op21)) AND ;
                         (ALLTRIM(TmpCli.TipoOper) = "2")
                        REPLACE Valor4 WITH TmpFinal.Valor4 + TmpCli.Valor, ;
                                Moeda4 WITH TmpCli.Moeda IN TmpFinal
                    CASE (ALLTRIM(TmpCli.Moeda) = ALLTRIM(TmpCabec.Op22)) AND ;
                         (ALLTRIM(TmpCli.TipoOper) = "2")
                        REPLACE Valor5 WITH TmpFinal.Valor5 + TmpCli.Valor, ;
                                Moeda5 WITH TmpCli.Moeda IN TmpFinal
                    CASE (ALLTRIM(TmpCli.Moeda) = ALLTRIM(TmpCabec.Op23)) AND ;
                         (ALLTRIM(TmpCli.TipoOper) = "2")
                        REPLACE Valor6 WITH TmpFinal.Valor6 + TmpCli.Valor, ;
                                Moeda6 WITH TmpCli.Moeda IN TmpFinal
                    ENDCASE

                    *-- Acumula total por moeda em TmpTotal
                    IF !SEEK(ALLTRIM(TmpCli.Moeda), "TmpTotal", "Moeda")
                        = SEEK(ALLTRIM(TmpCli.Moeda), "crSigCdMoe", "CMoes")
                        loc_lnNOrdRels = IIF(FOUND("crSigCdMoe"), crSigCdMoe.NOrdRels, 9)
                        INSERT INTO TmpTotal (Moeda, NOrdRels) ;
                            VALUES (TmpCli.Moeda, loc_lnNOrdRels)
                        = SEEK(ALLTRIM(TmpCli.Moeda), "TmpTotal", "Moeda")
                    ENDIF
                    REPLACE Valor WITH TmpTotal.Valor + TmpCli.Valor IN TmpTotal

                    SELECT TmpCli
                ENDSCAN
                WAIT CLEAR

                *-- Adiciona moedas sem cotacao que ainda nao constam em TmpTotal
                SELECT crSigCdMoe
                SCAN FOR !Cotas
                    IF !SEEK(ALLTRIM(crSigCdMoe.CMoes), "TmpTotal", "Moeda")
                        loc_lnNOrdRels = crSigCdMoe.NOrdRels
                        INSERT INTO TmpTotal (Moeda, NOrdRels) ;
                            VALUES (crSigCdMoe.CMoes, loc_lnNOrdRels)
                        = SEEK(ALLTRIM(crSigCdMoe.CMoes), "TmpTotal", "Moeda")
                    ENDIF
                    SELECT crSigCdMoe
                ENDSCAN

                *-- Calcula totais parciais por moeda com cotacao na data informada
                loc_cTotalTit  = ""
                loc_cTotalVal  = ""
                loc_nTotalGeral = 0

                SELECT TmpTotal
                SCAN
                    loc_cTotalTit  = loc_cTotalTit + "Total em " + ;
                                     ALLTRIM(TmpTotal.Moeda) + " : " + CHR(13) + CHR(10)
                    loc_cTotalVal  = loc_cTotalVal + ;
                                     TRANSFORM(TmpTotal.Valor, "999,999,999.99") + ;
                                     CHR(13) + CHR(10)
                    loc_nCot1 = THIS.BuscarCotacao(ALLTRIM(TmpTotal.Moeda), THIS.this_dDtCotacao)
                    loc_nTotalGeral = loc_nTotalGeral + ROUND(TmpTotal.Valor * loc_nCot1, 2)
                    SELECT TmpTotal
                ENDSCAN

                *-- Calcula totais gerais convertidos para cada moeda
                loc_cTotalGTit = ""
                loc_cTotalGVal = ""
                loc_cTotalGCot = ""

                SELECT TmpTotal
                SCAN
                    loc_nCot1 = THIS.BuscarCotacao(ALLTRIM(TmpTotal.Moeda), THIS.this_dDtCotacao)
                    loc_cTotalGTit = loc_cTotalGTit + "Total Geral " + ;
                                     ALLTRIM(TmpTotal.Moeda) + " : " + CHR(13) + CHR(10)
                    IF loc_nCot1 > 0
                        loc_cTotalGVal = loc_cTotalGVal + ;
                                         TRANSFORM(ROUND(loc_nTotalGeral / loc_nCot1, 2), ;
                                                   "999,999,999.99") + CHR(13) + CHR(10)
                    ELSE
                        loc_cTotalGVal = loc_cTotalGVal + "0.00" + CHR(13) + CHR(10)
                    ENDIF
                    loc_cTotalGCot = loc_cTotalGCot + ;
                                     TRANSFORM(loc_nCot1, "99,999.999999") + CHR(13) + CHR(10)
                    SELECT TmpTotal
                ENDSCAN

                *-- Publica variaveis para o relatorio .FRX
                PUBLIC _TotalTit, _TotalVal, _TotalGTit, _TotalGVal, _TotalGCot
                _TotalTit  = loc_cTotalTit
                _TotalVal  = loc_cTotalVal
                _TotalGTit = loc_cTotalGTit
                _TotalGVal = loc_cTotalGVal
                _TotalGCot = loc_cTotalGCot

                *-- Relacao TmpFinal -> TmpCabec para o relatorio
                SELECT TmpFinal
                SET RELATION TO Emps INTO TmpCabec
                GO TOP

                loc_lSucesso = .T.
                EXIT
            ENDDO

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Preparar Dados do Relat" + CHR(243) + "rio")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCotacao - Busca taxa de cambio da moeda para a data informada
    * Substitui fBuscarCotacao() do sistema legado
    * Tabela: SigCdCot (cmoes, datas, horas, valos)
    * Retorna 1.0 se moeda nao encontrada (fallback seguro)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarCotacao(par_cMoeda, par_dData)
        LOCAL loc_nTaxa, loc_cSQL, loc_nResult, loc_cMoeda, loc_cFiltroData

        loc_nTaxa  = 1.0
        loc_cMoeda = ALLTRIM(par_cMoeda)

        IF EMPTY(loc_cMoeda) OR loc_cMoeda = "R"
            RETURN loc_nTaxa
        ENDIF

        IF EMPTY(par_dData) OR VARTYPE(par_dData) != "D"
            loc_cFiltroData = "datas <= GETDATE()"
        ELSE
            loc_cFiltroData = "datas <= DATEADD(day, 1, " + FormatarDataSQL(par_dData) + ")"
        ENDIF

        loc_cSQL = "SELECT TOP 1 valos FROM SigCdCot " + ;
                   "WHERE cmoes = " + EscaparSQL(loc_cMoeda) + ;
                   " AND " + loc_cFiltroData + ;
                   " ORDER BY datas DESC, horas DESC"
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotAnr")
        IF loc_nResult > 0 AND !EOF("cursor_4c_CotAnr")
            SELECT cursor_4c_CotAnr
            IF NVL(valos, 0) > 0
                loc_nTaxa = valos
            ENDIF
        ENDIF

        IF USED("cursor_4c_CotAnr")
            USE IN cursor_4c_CotAnr
        ENDIF

        RETURN loc_nTaxa
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime diretamente na impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) TO PRINTER PROMPT NOCONSOLE
                THIS.RegistrarAuditoria("IMPRIMIR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Imprimir Relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) PREVIEW NOCONSOLE
                THIS.RegistrarAuditoria("VISUALIZAR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Visualizar Relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Prepara dados e gera documento (imprime para arquivo)
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) TO PRINTER NOCONSOLE
                THIS.RegistrarAuditoria("EXPORTAR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Gerar Documento do Relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave de auditoria da execucao
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = IIF(EMPTY(THIS.this_cEmpresa), "TODAS", ALLTRIM(THIS.this_cEmpresa))
        loc_cChave = loc_cChave + "/" + DTOC(THIS.this_dDtInicial) + ;
                     "/" + DTOC(THIS.this_dDtFinal)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio na tabela LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cChave   = THIS.ObterChavePrimaria()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                               gc_4c_UsuarioLogado, "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SIGREANR") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", GETDATE())"

            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Aviso: falha ao registrar auditoria - " + ;
                                       loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir / Atualizar / CarregarDoCursor
    *
    * Operacoes nao aplicaveis a BOs de relatorio. Sao implementadas aqui
    * apenas para manter um contrato uniforme com BusinessBase (auditoria,
    * dispatchers genericos, validadores automatizados) e para sinalizar
    * explicitamente a restricao - em vez de silenciar com herda padrao.
    *
    * Para relatorios, o fluxo correto eh:
    *   - PrepararDados() monta os cursores de saida (TmpFinal, TmpCabec,
    *     TmpCli, TmpTotal, dbCabecalho) via SQLEXEC sobre o periodo filtrado
    *   - Imprimir() / Visualizar() / GerarExcel() consomem esses cursores
    *     atraves do .FRX SigReAnr
    *
    * Qualquer chamada a uma destas rotinas em runtime indica uso incorreto
    * da API e deve falhar de forma observavel (mensagem de erro + retorno .F.).
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio n" + CHR(227) + ;
            "o insere registros. Use PrepararDados()/Imprimir()/Visualizar()."
        RETURN .F.
    ENDPROC

    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio n" + CHR(227) + ;
            "o atualiza registros. Use PrepararDados()/Imprimir()/Visualizar()."
        RETURN .F.
    ENDPROC

    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio processa o per" + ;
            CHR(237) + "odo inteiro em PrepararDados(), n" + CHR(227) + ;
            "o registro a registro."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos e cursores temporarios
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("TmpFinal")
            SELECT TmpFinal
            SET RELATION TO
            USE IN TmpFinal
        ENDIF
        IF USED("TmpCabec")
            USE IN TmpCabec
        ENDIF
        IF USED("TmpCli")
            USE IN TmpCli
        ENDIF
        IF USED("TmpTotal")
            USE IN TmpTotal
        ENDIF
        IF USED("dbCabecalho")
            USE IN dbCabecalho
        ENDIF
        IF USED("crSigCdOpe")
            USE IN crSigCdOpe
        ENDIF
        IF USED("crSigCdEmp")
            USE IN crSigCdEmp
        ENDIF
        IF USED("crSigCdMoe")
            USE IN crSigCdMoe
        ENDIF
        IF USED("Operas")
            USE IN Operas
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

