CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~3885: UPDATE coluna 'this_nncancelas' NAO EXISTE na tabela 'sigcqchi'
- [SQL-SCHEMA] Linha ~3885: UPDATE coluna 'this_nnemitidos' NAO EXISTE na tabela 'sigcqchi'


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigcqchi
CREATE TABLE [dbo].[SIGCQCHI](
	[agencias] [char](4) NOT NULL,
	[bancos] [char](3) NOT NULL,
	[cancelas] [bit] NOT NULL,
	[contas] [char](10) NOT NULL,
	[datas] [datetime] NULL,
	[dopes] [char](20) NOT NULL,
	[emitidos] [bit] NOT NULL,
	[emps] [char](3) NOT NULL,
	[favos] [char](40) NOT NULL,
	[grupos] [char](10) NOT NULL,
	[ncheques] [char](6) NOT NULL,
	[ncontas] [char](10) NOT NULL,
	[ncopias] [numeric](6, 0) NOT NULL,
	[nemissoes] [numeric](2, 0) NOT NULL,
	[numes] [numeric](6, 0) NOT NULL,
	[valors] [numeric](11, 2) NOT NULL,
	[vencs] [datetime] NULL,
	[versos] [text] NULL,
	[cidchaves] [char](20) NOT NULL,
	[empdopnums] [char](29) NOT NULL,
	[justcanc] [text] NULL,
	[impversos] [numeric](1, 0) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormSigPrChr.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SigPrChrBO.prg):

--- BO Linhas 61 a 71 ---
61:     this_cNcheques    = ""    && Numero do cheque (c6)
62:     this_cContas      = ""    && IClis / conta do favorecido (c10)
63:     this_nValors      = 0     && Valor do cheque
64:     this_cFavos       = ""    && Nome do favorecido (c40)
65:     this_nNcopias     = 0     && Numero da copia
66:     this_nNemitidos   = 0     && 1 = emitido, 0 = nao emitido
67:     this_nNcancelas   = 0     && 1 = cancelado, 0 = ativo
68:     this_nNmarca1s    = 0     && 1 = marcado para impressao
69:     this_cCidchaves   = ""    && Chave unica do cheque (para DELETE)
70:     this_cEmpDopNums  = ""    && emps + dopes + STR(numes, 6) (c29)
71:     this_cJustCanc    = ""    && Justificativa do cancelamento

--- BO Linhas 62 a 72 ---
62:     this_cContas      = ""    && IClis / conta do favorecido (c10)
63:     this_nValors      = 0     && Valor do cheque
64:     this_cFavos       = ""    && Nome do favorecido (c40)
65:     this_nNcopias     = 0     && Numero da copia
66:     this_nNemitidos   = 0     && 1 = emitido, 0 = nao emitido
67:     this_nNcancelas   = 0     && 1 = cancelado, 0 = ativo
68:     this_nNmarca1s    = 0     && 1 = marcado para impressao
69:     this_cCidchaves   = ""    && Chave unica do cheque (para DELETE)
70:     this_cEmpDopNums  = ""    && emps + dopes + STR(numes, 6) (c29)
71:     this_cJustCanc    = ""    && Justificativa do cancelamento
72:     this_cVersos      = ""    && Verso do cheque (text)

--- BO Linhas 143 a 153 ---
143:                 THIS.this_cNcheques   = NVL(ncheques,   "")
144:                 THIS.this_cContas     = NVL(contas,     "")
145:                 THIS.this_nValors     = NVL(valors,     0)
146:                 THIS.this_cFavos      = NVL(favos,      "")
147:                 THIS.this_nNcopias    = NVL(ncopias,    0)
148:                 THIS.this_nNemitidos  = NVL(nemitidos,  0)
149:                 THIS.this_nNcancelas  = NVL(ncancelas,  0)
150:                 THIS.this_nNmarca1s   = NVL(nmarca1s,   0)
151:                 THIS.this_cCidchaves  = NVL(cidchaves,  "")
152:                 THIS.this_cJustCanc   = NVL(justcanc,   "")
153: 

