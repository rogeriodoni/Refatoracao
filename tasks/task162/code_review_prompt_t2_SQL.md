# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (5)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRUPOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, EMPS, NOPERS, CONTAS, NMARCA1S, DATAS, EMICHQS, 0, NEMITIDOS, NCANCELAS, NCHQFS, LNCONTA1, BANCOS, AGENCIAS, NUMEROS, CIDCHAVES, NCHEQUES, ICLIS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CGRUS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, EMPS, NOPERS, CONTAS, NMARCA1S, DATAS, EMICHQS, 0, NEMITIDOS, NCANCELAS, NCHQFS, LNCONTA1, BANCOS, AGENCIAS, NUMEROS, CIDCHAVES, NCHEQUES, ICLIS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DGRUS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, EMPS, NOPERS, CONTAS, NMARCA1S, DATAS, EMICHQS, 0, NEMITIDOS, NCANCELAS, NCHQFS, LNCONTA1, BANCOS, AGENCIAS, NUMEROS, CIDCHAVES, NCHEQUES, ICLIS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, EMPS, NOPERS, CONTAS, NMARCA1S, DATAS, EMICHQS, 0, NEMITIDOS, NCANCELAS, NCHQFS, LNCONTA1, BANCOS, AGENCIAS, NUMEROS, CIDCHAVES, NCHEQUES, ICLIS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCRS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, EMPS, NOPERS, CONTAS, NMARCA1S, DATAS, EMICHQS, 0, NEMITIDOS, NCANCELAS, NCHQFS, LNCONTA1, BANCOS, AGENCIAS, NUMEROS, CIDCHAVES, NCHEQUES, ICLIS

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrChr.prg) - TRECHOS RELEVANTES PARA PASS SQL (3527 linhas total):

*-- Linhas 416 a 434:
416:             .FontName          = "Tahoma"
417:             .AllowHeaderSizing = .F.
418:             .AllowRowSizing    = .F.
419:             .DeleteMark        = .F.
420:             .ReadOnly          = .F.
421:             .ScrollBars        = 2
422:             .GridLineColor     = RGB(238, 238, 238)
423:             .Visible           = .T.
424: 
425:             *-- Column1 (clnDatas): ColumnOrder=10, aparece como 10a coluna
426:             WITH .Column1
427:                 .ColumnOrder       = 10
428:                 .Width             = 99
429:                 .Movable           = .F.
430:                 .Resizable         = .F.
431:                 .ReadOnly          = .T.
432:                 .FontName          = "Tahoma"
433:                 .Header1.Caption   = "Data"
434:                 .Header1.FontName  = "Tahoma"

*-- Linhas 622 a 652:
622:             ENDWITH
623:         ENDWITH
624: 
625:         *-- RecordSource e ControlSources FORA do WITH (evita auto-bind sobrescrever ControlSources)
626:         THIS.grd_4c_Dados.RecordSource                              = "CsSigCqChi"
627:         THIS.grd_4c_Dados.Column1.ControlSource                    = "CsSigCqChi.datas"
628:         THIS.grd_4c_Dados.Column2.ControlSource                    = "CsSigCqChi.contas"
629:         THIS.grd_4c_Dados.Column3.ControlSource                    = "CsSigCqChi.ncopias"
630:         THIS.grd_4c_Dados.Column4.ControlSource                    = "CsSigCqChi.bancos"
631:         THIS.grd_4c_Dados.Column5.ControlSource                    = "CsSigCqChi.agencias"
632:         THIS.grd_4c_Dados.Column6.ControlSource                    = "CsSigCqChi.ncontas"
633:         THIS.grd_4c_Dados.Column7.ControlSource                    = "CsSigCqChi.ncheques"
634:         THIS.grd_4c_Dados.Column8.ControlSource                    = "IIF(CsSigCqChi.NCancelas=1,'Cancelado',IIF(CsSigCqChi.NEmitidos>0,'Emitido','N'+CHR(227)+'o Emitido'))"
635:         THIS.grd_4c_Dados.Column9.ControlSource                    = "CsSigCqChi.valors"
636:         THIS.grd_4c_Dados.Column10.ControlSource                   = "CsSigCqChi.NMarca1s"
637:         THIS.grd_4c_Dados.Column10.chk_4c_Imprime.ControlSource   = "CsSigCqChi.NMarca1s"
638: 
639:         *-- Botao Marcar Todos (original Top=334, Left=742 -> 928)
640:         THIS.AddObject("cmd_4c_Tudo1", "CommandButton")
641:         WITH THIS.cmd_4c_Tudo1
642:             .Top         = 334
643:             .Left        = 928
644:             .Height      = 40
645:             .Width       = 40
646:             .FontName    = "Verdana"
647:             .FontSize    = 8
648:             .Caption     = ""
649:             .TabStop     = .F.
650:             .ToolTipText = "Marca tudo"
651:             .ForeColor   = RGB(36, 84, 155)
652:             .BackColor   = RGB(255, 255, 255)

