# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNLIQ, CONTAS, CIDCHAVES, CODIGO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNLIQ, CONTAS, CIDCHAVES, CODIGO

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
  ControlSource = "crSigCdCcj.Contas"
  ControlSource = ""
  DeleteMark = .F.
  ControlSource = "crSigCdCcj.data_base"
  ControlSource = "crSigCdCcj.Fator"
  ControlSource = "crSigCdCcj.Total"
  ControlSource = "crSigCdCcj.TotLiq"
Select crSigCdCcj 
Select a.Codigo, a.Data_Base, a.Fator, a.Contas, a.Total, a.TotLiq, Space(40) as DesConta, b.Datas, b.Valor, b.liquido, b.Dias ;
From crSigCdCcj a ;
Join crDetalhe b on a.Codigo = b.Codigo ;
Select CsRel
Select CsRel
nOldSele = Select()
Select crDetalhe
	Select crDetalhe
Select Count(*) As Qtd, Sum(Valor) As Valor, Sum(Liquido) As Liquido, Avg(Dias) As MedDias ;
	From crDetalhe ;
Select CsQtdDt
Select crDetalhe
Select(nOldSele)
	Select crDetalhe
Select Count(*) As Qtd, Sum(Valor) As Valor, Sum(Liquido) As Liquido, Avg(Dias) as MedDias ;
	From crDetalhe;
Select CsQtdDt
Select crSigCdCcj
If Not Thisform.poDataMgr.Update('crSigCdCcj')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Insert - crSigCdCcj )')
If Not Thisform.poDataMgr.Update('crSigDtCcj')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Insert - crSigDtCcj )')
Select crSigDtCcj
	lcUpdate = [Update SigDtCcj Set Datas = ?pDt where cidchaves = ']+crSigDtCcj.cidchaves+[' ]
	If Thisform.poDataMgr.SQLExecute(lcUpdate) < 1
		=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigDtCcj )')
Select crSigCdCcj
Select crSigCdCcj
Delete For Codigo = pChave
Select crSigDtCcj
Delete For Codigo = pChave
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdCcj Where Codigo = ?pChave], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigDtCcj Where Codigo = ?pChave], '') < 1)
	If Not ThisForm.poDataMgr.Update('crSigCdCcj')
	If Not ThisForm.poDataMgr.Update('crSigDtCcj')
Select crSigCdCcj
	If (Thisform.poDataMgr.SQLExecute([Delete From SigCdCcj Where Codigo = ?pChave], '') < 1)
	If (Thisform.poDataMgr.SQLExecute([Delete From SigDtCcj Where Codigo = ?pChave], '') < 1)
If Not Thisform.poDataMgr.Update('crSigCdCcj')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdCcj )')
If Not Thisform.poDataMgr.Update('crSigDtCcj')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigDtCcj )')
Select crSigDtCcj
	lcUpdate = [Update SigDtCcj Set Datas = ?pDt where cidchaves = ']+crSigDtCcj.cidchaves+[' ]
	If Thisform.poDataMgr.SQLExecute(lcUpdate) < 1
		=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigDtCcj )')
lcQuery = [Select a.*, b.rclis as desconta from sigcdccj a join sigcdcli b on a.contas = b.iclis]
Select * From crSigDtCcj Into Cursor crDetalhe Readwrite
Select crDetalhe
	.column1.ControlSource = 'crDetalhe.Datas'
	.Column2.ControlSource = 'crDetalhe.Valor'
	.column3.ControlSource = 'crDetalhe.Dias'
	.Column4.ControlSource = 'crDetalhe.Liquido'
Select crDetalhe
lcSql = [Select * From SIgDtCcj Where codigo = ']+lcCod+[' ]
=Thisform.PodataMgr.SqlExecute(lcSql,'TmpDet')
Select TmpDet
	Select crDetalhe
Select crDetalhe
Select Count(*) As Qtd, Avg(Dias) as MedDias ; 
	From crDetalhe ;
Select CsQtdDt
Select crSigCdCcj
Select crSigCdCcj
	Select crDetalhe
	Select crSigDtCcj
	Select crDetalhe
	Delete From crDetalhe where Empty(DataS)
			Select crSigDtCcj
			If Deleted('crDetalhe')
				Delete
		Select crDetalhe
