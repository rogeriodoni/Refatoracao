# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRUPOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, EMPS, NOPERS, CONTAS, NMARCA1S, DATAS, EMICHQS, 0, NEMITIDOS, NCANCELAS, NCHQFS, LNCONTA1, BANCOS, AGENCIAS, NUMEROS, CIDCHAVES, NCHEQUES, ICLIS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, EMPS, NOPERS, CONTAS, NMARCA1S, DATAS, EMICHQS, 0, NEMITIDOS, NCANCELAS, NCHQFS, LNCONTA1, BANCOS, AGENCIAS, NUMEROS, CIDCHAVES, NCHEQUES, ICLIS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCRS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, EMPS, NOPERS, CONTAS, NMARCA1S, DATAS, EMICHQS, 0, NEMITIDOS, NCANCELAS, NCHQFS, LNCONTA1, BANCOS, AGENCIAS, NUMEROS, CIDCHAVES, NCHEQUES, ICLIS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '1' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, EMPS, NOPERS, CONTAS, NMARCA1S, DATAS, EMICHQS, 0, NEMITIDOS, NCANCELAS, NCHQFS, LNCONTA1, BANCOS, AGENCIAS, NUMEROS, CIDCHAVES, NCHEQUES, ICLIS

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
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  Column7.ControlSource = ""
  Column8.ControlSource = ""
  Column9.ControlSource = ""
  Column10.ControlSource = ""
  SelectOnEntry = .T.
lStrQuery = [Select emps,dopes,numes,empos,grupos,contas,tipos,nopers,opers,acertos,cotacaos,valos,moedas,hists,vencs,datas ]+;
			[From SigCdPit ]+;
lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpPrIt')
Select TmpPrIt
	If Seek(m.contas,'CrContas','iclis')
			lStrQuery = [Select emps,nopers,grupos,contas,valors,valpags From SigMvCcr ]+;
			lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpMccr')
			Select TmpMccr
				Select TmpMccr
			lStrQuery = [Select emps,nopers,moefpgs,fpags,vpags From SigMvPar ]+;
			lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpPar')
			Select TmpPar
	Insert Into TmpConta From MemVar
	UpDate CsSigCqChi Set nMarca1s = 0 Where nMarca1s = 1
	Select CsSigCqChi
	Select CsSigCqChi
	lcQuery = [Select a.emps, a.dopes, a.numes, a.datas, a.bancos, a.agencias, a.ncontas, a.ncheques, a.contas, ] + ;
				[From SigCqChi a ] + ;
				 	 [a.Contas in (Select Distinct ContaDs From SigOpFp Where EmiChqs = 1) ] + ;
	lcQuery = [Select emps, dopes, numes, datas, bancos, agencias, ncontas, ncheques, contas, ] + ;
				[From SigCqChi ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpChi') < 1)
Select Emps, Dopes, Numes, Datas, Bancos, Agencias, NContas, NCheques, Contas, Valors, Favos, NCopias, ;
  From TmpChi ;
Select CsSigCqChi
	If Not Seek(lcBusca)
		.clnImprime.ControlSource   = 'CsSigCqChi.nMarca1s'
		.clnDatas.ControlSource     = 'CsSigCqChi.datas'
		.clnContas.ControlSource    = 'CsSigCqChi.contas'
		.clnNCopias.ControlSource   = 'CsSigCqChi.ncopias'
		.clnBancos.ControlSource    = 'CsSigCqChi.bancos'
		.clnAgencias.ControlSource  = 'CsSigCqChi.agencias'
		.clnNContas.ControlSource   = 'CsSigCqChi.ncontas'
		.clnNCheques.ControlSource  = 'CsSigCqChi.ncheques'
		.clnValors.ControlSource    = 'CsSigCqChi.valors'
		.clnSituacaos.ControlSource = [IIf(CsSigCqChi.ncancelas = 1,'Cancelado',IIf(CsSigCqChi.nemissoes > 1,'Reemitido',;
	.cntjustificativa.get_justificativa.ControlSource='CsSigCqChi.JustCanc'
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select * From SigCdmp ],'CrSigCdmp')
Select CrSigCdmp
lStrQuery = [Select Distinct b.IClis,b.RClis ]+;
			  [From SigOpFp a, SigCdCli b ]+;
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CrContas') < 1
lcQuery = [Select a.emps, a.dopes, a.numes, a.datas, a.bancos, a.agencias, a.ncontas, a.ncheques, a.contas, ] + ;
			[From SigCqChi a where 0=1 ]
If ThisForm.poDataMgr.SqlExecute(lcQuery,'CsSigCqChi') < 1
SELECT csSigCqChi
Select CrContas
	UpDate CsSigCqChi Set nMarca1s = Iif(nMarca1s = 1,0,1) ;
If Seek(1,'CsSigCqChi','nMarca1s')
	Select Distinct Impres as cNomeImp1s, Space(100) as cNomeImp2s, 0 as nMarca1s ;
	  From crSigCdmp ;
	Select CrImp1
				Select CrImp1
	Select Distinct cNomeImp1s, cNomeImp2s ;
	  From crImp1 ;
	Select CrImp2
	Select CrImp2
			=Seek(lcNomeImp1,'CrSigCdmp','impres')
			Select * From CsSigCqChi Where nMarca1s = 1 Into Cursor TmpChImp
			Select TmpChImp
				lStrQuery = [Select valos,vencs From SigMvPar ]+;
				lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpPar')
				Select TmpPar
					Select CsSigCqChi
					lStrQuery = [Update SigCqChi Set emitidos = 1 Where cidchaves = ']+CsSigCqChi.cidchaves+[' ]
					lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery)
				loBarra1.Update(.T.)
Select CsSigCqChi
Select Distinct Bancos ;
  From csSigCqChi ;
Select TmpChi
	Select bancos,valors,ncheques,datas,nemitidos,ncancelas,favos From CsSigCqChi ;
	Select CrCheque
		Select CrCheque
			lStrQuery = [Update SigCqChi Set emitidos = 1 ]+;
			lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery)
			Update CsSigCqChi Set nemitidos = 1 Where bancos = CrCheque.bancos And ncheques = CrCheque.ncheques
			Select CrCheque
	Select CsSigCqChi
		lStrQuery = [Delete From SigCqChi Where cidchaves = ']+CsSigCqChi.cidchaves+[' ]
		lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery,'')
		Select CsSigCqChi
		Delete
UpDate CsSigCqChi Set nMarca1s = 0 Where nMarca1s = 1
UpDate CsSigCqChi Set nMarca1s = 1 Where nMarca1s = 0 And nEmitidos = 0 And nCancelas = 0
Select bancos,valors,ncheques,datas,favos,nemitidos From CsSigCqChi ;
Select CrCheque
	Select CrCheque
		lStrQuery = [Update SigCqChi Set emitidos = 1 ]+;
		lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery)
		Select CrCheque
Select CsSigCqChi

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrChr.prg) - TRECHOS RELEVANTES PARA PASS SQL (3805 linhas total):

*-- Linhas 227 a 256:
227:     *==========================================================================
228:     * CriarCursorCheques - Cursor de trabalho da grade de cheques
229:     * (cursor_4c_Cheques = CsSigCqChi do legado). Estrutura EXATA da que sera
230:     * populada por SQLEXEC nas fases seguintes (filtros de Grupo/Conta/
231:     * Periodo, ver mExibeCheques/MontaChq do legado) - criado aqui vazio para
232:     * o Grid poder ligar Column.ControlSource ja nesta fase, sem estourar
233:     * "Alias nao encontrado" (regra: Column.ControlSource antes do cursor
234:     * existir derruba o Init).
235:     *==========================================================================
236:     PROTECTED PROCEDURE CriarCursorCheques()
237:         IF USED("cursor_4c_Cheques")
238:             USE IN cursor_4c_Cheques
239:         ENDIF
240: 
241:         CREATE CURSOR cursor_4c_Cheques ;
242:             (emps C(3), dopes C(20), numes N(6,0), datas T NULL, bancos C(3), ;
243:              agencias C(4), ncontas C(10), ncheques C(6), contas C(10), ;
244:              valors N(11,2), favos C(40), ncopias N(6,0), nemissoes N(2,0), ;
245:              cidchaves C(20), nemitidos N(1,0), ncancelas N(1,0), ;
246:              nmarca1s N(1,0), justcanc M)
247: 
248:         *-- Indices criados JUNTO com o cursor (vazio), nao apenas apos a
249:         *-- primeira carga: ExibirCheques faz "SET ORDER TO NCopias/Contas" e,
250:         *-- com o cursor existindo SEM TAG nenhuma, isso estoura "Table has no
251:         *-- index order set." - acontece quando o usuario abre a tela e usa
252:         *-- Procurar/Chq. Matric. ANTES de Processar (no legado o cursor nem
253:         *-- existia nesse momento e o guard IF USED() pulava tudo). INDEX ON
254:         *-- cursor vazio eh valido, e o ZAP da recarga PRESERVA as tags, entao
255:         *-- a chamada seguinte em MontaGrade vira no-op (guard TAGCOUNT = 0).
256:         THIS.CriarIndicesCheques()

