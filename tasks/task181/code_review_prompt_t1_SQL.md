# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (10)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPDOPNUMS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EAN13' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CBARS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DPROS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DPRO2S' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DISPLAY' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS
- [TRANSACAO-AVULSA] Linha 746: SQLEXEC com 'COMMIT' mas NAO existe BEGIN TRANSACTION no codigo. A conexao ODBC usa AUTOCOMMIT - cada SQLEXEC ja eh transacao implicita. CORRIGIR: Remover SQLEXEC com COMMIT e ROLLBACK. Para operacoes simples (1 UPDATE), nao precisa de transacao explicita. Usar transacoes SOMENTE para operacoes multi-statement (2+ UPDATE/INSERT atomicos).
- [TRANSACAO-AVULSA] Linha 755: SQLEXEC com 'ROLLBACK' mas NAO existe BEGIN TRANSACTION no codigo. A conexao ODBC usa AUTOCOMMIT - cada SQLEXEC ja eh transacao implicita. CORRIGIR: Remover SQLEXEC com COMMIT e ROLLBACK. Para operacoes simples (1 UPDATE), nao precisa de transacao explicita. Usar transacoes SOMENTE para operacoes multi-statement (2+ UPDATE/INSERT atomicos).

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
  Column1.ControlSource = "dbimpressao.cpros"
  Column2.ControlSource = "dbimpressao.dpros"
  Column3.ControlSource = "dbimpressao.qtds"
  Column4.ControlSource = "dbimpressao.Dpro2s"
  Column5.ControlSource = "dbimpressao.parcelas"
  Column6.ControlSource = "dbimpressao.PVens"
  Column7.ControlSource = "dbimpressao.PrecoDe"
  ControlSource = "dbimpressao.cpros"
  ControlSource = "dbimpressao.dpros"
  ControlSource = "dbimpressao.qtds"
  ControlSource = "dbimpressao.reffs"
  ControlSource = ""
				Insert Into crImpre	(impres) Values(Upper(laPrinters(lnI, 1)))
		Select crSigCdTpe
		Select crSigCdTpe
		lcSql = [Select b.Impres ] + ;
				  [From SigSyImp a, SigCdmp b ] + ;
				[Select c.Impres ] + ;
				  [From SigCdAcG a, SigSyImp b, SigCdmp c ] + ;
		If ThisForm.podatamgr.sqlexecute(lcSql,'crTmpCimp') <= 0
		Select crTmpCImp
			Select Distinct Impres ;
			  From crTmpCImp ;
			lcQuery = [Select Distinct Impres ] + ;
					    [From SigCdmp ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdmp]) < 1)
		Select crSigCdmp
		SELECT PADR(ALLTRIM(a.Impres),15)+' '+ALLTRIM(b.impres) as IDupla, b.impres, a.impres as impresS from crSigCdmp a, crImpre b where ALLTRIM(UPPER(a.impres)) like '%'+ALLTRIM(UPPER(b.impres))+'%' ;
		SELECT * FROM crImp order by 1 into cursor crImpreV
		SELECT crImpreV
	Select CPros From dbImpressao Where Not Empty(Cpros) Into Cursor TmpDig
			Select LocalLPreI
				Insert Into dbImpressao (Cpros, DPros, Qtds, QtdeEtiq, Obs, PVens, empos, PrecoDe) ;
	Select dbImpressao
	Select crSigCdUni
	lcQuery = [Select LPrecos, CPros, DPros, PVens, PrecoDe, VencIs, VencFs ] + ;
			    [From SigCdLpi ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalLPreI') < 1)
	Select LocalLPreI
Select dbImpressao
If Not Seek(cChave)
Select CPros From dbImpressao Where Not Empty(Cpros) Into Cursor TmpDig
		Select LocalEestI
			Insert Into dbImpressao (Cpros, DPros, Qtds, QtdeEtiq, Obs, PVens, empos, empdopnums, citens, Pesos, PrecoDe) ;
	Select dbImpressao
		lcQuery = [Select LPrecos, CPros, DPros, PVens, PrecoDe, VencIs, VencFs ] + ;
				    [From SigCdLpi ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalLPreI') < 1)
		Select LocalLPreI
Select dbImpressao
Select dbImpressao
Delete
Select dbImpressao
Select * From DbImpressao Where 0=1 Into Cursor crOrdenado ReadWrite
Select dbImpressao
Delete From dbImpressao Where Qtds <= 0 
Select DbImpressao
	Insert Into crOrdenado From Memvar
Select crOrdenado
	Insert Into DbImpressao From Memvar
Select dbImpressao

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEtq.prg) - TRECHOS RELEVANTES PARA PASS SQL (2672 linhas total):

*-- Linhas 60 a 99:
60:             ENDIF
61: 
62:             SET NULL ON
63:             CREATE CURSOR dbImpressao ;
64:                 (Cpros       C(14)   NULL, ;
65:                  DPros       C(40)   NULL, ;
66:                  Reffs       C(40)   NULL, ;
67:                  Qtds        N(10,3) NULL, ;
68:                  QtdeEtiq    N(10,3) NULL, ;
69:                  Pedido      C(30)   NULL, ;
70:                  Obs         C(10)   NULL, ;
71:                  PVens       N(12,2) NULL, ;
72:                  PrecoDe     N(12,2) NULL, ;
73:                  Parcelas    N(2,0)  NULL, ;
74:                  Cpros2      C(14)   NULL, ;
75:                  Cpros3      C(14)   NULL, ;
76:                  Cpros4      C(14)   NULL, ;
77:                  empos       C(3)    NULL, ;
78:                  empdopnums  C(29)   NULL, ;
79:                  citens      N(10,0) NULL, ;
80:                  Pesos       N(12,2) NULL, ;
81:                  CodTams     C(4)    NULL, ;
82:                  DPro2s      C(45)   NULL)
83:             SET NULL OFF
84:             SET DELETED ON
85: 
86:             INDEX ON Cpros   TAG Cpros
87:             INDEX ON RECNO() TAG Registros
88:             SET ORDER TO
89:             APPEND BLANK
90: 
91:             *-- Estrutura visual: cabecalho cinza + todos os controles do form plano
92:             THIS.ConfigurarPageFrame()
93:             THIS.ConfigurarPaginaLista()
94:             THIS.ConfigurarPaginaDados()
95:             THIS.CarregarTiposEtiqueta()
96:             THIS.CarregarImpressoras()
97: 
98:             *-- BINDEVENT grid: AfterRowColChange para lookup de colunas
99:             BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")

*-- Linhas 258 a 403:
258:                 .Width        = 818
259:                 .Height       = 157
260:                 .RecordMark   = .F.
261:                 .DeleteMark   = .F.
262:                 .FontName     = "Tahoma"
263:                 .FontSize     = 8
264:                 .HeaderHeight = 17
265:                 .RowHeight    = 17
266:                 .ScrollBars   = 2
267:                 .ColumnCount  = 7
268:                 .RecordSource = "dbImpressao"
269: 
270:                 *-- Column1: Produto (cpros)
271:                 WITH .Column1
272:                     .ControlSource = "dbImpressao.cpros"
273:                     .Width         = 110
274:                     .Movable       = .F.
275:                     .Resizable     = .F.
276:                     .FontName      = "Tahoma"
277:                     .FontSize      = 8
278:                     WITH .Header1
279:                         .FontName  = "Tahoma"
280:                         .FontSize  = 8
281:                         .Alignment = 2
282:                         .Caption   = "Produto"
283:                         .ForeColor = RGB(90,90,90)
284:                     ENDWITH
285:                     WITH .Text1
286:                         .FontName      = "Tahoma"
287:                         .FontSize      = 8
288:                         .BorderStyle   = 0
289:                         .ControlSource = "dbImpressao.cpros"
290:                         .Format        = "!"
291:                         .InputMask     = ""
292:                         .Margin        = 0
293:                         .MaxLength     = 14
294:                         .ForeColor     = RGB(0,0,0)
295:                         .BackColor     = RGB(255,255,255)
296:                         .Name          = "txt_4c_cpros"
297:                     ENDWITH
298:                 ENDWITH
299: 
300:                 *-- Column2: Descricao (dpros) - ColumnOrder=3
301:                 WITH .Column2
302:                     .ColumnOrder   = 3
303:                     .ControlSource = "dbImpressao.dpros"
304:                     .Width         = 270
305:                     .Movable       = .F.
306:                     .Resizable     = .F.
307:                     .FontName      = "Tahoma"
308:                     .FontSize      = 8
309:                     WITH .Header1
310:                         .FontName  = "Tahoma"
311:                         .FontSize  = 8
312:                         .Alignment = 2
313:                         .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
314:                         .ForeColor = RGB(90,90,90)
315:                     ENDWITH
316:                     WITH .Text1
317:                         .FontName      = "Tahoma"
318:                         .FontSize      = 8
319:                         .BorderStyle   = 0
320:                         .ControlSource = "dbImpressao.dpros"
321:                         .Margin        = 0
322:                         .ForeColor     = RGB(0,0,0)
323:                         .BackColor     = RGB(255,255,255)
324:                         .Name          = "txt_4c_dpros"
325:                     ENDWITH
326:                 ENDWITH
327: 
328:                 *-- Column3: Quantidade (qtds) - ColumnOrder=4
329:                 WITH .Column3
330:                     .ColumnOrder   = 4
331:                     .ControlSource = "dbImpressao.qtds"
332:                     .Width         = 65
333:                     .Movable       = .F.
334:                     .Resizable     = .F.
335:                     .FontName      = "Tahoma"
336:                     .FontSize      = 8
337:                     WITH .Header1
338:                         .FontName  = "Tahoma"
339:                         .FontSize  = 8
340:                         .Alignment = 2
341:                         .Caption   = "Quantidade"
342:                         .ForeColor = RGB(90,90,90)
343:                     ENDWITH
344:                     WITH .Text1
345:                         .FontName      = "Tahoma"
346:                         .FontSize      = 8
347:                         .BorderStyle   = 0
348:                         .ControlSource = "dbImpressao.qtds"
349:                         .Format        = "999,999.99"
350:                         .InputMask     = "999,999.99"
351:                         .Margin        = 0
352:                         .MaxLength     = 10
353:                         .ForeColor     = RGB(0,0,0)
354:                         .BackColor     = RGB(255,255,255)
355:                         .Name          = "txt_4c_qtds"
356:                     ENDWITH
357:                 ENDWITH
358: 
359:                 *-- Column4: Ref.Fornecedor display=DPro2s, edicao=reffs - ColumnOrder=2
360:                 WITH .Column4
361:                     .ColumnOrder   = 2
362:                     .ControlSource = "dbImpressao.Dpro2s"
363:                     .Width         = 135
364:                     .FontName      = "Tahoma"
365:                     .FontSize      = 8
366:                     WITH .Header1
367:                         .FontName  = "Tahoma"
368:                         .FontSize  = 8
369:                         .Alignment = 2
370:                         .Caption   = "Refer" + CHR(234) + "ncia Fornecedor"
371:                         .ForeColor = RGB(90,90,90)
372:                     ENDWITH
373:                     WITH .Text1
374:                         .FontName      = "Tahoma"
375:                         .FontSize      = 8
376:                         .BorderStyle   = 0
377:                         .ControlSource = "dbImpressao.reffs"
378:                         .Format        = "!"
379:                         .Margin        = 0
380:                         .ForeColor     = RGB(0,0,0)
381:                         .BackColor     = RGB(255,255,255)
382:                         .Name          = "txt_4c_reffs"
383:                     ENDWITH
384:                 ENDWITH
385: 
386:                 *-- Column5: Parcelas (par)
387:                 WITH .Column5
388:                     .ControlSource = "dbImpressao.parcelas"
389:                     .Width         = 60
390:                     .Movable       = .F.
391:                     .Resizable     = .F.
392:                     .FontName      = "Tahoma"
393:                     .FontSize      = 8
394:                     WITH .Header1
395:                         .FontName  = "Tahoma"
396:                         .FontSize  = 8
397:                         .Alignment = 2
398:                         .Caption   = "Parcelas"
399:                         .ForeColor = RGB(90,90,90)
400:                     ENDWITH
401:                     WITH .Text1
402:                         .FontName    = "Tahoma"
403:                         .FontSize    = 8

*-- Linhas 411 a 429:
411: 
412:                 *-- Column6: Preco (PVens) - somente leitura
413:                 WITH .Column6
414:                     .ControlSource = "dbImpressao.PVens"
415:                     .Enabled       = .F.
416:                     .Width         = 70
417:                     .Movable       = .F.
418:                     .Resizable     = .F.
419:                     .ReadOnly      = .T.
420:                     .FontName      = "Tahoma"
421:                     .FontSize      = 8
422:                     WITH .Header1
423:                         .FontName  = "Tahoma"
424:                         .FontSize  = 8
425:                         .Alignment = 2
426:                         .Caption   = "Pre" + CHR(231) + "o"
427:                         .ForeColor = RGB(90,90,90)
428:                     ENDWITH
429:                     WITH .Text1

*-- Linhas 441 a 459:
441: 
442:                 *-- Column7: Preco De (PrecoDe) - somente leitura
443:                 WITH .Column7
444:                     .ControlSource = "dbImpressao.PrecoDe"
445:                     .Enabled       = .F.
446:                     .Width         = 70
447:                     .Movable       = .F.
448:                     .Resizable     = .F.
449:                     .ReadOnly      = .T.
450:                     .FontName      = "Tahoma"
451:                     .FontSize      = 8
452:                     WITH .Header1
453:                         .FontName  = "Tahoma"
454:                         .FontSize  = 8
455:                         .Alignment = 2
456:                         .Caption   = "Pre" + CHR(231) + "o De"
457:                         .ForeColor = RGB(90,90,90)
458:                     ENDWITH
459:                     WITH .Text1

*-- Linhas 584 a 641:
584: 
585:             IF loc_lContinuar
586:                 *-- Reordenar dbImpressao: remove Qtds<=0 e ordena conforme opcao
587:                 SELECT * FROM dbImpressao WHERE 0=1 INTO CURSOR cursor_4c_Ordenado READWRITE
588: 
589:                 SELECT dbImpressao
590:                 DELETE FROM dbImpressao WHERE Qtds <= 0
591: 
592:                 IF THIS.obj_4c_OptOrdem.Value = 1
593:                     SET ORDER TO Cpros
594:                 ELSE
595:                     SET ORDER TO Registros
596:                 ENDIF
597: 
598:                 SELECT dbImpressao
599:                 SCAN
600:                     SCATTER MEMVAR MEMO
601:                     INSERT INTO cursor_4c_Ordenado FROM MEMVAR
602:                 ENDSCAN
603: 
604:                 ZAP IN dbImpressao
605:                 SET ORDER TO
606: 
607:                 SELECT cursor_4c_Ordenado
608:                 SCAN
609:                     SCATTER MEMVAR MEMO
610:                     INSERT INTO dbImpressao FROM MEMVAR
611:                 ENDSCAN
612: 
613:                 IF USED("cursor_4c_Ordenado")
614:                     USE IN cursor_4c_Ordenado
615:                 ENDIF
616: 
617:                 *-- Transfere parametros dos controles para o BO
618:                 THIS.FormParaBO()
619: 
620:                 IF THIS.this_oBusinessObject.ImprimirEtiquetas()
621:                     MsgInfo("Impress" + CHR(227) + "o Conclu" + CHR(237) + "da!!!")
622: 
623:                     THIS.txt_4c_Lpreco.Value  = ""
624:                     THIS.txt_4c_LPreco2.Value = ""
625: 
626:                     SELECT dbImpressao
627:                     ZAP
628:                     APPEND BLANK
629:                     THIS.grd_4c_Dados.SetFocus
630:                     THIS.grd_4c_Dados.col_4c_cpros.SetFocus
631:                 ENDIF
632:             ENDIF
633: 
634:             loc_lSucesso = .T.
635: 
636:         CATCH TO loc_oErro
637:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
638:                     " PROC=" + loc_oErro.Procedure, ;
639:                     "Erro FormSigPrEtq.BtnImprimeClick")
640:         ENDTRY
641: 