Select crSigCdCcj
Select crSigDtCcj
		select crSigCdCcj
	select crSigCdCcj
	Select crCli
		select crSigCdCcj
	select crSigCdCcj
	Select crCli
Select crSigCdCcj
Select crDetalhe
	Insert into crDetalhe(codigo) values (lcCod)
Select crSigCdCcj
Select crDetalhe
Select crDetalhe
SELECT crDetalhe
Delete

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormCCJ.prg) - TRECHOS RELEVANTES PARA PASS SQL (1834 linhas total):

*-- Linhas 356 a 374:
356:             .HighlightBackColor = RGB(255, 255, 255)
357:             .HighlightForeColor = RGB(15, 41, 104)
358:             .HighlightStyle     = 2
359:             .DeleteMark         = .F.
360:             .RecordMark         = .F.
361:             .RowHeight          = 16
362:             .ScrollBars         = 2
363:             .GridLines          = 3
364:             .ReadOnly           = .T.
365:             .Visible            = .T.
366:         ENDWITH
367: 
368:         THIS.TornarControlesVisiveis(loc_oPg1)
369:     ENDPROC
370: 
371:     *--------------------------------------------------------------------------
372:     * ConfigurarPaginaDados - Cria containers da Page2 (Dados)
373:     * Fase 3: cnt_4c_BotoesAcao com Confirmar/Cancelar
374:     * Fase 5: BtnRec/BtnVideo + campos Conta/DataBase/Fator/OptDias

*-- Linhas 709 a 759:
709:             .HighlightBackColor = RGB(255, 255, 255)
710:             .HighlightForeColor = RGB(15, 41, 104)
711:             .HighlightStyle     = 2
712:             .DeleteMark         = .F.
713:             .RecordMark         = .F.
714:             .RowHeight          = 18
715:             .ScrollBars         = 2
716:             .GridLines          = 3
717:             .ReadOnly           = .F.
718:             .Visible            = .T.
719:         ENDWITH
720: 
721:         loc_oGrdDet.Column1.Header1.Caption  = "Data"
722:         loc_oGrdDet.Column1.Width            = 90
723:         loc_oGrdDet.Column1.Sparse           = .F.
724:         loc_oGrdDet.Column1.ReadOnly         = .F.
725:         loc_oGrdDet.Column1.ControlSource    = ""
726:         loc_oGrdDet.Column1.Text1.InputMask  = "99/99/9999"
727: 
728:         loc_oGrdDet.Column2.Header1.Caption  = "Valor"
729:         loc_oGrdDet.Column2.Width            = 90
730:         loc_oGrdDet.Column2.Sparse           = .F.
731:         loc_oGrdDet.Column2.ReadOnly         = .F.
732:         loc_oGrdDet.Column2.ControlSource    = ""
733: 
734:         loc_oGrdDet.Column3.Header1.Caption  = "Dias"
735:         loc_oGrdDet.Column3.Width            = 45
736:         loc_oGrdDet.Column3.Sparse           = .F.
737:         loc_oGrdDet.Column3.ReadOnly         = .T.
738:         loc_oGrdDet.Column3.ControlSource    = ""
739: 
740:         loc_oGrdDet.Column4.Header1.Caption  = "Valor Liquido"
741:         loc_oGrdDet.Column4.Width            = 130
742:         loc_oGrdDet.Column4.Sparse           = .F.
743:         loc_oGrdDet.Column4.ReadOnly         = .T.
744:         loc_oGrdDet.Column4.ControlSource    = ""
745: 
746:         BINDEVENT(loc_oGrdDet.Column2.Text1, "LostFocus", THIS, "RecalcularItem")
747:         BINDEVENT(loc_oGrdDet.Column1.Text1, "KeyPress", THIS, "ValidarDataDetalhe")
748: 
749:         *-- Botao InserirV (original top=317 -> compensado=346, left=630, 45x45)
750:         loc_oPg2.AddObject("cmd_4c_InserirV", "CommandButton")
751:         WITH loc_oPg2.cmd_4c_InserirV
752:             .Caption         = "Inserir"
753:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
754:             .PicturePosition = 13
755:             .Top             = 346
756:             .Left            = 630
757:             .Width           = 45
758:             .Height          = 45
759:             .BackColor       = RGB(255, 255, 255)

