# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, EMPS, NOPERS, CONTAS, NMARCA1S, DATAS, EMICHQS, 0, NEMITIDOS, NCANCELAS, NCHQFS, LNCONTA1, BANCOS, AGENCIAS, NUMEROS, CIDCHAVES, NCHEQUES, ICLIS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMITIDOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, EMPS, NOPERS, CONTAS, NMARCA1S, DATAS, EMICHQS, 0, NEMITIDOS, NCANCELAS, NCHQFS, LNCONTA1, BANCOS, AGENCIAS, NUMEROS, CIDCHAVES, NCHEQUES, ICLIS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, EMPS, NOPERS, CONTAS, NMARCA1S, DATAS, EMICHQS, 0, NEMITIDOS, NCANCELAS, NCHQFS, LNCONTA1, BANCOS, AGENCIAS, NUMEROS, CIDCHAVES, NCHEQUES, ICLIS

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
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  Column7.ControlSource = ""
  Column8.ControlSource = ""
  Column9.ControlSource = ""
  Column10.ControlSource = ""
  SelectOnEntry = .T.
lStrQuery = [Select emps,dopes,numes,empos,grupos,contas,tipos,nopers,opers,acertos,cotacaos,valos,moedas,hists,vencs,datas ]+;
			[From SigCdPit ]+;
lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpPrIt')
Select TmpPrIt
	If Seek(m.contas,'CrContas','iclis')
			lStrQuery = [Select emps,nopers,grupos,contas,valors,valpags From SigMvCcr ]+;
			lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpMccr')
			Select TmpMccr
				Select TmpMccr
			lStrQuery = [Select emps,nopers,moefpgs,fpags,vpags From SigMvPar ]+;
			lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpPar')
			Select TmpPar
	Insert Into TmpConta From MemVar
	UpDate CsSigCqChi Set nMarca1s = 0 Where nMarca1s = 1
	Select CsSigCqChi
	Select CsSigCqChi
	lcQuery = [Select a.emps, a.dopes, a.numes, a.datas, a.bancos, a.agencias, a.ncontas, a.ncheques, a.contas, ] + ;
				[From SigCqChi a ] + ;
				 	 [a.Contas in (Select Distinct ContaDs From SigOpFp Where EmiChqs = 1) ] + ;
	lcQuery = [Select emps, dopes, numes, datas, bancos, agencias, ncontas, ncheques, contas, ] + ;
				[From SigCqChi ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpChi') < 1)
Select Emps, Dopes, Numes, Datas, Bancos, Agencias, NContas, NCheques, Contas, Valors, Favos, NCopias, ;
  From TmpChi ;
Select CsSigCqChi
	If Not Seek(lcBusca)
		.clnImprime.ControlSource   = 'CsSigCqChi.nMarca1s'
		.clnDatas.ControlSource     = 'CsSigCqChi.datas'
		.clnContas.ControlSource    = 'CsSigCqChi.contas'
		.clnNCopias.ControlSource   = 'CsSigCqChi.ncopias'
		.clnBancos.ControlSource    = 'CsSigCqChi.bancos'
		.clnAgencias.ControlSource  = 'CsSigCqChi.agencias'
		.clnNContas.ControlSource   = 'CsSigCqChi.ncontas'
		.clnNCheques.ControlSource  = 'CsSigCqChi.ncheques'
		.clnValors.ControlSource    = 'CsSigCqChi.valors'
		.clnSituacaos.ControlSource = [IIf(CsSigCqChi.ncancelas = 1,'Cancelado',IIf(CsSigCqChi.nemissoes > 1,'Reemitido',;
	.cntjustificativa.get_justificativa.ControlSource='CsSigCqChi.JustCanc'
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select * From SigCdmp ],'CrSigCdmp')
Select CrSigCdmp
lStrQuery = [Select Distinct b.IClis,b.RClis ]+;
			  [From SigOpFp a, SigCdCli b ]+;
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CrContas') < 1
lcQuery = [Select a.emps, a.dopes, a.numes, a.datas, a.bancos, a.agencias, a.ncontas, a.ncheques, a.contas, ] + ;
			[From SigCqChi a where 0=1 ]
If ThisForm.poDataMgr.SqlExecute(lcQuery,'CsSigCqChi') < 1
SELECT csSigCqChi
Select CrContas
	UpDate CsSigCqChi Set nMarca1s = Iif(nMarca1s = 1,0,1) ;
If Seek(1,'CsSigCqChi','nMarca1s')
	Select Distinct Impres as cNomeImp1s, Space(100) as cNomeImp2s, 0 as nMarca1s ;
	  From crSigCdmp ;
	Select CrImp1
				Select CrImp1
	Select Distinct cNomeImp1s, cNomeImp2s ;
	  From crImp1 ;
	Select CrImp2
	Select CrImp2
			=Seek(lcNomeImp1,'CrSigCdmp','impres')
			Select * From CsSigCqChi Where nMarca1s = 1 Into Cursor TmpChImp
			Select TmpChImp
				lStrQuery = [Select valos,vencs From SigMvPar ]+;
				lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpPar')
				Select TmpPar
					Select CsSigCqChi
					lStrQuery = [Update SigCqChi Set emitidos = 1 Where cidchaves = ']+CsSigCqChi.cidchaves+[' ]
					lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery)
				loBarra1.Update(.T.)
Select CsSigCqChi
Select Distinct Bancos ;
  From csSigCqChi ;
Select TmpChi
	Select bancos,valors,ncheques,datas,nemitidos,ncancelas,favos From CsSigCqChi ;
	Select CrCheque
		Select CrCheque
			lStrQuery = [Update SigCqChi Set emitidos = 1 ]+;
			lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery)
			Update CsSigCqChi Set nemitidos = 1 Where bancos = CrCheque.bancos And ncheques = CrCheque.ncheques
			Select CrCheque
	Select CsSigCqChi
		lStrQuery = [Delete From SigCqChi Where cidchaves = ']+CsSigCqChi.cidchaves+[' ]
		lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery,'')
		Select CsSigCqChi
		Delete
