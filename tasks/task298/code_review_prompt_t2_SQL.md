# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNLINHA, FPAGS, LNCONTA1, IMPBOLS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNLINHA, FPAGS, LNCONTA1, IMPBOLS

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
  ControlSource = "crSigCnFbl.clocals"
	Select crSigCnFBl
	Insert Into TmpImprime (Linha, Coluna, Conteudo, Style, LineSize, NHeight) ;
lcQueryCfgBl  = [Select * From SigCnFBl Where FPags = ?pPag]
	Select crSigCnFBl
	If ThisForm.Podatamgr.Update('CrSigCnFBl') And ;
			Select TprMvCab
			Insert Into TprMvCab (Emps, Dopes, Numes) ;
		Select TprMvCab
							Select CrSigCnFBl
							Select CrTmpPar
									Insert into Crdados  values(CrSigCnFBl.cLocals, xVenc, CrTmpPar.Datas, CrtmpNfis.NFis+'-'+Str(Crtmppar.parcs,1),;

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRIBL.prg) - TRECHOS RELEVANTES PARA PASS SQL (1273 linhas total):

*-- Linhas 43 a 61:
43: 
44:         *-- Cursor auxiliar de movimentos a imprimir (compartilhado com SigPrIbl.prg)
45:         IF !USED("TprMvCab")
46:             CREATE CURSOR TprMvCab (Emps C(3), Dopes C(20), Numes N(6,0), Parcs C(2))
47:         ENDIF
48: 
49:         RETURN DODEFAULT()
50:     ENDPROC
51: 
52:     *--------------------------------------------------------------------------
53:     * InicializarForm - Configura o formulario operacional completo
54:     *--------------------------------------------------------------------------
55:     PROTECTED PROCEDURE InicializarForm()
56:         LOCAL loc_lSucesso, loc_oErro
57:         loc_lSucesso = .F.
58:         TRY
59:             THIS.Caption = "Impress" + CHR(227) + "o de Boleto Banc" + CHR(225) + "rio"
60: 
61:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")

*-- Linhas 345 a 363:
345:             ENDIF
346: 
347:             SET NULL ON
348:             CREATE CURSOR cursor_4c_Config ( ;
349:                 FPags      C(12)  NULL, ;
350:                 cLocals    C(100) NULL, ;
351:                 cTxtCds    M      NULL, ;
352:                 cNomeImps  C(50)  NULL, ;
353:                 cFontePdrs C(20)  NULL, ;
354:                 nTamFontes N(3,0) NULL, ;
355:                 cTamFolha  C(30)  NULL, ;
356:                 cIdChaves  C(15)  NULL, ;
357:                 nLnLocals  N(6,2) NULL, ;
358:                 nClLocals  N(6,2) NULL, ;
359:                 nLnDtVencs N(6,2) NULL, ;
360:                 nClDtVencs N(6,2) NULL, ;
361:                 nLnDtDocs  N(6,2) NULL, ;
362:                 nClDtDocs  N(6,2) NULL, ;
363:                 nLnNrDocs  N(6,2) NULL, ;

*-- Linhas 383 a 420:
383:             )
384:             SET NULL OFF
385: 
386:             loc_cSQL = "SELECT FPags, cLocals, cTxtCds, cNomeImps, cFontePdrs," + ;
387:                        " nTamFontes, cTamFolha, cIdChaves," + ;
388:                        " nLnLocals, nClLocals, nLnDtVencs, nClDtVencs," + ;
389:                        " nLnDtDocs, nClDtDocs, nLnNrDocs, nClNrDocs," + ;
390:                        " nLnVlDocs, nClVlDocs, nLnRazClis, nClRazClis," + ;
391:                        " nLnCgcClis, nClCgcClis, nLnEndCobs, nClEndCobs," + ;
392:                        " nLnBaiCobs, nClBaiCobs, nLnCidCobs, nClCidCobs," + ;
393:                        " nLnEstCobs, nClEstCobs, nLnCepCobs, nClCepCobs," + ;
394:                        " nLnTxtCds, nClTxtCds" + ;
395:                        " FROM SigCnFBl WHERE FPags = " + EscaparSQL(loc_cFPags)
396:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConfigTemp")
397: 
398:             IF loc_nRet > 0 AND USED("cursor_4c_ConfigTemp") AND RECCOUNT("cursor_4c_ConfigTemp") > 0
399:                 SELECT cursor_4c_Config
400:                 ZAP
401:                 APPEND FROM DBF("cursor_4c_ConfigTemp")
402:                 IF USED("cursor_4c_ConfigTemp")
403:                     USE IN cursor_4c_ConfigTemp
404:                 ENDIF
405:                 SELECT cursor_4c_Config
406:                 GO TOP
407:                 loc_lAchou = .T.
408:             ELSE
409:                 IF USED("cursor_4c_ConfigTemp")
410:                     USE IN cursor_4c_ConfigTemp
411:                 ENDIF
412:             ENDIF
413: 
414:             IF loc_lAchou
415:                 IF PEMSTATUS(THIS, "txt_4c_Locals", 5)
416:                     THIS.txt_4c_Locals.Enabled = .T.
417:                     THIS.txt_4c_Locals.Value   = NVL(cursor_4c_Config.cLocals, "")
418:                     THIS.txt_4c_Locals.Refresh()
419:                 ENDIF
420:                 IF PEMSTATUS(THIS, "obj_4c_GetTxtCds", 5)

