# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (7)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, EMPS, NOPERS, CONTAS, NMARCA1S, DATAS, EMICHQS, 0, NEMITIDOS, NCANCELAS, NCHQFS, LNCONTA1, BANCOS, AGENCIAS, NUMEROS, CIDCHAVES, NCHEQUES, ICLIS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMITIDOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, EMPS, NOPERS, CONTAS, NMARCA1S, DATAS, EMICHQS, 0, NEMITIDOS, NCANCELAS, NCHQFS, LNCONTA1, BANCOS, AGENCIAS, NUMEROS, CIDCHAVES, NCHEQUES, ICLIS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, EMPS, NOPERS, CONTAS, NMARCA1S, DATAS, EMICHQS, 0, NEMITIDOS, NCANCELAS, NCHQFS, LNCONTA1, BANCOS, AGENCIAS, NUMEROS, CIDCHAVES, NCHEQUES, ICLIS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '1' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, EMPS, NOPERS, CONTAS, NMARCA1S, DATAS, EMICHQS, 0, NEMITIDOS, NCANCELAS, NCHQFS, LNCONTA1, BANCOS, AGENCIAS, NUMEROS, CIDCHAVES, NCHEQUES, ICLIS
- [TRANSACAO-AVULSA] Linha 3634: SQLEXEC com 'COMMIT' mas NAO existe BEGIN TRANSACTION no codigo. A conexao ODBC usa AUTOCOMMIT - cada SQLEXEC ja eh transacao implicita. CORRIGIR: Remover SQLEXEC com COMMIT e ROLLBACK. Para operacoes simples (1 UPDATE), nao precisa de transacao explicita. Usar transacoes SOMENTE para operacoes multi-statement (2+ UPDATE/INSERT atomicos).
- [TRANSACAO-AVULSA] Linha 3641: SQLEXEC com 'ROLLBACK' mas NAO existe BEGIN TRANSACTION no codigo. A conexao ODBC usa AUTOCOMMIT - cada SQLEXEC ja eh transacao implicita. CORRIGIR: Remover SQLEXEC com COMMIT e ROLLBACK. Para operacoes simples (1 UPDATE), nao precisa de transacao explicita. Usar transacoes SOMENTE para operacoes multi-statement (2+ UPDATE/INSERT atomicos).
- [TRANSACAO-AVULSA] Linha 3645: SQLEXEC com 'ROLLBACK' mas NAO existe BEGIN TRANSACTION no codigo. A conexao ODBC usa AUTOCOMMIT - cada SQLEXEC ja eh transacao implicita. CORRIGIR: Remover SQLEXEC com COMMIT e ROLLBACK. Para operacoes simples (1 UPDATE), nao precisa de transacao explicita. Usar transacoes SOMENTE para operacoes multi-statement (2+ UPDATE/INSERT atomicos).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrChr.prg) - TRECHOS RELEVANTES PARA PASS SQL (2644 linhas total):

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

*-- Linhas 1721 a 1742:
1721:         IF INLIST(par_nKeyCode, 13, 32)
1722:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1723:             IF USED(loc_cCursor) AND !EOF(loc_cCursor)
1724:                 SELECT (loc_cCursor)
1725:                 loc_nRecno = RECNO()
1726:                 loc_cChave = ALLTRIM(Bancos) + ALLTRIM(Agencias) + ALLTRIM(Ncontas) + ALLTRIM(Ncheques)
1727:                 UPDATE (loc_cCursor) SET NMarca1s = IIF(NMarca1s = 1, 0, 1) ;
1728:                     WHERE ALLTRIM(Bancos) + ALLTRIM(Agencias) + ALLTRIM(Ncontas) + ALLTRIM(Ncheques) = m.loc_cChave ;
1729:                     AND NEmitidos = 0 AND NCancelas = 0
1730:                 IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1731:                     GOTO loc_nRecno IN (loc_cCursor)
1732:                 ENDIF
1733:                 THIS.grd_4c_Dados.Refresh()
1734:             ENDIF
1735:             NODEFAULT
1736:         ENDIF
1737:     ENDPROC
1738: 
1739:     *-- Grid Checkbox MouseDown: delegar para KeyPress com SPACE
1740:     PROCEDURE GrdChkMouseDown(par_nButton, par_nShift, par_nX, par_nY)
1741:         THIS.GrdChkKeyPress(32, 0)
1742:         NODEFAULT

