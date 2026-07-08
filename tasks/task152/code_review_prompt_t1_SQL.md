# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, FK_CHAVE, EMPDOPNUMS, CONTADS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, FK_CHAVE, EMPDOPNUMS, CONTADS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NUMES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, FK_CHAVE, EMPDOPNUMS, CONTADS

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
  DeleteMark = .F.
		.DeleteMark 	   = .f.
		.Column1.ControlSource  = [crGrade.Emps]
		.Column2.ControlSource  = [crGrade.Dopes]
		.Column3.ControlSource  = [crGrade.Numes]
		.Column4.ControlSource  = [crGrade.Datas]
		.Column5.ControlSource  = [crGrade.GrupoDs]
		.Column6.ControlSource  = [crGrade.ContaDs]
		.Column7.ControlSource  = [crGrade.PrazoEnts]
		.Column8.ControlSource  = [crGrade.Pendentes]
		.DeleteMark 	   = .f.
		.Column1.ControlSource  = [crRodape.Descrs]
		.Column2.ControlSource  = [crRodape.Usuars]
		.Column3.ControlSource  = [crRodape.Pendentes]
Select Distinct EmpDopNums, Sum(Qtds) as Qtds ;
  From crSigMvEstPd ;
Select LocalEstPd
	lcQuery = [Select a.Emps, a.EmpDs, a.Dopes, a.Numes, a.GrupoDs, a.ContaDs, b.RClis, a.Usuars, a.Datas, a.PrazoEnts ] + ;
			    [From SigMvCab a, SigCdCli b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalEest]) < 1)
	Select LocalEest
		Insert Into crGrade (Emps, Dopes, Numes, GrupoDs, ContaDs, RClis, Usuars, Datas, PrazoEnts, EmpDs, Pendentes) ;
Select [ ] as Agrupar,Sum(Pendentes) as Pendentes ;
  From crGrade ;
Insert Into crRodape (Pendentes) Values (crTotal.Pendentes)
Select crGrade

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPDPNS.prg) - TRECHOS RELEVANTES PARA PASS SQL (1004 linhas total):

*-- Linhas 111 a 129:
111:                         *-- Inicializar exibicao do rodape com o primeiro registro
112:                         *-- (replicando logica original do SelecionaDados apos carga)
113:                         IF USED("cursor_4c_Grade") AND !EOF("cursor_4c_Grade")
114:                             SELECT cursor_4c_Grade
115:                             GO TOP
116:                             THIS.grd_4c_Rodape.Column1.Text1.Value = ;
117:                                 "Empresa Destino : " + ALLTRIM(NVL(EmpDs, ""))
118:                             THIS.grd_4c_Rodape.Column2.Text1.Value = ALLTRIM(NVL(Usuars, ""))
119:                             THIS.txt_4c_RClis.Value = ALLTRIM(NVL(RClis, ""))
120:                         ENDIF
121: 
122:                         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
123:                             THIS.grd_4c_Dados.Refresh()
124:                         ENDIF
125:                         IF PEMSTATUS(THIS, "grd_4c_Rodape", 5)
126:                             THIS.grd_4c_Rodape.Refresh()
127:                         ENDIF
128:                         *-- Focar na primeira coluna do grid principal
129:                         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)

*-- Linhas 151 a 187:
151:     *==========================================================================
152:     PROTECTED PROCEDURE CriarCursores()
153:         SET NULL ON
154:         CREATE CURSOR cursor_4c_Grade ( ;
155:             Emps       C(3)     NULL, ;
156:             Dopes      C(20)    NULL, ;
157:             Numes      N(6)     NULL, ;
158:             GrupoDs    C(10)    NULL, ;
159:             ContaDs    C(10)    NULL, ;
160:             Usuars     C(10)    NULL, ;
161:             Datas      D        NULL, ;
162:             PrazoEnts  D        NULL, ;
163:             Pendentes  N(10,3)  NULL, ;
164:             EmpDs      C(3)     NULL, ;
165:             RClis      C(50)    NULL  ;
166:         )
167:         SET NULL OFF
168:         SELECT cursor_4c_Grade
169:         INDEX ON DTOS(PrazoEnts) + DTOS(Datas) + Emps + Dopes + STR(Numes, 6) TAG Ordem
170: 
171:         SET NULL ON
172:         CREATE CURSOR cursor_4c_Rodape ( ;
173:             Descrs     C(100)   NULL, ;
174:             Usuars     C(10)    NULL, ;
175:             Pendentes  N(10,3)  NULL  ;
176:         )
177:         SET NULL OFF
178:     ENDPROC
179: 
180:     *==========================================================================
181:     * ConfigurarPageFrame - Cria o cabecalho cinza do form (cntSombra do legado).
182:     * Forms OPERACIONAIS nao usam PageFrame CRUD; este metodo constroi apenas
183:     * o container de titulo (equivalente ao frame visual superior).
184:     *==========================================================================
185:     PROTECTED PROCEDURE ConfigurarPageFrame()
186:         THIS.AddObject("cnt_4c_Sombra", "Container")
187:         WITH THIS.cnt_4c_Sombra

