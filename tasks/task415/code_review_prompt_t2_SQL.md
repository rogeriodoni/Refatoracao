# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CODIGOS, DOPES, CTITS, CCARS, GRUCARTITS, NTIPOS, FICHATECS, OPEINATVS, I, SGRUS, CPROS

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
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
  ControlSource = "crFichaCab.CGrus"
  ControlSource = "crFichaCab.DGrus"
  ControlSource = "crFichaCab.SGrus"
  ControlSource = "crFichaCab.DSGru"
  ControlSource = "crFichaCab.nChkDims"
  ControlSource = "crFichaCab.nChkPess"
  ControlSource = "crFichaCab.nChkTems"
  ControlSource = "crFichaCab.nChkImps"
  ControlSource = "crFichaCab.nFixFigs"
	lcQuery = [Select a.CGrus, a.nChkDims, a.nChkPess, a.nChkTems, a.nChkImps, a.nFixFigs, a.mFicTecs ] + ;
				[From SigCdGrp a ] + ;
	lcQuery = [Select a.Codigos as CGrus, 2 as nChkDims, 2 as nChkPess, 2 as nChkTems, 2 as nChkImps, 2 as nFixFigs, ] + ;
			  [Null as mFicTecs from SigCdGcr a ] + ;
	lcQuery = [Select a.Dopes as CGrus, 2 as nChkDims, 2 as nChkPess, 2 as nChkTems, 2 as nChkImps, 2 as nFixFigs, ] + ;
			  [Null as mFicTecs from SigCdOpe a ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalGru]) < 1)
	Insert Into crFichaCab (CGrus, DGrus, SGrus, DSGru, nChkDims, nChkPess, nChkTems, nChkImps, nFixFigs, mFicTecs) ;
lcQuery = [Select a.* ] + ;
			[From SigCdFtc a ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCFTec]) < 1)
Select LocalCFTec
	Insert Into crFichaTec (COrds, CGrus, SGrus, CCars, CTits, CLins, Maxs, Mins, nChkCxas, cSelecaos, cTpDados) ;
	Insert Into crFichaTec (COrds, CGrus, SGrus) Values (lnOrd, lcGru, lcSGr)
	Select crFichaTec
lcQuery = [Select * ] + ;
			[From SigCdFtc ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCFTec]) < 1)
	Select LocalCfTec
		Select crFichaTec
			lcQuery = [Select Distinct a.CPros ] + ;
						[From SigCdPft a, SigCdPro b ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalProFT]) < 1)
				lcQuery = [Select Distinct GruCarTits ] + ;
							[From SigCdFtr ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCFTeR]) < 1)
lcQuery = [Delete From SigCdFtc ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
	=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (mSv_Alterar - Delete - SigCdFtc)])
	Select CCars, CTits, Sum(1) as Totas ;
	  From crSigCdFtc ;
	Select csItens
	Select COrds, Sum(1) as Totas ;
	  From crSigCdFtc ;
	Select csItens
	lcQuery = [Select * ] + ;
				[From SigCdGrp ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalGru]) < 1)
	Select LocalGru
	Insert Into crSigCdGrp From Memvar
	If Not ThisForm.poDataMgr.Update([crSigCdGrp])
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigCdGrp)])
	lcQuery = [Delete From SigCdFtc ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
	=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (mSv_Alterar - Delete - SigCdFtc)])
		If Not ThisForm.poDataMgr.Update([crSigCdFtc])
			=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigCdFtc)])
	lcQryFTec = [Select * from SigCdFtc where nTipos = ]+Str(ThisForm.pnTipo,1)
			lcQuery = [Select CGrus, DGrus, FTecSubs ] + ;
						[From SigCdGrp ] + ;
			If (.poDataMgr.SqlExecute(lcQuery, [LocalGru]) < 1)
			Select LocalGru
				oProg.Update(.t.)
				Insert Into crDados (CGrus, DGrus, SGrus, DSGru, TemDados) ;
				lcQuery = [Select Distinct CGrus ] + ;
							[From SigCdFtc ] + ;
				If (.poDataMgr.SqlExecute(lcQuery, [LocalCfTec]) < 1)
					lcQuery = [Select CGrus, Codigos, Descricaos ] + ;
								[From SigCdPsg ] + ;
					If (.poDataMgr.SqlExecute(lcQuery, [LocalSGru]) < 1)
					Select LocalSGru
						Insert Into crDados (CGrus, DGrus, SGrus, DSGru, TemDados) ;
						lcQuery = [Select Distinct CGrus, SGrus ] + ;
									[From SigCdFtc ] + ;
						If (.poDataMgr.SqlExecute(lcQuery, [LocalCfTec]) < 1)
			lcQuery = [Select Codigos, Descrs ] + ;
						[From SigCdGcr Where FichaTecs = 1 ] + ;
			If (.poDataMgr.SqlExecute(lcQuery, [LocalGru]) < 1)
			Select LocalGru
				oProg.Update(.t.)
				Insert Into crDados (CGrus, DGrus, SGrus, DSGru, TemDados) ;
				lcQuery = [Select Distinct CGrus ] + ;
							[From SigCdFtc ] + ;
				If (.poDataMgr.SqlExecute(lcQuery, [LocalCfTec]) < 1)
			lcQuery = [Select a.Dopes, a.TitOpes ] + ;
						[From SigCdOpe a ] + ;
						[Left Join SigOpCdc b On a.Dopes = b.Dopes ] + ;
			If (.poDataMgr.SqlExecute(lcQuery, [LocalGru]) < 1)
			Select LocalGru
				oProg.Update(.t.)
				Insert Into crDados (CGrus, DGrus, SGrus, DSGru, TemDados) ;
				lcQuery = [Select Distinct cgrus ] + ;
							[From SigCdFtc ] + ;
				If (.poDataMgr.SqlExecute(lcQuery, [LocalCfTec]) < 1)
			.Column1.ControlSource = [crDados.CGrus]
			.Column2.ControlSource = [crDados.SGrus]
			.Column3.ControlSource = [crDados.DGrus]
			.Column4.ControlSource = [crDados.DSGru]
			.Column1.ControlSource = [crFichaTec.CCars]
			.Column2.ControlSource = [crFichaTec.CTits]
			.Column3.ControlSource = [crFichaTec.COrds]
			.Column4.ControlSource = [crFichaTec.CLins]
			.Column5.ControlSource = [crFichaTec.Maxs]
			.Column6.ControlSource = [crFichaTec.Mins]
			.Column7.ControlSource = [crFichaTec.nChkCxas]
			.Column8.ControlSource = [crFichaTec.cSelecaos]
			.Column9.ControlSource = [crFichaTec.cTpDados]
	lcQuery = [Select CGrus, DGrus, Mercs, Margems, 'S' as Apagar From SigCdGrp]
	lcQuery = [Select Codigos as cGrus, Descrs as DGrus, '   ' as Mercs, 0 as Margems, 'S' as Apagar from SigCdGcr]
	lcQuery = [Select Dopes as cGrus, TitOpes as DGrus, '   ' as Mercs, 0 as Margems, 'S' as Apagar from SigCdOpe]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdGrpFilter') < 1)
Select crSigCdGrpFilter
	lcQuery = [Select a.CGrus, a.nChkDims, a.nChkPess, a.nChkTems, a.nChkImps, a.nFixFigs, a.mFicTecs ] + ;
				[From SigCdGrp a ] + ;
	lcQuery = [Select a.Codigos as CGrus, 2 as nChkDims, 2 as nChkPess, 2 as nChkTems, 2 as nChkImps, 2 as nFixFigs, ] + ;
			  ['' as mFicTecs from SigCdGcr a ] + ; &&Null as mFicTecs 
	lcQuery = [Select a.Dopes as CGrus, 2 as nChkDims, 2 as nChkPess, 2 as nChkTems, 2 as nChkImps, 2 as nFixFigs, ] + ;
			  ['' as mFicTecs from SigCdOpe a ] + ; 
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalGru]) < 1)
	Insert Into crFichaCab (CGrus, DGrus, SGrus, DSGru, nChkDims, nChkPess, nChkTems, nChkImps, nFixFigs, mFicTecs) ;
lcQuery = [Select a.* ] + ;
			[From SigCdFtc a ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCFTec]) < 1)
Select LocalCFTec
	Insert Into crFichaTec (COrds, CGrus, SGrus, CCars, CTits, CLins, Maxs, Mins, nChkCxas, cSelecaos, cTpDados) ;
	Insert Into crFichaTec (COrds, CGrus, SGrus) Values (lnOrd, lcGru, lcSGr)
	Select crFichaTec
Select crFichaTec
	 	Insert Into crSigCdFtc (COrds, CGrus, SGrus, CCars, CTits, CLins, Maxs, Mins, nChkCxas, cSelecaos, cIdChaves, nTipos, cTpDados) ;
lcQuery = [Select * ] + ;
		  [From SigCdFtc ] + ;
ThisForm.poDatamgr.SqlExecute(lcQuery, [cpSigCdFtc])
Select cpSigCdFtc 
	Select crFichaTec
	Select cpSigCdFtc 
		Select crFichaTec
	If Not Seek(This.Value, 'crSigCdGrpFilter', 'CGrus')
	If Not Seek(This.Value, 'crSigCdGrpFilter', 'CGrus')
	Select crFichaTec
		Insert Into crFichaTec (COrds, CGrus, SGrus) Values (lnOrd, crFichaCab.CGrus, crFichaCab.SGrus)
	Delete In crFichaTec
	Select * ;
	  From crFichaTec ;
		Insert Into crFichaTec (COrds, CGrus, SGrus) Values (1, crFichaCab.CGrus, crFichaCab.SGrus)
			Delete File (lcFig)
			Delete File (lcArq)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormFct.prg) - TRECHOS RELEVANTES PARA PASS SQL (1983 linhas total):

