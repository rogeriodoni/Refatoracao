# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPDOPNUMS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TITS, CAMPOS, CODS, LCOBJ, NPOS, CHKSUBN, I

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
  ControlSource = "crSigSyCrs.Cods"
Select crSigSyCrs
		Select crSigSyCit
				If Seek(Str(crSigSyCrs.Cods, 6) + crSigSyCit.Campos, 'LocalCadRs', 'CodCampos')
		Delete
lcQuery = [Select Cods, Campos, Resps ] + ;
		    [From SigSyCrs ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalCadRs') < 1)
Select LocalCadRs
Select crSigSyCit
	Select LocalCadRs
Select LocalCadRs
Select LocalCadRs
Select LocalCadRs
Select LocalCadRs
Select LocalCadRs
	Select crSigSyCit
	Select crSigSyCit
			Insert Into crGrvCadRs (Tits, Campos, Cods, cIdChaves, Resps, Pergs) ;
		Insert Into crGrvCadRs (Tits, Campos, Cods, cIdChaves, Resps, Pergs) ;
		Insert Into crGrvCadRs (Tits, Campos, Cods, cIdChaves, Resps, Pergs) ;
		Insert Into crGrvCadRs (Tits, Campos, Cods, cIdChaves, Resps, Pergs) ;
		Insert Into crGrvCadRs (Tits, Campos, Cods, cIdChaves, Resps, Pergs) ;
		Insert Into crGrvCadRs (Tits, Campos, Cods, cIdChaves, Resps, Pergs) ;
		Insert Into crGrvCadRs (Tits, Campos, Cods, cIdChaves, Resps, Pergs) ;
	Select crSigSyCit
Select crSigSyCrs
Select LocalCadRs
	lcQuery = [Delete From SigSyCrs ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	If Not ThisForm.poDataMgr.Update('crGrvCadRs')
	lcQuery = [Delete From SigSyCrs ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	lcQuery = [Delete From SigSyCrs ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	If Not ThisForm.poDataMgr.Update('crGrvCadRs')
Select crSigSyCrs
		Select crSigSyCit
		lcQryCadRs = [Select Distinct ChkSubn, ChkApro, Cods]
					  [ From SigSyCrs ] + ;
			Select crSigSyCit
Select crSigSyCrs
			Insert Into crGrvCadRs (Tits, Campos, Cods, cIdChaves, Resps, Pergs, chkApro) ;
		Insert into LocalCadRs (Cods, Campos, Resps) Values (lnCod,'Aprova',lcVal)
			Insert Into crGrvCadRs (Tits, Campos, Cods, cIdChaves, Resps, Pergs, chkApro) ;
		Insert into LocalCadRs (Cods, Campos, Resps) Values (lnCod,'Datas',lcVal)
		ThisForm.poDatamgr.SqlExecute([UpDate SigSyCrs Set ChkApro = ?llOk Where Cods = ?lnCod])
		If Not ThisForm.poDataMgr.Update('crGrvCadRs')
		ThisForm.poDatamgr.SqlExecute([Delete From SigSyCrs Where Cods = ?lnCod And Campos = 'Datas' And Tits = ']+ThisForm.Tits+['])
		ThisForm.poDatamgr.SqlExecute([Delete From SigSyCrs Where Cods = ?lnCod And Campos = 'Aprova' And Tits = ']+ThisForm.Tits+['])
		ThisForm.poDatamgr.SqlExecute([UpDate SigSyCrs Set ChkApro = ?llOk Where Cods = ?lnCod])
		Select crSigSyCrs
		Select LocalCadRs 
		Delete
		Delete
		Select crSigSyCrs
		ThisForm.poDatamgr.SqlExecute([Delete From SigSyCrs Where Cods = ?lnCod And Campos = 'Emps' And Tits = ']+ThisForm.Tits+['])
		ThisForm.poDatamgr.SqlExecute([Delete From SigSyCrs Where Cods = ?lnCod And Campos = 'Dopes' And Tits = ']+ThisForm.Tits+['])
		ThisForm.poDatamgr.SqlExecute([Delete From SigSyCrs Where Cods = ?lnCod And Campos = 'Numes' And Tits = ']+ThisForm.Tits+['])
		ThisForm.poDatamgr.SqlExecute([Delete From SigSyCrs Where Cods = ?lnCod And Campos = 'Baixa' And Tits = ']+ThisForm.Tits+['])
		ThisForm.poDatamgr.SqlExecute([UpDate SigSyCrs Set ChkSubn = ?llOk Where Cods = ?lnCod])
		Select crSigSyCrs
		Select LocalCadRs 
		Delete
		Delete
		Delete
		Delete

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormDrs.prg) - TRECHOS RELEVANTES PARA PASS SQL (1949 linhas total):

*-- Linhas 473 a 491:
473:             .HighlightBackColor = RGB(255, 255, 255)
474:             .HighlightForeColor = RGB(15, 41, 104)
475:             .HighlightStyle     = 2
476:             .DeleteMark         = .F.
477:             .RecordMark         = .F.
478:             .RowHeight          = 16
479:             .ScrollBars         = 3
480:             .GridLines          = 3
481:             .Visible            = .T.
482:         ENDWITH
483:         BINDEVENT(loc_oPagina.grd_4c_Lista, "AfterRowColChange", THIS, "GrdAfterRowColChange")
484:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick",          THIS, "BtnVisualizarClick")
485: 
486:         THIS.TornarControlesVisiveis(loc_oPagina)
487:     ENDPROC
488: 
489:     *===========================================================================
490:     * ConfigurarPaginaDados - Page2: botoes acao + codigo + container dinamico
491:     *===========================================================================

*-- Linhas 630 a 649:
630:                     USE IN cursor_4c_Dados
631:                 ENDIF
632:                 IF USED("crSigSyCrs")
633:                     SELECT * FROM crSigSyCrs INTO CURSOR cursor_4c_Dados NOFILTER READWRITE
634:                     SELECT crSigSyCrs
635:                 ENDIF
636:                 THIS.MontarColunasGrid()
637:                 IF USED("crSigSyCrs")
638:                     loc_oGrd.SetAll("DynamicForeColor", ;
639:                         "Iif(crSigSyCrs.ChkSubn, RGB(0,0,255), Iif(crSigSyCrs.ChkApro, RGB(0,128,0), RGB(0,0,0)))", ;
640:                         "Column")
641:                     loc_oGrd.RecordSource = "crSigSyCrs"
642:                     loc_oGrd.Refresh()
643:                 ENDIF
644:                 THIS.AtualizarBotoesWorkflow()
645:             ENDIF
646:         CATCH TO loc_oErro
647:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
648:                 "FormDrs.CarregarLista")
649:         ENDTRY

*-- Linhas 659 a 718:
659:             loc_nCols = 1
660: 
661:             IF USED("crSigSyCit") AND RECCOUNT("crSigSyCit") > 0
662:                 SELECT crSigSyCit
663:                 SCAN
664:                     IF crSigSyCit.Listas = 1
665:                         loc_nCols = loc_nCols + 1
666:                     ENDIF
667:                 ENDSCAN
668:             ENDIF
669: 
670:             loc_oGrd.RecordSource = ""
671:             loc_oGrd.ColumnCount  = loc_nCols
672: 
673:             WITH loc_oGrd.Column1
674:                 .ControlSource       = "crSigSyCrs.Cods"
675:                 .Width               = 60
676:                 .ReadOnly            = .T.
677:                 .Header1.Caption     = "C" + CHR(243) + "digo"
678:                 .Header1.FontName    = "Tahoma"
679:                 .Header1.FontBold    = .T.
680:                 .Header1.FontSize    = 8
681:             ENDWITH
682: 
683:             IF USED("crSigSyCit") AND RECCOUNT("crSigSyCit") > 0
684:                 loc_nColIdx = 2
685:                 SELECT crSigSyCit
686:                 SCAN
687:                     IF crSigSyCit.Listas = 1
688:                         loc_cCampo  = ALLTRIM(crSigSyCit.Campos)
689:                         loc_cHeader = PROPER(ALLTRIM(crSigSyCit.Descs))
690: 
691:                         DO CASE
692:                             CASE crSigSyCit.Tipos = "D"
693:                                 loc_nWidth = 80
694:                             CASE crSigSyCit.Tipos = "N"
695:                                 loc_nWidth = 100
696:                             CASE !EMPTY(ALLTRIM(crSigSyCit.Pictures))
697:                                 loc_nWidth = MAX(60, LEN(ALLTRIM(crSigSyCit.Pictures)) * 8)
698:                             OTHERWISE
699:                                 loc_nWidth = 400
700:                         ENDCASE
701: 
702:                         WITH loc_oGrd.Columns(loc_nColIdx)
703:                             .ControlSource       = "crSigSyCrs." + loc_cCampo
704:                             .Width               = loc_nWidth
705:                             .ReadOnly            = .T.
706:                             .Header1.Caption     = loc_cHeader
707:                             .Header1.FontName    = "Tahoma"
708:                             .Header1.FontBold    = .T.
709:                             .Header1.FontSize    = 8
710:                         ENDWITH
711: 
712:                         loc_nColIdx = loc_nColIdx + 1
713:                     ENDIF
714:                 ENDSCAN
715:             ENDIF
716:         CATCH TO loc_oErro
717:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
718:                 "FormDrs.MontarColunasGrid")

*-- Linhas 739 a 757:
739:             THIS.this_nNroControles = 0
740: 
741:             IF USED("crSigSyCit") AND RECCOUNT("crSigSyCit") > 0
742:                 SELECT crSigSyCit
743:                 SCAN
744:                     loc_cCampo     = ALLTRIM(crSigSyCit.Campos)
745:                     loc_cDescs     = ALLTRIM(crSigSyCit.Descs)
746:                     loc_cTipos     = ALLTRIM(crSigSyCit.Tipos)
747:                     loc_nOrdems    = crSigSyCit.Ordems
748:                     loc_cInputMask = ALLTRIM(crSigSyCit.Pictures)
749: 
750:                     *-- Label
751:                     loc_cLblName = "lbl_4c_F" + ALLTRIM(STR(loc_nOrdems, 3))
752:                     loc_oCnt.AddObject(loc_cLblName, "Label")
753:                     WITH loc_oCnt.&loc_cLblName.
754:                         .Caption   = PROPER(loc_cDescs)
755:                         .Top       = loc_nTop
756:                         .Left      = loc_nLef + 4
757:                         .FontName  = "Tahoma"

*-- Linhas 1093 a 1111:
1093:                 loc_cObjName = THIS.laControles[loc_nIdx, 1]
1094:                 loc_cCampo   = THIS.laControles[loc_nIdx, 3]
1095: 
1096:                 SELECT crSigSyCit
1097:                 LOCATE FOR ALLTRIM(Campos) = loc_cCampo
1098:                 IF !EOF("crSigSyCit")
1099:                     loc_cTipos = ALLTRIM(crSigSyCit.Tipos)
1100:                 ELSE
1101:                     loc_cTipos = "M"
1102:                 ENDIF
1103: 
1104:                 IF SEEK(STR(THIS.this_nCodAtual, 6) + PADR(loc_cCampo, 10), "LocalCadRs", "CodCampos")
1105:                     loc_cVal = ALLTRIM(LocalCadRs.Resps)
1106:                 ELSE
1107:                     loc_cVal = ""
1108:                 ENDIF
1109: 
1110:                 IF TYPE("loc_oCnt.&loc_cObjName.") = "O"
1111:                     DO CASE

*-- Linhas 1171 a 1189:
1171:                 loc_cObjName = THIS.laControles[loc_nIdx, 1]
1172:                 loc_cCampo   = THIS.laControles[loc_nIdx, 3]
1173: 
1174:                 SELECT crSigSyCit
1175:                 LOCATE FOR ALLTRIM(Campos) = loc_cCampo
1176:                 IF !EOF("crSigSyCit")
1177:                     loc_cTipos   = ALLTRIM(crSigSyCit.Tipos)
1178:                     loc_cPicture = ALLTRIM(crSigSyCit.Pictures)
1179:                     loc_cDescs   = ALLTRIM(crSigSyCit.Descs)
1180:                 ELSE
1181:                     loc_cTipos   = "M"
1182:                     loc_cPicture = ""
1183:                     loc_cDescs   = loc_cCampo
1184:                 ENDIF
1185: 
1186:                 IF TYPE("loc_oCnt.&loc_cObjName.") = "O"
1187:                     DO CASE
1188:                         CASE loc_cTipos = "M"
1189:                             loc_cVal = ALLTRIM(loc_oCnt.&loc_cObjName..Value)

*-- Linhas 1198 a 1270:
1198:                     ENDCASE
1199: 
1200:                     IF !EMPTY(loc_cVal)
1201:                         INSERT INTO crGrvCadRs (Tits, Campos, Cods, Resps, Pergs, ChkApro, ChkSubn) ;
1202:                             VALUES (THIS.this_cTits, loc_cCampo, THIS.this_nCodAtual, ;
1203:                                     loc_cVal, loc_cDescs, ;
1204:                                     THIS.this_oBusinessObject.this_lChkApro, .F.)
1205:                     ENDIF
1206:                 ENDIF
1207:             ENDFOR
1208: 
1209:             *-- Campos fixos: Emps, Dopes, Numes (determina ChkSubn)
1210:             loc_lGrv = .T.
1211: 
1212:             loc_cVal = IIF(TYPE("loc_oCnt.txt_4c_FEmps") = "O", ALLTRIM(loc_oCnt.txt_4c_FEmps.Value), "")
1213:             IF !EMPTY(loc_cVal)
1214:                 INSERT INTO crGrvCadRs (Tits, Campos, Cods, Resps, Pergs, ChkApro, ChkSubn) ;
1215:                     VALUES (THIS.this_cTits, "Emps", THIS.this_nCodAtual, ;
1216:                             loc_cVal, "Empresa", THIS.this_oBusinessObject.this_lChkApro, .F.)
1217:             ELSE
1218:                 loc_lGrv = .F.
1219:             ENDIF
1220: 
1221:             loc_cVal = IIF(TYPE("loc_oCnt.txt_4c_FDopes") = "O", ALLTRIM(loc_oCnt.txt_4c_FDopes.Value), "")
1222:             IF !EMPTY(loc_cVal)
1223:                 INSERT INTO crGrvCadRs (Tits, Campos, Cods, Resps, Pergs, ChkApro, ChkSubn) ;
1224:                     VALUES (THIS.this_cTits, "Dopes", THIS.this_nCodAtual, ;
1225:                             loc_cVal, "Opera" + CHR(231) + CHR(227) + "o", ;
1226:                             THIS.this_oBusinessObject.this_lChkApro, .F.)
1227:             ELSE
1228:                 loc_lGrv = .F.
1229:             ENDIF
1230: 
1231:             loc_cVal = IIF(TYPE("loc_oCnt.txt_4c_FNumes") = "O", ALLTRIM(loc_oCnt.txt_4c_FNumes.Value), "")
1232:             IF !EMPTY(loc_cVal)
1233:                 INSERT INTO crGrvCadRs (Tits, Campos, Cods, Resps, Pergs, ChkApro, ChkSubn) ;
1234:                     VALUES (THIS.this_cTits, "Numes", THIS.this_nCodAtual, ;
1235:                             loc_cVal, "N" + CHR(250) + "mero", ;
1236:                             THIS.this_oBusinessObject.this_lChkApro, .F.)
1237:                 INSERT INTO crGrvCadRs (Tits, Campos, Cods, Resps, Pergs, ChkApro, ChkSubn) ;
1238:                     VALUES (THIS.this_cTits, "Baixa", THIS.this_nCodAtual, ;
1239:                             ALLTRIM(gc_4c_UsuarioLogado), "Baixa", ;
1240:                             THIS.this_oBusinessObject.this_lChkApro, .F.)
1241:             ELSE
1242:                 loc_lGrv = .F.
1243:             ENDIF
1244: 
1245:             *-- Aprova/Datas (readonly, preservados se preenchidos)
1246:             loc_cVal = IIF(TYPE("loc_oCnt.txt_4c_FAprova") = "O", ALLTRIM(loc_oCnt.txt_4c_FAprova.Value), "")
1247:             IF !EMPTY(loc_cVal)
1248:                 INSERT INTO crGrvCadRs (Tits, Campos, Cods, Resps, Pergs, ChkApro, ChkSubn) ;
1249:                     VALUES (THIS.this_cTits, "Aprova", THIS.this_nCodAtual, ;
1250:                             loc_cVal, "Aprovado", .T., loc_lGrv)
1251:             ENDIF
1252: 
1253:             loc_cVal = IIF(TYPE("loc_oCnt.txt_4c_FDatas") = "O", ALLTRIM(loc_oCnt.txt_4c_FDatas.Value), "")
1254:             IF !EMPTY(loc_cVal)
1255:                 INSERT INTO crGrvCadRs (Tits, Campos, Cods, Resps, Pergs, ChkApro, ChkSubn) ;
1256:                     VALUES (THIS.this_cTits, "Datas", THIS.this_nCodAtual, ;
1257:                             loc_cVal, "Data", .T., loc_lGrv)
1258:             ENDIF
1259: 
1260:             *-- ChkSubn = .T. somente quando Emps+Dopes+Numes todos preenchidos
1261:             REPLACE ALL ChkSubn WITH loc_lGrv IN crGrvCadRs
1262: 
1263:             loc_lResultado = .T.
1264:             ENDIF
1265:         CATCH TO loc_oErro
1266:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1267:                 "FormDrs.GravarDados")
1268:         ENDTRY
1269:         RETURN loc_lResultado
1270:     ENDFUNC

