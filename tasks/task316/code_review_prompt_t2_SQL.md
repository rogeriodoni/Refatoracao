# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CNDTTRANSI, CTIPOS, CHEADERS, DATAS, DOPES, CUPFIS, FPAGS, CNNSUS, EMPDOPNUMS, CNIDTEFS, RETSQL, CIDCHAVES

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
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
	.poDatamgr.SqlExecute([Select ncchequeps,Sistef, NumIps From SigCdPam],"crSigCdPam")
	.poDatamgr.SqlExecute([Select VerSitefs From SigCdPac],"crSigCdPac")
Select crSigCdPam
	SELECT crSigFiMpF
INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
INSERT INTO crSiTef (Tef) VALUES ("001-000 = "+STR(ltIdent,10))
INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("003-000 = "+lsValPago)
INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("010-000 = "+laCartao[VAL(lsCartao)+1])
INSERT INTO crSiTef (Tef) VALUES ("011-000 = "+lsTipTran)
INSERT INTO crSiTef (Tef) VALUES ("012-000 = "+lsNsu)
INSERT INTO crSiTef (Tef) VALUES ("013-000 = "+lsAutoriza)
INSERT INTO crSiTef (Tef) VALUES ("015-000 = "+SUBSTR(lsDataHora,7,2)+SUBSTR(lsDataHora,5,2)+SUBSTR(lsDataHora,9,6))
INSERT INTO crSiTef (Tef) VALUES ("017-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("018-000 = 1")
INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("022-000 = "+SUBSTR(lsDataHora,7,2)+SUBSTR(lsDataHora,5,2)+SUBSTR(lsDataHora,1,4))
INSERT INTO crSiTef (Tef) VALUES ("023-000 = "+SUBSTR(lsDataHora,9,6))
INSERT INTO crSiTef (Tef) VALUES ("023-000 = "+lsFinaliza)
INSERT INTO crSiTef (Tef) VALUES ("027-000 = "+SUBSTR(lsDataHora,9,6))
INSERT INTO crSiTef (Tef) VALUES ("028-000 = 27")
	INSERT INTO crSiTef (Tef) VALUES ("029-"+TRANSFORM(lnLinha,"@L 999")+" = "+IIF(lsPos<>0,SUBSTR(lsCupom,1,lsPos-1),lsCupom))
INSERT INTO crSiTef (Tef) VALUES ("030-000 = Transacao OK")
INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
SELECT crSitef 
INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
INSERT INTO crSiTef (Tef) VALUES ("001-000 = "+STR(ltIdent,10))
INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
	vSql=[Select Distinct a.Cemps, a.cDopes, a.cncupoms, a.cnIdents, a.cCupomNvs, a.cNnsus, a.cNValors, a.cnDtTrans, a.CnHrTrans, a.cStatus, a.FPags ]+;
	     [From SigFiTef a ]+;
	.SqlExecute(vSql,"Selecao")
	lcSql = [Select a.EmpDopNums, a.Notas, b.CupFis From SigMvCab a, SigCdOpe b where a.Datas Between ?llDti And ?llDtf ]+;
	.SqlExecute(lcSql,"Selecao2")
	Select Selecao2
Select Selecao
	=Seek(m.Cemps + Padr(m.Cdopes,20) + Str(Val(m.cncupoms),6),'Selecao2')
	Select Transacao
Select Transacao
	.Column1.ControlSource     = 'Transacao.cCupomnvs'
	.Column2.ControlSource     = 'Transacao.cnnsus'
	.Column3.ControlSource     = 'Transacao.cnValors'
	.Column4.ControlSource     = 'Transacao.CnDtTrans'
	.Column5.ControlSource     = 'Transacao.CnHrTrans'
	.Column6.ControlSource     = 'Transacao.CnCupoms'
	.Column7.ControlSource     = 'Transacao.cDopes'
SELECT Transacao
lcSql=[SELECT * From SigOpFp Where Fpags = ']+Transacao.FPags+[']
ThisFOrm.poDatamgr.SqlExecute(lcSql,"csSigOpFp")
SELECT Transacao
	lcSql=[Update SigFiTef set cStatus = 'CNC', UsuCancs = ']+Usuar+[' Where ctipos = 'R' And cHeaders='CRT' AND CNNSUS = ']+ALLTRIM(Transacao.cnnsus)+[']
	RetSql=ThisFOrm.poDatamgr.SqlExecute(lcSql)
	lcSql=[Select EmpDopNums,Valos,CnIdTefs,cidChaves From SigMvPar where EmpDopNums = ']+Transacao.EmpDopNums+[']
	ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalPar')
	Select LocalPar
		lcsql = [Update SigMvPar Set lCancelas = ?llTrue Where CidChaves = ']+LocalPar.Cidchaves+[']
		RetSql = ThisForm.Podatamgr.sqlexecute(lcSql,'')
SELECT Transacao
SELECT Transacao
lcSql=[SELECT * From SigOpFp Where Fpags = ']+Transacao.FPags+[']
ThisFOrm.poDatamgr.SqlExecute(lcSql,"csSigOpFp")
SELECT Transacao
SELECT Transacao
lcSql=[SELECT * From SigOpFp Where Fpags = ']+Transacao.FPags+[']
ThisFOrm.poDatamgr.SqlExecute(lcSql,"csSigOpFp")
Select Transacao
SELECT Transacao

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigproef.prg) - TRECHOS RELEVANTES PARA PASS SQL (1220 linhas total):

