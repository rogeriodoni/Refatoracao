# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (5)
- [GRID-SQL] Campo 'itras' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'razaos' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'cidas' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'estas' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'cgcs' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formtra.prg) - TRECHOS RELEVANTES PARA PASS SQL (2414 linhas total):

*-- Linhas 101 a 121:
101:         THIS.ConfigurarPaginaDados()
102:     ENDPROC
103: 
104:     *===========================================================================
105:     * ConfigurarPaginaLista - Page1 (Lista de Transportadoras)
106:     * Grid: cursor_4c_Dados (itras, razaos, cidas, estas, cgcs) - traBO.Buscar()
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

*-- Linhas 349 a 403:
349:             .HighlightBackColor = RGB(255, 255, 255)
350:             .HighlightForeColor = RGB(15, 41, 104)
351:             .HighlightStyle     = 2
352:             .DeleteMark         = .F.
353:             .RecordMark         = .F.
354:             .RowHeight          = 16
355:             .ScrollBars         = 2
356:             .GridLines          = 3
357:             .Visible            = .T.
358:         ENDWITH
359:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
360: 
361:         THIS.TornarControlesVisiveis(loc_oPagina)
362:     ENDPROC
363: 
364:     *===========================================================================
365:     * CarregarLista - Carrega dados no grid da Page1
366:     * OBRIGATORIO: Reconfigura ControlSource e Headers APOS RecordSource (Problema 2/48)
367:     * OBRIGATORIO: RecordSource FORA do WITH (Problema 36)
368:     *===========================================================================
369:     PROCEDURE CarregarLista()
370:         LOCAL loc_lResultado, loc_oGrid
371:         loc_lResultado = .F.
372: 
373:         TRY
374:             IF !THIS.this_oBusinessObject.Buscar("")
375:                 loc_lResultado = .F.
376:             ELSE
377:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
378: 
379:                 *-- PROBLEMA 48: RecordSource ANTES de ControlSource (FORA do WITH per Problema 36)
380:                 loc_oGrid.ColumnCount  = 5
381:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
382: 
383:                 *-- PROBLEMA 48: ControlSource APOS RecordSource (auto-bind seria sobrescrito)
384:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.itras"
385:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.razaos"
386:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cidas"
387:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.estas"
388:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.cgcs"
389: 
390:                 loc_oGrid.Column1.Width = 90
391:                 loc_oGrid.Column2.Width = 330
392:                 loc_oGrid.Column3.Width = 200
393:                 loc_oGrid.Column4.Width = 50
394:                 loc_oGrid.Column5.Width = 150
395: 
396:                 *-- PROBLEMA 2/32: Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
397:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
398:                 loc_oGrid.Column2.Header1.Caption = "Raz" + CHR(227) + "o Social"
399:                 loc_oGrid.Column3.Header1.Caption = "Cidade"
400:                 loc_oGrid.Column4.Header1.Caption = "UF"
401:                 loc_oGrid.Column5.Header1.Caption = "CGC"
402: 
403:                 THIS.FormatarGridLista(loc_oGrid)

