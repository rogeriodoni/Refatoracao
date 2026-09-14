# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.Draw()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGf2.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1101 linhas total):

*-- Linhas 30 a 153:
30:     *--------------------------------------------------------------------------
31:     * Init - Recebe ref do form pai, compartilha datasession e inicializa
32:     * DataSessionId ?? compartilhado ANTES do DODEFAULT para que
33:     * InicializarForm acesse crRel1 (cursor populado pelo form pai)
34:     *--------------------------------------------------------------------------
35:     PROCEDURE Init(par_loForm1)
36:         IF VARTYPE(par_loForm1) = "O"
37:             THIS.poform1       = par_loForm1
38:             THIS.DataSessionId = par_loForm1.DataSessionId
39:         ELSE
40:             THIS.poform1 = THIS
41:         ENDIF
42: 
43:         RETURN DODEFAULT()
44:     ENDPROC
45: 
46:     *--------------------------------------------------------------------------
47:     * InicializarForm - Configura form, cria containers e prepara exibi????o
48:     *--------------------------------------------------------------------------
49:     PROTECTED PROCEDURE InicializarForm()
50:         LOCAL loc_lSucesso, loc_oErro
51:         loc_lSucesso = .F.
52: 
53:         TRY
54:             *-- Business Object
55:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrGf2BO")
56: 
57:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
58:                 *-- Propriedades visuais do form
59:                 THIS.Caption = "Gr" + CHR(225) + "fico de Falha X Recupera" + ;
60:                                CHR(231) + CHR(227) + "o Mensal"
61:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
62: 
63:                 *-- Inicializar cursor de cache do gr??fico (via BO)
64:                 THIS.this_oBusinessObject.InicializarCursorGrafico()
65: 
66:                 *-- Criar containers do layout
67:                 THIS.ConfigurarPageFrame()
68:                 THIS.ConfigurarPaginaLista()
69:                 THIS.ConfigurarPaginaDados()
70: 
71:                 *-- Sincronizar caption do cabecalho com o form
72:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
73:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
74: 
75:                 *-- Estado inicial: aguarde visivel, grafico oculto
76:                 THIS.AlternarPagina("AGUARDE")
77: 
78:                 *-- Exibir form com aguarde enquanto carrega o grafico
79:                 THIS.Refresh()
80:                 THIS.Show()
81:                 THIS.Draw()
82: 
83:                 *-- Gerar grafico inicial (popula combo + gera chart para item 1)
84:                 THIS.LockScreen = .T.
85:                 THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Clear()
86:                 THIS.GerarGrafico(1)
87: 
88:                 *-- Transicionar para estado de exibicao do grafico
89:                 THIS.AlternarPagina("GRAFICO")
90:                 THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex = 1
91:                 THIS.LockScreen = .F.
92: 
93:                 loc_lSucesso = .T.
94:             ELSE
95:                 MsgErro("Erro ao criar SigPrGf2BO. " + ;
96:                         "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
97:                         "Erro InicializarForm")
98:             ENDIF
99: 
100:         CATCH TO loc_oErro
101:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
102:                     " PROC=" + loc_oErro.Procedure, "Erro InicializarForm")
103:         ENDTRY
104: 
105:         RETURN loc_lSucesso
106:     ENDPROC
107: 
108:     *--------------------------------------------------------------------------
109:     * ConfigurarPageFrame - Cria containers e controles do form
110:     * Form OPERACIONAL sem PageFrame: nome mantido por convencao do pipeline;
111:     * o layout eh custom (cabecalho + grafico OLE + controles inferiores).
112:     *--------------------------------------------------------------------------
113:     PROTECTED PROCEDURE ConfigurarPageFrame()
114:         *-- === Cabe??alho cinza escuro (cntSombra do legado) ===
115:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
116:         WITH THIS.cnt_4c_Cabecalho
117:             .Top         = 0
118:             .Left        = 0
119:             .Width       = THIS.Width
120:             .Height      = 80
121:             .BackColor   = RGB(100, 100, 100)
122:             .BackStyle   = 1
123:             .BorderWidth = 0
124:             .Visible     = .T.
125: 
126:             .AddObject("lbl_4c_Sombra", "Label")
127:             WITH .lbl_4c_Sombra
128:                 .Top       = 18
129:                 .Left      = 10
130:                 .Width     = THIS.Width
131:                 .Height    = 40
132:                 .FontName  = "Tahoma"
133:                 .FontSize  = 18
134:                 .FontBold  = .T.
135:                 .BackStyle = 0
136:                 .ForeColor = RGB(0, 0, 0)
137:                 .WordWrap  = .T.
138:                 .AutoSize  = .F.
139:                 .Visible   = .T.
140:             ENDWITH
141: 
142:             .AddObject("lbl_4c_Titulo", "Label")
143:             WITH .lbl_4c_Titulo
144:                 .Top       = 17
145:                 .Left      = 10
146:                 .Width     = THIS.Width
147:                 .Height    = 46
148:                 .FontName  = "Tahoma"
149:                 .FontSize  = 18
150:                 .FontBold  = .T.
151:                 .BackStyle = 0
152:                 .ForeColor = RGB(255, 255, 255)
153:                 .WordWrap  = .T.

