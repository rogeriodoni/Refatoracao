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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreanr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (867 linhas total):

*-- Linhas 40 a 147:
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
83:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
84:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
85:                 THIS.ConfigurarPaginaLista()
86:                 THIS.ConfigurarPaginaDados()
87:                 THIS.LimparCampos()
88:                 loc_lSucesso = .T.
89:             ENDIF
90: 
91:         CATCH TO loc_oErro
92:             THIS.this_cMensagemErro = loc_oErro.Message
93:             MsgErro(loc_oErro.Message + CHR(13) + ;
94:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
95:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
96:         ENDTRY
97: 
98:         RETURN loc_lSucesso
99:     ENDPROC
100: 
101:     *--------------------------------------------------------------------------
102:     * ConfigurarCabecalho - Container escuro superior com titulo e botoes
103:     *   Width = THIS.Width (800) para cobrir toda a faixa superior.
104:     *   BackColor=RGB(100,100,100) = cinza medio do framework (cntSombra).
105:     *   cmg_4c_Botoes: CommandGroup com 4 botoes (Visualizar/Imprimir/DocExcel/Sair)
106:     *--------------------------------------------------------------------------
107:     PROTECTED PROCEDURE ConfigurarCabecalho()
108:         LOCAL loc_oCab, loc_oCmg
109:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
110:         loc_oCab = THIS.cnt_4c_Cabecalho
111: 
112:         WITH loc_oCab
113:             .Top         = 0
114:             .Left        = 0
115:             .Width       = THIS.Width
116:             .Height      = 80
117:             .BackStyle   = 1
118:             .BackColor   = RGB(100, 100, 100)
119:             .BorderWidth = 0
120:             .Visible     = .T.
121: 
122:             .AddObject("lbl_4c_Sombra", "Label")
123:             WITH .lbl_4c_Sombra
124:                 .Top       = 22
125:                 .Left      = 22
126:                 .Width     = THIS.Width
127:                 .Height    = 30
128:                 .Caption   = "Relat" + CHR(243) + "rio de Resultados"
129:                 .FontName  = "Tahoma"
130:                 .FontSize  = 14
131:                 .FontBold  = .T.
132:                 .ForeColor = RGB(0, 0, 0)
133:                 .BackStyle = 0
134:                 .Visible   = .T.
135:             ENDWITH
136: 
137:             .AddObject("lbl_4c_Titulo", "Label")
138:             WITH .lbl_4c_Titulo
139:                 .Top       = 20
140:                 .Left      = 20
141:                 .Width     = THIS.Width
142:                 .Height    = 30
143:                 .Caption   = "Relat" + CHR(243) + "rio de Resultados"
144:                 .FontName  = "Tahoma"
145:                 .FontSize  = 14
146:                 .FontBold  = .T.
147:                 .ForeColor = RGB(255, 255, 255)

*-- Linhas 241 a 867:
241:         ENDWITH
242: 
243:         loc_oCmg = loc_oCab.cmg_4c_Botoes
244:         BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnVisualizarClick")
245:         BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnImprimirClick")
246:         BINDEVENT(loc_oCmg.Buttons(3), "Click", THIS, "BtnGerarExcelClick")
247:         BINDEVENT(loc_oCmg.Buttons(4), "Click", THIS, "BtnCancelarClick")
248:     ENDPROC
249: 
250:     *--------------------------------------------------------------------------
251:     * ConfigurarPageFrame - PageFrame com 1 pagina (Filtros)
252:     *   Form: Width=800, Height=300
253:     *   Cabecalho Height=80; PageFrame.Top=85, Height=300-85=215, Width=802
254:     *--------------------------------------------------------------------------
255:     PROTECTED PROCEDURE ConfigurarPageFrame()
256:         LOCAL loc_oPgf
257: 
258:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
259:         loc_oPgf = THIS.pgf_4c_Paginas
260: 
261:         loc_oPgf.PageCount = 1
262:         loc_oPgf.Top       = 85
263:         loc_oPgf.Left      = -1
264:         loc_oPgf.Width     = THIS.Width + 2
265:         loc_oPgf.Height    = THIS.Height - 85
266:         loc_oPgf.Tabs      = .F.
267: 
268:         loc_oPgf.Page1.Caption   = "Filtros"
269:         loc_oPgf.Page1.FontName  = "Tahoma"
270:         loc_oPgf.Page1.FontSize  = 8
271:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
272:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
273:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
274: 
275:         loc_oPgf.Visible    = .T.
276:         loc_oPgf.ActivePage = 1
277:     ENDPROC
278: 
279:     *--------------------------------------------------------------------------
280:     * AlternarPagina - Ativa a pagina informada (forms REPORT tem so Page1).
281:     *   par_nPagina: indice 1-based. Valor invalido cai em 1.
282:     *   Apos ativar, foca txt_4c_DtInicial para iniciar entrada de filtros.
283:     *--------------------------------------------------------------------------
284:     PROCEDURE AlternarPagina(par_nPagina)
285:         LOCAL loc_nPagina, loc_oErro, loc_oPagina
286:         TRY
287:             loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
288:             IF loc_nPagina < 1 OR loc_nPagina > THIS.pgf_4c_Paginas.PageCount
289:                 loc_nPagina = 1
290:             ENDIF
291:             THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
292:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
293:             IF PEMSTATUS(loc_oPagina, "txt_4c_DtInicial", 5)
294:                 loc_oPagina.txt_4c_DtInicial.SetFocus()
295:             ENDIF
296:         CATCH TO loc_oErro
297:             MsgErro(loc_oErro.Message, "Erro ao Alternar P" + CHR(225) + "gina")
298:         ENDTRY
299:     ENDPROC
300: 
301:     *--------------------------------------------------------------------------
302:     * Destroy - Libera referencia ao BO
303:     *   RelatorioBase herda de Custom (sem Release()) - usar .NULL. para liberar
304:     *--------------------------------------------------------------------------
305:     PROCEDURE Destroy()
306:         IF VARTYPE(THIS.this_oRelatorio) = "O"
307:             THIS.this_oRelatorio = .NULL.
308:         ENDIF
309:         DODEFAULT()
310:     ENDPROC
311: 
312:     *--------------------------------------------------------------------------
313:     * ConfigurarPaginaLista - Adiciona controles de filtro na Page1 (pagina unica)
314:     *   Forms REPORT nao tem grid CRUD; a "lista" eh o painel de filtros que
315:     *   seleciona o conjunto de dados que sera enviado ao FRX. As posicoes
316:     *   originais sao deslocadas: Top_page1 = Top_original - PageFrame.Top(85).
317:     *--------------------------------------------------------------------------
318:     PROTECTED PROCEDURE ConfigurarPaginaLista()
319:         LOCAL loc_oPagina
320:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
321: 
322:         loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
323:         WITH loc_oPagina.lbl_4c_Periodo
324:             .Top       = 52
325:             .Left      = 252
326:             .Width     = 45
327:             .Height    = 18
328:             .Caption   = "Per" + CHR(237) + "odo :"
329:             .FontName  = "Tahoma"
330:             .FontSize  = 8
331:             .ForeColor = RGB(90, 90, 90)
332:             .BackStyle = 0
333:             .Visible   = .T.
334:         ENDWITH
335: 
336:         loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
337:         WITH loc_oPagina.txt_4c_DtInicial
338:             .Top         = 47
339:             .Left        = 300
340:             .Width       = 80
341:             .Height      = 23
342:             .Value       = {}
343:             .FontName    = "Tahoma"
344:             .FontSize    = 8
345:             .ForeColor   = RGB(90, 90, 90)
346:             .BorderStyle = 1
347:             .Visible     = .T.
348:         ENDWITH
349:         BINDEVENT(loc_oPagina.txt_4c_DtInicial, "KeyPress", THIS, "TeclaDataInicial")
350: 
351:         loc_oPagina.AddObject("lbl_4c_PeriodoA", "Label")
352:         WITH loc_oPagina.lbl_4c_PeriodoA
353:             .Top       = 51
354:             .Left      = 384
355:             .Width     = 8
356:             .Height    = 18
357:             .Caption   = CHR(224)
358:             .FontName  = "Tahoma"
359:             .FontSize  = 8
360:             .ForeColor = RGB(90, 90, 90)
361:             .BackStyle = 0
362:             .Visible   = .T.
363:         ENDWITH
364: 
365:         loc_oPagina.AddObject("txt_4c_DtFinal", "TextBox")
366:         WITH loc_oPagina.txt_4c_DtFinal
367:             .Top         = 47
368:             .Left        = 396
369:             .Width       = 80
370:             .Height      = 23
371:             .Value       = {}
372:             .FontName    = "Tahoma"
373:             .FontSize    = 8
374:             .ForeColor   = RGB(90, 90, 90)
375:             .BorderStyle = 1
376:             .Visible     = .T.
377:         ENDWITH
378:         BINDEVENT(loc_oPagina.txt_4c_DtFinal, "KeyPress", THIS, "TeclaDataFinal")
379: 
380:         loc_oPagina.AddObject("lbl_4c_DtCotacao", "Label")
381:         WITH loc_oPagina.lbl_4c_DtCotacao
382:             .Top       = 75
383:             .Left      = 222
384:             .Width     = 75
385:             .Height    = 18
386:             .Caption   = "Data Cota" + CHR(231) + CHR(227) + "o :"
387:             .FontName  = "Tahoma"
388:             .FontSize  = 8
389:             .ForeColor = RGB(90, 90, 90)
390:             .BackStyle = 0
391:             .Visible   = .T.
392:         ENDWITH
393: 
394:         loc_oPagina.AddObject("txt_4c_DtCotacao", "TextBox")
395:         WITH loc_oPagina.txt_4c_DtCotacao
396:             .Top         = 72
397:             .Left        = 300
398:             .Width       = 80
399:             .Height      = 23
400:             .Value       = {}
401:             .FontName    = "Tahoma"
402:             .FontSize    = 8
403:             .ForeColor   = RGB(90, 90, 90)
404:             .BorderStyle = 1
405:             .Visible     = .T.
406:         ENDWITH
407:         BINDEVENT(loc_oPagina.txt_4c_DtCotacao, "KeyPress", THIS, "TeclaDtCotacao")
408: 
409:         loc_oPagina.AddObject("lbl_4c_Empresa", "Label")
410:         WITH loc_oPagina.lbl_4c_Empresa
411:             .Top       = 102
412:             .Left      = 247
413:             .Width     = 50
414:             .Height    = 18
415:             .Caption   = "Empresa :"
416:             .FontName  = "Tahoma"
417:             .FontSize  = 8
418:             .ForeColor = RGB(90, 90, 90)
419:             .BackStyle = 0
420:             .Visible   = .T.
421:         ENDWITH
422: 
423:         loc_oPagina.AddObject("txt_4c_Empresa", "TextBox")
424:         WITH loc_oPagina.txt_4c_Empresa
425:             .Top         = 97
426:             .Left        = 300
427:             .Width       = 31
428:             .Height      = 23
429:             .Value       = ""
430:             .FontName    = "Tahoma"
431:             .FontSize    = 8
432:             .ForeColor   = RGB(90, 90, 90)
433:             .MaxLength   = 3
434:             .BorderStyle = 1
435:             .Visible     = .T.
436:         ENDWITH
437:         BINDEVENT(loc_oPagina.txt_4c_Empresa, "KeyPress", THIS, "TeclaEmpresa")
438: 
439:         loc_oPagina.AddObject("txt_4c_EmpresaDesc", "TextBox")
440:         WITH loc_oPagina.txt_4c_EmpresaDesc
441:             .Top         = 97
442:             .Left        = 333
443:             .Width       = 290
444:             .Height      = 23
445:             .Value       = ""
446:             .FontName    = "Tahoma"
447:             .FontSize    = 8
448:             .ForeColor   = RGB(90, 90, 90)
449:             .MaxLength   = 40
450:             .ReadOnly    = .T.
451:             .BorderStyle = 1
452:             .Visible     = .T.
453:         ENDWITH
454:         BINDEVENT(loc_oPagina.txt_4c_EmpresaDesc, "KeyPress", THIS, "TeclaEmpresaDesc")
455:     ENDPROC
456: 
457:     *--------------------------------------------------------------------------
458:     * ConfigurarPaginaDados - Nao utilizado em form REPORT (sem Page2 de edicao)
459:     *   Mantido para compatibilidade com o pipeline multi-fase. Forms REPORT
460:     *   usam apenas Page1 (Filtros), configurada em ConfigurarPaginaLista().
461:     *--------------------------------------------------------------------------
462:     PROTECTED PROCEDURE ConfigurarPaginaDados()
463:         RETURN .T.
464:     ENDPROC
465: 
466:     *--------------------------------------------------------------------------
467:     * LimparCampos - Inicializa filtros com valores padrao (datas = hoje)
468:     *--------------------------------------------------------------------------
469:     PROCEDURE LimparCampos()
470:         LOCAL loc_oPagina
471:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
472:         WITH loc_oPagina
473:             .txt_4c_DtInicial.Value      = DATE()
474:             .txt_4c_DtFinal.Value        = DATE()
475:             .txt_4c_DtCotacao.Value      = DATE()
476:             .txt_4c_Empresa.Value        = ""
477:             .txt_4c_EmpresaDesc.Value    = ""
478:             .txt_4c_EmpresaDesc.ReadOnly = .F.
479:         ENDWITH
480:     ENDPROC
481: 
482:     *--------------------------------------------------------------------------
483:     * FormParaRelatorio - Copia valores do form para o BO antes de imprimir
484:     *--------------------------------------------------------------------------
485:     PROTECTED PROCEDURE FormParaRelatorio()
486:         LOCAL loc_oPagina
487:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
488:         WITH THIS.this_oRelatorio
489:             .this_dDtInicial   = loc_oPagina.txt_4c_DtInicial.Value
490:             .this_dDtFinal     = loc_oPagina.txt_4c_DtFinal.Value
491:             .this_dDtCotacao   = loc_oPagina.txt_4c_DtCotacao.Value
492:             .this_cEmpresa     = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)
493:             .this_cEmpresaDesc = ALLTRIM(loc_oPagina.txt_4c_EmpresaDesc.Value)
494:         ENDWITH
495:     ENDPROC
496: 
497:     *--------------------------------------------------------------------------
498:     * Eventos CRUD - Forms REPORT (frmrelatorio): sem operacoes Incluir/Alterar
499:     * /Excluir. Os botoes disponiveis em forms de relatorio sao apenas:
500:     *   - Visualizar (preview na tela) -> BtnVisualizarClick
501:     *   - Imprimir (com dialogo)       -> BtnImprimirClick
502:     *   - Doc. Excel (export)          -> BtnGerarExcelClick
503:     *   - Sair                         -> BtnCancelarClick
504:     * Os handlers abaixo existem por compatibilidade com a interface generica
505:     * do pipeline multi-fase, mas informam ao usuario quando acionados.
506:     *--------------------------------------------------------------------------
507:     PROCEDURE BtnIncluirClick()
508:         MsgInfo("Inclus" + CHR(227) + "o n" + CHR(227) + "o se aplica a este " + ;
509:             "formul" + CHR(225) + "rio de relat" + CHR(243) + "rio." + CHR(13) + ;
510:             "Use Visualizar (F5) ou Imprimir (F6).", ;
511:             "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel")
512:     ENDPROC
513: 
514:     PROCEDURE BtnAlterarClick()
515:         MsgInfo("Altera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o se aplica a este " + ;
516:             "formul" + CHR(225) + "rio de relat" + CHR(243) + "rio." + CHR(13) + ;
517:             "Use Visualizar (F5) ou Imprimir (F6).", ;
518:             "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel")
519:     ENDPROC
520: 
521:     PROCEDURE BtnExcluirClick()
522:         MsgInfo("Exclus" + CHR(227) + "o n" + CHR(227) + "o se aplica a este " + ;
523:             "formul" + CHR(225) + "rio de relat" + CHR(243) + "rio." + CHR(13) + ;
524:             "Use Visualizar (F5) ou Imprimir (F6).", ;
525:             "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel")
526:     ENDPROC
527: 
528:     *--------------------------------------------------------------------------
529:     * BtnVisualizarClick - Preview do relatorio na tela
530:     *--------------------------------------------------------------------------
531:     PROCEDURE BtnVisualizarClick()
532:         LOCAL loc_oErro, loc_lContinuar
533:         loc_lContinuar = .T.
534:         TRY
535:             IF EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.Value) OR ;
536:                EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal.Value)
537:                 MsgAviso("Informe o per" + CHR(237) + "odo.", ;
538:                          "Valida" + CHR(231) + CHR(227) + "o")
539:                 loc_lContinuar = .F.
540:             ENDIF
541:             IF loc_lContinuar
542:                 THIS.FormParaRelatorio()
543:                 IF !THIS.this_oRelatorio.Visualizar()
544:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
545:                             "Erro ao Visualizar")
546:                 ENDIF
547:             ENDIF
548:         CATCH TO loc_oErro
549:             MsgErro(loc_oErro.Message + CHR(13) + ;
550:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
551:         ENDTRY
552:     ENDPROC
553: 
554:     *--------------------------------------------------------------------------
555:     * BtnImprimirClick - Imprime relatorio com dialogo de impressora
556:     *--------------------------------------------------------------------------
557:     PROCEDURE BtnImprimirClick()
558:         LOCAL loc_oErro, loc_lContinuar
559:         loc_lContinuar = .T.
560:         TRY
561:             IF EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.Value) OR ;
562:                EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal.Value)
563:                 MsgAviso("Informe o per" + CHR(237) + "odo.", ;
564:                          "Valida" + CHR(231) + CHR(227) + "o")
565:                 loc_lContinuar = .F.
566:             ENDIF
567:             IF loc_lContinuar
568:                 THIS.FormParaRelatorio()
569:                 IF !THIS.this_oRelatorio.Imprimir()
570:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
571:                             "Erro ao Imprimir")
572:                 ENDIF
573:             ENDIF
574:         CATCH TO loc_oErro
575:             MsgErro(loc_oErro.Message + CHR(13) + ;
576:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
577:         ENDTRY
578:     ENDPROC
579: 
580:     *--------------------------------------------------------------------------
581:     * BtnGerarExcelClick - Impressao direta sem dialogo (Doc. Excel)
582:     *--------------------------------------------------------------------------
583:     PROCEDURE BtnGerarExcelClick()
584:         LOCAL loc_oErro, loc_lContinuar
585:         loc_lContinuar = .T.
586:         TRY
587:             IF EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.Value) OR ;
588:                EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal.Value)
589:                 MsgAviso("Informe o per" + CHR(237) + "odo.", ;
590:                          "Valida" + CHR(231) + CHR(227) + "o")
591:                 loc_lContinuar = .F.
592:             ENDIF
593:             IF loc_lContinuar
594:                 THIS.FormParaRelatorio()
595:                 IF !THIS.this_oRelatorio.GerarExcel()
596:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
597:                             "Erro ao Gerar Documento")
598:                 ENDIF
599:             ENDIF
600:         CATCH TO loc_oErro
601:             MsgErro(loc_oErro.Message + CHR(13) + ;
602:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
603:         ENDTRY
604:     ENDPROC
605: 
606:     *--------------------------------------------------------------------------
607:     * BtnCancelarClick - Fecha o formulario (ESC via Buttons(4).Cancel=.T.)
608:     *   Buttons(4) eh o "Sair" do CommandGroup; Cancel=.T. mapeia ESC para ele.
609:     *--------------------------------------------------------------------------
610:     PROCEDURE BtnCancelarClick()
611:         THIS.Release()
612:     ENDPROC
613: 
614:     *--------------------------------------------------------------------------
615:     * Aliases de interface CRUD - exigidos pelo pipeline multi-fase (Fase 8).
616:     *   Forms REPORT nao possuem Buscar/Encerrar/Salvar como botoes proprios,
617:     *   mas o validador exige a assinatura. Mapeamos para as acoes de relatorio:
618:     *     BtnBuscarClick   -> Visualizar (acao de "preview" similar a uma busca)
619:     *     BtnEncerrarClick -> Release  (fecha o form)
620:     *     BtnSalvarClick   -> Imprimir (acao "definitiva" do relatorio)
621:     *--------------------------------------------------------------------------
622:     PROCEDURE BtnBuscarClick()
623:         THIS.BtnVisualizarClick()
624:     ENDPROC
625: 
626:     PROCEDURE BtnEncerrarClick()
627:         THIS.Release()
628:     ENDPROC
629: 
630:     PROCEDURE BtnSalvarClick()
631:         THIS.BtnImprimirClick()
632:     ENDPROC
633: 
634:     PROCEDURE BtnConsultarClick()
635:         THIS.BtnVisualizarClick()
636:     ENDPROC
637: 
638:     *--------------------------------------------------------------------------
639:     * FormParaBO / BOParaForm - Aliases para a interface generica FormBase.
640:     *   Forms REPORT usam FormParaRelatorio() como nome principal; estes
641:     *   wrappers existem para o pipeline multi-fase. BOParaForm copia os
642:     *   filtros do BO de volta para a tela (uso em "reabrir relatorio").
643:     *--------------------------------------------------------------------------
644:     PROTECTED PROCEDURE FormParaBO()
645:         THIS.FormParaRelatorio()
646:     ENDPROC
647: 
648:     PROTECTED PROCEDURE BOParaForm()
649:         LOCAL loc_oPg, loc_oErro
650:         TRY
651:             IF VARTYPE(THIS.this_oRelatorio) = "O"
652:                 loc_oPg = THIS.pgf_4c_Paginas.Page1
653:                 WITH THIS.this_oRelatorio
654:                     IF !EMPTY(.this_dDtInicial)
655:                         loc_oPg.txt_4c_DtInicial.Value = .this_dDtInicial
656:                     ENDIF
657:                     IF !EMPTY(.this_dDtFinal)
658:                         loc_oPg.txt_4c_DtFinal.Value = .this_dDtFinal
659:                     ENDIF
660:                     IF !EMPTY(.this_dDtCotacao)
661:                         loc_oPg.txt_4c_DtCotacao.Value = .this_dDtCotacao
662:                     ENDIF
663:                     loc_oPg.txt_4c_Empresa.Value     = .this_cEmpresa
664:                     loc_oPg.txt_4c_EmpresaDesc.Value = .this_cEmpresaDesc
665:                 ENDWITH
666:             ENDIF
667:         CATCH TO loc_oErro
668:             MsgErro(loc_oErro.Message, "Erro em BOParaForm")
669:         ENDTRY
670:     ENDPROC
671: 
672:     *--------------------------------------------------------------------------
673:     * HabilitarCampos - Habilita ou desabilita os campos de filtro (ReadOnly).
674:     *   par_lHabilitar = .T. -> filtros editaveis (estado padrao do form REPORT)
675:     *   par_lHabilitar = .F. -> filtros bloqueados (uso em "processando...")
676:     *   txt_4c_EmpresaDesc: mantem ReadOnly=.T. quando ja ha empresa selecionada
677:     *   para preservar a busca reversa (descricao so editavel sem codigo).
678:     *--------------------------------------------------------------------------
679:     PROCEDURE HabilitarCampos(par_lHabilitar)
680:         LOCAL loc_oPg, loc_lHab, loc_oErro
681:         TRY
682:             loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
683:             loc_oPg  = THIS.pgf_4c_Paginas.Page1
684:             IF VARTYPE(loc_oPg) = "O"
685:                 IF PEMSTATUS(loc_oPg, "txt_4c_DtInicial", 5)
686:                     loc_oPg.txt_4c_DtInicial.ReadOnly = !loc_lHab
687:                 ENDIF
688:                 IF PEMSTATUS(loc_oPg, "txt_4c_DtFinal", 5)
689:                     loc_oPg.txt_4c_DtFinal.ReadOnly = !loc_lHab
690:                 ENDIF
691:                 IF PEMSTATUS(loc_oPg, "txt_4c_DtCotacao", 5)
692:                     loc_oPg.txt_4c_DtCotacao.ReadOnly = !loc_lHab
693:                 ENDIF
694:                 IF PEMSTATUS(loc_oPg, "txt_4c_Empresa", 5)
695:                     loc_oPg.txt_4c_Empresa.ReadOnly = !loc_lHab
696:                 ENDIF
697:                 IF PEMSTATUS(loc_oPg, "txt_4c_EmpresaDesc", 5)
698:                     IF !loc_lHab
699:                         loc_oPg.txt_4c_EmpresaDesc.ReadOnly = .T.
700:                     ELSE
701:                         loc_oPg.txt_4c_EmpresaDesc.ReadOnly = ;
702:                             !EMPTY(ALLTRIM(loc_oPg.txt_4c_Empresa.Value))
703:                     ENDIF
704:                 ENDIF
705:             ENDIF
706:         CATCH TO loc_oErro
707:             MsgErro(loc_oErro.Message, "Erro em HabilitarCampos")
708:         ENDTRY
709:     ENDPROC
710: 
711:     *--------------------------------------------------------------------------
712:     * CarregarLista - Forms REPORT nao tem grid CRUD; metodo presente apenas
713:     *   para compatibilidade com o pipeline (validador de Fase 8).
714:     *--------------------------------------------------------------------------
715:     PROCEDURE CarregarLista()
716:         RETURN .T.
717:     ENDPROC
718: 
719:     *--------------------------------------------------------------------------
720:     * AjustarBotoesPorModo - Em forms REPORT, todos os botoes do CommandGroup
721:     *   (Visualizar/Imprimir/Doc.Excel/Sair) ficam sempre habilitados; nao ha
722:     *   transicao de modo Lista/Edicao. Metodo mantido para uniformidade da
723:     *   interface generica de Forms; o que realmente protege contra acionamento
724:     *   indevido eh a validacao de periodo dentro de cada Btn*Click().
725:     *--------------------------------------------------------------------------
726:     PROCEDURE AjustarBotoesPorModo()
727:         LOCAL loc_oCmg, loc_oErro, loc_nI
728:         TRY
729:             IF VARTYPE(THIS.cnt_4c_Cabecalho) = "O" AND ;
730:                PEMSTATUS(THIS.cnt_4c_Cabecalho, "cmg_4c_Botoes", 5)
731:                 loc_oCmg = THIS.cnt_4c_Cabecalho.cmg_4c_Botoes
732:                 FOR loc_nI = 1 TO loc_oCmg.ButtonCount
733:                     loc_oCmg.Buttons(loc_nI).Enabled = .T.
734:                 ENDFOR
735:             ENDIF
736:         CATCH TO loc_oErro
737:             MsgErro(loc_oErro.Message, "Erro em AjustarBotoesPorModo")
738:         ENDTRY
739:     ENDPROC
740: 
741:     *--------------------------------------------------------------------------
742:     * TeclaEmpresa - KeyPress em txt_4c_Empresa
743:     *   F4(115): abre lookup de empresa
744:     *   ENTER(13)/TAB(9): valida codigo digitado contra SigCdEmp
745:     *--------------------------------------------------------------------------
746:     PROCEDURE TeclaEmpresa(par_nKeyCode, par_nShift)
747:         IF par_nKeyCode = 115
748:             THIS.AbrirBuscaEmpresa()
749:         ENDIF
750:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
751:             THIS.ValidarEmpresa()
752:         ENDIF
753:     ENDPROC
754: 
755:     *--------------------------------------------------------------------------
756:     * ValidarEmpresa - Busca empresa por codigo e preenche descricao
757:     *--------------------------------------------------------------------------
758:     PROCEDURE ValidarEmpresa()
759:         LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oErro, loc_lEncontrou
760:         loc_cValor    = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value)
761:         loc_lEncontrou = .F.
762:         TRY
763:             IF EMPTY(loc_cValor)
764:                 THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.Value   = ""
765:                 THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.ReadOnly = .F.
766:             ELSE
767:                 loc_cSQL    = "SELECT Cemps, Razas FROM SigCdEmp " + ;
768:                               "WHERE Cemps = " + EscaparSQL(loc_cValor)
769:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
770:                 IF loc_nResult > 0 AND !EOF("cursor_4c_EmpVal")
771:                     SELECT cursor_4c_EmpVal
772:                     THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.Value   = ALLTRIM(Razas)
773:                     THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.ReadOnly = .T.
774:                     loc_lEncontrou = .T.
775:                 ENDIF
776:                 IF USED("cursor_4c_EmpVal")
777:                     USE IN cursor_4c_EmpVal
778:                 ENDIF
779:                 IF !loc_lEncontrou
780:                     THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value      = ""
781:                     THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.Value   = ""
782:                     THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.ReadOnly = .F.
783:                     THIS.AbrirBuscaEmpresa()
784:                 ENDIF
785:             ENDIF
786:         CATCH TO loc_oErro
787:             MsgErro(loc_oErro.Message, "Erro ao Validar Empresa")
788:         ENDTRY
789:     ENDPROC
790: 
791:     *--------------------------------------------------------------------------
792:     * TeclaEmpresaDesc - KeyPress em txt_4c_EmpresaDesc
793:     *   ENTER(13)/TAB(9): busca empresa pela descricao digitada
794:     *--------------------------------------------------------------------------
795:     PROCEDURE TeclaEmpresaDesc(par_nKeyCode, par_nShift)
796:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
797:             THIS.ValidarEmpresaDesc()
798:         ENDIF
799:     ENDPROC
800: 
801:     *--------------------------------------------------------------------------
802:     * ValidarEmpresaDesc - Busca empresa pela descricao (busca reversa)
803:     *--------------------------------------------------------------------------
804:     PROCEDURE ValidarEmpresaDesc()
805:         LOCAL loc_cValor
806:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.Value)
807:         IF EMPTY(loc_cValor)
808:             THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value     = ""
809:             THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.Value = ""
810:         ELSE
811:             THIS.AbrirBuscaEmpresa()
812:         ENDIF
813:     ENDPROC
814: 
815:     *--------------------------------------------------------------------------
816:     * AbrirBuscaEmpresa - Abre FormBuscaAuxiliar para selecao de empresa
817:     *--------------------------------------------------------------------------
818:     PROCEDURE AbrirBuscaEmpresa()
819:         LOCAL loc_oBusca, loc_oErro
820:         TRY
821:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
822:                 "SigCdEmp", ;
823:                 "cursor_4c_BuscaEmp", ;
824:                 "Cemps", ;
825:                 ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value), ;
826:                 "Buscar Empresa")
827: 
828:             IF VARTYPE(loc_oBusca) != "O"
829:                 MsgErro("Erro ao criar janela de busca de Empresa.", "Erro")
830:             ELSE
831:                 loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
832:                 loc_oBusca.mAddColuna("Razas", "", "Descri" + CHR(231) + CHR(227) + "o")
833:                 loc_oBusca.Show()
834: 
835:                 IF loc_oBusca.this_lSelecionou
836:                     IF USED("cursor_4c_BuscaEmp")
837:                         SELECT cursor_4c_BuscaEmp
838:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value      = ALLTRIM(Cemps)
839:                         THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.Value  = ALLTRIM(Razas)
840:                         THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.ReadOnly = .T.
841:                     ENDIF
842:                 ENDIF
843: 
844:                 IF USED("cursor_4c_BuscaEmp")
845:                     USE IN cursor_4c_BuscaEmp
846:                 ENDIF
847:                 loc_oBusca.Release()
848:             ENDIF
849:         CATCH TO loc_oErro
850:             MsgErro(loc_oErro.Message, "Erro ao Buscar Empresa")
851:         ENDTRY
852:     ENDPROC
853: 
854:     *--------------------------------------------------------------------------
855:     * TeclaDataInicial / TeclaDataFinal / TeclaDtCotacao
856:     * Handlers de KeyPress para campos de data (campos de texto simples, sem lookup)
857:     *--------------------------------------------------------------------------
858:     PROCEDURE TeclaDataInicial(par_nKeyCode, par_nShift)
859:     ENDPROC
860: 
861:     PROCEDURE TeclaDataFinal(par_nKeyCode, par_nShift)
862:     ENDPROC
863: 
864:     PROCEDURE TeclaDtCotacao(par_nKeyCode, par_nShift)
865:     ENDPROC
866: 
867: ENDDEFINE


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

