# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NOPS, SERVICOS, CMATS, CPROS, EMPDNPS, RATEIO, NENVS, QTDS, PESOS, REINOPS, LIBPESS, SENHAS, CGRUS, MATS, EMPDOPNUMS, CPRO2S, CUNIS, FATORS, PESO2S, QTEQUALPS, IMPOPS, VALUE, CEMPS, DIFPES, SINALS, TRFPESAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'LINHAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NOPS, SERVICOS, CMATS, CPROS, EMPDNPS, RATEIO, NENVS, QTDS, PESOS, REINOPS, LIBPESS, SENHAS, CGRUS, MATS, EMPDOPNUMS, CPRO2S, CUNIS, FATORS, PESO2S, QTEQUALPS, IMPOPS, VALUE, CEMPS, DIFPES, SINALS, TRFPESAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NOPS, SERVICOS, CMATS, CPROS, EMPDNPS, RATEIO, NENVS, QTDS, PESOS, REINOPS, LIBPESS, SENHAS, CGRUS, MATS, EMPDOPNUMS, CPRO2S, CUNIS, FATORS, PESO2S, QTEQUALPS, IMPOPS, VALUE, CEMPS, DIFPES, SINALS, TRFPESAS

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
Select CrSigCdNei
lcSql = [Select a.cMats,c.Retrabs,a.Qtds,a.Coefs,a.Fators,a.Moedas From SigCdNei a, SigCdNec c, SigCdSvc b ]+;
Thisform.Podatamgr.Sqlexecute(lcSql,'CsxNensi')
Select csxNensI
Select crSigCdOpd
Select CrSigCdNei
Select xNensiE
Select xNensI
Select xNensiE
Append From Dbf('xNensI')
Delete All For Empty(Nops) And Empty(CMats) And Empty(Cats) And (Rateio <> 1)
	Select Nenvs, MatPs, Peso as Pesos ;
	From xPesa Where Recno() = _Amarra ;
	Select xRateio
		Select xNensiE
		If Seek(_Nenv)
			Insert Into xNensiE (Nenvs, Nops, Numps, CMats, PsFaseAnt, Pesos, Qtds, Rateio) ;
Select xNensiE
Select xNensiE
	Insert Into crSigCdNei (Emps, Dopps, Numps, Nops, Nenvs, CMats, CDescs, CUnis, Tpops, Cats, Obss, ;
	.Column1.ControlSource = 'xPesa.Cpros'
	.Column2.ControlSource = 'xPesa.Obs'
	.Column3.ControlSource = 'xPesa.Oper'
	.Column5.ControlSource = 'xPesa.Qtds'
	.Column6.ControlSource = 'xPesa.Peso'
	.Column4.ControlSource = 'xPesa.Tams'
	.Column7.ControlSource = 'xPesa.Cors'
	.Column8.ControlSource = 'xPesa.cbars'
	.Column9.ControlSource = 'xPesa.CustoFs'
lcSql = [Select Count(*) as Senha From SigCdUsu Where LibPess = 'S' And Senhas <> ' ']
ThisForm.parentform.poDataMgr.SqlExecute(lcSql,'TmpSenha')
Select TmpSenha
Select Nenvs, Sum(Qtds) as Qtds ;
  From xPesa ;
Select a.Nenvs, Sum(a.Pesos) as Pesos, b.Qtds ;
  From xNensi a, tPesa b ;
Select xRateio
Select xPesa
	Select xRateio
	If Seek(_Nenv) And xRateio.Pesos # 0 And crSigCdOpd.pesMatPs
		Select xPesa
Select xPesa
		lcSql = [Select b.mtprimas From SigCdPro a, SigCdGrp b Where a.Cpros = ']+xPesa.Cpros+[' And a.Cgrus = b.Cgrus ]
		ThisForm.ParentForm.PodataMgr.Sqlexecute(lcSql,'TmpGru')
		Select xPesa
			lcSql = [Select * from SigPrCpo Where Cpros = ']+xpesa.Cpros+[']
			ThisForm.parentform.Podatamgr.Sqlexecute(lcsql,'CrTmpCompo')
			lcSql = [Select Mats, cCats From SigCdSvc Where Mats <> ' ']
			ThisForm.ParentForm.PodataMgr.Sqlexecute(lcSql,'CsTmpSer')
			Select CsTmpSer
			lcSql = [Select b.cpros, sum(a.Qtds) as Qtds From SigCdNei a, SigCdSvc b ]+;
			Thisform.parentForm.Podatamgr.Sqlexecute(lcSql,'CsxNensi')
				Select Padr(b.ccats,14) as Cpros, sum(a.Qtds) as Qtds From CrSigCdNei a, CsTmpSer b ;
				Select CsxNensi
				Append From Dbf('CszNensi')
			lcSql = [Select dopes From SigOpOeo ]
			ThisForm.parentform.PodataMgr.Sqlexecute(lcsql,'TmpEopp')
				lcSql = [Select a.cpros,Sum(a.qtds) as Qtds From SigMvItn a, SigInBep b, SigCdNei c, SigOpPic d, SigCdSvc e ]+;
				Thisform.parentForm.Podatamgr.Sqlexecute(lcSql,'CsTmp3')
				Select CsxNensi
				Append From Dbf('CsTmp3')
			Select CrTmpCompo
			Select CrSigCdNei
				lcSql = [Select * from SigCdPro Where Cpros = ']+CrSigCdNei.Cmats+[']
				ThisForm.Parentform.podatamgr.sqlexecute(lcsql,'crTmpPro')
				lcSql = [Select EtiPads from SigCdGrp Where Cgrus = ']+CrTmpPro.Cgrus+[']
				ThisForm.Parentform.podatamgr.sqlexecute(lcsql,'crTmpGru')
				lcSql = [Select cUnis,Fators,QtEqualPs from SigCdUni Where cUnis = ']+CrTmpPro.Cunis+[']
				ThisForm.parentform.Podatamgr.Sqlexecute(lcsql,'CrTmpUni')
				Select CrtmpCompo
				If Seek(CrSigCdNei.Cmats)
					Select CrTmpCompo
			Select CsxNensi
				lcSql = [Select * from SigCdPro Where Cpros = ']+csxNensi.cpros+[']
				ThisForm.Parentform.podatamgr.sqlexecute(lcsql,'crTmpPro')
				lcSql = [Select EtiPads from SigCdGrp Where Cgrus = ']+CrTmpPro.Cgrus+[']
				ThisForm.Parentform.podatamgr.sqlexecute(lcsql,'crTmpGru')
				lcSql = [Select cUnis,Fators,QtEqualPs from SigCdUni Where cUnis = ']+CrTmpPro.Cunis+[']
				ThisForm.parentform.Podatamgr.Sqlexecute(lcsql,'CrTmpUni')
				Select CrtmpCompo
				If Seek(csxNensi.cpros)
					Select CrTmpCompo
			Select CsSigPrCpo
			Append From Dbf('CrTmpCompo')
					lcsql = [Select CGrus From SigCdPro Where cpros = ']+CsSigPrCpo.Mats+[']
					ThisForm.Podatamgr.Sqlexecute(lcsql,'Localpro')
					lcsql = [Select cestoqs,ImpOps from SigCdGrp where cgrus = ']+localpro.cgrus+[']
					ThisForm.PodataMgr.sqlexecute(lcsql,'LocalGru')
						Delete In CsSigPrCpo
			If Not Thisform.Podatamgr.update('CsSigPrCpo')
			Select xPesa
	Select xPesa
lcSql = [Select DifPes From SigCdEmp Where Cemps = ']+_Empr+[']
ThisForm.Podatamgr.Sqlexecute(lcsql,'CrSigCdEmp')
		Select xPesa
	Select xPesa
	Select xPesa
	Select xPesa
	Select xPesa
Select xPesa
Select xNensiS
	Select xPesa

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdMp9.prg) - TRECHOS RELEVANTES PARA PASS SQL (2131 linhas total):

*-- Linhas 71 a 96:
71: 
72:             *-- Data de referencia para cotacoes
73:             IF USED("TmpNens")
74:                 SELECT TmpNens
75:                 GO TOP
76:                 THIS.this_oBusinessObject.this_dDataMovimento = NVL(Datas, DATE())
77:             ENDIF
78: 
79:             *-- Codigo de acesso ao programa (crSigCdOpd.Ndopps)
80:             IF USED("crSigCdOpd")
81:                 SELECT crSigCdOpd
82:                 GO TOP
83:                 THIS.this_cProgAcesso = "P" + PADL(TRANSFORM(NVL(Ndopps, 0)), 8, "0")
84:                 THIS.this_oBusinessObject.this_cProgAcesso = THIS.this_cProgAcesso
85:             ENDIF
86: 
87:             *-- Cria cursores locais de trabalho
88:             THIS.CriarCursoresLocais()
89: 
90:             *-- Aparencia base do form (OPERACIONAL sem PageFrame Page1/Page2)
91:             THIS.ConfigurarPageFrame()
92: 
93:             *-- Interface
94:             THIS.ConfigurarCabecalho()
95:             THIS.ConfigurarPaginaLista()
96:             THIS.ConfigurarPaginaDados()

*-- Linhas 104 a 122:
104: 
105:             *-- Posiciona xPesa no inicio
106:             IF USED("xPesa")
107:                 SELECT xPesa
108:                 SET ORDER TO Amarra
109:                 GO TOP
110:             ENDIF
111: 
112:             THIS.Refresh()
113:             loc_lSucesso = .T.
114:         ELSE
115:             MsgErro("Falha ao criar SigPdMp9BO.", "Erro")
116:         ENDIF
117:         CATCH TO loc_oErro
118:             MsgErro(loc_oErro.Message, "Erro ao inicializar FormSigPdMp9")
119:         ENDTRY
120:         RETURN loc_lSucesso
121:     ENDPROC
122: 