*-- Linhas 348 a 406:
348:                 .ReadOnly     = .T.
349:                 .GridLines    = 1
350:                 .HeaderHeight = 18
351:                 .DeleteMark   = .F.
352:                 .RecordMark   = .F.
353:                 .Visible      = .T.
354:                 WITH .Column1
355:                     .ControlSource = "crDados.CGrus"
356:                     DO CASE
357:                     CASE THIS.this_nTipo = 1
358:                         .Width           = 100
359:                         .Header1.Caption = "Grupo"
360:                     CASE THIS.this_nTipo = 2
361:                         .Width           = 100
362:                         .Header1.Caption = "Grupo"
363:                     OTHERWISE
364:                         .Width           = 80
365:                         .Header1.Caption = "Grupo"
366:                     ENDCASE
367:                     .ReadOnly = .T.
368:                 ENDWITH
369:                 WITH .Column2
370:                     .ControlSource   = "crDados.SGrus"
371:                     .Width           = IIF(THIS.this_nTipo = 0, 100, 0)
372:                     .Header1.Caption = "Subgrupo"
373:                     .ReadOnly        = .T.
374:                 ENDWITH
375:                 WITH .Column3
376:                     .ControlSource = "crDados.DGrus"
377:                     DO CASE
378:                     CASE THIS.this_nTipo = 1
379:                         .Width           = 641
380:                         .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Grupo"
381:                     CASE THIS.this_nTipo = 2
382:                         .Width           = 641
383:                         .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Grupo"
384:                     OTHERWISE
385:                         .Width           = 403
386:                         .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Grupo"
387:                     ENDCASE
388:                     .ReadOnly = .T.
389:                 ENDWITH
390:                 WITH .Column4
391:                     .ControlSource   = "crDados.DSGru"
392:                     .Width           = IIF(THIS.this_nTipo = 0, 358, 0)
393:                     .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Subgrupo"
394:                     .ReadOnly        = .T.
395:                 ENDWITH
396:             ENDWITH
397:             loc_oPag.grd_4c_Lista.SetAll("DynamicBackColor", ;
398:                 "IIF(EMPTY(crDados.TemDados), RGB(255,255,255), RGB(255,255,187))", "Column")
399: 
400:             BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
401:             BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
402:             BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
403:             BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
404:             BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
405:             BINDEVENT(loc_oPag.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
406:             BINDEVENT(loc_oPag.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")

*-- Linhas 528 a 613:
528:                 .Width         = 80
529:                 .Height        = 20
530:                 .Enabled       = .F.
531:                 .ControlSource = "crFichaCab.CGrus"
532:                 .Visible       = .T.
533:             ENDWITH
534: 
535:             loc_oPg.AddObject("txt_4c_DGrus", "TextBox")
536:             WITH loc_oPg.txt_4c_DGrus
537:                 .Top           = 17
538:                 .Left          = 180
539:                 .Width         = 290
540:                 .Height        = 20
541:                 .Enabled       = .F.
542:                 .ControlSource = "crFichaCab.DGrus"
543:                 .Visible       = .T.
544:             ENDWITH
545: 
546:             loc_oPg.AddObject("lbl_4c_LabelSGrus", "Label")
547:             WITH loc_oPg.lbl_4c_LabelSGrus
548:                 .Top      = 45
549:                 .Left     = 25
550:                 .Width    = 70
551:                 .Height   = 18
552:                 .AutoSize = .F.
553:                 .Caption  = "Sub-grupo :"
554:                 .Visible  = (THIS.this_nTipo = 0)
555:             ENDWITH
556: 
557:             loc_oPg.AddObject("txt_4c_SGrus", "TextBox")
558:             WITH loc_oPg.txt_4c_SGrus
559:                 .Top           = 42
560:                 .Left          = 98
561:                 .Width         = 80
562:                 .Height        = 20
563:                 .Enabled       = .F.
564:                 .ControlSource = "crFichaCab.SGrus"
565:                 .Visible       = (THIS.this_nTipo = 0)
566:             ENDWITH
567: 
568:             loc_oPg.AddObject("txt_4c_DSGru", "TextBox")
569:             WITH loc_oPg.txt_4c_DSGru
570:                 .Top           = 42
571:                 .Left          = 180
572:                 .Width         = 290
573:                 .Height        = 20
574:                 .Enabled       = .F.
575:                 .ControlSource = "crFichaCab.DSGru"
576:                 .Visible       = (THIS.this_nTipo = 0)
577:             ENDWITH
578: 
579:             loc_oPg.AddObject("lbl_4c_LabelChkDims", "Label")
580:             WITH loc_oPg.lbl_4c_LabelChkDims
581:                 .Top      = 10
582:                 .Left     = 620
583:                 .Width    = 105
584:                 .Height   = 18
585:                 .AutoSize = .F.
586:                 .Caption  = "Dimens" + CHR(245) + "es :"
587:                 .Visible  = (THIS.this_nTipo = 0)
588:             ENDWITH
589: 
590:             loc_oPg.AddObject("opt_4c_NChkDims", "OptionGroup")
591:             WITH loc_oPg.opt_4c_NChkDims
592:                 .Top           = 10
593:                 .Left          = 729
594:                 .Width         = 180
595:                 .Height        = 16
596:                 .ButtonCount   = 2
597:                 .Value         = 1
598:                 .ControlSource = "crFichaCab.nChkDims"
599:                 .Visible       = (THIS.this_nTipo = 0)
600:                 WITH .Buttons(1)
601:                     .Caption   = "Sim"
602:                     .Width     = 50
603:                     .BackStyle = 0
604:                 ENDWITH
605:                 WITH .Buttons(2)
606:                     .Caption   = "N" + CHR(227) + "o"
607:                     .Left      = 55
608:                     .Width     = 60
609:                     .BackStyle = 0
610:                 ENDWITH
611:             ENDWITH
612: 
613:             loc_oPg.AddObject("lbl_4c_LabelChkTems", "Label")

*-- Linhas 629 a 647:
629:                 .Height        = 16
630:                 .ButtonCount   = 2
631:                 .Value         = 1
632:                 .ControlSource = "crFichaCab.nChkTems"
633:                 .Visible       = (THIS.this_nTipo = 0)
634:                 WITH .Buttons(1)
635:                     .Caption   = "Sim"
636:                     .Width     = 50
637:                     .BackStyle = 0
638:                 ENDWITH
639:                 WITH .Buttons(2)
640:                     .Caption   = "N" + CHR(227) + "o"
641:                     .Left      = 55
642:                     .Width     = 60
643:                     .BackStyle = 0
644:                 ENDWITH
645:             ENDWITH
646: 
647:             loc_oPg.AddObject("lbl_4c_LabelChkPess", "Label")

*-- Linhas 663 a 681:
663:                 .Height        = 16
664:                 .ButtonCount   = 2
665:                 .Value         = 1
666:                 .ControlSource = "crFichaCab.nChkPess"
667:                 .Visible       = (THIS.this_nTipo = 0)
668:                 WITH .Buttons(1)
669:                     .Caption   = "Sim"
670:                     .Width     = 50
671:                     .BackStyle = 0
672:                 ENDWITH
673:                 WITH .Buttons(2)
674:                     .Caption   = "N" + CHR(227) + "o"
675:                     .Left      = 55
676:                     .Width     = 60
677:                     .BackStyle = 0
678:                 ENDWITH
679:             ENDWITH
680: 
681:             loc_oPg.AddObject("grd_4c_Fichas", "Grid")

*-- Linhas 689 a 744:
689:                 .RecordSource = "crFichaTec"
690:                 .ReadOnly     = .F.
691:                 .GridLines    = 1
692:                 .DeleteMark   = .F.
693:                 .RecordMark   = .F.
694:                 .Visible      = .T.
695:                 WITH .Column1
696:                     .Width           = 200
697:                     .ControlSource   = "crFichaTec.CCars"
698:                     .Header1.Caption = "Grupo Caracter" + CHR(237) + "sticas"
699:                 ENDWITH
700:                 WITH .Column2
701:                     .Width           = 200
702:                     .ControlSource   = "crFichaTec.CTits"
703:                     .Header1.Caption = "T" + CHR(237) + "tulo Caracter" + CHR(237) + "sticas"
704:                 ENDWITH
705:                 WITH .Column3
706:                     .Width           = 50
707:                     .ControlSource   = "crFichaTec.COrds"
708:                     .Header1.Caption = "Ordem"
709:                     .Text1.InputMask = "999"
710:                 ENDWITH
711:                 WITH .Column4
712:                     .Width           = 50
713:                     .ControlSource   = "crFichaTec.CLins"
714:                     .Header1.Caption = "Linhas"
715:                     .Text1.InputMask = "99"
716:                 ENDWITH
717:                 WITH .Column5
718:                     .Width           = 50
719:                     .ControlSource   = "crFichaTec.Maxs"
720:                     .Header1.Caption = "M" + CHR(225) + "ximo"
721:                 ENDWITH
722:                 WITH .Column6
723:                     .Width           = 50
724:                     .ControlSource   = "crFichaTec.Mins"
725:                     .Header1.Caption = "M" + CHR(237) + "nimo"
726:                 ENDWITH
727:                 WITH .Column7
728:                     .Width          = 243
729:                     .ControlSource  = "crFichaTec.nChkCxas"
730:                     .Header1.Caption = "Digita" + CHR(231) + CHR(227) + "o"
731:                     .Sparse         = .F.
732:                     .CurrentControl = "opt_4c_NChkCxas"
733:                     .AddObject("opt_4c_NChkCxas", "OptionGroup")
734:                     WITH .opt_4c_NChkCxas
735:                         .ButtonCount = 3
736:                         .Value       = 1
737:                         .Height      = 16
738:                         .Width       = 241
739:                         WITH .Buttons(1)
740:                             .Caption   = "Maiusculo"
741:                             .Width     = 74
742:                             .BackStyle = 0
743:                         ENDWITH
744:                         WITH .Buttons(2)

*-- Linhas 756 a 779:
756:                 ENDWITH
757:                 WITH .Column8
758:                     .Width           = 25
759:                     .ControlSource   = "crFichaTec.cSelecaos"
760:                     .Header1.Caption = "S"
761:                 ENDWITH
762:                 WITH .Column9
763:                     .Width           = 25
764:                     .ControlSource   = "crFichaTec.cTpDados"
765:                     .Header1.Caption = "T"
766:                 ENDWITH
767:             ENDWITH
768: 
769:             loc_oPg.AddObject("cmd_4c_ApagarLinha", "CommandButton")
770:             WITH loc_oPg.cmd_4c_ApagarLinha
771:                 .Top     = 235
772:                 .Left    = 949
773:                 .Width   = 40
774:                 .Height  = 40
775:                 .Caption = ""
776:                 .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
777:                 .Themes  = .T.
778:                 .Visible = .F.
779:             ENDWITH

*-- Linhas 936 a 954:
936:                 .Height        = 16
937:                 .ButtonCount   = 2
938:                 .Value         = 1
939:                 .ControlSource = "crFichaCab.nChkImps"
940:                 .Visible       = (THIS.this_nTipo = 0)
941:                 WITH .Buttons(1)
942:                     .Caption   = "Produtos"
943:                     .Width     = 70
944:                     .BackStyle = 0
945:                 ENDWITH
946:                 WITH .Buttons(2)
947:                     .Caption   = "Ficha T" + CHR(233) + "cnica"
948:                     .Left      = 75
949:                     .Width     = 90
950:                     .BackStyle = 0
951:                 ENDWITH
952:             ENDWITH
953: 
954:             loc_oPg.AddObject("chk_4c_NFixFigs", "CheckBox")

*-- Linhas 960 a 978:
960:                 .Style         = 1
961:                 .Caption       = ""
962:                 .Picture       = gc_4c_CaminhoIcones + "geral_lock_on_34.jpg"
963:                 .ControlSource = "crFichaCab.nFixFigs"
964:                 .Themes        = .T.
965:                 .Visible       = (THIS.this_nTipo = 0)
966:             ENDWITH
967: 
968:             loc_oPg.AddObject("img_4c_FigTec", "Image")
969:             WITH loc_oPg.img_4c_FigTec
970:                 .Top     = 94
971:                 .Left    = 301
972:                 .Width   = 334
973:                 .Height  = 228
974:                 .Stretch = 1
975:                 .Visible = .F.
976:             ENDWITH
977: 
978:             loc_oPg.AddObject("cmd_4c_Figura", "CommandButton")

*-- Linhas 1070 a 1088:
1070:             IF !USED("crDados") OR RECCOUNT("crDados") = 0
1071:                 MsgAviso("Selecione um registro na lista.", "Aviso")
1072:             ELSE
1073:                 SELECT crDados
1074:                 IF EOF()
1075:                     MsgAviso("Selecione um registro na lista.", "Aviso")
1076:                 ELSE
1077:                     loc_cCGrus = ALLTRIM(crDados.CGrus)
1078:                     loc_cSGrus = ALLTRIM(crDados.SGrus)
1079:                     loc_cDGrus = ALLTRIM(crDados.DGrus)
1080:                     loc_cDSGru = ALLTRIM(crDados.DSGru)
1081: 
1082:             THIS.this_cModoAtual = par_cModo
1083:             THIS.this_oBusinessObject.CarregarFicha(loc_cCGrus, loc_cSGrus, ;
1084:                 loc_cDGrus, loc_cDSGru, par_cModo)
1085: 
1086:             IF par_cModo = "ALTERAR"
1087:                 THIS.this_oBusinessObject.CarregarFiltroGrupos()
1088:             ENDIF

*-- Linhas 1135 a 1153:
1135:             IF !USED("crDados") OR RECCOUNT("crDados") = 0
1136:                 MsgAviso("Selecione um grupo na lista.", "Aviso")
1137:             ELSE
1138:                 SELECT crDados
1139:                 IF EOF()
1140:                     MsgAviso("Selecione um grupo na lista.", "Aviso")
1141:                 ELSE
1142:                     IF !EMPTY(ALLTRIM(crDados.TemDados))
1143:                     MsgAviso("Este grupo j" + CHR(225) + " possui ficha t" + CHR(233) + ;
1144:                         "cnica. Use Alterar para modificar.", "Aviso")
1145:                 ELSE
1146:                     loc_lResultado = THIS.CarregarDados("ALTERAR")
1147:                     ENDIF
1148:                 ENDIF
1149:             ENDIF
1150:         CATCH TO loc_oErro
1151:             MsgErro("Erro ao incluir ficha:" + CHR(13) + loc_oErro.Message, "Erro")
1152:         ENDTRY
1153:         RETURN loc_lResultado

*-- Linhas 1246 a 1273:
1246:         loc_lResultado = .F.
1247:         TRY
1248:             IF USED("crFichaTec")
1249:                 SELECT crFichaTec
1250:                 IF !EOF() AND RECCOUNT() > 0
1251:                     IF MsgConfirma("Apagar esta linha da ficha t" + CHR(233) + "cnica?", "Confirmar")
1252:                         DELETE
1253:                         PACK
1254:                         SELECT crFichaTec
1255:                         GO TOP
1256:                         IF EOF()
1257:                             THIS.this_oBusinessObject.AdicionarLinhaFicha()
1258:                             SELECT crFichaTec
1259:                             GO TOP
1260:                         ENDIF
1261:                         THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1.grd_4c_Fichas.Refresh()
1262:                         loc_lResultado = .T.
1263:                     ENDIF
1264:                 ENDIF
1265:             ENDIF
1266:         CATCH TO loc_oErro
1267:             MsgErro("Erro ao apagar linha:" + CHR(13) + loc_oErro.Message, "Erro")
1268:         ENDTRY
1269:         RETURN loc_lResultado
1270:     ENDPROC
1271: 
1272:     *--------------------------------------------------------------------------
1273:     PROCEDURE BtnRespostasClick()

*-- Linhas 1281 a 1306:
1281:                     "o dispon" + CHR(237) + "vel.", "Aviso")
1282:             ELSE
1283:                 IF USED("crFichaTec")
1284:                     SELECT crFichaTec
1285:                     IF !EOF()
1286:                         loc_cCCars = ALLTRIM(crFichaTec.CCars)
1287:                         loc_cCTits = ALLTRIM(crFichaTec.CTits)
1288:                         IF EMPTY(loc_cCCars)
1289:                             MsgAviso("Selecione uma caracter" + CHR(237) + "stica na grade.", "Aviso")
1290:                         ELSE
1291:                             SELECT crFichaCab
1292:                             loc_cCGrus = ALLTRIM(crFichaCab.CGrus)
1293:                             loc_cSGrus = ALLTRIM(crFichaCab.SGrus)
1294:                             DO FORM (gc_4c_CaminhoForms + "cadastros\FormFte") ;
1295:                                 WITH loc_cCGrus, loc_cSGrus, loc_cCCars, loc_cCTits
1296:                             loc_lResultado = .T.
1297:                         ENDIF
1298:                     ENDIF
1299:                 ENDIF
1300:             ENDIF
1301:         CATCH TO loc_oErro
1302:             MsgErro("Erro ao abrir respostas:" + CHR(13) + loc_oErro.Message, "Erro")
1303:         ENDTRY
1304:         RETURN loc_lResultado
1305:     ENDPROC
1306: 

*-- Linhas 1340 a 1393:
1340:             IF EMPTY(loc_cCGrusSrc)
1341:                 MsgAviso("Informe o grupo de origem.", "Aviso")
1342:             ELSE
1343:                 loc_cSql = "SELECT CCars, CTits, COrds, CLins, Maxs, Mins, " + ;
1344:                            "nChkCxas, cSelecaos, cTpDados " + ;
1345:                            "FROM SigCdFtc WHERE CGrus = " + EscaparSQL(loc_cCGrusSrc)
1346:                 IF THIS.this_nTipo = 0 AND !EMPTY(loc_cSGrusSrc)
1347:                     loc_cSql = loc_cSql + " AND SGrus = " + EscaparSQL(loc_cSGrusSrc)
1348:                 ENDIF
1349:                 loc_cSql = loc_cSql + " ORDER BY COrds"
1350: 
1351:                 IF USED("cursor_4c_CopiaFtc")
1352:                     USE IN cursor_4c_CopiaFtc
1353:                 ENDIF
1354:                 loc_nSql = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_CopiaFtc")
1355:                 IF loc_nSql <= 0
1356:                     MsgErro("Erro ao buscar ficha de origem.", "Erro")
1357:                 ELSE
1358:                     IF RECCOUNT("cursor_4c_CopiaFtc") = 0
1359:                         USE IN cursor_4c_CopiaFtc
1360:                         MsgAviso("Grupo de origem n" + CHR(227) + "o possui ficha t" + ;
1361:                             CHR(233) + "cnica.", "Aviso")
1362:                     ELSE
1363:                         SELECT crFichaTec
1364:                         ZAP
1365:                         SELECT cursor_4c_CopiaFtc
1366:                         SCAN
1367:                             SELECT crFichaTec
1368:                             APPEND BLANK
1369:                             REPLACE crFichaTec.CCars     WITH ALLTRIM(cursor_4c_CopiaFtc.CCars)
1370:                             REPLACE crFichaTec.CTits     WITH ALLTRIM(cursor_4c_CopiaFtc.CTits)
1371:                             REPLACE crFichaTec.COrds     WITH cursor_4c_CopiaFtc.COrds
1372:                             REPLACE crFichaTec.CLins     WITH cursor_4c_CopiaFtc.CLins
1373:                             REPLACE crFichaTec.Maxs      WITH cursor_4c_CopiaFtc.Maxs
1374:                             REPLACE crFichaTec.Mins      WITH cursor_4c_CopiaFtc.Mins
1375:                             REPLACE crFichaTec.nChkCxas  WITH cursor_4c_CopiaFtc.nChkCxas
1376:                             REPLACE crFichaTec.cSelecaos WITH cursor_4c_CopiaFtc.cSelecaos
1377:                             REPLACE crFichaTec.cTpDados  WITH cursor_4c_CopiaFtc.cTpDados
1378:                             SELECT cursor_4c_CopiaFtc
1379:                         ENDSCAN
1380:                         USE IN cursor_4c_CopiaFtc
1381: 
1382:                         THIS.this_oBusinessObject.AdicionarLinhaFicha()
1383:                         loc_oPg.cnt_4c_CopiarAcesso.Visible = .F.
1384:                         loc_oPg.grd_4c_Fichas.Refresh()
1385:                         loc_lResultado = .T.
1386:                     ENDIF
1387:                 ENDIF
1388:             ENDIF
1389:         CATCH TO loc_oErro
1390:             MsgErro("Erro ao copiar ficha:" + CHR(13) + loc_oErro.Message, "Erro")
1391:         ENDTRY
1392:         RETURN loc_lResultado
1393:     ENDPROC

*-- Linhas 1410 a 1428:
1410:             IF !EMPTY(loc_cArqFig) AND FILE(loc_cArqFig)
1411:                 loc_cConteudo = FILETOSTR(loc_cArqFig)
1412:                 IF USED("crFichaCab")
1413:                     SELECT crFichaCab
1414:                     REPLACE crFichaCab.mFicTecs WITH loc_cConteudo
1415:                 ENDIF
1416:                 loc_cExt     = LOWER(JUSTEXT(loc_cArqFig))
1417:                 loc_cArqTemp = SYS(2023) + "\FigTec_" + SYS(3) + "." + loc_cExt
1418:                 STRTOFILE(loc_cConteudo, loc_cArqTemp)
1419:                 IF FILE(loc_cArqTemp)
1420:                     loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
1421:                     loc_oPg2.img_4c_FigTec.Picture = loc_cArqTemp
1422:                     loc_oPg2.img_4c_FigTec.Visible = .T.
1423:                 ENDIF
1424:                 loc_lResultado = .T.
1425:             ENDIF
1426:         CATCH TO loc_oErro
1427:             MsgErro("Erro ao carregar figura:" + CHR(13) + loc_oErro.Message, "Erro")
1428:         ENDTRY

*-- Linhas 1442 a 1490:
1442:         loc_lResultado = .T.
1443:         TRY
1444:             IF USED("crFichaTec")
1445:                 SELECT crFichaTec
1446:                 IF !EOF()
1447:                     loc_cCCars = ALLTRIM(crFichaTec.CCars)
1448:                     IF !EMPTY(loc_cCCars)
1449:                         IF USED("cursor_4c_BuscaCCars")
1450:                             USE IN cursor_4c_BuscaCCars
1451:                         ENDIF
1452:                         loc_nSql = SQLEXEC(gnConnHandle, ;
1453:                             "SELECT CCars, DCars FROM SigCrRaP WHERE CCars = " + EscaparSQL(loc_cCCars), ;
1454:                             "cursor_4c_BuscaCCars")
1455:                         IF loc_nSql > 0 AND RECCOUNT("cursor_4c_BuscaCCars") > 0
1456:                             USE IN cursor_4c_BuscaCCars
1457:                         ELSE
1458:                             IF USED("cursor_4c_BuscaCCars")
1459:                                 USE IN cursor_4c_BuscaCCars
1460:                             ENDIF
1461:                             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1462:                                 "SigCrRaP", "cursor_4c_BuscaCCars", "CCars", loc_cCCars, ;
1463:                                 "Caracter" + CHR(237) + "sticas")
1464:                             IF !ISNULL(loc_oForm)
1465:                                 IF !loc_oForm.this_lAchouRegistro
1466:                                     loc_oForm.mAddColuna("CCars", "", "C" + CHR(243) + "digo")
1467:                                     loc_oForm.mAddColuna("DCars", "", "Descri" + CHR(231) + CHR(227) + "o")
1468:                                     loc_oForm.Show()
1469:                                 ENDIF
1470:                                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaCCars")
1471:                                     SELECT crFichaTec
1472:                                     REPLACE crFichaTec.CCars WITH ALLTRIM(cursor_4c_BuscaCCars.CCars)
1473:                                     USE IN cursor_4c_BuscaCCars
1474:                                 ELSE
1475:                                     SELECT crFichaTec
1476:                                     REPLACE crFichaTec.CCars WITH ""
1477:                                     IF USED("cursor_4c_BuscaCCars")
1478:                                         USE IN cursor_4c_BuscaCCars
1479:                                     ENDIF
1480:                                 ENDIF
1481:                                 loc_oForm.Release()
1482:                             ENDIF
1483:                         ENDIF
1484:                     ENDIF
1485:                 ENDIF
1486:             ENDIF
1487:         CATCH TO loc_oErro
1488:             MsgErro("Erro em ValidCCarsGrid:" + CHR(13) + loc_oErro.Message, "Erro")
1489:         ENDTRY
1490:         RETURN loc_lResultado

