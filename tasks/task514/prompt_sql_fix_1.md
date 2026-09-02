CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1517: Tabela 'sys' NAO EXISTE no banco. Verificar nome correto no schema.sql ou codigo original.
- [SQL-SCHEMA] Linha ~3826: INSERT coluna 'dtcriacao' NAO EXISTE na tabela 'sigcdrlc'
- [SQL-SCHEMA] Linha ~3826: INSERT coluna 'dtalteracao' NAO EXISTE na tabela 'sigcdrlc'
- [SQL-SCHEMA] Linha ~3863: UPDATE coluna 'dtalteracao' NAO EXISTE na tabela 'sigcdrlc'
- [SQL-TIPO] Linha ~3929: Cursor 'cursor_4c_Dados' campo 'ativo' tipo VFP='I' incompativel com SQL 'numeric' (esperado: N/B/Y)


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigcdrlc
CREATE TABLE [dbo].[sigcdrlc](
	[ativo] [numeric](1, 0) NOT NULL,
	[descr] [text] NULL,
	[dtcad] [datetime] NULL,
	[dtmodif] [datetime] NULL,
	[nmreport] [text] NULL,
	[rpt_id] [char](15) NOT NULL,
	[sqlquery] [text] NULL,
	[nomedata] [char](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[rpt_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sigcdrld]    Script Date: 08/12/2025 10:07:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



## Trechos relevantes do Form (C:\4c\projeto\app\forms\cadastros\FormRPT.prg):

--- Linhas 1498 a 1538 ---
1498: 
1499:         TRY
1500:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Dados", 5) AND ;
1501:                PEMSTATUS(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1, "obj_4c_OleRTF_SqlCMD", 5)
1502: 
1503:                 loc_oSubPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1504:                 loc_cTabela = ALLTRIM(loc_oSubPg1.obj_4c_OleRTF_SqlCMD.OBJECT.SelText)
1505: 
1506:                 IF EMPTY(loc_cTabela)
1507:                     loc_oSubPg1.obj_4c_OleRTF_SqlCMD.SetFocus()
1508:                     MsgAviso("Selecione o nome da tabela no editor SQL.")
1509:                 ELSE
1510:                     IF GETWORDCOUNT(loc_cTabela) > 1
1511:                     loc_oSubPg1.obj_4c_OleRTF_SqlCMD.SetFocus()
1512:                     MsgAviso("Selecione apenas o nome da tabela (sem espa" + CHR(231) + "os).")
1513:                 ELSE
1514:                     IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
1515:                     MsgAviso("Sem conex" + CHR(227) + "o com o banco de dados.")
1516:                 ELSE
1517:                     loc_cSQL = "SELECT c.Column_ID, c.Name AS Column_Name, t.Name AS Type, " + ;
1518:                         "c.Max_Length, " + ;
1519:                         "CASE WHEN c.Precision>0 THEN CAST(c.Precision AS CHAR(3)) ELSE '' END AS Precision, " + ;
1520:                         "CASE WHEN c.Scale>0 THEN CAST(c.Scale AS CHAR(3)) ELSE '' END AS Scale, " + ;
1521:                         "CASE WHEN c.Is_Nullable=1 THEN 'yes' ELSE 'no' END AS Is_Nullable " + ;
1522:                         "FROM sys.all_Columns c " + ;
1523:                         "JOIN sys.types t ON t.System_Type_ID = c.System_Type_ID " + ;
1524:                         "WHERE object_id = object_id(" + EscaparSQL(loc_cTabela) + ") " + ;
1525:                         "ORDER BY c.Column_ID"
1526: 
1527:                     loc_oGrid = loc_oSubPg1.grd_4c_Resultado
1528:                     loc_oGrid.RecordSource = ""
1529:                     IF USED("cursor_4c_ResultadoTemp")
1530:                         USE IN cursor_4c_ResultadoTemp
1531:                     ENDIF
1532:                     IF USED("cursor_4c_Resultado")
1533:                         USE IN cursor_4c_Resultado
1534:                     ENDIF
1535: 
1536:                     loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResultadoTemp")
1537: 
1538:                     IF loc_nRes >= 0 AND USED("cursor_4c_ResultadoTemp")



## Trechos relevantes do BO (C:\4c\projeto\app\classes\RPTBO.prg):

--- BO Linhas 7 a 17 ---
7: 
8:     *-- Cabecalho do Relatorio (SIGCDRLC)
9:     this_cRPT_ID         = ""   && RPT_ID - Chave primaria (DTOS+STRTRAN(TIME))
10:     this_cNmReport       = ""   && NmReport - Nome do arquivo do report
11:     this_cDescr          = ""   && Descr - Descricao do report
12:     this_dDtCriacao      = {}   && DtCriacao - Data de criacao
13:     this_dDtAlteracao    = {}   && DtAlteracao - Data de alteracao
14:     this_lAtivo          = .T.  && Ativo - Indicador ativo (default ligado)
15:     this_cSqlQuery       = ""   && SqlQuery - Query SQL do report
16: 
17:     *-- Parametros de Layout do Relatorio (Page2 do formulario)

--- BO Linhas 8 a 18 ---
8:     *-- Cabecalho do Relatorio (SIGCDRLC)
9:     this_cRPT_ID         = ""   && RPT_ID - Chave primaria (DTOS+STRTRAN(TIME))
10:     this_cNmReport       = ""   && NmReport - Nome do arquivo do report
11:     this_cDescr          = ""   && Descr - Descricao do report
12:     this_dDtCriacao      = {}   && DtCriacao - Data de criacao
13:     this_dDtAlteracao    = {}   && DtAlteracao - Data de alteracao
14:     this_lAtivo          = .T.  && Ativo - Indicador ativo (default ligado)
15:     this_cSqlQuery       = ""   && SqlQuery - Query SQL do report
16: 
17:     *-- Parametros de Layout do Relatorio (Page2 do formulario)
18:     this_nOrientacao     = 1    && 1=Retrato, 2=Paisagem

--- BO Linhas 78 a 88 ---
78:                 THIS.this_cRPT_ID      = TratarNulo(RPT_ID,      "C")
79:                 THIS.this_cNmReport    = TratarNulo(NmReport,     "C")
80:                 THIS.this_cDescr       = TratarNulo(Descr,        "C")
81:                 THIS.this_lAtivo       = (TratarNulo(Ativo, "N") = 1)
82:                 THIS.this_cSqlQuery    = TratarNulo(SqlQuery,     "C")
83:                 IF PEMSTATUS(ALIAS(), "DtCriacao",   5)
84:                     THIS.this_dDtCriacao   = TratarNulo(DtCriacao,   "D")
85:                 ENDIF
86:                 IF PEMSTATUS(ALIAS(), "DtAlteracao", 5)
87:                     THIS.this_dDtAlteracao = TratarNulo(DtAlteracao, "D")
88:                 ENDIF

--- BO Linhas 79 a 89 ---
79:                 THIS.this_cNmReport    = TratarNulo(NmReport,     "C")
80:                 THIS.this_cDescr       = TratarNulo(Descr,        "C")
81:                 THIS.this_lAtivo       = (TratarNulo(Ativo, "N") = 1)
82:                 THIS.this_cSqlQuery    = TratarNulo(SqlQuery,     "C")
83:                 IF PEMSTATUS(ALIAS(), "DtCriacao",   5)
84:                     THIS.this_dDtCriacao   = TratarNulo(DtCriacao,   "D")
85:                 ENDIF
86:                 IF PEMSTATUS(ALIAS(), "DtAlteracao", 5)
87:                     THIS.this_dDtAlteracao = TratarNulo(DtAlteracao, "D")
88:                 ENDIF
89:                 loc_lSucesso = .T.

--- BO Linhas 81 a 91 ---
81:                 THIS.this_lAtivo       = (TratarNulo(Ativo, "N") = 1)
82:                 THIS.this_cSqlQuery    = TratarNulo(SqlQuery,     "C")
83:                 IF PEMSTATUS(ALIAS(), "DtCriacao",   5)
84:                     THIS.this_dDtCriacao   = TratarNulo(DtCriacao,   "D")
85:                 ENDIF
86:                 IF PEMSTATUS(ALIAS(), "DtAlteracao", 5)
87:                     THIS.this_dDtAlteracao = TratarNulo(DtAlteracao, "D")
88:                 ENDIF
89:                 loc_lSucesso = .T.
90:             ENDIF
91:         CATCH TO loc_oErro

--- BO Linhas 82 a 92 ---
82:                 THIS.this_cSqlQuery    = TratarNulo(SqlQuery,     "C")
83:                 IF PEMSTATUS(ALIAS(), "DtCriacao",   5)
84:                     THIS.this_dDtCriacao   = TratarNulo(DtCriacao,   "D")
85:                 ENDIF
86:                 IF PEMSTATUS(ALIAS(), "DtAlteracao", 5)
87:                     THIS.this_dDtAlteracao = TratarNulo(DtAlteracao, "D")
88:                 ENDIF
89:                 loc_lSucesso = .T.
90:             ENDIF
91:         CATCH TO loc_oErro
92:             MsgErro("Erro ao carregar do cursor:" + CHR(13) + loc_oErro.Message, "RPTBO.CarregarDoCursor")

--- BO Linhas 124 a 134 ---
124:     ENDFUNC
125: 
126:     *==========================================================================
127:     * Inserir - Insere novo registro na tabela SIGCDRLC
128:     * RPT_ID gerado como YYYYMMDD_HHMMSS
129:     * DtCriacao e DtAlteracao preenchidos com data atual
130:     *==========================================================================
131:     PROTECTED PROCEDURE Inserir()
132:         LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cAtivo, loc_cDataHoje
133:         loc_lSucesso = .F.
134: 

--- BO Linhas 136 a 146 ---
136:             THIS.this_cRPT_ID = THIS.GerarRPT_ID()
137:             loc_cAtivo        = IIF(THIS.this_lAtivo, "1", "0")
138:             loc_cDataHoje     = FormatarDataSQL(DATE())
139: 
140:             loc_cSQL = "INSERT INTO SIGCDRLC" + ;
141:                 " (RPT_ID, NmReport, Ativo, Descr, DtCriacao, DtAlteracao, SqlQuery)" + ;
142:                 " VALUES (" + ;
143:                 EscaparSQL(THIS.this_cRPT_ID)            + ", " + ;
144:                 EscaparSQL(UPPER(ALLTRIM(THIS.this_cNmReport))) + ", " + ;
145:                 loc_cAtivo                               + ", " + ;
146:                 EscaparSQL(ALLTRIM(THIS.this_cDescr))    + ", " + ;

--- BO Linhas 163 a 173 ---
163:         RETURN loc_lSucesso
164:     ENDPROC
165: 
166:     *==========================================================================
167:     * Atualizar - Atualiza registro existente na tabela SIGCDRLC
168:     * DtAlteracao atualizado com data atual
169:     *==========================================================================
170:     PROTECTED PROCEDURE Atualizar()
171:         LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cAtivo
172:         loc_lSucesso = .F.
173: 

--- BO Linhas 176 a 186 ---
176: 
177:             loc_cSQL = "UPDATE SIGCDRLC SET" + ;
178:                 " NmReport     = " + EscaparSQL(UPPER(ALLTRIM(THIS.this_cNmReport))) + "," + ;
179:                 " Ativo        = " + loc_cAtivo + "," + ;
180:                 " Descr        = " + EscaparSQL(ALLTRIM(THIS.this_cDescr)) + "," + ;
181:                 " DtAlteracao  = " + FormatarDataSQL(DATE()) + "," + ;
182:                 " SqlQuery     = " + EscaparSQL(ALLTRIM(THIS.this_cSqlQuery)) + ;
183:                 " WHERE RPT_ID = " + EscaparSQL(THIS.this_cRPT_ID)
184: 
185:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
186:             IF loc_nResultado >= 0

--- BO Linhas 228 a 238 ---
228:         RETURN loc_lSucesso
229:     ENDPROC
230: 
231:     *==========================================================================
232:     * Buscar - Busca lista de reports (exibe no grid da Page1)
233:     * Cursor: cursor_4c_Dados com RPT_ID, NmReport, Descr, Ativo, DtCriacao, DtAlteracao
234:     *==========================================================================
235:     PROCEDURE Buscar(par_cFiltro)
236:         LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
237:         loc_lSucesso = .F.
238: 

--- BO Linhas 243 a 253 ---
243:                     CREATE CURSOR cursor_4c_Dados ( ;
244:                         RPT_ID       C(20), ;
245:                         NmReport     C(100), ;
246:                         Descr        C(200), ;
247:                         Ativo        I,      ;
248:                         DtCriacao    D,      ;
249:                         DtAlteracao  D       ;
250:                     )
251:                     SET NULL OFF
252:                 ENDIF
253:                 loc_lSucesso = .T.

--- BO Linhas 244 a 254 ---
244:                         RPT_ID       C(20), ;
245:                         NmReport     C(100), ;
246:                         Descr        C(200), ;
247:                         Ativo        I,      ;
248:                         DtCriacao    D,      ;
249:                         DtAlteracao  D       ;
250:                     )
251:                     SET NULL OFF
252:                 ENDIF
253:                 loc_lSucesso = .T.
254:             ELSE

--- BO Linhas 250 a 260 ---
250:                     )
251:                     SET NULL OFF
252:                 ENDIF
253:                 loc_lSucesso = .T.
254:             ELSE
255:                 loc_cSQL = "SELECT RPT_ID, NmReport, Descr, Ativo, DtCriacao, DtAlteracao" + ;
256:                     " FROM SIGCDRLC"
257: 
258:                 IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
259:                     loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
260:                 ENDIF

--- BO Linhas 286 a 296 ---
286:     PROCEDURE CarregarPorCodigo(par_cRPT_ID)
287:         LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
288:         loc_lSucesso = .F.
289: 
290:         TRY
291:             loc_cSQL = "SELECT RPT_ID, NmReport, Descr, Ativo, DtCriacao, DtAlteracao, SqlQuery" + ;
292:                 " FROM SIGCDRLC WHERE RPT_ID = " + EscaparSQL(par_cRPT_ID)
293: 
294:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
295: 
296:             IF loc_nResultado >= 0 AND USED("cursor_4c_Carrega")


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\cadastros\FormRPT.prg
- BO: C:\4c\projeto\app\classes\RPTBO.prg