*-- Linhas 1766 a 1823:
1766:         LOCAL loc_cCursor, loc_nRecno
1767:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1768:         IF USED(loc_cCursor)
1769:             SELECT (loc_cCursor)
1770:             loc_nRecno = RECNO()
1771:             UPDATE (loc_cCursor) SET NMarca1s = 1 WHERE NMarca1s = 0 AND NEmitidos = 0 AND NCancelas = 0
1772:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1773:                 GOTO loc_nRecno IN (loc_cCursor)
1774:             ENDIF
1775:             THIS.grd_4c_Dados.Refresh()
1776:         ENDIF
1777:     ENDPROC
1778: 
1779:     *-- Botao Apaga: desmarca todos os cheques selecionados
1780:     PROCEDURE BtnApagaClick()
1781:         LOCAL loc_cCursor, loc_nRecno
1782:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1783:         IF USED(loc_cCursor)
1784:             SELECT (loc_cCursor)
1785:             loc_nRecno = RECNO()
1786:             UPDATE (loc_cCursor) SET NMarca1s = 0 WHERE NMarca1s = 1
1787:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1788:                 GOTO loc_nRecno IN (loc_cCursor)
1789:             ENDIF
1790:             THIS.grd_4c_Dados.Refresh()
1791:         ENDIF
1792:     ENDPROC
1793: 
1794:     *-- Botao Encerrar
1795:     PROCEDURE BtnEncerrarClick()
1796:         THIS.Release()
1797:     ENDPROC
1798: 
1799:     *-- Botao Documento: abre SigCdPgr para o cheque corrente
1800:     PROCEDURE BtnDocumentoClick()
1801:         LOCAL loc_lCarregou, loc_nRecno, loc_cCursor
1802:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1803: 
1804:         THIS.LockScreen = .T.
1805:         loc_nRecno = RECNO(loc_cCursor)
1806: 
1807:         IF !EOF(loc_cCursor) AND THIS.CarregarConta()
1808:             SELECT (loc_cCursor)
1809:             DO FORM SigCdPgr WITH ;
1810:                 LEFT(ALLTRIM(Dopes), 1), .T., ;
1811:                 ALLTRIM(Emps), ALLTRIM(Dopes), NNumes
1812:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1813:                 GOTO loc_nRecno IN (loc_cCursor)
1814:             ENDIF
1815:             THIS.ExibirCheques(.F.)
1816:         ENDIF
1817: 
1818:         THIS.LockScreen = .F.
1819:     ENDPROC
1820: 
1821:     *-- Botao Imprimir: abre FormSigReEch para visualizar/imprimir o cheque corrente
1822:     PROCEDURE BtnImprimirClick()
1823:         LOCAL loc_lCarregou, loc_cCursor

*-- Linhas 1829 a 1847:
1829:         ENDIF
1830: 
1831:         IF THIS.CarregarConta()
1832:             SELECT (loc_cCursor)
1833:             DO FORM FormSigReEch WITH ;
1834:                 ALLTRIM(Emps), ALLTRIM(Dopes), NNumes, "CONSULTAR", ALLTRIM(NCheques)
1835:             THIS.ExibirCheques(.F.)
1836:         ENDIF
1837:     ENDPROC
1838: 
1839:     *-- Botao Recibo: abre SigRerec para o cheque corrente
1840:     PROCEDURE BtnReciboClick()
1841:         LOCAL loc_lCarregou
1842:         IF THIS.CarregarConta()
1843:             DO FORM SigRerec WITH THIS, "RECIBO"
1844:         ENDIF
1845:     ENDPROC
1846: 
1847:     *-- Botao Excluir Documento

*-- Linhas 1853 a 1871:
1853:         loc_nRecno = RECNO(loc_cCursor)
1854: 
1855:         IF !EOF(loc_cCursor) AND THIS.CarregarConta()
1856:             SELECT (loc_cCursor)
1857:             DO FORM SigCdPgr WITH ;
1858:                 LEFT(ALLTRIM(Dopes), 1), .F., ;
1859:                 ALLTRIM(Emps), ALLTRIM(Dopes), NNumes
1860:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1861:                 GOTO loc_nRecno IN (loc_cCursor)
1862:             ENDIF
1863:             THIS.ExibirCheques(.F.)
1864:         ENDIF
1865: 
1866:         THIS.LockScreen = .F.
1867:     ENDPROC
1868: 
1869:     *-- Botao Cheque: imprime fisicamente cheques marcados em impressora de cheque
1870:     PROCEDURE BtnImpchqClick()
1871:         LOCAL loc_cCursor, loc_oErro, loc_cBancos