--- BO Linhas 144 a 154 ---
144:                 THIS.this_cContas     = NVL(contas,     "")
145:                 THIS.this_nValors     = NVL(valors,     0)
146:                 THIS.this_cFavos      = NVL(favos,      "")
147:                 THIS.this_nNcopias    = NVL(ncopias,    0)
148:                 THIS.this_nNemitidos  = NVL(nemitidos,  0)
149:                 THIS.this_nNcancelas  = NVL(ncancelas,  0)
150:                 THIS.this_nNmarca1s   = NVL(nmarca1s,   0)
151:                 THIS.this_cCidchaves  = NVL(cidchaves,  "")
152:                 THIS.this_cJustCanc   = NVL(justcanc,   "")
153: 
154:                 IF TYPE(par_cAliasCursor + ".grupos") != "U"

--- BO Linhas 177 a 187 ---
177:                         THIS.this_lEmitidos = NVL(EVALUATE(par_cAliasCursor + ".emitidos"), .F.)
178:                     ELSE
179:                         THIS.this_lEmitidos = (NVL(EVALUATE(par_cAliasCursor + ".emitidos"), 0) = 1)
180:                     ENDIF
181:                 ELSE
182:                     THIS.this_lEmitidos = (THIS.this_nNemitidos = 1)
183:                 ENDIF
184: 
185:                 IF TYPE(par_cAliasCursor + ".cancelas") != "U"
186:                     IF VARTYPE(EVALUATE(par_cAliasCursor + ".cancelas")) = "L"
187:                         THIS.this_lCancelas = NVL(EVALUATE(par_cAliasCursor + ".cancelas"), .F.)

--- BO Linhas 187 a 197 ---
187:                         THIS.this_lCancelas = NVL(EVALUATE(par_cAliasCursor + ".cancelas"), .F.)
188:                     ELSE
189:                         THIS.this_lCancelas = (NVL(EVALUATE(par_cAliasCursor + ".cancelas"), 0) = 1)
190:                     ENDIF
191:                 ELSE
192:                     THIS.this_lCancelas = (THIS.this_nNcancelas = 1)
193:                 ENDIF
194: 
195:                 THIS.this_cSituacao = IIF(THIS.this_nNcancelas = 1, ;
196:                     "Cancelado", ;
197:                     IIF(THIS.this_nNemitidos > 0, ;

--- BO Linhas 190 a 200 ---
190:                     ENDIF
191:                 ELSE
192:                     THIS.this_lCancelas = (THIS.this_nNcancelas = 1)
193:                 ENDIF
194: 
195:                 THIS.this_cSituacao = IIF(THIS.this_nNcancelas = 1, ;
196:                     "Cancelado", ;
197:                     IIF(THIS.this_nNemitidos > 0, ;
198:                         "Emitido", ;
199:                         "N" + CHR(227) + "o Emitido"))
200: 

--- BO Linhas 192 a 202 ---
192:                     THIS.this_lCancelas = (THIS.this_nNcancelas = 1)
193:                 ENDIF
194: 
195:                 THIS.this_cSituacao = IIF(THIS.this_nNcancelas = 1, ;
196:                     "Cancelado", ;
197:                     IIF(THIS.this_nNemitidos > 0, ;
198:                         "Emitido", ;
199:                         "N" + CHR(227) + "o Emitido"))
200: 
201:                 loc_lResultado = .T.
202:             ENDIF

--- BO Linhas 297 a 307 ---
297:                        "cidchaves, empdopnums, justcanc, impversos " + ;
298:                        ") VALUES ( "
299: 
300:             loc_cSQL = loc_cSQL + EscaparSQL(ALLTRIM(THIS.this_cAgencias)) + ", "
301:             loc_cSQL = loc_cSQL + EscaparSQL(ALLTRIM(THIS.this_cBancos)) + ", "
302:             loc_cSQL = loc_cSQL + IIF(THIS.this_lCancelas OR THIS.this_nNcancelas = 1, "1", "0") + ", "
303:             loc_cSQL = loc_cSQL + EscaparSQL(ALLTRIM(THIS.this_cContas)) + ", "
304:             loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatas) + ", "
305:             loc_cSQL = loc_cSQL + EscaparSQL(ALLTRIM(THIS.this_cDopes)) + ", "
306: 
307:             loc_cSQL = loc_cSQL + IIF(THIS.this_lEmitidos OR THIS.this_nNemitidos = 1, "1", "0") + ", "

--- BO Linhas 302 a 312 ---
302:             loc_cSQL = loc_cSQL + IIF(THIS.this_lCancelas OR THIS.this_nNcancelas = 1, "1", "0") + ", "
303:             loc_cSQL = loc_cSQL + EscaparSQL(ALLTRIM(THIS.this_cContas)) + ", "
304:             loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatas) + ", "
305:             loc_cSQL = loc_cSQL + EscaparSQL(ALLTRIM(THIS.this_cDopes)) + ", "
306: 
307:             loc_cSQL = loc_cSQL + IIF(THIS.this_lEmitidos OR THIS.this_nNemitidos = 1, "1", "0") + ", "
308:             loc_cSQL = loc_cSQL + EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ", "
309:             loc_cSQL = loc_cSQL + EscaparSQL(ALLTRIM(THIS.this_cFavos)) + ", "
310:             loc_cSQL = loc_cSQL + EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + ", "
311:             loc_cSQL = loc_cSQL + EscaparSQL(ALLTRIM(THIS.this_cNcheques)) + ", "
312:             loc_cSQL = loc_cSQL + EscaparSQL(ALLTRIM(THIS.this_cNcontas)) + ", "