*-- Linhas 291 a 454:
291:             .Height            = 340
292:             .ColumnCount       = 8
293:             .RecordSource      = "cursor_4c_Grade"
294:             .DeleteMark        = .F.
295:             .RecordMark        = .F.
296:             .ReadOnly          = .T.
297:             .ScrollBars        = 2
298:             .AllowHeaderSizing = .F.
299:             .AllowRowSizing    = .F.
300:             .HeaderHeight      = 17
301:             .GridLineColor     = RGB(238, 238, 238)
302:             .FontName          = "Tahoma"
303:             .Visible           = .T.
304: 
305:             *-- Column 1: Emp (3 chars)
306:             .Column1.ControlSource = "cursor_4c_Grade.Emps"
307:             .Column1.Width         = 41
308:             .Column1.ReadOnly      = .T.
309:             .Column1.FontName      = "Courier New"
310:             .Column1.Movable       = .F.
311:             .Column1.Resizable     = .F.
312:             .Column1.Text1.FontName  = "Courier New"
313:             .Column1.Text1.BorderStyle = 0
314:             .Column1.Text1.Margin    = 0
315:             .Column1.Text1.ReadOnly  = .T.
316:             .Column1.Text1.ForeColor = RGB(0, 0, 0)
317:             .Column1.Text1.BackColor = RGB(255, 255, 255)
318:             .Column1.Header1.Caption   = "Emp"
319:             .Column1.Header1.FontName  = "Tahoma"
320:             .Column1.Header1.FontSize  = 8
321:             .Column1.Header1.Alignment = 2
322:             .Column1.Header1.ForeColor = RGB(90, 90, 90)
323: 
324:             *-- Column 2: Operacao (20 chars)
325:             .Column2.ControlSource = "cursor_4c_Grade.Dopes"
326:             .Column2.Width         = 275
327:             .Column2.ReadOnly      = .T.
328:             .Column2.FontName      = "Courier New"
329:             .Column2.Movable       = .F.
330:             .Column2.Resizable     = .F.
331:             .Column2.Text1.FontName  = "Courier New"
332:             .Column2.Text1.BorderStyle = 0
333:             .Column2.Text1.Margin    = 0
334:             .Column2.Text1.ReadOnly  = .T.
335:             .Column2.Text1.ForeColor = RGB(0, 0, 0)
336:             .Column2.Text1.BackColor = RGB(255, 255, 255)
337:             .Column2.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
338:             .Column2.Header1.FontName  = "Tahoma"
339:             .Column2.Header1.FontSize  = 8
340:             .Column2.Header1.Alignment = 2
341:             .Column2.Header1.ForeColor = RGB(90, 90, 90)
342: 
343:             *-- Column 3: Codigo (numeric 6 digits, mask 999999)
344:             .Column3.ControlSource = "cursor_4c_Grade.Numes"
345:             .Column3.InputMask     = "999999"
346:             .Column3.Width         = 80
347:             .Column3.ReadOnly      = .T.
348:             .Column3.FontName      = "Courier New"
349:             .Column3.Movable       = .F.
350:             .Column3.Resizable     = .F.
351:             .Column3.Text1.FontName  = "Courier New"
352:             .Column3.Text1.BorderStyle = 0
353:             .Column3.Text1.Margin    = 0
354:             .Column3.Text1.ForeColor = RGB(0, 0, 0)
355:             .Column3.Text1.BackColor = RGB(255, 255, 255)
356:             .Column3.Header1.Caption   = CHR(67) + CHR(243) + "digo"
357:             .Column3.Header1.FontName  = "Tahoma"
358:             .Column3.Header1.FontSize  = 8
359:             .Column3.Header1.Alignment = 2
360:             .Column3.Header1.ForeColor = RGB(90, 90, 90)
361: 
362:             *-- Column 4: Data
363:             .Column4.ControlSource = "cursor_4c_Grade.Datas"
364:             .Column4.Width         = 107
365:             .Column4.ReadOnly      = .T.
366:             .Column4.FontName      = "Courier New"
367:             .Column4.Movable       = .F.
368:             .Column4.Resizable     = .F.
369:             .Column4.Text1.FontName  = "Courier New"
370:             .Column4.Text1.BorderStyle = 0
371:             .Column4.Text1.Margin    = 0
372:             .Column4.Text1.ReadOnly  = .T.
373:             .Column4.Text1.ForeColor = RGB(0, 0, 0)
374:             .Column4.Text1.BackColor = RGB(255, 255, 255)
375:             .Column4.Header1.Caption   = "Data"
376:             .Column4.Header1.FontName  = "Tahoma"
377:             .Column4.Header1.FontSize  = 8
378:             .Column4.Header1.Alignment = 2
379:             .Column4.Header1.ForeColor = RGB(90, 90, 90)
380: 
381:             *-- Column 5: Grupo (Alignment=3 conforme original Column5.Text1)
382:             .Column5.ControlSource = "cursor_4c_Grade.GrupoDs"
383:             .Column5.Width         = 107
384:             .Column5.ReadOnly      = .T.
385:             .Column5.FontName      = "Courier New"
386:             .Column5.Movable       = .F.
387:             .Column5.Resizable     = .F.
388:             .Column5.Text1.FontName  = "Courier New"
389:             .Column5.Text1.BorderStyle = 0
390:             .Column5.Text1.Margin    = 0
391:             .Column5.Text1.Alignment = 3
392:             .Column5.Text1.ForeColor = RGB(0, 0, 0)
393:             .Column5.Text1.BackColor = RGB(255, 255, 255)
394:             .Column5.Header1.Caption   = "Grupo"
395:             .Column5.Header1.FontName  = "Tahoma"
396:             .Column5.Header1.FontSize  = 8
397:             .Column5.Header1.Alignment = 2
398:             .Column5.Header1.ForeColor = RGB(90, 90, 90)
399: 
400:             *-- Column 6: Conta
401:             .Column6.ControlSource = "cursor_4c_Grade.ContaDs"
402:             .Column6.Width         = 107
403:             .Column6.ReadOnly      = .T.
404:             .Column6.FontName      = "Courier New"
405:             .Column6.Movable       = .F.
406:             .Column6.Resizable     = .F.
407:             .Column6.Text1.FontName  = "Courier New"
408:             .Column6.Text1.BorderStyle = 0
409:             .Column6.Text1.Margin    = 0
410:             .Column6.Text1.ReadOnly  = .T.
411:             .Column6.Text1.ForeColor = RGB(0, 0, 0)
412:             .Column6.Text1.BackColor = RGB(255, 255, 255)
413:             .Column6.Header1.Caption   = "Conta"
414:             .Column6.Header1.FontName  = "Tahoma"
415:             .Column6.Header1.FontSize  = 8
416:             .Column6.Header1.Alignment = 2
417:             .Column6.Header1.ForeColor = RGB(90, 90, 90)
418: 
419:             *-- Column 7: Data Entrega
420:             .Column7.ControlSource = "cursor_4c_Grade.PrazoEnts"
421:             .Column7.Width         = 107
422:             .Column7.ReadOnly      = .T.
423:             .Column7.FontName      = "Courier New"
424:             .Column7.Movable       = .F.
425:             .Column7.Resizable     = .F.
426:             .Column7.Text1.FontName  = "Courier New"
427:             .Column7.Text1.BorderStyle = 0
428:             .Column7.Text1.Margin    = 0
429:             .Column7.Text1.ReadOnly  = .T.
430:             .Column7.Text1.ForeColor = RGB(0, 0, 0)
431:             .Column7.Text1.BackColor = RGB(255, 255, 255)
432:             .Column7.Header1.Caption   = "Data / Entrega"
433:             .Column7.Header1.FontName  = "Tahoma"
434:             .Column7.Header1.FontSize  = 8
435:             .Column7.Header1.Alignment = 2
436:             .Column7.Header1.ForeColor = RGB(90, 90, 90)
437: 
438:             *-- Column 8: Qtde - FontBold + BackColor diferenciado conforme original
439:             .Column8.ControlSource = "cursor_4c_Grade.Pendentes"
440:             .Column8.InputMask     = "9999999.99"
441:             .Column8.Width         = 61
442:             .Column8.ReadOnly      = .T.
443:             .Column8.FontName      = "Courier New"
444:             .Column8.FontBold      = .T.
445:             .Column8.BackColor     = RGB(255, 255, 223)
446:             .Column8.Movable       = .F.
447:             .Column8.Resizable     = .F.
448:             .Column8.Text1.FontName  = "Courier New"
449:             .Column8.Text1.FontBold  = .T.
450:             .Column8.Text1.BorderStyle = 0
451:             .Column8.Text1.Margin    = 0
452:             .Column8.Text1.ReadOnly  = .T.
453:             .Column8.Text1.ForeColor = RGB(0, 0, 0)
454:             .Column8.Text1.BackColor = RGB(255, 255, 223)

