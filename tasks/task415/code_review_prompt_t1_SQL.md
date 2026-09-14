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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFct.prg) - TRECHOS RELEVANTES PARA PASS SQL (1973 linhas total):

*-- Linhas 347 a 405:
347:                 .ReadOnly     = .T.
348:                 .GridLines    = 1
349:                 .HeaderHeight = 18
350:                 .DeleteMark   = .F.
351:                 .RecordMark   = .F.
352:                 .Visible      = .T.
353:                 WITH .Column1
354:                     .ControlSource = "crDados.CGrus"
355:                     DO CASE
356:                     CASE THIS.this_nTipo = 1
357:                         .Width           = 100
358:                         .Header1.Caption = "Conta"
359:                     CASE THIS.this_nTipo = 2
360:                         .Width           = 100
361:                         .Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
362:                     OTHERWISE
363:                         .Width           = 80
364:                         .Header1.Caption = "Grupo"
365:                     ENDCASE
366:                     .ReadOnly = .T.
367:                 ENDWITH
368:                 WITH .Column2
369:                     .ControlSource   = "crDados.SGrus"
370:                     .Width           = IIF(THIS.this_nTipo = 0, 100, 0)
371:                     .Header1.Caption = "Sub-grupo"
372:                     .ReadOnly        = .T.
373:                 ENDWITH
374:                 WITH .Column3
375:                     .ControlSource = "crDados.DGrus"
376:                     DO CASE
377:                     CASE THIS.this_nTipo = 1
378:                         .Width           = 641
379:                         .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
380:                     CASE THIS.this_nTipo = 2
381:                         .Width           = 641
382:                         .Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
383:                     OTHERWISE
384:                         .Width           = 403
385:                         .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Grupo"
386:                     ENDCASE
387:                     .ReadOnly = .T.
388:                 ENDWITH
389:                 WITH .Column4
390:                     .ControlSource   = "crDados.DSGru"
391:                     .Width           = IIF(THIS.this_nTipo = 0, 358, 0)
392:                     .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o Sub-grupo"
393:                     .ReadOnly        = .T.
394:                 ENDWITH
395:             ENDWITH
396:             loc_oPag.grd_4c_Lista.SetAll("DynamicBackColor", ;
397:                 "IIF(EMPTY(crDados.TemDados), RGB(255,255,255), RGB(255,255,187))", "Column")
398: 
399:             BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
400:             BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
401:             BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
402:             BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
403:             BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
404:             BINDEVENT(loc_oPag.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
405:             BINDEVENT(loc_oPag.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")

*-- Linhas 527 a 612:
527:                 .Width         = 80
528:                 .Height        = 20
529:                 .Enabled       = .F.
530:                 .ControlSource = "crFichaCab.CGrus"
531:                 .Visible       = .T.
532:             ENDWITH
533: 
534:             loc_oPg.AddObject("txt_4c_DGrus", "TextBox")
535:             WITH loc_oPg.txt_4c_DGrus
536:                 .Top           = 17
537:                 .Left          = 180
538:                 .Width         = 290
539:                 .Height        = 20
540:                 .Enabled       = .F.
541:                 .ControlSource = "crFichaCab.DGrus"
542:                 .Visible       = .T.
543:             ENDWITH
544: 
545:             loc_oPg.AddObject("lbl_4c_LabelSGrus", "Label")
546:             WITH loc_oPg.lbl_4c_LabelSGrus
547:                 .Top      = 45
548:                 .Left     = 25
549:                 .Width    = 70
550:                 .Height   = 18
551:                 .AutoSize = .F.
552:                 .Caption  = "Sub-grupo :"
553:                 .Visible  = (THIS.this_nTipo = 0)
554:             ENDWITH
555: 
556:             loc_oPg.AddObject("txt_4c_SGrus", "TextBox")
557:             WITH loc_oPg.txt_4c_SGrus
558:                 .Top           = 42
559:                 .Left          = 98
560:                 .Width         = 80
561:                 .Height        = 20
562:                 .Enabled       = .F.
563:                 .ControlSource = "crFichaCab.SGrus"
564:                 .Visible       = (THIS.this_nTipo = 0)
565:             ENDWITH
566: 
567:             loc_oPg.AddObject("txt_4c_DSGru", "TextBox")
568:             WITH loc_oPg.txt_4c_DSGru
569:                 .Top           = 42
570:                 .Left          = 180
571:                 .Width         = 290
572:                 .Height        = 20
573:                 .Enabled       = .F.
574:                 .ControlSource = "crFichaCab.DSGru"
575:                 .Visible       = (THIS.this_nTipo = 0)
576:             ENDWITH
577: 
578:             loc_oPg.AddObject("lbl_4c_LabelChkDims", "Label")
579:             WITH loc_oPg.lbl_4c_LabelChkDims
580:                 .Top      = 10
581:                 .Left     = 620
582:                 .Width    = 105
583:                 .Height   = 18
584:                 .AutoSize = .F.
585:                 .Caption  = "Dimens" + CHR(245) + "es :"
586:                 .Visible  = (THIS.this_nTipo = 0)
587:             ENDWITH
588: 
589:             loc_oPg.AddObject("opt_4c_NChkDims", "OptionGroup")
590:             WITH loc_oPg.opt_4c_NChkDims
591:                 .Top           = 10
592:                 .Left          = 729
593:                 .Width         = 180
594:                 .Height        = 16
595:                 .ButtonCount   = 2
596:                 .Value         = 1
597:                 .ControlSource = "crFichaCab.nChkDims"
598:                 .Visible       = (THIS.this_nTipo = 0)
599:                 WITH .Buttons(1)
600:                     .Caption   = "Sim"
601:                     .Width     = 50
602:                     .BackStyle = 0
603:                 ENDWITH
604:                 WITH .Buttons(2)
605:                     .Caption   = "N" + CHR(227) + "o"
606:                     .Left      = 55
607:                     .Width     = 60
608:                     .BackStyle = 0
609:                 ENDWITH
610:             ENDWITH
611: 
612:             loc_oPg.AddObject("lbl_4c_LabelChkTems", "Label")

*-- Linhas 628 a 646:
628:                 .Height        = 16
629:                 .ButtonCount   = 2
630:                 .Value         = 1
631:                 .ControlSource = "crFichaCab.nChkTems"
632:                 .Visible       = (THIS.this_nTipo = 0)
633:                 WITH .Buttons(1)
634:                     .Caption   = "Sim"
635:                     .Width     = 50
636:                     .BackStyle = 0
637:                 ENDWITH
638:                 WITH .Buttons(2)
639:                     .Caption   = "N" + CHR(227) + "o"
640:                     .Left      = 55
641:                     .Width     = 60
642:                     .BackStyle = 0
643:                 ENDWITH
644:             ENDWITH
645: 
646:             loc_oPg.AddObject("lbl_4c_LabelChkPess", "Label")

*-- Linhas 662 a 680:
662:                 .Height        = 16
663:                 .ButtonCount   = 2
664:                 .Value         = 1
665:                 .ControlSource = "crFichaCab.nChkPess"
666:                 .Visible       = (THIS.this_nTipo = 0)
667:                 WITH .Buttons(1)
668:                     .Caption   = "Sim"
669:                     .Width     = 50
670:                     .BackStyle = 0
671:                 ENDWITH
672:                 WITH .Buttons(2)
673:                     .Caption   = "N" + CHR(227) + "o"
674:                     .Left      = 55
675:                     .Width     = 60
676:                     .BackStyle = 0
677:                 ENDWITH
678:             ENDWITH
679: 
680:             loc_oPg.AddObject("grd_4c_Fichas", "Grid")

*-- Linhas 688 a 743:
688:                 .RecordSource = "crFichaTec"
689:                 .ReadOnly     = .F.
690:                 .GridLines    = 1
691:                 .DeleteMark   = .F.
692:                 .RecordMark   = .F.
693:                 .Visible      = .T.
694:                 WITH .Column1
695:                     .Width           = 200
696:                     .ControlSource   = "crFichaTec.CCars"
697:                     .Header1.Caption = "Caracter" + CHR(237) + "stica"
698:                 ENDWITH
699:                 WITH .Column2
700:                     .Width           = 200
701:                     .ControlSource   = "crFichaTec.CTits"
702:                     .Header1.Caption = "T" + CHR(237) + "tulo"
703:                 ENDWITH
704:                 WITH .Column3
705:                     .Width           = 50
706:                     .ControlSource   = "crFichaTec.COrds"
707:                     .Header1.Caption = "Ordem"
708:                     .Text1.InputMask = "999"
709:                 ENDWITH
710:                 WITH .Column4
711:                     .Width           = 50
712:                     .ControlSource   = "crFichaTec.CLins"
713:                     .Header1.Caption = "Linhas"
714:                     .Text1.InputMask = "99"
715:                 ENDWITH
716:                 WITH .Column5
717:                     .Width           = 50
718:                     .ControlSource   = "crFichaTec.Maxs"
719:                     .Header1.Caption = "Max"
720:                 ENDWITH
721:                 WITH .Column6
722:                     .Width           = 50
723:                     .ControlSource   = "crFichaTec.Mins"
724:                     .Header1.Caption = "Min"
725:                 ENDWITH
726:                 WITH .Column7
727:                     .Width          = 243
728:                     .ControlSource  = "crFichaTec.nChkCxas"
729:                     .Header1.Caption = "Caixa"
730:                     .Sparse         = .F.
731:                     .CurrentControl = "opt_4c_NChkCxas"
732:                     .AddObject("opt_4c_NChkCxas", "OptionGroup")
733:                     WITH .opt_4c_NChkCxas
734:                         .ButtonCount = 3
735:                         .Value       = 1
736:                         .Height      = 16
737:                         .Width       = 241
738:                         WITH .Buttons(1)
739:                             .Caption   = "Maiusculo"
740:                             .Width     = 74
741:                             .BackStyle = 0
742:                         ENDWITH
743:                         WITH .Buttons(2)

*-- Linhas 755 a 778:
755:                 ENDWITH
756:                 WITH .Column8
757:                     .Width           = 25
758:                     .ControlSource   = "crFichaTec.cSelecaos"
759:                     .Header1.Caption = "S"
760:                 ENDWITH
761:                 WITH .Column9
762:                     .Width           = 25
763:                     .ControlSource   = "crFichaTec.cTpDados"
764:                     .Header1.Caption = "T"
765:                 ENDWITH
766:             ENDWITH
767: 
768:             loc_oPg.AddObject("cmd_4c_ApagarLinha", "CommandButton")
769:             WITH loc_oPg.cmd_4c_ApagarLinha
770:                 .Top     = 235
771:                 .Left    = 949
772:                 .Width   = 40
773:                 .Height  = 40
774:                 .Caption = ""
775:                 .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
776:                 .Themes  = .T.
777:                 .Visible = .F.
778:             ENDWITH

*-- Linhas 935 a 953:
935:                 .Height        = 16
936:                 .ButtonCount   = 2
937:                 .Value         = 1
938:                 .ControlSource = "crFichaCab.nChkImps"
939:                 .Visible       = (THIS.this_nTipo = 0)
940:                 WITH .Buttons(1)
941:                     .Caption   = "Produtos"
942:                     .Width     = 70
943:                     .BackStyle = 0
944:                 ENDWITH
945:                 WITH .Buttons(2)
946:                     .Caption   = "Ficha T" + CHR(233) + "cnica"
947:                     .Left      = 75
948:                     .Width     = 90
949:                     .BackStyle = 0
950:                 ENDWITH
951:             ENDWITH
952: 
953:             loc_oPg.AddObject("chk_4c_NFixFigs", "CheckBox")

*-- Linhas 959 a 977:
959:                 .Style         = 1
960:                 .Caption       = ""
961:                 .Picture       = gc_4c_CaminhoIcones + "geral_lock_on_34.jpg"
962:                 .ControlSource = "crFichaCab.nFixFigs"
963:                 .Themes        = .T.
964:                 .Visible       = (THIS.this_nTipo = 0)
965:             ENDWITH
966: 
967:             loc_oPg.AddObject("img_4c_FigTec", "Image")
968:             WITH loc_oPg.img_4c_FigTec
969:                 .Top     = 94
970:                 .Left    = 301
971:                 .Width   = 334
972:                 .Height  = 228
973:                 .Stretch = 1
974:                 .Visible = .F.
975:             ENDWITH
976: 
977:             loc_oPg.AddObject("cmd_4c_Figura", "CommandButton")

*-- Linhas 1069 a 1087:
1069:             IF !USED("crDados") OR RECCOUNT("crDados") = 0
1070:                 MsgAviso("Selecione um registro na lista.", "Aviso")
1071:             ELSE
1072:                 SELECT crDados
1073:                 IF EOF()
1074:                     MsgAviso("Selecione um registro na lista.", "Aviso")
1075:                 ELSE
1076:                     loc_cCGrus = ALLTRIM(crDados.CGrus)
1077:                     loc_cSGrus = ALLTRIM(crDados.SGrus)
1078:                     loc_cDGrus = ALLTRIM(crDados.DGrus)
1079:                     loc_cDSGru = ALLTRIM(crDados.DSGru)
1080: 
1081:             THIS.this_cModoAtual = par_cModo
1082:             THIS.this_oBusinessObject.CarregarFicha(loc_cCGrus, loc_cSGrus, ;
1083:                 loc_cDGrus, loc_cDSGru, par_cModo)
1084: 
1085:             IF par_cModo = "ALTERAR"
1086:                 THIS.this_oBusinessObject.CarregarFiltroGrupos()
1087:             ENDIF

*-- Linhas 1134 a 1152:
1134:             IF !USED("crDados") OR RECCOUNT("crDados") = 0
1135:                 MsgAviso("Selecione um grupo na lista.", "Aviso")
1136:             ELSE
1137:                 SELECT crDados
1138:                 IF EOF()
1139:                     MsgAviso("Selecione um grupo na lista.", "Aviso")
1140:                 ELSE
1141:                     IF !EMPTY(ALLTRIM(crDados.TemDados))
1142:                     MsgAviso("Este grupo j" + CHR(225) + " possui ficha t" + CHR(233) + ;
1143:                         "cnica. Use Alterar para modificar.", "Aviso")
1144:                 ELSE
1145:                     loc_lResultado = THIS.CarregarDados("ALTERAR")
1146:                     ENDIF
1147:                 ENDIF
1148:             ENDIF
1149:         CATCH TO loc_oErro
1150:             MsgErro("Erro ao incluir ficha:" + CHR(13) + loc_oErro.Message, "Erro")
1151:         ENDTRY
1152:         RETURN loc_lResultado

*-- Linhas 1245 a 1272:
1245:         loc_lResultado = .F.
1246:         TRY
1247:             IF USED("crFichaTec")
1248:                 SELECT crFichaTec
1249:                 IF !EOF() AND RECCOUNT() > 0
1250:                     IF MsgConfirma("Apagar esta linha da ficha t" + CHR(233) + "cnica?", "Confirmar")
1251:                         DELETE
1252:                         PACK
1253:                         SELECT crFichaTec
1254:                         GO TOP
1255:                         IF EOF()
1256:                             THIS.this_oBusinessObject.AdicionarLinhaFicha()
1257:                             SELECT crFichaTec
1258:                             GO TOP
1259:                         ENDIF
1260:                         THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1.grd_4c_Fichas.Refresh()
1261:                         loc_lResultado = .T.
1262:                     ENDIF
1263:                 ENDIF
1264:             ENDIF
1265:         CATCH TO loc_oErro
1266:             MsgErro("Erro ao apagar linha:" + CHR(13) + loc_oErro.Message, "Erro")
1267:         ENDTRY
1268:         RETURN loc_lResultado
1269:     ENDPROC
1270: 
1271:     *--------------------------------------------------------------------------
1272:     PROCEDURE BtnRespostasClick()

*-- Linhas 1280 a 1305:
1280:                     "o dispon" + CHR(237) + "vel.", "Aviso")
1281:             ELSE
1282:                 IF USED("crFichaTec")
1283:                     SELECT crFichaTec
1284:                     IF !EOF()
1285:                         loc_cCCars = ALLTRIM(crFichaTec.CCars)
1286:                         loc_cCTits = ALLTRIM(crFichaTec.CTits)
1287:                         IF EMPTY(loc_cCCars)
1288:                             MsgAviso("Selecione uma caracter" + CHR(237) + "stica na grade.", "Aviso")
1289:                         ELSE
1290:                             SELECT crFichaCab
1291:                             loc_cCGrus = ALLTRIM(crFichaCab.CGrus)
1292:                             loc_cSGrus = ALLTRIM(crFichaCab.SGrus)
1293:                             DO FORM (gc_4c_CaminhoForms + "cadastros\FormFte") ;
1294:                                 WITH loc_cCGrus, loc_cSGrus, loc_cCCars, loc_cCTits
1295:                             loc_lResultado = .T.
1296:                         ENDIF
1297:                     ENDIF
1298:                 ENDIF
1299:             ENDIF
1300:         CATCH TO loc_oErro
1301:             MsgErro("Erro ao abrir respostas:" + CHR(13) + loc_oErro.Message, "Erro")
1302:         ENDTRY
1303:         RETURN loc_lResultado
1304:     ENDPROC
1305: 

*-- Linhas 1339 a 1392:
1339:             IF EMPTY(loc_cCGrusSrc)
1340:                 MsgAviso("Informe o grupo de origem.", "Aviso")
1341:             ELSE
1342:                 loc_cSql = "SELECT CCars, CTits, COrds, CLins, Maxs, Mins, " + ;
1343:                            "nChkCxas, cSelecaos, cTpDados " + ;
1344:                            "FROM SigCdFtc WHERE CGrus = " + EscaparSQL(loc_cCGrusSrc)
1345:                 IF THIS.this_nTipo = 0 AND !EMPTY(loc_cSGrusSrc)
1346:                     loc_cSql = loc_cSql + " AND SGrus = " + EscaparSQL(loc_cSGrusSrc)
1347:                 ENDIF
1348:                 loc_cSql = loc_cSql + " ORDER BY COrds"
1349: 
1350:                 IF USED("cursor_4c_CopiaFtc")
1351:                     USE IN cursor_4c_CopiaFtc
1352:                 ENDIF
1353:                 loc_nSql = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_CopiaFtc")
1354:                 IF loc_nSql <= 0
1355:                     MsgErro("Erro ao buscar ficha de origem.", "Erro")
1356:                 ELSE
1357:                     IF RECCOUNT("cursor_4c_CopiaFtc") = 0
1358:                         USE IN cursor_4c_CopiaFtc
1359:                         MsgAviso("Grupo de origem n" + CHR(227) + "o possui ficha t" + ;
1360:                             CHR(233) + "cnica.", "Aviso")
1361:                     ELSE
1362:                         SELECT crFichaTec
1363:                         ZAP
1364:                         SELECT cursor_4c_CopiaFtc
1365:                         SCAN
1366:                             SELECT crFichaTec
1367:                             APPEND BLANK
1368:                             REPLACE crFichaTec.CCars     WITH ALLTRIM(cursor_4c_CopiaFtc.CCars)
1369:                             REPLACE crFichaTec.CTits     WITH ALLTRIM(cursor_4c_CopiaFtc.CTits)
1370:                             REPLACE crFichaTec.COrds     WITH cursor_4c_CopiaFtc.COrds
1371:                             REPLACE crFichaTec.CLins     WITH cursor_4c_CopiaFtc.CLins
1372:                             REPLACE crFichaTec.Maxs      WITH cursor_4c_CopiaFtc.Maxs
1373:                             REPLACE crFichaTec.Mins      WITH cursor_4c_CopiaFtc.Mins
1374:                             REPLACE crFichaTec.nChkCxas  WITH cursor_4c_CopiaFtc.nChkCxas
1375:                             REPLACE crFichaTec.cSelecaos WITH cursor_4c_CopiaFtc.cSelecaos
1376:                             REPLACE crFichaTec.cTpDados  WITH cursor_4c_CopiaFtc.cTpDados
1377:                             SELECT cursor_4c_CopiaFtc
1378:                         ENDSCAN
1379:                         USE IN cursor_4c_CopiaFtc
1380: 
1381:                         THIS.this_oBusinessObject.AdicionarLinhaFicha()
1382:                         loc_oPg.cnt_4c_CopiarAcesso.Visible = .F.
1383:                         loc_oPg.grd_4c_Fichas.Refresh()
1384:                         loc_lResultado = .T.
1385:                     ENDIF
1386:                 ENDIF
1387:             ENDIF
1388:         CATCH TO loc_oErro
1389:             MsgErro("Erro ao copiar ficha:" + CHR(13) + loc_oErro.Message, "Erro")
1390:         ENDTRY
1391:         RETURN loc_lResultado
1392:     ENDPROC

*-- Linhas 1409 a 1427:
1409:             IF !EMPTY(loc_cArqFig) AND FILE(loc_cArqFig)
1410:                 loc_cConteudo = FILETOSTR(loc_cArqFig)
1411:                 IF USED("crFichaCab")
1412:                     SELECT crFichaCab
1413:                     REPLACE crFichaCab.mFicTecs WITH loc_cConteudo
1414:                 ENDIF
1415:                 loc_cExt     = LOWER(JUSTEXT(loc_cArqFig))
1416:                 loc_cArqTemp = SYS(2023) + "\FigTec_" + SYS(3) + "." + loc_cExt
1417:                 STRTOFILE(loc_cConteudo, loc_cArqTemp)
1418:                 IF FILE(loc_cArqTemp)
1419:                     loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
1420:                     loc_oPg2.img_4c_FigTec.Picture = loc_cArqTemp
1421:                     loc_oPg2.img_4c_FigTec.Visible = .T.
1422:                 ENDIF
1423:                 loc_lResultado = .T.
1424:             ENDIF
1425:         CATCH TO loc_oErro
1426:             MsgErro("Erro ao carregar figura:" + CHR(13) + loc_oErro.Message, "Erro")
1427:         ENDTRY

*-- Linhas 1441 a 1489:
1441:         loc_lResultado = .T.
1442:         TRY
1443:             IF USED("crFichaTec")
1444:                 SELECT crFichaTec
1445:                 IF !EOF()
1446:                     loc_cCCars = ALLTRIM(crFichaTec.CCars)
1447:                     IF !EMPTY(loc_cCCars)
1448:                         IF USED("cursor_4c_BuscaCCars")
1449:                             USE IN cursor_4c_BuscaCCars
1450:                         ENDIF
1451:                         loc_nSql = SQLEXEC(gnConnHandle, ;
1452:                             "SELECT CCars, DCars FROM SigCrRaP WHERE CCars = " + EscaparSQL(loc_cCCars), ;
1453:                             "cursor_4c_BuscaCCars")
1454:                         IF loc_nSql > 0 AND RECCOUNT("cursor_4c_BuscaCCars") > 0
1455:                             USE IN cursor_4c_BuscaCCars
1456:                         ELSE
1457:                             IF USED("cursor_4c_BuscaCCars")
1458:                                 USE IN cursor_4c_BuscaCCars
1459:                             ENDIF
1460:                             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1461:                                 "SigCrRaP", "cursor_4c_BuscaCCars", "CCars", loc_cCCars, ;
1462:                                 "Caracter" + CHR(237) + "sticas")
1463:                             IF !ISNULL(loc_oForm)
1464:                                 IF !loc_oForm.this_lAchouRegistro
1465:                                     loc_oForm.mAddColuna("CCars", "", "C" + CHR(243) + "digo")
1466:                                     loc_oForm.mAddColuna("DCars", "", "Descri" + CHR(231) + CHR(227) + "o")
1467:                                     loc_oForm.Show()
1468:                                 ENDIF
1469:                                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaCCars")
1470:                                     SELECT crFichaTec
1471:                                     REPLACE crFichaTec.CCars WITH ALLTRIM(cursor_4c_BuscaCCars.CCars)
1472:                                     USE IN cursor_4c_BuscaCCars
1473:                                 ELSE
1474:                                     SELECT crFichaTec
1475:                                     REPLACE crFichaTec.CCars WITH ""
1476:                                     IF USED("cursor_4c_BuscaCCars")
1477:                                         USE IN cursor_4c_BuscaCCars
1478:                                     ENDIF
1479:                                 ENDIF
1480:                                 loc_oForm.Release()
1481:                             ENDIF
1482:                         ENDIF
1483:                     ENDIF
1484:                 ENDIF
1485:             ENDIF
1486:         CATCH TO loc_oErro
1487:             MsgErro("Erro em ValidCCarsGrid:" + CHR(13) + loc_oErro.Message, "Erro")
1488:         ENDTRY
1489:         RETURN loc_lResultado

