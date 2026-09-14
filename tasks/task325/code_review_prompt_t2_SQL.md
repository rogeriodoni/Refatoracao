# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (11)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CBARS, CBARS_OLD
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CBARS, CBARS_OLD
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CBARS, CBARS_OLD
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRUPOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CBARS, CBARS_OLD
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CGRUS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CBARS, CBARS_OLD
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DGRUS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CBARS, CBARS_OLD
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCRICAOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CBARS, CBARS_OLD
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'COLECOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CBARS, CBARS_OLD
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CBARS, CBARS_OLD
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'LINHAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CBARS, CBARS_OLD
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PROMOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CBARS, CBARS_OLD

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
Select csEtiqDig
		m.lcMcrSql1 = [select a.* from SigCdOpd a ]
			m.lnErro1 = .poDatamgr.Sqlexecute(m.lcMcrSql1,'SigCdOpd')
				Select ('SigCdOpd')
		m.lcMcrSql1 = [select a.* from SigCdPac a ]
		m.lnErro1 = .poDatamgr.Sqlexecute(m.lcMcrSql1,'crSigCdpac')
	If !seek(this.value,'SigCdOpd','dopps')
	lStrQuery = [Select a.CPros,a.CBars ] + ;
			[From SigOpEtq a ] + ;
			[left join sigopeta b on a.cpros = b.cpros and a.cbars = b.cbars_new ] + ;
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CrEtiqs') < 1
	Select CrEtiqs
	lStrQuery = [Select a.CPros,a.CBars ] + ;
			[From SigOpEtq a ] + ;
			[left join sigopeta b on a.cpros = b.cpros and a.cbars = b.cbars_new ] + ;
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CrEtiqs') < 1
	Select CrEtiqs

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrRet.prg) - TRECHOS RELEVANTES PARA PASS SQL (3321 linhas total):

*-- Linhas 1527 a 1548:
1527:                 USE IN cursor_4c_Opd
1528:             ENDIF
1529: 
1530:             loc_cSQL = "SELECT a.* FROM SigCdOpd a"
1531:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Opd") > 0
1532:                 IF USED("cursor_4c_Opd")
1533:                     SELECT cursor_4c_Opd
1534:                     INDEX ON dopps TAG dopps
1535:                     SET ORDER TO
1536:                 ENDIF
1537:             ENDIF
1538: 
1539:         CATCH TO loc_oErro
1540:             *-- Cursor de operacoes opcional; nao bloquear abertura do form
1541:         ENDTRY
1542:     ENDPROC
1543: 
1544:     *==========================================================================
1545:     * InicializarCampos - Limpa / inicializa todos os campos de filtro
1546:     *==========================================================================
1547:     PROTECTED PROCEDURE InicializarCampos()
1548:         LOCAL loc_oErro

*-- Linhas 1615 a 1663:
1615:         LOCAL loc_cSQL, loc_oErro
1616: 
1617:         TRY
1618:             loc_cSQL = "SELECT TOP 1 fixaemp FROM SigCdPac"
1619:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pac") > 0
1620:                 IF USED("cursor_4c_Pac") AND !EOF("cursor_4c_Pac")
1621:                     SELECT cursor_4c_Pac
1622:                     IF cursor_4c_Pac.fixaemp = 1
1623:                         THIS.txt_4c_CdEmpresa.Value   = go_4c_Sistema.cCodEmpresa
1624:                         THIS.txt_4c_CdEmpresa.Enabled = .F.
1625:                         THIS.PreencherDescEmpresa(go_4c_Sistema.cCodEmpresa)
1626:                     ENDIF
1627:                 ENDIF
1628:                 IF USED("cursor_4c_Pac")
1629:                     USE IN cursor_4c_Pac
1630:                 ENDIF
1631:             ENDIF
1632:         CATCH TO loc_oErro
1633:             *-- Parametro de empresa fixa opcional; ignorar falha
1634:         ENDTRY
1635:     ENDPROC
1636: 
1637:     *==========================================================================
1638:     * PreencherDescEmpresa - Busca Razas em SigCdEmp pelo codigo
1639:     *==========================================================================
1640:     PROTECTED PROCEDURE PreencherDescEmpresa(par_cCodEmp)
1641:         LOCAL loc_cSQL, loc_oErro
1642: 
1643:         TRY
1644:             loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + ;
1645:                        EscaparSQL(ALLTRIM(par_cCodEmp))
1646:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp") > 0
1647:                 IF USED("cursor_4c_Emp") AND !EOF("cursor_4c_Emp")
1648:                     SELECT cursor_4c_Emp
1649:                     THIS.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_Emp.Razas)
1650:                 ENDIF
1651:                 IF USED("cursor_4c_Emp")
1652:                     USE IN cursor_4c_Emp
1653:                 ENDIF
1654:             ENDIF
1655:         CATCH TO loc_oErro
1656:             *-- Descricao de empresa opcional; ignorar falha
1657:         ENDTRY
1658:     ENDPROC
1659: 
1660:     *==========================================================================
1661:     * TornarControlesVisiveis - Torna visiveis todos os controles de nivel raiz
1662:     *==========================================================================
1663:     PROCEDURE TornarControlesVisiveis()

