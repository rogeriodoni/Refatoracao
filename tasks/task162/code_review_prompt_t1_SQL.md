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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrChr.prg) - TRECHOS RELEVANTES PARA PASS SQL (3532 linhas total):

*-- Linhas 415 a 433:
415:             .FontName          = "Tahoma"
416:             .AllowHeaderSizing = .F.
417:             .AllowRowSizing    = .F.
418:             .DeleteMark        = .F.
419:             .ReadOnly          = .F.
420:             .ScrollBars        = 2
421:             .GridLineColor     = RGB(238, 238, 238)
422:             .ColumnCount       = 10
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

*-- Linhas 1662 a 1690:
1662: 
1663:         TRY
1664:             IF USED("CsSigCqChi")
1665:                 UPDATE CsSigCqChi SET nMarca1s = 0 WHERE nMarca1s = 1
1666:             ENDIF
1667: 
1668:             IF EMPTY(ALLTRIM(THIS.txt_4c_CdContas.Value))
1669:                 SELECT CsSigCqChi
1670:                 SET ORDER TO NCopias
1671:                 IF loc_lSeek
1672:                     SEEK CHR(255) IN CsSigCqChi ORDER NCopias ASCENDING
1673:                 ENDIF
1674:             ELSE
1675:                 SELECT CsSigCqChi
1676:                 SET ORDER TO Contas
1677:                 SET KEY TO ALLTRIM(THIS.txt_4c_CdContas.Value)
1678:                 IF loc_lSeek
1679:                     SEEK ALLTRIM(THIS.txt_4c_CdContas.Value) + CHR(255) IN CsSigCqChi ORDER Contas ASCENDING
1680:                 ENDIF
1681:             ENDIF
1682: 
1683:             THIS.obj_4c_CmdGok.Buttons(4).Enabled = .T.
1684:             THIS.obj_4c_CmdGok.Refresh
1685:             THIS.grd_4c_Dados.Refresh
1686: 
1687:             IF USED("CsSigCqChi") AND !EOF("CsSigCqChi")
1688:                 THIS.txt_4c_TxtFavorecido.Value = ALLTRIM(CsSigCqChi.favos)
1689:             ENDIF
1690:             THIS.txt_4c_TxtFavorecido.Refresh

*-- Linhas 1702 a 1720:
1702:     *  par_lPosiciona = .T.: reposiciona no cheque atual apos recarregar.
1703:     *--------------------------------------------------------------------------
1704:         LOCAL loc_lResultado, loc_lPosiciona, loc_cBusca
1705:         LOCAL loc_cCdGrupo, loc_cCdConta, loc_cQuery, loc_nQueryOk
1706:         PRIVATE pDtInicial, pDtFinal
1707: 
1708:         loc_lResultado = .F.
1709: 
1710:         TRY
1711:             loc_lPosiciona = (TYPE("par_lPosiciona") = "L" AND par_lPosiciona)
1712: 
1713:             IF loc_lPosiciona AND USED("CsSigCqChi") AND !EOF("CsSigCqChi")
1714:                 loc_cBusca = CsSigCqChi.bancos + CsSigCqChi.agencias + ;
1715:                              CsSigCqChi.ncontas  + CsSigCqChi.ncheques
1716:             ELSE
1717:                 loc_cBusca = ""
1718:             ENDIF
1719: 
1720:             pDtInicial   = THIS.txt_4c_Dt_inicial.Value

