# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: SISTEF, CTPTRANS, CINFOS, CIDCHAVES, CNMREDES, CNNSUS, CHEADERS, IMPS, CSTATUS, CNIDENTS, CCOMPROVS, LNCONTAQTDVIA

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
Select crSigFiTra
PROCEDURE deletetef
=seek('R'+_empr+Thisform.cOperacao+pcIdent,'SigTef','Ident')
Select SigTef
	Delete in SigTef
Select crSigFiFis
		Select CrTefImp
			Select CrTefResp
			If Seek('025') 
			Thisform.DeleteTef(crSigFiTef.cnIdents)
					SqlCanTef = [Update SigFiTef Set cStatus = 'CNC' Where cIdChaves = '] + ThisForm.pcIdChaves + [']
					Select CrTefResp
					If Seek('010') 
						SqlCanTef = [Update SigFiTef Set cStatus = 'CNC' ] + ;
				ThisForm.poDatamgr.SqlExecute(SqlCanTef)
							SELECT crSigFiTef
						Thisform.DeleteTef(crSigFiTef.cnIdents)
				Thisform.DeleteTef(crSigFiTef.cnIdents)
					SELECT crSigFiTef
	.poDatamgr.SqlExecute([Select Sistef From SigCdPam],'coSigCdPam')
	select crSigFiFis
Select coSigCdPam
	SELECT crSigFiMpF
Select crSigFiFis
	lcSql = [Select * From SigFiNfs Where Imps = ']+CrSigFiFis.Imps+[']
	If ThisForm.PodataMgr.SqlExecute(lcSql,'CrSigFiNfs') < 1
	Select CrSigFiNfs
	If !Seek( This.Value, 'CrSigFiNfs', 'cComprovs' )
	Select SigTef
	Count for ! Deleted() To lnQtdTef
				SqlCanTef = [Update SigFiTef Set cStatus = 'CNC' Where cnIdents = ']+SigTef.cnIdents+[']
				ThisForm.poDatamgr.SqlExecute(SqlCanTef)
				Select SigTef
				Delete
		Delete All
	Select CrTefImp
			Thisform.DeleteTef(crSigFiTef.cnIdents)
	lcQuery = [Select * from SigFiTef Where cIdChaves = '] + ThisForm.pcIdChaves + [']
	ThisForm.podatamgr.SqlExecute(lcQuery, [csSigFiTef])
	ThisForm.poDatamgr.SqlExecute([Select * From SigFiNfs Where Imps = ']+CrSigFiFis.Imps+[' And cComprovs = ']+csSigFiTef.cCupomnvs+['],'crTmpNFis')
		Delete File (lcarquivo)
	Select CrTefImp
	Delete all 
	Select CrTefResp
	Delete All
	Append From &lcArquivo. SDF
		If seek('012')
			Select CrTefResp
					Select CrTefResp
					Insert into CrTefImp from Memvar
					Select CrTefResp
				Select crTefImp
				Delete
		SqlCanTef = [Update SigFiTef Set cStatus = 'CNC' Where cIdChaves = '] + ThisForm.pcIdChaves + [']
		ThisForm.poDatamgr.SqlExecute(SqlCanTef)
	Select CrSigFiNfs
	Delete File (lcarquivo)
	Delete File (lcarquivo)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprtef.prg) - TRECHOS RELEVANTES PARA PASS SQL (1496 linhas total):

*-- Linhas 442 a 460:
442: 
443:             *-- Carregar configuracao fiscal (popula crSigFiFis - usado nos handlers)
444:             =fLerFiscal()
445:             SELECT crSigFiFis
446:             GO TOP
447: 
448:             IF VARTYPE(THIS.this_oModem) = "O"
449:                 *-- Ler numero de fabricacao da impressora fiscal
450:                 loc_cNoFab = LeituraFab(THIS.this_oModem)
451:                 IF VARTYPE(loc_cNoFab) = "C"
452:                     loc_cNoFabr = fDecriptografar(ALLTRIM(loc_cNoFab))
453:                     IF THIS.this_oBusinessObject.CarregarImpressoraFiscal(loc_cNoFabr)
454:                         THIS.cNoCaixa  = THIS.this_oBusinessObject.this_cNoCaixa
455:                         THIS.cNoFab    = loc_cNoFab
456:                         THIS.cOperacao = PADR(THIS.cNoCaixa + THIS.cNoFab + "ADM", 20)
457:                         loc_lOk        = .T.
458:                     ENDIF
459:                 ENDIF
460:             ENDIF

*-- Linhas 581 a 599:
581:             IF !EMPTY(ALLTRIM(THIS.txt_4c_Redetef.Value))
582:                 IF USED("crSigFiFis") AND !EOF("crSigFiFis")
583:                     IF THIS.this_oBusinessObject.BuscarComprovantes(ALLTRIM(crSigFiFis.Imps))
584:                         SELECT CrSigFiNfs
585:                         INDEX ON cComprovs TAG cComprovs
586:                         IF !SEEK(ALLTRIM(THIS.txt_4c_Redetef.Value), "CrSigFiNfs", "cComprovs")
587:                             THIS.AbrirBuscaRedetef()
588:                         ENDIF
589:                         IF USED("CrSigFiNfs") AND !EOF("CrSigFiNfs")
590:                             THIS.txt_4c_Redetef.Value = ALLTRIM(CrSigFiNfs.cComprovs)
591:                         ENDIF
592:                         THIS.txt_4c_Redetef.Refresh()
593:                     ENDIF
594:                 ENDIF
595:             ELSE
596:                 THIS.txt_4c_Redetef.Value = ""
597:                 THIS.txt_4c_Redetef.Refresh()
598:             ENDIF
599:         CATCH TO loc_oErro

