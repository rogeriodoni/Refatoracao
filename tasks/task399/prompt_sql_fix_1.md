CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1244: Coluna 'codigos' NAO EXISTE na tabela 'sigcddis' (referenciada como a.Codigos)
- [SQL-SCHEMA] Linha ~1244: Coluna 'iclis' NAO EXISTE na tabela 'sigcddis' (referenciada como a.Iclis)
- [SQL-SCHEMA] Linha ~1244: Coluna 'iclis' NAO EXISTE na tabela 'sigcddis' (referenciada como a.Iclis)
- [SQL-SCHEMA] Linha ~1285: Coluna 'codigos' NAO EXISTE na tabela 'sigcddis' (referenciada como a.Codigos)
- [SQL-SCHEMA] Linha ~1285: Coluna 'iclis' NAO EXISTE na tabela 'sigcddis' (referenciada como a.Iclis)
- [SQL-SCHEMA] Linha ~1285: Coluna 'iclis' NAO EXISTE na tabela 'sigcddis' (referenciada como a.Iclis)
- [SQL-SCHEMA] Linha ~1285: Coluna 'codigos' NAO EXISTE na tabela 'sigcddis' (referenciada como a.Codigos)
- [SQL-SCHEMA] Linha ~1354: INSERT coluna 'codigos' NAO EXISTE na tabela 'sigcddis'
- [SQL-SCHEMA] Linha ~1354: INSERT coluna 'iclis' NAO EXISTE na tabela 'sigcddis'
- [SQL-SCHEMA] Linha ~1390: UPDATE coluna 'iclis' NAO EXISTE na tabela 'sigcddis'
- [SQL-SCHEMA] Linha ~1390: WHERE coluna 'codigos' NAO EXISTE na tabela 'sigcddis'


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigcddis
CREATE TABLE [dbo].[SIGCDDIS](
	[grupos] [char](10) NOT NULL,
	[contas] [char](10) NOT NULL,
	[cidchaves] [char](20) NOT NULL,
	[tipos] [numeric](1, 0) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\cadastros\FormDsp.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\DspBO.prg):

--- BO Linhas 8 a 18 ---
8: 
9:     *--------------------------------------------------------------------------
10:     * Campos da tabela SigCdDis
11:     *--------------------------------------------------------------------------
12:     this_cCodigos   = ""   && char(20) PK - gerado por SYS(2015)
13:     this_cGrupos    = ""   && char(10) FK -> SigCdGcr.Codigos
14:     this_cIclis     = ""   && char(10) FK -> SigCdCli.IClis
15:     this_nTipos     = 1    && numeric(1,0) 1=Disponibilidade 2=Investimento 3=Emprestimo
16: 
17:     *--------------------------------------------------------------------------
18:     * Campos auxiliares (nao persistidos - apenas para exibicao no form)

--- BO Linhas 9 a 19 ---
9:     *--------------------------------------------------------------------------
10:     * Campos da tabela SigCdDis
11:     *--------------------------------------------------------------------------
12:     this_cCodigos   = ""   && char(20) PK - gerado por SYS(2015)
13:     this_cGrupos    = ""   && char(10) FK -> SigCdGcr.Codigos
14:     this_cIclis     = ""   && char(10) FK -> SigCdCli.IClis
15:     this_nTipos     = 1    && numeric(1,0) 1=Disponibilidade 2=Investimento 3=Emprestimo
16: 
17:     *--------------------------------------------------------------------------
18:     * Campos auxiliares (nao persistidos - apenas para exibicao no form)
19:     *--------------------------------------------------------------------------

--- BO Linhas 27 a 37 ---
27:         loc_lResultado = .F.
28: 
29:         TRY
30:             DODEFAULT()
31:             THIS.this_cTabela     = "SigCdDis"
32:             THIS.this_cCampoChave = "Codigos"
33:             loc_lResultado = .T.
34:         CATCH TO loc_oErro
35:             MsgErro(loc_oErro.Message, "Erro")
36:         ENDTRY
37: 

--- BO Linhas 49 a 59 ---
49:         TRY
50:             IF USED("cursor_4c_Dados")
51:                 USE IN cursor_4c_Dados
52:             ENDIF
53: 
54:             loc_cSQL = "SELECT a.Codigos, a.Grupos," + ;
55:                        " RTRIM(ISNULL(b.Descrs,'')) AS DsGrupos," + ;
56:                        " a.Iclis, RTRIM(ISNULL(c.Rclis,'')) AS DsConta, a.Tipos" + ;
57:                        " FROM SigCdDis a" + ;
58:                        " LEFT JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
59:                        " LEFT JOIN SigCdCli c ON c.Iclis = a.Iclis"