*-- Linhas 1497 a 1545:
1497:         loc_lResultado = .T.
1498:         TRY
1499:             IF USED("crFichaTec")
1500:                 SELECT crFichaTec
1501:                 IF !EOF()
1502:                     loc_cCTits = ALLTRIM(crFichaTec.CTits)
1503:                     IF !EMPTY(loc_cCTits)
1504:                         IF USED("cursor_4c_BuscaCTits")
1505:                             USE IN cursor_4c_BuscaCTits
1506:                         ENDIF
1507:                         loc_nSql = SQLEXEC(gnConnHandle, ;
1508:                             "SELECT CTits, DTits FROM SigPrCpP WHERE CTits = " + EscaparSQL(loc_cCTits), ;
1509:                             "cursor_4c_BuscaCTits")
1510:                         IF loc_nSql > 0 AND RECCOUNT("cursor_4c_BuscaCTits") > 0
1511:                             USE IN cursor_4c_BuscaCTits
1512:                         ELSE
1513:                             IF USED("cursor_4c_BuscaCTits")
1514:                                 USE IN cursor_4c_BuscaCTits
1515:                             ENDIF
1516:                             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1517:                                 "SigPrCpP", "cursor_4c_BuscaCTits", "CTits", loc_cCTits, ;
1518:                                 "T" + CHR(237) + "tulos")
1519:                             IF !ISNULL(loc_oForm)
1520:                                 IF !loc_oForm.this_lAchouRegistro
1521:                                     loc_oForm.mAddColuna("CTits", "", "C" + CHR(243) + "digo")
1522:                                     loc_oForm.mAddColuna("DTits", "", "Descri" + CHR(231) + CHR(227) + "o")
1523:                                     loc_oForm.Show()
1524:                                 ENDIF
1525:                                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaCTits")
1526:                                     SELECT crFichaTec
1527:                                     REPLACE crFichaTec.CTits WITH ALLTRIM(cursor_4c_BuscaCTits.CTits)
1528:                                     USE IN cursor_4c_BuscaCTits
1529:                                 ELSE
1530:                                     SELECT crFichaTec
1531:                                     REPLACE crFichaTec.CTits WITH ""
1532:                                     IF USED("cursor_4c_BuscaCTits")
1533:                                         USE IN cursor_4c_BuscaCTits
1534:                                     ENDIF
1535:                                 ENDIF
1536:                                 loc_oForm.Release()
1537:                             ENDIF
1538:                         ENDIF
1539:                     ENDIF
1540:                 ENDIF
1541:             ENDIF
1542:         CATCH TO loc_oErro
1543:             MsgErro("Erro em ValidCTitsGrid:" + CHR(13) + loc_oErro.Message, "Erro")
1544:         ENDTRY
1545:         RETURN loc_lResultado

