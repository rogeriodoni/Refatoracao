# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (7)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CPROS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NSITUAS, USUACESS, CIMPS, USUARIOS, GRUPOS, LNI, EMPDOPNUMS, FLAG, DOPES, NUMES, SGRUS, ETIQS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NOPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NSITUAS, USUACESS, CIMPS, USUARIOS, GRUPOS, LNI, EMPDOPNUMS, FLAG, DOPES, NUMES, SGRUS, ETIQS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NSITUAS, USUACESS, CIMPS, USUARIOS, GRUPOS, LNI, EMPDOPNUMS, FLAG, DOPES, NUMES, SGRUS, ETIQS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPDNPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NSITUAS, USUACESS, CIMPS, USUARIOS, GRUPOS, LNI, EMPDOPNUMS, FLAG, DOPES, NUMES, SGRUS, ETIQS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CURSOR_4C_IMPW' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NSITUAS, USUACESS, CIMPS, USUARIOS, GRUPOS, LNI, EMPDOPNUMS, FLAG, DOPES, NUMES, SGRUS, ETIQS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CGRUCODS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NSITUAS, USUACESS, CIMPS, USUARIOS, GRUPOS, LNI, EMPDOPNUMS, FLAG, DOPES, NUMES, SGRUS, ETIQS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'IMPETIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NSITUAS, USUACESS, CIMPS, USUARIOS, GRUPOS, LNI, EMPDOPNUMS, FLAG, DOPES, NUMES, SGRUS, ETIQS

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  ControlSource = ""
Select TmpNens
Select crTmpCdOpd
Select crSigCdNec
Select crSigCdTpe
Select crSigCdmp
lcSql = [Select b.* From SigSyImp a, SigCdmp b Where a.UsuAcess = ']+Usuar+[' and a.cimps = b.impres ]+;
	[Select c.* From SigCdAcG a, SigSyImp b, SigCdmp c Where a.Usuarios=']+Usuar+[' ]+;
If Thisform.poDataMgr.sqlexecute(lcSql,'CrTmpCimp') <= 0
Select CrTmpCimp
	Select Distinct Impres, nTpImpres From CrTmpCimp Into Cursor crSigCdmp Readwrite
	Select crSigCdmp
			Insert Into crImpre	(Impres) Values(Upper(laPrinters(lnI, 1)))
	Select crSigCdTpe
		Select crSigCdmp
	Select Padr(Alltrim(a.Impres),15)+' '+Alltrim(b.Impres) As IDupla, b.Impres, a.Impres As impresS From crSigCdmp a, crImpre b Where Alltrim(Upper(a.Impres)) Like '%'+Alltrim(Upper(b.Impres))+'%' ;
	Select * From crImp Order By 1 Into Cursor crImpreV
	Select crImpreV
Select xNensi
Select xPesa
Select Nenvs, Sum(Peso) As tPeso ;
	From xPesa ;
Select TmpEnv
	Insert Into xTotEnv (Nenvs, Saida) Values (TmpEnv.Nenvs, TmpEnv.tPeso)
Select xPesa
Select Nenvs, Sum(Peso) As Pesos ;
	From xPesa ;
Select xRateio
	Select xNensi
Select xNensi
		Select xTotMat
		If Not Seek(xNensi.CMats)
			Insert Into xTotMat (CMats, DPros, CUnis) Values (xNensi.CMats, LocalPro.DPros, LocalPro.CUnis)
			Select xTotEnv
			If Not Seek(xNensi.Nenvs)
				Insert Into xTotEnv (Nenvs) Values (xNensi.Nenvs)
Select xMFas
	Select LocalOpi
		If Not Seek(lcEdn, 'xTotPed')
			Insert Into xTotPed (Emps, Dopes, Numes, MascNum, NConta, Repres) ;
			Insert Into xTotPedOp (Emps, Dopes, Numes, MascNum, NConta, Nops) ;
Select xNensi
		Select xMatOp
		If Not Seek(Str(xNensi.Nops,10) + xNensi.CMats)
			Insert Into xMatOp (CMats, DPros, CUnis, Nops) Values (xNensi.CMats, LocalPro.DPros, LocalPro.CUnis, xNensi.Nops)
Select xTotMat
	Insert Into xTotMatOp (CMats, CUnis, Qtds, Pesos) Values (xTotMat.CMats, xTotMat.CUnis, xTotMat.Qtds, xTotMat.Pesos)
Select xMFas
	Select LocalOpi
		If Not Seek(lcEdn + Str(xMFas.Nops,10), 'xTotPedOp')
			Insert Into xTotPedOp (Emps, Dopes, Numes, MascNum, NConta, Nops) ;
Select xTotPedOp
Select xTotMatOp
Select xMatOp
Select xMatOp
Select xTotEnv
Select xTotPed
	Select LocalOpi
	lcQuery = [Select Emps, Dopps, Nops ] + ;
		[From SigOpPic ] + ;
	If (Thisform.poDataMgr.sqlexecute(lcQuery, 'LocalOpi') < 1)
	Select LocalOpi
Select xTotPed
Delete For Flag = 0
	Select xTotPed
	.Column1.ControlSource = 'xTotMat.CMats'
	.Column2.ControlSource = 'xTotMat.DPros'
	.Column3.ControlSource = 'xTotMat.Qtds'
	.Column4.ControlSource = 'xTotMat.CUnis'
	.Column5.ControlSource = 'xTotMat.Pesos'
	.Column1.ControlSource = 'xTotEnv.NEnvs'
	.Column2.ControlSource = 'xTotEnv.Entrada'
	.Column3.ControlSource = 'xTotEnv.Saida'
	.Column1.ControlSource = 'xTotPed.Dopes'
	.Column2.ControlSource = 'xTotPed.MascNum'
	.Column3.ControlSource = 'xTotPed.NConta'
	.Column4.ControlSource = 'xTotPed.Repres'
	.Column1.ControlSource = 'xMatOp.CMats'
	.Column2.ControlSource = 'xMatOp.DPros'
	.Column3.ControlSource = 'xMatOp.Qtds'
	.Column4.ControlSource = 'xMatOp.CUnis'
	.Column5.ControlSource = 'xMatOp.Pesos'
	.Column1.ControlSource = 'xTotPedOp.Dopes'
	.Column2.ControlSource = 'xTotPedOp.MascNum'
	.Column3.ControlSource = 'xTotPedOp.Nops'
	.Column4.ControlSource = 'xTotPedOp.NConta'
	.Column1.ControlSource = 'xTotMatOp.CMats'
	.Column2.ControlSource = 'xTotMatOp.Qtds'
	.Column3.ControlSource = 'xTotMatOp.CUnis'
	.Column4.ControlSource = 'xTotMatOp.Pesos'
Select xTotPed
Select crSigCdNec
Select xTotPedOp
Select xMatOp
	lcSql = [Select Cpros,Nops,Qtds,ObsEtiqs as Obs,Emps,Numes,Dopes,Empos,DopeOs,NumeOs,CodTams,Pesos,CodCors,Peso2s From SigOpEtq ]+;
			[Select Cpros,Nops,Qtds,ObsEtiqs as Obs,Emps,Numes,Dopes,Empos,DopeOs,NumeOs,CodTams,Pesos,CodCors,Peso2s From SigEtPos ]+;
	ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalEti')
	Select LocalEti
		Select LocalOpi
			Select Distinct CodTams From LocalOpi Into Cursor CsSelecao Order by CodTams
			Select CsSelecao
		Insert Into dbImpressao (CPros, DPros, Qtds, QtdeEtiq, Pedido, Obs, Nops, Notas, Aros, Pesos) ; 
	lcSql = [Select Cpros,Cbars,Qtds,ObsEtiqs as Obs,Emps,Numes,Dopes,Empos,DopeOs,NumeOs,Nops From SigOpEtq ]+;
	ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalEti')
	Select LocalEti
		Insert Into dbImpressao (CPros, DPros, Qtds, QtdeEtiq, Pedido, Obs) ; 
		lcSql = [Select Cpros,Cbars,Qtds,ObsEtiqs,Emps,Numes,Dopes From SigEtPos Where EmpDopNums = ']+TmpNens.Emps+TmpNens.Dopps+Str(TmpNens.Numps,6)+[']
		ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalEti')
		Select LocalEti
			Insert Into dbImpressao (CPros, Qtds) Values (LocalEti.CPros, _QtEtiq)
Select dbImpressao 

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdM10.prg) - TRECHOS RELEVANTES PARA PASS SQL (2172 linhas total):