--- BO Linhas 356 a 366 ---
356:             ENDIF
357: 
358:             loc_cSQL = "UPDATE SigCqChi SET " + ;
359:                        "agencias = "  + EscaparSQL(ALLTRIM(THIS.this_cAgencias)) + ", " + ;
360:                        "bancos = "    + EscaparSQL(ALLTRIM(THIS.this_cBancos))   + ", " + ;
361:                        "cancelas = "  + IIF(THIS.this_lCancelas OR THIS.this_nNcancelas = 1, "1", "0") + ", " + ;
362:                        "contas = "    + EscaparSQL(ALLTRIM(THIS.this_cContas))   + ", " + ;
363:                        "datas = "     + FormatarDataSQL(THIS.this_dDatas)        + ", " + ;
364:                        "dopes = "     + EscaparSQL(ALLTRIM(THIS.this_cDopes))    + ", " + ;
365:                        "emitidos = "  + IIF(THIS.this_lEmitidos OR THIS.this_nNemitidos = 1, "1", "0") + ", " + ;
366:                        "emps = "      + EscaparSQL(ALLTRIM(THIS.this_cEmps))     + ", " + ;

--- BO Linhas 360 a 370 ---
360:                        "bancos = "    + EscaparSQL(ALLTRIM(THIS.this_cBancos))   + ", " + ;
361:                        "cancelas = "  + IIF(THIS.this_lCancelas OR THIS.this_nNcancelas = 1, "1", "0") + ", " + ;
362:                        "contas = "    + EscaparSQL(ALLTRIM(THIS.this_cContas))   + ", " + ;
363:                        "datas = "     + FormatarDataSQL(THIS.this_dDatas)        + ", " + ;
364:                        "dopes = "     + EscaparSQL(ALLTRIM(THIS.this_cDopes))    + ", " + ;
365:                        "emitidos = "  + IIF(THIS.this_lEmitidos OR THIS.this_nNemitidos = 1, "1", "0") + ", " + ;
366:                        "emps = "      + EscaparSQL(ALLTRIM(THIS.this_cEmps))     + ", " + ;
367:                        "favos = "     + EscaparSQL(ALLTRIM(THIS.this_cFavos))    + ", " + ;
368:                        "grupos = "    + EscaparSQL(ALLTRIM(THIS.this_cGrupos))   + ", " + ;
369:                        "ncheques = "  + EscaparSQL(ALLTRIM(THIS.this_cNcheques)) + ", " + ;
370:                        "ncontas = "   + EscaparSQL(ALLTRIM(THIS.this_cNcontas))  + ", " + ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormSigPrChr.prg
- BO: C:\4c\projeto\app\classes\SigPrChrBO.prg