*-- Linhas 656 a 678:
656:         LOCAL loc_oErro
657: 
658:         TRY
659:             SELECT dbImpressao
660:             DELETE
661:             LOCATE FOR .F.
662: 
663:             SELECT dbImpressao
664:             GO TOP IN dbImpressao
665:             IF EOF("dbImpressao")
666:                 APPEND BLANK IN dbImpressao
667:             ENDIF
668:             GO TOP IN dbImpressao
669: 
670:             THIS.grd_4c_Dados.Refresh()
671: 
672:         CATCH TO loc_oErro
673:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
674:                     " PROC=" + loc_oErro.Procedure, ;
675:                     "Erro FormSigPrEtq.BtnExcluirClick")
676:         ENDTRY
677:     ENDPROC
678: 

*-- Linhas 707 a 725:
707: 
708:             IF loc_lContinuar
709:                 *-- Verificar se ja existem etiquetas na grade e confirmar substituicao
710:                 SELECT Cpros FROM dbImpressao WHERE !EMPTY(Cpros) INTO CURSOR cursor_4c_TmpDig
711:                 IF _TALLY > 0
712:                     loc_lContinuar = MsgConfirma("Existem Etiquetas na Grade! " + ;
713:                         "Deseja Refazer a Sele" + CHR(231) + CHR(227) + "o?")
714:                 ENDIF
715:                 IF USED("cursor_4c_TmpDig")
716:                     USE IN cursor_4c_TmpDig
717:                 ENDIF
718:             ENDIF
719: 
720:             IF loc_lContinuar
721:                 ZAP IN dbImpressao
722: 
723:                 loc_nItens = THIS.this_oBusinessObject.CarregarPorMovimentacao( ;
724:                     THIS.txt_4c_Emps.Value, ;
725:                     THIS.txt_4c_Dopes.Value, ;

*-- Linhas 732 a 771:
732:                     THIS.txt_4c_Emps.SetFocus
733:                 ELSE
734:                     *-- Aplicar lista de precos por item se preenchida e nao em modo chkLista
735:                     IF THIS.chk_4c_ChkLista.Value <> 1 AND !EMPTY(THIS.txt_4c_Lpreco.Value)
736:                         SELECT dbImpressao
737:                         SCAN
738:                             IF !EMPTY(dbImpressao.Cpros)
739:                                 THIS.this_oBusinessObject.AplicarListaPrecoNoItem( ;
740:                                     THIS.txt_4c_Lpreco.Value, ;
741:                                     ALLTRIM(dbImpressao.Cpros))
742:                             ENDIF
743:                         ENDSCAN
744:                     ENDIF
745:                 ENDIF
746: 
747:                 SELECT dbImpressao
748:                 IF RECCOUNT("dbImpressao") = 0
749:                     APPEND BLANK IN dbImpressao
750:                 ENDIF
751:                 GO TOP IN dbImpressao
752: 
753:                 THIS.grd_4c_Dados.Refresh()
754:             ENDIF
755: 
756:             loc_lSucesso = .T.
757: 
758:         CATCH TO loc_oErro
759:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
760:                     " PROC=" + loc_oErro.Procedure, ;
761:                     "Erro FormSigPrEtq.BtnCarregarClick")
762:         ENDTRY
763: 
764:         RETURN loc_lSucesso
765:     ENDPROC
766: 
767:     *--------------------------------------------------------------------------
768:     * ConfigurarPaginaDados - Cria controles de filtros/parametros (Parte 1):
769:     * Secao Lista de Precos, Movimentacoes e Tipo de Etiqueta
770:     *--------------------------------------------------------------------------
771:     PROTECTED PROCEDURE ConfigurarPaginaDados()