*-- Linhas 277 a 295:
277:             RETURN
278:         ENDIF
279: 
280:         SELECT (loc_cCursor)
281: 
282:         IF TAGCOUNT() = 0
283:             INDEX ON ncopias                TAG NCopias
284:             INDEX ON nemitidos              TAG NEmitidos
285:             INDEX ON ncancelas              TAG NCancelas
286:             INDEX ON nmarca1s               TAG NMarca1s
287:             INDEX ON ncheques               TAG NCheques
288:             INDEX ON datas                  TAG Datas
289:             INDEX ON ncontas + ncheques     TAG Conta
290:             INDEX ON contas + STR(ncopias)  TAG Contas
291:             INDEX ON DTOS(datas) + bancos + agencias + ncontas + ncheques        TAG Emissao
292:             INDEX ON STR(valors, 12, 2) + bancos + agencias + ncontas + ncheques TAG Valor
293:             INDEX ON bancos + agencias + ncontas + ncheques                      TAG Cheque
294:             INDEX ON agencias + ncontas + ncheques                               TAG Agencia
295:         ENDIF

*-- Linhas 303 a 325:
303:     *
304:     * Diferenca DELIBERADA em relacao ao legado: o legado faz
305:     * "GrdCCheques.RecordSource = '' + Use In CsSigCqChi" e recria o cursor com
306:     * SELECT ... INTO CURSOR ... ReadWrite, religando em seguida TODOS os
307:     * ControlSource. Aqui o cursor eh PRESERVADO e recarregado com ZAP +
308:     * APPEND FROM DBF(): reatribuir RecordSource resetaria Column.Width,
309:     * Header1.Caption, Sparse e CurrentControl (o CheckBox da coluna Imprime
310:     * deixaria de aparecer). O cursor criado por CREATE CURSOR ja eh
311:     * READWRITE, que eh o que a coluna editavel do CheckBox exige.
312:     *
313:     * ZAP exige SAFETY OFF: config.prg NAO desliga SAFETY (so SET EXACT ON) e
314:     * com SAFETY ON o ZAP abre dialogo modal de confirmacao que CONGELA a tela.
315:     *==========================================================================
316:     PROCEDURE MontaGrade(par_lPosiciona)
317:         LOCAL loc_lPosiciona, loc_lSucesso, loc_cCursor, loc_cTmp, loc_cBusca
318:         LOCAL loc_cSafety, loc_oErro
319:         loc_lSucesso   = .F.
320:         loc_lPosiciona = IIF(VARTYPE(par_lPosiciona) = "L", par_lPosiciona, .F.)
321:         loc_cBusca     = ""
322: 
323:         TRY
324:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
325:             loc_cTmp    = "cursor_4c_ChequesTmp"

*-- Linhas 333 a 400:
333:             *-- silencio (CLAUDE.md regra #42). Medido: SEEK com a chave crua
334:             *-- de 23 chars casa na tag Cheque.
335:             IF loc_lPosiciona AND USED(loc_cCursor) AND !EOF(loc_cCursor)
336:                 SELECT (loc_cCursor)
337:                 loc_cBusca = bancos + agencias + ncontas + ncheques
338:             ENDIF
339: 
340:             WAIT WINDOW "Aguarde! Selecionando Cheques..." NOWAIT
341: 
342:             IF !USED(loc_cCursor)
343:                 THIS.CriarCursorCheques()
344:             ENDIF
345: 
346:             IF THIS.this_oBusinessObject.CarregarCheques(loc_cTmp)
347:                 loc_cSafety = SET("Safety")
348:                 SET SAFETY OFF
349: 
350:                 SELECT (loc_cCursor)
351:                 ZAP
352:                 APPEND FROM DBF(loc_cTmp)
353: 
354:                 IF loc_cSafety == "ON"
355:                     SET SAFETY ON
356:                 ENDIF
357: 
358:                 IF USED(loc_cTmp)
359:                     USE IN (loc_cTmp)
360:                 ENDIF
361: 
362:                 THIS.CriarIndicesCheques()
363: 
364:                 *-- Legado: Set Order To NCopias + (llPosiciona -> Seek(lcBusca)
365:                 *-- senao Go Top). O SEEK roda na ordem CORRENTE (NCopias, que eh
366:                 *-- numerica) contra uma chave CHARACTER: medido no VFP9, isso
367:                 *-- NAO dispara erro - apenas nao encontra e cai no Go Top.
368:                 *-- Transcrito como esta para nao alterar o comportamento visivel.
369:                 SELECT (loc_cCursor)
370:                 SET ORDER TO NCopias
371: 
372:                 IF loc_lPosiciona
373:                     IF !SEEK(loc_cBusca)
374:                         GO TOP
375:                     ENDIF
376:                 ELSE
377:                     GO TOP
378:                 ENDIF
379: 
380:                 *-- Legado: .cntjustificativa.get_justificativa.ControlSource =
381:                 *-- 'CsSigCqChi.JustCanc' (o container de justificativa entra em
382:                 *-- fase posterior - religar so quando ele existir).
383:                 IF PEMSTATUS(THIS, "cnt_4c_justificativa", 5)
384:                     IF PEMSTATUS(THIS.cnt_4c_justificativa, "obj_4c_Get_justificativa", 5)
385:                         THIS.cnt_4c_justificativa.obj_4c_Get_justificativa.ControlSource = ;
386:                             loc_cCursor + ".justcanc"
387:                     ENDIF
388:                 ENDIF
389: 
390:                 THIS.grd_4c_Dados.Refresh()
391: 
392:                 loc_lSucesso = .T.
393:             ELSE
394:                 *-- Legado: MessageBox('Favor Reinicializar o Processo!!!', 16,
395:                 *-- 'Falha na Conexao (TmpChi - 1|2)'). A mensagem eh exibida
396:                 *-- APENAS aqui: o chamador (Processar) nao repete, para nao
397:                 *-- empilhar dois dialogos sobre a mesma falha.
398:                 MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
399:                     THIS.this_oBusinessObject.this_cMensagemErro, ;
400:                     "Falha na Conex" + CHR(227) + "o (Cheques)")

*-- Linhas 439 a 462:
439:             IF USED(loc_cCursor)
440:                 THIS.LockScreen = .T.
441: 
442:                 *-- Legado: UpDate CsSigCqChi Set nMarca1s = 0 Where nMarca1s = 1
443:                 UPDATE (loc_cCursor) SET nmarca1s = 0 WHERE nmarca1s = 1
444: 
445:                 loc_cConta = ALLTRIM(THIS.ObterFiltroConta())
446: 
447:                 SELECT (loc_cCursor)
448: 
449:                 IF EMPTY(loc_cConta)
450:                     SET ORDER TO NCopias
451:                     IF loc_lSeek
452:                         SEEK CHR(255) IN (loc_cCursor) ORDER NCopias ASCENDING
453:                     ENDIF
454:                 ELSE
455:                     *-- Legado: Set Order To contas + Set Key To <conta>. O
456:                     *-- SET KEY eh OMITIDO de proposito: a consulta do BO ja
457:                     *-- restringe o resultado a essa unica conta (WHERE
458:                     *-- a.contas = <conta>), entao ele nao filtra nada a mais -
459:                     *-- e a tag Contas eh COMPOSTA (contas + Str(ncopias)),
460:                     *-- de modo que um SET KEY com a chave parcial sob o
461:                     *-- SET EXACT ON global (config.prg) poderia nao casar e
462:                     *-- deixar a grade vazia sem erro nenhum.

