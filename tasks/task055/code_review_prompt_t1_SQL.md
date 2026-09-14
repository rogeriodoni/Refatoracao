# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: MARCA, CEMPS, PRODUC, EMPS, CODOBS, SERVICOS, CITENS, EMPDOPNUMS, MERCS, CGRUS, SGRUS, MATS, CODTAMS, ORDTS, CPROS, NOPS, CODCORS, EMPDNPS, QTDS, PESOS

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
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
		lcQuery = [Select TpInstalas ] + ;
				    [From SigCdPam]
		If (.poDataMgr.SqlExecute(lcQuery, 'crSigCdPam') < 1)
		Select CrSigCdPam
		lcSQLCmd = [Select Codigos, Descrs From SigCdTom]
		If (ThisForm.poDataMgr.SQLExecute(lcSQLCmd, 'crSigCdTom') < 1)
		Select crSigCdTom
			Insert Into Cs_SigCdTom (Marca,Codigos,Descri) ;
		Select cs_SigCdTom
Select cs_SigCdTom
Insert Into dbCabecalho (NomeEmpresa, Titulo, Periodo, SubTitulo) ;
lcQuery = [Select Cemps, Razas ] + ;
		    [From SigCdEmp ] + Iif(Empty(lcEmpresa), [], [ Where Cemps = '] + lcEmpresa + ['])
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrSigCdEmp') < 1)
Select cs_SigCdTom
lStrQuery = [Select a.Emps, a.Dopes, a.Numes, a.Datas, a.GrupoOs, a.ContaOs, a.GrupoDs, a.ContaDs, a.EmpDopNums, a.Nops, b.Globalizas, b.Servicos ]+;
			[From SigMvCab a Inner Join SigCdOpe b On a.Dopes = b.Dopes Where ] +;
