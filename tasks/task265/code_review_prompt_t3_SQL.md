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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrChr.prg) - TRECHOS RELEVANTES PARA PASS SQL (2643 linhas total):

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

*-- Linhas 1720 a 1741:
1720:         IF INLIST(par_nKeyCode, 13, 32)
1721:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1722:             IF USED(loc_cCursor) AND !EOF(loc_cCursor)
1723:                 SELECT (loc_cCursor)
1724:                 loc_nRecno = RECNO()
1725:                 loc_cChave = ALLTRIM(Bancos) + ALLTRIM(Agencias) + ALLTRIM(Ncontas) + ALLTRIM(Ncheques)
1726:                 UPDATE (loc_cCursor) SET NMarca1s = IIF(NMarca1s = 1, 0, 1) ;
1727:                     WHERE ALLTRIM(Bancos) + ALLTRIM(Agencias) + ALLTRIM(Ncontas) + ALLTRIM(Ncheques) = m.loc_cChave ;
1728:                     AND NEmitidos = 0 AND NCancelas = 0
1729:                 IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1730:                     GOTO loc_nRecno IN (loc_cCursor)
1731:                 ENDIF
1732:                 THIS.grd_4c_Dados.Refresh()
1733:             ENDIF
1734:             NODEFAULT
1735:         ENDIF
1736:     ENDPROC
1737: 
1738:     *-- Grid Checkbox MouseDown: delegar para KeyPress com SPACE
1739:     PROCEDURE GrdChkMouseDown(par_nButton, par_nShift, par_nX, par_nY)
1740:         THIS.GrdChkKeyPress(32, 0)
1741:         NODEFAULT

*-- Linhas 1765 a 1822:
1765:         LOCAL loc_cCursor, loc_nRecno
1766:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1767:         IF USED(loc_cCursor)
1768:             SELECT (loc_cCursor)
1769:             loc_nRecno = RECNO()
1770:             UPDATE (loc_cCursor) SET NMarca1s = 1 WHERE NMarca1s = 0 AND NEmitidos = 0 AND NCancelas = 0
1771:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1772:                 GOTO loc_nRecno IN (loc_cCursor)
1773:             ENDIF
1774:             THIS.grd_4c_Dados.Refresh()
1775:         ENDIF
1776:     ENDPROC
1777: 
1778:     *-- Botao Apaga: desmarca todos os cheques selecionados
1779:     PROCEDURE BtnApagaClick()
1780:         LOCAL loc_cCursor, loc_nRecno
1781:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1782:         IF USED(loc_cCursor)
1783:             SELECT (loc_cCursor)
1784:             loc_nRecno = RECNO()
1785:             UPDATE (loc_cCursor) SET NMarca1s = 0 WHERE NMarca1s = 1
1786:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1787:                 GOTO loc_nRecno IN (loc_cCursor)
1788:             ENDIF
1789:             THIS.grd_4c_Dados.Refresh()
1790:         ENDIF
1791:     ENDPROC
1792: 
1793:     *-- Botao Encerrar
1794:     PROCEDURE BtnEncerrarClick()
1795:         THIS.Release()
1796:     ENDPROC
1797: 
1798:     *-- Botao Documento: abre SigCdPgr para o cheque corrente
1799:     PROCEDURE BtnDocumentoClick()
1800:         LOCAL loc_lCarregou, loc_nRecno, loc_cCursor
1801:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1802: 
1803:         THIS.LockScreen = .T.
1804:         loc_nRecno = RECNO(loc_cCursor)
1805: 
1806:         IF !EOF(loc_cCursor) AND THIS.CarregarConta()
1807:             SELECT (loc_cCursor)
1808:             DO FORM SigCdPgr WITH ;
1809:                 LEFT(ALLTRIM(Dopes), 1), .T., ;
1810:                 ALLTRIM(Emps), ALLTRIM(Dopes), NNumes
1811:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1812:                 GOTO loc_nRecno IN (loc_cCursor)
1813:             ENDIF
1814:             THIS.ExibirCheques(.F.)
1815:         ENDIF
1816: 
1817:         THIS.LockScreen = .F.
1818:     ENDPROC
1819: 
1820:     *-- Botao Imprimir: abre FormSigReEch para visualizar/imprimir o cheque corrente
1821:     PROCEDURE BtnImprimirClick()
1822:         LOCAL loc_lCarregou, loc_cCursor