*-- Linhas 1731 a 1799:
1731:             ENDIF
1732: 
1733:             IF EMPTY(loc_cCdConta)
1734:                 loc_cQuery = "SELECT a.emps, a.dopes, a.numes, a.datas, a.bancos, a.agencias," + ;
1735:                              " a.ncontas, a.ncheques, a.contas," + ;
1736:                              " a.valors, a.favos, a.ncopias, a.emitidos, a.nemissoes, a.cancelas," + ;
1737:                              " a.cidchaves, a.JustCanc, 0 as NEmitidos, 0 as NCancelas, 0 as NMarca1s" + ;
1738:                              " FROM SigCqChi a" + ;
1739:                              " WHERE a.datas BETWEEN ?pDtInicial AND ?pDtFinal"
1740:                 IF !EMPTY(loc_cCdGrupo)
1741:                     loc_cQuery = loc_cQuery + " AND a.Grupos = " + EscaparSQL(loc_cCdGrupo)
1742:                 ENDIF
1743:                 loc_cQuery = loc_cQuery + ;
1744:                              " AND a.Contas IN (SELECT DISTINCT ContaDs FROM SigOpFp WHERE EmiChqs = 1)" + ;
1745:                              " ORDER BY a.emps, a.dopes, a.numes, a.datas, a.bancos, a.agencias," + ;
1746:                              " a.ncontas, a.ncheques, a.contas, a.valors, a.favos," + ;
1747:                              " a.ncopias, a.emitidos, a.nemissoes, a.cancelas, a.cidchaves"
1748:             ELSE
1749:                 loc_cQuery = "SELECT emps, dopes, numes, datas, bancos, agencias," + ;
1750:                              " ncontas, ncheques, contas," + ;
1751:                              " valors, favos, ncopias, emitidos, nemissoes, cancelas, cidchaves, JustCanc," + ;
1752:                              " 0 as NEmitidos, 0 as NCancelas, 0 as NMarca1s" + ;
1753:                              " FROM SigCqChi" + ;
1754:                              " WHERE datas BETWEEN ?pDtInicial AND ?pDtFinal"
1755:                 IF !EMPTY(loc_cCdGrupo)
1756:                     loc_cQuery = loc_cQuery + " AND Grupos = " + EscaparSQL(loc_cCdGrupo)
1757:                 ENDIF
1758:                 loc_cQuery = loc_cQuery + ;
1759:                              " AND Contas = " + EscaparSQL(loc_cCdConta) + ;
1760:                              " ORDER BY emps, dopes, numes, datas, bancos, agencias," + ;
1761:                              " ncontas, ncheques, contas, valors, favos," + ;
1762:                              " ncopias, emitidos, nemissoes, cancelas, cidchaves"
1763:             ENDIF
1764: 
1765:             IF USED("cursor_4c_TmpChi")
1766:                 USE IN cursor_4c_TmpChi
1767:             ENDIF
1768:             loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_TmpChi")
1769:             IF loc_nQueryOk < 1
1770:                 WAIT CLEAR
1771:                 MsgErro("Falha ao carregar cheques.", "Erro de Conex" + CHR(227) + "o")
1772:                 THIS.LockScreen = .F.
1773:                 loc_lResultado = .F.
1774:             ENDIF
1775: 
1776:             SELECT emps, dopes, numes, datas, bancos, agencias, ncontas, ncheques, contas, ;
1777:                    valors, favos, ncopias, NEmitidos, cidchaves, NCancelas, NMarca1s, JustCanc ;
1778:               FROM cursor_4c_TmpChi ;
1779:              ORDER BY bancos, agencias, ncontas, ncheques ;
1780:               INTO CURSOR CsSigCqChi READWRITE
1781: 
1782:             USE IN cursor_4c_TmpChi
1783: 
1784:             SELECT CsSigCqChi
1785:             INDEX ON ncopias                                                   TAG NCopias
1786:             INDEX ON NEmitidos                                                 TAG NEmitidos
1787:             INDEX ON NCancelas                                                 TAG NCancelas
1788:             INDEX ON NMarca1s                                                  TAG NMarca1s
1789:             INDEX ON ncheques                                                  TAG NCheques
1790:             INDEX ON datas                                                     TAG Datas
1791:             INDEX ON ncontas + ncheques                                        TAG Conta
1792:             INDEX ON contas + STR(ncopias)                                     TAG Contas
1793:             INDEX ON DTOS(datas) + bancos + agencias + ncontas + ncheques      TAG Emissao
1794:             INDEX ON STR(valors,12,2) + bancos + agencias + ncontas + ncheques TAG Valor
1795:             INDEX ON bancos + agencias + ncontas + ncheques                    TAG Cheque
1796:             INDEX ON agencias + ncontas + ncheques                             TAG Agencia
1797: 
1798:             SET ORDER TO NCopias
1799:             IF loc_lPosiciona AND !EMPTY(loc_cBusca)

*-- Linhas 1809 a 1848:
1809: 
1810:             WITH THIS.grd_4c_Dados
1811:                 .RecordSource                           = "CsSigCqChi"
1812:                 .Column10.ControlSource                 = "CsSigCqChi.NMarca1s"
1813:                 .Column10.chk_4c_Imprime.ControlSource = "CsSigCqChi.NMarca1s"
1814:                 .Column1.ControlSource                  = "CsSigCqChi.datas"
1815:                 .Column2.ControlSource                  = "CsSigCqChi.contas"
1816:                 .Column3.ControlSource                  = "CsSigCqChi.ncopias"
1817:                 .Column4.ControlSource                  = "CsSigCqChi.bancos"
1818:                 .Column5.ControlSource                  = "CsSigCqChi.agencias"
1819:                 .Column6.ControlSource                  = "CsSigCqChi.ncontas"
1820:                 .Column7.ControlSource                  = "CsSigCqChi.ncheques"
1821:                 .Column9.ControlSource                  = "CsSigCqChi.valors"
1822:                 .Column8.ControlSource = "IIF(CsSigCqChi.NCancelas=1,'Cancelado'," + ;
1823:                     "IIF(CsSigCqChi.NEmitidos=1," + ;
1824:                     "IIF(CsSigCqChi.ncopias>1,'Reemitido','Emitido')," + ;
1825:                     "'N" + CHR(227) + "o Emitido'))"
1826:                 .SetAll("DynamicForeColor", ;
1827:                     "IIF(CsSigCqChi.NCancelas=1,RGB(255,0,0)," + ;
1828:                     "IIF(CsSigCqChi.NEmitidos=0,RGB(0,0,255),RGB(0,0,0)))", ;
1829:                     "Column")
1830:                 .Refresh
1831:             ENDWITH
1832: 
1833:             THIS.cnt_4c_Justificativa.obj_4c_Get_justificativa.ControlSource = "CsSigCqChi.JustCanc"
1834: 
1835:             IF loc_lPosiciona
1836:                 THIS.MExibeCheques(.F.)
1837:             ELSE
1838:                 THIS.MExibeCheques(.T.)
1839:             ENDIF
1840: 
1841:             loc_lResultado = .T.
1842: 
1843:         CATCH TO loc_oErro
1844:             WAIT CLEAR
1845:             THIS.LockScreen = .F.
1846:             MsgErro(loc_oErro.Message, "Erro em MontaChq")
1847:         ENDTRY
1848: 