*-- Linhas 1550 a 1569:
1550:                     RETURN
1551:                 ENDIF
1552:                 loc_cEDN    = PADR(loc_cEmps, 3) + PADR(loc_cDopes, 20) + PADL(loc_cNumes, 6)
1553:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1554:                     "SELECT TOP 1 EmpDopNums FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(loc_cEDN), ;
1555:                     "cursor_4c_ValidaEDN")
1556:                 IF loc_nResult > 0
1557:                     IF EOF("cursor_4c_ValidaEDN")
1558:                         MsgAviso("A Opera" + CHR(231) + CHR(227) + "o com o N" + CHR(250) + ;
1559:                             "mero digitado n" + CHR(227) + "o foi encontrada na Empresa.", ;
1560:                             "Fichas T" + CHR(233) + "cnicas")
1561:                         USE IN cursor_4c_ValidaEDN
1562:                         RETURN
1563:                     ENDIF
1564:                     USE IN cursor_4c_ValidaEDN
1565:                 ELSE
1566:                     MsgErro("Erro ao validar SigMvCab:" + CHR(13) + CapturarErroSQL(), ;
1567:                         "FormDrs.BtnSalvarClick")
1568:                     RETURN
1569:                 ENDIF

*-- Linhas 1620 a 1651:
1620:                 IF loc_lConfirma
1621:                     THIS.this_oBusinessObject.this_nCods = crSigSyCrs.Cods
1622:                     IF THIS.this_oBusinessObject.Aprovar(ALLTRIM(gc_4c_UsuarioLogado))
1623:                         SELECT crSigSyCrs
1624:                         REPLACE crSigSyCrs.ChkApro WITH .T.
1625:                         loc_oAprovar.Caption = "Desaprovar"
1626:                         THIS.AtualizarBotoesWorkflow()
1627:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1628:                     ENDIF
1629:                 ENDIF
1630:             ELSE
1631:                 loc_lConfirma = MsgConfirma("Confirma Desaprova" + CHR(231) + CHR(227) + "o?", ;
1632:                     "Fichas T" + CHR(233) + "cnicas")
1633:                 IF loc_lConfirma
1634:                     THIS.this_oBusinessObject.this_nCods = crSigSyCrs.Cods
1635:                     IF THIS.this_oBusinessObject.Desaprovar()
1636:                         SELECT crSigSyCrs
1637:                         REPLACE crSigSyCrs.ChkApro WITH .F.
1638:                         loc_oAprovar.Caption = "Aprovar"
1639:                         THIS.AtualizarBotoesWorkflow()
1640:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1641:                     ENDIF
1642:                 ENDIF
1643:             ENDIF
1644:         CATCH TO loc_oErro
1645:             MsgErro(loc_oErro.Message, "FormDrs.BtnAprovarClick")
1646:         ENDTRY
1647:     ENDPROC
1648: 
1649:     *===========================================================================
1650:     * BtnBaixarClick - Baixa (abre Page2 em ALTERAR) ou Cancela Baixa
1651:     *===========================================================================