*-- Linhas 1942 a 1963:
1942:             RETURN
1943:         ENDIF
1944:         TRY
1945:             loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cCod)
1946:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldEmp") > 0 AND ;
1947:                USED("cursor_4c_VldEmp") AND !EOF("cursor_4c_VldEmp")
1948:                 SELECT cursor_4c_VldEmp
1949:                 THIS.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_VldEmp.Cemps)
1950:                 THIS.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_VldEmp.Razas)
1951:             ELSE
1952:                 THIS.txt_4c_CdEmpresa.Value = ""
1953:                 THIS.txt_4c_DsEmpresa.Value = ""
1954:             ENDIF
1955:         CATCH TO loc_oErro
1956:             MsgErro(loc_oErro.Message, "Erro ao validar Empresa")
1957:         ENDTRY
1958:         IF USED("cursor_4c_VldEmp")
1959:             USE IN cursor_4c_VldEmp
1960:         ENDIF
1961:     ENDPROC
1962: 
1963:     PROCEDURE ValidarDataFinal(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 1978 a 2019:
1978:         ENDIF
1979:         TRY
1980:             IF USED("cursor_4c_Opd")
1981:                 SELECT cursor_4c_Opd
1982:                 SET ORDER TO dopps
1983:                 IF !SEEK(loc_cValor, "cursor_4c_Opd", "dopps")
1984:                     THIS.txt_4c_NmOperacao.Value = ""
1985:                 ELSE
1986:                     THIS.txt_4c_NmOperacao.Value = ALLTRIM(cursor_4c_Opd.dopps)
1987:                 ENDIF
1988:             ELSE
1989:                 THIS.txt_4c_NmOperacao.Value = ""
1990:             ENDIF
1991:         CATCH TO loc_oErro
1992:             MsgErro(loc_oErro.Message, "Erro ao validar Opera" + CHR(231) + CHR(227) + "o")
1993:         ENDTRY
1994:     ENDPROC
1995: 
1996:     PROCEDURE ValidarIndustria(par_nKeyCode, par_nShiftAltCtrl)
1997:         LOCAL loc_cValor, loc_oErro
1998:         loc_cValor = UPPER(ALLTRIM(THIS.txt_4c_NmIndustria.Value))
1999:         IF EMPTY(loc_cValor)
2000:             RETURN
2001:         ENDIF
2002:         TRY
2003:             IF USED("cursor_4c_Opd")
2004:                 SELECT cursor_4c_Opd
2005:                 SET ORDER TO dopps
2006:                 IF !SEEK(loc_cValor, "cursor_4c_Opd", "dopps")
2007:                     THIS.txt_4c_NmIndustria.Value = ""
2008:                 ELSE
2009:                     THIS.txt_4c_NmIndustria.Value = ALLTRIM(cursor_4c_Opd.dopps)
2010:                 ENDIF
2011:             ELSE
2012:                 THIS.txt_4c_NmIndustria.Value = ""
2013:             ENDIF
2014:         CATCH TO loc_oErro
2015:             MsgErro(loc_oErro.Message, "Erro ao validar Ind" + CHR(250) + "stria")
2016:         ENDTRY
2017:     ENDPROC
2018: 
2019:     PROCEDURE ValidarGrupoEstoque(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 2025 a 2046:
2025:             RETURN
2026:         ENDIF
2027:         TRY
2028:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCod)
2029:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldGrEst") > 0 AND ;
2030:                USED("cursor_4c_VldGrEst") AND !EOF("cursor_4c_VldGrEst")
2031:                 SELECT cursor_4c_VldGrEst
2032:                 THIS.txt_4c_CdGrEstoque.Value = ALLTRIM(cursor_4c_VldGrEst.codigos)
2033:                 THIS.txt_4c_DsGrEstoque.Value = ALLTRIM(cursor_4c_VldGrEst.descrs)
2034:             ELSE
2035:                 THIS.txt_4c_CdGrEstoque.Value = ""
2036:                 THIS.txt_4c_DsGrEstoque.Value = ""
2037:             ENDIF
2038:         CATCH TO loc_oErro
2039:             MsgErro(loc_oErro.Message, "Erro ao validar Grupo Estoque")
2040:         ENDTRY
2041:         IF USED("cursor_4c_VldGrEst")
2042:             USE IN cursor_4c_VldGrEst
2043:         ENDIF
2044:         THIS.OnChangeCdGrEstoque()
2045:     ENDPROC
2046: 

*-- Linhas 2053 a 2133:
2053:             RETURN
2054:         ENDIF
2055:         TRY
2056:             loc_cSQL = "SELECT a.contas, b.descrs FROM SIGCDGFC a " + ;
2057:                        "INNER JOIN SigCdGcr b ON b.codigos = a.contas " + ;
2058:                        "WHERE a.contas = " + EscaparSQL(loc_cCod)
2059:             IF !EMPTY(loc_cGrupo)
2060:                 loc_cSQL = loc_cSQL + " AND a.grupos = " + EscaparSQL(loc_cGrupo)
2061:             ENDIF
2062:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldEst") > 0 AND ;
2063:                USED("cursor_4c_VldEst") AND !EOF("cursor_4c_VldEst")
2064:                 SELECT cursor_4c_VldEst
2065:                 THIS.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_VldEst.contas)
2066:                 THIS.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_VldEst.descrs)
2067:             ELSE
2068:                 THIS.txt_4c_CdEstoque.Value = ""
2069:                 THIS.txt_4c_DsEstoque.Value = ""
2070:             ENDIF
2071:         CATCH TO loc_oErro
2072:             MsgErro(loc_oErro.Message, "Erro ao validar Estoque")
2073:         ENDTRY
2074:         IF USED("cursor_4c_VldEst")
2075:             USE IN cursor_4c_VldEst
2076:         ENDIF
2077:     ENDPROC
2078: 
2079:     PROCEDURE ValidarProduto(par_nKeyCode, par_nShiftAltCtrl)
2080:         LOCAL loc_cCod, loc_cSQL, loc_oErro
2081:         loc_cCod = ALLTRIM(THIS.txt_4c_Cod.Value)
2082:         IF EMPTY(loc_cCod)
2083:             THIS.txt_4c_Dcod.Value = ""
2084:             RETURN
2085:         ENDIF
2086:         TRY
2087:             loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCod)
2088:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldPro") > 0 AND ;
2089:                USED("cursor_4c_VldPro") AND !EOF("cursor_4c_VldPro")
2090:                 SELECT cursor_4c_VldPro
2091:                 THIS.txt_4c_Cod.Value  = ALLTRIM(cursor_4c_VldPro.CPros)
2092:                 THIS.txt_4c_Dcod.Value = ALLTRIM(cursor_4c_VldPro.DPros)
2093:             ELSE
2094:                 THIS.txt_4c_Cod.Value  = ""
2095:                 THIS.txt_4c_Dcod.Value = ""
2096:             ENDIF
2097:         CATCH TO loc_oErro
2098:             MsgErro(loc_oErro.Message, "Erro ao validar Produto")
2099:         ENDTRY
2100:         IF USED("cursor_4c_VldPro")
2101:             USE IN cursor_4c_VldPro
2102:         ENDIF
2103:     ENDPROC
2104: 
2105:     PROCEDURE ValidarEtii(par_nKeyCode, par_nShiftAltCtrl)
2106:         LOCAL loc_nCBars, loc_cSQL, loc_oErro
2107:         IF EMPTY(THIS.txt_4c_Etii.Value) OR THIS.txt_4c_Etii.Value = 0
2108:             RETURN
2109:         ENDIF
2110:         TRY
2111:             loc_nCBars = THIS.txt_4c_Etii.Value
2112:             loc_cSQL = "SELECT TOP 1 a.CPros, a.CBars FROM SigOpEtq a " + ;
2113:                        "LEFT JOIN SigOpEta b ON a.CPros = b.CPros AND a.CBars = b.Cbars_new " + ;
2114:                        "WHERE (a.CBars = " + FormatarNumeroSQL(loc_nCBars) + ;
2115:                        " OR b.Cbars_old = " + FormatarNumeroSQL(loc_nCBars) + ")"
2116:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldEtii") > 0 AND ;
2117:                USED("cursor_4c_VldEtii") AND !EOF("cursor_4c_VldEtii")
2118:                 SELECT cursor_4c_VldEtii
2119:                 THIS.txt_4c_Etii.Value = cursor_4c_VldEtii.CBars
2120:                 IF EMPTY(THIS.txt_4c_Etif.Value) OR THIS.txt_4c_Etif.Value = 0
2121:                     THIS.txt_4c_Etif.Value = THIS.txt_4c_Etii.Value
2122:                 ENDIF
2123:             ELSE
2124:                 MsgAviso("Etiqueta n" + CHR(227) + "o cadastrada.")
2125:                 THIS.txt_4c_Etii.Value = 0
2126:                 THIS.txt_4c_Etii.SetFocus()
2127:             ENDIF
2128:         CATCH TO loc_oErro
2129:             MsgErro(loc_oErro.Message, "Erro ao validar Etiqueta Inicial")
2130:         ENDTRY
2131:         IF USED("cursor_4c_VldEtii")
2132:             USE IN cursor_4c_VldEtii
2133:         ENDIF