*-- Linhas 1663 a 1691:
1663: 
1664:         TRY
1665:             IF USED("CsSigCqChi")
1666:                 UPDATE CsSigCqChi SET nMarca1s = 0 WHERE nMarca1s = 1
1667:             ENDIF
1668: 
1669:             IF EMPTY(ALLTRIM(THIS.txt_4c_CdContas.Value))
1670:                 SELECT CsSigCqChi
1671:                 SET ORDER TO NCopias
1672:                 IF loc_lSeek
1673:                     SEEK CHR(255) IN CsSigCqChi ORDER NCopias ASCENDING
1674:                 ENDIF
1675:             ELSE
1676:                 SELECT CsSigCqChi
1677:                 SET ORDER TO Contas
1678:                 SET KEY TO ALLTRIM(THIS.txt_4c_CdContas.Value)
1679:                 IF loc_lSeek
1680:                     SEEK ALLTRIM(THIS.txt_4c_CdContas.Value) + CHR(255) IN CsSigCqChi ORDER Contas ASCENDING
1681:                 ENDIF
1682:             ENDIF
1683: 
1684:             THIS.obj_4c_CmdGok.Buttons(4).Enabled = .T.
1685:             THIS.obj_4c_CmdGok.Refresh
1686:             THIS.grd_4c_Dados.Refresh
1687: 
1688:             IF USED("CsSigCqChi") AND !EOF("CsSigCqChi")
1689:                 THIS.txt_4c_TxtFavorecido.Value = ALLTRIM(CsSigCqChi.favos)
1690:             ENDIF
1691:             THIS.txt_4c_TxtFavorecido.Refresh

*-- Linhas 1703 a 1721:
1703:     *  par_lPosiciona = .T.: reposiciona no cheque atual apos recarregar.
1704:     *--------------------------------------------------------------------------
1705:         LOCAL loc_lResultado, loc_lPosiciona, loc_cBusca
1706:         LOCAL loc_cCdGrupo, loc_cCdConta, loc_cQuery, loc_nQueryOk
1707:         PRIVATE pDtInicial, pDtFinal
1708: 
1709:         loc_lResultado = .F.
1710: 
1711:         TRY
1712:             loc_lPosiciona = (TYPE("par_lPosiciona") = "L" AND par_lPosiciona)
1713: 
1714:             IF loc_lPosiciona AND USED("CsSigCqChi") AND !EOF("CsSigCqChi")
1715:                 loc_cBusca = CsSigCqChi.bancos + CsSigCqChi.agencias + ;
1716:                              CsSigCqChi.ncontas  + CsSigCqChi.ncheques
1717:             ELSE
1718:                 loc_cBusca = ""
1719:             ENDIF
1720: 
1721:             pDtInicial   = THIS.txt_4c_Dt_inicial.Value

*-- Linhas 1732 a 1794:
1732:             ENDIF
1733: 
1734:             IF EMPTY(loc_cCdConta)
1735:                 loc_cQuery = "SELECT a.emps, a.dopes, a.numes, a.datas, a.bancos, a.agencias," + ;
1736:                              " a.ncontas, a.ncheques, a.contas," + ;
1737:                              " a.valors, a.favos, a.ncopias, a.emitidos, a.nemissoes, a.cancelas," + ;
1738:                              " a.cidchaves, a.JustCanc, 0 as NEmitidos, 0 as NCancelas, 0 as NMarca1s" + ;
1739:                              " FROM SigCqChi a" + ;
1740:                              " WHERE a.datas BETWEEN ?pDtInicial AND ?pDtFinal"
1741:                 loc_cQuery = loc_cQuery + ;
1742:                              " AND a.Contas IN (SELECT DISTINCT ContaDs FROM SigOpFp WHERE EmiChqs = 1)" + ;
1743:                              " ORDER BY a.emps, a.dopes, a.numes, a.datas, a.bancos, a.agencias," + ;
1744:                              " a.ncontas, a.ncheques, a.contas, a.valors, a.favos," + ;
1745:                              " a.ncopias, a.emitidos, a.nemissoes, a.cancelas, a.cidchaves"
1746:             ELSE
1747:                 loc_cQuery = "SELECT emps, dopes, numes, datas, bancos, agencias," + ;
1748:                              " ncontas, ncheques, contas," + ;
1749:                              " valors, favos, ncopias, emitidos, nemissoes, cancelas, cidchaves, JustCanc," + ;
1750:                              " 0 as NEmitidos, 0 as NCancelas, 0 as NMarca1s" + ;
1751:                              " FROM SigCqChi" + ;
1752:                              " WHERE datas BETWEEN ?pDtInicial AND ?pDtFinal"
1753:                 loc_cQuery = loc_cQuery + ;
1754:                              " AND Contas = " + EscaparSQL(loc_cCdConta) + ;
1755:                              " ORDER BY emps, dopes, numes, datas, bancos, agencias," + ;
1756:                              " ncontas, ncheques, contas, valors, favos," + ;
1757:                              " ncopias, emitidos, nemissoes, cancelas, cidchaves"
1758:             ENDIF
1759: 
1760:             IF USED("cursor_4c_TmpChi")
1761:                 USE IN cursor_4c_TmpChi
1762:             ENDIF
1763:             loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_TmpChi")
1764:             IF loc_nQueryOk < 1
1765:                 WAIT CLEAR
1766:                 MsgErro("Falha ao carregar cheques.", "Erro de Conex" + CHR(227) + "o")
1767:                 THIS.LockScreen = .F.
1768:                 loc_lResultado = .F.
1769:             ENDIF
1770: 
1771:             SELECT emps, dopes, numes, datas, bancos, agencias, ncontas, ncheques, contas, ;
1772:                    valors, favos, ncopias, NEmitidos, cidchaves, NCancelas, NMarca1s, JustCanc ;
1773:               FROM cursor_4c_TmpChi ;
1774:              ORDER BY bancos, agencias, ncontas, ncheques ;
1775:               INTO CURSOR CsSigCqChi READWRITE
1776: 
1777:             USE IN cursor_4c_TmpChi
1778: 
1779:             SELECT CsSigCqChi
1780:             INDEX ON ncopias                                                   TAG NCopias
1781:             INDEX ON NEmitidos                                                 TAG NEmitidos
1782:             INDEX ON NCancelas                                                 TAG NCancelas
1783:             INDEX ON NMarca1s                                                  TAG NMarca1s
1784:             INDEX ON ncheques                                                  TAG NCheques
1785:             INDEX ON datas                                                     TAG Datas
1786:             INDEX ON ncontas + ncheques                                        TAG Conta
1787:             INDEX ON contas + STR(ncopias)                                     TAG Contas
1788:             INDEX ON DTOS(datas) + bancos + agencias + ncontas + ncheques      TAG Emissao
1789:             INDEX ON STR(valors,12,2) + bancos + agencias + ncontas + ncheques TAG Valor
1790:             INDEX ON bancos + agencias + ncontas + ncheques                    TAG Cheque
1791:             INDEX ON agencias + ncontas + ncheques                             TAG Agencia
1792: 
1793:             SET ORDER TO NCopias
1794:             IF loc_lPosiciona AND !EMPTY(loc_cBusca)

