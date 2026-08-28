# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 394: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES GRID/CURSOR
- [MADDCOLUNA] mAddColuna com parametro numerico. Assinatura: (campo, mascara, titulo) - TODOS strings
- [GRID-HEADERS] Apos RecordSource, Header1.Caption resetado para nome do campo. REDEFINIR todos os captions
- [SQLEXEC-GRID] SQLEXEC direto no cursor do Grid destroi colunas. Usar cursor temp + ZAP + APPEND
- [CREATE-CURSOR-NULL] SET NULL ON antes de CREATE CURSOR (APPEND de dados com NULL falha)
- [RECORDSOURCE-WITH] RecordSource/ColumnCount FORA do WITH block (dentro causa "Unknown member COLUMN1")
- [CURSOR-DUPLICADO] CREATE CURSOR duplicado com ordem diferente de campos
- [GRID-RECORDSOURCE-AUTOBIND] Apos .RecordSource =, REDEFINIR .ControlSource de TODAS as colunas

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormPgb.prg) - TRECHOS RELEVANTES PARA PASS GRID (662 linhas total):

*-- Linhas 8 a 26:
8: *   Fase 1/2: PgbBO.prg (propriedades + CarregarHistorico via SP SigPrCtb)
9: *   Fase 3:   FormPgb.prg - estrutura base (Init, InicializarForm, ConfigurarLayout)
10: *             Cabecalho, Encerrar, Shape1, txt_4c_Texto, Shape2
11: *   Fase 4:   Grid grd_4c_Dados (7 colunas) + AfterRowColChange + CarregarDados bind
12: *   Fase 5/6: Form OPERACIONAL read-only sem Page2 nem campos de entrada.
13: *             Completado com propriedades visuais do grid (HighlightColors, ForeColor/
14: *             BackColor por coluna) equivalentes ao fCarregaGrade do legado.
15: *==============================================================================
16: DEFINE CLASS FormPgb AS FormBase
17: 
18:     *-- Parametros de entrada recebidos no Init
19:     this_cEmps  = ""
20:     this_cDopes = ""
21:     this_nNumes = 0
22: 
23:     *-- Business Object
24:     this_oBusinessObject = .NULL.
25: 
26:     *-- Propriedades visuais (PILAR 1 - valores exatos do SCX SIGCDPGB)

*-- Linhas 86 a 119:
86: 
87:             *-- Cursor placeholder identico ao populado por CarregarHistorico
88:             *-- Precisa existir antes de ConfigurarLayout (ControlSource do txt_4c_Texto)
89:             SET NULL ON
90:             IF USED("cursor_4c_HistoricoPgb")
91:                 USE IN cursor_4c_HistoricoPgb
92:             ENDIF
93:             CREATE CURSOR cursor_4c_HistoricoPgb ;
94:                 (Datas    D     NULL, ;
95:                  Etiqs    C(30) NULL, ;
96:                  Ccustos  C(20) NULL, ;
97:                  Ccusto2s C(20) NULL, ;
98:                  Tpoperas C(40) NULL, ;
99:                  Tplancs  C(10) NULL, ;
100:                  Dtbases  D     NULL, ;
101:                  Dpros    C(60) NULL)
102:             SET NULL OFF
103: 
104:             *-- Monta controles visuais (sem grid - Fase 4 adiciona grd_4c_Dados)
105:             *-- Nome ConfigurarPageFrame mantido por convencao do orquestrador,
106:             *-- mas este form OPERACIONAL nao usa PageFrame (layout customizado).
107:             THIS.ConfigurarPageFrame()
108: 
109:             *-- Propaga titulo para labels do cabecalho
110:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
111:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
112: 
113:             *-- Carrega dados via SP SigPrCtb (sem conexao em modo teste)
114:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
115:                 THIS.CarregarDados()
116:             ENDIF
117: 
118:             *-- Torna arvore de controles visivel (AddObject cria com Visible=.F.)
119:             THIS.TornarControlesVisiveis(THIS)

*-- Linhas 259 a 292:
259:     ENDPROC
260: 
261:     *--------------------------------------------------------------------------
262:     * ConfigurarPaginaLista - Cria grd_4c_Dados com 7 colunas do historico
263:     *   Layout exato do SCX original (Top=107, Left=80, Width=490, Height=292)
264:     *   RecordSource/ControlSources sao rebindados em CarregarDados pois o BO
265:     *   fecha e recria o cursor em CarregarHistorico (USE IN + CREATE CURSOR).
266:     *--------------------------------------------------------------------------
267:     PROTECTED PROCEDURE ConfigurarPaginaLista()
268:         LOCAL loc_oGrd, loc_oErro
269:         TRY
270:             THIS.AddObject("grd_4c_Dados", "Grid")
271:             loc_oGrd = THIS.grd_4c_Dados
272:             WITH loc_oGrd
273:                 .Top                 = 107
274:                 .Left                = 80
275:                 .Height              = 292
276:                 .Width               = 490
277:                 .ColumnCount         = 7
278:                 .FontName            = "Tahoma"
279:                 .FontSize            = 8
280:                 .AllowHeaderSizing   = .F.
281:                 .AllowRowSizing      = .F.
282:                 .DeleteMark          = .F.
283:                 .RecordMark          = .F.
284:                 .ReadOnly            = .T.
285:                 .RowHeight           = 17
286:                 .ScrollBars          = 2
287:                 .GridLineColor       = RGB(238, 238, 238)
288:                 .HighlightBackColor  = RGB(255, 255, 255)
289:                 .HighlightForeColor  = RGB(15, 41, 104)
290:                 .HighlightStyle      = 2
291:             ENDWITH
292: 

