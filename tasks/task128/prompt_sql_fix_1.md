CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1205: Coluna 'cidchaves' NAO EXISTE na tabela 'sigcdcli' (referenciada como b.cIdChaves)
- [SQL-SCHEMA] Linha ~1220: Coluna 'cidchaves' NAO EXISTE na tabela 'sigcdcli' (referenciada como c.cIdChaves)
- [SQL-SCHEMA] Linha ~1874: Coluna 'usuacess' NAO EXISTE na tabela 'sigcdacg' (referenciada como a.UsuAcess)
- [SQL-SCHEMA] Linha ~1874: Coluna 'cimps' NAO EXISTE na tabela 'sigcdacg' (referenciada como a.CImps)
- [SQL-SCHEMA] Linha ~2621: Coluna 'cidchaves' NAO EXISTE na tabela 'sigcdcli' (referenciada como b.cIdChaves)
- [SQL-SCHEMA] Linha ~2634: Coluna 'cidchaves' NAO EXISTE na tabela 'sigcdcli' (referenciada como c.cIdChaves)


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigcdacg
CREATE TABLE [dbo].[sigcdacg](
	[grupos] [char](10) NOT NULL,
	[usuarios] [char](10) NOT NULL,
	[pkchaves] [char](20) NOT NULL,
 

-- Tabela: sigcdcli
CREATE TABLE [dbo].[SIGCDCLI](
	[idcontas] [numeric](6, 0) NOT NULL,
	[bairs] [char](40) NOT NULL,
	[ccargs] [char](10) NOT NULL,
	[cepcobs] [char](9) NOT NULL,
	[ceps] [char](9) NOT NULL,
	[ceptrabs] [char](9) NOT NULL,
	[cfos] [char](10) NOT NULL,
	[cidas] [char](30) NOT NULL,
	[cidcobs] [char](20) NOT NULL,
	[cidtrabs] [char](20) NOT NULL,
	[codtifs] [char](3) NOT NULL,
	[coletors] [numeric](1, 0) NOT NULL,
	[comis] [numeric](5, 2) NOT NULL,
	[compls] [char](50) NOT NULL,
	[concilias] [numeric](1, 0) NOT NULL,
	[conjuges] [char](40) NOT NULL,
	[contacobs] [char](10) NOT NULL,
	[contamats] [char](10) NOT NULL,
	[contavens] [char](10) NOT NULL,
	[cpfs] [char](20) NOT NULL,
	[dataincs] [datetime] NULL,
	[datatrans] [datetime] NULL,
	[ddds] [char](4) NOT NULL,
	[dtalts] [datetime] NULL,
	[dtcasas] [datetime] NULL,
	[dtfilms] [datetime] NULL,
	[dtncons] [datetime] NULL,
	[emails] [char](50) NOT NULL,
	[emps] [char](3) NOT NULL,
	[endcobs] [char](80) NOT NULL,
	[endes] [char](60) NOT NULL,
	[endtrabs] [char](48) NOT NULL,
	[estas] [char](2) NOT NULL,
	[estcivils] [char](20) NOT NULL,
	[estcobs] [char](2) NOT NULL,
	[esttrabs] [char](2) NOT NULL,
	[faxs] [char](20) NOT NULL,
	[figjpgs] [text] NULL,
	[figuras] [image] NULL,
	[fpubls] [char](3) NOT NULL,
	[grupocobs] [char](10) NOT NULL,
	[grupomats] [char](10) NOT NULL,
	[grupos] [char](10) NOT NULL,
	[grupovens] [char](10) NOT NULL,
	[iclis] [char](10) NOT NULL,
	[limcres] [numeric](11, 2) NOT NULL,
	[lprecos] [char](30) NOT NULL,
	[maes] [char](50) NOT NULL,
	[nacionals] [char](15) NOT NULL,
	[nascs] [datetime] NULL,
	[nclis] [numeric](10, 0) NOT NULL,
	[nums] [char](10) NOT NULL,
	[obs] [text] NULL,
	[paicobs] [char](30) NOT NULL,
	[pais] [char](50) NOT NULL,
	[paises] [char](30) NOT NULL,
	[paitrabs] [char](30) NOT NULL,
	[profiss] [char](20) NOT NULL,
	[ramals] [char](4) NOT NULL,
	[razaos] [char](50) NOT NULL,
	[rclis] [char](50) NOT NULL,
	[rgconjuges] [char](13) NOT NULL,
	[rgs] [char](20) NOT NULL,
	[sexos] [char](1) NOT NULL,
	[tabds] [char](10) NOT NULL,
	[tel1s] [char](20) NOT NULL,
	[tel2s] [char](20) NOT NULL,
	[tpcads] [numeric](1, 0) NOT NULL,
	[tpclis] [numeric](1, 0) NOT NULL,
	[transps] [char](10) NOT NULL,
	[ultcomps] [datetime] NULL,
	[vcolets] [numeric](3, 0) NOT NULL,
	[baicobs] [char](20) NOT NULL,
	[gerbals] [numeric](1, 0) NOT NULL,
	[grufals] [char](10) NOT NULL,
	[pagfals] [numeric](1, 0) NOT NULL,
	[recfals] [numeric](1, 0) NOT NULL,
	[senhas] [char](10) NOT NULL,
	[suframas] [char](15) NOT NULL,
	[ccontabs] [char](10) NOT NULL,
	[codigos] [char](10) NOT NULL,
	[conprods] [char](10) NOT NULL,
	[contacents] [char](10) NOT NULL,
	[contato] [char](40) NOT NULL,
	[contats] [char](20) NOT NULL,
	[dtfats] [datetime] NULL,
	[dtmacums] [datetime] NULL,
	[grupocents] [char](10) NOT NULL,
	[gruprods] [char](10) NOT NULL,
	[hists] [char](30) NOT NULL,
	[intconts] [numeric](1, 0) NOT NULL,
	[ma
-- (truncado)


## Trechos relevantes do Form (C:\4c\projeto\app\forms\relatorios\Formsigreipe.prg):

--- Linhas 1186 a 1226 ---
1186:     *--------------------------------------------------------------------------
1187:     PROCEDURE ValidarDtFinal()
1188:         LOCAL loc_oPg1, loc_cDopes, loc_dDataIni, loc_dDataFin
1189:         LOCAL loc_nConta, loc_cSQL, loc_nResult, loc_oGrid
1190:         loc_oPg1     = THIS.pgf_4c_Paginas.Page1
1191:         loc_cDopes   = ALLTRIM(loc_oPg1.txt_4c__nm_operacao.Value)
1192:         loc_dDataIni = loc_oPg1.txt_4c__dt_inicial.Value
1193:         loc_dDataFin = loc_oPg1.txt_4c__dt_final.Value
1194:         loc_nConta   = loc_oPg1.obj_4c_Opt_conta.Value
1195:         loc_oGrid    = loc_oPg1.grd_4c_GrdOper
1196: 
1197:         IF EMPTY(loc_dDataFin)
1198:             RETURN
1199:         ENDIF
1200: 
1201:         loc_oGrid.RecordSource = ""
1202: 
1203:         TRY
1204:             IF loc_nConta = 1
1205:                 loc_cSQL = "SELECT 0 AS Marcas, a.Emps, a.Dopes, a.Numes, " + ;
1206:                            "b.RClis AS DescOrigs, c.RClis AS DescDests, " + ;
1207:                            "a.ContaEs, a.LocalEnts, " + ;
1208:                            "b.IClis, b.RClis, b.Endes, b.Nums, b.Compls, " + ;
1209:                            "b.Bairs, b.Cidas, b.Ceps, b.Estas, b.Tel1s, " + ;
1210:                            "b.Tel2s, b.Faxs, b.Nascs, b.cIdChaves, " + ;
1211:                            "b.Codigos, b.Paises, b.Contato " + ;
1212:                            "FROM SigMvCab a " + ;
1213:                            "INNER JOIN SigCdCli b ON a.ContaOs = b.Iclis " + ;
1214:                            "INNER JOIN SigCdCli c ON a.ContaDs = c.Iclis " + ;
1215:                            "WHERE RTRIM(a.Dopes) = " + EscaparSQL(loc_cDopes) + ;
1216:                            " AND a.Datas BETWEEN " + FormatarDataSQL(loc_dDataIni) + ;
1217:                            " AND " + FormatarDataSQL(loc_dDataFin) + ;
1218:                            " ORDER BY a.Numes"
1219:             ELSE
1220:                 loc_cSQL = "SELECT 0 AS Marcas, a.Emps, a.Dopes, a.Numes, " + ;
1221:                            "b.RClis AS DescOrigs, c.RClis AS DescDests, " + ;
1222:                            "a.ContaEs, a.LocalEnts, " + ;
1223:                            "c.IClis, c.RClis, c.Endes, c.Nums, c.Compls, " + ;
1224:                            "c.Bairs, c.Cidas, c.Ceps, c.Estas, c.Tel1s, " + ;
1225:                            "c.Tel2s, c.Faxs, c.Nascs, c.cIdChaves, " + ;
1226:                            "c.Codigos, c.Paises, c.Contato " + ;

--- Linhas 1201 a 1241 ---
1201:         loc_oGrid.RecordSource = ""
1202: 
1203:         TRY
1204:             IF loc_nConta = 1
1205:                 loc_cSQL = "SELECT 0 AS Marcas, a.Emps, a.Dopes, a.Numes, " + ;
1206:                            "b.RClis AS DescOrigs, c.RClis AS DescDests, " + ;
1207:                            "a.ContaEs, a.LocalEnts, " + ;
1208:                            "b.IClis, b.RClis, b.Endes, b.Nums, b.Compls, " + ;
1209:                            "b.Bairs, b.Cidas, b.Ceps, b.Estas, b.Tel1s, " + ;
1210:                            "b.Tel2s, b.Faxs, b.Nascs, b.cIdChaves, " + ;
1211:                            "b.Codigos, b.Paises, b.Contato " + ;
1212:                            "FROM SigMvCab a " + ;
1213:                            "INNER JOIN SigCdCli b ON a.ContaOs = b.Iclis " + ;
1214:                            "INNER JOIN SigCdCli c ON a.ContaDs = c.Iclis " + ;
1215:                            "WHERE RTRIM(a.Dopes) = " + EscaparSQL(loc_cDopes) + ;
1216:                            " AND a.Datas BETWEEN " + FormatarDataSQL(loc_dDataIni) + ;
1217:                            " AND " + FormatarDataSQL(loc_dDataFin) + ;
1218:                            " ORDER BY a.Numes"
1219:             ELSE
1220:                 loc_cSQL = "SELECT 0 AS Marcas, a.Emps, a.Dopes, a.Numes, " + ;
1221:                            "b.RClis AS DescOrigs, c.RClis AS DescDests, " + ;
1222:                            "a.ContaEs, a.LocalEnts, " + ;
1223:                            "c.IClis, c.RClis, c.Endes, c.Nums, c.Compls, " + ;
1224:                            "c.Bairs, c.Cidas, c.Ceps, c.Estas, c.Tel1s, " + ;
1225:                            "c.Tel2s, c.Faxs, c.Nascs, c.cIdChaves, " + ;
1226:                            "c.Codigos, c.Paises, c.Contato " + ;
1227:                            "FROM SigMvCab a " + ;
1228:                            "INNER JOIN SigCdCli b ON a.ContaOs = b.Iclis " + ;
1229:                            "INNER JOIN SigCdCli c ON a.ContaDs = c.Iclis " + ;
1230:                            "WHERE RTRIM(a.Dopes) = " + EscaparSQL(loc_cDopes) + ;
1231:                            " AND a.Datas BETWEEN " + FormatarDataSQL(loc_dDataIni) + ;
1232:                            " AND " + FormatarDataSQL(loc_dDataFin) + ;
1233:                            " ORDER BY a.Numes"
1234:             ENDIF
1235: 
1236:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpQuery")
1237: 
1238:             IF loc_nResult > 0
1239:                 IF USED("cursor_4c_Operacoes")
1240:                     USE IN cursor_4c_Operacoes
1241:                 ENDIF

--- Linhas 1855 a 1895 ---
1855:                 SELECT cursor_4c_SigCdPac
1856:                 GO TOP
1857:                 THIS.this_nAjDenss = IIF(cursor_4c_SigCdPac.AjDens < 10, 10, cursor_4c_SigCdPac.AjDens)
1858:                 THIS.this_nAjVelos = IIF(cursor_4c_SigCdPac.AjVelos < 1, 1, cursor_4c_SigCdPac.AjVelos)
1859:             ENDIF
1860:             IF USED("cursor_4c_SigCdPac")
1861:                 USE IN cursor_4c_SigCdPac
1862:             ENDIF
1863: 
1864:             *-- Lista de impressoras Windows (APRINTERS retorna array 2D: nome, porta)
1865:             loc_nPrinters = APRINTERS(loc_laPrinters)
1866:             IF loc_nPrinters > 0
1867:                 FOR loc_nI = 1 TO loc_nPrinters
1868:                     loc_laPrinters(loc_nI, 1) = UPPER(loc_laPrinters(loc_nI, 1))
1869:                 ENDFOR
1870:                 =ASORT(loc_laPrinters)
1871:             ENDIF
1872: 
1873:             *-- Impressoras termicas autorizadas para o usuario (SigSyImp+SigCdmp)
1874:             loc_cSQL = "SELECT b.Impres" + ;
1875:                        " FROM SigSyImp a, SigCdmp b" + ;
1876:                        " WHERE a.UsuAcess = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
1877:                        " AND a.CImps = b.Impres AND b.nTpImpres = 2" + ;
1878:                        " UNION ALL" + ;
1879:                        " SELECT c.Impres" + ;
1880:                        " FROM SigCdAcG a, SigSyImp b, SigCdmp c" + ;
1881:                        " WHERE a.Usuarios = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
1882:                        " AND a.Grupos = b.GrAcess" + ;
1883:                        " AND b.CImps = c.Impres AND c.nTpImpres = 2"
1884: 
1885:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCImp")
1886:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_TmpCImp") > 0
1887:                 SELECT DISTINCT Impres FROM cursor_4c_TmpCImp ;
1888:                     ORDER BY Impres ;
1889:                     INTO CURSOR cursor_4c_SigCdmp READWRITE
1890:             ELSE
1891:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1892:                     "SELECT DISTINCT Impres FROM SigCdmp WHERE nTpImpres = 2 ORDER BY Impres", ;
1893:                     "cursor_4c_SigCdmp")
1894:             ENDIF
1895:             IF USED("cursor_4c_TmpCImp")



## Trechos relevantes do BO (C:\4c\projeto\app\classes\sigreipeBO.prg):

--- BO Linhas 8 a 18 ---
8: 
9: DEFINE CLASS sigreipeBO AS RelatorioBase
10: 
11:     *-- Propriedades padrao
12:     this_cTabela         = "SigMlCab"
13:     this_cCampoChave     = "cIdChaves"
14:     this_cCursorDados    = "Relacao"
15:     this_cMensagemErro   = ""
16: 
17:     *-- Filtro: selecao por codigo/descricao (tabela SigMlItn)
18:     this_cCodigos        = ""

--- BO Linhas 49 a 59 ---
49:     *--------------------------------------------------------------------------
50:     * Init - Configura propriedades basicas do BO
51:     *--------------------------------------------------------------------------
52:     PROCEDURE Init()
53:         THIS.this_cTabela      = "SigMlCab"
54:         THIS.this_cCampoChave  = "cIdChaves"
55:         THIS.this_cCursorDados = "Relacao"
56:         RETURN DODEFAULT()
57:     ENDPROC
58: 
59:     *--------------------------------------------------------------------------

--- BO Linhas 96 a 106 ---
96:             ENDIF
97: 
98:             loc_cOrder = "a.IClis, a.RClis, a.Endes, a.Nums, a.Compls," + ;
99:                          " a.Bairs, a.Cidas, a.Ceps, a.Estas," + ;
100:                          " a.Tel1s, a.Tel2s, a.Faxs, a.Nascs," + ;
101:                          " a.cIdChaves, a.Codigos, b.Contato"
102: 
103:             loc_cSQL = "SELECT a.IClis, a.RClis, a.Endes, a.Nums, a.Compls," + ;
104:                        " a.Bairs, a.Cidas, a.Ceps, a.Estas," + ;
105:                        " a.Tel1s, a.Tel2s, a.Faxs, a.Nascs," + ;
106:                        " a.cIdChaves, a.Codigos, b.paises, b.Contato" + ;

--- BO Linhas 101 a 111 ---
101:                          " a.cIdChaves, a.Codigos, b.Contato"
102: 
103:             loc_cSQL = "SELECT a.IClis, a.RClis, a.Endes, a.Nums, a.Compls," + ;
104:                        " a.Bairs, a.Cidas, a.Ceps, a.Estas," + ;
105:                        " a.Tel1s, a.Tel2s, a.Faxs, a.Nascs," + ;
106:                        " a.cIdChaves, a.Codigos, b.paises, b.Contato" + ;
107:                        " FROM SigMlCab a, SigCdCli b" + ;
108:                        " WHERE " + loc_cWhere + ;
109:                        " ORDER BY " + loc_cOrder
110: 
111:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)

--- BO Linhas 153 a 163 ---
153:                            " b.Rclis AS DescOrigs, c.Rclis AS DescDests," + ;
154:                            " a.ContaEs, a.LocalEnts," + ;
155:                            " b.IClis, b.RClis, b.Endes, b.Nums, b.Compls," + ;
156:                            " b.Bairs, b.Cidas, b.Ceps, b.Estas," + ;
157:                            " b.Tel1s, b.Tel2s, b.Faxs, b.Nascs," + ;
158:                            " b.cIdChaves, b.Codigos, b.paises, b.Contato" + ;
159:                            " FROM SigMvCab a" + ;
160:                            " INNER JOIN SigCdCli b ON a.ContaOs = b.Iclis" + ;
161:                            " INNER JOIN SigCdCli c ON a.ContaDs = c.Iclis" + ;
162:                            " WHERE " + loc_cWhere
163:             ELSE

--- BO Linhas 166 a 176 ---
166:                            " b.Rclis AS DescOrigs, c.Rclis AS DescDests," + ;
167:                            " a.ContaEs, a.LocalEnts," + ;
168:                            " c.IClis, c.RClis, c.Endes, c.Nums, c.Compls," + ;
169:                            " c.Bairs, c.Cidas, c.Ceps, c.Estas," + ;
170:                            " c.Tel1s, c.Tel2s, c.Faxs, c.Nascs," + ;
171:                            " c.cIdChaves, c.Codigos, c.paises, c.Contato" + ;
172:                            " FROM SigMvCab a" + ;
173:                            " INNER JOIN SigCdCli b ON a.ContaOs = b.Iclis" + ;
174:                            " INNER JOIN SigCdCli c ON a.ContaDs = c.Iclis" + ;
175:                            " WHERE " + loc_cWhere
176:             ENDIF

--- BO Linhas 186 a 196 ---
186:                 USE IN (THIS.this_cCursorDados)
187:             ENDIF
188:             SELECT TmpOper
189:             IF !EOF()
190:                 SELECT IClis, RClis, Endes, Nums, Compls, Bairs, Cidas, Ceps, Estas, ;
191:                        Tel1s, Tel2s, Faxs, Nascs, cIdChaves, Codigos, paises, Contato ;
192:                        FROM TmpOper WHERE Marcas = 1 ;
193:                        INTO CURSOR (THIS.this_cCursorDados) READWRITE
194:             ELSE
195:                 *-- Cursor vazio com estrutura correta
196:                 CREATE CURSOR (THIS.this_cCursorDados) ;

--- BO Linhas 195 a 205 ---
195:                 *-- Cursor vazio com estrutura correta
196:                 CREATE CURSOR (THIS.this_cCursorDados) ;
197:                     (IClis C(15), RClis C(60), Endes C(60), Nums C(10), Compls C(20), ;
198:                      Bairs C(40), Cidas C(40), Ceps C(9), Estas C(2), ;
199:                      Tel1s C(20), Tel2s C(20), Faxs C(20), Nascs D, ;
200:                      cIdChaves C(36), Codigos C(10), paises C(20), Contato C(40))
201:             ENDIF
202: 
203:             loc_lSucesso = .T.
204:         CATCH TO loc_oErro
205:             THIS.this_cMensagemErro = loc_oErro.Message

--- BO Linhas 242 a 252 ---
242:         ENDTRY
243:         RETURN loc_lSucesso
244:     ENDPROC
245: 
246:     *--------------------------------------------------------------------------
247:     * ObterChavePrimaria - Retorna chave primaria (cIdChaves) do cursor atual
248:     *--------------------------------------------------------------------------
249:     PROCEDURE ObterChavePrimaria()
250:         LOCAL loc_cChave
251:         loc_cChave = ""
252:         TRY

--- BO Linhas 250 a 260 ---
250:         LOCAL loc_cChave
251:         loc_cChave = ""
252:         TRY
253:             IF USED(THIS.this_cCursorDados) AND !EOF(THIS.this_cCursorDados)
254:                 SELECT (THIS.this_cCursorDados)
255:                 loc_cChave = ALLTRIM(NVL(cIdChaves, ""))
256:             ENDIF
257:         CATCH TO loc_oErro
258:             loc_cChave = ""
259:         ENDTRY
260:         RETURN loc_cChave


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\relatorios\Formsigreipe.prg
- BO: C:\4c\projeto\app\classes\sigreipeBO.prg
