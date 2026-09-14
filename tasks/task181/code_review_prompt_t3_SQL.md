# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (8)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPDOPNUMS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EAN13' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CBARS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DPROS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DPRO2S' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DISPLAY' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEtq.prg) - TRECHOS RELEVANTES PARA PASS SQL (2712 linhas total):

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
91:             THIS.Caption = "Impress" + CHR(227) + "o de Etiquetas Selecionadas"
92: 
93:             *-- Estrutura visual: cabecalho cinza + todos os controles do form plano
94:             THIS.ConfigurarPageFrame()
95:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
96:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
97:             THIS.ConfigurarPaginaLista()
98:             THIS.ConfigurarPaginaDados()
99:             THIS.CarregarTiposEtiqueta()

*-- Linhas 267 a 412:
267:                 .Width        = 818
268:                 .Height       = 157
269:                 .RecordMark   = .F.
270:                 .DeleteMark   = .F.
271:                 .FontName     = "Tahoma"
272:                 .FontSize     = 8
273:                 .HeaderHeight = 17
274:                 .RowHeight    = 17
275:                 .ScrollBars   = 2
276:                 .ColumnCount  = 7
277:                 .RecordSource = "dbImpressao"
278: 
279:                 *-- Column1: Produto (cpros)
280:                 WITH .Column1
281:                     .ControlSource = "dbImpressao.cpros"
282:                     .Width         = 110
283:                     .Movable       = .F.
284:                     .Resizable     = .F.
285:                     .FontName      = "Tahoma"
286:                     .FontSize      = 8
287:                     WITH .Header1
288:                         .FontName  = "Tahoma"
289:                         .FontSize  = 8
290:                         .Alignment = 2
291:                         .Caption   = "Produto"
292:                         .ForeColor = RGB(90,90,90)
293:                     ENDWITH
294:                     WITH .Text1
295:                         .FontName      = "Tahoma"
296:                         .FontSize      = 8
297:                         .BorderStyle   = 0
298:                         .ControlSource = "dbImpressao.cpros"
299:                         .Format        = "!"
300:                         .InputMask     = ""
301:                         .Margin        = 0
302:                         .MaxLength     = 14
303:                         .ForeColor     = RGB(0,0,0)
304:                         .BackColor     = RGB(255,255,255)
305:                         .Name          = "txt_4c_cpros"
306:                     ENDWITH
307:                 ENDWITH
308: 
309:                 *-- Column2: Descricao (dpros) - ColumnOrder=3
310:                 WITH .Column2
311:                     .ColumnOrder   = 3
312:                     .ControlSource = "dbImpressao.dpros"
313:                     .Width         = 270
314:                     .Movable       = .F.
315:                     .Resizable     = .F.
316:                     .FontName      = "Tahoma"
317:                     .FontSize      = 8
318:                     WITH .Header1
319:                         .FontName  = "Tahoma"
320:                         .FontSize  = 8
321:                         .Alignment = 2
322:                         .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
323:                         .ForeColor = RGB(90,90,90)
324:                     ENDWITH
325:                     WITH .Text1
326:                         .FontName      = "Tahoma"
327:                         .FontSize      = 8
328:                         .BorderStyle   = 0
329:                         .ControlSource = "dbImpressao.dpros"
330:                         .Margin        = 0
331:                         .ForeColor     = RGB(0,0,0)
332:                         .BackColor     = RGB(255,255,255)
333:                         .Name          = "txt_4c_dpros"
334:                     ENDWITH
335:                 ENDWITH
336: 
337:                 *-- Column3: Quantidade (qtds) - ColumnOrder=4
338:                 WITH .Column3
339:                     .ColumnOrder   = 4
340:                     .ControlSource = "dbImpressao.qtds"
341:                     .Width         = 65
342:                     .Movable       = .F.
343:                     .Resizable     = .F.
344:                     .FontName      = "Tahoma"
345:                     .FontSize      = 8
346:                     WITH .Header1
347:                         .FontName  = "Tahoma"
348:                         .FontSize  = 8
349:                         .Alignment = 2
350:                         .Caption   = "Quantidade"
351:                         .ForeColor = RGB(90,90,90)
352:                     ENDWITH
353:                     WITH .Text1
354:                         .FontName      = "Tahoma"
355:                         .FontSize      = 8
356:                         .BorderStyle   = 0
357:                         .ControlSource = "dbImpressao.qtds"
358:                         .Format        = "999,999.99"
359:                         .InputMask     = "999,999.99"
360:                         .Margin        = 0
361:                         .MaxLength     = 10
362:                         .ForeColor     = RGB(0,0,0)
363:                         .BackColor     = RGB(255,255,255)
364:                         .Name          = "txt_4c_qtds"
365:                     ENDWITH
366:                 ENDWITH
367: 
368:                 *-- Column4: Ref.Fornecedor display=DPro2s, edicao=reffs - ColumnOrder=2
369:                 WITH .Column4
370:                     .ColumnOrder   = 2
371:                     .ControlSource = "dbImpressao.Dpro2s"
372:                     .Width         = 135
373:                     .FontName      = "Tahoma"
374:                     .FontSize      = 8
375:                     WITH .Header1
376:                         .FontName  = "Tahoma"
377:                         .FontSize  = 8
378:                         .Alignment = 2
379:                         .Caption   = "Refer" + CHR(234) + "ncia Fornecedor"
380:                         .ForeColor = RGB(90,90,90)
381:                     ENDWITH
382:                     WITH .Text1
383:                         .FontName      = "Tahoma"
384:                         .FontSize      = 8
385:                         .BorderStyle   = 0
386:                         .ControlSource = "dbImpressao.reffs"
387:                         .Format        = "!"
388:                         .Margin        = 0
389:                         .ForeColor     = RGB(0,0,0)
390:                         .BackColor     = RGB(255,255,255)
391:                         .Name          = "txt_4c_reffs"
392:                     ENDWITH
393:                 ENDWITH
394: 
395:                 *-- Column5: Parcelas (par)
396:                 WITH .Column5
397:                     .ControlSource = "dbImpressao.parcelas"
398:                     .Width         = 60
399:                     .Movable       = .F.
400:                     .Resizable     = .F.
401:                     .FontName      = "Tahoma"
402:                     .FontSize      = 8
403:                     WITH .Header1
404:                         .FontName  = "Tahoma"
405:                         .FontSize  = 8
406:                         .Alignment = 2
407:                         .Caption   = "Parcelas"
408:                         .ForeColor = RGB(90,90,90)
409:                     ENDWITH
410:                     WITH .Text1
411:                         .FontName    = "Tahoma"
412:                         .FontSize    = 8