*-- Linhas 1592 a 1621:
1592:         loc_nHeight = 15
1593: 
1594:         TRY
1595:             IF SQLEXEC(gnConnHandle, ;
1596:                 "SELECT nTipos, RTRIM(cEtiquetas) AS cEtiquetas " + ;
1597:                 "FROM SigCdTpe WHERE nSituas = 1 ORDER BY cOrdems, cEtiquetas", ;
1598:                 "cursor_4c_TiposEti") > 0
1599: 
1600:                 SELECT cursor_4c_TiposEti
1601:                 loc_nTipos = RECCOUNT("cursor_4c_TiposEti")
1602: 
1603:                 IF loc_nTipos > 0
1604:                     WITH THIS.obj_4c_Opt_Tipo
1605:                         .ButtonCount = loc_nTipos
1606:                         SELECT cursor_4c_TiposEti
1607:                         GO TOP IN cursor_4c_TiposEti
1608:                         DO WHILE !EOF("cursor_4c_TiposEti")
1609:                             WITH .Buttons(loc_nI)
1610:                                 .AutoSize  = .F.
1611:                                 .Width     = 197
1612:                                 .Caption   = " \<" + CHR(96 + loc_nI) + ". " + ;
1613:                                              ALLTRIM(cursor_4c_TiposEti.cEtiquetas)
1614:                                 .ForeColor = RGB(90,90,90)
1615:                                 .Tag       = ALLTRIM(STR(cursor_4c_TiposEti.nTipos))
1616:                                 .Top       = loc_nTop
1617:                                 .BackStyle = 0
1618:                                 .Height    = 16
1619:                                 .Left      = 9
1620:                             ENDWITH
1621:                             loc_nI      = loc_nI + 1

*-- Linhas 1678 a 1698:
1678: 
1679:             *-- Tenta match exato
1680:             IF !EMPTY(loc_cValor)
1681:                 loc_nRet = SQLEXEC(gnConnHandle, ;
1682:                     "SELECT TOP 1 RTRIM(LPrecos) AS LPrecos FROM SigCdLpc " + ;
1683:                     "WHERE RTRIM(LPrecos) = " + EscaparSQL(loc_cValor), ;
1684:                     "cursor_4c_ChkLpc")
1685:                 IF loc_nRet > 0 AND !EOF("cursor_4c_ChkLpc")
1686:                     par_oTxt.Value = ALLTRIM(cursor_4c_ChkLpc.LPrecos)
1687:                     loc_lEncontrado = .T.
1688:                     IF UPPER(par_oTxt.Name) = "TXT_4C_LPRECO" AND ;
1689:                        THIS.chk_4c_ChkLista.Value = 1
1690:                         THIS.CarregarItensListaPreco(par_oTxt.Value)
1691:                     ENDIF
1692:                 ENDIF
1693:                 IF USED("cursor_4c_ChkLpc")
1694:                     USE IN cursor_4c_ChkLpc
1695:                 ENDIF
1696:             ENDIF
1697: 
1698:             *-- Match nao encontrado: abre picker

*-- Linhas 1739 a 1798:
1739:         TRY
1740:             ZAP IN dbImpressao
1741: 
1742:             loc_cSQL = "SELECT RTRIM(a.LPrecos) AS LPrecos, RTRIM(a.CPros) AS Cpros, " + ;
1743:                        "RTRIM(a.DPros) AS DPros, a.PVens, a.Precode AS PrecoDe, " + ;
1744:                        "a.VencIs, a.VencFs " + ;
1745:                        "FROM SigCdLpi a " + ;
1746:                        "WHERE RTRIM(a.LPrecos) = " + EscaparSQL(par_cLPreco)
1747: 
1748:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LpreI") > 0
1749:                 SELECT cursor_4c_LpreI
1750:                 SCAN
1751:                     loc_nPVens   = cursor_4c_LpreI.PVens
1752:                     loc_nPrecoDe = cursor_4c_LpreI.PrecoDe
1753: 
1754:                     *-- Se preco da lista expirou, usa preco atual do produto
1755:                     IF !BETWEEN(DATETIME(), cursor_4c_LpreI.VencIs, cursor_4c_LpreI.VencFs)
1756:                         loc_nRetPro = SQLEXEC(gnConnHandle, ;
1757:                             "SELECT TOP 1 PVens, PrecoDe FROM SigCdPro " + ;
1758:                             "WHERE RTRIM(CPros) = " + ;
1759:                             EscaparSQL(ALLTRIM(cursor_4c_LpreI.Cpros)), ;
1760:                             "cursor_4c_LproPro")
1761:                         IF loc_nRetPro > 0 AND !EOF("cursor_4c_LproPro")
1762:                             loc_nPVens   = cursor_4c_LproPro.PVens
1763:                             loc_nPrecoDe = cursor_4c_LproPro.PrecoDe
1764:                         ENDIF
1765:                         IF USED("cursor_4c_LproPro")
1766:                             USE IN cursor_4c_LproPro
1767:                         ENDIF
1768:                     ENDIF
1769: 
1770:                     INSERT INTO dbImpressao ;
1771:                         (Cpros, DPros, Qtds, QtdeEtiq, Obs, PVens, empos, PrecoDe) ;
1772:                     VALUES ;
1773:                         (cursor_4c_LpreI.Cpros, cursor_4c_LpreI.DPros, 1, 1, ;
1774:                          PADR(par_cLPreco, 10), loc_nPVens, ;
1775:                          go_4c_Sistema.cCodEmpresa, loc_nPrecoDe)
1776:                 ENDSCAN
1777: 
1778:                 IF USED("cursor_4c_LpreI")
1779:                     USE IN cursor_4c_LpreI
1780:                 ENDIF
1781:             ENDIF
1782: 
1783:             SELECT dbImpressao
1784:             IF RECCOUNT("dbImpressao") = 0
1785:                 APPEND BLANK IN dbImpressao
1786:             ENDIF
1787:             GO TOP IN dbImpressao
1788:             THIS.grd_4c_Dados.Refresh()
1789: 
1790:             loc_lSucesso = .T.
1791: 
1792:         CATCH TO loc_oErro
1793:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1794:                     " PROC=" + loc_oErro.Procedure, ;
1795:                     "Erro FormSigPrEtq.CarregarItensListaPreco")
1796:         ENDTRY
1797: 
1798:         RETURN loc_lSucesso

*-- Linhas 1822 a 1842:
1822: 
1823:             *-- Tenta match exato
1824:             IF !EMPTY(loc_cValor)
1825:                 loc_nRet = SQLEXEC(gnConnHandle, ;
1826:                     "SELECT TOP 1 RTRIM(Cemps) AS Cemps FROM SigCdEmp " + ;
1827:                     "WHERE RTRIM(Cemps) = " + EscaparSQL(loc_cValor), ;
1828:                     "cursor_4c_ChkEmp")
1829:                 IF loc_nRet > 0 AND !EOF("cursor_4c_ChkEmp")
1830:                     THIS.txt_4c_Emps.Value = ALLTRIM(cursor_4c_ChkEmp.Cemps)
1831:                     loc_lEncontrado = .T.
1832:                 ENDIF
1833:                 IF USED("cursor_4c_ChkEmp")
1834:                     USE IN cursor_4c_ChkEmp
1835:                 ENDIF
1836:             ENDIF
1837: 
1838:             *-- Abre picker se nao encontrou match exato
1839:             IF !loc_lEncontrado
1840:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdEmp", ;
1841:                     "cursor_4c_BuscaEmp", "Cemps", loc_cValor, ;
1842:                     "Sele" + CHR(231) + CHR(227) + "o de Empresa", .T., .T., "")

*-- Linhas 1888 a 1908:
1888: 
1889:             *-- Tenta match exato
1890:             IF !EMPTY(loc_cValor)
1891:                 loc_nRet = SQLEXEC(gnConnHandle, ;
1892:                     "SELECT TOP 1 RTRIM(Dopes) AS Dopes FROM SigCdOpe " + ;
1893:                     "WHERE RTRIM(Dopes) = " + EscaparSQL(loc_cValor), ;
1894:                     "cursor_4c_ChkOpe")
1895:                 IF loc_nRet > 0 AND !EOF("cursor_4c_ChkOpe")
1896:                     THIS.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_ChkOpe.Dopes)
1897:                     loc_lEncontrado = .T.
1898:                 ENDIF
1899:                 IF USED("cursor_4c_ChkOpe")
1900:                     USE IN cursor_4c_ChkOpe
1901:                 ENDIF
1902:             ENDIF
1903: 
1904:             *-- Abre picker (SigCdOpe: Dopes eh PK e descricao - coluna unica)
1905:             IF !loc_lEncontrado
1906:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdOpe", ;
1907:                     "cursor_4c_BuscaOpe", "Dopes", loc_cValor, ;
1908:                     "Opera" + CHR(231) + CHR(227) + "o", .T., .T., "")

