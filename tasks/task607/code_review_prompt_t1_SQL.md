# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GCTPINSTALAS, CPROS, CITENS, EMPDOPNUMS, BLQDATAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GCTPINSTALAS, CPROS, CITENS, EMPDOPNUMS, BLQDATAS

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
  Pagina.Lista.Grade.Column2.ControlSource = ""
  Pagina.Lista.Grade.Column3.ControlSource = ""
  Pagina.Lista.Grade.Column4.ControlSource = ""
  Pagina.Lista.Grade.Column5.ControlSource = ""
  Pagina.Lista.Grade.Column6.ControlSource = ""
  Pagina.Lista.Grade.Column7.ControlSource = ""
  ControlSource = "xEestI.DPros"
  DeleteMark = .F.
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  Column7.ControlSource = ""
  Column10.SelectOnEntry = .T.
  ControlSource = "xeesti.citens"
  ControlSource = "csTemporario.grupoos"
  ControlSource = "csTemporario.contaos"
  ControlSource = ""
  ControlSource = "csTemporario.grupods"
  ControlSource = "csTemporario.contads"
  ControlSource = ""
  ControlSource = "csTemporario.Vends"
  ControlSource = ""
  ControlSource = "csTemporario.grvends"
  ControlSource = "csTemporario.tabds"
  ControlSource = "csTemporario.pstatus"
  ControlSource = "xEestI.OBS"
  ControlSource = "csTemporario.nops"
  ControlSource = "csTemporario.prazoents"
  DeleteMark = .F.
  Column1.ControlSource = ""
  ControlSource = "tmpoperacao.codigos"
  ControlSource = "csTemporario.mascnum"
  ControlSource = "csTemporario.notas"
  ControlSource = "CsTemporario.datas"
  ControlSource = "csTemporario.obses"
	.Column1.ControlSource = 'csTemporario.Numes'
	.Column2.ControlSource = 'csTemporario.Datas'
	.Column3.ControlSource = 'csTemporario.GrupoOs'
	.Column4.ControlSource = 'csTemporario.ContaOs'
	.Column5.ControlSource = 'csTemporario.GrupoDs'
	.Column6.ControlSource = 'csTemporario.ContaDs'
	.Column7.ControlSource = 'csTemporario.Nops'
	.Column8.ControlSource = 'csTemporario.Usuars'	
	.Column9.ControlSource = 'csTemporario.PStatus'
	.Column10.ControlSource = 'csTemporario.Emps'
	.Column11.ControlSource = 'csTemporario.Empds'
		.Column1.ControlSource = 'xEestI.Cpros'
		.Column3.ControlSource = 'xEestI.Qtds'
		.Column5.ControlSource = 'xEestI.QtBaixas'
		.Column4.ControlSource = 'xEestI.QtProds'
		.Column6.ControlSource = 'xEestI.QtBxProds'
		.Column2.ControlSource = 'xEestI.QtProds - xEestI.QtBxProds'
		.Column7.ControlSource = 'xEestI.CItens'
		.Column8.ControlSource = 'xEestI.TPesos'
		.Column9.ControlSource = 'xEestI.DescVals'
		.Column10.ControlSource = 'xEestI.CodTams'
		.Column1.ControlSource = 'xEestI.Cpros'
		.Column2.ControlSource = 'xEestI.QtBxProds'
		.Column3.ControlSource = 'xEestI.Qtds'
		.Column4.ControlSource = 'xEestI.Qtds - xEestI.QtBaixas'
		.Column5.ControlSource = 'xEestI.QtBaixas'
		.Column6.ControlSource = 'xEestI.QtProds'
		.Column7.ControlSource = 'xEestI.CItens'
		.Column8.ControlSource = 'xEestI.TPesos'
		.Column9.ControlSource = 'xEestI.DescVals'
		.Column10.ControlSource = 'xEestI.CodTams'
	.DeleteMark   = .f.
	.Column1.ControlSource = 'TmpOperacao.Codigos'
		Select TmpOperacao
		lcQuery = [select isnull(b.codtams,'') as codtams, isnull(b.codcors,'') as codcors, a.* ] + ;
			[from sigmvitn a ] + ;
			[left join sigmvits b on a.empdopnums = b.empdopnums ] + ; 
		.poDataMgr.SqlExecute(lcQuery,[crSigMvItn])
		.poDataMgr.SqlExecute(lcQuery,[xEestI])
		Select csTemporario