*-- Linhas 1804 a 1843:
1804: 
1805:             THIS.grd_4c_Dados.RecordSource = "CsSigCqChi"
1806:             WITH THIS.grd_4c_Dados
1807:                 .Column10.ControlSource                 = "CsSigCqChi.NMarca1s"
1808:                 .Column10.chk_4c_Imprime.ControlSource = "CsSigCqChi.NMarca1s"
1809:                 .Column1.ControlSource                  = "CsSigCqChi.datas"
1810:                 .Column2.ControlSource                  = "CsSigCqChi.contas"
1811:                 .Column3.ControlSource                  = "CsSigCqChi.ncopias"
1812:                 .Column4.ControlSource                  = "CsSigCqChi.bancos"
1813:                 .Column5.ControlSource                  = "CsSigCqChi.agencias"
1814:                 .Column6.ControlSource                  = "CsSigCqChi.ncontas"
1815:                 .Column7.ControlSource                  = "CsSigCqChi.ncheques"
1816:                 .Column9.ControlSource                  = "CsSigCqChi.valors"
1817:                 .Column8.ControlSource = "IIF(CsSigCqChi.NCancelas=1,'Cancelado'," + ;
1818:                     "IIF(CsSigCqChi.NEmitidos=1," + ;
1819:                     "IIF(CsSigCqChi.ncopias>1,'Reemitido','Emitido')," + ;
1820:                     "'N" + CHR(227) + "o Emitido'))"
1821:                 .SetAll("DynamicForeColor", ;
1822:                     "IIF(CsSigCqChi.NCancelas=1,RGB(255,0,0)," + ;
1823:                     "IIF(CsSigCqChi.NEmitidos=0,RGB(0,0,255),RGB(0,0,0)))", ;
1824:                     "Column")
1825:                 .Refresh
1826:             ENDWITH
1827: 
1828:             THIS.cnt_4c_Justificativa.obj_4c_Get_justificativa.ControlSource = "CsSigCqChi.JustCanc"
1829: 
1830:             IF loc_lPosiciona
1831:                 THIS.MExibeCheques(.F.)
1832:             ELSE
1833:                 THIS.MExibeCheques(.T.)
1834:             ENDIF
1835: 
1836:             loc_lResultado = .T.
1837: 
1838:         CATCH TO loc_oErro
1839:             WAIT CLEAR
1840:             THIS.LockScreen = .F.
1841:             MsgErro(loc_oErro.Message, "Erro em MontaChq")
1842:         ENDTRY
1843: 