*-- Linhas 235 a 545:
235:         WITH THIS.grd_4c_GradeEnvelopes
236:             .ColumnCount  = 3
237:             .RecordMark   = .F.
238:             .DeleteMark   = .F.
239:             .RecordSource = "xTotEnv"
240: 
241:             WITH .Column1
242:                 .Width         = 100
243:                 .Movable       = .F.
244:                 .Resizable     = .F.
245:                 .ReadOnly      = .T.
246:                 .ControlSource = "xTotEnv.Nenvs"
247:                 WITH .Header1
248:                     .FontName  = "Tahoma"
249:                     .FontSize  = 8
250:                     .Alignment = 2
251:                     .Caption   = "Industrializa" + CHR(231) + CHR(227) + "o"
252:                 ENDWITH
253:                 WITH .Text1
254:                     .BorderStyle = 0
255:                     .Margin      = 0
256:                     .ReadOnly    = .T.
257:                     .ForeColor   = RGB(0,0,0)
258:                     .BackColor   = RGB(255,255,255)
259:                 ENDWITH
260:             ENDWITH
261: 
262:             WITH .Column2
263:                 .Width         = 100
264:                 .Movable       = .F.
265:                 .Resizable     = .F.
266:                 .ReadOnly      = .T.
267:                 .ControlSource = "xTotEnv.Entrada"
268:                 WITH .Header1
269:                     .FontName  = "Tahoma"
270:                     .FontSize  = 8
271:                     .Alignment = 2
272:                     .Caption   = "Peso Entrada"
273:                 ENDWITH
274:                 WITH .Text1
275:                     .BorderStyle = 0
276:                     .Margin      = 0
277:                     .ReadOnly    = .T.
278:                     .ForeColor   = RGB(0,0,0)
279:                     .BackColor   = RGB(255,255,255)
280:                 ENDWITH
281:             ENDWITH
282: 
283:             WITH .Column3
284:                 .Width         = 100
285:                 .Movable       = .F.
286:                 .Resizable     = .F.
287:                 .ReadOnly      = .T.
288:                 .ControlSource = "xTotEnv.Saida"
289:                 WITH .Header1
290:                     .FontName  = "Tahoma"
291:                     .FontSize  = 8
292:                     .Alignment = 2
293:                     .Caption   = "Peso Sa" + CHR(237) + "da"
294:                 ENDWITH
295:                 WITH .Text1
296:                     .BorderStyle = 0
297:                     .Margin      = 0
298:                     .ReadOnly    = .T.
299:                     .ForeColor   = RGB(0,0,0)
300:                     .BackColor   = RGB(255,255,255)
301:                 ENDWITH
302:             ENDWITH
303:         ENDWITH
304: 
305:         IF USED("xTotEnv")
306:             SELECT xTotEnv
307:             GO TOP
308:         ENDIF
309:     ENDPROC
310: 
311:     *==========================================================================
312:     * ConfigurarGradePedidos - Configura grd_4c_GradePedidos (xTotPed)
313:     *==========================================================================
314:     PROTECTED PROCEDURE ConfigurarGradePedidos()
315:         THIS.lbl_4c_Label1.Caption = "Movimenta" + CHR(231) + CHR(245) + "es Finalizadas"
316:         WITH THIS.grd_4c_GradePedidos
317:             .ColumnCount  = 4
318:             .RecordMark   = .F.
319:             .DeleteMark   = .F.
320:             .RecordSource = "xTotPed"
321: 
322:             WITH .Column1
323:                 .Width         = 80
324:                 .Movable       = .F.
325:                 .Resizable     = .F.
326:                 .ReadOnly      = .T.
327:                 .ControlSource = "xTotPed.MascNum"
328:                 WITH .Header1
329:                     .FontName  = "Tahoma"
330:                     .FontSize  = 8
331:                     .Alignment = 2
332:                     .Caption   = "C" + CHR(243) + "digo"
333:                 ENDWITH
334:                 WITH .Text1
335:                     .BorderStyle = 0
336:                     .Margin      = 0
337:                     .ReadOnly    = .T.
338:                     .ForeColor   = RGB(0,0,0)
339:                     .BackColor   = RGB(255,255,255)
340:                 ENDWITH
341:             ENDWITH
342: 
343:             WITH .Column2
344:                 .Width         = 150
345:                 .Movable       = .F.
346:                 .Resizable     = .F.
347:                 .ReadOnly      = .T.
348:                 .ControlSource = "xTotPed.Dopes"
349:                 WITH .Header1
350:                     .FontName  = "Tahoma"
351:                     .FontSize  = 8
352:                     .Alignment = 2
353:                     .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
354:                 ENDWITH
355:                 WITH .Text1
356:                     .BorderStyle = 0
357:                     .Margin      = 0
358:                     .ReadOnly    = .T.
359:                     .ForeColor   = RGB(0,0,0)
360:                     .BackColor   = RGB(255,255,255)
361:                 ENDWITH
362:             ENDWITH
363: 
364:             WITH .Column3
365:                 .Width         = 356
366:                 .Movable       = .F.
367:                 .Resizable     = .F.
368:                 .ReadOnly      = .T.
369:                 .ControlSource = "xTotPed.NConta"
370:                 WITH .Header1
371:                     .FontName  = "Tahoma"
372:                     .FontSize  = 8
373:                     .Alignment = 2
374:                     .Caption   = "Conta"
375:                 ENDWITH
376:                 WITH .Text1
377:                     .BorderStyle = 0
378:                     .Margin      = 0
379:                     .ReadOnly    = .T.
380:                     .ForeColor   = RGB(0,0,0)
381:                     .BackColor   = RGB(255,255,255)
382:                 ENDWITH
383:             ENDWITH
384: 
385:             WITH .Column4
386:                 .Width         = 100
387:                 .Movable       = .F.
388:                 .Resizable     = .F.
389:                 .ReadOnly      = .T.
390:                 .ControlSource = "xTotPed.Repres"
391:                 WITH .Header1
392:                     .FontName  = "Tahoma"
393:                     .FontSize  = 8
394:                     .Alignment = 2
395:                     .Caption   = "Respons" + CHR(225) + "vel"
396:                 ENDWITH
397:                 WITH .Text1
398:                     .BorderStyle = 0
399:                     .Margin      = 0
400:                     .ReadOnly    = .T.
401:                     .ForeColor   = RGB(0,0,0)
402:                     .BackColor   = RGB(255,255,255)
403:                 ENDWITH
404:             ENDWITH
405:         ENDWITH
406: 
407:         IF USED("xTotPed")
408:             SELECT xTotPed
409:             GO TOP
410:         ENDIF
411:     ENDPROC
412: 
413:     *==========================================================================
414:     * ConfigurarGradeMateriais - Configura grd_4c_GradeMateriais (xTotMat)
415:     *==========================================================================
416:     PROTECTED PROCEDURE ConfigurarGradeMateriais()
417:         WITH THIS.grd_4c_GradeMateriais
418:             .ColumnCount  = 5
419:             .RecordMark   = .F.
420:             .DeleteMark   = .F.
421:             .RecordSource = "xTotMat"
422: 
423:             WITH .Column1
424:                 .Width         = 120
425:                 .Movable       = .F.
426:                 .Resizable     = .F.
427:                 .ReadOnly      = .T.
428:                 .ControlSource = "xTotMat.CMats"
429:                 WITH .Header1
430:                     .FontName  = "Tahoma"
431:                     .FontSize  = 8
432:                     .Alignment = 2
433:                     .Caption   = "Componente"
434:                 ENDWITH
435:                 WITH .Text1
436:                     .BorderStyle = 0
437:                     .Margin      = 0
438:                     .ReadOnly    = .T.
439:                     .ForeColor   = RGB(0,0,0)
440:                     .BackColor   = RGB(255,255,255)
441:                 ENDWITH
442:             ENDWITH
443: 
444:             WITH .Column2
445:                 .Width         = 335
446:                 .Movable       = .F.
447:                 .Resizable     = .F.
448:                 .ReadOnly      = .T.
449:                 .ControlSource = "xTotMat.DPros"
450:                 WITH .Header1
451:                     .FontName  = "Tahoma"
452:                     .FontSize  = 8
453:                     .Alignment = 2
454:                     .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
455:                 ENDWITH
456:                 WITH .Text1
457:                     .BorderStyle = 0
458:                     .Margin      = 0
459:                     .ReadOnly    = .T.
460:                     .ForeColor   = RGB(0,0,0)
461:                     .BackColor   = RGB(255,255,255)
462:                 ENDWITH
463:             ENDWITH
464: 
465:             WITH .Column3
466:                 .Width         = 95
467:                 .Movable       = .F.
468:                 .Resizable     = .F.
469:                 .ReadOnly      = .T.
470:                 .ControlSource = "xTotMat.Qtds"
471:                 WITH .Header1
472:                     .FontName  = "Tahoma"
473:                     .FontSize  = 8
474:                     .Alignment = 2
475:                     .Caption   = "Quantidade"
476:                 ENDWITH
477:                 WITH .Text1
478:                     .BorderStyle = 0
479:                     .Margin      = 0
480:                     .ReadOnly    = .T.
481:                     .ForeColor   = RGB(0,0,0)
482:                     .BackColor   = RGB(255,255,255)
483:                 ENDWITH
484:             ENDWITH
485: 
486:             WITH .Column4
487:                 .Width         = 35
488:                 .Movable       = .F.
489:                 .Resizable     = .F.
490:                 .ReadOnly      = .T.
491:                 .ControlSource = "xTotMat.CUnis"
492:                 WITH .Header1
493:                     .FontName  = "Tahoma"
494:                     .FontSize  = 8
495:                     .Alignment = 2
496:                     .Caption   = "Uni"
497:                 ENDWITH
498:                 WITH .Text1
499:                     .BorderStyle = 0
500:                     .Margin      = 0
501:                     .ReadOnly    = .T.
502:                     .ForeColor   = RGB(0,0,0)
503:                     .BackColor   = RGB(255,255,255)
504:                 ENDWITH
505:             ENDWITH
506: 
507:             WITH .Column5
508:                 .Width         = 100
509:                 .Movable       = .F.
510:                 .Resizable     = .F.
511:                 .ReadOnly      = .T.
512:                 .ControlSource = "xTotMat.Pesos"
513:                 WITH .Header1
514:                     .FontName  = "Tahoma"
515:                     .FontSize  = 8
516:                     .Alignment = 2
517:                     .Caption   = "Peso Atual"
518:                 ENDWITH
519:                 WITH .Text1
520:                     .BorderStyle = 0
521:                     .Margin      = 0
522:                     .ReadOnly    = .T.
523:                     .ForeColor   = RGB(0,0,0)
524:                     .BackColor   = RGB(255,255,255)
525:                 ENDWITH
526:             ENDWITH
527:         ENDWITH
528: 
529:         IF USED("xTotMat")
530:             SELECT xTotMat
531:             GO TOP
532:         ENDIF
533:     ENDPROC
534: 
535:     *==========================================================================
536:     * ConfigurarCntOps - Adiciona e configura os 3 grids dentro do cnt_4c_Ops
537:     *==========================================================================
538:     PROTECTED PROCEDURE ConfigurarCntOps()
539:         WITH THIS.cnt_4c_Ops
540: 
541:             *-- Labels de secao
542:             .ADDOBJECT("lbl_4c_Label1", "Label")
543:             WITH .lbl_4c_Label1
544:                 .AutoSize  = .T.
545:                 .FontName  = "Tahoma"

*-- Linhas 589 a 678:
589:                 .Left         = 15
590:                 .ReadOnly     = .T.
591:                 .RecordMark   = .F.
592:                 .DeleteMark   = .F.
593:                 .RecordSource = "xTotPedOp"
594:                 .TabIndex     = 5
595:                 .Top          = 15
596:                 .Width        = 619
597:                 .GridLineColor = RGB(238,238,238)
598:                 WITH .Column1
599:                     .Width         = 130
600:                     .Movable       = .F.
601:                     .Resizable     = .F.
602:                     .ReadOnly      = .T.
603:                     .ControlSource = "xTotPedOp.Dopes"
604:                     WITH .Header1
605:                         .FontName  = "Tahoma"
606:                         .FontSize  = 8
607:                         .Alignment = 2
608:                         .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
609:                     ENDWITH
610:                     WITH .Text1
611:                         .BorderStyle = 0
612:                         .Margin      = 0
613:                         .ReadOnly    = .T.
614:                         .ForeColor   = RGB(0,0,0)
615:                         .BackColor   = RGB(255,255,255)
616:                     ENDWITH
617:                 ENDWITH
618:                 WITH .Column2
619:                     .Width         = 80
620:                     .Movable       = .F.
621:                     .Resizable     = .F.
622:                     .ReadOnly      = .T.
623:                     .ControlSource = "xTotPedOp.MascNum"
624:                     WITH .Header1
625:                         .FontName  = "Tahoma"
626:                         .FontSize  = 8
627:                         .Alignment = 2
628:                         .Caption   = "C" + CHR(243) + "digo"
629:                     ENDWITH
630:                     WITH .Text1
631:                         .BorderStyle = 0
632:                         .Margin      = 0
633:                         .ReadOnly    = .T.
634:                         .ForeColor   = RGB(0,0,0)
635:                         .BackColor   = RGB(255,255,255)
636:                     ENDWITH
637:                 ENDWITH
638:                 WITH .Column3
639:                     .Width         = 100
640:                     .Movable       = .F.
641:                     .Resizable     = .F.
642:                     .ReadOnly      = .T.
643:                     .ControlSource = "xTotPedOp.Nops"
644:                     WITH .Header1
645:                         .FontName  = "Tahoma"
646:                         .FontSize  = 8
647:                         .Alignment = 2
648:                         .Caption   = "Industrializa" + CHR(231) + CHR(227) + "o"
649:                     ENDWITH
650:                     WITH .Text1
651:                         .BorderStyle = 0
652:                         .Margin      = 0
653:                         .ReadOnly    = .T.
654:                         .ForeColor   = RGB(0,0,0)
655:                         .BackColor   = RGB(255,255,255)
656:                     ENDWITH
657:                 ENDWITH
658:                 WITH .Column4
659:                     .Width         = 275
660:                     .Movable       = .F.
661:                     .Resizable     = .F.
662:                     .ReadOnly      = .T.
663:                     .ControlSource = "xTotPedOp.NConta"
664:                     WITH .Header1
665:                         .FontName  = "Tahoma"
666:                         .FontSize  = 8
667:                         .Alignment = 2
668:                         .Caption   = "Conta"
669:                     ENDWITH
670:                     WITH .Text1
671:                         .BorderStyle = 0
672:                         .Margin      = 0
673:                         .ReadOnly    = .T.
674:                         .ForeColor   = RGB(0,0,0)
675:                         .BackColor   = RGB(255,255,255)
676:                     ENDWITH
677:                 ENDWITH
678:                 .Visible = .T.