--- BO Linhas 51 a 61 ---
51:                 USE IN cursor_4c_Dados
52:             ENDIF
53: 
54:             loc_cSQL = "SELECT a.Codigos, a.Grupos," + ;
55:                        " RTRIM(ISNULL(b.Descrs,'')) AS DsGrupos," + ;
56:                        " a.Iclis, RTRIM(ISNULL(c.Rclis,'')) AS DsConta, a.Tipos" + ;
57:                        " FROM SigCdDis a" + ;
58:                        " LEFT JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
59:                        " LEFT JOIN SigCdCli c ON c.Iclis = a.Iclis"
60: 
61:             IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))

--- BO Linhas 53 a 63 ---
53: 
54:             loc_cSQL = "SELECT a.Codigos, a.Grupos," + ;
55:                        " RTRIM(ISNULL(b.Descrs,'')) AS DsGrupos," + ;
56:                        " a.Iclis, RTRIM(ISNULL(c.Rclis,'')) AS DsConta, a.Tipos" + ;
57:                        " FROM SigCdDis a" + ;
58:                        " LEFT JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
59:                        " LEFT JOIN SigCdCli c ON c.Iclis = a.Iclis"
60: 
61:             IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
62:                 loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
63:             ENDIF

--- BO Linhas 54 a 64 ---
54:             loc_cSQL = "SELECT a.Codigos, a.Grupos," + ;
55:                        " RTRIM(ISNULL(b.Descrs,'')) AS DsGrupos," + ;
56:                        " a.Iclis, RTRIM(ISNULL(c.Rclis,'')) AS DsConta, a.Tipos" + ;
57:                        " FROM SigCdDis a" + ;
58:                        " LEFT JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
59:                        " LEFT JOIN SigCdCli c ON c.Iclis = a.Iclis"
60: 
61:             IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
62:                 loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
63:             ENDIF
64: 

--- BO Linhas 60 a 70 ---
60: 
61:             IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
62:                 loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
63:             ENDIF
64: 
65:             loc_cSQL = loc_cSQL + " ORDER BY a.Grupos, a.Iclis"
66: 
67:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
68: 
69:             IF loc_nResult >= 0
70:                 GO TOP IN cursor_4c_Dados

--- BO Linhas 78 a 88 ---
78: 
79:         RETURN loc_lResultado
80:     ENDPROC
81: 
82:     *==========================================================================
83:     * CarregarPorCodigo - Carrega disponibilidade pelo Codigos (PK)
84:     * par_cCodigo: valor do Codigos
85:     *==========================================================================
86:     PROCEDURE CarregarPorCodigo(par_cCodigo)
87:         LOCAL loc_lResultado, loc_cSQL, loc_nResult
88:         loc_lResultado = .F.

--- BO Linhas 79 a 89 ---
79:         RETURN loc_lResultado
80:     ENDPROC
81: 
82:     *==========================================================================
83:     * CarregarPorCodigo - Carrega disponibilidade pelo Codigos (PK)
84:     * par_cCodigo: valor do Codigos
85:     *==========================================================================
86:     PROCEDURE CarregarPorCodigo(par_cCodigo)
87:         LOCAL loc_lResultado, loc_cSQL, loc_nResult
88:         loc_lResultado = .F.
89: 

--- BO Linhas 90 a 100 ---
90:         TRY
91:             IF USED("cursor_4c_Carrega")
92:                 USE IN cursor_4c_Carrega
93:             ENDIF
94: 
95:             loc_cSQL = "SELECT a.Codigos, a.Grupos," + ;
96:                        " RTRIM(ISNULL(b.Descrs,'')) AS DsGrupos," + ;
97:                        " a.Iclis, RTRIM(ISNULL(c.Rclis,'')) AS DsConta, a.Tipos" + ;
98:                        " FROM SigCdDis a" + ;
99:                        " LEFT JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
100:                        " LEFT JOIN SigCdCli c ON c.Iclis = a.Iclis" + ;