UpDate CsSigCqChi Set nMarca1s = 0 Where nMarca1s = 1
UpDate CsSigCqChi Set nMarca1s = 1 Where nMarca1s = 0 And nEmitidos = 0 And nCancelas = 0
Select bancos,valors,ncheques,datas,favos,nemitidos From CsSigCqChi ;
Select CrCheque
	Select CrCheque
		lStrQuery = [Update SigCqChi Set emitidos = 1 ]+;
		lnQueryOk = ThisForm.poDataMgr.SqlExecute(lStrQuery)
		Select CrCheque
Select CsSigCqChi

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrChr.prg) - TRECHOS RELEVANTES PARA PASS SQL (2645 linhas total):

*-- Linhas 406 a 424:
406:             .FontSize           = 8
407:             .AllowHeaderSizing  = .F.
408:             .AllowRowSizing     = .F.
409:             .DeleteMark         = .F.
410:             .RecordMark         = .F.
411:             .ScrollBars         = 2
412:             .GridLineColor      = RGB(238,238,238)
413:             .ReadOnly           = .F.
414: 
415:             *-- Coluna 1: Data (clnDatas) - ColumnOrder=10 = aparece por ultimo no tab
416:             WITH .Column1
417:                 .FontName       = "Tahoma"
418:                 .ColumnOrder    = 10
419:                 .Width          = 79
420:                 .Movable        = .F.
421:                 .Resizable      = .F.
422:                 .ReadOnly       = .T.
423:                 .Format         = "K"
424:                 .AddObject("Header1", "Header")

*-- Linhas 733 a 751:
733:             .Left           = 99
734:             .MaxLength      = 40
735:             .ReadOnly       = .T.
736:             .SelectOnEntry  = .T.
737:             .SpecialEffect  = 1
738:             .Top            = 530
739:             .Width          = 286
740:             .Themes         = .F.
741:             .Value          = ""
742:         ENDWITH
743:     ENDPROC
744: 
745:     *==========================================================================
746:     * ConfigurarPaginaLista - Alias de compatibilidade com pipeline multi-fase
747:     * OPERACIONAL: sem PageFrame; delega para ConfigurarGrade (mapeamento no cabecalho)
748:     *==========================================================================
749:     PROTECTED PROCEDURE ConfigurarPaginaLista
750:         THIS.ConfigurarGrade()
751:     ENDPROC

