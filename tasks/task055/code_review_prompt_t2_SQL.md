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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReCmp.prg) - TRECHOS RELEVANTES PARA PASS SQL (2716 linhas total):

*-- Linhas 289 a 307:
289:                     *-- Modo validacao UI: criar cursor vazio para o grid funcionar
290:                     IF !USED("cursor_4c_TipoMov")
291:                         SET NULL ON
292:                         CREATE CURSOR cursor_4c_TipoMov ;
293:                             (Marca N(1), Descri C(40), Codigos N(2))
294:                         SET NULL OFF
295:                     ENDIF
296:                 ENDIF
297:             ENDIF
298: 
299:             *-- ===== ROW 1: PERIODO =====
300:             loc_oPagina.AddObject("lbl_4c_Lbl_periodo", "Label")
301:             WITH loc_oPagina.lbl_4c_Lbl_periodo
302:                 .Top       = 38
303:                 .Left      = 55
304:                 .Width     = 45
305:                 .Height    = 18
306:                 .Caption   = "Per" + CHR(237) + "odo :"
307:                 .FontName  = "Tahoma"

*-- Linhas 735 a 785:
735:                 .HighlightBackColor = RGB(255, 255, 255)
736:                 .HighlightForeColor = RGB(15, 41, 104)
737:                 .HighlightStyle     = 2
738:                 .DeleteMark         = .F.
739:                 .RecordMark         = .F.
740:                 .RowHeight          = 16
741:                 .ScrollBars         = 2
742:                 .Themes             = .F.
743: 
744:                 *-- Column1: CheckBox para Marca (campo booleano de selecao)
745:                 WITH .Column1
746:                     .Width = 25
747:                     .Header1.Caption = ""
748:                     .AddObject("Check1", "CheckBox")
749:                     .Check1.Caption = ""
750:                     .Check1.Value = 0
751:                     .CurrentControl = "Check1"
752:                     .ControlSource = "cursor_4c_TipoMov.Marca"
753:                     .Visible = .T.
754:                 ENDWITH
755: 
756:                 *-- Column2: Descricao do tipo de movimentacao
757:                 WITH .Column2
758:                     .Width = 224
759:                     .ControlSource = "cursor_4c_TipoMov.Descri"
760:                     .ReadOnly = .T.
761:                     .Header1.Caption = "Descrs"
762:                     .Visible = .T.
763:                 ENDWITH
764: 
765:                 .Visible = .T.
766:             ENDWITH
767: 
768:             *-- Re-definir ControlSource apos RecordSource (auto-bind por ordem de campo pode sobrescrever)
769:             loc_oGrid.Column1.ControlSource = "cursor_4c_TipoMov.Marca"
770:             loc_oGrid.Column2.ControlSource = "cursor_4c_TipoMov.Descri"
771: 
772:             *-- Botoes SelTudo / Apaga (direita do grid)
773:             loc_oPagina.AddObject("cmd_4c_SelTudo", "CommandButton")
774:             WITH loc_oPagina.cmd_4c_SelTudo
775:                 .Top          = 186
776:                 .Left         = 763
777:                 .Width        = 35
778:                 .Height       = 34
779:                 .Caption      = ""
780:                 .Picture      = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
781:                 .ToolTipText  = "Selecionar Todos"
782:                 .FontName     = "Tahoma"
783:                 .FontSize     = 8
784:                 .ForeColor    = RGB(90, 90, 90)
785:                 .BackColor    = RGB(255, 255, 255)

