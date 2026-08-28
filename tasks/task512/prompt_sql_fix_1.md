CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~3126: INSERT coluna 'dtcriacao' NAO EXISTE na tabela 'sigcdrlc'
- [SQL-SCHEMA] Linha ~3126: INSERT coluna 'dtalteracao' NAO EXISTE na tabela 'sigcdrlc'
- [SQL-SCHEMA] Linha ~3168: UPDATE coluna 'dtalteracao' NAO EXISTE na tabela 'sigcdrlc'
- [SQL-SCHEMA] Linha ~3246: UPDATE coluna 'dtalteracao' NAO EXISTE na tabela 'sigcdrlc'
- [SQL-SCHEMA] Linha ~3311: Tabela 'sys' NAO EXISTE no banco. Verificar nome correto no schema.sql ou codigo original.
- [SQL-SCHEMA] Linha ~3345: Tabela 'sys' NAO EXISTE no banco. Verificar nome correto no schema.sql ou codigo original.


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



## Trechos relevantes do BO (C:\4c\projeto\app\classes\RPTBO.prg):

--- BO Linhas 9 a 19 ---
9:     *-- Propriedades: Cabecalho do Relatorio (SIGCDRLC)
10:     this_cRptId        = ""    && RPT_ID - Chave Primaria: DTOS(Date())+"_"+STRTRAN(TIME(),":","")
11:     this_cNmReport     = ""    && NmReport - Nome do arquivo do report
12:     this_cDescr        = ""    && Descr - Descricao do report
13:     this_lAtivo        = .T.   && Ativo - Flag ativo (1=Ativo, 0=Inativo)
14:     this_dDtCriacao    = {}    && DtCriacao - Data de criacao do report
15:     this_dDtAlteracao  = {}    && DtAlteracao - Data da ultima alteracao
16:     this_cSqlQuery     = ""    && SqlQuery - Comando SQL do report (memo)
17: 
18:     *--------------------------------------------------------------------------
19:     * Init - Configura tabela e chave primaria

--- BO Linhas 10 a 20 ---
10:     this_cRptId        = ""    && RPT_ID - Chave Primaria: DTOS(Date())+"_"+STRTRAN(TIME(),":","")
11:     this_cNmReport     = ""    && NmReport - Nome do arquivo do report
12:     this_cDescr        = ""    && Descr - Descricao do report
13:     this_lAtivo        = .T.   && Ativo - Flag ativo (1=Ativo, 0=Inativo)
14:     this_dDtCriacao    = {}    && DtCriacao - Data de criacao do report
15:     this_dDtAlteracao  = {}    && DtAlteracao - Data da ultima alteracao
16:     this_cSqlQuery     = ""    && SqlQuery - Comando SQL do report (memo)
17: 
18:     *--------------------------------------------------------------------------
19:     * Init - Configura tabela e chave primaria
20:     *--------------------------------------------------------------------------

--- BO Linhas 50 a 60 ---
50:         TRY
51:             IF USED("cursor_4c_Dados")
52:                 USE IN cursor_4c_Dados
53:             ENDIF
54: 
55:             loc_cSQL = "SELECT RPT_ID, NmReport, Descr, Ativo, DtCriacao, DtAlteracao" + ;
56:                        " FROM SIGCDRLC"
57: 
58:             IF !EMPTY(loc_cFiltro)
59:                 loc_cSQL = loc_cSQL + " WHERE NmReport LIKE " + EscaparSQL("%" + loc_cFiltro + "%")
60:             ENDIF

--- BO Linhas 96 a 106 ---
96:         TRY
97:             IF USED("cursor_4c_Carrega")
98:                 USE IN cursor_4c_Carrega
99:             ENDIF
100: 
101:             loc_cSQL = "SELECT RPT_ID, NmReport, Descr, Ativo, DtCriacao, DtAlteracao, SqlQuery" + ;
102:                        " FROM SIGCDRLC" + ;
103:                        " WHERE RPT_ID = " + EscaparSQL(ALLTRIM(par_cRptId))
104: 
105:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
106: 

--- BO Linhas 137 a 147 ---
137:         TRY
138:             IF USED("cursor_4c_Carrega")
139:                 USE IN cursor_4c_Carrega
140:             ENDIF
141: 
142:             loc_cSQL = "SELECT RPT_ID, NmReport, Descr, Ativo, DtCriacao, DtAlteracao, SqlQuery" + ;
143:                        " FROM SIGCDRLC" + ;
144:                        " WHERE NmReport = " + EscaparSQL(ALLTRIM(par_cNmReport))
145: 
146:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
147: 

--- BO Linhas 212 a 222 ---
212:             SELECT (par_cAliasCursor)
213:             THIS.this_cRptId       = TratarNulo(RPT_ID,      "C")
214:             THIS.this_cNmReport    = TratarNulo(NmReport,    "C")
215:             THIS.this_cDescr       = TratarNulo(Descr,       "C")
216:             THIS.this_lAtivo       = (NVL(Ativo, 1) = 1)
217:             THIS.this_dDtCriacao   = TratarNulo(DtCriacao,   "D")
218:             THIS.this_dDtAlteracao = TratarNulo(DtAlteracao, "D")
219: 
220:             IF PEMSTATUS(ALIAS() + "", "SqlQuery", 5) OR ;
221:                AFIELDS(laFields, par_cAliasCursor) > 0
222:                 IF ASCAN(laFields, "SQLQUERY") > 0