*-- Linhas 1465 a 1483:
1465:             RETURN
1466:         ENDIF
1467: 
1468:         SELECT (loc_cCursorCheques)
1469:         loc_lCancelado = (NCancelas <> 0)
1470: 
1471:         *-- Atualizar campo Favorecido
1472:         IF VARTYPE(THIS.txt_4c_Favorecido) = "O"
1473:             THIS.txt_4c_Favorecido.Value = ALLTRIM(NVL(Favos, ""))
1474:         ENDIF
1475: 
1476:         IF VARTYPE(THIS.cmg_4c_Acoes) = "O"
1477:             WITH THIS.cmg_4c_Acoes
1478:                 .Buttons(1).Enabled = !loc_lCancelado                                       && Documento
1479:                 .Buttons(6).Enabled = (!loc_lCancelado AND THIS.this_lExcluirDocumento)     && Exclui Docto
1480:                 .Buttons(3).Enabled = !loc_lCancelado                                       && Imprimir
1481:                 .Buttons(5).Enabled = !loc_lCancelado                                       && Recibo
1482:                 .Buttons(9).Enabled = (loc_lCancelado AND THIS.this_lExcluirCheque)         && Excluir Chq
1483:             ENDWITH

*-- Linhas 1556 a 1588:
1556:             RETURN .F.
1557:         ENDIF
1558: 
1559:         SELECT (loc_cCursor)
1560:         loc_cEmpdopnums = ALLTRIM(Emps) + ALLTRIM(Dopes) + STR(NNumes, 6)
1561: 
1562:         loc_cSQL = "SELECT * FROM SigCdPgr WHERE RTRIM(Emps)+RTRIM(Dopes)+STR(Numes,6) = " + ;
1563:                    EscaparSQL(loc_cEmpdopnums)
1564: 
1565:         IF USED("cursor_4c_Pgr")
1566:             USE IN cursor_4c_Pgr
1567:         ENDIF
1568: 
1569:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pgr") < 1
1570:             RETURN .F.
1571:         ENDIF
1572: 
1573:         SELECT cursor_4c_Pgr
1574:         GO TOP
1575: 
1576:         RETURN !EOF("cursor_4c_Pgr")
1577:     ENDPROC
1578: 
1579:     *==========================================================================
1580:     * ConfigurarBINDEVENTs - Vincula eventos dos controles aos handlers do form
1581:     *==========================================================================
1582:     PROTECTED PROCEDURE ConfigurarBINDEVENTs
1583:         *-- Grid: AfterRowColChange para atualizar painel ao navegar
1584:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
1585:             BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
1586:         ENDIF
1587: 
1588:         *-- Checkbox de selecao (Column10/Check1): KeyPress para toggle via teclado

*-- Linhas 1722 a 1743:
1722:         IF INLIST(par_nKeyCode, 13, 32)
1723:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1724:             IF USED(loc_cCursor) AND !EOF(loc_cCursor)
1725:                 SELECT (loc_cCursor)
1726:                 loc_nRecno = RECNO()
1727:                 loc_cChave = ALLTRIM(Bancos) + ALLTRIM(Agencias) + ALLTRIM(Ncontas) + ALLTRIM(Ncheques)
1728:                 UPDATE (loc_cCursor) SET NMarca1s = IIF(NMarca1s = 1, 0, 1) ;
1729:                     WHERE ALLTRIM(Bancos) + ALLTRIM(Agencias) + ALLTRIM(Ncontas) + ALLTRIM(Ncheques) = m.loc_cChave ;
1730:                     AND NEmitidos = 0 AND NCancelas = 0
1731:                 IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1732:                     GOTO loc_nRecno IN (loc_cCursor)
1733:                 ENDIF
1734:                 THIS.grd_4c_Dados.Refresh()
1735:             ENDIF
1736:             NODEFAULT
1737:         ENDIF
1738:     ENDPROC
1739: 
1740:     *-- Grid Checkbox MouseDown: delegar para KeyPress com SPACE
1741:     PROCEDURE GrdChkMouseDown(par_nButton, par_nShift, par_nX, par_nY)
1742:         THIS.GrdChkKeyPress(32, 0)
1743:         NODEFAULT