*-- Linhas 130 a 151:
130: 
131:             *-- CrSigCdNei: buffer local de movimentos antes de gravar no SQL Server
132:             IF USED("CrSigCdNei")
133:                 SELECT CrSigCdNei
134:                 ZAP
135:             ELSE
136:                 CREATE CURSOR CrSigCdNei ( ;
137:                     Emps      C(3),    ;
138:                     Dopps     C(10),   ;
139:                     Numps     N(10,0), ;
140:                     Nops      N(10,0), ;
141:                     Nenvs     N(10,0), ;
142:                     CMats     C(14),   ;
143:                     CDescs    C(40),   ;
144:                     CUnis     C(3),    ;
145:                     Tpops     C(3),    ;
146:                     Cats      C(6),    ;
147:                     Obss      C(40),   ;
148:                     AQtds     N(11,3), ;
149:                     Qtds      N(11,3), ;
150:                     Pesos     N(11,3), ;
151:                     FlagIncs  L,       ;

*-- Linhas 166 a 188:
166:             *-- xNensiE: cursor auxiliar para rateio de peso por envelope
167:             IF USED("xNensI")
168:                 IF USED("xNensiE")
169:                     SELECT xNensiE
170:                     ZAP
171:                 ELSE
172:                     SELECT * FROM xNensI WHERE .F. INTO CURSOR xNensiE READWRITE
173:                     SELECT xNensiE
174:                     IF TYPE("Rateio") <> "U"
175:                         INDEX ON NVL(Rateio, 0)          TAG Rateio
176:                     ENDIF
177:                     IF TYPE("Nenvs") <> "U"
178:                         INDEX ON NVL(Nenvs, 0)           TAG Nenvs
179:                     ENDIF
180:                     IF TYPE("Gravar") <> "U"
181:                         INDEX ON ALLTRIM(NVL(Gravar, "")) TAG Gravar
182:                     ENDIF
183:                     IF TYPE("PsFaseAnt") <> "U"
184:                         INDEX ON NVL(PsFaseAnt, 0)       TAG PsFaseAnt
185:                     ENDIF
186:                 ENDIF
187:             ENDIF
188:         CATCH TO loc_oErro

*-- Linhas 292 a 423:
292:         loc_lLibObss = .F.
293:         loc_lTrfPesas = .F.
294:         IF USED("crSigCdPam")
295:             SELECT crSigCdPam
296:             GO TOP
297:             IF VARTYPE(crSigCdPam.LibObss) = "L"
298:                 loc_lLibObss = crSigCdPam.LibObss
299:             ELSE
300:                 IF VARTYPE(crSigCdPam.LibObss) = "L"
301:                     loc_lLibObss = crSigCdPam.LibObss
302:                 ELSE
303:                     loc_lLibObss = (NVL(crSigCdPam.LibObss, 0) = 1)
304:                 ENDIF
305:             ENDIF
306:         ENDIF
307:         IF USED("crSigCdOpd")
308:             SELECT crSigCdOpd
309:             GO TOP
310:             IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
311:                 loc_lTrfPesas = crSigCdOpd.TrfPesas
312:             ELSE
313:                 IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
314:                     loc_lTrfPesas = crSigCdOpd.TrfPesas
315:                 ELSE
316:                     loc_lTrfPesas = (NVL(crSigCdOpd.TrfPesas, 0) = 1)
317:                 ENDIF
318:             ENDIF
319:         ENDIF
320: 
321:         THIS.AddObject("grd_4c_Itens", "Grid")
322:         WITH THIS.grd_4c_Itens
323:             .ColumnCount       = 9
324:             .FontSize          = 8
325:             .AllowHeaderSizing = .F.
326:             .AllowRowSizing    = .F.
327:             .DeleteMark        = .F.
328:             .RecordMark        = .F.
329:             .Height            = 463
330:             .Left              = 10
331:             .Panel             = 1
332:             .RowHeight         = 17
333:             .ScrollBars        = 2
334:             .TabIndex          = 1
335:             .Top               = 111
336:             .Width             = 980
337:             .GridLineColor     = RGB(238, 238, 238)
338:             .RecordSource      = "xPesa"
339:             .ReadOnly          = loc_lTrfPesas
340: 
341:             *-- Column1: Produto (Cpros) - ReadOnly
342:             WITH .Column1
343:                 .ControlSource     = "xPesa.Cpros"
344:                 .ColumnOrder       = 3
345:                 .Width             = 120
346:                 .Movable           = .F.
347:                 .Resizable         = .F.
348:                 .ReadOnly          = .T.
349:                 .FontSize          = 8
350:                 .Header1.Caption   = "Produto"
351:                 .Header1.FontName  = "Tahoma"
352:                 .Header1.FontSize  = 8
353:                 .Header1.Alignment = 2
354:                 .Text1.FontSize    = 8
355:                 .Text1.BorderStyle = 0
356:                 .Text1.Margin      = 0
357:                 .Text1.ReadOnly    = .T.
358:                 .Text1.ForeColor   = RGB(0, 0, 0)
359:                 .Text1.BackColor   = RGB(255, 255, 255)
360:             ENDWITH
361:             BINDEVENT(THIS.grd_4c_Itens.Column1.Text1, "When", THIS, "GradeCol1TextWhen")
362: 
363:             *-- Column2: Observacao (Obs) - editavel com LibObss=1 e INSERIR
364:             WITH .Column2
365:                 .ControlSource     = "xPesa.Obs"
366:                 .ColumnOrder       = 6
367:                 .Width             = 100
368:                 .Movable           = .F.
369:                 .Resizable         = .F.
370:                 .ReadOnly          = !loc_lLibObss
371:                 .FontSize          = 8
372:                 .Header1.Caption   = "Observa" + CHR(231) + CHR(227) + "o"
373:                 .Header1.FontName  = "Tahoma"
374:                 .Header1.FontSize  = 8
375:                 .Header1.Alignment = 2
376:                 .Text1.FontSize    = 8
377:                 .Text1.BorderStyle = 0
378:                 .Text1.Margin      = 0
379:                 .Text1.ForeColor   = RGB(0, 0, 0)
380:                 .Text1.BackColor   = RGB(255, 255, 255)
381:             ENDWITH
382:             BINDEVENT(THIS.grd_4c_Itens.Column2.Text1, "When", THIS, "GradeCol2TextWhen")
383: 
384:             *-- Column3: Movimentacao (Oper) - ReadOnly
385:             WITH .Column3
386:                 .ControlSource     = "xPesa.Oper"
387:                 .ColumnOrder       = 4
388:                 .Width             = 221
389:                 .Movable           = .F.
390:                 .Resizable         = .F.
391:                 .ReadOnly          = .T.
392:                 .FontSize          = 8
393:                 .Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
394:                 .Header1.FontName  = "Tahoma"
395:                 .Header1.FontSize  = 8
396:                 .Header1.Alignment = 2
397:                 .Text1.FontSize    = 8
398:                 .Text1.BorderStyle = 0
399:                 .Text1.Margin      = 0
400:                 .Text1.ReadOnly    = .T.
401:                 .Text1.ForeColor   = RGB(0, 0, 0)
402:                 .Text1.BackColor   = RGB(255, 255, 255)
403:             ENDWITH
404:             BINDEVENT(THIS.grd_4c_Itens.Column3.Text1, "When", THIS, "GradeCol3TextWhen")
405: 
406:             *-- Column4: Tamanho (Tams) - lookup SigCdTam, editavel com LibObss=1
407:             WITH .Column4
408:                 .ControlSource     = "xPesa.Tams"
409:                 .ColumnOrder       = 8
410:                 .Width             = 40
411:                 .Movable           = .F.
412:                 .Resizable         = .F.
413:                 .ReadOnly          = .F.
414:                 .FontSize          = 8
415:                 .Header1.Caption   = "Tam"
416:                 .Header1.FontName  = "Tahoma"
417:                 .Header1.FontSize  = 8
418:                 .Header1.Alignment = 2
419:                 .Text1.FontSize    = 8
420:                 .Text1.BorderStyle = 0
421:                 .Text1.Margin      = 0
422:                 .Text1.ReadOnly    = .F.
423:                 .Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 429 a 447:
429: 
430:             *-- Column5: Quantidade (Qtds) - ReadOnly (editavel se LibObss<>1)
431:             WITH .Column5
432:                 .ControlSource     = "xPesa.Qtds"
433:                 .ColumnOrder       = 5
434:                 .Width             = 100
435:                 .Movable           = .F.
436:                 .Resizable         = .F.
437:                 .ReadOnly          = .T.
438:                 .FontBold          = .T.
439:                 .FontSize          = 8
440:                 .Format            = "K"
441:                 .Header1.Caption   = "Quantidade"
442:                 .Header1.FontName  = "Tahoma"
443:                 .Header1.FontSize  = 8
444:                 .Header1.Alignment = 2
445:                 .Text1.FontBold    = .T.
446:                 .Text1.FontSize    = 8
447:                 .Text1.BorderStyle = 0

*-- Linhas 455 a 473:
455: 
456:             *-- Column6: Peso (Peso) - campo editavel principal com logica de balanca
457:             WITH .Column6
458:                 .ControlSource     = "xPesa.Peso"
459:                 .ColumnOrder       = 9
460:                 .Width             = 100
461:                 .Movable           = .F.
462:                 .Resizable         = .F.
463:                 .ReadOnly          = .F.
464:                 .FontBold          = .T.
465:                 .FontSize          = 8
466:                 .Header1.Caption   = "Peso"
467:                 .Header1.FontName  = "Tahoma"
468:                 .Header1.FontSize  = 8
469:                 .Header1.Alignment = 2
470:                 .Text1.FontBold    = .T.
471:                 .Text1.FontSize    = 8
472:                 .Text1.BorderStyle = 0
473:                 .Text1.Margin      = 0

*-- Linhas 481 a 499:
481: 
482:             *-- Column7: Cor (Cors) - lookup SigCdCor, editavel com LibObss=1
483:             WITH .Column7
484:                 .ControlSource     = "xPesa.Cors"
485:                 .ColumnOrder       = 7
486:                 .Width             = 40
487:                 .Movable           = .F.
488:                 .Resizable         = .F.
489:                 .ReadOnly          = .F.
490:                 .FontSize          = 8
491:                 .Header1.Caption   = "Cor"
492:                 .Header1.FontName  = "Tahoma"
493:                 .Header1.FontSize  = 8
494:                 .Header1.Alignment = 2
495:                 .Text1.FontSize    = 8
496:                 .Text1.BorderStyle = 0
497:                 .Text1.Margin      = 0
498:                 .Text1.ReadOnly    = .F.
499:                 .Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 505 a 545:
505: 
506:             *-- Column8: Barras (Cbars) - ReadOnly
507:             WITH .Column8
508:                 .ControlSource     = "xPesa.Cbars"
509:                 .ColumnOrder       = 2
510:                 .Width             = 110
511:                 .Movable           = .F.
512:                 .Resizable         = .F.
513:                 .ReadOnly          = .T.
514:                 .FontSize          = 8
515:                 .Header1.Caption   = "Barras"
516:                 .Header1.FontName  = "Tahoma"
517:                 .Header1.FontSize  = 8
518:                 .Header1.Alignment = 2
519:                 .Text1.FontSize    = 8
520:                 .Text1.BorderStyle = 0
521:                 .Text1.Margin      = 0
522:                 .Text1.ReadOnly    = .T.
523:                 .Text1.ForeColor   = RGB(0, 0, 0)
524:                 .Text1.BackColor   = RGB(255, 255, 255)
525:             ENDWITH
526:             BINDEVENT(THIS.grd_4c_Itens.Column8.Text1, "When", THIS, "GradeCol8TextWhen")
527: 
528:             *-- Column9: Custo (CustoFs) - ReadOnly, visivel apenas com permissao CUSTOP
529:             WITH .Column9
530:                 .ControlSource     = "xPesa.CustoFs"
531:                 .ColumnOrder       = 1
532:                 .Movable           = .F.
533:                 .Resizable         = .F.
534:                 .ReadOnly          = .T.
535:                 .FontSize          = 8
536:                 .Header1.Caption   = "Custo"
537:                 .Header1.FontName  = "Tahoma"
538:                 .Header1.FontSize  = 8
539:                 .Header1.Alignment = 2
540:                 .Text1.FontSize    = 8
541:                 .Text1.BorderStyle = 0
542:                 .Text1.Margin      = 0
543:                 .Text1.ReadOnly    = .T.
544:                 .Text1.ForeColor   = RGB(0, 0, 0)
545:                 .Text1.BackColor   = RGB(255, 255, 255)

*-- Linhas 740 a 758:
740:         THIS.this_lTemBalanca = .F.
741:         TRY
742:             IF USED("crSigCdPam")
743:             SELECT crSigCdPam
744:             GO TOP
745:             LOCAL loc_cVcx
746:             loc_cVcx = ALLTRIM(gc_4c_CaminhoBase) + "..\framework\framework.vcx"
747:             IF FILE(loc_cVcx)
748:             SET CLASSLIB TO (loc_cVcx) ADDITIVE
749:             THIS.AddObject("bal_4c_Balanca", "balan" + CHR(231) + "a")
750:             WITH THIS.bal_4c_Balanca
751:                 .Top          = 84
752:                 .Left         = 924
753:                 .Height       = 36
754:                 .Width        = 24
755:                 .Porta        = NVL(crSigCdPam.BalPortas, 0)
756:                 .Velocidade   = NVL(crSigCdPam.BalVelocs, 0)
757:                 .TipoParidade = NVL(crSigCdPam.BalTppars, 0)
758:                 .Bits         = NVL(crSigCdPam.BalBits,   0)

*-- Linhas 773 a 840:
773:     *==========================================================================
774:     * InicializarPesoFixs - Calcula PesoFixs para cada peca em xPesa
775:     * a partir dos pesos fixos acumulados em xNensi (Rateio=3, !Visivel)
776:     * Replica logica de Select/Index/Scan no Init do legado
777:     *==========================================================================
778:     PROTECTED PROCEDURE InicializarPesoFixs()
779:         LOCAL loc_oErro, loc_lPesMatPs
780:         loc_lPesMatPs = .F.
781:         TRY
782:             IF USED("xPesa") AND USED("xNensI") AND USED("crSigCdOpd")
783:             SELECT crSigCdOpd
784:             GO TOP
785:             loc_lPesMatPs = (NVL(crSigCdOpd.pesMatPs, 0) <> 0)
786:             IF loc_lPesMatPs
787: 
788:             *-- Total de pecas por envelope
789:             IF USED("tPesa_4c")
790:                 USE IN tPesa_4c
791:             ENDIF
792:             SELECT Nenvs, SUM(Qtds) AS Qtds ;
793:               FROM xPesa ;
794:              GROUP BY Nenvs ;
795:               INTO CURSOR tPesa_4c
796: 
797:             *-- Peso fixo (Rateio=3, !Visivel) por envelope
798:             IF USED("xRateio_4c")
799:                 USE IN xRateio_4c
800:             ENDIF
801:             SELECT a.Nenvs, SUM(a.Pesos) AS Pesos, b.Qtds ;
802:               FROM xNensI a, tPesa_4c b ;
803:              WHERE !IIF(VARTYPE(a.Visivel)="L", a.Visivel, NVL(a.Visivel,0)=1) ;
804:                AND NVL(a.Rateio, 0) = 3 ;
805:                AND a.Nenvs = b.Nenvs ;
806:              GROUP BY a.Nenvs, b.Qtds ;
807:               INTO CURSOR xRateio_4c
808: 
809:             IF RECCOUNT("xRateio_4c") > 0
810:                 SELECT xRateio_4c
811:                 INDEX ON NVL(Nenvs, 0) TAG Nenvs
812: 
813:                 SELECT xPesa
814:                 SCAN
815:                     LOCAL loc_nNenv, loc_nQtds, loc_nPesoFixs
816:                     loc_nNenv    = NVL(xPesa.Nenvs, 0)
817:                     loc_nQtds    = NVL(xPesa.Qtds, 0)
818:                     loc_nPesoFixs = 0
819:                     SELECT xRateio_4c
820:                     IF SEEK(loc_nNenv) AND NVL(xRateio_4c.Pesos, 0) <> 0 AND xRateio_4c.Qtds <> 0
821:                         loc_nPesoFixs = (xRateio_4c.Pesos / xRateio_4c.Qtds) * loc_nQtds
822:                         SELECT xPesa
823:                         REPLACE xPesa.PesoFixs WITH loc_nPesoFixs
824:                     ENDIF
825:                     SELECT xPesa
826:                 ENDSCAN
827:             ENDIF
828: 
829:             IF USED("xRateio_4c")
830:                 USE IN xRateio_4c
831:             ENDIF
832:             IF USED("tPesa_4c")
833:                 USE IN tPesa_4c
834:             ENDIF
835:             ENDIF && loc_lPesMatPs
836:             ENDIF && USED("xPesa") AND USED("xNensI") AND USED("crSigCdOpd")
837:         CATCH TO loc_oErro
838:             MsgErro(loc_oErro.Message, "Erro ao inicializar PesoFixs")
839:         ENDTRY
840:     ENDPROC

*-- Linhas 858 a 876:
858:         loc_lLibObss = .F.
859:         loc_lModoInserir = .F.
860:         IF USED("crSigCdPam")
861:             SELECT crSigCdPam
862:             GO TOP
863:             IF VARTYPE(crSigCdPam.LibObss) = "L"
864:                 loc_lLibObss = crSigCdPam.LibObss
865:             ELSE
866:                 IF VARTYPE(crSigCdPam.LibObss) = "L"
867:                     loc_lLibObss = crSigCdPam.LibObss
868:                 ELSE
869:                     loc_lLibObss = (NVL(crSigCdPam.LibObss, 0) = 1)
870:                 ENDIF
871:             ENDIF
872:         ENDIF
873:         IF VARTYPE(THIS.this_oPaiForm) = "O"
874:             loc_lModoInserir = (ALLTRIM(THIS.this_oPaiForm.pcEscolha) = "INSERIR")
875:         ENDIF
876:         RETURN loc_lLibObss AND loc_lModoInserir

*-- Linhas 888 a 906:
888:     *==========================================================================
889:     FUNCTION GradeCol4TextWhen()
890:         IF USED("crSigCdPam")
891:             SELECT crSigCdPam
892:             GO TOP
893:             RETURN NVL(crSigCdPam.LibObss, 0) = 1
894:         ENDIF
895:         RETURN .F.
896:     ENDFUNC
897: 
898:     *==========================================================================
899:     * GradeCol4TextKeyPress - Tamanho: F4/F5 abre lookup SigCdTam
900:     *==========================================================================
901:     FUNCTION GradeCol4TextKeyPress(par_nKeyCode, par_nShiftAltCtrl)
902:         IF par_nKeyCode = 115 OR par_nKeyCode = 116  && F4 ou F5
903:             THIS.AbrirLookupTamanho()
904:             RETURN .F.
905:         ENDIF
906:     ENDFUNC

*-- Linhas 925 a 1004:
925:                 loc_cValor = ALLTRIM(NVL(THIS.grd_4c_Itens.Column4.Text1.Value, ""))
926:             ENDIF
927:             IF EMPTY(loc_cValor) AND USED("xPesa")
928:                 SELECT xPesa
929:                 loc_cValor = ALLTRIM(NVL(Tams, ""))
930:             ENDIF
931:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
932:                 "SigCdTam", "cursor_4c_TamBusca", "Cods", loc_cValor, ;
933:                 "Sele" + CHR(231) + CHR(227) + "o de Tamanho", .T.)
934:             IF VARTYPE(loc_oBusca) = "O"
935:                 IF !loc_oBusca.this_lAchouRegistro
936:                     loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
937:                     loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
938:                     loc_oBusca.Show()
939:                 ENDIF
940:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_TamBusca")
941:                     IF USED("xPesa")
942:                         SELECT xPesa
943:                         REPLACE Tams WITH ALLTRIM(cursor_4c_TamBusca.Cods)
944:                     ENDIF
945:                 ENDIF
946:                 loc_oBusca.Release()
947:             ENDIF
948:             IF USED("cursor_4c_TamBusca")
949:                 USE IN cursor_4c_TamBusca
950:             ENDIF
951:         CATCH TO loc_oErro
952:             MsgErro(loc_oErro.Message, "Erro ao buscar tamanho")
953:         ENDTRY
954:         IF VARTYPE(THIS.grd_4c_Itens) = "O"
955:             THIS.grd_4c_Itens.Refresh()
956:         ENDIF
957:     ENDFUNC
958: 
959:     *==========================================================================
960:     * GradeCol5TextWhen - Quantidade: editavel apenas se LibObss <> 1
961:     *==========================================================================
962:     FUNCTION GradeCol5TextWhen()
963:         IF USED("crSigCdPam")
964:             SELECT crSigCdPam
965:             GO TOP
966:             RETURN NVL(crSigCdPam.LibObss, 0) <> 1
967:         ENDIF
968:         RETURN .F.
969:     ENDFUNC
970: 
971:     *==========================================================================
972:     * GradeCol6TextWhen - Peso: salva OldValue, ativa balanca, controla edicao
973:     * Replica Column6.Text1.When do legado
974:     *==========================================================================
975:     FUNCTION GradeCol6TextWhen()
976:         LOCAL loc_lModoInserir, loc_lPesoBals, loc_lTrfPesas
977:         THIS.this_lAlterou = .F.
978:         IF USED("xPesa")
979:             SELECT xPesa
980:             THIS.this_nOldValue = NVL(Peso, 0)
981:         ENDIF
982:         loc_lModoInserir = .F.
983:         loc_lPesoBals    = .F.
984:         loc_lTrfPesas    = .F.
985:         IF VARTYPE(THIS.this_oPaiForm) = "O"
986:             loc_lModoInserir = (ALLTRIM(THIS.this_oPaiForm.pcEscolha) = "INSERIR")
987:         ENDIF
988:         IF USED("crSigCdOpd")
989:             SELECT crSigCdOpd
990:             GO TOP
991:             IF VARTYPE(crSigCdOpd.PesoBals) = "L"
992:                 loc_lPesoBals = crSigCdOpd.PesoBals
993:             ELSE
994:                 IF VARTYPE(crSigCdOpd.PesoBals) = "L"
995:                     loc_lPesoBals = crSigCdOpd.PesoBals
996:                 ELSE
997:                     loc_lPesoBals = (NVL(crSigCdOpd.PesoBals, 0) = 1)
998:                 ENDIF
999:             ENDIF
1000:             IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
1001:                 loc_lTrfPesas = crSigCdOpd.TrfPesas
1002:             ELSE
1003:                 IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
1004:                     loc_lTrfPesas = crSigCdOpd.TrfPesas