*-- Linhas 1869 a 1977:
1869:                 USE IN TmpPrIt
1870:             ENDIF
1871: 
1872:             loc_cSQL = "SELECT emps, dopes, numes, empos, grupos, contas, tipos, nopers, opers," + ;
1873:                        " acertos, cotacaos, valos, moedas, hists, vencs, datas" + ;
1874:                        " FROM SigCdPit" + ;
1875:                        " WHERE empdopnums = " + EscaparSQL(loc_cChave) + ;
1876:                        " ORDER BY emps, dopes, numes, grupos, contas, nopers"
1877: 
1878:             loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "TmpPrIt")
1879:             IF loc_nQueryOk < 1
1880:                 MsgErro("Falha ao carregar pagamentos.", "Erro")
1881:                 loc_lResultado = .F.
1882:             ENDIF
1883: 
1884:             IF USED("TmpConta")
1885:                 USE IN TmpConta
1886:             ENDIF
1887: 
1888:             SET NULL ON
1889:             CREATE CURSOR TmpConta (grupos C(10) NULL, contas C(10) NULL, flag L NULL, ;
1890:                 valos N(12,2) NULL, acerto N(12,2) NULL, moedas C(3) NULL, ;
1891:                 datas D NULL, vencs D NULL, hists C(50) NULL, nomes C(50) NULL, ;
1892:                 emps C(3) NULL, nopers N(9,0) NULL, dopes C(20) NULL, numes N(6,0) NULL, ;
1893:                 tipos C(1) NULL, fpags C(12) NULL, opers C(1) NULL, baixa N(12,2) NULL, ;
1894:                 baixaaut N(12,2) NULL, cotacaos N(12,4) NULL, grupocs C(10) NULL, ;
1895:                 contacs C(10) NULL, cotorigs N(12,4) NULL, moedacs C(3) NULL, ;
1896:                 cotacaocs N(12,4) NULL, valocs N(12,2) NULL, empos C(3) NULL, ;
1897:                 OrdCopChs N(3,0) NULL)
1898:             SET NULL OFF
1899: 
1900:             SELECT TmpPrIt
1901:             GO TOP
1902: 
1903:             SCAN
1904:                 SCATTER MEMVAR
1905:                 m.flag  = .F.
1906:                 m.nomes = ""
1907: 
1908:                 IF USED("CrContas") AND SEEK(m.contas, "CrContas", "IClis")
1909:                     m.nomes = ALLTRIM(CrContas.RClis)
1910:                 ENDIF
1911: 
1912:                 DO CASE
1913:                 CASE TmpPrIt.tipos = "M"
1914:                     IF m.acertos <> 0
1915:                         m.flag = .T.
1916:                     ENDIF
1917: 
1918:                 CASE TmpPrIt.tipos = "C"
1919:                     m.flag = .T.
1920:                     IF USED("TmpMccr")
1921:                         USE IN TmpMccr
1922:                     ENDIF
1923:                     loc_cSQL = "SELECT emps, nopers, grupos, contas, valors, valpags" + ;
1924:                                " FROM SigMvCcr" + ;
1925:                                " WHERE emps = " + EscaparSQL(m.empos) + ;
1926:                                " AND nopers = " + FormatarNumeroSQL(m.nopers)
1927:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpMccr") >= 1
1928:                         SELECT TmpMccr
1929:                         GO TOP
1930:                         IF m.grupos <> TmpMccr.grupos OR m.contas <> TmpMccr.contas
1931:                             SKIP
1932:                         ENDIF
1933:                         IF !EOF("TmpMccr")
1934:                             m.valos = TmpMccr.valors - TmpMccr.valpags + m.acertos
1935:                         ENDIF
1936:                     ENDIF
1937: 
1938:                 CASE TmpPrIt.tipos = "P"
1939:                     m.flag = .T.
1940:                     IF USED("TmpPar")
1941:                         USE IN TmpPar
1942:                     ENDIF
1943:                     loc_cSQL = "SELECT emps, nopers, moefpgs, fpags, vpags" + ;
1944:                                " FROM SigMvPar" + ;
1945:                                " WHERE emps = " + EscaparSQL(m.empos) + ;
1946:                                " AND nopers = " + FormatarNumeroSQL(m.nopers)
1947:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpPar") >= 1
1948:                         SELECT TmpPar
1949:                         GO TOP
1950:                         IF !EOF("TmpPar")
1951:                             m.valos  = m.valos - TmpPar.vpags + m.acertos
1952:                             m.moedas = ALLTRIM(TmpPar.moefpgs)
1953:                             m.hists  = ALLTRIM(TmpPar.fpags) + " " + m.emps + ;
1954:                                        ALLTRIM(m.dopes) + " " + ALLTRIM(TRANSFORM(m.numes))
1955:                         ENDIF
1956:                     ENDIF
1957:                 ENDCASE
1958: 
1959:                 m.acerto = m.acertos
1960:                 SELECT TmpConta
1961:                 INSERT INTO TmpConta FROM MEMVAR
1962:                 SELECT TmpPrIt
1963:             ENDSCAN
1964: 
1965:             IF USED("TmpPrIt")
1966:                 USE IN TmpPrIt
1967:             ENDIF
1968: 
1969:             loc_lResultado = .T.
1970: 
1971:         CATCH TO loc_oErro
1972:             MsgErro(loc_oErro.Message, "Erro em CarregaConta")
1973:         ENDTRY
1974: 
1975:         RETURN loc_lResultado
1976:     ENDPROC
1977: 