*-- Linhas 1767 a 1824:
1767:         LOCAL loc_cCursor, loc_nRecno
1768:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1769:         IF USED(loc_cCursor)
1770:             SELECT (loc_cCursor)
1771:             loc_nRecno = RECNO()
1772:             UPDATE (loc_cCursor) SET NMarca1s = 1 WHERE NMarca1s = 0 AND NEmitidos = 0 AND NCancelas = 0
1773:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1774:                 GOTO loc_nRecno IN (loc_cCursor)
1775:             ENDIF
1776:             THIS.grd_4c_Dados.Refresh()
1777:         ENDIF
1778:     ENDPROC
1779: 
1780:     *-- Botao Apaga: desmarca todos os cheques selecionados
1781:     PROCEDURE BtnApagaClick()
1782:         LOCAL loc_cCursor, loc_nRecno
1783:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1784:         IF USED(loc_cCursor)
1785:             SELECT (loc_cCursor)
1786:             loc_nRecno = RECNO()
1787:             UPDATE (loc_cCursor) SET NMarca1s = 0 WHERE NMarca1s = 1
1788:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1789:                 GOTO loc_nRecno IN (loc_cCursor)
1790:             ENDIF
1791:             THIS.grd_4c_Dados.Refresh()
1792:         ENDIF
1793:     ENDPROC
1794: 
1795:     *-- Botao Encerrar
1796:     PROCEDURE BtnEncerrarClick()
1797:         THIS.Release()
1798:     ENDPROC
1799: 
1800:     *-- Botao Documento: abre SigCdPgr para o cheque corrente
1801:     PROCEDURE BtnDocumentoClick()
1802:         LOCAL loc_lCarregou, loc_nRecno, loc_cCursor
1803:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1804: 
1805:         THIS.LockScreen = .T.
1806:         loc_nRecno = RECNO(loc_cCursor)
1807: 
1808:         IF !EOF(loc_cCursor) AND THIS.CarregarConta()
1809:             SELECT (loc_cCursor)
1810:             DO FORM SigCdPgr WITH ;
1811:                 LEFT(ALLTRIM(Dopes), 1), .T., ;
1812:                 ALLTRIM(Emps), ALLTRIM(Dopes), NNumes
1813:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1814:                 GOTO loc_nRecno IN (loc_cCursor)
1815:             ENDIF
1816:             THIS.ExibirCheques(.F.)
1817:         ENDIF
1818: 
1819:         THIS.LockScreen = .F.
1820:     ENDPROC
1821: 
1822:     *-- Botao Imprimir: abre FormSigReEch para visualizar/imprimir o cheque corrente
1823:     PROCEDURE BtnImprimirClick()
1824:         LOCAL loc_lCarregou, loc_cCursor

*-- Linhas 1830 a 1848:
1830:         ENDIF
1831: 
1832:         IF THIS.CarregarConta()
1833:             SELECT (loc_cCursor)
1834:             DO FORM FormSigReEch WITH ;
1835:                 ALLTRIM(Emps), ALLTRIM(Dopes), NNumes, "CONSULTAR", ALLTRIM(NCheques)
1836:             THIS.ExibirCheques(.F.)
1837:         ENDIF
1838:     ENDPROC
1839: 
1840:     *-- Botao Recibo: abre SigRerec para o cheque corrente
1841:     PROCEDURE BtnReciboClick()
1842:         LOCAL loc_lCarregou
1843:         IF THIS.CarregarConta()
1844:             DO FORM SigRerec WITH THIS, "RECIBO"
1845:         ENDIF
1846:     ENDPROC
1847: 
1848:     *-- Botao Excluir Documento

*-- Linhas 1854 a 1872:
1854:         loc_nRecno = RECNO(loc_cCursor)
1855: 
1856:         IF !EOF(loc_cCursor) AND THIS.CarregarConta()
1857:             SELECT (loc_cCursor)
1858:             DO FORM SigCdPgr WITH ;
1859:                 LEFT(ALLTRIM(Dopes), 1), .F., ;
1860:                 ALLTRIM(Emps), ALLTRIM(Dopes), NNumes
1861:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1862:                 GOTO loc_nRecno IN (loc_cCursor)
1863:             ENDIF
1864:             THIS.ExibirCheques(.F.)
1865:         ENDIF
1866: 
1867:         THIS.LockScreen = .F.
1868:     ENDPROC
1869: 
1870:     *-- Botao Cheque: imprime fisicamente cheques marcados em impressora de cheque
1871:     PROCEDURE BtnImpchqClick()
1872:         LOCAL loc_cCursor, loc_oErro, loc_cBancos