*-- Linhas 2141 a 2243:
2141:         ENDIF
2142:         TRY
2143:             loc_nCBars = THIS.txt_4c_Etif.Value
2144:             loc_cSQL = "SELECT TOP 1 a.CPros, a.CBars FROM SigOpEtq a " + ;
2145:                        "LEFT JOIN SigOpEta b ON a.CPros = b.CPros AND a.CBars = b.Cbars_new " + ;
2146:                        "WHERE (a.CBars = " + FormatarNumeroSQL(loc_nCBars) + ;
2147:                        " OR b.Cbars_old = " + FormatarNumeroSQL(loc_nCBars) + ")"
2148:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldEtif") > 0 AND ;
2149:                USED("cursor_4c_VldEtif") AND !EOF("cursor_4c_VldEtif")
2150:                 SELECT cursor_4c_VldEtif
2151:                 THIS.txt_4c_Etif.Value = cursor_4c_VldEtif.CBars
2152:             ELSE
2153:                 MsgAviso("Etiqueta n" + CHR(227) + "o cadastrada.")
2154:                 THIS.txt_4c_Etif.Value = 0
2155:                 THIS.txt_4c_Etif.SetFocus()
2156:             ENDIF
2157:         CATCH TO loc_oErro
2158:             MsgErro(loc_oErro.Message, "Erro ao validar Etiqueta Final")
2159:         ENDTRY
2160:         IF USED("cursor_4c_VldEtif")
2161:             USE IN cursor_4c_VldEtif
2162:         ENDIF
2163:         THIS.OnChangeEtif()
2164:     ENDPROC
2165: 
2166:     PROCEDURE ValidarGrandeGrupo(par_nKeyCode, par_nShiftAltCtrl)
2167:         LOCAL loc_cCod, loc_cSQL, loc_oErro
2168:         loc_cCod = ALLTRIM(THIS.txt_4c_GdeGrupo.Value)
2169:         IF EMPTY(loc_cCod)
2170:             RETURN
2171:         ENDIF
2172:         TRY
2173:             loc_cSQL = "SELECT codigos, descs FROM SigCdGpr WHERE codigos = " + EscaparSQL(loc_cCod)
2174:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldGpr") > 0 AND ;
2175:                USED("cursor_4c_VldGpr") AND !EOF("cursor_4c_VldGpr")
2176:                 SELECT cursor_4c_VldGpr
2177:                 THIS.txt_4c_GdeGrupo.Value = ALLTRIM(cursor_4c_VldGpr.codigos)
2178:             ELSE
2179:                 THIS.txt_4c_GdeGrupo.Value = ""
2180:             ENDIF
2181:         CATCH TO loc_oErro
2182:             MsgErro(loc_oErro.Message, "Erro ao validar Grande Grupo")
2183:         ENDTRY
2184:         IF USED("cursor_4c_VldGpr")
2185:             USE IN cursor_4c_VldGpr
2186:         ENDIF
2187:     ENDPROC
2188: 
2189:     PROCEDURE ValidarGrupoProduto(par_nKeyCode, par_nShiftAltCtrl)
2190:         LOCAL loc_cCod, loc_cSQL, loc_oErro
2191:         loc_cCod = ALLTRIM(THIS.txt_4c_Cgru.Value)
2192:         IF EMPTY(loc_cCod)
2193:             THIS.txt_4c_Dgru.Value = ""
2194:             THIS.OnChangeCgru()
2195:             RETURN
2196:         ENDIF
2197:         TRY
2198:             loc_cSQL = "SELECT cgrus, dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCod)
2199:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldGrp") > 0 AND ;
2200:                USED("cursor_4c_VldGrp") AND !EOF("cursor_4c_VldGrp")
2201:                 SELECT cursor_4c_VldGrp
2202:                 THIS.txt_4c_Cgru.Value = ALLTRIM(cursor_4c_VldGrp.cgrus)
2203:                 THIS.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_VldGrp.dgrus)
2204:             ELSE
2205:                 THIS.txt_4c_Cgru.Value = ""
2206:                 THIS.txt_4c_Dgru.Value = ""
2207:             ENDIF
2208:         CATCH TO loc_oErro
2209:             MsgErro(loc_oErro.Message, "Erro ao validar Grupo Produto")
2210:         ENDTRY
2211:         IF USED("cursor_4c_VldGrp")
2212:             USE IN cursor_4c_VldGrp
2213:         ENDIF
2214:         THIS.OnChangeCgru()
2215:     ENDPROC
2216: 
2217:     PROCEDURE ValidarGrupoProdutoDesc(par_nKeyCode, par_nShiftAltCtrl)
2218:         LOCAL loc_cDesc, loc_cSQL, loc_oErro
2219:         loc_cDesc = ALLTRIM(THIS.txt_4c_Dgru.Value)
2220:         IF EMPTY(loc_cDesc) OR !EMPTY(ALLTRIM(THIS.txt_4c_Cgru.Value))
2221:             RETURN
2222:         ENDIF
2223:         TRY
2224:             loc_cSQL = "SELECT TOP 1 cgrus, dgrus FROM SigCdGrp WHERE dgrus LIKE " + ;
2225:                        EscaparSQL(loc_cDesc + "%")
2226:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldGrpD") > 0 AND ;
2227:                USED("cursor_4c_VldGrpD") AND !EOF("cursor_4c_VldGrpD")
2228:                 SELECT cursor_4c_VldGrpD
2229:                 THIS.txt_4c_Cgru.Value = ALLTRIM(cursor_4c_VldGrpD.cgrus)
2230:                 THIS.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_VldGrpD.dgrus)
2231:             ELSE
2232:                 THIS.txt_4c_Dgru.Value = ""
2233:             ENDIF
2234:         CATCH TO loc_oErro
2235:             MsgErro(loc_oErro.Message, "Erro ao validar Grupo Produto")
2236:         ENDTRY
2237:         IF USED("cursor_4c_VldGrpD")
2238:             USE IN cursor_4c_VldGrpD
2239:         ENDIF
2240:         THIS.OnChangeCgru()
2241:     ENDPROC
2242: 
2243:     PROCEDURE ValidarSubGrupo(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 2249 a 2274:
2249:             RETURN
2250:         ENDIF
2251:         TRY
2252:             loc_cSQL = "SELECT codigos, descricaos FROM SigCdPsg WHERE codigos = " + ;
2253:                        EscaparSQL(loc_cCod)
2254:             IF !EMPTY(loc_cGru)
2255:                 loc_cSQL = loc_cSQL + " AND cgrus = " + EscaparSQL(loc_cGru)
2256:             ENDIF
2257:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldPsg") > 0 AND ;
2258:                USED("cursor_4c_VldPsg") AND !EOF("cursor_4c_VldPsg")
2259:                 SELECT cursor_4c_VldPsg
2260:                 THIS.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_VldPsg.codigos)
2261:                 THIS.txt_4c_DSGru.Value = ALLTRIM(cursor_4c_VldPsg.descricaos)
2262:             ELSE
2263:                 THIS.txt_4c_CSGru.Value = ""
2264:                 THIS.txt_4c_DSGru.Value = ""
2265:             ENDIF
2266:         CATCH TO loc_oErro
2267:             MsgErro(loc_oErro.Message, "Erro ao validar Subgrupo")
2268:         ENDTRY
2269:         IF USED("cursor_4c_VldPsg")
2270:             USE IN cursor_4c_VldPsg
2271:         ENDIF
2272:     ENDPROC
2273: 
2274:     PROCEDURE ValidarSubGrupoDesc(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 2280 a 2305:
2280:             RETURN
2281:         ENDIF
2282:         TRY
2283:             loc_cSQL = "SELECT TOP 1 codigos, descricaos FROM SigCdPsg WHERE descricaos LIKE " + ;
2284:                        EscaparSQL(loc_cDesc + "%")
2285:             IF !EMPTY(loc_cGru)
2286:                 loc_cSQL = loc_cSQL + " AND cgrus = " + EscaparSQL(loc_cGru)
2287:             ENDIF
2288:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldPsgD") > 0 AND ;
2289:                USED("cursor_4c_VldPsgD") AND !EOF("cursor_4c_VldPsgD")
2290:                 SELECT cursor_4c_VldPsgD
2291:                 THIS.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_VldPsgD.codigos)
2292:                 THIS.txt_4c_DSGru.Value = ALLTRIM(cursor_4c_VldPsgD.descricaos)
2293:             ELSE
2294:                 THIS.txt_4c_CSGru.Value = ""
2295:                 THIS.txt_4c_DSGru.Value = ""
2296:             ENDIF
2297:         CATCH TO loc_oErro
2298:             MsgErro(loc_oErro.Message, "Erro ao validar Subgrupo")
2299:         ENDTRY
2300:         IF USED("cursor_4c_VldPsgD")
2301:             USE IN cursor_4c_VldPsgD
2302:         ENDIF
2303:     ENDPROC
2304: 
2305:     PROCEDURE ValidarColecao(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 2311 a 2468:
2311:             RETURN
2312:         ENDIF
2313:         TRY
2314:             loc_cSQL = "SELECT Colecoes, Descs FROM SigCdCol WHERE Colecoes = " + EscaparSQL(loc_cCod)
2315:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldCol") > 0 AND ;
2316:                USED("cursor_4c_VldCol") AND !EOF("cursor_4c_VldCol")
2317:                 SELECT cursor_4c_VldCol
2318:                 THIS.txt_4c_Col.Value  = ALLTRIM(cursor_4c_VldCol.Colecoes)
2319:                 THIS.txt_4c_DCol.Value = ALLTRIM(cursor_4c_VldCol.Descs)
2320:             ELSE
2321:                 THIS.txt_4c_Col.Value  = ""
2322:                 THIS.txt_4c_DCol.Value = ""
2323:             ENDIF
2324:         CATCH TO loc_oErro
2325:             MsgErro(loc_oErro.Message, "Erro ao validar Cole" + CHR(231) + CHR(227) + "o")
2326:         ENDTRY
2327:         IF USED("cursor_4c_VldCol")
2328:             USE IN cursor_4c_VldCol
2329:         ENDIF
2330:         THIS.OnChangeCol()
2331:     ENDPROC
2332: 
2333:     PROCEDURE ValidarColecaoDesc(par_nKeyCode, par_nShiftAltCtrl)
2334:         LOCAL loc_cDesc, loc_cSQL, loc_oErro
2335:         loc_cDesc = ALLTRIM(THIS.txt_4c_DCol.Value)
2336:         IF EMPTY(loc_cDesc) OR !EMPTY(ALLTRIM(THIS.txt_4c_Col.Value))
2337:             RETURN
2338:         ENDIF
2339:         TRY
2340:             loc_cSQL = "SELECT TOP 1 Colecoes, Descs FROM SigCdCol WHERE Descs LIKE " + ;
2341:                        EscaparSQL(loc_cDesc + "%")
2342:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldColD") > 0 AND ;
2343:                USED("cursor_4c_VldColD") AND !EOF("cursor_4c_VldColD")
2344:                 SELECT cursor_4c_VldColD
2345:                 THIS.txt_4c_Col.Value  = ALLTRIM(cursor_4c_VldColD.Colecoes)
2346:                 THIS.txt_4c_DCol.Value = ALLTRIM(cursor_4c_VldColD.Descs)
2347:             ELSE
2348:                 THIS.txt_4c_Col.Value  = ""
2349:                 THIS.txt_4c_DCol.Value = ""
2350:             ENDIF
2351:         CATCH TO loc_oErro
2352:             MsgErro(loc_oErro.Message, "Erro ao validar Cole" + CHR(231) + CHR(227) + "o")
2353:         ENDTRY
2354:         IF USED("cursor_4c_VldColD")
2355:             USE IN cursor_4c_VldColD
2356:         ENDIF
2357:         THIS.OnChangeCol()
2358:     ENDPROC
2359: 
2360:     PROCEDURE ValidarLinha(par_nKeyCode, par_nShiftAltCtrl)
2361:         LOCAL loc_cCod, loc_cSQL, loc_oErro
2362:         loc_cCod = ALLTRIM(THIS.txt_4c_Lin.Value)
2363:         IF EMPTY(loc_cCod)
2364:             RETURN
2365:         ENDIF
2366:         TRY
2367:             loc_cSQL = "SELECT linhas, descs FROM SigCdLin WHERE linhas = " + EscaparSQL(loc_cCod)
2368:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldLin") > 0 AND ;
2369:                USED("cursor_4c_VldLin") AND !EOF("cursor_4c_VldLin")
2370:                 SELECT cursor_4c_VldLin
2371:                 THIS.txt_4c_Lin.Value = ALLTRIM(cursor_4c_VldLin.linhas)
2372:             ELSE
2373:                 THIS.txt_4c_Lin.Value = ""
2374:             ENDIF
2375:         CATCH TO loc_oErro
2376:             MsgErro(loc_oErro.Message, "Erro ao validar Linha")
2377:         ENDTRY
2378:         IF USED("cursor_4c_VldLin")
2379:             USE IN cursor_4c_VldLin
2380:         ENDIF
2381:     ENDPROC
2382: 
2383:     PROCEDURE ValidarLocalProduto(par_nKeyCode, par_nShiftAltCtrl)
2384:         LOCAL loc_cCod, loc_cSQL, loc_oErro
2385:         loc_cCod = ALLTRIM(THIS.txt_4c_Local.Value)
2386:         IF EMPTY(loc_cCod)
2387:             RETURN
2388:         ENDIF
2389:         TRY
2390:             loc_cSQL = "SELECT codigos FROM SigPrLcl WHERE codigos = " + EscaparSQL(loc_cCod)
2391:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldLoc") > 0 AND ;
2392:                USED("cursor_4c_VldLoc") AND !EOF("cursor_4c_VldLoc")
2393:                 SELECT cursor_4c_VldLoc
2394:                 THIS.txt_4c_Local.Value = ALLTRIM(cursor_4c_VldLoc.codigos)
2395:             ELSE
2396:                 THIS.txt_4c_Local.Value = ""
2397:             ENDIF
2398:         CATCH TO loc_oErro
2399:             MsgErro(loc_oErro.Message, "Erro ao validar Local do Produto")
2400:         ENDTRY
2401:         IF USED("cursor_4c_VldLoc")
2402:             USE IN cursor_4c_VldLoc
2403:         ENDIF
2404:     ENDPROC
2405: 
2406:     PROCEDURE ValidarLocalEtiqueta(par_nKeyCode, par_nShiftAltCtrl)
2407:         LOCAL loc_cCod, loc_cSQL, loc_oErro
2408:         loc_cCod = ALLTRIM(THIS.txt_4c_Localizas.Value)
2409:         IF EMPTY(loc_cCod)
2410:             RETURN
2411:         ENDIF
2412:         TRY
2413:             loc_cSQL = "SELECT codigos FROM SigPrLcl WHERE codigos = " + EscaparSQL(loc_cCod)
2414:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldLocE") > 0 AND ;
2415:                USED("cursor_4c_VldLocE") AND !EOF("cursor_4c_VldLocE")
2416:                 SELECT cursor_4c_VldLocE
2417:                 THIS.txt_4c_Localizas.Value = ALLTRIM(cursor_4c_VldLocE.codigos)
2418:             ELSE
2419:                 THIS.txt_4c_Localizas.Value = ""
2420:             ENDIF
2421:         CATCH TO loc_oErro
2422:             MsgErro(loc_oErro.Message, "Erro ao validar Local da Etiqueta")
2423:         ENDTRY
2424:         IF USED("cursor_4c_VldLocE")
2425:             USE IN cursor_4c_VldLocE
2426:         ENDIF
2427:     ENDPROC
2428: 
2429:     PROCEDURE ValidarPromocao(par_nKeyCode, par_nShiftAltCtrl)
2430:         LOCAL loc_cCod, loc_cSQL, loc_oErro
2431:         loc_cCod = ALLTRIM(THIS.txt_4c_Promos.Value)
2432:         IF EMPTY(loc_cCod)
2433:             RETURN
2434:         ENDIF
2435:         TRY
2436:             loc_cSQL = "SELECT promos FROM SigPrPmc WHERE promos = " + EscaparSQL(loc_cCod)
2437:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldPmc") > 0 AND ;
2438:                USED("cursor_4c_VldPmc") AND !EOF("cursor_4c_VldPmc")
2439:                 SELECT cursor_4c_VldPmc
2440:                 THIS.txt_4c_Promos.Value = ALLTRIM(cursor_4c_VldPmc.promos)
2441:             ELSE
2442:                 THIS.txt_4c_Promos.Value = ""
2443:             ENDIF
2444:         CATCH TO loc_oErro
2445:             MsgErro(loc_oErro.Message, "Erro ao validar Promo" + CHR(231) + CHR(227) + "o")
2446:         ENDTRY
2447:         IF USED("cursor_4c_VldPmc")
2448:             USE IN cursor_4c_VldPmc
2449:         ENDIF
2450:     ENDPROC
2451: 
2452:     *==========================================================================
2453:     * ABRIR BUSCA - Pickers usando FormBuscaAuxiliar (Modo 1: SELECT no Init)
2454:     *==========================================================================
2455: 
2456:     PROTECTED PROCEDURE AbrirBuscaEmpresa()
2457:         LOCAL loc_oBusca, loc_cValor, loc_oErro
2458:         TRY
2459:             loc_cValor = ALLTRIM(THIS.txt_4c_CdEmpresa.Value)
2460:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2461:                 "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", loc_cValor, "Empresa")
2462:             IF VARTYPE(loc_oBusca) = "O"
2463:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2464:                     THIS.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
2465:                     THIS.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
2466:                 ELSE
2467:                     IF !loc_oBusca.this_lAchouRegistro
2468:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")