*-- Linhas 245 a 315:
245:     *--------------------------------------------------------------------------
246:     * Destroy - Libera recursos ao fechar o form
247:     *--------------------------------------------------------------------------
248:     PROCEDURE Destroy()
249:         LOCAL loc_oErro
250: 
251:         TRY
252:             *-- Limpar cursor de cache do gr??fico
253:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
254:                 THIS.this_oBusinessObject.LimparCursorGrafico()
255:                 THIS.this_oBusinessObject = .NULL.
256:             ENDIF
257: 
258:             *-- Reabilitar form pai (form era modeless e desabilitava o pai)
259:             IF VARTYPE(THIS.poform1) = "O" AND THIS.poform1 != THIS
260:                 THIS.poform1.LockScreen = .T.
261:                 THIS.poform1.Enabled   = .T.
262:                 THIS.poform1.LockScreen = .F.
263:             ENDIF
264: 
265:         CATCH TO loc_oErro
266:             MsgErro(loc_oErro.Message, "Erro Destroy FormSigPrGf2")
267:         ENDTRY
268: 
269:         DODEFAULT()
270:     ENDPROC
271: 
272:     *--------------------------------------------------------------------------
273:     * ConfigurarPaginaLista - Adiciona OLE e configura botoes do CommandGroup
274:     *--------------------------------------------------------------------------
275:     PROTECTED PROCEDURE ConfigurarPaginaLista()
276:         *-- OLE Bound Control para exibicao do grafico (oleGrafico1 do legado)
277:         THIS.cnt_4c_Grf1.AddObject("obj_4c_OleGrafico1", "OLEBoundControl")
278:         WITH THIS.cnt_4c_Grf1.obj_4c_OleGrafico1
279:             .Top     = 19
280:             .Left    = 5
281:             .Height  = 390
282:             .Width   = 760
283:             .Visible = .T.
284:         ENDWITH
285: 
286:         *-- Botao 1: Grafico (geral_grafico_pizza_60.jpg - icone do legado)
287:         WITH THIS.obj_4c_CmdgGrafico
288:             WITH .Buttons(1)
289:                 .Caption         = "Gr" + CHR(225) + "fico"
290:                 .Left            = 5
291:                 .Top             = 5
292:                 .Width           = 75
293:                 .Height          = 75
294:                 .FontBold        = .T.
295:                 .FontItalic      = .T.
296:                 .ForeColor       = RGB(90, 90, 90)
297:                 .BackColor       = RGB(255, 255, 255)
298:                 .Themes          = .F.
299:                 .SpecialEffect   = 0
300:                 .PicturePosition = 13
301:                 .Picture         = gc_4c_CaminhoIcones + "geral_grafico_pizza_60.jpg"
302:                 .WordWrap        = .T.
303:                 .MousePointer    = 15
304:             ENDWITH
305:             WITH .Buttons(2)
306:                 .Caption         = "Encerrar"
307:                 .Left            = 80
308:                 .Top             = 5
309:                 .Width           = 75
310:                 .Height          = 75
311:                 .FontName        = "Comic Sans MS"
312:                 .FontSize        = 8
313:                 .FontBold        = .T.
314:                 .FontItalic      = .T.
315:                 .ForeColor       = RGB(90, 90, 90)