*-- Linhas 1018 a 1036:
1018:                 IF NVL(loc_oTxt.Value, 0) <> 0 AND LASTKEY() <> 27 AND ;
1019:                    !THIS.bal_4c_Balanca.TempoEsgotado
1020:                     IF USED("xPesa")
1021:                         SELECT xPesa
1022:                         SKIP
1023:                         IF !EOF()
1024:                             IF USED("crSigCdPam") AND NVL(crSigCdPam.LibObss, 0) = 1
1025:                                 THIS.grd_4c_Itens.Column2.SetFocus()
1026:                             ELSE
1027:                                 THIS.grd_4c_Itens.Column5.SetFocus()
1028:                             ENDIF
1029:                         ENDIF
1030:                     ENDIF
1031:                 ENDIF
1032:             CATCH TO loc_oErro
1033:                 *-- Balanca falhou durante ativacao - continuar com peso manual
1034:             ENDTRY
1035:         ENDIF
1036:         RETURN loc_lModoInserir AND !loc_lPesoBals

*-- Linhas 1047 a 1125:
1047:         loc_nValorAtual = 0
1048:         TRY
1049:             IF USED("xPesa")
1050:                 SELECT xPesa
1051:                 loc_nValorAtual = NVL(Peso, 0)
1052:                 loc_nQtds       = NVL(Qtds, 0)
1053:                 loc_nPesoFixs   = NVL(PesoFixs, 0)
1054:             ENDIF
1055: 
1056:             *-- Sem alteracao ou zero: sem validacao
1057:             IF loc_nValorAtual <> 0 AND loc_nValorAtual <> THIS.this_nOldValue
1058:                 *-- Valor negativo: nao permitido
1059:                 IF loc_nValorAtual < 0
1060:                     MsgAviso("O Peso N" + CHR(227) + "o Pode Ser Um Valor Negativo!!!", "")
1061:                     IF USED("xPesa")
1062:                         SELECT xPesa
1063:                         REPLACE Peso WITH THIS.this_nOldValue
1064:                     ENDIF
1065:                     loc_lValido = .F.
1066:                 ELSE
1067:                     THIS.this_lAlterou = .T.
1068: 
1069:             *-- Verifica tolerancia de diferenca de peso
1070:             IF !THIS.this_oBusinessObject.VerificarDiferencaPeso(loc_nValorAtual)
1071:                 *-- Fora do limite - calcula valores para mensagem
1072:                 loc_nPesagem  = 0
1073:                 loc_nDifPesags = 0
1074:                 IF USED("crSigCdPam")
1075:                     SELECT crSigCdPam
1076:                     GO TOP
1077:                     loc_nDifPesags = NVL(crSigCdPam.DifPesags, 0)
1078:                 ENDIF
1079:                 IF loc_nQtds <> 0
1080:                     loc_nPesagem = (loc_nValorAtual / loc_nQtds) - loc_nPesoFixs
1081:                 ENDIF
1082: 
1083:                 MsgAviso("Peso Diferente do Peso da Tabela e fora do Limite de " + ;
1084:                     TRANSFORM(loc_nDifPesags, "@Z 999.99%") + CHR(13) + ;
1085:                     "Real: " + ALLTRIM(TRANSFORM(loc_nPesagem, "@Z 9999.999")), "")
1086: 
1087:                 IF THIS.this_lLiberaPeso
1088:                     *-- Solicita senha de autorizacao (SigOpSen)
1089:                     LOCAL loc_cRetorno, loc_lOk, loc_cInfo
1090:                     loc_cRetorno = ""
1091:                     loc_cInfo    = "Libera Pesagem R:" + ALLTRIM(TRANSFORM(loc_nPesagem, "@Z999.999"))
1092:                     DO FORM SigOpSen WITH "LIBPESO", loc_cInfo, "" TO loc_cRetorno
1093:                     CLEAR TYPEAHEAD
1094:                     loc_lOk = (LEFT(ALLTRIM(loc_cRetorno), 1) = "*")
1095:                     IF !loc_lOk
1096:                         MsgAviso("Pesagem n" + CHR(227) + "o autorizada!!!", "")
1097:                         IF USED("xPesa")
1098:                             SELECT xPesa
1099:                             REPLACE Peso WITH 0
1100:                         ENDIF
1101:                         loc_lValido = .F.
1102:                     ELSE
1103:                         IF USED("xPesa")
1104:                             SELECT xPesa
1105:                             REPLACE UsuLibs WITH PADR(SUBSTR(loc_cRetorno, 2), 10)
1106:                         ENDIF
1107:                     ENDIF
1108:                 ELSE
1109:                     IF USED("xPesa")
1110:                         SELECT xPesa
1111:                         REPLACE Peso WITH THIS.this_nOldValue
1112:                     ENDIF
1113:                     loc_lValido = .F.
1114:                 ENDIF
1115:             ENDIF && !VerificarDiferencaPeso
1116:                 ENDIF && loc_nValorAtual >= 0
1117:             ENDIF && loc_nValorAtual <> 0
1118:         CATCH TO loc_oErro
1119:             MsgErro(loc_oErro.Message, "Erro na valida" + CHR(231) + CHR(227) + "o do peso")
1120:             loc_lValido = .T.
1121:         ENDTRY
1122:         RETURN loc_lValido
1123:     ENDFUNC
1124: 
1125:     *==========================================================================

*-- Linhas 1131 a 1180:
1131:         LOCAL loc_lEspecial, loc_nNops, loc_cCpros, loc_nCusto
1132:         TRY
1133:             IF USED("xPesa")
1134:                 SELECT xPesa
1135:                 loc_nValorAtual = NVL(Peso, 0)
1136:             ENDIF
1137:             IF loc_nValorAtual <> 0 AND THIS.this_lAlterou
1138:                 SELECT xPesa
1139:                 loc_nRecno    = RECNO()
1140:                 loc_nNenv     = NVL(Nenvs, 0)
1141:                 loc_lEspecial = IIF(VARTYPE(Especial)="L", Especial, NVL(Especial,0)=1)
1142:                 loc_nNops     = NVL(Nops, 0)
1143:                 loc_cCpros    = ALLTRIM(NVL(Cpros, ""))
1144: 
1145:             *-- Distribui rateio de peso entre materiais do envelope
1146:             THIS.this_oBusinessObject.DistribuirRateio(loc_nRecno)
1147: 
1148:             *-- Calcula custo de producao e atualiza xPesa.CustoFs
1149:             loc_nCusto = THIS.this_oBusinessObject.CalcularCustoProducao(loc_nNops, loc_cCpros)
1150:             IF USED("xPesa")
1151:                 SELECT xPesa
1152:                 IF loc_nRecno > 0
1153:                     GO loc_nRecno
1154:                 ENDIF
1155:                 REPLACE CustoFs WITH loc_nCusto
1156:             ENDIF
1157: 
1158:             *-- Peca especial: processa composicao SigPrCpo
1159:             IF loc_lEspecial
1160:                 THIS.ProcessarPesoEspecial(loc_nNenv, loc_nNops, loc_cCpros, loc_nRecno)
1161:             ENDIF
1162: 
1163:             *-- Navegacao: avanca para proxima peca
1164:             IF USED("xPesa")
1165:                 SELECT xPesa
1166:                 IF loc_nRecno > 0
1167:                     GO loc_nRecno
1168:                 ENDIF
1169:                 SKIP
1170:                 KEYBOARD "{DOWNARROW}"
1171:                 IF EOF("xPesa")
1172:                     IF VARTYPE(THIS.cmd_4c_Resumo) = "O"
1173:                         THIS.cmd_4c_Resumo.SetFocus()
1174:                     ENDIF
1175:                 ELSE
1176:                     IF USED("crSigCdPam") AND NVL(crSigCdPam.LibObss, 0) = 1
1177:                         THIS.grd_4c_Itens.Column2.SetFocus()
1178:                     ELSE
1179:                         THIS.grd_4c_Itens.Column5.SetFocus()
1180:                         KEYBOARD "{LEFTARROW}"

*-- Linhas 1192 a 1210:
1192:     *==========================================================================
1193:     FUNCTION GradeCol7TextWhen()
1194:         IF USED("crSigCdPam")
1195:             SELECT crSigCdPam
1196:             GO TOP
1197:             RETURN NVL(crSigCdPam.LibObss, 0) = 1
1198:         ENDIF
1199:         RETURN .F.
1200:     ENDFUNC
1201: 
1202:     *==========================================================================
1203:     * GradeCol7TextKeyPress - Cor: F4/F5 abre lookup SigCdCor
1204:     *==========================================================================
1205:     FUNCTION GradeCol7TextKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1206:         IF par_nKeyCode = 115 OR par_nKeyCode = 116  && F4 ou F5
1207:             THIS.AbrirLookupCor()
1208:             RETURN .F.
1209:         ENDIF
1210:     ENDFUNC

*-- Linhas 1229 a 1261:
1229:                 loc_cValor = ALLTRIM(NVL(THIS.grd_4c_Itens.Column7.Text1.Value, ""))
1230:             ENDIF
1231:             IF EMPTY(loc_cValor) AND USED("xPesa")
1232:                 SELECT xPesa
1233:                 loc_cValor = ALLTRIM(NVL(Cors, ""))
1234:             ENDIF
1235:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1236:                 "SigCdCor", "cursor_4c_CorBusca", "Cods", loc_cValor, ;
1237:                 "Sele" + CHR(231) + CHR(227) + "o de Cor", .T.)
1238:             IF VARTYPE(loc_oBusca) = "O"
1239:                 IF !loc_oBusca.this_lAchouRegistro
1240:                     loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
1241:                     loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1242:                     loc_oBusca.Show()
1243:                 ENDIF
1244:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_CorBusca")
1245:                     IF USED("xPesa")
1246:                         SELECT xPesa
1247:                         REPLACE Cors WITH ALLTRIM(cursor_4c_CorBusca.Cods)
1248:                     ENDIF
1249:                 ENDIF
1250:                 loc_oBusca.Release()
1251:             ENDIF
1252:             IF USED("cursor_4c_CorBusca")
1253:                 USE IN cursor_4c_CorBusca
1254:             ENDIF
1255:         CATCH TO loc_oErro
1256:             MsgErro(loc_oErro.Message, "Erro ao buscar cor")
1257:         ENDTRY
1258:         IF VARTYPE(THIS.grd_4c_Itens) = "O"
1259:             THIS.grd_4c_Itens.Refresh()
1260:         ENDIF
1261:     ENDFUNC

*-- Linhas 1281 a 1302:
1281:         LOCAL loc_nRecno, loc_oErro
1282:         TRY
1283:             IF fChecaAcesso(THIS.this_cProgAcesso, "CUSTOP") AND USED("xPesa")
1284:                 SELECT xPesa
1285:                 loc_nRecno = RECNO()
1286:                 DO FORM SigCdPro WITH "PESAGEM", ALLTRIM(NVL(Cpros, ""))
1287:                 SELECT xPesa
1288:                 IF loc_nRecno > 0
1289:                     GO loc_nRecno
1290:                 ENDIF
1291:             ENDIF
1292:         CATCH TO loc_oErro
1293:             MsgErro(loc_oErro.Message, "Erro ao abrir produto")
1294:         ENDTRY
1295:     ENDPROC
1296: 
1297:     *==========================================================================
1298:     * TxtEspecialWhen - Indicador visual de peca especial (ReadOnly decorativo)
1299:     *==========================================================================
1300:     FUNCTION TxtEspecialWhen()
1301:         RETURN .F.
1302:     ENDFUNC

*-- Linhas 1341 a 1359:
1341:                 MsgAviso("Cursor de pesagem n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Aviso")
1342:                 RETURN
1343:             ENDIF
1344:             SELECT xPesa
1345:             APPEND BLANK
1346:             REPLACE Peso WITH 0, Qtds WITH 1
1347:             THIS.this_lAlterou = .T.
1348:             IF VARTYPE(THIS.grd_4c_Itens) = "O"
1349:                 THIS.grd_4c_Itens.Refresh()
1350:                 THIS.grd_4c_Itens.SetFocus()
1351:             ENDIF
1352:         CATCH TO loc_oErro
1353:             MsgErro(loc_oErro.Message, "Erro ao incluir pe" + CHR(231) + "a")
1354:         ENDTRY
1355:     ENDPROC
1356: 
1357:     *==========================================================================
1358:     * BtnAlterarClick - Foca grade na pe" + CHR(231) + "a corrente para editar peso
1359:     * Form OPERACIONAL: Alterar = editar peso da pe" + CHR(231) + "a corrente

*-- Linhas 1370 a 1388:
1370:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " pe" + CHR(231) + "as para alterar.", "Aviso")
1371:                 RETURN
1372:             ENDIF
1373:             SELECT xPesa
1374:             IF EOF() OR BOF()
1375:                 GO TOP
1376:             ENDIF
1377:             THIS.this_lAlterou = .T.
1378:             IF VARTYPE(THIS.grd_4c_Itens) = "O"
1379:                 THIS.grd_4c_Itens.SetFocus()
1380:                 IF PEMSTATUS(THIS.grd_4c_Itens, "Column6", 5)
1381:                     THIS.grd_4c_Itens.Column6.SetFocus()
1382:                 ENDIF
1383:             ENDIF
1384:         CATCH TO loc_oErro
1385:             MsgErro(loc_oErro.Message, "Erro ao alterar pe" + CHR(231) + "a")
1386:         ENDTRY
1387:     ENDPROC
1388: 

*-- Linhas 1401 a 1427:
1401:                 MsgAviso("Sem permiss" + CHR(227) + "o para visualizar custo.", "Aviso")
1402:                 RETURN
1403:             ENDIF
1404:             SELECT xPesa
1405:             loc_nRecno = RECNO()
1406:             loc_cCpros = ALLTRIM(NVL(Cpros, ""))
1407:             IF EMPTY(loc_cCpros)
1408:                 MsgAviso("Pe" + CHR(231) + "a sem produto associado.", "Aviso")
1409:                 RETURN
1410:             ENDIF
1411:             DO FORM SigCdPro WITH "PESAGEM", loc_cCpros
1412:             SELECT xPesa
1413:             IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT()
1414:                 GO loc_nRecno
1415:             ENDIF
1416:             IF VARTYPE(THIS.grd_4c_Itens) = "O"
1417:                 THIS.grd_4c_Itens.Refresh()
1418:             ENDIF
1419:         CATCH TO loc_oErro
1420:             MsgErro(loc_oErro.Message, "Erro ao visualizar pe" + CHR(231) + "a")
1421:         ENDTRY
1422:     ENDPROC
1423: 
1424:     *==========================================================================
1425:     * BtnExcluirClick - Zera peso da pe" + CHR(231) + "a corrente (desfaz pesagem)
1426:     * Form OPERACIONAL: Excluir zera Peso e PesoFixs da linha corrente
1427:     *==========================================================================

