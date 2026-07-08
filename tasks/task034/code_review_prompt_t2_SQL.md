# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (5)
- [GRID-SQL] Campo 'Marca' usado em ControlSource de cursor_4c_TiposMat mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Descs' usado em ControlSource de cursor_4c_TiposMat mas NAO aparece no SELECT SQL
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TAMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: MARCA, LNTOTOP, DATAS, EMPDNPS, GRUPODS, GRUPOOS, CONTADS, CONTAOS, NENVS, CODS, CMATS, SERVICOS, RETRABS, CGRUS, MERCS, CODFINP, CCLASS, FLAGINCS, DOPPS, LCEDN, CPROS, NOPS, CUNIS, ICLIS, GERBALS, SITUAS, EMPS, ACESSO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TAMHS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: MARCA, LNTOTOP, DATAS, EMPDNPS, GRUPODS, GRUPOOS, CONTADS, CONTAOS, NENVS, CODS, CMATS, SERVICOS, RETRABS, CGRUS, MERCS, CODFINP, CCLASS, FLAGINCS, DOPPS, LCEDN, CPROS, NOPS, CUNIS, ICLIS, GERBALS, SITUAS, EMPS, ACESSO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TAMLS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: MARCA, LNTOTOP, DATAS, EMPDNPS, GRUPODS, GRUPOOS, CONTADS, CONTAOS, NENVS, CODS, CMATS, SERVICOS, RETRABS, CGRUS, MERCS, CODFINP, CCLASS, FLAGINCS, DOPPS, LCEDN, CPROS, NOPS, CUNIS, ICLIS, GERBALS, SITUAS, EMPS, ACESSO

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
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
Select CrSigOpOpt
lStrQuery = [Select a.Datas,a.CIdChaves,a.Emps,a.DopPs,a.NumPs,a.GrupoOs,a.ContaOs,b.CMats,b.Qtds,b.TpOps,b.Nenvs,]+;
			  [From SigCdNec a, SigCdNei b ] + ;
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpNens') < 1
lStrQuery = [Select a.Datas,a.CIdChaves,a.Emps,a.DopPs,a.NumPs,a.ContaOs,b.CMats,b.Qtds,b.TpOps,b.Nenvs,]+;
			  [From SigCdNec a, SigCdNei b, SigOpOpt c, SigCdPro d, SigCdGcr e ] + ;
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpProd') < 1
Select CsSigCdOpd
Select * From CrSigOpOpt Where Marca > 0 Into Cursor csLocalMc
	Select a.* From TmpNens a, CsSigCdOpd b ;
	Select a.* From TmpNens a, CsSigCdOpd b ;
	Select Distinct Empdnps From CrSigCdNec Where Nenvs = lnEnvelope Into Cursor crEnvelope