*-- Linhas 420 a 438:
420: 
421:                 *-- Column6: Preco (PVens) - somente leitura
422:                 WITH .Column6
423:                     .ControlSource = "dbImpressao.PVens"
424:                     .Enabled       = .F.
425:                     .Width         = 70
426:                     .Movable       = .F.
427:                     .Resizable     = .F.
428:                     .ReadOnly      = .T.
429:                     .FontName      = "Tahoma"
430:                     .FontSize      = 8
431:                     WITH .Header1
432:                         .FontName  = "Tahoma"
433:                         .FontSize  = 8
434:                         .Alignment = 2
435:                         .Caption   = "Pre" + CHR(231) + "o"
436:                         .ForeColor = RGB(90,90,90)
437:                     ENDWITH
438:                     WITH .Text1

*-- Linhas 450 a 468:
450: 
451:                 *-- Column7: Preco De (PrecoDe) - somente leitura
452:                 WITH .Column7
453:                     .ControlSource = "dbImpressao.PrecoDe"
454:                     .Enabled       = .F.
455:                     .Width         = 70
456:                     .Movable       = .F.
457:                     .Resizable     = .F.
458:                     .ReadOnly      = .T.
459:                     .FontName      = "Tahoma"
460:                     .FontSize      = 8
461:                     WITH .Header1
462:                         .FontName  = "Tahoma"
463:                         .FontSize  = 8
464:                         .Alignment = 2
465:                         .Caption   = "Pre" + CHR(231) + "o De"
466:                         .ForeColor = RGB(90,90,90)
467:                     ENDWITH
468:                     WITH .Text1

