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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrChr.prg) - TRECHOS RELEVANTES PARA PASS SQL (3818 linhas total):

*-- Linhas 227 a 265:
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
237:         LOCAL loc_cNull
238: 
239:         IF USED("cursor_4c_Cheques")
240:             USE IN cursor_4c_Cheques
241:         ENDIF
242: 
243:         *-- SET NULL ON antes do CREATE CURSOR: SQL Server pode devolver NULL
244:         *-- em colunas aqui declaradas sem a clausula NULL (favos/contas/etc).
245:         *-- Sem isso, o APPEND FROM DBF() de MontaGrade estoura "Field XXX
246:         *-- does not accept null values" no primeiro registro NULL.
247:         loc_cNull = SET("Null")
248:         SET NULL ON
249: 
250:         CREATE CURSOR cursor_4c_Cheques ;
251:             (emps C(3), dopes C(20), numes N(6,0), datas T NULL, bancos C(3), ;
252:              agencias C(4), ncontas C(10), ncheques C(6), contas C(10), ;
253:              valors N(11,2), favos C(40), ncopias N(6,0), nemissoes N(2,0), ;
254:              cidchaves C(20), nemitidos N(1,0), ncancelas N(1,0), ;
255:              nmarca1s N(1,0), justcanc M)
256: 
257:         IF loc_cNull == "OFF"
258:             SET NULL OFF
259:         ENDIF
260: 
261:         *-- Indices criados JUNTO com o cursor (vazio), nao apenas apos a
262:         *-- primeira carga: ExibirCheques faz "SET ORDER TO NCopias/Contas" e,
263:         *-- com o cursor existindo SEM TAG nenhuma, isso estoura "Table has no
264:         *-- index order set." - acontece quando o usuario abre a tela e usa
265:         *-- Procurar/Chq. Matric. ANTES de Processar (no legado o cursor nem

*-- Linhas 290 a 308:
290:             RETURN
291:         ENDIF
292: 
293:         SELECT (loc_cCursor)
294: 
295:         IF TAGCOUNT() = 0
296:             INDEX ON ncopias                TAG NCopias
297:             INDEX ON nemitidos              TAG NEmitidos
298:             INDEX ON ncancelas              TAG NCancelas
299:             INDEX ON nmarca1s               TAG NMarca1s
300:             INDEX ON ncheques               TAG NCheques
301:             INDEX ON datas                  TAG Datas
302:             INDEX ON ncontas + ncheques     TAG Conta
303:             INDEX ON contas + STR(ncopias)  TAG Contas
304:             INDEX ON DTOS(datas) + bancos + agencias + ncontas + ncheques        TAG Emissao
305:             INDEX ON STR(valors, 12, 2) + bancos + agencias + ncontas + ncheques TAG Valor
306:             INDEX ON bancos + agencias + ncontas + ncheques                      TAG Cheque
307:             INDEX ON agencias + ncontas + ncheques                               TAG Agencia
308:         ENDIF

*-- Linhas 316 a 338:
316:     *
317:     * Diferenca DELIBERADA em relacao ao legado: o legado faz
318:     * "GrdCCheques.RecordSource = '' + Use In CsSigCqChi" e recria o cursor com
319:     * SELECT ... INTO CURSOR ... ReadWrite, religando em seguida TODOS os
320:     * ControlSource. Aqui o cursor eh PRESERVADO e recarregado com ZAP +
321:     * APPEND FROM DBF(): reatribuir RecordSource resetaria Column.Width,
322:     * Header1.Caption, Sparse e CurrentControl (o CheckBox da coluna Imprime
323:     * deixaria de aparecer). O cursor criado por CREATE CURSOR ja eh
324:     * READWRITE, que eh o que a coluna editavel do CheckBox exige.
325:     *
326:     * ZAP exige SAFETY OFF: config.prg NAO desliga SAFETY (so SET EXACT ON) e
327:     * com SAFETY ON o ZAP abre dialogo modal de confirmacao que CONGELA a tela.
328:     *==========================================================================
329:     PROCEDURE MontaGrade(par_lPosiciona)
330:         LOCAL loc_lPosiciona, loc_lSucesso, loc_cCursor, loc_cTmp, loc_cBusca
331:         LOCAL loc_cSafety, loc_oErro
332:         loc_lSucesso   = .F.
333:         loc_lPosiciona = IIF(VARTYPE(par_lPosiciona) = "L", par_lPosiciona, .F.)
334:         loc_cBusca     = ""
335: 
336:         TRY
337:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
338:             loc_cTmp    = "cursor_4c_ChequesTmp"

*-- Linhas 346 a 413:
346:             *-- silencio (CLAUDE.md regra #42). Medido: SEEK com a chave crua
347:             *-- de 23 chars casa na tag Cheque.
348:             IF loc_lPosiciona AND USED(loc_cCursor) AND !EOF(loc_cCursor)
349:                 SELECT (loc_cCursor)
350:                 loc_cBusca = bancos + agencias + ncontas + ncheques
351:             ENDIF
352: 
353:             WAIT WINDOW "Aguarde! Selecionando Cheques..." NOWAIT
354: 
355:             IF !USED(loc_cCursor)
356:                 THIS.CriarCursorCheques()
357:             ENDIF
358: 
359:             IF THIS.this_oBusinessObject.CarregarCheques(loc_cTmp)
360:                 loc_cSafety = SET("Safety")
361:                 SET SAFETY OFF
362: 
363:                 SELECT (loc_cCursor)
364:                 ZAP
365:                 APPEND FROM DBF(loc_cTmp)
366: 
367:                 IF loc_cSafety == "ON"
368:                     SET SAFETY ON
369:                 ENDIF
370: 
371:                 IF USED(loc_cTmp)
372:                     USE IN (loc_cTmp)
373:                 ENDIF
374: 
375:                 THIS.CriarIndicesCheques()
376: 
377:                 *-- Legado: Set Order To NCopias + (llPosiciona -> Seek(lcBusca)
378:                 *-- senao Go Top). O SEEK roda na ordem CORRENTE (NCopias, que eh
379:                 *-- numerica) contra uma chave CHARACTER: medido no VFP9, isso
380:                 *-- NAO dispara erro - apenas nao encontra e cai no Go Top.
381:                 *-- Transcrito como esta para nao alterar o comportamento visivel.
382:                 SELECT (loc_cCursor)
383:                 SET ORDER TO NCopias
384: 
385:                 IF loc_lPosiciona
386:                     IF !SEEK(loc_cBusca)
387:                         GO TOP
388:                     ENDIF
389:                 ELSE
390:                     GO TOP
391:                 ENDIF
392: 
393:                 *-- Legado: .cntjustificativa.get_justificativa.ControlSource =
394:                 *-- 'CsSigCqChi.JustCanc' (o container de justificativa entra em
395:                 *-- fase posterior - religar so quando ele existir).
396:                 IF PEMSTATUS(THIS, "cnt_4c_justificativa", 5)
397:                     IF PEMSTATUS(THIS.cnt_4c_justificativa, "obj_4c_Get_justificativa", 5)
398:                         THIS.cnt_4c_justificativa.obj_4c_Get_justificativa.ControlSource = ;
399:                             loc_cCursor + ".justcanc"
400:                     ENDIF
401:                 ENDIF
402: 
403:                 THIS.grd_4c_Dados.Refresh()
404: 
405:                 loc_lSucesso = .T.
406:             ELSE
407:                 *-- Legado: MessageBox('Favor Reinicializar o Processo!!!', 16,
408:                 *-- 'Falha na Conexao (TmpChi - 1|2)'). A mensagem eh exibida
409:                 *-- APENAS aqui: o chamador (Processar) nao repete, para nao
410:                 *-- empilhar dois dialogos sobre a mesma falha.
411:                 MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
412:                     THIS.this_oBusinessObject.this_cMensagemErro, ;
413:                     "Falha na Conex" + CHR(227) + "o (Cheques)")

*-- Linhas 452 a 475:
452:             IF USED(loc_cCursor)
453:                 THIS.LockScreen = .T.
454: 
455:                 *-- Legado: UpDate CsSigCqChi Set nMarca1s = 0 Where nMarca1s = 1
456:                 UPDATE (loc_cCursor) SET nmarca1s = 0 WHERE nmarca1s = 1
457: 
458:                 loc_cConta = ALLTRIM(THIS.ObterFiltroConta())
459: 
460:                 SELECT (loc_cCursor)
461: 
462:                 IF EMPTY(loc_cConta)
463:                     SET ORDER TO NCopias
464:                     IF loc_lSeek
465:                         SEEK CHR(255) IN (loc_cCursor) ORDER NCopias ASCENDING
466:                     ENDIF
467:                 ELSE
468:                     *-- Legado: Set Order To contas + Set Key To <conta>. O
469:                     *-- SET KEY eh OMITIDO de proposito: a consulta do BO ja
470:                     *-- restringe o resultado a essa unica conta (WHERE
471:                     *-- a.contas = <conta>), entao ele nao filtra nada a mais -
472:                     *-- e a tag Contas eh COMPOSTA (contas + Str(ncopias)),
473:                     *-- de modo que um SET KEY com a chave parcial sob o
474:                     *-- SET EXACT ON global (config.prg) poderia nao casar e
475:                     *-- deixar a grade vazia sem erro nenhum.

*-- Linhas 557 a 727:
557:     * ColumnOrder replica o SCX: clnImprime (Column10) desenha PRIMEIRO
558:     * (ColumnOrder=1) e clnDatas (Column1) desenha POR ULTIMO (ColumnOrder=10)
559:     * - os demais seguem a ordem de criacao (2..9). clnSituacaos (Column8) eh
560:     * CALCULADA (nao existe coluna no cursor) - ControlSource eh a mesma
561:     * expressao IIF aninhada do legado.
562:     *==========================================================================
563:     PROTECTED PROCEDURE ConfigurarGrid()
564:         LOCAL loc_oGrid, loc_oErro
565: 
566:         TRY
567:             THIS.CriarCursorCheques()
568: 
569:             THIS.AddObject("grd_4c_Dados", "Grid")
570:             loc_oGrid = THIS.grd_4c_Dados
571: 
572:             WITH loc_oGrid
573:                 .Top               = 233
574:                 .Left              = 24
575:                 .Width             = 710
576:                 .Height            = 291
577:                 .FontName          = "Tahoma"
578:                 .FontSize          = 8
579:                 .AllowHeaderSizing = .F.
580:                 .AllowRowSizing    = .F.
581:                 .DeleteMark        = .F.
582:                 .RecordMark        = .F.
583:                 .ScrollBars        = 2
584:                 .GridLineColor     = RGB(238, 238, 238)
585:                 .ReadOnly          = .F.
586:                 .ColumnCount       = 10
587:                 .RecordSource      = "cursor_4c_Cheques"
588:                 .Visible           = .T.
589:             ENDWITH
590: 
591:             *-- Column1: clnDatas (desenha por ultimo - ColumnOrder=10)
592:             WITH loc_oGrid.Column1
593:                 .FontName          = "Tahoma"
594:                 .Width             = 79
595:                 .Movable           = .F.
596:                 .Resizable         = .F.
597:                 .ReadOnly          = .T.
598:                 .ColumnOrder       = 10
599:                 .ControlSource     = "cursor_4c_Cheques.datas"
600:                 .Header1.Caption   = "Data"
601:                 .Header1.Alignment = 2
602:                 .Header1.ForeColor = RGB(90, 90, 90)
603:             ENDWITH
604: 
605:             *-- Column2: clnContas
606:             WITH loc_oGrid.Column2
607:                 .FontName          = "Tahoma"
608:                 .Width             = 79
609:                 .Movable           = .F.
610:                 .Resizable         = .F.
611:                 .ReadOnly          = .T.
612:                 .ControlSource     = "cursor_4c_Cheques.contas"
613:                 .Header1.Caption   = "Conta"
614:                 .Header1.Alignment = 2
615:                 .Header1.ForeColor = RGB(90, 90, 90)
616:             ENDWITH
617: 
618:             *-- Column3: clnNcopias
619:             WITH loc_oGrid.Column3
620:                 .FontName          = "Tahoma"
621:                 .Width             = 51
622:                 .Movable           = .F.
623:                 .Resizable         = .F.
624:                 .ReadOnly          = .T.
625:                 .InputMask         = "999999"
626:                 .ControlSource     = "cursor_4c_Cheques.ncopias"
627:                 .Header1.Caption   = "C" + CHR(243) + "pia"
628:                 .Header1.Alignment = 2
629:                 .Header1.ForeColor = RGB(90, 90, 90)
630:             ENDWITH
631: 
632:             *-- Legado: clnNcopias.Header1.Click - reordena para NCopias ao
633:             *-- clicar no cabecalho, so quando nao ha filtro de Conta e a
634:             *-- ordem corrente ainda nao eh NCopias.
635:             BINDEVENT(loc_oGrid.Column3.Header1, "Click", THIS, "Column3Header1Click")
636: 
637:             *-- Column4: clnBancos
638:             WITH loc_oGrid.Column4
639:                 .FontName          = "Tahoma"
640:                 .Width             = 30
641:                 .Movable           = .F.
642:                 .Resizable         = .F.
643:                 .ReadOnly          = .T.
644:                 .ControlSource     = "cursor_4c_Cheques.bancos"
645:                 .Header1.Caption   = "Bco"
646:                 .Header1.Alignment = 2
647:                 .Header1.ForeColor = RGB(90, 90, 90)
648:             ENDWITH
649: 
650:             *-- Column5: clnAgencias
651:             WITH loc_oGrid.Column5
652:                 .FontName          = "Tahoma"
653:                 .Width             = 37
654:                 .Movable           = .F.
655:                 .Resizable         = .F.
656:                 .ReadOnly          = .T.
657:                 .ControlSource     = "cursor_4c_Cheques.agencias"
658:                 .Header1.Caption   = "Ag."
659:                 .Header1.Alignment = 2
660:                 .Header1.ForeColor = RGB(90, 90, 90)
661:             ENDWITH
662: 
663:             *-- Column6: clnNcontas
664:             WITH loc_oGrid.Column6
665:                 .FontName          = "Tahoma"
666:                 .Width             = 79
667:                 .Movable           = .F.
668:                 .Resizable         = .F.
669:                 .ReadOnly          = .T.
670:                 .ControlSource     = "cursor_4c_Cheques.ncontas"
671:                 .Header1.Caption   = "C.Corrente"
672:                 .Header1.Alignment = 2
673:                 .Header1.ForeColor = RGB(90, 90, 90)
674:             ENDWITH
675: 
676:             *-- Column7: clnNcheques
677:             WITH loc_oGrid.Column7
678:                 .FontName          = "Tahoma"
679:                 .Width             = 51
680:                 .Movable           = .F.
681:                 .Resizable         = .F.
682:                 .ReadOnly          = .T.
683:                 .ControlSource     = "cursor_4c_Cheques.ncheques"
684:                 .Header1.Caption   = "Cheque"
685:                 .Header1.Alignment = 2
686:                 .Header1.ForeColor = RGB(90, 90, 90)
687:             ENDWITH
688: 
689:             *-- Column8: clnSituacaos (CALCULADA - identica ao legado)
690:             WITH loc_oGrid.Column8
691:                 .FontName          = "Tahoma"
692:                 .Width             = 79
693:                 .Movable           = .F.
694:                 .Resizable         = .F.
695:                 .ReadOnly          = .T.
696:                 .ControlSource     = "IIF(cursor_4c_Cheques.ncancelas = 1, 'Cancelado', " + ;
697:                                       "IIF(cursor_4c_Cheques.nemissoes > 1, 'Reemitido', " + ;
698:                                       "IIF(cursor_4c_Cheques.nemitidos = 1, 'Emitido', 'N" + CHR(227) + "o Emitido')))"
699:                 .Header1.Caption   = "Situa" + CHR(231) + CHR(227) + "o"
700:                 .Header1.Alignment = 2
701:                 .Header1.ForeColor = RGB(90, 90, 90)
702:             ENDWITH
703: 
704:             *-- Column9: clnValors
705:             WITH loc_oGrid.Column9
706:                 .FontName          = "Tahoma"
707:                 .Width             = 110
708:                 .Movable           = .F.
709:                 .Resizable         = .F.
710:                 .ReadOnly          = .T.
711:                 .InputMask         = "999,999,999.99"
712:                 .ControlSource     = "cursor_4c_Cheques.valors"
713:                 .Header1.Caption   = "Valor"
714:                 .Header1.Alignment = 2
715:                 .Header1.ForeColor = RGB(90, 90, 90)
716:             ENDWITH
717: 
718:             *-- Column10: clnImprime (checkbox - desenha PRIMEIRO, ColumnOrder=1)
719:             WITH loc_oGrid.Column10
720:                 .FontName    = "Tahoma"
721:                 .Width       = 55
722:                 .Movable     = .F.
723:                 .Resizable   = .F.
724:                 .ColumnOrder = 1
725:             ENDWITH
726: 
727:             loc_oGrid.Column10.AddObject("chk_4c_Check1", "CheckBox")

*-- Linhas 736 a 754:
736:                 .CurrentControl    = "chk_4c_Check1"
737:                 .Sparse            = .F.
738:                 .ReadOnly          = .F.
739:                 .ControlSource     = "cursor_4c_Cheques.nmarca1s"
740:                 .Header1.Caption   = "Imprime"
741:                 .Header1.Alignment = 2
742:                 .Header1.ForeColor = RGB(90, 90, 90)
743:             ENDWITH
744: 
745:             loc_oGrid.SetAll("DynamicForeColor", ;
746:                 "IIF(cursor_4c_Cheques.ncancelas = 1, RGB(255,0,0), " + ;
747:                 "IIF(cursor_4c_Cheques.nemitidos = 0, RGB(0,0,255), RGB(0,0,0)))", "Column")
748: 
749:             BINDEVENT(loc_oGrid.Column10.chk_4c_Check1, "KeyPress",  THIS, "ChkImprimeKeyPress")
750:             BINDEVENT(loc_oGrid.Column10.chk_4c_Check1, "MouseUp",   THIS, "ChkImprimeMouseUp")
751:             BINDEVENT(loc_oGrid.Column10.chk_4c_Check1, "MouseDown", THIS, "ChkImprimeMouseDown")
752:             BINDEVENT(loc_oGrid.Column10.chk_4c_Check1, "Click",     THIS, "ChkImprimeClick")
753: 
754:             *-- Legado: Scrolled/DoScroll/BeforeRowColChange/AfterRowColChange

*-- Linhas 771 a 809:
771:     * "Imprime" (Column10.chk_4c_Check1 = clnImprime.Check1 do legado).
772:     * MouseDown/Click apenas suprimem o toggle nativo do CheckBox (NODEFAULT);
773:     * MouseUp e KeyPress(Enter/Espaco) fazem a alternancia de verdade via
774:     * UPDATE no cursor, replicando 1:1 o KeyPress original do legado.
775:     * PUBLIC (sem PROTECTED) - BINDEVENT so dispara metodos PUBLIC.
776:     *==========================================================================
777:     PROCEDURE ChkImprimeKeyPress(par_nKeyCode, par_nShiftAltCtrl)
778:         LOCAL loc_cCursor, loc_nRecno, loc_cChave
779: 
780:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
781: 
782:         IF INLIST(par_nKeyCode, 13, 32) AND USED(loc_cCursor)
783:             loc_nRecno = RECNO(loc_cCursor)
784:             SELECT (loc_cCursor)
785:             loc_cChave = bancos + agencias + ncontas + ncheques
786: 
787:             UPDATE (loc_cCursor) SET nmarca1s = IIF(nmarca1s = 1, 0, 1) ;
788:                 WHERE bancos + agencias + ncontas + ncheques = loc_cChave ;
789:                   AND nemitidos = 0 AND ncancelas = 0
790: 
791:             THIS.grd_4c_Dados.Refresh()
792: 
793:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
794:                 SELECT (loc_cCursor)
795:                 GOTO loc_nRecno
796:             ENDIF
797: 
798:             NODEFAULT
799:         ENDIF
800:     ENDPROC
801: 
802:     PROCEDURE ChkImprimeMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
803:         THIS.ChkImprimeKeyPress(32, 0)
804:         NODEFAULT
805:     ENDPROC
806: 
807:     PROCEDURE ChkImprimeMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
808:         NODEFAULT
809:     ENDPROC

*-- Linhas 2030 a 2048:
2030:             loc_cSafety = SET("Safety")
2031:             SET SAFETY OFF
2032: 
2033:             SELECT (loc_cCursor)
2034:             ZAP
2035: 
2036:             IF loc_cSafety == "ON"
2037:                 SET SAFETY ON
2038:             ENDIF
2039: 
2040:             THIS.grd_4c_Dados.Refresh()
2041:         ENDIF
2042:     ENDPROC
2043: 
2044:     *==========================================================================
2045:     * ValidarCdGruposKeyPress / ValidarDsGruposKeyPress - Equivalente ao Valid
2046:     * de GetCdGrupos/GetDsGrupos do legado (fAcessoContab): F4 abre o picker
2047:     * (AbrirBuscaGrupo), Enter/Tab tenta o match EXATO contra SigCdGcr
2048:     * (Codigos/Descrs) e, sem match, abre o picker com o prefixo digitado. O

*-- Linhas 2072 a 2091:
2072:                 USE IN cursor_4c_BuscaGrupo
2073:             ENDIF
2074: 
2075:             loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cValor)
2076:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")
2077: 
2078:             IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
2079:                 THIS.txt_4c_CdGrupos.Value = ALLTRIM(cursor_4c_BuscaGrupo.codigos)
2080:                 THIS.txt_4c_DsGrupos.Value = ALLTRIM(cursor_4c_BuscaGrupo.descrs)
2081: 
2082:                 IF USED("cursor_4c_BuscaGrupo")
2083:                     USE IN cursor_4c_BuscaGrupo
2084:                 ENDIF
2085:             ELSE
2086:                 IF USED("cursor_4c_BuscaGrupo")
2087:                     USE IN cursor_4c_BuscaGrupo
2088:                 ENDIF
2089:                 THIS.AbrirBuscaGrupo()
2090:                 RETURN
2091:             ENDIF