*-- Linhas 2054 a 2072:
2054:                 loc_nRecno = RECNO("CsSigCqChi")
2055:                 loc_cChave = CsSigCqChi.bancos + CsSigCqChi.agencias + ;
2056:                              CsSigCqChi.ncontas + CsSigCqChi.ncheques
2057:                 UPDATE CsSigCqChi SET NMarca1s = IIF(NMarca1s = 1, 0, 1) ;
2058:                   WHERE bancos + agencias + ncontas + ncheques = loc_cChave ;
2059:                     AND NEmitidos = 0 AND NCancelas = 0
2060:                 THIS.grd_4c_Dados.Refresh
2061:                 IF BETWEEN(loc_nRecno, 1, RECCOUNT("CsSigCqChi"))
2062:                     GOTO loc_nRecno IN CsSigCqChi
2063:                 ENDIF
2064:             ENDIF
2065:         ENDIF
2066:     ENDPROC
2067: 
2068:     *-- Grid: CheckBox Imprime - MouseUp (simula KeyPress com SPACE)
2069:     PROCEDURE ChkImprimeMouseUp(par_nButton, par_nShift, par_nX, par_nY)
2070:         THIS.ChkImprimeKeyPress(32, 0)
2071:     ENDPROC
2072: 

*-- Linhas 2230 a 2292:
2230:                 USE IN CrImp1
2231:             ENDIF
2232: 
2233:             SELECT DISTINCT Impres as cNomeImp1s, SPACE(100) as cNomeImp2s, 0 as nMarca1s ;
2234:               FROM CrSigCdmp ;
2235:              WHERE nchqfs = 1 ;
2236:              ORDER BY Impres ;
2237:               INTO CURSOR CrImp1 READWRITE
2238: 
2239:             IF EOF("CrImp1")
2240:                 MsgAviso("Nenhuma impressora de cheque configurada!", "Aten" + CHR(231) + CHR(227) + "o")
2241:                 USE IN CrImp1
2242:                 RETURN
2243:             ENDIF
2244: 
2245:             *-- Identificar impressoras instaladas no sistema
2246:             loc_nPrinters = APRINTERS(loc_aPrinters)
2247:             SELECT CrImp1
2248:             GO TOP
2249:             SCAN
2250:                 loc_cNomeImp = LOWER(ALLTRIM(CrImp1.cNomeImp1s))
2251:                 loc_lEncontrou = .F.
2252:                 LOCAL loc_n
2253:                 FOR loc_n = 1 TO loc_nPrinters
2254:                     IF LOWER(ALLTRIM(JUSTFNAME(loc_aPrinters(loc_n, 1)))) == loc_cNomeImp
2255:                         loc_cNomeImpPath = ALLTRIM(loc_aPrinters(loc_n, 1))
2256:                         SCATTER MEMVAR
2257:                         m.cNomeImp2s = loc_cNomeImpPath
2258:                         m.nMarca1s   = 1
2259:                         GATHER MEMVAR FIELDS cNomeImp2s, nMarca1s
2260:                         loc_lEncontrou = .T.
2261:                         EXIT
2262:                     ENDIF
2263:                 ENDFOR
2264:             ENDSCAN
2265: 
2266:             IF USED("CrImp2")
2267:                 USE IN CrImp2
2268:             ENDIF
2269:             SELECT DISTINCT cNomeImp1s, cNomeImp2s ;
2270:               FROM CrImp1 ;
2271:              WHERE nMarca1s = 1 ;
2272:              ORDER BY cNomeImp1s ;
2273:               INTO CURSOR CrImp2 READWRITE
2274: 
2275:             USE IN CrImp1
2276: 
2277:             SELECT CrImp2
2278:             INDEX ON cNomeImp2s TAG cNomeImp2s
2279:             GO TOP
2280: 
2281:             IF EOF("CrImp2")
2282:                 MsgAviso("Nenhuma impressora de cheque instalada!", "Aten" + CHR(231) + CHR(227) + "o")
2283:                 USE IN CrImp2
2284:                 RETURN
2285:             ENDIF
2286: 
2287:             *-- Selecionar impressora (se mais de uma disponivel)
2288:             IF RECCOUNT("CrImp2") > 1
2289:                 loc_cNomeImpPath = GETPRINTER()
2290:                 IF EMPTY(loc_cNomeImpPath)
2291:                     USE IN CrImp2
2292:                     RETURN