*-- Linhas 593 a 650:
593: 
594:             IF loc_lContinuar
595:                 *-- Reordenar dbImpressao: remove Qtds<=0 e ordena conforme opcao
596:                 SELECT * FROM dbImpressao WHERE 0=1 INTO CURSOR cursor_4c_Ordenado READWRITE
597: 
598:                 SELECT dbImpressao
599:                 DELETE FROM dbImpressao WHERE Qtds <= 0
600: 
601:                 IF THIS.obj_4c_OptOrdem.Value = 1
602:                     SET ORDER TO Cpros
603:                 ELSE
604:                     SET ORDER TO Registros
605:                 ENDIF
606: 
607:                 SELECT dbImpressao
608:                 SCAN
609:                     SCATTER MEMVAR MEMO
610:                     INSERT INTO cursor_4c_Ordenado FROM MEMVAR
611:                 ENDSCAN
612: 
613:                 ZAP IN dbImpressao
614:                 SET ORDER TO
615: 
616:                 SELECT cursor_4c_Ordenado
617:                 SCAN
618:                     SCATTER MEMVAR MEMO
619:                     INSERT INTO dbImpressao FROM MEMVAR
620:                 ENDSCAN
621: 
622:                 IF USED("cursor_4c_Ordenado")
623:                     USE IN cursor_4c_Ordenado
624:                 ENDIF
625: 
626:                 *-- Transfere parametros dos controles para o BO
627:                 THIS.FormParaBO()
628: 
629:                 IF THIS.this_oBusinessObject.ImprimirEtiquetas()
630:                     MsgInfo("Impress" + CHR(227) + "o Conclu" + CHR(237) + "da!!!")
631: 
632:                     THIS.txt_4c_Lpreco.Value  = ""
633:                     THIS.txt_4c_LPreco2.Value = ""
634: 
635:                     SELECT dbImpressao
636:                     ZAP
637:                     APPEND BLANK
638:                     THIS.grd_4c_Dados.SetFocus
639:                     THIS.grd_4c_Dados.col_4c_cpros.SetFocus
640:                 ENDIF
641:             ENDIF
642: 
643:             loc_lSucesso = .T.
644: 
645:         CATCH TO loc_oErro
646:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
647:                     " PROC=" + loc_oErro.Procedure, ;
648:                     "Erro FormSigPrEtq.BtnImprimeClick")
649:         ENDTRY
650: 

*-- Linhas 665 a 687:
665:         LOCAL loc_oErro
666: 
667:         TRY
668:             SELECT dbImpressao
669:             DELETE
670:             LOCATE FOR .F.
671: 
672:             SELECT dbImpressao
673:             GO TOP IN dbImpressao
674:             IF EOF("dbImpressao")
675:                 APPEND BLANK IN dbImpressao
676:             ENDIF
677:             GO TOP IN dbImpressao
678: 
679:             THIS.grd_4c_Dados.Refresh()
680: 
681:         CATCH TO loc_oErro
682:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
683:                     " PROC=" + loc_oErro.Procedure, ;
684:                     "Erro FormSigPrEtq.BtnExcluirClick")
685:         ENDTRY
686:     ENDPROC
687: 

*-- Linhas 716 a 734:
716: 
717:             IF loc_lContinuar
718:                 *-- Verificar se ja existem etiquetas na grade e confirmar substituicao
719:                 SELECT Cpros FROM dbImpressao WHERE !EMPTY(Cpros) INTO CURSOR cursor_4c_TmpDig
720:                 IF _TALLY > 0
721:                     loc_lContinuar = MsgConfirma("Existem Etiquetas na Grade! " + ;
722:                         "Deseja Refazer a Sele" + CHR(231) + CHR(227) + "o?")
723:                 ENDIF
724:                 IF USED("cursor_4c_TmpDig")
725:                     USE IN cursor_4c_TmpDig
726:                 ENDIF
727:             ENDIF
728: 
729:             IF loc_lContinuar
730:                 ZAP IN dbImpressao
731: 
732:                 loc_nItens = THIS.this_oBusinessObject.CarregarPorMovimentacao( ;
733:                     THIS.txt_4c_Emps.Value, ;
734:                     THIS.txt_4c_Dopes.Value, ;

*-- Linhas 742 a 771:
742:                 ELSE
743:                     *-- Aplicar lista de precos por item se preenchida e nao em modo chkLista
744:                     IF THIS.chk_4c_ChkLista.Value <> 1 AND !EMPTY(THIS.txt_4c_Lpreco.Value)
745:                         SELECT dbImpressao
746:                         SCAN
747:                             IF !EMPTY(dbImpressao.Cpros)
748:                                 THIS.this_oBusinessObject.AplicarListaPrecoNoItem( ;
749:                                     THIS.txt_4c_Lpreco.Value, ;
750:                                     ALLTRIM(dbImpressao.Cpros))
751:                             ENDIF
752:                         ENDSCAN
753:                     ENDIF
754:                 ENDIF
755: 
756:                 SELECT dbImpressao
757:                 IF RECCOUNT("dbImpressao") = 0
758:                     APPEND BLANK IN dbImpressao
759:                 ENDIF
760:                 GO TOP IN dbImpressao
761: 
762:                 THIS.grd_4c_Dados.Refresh()
763:             ENDIF
764: 
765:             loc_lSucesso = .T.
766: 
767:         CATCH TO loc_oErro
768:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
769:                     " PROC=" + loc_oErro.Procedure, ;
770:                     "Erro FormSigPrEtq.BtnCarregarClick")
771:         ENDTRY