*-- Linhas 323 a 584:
323:             ENDWITH
324:         ENDWITH
325: 
326:         *-- BINDEVENT: CommandGroup Click -> CmdGraficoClick (PUBLIC)
327:         BINDEVENT(THIS.obj_4c_CmdgGrafico, "Click", THIS, "CmdGraficoClick")
328:     ENDPROC
329: 
330:     *--------------------------------------------------------------------------
331:     * ConfigurarPaginaDados - Popula cnt_4c_Grf2 com Label e ComboBox
332:     * (cntGrf2.lblChave1 + cntGrf2.cmbChave1 do legado)
333:     * Items do combo sao populados em GerarGrafico() na primeira chamada.
334:     *--------------------------------------------------------------------------
335:     PROTECTED PROCEDURE ConfigurarPaginaDados()
336:         LOCAL loc_oGrf2
337:         loc_oGrf2 = THIS.cnt_4c_Grf2
338: 
339:         *-- Label "Grupo / Vendedor :" (lblChave1 do legado)
340:         loc_oGrf2.AddObject("lbl_4c_LblChave1", "Label")
341:         WITH loc_oGrf2.lbl_4c_LblChave1
342:             .Top       = 9
343:             .Left      = 7
344:             .Width     = 94
345:             .Height    = 15
346:             .FontName  = "Tahoma"
347:             .FontSize  = 8
348:             .BackStyle = 0
349:             .ForeColor = RGB(90, 90, 90)
350:             .Caption   = "Grupo / Vendedor :"
351:             .AutoSize  = .T.
352:             .Visible   = .T.
353:         ENDWITH
354: 
355:         *-- ComboBox de selecao de grupo/vendedor (cmbChave1 do legado)
356:         *-- Items populados em GerarGrafico() ao inicializar
357:         loc_oGrf2.AddObject("cbo_4c_CmbChave1", "ComboBox")
358:         WITH loc_oGrf2.cbo_4c_CmbChave1
359:             .Top               = 4
360:             .Left              = 129
361:             .Width             = 86
362:             .Height            = 25
363:             .FontName          = "Courier New"
364:             .FontSize          = 9
365:             .ColumnCount       = 1
366:             .ColumnLines       = .F.
367:             .IncrementalSearch = .T.
368:             .Style             = 2
369:             .ReadOnly          = .T.
370:             .Format            = "K"
371:             .Sorted            = .F.
372:             .SpecialEffect     = 0
373:             .Alignment         = 0
374:             .Visible           = .T.
375:         ENDWITH
376: 
377:         *-- BINDEVENTs: Click e GotFocus no ComboBox (PUBLIC handlers exigidos)
378:         BINDEVENT(loc_oGrf2.cbo_4c_CmbChave1, "Click",    THIS, "CboChave1Click")
379:         BINDEVENT(loc_oGrf2.cbo_4c_CmbChave1, "GotFocus", THIS, "CboChave1GotFocus")
380:     ENDPROC
381: 
382:     *--------------------------------------------------------------------------
383:     * CboChave1Click - Regera grafico para grupo/vendedor selecionado no combo
384:     *--------------------------------------------------------------------------
385:     PROCEDURE CboChave1Click()
386:         LOCAL loc_oErro
387: 
388:         TRY
389:             THIS.cnt_4c_Aguarde.Visible = .T.
390:             THIS.Refresh()
391:             THIS.Draw()
392:             THIS.LockScreen = .T.
393:             THIS.SetAll("Enabled", .F., "OLEBoundControl")
394: 
395:             THIS.GerarGrafico(THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex)
396: 
397:             THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus()
398:             THIS.cnt_4c_Aguarde.Visible = .F.
399:             THIS.Refresh()
400:             THIS.Draw()
401:             THIS.LockScreen = .F.
402: 
403:         CATCH TO loc_oErro
404:             THIS.LockScreen = .F.
405:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
406:                     "Erro CboChave1Click")
407:         ENDTRY
408:     ENDPROC
409: 
410:     *--------------------------------------------------------------------------
411:     * CboChave1GotFocus - Desabilita controles OLE quando combo recebe foco
412:     *--------------------------------------------------------------------------
413:     PROCEDURE CboChave1GotFocus()
414:         THIS.SetAll("Enabled", .F., "OLEBoundControl")
415:     ENDPROC
416: 
417:     *--------------------------------------------------------------------------
418:     * AlternarPagina - Alterna entre estado de espera e exibicao do grafico
419:     * par_cEstado: "AGUARDE" ou "GRAFICO"
420:     *--------------------------------------------------------------------------
421:     PROCEDURE AlternarPagina(par_cEstado)
422:         LOCAL loc_cEstado
423:         loc_cEstado = UPPER(ALLTRIM(IIF(VARTYPE(par_cEstado) = "C", par_cEstado, "AGUARDE")))
424: 
425:         DO CASE
426:         CASE loc_cEstado = "AGUARDE"
427:             THIS.cnt_4c_Aguarde.Visible     = .T.
428:             THIS.cnt_4c_Grf1.Visible        = .F.
429:             THIS.cnt_4c_Grf2.Visible        = .F.
430:             THIS.obj_4c_CmdgGrafico.Visible = .F.
431:         CASE loc_cEstado = "GRAFICO"
432:             THIS.cnt_4c_Aguarde.Visible     = .F.
433:             THIS.cnt_4c_Grf1.Visible        = .T.
434:             THIS.cnt_4c_Grf2.Visible        = .T.
435:             THIS.obj_4c_CmdgGrafico.Visible = .T.
436:         ENDCASE
437: 
438:         THIS.Refresh()
439:         THIS.Draw()
440:     ENDPROC
441: 
442:     *--------------------------------------------------------------------------
443:     * CmdGraficoClick - Handler do CommandGroup (despachante por .Value)
444:     *--------------------------------------------------------------------------
445:     PROCEDURE CmdGraficoClick()
446:         DO CASE
447:         CASE THIS.obj_4c_CmdgGrafico.Value = 1
448:             THIS.BtnGraficoClick()
449:         CASE THIS.obj_4c_CmdgGrafico.Value = 2
450:             THIS.BtnEncerrarClick()
451:         ENDCASE
452:     ENDPROC
453: 
454:     *--------------------------------------------------------------------------
455:     * BtnGraficoClick - Imprime grafico atual na impressora via SigPrGf1.frx
456:     *--------------------------------------------------------------------------
457:     PROTECTED PROCEDURE BtnGraficoClick()
458:         LOCAL loc_oErro, loc_cRelatorio, loc_nRecno
459:         LOCAL loc_cPoint, loc_cSep
460: 
461:         TRY
462:             THIS.LockScreen = .T.
463: 
464:             loc_cRelatorio = FULLPATH(gc_4c_CaminhoReports + "SigPrGf1.frx")
465: 
466:             IF NOT FILE(loc_cRelatorio)
467:                 MsgErro("Relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + ;
468:                         CHR(13) + loc_cRelatorio, ;
469:                         "Gr" + CHR(225) + "fico")
470:             ELSE
471:                 IF USED("crGrafico1") AND RECCOUNT("crGrafico1") > 0
472:                     loc_nRecno = RECNO("crGrafico1")
473:                     loc_cPoint = SET("POINT")
474:                     loc_cSep   = SET("SEPARATOR")
475: 
476:                     SET POINT TO "."
477:                     SET SEPARATOR TO ","
478:                     SET REPORTBEHAVIOR 80
479: 
480:                     SELECT crGrafico1
481:                     REPORT FORM (FULLPATH(gc_4c_CaminhoReports + "SigPrGf1")) ;
482:                         NEXT 1 TO PRINTER PROMPT NOCONSOLE
483: 
484:                     SET POINT TO (loc_cPoint)
485:                     SET SEPARATOR TO (loc_cSep)
486:                     SET REPORTBEHAVIOR 90
487: 
488:                     IF BETWEEN(loc_nRecno, 1, RECCOUNT("crGrafico1"))
489:                         GOTO loc_nRecno IN crGrafico1
490:                     ENDIF
491: 
492:                     THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus()
493:                 ELSE
494:                     MsgAviso("Nenhum gr" + CHR(225) + "fico dispon" + CHR(237) + ;
495:                              "vel para impress" + CHR(227) + "o.", ;
496:                              "Impress" + CHR(227) + "o")
497:                 ENDIF
498:             ENDIF
499: 
500:             THIS.Refresh()
501:             THIS.Draw()
502:             THIS.LockScreen = .F.
503: 
504:         CATCH TO loc_oErro
505:             THIS.LockScreen = .F.
506:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
507:                     "Erro BtnGraficoClick")
508:         ENDTRY
509:     ENDPROC
510: 
511:     *--------------------------------------------------------------------------
512:     * BtnEncerrarClick - Limpa OLE, fecha cursor de cache e libera o form
513:     *--------------------------------------------------------------------------
514:     PROTECTED PROCEDURE BtnEncerrarClick()
515:         LOCAL loc_oErro
516: 
517:         TRY
518:             THIS.LockScreen = .T.
519: 
520:             IF VARTYPE(THIS.cnt_4c_Grf1) = "O" AND ;
521:                PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)
522:                 THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
523:             ENDIF
524: 
525:             IF USED("crGrafico1")
526:                 USE IN crGrafico1
527:             ENDIF
528: 
529:             THIS.Release()
530: 
531:         CATCH TO loc_oErro
532:             THIS.LockScreen = .F.
533:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
534:                     "Erro BtnEncerrarClick")
535:         ENDTRY
536:     ENDPROC
537: 
538:     *--------------------------------------------------------------------------
539:     * GerarGrafico - Gera/exibe grafico OLE para o grupo/vendedor selecionado
540:     *   par_nLinha - Indice 1-based no ComboBox (0 ou omitido = usar primeiro)
541:     *   Equivale ao mgeragrafico do legado: popula combo na 1a chamada,
542:     *   gera dados via BO, configura objeto MSGraph.Chart no OLE Bound Control.
543:     *--------------------------------------------------------------------------
544:     PROTECTED PROCEDURE GerarGrafico(par_nLinha)
545:         LOCAL loc_lSucesso, loc_oErro
546:         LOCAL loc_nLinha, loc_cChave1
547:         LOCAL loc_nCount, loc_nTmStr
548:         LOCAL loc_lCacheMiss
549:         LOCAL loc_cPoint, loc_cSep
550:         LOCAL loc_i, loc_nGrupo, loc_nMes
551:         LOCAL loc_oOle
552:         LOCAL ARRAY loc_aChaves(1)
553: 
554:         loc_lSucesso  = .F.
555:         loc_lCacheMiss = .F.
556: 
557:         *-- Salvar locale antes de qualquer RETURN/CATCH
558:         loc_cPoint = SET("POINT")
559:         loc_cSep   = SET("SEPARATOR")
560:         SET POINT TO ","
561:         SET SEPARATOR TO "."
562: 
563:         TRY
564:             loc_nLinha = IIF(VARTYPE(par_nLinha) = "N" .AND. par_nLinha > 0, par_nLinha, 1)
565: 
566:             *-- === 1. Populacao inicial do ComboBox (apenas na primeira chamada) ===
567:             IF THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount = 0
568:                 DIMENSION loc_aChaves(1)
569:                 loc_nCount = THIS.this_oBusinessObject.ObterChavesGrafico(@loc_aChaves)
570: 
571:                 IF loc_nCount > 0
572:                     loc_nTmStr = LEN(ALLTRIM(loc_aChaves(1)))
573: 
574:                     WITH THIS.cnt_4c_Grf2.cbo_4c_CmbChave1
575:                         .Clear()
576:                         .RowSourceType = 0
577:                         .RowSource     = ""
578:                         .Width         = (loc_nTmStr * 7 + 9) + 20
579:                         .Height        = 25
580:                         .Top           = 5
581:                         .Left          = 5 + THIS.cnt_4c_Grf2.lbl_4c_LblChave1.Width
582:                         FOR loc_i = 1 TO loc_nCount
583:                             .AddItem(PADR(loc_aChaves(loc_i), loc_nTmStr))
584:                         ENDFOR