*-- Linhas 686 a 795:
686:                 .Left         = 15
687:                 .ReadOnly     = .T.
688:                 .RecordMark   = .F.
689:                 .DeleteMark   = .F.
690:                 .RecordSource = "xMatOp"
691:                 .TabIndex     = 7
692:                 .Top          = 210
693:                 .Width        = 619
694:                 .GridLineColor = RGB(238,238,238)
695:                 WITH .Column1
696:                     .Width         = 100
697:                     .Movable       = .F.
698:                     .Resizable     = .F.
699:                     .ReadOnly      = .T.
700:                     .ControlSource = "xMatOp.CMats"
701:                     WITH .Header1
702:                         .FontName  = "Tahoma"
703:                         .FontSize  = 8
704:                         .Alignment = 2
705:                         .Caption   = "Componente"
706:                     ENDWITH
707:                     WITH .Text1
708:                         .BorderStyle = 0
709:                         .Margin      = 0
710:                         .ReadOnly    = .T.
711:                         .ForeColor   = RGB(0,0,0)
712:                         .BackColor   = RGB(255,255,255)
713:                     ENDWITH
714:                 ENDWITH
715:                 WITH .Column2
716:                     .Width         = 289
717:                     .Movable       = .F.
718:                     .Resizable     = .F.
719:                     .ReadOnly      = .T.
720:                     .ControlSource = "xMatOp.DPros"
721:                     WITH .Header1
722:                         .FontName  = "Tahoma"
723:                         .FontSize  = 8
724:                         .Alignment = 2
725:                         .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
726:                     ENDWITH
727:                     WITH .Text1
728:                         .BorderStyle = 0
729:                         .Margin      = 0
730:                         .ReadOnly    = .T.
731:                         .ForeColor   = RGB(0,0,0)
732:                         .BackColor   = RGB(255,255,255)
733:                     ENDWITH
734:                 ENDWITH
735:                 WITH .Column3
736:                     .Width         = 80
737:                     .Movable       = .F.
738:                     .Resizable     = .F.
739:                     .ReadOnly      = .T.
740:                     .ControlSource = "xMatOp.Qtds"
741:                     WITH .Header1
742:                         .FontName  = "Tahoma"
743:                         .FontSize  = 8
744:                         .Alignment = 2
745:                         .Caption   = "Quantidade"
746:                     ENDWITH
747:                     WITH .Text1
748:                         .BorderStyle = 0
749:                         .Margin      = 0
750:                         .ReadOnly    = .T.
751:                         .ForeColor   = RGB(0,0,0)
752:                         .BackColor   = RGB(255,255,255)
753:                     ENDWITH
754:                 ENDWITH
755:                 WITH .Column4
756:                     .Width         = 35
757:                     .Movable       = .F.
758:                     .Resizable     = .F.
759:                     .ReadOnly      = .T.
760:                     .ControlSource = "xMatOp.CUnis"
761:                     WITH .Header1
762:                         .FontName  = "Tahoma"
763:                         .FontSize  = 8
764:                         .Alignment = 2
765:                         .Caption   = "Uni"
766:                     ENDWITH
767:                     WITH .Text1
768:                         .BorderStyle = 0
769:                         .Margin      = 0
770:                         .ReadOnly    = .T.
771:                         .ForeColor   = RGB(0,0,0)
772:                         .BackColor   = RGB(255,255,255)
773:                     ENDWITH
774:                 ENDWITH
775:                 WITH .Column5
776:                     .Width         = 80
777:                     .Movable       = .F.
778:                     .Resizable     = .F.
779:                     .ReadOnly      = .T.
780:                     .ControlSource = "xMatOp.Pesos"
781:                     WITH .Header1
782:                         .FontName  = "Tahoma"
783:                         .FontSize  = 8
784:                         .Alignment = 2
785:                         .Caption   = "Peso Atual"
786:                     ENDWITH
787:                     WITH .Text1
788:                         .BorderStyle = 0
789:                         .Margin      = 0
790:                         .ReadOnly    = .T.
791:                         .ForeColor   = RGB(0,0,0)
792:                         .BackColor   = RGB(255,255,255)
793:                     ENDWITH
794:                 ENDWITH
795:                 .Visible = .T.

*-- Linhas 813 a 891:
813:                     .Movable       = .F.
814:                     .Resizable     = .F.
815:                     .ReadOnly      = .T.
816:                     .ControlSource = "xTotMatOp.CMats"
817:                     WITH .Header1
818:                         .FontName  = "Tahoma"
819:                         .FontSize  = 8
820:                         .Alignment = 2
821:                         .Caption   = "Componente"
822:                     ENDWITH
823:                     WITH .Text1
824:                         .BorderStyle = 0
825:                         .Margin      = 0
826:                         .ReadOnly    = .T.
827:                         .ForeColor   = RGB(0,0,0)
828:                         .BackColor   = RGB(255,255,255)
829:                     ENDWITH
830:                 ENDWITH
831:                 WITH .Column2
832:                     .Width         = 95
833:                     .Movable       = .F.
834:                     .Resizable     = .F.
835:                     .ReadOnly      = .T.
836:                     .ControlSource = "xTotMatOp.Qtds"
837:                     WITH .Header1
838:                         .FontName  = "Tahoma"
839:                         .FontSize  = 8
840:                         .Alignment = 2
841:                         .Caption   = "Quantidade"
842:                     ENDWITH
843:                     WITH .Text1
844:                         .BorderStyle = 0
845:                         .Margin      = 0
846:                         .ReadOnly    = .T.
847:                         .ForeColor   = RGB(0,0,0)
848:                         .BackColor   = RGB(255,255,255)
849:                     ENDWITH
850:                 ENDWITH
851:                 WITH .Column3
852:                     .Width         = 35
853:                     .Movable       = .F.
854:                     .Resizable     = .F.
855:                     .ReadOnly      = .T.
856:                     .ControlSource = "xTotMatOp.CUnis"
857:                     WITH .Header1
858:                         .FontName  = "Tahoma"
859:                         .FontSize  = 8
860:                         .Alignment = 2
861:                         .Caption   = "Uni"
862:                     ENDWITH
863:                     WITH .Text1
864:                         .BorderStyle = 0
865:                         .Margin      = 0
866:                         .ReadOnly    = .T.
867:                         .ForeColor   = RGB(0,0,0)
868:                         .BackColor   = RGB(255,255,255)
869:                     ENDWITH
870:                 ENDWITH
871:                 WITH .Column4
872:                     .Width         = 100
873:                     .Movable       = .F.
874:                     .Resizable     = .F.
875:                     .ReadOnly      = .T.
876:                     .ControlSource = "xTotMatOp.Pesos"
877:                     WITH .Header1
878:                         .FontName  = "Tahoma"
879:                         .FontSize  = 8
880:                         .Alignment = 2
881:                         .Caption   = "Peso Atual"
882:                     ENDWITH
883:                     WITH .Text1
884:                         .BorderStyle = 0
885:                         .Margin      = 0
886:                         .ReadOnly    = .T.
887:                         .ForeColor   = RGB(0,0,0)
888:                         .BackColor   = RGB(255,255,255)
889:                     ENDWITH
890:                 ENDWITH
891:                 .Visible = .T.

*-- Linhas 898 a 928:
898: 
899:         *-- Posicionar cursores no topo e aplicar filtro inicial
900:         IF USED("xTotPedOp") AND USED("xMatOp")
901:             SELECT xTotPedOp
902:             GO TOP
903:             IF NOT EOF("xTotPedOp") AND RECCOUNT("xTotPedOp") > 0
904:                 LOCAL loc_nNopsInicial
905:                 loc_nNopsInicial = xTotPedOp.Nops
906:                 SELECT xMatOp
907:                 SET FILTER TO Nops = loc_nNopsInicial
908:                 GO TOP
909:                 RELEASE loc_nNopsInicial
910:             ENDIF
911:         ENDIF
912:         IF USED("xTotMatOp")
913:             SELECT xTotMatOp
914:             GO TOP
915:         ENDIF
916:     ENDPROC
917: 
918:     *==========================================================================
919:     * ConfigurarEtiquetas - Adiciona controles no container cnt_4c_Etiquetas
920:     *==========================================================================
921:     PROTECTED PROCEDURE ConfigurarEtiquetas()
922:         LOCAL loc_oErro
923:         LOCAL loc_lSucesso
924:         loc_lSucesso = .F.
925: 
926:         TRY
927:             *-- Carrega impressoras (SQL + Windows) criando cursor crImpreV
928:             THIS.this_oBusinessObject.CarregarImpressoras()

*-- Linhas 1404 a 1463:
1404:             loc_nMaxTpEtis = 5
1405:             loc_nTpEtiPads = 0
1406:             IF USED("crSigCdPam")
1407:                 SELECT crSigCdPam
1408:                 GO TOP
1409:                 loc_nMaxTpEtis = IIF(VARTYPE(crSigCdPam.nMaxTpEtis) = "N", ;
1410:                                      crSigCdPam.nMaxTpEtis, 5)
1411:                 loc_nTpEtiPads = IIF(VARTYPE(crSigCdPam.TpEtiPads) = "N", ;
1412:                                      crSigCdPam.TpEtiPads, 0)
1413:             ELSE
1414:                 IF USED("cursor_4c_TmpPam")
1415:                     USE IN cursor_4c_TmpPam
1416:                 ENDIF
1417:                 loc_cSQL = "SELECT TOP 1 nMaxTpEtis, TpEtiPads FROM SigCdPam"
1418:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPam") > 0
1419:                     SELECT cursor_4c_TmpPam
1420:                     loc_nMaxTpEtis = IIF(VARTYPE(nMaxTpEtis) = "N", nMaxTpEtis, 5)
1421:                     loc_nTpEtiPads = IIF(VARTYPE(TpEtiPads)  = "N", TpEtiPads,  0)
1422:                     USE IN cursor_4c_TmpPam
1423:                 ENDIF
1424:             ENDIF
1425: 
1426:             *-- Query SigCdTpe filtrado e ordenado
1427:             IF USED("cursor_4c_SigCdTpe")
1428:                 USE IN cursor_4c_SigCdTpe
1429:             ENDIF
1430:             loc_cSQL = "SELECT nTipos, cEtiquetas FROM SigCdTpe" + ;
1431:                        " WHERE nSituas = 1" + ;
1432:                        " ORDER BY cOrdems, cEtiquetas"
1433:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdTpe")
1434: 
1435:             IF loc_nRet > 0
1436:                 SELECT cursor_4c_SigCdTpe
1437:                 COUNT TO loc_nTipos
1438:                 loc_nTipoPadrao = 1
1439: 
1440:                 WITH THIS.cnt_4c_Etiquetas.obj_4c_Opt_Tipo
1441:                     IF loc_nTipos > 0
1442:                         loc_nMaxTipos = MIN(loc_nTipos, MAX(loc_nMaxTpEtis, 5))
1443:                         .ButtonCount  = loc_nMaxTipos
1444:                         loc_nI        = 1
1445:                         loc_nTop      = 10
1446:                         loc_nHeight   = 15
1447: 
1448:                         SELECT cursor_4c_SigCdTpe
1449:                         GO TOP
1450:                         DO WHILE NOT EOF() AND loc_nI <= loc_nMaxTipos
1451:                             IF cursor_4c_SigCdTpe.nTipos = loc_nTpEtiPads
1452:                                 loc_nTipoPadrao = loc_nI
1453:                             ENDIF
1454:                             loc_cI = ALLTRIM(STR(loc_nI))
1455:                             WITH .Option&loc_cI.
1456:                                 .AutoSize  = .F.
1457:                                 .Width     = 160
1458:                                 .Caption   = " \<" + CHR(96 + loc_nI) + ". " + ;
1459:                                              ALLTRIM(cursor_4c_SigCdTpe.cEtiquetas)
1460:                                 .ForeColor = RGB(90,90,90)
1461:                                 .Themes    = .F.
1462:                                 .Tag       = ALLTRIM(STR(cursor_4c_SigCdTpe.nTipos))
1463:                                 .Top       = loc_nTop