*-- Linhas 1631 a 1660:
1631:         loc_nHeight = 15
1632: 
1633:         TRY
1634:             IF SQLEXEC(gnConnHandle, ;
1635:                 "SELECT nTipos, RTRIM(cEtiquetas) AS cEtiquetas " + ;
1636:                 "FROM SigCdTpe WHERE nSituas = 1 ORDER BY cOrdems, cEtiquetas", ;
1637:                 "cursor_4c_TiposEti") > 0
1638: 
1639:                 SELECT cursor_4c_TiposEti
1640:                 loc_nTipos = RECCOUNT("cursor_4c_TiposEti")
1641: 
1642:                 IF loc_nTipos > 0
1643:                     WITH THIS.obj_4c_Opt_Tipo
1644:                         .ButtonCount = loc_nTipos
1645:                         SELECT cursor_4c_TiposEti
1646:                         GO TOP IN cursor_4c_TiposEti
1647:                         DO WHILE !EOF("cursor_4c_TiposEti")
1648:                             WITH .Buttons(loc_nI)
1649:                                 .AutoSize  = .F.
1650:                                 .Width     = 197
1651:                                 .Caption   = " \<" + CHR(96 + loc_nI) + ". " + ;
1652:                                              ALLTRIM(cursor_4c_TiposEti.cEtiquetas)
1653:                                 .ForeColor = RGB(90,90,90)
1654:                                 .Tag       = ALLTRIM(STR(cursor_4c_TiposEti.nTipos))
1655:                                 .Top       = loc_nTop
1656:                                 .BackStyle = 0
1657:                                 .Height    = 16
1658:                                 .Left      = 9
1659:                                 .Themes    = .F.
1660:                             ENDWITH

*-- Linhas 1718 a 1738:
1718: 
1719:             *-- Tenta match exato
1720:             IF !EMPTY(loc_cValor)
1721:                 loc_nRet = SQLEXEC(gnConnHandle, ;
1722:                     "SELECT TOP 1 RTRIM(LPrecos) AS LPrecos FROM SigCdLpc " + ;
1723:                     "WHERE RTRIM(LPrecos) = " + EscaparSQL(loc_cValor), ;
1724:                     "cursor_4c_ChkLpc")
1725:                 IF loc_nRet > 0 AND !EOF("cursor_4c_ChkLpc")
1726:                     par_oTxt.Value = ALLTRIM(cursor_4c_ChkLpc.LPrecos)
1727:                     loc_lEncontrado = .T.
1728:                     IF UPPER(par_oTxt.Name) = "TXT_4C_LPRECO" AND ;
1729:                        THIS.chk_4c_ChkLista.Value = 1
1730:                         THIS.CarregarItensListaPreco(par_oTxt.Value)
1731:                     ENDIF
1732:                 ENDIF
1733:                 IF USED("cursor_4c_ChkLpc")
1734:                     USE IN cursor_4c_ChkLpc
1735:                 ENDIF
1736:             ENDIF
1737: 
1738:             *-- Match nao encontrado: abre picker

*-- Linhas 1779 a 1838:
1779:         TRY
1780:             ZAP IN dbImpressao
1781: 
1782:             loc_cSQL = "SELECT RTRIM(a.LPrecos) AS LPrecos, RTRIM(a.CPros) AS Cpros, " + ;
1783:                        "RTRIM(a.DPros) AS DPros, a.PVens, a.Precode AS PrecoDe, " + ;
1784:                        "a.VencIs, a.VencFs " + ;
1785:                        "FROM SigCdLpi a " + ;
1786:                        "WHERE RTRIM(a.LPrecos) = " + EscaparSQL(par_cLPreco)
1787: 
1788:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LpreI") > 0
1789:                 SELECT cursor_4c_LpreI
1790:                 SCAN
1791:                     loc_nPVens   = cursor_4c_LpreI.PVens
1792:                     loc_nPrecoDe = cursor_4c_LpreI.PrecoDe
1793: 
1794:                     *-- Se preco da lista expirou, usa preco atual do produto
1795:                     IF !BETWEEN(DATETIME(), cursor_4c_LpreI.VencIs, cursor_4c_LpreI.VencFs)
1796:                         loc_nRetPro = SQLEXEC(gnConnHandle, ;
1797:                             "SELECT TOP 1 PVens, PrecoDe FROM SigCdPro " + ;
1798:                             "WHERE RTRIM(CPros) = " + ;
1799:                             EscaparSQL(ALLTRIM(cursor_4c_LpreI.Cpros)), ;
1800:                             "cursor_4c_LproPro")
1801:                         IF loc_nRetPro > 0 AND !EOF("cursor_4c_LproPro")
1802:                             loc_nPVens   = cursor_4c_LproPro.PVens
1803:                             loc_nPrecoDe = cursor_4c_LproPro.PrecoDe
1804:                         ENDIF
1805:                         IF USED("cursor_4c_LproPro")
1806:                             USE IN cursor_4c_LproPro
1807:                         ENDIF
1808:                     ENDIF
1809: 
1810:                     INSERT INTO dbImpressao ;
1811:                         (Cpros, DPros, Qtds, QtdeEtiq, Obs, PVens, empos, PrecoDe) ;
1812:                     VALUES ;
1813:                         (cursor_4c_LpreI.Cpros, cursor_4c_LpreI.DPros, 1, 1, ;
1814:                          PADR(par_cLPreco, 10), loc_nPVens, ;
1815:                          go_4c_Sistema.cCodEmpresa, loc_nPrecoDe)
1816:                 ENDSCAN
1817: 
1818:                 IF USED("cursor_4c_LpreI")
1819:                     USE IN cursor_4c_LpreI
1820:                 ENDIF
1821:             ENDIF
1822: 
1823:             SELECT dbImpressao
1824:             IF RECCOUNT("dbImpressao") = 0
1825:                 APPEND BLANK IN dbImpressao
1826:             ENDIF
1827:             GO TOP IN dbImpressao
1828:             THIS.grd_4c_Dados.Refresh()
1829: 
1830:             loc_lSucesso = .T.
1831: 
1832:         CATCH TO loc_oErro
1833:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1834:                     " PROC=" + loc_oErro.Procedure, ;
1835:                     "Erro FormSigPrEtq.CarregarItensListaPreco")
1836:         ENDTRY
1837: 
1838:         RETURN loc_lSucesso