*-- Linhas 2125 a 2144:
2125:                 USE IN cursor_4c_BuscaGrupo
2126:             ENDIF
2127: 
2128:             loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE descrs = " + EscaparSQL(loc_cValor)
2129:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")
2130: 
2131:             IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
2132:                 THIS.txt_4c_CdGrupos.Value = ALLTRIM(cursor_4c_BuscaGrupo.codigos)
2133:                 THIS.txt_4c_DsGrupos.Value = ALLTRIM(cursor_4c_BuscaGrupo.descrs)
2134: 
2135:                 IF USED("cursor_4c_BuscaGrupo")
2136:                     USE IN cursor_4c_BuscaGrupo
2137:                 ENDIF
2138:             ELSE
2139:                 IF USED("cursor_4c_BuscaGrupo")
2140:                     USE IN cursor_4c_BuscaGrupo
2141:                 ENDIF
2142:                 THIS.AbrirBuscaGrupo()
2143:                 RETURN
2144:             ENDIF

*-- Linhas 2170 a 2195:
2170:         ENDIF
2171: 
2172:         IF !EMPTY(loc_cFiltro)
2173:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr WHERE " + ;
2174:                 "codigos LIKE " + EscaparSQL(loc_cFiltro + "%") + ;
2175:                 " OR descrs LIKE " + EscaparSQL(loc_cFiltro + "%") + " ORDER BY codigos"
2176:         ELSE
2177:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
2178:         ENDIF
2179: 
2180:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")
2181: 
2182:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
2183:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2184:             loc_oBusca.DefinirCursor("cursor_4c_BuscaGrupo", "codigos", "descrs", ;
2185:                 "Grupo de Contas")
2186: 
2187:             IF loc_oBusca.Mostrar()
2188:                 THIS.txt_4c_CdGrupos.Value = loc_oBusca.cCodigoSelecionado
2189:                 THIS.txt_4c_DsGrupos.Value = loc_oBusca.cDescricaoSelecionada
2190:                 THIS.LimparChequesSeFiltroMudou()
2191:             ENDIF
2192: 
2193:             loc_oBusca.Release()
2194:         ENDIF
2195: 