*-- Linhas 1496 a 1544:
1496:         loc_lResultado = .T.
1497:         TRY
1498:             IF USED("crFichaTec")
1499:                 SELECT crFichaTec
1500:                 IF !EOF()
1501:                     loc_cCTits = ALLTRIM(crFichaTec.CTits)
1502:                     IF !EMPTY(loc_cCTits)
1503:                         IF USED("cursor_4c_BuscaCTits")
1504:                             USE IN cursor_4c_BuscaCTits
1505:                         ENDIF
1506:                         loc_nSql = SQLEXEC(gnConnHandle, ;
1507:                             "SELECT CTits, DTits FROM SigPrCpP WHERE CTits = " + EscaparSQL(loc_cCTits), ;
1508:                             "cursor_4c_BuscaCTits")
1509:                         IF loc_nSql > 0 AND RECCOUNT("cursor_4c_BuscaCTits") > 0
1510:                             USE IN cursor_4c_BuscaCTits
1511:                         ELSE
1512:                             IF USED("cursor_4c_BuscaCTits")
1513:                                 USE IN cursor_4c_BuscaCTits
1514:                             ENDIF
1515:                             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1516:                                 "SigPrCpP", "cursor_4c_BuscaCTits", "CTits", loc_cCTits, ;
1517:                                 "T" + CHR(237) + "tulos")
1518:                             IF !ISNULL(loc_oForm)
1519:                                 IF !loc_oForm.this_lAchouRegistro
1520:                                     loc_oForm.mAddColuna("CTits", "", "C" + CHR(243) + "digo")
1521:                                     loc_oForm.mAddColuna("DTits", "", "Descri" + CHR(231) + CHR(227) + "o")
1522:                                     loc_oForm.Show()
1523:                                 ENDIF
1524:                                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaCTits")
1525:                                     SELECT crFichaTec
1526:                                     REPLACE crFichaTec.CTits WITH ALLTRIM(cursor_4c_BuscaCTits.CTits)
1527:                                     USE IN cursor_4c_BuscaCTits
1528:                                 ELSE
1529:                                     SELECT crFichaTec
1530:                                     REPLACE crFichaTec.CTits WITH ""
1531:                                     IF USED("cursor_4c_BuscaCTits")
1532:                                         USE IN cursor_4c_BuscaCTits
1533:                                     ENDIF
1534:                                 ENDIF
1535:                                 loc_oForm.Release()
1536:                             ENDIF
1537:                         ENDIF
1538:                     ENDIF
1539:                 ENDIF
1540:             ENDIF
1541:         CATCH TO loc_oErro
1542:             MsgErro("Erro em ValidCTitsGrid:" + CHR(13) + loc_oErro.Message, "Erro")
1543:         ENDTRY
1544:         RETURN loc_lResultado