*-- Linhas 1044 a 1076:
1044:     ENDPROC
1045: 
1046:     *--------------------------------------------------------------------------
1047:     * AtualizarGrid - Wire RecordSource/ControlSource/Headers do grd_4c_Lista
1048:     *--------------------------------------------------------------------------
1049:     PROTECTED PROCEDURE AtualizarGrid()
1050:         LOCAL loc_oGrid
1051:         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1052: 
1053:         loc_oGrid.ColumnCount = 6
1054:         loc_oGrid.RecordSource = "cursor_4c_Dados"
1055: 
1056:         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.contas"
1057:         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.desconta"
1058:         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.data_base"
1059:         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.fator"
1060:         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.total"
1061:         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.totliq"
1062: 
1063:         loc_oGrid.Column1.Width = 80
1064:         loc_oGrid.Column2.Width = 300
1065:         loc_oGrid.Column3.Width = 100
1066:         loc_oGrid.Column4.Width = 60
1067:         loc_oGrid.Column5.Width = 100
1068:         loc_oGrid.Column6.Width = 100
1069: 
1070:         loc_oGrid.Column1.Header1.Caption = "Conta"
1071:         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1072:         loc_oGrid.Column3.Header1.Caption = "Data Base"
1073:         loc_oGrid.Column4.Header1.Caption = "Fator"
1074:         loc_oGrid.Column5.Header1.Caption = "Total"
1075:         loc_oGrid.Column6.Header1.Caption = "Valor Liquido"
1076: 

*-- Linhas 1128 a 1146:
1128:         loc_cCodigo = ""
1129: 
1130:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1131:             SELECT cursor_4c_Dados
1132:             loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.codigo, ""))
1133:         ENDIF
1134: 
1135:         IF EMPTY(loc_cCodigo)
1136:             MsgAviso("Selecione um registro na lista.", "Visualizar")
1137:             RETURN
1138:         ENDIF
1139: 
1140:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1141:             THIS.this_oBusinessObject.BuscarDetalhe(loc_cCodigo)
1142:             THIS.AtualizarGradeDetalhe()
1143:             THIS.this_cModoAtual = "VISUALIZAR"
1144:             THIS.BOParaForm()
1145:             THIS.HabilitarCampos(.F.)
1146:             THIS.AjustarBotoesPorModo()

*-- Linhas 1156 a 1174:
1156:         loc_cCodigo = ""
1157: 
1158:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1159:             SELECT cursor_4c_Dados
1160:             loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.codigo, ""))
1161:         ENDIF
1162: 
1163:         IF EMPTY(loc_cCodigo)
1164:             MsgAviso("Selecione um registro na lista.", "Alterar")
1165:             RETURN
1166:         ENDIF
1167: 
1168:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1169:             THIS.this_oBusinessObject.BuscarDetalhe(loc_cCodigo)
1170:             THIS.AtualizarGradeDetalhe()
1171:             THIS.this_oBusinessObject.EditarRegistro()
1172:             THIS.this_cModoAtual = "ALTERAR"
1173:             THIS.BOParaForm()
1174:             THIS.HabilitarCampos(.T.)

*-- Linhas 1186 a 1204:
1186:         loc_lConfirma = .F.
1187: 
1188:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1189:             SELECT cursor_4c_Dados
1190:             loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.codigo, ""))
1191:         ENDIF
1192: 
1193:         IF EMPTY(loc_cCodigo)
1194:             MsgAviso("Selecione um registro na lista.", "Excluir")
1195:             RETURN
1196:         ENDIF
1197: 
1198:         loc_lConfirma = MsgConfirma("Deseja excluir o c" + CHR(225) + ;
1199:             "lculo de juros selecionado?", "Excluir")
1200:         IF !loc_lConfirma
1201:             RETURN
1202:         ENDIF
1203: 
1204:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)