*-- Linhas 1554 a 1572:
1554:         TRY
1555:             IF par_nKeyCode = 13 AND THIS.this_cModoAtual = "ALTERAR"
1556:                 IF USED("crFichaTec")
1557:                     SELECT crFichaTec
1558:                     IF !EOF() AND RECNO() = RECCOUNT()
1559:                         THIS.this_oBusinessObject.AdicionarLinhaFicha()
1560:                         THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1.grd_4c_Fichas.Refresh()
1561:                     ENDIF
1562:                 ENDIF
1563:             ENDIF
1564:             loc_lResultado = .T.
1565:         CATCH TO loc_oErro
1566:             MsgErro("Erro em KeyPressCTpDados:" + CHR(13) + loc_oErro.Message, "Erro")
1567:         ENDTRY
1568:         RETURN loc_lResultado
1569:     ENDPROC
1570: 
1571:     *--------------------------------------------------------------------------
1572:     PROCEDURE ValidCpyCGrus(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 1586 a 1604:
1586:                 loc_lEncontrado = .T.
1587:             ELSE
1588:                 IF USED("crSigCdGrpFilter")
1589:                     SELECT crSigCdGrpFilter
1590:                     LOCATE FOR ALLTRIM(crSigCdGrpFilter.CGrus) = loc_cCGrus
1591:                     IF !EOF()
1592:                         loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDGrus.Value = ALLTRIM(crSigCdGrpFilter.DGrus)
1593:                         loc_lEncontrado = .T.
1594:                     ENDIF
1595:                 ENDIF
1596:             ENDIF
1597:             IF !loc_lEncontrado
1598:                 DO CASE
1599:                 CASE THIS.this_nTipo = 1
1600:                     loc_cTabela = "SigCdGcr"
1601:                 CASE THIS.this_nTipo = 2
1602:                     loc_cTabela = "SigCdOpe"
1603:                 OTHERWISE
1604:                     loc_cTabela = "SigCdGrp"

*-- Linhas 1654 a 1696:
1654:                 IF USED("cursor_4c_BuscaSGrp")
1655:                     USE IN cursor_4c_BuscaSGrp
1656:                 ENDIF
1657:                 loc_nSql = SQLEXEC(gnConnHandle, ;
1658:                     "SELECT Codigos, Descricaos FROM SigCdPsg" + ;
1659:                     " WHERE CGrus = " + EscaparSQL(loc_cCGrus) + ;
1660:                     " AND Codigos = " + EscaparSQL(loc_cSGrus), ;
1661:                     "cursor_4c_BuscaSGrp")
1662:                 IF loc_nSql > 0 AND RECCOUNT("cursor_4c_BuscaSGrp") > 0
1663:                     SELECT cursor_4c_BuscaSGrp
1664:                     loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus.Value = ALLTRIM(cursor_4c_BuscaSGrp.Codigos)
1665:                     loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDSGru.Value = ALLTRIM(cursor_4c_BuscaSGrp.Descricaos)
1666:                     USE IN cursor_4c_BuscaSGrp
1667:                 ELSE
1668:                     IF USED("cursor_4c_BuscaSGrp")
1669:                         USE IN cursor_4c_BuscaSGrp
1670:                     ENDIF
1671:                     loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1672:                         "SigCdPsg", "cursor_4c_BuscaSGrp", "Codigos", loc_cSGrus, ;
1673:                         "Sub-grupos")
1674:                     IF VARTYPE(loc_oForm) = "O"
1675:                         IF !loc_oForm.this_lAchouRegistro
1676:                             loc_oForm.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
1677:                             loc_oForm.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1678:                             loc_oForm.Show()
1679:                         ENDIF
1680:                         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaSGrp")
1681:                             SELECT cursor_4c_BuscaSGrp
1682:                             loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus.Value = ALLTRIM(cursor_4c_BuscaSGrp.Codigos)
1683:                             loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDSGru.Value = ALLTRIM(cursor_4c_BuscaSGrp.Descricaos)
1684:                             USE IN cursor_4c_BuscaSGrp
1685:                         ELSE
1686:                             loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus.Value = ""
1687:                             loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDSGru.Value = ""
1688:                             IF USED("cursor_4c_BuscaSGrp")
1689:                                 USE IN cursor_4c_BuscaSGrp
1690:                             ENDIF
1691:                         ENDIF
1692:                         loc_oForm.Release()
1693:                     ENDIF
1694:                 ENDIF
1695:             ENDIF
1696:         CATCH TO loc_oErro