*-- Linhas 1828 a 1846:
1828:         ENDIF
1829: 
1830:         IF THIS.CarregarConta()
1831:             SELECT (loc_cCursor)
1832:             DO FORM FormSigReEch WITH ;
1833:                 ALLTRIM(Emps), ALLTRIM(Dopes), NNumes, "CONSULTAR", ALLTRIM(NCheques)
1834:             THIS.ExibirCheques(.F.)
1835:         ENDIF
1836:     ENDPROC
1837: 
1838:     *-- Botao Recibo: abre SigRerec para o cheque corrente
1839:     PROCEDURE BtnReciboClick()
1840:         LOCAL loc_lCarregou
1841:         IF THIS.CarregarConta()
1842:             DO FORM SigRerec WITH THIS, "RECIBO"
1843:         ENDIF
1844:     ENDPROC
1845: 
1846:     *-- Botao Excluir Documento

*-- Linhas 1852 a 1870:
1852:         loc_nRecno = RECNO(loc_cCursor)
1853: 
1854:         IF !EOF(loc_cCursor) AND THIS.CarregarConta()
1855:             SELECT (loc_cCursor)
1856:             DO FORM SigCdPgr WITH ;
1857:                 LEFT(ALLTRIM(Dopes), 1), .F., ;
1858:                 ALLTRIM(Emps), ALLTRIM(Dopes), NNumes
1859:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1860:                 GOTO loc_nRecno IN (loc_cCursor)
1861:             ENDIF
1862:             THIS.ExibirCheques(.F.)
1863:         ENDIF
1864: 
1865:         THIS.LockScreen = .F.
1866:     ENDPROC
1867: 
1868:     *-- Botao Cheque: imprime fisicamente cheques marcados em impressora de cheque
1869:     PROCEDURE BtnImpchqClick()
1870:         LOCAL loc_cCursor, loc_oErro, loc_cBancos

*-- Linhas 1880 a 1925:
1880:                 USE IN cursor_4c_TmpBanco
1881:             ENDIF
1882: 
1883:             SELECT DISTINCT Bancos FROM (loc_cCursor) WHERE NMarca1s = 1 ;
1884:               INTO CURSOR cursor_4c_TmpBanco
1885: 
1886:             SELECT cursor_4c_TmpBanco
1887:             GO TOP
1888:             IF EOF("cursor_4c_TmpBanco")
1889:                 MsgAviso("Nenhum cheque selecionado para impress" + CHR(227) + "o.", "Cheque")
1890:                 USE IN cursor_4c_TmpBanco
1891:                 RETURN
1892:             ENDIF
1893: 
1894:             IF RECCOUNT("cursor_4c_TmpBanco") > 1
1895:                 MsgAviso("Todos os cheques selecionados devem ser do mesmo banco.", ;
1896:                     "Aten" + CHR(231) + CHR(227) + "o")
1897:                 USE IN cursor_4c_TmpBanco
1898:                 RETURN
1899:             ENDIF
1900: 
1901:             loc_cBancos = ALLTRIM(cursor_4c_TmpBanco.Bancos)
1902:             USE IN cursor_4c_TmpBanco
1903: 
1904:             IF USED("cursor_4c_ImpTemp")
1905:                 USE IN cursor_4c_ImpTemp
1906:             ENDIF
1907: 
1908:             SELECT Bancos, Agencias, NContas, NCheques, cIdChaves, ;
1909:                    Valors, Datas, NEmitidos, NCancelas, Favos ;
1910:               FROM (loc_cCursor) ;
1911:              WHERE NMarca1s = 1 ;
1912:              ORDER BY Bancos, NCheques ;
1913:               INTO CURSOR cursor_4c_ImpTemp READWRITE
1914: 
1915:             THIS.this_oBusinessObject.ImprimirCheques(loc_cBancos)
1916: 
1917:             IF USED("cursor_4c_ImpTemp")
1918:                 USE IN cursor_4c_ImpTemp
1919:             ENDIF
1920: 
1921:             THIS.ExibirCheques(.F.)
1922: 
1923:         CATCH TO loc_oErro
1924:             MsgErro(loc_oErro.Message, "Erro ao imprimir cheque")
1925:         ENDTRY