*-- Linhas 1864 a 1972:
1864:                 USE IN TmpPrIt
1865:             ENDIF
1866: 
1867:             loc_cSQL = "SELECT emps, dopes, numes, empos, grupos, contas, tipos, nopers, opers," + ;
1868:                        " acertos, cotacaos, valos, moedas, hists, vencs, datas" + ;
1869:                        " FROM SigCdPit" + ;
1870:                        " WHERE empdopnums = " + EscaparSQL(loc_cChave) + ;
1871:                        " ORDER BY emps, dopes, numes, grupos, contas, nopers"
1872: 
1873:             loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "TmpPrIt")
1874:             IF loc_nQueryOk < 1
1875:                 MsgErro("Falha ao carregar pagamentos.", "Erro")
1876:                 loc_lResultado = .F.
1877:             ENDIF
1878: 
1879:             IF USED("TmpConta")
1880:                 USE IN TmpConta
1881:             ENDIF
1882: 
1883:             SET NULL ON
1884:             CREATE CURSOR TmpConta (grupos C(10) NULL, contas C(10) NULL, flag L NULL, ;
1885:                 valos N(12,2) NULL, acerto N(12,2) NULL, moedas C(3) NULL, ;
1886:                 datas D NULL, vencs D NULL, hists C(50) NULL, nomes C(50) NULL, ;
1887:                 emps C(3) NULL, nopers N(9,0) NULL, dopes C(20) NULL, numes N(6,0) NULL, ;
1888:                 tipos C(1) NULL, fpags C(12) NULL, opers C(1) NULL, baixa N(12,2) NULL, ;
1889:                 baixaaut N(12,2) NULL, cotacaos N(12,4) NULL, grupocs C(10) NULL, ;
1890:                 contacs C(10) NULL, cotorigs N(12,4) NULL, moedacs C(3) NULL, ;
1891:                 cotacaocs N(12,4) NULL, valocs N(12,2) NULL, empos C(3) NULL, ;
1892:                 OrdCopChs N(3,0) NULL)
1893:             SET NULL OFF
1894: 
1895:             SELECT TmpPrIt
1896:             GO TOP
1897: 
1898:             SCAN
1899:                 SCATTER MEMVAR
1900:                 m.flag  = .F.
1901:                 m.nomes = ""
1902: 
1903:                 IF USED("CrContas") AND SEEK(m.contas, "CrContas", "IClis")
1904:                     m.nomes = ALLTRIM(CrContas.RClis)
1905:                 ENDIF
1906: 
1907:                 DO CASE
1908:                 CASE TmpPrIt.tipos = "M"
1909:                     IF m.acertos <> 0
1910:                         m.flag = .T.
1911:                     ENDIF
1912: 
1913:                 CASE TmpPrIt.tipos = "C"
1914:                     m.flag = .T.
1915:                     IF USED("TmpMccr")
1916:                         USE IN TmpMccr
1917:                     ENDIF
1918:                     loc_cSQL = "SELECT emps, nopers, grupos, contas, valors, valpags" + ;
1919:                                " FROM SigMvCcr" + ;
1920:                                " WHERE emps = " + EscaparSQL(m.empos) + ;
1921:                                " AND nopers = " + FormatarNumeroSQL(m.nopers)
1922:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpMccr") >= 1
1923:                         SELECT TmpMccr
1924:                         GO TOP
1925:                         IF m.grupos <> TmpMccr.grupos OR m.contas <> TmpMccr.contas
1926:                             SKIP
1927:                         ENDIF
1928:                         IF !EOF("TmpMccr")
1929:                             m.valos = TmpMccr.valors - TmpMccr.valpags + m.acertos
1930:                         ENDIF
1931:                     ENDIF
1932: 
1933:                 CASE TmpPrIt.tipos = "P"
1934:                     m.flag = .T.
1935:                     IF USED("TmpPar")
1936:                         USE IN TmpPar
1937:                     ENDIF
1938:                     loc_cSQL = "SELECT emps, nopers, moefpgs, fpags, vpags" + ;
1939:                                " FROM SigMvPar" + ;
1940:                                " WHERE emps = " + EscaparSQL(m.empos) + ;
1941:                                " AND nopers = " + FormatarNumeroSQL(m.nopers)
1942:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpPar") >= 1
1943:                         SELECT TmpPar
1944:                         GO TOP
1945:                         IF !EOF("TmpPar")
1946:                             m.valos  = m.valos - TmpPar.vpags + m.acertos
1947:                             m.moedas = ALLTRIM(TmpPar.moefpgs)
1948:                             m.hists  = ALLTRIM(TmpPar.fpags) + " " + m.emps + ;
1949:                                        ALLTRIM(m.dopes) + " " + ALLTRIM(TRANSFORM(m.numes))
1950:                         ENDIF
1951:                     ENDIF
1952:                 ENDCASE
1953: 
1954:                 m.acerto = m.acertos
1955:                 SELECT TmpConta
1956:                 INSERT INTO TmpConta FROM MEMVAR
1957:                 SELECT TmpPrIt
1958:             ENDSCAN
1959: 
1960:             IF USED("TmpPrIt")
1961:                 USE IN TmpPrIt
1962:             ENDIF
1963: 
1964:             loc_lResultado = .T.
1965: 
1966:         CATCH TO loc_oErro
1967:             MsgErro(loc_oErro.Message, "Erro em CarregaConta")
1968:         ENDTRY
1969: 
1970:         RETURN loc_lResultado
1971:     ENDPROC
1972: 

*-- Linhas 2049 a 2067:
2049:                 loc_nRecno = RECNO("CsSigCqChi")
2050:                 loc_cChave = CsSigCqChi.bancos + CsSigCqChi.agencias + ;
2051:                              CsSigCqChi.ncontas + CsSigCqChi.ncheques
2052:                 UPDATE CsSigCqChi SET NMarca1s = IIF(NMarca1s = 1, 0, 1) ;
2053:                   WHERE bancos + agencias + ncontas + ncheques = loc_cChave ;
2054:                     AND NEmitidos = 0 AND NCancelas = 0
2055:                 THIS.grd_4c_Dados.Refresh
2056:                 IF BETWEEN(loc_nRecno, 1, RECCOUNT("CsSigCqChi"))
2057:                     GOTO loc_nRecno IN CsSigCqChi
2058:                 ENDIF
2059:             ENDIF
2060:         ENDIF
2061:     ENDPROC
2062: 
2063:     *-- Grid: CheckBox Imprime - MouseUp (simula KeyPress com SPACE)
2064:     PROCEDURE ChkImprimeMouseUp(par_nButton, par_nShift, par_nX, par_nY)
2065:         THIS.ChkImprimeKeyPress(32, 0)
2066:     ENDPROC
2067: 