Select CrSigCdNec
		loBarra.Update(.T.)
			Select crEnvelope
		lcQuery = [Select a.CPros,a.DPros,a.CGrus,a.Sgrus,a.CUnis,b.Mercs,a.Pcuss,a.Moecs,a.Cclass,a.CodFinp,a.TamPs,a.TamHs,a.TamLs From SigCdPro a, SigCdGrp b ] +;
		If Thisform.PodataMgr.SqlExecute(lcQuery,'CrSigCdPro') < 1
		Select CrSigCdPro
			lcQuery = [Select top 1 a.Cpros, b.DPros ] + ;
					    [From SigOpPic a Inner join SigCdPro b on a.Cpros = b.Cpros Where Nops = ?crSigCdNec.Nops]
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalPro]) < 1)
		Select TmpRelat
		If Not Seek(Dtos(ldData) + lcGrp + lcCta + lcTpOps + CrSigCdPro.Cunis + CrSigCdNec.CMats + lcPed + Str(lnEnv,10) )			
			Insert Into TmpRelat (Fase, Iclis, RClis, CMats, Dpros, CPros, DDPros, TpOps, Cunis, Operacaos, Nenvs, ;
			If Not Seek(Dtos(Ctod('31/12/9999')) + Replicate(Chr(255), 20) + lcTpOps + CrSigCdPro.Cunis + CrSigCdNec.CMats)
				Insert Into TmpRelat (Fase, Iclis, RClis, CMats, TpOps, Cunis, ;
Select TmpRelat
		Select * from TmpRelat order by Datas, Fase, IClis, TpOps, CUnis, Moecs, CMats, Qtde Desc into cursor TmpRelat ReadWrite
		Select CodFinp, Cunis, Sum(Qtds) as QtdTrabs, Sum(Qtds * Pcuss) as CustoTrabs from TmpProd ;
		Select a.TpOps, a.CodFinp as Agrupa, a.DFinP as Dagrupa, a.Cunis, a.Moecs, b.QtdTrabs, Sum(a.Qtde) as Qtde, Sum(a.Valor) as Valor, ;
			from TmpRelat a Left Join TmpProd b On a.CodFinP = b.CodFinP And a.Cunis = b.Cunis ;
		Select Cclass, Cunis, Sum(Qtds) as QtdTrabs, Sum(Qtds * Pcuss) as CustoTrabs from TmpProd ;
		Select a.TpOps, a.Cclass as Agrupa, a.DClass as Dagrupa, a.Cunis, a.Moecs, b.QtdTrabs, Sum(a.Qtde) as Qtde, Sum(a.Valor) as Valor, ;
			from TmpRelat a Left Join TmpProd b On a.Cclass = b.Cclass And a.Cunis = b.Cunis ;
		Select GrupoOs, ContaOs, Cunis, Sum(Qtds) as QtdTrabs, Sum(Qtds * Pcuss) as CustoTrabs from TmpProd ;
		Select a.TpOps, a.Fase as Agrupa, a.Iclis + ' - ' + a.Rclis as Dagrupa, a.Cunis, a.Moecs, b.QtdTrabs, Sum(a.Qtde) as Qtde, Sum(a.Valor) as Valor, ;
			from TmpRelat a Left Join TmpProd b On a.Fase = Padr(b.GrupoOs,10) And a.Iclis = b.ContaOs And a.Cunis = b.Cunis ;
Insert Into dbCabecalho (Titulo, SubTitulo, NomeEmpresa) Values (lcCab, lcSub, lcEmp)
Select TmpRelat
		lcQuery = [Select Codigos, Descrs ] + ;
				    [From SigCdGcr ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrSigCdGcr') < 1)
		Select CrSigCdGcr
		lcQuery = [Select 0 As Marca, Cods, Descs ] + ;
				    [From SigOpOpt ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrSigOpOpt') < 1)
		Select CrSigOpOpt
			.GrdTipo.Column1.ControlSource = 'CrSigOpOpt.Marca'
			.GrdTipo.Column3.ControlSource = 'CrSigOpOpt.Descs'
		lcQuery = [Select IClis, RClis, Inativas ] + ;
				    [From SigCdCli ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrSigCdCli') < 1)
		Select CrSigCdCli
		lcSql = [Select 0 as Acesso, * From SigInTgo ]
		If (ThisForm.poDataMgr.SqlExecute(lcSql, 'TmpTpGop') < 1)
		Select TmpTpGop
		Select * From TmpTpGop Where Acesso = 1 Into Cursor CrTmpTpGop ReadWrite
		Select CrTmpTpGop
		Select crSigCdCot
		Select crSigCdMoe
If ThisForm.poDataMgr.SqlExecute([Select 0 As Marca, DopPs, ndopps, CodTgOps From SigCdOpd ],'CsSigCdOpd') < 1
	Select CrSigCdGcr
	If Not Seek(This.Value)
	Select CrSigCdCli
	If Not Seek(This.Value)
	Select CrSigCdCli
	If Not Seek(This.Value)
Select crSigOpOpt
Select crSigOpOpt
	Select CrSigCdGcr
	If Not Seek(This.Value)
If Not Empty(This.Value) And Not Seek(This.Value, 'crTmpTpGop', 'Codigos')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReAtm.prg) - TRECHOS RELEVANTES PARA PASS SQL (2521 linhas total):

*-- Linhas 17 a 37:
17: *   - Classificacao (Class/DClass)       -> SigCdCls
18: *   - Dimensoes (TamPs/TamHs/TamLs)
19: *   - Moeda (CdMoeda/DsMoeda)           -> SigCdMoe / crSigCdMoe
20: *   - Envelope / N. OP
21: *   - Agrupamento (opt_4c_Agru: 1=Analitico 2=Modelo 3=Classif 4=Conta)
22: *   - Grid de Tipos de Material (cursor_4c_TiposMat) com checkbox Marca
23: *   - cnt_4c_Ope: grid grd_4c_Dados + cmd_4c_SelTudo + cmd_4c_Apagar
24: *==============================================================================
25: 
26: DEFINE CLASS FormSigReAtm AS FormBase
27: 
28:     *-- Dimensoes EXATAS do original SIGREATM.SCX
29:     Height      = 550
30:     Width       = 800
31:     DataSession = 2
32:     ShowWindow  = 1
33:     WindowType  = 1
34:     AutoCenter  = .T.
35:     BorderStyle = 2
36:     ControlBox  = .F.
37:     Closable    = .F.

*-- Linhas 639 a 659:
639:     ENDPROC
640: 
641:     *--------------------------------------------------------------------------
642:     * ConfigurarFiltros - Adiciona a SEGUNDA METADE dos filtros (Modelo,
643:     *   Acabamento, Classificacao, Dimensoes, Moeda, Envelope, OP, Agrupamento)
644:     *   e cria cnt_4c_Ope com o grid de tipos de material (cursor_4c_TiposMat).
645:     *   Chamado por ConfigurarPaginaLista APOS ConfigurarPaginaDados.
646:     *--------------------------------------------------------------------------
647:     PROTECTED PROCEDURE ConfigurarFiltros()
648:         LOCAL loc_oCnt, loc_oOpe, loc_oGrd
649:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
650: 
651:         *-- Modelo/Finalidade de Produto --------------------------------------
652:         loc_oCnt.AddObject("lbl_4c_Modelo", "Label")
653:         WITH loc_oCnt.lbl_4c_Modelo
654:             .AutoSize  = .F.
655:             .FontName  = "Tahoma"
656:             .FontSize  = 8
657:             .Alignment = 1
658:             .Caption   = "Modelo :"
659:             .Height    = 15

*-- Linhas 1182 a 1207:
1182:         WITH loc_oOpe.grd_4c_Dados
1183:             .ColumnCount    = 2
1184:             .AllowRowSizing = .F.
1185:             .DeleteMark     = .F.
1186:             .GridLines      = 3
1187:             .HeaderHeight   = 0
1188:             .Height         = 240
1189:             .Left           = 5
1190:             .Panel          = 1
1191:             .RecordMark     = .F.
1192:             .RecordSource   = "cursor_4c_TiposMat"
1193:             .RowHeight      = 18
1194:             .ScrollBars     = 2
1195:             .TabStop        = .F.
1196:             .Top            = 17
1197:             .Width          = 300
1198:             .GridLineColor  = RGB(238, 238, 238)
1199:             .FontName       = "Tahoma"
1200:             .Visible        = .T.
1201:         ENDWITH
1202:         loc_oGrd = loc_oOpe.grd_4c_Dados
1203: 
1204:         WITH loc_oGrd.Column1
1205:             .Width         = 15
1206:             .Sparse        = .F.
1207:             .Alignment     = 0

*-- Linhas 1215 a 1239:
1215:             .Alignment     = 0
1216:             .BackStyle     = 0
1217:             .Enabled       = .T.
1218:         ENDWITH
1219:         loc_oGrd.Column1.CurrentControl  = "chk_4c_Marca"
1220:         loc_oGrd.Column1.ControlSource   = "cursor_4c_TiposMat.Marca"
1221: 
1222:         WITH loc_oGrd.Column2
1223:             .Width         = 220
1224:             .ControlSource = "cursor_4c_TiposMat.Descs"
1225:             .ReadOnly      = .T.
1226:             .Enabled       = .T.
1227:             .FontName      = "Tahoma"
1228:         ENDWITH
1229:         loc_oGrd.Column2.Header1.Caption = "Descrs"
1230:     ENDPROC
1231: 
1232:     *--------------------------------------------------------------------------
1233:     * ConfigurarMensagem - Cria container "Aguarde!!!" (oculto inicialmente)
1234:     *--------------------------------------------------------------------------
1235:     PROTECTED PROCEDURE ConfigurarMensagem()
1236:         LOCAL loc_oCnt
1237:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
1238:         loc_oCnt.AddObject("cnt_4c_Mensagem", "Container")
1239:         WITH loc_oCnt.cnt_4c_Mensagem

*-- Linhas 1353 a 1371:
1353:         loc_oCnt.chk_4c_Produtos.Value = 0
1354:         *-- Auto-preencher TpGOp se apenas um valor permitido
1355:         IF USED("cursor_4c_TpGOp")
1356:             SELECT cursor_4c_TpGOp
1357:             GO TOP
1358:             IF RECCOUNT("cursor_4c_TpGOp") = 1 AND !EOF("cursor_4c_TpGOp")
1359:                 loc_oCnt.txt_4c_TpGOp.Value = ALLTRIM(cursor_4c_TpGOp.Codigos)
1360:             ELSE
1361:                 loc_oCnt.txt_4c_TpGOp.Value = ""
1362:             ENDIF
1363:         ELSE
1364:             loc_oCnt.txt_4c_TpGOp.Value = ""
1365:         ENDIF
1366:         THIS.AjustarCamposDescricao()
1367:     ENDPROC
1368: 
1369:     *--------------------------------------------------------------------------
1370:     * AjustarCamposDescricao - Habilita/desabilita campos conforme When original
1371:     *   - DGrupo: habilitado so quando Grupo vazio (busca reversa por nome)

*-- Linhas 1879 a 1909:
1879:         ENDIF
1880:     ENDPROC
1881: 
1882:     *-- Grid container: botoes Marca/Desmarca --------------------------------
1883:     PROCEDURE CntOpeApagaClick()
1884:         IF USED("cursor_4c_TiposMat")
1885:             SELECT cursor_4c_TiposMat
1886:             REPLACE ALL Marca WITH 0
1887:             GO TOP
1888:         ENDIF
1889:         THIS.pgf_4c_Paginas.Page1.cnt_4c_Local.cnt_4c_Ope.grd_4c_Dados.Refresh()
1890:     ENDPROC
1891: 
1892:     PROCEDURE CntOpeSelTudoClick()
1893:         IF USED("cursor_4c_TiposMat")
1894:             SELECT cursor_4c_TiposMat
1895:             REPLACE ALL Marca WITH 1
1896:             GO TOP
1897:         ENDIF
1898:         THIS.pgf_4c_Paginas.Page1.cnt_4c_Local.cnt_4c_Ope.grd_4c_Dados.Refresh()
1899:     ENDPROC
1900: 
1901:     *--------------------------------------------------------------------------
1902:     * AbrirBuscaTpGOp - Lookup Tipo de Geracao de OP
1903:     *   Primeiro SEEK em cursor_4c_TpGOp (pre-filtrado por fChecaAcesso).
1904:     *   Se nao encontrado, abre FormBuscaAuxiliar em SigInTgo.
1905:     *--------------------------------------------------------------------------
1906:     PROTECTED PROCEDURE AbrirBuscaTpGOp()
1907:         LOCAL loc_oBusca, loc_oCnt, loc_cValor
1908:         loc_oCnt  = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
1909:         loc_cValor = ALLTRIM(loc_oCnt.txt_4c_TpGOp.Value)

*-- Linhas 1926 a 2002:
1926:         loc_oBusca.Show()
1927:         IF loc_oBusca.this_lSelecionou
1928:             IF USED("cursor_4c_BuscaTpGOp")
1929:                 SELECT cursor_4c_BuscaTpGOp
1930:                 IF !EOF()
1931:                     loc_oCnt.txt_4c_TpGOp.Value = ALLTRIM(Codigos)
1932:                 ENDIF
1933:                 USE IN cursor_4c_BuscaTpGOp
1934:             ENDIF
1935:         ELSE
1936:             loc_oCnt.txt_4c_TpGOp.Value = ""
1937:         ENDIF
1938:         loc_oBusca.Release()
1939:     ENDPROC
1940: 
1941:     *--------------------------------------------------------------------------
1942:     * AbrirBuscaGrupo - Lookup Grupo de Balanco (SigCdGcr)
1943:     *   SEEK em cursor_4c_GruposBal; se nao encontrado, FormBuscaAuxiliar.
1944:     *--------------------------------------------------------------------------
1945:     PROTECTED PROCEDURE AbrirBuscaGrupo(par_cTipoBusca)
1946:         LOCAL loc_oBusca, loc_oCnt, loc_cValorInicial, loc_cCampo
1947:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
1948:         IF par_cTipoBusca = "C"
1949:             loc_cValorInicial = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
1950:             loc_cCampo        = "Codigos"
1951:             IF USED("cursor_4c_GruposBal") AND !EMPTY(loc_cValorInicial)
1952:                 SELECT cursor_4c_GruposBal
1953:                 SET ORDER TO TAG BalCodigo
1954:                 IF SEEK(loc_cValorInicial)
1955:                     loc_oCnt.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_GruposBal.Codigos)
1956:                     loc_oCnt.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_GruposBal.Descrs)
1957:                     THIS.AjustarCamposDescricao()
1958:                     RETURN
1959:                 ENDIF
1960:             ENDIF
1961:         ELSE
1962:             loc_cValorInicial = ALLTRIM(loc_oCnt.txt_4c_DGrupo.Value)
1963:             loc_cCampo        = "Descrs"
1964:             IF USED("cursor_4c_GruposBal") AND !EMPTY(loc_cValorInicial)
1965:                 SELECT cursor_4c_GruposBal
1966:                 SET ORDER TO TAG BalDescrs
1967:                 IF SEEK(loc_cValorInicial)
1968:                     loc_oCnt.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_GruposBal.Codigos)
1969:                     loc_oCnt.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_GruposBal.Descrs)
1970:                     THIS.AjustarCamposDescricao()
1971:                     RETURN
1972:                 ENDIF
1973:             ENDIF
1974:         ENDIF
1975:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1976:             "SigCdGcr", "cursor_4c_BuscaGrupo", loc_cCampo, ;
1977:             loc_cValorInicial, ;
1978:             "Grupo de Balan" + CHR(231) + "o")
1979:         IF VARTYPE(loc_oBusca) != "O"
1980:             RETURN
1981:         ENDIF
1982:         loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1983:         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1984:         loc_oBusca.Show()
1985:         IF loc_oBusca.this_lSelecionou
1986:             IF USED("cursor_4c_BuscaGrupo")
1987:                 SELECT cursor_4c_BuscaGrupo
1988:                 IF !EOF()
1989:                     loc_oCnt.txt_4c_Grupo.Value  = ALLTRIM(Codigos)
1990:                     loc_oCnt.txt_4c_DGrupo.Value = ALLTRIM(Descrs)
1991:                 ENDIF
1992:                 USE IN cursor_4c_BuscaGrupo
1993:             ENDIF
1994:         ELSE
1995:             loc_oCnt.txt_4c_Grupo.Value  = ""
1996:             loc_oCnt.txt_4c_DGrupo.Value = ""
1997:         ENDIF
1998:         loc_oBusca.Release()
1999:         THIS.AjustarCamposDescricao()
2000:     ENDPROC
2001: 
2002:     *--------------------------------------------------------------------------