*-- Linhas 1582 a 1600:
1582:         TRY
1583:             IF NOT EMPTY(par_cImpresS)
1584:                 IF USED("cursor_4c_TmpCimp")
1585:                     SELECT cursor_4c_TmpCimp
1586:                     LOCATE FOR ALLTRIM(UPPER(Impres)) == ALLTRIM(UPPER(par_cImpresS))
1587:                     IF FOUND()
1588:                         loc_nImpEtis = IIF(VARTYPE(ImpEtis) = "N" AND ImpEtis <> 0, ImpEtis, 1)
1589:                         loc_nAjVerts = IIF(VARTYPE(AjVerts) = "N", AjVerts, 0)
1590:                         loc_nAjHorzs = IIF(VARTYPE(AjHorzs) = "N", AjHorzs, 0)
1591:                         loc_nAjDenss = IIF(VARTYPE(AjDenss) = "N", IIF(AjDenss < 10, 10, AjDenss), 10)
1592:                         loc_nAjVelos = IIF(VARTYPE(AjVelos) = "N", AjVelos, 3)
1593: 
1594:                         WITH THIS.cnt_4c_Etiquetas.cnt_4c__Impressora
1595:                             .obj_4c_Opcao_imp.Value   = loc_nImpEtis
1596:                             .obj_4c_Spn_AjVerts.Value = loc_nAjVerts
1597:                             .obj_4c_Spn_AjHorzs.Value = loc_nAjHorzs
1598:                             .obj_4c_Spn_AjDenss.Value = loc_nAjDenss
1599:                             .obj_4c_Spn_AjVelos.Value = loc_nAjVelos
1600:                             .Visible     = .T.

*-- Linhas 1612 a 1646:
1612:     *==========================================================================
1613:     PROCEDURE GradePedOpAfterRowColChange(par_nColIndex)
1614:         IF USED("xTotPedOp") AND USED("xMatOp")
1615:             SELECT xTotPedOp
1616:             SELECT xMatOp
1617:             SET FILTER TO Nops = xTotPedOp.Nops
1618:             GO TOP
1619:             THIS.cnt_4c_Ops.grd_4c_GradeMatOp.Refresh
1620:         ENDIF
1621:     ENDPROC
1622: 
1623:     *==========================================================================
1624:     * ImpressoraInteractiveChange - BINDEVENT: atualiza config ao mudar impressora
1625:     *==========================================================================
1626:     PROCEDURE ImpressoraInteractiveChange()
1627:         LOCAL loc_cImpresS
1628:         loc_cImpresS = ""
1629: 
1630:         IF USED("crImpreV")
1631:             SELECT crImpreV
1632:             IF NOT EOF()
1633:                 loc_cImpresS = ALLTRIM(NVL(crImpreV.impresS, ""))
1634:             ENDIF
1635:         ENDIF
1636: 
1637:         THIS.CarregarConfigImpressora(loc_cImpresS)
1638:     ENDPROC
1639: 
1640:     *==========================================================================
1641:     * BtnImprimirClick - BINDEVENT: prepara dbImpressao e executa SigOpEtq
1642:     *==========================================================================
1643:     PROCEDURE BtnImprimirClick()
1644:         LOCAL loc_lSucesso, loc_oErro
1645:         LOCAL loc_nTipos, loc_nTipEtq, loc_cNomeImp, loc_lImpPreco, loc_lImpPeso
1646:         LOCAL loc_nTpImpressora, loc_nAjVerts, loc_nAjHorzs, loc_nAjDenss, loc_nAjVelos

*-- Linhas 1654 a 1691:
1654:                 loc_lImpPeso  = (.obj_4c_Opt_peso.Value = 1)
1655: 
1656:                 IF USED("crImpreV")
1657:                     SELECT crImpreV
1658:                     loc_cNomeImp = IIF(NOT EOF(), ALLTRIM(NVL(crImpreV.Impres, "")), "")
1659:                 ELSE
1660:                     loc_cNomeImp = ""
1661:                 ENDIF
1662: 
1663:                 WITH .cnt_4c__Impressora
1664:                     loc_nTpImpressora = .obj_4c_Opcao_imp.Value
1665:                     loc_nAjVerts      = .obj_4c_Spn_AjVerts.Value
1666:                     loc_nAjHorzs      = .obj_4c_Spn_AjHorzs.Value
1667:                     loc_nAjDenss      = .obj_4c_Spn_AjDenss.Value
1668:                     loc_nAjVelos      = .obj_4c_Spn_AjVelos.Value
1669:                     .Visible     = .T.
1670:                 ENDWITH
1671:                 .Visible     = .T.
1672:             ENDWITH
1673: 
1674:             IF THIS.this_oBusinessObject.PrepararDbImpressao(loc_nTipEtq)
1675:                 IF USED("dbImpressao")
1676:                     SELECT dbImpressao
1677:                     GO TOP
1678:                 ENDIF
1679: 
1680:                 =SigOpEtq(gnConnHandle, loc_lImpPreco, .F., loc_nTipEtq, ;
1681:                            loc_nTpImpressora, loc_nAjVerts, loc_nAjHorzs, loc_nAjDenss, ;
1682:                            .NULL., .NULL., .NULL., loc_cNomeImp, ;
1683:                            .F., .F., loc_nAjVelos, loc_lImpPeso)
1684: 
1685:                 MsgInfo("Impress" + CHR(227) + "o Conclu" + CHR(237) + "da!!!", "")
1686:                 loc_lSucesso = .T.
1687:             ENDIF
1688:         CATCH TO loc_oErro
1689:             MsgErro(loc_oErro.Message, "Erro")
1690:         ENDTRY
1691: 

*-- Linhas 1723 a 1761:
1723:                     .FontName    = "Verdana"
1724:                     .FontSize    = 8
1725:                     .RecordMark  = .F.
1726:                     .DeleteMark  = .F.
1727:                     .Visible     = .T.
1728:                 ENDWITH
1729:             ENDIF
1730: 
1731:             IF PEMSTATUS(THIS, "grd_4c_GradePedidos", 5)
1732:                 WITH THIS.grd_4c_GradePedidos
1733:                     .FontName    = "Verdana"
1734:                     .FontSize    = 8
1735:                     .RecordMark  = .F.
1736:                     .DeleteMark  = .F.
1737:                     .Visible     = .T.
1738:                 ENDWITH
1739:             ENDIF
1740: 
1741:             IF PEMSTATUS(THIS, "grd_4c_GradeMateriais", 5)
1742:                 WITH THIS.grd_4c_GradeMateriais
1743:                     .FontName    = "Verdana"
1744:                     .FontSize    = 8
1745:                     .RecordMark  = .F.
1746:                     .DeleteMark  = .F.
1747:                     .Visible     = .T.
1748:                 ENDWITH
1749:             ENDIF
1750: 
1751:             *-- Garante labels visiveis
1752:             IF PEMSTATUS(THIS, "lbl_4c_Envelopes", 5)
1753:                 THIS.lbl_4c_Envelopes.Visible = .T.
1754:             ENDIF
1755:             IF PEMSTATUS(THIS, "lbl_4c_Materiais", 5)
1756:                 THIS.lbl_4c_Materiais.Visible = .T.
1757:             ENDIF
1758:             IF PEMSTATUS(THIS, "lbl_4c_Label1", 5)
1759:                 THIS.lbl_4c_Label1.Visible = .T.
1760:             ENDIF
1761:         CATCH TO loc_oErro

*-- Linhas 1842 a 1860:
1842:                 IF THIS.cnt_4c_Etiquetas.Visible
1843:                     loc_cImpresS = ""
1844:                     IF USED("crImpreV")
1845:                         SELECT crImpreV
1846:                         IF NOT EOF()
1847:                             loc_cImpresS = ALLTRIM(NVL(crImpreV.impresS, ""))
1848:                         ENDIF
1849:                     ENDIF
1850:                     THIS.CarregarConfigImpressora(loc_cImpresS)
1851:                 ENDIF
1852:             ENDIF
1853:         CATCH TO loc_oErro
1854:             MsgErro(loc_oErro.Message, "Erro BtnIncluirClick")
1855:         ENDTRY
1856:     ENDPROC
1857: 
1858:     *==========================================================================
1859:     * BtnAlterarClick - Form OPERACIONAL (sem CRUD - resumo somente leitura)
1860:     * Wrapper canonico para a auditoria do orquestrador.

*-- Linhas 1932 a 1953:
1932:             *-- Se acabou de exibir CntOps, sincroniza xMatOp pelo primeiro Nops
1933:             IF THIS.this_oBusinessObject.this_lExibeCntOps
1934:                 IF USED("xTotPedOp") AND USED("xMatOp")
1935:                     SELECT xTotPedOp
1936:                     GO TOP
1937:                     IF NOT EOF()
1938:                         SELECT xMatOp
1939:                         SET FILTER TO Nops = xTotPedOp.Nops
1940:                         GO TOP
1941:                     ENDIF
1942:                     IF PEMSTATUS(THIS, "cnt_4c_Ops", 5)
1943:                         IF PEMSTATUS(THIS.cnt_4c_Ops, "grd_4c_GradeMatOp", 5)
1944:                             THIS.cnt_4c_Ops.grd_4c_GradeMatOp.Refresh
1945:                         ENDIF
1946:                     ENDIF
1947:                 ENDIF
1948:             ENDIF
1949:         CATCH TO loc_oErro
1950:             MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
1951:         ENDTRY
1952:     ENDPROC
1953: 

*-- Linhas 2059 a 2077:
2059:                     ENDWITH
2060: 
2061:                     IF USED("crImpreV")
2062:                         SELECT crImpreV
2063:                         IF NOT EOF()
2064:                             THIS.this_oBusinessObject.this_cNomeImpressora = ;
2065:                                 ALLTRIM(NVL(crImpreV.Impres, ""))
2066:                         ENDIF
2067:                     ENDIF
2068:                     .Visible     = .T.
2069:                 ENDWITH
2070:             ENDIF
2071:         CATCH TO loc_oErro
2072:             MsgErro(loc_oErro.Message, "Erro FormParaBO")
2073:         ENDTRY
2074: 
2075:         RETURN .T.
2076:     ENDPROC
2077: 