*-- Linhas 475 a 548:
475:             .Height            = 23
476:             .ColumnCount       = 3
477:             .RecordSource      = "cursor_4c_Rodape"
478:             .DeleteMark        = .F.
479:             .RecordMark        = .F.
480:             .ReadOnly          = .T.
481:             .ScrollBars        = 2
482:             .AllowHeaderSizing = .F.
483:             .AllowRowSizing    = .F.
484:             .HeaderHeight      = 4
485:             .FontName          = "Arial"
486:             .Visible           = .T.
487: 
488:             *-- Column 1: Descrs (descricao empresa destino) - Width 722 (542*1000/750)
489:             .Column1.ControlSource = "cursor_4c_Rodape.Descrs"
490:             .Column1.Width         = 722
491:             .Column1.ReadOnly      = .T.
492:             .Column1.BackColor     = RGB(255, 255, 223)
493:             .Column1.FontName      = "Arial"
494:             .Column1.Movable       = .F.
495:             .Column1.Resizable     = .F.
496:             .Column1.Text1.FontName  = "Arial"
497:             .Column1.Text1.BorderStyle = 0
498:             .Column1.Text1.Margin    = 0
499:             .Column1.Text1.ReadOnly  = .T.
500:             .Column1.Text1.ForeColor = RGB(0, 0, 0)
501:             .Column1.Text1.BackColor = RGB(255, 255, 223)
502:             .Column1.Header1.Caption   = ""
503:             .Column1.Header1.FontName  = "Arial"
504:             .Column1.Header1.FontSize  = 8
505:             .Column1.Header1.Alignment = 2
506:             .Column1.Header1.ForeColor = RGB(90, 90, 90)
507:             .Column1.Header1.BackColor = RGB(255, 255, 0)
508: 
509:             *-- Column 2: Usuars (usuario) - Width 80 (scaled)
510:             .Column2.ControlSource = "cursor_4c_Rodape.Usuars"
511:             .Column2.Width         = 80
512:             .Column2.ReadOnly      = .T.
513:             .Column2.BackColor     = RGB(255, 255, 223)
514:             .Column2.FontName      = "Arial"
515:             .Column2.FontBold      = .T.
516:             .Column2.Movable       = .F.
517:             .Column2.Resizable     = .F.
518:             .Column2.Text1.FontName  = "Arial"
519:             .Column2.Text1.FontBold  = .T.
520:             .Column2.Text1.BorderStyle = 0
521:             .Column2.Text1.Margin    = 0
522:             .Column2.Text1.ReadOnly  = .T.
523:             .Column2.Text1.ForeColor = RGB(0, 0, 0)
524:             .Column2.Text1.BackColor = RGB(255, 255, 223)
525:             .Column2.Header1.Caption   = ""
526:             .Column2.Header1.FontName  = "Arial"
527:             .Column2.Header1.FontSize  = 8
528:             .Column2.Header1.Alignment = 2
529:             .Column2.Header1.ForeColor = RGB(90, 90, 90)
530:             .Column2.Header1.BackColor = RGB(255, 255, 0)
531: 
532:             *-- Column 3: Qtde total - mask 9999999.99
533:             .Column3.ControlSource = "cursor_4c_Rodape.Pendentes"
534:             .Column3.InputMask     = "9999999.99"
535:             .Column3.Width         = 80
536:             .Column3.ReadOnly      = .T.
537:             .Column3.BackColor     = RGB(255, 255, 223)
538:             .Column3.FontName      = "Arial"
539:             .Column3.FontBold      = .T.
540:             .Column3.Movable       = .F.
541:             .Column3.Resizable     = .F.
542:             .Column3.Text1.FontName  = "Arial"
543:             .Column3.Text1.FontBold  = .T.
544:             .Column3.Text1.BorderStyle = 0
545:             .Column3.Text1.Margin    = 0
546:             .Column3.Text1.ReadOnly  = .T.
547:             .Column3.Text1.ForeColor = RGB(0, 0, 0)
548:             .Column3.Text1.BackColor = RGB(255, 255, 223)

