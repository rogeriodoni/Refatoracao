CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1590: Coluna 'marcas' NAO EXISTE na tabela 'sigcdrci' (referenciada como a.Marcas)
- [SQL-SCHEMA] Linha ~1982: INSERT coluna 'marcas' NAO EXISTE na tabela 'sigcdrci'


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigcdrci
CREATE TABLE [dbo].[sigcdrci](
	[cidchaves] [char](20) NOT NULL,
	[contas] [char](10) NOT NULL,
	[descrats] [char](20) NOT NULL,
	[emps] [char](3) NOT NULL,
	[grupos] [char](10) NOT NULL,
	[percrats] [numeric](5, 2) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\cadastros\FormRcc.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\RccBO.prg):

--- BO Linhas 129 a 139 ---
129:         LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
130:         loc_lSucesso = .F.
131: 
132:         TRY
133:             loc_cSQL = "SELECT a.DescRats, a.Emps, a.Grupos, a.Contas," + ;
134:                        " a.PercRats, a.Marcas, a.CidChaves, c.rclis AS Descs" + ;
135:                        " FROM SigCdRci a" + ;
136:                        " LEFT JOIN SigCdCli c ON c.iclis = a.Contas" + ;
137:                        " WHERE a.DescRats = " + EscaparSQL(par_cDescRats) + ;
138:                        " ORDER BY a.Grupos, a.Contas"
139: 

--- BO Linhas 169 a 179 ---
169:                 USE IN cursor_4c_RateioEdit
170:             ENDIF
171: 
172:             SET NULL ON
173:             CREATE CURSOR cursor_4c_RateioEdit ( ;
174:                 Marcas    I, ;
175:                 Emps      C(3), ;
176:                 Grupos    C(20), ;
177:                 Contas    C(20), ;
178:                 Descs     C(60), ;
179:                 PercRats  N(5,2), ;

--- BO Linhas 179 a 189 ---
179:                 PercRats  N(5,2), ;
180:                 Manual    I ;
181:             )
182:             SET NULL OFF
183: 
184:             loc_cSQL = "SELECT 0 AS Marcas, SPACE(3) AS Emps, a.grupos," + ;
185:                        " a.iclis AS Contas, a.rclis AS Descs," + ;
186:                        " CAST(0.00 AS NUMERIC(5,2)) AS PercRats, 0 AS Manual" + ;
187:                        " FROM SigCdCli a" + ;
188:                        " JOIN SigCdGcr b ON a.grupos = b.codigos" + ;
189:                        " WHERE b.coletors = 9" + ;

--- BO Linhas 251 a 261 ---
251:                     loc_cGrupos = ALLTRIM(cursor_4c_RciExist.Grupos)
252:                     loc_cContas = ALLTRIM(cursor_4c_RciExist.Contas)
253:                     loc_nPerc   = cursor_4c_RciExist.PercRats
254: 
255:                     IF SEEK(loc_cGrupos + loc_cContas, "cursor_4c_RateioEdit", "GruConta")
256:                         REPLACE Marcas WITH 1, PercRats WITH loc_nPerc IN cursor_4c_RateioEdit
257:                     ENDIF
258: 
259:                     SKIP IN cursor_4c_RciExist
260:                 ENDDO
261:             ENDIF

--- BO Linhas 287 a 297 ---
287: 
288:         TRY
289:             SELECT cursor_4c_RateioEdit
290:             loc_nQtde = 0
291:             GO TOP
292:             COUNT FOR Marcas = 1 TO loc_nQtde
293: 
294:             IF loc_nQtde > 0
295:                 loc_nRat = ROUND(100 / loc_nQtde, 2)
296:                 SCAN FOR Marcas = 1
297:                     REPLACE PercRats WITH loc_nRat IN cursor_4c_RateioEdit