*-- Linhas 2225 a 2287:
2225:                 USE IN CrImp1
2226:             ENDIF
2227: 
2228:             SELECT DISTINCT Impres as cNomeImp1s, SPACE(100) as cNomeImp2s, 0 as nMarca1s ;
2229:               FROM CrSigCdmp ;
2230:              WHERE nchqfs = 1 ;
2231:              ORDER BY Impres ;
2232:               INTO CURSOR CrImp1 READWRITE
2233: 
2234:             IF EOF("CrImp1")
2235:                 MsgAviso("Nenhuma impressora de cheque configurada!", "Aten" + CHR(231) + CHR(227) + "o")
2236:                 USE IN CrImp1
2237:                 RETURN
2238:             ENDIF
2239: 
2240:             *-- Identificar impressoras instaladas no sistema
2241:             loc_nPrinters = APRINTERS(loc_aPrinters)
2242:             SELECT CrImp1
2243:             GO TOP
2244:             SCAN
2245:                 loc_cNomeImp = LOWER(ALLTRIM(CrImp1.cNomeImp1s))
2246:                 loc_lEncontrou = .F.
2247:                 LOCAL loc_n
2248:                 FOR loc_n = 1 TO loc_nPrinters
2249:                     IF LOWER(ALLTRIM(JUSTFNAME(loc_aPrinters(loc_n, 1)))) == loc_cNomeImp
2250:                         loc_cNomeImpPath = ALLTRIM(loc_aPrinters(loc_n, 1))
2251:                         SCATTER MEMVAR
2252:                         m.cNomeImp2s = loc_cNomeImpPath
2253:                         m.nMarca1s   = 1
2254:                         GATHER MEMVAR FIELDS cNomeImp2s, nMarca1s
2255:                         loc_lEncontrou = .T.
2256:                         EXIT
2257:                     ENDIF
2258:                 ENDFOR
2259:             ENDSCAN
2260: 
2261:             IF USED("CrImp2")
2262:                 USE IN CrImp2
2263:             ENDIF
2264:             SELECT DISTINCT cNomeImp1s, cNomeImp2s ;
2265:               FROM CrImp1 ;
2266:              WHERE nMarca1s = 1 ;
2267:              ORDER BY cNomeImp1s ;
2268:               INTO CURSOR CrImp2 READWRITE
2269: 
2270:             USE IN CrImp1
2271: 
2272:             SELECT CrImp2
2273:             INDEX ON cNomeImp2s TAG cNomeImp2s
2274:             GO TOP
2275: 
2276:             IF EOF("CrImp2")
2277:                 MsgAviso("Nenhuma impressora de cheque instalada!", "Aten" + CHR(231) + CHR(227) + "o")
2278:                 USE IN CrImp2
2279:                 RETURN
2280:             ENDIF
2281: 
2282:             *-- Selecionar impressora (se mais de uma disponivel)
2283:             IF RECCOUNT("CrImp2") > 1
2284:                 loc_cNomeImpPath = GETPRINTER()
2285:                 IF EMPTY(loc_cNomeImpPath)
2286:                     USE IN CrImp2
2287:                     RETURN

*-- Linhas 2336 a 2382:
2336:                 @ 0, 0 SAY EVALUATE(loc_cPrnIni)
2337:             ENDIF
2338: 
2339:             SELECT * FROM CsSigCqChi WHERE NMarca1s = 1 INTO CURSOR TmpChImp
2340: 
2341:             WAIT WINDOW "Imprimindo Cheque(s) Selecionado(s)..." NOWAIT
2342: 
2343:             SELECT TmpChImp
2344:             GO TOP
2345:             SCAN
2346:                 PRIVATE pBancos, pAgencias, pNContas, pNCheques
2347:                 pBancos   = TmpChImp.bancos
2348:                 pAgencias = TmpChImp.agencias
2349:                 pNContas  = TmpChImp.ncontas
2350:                 pNCheques = TmpChImp.ncheques
2351: 
2352:                 IF USED("TmpPar")
2353:                     USE IN TmpPar
2354:                 ENDIF
2355:                 loc_cSQL = "SELECT valos, vencs FROM SigMvPar" + ;
2356:                            " WHERE bancos = ?pBancos AND agencias = ?pAgencias" + ;
2357:                            " AND contas = ?pNContas AND numeros = ?pNCheques"
2358:                 loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "TmpPar")
2359:                 IF loc_nQueryOk < 1
2360:                     WAIT CLEAR
2361:                     SET PRINTER TO DEFAULT
2362:                     SET DEVICE TO SCREEN
2363:                     MsgErro("Falha ao carregar dados do cheque.", "Erro")
2364:                     RETURN
2365:                 ENDIF
2366: 
2367:                 SELECT TmpPar
2368:                 GO TOP
2369:                 IF !EOF() AND (EMPTY(ALLTRIM(THIS.txt_4c_CdContas.Value)) OR ;
2370:                                TmpChImp.contas = ALLTRIM(THIS.txt_4c_CdContas.Value))
2371:                     LOCAL loc_cStr1, loc_cStr2
2372:                     loc_cStr1 = "#" + ALLTRIM(TRANSFORM(TmpPar.valos, "999,999,999.99")) + "#"
2373:                     @ loc_nLivl,    loc_nClvl    SAY loc_cStr1 FONT "Courier New", 10 STYLE "N"
2374: 
2375:                     loc_cStr1 = ALLTRIM(STR(TmpPar.valos))
2376:                     loc_cStr2 = loc_cStr1
2377:                     IF LEN(loc_cStr2) > (loc_nMaxCol - loc_nClvExt1)
2378:                         loc_cStr2 = LEFT(loc_cStr2, (loc_nMaxCol - loc_nClvExt1))
2379:                         IF !EMPTY(SUBSTR(loc_cStr1, LEN(loc_cStr2) + 1))
2380:                             loc_cStr2 = SUBSTR(loc_cStr2, 1, RAT(" ", loc_cStr2))
2381:                         ENDIF
2382:                     ENDIF