*-- Linhas 1437 a 1463:
1437:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " pe" + CHR(231) + "a para excluir.", "Aviso")
1438:                 RETURN
1439:             ENDIF
1440:             SELECT xPesa
1441:             IF EOF() OR BOF()
1442:                 GO TOP
1443:             ENDIF
1444:             loc_lConfirma = MsgConfirma("Confirma desfazer a pesagem desta pe" + CHR(231) + "a?", "Confirma" + CHR(231) + CHR(227) + "o")
1445:             IF !loc_lConfirma
1446:                 RETURN
1447:             ENDIF
1448:             SELECT xPesa
1449:             REPLACE Peso WITH 0
1450:             IF TYPE("xPesa.PesoFixs") <> "U"
1451:                 REPLACE PesoFixs WITH 0
1452:             ENDIF
1453:             THIS.this_lAlterou = .T.
1454:             THIS.this_nOldValue = 0
1455:             IF VARTYPE(THIS.grd_4c_Itens) = "O"
1456:                 THIS.grd_4c_Itens.Refresh()
1457:                 THIS.grd_4c_Itens.SetFocus()
1458:             ENDIF
1459:         CATCH TO loc_oErro
1460:             MsgErro(loc_oErro.Message, "Erro ao excluir pesagem")
1461:         ENDTRY
1462:     ENDPROC
1463: 

*-- Linhas 1478 a 1499:
1478:                VARTYPE(THIS.this_oPaiForm) = "O" AND ;
1479:                INLIST(ALLTRIM(THIS.this_oPaiForm.pcEscolha), "INSERIR", "ALTERAR")
1480:                 IF USED("xPesa")
1481:                     SELECT xPesa
1482:                     loc_nRecno = RECNO()
1483:                     DO FORM SigCdPro WITH "PESAGEM", ALLTRIM(NVL(Cpros, ""))
1484:                     SELECT xPesa
1485:                     IF loc_nRecno > 0
1486:                         LOCATE FOR RECNO() = loc_nRecno
1487:                     ENDIF
1488:                 ENDIF
1489:             ENDIF
1490:             IF VARTYPE(THIS.grd_4c_Itens) = "O"
1491:                 THIS.grd_4c_Itens.SetFocus()
1492:             ENDIF
1493:         CATCH TO loc_oErro
1494:             MsgErro(loc_oErro.Message, "Erro ao abrir custo de produto")
1495:         ENDTRY
1496:     ENDPROC
1497: 
1498:     *==========================================================================
1499:     * BtnProcessarClick - Valida que todas as pecas foram pesadas e encerra

*-- Linhas 1507 a 1525:
1507:             IF VARTYPE(THIS.this_oPaiForm) = "O" AND ;
1508:                ALLTRIM(THIS.this_oPaiForm.pcEscolha) = "INSERIR"
1509:                 IF USED("xPesa")
1510:                     SELECT xPesa
1511:                     SCAN
1512:                         IF NVL(Peso, 0) = 0
1513:                             MsgAviso("Existe Uma Pe" + CHR(231) + "a Que N" + CHR(227) + ;
1514:                                      "o Foi Pesada!!!", "")
1515:                             IF VARTYPE(THIS.grd_4c_Itens) = "O"
1516:                                 THIS.grd_4c_Itens.Refresh()
1517:                             ENDIF
1518:                             loc_lPodeProsseguir = .F.
1519:                             EXIT
1520:                         ENDIF
1521:                     ENDSCAN
1522:                 ENDIF
1523:             ENDIF
1524: 
1525:             IF loc_lPodeProsseguir AND USED("xNensiS") AND RECCOUNT("xNensiS") > 0

*-- Linhas 1583 a 1601:
1583:         LOCAL loc_oErro
1584:         TRY
1585:             IF USED("xPesa")
1586:                 SELECT xPesa
1587:                 GO TOP
1588:             ENDIF
1589:             IF VARTYPE(THIS.grd_4c_Itens) = "O"
1590:                 THIS.grd_4c_Itens.Refresh()
1591:             ENDIF
1592:         CATCH TO loc_oErro
1593:             MsgErro(loc_oErro.Message, "Erro ao alternar p" + CHR(225) + "gina")
1594:         ENDTRY
1595:     ENDPROC
1596: 
1597:     *==========================================================================
1598:     * ProcessarPesoEspecial - Logica de composicao para peca especial
1599:     * Constroi CrTmpCompo a partir de CrSigCdNei + servicos externos
1600:     * Grava SigPrCpo e abre SigCdPro para revisao
1601:     * Replica logica da secao IF xpesa.Especial de Column6.Text1.LostFocus

*-- Linhas 1610 a 1800:
1610:         loc_lSucesso = .F.
1611:         TRY
1612:             *-- 1. Tipo de materia prima do grupo do produto (MtPrimas)
1613:             loc_cSQL = "SELECT b.mtprimas FROM SigCdPro a " + ;
1614:                        "JOIN SigCdGrp b ON a.Cgrus = b.Cgrus " + ;
1615:                        "WHERE a.Cpros = " + EscaparSQL(par_cCpros)
1616:             IF USED("cursor_4c_EspGruTip")
1617:                 USE IN cursor_4c_EspGruTip
1618:             ENDIF
1619:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EspGruTip")
1620:             loc_nMtPrimas = 0
1621:             IF loc_nRet >= 1
1622:                 SELECT cursor_4c_EspGruTip
1623:                 GO TOP
1624:                 loc_nMtPrimas = NVL(MtPrimas, 0)
1625:                 USE IN cursor_4c_EspGruTip
1626:             ENDIF
1627: 
1628:             *-- 2. Carrega composicao atual do SQL Server em CrTmpCompo
1629:             loc_cSQL = "SELECT * FROM SigPrCpo WHERE Cpros = " + EscaparSQL(par_cCpros)
1630:             IF USED("CrTmpCompo")
1631:                 USE IN CrTmpCompo
1632:             ENDIF
1633:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "CrTmpCompo")
1634:             IF loc_nRet >= 1
1635:             *-- Indexa por Mats e reseta TpAlts
1636:             SELECT CrTmpCompo
1637:             INDEX ON ALLTRIM(NVL(Mats, "")) TAG Mats
1638:             REPLACE ALL TpAlts WITH 0
1639: 
1640:             *-- 3. Servicos do cadastro (SigCdSvc)
1641:             loc_cSQL = "SELECT Mats, cCats FROM SigCdSvc WHERE Mats <> ' '"
1642:             IF USED("CsTmpSer")
1643:                 USE IN CsTmpSer
1644:             ENDIF
1645:             SQLEXEC(gnConnHandle, loc_cSQL, "CsTmpSer")
1646:             IF USED("CsTmpSer")
1647:                 SELECT CsTmpSer
1648:                 INDEX ON ALLTRIM(NVL(Mats, "")) TAG Mats
1649:             ENDIF
1650: 
1651:             *-- 4. Servicos do envelope (SigCdNei JOIN SigCdSvc para o nenvs atual)
1652:             loc_cSQL = "SELECT b.cpros, SUM(a.Qtds) AS Qtds " + ;
1653:                        "FROM SigCdNei a JOIN SigCdSvc b ON a.cMats = b.ccats " + ;
1654:                        "WHERE a.Nenvs = " + FormatarNumeroSQL(par_nNenv) + ;
1655:                        " AND a.Servicos = 1 AND a.cMats <> ' ' AND b.Cpros <> ' ' " + ;
1656:                        "GROUP BY b.cpros"
1657:             IF USED("CsxNensi")
1658:                 USE IN CsxNensi
1659:             ENDIF
1660:             SQLEXEC(gnConnHandle, loc_cSQL, "CsxNensi")
1661: 
1662:             *-- 5. Se MtPrimas=3: inclui materiais de CrSigCdNei que sao servicos
1663:             IF loc_nMtPrimas = 3 AND USED("CrSigCdNei") AND USED("CsTmpSer") AND USED("CsxNensi")
1664:                 IF USED("CszNensi")
1665:                     USE IN CszNensi
1666:                 ENDIF
1667:                 SELECT PADR(b.Mats, 14) AS Cpros, SUM(a.Qtds) AS Qtds ;
1668:                   FROM CrSigCdNei a, CsTmpSer b ;
1669:                  WHERE a.CMats = b.Mats AND a.Nenvs = par_nNenv ;
1670:                  GROUP BY 1 HAVING SUM(a.Qtds) > 0 ;
1671:                   INTO CURSOR CszNensi
1672:                 IF RECCOUNT("CszNensi") > 0
1673:                     SELECT CsxNensi
1674:                     APPEND FROM DBF("CszNensi")
1675:                 ENDIF
1676:                 IF USED("CszNensi")
1677:                     USE IN CszNensi
1678:                 ENDIF
1679:             ENDIF
1680: 
1681:             *-- 6. Operacoes de inspecao via SigOpOeo (SigMvItn/SigInBep/SigOpPic)
1682:             loc_cSQL = "SELECT dopes FROM SigOpOeo"
1683:             IF USED("TmpEOpp_4c")
1684:                 USE IN TmpEOpp_4c
1685:             ENDIF
1686:             SQLEXEC(gnConnHandle, loc_cSQL, "TmpEOpp_4c")
1687:             loc_lTemOpEopp = USED("TmpEOpp_4c") AND RECCOUNT("TmpEOpp_4c") > 0
1688: 
1689:             IF loc_lTemOpEopp AND USED("CsxNensi")
1690:                 loc_cSQL = "SELECT a.cpros, SUM(a.qtds) AS Qtds " + ;
1691:                            "FROM SigMvItn a " + ;
1692:                            "JOIN SigInBep b ON a.empDopNums = b.EmpDopNums " + ;
1693:                            "JOIN SigCdNei c ON b.empdnps = c.empdnps " + ;
1694:                            "JOIN SigOpPic d ON c.Nops = d.Nops " + ;
1695:                            "JOIN SigCdSvc e ON a.Cpros = e.ccats " + ;
1696:                            "WHERE c.nenvs = " + FormatarNumeroSQL(par_nNenv) + ;
1697:                            " AND a.cpro2s = d.Cpros " + ;
1698:                            "GROUP BY a.Cpros"
1699:                 IF USED("CsTmp3_4c")
1700:                     USE IN CsTmp3_4c
1701:                 ENDIF
1702:                 SQLEXEC(gnConnHandle, loc_cSQL, "CsTmp3_4c")
1703:                 IF USED("CsTmp3_4c") AND RECCOUNT("CsTmp3_4c") > 0
1704:                     SELECT CsxNensi
1705:                     APPEND FROM DBF("CsTmp3_4c")
1706:                 ENDIF
1707:                 IF USED("CsTmp3_4c")
1708:                     USE IN CsTmp3_4c
1709:                 ENDIF
1710:             ENDIF
1711:             IF USED("TmpEOpp_4c")
1712:                 USE IN TmpEOpp_4c
1713:             ENDIF
1714: 
1715:             *-- 7. Processa CrSigCdNei: atualiza ou insere em CrTmpCompo
1716:             IF USED("CrSigCdNei")
1717:                 SELECT CrSigCdNei
1718:                 SCAN FOR NVL(Nops, 0) = par_nNops
1719:                     IF EMPTY(ALLTRIM(NVL(CMats, ""))) OR ;
1720:                        IIF(VARTYPE(Servicos)="L", Servicos, NVL(Servicos,0)=1)
1721:                         LOOP
1722:                     ENDIF
1723:                     loc_cCMats = ALLTRIM(NVL(CMats, ""))
1724:                     loc_nPeso2 = NVL(Peso2s, 0)
1725:                     loc_nQtds  = NVL(Qtds, 0)
1726: 
1727:                     *-- Dados do produto/grupo do material
1728:                     loc_cSQL = "SELECT p.Dpros, p.Cunis, p.cUniPs, p.Cgrus, p.CustoFs, p.MoeCusFs " + ;
1729:                                "FROM SigCdPro p WHERE p.Cpros = " + EscaparSQL(loc_cCMats)
1730:                     SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EspPro")
1731:                     loc_cSQL = "SELECT g.EtiPads FROM SigCdGrp g " + ;
1732:                                "JOIN SigCdPro p ON p.Cgrus = g.Cgrus " + ;
1733:                                "WHERE p.Cpros = " + EscaparSQL(loc_cCMats)
1734:                     SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EspGrp")
1735:                     *-- Verifica Peso2s: se unidade tem Fators=0 e QtEqualPs<>'S', usa pesos do movimento
1736:                     loc_cSQL = "SELECT u.Fators, u.QtEqualPs FROM SigCdUni u " + ;
1737:                                "JOIN SigCdPro p ON p.Cunis = u.cUnis " + ;
1738:                                "WHERE p.Cpros = " + EscaparSQL(loc_cCMats)
1739:                     SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EspUni")
1740:                     IF loc_nPeso2 = 0 AND USED("cursor_4c_EspUni")
1741:                         SELECT cursor_4c_EspUni
1742:                         GO TOP
1743:                         IF !EOF() AND NVL(Fators,0)=0 AND ALLTRIM(NVL(QtEqualPs,""))<>"S"
1744:                             SELECT CrSigCdNei
1745:                             loc_nPeso2 = NVL(Pesos, 0)
1746:                         ENDIF
1747:                     ENDIF
1748: 
1749:                     *-- Atualiza CrTmpCompo
1750:                     SELECT CrTmpCompo
1751:                     IF SEEK(loc_cCMats)
1752:                         IF NVL(TpAlts, 0) = 0
1753:                             REPLACE Qtds WITH loc_nQtds, Pesos WITH loc_nPeso2, TpAlts WITH 1
1754:                         ELSE
1755:                             IF NVL(TpAlts, 0) > 0
1756:                                 REPLACE Qtds WITH NVL(Qtds,0)+loc_nQtds, Pesos WITH NVL(Pesos,0)+loc_nPeso2
1757:                             ENDIF
1758:                         ENDIF
1759:                     ELSE
1760:                         APPEND BLANK
1761:                         loc_cDpros    = ""
1762:                         loc_cCunis    = ""
1763:                         loc_cCuniPs   = ""
1764:                         loc_cCgrus2   = ""
1765:                         loc_nCustoFs  = 0
1766:                         loc_cMoeCusFs = ""
1767:                         loc_cEtiPads  = ""
1768:                         IF USED("cursor_4c_EspPro")
1769:                             SELECT cursor_4c_EspPro
1770:                             GO TOP
1771:                             loc_cDpros    = ALLTRIM(NVL(Dpros,    ""))
1772:                             loc_cCunis    = ALLTRIM(NVL(Cunis,    ""))
1773:                             loc_cCuniPs   = ALLTRIM(NVL(cUniPs,   ""))
1774:                             loc_cCgrus2   = ALLTRIM(NVL(Cgrus,    ""))
1775:                             loc_nCustoFs  = NVL(CustoFs,   0)
1776:                             loc_cMoeCusFs = ALLTRIM(NVL(MoeCusFs, ""))
1777:                         ENDIF
1778:                         IF USED("cursor_4c_EspGrp")
1779:                             SELECT cursor_4c_EspGrp
1780:                             GO TOP
1781:                             IF !EOF()
1782:                                 loc_cEtiPads = ALLTRIM(NVL(EtiPads, ""))
1783:                             ENDIF
1784:                         ENDIF
1785:                         SELECT CrTmpCompo
1786:                         REPLACE cpros     WITH par_cCpros,   ;
1787:                                 Mats      WITH loc_cCMats,   ;
1788:                                 Qtds      WITH loc_nQtds,    ;
1789:                                 Pesos     WITH loc_nPeso2,   ;
1790:                                 dcompos   WITH loc_cDpros,   ;
1791:                                 UniCompos WITH loc_cCunis,   ;
1792:                                 cUniPs    WITH loc_cCuniPs,  ;
1793:                                 cgrus     WITH loc_cCgrus2,  ;
1794:                                 pcompos   WITH loc_nCustoFs, ;
1795:                                 Moeds     WITH loc_cMoeCusFs,;
1796:                                 DtMovs    WITH DATETIME(),   ;
1797:                                 TpAlts    WITH 2,            ;
1798:                                 cIdChaves WITH ALLTRIM(fUniqueIds()), ;
1799:                                 Etiqs     WITH loc_cEtiPads
1800:                     ENDIF