*-- Linhas 615 a 633:
615:                                        ALLTRIM(THIS.txt_4c_Redetef.Value), ;
616:                                        "Sele" + CHR(231) + CHR(227) + "o", ;
617:                                        .F., .F., ;
618:                                        "Imps = " + EscaparSQL(loc_cImps))
619:             IF VARTYPE(loc_oBusca) = "O"
620:                 loc_oBusca.mAddColuna("cComprovs", "", "Rede Tef")
621:                 loc_oBusca.mAddColuna("nfinalzs",  "XXXXXXXXXX", "Finalizadora")
622:                 loc_oBusca.Show()
623:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaRedetef")
624:                     THIS.txt_4c_Redetef.Value = ALLTRIM(cursor_4c_BuscaRedetef.cComprovs)
625:                 ENDIF
626:                 loc_oBusca.Release()
627:             ENDIF
628:         CATCH TO loc_oErro
629:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro AbrirBuscaRedetef")
630:         ENDTRY
631:         IF USED("cursor_4c_BuscaRedetef")
632:             USE IN cursor_4c_BuscaRedetef
633:         ENDIF

*-- Linhas 650 a 678:
650:                 IF USED("crSigFiFis") AND !EOF("crSigFiFis")
651:                     IF THIS.this_oBusinessObject.BuscarNFiscalPorComprovante( ;
652:                             ALLTRIM(crSigFiFis.Imps), loc_lcRedeTef)
653:                         SELECT crTmpNFis
654:                         GO TOP
655:                         IF !EOF("crTmpNFis")
656:                             loc_lcDirReq = ALLTRIM(crTmpNFis.cTefdReqs)
657:                             loc_lcArq    = loc_lcDirReq + "IntPos.001"
658:                             IF FILE(loc_lcArq)
659:                                 DELETE FILE (loc_lcArq)
660:                             ENDIF
661:                             loc_lcArq = loc_lcDirReq + "IntPos.Tmp"
662:                             IF FILE(loc_lcArq)
663:                                 DELETE FILE (loc_lcArq)
664:                             ENDIF
665:                         ENDIF
666:                     ENDIF
667:                 ENDIF
668:             ENDIF
669:             WAIT CLEAR
670:         CATCH TO loc_oErro
671:             WAIT CLEAR
672:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CmdTefAtvClick")
673:         ENDTRY
674:     ENDPROC
675: 
676:     *==========================================================================
677:     PROCEDURE CmdTefAdmClick
678:     *==========================================================================

*-- Linhas 684 a 702:
684:             IF USED("CrTefImp")
685:                 USE IN CrTefImp
686:             ENDIF
687:             CREATE CURSOR CrTefImp (cinfos C(100), nordems N(2), cnIdents C(10))
688:             INDEX ON cnIdents TAG Ident
689: 
690:             loc_oFormulario = THIS.this_oModem
691:             loc_okTef       = .T.
692: 
693:             WAIT WINDOW "Aguarde Verificando TEF Ativo!!" NOWAIT
694:             loc_lcRedeTef = ALLTRIM(THIS.txt_4c_Redetef.Value)
695: 
696:             IF THIS.this_oBusinessObject.this_nSistef = 1
697:                 loc_lcTipo  = "ATV"
698:                 loc_SendTef = SigFiTefReq(THIS, THIS.cNoCaixa, go_4c_Sistema.cCodEmpresa, ;
699:                                            THIS.cOperacao, 0, 0, loc_lcTipo, 0, loc_lcRedeTef)
700:                 IF VARTYPE(loc_SendTef) = "N"
701:                     *-- ATV retornou numerico: TEF ativo
702:                 ELSE

*-- Linhas 718 a 740:
718:                 IF USED("CrTef")
719:                     USE IN CrTef
720:                 ENDIF
721:                 CREATE CURSOR CrTef (cinfos M)
722: 
723:                 IF USED("SigTef")
724:                     SELECT SigTef
725:                     COUNT FOR !DELETED() TO loc_lnQtdTef
726:                     GO TOP
727:                     IF loc_lnQtdTef = 1 AND SigTef.cStatus <> "CNF"
728:                         SCAN
729:                             IF SigTef.cCnfs = "C"
730:                                 WAIT WINDOW "Aguarde Processamento Confirma" + CHR(231) + ;
731:                                             CHR(227) + "o SITEF, Prov" + CHR(225) + ;
732:                                             "vel Queda Energia !!" NOWAIT
733:                                 loc_lcTipo = "CNF"
734:                             ELSE
735:                                 WAIT WINDOW "Aguarde Processamento Cancelamento SITEF, Prov" + ;
736:                                             CHR(225) + "vel Queda Energia !!" NOWAIT
737:                                 loc_lcTipo = "NCN"
738:                                 THIS.this_oBusinessObject.AtualizarStatusTefPorIdents( ;
739:                                     SigTef.cnIdents, "CNC")
740:                             ENDIF