*-- Linhas 1881 a 1926:
1881:                 USE IN cursor_4c_TmpBanco
1882:             ENDIF
1883: 
1884:             SELECT DISTINCT Bancos FROM (loc_cCursor) WHERE NMarca1s = 1 ;
1885:               INTO CURSOR cursor_4c_TmpBanco
1886: 
1887:             SELECT cursor_4c_TmpBanco
1888:             GO TOP
1889:             IF EOF("cursor_4c_TmpBanco")
1890:                 MsgAviso("Nenhum cheque selecionado para impress" + CHR(227) + "o.", "Cheque")
1891:                 USE IN cursor_4c_TmpBanco
1892:                 RETURN
1893:             ENDIF
1894: 
1895:             IF RECCOUNT("cursor_4c_TmpBanco") > 1
1896:                 MsgAviso("Todos os cheques selecionados devem ser do mesmo banco.", ;
1897:                     "Aten" + CHR(231) + CHR(227) + "o")
1898:                 USE IN cursor_4c_TmpBanco
1899:                 RETURN
1900:             ENDIF
1901: 
1902:             loc_cBancos = ALLTRIM(cursor_4c_TmpBanco.Bancos)
1903:             USE IN cursor_4c_TmpBanco
1904: 
1905:             IF USED("cursor_4c_ImpTemp")
1906:                 USE IN cursor_4c_ImpTemp
1907:             ENDIF
1908: 
1909:             SELECT Bancos, Agencias, NContas, NCheques, cIdChaves, ;
1910:                    Valors, Datas, NEmitidos, NCancelas, Favos ;
1911:               FROM (loc_cCursor) ;
1912:              WHERE NMarca1s = 1 ;
1913:              ORDER BY Bancos, NCheques ;
1914:               INTO CURSOR cursor_4c_ImpTemp READWRITE
1915: 
1916:             THIS.this_oBusinessObject.ImprimirCheques(loc_cBancos)
1917: 
1918:             IF USED("cursor_4c_ImpTemp")
1919:                 USE IN cursor_4c_ImpTemp
1920:             ENDIF
1921: 
1922:             THIS.ExibirCheques(.F.)
1923: 
1924:         CATCH TO loc_oErro
1925:             MsgErro(loc_oErro.Message, "Erro ao imprimir cheque")
1926:         ENDTRY

*-- Linhas 1950 a 1987:
1950:             RETURN
1951:         ENDIF
1952: 
1953:         SELECT (loc_cCursor)
1954:         IF NCancelas = 1 AND THIS.this_lExcluirCheque
1955:             IF MsgConfirma("Deseja realmente excluir o cheque :" + CHR(13) + ;
1956:                            ALLTRIM(Bancos) + " / " + ALLTRIM(Agencias) + ;
1957:                            " / " + ALLTRIM(Ncontas) + " / " + ALLTRIM(Ncheques) + " ?")
1958:                 TRY
1959:                     loc_cSQL = "DELETE FROM SigCqChi WHERE cidchaves = " + EscaparSQL(ALLTRIM(Cidchaves))
1960:                     IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
1961:                         IF SQLEXEC(gnConnHandle, "COMMIT") > 0
1962:                             loc_cMensa = "Exclus" + CHR(227) + "o do cheque cancelado : " + ;
1963:                                          ALLTRIM(Bancos) + "/" + ALLTRIM(Agencias) + ;
1964:                                          "/" + ALLTRIM(Ncontas) + "/" + ALLTRIM(Ncheques)
1965:                             THIS.this_oBusinessObject.RegistrarAuditoria("DELETE")
1966:                         ENDIF
1967:                     ELSE
1968:                         SQLEXEC(gnConnHandle, "ROLLBACK")
1969:                         MsgErro("Falha ao excluir cheque.", "Erro")
1970:                     ENDIF
1971:                 CATCH TO loc_oErro
1972:                     SQLEXEC(gnConnHandle, "ROLLBACK")
1973:                     MsgErro(loc_oErro.Message, "Erro")
1974:                 ENDTRY
1975:                 THIS.ExibirCheques(.F.)
1976:             ENDIF
1977:         ENDIF
1978:     ENDPROC
1979: 
1980:     *-- Botao Procurar: activa container de busca de cheque
1981:     PROCEDURE BtnProcurarClick()
1982:         THIS.this_lPlInicio = .T.
1983:         WITH THIS.cnt_4c_Procurar
1984:             .Visible = .T.
1985:             .Enabled = .T.
1986:             .txt_4c_BancoP.SetFocus()
1987:         ENDWITH