*-- Linhas 2397 a 2427:
2397: 
2398:                     PRIVATE pCidChave
2399:                     pCidChave = TmpChImp.cidchaves
2400:                     loc_cSQL  = "UPDATE SigCqChi SET emitidos = 1 WHERE cidchaves = ?pCidChave"
2401:                     loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL)
2402:                     IF loc_nQueryOk < 1
2403:                         WAIT CLEAR
2404:                         SET PRINTER TO DEFAULT
2405:                         SET DEVICE TO SCREEN
2406:                         MsgErro("Falha ao atualizar emissao do cheque.", "Erro")
2407:                         RETURN
2408:                     ENDIF
2409:                 ENDIF
2410: 
2411:                 WAIT WINDOW "Imprimindo Cheque(s) Selecionado(s)..." NOWAIT
2412:                 SELECT TmpChImp
2413:             ENDSCAN
2414: 
2415:             WAIT CLEAR
2416:             SET PRINTER TO DEFAULT
2417:             SET DEVICE TO SCREEN
2418:             SET CONSOLE ON
2419: 
2420:             IF USED("TmpPar")
2421:                 USE IN TmpPar
2422:             ENDIF
2423:             IF USED("TmpChImp")
2424:                 USE IN TmpChImp
2425:             ENDIF
2426: 
2427:             SET POINT TO (loc_cPoint)

*-- Linhas 2444 a 2492:
2444:                 RETURN
2445:             ENDIF
2446: 
2447:             SELECT CsSigCqChi
2448:             loc_nRecno = RECNO()
2449: 
2450:             IF USED("TmpChi")
2451:                 USE IN TmpChi
2452:             ENDIF
2453: 
2454:             SELECT DISTINCT bancos ;
2455:               FROM CsSigCqChi ;
2456:              WHERE NMarca1s = 1 ;
2457:               INTO CURSOR TmpChi
2458: 
2459:             SELECT TmpChi
2460:             GO TOP
2461: 
2462:             IF !EOF()
2463:                 IF RECCOUNT("TmpChi") > 1
2464:                     MsgAviso("Todos os cheques selecionados devem ser do mesmo banco.", "Aten" + CHR(231) + CHR(227) + "o")
2465:                     SELECT CsSigCqChi
2466:                     GOTO loc_nRecno
2467:                     THIS.grd_4c_Dados.SetFocus
2468:                     RETURN
2469:                 ENDIF
2470: 
2471:                 SELECT bancos, valors, ncheques, datas, NEmitidos, NCancelas, favos ;
2472:                   FROM CsSigCqChi ;
2473:                  WHERE NMarca1s = 1 ;
2474:                  ORDER BY bancos, ncheques ;
2475:                   INTO CURSOR CrCheque
2476: 
2477:                 SELECT CrCheque
2478:                 LOCATE FOR NEmitidos = 1
2479:                 IF FOUND()
2480:                     IF MsgConfirma("Os cheques selecionados j" + CHR(225) + " foram emitidos. " + ;
2481:                                    "Confirma impress" + CHR(227) + "o?", ;
2482:                                    "Aten" + CHR(231) + CHR(227) + "o")
2483:                         MsgAviso("Verifique se a impressora est" + CHR(225) + ;
2484:                                  " pronta para impress" + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
2485:                     ELSE
2486:                         IF USED("CrCheque")
2487:                             USE IN CrCheque
2488:                         ENDIF
2489:                         RETURN
2490:                     ENDIF
2491:                 ELSE
2492:                     MsgAviso("Verifique se a impressora est" + CHR(225) + ;

*-- Linhas 2499 a 2540:
2499: 
2500:                 PUBLIC xImpOk
2501:                 IF TYPE("xImpOk") = "L" AND xImpOk
2502:                     SELECT CrCheque
2503:                     GO TOP
2504:                     SCAN
2505:                         PRIVATE pBancos2, pNCheques2
2506:                         pBancos2   = CrCheque.bancos
2507:                         pNCheques2 = CrCheque.ncheques
2508:                         loc_cSQL   = "UPDATE SigCqChi SET emitidos = 1" + ;
2509:                                      " WHERE bancos = ?pBancos2 AND ncheques = ?pNCheques2"
2510:                         loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL)
2511:                         IF loc_nQueryOk < 1
2512:                             MsgErro("Falha ao atualizar emissao.", "Erro")
2513:                             RETURN
2514:                         ENDIF
2515:                         UPDATE CsSigCqChi SET NEmitidos = 1 ;
2516:                           WHERE bancos = CrCheque.bancos AND ncheques = CrCheque.ncheques
2517:                         SELECT CrCheque
2518:                     ENDSCAN
2519:                     THIS.this_oBusinessObject.Commit()
2520:                 ENDIF
2521: 
2522:                 IF USED("CrCheque")
2523:                     USE IN CrCheque
2524:                 ENDIF
2525:                 SELECT CsSigCqChi
2526:                 GOTO loc_nRecno
2527:                 THIS.grd_4c_Dados.Refresh
2528:             ELSE
2529:                 *-- Nenhum cheque marcado: abrir painel de faixa matricial
2530:                 THIS.this_lChMatIni = .T.
2531:                 THIS.AtivarImpChmat()
2532:             ENDIF
2533: 
2534:             IF USED("TmpChi")
2535:                 USE IN TmpChi
2536:             ENDIF
2537: 
2538:         CATCH TO loc_oErro
2539:             MsgErro(loc_oErro.Message, "Erro em Chq. Matric.")
2540:         ENDTRY

*-- Linhas 2574 a 2598:
2574: 
2575:                 PRIVATE pCidChaveDel
2576:                 pCidChaveDel = CsSigCqChi.cidchaves
2577:                 loc_cSQL     = "DELETE FROM SigCqChi WHERE cidchaves = ?pCidChaveDel"
2578:                 loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL)
2579: 
2580:                 IF loc_nQueryOk >= 1
2581:                     THIS.this_oBusinessObject.Commit()
2582:                     SELECT CsSigCqChi
2583:                     DELETE
2584:                     THIS.grd_4c_Dados.Refresh
2585:                 ELSE
2586:                     MsgErro("Falha ao excluir cheque.", "Erro")
2587:                 ENDIF
2588:             ENDIF
2589:         ENDIF
2590:     ENDPROC
2591: 
2592:     *==========================================================================
2593:     *  Handlers dos campos de filtro
2594:     *==========================================================================
2595: 
2596:     *-- CdGrupos: salva valor ao entrar
2597:     PROCEDURE CdGruposGotFocus()
2598:         THIS.this_cAntCdGrupo = ALLTRIM(THIS.txt_4c_CdGrupos.Value)