*-- Linhas 677 a 695:
677:             WAIT CLEAR
678: 
679:             IF USED("cursor_4c_Grade") AND !EOF("cursor_4c_Grade")
680:                 SELECT cursor_4c_Grade
681:                 GO TOP
682:                 THIS.grd_4c_Rodape.Column1.Text1.Value = ;
683:                     "Empresa Destino : " + ALLTRIM(NVL(EmpDs, ""))
684:                 THIS.grd_4c_Rodape.Column2.Text1.Value = ALLTRIM(NVL(Usuars, ""))
685:                 THIS.txt_4c_RClis.Value = ALLTRIM(NVL(RClis, ""))
686:             ELSE
687:                 THIS.grd_4c_Rodape.Column1.Text1.Value = ""
688:                 THIS.grd_4c_Rodape.Column2.Text1.Value = ""
689:                 THIS.txt_4c_RClis.Value = ""
690:             ENDIF
691: 
692:             THIS.grd_4c_Dados.Refresh()
693:             THIS.grd_4c_Rodape.Refresh()
694:             THIS.txt_4c_RClis.Refresh()
695: 

*-- Linhas 717 a 735:
717:                 RETURN
718:             ENDIF
719: 
720:             SELECT cursor_4c_Grade
721:             IF RECCOUNT("cursor_4c_Grade") = 0
722:                 MsgAviso("N" + CHR(227) + "o existem pend" + CHR(234) + "ncias para esta opera" + CHR(231) + CHR(227) + "o.", ;
723:                         "Pendentes")
724:                 RETURN
725:             ENDIF
726: 
727:             GO TOP
728: 
729:             THIS.grd_4c_Rodape.Column1.Text1.Value = ;
730:                 "Empresa Destino : " + ALLTRIM(NVL(EmpDs, ""))
731:             THIS.grd_4c_Rodape.Column2.Text1.Value = ALLTRIM(NVL(Usuars, ""))
732:             THIS.txt_4c_RClis.Value = ALLTRIM(NVL(RClis, ""))
733: 
734:             THIS.grd_4c_Dados.Refresh()
735:             THIS.grd_4c_Rodape.Refresh()