--- BO Linhas 291 a 301 ---
291:             GO TOP
292:             COUNT FOR Marcas = 1 TO loc_nQtde
293: 
294:             IF loc_nQtde > 0
295:                 loc_nRat = ROUND(100 / loc_nQtde, 2)
296:                 SCAN FOR Marcas = 1
297:                     REPLACE PercRats WITH loc_nRat IN cursor_4c_RateioEdit
298:                 ENDSCAN
299:             ENDIF
300: 
301:             SELECT cursor_4c_RateioEdit

--- BO Linhas 302 a 312 ---
302:             loc_nPTotal = 0
303:             SUM PercRats TO loc_nPTotal
304: 
305:             IF loc_nPTotal > 100
306:                 GO TOP
307:                 LOCATE FOR Marcas = 1
308:                 IF FOUND()
309:                     REPLACE PercRats WITH PercRats - (loc_nPTotal - 100) IN cursor_4c_RateioEdit
310:                 ENDIF
311:                 loc_nPTotal = 0
312:                 SUM PercRats TO loc_nPTotal

--- BO Linhas 312 a 322 ---
312:                 SUM PercRats TO loc_nPTotal
313:             ENDIF
314: 
315:             IF !EMPTY(loc_nPTotal) AND loc_nPTotal < 100
316:                 GO TOP
317:                 LOCATE FOR Marcas = 1
318:                 IF FOUND()
319:                     REPLACE PercRats WITH PercRats + ((loc_nPTotal - 100) * -1) IN cursor_4c_RateioEdit
320:                 ENDIF
321:             ENDIF
322: 

--- BO Linhas 339 a 349 ---
339:         ENDIF
340: 
341:         TRY
342:             SELECT cursor_4c_RateioEdit
343:             loc_nTotal = 0
344:             SUM PercRats FOR Marcas = 1 TO loc_nTotal
345: 
346:             IF loc_nTotal <> 100
347:                 MsgAviso("Total de rateio diferente de 100%. " + ;
348:                     "Total atual: " + TRANSFORM(loc_nTotal) + "%", ;
349:                     "Lan" + CHR(231) + "amento incorreto")

--- BO Linhas 515 a 525 ---
515:         ENDIF
516: 
517:         TRY
518:             SELECT cursor_4c_RateioEdit
519:             GO TOP
520:             SCAN FOR Marcas = 1
521:                 IF EMPTY(Grupos) AND EMPTY(Contas)
522:                     LOOP
523:                 ENDIF
524: 
525:                 loc_cSQL = "INSERT INTO SigCdRci" + ;

--- BO Linhas 521 a 531 ---
521:                 IF EMPTY(Grupos) AND EMPTY(Contas)
522:                     LOOP
523:                 ENDIF
524: 
525:                 loc_cSQL = "INSERT INTO SigCdRci" + ;
526:                            " (CidChaves, DescRats, Emps, Grupos, Contas, PercRats, Marcas)" + ;
527:                            " VALUES (" + ;
528:                            EscaparSQL(SYS(2015)) + ", " + ;
529:                            EscaparSQL(THIS.this_cDescRats) + ", " + ;
530:                            EscaparSQL(Emps) + ", " + ;
531:                            EscaparSQL(Grupos) + ", " + ;

--- BO Linhas 529 a 539 ---
529:                            EscaparSQL(THIS.this_cDescRats) + ", " + ;
530:                            EscaparSQL(Emps) + ", " + ;
531:                            EscaparSQL(Grupos) + ", " + ;
532:                            EscaparSQL(Contas) + ", " + ;
533:                            FormatarNumeroSQL(PercRats) + ", " + ;
534:                            TRANSFORM(Marcas) + ")"
535: 
536:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
537:                 IF loc_nResultado < 0
538:                     MsgErro("Erro ao inserir item de rateio: " + CapturarErroSQL(), "Erro SQL")
539:                     loc_lSucesso = .F.


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\cadastros\FormRcc.prg
- BO: C:\4c\projeto\app\classes\RccBO.prg