*-- Linhas 1553 a 1571:
1553:         TRY
1554:             IF par_nKeyCode = 13 AND THIS.this_cModoAtual = "ALTERAR"
1555:                 IF USED("crFichaTec")
1556:                     SELECT crFichaTec
1557:                     IF !EOF() AND RECNO() = RECCOUNT()
1558:                         THIS.this_oBusinessObject.AdicionarLinhaFicha()
1559:                         THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1.grd_4c_Fichas.Refresh()
1560:                     ENDIF
1561:                 ENDIF
1562:             ENDIF
1563:             loc_lResultado = .T.
1564:         CATCH TO loc_oErro
1565:             MsgErro("Erro em KeyPressCTpDados:" + CHR(13) + loc_oErro.Message, "Erro")
1566:         ENDTRY
1567:         RETURN loc_lResultado
1568:     ENDPROC
1569: 
1570:     *--------------------------------------------------------------------------
1571:     PROCEDURE ValidCpyCGrus()

*-- Linhas 1581 a 1599:
1581:                 loc_lEncontrado = .T.
1582:             ELSE
1583:                 IF USED("crSigCdGrpFilter")
1584:                     SELECT crSigCdGrpFilter
1585:                     LOCATE FOR ALLTRIM(crSigCdGrpFilter.CGrus) = loc_cCGrus
1586:                     IF !EOF()
1587:                         loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDGrus.Value = ALLTRIM(crSigCdGrpFilter.DGrus)
1588:                         loc_lEncontrado = .T.
1589:                     ENDIF
1590:                 ENDIF
1591:             ENDIF
1592:             IF !loc_lEncontrado
1593:                 DO CASE
1594:                 CASE THIS.this_nTipo = 1
1595:                     loc_cTabela = "SigCdGcr"
1596:                 CASE THIS.this_nTipo = 2
1597:                     loc_cTabela = "SigCdOpe"
1598:                 OTHERWISE
1599:                     loc_cTabela = "SigCdGrp"