*-- Linhas 1882 a 1927:
1882:                 USE IN cursor_4c_TmpBanco
1883:             ENDIF
1884: 
1885:             SELECT DISTINCT Bancos FROM (loc_cCursor) WHERE NMarca1s = 1 ;
1886:               INTO CURSOR cursor_4c_TmpBanco
1887: 
1888:             SELECT cursor_4c_TmpBanco
1889:             GO TOP
1890:             IF EOF("cursor_4c_TmpBanco")
1891:                 MsgAviso("Nenhum cheque selecionado para impress" + CHR(227) + "o.", "Cheque")
1892:                 USE IN cursor_4c_TmpBanco
1893:                 RETURN
1894:             ENDIF
1895: 
1896:             IF RECCOUNT("cursor_4c_TmpBanco") > 1
1897:                 MsgAviso("Todos os cheques selecionados devem ser do mesmo banco.", ;
1898:                     "Aten" + CHR(231) + CHR(227) + "o")
1899:                 USE IN cursor_4c_TmpBanco
1900:                 RETURN
1901:             ENDIF
1902: 
1903:             loc_cBancos = ALLTRIM(cursor_4c_TmpBanco.Bancos)
1904:             USE IN cursor_4c_TmpBanco
1905: 
1906:             IF USED("cursor_4c_ImpTemp")
1907:                 USE IN cursor_4c_ImpTemp
1908:             ENDIF
1909: 
1910:             SELECT Bancos, Agencias, NContas, NCheques, cIdChaves, ;
1911:                    Valors, Datas, NEmitidos, NCancelas, Favos ;
1912:               FROM (loc_cCursor) ;
1913:              WHERE NMarca1s = 1 ;
1914:              ORDER BY Bancos, NCheques ;
1915:               INTO CURSOR cursor_4c_ImpTemp READWRITE
1916: 
1917:             THIS.this_oBusinessObject.ImprimirCheques(loc_cBancos)
1918: 
1919:             IF USED("cursor_4c_ImpTemp")
1920:                 USE IN cursor_4c_ImpTemp
1921:             ENDIF
1922: 
1923:             THIS.ExibirCheques(.F.)
1924: 
1925:         CATCH TO loc_oErro
1926:             MsgErro(loc_oErro.Message, "Erro ao imprimir cheque")
1927:         ENDTRY

*-- Linhas 1951 a 1980:
1951:             RETURN
1952:         ENDIF
1953: 
1954:         SELECT (loc_cCursor)
1955:         IF NCancelas = 1 AND THIS.this_lExcluirCheque
1956:             IF MsgConfirma("Deseja realmente excluir o cheque :" + CHR(13) + ;
1957:                            ALLTRIM(Bancos) + " / " + ALLTRIM(Agencias) + ;
1958:                            " / " + ALLTRIM(Ncontas) + " / " + ALLTRIM(Ncheques) + " ?")
1959:                 TRY
1960:                     loc_cSQL = "DELETE FROM SigCqChi WHERE cidchaves = " + EscaparSQL(ALLTRIM(Cidchaves))
1961:                     IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
1962:                         loc_cMensa = "Exclus" + CHR(227) + "o do cheque cancelado : " + ;
1963:                                      ALLTRIM(Bancos) + "/" + ALLTRIM(Agencias) + ;
1964:                                      "/" + ALLTRIM(Ncontas) + "/" + ALLTRIM(Ncheques)
1965:                         THIS.this_oBusinessObject.RegistrarAuditoria("DELETE")
1966:                     ELSE
1967:                         MsgErro("Falha ao excluir cheque.", "Erro")
1968:                     ENDIF
1969:                 CATCH TO loc_oErro
1970:                     MsgErro(loc_oErro.Message, "Erro")
1971:                 ENDTRY
1972:                 THIS.ExibirCheques(.F.)
1973:             ENDIF
1974:         ENDIF
1975:     ENDPROC
1976: 
1977:     *-- Botao Procurar: activa container de busca de cheque
1978:     PROCEDURE BtnProcurarClick()
1979:         THIS.this_lPlInicio = .T.
1980:         WITH THIS.cnt_4c_Procurar