*-- Linhas 1807 a 1970:
1807:                     IF USED("cursor_4c_EspUni")
1808:                         USE IN cursor_4c_EspUni
1809:                     ENDIF
1810:                     SELECT CrSigCdNei
1811:                 ENDSCAN
1812:             ENDIF
1813: 
1814:             *-- 8. Processa CsxNensi: servicos de producao
1815:             IF USED("CsxNensi")
1816:                 SELECT CsxNensi
1817:                 GO TOP
1818:                 DO WHILE !EOF()
1819:                     loc_cSvcCpros = ALLTRIM(NVL(CsxNensi.cpros, ""))
1820:                     loc_nSvcQtds  = NVL(CsxNensi.Qtds, 0)
1821:                     loc_cSQL = "SELECT p.Dpros, p.Cunis, p.cUniPs, p.Cgrus, p.CustoFs, p.MoeCusFs " + ;
1822:                                "FROM SigCdPro p WHERE p.Cpros = " + EscaparSQL(loc_cSvcCpros)
1823:                     SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SvcPro")
1824:                     loc_cSQL = "SELECT g.EtiPads FROM SigCdGrp g " + ;
1825:                                "JOIN SigCdPro p ON p.Cgrus = g.Cgrus " + ;
1826:                                "WHERE p.Cpros = " + EscaparSQL(loc_cSvcCpros)
1827:                     SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SvcGrp")
1828:                     IF USED("CrTmpCompo")
1829:                         SELECT CrTmpCompo
1830:                         IF SEEK(loc_cSvcCpros)
1831:                             IF NVL(TpAlts, 0) = 0
1832:                                 REPLACE Qtds WITH loc_nSvcQtds, TpAlts WITH 1
1833:                             ELSE
1834:                                 IF NVL(TpAlts, 0) > 0
1835:                                     REPLACE Qtds WITH NVL(Qtds, 0) + loc_nSvcQtds
1836:                                 ENDIF
1837:                             ENDIF
1838:                         ELSE
1839:                             APPEND BLANK
1840:                             loc_cSvcEtiPads  = ""
1841:                             loc_cSvcDpros    = ""
1842:                             loc_cSvcCunis    = ""
1843:                             loc_cSvcCuniPs   = ""
1844:                             loc_cSvcCgrus    = ""
1845:                             loc_nSvcCustoFs  = 0
1846:                             loc_cSvcMoeCusFs = ""
1847:                             IF USED("cursor_4c_SvcPro")
1848:                                 SELECT cursor_4c_SvcPro
1849:                                 GO TOP
1850:                                 loc_cSvcDpros    = ALLTRIM(NVL(Dpros,    ""))
1851:                                 loc_cSvcCunis    = ALLTRIM(NVL(Cunis,    ""))
1852:                                 loc_cSvcCuniPs   = ALLTRIM(NVL(cUniPs,   ""))
1853:                                 loc_cSvcCgrus    = ALLTRIM(NVL(Cgrus,    ""))
1854:                                 loc_nSvcCustoFs  = NVL(CustoFs,   0)
1855:                                 loc_cSvcMoeCusFs = ALLTRIM(NVL(MoeCusFs, ""))
1856:                             ENDIF
1857:                             IF USED("cursor_4c_SvcGrp")
1858:                                 SELECT cursor_4c_SvcGrp
1859:                                 GO TOP
1860:                                 IF !EOF()
1861:                                     loc_cSvcEtiPads = ALLTRIM(NVL(EtiPads, ""))
1862:                                 ENDIF
1863:                             ENDIF
1864:                             SELECT CrTmpCompo
1865:                             REPLACE cpros     WITH par_cCpros,      ;
1866:                                     Mats      WITH loc_cSvcCpros,   ;
1867:                                     Qtds      WITH loc_nSvcQtds,    ;
1868:                                     Pesos     WITH 0,               ;
1869:                                     dcompos   WITH loc_cSvcDpros,   ;
1870:                                     UniCompos WITH loc_cSvcCunis,   ;
1871:                                     cUniPs    WITH loc_cSvcCuniPs,  ;
1872:                                     cgrus     WITH loc_cSvcCgrus,   ;
1873:                                     pcompos   WITH loc_nSvcCustoFs, ;
1874:                                     Moeds     WITH loc_cSvcMoeCusFs,;
1875:                                     DtMovs    WITH DATETIME(),      ;
1876:                                     TpAlts    WITH 2,               ;
1877:                                     cIdChaves WITH ALLTRIM(fUniqueIds()), ;
1878:                                     Etiqs     WITH loc_cSvcEtiPads
1879:                         ENDIF
1880:                     ENDIF
1881:                     IF USED("cursor_4c_SvcPro")
1882:                         USE IN cursor_4c_SvcPro
1883:                     ENDIF
1884:                     IF USED("cursor_4c_SvcGrp")
1885:                         USE IN cursor_4c_SvcGrp
1886:                     ENDIF
1887:                     SELECT CsxNensi
1888:                     SKIP
1889:                 ENDDO
1890:                 USE IN CsxNensi
1891:             ENDIF
1892:             IF USED("CsTmpSer")
1893:                 USE IN CsTmpSer
1894:             ENDIF
1895: 
1896:             *-- 9. Remove itens que nao devem ser gravados (TpAlts=0, CEstoqs=1, ImpOps=1)
1897:             IF USED("CrTmpCompo")
1898:                 SELECT CrTmpCompo
1899:                 GO TOP
1900:                 DO WHILE !EOF()
1901:                     IF NVL(TpAlts, 0) = 0
1902:                         loc_cSQL = "SELECT g.CEstoqs, g.ImpOps FROM SigCdGrp g " + ;
1903:                                    "JOIN SigCdPro p ON p.Cgrus = g.Cgrus " + ;
1904:                                    "WHERE p.Cpros = " + EscaparSQL(ALLTRIM(NVL(Mats, "")))
1905:                         loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EspFilt")
1906:                         IF loc_nRet >= 1 AND USED("cursor_4c_EspFilt")
1907:                             SELECT cursor_4c_EspFilt
1908:                             GO TOP
1909:                             IF NVL(CEstoqs, 0) = 1 AND NVL(ImpOps, 0) = 1
1910:                                 SELECT CrTmpCompo
1911:                                 DELETE
1912:                             ENDIF
1913:                             USE IN cursor_4c_EspFilt
1914:                         ENDIF
1915:                     ENDIF
1916:                     SELECT CrTmpCompo
1917:                     SKIP
1918:                 ENDDO
1919:             ENDIF
1920: 
1921:             *-- 10. Grava composicao especial no SQL Server
1922:             loc_lSucesso = THIS.this_oBusinessObject.GravarComposicaoEspecial("CrTmpCompo")
1923: 
1924:             IF loc_lSucesso
1925:                 *-- Abre form de produto para revisao da composicao
1926:                 DO FORM SigCdPro WITH "PESAGEM", par_cCpros
1927:             ELSE
1928:                 MsgErro("Falha ao gravar composi" + CHR(231) + CHR(227) + "o especial.", "Erro")
1929:             ENDIF
1930: 
1931:             *-- Reposiciona xPesa no registro original
1932:             IF USED("xPesa") AND par_nRecno > 0
1933:                 SELECT xPesa
1934:                 GO par_nRecno
1935:             ENDIF
1936: 
1937:             IF USED("CrTmpCompo")
1938:                 USE IN CrTmpCompo
1939:             ENDIF
1940:             ENDIF && loc_nRet >= 1
1941:         CATCH TO loc_oErro
1942:             MsgErro(loc_oErro.Message, "Erro ao processar pe" + CHR(231) + "a especial")
1943:         ENDTRY
1944:     ENDPROC
1945: 
1946:     *==========================================================================
1947:     * CarregarLista - Atualiza o grid com os dados do cursor xPesa
1948:     * Form OPERACIONAL: xPesa ja vem pre-carregado do form pai.
1949:     * Este metodo apenas reposiciona e rebind o RecordSource quando necessario.
1950:     *==========================================================================
1951:     PROCEDURE CarregarLista()
1952:         LOCAL loc_oErro
1953:         TRY
1954:             IF USED("xPesa") AND VARTYPE(THIS.grd_4c_Itens) = "O"
1955:                 SELECT xPesa
1956:                 GO TOP
1957:                 WITH THIS.grd_4c_Itens
1958:                     .RecordSource = "xPesa"
1959:                     .Column1.Header1.Caption = "Produto"
1960:                     .Column2.Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
1961:                     .Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
1962:                     .Column4.Header1.Caption = "Tam"
1963:                     .Column5.Header1.Caption = "Quantidade"
1964:                     .Column6.Header1.Caption = "Peso"
1965:                     .Column7.Header1.Caption = "Cor"
1966:                     .Column8.Header1.Caption = "Barras"
1967:                     .Column9.Header1.Caption = "Custo"
1968:                     .Refresh()
1969:                 ENDWITH
1970:             ENDIF

*-- Linhas 2019 a 2037:
2019:         THIS.this_oBusinessObject.this_nOldValue      = THIS.this_nOldValue
2020:         THIS.this_oBusinessObject.this_lLiberaPeso    = THIS.this_lLiberaPeso
2021:         IF USED("xPesa")
2022:             SELECT xPesa
2023:             THIS.this_oBusinessObject.this_cCpros   = ALLTRIM(NVL(Cpros,    ""))
2024:             THIS.this_oBusinessObject.this_cObs     = ALLTRIM(NVL(Obs,      ""))
2025:             THIS.this_oBusinessObject.this_cOper    = ALLTRIM(NVL(Oper,     ""))
2026:             THIS.this_oBusinessObject.this_nQtds    = NVL(Qtds,    0)
2027:             THIS.this_oBusinessObject.this_nPeso    = NVL(Peso,    0)
2028:             THIS.this_oBusinessObject.this_cTams    = ALLTRIM(NVL(Tams,     ""))
2029:             THIS.this_oBusinessObject.this_cCors    = ALLTRIM(NVL(Cors,     ""))
2030:             THIS.this_oBusinessObject.this_cCbars   = ALLTRIM(NVL(Cbars,    ""))
2031:             THIS.this_oBusinessObject.this_nCustoFs = NVL(CustoFs, 0)
2032:             THIS.this_oBusinessObject.this_nNops    = NVL(Nops,    0)
2033:             THIS.this_oBusinessObject.this_nNenvs   = NVL(Nenvs,   0)
2034:             THIS.this_oBusinessObject.this_nPesoFixs = NVL(PesoFixs, 0)
2035:             THIS.this_oBusinessObject.this_lEspecial = IIF(VARTYPE(Especial)="L", Especial, NVL(Especial,0)=1)
2036:         ENDIF
2037:     ENDPROC

*-- Linhas 2060 a 2078:
2060:         LOCAL loc_lLibObss
2061:         loc_lLibObss = .F.
2062:         IF USED("crSigCdPam")
2063:             SELECT crSigCdPam
2064:             GO TOP
2065:             IF VARTYPE(crSigCdPam.LibObss) = "L"
2066:                 loc_lLibObss = crSigCdPam.LibObss
2067:             ELSE
2068:                 IF VARTYPE(crSigCdPam.LibObss) = "L"
2069:                     loc_lLibObss = crSigCdPam.LibObss
2070:                 ELSE
2071:                     loc_lLibObss = (NVL(crSigCdPam.LibObss, 0) = 1)
2072:                 ENDIF
2073:             ENDIF
2074:         ENDIF
2075:         IF VARTYPE(THIS.txt_4c_PesoMedio) = "O"
2076:             THIS.txt_4c_PesoMedio.ReadOnly = !par_lHabilitar
2077:         ENDIF
2078:         IF VARTYPE(THIS.grd_4c_Itens) = "O"

*-- Linhas 2098 a 2116:
2098:             THIS.txt_4c_PesoMedio.Value = 0
2099:         ENDIF
2100:         IF USED("xPesa") AND VARTYPE(THIS.grd_4c_Itens) = "O"
2101:             SELECT xPesa
2102:             GO TOP
2103:             THIS.grd_4c_Itens.Refresh()
2104:         ENDIF
2105:     ENDPROC
2106: 
2107:     *==========================================================================
2108:     * BtnSalvarClick - Equivalente a BtnProcessarClick para forms OPERACIONAIS
2109:     * Confirma a pesagem e encerra o form (chamado pelo FormBase se necessario)
2110:     *==========================================================================
2111:     PROCEDURE BtnSalvarClick()
2112:         THIS.BtnProcessarClick()
2113:     ENDPROC
2114: 
2115:     *==========================================================================
2116:     * BtnBuscarClick - Recarrega/reposiciona o grid com os dados do cursor xPesa