Select csTemporario
			Select csTemporario
Select crSigMvPec
	Insert Into TmpOperacao From MemVar
lcQuery = [select isnull(b.codtams,'') as codtams, isnull(b.codcors,'') as codcors, b.qtds as QtdsS, a.* ] + ;
			[from sigmvitn a ] + ;
			[left join sigmvits b on a.empdopnums = b.empdopnums ] + ; 
ThisForm.poDataMgr.SqlExecute(lcQuery,[crSigMvItn])
SELECT empdopnums, cpros, codcors, codtams, SUM(qtds) as qtds, SUM(qtdss) as qtdss, Max(qtbaixas) as qtbaixas, Max(qtprods) as qtprods, ;
from crSigMvItn group by empdopnums, cpros, codcors, codtams into cursor crSigMvItn
Select crSigMvItn
	Insert Into xEestI From Memvar
Select xEestI
Select xEestI
Select xEestI
lcSql = [Select a.cpros,a.FigJpgs From SigCdPro a Where a.cpros = ']+lcCodPro+[' ]
ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpPro')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigpres2.prg) - TRECHOS RELEVANTES PARA PASS SQL (2041 linhas total):

*-- Linhas 9 a 27:
9: * Lparameters _Chave, pDataSes, poForm e usava "Set DataSession to pDataSes"
10: * para enxergar cursores locais ja abertos pelo form pai (csTemporario,
11: * xEestI, TmpOperacao). Neste sistema o sigpres2BO carrega o registro
12: * sozinho via SQLEXEC (CarregarPorCodigo/CidChaves) - nao ha cursor
13: * compartilhado entre forms - por isso o 2o parametro do Init deixa de ser
14: * o DataSessionId do pai e passa a ser a propria chave do movimento
15: * (CidChaves) que o form pai ja tinha selecionado. Ver cabecalho de
16: * sigpres2BO.prg para mais contexto sobre o fluxo do dialogo.
17: *==============================================================================
18: 
19: DEFINE CLASS Formsigpres2 AS FormBase
20: 
21:     *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
22:     Height      = 600
23:     Width       = 1000
24:     Caption     = ""
25:     AutoCenter  = .T.
26:     ShowWindow  = 1
27:     WindowType  = 1

*-- Linhas 347 a 376:
347: 
348:         *-- Grid da Lista (Grade no legado) - somente leitura, mostra o
349:         *-- resumo do movimento (Origem/Destino/Doc.Op/Usuario/Status/EmpO/
350:         *-- EmpD) que o form pai ja selecionou. ControlSource/Header sao
351:         *-- (re)definidos em CarregarLista(), apos o RecordSource - regra
352:         *-- "Grade perde cabecalhos apos RecordSource" (FORMCOR_LICOES).
353:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
354:         WITH loc_oPagina.grd_4c_Lista
355:             .Top             = 150
356:             .Left            = 35
357:             .Width           = 944
358:             .Height          = 470
359:             .ColumnCount     = 11
360:             .ReadOnly        = .T.
361:             .DeleteMark      = .F.
362:             .RecordMark      = .F.
363:             .FontName        = "Tahoma"
364:             .FontSize        = 8
365:             .ForeColor       = RGB(0, 0, 0)
366:             .BackColor       = RGB(255, 255, 255)
367:             .GridLineColor   = RGB(238, 238, 238)
368:             .HighlightBackColor = RGB(255, 255, 255)
369:             .HighlightForeColor = RGB(15, 41, 104)
370:             .HighlightStyle  = 2
371:             .RowHeight       = 16
372:             .ScrollBars      = 2
373:             .Visible         = .T.
374:         ENDWITH
375: 
376:         THIS.TornarControlesVisiveis(loc_oPagina)

*-- Linhas 1143 a 1177:
1143:         *-- relativos ao proprio container).
1144: 
1145:         *-- Grade de Itens (fwgrade1/xEestI no legado) - 10 colunas,
1146:         *-- somente leitura. RecordSource/ControlSource/Headers sao
1147:         *-- (re)definidos em CarregarItensGrid(), apos SQLEXEC popular
1148:         *-- cursor_4c_Itens (regra "Grade perde cabecalhos apos
1149:         *-- RecordSource" - FORMCOR_LICOES/CLAUDE.md). O ramo
1150:         *-- 'gcTpInstalas=V' do legado (troca de headers/formulas) nao foi
1151:         *-- portado - essa global de configuracao nao existe na nova
1152:         *-- arquitetura; o ramo aqui e o Else (default), que e o que bate
1153:         *-- com os headers estaticos do SCX (layout.json).
1154:         loc_oPagina.AddObject("grd_4c_Itens", "Grid")
1155:         WITH loc_oPagina.grd_4c_Itens
1156:             .Top             = 379
1157:             .Left            = 23
1158:             .Width           = 732
1159:             .Height          = 191
1160:             .ColumnCount     = 10
1161:             .ReadOnly        = .T.
1162:             .DeleteMark      = .F.
1163:             .RecordMark      = .F.
1164:             .GridLines       = 3
1165:             .FontName        = "Tahoma"
1166:             .FontSize        = 8
1167:             .ForeColor       = RGB(0, 0, 0)
1168:             .BackColor       = RGB(255, 255, 255)
1169:             .GridLineColor   = RGB(238, 238, 238)
1170:             .HighlightBackColor = RGB(255, 255, 255)
1171:             .HighlightForeColor = RGB(15, 41, 104)
1172:             .HighlightStyle  = 2
1173:             .RowHeight       = 16
1174:             .ScrollBars      = 2
1175:             .Visible         = .T.
1176:         ENDWITH
1177: 

*-- Linhas 1269 a 1287:
1269:             .Height      = 148
1270:             .ColumnCount = 1
1271:             .ReadOnly    = .T.
1272:             .DeleteMark  = .F.
1273:             .RecordMark  = .F.
1274:             .GridLines   = 3
1275:             .FontName    = "Tahoma"
1276:             .FontSize    = 8
1277:             .ForeColor   = RGB(0, 0, 0)
1278:             .BackColor   = RGB(255, 255, 255)
1279:             .Visible     = .T.
1280:         ENDWITH
1281: 
1282:         *-- Observacao geral do cabecalho do movimento (Container1/fwmemo1
1283:         *-- -> csTemporario.obses no legado = this_cObservacao no BO, ja
1284:         *-- existente desde a Fase 1/2)
1285:         loc_oPagina.AddObject("cnt_4c_Observacao", "Container")
1286:         WITH loc_oPagina.cnt_4c_Observacao
1287:             .Top       = 202

*-- Linhas 1389 a 1440:
1389:                         USE IN cursor_4c_Dados
1390:                     ENDIF
1391: 
1392:                     CREATE CURSOR cursor_4c_Dados ;
1393:                         (numes N(6,0), datas T, grupoos C(10), contaos C(10), ;
1394:                          grupods C(10), contads C(10), nops N(10,0), usuars C(10), ;
1395:                          pstatus C(1), emps C(3), empds C(3))
1396: 
1397:                     APPEND BLANK IN cursor_4c_Dados
1398:                     SELECT cursor_4c_Dados
1399:                     REPLACE numes   WITH THIS.this_oBusinessObject.this_nNumero, ;
1400:                             datas   WITH THIS.this_oBusinessObject.this_dData, ;
1401:                             grupoos WITH THIS.this_oBusinessObject.this_cGrupoOrigem, ;
1402:                             contaos WITH THIS.this_oBusinessObject.this_cContaOrigem, ;
1403:                             grupods WITH THIS.this_oBusinessObject.this_cGrupoDestino, ;
1404:                             contads WITH THIS.this_oBusinessObject.this_cContaDestino, ;
1405:                             nops    WITH THIS.this_oBusinessObject.this_nNumeroOP, ;
1406:                             usuars  WITH THIS.this_oBusinessObject.this_cUsuario, ;
1407:                             pstatus WITH THIS.this_oBusinessObject.this_cStatus, ;
1408:                             emps    WITH THIS.this_oBusinessObject.this_cEmpresa, ;
1409:                             empds   WITH THIS.this_oBusinessObject.this_cEmpresaDestino
1410:                     GO TOP IN cursor_4c_Dados
1411: 
1412:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1413: 
1414:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1415:                     loc_oGrid.Column1.ControlSource  = "cursor_4c_Dados.numes"
1416:                     loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.datas"
1417:                     loc_oGrid.Column3.ControlSource  = "cursor_4c_Dados.grupoos"
1418:                     loc_oGrid.Column4.ControlSource  = "cursor_4c_Dados.contaos"
1419:                     loc_oGrid.Column5.ControlSource  = "cursor_4c_Dados.grupods"
1420:                     loc_oGrid.Column6.ControlSource  = "cursor_4c_Dados.contads"
1421:                     loc_oGrid.Column7.ControlSource  = "cursor_4c_Dados.nops"
1422:                     loc_oGrid.Column8.ControlSource  = "cursor_4c_Dados.usuars"
1423:                     loc_oGrid.Column9.ControlSource  = "cursor_4c_Dados.pstatus"
1424:                     loc_oGrid.Column10.ControlSource = "cursor_4c_Dados.emps"
1425:                     loc_oGrid.Column11.ControlSource = "cursor_4c_Dados.empds"
1426: 
1427:                     loc_oGrid.Column1.Width  = 80
1428:                     loc_oGrid.Column2.Width  = 80
1429:                     loc_oGrid.Column3.Width  = 80
1430:                     loc_oGrid.Column4.Width  = 80
1431:                     loc_oGrid.Column5.Width  = 80
1432:                     loc_oGrid.Column6.Width  = 80
1433:                     loc_oGrid.Column7.Width  = 80
1434:                     loc_oGrid.Column8.Width  = 80
1435:                     loc_oGrid.Column9.Width  = 40
1436:                     loc_oGrid.Column9.Alignment = 2
1437:                     loc_oGrid.Column10.Width = 50
1438:                     loc_oGrid.Column11.Width = 50
1439: 
1440:                     loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digo"

*-- Linhas 1640 a 1689:
1640: 
1641:     *===========================================================================
1642:     * CarregarItensGrid - Popula grd_4c_Itens a partir de cursor_4c_Itens
1643:     * (sigpres2BO.CarregarItens) e reconfigura RecordSource/ControlSource/
1644:     * Header/Width - regra "Grade perde cabecalhos apos RecordSource"
1645:     * (FORMCOR_LICOES/CLAUDE.md). Ao final, posiciona no 1o item e atualiza
1646:     * Descricao/Observacao/Imagem (AtualizarItemSelecionado).
1647:     *===========================================================================
1648:     PROTECTED PROCEDURE CarregarItensGrid()
1649:         LOCAL loc_lResultado, loc_oGrid, loc_oPagina
1650:         loc_lResultado = .F.
1651: 
1652:         TRY
1653:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1654:                 loc_lResultado = .T.
1655:             ELSE
1656:                 loc_oPagina = THIS.pgf_4c_Paginas.Page2
1657: 
1658:                 IF !THIS.this_oBusinessObject.CarregarItens()
1659:                     loc_lResultado = .F.
1660:                 ELSE
1661:                     loc_oGrid = loc_oPagina.grd_4c_Itens
1662:                     loc_oGrid.ColumnCount = 10
1663:                     loc_oGrid.RecordSource = "cursor_4c_Itens"
1664: 
1665:                     loc_oGrid.Column1.ControlSource  = "cursor_4c_Itens.cpros"
1666:                     loc_oGrid.Column2.ControlSource  = "cursor_4c_Itens.qtbxprods"
1667:                     loc_oGrid.Column3.ControlSource  = "cursor_4c_Itens.qtds"
1668:                     loc_oGrid.Column4.ControlSource  = "cursor_4c_Itens.saldo"
1669:                     loc_oGrid.Column5.ControlSource  = "cursor_4c_Itens.qtbaixas"
1670:                     loc_oGrid.Column6.ControlSource  = "cursor_4c_Itens.qtprods"
1671:                     loc_oGrid.Column7.ControlSource  = "cursor_4c_Itens.citens"
1672:                     loc_oGrid.Column8.ControlSource  = "cursor_4c_Itens.tpesos"
1673:                     loc_oGrid.Column9.ControlSource  = "cursor_4c_Itens.descvals"
1674:                     loc_oGrid.Column10.ControlSource = "cursor_4c_Itens.codtams"
1675: 
1676:                     loc_oGrid.Column1.Width  = 90
1677:                     loc_oGrid.Column2.Width  = 70
1678:                     loc_oGrid.Column3.Width  = 60
1679:                     loc_oGrid.Column4.Width  = 60
1680:                     loc_oGrid.Column5.Width  = 70
1681:                     loc_oGrid.Column6.Width  = 70
1682:                     loc_oGrid.Column7.Width  = 60
1683:                     loc_oGrid.Column8.Width  = 70
1684:                     loc_oGrid.Column9.Width  = 60
1685:                     loc_oGrid.Column10.Width = 60
1686: 
1687:                     loc_oGrid.Column1.Header1.Caption  = "Produto"
1688:                     loc_oGrid.Column2.Header1.Caption  = "Produzido"
1689:                     loc_oGrid.Column3.Header1.Caption  = "Qtd."

*-- Linhas 1735 a 1753:
1735:                     loc_oGrid = loc_oPagina.grd_4c_Operacoes
1736:                     loc_oGrid.ColumnCount = 1
1737:                     loc_oGrid.RecordSource = "cursor_4c_Operacoes"
1738:                     loc_oGrid.Column1.ControlSource  = "cursor_4c_Operacoes.codigos"
1739:                     loc_oGrid.Column1.Width          = 100
1740:                     loc_oGrid.Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1741:                     loc_oGrid.Column1.FontName        = "Courier New"
1742:                     loc_oGrid.Refresh()
1743: 
1744:                     loc_lResultado = .T.
1745:                 ENDIF
1746:             ENDIF
1747:         CATCH TO loException
1748:             MostrarErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + loException.Message, "Formsigpres2.CarregarOperacoesGrid")
1749:             loc_lResultado = .F.
1750:         ENDTRY
1751: 
1752:         RETURN loc_lResultado
1753:     ENDPROC

*-- Linhas 1781 a 1808:
1781:             RETURN
1782:         ENDIF
1783: 
1784:         SELECT cursor_4c_Itens
1785:         loc_oPagina.txt_4c_Descr.Value          = ALLTRIM(TratarNulo(cursor_4c_Itens.dpros, ""))
1786:         loc_oPagina.edt_4c_ObservacaoItem.Value = TratarNulo(cursor_4c_Itens.obs, "")
1787:         loc_cCodigoProduto                       = ALLTRIM(cursor_4c_Itens.cpros)
1788: 
1789:         IF !EMPTY(loc_cCodigoProduto)
1790:             IF USED("cursor_4c_Produto")
1791:                 USE IN cursor_4c_Produto
1792:             ENDIF
1793:             IF SQLEXEC(gnConnHandle, "SELECT figjpgs FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCodigoProduto), "cursor_4c_Produto") >= 1
1794:                 IF RECCOUNT("cursor_4c_Produto") > 0 AND !EMPTY(TratarNulo(cursor_4c_Produto.figjpgs, ""))
1795:                     loc_cArquivo = SYS(2023) + "\sigpres2_" + SYS(2015) + ".jpg"
1796:                     IF STRTOFILE(cursor_4c_Produto.figjpgs, loc_cArquivo) > 0
1797:                         loc_oPagina.img_4c_FigJpg.Picture = loc_cArquivo
1798:                         loc_oPagina.img_4c_FigJpg.Visible = .T.
1799:                     ENDIF
1800:                 ENDIF
1801:             ENDIF
1802:             IF USED("cursor_4c_Produto")
1803:                 USE IN cursor_4c_Produto
1804:             ENDIF
1805:         ENDIF
1806:     ENDPROC
1807: 
1808:     *===========================================================================

*-- Linhas 1843 a 1867:
1843:         IF fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_cConta, ;
1844:                 loc_oOrigem.txt_4c_ContaOrigem, loc_oOrigem.txt_4c_DescContaOrigem)
1845:             IF EMPTY(loc_cGrupo)
1846:                 loc_cSQL = "SELECT grupos FROM SigCdCli WHERE iclis = " + ;
1847:                     EscaparSQL(ALLTRIM(loc_oOrigem.txt_4c_ContaOrigem.Value))
1848: 
1849:                 IF USED("cursor_4c_GrupoConta")
1850:                     USE IN cursor_4c_GrupoConta
1851:                 ENDIF
1852:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoConta") >= 1 AND RECCOUNT("cursor_4c_GrupoConta") > 0
1853:                     loc_oOrigem.txt_4c_GrupoOrigem.Value = ALLTRIM(TratarNulo(cursor_4c_GrupoConta.grupos, ""))
1854:                 ENDIF
1855:                 IF USED("cursor_4c_GrupoConta")
1856:                     USE IN cursor_4c_GrupoConta
1857:                 ENDIF
1858:             ENDIF
1859:         ELSE
1860:             MsgAviso("Acesso Negado!!!", "Aten" + CHR(231) + CHR(227) + "o")
1861:             loc_oOrigem.txt_4c_ContaOrigem.Value     = ""
1862:             loc_oOrigem.txt_4c_DescContaOrigem.Value = ""
1863:         ENDIF
1864:     ENDPROC
1865: 
1866:     *===========================================================================
1867:     * ValidarContaDestino - Equivalente a Origem.Get_ContaD.Valid do legado:


### BO (C:\4c\projeto\app\classes\sigpres2BO.prg):
*==============================================================================
* SIGPRES2BO.PRG
* Business Object para o dialogo de Origem/Destino/Representante de Movimento
* (SIGPRES2 - dialogo filho aberto por um form OPERACIONAL pai via
*  "Do Form SigPrEs2 With ThisForm, ...", NAO acessivel direto pelo menu)
*
* Tabela Principal : SigMvCab (cabecalho de movimentacao)
* Chave Real (PK)  : CidChaves    CHAR(20)
* Chave Posicional : EmpDopNums   CHAR(29) = Emps CHAR(3) + Dopes CHAR(20) + Str(Numes, 6)
*                     (NUNCA usar ALLTRIM nas partes - ver CLAUDE.md regra #42)
*
* Logica do legado: o form pai ja populou um cursor local (csTemporario) com o
* registro (ou lote de registros) de SigMvCab a editar; o SIGPRES2 apenas edita
* os campos de cabecalho abaixo (Origem/Destino/Representante/Status/Prazo) e
* delega o commit ao TableUpdate do buffer do framework (Grupo_Salva.Salva.Click
* so chama DoDefault() + mAtivapagina1 - nao ha INSERT/UPDATE/DELETE proprios no
* codigo fonte do SIGPRES2). Os campos de item (grid fwgrade1/xEestI, vindos de
* SigMvItn/SigMvIts) e a grade de operacoes (TmpOperacao/SigMvPec) sao
* somente-leitura e pertencem a um cursor de detalhe, nao a properties escalares
* deste BO.
*==============================================================================

DEFINE CLASS sigpres2BO AS BusinessBase

    *-- Chave composta do movimento (SigMvCab)
    this_cEmpresa            = ""   && Emps        CHAR(3)  - Empresa (parte da chave posicional)
    this_cTipoDocumento      = ""   && Dopes        CHAR(20) - Tipo de documento (parte da chave posicional)
    this_nNumero             = 0    && Numes        NUMERIC(6,0) - Numero do documento (parte da chave posicional)
    this_cEmpresaDestino     = ""   && Empds        CHAR(3)  - Empresa de destino (grid Lista, coluna "EmpD")
    this_cChaveMovimento     = ""   && EmpDopNums   CHAR(29) - Chave posicional (Emps+Dopes+Str(Numes,6))
    this_cCidChave           = ""   && CidChaves    CHAR(20) - Chave primaria real da tabela

    *-- Origem / Destino / Representante (container "Origem" da Pagina Dados)
    this_cGrupoOrigem        = ""   && Grupoos      CHAR(10)
    this_cContaOrigem        = ""   && Contaos      CHAR(10)
    this_cGrupoDestino       = ""   && Grupods      CHAR(10)
    this_cContaDestino       = ""   && Contads      CHAR(10)
    this_cRepresentante      = ""   && Vends        CHAR(10)
    this_cGrupoRepresentante = ""   && Grvends      CHAR(10)

    *-- Demais campos de cabecalho editaveis na Pagina Dados
    this_cTabelaDesconto     = ""   && Tabds        CHAR(10)
    this_cStatus             = ""   && PStatus      CHAR(1)
    this_cUsuario            = ""   && Usuars       CHAR(10) - usuario do movimento (grid Lista, coluna "Usuario")
    this_nNumeroOP           = 0    && Nops         NUMERIC(10,0)
    this_dPrazoEntrega       = {}   && PrazoEnts    DATETIME
    this_cCodigoMascarado    = ""   && MascNum      CHAR(10) - exibicao formatada (Get_codigo), somente leitura
    this_cDocumento          = ""   && Notas        CHAR(6)  - numero do documento/nota (Get_nota)
    this_dData               = {}   && Datas        DATETIME
    this_cObservacao         = ""   && Obses        TEXT (memo)

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "CidChaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave real da tabela (CidChaves), usada por
    * RegistrarAuditoria() e pela clausula WHERE de Atualizar()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChave)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia as colunas de SigMvCab que este dialogo edita
    * (Origem/Destino/Representante/cabecalho) para as properties do BO.
    * SELECT (par_cAliasCursor) ANTES de acessar os campos (regra #8 CLAUDE.md).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cEmpresa            = TratarNulo(emps, "")
                THIS.this_cTipoDocumento      = TratarNulo(dopes, "")
                THIS.this_nNumero             = TratarNulo(numes, 0)
                THIS.this_cEmpresaDestino     = TratarNulo(empds, "")
                THIS.this_cChaveMovimento     = TratarNulo(empdopnums, "")
                THIS.this_cCidChave           = TratarNulo(cidchaves, "")

                THIS.this_cGrupoOrigem        = TratarNulo(grupoos, "")
                THIS.this_cContaOrigem        = TratarNulo(contaos, "")
                THIS.this_cGrupoDestino       = TratarNulo(grupods, "")
                THIS.this_cContaDestino       = TratarNulo(contads, "")
                THIS.this_cRepresentante      = TratarNulo(vends, "")
                THIS.this_cGrupoRepresentante = TratarNulo(grvends, "")

                THIS.this_cTabelaDesconto     = TratarNulo(tabds, "")
                THIS.this_cStatus             = TratarNulo(pstatus, "")
                THIS.this_cUsuario            = TratarNulo(usuars, "")
                THIS.this_nNumeroOP           = TratarNulo(nops, 0)
                THIS.this_dPrazoEntrega       = TratarNulo(prazoents, {})
                THIS.this_cCodigoMascarado    = TratarNulo(mascnum, "")
                THIS.this_cDocumento          = TratarNulo(notas, "")
                THIS.this_dData               = TratarNulo(datas, {})
                THIS.this_cObservacao         = TratarNulo(obses, "")

                THIS.this_lNovoRegistro = .F.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigpres2BO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega o movimento pela chave real (CidChaves).
    * SELECT * (como no legado, que abre o registro inteiro via csTemporario)
    * para que CarregarDoCursor sempre encontre as colunas que le.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT * FROM SigMvCab WHERE cidchaves = " + EscaparSQL(par_cCodigo)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                ELSE
                    MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "sigpres2BO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE parcial em SigMvCab, restrito aos campos que este
    * dialogo de fato edita (Origem/Destino/Representante/Status/Prazo/
    * Documento/Data/Observacao). Equivalente ao TableUpdate() do buffer
    * otimista do framework legado: Grupo_Salva.Salva.Click do SIGPRES2 nao
    * tem SQL proprio (so DoDefault() + mAtivapagina1 - ver cabecalho do
    * arquivo), mas o buffer so envia ao SQL Server as colunas realmente
    * alteradas na tela - por isso o UPDATE aqui cobre so essas colunas,
    * nunca a linha inteira (colunas de identificacao como Emps/Dopes/Numes/
    * EmpDopNums/MascNum sao somente leitura nesta tela e ficam de fora).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigMvCab SET"
            loc_cSQL = loc_cSQL + " grupoos = "   + EscaparSQL(LEFT(THIS.this_cGrupoOrigem, 10)) + ","
            loc_cSQL = loc_cSQL + " contaos = "   + EscaparSQL(LEFT(THIS.this_cContaOrigem, 10)) + ","
            loc_cSQL = loc_cSQL + " grupods = "   + EscaparSQL(LEFT(THIS.this_cGrupoDestino, 10)) + ","
            loc_cSQL = loc_cSQL + " contads = "   + EscaparSQL(LEFT(THIS.this_cContaDestino, 10)) + ","
            loc_cSQL = loc_cSQL + " vends = "     + EscaparSQL(LEFT(THIS.this_cRepresentante, 10)) + ","
            loc_cSQL = loc_cSQL + " grvends = "   + EscaparSQL(LEFT(THIS.this_cGrupoRepresentante, 10)) + ","
            loc_cSQL = loc_cSQL + " tabds = "     + EscaparSQL(LEFT(THIS.this_cTabelaDesconto, 10)) + ","
            loc_cSQL = loc_cSQL + " pstatus = "   + EscaparSQL(LEFT(THIS.this_cStatus, 1)) + ","
            loc_cSQL = loc_cSQL + " nops = "      + FormatarNumeroSQL(THIS.this_nNumeroOP, 0) + ","
            loc_cSQL = loc_cSQL + " prazoents = " + FormatarDataSQL(THIS.this_dPrazoEntrega) + ","
            loc_cSQL = loc_cSQL + " notas = "     + EscaparSQL(LEFT(THIS.this_cDocumento, 6)) + ","
            loc_cSQL = loc_cSQL + " datas = "     + FormatarDataSQL(THIS.this_dData) + ","
            loc_cSQL = loc_cSQL + " obses = "     + EscaparSQL(THIS.this_cObservacao)
            loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChave)

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResultado < 0
                MsgErro("Erro ao atualizar movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigpres2BO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir() e ExecutarExclusao() permanecem com o comportamento herdado
    * de BusinessBase (recusar a operacao): no fonte legado do SIGPRES2 nao
    * ha Append/Delete contra SigMvCab - o dialogo so edita um registro que
    * o form pai ja havia populado em csTemporario antes de abri-lo (ver
    * cabecalho do arquivo). Este BO nunca cria nem exclui movimentos.
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * CarregarItens - Carrega os itens do movimento (grid fwgrade1/xEestI do
    * legado) em cursor_4c_Itens. Fonte: SigMvItn (a) LEFT JOIN SigMvIts (b)
    * por EmpDopNums+Cpros+CItens (mesma juncao do PROCEDURE Init legado -
    * regra #42 CLAUDE.md, nunca ALLTRIM na chave posicional). Saldo =
    * Qtds - QtBaixas ja calculado no SELECT (equivalente ao
    * Column4.ControlSource legado 'xEestI.Qtds - xEestI.QtBaixas', ramo
    * Else de montagrades - o ramo If(gcTpInstalas='V') nao foi portado:
    * essa global de configuracao nao existe na nova arquitetura, e o ramo
    * Else e o que bate com os headers estaticos do SCX/layout.json).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarItens()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Itens")
                USE IN cursor_4c_Itens
            ENDIF

            loc_cSQL = "SELECT a.cpros, a.dpros, a.qtds, a.qtprods," + ;
                " a.qtbaixas, a.qtbxprods, a.citens, a.tpesos," + ;
                " a.descvals, ISNULL(b.codtams, '') AS codtams," + ;
                " a.obs, (a.qtds - a.qtbaixas) AS saldo" + ;
                " FROM sigmvitn a" + ;
                " LEFT JOIN sigmvits b ON b.empdopnums = a.empdopnums" + ;
                " AND b.cpros = a.cpros AND b.citens = a.citens" + ;
                " WHERE a.empdopnums = " + EscaparSQL(THIS.this_cChaveMovimento) + ;
                " ORDER BY a.citens"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Itens")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar itens do movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar itens:" + CHR(13) + loException.Message, "sigpres2BO.CarregarItens")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacoes - Carrega os codigos de operacao vinculados ao
    * movimento (grid GradeOperacao/TmpOperacao do legado). Fonte: SigMvPec
    * filtrado por EmpDopNums (mesmo filtro do legado
    * CursorQuery('SigMvPec', 'TmpOperacao', 'EmpDopNums', pEdn)).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacoes()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF

            loc_cSQL = "SELECT DISTINCT codigos FROM sigmvpec" + ;
                " WHERE empdopnums = " + EscaparSQL(THIS.this_cChaveMovimento) + ;
                " ORDER BY codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es do movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + loException.Message, "sigpres2BO.CarregarOperacoes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