*-- Linhas 1483 a 1511:
1483:             IF VARTYPE(loc_oBusca) = "O"
1484:                 IF loc_oBusca.this_lAchouRegistro AND loc_oBusca.this_lSelecionou
1485:                     IF USED("cursor_4c_BuscaConta")
1486:                         SELECT cursor_4c_BuscaConta
1487:                         loc_oPg2.txt_4c_Contas.Value  = ALLTRIM(NVL(iclis, ""))
1488:                         loc_oPg2.txt_4c_DContas.Value = ALLTRIM(NVL(rclis, ""))
1489:                     ENDIF
1490:                 ELSE
1491:                     IF !loc_oBusca.this_lAchouRegistro
1492:                     loc_oBusca.mAddColuna("iclis", "", "Conta")
1493:                     loc_oBusca.mAddColuna("rclis", "", "Nome")
1494:                     loc_oBusca.Show()
1495:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1496:                         SELECT cursor_4c_BuscaConta
1497:                         loc_oPg2.txt_4c_Contas.Value  = ALLTRIM(NVL(iclis, ""))
1498:                         loc_oPg2.txt_4c_DContas.Value = ALLTRIM(NVL(rclis, ""))
1499:                     ELSE
1500:                         loc_oPg2.txt_4c_Contas.Value  = ""
1501:                         loc_oPg2.txt_4c_DContas.Value = ""
1502:                     ENDIF
1503:                     ENDIF
1504:                 ENDIF
1505:                 loc_oBusca.Release()
1506:             ENDIF
1507: 
1508:             IF USED("cursor_4c_BuscaConta")
1509:                 USE IN cursor_4c_BuscaConta
1510:             ENDIF
1511:         CATCH TO loc_oErro

*-- Linhas 1540 a 1584:
1540:     ENDPROC
1541: 
1542:     *--------------------------------------------------------------------------
1543:     * AtualizarGradeDetalhe - Wira RecordSource/ControlSources do grd_4c_Detalhe
1544:     * Chamado apos BuscarDetalhe() para associar grid ao cursor de detalhe
1545:     *--------------------------------------------------------------------------
1546:     PROTECTED PROCEDURE AtualizarGradeDetalhe()
1547:         LOCAL loc_oPg2, loc_oGrd, loc_cAlias
1548:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1549:         loc_cAlias = THIS.this_oBusinessObject.this_cCursorDetalhe
1550: 
1551:         IF !PEMSTATUS(loc_oPg2, "grd_4c_Detalhe", 5)
1552:             RETURN
1553:         ENDIF
1554: 
1555:         TRY
1556:             loc_oGrd = loc_oPg2.grd_4c_Detalhe
1557: 
1558:             IF USED(loc_cAlias)
1559:                 loc_oGrd.RecordSource          = loc_cAlias
1560:                 loc_oGrd.Column1.ControlSource = loc_cAlias + ".datas"
1561:                 loc_oGrd.Column2.ControlSource = loc_cAlias + ".valor"
1562:                 loc_oGrd.Column3.ControlSource = loc_cAlias + ".dias"
1563:                 loc_oGrd.Column4.ControlSource = loc_cAlias + ".liquido"
1564:             ELSE
1565:                 loc_oGrd.RecordSource          = ""
1566:                 loc_oGrd.Column1.ControlSource = ""
1567:                 loc_oGrd.Column2.ControlSource = ""
1568:                 loc_oGrd.Column3.ControlSource = ""
1569:                 loc_oGrd.Column4.ControlSource = ""
1570:             ENDIF
1571: 
1572:             loc_oGrd.Refresh()
1573:         CATCH TO loc_oErro
1574:             MsgErro(loc_oErro.Message, "AtualizarGradeDetalhe")
1575:         ENDTRY
1576:     ENDPROC
1577: 
1578:     *--------------------------------------------------------------------------
1579:     * AtualizarTotais - Escaneia cursor de detalhe e atualiza campos de totais
1580:     * Chamado apos Recalcular(), ExcluirVClick() e BOParaForm()
1581:     *--------------------------------------------------------------------------
1582:     PROTECTED PROCEDURE AtualizarTotais()
1583:         LOCAL loc_oPg2, loc_cAlias
1584:         LOCAL loc_nQtde, loc_nTotalDias, loc_nTotal, loc_nTotLiq, loc_nDias

*-- Linhas 1596 a 1614:
1596: 
1597:         TRY
1598:             IF USED(loc_cAlias)
1599:                 SELECT (loc_cAlias)
1600:                 SCAN
1601:                     IF !EMPTY(datas)
1602:                         loc_nQtde      = loc_nQtde + 1
1603:                         loc_nDias      = NVL(dias, 0)
1604:                         loc_nTotalDias = loc_nTotalDias + loc_nDias
1605:                         loc_nTotal     = loc_nTotal + NVL(valor, 0)
1606:                         loc_nTotLiq    = loc_nTotLiq + NVL(liquido, 0)
1607:                     ENDIF
1608:                 ENDSCAN
1609:             ENDIF
1610: 
1611:             loc_oPg2.txt_4c_Qtde.Value   = loc_nQtde
1612:             loc_oPg2.txt_4c_Media.Value  = IIF(loc_nQtde > 0, loc_nTotalDias / loc_nQtde, 0)
1613:             loc_oPg2.txt_4c_Total.Value  = loc_nTotal
1614:             loc_oPg2.txt_4c_TotLiq.Value = loc_nTotLiq