*-- Linhas 1683 a 1701:
1683:                     "Fichas T" + CHR(233) + "cnicas")
1684:                 IF loc_lConfirma
1685:                     IF THIS.this_oBusinessObject.CancelarBaixa(crSigSyCrs.Cods)
1686:                         SELECT crSigSyCrs
1687:                         REPLACE crSigSyCrs.ChkSubn WITH .F.
1688:                         loc_oBaixar.Caption = "Baixar"
1689:                         THIS.AtualizarBotoesWorkflow()
1690:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1691:                     ENDIF
1692:                 ENDIF
1693:             ENDIF
1694:         CATCH TO loc_oErro
1695:             MsgErro(loc_oErro.Message, "FormDrs.BtnBaixarClick")
1696:         ENDTRY
1697:     ENDPROC
1698: 
1699:     *===========================================================================
1700:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1701:     * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)

*-- Linhas 1842 a 1860:
1842:                 loc_cObjName = THIS.laControles[loc_nIdx, 1]
1843:                 loc_cCampo   = THIS.laControles[loc_nIdx, 3]
1844: 
1845:                 SELECT crSigSyCit
1846:                 LOCATE FOR ALLTRIM(Campos) = loc_cCampo
1847:                 IF !EOF("crSigSyCit")
1848:                     loc_cTipos = ALLTRIM(crSigSyCit.Tipos)
1849:                 ELSE
1850:                     loc_cTipos = "M"
1851:                 ENDIF
1852: 
1853:                 IF TYPE("loc_oCnt.&loc_cObjName.") = "O"
1854:                     DO CASE
1855:                         CASE loc_cTipos = "D"
1856:                             loc_oCnt.&loc_cObjName..Value = CTOD("")
1857:                         CASE loc_cTipos = "N"
1858:                             loc_oCnt.&loc_cObjName..Value = 0
1859:                         OTHERWISE
1860:                             loc_oCnt.&loc_cObjName..Value = ""