*-- Linhas 2341 a 2387:
2341:                 @ 0, 0 SAY EVALUATE(loc_cPrnIni)
2342:             ENDIF
2343: 
2344:             SELECT * FROM CsSigCqChi WHERE NMarca1s = 1 INTO CURSOR TmpChImp
2345: 
2346:             WAIT WINDOW "Imprimindo Cheque(s) Selecionado(s)..." NOWAIT
2347: 
2348:             SELECT TmpChImp
2349:             GO TOP
2350:             SCAN
2351:                 PRIVATE pBancos, pAgencias, pNContas, pNCheques
2352:                 pBancos   = TmpChImp.bancos
2353:                 pAgencias = TmpChImp.agencias
2354:                 pNContas  = TmpChImp.ncontas
2355:                 pNCheques = TmpChImp.ncheques
2356: 
2357:                 IF USED("TmpPar")
2358:                     USE IN TmpPar
2359:                 ENDIF
2360:                 loc_cSQL = "SELECT valos, vencs FROM SigMvPar" + ;
2361:                            " WHERE bancos = ?pBancos AND agencias = ?pAgencias" + ;
2362:                            " AND contas = ?pNContas AND numeros = ?pNCheques"
2363:                 loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "TmpPar")
2364:                 IF loc_nQueryOk < 1
2365:                     WAIT CLEAR
2366:                     SET PRINTER TO DEFAULT
2367:                     SET DEVICE TO SCREEN
2368:                     MsgErro("Falha ao carregar dados do cheque.", "Erro")
2369:                     RETURN
2370:                 ENDIF
2371: 
2372:                 SELECT TmpPar
2373:                 GO TOP
2374:                 IF !EOF() AND (EMPTY(ALLTRIM(THIS.txt_4c_CdContas.Value)) OR ;
2375:                                TmpChImp.contas = ALLTRIM(THIS.txt_4c_CdContas.Value))
2376:                     LOCAL loc_cStr1, loc_cStr2
2377:                     loc_cStr1 = "#" + ALLTRIM(TRANSFORM(TmpPar.valos, "999,999,999.99")) + "#"
2378:                     @ loc_nLivl,    loc_nClvl    SAY loc_cStr1 FONT "Courier New", 10 STYLE "N"
2379: 
2380:                     loc_cStr1 = ALLTRIM(STR(TmpPar.valos))
2381:                     loc_cStr2 = loc_cStr1
2382:                     IF LEN(loc_cStr2) > (loc_nMaxCol - loc_nClvExt1)
2383:                         loc_cStr2 = LEFT(loc_cStr2, (loc_nMaxCol - loc_nClvExt1))
2384:                         IF !EMPTY(SUBSTR(loc_cStr1, LEN(loc_cStr2) + 1))
2385:                             loc_cStr2 = SUBSTR(loc_cStr2, 1, RAT(" ", loc_cStr2))
2386:                         ENDIF
2387:                     ENDIF

*-- Linhas 2402 a 2432:
2402: 
2403:                     PRIVATE pCidChave
2404:                     pCidChave = TmpChImp.cidchaves
2405:                     loc_cSQL  = "UPDATE SigCqChi SET emitidos = 1 WHERE cidchaves = ?pCidChave"
2406:                     loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL)
2407:                     IF loc_nQueryOk < 1
2408:                         WAIT CLEAR
2409:                         SET PRINTER TO DEFAULT
2410:                         SET DEVICE TO SCREEN
2411:                         MsgErro("Falha ao atualizar emissao do cheque.", "Erro")
2412:                         RETURN
2413:                     ENDIF
2414:                 ENDIF
2415: 
2416:                 WAIT WINDOW "Imprimindo Cheque(s) Selecionado(s)..." NOWAIT
2417:                 SELECT TmpChImp
2418:             ENDSCAN
2419: 
2420:             WAIT CLEAR
2421:             SET PRINTER TO DEFAULT
2422:             SET DEVICE TO SCREEN
2423:             SET CONSOLE ON
2424: 
2425:             IF USED("TmpPar")
2426:                 USE IN TmpPar
2427:             ENDIF
2428:             IF USED("TmpChImp")
2429:                 USE IN TmpChImp
2430:             ENDIF
2431: 
2432:             SET POINT TO (loc_cPoint)