*-- Linhas 544 a 714:
544:     * ColumnOrder replica o SCX: clnImprime (Column10) desenha PRIMEIRO
545:     * (ColumnOrder=1) e clnDatas (Column1) desenha POR ULTIMO (ColumnOrder=10)
546:     * - os demais seguem a ordem de criacao (2..9). clnSituacaos (Column8) eh
547:     * CALCULADA (nao existe coluna no cursor) - ControlSource eh a mesma
548:     * expressao IIF aninhada do legado.
549:     *==========================================================================
550:     PROTECTED PROCEDURE ConfigurarGrid()
551:         LOCAL loc_oGrid, loc_oErro
552: 
553:         TRY
554:             THIS.CriarCursorCheques()
555: 
556:             THIS.AddObject("grd_4c_Dados", "Grid")
557:             loc_oGrid = THIS.grd_4c_Dados
558: 
559:             WITH loc_oGrid
560:                 .Top               = 233
561:                 .Left              = 24
562:                 .Width             = 710
563:                 .Height            = 291
564:                 .FontName          = "Tahoma"
565:                 .FontSize          = 8
566:                 .AllowHeaderSizing = .F.
567:                 .AllowRowSizing    = .F.
568:                 .DeleteMark        = .F.
569:                 .RecordMark        = .F.
570:                 .ScrollBars        = 2
571:                 .GridLineColor     = RGB(238, 238, 238)
572:                 .ReadOnly          = .F.
573:                 .ColumnCount       = 10
574:                 .RecordSource      = "cursor_4c_Cheques"
575:                 .Visible           = .T.
576:             ENDWITH
577: 
578:             *-- Column1: clnDatas (desenha por ultimo - ColumnOrder=10)
579:             WITH loc_oGrid.Column1
580:                 .FontName          = "Tahoma"
581:                 .Width             = 79
582:                 .Movable           = .F.
583:                 .Resizable         = .F.
584:                 .ReadOnly          = .T.
585:                 .ColumnOrder       = 10
586:                 .ControlSource     = "cursor_4c_Cheques.datas"
587:                 .Header1.Caption   = "Data"
588:                 .Header1.Alignment = 2
589:                 .Header1.ForeColor = RGB(90, 90, 90)
590:             ENDWITH
591: 
592:             *-- Column2: clnContas
593:             WITH loc_oGrid.Column2
594:                 .FontName          = "Tahoma"
595:                 .Width             = 79
596:                 .Movable           = .F.
597:                 .Resizable         = .F.
598:                 .ReadOnly          = .T.
599:                 .ControlSource     = "cursor_4c_Cheques.contas"
600:                 .Header1.Caption   = "Conta"
601:                 .Header1.Alignment = 2
602:                 .Header1.ForeColor = RGB(90, 90, 90)
603:             ENDWITH
604: 
605:             *-- Column3: clnNcopias
606:             WITH loc_oGrid.Column3
607:                 .FontName          = "Tahoma"
608:                 .Width             = 51
609:                 .Movable           = .F.
610:                 .Resizable         = .F.
611:                 .ReadOnly          = .T.
612:                 .InputMask         = "999999"
613:                 .ControlSource     = "cursor_4c_Cheques.ncopias"
614:                 .Header1.Caption   = "C" + CHR(243) + "pia"
615:                 .Header1.Alignment = 2
616:                 .Header1.ForeColor = RGB(90, 90, 90)
617:             ENDWITH
618: 
619:             *-- Legado: clnNcopias.Header1.Click - reordena para NCopias ao
620:             *-- clicar no cabecalho, so quando nao ha filtro de Conta e a
621:             *-- ordem corrente ainda nao eh NCopias.
622:             BINDEVENT(loc_oGrid.Column3.Header1, "Click", THIS, "Column3Header1Click")
623: 
624:             *-- Column4: clnBancos
625:             WITH loc_oGrid.Column4
626:                 .FontName          = "Tahoma"
627:                 .Width             = 30
628:                 .Movable           = .F.
629:                 .Resizable         = .F.
630:                 .ReadOnly          = .T.
631:                 .ControlSource     = "cursor_4c_Cheques.bancos"
632:                 .Header1.Caption   = "Bco"
633:                 .Header1.Alignment = 2
634:                 .Header1.ForeColor = RGB(90, 90, 90)
635:             ENDWITH
636: 
637:             *-- Column5: clnAgencias
638:             WITH loc_oGrid.Column5
639:                 .FontName          = "Tahoma"
640:                 .Width             = 37
641:                 .Movable           = .F.
642:                 .Resizable         = .F.
643:                 .ReadOnly          = .T.
644:                 .ControlSource     = "cursor_4c_Cheques.agencias"
645:                 .Header1.Caption   = "Ag."
646:                 .Header1.Alignment = 2
647:                 .Header1.ForeColor = RGB(90, 90, 90)
648:             ENDWITH
649: 
650:             *-- Column6: clnNcontas
651:             WITH loc_oGrid.Column6
652:                 .FontName          = "Tahoma"
653:                 .Width             = 79
654:                 .Movable           = .F.
655:                 .Resizable         = .F.
656:                 .ReadOnly          = .T.
657:                 .ControlSource     = "cursor_4c_Cheques.ncontas"
658:                 .Header1.Caption   = "C.Corrente"
659:                 .Header1.Alignment = 2
660:                 .Header1.ForeColor = RGB(90, 90, 90)
661:             ENDWITH
662: 
663:             *-- Column7: clnNcheques
664:             WITH loc_oGrid.Column7
665:                 .FontName          = "Tahoma"
666:                 .Width             = 51
667:                 .Movable           = .F.
668:                 .Resizable         = .F.
669:                 .ReadOnly          = .T.
670:                 .ControlSource     = "cursor_4c_Cheques.ncheques"
671:                 .Header1.Caption   = "Cheque"
672:                 .Header1.Alignment = 2
673:                 .Header1.ForeColor = RGB(90, 90, 90)
674:             ENDWITH
675: 
676:             *-- Column8: clnSituacaos (CALCULADA - identica ao legado)
677:             WITH loc_oGrid.Column8
678:                 .FontName          = "Tahoma"
679:                 .Width             = 79
680:                 .Movable           = .F.
681:                 .Resizable         = .F.
682:                 .ReadOnly          = .T.
683:                 .ControlSource     = "IIF(cursor_4c_Cheques.ncancelas = 1, 'Cancelado', " + ;
684:                                       "IIF(cursor_4c_Cheques.nemissoes > 1, 'Reemitido', " + ;
685:                                       "IIF(cursor_4c_Cheques.nemitidos = 1, 'Emitido', 'N" + CHR(227) + "o Emitido')))"
686:                 .Header1.Caption   = "Situa" + CHR(231) + CHR(227) + "o"
687:                 .Header1.Alignment = 2
688:                 .Header1.ForeColor = RGB(90, 90, 90)
689:             ENDWITH
690: 
691:             *-- Column9: clnValors
692:             WITH loc_oGrid.Column9
693:                 .FontName          = "Tahoma"
694:                 .Width             = 110
695:                 .Movable           = .F.
696:                 .Resizable         = .F.
697:                 .ReadOnly          = .T.
698:                 .InputMask         = "999,999,999.99"
699:                 .ControlSource     = "cursor_4c_Cheques.valors"
700:                 .Header1.Caption   = "Valor"
701:                 .Header1.Alignment = 2
702:                 .Header1.ForeColor = RGB(90, 90, 90)
703:             ENDWITH
704: 
705:             *-- Column10: clnImprime (checkbox - desenha PRIMEIRO, ColumnOrder=1)
706:             WITH loc_oGrid.Column10
707:                 .FontName    = "Tahoma"
708:                 .Width       = 55
709:                 .Movable     = .F.
710:                 .Resizable   = .F.
711:                 .ColumnOrder = 1
712:             ENDWITH
713: 
714:             loc_oGrid.Column10.AddObject("chk_4c_Check1", "CheckBox")

*-- Linhas 723 a 741:
723:                 .CurrentControl    = "chk_4c_Check1"
724:                 .Sparse            = .F.
725:                 .ReadOnly          = .F.
726:                 .ControlSource     = "cursor_4c_Cheques.nmarca1s"
727:                 .Header1.Caption   = "Imprime"
728:                 .Header1.Alignment = 2
729:                 .Header1.ForeColor = RGB(90, 90, 90)
730:             ENDWITH
731: 
732:             loc_oGrid.SetAll("DynamicForeColor", ;
733:                 "IIF(cursor_4c_Cheques.ncancelas = 1, RGB(255,0,0), " + ;
734:                 "IIF(cursor_4c_Cheques.nemitidos = 0, RGB(0,0,255), RGB(0,0,0)))", "Column")
735: 
736:             BINDEVENT(loc_oGrid.Column10.chk_4c_Check1, "KeyPress",  THIS, "ChkImprimeKeyPress")
737:             BINDEVENT(loc_oGrid.Column10.chk_4c_Check1, "MouseUp",   THIS, "ChkImprimeMouseUp")
738:             BINDEVENT(loc_oGrid.Column10.chk_4c_Check1, "MouseDown", THIS, "ChkImprimeMouseDown")
739:             BINDEVENT(loc_oGrid.Column10.chk_4c_Check1, "Click",     THIS, "ChkImprimeClick")
740: 
741:             *-- Legado: Scrolled/DoScroll/BeforeRowColChange/AfterRowColChange

*-- Linhas 758 a 796:
758:     * "Imprime" (Column10.chk_4c_Check1 = clnImprime.Check1 do legado).
759:     * MouseDown/Click apenas suprimem o toggle nativo do CheckBox (NODEFAULT);
760:     * MouseUp e KeyPress(Enter/Espaco) fazem a alternancia de verdade via
761:     * UPDATE no cursor, replicando 1:1 o KeyPress original do legado.
762:     * PUBLIC (sem PROTECTED) - BINDEVENT so dispara metodos PUBLIC.
763:     *==========================================================================
764:     PROCEDURE ChkImprimeKeyPress(par_nKeyCode, par_nShiftAltCtrl)
765:         LOCAL loc_cCursor, loc_nRecno, loc_cChave
766: 
767:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
768: 
769:         IF INLIST(par_nKeyCode, 13, 32) AND USED(loc_cCursor)
770:             loc_nRecno = RECNO(loc_cCursor)
771:             SELECT (loc_cCursor)
772:             loc_cChave = bancos + agencias + ncontas + ncheques
773: 
774:             UPDATE (loc_cCursor) SET nmarca1s = IIF(nmarca1s = 1, 0, 1) ;
775:                 WHERE bancos + agencias + ncontas + ncheques = loc_cChave ;
776:                   AND nemitidos = 0 AND ncancelas = 0
777: 
778:             THIS.grd_4c_Dados.Refresh()
779: 
780:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
781:                 SELECT (loc_cCursor)
782:                 GOTO loc_nRecno
783:             ENDIF
784: 
785:             NODEFAULT
786:         ENDIF
787:     ENDPROC
788: 
789:     PROCEDURE ChkImprimeMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
790:         THIS.ChkImprimeKeyPress(32, 0)
791:         NODEFAULT
792:     ENDPROC
793: 
794:     PROCEDURE ChkImprimeMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
795:         NODEFAULT
796:     ENDPROC