*-- Linhas 2010 a 2063:
2010:             loc_cValorInicial = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
2011:             loc_cCampo        = "IClis"
2012:             IF USED("cursor_4c_Clientes") AND !EMPTY(loc_cValorInicial)
2013:                 SELECT cursor_4c_Clientes
2014:                 SET ORDER TO TAG BalCodigo
2015:                 IF SEEK(loc_cValorInicial)
2016:                     loc_oCnt.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_Clientes.IClis)
2017:                     loc_oCnt.txt_4c_DConta.Value = ALLTRIM(cursor_4c_Clientes.RClis)
2018:                     THIS.AjustarCamposDescricao()
2019:                     RETURN
2020:                 ENDIF
2021:             ENDIF
2022:         ELSE
2023:             loc_cValorInicial = ALLTRIM(loc_oCnt.txt_4c_DConta.Value)
2024:             loc_cCampo        = "RClis"
2025:             IF USED("cursor_4c_Clientes") AND !EMPTY(loc_cValorInicial)
2026:                 SELECT cursor_4c_Clientes
2027:                 SET ORDER TO TAG BalNome
2028:                 IF SEEK(loc_cValorInicial)
2029:                     loc_oCnt.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_Clientes.IClis)
2030:                     loc_oCnt.txt_4c_DConta.Value = ALLTRIM(cursor_4c_Clientes.RClis)
2031:                     THIS.AjustarCamposDescricao()
2032:                     RETURN
2033:                 ENDIF
2034:             ENDIF
2035:         ENDIF
2036:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2037:             "SigCdCli", "cursor_4c_BuscaConta", loc_cCampo, ;
2038:             loc_cValorInicial, ;
2039:             "Conta / Cliente")
2040:         IF VARTYPE(loc_oBusca) != "O"
2041:             RETURN
2042:         ENDIF
2043:         loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
2044:         loc_oBusca.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
2045:         loc_oBusca.Show()
2046:         IF loc_oBusca.this_lSelecionou
2047:             IF USED("cursor_4c_BuscaConta")
2048:                 SELECT cursor_4c_BuscaConta
2049:                 IF !EOF()
2050:                     loc_oCnt.txt_4c_Conta.Value  = ALLTRIM(IClis)
2051:                     loc_oCnt.txt_4c_DConta.Value = ALLTRIM(RClis)
2052:                 ENDIF
2053:                 USE IN cursor_4c_BuscaConta
2054:             ENDIF
2055:         ELSE
2056:             loc_oCnt.txt_4c_Conta.Value  = ""
2057:             loc_oCnt.txt_4c_DConta.Value = ""
2058:         ENDIF
2059:         loc_oBusca.Release()
2060:         THIS.AjustarCamposDescricao()
2061:     ENDPROC
2062: 
2063:     *--------------------------------------------------------------------------

*-- Linhas 2079 a 2097:
2079:         loc_oBusca.Show()
2080:         IF loc_oBusca.this_lSelecionou
2081:             IF USED("cursor_4c_BuscaGgrp")
2082:                 SELECT cursor_4c_BuscaGgrp
2083:                 IF !EOF()
2084:                     loc_oCnt.txt_4c_Ggrp.Value  = ALLTRIM(Codigos)
2085:                     loc_oCnt.txt_4c_DGGrp.Value = ALLTRIM(Descs)
2086:                 ENDIF
2087:                 USE IN cursor_4c_BuscaGgrp
2088:             ENDIF
2089:         ELSE
2090:             loc_oCnt.txt_4c_Ggrp.Value  = ""
2091:             loc_oCnt.txt_4c_DGGrp.Value = ""
2092:         ENDIF
2093:         loc_oBusca.Release()
2094:     ENDPROC
2095: 
2096:     *--------------------------------------------------------------------------
2097:     * AbrirBuscaCGru - Lookup Grupo de Materia Prima (SigCdGrp)

*-- Linhas 2118 a 2136:
2118:         loc_oBusca.Show()
2119:         IF loc_oBusca.this_lSelecionou
2120:             IF USED("cursor_4c_BuscaCGru")
2121:                 SELECT cursor_4c_BuscaCGru
2122:                 IF !EOF()
2123:                     loc_oCnt.txt_4c_CGru.Value = ALLTRIM(CGrus)
2124:                     loc_oCnt.txt_4c_DGru.Value = ALLTRIM(DGrus)
2125:                 ENDIF
2126:                 USE IN cursor_4c_BuscaCGru
2127:             ENDIF
2128:         ELSE
2129:             loc_oCnt.txt_4c_CGru.Value = ""
2130:             loc_oCnt.txt_4c_DGru.Value = ""
2131:         ENDIF
2132:         loc_oBusca.Release()
2133:         THIS.AjustarCamposDescricao()
2134:     ENDPROC
2135: 
2136:     *--------------------------------------------------------------------------

*-- Linhas 2158 a 2176:
2158:         loc_oBusca.Show()
2159:         IF loc_oBusca.this_lSelecionou
2160:             IF USED("cursor_4c_BuscaCSGru")
2161:                 SELECT cursor_4c_BuscaCSGru
2162:                 IF !EOF()
2163:                     loc_oCnt.txt_4c_CSGru.Value = ALLTRIM(Codigos)
2164:                     loc_oCnt.txt_4c_DsGru.Value = ALLTRIM(Descricaos)
2165:                 ENDIF
2166:                 USE IN cursor_4c_BuscaCSGru
2167:             ENDIF
2168:         ELSE
2169:             loc_oCnt.txt_4c_CSGru.Value = ""
2170:             loc_oCnt.txt_4c_DsGru.Value = ""
2171:         ENDIF
2172:         loc_oBusca.Release()
2173:         THIS.AjustarCamposDescricao()
2174:     ENDPROC
2175: 
2176:     *--------------------------------------------------------------------------

*-- Linhas 2198 a 2216:
2198:         loc_oBusca.Show()
2199:         IF loc_oBusca.this_lSelecionou
2200:             IF USED("cursor_4c_BuscaCodFinP")
2201:                 SELECT cursor_4c_BuscaCodFinP
2202:                 IF !EOF()
2203:                     loc_oCnt.txt_4c_CodFinP.Value = ALLTRIM(Cods)
2204:                     loc_oCnt.txt_4c_DesFinP.Value = ALLTRIM(Descs)
2205:                 ENDIF
2206:                 USE IN cursor_4c_BuscaCodFinP
2207:             ENDIF
2208:         ELSE
2209:             loc_oCnt.txt_4c_CodFinP.Value = ""
2210:             loc_oCnt.txt_4c_DesFinP.Value = ""
2211:         ENDIF
2212:         loc_oBusca.Release()
2213:         THIS.AjustarCamposDescricao()
2214:     ENDPROC
2215: 
2216:     *--------------------------------------------------------------------------