*-- Linhas 1481 a 1515:
1481:         ENDWITH
1482: 
1483:         *-- Grid de fretes por estado - estrutura criada aqui; RecordSource,
1484:         *-- ControlSource e Headers sao definidos em CarregarGradeEstados()
1485:         *-- (Problema 2/48: reconfigurar SOMENTE apos RecordSource)
1486:         loc_oPagina.AddObject("grd_4c_Estados", "Grid")
1487:         loc_oPagina.grd_4c_Estados.ColumnCount = 5
1488:         WITH loc_oPagina.grd_4c_Estados
1489:             .Top           = 211
1490:             .Left          = 500
1491:             .Width         = 490
1492:             .Height        = 419
1493:             .FontName      = "Tahoma"
1494:             .FontSize      = 8
1495:             .ForeColor     = RGB(0, 0, 0)
1496:             .BackColor     = RGB(255, 255, 255)
1497:             .GridLineColor = RGB(238, 238, 238)
1498:             .GridLineWidth = 1
1499:             .HeaderHeight  = 20
1500:             .DeleteMark    = .F.
1501:             .RecordMark    = .F.
1502:             .ScrollBars    = 2
1503:             .GridLines     = 3
1504:             .Panel         = 1
1505:             .Visible       = .T.
1506:         ENDWITH
1507: 
1508:         *-- Coluna UF (Column1) - controle customizado com lookup no LostFocus
1509:         *-- (CLAUDE.md regra #18: precisa de CurrentControl + Sparse=.F.)
1510:         loc_oPagina.grd_4c_Estados.Column1.AddObject("txt_4c_ColUf", "TextBox")
1511:         WITH loc_oPagina.grd_4c_Estados.Column1.txt_4c_ColUf
1512:             .FontName    = "Arial"
1513:             .FontSize    = 8
1514:             .Alignment   = 2
1515:             .BorderStyle = 0

*-- Linhas 1645 a 1728:
1645:     *===========================================================================
1646:     * CarregarGradeEstados - Carrega/atualiza a grade de fretes por estado
1647:     * (GradEstado/crSigPrTrv no legado). SigPrTrv NAO tem colunas "uf"/"munici" -
1648:     * sao alias de JOIN com SigCdUfs/SigCdMun (ver docs/schema.sql).
1649:     * REGRA: RecordSource/ControlSource/Headers configurados so na 1a chamada
1650:     * (Problema 48); recargas seguintes usam cursor temporario + ZAP + APPEND
1651:     * (Problema 34/35) para nao destruir as colunas do Grid.
1652:     *===========================================================================
1653:     PROCEDURE CarregarGradeEstados(par_cCodigo)
1654:         LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_oGrid, loc_lPrimeiraVez
1655:         loc_lResultado = .F.
1656: 
1657:         TRY
1658:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Estados
1659:             loc_lPrimeiraVez = EMPTY(loc_oGrid.RecordSource)
1660: 
1661:             IF !USED("cursor_4c_Estados")
1662:                 SET NULL ON
1663:                 CREATE CURSOR cursor_4c_Estados (cidchaves C(20), codibges C(7), ;
1664:                     pesomaxs N(8,2), pesomins N(8,2), ufibges N(5,0), valfretes N(9,2), ;
1665:                     uf C(2), munici C(40))
1666:                 SET NULL OFF
1667:             ELSE
1668:                 SELECT cursor_4c_Estados
1669:                 ZAP
1670:             ENDIF
1671: 
1672:             IF VARTYPE(par_cCodigo) = "C" AND !EMPTY(par_cCodigo) ;
1673:                     AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1674: 
1675:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
1676:                     SELECT a.cidchaves, a.codibges, a.pesomaxs, a.pesomins, a.ufibges,
1677:                         a.valfretes, d.estados AS uf, c.descs AS munici
1678:                     FROM SigPrTrv a
1679:                     INNER JOIN SigCdUfs d ON d.ufibges = a.ufibges
1680:                     LEFT JOIN SigCdMun c ON c.codigos = a.codibges
1681:                     WHERE a.itras = <<EscaparSQL(par_cCodigo)>>
1682:                     ORDER BY d.estados
1683:                 ENDTEXT
1684: 
1685:                 IF USED("cursor_4c_EstadosTemp")
1686:                     USE IN cursor_4c_EstadosTemp
1687:                 ENDIF
1688:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstadosTemp")
1689: 
1690:                 IF loc_nResultado >= 0 AND USED("cursor_4c_EstadosTemp")
1691:                     SELECT cursor_4c_Estados
1692:                     APPEND FROM DBF("cursor_4c_EstadosTemp")
1693:                     USE IN cursor_4c_EstadosTemp
1694:                 ELSE
1695:                     MostrarErro("Erro ao carregar fretes por estado:" + CHR(13) + CapturarErroSQL(), ;
1696:                         "Formtra.CarregarGradeEstados")
1697:                 ENDIF
1698:             ENDIF
1699: 
1700:             SELECT cursor_4c_Estados
1701:             GO TOP
1702: 
1703:             IF loc_lPrimeiraVez
1704:                 loc_oGrid.RecordSource = "cursor_4c_Estados"
1705: 
1706:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Estados.uf"
1707:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Estados.valfretes"
1708:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Estados.pesomins"
1709:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Estados.pesomaxs"
1710:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Estados.munici"
1711: 
1712:                 loc_oGrid.Column1.txt_4c_ColUf.ControlSource        = "cursor_4c_Estados.uf"
1713:                 loc_oGrid.Column5.txt_4c_ColMunicipio.ControlSource = "cursor_4c_Estados.munici"
1714: 
1715:                 loc_oGrid.Column1.Width = 50
1716:                 loc_oGrid.Column2.Width = 90
1717:                 loc_oGrid.Column3.Width = 90
1718:                 loc_oGrid.Column4.Width = 90
1719:                 loc_oGrid.Column5.Width = 165
1720: 
1721:                 loc_oGrid.Column2.Text1.Alignment = 3
1722:                 loc_oGrid.Column3.Text1.Alignment = 3
1723:                 loc_oGrid.Column4.Text1.Alignment = 3
1724: 
1725:                 loc_oGrid.Column1.Header1.Caption = "UF"
1726:                 loc_oGrid.Column2.Header1.Caption = "Valor"
1727:                 loc_oGrid.Column3.Header1.Caption = "Peso M" + CHR(237) + "nimo"
1728:                 loc_oGrid.Column4.Header1.Caption = "Peso M" + CHR(225) + "ximo"

*-- Linhas 1745 a 1799:
1745:     * SalvarGradeEstados - Grava os fretes por estado da grade (cursor_4c_Estados)
1746:     * na tabela SigPrTrv. Estrategia: apaga tudo do codigo e regrava (mais simples
1747:     * e seguro que diff linha-a-linha; equivalente ao msv_inserir/msv_alterar
1748:     * do legado que tambem regravam o cursor inteiro via poDataMgr.Update).
1749:     *===========================================================================
1750:     PROCEDURE SalvarGradeEstados(par_cCodigo)
1751:         LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_cCidChaves
1752:         loc_lResultado = .T.
1753: 
1754:         TRY
1755:             loc_cSQL = "DELETE FROM SigPrTrv WHERE itras = " + EscaparSQL(par_cCodigo)
1756:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
1757: 
1758:             IF loc_nResultado < 0
1759:                 MostrarErro("Erro ao atualizar fretes por estado:" + CHR(13) + CapturarErroSQL(), ;
1760:                     "Formtra.SalvarGradeEstados")
1761:                 loc_lResultado = .F.
1762:             ELSE
1763:                 IF USED("cursor_4c_Estados")
1764:                     SELECT cursor_4c_Estados
1765:                     SCAN FOR !DELETED() AND !EMPTY(ALLTRIM(uf))
1766:                         loc_cCidChaves = ALLTRIM(cursor_4c_Estados.cidchaves)
1767:                         IF EMPTY(loc_cCidChaves)
1768:                             loc_cCidChaves = fUniqueIds("")
1769:                         ENDIF
1770: 
1771:                         TEXT TO loc_cSQL TEXTMERGE NOSHOW
1772:                             INSERT INTO SigPrTrv (cidchaves, codibges, itras, pesomaxs, pesomins, ufibges, valfretes)
1773:                             VALUES (
1774:                                 <<EscaparSQL(loc_cCidChaves)>>,
1775:                                 <<EscaparSQL(cursor_4c_Estados.codibges)>>,
1776:                                 <<EscaparSQL(par_cCodigo)>>,
1777:                                 <<FormatarNumeroSQL(cursor_4c_Estados.pesomaxs, 2)>>,
1778:                                 <<FormatarNumeroSQL(cursor_4c_Estados.pesomins, 2)>>,
1779:                                 <<FormatarNumeroSQL(cursor_4c_Estados.ufibges, 0)>>,
1780:                                 <<FormatarNumeroSQL(cursor_4c_Estados.valfretes, 2)>>
1781:                             )
1782:                         ENDTEXT
1783: 
1784:                         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
1785:                         IF loc_nResultado < 0
1786:                             MostrarErro("Erro ao gravar frete do estado " + ALLTRIM(cursor_4c_Estados.uf) + ":" + ;
1787:                                 CHR(13) + CapturarErroSQL(), "Formtra.SalvarGradeEstados")
1788:                             loc_lResultado = .F.
1789:                             EXIT
1790:                         ENDIF
1791:                     ENDSCAN
1792:                 ENDIF
1793:             ENDIF
1794: 
1795:         CATCH TO loException
1796:             MostrarErro("Erro ao salvar fretes por estado:" + CHR(13) + loException.Message, ;
1797:                 "Formtra.SalvarGradeEstados")
1798:             loc_lResultado = .F.
1799:         ENDTRY

*-- Linhas 1810 a 1969:
1810:             RETURN
1811:         ENDIF
1812: 
1813:         SELECT cursor_4c_Estados
1814:         APPEND BLANK
1815:         REPLACE cidchaves WITH fUniqueIds(""), uf WITH "", ufibges WITH 0, ;
1816:             munici WITH "", codibges WITH "", valfretes WITH 0, ;
1817:             pesomins WITH 0, pesomaxs WITH 0 IN cursor_4c_Estados
1818: 
1819:         WITH THIS.pgf_4c_Paginas.Page2.grd_4c_Estados
1820:             .Refresh()
1821:             .SetFocus()
1822:             .Column1.SetFocus()
1823:         ENDWITH
1824:     ENDPROC
1825: 
1826:     *===========================================================================
1827:     * BtnExcluirEstadoClick - Remove a linha atual da grade de estados
1828:     * (excluir.Click no legado)
1829:     *===========================================================================
1830:     PROCEDURE BtnExcluirEstadoClick()
1831:         IF !USED("cursor_4c_Estados")
1832:             RETURN
1833:         ENDIF
1834: 
1835:         SELECT cursor_4c_Estados
1836:         IF EOF() OR BOF()
1837:             RETURN
1838:         ENDIF
1839: 
1840:         DELETE IN cursor_4c_Estados
1841:         GO TOP IN cursor_4c_Estados
1842: 
1843:         THIS.pgf_4c_Paginas.Page2.grd_4c_Estados.Refresh()
1844:     ENDPROC
1845: 
1846:     *===========================================================================
1847:     * ValidarUfEstado - Lookup do campo UF da grade de estados (Column1)
1848:     * Legado: Column1.Text1.Valid - CreateObject('fwbuscaext', ..., 'SigCdUfs', ...)
1849:     *===========================================================================
1850:     PROCEDURE ValidarUfEstado()
1851:         LOCAL loc_oBusca, loc_cUf
1852: 
1853:         IF !USED("cursor_4c_Estados")
1854:             RETURN
1855:         ENDIF
1856: 
1857:         SELECT cursor_4c_Estados
1858:         loc_cUf = UPPER(ALLTRIM(cursor_4c_Estados.uf))
1859: 
1860:         IF EMPTY(loc_cUf)
1861:             REPLACE uf WITH "", ufibges WITH 0, munici WITH "", codibges WITH "", ;
1862:                 valfretes WITH 0, pesomins WITH 0, pesomaxs WITH 0 IN cursor_4c_Estados
1863:             THIS.pgf_4c_Paginas.Page2.grd_4c_Estados.Refresh()
1864:             RETURN
1865:         ENDIF
1866: 
1867:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdUfs", ;
1868:             "cursor_4c_BuscaUf", "Estados", PADR(loc_cUf, 2), "Selecionar Estado")
1869: 
1870:         IF VARTYPE(loc_oBusca) = "O"
1871:             IF !loc_oBusca.this_lAchouRegistro
1872:                 loc_oBusca.mAddColuna("Estados", "", "UF")
1873:                 loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1874:                 loc_oBusca.mAddColuna("UFIBGEs", "", "IBGE")
1875:                 loc_oBusca.Show()
1876:             ENDIF
1877: 
1878:             SELECT cursor_4c_Estados
1879:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUf")
1880:                 REPLACE uf WITH ALLTRIM(cursor_4c_BuscaUf.Estados), ;
1881:                     ufibges WITH cursor_4c_BuscaUf.UFIBGEs, ;
1882:                     munici WITH "", codibges WITH "", ;
1883:                     valfretes WITH 0, pesomins WITH 0, pesomaxs WITH 0 ;
1884:                     IN cursor_4c_Estados
1885:             ELSE
1886:                 REPLACE uf WITH "", ufibges WITH 0, munici WITH "", codibges WITH "", ;
1887:                     valfretes WITH 0, pesomins WITH 0, pesomaxs WITH 0 IN cursor_4c_Estados
1888:             ENDIF
1889: 
1890:             IF USED("cursor_4c_BuscaUf")
1891:                 USE IN cursor_4c_BuscaUf
1892:             ENDIF
1893:             loc_oBusca.Release()
1894:         ENDIF
1895: 
1896:         THIS.pgf_4c_Paginas.Page2.grd_4c_Estados.Refresh()
1897:     ENDPROC
1898: 
1899:     *===========================================================================
1900:     * ValidarMunicipioEstado - Lookup do Municipio da grade de estados (Column5)
1901:     * Legado: Column5.Text1.Valid - join SigCdMun+SigCdUfs filtrado pela UF da
1902:     * linha atual, seek exato ou fwbuscaint (grid) se nao achar
1903:     *===========================================================================
1904:     PROCEDURE ValidarMunicipioEstado()
1905:         LOCAL loc_cUf, loc_cMunicipio, loc_cSQL, loc_nResultado, loc_oBusca
1906: 
1907:         IF !USED("cursor_4c_Estados")
1908:             RETURN
1909:         ENDIF
1910: 
1911:         SELECT cursor_4c_Estados
1912:         loc_cUf        = UPPER(ALLTRIM(cursor_4c_Estados.uf))
1913:         loc_cMunicipio = ALLTRIM(cursor_4c_Estados.munici)
1914: 
1915:         IF EMPTY(loc_cUf) OR EMPTY(loc_cMunicipio)
1916:             RETURN
1917:         ENDIF
1918: 
1919:         IF USED("cursor_4c_BuscaMunicipio")
1920:             USE IN cursor_4c_BuscaMunicipio
1921:         ENDIF
1922: 
1923:         TEXT TO loc_cSQL TEXTMERGE NOSHOW
1924:             SELECT b.estados AS uf, a.descs AS munici, a.codigos AS codibges
1925:             FROM SigCdMun a
1926:             INNER JOIN SigCdUfs b ON a.ufibges = b.ufibges
1927:             WHERE b.estados = <<EscaparSQL(loc_cUf)>>
1928:             ORDER BY a.descs
1929:         ENDTEXT
1930: 
1931:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMunicipio")
1932: 
1933:         IF loc_nResultado < 0 OR !USED("cursor_4c_BuscaMunicipio")
1934:             MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
1935:                 "Falha na Conex" + CHR(227) + "o")
1936:             RETURN
1937:         ENDIF
1938: 
1939:         SELECT cursor_4c_BuscaMunicipio
1940:         LOCATE FOR UPPER(ALLTRIM(munici)) == UPPER(loc_cMunicipio)
1941: 
1942:         IF FOUND()
1943:             SELECT cursor_4c_Estados
1944:             REPLACE munici WITH ALLTRIM(cursor_4c_BuscaMunicipio.munici), ;
1945:                 codibges WITH ALLTRIM(cursor_4c_BuscaMunicipio.codibges) IN cursor_4c_Estados
1946:         ELSE
1947:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1948:             loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaMunicipio"
1949:             loc_oBusca.this_cTitulo        = "Selecionar Munic" + CHR(237) + "pio"
1950:             loc_oBusca.mAddColuna("munici", "", "Munic" + CHR(237) + "pio")
1951:             loc_oBusca.mAddColuna("uf", "", "UF")
1952:             loc_oBusca.Show()
1953: 
1954:             SELECT cursor_4c_Estados
1955:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMunicipio")
1956:                 REPLACE munici WITH ALLTRIM(cursor_4c_BuscaMunicipio.munici), ;
1957:                     codibges WITH ALLTRIM(cursor_4c_BuscaMunicipio.codibges) IN cursor_4c_Estados
1958:             ELSE
1959:                 REPLACE munici WITH "", codibges WITH "" IN cursor_4c_Estados
1960:             ENDIF
1961:             loc_oBusca.Release()
1962:         ENDIF
1963: 
1964:         REPLACE valfretes WITH 0, pesomins WITH 0, pesomaxs WITH 0 IN cursor_4c_Estados
1965: 
1966:         IF USED("cursor_4c_BuscaMunicipio")
1967:             USE IN cursor_4c_BuscaMunicipio
1968:         ENDIF
1969: 