*-- Linhas 780 a 1101:
780:     * "nova consulta/processamento" do grafico com a chave inicial.
781:     * Existe para atender ao contrato da pipeline.
782:     *--------------------------------------------------------------------------
783:     PROCEDURE BtnIncluirClick()
784:         LOCAL loc_oErro
785: 
786:         TRY
787:             THIS.cnt_4c_Aguarde.Visible = .T.
788:             THIS.Refresh()
789:             THIS.Draw()
790:             THIS.LockScreen = .T.
791:             THIS.SetAll("Enabled", .F., "OLEBoundControl")
792: 
793:             *-- Regenera o grafico a partir do primeiro item do combo
794:             THIS.GerarGrafico(1)
795: 
796:             IF THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount > 0
797:                 THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex = 1
798:                 THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus()
799:             ENDIF
800: 
801:             THIS.cnt_4c_Aguarde.Visible = .F.
802:             THIS.Refresh()
803:             THIS.Draw()
804:             THIS.LockScreen = .F.
805: 
806:         CATCH TO loc_oErro
807:             THIS.LockScreen = .F.
808:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
809:                     " PROC=" + loc_oErro.Procedure, "Erro em BtnIncluirClick")
810:         ENDTRY
811:     ENDPROC
812: 
813:     *--------------------------------------------------------------------------
814:     * BtnAlterarClick - Habilita edicao interativa da chave: garante que o
815:     * ComboBox esteja habilitado e devolve foco ao combo para permitir troca
816:     * do grupo/vendedor. Nao ha UPDATE persistente em SigPrGf2 (form
817:     * OPERACIONAL sem entidade CRUD). Existe para atender ao contrato da
818:     * pipeline e como atalho equivalente a "editar selecao".
819:     *--------------------------------------------------------------------------
820:     PROCEDURE BtnAlterarClick()
821:         LOCAL loc_oErro
822: 
823:         TRY
824:             IF VARTYPE(THIS.cnt_4c_Grf2) = "O" AND ;
825:                PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
826:                 THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Enabled  = .T.
827:                 THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ReadOnly = .F.
828: 
829:                 IF THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount > 0
830:                     THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus()
831:                 ENDIF
832:             ENDIF
833: 
834:             THIS.Refresh()
835: 
836:         CATCH TO loc_oErro
837:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
838:                     " PROC=" + loc_oErro.Procedure, "Erro em BtnAlterarClick")
839:         ENDTRY
840:     ENDPROC
841: 
842:     *--------------------------------------------------------------------------
843:     * BtnVisualizarClick - Executa a regeracao/exibicao do grafico para a
844:     * chave atualmente selecionada no combo. Em forms OPERACIONAIS de
845:     * consulta/relatorio, "Visualizar" corresponde a executar a consulta e
846:     * exibir o resultado ??? delegamos para CboChave1Click para reaproveitar
847:     * o indicador cnt_4c_Aguarde, a chamada a GerarGrafico e o tratamento
848:     * de erros.
849:     *--------------------------------------------------------------------------
850:     PROCEDURE BtnVisualizarClick()
851:         THIS.CboChave1Click()
852:     ENDPROC
853: 
854:     *--------------------------------------------------------------------------
855:     * BtnExcluirClick - Limpa o cache do grafico e reseta o OLE Bound Control:
856:     * apaga registros do cursor crGrafico1, desvincula a ControlSource do OLE
857:     * e sinaliza o container de espera. Nao existe DELETE em SigPrGf2 (form
858:     * OPERACIONAL sem entidade persistida) ??? este evento existe para atender
859:     * ao contrato da pipeline e como atalho equivalente a "limpar consulta".
860:     *--------------------------------------------------------------------------
861:     PROCEDURE BtnExcluirClick()
862:         LOCAL loc_oErro
863: 
864:         TRY
865:             THIS.LockScreen = .T.
866: 
867:             *-- Desvincula o OLE Bound Control (para o grafico deixar de refletir cache)
868:             IF VARTYPE(THIS.cnt_4c_Grf1) = "O" AND ;
869:                PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)
870:                 TRY
871:                     THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
872:                 CATCH TO loc_oErro
873:                     *-- Erros OLE nao sao fatais aqui
874:                 ENDTRY
875:             ENDIF
876: 
877:             *-- Limpa cache do BO (ZAP em crGrafico1)
878:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
879:                 THIS.this_oBusinessObject.LimparCursorGrafico()
880:                 THIS.this_oBusinessObject.InicializarCursorGrafico()
881:             ENDIF
882: 
883:             *-- Estado de espera: grafico oculto, combo mantido para reselecao
884:             THIS.cnt_4c_Grf1.Visible    = .F.
885:             THIS.cnt_4c_Aguarde.Visible = .T.
886: 
887:             THIS.Refresh()
888:             THIS.Draw()
889:             THIS.LockScreen = .F.
890: 
891:         CATCH TO loc_oErro
892:             THIS.LockScreen = .F.
893:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
894:                     " PROC=" + loc_oErro.Procedure, "Erro em BtnExcluirClick")
895:         ENDTRY
896:     ENDPROC
897: 
898:     *--------------------------------------------------------------------------
899:     * CarregarLista - Regenera grafico OLE para o item atualmente selecionado
900:     * no ComboBox. Em form OPERACIONAL de visualizacao de grafico, nao ha lista
901:     * de registros para carregar ??? "CarregarLista" equivale a "regenerar grafico".
902:     *--------------------------------------------------------------------------
903:     PROCEDURE CarregarLista()
904:         LOCAL loc_lSucesso, loc_nIdx
905:         loc_lSucesso = .F.
906: 
907:         TRY
908:             IF VARTYPE(THIS.cnt_4c_Grf2) = "O" AND ;
909:                PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
910:                 loc_nIdx = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex
911:                 IF loc_nIdx < 1
912:                     loc_nIdx = 1
913:                 ENDIF
914:                 loc_lSucesso = THIS.GerarGrafico(loc_nIdx)
915:             ENDIF
916:         CATCH TO loc_oErro
917:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
918:                     "Erro CarregarLista")
919:         ENDTRY
920: 
921:         RETURN loc_lSucesso
922:     ENDPROC
923: 
924:     *--------------------------------------------------------------------------
925:     * FormParaBO - Copia o estado atual do form (selecao do combo) para o BO
926:     *--------------------------------------------------------------------------
927:     PROTECTED PROCEDURE FormParaBO()
928:         LOCAL loc_nIdx, loc_cChave
929: 
930:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
931:             RETURN
932:         ENDIF
933: 
934:         loc_cChave = ""
935: 
936:         IF VARTYPE(THIS.cnt_4c_Grf2) = "O" AND ;
937:            PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
938:             loc_nIdx = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex
939:             IF loc_nIdx > 0
940:                 loc_cChave = ALLTRIM(THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.List(loc_nIdx))
941:             ENDIF
942:         ENDIF
943: 
944:         THIS.this_oBusinessObject.this_cChave1 = loc_cChave
945:     ENDPROC
946: 
947:     *--------------------------------------------------------------------------
948:     * BOParaForm - Atualiza o form a partir do estado do BO
949:     * Sincroniza titulo do cabecalho com this_cCaption do BO
950:     *--------------------------------------------------------------------------
951:     PROTECTED PROCEDURE BOParaForm()
952:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
953:             RETURN
954:         ENDIF
955: 
956:         IF !EMPTY(THIS.this_oBusinessObject.this_cCaption)
957:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.this_oBusinessObject.this_cCaption
958:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.this_oBusinessObject.this_cCaption
959:         ENDIF
960:     ENDPROC
961: 
962:     *--------------------------------------------------------------------------
963:     * HabilitarCampos - Habilita ou desabilita controles do form
964:     * par_lHabilitar: .T. = habilitar, .F. = desabilitar
965:     *--------------------------------------------------------------------------
966:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
967:         LOCAL loc_lHabilitar
968:         loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
969: 
970:         IF VARTYPE(THIS.cnt_4c_Grf2) = "O" AND ;
971:            PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
972:             THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Enabled  = loc_lHabilitar
973:             THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ReadOnly = !loc_lHabilitar
974:         ENDIF
975: 
976:         IF VARTYPE(THIS.obj_4c_CmdgGrafico) = "O"
977:             THIS.obj_4c_CmdgGrafico.Enabled = loc_lHabilitar
978:         ENDIF
979:     ENDPROC
980: 
981:     *--------------------------------------------------------------------------
982:     * LimparCampos - Reseta combo, limpa cache do grafico e volta ao estado
983:     * de espera (cnt_4c_Aguarde). Equivalente a "limpar consulta".
984:     *--------------------------------------------------------------------------
985:     PROTECTED PROCEDURE LimparCampos()
986:         LOCAL loc_oErro
987: 
988:         TRY
989:             *-- Desvincula o OLE antes de zerar cursor (evita acesso a dados liberados)
990:             IF VARTYPE(THIS.cnt_4c_Grf1) = "O" AND ;
991:                PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)
992:                 TRY
993:                     THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
994:                 CATCH
995:                 ENDTRY
996:             ENDIF
997: 
998:             *-- Limpa e recria cursor de cache via BO
999:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1000:                 THIS.this_oBusinessObject.LimparCursorGrafico()
1001:                 THIS.this_oBusinessObject.InicializarCursorGrafico()
1002:             ENDIF
1003: 
1004:             *-- Resetar combo
1005:             IF VARTYPE(THIS.cnt_4c_Grf2) = "O" AND ;
1006:                PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
1007:                 THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Clear()
1008:             ENDIF
1009: 
1010:             *-- Exibir estado de espera
1011:             THIS.AlternarPagina("AGUARDE")
1012: 
1013:         CATCH TO loc_oErro
1014:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1015:                     "Erro LimparCampos")
1016:         ENDTRY
1017:     ENDPROC
1018: 
1019:     *--------------------------------------------------------------------------
1020:     * AjustarBotoesPorModo - Ajusta visibilidade do CommandGroup conforme estado
1021:     * Form OPERACIONAL sem modo CRUD: apenas garante que o CmdGroup esta visivel
1022:     * quando o grafico foi gerado.
1023:     *--------------------------------------------------------------------------
1024:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1025:         LOCAL loc_lTemGrafico
1026:         loc_lTemGrafico = USED("crGrafico1") AND RECCOUNT("crGrafico1") > 0
1027: 
1028:         IF VARTYPE(THIS.obj_4c_CmdgGrafico) = "O"
1029:             THIS.obj_4c_CmdgGrafico.Visible = loc_lTemGrafico
1030:         ENDIF
1031:     ENDPROC
1032: 
1033:     *--------------------------------------------------------------------------
1034:     * BtnBuscarClick - Dispara geracao/atualizacao do grafico para a selecao
1035:     * atual do ComboBox. Em form OPERACIONAL de grafico, "Buscar" equivale a
1036:     * "visualizar grafico para chave selecionada".
1037:     *--------------------------------------------------------------------------
1038:     PROCEDURE BtnBuscarClick()
1039:         THIS.CboChave1Click()
1040:     ENDPROC
1041: 
1042:     *--------------------------------------------------------------------------
1043:     * BtnSalvarClick - Form OPERACIONAL sem persistencia em banco de dados.
1044:     * Dados sao gerados dinamicamente a partir do cursor crRel1 do form pai
1045:     * e mantidos em memoria (crGrafico1). Nao ha operacao de salvamento.
1046:     *--------------------------------------------------------------------------
1047:     PROCEDURE BtnSalvarClick()
1048:         LOCAL loc_oErro, loc_nIdx
1049:         loc_nIdx = 1
1050: 
1051:         TRY
1052:             IF VARTYPE(THIS.cnt_4c_Grf2) = "O" AND ;
1053:                PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
1054:                 loc_nIdx = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex
1055:                 IF loc_nIdx < 1
1056:                     loc_nIdx = 1
1057:                 ENDIF
1058:             ENDIF
1059: 
1060:             THIS.GerarGrafico(loc_nIdx)
1061: 
1062:         CATCH TO loc_oErro
1063:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1064:                     " PROC=" + loc_oErro.Procedure, "Erro em BtnSalvarClick")
1065:         ENDTRY
1066:     ENDPROC
1067: 
1068:     *--------------------------------------------------------------------------
1069:     * BtnCancelarClick - Encerra o form (equivalente a Encerrar para este
1070:     * form OPERACIONAL que nao tem estado editavel a cancelar).
1071:     *--------------------------------------------------------------------------
1072:     PROCEDURE BtnCancelarClick()
1073:         THIS.BtnEncerrarClick()
1074:     ENDPROC
1075: 
1076:     *--------------------------------------------------------------------------
1077:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1078:     * Percorre Controls e sub-containers. Estado de exibicao dos containers
1079:     * principais (cnt_4c_Grf1/Grf2/CmdgGrafico) e gerenciado por AlternarPagina,
1080:     * portanto este metodo e chamado antes da primeira chamada a AlternarPagina.
1081:     *--------------------------------------------------------------------------
1082:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1083:         LOCAL loc_i, loc_oControl
1084: 
1085:         FOR loc_i = 1 TO par_oContainer.ControlCount
1086:             loc_oControl = par_oContainer.Controls(loc_i)
1087: 
1088:             IF VARTYPE(loc_oControl) = "O"
1089:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
1090:                     loc_oControl.Visible = .T.
1091:                 ENDIF
1092: 
1093:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
1094:                    loc_oControl.ControlCount > 0
1095:                     THIS.TornarControlesVisiveis(loc_oControl)
1096:                 ENDIF
1097:             ENDIF
1098:         ENDFOR
1099:     ENDPROC
1100: 
1101: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrGf2BO.prg):
*==============================================================================
* SigPrGf2BO.prg - Business Object: Grafico de Falha X Recuperacao Mensal
* Herda de: BusinessBase
* Tipo: OPERACIONAL - Visualizacao de grafico OLE (MSGraph)
* Sem tabela de banco - dados vem do cursor crRel1 do form pai
*==============================================================================
DEFINE CLASS SigPrGf2BO AS BusinessBase

    *-- Identificacao da entidade (sem tabela CRUD)
    this_cTabela     = ""
    this_cCampoChave = ""

    *-- Cursores utilizados
    this_cCursorOrigem  = "crRel1"      && Cursor com dados do form pai
    this_cCursorGrafico = "crGrafico1"  && Cursor de cache do grafico OLE

    *-- Configuracao do grafico
    this_nNumGrafico = 0    && Numero do grafico (pnnumgrf)
    this_cCaption    = ""   && Titulo exibido no cabecalho e no grafico

    *-- Chave de selecao atual (cmbChave1 - Grupo/Vendedor)
    this_cChave1 = ""       && Valor selecionado no ComboBox (cEmps)

    *-- Dados de titulo extraidos de crRel1
    this_cTitulo1   = ""    && Titulo linha 1 (crRel1.cTitulo1s)
    this_cTitulo2   = ""    && Titulo linha 2 (crRel1.cTitulo2s)
    this_cEmpresa   = ""    && Nome da empresa (crRel1.cEmpresas)

    *-- Series de dados (strings TAB-delimitadas para MSGraph)
    this_cStranomes  = ""   && Nomes dos meses (crRel1.cStranomes, TAB-sep)
    this_cStrFalhas  = ""   && Contagem de falhas (crRel1.nFalhas, TAB-sep)
    this_cStrPesoccb = ""   && Contagem de recuperacoes (crRel1.nPesoccbs, TAB-sep)

    *-- Dimensoes das series
    this_nNmeses  = 0       && Numero de periodos/meses encontrados
    this_nNgrupos = 2       && Numero de series no grafico (Falha + Recuperacao)

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            this_cTabela     = ""
            this_cCampoChave = ""
            this_cCaption    = "Gr" + CHR(225) + "fico de Falha X Recupera" + CHR(231) + CHR(227) + "o Mensal"
            this_nNgrupos    = 2

            loc_lResultado = DODEFAULT()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave do grafico (cEmps do vendedor/grupo)
    * Sem tabela SQL persistente: chave logica eh o valor selecionado no ComboBox
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cChave1)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    *   par_cAliasCursor - Nome do alias (crRel1 ou crGrafico1)
    *   Se omitido, usa this_cCursorOrigem (crRel1)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado, loc_cAlias
        loc_lResultado = .F.

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                         par_cAliasCursor, THIS.this_cCursorOrigem)

        TRY
            IF !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor " + loc_cAlias + " n" + CHR(227) + "o est" + CHR(225) + " aberto"
            ELSE
                SELECT (loc_cAlias)

                DO CASE
                CASE UPPER(loc_cAlias) == UPPER(THIS.this_cCursorOrigem)
                    *-- Mapeia crRel1 (cursor do form pai)
                    IF TYPE(loc_cAlias + ".cEmps") != "U"
                        THIS.this_cChave1 = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".cEmps"), ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".cTitulo1s") != "U"
                        THIS.this_cTitulo1 = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".cTitulo1s"), ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".cTitulo2s") != "U"
                        THIS.this_cTitulo2 = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".cTitulo2s"), ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".cEmpresas") != "U"
                        THIS.this_cEmpresa = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".cEmpresas"), ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".cStranomes") != "U"
                        THIS.this_cStranomes = NVL(EVALUATE(loc_cAlias + ".cStranomes"), "")
                    ENDIF
                    loc_lResultado = .T.
                CASE UPPER(loc_cAlias) == UPPER(THIS.this_cCursorGrafico)
                    *-- Mapeia crGrafico1 (cursor de cache do grafico OLE)
                    IF TYPE(loc_cAlias + ".cChave1s") != "U"
                        THIS.this_cChave1 = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".cChave1s"), ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".ctitulo1s") != "U"
                        THIS.this_cTitulo1 = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".ctitulo1s"), ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".cempresas") != "U"
                        THIS.this_cEmpresa = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".cempresas"), ""))
                    ENDIF
                    loc_lResultado = .T.
                OTHERWISE
                    THIS.this_cMensagemErro = "Alias n" + CHR(227) + "o suportado: " + loc_cAlias
                ENDCASE
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar cursor: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere registro de cache no cursor crGrafico1
    * Nao ha tabela persistente em SQL Server: cache eh mantido em memoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cChave
        loc_lResultado = .F.

        TRY
            loc_cChave = ALLTRIM(THIS.this_cChave1)

            IF EMPTY(loc_cChave)
                THIS.this_cMensagemErro = "Chave do gr" + CHR(225) + "fico n" + CHR(227) + "o informada"
            ELSE
                THIS.InicializarCursorGrafico()

                SELECT crGrafico1
                LOCATE FOR crGrafico1.cChave1s == PADR(loc_cChave, 100)

                IF !EOF("crGrafico1")
                    THIS.this_cMensagemErro = "Cache do gr" + CHR(225) + "fico j" + CHR(225) + " existe: " + loc_cChave
                ELSE
                    INSERT INTO crGrafico1 (cChave1s, ctitulo1s, cempresas) ;
                        VALUES (PADR(loc_cChave, 100), ;
                                PADR(THIS.this_cTitulo1, 128), ;
                                PADR(THIS.this_cEmpresa, 254))

                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inserir cache do gr" + CHR(225) + "fico: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro de cache do grafico
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cChave
        loc_lResultado = .F.

        TRY
            loc_cChave = ALLTRIM(THIS.this_cChave1)

            DO CASE
            CASE EMPTY(loc_cChave)
                THIS.this_cMensagemErro = "Chave do gr" + CHR(225) + "fico n" + CHR(227) + "o informada"
            CASE !USED("crGrafico1")
                THIS.this_cMensagemErro = "Cursor crGrafico1 n" + CHR(227) + "o est" + CHR(225) + " aberto"
            OTHERWISE
                SELECT crGrafico1
                LOCATE FOR crGrafico1.cChave1s == PADR(loc_cChave, 100)

                IF EOF("crGrafico1")
                    THIS.this_cMensagemErro = "Cache do gr" + CHR(225) + "fico n" + CHR(227) + "o encontrado: " + loc_cChave
                ELSE
                    REPLACE crGrafico1.ctitulo1s WITH PADR(THIS.this_cTitulo1, 128), ;
                            crGrafico1.cempresas  WITH PADR(THIS.this_cEmpresa, 254)

                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ENDIF
            ENDCASE

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar cache do gr" + CHR(225) + "fico: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra visualizacao do grafico em LogAuditoria
    *   par_cOperacao - "INSERT", "UPDATE" ou "VIEW"
    * Grafico OLE nao possui tabela persistente; auditoria usa "SigPrGf2" como
    *   tabela virtual e a chave selecionada como ChaveRegistro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cChave = THIS.ObterChavePrimaria()

            DO CASE
            CASE EMPTY(loc_cChave)
                *-- Sem chave: nao ha o que auditar
            CASE TYPE("gnConnHandle") != "N" OR gnConnHandle < 0
                *-- Sem conexao ativa: pula auditoria silenciosamente
            OTHERWISE
                loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

                loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                           "VALUES (" + EscaparSQL("SigPrGf2") + ", " + ;
                           EscaparSQL(par_cOperacao) + ", " + ;
                           EscaparSQL(loc_cChave) + ", " + ;
                           EscaparSQL(loc_cUsuario) + ", GETDATE())"

                SQLEXEC(gnConnHandle, loc_cSQL)
                loc_lResultado = .T.
            ENDCASE

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao registrar auditoria: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursorGrafico - Cria cursor crGrafico1 se nao existir
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursorGrafico()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF !USED("crGrafico1")
                SET NULL ON
                CREATE CURSOR crGrafico1 ;
                    (gGrafico1s G(4), cChave1s C(100), cempresas C(254), ctitulo1s C(128))
                SET NULL OFF
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavesGrafico - Retorna array de valores distintos de cEmps no crRel1
    *   par_aChaves - array BYREF que recebera as chaves
    *   Retorna: numero de chaves encontradas (0 se falhar)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavesGrafico(par_aChaves)
        LOCAL loc_nCount
        loc_nCount = 0

        TRY
            IF !USED(THIS.this_cCursorOrigem)
                loc_lResultado = 0
            ENDIF

            DIMENSION par_aChaves(1)
            par_aChaves = .F.

            SELECT DISTINCT cEmps ;
                FROM (THIS.this_cCursorOrigem) ;
                ORDER BY 1 ;
                INTO ARRAY par_aChaves

            loc_nCount = ALEN(par_aChaves, 1)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_nCount = 0
        ENDTRY

        RETURN loc_nCount
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosGrafico - Prepara crGrafico1 para a chave selecionada
    *   par_nLinha    - Indice (1-based) da chave no array de chaves
    *   par_aChaves   - Array com os valores de cEmps disponiveis
    *   Retorna .T. se os dados foram preparados com sucesso
    *   Efeito colateral: popula this_cChave1, this_cTitulo1, this_cEmpresa,
    *     this_cStranomes, this_cStrFalhas, this_cStrPesoccb, this_nNmeses
    *     e insere/garante registro em crGrafico1 (APPEND GENERAL gGrafico1s)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosGrafico(par_nLinha, par_aChaves)
        LOCAL loc_lResultado, loc_nLinha, loc_cChave1
        LOCAL loc_cTitulo1, loc_cEmpresa
        LOCAL loc_cStrg1, loc_cStrg2, loc_cStrg3, loc_nNmeses
        LOCAL loc_cTAB, loc_cCRLF

        loc_lResultado = .F.
        loc_cTAB  = CHR(9)
        loc_cCRLF = CHR(13) + CHR(10)

        TRY
            IF !USED(THIS.this_cCursorOrigem)
                loc_lResultado = .F.
            ENDIF

            loc_nLinha = IIF(VARTYPE(par_nLinha) = "N" .AND. par_nLinha > 0, par_nLinha, 1)

            IF VARTYPE(par_aChaves) != "A" OR ALEN(par_aChaves, 1) < loc_nLinha
                loc_lResultado = .F.
            ENDIF

            loc_cChave1 = ALLTRIM(par_aChaves(loc_nLinha))

            THIS.InicializarCursorGrafico()

            *-- Verificar cache
            SELECT crGrafico1
            LOCATE FOR crGrafico1.cChave1s == PADR(loc_cChave1, 100)

            IF EOF("crGrafico1")
                *-- Preparar series de dados a partir do cursor de origem
                loc_nNmeses = 0
                loc_cStrg2  = "Falha"
                loc_cStrg3  = "Recupera" + CHR(231) + CHR(227) + "o"
                loc_cStrg1  = ""
                loc_cTitulo1 = ""
                loc_cEmpresa = ""

                SELECT crRel1
                SET ORDER TO ("") IN crRel1
                LOCATE FOR crRel1.cEmps == loc_cChave1

                IF !EOF("crRel1")
                    loc_cTitulo1 = ALLTRIM(crRel1.cTitulo1s) + CHR(13) + ALLTRIM(crRel1.cTitulo2s)
                    loc_cEmpresa = crRel1.cEmpresas

                    SCAN WHILE crRel1.cEmps == loc_cChave1
                        loc_nNmeses = loc_nNmeses + 1
                        loc_cStrg1  = loc_cStrg1 + loc_cTAB + ALLTRIM(crRel1.cStranomes)
                        loc_cStrg2  = loc_cStrg2 + loc_cTAB + ;
                            ALLTRIM(TRANSFORM(crRel1.nFalhas, "999,999,999.99"))
                        loc_cStrg3  = loc_cStrg3 + loc_cTAB + ;
                            ALLTRIM(TRANSFORM(crRel1.nPesoccbs, "999,999,999.99"))
                    ENDSCAN
                ENDIF

                *-- Inserir no cache e gravar objeto OLE do grafico
                SELECT crGrafico1
                INSERT INTO crGrafico1 (cChave1s, ctitulo1s, cempresas) ;
                    VALUES (loc_cChave1, loc_cTitulo1, loc_cEmpresa)
                APPEND GENERAL gGrafico1s CLASS "MSGraph.Chart" ;
                    DATA (loc_cStrg1 + loc_cCRLF + loc_cStrg2 + loc_cCRLF + loc_cStrg3)

                *-- Atualizar propriedades do BO
                THIS.this_cChave1     = loc_cChave1
                THIS.this_cEmpresa    = loc_cEmpresa
                THIS.this_cTitulo1    = loc_cTitulo1
                THIS.this_cStranomes  = loc_cStrg1
                THIS.this_cStrFalhas  = loc_cStrg2
                THIS.this_cStrPesoccb = loc_cStrg3
                THIS.this_nNmeses     = loc_nNmeses
            ELSE
                *-- Recuperar titulo/empresa do cache
                THIS.this_cChave1  = ALLTRIM(crGrafico1.cChave1s)
                THIS.this_cTitulo1 = ALLTRIM(crGrafico1.ctitulo1s)
                THIS.this_cEmpresa = ALLTRIM(crGrafico1.cempresas)
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursorGrafico - Fecha cursor de cache do grafico
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursorGrafico()
        IF USED("crGrafico1")
            USE IN crGrafico1
        ENDIF
    ENDPROC

ENDDEFINE