*-- Linhas 2614 a 2633:
2614:             IF USED("cursor_4c_GrupoValida")
2615:                 USE IN cursor_4c_GrupoValida
2616:             ENDIF
2617:             loc_nQueryOk = SQLEXEC(gnConnHandle, ;
2618:                 "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = ?pGrupoVal", ;
2619:                 "cursor_4c_GrupoValida")
2620:             IF loc_nQueryOk >= 1 AND !EOF("cursor_4c_GrupoValida")
2621:                 THIS.txt_4c_DsGrupos.Value = ALLTRIM(cursor_4c_GrupoValida.Descrs)
2622:                 USE IN cursor_4c_GrupoValida
2623:             ELSE
2624:                 IF USED("cursor_4c_GrupoValida")
2625:                     USE IN cursor_4c_GrupoValida
2626:                 ENDIF
2627:                 MsgAviso("Grupo n" + CHR(227) + "o encontrado!", "")
2628:                 THIS.txt_4c_CdGrupos.Value = ""
2629:                 THIS.txt_4c_DsGrupos.Value = ""
2630:             ENDIF
2631:         ELSE
2632:             THIS.txt_4c_DsGrupos.Value = ""
2633:         ENDIF

*-- Linhas 2664 a 2683:
2664:             IF USED("cursor_4c_GrupoValida")
2665:                 USE IN cursor_4c_GrupoValida
2666:             ENDIF
2667:             loc_nQueryOk = SQLEXEC(gnConnHandle, ;
2668:                 "SELECT Codigos, Descrs FROM SigCdGcr WHERE Descrs LIKE ?pGrupoDesc + '%'", ;
2669:                 "cursor_4c_GrupoValida")
2670:             IF loc_nQueryOk >= 1 AND !EOF("cursor_4c_GrupoValida")
2671:                 THIS.txt_4c_CdGrupos.Value = ALLTRIM(cursor_4c_GrupoValida.Codigos)
2672:                 THIS.txt_4c_DsGrupos.Value = ALLTRIM(cursor_4c_GrupoValida.Descrs)
2673:                 USE IN cursor_4c_GrupoValida
2674:             ELSE
2675:                 IF USED("cursor_4c_GrupoValida")
2676:                     USE IN cursor_4c_GrupoValida
2677:                 ENDIF
2678:                 MsgAviso("Grupo n" + CHR(227) + "o encontrado!", "")
2679:                 THIS.txt_4c_CdGrupos.Value = ""
2680:                 THIS.txt_4c_DsGrupos.Value = ""
2681:             ENDIF
2682:         ELSE
2683:             THIS.txt_4c_CdGrupos.Value = ""

*-- Linhas 2815 a 2848:
2815:             RETURN
2816:         ENDIF
2817:         loc_nRecno = RECNO("CsSigCqChi")
2818:         UPDATE CsSigCqChi SET NMarca1s = 0 WHERE NMarca1s = 1
2819:         IF BETWEEN(loc_nRecno, 1, RECCOUNT("CsSigCqChi"))
2820:             GOTO loc_nRecno IN CsSigCqChi
2821:         ENDIF
2822:         THIS.grd_4c_Dados.Refresh
2823:     ENDPROC
2824: 
2825:     *-- Botao Marcar Todos
2826:     PROCEDURE CmdTudo1Click()
2827:         LOCAL loc_nRecno
2828: 
2829:         IF !USED("CsSigCqChi")
2830:             RETURN
2831:         ENDIF
2832:         loc_nRecno = RECNO("CsSigCqChi")
2833:         UPDATE CsSigCqChi SET NMarca1s = 1 WHERE NMarca1s = 0 AND NEmitidos = 0 AND NCancelas = 0
2834:         IF BETWEEN(loc_nRecno, 1, RECCOUNT("CsSigCqChi"))
2835:             GOTO loc_nRecno IN CsSigCqChi
2836:         ENDIF
2837:         THIS.grd_4c_Dados.Refresh
2838:     ENDPROC
2839: 
2840:     *-- Botao Processar
2841:     PROCEDURE Command2Click()
2842:         IF THIS.txt_4c_Dt_inicial.Value > THIS.txt_4c_Dt_final.Value
2843:             MsgAviso("Data Final menor que Data Inicial !!!", "Per" + CHR(237) + "odo Inv" + CHR(225) + "lido")
2844:             THIS.txt_4c_Dt_inicial.SetFocus
2845:             RETURN
2846:         ENDIF
2847: 
2848:         IF THIS.this_dAntDtIni <> THIS.txt_4c_Dt_inicial.Value OR ;