*-- Linhas 1656 a 1674:
1656:                 RETURN
1657:             ENDIF
1658: 
1659:             SELECT (loc_cAlias)
1660: 
1661:             IF !EOF() AND !BOF() AND !EMPTY(datas) AND YEAR(TTOD(datas)) < 1900
1662:                 REPLACE datas WITH {}
1663:                 loc_oPg2.grd_4c_Detalhe.Refresh()
1664:             ENDIF
1665:         CATCH TO loc_oErro
1666:             MsgErro(loc_oErro.Message, "ValidarDataDetalhe")
1667:         ENDTRY
1668:     ENDPROC
1669: 
1670:     *--------------------------------------------------------------------------
1671:     * InserirVClick - Adiciona nova linha em branco ao cursor de detalhe
1672:     *--------------------------------------------------------------------------
1673:     PROCEDURE InserirVClick()
1674:         LOCAL loc_cAlias, loc_oPg2

*-- Linhas 1680 a 1698:
1680:         ENDIF
1681: 
1682:         TRY
1683:             SELECT (loc_cAlias)
1684:             APPEND BLANK
1685:             REPLACE cidchaves WITH "", ;
1686:                     codigo    WITH THIS.this_oBusinessObject.this_cCodigo, ;
1687:                     datas     WITH {}, ;
1688:                     dias      WITH 0, ;
1689:                     liquido   WITH 0, ;
1690:                     valor     WITH 0
1691: 
1692:             IF PEMSTATUS(loc_oPg2, "grd_4c_Detalhe", 5)
1693:                 loc_oPg2.grd_4c_Detalhe.Refresh()
1694:             ENDIF
1695:         CATCH TO loc_oErro
1696:             MsgErro(loc_oErro.Message, "InserirVClick")
1697:         ENDTRY
1698:     ENDPROC

*-- Linhas 1712 a 1757:
1712:             RETURN
1713:         ENDIF
1714: 
1715:         SELECT (loc_cAlias)
1716:         IF RECCOUNT() = 0 OR EOF()
1717:             MsgAviso("Nenhuma linha selecionada.", "Excluir")
1718:             RETURN
1719:         ENDIF
1720: 
1721:         loc_lConfirma = MsgConfirma("Deseja excluir a linha selecionada?", "Excluir")
1722:         IF !loc_lConfirma
1723:             RETURN
1724:         ENDIF
1725: 
1726:         TRY
1727:             *-- Marca e reconstroi cursor sem o registro (DELETE + SELECT WHERE !DELETED())
1728:             SELECT (loc_cAlias)
1729:             DELETE
1730: 
1731:             IF USED(loc_cTemp)
1732:                 USE IN (loc_cTemp)
1733:             ENDIF
1734: 
1735:             SELECT cidchaves, codigo, datas, dias, liquido, valor ;
1736:                 FROM (loc_cAlias) WHERE !DELETED() ;
1737:                 INTO CURSOR (loc_cTemp) READWRITE
1738: 
1739:             USE IN (loc_cAlias)
1740: 
1741:             SELECT cidchaves, codigo, datas, dias, liquido, valor ;
1742:                 FROM (loc_cTemp) ;
1743:                 INTO CURSOR (loc_cAlias) READWRITE
1744: 
1745:             IF USED(loc_cTemp)
1746:                 USE IN (loc_cTemp)
1747:             ENDIF
1748: 
1749:             THIS.AtualizarGradeDetalhe()
1750:             THIS.AtualizarTotais()
1751:         CATCH TO loc_oErro
1752:             MsgErro(loc_oErro.Message, "ExcluirVClick")
1753:             IF USED(loc_cTemp)
1754:                 USE IN (loc_cTemp)
1755:             ENDIF
1756:         ENDTRY
1757:     ENDPROC