*-- Linhas 1645 a 1687:
1645:                 IF USED("cursor_4c_BuscaSGrp")
1646:                     USE IN cursor_4c_BuscaSGrp
1647:                 ENDIF
1648:                 loc_nSql = SQLEXEC(gnConnHandle, ;
1649:                     "SELECT Codigos, Descricaos FROM SigCdPsg" + ;
1650:                     " WHERE CGrus = " + EscaparSQL(loc_cCGrus) + ;
1651:                     " AND Codigos = " + EscaparSQL(loc_cSGrus), ;
1652:                     "cursor_4c_BuscaSGrp")
1653:                 IF loc_nSql > 0 AND RECCOUNT("cursor_4c_BuscaSGrp") > 0
1654:                     SELECT cursor_4c_BuscaSGrp
1655:                     loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus.Value = ALLTRIM(cursor_4c_BuscaSGrp.Codigos)
1656:                     loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDSGru.Value = ALLTRIM(cursor_4c_BuscaSGrp.Descricaos)
1657:                     USE IN cursor_4c_BuscaSGrp
1658:                 ELSE
1659:                     IF USED("cursor_4c_BuscaSGrp")
1660:                         USE IN cursor_4c_BuscaSGrp
1661:                     ENDIF
1662:                     loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1663:                         "SigCdPsg", "cursor_4c_BuscaSGrp", "Codigos", loc_cSGrus, ;
1664:                         "Sub-grupos")
1665:                     IF VARTYPE(loc_oForm) = "O"
1666:                         IF !loc_oForm.this_lAchouRegistro
1667:                             loc_oForm.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
1668:                             loc_oForm.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1669:                             loc_oForm.Show()
1670:                         ENDIF
1671:                         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaSGrp")
1672:                             SELECT cursor_4c_BuscaSGrp
1673:                             loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus.Value = ALLTRIM(cursor_4c_BuscaSGrp.Codigos)
1674:                             loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDSGru.Value = ALLTRIM(cursor_4c_BuscaSGrp.Descricaos)
1675:                             USE IN cursor_4c_BuscaSGrp
1676:                         ELSE
1677:                             loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus.Value = ""
1678:                             loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDSGru.Value = ""
1679:                             IF USED("cursor_4c_BuscaSGrp")
1680:                                 USE IN cursor_4c_BuscaSGrp
1681:                             ENDIF
1682:                         ENDIF
1683:                         loc_oForm.Release()
1684:                     ENDIF
1685:                 ENDIF
1686:             ENDIF
1687:         CATCH TO loc_oErro