*-- Linhas 1706 a 1747:
1706:         loc_lResultado = .T.
1707:         TRY
1708:             IF USED("crFichaTec")
1709:                 SELECT crFichaTec
1710:                 IF !EOF()
1711:                     loc_cValor = ALLTRIM(crFichaTec.cSelecaos)
1712:                     IF !EMPTY(loc_cValor) AND !INLIST(loc_cValor, "S", "N")
1713:                         MsgAviso("Tipos de Sele" + CHR(231) + CHR(227) + "o v" + CHR(225) + ;
1714:                             "lidos: S ou N !", "Aten" + CHR(231) + CHR(227) + "o")
1715:                         REPLACE crFichaTec.cSelecaos WITH " "
1716:                     ENDIF
1717:                 ENDIF
1718:             ENDIF
1719:         CATCH TO loc_oErro
1720:             MsgErro("Erro em ValidCSelecaos:" + CHR(13) + loc_oErro.Message, "Erro")
1721:         ENDTRY
1722:         RETURN loc_lResultado
1723:     ENDPROC
1724: 
1725:     *--------------------------------------------------------------------------
1726:     PROCEDURE ValidCTpDados()
1727:     *--------------------------------------------------------------------------
1728:         LOCAL loc_lResultado, loc_cValor
1729:         loc_lResultado = .T.
1730:         TRY
1731:             IF USED("crFichaTec")
1732:                 SELECT crFichaTec
1733:                 IF !EOF()
1734:                     loc_cValor = ALLTRIM(crFichaTec.cTpDados)
1735:                     IF !EMPTY(loc_cValor) AND !INLIST(loc_cValor, "C", "D", "N")
1736:                         MsgAviso("Tipo de dado inv" + CHR(225) + "lido." + CHR(13) + ;
1737:                             "Usar: C - Caracter, D - Data, N - Num" + CHR(233) + "rico !", ;
1738:                             "Aten" + CHR(231) + CHR(227) + "o")
1739:                         REPLACE crFichaTec.cTpDados WITH " "
1740:                     ENDIF
1741:                 ENDIF
1742:             ENDIF
1743:         CATCH TO loc_oErro
1744:             MsgErro("Erro em ValidCTpDados:" + CHR(13) + loc_oErro.Message, "Erro")
1745:         ENDTRY
1746:         RETURN loc_lResultado
1747:     ENDPROC

*-- Linhas 1813 a 1850:
1813: 
1814:     *--------------------------------------------------------------------------
1815:     * FormParaBO - Consolida dados dos controles bound ao BO/cursor
1816:     *   Os TextBox/OptionGroup/CheckBox estao com ControlSource direto para
1817:     *   crFichaCab/crFichaTec (padrao SCX legado). Este metodo garante que
1818:     *   o registro corrente esteja gravado no cursor antes de operacoes.
1819:     *--------------------------------------------------------------------------
1820:     PROTECTED PROCEDURE FormParaBO()
1821:         LOCAL loc_lResultado
1822:         loc_lResultado = .F.
1823:         TRY
1824:             *-- ControlSource faz binding bidirecional automatico: qualquer
1825:             *-- alteracao na tela ja esta gravada no cursor. Aqui garantimos
1826:             *-- apenas que os cursores estao posicionados corretamente para
1827:             *-- que o BO acesse o registro correto no Salvar/Excluir.
1828:             IF USED("crFichaCab")
1829:                 SELECT crFichaCab
1830:                 IF !EOF() AND !BOF()
1831:                     GO RECNO()
1832:                 ENDIF
1833:             ENDIF
1834:             IF USED("crFichaTec")
1835:                 SELECT crFichaTec
1836:                 IF !EOF() AND !BOF()
1837:                     GO RECNO()
1838:                 ENDIF
1839:             ENDIF
1840:             loc_lResultado = .T.
1841:         CATCH TO loc_oErro
1842:             MsgErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message, "Erro")
1843:         ENDTRY
1844:         RETURN loc_lResultado
1845:     ENDPROC
1846: 
1847:     *--------------------------------------------------------------------------
1848:     * BOParaForm - Atualiza controles da tela com dados dos cursores do BO
1849:     *   Refresh dos containers/grids que exibem crFichaCab e crFichaTec.
1850:     *--------------------------------------------------------------------------

*-- Linhas 1856 a 1874:
1856:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
1857: 
1858:             IF USED("crFichaTec")
1859:                 SELECT crFichaTec
1860:                 GO TOP
1861:                 loc_oPg.grd_4c_Fichas.Refresh()
1862:             ENDIF
1863: 
1864:             *-- Refresh dos OptionGroups bound (nChkDims/nChkTems/nChkPess/nChkImps)
1865:             IF PEMSTATUS(loc_oPg, "opt_4c_NChkDims", 5)
1866:                 loc_oPg.opt_4c_NChkDims.Refresh()
1867:             ENDIF
1868:             IF PEMSTATUS(loc_oPg, "opt_4c_NChkTems", 5)
1869:                 loc_oPg.opt_4c_NChkTems.Refresh()
1870:             ENDIF
1871:             IF PEMSTATUS(loc_oPg, "opt_4c_NChkPess", 5)
1872:                 loc_oPg.opt_4c_NChkPess.Refresh()
1873:             ENDIF
1874:             IF PEMSTATUS(loc_oPg2, "opt_4c_NChkImps", 5)

*-- Linhas 1894 a 1916:
1894:         loc_lResultado = .F.
1895:         TRY
1896:             IF USED("crFichaCab")
1897:                 SELECT crFichaCab
1898:                 ZAP
1899:             ENDIF
1900:             IF USED("crFichaTec")
1901:                 SELECT crFichaTec
1902:                 ZAP
1903:             ENDIF
1904: 
1905:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
1906:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
1907: 
1908:             *-- Fecha painel de copia se estiver aberto
1909:             IF PEMSTATUS(loc_oPg, "cnt_4c_CopiarAcesso", 5)
1910:                 loc_oPg.cnt_4c_CopiarAcesso.Visible = .F.
1911:                 loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyCGrus.Value = ""
1912:                 loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDGrus.Value = ""
1913:                 loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus.Value = ""
1914:                 loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDSGru.Value = ""
1915:             ENDIF
1916: 