*-- Linhas 2449 a 2497:
2449:                 RETURN
2450:             ENDIF
2451: 
2452:             SELECT CsSigCqChi
2453:             loc_nRecno = RECNO()
2454: 
2455:             IF USED("TmpChi")
2456:                 USE IN TmpChi
2457:             ENDIF
2458: 
2459:             SELECT DISTINCT bancos ;
2460:               FROM CsSigCqChi ;
2461:              WHERE NMarca1s = 1 ;
2462:               INTO CURSOR TmpChi
2463: 
2464:             SELECT TmpChi
2465:             GO TOP
2466: 
2467:             IF !EOF()
2468:                 IF RECCOUNT("TmpChi") > 1
2469:                     MsgAviso("Todos os cheques selecionados devem ser do mesmo banco.", "Aten" + CHR(231) + CHR(227) + "o")
2470:                     SELECT CsSigCqChi
2471:                     GOTO loc_nRecno
2472:                     THIS.grd_4c_Dados.SetFocus
2473:                     RETURN
2474:                 ENDIF
2475: 
2476:                 SELECT bancos, valors, ncheques, datas, NEmitidos, NCancelas, favos ;
2477:                   FROM CsSigCqChi ;
2478:                  WHERE NMarca1s = 1 ;
2479:                  ORDER BY bancos, ncheques ;
2480:                   INTO CURSOR CrCheque
2481: 
2482:                 SELECT CrCheque
2483:                 LOCATE FOR NEmitidos = 1
2484:                 IF FOUND()
2485:                     IF MsgConfirma("Os cheques selecionados j" + CHR(225) + " foram emitidos. " + ;
2486:                                    "Confirma impress" + CHR(227) + "o?", ;
2487:                                    "Aten" + CHR(231) + CHR(227) + "o")
2488:                         MsgAviso("Verifique se a impressora est" + CHR(225) + ;
2489:                                  " pronta para impress" + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
2490:                     ELSE
2491:                         IF USED("CrCheque")
2492:                             USE IN CrCheque
2493:                         ENDIF
2494:                         RETURN
2495:                     ENDIF
2496:                 ELSE
2497:                     MsgAviso("Verifique se a impressora est" + CHR(225) + ;

*-- Linhas 2504 a 2545:
2504: 
2505:                 PUBLIC xImpOk
2506:                 IF TYPE("xImpOk") = "L" AND xImpOk
2507:                     SELECT CrCheque
2508:                     GO TOP
2509:                     SCAN
2510:                         PRIVATE pBancos2, pNCheques2
2511:                         pBancos2   = CrCheque.bancos
2512:                         pNCheques2 = CrCheque.ncheques
2513:                         loc_cSQL   = "UPDATE SigCqChi SET emitidos = 1" + ;
2514:                                      " WHERE bancos = ?pBancos2 AND ncheques = ?pNCheques2"
2515:                         loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL)
2516:                         IF loc_nQueryOk < 1
2517:                             MsgErro("Falha ao atualizar emissao.", "Erro")
2518:                             RETURN
2519:                         ENDIF
2520:                         UPDATE CsSigCqChi SET NEmitidos = 1 ;
2521:                           WHERE bancos = CrCheque.bancos AND ncheques = CrCheque.ncheques
2522:                         SELECT CrCheque
2523:                     ENDSCAN
2524:                     THIS.this_oBusinessObject.Commit()
2525:                 ENDIF
2526: 
2527:                 IF USED("CrCheque")
2528:                     USE IN CrCheque
2529:                 ENDIF
2530:                 SELECT CsSigCqChi
2531:                 GOTO loc_nRecno
2532:                 THIS.grd_4c_Dados.Refresh
2533:             ELSE
2534:                 *-- Nenhum cheque marcado: abrir painel de faixa matricial
2535:                 THIS.this_lChMatIni = .T.
2536:                 THIS.AtivarImpChmat()
2537:             ENDIF
2538: 
2539:             IF USED("TmpChi")
2540:                 USE IN TmpChi
2541:             ENDIF
2542: 
2543:         CATCH TO loc_oErro
2544:             MsgErro(loc_oErro.Message, "Erro em Chq. Matric.")
2545:         ENDTRY

*-- Linhas 2579 a 2603:
2579: 
2580:                 PRIVATE pCidChaveDel
2581:                 pCidChaveDel = CsSigCqChi.cidchaves
2582:                 loc_cSQL     = "DELETE FROM SigCqChi WHERE cidchaves = ?pCidChaveDel"
2583:                 loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL)
2584: 
2585:                 IF loc_nQueryOk >= 1
2586:                     THIS.this_oBusinessObject.Commit()
2587:                     SELECT CsSigCqChi
2588:                     DELETE
2589:                     THIS.grd_4c_Dados.Refresh
2590:                 ELSE
2591:                     MsgErro("Falha ao excluir cheque.", "Erro")
2592:                 ENDIF
2593:             ENDIF
2594:         ENDIF
2595:     ENDPROC
2596: 
2597:     *==========================================================================
2598:     *  Handlers dos campos de filtro
2599:     *==========================================================================
2600: 
2601:     *-- CdGrupos: salva valor ao entrar
2602:     PROCEDURE CdGruposGotFocus()
2603:         THIS.this_cAntCdGrupo = ALLTRIM(THIS.txt_4c_CdGrupos.Value)

