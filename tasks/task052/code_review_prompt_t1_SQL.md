# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'MAXLENGTH' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DESCS, X, DATAS, DOPES, EMPS, CONTADS, EMPDOPNUMS, GRUPOS, CONTAVENS, NMARCA, NUMES, ICLIS, CODIGOS, CONTAOS, CPROS, LNOPTCOMP, LNCOMPA, NVALCOMP, NQTDE, LNORDEM, ORDEM, 1, CICLIS, CEMPS, CMOES, UFIBGES, ESTADOS

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
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
lcQuery = [Select a.Codigos ] + ;
		    [From SigCdMun a, SigCdUfs b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalMunic]) < 1)
Select LocalMunic
Insert Into CsCabecalho ( nm_empresa,nm_titulo,nm_periodo,nm_tipo,nm_Comparativo,nm_OptComp);
Select CsCabecalho
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select a.emps,a.dopes,a.numes,a.empdopnums,a.datas,a.valos,a.contads,a.contaos,]+;
	   [From SigMvCab a, SigCdOpe b ]+;
	lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select a.emps,a.dopes,a.numes,a.empdopnums,a.datas,a.valos,a.contads,a.contaos,]+;
				[From SigMvCab a, SigCdOpe b, SigMvEtv e ]+;
	SELECT cursorx
		INSERT into crSigMvCab from memvar
	lcSql = [Select a.Iclis,a.Rclis,a.ContaVens,b.Rclis as dVends From SigCdCli a Left Join SigCdCli b On a.ContaVens = b.Iclis where a.Grupos = ']+CrSigCdPam.GrPadClis+[']
	If Thisform.Podatamgr.Sqlexecute(lcSql,'TmpCliente') < 1
	Select CrSigMvCab
		loBarra.UpDate(.T.)
				Select CrSigMvCab
			Select CrSigCdTom
			=Seek(lcTipoOpe,'CrSigCdTom','codigos')
				Select CrSigMvCab
				lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select emps,dopes,numes,valtots,moeds From SigMvMov ]+;
				Select TmpEstMo
					Select CrSigMvCab
					Select CrSigMvCab
								Select CrSigMvCab
								lnQueryOk = ThisForm.poDataMgr.Sqlexecute([Select emps,dopes,numes,totas From SigMvItn ]+;
								Select TprMvCabi
									Select CrSigMvCab
								Select CrSigMvCab
		Select CrSigMvCab
		lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select iclis,rclis,codigos,grupos,contavens,cidas,estas From SigCdCli ]+;
		Select TmpCli
			lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select codigos,descs,grupos From SigCdClc ]+;
			Select TmpClaCo
			lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select iclis,rclis From SigCdCli ]+;
			Select TmpCli
			lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select iclis,rclis,codigos,grupos,tabds From SigCdCli ]+;
			Select TmpCli
					lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select codigos,descs From SigCdClc ]+;
					Select TmpClaCo
			Select TmpResult
	lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select a.contads,a.contaos,a.vends,b.emps,b.dopes,b.numes,b.cunis,]+;
		   [From SigMvCab a,SigMvItn b,SigCdOpe c ]+;
		lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select a.contads,a.contaos, e.contas as vends,b.emps,b.dopes,b.numes,b.cunis,]+;
					[From SigMvCab a,SigMvItn b,SigCdOpe c, sigmvetv e ]+;
		SELECT cursorx
			INSERT into TmpQuant from memvar
	Select TmpQuant
				Select TmpQuant
			Select CrSigCdTom
			=Seek(lcTipoOpe,'CrSigCdTom','codigos')
				Select TmpQuant
			Select TmpQuant
			Select TmpQuant
		lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select iclis,rclis,codigos,grupos,contavens,cidas,estas From SigCdCli ]+;
		Select TmpCli
			lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select codigos,descs,grupos From SigCdClc ]+;
			Select TmpClaCo
			lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select iclis,rclis From SigCdCli ]+;
			Select TmpCli
			lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select iclis,rclis,codigos,grupos,tabds From SigCdCli ]+;
			Select TmpCli
					lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select codigos,descs From SigCdClc ]+;
					Select TmpClaCo
		Select TmpQuant
			Select TmpResult
		Select TmpQuant
Select TmpResult
Delete For IsEmpty(ciclis) And lnOptComp = 2 And lnCompa = 1
	Select TmpResult
Select TmpResult
Select Tmpresult
Select TmpResult
		Delete For TmpResult.nValComp < lnQtMin
		Delete For TmpResult.nqtde < lnQtMin
	Delete For TmpResult.ordem > lnQtde
	Select * ;
	  From TmpCliente ;
	 Where Iclis Not In (Select cIclis From TmpResult) ;
		Delete From Selecao Where ContaVens <> lcCVendedor
	Select TmpResult
	Select Selecao
		Insert Into TmpResult (Quebras, ciClis, cRclis, Ordem) ;
		SELECT tmpResult
		lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select iclis,rclis,razaos,cidas,estas,contato,emails,tel1s From SigCdCli ]+;
		SELECT a.*, b.* from tmpResult a, crCli b where a.ciclis = b.iclis into cursor tmpResult readwrite
	SELECT tmpresult