*-- Linhas 2231 a 2254:
2231:                 USE IN cursor_4c_BuscaConta
2232:             ENDIF
2233: 
2234:             loc_cSQL = "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cValor)
2235:             IF !EMPTY(loc_cGrupo)
2236:                 loc_cSQL = loc_cSQL + " AND grupos = " + EscaparSQL(loc_cGrupo)
2237:             ENDIF
2238: 
2239:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
2240: 
2241:             IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaConta") > 0
2242:                 THIS.txt_4c_CdContas.Value = ALLTRIM(cursor_4c_BuscaConta.iclis)
2243:                 THIS.txt_4c_DsContas.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)
2244: 
2245:                 IF USED("cursor_4c_BuscaConta")
2246:                     USE IN cursor_4c_BuscaConta
2247:                 ENDIF
2248:             ELSE
2249:                 IF USED("cursor_4c_BuscaConta")
2250:                     USE IN cursor_4c_BuscaConta
2251:                 ENDIF
2252:                 THIS.AbrirBuscaConta()
2253:                 RETURN
2254:             ENDIF

*-- Linhas 2289 a 2312:
2289:                 USE IN cursor_4c_BuscaConta
2290:             ENDIF
2291: 
2292:             loc_cSQL = "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE RTRIM(rclis) = " + EscaparSQL(loc_cValor)
2293:             IF !EMPTY(loc_cGrupo)
2294:                 loc_cSQL = loc_cSQL + " AND grupos = " + EscaparSQL(loc_cGrupo)
2295:             ENDIF
2296: 
2297:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
2298: 
2299:             IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaConta") > 0
2300:                 THIS.txt_4c_CdContas.Value = ALLTRIM(cursor_4c_BuscaConta.iclis)
2301:                 THIS.txt_4c_DsContas.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)
2302: 
2303:                 IF USED("cursor_4c_BuscaConta")
2304:                     USE IN cursor_4c_BuscaConta
2305:                 ENDIF
2306:             ELSE
2307:                 IF USED("cursor_4c_BuscaConta")
2308:                     USE IN cursor_4c_BuscaConta
2309:                 ENDIF
2310:                 THIS.AbrirBuscaConta()
2311:                 RETURN
2312:             ENDIF