If (ThisForm.poDataMgr.SqlExecute(lStrQuery, 'CrSigMvCab') < 1)
Select CrSigMvCab
Select CrSigCdEmp
	oProg.Update(.T.,'Empresa: ' + CrSigCdEmp.CEmps)
	Select CrSigMvCab
	If Seek(lcEmpPro,'CrSigMvCab','EmpDopNums')
			oProg2.Update(.T.)
			lStrQuery = [Select a.mats, a.CPros, a.Pesos, a.Qtds, a.QtBaixas,b.Dpros as Dmats,b.CGrus,b.CUnis,b.PesoMs,b.CustoFs, b.Reffs as RefMats, ] +;
						[From SigSubMv a Inner Join SigCdPro e On e.Cpros = a.Cpros ] +;
						[Inner Join SigMvItn f On f.empdopnums = a.empdopnums and f.citens = a.citem2 ] +;
						[Inner Join SigCdPro b On b.CPros = a.mats ] +;
						[Left Join SigCdGrp c On c.CGrus = b.CGrus ] +;
						[Left Join SigCdUni d On d.CUnis = b.CUnis ] +;
						[Left Join SigMvIts g On g.EmpDopNums = f.EmpDopNums And g.Citens = f.Citens ] +;
						[Select a.mats, a.CPros, ] +;
						[From SigMvItn e Left Join SigMvIts g On e.EmpDopNums = g.EmpDopNums And e.Citens = g.Citens ] +;
						[Inner Join SigPrCpo a On e.cpros = a.cpros ] +;
						[Left Join SigSubCp h On a.Cpros = h.Cpros and a.Mats = h.Mats And h.CodTams = g.CodTams ] +;
						[Inner Join SigCdPro f On e.Cpros = f.Cpros ] +;
						[Inner Join SigCdPro b On b.CPros = a.mats ] +;
						[Left Join SigCdGrp c On c.CGrus = b.CGrus ] +;
						[Left Join SigCdUni d On d.CUnis = b.CUnis ] +;
						[and e.citens not in (Select e.citens ] +;
						[From SigMvItn e, SigSubMv a ] +;
			If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CrSigMvItn') < 1
			Select CrSigMvItn
				lcQuery = [Select a.Nops, a.cpros, a.Emps, a.empdopnops, a.EmpDopNums, Sum(a.qtds) as Qtds, a.codcors, a.CodTams, b.descs as desccors, a.citens ] + ;
						    [From SigOpPic a left join SigCdCor b on a.codcors = b.cods ] + ;
				If ThisForm.poDataMgr.SqlExecute(lcQuery,'CrSigOpPic') < 1
				Select crSigOpPic
			Select CrSigMvItn
					Select crSigOpPic
					=Seek(Str(CrSigMvItn.Citens,4) + CrSigMvItn.Cpros + CrSigMvItn.CodCors + CrSigMvItn.CodTams + CrSigMvItn.EmpDopNums,'crSigOpPic','CproNop2')
							lcSql = [Select ChkSubn From SigCdNec Where EmpDnPs = ']+CrSigOpPic.EmpdopNops+[']
							ThisForm.PodataMgr.SqlExecute(lcSql,'TmpNens')
							Select TmpNens
						If Not Seek(CrSigMvItn.Cpros + Padr(lcNop, 10) + CrSigMvItn.Mats + CrSigMvItn.Reffs, [TmpRelat], [CproMatRef])
							Insert Into TmpRelat (Grupo,Conta,Emps,Razas,CGrus,DGrus,CPros,DPros,Cunis,Pesoms,reffs,Mats,Dmats,;
					Select TmpRelat
					If Not Seek(CrSigMvItn.Cpros + Space(10) + CrSigMvItn.Mats + CrSigMvItn.Reffs, [TmpRelat], [CproMatRef])					
						Insert Into TmpRelat (Grupo,Conta,Emps,Razas,CGrus,DGrus,CPros,DPros,Cunis,Pesoms,reffs,Mats,Dmats,;
				Select CrSigMvItn
			Select CrSigMvCab
	Select CrSigCdEmp
Delete From TmpRelat where Qtds <= 0 And Pesos <= 0
Select dbCabecalho
Select UniCompos, Sum(Qtds) as Qtds, CUniPs, Sum(Pesos) as Pesos ;
  From TmpRelat ;
Select crTotFims
Select TmpRelat
	Select cs_SigCdTom

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReCmp.prg) - TRECHOS RELEVANTES PARA PASS SQL (2710 linhas total):

*-- Linhas 288 a 306:
288:                 ELSE
289:                     *-- Modo validacao UI: criar cursor vazio para o grid funcionar
290:                     IF !USED("cursor_4c_TipoMov")
291:                         CREATE CURSOR cursor_4c_TipoMov ;
292:                             (Marca N(1), Descri C(40), Codigos N(2))
293:                     ENDIF
294:                 ENDIF
295:             ENDIF
296: 
297:             *-- ===== ROW 1: PERIODO =====
298:             loc_oPagina.AddObject("lbl_4c_Lbl_periodo", "Label")
299:             WITH loc_oPagina.lbl_4c_Lbl_periodo
300:                 .Top       = 38
301:                 .Left      = 55
302:                 .Width     = 45
303:                 .Height    = 18
304:                 .Caption   = "Per" + CHR(237) + "odo :"
305:                 .FontName  = "Tahoma"
306:                 .FontSize  = 8

*-- Linhas 733 a 772:
733:                 .HighlightBackColor = RGB(255, 255, 255)
734:                 .HighlightForeColor = RGB(15, 41, 104)
735:                 .HighlightStyle     = 2
736:                 .DeleteMark         = .F.
737:                 .RecordMark         = .F.
738:                 .RowHeight          = 16
739:                 .ScrollBars         = 2
740:                 .Themes             = .F.
741: 
742:                 *-- Column1: CheckBox para Marca (campo booleano de selecao)
743:                 WITH .Column1
744:                     .Width = 25
745:                     .Header1.Caption = ""
746:                     .AddObject("Check1", "CheckBox")
747:                     .Check1.Caption = ""
748:                     .Check1.Value = 0
749:                     .CurrentControl = "Check1"
750:                     .ControlSource = "cursor_4c_TipoMov.Marca"
751:                     .Visible = .T.
752:                 ENDWITH
753: 
754:                 *-- Column2: Descricao do tipo de movimentacao
755:                 WITH .Column2
756:                     .Width = 224
757:                     .ControlSource = "cursor_4c_TipoMov.Descri"
758:                     .ReadOnly = .T.
759:                     .Header1.Caption = "Tipo"
760:                     .Visible = .T.
761:                 ENDWITH
762: 
763:                 .Visible = .T.
764:             ENDWITH
765: 
766:             *-- Botoes SelTudo / Apaga (direita do grid)
767:             loc_oPagina.AddObject("cmd_4c_SelTudo", "CommandButton")
768:             WITH loc_oPagina.cmd_4c_SelTudo
769:                 .Top          = 186
770:                 .Left         = 763
771:                 .Width        = 35
772:                 .Height       = 34

*-- Linhas 1531 a 1549:
1531:                         IF USED("TmpRelat") AND RECCOUNT("TmpRelat") > 0
1532:                             loc_cArquivo = ADDBS(SYS(2023)) + "SigReCmp_" + ;
1533:                                 DTOS(DATE()) + "_" + STRTRAN(TIME(), ":", "") + ".xls"
1534:                             SELECT TmpRelat
1535:                             COPY TO (loc_cArquivo) TYPE XLS
1536:                             IF FILE(loc_cArquivo)
1537:                                 DECLARE INTEGER ShellExecute IN shell32.dll ;
1538:                                     INTEGER hndWin, STRING cAction, STRING cFileName, ;
1539:                                     STRING cParams, STRING cDir, INTEGER nShowWin
1540:                                 ShellExecute(0, "open", loc_cArquivo, "", "", 1)
1541:                                 MsgInfo("Arquivo exportado para:" + CHR(13) + loc_cArquivo)
1542:                             ELSE
1543:                                 MsgErro("Erro ao exportar para Excel.", "Erro")
1544:                             ENDIF
1545:                         ELSE
1546:                             MsgAviso("Sem dados para exportar.", "Aviso")
1547:                         ENDIF
1548:                     ELSE
1549:                         MsgErro("Erro ao processar relat" + CHR(243) + "rio:" + CHR(13) + ;

*-- Linhas 1739 a 1761:
1739:             ENDIF
1740:             RETURN
1741:         ENDIF
1742:         loc_cSQL = "SELECT Dopes, Descrs FROM SigCdOpe WHERE Dopes = " + ;
1743:                    EscaparSQL(loc_cCod)
1744:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeVal")
1745:         IF loc_nResult > 0
1746:             SELECT cursor_4c_OpeVal
1747:             IF !EOF()
1748:                 IF PEMSTATUS(loc_oPg, "chk_4c_Chkservico", 5)
1749:                     loc_oPg.chk_4c_Chkservico.Enabled = .T.
1750:                 ENDIF
1751:             ELSE
1752:                 IF USED("cursor_4c_OpeVal")
1753:                     USE IN cursor_4c_OpeVal
1754:                 ENDIF
1755:                 THIS.AbrirBuscaOperacao()
1756:                 RETURN
1757:             ENDIF
1758:             IF USED("cursor_4c_OpeVal")
1759:                 USE IN cursor_4c_OpeVal
1760:             ENDIF
1761:         ELSE

*-- Linhas 1776 a 1806:
1776:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1777:                     IF PEMSTATUS(loc_oPg, "txt_4c__operacao", 5) AND ;
1778:                        USED("cursor_4c_BuscaOpe")
1779:                         SELECT cursor_4c_BuscaOpe
1780:                         loc_oPg.txt_4c__operacao.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
1781:                         IF PEMSTATUS(loc_oPg, "chk_4c_Chkservico", 5)
1782:                             loc_oPg.chk_4c_Chkservico.Enabled = .T.
1783:                         ENDIF
1784:                     ENDIF
1785:                 ELSE
1786:                     IF !loc_oBusca.this_lAchouRegistro
1787:                     loc_oBusca.mAddColuna("Dopes",  "", "C" + CHR(243) + "digo")
1788:                     loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1789:                     loc_oBusca.Show()
1790:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
1791:                         SELECT cursor_4c_BuscaOpe
1792:                         IF PEMSTATUS(loc_oPg, "txt_4c__operacao", 5)
1793:                             loc_oPg.txt_4c__operacao.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
1794:                             IF PEMSTATUS(loc_oPg, "chk_4c_Chkservico", 5)
1795:                                 loc_oPg.chk_4c_Chkservico.Enabled = .T.
1796:                             ENDIF
1797:                         ENDIF
1798:                     ENDIF
1799:                     ENDIF
1800:                 ENDIF
1801:                 loc_oBusca.Release()
1802:             ENDIF
1803:             IF USED("cursor_4c_BuscaOpe")
1804:                 USE IN cursor_4c_BuscaOpe
1805:             ENDIF
1806:         CATCH TO loc_oErro

*-- Linhas 1835 a 1857:
1835:             ENDIF
1836:             RETURN
1837:         ENDIF
1838:         loc_cSQL = "SELECT Codigos, Descrs FROM SigCdObs WHERE Codigos = " + ;
1839:                    ALLTRIM(STR(loc_nCod, 3))
1840:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ObsVal")
1841:         IF loc_nResult > 0
1842:             SELECT cursor_4c_ObsVal
1843:             IF !EOF()
1844:                 IF PEMSTATUS(loc_oPg, "txt_4c_DesObs", 5)
1845:                     loc_oPg.txt_4c_DesObs.Value = ALLTRIM(cursor_4c_ObsVal.Descrs)
1846:                     loc_oPg.txt_4c_DesObs.Enabled = .T.
1847:                 ENDIF
1848:             ELSE
1849:                 IF USED("cursor_4c_ObsVal")
1850:                     USE IN cursor_4c_ObsVal
1851:                 ENDIF
1852:                 THIS.AbrirBuscaCodObs()
1853:                 RETURN
1854:             ENDIF
1855:             IF USED("cursor_4c_ObsVal")
1856:                 USE IN cursor_4c_ObsVal
1857:             ENDIF

*-- Linhas 1875 a 1908:
1875:             IF VARTYPE(loc_oBusca) = "O"
1876:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1877:                     IF USED("cursor_4c_BuscaObs")
1878:                         SELECT cursor_4c_BuscaObs
1879:                         IF PEMSTATUS(loc_oPg, "txt_4c_CodObs", 5)
1880:                             loc_oPg.txt_4c_CodObs.Value = cursor_4c_BuscaObs.Codigos
1881:                         ENDIF
1882:                         IF PEMSTATUS(loc_oPg, "txt_4c_DesObs", 5)
1883:                             loc_oPg.txt_4c_DesObs.Value = ALLTRIM(cursor_4c_BuscaObs.Descrs)
1884:                             loc_oPg.txt_4c_DesObs.Enabled = .T.
1885:                         ENDIF
1886:                     ENDIF
1887:                 ELSE
1888:                     IF !loc_oBusca.this_lAchouRegistro
1889:                     loc_oBusca.mAddColuna("Codigos", "XXX", "C" + CHR(243) + "digo")
1890:                     loc_oBusca.mAddColuna("Descrs",  "",    "Descri" + CHR(231) + CHR(227) + "o")
1891:                     loc_oBusca.Show()
1892:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaObs")
1893:                         SELECT cursor_4c_BuscaObs
1894:                         IF PEMSTATUS(loc_oPg, "txt_4c_CodObs", 5)
1895:                             loc_oPg.txt_4c_CodObs.Value = cursor_4c_BuscaObs.Codigos
1896:                         ENDIF
1897:                         IF PEMSTATUS(loc_oPg, "txt_4c_DesObs", 5)
1898:                             loc_oPg.txt_4c_DesObs.Value = ALLTRIM(cursor_4c_BuscaObs.Descrs)
1899:                             loc_oPg.txt_4c_DesObs.Enabled = .T.
1900:                         ENDIF
1901:                     ENDIF
1902:                     ENDIF
1903:                 ENDIF
1904:                 loc_oBusca.Release()
1905:             ENDIF
1906:             IF USED("cursor_4c_BuscaObs")
1907:                 USE IN cursor_4c_BuscaObs
1908:             ENDIF

*-- Linhas 1952 a 1984:
1952:             IF VARTYPE(loc_oBusca) = "O"
1953:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1954:                     IF USED("cursor_4c_BuscaObsD")
1955:                         SELECT cursor_4c_BuscaObsD
1956:                         IF PEMSTATUS(loc_oPg, "txt_4c_CodObs", 5)
1957:                             loc_oPg.txt_4c_CodObs.Value = cursor_4c_BuscaObsD.Codigos
1958:                         ENDIF
1959:                         IF PEMSTATUS(loc_oPg, "txt_4c_DesObs", 5)
1960:                             loc_oPg.txt_4c_DesObs.Value = ALLTRIM(cursor_4c_BuscaObsD.Descrs)
1961:                         ENDIF
1962:                     ENDIF
1963:                 ELSE
1964:                     IF !loc_oBusca.this_lAchouRegistro
1965:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1966:                     loc_oBusca.mAddColuna("Codigos", "XXX", "C" + CHR(243) + "digo")
1967:                     loc_oBusca.Show()
1968:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaObsD")
1969:                         SELECT cursor_4c_BuscaObsD
1970:                         IF PEMSTATUS(loc_oPg, "txt_4c_CodObs", 5)
1971:                             loc_oPg.txt_4c_CodObs.Value = cursor_4c_BuscaObsD.Codigos
1972:                         ENDIF
1973:                         IF PEMSTATUS(loc_oPg, "txt_4c_DesObs", 5)
1974:                             loc_oPg.txt_4c_DesObs.Value = ALLTRIM(cursor_4c_BuscaObsD.Descrs)
1975:                         ENDIF
1976:                     ENDIF
1977:                     ENDIF
1978:                 ENDIF
1979:                 loc_oBusca.Release()
1980:             ENDIF
1981:             IF USED("cursor_4c_BuscaObsD")
1982:                 USE IN cursor_4c_BuscaObsD
1983:             ENDIF
1984:         CATCH TO loc_oErro

*-- Linhas 2013 a 2035:
2013:             ENDIF
2014:             RETURN
2015:         ENDIF
2016:         loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
2017:                    EscaparSQL(loc_cCod)
2018:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
2019:         IF loc_nResult > 0
2020:             SELECT cursor_4c_EmpVal
2021:             IF !EOF()
2022:                 IF PEMSTATUS(loc_oPg, "txt_4c__empresa_desc", 5)
2023:                     loc_oPg.txt_4c__empresa_desc.Value = ALLTRIM(cursor_4c_EmpVal.Razas)
2024:                     loc_oPg.txt_4c__empresa_desc.Enabled = .T.
2025:                 ENDIF
2026:             ELSE
2027:                 IF USED("cursor_4c_EmpVal")
2028:                     USE IN cursor_4c_EmpVal
2029:                 ENDIF
2030:                 THIS.AbrirBuscaEmpresa()
2031:                 RETURN
2032:             ENDIF
2033:             IF USED("cursor_4c_EmpVal")
2034:                 USE IN cursor_4c_EmpVal
2035:             ENDIF

*-- Linhas 2049 a 2082:
2049:             IF VARTYPE(loc_oBusca) = "O"
2050:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2051:                     IF USED("cursor_4c_BuscaEmp")
2052:                         SELECT cursor_4c_BuscaEmp
2053:                         IF PEMSTATUS(loc_oPg, "txt_4c__empresa", 5)
2054:                             loc_oPg.txt_4c__empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
2055:                         ENDIF
2056:                         IF PEMSTATUS(loc_oPg, "txt_4c__empresa_desc", 5)
2057:                             loc_oPg.txt_4c__empresa_desc.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
2058:                             loc_oPg.txt_4c__empresa_desc.Enabled = .T.
2059:                         ENDIF
2060:                     ENDIF
2061:                 ELSE
2062:                     IF !loc_oBusca.this_lAchouRegistro
2063:                     loc_oBusca.mAddColuna("Cemps", "XXX", "C" + CHR(243) + "digo")
2064:                     loc_oBusca.mAddColuna("Razas", "",    "Raz" + CHR(227) + "o Social")
2065:                     loc_oBusca.Show()
2066:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
2067:                         SELECT cursor_4c_BuscaEmp
2068:                         IF PEMSTATUS(loc_oPg, "txt_4c__empresa", 5)
2069:                             loc_oPg.txt_4c__empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
2070:                         ENDIF
2071:                         IF PEMSTATUS(loc_oPg, "txt_4c__empresa_desc", 5)
2072:                             loc_oPg.txt_4c__empresa_desc.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
2073:                             loc_oPg.txt_4c__empresa_desc.Enabled = .T.
2074:                         ENDIF
2075:                     ENDIF
2076:                     ENDIF
2077:                 ENDIF
2078:                 loc_oBusca.Release()
2079:             ENDIF
2080:             IF USED("cursor_4c_BuscaEmp")
2081:                 USE IN cursor_4c_BuscaEmp
2082:             ENDIF

*-- Linhas 2148 a 2170:
2148:             ENDIF
2149:             RETURN
2150:         ENDIF
2151:         loc_cSQL = "SELECT codigos, descs FROM SigCdGpr " + ;
2152:                    "WHERE CAST(codigos AS VARCHAR(5)) = " + EscaparSQL(loc_cCod)
2153:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GGruVal")
2154:         IF loc_nResult > 0
2155:             SELECT cursor_4c_GGruVal
2156:             IF !EOF()
2157:                 IF PEMSTATUS(loc_oPg, "txt_4c__cd_ggrupo", 5)
2158:                     loc_oPg.txt_4c__cd_ggrupo.Value = ;
2159:                         ALLTRIM(STR(cursor_4c_GGruVal.codigos, 2))
2160:                 ENDIF
2161:                 IF PEMSTATUS(loc_oPg, "txt_4c__ds_ggrupo", 5)
2162:                     loc_oPg.txt_4c__ds_ggrupo.Value = ALLTRIM(cursor_4c_GGruVal.descs)
2163:                     loc_oPg.txt_4c__ds_ggrupo.Enabled = .T.
2164:                 ENDIF
2165:             ELSE
2166:                 IF USED("cursor_4c_GGruVal")
2167:                     USE IN cursor_4c_GGruVal
2168:                 ENDIF
2169:                 THIS.AbrirBuscaGrdGrupo()
2170:                 RETURN

*-- Linhas 2189 a 2223:
2189:             IF VARTYPE(loc_oBusca) = "O"
2190:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2191:                     IF USED("cursor_4c_BuscaGGru")
2192:                         SELECT cursor_4c_BuscaGGru
2193:                         IF PEMSTATUS(loc_oPg, "txt_4c__cd_ggrupo", 5)
2194:                             loc_oPg.txt_4c__cd_ggrupo.Value = ;
2195:                                 ALLTRIM(STR(cursor_4c_BuscaGGru.codigos, 2))
2196:                         ENDIF
2197:                         IF PEMSTATUS(loc_oPg, "txt_4c__ds_ggrupo", 5)
2198:                             loc_oPg.txt_4c__ds_ggrupo.Value = ALLTRIM(cursor_4c_BuscaGGru.descs)
2199:                             loc_oPg.txt_4c__ds_ggrupo.Enabled = .T.
2200:                         ENDIF
2201:                     ENDIF
2202:                 ELSE
2203:                     IF !loc_oBusca.this_lAchouRegistro
2204:                     loc_oBusca.mAddColuna("codigos", "",  "C" + CHR(243) + "digo")
2205:                     loc_oBusca.mAddColuna("descs",   "",  "Descri" + CHR(231) + CHR(227) + "o")
2206:                     loc_oBusca.Show()
2207:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGGru")
2208:                         SELECT cursor_4c_BuscaGGru
2209:                         IF PEMSTATUS(loc_oPg, "txt_4c__cd_ggrupo", 5)
2210:                             loc_oPg.txt_4c__cd_ggrupo.Value = ;
2211:                                 ALLTRIM(STR(cursor_4c_BuscaGGru.codigos, 2))
2212:                         ENDIF
2213:                         IF PEMSTATUS(loc_oPg, "txt_4c__ds_ggrupo", 5)
2214:                             loc_oPg.txt_4c__ds_ggrupo.Value = ALLTRIM(cursor_4c_BuscaGGru.descs)
2215:                             loc_oPg.txt_4c__ds_ggrupo.Enabled = .T.
2216:                         ENDIF
2217:                     ENDIF
2218:                     ENDIF
2219:                 ENDIF
2220:                 loc_oBusca.Release()
2221:             ENDIF
2222:             IF USED("cursor_4c_BuscaGGru")
2223:                 USE IN cursor_4c_BuscaGGru

*-- Linhas 2264 a 2298:
2264:                 IF VARTYPE(loc_oBusca) = "O"
2265:                     IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2266:                         IF USED("cursor_4c_BuscaGGruD")
2267:                             SELECT cursor_4c_BuscaGGruD
2268:                             IF PEMSTATUS(loc_oPg, "txt_4c__cd_ggrupo", 5)
2269:                                 loc_oPg.txt_4c__cd_ggrupo.Value = ;
2270:                                     ALLTRIM(STR(cursor_4c_BuscaGGruD.codigos, 2))
2271:                             ENDIF
2272:                             IF PEMSTATUS(loc_oPg, "txt_4c__ds_ggrupo", 5)
2273:                                 loc_oPg.txt_4c__ds_ggrupo.Value = ;
2274:                                     ALLTRIM(cursor_4c_BuscaGGruD.descs)
2275:                             ENDIF
2276:                         ENDIF
2277:                     ELSE
2278:                         IF !loc_oBusca.this_lAchouRegistro
2279:                         loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
2280:                         loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
2281:                         loc_oBusca.Show()
2282:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGGruD")
2283:                             SELECT cursor_4c_BuscaGGruD
2284:                             IF PEMSTATUS(loc_oPg, "txt_4c__cd_ggrupo", 5)
2285:                                 loc_oPg.txt_4c__cd_ggrupo.Value = ;
2286:                                     ALLTRIM(STR(cursor_4c_BuscaGGruD.codigos, 2))
2287:                             ENDIF
2288:                             IF PEMSTATUS(loc_oPg, "txt_4c__ds_ggrupo", 5)
2289:                                 loc_oPg.txt_4c__ds_ggrupo.Value = ;
2290:                                     ALLTRIM(cursor_4c_BuscaGGruD.descs)
2291:                             ENDIF
2292:                         ENDIF
2293:                         ENDIF
2294:                     ENDIF
2295:                     loc_oBusca.Release()
2296:                 ENDIF
2297:                 IF USED("cursor_4c_BuscaGGruD")
2298:                     USE IN cursor_4c_BuscaGGruD

*-- Linhas 2330 a 2352:
2330:             ENDIF
2331:             RETURN
2332:         ENDIF
2333:         loc_cSQL = "SELECT CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + ;
2334:                    EscaparSQL(loc_cCod)
2335:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruVal")
2336:         IF loc_nResult > 0
2337:             SELECT cursor_4c_GruVal
2338:             IF !EOF()
2339:                 IF PEMSTATUS(loc_oPg, "txt_4c__grupo_desc", 5)
2340:                     loc_oPg.txt_4c__grupo_desc.Value = ALLTRIM(cursor_4c_GruVal.DGrus)
2341:                     loc_oPg.txt_4c__grupo_desc.Enabled = .T.
2342:                 ENDIF
2343:             ELSE
2344:                 IF USED("cursor_4c_GruVal")
2345:                     USE IN cursor_4c_GruVal
2346:                 ENDIF
2347:                 THIS.AbrirBuscaGrupo()
2348:                 RETURN
2349:             ENDIF
2350:             IF USED("cursor_4c_GruVal")
2351:                 USE IN cursor_4c_GruVal
2352:             ENDIF

*-- Linhas 2367 a 2400:
2367:             IF VARTYPE(loc_oBusca) = "O"
2368:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2369:                     IF USED("cursor_4c_BuscaGru")
2370:                         SELECT cursor_4c_BuscaGru
2371:                         IF PEMSTATUS(loc_oPg, "txt_4c__grupo", 5)
2372:                             loc_oPg.txt_4c__grupo.Value = ALLTRIM(cursor_4c_BuscaGru.CGrus)
2373:                         ENDIF
2374:                         IF PEMSTATUS(loc_oPg, "txt_4c__grupo_desc", 5)
2375:                             loc_oPg.txt_4c__grupo_desc.Value = ALLTRIM(cursor_4c_BuscaGru.DGrus)
2376:                             loc_oPg.txt_4c__grupo_desc.Enabled = .T.
2377:                         ENDIF
2378:                     ENDIF
2379:                 ELSE
2380:                     IF !loc_oBusca.this_lAchouRegistro
2381:                     loc_oBusca.mAddColuna("CGrus", "XXX", "C" + CHR(243) + "digo")
2382:                     loc_oBusca.mAddColuna("DGrus", "",    "Descri" + CHR(231) + CHR(227) + "o")
2383:                     loc_oBusca.Show()
2384:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGru")
2385:                         SELECT cursor_4c_BuscaGru
2386:                         IF PEMSTATUS(loc_oPg, "txt_4c__grupo", 5)
2387:                             loc_oPg.txt_4c__grupo.Value = ALLTRIM(cursor_4c_BuscaGru.CGrus)
2388:                         ENDIF
2389:                         IF PEMSTATUS(loc_oPg, "txt_4c__grupo_desc", 5)
2390:                             loc_oPg.txt_4c__grupo_desc.Value = ALLTRIM(cursor_4c_BuscaGru.DGrus)
2391:                             loc_oPg.txt_4c__grupo_desc.Enabled = .T.
2392:                         ENDIF
2393:                     ENDIF
2394:                     ENDIF
2395:                 ENDIF
2396:                 loc_oBusca.Release()
2397:             ENDIF
2398:             IF USED("cursor_4c_BuscaGru")
2399:                 USE IN cursor_4c_BuscaGru
2400:             ENDIF

*-- Linhas 2436 a 2468:
2436:                 IF VARTYPE(loc_oBusca) = "O"
2437:                     IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2438:                         IF USED("cursor_4c_BuscaGruD")
2439:                             SELECT cursor_4c_BuscaGruD
2440:                             IF PEMSTATUS(loc_oPg, "txt_4c__grupo", 5)
2441:                                 loc_oPg.txt_4c__grupo.Value = ALLTRIM(cursor_4c_BuscaGruD.CGrus)
2442:                             ENDIF
2443:                             IF PEMSTATUS(loc_oPg, "txt_4c__grupo_desc", 5)
2444:                                 loc_oPg.txt_4c__grupo_desc.Value = ALLTRIM(cursor_4c_BuscaGruD.DGrus)
2445:                             ENDIF
2446:                         ENDIF
2447:                     ELSE
2448:                         IF !loc_oBusca.this_lAchouRegistro
2449:                         loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
2450:                         loc_oBusca.mAddColuna("CGrus", "XXX", "C" + CHR(243) + "digo")
2451:                         loc_oBusca.Show()
2452:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGruD")
2453:                             SELECT cursor_4c_BuscaGruD
2454:                             IF PEMSTATUS(loc_oPg, "txt_4c__grupo", 5)
2455:                                 loc_oPg.txt_4c__grupo.Value = ALLTRIM(cursor_4c_BuscaGruD.CGrus)
2456:                             ENDIF
2457:                             IF PEMSTATUS(loc_oPg, "txt_4c__grupo_desc", 5)
2458:                                 loc_oPg.txt_4c__grupo_desc.Value = ALLTRIM(cursor_4c_BuscaGruD.DGrus)
2459:                             ENDIF
2460:                         ENDIF
2461:                         ENDIF
2462:                     ENDIF
2463:                     loc_oBusca.Release()
2464:                 ENDIF
2465:                 IF USED("cursor_4c_BuscaGruD")
2466:                     USE IN cursor_4c_BuscaGruD
2467:                 ENDIF
2468:             ENDIF

*-- Linhas 2498 a 2520:
2498:             ENDIF
2499:             RETURN
2500:         ENDIF
2501:         loc_cSQL = "SELECT Codigos, Descricaos, CGrus FROM SigCdPsg " + ;
2502:                    "WHERE Codigos = " + EscaparSQL(loc_cCod)
2503:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SGruVal")
2504:         IF loc_nResult > 0
2505:             SELECT cursor_4c_SGruVal
2506:             IF !EOF()
2507:                 IF PEMSTATUS(loc_oPg, "txt_4c__cd_sgrupo", 5)
2508:                     loc_oPg.txt_4c__cd_sgrupo.Value = ALLTRIM(cursor_4c_SGruVal.Codigos)
2509:                 ENDIF
2510:                 IF PEMSTATUS(loc_oPg, "txt_4c__ds_sgrupo", 5)
2511:                     loc_oPg.txt_4c__ds_sgrupo.Value = ALLTRIM(cursor_4c_SGruVal.Descricaos)
2512:                     loc_oPg.txt_4c__ds_sgrupo.Enabled = .T.
2513:                 ENDIF
2514:             ELSE
2515:                 IF USED("cursor_4c_SGruVal")
2516:                     USE IN cursor_4c_SGruVal
2517:                 ENDIF
2518:                 THIS.AbrirBuscaSubGrupo()
2519:                 RETURN
2520:             ENDIF

*-- Linhas 2538 a 2575:
2538:             IF VARTYPE(loc_oBusca) = "O"
2539:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2540:                     IF USED("cursor_4c_BuscaSGru")
2541:                         SELECT cursor_4c_BuscaSGru
2542:                         IF PEMSTATUS(loc_oPg, "txt_4c__cd_sgrupo", 5)
2543:                             loc_oPg.txt_4c__cd_sgrupo.Value = ;
2544:                                 ALLTRIM(cursor_4c_BuscaSGru.Codigos)
2545:                         ENDIF
2546:                         IF PEMSTATUS(loc_oPg, "txt_4c__ds_sgrupo", 5)
2547:                             loc_oPg.txt_4c__ds_sgrupo.Value = ;
2548:                                 ALLTRIM(cursor_4c_BuscaSGru.Descricaos)
2549:                             loc_oPg.txt_4c__ds_sgrupo.Enabled = .T.
2550:                         ENDIF
2551:                     ENDIF
2552:                 ELSE
2553:                     IF !loc_oBusca.this_lAchouRegistro
2554:                     loc_oBusca.mAddColuna("Codigos",    "XXXXXXXXXX", "Sub-Grupo")
2555:                     loc_oBusca.mAddColuna("Descricaos", "XXXXXXXXXXXXXXXXXXXX", ;
2556:                         "Descri" + CHR(231) + CHR(227) + "o")
2557:                     loc_oBusca.mAddColuna("CGrus", "XXXXXXXXXX", "Grupo")
2558:                     loc_oBusca.Show()
2559:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSGru")
2560:                         SELECT cursor_4c_BuscaSGru
2561:                         IF PEMSTATUS(loc_oPg, "txt_4c__cd_sgrupo", 5)
2562:                             loc_oPg.txt_4c__cd_sgrupo.Value = ;
2563:                                 ALLTRIM(cursor_4c_BuscaSGru.Codigos)
2564:                         ENDIF
2565:                         IF PEMSTATUS(loc_oPg, "txt_4c__ds_sgrupo", 5)
2566:                             loc_oPg.txt_4c__ds_sgrupo.Value = ;
2567:                                 ALLTRIM(cursor_4c_BuscaSGru.Descricaos)
2568:                             loc_oPg.txt_4c__ds_sgrupo.Enabled = .T.
2569:                         ENDIF
2570:                     ENDIF
2571:                     ENDIF
2572:                 ENDIF
2573:                 loc_oBusca.Release()
2574:             ENDIF
2575:             IF USED("cursor_4c_BuscaSGru")

*-- Linhas 2613 a 2649:
2613:                 IF VARTYPE(loc_oBusca) = "O"
2614:                     IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2615:                         IF USED("cursor_4c_BuscaSGruD")
2616:                             SELECT cursor_4c_BuscaSGruD
2617:                             IF PEMSTATUS(loc_oPg, "txt_4c__cd_sgrupo", 5)
2618:                                 loc_oPg.txt_4c__cd_sgrupo.Value = ;
2619:                                     ALLTRIM(cursor_4c_BuscaSGruD.Codigos)
2620:                             ENDIF
2621:                             IF PEMSTATUS(loc_oPg, "txt_4c__ds_sgrupo", 5)
2622:                                 loc_oPg.txt_4c__ds_sgrupo.Value = ;
2623:                                     ALLTRIM(cursor_4c_BuscaSGruD.Descricaos)
2624:                             ENDIF
2625:                         ENDIF
2626:                     ELSE
2627:                         IF !loc_oBusca.this_lAchouRegistro
2628:                         loc_oBusca.mAddColuna("Descricaos", "XXXXXXXXXXXXXXXXXXXX", ;
2629:                             "Descri" + CHR(231) + CHR(227) + "o")
2630:                         loc_oBusca.mAddColuna("Codigos",    "XXXXXXXXXX", "Sub-Grupo")
2631:                         loc_oBusca.mAddColuna("CGrus",      "XXXXXXXXXX", "Grupo")
2632:                         loc_oBusca.Show()
2633:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSGruD")
2634:                             SELECT cursor_4c_BuscaSGruD
2635:                             IF PEMSTATUS(loc_oPg, "txt_4c__cd_sgrupo", 5)
2636:                                 loc_oPg.txt_4c__cd_sgrupo.Value = ;
2637:                                     ALLTRIM(cursor_4c_BuscaSGruD.Codigos)
2638:                             ENDIF
2639:                             IF PEMSTATUS(loc_oPg, "txt_4c__ds_sgrupo", 5)
2640:                                 loc_oPg.txt_4c__ds_sgrupo.Value = ;
2641:                                     ALLTRIM(cursor_4c_BuscaSGruD.Descricaos)
2642:                             ENDIF
2643:                         ENDIF
2644:                         ENDIF
2645:                     ENDIF
2646:                     loc_oBusca.Release()
2647:                 ENDIF
2648:                 IF USED("cursor_4c_BuscaSGruD")
2649:                     USE IN cursor_4c_BuscaSGruD


### BO (C:\4c\projeto\app\classes\SigReCmpBO.prg):
*==============================================================================
* SigReCmpBO.prg
* Business Object: Listagem de Composicao Por Movimentacao/OP (SIGRECMP)
* Herda de: RelatorioBase
* Tipo: REPORT
* Form legado: SigReCmp.SCX (frmrelatorio)
* Relatorios: SigReCp2.frx (agrupamento=1), SigReCp3.frx (agrupamento=2)
*==============================================================================

DEFINE CLASS SigReCmpBO AS RelatorioBase

    *-- Identificacao (sem tabela direta - relatorio)
    this_cTabela          = ""
    this_cCampoChave      = ""
    this_cMensagemErro    = ""

    *--------------------------------------------------------------------------
    * Filtros de data e periodo
    *--------------------------------------------------------------------------
    this_dDtInicial       = {}    && Data inicial do periodo
    this_dDtFinal         = {}    && Data final do periodo
    this_nOptData         = 1     && 1=Lancamento, 2=Prazo Entrega

    *--------------------------------------------------------------------------
    * Filtro de movimentacao
    *--------------------------------------------------------------------------
    this_cOperacao        = ""    && Codigo da movimentacao (max 20 chars)
    this_nNumes           = 0     && Numero da movimentacao (0=todos)

    *--------------------------------------------------------------------------
    * Filtro de OP (Ordem de Producao)
    *--------------------------------------------------------------------------
    this_lChkImpOp        = .F.   && .T. = filtrar por intervalo de OP
    this_nOpi             = 0     && OP inicial (0=sem filtro)
    this_nOpf             = 0     && OP final (0=sem limite, tratado como 999999)

    *--------------------------------------------------------------------------
    * Filtro de empresa
    *--------------------------------------------------------------------------
    this_cEmpresa         = ""    && Codigo da empresa (3 chars)
    this_cEmpresaDesc     = ""    && Descricao da empresa

    *--------------------------------------------------------------------------
    * Filtro de observacao
    *--------------------------------------------------------------------------
    this_nCodObs          = 0     && Codigo de observacao (0=todos)
    this_cDesObs          = ""    && Descricao da observacao

    *--------------------------------------------------------------------------
    * Filtro de grupo estoque / conta
    *--------------------------------------------------------------------------
    this_cGrEstoque       = ""    && Codigo do grupo estoque (10 chars)
    this_cGrEstoqueDesc   = ""    && Descricao do grupo estoque
    this_cEstoque         = ""    && Codigo da conta/estoque (10 chars)
    this_cEstoqueDesc     = ""    && Descricao da conta/estoque

    *--------------------------------------------------------------------------
    * Filtro de grande grupo
    *--------------------------------------------------------------------------
    this_cGrdGrupo        = ""    && Codigo do grande grupo (3 chars)
    this_cGrdGrupoDesc    = ""    && Descricao do grande grupo

    *--------------------------------------------------------------------------
    * Filtro de grupo produto
    *--------------------------------------------------------------------------
    this_cGrupo           = ""    && Codigo do grupo produto (3 chars)
    this_cGrupoDesc       = ""    && Descricao do grupo produto

    *--------------------------------------------------------------------------
    * Filtro de subgrupo
    *--------------------------------------------------------------------------
    this_cSubGrupo        = ""    && Codigo do subgrupo (6 chars)
    this_cSubGrupoDesc    = ""    && Descricao do subgrupo

    *--------------------------------------------------------------------------
    * Opcoes gerais de filtro e agrupamento
    *--------------------------------------------------------------------------
    this_nOpcaoSituacao   = 3     && OptSituas: 1=N.Ind., 2=Industrializada, 3=Todos
    this_nAgrupamento     = 1     && optagrupa: 1=por Composicao, 2=pela OP
    this_lServico         = .F.   && .T. = incluir industrializacao de servico
    this_lPendente        = .F.   && .T. = filtrar apenas pendentes
    this_lOrdem           = .F.   && .T. = filtrar por ordem de composicao

    *==========================================================================
    * Init - Inicializa o BO de relatorio (sem tabela direta)
    *==========================================================================
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Nao aplicavel para relatorio
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *==========================================================================
    * InicializarDados
    * Cria e popula cursor_4c_TipoMov com tipos de movimentacao de SigCdTom.
    * Equivalente ao Load (CREATE CURSOR cs_SigCdTom) + parte do Init legado.
    * Deve ser chamado pelo form antes de exibir o grid de tipos.
    *==========================================================================
    PROCEDURE InicializarDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_TipoMov")
                USE IN cursor_4c_TipoMov
            ENDIF
            CREATE CURSOR cursor_4c_TipoMov (Marca N(1), Descri C(40), Codigos N(2))
            INDEX ON Codigos TAG Codigos

            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdTom"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TipoMovTemp") > 0
                SELECT cursor_4c_TipoMovTemp
                SCAN
                    INSERT INTO cursor_4c_TipoMov (Marca, Codigos, Descri) ;
                        VALUES (0, cursor_4c_TipoMovTemp.Codigos, ;
                                ALLTRIM(STR(cursor_4c_TipoMovTemp.Codigos, 2)) + "-" + ;
                                ALLTRIM(cursor_4c_TipoMovTemp.Descrs))
                ENDSCAN
                IF USED("cursor_4c_TipoMovTemp")
                    USE IN cursor_4c_TipoMovTemp
                ENDIF
            ENDIF
            SELECT cursor_4c_TipoMov
            GO TOP
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterNomeRelatorio
    * Retorna nome do FRX conforme agrupamento selecionado
    *==========================================================================
    PROCEDURE ObterNomeRelatorio()
        IF THIS.this_nAgrupamento = 1
            RETURN "SigReCp2"
        ELSE
            RETURN "SigReCp3"
        ENDIF
    ENDPROC

    *==========================================================================
    * ObterMensagemErro
    * Retorna ultima mensagem de erro registrada
    *==========================================================================
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *==========================================================================
    * DesmarcarTodos
    * Remove marca de todos os tipos de movimentacao (equivalente ao btn apaga)
    *==========================================================================
    PROCEDURE DesmarcarTodos()
        IF USED("cursor_4c_TipoMov")
            SELECT cursor_4c_TipoMov
            REPLACE ALL Marca WITH 0
            GO TOP
        ENDIF
    ENDPROC

    *==========================================================================
    * MarcarTodos
    * Marca todos os tipos de movimentacao (equivalente ao btn SelTudo)
    *==========================================================================
    PROCEDURE MarcarTodos()
        IF USED("cursor_4c_TipoMov")
            SELECT cursor_4c_TipoMov
            REPLACE ALL Marca WITH 1
            GO TOP
        ENDIF
    ENDPROC

    *==========================================================================
    * PrepararDados
    * Executa processamento principal: seleciona movimentacoes e composicoes.
    * Equivalente ao metodo "processamento" do form legado SIGRECMP.
    * Popula cursores TmpRelat e dbCabecalho para uso pelo REPORT FORM.
    *==========================================================================
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        LOCAL loc_cOperacao, loc_nNume, loc_cEmpresa, loc_cGrupop
        LOCAL loc_cGrdGru, loc_cSubGru, loc_cGrupo, loc_cConta
        LOCAL loc_nOpcao, loc_lChkOp, loc_nNopi, loc_nNopf
        LOCAL loc_lServico, loc_lPendente, loc_nObs, loc_lOrdem
        LOCAL loc_cDtI, loc_cDtF, loc_cDatos
        LOCAL loc_llTipoSel, loc_cFilTipo, loc_cWhere, loc_cSQL
        LOCAL loc_cEmpresaDesc, loc_cNomeEmpresa
        LOCAL loc_cTitulo, loc_cPeriodo, loc_cSubTit, loc_cTot
        LOCAL loc_lcChave, loc_cGrupoRel, loc_cContaRel
        LOCAL loc_lnQtde, loc_lnPeso, loc_cDgru, loc_cNop
        LOCAL loc_nLnOpi, loc_nLnOpf, loc_nRegs, loc_cEmpPro, loc_cSqlPen
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            *-- Extrair valores dos filtros das propriedades do BO
            loc_cOperacao = PADR(ALLTRIM(THIS.this_cOperacao), 20)
            loc_nNume     = THIS.this_nNumes
            loc_cEmpresa  = THIS.this_cEmpresa
            loc_cGrupop   = PADR(ALLTRIM(THIS.this_cGrupo), 3)
            loc_cGrdGru   = THIS.this_cGrdGrupo
            loc_cSubGru   = THIS.this_cSubGrupo
            loc_cGrupo    = PADR(ALLTRIM(THIS.this_cGrEstoque), 10)
            loc_cConta    = PADR(ALLTRIM(THIS.this_cEstoque), 10)
            loc_nOpcao    = THIS.this_nOpcaoSituacao
            loc_lChkOp    = THIS.this_lChkImpOp
            loc_nNopi     = THIS.this_nOpi
            loc_nNopf     = IIF(THIS.this_nOpf = 0, 999999, THIS.this_nOpf)
            loc_lServico  = THIS.this_lServico
            loc_lPendente = THIS.this_lPendente
            loc_nObs      = THIS.this_nCodObs
            loc_lOrdem    = THIS.this_lOrdem

            *-- Formatar datas para SQL Server (pDtI/pDtF do legado)
            loc_cDatos = DTOS(THIS.this_dDtFinal)
            loc_cDtI   = FormatarDataSQL(THIS.this_dDtInicial)
            loc_cDtF   = "'" + LEFT(loc_cDatos, 4) + "-" + ;
                         SUBSTR(loc_cDatos, 5, 2) + "-" + ;
                         RIGHT(loc_cDatos, 2) + " 23:59:59'"

            *-- Verificar se ha tipos selecionados no grid de tipos
            loc_llTipoSel = .F.
            loc_cFilTipo  = ""
            IF USED("cursor_4c_TipoMov")
                SELECT cursor_4c_TipoMov
                GO TOP
                LOCATE FOR Marca = 1
                IF !EOF()
                    loc_llTipoSel = .T.
                ENDIF
            ENDIF

            *-- Fechar cursores de resultado anteriores
            IF USED("TmpRelat")
                USE IN TmpRelat
            ENDIF
            IF USED("dbCabecalho")
                USE IN dbCabecalho
            ENDIF
            IF USED("CrSigMvCab")
                USE IN CrSigMvCab
            ENDIF
            IF USED("CrSigCdEmp")
                USE IN CrSigCdEmp
            ENDIF
            IF USED("CrSigMvItn")
                USE IN CrSigMvItn
            ENDIF
            IF USED("CrSigOpPic")
                USE IN CrSigOpPic
            ENDIF

            *-- Buscar empresas para cabecalho e processamento
            loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp" + ;
                       IIF(EMPTY(loc_cEmpresa), "", " WHERE Cemps = " + EscaparSQL(loc_cEmpresa))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdEmp") < 1
                THIS.this_cMensagemErro = "Erro ao carregar empresas"
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
                SELECT CrSigCdEmp
                GO TOP
                loc_cEmpresaDesc = IIF(EOF(), "", ALLTRIM(CrSigCdEmp.Razas))

            *-- Buscar razao social da empresa logada no sistema
            loc_cNomeEmpresa = ""
            loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + ;
                       EscaparSQL(go_4c_Sistema.cCodEmpresa)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpSis") > 0
                SELECT cursor_4c_EmpSis
                IF !EOF()
                    loc_cNomeEmpresa = ALLTRIM(cursor_4c_EmpSis.Razas)
                ENDIF
                USE IN cursor_4c_EmpSis
            ENDIF

            *-- Montar textos do cabecalho do relatorio
            loc_cTitulo  = "Listagem de Composi" + CHR(231) + CHR(227) + ;
                           "o por Movimenta" + CHR(231) + CHR(227) + "o ( " + ;
                           ALLTRIM(loc_cOperacao) + ;
                           IIF(loc_nNume <> 0, ": " + ALLTRIM(STR(loc_nNume, 6)), "") + " )"
            loc_cPeriodo = "Per" + CHR(237) + "odo: " + DTOC(THIS.this_dDtInicial) + ;
                           " " + CHR(224) + " " + DTOC(THIS.this_dDtFinal) + " - " + ;
                           IIF(EMPTY(loc_cEmpresa), "Geral", ;
                               "Empresa: " + loc_cEmpresa + " - " + ALLTRIM(loc_cEmpresaDesc))
            loc_cSubTit  = IIF(loc_nNopi <> 0, ;
                               "OP: " + ALLTRIM(STR(loc_nNopi, 6)) + ;
                               " " + CHR(224) + " " + ALLTRIM(STR(loc_nNopf, 6)), ;
                               "")

            *-- Criar cursor de cabecalho (dbCabecalho legado)
            CREATE CURSOR dbCabecalho ;
                (NomeEmpresa C(80), Titulo C(80), Periodo C(150), ;
                 SubTitulo C(80), lCompo L, Total M(4))
            INSERT INTO dbCabecalho (NomeEmpresa, Titulo, Periodo, SubTitulo) ;
                VALUES (loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo, loc_cSubTit)

            *-- Criar cursor de resultado principal (TmpRelat legado)
            CREATE CURSOR TmpRelat ;
                (Emps C(3), Razas C(40), CGrus C(3), DGrus C(20), ;
                 Grupo C(10), Conta C(10), DConta C(40), Tps C(1), ;
                 CPros C(14), DPros C(40), cUnis C(3), Qtds N(12, 3), ;
                 QtPds N(10), Pesoms N(8, 4), Pesos N(12, 3), ;
                 Datas D(8), NDias N(8), Imps N(1), reffs C(40), ;
                 Mats C(14), DMats C(40), unicompos C(3), cunips C(3), ;
                 Nops C(10), ObsOfs C(50), RefMats C(20))
            INDEX ON Grupo + Conta + Emps + CPros TAG EmpCPro
            INDEX ON Grupo + Conta + Emps + Tps + CGrus + CPros TAG EmpCGruPro
            INDEX ON Grupo + Conta + Emps + Tps + CGrus + CPros TAG EGP
            INDEX ON Mats + Reffs + CPros TAG MatRef
            INDEX ON CPros + Nops + Mats + Reffs TAG CproMatRef

            *-- ==============================================================
            *-- MONTAR WHERE para consulta de movimentacoes (SigMvCab)
            *-- ==============================================================
            loc_cWhere = ""
            IF loc_lChkOp
                *-- Filtro por intervalo de OP (chkImpOp marcado)
                loc_cWhere = " a.Nops BETWEEN " + ALLTRIM(STR(loc_nNopi)) + ;
                             " AND " + ALLTRIM(STR(loc_nNopf)) + ;
                             " AND b.produc = 1"
                IF !EMPTY(loc_cEmpresa)
                    loc_cWhere = loc_cWhere + " AND a.Emps = " + EscaparSQL(loc_cEmpresa)
                ENDIF
            ELSE
                *-- Filtro por operacao e datas
                IF !EMPTY(ALLTRIM(loc_cOperacao))
                    loc_cWhere = " a.Dopes = " + EscaparSQL(ALLTRIM(loc_cOperacao))
                ENDIF
                IF EMPTY(ALLTRIM(loc_cOperacao)) AND !loc_llTipoSel
                    loc_cWhere = loc_cWhere + ;
                                 IIF(EMPTY(loc_cWhere), "", " AND ") + " b.produc = 1"
                ENDIF
                IF loc_nNume <> 0
                    loc_cWhere = loc_cWhere + ;
                                 IIF(EMPTY(loc_cWhere), "", " AND ") + ;
                                 " a.Numes = " + ALLTRIM(STR(loc_nNume, 6))
                ENDIF
                IF loc_nNume = 0
                    IF THIS.this_nOptData = 1
                        loc_cWhere = loc_cWhere + ;
                                     IIF(EMPTY(loc_cWhere), "", " AND ") + ;
                                     " a.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF
                    ELSE
                        loc_cWhere = loc_cWhere + ;
                                     IIF(EMPTY(loc_cWhere), "", " AND ") + ;
                                     " a.PrazoEnts BETWEEN " + loc_cDtI + " AND " + loc_cDtF
                    ENDIF
                ENDIF
                IF !EMPTY(loc_cEmpresa)
                    loc_cWhere = loc_cWhere + ;
                                 IIF(EMPTY(loc_cWhere), "", " AND ") + ;
                                 " a.Emps = " + EscaparSQL(loc_cEmpresa)
                ENDIF
                IF loc_nOpcao = 1
                    loc_cWhere = loc_cWhere + ;
                                 IIF(EMPTY(loc_cWhere), "", " AND ") + " a.Nops = 0"
                ENDIF
                IF loc_nOpcao = 2
                    loc_cWhere = loc_cWhere + ;
                                 IIF(EMPTY(loc_cWhere), "", " AND ") + " a.Nops <> 0"
                ENDIF
            ENDIF

            *-- Adicionar filtro pelos tipos de movimentacao selecionados no grid
            IF USED("cursor_4c_TipoMov") AND loc_llTipoSel
                SELECT cursor_4c_TipoMov
                GO TOP
                SCAN FOR Marca = 1
                    IF EMPTY(loc_cFilTipo)
                        loc_cFilTipo = ALLTRIM(STR(cursor_4c_TipoMov.Codigos))
                    ELSE
                        loc_cFilTipo = loc_cFilTipo + "," + ;
                                       ALLTRIM(STR(cursor_4c_TipoMov.Codigos))
                    ENDIF
                ENDSCAN
            ENDIF
            IF !EMPTY(loc_cFilTipo)
                loc_cWhere = loc_cWhere + ;
                             IIF(EMPTY(loc_cWhere), "", " AND ") + ;
                             " b.TipoOps IN (" + loc_cFilTipo + ")"
            ENDIF

            *-- ==============================================================
            *-- SELECIONAR MOVIMENTACOES (SigMvCab JOIN SigCdOpe)
            *-- ==============================================================
            WAIT WINDOW "Aguarde! Selecionando Movimenta" + ;
                        CHR(231) + CHR(245) + "es..." NOWAIT

            loc_cSQL = "SELECT a.Emps, a.Dopes, a.Numes, a.Datas, " + ;
                       "a.GrupoOs, a.ContaOs, a.GrupoDs, a.ContaDs, " + ;
                       "a.EmpDopNums, a.Nops, b.Globalizas, b.Servicos " + ;
                       "FROM SigMvCab a INNER JOIN SigCdOpe b ON a.Dopes = b.Dopes"
            IF !EMPTY(loc_cWhere)
                loc_cSQL = loc_cSQL + " WHERE " + loc_cWhere
            ENDIF
            IF loc_nObs <> 0
                loc_cSQL = loc_cSQL + ;
                           IIF(!EMPTY(loc_cWhere), " AND", " WHERE") + ;
                           " a.CodObs = " + ALLTRIM(STR(loc_nObs))
            ENDIF
            loc_cSQL = loc_cSQL + ;
                       " ORDER BY a.Emps, a.Dopes, a.Numes, a.Datas, " + ;
                       "a.GrupoOs, a.ContaOs, a.GrupoDs, a.ContaDs, a.EmpDopNums"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "CrSigMvCab") < 1
                THIS.this_cMensagemErro = "Erro ao carregar movimenta" + ;
                                          CHR(231) + CHR(245) + "es"
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
            SELECT CrSigMvCab
            INDEX ON EmpDopNums TAG EmpDopNums
            GO TOP
            WAIT CLEAR

            *-- ==============================================================
            *-- PROCESSAR POR EMPRESA
            *-- ==============================================================
            SELECT CrSigCdEmp
            GO TOP
            SCAN
                loc_cEmpPro = CrSigCdEmp.Cemps

                SELECT CrSigMvCab
                COUNT FOR Emps = loc_cEmpPro TO loc_nRegs
                GO TOP

                IF SEEK(loc_cEmpPro, "CrSigMvCab", "EmpDopNums")
                    WAIT WINDOW "Verificando Movimenta" + CHR(231) + ;
                                CHR(245) + "es..." NOWAIT

                    SCAN WHILE CrSigMvCab.Emps = loc_cEmpPro
                        loc_cGrupoRel = ""
                        loc_cContaRel = ""

                        *-- Pular industrializacoes de servico se nao marcado
                        IF !loc_lServico AND EMPTY(ALLTRIM(loc_cOperacao)) AND ;
                           INLIST(CrSigMvCab.Servicos, 1, 2)
                            LOOP
                        ENDIF

                        *-- Filtrar por grupo/conta estoque se informados
                        IF !EMPTY(ALLTRIM(loc_cGrupo)) OR !EMPTY(ALLTRIM(loc_cConta))
                            IF CrSigMvCab.Globalizas = 1 OR CrSigMvCab.Servicos = 1
                                IF !EMPTY(ALLTRIM(loc_cGrupo)) AND ;
                                   (loc_cGrupo <> CrSigMvCab.GrupoOs)
                                    SELECT CrSigMvCab
                                    LOOP
                                ENDIF
                                IF !EMPTY(ALLTRIM(loc_cConta)) AND ;
                                   (loc_cConta <> CrSigMvCab.ContaOs)
                                    SELECT CrSigMvCab
                                    LOOP
                                ENDIF
                                loc_cGrupoRel = CrSigMvCab.GrupoOs
                                loc_cContaRel = CrSigMvCab.ContaOs
                            ENDIF
                            IF CrSigMvCab.Globalizas = 2 OR CrSigMvCab.Servicos = 2
                                IF !EMPTY(ALLTRIM(loc_cGrupo)) AND ;
                                   (loc_cGrupo <> CrSigMvCab.GrupoDs)
                                    SELECT CrSigMvCab
                                    LOOP
                                ENDIF
                                IF !EMPTY(ALLTRIM(loc_cConta)) AND ;
                                   (loc_cConta <> CrSigMvCab.ContaDs)
                                    SELECT CrSigMvCab
                                    LOOP
                                ENDIF
                                loc_cGrupoRel = CrSigMvCab.GrupoDs
                                loc_cContaRel = CrSigMvCab.ContaDs
                            ENDIF
                        ELSE
                            loc_cGrupoRel = SPACE(10)
                            loc_cContaRel = SPACE(10)
                        ENDIF

                        loc_lcChave = CrSigMvCab.EmpDopNums

                        *-- Fechar cursor de itens da iteracao anterior
                        IF USED("CrSigMvItn")
                            USE IN CrSigMvItn
                        ENDIF

                        *-- ======================================================
                        *-- QUERY DE COMPONENTES DA MOVIMENTACAO (UNION ALL)
                        *-- Parte 1: Componentes diretos (SigSubMv + SigMvItn)
                        *-- ======================================================
                        loc_cSQL = "SELECT a.mats, a.CPros, a.Pesos, a.Qtds, a.QtBaixas, " + ;
                                   "b.Dpros AS Dmats, b.CGrus, b.CUnis, b.PesoMs, b.CustoFs, " + ;
                                   "b.Reffs AS RefMats, c.DGrus, d.FatDivs, b.Reffs, e.Dpros, " + ;
                                   "a.cunis AS unicompos, a.cunips, " + ;
                                   "CASE WHEN g.Qtds IS NULL THEN f.Qtds ELSE g.Qtds END AS QtdPed, " + ;
                                   "d.Fators, f.Citens, SPACE(50) AS ObsOFs, a.EmpDopNums, " + ;
                                   "CASE WHEN g.CodCors IS NULL THEN SPACE(4) " + ;
                                   "ELSE g.CodCors END AS CodCors, " + ;
                                   "CASE WHEN g.CodTams IS NULL THEN SPACE(4) " + ;
                                   "ELSE g.CodTams END AS CodTams " + ;
                                   "FROM SigSubMv a " + ;
                                   "INNER JOIN SigCdPro e ON e.Cpros = a.Cpros " + ;
                                   "INNER JOIN SigMvItn f ON f.empdopnums = a.empdopnums " + ;
                                   "AND f.citens = a.citem2 " + ;
                                   "INNER JOIN SigCdPro b ON b.CPros = a.mats " + ;
                                   "LEFT JOIN SigCdGrp c ON c.CGrus = b.CGrus " + ;
                                   "LEFT JOIN SigCdUni d ON d.CUnis = b.CUnis " + ;
                                   "LEFT JOIN SigMvIts g ON g.EmpDopNums = f.EmpDopNums " + ;
                                   "AND g.Citens = f.Citens " + ;
                                   "WHERE a.empdopnums = " + EscaparSQL(loc_lcChave)
                        IF !EMPTY(ALLTRIM(loc_cGrdGru))
                            loc_cSQL = loc_cSQL + ;
                                       " AND b.Mercs = " + EscaparSQL(ALLTRIM(loc_cGrdGru))
                        ENDIF
                        IF !EMPTY(ALLTRIM(loc_cGrupop))
                            loc_cSQL = loc_cSQL + ;
                                       " AND b.CGrus = " + EscaparSQL(ALLTRIM(loc_cGrupop))
                        ENDIF
                        IF !EMPTY(ALLTRIM(loc_cSubGru))
                            loc_cSQL = loc_cSQL + ;
                                       " AND b.SGrus = " + EscaparSQL(ALLTRIM(loc_cSubGru))
                        ENDIF

                        *-- Parte 2: Componentes do plano (SigPrCpo + SigMvItn)
                        loc_cSQL = loc_cSQL + ;
                                   " UNION ALL " + ;
                                   "SELECT a.mats, a.CPros, " + ;
                                   "CASE WHEN h.Pesos IS NULL THEN a.Pesos ELSE h.Pesos END AS Pesos, " + ;
                                   "CASE WHEN h.Qtds IS NULL THEN a.Qtds ELSE h.Qtds END AS Qtds, " + ;
                                   "0 AS QtBaixas, b.Dpros AS DMats, b.CGrus, b.CUnis, " + ;
                                   "b.PesoMs, b.CustoFs, b.Reffs AS RefMats, c.DGrus, " + ;
                                   "d.FatDivs, f.reffs, e.Dpros, a.unicompos, a.cunips, " + ;
                                   "CASE WHEN g.Qtds IS NULL THEN e.Qtds ELSE g.Qtds END AS QtdPed, " + ;
                                   "d.Fators, e.Citens, CAST(a.ObsOFs AS CHAR(50)) AS ObsOFs, " + ;
                                   "e.EmpDopNums, " + ;
                                   "CASE WHEN g.CodCors IS NULL THEN SPACE(4) " + ;
                                   "ELSE g.CodCors END AS CodCors, " + ;
                                   "CASE WHEN g.CodTams IS NULL THEN SPACE(4) " + ;
                                   "ELSE g.CodTams END AS CodTams " + ;
                                   "FROM SigMvItn e " + ;
                                   "LEFT JOIN SigMvIts g ON e.EmpDopNums = g.EmpDopNums " + ;
                                   "AND e.Citens = g.Citens " + ;
                                   "INNER JOIN SigPrCpo a ON e.cpros = a.cpros " + ;
                                   "LEFT JOIN SigSubCp h ON a.Cpros = h.Cpros " + ;
                                   "AND a.Mats = h.Mats AND h.CodTams = g.CodTams " + ;
                                   "INNER JOIN SigCdPro f ON e.Cpros = f.Cpros " + ;
                                   "INNER JOIN SigCdPro b ON b.CPros = a.mats " + ;
                                   "LEFT JOIN SigCdGrp c ON c.CGrus = b.CGrus " + ;
                                   "LEFT JOIN SigCdUni d ON d.CUnis = b.CUnis " + ;
                                   "WHERE e.empdopnums = " + EscaparSQL(loc_lcChave)
                        IF !EMPTY(ALLTRIM(loc_cGrdGru))
                            loc_cSQL = loc_cSQL + ;
                                       " AND b.Mercs = " + EscaparSQL(ALLTRIM(loc_cGrdGru))
                        ENDIF
                        IF !EMPTY(ALLTRIM(loc_cGrupop))
                            loc_cSQL = loc_cSQL + ;
                                       " AND b.CGrus = " + EscaparSQL(ALLTRIM(loc_cGrupop))
                        ENDIF
                        IF !EMPTY(ALLTRIM(loc_cSubGru))
                            loc_cSQL = loc_cSQL + ;
                                       " AND b.SGrus = " + EscaparSQL(ALLTRIM(loc_cSubGru))
                        ENDIF
                        IF loc_lOrdem
                            loc_cSQL = loc_cSQL + " AND a.OrdTs = 0"
                        ENDIF
                        loc_cSQL = loc_cSQL + ;
                                   " AND e.citens NOT IN (" + ;
                                   "SELECT e.citens FROM SigMvItn e, SigSubMv a " + ;
                                   "WHERE e.empdopnums = " + EscaparSQL(loc_lcChave) + ;
                                   " AND e.empdopnums = a.empdopnums " + ;
                                   "AND e.citens = a.citem2 GROUP BY e.citens)"

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "CrSigMvItn") < 1
                            SELECT CrSigMvCab
                            LOOP
                        ENDIF
                        SELECT CrSigMvItn
                        INDEX ON CPros + STR(Pesos, 12, 3) + STR(Qtds, 12, 3) TAG Ordem

                        *-- Buscar dados de OP se a movimentacao possuir Nops
                        IF !EMPTY(CrSigMvCab.Nops)
                            loc_nLnOpi = CrSigMvCab.Nops * 10000
                            loc_nLnOpf = (CrSigMvCab.Nops + 1) * 10000

                            IF USED("CrSigOpPic")
                                USE IN CrSigOpPic
                            ENDIF

                            loc_cSQL = "SELECT a.Nops, a.cpros, a.Emps, a.empdopnops, " + ;
                                       "a.EmpDopNums, SUM(a.qtds) AS Qtds, " + ;
                                       "a.codcors, a.CodTams, b.descs AS desccors, a.citens " + ;
                                       "FROM SigOpPic a " + ;
                                       "LEFT JOIN SigCdCor b ON a.codcors = b.cods " + ;
                                       "WHERE a.Nops BETWEEN " + ;
                                       ALLTRIM(STR(loc_nLnOpi, 10)) + ;
                                       " AND " + ALLTRIM(STR(loc_nLnOpf, 10)) + ;
                                       " AND a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                                       " GROUP BY a.Nops, a.cpros, a.emps, a.empdopnops, " + ;
                                       "a.EmpDopNums, a.codcors, a.CodTams, b.descs, a.citens"

                            IF SQLEXEC(gnConnHandle, loc_cSQL, "CrSigOpPic") > 0
                                SELECT CrSigOpPic
                                INDEX ON STR(Citens, 4) + Cpros + STR(Nops, 10) TAG CproNop
                                INDEX ON STR(Citens, 4) + Cpros + CodCors + ;
                                         CodTams + EmpDopNums + STR(Nops, 10) TAG CproNop2
                            ENDIF
                        ENDIF

                        *-- ======================================================
                        *-- ITERAR SOBRE OS COMPONENTES E ACUMULAR EM TmpRelat
                        *-- ======================================================
                        SELECT CrSigMvItn
                        GO TOP
                        SCAN
                            loc_cNop = ""

                            IF !EMPTY(CrSigMvCab.Nops) AND USED("CrSigOpPic")
                                *-- Com OP: usar quantidades do SigOpPic
                                SELECT CrSigOpPic
                                =SEEK(STR(CrSigMvItn.Citens, 4) + CrSigMvItn.Cpros + ;
                                      CrSigMvItn.CodCors + CrSigMvItn.CodTams + ;
                                      CrSigMvItn.EmpDopNums, "CrSigOpPic", "CproNop2")

                                SCAN FOR CrSigOpPic.Cpros = CrSigMvItn.Cpros AND ;
                                         CrSigOpPic.Citens = CrSigMvItn.Citens AND ;
                                         CrSigOpPic.EmpDopNums = CrSigMvItn.EmpDopNums AND ;
                                         CrSigOpPic.CodCors = CrSigMvItn.CodCors AND ;
                                         CrSigOpPic.CodTams = CrSigMvItn.CodTams

                                                IF loc_lPendente
                                        loc_cSqlPen = "SELECT ChkSubn FROM SigCdNec " + ;
                                                      "WHERE EmpDnPs = " + ;
                                                      EscaparSQL(ALLTRIM(CrSigOpPic.EmpdopNops))
                                        IF SQLEXEC(gnConnHandle, loc_cSqlPen, "TmpNens") > 0
                                            SELECT TmpNens
                                            IF !EOF() AND TmpNens.ChkSubn
                                                IF USED("TmpNens")
                                                    USE IN TmpNens
                                                ENDIF
                                                SELECT CrSigOpPic
                                                LOOP
                                            ENDIF
                                            IF USED("TmpNens")
                                                USE IN TmpNens
                                            ENDIF
                                        ENDIF
                                    ENDIF

                                    loc_lnQtde = ROUND(CrSigOpPic.Qtds * CrSigMvItn.Qtds, 3)
                                    loc_lnPeso = ROUND(CrSigOpPic.Qtds * CrSigMvItn.Pesos, 3)
                                    loc_cDgru  = NVL(CrSigMvItn.DGrus, "")
                                    loc_cNop   = IIF(THIS.this_nAgrupamento = 2, ;
                                                     ALLTRIM(STR(CrSigOpPic.Nops)), "")

                                    SELECT TmpRelat
                                    SET ORDER TO CproMatRef
                                    IF !SEEK(CrSigMvItn.Cpros + PADR(loc_cNop, 10) + ;
                                             CrSigMvItn.Mats + CrSigMvItn.Reffs, ;
                                             "TmpRelat", "CproMatRef")
                                        INSERT INTO TmpRelat ;
                                            (Grupo, Conta, Emps, Razas, CGrus, DGrus, ;
                                             CPros, DPros, Cunis, Pesoms, reffs, Mats, ;
                                             Dmats, unicompos, cunips, Nops, ObsOfs, RefMats) ;
                                            VALUES (loc_cGrupoRel, loc_cContaRel, ;
                                                    CrSigMvCab.Emps, CrSigCdEmp.Razas, ;
                                                    CrSigMvItn.CGrus, loc_cDgru, ;
                                                    CrSigMvItn.CPros, CrSigMvItn.DPros, ;
                                                    CrSigMvItn.Cunis, loc_lnPeso, ;
                                                    CrSigMvItn.Reffs, CrSigMvItn.Mats, ;
                                                    CrSigMvItn.DMats, CrSigMvItn.unicompos, ;
                                                    CrSigMvItn.cunips, loc_cNop, ;
                                                    CrSigMvItn.ObsOfs, CrSigMvItn.RefMats)
                                    ENDIF
                                    REPLACE Qtds  WITH TmpRelat.Qtds + loc_lnQtde, ;
                                            Pesos WITH TmpRelat.Pesos + loc_lnPeso ;
                                            IN TmpRelat
                                    SELECT CrSigOpPic
                                ENDSCAN

                            ELSE
                                *-- Sem OP: usar quantidade do pedido (QtdPed do SigMvItn)
                                loc_lnQtde = ROUND(CrSigMvItn.QtdPed * CrSigMvItn.Qtds, 3)
                                loc_lnPeso = ROUND(CrSigMvItn.QtdPed * CrSigMvItn.Pesos, 3)
                                loc_cDgru  = NVL(CrSigMvItn.DGrus, "")

                                SELECT TmpRelat
                                SET ORDER TO EmpCPro

                                IF !SEEK(CrSigMvItn.Cpros + SPACE(10) + ;
                                         CrSigMvItn.Mats + CrSigMvItn.Reffs, ;
                                         "TmpRelat", "CproMatRef")
                                    INSERT INTO TmpRelat ;
                                        (Grupo, Conta, Emps, Razas, CGrus, DGrus, ;
                                         CPros, DPros, Cunis, Pesoms, reffs, Mats, ;
                                         Dmats, unicompos, cunips, Nops, ObsOfs, RefMats) ;
                                        VALUES (loc_cGrupoRel, loc_cContaRel, ;
                                                CrSigMvCab.Emps, CrSigCdEmp.Razas, ;
                                                CrSigMvItn.CGrus, loc_cDgru, ;
                                                CrSigMvItn.CPros, CrSigMvItn.DPros, ;
                                                CrSigMvItn.Cunis, loc_lnPeso, ;
                                                CrSigMvItn.Reffs, CrSigMvItn.Mats, ;
                                                CrSigMvItn.DMats, CrSigMvItn.unicompos, ;
                                                CrSigMvItn.cunips, loc_cNop, ;
                                                CrSigMvItn.ObsOfs, CrSigMvItn.RefMats)
                                ENDIF
                                REPLACE Qtds  WITH TmpRelat.Qtds + loc_lnQtde, ;
                                        Pesos WITH TmpRelat.Pesos + loc_lnPeso ;
                                        IN TmpRelat
                            ENDIF

                            SELECT CrSigMvItn
                        ENDSCAN

                        SELECT CrSigMvCab
                    ENDSCAN

                    WAIT CLEAR
                ENDIF

                SELECT CrSigCdEmp
            ENDSCAN

            *-- ==============================================================
            *-- POS-PROCESSAMENTO: limpeza, totais e ordenacao
            *-- ==============================================================

            *-- Remover registros sem movimentacao real
            DELETE FROM TmpRelat WHERE Qtds <= 0 AND Pesos <= 0
            LOCATE FOR .F.

            *-- Calcular totais por unidade de medida para cabecalho
            SELECT UniCompos, SUM(Qtds) AS Qtds, CUniPs, SUM(Pesos) AS Pesos ;
                FROM TmpRelat ;
                GROUP BY UniCompos, CUniPs ;
                INTO CURSOR crTotFims READWRITE

            loc_cTot = "  Qtd 1. Ped.  |Uni|  Qtd 2. Ped. |Uni|"
            IF USED("crTotFims")
                SELECT crTotFims
                GO TOP
                SCAN
                    loc_cTot = loc_cTot + CHR(13) + ;
                               TRANSFORM(crTotFims.Qtds, "999,999,999.999") + "|" + ;
                               ALLTRIM(crTotFims.UniCompos) + "|" + ;
                               TRANSFORM(crTotFims.Pesos, "99,999,999.999") + "|" + ;
                               ALLTRIM(crTotFims.CUniPs) + "|"
                ENDSCAN
                USE IN crTotFims
            ENDIF

            SELECT dbCabecalho
            GO TOP
            REPLACE Total WITH Total + loc_cTot IN dbCabecalho

            *-- Ordenar TmpRelat conforme agrupamento selecionado
            SELECT TmpRelat
            IF THIS.this_nAgrupamento = 1
                SET ORDER TO MatRef
            ELSE
                SET ORDER TO CproMatRef
            ENDIF
            GO TOP

            loc_lSucesso = .T.
            ENDIF && loc_lContinuar (CrSigMvCab)
            ENDIF && loc_lContinuar (CrSigCdEmp)

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            WAIT CLEAR
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Visualizar
    * Executa PrepararDados e exibe relatorio em modo Preview (visualizacao)
    * Equivalente ao metodo "visualizacao" do form legado
    *==========================================================================
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cFrx, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFrx = gc_4c_CaminhoReports + THIS.ObterNomeRelatorio()
                REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Imprimir
    * Executa PrepararDados e imprime com dialogo de selecao de impressora
    * Equivalente ao metodo "impressao" do form legado
    *==========================================================================
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cFrx, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFrx = gc_4c_CaminhoReports + THIS.ObterNomeRelatorio()
                REPORT FORM (loc_cFrx) TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GerarDocumento
    * Executa PrepararDados e envia direto para impressora (sem dialogo)
    * Equivalente ao metodo "documento" do form legado
    *==========================================================================
    PROCEDURE GerarDocumento()
        LOCAL loc_lSucesso, loc_cFrx, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFrx = gc_4c_CaminhoReports + THIS.ObterNomeRelatorio()
                REPORT FORM (loc_cFrx) TO PRINTER NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RegistrarAuditoria
    * Registra operacao no log de auditoria (uso em Inserir/Atualizar)
    * Em BO de RELATORIO nao ha persistencia, portanto registra apenas leitura
    *==========================================================================
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Usuario, DataHora, Operacao, Tabela, ChavePrimaria) " + ;
                       "VALUES (" + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL("SigReCmp") + ", " + ;
                       EscaparSQL(THIS.ObterChavePrimaria()) + ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor
    * NAO APLICAVEL para BO de relatorio (sem tabela direta).
    * Mantido como stub para compatibilidade com pipeline de migracao.
    * Relatorios obtem dados via PrepararDados() agregando multiplas tabelas.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        THIS.this_cMensagemErro = "CarregarDoCursor n" + CHR(227) + ;
                                   "o aplic" + CHR(225) + "vel para relat" + ;
                                   CHR(243) + "rio"
        RETURN .F.
    ENDPROC

    *==========================================================================
    * Inserir
    * NAO APLICAVEL para BO de relatorio (apenas leitura).
    * Mantido como stub para compatibilidade com pipeline de migracao.
    * Auditoria de execucao do relatorio eh registrada em PrepararDados.
    *==========================================================================
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Inserir n" + CHR(227) + ;
                                   "o aplic" + CHR(225) + ;
                                   "vel para relat" + CHR(243) + "rio"
        RETURN .F.
    ENDPROC

    *==========================================================================
    * Atualizar
    * NAO APLICAVEL para BO de relatorio (apenas leitura).
    * Mantido como stub para compatibilidade com pipeline de migracao.
    *==========================================================================
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Atualizar n" + CHR(227) + ;
                                   "o aplic" + CHR(225) + ;
                                   "vel para relat" + CHR(243) + "rio"
        RETURN .F.
    ENDPROC

    *==========================================================================
    * Destroy - Fecha todos os cursores abertos pelo BO
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_TipoMov")
            USE IN cursor_4c_TipoMov
        ENDIF
        IF USED("CrSigMvCab")
            USE IN CrSigMvCab
        ENDIF
        IF USED("CrSigMvItn")
            USE IN CrSigMvItn
        ENDIF
        IF USED("CrSigCdEmp")
            USE IN CrSigCdEmp
        ENDIF
        IF USED("CrSigOpPic")
            USE IN CrSigOpPic
        ENDIF
        IF USED("TmpRelat")
            USE IN TmpRelat
        ENDIF
        IF USED("dbCabecalho")
            USE IN dbCabecalho
        ENDIF
        IF USED("crTotFims")
            USE IN crTotFims
        ENDIF
        IF USED("TmpNens")
            USE IN TmpNens
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