*-- Linhas 1862 a 1882:
1862: 
1863:             *-- Tenta match exato
1864:             IF !EMPTY(loc_cValor)
1865:                 loc_nRet = SQLEXEC(gnConnHandle, ;
1866:                     "SELECT TOP 1 RTRIM(Cemps) AS Cemps FROM SigCdEmp " + ;
1867:                     "WHERE RTRIM(Cemps) = " + EscaparSQL(loc_cValor), ;
1868:                     "cursor_4c_ChkEmp")
1869:                 IF loc_nRet > 0 AND !EOF("cursor_4c_ChkEmp")
1870:                     THIS.txt_4c_Emps.Value = ALLTRIM(cursor_4c_ChkEmp.Cemps)
1871:                     loc_lEncontrado = .T.
1872:                 ENDIF
1873:                 IF USED("cursor_4c_ChkEmp")
1874:                     USE IN cursor_4c_ChkEmp
1875:                 ENDIF
1876:             ENDIF
1877: 
1878:             *-- Abre picker se nao encontrou match exato
1879:             IF !loc_lEncontrado
1880:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdEmp", ;
1881:                     "cursor_4c_BuscaEmp", "Cemps", loc_cValor, ;
1882:                     "Sele" + CHR(231) + CHR(227) + "o de Empresa", .T., .T., "")

*-- Linhas 1928 a 1948:
1928: 
1929:             *-- Tenta match exato
1930:             IF !EMPTY(loc_cValor)
1931:                 loc_nRet = SQLEXEC(gnConnHandle, ;
1932:                     "SELECT TOP 1 RTRIM(Dopes) AS Dopes FROM SigCdOpe " + ;
1933:                     "WHERE RTRIM(Dopes) = " + EscaparSQL(loc_cValor), ;
1934:                     "cursor_4c_ChkOpe")
1935:                 IF loc_nRet > 0 AND !EOF("cursor_4c_ChkOpe")
1936:                     THIS.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_ChkOpe.Dopes)
1937:                     loc_lEncontrado = .T.
1938:                 ENDIF
1939:                 IF USED("cursor_4c_ChkOpe")
1940:                     USE IN cursor_4c_ChkOpe
1941:                 ENDIF
1942:             ENDIF
1943: 
1944:             *-- Abre picker (SigCdOpe: Dopes eh PK e descricao - coluna unica)
1945:             IF !loc_lEncontrado
1946:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdOpe", ;
1947:                     "cursor_4c_BuscaOpe", "Dopes", loc_cValor, ;
1948:                     "Opera" + CHR(231) + CHR(227) + "o", .T., .T., "")