*-- Linhas 1942 a 1973:
1942:             ENDIF
1943: 
1944:             SET NULL ON
1945:             CREATE CURSOR cursor_4c_ImpreV (impresS C(100) NULL)
1946:             SET NULL OFF
1947: 
1948:             DIMENSION la_4c_Printers(1, 3)
1949:             loc_nTotal = APRINTERS(la_4c_Printers)
1950: 
1951:             IF loc_nTotal > 0
1952:                 FOR loc_nI = 1 TO loc_nTotal
1953:                     INSERT INTO cursor_4c_ImpreV VALUES (la_4c_Printers[loc_nI, 1])
1954:                 ENDFOR
1955:             ENDIF
1956: 
1957:             IF RECCOUNT("cursor_4c_ImpreV") = 0
1958:                 INSERT INTO cursor_4c_ImpreV VALUES ("Impressora Padr" + CHR(227) + "o")
1959:             ENDIF
1960: 
1961:             GO TOP IN cursor_4c_ImpreV
1962: 
1963:             THIS.cbo_4c_Get_Printer.RowSourceType = 2
1964:             THIS.cbo_4c_Get_Printer.RowSource     = "cursor_4c_ImpreV"
1965:             THIS.cbo_4c_Get_Printer.BoundColumn   = 1
1966:             THIS.cbo_4c_Get_Printer.BoundTo       = .F.
1967:             THIS.cbo_4c_Get_Printer.Refresh()
1968: 
1969:         CATCH TO loc_oErro
1970:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1971:                     " PROC=" + loc_oErro.Procedure, ;
1972:                     "Erro FormSigPrEtq.CarregarImpressoras")
1973:         ENDTRY

*-- Linhas 2033 a 2076:
2033:             *-- 1. Tentar match por EAN13 (numerico inteiro)
2034:             loc_nCod = INT(VAL(loc_cProd))
2035:             IF loc_nCod > 0
2036:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2037:                     "SELECT TOP 1 RTRIM(CPros) AS Cpros, RTRIM(DPros) AS DPros, " + ;
2038:                     "PVens, PrecoDe FROM SigCdPro " + ;
2039:                     "WHERE Ean13 = " + FormatarNumeroSQL(loc_nCod), ;
2040:                     "cursor_4c_PrEan")
2041:                 IF loc_nRet > 0 AND !EOF("cursor_4c_PrEan")
2042:                     dbImpressao.Cpros = PADR(ALLTRIM(cursor_4c_PrEan.Cpros), 14)
2043:                     dbImpressao.DPros = PADR(ALLTRIM(cursor_4c_PrEan.DPros), 40)
2044:                     dbImpressao.PVens   = cursor_4c_PrEan.PVens
2045:                     dbImpressao.PrecoDe = cursor_4c_PrEan.PrecoDe
2046:                     THIS.grd_4c_Dados.Refresh()
2047:                     IF USED("cursor_4c_PrEan")
2048:                         USE IN cursor_4c_PrEan
2049:                     ENDIF
2050:                     RETURN
2051:                 ENDIF
2052:                 IF USED("cursor_4c_PrEan")
2053:                     USE IN cursor_4c_PrEan
2054:                 ENDIF
2055:             ENDIF
2056: 
2057:             *-- 2. Tentar match direto por CPros
2058:             loc_nRet = SQLEXEC(gnConnHandle, ;
2059:                 "SELECT TOP 1 RTRIM(CPros) AS Cpros, RTRIM(DPros) AS DPros, " + ;
2060:                 "PVens, PrecoDe FROM SigCdPro " + ;
2061:                 "WHERE RTRIM(CPros) = " + EscaparSQL(loc_cProd), ;
2062:                 "cursor_4c_PrCd")
2063:             IF loc_nRet > 0 AND !EOF("cursor_4c_PrCd")
2064:                 dbImpressao.DPros   = PADR(ALLTRIM(cursor_4c_PrCd.DPros), 40)
2065:                 dbImpressao.PVens   = cursor_4c_PrCd.PVens
2066:                 dbImpressao.PrecoDe = cursor_4c_PrCd.PrecoDe
2067:                 THIS.grd_4c_Dados.Refresh()
2068:                 IF USED("cursor_4c_PrCd")
2069:                     USE IN cursor_4c_PrCd
2070:                 ENDIF
2071:                 RETURN
2072:             ENDIF
2073:             IF USED("cursor_4c_PrCd")
2074:                 USE IN cursor_4c_PrCd
2075:             ENDIF
2076: 

*-- Linhas 2128 a 2148:
2128:             ENDIF
2129: 
2130:             *-- Tentar match por DPros
2131:             loc_nRet = SQLEXEC(gnConnHandle, ;
2132:                 "SELECT TOP 1 RTRIM(CPros) AS Cpros, RTRIM(DPros) AS DPros " + ;
2133:                 "FROM SigCdPro WHERE RTRIM(DPros) = " + EscaparSQL(loc_cDesc), ;
2134:                 "cursor_4c_PrDp")
2135:             IF loc_nRet > 0 AND !EOF("cursor_4c_PrDp")
2136:                 dbImpressao.Cpros = PADR(ALLTRIM(cursor_4c_PrDp.Cpros), 14)
2137:                 THIS.grd_4c_Dados.Refresh()
2138:                 IF USED("cursor_4c_PrDp")
2139:                     USE IN cursor_4c_PrDp
2140:                 ENDIF
2141:                 RETURN
2142:             ENDIF
2143:             IF USED("cursor_4c_PrDp")
2144:                 USE IN cursor_4c_PrDp
2145:             ENDIF
2146: 
2147:             *-- Nao encontrado: abrir picker por descricao
2148:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;

*-- Linhas 2195 a 2216:
2195:             ENDIF
2196: 
2197:             *-- Tentar match por Dpro2s (referencia do fornecedor)
2198:             loc_nRet = SQLEXEC(gnConnHandle, ;
2199:                 "SELECT TOP 1 RTRIM(CPros) AS Cpros, RTRIM(DPros) AS DPros, " + ;
2200:                 "RTRIM(DPro2s) AS DPro2s, PVens, PrecoDe " + ;
2201:                 "FROM SigCdPro WHERE RTRIM(DPro2s) = " + EscaparSQL(loc_cReff), ;
2202:                 "cursor_4c_PrRff")
2203:             IF loc_nRet > 0 AND !EOF("cursor_4c_PrRff")
2204:                 dbImpressao.Cpros   = PADR(ALLTRIM(cursor_4c_PrRff.Cpros), 14)
2205:                 dbImpressao.DPros   = PADR(ALLTRIM(cursor_4c_PrRff.DPros), 40)
2206:                 dbImpressao.PVens   = cursor_4c_PrRff.PVens
2207:                 dbImpressao.PrecoDe = cursor_4c_PrRff.PrecoDe
2208:                 THIS.grd_4c_Dados.Refresh()
2209:                 IF USED("cursor_4c_PrRff")
2210:                     USE IN cursor_4c_PrRff
2211:                 ENDIF
2212:                 RETURN
2213:             ENDIF
2214:             IF USED("cursor_4c_PrRff")
2215:                 USE IN cursor_4c_PrRff
2216:             ENDIF

*-- Linhas 2269 a 2310:
2269:             ENDIF
2270: 
2271:             *-- Validar produto existe em SigCdPro
2272:             loc_nRet = SQLEXEC(gnConnHandle, ;
2273:                 "SELECT TOP 1 RTRIM(CPros) AS Cpros FROM SigCdPro " + ;
2274:                 "WHERE RTRIM(CPros) = " + EscaparSQL(loc_cProd), ;
2275:                 "cursor_4c_PrQt")
2276:             IF loc_nRet <= 0 OR EOF("cursor_4c_PrQt")
2277:                 MsgAviso("Produto Inv" + CHR(225) + "lido!!!")
2278:                 IF USED("cursor_4c_PrQt")
2279:                     USE IN cursor_4c_PrQt
2280:                 ENDIF
2281:                 RETURN
2282:             ENDIF
2283:             IF USED("cursor_4c_PrQt")
2284:                 USE IN cursor_4c_PrQt
2285:             ENDIF
2286: 
2287:             *-- Definir quantidade de etiquetas igual a qtds (se maior que 0)
2288:             IF loc_nQtd > 0
2289:                 dbImpressao.QtdeEtiq = loc_nQtd
2290:             ENDIF
2291: 
2292:             THIS.grd_4c_Dados.Refresh()
2293: 
2294:             *-- Avancar para proxima linha (ENTER = nova linha no grid)
2295:             SELECT dbImpressao
2296:             IF !EOF()
2297:                 SKIP
2298:                 IF EOF()
2299:                     APPEND BLANK
2300:                 ENDIF
2301:             ENDIF
2302: 
2303:             THIS.grd_4c_Dados.Refresh()
2304:             THIS.grd_4c_Dados.SetFocus
2305: 
2306:             loc_lSucesso = .T.
2307: 
2308:         CATCH TO loc_oErro
2309:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2310:                     " PROC=" + loc_oErro.Procedure, ;

*-- Linhas 2363 a 2390:
2363:                 RETURN
2364:             ENDIF
2365: 
2366:             SELECT dbImpressao
2367:             SET ORDER TO
2368: 
2369:             *-- Se a grade tem apenas uma linha em branco padrao, reusa-a
2370:             IF RECCOUNT("dbImpressao") = 1 AND EMPTY(ALLTRIM(NVL(dbImpressao.Cpros, "")))
2371:                 GO TOP IN dbImpressao
2372:             ELSE
2373:                 APPEND BLANK IN dbImpressao
2374:                 *-- Posiciona na ultima linha (a que acabou de ser criada)
2375:                 SELECT dbImpressao
2376:                 GO BOTTOM IN dbImpressao
2377:             ENDIF
2378: 
2379:             THIS.grd_4c_Dados.Refresh()
2380:             THIS.AtualizarEstadoColunas()
2381: 
2382:             *-- Foca a coluna de produto para digitacao imediata
2383:             IF PEMSTATUS(THIS.grd_4c_Dados, "col_4c_cpros", 5)
2384:                 THIS.grd_4c_Dados.SetFocus()
2385:                 THIS.grd_4c_Dados.ActivateCell( ;
2386:                     RECNO("dbImpressao"), 1)
2387:             ENDIF
2388: 
2389:         CATCH TO loc_oErro
2390:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;