### BO (C:\4c\projeto\app\classes\CCJBO.prg):
*============================================================================
* CCJBO.prg - Business Object para Calculo de Juros
*
* Tabela principal : SigCdCcj  (PK: codigo char(6))
* Tabela detalhe   : SigDtCcj  (PK: cidchaves char(20), FK: codigo char(6))
* Lookup conta     : SigCdCli  (PK: Iclis, desc: Rclis)
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS CCJBO AS BusinessBase

    *==========================================================================
    * Propriedades da entidade SigCdCcj (campos do banco)
    *==========================================================================
    this_cCodigo   = ""    && char(6)       - Chave primaria (gerada externamente)
    this_cContas   = ""    && char(10)      - Conta (FK SigCdCli.Iclis)
    this_dDataBase = {}    && datetime NULL - Data Base para calculo de juros
    this_nFator    = 0     && numeric(5,2)  - Fator de juros (porcentagem)
    this_nTotal    = 0     && numeric(11,2) - Total bruto dos documentos
    this_nTotLiq   = 0     && numeric(11,2) - Total liquido apos calculo de juros

    *==========================================================================
    * Propriedades de exibicao - nao armazenadas no banco
    *==========================================================================
    this_cDContas   = ""   && Descricao da conta (SigCdCli.Rclis, exibicao)
    this_nQtde      = 0    && Quantidade de documentos no detalhe (calculada)
    this_nMedia     = 0    && Media de dias calculados
    this_nTiposDias = 1    && Tipo calculo: 1=Corridos, 2=Uteis (optDias.Value)

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdCcj"
            THIS.this_cCampoChave = "codigo"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- Alias do cursor de detalhe (SigDtCcj)
    this_cCursorDetalhe = "cursor_4c_Detalhe"

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da PK para RegistrarAuditoria
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo   = ALLTRIM(TratarNulo(codigo, "C"))
            THIS.this_cContas   = ALLTRIM(TratarNulo(contas, "C"))
            THIS.this_dDataBase = TratarNulo(data_base, "D")
            THIS.this_nFator    = TratarNulo(fator, "N")
            THIS.this_nTotal    = TratarNulo(total, "N")
            THIS.this_nTotLiq   = TratarNulo(totliq, "N")
            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - SELECT com JOIN SigCdCli para o grid da lista
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cWhere
        loc_lSucesso = .F.
        loc_cWhere   = ""

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT a.codigo, a.contas, a.data_base, a.fator, a.total, a.totliq," + ;
                       " ISNULL(b.rclis, '') AS desconta" + ;
                       " FROM sigcdccj a" + ;
                       " LEFT JOIN sigcdcli b ON b.iclis = a.contas"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE a.contas LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                             " OR ISNULL(b.rclis, '') LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%")
                loc_cSQL = loc_cSQL + loc_cWhere
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.contas, a.data_base DESC"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar C" + CHR(225) + "lculo de Juros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - SELECT pelo codigo (PK) para edicao/visualizacao
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT codigo, contas, data_base, fator, total, totliq" + ;
                       " FROM sigcdccj" + ;
                       " WHERE codigo = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GerarCodigo - Gera codigo unico de 6 chars via SQL Server NEWID()
    *==========================================================================
    PROCEDURE GerarCodigo()
        LOCAL loc_cSQL, loc_nResultado, loc_cNovoCodigo
        loc_cNovoCodigo = ""

        TRY
            IF USED("cursor_4c_GerarCod")
                USE IN cursor_4c_GerarCod
            ENDIF

            loc_cSQL = "SELECT UPPER(LEFT(REPLACE(NEWID(), '-', ''), 6)) AS novoCodigo"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GerarCod")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_GerarCod") > 0
                SELECT cursor_4c_GerarCod
                loc_cNovoCodigo = ALLTRIM(novoCodigo)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_GerarCod")
            USE IN cursor_4c_GerarCod
        ENDIF

        RETURN loc_cNovoCodigo
    ENDPROC

    *==========================================================================
    * BuscarDetalhe - Carrega linhas de SigDtCcj para cursor de detalhe
    *                 Se par_cCodigo vazio, cria cursor vazio com a estrutura
    *==========================================================================
    PROCEDURE BuscarDetalhe(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorDetalhe)
                USE IN (THIS.this_cCursorDetalhe)
            ENDIF

            IF EMPTY(ALLTRIM(par_cCodigo))
                SET NULL ON
                CREATE CURSOR (THIS.this_cCursorDetalhe) ;
                    (cidchaves C(20), codigo C(6), datas T, ;
                     dias N(3,0), liquido N(11,2), valor N(11,2))
                SET NULL OFF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT cidchaves, codigo, datas, dias, liquido, valor" + ;
                           " FROM sigdtccj" + ;
                           " WHERE codigo = " + EscaparSQL(par_cCodigo) + ;
                           " ORDER BY datas"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DetLoad")

                IF loc_nResultado > 0
                    *-- Converte para READWRITE (SQLEXEC gera somente-leitura por padrao)
                    *-- Necessario para APPEND BLANK (InserirV) e REPLACE (Recalcular)
                    SELECT cidchaves, codigo, datas, dias, liquido, valor ;
                        FROM cursor_4c_DetLoad ;
                        INTO CURSOR (THIS.this_cCursorDetalhe) READWRITE
                    IF USED("cursor_4c_DetLoad")
                        USE IN cursor_4c_DetLoad
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao carregar detalhe:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarContaPorCodigo - Valida e retorna descricao de SigCdCli
    *==========================================================================
    PROCEDURE BuscarContaPorCodigo(par_cConta)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(par_cConta))
            THIS.this_cDContas = ""
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF

            loc_cSQL = "SELECT iclis, rclis" + ;
                       " FROM sigcdcli" + ;
                       " WHERE iclis = " + EscaparSQL(par_cConta)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaConta") > 0
                SELECT cursor_4c_BuscaConta
                THIS.this_cDContas = ALLTRIM(NVL(rclis, ""))
                loc_lSucesso = .T.
            ELSE
                THIS.this_cDContas = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InserirDetalhe - PROTECTED: persiste cursor de detalhe em sigdtccj
    *==========================================================================
    PROTECTED PROCEDURE InserirDetalhe()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cAlias
        LOCAL loc_cCodigo, loc_dDatas, loc_nDias, loc_nLiquido, loc_nValor
        loc_lSucesso = .T.
        loc_cAlias   = THIS.this_cCursorDetalhe

        IF !USED(loc_cAlias)
            RETURN .T.
        ENDIF

        TRY
            SELECT (loc_cAlias)
            GO TOP

            SCAN
                IF EMPTY(datas)
                    LOOP
                ENDIF

                loc_cCodigo  = THIS.this_cCodigo
                loc_dDatas   = datas
                loc_nDias    = NVL(dias, 0)
                loc_nLiquido = NVL(liquido, 0)
                loc_nValor   = NVL(valor, 0)

                loc_cSQL = "INSERT INTO sigdtccj" + ;
                           " (cidchaves, codigo, datas, dias, liquido, valor)" + ;
                           " VALUES (" + ;
                           " LEFT(REPLACE(NEWID(), '-', ''), 20)," + ;
                           EscaparSQL(loc_cCodigo) + "," + ;
                           FormatarDataSQL(loc_dDatas) + "," + ;
                           FormatarNumeroSQL(loc_nDias) + "," + ;
                           FormatarNumeroSQL(loc_nLiquido) + "," + ;
                           FormatarNumeroSQL(loc_nValor) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    MsgErro("Erro ao inserir linha de detalhe:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                    EXIT
                ENDIF
            ENDSCAN
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - PROTECTED: INSERT em sigcdccj + linhas sigdtccj
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO sigcdccj (codigo, contas, data_base, fator, total, totliq)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo) + "," + ;
                       EscaparSQL(THIS.this_cContas) + "," + ;
                       FormatarDataSQL(THIS.this_dDataBase) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFator) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTotal) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTotLiq) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                IF THIS.InserirDetalhe()
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MsgErro("Erro ao inserir C" + CHR(225) + "lculo de Juros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - PROTECTED: DELETE+INSERT (padrao legado msv_alterar)
    *             Delete cabecalho + detalhe antigos, reinsere com novos valores
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- DELETE detalhe primeiro (FK)
            loc_cSQL = "DELETE FROM sigdtccj WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao remover detalhe para atualizar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- DELETE cabecalho
            loc_cSQL = "DELETE FROM sigcdccj WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao remover cabecalho para atualizar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- RE-INSERT cabecalho com valores atualizados
            loc_cSQL = "INSERT INTO sigcdccj (codigo, contas, data_base, fator, total, totliq)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo) + "," + ;
                       EscaparSQL(THIS.this_cContas) + "," + ;
                       FormatarDataSQL(THIS.this_dDataBase) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFator) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTotal) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTotLiq) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                IF THIS.InserirDetalhe()
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MsgErro("Erro ao reinserir C" + CHR(225) + "lculo de Juros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - PROTECTED: DELETE de sigdtccj e sigcdccj
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- DELETE detalhe primeiro (integridade referencial)
            loc_cSQL = "DELETE FROM sigdtccj WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao excluir detalhe:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- DELETE cabecalho
            loc_cSQL = "DELETE FROM sigcdccj WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir C" + CHR(225) + "lculo de Juros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Recalcular - Recalcula juros de cada linha do detalhe
    * Prerequisito: this_dDataBase, this_nFator e this_nTiposDias setados
    * Atualiza Dias/Liquido no cursor_4c_Detalhe e acumula this_n* totais
    *==========================================================================
    PROCEDURE Recalcular()
        LOCAL loc_lSucesso, loc_cAlias
        LOCAL loc_dBase, loc_nFator, loc_nTipo
        LOCAL loc_nQtde, loc_nTotalDias, loc_nTotal, loc_nTotLiq
        LOCAL loc_nDias, loc_nLiquido, loc_dDatas_d, loc_dBase_d, loc_nValor

        loc_lSucesso   = .F.
        loc_cAlias     = THIS.this_cCursorDetalhe
        loc_dBase      = THIS.this_dDataBase
        loc_nFator     = THIS.this_nFator
        loc_nTipo      = THIS.this_nTiposDias
        loc_nQtde      = 0
        loc_nTotalDias = 0
        loc_nTotal     = 0
        loc_nTotLiq    = 0

        IF !USED(loc_cAlias)
            MsgErro("Cursor de detalhe n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Recalcular")
            RETURN .F.
        ENDIF

        IF EMPTY(loc_dBase)
            MsgErro("Data Base n" + CHR(227) + "o informada.", "Recalcular")
            RETURN .F.
        ENDIF

        TRY
            loc_dBase_d = TTOD(loc_dBase)

            SELECT (loc_cAlias)
            GO TOP

            SCAN
                IF EMPTY(datas)
                    LOOP
                ENDIF

                loc_dDatas_d = TTOD(datas)
                loc_nValor   = NVL(valor, 0)
                loc_nDias    = loc_dDatas_d - loc_dBase_d

                IF loc_nDias < 0
                    loc_nDias = 0
                ENDIF

                IF loc_nDias > 0 AND loc_nTipo = 2
                    loc_nDias = THIS.ContarDiasUteis(loc_dBase_d, loc_dDatas_d)
                ENDIF

                loc_nLiquido = loc_nValor + loc_nValor * (loc_nFator / 100) * loc_nDias

                REPLACE dias WITH loc_nDias, liquido WITH loc_nLiquido

                loc_nQtde      = loc_nQtde + 1
                loc_nTotalDias = loc_nTotalDias + loc_nDias
                loc_nTotal     = loc_nTotal + loc_nValor
                loc_nTotLiq    = loc_nTotLiq + loc_nLiquido
            ENDSCAN

            THIS.this_nQtde   = loc_nQtde
            THIS.this_nMedia  = IIF(loc_nQtde > 0, loc_nTotalDias / loc_nQtde, 0)
            THIS.this_nTotal  = loc_nTotal
            THIS.this_nTotLiq = loc_nTotLiq

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Recalcular")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ContarDiasUteis - Conta dias seg-sex entre par_dInicio e par_dFim (inc.)
    *==========================================================================
    PROTECTED PROCEDURE ContarDiasUteis(par_dInicio, par_dFim)
        LOCAL loc_nCount, loc_dCurrent, loc_nDow
        loc_nCount   = 0
        loc_dCurrent = par_dInicio

        DO WHILE loc_dCurrent <= par_dFim
            loc_nDow = DOW(loc_dCurrent)
            IF loc_nDow != 1 AND loc_nDow != 7
                loc_nCount = loc_nCount + 1
            ENDIF
            loc_dCurrent = loc_dCurrent + 1
        ENDDO

        RETURN loc_nCount
    ENDPROC

ENDDEFINE