*-- Linhas 1949 a 1978:
1949:             RETURN
1950:         ENDIF
1951: 
1952:         SELECT (loc_cCursor)
1953:         IF NCancelas = 1 AND THIS.this_lExcluirCheque
1954:             IF MsgConfirma("Deseja realmente excluir o cheque :" + CHR(13) + ;
1955:                            ALLTRIM(Bancos) + " / " + ALLTRIM(Agencias) + ;
1956:                            " / " + ALLTRIM(Ncontas) + " / " + ALLTRIM(Ncheques) + " ?")
1957:                 TRY
1958:                     loc_cSQL = "DELETE FROM SigCqChi WHERE cidchaves = " + EscaparSQL(ALLTRIM(Cidchaves))
1959:                     IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
1960:                         loc_cMensa = "Exclus" + CHR(227) + "o do cheque cancelado : " + ;
1961:                                      ALLTRIM(Bancos) + "/" + ALLTRIM(Agencias) + ;
1962:                                      "/" + ALLTRIM(Ncontas) + "/" + ALLTRIM(Ncheques)
1963:                         THIS.this_oBusinessObject.RegistrarAuditoria("DELETE")
1964:                     ELSE
1965:                         MsgErro("Falha ao excluir cheque.", "Erro")
1966:                     ENDIF
1967:                 CATCH TO loc_oErro
1968:                     MsgErro(loc_oErro.Message, "Erro")
1969:                 ENDTRY
1970:                 THIS.ExibirCheques(.F.)
1971:             ENDIF
1972:         ENDIF
1973:     ENDPROC
1974: 
1975:     *-- Botao Procurar: activa container de busca de cheque
1976:     PROCEDURE BtnProcurarClick()
1977:         THIS.this_lPlInicio = .T.
1978:         WITH THIS.cnt_4c_Procurar

*-- Linhas 2011 a 2029:
2011: 
2012:         IF !EOF(loc_cCursor) AND THIS.CarregarConta()
2013:             TRY
2014:                 SELECT (loc_cCursor)
2015:                 THIS.Enabled = .F.
2016:                 DO FORM SigCdPgr WITH ;
2017:                     LEFT(ALLTRIM(Dopes), 1), .F., ;
2018:                     ALLTRIM(Emps), ALLTRIM(Dopes), NNumes
2019:                 IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
2020:                     GOTO loc_nRecno IN (loc_cCursor)
2021:                 ENDIF
2022:                 THIS.ExibirCheques(.F.)
2023:                 THIS.Enabled = .T.
2024:                 THIS.cnt_4c_Justificativa.Visible = .F.
2025:             CATCH TO loc_oErro
2026:                 THIS.Enabled = .T.
2027:                 MsgErro(loc_oErro.Message, "Erro")
2028:             ENDTRY
2029:         ENDIF