*-- Linhas 2013 a 2031:
2013: 
2014:         IF !EOF(loc_cCursor) AND THIS.CarregarConta()
2015:             TRY
2016:                 SELECT (loc_cCursor)
2017:                 THIS.Enabled = .F.
2018:                 DO FORM SigCdPgr WITH ;
2019:                     LEFT(ALLTRIM(Dopes), 1), .F., ;
2020:                     ALLTRIM(Emps), ALLTRIM(Dopes), NNumes
2021:                 IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
2022:                     GOTO loc_nRecno IN (loc_cCursor)
2023:                 ENDIF
2024:                 THIS.ExibirCheques(.F.)
2025:                 THIS.Enabled = .T.
2026:                 THIS.cnt_4c_Justificativa.Visible = .F.
2027:             CATCH TO loc_oErro
2028:                 THIS.Enabled = .T.
2029:                 MsgErro(loc_oErro.Message, "Erro")
2030:             ENDTRY
2031:         ENDIF

*-- Linhas 2072 a 2101:
2072:         ENDIF
2073: 
2074:         TRY
2075:             loc_cSQL = "SELECT bancos, valors, ncheques, datas, emitidos, cancelas, favos " + ;
2076:                        "FROM SigCqChi " + ;
2077:                        "WHERE bancos = " + EscaparSQL(loc_cBanco) + ;
2078:                        " AND ncheques BETWEEN " + EscaparSQL(loc_cChIni) + ;
2079:                        " AND " + EscaparSQL(loc_cChFin) + ;
2080:                        " ORDER BY ncheques"
2081: 
2082:             IF USED("cursor_4c_MatrizTemp")
2083:                 USE IN cursor_4c_MatrizTemp
2084:             ENDIF
2085: 
2086:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MatrizTemp") > 0
2087:                 THIS.this_oBusinessObject.ImprimirChequesMatricial()
2088:                 USE IN cursor_4c_MatrizTemp
2089:             ELSE
2090:                 MsgAviso("Nenhum cheque encontrado na faixa informada.", "Impress" + CHR(227) + "o")
2091:             ENDIF
2092: 
2093:         CATCH TO loc_oErro
2094:             MsgErro(loc_oErro.Message, "Erro ao imprimir matricial")
2095:         ENDTRY
2096:     ENDPROC
2097: 
2098:     *-- Botao Encerrar Matricial: fecha container impchmat e reactiva acoes
2099:     PROCEDURE BtnCancChmatClick()
2100:         THIS.LockScreen = .T.
2101:         THIS.cmg_4c_Acoes.Enabled    = .T.

*-- Linhas 2115 a 2133:
2115: 
2116:         loc_oCnt.txt_4c_BancoP.Value = PADR(ALLTRIM(loc_oCnt.txt_4c_BancoP.Value), 3)
2117: 
2118:         SELECT (loc_cCursor)
2119:         DO CASE
2120:             CASE !EMPTY(loc_oCnt.txt_4c_EmissaoP.Value)
2121:                 SET ORDER TO Emissao
2122:                 SEEK DTOS(loc_oCnt.txt_4c_EmissaoP.Value) + ;
2123:                      ALLTRIM(loc_oCnt.txt_4c_BancoP.Value) + ;
2124:                      ALLTRIM(loc_oCnt.txt_4c_AgenciaP.Value) + ;
2125:                      ALLTRIM(loc_oCnt.txt_4c_ContaP.Value) + ;
2126:                      ALLTRIM(loc_oCnt.txt_4c_ChequeP.Value)
2127:             CASE !EMPTY(loc_oCnt.txt_4c_ValorP.Value)
2128:                 SET ORDER TO Valor
2129:                 SEEK STR(loc_oCnt.txt_4c_ValorP.Value, 12, 2) + ;
2130:                      ALLTRIM(loc_oCnt.txt_4c_BancoP.Value) + ;
2131:                      ALLTRIM(loc_oCnt.txt_4c_AgenciaP.Value) + ;
2132:                      ALLTRIM(loc_oCnt.txt_4c_ContaP.Value) + ;
2133:                      ALLTRIM(loc_oCnt.txt_4c_ChequeP.Value)