--- BO Linhas 92 a 102 ---
92:                 USE IN cursor_4c_Carrega
93:             ENDIF
94: 
95:             loc_cSQL = "SELECT a.Codigos, a.Grupos," + ;
96:                        " RTRIM(ISNULL(b.Descrs,'')) AS DsGrupos," + ;
97:                        " a.Iclis, RTRIM(ISNULL(c.Rclis,'')) AS DsConta, a.Tipos" + ;
98:                        " FROM SigCdDis a" + ;
99:                        " LEFT JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
100:                        " LEFT JOIN SigCdCli c ON c.Iclis = a.Iclis" + ;
101:                        " WHERE a.Codigos = " + EscaparSQL(par_cCodigo)
102: 

--- BO Linhas 94 a 104 ---
94: 
95:             loc_cSQL = "SELECT a.Codigos, a.Grupos," + ;
96:                        " RTRIM(ISNULL(b.Descrs,'')) AS DsGrupos," + ;
97:                        " a.Iclis, RTRIM(ISNULL(c.Rclis,'')) AS DsConta, a.Tipos" + ;
98:                        " FROM SigCdDis a" + ;
99:                        " LEFT JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
100:                        " LEFT JOIN SigCdCli c ON c.Iclis = a.Iclis" + ;
101:                        " WHERE a.Codigos = " + EscaparSQL(par_cCodigo)
102: 
103:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
104: 

--- BO Linhas 95 a 105 ---
95:             loc_cSQL = "SELECT a.Codigos, a.Grupos," + ;
96:                        " RTRIM(ISNULL(b.Descrs,'')) AS DsGrupos," + ;
97:                        " a.Iclis, RTRIM(ISNULL(c.Rclis,'')) AS DsConta, a.Tipos" + ;
98:                        " FROM SigCdDis a" + ;
99:                        " LEFT JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
100:                        " LEFT JOIN SigCdCli c ON c.Iclis = a.Iclis" + ;
101:                        " WHERE a.Codigos = " + EscaparSQL(par_cCodigo)
102: 
103:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
104: 
105:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0

--- BO Linhas 96 a 106 ---
96:                        " RTRIM(ISNULL(b.Descrs,'')) AS DsGrupos," + ;
97:                        " a.Iclis, RTRIM(ISNULL(c.Rclis,'')) AS DsConta, a.Tipos" + ;
98:                        " FROM SigCdDis a" + ;
99:                        " LEFT JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
100:                        " LEFT JOIN SigCdCli c ON c.Iclis = a.Iclis" + ;
101:                        " WHERE a.Codigos = " + EscaparSQL(par_cCodigo)
102: 
103:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
104: 
105:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
106:                 loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")

--- BO Linhas 130 a 140 ---
130:         loc_lResultado = .F.
131: 
132:         TRY
133:             IF USED(par_cAliasCursor)
134:                 SELECT (par_cAliasCursor)
135:                 THIS.this_cCodigos   = TratarNulo(Codigos,  "C")
136:                 THIS.this_cGrupos    = TratarNulo(Grupos,   "C")
137:                 THIS.this_cIclis     = TratarNulo(Iclis,    "C")
138:                 THIS.this_nTipos     = TratarNulo(Tipos,    "N")
139:                 THIS.this_cDsGrupo   = TratarNulo(DsGrupos, "C")
140:                 THIS.this_cDsConta   = TratarNulo(DsConta,  "C")

--- BO Linhas 132 a 142 ---
132:         TRY
133:             IF USED(par_cAliasCursor)
134:                 SELECT (par_cAliasCursor)
135:                 THIS.this_cCodigos   = TratarNulo(Codigos,  "C")
136:                 THIS.this_cGrupos    = TratarNulo(Grupos,   "C")
137:                 THIS.this_cIclis     = TratarNulo(Iclis,    "C")
138:                 THIS.this_nTipos     = TratarNulo(Tipos,    "N")
139:                 THIS.this_cDsGrupo   = TratarNulo(DsGrupos, "C")
140:                 THIS.this_cDsConta   = TratarNulo(DsConta,  "C")
141:                 loc_lResultado = .T.
142:             ENDIF

--- BO Linhas 147 a 157 ---
147:         RETURN loc_lResultado
148:     ENDPROC
149: 
150:     *==========================================================================
151:     * Inserir - Insere nova disponibilidade (PROTECTED)
152:     * Gera Codigos via SYS(2015), verifica duplicidade antes de INSERT
153:     *==========================================================================
154:     PROTECTED PROCEDURE Inserir()
155:         LOCAL loc_lResultado, loc_cSQL, loc_nResult
156:         loc_lResultado = .F.
157: 