Select TmpResult
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select moedaps,GrPadClis From SigCdPam ],'CrSigCdPam')
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select cemps,razas From SigCdEmp Where cemps = ']+_Empr+[' ],'CrSigCdEmp')
lnQueryOk = ThisForm.poDataSql.SqlExecute([Select 0 As nMarca,codigos,Str(codigos,2) + '-' + descrs As Descri ]+;
	   [From SigCdTom ],'CrSigCdTom')
Select CrSigCdPam
Select CrSigCdEmp
Select CrSigCdTom
	.Column1.ControlSource = 'CrSigCdTom.nMarca'
	.Column3.ControlSource = 'CrSigCdTom.Descri'
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select cmoes,dmoes From SigCdMoe ]+;
Select TmpMoe
Select CrSigCdTom
Select CrSigCdTom

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecmc.prg) - TRECHOS RELEVANTES PARA PASS SQL (2064 linhas total):

*-- Linhas 983 a 1001:
983:             .Height       = 218
984:             .ColumnCount  = 2
985:             .AllowRowSizing = .F.
986:             .DeleteMark   = .F.
987:             .GridLines    = 3
988:             .HeaderHeight = 0
989:             .RowHeight    = 18
990:             .ScrollBars   = 2
991:             .RecordMark   = .F.
992:             .GridLineColor = RGB(255, 255, 255)
993:             .Themes       = .F.
994:             .Visible      = .T.
995:         ENDWITH
996: 
997:         *-- Column1: CheckBox para nMarca (Width=20, Sparse=.F.)
998:         WITH loc_oGrd.Column1
999:             .Width         = 20
1000:             .Sparse        = .F.
1001:             .Enabled       = .T.

*-- Linhas 1025 a 1044:
1025:         *-- Vincular grid ao cursor CrSigCdTom
1026:         IF USED("CrSigCdTom")
1027:             loc_oGrd.RecordSource              = "CrSigCdTom"
1028:             loc_oGrd.Column1.ControlSource     = "CrSigCdTom.nMarca"
1029:             loc_oGrd.Column2.ControlSource     = "CrSigCdTom.Descri"
1030:         ENDIF
1031: 
1032:         *-- Botao Selecionar todos (SelTudo: L=735, T=204->119, W=45, H=45)
1033:         loc_oPg.AddObject("cmd_4c_SelTudo", "CommandButton")
1034:         WITH loc_oPg.cmd_4c_SelTudo
1035:             .Top           = 119
1036:             .Left          = 735
1037:             .Width         = 45
1038:             .Height        = 45
1039:             .Caption       = ""
1040:             .FontName      = "Verdana"
1041:             .FontSize      = 8
1042:             .ForeColor     = RGB(36, 84, 155)
1043:             .BackColor     = RGB(255, 255, 255)
1044:             .Themes        = .F.

*-- Linhas 1506 a 1533:
1506: 
1507:     PROCEDURE CmdSelTudoClick()
1508:         IF USED("CrSigCdTom")
1509:             SELECT CrSigCdTom
1510:             REPLACE ALL CrSigCdTom.nMarca WITH 1
1511:             GO TOP
1512:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1513:         ENDIF
1514:     ENDPROC
1515: 
1516:     PROCEDURE CmdApagaClick()
1517:         IF USED("CrSigCdTom")
1518:             SELECT CrSigCdTom
1519:             REPLACE ALL CrSigCdTom.nMarca WITH 0
1520:             GO TOP
1521:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1522:         ENDIF
1523:     ENDPROC
1524: 
1525:     PROCEDURE CmdGraficosClick()
1526:         MsgInfo("Gr" + CHR(225) + "ficos n" + CHR(227) + "o dispon" + CHR(237) + ;
1527:             "vel nesta vers" + CHR(227) + "o.", "Informa" + CHR(231) + CHR(227) + "o")
1528:     ENDPROC
1529: 
1530:     *==========================================================================
1531:     * KEYPRESS HANDLERS
1532:     *==========================================================================
1533: 

*-- Linhas 1789 a 1807:
1789:         loc_oBusca.Show()
1790: 
1791:         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpresa")
1792:             SELECT cursor_4c_BuscaEmpresa
1793:             IF !EOF()
1794:                 loc_oPg.txt_4c_Empresa.Value  = ALLTRIM(cemps)
1795:                 loc_oPg.txt_4c_DEmpresa.Value = ALLTRIM(razas)
1796:             ENDIF
1797:         ENDIF
1798:         IF USED("cursor_4c_BuscaEmpresa")
1799:             USE IN cursor_4c_BuscaEmpresa
1800:         ENDIF
1801:         loc_oBusca.Release()
1802:     ENDPROC
1803: 
1804:     PROTECTED PROCEDURE AbrirBuscaOperacao()
1805:         LOCAL loc_oBusca, loc_oPg, loc_cValor
1806:         loc_oPg   = THIS.pgf_4c_Paginas.Page1
1807:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_NmOperacao.Value)