*-- Linhas 2016 a 2034:
2016: 
2017:         IF !EOF(loc_cCursor) AND THIS.CarregarConta()
2018:             TRY
2019:                 SELECT (loc_cCursor)
2020:                 THIS.Enabled = .F.
2021:                 DO FORM SigCdPgr WITH ;
2022:                     LEFT(ALLTRIM(Dopes), 1), .F., ;
2023:                     ALLTRIM(Emps), ALLTRIM(Dopes), NNumes
2024:                 IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
2025:                     GOTO loc_nRecno IN (loc_cCursor)
2026:                 ENDIF
2027:                 THIS.ExibirCheques(.F.)
2028:                 THIS.Enabled = .T.
2029:                 THIS.cnt_4c_Justificativa.Visible = .F.
2030:             CATCH TO loc_oErro
2031:                 THIS.Enabled = .T.
2032:                 MsgErro(loc_oErro.Message, "Erro")
2033:             ENDTRY
2034:         ENDIF

*-- Linhas 2075 a 2104:
2075:         ENDIF
2076: 
2077:         TRY
2078:             loc_cSQL = "SELECT bancos, valors, ncheques, datas, emitidos, cancelas, favos " + ;
2079:                        "FROM SigCqChi " + ;
2080:                        "WHERE bancos = " + EscaparSQL(loc_cBanco) + ;
2081:                        " AND ncheques BETWEEN " + EscaparSQL(loc_cChIni) + ;
2082:                        " AND " + EscaparSQL(loc_cChFin) + ;
2083:                        " ORDER BY ncheques"
2084: 
2085:             IF USED("cursor_4c_MatrizTemp")
2086:                 USE IN cursor_4c_MatrizTemp
2087:             ENDIF
2088: 
2089:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MatrizTemp") > 0
2090:                 THIS.this_oBusinessObject.ImprimirChequesMatricial()
2091:                 USE IN cursor_4c_MatrizTemp
2092:             ELSE
2093:                 MsgAviso("Nenhum cheque encontrado na faixa informada.", "Impress" + CHR(227) + "o")
2094:             ENDIF
2095: 
2096:         CATCH TO loc_oErro
2097:             MsgErro(loc_oErro.Message, "Erro ao imprimir matricial")
2098:         ENDTRY
2099:     ENDPROC
2100: 
2101:     *-- Botao Encerrar Matricial: fecha container impchmat e reactiva acoes
2102:     PROCEDURE BtnCancChmatClick()
2103:         THIS.LockScreen = .T.
2104:         THIS.cmg_4c_Acoes.Enabled    = .T.

*-- Linhas 2118 a 2136:
2118: 
2119:         loc_oCnt.txt_4c_BancoP.Value = PADR(ALLTRIM(loc_oCnt.txt_4c_BancoP.Value), 3)
2120: 
2121:         SELECT (loc_cCursor)
2122:         DO CASE
2123:             CASE !EMPTY(loc_oCnt.txt_4c_EmissaoP.Value)
2124:                 SET ORDER TO Emissao
2125:                 SEEK DTOS(loc_oCnt.txt_4c_EmissaoP.Value) + ;
2126:                      ALLTRIM(loc_oCnt.txt_4c_BancoP.Value) + ;
2127:                      ALLTRIM(loc_oCnt.txt_4c_AgenciaP.Value) + ;
2128:                      ALLTRIM(loc_oCnt.txt_4c_ContaP.Value) + ;
2129:                      ALLTRIM(loc_oCnt.txt_4c_ChequeP.Value)
2130:             CASE !EMPTY(loc_oCnt.txt_4c_ValorP.Value)
2131:                 SET ORDER TO Valor
2132:                 SEEK STR(loc_oCnt.txt_4c_ValorP.Value, 12, 2) + ;
2133:                      ALLTRIM(loc_oCnt.txt_4c_BancoP.Value) + ;
2134:                      ALLTRIM(loc_oCnt.txt_4c_AgenciaP.Value) + ;
2135:                      ALLTRIM(loc_oCnt.txt_4c_ContaP.Value) + ;
2136:                      ALLTRIM(loc_oCnt.txt_4c_ChequeP.Value)