*-- Linhas 2017 a 2035:
2017:             loc_cSafety = SET("Safety")
2018:             SET SAFETY OFF
2019: 
2020:             SELECT (loc_cCursor)
2021:             ZAP
2022: 
2023:             IF loc_cSafety == "ON"
2024:                 SET SAFETY ON
2025:             ENDIF
2026: 
2027:             THIS.grd_4c_Dados.Refresh()
2028:         ENDIF
2029:     ENDPROC
2030: 
2031:     *==========================================================================
2032:     * ValidarCdGruposKeyPress / ValidarDsGruposKeyPress - Equivalente ao Valid
2033:     * de GetCdGrupos/GetDsGrupos do legado (fAcessoContab): F4 abre o picker
2034:     * (AbrirBuscaGrupo), Enter/Tab tenta o match EXATO contra SigCdGcr
2035:     * (Codigos/Descrs) e, sem match, abre o picker com o prefixo digitado. O

*-- Linhas 2059 a 2078:
2059:                 USE IN cursor_4c_BuscaGrupo
2060:             ENDIF
2061: 
2062:             loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cValor)
2063:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")
2064: 
2065:             IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
2066:                 THIS.txt_4c_CdGrupos.Value = ALLTRIM(cursor_4c_BuscaGrupo.codigos)
2067:                 THIS.txt_4c_DsGrupos.Value = ALLTRIM(cursor_4c_BuscaGrupo.descrs)
2068: 
2069:                 IF USED("cursor_4c_BuscaGrupo")
2070:                     USE IN cursor_4c_BuscaGrupo
2071:                 ENDIF
2072:             ELSE
2073:                 IF USED("cursor_4c_BuscaGrupo")
2074:                     USE IN cursor_4c_BuscaGrupo
2075:                 ENDIF
2076:                 THIS.AbrirBuscaGrupo()
2077:                 RETURN
2078:             ENDIF

*-- Linhas 2112 a 2131:
2112:                 USE IN cursor_4c_BuscaGrupo
2113:             ENDIF
2114: 
2115:             loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE descrs = " + EscaparSQL(loc_cValor)
2116:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")
2117: 
2118:             IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
2119:                 THIS.txt_4c_CdGrupos.Value = ALLTRIM(cursor_4c_BuscaGrupo.codigos)
2120:                 THIS.txt_4c_DsGrupos.Value = ALLTRIM(cursor_4c_BuscaGrupo.descrs)
2121: 
2122:                 IF USED("cursor_4c_BuscaGrupo")
2123:                     USE IN cursor_4c_BuscaGrupo
2124:                 ENDIF
2125:             ELSE
2126:                 IF USED("cursor_4c_BuscaGrupo")
2127:                     USE IN cursor_4c_BuscaGrupo
2128:                 ENDIF
2129:                 THIS.AbrirBuscaGrupo()
2130:                 RETURN
2131:             ENDIF

*-- Linhas 2157 a 2182:
2157:         ENDIF
2158: 
2159:         IF !EMPTY(loc_cFiltro)
2160:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr WHERE " + ;
2161:                 "codigos LIKE " + EscaparSQL(loc_cFiltro + "%") + ;
2162:                 " OR descrs LIKE " + EscaparSQL(loc_cFiltro + "%") + " ORDER BY codigos"
2163:         ELSE
2164:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
2165:         ENDIF
2166: 
2167:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")
2168: 
2169:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
2170:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2171:             loc_oBusca.DefinirCursor("cursor_4c_BuscaGrupo", "codigos", "descrs", ;
2172:                 "Grupo de Contas")
2173: 
2174:             IF loc_oBusca.Mostrar()
2175:                 THIS.txt_4c_CdGrupos.Value = loc_oBusca.cCodigoSelecionado
2176:                 THIS.txt_4c_DsGrupos.Value = loc_oBusca.cDescricaoSelecionada
2177:                 THIS.LimparChequesSeFiltroMudou()
2178:             ENDIF
2179: 
2180:             loc_oBusca.Release()
2181:         ENDIF
2182: 

*-- Linhas 2218 a 2241:
2218:                 USE IN cursor_4c_BuscaConta
2219:             ENDIF
2220: 
2221:             loc_cSQL = "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cValor)
2222:             IF !EMPTY(loc_cGrupo)
2223:                 loc_cSQL = loc_cSQL + " AND grupos = " + EscaparSQL(loc_cGrupo)
2224:             ENDIF
2225: 
2226:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
2227: 
2228:             IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaConta") > 0
2229:                 THIS.txt_4c_CdContas.Value = ALLTRIM(cursor_4c_BuscaConta.iclis)
2230:                 THIS.txt_4c_DsContas.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)
2231: 
2232:                 IF USED("cursor_4c_BuscaConta")
2233:                     USE IN cursor_4c_BuscaConta
2234:                 ENDIF
2235:             ELSE
2236:                 IF USED("cursor_4c_BuscaConta")
2237:                     USE IN cursor_4c_BuscaConta
2238:                 ENDIF
2239:                 THIS.AbrirBuscaConta()
2240:                 RETURN
2241:             ENDIF

*-- Linhas 2276 a 2299:
2276:                 USE IN cursor_4c_BuscaConta
2277:             ENDIF
2278: 
2279:             loc_cSQL = "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE RTRIM(rclis) = " + EscaparSQL(loc_cValor)
2280:             IF !EMPTY(loc_cGrupo)
2281:                 loc_cSQL = loc_cSQL + " AND grupos = " + EscaparSQL(loc_cGrupo)
2282:             ENDIF
2283: 
2284:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
2285: 
2286:             IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaConta") > 0
2287:                 THIS.txt_4c_CdContas.Value = ALLTRIM(cursor_4c_BuscaConta.iclis)
2288:                 THIS.txt_4c_DsContas.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)
2289: 
2290:                 IF USED("cursor_4c_BuscaConta")
2291:                     USE IN cursor_4c_BuscaConta
2292:                 ENDIF
2293:             ELSE
2294:                 IF USED("cursor_4c_BuscaConta")
2295:                     USE IN cursor_4c_BuscaConta
2296:                 ENDIF
2297:                 THIS.AbrirBuscaConta()
2298:                 RETURN
2299:             ENDIF

*-- Linhas 2325 a 2356:
2325:             USE IN cursor_4c_BuscaConta
2326:         ENDIF
2327: 
2328:         loc_cSQL = "SELECT iclis, rclis FROM SigCdCli WHERE 1 = 1 "
2329: 
2330:         IF !EMPTY(loc_cGrupo)
2331:             loc_cSQL = loc_cSQL + "AND grupos = " + EscaparSQL(loc_cGrupo) + " "
2332:         ENDIF
2333: 
2334:         IF !EMPTY(loc_cFiltro)
2335:             loc_cSQL = loc_cSQL + "AND (iclis LIKE " + EscaparSQL(loc_cFiltro + "%") + ;
2336:                 " OR RTRIM(rclis) LIKE " + EscaparSQL(loc_cFiltro + "%") + ") "
2337:         ENDIF
2338: 
2339:         loc_cSQL = loc_cSQL + "ORDER BY iclis"
2340: 
2341:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
2342: 
2343:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaConta") > 0
2344:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2345:             loc_oBusca.DefinirCursor("cursor_4c_BuscaConta", "iclis", "rclis", "Contas")
2346: 
2347:             IF loc_oBusca.Mostrar()
2348:                 THIS.txt_4c_CdContas.Value = loc_oBusca.cCodigoSelecionado
2349:                 THIS.txt_4c_DsContas.Value = loc_oBusca.cDescricaoSelecionada
2350:                 THIS.LimparChequesSeFiltroMudou()
2351:             ENDIF
2352: 
2353:             loc_oBusca.Release()
2354:         ENDIF
2355: 
2356:         IF USED("cursor_4c_BuscaConta")