*-- Linhas 2619 a 2638:
2619:             IF USED("cursor_4c_GrupoValida")
2620:                 USE IN cursor_4c_GrupoValida
2621:             ENDIF
2622:             loc_nQueryOk = SQLEXEC(gnConnHandle, ;
2623:                 "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = ?pGrupoVal", ;
2624:                 "cursor_4c_GrupoValida")
2625:             IF loc_nQueryOk >= 1 AND !EOF("cursor_4c_GrupoValida")
2626:                 THIS.txt_4c_DsGrupos.Value = ALLTRIM(cursor_4c_GrupoValida.Descrs)
2627:                 USE IN cursor_4c_GrupoValida
2628:             ELSE
2629:                 IF USED("cursor_4c_GrupoValida")
2630:                     USE IN cursor_4c_GrupoValida
2631:                 ENDIF
2632:                 MsgAviso("Grupo n" + CHR(227) + "o encontrado!", "")
2633:                 THIS.txt_4c_CdGrupos.Value = ""
2634:                 THIS.txt_4c_DsGrupos.Value = ""
2635:             ENDIF
2636:         ELSE
2637:             THIS.txt_4c_DsGrupos.Value = ""
2638:         ENDIF

*-- Linhas 2669 a 2688:
2669:             IF USED("cursor_4c_GrupoValida")
2670:                 USE IN cursor_4c_GrupoValida
2671:             ENDIF
2672:             loc_nQueryOk = SQLEXEC(gnConnHandle, ;
2673:                 "SELECT Codigos, Descrs FROM SigCdGcr WHERE Descrs LIKE ?pGrupoDesc + '%'", ;
2674:                 "cursor_4c_GrupoValida")
2675:             IF loc_nQueryOk >= 1 AND !EOF("cursor_4c_GrupoValida")
2676:                 THIS.txt_4c_CdGrupos.Value = ALLTRIM(cursor_4c_GrupoValida.Codigos)
2677:                 THIS.txt_4c_DsGrupos.Value = ALLTRIM(cursor_4c_GrupoValida.Descrs)
2678:                 USE IN cursor_4c_GrupoValida
2679:             ELSE
2680:                 IF USED("cursor_4c_GrupoValida")
2681:                     USE IN cursor_4c_GrupoValida
2682:                 ENDIF
2683:                 MsgAviso("Grupo n" + CHR(227) + "o encontrado!", "")
2684:                 THIS.txt_4c_CdGrupos.Value = ""
2685:                 THIS.txt_4c_DsGrupos.Value = ""
2686:             ENDIF
2687:         ELSE
2688:             THIS.txt_4c_CdGrupos.Value = ""

*-- Linhas 2820 a 2853:
2820:             RETURN
2821:         ENDIF
2822:         loc_nRecno = RECNO("CsSigCqChi")
2823:         UPDATE CsSigCqChi SET NMarca1s = 0 WHERE NMarca1s = 1
2824:         IF BETWEEN(loc_nRecno, 1, RECCOUNT("CsSigCqChi"))
2825:             GOTO loc_nRecno IN CsSigCqChi
2826:         ENDIF
2827:         THIS.grd_4c_Dados.Refresh
2828:     ENDPROC
2829: 
2830:     *-- Botao Marcar Todos
2831:     PROCEDURE CmdTudo1Click()
2832:         LOCAL loc_nRecno
2833: 
2834:         IF !USED("CsSigCqChi")
2835:             RETURN
2836:         ENDIF
2837:         loc_nRecno = RECNO("CsSigCqChi")
2838:         UPDATE CsSigCqChi SET NMarca1s = 1 WHERE NMarca1s = 0 AND NEmitidos = 0 AND NCancelas = 0
2839:         IF BETWEEN(loc_nRecno, 1, RECCOUNT("CsSigCqChi"))
2840:             GOTO loc_nRecno IN CsSigCqChi
2841:         ENDIF
2842:         THIS.grd_4c_Dados.Refresh
2843:     ENDPROC
2844: 
2845:     *-- Botao Processar
2846:     PROCEDURE Command2Click()
2847:         IF THIS.txt_4c_Dt_inicial.Value > THIS.txt_4c_Dt_final.Value
2848:             MsgAviso("Data Final menor que Data Inicial !!!", "Per" + CHR(237) + "odo Inv" + CHR(225) + "lido")
2849:             THIS.txt_4c_Dt_inicial.SetFocus
2850:             RETURN
2851:         ENDIF
2852: 
2853:         IF THIS.this_dAntDtIni <> THIS.txt_4c_Dt_inicial.Value OR ;