--- BO Linhas 159 a 169 ---
159:             IF THIS.VerificarDuplicidade(THIS.this_cGrupos, THIS.this_cIclis, "")
160:                 MsgErro("Disponibilidade j" + CHR(225) + " est" + CHR(225) + " cadastrada!", "Valida" + CHR(231) + CHR(227) + "o")
161:             ELSE
162:                 THIS.this_cCodigos = LEFT(SYS(2015) + SYS(2015), 20)
163: 
164:                 loc_cSQL = "INSERT INTO SigCdDis (Codigos, Grupos, Iclis, Tipos)" + ;
165:                            " VALUES (" + ;
166:                            EscaparSQL(THIS.this_cCodigos)               + ", " + ;
167:                            EscaparSQL(LEFT(THIS.this_cGrupos, 10))      + ", " + ;
168:                            EscaparSQL(LEFT(THIS.this_cIclis, 10))       + ", " + ;
169:                            FormatarNumeroSQL(THIS.this_nTipos)          + ;

--- BO Linhas 197 a 207 ---
197:             IF THIS.VerificarDuplicidade(THIS.this_cGrupos, THIS.this_cIclis, THIS.this_cCodigos)
198:                 MsgErro("Disponibilidade j" + CHR(225) + " est" + CHR(225) + " cadastrada!", "Valida" + CHR(231) + CHR(227) + "o")
199:             ELSE
200:                 loc_cSQL = "UPDATE SigCdDis SET" + ;
201:                            " Grupos = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + "," + ;
202:                            " Iclis  = " + EscaparSQL(LEFT(THIS.this_cIclis, 10))  + "," + ;
203:                            " Tipos  = " + FormatarNumeroSQL(THIS.this_nTipos) + ;
204:                            " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
205: 
206:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
207: 

--- BO Linhas 199 a 209 ---
199:             ELSE
200:                 loc_cSQL = "UPDATE SigCdDis SET" + ;
201:                            " Grupos = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + "," + ;
202:                            " Iclis  = " + EscaparSQL(LEFT(THIS.this_cIclis, 10))  + "," + ;
203:                            " Tipos  = " + FormatarNumeroSQL(THIS.this_nTipos) + ;
204:                            " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
205: 
206:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
207: 
208:                 IF loc_nResult >= 0
209:                     THIS.RegistrarAuditoria("UPDATE")

--- BO Linhas 226 a 236 ---
226:     PROTECTED PROCEDURE ExecutarExclusao()
227:         LOCAL loc_lResultado, loc_cSQL, loc_nResult
228:         loc_lResultado = .F.
229: 
230:         TRY
231:             loc_cSQL = "DELETE FROM SigCdDis WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
232: 
233:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
234: 
235:             IF loc_nResult >= 0
236:                 THIS.RegistrarAuditoria("DELETE")

--- BO Linhas 251 a 261 ---
251:     PROCEDURE ObterChavePrimaria()
252:         RETURN THIS.this_cCodigos
253:     ENDPROC
254: 
255:     *==========================================================================
256:     * VerificarDuplicidade - Verifica se ja existe registro com Grupos+Iclis
257:     * par_cGrupos: codigo do grupo (SigCdDis.Grupos)
258:     * par_cContas: codigo da conta (SigCdDis.Iclis)
259:     * par_cExcluirChave: PK a excluir da verificacao (vazio=INSERT, atual=UPDATE)
260:     * Retorna: .T. se duplicado, .F. se nao existe
261:     *==========================================================================

--- BO Linhas 253 a 263 ---
253:     ENDPROC
254: 
255:     *==========================================================================
256:     * VerificarDuplicidade - Verifica se ja existe registro com Grupos+Iclis
257:     * par_cGrupos: codigo do grupo (SigCdDis.Grupos)
258:     * par_cContas: codigo da conta (SigCdDis.Iclis)
259:     * par_cExcluirChave: PK a excluir da verificacao (vazio=INSERT, atual=UPDATE)
260:     * Retorna: .T. se duplicado, .F. se nao existe
261:     *==========================================================================
262:     PROCEDURE VerificarDuplicidade(par_cGrupos, par_cContas, par_cExcluirChave)
263:         LOCAL loc_lDuplicado, loc_cSQL, loc_nResult