*-- Linhas 2407 a 2425:
2407:                 RETURN
2408:             ENDIF
2409: 
2410:             SELECT dbImpressao
2411:             loc_nRecno = RECNO("dbImpressao")
2412: 
2413:             IF EOF("dbImpressao") OR EMPTY(ALLTRIM(NVL(dbImpressao.Cpros, "")))
2414:                 MsgAviso("Selecione um item na grade antes de alterar!!!")
2415:                 THIS.grd_4c_Dados.SetFocus()
2416:                 RETURN
2417:             ENDIF
2418: 
2419:             *-- Permite editar Parcelas se a modalidade Preco = Parcelamento (6)
2420:             IF THIS.obj_4c_Opt_Preco.Value = 6
2421:                 THIS.grd_4c_Dados.col_4c_par.ReadOnly = .F.
2422:             ENDIF
2423: 
2424:             THIS.grd_4c_Dados.Refresh()
2425: 

*-- Linhas 2453 a 2474:
2453:             loc_nQtdTotal = 0
2454: 
2455:             *-- Conta itens validos (Cpros preenchido)
2456:             SELECT COUNT(*) AS nTot, ;
2457:                    COUNT(DISTINCT Cpros) AS nDist, ;
2458:                    SUM(NVL(QtdeEtiq, 0)) AS nQtd ;
2459:                 FROM dbImpressao ;
2460:                 WHERE !EMPTY(NVL(Cpros, "")) ;
2461:                 INTO CURSOR cursor_4c_TmpResumo
2462: 
2463:             IF USED("cursor_4c_TmpResumo") AND !EOF("cursor_4c_TmpResumo")
2464:                 loc_nTotal     = NVL(cursor_4c_TmpResumo.nTot,  0)
2465:                 loc_nDistintos = NVL(cursor_4c_TmpResumo.nDist, 0)
2466:                 loc_nQtdTotal  = NVL(cursor_4c_TmpResumo.nQtd,  0)
2467:             ENDIF
2468: 
2469:             IF USED("cursor_4c_TmpResumo")
2470:                 USE IN cursor_4c_TmpResumo
2471:             ENDIF
2472: 
2473:             IF loc_nTotal = 0
2474:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + ;

*-- Linhas 2483 a 2501:
2483: 
2484:             MsgInfo(loc_cMsg, "Visualizar Impress" + CHR(227) + "o")
2485: 
2486:             SELECT dbImpressao
2487:             GO TOP IN dbImpressao
2488:             THIS.grd_4c_Dados.Refresh()
2489: 
2490:         CATCH TO loc_oErro
2491:             IF USED("cursor_4c_TmpResumo")
2492:                 USE IN cursor_4c_TmpResumo
2493:             ENDIF
2494:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2495:                     " PROC=" + loc_oErro.Procedure, ;
2496:                     "Erro FormSigPrEtq.BtnVisualizarClick")
2497:         ENDTRY
2498:     ENDPROC
2499: 
2500:     *--------------------------------------------------------------------------
2501:     * FormParaBO - Transfere parametros dos controles do form para o BO

*-- Linhas 2552 a 2570:
2552:     *--------------------------------------------------------------------------
2553:     PROCEDURE CarregarLista()
2554:         IF USED("dbImpressao")
2555:             SELECT dbImpressao
2556:             IF RECCOUNT("dbImpressao") = 0
2557:                 APPEND BLANK IN dbImpressao
2558:             ENDIF
2559:             GO TOP IN dbImpressao
2560:         ENDIF
2561: 
2562:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2563:             THIS.grd_4c_Dados.Refresh()
2564:         ENDIF
2565:     ENDPROC
2566: 
2567:     *--------------------------------------------------------------------------
2568:     * LimparCampos - Limpa filtros de entrada e reseta grade dbImpressao
2569:     *--------------------------------------------------------------------------
2570:     PROCEDURE LimparCampos()


### BO (C:\4c\projeto\app\classes\SigPrEtqBO.prg):
*==============================================================================
* SIGPRETQBO.PRG
* Business Object - Impressao de Etiquetas Selecionadas
* Form OPERACIONAL - cursor local dbImpressao, sem tabela principal
*==============================================================================

