# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGf2.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1097 linhas total):

*-- Linhas 30 a 152:
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
81: 
82:                 *-- Gerar grafico inicial (popula combo + gera chart para item 1)
83:                 THIS.LockScreen = .T.
84:                 THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Clear()
85:                 THIS.GerarGrafico(1)
86: 
87:                 *-- Transicionar para estado de exibicao do grafico
88:                 THIS.AlternarPagina("GRAFICO")
89:                 THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex = 1
90:                 THIS.LockScreen = .F.
91: 
92:                 loc_lSucesso = .T.
93:             ELSE
94:                 MsgErro("Erro ao criar SigPrGf2BO. " + ;
95:                         "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
96:                         "Erro InicializarForm")
97:             ENDIF
98: 
99:         CATCH TO loc_oErro
100:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
101:                     " PROC=" + loc_oErro.Procedure, "Erro InicializarForm")
102:         ENDTRY
103: 
104:         RETURN loc_lSucesso
105:     ENDPROC
106: 
107:     *--------------------------------------------------------------------------
108:     * ConfigurarPageFrame - Cria containers e controles do form
109:     * Form OPERACIONAL sem PageFrame: nome mantido por convencao do pipeline;
110:     * o layout eh custom (cabecalho + grafico OLE + controles inferiores).
111:     *--------------------------------------------------------------------------
112:     PROTECTED PROCEDURE ConfigurarPageFrame()
113:         *-- === Cabe??alho cinza escuro (cntSombra do legado) ===
114:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
115:         WITH THIS.cnt_4c_Cabecalho
116:             .Top         = 0
117:             .Left        = 0
118:             .Width       = THIS.Width
119:             .Height      = 80
120:             .BackColor   = RGB(100, 100, 100)
121:             .BackStyle   = 1
122:             .BorderWidth = 0
123:             .Visible     = .T.
124: 
125:             .AddObject("lbl_4c_Sombra", "Label")
126:             WITH .lbl_4c_Sombra
127:                 .Top       = 18
128:                 .Left      = 10
129:                 .Width     = THIS.Width
130:                 .Height    = 40
131:                 .FontName  = "Tahoma"
132:                 .FontSize  = 18
133:                 .FontBold  = .T.
134:                 .BackStyle = 0
135:                 .ForeColor = RGB(0, 0, 0)
136:                 .WordWrap  = .T.
137:                 .AutoSize  = .F.
138:                 .Visible   = .T.
139:             ENDWITH
140: 
141:             .AddObject("lbl_4c_Titulo", "Label")
142:             WITH .lbl_4c_Titulo
143:                 .Top       = 17
144:                 .Left      = 10
145:                 .Width     = THIS.Width
146:                 .Height    = 46
147:                 .FontName  = "Tahoma"
148:                 .FontSize  = 18
149:                 .FontBold  = .T.
150:                 .BackStyle = 0
151:                 .ForeColor = RGB(255, 255, 255)
152:                 .WordWrap  = .T.

