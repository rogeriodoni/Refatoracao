# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [GRID-SQL] Campo 'itras' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'razaos' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'tel1s' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL

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
  ControlSource = "crSigPrTrp.itras"
  ControlSource = "crSigPrTrp.idtransp"
  ControlSource = "crSigPrTrp.razaos"
  ControlSource = "crSigPrTrp.bairs"
  ControlSource = "crSigPrTrp.cidas"
  ControlSource = "crSigPrTrp.endes"
  ControlSource = "crSigPrTrp.ceps"
  ControlSource = "crSigPrTrp.estas"
  ControlSource = "crSigPrTrp.tel1s"
  ControlSource = "crSigPrTrp.tel2s"
  ControlSource = "crSigPrTrp.faxs"
  ControlSource = "crSigPrTrp.cgcs"
  ControlSource = "crSigPrTrp.inscs"
  ControlSource = "crSigPrTrp.tpconexao"
  ControlSource = "crSigPrTrp.ftpend"
  ControlSource = "crSigPrTrp.ftpusuario"
  ControlSource = "crSigPrTrp.ftpsenha"
  ControlSource = "crSigPrTrp.dirftpts"
  ControlSource = "crSigPrTrp.dirftpls"
  ControlSource = ""
  ControlSource = "crSigPrTrp.drivets"
  ControlSource = "crSigPrTrp.drivels"
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  ControlSource = "crSigPrTrp.locdel"
  ControlSource = "crSigPrTrp.ftpdel"
  ControlSource = "crSigPrTrp.urltransp"
  ControlSource = "crSigPrTrp.tipotrans"
If Not Thisform.poDataMgr.Update('crSigPrTrp')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigPrTrp )')
If Not Thisform.poDataMgr.Update('crSigPrTrv')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigPrTrv )')
Select crSigPrTrp
Delete For Itras = pChave
Select crSigPrTrv
Delete For Itras = pChave
	If Not ThisForm.poDataMgr.Update('crSigPrTrp')
	If Not ThisForm.poDataMgr.Update('crSigPrTrv')
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigPrTrp Where Itras = ?pChave], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigPrTrv Where Itras = ?pChave], '') < 1)
If Not Thisform.poDataMgr.Update('crSigPrTrp')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigPrTrp )')
If Not Thisform.poDataMgr.Update('crSigPrTrv')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigPrTrv )')
lcSqlSigPrTrv = [Select a.*, d.estados as uf, c.descs as munici From SigPrTrv a Inner Join SigCdUfs d On d.ufibges = a.ufibges ] +;
				[Left Join SigCdMun c on c.codigos = a.codibges Where a.Itras = ?lcItra]
	Select crSigPrTrv
		.column1.ControlSource = 'crSigPrTrv.uf'
		.Column2.ControlSource = 'crSigPrTrv.valfretes'
		.Column3.ControlSource = 'crSigPrTrv.pesomins'
		.Column4.ControlSource = 'crSigPrTrv.pesomaxs'
		.Column5.ControlSource = 'crSigPrTrv.Munici'
	Select crSigPrTrp
	Select CrSigPrTrp
Select crSigPrTrv
	.column1.ControlSource = 'crSigPrTrv.uf'
	.Column2.ControlSource = 'crSigPrTrv.valfretes'
	.Column3.ControlSource = 'crSigPrTrv.pesomins'
	.Column4.ControlSource = 'crSigPrTrv.pesomaxs'
	.Column5.ControlSource = 'crSigPrTrv.Munici'	
Select crSigPrTrp
Select CrSigPrTrp
	Select crSigPrTrv
Select CrSigPrTrp
	Select * from crSigPrTrv where Uf = lcUf And Munici = lcMuni And this.Value between PesoMins And PesoMaxs And CidChaves <> lcCidChaves into cursor TmpPeso
	Select * from crSigPrTrv where Uf = lcUf And Munici = lcMuni And this.Value between PesoMins And PesoMaxs And CidChaves <> lcCidChaves into cursor TmpPeso
	lcQuery = 	[Select b.estados, a.descs as munici, a.codigos as codibges, b.UFIBGEs From SigCdMun a, SigcdUfs b where b.estados = '] + ;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, [crLocal])) >0
		Select crlocal
		If Not Seek(Padr(This.Value, 40), [crLocal], [munici])
Select crSigPrTrv
Select crSigPrTrv
Select crSigPrTrv
Delete

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formtra.prg) - TRECHOS RELEVANTES PARA PASS SQL (2410 linhas total):

*-- Linhas 101 a 121:
101:         THIS.ConfigurarPaginaDados()
102:     ENDPROC
103: 
104:     *===========================================================================
105:     * ConfigurarPaginaLista - Page1 (Lista de Transportadoras)
106:     * Grid: cursor_4c_Dados (itras, razaos, tel1s) - traBO.Buscar()
107:     * Botoes CRUD: Incluir, Visualizar, Alterar, Excluir, Buscar, Encerrar
108:     *===========================================================================
109:     PROTECTED PROCEDURE ConfigurarPaginaLista()
110:         LOCAL loc_oPagina
111:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
112: 
113:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
114: 
115:         *-- Cabecalho (faixa cinza) - PRIMEIRO AddObject da pagina (CLAUDE.md regra #11)
116:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
117:         WITH loc_oPagina.cnt_4c_Cabecalho
118:             .Top         = 29
119:             .Left        = 0
120:             .Width       = THIS.Width
121:             .Height      = 80

*-- Linhas 350 a 402:
350:             .HighlightBackColor = RGB(255, 255, 255)
351:             .HighlightForeColor = RGB(15, 41, 104)
352:             .HighlightStyle     = 2
353:             .DeleteMark         = .F.
354:             .RecordMark         = .F.
355:             .RowHeight          = 16
356:             .ScrollBars         = 2
357:             .GridLines          = 3
358:             .Visible            = .T.
359:         ENDWITH
360:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
361: 
362:         THIS.TornarControlesVisiveis(loc_oPagina)
363:     ENDPROC
364: 
365:     *===========================================================================
366:     * CarregarLista - Carrega dados no grid da Page1
367:     * OBRIGATORIO: Reconfigura ControlSource e Headers APOS RecordSource (Problema 2/48)
368:     * OBRIGATORIO: RecordSource FORA do WITH (Problema 36)
369:     *===========================================================================
370:     PROCEDURE CarregarLista()
371:         LOCAL loc_lResultado, loc_oGrid
372:         loc_lResultado = .F.
373: 
374:         TRY
375:             IF !THIS.this_oBusinessObject.Buscar("")
376:                 loc_lResultado = .F.
377:             ELSE
378:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
379: 
380:                 *-- PROBLEMA 48: RecordSource ANTES de ControlSource (FORA do WITH per Problema 36)
381:                 loc_oGrid.ColumnCount  = 3
382:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
383: 
384:                 *-- PROBLEMA 48: ControlSource APOS RecordSource (auto-bind seria sobrescrito)
385:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.itras"
386:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.razaos"
387:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.tel1s"
388: 
389:                 *-- Larguras proporcionais ao legado (pColuna: 85/322/120 de 971) sobre Width=880
390:                 loc_oGrid.Column1.Width = 140
391:                 loc_oGrid.Column2.Width = 535
392:                 loc_oGrid.Column3.Width = 200
393: 
394:                 *-- PROBLEMA 2/32: Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
395:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
396:                 loc_oGrid.Column2.Header1.Caption = "Raz" + CHR(227) + "o Social"
397:                 loc_oGrid.Column3.Header1.Caption = "Telefone"
398: 
399:                 THIS.FormatarGridLista(loc_oGrid)
400:                 loc_lResultado = .T.
401:             ENDIF
402: 

*-- Linhas 1477 a 1511:
1477:         ENDWITH
1478: 
1479:         *-- Grid de fretes por estado - estrutura criada aqui; RecordSource,
1480:         *-- ControlSource e Headers sao definidos em CarregarGradeEstados()
1481:         *-- (Problema 2/48: reconfigurar SOMENTE apos RecordSource)
1482:         loc_oPagina.AddObject("grd_4c_Estados", "Grid")
1483:         loc_oPagina.grd_4c_Estados.ColumnCount = 5
1484:         WITH loc_oPagina.grd_4c_Estados
1485:             .Top           = 211
1486:             .Left          = 500
1487:             .Width         = 490
1488:             .Height        = 419
1489:             .FontName      = "Tahoma"
1490:             .FontSize      = 8
1491:             .ForeColor     = RGB(0, 0, 0)
1492:             .BackColor     = RGB(255, 255, 255)
1493:             .GridLineColor = RGB(238, 238, 238)
1494:             .GridLineWidth = 1
1495:             .HeaderHeight  = 20
1496:             .DeleteMark    = .F.
1497:             .RecordMark    = .F.
1498:             .ScrollBars    = 2
1499:             .GridLines     = 3
1500:             .Panel         = 1
1501:             .Visible       = .T.
1502:         ENDWITH
1503: 
1504:         *-- Coluna UF (Column1) - controle customizado com lookup no LostFocus
1505:         *-- (CLAUDE.md regra #18: precisa de CurrentControl + Sparse=.F.)
1506:         loc_oPagina.grd_4c_Estados.Column1.AddObject("txt_4c_ColUf", "TextBox")
1507:         WITH loc_oPagina.grd_4c_Estados.Column1.txt_4c_ColUf
1508:             .FontName    = "Arial"
1509:             .FontSize    = 8
1510:             .Alignment   = 2
1511:             .BorderStyle = 0

*-- Linhas 1641 a 1724:
1641:     *===========================================================================
1642:     * CarregarGradeEstados - Carrega/atualiza a grade de fretes por estado
1643:     * (GradEstado/crSigPrTrv no legado). SigPrTrv NAO tem colunas "uf"/"munici" -
1644:     * sao alias de JOIN com SigCdUfs/SigCdMun (ver docs/schema.sql).
1645:     * REGRA: RecordSource/ControlSource/Headers configurados so na 1a chamada
1646:     * (Problema 48); recargas seguintes usam cursor temporario + ZAP + APPEND
1647:     * (Problema 34/35) para nao destruir as colunas do Grid.
1648:     *===========================================================================
1649:     PROCEDURE CarregarGradeEstados(par_cCodigo)
1650:         LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_oGrid, loc_lPrimeiraVez
1651:         loc_lResultado = .F.
1652: 
1653:         TRY
1654:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Estados
1655:             loc_lPrimeiraVez = EMPTY(loc_oGrid.RecordSource)
1656: 
1657:             IF !USED("cursor_4c_Estados")
1658:                 SET NULL ON
1659:                 CREATE CURSOR cursor_4c_Estados (cidchaves C(20), codibges C(7), ;
1660:                     pesomaxs N(8,2), pesomins N(8,2), ufibges N(5,0), valfretes N(9,2), ;
1661:                     uf C(2), munici C(40))
1662:                 SET NULL OFF
1663:             ELSE
1664:                 SELECT cursor_4c_Estados
1665:                 ZAP
1666:             ENDIF
1667: 
1668:             IF VARTYPE(par_cCodigo) = "C" AND !EMPTY(par_cCodigo) ;
1669:                     AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1670: 
1671:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
1672:                     SELECT a.cidchaves, a.codibges, a.pesomaxs, a.pesomins, a.ufibges,
1673:                         a.valfretes, d.estados AS uf, c.descs AS munici
1674:                     FROM SigPrTrv a
1675:                     INNER JOIN SigCdUfs d ON d.ufibges = a.ufibges
1676:                     LEFT JOIN SigCdMun c ON c.codigos = a.codibges
1677:                     WHERE a.itras = <<EscaparSQL(par_cCodigo)>>
1678:                     ORDER BY d.estados
1679:                 ENDTEXT
1680: 
1681:                 IF USED("cursor_4c_EstadosTemp")
1682:                     USE IN cursor_4c_EstadosTemp
1683:                 ENDIF
1684:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstadosTemp")
1685: 
1686:                 IF loc_nResultado >= 0 AND USED("cursor_4c_EstadosTemp")
1687:                     SELECT cursor_4c_Estados
1688:                     APPEND FROM DBF("cursor_4c_EstadosTemp")
1689:                     USE IN cursor_4c_EstadosTemp
1690:                 ELSE
1691:                     MostrarErro("Erro ao carregar fretes por estado:" + CHR(13) + CapturarErroSQL(), ;
1692:                         "Formtra.CarregarGradeEstados")
1693:                 ENDIF
1694:             ENDIF
1695: 
1696:             SELECT cursor_4c_Estados
1697:             GO TOP
1698: 
1699:             IF loc_lPrimeiraVez
1700:                 loc_oGrid.RecordSource = "cursor_4c_Estados"
1701: 
1702:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Estados.uf"
1703:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Estados.valfretes"
1704:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Estados.pesomins"
1705:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Estados.pesomaxs"
1706:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Estados.munici"
1707: 
1708:                 loc_oGrid.Column1.txt_4c_ColUf.ControlSource        = "cursor_4c_Estados.uf"
1709:                 loc_oGrid.Column5.txt_4c_ColMunicipio.ControlSource = "cursor_4c_Estados.munici"
1710: 
1711:                 loc_oGrid.Column1.Width = 50
1712:                 loc_oGrid.Column2.Width = 90
1713:                 loc_oGrid.Column3.Width = 90
1714:                 loc_oGrid.Column4.Width = 90
1715:                 loc_oGrid.Column5.Width = 165
1716: 
1717:                 loc_oGrid.Column2.Text1.Alignment = 3
1718:                 loc_oGrid.Column3.Text1.Alignment = 3
1719:                 loc_oGrid.Column4.Text1.Alignment = 3
1720: 
1721:                 loc_oGrid.Column1.Header1.Caption = "UF"
1722:                 loc_oGrid.Column2.Header1.Caption = "Valor"
1723:                 loc_oGrid.Column3.Header1.Caption = "Peso M" + CHR(237) + "nimo"
1724:                 loc_oGrid.Column4.Header1.Caption = "Peso M" + CHR(225) + "ximo"

*-- Linhas 1741 a 1795:
1741:     * SalvarGradeEstados - Grava os fretes por estado da grade (cursor_4c_Estados)
1742:     * na tabela SigPrTrv. Estrategia: apaga tudo do codigo e regrava (mais simples
1743:     * e seguro que diff linha-a-linha; equivalente ao msv_inserir/msv_alterar
1744:     * do legado que tambem regravam o cursor inteiro via poDataMgr.Update).
1745:     *===========================================================================
1746:     PROCEDURE SalvarGradeEstados(par_cCodigo)
1747:         LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_cCidChaves
1748:         loc_lResultado = .T.
1749: 
1750:         TRY
1751:             loc_cSQL = "DELETE FROM SigPrTrv WHERE itras = " + EscaparSQL(par_cCodigo)
1752:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
1753: 
1754:             IF loc_nResultado < 0
1755:                 MostrarErro("Erro ao atualizar fretes por estado:" + CHR(13) + CapturarErroSQL(), ;
1756:                     "Formtra.SalvarGradeEstados")
1757:                 loc_lResultado = .F.
1758:             ELSE
1759:                 IF USED("cursor_4c_Estados")
1760:                     SELECT cursor_4c_Estados
1761:                     SCAN FOR !DELETED() AND !EMPTY(ALLTRIM(uf))
1762:                         loc_cCidChaves = ALLTRIM(cursor_4c_Estados.cidchaves)
1763:                         IF EMPTY(loc_cCidChaves)
1764:                             loc_cCidChaves = fUniqueIds("")
1765:                         ENDIF
1766: 
1767:                         TEXT TO loc_cSQL TEXTMERGE NOSHOW
1768:                             INSERT INTO SigPrTrv (cidchaves, codibges, itras, pesomaxs, pesomins, ufibges, valfretes)
1769:                             VALUES (
1770:                                 <<EscaparSQL(loc_cCidChaves)>>,
1771:                                 <<EscaparSQL(cursor_4c_Estados.codibges)>>,
1772:                                 <<EscaparSQL(par_cCodigo)>>,
1773:                                 <<FormatarNumeroSQL(cursor_4c_Estados.pesomaxs, 2)>>,
1774:                                 <<FormatarNumeroSQL(cursor_4c_Estados.pesomins, 2)>>,
1775:                                 <<FormatarNumeroSQL(cursor_4c_Estados.ufibges, 0)>>,
1776:                                 <<FormatarNumeroSQL(cursor_4c_Estados.valfretes, 2)>>
1777:                             )
1778:                         ENDTEXT
1779: 
1780:                         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
1781:                         IF loc_nResultado < 0
1782:                             MostrarErro("Erro ao gravar frete do estado " + ALLTRIM(cursor_4c_Estados.uf) + ":" + ;
1783:                                 CHR(13) + CapturarErroSQL(), "Formtra.SalvarGradeEstados")
1784:                             loc_lResultado = .F.
1785:                             EXIT
1786:                         ENDIF
1787:                     ENDSCAN
1788:                 ENDIF
1789:             ENDIF
1790: 
1791:         CATCH TO loException
1792:             MostrarErro("Erro ao salvar fretes por estado:" + CHR(13) + loException.Message, ;
1793:                 "Formtra.SalvarGradeEstados")
1794:             loc_lResultado = .F.
1795:         ENDTRY

*-- Linhas 1806 a 1965:
1806:             RETURN
1807:         ENDIF
1808: 
1809:         SELECT cursor_4c_Estados
1810:         APPEND BLANK
1811:         REPLACE cidchaves WITH fUniqueIds(""), uf WITH "", ufibges WITH 0, ;
1812:             munici WITH "", codibges WITH "", valfretes WITH 0, ;
1813:             pesomins WITH 0, pesomaxs WITH 0 IN cursor_4c_Estados
1814: 
1815:         WITH THIS.pgf_4c_Paginas.Page2.grd_4c_Estados
1816:             .Refresh()
1817:             .SetFocus()
1818:             .Column1.SetFocus()
1819:         ENDWITH
1820:     ENDPROC
1821: 
1822:     *===========================================================================
1823:     * BtnExcluirEstadoClick - Remove a linha atual da grade de estados
1824:     * (excluir.Click no legado)
1825:     *===========================================================================
1826:     PROCEDURE BtnExcluirEstadoClick()
1827:         IF !USED("cursor_4c_Estados")
1828:             RETURN
1829:         ENDIF
1830: 
1831:         SELECT cursor_4c_Estados
1832:         IF EOF() OR BOF()
1833:             RETURN
1834:         ENDIF
1835: 
1836:         DELETE IN cursor_4c_Estados
1837:         GO TOP IN cursor_4c_Estados
1838: 
1839:         THIS.pgf_4c_Paginas.Page2.grd_4c_Estados.Refresh()
1840:     ENDPROC
1841: 
1842:     *===========================================================================
1843:     * ValidarUfEstado - Lookup do campo UF da grade de estados (Column1)
1844:     * Legado: Column1.Text1.Valid - CreateObject('fwbuscaext', ..., 'SigCdUfs', ...)
1845:     *===========================================================================
1846:     PROCEDURE ValidarUfEstado(par_nKeyCode, par_nShiftAltCtrl)
1847:         LOCAL loc_oBusca, loc_cUf
1848: 
1849:         IF !USED("cursor_4c_Estados")
1850:             RETURN
1851:         ENDIF
1852: 
1853:         SELECT cursor_4c_Estados
1854:         loc_cUf = UPPER(ALLTRIM(cursor_4c_Estados.uf))
1855: 
1856:         IF EMPTY(loc_cUf)
1857:             REPLACE uf WITH "", ufibges WITH 0, munici WITH "", codibges WITH "", ;
1858:                 valfretes WITH 0, pesomins WITH 0, pesomaxs WITH 0 IN cursor_4c_Estados
1859:             THIS.pgf_4c_Paginas.Page2.grd_4c_Estados.Refresh()
1860:             RETURN
1861:         ENDIF
1862: 
1863:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdUfs", ;
1864:             "cursor_4c_BuscaUf", "Estados", PADR(loc_cUf, 2), "Selecionar Estado")
1865: 
1866:         IF VARTYPE(loc_oBusca) = "O"
1867:             IF !loc_oBusca.this_lAchouRegistro
1868:                 loc_oBusca.mAddColuna("Estados", "", "UF")
1869:                 loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1870:                 loc_oBusca.mAddColuna("UFIBGEs", "", "IBGE")
1871:                 loc_oBusca.Show()
1872:             ENDIF
1873: 
1874:             SELECT cursor_4c_Estados
1875:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUf")
1876:                 REPLACE uf WITH ALLTRIM(cursor_4c_BuscaUf.Estados), ;
1877:                     ufibges WITH cursor_4c_BuscaUf.UFIBGEs, ;
1878:                     munici WITH "", codibges WITH "", ;
1879:                     valfretes WITH 0, pesomins WITH 0, pesomaxs WITH 0 ;
1880:                     IN cursor_4c_Estados
1881:             ELSE
1882:                 REPLACE uf WITH "", ufibges WITH 0, munici WITH "", codibges WITH "", ;
1883:                     valfretes WITH 0, pesomins WITH 0, pesomaxs WITH 0 IN cursor_4c_Estados
1884:             ENDIF
1885: 
1886:             IF USED("cursor_4c_BuscaUf")
1887:                 USE IN cursor_4c_BuscaUf
1888:             ENDIF
1889:             loc_oBusca.Release()
1890:         ENDIF
1891: 
1892:         THIS.pgf_4c_Paginas.Page2.grd_4c_Estados.Refresh()
1893:     ENDPROC
1894: 
1895:     *===========================================================================
1896:     * ValidarMunicipioEstado - Lookup do Municipio da grade de estados (Column5)
1897:     * Legado: Column5.Text1.Valid - join SigCdMun+SigCdUfs filtrado pela UF da
1898:     * linha atual, seek exato ou fwbuscaint (grid) se nao achar
1899:     *===========================================================================
1900:     PROCEDURE ValidarMunicipioEstado(par_nKeyCode, par_nShiftAltCtrl)
1901:         LOCAL loc_cUf, loc_cMunicipio, loc_cSQL, loc_nResultado, loc_oBusca
1902: 
1903:         IF !USED("cursor_4c_Estados")
1904:             RETURN
1905:         ENDIF
1906: 
1907:         SELECT cursor_4c_Estados
1908:         loc_cUf        = UPPER(ALLTRIM(cursor_4c_Estados.uf))
1909:         loc_cMunicipio = ALLTRIM(cursor_4c_Estados.munici)
1910: 
1911:         IF EMPTY(loc_cUf) OR EMPTY(loc_cMunicipio)
1912:             RETURN
1913:         ENDIF
1914: 
1915:         IF USED("cursor_4c_BuscaMunicipio")
1916:             USE IN cursor_4c_BuscaMunicipio
1917:         ENDIF
1918: 
1919:         TEXT TO loc_cSQL TEXTMERGE NOSHOW
1920:             SELECT b.estados AS uf, a.descs AS munici, a.codigos AS codibges
1921:             FROM SigCdMun a
1922:             INNER JOIN SigCdUfs b ON a.ufibges = b.ufibges
1923:             WHERE b.estados = <<EscaparSQL(loc_cUf)>>
1924:             ORDER BY a.descs
1925:         ENDTEXT
1926: 
1927:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMunicipio")
1928: 
1929:         IF loc_nResultado < 0 OR !USED("cursor_4c_BuscaMunicipio")
1930:             MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
1931:                 "Falha na Conex" + CHR(227) + "o")
1932:             RETURN
1933:         ENDIF
1934: 
1935:         SELECT cursor_4c_BuscaMunicipio
1936:         LOCATE FOR UPPER(ALLTRIM(munici)) == UPPER(loc_cMunicipio)
1937: 
1938:         IF FOUND()
1939:             SELECT cursor_4c_Estados
1940:             REPLACE munici WITH ALLTRIM(cursor_4c_BuscaMunicipio.munici), ;
1941:                 codibges WITH ALLTRIM(cursor_4c_BuscaMunicipio.codibges) IN cursor_4c_Estados
1942:         ELSE
1943:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1944:             loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaMunicipio"
1945:             loc_oBusca.this_cTitulo        = "Selecionar Munic" + CHR(237) + "pio"
1946:             loc_oBusca.mAddColuna("munici", "", "Munic" + CHR(237) + "pio")
1947:             loc_oBusca.mAddColuna("uf", "", "UF")
1948:             loc_oBusca.Show()
1949: 
1950:             SELECT cursor_4c_Estados
1951:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMunicipio")
1952:                 REPLACE munici WITH ALLTRIM(cursor_4c_BuscaMunicipio.munici), ;
1953:                     codibges WITH ALLTRIM(cursor_4c_BuscaMunicipio.codibges) IN cursor_4c_Estados
1954:             ELSE
1955:                 REPLACE munici WITH "", codibges WITH "" IN cursor_4c_Estados
1956:             ENDIF
1957:             loc_oBusca.Release()
1958:         ENDIF
1959: 
1960:         REPLACE valfretes WITH 0, pesomins WITH 0, pesomaxs WITH 0 IN cursor_4c_Estados
1961: 
1962:         IF USED("cursor_4c_BuscaMunicipio")
1963:             USE IN cursor_4c_BuscaMunicipio
1964:         ENDIF
1965: 

*-- Linhas 2052 a 2071:
2052:         *-- Legado: frete/peso nao pode ficar totalmente zerado (regra de negocio)
2053:         loc_lFreteInvalido = .F.
2054:         IF USED("cursor_4c_Estados")
2055:             SELECT cursor_4c_Estados
2056:             LOCATE FOR !DELETED() AND !EMPTY(ALLTRIM(uf)) AND ;
2057:                 (valfretes = 0 OR (pesomins = 0 AND pesomaxs = 0))
2058:             loc_lFreteInvalido = FOUND()
2059:         ENDIF
2060: 
2061:         IF loc_lFreteInvalido
2062:             MsgAviso("Valor do frete, peso m" + CHR(237) + "nimo ou peso m" + CHR(225) + ;
2063:                 "ximo n" + CHR(227) + "o podem ficar zerados.")
2064:             RETURN
2065:         ENDIF
2066: 
2067:         IF THIS.this_oBusinessObject.Salvar()
2068:             IF THIS.SalvarGradeEstados(THIS.this_oBusinessObject.this_cCodigo)
2069:                 MsgInfo("Registro salvo com sucesso!", "Confirmar")
2070:                 THIS.AlternarPagina(1)
2071:             ELSE

*-- Linhas 2108 a 2156:
2108:     *===========================================================================
2109:     PROCEDURE BtnVisualizarClick()
2110:         LOCAL loc_cCodigo
2111:         loc_cCodigo = ""
2112: 
2113:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
2114:             SELECT cursor_4c_Dados
2115:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.itras)
2116:         ENDIF
2117: 
2118:         IF EMPTY(loc_cCodigo)
2119:             MsgAviso("Selecione um registro para visualizar.")
2120:         ELSE
2121:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2122:                 THIS.this_cModoAtual = "VISUALIZAR"
2123:                 THIS.BOParaForm()
2124:                 THIS.HabilitarCampos(.F.)
2125:                 THIS.AjustarBotoesPorModo()
2126:                 THIS.AlternarPagina(2)
2127:             ENDIF
2128:         ENDIF
2129:     ENDPROC
2130: 
2131:     *===========================================================================
2132:     * BtnAlterarClick - Abre Page2 para alterar registro selecionado
2133:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
2134:     *===========================================================================
2135:     PROCEDURE BtnAlterarClick()
2136:         LOCAL loc_cCodigo
2137:         loc_cCodigo = ""
2138: 
2139:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
2140:             SELECT cursor_4c_Dados
2141:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.itras)
2142:         ENDIF
2143: 
2144:         IF EMPTY(loc_cCodigo)
2145:             MsgAviso("Selecione um registro para alterar.")
2146:         ELSE
2147:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2148:                 THIS.this_oBusinessObject.EditarRegistro()
2149:                 THIS.this_cModoAtual = "ALTERAR"
2150:                 THIS.BOParaForm()
2151:                 THIS.HabilitarCampos(.T.)
2152:                 THIS.AjustarBotoesPorModo()
2153:                 THIS.AlternarPagina(2)
2154:             ENDIF
2155:         ENDIF
2156:     ENDPROC

*-- Linhas 2163 a 2185:
2163:     *===========================================================================
2164:     PROCEDURE BtnExcluirClick()
2165:         LOCAL loc_cCodigo
2166:         loc_cCodigo = ""
2167: 
2168:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
2169:             SELECT cursor_4c_Dados
2170:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.itras)
2171:         ENDIF
2172: 
2173:         IF EMPTY(loc_cCodigo)
2174:             MsgAviso("Selecione um registro para excluir.")
2175:         ELSE
2176:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2177:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da transportadora [" + loc_cCodigo + "]?", ;
2178:                     "Confirmar Exclus" + CHR(227) + "o")
2179:                     IF THIS.this_oBusinessObject.Excluir()
2180:                         MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
2181:                         THIS.CarregarLista()
2182:                     ENDIF
2183:                 ENDIF
2184:             ENDIF
2185:         ENDIF

*-- Linhas 2205 a 2235:
2205:                 loc_oBusca.Show()
2206: 
2207:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTra")
2208:                     SELECT cursor_4c_BuscaTra
2209:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaTra.itras)
2210:                 ENDIF
2211: 
2212:                 loc_oBusca.Release()
2213:             ENDIF
2214: 
2215:             IF USED("cursor_4c_BuscaTra")
2216:                 USE IN cursor_4c_BuscaTra
2217:             ENDIF
2218: 
2219:             IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
2220:                 SELECT cursor_4c_Dados
2221:                 LOCATE FOR ALLTRIM(itras) == loc_cCodigo
2222:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
2223:             ENDIF
2224: 
2225:         CATCH TO loException
2226:             MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "Formtra.BtnBuscarClick")
2227:             IF USED("cursor_4c_BuscaTra")
2228:                 USE IN cursor_4c_BuscaTra
2229:             ENDIF
2230:         ENDTRY
2231:     ENDPROC
2232: 
2233:     *===========================================================================
2234:     * BtnEncerrarClick - Fecha o formulario
2235:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)

*-- Linhas 2320 a 2338:
2320:         loc_oPg.txt_4c_Senha2.Value                 = ""
2321: 
2322:         IF USED("cursor_4c_Estados")
2323:             SELECT cursor_4c_Estados
2324:             ZAP
2325:         ENDIF
2326:         loc_oPg.grd_4c_Estados.Refresh()
2327:     ENDPROC
2328: 
2329:     *===========================================================================
2330:     * AjustarBotoesPorModo - Ajusta estado dos botoes da Page2 conforme modo
2331:     * INCLUIR/ALTERAR: Confirmar habilitado | VISUALIZAR: Confirmar desabilitado
2332:     * PUBLIC: harness TesteAutomatico.prg chama direto de fora da classe (regra #3)
2333:     *===========================================================================
2334:     PROCEDURE AjustarBotoesPorModo()
2335:         LOCAL loc_oPagina, loc_lEditando
2336:         loc_oPagina   = THIS.pgf_4c_Paginas.Page2
2337:         loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2338: 

*-- Linhas 2378 a 2399:
2378:     PROCEDURE Destroy()
2379:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2380:             THIS.this_oBusinessObject = .NULL.
2381:         ENDIF
2382: 
2383:         IF USED("cursor_4c_Dados")
2384:             USE IN cursor_4c_Dados
2385:         ENDIF
2386: 
2387:         IF USED("cursor_4c_Estados")
2388:             USE IN cursor_4c_Estados
2389:         ENDIF
2390: 
2391:         IF USED("cursor_4c_EstadosTemp")
2392:             USE IN cursor_4c_EstadosTemp
2393:         ENDIF
2394: 
2395:         IF USED("cursor_4c_BuscaUf")
2396:             USE IN cursor_4c_BuscaUf
2397:         ENDIF
2398: 
2399:         IF USED("cursor_4c_BuscaMunicipio")


### BO (C:\4c\projeto\app\classes\traBO.prg):
*====================================================================
* traBO.prg
*
* Business Object para Cadastro de Transportadoras
* Tabela: SigPrTrp (cabecalho) / SigPrTrv (fretes por estado - detalhe)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS traBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigPrTrp)
    this_cCodigo             = ""    && itras char(10) - PK
    this_nCodigoSequencial   = 0     && codigos numeric(6,0) - sequencial usado para gerar o itras
    this_cRazaoSocial        = ""    && razaos char(40)
    this_cEndereco           = ""    && endes char(40)
    this_cBairro             = ""    && bairs char(20)
    this_cCidade             = ""    && cidas char(30)
    this_cCep                = ""    && ceps char(9)
    this_cUf                 = ""    && estas char(2)
    this_cTelefone1          = ""    && tel1s char(20)
    this_cTelefone2          = ""    && tel2s char(20)
    this_cFax                = ""    && faxs char(20)
    this_cCgc                = ""    && cgcs char(20)
    this_cInscricaoEstadual  = ""    && inscs char(20)
    this_cApelido            = ""    && apelidos char(30) NULL
    this_cIdTransportadora   = ""    && idtransp char(50) - rotulado "ID E-Commerce" no legado
    this_cTipoConexao        = ""    && tpconexao char(1) - D/B (Dial-Up / Banda Larga)
    this_cFtpEndereco        = ""    && ftpend char(50)
    this_cFtpUsuario         = ""    && ftpusuario char(50)
    this_cFtpSenha           = ""    && ftpsenha char(20)
    this_cDirFtpEnvio        = ""    && dirftpts char(60) - "Pasta p/ Envio"
    this_cDirFtpRecepcao     = ""    && dirftpls char(60) - "Pasta p/ Recepcao"
    this_cDriveGeracao       = ""    && drivets char(60) - "Geracao"
    this_cDriveLeitura       = ""    && drivels char(60) - "Leitura"
    this_lLimpaDiretorioFtp  = .F.   && ftpdel bit NULL
    this_lLimpaDiretorioLocal = .F.  && locdel bit NULL
    this_cUrlTransp          = ""    && urltransp char(200)
    this_nTipoTransporte     = 0     && tipotrans numeric(1,0)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrTrp"
            THIS.this_cCampoChave = "itras"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "traBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo             = TratarNulo(itras,      "C")
                THIS.this_cRazaoSocial        = TratarNulo(razaos,     "C")
                THIS.this_nCodigoSequencial   = TratarNulo(codigos,    "N")
                THIS.this_cEndereco           = TratarNulo(endes,      "C")
                THIS.this_cBairro             = TratarNulo(bairs,      "C")
                THIS.this_cCidade             = TratarNulo(cidas,      "C")
                THIS.this_cCep                = TratarNulo(ceps,       "C")
                THIS.this_cUf                 = TratarNulo(estas,      "C")
                THIS.this_cTelefone1          = TratarNulo(tel1s,      "C")
                THIS.this_cTelefone2          = TratarNulo(tel2s,      "C")
                THIS.this_cFax                = TratarNulo(faxs,       "C")
                THIS.this_cCgc                = TratarNulo(cgcs,       "C")
                THIS.this_cInscricaoEstadual  = TratarNulo(inscs,      "C")
                THIS.this_cApelido            = TratarNulo(apelidos,   "C")
                THIS.this_cIdTransportadora   = TratarNulo(idtransp,   "C")
                THIS.this_cTipoConexao        = TratarNulo(tpconexao,  "C")
                THIS.this_cFtpEndereco        = TratarNulo(ftpend,     "C")
                THIS.this_cFtpUsuario         = TratarNulo(ftpusuario, "C")
                THIS.this_cFtpSenha           = TratarNulo(ftpsenha,   "C")
                THIS.this_cDirFtpEnvio        = TratarNulo(dirftpts,   "C")
                THIS.this_cDirFtpRecepcao     = TratarNulo(dirftpls,   "C")
                THIS.this_cDriveGeracao       = TratarNulo(drivets,    "C")
                THIS.this_cDriveLeitura       = TratarNulo(drivels,    "C")
                THIS.this_lLimpaDiretorioFtp  = ConverterParaLogico(ftpdel)
                THIS.this_lLimpaDiretorioLocal = ConverterParaLogico(locdel)
                THIS.this_cUrlTransp          = TratarNulo(urltransp,  "C")
                THIS.this_nTipoTransporte     = TratarNulo(tipotrans,  "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "traBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InicializarValoresPadrao - Gera codigo (itras) para novo registro
    * Legado: m.Codigos = fGerUniqueKey('SigPrTrp' + _Empr)
    *         m.Itras   = 'T' + _Empr + Padl(m.codigos, 6, '0')
    * Aqui o sequencial vem do MAX(codigos) da propria tabela (seguro entre
    * sessoes), e _Empr (legado) -> go_4c_Sistema.cCodEmpresa
    *====================================================================
    PROTECTED PROCEDURE InicializarValoresPadrao()
        LOCAL loc_cSQL, loc_nResultado, loc_nSeq, loc_cEmpresa
        loc_nSeq = 1

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(codigos),0) AS maxval FROM SigPrTrp"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SeqTra")
            IF loc_nResultado >= 0 AND USED("cursor_4c_SeqTra")
                SELECT cursor_4c_SeqTra
                loc_nSeq = NVL(cursor_4c_SeqTra.maxval, 0) + 1
                USE IN cursor_4c_SeqTra
            ENDIF
        CATCH TO loException
            loc_nSeq = 1
        ENDTRY

        loc_cEmpresa = IIF(TYPE("go_4c_Sistema.cCodEmpresa") = "C", ;
            ALLTRIM(go_4c_Sistema.cCodEmpresa), "")

        THIS.this_nCodigoSequencial = loc_nSeq
        THIS.this_cCodigo           = "T" + loc_cEmpresa + PADL(TRANSFORM(loc_nSeq), 6, "0")
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigo))
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo Inv" + CHR(225) + "lido."
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCodigo)
                THIS.this_cMensagemErro = "C" + CHR(243) + "digo J" + CHR(225) + " Cadastrado."
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cRazaoSocial))
            THIS.this_cMensagemErro = "Raz" + CHR(227) + "o Social " + CHR(233) + " obrigat" + CHR(243) + "ria."
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarCodigoExistente - Verifica se itras ja existe no banco
    *====================================================================
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigPrTrp" + ;
                " WHERE itras = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkTra")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkTra")
                SELECT cursor_4c_ChkTra
                loc_lExiste = (cursor_4c_ChkTra.qtd > 0)
                USE IN cursor_4c_ChkTra
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "traBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigPrTrp
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrTrp (itras, razaos, codigos, endes, bairs, cidas, ceps, estas,
                    tel1s, tel2s, faxs, cgcs, inscs, apelidos, idtransp, dirftpls, dirftpts,
                    drivels, drivets, ftpdel, ftpend, ftpsenha, ftpusuario, locdel, tpconexao,
                    urltransp, tipotrans)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cRazaoSocial)>>,
                    <<FormatarNumeroSQL(THIS.this_nCodigoSequencial, 0)>>,
                    <<EscaparSQL(THIS.this_cEndereco)>>,
                    <<EscaparSQL(THIS.this_cBairro)>>,
                    <<EscaparSQL(THIS.this_cCidade)>>,
                    <<EscaparSQL(THIS.this_cCep)>>,
                    <<EscaparSQL(THIS.this_cUf)>>,
                    <<EscaparSQL(THIS.this_cTelefone1)>>,
                    <<EscaparSQL(THIS.this_cTelefone2)>>,
                    <<EscaparSQL(THIS.this_cFax)>>,
                    <<EscaparSQL(THIS.this_cCgc)>>,
                    <<EscaparSQL(THIS.this_cInscricaoEstadual)>>,
                    <<EscaparSQL(THIS.this_cApelido)>>,
                    <<EscaparSQL(THIS.this_cIdTransportadora)>>,
                    <<EscaparSQL(THIS.this_cDirFtpRecepcao)>>,
                    <<EscaparSQL(THIS.this_cDirFtpEnvio)>>,
                    <<EscaparSQL(THIS.this_cDriveLeitura)>>,
                    <<EscaparSQL(THIS.this_cDriveGeracao)>>,
                    <<IIF(THIS.this_lLimpaDiretorioFtp, 1, 0)>>,
                    <<EscaparSQL(THIS.this_cFtpEndereco)>>,
                    <<EscaparSQL(THIS.this_cFtpSenha)>>,
                    <<EscaparSQL(THIS.this_cFtpUsuario)>>,
                    <<IIF(THIS.this_lLimpaDiretorioLocal, 1, 0)>>,
                    <<EscaparSQL(THIS.this_cTipoConexao)>>,
                    <<EscaparSQL(THIS.this_cUrlTransp)>>,
                    <<FormatarNumeroSQL(THIS.this_nTipoTransporte, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir transportadora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "traBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigPrTrp
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrTrp
                SET razaos      = <<EscaparSQL(THIS.this_cRazaoSocial)>>,
                    endes       = <<EscaparSQL(THIS.this_cEndereco)>>,
                    bairs       = <<EscaparSQL(THIS.this_cBairro)>>,
                    cidas       = <<EscaparSQL(THIS.this_cCidade)>>,
                    ceps        = <<EscaparSQL(THIS.this_cCep)>>,
                    estas       = <<EscaparSQL(THIS.this_cUf)>>,
                    tel1s       = <<EscaparSQL(THIS.this_cTelefone1)>>,
                    tel2s       = <<EscaparSQL(THIS.this_cTelefone2)>>,
                    faxs        = <<EscaparSQL(THIS.this_cFax)>>,
                    cgcs        = <<EscaparSQL(THIS.this_cCgc)>>,
                    inscs       = <<EscaparSQL(THIS.this_cInscricaoEstadual)>>,
                    apelidos    = <<EscaparSQL(THIS.this_cApelido)>>,
                    idtransp    = <<EscaparSQL(THIS.this_cIdTransportadora)>>,
                    dirftpls    = <<EscaparSQL(THIS.this_cDirFtpRecepcao)>>,
                    dirftpts    = <<EscaparSQL(THIS.this_cDirFtpEnvio)>>,
                    drivels     = <<EscaparSQL(THIS.this_cDriveLeitura)>>,
                    drivets     = <<EscaparSQL(THIS.this_cDriveGeracao)>>,
                    ftpdel      = <<IIF(THIS.this_lLimpaDiretorioFtp, 1, 0)>>,
                    ftpend      = <<EscaparSQL(THIS.this_cFtpEndereco)>>,
                    ftpsenha    = <<EscaparSQL(THIS.this_cFtpSenha)>>,
                    ftpusuario  = <<EscaparSQL(THIS.this_cFtpUsuario)>>,
                    locdel      = <<IIF(THIS.this_lLimpaDiretorioLocal, 1, 0)>>,
                    tpconexao   = <<EscaparSQL(THIS.this_cTipoConexao)>>,
                    urltransp   = <<EscaparSQL(THIS.this_cUrlTransp)>>,
                    tipotrans   = <<FormatarNumeroSQL(THIS.this_nTipoTransporte, 0)>>
                WHERE itras = <<EscaparSQL(THIS.this_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar transportadora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "traBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigPrTrp e os fretes
    * por estado associados (SigPrTrv), espelhando o legado
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrTrv WHERE itras = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MostrarErro("Erro ao excluir fretes da transportadora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_cSQL = "DELETE FROM SigPrTrp WHERE itras = " + EscaparSQL(THIS.this_cCodigo)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir transportadora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "traBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com itras, razaos, tel1s
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (itras C(10), razaos C(40), tel1s C(20))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT itras, razaos, tel1s FROM SigPrTrp"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY razaos"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar transportadoras:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "traBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (itras)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT itras, razaos, codigos, endes, bairs, cidas, ceps, estas,
                    tel1s, tel2s, faxs, cgcs, inscs, apelidos, idtransp, dirftpls,
                    dirftpts, drivels, drivets, ftpdel, ftpend, ftpsenha, ftpusuario,
                    locdel, tpconexao, urltransp, tipotrans
                FROM SigPrTrp
                WHERE itras = <<EscaparSQL(par_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    THIS.this_cMensagemErro = "Transportadora n" + CHR(227) + "o encontrada!"
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar transportadora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "traBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