*-- Linhas 1982 a 2013:
1982:             ENDIF
1983: 
1984:             SET NULL ON
1985:             CREATE CURSOR cursor_4c_ImpreV (impresS C(100) NULL)
1986:             SET NULL OFF
1987: 
1988:             DIMENSION la_4c_Printers(1, 3)
1989:             loc_nTotal = APRINTERS(la_4c_Printers)
1990: 
1991:             IF loc_nTotal > 0
1992:                 FOR loc_nI = 1 TO loc_nTotal
1993:                     INSERT INTO cursor_4c_ImpreV VALUES (la_4c_Printers[loc_nI, 1])
1994:                 ENDFOR
1995:             ENDIF
1996: 
1997:             IF RECCOUNT("cursor_4c_ImpreV") = 0
1998:                 INSERT INTO cursor_4c_ImpreV VALUES ("Impressora Padr" + CHR(227) + "o")
1999:             ENDIF
2000: 
2001:             GO TOP IN cursor_4c_ImpreV
2002: 
2003:             THIS.cbo_4c_Get_Printer.RowSourceType = 2
2004:             THIS.cbo_4c_Get_Printer.RowSource     = "cursor_4c_ImpreV"
2005:             THIS.cbo_4c_Get_Printer.BoundColumn   = 1
2006:             THIS.cbo_4c_Get_Printer.BoundTo       = .F.
2007:             THIS.cbo_4c_Get_Printer.Refresh()
2008: 
2009:         CATCH TO loc_oErro
2010:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2011:                     " PROC=" + loc_oErro.Procedure, ;
2012:                     "Erro FormSigPrEtq.CarregarImpressoras")
2013:         ENDTRY

*-- Linhas 2073 a 2116:
2073:             *-- 1. Tentar match por EAN13 (numerico inteiro)
2074:             loc_nCod = INT(VAL(loc_cProd))
2075:             IF loc_nCod > 0
2076:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2077:                     "SELECT TOP 1 RTRIM(CPros) AS Cpros, RTRIM(DPros) AS DPros, " + ;
2078:                     "PVens, PrecoDe FROM SigCdPro " + ;
2079:                     "WHERE Ean13 = " + FormatarNumeroSQL(loc_nCod), ;
2080:                     "cursor_4c_PrEan")
2081:                 IF loc_nRet > 0 AND !EOF("cursor_4c_PrEan")
2082:                     dbImpressao.Cpros = PADR(ALLTRIM(cursor_4c_PrEan.Cpros), 14)
2083:                     dbImpressao.DPros = PADR(ALLTRIM(cursor_4c_PrEan.DPros), 40)
2084:                     dbImpressao.PVens   = cursor_4c_PrEan.PVens
2085:                     dbImpressao.PrecoDe = cursor_4c_PrEan.PrecoDe
2086:                     THIS.grd_4c_Dados.Refresh()
2087:                     IF USED("cursor_4c_PrEan")
2088:                         USE IN cursor_4c_PrEan
2089:                     ENDIF
2090:                     RETURN
2091:                 ENDIF
2092:                 IF USED("cursor_4c_PrEan")
2093:                     USE IN cursor_4c_PrEan
2094:                 ENDIF
2095:             ENDIF
2096: 
2097:             *-- 2. Tentar match direto por CPros
2098:             loc_nRet = SQLEXEC(gnConnHandle, ;
2099:                 "SELECT TOP 1 RTRIM(CPros) AS Cpros, RTRIM(DPros) AS DPros, " + ;
2100:                 "PVens, PrecoDe FROM SigCdPro " + ;
2101:                 "WHERE RTRIM(CPros) = " + EscaparSQL(loc_cProd), ;
2102:                 "cursor_4c_PrCd")
2103:             IF loc_nRet > 0 AND !EOF("cursor_4c_PrCd")
2104:                 dbImpressao.DPros   = PADR(ALLTRIM(cursor_4c_PrCd.DPros), 40)
2105:                 dbImpressao.PVens   = cursor_4c_PrCd.PVens
2106:                 dbImpressao.PrecoDe = cursor_4c_PrCd.PrecoDe
2107:                 THIS.grd_4c_Dados.Refresh()
2108:                 IF USED("cursor_4c_PrCd")
2109:                     USE IN cursor_4c_PrCd
2110:                 ENDIF
2111:                 RETURN
2112:             ENDIF
2113:             IF USED("cursor_4c_PrCd")
2114:                 USE IN cursor_4c_PrCd
2115:             ENDIF
2116: 

*-- Linhas 2168 a 2188:
2168:             ENDIF
2169: 
2170:             *-- Tentar match por DPros
2171:             loc_nRet = SQLEXEC(gnConnHandle, ;
2172:                 "SELECT TOP 1 RTRIM(CPros) AS Cpros, RTRIM(DPros) AS DPros " + ;
2173:                 "FROM SigCdPro WHERE RTRIM(DPros) = " + EscaparSQL(loc_cDesc), ;
2174:                 "cursor_4c_PrDp")
2175:             IF loc_nRet > 0 AND !EOF("cursor_4c_PrDp")
2176:                 dbImpressao.Cpros = PADR(ALLTRIM(cursor_4c_PrDp.Cpros), 14)
2177:                 THIS.grd_4c_Dados.Refresh()
2178:                 IF USED("cursor_4c_PrDp")
2179:                     USE IN cursor_4c_PrDp
2180:                 ENDIF
2181:                 RETURN
2182:             ENDIF
2183:             IF USED("cursor_4c_PrDp")
2184:                 USE IN cursor_4c_PrDp
2185:             ENDIF
2186: 
2187:             *-- Nao encontrado: abrir picker por descricao
2188:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;