*-- Linhas 244 a 314:
244:     *--------------------------------------------------------------------------
245:     * Destroy - Libera recursos ao fechar o form
246:     *--------------------------------------------------------------------------
247:     PROCEDURE Destroy()
248:         LOCAL loc_oErro
249: 
250:         TRY
251:             *-- Limpar cursor de cache do gr??fico
252:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
253:                 THIS.this_oBusinessObject.LimparCursorGrafico()
254:                 THIS.this_oBusinessObject = .NULL.
255:             ENDIF
256: 
257:             *-- Reabilitar form pai (form era modeless e desabilitava o pai)
258:             IF VARTYPE(THIS.poform1) = "O" AND THIS.poform1 != THIS
259:                 THIS.poform1.LockScreen = .T.
260:                 THIS.poform1.Enabled   = .T.
261:                 THIS.poform1.LockScreen = .F.
262:             ENDIF
263: 
264:         CATCH TO loc_oErro
265:             MsgErro(loc_oErro.Message, "Erro Destroy FormSigPrGf2")
266:         ENDTRY
267: 
268:         DODEFAULT()
269:     ENDPROC
270: 
271:     *--------------------------------------------------------------------------
272:     * ConfigurarPaginaLista - Adiciona OLE e configura botoes do CommandGroup
273:     *--------------------------------------------------------------------------
274:     PROTECTED PROCEDURE ConfigurarPaginaLista()
275:         *-- OLE Bound Control para exibicao do grafico (oleGrafico1 do legado)
276:         THIS.cnt_4c_Grf1.AddObject("obj_4c_OleGrafico1", "OLEBoundControl")
277:         WITH THIS.cnt_4c_Grf1.obj_4c_OleGrafico1
278:             .Top     = 19
279:             .Left    = 5
280:             .Height  = 390
281:             .Width   = 760
282:             .Visible = .T.
283:         ENDWITH
284: 
285:         *-- Botao 1: Grafico (geral_grafico_pizza_60.jpg - icone do legado)
286:         WITH THIS.obj_4c_CmdgGrafico
287:             WITH .Buttons(1)
288:                 .Caption         = "Gr" + CHR(225) + "fico"
289:                 .Left            = 5
290:                 .Top             = 5
291:                 .Width           = 75
292:                 .Height          = 75
293:                 .FontBold        = .T.
294:                 .FontItalic      = .T.
295:                 .ForeColor       = RGB(90, 90, 90)
296:                 .BackColor       = RGB(255, 255, 255)
297:                 .Themes          = .F.
298:                 .SpecialEffect   = 0
299:                 .PicturePosition = 13
300:                 .Picture         = gc_4c_CaminhoIcones + "geral_grafico_pizza_60.jpg"
301:                 .WordWrap        = .T.
302:                 .MousePointer    = 15
303:             ENDWITH
304:             WITH .Buttons(2)
305:                 .Caption         = "Encerrar"
306:                 .Left            = 80
307:                 .Top             = 5
308:                 .Width           = 75
309:                 .Height          = 75
310:                 .FontName        = "Tahoma"
311:                 .FontSize        = 8
312:                 .FontBold        = .T.
313:                 .FontItalic      = .T.
314:                 .ForeColor       = RGB(90, 90, 90)

*-- Linhas 322 a 579:
322:             ENDWITH
323:         ENDWITH
324: 
325:         *-- BINDEVENT: CommandGroup Click -> CmdGraficoClick (PUBLIC)
326:         BINDEVENT(THIS.obj_4c_CmdgGrafico, "Click", THIS, "CmdGraficoClick")
327:     ENDPROC
328: 
329:     *--------------------------------------------------------------------------
330:     * ConfigurarPaginaDados - Popula cnt_4c_Grf2 com Label e ComboBox
331:     * (cntGrf2.lblChave1 + cntGrf2.cmbChave1 do legado)
332:     * Items do combo sao populados em GerarGrafico() na primeira chamada.
333:     *--------------------------------------------------------------------------
334:     PROTECTED PROCEDURE ConfigurarPaginaDados()
335:         LOCAL loc_oGrf2
336:         loc_oGrf2 = THIS.cnt_4c_Grf2
337: 
338:         *-- Label "Grupo / Vendedor :" (lblChave1 do legado)
339:         loc_oGrf2.AddObject("lbl_4c_LblChave1", "Label")
340:         WITH loc_oGrf2.lbl_4c_LblChave1
341:             .Top       = 9
342:             .Left      = 7
343:             .Width     = 94
344:             .Height    = 15
345:             .FontName  = "Tahoma"
346:             .FontSize  = 8
347:             .BackStyle = 0
348:             .ForeColor = RGB(90, 90, 90)
349:             .Caption   = "Grupo / Vendedor :"
350:             .AutoSize  = .T.
351:             .Visible   = .T.
352:         ENDWITH
353: 
354:         *-- ComboBox de selecao de grupo/vendedor (cmbChave1 do legado)
355:         *-- Items populados em GerarGrafico() ao inicializar
356:         loc_oGrf2.AddObject("cbo_4c_CmbChave1", "ComboBox")
357:         WITH loc_oGrf2.cbo_4c_CmbChave1
358:             .Top               = 4
359:             .Left              = 129
360:             .Width             = 86
361:             .Height            = 25
362:             .FontName          = "Courier New"
363:             .FontSize          = 9
364:             .ColumnCount       = 1
365:             .ColumnLines       = .F.
366:             .IncrementalSearch = .T.
367:             .Style             = 2
368:             .ReadOnly          = .T.
369:             .Format            = "K"
370:             .Sorted            = .F.
371:             .SpecialEffect     = 0
372:             .Alignment         = 0
373:             .Visible           = .T.
374:         ENDWITH
375: 
376:         *-- BINDEVENTs: Click e GotFocus no ComboBox (PUBLIC handlers exigidos)
377:         BINDEVENT(loc_oGrf2.cbo_4c_CmbChave1, "Click",    THIS, "CboChave1Click")
378:         BINDEVENT(loc_oGrf2.cbo_4c_CmbChave1, "GotFocus", THIS, "CboChave1GotFocus")
379:     ENDPROC
380: 
381:     *--------------------------------------------------------------------------
382:     * CboChave1Click - Regera grafico para grupo/vendedor selecionado no combo
383:     *--------------------------------------------------------------------------
384:     PROCEDURE CboChave1Click()
385:         LOCAL loc_oErro
386: 
387:         TRY
388:             THIS.cnt_4c_Aguarde.Visible = .T.
389:             THIS.Refresh()
390:             THIS.LockScreen = .T.
391:             THIS.SetAll("Enabled", .F., "OLEBoundControl")
392: 
393:             THIS.GerarGrafico(THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex)
394: 
395:             THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus()
396:             THIS.cnt_4c_Aguarde.Visible = .F.
397:             THIS.Refresh()
398:             THIS.LockScreen = .F.
399: 
400:         CATCH TO loc_oErro
401:             THIS.LockScreen = .F.
402:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
403:                     "Erro CboChave1Click")
404:         ENDTRY
405:     ENDPROC
406: 
407:     *--------------------------------------------------------------------------
408:     * CboChave1GotFocus - Desabilita controles OLE quando combo recebe foco
409:     *--------------------------------------------------------------------------
410:     PROCEDURE CboChave1GotFocus()
411:         THIS.SetAll("Enabled", .F., "OLEBoundControl")
412:     ENDPROC
413: 
414:     *--------------------------------------------------------------------------
415:     * AlternarPagina - Alterna entre estado de espera e exibicao do grafico
416:     * par_cEstado: "AGUARDE" ou "GRAFICO"
417:     *--------------------------------------------------------------------------
418:     PROCEDURE AlternarPagina(par_cEstado)
419:         LOCAL loc_cEstado
420:         loc_cEstado = UPPER(ALLTRIM(IIF(VARTYPE(par_cEstado) = "C", par_cEstado, "AGUARDE")))
421: 
422:         DO CASE
423:         CASE loc_cEstado = "AGUARDE"
424:             THIS.cnt_4c_Aguarde.Visible     = .T.
425:             THIS.cnt_4c_Grf1.Visible        = .F.
426:             THIS.cnt_4c_Grf2.Visible        = .F.
427:             THIS.obj_4c_CmdgGrafico.Visible = .F.
428:         CASE loc_cEstado = "GRAFICO"
429:             THIS.cnt_4c_Aguarde.Visible     = .F.
430:             THIS.cnt_4c_Grf1.Visible        = .T.
431:             THIS.cnt_4c_Grf2.Visible        = .T.
432:             THIS.obj_4c_CmdgGrafico.Visible = .T.
433:         ENDCASE
434: 
435:         THIS.Refresh()
436:     ENDPROC
437: 
438:     *--------------------------------------------------------------------------
439:     * CmdGraficoClick - Handler do CommandGroup (despachante por .Value)
440:     *--------------------------------------------------------------------------
441:     PROCEDURE CmdGraficoClick()
442:         DO CASE
443:         CASE THIS.obj_4c_CmdgGrafico.Value = 1
444:             THIS.BtnGraficoClick()
445:         CASE THIS.obj_4c_CmdgGrafico.Value = 2
446:             THIS.BtnEncerrarClick()
447:         ENDCASE
448:     ENDPROC
449: 
450:     *--------------------------------------------------------------------------
451:     * BtnGraficoClick - Imprime grafico atual na impressora via SigPrGf1.frx
452:     *--------------------------------------------------------------------------
453:     PROTECTED PROCEDURE BtnGraficoClick()
454:         LOCAL loc_oErro, loc_cRelatorio, loc_nRecno
455:         LOCAL loc_cPoint, loc_cSep
456: 
457:         TRY
458:             THIS.LockScreen = .T.
459: 
460:             loc_cRelatorio = FULLPATH(gc_4c_CaminhoReports + "SigPrGf1.frx")
461: 
462:             IF NOT FILE(loc_cRelatorio)
463:                 MsgErro("Relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + ;
464:                         CHR(13) + loc_cRelatorio, ;
465:                         "Gr" + CHR(225) + "fico")
466:             ELSE
467:                 IF USED("crGrafico1") AND RECCOUNT("crGrafico1") > 0
468:                     loc_nRecno = RECNO("crGrafico1")
469:                     loc_cPoint = SET("POINT")
470:                     loc_cSep   = SET("SEPARATOR")
471: 
472:                     SET POINT TO "."
473:                     SET SEPARATOR TO ","
474:                     SET REPORTBEHAVIOR 80
475: 
476:                     SELECT crGrafico1
477:                     REPORT FORM (FULLPATH(gc_4c_CaminhoReports + "SigPrGf1")) ;
478:                         NEXT 1 TO PRINTER PROMPT NOCONSOLE
479: 
480:                     SET POINT TO (loc_cPoint)
481:                     SET SEPARATOR TO (loc_cSep)
482:                     SET REPORTBEHAVIOR 90
483: 
484:                     IF BETWEEN(loc_nRecno, 1, RECCOUNT("crGrafico1"))
485:                         GOTO loc_nRecno IN crGrafico1
486:                     ENDIF
487: 
488:                     THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus()
489:                 ELSE
490:                     MsgAviso("Nenhum gr" + CHR(225) + "fico dispon" + CHR(237) + ;
491:                              "vel para impress" + CHR(227) + "o.", ;
492:                              "Impress" + CHR(227) + "o")
493:                 ENDIF
494:             ENDIF
495: 
496:             THIS.Refresh()
497:             THIS.LockScreen = .F.
498: 
499:         CATCH TO loc_oErro
500:             THIS.LockScreen = .F.
501:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
502:                     "Erro BtnGraficoClick")
503:         ENDTRY
504:     ENDPROC
505: 
506:     *--------------------------------------------------------------------------
507:     * BtnEncerrarClick - Limpa OLE, fecha cursor de cache e libera o form
508:     *--------------------------------------------------------------------------
509:     PROTECTED PROCEDURE BtnEncerrarClick()
510:         LOCAL loc_oErro
511: 
512:         TRY
513:             THIS.LockScreen = .T.
514: 
515:             IF VARTYPE(THIS.cnt_4c_Grf1) = "O" AND ;
516:                PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)
517:                 THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
518:             ENDIF
519: 
520:             IF USED("crGrafico1")
521:                 USE IN crGrafico1
522:             ENDIF
523: 
524:             THIS.Release()
525: 
526:         CATCH TO loc_oErro
527:             THIS.LockScreen = .F.
528:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
529:                     "Erro BtnEncerrarClick")
530:         ENDTRY
531:     ENDPROC
532: 
533:     *--------------------------------------------------------------------------
534:     * GerarGrafico - Gera/exibe grafico OLE para o grupo/vendedor selecionado
535:     *   par_nLinha - Indice 1-based no ComboBox (0 ou omitido = usar primeiro)
536:     *   Equivale ao mgeragrafico do legado: popula combo na 1a chamada,
537:     *   gera dados via BO, configura objeto MSGraph.Chart no OLE Bound Control.
538:     *--------------------------------------------------------------------------
539:     PROTECTED PROCEDURE GerarGrafico(par_nLinha)
540:         LOCAL loc_lSucesso, loc_oErro
541:         LOCAL loc_nLinha, loc_cChave1
542:         LOCAL loc_nCount, loc_nTmStr
543:         LOCAL loc_lCacheMiss
544:         LOCAL loc_cPoint, loc_cSep
545:         LOCAL loc_i, loc_nGrupo, loc_nMes
546:         LOCAL loc_oOle
547:         LOCAL ARRAY loc_aChaves(1)
548: 
549:         loc_lSucesso  = .F.
550:         loc_lCacheMiss = .F.
551: 
552:         *-- Salvar locale antes de qualquer RETURN/CATCH
553:         loc_cPoint = SET("POINT")
554:         loc_cSep   = SET("SEPARATOR")
555:         SET POINT TO ","
556:         SET SEPARATOR TO "."
557: 
558:         TRY
559:             loc_nLinha = IIF(VARTYPE(par_nLinha) = "N" .AND. par_nLinha > 0, par_nLinha, 1)
560: 
561:             *-- === 1. Populacao inicial do ComboBox (apenas na primeira chamada) ===
562:             IF THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount = 0
563:                 DIMENSION loc_aChaves(1)
564:                 loc_nCount = THIS.this_oBusinessObject.ObterChavesGrafico(@loc_aChaves)
565: 
566:                 IF loc_nCount > 0
567:                     loc_nTmStr = LEN(ALLTRIM(loc_aChaves(1)))
568: 
569:                     WITH THIS.cnt_4c_Grf2.cbo_4c_CmbChave1
570:                         .Clear()
571:                         .RowSourceType = 0
572:                         .RowSource     = ""
573:                         .Width         = (loc_nTmStr * 7 + 9) + 20
574:                         .Height        = 25
575:                         .Top           = 5
576:                         .Left          = 5 + THIS.cnt_4c_Grf2.lbl_4c_LblChave1.Width
577:                         FOR loc_i = 1 TO loc_nCount
578:                             .AddItem(PADR(loc_aChaves(loc_i), loc_nTmStr))
579:                         ENDFOR