*-- Linhas 1817 a 1835:
1817:         loc_oBusca.Show()
1818: 
1819:         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
1820:             SELECT cursor_4c_BuscaOpe
1821:             IF !EOF()
1822:                 loc_oPg.txt_4c_NmOperacao.Value = ALLTRIM(dopes)
1823:             ENDIF
1824:         ENDIF
1825:         IF USED("cursor_4c_BuscaOpe")
1826:             USE IN cursor_4c_BuscaOpe
1827:         ENDIF
1828:         loc_oBusca.Release()
1829:     ENDPROC
1830: 
1831:     PROTECTED PROCEDURE AbrirBuscaMoeda(par_cTipo)
1832:         LOCAL loc_oBusca, loc_oPg, loc_cValor, loc_cCampo
1833:         loc_oPg = THIS.pgf_4c_Paginas.Page1
1834:         IF par_cTipo = "C"
1835:             loc_cValor = ALLTRIM(loc_oPg.txt_4c_Moeda.Value)

*-- Linhas 1850 a 1868:
1850:         loc_oBusca.Show()
1851: 
1852:         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
1853:             SELECT cursor_4c_BuscaMoeda
1854:             IF !EOF()
1855:                 loc_oPg.txt_4c_Moeda.Value     = ALLTRIM(cmoes)
1856:                 loc_oPg.txt_4c_MoedaDesc.Value = ALLTRIM(dmoes)
1857:             ENDIF
1858:         ENDIF
1859:         IF USED("cursor_4c_BuscaMoeda")
1860:             USE IN cursor_4c_BuscaMoeda
1861:         ENDIF
1862:         loc_oBusca.Release()
1863:     ENDPROC
1864: 
1865:     PROTECTED PROCEDURE AbrirBuscaConta(par_cTipo)
1866:         LOCAL loc_oBusca, loc_oPg, loc_cValor, loc_cCampo
1867:         loc_oPg = THIS.pgf_4c_Paginas.Page1
1868:         IF par_cTipo = "C"

*-- Linhas 1884 a 1902:
1884:         loc_oBusca.Show()
1885: 
1886:         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1887:             SELECT cursor_4c_BuscaConta
1888:             IF !EOF()
1889:                 loc_oPg.txt_4c_CdConta.Value = ALLTRIM(iclis)
1890:                 loc_oPg.txt_4c_DsConta.Value = ALLTRIM(rclis)
1891:             ENDIF
1892:         ENDIF
1893:         IF USED("cursor_4c_BuscaConta")
1894:             USE IN cursor_4c_BuscaConta
1895:         ENDIF
1896:         loc_oBusca.Release()
1897:     ENDPROC
1898: 
1899:     PROTECTED PROCEDURE AbrirBuscaVendedor(par_cTipo)
1900:         LOCAL loc_oBusca, loc_oPg, loc_cValor, loc_cCampo
1901:         loc_oPg = THIS.pgf_4c_Paginas.Page1
1902:         IF par_cTipo = "C"

*-- Linhas 1918 a 1936:
1918:         loc_oBusca.Show()
1919: 
1920:         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVendedor")
1921:             SELECT cursor_4c_BuscaVendedor
1922:             IF !EOF()
1923:                 loc_oPg.txt_4c_CdVendedor.Value = ALLTRIM(iclis)
1924:                 loc_oPg.txt_4c_DsVendedor.Value = ALLTRIM(rclis)
1925:             ENDIF
1926:         ENDIF
1927:         IF USED("cursor_4c_BuscaVendedor")
1928:             USE IN cursor_4c_BuscaVendedor
1929:         ENDIF
1930:         loc_oBusca.Release()
1931:     ENDPROC
1932: 
1933:     PROTECTED PROCEDURE AbrirBuscaProduto(par_cTipo)
1934:         LOCAL loc_oBusca, loc_oPg, loc_cValor, loc_cCampo
1935:         loc_oPg = THIS.pgf_4c_Paginas.Page1
1936:         IF par_cTipo = "C"

*-- Linhas 1952 a 1970:
1952:         loc_oBusca.Show()
1953: 
1954:         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
1955:             SELECT cursor_4c_BuscaProduto
1956:             IF !EOF()
1957:                 loc_oPg.txt_4c_CdProduto.Value = ALLTRIM(cpros)
1958:                 loc_oPg.txt_4c_DsProduto.Value = ALLTRIM(dpros)
1959:             ENDIF
1960:         ENDIF
1961:         IF USED("cursor_4c_BuscaProduto")
1962:             USE IN cursor_4c_BuscaProduto
1963:         ENDIF
1964:         loc_oBusca.Release()
1965:         THIS.AjustarCamposProduto()
1966:     ENDPROC
1967: 
1968:     *==========================================================================
1969:     * COMPATIBILIDADE API CRUD
1970:     *==========================================================================