--- BO Linhas 267 a 277 ---
267:             IF USED("cursor_4c_Duplic")
268:                 USE IN cursor_4c_Duplic
269:             ENDIF
270: 
271:             loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdDis" + ;
272:                        " WHERE Iclis = " + EscaparSQL(par_cContas)
273: 
274:             IF VARTYPE(par_cExcluirChave) = "C" AND !EMPTY(ALLTRIM(par_cExcluirChave))
275:                 loc_cSQL = loc_cSQL + " AND Codigos <> " + EscaparSQL(par_cExcluirChave)
276:             ENDIF
277: 

--- BO Linhas 270 a 280 ---
270: 
271:             loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdDis" + ;
272:                        " WHERE Iclis = " + EscaparSQL(par_cContas)
273: 
274:             IF VARTYPE(par_cExcluirChave) = "C" AND !EMPTY(ALLTRIM(par_cExcluirChave))
275:                 loc_cSQL = loc_cSQL + " AND Codigos <> " + EscaparSQL(par_cExcluirChave)
276:             ENDIF
277: 
278:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Duplic")
279: 
280:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Duplic") > 0

--- BO Linhas 292 a 302 ---
292:         RETURN loc_lDuplicado
293:     ENDPROC
294: 
295:     *==========================================================================
296:     * ValidarGrupo - Valida codigo de grupo e carrega descricao
297:     * par_cGrupo: codigo do grupo (SigCdGcr.Codigos)
298:     * Retorna: .T. se valido | Efeito: popula this_cDsGrupo
299:     *==========================================================================
300:     PROCEDURE ValidarGrupo(par_cGrupo)
301:         LOCAL loc_lResultado, loc_cSQL, loc_nResult
302:         loc_lResultado = .F.

--- BO Linhas 307 a 317 ---
307:             ENDIF
308: 
309:             IF EMPTY(ALLTRIM(par_cGrupo))
310:                 THIS.this_cDsGrupo = ""
311:             ELSE
312:                 loc_cSQL = "SELECT Codigos, RTRIM(Descrs) AS Descrs FROM SigCdGcr" + ;
313:                            " WHERE Codigos = " + EscaparSQL(par_cGrupo)
314: 
315:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGrupo")
316: 
317:                 IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ValGrupo") > 0

--- BO Linhas 308 a 318 ---
308: 
309:             IF EMPTY(ALLTRIM(par_cGrupo))
310:                 THIS.this_cDsGrupo = ""
311:             ELSE
312:                 loc_cSQL = "SELECT Codigos, RTRIM(Descrs) AS Descrs FROM SigCdGcr" + ;
313:                            " WHERE Codigos = " + EscaparSQL(par_cGrupo)
314: 
315:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGrupo")
316: 
317:                 IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ValGrupo") > 0
318:                     SELECT cursor_4c_ValGrupo

--- BO Linhas 332 a 342 ---
332: 
333:         RETURN loc_lResultado
334:     ENDPROC
335: 
336:     *==========================================================================
337:     * ValidarConta - Valida codigo de conta (SigCdCli.IClis)
338:     * par_cGrupo: nao utilizado no filtro SQL
339:     * par_cConta: codigo da conta (SigCdCli.IClis)
340:     * Retorna: .T. se valida | Efeito: popula this_cDsConta
341:     *==========================================================================
342:     PROCEDURE ValidarConta(par_cGrupo, par_cConta)

--- BO Linhas 334 a 344 ---
334:     ENDPROC
335: 
336:     *==========================================================================
337:     * ValidarConta - Valida codigo de conta (SigCdCli.IClis)
338:     * par_cGrupo: nao utilizado no filtro SQL
339:     * par_cConta: codigo da conta (SigCdCli.IClis)
340:     * Retorna: .T. se valida | Efeito: popula this_cDsConta
341:     *==========================================================================
342:     PROCEDURE ValidarConta(par_cGrupo, par_cConta)
343:         LOCAL loc_lResultado, loc_cSQL, loc_nResult
344:         loc_lResultado = .F.

--- BO Linhas 349 a 359 ---
349:             ENDIF
350: 
351:             IF EMPTY(ALLTRIM(par_cConta))
352:                 THIS.this_cDsConta = ""
353:             ELSE
354:                 loc_cSQL = "SELECT Iclis, RTRIM(Rclis) AS Rclis FROM SigCdCli" + ;
355:                            " WHERE Iclis = " + EscaparSQL(par_cConta)
356: 
357:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValConta")
358: 
359:                 IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ValConta") > 0