*-- Linhas 774 a 1097:
774:     * "nova consulta/processamento" do grafico com a chave inicial.
775:     * Existe para atender ao contrato da pipeline.
776:     *--------------------------------------------------------------------------
777:     PROCEDURE BtnIncluirClick()
778:         LOCAL loc_oErro
779: 
780:         TRY
781:             THIS.cnt_4c_Aguarde.Visible = .T.
782:             THIS.Refresh()
783:             THIS.LockScreen = .T.
784:             THIS.SetAll("Enabled", .F., "OLEBoundControl")
785: 
786:             *-- Regenera o grafico a partir do primeiro item do combo
787:             THIS.GerarGrafico(1)
788: 
789:             IF THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount > 0
790:                 THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex = 1
791:                 THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus()
792:             ENDIF
793: 
794:             THIS.cnt_4c_Aguarde.Visible = .F.
795:             THIS.Refresh()
796:             THIS.LockScreen = .F.
797: 
798:         CATCH TO loc_oErro
799:             THIS.LockScreen = .F.
800:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
801:                     " PROC=" + loc_oErro.Procedure, "Erro em BtnIncluirClick")
802:         ENDTRY
803:     ENDPROC
804: 
805:     *--------------------------------------------------------------------------
806:     * BtnAlterarClick - Habilita edicao interativa da chave: garante que o
807:     * ComboBox esteja habilitado e devolve foco ao combo para permitir troca
808:     * do grupo/vendedor. Nao ha UPDATE persistente em SigPrGf2 (form
809:     * OPERACIONAL sem entidade CRUD). Existe para atender ao contrato da
810:     * pipeline e como atalho equivalente a "editar selecao".
811:     *--------------------------------------------------------------------------
812:     PROCEDURE BtnAlterarClick()
813:         LOCAL loc_oErro
814: 
815:         TRY
816:             IF VARTYPE(THIS.cnt_4c_Grf2) = "O" AND ;
817:                PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
818:                 THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Enabled  = .T.
819:                 THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ReadOnly = .F.
820: 
821:                 IF THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount > 0
822:                     THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus()
823:                 ENDIF
824:             ENDIF
825: 
826:             THIS.Refresh()
827: 
828:         CATCH TO loc_oErro
829:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
830:                     " PROC=" + loc_oErro.Procedure, "Erro em BtnAlterarClick")
831:         ENDTRY
832:     ENDPROC
833: 
834:     *--------------------------------------------------------------------------
835:     * BtnVisualizarClick - Executa a regeracao/exibicao do grafico para a
836:     * chave atualmente selecionada no combo. Em forms OPERACIONAIS de
837:     * consulta/relatorio, "Visualizar" corresponde a executar a consulta e
838:     * exibir o resultado ??? delegamos para CboChave1Click para reaproveitar
839:     * o indicador cnt_4c_Aguarde, a chamada a GerarGrafico e o tratamento
840:     * de erros.
841:     *--------------------------------------------------------------------------
842:     PROCEDURE BtnVisualizarClick()
843:         THIS.CboChave1Click()
844:     ENDPROC
845: 
846:     *--------------------------------------------------------------------------
847:     * BtnExcluirClick - Limpa o cache do grafico e reseta o OLE Bound Control:
848:     * apaga registros do cursor crGrafico1, desvincula a ControlSource do OLE
849:     * e sinaliza o container de espera. Nao existe DELETE em SigPrGf2 (form
850:     * OPERACIONAL sem entidade persistida) ??? este evento existe para atender
851:     * ao contrato da pipeline e como atalho equivalente a "limpar consulta".
852:     *--------------------------------------------------------------------------
853:     PROCEDURE BtnExcluirClick()
854:         LOCAL loc_oErro
855: 
856:         TRY
857:             THIS.LockScreen = .T.
858: 
859:             *-- Desvincula o OLE Bound Control (para o grafico deixar de refletir cache)
860:             IF VARTYPE(THIS.cnt_4c_Grf1) = "O" AND ;
861:                PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)
862:                 TRY
863:                     THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
864:                 CATCH TO loc_oErro
865:                     *-- Erros OLE nao sao fatais aqui
866:                 ENDTRY
867:             ENDIF
868: 
869:             *-- Limpa cache do BO (ZAP em crGrafico1)
870:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
871:                 THIS.this_oBusinessObject.LimparCursorGrafico()
872:                 THIS.this_oBusinessObject.InicializarCursorGrafico()
873:             ENDIF
874: 
875:             *-- Estado de espera: grafico oculto, combo mantido para reselecao
876:             THIS.cnt_4c_Grf1.Visible    = .F.
877:             THIS.cnt_4c_Aguarde.Visible = .T.
878: 
879:             THIS.Refresh()
880:             THIS.LockScreen = .F.
881: 
882:         CATCH TO loc_oErro
883:             THIS.LockScreen = .F.
884:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
885:                     " PROC=" + loc_oErro.Procedure, "Erro em BtnExcluirClick")
886:         ENDTRY
887:     ENDPROC
888: 
889:     *--------------------------------------------------------------------------
890:     * CarregarLista - Regenera grafico OLE para o item atualmente selecionado
891:     * no ComboBox. Em form OPERACIONAL de visualizacao de grafico, nao ha lista
892:     * de registros para carregar ??? "CarregarLista" equivale a "regenerar grafico".
893:     *--------------------------------------------------------------------------
894:     PROCEDURE CarregarLista()
895:         LOCAL loc_lSucesso, loc_nIdx
896:         loc_lSucesso = .F.
897: 
898:         TRY
899:             IF VARTYPE(THIS.cnt_4c_Grf2) = "O" AND ;
900:                PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
901:                 loc_nIdx = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex
902:                 IF loc_nIdx < 1
903:                     loc_nIdx = 1
904:                 ENDIF
905:                 loc_lSucesso = THIS.GerarGrafico(loc_nIdx)
906:             ENDIF
907:         CATCH TO loc_oErro
908:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
909:                     "Erro CarregarLista")
910:         ENDTRY
911: 
912:         RETURN loc_lSucesso
913:     ENDPROC
914: 
915:     *--------------------------------------------------------------------------
916:     * FormParaBO - Copia o estado atual do form (selecao do combo) para o BO
917:     *--------------------------------------------------------------------------
918:     PROTECTED PROCEDURE FormParaBO()
919:         LOCAL loc_nIdx, loc_cChave
920: 
921:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
922:             RETURN
923:         ENDIF
924: 
925:         loc_cChave = ""
926: 
927:         IF VARTYPE(THIS.cnt_4c_Grf2) = "O" AND ;
928:            PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
929:             loc_nIdx = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex
930:             IF loc_nIdx > 0
931:                 loc_cChave = ALLTRIM(THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.List(loc_nIdx))
932:             ENDIF
933:         ENDIF
934: 
935:         THIS.this_oBusinessObject.this_cChave1 = loc_cChave
936:     ENDPROC
937: 
938:     *--------------------------------------------------------------------------
939:     * BOParaForm - Atualiza o form a partir do estado do BO
940:     * Sincroniza titulo do cabecalho com this_cCaption do BO
941:     *--------------------------------------------------------------------------
942:     PROTECTED PROCEDURE BOParaForm()
943:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
944:             RETURN
945:         ENDIF
946: 
947:         IF !EMPTY(THIS.this_oBusinessObject.this_cCaption)
948:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.this_oBusinessObject.this_cCaption
949:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.this_oBusinessObject.this_cCaption
950:         ENDIF
951:     ENDPROC
952: 
953:     *--------------------------------------------------------------------------
954:     * HabilitarCampos - Habilita ou desabilita controles do form
955:     * par_lHabilitar: .T. = habilitar, .F. = desabilitar
956:     *--------------------------------------------------------------------------
957:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
958:         LOCAL loc_lHabilitar
959:         loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
960: 
961:         IF VARTYPE(THIS.cnt_4c_Grf2) = "O" AND ;
962:            PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
963:             THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Enabled  = loc_lHabilitar
964:             THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ReadOnly = !loc_lHabilitar
965:         ENDIF
966: 
967:         IF VARTYPE(THIS.obj_4c_CmdgGrafico) = "O"
968:             THIS.obj_4c_CmdgGrafico.Enabled = loc_lHabilitar
969:         ENDIF
970:     ENDPROC
971: 
972:     *--------------------------------------------------------------------------
973:     * LimparCampos - Reseta combo, limpa cache do grafico e volta ao estado
974:     * de espera (cnt_4c_Aguarde). Equivalente a "limpar consulta".
975:     *--------------------------------------------------------------------------
976:     PROTECTED PROCEDURE LimparCampos()
977:         LOCAL loc_oErro
978: 
979:         TRY
980:             *-- Desvincula o OLE antes de zerar cursor (evita acesso a dados liberados)
981:             IF VARTYPE(THIS.cnt_4c_Grf1) = "O" AND ;
982:                PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)
983:                 TRY
984:                     THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
985:                 CATCH
986:                 ENDTRY
987:             ENDIF
988: 
989:             *-- Limpa e recria cursor de cache via BO
990:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
991:                 THIS.this_oBusinessObject.LimparCursorGrafico()
992:                 THIS.this_oBusinessObject.InicializarCursorGrafico()
993:             ENDIF
994: 
995:             *-- Resetar combo
996:             IF VARTYPE(THIS.cnt_4c_Grf2) = "O" AND ;
997:                PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
998:                 THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Clear()
999:             ENDIF
1000: 
1001:             *-- Exibir estado de espera
1002:             THIS.AlternarPagina("AGUARDE")
1003: 
1004:         CATCH TO loc_oErro
1005:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1006:                     "Erro LimparCampos")
1007:         ENDTRY
1008:     ENDPROC
1009: 
1010:     *--------------------------------------------------------------------------
1011:     * AjustarBotoesPorModo - Ajusta visibilidade do CommandGroup conforme estado
1012:     * Form OPERACIONAL sem modo CRUD: apenas garante que o CmdGroup esta visivel
1013:     * quando o grafico foi gerado.
1014:     *--------------------------------------------------------------------------
1015:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1016:         LOCAL loc_lTemGrafico
1017:         loc_lTemGrafico = USED("crGrafico1") AND RECCOUNT("crGrafico1") > 0
1018: 
1019:         IF VARTYPE(THIS.obj_4c_CmdgGrafico) = "O"
1020:             THIS.obj_4c_CmdgGrafico.Visible = loc_lTemGrafico
1021:         ENDIF
1022:     ENDPROC
1023: 
1024:     *--------------------------------------------------------------------------
1025:     * BtnBuscarClick - Dispara geracao/atualizacao do grafico para a selecao
1026:     * atual do ComboBox. Em form OPERACIONAL de grafico, "Buscar" equivale a
1027:     * "visualizar grafico para chave selecionada".
1028:     *--------------------------------------------------------------------------
1029:     PROCEDURE BtnBuscarClick()
1030:         THIS.CboChave1Click()
1031:     ENDPROC
1032: 
1033:     *--------------------------------------------------------------------------
1034:     * BtnSalvarClick - Form OPERACIONAL sem persistencia em banco de dados.
1035:     * Dados sao gerados dinamicamente a partir do cursor crRel1 do form pai
1036:     * e mantidos em memoria (crGrafico1). Nao ha operacao de salvamento.
1037:     *--------------------------------------------------------------------------
1038:     PROCEDURE BtnSalvarClick()
1039:         LOCAL loc_oErro, loc_nIdx
1040:         loc_nIdx = 1
1041: 
1042:         TRY
1043:             IF VARTYPE(THIS.cnt_4c_Grf2) = "O" AND ;
1044:                PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
1045:                 loc_nIdx = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex
1046:                 IF loc_nIdx < 1
1047:                     loc_nIdx = 1
1048:                 ENDIF
1049:             ENDIF
1050: 
1051:             THIS.GerarGrafico(loc_nIdx)
1052: 
1053:         CATCH TO loc_oErro
1054:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1055:                     " PROC=" + loc_oErro.Procedure, "Erro em BtnSalvarClick")
1056:         ENDTRY
1057:     ENDPROC
1058: 
1059:     *--------------------------------------------------------------------------
1060:     * BtnCancelarClick - Encerra o form (equivalente a Encerrar para este
1061:     * form OPERACIONAL que nao tem estado editavel a cancelar).
1062:     *--------------------------------------------------------------------------
1063:     PROCEDURE BtnCancelarClick()
1064:         THIS.BtnEncerrarClick()
1065:     ENDPROC
1066: 
1067:     *--------------------------------------------------------------------------
1068:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1069:     * Percorre Controls e sub-containers. Estado de exibicao dos containers
1070:     * principais (cnt_4c_Grf1/Grf2/CmdgGrafico) e gerenciado por AlternarPagina,
1071:     * portanto este metodo e chamado antes da primeira chamada a AlternarPagina.
1072:     *--------------------------------------------------------------------------
1073:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1074:         LOCAL loc_i, loc_oControl
1075: 
1076:         FOR loc_i = 1 TO par_oContainer.ControlCount
1077:             loc_oControl = par_oContainer.Controls(loc_i)
1078: 
1079:             IF VARTYPE(loc_oControl) = "O"
1080:                 IF INLIST(UPPER(loc_oControl.Name), "CNT_4C_CABECALHO")
1081:                     THIS.TornarControlesVisiveis(loc_oControl)
1082:                     LOOP
1083:                 ENDIF
1084: 
1085:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
1086:                     loc_oControl.Visible = .T.
1087:                 ENDIF
1088: 
1089:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
1090:                    loc_oControl.ControlCount > 0
1091:                     THIS.TornarControlesVisiveis(loc_oControl)
1092:                 ENDIF
1093:             ENDIF
1094:         ENDFOR
1095:     ENDPROC
1096: 
1097: ENDDEFINE


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