*-- Linhas 2235 a 2256:
2235:             ENDIF
2236: 
2237:             *-- Tentar match por Dpro2s (referencia do fornecedor)
2238:             loc_nRet = SQLEXEC(gnConnHandle, ;
2239:                 "SELECT TOP 1 RTRIM(CPros) AS Cpros, RTRIM(DPros) AS DPros, " + ;
2240:                 "RTRIM(DPro2s) AS DPro2s, PVens, PrecoDe " + ;
2241:                 "FROM SigCdPro WHERE RTRIM(DPro2s) = " + EscaparSQL(loc_cReff), ;
2242:                 "cursor_4c_PrRff")
2243:             IF loc_nRet > 0 AND !EOF("cursor_4c_PrRff")
2244:                 dbImpressao.Cpros   = PADR(ALLTRIM(cursor_4c_PrRff.Cpros), 14)
2245:                 dbImpressao.DPros   = PADR(ALLTRIM(cursor_4c_PrRff.DPros), 40)
2246:                 dbImpressao.PVens   = cursor_4c_PrRff.PVens
2247:                 dbImpressao.PrecoDe = cursor_4c_PrRff.PrecoDe
2248:                 THIS.grd_4c_Dados.Refresh()
2249:                 IF USED("cursor_4c_PrRff")
2250:                     USE IN cursor_4c_PrRff
2251:                 ENDIF
2252:                 RETURN
2253:             ENDIF
2254:             IF USED("cursor_4c_PrRff")
2255:                 USE IN cursor_4c_PrRff
2256:             ENDIF

*-- Linhas 2309 a 2350:
2309:             ENDIF
2310: 
2311:             *-- Validar produto existe em SigCdPro
2312:             loc_nRet = SQLEXEC(gnConnHandle, ;
2313:                 "SELECT TOP 1 RTRIM(CPros) AS Cpros FROM SigCdPro " + ;
2314:                 "WHERE RTRIM(CPros) = " + EscaparSQL(loc_cProd), ;
2315:                 "cursor_4c_PrQt")
2316:             IF loc_nRet <= 0 OR EOF("cursor_4c_PrQt")
2317:                 MsgAviso("Produto Inv" + CHR(225) + "lido!!!")
2318:                 IF USED("cursor_4c_PrQt")
2319:                     USE IN cursor_4c_PrQt
2320:                 ENDIF
2321:                 RETURN
2322:             ENDIF
2323:             IF USED("cursor_4c_PrQt")
2324:                 USE IN cursor_4c_PrQt
2325:             ENDIF
2326: 
2327:             *-- Definir quantidade de etiquetas igual a qtds (se maior que 0)
2328:             IF loc_nQtd > 0
2329:                 dbImpressao.QtdeEtiq = loc_nQtd
2330:             ENDIF
2331: 
2332:             THIS.grd_4c_Dados.Refresh()
2333: 
2334:             *-- Avancar para proxima linha (ENTER = nova linha no grid)
2335:             SELECT dbImpressao
2336:             IF !EOF()
2337:                 SKIP
2338:                 IF EOF()
2339:                     APPEND BLANK
2340:                 ENDIF
2341:             ENDIF
2342: 
2343:             THIS.grd_4c_Dados.Refresh()
2344:             THIS.grd_4c_Dados.SetFocus
2345: 
2346:             loc_lSucesso = .T.
2347: 
2348:         CATCH TO loc_oErro
2349:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2350:                     " PROC=" + loc_oErro.Procedure, ;