*-- Linhas 2281 a 2305:
2281:         loc_cVal = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
2282: 
2283:         IF !EMPTY(loc_cVal)
2284:             loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE RTRIM(codigos) = " + ;
2285:                        EscaparSQL(loc_cVal)
2286:             IF USED("cursor_4c_GrupoOk")
2287:                 USE IN cursor_4c_GrupoOk
2288:             ENDIF
2289:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoOk") > 0
2290:                 SELECT cursor_4c_GrupoOk
2291:                 GO TOP
2292:                 IF !EOF("cursor_4c_GrupoOk")
2293:                     THIS.txt_4c_CdGrupos.Value = ALLTRIM(cursor_4c_GrupoOk.codigos)
2294:                     THIS.txt_4c_DsGrupos.Value = ALLTRIM(cursor_4c_GrupoOk.descrs)
2295:                     THIS.this_oBusinessObject.this_cCdGrupos = ALLTRIM(cursor_4c_GrupoOk.codigos)
2296:                     USE IN cursor_4c_GrupoOk
2297:                     IF THIS.txt_4c_CdGrupos.Value != THIS.this_cAntCdGrupo
2298:                         ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2299:                         THIS.grd_4c_Dados.Refresh()
2300:                     ENDIF
2301:                     THIS.this_cAntCdGrupo = THIS.txt_4c_CdGrupos.Value
2302:                     RETURN
2303:                 ENDIF
2304:                 USE IN cursor_4c_GrupoOk
2305:             ENDIF

*-- Linhas 2324 a 2342:
2324:             loc_oForm.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2325:             loc_oForm.Show()
2326:             IF loc_oForm.this_lSelecionou AND USED("cursor_4c_GrupoLookup")
2327:                 SELECT cursor_4c_GrupoLookup
2328:                 THIS.txt_4c_CdGrupos.Value = ALLTRIM(codigos)
2329:                 THIS.txt_4c_DsGrupos.Value = ALLTRIM(descrs)
2330:                 THIS.this_oBusinessObject.this_cCdGrupos = ALLTRIM(codigos)
2331:             ENDIF
2332:         ENDIF
2333:         IF THIS.txt_4c_CdGrupos.Value != THIS.this_cAntCdGrupo
2334:             ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2335:             THIS.grd_4c_Dados.Refresh()
2336:         ENDIF
2337:         THIS.this_cAntCdGrupo = THIS.txt_4c_CdGrupos.Value
2338:     ENDPROC
2339: 
2340:     *-- KeyPress na descricao do grupo: F4/Enter/Tab abre lookup por descricao
2341:     PROCEDURE TxtDsGruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2342:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115

*-- Linhas 2354 a 2417:
2354:             loc_oForm.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2355:             loc_oForm.Show()
2356:             IF loc_oForm.this_lSelecionou AND USED("cursor_4c_GrupoLookup")
2357:                 SELECT cursor_4c_GrupoLookup
2358:                 THIS.txt_4c_CdGrupos.Value = ALLTRIM(codigos)
2359:                 THIS.txt_4c_DsGrupos.Value = ALLTRIM(descrs)
2360:                 THIS.this_oBusinessObject.this_cCdGrupos = ALLTRIM(codigos)
2361:             ENDIF
2362:         ENDIF
2363:         IF THIS.txt_4c_CdGrupos.Value != THIS.this_cAntDsGrupo
2364:             ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2365:             THIS.grd_4c_Dados.Refresh()
2366:         ENDIF
2367:         THIS.this_cAntDsGrupo = THIS.txt_4c_CdGrupos.Value
2368:     ENDPROC
2369: 
2370:     *-- KeyPress no codigo da conta: F4/Enter/Tab abre lookup de contas
2371:     PROCEDURE TxtCdContasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2372:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
2373:             RETURN
2374:         ENDIF
2375:         LOCAL loc_cVal, loc_oForm, loc_cSQL
2376:         loc_cVal = ALLTRIM(THIS.txt_4c_CdContas.Value)
2377: 
2378:         IF !EMPTY(loc_cVal)
2379:             IF USED("cursor_4c_Contas") AND SEEK(loc_cVal, "cursor_4c_Contas", "IClis")
2380:                 SELECT cursor_4c_Contas
2381:                 THIS.txt_4c_CdContas.Value = ALLTRIM(IClis)
2382:                 THIS.txt_4c_DsContas.Value = ALLTRIM(RClis)
2383:                 THIS.this_oBusinessObject.this_cCdContas = ALLTRIM(IClis)
2384:                 IF THIS.txt_4c_CdContas.Value != THIS.this_cAntCdConta
2385:                     ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2386:                     THIS.grd_4c_Dados.Refresh()
2387:                 ENDIF
2388:                 THIS.this_cAntCdConta = THIS.txt_4c_CdContas.Value
2389:                 RETURN
2390:             ENDIF
2391:         ELSE
2392:             THIS.txt_4c_DsContas.Value = ""
2393:             THIS.this_oBusinessObject.this_cCdContas = ""
2394:             IF THIS.this_cAntCdConta != ""
2395:                 ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2396:                 THIS.grd_4c_Dados.Refresh()
2397:             ENDIF
2398:             THIS.this_cAntCdConta = ""
2399:             RETURN
2400:         ENDIF
2401: 
2402:         *-- Nao encontrado: abrir picker usando SQLEXEC LIKE no cursor_4c_ContasLookup
2403:         THIS.AbrirLookupContas(loc_cVal, "C")
2404:         IF THIS.txt_4c_CdContas.Value != THIS.this_cAntCdConta
2405:             ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2406:             THIS.grd_4c_Dados.Refresh()
2407:         ENDIF
2408:         THIS.this_cAntCdConta = THIS.txt_4c_CdContas.Value
2409:     ENDPROC
2410: 
2411:     *-- KeyPress na descricao da conta: F4/Enter/Tab abre lookup por nome
2412:     PROCEDURE TxtDsContasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2413:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
2414:             RETURN
2415:         ENDIF
2416:         LOCAL loc_cVal
2417:         loc_cVal = ALLTRIM(THIS.txt_4c_DsContas.Value)