### BO (C:\4c\projeto\app\classes\FctBO.prg):
*==============================================================================
* FctBO.prg - Business Object para Cadastro de Ficha Tecnica / Perfis
* Tabela principal: SigCdFtc (linhas de ficha tecnica por CGrus+SGrus)
* Cabecalho do grupo: SigCdGrp (pnTipo=0), SigCdGcr (pnTipo=1), SigCdOpe (pnTipo=2)
*==============================================================================
DEFINE CLASS FctBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Identificacao do grupo selecionado (cabecalho da ficha tecnica)
    *--------------------------------------------------------------------------
    this_cCGrus    = ""   && Codigo do grupo (chave 1)
    this_cDGrus    = ""   && Descricao do grupo
    this_cSGrus    = ""   && Codigo do subgrupo (chave 2)
    this_cDSGru    = ""   && Descricao do subgrupo

    *--------------------------------------------------------------------------
    * Flags do cabecalho (vem de SigCdGrp quando pnTipo=0)
    * nChkDims: Dimensoes Obrigatorias (1=Sim, 2=Nao)
    * nChkPess: Peso Obrigatorio        (1=Sim, 2=Nao)
    * nChkTems: Tempo Instal Obrigatorio (1=Sim, 2=Nao)
    * nChkImps: Impressao (1=Produtos, 2=Ficha Tecnica)
    * nFixFigs: Figuras Fixas (0/1)
    *--------------------------------------------------------------------------
    this_nChkDims  = 1    && Dimensoes Obrigatorias
    this_nChkPess  = 1    && Peso Obrigatorio
    this_nChkTems  = 1    && Tempo de Instalacao Obrigatorio
    this_nChkImps  = 1    && Tipo de impressao
    this_nFixFigs  = 0    && Figuras fixas (checkbox)
    this_mFicTecs  = ""   && Imagem tecnica (memo/binario)

    *--------------------------------------------------------------------------
    * Tipo de formulario
    * 0 = Ficha Tecnica de Produtos (SigCdGrp/SigCdPsg)
    * 1 = Perfil de Contas           (SigCdGcr)
    * 2 = Configuracao de Movimentacao (SigCdOpe)
    *--------------------------------------------------------------------------
    this_nTipo     = 0    && Tipo (0=Produtos, 1=Contas, 2=Movimentacoes)

    *--------------------------------------------------------------------------
    * Controle de cursor principal do grid (SigCdFtc)
    *--------------------------------------------------------------------------
    this_cCursorDados = "crFichaTec"

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()

            IF loc_lResultado
                THIS.this_cTabela     = "SigCdFtc"
                THIS.this_cCampoChave = "cIdChaves"
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao inicializar FctBO:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        LOCAL loc_oErro
        TRY
            IF USED("crDados")
                USE IN crDados
            ENDIF
            IF USED("crFichaCab")
                USE IN crFichaCab
            ENDIF
            IF USED("crFichaTec")
                USE IN crFichaTec
            ENDIF
            IF USED("crSigCdFtc")
                USE IN crSigCdFtc
            ENDIF
            IF USED("crSigCdGrp")
                USE IN crSigCdGrp
            ENDIF
            IF USED("crSigCdGrpFilter")
                USE IN crSigCdGrpFilter
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao destruir FctBO:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        DODEFAULT()
    ENDPROC

    *==========================================================================
    * CriarCursores - Cria os cursores de trabalho necessarios
    *==========================================================================
    PROCEDURE CriarCursores()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("crDados")
                USE IN crDados
            ENDIF
            IF USED("crFichaCab")
                USE IN crFichaCab
            ENDIF
            IF USED("crFichaTec")
                USE IN crFichaTec
            ENDIF
            IF USED("crSigCdFtc")
                USE IN crSigCdFtc
            ENDIF
            IF USED("crSigCdGrp")
                USE IN crSigCdGrp
            ENDIF

            SET NULL ON
            CREATE CURSOR crDados (CGrus C(20), DGrus C(30), SGrus C(6), DSGru C(20), TemDados C(20))
            INDEX ON CGrus + SGrus TAG Col1
            INDEX ON SGrus + CGrus TAG Col2
            INDEX ON DGrus + CGrus TAG Col3
            INDEX ON DSGru + SGrus TAG Col4
            SET ORDER TO Col1 IN crDados

            CREATE CURSOR crFichaCab (CGrus C(20), DGrus C(30), SGrus C(6), DSGru C(20), ;
                nChkDims N(1), nChkPess N(1), nChkTems N(1), nChkImps N(1), ;
                nFixFigs N(1), mFicTecs M NULL)

            CREATE CURSOR crFichaTec (CGrus C(20), SGrus C(6), CCars C(20), CTits C(20), ;
                COrds N(3), CLins N(2), Maxs N(3), Mins N(3), ;
                nChkCxas N(1), cSelecaos C(1), cTpDados C(1))

            CREATE CURSOR crSigCdGrp (CGrus C(20), DGrus C(30), Mercs C(3), ;
                Margems N(9,6), Apagar C(1))
            SET NULL OFF

            loc_lResultado = .T.

        CATCH TO loException
            MsgErro("Erro ao criar cursores:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Buscar - Carrega a lista de grupos/contas/movimentacoes na grade principal
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
    *==========================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF !USED("crDados")
                    SET NULL ON
                    CREATE CURSOR crDados (CGrus C(20), DGrus C(30), SGrus C(6), DSGru C(20), TemDados C(20))
                    SET NULL OFF
                ENDIF
                loc_lResultado = .T.
            ENDIF

            IF USED("crDados")
                ZAP IN crDados
            ELSE
                THIS.CriarCursores()
            ENDIF

            DO CASE
            CASE THIS.this_nTipo = 0
                loc_cSQL = "SELECT CGrus, DGrus, FTecSubs" + ;
                    " FROM SigCdGrp" + ;
                    " ORDER BY CGrus, DGrus"

            CASE THIS.this_nTipo = 1
                loc_cSQL = "SELECT Codigos, Descrs, 0 AS FTecSubs" + ;
                    " FROM SigCdGcr WHERE FichaTecs = 1" + ;
                    " ORDER BY Codigos, Descrs"

            CASE THIS.this_nTipo = 2
                loc_cSQL = "SELECT a.Dopes, a.TitOpes, 0 AS FTecSubs" + ;
                    " FROM SigCdOpe a" + ;
                    " LEFT JOIN SigOpCdc b ON a.Dopes = b.Dopes" + ;
                    " WHERE b.OpeInatvs IN (0,2)" + ;
                    " ORDER BY a.Dopes, a.TitOpes"
            ENDCASE

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crLocalGru")
            IF loc_nResult < 1
                MsgErro("Erro ao carregar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                SELECT crLocalGru
                SCAN
                    LOCAL loc_cGrupo, loc_cDescGrupo, loc_nFTecSubs
                    loc_cGrupo    = ALLTRIM(crLocalGru.CGrus)
                    loc_cDescGrupo = ""
                    loc_nFTecSubs  = 0

                    DO CASE
                    CASE THIS.this_nTipo = 0
                        loc_cDescGrupo = ALLTRIM(crLocalGru.DGrus)
                        loc_nFTecSubs  = NVL(crLocalGru.FTecSubs, 0)
                    CASE THIS.this_nTipo = 1
                        loc_cGrupo     = ALLTRIM(crLocalGru.Codigos)
                        loc_cDescGrupo = ALLTRIM(crLocalGru.Descrs)
                    CASE THIS.this_nTipo = 2
                        loc_cGrupo     = ALLTRIM(crLocalGru.Dopes)
                        loc_cDescGrupo = ALLTRIM(crLocalGru.TitOpes)
                    ENDCASE

                    INSERT INTO crDados (CGrus, DGrus, SGrus, DSGru, TemDados) ;
                        VALUES (loc_cGrupo, loc_cDescGrupo, "", "", "")

                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT DISTINCT CGrus FROM SigCdFtc" + ;
                        " WHERE CGrus = " + EscaparSQL(loc_cGrupo) + ;
                        " AND SGrus = SPACE(6) AND nTipos = " + ;
                        FormatarNumeroSQL(THIS.this_nTipo), "crTmpFtc")
                    IF loc_nResult >= 1
                        GO TOP IN crTmpFtc
                        IF !EOF("crTmpFtc")
                            SELECT crDados
                            GO BOTTOM IN crDados
                            REPLACE TemDados WITH loc_cGrupo IN crDados
                        ENDIF
                        IF USED("crTmpFtc")
                            USE IN crTmpFtc
                        ENDIF
                    ENDIF

                    IF THIS.this_nTipo = 0 AND loc_nFTecSubs = 1
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT CGrus, Codigos, Descricaos FROM SigCdPsg" + ;
                            " WHERE CGrus = " + EscaparSQL(loc_cGrupo) + ;
                            " ORDER BY CGrus, Codigos, Descricaos", "crLocalSGru")
                        IF loc_nResult >= 1
                            SELECT crLocalSGru
                            SCAN
                                INSERT INTO crDados (CGrus, DGrus, SGrus, DSGru, TemDados) ;
                                    VALUES (loc_cGrupo, loc_cDescGrupo, ;
                                        ALLTRIM(crLocalSGru.Codigos), ;
                                        ALLTRIM(crLocalSGru.Descricaos), "")

                                loc_nResult = SQLEXEC(gnConnHandle, ;
                                    "SELECT DISTINCT CGrus, SGrus FROM SigCdFtc" + ;
                                    " WHERE CGrus = " + EscaparSQL(loc_cGrupo) + ;
                                    " AND SGrus = " + EscaparSQL(ALLTRIM(crLocalSGru.Codigos)) + ;
                                    " AND nTipos = 0", "crTmpSGru")
                                IF loc_nResult >= 1
                                    GO TOP IN crTmpSGru
                                    IF !EOF("crTmpSGru")
                                        SELECT crDados
                                        GO BOTTOM IN crDados
                                        REPLACE TemDados WITH ;
                                            loc_cGrupo + ALLTRIM(crLocalSGru.Codigos) IN crDados
                                    ENDIF
                                    IF USED("crTmpSGru")
                                        USE IN crTmpSGru
                                    ENDIF
                                ENDIF
                            ENDSCAN
                            IF USED("crLocalSGru")
                                USE IN crLocalSGru
                            ENDIF
                        ENDIF
                    ENDIF

                    SELECT crLocalGru
                ENDSCAN

                IF USED("crLocalGru")
                    USE IN crLocalGru
                ENDIF

                GO TOP IN crDados
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao buscar grupos:" + CHR(13) + loException.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarFicha - Carrega crFichaCab e crFichaTec para um grupo/subgrupo
    * par_cCGrus  - Codigo do grupo
    * par_cSGrus  - Codigo do subgrupo (vazio para grupo raiz)
    * par_cDGrus  - Descricao do grupo
    * par_cDSGru  - Descricao do subgrupo
    * par_cModo   - "ALTERAR" / "VISUALIZAR" / "EXCLUIR"
    *==========================================================================
    FUNCTION CarregarFicha(par_cCGrus, par_cSGrus, par_cDGrus, par_cDSGru, par_cModo)
    *==========================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_nOrd
        loc_lResultado = .F.

        TRY
            IF USED("crFichaCab")
                ZAP IN crFichaCab
            ENDIF
            IF USED("crFichaTec")
                ZAP IN crFichaTec
            ENDIF

            THIS.this_cCGrus = ALLTRIM(par_cCGrus)
            THIS.this_cSGrus = ALLTRIM(par_cSGrus)
            THIS.this_cDGrus = ALLTRIM(par_cDGrus)
            THIS.this_cDSGru = ALLTRIM(par_cDSGru)

            DO CASE
            CASE THIS.this_nTipo = 0
                loc_cSQL = "SELECT a.CGrus, a.nChkDims, a.nChkPess, a.nChkTems," + ;
                    " a.nChkImps, a.nFixFigs, a.mFicTecs" + ;
                    " FROM SigCdGrp a" + ;
                    " WHERE a.CGrus = " + EscaparSQL(THIS.this_cCGrus)

            CASE THIS.this_nTipo = 1
                loc_cSQL = "SELECT a.Codigos AS CGrus, 2 AS nChkDims, 2 AS nChkPess," + ;
                    " 2 AS nChkTems, 2 AS nChkImps, 2 AS nFixFigs, '' AS mFicTecs" + ;
                    " FROM SigCdGcr a" + ;
                    " WHERE a.Codigos = " + EscaparSQL(THIS.this_cCGrus)

            CASE THIS.this_nTipo = 2
                loc_cSQL = "SELECT a.Dopes AS CGrus, 2 AS nChkDims, 2 AS nChkPess," + ;
                    " 2 AS nChkTems, 2 AS nChkImps, 2 AS nFixFigs, '' AS mFicTecs" + ;
                    " FROM SigCdOpe a" + ;
                    " WHERE a.Dopes = " + EscaparSQL(THIS.this_cCGrus)
            ENDCASE

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crLocalGruFicha")
            IF loc_nResult < 1
                MsgErro("Erro ao acessar cadastro de grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                GO TOP IN crLocalGruFicha
                IF EOF("crLocalGruFicha")
                    MsgAviso("O grupo " + CHR(34) + THIS.this_cCGrus + CHR(34) + ;
                        " n" + CHR(227) + "o foi encontrado!" + CHR(13) + ;
                        "O grupo pode ter sido exclu" + CHR(237) + "do. Reinicie a opera" + ;
                        CHR(231) + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    INSERT INTO crFichaCab (CGrus, DGrus, SGrus, DSGru, nChkDims, ;
                        nChkPess, nChkTems, nChkImps, nFixFigs, mFicTecs) ;
                        VALUES (THIS.this_cCGrus, THIS.this_cDGrus, THIS.this_cSGrus, ;
                        THIS.this_cDSGru, NVL(crLocalGruFicha.nChkDims, 1), ;
                        NVL(crLocalGruFicha.nChkPess, 1), ;
                        NVL(crLocalGruFicha.nChkTems, 1), ;
                        NVL(crLocalGruFicha.nChkImps, 1), ;
                        NVL(crLocalGruFicha.nFixFigs, 0), ;
                        NVL(crLocalGruFicha.mFicTecs, ""))

                    THIS.this_nChkDims = NVL(crLocalGruFicha.nChkDims, 1)
                    THIS.this_nChkPess = NVL(crLocalGruFicha.nChkPess, 1)
                    THIS.this_nChkTems = NVL(crLocalGruFicha.nChkTems, 1)
                    THIS.this_nChkImps = NVL(crLocalGruFicha.nChkImps, 1)
                    THIS.this_nFixFigs = NVL(crLocalGruFicha.nFixFigs, 0)
                    THIS.this_mFicTecs = NVL(crLocalGruFicha.mFicTecs, "")

                    loc_cSQL = "SELECT a.*" + ;
                        " FROM SigCdFtc a" + ;
                        " WHERE a.CGrus = " + EscaparSQL(THIS.this_cCGrus) + ;
                        " AND a.SGrus = " + EscaparSQL(THIS.this_cSGrus) + ;
                        " ORDER BY a.COrds"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crLocalCFTec")
                    IF loc_nResult < 1
                        MsgErro("Erro ao carregar ficha t" + CHR(233) + "cnica:" + ;
                            CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ELSE
                        loc_nOrd = 1
                        SELECT crLocalCFTec
                        SCAN
                            INSERT INTO crFichaTec (COrds, CGrus, SGrus, CCars, CTits, ;
                                CLins, Maxs, Mins, nChkCxas, cSelecaos, cTpDados) ;
                                VALUES (loc_nOrd, THIS.this_cCGrus, THIS.this_cSGrus, ;
                                NVL(crLocalCFTec.CCars, ""), NVL(crLocalCFTec.CTits, ""), ;
                                NVL(crLocalCFTec.CLins, 0), NVL(crLocalCFTec.Maxs, 0), ;
                                NVL(crLocalCFTec.Mins, 0), NVL(crLocalCFTec.nChkCxas, 0), ;
                                NVL(crLocalCFTec.cSelecaos, " "), ;
                                NVL(crLocalCFTec.cTpDados, " "))
                            loc_nOrd = loc_nOrd + 1
                        ENDSCAN

                        IF USED("crLocalCFTec")
                            USE IN crLocalCFTec
                        ENDIF

                        IF ALLTRIM(par_cModo) == "ALTERAR"
                            INSERT INTO crFichaTec (COrds, CGrus, SGrus) ;
                                VALUES (loc_nOrd, THIS.this_cCGrus, THIS.this_cSGrus)
                        ENDIF

                        GO TOP IN crFichaCab
                        GO TOP IN crFichaTec
                        GO BOTTOM IN crFichaTec

                        loc_lResultado = .T.
                    ENDIF
                ENDIF

                IF USED("crLocalGruFicha")
                    USE IN crLocalGruFicha
                ENDIF
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao carregar ficha:" + CHR(13) + loException.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarFiltroGrupos - Carrega crSigCdGrpFilter para lookup no container de copia
    *==========================================================================
    FUNCTION CarregarFiltroGrupos()
    *==========================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("crSigCdGrpFilter")
                USE IN crSigCdGrpFilter
            ENDIF

            DO CASE
            CASE THIS.this_nTipo = 0
                loc_cSQL = "SELECT CGrus, DGrus, Mercs, Margems, 'S' AS Apagar" + ;
                    " FROM SigCdGrp"

            CASE THIS.this_nTipo = 1
                loc_cSQL = "SELECT Codigos AS CGrus, Descrs AS DGrus," + ;
                    " '   ' AS Mercs, 0 AS Margems, 'S' AS Apagar FROM SigCdGcr"

            CASE THIS.this_nTipo = 2
                loc_cSQL = "SELECT Dopes AS CGrus, TitOpes AS DGrus," + ;
                    " '   ' AS Mercs, 0 AS Margems, 'S' AS Apagar FROM SigCdOpe"
            ENDCASE

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdGrpFilter")
            IF loc_nResult < 1
                MsgErro("Erro ao carregar filtro de grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                SELECT crSigCdGrpFilter
                IF RECCOUNT("crSigCdGrpFilter") > 0
                    INDEX ON CGrus TAG CGrus
                    INDEX ON DGrus TAG DGrus
                ENDIF
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao carregar filtro de grupos:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AdicionarLinhaFicha - Adiciona linha em branco no final do crFichaTec
    *==========================================================================
    FUNCTION AdicionarLinhaFicha()
    *==========================================================================
        LOCAL loc_lResultado, loc_nProxOrd
        loc_lResultado = .F.

        TRY
            IF !USED("crFichaTec") OR !USED("crFichaCab")
                loc_lResultado = .F.
            ENDIF

            loc_nProxOrd = RECCOUNT("crFichaTec") + 1

            SELECT crFichaTec
            GO BOTTOM IN crFichaTec
            IF !EOF("crFichaTec")
                loc_nProxOrd = NVL(crFichaTec.COrds, 0) + 1
            ENDIF

            INSERT INTO crFichaTec (COrds, CGrus, SGrus) ;
                VALUES (loc_nProxOrd, THIS.this_cCGrus, THIS.this_cSGrus)

            GO BOTTOM IN crFichaTec
            loc_lResultado = .T.

        CATCH TO loException
            MsgErro("Erro ao adicionar linha:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarFichaTec - Valida o conteudo da grade antes de gravar
    *==========================================================================
    FUNCTION ValidarFichaTec()
    *==========================================================================
        LOCAL loc_lResultado, loc_cMensagem
        loc_lResultado = .F.

        TRY
            IF !USED("crFichaTec")
                MsgErro("Cursor de ficha t" + CHR(233) + "cnica n" + CHR(227) + ;
                    "o encontrado!", "Erro")
                loc_lResultado = .F.
            ENDIF

            IF USED("crSigCdFtc")
                ZAP IN crSigCdFtc
            ELSE
                SET NULL ON
                CREATE CURSOR crSigCdFtc (COrds N(3), CGrus C(20), SGrus C(6), ;
                    CCars C(20), CTits C(20), CLins N(2), Maxs N(3), Mins N(3), ;
                    nChkCxas N(1), cSelecaos C(1), cIdChaves C(50), ;
                    nTipos N(1), cTpDados C(1))
                SET NULL OFF
            ENDIF

            SELECT crFichaTec
            SCAN
                IF !EMPTY(ALLTRIM(crFichaTec.CCars)) AND ;
                   !EMPTY(ALLTRIM(crFichaTec.CTits)) AND ;
                   crFichaTec.CLins >= 1
                    INSERT INTO crSigCdFtc (COrds, CGrus, SGrus, CCars, CTits, ;
                        CLins, Maxs, Mins, nChkCxas, cSelecaos, cIdChaves, ;
                        nTipos, cTpDados) ;
                        VALUES (crFichaTec.COrds, crFichaTec.CGrus, crFichaTec.SGrus, ;
                        crFichaTec.CCars, crFichaTec.CTits, crFichaTec.CLins, ;
                        crFichaTec.Maxs, crFichaTec.Mins, crFichaTec.nChkCxas, ;
                        NVL(crFichaTec.cSelecaos, " "), ;
                        LEFT(SYS(2015) + SYS(2015) + PADL(TRANSFORM(crFichaTec.COrds),5,"0"), 50), ;
                        THIS.this_nTipo, ;
                        NVL(crFichaTec.cTpDados, " "))
                ENDIF
            ENDSCAN

            IF RECCOUNT("crSigCdFtc") < 1
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + ;
                    " nenhum registro v" + CHR(225) + "lido na grade de ficha t" + ;
                    CHR(233) + "cnica!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF

            SELECT CCars, CTits, SUM(1) AS Totas ;
                FROM crSigCdFtc ;
                GROUP BY CCars, CTits ;
                INTO CURSOR csItensCheck

            SELECT csItensCheck
            SCAN
                IF csItensCheck.Totas > 1
                    MsgAviso("O Grupo e o T" + CHR(237) + "tulo " + CHR(34) + ;
                        ALLTRIM(csItensCheck.CCars) + " / " + ;
                        ALLTRIM(csItensCheck.CTits) + CHR(34) + ;
                        " est" + CHR(225) + " duplicado!", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    IF USED("csItensCheck")
                        USE IN csItensCheck
                    ENDIF
                    loc_lResultado = .F.
                ENDIF
            ENDSCAN
            IF USED("csItensCheck")
                USE IN csItensCheck
            ENDIF

            SELECT COrds, SUM(1) AS Totas ;
                FROM crSigCdFtc ;
                GROUP BY COrds ;
                INTO CURSOR csOrdsCheck

            SELECT csOrdsCheck
            SCAN
                IF csOrdsCheck.Totas > 1
                    MsgAviso("A ordem de apresenta" + CHR(231) + CHR(227) + "o " + ;
                        CHR(34) + ALLTRIM(STR(csOrdsCheck.COrds)) + CHR(34) + ;
                        " est" + CHR(225) + " duplicada!", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    IF USED("csOrdsCheck")
                        USE IN csOrdsCheck
                    ENDIF
                    loc_lResultado = .F.
                ENDIF
            ENDSCAN
            IF USED("csOrdsCheck")
                USE IN csOrdsCheck
            ENDIF

            loc_lResultado = .T.

        CATCH TO loException
            MsgErro("Erro ao validar ficha:" + CHR(13) + loException.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * VerificarExcluirFicha - Verifica se e possivel excluir a ficha tecnica
    *==========================================================================
    FUNCTION VerificarExcluirFicha()
    *==========================================================================
        LOCAL loc_lResultado, loc_nResult, loc_cSQL
        loc_lResultado = .T.

        TRY
            IF !USED("crSigCdFtc") OR RECCOUNT("crSigCdFtc") < 1
                loc_lResultado = .T.
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT * FROM SigCdFtc" + ;
                " WHERE CGrus = " + EscaparSQL(THIS.this_cCGrus) + ;
                " AND SGrus = " + EscaparSQL(THIS.this_cSGrus), "crVerFtc")

            IF loc_nResult >= 1
                SELECT crVerFtc
                SCAN
                    LOCAL loc_cCCars, loc_cCTits, loc_cMsgProd
                    loc_cCCars = ALLTRIM(crVerFtc.CCars)
                    loc_cCTits = ALLTRIM(crVerFtc.CTits)

                    IF !EMPTY(loc_cCCars) AND !EMPTY(loc_cCTits)
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT DISTINCT a.CPros FROM SigCdPft a, SigCdPro b" + ;
                            " WHERE a.CCars = " + EscaparSQL(loc_cCCars) + ;
                            " AND a.CTits = " + EscaparSQL(loc_cCTits) + ;
                            " AND a.CPros = b.CPros" + ;
                            " AND b.CGrus = " + EscaparSQL(THIS.this_cCGrus) + ;
                            " AND b.SGrus = " + EscaparSQL(THIS.this_cSGrus) + ;
                            " ORDER BY a.CPros", "crVerProd")
                        IF loc_nResult >= 1 AND RECCOUNT("crVerProd") > 0
                            GO TOP IN crVerProd
                            IF RECCOUNT("crVerProd") = 1
                                loc_cMsgProd = "O produto " + CHR(34) + ;
                                    ALLTRIM(crVerProd.CPros) + CHR(34) + " est" + CHR(225) + " "
                            ELSE
                                loc_cMsgProd = "Existem produtos que est" + CHR(227) + "o "
                            ENDIF
                            loc_cMsgProd = loc_cMsgProd + "utilizando o" + CHR(13) + ;
                                "Grupo de Caracter" + CHR(237) + "sticas: " + loc_cCCars + ;
                                " e o T" + CHR(237) + "tulo: " + loc_cCTits + "."
                            MsgErro(loc_cMsgProd, "Imposs" + CHR(237) + "vel Excluir")
                            IF USED("crVerProd")
                                USE IN crVerProd
                            ENDIF
                            loc_lResultado = .F.
                        ENDIF
                        IF USED("crVerProd")
                            USE IN crVerProd
                        ENDIF

                        IF loc_lResultado
                            loc_nResult = SQLEXEC(gnConnHandle, ;
                                "SELECT DISTINCT GruCarTits FROM SigCdFtr" + ;
                                " WHERE GruCarTits = " + ;
                                EscaparSQL(THIS.this_cCGrus + THIS.this_cSGrus + loc_cCCars + loc_cCTits), ;
                                "crVerResp")
                            IF loc_nResult >= 1 AND RECCOUNT("crVerResp") > 0
                                MsgErro("A Caracter" + CHR(237) + "stica " + CHR(34) + ;
                                    loc_cCCars + CHR(34) + " com o T" + CHR(237) + ;
                                    "tulo " + CHR(34) + loc_cCTits + CHR(34) + CHR(13) + ;
                                    "possui respostas cadastradas! Exclua as respostas primeiro!", ;
                                    "Imposs" + CHR(237) + "vel Excluir")
                                IF USED("crVerResp")
                                    USE IN crVerResp
                                ENDIF
                                loc_lResultado = .F.
                            ENDIF
                            IF USED("crVerResp")
                                USE IN crVerResp
                            ENDIF
                        ENDIF
                    ENDIF

                    IF !loc_lResultado
                        GO BOTTOM IN crVerFtc
                    ENDIF
                ENDSCAN
                IF USED("crVerFtc")
                    USE IN crVerFtc
                ENDIF
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao verificar depend" + CHR(234) + "ncias:" + CHR(13) + ;
                loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AtualizarGrupoFicha - Atualiza flags do grupo e salva ficha tecnica
    * par_cModo - "ALTERAR" ou "EXCLUIR"
    *==========================================================================
    FUNCTION AtualizarGrupoFicha(par_cModo)
    *==========================================================================
        LOCAL loc_lResultado, loc_nResult, loc_cSQL
        loc_lResultado = .F.

        IF !INLIST(ALLTRIM(par_cModo), "ALTERAR", "EXCLUIR")
            MsgErro("Modo inv" + CHR(225) + "lido: " + ALLTRIM(par_cModo), "Erro")
            RETURN .F.
        ENDIF

        TRY
            IF ALLTRIM(par_cModo) == "ALTERAR"
                loc_lResultado = THIS.Atualizar()
            ELSE
                loc_lResultado = THIS.ExecutarExclusao()
            ENDIF

            IF loc_lResultado
                IF USED("crDados")
                    SELECT crDados
                    IF ALLTRIM(par_cModo) == "ALTERAR"
                        REPLACE TemDados WITH THIS.this_cCGrus + THIS.this_cSGrus IN crDados
                    ELSE
                        REPLACE TemDados WITH "" IN crDados
                    ENDIF
                ENDIF
                THIS.RegistrarAuditoria(par_cModo)
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao atualizar ficha:" + CHR(13) + loException.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
    *==========================================================================
        RETURN ALLTRIM(THIS.this_cCGrus) + "/" + ALLTRIM(THIS.this_cSGrus)
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCGrus   = ALLTRIM(TratarNulo(CGrus, "C"))
                THIS.this_cDGrus   = ALLTRIM(TratarNulo(DGrus, "C"))
                THIS.this_cSGrus   = ALLTRIM(TratarNulo(SGrus, "C"))
                THIS.this_cDSGru   = ALLTRIM(TratarNulo(DSGru, "C"))
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Inserir()
    *==========================================================================
        RETURN .T.
    ENDPROC

    *==========================================================================
    * Atualizar - Salva a ficha tecnica no banco:
    *   1. DELETE registros antigos de SigCdFtc
    *   2. Se pnTipo=0: UPDATE flags em SigCdGrp
    *   3. INSERT novos registros de crSigCdFtc em SigCdFtc
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
    *==========================================================================
        LOCAL loc_lResultado, loc_nResult, loc_cSQL
        loc_lResultado = .F.

        TRY
            IF THIS.this_nTipo = 0
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigCdGrp WHERE CGrus = " + ;
                    EscaparSQL(THIS.this_cCGrus), "crLocalGruUpd")
                IF loc_nResult < 1 OR EOF("crLocalGruUpd")
                    MsgErro("O grupo " + CHR(34) + THIS.this_cCGrus + CHR(34) + ;
                        " foi exclu" + CHR(237) + "do durante o processo. Reinicie!", "Erro")
                    IF USED("crLocalGruUpd")
                        USE IN crLocalGruUpd
                    ENDIF
                    loc_lResultado = .F.
                ENDIF
                IF USED("crLocalGruUpd")
                    USE IN crLocalGruUpd
                ENDIF

                IF !USED("crFichaCab")
                    MsgErro("Cursor de cabe" + CHR(231) + "alho n" + CHR(227) + "o encontrado!", "Erro")
                    loc_lResultado = .F.
                ENDIF

                GO TOP IN crFichaCab
                loc_cSQL = "UPDATE SigCdGrp SET" + ;
                    " nChkDims = " + FormatarNumeroSQL(crFichaCab.nChkDims) + "," + ;
                    " nChkPess = " + FormatarNumeroSQL(crFichaCab.nChkPess) + "," + ;
                    " nChkTems = " + FormatarNumeroSQL(crFichaCab.nChkTems) + "," + ;
                    " nChkImps = " + FormatarNumeroSQL(crFichaCab.nChkImps) + "," + ;
                    " nFixFigs = " + FormatarNumeroSQL(crFichaCab.nFixFigs) + "," + ;
                    " mFicTecs = " + IIF(EMPTY(crFichaCab.mFicTecs), "NULL", ;
                        EscaparSQL(crFichaCab.mFicTecs)) + ;
                    " WHERE CGrus = " + EscaparSQL(THIS.this_cCGrus)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult < 1
                    MsgErro("Erro ao atualizar grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdFtc" + ;
                " WHERE CGrus = " + EscaparSQL(THIS.this_cCGrus) + ;
                " AND SGrus = " + EscaparSQL(THIS.this_cSGrus))
            IF loc_nResult < 1
                MsgErro("Erro ao excluir ficha anterior:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ENDIF

            IF USED("crSigCdFtc") AND RECCOUNT("crSigCdFtc") > 0
                SELECT crSigCdFtc
                SCAN
                    loc_cSQL = "INSERT INTO SigCdFtc" + ;
                        " (COrds, CGrus, SGrus, CCars, CTits, CLins, Maxs, Mins," + ;
                        " nChkCxas, cSelecaos, cIdChaves, nTipos, cTpDados) VALUES (" + ;
                        FormatarNumeroSQL(crSigCdFtc.COrds) + ", " + ;
                        EscaparSQL(crSigCdFtc.CGrus) + ", " + ;
                        EscaparSQL(crSigCdFtc.SGrus) + ", " + ;
                        EscaparSQL(crSigCdFtc.CCars) + ", " + ;
                        EscaparSQL(crSigCdFtc.CTits) + ", " + ;
                        FormatarNumeroSQL(crSigCdFtc.CLins) + ", " + ;
                        FormatarNumeroSQL(crSigCdFtc.Maxs) + ", " + ;
                        FormatarNumeroSQL(crSigCdFtc.Mins) + ", " + ;
                        FormatarNumeroSQL(crSigCdFtc.nChkCxas) + ", " + ;
                        EscaparSQL(NVL(crSigCdFtc.cSelecaos, " ")) + ", " + ;
                        "CONVERT(VARCHAR(50), NEWID()), " + ;
                        FormatarNumeroSQL(crSigCdFtc.nTipos) + ", " + ;
                        EscaparSQL(NVL(crSigCdFtc.cTpDados, " ")) + ")"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResult < 1
                        MsgErro("Erro ao inserir linha da ficha:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                        loc_lResultado = .F.
                    ENDIF
                ENDSCAN
            ENDIF

            loc_lResultado = .T.

        CATCH TO loException
            MsgErro("Erro ao salvar ficha t" + CHR(233) + "cnica:" + CHR(13) + ;
                loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
    *==========================================================================
        LOCAL loc_lResultado, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdFtc" + ;
                " WHERE CGrus = " + EscaparSQL(THIS.this_cCGrus) + ;
                " AND SGrus = " + EscaparSQL(THIS.this_cSGrus))
            IF loc_nResult < 1
                MsgErro("Erro ao excluir ficha t" + CHR(233) + "cnica:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao excluir ficha:" + CHR(13) + loException.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