*-- Linhas 760 a 778:
760:                 RETURN
761:             ENDIF
762: 
763:             SELECT cursor_4c_Grade
764:             loc_cDetalhe = "Empresa  : " + ALLTRIM(NVL(Emps, "")) + " - " + ALLTRIM(NVL(EmpDs, "")) + CHR(13) + ;
765:                            "Opera" + CHR(231) + CHR(227) + "o: " + ALLTRIM(NVL(Dopes, "")) + " " + ;
766:                            ALLTRIM(TRANSFORM(NVL(Numes, 0))) + CHR(13) + ;
767:                            "Data     : " + DTOC(NVL(Datas, {})) + CHR(13) + ;
768:                            "Entrega  : " + DTOC(NVL(PrazoEnts, {})) + CHR(13) + ;
769:                            "Grupo    : " + ALLTRIM(NVL(GrupoDs, "")) + CHR(13) + ;
770:                            "Conta    : " + ALLTRIM(NVL(ContaDs, "")) + CHR(13) + ;
771:                            "Usu" + CHR(225) + "rio  : " + ALLTRIM(NVL(Usuars, "")) + CHR(13) + ;
772:                            "Cliente  : " + ALLTRIM(NVL(RClis, "")) + CHR(13) + ;
773:                            "Pendente : " + ALLTRIM(TRANSFORM(NVL(Pendentes, 0), "9999999.99"))
774:             MsgInfo(loc_cDetalhe, "Detalhe da Pend" + CHR(234) + "ncia")
775:         CATCH TO loc_oErro
776:             MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
777:         ENDTRY
778:     ENDPROC

*-- Linhas 805 a 823:
805: 
806:         TRY
807:             IF USED("cursor_4c_Grade") AND !EOF("cursor_4c_Grade") AND !BOF("cursor_4c_Grade")
808:                 SELECT cursor_4c_Grade
809: 
810:                 THIS.grd_4c_Rodape.Column1.Text1.Value = ;
811:                     "Empresa Destino : " + ALLTRIM(NVL(EmpDs, ""))
812:                 THIS.grd_4c_Rodape.Column2.Text1.Value = ALLTRIM(NVL(Usuars, ""))
813:                 THIS.txt_4c_RClis.Value = ALLTRIM(NVL(RClis, ""))
814: 
815:                 THIS.grd_4c_Rodape.Column1.Refresh()
816:                 THIS.grd_4c_Rodape.Column2.Refresh()
817:                 THIS.txt_4c_RClis.Refresh()
818:             ENDIF
819:         CATCH TO loc_oErro
820:             MsgErro(loc_oErro.Message, "Erro GrdDadosAfterRowColChange")
821:         ENDTRY
822:     ENDPROC
823: 