*-- Linhas 2435 a 2499:
2435:         IF par_cModo = "C"
2436:             loc_cCampo = "IClis"
2437:             IF EMPTY(par_cVal)
2438:                 loc_cSQL = "SELECT IClis, RClis FROM SigCdCli"
2439:             ELSE
2440:                 loc_cSQL = "SELECT IClis, RClis FROM SigCdCli " + ;
2441:                            "WHERE RTRIM(IClis) LIKE " + EscaparSQL(ALLTRIM(par_cVal) + "%")
2442:             ENDIF
2443:         ELSE
2444:             loc_cCampo = "RClis"
2445:             IF EMPTY(par_cVal)
2446:                 loc_cSQL = "SELECT IClis, RClis FROM SigCdCli"
2447:             ELSE
2448:                 loc_cSQL = "SELECT IClis, RClis FROM SigCdCli " + ;
2449:                            "WHERE RTRIM(RClis) LIKE " + EscaparSQL(ALLTRIM(par_cVal) + "%")
2450:             ENDIF
2451:         ENDIF
2452: 
2453:         IF !EMPTY(loc_cGrupo)
2454:             IF EMPTY(par_cVal)
2455:                 loc_cSQL = loc_cSQL + " WHERE RTRIM(Grupos) = " + EscaparSQL(loc_cGrupo)
2456:             ELSE
2457:                 loc_cSQL = loc_cSQL + " AND RTRIM(Grupos) = " + EscaparSQL(loc_cGrupo)
2458:             ENDIF
2459:         ENDIF
2460: 
2461:         loc_cSQL = loc_cSQL + " ORDER BY IClis"
2462: 
2463:         IF USED("cursor_4c_ContasLookup")
2464:             USE IN cursor_4c_ContasLookup
2465:         ENDIF
2466: 
2467:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContasLookup") < 1
2468:             RETURN
2469:         ENDIF
2470: 
2471:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2472:                     "", "cursor_4c_ContasLookup", ;
2473:                     loc_cCampo, ALLTRIM(par_cVal), ;
2474:                     "Contas", .T., .T., "")
2475:         IF VARTYPE(loc_oForm) != "O"
2476:             RETURN
2477:         ENDIF
2478: 
2479:         loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
2480:         loc_oForm.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
2481:         loc_oForm.Show()
2482: 
2483:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_ContasLookup")
2484:             SELECT cursor_4c_ContasLookup
2485:             THIS.txt_4c_CdContas.Value = ALLTRIM(IClis)
2486:             THIS.txt_4c_DsContas.Value = ALLTRIM(RClis)
2487:             THIS.this_oBusinessObject.this_cCdContas = ALLTRIM(IClis)
2488:         ENDIF
2489: 
2490:         IF THIS.txt_4c_CdContas.Value != THIS.this_cAntCdConta
2491:             ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2492:             THIS.grd_4c_Dados.Refresh()
2493:         ENDIF
2494:         THIS.this_cAntCdConta = THIS.txt_4c_CdContas.Value
2495:     ENDPROC
2496: 
2497:     *-- LostFocus do txt_4c_Chfin: padroniza para 6 digitos com zeros a esquerda
2498:     PROCEDURE TxtChfinLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2499:         IF !EMPTY(THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value)