*-- Linhas 2070 a 2099:
2070:         ENDIF
2071: 
2072:         TRY
2073:             loc_cSQL = "SELECT bancos, valors, ncheques, datas, emitidos, cancelas, favos " + ;
2074:                        "FROM SigCqChi " + ;
2075:                        "WHERE bancos = " + EscaparSQL(loc_cBanco) + ;
2076:                        " AND ncheques BETWEEN " + EscaparSQL(loc_cChIni) + ;
2077:                        " AND " + EscaparSQL(loc_cChFin) + ;
2078:                        " ORDER BY ncheques"
2079: 
2080:             IF USED("cursor_4c_MatrizTemp")
2081:                 USE IN cursor_4c_MatrizTemp
2082:             ENDIF
2083: 
2084:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MatrizTemp") > 0
2085:                 THIS.this_oBusinessObject.ImprimirChequesMatricial()
2086:                 USE IN cursor_4c_MatrizTemp
2087:             ELSE
2088:                 MsgAviso("Nenhum cheque encontrado na faixa informada.", "Impress" + CHR(227) + "o")
2089:             ENDIF
2090: 
2091:         CATCH TO loc_oErro
2092:             MsgErro(loc_oErro.Message, "Erro ao imprimir matricial")
2093:         ENDTRY
2094:     ENDPROC
2095: 
2096:     *-- Botao Encerrar Matricial: fecha container impchmat e reactiva acoes
2097:     PROCEDURE BtnCancChmatClick()
2098:         THIS.LockScreen = .T.
2099:         THIS.cmg_4c_Acoes.Enabled    = .T.

*-- Linhas 2113 a 2131:
2113: 
2114:         loc_oCnt.txt_4c_BancoP.Value = PADR(ALLTRIM(loc_oCnt.txt_4c_BancoP.Value), 3)
2115: 
2116:         SELECT (loc_cCursor)
2117:         DO CASE
2118:             CASE !EMPTY(loc_oCnt.txt_4c_EmissaoP.Value)
2119:                 SET ORDER TO Emissao
2120:                 SEEK DTOS(loc_oCnt.txt_4c_EmissaoP.Value) + ;
2121:                      ALLTRIM(loc_oCnt.txt_4c_BancoP.Value) + ;
2122:                      ALLTRIM(loc_oCnt.txt_4c_AgenciaP.Value) + ;
2123:                      ALLTRIM(loc_oCnt.txt_4c_ContaP.Value) + ;
2124:                      ALLTRIM(loc_oCnt.txt_4c_ChequeP.Value)
2125:             CASE !EMPTY(loc_oCnt.txt_4c_ValorP.Value)
2126:                 SET ORDER TO Valor
2127:                 SEEK STR(loc_oCnt.txt_4c_ValorP.Value, 12, 2) + ;
2128:                      ALLTRIM(loc_oCnt.txt_4c_BancoP.Value) + ;
2129:                      ALLTRIM(loc_oCnt.txt_4c_AgenciaP.Value) + ;
2130:                      ALLTRIM(loc_oCnt.txt_4c_ContaP.Value) + ;
2131:                      ALLTRIM(loc_oCnt.txt_4c_ChequeP.Value)

*-- Linhas 2279 a 2303:
2279:         loc_cVal = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
2280: 
2281:         IF !EMPTY(loc_cVal)
2282:             loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE RTRIM(codigos) = " + ;
2283:                        EscaparSQL(loc_cVal)
2284:             IF USED("cursor_4c_GrupoOk")
2285:                 USE IN cursor_4c_GrupoOk
2286:             ENDIF
2287:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoOk") > 0
2288:                 SELECT cursor_4c_GrupoOk
2289:                 GO TOP
2290:                 IF !EOF("cursor_4c_GrupoOk")
2291:                     THIS.txt_4c_CdGrupos.Value = ALLTRIM(cursor_4c_GrupoOk.codigos)
2292:                     THIS.txt_4c_DsGrupos.Value = ALLTRIM(cursor_4c_GrupoOk.descrs)
2293:                     THIS.this_oBusinessObject.this_cCdGrupos = ALLTRIM(cursor_4c_GrupoOk.codigos)
2294:                     USE IN cursor_4c_GrupoOk
2295:                     IF THIS.txt_4c_CdGrupos.Value != THIS.this_cAntCdGrupo
2296:                         ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2297:                         THIS.grd_4c_Dados.Refresh()
2298:                     ENDIF
2299:                     THIS.this_cAntCdGrupo = THIS.txt_4c_CdGrupos.Value
2300:                     RETURN
2301:                 ENDIF
2302:                 USE IN cursor_4c_GrupoOk
2303:             ENDIF