*-- Linhas 2238 a 2256:
2238:         loc_oBusca.Show()
2239:         IF loc_oBusca.this_lSelecionou
2240:             IF USED("cursor_4c_BuscaAcab")
2241:                 SELECT cursor_4c_BuscaAcab
2242:                 IF !EOF()
2243:                     loc_oCnt.txt_4c_CodAcb.Value = ALLTRIM(Cods)
2244:                     loc_oCnt.txt_4c_DAcb.Value   = ALLTRIM(Descrs)
2245:                 ENDIF
2246:                 USE IN cursor_4c_BuscaAcab
2247:             ENDIF
2248:         ELSE
2249:             loc_oCnt.txt_4c_CodAcb.Value = ""
2250:             loc_oCnt.txt_4c_DAcb.Value   = ""
2251:         ENDIF
2252:         loc_oBusca.Release()
2253:         THIS.AjustarCamposDescricao()
2254:     ENDPROC
2255: 
2256:     *--------------------------------------------------------------------------

*-- Linhas 2278 a 2296:
2278:         loc_oBusca.Show()
2279:         IF loc_oBusca.this_lSelecionou
2280:             IF USED("cursor_4c_BuscaClass")
2281:                 SELECT cursor_4c_BuscaClass
2282:                 IF !EOF()
2283:                     loc_oCnt.txt_4c_Class.Value  = ALLTRIM(Cods)
2284:                     loc_oCnt.txt_4c_DClass.Value = ALLTRIM(Descrs)
2285:                 ENDIF
2286:                 USE IN cursor_4c_BuscaClass
2287:             ENDIF
2288:         ELSE
2289:             loc_oCnt.txt_4c_Class.Value  = ""
2290:             loc_oCnt.txt_4c_DClass.Value = ""
2291:         ENDIF
2292:         loc_oBusca.Release()
2293:         THIS.AjustarCamposDescricao()
2294:     ENDPROC
2295: 
2296:     *--------------------------------------------------------------------------

*-- Linhas 2318 a 2336:
2318:         loc_oBusca.Show()
2319:         IF loc_oBusca.this_lSelecionou
2320:             IF USED("cursor_4c_BuscaMoeda")
2321:                 SELECT cursor_4c_BuscaMoeda
2322:                 IF !EOF()
2323:                     loc_oCnt.txt_4c_CdMoeda.Value = ALLTRIM(CMoes)
2324:                     loc_oCnt.txt_4c_DsMoeda.Value = ALLTRIM(DMoes)
2325:                 ENDIF
2326:                 USE IN cursor_4c_BuscaMoeda
2327:             ENDIF
2328:         ELSE
2329:             loc_oCnt.txt_4c_CdMoeda.Value = ""
2330:             loc_oCnt.txt_4c_DsMoeda.Value = ""
2331:         ENDIF
2332:         loc_oBusca.Release()
2333:         THIS.AjustarCamposDescricao()
2334:     ENDPROC
2335: 
2336:     *-- DblClick handlers: abrem lookup direto sem precisar pressionar F4 ------


### BO (C:\4c\projeto\app\classes\SigReAtmBO.prg):
*==============================================================================
* SIGREATMBO.PRG
* Business Object para Relatorio Analise por Tipo de Material (SigReAtm)
* Herda de: RelatorioBase
*==============================================================================