*-- Linhas 2403 a 2430:
2403:                 RETURN
2404:             ENDIF
2405: 
2406:             SELECT dbImpressao
2407:             SET ORDER TO
2408: 
2409:             *-- Se a grade tem apenas uma linha em branco padrao, reusa-a
2410:             IF RECCOUNT("dbImpressao") = 1 AND EMPTY(ALLTRIM(NVL(dbImpressao.Cpros, "")))
2411:                 GO TOP IN dbImpressao
2412:             ELSE
2413:                 APPEND BLANK IN dbImpressao
2414:                 *-- Posiciona na ultima linha (a que acabou de ser criada)
2415:                 SELECT dbImpressao
2416:                 GO BOTTOM IN dbImpressao
2417:             ENDIF
2418: 
2419:             THIS.grd_4c_Dados.Refresh()
2420:             THIS.AtualizarEstadoColunas()
2421: 
2422:             *-- Foca a coluna de produto para digitacao imediata
2423:             IF PEMSTATUS(THIS.grd_4c_Dados, "col_4c_cpros", 5)
2424:                 THIS.grd_4c_Dados.SetFocus()
2425:                 THIS.grd_4c_Dados.ActivateCell( ;
2426:                     RECNO("dbImpressao"), 1)
2427:             ENDIF
2428: 
2429:         CATCH TO loc_oErro
2430:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;

*-- Linhas 2447 a 2465:
2447:                 RETURN
2448:             ENDIF
2449: 
2450:             SELECT dbImpressao
2451:             loc_nRecno = RECNO("dbImpressao")
2452: 
2453:             IF EOF("dbImpressao") OR EMPTY(ALLTRIM(NVL(dbImpressao.Cpros, "")))
2454:                 MsgAviso("Selecione um item na grade antes de alterar!!!")
2455:                 THIS.grd_4c_Dados.SetFocus()
2456:                 RETURN
2457:             ENDIF
2458: 
2459:             *-- Permite editar Parcelas se a modalidade Preco = Parcelamento (6)
2460:             IF THIS.obj_4c_Opt_Preco.Value = 6
2461:                 THIS.grd_4c_Dados.col_4c_par.ReadOnly = .F.
2462:             ENDIF
2463: 
2464:             THIS.grd_4c_Dados.Refresh()
2465: 

*-- Linhas 2493 a 2514:
2493:             loc_nQtdTotal = 0
2494: 
2495:             *-- Conta itens validos (Cpros preenchido)
2496:             SELECT COUNT(*) AS nTot, ;
2497:                    COUNT(DISTINCT Cpros) AS nDist, ;
2498:                    SUM(NVL(QtdeEtiq, 0)) AS nQtd ;
2499:                 FROM dbImpressao ;
2500:                 WHERE !EMPTY(NVL(Cpros, "")) ;
2501:                 INTO CURSOR cursor_4c_TmpResumo
2502: 
2503:             IF USED("cursor_4c_TmpResumo") AND !EOF("cursor_4c_TmpResumo")
2504:                 loc_nTotal     = NVL(cursor_4c_TmpResumo.nTot,  0)
2505:                 loc_nDistintos = NVL(cursor_4c_TmpResumo.nDist, 0)
2506:                 loc_nQtdTotal  = NVL(cursor_4c_TmpResumo.nQtd,  0)
2507:             ENDIF
2508: 
2509:             IF USED("cursor_4c_TmpResumo")
2510:                 USE IN cursor_4c_TmpResumo
2511:             ENDIF
2512: 
2513:             IF loc_nTotal = 0
2514:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + ;

*-- Linhas 2523 a 2541:
2523: 
2524:             MsgInfo(loc_cMsg, "Visualizar Impress" + CHR(227) + "o")
2525: 
2526:             SELECT dbImpressao
2527:             GO TOP IN dbImpressao
2528:             THIS.grd_4c_Dados.Refresh()
2529: 
2530:         CATCH TO loc_oErro
2531:             IF USED("cursor_4c_TmpResumo")
2532:                 USE IN cursor_4c_TmpResumo
2533:             ENDIF
2534:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2535:                     " PROC=" + loc_oErro.Procedure, ;
2536:                     "Erro FormSigPrEtq.BtnVisualizarClick")
2537:         ENDTRY
2538:     ENDPROC
2539: 
2540:     *--------------------------------------------------------------------------
2541:     * FormParaBO - Transfere parametros dos controles do form para o BO

*-- Linhas 2592 a 2610:
2592:     *--------------------------------------------------------------------------
2593:     PROCEDURE CarregarLista()
2594:         IF USED("dbImpressao")
2595:             SELECT dbImpressao
2596:             IF RECCOUNT("dbImpressao") = 0
2597:                 APPEND BLANK IN dbImpressao
2598:             ENDIF
2599:             GO TOP IN dbImpressao
2600:         ENDIF
2601: 
2602:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2603:             THIS.grd_4c_Dados.Refresh()
2604:         ENDIF
2605:     ENDPROC
2606: 
2607:     *--------------------------------------------------------------------------
2608:     * LimparCampos - Limpa filtros de entrada e reseta grade dbImpressao
2609:     *--------------------------------------------------------------------------
2610:     PROCEDURE LimparCampos()


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

            loc_lSucesso = .T.

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