*-- Linhas 750 a 778:
750:                                             VAL(STRTRAN(SigTef.cnValors, ",", ".")), ;
751:                                             VAL(SigTef.cnValors) / 100)
752:                                 ENDIF
753:                                 SELECT SigTef
754:                                 DELETE
755:                             ELSE
756:                                 MsgAviso("Problemas de comunica" + CHR(231) + ;
757:                                          CHR(227) + "o com TEF !!", "")
758:                                 loc_okTef = .F.
759:                             ENDIF
760:                         ENDSCAN
761:                     ELSE
762:                         SELECT SigTef
763:                         DELETE ALL
764:                     ENDIF
765:                 ENDIF
766: 
767:                 WAIT CLEAR
768: 
769:                 IF loc_llChecaSigTef AND USED("SigTef")
770:                     USE IN SigTef
771:                 ENDIF
772:                 IF USED("CrTef")
773:                     USE IN CrTef
774:                 ENDIF
775: 
776:                 IF USED("crSigFiFis") AND !EOF("crSigFiFis")
777:                     IF UPPER(ALLTRIM(crSigFiFis.Imps)) <> "SWEDA"
778:                         loc_VerStatus = RotStatus(1, loc_oFormulario)

*-- Linhas 792 a 828:
792:                                            THIS.cOperacao, 0, 0, loc_lcTipo, 0, loc_lcRedeTef)
793:                 WAIT CLEAR
794: 
795:                 SELECT CrTefImp
796:                 IF RECCOUNT("CrTefImp") <> 0
797:                     WAIT WINDOW "Aguarde Impress" + CHR(227) + "o !!" NOWAIT
798:                     IF VARTYPE(loc_SendTef) = "N"
799:                         loc_lnIdent = loc_SendTef
800:                         THIS.ImprFiscalProc(loc_lnIdent)
801:                     ENDIF
802:                 ELSE
803:                     IF VARTYPE(loc_SendTef) = "N"
804:                         loc_lnIdent = loc_SendTef
805:                         IF THIS.this_oBusinessObject.BuscarTransacaoTEF("R", ;
806:                                 go_4c_Sistema.cCodEmpresa, THIS.cOperacao, ;
807:                                 ALLTRIM(STR(loc_lnIdent, 20)))
808:                             THIS.ExcluirTef(crSigFiTef.cnIdents)
809:                             THIS.this_oBusinessObject.BuscarTransacaoTEF("R", ;
810:                                 go_4c_Sistema.cCodEmpresa, THIS.cOperacao, ;
811:                                 ALLTRIM(STR(loc_lnIdent, 20)))
812:                             IF USED("crSigFiTef") AND !EOF("crSigFiTef")
813:                                 SELECT crSigFiTef
814:                                 IF !EMPTY(ALLTRIM(crSigFiTef.cTxtOpers))
815:                                     MsgAviso(ALLTRIM(crSigFiTef.cTxtOpers), "")
816:                                 ENDIF
817:                                 IF !EMPTY(ALLTRIM(crSigFiTef.cTxtClis))
818:                                     MsgAviso(ALLTRIM(crSigFiTef.cTxtClis), "")
819:                                 ENDIF
820:                             ENDIF
821:                         ENDIF
822:                     ENDIF
823:                 ENDIF
824:             ENDIF
825: 
826:             WAIT CLEAR
827:             THIS.cmd_4c_TefAdm.Enabled = .T.
828: 

*-- Linhas 845 a 863:
845:             IF USED("CrTefImp")
846:                 USE IN CrTefImp
847:             ENDIF
848:             CREATE CURSOR CrTefImp (cinfos C(100), nordems N(2), cnIdents C(10))
849:             INDEX ON cnIdents TAG Ident
850: 
851:             loc_oFormulario = THIS.this_oModem
852:             loc_okTef       = .T.
853:             loc_lcNSU       = ""
854:             loc_lcFinalzs   = ""
855:             loc_llCancTef   = .F.
856:             loc_RetCVinc    = .F.
857: 
858:             =fLerFiscal()
859: 
860:             WAIT WINDOW "Aguarde Verificando TEF Ativo!!" NOWAIT
861:             loc_lcRedeTef = ALLTRIM(THIS.txt_4c_Redetef.Value)
862: 
863:             IF THIS.this_oBusinessObject.this_nSistef = 1