*-- Linhas 1697 a 1738:
1697:         loc_lResultado = .T.
1698:         TRY
1699:             IF USED("crFichaTec")
1700:                 SELECT crFichaTec
1701:                 IF !EOF()
1702:                     loc_cValor = ALLTRIM(crFichaTec.cSelecaos)
1703:                     IF !EMPTY(loc_cValor) AND !INLIST(loc_cValor, "S", "N")
1704:                         MsgAviso("Tipos de Sele" + CHR(231) + CHR(227) + "o v" + CHR(225) + ;
1705:                             "lidos: S ou N !", "Aten" + CHR(231) + CHR(227) + "o")
1706:                         REPLACE crFichaTec.cSelecaos WITH " "
1707:                     ENDIF
1708:                 ENDIF
1709:             ENDIF
1710:         CATCH TO loc_oErro
1711:             MsgErro("Erro em ValidCSelecaos:" + CHR(13) + loc_oErro.Message, "Erro")
1712:         ENDTRY
1713:         RETURN loc_lResultado
1714:     ENDPROC
1715: 
1716:     *--------------------------------------------------------------------------
1717:     PROCEDURE ValidCTpDados()
1718:     *--------------------------------------------------------------------------
1719:         LOCAL loc_lResultado, loc_cValor
1720:         loc_lResultado = .T.
1721:         TRY
1722:             IF USED("crFichaTec")
1723:                 SELECT crFichaTec
1724:                 IF !EOF()
1725:                     loc_cValor = ALLTRIM(crFichaTec.cTpDados)
1726:                     IF !EMPTY(loc_cValor) AND !INLIST(loc_cValor, "C", "D", "N")
1727:                         MsgAviso("Tipo de dado inv" + CHR(225) + "lido." + CHR(13) + ;
1728:                             "Usar: C - Caracter, D - Data, N - Num" + CHR(233) + "rico !", ;
1729:                             "Aten" + CHR(231) + CHR(227) + "o")
1730:                         REPLACE crFichaTec.cTpDados WITH " "
1731:                     ENDIF
1732:                 ENDIF
1733:             ENDIF
1734:         CATCH TO loc_oErro
1735:             MsgErro("Erro em ValidCTpDados:" + CHR(13) + loc_oErro.Message, "Erro")
1736:         ENDTRY
1737:         RETURN loc_lResultado
1738:     ENDPROC

*-- Linhas 1803 a 1840:
1803: 
1804:     *--------------------------------------------------------------------------
1805:     * FormParaBO - Consolida dados dos controles bound ao BO/cursor
1806:     *   Os TextBox/OptionGroup/CheckBox estao com ControlSource direto para
1807:     *   crFichaCab/crFichaTec (padrao SCX legado). Este metodo garante que
1808:     *   o registro corrente esteja gravado no cursor antes de operacoes.
1809:     *--------------------------------------------------------------------------
1810:     PROTECTED PROCEDURE FormParaBO()
1811:         LOCAL loc_lResultado
1812:         loc_lResultado = .F.
1813:         TRY
1814:             *-- ControlSource faz binding bidirecional automatico: qualquer
1815:             *-- alteracao na tela ja esta gravada no cursor. Aqui garantimos
1816:             *-- apenas que os cursores estao posicionados corretamente para
1817:             *-- que o BO acesse o registro correto no Salvar/Excluir.
1818:             IF USED("crFichaCab")
1819:                 SELECT crFichaCab
1820:                 IF !EOF() AND !BOF()
1821:                     GO RECNO()
1822:                 ENDIF
1823:             ENDIF
1824:             IF USED("crFichaTec")
1825:                 SELECT crFichaTec
1826:                 IF !EOF() AND !BOF()
1827:                     GO RECNO()
1828:                 ENDIF
1829:             ENDIF
1830:             loc_lResultado = .T.
1831:         CATCH TO loc_oErro
1832:             MsgErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message, "Erro")
1833:         ENDTRY
1834:         RETURN loc_lResultado
1835:     ENDPROC
1836: 
1837:     *--------------------------------------------------------------------------
1838:     * BOParaForm - Atualiza controles da tela com dados dos cursores do BO
1839:     *   Refresh dos containers/grids que exibem crFichaCab e crFichaTec.
1840:     *--------------------------------------------------------------------------