*-- Linhas 474 a 497:
474: 
475:             IF loc_lProcessar
476:                 *-- Busca exata primeiro
477:                 loc_cSQL = "SELECT TOP 1 FPags FROM SigCnFBl WHERE FPags = " + ;
478:                            EscaparSQL(PADR(loc_cVal, 12))
479:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FPagsExato")
480: 
481:                 IF loc_nRet > 0 AND USED("cursor_4c_FPagsExato") AND RECCOUNT("cursor_4c_FPagsExato") > 0
482:                     SELECT cursor_4c_FPagsExato
483:                     THIS.txt_4c_FPags.Value = ALLTRIM(NVL(FPags, ""))
484:                     IF USED("cursor_4c_FPagsExato")
485:                         USE IN cursor_4c_FPagsExato
486:                     ENDIF
487:                     THIS.AtualizaBoleto(THIS.txt_4c_FPags.Value)
488:                 ELSE
489:                     IF USED("cursor_4c_FPagsExato")
490:                         USE IN cursor_4c_FPagsExato
491:                     ENDIF
492:                     *-- Nao encontrado exato: abre lookup
493:                     THIS.AbrirLookupFPags()
494:                 ENDIF
495:             ENDIF
496:         CATCH TO loc_oErro
497:             MsgErro(loc_oErro.Message, "Erro ao validar Condi" + CHR(231) + CHR(227) + "o de Pagamento")

*-- Linhas 523 a 541:
523:                 loc_oLookup.Show()
524: 
525:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaFPags")
526:                     SELECT cursor_4c_BuscaFPags
527:                     THIS.txt_4c_FPags.Value = ALLTRIM(NVL(FPags, ""))
528:                     THIS.AtualizaBoleto(THIS.txt_4c_FPags.Value)
529:                 ENDIF
530:                 loc_oLookup.Release()
531:             ENDIF
532: 
533:             IF USED("cursor_4c_BuscaFPags")
534:                 USE IN cursor_4c_BuscaFPags
535:             ENDIF
536:         CATCH TO loc_oErro
537:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de Condi" + CHR(231) + CHR(227) + "o")
538:         ENDTRY
539:     ENDPROC
540: 
541:     *--------------------------------------------------------------------------