*-- Linhas 877 a 974:
877:                 IF USED("CrTef")
878:                     USE IN CrTef
879:                 ENDIF
880:                 CREATE CURSOR CrTef (cinfos M)
881: 
882:                 IF THIS.this_oBusinessObject.BuscarTransacaoPorIdChaves(THIS.cPcIdChaves)
883:                     SELECT csSigFiTef
884:                     GO TOP
885: 
886:                     IF THIS.this_oBusinessObject.BuscarNFiscalPorComprovante( ;
887:                             ALLTRIM(crSigFiFis.Imps), ALLTRIM(csSigFiTef.cCupomnvs))
888:                         SELECT crTmpNFis
889:                         GO TOP
890:                         loc_lcDirReq  = ALLTRIM(crTmpNFis.cTefdReqs)
891:                         loc_lcDirResp = ALLTRIM(crTmpNFis.cTefdResps)
892:                         loc_lnQtdVia  = crTmpNFis.nQtdVias
893: 
894:                         loc_lcArquivo = LOWER(loc_lcDirResp + "IntPos.001")
895:                         IF FILE(loc_lcArquivo)
896:                             DELETE FILE (loc_lcArquivo)
897:                         ENDIF
898: 
899:                         SELECT csSigFiTef
900:                         loc_lcTipo = "CNC"
901:                         TefImpr(csSigFiTef.cEmps, csSigFiTef.cDopes, VAL(csSigFiTef.cnCupoms), ;
902:                                 loc_lcTipo, VAL(csSigFiTef.cnIdents), csSigFiTef.cNmRedes, ;
903:                                 csSigFiTef.cnNSUs, csSigFiTef.cFinalzs, csSigFiTef.cCupomnvs, ;
904:                                 csSigFiTef.Fpags, VAL(csSigFiTef.cnValors) / 100)
905: 
906:                         SELECT crTmpNFis
907:                         loc_lcDirReq  = ALLTRIM(crTmpNFis.cTefdReqs)
908:                         loc_lcDirResp = ALLTRIM(crTmpNFis.cTefdResps)
909:                         loc_lnQtdVia  = crTmpNFis.nQtdVias
910:                         loc_lcArquivo = LOWER(loc_lcDirResp + "IntPos.001")
911: 
912:                         SELECT CrTefImp
913:                         DELETE ALL
914: 
915:                         IF !USED("CrTefResp")
916:                             CREATE CURSOR CrTefResp (cinfos C(100))
917:                             INDEX ON SUBSTR(CrTefResp.cInfos, 1, 3) TAG resp
918:                         ENDIF
919:                         SELECT CrTefResp
920:                         SET ORDER TO resp
921:                         DELETE ALL
922: 
923:                         APPEND FROM &loc_lcArquivo. SDF
924:                         SEEK "009"
925:                         IF ALLTRIM(SUBSTR(CrTefResp.cinfos, 11)) = "0"
926:                             loc_lcNSU = ""
927:                             IF SEEK("012")
928:                                 loc_lcNSU = SUBSTR(CrTefResp.cinfos, 11)
929:                             ENDIF
930:                             loc_lcFinalzs = ""
931:                             SEEK "027"
932:                             IF FOUND()
933:                                 loc_lcFinalzs = SUBSTR(CrTefResp.cinfos, 11)
934:                             ENDIF
935: 
936:                             FOR loc_lnContaQtdVia = 1 TO loc_lnQtdVia
937:                                 SELECT CrTefResp
938:                                 GO TOP
939:                                 SEEK "029"
940:                                 IF FOUND()
941:                                     DO WHILE CrTefResp.cInfos = "029"
942:                                         SELECT CrTefResp
943:                                         SCATTER MEMVAR
944:                                         m.cnIdents = csSigFiTef.cnIdents
945:                                         m.cinfos   = STRTRAN(SUBSTR(CrTefResp.cinfos, 11), '"', "")
946:                                         m.nvias    = loc_lnContaQtdVia
947:                                         INSERT INTO CrTefImp FROM MEMVAR
948:                                         SELECT CrTefResp
949:                                         SKIP
950:                                     ENDDO
951:                                     SELECT CrTefImp
952:                                     DELETE
953:                                 ENDIF
954:                             NEXT
955: 
956:                             loc_RetCVinc  = .F.
957:                             loc_llCancTef = .F.
958:                             DO WHILE !loc_RetCVinc
959:                                 SELECT csSigFiTef
960:                                 loc_RetCVinc = RRelGerVinc(csSigFiTef.cnIdents, loc_oFormulario)
961:                                 IF !loc_RetCVinc
962:                                     IF !MsgConfirma("Impressora N" + CHR(227) + "o Responde (1), " + ;
963:                                                     "Tentar Novamente ?", "")
964:                                         MsgInfo("Cancelamento N" + CHR(227) + "o Realizado com Sucesso," + ;
965:                                                 " Reimpress" + CHR(227) + "o pelo Modulo Administrativo", "")
966:                                         loc_llCancTef = .T.
967:                                         loc_RetCVinc  = .F.
968:                                         EXIT
969:                                     ENDIF
970:                                 ENDIF
971:                             ENDDO
972:                         ELSE
973:                             SEEK "030"
974:                             loc_lcMsg = IIF(EMPTY(ALLTRIM(SUBSTR(CrTefResp.cinfos, 11))), ;

*-- Linhas 983 a 1001:
983:                         ENDIF
984: 
985:                         IF !loc_llCancTef
986:                             SELECT csSigFiTef
987:                             loc_lcTipo = "CNF"
988:                             TefImpr(csSigFiTef.cEmps, csSigFiTef.cDopes, VAL(csSigFiTef.cnCupoms), ;
989:                                     loc_lcTipo, VAL(csSigFiTef.cnIdents), csSigFiTef.cNmRedes, ;
990:                                     loc_lcNSU, loc_lcFinalzs, csSigFiTef.cCupomnvs, csSigFiTef.Fpags)
991:                             THIS.this_oBusinessObject.AtualizarStatusTef(THIS.cPcIdChaves, "CNC")
992:                             WAIT CLEAR
993:                         ELSE
994:                             loc_lcNSU     = IIF(!EMPTY(loc_lcNSU),     loc_lcNSU,     csSigFiTef.cnNSUs)
995:                             loc_lcFinalzs = IIF(!EMPTY(loc_lcFinalzs), loc_lcFinalzs, csSigFiTef.cFinalzs)
996:                             FinFimVinc(loc_oFormulario)
997:                             DO FORM SIGCNTEF WITH csSigFiTef.cnNSUs, csSigFiTef.cNmRedes, ;
998:                                 VAL(STRTRAN(csSigFiTef.cnValors, ",", ".")) / 100
999:                             loc_lcTipo = "NCN"
1000:                             TefImpr(go_4c_Sistema.cCodEmpresa, "", 0, loc_lcTipo, ;
1001:                                     VAL(csSigFiTef.cnIdents), csSigFiTef.cNmRedes, ;

*-- Linhas 1021 a 1054:
1021:             ENDIF
1022: 
1023:             loc_nSistef = THIS.this_oBusinessObject.this_nSistef
1024:             SELECT crSigFiTef
1025: 
1026:             IF (ALLTRIM(crSigFiTef.cTpTrans) = "99" AND loc_nSistef = 1) OR loc_nSistef = 3
1027:                 loc_cHeader = SPACE(3)
1028:             ELSE
1029:                 loc_cHeader = crSigFiTef.cHeaders
1030:             ENDIF
1031: 
1032:             IF USED("crSigFiTra")
1033:                 USE IN crSigFiTra
1034:             ENDIF
1035:             loc_cSQL = "SELECT * FROM SigFiTra " + ;
1036:                        "WHERE cHeaders = " + EscaparSQL(ALLTRIM(loc_cHeader)) + ;
1037:                        " AND cTpTrans = " + EscaparSQL(ALLTRIM(crSigFiTef.cTpTrans))
1038:             IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigFiTra") > 0
1039:                 SELECT crSigFiTra
1040:                 GO TOP
1041:                 IF EOF() OR ALLTRIM(crSigFiTef.cTpTrans) = "99"
1042:                     loc_lcTran = "Outras"
1043:                 ELSE
1044:                     loc_lcTran = ALLTRIM(crSigFiTra.cTrans)
1045:                 ENDIF
1046:             ELSE
1047:                 loc_lcTran = "Outras"
1048:             ENDIF
1049: 
1050:             WITH THIS.cnt_4c_TefTxt
1051:                 .Top  = 35
1052:                 .Left = 2
1053:                 IF loc_nSistef = 1 OR loc_nSistef = 3
1054:                     IF !EMPTY(ALLTRIM(crSigFiTef.cTxtOpers))

*-- Linhas 1094 a 1150:
1094:             IF USED("SigTef")
1095:                 loc_cChave = "R" + go_4c_Sistema.cCodEmpresa + THIS.cOperacao + ALLTRIM(par_cIdent)
1096:                 =SEEK(loc_cChave, "SigTef", "Ident")
1097:                 SELECT SigTef
1098:                 IF !EOF("SigTef")
1099:                     DELETE IN SigTef
1100:                 ENDIF
1101:             ENDIF
1102:         CATCH TO loc_oErro
1103:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ExcluirTef")
1104:         ENDTRY
1105:         IF loc_llChecaSigTef AND USED("SigTef")
1106:             USE IN SigTef
1107:         ENDIF
1108:     ENDPROC
1109: 
1110:     *==========================================================================
1111:     PROTECTED PROCEDURE ImprFiscalProc(par_nIdent)
1112:     *==========================================================================
1113:         LOCAL loc_lRetCVinc, loc_lLoopCVinc, loc_lRetNImp, loc_lPrimeira, loc_lRetFim
1114:         LOCAL loc_lnValor, loc_lcCancTef, loc_lcNSUs, loc_lcTipo, loc_VerStatus
1115:         LOCAL loc_oFormulario, loc_lcRedes, loc_oErro
1116: 
1117:         TRY
1118:             IF USED("crSigFiFis")
1119:                 SELECT crSigFiFis
1120:                 GO TOP
1121:             ENDIF
1122: 
1123:             loc_oFormulario = THIS.this_oModem
1124: 
1125:             IF !EMPTY(THIS.cOperacao)
1126:                 loc_lRetCVinc  = .F.
1127:                 loc_lLoopCVinc = .T.
1128:                 loc_lPrimeira  = .T.
1129:                 loc_lRetFim    = .T.
1130: 
1131:                 DO WHILE loc_lLoopCVinc
1132:                     CLEAR TYPEAHEAD
1133:                     THIS.ProcCntTxt()
1134: 
1135:                     SELECT CrTefImp
1136:                     loc_lnValor = "0"
1137:                     GO TOP
1138:                     LOCATE FOR cinfos = " VALOR VENDA"
1139:                     IF EOF()
1140:                         LOCATE FOR cinfos = "    FINAL"
1141:                         IF !EOF()
1142:                             loc_lnValor = STRTRAN(STRTRAN(ALLTRIM(SUBSTR(cinfos, 10)), ",", ""), ".", "")
1143:                         ENDIF
1144:                     ELSE
1145:                         loc_lnValor = STRTRAN(STRTRAN(ALLTRIM(SUBSTR(cinfos, 16)), ",", ""), ".", "")
1146:                     ENDIF
1147:                     GO TOP
1148: 
1149:                     IF !loc_lPrimeira
1150:                         IF USED("crSigFiFis") AND UPPER(ALLTRIM(crSigFiFis.Imps)) = "SWEDA"

*-- Linhas 1164 a 1224:
1164:                     ENDIF
1165: 
1166:                     IF loc_lRetFim
1167:                         SELECT CrTefImp
1168:                         GO TOP
1169:                         loc_lRetCVinc = RRelGerVinc(CrTefImp.cnIdents, loc_oFormulario, THIS.cOperacao)
1170:                     ENDIF
1171: 
1172:                     loc_lPrimeira = .F.
1173:                     WITH THIS.cnt_4c_TefTxt
1174:                         .lbl_4c_TxtOper.Caption    = ""
1175:                         .lbl_4c_TxtCli.Caption     = ""
1176:                         .lbl_4c_TxtTpTrans.Caption = ""
1177:                         .Visible = .F.
1178:                     ENDWITH
1179: 
1180:                     IF loc_lRetCVinc
1181:                         loc_lcCancTef = ""
1182:                         IF USED("CrTefResp")
1183:                             SELECT CrTefResp
1184:                             GO TOP
1185:                             IF SEEK("025")
1186:                                 loc_lcCancTef = ALLTRIM(SUBSTR(CrTefResp.cinfos, 11))
1187:                             ENDIF
1188:                         ENDIF
1189: 
1190:                         IF THIS.this_oBusinessObject.BuscarTransacaoTEF("R", ;
1191:                                 go_4c_Sistema.cCodEmpresa, THIS.cOperacao, ;
1192:                                 ALLTRIM(STR(par_nIdent, 20)))
1193:                             SELECT crSigFiTef
1194:                             loc_lcNSUs = IIF(EMPTY(ALLTRIM(crSigFiTef.cnNSUCancs)), ;
1195:                                              crSigFiTef.cnNSUs, crSigFiTef.cnNSUCancs)
1196:                             loc_lcTipo = "CNF"
1197:                             TefImpr(go_4c_Sistema.cCodEmpresa, THIS.cOperacao, 0, loc_lcTipo, ;
1198:                                     VAL(crSigFiTef.cnIdents), crSigFiTef.cNmRedes, loc_lcNSUs, ;
1199:                                     crSigFiTef.cFinalzs, crSigFiTef.cCupomnvs, crSigFiTef.FPags)
1200:                             THIS.ExcluirTef(crSigFiTef.cnIdents)
1201: 
1202:                             IF !EMPTY(loc_lcCancTef)
1203:                                 IF !EMPTY(THIS.cPcIdChaves)
1204:                                     THIS.this_oBusinessObject.AtualizarStatusTef( ;
1205:                                         THIS.cPcIdChaves, "CNC")
1206:                                 ELSE
1207:                                     loc_lcRedes = ""
1208:                                     IF USED("CrTefResp")
1209:                                         SELECT CrTefResp
1210:                                         IF SEEK("010")
1211:                                             loc_lcRedes = ALLTRIM(SUBSTR(CrTefResp.cinfos, 11))
1212:                                         ENDIF
1213:                                     ENDIF
1214:                                     IF !EMPTY(loc_lcRedes)
1215:                                         THIS.this_oBusinessObject.AtualizarStatusTefPorRede( ;
1216:                                             loc_lcRedes, loc_lcCancTef, "CNC")
1217:                                     ENDIF
1218:                                 ENDIF
1219:                             ENDIF
1220:                         ENDIF
1221: 
1222:                         loc_lLoopCVinc = .F.
1223:                         loc_lRetCVinc  = .T.
1224:                         LOOP

*-- Linhas 1234 a 1283:
1234:                                         IF THIS.this_oBusinessObject.BuscarTransacaoTEF("R", ;
1235:                                                 go_4c_Sistema.cCodEmpresa, THIS.cOperacao, ;
1236:                                                 ALLTRIM(STR(par_nIdent, 20)))
1237:                                             SELECT crSigFiTef
1238:                                             DO FORM SIGCNTEF WITH crSigFiTef.cnNSUs, crSigFiTef.cNmRedes, ;
1239:                                                 VAL(loc_lnValor) / 100
1240:                                         ENDIF
1241:                                     ENDIF
1242:                                     IF THIS.this_oBusinessObject.BuscarTransacaoTEF("R", ;
1243:                                             go_4c_Sistema.cCodEmpresa, THIS.cOperacao, ;
1244:                                             ALLTRIM(STR(par_nIdent, 20)))
1245:                                         SELECT crSigFiTef
1246:                                         loc_lcTipo = "NCN"
1247:                                         TefImpr(go_4c_Sistema.cCodEmpresa, THIS.cOperacao, 0, ;
1248:                                                 loc_lcTipo, VAL(crSigFiTef.cnIdents), ;
1249:                                                 crSigFiTef.cNmRedes, crSigFiTef.cnNSUs, ;
1250:                                                 crSigFiTef.cFinalzs, crSigFiTef.cCupomnvs, ;
1251:                                                 crSigFiTef.FPags)
1252:                                         THIS.ExcluirTef(crSigFiTef.cnIdents)
1253:                                     ENDIF
1254:                                     loc_lLoopCVinc = .F.
1255:                                     loc_lRetCVinc  = .F.
1256:                                     LOOP
1257:                                 ENDIF
1258:                             ENDIF
1259:                         ENDIF
1260: 
1261:                         IF (THIS.this_oBusinessObject.this_nSistef = 1 AND ;
1262:                             !MsgConfirma("IMPRESSORA N" + CHR(195) + "O RESPONDE, TENTAR NOVAMENTE", "")) OR ;
1263:                            THIS.this_oBusinessObject.this_nSistef = 3
1264: 
1265:                             IF THIS.this_oBusinessObject.BuscarTransacaoTEF("R", ;
1266:                                     go_4c_Sistema.cCodEmpresa, THIS.cOperacao, ;
1267:                                     ALLTRIM(STR(par_nIdent, 20)))
1268:                                 SELECT crSigFiTef
1269:                                 loc_lcTipo = "NCN"
1270:                                 TefImpr(go_4c_Sistema.cCodEmpresa, THIS.cOperacao, 0, ;
1271:                                         loc_lcTipo, VAL(crSigFiTef.cnIdents), ;
1272:                                         crSigFiTef.cNmRedes, crSigFiTef.cnNSUs, ;
1273:                                         crSigFiTef.cFinalzs, crSigFiTef.cCupomnvs, ;
1274:                                         crSigFiTef.FPags)
1275:                                 THIS.ExcluirTef(crSigFiTef.cnIdents)
1276:                                 IF THIS.this_oBusinessObject.this_nSistef = 1
1277:                                     DO FORM SIGCNTEF WITH crSigFiTef.cnNSUs, crSigFiTef.cNmRedes, ;
1278:                                         VAL(loc_lnValor) / 100
1279:                                 ENDIF
1280:                             ENDIF
1281:                             loc_lLoopCVinc = .F.
1282:                             loc_lRetCVinc  = .F.
1283:                             LOOP


### BO (C:\4c\projeto\app\classes\sigprtefBO.prg):
*==============================================================================
* sigprtefBO.prg - Business Object para Administracao do TEF
* Fase 1/8 - Propriedades e Init
*==============================================================================
DEFINE CLASS sigprtefBO AS BusinessBase

    *-- Identificacao da operacao TEF
    this_cOperacao      = ""    && Operacao TEF atual (PADR NoCaixa+NoFab+'ADM', 20 chars)
    this_cNoCaixa       = ""    && Numero do caixa fiscal (crSigFiMpf.cnCaixas)
    this_cNoFab         = ""    && Numero de fabricacao da impressora fiscal (LeituraFab)
    this_cPcIdChaves    = ""    && Chaves de identificacao da transacao TEF (param Init)

    *-- Parametros do sistema TEF carregados de SigCdPam
    this_nSistef        = 0     && Tipo sistema TEF: 1=SiTef/Autoritec, 3=VeriFone
    this_cImps          = ""    && Modelo impressora fiscal (ex: SWEDA) de crSigFiFis

    *-- Campo de busca / validacao TEF
    this_cRedeTef       = ""    && Comprovante / rede TEF selecionada (Get_redetef)

    *-- Flags de controle de acesso e estado
    this_lAcessoAdm     = .F.   && Acesso habilitado para operacao Admin TEF
    this_lAcessoAtv     = .F.   && Acesso habilitado para verificacao TEF Ativo
    this_lInicializado  = .F.   && Inicializacao concluida com sucesso (impressora OK)

    PROCEDURE Init()
        this_cTabela     = ""
        this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir do cursor coSigCdPam
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                this_nSistef = NVL(Sistef, 0)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador da operacao TEF corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN this_cOperacao
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel para form OPERACIONAL TEF
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel para form OPERACIONAL TEF (usar AtualizarStatusTef)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao TEF em LogAuditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_oErro
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, UsuarioID, DataHora, ChavePrimaria) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SigFiTef") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(THIS.ObterChavePrimaria()) + ")"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametrosTEF - Carrega Sistef de SigCdPam e popula this_nSistef
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametrosTEF()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("coSigCdPam")
                USE IN coSigCdPam
            ENDIF
            loc_cSQL = "SELECT Sistef FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "coSigCdPam") > 0
                SELECT coSigCdPam
                GOTO TOP
                IF !EOF()
                    this_nSistef = NVL(Sistef, 0)
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao carregar par" + CHR(226) + "metros TEF de SigCdPam", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarImpressoraFiscal - Carrega SigFiMpF pelo numero de fabricacao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarImpressoraFiscal(par_cNoFab)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("crSigFiMpF")
                USE IN crSigFiMpF
            ENDIF
            loc_cSQL = "SELECT cnCaixas FROM SigFiMpF"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigFiMpF") > 0
                SELECT crSigFiMpF
                GOTO TOP
                IF !EOF()
                    this_cNoCaixa = NVL(cnCaixas, "")
                    this_cNoFab   = ALLTRIM(par_cNoFab)
                    loc_lSucesso  = .T.
                ELSE
                    MsgAviso("Impressora Fiscal Inv" + CHR(225) + "lida para esta Loja !!", "Aviso")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarComprovantes - Busca comprovantes TEF em SigFiNfs por modelo impressora
    *--------------------------------------------------------------------------
    PROCEDURE BuscarComprovantes(par_cImps)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("CrSigFiNfs")
                USE IN CrSigFiNfs
            ENDIF
            loc_cSQL = "SELECT * FROM SigFiNfs WHERE Imps = " + EscaparSQL(ALLTRIM(par_cImps))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "CrSigFiNfs") > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha na Conex" + CHR(227) + "o ao buscar comprovantes TEF", "Falha na Conex" + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarNFiscalPorComprovante - Busca SigFiNfs por Imps e cComprovs
    *--------------------------------------------------------------------------
    PROCEDURE BuscarNFiscalPorComprovante(par_cImps, par_cComprovs)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("crTmpNFis")
                USE IN crTmpNFis
            ENDIF
            loc_cSQL = "SELECT Imps, cComprovs, cTefdReqs, cTefdResps, nQtdVias " + ;
                       "FROM SigFiNfs " + ;
                       "WHERE Imps = " + EscaparSQL(ALLTRIM(par_cImps)) + ;
                       " AND cComprovs = " + EscaparSQL(ALLTRIM(par_cComprovs))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crTmpNFis") > 0
                SELECT crTmpNFis
                GOTO TOP
                loc_lSucesso = !EOF()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTransacaoTEF - Busca SigFiTef pelos campos chave (tipo/empresa/operacao/ident)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTransacaoTEF(par_cTipo, par_cEmps, par_cDopes, par_cIdents)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("crSigFiTef")
                USE IN crSigFiTef
            ENDIF
            loc_cSQL = "SELECT cTipos, cEmps, cDopes, cnIdents, cNmRedes, cnNSUs, " + ;
                       "cFinalzs, cCupomnvs, FPags, cnNSUCancs, cnValors, " + ;
                       "cTxtOpers, cTxtClis, cIdChaves, cStatus, cHeaders, cnCupoms " + ;
                       "FROM SigFiTef " + ;
                       "WHERE cnIdents = " + EscaparSQL(par_cIdents)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigFiTef") > 0
                SELECT crSigFiTef
                GOTO TOP
                loc_lSucesso = !EOF()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTransacaoPorIdChaves - Busca SigFiTef por cIdChaves
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTransacaoPorIdChaves(par_cIdChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("csSigFiTef")
                USE IN csSigFiTef
            ENDIF
            loc_cSQL = "SELECT cTipos, cEmps, cDopes, cnIdents, cNmRedes, cnNSUs, " + ;
                       "cFinalzs, cCupomnvs, FPags, cnNSUCancs, cnValors, " + ;
                       "cTxtOpers, cTxtClis, cIdChaves, cStatus, cHeaders, cnCupoms " + ;
                       "FROM SigFiTef " + ;
                       "WHERE cIdChaves = " + EscaparSQL(par_cIdChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "csSigFiTef") > 0
                SELECT csSigFiTef
                GOTO TOP
                loc_lSucesso = !EOF()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarStatusTef - UPDATE SigFiTef SET cStatus por cIdChaves
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarStatusTef(par_cIdChaves, par_cStatus)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigFiTef SET cStatus = " + EscaparSQL(par_cStatus) + ;
                       " WHERE cIdChaves = " + EscaparSQL(par_cIdChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                SQLCOMMIT(gnConnHandle)
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao atualizar status TEF por cIdChaves", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarStatusTefPorRede - UPDATE SigFiTef SET cStatus por cnmredes/cnnsus (CRT)
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarStatusTefPorRede(par_cNmRedes, par_cNSUs, par_cStatus)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigFiTef SET cStatus = " + EscaparSQL(par_cStatus) + ;
                       " WHERE cnmredes = " + EscaparSQL(par_cNmRedes) + ;
                       " AND cnnsus = " + EscaparSQL(par_cNSUs) + ;
                       " AND cHeaders = 'CRT'"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                SQLCOMMIT(gnConnHandle)
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao atualizar status TEF por rede", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarStatusTefPorIdents - UPDATE SigFiTef SET cStatus por cnIdents
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarStatusTefPorIdents(par_cIdents, par_cStatus)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigFiTef SET cStatus = " + EscaparSQL(par_cStatus) + ;
                       " WHERE cnIdents = " + EscaparSQL(par_cIdents)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                SQLCOMMIT(gnConnHandle)
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao atualizar status TEF por cnIdents", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