*-- Linhas 1537 a 1555:
1537:                         IF USED("TmpRelat") AND RECCOUNT("TmpRelat") > 0
1538:                             loc_cArquivo = ADDBS(SYS(2023)) + "SigReCmp_" + ;
1539:                                 DTOS(DATE()) + "_" + STRTRAN(TIME(), ":", "") + ".xls"
1540:                             SELECT TmpRelat
1541:                             COPY TO (loc_cArquivo) TYPE XLS
1542:                             IF FILE(loc_cArquivo)
1543:                                 DECLARE INTEGER ShellExecute IN shell32.dll ;
1544:                                     INTEGER hndWin, STRING cAction, STRING cFileName, ;
1545:                                     STRING cParams, STRING cDir, INTEGER nShowWin
1546:                                 ShellExecute(0, "open", loc_cArquivo, "", "", 1)
1547:                                 MsgInfo("Arquivo exportado para:" + CHR(13) + loc_cArquivo)
1548:                             ELSE
1549:                                 MsgErro("Erro ao exportar para Excel.", "Erro")
1550:                             ENDIF
1551:                         ELSE
1552:                             MsgAviso("Sem dados para exportar.", "Aviso")
1553:                         ENDIF
1554:                     ELSE
1555:                         MsgErro("Erro ao processar relat" + CHR(243) + "rio:" + CHR(13) + ;

*-- Linhas 1745 a 1767:
1745:             ENDIF
1746:             RETURN
1747:         ENDIF
1748:         loc_cSQL = "SELECT Dopes, Descrs FROM SigCdOpe WHERE Dopes = " + ;
1749:                    EscaparSQL(loc_cCod)
1750:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeVal")
1751:         IF loc_nResult > 0
1752:             SELECT cursor_4c_OpeVal
1753:             IF !EOF()
1754:                 IF PEMSTATUS(loc_oPg, "chk_4c_Chkservico", 5)
1755:                     loc_oPg.chk_4c_Chkservico.Enabled = .T.
1756:                 ENDIF
1757:             ELSE
1758:                 IF USED("cursor_4c_OpeVal")
1759:                     USE IN cursor_4c_OpeVal
1760:                 ENDIF
1761:                 THIS.AbrirBuscaOperacao()
1762:                 RETURN
1763:             ENDIF
1764:             IF USED("cursor_4c_OpeVal")
1765:                 USE IN cursor_4c_OpeVal
1766:             ENDIF
1767:         ELSE

*-- Linhas 1782 a 1812:
1782:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1783:                     IF PEMSTATUS(loc_oPg, "txt_4c__operacao", 5) AND ;
1784:                        USED("cursor_4c_BuscaOpe")
1785:                         SELECT cursor_4c_BuscaOpe
1786:                         loc_oPg.txt_4c__operacao.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
1787:                         IF PEMSTATUS(loc_oPg, "chk_4c_Chkservico", 5)
1788:                             loc_oPg.chk_4c_Chkservico.Enabled = .T.
1789:                         ENDIF
1790:                     ENDIF
1791:                 ELSE
1792:                     IF !loc_oBusca.this_lAchouRegistro
1793:                     loc_oBusca.mAddColuna("Dopes",  "", "C" + CHR(243) + "digo")
1794:                     loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1795:                     loc_oBusca.Show()
1796:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
1797:                         SELECT cursor_4c_BuscaOpe
1798:                         IF PEMSTATUS(loc_oPg, "txt_4c__operacao", 5)
1799:                             loc_oPg.txt_4c__operacao.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
1800:                             IF PEMSTATUS(loc_oPg, "chk_4c_Chkservico", 5)
1801:                                 loc_oPg.chk_4c_Chkservico.Enabled = .T.
1802:                             ENDIF
1803:                         ENDIF
1804:                     ENDIF
1805:                     ENDIF
1806:                 ENDIF
1807:                 loc_oBusca.Release()
1808:             ENDIF
1809:             IF USED("cursor_4c_BuscaOpe")
1810:                 USE IN cursor_4c_BuscaOpe
1811:             ENDIF
1812:         CATCH TO loc_oErro

*-- Linhas 1841 a 1862:
1841:             ENDIF
1842:             RETURN
1843:         ENDIF
1844:         loc_cSQL = "SELECT Codigos, Descrs FROM SigCdObs"
1845:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ObsVal")
1846:         IF loc_nResult > 0
1847:             SELECT cursor_4c_ObsVal
1848:             LOCATE FOR Codigos = loc_nCod
1849:             IF !EOF()
1850:                 IF PEMSTATUS(loc_oPg, "txt_4c_DesObs", 5)
1851:                     loc_oPg.txt_4c_DesObs.Value = ALLTRIM(cursor_4c_ObsVal.Descrs)
1852:                     loc_oPg.txt_4c_DesObs.Enabled = .T.
1853:                 ENDIF
1854:             ELSE
1855:                 IF USED("cursor_4c_ObsVal")
1856:                     USE IN cursor_4c_ObsVal
1857:                 ENDIF
1858:                 THIS.AbrirBuscaCodObs()
1859:                 RETURN
1860:             ENDIF
1861:             IF USED("cursor_4c_ObsVal")
1862:                 USE IN cursor_4c_ObsVal

*-- Linhas 1881 a 1914:
1881:             IF VARTYPE(loc_oBusca) = "O"
1882:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1883:                     IF USED("cursor_4c_BuscaObs")
1884:                         SELECT cursor_4c_BuscaObs
1885:                         IF PEMSTATUS(loc_oPg, "txt_4c_CodObs", 5)
1886:                             loc_oPg.txt_4c_CodObs.Value = cursor_4c_BuscaObs.Codigos
1887:                         ENDIF
1888:                         IF PEMSTATUS(loc_oPg, "txt_4c_DesObs", 5)
1889:                             loc_oPg.txt_4c_DesObs.Value = ALLTRIM(cursor_4c_BuscaObs.Descrs)
1890:                             loc_oPg.txt_4c_DesObs.Enabled = .T.
1891:                         ENDIF
1892:                     ENDIF
1893:                 ELSE
1894:                     IF !loc_oBusca.this_lAchouRegistro
1895:                     loc_oBusca.mAddColuna("Codigos", "XXX", "C" + CHR(243) + "digo")
1896:                     loc_oBusca.mAddColuna("Descrs",  "",    "Descri" + CHR(231) + CHR(227) + "o")
1897:                     loc_oBusca.Show()
1898:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaObs")
1899:                         SELECT cursor_4c_BuscaObs
1900:                         IF PEMSTATUS(loc_oPg, "txt_4c_CodObs", 5)
1901:                             loc_oPg.txt_4c_CodObs.Value = cursor_4c_BuscaObs.Codigos
1902:                         ENDIF
1903:                         IF PEMSTATUS(loc_oPg, "txt_4c_DesObs", 5)
1904:                             loc_oPg.txt_4c_DesObs.Value = ALLTRIM(cursor_4c_BuscaObs.Descrs)
1905:                             loc_oPg.txt_4c_DesObs.Enabled = .T.
1906:                         ENDIF
1907:                     ENDIF
1908:                     ENDIF
1909:                 ENDIF
1910:                 loc_oBusca.Release()
1911:             ENDIF
1912:             IF USED("cursor_4c_BuscaObs")
1913:                 USE IN cursor_4c_BuscaObs
1914:             ENDIF

*-- Linhas 1958 a 1990:
1958:             IF VARTYPE(loc_oBusca) = "O"
1959:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1960:                     IF USED("cursor_4c_BuscaObsD")
1961:                         SELECT cursor_4c_BuscaObsD
1962:                         IF PEMSTATUS(loc_oPg, "txt_4c_CodObs", 5)
1963:                             loc_oPg.txt_4c_CodObs.Value = cursor_4c_BuscaObsD.Codigos
1964:                         ENDIF
1965:                         IF PEMSTATUS(loc_oPg, "txt_4c_DesObs", 5)
1966:                             loc_oPg.txt_4c_DesObs.Value = ALLTRIM(cursor_4c_BuscaObsD.Descrs)
1967:                         ENDIF
1968:                     ENDIF
1969:                 ELSE
1970:                     IF !loc_oBusca.this_lAchouRegistro
1971:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1972:                     loc_oBusca.mAddColuna("Codigos", "XXX", "C" + CHR(243) + "digo")
1973:                     loc_oBusca.Show()
1974:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaObsD")
1975:                         SELECT cursor_4c_BuscaObsD
1976:                         IF PEMSTATUS(loc_oPg, "txt_4c_CodObs", 5)
1977:                             loc_oPg.txt_4c_CodObs.Value = cursor_4c_BuscaObsD.Codigos
1978:                         ENDIF
1979:                         IF PEMSTATUS(loc_oPg, "txt_4c_DesObs", 5)
1980:                             loc_oPg.txt_4c_DesObs.Value = ALLTRIM(cursor_4c_BuscaObsD.Descrs)
1981:                         ENDIF
1982:                     ENDIF
1983:                     ENDIF
1984:                 ENDIF
1985:                 loc_oBusca.Release()
1986:             ENDIF
1987:             IF USED("cursor_4c_BuscaObsD")
1988:                 USE IN cursor_4c_BuscaObsD
1989:             ENDIF
1990:         CATCH TO loc_oErro

*-- Linhas 2019 a 2041:
2019:             ENDIF
2020:             RETURN
2021:         ENDIF
2022:         loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
2023:                    EscaparSQL(loc_cCod)
2024:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
2025:         IF loc_nResult > 0
2026:             SELECT cursor_4c_EmpVal
2027:             IF !EOF()
2028:                 IF PEMSTATUS(loc_oPg, "txt_4c__empresa_desc", 5)
2029:                     loc_oPg.txt_4c__empresa_desc.Value = ALLTRIM(cursor_4c_EmpVal.Razas)
2030:                     loc_oPg.txt_4c__empresa_desc.Enabled = .T.
2031:                 ENDIF
2032:             ELSE
2033:                 IF USED("cursor_4c_EmpVal")
2034:                     USE IN cursor_4c_EmpVal
2035:                 ENDIF
2036:                 THIS.AbrirBuscaEmpresa()
2037:                 RETURN
2038:             ENDIF
2039:             IF USED("cursor_4c_EmpVal")
2040:                 USE IN cursor_4c_EmpVal
2041:             ENDIF

*-- Linhas 2055 a 2088:
2055:             IF VARTYPE(loc_oBusca) = "O"
2056:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2057:                     IF USED("cursor_4c_BuscaEmp")
2058:                         SELECT cursor_4c_BuscaEmp
2059:                         IF PEMSTATUS(loc_oPg, "txt_4c__empresa", 5)
2060:                             loc_oPg.txt_4c__empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
2061:                         ENDIF
2062:                         IF PEMSTATUS(loc_oPg, "txt_4c__empresa_desc", 5)
2063:                             loc_oPg.txt_4c__empresa_desc.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
2064:                             loc_oPg.txt_4c__empresa_desc.Enabled = .T.
2065:                         ENDIF
2066:                     ENDIF
2067:                 ELSE
2068:                     IF !loc_oBusca.this_lAchouRegistro
2069:                     loc_oBusca.mAddColuna("Cemps", "XXX", "C" + CHR(243) + "digo")
2070:                     loc_oBusca.mAddColuna("Razas", "",    "Raz" + CHR(227) + "o Social")
2071:                     loc_oBusca.Show()
2072:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
2073:                         SELECT cursor_4c_BuscaEmp
2074:                         IF PEMSTATUS(loc_oPg, "txt_4c__empresa", 5)
2075:                             loc_oPg.txt_4c__empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
2076:                         ENDIF
2077:                         IF PEMSTATUS(loc_oPg, "txt_4c__empresa_desc", 5)
2078:                             loc_oPg.txt_4c__empresa_desc.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
2079:                             loc_oPg.txt_4c__empresa_desc.Enabled = .T.
2080:                         ENDIF
2081:                     ENDIF
2082:                     ENDIF
2083:                 ENDIF
2084:                 loc_oBusca.Release()
2085:             ENDIF
2086:             IF USED("cursor_4c_BuscaEmp")
2087:                 USE IN cursor_4c_BuscaEmp
2088:             ENDIF

*-- Linhas 2154 a 2175:
2154:             ENDIF
2155:             RETURN
2156:         ENDIF
2157:         loc_cSQL = "SELECT codigos, descs FROM SigCdGpr"
2158:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GGruVal")
2159:         IF loc_nResult > 0
2160:             SELECT cursor_4c_GGruVal
2161:             LOCATE FOR ALLTRIM(STR(codigos, 5)) = ALLTRIM(loc_cCod)
2162:             IF !EOF()
2163:                 IF PEMSTATUS(loc_oPg, "txt_4c__cd_ggrupo", 5)
2164:                     loc_oPg.txt_4c__cd_ggrupo.Value = ;
2165:                         ALLTRIM(STR(cursor_4c_GGruVal.codigos, 2))
2166:                 ENDIF
2167:                 IF PEMSTATUS(loc_oPg, "txt_4c__ds_ggrupo", 5)
2168:                     loc_oPg.txt_4c__ds_ggrupo.Value = ALLTRIM(cursor_4c_GGruVal.descs)
2169:                     loc_oPg.txt_4c__ds_ggrupo.Enabled = .T.
2170:                 ENDIF
2171:             ELSE
2172:                 IF USED("cursor_4c_GGruVal")
2173:                     USE IN cursor_4c_GGruVal
2174:                 ENDIF
2175:                 THIS.AbrirBuscaGrdGrupo()

*-- Linhas 2195 a 2229:
2195:             IF VARTYPE(loc_oBusca) = "O"
2196:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2197:                     IF USED("cursor_4c_BuscaGGru")
2198:                         SELECT cursor_4c_BuscaGGru
2199:                         IF PEMSTATUS(loc_oPg, "txt_4c__cd_ggrupo", 5)
2200:                             loc_oPg.txt_4c__cd_ggrupo.Value = ;
2201:                                 ALLTRIM(STR(cursor_4c_BuscaGGru.codigos, 2))
2202:                         ENDIF
2203:                         IF PEMSTATUS(loc_oPg, "txt_4c__ds_ggrupo", 5)
2204:                             loc_oPg.txt_4c__ds_ggrupo.Value = ALLTRIM(cursor_4c_BuscaGGru.descs)
2205:                             loc_oPg.txt_4c__ds_ggrupo.Enabled = .T.
2206:                         ENDIF
2207:                     ENDIF
2208:                 ELSE
2209:                     IF !loc_oBusca.this_lAchouRegistro
2210:                     loc_oBusca.mAddColuna("codigos", "",  "C" + CHR(243) + "digo")
2211:                     loc_oBusca.mAddColuna("descs",   "",  "Descri" + CHR(231) + CHR(227) + "o")
2212:                     loc_oBusca.Show()
2213:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGGru")
2214:                         SELECT cursor_4c_BuscaGGru
2215:                         IF PEMSTATUS(loc_oPg, "txt_4c__cd_ggrupo", 5)
2216:                             loc_oPg.txt_4c__cd_ggrupo.Value = ;
2217:                                 ALLTRIM(STR(cursor_4c_BuscaGGru.codigos, 2))
2218:                         ENDIF
2219:                         IF PEMSTATUS(loc_oPg, "txt_4c__ds_ggrupo", 5)
2220:                             loc_oPg.txt_4c__ds_ggrupo.Value = ALLTRIM(cursor_4c_BuscaGGru.descs)
2221:                             loc_oPg.txt_4c__ds_ggrupo.Enabled = .T.
2222:                         ENDIF
2223:                     ENDIF
2224:                     ENDIF
2225:                 ENDIF
2226:                 loc_oBusca.Release()
2227:             ENDIF
2228:             IF USED("cursor_4c_BuscaGGru")
2229:                 USE IN cursor_4c_BuscaGGru

*-- Linhas 2270 a 2304:
2270:                 IF VARTYPE(loc_oBusca) = "O"
2271:                     IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2272:                         IF USED("cursor_4c_BuscaGGruD")
2273:                             SELECT cursor_4c_BuscaGGruD
2274:                             IF PEMSTATUS(loc_oPg, "txt_4c__cd_ggrupo", 5)
2275:                                 loc_oPg.txt_4c__cd_ggrupo.Value = ;
2276:                                     ALLTRIM(STR(cursor_4c_BuscaGGruD.codigos, 2))
2277:                             ENDIF
2278:                             IF PEMSTATUS(loc_oPg, "txt_4c__ds_ggrupo", 5)
2279:                                 loc_oPg.txt_4c__ds_ggrupo.Value = ;
2280:                                     ALLTRIM(cursor_4c_BuscaGGruD.descs)
2281:                             ENDIF
2282:                         ENDIF
2283:                     ELSE
2284:                         IF !loc_oBusca.this_lAchouRegistro
2285:                         loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
2286:                         loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
2287:                         loc_oBusca.Show()
2288:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGGruD")
2289:                             SELECT cursor_4c_BuscaGGruD
2290:                             IF PEMSTATUS(loc_oPg, "txt_4c__cd_ggrupo", 5)
2291:                                 loc_oPg.txt_4c__cd_ggrupo.Value = ;
2292:                                     ALLTRIM(STR(cursor_4c_BuscaGGruD.codigos, 2))
2293:                             ENDIF
2294:                             IF PEMSTATUS(loc_oPg, "txt_4c__ds_ggrupo", 5)
2295:                                 loc_oPg.txt_4c__ds_ggrupo.Value = ;
2296:                                     ALLTRIM(cursor_4c_BuscaGGruD.descs)
2297:                             ENDIF
2298:                         ENDIF
2299:                         ENDIF
2300:                     ENDIF
2301:                     loc_oBusca.Release()
2302:                 ENDIF
2303:                 IF USED("cursor_4c_BuscaGGruD")
2304:                     USE IN cursor_4c_BuscaGGruD

*-- Linhas 2336 a 2358:
2336:             ENDIF
2337:             RETURN
2338:         ENDIF
2339:         loc_cSQL = "SELECT CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + ;
2340:                    EscaparSQL(loc_cCod)
2341:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruVal")
2342:         IF loc_nResult > 0
2343:             SELECT cursor_4c_GruVal
2344:             IF !EOF()
2345:                 IF PEMSTATUS(loc_oPg, "txt_4c__grupo_desc", 5)
2346:                     loc_oPg.txt_4c__grupo_desc.Value = ALLTRIM(cursor_4c_GruVal.DGrus)
2347:                     loc_oPg.txt_4c__grupo_desc.Enabled = .T.
2348:                 ENDIF
2349:             ELSE
2350:                 IF USED("cursor_4c_GruVal")
2351:                     USE IN cursor_4c_GruVal
2352:                 ENDIF
2353:                 THIS.AbrirBuscaGrupo()
2354:                 RETURN
2355:             ENDIF
2356:             IF USED("cursor_4c_GruVal")
2357:                 USE IN cursor_4c_GruVal
2358:             ENDIF

*-- Linhas 2373 a 2406:
2373:             IF VARTYPE(loc_oBusca) = "O"
2374:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2375:                     IF USED("cursor_4c_BuscaGru")
2376:                         SELECT cursor_4c_BuscaGru
2377:                         IF PEMSTATUS(loc_oPg, "txt_4c__grupo", 5)
2378:                             loc_oPg.txt_4c__grupo.Value = ALLTRIM(cursor_4c_BuscaGru.CGrus)
2379:                         ENDIF
2380:                         IF PEMSTATUS(loc_oPg, "txt_4c__grupo_desc", 5)
2381:                             loc_oPg.txt_4c__grupo_desc.Value = ALLTRIM(cursor_4c_BuscaGru.DGrus)
2382:                             loc_oPg.txt_4c__grupo_desc.Enabled = .T.
2383:                         ENDIF
2384:                     ENDIF
2385:                 ELSE
2386:                     IF !loc_oBusca.this_lAchouRegistro
2387:                     loc_oBusca.mAddColuna("CGrus", "XXX", "C" + CHR(243) + "digo")
2388:                     loc_oBusca.mAddColuna("DGrus", "",    "Descri" + CHR(231) + CHR(227) + "o")
2389:                     loc_oBusca.Show()
2390:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGru")
2391:                         SELECT cursor_4c_BuscaGru
2392:                         IF PEMSTATUS(loc_oPg, "txt_4c__grupo", 5)
2393:                             loc_oPg.txt_4c__grupo.Value = ALLTRIM(cursor_4c_BuscaGru.CGrus)
2394:                         ENDIF
2395:                         IF PEMSTATUS(loc_oPg, "txt_4c__grupo_desc", 5)
2396:                             loc_oPg.txt_4c__grupo_desc.Value = ALLTRIM(cursor_4c_BuscaGru.DGrus)
2397:                             loc_oPg.txt_4c__grupo_desc.Enabled = .T.
2398:                         ENDIF
2399:                     ENDIF
2400:                     ENDIF
2401:                 ENDIF
2402:                 loc_oBusca.Release()
2403:             ENDIF
2404:             IF USED("cursor_4c_BuscaGru")
2405:                 USE IN cursor_4c_BuscaGru
2406:             ENDIF

*-- Linhas 2442 a 2474:
2442:                 IF VARTYPE(loc_oBusca) = "O"
2443:                     IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2444:                         IF USED("cursor_4c_BuscaGruD")
2445:                             SELECT cursor_4c_BuscaGruD
2446:                             IF PEMSTATUS(loc_oPg, "txt_4c__grupo", 5)
2447:                                 loc_oPg.txt_4c__grupo.Value = ALLTRIM(cursor_4c_BuscaGruD.CGrus)
2448:                             ENDIF
2449:                             IF PEMSTATUS(loc_oPg, "txt_4c__grupo_desc", 5)
2450:                                 loc_oPg.txt_4c__grupo_desc.Value = ALLTRIM(cursor_4c_BuscaGruD.DGrus)
2451:                             ENDIF
2452:                         ENDIF
2453:                     ELSE
2454:                         IF !loc_oBusca.this_lAchouRegistro
2455:                         loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
2456:                         loc_oBusca.mAddColuna("CGrus", "XXX", "C" + CHR(243) + "digo")
2457:                         loc_oBusca.Show()
2458:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGruD")
2459:                             SELECT cursor_4c_BuscaGruD
2460:                             IF PEMSTATUS(loc_oPg, "txt_4c__grupo", 5)
2461:                                 loc_oPg.txt_4c__grupo.Value = ALLTRIM(cursor_4c_BuscaGruD.CGrus)
2462:                             ENDIF
2463:                             IF PEMSTATUS(loc_oPg, "txt_4c__grupo_desc", 5)
2464:                                 loc_oPg.txt_4c__grupo_desc.Value = ALLTRIM(cursor_4c_BuscaGruD.DGrus)
2465:                             ENDIF
2466:                         ENDIF
2467:                         ENDIF
2468:                     ENDIF
2469:                     loc_oBusca.Release()
2470:                 ENDIF
2471:                 IF USED("cursor_4c_BuscaGruD")
2472:                     USE IN cursor_4c_BuscaGruD
2473:                 ENDIF
2474:             ENDIF

*-- Linhas 2504 a 2525:
2504:             ENDIF
2505:             RETURN
2506:         ENDIF
2507:         loc_cSQL = "SELECT Codigos, Descricaos, CGrus FROM SigCdPsg"
2508:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SGruVal")
2509:         IF loc_nResult > 0
2510:             SELECT cursor_4c_SGruVal
2511:             LOCATE FOR Codigos = loc_cCod
2512:             IF !EOF()
2513:                 IF PEMSTATUS(loc_oPg, "txt_4c__cd_sgrupo", 5)
2514:                     loc_oPg.txt_4c__cd_sgrupo.Value = ALLTRIM(cursor_4c_SGruVal.Codigos)
2515:                 ENDIF
2516:                 IF PEMSTATUS(loc_oPg, "txt_4c__ds_sgrupo", 5)
2517:                     loc_oPg.txt_4c__ds_sgrupo.Value = ALLTRIM(cursor_4c_SGruVal.Descricaos)
2518:                     loc_oPg.txt_4c__ds_sgrupo.Enabled = .T.
2519:                 ENDIF
2520:             ELSE
2521:                 IF USED("cursor_4c_SGruVal")
2522:                     USE IN cursor_4c_SGruVal
2523:                 ENDIF
2524:                 THIS.AbrirBuscaSubGrupo()
2525:                 RETURN

*-- Linhas 2544 a 2581:
2544:             IF VARTYPE(loc_oBusca) = "O"
2545:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2546:                     IF USED("cursor_4c_BuscaSGru")
2547:                         SELECT cursor_4c_BuscaSGru
2548:                         IF PEMSTATUS(loc_oPg, "txt_4c__cd_sgrupo", 5)
2549:                             loc_oPg.txt_4c__cd_sgrupo.Value = ;
2550:                                 ALLTRIM(cursor_4c_BuscaSGru.Codigos)
2551:                         ENDIF
2552:                         IF PEMSTATUS(loc_oPg, "txt_4c__ds_sgrupo", 5)
2553:                             loc_oPg.txt_4c__ds_sgrupo.Value = ;
2554:                                 ALLTRIM(cursor_4c_BuscaSGru.Descricaos)
2555:                             loc_oPg.txt_4c__ds_sgrupo.Enabled = .T.
2556:                         ENDIF
2557:                     ENDIF
2558:                 ELSE
2559:                     IF !loc_oBusca.this_lAchouRegistro
2560:                     loc_oBusca.mAddColuna("Codigos",    "XXXXXXXXXX", "Sub-Grupo")
2561:                     loc_oBusca.mAddColuna("Descricaos", "XXXXXXXXXXXXXXXXXXXX", ;
2562:                         "Descri" + CHR(231) + CHR(227) + "o")
2563:                     loc_oBusca.mAddColuna("CGrus", "XXXXXXXXXX", "Grupo")
2564:                     loc_oBusca.Show()
2565:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSGru")
2566:                         SELECT cursor_4c_BuscaSGru
2567:                         IF PEMSTATUS(loc_oPg, "txt_4c__cd_sgrupo", 5)
2568:                             loc_oPg.txt_4c__cd_sgrupo.Value = ;
2569:                                 ALLTRIM(cursor_4c_BuscaSGru.Codigos)
2570:                         ENDIF
2571:                         IF PEMSTATUS(loc_oPg, "txt_4c__ds_sgrupo", 5)
2572:                             loc_oPg.txt_4c__ds_sgrupo.Value = ;
2573:                                 ALLTRIM(cursor_4c_BuscaSGru.Descricaos)
2574:                             loc_oPg.txt_4c__ds_sgrupo.Enabled = .T.
2575:                         ENDIF
2576:                     ENDIF
2577:                     ENDIF
2578:                 ENDIF
2579:                 loc_oBusca.Release()
2580:             ENDIF
2581:             IF USED("cursor_4c_BuscaSGru")

*-- Linhas 2619 a 2655:
2619:                 IF VARTYPE(loc_oBusca) = "O"
2620:                     IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2621:                         IF USED("cursor_4c_BuscaSGruD")
2622:                             SELECT cursor_4c_BuscaSGruD
2623:                             IF PEMSTATUS(loc_oPg, "txt_4c__cd_sgrupo", 5)
2624:                                 loc_oPg.txt_4c__cd_sgrupo.Value = ;
2625:                                     ALLTRIM(cursor_4c_BuscaSGruD.Codigos)
2626:                             ENDIF
2627:                             IF PEMSTATUS(loc_oPg, "txt_4c__ds_sgrupo", 5)
2628:                                 loc_oPg.txt_4c__ds_sgrupo.Value = ;
2629:                                     ALLTRIM(cursor_4c_BuscaSGruD.Descricaos)
2630:                             ENDIF
2631:                         ENDIF
2632:                     ELSE
2633:                         IF !loc_oBusca.this_lAchouRegistro
2634:                         loc_oBusca.mAddColuna("Descricaos", "XXXXXXXXXXXXXXXXXXXX", ;
2635:                             "Descri" + CHR(231) + CHR(227) + "o")
2636:                         loc_oBusca.mAddColuna("Codigos",    "XXXXXXXXXX", "Sub-Grupo")
2637:                         loc_oBusca.mAddColuna("CGrus",      "XXXXXXXXXX", "Grupo")
2638:                         loc_oBusca.Show()
2639:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSGruD")
2640:                             SELECT cursor_4c_BuscaSGruD
2641:                             IF PEMSTATUS(loc_oPg, "txt_4c__cd_sgrupo", 5)
2642:                                 loc_oPg.txt_4c__cd_sgrupo.Value = ;
2643:                                     ALLTRIM(cursor_4c_BuscaSGruD.Codigos)
2644:                             ENDIF
2645:                             IF PEMSTATUS(loc_oPg, "txt_4c__ds_sgrupo", 5)
2646:                                 loc_oPg.txt_4c__ds_sgrupo.Value = ;
2647:                                     ALLTRIM(cursor_4c_BuscaSGruD.Descricaos)
2648:                             ENDIF
2649:                         ENDIF
2650:                         ENDIF
2651:                     ENDIF
2652:                     loc_oBusca.Release()
2653:                 ENDIF
2654:                 IF USED("cursor_4c_BuscaSGruD")
2655:                     USE IN cursor_4c_BuscaSGruD


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
            SET NULL ON
            CREATE CURSOR cursor_4c_TipoMov (Marca N(1), Descri C(40), Codigos N(2))
            SET NULL OFF
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