*-- Linhas 2056 a 2075:
2056:         *-- Legado: frete/peso nao pode ficar totalmente zerado (regra de negocio)
2057:         loc_lFreteInvalido = .F.
2058:         IF USED("cursor_4c_Estados")
2059:             SELECT cursor_4c_Estados
2060:             LOCATE FOR !DELETED() AND !EMPTY(ALLTRIM(uf)) AND ;
2061:                 (valfretes = 0 OR (pesomins = 0 AND pesomaxs = 0))
2062:             loc_lFreteInvalido = FOUND()
2063:         ENDIF
2064: 
2065:         IF loc_lFreteInvalido
2066:             MsgAviso("Valor do frete, peso m" + CHR(237) + "nimo ou peso m" + CHR(225) + ;
2067:                 "ximo n" + CHR(227) + "o podem ficar zerados.")
2068:             RETURN
2069:         ENDIF
2070: 
2071:         IF THIS.this_oBusinessObject.Salvar()
2072:             IF THIS.SalvarGradeEstados(THIS.this_oBusinessObject.this_cCodigo)
2073:                 MsgInfo("Registro salvo com sucesso!", "Confirmar")
2074:                 THIS.AlternarPagina(1)
2075:             ELSE

*-- Linhas 2112 a 2160:
2112:     *===========================================================================
2113:     PROCEDURE BtnVisualizarClick()
2114:         LOCAL loc_cCodigo
2115:         loc_cCodigo = ""
2116: 
2117:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
2118:             SELECT cursor_4c_Dados
2119:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.itras)
2120:         ENDIF
2121: 
2122:         IF EMPTY(loc_cCodigo)
2123:             MsgAviso("Selecione um registro para visualizar.")
2124:         ELSE
2125:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2126:                 THIS.this_cModoAtual = "VISUALIZAR"
2127:                 THIS.BOParaForm()
2128:                 THIS.HabilitarCampos(.F.)
2129:                 THIS.AjustarBotoesPorModo()
2130:                 THIS.AlternarPagina(2)
2131:             ENDIF
2132:         ENDIF
2133:     ENDPROC
2134: 
2135:     *===========================================================================
2136:     * BtnAlterarClick - Abre Page2 para alterar registro selecionado
2137:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
2138:     *===========================================================================
2139:     PROCEDURE BtnAlterarClick()
2140:         LOCAL loc_cCodigo
2141:         loc_cCodigo = ""
2142: 
2143:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
2144:             SELECT cursor_4c_Dados
2145:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.itras)
2146:         ENDIF
2147: 
2148:         IF EMPTY(loc_cCodigo)
2149:             MsgAviso("Selecione um registro para alterar.")
2150:         ELSE
2151:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2152:                 THIS.this_oBusinessObject.EditarRegistro()
2153:                 THIS.this_cModoAtual = "ALTERAR"
2154:                 THIS.BOParaForm()
2155:                 THIS.HabilitarCampos(.T.)
2156:                 THIS.AjustarBotoesPorModo()
2157:                 THIS.AlternarPagina(2)
2158:             ENDIF
2159:         ENDIF
2160:     ENDPROC