*-- Linhas 951 a 969:
951: 
952:             IF loc_lSucesso
953:                 IF USED("cursor_4c_Grade") AND !EOF("cursor_4c_Grade")
954:                     SELECT cursor_4c_Grade
955:                     GO TOP
956:                     THIS.grd_4c_Rodape.Column1.Text1.Value = ;
957:                         "Empresa Destino : " + ALLTRIM(NVL(EmpDs, ""))
958:                     THIS.grd_4c_Rodape.Column2.Text1.Value = ALLTRIM(NVL(Usuars, ""))
959:                     THIS.txt_4c_RClis.Value = ALLTRIM(NVL(RClis, ""))
960:                 ELSE
961:                     THIS.LimparCampos()
962:                 ENDIF
963: 
964:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
965:                     THIS.grd_4c_Dados.Refresh()
966:                 ENDIF
967:                 IF PEMSTATUS(THIS, "grd_4c_Rodape", 5)
968:                     THIS.grd_4c_Rodape.Refresh()
969:                 ENDIF


### BO (C:\4c\projeto\app\classes\SIGPDPNSBO.prg):
*==============================================================================
* SIGPDPNSBO.prg - BO de movimentos em aberto aguardando confirmacao (SIGPDPNS)
* Herda de BusinessBase
* Tabela principal: SigMvCab (movimentos em aberto filtrados por chave de sessao)
* Form OPERACIONAL: exibe movimentos em aberto filtrados por chave de sessao (this_cKey)
*==============================================================================
DEFINE CLASS SIGPDPNSBO AS BusinessBase

    *-- Chave de filtro recebida pelo form (equivalente a lpKey do legado)
    this_cKey            = ""

    *-- Campos da linha corrente em cursor_4c_Grade (equiv. crGrade)
    *-- cursor_4c_Grade: Emps c(3), Dopes c(20), Numes n(6), GrupoDs c(10),
    *--                  ContaDs c(10), Usuars c(10), Datas d, PrazoEnts d,
    *--                  Qtds n(10,3), EmpDs c(3), RClis c(50)
    this_cEmps           = ""
    this_cEmpDs          = ""
    this_cDopes          = ""
    this_nNumes          = 0
    this_cGrupoDs        = ""
    this_cContaDs        = ""
    this_cUsuars         = ""
    this_dDatas          = {}
    this_dPrazoEnts      = {}
    this_nPendentes      = 0
    this_cRClis          = ""

    *-- Totalizador de quantidade exibido em cursor_4c_Rodape (campo Qtds)
    this_nTotalPendentes = 0

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        this_cTabela     = "SigMvCab"
        this_cCampoChave = "EmpDopNums"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir da linha corrente do cursor
    * Chamado pelo form ao navegar em grd_4c_Dados (AfterRowColChange)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cEmps      = TratarNulo(Emps,      "C")
            THIS.this_cEmpDs     = TratarNulo(EmpDs,     "C")
            THIS.this_cDopes     = TratarNulo(Dopes,     "C")
            THIS.this_nNumes     = TratarNulo(Numes,     "N")
            THIS.this_cGrupoDs   = TratarNulo(GrupoDs,   "C")
            THIS.this_cContaDs   = TratarNulo(ContaDs,   "C")
            THIS.this_cUsuars    = TratarNulo(Usuars,    "C")
            THIS.this_dDatas     = TratarNulo(Datas,     "D")
            THIS.this_dPrazoEnts = TratarNulo(PrazoEnts, "D")
            THIS.this_nPendentes = TratarNulo(Pendentes, "N")
            THIS.this_cRClis     = TratarNulo(RClis,     "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarDados - Popula cursor_4c_Grade e cursor_4c_Rodape
    * Equivale a SelecionaDados do legado (SIGPDPNS.selecionadados)
    * Pre-requisitos:
    *   - cursor_4c_Grade e cursor_4c_Rodape ja criados pelo form
    *   - crSigMvEstPd em scope com campos EmpDopNums, Qtds, Fk_chave
    *   - this_cKey preenchido com a chave de filtro da sessao
    *--------------------------------------------------------------------------
    PROCEDURE SelecionarDados()
        LOCAL loc_lSucesso, loc_lPodeProsseguir
        LOCAL loc_cSQL, loc_nTotal, loc_oErro

        loc_lSucesso        = .F.
        loc_lPodeProsseguir = .T.

        TRY
            IF !USED("crSigMvEstPd")
                MsgErro("Cursor crSigMvEstPd n" + CHR(227) + "o encontrado.", ;
                        "Erro ao Selecionar Dados")
                loc_lPodeProsseguir = .F.
            ENDIF

            IF loc_lPodeProsseguir AND !USED("cursor_4c_Grade")
                MsgErro("Cursor cursor_4c_Grade n" + CHR(227) + "o encontrado.", ;
                        "Erro ao Selecionar Dados")
                loc_lPodeProsseguir = .F.
            ENDIF

            IF loc_lPodeProsseguir
                *-- Limpar cursores de destino
                SELECT cursor_4c_Grade
                ZAP
                IF USED("cursor_4c_Rodape")
                    SELECT cursor_4c_Rodape
                    ZAP
                ENDIF

                *-- Obter EmpDopNums distintos filtrados pela chave da sessao
                SELECT DISTINCT EmpDopNums, SUM(Qtds) AS Qtds ;
                  FROM crSigMvEstPd ;
                 WHERE Fk_chave = THIS.this_cKey ;
                 GROUP BY EmpDopNums ;
                 ORDER BY EmpDopNums ;
                  INTO CURSOR cursor_4c_LocalEstPd

                *-- Para cada grupo EmpDopNums, buscar movimentos no SQL Server
                SELECT cursor_4c_LocalEstPd
                SCAN
                    loc_cSQL = "SELECT a.Emps, a.EmpDs, a.Dopes, a.Numes, " + ;
                               "a.GrupoDs, a.ContaDs, b.RClis, a.Usuars, " + ;
                               "a.Datas, a.PrazoEnts " + ;
                               "FROM SigMvCab a, SigCdCli b " + ;
                               "WHERE a.EmpDopNums = '" + ;
                               ALLTRIM(cursor_4c_LocalEstPd.EmpDopNums) + ;
                               "' AND a.ContaDs = b.IClis"

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEest") >= 1
                        SELECT cursor_4c_LocalEest
                        SCAN
                            INSERT INTO cursor_4c_Grade ;
                                (Emps, Dopes, Numes, GrupoDs, ContaDs, ;
                                 RClis, Usuars, Datas, PrazoEnts, EmpDs, Pendentes) ;
                            VALUES ;
                                (cursor_4c_LocalEest.Emps, ;
                                 cursor_4c_LocalEest.Dopes, ;
                                 cursor_4c_LocalEest.Numes, ;
                                 cursor_4c_LocalEest.GrupoDs, ;
                                 cursor_4c_LocalEest.ContaDs, ;
                                 cursor_4c_LocalEest.RClis, ;
                                 cursor_4c_LocalEest.Usuars, ;
                                 IIF(ISNULL(cursor_4c_LocalEest.Datas), {}, ;
                                     TTOD(cursor_4c_LocalEest.Datas)), ;
                                 IIF(ISNULL(cursor_4c_LocalEest.PrazoEnts), {}, ;
                                     TTOD(cursor_4c_LocalEest.PrazoEnts)), ;
                                 cursor_4c_LocalEest.EmpDs, ;
                                 cursor_4c_LocalEstPd.Qtds)
                        ENDSCAN
                        USE IN cursor_4c_LocalEest
                    ELSE
                        MsgErro("Falha ao carregar movimentos: " + ;
                                ALLTRIM(cursor_4c_LocalEstPd.EmpDopNums), ;
                                "Erro SQL")
                    ENDIF
                ENDSCAN

                IF USED("cursor_4c_LocalEstPd")
                    USE IN cursor_4c_LocalEstPd
                ENDIF

                *-- Calcular total de quantidades em aberto
                loc_nTotal = 0
                SELECT SUM(Pendentes) AS nTotalPs ;
                  FROM cursor_4c_Grade ;
                  INTO CURSOR cursor_4c_TotalPs

                IF USED("cursor_4c_TotalPs")
                    SELECT cursor_4c_TotalPs
                    GO TOP
                    IF !EOF()
                        loc_nTotal = NVL(nTotalPs, 0)
                    ENDIF
                    USE IN cursor_4c_TotalPs
                ENDIF

                THIS.this_nTotalPendentes = loc_nTotal

                *-- Inserir totalizador no rodape
                IF USED("cursor_4c_Rodape")
                    INSERT INTO cursor_4c_Rodape (Pendentes) VALUES (loc_nTotal)
                ENDIF

                *-- Posicionar no inicio para exibicao no grid
                IF USED("cursor_4c_Grade") AND !EOF("cursor_4c_Grade")
                    GO TOP IN cursor_4c_Grade
                ENDIF
                IF USED("cursor_4c_Rodape") AND !EOF("cursor_4c_Rodape")
                    GO TOP IN cursor_4c_Rodape
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Selecionar Dados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave de filtro da sessao (this_cKey)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cKey)
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarChaveEmpDopNum - Concatena Emps + Dopes + Numes no formato legado
    * Usado para localizar a linha de SigMvCab da operacao corrente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarChaveEmpDopNum()
        RETURN ALLTRIM(THIS.this_cEmps) + ;
               ALLTRIM(THIS.this_cDopes) + ;
               PADL(ALLTRIM(STR(THIS.this_nNumes, 6, 0)), 6, "0")
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigMvCab com os campos rastreados pelo BO
    * Os demais campos NOT NULL recebem defaults seguros para que o INSERT
    * passe na validacao do schema.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        LOCAL loc_oErro, loc_cChave

        loc_lResultado = .F.

        TRY
            loc_cChave = THIS.MontarChaveEmpDopNum()

            IF EMPTY(loc_cChave)
                THIS.this_cMensagemErro = "Chave EmpDopNum vazia: " + ;
                                          "Emps/Dopes/Numes nao preenchidos."
                loc_lResultado = .F.
            ENDIF

            loc_cSQL = "INSERT INTO SigMvCab " + ;
                       "(cidchaves, emps, empds, dopes, numes, grupods, " + ;
                       " contads, usuars, datas, prazoents, " + ;
                       " npedclis, acres, antecs, chksubn, codpeds, contaos, " + ;
                       " desc2s, descs, devols, grresps, grupoos, grupos, " + ;
                       " grvends, iclis, ifors, locals, lotechqs, lprecos, " + ;
                       " mascnum, ncarnecs, nemps, nops, notas, nrcons, " + ;
                       " ntrans, numolds, opers, resps, tabds, tpfats, " + ;
                       " transps, usuals, usulibs, valacres, valdes2s, " + ;
                       " valdescs, valdevs, valencs, valinis, valos, " + ;
                       " valservs, valvars, vars, vends, cotusus, espes, " + ;
                       " qtdes, lcancelas, cofs, livros, chkbxparcs, ecfs, " + ;
                       " codobs, dgopes, trfisicos, utilizados, valndevs, " + ;
                       " valobxs, noforms, auditors, usuconfs) " + ;
                       "VALUES (" + ;
                       EscaparSQL(LEFT(loc_cChave, 20)) + ", " + ;
                       EscaparSQL(THIS.this_cEmps) + ", " + ;
                       EscaparSQL(THIS.this_cEmpDs) + ", " + ;
                       EscaparSQL(THIS.this_cDopes) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumes, 0) + ", " + ;
                       EscaparSQL(THIS.this_cGrupoDs) + ", " + ;
                       EscaparSQL(THIS.this_cContaDs) + ", " + ;
                       EscaparSQL(THIS.this_cUsuars) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       FormatarDataSQL(THIS.this_dPrazoEnts) + ", " + ;
                       "0, 0, '', 0, 0, '', " + ;
                       "0, 0, 0, '', '', '', " + ;
                       "'', '', '', '', 0, '', " + ;
                       "'', '', '', 0, '', '', " + ;
                       "0, 0, '', '', '', '', " + ;
                       "0, '', '', 0, 0, " + ;
                       "0, 0, 0, 0, 0, " + ;
                       "0, 0, 0, '', '', '', " + ;
                       "0, 0, 0, 0, 0, '', " + ;
                       "0, '', 0, 0, 0, " + ;
                       "0, '', '', '')"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir registro em SigMvCab"
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro Inserir: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigMvCab com os campos rastreados pelo BO
    * Filtra pela combinacao Emps + Dopes + Numes (equivalente a EmpDopNums)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        LOCAL loc_oErro

        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cEmps) OR EMPTY(THIS.this_cDopes) OR ;
               THIS.this_nNumes = 0
                THIS.this_cMensagemErro = "Chave (Emps/Dopes/Numes) " + ;
                                          "vazia para UPDATE."
                loc_lResultado = .F.
            ENDIF

            loc_cSQL = "UPDATE SigMvCab SET " + ;
                       " empds    = " + EscaparSQL(THIS.this_cEmpDs)   + ", " + ;
                       " grupods  = " + EscaparSQL(THIS.this_cGrupoDs) + ", " + ;
                       " contads  = " + EscaparSQL(THIS.this_cContaDs) + ", " + ;
                       " usuars   = " + EscaparSQL(THIS.this_cUsuars)  + ", " + ;
                       " datas    = " + FormatarDataSQL(THIS.this_dDatas)     + ", " + ;
                       " prazoents= " + FormatarDataSQL(THIS.this_dPrazoEnts) + ;
                       " WHERE emps  = " + EscaparSQL(THIS.this_cEmps)  + ;
                       "   AND dopes = " + EscaparSQL(THIS.this_cDopes) + ;
                       "   AND numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar registro em SigMvCab"
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro Atualizar: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