*-- Linhas 2988 a 3046:
2988:             pChIniFil = loc_cChIni
2989:             pChFinFil = loc_cChFin
2990: 
2991:             SELECT bancos, valors, ncheques, datas, favos, NEmitidos ;
2992:               FROM CsSigCqChi ;
2993:              WHERE bancos = ?pBancoFil ;
2994:                AND ncheques BETWEEN ?pChIniFil AND ?pChFinFil ;
2995:                AND NCancelas = 0 ;
2996:              ORDER BY bancos, ncheques ;
2997:               INTO CURSOR CrCheque
2998: 
2999:             SELECT CrCheque
3000:             LOCATE FOR NEmitidos = 1
3001:             IF FOUND()
3002:                 IF !MsgConfirma("Os cheques selecionados j" + CHR(225) + " foram emitidos. " + ;
3003:                                 "Confirma impress" + CHR(227) + "o?", ;
3004:                                 "Aten" + CHR(231) + CHR(227) + "o")
3005:                     USE IN CrCheque
3006:                     RETURN
3007:                 ENDIF
3008:             ENDIF
3009: 
3010:             GO TOP
3011:             MsgAviso("Verificar se a impressora est" + CHR(225) + ;
3012:                      " pronta para impress" + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
3013: 
3014:             DO SigIpChq.prg
3015: 
3016:             PUBLIC xImpOk
3017:             IF TYPE("xImpOk") = "L" AND xImpOk
3018:                 LOCAL loc_cSQL, loc_nQueryOk
3019:                 SELECT CrCheque
3020:                 SCAN
3021:                     PRIVATE pBancoUpd, pNChequeUpd
3022:                     pBancoUpd   = CrCheque.bancos
3023:                     pNChequeUpd = CrCheque.ncheques
3024:                     loc_cSQL = "UPDATE SigCqChi SET emitidos = 1" + ;
3025:                                " WHERE bancos = ?pBancoUpd AND ncheques = ?pNChequeUpd"
3026:                     loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL)
3027:                     IF loc_nQueryOk < 1
3028:                         MsgErro("Falha ao atualizar emissao.", "Erro")
3029:                         EXIT
3030:                     ENDIF
3031:                     SELECT CrCheque
3032:                 ENDSCAN
3033:             ENDIF
3034: 
3035:             IF USED("CrCheque")
3036:                 USE IN CrCheque
3037:             ENDIF
3038: 
3039:         CATCH TO loc_oErro
3040:             MsgErro(loc_oErro.Message, "Erro na impressao matricial")
3041:         ENDTRY
3042:     ENDPROC
3043: 
3044:     PROCEDURE ImpchmatEncerrarClick()
3045:         THIS.LockScreen = .T.
3046:         THIS.obj_4c_CmdGok.Enabled   = .T.

*-- Linhas 3113 a 3131:
3113:         loc_nValor   = THIS.cnt_4c_Procurar.txt_4c_Valor.Value
3114: 
3115:         SET NEAR ON
3116:         SELECT CsSigCqChi
3117: 
3118:         DO CASE
3119:         CASE !EMPTY(loc_dEmissao) AND VARTYPE(loc_dEmissao) = "D"
3120:             SET ORDER TO Emissao
3121:             SEEK DTOS(loc_dEmissao) + loc_cBanco + loc_cAgencia + loc_cConta + loc_cCheque
3122:         CASE loc_nValor <> 0
3123:             SET ORDER TO Valor
3124:             SEEK STR(loc_nValor, 12, 2) + loc_cBanco + loc_cAgencia + loc_cConta + loc_cCheque
3125:         CASE !EMPTY(loc_cBanco)
3126:             SET ORDER TO Cheque
3127:             SEEK loc_cBanco + loc_cAgencia + loc_cConta + loc_cCheque
3128:         CASE !EMPTY(loc_cAgencia)
3129:             SET ORDER TO Agencia
3130:             SEEK loc_cAgencia + loc_cConta + loc_cCheque
3131:         CASE !EMPTY(loc_cConta)

*-- Linhas 3291 a 3318:
3291: 
3292:                 PRIVATE pCidChaveDel
3293:                 pCidChaveDel = CsSigCqChi.cidchaves
3294:                 loc_cSQL     = "DELETE FROM SigCqChi WHERE cidchaves = ?pCidChaveDel"
3295:                 loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL)
3296: 
3297:                 IF loc_nQueryOk >= 1
3298:                     THIS.this_oBusinessObject.Commit()
3299:                     loc_cMensa = "Exclus" + CHR(227) + "o do cheque cancelado: " + ;
3300:                                  CsSigCqChi.bancos + "/" + CsSigCqChi.agencias + ;
3301:                                  "/" + CsSigCqChi.ncontas + "/" + CsSigCqChi.ncheques
3302:                     SELECT CsSigCqChi
3303:                     DELETE
3304:                     THIS.grd_4c_Dados.Refresh
3305:                     MsgInfo("Cheque exclu" + CHR(237) + "do com sucesso.", ;
3306:                             "Exclus" + CHR(227) + "o")
3307:                 ELSE
3308:                     MsgErro("Falha ao excluir cheque.", "Erro")
3309:                 ENDIF
3310:             ENDIF
3311:         CATCH TO loc_oErro
3312:             MsgErro(loc_oErro.Message, "Erro em Excluir")
3313:         ENDTRY
3314:     ENDPROC
3315: 
3316:     *==========================================================================
3317:     *  FASE 8/8 - Metodos auxiliares e consolidacao final
3318:     *==========================================================================