*-- Linhas 2167 a 2189:
2167:     *===========================================================================
2168:     PROCEDURE BtnExcluirClick()
2169:         LOCAL loc_cCodigo
2170:         loc_cCodigo = ""
2171: 
2172:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
2173:             SELECT cursor_4c_Dados
2174:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.itras)
2175:         ENDIF
2176: 
2177:         IF EMPTY(loc_cCodigo)
2178:             MsgAviso("Selecione um registro para excluir.")
2179:         ELSE
2180:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2181:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da transportadora [" + loc_cCodigo + "]?", ;
2182:                     "Confirmar Exclus" + CHR(227) + "o")
2183:                     IF THIS.this_oBusinessObject.Excluir()
2184:                         MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
2185:                         THIS.CarregarLista()
2186:                     ENDIF
2187:                 ENDIF
2188:             ENDIF
2189:         ENDIF

*-- Linhas 2209 a 2239:
2209:                 loc_oBusca.Show()
2210: 
2211:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTra")
2212:                     SELECT cursor_4c_BuscaTra
2213:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaTra.itras)
2214:                 ENDIF
2215: 
2216:                 loc_oBusca.Release()
2217:             ENDIF
2218: 
2219:             IF USED("cursor_4c_BuscaTra")
2220:                 USE IN cursor_4c_BuscaTra
2221:             ENDIF
2222: 
2223:             IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
2224:                 SELECT cursor_4c_Dados
2225:                 LOCATE FOR ALLTRIM(itras) == loc_cCodigo
2226:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
2227:             ENDIF
2228: 
2229:         CATCH TO loException
2230:             MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "Formtra.BtnBuscarClick")
2231:             IF USED("cursor_4c_BuscaTra")
2232:                 USE IN cursor_4c_BuscaTra
2233:             ENDIF
2234:         ENDTRY
2235:     ENDPROC
2236: 
2237:     *===========================================================================
2238:     * BtnEncerrarClick - Fecha o formulario
2239:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)