*-- Linhas 2554 a 2592:
2554:     * ncancelas convertidos via CASE WHEN, sem grupos/vencs/versos/
2555:     * empdopnums/impversos). Passar o cursor da grade direto estouraria
2556:     * "Variable 'CANCELAS' is not found." Por isso o cheque corrente eh
2557:     * relido com SELECT * FROM SigCqChi (mesmas colunas que CarregarDoCursor
2558:     * espera), pela PK cidchaves.
2559:     *==========================================================================
2560:     PROCEDURE BtnExcluirChqClick()
2561:         LOCAL loc_cCursor, loc_cCidchaves, loc_cSQL, loc_nResultado, loc_cMensagem
2562: 
2563:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2564: 
2565:         IF !USED(loc_cCursor) OR EOF(loc_cCursor)
2566:             MsgAviso("Nenhum cheque selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
2567:             RETURN
2568:         ENDIF
2569: 
2570:         loc_cCidchaves = EVALUATE(loc_cCursor + ".cidchaves")
2571: 
2572:         IF USED("cursor_4c_ChequeAtual")
2573:             USE IN cursor_4c_ChequeAtual
2574:         ENDIF
2575: 
2576:         loc_cSQL = "SELECT * FROM SigCqChi WHERE cidchaves = " + EscaparSQL(loc_cCidchaves)
2577:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChequeAtual")
2578: 
2579:         IF loc_nResultado <= 0 OR RECCOUNT("cursor_4c_ChequeAtual") = 0
2580:             MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel localizar o cheque para exclus" + CHR(227) + "o." + CHR(13) + CapturarErroSQL(), "Erro SQL")
2581:             IF USED("cursor_4c_ChequeAtual")
2582:                 USE IN cursor_4c_ChequeAtual
2583:             ENDIF
2584:             RETURN
2585:         ENDIF
2586: 
2587:         THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_ChequeAtual")
2588: 
2589:         IF USED("cursor_4c_ChequeAtual")
2590:             USE IN cursor_4c_ChequeAtual
2591:         ENDIF
2592: 

*-- Linhas 2598 a 2655:
2598: 
2599:         IF MsgConfirma(loc_cMensagem, "Exclus" + CHR(227) + "o de cheque cancelado")
2600:             IF THIS.this_oBusinessObject.Excluir()
2601:                 SELECT (loc_cCursor)
2602:                 DELETE
2603:                 THIS.grd_4c_Dados.Refresh()
2604:             ENDIF
2605:         ENDIF
2606:     ENDPROC
2607: 
2608:     *==========================================================================
2609:     * BtnMarcarTudoClick / BtnDesmarcarTudoClick - cmdTudo1.Click /
2610:     * cmdApaga1.Click do legado (marca/desmarca em massa a coluna Imprime).
2611:     *==========================================================================
2612:     PROCEDURE BtnMarcarTudoClick()
2613:         LOCAL loc_cCursor, loc_nRecno
2614: 
2615:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2616: 
2617:         IF USED(loc_cCursor)
2618:             loc_nRecno = RECNO(loc_cCursor)
2619:             UPDATE (loc_cCursor) SET nmarca1s = 1 WHERE nmarca1s = 0 AND nemitidos = 0 AND ncancelas = 0
2620: 
2621:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
2622:                 SELECT (loc_cCursor)
2623:                 GOTO loc_nRecno
2624:             ENDIF
2625: 
2626:             THIS.grd_4c_Dados.Refresh()
2627:         ENDIF
2628:     ENDPROC
2629: 
2630:     PROCEDURE BtnDesmarcarTudoClick()
2631:         LOCAL loc_cCursor, loc_nRecno
2632: 
2633:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2634: 
2635:         IF USED(loc_cCursor)
2636:             loc_nRecno = RECNO(loc_cCursor)
2637:             UPDATE (loc_cCursor) SET nmarca1s = 0 WHERE nmarca1s = 1
2638: 
2639:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
2640:                 SELECT (loc_cCursor)
2641:                 GOTO loc_nRecno
2642:             ENDIF
2643: 
2644:             THIS.grd_4c_Dados.Refresh()
2645:         ENDIF
2646:     ENDPROC
2647: 
2648:     *==========================================================================
2649:     * BtnImprimirClick - Imprimir (cmdImprimir.Click do legado): abre
2650:     * FormSigReEch (Emissao de Cheque, ja migrado) no modo CONSULTAR para o
2651:     * cheque selecionado na grade - mesmos parametros do "Do Form SigReEch
2652:     * With emps,dopes,numes,'CONSULTAR',ncheques" original.
2653:     *==========================================================================
2654:     PROCEDURE BtnImprimirClick()
2655:         LOCAL loc_cCursor, loc_oForm, loc_oErro

*-- Linhas 2662 a 2680:
2662:         ENDIF
2663: 
2664:         loc_oForm = .NULL.
2665:         SELECT (loc_cCursor)
2666: 
2667:         TRY
2668:             loc_oForm = CREATEOBJECT("FormSigReEch", emps, dopes, numes, "CONSULTAR", ncheques)
2669:         CATCH TO loc_oErro
2670:             MsgErro(loc_oErro.Message, "Erro ao abrir emiss" + CHR(227) + "o de cheque")
2671:             loc_oForm = .NULL.
2672:         ENDTRY
2673: 
2674:         IF VARTYPE(loc_oForm) = "O"
2675:             loc_oForm.Show()
2676:         ENDIF
2677:     ENDPROC
2678: 
2679:     *==========================================================================
2680:     * BtnDocumentoClick - Documento (cmdDocumento.Click do legado): confere

*-- Linhas 2694 a 2716:
2694:             RETURN
2695:         ENDIF
2696: 
2697:         SELECT (loc_cCursor)
2698:         loc_cEmpDopNums = PADR(emps, 3) + PADR(dopes, 20) + STR(numes, 6)
2699: 
2700:         loc_cSQL = "SELECT TOP 1 empdopnums FROM SigCdPgr WHERE empdopnums = " + EscaparSQL(loc_cEmpDopNums)
2701:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerificaPgr")
2702: 
2703:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_VerificaPgr") > 0
2704:             loc_oForm = .NULL.
2705:             TRY
2706:                 loc_oForm = CREATEOBJECT("Formpgr")
2707:             CATCH TO loc_oErro
2708:                 MsgErro(loc_oErro.Message, "Erro ao abrir Lan" + CHR(231) + "amentos e Pagamentos")
2709:                 loc_oForm = .NULL.
2710:             ENDTRY
2711: 
2712:             IF VARTYPE(loc_oForm) = "O"
2713:                 loc_oForm.Show()
2714:             ENDIF
2715:         ENDIF
2716: 

*-- Linhas 2807 a 2825:
2807:             .Visible     = .T.
2808:         ENDWITH
2809: 
2810:         SELECT (loc_cCursor)
2811:         SET NEAR ON
2812: 
2813:         DO CASE
2814:             CASE !EMPTY(loc_dEmissao)
2815:                 SET ORDER TO Emissao
2816:                 SEEK DTOS(loc_dEmissao) + loc_cBanco + loc_cAgencia + loc_cConta + loc_cCheque
2817:             CASE loc_nValor != 0
2818:                 SET ORDER TO Valor
2819:                 SEEK STR(loc_nValor, 12, 2) + loc_cBanco + loc_cAgencia + loc_cConta + loc_cCheque
2820:             CASE !EMPTY(loc_cBanco)
2821:                 SET ORDER TO Cheque
2822:                 SEEK loc_cBanco + loc_cAgencia + loc_cConta + loc_cCheque
2823:             CASE !EMPTY(loc_cAgencia)
2824:                 SET ORDER TO Agencia
2825:                 SEEK loc_cAgencia + loc_cConta + loc_cCheque

*-- Linhas 2999 a 3021:
2999:             RETURN
3000:         ENDIF
3001: 
3002:         SELECT (loc_cCursor)
3003:         loc_cEmpDopNums = PADR(emps, 3) + PADR(dopes, 20) + STR(numes, 6)
3004: 
3005:         loc_cSQL = "SELECT TOP 1 empdopnums FROM SigCdPgr WHERE empdopnums = " + EscaparSQL(loc_cEmpDopNums)
3006:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerificaPgr")
3007: 
3008:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_VerificaPgr") > 0
3009:             loc_oForm = .NULL.
3010:             TRY
3011:                 loc_oForm = CREATEOBJECT("Formpgr")
3012:             CATCH TO loc_oErro
3013:                 MsgErro(loc_oErro.Message, "Erro ao abrir Lan" + CHR(231) + "amentos e Pagamentos")
3014:                 loc_oForm = .NULL.
3015:             ENDTRY
3016: 
3017:             IF VARTYPE(loc_oForm) = "O"
3018:                 loc_oForm.Show()
3019:             ENDIF
3020:         ENDIF
3021: 

*-- Linhas 3074 a 3092:
3074:             RETURN
3075:         ENDIF
3076: 
3077:         SELECT (loc_cCursor)
3078:         COUNT TO loc_nQtdMarcados FOR nmarca1s = 1
3079: 
3080:         IF loc_nQtdMarcados = 0
3081:             MsgAviso("Nenhum Cheque Selecionado !!!", "Aten" + CHR(231) + CHR(227) + "o")
3082:             RETURN
3083:         ENDIF
3084: 
3085:         IF MsgConfirma("Confirma que " + ALLTRIM(STR(loc_nQtdMarcados)) + " cheque(s) selecionado(s) " + ;
3086:                 "j" + CHR(225) + " foram impressos na impressora de cheques?", "Impress" + CHR(227) + "o de Cheque")
3087:             IF THIS.this_oBusinessObject.MarcarChequesComoEmitidos(loc_cCursor)
3088:                 THIS.grd_4c_Dados.Refresh()
3089:             ENDIF
3090:         ENDIF
3091:     ENDPROC
3092: 

*-- Linhas 3106 a 3138:
3106:             RETURN
3107:         ENDIF
3108: 
3109:         SELECT (loc_cCursor)
3110:         COUNT TO loc_nQtdMarcados FOR nmarca1s = 1
3111: 
3112:         *-- Legado: sem cheque marcado (TmpChi vazio), o botao abre o painel
3113:         *-- de impressao manual (banco + faixa de cheques digitados), em vez
3114:         *-- de operar sobre a selecao da grade.
3115:         IF loc_nQtdMarcados = 0
3116:             THIS.AbrirImpressaoManualCheque()
3117:             RETURN
3118:         ENDIF
3119: 
3120:         loc_lMesmoBanco    = .T.
3121:         loc_cPrimeiroBanco = ""
3122: 
3123:         SELECT (loc_cCursor)
3124:         SCAN FOR nmarca1s = 1
3125:             IF EMPTY(loc_cPrimeiroBanco)
3126:                 loc_cPrimeiroBanco = bancos
3127:             ELSE
3128:                 IF bancos != loc_cPrimeiroBanco
3129:                     loc_lMesmoBanco = .F.
3130:                     EXIT
3131:                 ENDIF
3132:             ENDIF
3133:         ENDSCAN
3134: 
3135:         IF !loc_lMesmoBanco
3136:             MsgAviso("Todos os cheques selecionados devem ser do mesmo banco", "Aten" + CHR(231) + CHR(227) + "o")
3137:             RETURN
3138:         ENDIF

*-- Linhas 3218 a 3236:
3218:     *==========================================================================
3219:     * ImprimirChequeManualClick - cmdimpri.Click do impchmat.cmdGprocurar
3220:     * legado: valida Banco/faixa, filtra o cursor JA CARREGADO da grade
3221:     * (mesma fonte que o legado usa - "Select ... From CsSigCqChi Where
3222:     * bancos = ... And ncheques Between ... And ncancelas = 0", NAO uma nova
3223:     * consulta ao SQL Server) e, confirmando, marca como emitidos.
3224:     *
3225:     * A rotina de posicionamento fisico na folha do cheque (SigIpChq.prg,
3226:     * ~180 linhas com fValorExtenso/fwBuscaInt, nenhuma delas portada) fica
3227:     * para uma fase dedicada de impressao de cheques - mesma ressalva ja
3228:     * documentada em BtnImpChqClick/BtnChMatClick.
3229:     *==========================================================================
3230:     PROCEDURE ImprimirChequeManualClick()
3231:         LOCAL loc_cCursor, loc_cBanco, loc_cChIni, loc_cChFin, loc_nQtd, loc_lTemEmitido
3232: 
3233:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
3234: 
3235:         WITH THIS.cnt_4c_Impchmat
3236:             loc_cBanco = .txt_4c_Banco.Value

*-- Linhas 3267 a 3292:
3267:             RETURN
3268:         ENDIF
3269: 
3270:         SELECT (loc_cCursor)
3271:         COUNT TO loc_nQtd FOR bancos = loc_cBanco AND BETWEEN(ncheques, loc_cChIni, loc_cChFin) AND ncancelas = 0
3272: 
3273:         IF loc_nQtd = 0
3274:             RETURN
3275:         ENDIF
3276: 
3277:         SELECT (loc_cCursor)
3278:         LOCATE FOR bancos = loc_cBanco AND BETWEEN(ncheques, loc_cChIni, loc_cChFin) AND ncancelas = 0 AND nemitidos = 1
3279:         loc_lTemEmitido = FOUND()
3280: 
3281:         IF loc_lTemEmitido
3282:             IF !MsgConfirma("Os cheques selecionados j" + CHR(225) + " foram emitidos. Confirma impress" + CHR(227) + "o ?", "Aten" + CHR(231) + CHR(227) + "o")
3283:                 RETURN
3284:             ENDIF
3285:         ENDIF
3286: 
3287:         MsgAviso("Verifique se a impressora est" + CHR(225) + " pronta p/ impress" + CHR(227) + "o", "Aten" + CHR(231) + CHR(227) + "o")
3288: 
3289:         IF THIS.this_oBusinessObject.MarcarChequesComoEmitidosPorFaixa(loc_cCursor, loc_cBanco, loc_cChIni, loc_cChFin)
3290:             THIS.grd_4c_Dados.Refresh()
3291:             THIS.FecharImpressaoManualCheque()
3292:         ENDIF


### BO (C:\4c\projeto\app\classes\SigPrChrBO.prg):
*============================================================================
* SigPrChrBO.prg - Business Object para Consulta/Cancelamento de Cheques
*
* Origem legado: SIGPRCHR.SCX
* Form OPERACIONAL (nao segue padrao CRUD Page1=Lista/Page2=Dados): tela de
* consulta de cheques emitidos por conta/periodo, com filtro por Grupo e
* Conta, impressao de cheque/documento/recibo, cancelamento de documento e
* exclusao fisica de cheque cancelado (Delete From SigCqChi Where cidchaves
* = ...). Tabela principal manipulada: SigCqChi (comportamento.json).
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigPrChrBO AS BusinessBase

    *==========================================================================
    * Filtro de periodo - espelha Dt_Inicial/Dt_Final do legado. AntData* eh
    * o valor anterior do filtro (AntDtIni/AntDtFin), usado para saber se a
    * lista de cheques precisa ser recarregada quando o campo muda de valor.
    *==========================================================================
    this_dDataInicial    = {}    && Data inicial do periodo de busca (Dt_Inicial)
    this_dDataFinal      = {}    && Data final do periodo de busca (Dt_Final)
    this_dAntDataInicial = {}    && Valor anterior de this_dDataInicial (AntDtIni)
    this_dAntDataFinal   = {}    && Valor anterior de this_dDataFinal (AntDtFin)

    *==========================================================================
    * Filtro de Grupo de Contas - espelha GetCdGrupos/GetDsGrupos. Ant* guarda
    * o valor anterior para decidir se o cursor de cheques precisa ser
    * recarregado (Zap In CsSigCqChi quando o valor muda).
    *==========================================================================
    this_cCodGrupo     = ""      && Codigo do grupo de contas (GetCdGrupos)
    this_cDescGrupo    = ""      && Descricao do grupo de contas (GetDsGrupos)
    this_cAntCodGrupo  = ""      && Valor anterior de this_cCodGrupo (AntCdGrupo)
    this_cAntDescGrupo = ""      && Valor anterior de this_cDescGrupo (AntDsGrupo)

    *==========================================================================
    * Filtro de Conta - espelha getCdContas/getDsContas. Ant* guarda o valor
    * anterior para a mesma finalidade do bloco de Grupo.
    *==========================================================================
    this_cCodConta     = ""      && Codigo da conta (getCdContas)
    this_cDescConta    = ""      && Descricao/razao social da conta (getDsContas)
    this_cAntCodConta  = ""      && Valor anterior de this_cCodConta (AntCdConta)
    this_cAntDescConta = ""      && Valor anterior de this_cDescConta (AntDsConta)

    *==========================================================================
    * Favorecido do cheque selecionado na grade (TxtFavorecido, somente
    * leitura - espelha CsSigCqChi.favos do registro corrente).
    *==========================================================================
    this_cFavorecido = ""

    *==========================================================================
    * Flags de acesso do usuario logado (fChecaAcesso('SIGPRCHR', <operacao>)
    * no Init legado) - controlam Enabled dos botoes Excluir Documento e
    * Excluir Cheque.
    *==========================================================================
    this_lExcluirDocumento = .F.  && Acesso para excluir documento (ExcluirDocumento)
    this_lExcluirCheque    = .F.  && Acesso para excluir cheque cancelado (ExcluirCheque)

    *==========================================================================
    * Controle de fluxo da primeira exibicao da lista de cheques - MontaChq
    * recebe par_lPosiciona e, quando .F. (Inicial = .T. no legado), vai
    * direto para o Top do cursor em vez de reposicionar no ultimo cheque
    * selecionado.
    *==========================================================================
    this_lPrimeiraExibicao = .T.  && Inicial

    *==========================================================================
    * Leitor de codigo de barras do cheque (getBanco.KeyPress no legado):
    * this_lLeitorChequeAtivo indica se o usuario esta no meio de uma leitura
    * (tecla 60 inicia, tecla 58 finaliza) e this_cChequeLido acumula os
    * caracteres lidos (pcChqLido).
    *==========================================================================
    this_lLeitorChequeAtivo = .F. && plLeCheque
    this_cChequeLido        = ""  && pcChqLido

    *==========================================================================
    * Nomes dos cursores de trabalho, compartilhados entre os metodos do BO
    * e o Form (grids ligados via RecordSource/ControlSource).
    *==========================================================================
    this_cCursorCheques     = "cursor_4c_Cheques"      && CsSigCqChi (cheques do periodo/conta filtrados)
    this_cCursorContas      = "cursor_4c_Contas"        && CrContas (contas com emissao de cheque habilitada)
    this_cCursorImpressoras = "cursor_4c_Impressoras"   && CrSigCdmp (impressoras cadastradas)

    *==========================================================================
    * Cheque corrente - espelha 1:1 as colunas de SigCqChi (docs/schema.sql)
    * do registro selecionado na grade. Populado por CarregarDoCursor() e
    * usado por ObterChavePrimaria()/ExecutarExclusao() no cancelamento
    * fisico do cheque (Delete From SigCqChi Where cidchaves = ... do
    * cmdGok.Click legado).
    *==========================================================================
    this_cCidchaves   = ""      && PK Fortyus (cidchaves)
    this_cAgencias    = ""      && agencias char(4)
    this_cBancos      = ""      && bancos char(3)
    this_lCancelas    = .F.     && cancelas bit -> cheque CANCELADO (ncancelas no legado)
    this_cContas      = ""      && contas char(10)
    this_dDatas       = {}      && datas datetime NULL - emissao do cheque
    this_cDopes       = ""      && dopes char(20) - documento de origem
    this_lEmitidos    = .F.     && emitidos bit (nemitidos no legado)
    this_cEmps        = ""      && emps char(3)
    this_cGrupos      = ""      && grupos char(10) - grupo de contas do cheque
    this_cNcheques    = ""      && ncheques char(6) - numero do cheque
    this_cNcontas     = ""      && ncontas char(10) - conta corrente
    this_nNcopias     = 0       && ncopias numeric(6,0)
    this_nNemissoes   = 0       && nemissoes numeric(2,0)
    this_nNumes       = 0       && numes numeric(6,0) - numero do documento (Dopes/Numes)
    this_nValors      = 0       && valors numeric(11,2)
    this_dVencs       = {}      && vencs datetime NULL - vencimento
    this_cVersos      = ""      && versos text - texto do verso do cheque
    this_cEmpDopNums  = ""      && empdopnums char(29) - chave posicional Emps+Dopes+Str(Numes,6)
    this_cJustCanc    = ""      && justcanc text - justificativa do cancelamento (get_justificativa)
    this_nImpVersos   = 0       && impversos numeric(1,0)

    *==========================================================================
    * Init - Business Object sem tabela unica de persistencia CRUD; a tabela
    * fisica manipulada (Delete no cancelamento de cheque) eh SigCqChi, e a
    * chave primaria eh cidchaves (cidchaves char - PK Fortyus, ver INSERT
    * do legado / regra #22 do CLAUDE.md).
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT("SigCqChi")
            THIS.this_cCampoChave = "cidchaves"

            THIS.this_dDataInicial = DATE()
            THIS.this_dDataFinal   = DATE()
            THIS.this_dAntDataInicial = {}
            THIS.this_dAntDataFinal   = {}
            THIS.this_cAntCodGrupo    = ""
            THIS.this_cAntDescGrupo   = ""
            THIS.this_cAntCodConta    = ""
            THIS.this_cAntDescConta   = ""

            THIS.this_lExcluirDocumento = fChecaAcesso("SIGPRCHR", "EXCLUIR")
            THIS.this_lExcluirCheque    = fChecaAcesso("SIGPRCHR", "EXCLUIRCHQ")
            THIS.this_lPrimeiraExibicao = .T.

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas de SigCqChi (par_cAliasCursor
    * eh um cursor de UM cheque, populado por SQLEXEC com os nomes reais do
    * banco - docs/schema.sql) para as properties this_* do cheque corrente.
    * Usado pelo Form ao selecionar uma linha da grade, antes de acionar
    * Excluir() (cancelamento fisico do cheque ja cancelado).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cCidchaves  = TratarNulo(cidchaves, "")
            THIS.this_cAgencias   = TratarNulo(agencias, "")
            THIS.this_cBancos     = TratarNulo(bancos, "")
            THIS.this_lCancelas   = ConverterParaLogico(cancelas)
            THIS.this_cContas     = TratarNulo(contas, "")
            THIS.this_dDatas      = ConverterParaData(datas)
            THIS.this_cDopes      = TratarNulo(dopes, "")
            THIS.this_lEmitidos   = ConverterParaLogico(emitidos)
            THIS.this_cEmps       = TratarNulo(emps, "")
            THIS.this_cFavorecido = TratarNulo(favos, "")
            THIS.this_cGrupos     = TratarNulo(grupos, "")
            THIS.this_cNcheques   = TratarNulo(ncheques, "")
            THIS.this_cNcontas    = TratarNulo(ncontas, "")
            THIS.this_nNcopias    = NVL(ncopias, 0)
            THIS.this_nNemissoes  = NVL(nemissoes, 0)
            THIS.this_nNumes      = NVL(numes, 0)
            THIS.this_nValors     = NVL(valors, 0)
            THIS.this_dVencs      = ConverterParaData(vencs)
            THIS.this_cVersos     = TratarNulo(versos, "")
            THIS.this_cEmpDopNums = TratarNulo(empdopnums, "")
            THIS.this_cJustCanc   = TratarNulo(justcanc, "")
            THIS.this_nImpVersos  = NVL(impversos, 0)

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarCheques - Consulta os cheques do periodo/grupo/conta filtrados e
    * devolve o resultado em par_cCursorDestino (cursor TEMPORARIO - quem
    * transfere para o cursor da grade eh o Form, via ZAP + APPEND FROM DBF,
    * para nao destruir o binding do Grid).
    *
    * Transcricao 1:1 do SELECT do "PROCEDURE montachq" legado (duas variantes
    * conforme a Conta estar preenchida ou nao):
    *
    *   Sem conta : ...Where a.datas Between ?lcDtInicial And ?lcDtFinal And
    *                    [a.Grupos = '<grupo>' And]
    *                    a.Contas in (Select Distinct ContaDs From SigOpFp
    *                                  Where EmiChqs = 1)
    *   Com conta : ...Where datas Between ... And [Grupos = ... And]
    *                    Contas = '<conta>'
    *
    * O filtro de Grupo eh OPCIONAL no legado (Iif(Empty(lcCdGrupo), [], ...)) -
    * a ausencia dele NAO eh esquecimento de migracao.
    *
    * Os "Iif(Emitidos,1,0) as NEmitidos" / "Iif(Cancelas,1,0) as NCancelas"
    * que o legado faz no SELECT VFP sao resolvidos aqui no SQL Server (CASE
    * WHEN), porque emitidos/cancelas sao colunas "bit" (docs/schema.sql) e
    * chegam ao VFP ora como Logico ora como Numerico conforme o driver
    * (CLAUDE.md regra #13) - converter no servidor elimina a ambiguidade e
    * entrega numeric(1,0), que eh o tipo das colunas nemitidos/ncancelas do
    * cursor da grade.
    *
    * A ordenacao final eh a do SELECT VFP do legado (Order By Bancos,
    * Agencias, NContas, NCheques), que sobrepoe o Order By da query remota.
    *==========================================================================
    PROCEDURE CarregarCheques(par_cCursorDestino)
        LOCAL loc_lSucesso, loc_cCursor, loc_cSQL, loc_nResultado
        LOCAL loc_dIni, loc_dFim, loc_tIni, loc_tFim, loc_cGrupo, loc_cConta
        LOCAL loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cCursor = IIF(VARTYPE(par_cCursorDestino) = "C" AND ;
                !EMPTY(par_cCursorDestino), par_cCursorDestino, "cursor_4c_ChequesTmp")

            *-- ConverterParaData: o filtro pode chegar como DATE (TextBox com
            *-- .Value = {}) ou como DATETIME (coluna do banco) - CLAUDE.md #16.
            loc_dIni = ConverterParaData(THIS.this_dDataInicial)
            loc_dFim = ConverterParaData(THIS.this_dDataFinal)

            IF EMPTY(loc_dIni) OR EMPTY(loc_dFim)
                THIS.this_cMensagemErro = "Per" + CHR(237) + "odo n" + CHR(227) + ;
                    "o informado para a consulta de cheques."
            ELSE
                *-- fDtoSQL(Dt_Inicial.Value) / fDtoSQL(Dt_Final.Value,'23:59:59')
                loc_tIni = DTOT(loc_dIni)
                loc_tFim = DATETIME(YEAR(loc_dFim), MONTH(loc_dFim), DAY(loc_dFim), 23, 59, 59)

                loc_cGrupo = ALLTRIM(THIS.this_cCodGrupo)
                loc_cConta = ALLTRIM(THIS.this_cCodConta)

                loc_cSQL = "SELECT a.emps, a.dopes, a.numes, a.datas, a.bancos, " + ;
                           "a.agencias, a.ncontas, a.ncheques, a.contas, a.valors, " + ;
                           "a.favos, a.ncopias, a.nemissoes, a.cidchaves, a.justcanc, " + ;
                           "CASE WHEN a.emitidos = 1 THEN 1 ELSE 0 END AS nemitidos, " + ;
                           "CASE WHEN a.cancelas = 1 THEN 1 ELSE 0 END AS ncancelas, " + ;
                           "0 AS nmarca1s " + ;
                           "FROM SigCqChi a " + ;
                           "WHERE a.datas BETWEEN " + FormatarDataSQL(loc_tIni) + ;
                               " AND " + FormatarDataSQL(loc_tFim) + " "

                IF !EMPTY(loc_cGrupo)
                    loc_cSQL = loc_cSQL + "AND a.grupos = " + EscaparSQL(loc_cGrupo) + " "
                ENDIF

                IF EMPTY(loc_cConta)
                    loc_cSQL = loc_cSQL + ;
                        "AND a.contas IN (SELECT DISTINCT ContaDs FROM SigOpFp " + ;
                        "WHERE EmiChqs = 1) "
                ELSE
                    loc_cSQL = loc_cSQL + "AND a.contas = " + EscaparSQL(loc_cConta) + " "
                ENDIF

                loc_cSQL = loc_cSQL + ;
                    "ORDER BY a.bancos, a.agencias, a.ncontas, a.ncheques"

                IF USED(loc_cCursor)
                    USE IN (loc_cCursor)
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

                *-- Legado: If (SqlExecute(...) < 1) -> falha de conexao
                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Falha ao selecionar os cheques do " + ;
                        "per" + CHR(237) + "odo." + CHR(13) + CapturarErroSQL()
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - PK Fortyus de SigCqChi eh cidchaves (char, ver
    * regra #22 do CLAUDE.md). Usado por RegistrarAuditoria() (BusinessBase)
    * no INSERT INTO LogAuditoria apos ExecutarExclusao().
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidchaves
    ENDPROC

    *==========================================================================
    * Inserir()/Atualizar() - o legado (SIGPRCHR.SCX) NAO grava nem altera
    * registros em SigCqChi: os cheques sao emitidos por outro modulo do
    * sistema (emissao de cheques). Esta tela apenas consulta cheques por
    * Grupo/Conta/Periodo (comportamento.json: Select .../CsSigCqChi, sem
    * nenhum Insert/Update em SigCqChi) e cancela fisicamente um documento
    * ja cancelado (Delete From SigCqChi Where cidchaves = ... no
    * cmdGok.Click legado, replicado em ExecutarExclusao() abaixo). O
    * comportamento padrao herdado de BusinessBase (recusar Inserir/
    * Atualizar) ja eh o correto para esta entidade neste form.
    *==========================================================================

    *==========================================================================
    * AntesDeExcluir - Replica o guard do legado antes do MessageBox de
    * confirmacao e do Delete: "If CsSigCqChi.ncancelas = 1 And
    * ThisForm.ExcluirCheque" (cmdGok.Click). So permite excluir um cheque
    * JA CANCELADO e quando o usuario tem o acesso ExcluirCheque
    * (fChecaAcesso('SIGPRCHR','EXCLUIRCHQ') calculado no Init).
    *==========================================================================
    PROTECTED PROCEDURE AntesDeExcluir()
        IF !THIS.this_lCancelas
            THIS.this_cMensagemErro = "Somente cheques CANCELADOS podem ser exclu" + CHR(237) + "dos."
            RETURN .F.
        ENDIF

        IF !THIS.this_lExcluirCheque
            THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio n" + CHR(227) + "o possui acesso para excluir cheque cancelado."
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Delete From SigCqChi Where cidchaves = ... do
    * cmdGok.Click legado (exclusao fisica do cheque cancelado). Conexao
    * nasce em modo transacional manual (Transactions=2) - commit/rollback
    * explicitos.
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cCidchaves)
            THIS.this_cMensagemErro = "Cheque sem chave prim" + CHR(225) + "ria (cidchaves) para exclus" + CHR(227) + "o."
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "DELETE FROM SigCqChi WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                SQLCOMMIT(gnConnHandle)
                THIS.RegistrarAuditoria("EXCLUSAO")
                loc_lSucesso = .T.
            ELSE
                SQLROLLBACK(gnConnHandle)
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o cheque cancelado:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            SQLROLLBACK(gnConnHandle)
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MarcarChequesComoEmitidos - Marca como emitidos (SQL Server + cursor de
    * trabalho) todos os cheques com nmarca1s = 1 no cursor informado.
    * Replica o "Update SigCqChi Set emitidos = 1 Where cidchaves = ..." dos
    * fluxos de impressao do legado (cmdImpchq/cmdchmat), um UPDATE por
    * cheque (cada cheque tem cidchaves proprio). Conexao em modo
    * transacional manual (Transactions=2) - commit/rollback explicitos.
    *==========================================================================
    PROCEDURE MarcarChequesComoEmitidos(par_cCursor)
        LOCAL loc_lSucesso, loc_lErro, loc_cSQL, loc_nResultado, loc_nRecno, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(par_cCursor) = "C" AND USED(par_cCursor)
            loc_lErro  = .F.
            loc_nRecno = RECNO(par_cCursor)

            TRY
                SELECT (par_cCursor)
                SCAN FOR nmarca1s = 1
                    loc_cSQL = "UPDATE SigCqChi SET emitidos = 1 WHERE cidchaves = " + EscaparSQL(cidchaves)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        loc_lErro = .T.
                        EXIT
                    ENDIF

                    REPLACE nemitidos WITH 1, nmarca1s WITH 0
                    SELECT (par_cCursor)
                ENDSCAN

                IF loc_lErro
                    SQLROLLBACK(gnConnHandle)
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel marcar o(s) cheque(s) como emitido(s):" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    SQLCOMMIT(gnConnHandle)
                    loc_lSucesso = .T.
                ENDIF
            CATCH TO loc_oErro
                SQLROLLBACK(gnConnHandle)
                MsgErro(loc_oErro.Message, "Erro")
            ENDTRY

            IF USED(par_cCursor) AND BETWEEN(loc_nRecno, 1, RECCOUNT(par_cCursor))
                SELECT (par_cCursor)
                GOTO loc_nRecno
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MarcarChequesComoEmitidosPorFaixa - Variante de MarcarChequesComoEmitidos
    * para o painel de impressao manual (cnt_4c_Impchmat/impchmat do legado):
    * marca como emitidos TODOS os cheques do cursor de trabalho que casam
    * com Banco + faixa de numero de cheque (nao pelo cidchaves de cada
    * linha marcada). Replica "Update SigCqChi Set emitidos = 1 Where bancos
    * = ... And ncheques = ..." do cmdimpri.Click legado, um UPDATE por
    * cheque da faixa. Conexao em modo transacional manual - commit/rollback
    * explicitos.
    *==========================================================================
    PROCEDURE MarcarChequesComoEmitidosPorFaixa(par_cCursor, par_cBanco, par_cChequeIni, par_cChequeFin)
        LOCAL loc_lSucesso, loc_lErro, loc_cSQL, loc_nResultado, loc_nRecno, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(par_cCursor) = "C" AND USED(par_cCursor)
            loc_lErro  = .F.
            loc_nRecno = RECNO(par_cCursor)

            TRY
                SELECT (par_cCursor)
                SCAN FOR bancos = par_cBanco AND BETWEEN(ncheques, par_cChequeIni, par_cChequeFin) AND ncancelas = 0
                    loc_cSQL = "UPDATE SigCqChi SET emitidos = 1 WHERE bancos = " + EscaparSQL(bancos) + ;
                        " AND ncheques = " + EscaparSQL(ncheques)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        loc_lErro = .T.
                        EXIT
                    ENDIF

                    REPLACE nemitidos WITH 1
                    SELECT (par_cCursor)
                ENDSCAN

                IF loc_lErro
                    SQLROLLBACK(gnConnHandle)
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel marcar o(s) cheque(s) como emitido(s):" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    SQLCOMMIT(gnConnHandle)
                    loc_lSucesso = .T.
                ENDIF
            CATCH TO loc_oErro
                SQLROLLBACK(gnConnHandle)
                MsgErro(loc_oErro.Message, "Erro")
            ENDTRY

            IF USED(par_cCursor) AND BETWEEN(loc_nRecno, 1, RECCOUNT(par_cCursor))
                SELECT (par_cCursor)
                GOTO loc_nRecno
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparDados - Reseta o cheque corrente (chamado por BusinessBase.Excluir
    * apos ExecutarExclusao() ter sucesso, e por NovoRegistro/CancelarEdicao).
    *==========================================================================
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCidchaves  = ""
        THIS.this_cAgencias   = ""
        THIS.this_cBancos     = ""
        THIS.this_lCancelas   = .F.
        THIS.this_cContas     = ""
        THIS.this_dDatas      = {}
        THIS.this_cDopes      = ""
        THIS.this_lEmitidos   = .F.
        THIS.this_cEmps       = ""
        THIS.this_cFavorecido = ""
        THIS.this_cGrupos     = ""
        THIS.this_cNcheques   = ""
        THIS.this_cNcontas    = ""
        THIS.this_nNcopias    = 0
        THIS.this_nNemissoes  = 0
        THIS.this_nNumes      = 0
        THIS.this_nValors     = 0
        THIS.this_dVencs      = {}
        THIS.this_cVersos     = ""
        THIS.this_cEmpDopNums = ""
        THIS.this_cJustCanc   = ""
        THIS.this_nImpVersos  = 0
    ENDPROC

ENDDEFINE