*-- Linhas 171 a 189:
171:     *====================================================================
172:     PROCEDURE ObterNsuRetorno()
173:         IF USED("Transacao")
174:             SELECT Transacao
175:             IF !EOF()
176:                 RETURN ALLTRIM(NVL(cnnsus, ""))
177:             ENDIF
178:         ENDIF
179:         RETURN ""
180:     ENDPROC
181: 
182:     *====================================================================
183:     * Destroy - Libera recursos e cursores
184:     *====================================================================
185:     PROCEDURE Destroy()
186:         LOCAL loc_oErro
187:         TRY
188:             THIS.this_cNsuRetorno = THIS.ObterNsuRetorno()
189: 

*-- Linhas 241 a 259:
241:                 .Height        = 230
242:                 .ColumnCount   = 7
243:                 .ReadOnly      = .T.
244:                 .DeleteMark    = .F.
245:                 .RecordMark    = .F.
246:                 .ScrollBars    = 2
247:                 .FontName      = "Tahoma"
248:                 .FontSize      = 8
249:                 .GridLineColor = RGB(192, 192, 192)
250:                 .HeaderHeight  = 16
251:                 .RowHeight     = 15
252:                 .Visible       = .T.
253:             ENDWITH
254: 
255:             *-- Cabecalhos iniciais das colunas (definidos antes de RecordSource para
256:             *-- evitar cabecalhos genericos "Column1/Column2" enquanto SqlTrans carrega)
257:             WITH loc_oCnt.grd_4c_Dados
258:                 .ColumnCount                  = 7
259:                 .Column1.Width                = 70

*-- Linhas 539 a 557:
539:             RETURN
540:         ENDIF
541: 
542:         SELECT Transacao
543:         IF EOF()
544:             MsgAviso("Selecione uma transa" + CHR(231) + CHR(227) + ;
545:                      "o na grade antes de alterar.", "Aviso")
546:             RETURN
547:         ENDIF
548: 
549:         IF ALLTRIM(Transacao.cStatus) = "CNC"
550:             MsgAviso("Transa" + CHR(231) + CHR(227) + "o cancelada n" + CHR(227) + ;
551:                      "o pode ser alterada.", "Aviso")
552:             RETURN
553:         ENDIF
554: 
555:         THIS.BtnReimprimirClick()
556:     ENDPROC
557: 

*-- Linhas 568 a 586:
568:             RETURN
569:         ENDIF
570: 
571:         SELECT Transacao
572:         IF EOF()
573:             MsgAviso("Selecione uma transa" + CHR(231) + CHR(227) + ;
574:                      "o na grade antes de visualizar.", "Aviso")
575:             RETURN
576:         ENDIF
577: 
578:         THIS.BtnUltimoClick()
579:     ENDPROC
580: 
581:     *====================================================================
582:     * BtnExcluirClick - Cancela transacao TEF selecionada
583:     * Semantica CRUD "Excluir" mapeada para BtnCancelaClick. Cancelamento
584:     * de TEF nao remove fisicamente o registro (integridade fiscal); marca
585:     * cStatus='CNC', grava usuario cancelante em UsuCancs e reverte parcelas
586:     * em SigMvPar via lCancelas=.T. (padrao SigOpCtf/SigTfCan).

*-- Linhas 592 a 610:
592:             RETURN
593:         ENDIF
594: 
595:         SELECT Transacao
596:         IF EOF()
597:             MsgAviso("Selecione uma transa" + CHR(231) + CHR(227) + ;
598:                      "o na grade antes de cancelar.", "Aviso")
599:             RETURN
600:         ENDIF
601: 
602:         THIS.BtnCancelaClick()
603:     ENDPROC
604: 
605:     *====================================================================
606:     * SqlTrans - Carrega transacoes TEF no periodo e configura o grid
607:     * Equivalente ao sqltrans do form original
608:     *====================================================================
609:     PROCEDURE SqlTrans()
610:         LOCAL loc_lResultado, loc_dDtI, loc_dDtF, loc_oGrid

*-- Linhas 631 a 710:
631:                 loc_oGrid.ColumnCount  = 7
632:                 loc_oGrid.ReadOnly     = .T.
633: 
634:                 loc_oGrid.Column1.ControlSource    = "Transacao.cCupomNvs"
635:                 loc_oGrid.Column1.Width            = 70
636:                 loc_oGrid.Column1.FontSize         = 8
637:                 loc_oGrid.Column1.Movable          = .F.
638:                 loc_oGrid.Column1.Resizable        = .F.
639:                 loc_oGrid.Column1.ReadOnly         = .T.
640:                 loc_oGrid.Column1.Header1.Caption  = "Rede"
641:                 loc_oGrid.Column1.Header1.Alignment = 2
642:                 loc_oGrid.Column1.Header1.FontSize  = 8
643: 
644:                 loc_oGrid.Column2.ControlSource    = "Transacao.cnnsus"
645:                 loc_oGrid.Column2.Width            = 78
646:                 loc_oGrid.Column2.FontSize         = 8
647:                 loc_oGrid.Column2.Movable          = .F.
648:                 loc_oGrid.Column2.Resizable        = .F.
649:                 loc_oGrid.Column2.ReadOnly         = .T.
650:                 loc_oGrid.Column2.Header1.Caption  = "N.Autorizacao"
651:                 loc_oGrid.Column2.Header1.Alignment = 2
652:                 loc_oGrid.Column2.Header1.FontSize  = 8
653: 
654:                 loc_oGrid.Column3.ControlSource    = "Transacao.cnValors"
655:                 loc_oGrid.Column3.Width            = 75
656:                 loc_oGrid.Column3.FontSize         = 8
657:                 loc_oGrid.Column3.Movable          = .F.
658:                 loc_oGrid.Column3.Resizable        = .F.
659:                 loc_oGrid.Column3.ReadOnly         = .T.
660:                 loc_oGrid.Column3.Header1.Caption  = "Valor"
661:                 loc_oGrid.Column3.Header1.Alignment = 2
662:                 loc_oGrid.Column3.Header1.FontSize  = 8
663: 
664:                 loc_oGrid.Column4.ControlSource    = "Transacao.cnDtTrans"
665:                 loc_oGrid.Column4.Width            = 65
666:                 loc_oGrid.Column4.FontSize         = 8
667:                 loc_oGrid.Column4.Movable          = .F.
668:                 loc_oGrid.Column4.Resizable        = .F.
669:                 loc_oGrid.Column4.ReadOnly         = .T.
670:                 loc_oGrid.Column4.Alignment        = 2
671:                 loc_oGrid.Column4.Header1.Caption  = "Data"
672:                 loc_oGrid.Column4.Header1.Alignment = 2
673:                 loc_oGrid.Column4.Header1.FontSize  = 8
674: 
675:                 loc_oGrid.Column5.ControlSource    = "Transacao.CnHrTrans"
676:                 loc_oGrid.Column5.Width            = 55
677:                 loc_oGrid.Column5.FontSize         = 8
678:                 loc_oGrid.Column5.Movable          = .F.
679:                 loc_oGrid.Column5.Resizable        = .F.
680:                 loc_oGrid.Column5.ReadOnly         = .T.
681:                 loc_oGrid.Column5.Header1.Caption  = "Header1"
682:                 loc_oGrid.Column5.Header1.Alignment = 2
683:                 loc_oGrid.Column5.Header1.FontSize  = 8
684: 
685:                 loc_oGrid.Column6.ControlSource    = "Transacao.cnCupoms"
686:                 loc_oGrid.Column6.Width            = 60
687:                 loc_oGrid.Column6.FontSize         = 8
688:                 loc_oGrid.Column6.Movable          = .F.
689:                 loc_oGrid.Column6.Resizable        = .F.
690:                 loc_oGrid.Column6.ReadOnly         = .T.
691:                 loc_oGrid.Column6.Header1.Caption  = "Header1"
692:                 loc_oGrid.Column6.Header1.Alignment = 2
693:                 loc_oGrid.Column6.Header1.FontSize  = 8
694: 
695:                 loc_oGrid.Column7.ControlSource    = "Transacao.cDopes"
696:                 loc_oGrid.Column7.Width            = 120
697:                 loc_oGrid.Column7.FontSize         = 8
698:                 loc_oGrid.Column7.Movable          = .F.
699:                 loc_oGrid.Column7.Resizable        = .F.
700:                 loc_oGrid.Column7.ReadOnly         = .T.
701:                 loc_oGrid.Column7.Header1.Caption  = "Header1"
702:                 loc_oGrid.Column7.Header1.Alignment = 2
703:                 loc_oGrid.Column7.Header1.FontSize  = 8
704: 
705:                 loc_oGrid.SetAll("DynamicForeColor", ;
706:                     "IIF(Transacao.lCancel, RGB(255,0,0), RGB(0,0,0))", "Column")
707:                 loc_oGrid.Refresh()
708:                 loc_oGrid.SetFocus()
709:             ENDIF
710: 

*-- Linhas 780 a 798:
780:             RETURN
781:         ENDIF
782: 
783:         SELECT Transacao
784:         IF EOF()
785:             MsgAviso("N" + CHR(227) + "o existem transa" + CHR(231) + CHR(245) + "es efetuadas", "Aviso")
786:             RETURN
787:         ENDIF
788: 
789:         TRY
790:             loc_nResposta = SigPrTef( ;
791:                 THIS.this_oBusinessObject.this_cNumIps, ;
792:                 110, ;
793:                 Transacao.cnValors, ;
794:                 "1", ;
795:                 THIS.this_oBusinessObject.this_cCnCaixas, ;
796:                 .NULL., ;
797:                 "SW000001", ;
798:                 0)

*-- Linhas 814 a 832:
814:             RETURN
815:         ENDIF
816: 
817:         SELECT Transacao
818:         IF EOF()
819:             MsgAviso("N" + CHR(227) + "o existem transa" + CHR(231) + CHR(245) + "es efetuadas", "Aviso")
820:             RETURN
821:         ENDIF
822: 
823:         TRY
824:             THIS.this_oBusinessObject.CarregarPagamentoFP(ALLTRIM(Transacao.FPags))
825: 
826:             loc_cNSU  = ALLTRIM(Transacao.cnnsus)
827:             loc_cData = DTOC(Transacao.cnDtTrans)
828:             loc_cData = SUBSTR(loc_cData, 1, 2) + SUBSTR(loc_cData, 4, 2) + SUBSTR(loc_cData, 7, 4)
829:             SKIP
830: 
831:             IF ALLTRIM(THIS.this_oBusinessObject.this_cVerSitefs) = "4.1"
832:                 DO FORM SigPrOer WITH ;

*-- Linhas 843 a 884:
843:             ENDIF
844: 
845:             IF USED("Transacao")
846:                 SELECT Transacao
847:                 GO BOTTOM
848:             ENDIF
849: 
850:         CATCH TO loc_oErro
851:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
852:                     " PROC=" + loc_oErro.Procedure, "Erro " + CHR(218) + "ltimo")
853:         ENDTRY
854: 
855:         THIS.Release()
856:     ENDPROC
857: 
858:     *====================================================================
859:     * BtnReimprimirClick - Reimprime comprovante TEF (F4)
860:     *====================================================================
861:     PROCEDURE BtnReimprimirClick()
862:         LOCAL loc_cNSU, loc_cData
863: 
864:         IF !USED("Transacao")
865:             MsgAviso("N" + CHR(227) + "o existem transa" + CHR(231) + CHR(245) + "es efetuadas", "Aviso")
866:             RETURN
867:         ENDIF
868: 
869:         SELECT Transacao
870:         IF EOF()
871:             MsgAviso("N" + CHR(227) + "o existem transa" + CHR(231) + CHR(245) + "es efetuadas", "Aviso")
872:             RETURN
873:         ENDIF
874: 
875:         IF ALLTRIM(Transacao.cStatus) = "CNC"
876:             MsgAviso("Transa" + CHR(231) + CHR(227) + "o cancelada", "Aviso")
877:             RETURN
878:         ENDIF
879: 
880:         TRY
881:             loc_cNSU  = ALLTRIM(Transacao.cnnsus)
882:             loc_cData = DTOC(Transacao.cnDtTrans)
883:             loc_cData = SUBSTR(loc_cData, 1, 2) + SUBSTR(loc_cData, 4, 2) + SUBSTR(loc_cData, 7, 4)
884:             SKIP

*-- Linhas 902 a 943:
902:             ENDIF
903: 
904:             IF USED("Transacao")
905:                 SELECT Transacao
906:                 SKIP -1
907:             ENDIF
908: 
909:         CATCH TO loc_oErro
910:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
911:                     " PROC=" + loc_oErro.Procedure, "Erro Reimprimir")
912:         ENDTRY
913: 
914:         THIS.Release()
915:     ENDPROC
916: 
917:     *====================================================================
918:     * BtnCancelaClick - Cancela transacao TEF selecionada (F5)
919:     *====================================================================
920:     PROCEDURE BtnCancelaClick()
921:         LOCAL loc_lCancel, loc_cData
922: 
923:         IF !USED("Transacao")
924:             MsgAviso("N" + CHR(227) + "o existem transa" + CHR(231) + CHR(245) + "es efetuadas", "Aviso")
925:             RETURN
926:         ENDIF
927: 
928:         SELECT Transacao
929:         IF EOF()
930:             MsgAviso("N" + CHR(227) + "o existem transa" + CHR(231) + CHR(245) + "es efetuadas", "Aviso")
931:             RETURN
932:         ENDIF
933: 
934:         IF ALLTRIM(Transacao.cStatus) = "CNC"
935:             MsgAviso("Transa" + CHR(231) + CHR(227) + "o j" + CHR(225) + " cancelada", "Aviso")
936:             RETURN
937:         ENDIF
938: 
939:         IF Transacao.CupFis = 3
940:             IF !MsgConfirma("Aten" + CHR(231) + CHR(227) + "o! Esta " + CHR(233) + " uma opera" + ;
941:                             CHR(231) + CHR(227) + "o de Cupom N" + CHR(227) + "o Fiscal." + CHR(13) + ;
942:                             "Deseja realmente continuar com o cancelamento?")
943:                 RETURN

*-- Linhas 1027 a 1095:
1027:         IF USED("crSiTef")
1028:             USE IN crSiTef
1029:         ENDIF
1030:         CREATE CURSOR crSiTef (tef C(100))
1031: 
1032:         INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
1033:         INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + TRANSFORM(THIS.this_cOperacao))
1034:         INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
1035:         INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_sValPago)
1036:         INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
1037:         INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")
1038:         INSERT INTO crSiTef (Tef) VALUES ("010-000 = " + loc_aCartao[VAL(par_sCartao) + 1])
1039:         INSERT INTO crSiTef (Tef) VALUES ("011-000 = " + par_sTipTran)
1040:         INSERT INTO crSiTef (Tef) VALUES ("012-000 = " + par_sNsu)
1041:         INSERT INTO crSiTef (Tef) VALUES ("013-000 = " + par_sAutoriza)
1042:         INSERT INTO crSiTef (Tef) VALUES ("015-000 = " + ;
1043:             SUBSTR(par_sDataHora, 7, 2) + SUBSTR(par_sDataHora, 5, 2) + SUBSTR(par_sDataHora, 9, 6))
1044:         INSERT INTO crSiTef (Tef) VALUES ("017-000 = 0")
1045:         INSERT INTO crSiTef (Tef) VALUES ("018-000 = 1")
1046:         INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
1047:         INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
1048:         INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
1049:         INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
1050:         INSERT INTO crSiTef (Tef) VALUES ("022-000 = " + ;
1051:             SUBSTR(par_sDataHora, 7, 2) + SUBSTR(par_sDataHora, 5, 2) + SUBSTR(par_sDataHora, 1, 4))
1052:         INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + SUBSTR(par_sDataHora, 9, 6))
1053:         INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + par_sFinaliza)
1054:         INSERT INTO crSiTef (Tef) VALUES ("027-000 = " + SUBSTR(par_sDataHora, 9, 6))
1055:         INSERT INTO crSiTef (Tef) VALUES ("028-000 = 27")
1056: 
1057:         loc_sPos       = 1
1058:         loc_nLinha     = 1
1059:         loc_sCupomTemp = par_sCupom
1060: 
1061:         DO WHILE loc_sPos <> 0
1062:             loc_sPos = AT(CHR(10), loc_sCupomTemp)
1063:             INSERT INTO crSiTef (Tef) VALUES ( ;
1064:                 "029-" + TRANSFORM(loc_nLinha, "@L 999") + " = " + ;
1065:                 IIF(loc_sPos <> 0, SUBSTR(loc_sCupomTemp, 1, loc_sPos - 1), loc_sCupomTemp))
1066:             loc_sCupomTemp = SUBSTR(loc_sCupomTemp, loc_sPos + 1)
1067:             loc_nLinha     = loc_nLinha + 1
1068:         ENDDO
1069: 
1070:         INSERT INTO crSiTef (Tef) VALUES ("030-000 = Transacao OK")
1071:         INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
1072:         INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
1073: 
1074:         SELECT crSiTef
1075:         COPY TO C:\client\Resp\IntPos.001 SDF
1076:         ZAP
1077: 
1078:         INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
1079:         INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + TRANSFORM(THIS.this_cOperacao))
1080:         INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
1081: 
1082:         COPY TO C:\client\Resp\IntPos.STS SDF
1083: 
1084:         USE IN crSiTef
1085:     ENDPROC
1086: 
1087:     *====================================================================
1088:     * CarregarLista - Compatibilidade CRUD: recarrega grid de transacoes
1089:     *====================================================================
1090:     PROCEDURE CarregarLista()
1091:         RETURN THIS.SqlTrans()
1092:     ENDPROC
1093: 
1094:     *====================================================================
1095:     * BtnBuscarClick - Recarrega transacoes com o periodo informado


### BO (C:\4c\projeto\app\classes\sigproefBO.prg):
*====================================================================
* sigproefBO.prg
* Business Object para Selecao de Transacao TEF (sigproef)
* Tabela principal: SigOpFp | Chave: Fpags
*====================================================================

DEFINE CLASS sigproefBO AS BusinessBase

    *-- ===================================================================
    *-- IDENTIFICACAO DA ENTIDADE
    *-- ===================================================================
    this_cTabela     = "SigOpFp"
    this_cCampoChave = "Fpags"

    *-- ===================================================================
    *-- CONFIGURACAO DE HARDWARE - SigCdPam
    *-- ===================================================================
    this_nNcChequeps = 0
    this_nSistef     = 0
    this_cNumIps     = ""

    *-- ===================================================================
    *-- CONFIGURACAO DO SISTEMA - SigCdPac
    *-- ===================================================================
    this_cVerSitefs  = ""

    *-- ===================================================================
    *-- IMPRESSORA FISCAL - SIGFIMPF
    *-- ===================================================================
    this_cCImpFabs   = ""
    this_cCnCaixas   = ""

    *-- ===================================================================
    *-- ESTADO OPERACIONAL DO FORM
    *-- ===================================================================
    this_cOperacao   = ""
    this_cNoCaixa    = ""
    this_cNoFab      = ""
    this_lCancelaVisivel = .F.

    *-- ===================================================================
    *-- FILTRO DE PERIODO
    *-- ===================================================================
    this_dDataInicial = {}
    this_dDataFinal   = {}

    *-- ===================================================================
    *-- PAGAMENTO FP - SigOpFp (campos usados pelo form)
    *-- ===================================================================
    this_cCodEstabs   = ""

    *-- ===================================================================
    *-- TRANSACAO CORRENTE (campos do cursor Transacao)
    *-- ===================================================================
    this_cDopes       = ""
    this_cCnCupoms    = ""
    this_cCCupomNvs   = ""
    this_cCnNsus      = ""
    this_nCnValors    = 0
    this_dCnDtTrans   = {}
    this_cCnHrTrans   = ""
    this_cStatus      = ""
    this_cFPags       = ""
    this_lCancel      = .F.
    this_nCupFis      = 0
    this_cEmpDopNums  = ""
    this_cCnIdents    = ""

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigOpFp"
            THIS.this_cCampoChave = "Fpags"

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CarregarConfiguracao - Carrega SigCdPam e SigCdPac em cursores
    * Chamado pelo form apos conexao estabelecida
    *====================================================================
    PROCEDURE CarregarConfiguracao()
        LOCAL loc_lResultado, loc_nRes
        loc_lResultado = .F.

        TRY
            loc_nRes = SQLEXEC(gnConnHandle, ;
                "SELECT ncchequeps, Sistef, NumIps FROM SigCdPam", ;
                "crSigCdPam")
            IF loc_nRes < 0
                THIS.this_cMensagemErro = "Erro ao carregar SigCdPam"
                loc_lResultado = .F.
            ENDIF

            loc_nRes = SQLEXEC(gnConnHandle, ;
                "SELECT VerSitefs FROM SigCdPac", ;
                "crSigCdPac")
            IF loc_nRes < 0
                THIS.this_cMensagemErro = "Erro ao carregar SigCdPac"
                loc_lResultado = .F.
            ENDIF

            IF USED("crSigCdPam")
                SELECT crSigCdPam
                GO TOP
                THIS.this_nNcChequeps = NVL(ncchequeps, 0)
                THIS.this_nSistef     = NVL(Sistef, 0)
                THIS.this_cNumIps     = ALLTRIM(NVL(NumIps, ""))
            ENDIF

            IF USED("crSigCdPac")
                SELECT crSigCdPac
                GO TOP
                THIS.this_cVerSitefs  = ALLTRIM(NVL(VerSitefs, ""))
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CarregarImpressoraFiscal - Carrega SIGFIMPF pelo numero de fabricacao
    * par_cNoFab: numero de fabricacao da impressora (cImpFabs)
    *====================================================================
    PROCEDURE CarregarImpressoraFiscal(par_cNoFab)
        LOCAL loc_lResultado, loc_nRes, loc_cSQL
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cImpFabs, CnCaixas FROM SIGFIMPF"

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "crSigFiMpF")

            IF loc_nRes >= 0 AND USED("crSigFiMpF")
                SELECT crSigFiMpF
                IF !EOF()
                    THIS.this_cCImpFabs = ALLTRIM(NVL(cImpFabs, ""))
                    THIS.this_cCnCaixas = ALLTRIM(NVL(CnCaixas, ""))
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Impressora Fiscal inv" + CHR(225) + "lida para esta Loja"
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar impressora fiscal"
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * BuscarTransacoes - Busca transacoes TEF no periodo informado
    * Equivalente ao metodo SqlTrans do form original
    * Popula cursor "Transacao" com os dados formatados
    *====================================================================
    PROCEDURE BuscarTransacoes(par_dDataInicial, par_dDataFinal)
        LOCAL loc_lResultado, loc_nRes, loc_cSQL
        LOCAL loc_cDtI, loc_cDtF, loc_cDtISQL, loc_cDtFSQL
        loc_lResultado = .F.

        TRY
            THIS.this_dDataInicial = par_dDataInicial
            THIS.this_dDataFinal   = par_dDataFinal

            loc_cDtI    = DTOS(par_dDataInicial)
            loc_cDtF    = DTOS(par_dDataFinal)
            loc_cDtISQL = FormatarDataSQL(par_dDataInicial)
            loc_cDtFSQL = FormatarDataSQL(par_dDataFinal)

            loc_cSQL = "SELECT DISTINCT a.Cemps, a.cDopes, a.cncupoms, a.cnIdents, " + ;
                       "a.cCupomNvs, a.cNnsus, a.cNValors, a.cnDtTrans, " + ;
                       "a.CnHrTrans, a.cStatus, a.FPags " + ;
                       "FROM SigFiTef a " + ;
                       "WHERE cndttransI BETWEEN " + EscaparSQL(loc_cDtI) + " AND " + EscaparSQL(loc_cDtF) + " " + ;
                       "AND a.ctipos = 'R' " + ;
                       "AND (a.cHeaders = 'CRT' OR a.cHeaders = 'CHQ') " + ;
                       "AND NOT a.cnnsus = '   ' " + ;
                       "ORDER BY a.cnDtTrans, a.CnHrTrans"

            IF USED("Selecao")
                USE IN Selecao
            ENDIF
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "Selecao")
            IF loc_nRes < 0
                THIS.this_cMensagemErro = "Erro ao buscar transa" + CHR(231) + CHR(245) + "es TEF"
                loc_lResultado = .F.
            ENDIF

            loc_cSQL = "SELECT a.EmpDopNums, a.Notas, b.CupFis " + ;
                       "FROM SigMvCab a, SigCdOpe b " + ;
                       "WHERE a.Datas BETWEEN " + loc_cDtISQL + " AND " + loc_cDtFSQL + " " + ;
                       "AND a.dopes = b.dopes " + ;
                       "AND b.Cupfis IN (1, 3)"

            IF USED("Selecao2")
                USE IN Selecao2
            ENDIF
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "Selecao2")
            IF loc_nRes < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados de cupom"
                loc_lResultado = .F.
            ENDIF

            SELECT Selecao2
            INDEX ON EmpDopNums TAG EmpDopNums

            IF USED("Transacao")
                USE IN Transacao
            ENDIF
            CREATE CURSOR Transacao ( ;
                cDopes      C(20), ;
                cnCupoms    C(10), ;
                cCupomNvs   C(20), ;
                cnnsus      C(12), ;
                cnValors    N(12,2), ;
                cnDtTrans   D, ;
                CnHrTrans   C(8), ;
                cStatus     C(3), ;
                FPags       C(12), ;
                lCancel     L, ;
                CupFis      N(1), ;
                EmpDopNums  C(29), ;
                cnIdents    C(10) ;
            )
            INDEX ON cnDtTrans TAG Datas

            SELECT Selecao
            SCAN
                SCATTER MEMVAR
                m.CnHrTrans = TRANSFORM(m.CnHrTrans, "@R xx:xx:xx")
                m.CnValors  = ROUND(VAL(STRTRAN(m.cnValors, ',', '')) / 100, 2)
                m.CnDtTrans = CTOD(SUBSTR(m.CnDtTrans, 1, 2) + '/' + ;
                              SUBSTR(m.CnDtTrans, 3, 2) + '/' + ;
                              RIGHT(m.CnDtTrans, 4))

                =SEEK(m.Cemps + PADR(m.Cdopes, 20) + STR(VAL(m.cncupoms), 6), 'Selecao2')

                IF !EOF('Selecao2')
                    m.cnCupoms   = Selecao2.Notas
                    m.CupFis     = Selecao2.CupFis
                    m.EmpDopNums = Selecao2.EmpDopNums
                ELSE
                    m.cnCupoms   = ""
                    m.CupFis     = 0
                    m.EmpDopNums = ""
                ENDIF

                SELECT Transacao
                APPEND BLANK
                GATHER MEMVAR
                REPLACE cnnsus   WITH SUBSTR(cnnsus, 1, 12)
                REPLACE lCancel  WITH IIF(cStatus = "CNC", .T., .F.)
            ENDSCAN

            SELECT Transacao
            GO BOTTOM

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CarregarPagamentoFP - Carrega dados de SigOpFp para transacao corrente
    * par_cFPags: chave Fpags da transacao
    *====================================================================
    PROCEDURE CarregarPagamentoFP(par_cFPags)
        LOCAL loc_lResultado, loc_nRes, loc_cSQL
        loc_lResultado = .F.

        TRY
            IF USED("csSigOpFp")
                USE IN csSigOpFp
            ENDIF

            loc_cSQL = "SELECT * FROM SigOpFp WHERE Fpags = " + EscaparSQL(par_cFPags)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "csSigOpFp")

            IF loc_nRes >= 0
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar pagamento"
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CancelarTransacao - Cancela transacao TEF selecionada
    * Atualiza SigFiTef e SigMvPar
    * par_cCnNsus:     NSU da transacao
    * par_cEmpDopNums: chave EmpDopNums para SigMvPar
    * par_cCnIdents:   identidade da transacao em SigMvPar
    *====================================================================
    PROCEDURE CancelarTransacao(par_cCnNsus, par_cEmpDopNums, par_cCnIdents)
        LOCAL loc_lResultado, loc_nRes, loc_cSQL
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigFiTef SET cStatus = 'CNC', " + ;
                       "UsuCancs = " + EscaparSQL(gc_4c_UsuarioLogado) + " " + ;
                       "WHERE ctipos = 'R' AND cHeaders = 'CRT' " + ;
                       "AND CNNSUS = " + EscaparSQL(ALLTRIM(par_cCnNsus))

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRes > 0
                loc_cSQL = "SELECT EmpDopNums, Valos, CnIdTefs, cidChaves " + ;
                           "FROM SigMvPar WHERE EmpDopNums = " + EscaparSQL(par_cEmpDopNums)

                IF USED("LocalPar")
                    USE IN LocalPar
                ENDIF
                SQLEXEC(gnConnHandle, loc_cSQL, "LocalPar")

                SELECT LocalPar
                LOCATE FOR CnIdTefs = par_cCnIdents
                IF !EOF() AND loc_nRes > 0
                    loc_cSQL = "UPDATE SigMvPar SET lCancelas = 1 " + ;
                               "WHERE CidChaves = " + EscaparSQL(LocalPar.Cidchaves)
                    loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)
                ENDIF

                IF loc_nRes > 0
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao atualizar SigMvPar"
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao cancelar em SigFiTef"
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CarregarTransacaoCorrente - Preenche this_* com dados da linha do grid
    * par_cAlias: alias do cursor Transacao (normalmente "Transacao")
    *====================================================================
    PROCEDURE CarregarTransacaoCorrente(par_cAlias)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAlias)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAlias)
            IF EOF()
                loc_lResultado = .F.
            ENDIF

            THIS.this_cDopes      = ALLTRIM(NVL(cDopes, ""))
            THIS.this_cCnCupoms   = ALLTRIM(NVL(cnCupoms, ""))
            THIS.this_cCCupomNvs  = ALLTRIM(NVL(cCupomNvs, ""))
            THIS.this_cCnNsus     = ALLTRIM(NVL(cnnsus, ""))
            THIS.this_nCnValors   = NVL(cnValors, 0)
            THIS.this_dCnDtTrans  = NVL(cnDtTrans, {})
            THIS.this_cCnHrTrans  = ALLTRIM(NVL(CnHrTrans, ""))
            THIS.this_cStatus     = ALLTRIM(NVL(cStatus, ""))
            THIS.this_cFPags      = ALLTRIM(NVL(FPags, ""))
            THIS.this_lCancel     = NVL(lCancel, .F.)
            THIS.this_nCupFis     = NVL(CupFis, 0)
            THIS.this_cEmpDopNums = ALLTRIM(NVL(EmpDopNums, ""))
            THIS.this_cCnIdents   = ALLTRIM(NVL(cnIdents, ""))

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega campos de SigOpFp nas propriedades this_*
    * par_cAliasCursor: alias do cursor com dados de SigOpFp (ex: csSigOpFp)
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)
            IF EOF()
                loc_lResultado = .F.
            ENDIF

            THIS.this_cFPags     = ALLTRIM(NVL(Fpags, ""))
            THIS.this_cCodEstabs = ALLTRIM(NVL(CodEstabs, ""))

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna valor da chave para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cFPags
    ENDPROC

    *====================================================================
    * Inserir - Insere transacao no cursor local Transacao
    * Usado para registrar transacoes TEF processadas pelo form
    * Preenche todos os campos usando as propriedades this_*
    *====================================================================
    PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cValFmt
        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cFPags)
                THIS.this_cMensagemErro = "Forma de pagamento (Fpags) obrigat" + CHR(243) + "ria"
                loc_lResultado = .F.
            ENDIF

            IF !USED("Transacao")
                CREATE CURSOR Transacao ( ;
                    cDopes      C(20), ;
                    cnCupoms    C(10), ;
                    cCupomNvs   C(20), ;
                    cnnsus      C(12), ;
                    cnValors    N(12,2), ;
                    cnDtTrans   D, ;
                    CnHrTrans   C(8), ;
                    cStatus     C(3), ;
                    FPags       C(12), ;
                    lCancel     L, ;
                    CupFis      N(1), ;
                    EmpDopNums  C(29), ;
                    cnIdents    C(10) ;
                )
                INDEX ON cnDtTrans TAG Datas
            ENDIF

            SELECT Transacao
            APPEND BLANK
            REPLACE cDopes      WITH THIS.this_cDopes, ;
                    cnCupoms    WITH THIS.this_cCnCupoms, ;
                    cCupomNvs   WITH THIS.this_cCCupomNvs, ;
                    cnnsus      WITH THIS.this_cCnNsus, ;
                    cnValors    WITH THIS.this_nCnValors, ;
                    cnDtTrans   WITH THIS.this_dCnDtTrans, ;
                    CnHrTrans   WITH THIS.this_cCnHrTrans, ;
                    cStatus     WITH THIS.this_cStatus, ;
                    FPags       WITH THIS.this_cFPags, ;
                    lCancel     WITH THIS.this_lCancel, ;
                    CupFis      WITH THIS.this_nCupFis, ;
                    EmpDopNums  WITH THIS.this_cEmpDopNums, ;
                    cnIdents    WITH THIS.this_cCnIdents

            THIS.RegistrarAuditoria("INSERT")
            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inserir transa" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza transacao no cursor local Transacao
    * Localiza pela chave FPags e atualiza campos mutaveis
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cFPags)
                THIS.this_cMensagemErro = "Forma de pagamento (Fpags) obrigat" + CHR(243) + "ria"
                loc_lResultado = .F.
            ENDIF

            IF !USED("Transacao")
                THIS.this_cMensagemErro = "Cursor Transacao n" + CHR(227) + "o est" + CHR(225) + " aberto"
                loc_lResultado = .F.
            ENDIF

            SELECT Transacao
            LOCATE FOR ALLTRIM(FPags) == ALLTRIM(THIS.this_cFPags) ;
                       AND ALLTRIM(cnnsus) == ALLTRIM(THIS.this_cCnNsus)

            IF !FOUND()
                THIS.this_cMensagemErro = "Transa" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada"
                loc_lResultado = .F.
            ENDIF

            REPLACE cStatus    WITH THIS.this_cStatus, ;
                    lCancel    WITH THIS.this_lCancel, ;
                    cnValors   WITH THIS.this_nCnValors, ;
                    CnHrTrans  WITH THIS.this_cCnHrTrans, ;
                    CupFis     WITH THIS.this_nCupFis, ;
                    EmpDopNums WITH THIS.this_cEmpDopNums, ;
                    cnIdents   WITH THIS.this_cCnIdents

            THIS.RegistrarAuditoria("UPDATE")
            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar transa" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