*-- Linhas 2324 a 2342:
2324:         loc_oPg.txt_4c_Senha2.Value                 = ""
2325: 
2326:         IF USED("cursor_4c_Estados")
2327:             SELECT cursor_4c_Estados
2328:             ZAP
2329:         ENDIF
2330:         loc_oPg.grd_4c_Estados.Refresh()
2331:     ENDPROC
2332: 
2333:     *===========================================================================
2334:     * AjustarBotoesPorModo - Ajusta estado dos botoes da Page2 conforme modo
2335:     * INCLUIR/ALTERAR: Confirmar habilitado | VISUALIZAR: Confirmar desabilitado
2336:     * PUBLIC: harness TesteAutomatico.prg chama direto de fora da classe (regra #3)
2337:     *===========================================================================
2338:     PROCEDURE AjustarBotoesPorModo()
2339:         LOCAL loc_oPagina, loc_lEditando
2340:         loc_oPagina   = THIS.pgf_4c_Paginas.Page2
2341:         loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2342: 

*-- Linhas 2382 a 2403:
2382:     PROCEDURE Destroy()
2383:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2384:             THIS.this_oBusinessObject = .NULL.
2385:         ENDIF
2386: 
2387:         IF USED("cursor_4c_Dados")
2388:             USE IN cursor_4c_Dados
2389:         ENDIF
2390: 
2391:         IF USED("cursor_4c_Estados")
2392:             USE IN cursor_4c_Estados
2393:         ENDIF
2394: 
2395:         IF USED("cursor_4c_EstadosTemp")
2396:             USE IN cursor_4c_EstadosTemp
2397:         ENDIF
2398: 
2399:         IF USED("cursor_4c_BuscaUf")
2400:             USE IN cursor_4c_BuscaUf
2401:         ENDIF
2402: 
2403:         IF USED("cursor_4c_BuscaMunicipio")


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
    * Retorna cursor_4c_Dados com itras, razaos, cidas, estas, cgcs
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (itras C(10), razaos C(40), cidas C(30), estas C(2), cgcs C(20))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT itras, razaos, cidas, estas, cgcs FROM SigPrTrp"

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