### BO (C:\4c\projeto\app\classes\SigPdM10BO.prg):
*==============================================================================
* SigPdM10BO.prg - Business Object para Resumo da Movimenta" + CHR(231) + CHR(227) + "o
* Form OPERACIONAL: recebe cursores pre-preparados do form pai via Init().
* Nao gerencia tabela CRUD direta - dados sao read-only a partir de cursores
* compartilhados da sessao de dados do form pai (xNensi, xPesa, xMFas).
*==============================================================================

DEFINE CLASS SigPdM10BO AS BusinessBase

    *-- Identificacao da movimentacao (lidos de TmpNens no Init do form)
    this_cEmps      = ""     && Codigo da empresa
    this_cDopps     = ""     && Tipo de operacao
    this_nNumps     = 0      && Numero da movimentacao
    this_dDatas     = {}     && Data da movimentacao
    this_cPosicaor  = ""     && Chave composta Emps+Dopps+Str(Numps,10)

    *-- Controle de modo de exibicao (definido por SigCdOpd.ResumoPOp)
    this_lExibeCntOps      = .F.    && .T. = exibir painel resumo por OP (CntOps)
    this_lMostrarEtiquetas = .F.    && Visibilidade do container de etiquetas

    *-- Configuracao de etiquetas (populados do container Etiquetas)
    this_nTipoEtiqueta   = 0     && Codigo nTipos do tipo selecionado (SigCdTpe.nTipos)
    this_lImpPreco       = .F.   && Imprimir preco na etiqueta
    this_lImpPeso        = .F.   && Imprimir peso na etiqueta
    this_cNomeImpressora = ""    && Nome da impressora Windows selecionada
    this_nTpImpressora   = 0     && Tipo: 1=Allegro, 2=Zebra ZPL, 3=Zebra EPL
    this_nAjVerts        = 0     && Ajuste vertical de impressao
    this_nAjHorzs        = 0     && Ajuste horizontal de impressao
    this_nAjDenss        = 10   && Densidade de impressao (10-20)
    this_nAjVelos        = 3     && Velocidade de impressao (1-3)

    *-- Titulo dinamico do label de pesos (depende do form pai)
    this_cTituloEnvelopes = ""   && Caption dinamico: "Peso por [Titulo do pai]"

    *-- Modo herdado do form pai (INSERIR/ALTERAR) para DtFechas
    this_cModoParent = ""

    *-- Flags de SigCdOpd para controle de impressao de etiquetas
    this_nChkUnis = 0    && Verifica se usa unidades para etiquetas
    this_nEtiqs   = 0    && Flag de etiquetas habilitadas

    *--------------------------------------------------------------------------
    * Init - Configuracao basica do BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Le cursor TmpNens e popula propriedades do BO
    * par_cAliasCursor: nome do alias "TmpNens" (cursor do form pai)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            GO TOP
            THIS.this_cEmps     = ALLTRIM(NVL(Emps,  ""))
            THIS.this_cDopps    = ALLTRIM(NVL(Dopps, ""))
            THIS.this_nNumps    = NVL(Numps, 0)
            THIS.this_dDatas    = NVL(DataS, {})
            THIS.this_cPosicaor = THIS.this_cEmps + THIS.this_cDopps + STR(THIS.this_nNumps, 10)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta Emps+Dopps+Str(Numps,10)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cPosicaor
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel para form operacional sem persistencia direta
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel para form operacional
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarModoCntOps - Consulta SigCdOpd.ResumoPOp para determinar layout
    * Popula: this_lExibeCntOps, this_nChkUnis, this_nEtiqs
    *--------------------------------------------------------------------------
    PROCEDURE VerificarModoCntOps()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_TmpOpd")
                TABLEREVERT(.T., "cursor_4c_TmpOpd")
                USE IN cursor_4c_TmpOpd
            ENDIF

            loc_cSQL = "SELECT ResumoPOp, ChkUnis, Etiqs FROM SigCdOpd WHERE Dopes = " + EscaparSQL(THIS.this_cDopps)
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpd")

            IF loc_nRet > 0
                SELECT cursor_4c_TmpOpd
                IF NOT EOF()
                    IF VARTYPE(cursor_4c_TmpOpd.ResumoPOp) = "L"
                        THIS.this_lExibeCntOps = cursor_4c_TmpOpd.ResumoPOp
                    ELSE
                        IF VARTYPE(cursor_4c_TmpOpd.ResumoPOp) = "L"
                            THIS.this_lExibeCntOps = cursor_4c_TmpOpd.ResumoPOp
                        ELSE
                            IF VARTYPE(cursor_4c_TmpOpd.ResumoPOp) = "L"
                                THIS.this_lExibeCntOps = cursor_4c_TmpOpd.ResumoPOp
                            ELSE
                                IF VARTYPE(cursor_4c_TmpOpd.ResumoPOp) = "L"
                                    THIS.this_lExibeCntOps = cursor_4c_TmpOpd.ResumoPOp
                                ELSE
                                    IF VARTYPE(cursor_4c_TmpOpd.ResumoPOp) = "L"
                                        THIS.this_lExibeCntOps = cursor_4c_TmpOpd.ResumoPOp
                                    ELSE
                                        THIS.this_lExibeCntOps = (NVL(cursor_4c_TmpOpd.ResumoPOp, 0) = 1)
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                    THIS.this_nChkUnis     = NVL(cursor_4c_TmpOpd.ChkUnis, 0)
                    THIS.this_nEtiqs       = NVL(cursor_4c_TmpOpd.Etiqs,   0)
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao verificar modo de exibi" + CHR(231) + CHR(227) + "o.", "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararCursores - Cria cursores de trabalho para os grids
    * Cursores criados: xTotEnv, xTotMat, xTotPed, xTotMatOp, xMatOp, xTotPedOp
    *--------------------------------------------------------------------------
    PROCEDURE PrepararCursores()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            SET NULL ON

            IF USED("xTotEnv")
                USE IN xTotEnv
            ENDIF
            CREATE CURSOR xTotEnv (Nenvs N(10) NULL, Entrada N(12,3) NULL, Saida N(12,3) NULL)
            INDEX ON Nenvs TAG Nenvs

            IF USED("xTotMat")
                USE IN xTotMat
            ENDIF
            CREATE CURSOR xTotMat (CMats C(14) NULL, DPros C(40) NULL, CUnis C(3) NULL, Qtds N(10,3) NULL, Pesos N(10,3) NULL)
            INDEX ON CMats TAG CMats

            IF USED("xTotPed")
                USE IN xTotPed
            ENDIF
            CREATE CURSOR xTotPed (Emps C(3) NULL, Dopes C(20) NULL, Numes N(6) NULL, MascNum C(6) NULL, NConta C(50) NULL, Repres C(50) NULL, Flag N(1) NULL, DtFechas D NULL)
            INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum

            IF USED("xTotMatOp")
                USE IN xTotMatOp
            ENDIF
            CREATE CURSOR xTotMatOp (CMats C(14) NULL, CUnis C(3) NULL, Qtds N(10,3) NULL, Pesos N(10,3) NULL)
            INDEX ON CMats TAG CMats

            IF USED("xMatOp")
                USE IN xMatOp
            ENDIF
            CREATE CURSOR xMatOp (CMats C(14) NULL, DPros C(40) NULL, CUnis C(3) NULL, Qtds N(10,3) NULL, Pesos N(10,3) NULL, Nops N(10) NULL)
            INDEX ON STR(Nops, 10) + CMats TAG NopMats

            IF USED("xTotPedOp")
                USE IN xTotPedOp
            ENDIF
            CREATE CURSOR xTotPedOp (Emps C(3) NULL, Dopes C(20) NULL, Numes N(6) NULL, MascNum C(6) NULL, NConta C(50) NULL, Flag N(1) NULL, DtFechas D NULL, Nops N(10) NULL)
            INDEX ON Emps + Dopes + STR(Numes, 6) + STR(Nops, 10) TAG EdnNops

            SET NULL OFF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            SET NULL OFF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEnvelopes - Processa xPesa e popula xTotEnv.Saida
    * Agrupa pesos por envelope e insere totais em xTotEnv
    *--------------------------------------------------------------------------
    PROCEDURE CarregarEnvelopes()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF NOT USED("xPesa")
            RETURN loc_lSucesso
        ENDIF

        TRY
            SET NULL ON
            IF USED("cursor_4c_TmpEnv")
                USE IN cursor_4c_TmpEnv
            ENDIF
            SELECT Nenvs, SUM(Peso) AS tPeso ;
                FROM xPesa ;
                GROUP BY Nenvs ;
                ORDER BY Nenvs ;
                INTO CURSOR cursor_4c_TmpEnv READWRITE
            SET NULL OFF

            SELECT cursor_4c_TmpEnv
            SCAN
                LOCAL loc_nNenvE, loc_nPesoE
                loc_nNenvE = cursor_4c_TmpEnv.Nenvs
                loc_nPesoE = cursor_4c_TmpEnv.tPeso

                SELECT xTotEnv
                IF NOT SEEK(loc_nNenvE)
                    INSERT INTO xTotEnv (Nenvs, Entrada, Saida) VALUES (loc_nNenvE, 0, 0)
                ENDIF
                REPLACE Saida WITH loc_nPesoE IN xTotEnv

                RELEASE loc_nNenvE, loc_nPesoE
                SELECT cursor_4c_TmpEnv
            ENDSCAN

            IF USED("cursor_4c_TmpEnv")
                USE IN cursor_4c_TmpEnv
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarRateio - Ajusta quantidades/pesos de xNensi conforme logica de rateio
    * Distribui proporcional o peso da pesagem entre os itens de rateio=2
    * Rateio=3: descontado da pesagem total
    * Rateio=2: recebe proporcao + saldo de arredondamento no primeiro registro
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarRateio()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF NOT USED("xPesa") OR NOT USED("xNensi")
            RETURN loc_lSucesso
        ENDIF

        TRY
            SET NULL ON
            IF USED("xRateio")
                USE IN xRateio
            ENDIF
            SELECT Nenvs, SUM(Peso) AS Pesos ;
                FROM xPesa ;
                GROUP BY Nenvs ;
                ORDER BY Nenvs ;
                INTO CURSOR xRateio READWRITE
            SET NULL OFF

            SELECT xRateio
            SCAN
                LOCAL loc_nNenv, loc_nPesagem, loc_nPesoAnt, loc_nRecno, loc_nDifPeso
                loc_nNenv    = xRateio.Nenvs
                loc_nPesagem = xRateio.Pesos
                loc_nPesoAnt = 0
                loc_nRecno   = 0

                SELECT xNensi
                SCAN FOR (Rateio = 3) AND (Nenvs = loc_nNenv) AND NOT FlagIncs
                    loc_nPesagem = loc_nPesagem - Pesos
                ENDSCAN

                SELECT xNensi
                SCAN FOR (Rateio = 2) AND (Nenvs = loc_nNenv) AND NOT FlagIncs
                    IF loc_nRecno = 0
                        loc_nRecno = RECNO()
                    ENDIF
                    loc_nPesoAnt = loc_nPesoAnt + PsFaseAnt
                ENDSCAN

                loc_nDifPeso = loc_nPesagem - loc_nPesoAnt

                SELECT xNensi
                SCAN FOR (Rateio = 2) AND (Nenvs = loc_nNenv) AND NOT FlagIncs
                    LOCAL loc_nDiv, loc_nNovoPeso
                    loc_nDiv      = IIF(loc_nPesoAnt = 0, 1, loc_nPesoAnt)
                    loc_nNovoPeso = ROUND(PsFaseAnt + (PsFaseAnt / loc_nDiv * loc_nDifPeso), 2)
                    REPLACE Pesos WITH loc_nNovoPeso, Qtds WITH loc_nNovoPeso
                    loc_nPesagem  = loc_nPesagem - loc_nNovoPeso
                    RELEASE loc_nDiv, loc_nNovoPeso
                ENDSCAN

                IF (loc_nRecno <> 0) AND (loc_nPesagem <> 0)
                    SELECT xNensi
                    GO loc_nRecno
                    REPLACE Pesos WITH xNensi.Pesos + loc_nPesagem, ;
                            Qtds  WITH xNensi.Qtds  + loc_nPesagem
                ENDIF

                RELEASE loc_nNenv, loc_nPesagem, loc_nPesoAnt, loc_nRecno, loc_nDifPeso
                SELECT xRateio
            ENDSCAN

            IF USED("xRateio")
                USE IN xRateio
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarMateriais - Processa xNensi e popula xTotMat + atualiza xTotEnv.Entrada
    * Para cada item com Rateio in (2,3,5): acumula Qtds/Pesos em xTotMat
    * e acumula PsFaseAnt em xTotEnv.Entrada
    *--------------------------------------------------------------------------
    PROCEDURE CarregarMateriais()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_cCMats, loc_cDPros, loc_cCUnis
        loc_lSucesso = .F.

        IF NOT USED("xNensi")
            RETURN loc_lSucesso
        ENDIF

        TRY
            SELECT xNensi
            SET ORDER TO
            SCAN
                IF INLIST(xNensi.Rateio, 2, 3, 5)
                    loc_cCMats = ALLTRIM(xNensi.CMats)

                    SELECT xTotMat
                    IF NOT SEEK(loc_cCMats)
                        IF USED("cursor_4c_LocalPro")
                            TABLEREVERT(.T., "cursor_4c_LocalPro")
                            USE IN cursor_4c_LocalPro
                        ENDIF
                        loc_cSQL = "SELECT CUnis, DPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCMats)
                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro")
                        IF loc_nRet > 0 AND NOT EOF("cursor_4c_LocalPro")
                            SELECT cursor_4c_LocalPro
                            loc_cDPros = ALLTRIM(NVL(DPros, ""))
                            loc_cCUnis = ALLTRIM(NVL(CUnis, ""))
                        ELSE
                            loc_cDPros = ""
                            loc_cCUnis = ""
                        ENDIF

                        INSERT INTO xTotMat (CMats, DPros, CUnis, Qtds, Pesos) ;
                            VALUES (loc_cCMats, loc_cDPros, loc_cCUnis, 0, 0)
                    ENDIF

                    REPLACE Qtds  WITH xTotMat.Qtds  + xNensi.Qtds, ;
                            Pesos WITH xTotMat.Pesos + xNensi.Pesos IN xTotMat

                    SELECT xTotEnv
                    IF NOT SEEK(xNensi.Nenvs)
                        INSERT INTO xTotEnv (Nenvs, Entrada, Saida) VALUES (xNensi.Nenvs, 0, 0)
                    ENDIF
                    REPLACE Entrada WITH xTotEnv.Entrada + xNensi.PsFaseAnt IN xTotEnv

                    SELECT xNensi
                ENDIF
            ENDSCAN

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPedidosBaixados - Processa xMFas e popula xTotPed + xTotPedOp
    * Para cada OP (xMFas.Nops): busca pedidos via SigOpPic, monta NConta via
    * SigMvCab + SigCdCli e insere em xTotPed e xTotPedOp
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPedidosBaixados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_cEmp, loc_cEdn, loc_cNConta, loc_cConta, loc_cVends, loc_nNops
        loc_lSucesso = .F.

        IF NOT USED("xMFas")
            RETURN loc_lSucesso
        ENDIF

        TRY
            SELECT xMFas
            SCAN
                loc_nNops = xMFas.Nops

                IF USED("cursor_4c_LocalOpi")
                    TABLEREVERT(.T., "cursor_4c_LocalOpi")
                    USE IN cursor_4c_LocalOpi
                ENDIF
                loc_cSQL = "SELECT Emps, Dopes, Numes, EmpDs FROM SigOpPic WHERE Nops = " + FormatarNumeroSQL(loc_nNops)
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpi")

                IF loc_nRet > 0
                    SELECT cursor_4c_LocalOpi
                    SCAN
                        loc_cEmp = IIF(EMPTY(cursor_4c_LocalOpi.EmpDs), ;
                                       ALLTRIM(cursor_4c_LocalOpi.Emps), ;
                                       ALLTRIM(cursor_4c_LocalOpi.EmpDs))
                        loc_cEdn = loc_cEmp + ALLTRIM(cursor_4c_LocalOpi.Dopes) + STR(cursor_4c_LocalOpi.Numes, 6)

                        SELECT xTotPed
                        IF NOT SEEK(loc_cEdn)
                            IF USED("cursor_4c_LocalEest")
                                TABLEREVERT(.T., "cursor_4c_LocalEest")
                                USE IN cursor_4c_LocalEest
                            ENDIF
                            loc_cSQL = "SELECT ContaOs, ContaDs, Vends FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(loc_cEdn)
                            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEest")

                            IF loc_nRet > 0 AND NOT EOF("cursor_4c_LocalEest")
                                SELECT cursor_4c_LocalEest
                                loc_cConta = IIF(EMPTY(cursor_4c_LocalEest.ContaDs), ;
                                                 ALLTRIM(cursor_4c_LocalEest.ContaOs), ;
                                                 ALLTRIM(cursor_4c_LocalEest.ContaDs))
                                loc_cVends = ALLTRIM(NVL(cursor_4c_LocalEest.Vends, ""))
                            ELSE
                                loc_cConta = ""
                                loc_cVends = ""
                            ENDIF

                            IF USED("cursor_4c_LocalCli")
                                TABLEREVERT(.T., "cursor_4c_LocalCli")
                                USE IN cursor_4c_LocalCli
                            ENDIF
                            IF NOT EMPTY(loc_cConta)
                                loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cConta)
                                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalCli")
                                IF loc_nRet > 0 AND NOT EOF("cursor_4c_LocalCli")
                                    SELECT cursor_4c_LocalCli
                                    loc_cNConta = loc_cConta + " / " + ALLTRIM(NVL(RClis, ""))
                                ELSE
                                    loc_cNConta = loc_cConta
                                ENDIF
                            ELSE
                                loc_cNConta = ""
                            ENDIF

                            SELECT cursor_4c_LocalOpi
                            INSERT INTO xTotPed (Emps, Dopes, Numes, MascNum, NConta, Repres, Flag) ;
                                VALUES (loc_cEmp, ALLTRIM(cursor_4c_LocalOpi.Dopes), ;
                                        cursor_4c_LocalOpi.Numes, ;
                                        ALLTRIM(STR(cursor_4c_LocalOpi.Numes, 6)), ;
                                        loc_cNConta, loc_cVends, 0)

                            INSERT INTO xTotPedOp (Emps, Dopes, Numes, MascNum, NConta, Nops, Flag) ;
                                VALUES (loc_cEmp, ALLTRIM(cursor_4c_LocalOpi.Dopes), ;
                                        cursor_4c_LocalOpi.Numes, ;
                                        ALLTRIM(STR(cursor_4c_LocalOpi.Numes, 6)), ;
                                        loc_cNConta, loc_nNops, 0)
                        ENDIF

                        SELECT cursor_4c_LocalOpi
                    ENDSCAN
                ENDIF

                SELECT xMFas
            ENDSCAN

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarResumoPorOP - Processa xNensi e popula xMatOp; copia xTotMat em xTotMatOp
    * Para cada item com Rateio in (2,3,5): acumula em xMatOp indexado por Nops+CMats
    *--------------------------------------------------------------------------
    PROCEDURE CarregarResumoPorOP()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_cCMats, loc_cDPros, loc_cCUnis, loc_nNops
        loc_lSucesso = .F.

        IF NOT USED("xNensi")
            RETURN loc_lSucesso
        ENDIF

        TRY
            SELECT xNensi
            SET ORDER TO
            SCAN
                IF INLIST(xNensi.Rateio, 2, 3, 5)
                    loc_cCMats = ALLTRIM(xNensi.CMats)
                    loc_nNops  = xNensi.Nops

                    SELECT xMatOp
                    IF NOT SEEK(STR(loc_nNops, 10) + loc_cCMats)
                        IF USED("cursor_4c_LocalPro")
                            TABLEREVERT(.T., "cursor_4c_LocalPro")
                            USE IN cursor_4c_LocalPro
                        ENDIF
                        loc_cSQL = "SELECT CUnis, DPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCMats)
                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro")
                        IF loc_nRet > 0 AND NOT EOF("cursor_4c_LocalPro")
                            SELECT cursor_4c_LocalPro
                            loc_cDPros = ALLTRIM(NVL(DPros, ""))
                            loc_cCUnis = ALLTRIM(NVL(CUnis, ""))
                        ELSE
                            loc_cDPros = ""
                            loc_cCUnis = ""
                        ENDIF

                        INSERT INTO xMatOp (CMats, DPros, CUnis, Qtds, Pesos, Nops) ;
                            VALUES (loc_cCMats, loc_cDPros, loc_cCUnis, 0, 0, loc_nNops)
                    ENDIF

                    REPLACE Qtds  WITH xMatOp.Qtds  + xNensi.Qtds, ;
                            Pesos WITH xMatOp.Pesos + xNensi.Pesos IN xMatOp

                    SELECT xNensi
                ENDIF
            ENDSCAN

            SELECT xTotMat
            SCAN
                INSERT INTO xTotMatOp (CMats, CUnis, Qtds, Pesos) ;
                    VALUES (xTotMat.CMats, xTotMat.CUnis, xTotMat.Qtds, xTotMat.Pesos)
            ENDSCAN

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarPedidosFechados - Verifica SigCdNec (ChkSubn) por pedido em xTotPed
    * Remove pedidos em aberto (Flag=0) e preenche DtFechas nos fechados
    *--------------------------------------------------------------------------
    PROCEDURE MarcarPedidosFechados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_cChave, loc_lAberto, loc_cChaveP
        loc_lSucesso = .F.

        TRY
            SELECT xTotPed
            SCAN
                loc_cChave  = ALLTRIM(Emps) + ALLTRIM(Dopes) + STR(Numes, 6)
                loc_lAberto = .F.

                IF USED("cursor_4c_LocalOpi")
                    TABLEREVERT(.T., "cursor_4c_LocalOpi")
                    USE IN cursor_4c_LocalOpi
                ENDIF
                loc_cSQL = "SELECT Emps, Dopps, Nops FROM SigOpPic WHERE EmpDopNums = " + EscaparSQL(loc_cChave)
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpi")

                IF loc_nRet > 0
                    SELECT cursor_4c_LocalOpi
                    SCAN
                        loc_cChaveP = ALLTRIM(cursor_4c_LocalOpi.Emps) + ;
                                      ALLTRIM(cursor_4c_LocalOpi.Dopps) + ;
                                      STR(cursor_4c_LocalOpi.Nops, 10)

                        IF USED("cursor_4c_LocalNens")
                            TABLEREVERT(.T., "cursor_4c_LocalNens")
                            USE IN cursor_4c_LocalNens
                        ENDIF
                        loc_cSQL = "SELECT ChkSubn FROM SigCdNec WHERE EmpDNPs = " + EscaparSQL(loc_cChaveP)
                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalNens")

                        IF loc_nRet > 0 AND NOT EOF("cursor_4c_LocalNens")
                            SELECT cursor_4c_LocalNens
                            IF NOT NVL(ChkSubn, .F.)
                                loc_lAberto = .T.
                                EXIT
                            ENDIF
                        ELSE
                            loc_lAberto = .T.
                            EXIT
                        ENDIF

                        SELECT cursor_4c_LocalOpi
                    ENDSCAN
                ENDIF

                IF NOT loc_lAberto
                    REPLACE Flag WITH 1 IN xTotPed
                ENDIF

                SELECT xTotPed
            ENDSCAN

            SELECT xTotPed
            DELETE FOR Flag = 0
            PACK

            IF INLIST(THIS.this_cModoParent, "INSERIR", "ALTERAR")
                IF USED("TmpNens")
                    SELECT TmpNens
                    LOCAL loc_dDataS
                    loc_dDataS = NVL(DataS, DATE())
                    SELECT xTotPed
                    SCAN
                        REPLACE DtFechas WITH loc_dDataS
                    ENDSCAN
                    RELEASE loc_dDataS
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Orquestra o processo completo de carregamento de dados
    * Sequencia: PrepararCursores > Envelopes > Rateio > Materiais >
    *            PedidosBaixados > ResumoPorOP > MarcarFechados
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.PrepararCursores()
            IF loc_lSucesso
                loc_lSucesso = THIS.CarregarEnvelopes()
            ENDIF
            IF loc_lSucesso
                loc_lSucesso = THIS.ProcessarRateio()
            ENDIF
            IF loc_lSucesso
                loc_lSucesso = THIS.CarregarMateriais()
            ENDIF
            IF loc_lSucesso
                loc_lSucesso = THIS.CarregarPedidosBaixados()
            ENDIF
            IF loc_lSucesso
                loc_lSucesso = THIS.CarregarResumoPorOP()
            ENDIF
            IF loc_lSucesso
                loc_lSucesso = THIS.MarcarPedidosFechados()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarImpressoras - Cria crImpreV combinando impressoras SQL + Windows
    * Consulta: SigSyImp/SigCdAcG para impressoras autorizadas ao usuario
    *           APRINTERS() para impressoras instaladas no Windows
    *--------------------------------------------------------------------------
    PROCEDURE CarregarImpressoras()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_nPrinters, loc_aPrinters, loc_nI
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT b.* FROM SigSyImp a, SigCdmp b" + ;
                       " WHERE a.UsuAcess = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " AND a.cimps = b.impres" + ;
                       " UNION ALL " + ;
                       "SELECT c.* FROM SigCdAcG a, SigSyImp b, SigCdmp c" + ;
                       " WHERE a.Usuarios = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " AND a.Grupos = b.GrAcess AND b.Cimps = c.Impres"

            IF USED("cursor_4c_TmpCimp")
                TABLEREVERT(.T., "cursor_4c_TmpCimp")
                USE IN cursor_4c_TmpCimp
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCimp")

            IF loc_nRet <= 0
                MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o com Servidor de Banco de Dados.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            IF USED("cursor_4c_SigCdmp")
                TABLEREVERT(.T., "cursor_4c_SigCdmp")
                USE IN cursor_4c_SigCdmp
            ENDIF

            IF RECCOUNT("cursor_4c_TmpCimp") > 0
                SELECT DISTINCT Impres, nTpImpres FROM cursor_4c_TmpCimp ;
                    INTO CURSOR cursor_4c_SigCdmp READWRITE
                SELECT cursor_4c_SigCdmp
                INDEX ON Impres TAG skImpres
            ELSE
                SET NULL ON
                CREATE CURSOR cursor_4c_SigCdmp (Impres C(50) NULL, nTpImpres N(2) NULL)
                INDEX ON Impres TAG skImpres
                SET NULL OFF
            ENDIF

            DIMENSION loc_aPrinters(1)
            loc_nPrinters = APRINTERS(loc_aPrinters)

            IF loc_nPrinters = 0
                MsgAviso("N" + CHR(227) + "o Foi Encontrada Nenhuma Impressora!!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            IF USED("cursor_4c_ImpWin")
                USE IN cursor_4c_ImpWin
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_ImpWin (Impres C(50) NULL)
            SET NULL OFF
            FOR loc_nI = 1 TO loc_nPrinters
                INSERT INTO cursor_4c_ImpWin (Impres) VALUES (UPPER(loc_aPrinters(loc_nI, 1)))
            ENDFOR

            IF USED("cursor_4c_ImpMatch")
                TABLEREVERT(.T., "cursor_4c_ImpMatch")
                USE IN cursor_4c_ImpMatch
            ENDIF
            SELECT PADR(ALLTRIM(a.Impres), 15) + " " + ALLTRIM(b.Impres) AS IDupla, ;
                   b.Impres, a.Impres AS impresS ;
                FROM cursor_4c_SigCdmp a, cursor_4c_ImpWin b ;
                WHERE ALLTRIM(UPPER(a.Impres)) LIKE "%" + ALLTRIM(UPPER(b.Impres)) + "%" ;
                GROUP BY b.Impres, a.Impres ;
                INTO CURSOR cursor_4c_ImpMatch READWRITE

            IF RECCOUNT("cursor_4c_ImpMatch") > 1
                SELECT cursor_4c_ImpMatch
                APPEND BLANK
            ENDIF

            IF USED("crImpreV")
                USE IN crImpreV
            ENDIF
            SELECT * FROM cursor_4c_ImpMatch ORDER BY 1 INTO CURSOR crImpreV READWRITE

            SELECT crImpreV
            GO TOP

            IF USED("cursor_4c_ImpMatch")
                USE IN cursor_4c_ImpMatch
            ENDIF
            IF USED("cursor_4c_ImpWin")
                USE IN cursor_4c_ImpWin
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDbImpressao - Monta cursor dbImpressao para uso por SigOpEtq
    * par_nTipoEtq: codigo do tipo de etiqueta selecionado (SigCdTpe.nTipos)
    * Cursor dbImpressao fica disponivel para o form chamar =SigOpEtq(...)
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDbImpressao(par_nTipoEtq)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_cChaveNs
        loc_lSucesso = .F.

        TRY
            loc_cChaveNs = THIS.this_cEmps + THIS.this_cDopps + STR(THIS.this_nNumps, 6)

            IF USED("dbImpressao")
                USE IN dbImpressao
            ENDIF
            SET NULL ON
            CREATE CURSOR dbImpressao (Cpros C(14) NULL, Dpros C(40) NULL, Qtds N(1) NULL, ;
                                       QtdeEtiq N(10,3) NULL, Pedido C(30) NULL, Obs C(10) NULL, ;
                                       Nops N(10) NULL, Notas C(6) NULL, Aros C(50) NULL, ;
                                       Pesos N(12,3) NULL, Contas C(10) NULL, ;
                                       EmpDopNums C(29) NULL, Reffs C(20) NULL, ;
                                       empos C(3) NULL, cpros1 C(14) NULL, codtams C(4) NULL)
            SET NULL OFF

            IF par_nTipoEtq = 74
                THIS.PrepararDbImpressaoOP(loc_cChaveNs)
            ELSE
                THIS.PrepararDbImpressaoPadrao(par_nTipoEtq, loc_cChaveNs)
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDbImpressaoOP - Preenche dbImpressao para etiqueta de OP (tipo 74)
    * Consulta SigOpEtq + SigEtPos e lookup em SigCdPro, SigCdOpe, SigCdPsg, SigOpPic
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDbImpressaoOP(par_cChaveNs)
        LOCAL loc_cSQL, loc_nRet
        LOCAL loc_cCPros, loc_cDopeOs, loc_cDPros, loc_cCGrus, loc_cSGrus
        LOCAL loc_lColecoes, loc_cClassis, loc_cAro, loc_nNops, loc_cAbrevs

        TRY
            IF USED("cursor_4c_LocalEti")
                TABLEREVERT(.T., "cursor_4c_LocalEti")
                USE IN cursor_4c_LocalEti
            ENDIF

            loc_cSQL = "SELECT Cpros,Nops,Qtds,ObsEtiqs AS Obs,Emps,Numes,Dopes,Empos,DopeOs,NumeOs," + ;
                       "CodTams,Pesos,CodCors,Peso2s FROM SigOpEtq" + ;
                       " WHERE EmpDopNums = " + EscaparSQL(par_cChaveNs) + ;
                       " UNION ALL " + ;
                       "SELECT Cpros,Nops,Qtds,ObsEtiqs AS Obs,Emps,Numes,Dopes,Empos,DopeOs,NumeOs," + ;
                       "CodTams,Pesos,CodCors,Peso2s FROM SigEtPos" + ;
                       " WHERE EmpDopNums = " + EscaparSQL(par_cChaveNs) + ;
                       " ORDER BY Nops"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEti")

            IF loc_nRet <= 0
                RETURN
            ENDIF

            SELECT cursor_4c_LocalEti
            SCAN
                loc_cCPros  = ALLTRIM(cursor_4c_LocalEti.CPros)
                loc_cDopeOs = ALLTRIM(cursor_4c_LocalEti.DopeOs)
                loc_nNops   = cursor_4c_LocalEti.Nops

                IF USED("cursor_4c_LocalPro")
                    TABLEREVERT(.T., "cursor_4c_LocalPro")
                    USE IN cursor_4c_LocalPro
                ENDIF
                loc_cSQL = "SELECT Cpros,CGrus,SGrus,DPros,Colecoes FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCPros)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro")

                IF USED("cursor_4c_LocalOpe")
                    TABLEREVERT(.T., "cursor_4c_LocalOpe")
                    USE IN cursor_4c_LocalOpe
                ENDIF
                loc_cSQL = "SELECT Abrevs FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cDopeOs)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpe")

                IF NOT EOF("cursor_4c_LocalPro")
                    SELECT cursor_4c_LocalPro
                    loc_cCGrus    = ALLTRIM(NVL(CGrus, ""))
                    loc_cSGrus    = ALLTRIM(NVL(SGrus, ""))
                    loc_cDPros    = ALLTRIM(NVL(DPros, ""))
                    loc_lColecoes = NOT EMPTY(NVL(Colecoes, ""))
                ELSE
                    loc_cCGrus    = ""
                    loc_cSGrus    = ""
                    loc_cDPros    = ""
                    loc_lColecoes = .F.
                ENDIF

                IF USED("cursor_4c_LocalSGru")
                    TABLEREVERT(.T., "cursor_4c_LocalSGru")
                    USE IN cursor_4c_LocalSGru
                ENDIF
                loc_cSQL = "SELECT Descricaos FROM SigCdPsg WHERE CGruCods = " + EscaparSQL(loc_cCGrus + loc_cSGrus)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalSGru")

                IF USED("cursor_4c_LocalOpi")
                    TABLEREVERT(.T., "cursor_4c_LocalOpi")
                    USE IN cursor_4c_LocalOpi
                ENDIF
                loc_cSQL = "SELECT Notas,CodTams,CodCors,Numes,dopes FROM SigOpPic WHERE Nops = " + FormatarNumeroSQL(loc_nNops)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpi")

                loc_cAro = ""

                IF NOT EOF("cursor_4c_LocalOpi")
                    SELECT cursor_4c_LocalOpi
                    LOCAL loc_lNaoN, loc_nNumeOs, loc_cDopesOi
                    loc_lNaoN   = NOT EMPTY(NVL(notas, ""))
                    loc_nNumeOs = NVL(Numes, 0)
                    loc_cDopesOi = ALLTRIM(NVL(dopes, ""))

                    loc_cClassis = PADC(IIF(loc_lColecoes AND loc_cSGrus <> PADR("N", 6), ;
                                            "Fundi" + CHR(231) + CHR(227) + "o", ;
                                            IIF(loc_lNaoN, "Os", "Alian" + CHR(231) + "a")), 10)

                    IF loc_cClassis = PADC("Os", 10)
                        IF USED("cursor_4c_CsSelecao")
                            USE IN cursor_4c_CsSelecao
                        ENDIF
                        SELECT DISTINCT CodTams FROM cursor_4c_LocalOpi ;
                            INTO CURSOR cursor_4c_CsSelecao READWRITE ;
                            ORDER BY CodTams
                        SELECT cursor_4c_CsSelecao
                        SCAN
                            loc_cAro = loc_cAro + ALLTRIM(NVL(CodTams, "")) + "/"
                        ENDSCAN
                        IF USED("cursor_4c_CsSelecao")
                            USE IN cursor_4c_CsSelecao
                        ENDIF
                    ENDIF

                    IF NOT EOF("cursor_4c_LocalOpe")
                        SELECT cursor_4c_LocalOpe
                        loc_cAbrevs = ALLTRIM(NVL(Abrevs, ""))
                    ELSE
                        loc_cAbrevs = ""
                    ENDIF

                    SELECT cursor_4c_LocalEti
                    INSERT INTO dbImpressao (CPros, DPros, Qtds, QtdeEtiq, Pedido, Obs, Nops, Notas, Aros, Pesos) ;
                        VALUES (loc_cCPros, loc_cDPros, 1, ;
                                NVL(cursor_4c_LocalEti.Qtds, 0), ;
                                loc_cAbrevs + " : " + ALLTRIM(STR(NVL(cursor_4c_LocalEti.NumeOs, 0), 6)), ;
                                ALLTRIM(NVL(cursor_4c_LocalEti.Obs, "")), ;
                                loc_nNops, ;
                                PADR(IIF(loc_lNaoN, ALLTRIM(NVL(cursor_4c_LocalOpi.notas, "")), ""), 6), ;
                                PADR(loc_cAro, 50), ;
                                NVL(cursor_4c_LocalEti.Pesos, 0))

                    RELEASE loc_lNaoN, loc_nNumeOs, loc_cDopesOi, loc_cClassis
                ENDIF

                RELEASE loc_cCPros, loc_cDopeOs, loc_cDPros, loc_cCGrus, loc_cSGrus
                RELEASE loc_lColecoes, loc_cAro, loc_nNops, loc_cAbrevs
                SELECT cursor_4c_LocalEti
            ENDSCAN
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDbImpressaoPadrao - Preenche dbImpressao para tipos de etiqueta nao-OP
    * Consulta SigOpEtq; para tipos 14,39,109,113 inclui dados de SigMvCab/SigCdCli
    * Se ChkUnis=1 e Etiqs=1, inclui etiquetas extras de SigEtPos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDbImpressaoPadrao(par_nTipoEtq, par_cChaveNs)
        LOCAL loc_cSQL, loc_nRet
        LOCAL loc_cCPros, loc_cDPros, loc_nCBars, loc_nNops, loc_cAbrevs

        TRY
            IF USED("cursor_4c_LocalEti")
                TABLEREVERT(.T., "cursor_4c_LocalEti")
                USE IN cursor_4c_LocalEti
            ENDIF
            loc_cSQL = "SELECT Cpros,Cbars,Qtds,ObsEtiqs AS Obs,Emps,Numes,Dopes,Empos,DopeOs,NumeOs,Nops" + ;
                       " FROM SigOpEtq" + ;
                       " WHERE EmpDopNums = " + EscaparSQL(par_cChaveNs) + ;
                       " ORDER BY Cbars"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEti")

            IF loc_nRet <= 0
                RETURN
            ENDIF

            SELECT cursor_4c_LocalEti
            SCAN
                loc_cCPros = ALLTRIM(cursor_4c_LocalEti.CPros)
                loc_nCBars = cursor_4c_LocalEti.Cbars
                loc_nNops  = cursor_4c_LocalEti.Nops

                IF USED("cursor_4c_LocalPro")
                    TABLEREVERT(.T., "cursor_4c_LocalPro")
                    USE IN cursor_4c_LocalPro
                ENDIF
                loc_cSQL = "SELECT CGrus, SGrus, DPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCPros)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro")
                IF NOT EOF("cursor_4c_LocalPro")
                    SELECT cursor_4c_LocalPro
                    loc_cDPros = ALLTRIM(NVL(DPros, ""))
                ELSE
                    loc_cDPros = ""
                ENDIF

                IF USED("cursor_4c_LocalOpe")
                    TABLEREVERT(.T., "cursor_4c_LocalOpe")
                    USE IN cursor_4c_LocalOpe
                ENDIF
                loc_cSQL = "SELECT Abrevs, globalizas FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(cursor_4c_LocalEti.Dopes))
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpe")

                IF USED("cursor_4c_LocalOpeO")
                    TABLEREVERT(.T., "cursor_4c_LocalOpeO")
                    USE IN cursor_4c_LocalOpeO
                ENDIF
                loc_cSQL = "SELECT Abrevs, globalizas FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(cursor_4c_LocalEti.DopeOs))
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpeO")

                IF NOT EOF("cursor_4c_LocalOpe")
                    SELECT cursor_4c_LocalOpe
                    loc_cAbrevs = ALLTRIM(NVL(Abrevs, ""))
                ELSE
                    loc_cAbrevs = ""
                ENDIF

                SELECT cursor_4c_LocalEti
                INSERT INTO dbImpressao (CPros, DPros, Qtds, QtdeEtiq, Pedido, Obs) ;
                    VALUES (STR(loc_nCBars, 14), loc_cDPros, 1, ;
                            NVL(cursor_4c_LocalEti.Qtds, 0), ;
                            loc_cAbrevs + " : " + ALLTRIM(STR(NVL(cursor_4c_LocalEti.NumeOs, 0), 6)), ;
                            ALLTRIM(NVL(cursor_4c_LocalEti.Obs, "")))

                IF INLIST(par_nTipoEtq, 14, 39, 109, 113)
                    IF USED("cursor_4c_LocalOpi")
                        TABLEREVERT(.T., "cursor_4c_LocalOpi")
                        USE IN cursor_4c_LocalOpi
                    ENDIF
                    loc_cSQL = "SELECT Emps, Dopes, Numes, EmpDs FROM SigOpPic WHERE Nops = " + FormatarNumeroSQL(loc_nNops)
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpi")

                    IF NOT EOF("cursor_4c_LocalOpi")
                        SELECT cursor_4c_LocalOpi

                        LOCAL loc_cEdnL
                        loc_cEdnL = ALLTRIM(cursor_4c_LocalEti.Empos) + ;
                                    ALLTRIM(cursor_4c_LocalEti.DopeOs) + ;
                                    STR(NVL(cursor_4c_LocalEti.NumeOs, 0), 6)

                        IF USED("cursor_4c_LocalEest")
                            TABLEREVERT(.T., "cursor_4c_LocalEest")
                            USE IN cursor_4c_LocalEest
                        ENDIF
                        loc_cSQL = "SELECT ContaOs, ContaDs FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(loc_cEdnL)
                        SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEest")

                        LOCAL loc_lGlobaliza, loc_cContaL
                        IF NOT EOF("cursor_4c_LocalOpeO")
                            SELECT cursor_4c_LocalOpeO
                            IF VARTYPE(globalizas) = "L"
                                loc_lGlobaliza = globalizas
                            ELSE
                                IF VARTYPE(globalizas) = "L"
                                    loc_lGlobaliza = globalizas
                                ELSE
                                    IF VARTYPE(globalizas) = "L"
                                        loc_lGlobaliza = globalizas
                                    ELSE
                                        IF VARTYPE(globalizas) = "L"
                                            loc_lGlobaliza = globalizas
                                        ELSE
                                            IF VARTYPE(globalizas) = "L"
                                                loc_lGlobaliza = globalizas
                                            ELSE
                                                loc_lGlobaliza = (NVL(globalizas, 0) = 1)
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ELSE
                            loc_lGlobaliza = .F.
                        ENDIF

                        IF NOT EOF("cursor_4c_LocalEest")
                            SELECT cursor_4c_LocalEest
                            loc_cContaL = IIF(loc_lGlobaliza, ;
                                              ALLTRIM(NVL(ContaOs, "")), ;
                                              ALLTRIM(NVL(ContaDs, "")))
                        ELSE
                            loc_cContaL = ""
                        ENDIF

                        IF INLIST(par_nTipoEtq, 109, 113)
                            IF USED("cursor_4c_LocalCli")
                                TABLEREVERT(.T., "cursor_4c_LocalCli")
                                USE IN cursor_4c_LocalCli
                            ENDIF
                            loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cContaL)
                            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalCli")
                            IF NOT EOF("cursor_4c_LocalCli")
                                SELECT cursor_4c_LocalCli
                                loc_cContaL = ALLTRIM(NVL(Rclis, ""))
                            ENDIF
                        ENDIF

                        SELECT cursor_4c_LocalEti
                        IF par_nTipoEtq <> 14
                            REPLACE Pedido WITH loc_cContaL + ;
                                IIF(INLIST(par_nTipoEtq, 39), "/" + ALLTRIM(STR(NVL(cursor_4c_LocalEti.NumeOs, 0), 6)), "") ;
                                IN dbImpressao
                        ELSE
                            REPLACE Contas WITH loc_cContaL IN dbImpressao
                        ENDIF

                        RELEASE loc_cEdnL, loc_lGlobaliza, loc_cContaL
                    ENDIF
                ENDIF

                RELEASE loc_cCPros, loc_cDPros, loc_nCBars, loc_nNops, loc_cAbrevs
                SELECT cursor_4c_LocalEti
            ENDSCAN

            IF THIS.this_nChkUnis = 1 AND THIS.this_nEtiqs = 1
                IF USED("cursor_4c_LocalEtiPos")
                    TABLEREVERT(.T., "cursor_4c_LocalEtiPos")
                    USE IN cursor_4c_LocalEtiPos
                ENDIF
                loc_cSQL = "SELECT Cpros,Cbars,Qtds,ObsEtiqs,Emps,Numes,Dopes FROM SigEtPos" + ;
                           " WHERE EmpDopNums = " + EscaparSQL(par_cChaveNs)
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEtiPos")

                IF loc_nRet > 0
                    SELECT cursor_4c_LocalEtiPos
                    SCAN
                        INSERT INTO dbImpressao (CPros, Qtds) ;
                            VALUES (cursor_4c_LocalEtiPos.CPros, cursor_4c_LocalEtiPos.Qtds)
                    ENDSCAN
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE

