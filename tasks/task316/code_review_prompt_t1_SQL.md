# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-ASPAS] Linha 196: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "WHERE cndttransI BETWEEN '" + loc_cDtI + "' AND '" + loc_cDtF + "' " + ;
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIMPFABS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CNDTTRANSI, CTIPOS, CHEADERS, DATAS, DOPES, CUPFIS, FPAGS, CNNSUS, EMPDOPNUMS, CNIDTEFS, RETSQL, CIDCHAVES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CNDTTRANSI, CTIPOS, CHEADERS, DATAS, DOPES, CUPFIS, FPAGS, CNNSUS, EMPDOPNUMS, CNIDTEFS, RETSQL, CIDCHAVES
- [TRANSACAO-AVULSA] Linha 355: SQLEXEC com 'COMMIT' mas NAO existe BEGIN TRANSACTION no codigo. A conexao ODBC usa AUTOCOMMIT - cada SQLEXEC ja eh transacao implicita. CORRIGIR: Remover SQLEXEC com COMMIT e ROLLBACK. Para operacoes simples (1 UPDATE), nao precisa de transacao explicita. Usar transacoes SOMENTE para operacoes multi-statement (2+ UPDATE/INSERT atomicos).

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigproef.prg) - TRECHOS RELEVANTES PARA PASS SQL (1219 linhas total):

*-- Linhas 170 a 212:
170:     *====================================================================
171:     PROCEDURE ObterNsuRetorno()
172:         IF USED("Transacao")
173:             SELECT Transacao
174:             IF !EOF()
175:                 RETURN ALLTRIM(NVL(cnnsus, ""))
176:             ENDIF
177:         ENDIF
178:         RETURN ""
179:     ENDPROC
180: 
181:     *====================================================================
182:     * Destroy - Libera recursos e cursores
183:     *====================================================================
184:     PROCEDURE Destroy()
185:         LOCAL loc_oErro
186:         TRY
187:             THIS.this_cNsuRetorno = THIS.ObterNsuRetorno()
188: 
189:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
190:                 THIS.this_oBusinessObject = .NULL.
191:             ENDIF
192: 
193:             IF USED("Transacao")
194:                 USE IN Transacao
195:             ENDIF
196:             IF USED("Selecao")
197:                 USE IN Selecao
198:             ENDIF
199:             IF USED("Selecao2")
200:                 USE IN Selecao2
201:             ENDIF
202:             IF USED("LocalPar")
203:                 USE IN LocalPar
204:             ENDIF
205:             IF USED("crSigCdPam")
206:                 USE IN crSigCdPam
207:             ENDIF
208:             IF USED("crSigCdPac")
209:                 USE IN crSigCdPac
210:             ENDIF
211:             IF USED("crSigFiMpF")
212:                 USE IN crSigFiMpF

*-- Linhas 240 a 258:
240:                 .Height        = 230
241:                 .ColumnCount   = 7
242:                 .ReadOnly      = .T.
243:                 .DeleteMark    = .F.
244:                 .RecordMark    = .F.
245:                 .ScrollBars    = 2
246:                 .FontName      = "Tahoma"
247:                 .FontSize      = 8
248:                 .GridLineColor = RGB(192, 192, 192)
249:                 .HeaderHeight  = 16
250:                 .RowHeight     = 15
251:                 .Visible       = .T.
252:             ENDWITH
253: 
254:             *-- Cabecalhos iniciais das colunas (definidos antes de RecordSource para
255:             *-- evitar cabecalhos genericos "Column1/Column2" enquanto SqlTrans carrega)
256:             WITH loc_oCnt.grd_4c_Dados
257:                 .ColumnCount                  = 7
258:                 .Column1.Width                = 70

*-- Linhas 341 a 371:
341:                 .BackStyle = 0
342:                 .Visible   = .T.
343:             ENDWITH
344: 
345:             loc_oPer.AddObject("txt_4c_DtFinal", "TextBox")
346:             WITH loc_oPer.txt_4c_DtFinal
347:                 .Value     = {}
348:                 .Alignment = 3
349:                 .Height    = 23
350:                 .Left      = 119
351:                 .Top       = 22
352:                 .Width     = 81
353:                 .FontName  = "Tahoma"
354:                 .FontSize  = 8
355:                 .Visible   = .T.
356:             ENDWITH
357: 
358:             *-- Shape decorativo de fundo dos botoes (pixel-perfect: Top=277, Left=245, 331x53)
359:             loc_oCnt.AddObject("shp_4c_Botoes", "Shape")
360:             WITH loc_oCnt.shp_4c_Botoes
361:                 .Top           = 277
362:                 .Left          = 245
363:                 .Height        = 53
364:                 .Width         = 331
365:                 .SpecialEffect = 0
366:                 .Visible       = .T.
367:             ENDWITH
368: 
369:             *-- Botao Gerencial F2 (pixel-perfect: Top=281, Left=251, 64x46)
370:             loc_oCnt.AddObject("cmd_4c_Gerencial", "CommandButton")
371:             WITH loc_oCnt.cmd_4c_Gerencial

*-- Linhas 538 a 556:
538:             RETURN
539:         ENDIF
540: 
541:         SELECT Transacao
542:         IF EOF()
543:             MsgAviso("Selecione uma transa" + CHR(231) + CHR(227) + ;
544:                      "o na grade antes de alterar.", "Aviso")
545:             RETURN
546:         ENDIF
547: 
548:         IF ALLTRIM(Transacao.cStatus) = "CNC"
549:             MsgAviso("Transa" + CHR(231) + CHR(227) + "o cancelada n" + CHR(227) + ;
550:                      "o pode ser alterada.", "Aviso")
551:             RETURN
552:         ENDIF
553: 
554:         THIS.BtnReimprimirClick()
555:     ENDPROC
556: 

*-- Linhas 567 a 585:
567:             RETURN
568:         ENDIF
569: 
570:         SELECT Transacao
571:         IF EOF()
572:             MsgAviso("Selecione uma transa" + CHR(231) + CHR(227) + ;
573:                      "o na grade antes de visualizar.", "Aviso")
574:             RETURN
575:         ENDIF
576: 
577:         THIS.BtnUltimoClick()
578:     ENDPROC
579: 
580:     *====================================================================
581:     * BtnExcluirClick - Cancela transacao TEF selecionada
582:     * Semantica CRUD "Excluir" mapeada para BtnCancelaClick. Cancelamento
583:     * de TEF nao remove fisicamente o registro (integridade fiscal); marca
584:     * cStatus='CNC', grava usuario cancelante em UsuCancs e reverte parcelas
585:     * em SigMvPar via lCancelas=.T. (padrao SigOpCtf/SigTfCan).

*-- Linhas 591 a 609:
591:             RETURN
592:         ENDIF
593: 
594:         SELECT Transacao
595:         IF EOF()
596:             MsgAviso("Selecione uma transa" + CHR(231) + CHR(227) + ;
597:                      "o na grade antes de cancelar.", "Aviso")
598:             RETURN
599:         ENDIF
600: 
601:         THIS.BtnCancelaClick()
602:     ENDPROC
603: 
604:     *====================================================================
605:     * SqlTrans - Carrega transacoes TEF no periodo e configura o grid
606:     * Equivalente ao sqltrans do form original
607:     *====================================================================
608:     PROCEDURE SqlTrans()
609:         LOCAL loc_lResultado, loc_dDtI, loc_dDtF, loc_oGrid

*-- Linhas 630 a 709:
630:                 loc_oGrid.ColumnCount  = 7
631:                 loc_oGrid.ReadOnly     = .T.
632: 
633:                 loc_oGrid.Column1.ControlSource    = "Transacao.cCupomNvs"
634:                 loc_oGrid.Column1.Width            = 70
635:                 loc_oGrid.Column1.FontSize         = 8
636:                 loc_oGrid.Column1.Movable          = .F.
637:                 loc_oGrid.Column1.Resizable        = .F.
638:                 loc_oGrid.Column1.ReadOnly         = .T.
639:                 loc_oGrid.Column1.Header1.Caption  = "Rede"
640:                 loc_oGrid.Column1.Header1.Alignment = 2
641:                 loc_oGrid.Column1.Header1.FontSize  = 8
642: 
643:                 loc_oGrid.Column2.ControlSource    = "Transacao.cnnsus"
644:                 loc_oGrid.Column2.Width            = 78
645:                 loc_oGrid.Column2.FontSize         = 8
646:                 loc_oGrid.Column2.Movable          = .F.
647:                 loc_oGrid.Column2.Resizable        = .F.
648:                 loc_oGrid.Column2.ReadOnly         = .T.
649:                 loc_oGrid.Column2.Header1.Caption  = "No.Autoriza" + CHR(231) + CHR(227) + "o"
650:                 loc_oGrid.Column2.Header1.Alignment = 2
651:                 loc_oGrid.Column2.Header1.FontSize  = 8
652: 
653:                 loc_oGrid.Column3.ControlSource    = "Transacao.cnValors"
654:                 loc_oGrid.Column3.Width            = 75
655:                 loc_oGrid.Column3.FontSize         = 8
656:                 loc_oGrid.Column3.Movable          = .F.
657:                 loc_oGrid.Column3.Resizable        = .F.
658:                 loc_oGrid.Column3.ReadOnly         = .T.
659:                 loc_oGrid.Column3.Header1.Caption  = "Valor"
660:                 loc_oGrid.Column3.Header1.Alignment = 2
661:                 loc_oGrid.Column3.Header1.FontSize  = 8
662: 
663:                 loc_oGrid.Column4.ControlSource    = "Transacao.cnDtTrans"
664:                 loc_oGrid.Column4.Width            = 65
665:                 loc_oGrid.Column4.FontSize         = 8
666:                 loc_oGrid.Column4.Movable          = .F.
667:                 loc_oGrid.Column4.Resizable        = .F.
668:                 loc_oGrid.Column4.ReadOnly         = .T.
669:                 loc_oGrid.Column4.Alignment        = 2
670:                 loc_oGrid.Column4.Header1.Caption  = "Data"
671:                 loc_oGrid.Column4.Header1.Alignment = 2
672:                 loc_oGrid.Column4.Header1.FontSize  = 8
673: 
674:                 loc_oGrid.Column5.ControlSource    = "Transacao.CnHrTrans"
675:                 loc_oGrid.Column5.Width            = 55
676:                 loc_oGrid.Column5.FontSize         = 8
677:                 loc_oGrid.Column5.Movable          = .F.
678:                 loc_oGrid.Column5.Resizable        = .F.
679:                 loc_oGrid.Column5.ReadOnly         = .T.
680:                 loc_oGrid.Column5.Header1.Caption  = "Hora"
681:                 loc_oGrid.Column5.Header1.Alignment = 2
682:                 loc_oGrid.Column5.Header1.FontSize  = 8
683: 
684:                 loc_oGrid.Column6.ControlSource    = "Transacao.cnCupoms"
685:                 loc_oGrid.Column6.Width            = 60
686:                 loc_oGrid.Column6.FontSize         = 8
687:                 loc_oGrid.Column6.Movable          = .F.
688:                 loc_oGrid.Column6.Resizable        = .F.
689:                 loc_oGrid.Column6.ReadOnly         = .T.
690:                 loc_oGrid.Column6.Header1.Caption  = "Cupom"
691:                 loc_oGrid.Column6.Header1.Alignment = 2
692:                 loc_oGrid.Column6.Header1.FontSize  = 8
693: 
694:                 loc_oGrid.Column7.ControlSource    = "Transacao.cDopes"
695:                 loc_oGrid.Column7.Width            = 120
696:                 loc_oGrid.Column7.FontSize         = 8
697:                 loc_oGrid.Column7.Movable          = .F.
698:                 loc_oGrid.Column7.Resizable        = .F.
699:                 loc_oGrid.Column7.ReadOnly         = .T.
700:                 loc_oGrid.Column7.Header1.Caption  = "Opera" + CHR(231) + CHR(227) + "o"
701:                 loc_oGrid.Column7.Header1.Alignment = 2
702:                 loc_oGrid.Column7.Header1.FontSize  = 8
703: 
704:                 loc_oGrid.SetAll("DynamicForeColor", ;
705:                     "IIF(Transacao.lCancel, RGB(255,0,0), RGB(0,0,0))", "Column")
706:                 loc_oGrid.Refresh()
707:                 loc_oGrid.SetFocus()
708:             ENDIF
709: 

*-- Linhas 779 a 797:
779:             RETURN
780:         ENDIF
781: 
782:         SELECT Transacao
783:         IF EOF()
784:             MsgAviso("N" + CHR(227) + "o existem transa" + CHR(231) + CHR(245) + "es efetuadas", "Aviso")
785:             RETURN
786:         ENDIF
787: 
788:         TRY
789:             loc_nResposta = SigPrTef( ;
790:                 THIS.this_oBusinessObject.this_cNumIps, ;
791:                 110, ;
792:                 Transacao.cnValors, ;
793:                 "1", ;
794:                 THIS.this_oBusinessObject.this_cCnCaixas, ;
795:                 .NULL., ;
796:                 "SW000001", ;
797:                 0)

*-- Linhas 813 a 831:
813:             RETURN
814:         ENDIF
815: 
816:         SELECT Transacao
817:         IF EOF()
818:             MsgAviso("N" + CHR(227) + "o existem transa" + CHR(231) + CHR(245) + "es efetuadas", "Aviso")
819:             RETURN
820:         ENDIF
821: 
822:         TRY
823:             THIS.this_oBusinessObject.CarregarPagamentoFP(ALLTRIM(Transacao.FPags))
824: 
825:             loc_cNSU  = ALLTRIM(Transacao.cnnsus)
826:             loc_cData = DTOC(Transacao.cnDtTrans)
827:             loc_cData = SUBSTR(loc_cData, 1, 2) + SUBSTR(loc_cData, 4, 2) + SUBSTR(loc_cData, 7, 4)
828:             SKIP
829: 
830:             IF ALLTRIM(THIS.this_oBusinessObject.this_cVerSitefs) = "4.1"
831:                 DO FORM SigPrOer WITH ;

*-- Linhas 842 a 883:
842:             ENDIF
843: 
844:             IF USED("Transacao")
845:                 SELECT Transacao
846:                 GO BOTTOM
847:             ENDIF
848: 
849:         CATCH TO loc_oErro
850:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
851:                     " PROC=" + loc_oErro.Procedure, "Erro " + CHR(218) + "ltimo")
852:         ENDTRY
853: 
854:         THIS.Release()
855:     ENDPROC
856: 
857:     *====================================================================
858:     * BtnReimprimirClick - Reimprime comprovante TEF (F4)
859:     *====================================================================
860:     PROCEDURE BtnReimprimirClick()
861:         LOCAL loc_cNSU, loc_cData
862: 
863:         IF !USED("Transacao")
864:             MsgAviso("N" + CHR(227) + "o existem transa" + CHR(231) + CHR(245) + "es efetuadas", "Aviso")
865:             RETURN
866:         ENDIF
867: 
868:         SELECT Transacao
869:         IF EOF()
870:             MsgAviso("N" + CHR(227) + "o existem transa" + CHR(231) + CHR(245) + "es efetuadas", "Aviso")
871:             RETURN
872:         ENDIF
873: 
874:         IF ALLTRIM(Transacao.cStatus) = "CNC"
875:             MsgAviso("Transa" + CHR(231) + CHR(227) + "o cancelada", "Aviso")
876:             RETURN
877:         ENDIF
878: 
879:         TRY
880:             loc_cNSU  = ALLTRIM(Transacao.cnnsus)
881:             loc_cData = DTOC(Transacao.cnDtTrans)
882:             loc_cData = SUBSTR(loc_cData, 1, 2) + SUBSTR(loc_cData, 4, 2) + SUBSTR(loc_cData, 7, 4)
883:             SKIP

*-- Linhas 901 a 942:
901:             ENDIF
902: 
903:             IF USED("Transacao")
904:                 SELECT Transacao
905:                 SKIP -1
906:             ENDIF
907: 
908:         CATCH TO loc_oErro
909:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
910:                     " PROC=" + loc_oErro.Procedure, "Erro Reimprimir")
911:         ENDTRY
912: 
913:         THIS.Release()
914:     ENDPROC
915: 
916:     *====================================================================
917:     * BtnCancelaClick - Cancela transacao TEF selecionada (F5)
918:     *====================================================================
919:     PROCEDURE BtnCancelaClick()
920:         LOCAL loc_lCancel, loc_cData
921: 
922:         IF !USED("Transacao")
923:             MsgAviso("N" + CHR(227) + "o existem transa" + CHR(231) + CHR(245) + "es efetuadas", "Aviso")
924:             RETURN
925:         ENDIF
926: 
927:         SELECT Transacao
928:         IF EOF()
929:             MsgAviso("N" + CHR(227) + "o existem transa" + CHR(231) + CHR(245) + "es efetuadas", "Aviso")
930:             RETURN
931:         ENDIF
932: 
933:         IF ALLTRIM(Transacao.cStatus) = "CNC"
934:             MsgAviso("Transa" + CHR(231) + CHR(227) + "o j" + CHR(225) + " cancelada", "Aviso")
935:             RETURN
936:         ENDIF
937: 
938:         IF Transacao.CupFis = 3
939:             IF !MsgConfirma("Aten" + CHR(231) + CHR(227) + "o! Esta " + CHR(233) + " uma opera" + ;
940:                             CHR(231) + CHR(227) + "o de Cupom N" + CHR(227) + "o Fiscal." + CHR(13) + ;
941:                             "Deseja realmente continuar com o cancelamento?")
942:                 RETURN

*-- Linhas 1026 a 1094:
1026:         IF USED("crSiTef")
1027:             USE IN crSiTef
1028:         ENDIF
1029:         CREATE CURSOR crSiTef (tef C(100))
1030: 
1031:         INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
1032:         INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + TRANSFORM(THIS.this_cOperacao))
1033:         INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
1034:         INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_sValPago)
1035:         INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
1036:         INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")
1037:         INSERT INTO crSiTef (Tef) VALUES ("010-000 = " + loc_aCartao[VAL(par_sCartao) + 1])
1038:         INSERT INTO crSiTef (Tef) VALUES ("011-000 = " + par_sTipTran)
1039:         INSERT INTO crSiTef (Tef) VALUES ("012-000 = " + par_sNsu)
1040:         INSERT INTO crSiTef (Tef) VALUES ("013-000 = " + par_sAutoriza)
1041:         INSERT INTO crSiTef (Tef) VALUES ("015-000 = " + ;
1042:             SUBSTR(par_sDataHora, 7, 2) + SUBSTR(par_sDataHora, 5, 2) + SUBSTR(par_sDataHora, 9, 6))
1043:         INSERT INTO crSiTef (Tef) VALUES ("017-000 = 0")
1044:         INSERT INTO crSiTef (Tef) VALUES ("018-000 = 1")
1045:         INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
1046:         INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
1047:         INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
1048:         INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
1049:         INSERT INTO crSiTef (Tef) VALUES ("022-000 = " + ;
1050:             SUBSTR(par_sDataHora, 7, 2) + SUBSTR(par_sDataHora, 5, 2) + SUBSTR(par_sDataHora, 1, 4))
1051:         INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + SUBSTR(par_sDataHora, 9, 6))
1052:         INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + par_sFinaliza)
1053:         INSERT INTO crSiTef (Tef) VALUES ("027-000 = " + SUBSTR(par_sDataHora, 9, 6))
1054:         INSERT INTO crSiTef (Tef) VALUES ("028-000 = 27")
1055: 
1056:         loc_sPos       = 1
1057:         loc_nLinha     = 1
1058:         loc_sCupomTemp = par_sCupom
1059: 
1060:         DO WHILE loc_sPos <> 0
1061:             loc_sPos = AT(CHR(10), loc_sCupomTemp)
1062:             INSERT INTO crSiTef (Tef) VALUES ( ;
1063:                 "029-" + TRANSFORM(loc_nLinha, "@L 999") + " = " + ;
1064:                 IIF(loc_sPos <> 0, SUBSTR(loc_sCupomTemp, 1, loc_sPos - 1), loc_sCupomTemp))
1065:             loc_sCupomTemp = SUBSTR(loc_sCupomTemp, loc_sPos + 1)
1066:             loc_nLinha     = loc_nLinha + 1
1067:         ENDDO
1068: 
1069:         INSERT INTO crSiTef (Tef) VALUES ("030-000 = Transacao OK")
1070:         INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
1071:         INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
1072: 
1073:         SELECT crSiTef
1074:         COPY TO C:\client\Resp\IntPos.001 SDF
1075:         ZAP
1076: 
1077:         INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
1078:         INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + TRANSFORM(THIS.this_cOperacao))
1079:         INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
1080: 
1081:         COPY TO C:\client\Resp\IntPos.STS SDF
1082: 
1083:         USE IN crSiTef
1084:     ENDPROC
1085: 
1086:     *====================================================================
1087:     * CarregarLista - Compatibilidade CRUD: recarrega grid de transacoes
1088:     *====================================================================
1089:     PROCEDURE CarregarLista()
1090:         RETURN THIS.SqlTrans()
1091:     ENDPROC
1092: 
1093:     *====================================================================
1094:     * BtnBuscarClick - Recarrega transacoes com o periodo informado


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
            loc_cSQL = "SELECT cImpFabs, CnCaixas FROM SIGFIMPF WHERE cImpFabs = " + ;
                       EscaparSQL(par_cNoFab)

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
                       "WHERE cndttransI BETWEEN '" + loc_cDtI + "' AND '" + loc_cDtF + "' " + ;
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
                    SQLEXEC(gnConnHandle, "COMMIT")
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

