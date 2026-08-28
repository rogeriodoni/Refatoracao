# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 291: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormPgb.prg) - TRECHOS RELEVANTES PARA PASS GRID (659 linhas total):

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

*-- Linhas 259 a 451:
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
291:                 .RecordSource        = "cursor_4c_HistoricoPgb"
292:             ENDWITH
293: 
294:             *-- Column1: Data
295:             WITH loc_oGrd.Column1
296:                 .FontName      = "Tahoma"
297:                 .FontSize      = 8
298:                 .Alignment     = 3
299:                 .Width         = 66
300:                 .Movable       = .F.
301:                 .Resizable     = .T.
302:                 .ReadOnly      = .T.
303:                 .ForeColor     = RGB(0, 0, 0)
304:                 .BackColor     = RGB(255, 255, 255)
305:                 .ControlSource = "cursor_4c_HistoricoPgb.Datas"
306:             ENDWITH
307:             loc_oGrd.Column1.Header1.Caption   = "Data"
308:             loc_oGrd.Column1.Header1.Alignment = 2
309: 
310:             *-- Column2: Barra (Etiqs)
311:             WITH loc_oGrd.Column2
312:                 .FontName      = "Tahoma"
313:                 .FontSize      = 8
314:                 .Alignment     = 3
315:                 .Width         = 66
316:                 .ReadOnly      = .T.
317:                 .ForeColor     = RGB(0, 0, 0)
318:                 .BackColor     = RGB(255, 255, 255)
319:                 .ControlSource = "cursor_4c_HistoricoPgb.Etiqs"
320:             ENDWITH
321:             loc_oGrd.Column2.Header1.Caption   = "Barra"
322:             loc_oGrd.Column2.Header1.Alignment = 2
323: 
324:             *-- Column3: C.Custo (Ccustos)
325:             WITH loc_oGrd.Column3
326:                 .FontName      = "Tahoma"
327:                 .FontSize      = 8
328:                 .Alignment     = 3
329:                 .Width         = 73
330:                 .ReadOnly      = .T.
331:                 .ForeColor     = RGB(0, 0, 0)
332:                 .BackColor     = RGB(255, 255, 255)
333:                 .ControlSource = "cursor_4c_HistoricoPgb.Ccustos"
334:             ENDWITH
335:             loc_oGrd.Column3.Header1.Caption   = "C.Custo"
336:             loc_oGrd.Column3.Header1.Alignment = 2
337: 
338:             *-- Column4: C.Custo2 (Ccusto2s)
339:             WITH loc_oGrd.Column4
340:                 .FontName      = "Tahoma"
341:                 .FontSize      = 8
342:                 .Alignment     = 3
343:                 .Width         = 73
344:                 .ReadOnly      = .T.
345:                 .ForeColor     = RGB(0, 0, 0)
346:                 .BackColor     = RGB(255, 255, 255)
347:                 .ControlSource = "cursor_4c_HistoricoPgb.Ccusto2s"
348:             ENDWITH
349:             loc_oGrd.Column4.Header1.Caption   = "C.Custo2"
350:             loc_oGrd.Column4.Header1.Alignment = 2
351: 
352:             *-- Column5: Ocorrencia (Tpoperas) - CHR(234) = e-circunflexo
353:             WITH loc_oGrd.Column5
354:                 .FontName      = "Tahoma"
355:                 .FontSize      = 8
356:                 .Alignment     = 3
357:                 .Width         = 80
358:                 .ReadOnly      = .T.
359:                 .ForeColor     = RGB(0, 0, 0)
360:                 .BackColor     = RGB(255, 255, 255)
361:                 .ControlSource = "cursor_4c_HistoricoPgb.Tpoperas"
362:             ENDWITH
363:             loc_oGrd.Column5.Header1.Caption   = "Ocorr" + CHR(234) + "ncia"
364:             loc_oGrd.Column5.Header1.Alignment = 2
365: 
366:             *-- Column6: Oper (Tplancs - plano de contas/lancamento)
367:             WITH loc_oGrd.Column6
368:                 .FontName      = "Tahoma"
369:                 .FontSize      = 8
370:                 .Alignment     = 3
371:                 .Width         = 30
372:                 .ReadOnly      = .T.
373:                 .ForeColor     = RGB(0, 0, 0)
374:                 .BackColor     = RGB(255, 255, 255)
375:                 .ControlSource = "cursor_4c_HistoricoPgb.Tplancs"
376:             ENDWITH
377:             loc_oGrd.Column6.Header1.Caption   = "Oper"
378:             loc_oGrd.Column6.Header1.Alignment = 2
379: 
380:             *-- Column7: Dt.Base (Dtbases)
381:             WITH loc_oGrd.Column7
382:                 .FontName      = "Tahoma"
383:                 .FontSize      = 8
384:                 .Width         = 66
385:                 .ReadOnly      = .T.
386:                 .ForeColor     = RGB(0, 0, 0)
387:                 .BackColor     = RGB(255, 255, 255)
388:                 .ControlSource = "cursor_4c_HistoricoPgb.Dtbases"
389:             ENDWITH
390:             loc_oGrd.Column7.Header1.Caption   = "Dt.Base"
391:             loc_oGrd.Column7.Header1.Alignment = 2
392: 
393:             BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
394: 
395:         CATCH TO loc_oErro
396:             MsgErro(loc_oErro.Message + CHR(13) + ;
397:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
398:                 "Procedure: " + loc_oErro.Procedure, "FormPgb.ConfigurarPaginaLista")
399:         ENDTRY
400:     ENDPROC
401: 
402:     *--------------------------------------------------------------------------
403:     * CarregarDados - Executa SP SigPrCtb via BO e posiciona no ultimo registro
404:     *   O cursor cursor_4c_HistoricoPgb e populado pelo BO; o grid e rebindado
405:     *   aqui porque o BO fecha e recria o cursor (USE IN + CREATE CURSOR).
406:     *--------------------------------------------------------------------------
407:     PROTECTED PROCEDURE CarregarDados()
408:         LOCAL loc_lOk, loc_oErro
409:         loc_lOk = .F.
410: 
411:         TRY
412:             loc_lOk = THIS.this_oBusinessObject.CarregarHistorico( ;
413:                 THIS.this_cEmps,  ;
414:                 THIS.this_cDopes, ;
415:                 THIS.this_nNumes)
416: 
417:             IF loc_lOk AND USED("cursor_4c_HistoricoPgb")
418:                 *-- Rebind grid: BO fecha e recria cursor em CarregarHistorico
419:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
420:                     THIS.grd_4c_Dados.ColumnCount             = 7
421:                     THIS.grd_4c_Dados.RecordSource            = "cursor_4c_HistoricoPgb"
422:                     THIS.grd_4c_Dados.Column1.ControlSource   = "cursor_4c_HistoricoPgb.Datas"
423:                     THIS.grd_4c_Dados.Column2.ControlSource   = "cursor_4c_HistoricoPgb.Etiqs"
424:                     THIS.grd_4c_Dados.Column3.ControlSource   = "cursor_4c_HistoricoPgb.Ccustos"
425:                     THIS.grd_4c_Dados.Column4.ControlSource   = "cursor_4c_HistoricoPgb.Ccusto2s"
426:                     THIS.grd_4c_Dados.Column5.ControlSource   = "cursor_4c_HistoricoPgb.Tpoperas"
427:                     THIS.grd_4c_Dados.Column6.ControlSource   = "cursor_4c_HistoricoPgb.Tplancs"
428:                     THIS.grd_4c_Dados.Column7.ControlSource   = "cursor_4c_HistoricoPgb.Dtbases"
429:                     THIS.grd_4c_Dados.Column1.Header1.Caption = "Data"
430:                     THIS.grd_4c_Dados.Column2.Header1.Caption = "Barra"
431:                     THIS.grd_4c_Dados.Column3.Header1.Caption = "C.Custo"
432:                     THIS.grd_4c_Dados.Column4.Header1.Caption = "C.Custo2"
433:                     THIS.grd_4c_Dados.Column5.Header1.Caption = "Ocorr" + CHR(234) + "ncia"
434:                     THIS.grd_4c_Dados.Column6.Header1.Caption = "Oper"
435:                     THIS.grd_4c_Dados.Column7.Header1.Caption = "Dt.Base"
436:                     THIS.grd_4c_Dados.Refresh()
437:                 ENDIF
438:                 IF PEMSTATUS(THIS, "txt_4c_Texto", 5)
439:                     THIS.txt_4c_Texto.Refresh()
440:                 ENDIF
441:             ENDIF
442:         CATCH TO loc_oErro
443:             MsgErro(loc_oErro.Message + CHR(13) + ;
444:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
445:                 "Procedure: " + loc_oErro.Procedure, "FormPgb.CarregarDados")
446:         ENDTRY
447: 
448:         RETURN loc_lOk
449:     ENDPROC
450: 
451:     *--------------------------------------------------------------------------

*-- Linhas 602 a 621:
602:     *   via ControlSource; apenas forca refresh dos controles visuais.
603:     *--------------------------------------------------------------------------
604:     PROTECTED PROCEDURE BOParaForm()
605:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
606:             THIS.grd_4c_Dados.Refresh()
607:         ENDIF
608:         IF PEMSTATUS(THIS, "txt_4c_Texto", 5)
609:             THIS.txt_4c_Texto.Refresh()
610:         ENDIF
611:     ENDPROC
612: 
613:     *--------------------------------------------------------------------------
614:     * HabilitarCampos - No-op deliberado (form OPERACIONAL somente leitura)
615:     *   Todos os controles sao ReadOnly por definicao; nao ha modo de edicao.
616:     *--------------------------------------------------------------------------
617:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
618:         RETURN
619:     ENDPROC
620: 
621:     *--------------------------------------------------------------------------