*-- Linhas 2322 a 2340:
2322:             loc_oForm.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2323:             loc_oForm.Show()
2324:             IF loc_oForm.this_lSelecionou AND USED("cursor_4c_GrupoLookup")
2325:                 SELECT cursor_4c_GrupoLookup
2326:                 THIS.txt_4c_CdGrupos.Value = ALLTRIM(codigos)
2327:                 THIS.txt_4c_DsGrupos.Value = ALLTRIM(descrs)
2328:                 THIS.this_oBusinessObject.this_cCdGrupos = ALLTRIM(codigos)
2329:             ENDIF
2330:         ENDIF
2331:         IF THIS.txt_4c_CdGrupos.Value != THIS.this_cAntCdGrupo
2332:             ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2333:             THIS.grd_4c_Dados.Refresh()
2334:         ENDIF
2335:         THIS.this_cAntCdGrupo = THIS.txt_4c_CdGrupos.Value
2336:     ENDPROC
2337: 
2338:     *-- KeyPress na descricao do grupo: F4/Enter/Tab abre lookup por descricao
2339:     PROCEDURE TxtDsGruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2340:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115

*-- Linhas 2352 a 2415:
2352:             loc_oForm.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2353:             loc_oForm.Show()
2354:             IF loc_oForm.this_lSelecionou AND USED("cursor_4c_GrupoLookup")
2355:                 SELECT cursor_4c_GrupoLookup
2356:                 THIS.txt_4c_CdGrupos.Value = ALLTRIM(codigos)
2357:                 THIS.txt_4c_DsGrupos.Value = ALLTRIM(descrs)
2358:                 THIS.this_oBusinessObject.this_cCdGrupos = ALLTRIM(codigos)
2359:             ENDIF
2360:         ENDIF
2361:         IF THIS.txt_4c_CdGrupos.Value != THIS.this_cAntDsGrupo
2362:             ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2363:             THIS.grd_4c_Dados.Refresh()
2364:         ENDIF
2365:         THIS.this_cAntDsGrupo = THIS.txt_4c_CdGrupos.Value
2366:     ENDPROC
2367: 
2368:     *-- KeyPress no codigo da conta: F4/Enter/Tab abre lookup de contas
2369:     PROCEDURE TxtCdContasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2370:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
2371:             RETURN
2372:         ENDIF
2373:         LOCAL loc_cVal, loc_oForm, loc_cSQL
2374:         loc_cVal = ALLTRIM(THIS.txt_4c_CdContas.Value)
2375: 
2376:         IF !EMPTY(loc_cVal)
2377:             IF USED("cursor_4c_Contas") AND SEEK(loc_cVal, "cursor_4c_Contas", "IClis")
2378:                 SELECT cursor_4c_Contas
2379:                 THIS.txt_4c_CdContas.Value = ALLTRIM(IClis)
2380:                 THIS.txt_4c_DsContas.Value = ALLTRIM(RClis)
2381:                 THIS.this_oBusinessObject.this_cCdContas = ALLTRIM(IClis)
2382:                 IF THIS.txt_4c_CdContas.Value != THIS.this_cAntCdConta
2383:                     ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2384:                     THIS.grd_4c_Dados.Refresh()
2385:                 ENDIF
2386:                 THIS.this_cAntCdConta = THIS.txt_4c_CdContas.Value
2387:                 RETURN
2388:             ENDIF
2389:         ELSE
2390:             THIS.txt_4c_DsContas.Value = ""
2391:             THIS.this_oBusinessObject.this_cCdContas = ""
2392:             IF THIS.this_cAntCdConta != ""
2393:                 ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2394:                 THIS.grd_4c_Dados.Refresh()
2395:             ENDIF
2396:             THIS.this_cAntCdConta = ""
2397:             RETURN
2398:         ENDIF
2399: 
2400:         *-- Nao encontrado: abrir picker usando SQLEXEC LIKE no cursor_4c_ContasLookup
2401:         THIS.AbrirLookupContas(loc_cVal, "C")
2402:         IF THIS.txt_4c_CdContas.Value != THIS.this_cAntCdConta
2403:             ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2404:             THIS.grd_4c_Dados.Refresh()
2405:         ENDIF
2406:         THIS.this_cAntCdConta = THIS.txt_4c_CdContas.Value
2407:     ENDPROC
2408: 
2409:     *-- KeyPress na descricao da conta: F4/Enter/Tab abre lookup por nome
2410:     PROCEDURE TxtDsContasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2411:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
2412:             RETURN
2413:         ENDIF
2414:         LOCAL loc_cVal
2415:         loc_cVal = ALLTRIM(THIS.txt_4c_DsContas.Value)