*-- Linhas 2338 a 2369:
2338:             USE IN cursor_4c_BuscaConta
2339:         ENDIF
2340: 
2341:         loc_cSQL = "SELECT iclis, rclis FROM SigCdCli WHERE 1 = 1 "
2342: 
2343:         IF !EMPTY(loc_cGrupo)
2344:             loc_cSQL = loc_cSQL + "AND grupos = " + EscaparSQL(loc_cGrupo) + " "
2345:         ENDIF
2346: 
2347:         IF !EMPTY(loc_cFiltro)
2348:             loc_cSQL = loc_cSQL + "AND (iclis LIKE " + EscaparSQL(loc_cFiltro + "%") + ;
2349:                 " OR RTRIM(rclis) LIKE " + EscaparSQL(loc_cFiltro + "%") + ") "
2350:         ENDIF
2351: 
2352:         loc_cSQL = loc_cSQL + "ORDER BY iclis"
2353: 
2354:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
2355: 
2356:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaConta") > 0
2357:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2358:             loc_oBusca.DefinirCursor("cursor_4c_BuscaConta", "iclis", "rclis", "Contas")
2359: 
2360:             IF loc_oBusca.Mostrar()
2361:                 THIS.txt_4c_CdContas.Value = loc_oBusca.cCodigoSelecionado
2362:                 THIS.txt_4c_DsContas.Value = loc_oBusca.cDescricaoSelecionada
2363:                 THIS.LimparChequesSeFiltroMudou()
2364:             ENDIF
2365: 
2366:             loc_oBusca.Release()
2367:         ENDIF
2368: 
2369:         IF USED("cursor_4c_BuscaConta")