*-- Linhas 2993 a 3051:
2993:             pChIniFil = loc_cChIni
2994:             pChFinFil = loc_cChFin
2995: 
2996:             SELECT bancos, valors, ncheques, datas, favos, NEmitidos ;
2997:               FROM CsSigCqChi ;
2998:              WHERE bancos = ?pBancoFil ;
2999:                AND ncheques BETWEEN ?pChIniFil AND ?pChFinFil ;
3000:                AND NCancelas = 0 ;
3001:              ORDER BY bancos, ncheques ;
3002:               INTO CURSOR CrCheque
3003: 
3004:             SELECT CrCheque
3005:             LOCATE FOR NEmitidos = 1
3006:             IF FOUND()
3007:                 IF !MsgConfirma("Os cheques selecionados j" + CHR(225) + " foram emitidos. " + ;
3008:                                 "Confirma impress" + CHR(227) + "o?", ;
3009:                                 "Aten" + CHR(231) + CHR(227) + "o")
3010:                     USE IN CrCheque
3011:                     RETURN
3012:                 ENDIF
3013:             ENDIF
3014: 
3015:             GO TOP
3016:             MsgAviso("Verificar se a impressora est" + CHR(225) + ;
3017:                      " pronta para impress" + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
3018: 
3019:             DO SigIpChq.prg
3020: 
3021:             PUBLIC xImpOk
3022:             IF TYPE("xImpOk") = "L" AND xImpOk
3023:                 LOCAL loc_cSQL, loc_nQueryOk
3024:                 SELECT CrCheque
3025:                 SCAN
3026:                     PRIVATE pBancoUpd, pNChequeUpd
3027:                     pBancoUpd   = CrCheque.bancos
3028:                     pNChequeUpd = CrCheque.ncheques
3029:                     loc_cSQL = "UPDATE SigCqChi SET emitidos = 1" + ;
3030:                                " WHERE bancos = ?pBancoUpd AND ncheques = ?pNChequeUpd"
3031:                     loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL)
3032:                     IF loc_nQueryOk < 1
3033:                         MsgErro("Falha ao atualizar emissao.", "Erro")
3034:                         EXIT
3035:                     ENDIF
3036:                     SELECT CrCheque
3037:                 ENDSCAN
3038:             ENDIF
3039: 
3040:             IF USED("CrCheque")
3041:                 USE IN CrCheque
3042:             ENDIF
3043: 
3044:         CATCH TO loc_oErro
3045:             MsgErro(loc_oErro.Message, "Erro na impressao matricial")
3046:         ENDTRY
3047:     ENDPROC
3048: 
3049:     PROCEDURE ImpchmatEncerrarClick()
3050:         THIS.LockScreen = .T.
3051:         THIS.obj_4c_CmdGok.Enabled   = .T.

*-- Linhas 3118 a 3136:
3118:         loc_nValor   = THIS.cnt_4c_Procurar.txt_4c_Valor.Value
3119: 
3120:         SET NEAR ON
3121:         SELECT CsSigCqChi
3122: 
3123:         DO CASE
3124:         CASE !EMPTY(loc_dEmissao) AND VARTYPE(loc_dEmissao) = "D"
3125:             SET ORDER TO Emissao
3126:             SEEK DTOS(loc_dEmissao) + loc_cBanco + loc_cAgencia + loc_cConta + loc_cCheque
3127:         CASE loc_nValor <> 0
3128:             SET ORDER TO Valor
3129:             SEEK STR(loc_nValor, 12, 2) + loc_cBanco + loc_cAgencia + loc_cConta + loc_cCheque
3130:         CASE !EMPTY(loc_cBanco)
3131:             SET ORDER TO Cheque
3132:             SEEK loc_cBanco + loc_cAgencia + loc_cConta + loc_cCheque
3133:         CASE !EMPTY(loc_cAgencia)
3134:             SET ORDER TO Agencia
3135:             SEEK loc_cAgencia + loc_cConta + loc_cCheque
3136:         CASE !EMPTY(loc_cConta)

*-- Linhas 3296 a 3323:
3296: 
3297:                 PRIVATE pCidChaveDel
3298:                 pCidChaveDel = CsSigCqChi.cidchaves
3299:                 loc_cSQL     = "DELETE FROM SigCqChi WHERE cidchaves = ?pCidChaveDel"
3300:                 loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL)
3301: 
3302:                 IF loc_nQueryOk >= 1
3303:                     THIS.this_oBusinessObject.Commit()
3304:                     loc_cMensa = "Exclus" + CHR(227) + "o do cheque cancelado: " + ;
3305:                                  CsSigCqChi.bancos + "/" + CsSigCqChi.agencias + ;
3306:                                  "/" + CsSigCqChi.ncontas + "/" + CsSigCqChi.ncheques
3307:                     SELECT CsSigCqChi
3308:                     DELETE
3309:                     THIS.grd_4c_Dados.Refresh
3310:                     MsgInfo("Cheque exclu" + CHR(237) + "do com sucesso.", ;
3311:                             "Exclus" + CHR(227) + "o")
3312:                 ELSE
3313:                     MsgErro("Falha ao excluir cheque.", "Erro")
3314:                 ENDIF
3315:             ENDIF
3316:         CATCH TO loc_oErro
3317:             MsgErro(loc_oErro.Message, "Erro em Excluir")
3318:         ENDTRY
3319:     ENDPROC
3320: 
3321:     *==========================================================================
3322:     *  FASE 8/8 - Metodos auxiliares e consolidacao final
3323:     *==========================================================================