*-- Linhas 562 a 838:
562:                 RETURN
563:             ENDIF
564: 
565:             SELECT cursor_4c_Config
566:             REPLACE cLocals WITH THIS.txt_4c_Locals.Value
567:             REPLACE cTxtCds WITH THIS.obj_4c_GetTxtCds.Value
568: 
569:             loc_cSQL = "UPDATE SigCnFBl SET" + ;
570:                        " cLocals = " + EscaparSQL(THIS.txt_4c_Locals.Value) + "," + ;
571:                        " cTxtCds = " + EscaparSQL(THIS.obj_4c_GetTxtCds.Value) + ;
572:                        " WHERE FPags = " + EscaparSQL(PADR(THIS.this_cFPagsSel, 12))
573:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
574:             IF loc_nRet <= 0
575:                 MsgAviso("Falha ao salvar. Favor reinicializar o processo.", "Falha na Conex" + CHR(227) + "o")
576:                 THIS.LockScreen = .F.
577:                 RETURN
578:             ENDIF
579: 
580:             *-- Verifica se ha impressora de boleto configurada
581:             loc_lTemImpressora = .F.
582:             IF APRINTERS(loc_laPrinters) > 0
583:                 LOCAL loc_i
584:                 SELECT cursor_4c_Config
585:                 FOR loc_i = 1 TO ALEN(loc_laPrinters, 1)
586:                     IF UPPER(ALLTRIM(loc_laPrinters[loc_i, 1])) == UPPER(ALLTRIM(cursor_4c_Config.cNomeImps))
587:                         loc_lTemImpressora = .T.
588:                         EXIT
589:                     ENDIF
590:                 ENDFOR
591:             ENDIF
592: 
593:             IF !loc_lTemImpressora
594:                 MsgAviso("Nenhuma Impressora de Boleto Configurada ou Instalada.", "Aviso")
595:                 THIS.LockScreen = .F.
596:                 RETURN
597:             ENDIF
598: 
599:             *-- Carrega movimentos a imprimir
600:             IF !EMPTY(THIS.this_cChave1)
601:                 SELECT TprMvCab
602:                 ZAP
603:                 INSERT INTO TprMvCab (Emps, Dopes, Numes) VALUES ;
604:                     (SUBSTR(THIS.this_cChave1, 1, 3), ;
605:                      SUBSTR(THIS.this_cChave1, 4, 20), ;
606:                      INT(VAL(SUBSTR(THIS.this_cChave1, 24, 6))))
607:             ENDIF
608: 
609:             *-- Cria cursor de dados do boleto (uma linha por parcela impressa)
610:             IF USED("Crdados")
611:                 USE IN Crdados
612:             ENDIF
613:             SET NULL ON
614:             CREATE CURSOR Crdados ( ;
615:                 clocal  C(100), ;
616:                 vencs   C(12), ;
617:                 datdoc  D, ;
618:                 numdoc  C(8), ;
619:                 valor   N(14,2), ;
620:                 razaos  C(50), ;
621:                 cpfs    C(20), ;
622:                 endcobs C(80), ;
623:                 baicobs C(20), ;
624:                 cidcobs C(20), ;
625:                 estcobs C(2), ;
626:                 cepcobs C(9), ;
627:                 texto   M ;
628:             )
629:             SET NULL OFF
630: 
631:             *-- Monta fontes de impressao a partir da configuracao
632:             SELECT cursor_4c_Config
633:             IF EMPTY(ALLTRIM(NVL(cursor_4c_Config.cFontePdrs, "")))
634:                 loc_cFonteP = ""
635:                 loc_cFonteG = ""
636:             ELSE
637:                 IF NVL(cursor_4c_Config.nTamFontes, 0) = 0
638:                     loc_cFonteP = "Font '" + ALLTRIM(cursor_4c_Config.cFontePdrs) + "',9"
639:                     loc_cFonteG = "Font '" + ALLTRIM(cursor_4c_Config.cFontePdrs) + "',11"
640:                 ELSE
641:                     loc_cFonteP = "Font '" + ALLTRIM(cursor_4c_Config.cFontePdrs) + "'," + ;
642:                                   ALLTRIM(STR(cursor_4c_Config.nTamFontes, 3))
643:                     loc_cFonteG = "Font '" + ALLTRIM(cursor_4c_Config.cFontePdrs) + "'," + ;
644:                                   ALLTRIM(STR(cursor_4c_Config.nTamFontes + 2, 3))
645:                 ENDIF
646:             ENDIF
647:             loc_nTamFolha = VAL(ALLTRIM(SUBSTR(cursor_4c_Config.cTamFolha, ;
648:                                 (AT("/", cursor_4c_Config.cTamFolha, 1) + 1), ;
649:                                 (AT("/", cursor_4c_Config.cTamFolha, 2) - AT("/", cursor_4c_Config.cTamFolha, 1) - 1))))
650: 
651:             *-- Itera movimentos e gera dados de impressao
652:             SELECT TprMvCab
653:             GO TOP
654:             SCAN
655:                 loc_cChave1 = TprMvCab.Emps + TprMvCab.Dopes + STR(TprMvCab.Numes, 6)
656:                 loc_nParcel = NVL(TprMvCab.Parcs, 0)
657:                 IF VARTYPE(loc_nParcel) != "N"
658:                     loc_nParcel = 0
659:                 ENDIF
660: 
661:                 *-- Busca cabecalho do movimento
662:                 loc_cSQL = "SELECT TOP 1 Emps, Dopes, Numes, Contaos, Contads, Nfiscals" + ;
663:                            " FROM SigMvCab WHERE Emps + Dopes + CAST(Numes AS CHAR(6)) = " + ;
664:                            EscaparSQL(loc_cChave1)
665:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCab")
666:                 IF loc_nRet <= 0 OR !USED("cursor_4c_MvCab") OR RECCOUNT("cursor_4c_MvCab") = 0
667:                     MsgAviso("Esta Opera" + CHR(231) + CHR(227) + "o N" + CHR(227) + ;
668:                              "o Encontrou Movimenta" + CHR(231) + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
669:                     IF USED("cursor_4c_MvCab")
670:                         USE IN cursor_4c_MvCab
671:                     ENDIF
672:                     LOOP
673:                 ENDIF
674: 
675:                 *-- Busca parcelas do movimento
676:                 loc_cSQL = "SELECT Emps, Dopes, Numes, Parcs, Fpags, Vencs, Datas, Valos" + ;
677:                            " FROM SigMvPar WHERE Emps + Dopes + CAST(Numes AS CHAR(6)) = " + ;
678:                            EscaparSQL(loc_cChave1) + " ORDER BY Parcs"
679:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvPar")
680:                 IF loc_nRet <= 0 OR !USED("cursor_4c_MvPar") OR RECCOUNT("cursor_4c_MvPar") = 0
681:                     MsgAviso("Nenhuma Forma de Pagamento Encontrada Nessa Opera" + CHR(231) + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
682:                     IF USED("cursor_4c_MvPar")
683:                         USE IN cursor_4c_MvPar
684:                     ENDIF
685:                     IF USED("cursor_4c_MvCab")
686:                         USE IN cursor_4c_MvCab
687:                     ENDIF
688:                     LOOP
689:                 ENDIF
690: 
691:                 *-- Busca nota fiscal do movimento
692:                 loc_cSQL = "SELECT TOP 1 NFis, Emps, Dopes, Numes" + ;
693:                            " FROM SigMvNfi WHERE Emps + Dopes + CAST(Numes AS CHAR(6)) = " + ;
694:                            EscaparSQL(loc_cChave1)
695:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvNfi")
696:                 IF loc_nRet <= 0 OR !USED("cursor_4c_MvNfi") OR RECCOUNT("cursor_4c_MvNfi") = 0
697:                     MsgAviso("Esta Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
698:                              "o possui Nota Fiscal Cadastrada.", "Aten" + CHR(231) + CHR(227) + "o")
699:                     IF USED("cursor_4c_MvNfi")
700:                         USE IN cursor_4c_MvNfi
701:                     ENDIF
702:                     IF USED("cursor_4c_MvPar")
703:                         USE IN cursor_4c_MvPar
704:                     ENDIF
705:                     IF USED("cursor_4c_MvCab")
706:                         USE IN cursor_4c_MvCab
707:                     ENDIF
708:                     LOOP
709:                 ENDIF
710: 
711:                 *-- Busca dados do cliente (conta de origem ou destino conforme tipo NF)
712:                 SELECT cursor_4c_MvCab
713:                 LOCAL loc_cContaCli
714:                 loc_cContaCli = IIF(NVL(cursor_4c_MvCab.Nfiscals, 0) = 1, ;
715:                                     cursor_4c_MvCab.Contaos, cursor_4c_MvCab.Contads)
716:                 loc_cSQL = "SELECT TOP 1 Iclis, Razaos, Cpfs," + ;
717:                            " Endes, EndCobs, Bairs, BaiCobs, Cidas, CidCobs," + ;
718:                            " Estas, EstCobs, Ceps, CepCobs" + ;
719:                            " FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cContaCli)
720:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cli")
721:                 IF loc_nRet <= 0 OR !USED("cursor_4c_Cli") OR RECCOUNT("cursor_4c_Cli") = 0
722:                     IF USED("cursor_4c_Cli")
723:                         USE IN cursor_4c_Cli
724:                     ENDIF
725:                     IF USED("cursor_4c_MvNfi")
726:                         USE IN cursor_4c_MvNfi
727:                     ENDIF
728:                     IF USED("cursor_4c_MvPar")
729:                         USE IN cursor_4c_MvPar
730:                     ENDIF
731:                     IF USED("cursor_4c_MvCab")
732:                         USE IN cursor_4c_MvCab
733:                     ENDIF
734:                     LOOP
735:                 ENDIF
736: 
737:                 *-- Itera parcelas e insere dados para impressao
738:                 SELECT cursor_4c_MvPar
739:                 GO TOP
740:                 SCAN
741:                     loc_lTaOk = .T.
742:                     IF loc_nParcel > 0
743:                         IF cursor_4c_MvPar.Parcs != loc_nParcel
744:                             loc_lTaOk = .F.
745:                         ENDIF
746:                     ENDIF
747: 
748:                     IF loc_lTaOk
749:                         *-- Verifica forma de pagamento habilita boleto
750:                         loc_cSQL = "SELECT TOP 1 Fpags, ImpBols, ImpNotas" + ;
751:                                    " FROM SigOpFp WHERE Fpags = " + ;
752:                                    EscaparSQL(cursor_4c_MvPar.Fpags)
753:                         loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpFp")
754: 
755:                         IF loc_nRet > 0 AND USED("cursor_4c_OpFp") AND ;
756:                            RECCOUNT("cursor_4c_OpFp") > 0 AND cursor_4c_OpFp.ImpBols
757: 
758:                             *-- Cria cursor TmpImprime e indice de ordenacao
759:                             IF USED("TmpImprime")
760:                                 USE IN TmpImprime
761:                             ENDIF
762:                             CREATE CURSOR TmpImprime ( ;
763:                                 Linha    N(6,2), ;
764:                                 Coluna   N(6,2), ;
765:                                 Conteudo C(100), ;
766:                                 Style    C(3), ;
767:                                 fontname C(64), ;
768:                                 fontsize I, ;
769:                                 linesize N(6,2), ;
770:                                 nheight  N(6,2) ;
771:                             )
772:                             INDEX ON (Linha * 1000000000) + (Coluna * 100) TAG Ordem
773: 
774:                             LOCAL loc_xVenc
775:                             SELECT cursor_4c_OpFp
776:                             IF NVL(cursor_4c_OpFp.ImpNotas, 0) = 1
777:                                 SELECT cursor_4c_MvPar
778:                                 loc_xVenc = DTOC(cursor_4c_MvPar.Vencs)
779:                             ELSE
780:                                 SELECT cursor_4c_MvPar
781:                                 loc_xVenc = ALLTRIM(NVL(cursor_4c_MvPar.FPags, ""))
782:                             ENDIF
783: 
784:                             SELECT cursor_4c_MvNfi
785:                             LOCAL loc_cNumDoc
786:                             loc_cNumDoc = ALLTRIM(NVL(cursor_4c_MvNfi.NFis, "")) + "-" + ;
787:                                           ALLTRIM(STR(NVL(cursor_4c_MvPar.Parcs, 0), 1))
788: 
789:                             SELECT cursor_4c_Cli
790:                             LOCAL loc_cEndCob, loc_cBaiCob, loc_cCidCob, loc_cEstCob, loc_cCepCob
791:                             loc_cEndCob = IIF(!EMPTY(ALLTRIM(NVL(cursor_4c_Cli.EndCobs, ""))), ;
792:                                               cursor_4c_Cli.EndCobs, cursor_4c_Cli.Endes)
793:                             loc_cBaiCob = IIF(!EMPTY(ALLTRIM(NVL(cursor_4c_Cli.BaiCobs, ""))), ;
794:                                               cursor_4c_Cli.BaiCobs, cursor_4c_Cli.Bairs)
795:                             loc_cCidCob = IIF(!EMPTY(ALLTRIM(NVL(cursor_4c_Cli.CidCobs, ""))), ;
796:                                               cursor_4c_Cli.CidCobs, cursor_4c_Cli.Cidas)
797:                             loc_cEstCob = IIF(!EMPTY(ALLTRIM(NVL(cursor_4c_Cli.EstCobs, ""))), ;
798:                                               cursor_4c_Cli.EstCobs, cursor_4c_Cli.Estas)
799:                             loc_cCepCob = IIF(!EMPTY(ALLTRIM(NVL(cursor_4c_Cli.CepCobs, ""))), ;
800:                                               cursor_4c_Cli.CepCobs, cursor_4c_Cli.Ceps)
801: 
802:                             SELECT cursor_4c_MvPar
803:                             SELECT Crdados
804:                             ZAP
805:                             SELECT cursor_4c_Config
806:                             INSERT INTO Crdados VALUES ( ;
807:                                 cursor_4c_Config.cLocals, ;
808:                                 m.loc_xVenc, ;
809:                                 cursor_4c_MvPar.Datas, ;
810:                                 m.loc_cNumDoc, ;
811:                                 cursor_4c_MvPar.Valos, ;
812:                                 cursor_4c_Cli.Razaos, ;
813:                                 cursor_4c_Cli.Cpfs, ;
814:                                 m.loc_cEndCob, ;
815:                                 m.loc_cBaiCob, ;
816:                                 m.loc_cCidCob, ;
817:                                 m.loc_cEstCob, ;
818:                                 m.loc_cCepCob, ;
819:                                 THIS.obj_4c_GetTxtCds.Value ;
820:                             )
821: 
822:                             *-- Preenche TmpImprime com posicoes configuradas
823:                             SELECT cursor_4c_Config
824:                             THIS.GrDetalhe(cursor_4c_Config.nLnLocals,  cursor_4c_Config.nClLocals,  "Crdados.clocal",  "", 60, 1)
825:                             THIS.GrDetalhe(cursor_4c_Config.nLnDtVencs, cursor_4c_Config.nClDtVencs, "Crdados.Vencs",   "", 9,  1)
826:                             THIS.GrDetalhe(cursor_4c_Config.nLnDtDocs,  cursor_4c_Config.nClDtDocs,  "Dtoc(Crdados.Datdoc)", "", 9, 1)
827:                             THIS.GrDetalhe(cursor_4c_Config.nLnNrDocs,  cursor_4c_Config.nClNrDocs,  "Crdados.numdoc",  "", 9,  1)
828:                             THIS.GrDetalhe(cursor_4c_Config.nLnVlDocs,  cursor_4c_Config.nClVlDocs,  "Transform(CrDados.Valor,'@Z 999,999,999.99')", "", 15, 1)
829:                             THIS.GrDetalhe(cursor_4c_Config.nLnRazClis, cursor_4c_Config.nClRazClis, "AllTrim(Crdados.Razaos)",  "", 50, 1)
830:                             THIS.GrDetalhe(cursor_4c_Config.nLnCgcClis, cursor_4c_Config.nClCgcClis, "AllTrim(Crdados.Cpfs)",    "", 20, 1)
831:                             THIS.GrDetalhe(cursor_4c_Config.nLnEndCobs, cursor_4c_Config.nClEndCobs, "AllTrim(Crdados.EndCobs)", "", 80, 1)
832:                             THIS.GrDetalhe(cursor_4c_Config.nLnBaiCobs, cursor_4c_Config.nClBaiCobs, "AllTrim(Crdados.BaiCobs)", "", 20, 1)
833:                             THIS.GrDetalhe(cursor_4c_Config.nLnCidCobs, cursor_4c_Config.nClCidCobs, "AllTrim(Crdados.CidCobs)", "", 20, 1)
834:                             THIS.GrDetalhe(cursor_4c_Config.nLnEstCobs, cursor_4c_Config.nClEstCobs, "AllTrim(Crdados.EstCobs)", "", 2,  1)
835:                             THIS.GrDetalhe(cursor_4c_Config.nLnCepCobs, cursor_4c_Config.nClCepCobs, "AllTrim(Crdados.CepCobs)", "", 9,  1)
836:                             THIS.GrDetalhe(cursor_4c_Config.nLnTxtCds,  cursor_4c_Config.nClTxtCds,  "Crdados.texto",   "", 60, 6)
837: 
838:                             *-- Chama rotina de impressao matricial SigPrIbl.prg

*-- Linhas 912 a 930:
912: 
913:             IF !(loc_cEstilo == "*") AND (loc_nColuna != 0 OR loc_nLinha != 0)
914:                 IF USED("TmpImprime")
915:                     INSERT INTO TmpImprime (Linha, Coluna, Conteudo, Style, LineSize, NHeight) ;
916:                         VALUES (loc_nLinha, loc_nColuna, loc_cDetalhe, ;
917:                                 ALLTRIM(loc_cEstilo), par_nLineSize, par_nHeight)
918:                 ENDIF
919:             ENDIF
920:         CATCH TO loc_oErro
921:             MsgErro(loc_oErro.Message, "Erro em GrDetalhe")
922:         ENDTRY
923:     ENDPROC
924: 
925:     *--------------------------------------------------------------------------
926:     * BtnIncluirClick - Ponto de entrada canonico do pipeline
927:     * Form OPERACIONAL de impressao de boleto: a acao "Incluir/Confirmar" eh a
928:     * propria impressao dos boletos bancarios. Delega para CmdImprimirClick, que
929:     * confirma, salva a config editada em SigCnFBl e envia os movimentos para
930:     * impressora matricial via SigPrIbl.

*-- Linhas 1086 a 1108:
1086:                 RETURN
1087:             ENDIF
1088: 
1089:             loc_cSQL = "UPDATE SigCnFBl SET" + ;
1090:                        " cLocals = " + EscaparSQL(THIS.txt_4c_Locals.Value) + "," + ;
1091:                        " cTxtCds = " + EscaparSQL(THIS.obj_4c_GetTxtCds.Value) + ;
1092:                        " WHERE FPags = " + EscaparSQL(PADR(THIS.this_cFPagsSel, 12))
1093:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
1094:             IF loc_nRet > 0
1095:                 MsgInfo("Dados salvos com sucesso.", "Salvo")
1096:             ELSE
1097:                 MsgAviso("Falha ao salvar. Verifique a conex" + CHR(227) + "o.", "Aviso")
1098:             ENDIF
1099:         CATCH TO loc_oErro
1100:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ao Salvar")
1101:         ENDTRY
1102:     ENDPROC
1103: 
1104:     *--------------------------------------------------------------------------
1105:     * BtnCancelarClick - Cancela edicao corrente, restaura valores do banco
1106:     *--------------------------------------------------------------------------
1107:     PROCEDURE BtnCancelarClick()
1108:         LOCAL loc_oErro

*-- Linhas 1152 a 1170:
1152:         LOCAL loc_oErro
1153:         TRY
1154:             IF USED("cursor_4c_Config") AND RECCOUNT("cursor_4c_Config") > 0
1155:                 SELECT cursor_4c_Config
1156:                 GO TOP
1157:                 IF PEMSTATUS(THIS, "txt_4c_FPags", 5)
1158:                     THIS.txt_4c_FPags.Value = ALLTRIM(NVL(cursor_4c_Config.FPags, ""))
1159:                 ENDIF
1160:                 IF PEMSTATUS(THIS, "txt_4c_Locals", 5)
1161:                     THIS.txt_4c_Locals.Value = NVL(cursor_4c_Config.cLocals, "")
1162:                 ENDIF
1163:                 IF PEMSTATUS(THIS, "obj_4c_GetTxtCds", 5)
1164:                     THIS.obj_4c_GetTxtCds.Value = NVL(cursor_4c_Config.cTxtCds, "")
1165:                 ENDIF
1166:             ENDIF
1167:         CATCH TO loc_oErro
1168:             MsgErro(loc_oErro.Message, "Erro em BOParaForm")
1169:         ENDTRY
1170:     ENDPROC


### BO (C:\4c\projeto\app\classes\SIGPRIBLBO.prg):
*------------------------------------------------------------------------------
* SIGPRIBLBO.prg - Business Object para Impressao de Boleto Bancario
* Herda de: BusinessBase
* Tabela principal: SigCnFBl (configuracao de boleto)
*------------------------------------------------------------------------------
DEFINE CLASS SIGPRIBLBO AS BusinessBase

    *-- Identificacao da tabela e chave
    this_cTabela      = "SigCnFBl"
    this_cCampoChave  = "FPags"

    *-- Chave do movimento recebida do form pai (pcchave1)
    this_cChave1      = ""

    *-- Campos da configuracao de boleto (SigCnFBl)
    this_cFPags       = ""
    this_cIdChaves    = ""
    this_cLocals      = ""
    this_cTxtCds      = ""
    this_cNomeImps    = ""
    this_cFontePdrs   = ""
    this_nTamFontes   = 0
    this_cTamFolha    = ""

    *-- Posicoes de impressao: Local de Pagamento
    this_nLnLocals    = 0
    this_nClLocals    = 0

    *-- Posicoes de impressao: Data de Vencimento
    this_nLnDtVencs   = 0
    this_nClDtVencs   = 0

    *-- Posicoes de impressao: Data do Documento
    this_nLnDtDocs    = 0
    this_nClDtDocs    = 0

    *-- Posicoes de impressao: Numero do Documento
    this_nLnNrDocs    = 0
    this_nClNrDocs    = 0

    *-- Posicoes de impressao: Valor do Documento
    this_nLnVlDocs    = 0
    this_nClVlDocs    = 0

    *-- Posicoes de impressao: Razao Social do Cliente
    this_nLnRazClis   = 0
    this_nClRazClis   = 0

    *-- Posicoes de impressao: CPF/CNPJ do Cliente
    this_nLnCgcClis   = 0
    this_nClCgcClis   = 0

    *-- Posicoes de impressao: Endereco de Cobranca
    this_nLnEndCobs   = 0
    this_nClEndCobs   = 0

    *-- Posicoes de impressao: Bairro de Cobranca
    this_nLnBaiCobs   = 0
    this_nClBaiCobs   = 0

    *-- Posicoes de impressao: Cidade de Cobranca
    this_nLnCidCobs   = 0
    this_nClCidCobs   = 0

    *-- Posicoes de impressao: Estado de Cobranca
    this_nLnEstCobs   = 0
    this_nClEstCobs   = 0

    *-- Posicoes de impressao: CEP de Cobranca
    this_nLnCepCobs   = 0
    this_nClCepCobs   = 0

    *-- Posicoes de impressao: Texto do Cedente
    this_nLnTxtCds    = 0
    this_nClTxtCds    = 0

    *-- Fatores de escala para impressao matricial
    this_nNffatorln   = 0
    this_nNffatorcl   = 0

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCnFBl"
        THIS.this_cCampoChave = "FPags"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria do registro atual
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cFPags)
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarConfiguracao - Carrega configuracao de boleto para FPags informado
    *--------------------------------------------------------------------------
    PROCEDURE BuscarConfiguracao(par_cFPags)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Config")
                USE IN cursor_4c_Config
            ENDIF
            loc_cSQL = "SELECT FPags, cIdChaves, cLocals, cTxtCds, cNomeImps," + ;
                       " cFontePdrs, nTamFontes, cTamFolha," + ;
                       " nLnLocals, nClLocals, nLnDtVencs, nClDtVencs," + ;
                       " nLnDtDocs, nClDtDocs, nLnNrDocs, nClNrDocs," + ;
                       " nLnVlDocs, nClVlDocs, nLnRazClis, nClRazClis," + ;
                       " nLnCgcClis, nClCgcClis, nLnEndCobs, nClEndCobs," + ;
                       " nLnBaiCobs, nClBaiCobs, nLnCidCobs, nClCidCobs," + ;
                       " nLnEstCobs, nClEstCobs, nLnCepCobs, nClCepCobs," + ;
                       " nLnTxtCds, nClTxtCds" + ;
                       " FROM SigCnFBl" + ;
                       " WHERE FPags = " + EscaparSQL(PADR(par_cFPags, 12))
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Config")
            IF loc_nRet > 0
                IF RECCOUNT("cursor_4c_Config") > 0
                    SELECT cursor_4c_Config
                    GO TOP
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Config")
                ENDIF
            ELSE
                MsgErro("Erro ao buscar configura" + CHR(231) + CHR(227) + "o de boleto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades this_*
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAlias)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAlias)
                SELECT (par_cAlias)
                THIS.this_cFPags     = TratarNulo(FPags,      "C")
                THIS.this_cIdChaves  = TratarNulo(cIdChaves,  "C")
                THIS.this_cLocals    = TratarNulo(cLocals,    "C")
                THIS.this_cTxtCds    = TratarNulo(cTxtCds,    "C")
                THIS.this_cNomeImps  = TratarNulo(cNomeImps,  "C")
                THIS.this_cFontePdrs = TratarNulo(cFontePdrs, "C")
                THIS.this_nTamFontes = TratarNulo(nTamFontes, "N")
                THIS.this_cTamFolha  = TratarNulo(cTamFolha,  "C")
                THIS.this_nLnLocals  = TratarNulo(nLnLocals,  "N")
                THIS.this_nClLocals  = TratarNulo(nClLocals,  "N")
                THIS.this_nLnDtVencs = TratarNulo(nLnDtVencs, "N")
                THIS.this_nClDtVencs = TratarNulo(nClDtVencs, "N")
                THIS.this_nLnDtDocs  = TratarNulo(nLnDtDocs,  "N")
                THIS.this_nClDtDocs  = TratarNulo(nClDtDocs,  "N")
                THIS.this_nLnNrDocs  = TratarNulo(nLnNrDocs,  "N")
                THIS.this_nClNrDocs  = TratarNulo(nClNrDocs,  "N")
                THIS.this_nLnVlDocs  = TratarNulo(nLnVlDocs,  "N")
                THIS.this_nClVlDocs  = TratarNulo(nClVlDocs,  "N")
                THIS.this_nLnRazClis = TratarNulo(nLnRazClis, "N")
                THIS.this_nClRazClis = TratarNulo(nClRazClis, "N")
                THIS.this_nLnCgcClis = TratarNulo(nLnCgcClis, "N")
                THIS.this_nClCgcClis = TratarNulo(nClCgcClis, "N")
                THIS.this_nLnEndCobs = TratarNulo(nLnEndCobs, "N")
                THIS.this_nClEndCobs = TratarNulo(nClEndCobs, "N")
                THIS.this_nLnBaiCobs = TratarNulo(nLnBaiCobs, "N")
                THIS.this_nClBaiCobs = TratarNulo(nClBaiCobs, "N")
                THIS.this_nLnCidCobs = TratarNulo(nLnCidCobs, "N")
                THIS.this_nClCidCobs = TratarNulo(nClCidCobs, "N")
                THIS.this_nLnEstCobs = TratarNulo(nLnEstCobs, "N")
                THIS.this_nClEstCobs = TratarNulo(nClEstCobs, "N")
                THIS.this_nLnCepCobs = TratarNulo(nLnCepCobs, "N")
                THIS.this_nClCepCobs = TratarNulo(nClCepCobs, "N")
                THIS.this_nLnTxtCds  = TratarNulo(nLnTxtCds,  "N")
                THIS.this_nClTxtCds  = TratarNulo(nClTxtCds,  "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de Inserir/Atualizar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cFPags))
            THIS.this_cMensagemErro = "Condi" + CHR(231) + CHR(227) + "o de Pagamento obrigat" + CHR(243) + "ria."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere nova configuracao de boleto em SigCnFBl
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !THIS.ValidarDados()
                RETURN
            ENDIF
            loc_cSQL = "INSERT INTO SigCnFBl (" + ;
                       " FPags, cIdChaves, cLocals, cTxtCds, cNomeImps," + ;
                       " cFontePdrs, nTamFontes, cTamFolha," + ;
                       " nLnLocals, nClLocals, nLnDtVencs, nClDtVencs," + ;
                       " nLnDtDocs, nClDtDocs, nLnNrDocs, nClNrDocs," + ;
                       " nLnVlDocs, nClVlDocs, nLnRazClis, nClRazClis," + ;
                       " nLnCgcClis, nClCgcClis, nLnEndCobs, nClEndCobs," + ;
                       " nLnBaiCobs, nClBaiCobs, nLnCidCobs, nClCidCobs," + ;
                       " nLnEstCobs, nClEstCobs, nLnCepCobs, nClCepCobs," + ;
                       " nLnTxtCds, nClTxtCds" + ;
                       ") VALUES (" + ;
                       EscaparSQL(PADR(THIS.this_cFPags, 12)) + ", " + ;
                       EscaparSQL(THIS.this_cIdChaves) + ", " + ;
                       EscaparSQL(THIS.this_cLocals) + ", " + ;
                       EscaparSQL(THIS.this_cTxtCds) + ", " + ;
                       EscaparSQL(THIS.this_cNomeImps) + ", " + ;
                       EscaparSQL(THIS.this_cFontePdrs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTamFontes, 0) + ", " + ;
                       EscaparSQL(THIS.this_cTamFolha) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnLocals, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClLocals, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnDtVencs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClDtVencs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnDtDocs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClDtDocs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnNrDocs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClNrDocs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnVlDocs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClVlDocs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnRazClis, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClRazClis, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnCgcClis, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClCgcClis, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnEndCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClEndCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnBaiCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClBaiCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnCidCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClCidCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnEstCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClEstCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnCepCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClCepCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnTxtCds, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClTxtCds, 2) + ;
                       ")"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir configura" + CHR(231) + CHR(227) + "o de boleto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Salva campos editaveis (cLocals, cTxtCds) em SigCnFBl
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cFPags))
                MsgAviso("Condi" + CHR(231) + CHR(227) + "o de Pagamento n" + CHR(227) + "o selecionada.", "Aviso")
                RETURN
            ENDIF
            loc_cSQL = "UPDATE SigCnFBl SET" + ;
                       " cLocals = " + EscaparSQL(THIS.this_cLocals) + "," + ;
                       " cTxtCds = " + EscaparSQL(THIS.this_cTxtCds) + ;
                       " WHERE FPags = " + EscaparSQL(PADR(THIS.this_cFPags, 12))
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar configura" + CHR(231) + CHR(227) + "o de boleto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui configuracao de boleto de SigCnFBl
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cFPags))
                MsgAviso("Condi" + CHR(231) + CHR(227) + "o de Pagamento n" + CHR(227) + "o selecionada.", "Aviso")
                RETURN
            ENDIF
            loc_cSQL = "DELETE FROM SigCnFBl WHERE FPags = " + ;
                       EscaparSQL(PADR(THIS.this_cFPags, 12))
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("E")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir configura" + CHR(231) + CHR(227) + "o de boleto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