*-- Linhas 2284 a 2308:
2284:         loc_cVal = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
2285: 
2286:         IF !EMPTY(loc_cVal)
2287:             loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE RTRIM(codigos) = " + ;
2288:                        EscaparSQL(loc_cVal)
2289:             IF USED("cursor_4c_GrupoOk")
2290:                 USE IN cursor_4c_GrupoOk
2291:             ENDIF
2292:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoOk") > 0
2293:                 SELECT cursor_4c_GrupoOk
2294:                 GO TOP
2295:                 IF !EOF("cursor_4c_GrupoOk")
2296:                     THIS.txt_4c_CdGrupos.Value = ALLTRIM(cursor_4c_GrupoOk.codigos)
2297:                     THIS.txt_4c_DsGrupos.Value = ALLTRIM(cursor_4c_GrupoOk.descrs)
2298:                     THIS.this_oBusinessObject.this_cCdGrupos = ALLTRIM(cursor_4c_GrupoOk.codigos)
2299:                     USE IN cursor_4c_GrupoOk
2300:                     IF THIS.txt_4c_CdGrupos.Value != THIS.this_cAntCdGrupo
2301:                         ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2302:                         THIS.grd_4c_Dados.Refresh()
2303:                     ENDIF
2304:                     THIS.this_cAntCdGrupo = THIS.txt_4c_CdGrupos.Value
2305:                     RETURN
2306:                 ENDIF
2307:                 USE IN cursor_4c_GrupoOk
2308:             ENDIF

*-- Linhas 2327 a 2345:
2327:             loc_oForm.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2328:             loc_oForm.Show()
2329:             IF loc_oForm.this_lSelecionou AND USED("cursor_4c_GrupoLookup")
2330:                 SELECT cursor_4c_GrupoLookup
2331:                 THIS.txt_4c_CdGrupos.Value = ALLTRIM(codigos)
2332:                 THIS.txt_4c_DsGrupos.Value = ALLTRIM(descrs)
2333:                 THIS.this_oBusinessObject.this_cCdGrupos = ALLTRIM(codigos)
2334:             ENDIF
2335:         ENDIF
2336:         IF THIS.txt_4c_CdGrupos.Value != THIS.this_cAntCdGrupo
2337:             ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2338:             THIS.grd_4c_Dados.Refresh()
2339:         ENDIF
2340:         THIS.this_cAntCdGrupo = THIS.txt_4c_CdGrupos.Value
2341:     ENDPROC
2342: 
2343:     *-- KeyPress na descricao do grupo: F4/Enter/Tab abre lookup por descricao
2344:     PROCEDURE TxtDsGruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2345:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115

*-- Linhas 2357 a 2420:
2357:             loc_oForm.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2358:             loc_oForm.Show()
2359:             IF loc_oForm.this_lSelecionou AND USED("cursor_4c_GrupoLookup")
2360:                 SELECT cursor_4c_GrupoLookup
2361:                 THIS.txt_4c_CdGrupos.Value = ALLTRIM(codigos)
2362:                 THIS.txt_4c_DsGrupos.Value = ALLTRIM(descrs)
2363:                 THIS.this_oBusinessObject.this_cCdGrupos = ALLTRIM(codigos)
2364:             ENDIF
2365:         ENDIF
2366:         IF THIS.txt_4c_CdGrupos.Value != THIS.this_cAntDsGrupo
2367:             ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2368:             THIS.grd_4c_Dados.Refresh()
2369:         ENDIF
2370:         THIS.this_cAntDsGrupo = THIS.txt_4c_CdGrupos.Value
2371:     ENDPROC
2372: 
2373:     *-- KeyPress no codigo da conta: F4/Enter/Tab abre lookup de contas
2374:     PROCEDURE TxtCdContasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2375:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
2376:             RETURN
2377:         ENDIF
2378:         LOCAL loc_cVal, loc_oForm, loc_cSQL
2379:         loc_cVal = ALLTRIM(THIS.txt_4c_CdContas.Value)
2380: 
2381:         IF !EMPTY(loc_cVal)
2382:             IF USED("cursor_4c_Contas") AND SEEK(loc_cVal, "cursor_4c_Contas", "IClis")
2383:                 SELECT cursor_4c_Contas
2384:                 THIS.txt_4c_CdContas.Value = ALLTRIM(IClis)
2385:                 THIS.txt_4c_DsContas.Value = ALLTRIM(RClis)
2386:                 THIS.this_oBusinessObject.this_cCdContas = ALLTRIM(IClis)
2387:                 IF THIS.txt_4c_CdContas.Value != THIS.this_cAntCdConta
2388:                     ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2389:                     THIS.grd_4c_Dados.Refresh()
2390:                 ENDIF
2391:                 THIS.this_cAntCdConta = THIS.txt_4c_CdContas.Value
2392:                 RETURN
2393:             ENDIF
2394:         ELSE
2395:             THIS.txt_4c_DsContas.Value = ""
2396:             THIS.this_oBusinessObject.this_cCdContas = ""
2397:             IF THIS.this_cAntCdConta != ""
2398:                 ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2399:                 THIS.grd_4c_Dados.Refresh()
2400:             ENDIF
2401:             THIS.this_cAntCdConta = ""
2402:             RETURN
2403:         ENDIF
2404: 
2405:         *-- Nao encontrado: abrir picker usando SQLEXEC LIKE no cursor_4c_ContasLookup
2406:         THIS.AbrirLookupContas(loc_cVal, "C")
2407:         IF THIS.txt_4c_CdContas.Value != THIS.this_cAntCdConta
2408:             ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2409:             THIS.grd_4c_Dados.Refresh()
2410:         ENDIF
2411:         THIS.this_cAntCdConta = THIS.txt_4c_CdContas.Value
2412:     ENDPROC
2413: 
2414:     *-- KeyPress na descricao da conta: F4/Enter/Tab abre lookup por nome
2415:     PROCEDURE TxtDsContasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2416:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
2417:             RETURN
2418:         ENDIF
2419:         LOCAL loc_cVal
2420:         loc_cVal = ALLTRIM(THIS.txt_4c_DsContas.Value)