*-- Linhas 1846 a 1864:
1846:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
1847: 
1848:             IF USED("crFichaTec")
1849:                 SELECT crFichaTec
1850:                 GO TOP
1851:                 loc_oPg.grd_4c_Fichas.Refresh()
1852:             ENDIF
1853: 
1854:             *-- Refresh dos OptionGroups bound (nChkDims/nChkTems/nChkPess/nChkImps)
1855:             IF PEMSTATUS(loc_oPg, "opt_4c_NChkDims", 5)
1856:                 loc_oPg.opt_4c_NChkDims.Refresh()
1857:             ENDIF
1858:             IF PEMSTATUS(loc_oPg, "opt_4c_NChkTems", 5)
1859:                 loc_oPg.opt_4c_NChkTems.Refresh()
1860:             ENDIF
1861:             IF PEMSTATUS(loc_oPg, "opt_4c_NChkPess", 5)
1862:                 loc_oPg.opt_4c_NChkPess.Refresh()
1863:             ENDIF
1864:             IF PEMSTATUS(loc_oPg2, "opt_4c_NChkImps", 5)

*-- Linhas 1884 a 1906:
1884:         loc_lResultado = .F.
1885:         TRY
1886:             IF USED("crFichaCab")
1887:                 SELECT crFichaCab
1888:                 ZAP
1889:             ENDIF
1890:             IF USED("crFichaTec")
1891:                 SELECT crFichaTec
1892:                 ZAP
1893:             ENDIF
1894: 
1895:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
1896:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
1897: 
1898:             *-- Fecha painel de copia se estiver aberto
1899:             IF PEMSTATUS(loc_oPg, "cnt_4c_CopiarAcesso", 5)
1900:                 loc_oPg.cnt_4c_CopiarAcesso.Visible = .F.
1901:                 loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyCGrus.Value = ""
1902:                 loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDGrus.Value = ""
1903:                 loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus.Value = ""
1904:                 loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDSGru.Value = ""
1905:             ENDIF
1906: 


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