*-- Linhas 303 a 454:
303:                 .BackColor     = RGB(255, 255, 255)
304:                 .ControlSource = "cursor_4c_HistoricoPgb.Datas"
305:             ENDWITH
306:             loc_oGrd.Column1.Header1.Caption   = "Data"
307:             loc_oGrd.Column1.Header1.Alignment = 2
308: 
309:             *-- Column2: Barra (Etiqs)
310:             WITH loc_oGrd.Column2
311:                 .FontName      = "Tahoma"
312:                 .FontSize      = 8
313:                 .Alignment     = 3
314:                 .Width         = 66
315:                 .ReadOnly      = .T.
316:                 .ForeColor     = RGB(0, 0, 0)
317:                 .BackColor     = RGB(255, 255, 255)
318:                 .ControlSource = "cursor_4c_HistoricoPgb.Etiqs"
319:             ENDWITH
320:             loc_oGrd.Column2.Header1.Caption   = "Barra"
321:             loc_oGrd.Column2.Header1.Alignment = 2
322: 
323:             *-- Column3: C.Custo (Ccustos)
324:             WITH loc_oGrd.Column3
325:                 .FontName      = "Tahoma"
326:                 .FontSize      = 8
327:                 .Alignment     = 3
328:                 .Width         = 73
329:                 .ReadOnly      = .T.
330:                 .ForeColor     = RGB(0, 0, 0)
331:                 .BackColor     = RGB(255, 255, 255)
332:                 .ControlSource = "cursor_4c_HistoricoPgb.Ccustos"
333:             ENDWITH
334:             loc_oGrd.Column3.Header1.Caption   = "C.Custo"
335:             loc_oGrd.Column3.Header1.Alignment = 2
336: 
337:             *-- Column4: C.Custo2 (Ccusto2s)
338:             WITH loc_oGrd.Column4
339:                 .FontName      = "Tahoma"
340:                 .FontSize      = 8
341:                 .Alignment     = 3
342:                 .Width         = 73
343:                 .ReadOnly      = .T.
344:                 .ForeColor     = RGB(0, 0, 0)
345:                 .BackColor     = RGB(255, 255, 255)
346:                 .ControlSource = "cursor_4c_HistoricoPgb.Ccusto2s"
347:             ENDWITH
348:             loc_oGrd.Column4.Header1.Caption   = "C.Custo2"
349:             loc_oGrd.Column4.Header1.Alignment = 2
350: 
351:             *-- Column5: Ocorrencia (Tpoperas) - CHR(234) = e-circunflexo
352:             WITH loc_oGrd.Column5
353:                 .FontName      = "Tahoma"
354:                 .FontSize      = 8
355:                 .Alignment     = 3
356:                 .Width         = 80
357:                 .ReadOnly      = .T.
358:                 .ForeColor     = RGB(0, 0, 0)
359:                 .BackColor     = RGB(255, 255, 255)
360:                 .ControlSource = "cursor_4c_HistoricoPgb.Tpoperas"
361:             ENDWITH
362:             loc_oGrd.Column5.Header1.Caption   = "Ocorr" + CHR(234) + "ncia"
363:             loc_oGrd.Column5.Header1.Alignment = 2
364: 
365:             *-- Column6: Oper (Tplancs - plano de contas/lancamento)
366:             WITH loc_oGrd.Column6
367:                 .FontName      = "Tahoma"
368:                 .FontSize      = 8
369:                 .Alignment     = 3
370:                 .Width         = 30
371:                 .ReadOnly      = .T.
372:                 .ForeColor     = RGB(0, 0, 0)
373:                 .BackColor     = RGB(255, 255, 255)
374:                 .ControlSource = "cursor_4c_HistoricoPgb.Tplancs"
375:             ENDWITH
376:             loc_oGrd.Column6.Header1.Caption   = "Oper"
377:             loc_oGrd.Column6.Header1.Alignment = 2
378: 
379:             *-- Column7: Dt.Base (Dtbases)
380:             WITH loc_oGrd.Column7
381:                 .FontName      = "Tahoma"
382:                 .FontSize      = 8
383:                 .Width         = 66
384:                 .ReadOnly      = .T.
385:                 .ForeColor     = RGB(0, 0, 0)
386:                 .BackColor     = RGB(255, 255, 255)
387:                 .ControlSource = "cursor_4c_HistoricoPgb.Dtbases"
388:             ENDWITH
389:             loc_oGrd.Column7.Header1.Caption   = "Dt.Base"
390:             loc_oGrd.Column7.Header1.Alignment = 2
391: 
392:             *-- RecordSource definido apos todos os ControlSources para evitar auto-bind do VFP
393:             loc_oGrd.ColumnCount = 3
394:             loc_oGrd.RecordSource = "cursor_4c_HistoricoPgb"
395: 
396:             BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
397: 
398:         CATCH TO loc_oErro
399:             MsgErro(loc_oErro.Message + CHR(13) + ;
400:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
401:                 "Procedure: " + loc_oErro.Procedure, "FormPgb.ConfigurarPaginaLista")
402:         ENDTRY
403:     ENDPROC
404: 
405:     *--------------------------------------------------------------------------
406:     * CarregarDados - Executa SP SigPrCtb via BO e posiciona no ultimo registro
407:     *   O cursor cursor_4c_HistoricoPgb e populado pelo BO; o grid e rebindado
408:     *   aqui porque o BO fecha e recria o cursor (USE IN + CREATE CURSOR).
409:     *--------------------------------------------------------------------------
410:     PROTECTED PROCEDURE CarregarDados()
411:         LOCAL loc_lOk, loc_oErro
412:         loc_lOk = .F.
413: 
414:         TRY
415:             loc_lOk = THIS.this_oBusinessObject.CarregarHistorico( ;
416:                 THIS.this_cEmps,  ;
417:                 THIS.this_cDopes, ;
418:                 THIS.this_nNumes)
419: 
420:             IF loc_lOk AND USED("cursor_4c_HistoricoPgb")
421:                 *-- Rebind grid: BO fecha e recria cursor em CarregarHistorico
422:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
423:                     THIS.grd_4c_Dados.ColumnCount             = 7
424:                     THIS.grd_4c_Dados.RecordSource            = "cursor_4c_HistoricoPgb"
425:                     THIS.grd_4c_Dados.Column1.ControlSource   = "cursor_4c_HistoricoPgb.Datas"
426:                     THIS.grd_4c_Dados.Column2.ControlSource   = "cursor_4c_HistoricoPgb.Etiqs"
427:                     THIS.grd_4c_Dados.Column3.ControlSource   = "cursor_4c_HistoricoPgb.Ccustos"
428:                     THIS.grd_4c_Dados.Column4.ControlSource   = "cursor_4c_HistoricoPgb.Ccusto2s"
429:                     THIS.grd_4c_Dados.Column5.ControlSource   = "cursor_4c_HistoricoPgb.Tpoperas"
430:                     THIS.grd_4c_Dados.Column6.ControlSource   = "cursor_4c_HistoricoPgb.Tplancs"
431:                     THIS.grd_4c_Dados.Column7.ControlSource   = "cursor_4c_HistoricoPgb.Dtbases"
432:                     THIS.grd_4c_Dados.Column1.Header1.Caption = "Data"
433:                     THIS.grd_4c_Dados.Column2.Header1.Caption = "Barra"
434:                     THIS.grd_4c_Dados.Column3.Header1.Caption = "C.Custo"
435:                     THIS.grd_4c_Dados.Column4.Header1.Caption = "C.Custo2"
436:                     THIS.grd_4c_Dados.Column5.Header1.Caption = "Ocorr" + CHR(234) + "ncia"
437:                     THIS.grd_4c_Dados.Column6.Header1.Caption = "Oper"
438:                     THIS.grd_4c_Dados.Column7.Header1.Caption = "Dt.Base"
439:                     THIS.grd_4c_Dados.Refresh()
440:                 ENDIF
441:                 IF PEMSTATUS(THIS, "txt_4c_Texto", 5)
442:                     THIS.txt_4c_Texto.Refresh()
443:                 ENDIF
444:             ENDIF
445:         CATCH TO loc_oErro
446:             MsgErro(loc_oErro.Message + CHR(13) + ;
447:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
448:                 "Procedure: " + loc_oErro.Procedure, "FormPgb.CarregarDados")
449:         ENDTRY
450: 
451:         RETURN loc_lOk
452:     ENDPROC
453: 
454:     *--------------------------------------------------------------------------

*-- Linhas 605 a 624:
605:     *   via ControlSource; apenas forca refresh dos controles visuais.
606:     *--------------------------------------------------------------------------
607:     PROTECTED PROCEDURE BOParaForm()
608:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
609:             THIS.grd_4c_Dados.Refresh()
610:         ENDIF
611:         IF PEMSTATUS(THIS, "txt_4c_Texto", 5)
612:             THIS.txt_4c_Texto.Refresh()
613:         ENDIF
614:     ENDPROC
615: 
616:     *--------------------------------------------------------------------------
617:     * HabilitarCampos - No-op deliberado (form OPERACIONAL somente leitura)
618:     *   Todos os controles sao ReadOnly por definicao; nao ha modo de edicao.
619:     *--------------------------------------------------------------------------
620:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
621:         RETURN
622:     ENDPROC
623: 
624:     *--------------------------------------------------------------------------