*-- Linhas 2433 a 2497:
2433:         IF par_cModo = "C"
2434:             loc_cCampo = "IClis"
2435:             IF EMPTY(par_cVal)
2436:                 loc_cSQL = "SELECT IClis, RClis FROM SigCdCli"
2437:             ELSE
2438:                 loc_cSQL = "SELECT IClis, RClis FROM SigCdCli " + ;
2439:                            "WHERE RTRIM(IClis) LIKE " + EscaparSQL(ALLTRIM(par_cVal) + "%")
2440:             ENDIF
2441:         ELSE
2442:             loc_cCampo = "RClis"
2443:             IF EMPTY(par_cVal)
2444:                 loc_cSQL = "SELECT IClis, RClis FROM SigCdCli"
2445:             ELSE
2446:                 loc_cSQL = "SELECT IClis, RClis FROM SigCdCli " + ;
2447:                            "WHERE RTRIM(RClis) LIKE " + EscaparSQL(ALLTRIM(par_cVal) + "%")
2448:             ENDIF
2449:         ENDIF
2450: 
2451:         IF !EMPTY(loc_cGrupo)
2452:             IF EMPTY(par_cVal)
2453:                 loc_cSQL = loc_cSQL + " WHERE RTRIM(Grupos) = " + EscaparSQL(loc_cGrupo)
2454:             ELSE
2455:                 loc_cSQL = loc_cSQL + " AND RTRIM(Grupos) = " + EscaparSQL(loc_cGrupo)
2456:             ENDIF
2457:         ENDIF
2458: 
2459:         loc_cSQL = loc_cSQL + " ORDER BY IClis"
2460: 
2461:         IF USED("cursor_4c_ContasLookup")
2462:             USE IN cursor_4c_ContasLookup
2463:         ENDIF
2464: 
2465:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContasLookup") < 1
2466:             RETURN
2467:         ENDIF
2468: 
2469:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2470:                     "", "cursor_4c_ContasLookup", ;
2471:                     loc_cCampo, ALLTRIM(par_cVal), ;
2472:                     "Contas", .T., .T., "")
2473:         IF VARTYPE(loc_oForm) != "O"
2474:             RETURN
2475:         ENDIF
2476: 
2477:         loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
2478:         loc_oForm.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
2479:         loc_oForm.Show()
2480: 
2481:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_ContasLookup")
2482:             SELECT cursor_4c_ContasLookup
2483:             THIS.txt_4c_CdContas.Value = ALLTRIM(IClis)
2484:             THIS.txt_4c_DsContas.Value = ALLTRIM(RClis)
2485:             THIS.this_oBusinessObject.this_cCdContas = ALLTRIM(IClis)
2486:         ENDIF
2487: 
2488:         IF THIS.txt_4c_CdContas.Value != THIS.this_cAntCdConta
2489:             ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2490:             THIS.grd_4c_Dados.Refresh()
2491:         ENDIF
2492:         THIS.this_cAntCdConta = THIS.txt_4c_CdContas.Value
2493:     ENDPROC
2494: 
2495:     *-- LostFocus do txt_4c_Chfin: padroniza para 6 digitos com zeros a esquerda
2496:     PROCEDURE TxtChfinLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2497:         IF !EMPTY(THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value)