--- BO Linhas 213 a 223 ---
213:             THIS.this_cRptId       = TratarNulo(RPT_ID,      "C")
214:             THIS.this_cNmReport    = TratarNulo(NmReport,    "C")
215:             THIS.this_cDescr       = TratarNulo(Descr,       "C")
216:             THIS.this_lAtivo       = (NVL(Ativo, 1) = 1)
217:             THIS.this_dDtCriacao   = TratarNulo(DtCriacao,   "D")
218:             THIS.this_dDtAlteracao = TratarNulo(DtAlteracao, "D")
219: 
220:             IF PEMSTATUS(ALIAS() + "", "SqlQuery", 5) OR ;
221:                AFIELDS(laFields, par_cAliasCursor) > 0
222:                 IF ASCAN(laFields, "SQLQUERY") > 0
223:                     THIS.this_cSqlQuery = TratarNulo(SqlQuery, "C")

--- BO Linhas 247 a 257 ---
247:             SELECT (par_cAliasCursor)
248:             THIS.this_cRptId       = TratarNulo(RPT_ID,      "C")
249:             THIS.this_cNmReport    = TratarNulo(NmReport,    "C")
250:             THIS.this_cDescr       = TratarNulo(Descr,       "C")
251:             THIS.this_lAtivo       = (NVL(Ativo, 1) = 1)
252:             THIS.this_dDtCriacao   = TratarNulo(DtCriacao,   "D")
253:             THIS.this_dDtAlteracao = TratarNulo(DtAlteracao, "D")
254:             THIS.this_cSqlQuery    = TratarNulo(SqlQuery,    "C")
255:             THIS.this_lNovoRegistro = .F.
256:             loc_lSucesso = .T.
257:         CATCH TO loc_oErro

--- BO Linhas 248 a 258 ---
248:             THIS.this_cRptId       = TratarNulo(RPT_ID,      "C")
249:             THIS.this_cNmReport    = TratarNulo(NmReport,    "C")
250:             THIS.this_cDescr       = TratarNulo(Descr,       "C")
251:             THIS.this_lAtivo       = (NVL(Ativo, 1) = 1)
252:             THIS.this_dDtCriacao   = TratarNulo(DtCriacao,   "D")
253:             THIS.this_dDtAlteracao = TratarNulo(DtAlteracao, "D")
254:             THIS.this_cSqlQuery    = TratarNulo(SqlQuery,    "C")
255:             THIS.this_lNovoRegistro = .F.
256:             loc_lSucesso = .T.
257:         CATCH TO loc_oErro
258:             MsgErro("Erro em RPTBO.CarregarDoCursorCompleto:" + CHR(13) + loc_oErro.Message, "Erro")

--- BO Linhas 291 a 301 ---
291:             THIS.this_cRptId      = loc_cRptId
292:             THIS.this_dDtCriacao  = DATE()
293:             THIS.this_dDtAlteracao = DATE()
294: 
295:             loc_cSQL = "INSERT INTO SIGCDRLC" + ;
296:                        " (RPT_ID, NmReport, Descr, Ativo, DtCriacao, DtAlteracao, SqlQuery)" + ;
297:                        " VALUES (" + ;
298:                        EscaparSQL(THIS.this_cRptId) + ", " + ;
299:                        EscaparSQL(THIS.this_cNmReport) + ", " + ;
300:                        EscaparSQL(THIS.this_cDescr) + ", " + ;
301:                        IIF(THIS.this_lAtivo, "1", "0") + ", " + ;

--- BO Linhas 336 a 346 ---
336: 
337:             loc_cSQL = "UPDATE SIGCDRLC SET" + ;
338:                        " NmReport = " + EscaparSQL(THIS.this_cNmReport) + "," + ;
339:                        " Descr = " + EscaparSQL(THIS.this_cDescr) + "," + ;
340:                        " Ativo = " + IIF(THIS.this_lAtivo, "1", "0") + "," + ;
341:                        " DtAlteracao = " + FormatarDataSQL(THIS.this_dDtAlteracao) + "," + ;
342:                        " SqlQuery = " + EscaparSQL(THIS.this_cSqlQuery) + ;
343:                        " WHERE RPT_ID = " + EscaparSQL(THIS.this_cRptId)
344: 
345:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
346: 

--- BO Linhas 412 a 422 ---
412:         TRY
413:             THIS.this_dDtAlteracao = DATE()
414: 
415:             loc_cSQL = "UPDATE SIGCDRLC SET" + ;
416:                        " SqlQuery = " + EscaparSQL(par_cSqlQuery) + "," + ;
417:                        " DtAlteracao = " + FormatarDataSQL(THIS.this_dDtAlteracao) + ;
418:                        " WHERE RPT_ID = " + EscaparSQL(ALLTRIM(par_cRptId))
419: 
420:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
421: 
422:             IF loc_nResultado >= 0


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