DEFINE CLASS SigReAtmBO AS RelatorioBase

    *-- Filtros de periodo
    this_dDatai           = {}
    this_dDataf           = {}

    *-- Filtro tipo de OP
    this_cTpGOp           = ""

    *-- Filtro grupo de balanco (SigCdGcr)
    this_cGrupo           = ""
    this_cDGrupo          = ""

    *-- Filtro conta/cliente
    this_cConta           = ""
    this_cDConta          = ""

    *-- Filtro grande grupo de produto
    this_cGgrp            = ""
    this_cDGGrp           = ""

    *-- Filtro grupo de materia prima
    this_cCGru            = ""
    this_cDGru            = ""

    *-- Filtro subgrupo de materia prima
    this_cCSGru           = ""
    this_cDsGru           = ""

    *-- Filtro modelo (finalidade de produto)
    this_cCodFinP         = ""
    this_cDesFinP         = ""

    *-- Filtro acabamento
    this_cCodAcb          = ""
    this_cDAcb            = ""

    *-- Filtro classificacao
    this_cClass           = ""
    this_cDClass          = ""

    *-- Filtro dimensoes
    this_nTamPs           = 0
    this_nTamHs           = 0
    this_nTamLs           = 0

    *-- Filtro envelope e OP
    this_nEnvelope        = 0
    this_nNop             = 0

    *-- Filtro moeda de conversao
    this_cCdMoeda         = ""
    this_cDsMoeda         = ""

    *-- Agrupamento: 1=Analitico 2=Modelo 3=Classificacao 4=Conta
    this_nAgru            = 4

    *-- Opcoes logicas
    this_lDestino         = .F.
    this_lProdutos        = .F.

    *-- Nomes dos cursors para uso pelo Form
    this_cCursorTiposMat  = "cursor_4c_TiposMat"
    this_cCursorGrupos    = "cursor_4c_GruposBal"
    this_cCursorClientes  = "cursor_4c_Clientes"
    this_cCursorTpGOp     = "cursor_4c_TpGOp"

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursors(8), loc_nI
        loc_aCursors(1) = "cursor_4c_GruposBal"
        loc_aCursors(2) = "cursor_4c_TiposMat"
        loc_aCursors(3) = "cursor_4c_Clientes"
        loc_aCursors(4) = "cursor_4c_Pam"
        loc_aCursors(5) = "cursor_4c_TpGOp"
        loc_aCursors(6) = "crSigCdCot"
        loc_aCursors(7) = "crSigCdMoe"
        loc_aCursors(8) = "cursor_4c_Operacoes"
        FOR loc_nI = 1 TO 8
            IF USED(loc_aCursors(loc_nI))
                USE IN (loc_aCursors(loc_nI))
            ENDIF
        ENDFOR
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarDados - Carrega cursors de referencia usados pelo Form e pelo
    * PrepararDados. Deve ser chamado no InicializarForm() do Form.
    *--------------------------------------------------------------------------
    PROCEDURE InicializarDados()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL, loc_cEmp, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_cEmp = ALLTRIM(go_4c_Sistema.cCodEmpresa)

            *-- 1. Grupos de balanco (SigCdGcr GerBals=1)
            IF USED("cursor_4c_GruposBal")
                USE IN cursor_4c_GruposBal
            ENDIF
            loc_cSQL = "SELECT Codigos, Descrs, Agrupas FROM SigCdGcr WHERE GerBals = 1"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposBal")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar grupos de balan" + CHR(231) + CHR(227) + "o"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_GruposBal
            INDEX ON Codigos TAG BalCodigo
            INDEX ON Descrs  TAG BalDescrs

            *-- 2. Tipos de material selecionaveis (SigOpOpt Situas<2)
            IF USED("cursor_4c_TiposMat")
                USE IN cursor_4c_TiposMat
            ENDIF
            loc_cSQL = "SELECT 0 AS Marca, Cods, Descs FROM SigOpOpt " + ;
                       "WHERE Situas < 2 AND " + ;
                       "(RTRIM(Emps) = '' OR Emps = " + EscaparSQL(loc_cEmp) + ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TiposMat")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar tipos de material"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_TiposMat
            INDEX ON Cods  TAG Cods
            INDEX ON Descs TAG Descs
            GO TOP

            *-- 3. Clientes (SigCdCli GerBals=1)
            IF USED("cursor_4c_Clientes")
                USE IN cursor_4c_Clientes
            ENDIF
            loc_cSQL = "SELECT IClis, RClis, Inativas FROM SigCdCli WHERE GerBals = 1"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Clientes")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar clientes"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_Clientes
            INDEX ON IClis TAG BalCodigo
            INDEX ON RClis TAG BalNome

            *-- 4. Parametros empresa (GrTrans para exclusao de transitorio)
            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF
            loc_cSQL = "SELECT GrTrans FROM SigCdPam"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar par" + CHR(226) + "metros"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_Pam
            GO TOP

            *-- 5. Tipos de geracao de OP filtrados por acesso do usuario
            IF USED("TmpTpGop")
                USE IN TmpTpGop
            ENDIF
            IF USED("cursor_4c_TpGOp")
                USE IN cursor_4c_TpGOp
            ENDIF
            loc_cSQL = "SELECT 0 AS Acesso, Codigos, Descs FROM SigInTgo"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpTpGop")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar tipos de OP"
                loc_lSucesso = .F.
            ENDIF
            SELECT TmpTpGop
            SCAN
                IF fChecaAcesso("SIGPRGLOT", ALLTRIM(TmpTpGop.Codigos))
                    REPLACE Acesso WITH 1 IN TmpTpGop
                ENDIF
            ENDSCAN
            SELECT * FROM TmpTpGop WHERE Acesso = 1 INTO CURSOR cursor_4c_TpGOp READWRITE
            SELECT cursor_4c_TpGOp
            INDEX ON Codigos TAG Codigos
            GO TOP
            USE IN TmpTpGop

            *-- 6. Cotacoes de moeda (crSigCdCot - nome exato usado por fCarregarCambio)
            IF USED("crSigCdCot")
                USE IN crSigCdCot
            ENDIF
            loc_cSQL = "SELECT CMoes, Datas, Valos FROM SigCdCot"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCot")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar cota" + CHR(231) + CHR(245) + "es"
                loc_lSucesso = .F.
            ENDIF
            SELECT crSigCdCot
            INDEX ON CMoes + DTOS(Datas) TAG CMoeData
            SET ORDER TO CMoeData DESCENDING

            *-- 7. Moedas (crSigCdMoe - nome exato usado por fCarregarCambio)
            IF USED("crSigCdMoe")
                USE IN crSigCdMoe
            ENDIF
            loc_cSQL = "SELECT CMoes, Cotas FROM SigCdMoe"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdMoe")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar moedas"
                loc_lSucesso = .F.
            ENDIF
            SELECT crSigCdMoe
            INDEX ON CMoes TAG CMoes

            *-- 8. Operacoes de producao (SigCdOpd)
            IF USED("cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF
            loc_cSQL = "SELECT 0 AS Marca, DopPs, ndopps, CodTgOps FROM SigCdOpd"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar opera" + CHR(231) + CHR(245) + "es"
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em InicializarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa processamento completo do relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL, loc_oErro
        LOCAL loc_cGrupo, loc_cConta, loc_cGruMat, loc_cGgrp, loc_cSgru
        LOCAL loc_dDatai, loc_dDataf, loc_lDestino, loc_nEnvelope, loc_nOp
        LOCAL loc_nOpI, loc_nOpF, loc_cTGOp, loc_cCodFin, loc_cClas
        LOCAL loc_nTamA, loc_nTamP, loc_nTamC, loc_nAgru, loc_cMoeda
        LOCAL loc_cTpOp, loc_nTotOp, loc_cCabTipo, loc_cCab, loc_cSub, loc_cEmp
        LOCAL loc_cTpOps, loc_cGrp, loc_cCta, loc_cPed, loc_nEnv, loc_ldData
        LOCAL loc_lcDimen, loc_lcPro, loc_lcDpr, loc_cGrTrans, loc_nValorCalc
        LOCAL loc_cDtI, loc_cDtF, loc_cChave, loc_cChaveTotal, loc_cRClis
        LOCAL loc_cDFinP, loc_cDClass, loc_cQueryPro, loc_cLabel1, loc_cLabel2, loc_cLabel3

        loc_lSucesso = .F.

        TRY
            *-- Copiar filtros das propriedades
            loc_cGrupo    = ALLTRIM(THIS.this_cGrupo)
            loc_cConta    = ALLTRIM(THIS.this_cConta)
            loc_cGruMat   = ALLTRIM(THIS.this_cCGru)
            loc_cGgrp     = ALLTRIM(THIS.this_cGgrp)
            loc_cSgru     = ALLTRIM(THIS.this_cCSGru)
            loc_dDatai    = THIS.this_dDatai
            loc_dDataf    = THIS.this_dDataf
            loc_lDestino  = THIS.this_lDestino
            loc_nEnvelope = THIS.this_nEnvelope
            loc_nOp       = THIS.this_nNop
            loc_nOpI      = (loc_nOp * 10000) + 1
            loc_nOpF      = (loc_nOp * 10000) + 9999
            loc_cTGOp     = ALLTRIM(THIS.this_cTpGOp)
            loc_cCodFin   = ALLTRIM(THIS.this_cCodFinP)
            loc_cClas     = ALLTRIM(THIS.this_cClass)
            loc_nTamA     = THIS.this_nTamHs
            loc_nTamP     = THIS.this_nTamPs
            loc_nTamC     = THIS.this_nTamLs
            loc_nAgru     = THIS.this_nAgru
            loc_cMoeda    = ALLTRIM(THIS.this_cCdMoeda)

            *-- Criar cursor TmpRelat com indexes
            IF USED("TmpRelat")
                USE IN TmpRelat
            ENDIF
            CREATE CURSOR TmpRelat (Fase c(10), IClis c(10), RClis c(50), ;
                CMats c(14), DPros c(40), CPros c(14), DDPros c(40), ;
                Qtde n(12,3), TpOps c(15), CUnis c(3), Operacaos c(31), ;
                Nenvs n(10), Datas D, Pesos n(12,3), Valor n(12,2), ;
                Fators n(12,3), Moecs c(3), Cgrus c(3), Sgrus c(3), ;
                Cclass c(3), CodFinP c(3), Dimens c(30), DFinP c(20), ;
                DClass c(40), QtdTrabs n(12,3))
            INDEX ON DTOS(Datas) + Operacaos + STR(Nenvs,10) + CMats TAG Operacao
            INDEX ON TpOps + CodFinP + STR(Qtde,12,3) TAG TpCodFin
            INDEX ON DTOS(Datas) + Fase + IClis + TpOps + CUnis + ;
                CMats + Operacaos + STR(Nenvs,10) + STR(Qtde,12,3) TAG FFuncMat

            *-- Datas formatadas
            loc_cDtI = FormatarDataSQL(loc_dDatai)
            loc_cDtF = FormatarDataSQL(loc_dDataf)

            *-- Montar filtro de tipos de material marcados no grid
            loc_cTpOp  = ""
            loc_nTotOp = 0
            IF USED("cursor_4c_TiposMat")
                SELECT cursor_4c_TiposMat
                GO TOP
                COUNT FOR Marca = 1 TO loc_nTotOp
                SCAN
                    IF cursor_4c_TiposMat.Marca = 1 OR loc_nTotOp = 0
                        IF EMPTY(loc_cTpOp)
                            loc_cTpOp = "'" + ALLTRIM(cursor_4c_TiposMat.Cods) + "'"
                        ELSE
                            loc_cTpOp = loc_cTpOp + ",'" + ALLTRIM(cursor_4c_TiposMat.Cods) + "'"
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF
            loc_cTpOp = "(" + IIF(EMPTY(loc_cTpOp), "''", loc_cTpOp) + ")"

            *-- QUERY 1: movimentos basicos (TmpNens)
            IF USED("TmpNens")
                USE IN TmpNens
            ENDIF
            loc_cSQL = "Select a.Datas,a.CIdChaves,a.Emps,a.DopPs,a.NumPs,a.GrupoOs,a.ContaOs," + ;
                       "b.CMats,b.Qtds,b.TpOps,b.Nenvs," + ;
                       "a.GrupoDs,a.ContaDs,b.Nops,b.Pesos,b.Fators,b.Servicos,b.Cats,b.Empdnps " + ;
                       "From SigCdNec a, SigCdNei b " + ;
                       "Where a.Datas Between " + loc_cDtI + " And " + loc_cDtF + ;
                       " And a.EmpDNPs = b.EmpDNPs"
            IF !EMPTY(loc_cTpOp) AND loc_cTpOp <> "()"
                loc_cSQL = loc_cSQL + " And b.TpOps in " + loc_cTpOp
            ENDIF
            IF !EMPTY(loc_cGrupo)
                IF loc_lDestino
                    loc_cSQL = loc_cSQL + " And a.GrupoDs = " + EscaparSQL(loc_cGrupo)
                ELSE
                    loc_cSQL = loc_cSQL + " And a.GrupoOs = " + EscaparSQL(loc_cGrupo)
                ENDIF
            ENDIF
            IF !EMPTY(loc_cConta)
                IF loc_lDestino
                    loc_cSQL = loc_cSQL + " And a.ContaDs = " + EscaparSQL(loc_cConta)
                ELSE
                    loc_cSQL = loc_cSQL + " And a.ContaOs = " + EscaparSQL(loc_cConta)
                ENDIF
            ENDIF
            IF loc_nEnvelope > 0
                loc_cSQL = loc_cSQL + " And b.Nenvs = " + FormatarNumeroSQL(loc_nEnvelope)
            ENDIF
            loc_cSQL = loc_cSQL + " Order By a.cIdChaves"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpNens")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar movimenta" + CHR(231) + CHR(245) + "es (TmpNens)"
                loc_lSucesso = .F.
            ENDIF

            *-- QUERY 2: componentes com dados de produto (TmpProd)
            IF USED("TmpProd")
                USE IN TmpProd
            ENDIF
            loc_cSQL = "Select a.Datas,a.CIdChaves,a.Emps,a.DopPs,a.NumPs,a.ContaOs," + ;
                       "b.CMats,b.Qtds,b.TpOps,b.Nenvs,a.GrupoDs,a.ContaDs," + ;
                       "b.Nops,b.Pesos,b.Fators,b.Servicos,b.Cats,b.Empdnps," + ;
                       "d.CodFinP,d.Cclass,d.Cunis,d.Pcuss," + ;
                       "case when e.agrupas = '' then a.GrupoOs else e.agrupas end as GrupoOs " + ;
                       "From SigCdNec a, SigCdNei b, SigOpOpt c, SigCdPro d, SigCdGcr e " + ;
                       "Where a.Datas Between " + loc_cDtI + " And " + loc_cDtF + ;
                       " And a.EmpDNPs = b.EmpDNPs And c.Cods = b.TpOps" + ;
                       " And b.Cmats = d.Cpros And b.servicos = 0 And a.Retrabs = 0 And a.GrupoOs = e.Codigos"
            IF !EMPTY(loc_cGrupo)
                IF loc_lDestino
                    loc_cSQL = loc_cSQL + " And a.GrupoDs = " + EscaparSQL(loc_cGrupo)
                ELSE
                    loc_cSQL = loc_cSQL + " And a.GrupoOs = " + EscaparSQL(loc_cGrupo)
                ENDIF
            ENDIF
            IF !EMPTY(loc_cConta)
                IF loc_lDestino
                    loc_cSQL = loc_cSQL + " And a.ContaDs = " + EscaparSQL(loc_cConta)
                ELSE
                    loc_cSQL = loc_cSQL + " And a.ContaOs = " + EscaparSQL(loc_cConta)
                ENDIF
            ENDIF
            IF loc_nEnvelope > 0
                loc_cSQL = loc_cSQL + " And b.Nenvs = " + FormatarNumeroSQL(loc_nEnvelope)
            ENDIF
            IF !EMPTY(loc_cGruMat)
                loc_cSQL = loc_cSQL + " And d.CGrus = " + EscaparSQL(loc_cGruMat)
            ENDIF
            IF !EMPTY(loc_cGgrp)
                loc_cSQL = loc_cSQL + " And d.Mercs = " + EscaparSQL(loc_cGgrp)
            ENDIF
            IF !EMPTY(loc_cCodFin)
                loc_cSQL = loc_cSQL + " And d.CodFinP = " + EscaparSQL(loc_cCodFin)
            ENDIF
            IF !EMPTY(loc_cClas)
                loc_cSQL = loc_cSQL + " And d.Cclass = " + EscaparSQL(loc_cClas)
            ENDIF
            loc_cSQL = loc_cSQL + " Order By a.cIdChaves"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpProd")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar componentes (TmpProd)"
                loc_lSucesso = .F.
            ENDIF

            *-- Filtrar movimentos por tipo de geracao de OP
            IF USED("CrSigCdNec")
                USE IN CrSigCdNec
            ENDIF
            SELECT TmpNens.* FROM TmpNens, cursor_4c_Operacoes ;
                WHERE TmpNens.DopPs = cursor_4c_Operacoes.DopPs ;
                AND IIF(!EMPTY(loc_cTGOp), ALLTRIM(cursor_4c_Operacoes.CodTgOps) = loc_cTGOp, .T.) ;
                INTO CURSOR CrSigCdNec READWRITE

            *-- Cursor de filtro por envelope
            IF USED("crEnvelope")
                USE IN crEnvelope
            ENDIF
            IF loc_nEnvelope > 0
                SELECT DISTINCT Empdnps FROM CrSigCdNec ;
                    WHERE Nenvs = loc_nEnvelope INTO CURSOR crEnvelope
            ENDIF

            *-- Indexar CrSigCdNec
            SELECT CrSigCdNec
            INDEX ON DTOS(Datas) + CIdChaves TAG Datas
            SET ORDER TO Datas
            GO TOP

            *-- Ler GrTrans uma vez (evitar acesso ao cursor dentro do SCAN)
            loc_cGrTrans = ""
            IF USED("cursor_4c_Pam")
                SELECT cursor_4c_Pam
                GO TOP
                IF !EOF()
                    loc_cGrTrans = ALLTRIM(cursor_4c_Pam.GrTrans)
                ENDIF
            ENDIF

            *-- Processar movimentos
            LOCAL loc_nTotal
            loc_nTotal = RECCOUNT("CrSigCdNec")

            IF loc_nTotal > 0
                WAIT WINDOW "Processando movimenta" + CHR(231) + CHR(245) + "es..." NOWAIT

                SELECT CrSigCdNec
                SCAN
                    *-- Filtro envelope
                    IF loc_nEnvelope > 0
                        IF USED("crEnvelope")
                            SELECT crEnvelope
                            GO TOP
                            LOCATE FOR Empdnps = CrSigCdNec.Empdnps
                            IF EOF("crEnvelope")
                                LOOP
                            ENDIF
                        ENDIF
                    ENDIF

                    *-- Filtro numero de OP
                    IF loc_nOp > 0
                        IF !BETWEEN(CrSigCdNec.Nops, loc_nOpI, loc_nOpF)
                            LOOP
                        ENDIF
                    ENDIF

                    *-- Buscar dados do produto/material para este componente
                    IF USED("CrSigCdPro")
                        USE IN CrSigCdPro
                    ENDIF
                    loc_cQueryPro = "Select a.CPros,a.DPros,a.CGrus,a.Sgrus,a.CUnis," + ;
                                    "b.Mercs,a.Pcuss,a.Moecs,a.Cclass,a.CodFinp," + ;
                                    "a.TamPs,a.TamHs,a.TamLs " + ;
                                    "From SigCdPro a, SigCdGrp b " + ;
                                    "Where a.CPros = " + EscaparSQL(ALLTRIM(CrSigCdNec.CMats)) + ;
                                    " And a.Cgrus = b.Cgrus"
                    IF SQLEXEC(gnConnHandle, loc_cQueryPro, "CrSigCdPro") < 1
                        THIS.this_cMensagemErro = "Erro ao buscar produto " + ALLTRIM(CrSigCdNec.CMats)
                        loc_lSucesso = .F.
                    ENDIF
                    SELECT CrSigCdPro
                    IF EOF()
                        LOOP
                    ENDIF

                    *-- Aplicar filtros de produto
                    IF !EMPTY(loc_cGruMat) AND ALLTRIM(CrSigCdPro.CGrus) <> loc_cGruMat
                        LOOP
                    ENDIF
                    IF !EMPTY(loc_cGgrp) AND ALLTRIM(CrSigCdPro.Mercs) <> loc_cGgrp
                        LOOP
                    ENDIF
                    IF !EMPTY(loc_cSgru) AND ALLTRIM(CrSigCdPro.Sgrus) <> loc_cSgru
                        LOOP
                    ENDIF
                    IF !EMPTY(loc_cCodFin) AND ALLTRIM(CrSigCdPro.CodFinp) <> loc_cCodFin
                        LOOP
                    ENDIF
                    IF !EMPTY(loc_cClas) AND ALLTRIM(CrSigCdPro.Cclass) <> loc_cClas
                        LOOP
                    ENDIF
                    IF loc_nTamP <> 0 AND CrSigCdPro.TamPs <> loc_nTamP
                        LOOP
                    ENDIF
                    IF loc_nTamA <> 0 AND CrSigCdPro.TamHs <> loc_nTamA
                        LOOP
                    ENDIF
                    IF loc_nTamC <> 0 AND CrSigCdPro.TamLs <> loc_nTamC
                        LOOP
                    ENDIF

                    loc_cTpOps = CrSigCdNec.TpOps

                    *-- Determinar grupo (origem ou destino)
                    IF loc_lDestino
                        loc_cGrp = CrSigCdNec.GrupoDs
                    ELSE
                        loc_cGrp = CrSigCdNec.GrupoOs
                    ENDIF

                    *-- Buscar agrupamento customizado do grupo
                    IF USED("cursor_4c_GruposBal") AND !EMPTY(ALLTRIM(loc_cGrp))
                        SELECT cursor_4c_GruposBal
                        SET ORDER TO TAG BalCodigo
                        IF SEEK(ALLTRIM(loc_cGrp)) AND !EMPTY(ALLTRIM(cursor_4c_GruposBal.Agrupas))
                            loc_cGrp = PADR(ALLTRIM(cursor_4c_GruposBal.Agrupas), 10)
                        ENDIF
                        SELECT CrSigCdNec
                    ENDIF

                    *-- Excluir grupo transitorio
                    IF ALLTRIM(loc_cGrp) = loc_cGrTrans
                        LOOP
                    ENDIF

                    *-- Determinar conta
                    IF loc_lDestino
                        loc_cCta = CrSigCdNec.ContaDs
                    ELSE
                        loc_cCta = CrSigCdNec.ContaOs
                    ENDIF

                    *-- Montar chave de agrupamento (loc_cPed/lnEnv/ldData por modo)
                    IF loc_nAgru = 1
                        loc_cPed   = PADR(ALLTRIM(CrSigCdNec.DopPs) + "-" + STR(CrSigCdNec.NumPs,10), 31)
                        loc_nEnv   = CrSigCdNec.Nenvs
                        loc_ldData = CrSigCdNec.Datas
                    ELSE
                        loc_cPed   = PADR(" ", 31)
                        loc_nEnv   = 0
                        loc_ldData = CTOD("31/12/9999")
                    ENDIF

                    *-- Buscar produto final da OP (opcional)
                    loc_lcPro = ""
                    loc_lcDpr = ""
                    IF !EMPTY(CrSigCdNec.Nops) AND THIS.this_lProdutos
                        IF USED("LocalPro")
                            USE IN LocalPro
                        ENDIF
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT TOP 1 a.Cpros,b.DPros " + ;
                            "From SigOpPic a Inner join SigCdPro b on a.Cpros = b.Cpros " + ;
                            "Where Nops = " + FormatarNumeroSQL(CrSigCdNec.Nops), "LocalPro")
                        IF loc_nResult > 0
                            SELECT LocalPro
                            GO TOP
                            IF !EOF()
                                loc_lcDpr = ALLTRIM(LocalPro.DPros)
                                loc_lcPro = ALLTRIM(LocalPro.Cpros)
                            ENDIF
                        ENDIF
                    ENDIF

                    *-- Montar string de dimensoes do produto
                    loc_lcDimen = ""
                    IF USED("crSigCdGrp")
                        USE IN crSigCdGrp
                    ENDIF
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT TitulosPro FROM SigCdGrp WHERE CGrus = " + ;
                        EscaparSQL(ALLTRIM(CrSigCdPro.CGrus)), "crSigCdGrp")
                    IF loc_nResult > 0
                        SELECT crSigCdGrp
                        GO TOP
                        IF !EOF() AND !EMPTY(SUBSTR(crSigCdGrp.TitulosPro, 61, 60))
                            loc_cLabel1 = IIF(EMPTY(ALLTRIM(SUBSTR(crSigCdGrp.TitulosPro, 61, 20))), ;
                                             "p", ALLTRIM(SUBSTR(crSigCdGrp.TitulosPro, 61, 20)))
                            loc_cLabel2 = IIF(EMPTY(ALLTRIM(SUBSTR(crSigCdGrp.TitulosPro, 81, 20))), ;
                                             "a", ALLTRIM(SUBSTR(crSigCdGrp.TitulosPro, 81, 20)))
                            loc_cLabel3 = IIF(EMPTY(ALLTRIM(SUBSTR(crSigCdGrp.TitulosPro, 101, 20))), ;
                                             "c", ALLTRIM(SUBSTR(crSigCdGrp.TitulosPro, 101, 20)))
                            loc_lcDimen = STR(CrSigCdPro.TamPs, 2) + loc_cLabel1 + ;
                                          " x " + STR(CrSigCdPro.TamHs, 2) + loc_cLabel2 + ;
                                          " x " + STR(CrSigCdPro.TamLs, 2) + loc_cLabel3
                        ENDIF
                    ENDIF

                    *-- Buscar descricao de finalidade/modelo (SigCdFip)
                    IF USED("crSigCdFip")
                        USE IN crSigCdFip
                    ENDIF
                    SQLEXEC(gnConnHandle, ;
                        "SELECT Descs FROM SigCdFip WHERE Cods = " + ;
                        EscaparSQL(ALLTRIM(CrSigCdPro.CodFinp)), "crSigCdFip")
                    loc_cDFinP = ""
                    IF USED("crSigCdFip")
                        SELECT crSigCdFip
                        GO TOP
                        IF !EOF()
                            loc_cDFinP = ALLTRIM(crSigCdFip.Descs)
                        ENDIF
                    ENDIF

                    *-- Buscar descricao de classificacao (SigCdCls)
                    IF USED("crSigCdCls")
                        USE IN crSigCdCls
                    ENDIF
                    SQLEXEC(gnConnHandle, ;
                        "SELECT Descs FROM SigCdCls WHERE Cods = " + ;
                        EscaparSQL(ALLTRIM(CrSigCdPro.Cclass)), "crSigCdCls")
                    loc_cDClass = ""
                    IF USED("crSigCdCls")
                        SELECT crSigCdCls
                        GO TOP
                        IF !EOF()
                            loc_cDClass = ALLTRIM(crSigCdCls.Descs)
                        ENDIF
                    ENDIF

                    *-- Montar chave de busca no TmpRelat
                    loc_cChave = DTOS(loc_ldData) + ;
                                 PADR(ALLTRIM(loc_cGrp), 10) + ;
                                 PADR(ALLTRIM(loc_cCta), 10) + ;
                                 PADR(ALLTRIM(loc_cTpOps), 15) + ;
                                 PADR(ALLTRIM(CrSigCdPro.Cunis), 3) + ;
                                 PADR(ALLTRIM(CrSigCdNec.CMats), 14) + ;
                                 loc_cPed + ;
                                 STR(loc_nEnv, 10)

                    SELECT TmpRelat
                    SET ORDER TO TAG FFuncMat

                    IF !SEEK(loc_cChave)
                        *-- Buscar nome do cliente para o INSERT
                        IF USED("CrTmpCli")
                            USE IN CrTmpCli
                        ENDIF
                        SQLEXEC(gnConnHandle, ;
                            "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
                            EscaparSQL(ALLTRIM(loc_cCta)), "CrTmpCli")
                        loc_cRClis = ""
                        IF USED("CrTmpCli")
                            SELECT CrTmpCli
                            GO TOP
                            IF !EOF()
                                loc_cRClis = ALLTRIM(CrTmpCli.RClis)
                            ENDIF
                        ENDIF

                        SELECT TmpRelat
                        INSERT INTO TmpRelat (Fase, IClis, RClis, CMats, DPros, CPros, ;
                            DDPros, TpOps, CUnis, Operacaos, Nenvs, Datas, Fators, ;
                            Moecs, Cclass, CodFinP, Dimens, Cgrus, Sgrus, DFinP, DClass) ;
                            VALUES (PADR(ALLTRIM(loc_cGrp),10), ;
                                PADR(ALLTRIM(loc_cCta),10), ;
                                loc_cRClis, ;
                                PADR(ALLTRIM(CrSigCdNec.CMats),14), ;
                                ALLTRIM(CrSigCdPro.DPros), ;
                                loc_lcPro, loc_lcDpr, ;
                                PADR(ALLTRIM(loc_cTpOps),15), ;
                                PADR(ALLTRIM(CrSigCdPro.Cunis),3), ;
                                loc_cPed, loc_nEnv, loc_ldData, ;
                                CrSigCdNec.Fators, ;
                                PADR(ALLTRIM(CrSigCdPro.Moecs),3), ;
                                PADR(ALLTRIM(CrSigCdPro.Cclass),3), ;
                                PADR(ALLTRIM(CrSigCdPro.CodFinp),3), ;
                                loc_lcDimen, ;
                                PADR(ALLTRIM(CrSigCdPro.Cgrus),3), ;
                                PADR(ALLTRIM(CrSigCdPro.Sgrus),3), ;
                                loc_cDFinP, loc_cDClass)
                    ENDIF

                    SELECT TmpRelat
                    REPLACE Qtde WITH Qtde + CrSigCdNec.Qtds
                    IF ALLTRIM(CrSigCdPro.Moecs) <> loc_cMoeda
                        loc_nValorCalc = fCarregarCambio(ALLTRIM(CrSigCdPro.Moecs), DATE()) / ;
                                         fCarregarCambio(loc_cMoeda, DATE())
                    ELSE
                        loc_nValorCalc = CrSigCdPro.Pcuss * CrSigCdNec.Qtds
                    ENDIF
                    REPLACE Valor WITH Valor + loc_nValorCalc
                    REPLACE Moecs WITH IIF(ALLTRIM(CrSigCdPro.Moecs) <> loc_cMoeda, ;
                        loc_cMoeda, ALLTRIM(CrSigCdPro.Moecs))

                    *-- Linha de total geral (somente modo Analitico)
                    IF loc_nAgru = 1
                        loc_cChaveTotal = DTOS(CTOD("31/12/9999")) + ;
                                          REPLICATE(CHR(255), 20) + ;
                                          PADR(ALLTRIM(loc_cTpOps), 15) + ;
                                          PADR(ALLTRIM(CrSigCdPro.Cunis), 3) + ;
                                          PADR(ALLTRIM(CrSigCdNec.CMats), 14) + ;
                                          PADR(" ", 31) + STR(0, 10)
                        SELECT TmpRelat
                        SET ORDER TO TAG FFuncMat
                        IF !SEEK(loc_cChaveTotal)
                            INSERT INTO TmpRelat (Fase, IClis, RClis, CMats, TpOps, ;
                                CUnis, Moecs, Datas, CodFinP, Cclass) ;
                                VALUES (REPLICATE(CHR(255),10), ;
                                    REPLICATE(CHR(255),10), ;
                                    "Total Geral : ", ;
                                    PADR(ALLTRIM(CrSigCdNec.CMats),14), ;
                                    PADR(ALLTRIM(loc_cTpOps),15), ;
                                    PADR(ALLTRIM(CrSigCdPro.Cunis),3), ;
                                    PADR(ALLTRIM(CrSigCdPro.Moecs),3), ;
                                    CTOD("31/12/9999"), "", "")
                        ENDIF
                        SELECT TmpRelat
                        REPLACE Qtde WITH Qtde + CrSigCdNec.Qtds
                        IF ALLTRIM(CrSigCdPro.Moecs) <> loc_cMoeda
                            loc_nValorCalc = fCarregarCambio(ALLTRIM(CrSigCdPro.Moecs), DATE()) / ;
                                             fCarregarCambio(loc_cMoeda, DATE())
                        ELSE
                            loc_nValorCalc = CrSigCdPro.Pcuss * CrSigCdNec.Qtds
                        ENDIF
                        REPLACE Valor WITH Valor + loc_nValorCalc
                        REPLACE Moecs WITH IIF(ALLTRIM(CrSigCdPro.Moecs) <> loc_cMoeda, ;
                            loc_cMoeda, ALLTRIM(CrSigCdPro.Moecs))
                    ENDIF

                ENDSCAN

                WAIT CLEAR
            ENDIF

            *-- Agregar TmpRelat conforme tipo de agrupamento
            SELECT TmpRelat
            GO TOP

            DO CASE
                CASE loc_nAgru = 1
                    loc_cCabTipo = " - Tipo : Anal" + CHR(237) + "tico"
                    SELECT * FROM TmpRelat ;
                        ORDER BY Datas, Fase, IClis, TpOps, CUnis, Moecs, CMats, Qtde DESC ;
                        INTO CURSOR TmpRelat READWRITE

                CASE loc_nAgru = 2
                    loc_cCabTipo = " - Tipo : Modelo"
                    SELECT CodFinp, Cunis, ;
                        SUM(Qtds) AS QtdTrabs, SUM(Qtds * Pcuss) AS CustoTrabs ;
                        FROM TmpProd ;
                        GROUP BY CodFinp, Cunis ;
                        ORDER BY CodFinp, QtdTrabs DESC ;
                        INTO CURSOR TmpProd READWRITE
                    SELECT a.TpOps, a.CodFinp AS Agrupa, a.DFinP AS Dagrupa, ;
                        a.Cunis, a.Moecs, b.QtdTrabs, ;
                        SUM(a.Qtde) AS Qtde, SUM(a.Valor) AS Valor, ;
                        b.CustoTrabs, ((SUM(a.Qtde) / b.QtdTrabs) * 100) AS PercMat ;
                        FROM TmpRelat a LEFT JOIN TmpProd b ;
                            ON a.CodFinP = b.CodFinP AND a.Cunis = b.Cunis ;
                        GROUP BY a.TpOps, a.CodFinp, a.DFinP, a.Cunis, a.Moecs, ;
                            b.QtdTrabs, b.CustoTrabs ;
                        ORDER BY a.TpOps, a.CodFinp, a.Cunis ;
                        INTO CURSOR TmpRelat READWRITE

                CASE loc_nAgru = 3
                    loc_cCabTipo = " - Tipo : Classifica" + CHR(231) + CHR(227) + "o"
                    SELECT Cclass, Cunis, ;
                        SUM(Qtds) AS QtdTrabs, SUM(Qtds * Pcuss) AS CustoTrabs ;
                        FROM TmpProd ;
                        GROUP BY Cclass, Cunis ;
                        ORDER BY Cclass, QtdTrabs DESC ;
                        INTO CURSOR TmpProd READWRITE
                    SELECT a.TpOps, a.Cclass AS Agrupa, a.DClass AS Dagrupa, ;
                        a.Cunis, a.Moecs, b.QtdTrabs, ;
                        SUM(a.Qtde) AS Qtde, SUM(a.Valor) AS Valor, ;
                        b.CustoTrabs, ((SUM(a.Qtde) / b.QtdTrabs) * 100) AS PercMat ;
                        FROM TmpRelat a LEFT JOIN TmpProd b ;
                            ON a.Cclass = b.Cclass AND a.Cunis = b.Cunis ;
                        GROUP BY a.TpOps, a.Cclass, a.DClass, a.Cunis, a.Moecs, ;
                            b.QtdTrabs, b.CustoTrabs ;
                        ORDER BY a.TpOps, a.Cclass, a.Cunis ;
                        INTO CURSOR TmpRelat READWRITE

                CASE loc_nAgru = 4
                    loc_cCabTipo = " - Tipo : Conta"
                    SELECT GrupoOs, ContaOs, Cunis, ;
                        SUM(Qtds) AS QtdTrabs, SUM(Qtds * Pcuss) AS CustoTrabs ;
                        FROM TmpProd ;
                        GROUP BY GrupoOs, ContaOs, Cunis ;
                        ORDER BY GrupoOs, ContaOs, QtdTrabs DESC ;
                        INTO CURSOR TmpProd READWRITE
                    SELECT a.TpOps, a.Fase AS Agrupa, ;
                        ALLTRIM(a.IClis) + " - " + ALLTRIM(a.RClis) AS Dagrupa, ;
                        a.Cunis, a.Moecs, b.QtdTrabs, ;
                        SUM(a.Qtde) AS Qtde, SUM(a.Valor) AS Valor, ;
                        b.CustoTrabs, ((SUM(a.Qtde) / b.QtdTrabs) * 100) AS PercMat ;
                        FROM TmpRelat a LEFT JOIN TmpProd b ;
                            ON ALLTRIM(a.Fase) = ALLTRIM(b.GrupoOs) ;
                                AND ALLTRIM(a.IClis) = ALLTRIM(b.ContaOs) ;
                                AND a.Cunis = b.Cunis ;
                        GROUP BY a.TpOps, a.Fase, Dagrupa, a.Cunis, a.Moecs, ;
                            b.QtdTrabs, b.CustoTrabs ;
                        ORDER BY a.TpOps, a.Fase, Dagrupa, a.Cunis ;
                        INTO CURSOR TmpRelat READWRITE

            ENDCASE

            *-- Cabecalho do relatorio
            loc_cCab = "An" + CHR(225) + "lise por Tipo de Material" + ;
                       CHR(13) + "Moeda : " + loc_cMoeda + loc_cCabTipo
            IF loc_lDestino
                loc_cSub = "Por Destino"
            ELSE
                loc_cSub = "Por Origem"
            ENDIF
            loc_cSub = loc_cSub + " - Per" + CHR(237) + "odo : " + ;
                       ALLTRIM(DTOC(loc_dDatai)) + " at" + CHR(233) + " " + ;
                       ALLTRIM(DTOC(loc_dDataf))

            *-- Nome da empresa
            loc_cEmp = ALLTRIM(go_4c_Sistema.cCodEmpresa) + " - " + ALLTRIM(go_4c_Sistema.cEmpresa)

            *-- Cursor de cabecalho
            IF USED("dbCabecalho")
                USE IN dbCabecalho
            ENDIF
            CREATE CURSOR dbCabecalho (Titulo c(100), SubTitulo c(100), NomeEmpresa c(100))
            INSERT INTO dbCabecalho (Titulo, SubTitulo, NomeEmpresa) ;
                VALUES (loc_cCab, loc_cSub, loc_cEmp)

            SELECT TmpRelat
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro(loc_oErro.Message, "Erro em PrepararDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                DO CASE
                    CASE THIS.this_nAgru = 1
                        REPORT FORM (gc_4c_CaminhoReports + "SigReAt2") PREVIEW NOCONSOLE
                    OTHERWISE
                        REPORT FORM (gc_4c_CaminhoReports + "SigReAt3") PREVIEW NOCONSOLE
                ENDCASE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao visualizar relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                DO CASE
                    CASE THIS.this_nAgru = 1
                        REPORT FORM (gc_4c_CaminhoReports + "SigReAt2") TO PRINT PROMPT NOCONSOLE
                    OTHERWISE
                        REPORT FORM (gc_4c_CaminhoReports + "SigReAt3") TO PRINT PROMPT NOCONSOLE
                ENDCASE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao imprimir relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro da ultima operacao
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao possui chave primaria persistida
    * Para fins de auditoria/log, retorna chave composta dos filtros principais
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = DTOC(THIS.this_dDatai) + "|" + DTOC(THIS.this_dDataf) + "|" + ;
                     ALLTRIM(THIS.this_cTpGOp) + "|" + ALLTRIM(THIS.this_cGrupo) + "|" + ;
                     ALLTRIM(THIS.this_cConta) + "|" + STR(THIS.this_nAgru, 1)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Nao aplicavel a relatorios (RelatorioBase nao persiste)
    * Mantido para compatibilidade com padrao de validacao do pipeline.
    * Em relatorios, a carga dos filtros vem do Form (FormParaRelatorio).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel a relatorios (frmrelatorio nao persiste dados)
    * Mantido para compatibilidade com padrao de validacao do pipeline.
    * A acao equivalente em relatorios eh Visualizar()/Imprimir().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                  "o aplic" + CHR(225) + "vel a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel a relatorios (frmrelatorio nao persiste dados)
    * Mantido para compatibilidade com padrao de validacao do pipeline.
    * A acao equivalente em relatorios eh Visualizar()/Imprimir().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                  "o aplic" + CHR(225) + "vel a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

ENDDEFINE