*-- Linhas 2644 a 2662:
2644:         TRY
2645:             loc_cValor  = ALLTRIM(THIS.txt_4c_CdEstoque.Value)
2646:             loc_cGrupo  = ALLTRIM(THIS.txt_4c_CdGrEstoque.Value)
2647:             loc_cFiltro = IIF(EMPTY(loc_cGrupo), "", "grupos = " + EscaparSQL(loc_cGrupo))
2648:             loc_oBusca  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2649:                 "SIGCDGFC", "cursor_4c_BuscaEst", "contas", loc_cValor, ;
2650:                 "Estoque", .F., .T., loc_cFiltro)
2651:             IF VARTYPE(loc_oBusca) = "O"
2652:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2653:                     THIS.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_BuscaEst.contas)
2654:                     THIS.txt_4c_DsEstoque.Value = ""
2655:                 ELSE
2656:                     IF !loc_oBusca.this_lAchouRegistro
2657:                     loc_oBusca.mAddColuna("contas", "", "Estoque")
2658:                     loc_oBusca.mAddColuna("grupos", "", "Grupo")
2659:                     loc_oBusca.Show()
2660:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEst")
2661:                         THIS.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_BuscaEst.contas)
2662:                         THIS.txt_4c_DsEstoque.Value = ""

*-- Linhas 2837 a 2855:
2837:         TRY
2838:             loc_cValor  = ALLTRIM(THIS.txt_4c_CSGru.Value)
2839:             loc_cGru    = ALLTRIM(THIS.txt_4c_Cgru.Value)
2840:             loc_cFiltro = IIF(EMPTY(loc_cGru), "", "cgrus = " + EscaparSQL(loc_cGru))
2841:             loc_oBusca  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2842:                 "SigCdPsg", "cursor_4c_BuscaPsg", "codigos", loc_cValor, ;
2843:                 "Subgrupo", .F., .T., loc_cFiltro)
2844:             IF VARTYPE(loc_oBusca) = "O"
2845:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2846:                     THIS.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_BuscaPsg.codigos)
2847:                     THIS.txt_4c_DSGru.Value = ALLTRIM(cursor_4c_BuscaPsg.descricaos)
2848:                 ELSE
2849:                     IF !loc_oBusca.this_lAchouRegistro
2850:                     loc_oBusca.mAddColuna("codigos",     "", "C" + CHR(243) + "digo")
2851:                     loc_oBusca.mAddColuna("descricaos",  "", "Descri" + CHR(231) + CHR(227) + "o")
2852:                     loc_oBusca.Show()
2853:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPsg")
2854:                         THIS.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_BuscaPsg.codigos)
2855:                         THIS.txt_4c_DSGru.Value = ALLTRIM(cursor_4c_BuscaPsg.descricaos)