--- BO Linhas 350 a 360 ---
350: 
351:             IF EMPTY(ALLTRIM(par_cConta))
352:                 THIS.this_cDsConta = ""
353:             ELSE
354:                 loc_cSQL = "SELECT Iclis, RTRIM(Rclis) AS Rclis FROM SigCdCli" + ;
355:                            " WHERE Iclis = " + EscaparSQL(par_cConta)
356: 
357:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValConta")
358: 
359:                 IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ValConta") > 0
360:                     SELECT cursor_4c_ValConta

--- BO Linhas 375 a 385 ---
375:         RETURN loc_lResultado
376:     ENDPROC
377: 
378:     *==========================================================================
379:     * BuscarGrupos - Popula cursor_4c_BuscaGrupo para lookup de grupos
380:     * par_cFiltro: prefixo para filtrar por Codigos (vazio = todos)
381:     *==========================================================================
382:     PROCEDURE BuscarGrupos(par_cFiltro)
383:         LOCAL loc_lResultado, loc_cSQL, loc_nResult
384:         loc_lResultado = .F.
385: 

--- BO Linhas 386 a 396 ---
386:         TRY
387:             IF USED("cursor_4c_BuscaGrupo")
388:                 USE IN cursor_4c_BuscaGrupo
389:             ENDIF
390: 
391:             loc_cSQL = "SELECT Codigos, RTRIM(Descrs) AS Descrs FROM SigCdGcr"
392: 
393:             IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
394:                 loc_cSQL = loc_cSQL + " WHERE Codigos LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
395:             ENDIF
396: 

--- BO Linhas 389 a 399 ---
389:             ENDIF
390: 
391:             loc_cSQL = "SELECT Codigos, RTRIM(Descrs) AS Descrs FROM SigCdGcr"
392: 
393:             IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
394:                 loc_cSQL = loc_cSQL + " WHERE Codigos LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
395:             ENDIF
396: 
397:             loc_cSQL = loc_cSQL + " ORDER BY Codigos"
398: 
399:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")

--- BO Linhas 392 a 402 ---
392: 
393:             IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
394:                 loc_cSQL = loc_cSQL + " WHERE Codigos LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
395:             ENDIF
396: 
397:             loc_cSQL = loc_cSQL + " ORDER BY Codigos"
398: 
399:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")
400: 
401:             IF loc_nResult >= 0
402:                 GO TOP IN cursor_4c_BuscaGrupo

--- BO Linhas 412 a 422 ---
412:     ENDPROC
413: 
414:     *==========================================================================
415:     * BuscarContas - Popula cursor_4c_BuscaConta para lookup de contas
416:     * par_cGrupo: nao utilizado no filtro SQL
417:     * par_cFiltro: prefixo para filtrar por Iclis (vazio = todos)
418:     *==========================================================================
419:     PROCEDURE BuscarContas(par_cGrupo, par_cFiltro)
420:         LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cWhere
421:         loc_lResultado = .F.
422:         loc_cWhere     = ""

--- BO Linhas 424 a 434 ---
424:         TRY
425:             IF USED("cursor_4c_BuscaConta")
426:                 USE IN cursor_4c_BuscaConta
427:             ENDIF
428: 
429:             loc_cSQL = "SELECT Iclis, RTRIM(Rclis) AS Rclis FROM SigCdCli"
430: 
431:             IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
432:                 loc_cWhere = " WHERE Iclis LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
433:             ENDIF
434: 

--- BO Linhas 427 a 437 ---
427:             ENDIF
428: 
429:             loc_cSQL = "SELECT Iclis, RTRIM(Rclis) AS Rclis FROM SigCdCli"
430: 
431:             IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
432:                 loc_cWhere = " WHERE Iclis LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
433:             ENDIF
434: 
435:             loc_cSQL = loc_cSQL + loc_cWhere + " ORDER BY Iclis"
436: 
437:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")

--- BO Linhas 430 a 440 ---
430: 
431:             IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
432:                 loc_cWhere = " WHERE Iclis LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
433:             ENDIF
434: 
435:             loc_cSQL = loc_cSQL + loc_cWhere + " ORDER BY Iclis"
436: 
437:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
438: 
439:             IF loc_nResult >= 0
440:                 GO TOP IN cursor_4c_BuscaConta


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\cadastros\FormDsp.prg
- BO: C:\4c\projeto\app\classes\DspBO.prg