DEFINE CLASS SigPrEtqBO AS BusinessBase

    *-- Sem tabela principal (form operacional)
    this_cTabela       = ""
    this_cCampoChave   = ""

    *--------------------------------------------------------------------------
    * Parametros de filtro / entrada do usuario
    *--------------------------------------------------------------------------
    this_cEmps         = ""    && Empresa (3 chars)
    this_cDopes        = ""    && Operacao (20 chars)
    this_nNumes        = 0     && Numero do documento
    this_cLPrecos      = ""    && Lista de precos 1 (30 chars)
    this_cLPrecos2     = ""    && Lista de precos 2 (30 chars)

    *--------------------------------------------------------------------------
    * Configuracao da etiqueta (SigCdPam)
    *--------------------------------------------------------------------------
    this_nMaxTpEtis    = 0     && Numero maximo de tipos de etiqueta
    this_nTpEtiPads    = 0     && Tipo de etiqueta padrao
    this_nMaxImpEti    = 0     && Numero maximo de impressoras
    this_nImpEtis      = 0     && Impressora padrao
    this_cTpInstalas   = ""    && Tipo de instalacao
    this_nAjVerts      = 0     && Ajuste vertical padrao (SigCdPam)
    this_nAjHorzs      = 0     && Ajuste horizontal padrao (SigCdPam)
    this_cTpCBars      = ""    && Tipo de codigo de barras

    *--------------------------------------------------------------------------
    * Configuracao adicional (SigCdPac)
    *--------------------------------------------------------------------------
    this_nAjDens       = 20   && Ajuste de densidade padrao
    this_nAjVelos      = 1    && Ajuste de velocidade padrao
    this_nEtqSeps      = 1    && Etiqueta separadora (1=Sim, 2=Nao)

    *--------------------------------------------------------------------------
    * Opcoes de impressao (espelham controles do form)
    *--------------------------------------------------------------------------
    this_nImpPreco     = 1    && Tipo de preco a imprimir (1-6, opt_Preco.Value)
    this_lImpSepar     = .T.  && Imprimir separadora (opt_separador=1)
    this_lImpPeso      = .T.  && Imprimir peso (opt_peso=1)
    this_lCompo        = .T.  && Imprimir composicao (optCompos=1)
    this_nTipo         = 1    && Indice do tipo de etiqueta (Opt_Tipo.Value)
    this_nTpEti        = 0    && ID do tipo de etiqueta (SigCdTpe.nTipos via Tag)
    this_nTpImp        = 1    && Tipo impressora (1=Allegro, 2=Zebra ZPL, 3=Zebra EPL)
    this_nAjVertsPrint = 0    && Ajuste vertical para impressao (Spn_AjVerts.Value)
    this_nAjHorzsPrint = 0    && Ajuste horizontal para impressao (Spn_AjHorzs.Value)
    this_nAjDensPrint  = 20   && Densidade para impressao (Spn_AjDenss.Value)
    this_nAjVelosPrint = 1    && Velocidade para impressao (spn_AjVelos.Value)
    this_cNomeImp      = ""   && Nome da impressora selecionada (crImpreV.impres)
    this_nImpres       = 0    && Numero de registro da impressora (RECNO crImpreV)
    this_cLp1          = ""   && Lista de precos 1 (passada ao SigOpEtq)
    this_cLp2          = ""   && Lista de precos 2 (passada ao SigOpEtq)
    this_nOrdem        = 1    && Ordem de impressao (1=Produto, 2=Nenhuma)

    *--------------------------------------------------------------------------
    * Campos do cursor dbImpressao (linha corrente)
    *--------------------------------------------------------------------------
    this_cReffs        = ""    && Referencia do fornecedor (dbImpressao.Reffs)
    this_nQtds         = 0     && Quantidade (dbImpressao.Qtds)
    this_nQtdeEtiq     = 0     && Quantidade de etiquetas (dbImpressao.QtdeEtiq)
    this_cPedido       = ""    && Numero do pedido (dbImpressao.Pedido)
    this_cObs          = ""    && Obs / lista de precos usada (dbImpressao.Obs)
    this_nParcelas     = 0     && Numero de parcelas (dbImpressao.Parcelas)
    this_cCpros2       = ""    && Codigo produto 2 (dbImpressao.Cpros2)
    this_cCpros3       = ""    && Codigo produto 3 (dbImpressao.Cpros3)
    this_cCpros4       = ""    && Codigo produto 4 (dbImpressao.Cpros4)
    this_cEmpos        = ""    && Empresa (dbImpressao.empos)
    this_cEmpdopnums   = ""    && Chave emp+ope+num (dbImpressao.empdopnums)
    this_nCitens       = 0     && Numero do item (dbImpressao.citens)
    this_nPesos        = 0     && Peso do item (dbImpressao.Pesos)
    this_cCodTams      = ""    && Codigo do tamanho (dbImpressao.CodTams)

    *--------------------------------------------------------------------------
    * Produto corrente (validado no grid)
    *--------------------------------------------------------------------------
    this_cCpros        = ""   && Codigo do produto (SigCdPro.CPros)
    this_cDpros        = ""   && Descricao do produto (SigCdPro.DPros)
    this_cDpro2s       = ""   && Referencia do fornecedor (SigCdPro.Dpro2s)
    this_cCunis        = ""   && Unidade do produto (SigCdPro.CUnis)
    this_nPVens        = 0    && Preco de venda (SigCdPro.PVens)
    this_nPrecoDe      = 0    && Preco De (SigCdPro.PrecoDe)
    this_nPesoMs       = 0    && Peso do produto (SigCdPro.PesoMs)

    *--------------------------------------------------------------------------
    * INIT - Configura BO sem tabela principal (form operacional)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            DODEFAULT()

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrEtqBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarConfiguracao - Carrega SigCdPam e SigCdPac
    * Retorna: .T. se carregado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarConfiguracao()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT nMaxTpEtis, TpEtiPads, nMaxImpEti, ImpEtis, " + ;
                       "TpInstalas, AjVerts, AjHorzs, TpCBars " + ;
                       "FROM SigCdPam"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPam") > 0
                IF !EOF("cursor_4c_SigCdPam")
                    SELECT cursor_4c_SigCdPam
                    THIS.this_nMaxTpEtis  = NVL(nMaxTpEtis, 7)
                    THIS.this_nTpEtiPads  = NVL(TpEtiPads,  1)
                    THIS.this_nMaxImpEti  = NVL(nMaxImpEti, 5)
                    THIS.this_nImpEtis    = NVL(ImpEtis,    1)
                    THIS.this_cTpInstalas = NVL(TpInstalas, "")
                    THIS.this_nAjVerts    = NVL(AjVerts,    0)
                    THIS.this_nAjHorzs    = NVL(AjHorzs,    0)
                    THIS.this_cTpCBars    = NVL(TpCBars,    "")

                    THIS.this_nAjVertsPrint = THIS.this_nAjVerts
                    THIS.this_nAjHorzsPrint = THIS.this_nAjHorzs
                ENDIF
                USE IN cursor_4c_SigCdPam
            ENDIF

            loc_cSQL = "SELECT AjDens, AjVelos, EtqSeps FROM SigCdPac"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPac") > 0
                IF !EOF("cursor_4c_SigCdPac")
                    SELECT cursor_4c_SigCdPac
                    THIS.this_nAjDens   = IIF(EMPTY(NVL(AjDens,  0)), 20, NVL(AjDens,  0))
                    THIS.this_nAjVelos  = IIF(EMPTY(NVL(AjVelos, 0)), 1,  NVL(AjVelos, 0))
                    THIS.this_nEtqSeps  = NVL(EtqSeps, 1)

                    THIS.this_nAjDensPrint  = THIS.this_nAjDens
                    THIS.this_nAjVelosPrint = THIS.this_nAjVelos
                ENDIF
                USE IN cursor_4c_SigCdPac
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarConfiguracao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTiposEtiqueta - Carrega SigCdTpe em cursor cursor_4c_TiposEti
    * Retorna: numero de tipos encontrados (0 se nenhum)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTiposEtiqueta()
        LOCAL loc_nTipos, loc_oErro, loc_cSQL

        loc_nTipos = 0

        TRY
            loc_cSQL = "SELECT nTipos, cEtiquetas, cOrdems, nSituas " + ;
                       "FROM SigCdTpe WHERE nSituas = 1 ORDER BY cOrdems"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TiposEti") > 0
                loc_nTipos = _TALLY
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarTiposEtiqueta")
            loc_nTipos = 0
        ENDTRY

        RETURN loc_nTipos
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarImpressoras - Carrega impressoras disponiveis para o usuario
    * Popula cursor_4c_ImpTemp com campo Impres C(50)
    * Retorna: .T. se carregado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarImpressoras()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cUsuario

        loc_lSucesso = .F.

        TRY
            loc_cUsuario = EscaparSQL(gc_4c_UsuarioLogado)

            loc_cSQL = "SELECT b.Impres FROM SigSyImp a " + ;
                       "INNER JOIN SigCdmp b ON a.CImps = b.Impres " + ;
                       "WHERE a.UsuAcess = " + loc_cUsuario + ;
                       " AND b.nTpImpres = 2 " + ;
                       "UNION ALL " + ;
                       "SELECT c.Impres FROM SigCdAcG a " + ;
                       "INNER JOIN SigSyImp b ON a.Grupos = b.GrAcess " + ;
                       "INNER JOIN SigCdmp c ON b.CImps = c.Impres " + ;
                       "WHERE a.Usuarios = " + loc_cUsuario + ;
                       " AND c.nTpImpres = 2"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpTemp") <= 0
                loc_cSQL = "SELECT DISTINCT Impres FROM SigCdmp " + ;
                           "WHERE nTpImpres = 2 ORDER BY Impres"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpTemp") > 0
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarImpressoras")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorListaPrecos - Popula dbImpressao via SigCdLpi
    * par_cLPrecos:      codigo da lista de precos
    * par_lCarregarItens: se .T. insere itens no cursor dbImpressao
    * Retorna: .T. se carregado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorListaPrecos(par_cLPrecos, par_lCarregarItens)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nVal, loc_nValDe
        LOCAL loc_cCPros, loc_cDPros, loc_cLPrecosItem, loc_cSQLPro

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT LPrecos, CPros, DPros, PVens, PrecoDe, VencIs, VencFs " + ;
                       "FROM SigCdLpi " + ;
                       "WHERE LPrecos = " + EscaparSQL(PADR(ALLTRIM(par_cLPrecos), 30))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ListaIten") <= 0
                MsgErro("Falha ao carregar itens da lista de pre" + CHR(231) + "os.", ;
                        "Erro CarregarPorListaPrecos")
            ELSE
                IF par_lCarregarItens
                    SELECT cursor_4c_ListaIten
                    SCAN
                        loc_nVal        = NVL(PVens,   0)
                        loc_nValDe      = NVL(PrecoDe, 0)
                        loc_cCPros      = ALLTRIM(NVL(CPros,   ""))
                        loc_cDPros      = ALLTRIM(NVL(DPros,   ""))
                        loc_cLPrecosItem = ALLTRIM(NVL(LPrecos, ""))

                        IF !BETWEEN(DATETIME(), VencIs, VencFs)
                            loc_cSQLPro = "SELECT PVens, PrecoDe FROM SigCdPro " + ;
                                          "WHERE CPros = " + EscaparSQL(PADR(loc_cCPros, 14))

                            IF SQLEXEC(gnConnHandle, loc_cSQLPro, "cursor_4c_ProTemp") > 0
                                IF !EOF("cursor_4c_ProTemp")
                                    SELECT cursor_4c_ProTemp
                                    loc_nVal   = NVL(PVens,   0)
                                    loc_nValDe = NVL(PrecoDe, 0)
                                ENDIF
                                USE IN cursor_4c_ProTemp
                                SELECT cursor_4c_ListaIten
                            ENDIF
                        ENDIF

                        INSERT INTO dbImpressao ;
                            (Cpros, DPros, Qtds, QtdeEtiq, Obs, PVens, empos, PrecoDe) ;
                            VALUES ;
                            (loc_cCPros, loc_cDPros, 1, 1, ;
                             loc_cLPrecosItem, loc_nVal, ;
                             go_4c_Sistema.cCodEmpresa, loc_nValDe)
                    ENDSCAN
                ENDIF

                IF USED("cursor_4c_ListaIten")
                    USE IN cursor_4c_ListaIten
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarPorListaPrecos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorMovimentacao - Popula dbImpressao via SigMvItn
    * par_cEmps:          empresa (3 chars)
    * par_cDopes:         operacao (20 chars)
    * par_nNumes:         numero do documento
    * par_lCarregarItens: se .T. insere itens no cursor dbImpressao
    * Retorna: numero de itens carregados (-1 em erro, 0 se nenhum)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorMovimentacao(par_cEmps, par_cDopes, par_nNumes, par_lCarregarItens)
        LOCAL loc_nItens, loc_oErro, loc_cEdn, loc_cSQL
        LOCAL loc_nVen, loc_nValDe, loc_nPes, loc_cSQLPro
        LOCAL loc_cCPros, loc_cDPros, loc_nQtds, loc_nCitens

        loc_nItens = -1

        TRY
            loc_cEdn = PADR(ALLTRIM(par_cEmps), 3) + ;
                       PADR(ALLTRIM(par_cDopes), 20) + ;
                       STR(par_nNumes, 6)

            loc_cSQL = "SELECT CPros, DPros, Units, Qtds, Citens " + ;
                       "FROM SigMvItn " + ;
                       "WHERE EmpDopNums = " + EscaparSQL(loc_cEdn)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvIten") <= 0
                MsgErro("Falha ao carregar itens da movimenta" + CHR(231) + CHR(227) + "o.", ;
                        "Erro CarregarPorMovimentacao")
                loc_nItens = -1
            ELSE
                loc_nItens = _TALLY

                IF loc_nItens >= 1 AND par_lCarregarItens
                    SELECT cursor_4c_MvIten
                    SCAN
                        loc_nVen     = 0
                        loc_nValDe   = 0
                        loc_nPes     = 0
                        loc_cCPros   = ALLTRIM(NVL(CPros, ""))
                        loc_cDPros   = ALLTRIM(NVL(DPros, ""))
                        loc_nQtds    = NVL(Qtds,   0)
                        loc_nCitens  = NVL(Citens, 0)

                        loc_cSQLPro = "SELECT PVens, PesoMs, PrecoDe FROM SigCdPro " + ;
                                      "WHERE CPros = " + EscaparSQL(PADR(loc_cCPros, 14))

                        IF SQLEXEC(gnConnHandle, loc_cSQLPro, "cursor_4c_ProLocal") > 0
                            IF !EOF("cursor_4c_ProLocal")
                                SELECT cursor_4c_ProLocal
                                IF NVL(PVens,   0) > 0
                                    loc_nVen   = PVens
                                ENDIF
                                IF NVL(PrecoDe, 0) > 0
                                    loc_nValDe = PrecoDe
                                ENDIF
                                IF NVL(PesoMs,  0) > 0
                                    loc_nPes   = PesoMs
                                ENDIF
                            ENDIF
                            USE IN cursor_4c_ProLocal
                            SELECT cursor_4c_MvIten
                        ENDIF

                        INSERT INTO dbImpressao ;
                            (Cpros, DPros, Qtds, QtdeEtiq, Obs, PVens, empos, ;
                             empdopnums, citens, Pesos, PrecoDe) ;
                            VALUES ;
                            (loc_cCPros, loc_cDPros, ;
                             loc_nQtds, loc_nQtds, ;
                             loc_cEdn, loc_nVen, ;
                             go_4c_Sistema.cCodEmpresa, ;
                             loc_cEdn, loc_nCitens, loc_nPes, loc_nValDe)
                    ENDSCAN
                ENDIF

                IF USED("cursor_4c_MvIten")
                    USE IN cursor_4c_MvIten
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarPorMovimentacao")
            loc_nItens = -1
        ENDTRY

        RETURN loc_nItens
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarListaPrecoNoItem - Aplica preco da lista ao registro corrente
    * de dbImpressao (deve ser chamado com cursor dbImpressao posicionado)
    * par_cLPrecos: codigo da lista de precos
    * par_cCpros:   codigo do produto
    * Retorna: .T. se preco foi aplicado
    *--------------------------------------------------------------------------
    PROCEDURE AplicarListaPrecoNoItem(par_cLPrecos, par_cCpros)
        LOCAL loc_lAplicado, loc_oErro, loc_cSQL, loc_nVal, loc_nValDe
        LOCAL loc_cLPrecosAplic, loc_cSQLPro

        loc_lAplicado = .F.

        TRY
            loc_cSQL = "SELECT LPrecos, CPros, DPros, PVens, PrecoDe, VencIs, VencFs " + ;
                       "FROM SigCdLpi " + ;
                       "WHERE LPrecos = " + EscaparSQL(PADR(par_cLPrecos, 30)) + ;
                       " AND CPros = "   + EscaparSQL(PADR(par_cCpros,   14))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LpiItem") > 0
                SELECT cursor_4c_LpiItem
                GO TOP

                IF !EOF()
                    loc_nVal          = NVL(PVens,   0)
                    loc_nValDe        = NVL(PrecoDe, 0)
                    loc_cLPrecosAplic = ALLTRIM(NVL(LPrecos, ""))

                    IF !BETWEEN(DATETIME(), VencIs, VencFs)
                        loc_cSQLPro = "SELECT PVens, PrecoDe FROM SigCdPro " + ;
                                      "WHERE CPros = " + EscaparSQL(PADR(par_cCpros, 14))

                        IF SQLEXEC(gnConnHandle, loc_cSQLPro, "cursor_4c_ProPreco") > 0
                            IF !EOF("cursor_4c_ProPreco")
                                SELECT cursor_4c_ProPreco
                                loc_nVal   = NVL(PVens,   0)
                                loc_nValDe = NVL(PrecoDe, 0)
                            ENDIF
                            USE IN cursor_4c_ProPreco
                            SELECT cursor_4c_LpiItem
                        ENDIF
                    ENDIF

                    USE IN cursor_4c_LpiItem

                    REPLACE Obs     WITH loc_cLPrecosAplic, ;
                            PVens   WITH loc_nVal, ;
                            PrecoDe WITH loc_nValDe ;
                            IN dbImpressao

                    loc_lAplicado = .T.
                ELSE
                    USE IN cursor_4c_LpiItem
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro AplicarListaPrecoNoItem")
        ENDTRY

        RETURN loc_lAplicado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProdutoPorCodigo - Valida / resolve CPros no SigCdPro
    * Suporta EAN13 (numerico) e pesquisa por CBars e CPros direto
    * Preenche props this_cCpros, this_cDpros, this_nPVens, etc.
    * Retorna: .T. se produto encontrado
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProdutoPorCodigo(par_cValor)
        LOCAL loc_lEncontrou, loc_oErro, loc_cSQL, loc_nCod, loc_cValorResolvido

        loc_lEncontrou = .F.

        TRY
            THIS.this_cCpros   = ""
            THIS.this_cDpros   = ""
            THIS.this_cDpro2s  = ""
            THIS.this_cCunis   = ""
            THIS.this_nPVens   = 0
            THIS.this_nPrecoDe = 0
            THIS.this_nPesoMs  = 0

            IF !EMPTY(par_cValor)
                loc_cValorResolvido = par_cValor

                *-- Tentativa 1: resolver como EAN13
                loc_nCod = INT(VAL(par_cValor))
                IF loc_nCod > 0
                    loc_cSQL = "SELECT TOP 1 CPros FROM SigCdPro " + ;
                               "WHERE Ean13 = " + FormatarNumeroSQL(loc_nCod)

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrEan") > 0
                        IF !EOF("cursor_4c_PrEan")
                            SELECT cursor_4c_PrEan
                            loc_cValorResolvido = ALLTRIM(CPros)
                        ENDIF
                        USE IN cursor_4c_PrEan
                    ENDIF
                ENDIF

                *-- Tentativa 2: resolver como codigo de barras (CBars)
                IF LEN(ALLTRIM(par_cValor)) <= 14
                    loc_cSQL = "SELECT TOP 1 CPros FROM SigCdPro " + ;
                               "WHERE CBars = " + FormatarNumeroSQL(INT(VAL(par_cValor)))

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrBars") > 0
                        IF !EOF("cursor_4c_PrBars")
                            SELECT cursor_4c_PrBars
                            loc_cValorResolvido = ALLTRIM(CPros)
                        ENDIF
                        USE IN cursor_4c_PrBars
                    ENDIF
                ENDIF

                *-- Buscar dados completos por CPros resolvido
                loc_cSQL = "SELECT TOP 1 CPros, DPros, Dpro2s, CUnis, " + ;
                           "PVens, PrecoDe, PesoMs " + ;
                           "FROM SigCdPro " + ;
                           "WHERE CPros = " + EscaparSQL(PADR(loc_cValorResolvido, 14))

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrDados") > 0
                    IF !EOF("cursor_4c_PrDados")
                        SELECT cursor_4c_PrDados
                        THIS.this_cCpros   = ALLTRIM(NVL(CPros,   ""))
                        THIS.this_cDpros   = ALLTRIM(NVL(DPros,   ""))
                        THIS.this_cDpro2s  = ALLTRIM(NVL(Dpro2s,  ""))
                        THIS.this_cCunis   = ALLTRIM(NVL(CUnis,   ""))
                        THIS.this_nPVens   = NVL(PVens,   0)
                        THIS.this_nPrecoDe = NVL(PrecoDe, 0)
                        THIS.this_nPesoMs  = NVL(PesoMs,  0)
                        loc_lEncontrou     = .T.
                    ENDIF
                    USE IN cursor_4c_PrDados
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BuscarProdutoPorCodigo")
        ENDTRY

        RETURN loc_lEncontrou
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProdutoPorDescricao - Resolve DPros direto (busca exata)
    * Preenche props this_cCpros, this_cDpros, etc.
    * Retorna: .T. se produto encontrado
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProdutoPorDescricao(par_cDpros)
        LOCAL loc_lEncontrou, loc_oErro, loc_cSQL

        loc_lEncontrou = .F.

        TRY
            THIS.this_cCpros   = ""
            THIS.this_cDpros   = ""
            THIS.this_cDpro2s  = ""
            THIS.this_cCunis   = ""
            THIS.this_nPVens   = 0
            THIS.this_nPrecoDe = 0
            THIS.this_nPesoMs  = 0

            IF !EMPTY(par_cDpros)
                loc_cSQL = "SELECT TOP 1 CPros, DPros, Dpro2s, CUnis, " + ;
                           "PVens, PrecoDe, PesoMs " + ;
                           "FROM SigCdPro " + ;
                           "WHERE DPros = " + EscaparSQL(par_cDpros)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrDescr") > 0
                    IF !EOF("cursor_4c_PrDescr")
                        SELECT cursor_4c_PrDescr
                        THIS.this_cCpros   = ALLTRIM(NVL(CPros,   ""))
                        THIS.this_cDpros   = ALLTRIM(NVL(DPros,   ""))
                        THIS.this_cDpro2s  = ALLTRIM(NVL(Dpro2s,  ""))
                        THIS.this_cCunis   = ALLTRIM(NVL(CUnis,   ""))
                        THIS.this_nPVens   = NVL(PVens,   0)
                        THIS.this_nPrecoDe = NVL(PrecoDe, 0)
                        THIS.this_nPesoMs  = NVL(PesoMs,  0)
                        loc_lEncontrou     = .T.
                    ENDIF
                    USE IN cursor_4c_PrDescr
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BuscarProdutoPorDescricao")
        ENDTRY

        RETURN loc_lEncontrou
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProdutoPorReferencia - Resolve Dpro2s direto (busca exata)
    * Preenche props this_cCpros, this_cDpros, etc.
    * Retorna: .T. se produto encontrado
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProdutoPorReferencia(par_cDpro2s)
        LOCAL loc_lEncontrou, loc_oErro, loc_cSQL

        loc_lEncontrou = .F.

        TRY
            THIS.this_cCpros   = ""
            THIS.this_cDpros   = ""
            THIS.this_cDpro2s  = ""
            THIS.this_cCunis   = ""
            THIS.this_nPVens   = 0
            THIS.this_nPrecoDe = 0
            THIS.this_nPesoMs  = 0

            IF !EMPTY(par_cDpro2s)
                loc_cSQL = "SELECT TOP 1 CPros, DPros, Dpro2s, CUnis, " + ;
                           "PVens, PrecoDe, PesoMs " + ;
                           "FROM SigCdPro " + ;
                           "WHERE Dpro2s = " + EscaparSQL(par_cDpro2s)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrRef") > 0
                    IF !EOF("cursor_4c_PrRef")
                        SELECT cursor_4c_PrRef
                        THIS.this_cCpros   = ALLTRIM(NVL(CPros,   ""))
                        THIS.this_cDpros   = ALLTRIM(NVL(DPros,   ""))
                        THIS.this_cDpro2s  = ALLTRIM(NVL(Dpro2s,  ""))
                        THIS.this_cCunis   = ALLTRIM(NVL(CUnis,   ""))
                        THIS.this_nPVens   = NVL(PVens,   0)
                        THIS.this_nPrecoDe = NVL(PrecoDe, 0)
                        THIS.this_nPesoMs  = NVL(PesoMs,  0)
                        loc_lEncontrou     = .T.
                    ENDIF
                    USE IN cursor_4c_PrRef
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BuscarProdutoPorReferencia")
        ENDTRY

        RETURN loc_lEncontrou
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarEtiquetaIndividual - Verifica se produto usa etiqueta individual
    * Retorna: .T. se produto usa etiqueta individual E nao permite duplicata
    * (o form bloqueia a impressao desse produto nesse caso)
    *--------------------------------------------------------------------------
    PROCEDURE VerificarEtiquetaIndividual(par_cCpros)
        LOCAL loc_lEtqIndividual, loc_oErro, loc_cSQL

        loc_lEtqIndividual = .F.

        TRY
            IF !EMPTY(par_cCpros)
                loc_cSQL = "SELECT u.Etiqs, u.EtiqDups " + ;
                           "FROM SigCdPro p " + ;
                           "INNER JOIN SigCdUni u ON p.CUnis = u.CUnis " + ;
                           "WHERE p.CPros = " + EscaparSQL(PADR(par_cCpros, 14))

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UniEtq") > 0
                    IF !EOF("cursor_4c_UniEtq")
                        SELECT cursor_4c_UniEtq
                        IF ALLTRIM(NVL(Etiqs, "")) = "S" AND NVL(EtiqDups, 0) <> 1
                            loc_lEtqIndividual = .T.
                        ENDIF
                    ENDIF
                    USE IN cursor_4c_UniEtq
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro VerificarEtiquetaIndividual")
        ENDTRY

        RETURN loc_lEtqIndividual
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterNDopesParaBOP - Busca NDopes de SigCdOpe para montar codigo BOP
    * Retorna: string NDopes (4 chars padded) ou "" se nao encontrado
    *--------------------------------------------------------------------------
    PROCEDURE ObterNDopesParaBOP(par_cDopes)
        LOCAL loc_cNDopes, loc_oErro, loc_cSQL

        loc_cNDopes = ""

        TRY
            IF !EMPTY(par_cDopes)
                loc_cSQL = "SELECT TOP 1 NDopes FROM SigCdOpe " + ;
                           "WHERE Dopes = " + EscaparSQL(par_cDopes)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeNDop") > 0
                    IF !EOF("cursor_4c_OpeNDop")
                        SELECT cursor_4c_OpeNDop
                        IF !EMPTY(NVL(NDopes, 0))
                            loc_cNDopes = PADL(TRANSFORM(NVL(NDopes, 0)), 4, "0")
                        ENDIF
                    ENDIF
                    USE IN cursor_4c_OpeNDop
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ObterNDopesParaBOP")
        ENDTRY

        RETURN loc_cNDopes
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirEtiquetas - Chama SigOpEtq com os parametros de impressao
    * Retorna: .T. se impressao concluida com sucesso (incluindo Commit)
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirEtiquetas()
        LOCAL loc_lSucesso, loc_oErro, loc_cBop, loc_cNDopes

        loc_lSucesso = .F.

        TRY
            loc_cBop = ""
            IF !EMPTY(THIS.this_cDopes) AND THIS.this_nNumes > 0
                loc_cNDopes = THIS.ObterNDopesParaBOP(THIS.this_cDopes)
                IF !EMPTY(loc_cNDopes)
                    loc_cBop = loc_cNDopes + PADL(TRANSFORM(THIS.this_nNumes), 6, "0")
                ENDIF
            ENDIF

            =SigOpEtq(gnConnHandle, ;
                      THIS.this_nImpPreco, ;
                      THIS.this_lImpSepar, ;
                      THIS.this_nTpEti, ;
                      THIS.this_nTpImp, ;
                      THIS.this_nAjVertsPrint, ;
                      THIS.this_nAjHorzsPrint, ;
                      THIS.this_nAjDensPrint, ;
                      .NULL., .NULL., .NULL., ;
                      THIS.this_cNomeImp, ;
                      .NULL., .NULL., ;
                      THIS.this_nAjVelosPrint, ;
                      THIS.this_lImpPeso, ;
                      loc_cBop, ;
                      THIS.this_cLp1, ;
                      THIS.this_cLp2, ;
                      .F., .F., ;
                      THIS.this_lCompo)

            IF SQLEXEC(gnConnHandle, "COMMIT", "cursor_4c_Commit") >= 0
                IF USED("cursor_4c_Commit")
                    USE IN cursor_4c_Commit
                ENDIF
                loc_lSucesso = .T.
            ELSE
                IF USED("cursor_4c_Commit")
                    USE IN cursor_4c_Commit
                ENDIF
                SQLEXEC(gnConnHandle, "ROLLBACK", "cursor_4c_Rollback")
                IF USED("cursor_4c_Rollback")
                    USE IN cursor_4c_Rollback
                ENDIF
                MsgErro("Falha ao confirmar transa" + CHR(231) + CHR(227) + "o (Commit).", ;
                        "Erro ImprimirEtiquetas")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ImprimirEtiquetas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades BO a partir de um alias de cursor
    * par_cAliasCursor: alias do cursor (normalmente "dbImpressao")
    * Retorna: .T. se carregado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCpros       = ALLTRIM(NVL(Cpros,       ""))
                THIS.this_cDpros       = ALLTRIM(NVL(DPros,       ""))
                THIS.this_cReffs       = ALLTRIM(NVL(Reffs,       ""))
                THIS.this_nQtds        = NVL(Qtds,      0)
                THIS.this_nQtdeEtiq    = NVL(QtdeEtiq,  0)
                THIS.this_cPedido      = ALLTRIM(NVL(Pedido,      ""))
                THIS.this_cObs         = ALLTRIM(NVL(Obs,         ""))
                THIS.this_nPVens       = NVL(PVens,     0)
                THIS.this_nPrecoDe     = NVL(PrecoDe,   0)
                THIS.this_nParcelas    = NVL(Parcelas,  0)
                THIS.this_cCpros2      = ALLTRIM(NVL(Cpros2,      ""))
                THIS.this_cCpros3      = ALLTRIM(NVL(Cpros3,      ""))
                THIS.this_cCpros4      = ALLTRIM(NVL(Cpros4,      ""))
                THIS.this_cEmpos       = ALLTRIM(NVL(empos,       ""))
                THIS.this_cEmpdopnums  = ALLTRIM(NVL(empdopnums,  ""))
                THIS.this_nCitens      = NVL(citens,    0)
                THIS.this_nPesos       = NVL(Pesos,     0)
                THIS.this_cCodTams     = ALLTRIM(NVL(CodTams,     ""))
                THIS.this_cDpro2s      = ALLTRIM(NVL(DPro2s,      ""))

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrEtqBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Adiciona nova linha ao cursor local dbImpressao
    * Retorna: .T. se inserido com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("dbImpressao")
                INSERT INTO dbImpressao ;
                    (Cpros, DPros, Reffs, Qtds, QtdeEtiq, ;
                     Pedido, Obs, PVens, PrecoDe, Parcelas, ;
                     Cpros2, Cpros3, Cpros4, empos, empdopnums, ;
                     citens, Pesos, CodTams, DPro2s) ;
                    VALUES ;
                    (THIS.this_cCpros, THIS.this_cDpros, THIS.this_cReffs, ;
                     THIS.this_nQtds, THIS.this_nQtdeEtiq, ;
                     THIS.this_cPedido, THIS.this_cObs, THIS.this_nPVens, ;
                     THIS.this_nPrecoDe, THIS.this_nParcelas, ;
                     THIS.this_cCpros2, THIS.this_cCpros3, THIS.this_cCpros4, ;
                     THIS.this_cEmpos, THIS.this_cEmpdopnums, ;
                     THIS.this_nCitens, THIS.this_nPesos, ;
                     THIS.this_cCodTams, THIS.this_cDpro2s)

                THIS.RegistrarAuditoria("I")

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrEtqBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza linha corrente do cursor local dbImpressao
    * Retorna: .T. se atualizado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("dbImpressao") AND !EOF("dbImpressao")
                SELECT dbImpressao

                REPLACE Cpros       WITH THIS.this_cCpros, ;
                        DPros       WITH THIS.this_cDpros, ;
                        Reffs       WITH THIS.this_cReffs, ;
                        Qtds        WITH THIS.this_nQtds, ;
                        QtdeEtiq    WITH THIS.this_nQtdeEtiq, ;
                        Pedido      WITH THIS.this_cPedido, ;
                        Obs         WITH THIS.this_cObs, ;
                        PVens       WITH THIS.this_nPVens, ;
                        PrecoDe     WITH THIS.this_nPrecoDe, ;
                        Parcelas    WITH THIS.this_nParcelas, ;
                        Cpros2      WITH THIS.this_cCpros2, ;
                        Cpros3      WITH THIS.this_cCpros3, ;
                        Cpros4      WITH THIS.this_cCpros4, ;
                        empos       WITH THIS.this_cEmpos, ;
                        empdopnums  WITH THIS.this_cEmpdopnums, ;
                        citens      WITH THIS.this_nCitens, ;
                        Pesos       WITH THIS.this_nPesos, ;
                        CodTams     WITH THIS.this_cCodTams, ;
                        DPro2s      WITH THIS.this_cDpro2s

                THIS.RegistrarAuditoria("A")

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrEtqBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o codigo do produto corrente em dbImpressao
    * Form OPERACIONAL: usa CPros como identificador do item corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        LOCAL loc_cChave

        loc_cChave = ""

        IF USED("dbImpressao") AND !EOF("dbImpressao")
            SELECT dbImpressao
            loc_cChave = ALLTRIM(NVL(Cpros, ""))
        ENDIF

        RETURN loc_cChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Form OPERACIONAL sem tabela principal
    * Sem persistencia em LogAuditoria (cursor local nao eh auditavel)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN .T.
    ENDPROC

ENDDEFINE