### BO (C:\4c\projeto\app\classes\SigPdMp9BO.prg):
*------------------------------------------------------------------------------
* SigPdMp9BO.prg - Business Object: Pesagem de Pe" + CHR(231) + "as
* Herda de BusinessBase
* Tabela principal: SigPrCpo (composi" + CHR(231) + CHR(227) + "o especial de pe" + CHR(231) + "as)
* Cursor de trabalho: xPesa (gerenciado pelo form pai SigPdM8/similar)
*------------------------------------------------------------------------------
DEFINE CLASS SigPdMp9BO AS BusinessBase

    *-- Dados da linha atual do cursor xPesa (grid GradeItens)
    this_cCpros      = ""    && Codigo do produto (Column1 - Produto)
    this_cObs        = ""    && Observacao (Column2 - Observa" + CHR(231) + CHR(227) + "o)
    this_cOper       = ""    && Opera" + CHR(231) + CHR(227) + "o/Movimenta" + CHR(231) + CHR(227) + "o (Column3)
    this_nQtds       = 0     && Quantidade (Column5 - Quantidade)
    this_nPeso       = 0     && Peso (Column6 - Peso)
    this_cTams       = ""    && Codigo do tamanho (Column4 - Tam)
    this_cCors       = ""    && Codigo da cor (Column7 - Cor)
    this_cCbars      = ""    && Codigo de barras (Column8 - Barras)
    this_nCustoFs    = 0     && Custo de produ" + CHR(231) + CHR(227) + "o (Column9 - Custo)
    this_lEspecial   = .F.   && Flag pe" + CHR(231) + "a especial (DynamicForeColor vermelho)
    this_nNops       = 0     && N" + CHR(250) + "mero da opera" + CHR(231) + CHR(227) + "o
    this_nNenvs      = 0     && N" + CHR(250) + "mero do envelope/pe" + CHR(231) + "a
    this_nPesoFixs   = 0     && Peso fixo da pe" + CHR(231) + "a
    this_cUsuLibs    = ""    && Usu" + CHR(225) + "rio que liberou pesagem fora do limite
    this_cMatPs      = ""    && Material da pe" + CHR(231) + "a (para rateio)
    this_nPeso2s     = 0     && Peso secund" + CHR(225) + "rio da pe" + CHR(231) + "a

    *-- Estado do processo de pesagem
    this_lAlterou    = .F.   && Indica se peso foi alterado na linha atual
    this_lLiberaPeso = .F.   && Indica se usu" + CHR(225) + "rio tem permiss" + CHR(227) + "o para liberar pesagem
    this_nOldValue   = 0     && Valor anterior do peso antes da edi" + CHR(231) + CHR(227) + "o
    this_nPesoMedio  = 0     && Peso m" + CHR(233) + "dio calculado (campo get_pesom)

    *-- C" + CHR(243) + "digo de acesso ao programa para verifica" + CHR(231) + CHR(227) + "o de permiss" + CHR(227) + "o (fChecaAcesso)
    this_cProgAcesso = ""    && Ex: 'P00000001' constru" + CHR(237) + "do a partir de Ndopps

    *-- Data de refer" + CHR(234) + "ncia para cota" + CHR(231) + CHR(245) + "es de moeda (de TmpNens.Datas)
    this_dDataMovimento = {} && Data da movimenta" + CHR(231) + CHR(227) + "o atual

    *-- Propriedades de composi" + CHR(231) + CHR(227) + "o SigPrCpo (para INSERT/UPDATE via ExecutarInsercao/ExecutarAtualizacao)
    this_cIdChaves       = ""   && cidchaves char(20) PRIMARY KEY
    this_cMats           = ""   && mats char(14) - c" + CHR(243) + "digo do material
    this_cCgrus          = ""   && cgrus char(3) - c" + CHR(243) + "digo do grupo
    this_cCats           = ""   && cats char(6) - categoria
    this_cDcompos        = ""   && dcompos char(40) - descri" + CHR(231) + CHR(227) + "o da composi" + CHR(231) + CHR(227) + "o
    this_cDscGrp         = ""   && dscgrp char(20) - descri" + CHR(231) + CHR(227) + "o do grupo
    this_cEtiqs          = ""   && etiqs char(1) - etiqueta
    this_cGrupos         = ""   && grupos char(10) - grupos
    this_cMoeds          = ""   && moeds char(3) - moeda
    this_cObsCompos      = ""   && obscompos char(10) - observa" + CHR(231) + CHR(227) + "o
    this_nOrdems         = 0    && ordems numeric(2,0) - ordem
    this_nPcompos        = 0    && pcompos numeric(11,3) - pre" + CHR(231) + "o
    this_nQtdsCompo      = 0    && qtds numeric(8,3) - quantidade na composi" + CHR(231) + CHR(227) + "o
    this_nQtscons        = 0    && qtscons numeric(8,3) - qtd consumida
    this_cUniCompos      = ""   && unicompos char(3) - unidade
    this_cCompos         = ""   && compos char(10) - composi" + CHR(231) + CHR(227) + "o
    this_nOrdCompos      = 0    && ordcompos numeric(2,0) - ordem composi" + CHR(231) + CHR(227) + "o
    this_nQtdCvs         = 0    && qtdcvs numeric(11,3) - qtd convertida
    this_nVlrCvs         = 0    && vlrcvs numeric(11,2) - valor convertido
    this_dDtMovs         = {}   && dtmovs - data do movimento
    this_cCuniPs         = ""   && cunips char(3) - unidade peso
    this_nMarkCvs        = 0    && markcvs numeric(9,6) - markup convertido
    this_nPesos          = 0    && pesos numeric(8,3) - peso na composi" + CHR(231) + CHR(227) + "o
    this_nTotas          = 0    && totas numeric(11,3) - total
    this_nTpAlts         = 0    && tpalts numeric(1,0) - tipo de altera" + CHR(231) + CHR(227) + "o
    this_nVlrPvs         = 0    && vlrpvs numeric(11,2) - valor venda
    this_nOrdTs          = 0    && ordts numeric(2,0) - ordem t
    this_cTipos          = ""   && tipos char(20) - tipos
    this_cMatriz         = ""   && matriz char(14) - matriz
    this_cObsOfs         = ""   && obsofs char(120) - obs ofertas
    this_nPedraPrincipal = 0    && PedraPrincipal numeric(1,0)

    *==========================================================================
    * Init - Configura tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        THIS.this_cTabela     = "SigPrCpo"
        THIS.this_cCampoChave = "cIdChaves"
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna cIdChaves do registro atual
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cIdChaves)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir do cursor xPesa
    * par_cAliasCursor: alias do cursor (tipicamente "xPesa")
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCpros    = ALLTRIM(NVL(Cpros,    ""))
            THIS.this_cObs      = ALLTRIM(NVL(Obs,      ""))
            THIS.this_cOper     = ALLTRIM(NVL(Oper,     ""))
            THIS.this_nQtds     = NVL(Qtds,     0)
            THIS.this_nPeso     = NVL(Peso,     0)
            THIS.this_cTams     = ALLTRIM(NVL(Tams,    ""))
            THIS.this_cCors     = ALLTRIM(NVL(Cors,    ""))
            THIS.this_cCbars    = ALLTRIM(NVL(Cbars,   ""))
            THIS.this_nCustoFs  = NVL(CustoFs,  0)
            THIS.this_lEspecial = IIF(VARTYPE(Especial) = "L", Especial, NVL(Especial, 0) = 1)
            THIS.this_nNops     = NVL(Nops,     0)
            THIS.this_nNenvs    = NVL(Nenvs,    0)
            THIS.this_nPesoFixs = NVL(PesoFixs, 0)
            THIS.this_cUsuLibs  = ALLTRIM(NVL(UsuLibs, ""))
            THIS.this_cMatPs    = ALLTRIM(NVL(MatPs,   ""))
            THIS.this_nPeso2s   = NVL(Peso2s,   0)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida dados m" + CHR(237) + "nimos antes de gravar SigPrCpo
    *==========================================================================
    PROTECTED FUNCTION ValidarDados()
        IF EMPTY(THIS.this_cCpros)
            MsgAviso("O c" + CHR(243) + "digo do produto deve ser informado.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cMats)
            MsgAviso("O c" + CHR(243) + "digo do material deve ser informado.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDFUNC

    *==========================================================================
    * ExecutarInsercao - INSERT INTO SigPrCpo com os dados das propriedades do BO
    *==========================================================================
    PROTECTED FUNCTION ExecutarInsercao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cIdChaves)
                THIS.this_cIdChaves = ALLTRIM(fUniqueIds())
            ENDIF

            loc_cSQL = "INSERT INTO SigPrCpo (" + ;
                       "cidchaves, cpros, mats, cgrus, cats, dcompos, dscgrp, etiqs, grupos, " + ;
                       "moeds, obscompos, ordems, pcompos, qtds, qtscons, unicompos, compos, " + ;
                       "ordcompos, qtdcvs, vlrcvs, dtmovs, cunips, markcvs, pesos, totas, " + ;
                       "tpalts, vlrpvs, ordts, tipos, matriz, obsofs, datatrans, PedraPrincipal) " + ;
                       "VALUES (" + ;
                       EscaparSQL(THIS.this_cIdChaves)        + ", " + ;
                       EscaparSQL(THIS.this_cCpros)           + ", " + ;
                       EscaparSQL(THIS.this_cMats)            + ", " + ;
                       EscaparSQL(THIS.this_cCgrus)           + ", " + ;
                       EscaparSQL(THIS.this_cCats)            + ", " + ;
                       EscaparSQL(THIS.this_cDcompos)         + ", " + ;
                       EscaparSQL(THIS.this_cDscGrp)          + ", " + ;
                       EscaparSQL(THIS.this_cEtiqs)           + ", " + ;
                       EscaparSQL(THIS.this_cGrupos)          + ", " + ;
                       EscaparSQL(THIS.this_cMoeds)           + ", " + ;
                       EscaparSQL(THIS.this_cObsCompos)       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nOrdems)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPcompos)  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdsCompo)+ ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtscons)  + ", " + ;
                       EscaparSQL(THIS.this_cUniCompos)       + ", " + ;
                       EscaparSQL(THIS.this_cCompos)          + ", " + ;
                       FormatarNumeroSQL(THIS.this_nOrdCompos)+ ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdCvs)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nVlrCvs)   + ", " + ;
                       "GETDATE(), "                          + ;
                       EscaparSQL(THIS.this_cCuniPs)          + ", " + ;
                       FormatarNumeroSQL(THIS.this_nMarkCvs)  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPesos)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTotas)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTpAlts)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nVlrPvs)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nOrdTs)    + ", " + ;
                       EscaparSQL(THIS.this_cTipos)           + ", " + ;
                       EscaparSQL(THIS.this_cMatriz)          + ", " + ;
                       EscaparSQL(THIS.this_cObsOfs)          + ", " + ;
                       "GETDATE(), "                          + ;
                       FormatarNumeroSQL(THIS.this_nPedraPrincipal) + ")"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 1
                MsgErro("Falha ao inserir composi" + CHR(231) + CHR(227) + "o em SigPrCpo.", "Erro")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inserir SigPrCpo")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarAtualizacao - UPDATE SigPrCpo WHERE cidchaves = this_cIdChaves
    *==========================================================================
    PROTECTED FUNCTION ExecutarAtualizacao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cIdChaves)
                MsgErro("Chave prim" + CHR(225) + "ria n" + CHR(227) + "o informada para UPDATE.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "UPDATE SigPrCpo SET " + ;
                       "cpros = "     + EscaparSQL(THIS.this_cCpros)            + ", " + ;
                       "mats = "      + EscaparSQL(THIS.this_cMats)             + ", " + ;
                       "cgrus = "     + EscaparSQL(THIS.this_cCgrus)            + ", " + ;
                       "cats = "      + EscaparSQL(THIS.this_cCats)             + ", " + ;
                       "dcompos = "   + EscaparSQL(THIS.this_cDcompos)          + ", " + ;
                       "dscgrp = "    + EscaparSQL(THIS.this_cDscGrp)           + ", " + ;
                       "etiqs = "     + EscaparSQL(THIS.this_cEtiqs)            + ", " + ;
                       "grupos = "    + EscaparSQL(THIS.this_cGrupos)           + ", " + ;
                       "moeds = "     + EscaparSQL(THIS.this_cMoeds)            + ", " + ;
                       "obscompos = " + EscaparSQL(THIS.this_cObsCompos)        + ", " + ;
                       "ordems = "    + FormatarNumeroSQL(THIS.this_nOrdems)    + ", " + ;
                       "pcompos = "   + FormatarNumeroSQL(THIS.this_nPcompos)   + ", " + ;
                       "qtds = "      + FormatarNumeroSQL(THIS.this_nQtdsCompo) + ", " + ;
                       "qtscons = "   + FormatarNumeroSQL(THIS.this_nQtscons)   + ", " + ;
                       "unicompos = " + EscaparSQL(THIS.this_cUniCompos)        + ", " + ;
                       "compos = "    + EscaparSQL(THIS.this_cCompos)           + ", " + ;
                       "ordcompos = " + FormatarNumeroSQL(THIS.this_nOrdCompos) + ", " + ;
                       "qtdcvs = "    + FormatarNumeroSQL(THIS.this_nQtdCvs)    + ", " + ;
                       "vlrcvs = "    + FormatarNumeroSQL(THIS.this_nVlrCvs)    + ", " + ;
                       "dtmovs = GETDATE(), " + ;
                       "cunips = "    + EscaparSQL(THIS.this_cCuniPs)           + ", " + ;
                       "markcvs = "   + FormatarNumeroSQL(THIS.this_nMarkCvs)   + ", " + ;
                       "pesos = "     + FormatarNumeroSQL(THIS.this_nPesos)     + ", " + ;
                       "totas = "     + FormatarNumeroSQL(THIS.this_nTotas)     + ", " + ;
                       "tpalts = "    + FormatarNumeroSQL(THIS.this_nTpAlts)    + ", " + ;
                       "vlrpvs = "    + FormatarNumeroSQL(THIS.this_nVlrPvs)    + ", " + ;
                       "ordts = "     + FormatarNumeroSQL(THIS.this_nOrdTs)     + ", " + ;
                       "tipos = "     + EscaparSQL(THIS.this_cTipos)            + ", " + ;
                       "matriz = "    + EscaparSQL(THIS.this_cMatriz)           + ", " + ;
                       "obsofs = "    + EscaparSQL(THIS.this_cObsOfs)           + ", " + ;
                       "PedraPrincipal = " + FormatarNumeroSQL(THIS.this_nPedraPrincipal) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 1
                MsgErro("Falha ao atualizar composi" + CHR(231) + CHR(227) + "o em SigPrCpo.", "Erro")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar SigPrCpo")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarPermissaoLiberaPeso - Verifica se existe usu" + CHR(225) + "rio com senha de libera" + CHR(231) + CHR(227) + "o
    * Seta this_lLiberaPeso e retorna .T. se ao menos um usu" + CHR(225) + "rio tem LibPess='S'
    * Replica: lcSql = [Select Count(*) as Senha From SigCdUsu Where LibPess = 'S' And Senhas <> ' ']
    *==========================================================================
    FUNCTION BuscarPermissaoLiberaPeso()
        LOCAL loc_lPodeLiberar, loc_cSQL, loc_nRet, loc_oErro
        loc_lPodeLiberar = .F.
        TRY
            loc_cSQL = "SELECT COUNT(*) AS Senha FROM SigCdUsu " + ;
                       "WHERE LibPess = 'S' AND Senhas <> ' '"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpSenha")
            IF loc_nRet >= 1
                SELECT cursor_4c_TmpSenha
                GO TOP
                IF NVL(Senha, 0) > 0
                    loc_lPodeLiberar = .T.
                ENDIF
                IF USED("cursor_4c_TmpSenha")
                    USE IN cursor_4c_TmpSenha
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao verificar permiss" + CHR(227) + "o de peso")
        ENDTRY
        THIS.this_lLiberaPeso = loc_lPodeLiberar
        RETURN loc_lPodeLiberar
    ENDFUNC

    *==========================================================================
    * VerificarDiferencaPeso - Valida se novo peso est" + CHR(225) + " dentro do limite tolerado
    * par_nPesoNovo: valor do peso digitado pelo usu" + CHR(225) + "rio
    * Retorna .T. se dentro do limite (ou sem configura" + CHR(231) + CHR(227) + "o de limite)
    *         .F. se fora do limite (form deve tratar autoriza" + CHR(231) + CHR(227) + "o)
    * Replica logica de Column6.Text1.Valid do legado
    *==========================================================================
    FUNCTION VerificarDiferencaPeso(par_nPesoNovo)
        LOCAL loc_lDentroLimite, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_nDifPesags, loc_cDifPes, loc_nPesoMs, loc_cLinhas
        LOCAL loc_nChkPesags, loc_nPesagem, loc_nXDif, loc_nSinals
        loc_lDentroLimite = .T.
        TRY
            *-- Busca flag de controle de diferenca de peso da empresa
            loc_cSQL = "SELECT DifPes FROM SigCdEmp WHERE Cemps = " + ;
                       EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpDif")
            IF loc_nRet < 1
                loc_lSucesso = .T.
            ENDIF
            SELECT cursor_4c_EmpDif
            GO TOP
            loc_cDifPes = ALLTRIM(NVL(DifPes, ""))
            IF USED("cursor_4c_EmpDif")
                USE IN cursor_4c_EmpDif
            ENDIF

            *-- Busca tolerancia da parametrizacao (crSigCdPam.DifPesags, .Sinals)
            IF !USED("crSigCdPam")
                loc_lSucesso = .T.
            ENDIF
            SELECT crSigCdPam
            GO TOP
            loc_nDifPesags = NVL(DifPesags, 0)
            loc_nSinals    = NVL(Sinals, 0)

            IF loc_nDifPesags = 0 OR loc_cDifPes <> "S"
                loc_lSucesso = .T.
            ENDIF

            *-- Busca peso nominal e linha do produto
            loc_cSQL = "SELECT PesoMs, Linhas FROM SigCdPro " + ;
                       "WHERE Cpros = " + EscaparSQL(THIS.this_cCpros)
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProPeso")
            IF loc_nRet < 1
                loc_lSucesso = .T.
            ENDIF
            SELECT cursor_4c_ProPeso
            GO TOP
            loc_nPesoMs = NVL(PesoMs, 0)
            loc_cLinhas = ALLTRIM(NVL(Linhas, ""))
            IF USED("cursor_4c_ProPeso")
                USE IN cursor_4c_ProPeso
            ENDIF

            *-- Busca flag ChkPesags da linha (se informada)
            loc_nChkPesags = 0
            IF !EMPTY(loc_cLinhas)
                loc_cSQL = "SELECT ChkPesags FROM SigCdLin WHERE Linhas = " + ;
                           EscaparSQL(loc_cLinhas)
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinPeso")
                IF loc_nRet >= 1
                    SELECT cursor_4c_LinPeso
                    GO TOP
                    loc_nChkPesags = NVL(ChkPesags, 0)
                    IF USED("cursor_4c_LinPeso")
                        USE IN cursor_4c_LinPeso
                    ENDIF
                ENDIF
            ENDIF

            IF loc_nPesoMs = 0 OR loc_nChkPesags = 2
                loc_lSucesso = .T.
            ENDIF

            *-- Calcula peso real por pe" + CHR(231) + "a e percentual de diferen" + CHR(231) + "a
            loc_nPesagem = 0
            IF THIS.this_nQtds <> 0
                loc_nPesagem = (par_nPesoNovo / THIS.this_nQtds) - THIS.this_nPesoFixs
            ENDIF

            IF loc_nPesagem <> loc_nPesoMs
                loc_nXDif = (((loc_nPesagem / loc_nPesoMs) - 1) * 100)
                IF (loc_nXDif < (loc_nDifPesags * -1) AND loc_nSinals <> 1) OR ;
                   (loc_nXDif > loc_nDifPesags AND loc_nSinals <> 2)
                    loc_lDentroLimite = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao verificar diferen" + CHR(231) + "a de peso")
            loc_lDentroLimite = .T.
        ENDTRY
        RETURN loc_lDentroLimite
    ENDFUNC

    *==========================================================================
    * AtualizarPesoMedio - Distribui peso m" + CHR(233) + "dio por todas as pe" + CHR(231) + "as do cursor xPesa
    * par_nPesoMedio: valor do campo get_pesom
    * Replica logica de get_pesom.Valid do legado
    *==========================================================================
    FUNCTION AtualizarPesoMedio(par_nPesoMedio)
        LOCAL loc_lSucesso, loc_nTotal, loc_nPesoPorUnid, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !USED("xPesa") OR par_nPesoMedio = 0
                loc_lSucesso = .F.
            ENDIF
            SELECT xPesa
            SUM Qtds TO loc_nTotal
            IF loc_nTotal = 0
                loc_lSucesso = .F.
            ENDIF
            loc_nPesoPorUnid = par_nPesoMedio / loc_nTotal
            SELECT xPesa
            SCAN
                REPLACE Peso WITH NVL(Qtds, 0) * loc_nPesoPorUnid
            ENDSCAN
            GO TOP
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar peso m" + CHR(233) + "dio")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CalcularCustoProducao - Calcula custo de produ" + CHR(231) + CHR(227) + "o de uma pe" + CHR(231) + "a
    * par_nNops: n" + CHR(250) + "mero da opera" + CHR(231) + CHR(227) + "o
    * par_cCpros: c" + CHR(243) + "digo do produto
    * Retorna valor num" + CHR(233) + "rico do custo calculado
    * Replica logica de custoproducao do legado (usa CrSigCdNei local)
    *==========================================================================
    FUNCTION CalcularCustoProducao(par_nNops, par_cCpros)
        LOCAL loc_nCusto, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_cMoeda, loc_nQtdeqs, loc_nMoev, loc_nMoem
        LOCAL loc_nValor, loc_cMoedaItem, loc_lRetrab
        loc_nCusto = 0
        TRY
            *-- Busca dados do produto principal para cambio
            loc_cSQL = "SELECT MoeCusfs, CustoFs, pVens, Moevs FROM SigCdPro " + ;
                       "WHERE CPros = " + EscaparSQL(par_cCpros)
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpPro")
            IF loc_nRet < 1
                loc_lSucesso = 0
            ENDIF
            SELECT cursor_4c_CpPro
            GO TOP
            loc_cMoeda = ALLTRIM(NVL(MoeCusfs, ""))
            IF USED("cursor_4c_CpPro")
                USE IN cursor_4c_CpPro
            ENDIF

            *-- Busca moeda substituta para cotacao (Moeqs/Qtdeqs de SigCdMoe)
            loc_nQtdeqs = 1
            loc_cSQL    = "SELECT Moeqs, Qtdeqs FROM SigCdMoe WHERE CMoes = " + ;
                          EscaparSQL(loc_cMoeda)
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpMoe")
            IF loc_nRet >= 1
                SELECT cursor_4c_CpMoe
                GO TOP
                IF !EOF() AND !EMPTY(ALLTRIM(NVL(Moeqs, "")))
                    loc_cMoeda  = ALLTRIM(NVL(Moeqs, ""))
                    loc_nQtdeqs = IIF(NVL(Qtdeqs, 0) = 0, 1, NVL(Qtdeqs, 0))
                ENDIF
                IF USED("cursor_4c_CpMoe")
                    USE IN cursor_4c_CpMoe
                ENDIF
            ENDIF
            loc_nMoev = fBuscarCotacao(loc_cMoeda, THIS.this_dDataMovimento, gnConnHandle) * loc_nQtdeqs

            *-- Soma custo de materiais do cursor local CrSigCdNei (por opera" + CHR(231) + CHR(227) + "o)
            IF USED("CrSigCdNei")
                SELECT CrSigCdNei
                SCAN FOR Nops = par_nNops
                    IF EMPTY(NVL(Cmats, "")) OR IIF(VARTYPE(Servicos)="L", Servicos, NVL(Servicos,0)=1)
                        LOOP
                    ENDIF
                    loc_cMoedaItem = ALLTRIM(NVL(MoeCusFs, ""))
                    loc_nQtdeqs    = 1
                    loc_cSQL = "SELECT Moeqs, Qtdeqs FROM SigCdMoe WHERE CMoes = " + ;
                               EscaparSQL(loc_cMoedaItem)
                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeNei")
                    IF loc_nRet >= 1
                        SELECT cursor_4c_MoeNei
                        GO TOP
                        IF !EOF() AND !EMPTY(ALLTRIM(NVL(Moeqs, "")))
                            loc_cMoedaItem = ALLTRIM(NVL(Moeqs, ""))
                            loc_nQtdeqs    = IIF(NVL(Qtdeqs,0)=0, 1, NVL(Qtdeqs,0))
                        ENDIF
                        IF USED("cursor_4c_MoeNei")
                            USE IN cursor_4c_MoeNei
                        ENDIF
                    ENDIF
                    loc_nMoem = fBuscarCotacao(loc_cMoedaItem, THIS.this_dDataMovimento, gnConnHandle) * loc_nQtdeqs
                    SELECT CrSigCdNei
                    loc_nCusto = loc_nCusto + ;
                                 (NVL(Qtds,0) * NVL(CustoFs,0) * IIF(loc_nMoev=0, 1, loc_nMoem / loc_nMoev))
                ENDSCAN
            ENDIF

            *-- Busca servi" + CHR(231) + "os terceirizados no SQL Server
            loc_cSQL = "SELECT a.cMats, c.Retrabs, a.Qtds, a.Coefs, a.Fators, a.Moedas " + ;
                       "FROM SigCdNei a " + ;
                       "JOIN SigCdSvc b ON a.cMats = b.ccats AND b.Cpros <> ' ' " + ;
                       "JOIN SigCdNec c ON a.EmpDnps = c.EmpDnPs " + ;
                       "WHERE a.Nops = " + FormatarNumeroSQL(par_nNops) + ;
                       " AND a.Servicos = 1 AND a.cMats <> ' '"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpSvc")
            IF loc_nRet >= 1
                SELECT cursor_4c_CpSvc
                SCAN
                    loc_lRetrab    = IIF(VARTYPE(Retrabs)="L", Retrabs, NVL(Retrabs,0)=1)
                    loc_cMoedaItem = ALLTRIM(NVL(cursor_4c_CpSvc.Moedas, ""))
                    IF loc_lRetrab AND NVL(Coefs,0) <> 0
                        loc_nValor = ROUND(NVL(Coefs,0) * NVL(cursor_4c_CpSvc.Qtds,0), 2)
                    ELSE
                        loc_nValor = ROUND(NVL(Fators,0) * NVL(cursor_4c_CpSvc.Qtds,0), 2)
                    ENDIF

                    IF loc_nValor = 0
                        LOCAL loc_cMatsSvc
                        loc_cMatsSvc = ALLTRIM(NVL(cursor_4c_CpSvc.cMats, ""))
                        loc_cSQL = "SELECT p.MoeCusfs, p.CustoFs, p.pVens, p.Moevs, g.pvCompos " + ;
                                   "FROM SigCdPro p LEFT JOIN SigCdGrp g ON p.Cgrus = g.Cgrus " + ;
                                   "WHERE p.CPros = " + EscaparSQL(loc_cMatsSvc)
                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpProSvc")
                        IF loc_nRet >= 1
                            SELECT cursor_4c_CpProSvc
                            GO TOP
                            IF NVL(pvCompos,0) = 2
                                loc_nValor     = ROUND(NVL(pVens,0) * NVL(cursor_4c_CpSvc.Qtds,0), 2)
                                loc_cMoedaItem = ALLTRIM(NVL(Moevs,""))
                            ELSE
                                loc_nValor     = ROUND(NVL(CustoFs,0) * NVL(cursor_4c_CpSvc.Qtds,0), 2)
                                loc_cMoedaItem = ALLTRIM(NVL(MoeCusfs,""))
                            ENDIF
                            IF USED("cursor_4c_CpProSvc")
                                USE IN cursor_4c_CpProSvc
                            ENDIF
                        ENDIF
                    ENDIF

                    loc_nQtdeqs = 1
                    loc_cSQL = "SELECT Moeqs, Qtdeqs FROM SigCdMoe WHERE CMoes = " + ;
                               EscaparSQL(loc_cMoedaItem)
                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeSvc")
                    IF loc_nRet >= 1
                        SELECT cursor_4c_MoeSvc
                        GO TOP
                        IF !EOF() AND !EMPTY(ALLTRIM(NVL(Moeqs,"")))
                            loc_cMoedaItem = ALLTRIM(NVL(Moeqs,""))
                            loc_nQtdeqs    = IIF(NVL(Qtdeqs,0)=0, 1, NVL(Qtdeqs,0))
                        ENDIF
                        IF USED("cursor_4c_MoeSvc")
                            USE IN cursor_4c_MoeSvc
                        ENDIF
                    ENDIF
                    loc_nMoem = fBuscarCotacao(loc_cMoedaItem, THIS.this_dDataMovimento, gnConnHandle) * loc_nQtdeqs
                    SELECT cursor_4c_CpSvc
                    loc_nCusto = loc_nCusto + (loc_nValor * IIF(loc_nMoev=0, 1, loc_nMoem / loc_nMoev))
                ENDSCAN
                IF USED("cursor_4c_CpSvc")
                    USE IN cursor_4c_CpSvc
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao calcular custo de produ" + CHR(231) + CHR(227) + "o")
            loc_nCusto = 0
        ENDTRY
        RETURN loc_nCusto
    ENDFUNC

    *==========================================================================
    * DistribuirRateio - Distribui peso entre os materiais do envelope
    * par_nAmarra: RECNO() da linha atual de xPesa
    * Popula cursor local CrSigCdNei com os materiais e pesos distribuidos
    * Replica logica de ratpeso do legado
    *==========================================================================
    FUNCTION DistribuirRateio(par_nAmarra)
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_nNenv, loc_cMatP, loc_nPesagem, loc_nPesoAnt, loc_nRecnoRateio
        LOCAL loc_nDifPeso, loc_nTotGrava, loc_cSQL, loc_nRet, loc_lTemOuro
        LOCAL loc_cEmps, loc_cDopps, loc_nNumps, loc_cEmpDnPs
        LOCAL loc_nPsFaseAnt, loc_nDivisor
        loc_lSucesso = .F.
        TRY
            IF !USED("crSigCdOpd") OR !USED("xNensiE") OR !USED("TmpNens")
                MsgErro("Cursores de opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o est" + CHR(227) + "o abertos.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Posiciona crSigCdOpd pelo tipo de opera" + CHR(231) + CHR(227) + "o
            SELECT crSigCdOpd
            SET ORDER TO Dopps
            SELECT TmpNens
            GO TOP
            SEEK ALLTRIM(NVL(TmpNens.Dopps, "")) IN crSigCdOpd

            *-- Zera cursores de trabalho para reprocessamento
            IF USED("CrSigCdNei")
                SELECT CrSigCdNei
                ZAP
            ENDIF
            SELECT xNensiE
            ZAP

            *-- Copia xNensI para xNensiE e calcula totais
            IF USED("xNensI")
                SELECT xNensI
                SET ORDER TO
                SELECT xNensiE
                APPEND FROM DBF("xNensI")
                SUM Pesos TO loc_nTotGrava FOR Visivel AND !IIF(VARTYPE(Servicos)="L", Servicos, NVL(Servicos,0)=1)
                SET ORDER TO Rateio
                DELETE ALL FOR EMPTY(NVL(Nops,"")) AND EMPTY(NVL(CMats,"")) AND ;
                              EMPTY(NVL(Cats,"")) AND NVL(Rateio,0) <> 1
                GO TOP
            ENDIF

            *-- Rateio especial para etiquetas tipo 1 ou 3
            IF INLIST(NVL(crSigCdOpd.Etiqs, 0), 1, 3)
                IF USED("xRateio")
                    USE IN xRateio
                ENDIF
                SELECT xPesa
                SELECT Nenvs, MatPs, Peso AS Pesos ;
                FROM xPesa WHERE RECNO() = par_nAmarra ;
                INTO CURSOR xRateio

                SELECT xRateio
                SCAN
                    loc_nNenv        = NVL(Nenvs, 0)
                    loc_cMatP        = ALLTRIM(NVL(MatPs, ""))
                    loc_nPesagem     = NVL(Pesos, 0)
                    loc_nPesoAnt     = 0
                    loc_nRecnoRateio = 0
                    loc_lTemOuro     = .F.

                    SELECT xNensiE
                    SET ORDER TO Nenvs
                    IF SEEK(loc_nNenv)
                        SCAN WHILE NVL(Nenvs,0) = loc_nNenv
                            IF ALLTRIM(NVL(CMats,"")) = loc_cMatP
                                loc_lTemOuro = .T.
                                EXIT
                            ENDIF
                        ENDSCAN
                    ENDIF

                    IF !loc_lTemOuro
                        SELECT TmpNens
                        GO TOP
                        INSERT INTO xNensiE (Nenvs, Nops, Numps, CMats, PsFaseAnt, Pesos, Qtds, Rateio) ;
                        VALUES (loc_nNenv, loc_nNenv, NVL(Numps,0), loc_cMatP, ;
                                loc_nPesagem, loc_nPesagem, loc_nPesagem, 2)
                    ENDIF

                    SELECT xNensiE
                    SCAN FOR NVL(Rateio,0) = 3 AND NVL(NEnvs,0) = loc_nNenv AND ;
                             !IIF(VARTYPE(FlagIncs)="L", FlagIncs, NVL(FlagIncs,0)=1)
                        loc_nPesagem = loc_nPesagem - NVL(Pesos, 0)
                    ENDSCAN

                    SCAN FOR NVL(Rateio,0) = 2 AND NVL(NEnvs,0) = loc_nNenv AND ;
                             !IIF(VARTYPE(FlagIncs)="L", FlagIncs, NVL(FlagIncs,0)=1)
                        IF loc_nRecnoRateio = 0
                            loc_nRecnoRateio = RECNO()
                        ENDIF
                        loc_nPesoAnt = loc_nPesoAnt + NVL(PsFaseAnt, 0)
                    ENDSCAN

                    loc_nDifPeso = loc_nPesagem - loc_nPesoAnt
                    SCAN FOR NVL(Rateio,0) = 2 AND NVL(NEnvs,0) = loc_nNenv AND ;
                             !IIF(VARTYPE(FlagIncs)="L", FlagIncs, NVL(FlagIncs,0)=1)
                        loc_nPsFaseAnt = NVL(PsFaseAnt, 0)
                        loc_nDivisor   = IIF(loc_nPesoAnt = 0, 1, loc_nPesoAnt)
                        REPLACE Pesos WITH ROUND(loc_nPsFaseAnt + (loc_nPsFaseAnt / loc_nDivisor * loc_nDifPeso), 2), ;
                                Qtds  WITH ROUND(loc_nPsFaseAnt + (loc_nPsFaseAnt / loc_nDivisor * loc_nDifPeso), 2)
                        loc_nPesagem = loc_nPesagem - NVL(Pesos, 0)
                    ENDSCAN

                    IF loc_nRecnoRateio <> 0 AND loc_nPesagem <> 0
                        GO loc_nRecnoRateio
                        REPLACE Pesos WITH NVL(Pesos,0) + loc_nPesagem, ;
                                Qtds  WITH NVL(Qtds,0)  + loc_nPesagem
                    ENDIF

                    SELECT xRateio
                ENDSCAN
                IF USED("xRateio")
                    USE IN xRateio
                ENDIF
            ENDIF

            *-- Grava xNensiE no cursor local CrSigCdNei com dados do SQL Server
            SELECT TmpNens
            GO TOP
            loc_cEmps    = ALLTRIM(NVL(TmpNens.Emps,  ""))
            loc_cDopps   = ALLTRIM(NVL(TmpNens.Dopps, ""))
            loc_nNumps   = NVL(TmpNens.Numps, 0)
            loc_cEmpDnPs = loc_cEmps + loc_cDopps + STR(loc_nNumps, 10)

            SELECT xNensiE
            SET ORDER TO Gravar
            SCAN FOR NVL(Qtds,0) <> 0 OR NVL(Pesos,0) <> 0 OR ;
                     (USED("crSigCdOpd") AND NVL(crSigCdOpd.ReiNops, 0) = 1)

                *-- Busca custo e flags do produto/grupo para este material
                loc_cSQL = "SELECT g.CEstoqs, g.pvCompos, g.Varias, " + ;
                           "p.CGrus, p.CustoFs, p.MoeCusFs, p.pVens, p.Moevs " + ;
                           "FROM SigCdPro p LEFT JOIN SigCdGrp g ON p.CGrus = g.CGrus " + ;
                           "WHERE p.Cpros = " + EscaparSQL(ALLTRIM(NVL(xNensiE.CMats,"")))
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PgRateio")

                IF USED("CrSigCdNei")
                    INSERT INTO CrSigCdNei ;
                    (Emps, Dopps, Numps, Nops, Nenvs, CMats, CDescs, CUnis, Tpops, Cats, Obss, ;
                     AQtds, Qtds, Pesos, FlagIncs, Fators, Moedas, Servicos, GrupoFins, ;
                     nLotes, PesoFixs, cIdChaves, EmpDNPs, Peso2s) ;
                    VALUES ;
                    (loc_cEmps, loc_cDopps, loc_nNumps, ;
                     NVL(xNensiE.NOps,0), NVL(xNensiE.Nenvs,0), ;
                     ALLTRIM(NVL(xNensiE.CMats,"")),   ALLTRIM(NVL(xNensiE.CDescs,"")), ;
                     ALLTRIM(NVL(xNensiE.CUnis,"")),   ALLTRIM(NVL(xNensiE.Tpops,"")), ;
                     ALLTRIM(NVL(xNensiE.Cats,"")),    ALLTRIM(NVL(xNensiE.Obss,"")), ;
                     NVL(xNensiE.AQtds,0), NVL(xNensiE.Qtds,0), NVL(xNensiE.Pesos,0), ;
                     IIF(VARTYPE(xNensiE.FlagIncs)="L", xNensiE.FlagIncs, NVL(xNensiE.FlagIncs,0)=1), ;
                     NVL(xNensiE.Fators,0), ALLTRIM(NVL(xNensiE.Moedas,"")), ;
                     IIF(VARTYPE(xNensiE.Servicos)="L", xNensiE.Servicos, NVL(xNensiE.Servicos,0)=1), ;
                     ALLTRIM(NVL(xNensiE.GrupoFins,"")), ;
                     NVL(xNensiE.nLotes,0), NVL(xNensiE.PesoFixs,0), ;
                     ALLTRIM(fUniqueIds()), loc_cEmpDnPs, NVL(xNensiE.Peso2s,0))

                    *-- Atualiza custo/moeda e flag PesoFixs baseado no grupo do produto
                    IF loc_nRet >= 1 AND USED("cursor_4c_PgRateio")
                        SELECT cursor_4c_PgRateio
                        GO TOP
                        SELECT CrSigCdNei
                        GO BOTTOM
                        IF NVL(cursor_4c_PgRateio.pvCompos, 0) = 2
                            REPLACE CustoFs  WITH NVL(cursor_4c_PgRateio.pVens,    0), ;
                                    MoeCusfs WITH ALLTRIM(NVL(cursor_4c_PgRateio.Moevs,""))
                        ELSE
                            REPLACE CustoFs  WITH NVL(cursor_4c_PgRateio.CustoFs,  0), ;
                                    MoeCusFs WITH ALLTRIM(NVL(cursor_4c_PgRateio.MoeCusFs,""))
                        ENDIF
                        IF USED("crSigCdOpd") AND NVL(crSigCdOpd.PesoFixs,0) = 1 AND ;
                           NVL(cursor_4c_PgRateio.Varias,0) = 1
                            REPLACE PesoFixs WITH 1
                        ENDIF
                        IF USED("cursor_4c_PgRateio")
                            USE IN cursor_4c_PgRateio
                        ENDIF
                    ENDIF
                ENDIF
                SELECT xNensiE
            ENDSCAN
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao distribuir rateio de peso")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * GravarComposicaoEspecial - Grava composi" + CHR(231) + CHR(227) + "o especial no SQL Server (SigPrCpo)
    * par_cAliasCursor: cursor local com dados (ex: "CsSigPrCpo")
    *   - Cursor deve ter campos do SigPrCpo (ideal: construido via SELECT * FROM SigPrCpo)
    *   - Campos m" + CHR(237) + "nimos: cpros, mats, qtds, pesos, dcompos, unicompos, cunips,
    *     cgrus, pcompos, moeds, dtmovs, tpalts, cidchaves, etiqs
    * Replica: Thisform.Podatamgr.update('CsSigPrCpo') do legado
    * Retorna .T. se sucesso, .F. se falha
    *==========================================================================
    FUNCTION GravarComposicaoEspecial(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_cCpros, loc_cIdChaves, loc_nTpAlts
        loc_lSucesso = .F.
        TRY
            IF !USED(par_cAliasCursor)
                MsgErro("Cursor " + par_cAliasCursor + " n" + CHR(227) + "o est" + CHR(225) + " aberto.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            SELECT (par_cAliasCursor)
            GO TOP
            IF EOF()
                loc_lSucesso = .T.
            ENDIF

            *-- Remove composi" + CHR(231) + CHR(227) + "o anterior do produto no SQL Server
            loc_cCpros = ALLTRIM(NVL(cpros, ""))
            IF !EMPTY(loc_cCpros)
                loc_cSQL = "DELETE FROM SigPrCpo WHERE cpros = " + EscaparSQL(loc_cCpros)
                SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF

            *-- Insere cada linha v" + CHR(225) + "lida (TpAlts > 0)
            SELECT (par_cAliasCursor)
            GO TOP
            DO WHILE !EOF()
                loc_nTpAlts = NVL(TpAlts, 0)
                IF loc_nTpAlts > 0
                    loc_cIdChaves = ALLTRIM(NVL(cIdChaves, ""))
                    IF EMPTY(loc_cIdChaves)
                        loc_cIdChaves = ALLTRIM(fUniqueIds())
                    ENDIF
                    loc_cSQL = "INSERT INTO SigPrCpo (" + ;
                               "cidchaves, cpros, mats, cgrus, cats, dcompos, dscgrp, etiqs, " + ;
                               "grupos, moeds, obscompos, ordems, pcompos, qtds, qtscons, " + ;
                               "unicompos, compos, ordcompos, qtdcvs, vlrcvs, dtmovs, cunips, " + ;
                               "markcvs, pesos, totas, tpalts, vlrpvs, ordts, tipos, matriz, " + ;
                               "obsofs, datatrans, PedraPrincipal) " + ;
                               "VALUES (" + ;
                               EscaparSQL(loc_cIdChaves)                          + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(cpros,     "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(mats,      "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(cgrus,     "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(cats,      "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(dcompos,   "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(dscgrp,    "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(etiqs,     "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(grupos,    "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(moeds,     "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(obscompos, "")))            + ", " + ;
                               FormatarNumeroSQL(NVL(ordems,      0))             + ", " + ;
                               FormatarNumeroSQL(NVL(pcompos,     0))             + ", " + ;
                               FormatarNumeroSQL(NVL(qtds,        0))             + ", " + ;
                               FormatarNumeroSQL(NVL(qtscons,     0))             + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(unicompos, "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(compos,    "")))            + ", " + ;
                               FormatarNumeroSQL(NVL(ordcompos,   0))             + ", " + ;
                               FormatarNumeroSQL(NVL(qtdcvs,      0))             + ", " + ;
                               FormatarNumeroSQL(NVL(vlrcvs,      0))             + ", " + ;
                               "GETDATE(), "                                               + ;
                               EscaparSQL(ALLTRIM(NVL(cunips,    "")))            + ", " + ;
                               FormatarNumeroSQL(NVL(markcvs,     0))             + ", " + ;
                               FormatarNumeroSQL(NVL(pesos,       0))             + ", " + ;
                               FormatarNumeroSQL(NVL(totas,       0))             + ", " + ;
                               FormatarNumeroSQL(NVL(tpalts,      0))             + ", " + ;
                               FormatarNumeroSQL(NVL(vlrpvs,      0))             + ", " + ;
                               FormatarNumeroSQL(NVL(ordts,       0))             + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(tipos,     "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(matriz,    "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(obsofs,    "")))            + ", " + ;
                               "GETDATE(), "                                               + ;
                               FormatarNumeroSQL(NVL(PedraPrincipal, 0))          + ")"
                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nRet < 1
                        MsgErro("Falha ao gravar composi" + CHR(231) + CHR(227) + "o especial. " + ;
                                "Produto: " + ALLTRIM(NVL(cpros,"")), "Erro")
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF
                SELECT (par_cAliasCursor)
                SKIP
            ENDDO
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao gravar composi" + CHR(231) + CHR(227) + "o especial")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * GravarSigCdNei - Persiste cursor local CrSigCdNei no SQL Server (SigCdNei)
    * Equivalente ao poDataMgr.update('CrSigCdNei') do legado
    * Chamado pelo form em BtnProcessarClick ap" + CHR(243) + "s todas as pe" + CHR(231) + "as pesadas
    * Retorna .T. se sucesso, .F. se falha
    *==========================================================================
    FUNCTION GravarSigCdNei()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_lFlagIncs, loc_lServicos
        loc_lSucesso = .F.
        TRY
            IF !USED("CrSigCdNei") OR RECCOUNT("CrSigCdNei") = 0
                loc_lSucesso = .T.
            ENDIF
            SELECT CrSigCdNei
            GO TOP
            DO WHILE !EOF()
                loc_lFlagIncs = IIF(VARTYPE(FlagIncs)="L", FlagIncs, NVL(FlagIncs,0)=1)
                loc_lServicos = IIF(VARTYPE(Servicos)="L", Servicos, NVL(Servicos,0)=1)

                loc_cSQL = "INSERT INTO SigCdNei (" + ;
                           "emps, dopps, numps, nops, nenvs, cmats, cdescs, cunis, tpops, cats, " + ;
                           "obss, aqtds, qtds, pesos, flagincs, fators, moedas, servicos, " + ;
                           "grupofins, nlotes, pesofixs, cidchaves, empdnps, peso2s, " + ;
                           "custofs, moecusfs) " + ;
                           "VALUES (" + ;
                           EscaparSQL(ALLTRIM(NVL(Emps,      ""))) + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(Dopps,     ""))) + ", " + ;
                           FormatarNumeroSQL(NVL(Numps,       0))  + ", " + ;
                           FormatarNumeroSQL(NVL(Nops,        0))  + ", " + ;
                           FormatarNumeroSQL(NVL(Nenvs,       0))  + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(CMats,     ""))) + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(CDescs,    ""))) + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(CUnis,     ""))) + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(Tpops,     ""))) + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(Cats,      ""))) + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(Obss,      ""))) + ", " + ;
                           FormatarNumeroSQL(NVL(AQtds,       0))  + ", " + ;
                           FormatarNumeroSQL(NVL(Qtds,        0))  + ", " + ;
                           FormatarNumeroSQL(NVL(Pesos,       0))  + ", " + ;
                           IIF(loc_lFlagIncs, "1", "0")            + ", " + ;
                           FormatarNumeroSQL(NVL(Fators,      0))  + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(Moedas,    ""))) + ", " + ;
                           IIF(loc_lServicos, "1", "0")            + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(GrupoFins, ""))) + ", " + ;
                           FormatarNumeroSQL(NVL(nLotes,      0))  + ", " + ;
                           FormatarNumeroSQL(NVL(PesoFixs,    0))  + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(cIdChaves, ""))) + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(EmpDNPs,   ""))) + ", " + ;
                           FormatarNumeroSQL(NVL(Peso2s,      0))  + ", " + ;
                           FormatarNumeroSQL(NVL(CustoFs,     0))  + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(MoeCusFs,  ""))) + ")"

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nRet < 1
                    MsgErro("Falha ao gravar SigCdNei (Nenvs=" + ;
                            TRANSFORM(NVL(Nenvs,0)) + ")", "Erro")
                    loc_lSucesso = .F.
                ENDIF
                SELECT CrSigCdNei
                SKIP
            ENDDO
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao gravar SigCdNei")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