*-- Linhas 2871 a 2889:
2871:         TRY
2872:             loc_cValor  = ALLTRIM(THIS.txt_4c_DSGru.Value)
2873:             loc_cGru    = ALLTRIM(THIS.txt_4c_Cgru.Value)
2874:             loc_cFiltro = IIF(EMPTY(loc_cGru), "", "cgrus = " + EscaparSQL(loc_cGru))
2875:             loc_oBusca  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2876:                 "SigCdPsg", "cursor_4c_BuscaPsg", "descricaos", loc_cValor, ;
2877:                 "Subgrupo", .F., .T., loc_cFiltro)
2878:             IF VARTYPE(loc_oBusca) = "O"
2879:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2880:                     THIS.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_BuscaPsg.codigos)
2881:                     THIS.txt_4c_DSGru.Value = ALLTRIM(cursor_4c_BuscaPsg.descricaos)
2882:                 ELSE
2883:                     IF !loc_oBusca.this_lAchouRegistro
2884:                     loc_oBusca.mAddColuna("descricaos",  "", "Descri" + CHR(231) + CHR(227) + "o")
2885:                     loc_oBusca.mAddColuna("codigos",     "", "C" + CHR(243) + "digo")
2886:                     loc_oBusca.Show()
2887:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPsg")
2888:                         THIS.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_BuscaPsg.codigos)
2889:                         THIS.txt_4c_DSGru.Value = ALLTRIM(cursor_4c_BuscaPsg.descricaos)