*-- Linhas 2567 a 2605:
2567:     * ncancelas convertidos via CASE WHEN, sem grupos/vencs/versos/
2568:     * empdopnums/impversos). Passar o cursor da grade direto estouraria
2569:     * "Variable 'CANCELAS' is not found." Por isso o cheque corrente eh
2570:     * relido com SELECT * FROM SigCqChi (mesmas colunas que CarregarDoCursor
2571:     * espera), pela PK cidchaves.
2572:     *==========================================================================
2573:     PROCEDURE BtnExcluirChqClick()
2574:         LOCAL loc_cCursor, loc_cCidchaves, loc_cSQL, loc_nResultado, loc_cMensagem
2575: 
2576:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2577: 
2578:         IF !USED(loc_cCursor) OR EOF(loc_cCursor)
2579:             MsgAviso("Nenhum cheque selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
2580:             RETURN
2581:         ENDIF
2582: 
2583:         loc_cCidchaves = EVALUATE(loc_cCursor + ".cidchaves")
2584: 
2585:         IF USED("cursor_4c_ChequeAtual")
2586:             USE IN cursor_4c_ChequeAtual
2587:         ENDIF
2588: 
2589:         loc_cSQL = "SELECT * FROM SigCqChi WHERE cidchaves = " + EscaparSQL(loc_cCidchaves)
2590:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChequeAtual")
2591: 
2592:         IF loc_nResultado <= 0 OR RECCOUNT("cursor_4c_ChequeAtual") = 0
2593:             MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel localizar o cheque para exclus" + CHR(227) + "o." + CHR(13) + CapturarErroSQL(), "Erro SQL")
2594:             IF USED("cursor_4c_ChequeAtual")
2595:                 USE IN cursor_4c_ChequeAtual
2596:             ENDIF
2597:             RETURN
2598:         ENDIF
2599: 
2600:         THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_ChequeAtual")
2601: 
2602:         IF USED("cursor_4c_ChequeAtual")
2603:             USE IN cursor_4c_ChequeAtual
2604:         ENDIF
2605: 

*-- Linhas 2611 a 2668:
2611: 
2612:         IF MsgConfirma(loc_cMensagem, "Exclus" + CHR(227) + "o de cheque cancelado")
2613:             IF THIS.this_oBusinessObject.Excluir()
2614:                 SELECT (loc_cCursor)
2615:                 DELETE
2616:                 THIS.grd_4c_Dados.Refresh()
2617:             ENDIF
2618:         ENDIF
2619:     ENDPROC
2620: 
2621:     *==========================================================================
2622:     * BtnMarcarTudoClick / BtnDesmarcarTudoClick - cmdTudo1.Click /
2623:     * cmdApaga1.Click do legado (marca/desmarca em massa a coluna Imprime).
2624:     *==========================================================================
2625:     PROCEDURE BtnMarcarTudoClick()
2626:         LOCAL loc_cCursor, loc_nRecno
2627: 
2628:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2629: 
2630:         IF USED(loc_cCursor)
2631:             loc_nRecno = RECNO(loc_cCursor)
2632:             UPDATE (loc_cCursor) SET nmarca1s = 1 WHERE nmarca1s = 0 AND nemitidos = 0 AND ncancelas = 0
2633: 
2634:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
2635:                 SELECT (loc_cCursor)
2636:                 GOTO loc_nRecno
2637:             ENDIF
2638: 
2639:             THIS.grd_4c_Dados.Refresh()
2640:         ENDIF
2641:     ENDPROC
2642: 
2643:     PROCEDURE BtnDesmarcarTudoClick()
2644:         LOCAL loc_cCursor, loc_nRecno
2645: 
2646:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
2647: 
2648:         IF USED(loc_cCursor)
2649:             loc_nRecno = RECNO(loc_cCursor)
2650:             UPDATE (loc_cCursor) SET nmarca1s = 0 WHERE nmarca1s = 1
2651: 
2652:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
2653:                 SELECT (loc_cCursor)
2654:                 GOTO loc_nRecno
2655:             ENDIF
2656: 
2657:             THIS.grd_4c_Dados.Refresh()
2658:         ENDIF
2659:     ENDPROC
2660: 
2661:     *==========================================================================
2662:     * BtnImprimirClick - Imprimir (cmdImprimir.Click do legado): abre
2663:     * FormSigReEch (Emissao de Cheque, ja migrado) no modo CONSULTAR para o
2664:     * cheque selecionado na grade - mesmos parametros do "Do Form SigReEch
2665:     * With emps,dopes,numes,'CONSULTAR',ncheques" original.
2666:     *==========================================================================
2667:     PROCEDURE BtnImprimirClick()
2668:         LOCAL loc_cCursor, loc_oForm, loc_oErro

*-- Linhas 2675 a 2693:
2675:         ENDIF
2676: 
2677:         loc_oForm = .NULL.
2678:         SELECT (loc_cCursor)
2679: 
2680:         TRY
2681:             loc_oForm = CREATEOBJECT("FormSigReEch", emps, dopes, numes, "CONSULTAR", ncheques)
2682:         CATCH TO loc_oErro
2683:             MsgErro(loc_oErro.Message, "Erro ao abrir emiss" + CHR(227) + "o de cheque")
2684:             loc_oForm = .NULL.
2685:         ENDTRY
2686: 
2687:         IF VARTYPE(loc_oForm) = "O"
2688:             loc_oForm.Show()
2689:         ENDIF
2690:     ENDPROC
2691: 
2692:     *==========================================================================
2693:     * BtnDocumentoClick - Documento (cmdDocumento.Click do legado): confere

*-- Linhas 2707 a 2729:
2707:             RETURN
2708:         ENDIF
2709: 
2710:         SELECT (loc_cCursor)
2711:         loc_cEmpDopNums = PADR(emps, 3) + PADR(dopes, 20) + STR(numes, 6)
2712: 
2713:         loc_cSQL = "SELECT TOP 1 empdopnums FROM SigCdPgr WHERE empdopnums = " + EscaparSQL(loc_cEmpDopNums)
2714:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerificaPgr")
2715: 
2716:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_VerificaPgr") > 0
2717:             loc_oForm = .NULL.
2718:             TRY
2719:                 loc_oForm = CREATEOBJECT("Formpgr")
2720:             CATCH TO loc_oErro
2721:                 MsgErro(loc_oErro.Message, "Erro ao abrir Lan" + CHR(231) + "amentos e Pagamentos")
2722:                 loc_oForm = .NULL.
2723:             ENDTRY
2724: 
2725:             IF VARTYPE(loc_oForm) = "O"
2726:                 loc_oForm.Show()
2727:             ENDIF
2728:         ENDIF
2729: 

*-- Linhas 2820 a 2838:
2820:             .Visible     = .T.
2821:         ENDWITH
2822: 
2823:         SELECT (loc_cCursor)
2824:         SET NEAR ON
2825: 
2826:         DO CASE
2827:             CASE !EMPTY(loc_dEmissao)
2828:                 SET ORDER TO Emissao
2829:                 SEEK DTOS(loc_dEmissao) + loc_cBanco + loc_cAgencia + loc_cConta + loc_cCheque
2830:             CASE loc_nValor != 0
2831:                 SET ORDER TO Valor
2832:                 SEEK STR(loc_nValor, 12, 2) + loc_cBanco + loc_cAgencia + loc_cConta + loc_cCheque
2833:             CASE !EMPTY(loc_cBanco)
2834:                 SET ORDER TO Cheque
2835:                 SEEK loc_cBanco + loc_cAgencia + loc_cConta + loc_cCheque
2836:             CASE !EMPTY(loc_cAgencia)
2837:                 SET ORDER TO Agencia
2838:                 SEEK loc_cAgencia + loc_cConta + loc_cCheque

*-- Linhas 3012 a 3034:
3012:             RETURN
3013:         ENDIF
3014: 
3015:         SELECT (loc_cCursor)
3016:         loc_cEmpDopNums = PADR(emps, 3) + PADR(dopes, 20) + STR(numes, 6)
3017: 
3018:         loc_cSQL = "SELECT TOP 1 empdopnums FROM SigCdPgr WHERE empdopnums = " + EscaparSQL(loc_cEmpDopNums)
3019:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerificaPgr")
3020: 
3021:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_VerificaPgr") > 0
3022:             loc_oForm = .NULL.
3023:             TRY
3024:                 loc_oForm = CREATEOBJECT("Formpgr")
3025:             CATCH TO loc_oErro
3026:                 MsgErro(loc_oErro.Message, "Erro ao abrir Lan" + CHR(231) + "amentos e Pagamentos")
3027:                 loc_oForm = .NULL.
3028:             ENDTRY
3029: 
3030:             IF VARTYPE(loc_oForm) = "O"
3031:                 loc_oForm.Show()
3032:             ENDIF
3033:         ENDIF
3034: 

*-- Linhas 3087 a 3105:
3087:             RETURN
3088:         ENDIF
3089: 
3090:         SELECT (loc_cCursor)
3091:         COUNT TO loc_nQtdMarcados FOR nmarca1s = 1
3092: 
3093:         IF loc_nQtdMarcados = 0
3094:             MsgAviso("Nenhum Cheque Selecionado !!!", "Aten" + CHR(231) + CHR(227) + "o")
3095:             RETURN
3096:         ENDIF
3097: 
3098:         IF MsgConfirma("Confirma que " + ALLTRIM(STR(loc_nQtdMarcados)) + " cheque(s) selecionado(s) " + ;
3099:                 "j" + CHR(225) + " foram impressos na impressora de cheques?", "Impress" + CHR(227) + "o de Cheque")
3100:             IF THIS.this_oBusinessObject.MarcarChequesComoEmitidos(loc_cCursor)
3101:                 THIS.grd_4c_Dados.Refresh()
3102:             ENDIF
3103:         ENDIF
3104:     ENDPROC
3105: 

*-- Linhas 3119 a 3151:
3119:             RETURN
3120:         ENDIF
3121: 
3122:         SELECT (loc_cCursor)
3123:         COUNT TO loc_nQtdMarcados FOR nmarca1s = 1
3124: 
3125:         *-- Legado: sem cheque marcado (TmpChi vazio), o botao abre o painel
3126:         *-- de impressao manual (banco + faixa de cheques digitados), em vez
3127:         *-- de operar sobre a selecao da grade.
3128:         IF loc_nQtdMarcados = 0
3129:             THIS.AbrirImpressaoManualCheque()
3130:             RETURN
3131:         ENDIF
3132: 
3133:         loc_lMesmoBanco    = .T.
3134:         loc_cPrimeiroBanco = ""
3135: 
3136:         SELECT (loc_cCursor)
3137:         SCAN FOR nmarca1s = 1
3138:             IF EMPTY(loc_cPrimeiroBanco)
3139:                 loc_cPrimeiroBanco = bancos
3140:             ELSE
3141:                 IF bancos != loc_cPrimeiroBanco
3142:                     loc_lMesmoBanco = .F.
3143:                     EXIT
3144:                 ENDIF
3145:             ENDIF
3146:         ENDSCAN
3147: 
3148:         IF !loc_lMesmoBanco
3149:             MsgAviso("Todos os cheques selecionados devem ser do mesmo banco", "Aten" + CHR(231) + CHR(227) + "o")
3150:             RETURN
3151:         ENDIF

*-- Linhas 3231 a 3249:
3231:     *==========================================================================
3232:     * ImprimirChequeManualClick - cmdimpri.Click do impchmat.cmdGprocurar
3233:     * legado: valida Banco/faixa, filtra o cursor JA CARREGADO da grade
3234:     * (mesma fonte que o legado usa - "Select ... From CsSigCqChi Where
3235:     * bancos = ... And ncheques Between ... And ncancelas = 0", NAO uma nova
3236:     * consulta ao SQL Server) e, confirmando, marca como emitidos.
3237:     *
3238:     * A rotina de posicionamento fisico na folha do cheque (SigIpChq.prg,
3239:     * ~180 linhas com fValorExtenso/fwBuscaInt, nenhuma delas portada) fica
3240:     * para uma fase dedicada de impressao de cheques - mesma ressalva ja
3241:     * documentada em BtnImpChqClick/BtnChMatClick.
3242:     *==========================================================================
3243:     PROCEDURE ImprimirChequeManualClick()
3244:         LOCAL loc_cCursor, loc_cBanco, loc_cChIni, loc_cChFin, loc_nQtd, loc_lTemEmitido
3245: 
3246:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
3247: 
3248:         WITH THIS.cnt_4c_Impchmat
3249:             loc_cBanco = .txt_4c_Banco.Value

*-- Linhas 3280 a 3305:
3280:             RETURN
3281:         ENDIF
3282: 
3283:         SELECT (loc_cCursor)
3284:         COUNT TO loc_nQtd FOR bancos = loc_cBanco AND BETWEEN(ncheques, loc_cChIni, loc_cChFin) AND ncancelas = 0
3285: 
3286:         IF loc_nQtd = 0
3287:             RETURN
3288:         ENDIF
3289: 
3290:         SELECT (loc_cCursor)
3291:         LOCATE FOR bancos = loc_cBanco AND BETWEEN(ncheques, loc_cChIni, loc_cChFin) AND ncancelas = 0 AND nemitidos = 1
3292:         loc_lTemEmitido = FOUND()
3293: 
3294:         IF loc_lTemEmitido
3295:             IF !MsgConfirma("Os cheques selecionados j" + CHR(225) + " foram emitidos. Confirma impress" + CHR(227) + "o ?", "Aten" + CHR(231) + CHR(227) + "o")
3296:                 RETURN
3297:             ENDIF
3298:         ENDIF
3299: 
3300:         MsgAviso("Verifique se a impressora est" + CHR(225) + " pronta p/ impress" + CHR(227) + "o", "Aten" + CHR(231) + CHR(227) + "o")
3301: 
3302:         IF THIS.this_oBusinessObject.MarcarChequesComoEmitidosPorFaixa(loc_cCursor, loc_cBanco, loc_cChIni, loc_cChFin)
3303:             THIS.grd_4c_Dados.Refresh()
3304:             THIS.FecharImpressaoManualCheque()
3305:         ENDIF


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