### BO (C:\4c\projeto\app\classes\DrsBO.prg):
*===============================================================================
* DrsBO.prg - Business Object para Fichas Tecnicas (SigSyCrs)
* Herda de BusinessBase
*
* Tabela principal: SigSyCrs
* Tabela config: SigSyCit
*
* MODELO DE DADOS (key-value store):
*   SigSyCrs (Tits C20, Cods N, Campos C10, Resps M, Pergs C, cIdChaves C,
*             ChkApro L, ChkSubn L)
*   SigSyCit (Tits C20, Campos C10, Descs C, Tipos C1, Ordems N, Listas N,
*             Linhas N, Files C, Fields C, Chaves C, cIdChaves C, CampoOAs C,
*             CampoDAs C, Associados C, Cadeado N, Vinculados C,
*             Obrigatorios L, Pictures C)
*
* Um "registro logico" = conjunto de rows em SigSyCrs com mesmo (Tits, Cods).
* Cada row armazena um campo: Campos=nome, Resps=valor, Pergs=rotulo.
* cIdChaves e a PK fisica de cada row individual.
*===============================================================================

DEFINE CLASS DrsBO AS BusinessBase

    *---------------------------------------------------------------------------
    * Identificacao do registro logico (Tits + Cods formam a PK logica)
    *---------------------------------------------------------------------------
    this_cTits   = ""   && Tipo de ficha C(20) - identifica o formulario/processo
    this_nCods   = 0    && Codigo do registro (PK logica dentro do Tits)

    *---------------------------------------------------------------------------
    * Status do workflow de aprovacao/baixa
    *---------------------------------------------------------------------------
    this_lChkApro  = .F.    && Aprovado
    this_lChkSubn  = .F.    && Baixado/Encerrado (ChkSubn)

    *---------------------------------------------------------------------------
    * Campos fixos de cabecalho (armazenados como key-value em SigSyCrs)
    * Campos = 'Emps', 'Dopes', 'Numes', 'Aprova', 'Datas', 'Baixa'
    *---------------------------------------------------------------------------
    this_cEmps   = ""   && Empresa (C3) - referencia SigCdEmp.CEmps
    this_cDopes  = ""   && Operacao (C20) - referencia SigCdOpe.Dopes
    this_cNumes  = ""   && Numero da operacao (C6)
    this_cAprova = ""   && Aprovador - usuario que aprovou (C10)
    this_cDatas  = ""   && Data de aprovacao como string (C20)
    this_cBaixa  = ""   && Usuario que registrou baixa (C10)

    *---------------------------------------------------------------------------
    * Nomes dos cursores de trabalho (mantidos como constantes aqui para
    * referencia cruzada com o Form)
    *---------------------------------------------------------------------------
    this_cCursorRs    = "crGrvCadRs"    && Cursor escrita SigSyCrs (key=cIdChaves)
    this_cCursorLista = "crSigSyCrs"    && Cursor lista SigSyCrs (key=Cods)
    this_cCursorCit   = "crSigSyCit"    && Cursor config SigSyCit
    this_cCursorLocal = "LocalCadRs"    && Cursor local de respostas (key=CodCampos)

    *===========================================================================
    PROCEDURE Init()
    *===========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigSyCrs"
            THIS.this_cCampoChave = "cIdChaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * Destroy - Fecha cursores ao destruir o BO
    *===========================================================================
    PROCEDURE Destroy()
        THIS.FecharCursores()
        DODEFAULT()
    ENDPROC

    *===========================================================================
    * ObterChavePrimaria - Retorna chave para auditoria
    *===========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN EscaparSQL(ALLTRIM(THIS.this_cTits)) + ", " + ;
               FormatarNumeroSQL(THIS.this_nCods)
    ENDFUNC

    *===========================================================================
    * FecharCursores - Fecha todos os cursores de trabalho
    *===========================================================================
    PROCEDURE FecharCursores()
        IF USED("crSigSyCrs")
            USE IN crSigSyCrs
        ENDIF
        IF USED("LocalCadRs")
            USE IN LocalCadRs
        ENDIF
        IF USED("crSigSyCit")
            USE IN crSigSyCit
        ENDIF
        IF USED("crGrvCadRs")
            USE IN crGrvCadRs
        ENDIF
    ENDPROC

    *===========================================================================
    * InicializarCursores - Cria cursor de escrita crGrvCadRs
    *===========================================================================
    FUNCTION InicializarCursores()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("crGrvCadRs")
                USE IN crGrvCadRs
            ENDIF
            SET NULL ON
            CREATE CURSOR crGrvCadRs ( ;
                Tits      C(20),  ;
                Campos    C(10),  ;
                Cods      N(10,0), ;
                cIdChaves C(38),  ;
                Resps     M,      ;
                Pergs     C(200), ;
                ChkApro   L,      ;
                ChkSubn   L )
            SET NULL OFF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * CarregarSigSyCit - Carrega definicoes de campos de SigSyCit para este Tits
    *===========================================================================
    FUNCTION CarregarSigSyCit()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("crSigSyCit")
                USE IN crSigSyCit
            ENDIF

            *-- Test mode without DB: create empty cursor so form can initialize
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                SET NULL ON
                CREATE CURSOR crSigSyCit (Tits C(20), Campos C(10), Descs C(60), Tipos C(1), ;
                    Ordems N(3,0), Listas N(1,0), Linhas N(3,0), Files C(200), Fields C(200), ;
                    Chaves C(100), cIdChaves C(38), CampoOAs C(20), CampoDAs C(20), ;
                    Associados C(100), Cadeado N(1,0), Vinculados C(100), ;
                    Obrigatorios N(1,0), Pictures C(50))
                SET NULL OFF
                loc_lResultado = .T.
            ELSE

            loc_cSQL = "SELECT Tits, Campos, Descs, Tipos, Ordems, Listas, Linhas, Files," + ;
                       " Fields, Chaves, cIdChaves, CampoOAs, CampoDAs, Associados, Cadeado," + ;
                       " Vinculados, Obrigatorios, Pictures FROM SigSyCit" + ;
                       " WHERE Tits = " + EscaparSQL(THIS.this_cTits) + " ORDER BY Ordems"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigSyCit")
            IF loc_nResult > 0
                IF RECCOUNT("crSigSyCit") > 0
                    SELECT crSigSyCit
                    INDEX ON STR(Ordems, 2) TAG Ordems ADDITIVE
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar SigSyCit:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
            ENDIF && gnConnHandle
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * ApanhaRespostas - Carrega todas as respostas de SigSyCrs em LocalCadRs indexado
    *===========================================================================
    FUNCTION ApanhaRespostas()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("LocalCadRs")
                USE IN LocalCadRs
            ENDIF
            loc_cSQL = "SELECT Cods, Campos, CAST(Resps AS VARCHAR(8000)) AS Resps" + ;
                       " FROM SigSyCrs WHERE Tits = " + EscaparSQL(THIS.this_cTits) + ;
                       " ORDER BY Cods, Campos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalCadRs")
            IF loc_nResult > 0
                IF RECCOUNT("LocalCadRs") > 0
                    SELECT LocalCadRs
                    INDEX ON STR(Cods, 6) + Campos TAG CodCampos ADDITIVE
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar respostas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * AlimentaLista - Preenche colunas dinamicas de crSigSyCrs via LocalCadRs
    *===========================================================================
    PROCEDURE AlimentaLista()
        LOCAL loc_cCpo
        TRY
            IF USED("crSigSyCrs") AND USED("LocalCadRs") AND USED("crSigSyCit") ;
                    AND RECCOUNT("crSigSyCrs") > 0 AND RECCOUNT("crSigSyCit") > 0
                SELECT crSigSyCrs
                SCAN
                    SELECT crSigSyCit
                    SCAN
                        IF crSigSyCit.Listas = 1
                            loc_cCpo = ALLTRIM(crSigSyCit.Campos)
                            IF SEEK(STR(crSigSyCrs.Cods, 6) + crSigSyCit.Campos, ;
                                    "LocalCadRs", "CodCampos")
                                IF crSigSyCit.Tipos = "N"
                                    REPLACE &loc_cCpo. WITH VAL(LocalCadRs.Resps) IN crSigSyCrs
                                ELSE
                                    REPLACE &loc_cCpo. WITH LocalCadRs.Resps IN crSigSyCrs
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDSCAN
                    SELECT crSigSyCrs
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * Buscar - Lista registros em crSigSyCrs com colunas dinamicas de SigSyCit
    * par_cFiltro: aceita "TODAS"/"" (sem filtro), status=0 (em aberto) ou "BAIXADAS" (ChkSubn=1)
    *===========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResult, loc_lResultado, loc_cCpo
        loc_lResultado = .F.
        IF VARTYPE(par_cFiltro) <> "C"
            par_cFiltro = ""
        ENDIF
        TRY
            IF !USED("crSigSyCit")
                THIS.CarregarSigSyCit()
            ENDIF
            IF !USED("LocalCadRs")
                THIS.ApanhaRespostas()
            ENDIF
            DO CASE
                CASE UPPER(ALLTRIM(par_cFiltro)) = "PENDENTES"
                    loc_cWhere = " AND ChkSubn = 0"
                CASE UPPER(ALLTRIM(par_cFiltro)) = "BAIXADAS"
                    loc_cWhere = " AND ChkSubn = 1"
                OTHERWISE
                    loc_cWhere = ""
            ENDCASE
            loc_cSQL = "SELECT DISTINCT ChkSubn, ChkApro, Cods"
            IF USED("crSigSyCit") AND RECCOUNT("crSigSyCit") > 0
                SELECT crSigSyCit
                SCAN
                    IF crSigSyCit.Listas = 1
                        loc_cCpo = ALLTRIM(crSigSyCit.Campos)
                        DO CASE
                            CASE crSigSyCit.Tipos = "N"
                                loc_cSQL = loc_cSQL + ;
                                           ", CAST(9999999999.99 AS DECIMAL(14,2)) AS " + loc_cCpo
                            CASE crSigSyCit.Tipos = "M"
                                loc_cSQL = loc_cSQL + ", SPACE(50) AS " + loc_cCpo
                            OTHERWISE
                                loc_cSQL = loc_cSQL + ", SPACE(12) AS " + loc_cCpo
                        ENDCASE
                    ENDIF
                ENDSCAN
            ENDIF
            loc_cSQL = loc_cSQL + ;
                       " FROM SigSyCrs WHERE Tits = " + EscaparSQL(THIS.this_cTits) + ;
                       loc_cWhere + " ORDER BY Cods"
            IF USED("crSigSyCrs")
                USE IN crSigSyCrs
            ENDIF
            *-- Test mode without DB: create empty cursor
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                SET NULL ON
                CREATE CURSOR crSigSyCrs (ChkSubn L, ChkApro L, Cods N(10,0))
                SET NULL OFF
                loc_lResultado = .T.
            ELSE
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigSyCrs")
                IF loc_nResult > 0
                    THIS.AlimentaLista()
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao carregar lista:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * GerarNovoCods - Gera proximo Cods disponivel para este Tits
    *===========================================================================
    FUNCTION GerarNovoCods()
        LOCAL loc_cSQL, loc_nCods, loc_nResult
        loc_nCods = 0
        TRY
            loc_cSQL = "SELECT ISNULL(MAX(Cods), 0) + 1 AS NextCods FROM SigSyCrs" + ;
                       " WHERE Tits = " + EscaparSQL(THIS.this_cTits)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_NextCods")
                TABLEREVERT(.T., "cursor_4c_NextCods")
                USE IN cursor_4c_NextCods
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NextCods")
            IF loc_nResult > 0 AND !EOF("cursor_4c_NextCods")
                loc_nCods = cursor_4c_NextCods.NextCods
                USE IN cursor_4c_NextCods
            ELSE
                MsgErro("Erro ao gerar c" + CHR(243) + "digo:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                IF USED("cursor_4c_NextCods")
                    USE IN cursor_4c_NextCods
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_nCods
    ENDFUNC

    *===========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *===========================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nCods    = TratarNulo(Cods, "N")
                THIS.this_lChkApro = (TratarNulo(ChkApro, "N") <> 0)
                THIS.this_lChkSubn = (TratarNulo(ChkSubn, "N") <> 0)
                THIS.this_lNovoRegistro = .F.
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * CarregarPorCodigo - Carrega propriedades do BO para um Cods especifico
    *===========================================================================
    FUNCTION CarregarPorCodigo(par_nCods)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            IF !USED("LocalCadRs")
                THIS.ApanhaRespostas()
            ENDIF
            IF USED("LocalCadRs")
                THIS.this_nCods = par_nCods
                IF SEEK(STR(par_nCods, 6) + PADR("Emps", 10), "LocalCadRs", "CodCampos")
                    THIS.this_cEmps = ALLTRIM(LocalCadRs.Resps)
                ELSE
                    THIS.this_cEmps = ""
                ENDIF
                IF SEEK(STR(par_nCods, 6) + PADR("Dopes", 10), "LocalCadRs", "CodCampos")
                    THIS.this_cDopes = ALLTRIM(LocalCadRs.Resps)
                ELSE
                    THIS.this_cDopes = ""
                ENDIF
                IF SEEK(STR(par_nCods, 6) + PADR("Numes", 10), "LocalCadRs", "CodCampos")
                    THIS.this_cNumes = ALLTRIM(LocalCadRs.Resps)
                ELSE
                    THIS.this_cNumes = ""
                ENDIF
                IF SEEK(STR(par_nCods, 6) + PADR("Aprova", 10), "LocalCadRs", "CodCampos")
                    THIS.this_cAprova = ALLTRIM(LocalCadRs.Resps)
                ELSE
                    THIS.this_cAprova = ""
                ENDIF
                IF SEEK(STR(par_nCods, 6) + PADR("Datas", 10), "LocalCadRs", "CodCampos")
                    THIS.this_cDatas = ALLTRIM(LocalCadRs.Resps)
                ELSE
                    THIS.this_cDatas = ""
                ENDIF
                IF SEEK(STR(par_nCods, 6) + PADR("Baixa", 10), "LocalCadRs", "CodCampos")
                    THIS.this_cBaixa = ALLTRIM(LocalCadRs.Resps)
                ELSE
                    THIS.this_cBaixa = ""
                ENDIF
            ENDIF
            IF USED("crSigSyCrs")
                SELECT crSigSyCrs
                LOCATE FOR Cods = par_nCods
                IF !EOF("crSigSyCrs")
                    THIS.this_lChkApro = crSigSyCrs.ChkApro
                    THIS.this_lChkSubn = crSigSyCrs.ChkSubn
                    loc_lResultado = .T.
                ENDIF
            ELSE
                loc_cSQL = "SELECT TOP 1 ChkApro, ChkSubn FROM SigSyCrs" + ;
                           " WHERE Tits = " + EscaparSQL(THIS.this_cTits) + ;
                           " AND Cods = " + FormatarNumeroSQL(par_nCods)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_CarregaFlags")
                    TABLEREVERT(.T., "cursor_4c_CarregaFlags")
                    USE IN cursor_4c_CarregaFlags
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarregaFlags")
                IF loc_nResult > 0 AND !EOF("cursor_4c_CarregaFlags")
                    THIS.this_lChkApro = (cursor_4c_CarregaFlags.ChkApro <> 0)
                    THIS.this_lChkSubn = (cursor_4c_CarregaFlags.ChkSubn <> 0)
                    loc_lResultado = .T.
                ENDIF
                IF USED("cursor_4c_CarregaFlags")
                    USE IN cursor_4c_CarregaFlags
                ENDIF
            ENDIF
            IF loc_lResultado
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * SalvarCampos - PRIVADO - Executa DELETE+INSERT de crGrvCadRs em SigSyCrs
    * Retorna .T. se salvou com sucesso
    *===========================================================================
    PROTECTED FUNCTION SalvarCampos()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_lTransacao
        loc_lResultado = .F.
        loc_lTransacao = .F.
        TRY
            IF SQLEXEC(gnConnHandle, "BEGIN TRANSACTION") >= 0
                loc_lTransacao = .T.
            ELSE
                MsgErro("Erro ao iniciar transa" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF loc_lTransacao
                loc_cSQL = "DELETE FROM SigSyCrs WHERE Tits = " + ;
                           EscaparSQL(THIS.this_cTits) + ;
                           " AND Cods = " + FormatarNumeroSQL(THIS.this_nCods)
                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                    MsgErro("Erro ao excluir registros anteriores:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                    loc_lTransacao = .F.
                ENDIF
            ENDIF
            IF loc_lTransacao AND USED("crGrvCadRs") AND RECCOUNT("crGrvCadRs") > 0
                SELECT crGrvCadRs
                SCAN WHILE loc_lTransacao
                    loc_cSQL = "INSERT INTO SigSyCrs" + ;
                               " (Tits, Campos, Cods, cIdChaves, Resps, Pergs, ChkApro, ChkSubn)" + ;
                               " VALUES (" + ;
                               EscaparSQL(ALLTRIM(crGrvCadRs.Tits)) + ", " + ;
                               EscaparSQL(ALLTRIM(crGrvCadRs.Campos)) + ", " + ;
                               FormatarNumeroSQL(crGrvCadRs.Cods) + ", " + ;
                               "CAST(NEWID() AS VARCHAR(38)), " + ;
                               EscaparSQL(ALLTRIM(crGrvCadRs.Resps)) + ", " + ;
                               EscaparSQL(ALLTRIM(crGrvCadRs.Pergs)) + ", " + ;
                               IIF(crGrvCadRs.ChkApro, "1", "0") + ", " + ;
                               IIF(crGrvCadRs.ChkSubn, "1", "0") + ;
                               ")"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResult < 0
                        MsgErro("Erro ao inserir campo '" + ALLTRIM(crGrvCadRs.Campos) + ;
                                "':" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        loc_lTransacao = .F.
                    ENDIF
                ENDSCAN
            ENDIF
            IF loc_lTransacao
                IF SQLEXEC(gnConnHandle, "COMMIT TRANSACTION") >= 0
                    loc_lTransacao = .F.
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro no commit:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
            IF loc_lTransacao
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                loc_lTransacao = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF loc_lTransacao
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                loc_lTransacao = .F.
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * Inserir - Salva novo registro (chamado por BusinessBase.Salvar)
    *===========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF THIS.SalvarCampos()
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * Atualizar - Atualiza registro existente (chamado por BusinessBase.Salvar)
    * Usa padrao delete-insert identico ao original
    *===========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF THIS.SalvarCampos()
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * ExecutarExclusao - Exclui todos os campos de um registro logico (Tits+Cods)
    *===========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM SigSyCrs WHERE Tits = " + ;
                       EscaparSQL(THIS.this_cTits) + ;
                       " AND Cods = " + FormatarNumeroSQL(THIS.this_nCods)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir registro:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * Aprovar - Aprova o registro atual (seta ChkApro=.T., grava Aprova/Datas)
    * par_cUsuario: nome do usuario que esta aprovando
    *===========================================================================
    FUNCTION Aprovar(par_cUsuario)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cDataHora
        loc_lResultado = .F.
        TRY
            loc_cDataHora = TTOC(DATETIME())
            loc_cSQL = "DELETE FROM SigSyCrs WHERE Tits = " + ;
                       EscaparSQL(THIS.this_cTits) + ;
                       " AND Cods = " + FormatarNumeroSQL(THIS.this_nCods) + ;
                       " AND Campos IN ('Aprova', 'Datas')"
            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_cSQL = "INSERT INTO SigSyCrs" + ;
                       " (Tits, Campos, Cods, cIdChaves, Resps, Pergs, ChkApro, ChkSubn)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cTits) + ", 'Aprova', " + ;
                       FormatarNumeroSQL(THIS.this_nCods) + ", " + ;
                       "CAST(NEWID() AS VARCHAR(38)), " + ;
                       EscaparSQL(ALLTRIM(par_cUsuario)) + ", 'Aprovado', 1, 0)"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_cSQL = "INSERT INTO SigSyCrs" + ;
                           " (Tits, Campos, Cods, cIdChaves, Resps, Pergs, ChkApro, ChkSubn)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cTits) + ", 'Datas', " + ;
                           FormatarNumeroSQL(THIS.this_nCods) + ", " + ;
                           "CAST(NEWID() AS VARCHAR(38)), " + ;
                           EscaparSQL(loc_cDataHora) + ", 'Data', 1, 0)"
                SQLEXEC(gnConnHandle, loc_cSQL)
                loc_cSQL = "UPDATE SigSyCrs SET ChkApro = 1" + ;
                           " WHERE Tits = " + EscaparSQL(THIS.this_cTits) + ;
                           " AND Cods = " + FormatarNumeroSQL(THIS.this_nCods)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult >= 0
                    THIS.this_lChkApro = .T.
                    THIS.this_cAprova  = ALLTRIM(par_cUsuario)
                    THIS.this_cDatas   = loc_cDataHora
                    THIS.ApanhaRespostas()
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao aprovar registro:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao gravar aprovador:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * Desaprovar - Remove aprovacao do registro atual (seta ChkApro=.F.)
    *===========================================================================
    FUNCTION Desaprovar()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM SigSyCrs WHERE Tits = " + ;
                       EscaparSQL(THIS.this_cTits) + ;
                       " AND Cods = " + FormatarNumeroSQL(THIS.this_nCods) + ;
                       " AND Campos IN ('Aprova', 'Datas')"
            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_cSQL = "UPDATE SigSyCrs SET ChkApro = 0" + ;
                       " WHERE Tits = " + EscaparSQL(THIS.this_cTits) + ;
                       " AND Cods = " + FormatarNumeroSQL(THIS.this_nCods)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.this_lChkApro = .F.
                THIS.this_cAprova  = ""
                THIS.this_cDatas   = ""
                THIS.ApanhaRespostas()
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao desaprovar registro:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * CancelarBaixa - Cancela baixa do registro (seta ChkSubn=.F., remove campos de baixa)
    *===========================================================================
    FUNCTION CancelarBaixa(par_nCods)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM SigSyCrs WHERE Tits = " + ;
                       EscaparSQL(THIS.this_cTits) + ;
                       " AND Cods = " + FormatarNumeroSQL(par_nCods) + ;
                       " AND Campos IN ('Emps', 'Dopes', 'Numes', 'Baixa')"
            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_cSQL = "UPDATE SigSyCrs SET ChkSubn = 0" + ;
                       " WHERE Tits = " + EscaparSQL(THIS.this_cTits) + ;
                       " AND Cods = " + FormatarNumeroSQL(par_nCods)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.this_lChkSubn = .F.
                THIS.this_cEmps    = ""
                THIS.this_cDopes   = ""
                THIS.this_cNumes   = ""
                THIS.this_cBaixa   = ""
                THIS.ApanhaRespostas()
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao cancelar baixa:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