### BO (C:\4c\projeto\app\classes\SigPrRetBO.prg):
*==============================================================================
* SigPrRetBO.PRG
* Business Object - Operacional: Retorno de Estoque (Etiquetas)
*
* Herda de BusinessBase
* Form de filtros que abre SigOpIpE com variaveis PRIVATE.
* Sem CRUD - armazena parametros de filtro para consulta/digitacao/arquivadas.
*==============================================================================

DEFINE CLASS SigPrRetBO AS BusinessBase

    *-- Sem tabela primaria (form operacional de filtros)
    this_cTabela      = ""
    this_cCampoChave  = ""

    *-- Empresa
    this_cCdEmpresa   = ""
    this_cDsEmpresa   = ""

    *-- Periodo
    this_dDtInicial   = {}
    this_dDtFinal     = {}

    *-- Operacao / Industria / Numero NF
    this_cNmOperacao  = ""
    this_cNmIndustria = ""
    this_nNumero      = 0
    this_nNumerof     = 0

    *-- Produto (SigCdPro: CPros / DPros)
    this_cCodProduto  = ""
    this_cDsProduto   = ""

    *-- Etiqueta (SigOpEtq: CBars n(14))
    this_nEtiqIni     = 0
    this_nEtiqFim     = 0
    this_nQtdEti      = 0

    *-- Grupo Estoque / Estoque
    this_cCdGrEstoque = ""
    this_cDsGrEstoque = ""
    this_cCdEstoque   = ""
    this_cDsEstoque   = ""

    *-- Grande Grupo (SigCdGpr: Codigos char(3))
    this_cGdeGrupo    = ""

    *-- Grupo Produto (SigCdGrp: CGrus char(3) / DGrus char(20))
    this_cCgru        = ""
    this_cDgru        = ""

    *-- Sub-Grupo (SigCdPsg: Codigos char(6) / Descricaos char(20))
    this_cCSGru       = ""
    this_cDSGru       = ""

    *-- Grupo Venda / Colecao (SigCdCol: Colecoes / Descs)
    this_cCol         = ""
    this_cDCol        = ""

    *-- Linha (SigCdLin: linhas char(10))
    this_cLin         = ""

    *-- Local do Produto (SigPrLcl: Codigos char(10))
    this_cLocal       = ""

    *-- Local da Etiqueta (SigPrLcl: Codigos char(10))
    this_cLocalizas   = ""

    *-- Promocao (SigPrPmc: promos char(25))
    this_cPromos      = ""

    *-- Opcoes de impressao / ordenacao
    this_nOrdem       = 1
    this_nOptMarcas   = 1
    this_nChkPreco    = 2

    *-- Controle interno
    this_cTipo        = ""
    this_cOpEscolha   = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Form operacional sem tabela primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega this_* a partir de cursor com parametros
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCdEmpresa   = TratarNulo(CdEmpresa,   "C")
                THIS.this_cDsEmpresa   = TratarNulo(DsEmpresa,   "C")
                THIS.this_dDtInicial   = TratarNulo(DtInicial,   "D")
                THIS.this_dDtFinal     = TratarNulo(DtFinal,     "D")
                THIS.this_cNmOperacao  = TratarNulo(NmOperacao,  "C")
                THIS.this_cNmIndustria = TratarNulo(NmIndustria, "C")
                THIS.this_nNumero      = TratarNulo(Numero,      "N")
                THIS.this_nNumerof     = TratarNulo(Numerof,     "N")
                THIS.this_cCodProduto  = TratarNulo(CPros,       "C")
                THIS.this_cDsProduto   = TratarNulo(DPros,       "C")
                THIS.this_nEtiqIni     = TratarNulo(EtiqIni,     "N")
                THIS.this_nEtiqFim     = TratarNulo(EtiqFim,     "N")
                THIS.this_nQtdEti      = TratarNulo(QtdEti,      "N")
                THIS.this_cCdGrEstoque = TratarNulo(CdGrEstoque, "C")
                THIS.this_cDsGrEstoque = TratarNulo(DsGrEstoque, "C")
                THIS.this_cCdEstoque   = TratarNulo(CdEstoque,   "C")
                THIS.this_cDsEstoque   = TratarNulo(DsEstoque,   "C")
                THIS.this_cGdeGrupo    = TratarNulo(GdeGrupo,    "C")
                THIS.this_cCgru        = TratarNulo(CGrus,       "C")
                THIS.this_cDgru        = TratarNulo(DGrus,       "C")
                THIS.this_cCSGru       = TratarNulo(CSGru,       "C")
                THIS.this_cDSGru       = TratarNulo(DSGru,       "C")
                THIS.this_cCol         = TratarNulo(Colecoes,    "C")
                THIS.this_cDCol        = TratarNulo(Descs,       "C")
                THIS.this_cLin         = TratarNulo(Linhas,      "C")
                THIS.this_cLocal       = TratarNulo(CdLocal,     "C")
                THIS.this_cLocalizas   = TratarNulo(Localizas,   "C")
                THIS.this_cPromos      = TratarNulo(Promos,      "C")
                THIS.this_nOrdem       = TratarNulo(Ordem,       "N")
                THIS.this_nOptMarcas   = TratarNulo(OptMarcas,   "N")
                THIS.this_nChkPreco    = TratarNulo(ChkPreco,    "N")
                THIS.this_cTipo        = TratarNulo(Tipo,        "C")
                THIS.this_cOpEscolha   = TratarNulo(OpEscolha,   "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursores - Carrega SigCdOpd para lookup de operacoes por SEEK
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursores()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF USED("SigCdOpd")
                USE IN SigCdOpd
            ENDIF
            loc_cSQL = "SELECT a.* FROM SigCdOpd a"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "SigCdOpd") > 0
                SELECT SigCdOpd
                INDEX ON dopps TAG dopps
                SET ORDER TO
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inicializar cursores")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEtiqueta - Resolve CBars via SigOpEtq + SigOpEta (renomeadas)
    * Retorna 0 se invalido, ou o CBars resolvido se encontrado
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEtiqueta(par_nCBars)
        LOCAL loc_nResultado, loc_cSQL, loc_oErro, loc_lcCBars
        loc_nResultado = 0
        TRY
            loc_lcCBars = ALLTRIM(STR(par_nCBars, 14))
            loc_cSQL = "SELECT a.CPros, a.CBars " + ;
                       "FROM SigOpEtq a " + ;
                       "LEFT JOIN SigOpEta b ON a.cpros = b.cpros AND a.cbars = b.cbars_new " + ;
                       "WHERE (a.CBars = " + loc_lcCBars + ;
                       " OR b.cbars_old = " + loc_lcCBars + ")"
            IF USED("cursor_4c_EtiqTemp")
                USE IN cursor_4c_EtiqTemp
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EtiqTemp") > 0
                SELECT cursor_4c_EtiqTemp
                GO TOP
                IF !EOF("cursor_4c_EtiqTemp")
                    loc_nResultado = cursor_4c_EtiqTemp.CBars
                ENDIF
                USE IN cursor_4c_EtiqTemp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar etiqueta")
        ENDTRY
        RETURN loc_nResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarEtiquetaCadastrada - Confirma existencia de CBars em SigOpEtq
    *--------------------------------------------------------------------------
    PROCEDURE VerificarEtiquetaCadastrada(par_nCBars)
        LOCAL loc_lExiste, loc_cSQL, loc_oErro
        loc_lExiste = .F.
        TRY
            loc_cSQL = "SELECT TOP 1 CBars FROM SigOpEtq " + ;
                       "WHERE CBars = " + ALLTRIM(STR(par_nCBars, 14))
            IF USED("cursor_4c_EtiqCheck")
                USE IN cursor_4c_EtiqCheck
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EtiqCheck") > 0
                SELECT cursor_4c_EtiqCheck
                loc_lExiste = !EOF("cursor_4c_EtiqCheck")
                USE IN cursor_4c_EtiqCheck
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao verificar etiqueta")
        ENDTRY
        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Form OPERACIONAL de filtros sem persistencia em tabela propria.
    * Valida parametros minimos e registra auditoria da operacao (Consulta/Impressao).
    * Nao ha INSERT em base porque o legado usa SigOpIpE via variaveis PRIVATE
    * e a acao efetiva do form eh disparar consulta/impressao para SigCdPro/SigOpEtq.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF
            THIS.RegistrarAuditoria("CONSULTA_ETIQUETA")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao processar filtros de estoque")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Form OPERACIONAL: re-executa consulta com filtros atualizados.
    * Nao ha UPDATE em base porque nao existe tabela primaria (form de filtros).
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF
            THIS.RegistrarAuditoria("REEXECUCAO_FILTRO")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar filtros de estoque")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Verifica coerencia minima dos filtros do form operacional.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.
        IF !EMPTY(THIS.this_dDtInicial) AND !EMPTY(THIS.this_dDtFinal)
            IF THIS.this_dDtFinal < THIS.this_dDtInicial
                MsgAviso("Data Final deve ser maior ou igual a Data Inicial.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lValido = .F.
            ENDIF
        ENDIF
        IF loc_lValido AND THIS.this_nEtiqIni > 0 AND THIS.this_nEtiqFim > 0
            IF THIS.this_nEtiqFim < THIS.this_nEtiqIni
                MsgAviso("Etiqueta Final deve ser maior ou igual a Etiqueta Inicial.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lValido = .F.
            ENDIF
        ENDIF
        IF loc_lValido AND !EMPTY(THIS.this_nNumero) AND !EMPTY(THIS.this_nNumerof)
            IF THIS.this_nNumerof < THIS.this_nNumero
                MsgAviso("N" + CHR(250) + "mero Final deve ser maior ou igual ao N" + CHR(250) + "mero Inicial.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lValido = .F.
            ENDIF
        ENDIF
        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Grava operacao do form em LogAuditoria (SQL Server).
    * Como nao ha chave primaria, usa hash textual dos filtros como identificador.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cDetalhe, loc_oErro
        TRY
            loc_cDetalhe = "Emp=" + ALLTRIM(THIS.this_cCdEmpresa) + ;
                           " Prod=" + ALLTRIM(THIS.this_cCodProduto) + ;
                           " Grp=" + ALLTRIM(THIS.this_cCgru) + ;
                           " Est=" + ALLTRIM(THIS.this_cCdEstoque) + ;
                           " DtI=" + DTOC(THIS.this_dDtInicial) + ;
                           " DtF=" + DTOC(THIS.this_dDtFinal) + ;
                           " EtqI=" + ALLTRIM(STR(THIS.this_nEtiqIni, 14)) + ;
                           " EtqF=" + ALLTRIM(STR(THIS.this_nEtiqFim, 14))
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Usuario, DataHora, Tabela, ChavePrimaria, Operacao, Detalhes) " + ;
                       "VALUES (" + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL("SigPrRet") + ", " + ;
                       EscaparSQL("") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(LEFT(loc_cDetalhe, 500)) + ")"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao registrar auditoria")
        ENDTRY
    ENDPROC

ENDDEFINE