*-- Linhas 2438 a 2498:
2438:         IF par_cModo = "C"
2439:             loc_cCampo = "IClis"
2440:             IF EMPTY(par_cVal)
2441:                 loc_cSQL = "SELECT IClis, RClis FROM SigCdCli WHERE 1=1"
2442:             ELSE
2443:                 loc_cSQL = "SELECT IClis, RClis FROM SigCdCli " + ;
2444:                            "WHERE RTRIM(IClis) LIKE " + EscaparSQL(ALLTRIM(par_cVal) + "%")
2445:             ENDIF
2446:         ELSE
2447:             loc_cCampo = "RClis"
2448:             IF EMPTY(par_cVal)
2449:                 loc_cSQL = "SELECT IClis, RClis FROM SigCdCli WHERE 1=1"
2450:             ELSE
2451:                 loc_cSQL = "SELECT IClis, RClis FROM SigCdCli " + ;
2452:                            "WHERE RTRIM(RClis) LIKE " + EscaparSQL(ALLTRIM(par_cVal) + "%")
2453:             ENDIF
2454:         ENDIF
2455: 
2456:         IF !EMPTY(loc_cGrupo)
2457:             loc_cSQL = loc_cSQL + " AND RTRIM(Grupos) = " + EscaparSQL(loc_cGrupo)
2458:         ENDIF
2459: 
2460:         loc_cSQL = loc_cSQL + " ORDER BY IClis"
2461: 
2462:         IF USED("cursor_4c_ContasLookup")
2463:             USE IN cursor_4c_ContasLookup
2464:         ENDIF
2465: 
2466:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContasLookup") < 1
2467:             RETURN
2468:         ENDIF
2469: 
2470:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2471:                     "", "cursor_4c_ContasLookup", ;
2472:                     loc_cCampo, ALLTRIM(par_cVal), ;
2473:                     "Contas", .T., .T., "")
2474:         IF VARTYPE(loc_oForm) != "O"
2475:             RETURN
2476:         ENDIF
2477: 
2478:         loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
2479:         loc_oForm.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
2480:         loc_oForm.Show()
2481: 
2482:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_ContasLookup")
2483:             SELECT cursor_4c_ContasLookup
2484:             THIS.txt_4c_CdContas.Value = ALLTRIM(IClis)
2485:             THIS.txt_4c_DsContas.Value = ALLTRIM(RClis)
2486:             THIS.this_oBusinessObject.this_cCdContas = ALLTRIM(IClis)
2487:         ENDIF
2488: 
2489:         IF THIS.txt_4c_CdContas.Value != THIS.this_cAntCdConta
2490:             ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
2491:             THIS.grd_4c_Dados.Refresh()
2492:         ENDIF
2493:         THIS.this_cAntCdConta = THIS.txt_4c_CdContas.Value
2494:     ENDPROC
2495: 
2496:     *-- LostFocus do txt_4c_Chfin: padroniza para 6 digitos com zeros a esquerda
2497:     PROCEDURE TxtChfinLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2498:         IF !EMPTY(THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value)

*-- Linhas 3620 a 2644:

*-- Linhas 3627 a 2644:

*-- Linhas 3631 a 2644:

