CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~2449: UPDATE coluna 'grupoos' NAO EXISTE na tabela 'sigmvpec'
- [SQL-SCHEMA] Linha ~2449: UPDATE coluna 'contaos' NAO EXISTE na tabela 'sigmvpec'
- [SQL-SCHEMA] Linha ~2449: UPDATE coluna 'grupods' NAO EXISTE na tabela 'sigmvpec'
- [SQL-SCHEMA] Linha ~2449: UPDATE coluna 'contads' NAO EXISTE na tabela 'sigmvpec'
- [SQL-SCHEMA] Linha ~2449: UPDATE coluna 'tabds' NAO EXISTE na tabela 'sigmvpec'
- [SQL-SCHEMA] Linha ~2449: UPDATE coluna 'notas' NAO EXISTE na tabela 'sigmvpec'
- [SQL-SCHEMA] Linha ~2449: UPDATE coluna 'vends' NAO EXISTE na tabela 'sigmvpec'
- [SQL-SCHEMA] Linha ~2449: UPDATE coluna 'grvends' NAO EXISTE na tabela 'sigmvpec'
- [SQL-SCHEMA] Linha ~2449: UPDATE coluna 'prazoents' NAO EXISTE na tabela 'sigmvpec'


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigmvpec
CREATE TABLE [dbo].[SigMvPec](
	[emps] [char](3) NOT NULL,
	[dopes] [char](20) NOT NULL,
	[numes] [numeric](6, 0) NOT NULL,
	[codigos] [numeric](10, 0) NOT NULL,
	[datatrans] [datetime] NULL,
	[ntrans] [numeric](6, 0) NOT NULL,
	[locals] [char](10) NOT NULL,
	[valobxs] [numeric](11, 2) NOT NULL,
	[cidchaves] [char](20) NOT NULL,
	[empdopnums] [char](29) NOT NULL,
	[empsubns] [char](3) NOT NULL,
	[datas] [datetime] NULL,
	[chksubn] [bit] NULL,
	[dtagends] [datetime] NULL,
	[chkpagos] [bit] NOT NULL,
	[nparcs] [numeric](3, 0) NOT NULL,
	[valps] [numeric](11, 2) NOT NULL,
	[valvars] [numeric](11, 2) NOT NULL,
	[vencps] [datetime] NULL,
	[pstatus] [char](1) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\cadastros\Formsigpres2.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\sigpres2BO.prg):

--- BO Linhas 134 a 144 ---
134:                 THIS.this_cEmps        = TratarNulo(emps,       "C")
135:                 THIS.this_cEmpds       = TratarNulo(empds,      "C")
136:                 THIS.this_cDopes       = TratarNulo(dopes,      "C")
137:                 THIS.this_nNumes       = TratarNulo(numes,      "N")
138:                 THIS.this_dDatas       = TratarNulo(datas,      "D")
139:                 THIS.this_cGrupoOs     = TratarNulo(grupoos,    "C")
140:                 THIS.this_cContaOs     = TratarNulo(contaos,    "C")
141:                 THIS.this_cGrupoDs     = TratarNulo(grupods,    "C")
142:                 THIS.this_cContaDs     = TratarNulo(contads,    "C")
143:                 THIS.this_nNops        = TratarNulo(nops,       "N")
144:                 THIS.this_cUsuars      = TratarNulo(usuars,     "C")

--- BO Linhas 135 a 145 ---
135:                 THIS.this_cEmpds       = TratarNulo(empds,      "C")
136:                 THIS.this_cDopes       = TratarNulo(dopes,      "C")
137:                 THIS.this_nNumes       = TratarNulo(numes,      "N")
138:                 THIS.this_dDatas       = TratarNulo(datas,      "D")
139:                 THIS.this_cGrupoOs     = TratarNulo(grupoos,    "C")
140:                 THIS.this_cContaOs     = TratarNulo(contaos,    "C")
141:                 THIS.this_cGrupoDs     = TratarNulo(grupods,    "C")
142:                 THIS.this_cContaDs     = TratarNulo(contads,    "C")
143:                 THIS.this_nNops        = TratarNulo(nops,       "N")
144:                 THIS.this_cUsuars      = TratarNulo(usuars,     "C")
145:                 THIS.this_cPStatus     = TratarNulo(pstatus,    "C")

--- BO Linhas 136 a 146 ---
136:                 THIS.this_cDopes       = TratarNulo(dopes,      "C")
137:                 THIS.this_nNumes       = TratarNulo(numes,      "N")
138:                 THIS.this_dDatas       = TratarNulo(datas,      "D")
139:                 THIS.this_cGrupoOs     = TratarNulo(grupoos,    "C")
140:                 THIS.this_cContaOs     = TratarNulo(contaos,    "C")
141:                 THIS.this_cGrupoDs     = TratarNulo(grupods,    "C")
142:                 THIS.this_cContaDs     = TratarNulo(contads,    "C")
143:                 THIS.this_nNops        = TratarNulo(nops,       "N")
144:                 THIS.this_cUsuars      = TratarNulo(usuars,     "C")
145:                 THIS.this_cPStatus     = TratarNulo(pstatus,    "C")
146:                 THIS.this_cVends       = TratarNulo(vends,      "C")

--- BO Linhas 137 a 147 ---
137:                 THIS.this_nNumes       = TratarNulo(numes,      "N")
138:                 THIS.this_dDatas       = TratarNulo(datas,      "D")
139:                 THIS.this_cGrupoOs     = TratarNulo(grupoos,    "C")
140:                 THIS.this_cContaOs     = TratarNulo(contaos,    "C")
141:                 THIS.this_cGrupoDs     = TratarNulo(grupods,    "C")
142:                 THIS.this_cContaDs     = TratarNulo(contads,    "C")
143:                 THIS.this_nNops        = TratarNulo(nops,       "N")
144:                 THIS.this_cUsuars      = TratarNulo(usuars,     "C")
145:                 THIS.this_cPStatus     = TratarNulo(pstatus,    "C")
146:                 THIS.this_cVends       = TratarNulo(vends,      "C")
147:                 THIS.this_cGrvends     = TratarNulo(grvends,    "C")

--- BO Linhas 141 a 151 ---
141:                 THIS.this_cGrupoDs     = TratarNulo(grupods,    "C")
142:                 THIS.this_cContaDs     = TratarNulo(contads,    "C")
143:                 THIS.this_nNops        = TratarNulo(nops,       "N")
144:                 THIS.this_cUsuars      = TratarNulo(usuars,     "C")
145:                 THIS.this_cPStatus     = TratarNulo(pstatus,    "C")
146:                 THIS.this_cVends       = TratarNulo(vends,      "C")
147:                 THIS.this_cGrvends     = TratarNulo(grvends,    "C")
148:                 THIS.this_cTabds       = TratarNulo(tabds,      "C")
149:                 THIS.this_cObses       = TratarNulo(obses,      "C")
150:                 THIS.this_dPrazoents   = TratarNulo(prazoents,  "D")
151:                 THIS.this_cMascnum     = TratarNulo(mascnum,    "C")

--- BO Linhas 142 a 152 ---
142:                 THIS.this_cContaDs     = TratarNulo(contads,    "C")
143:                 THIS.this_nNops        = TratarNulo(nops,       "N")
144:                 THIS.this_cUsuars      = TratarNulo(usuars,     "C")
145:                 THIS.this_cPStatus     = TratarNulo(pstatus,    "C")
146:                 THIS.this_cVends       = TratarNulo(vends,      "C")
147:                 THIS.this_cGrvends     = TratarNulo(grvends,    "C")
148:                 THIS.this_cTabds       = TratarNulo(tabds,      "C")
149:                 THIS.this_cObses       = TratarNulo(obses,      "C")
150:                 THIS.this_dPrazoents   = TratarNulo(prazoents,  "D")
151:                 THIS.this_cMascnum     = TratarNulo(mascnum,    "C")
152:                 THIS.this_cNotas       = TratarNulo(notas,      "C")

--- BO Linhas 143 a 153 ---
143:                 THIS.this_nNops        = TratarNulo(nops,       "N")
144:                 THIS.this_cUsuars      = TratarNulo(usuars,     "C")
145:                 THIS.this_cPStatus     = TratarNulo(pstatus,    "C")
146:                 THIS.this_cVends       = TratarNulo(vends,      "C")
147:                 THIS.this_cGrvends     = TratarNulo(grvends,    "C")
148:                 THIS.this_cTabds       = TratarNulo(tabds,      "C")
149:                 THIS.this_cObses       = TratarNulo(obses,      "C")
150:                 THIS.this_dPrazoents   = TratarNulo(prazoents,  "D")
151:                 THIS.this_cMascnum     = TratarNulo(mascnum,    "C")
152:                 THIS.this_cNotas       = TratarNulo(notas,      "C")
153:                 THIS.this_lChksubn     = ConverterParaLogico(chksubn)

--- BO Linhas 145 a 155 ---
145:                 THIS.this_cPStatus     = TratarNulo(pstatus,    "C")
146:                 THIS.this_cVends       = TratarNulo(vends,      "C")
147:                 THIS.this_cGrvends     = TratarNulo(grvends,    "C")
148:                 THIS.this_cTabds       = TratarNulo(tabds,      "C")
149:                 THIS.this_cObses       = TratarNulo(obses,      "C")
150:                 THIS.this_dPrazoents   = TratarNulo(prazoents,  "D")
151:                 THIS.this_cMascnum     = TratarNulo(mascnum,    "C")
152:                 THIS.this_cNotas       = TratarNulo(notas,      "C")
153:                 THIS.this_lChksubn     = ConverterParaLogico(chksubn)
154:                 THIS.this_lChkBxParcs  = ConverterParaLogico(chkbxparcs)
155:                 THIS.this_cEmpdopnums  = ALLTRIM(THIS.this_cEmps) + ;

--- BO Linhas 147 a 157 ---
147:                 THIS.this_cGrvends     = TratarNulo(grvends,    "C")
148:                 THIS.this_cTabds       = TratarNulo(tabds,      "C")
149:                 THIS.this_cObses       = TratarNulo(obses,      "C")
150:                 THIS.this_dPrazoents   = TratarNulo(prazoents,  "D")
151:                 THIS.this_cMascnum     = TratarNulo(mascnum,    "C")
152:                 THIS.this_cNotas       = TratarNulo(notas,      "C")
153:                 THIS.this_lChksubn     = ConverterParaLogico(chksubn)
154:                 THIS.this_lChkBxParcs  = ConverterParaLogico(chkbxparcs)
155:                 THIS.this_cEmpdopnums  = ALLTRIM(THIS.this_cEmps) + ;
156:                                          ALLTRIM(THIS.this_cDopes) + ;
157:                                          STR(THIS.this_nNumes, 6)

--- BO Linhas 418 a 428 ---
418:     PROTECTED PROCEDURE ExecutarAtualizacao()
419:         LOCAL loc_lResultado, loc_cSQL
420:         loc_lResultado = .F.
421:         TRY
422:             loc_cSQL = "UPDATE SigMvPec SET" + ;
423:                        " grupoos = " + EscaparSQL(THIS.this_cGrupoOs) + "," + ;
424:                        " contaos = " + EscaparSQL(THIS.this_cContaOs) + "," + ;
425:                        " grupods = " + EscaparSQL(THIS.this_cGrupoDs) + "," + ;
426:                        " contads = " + EscaparSQL(THIS.this_cContaDs) + "," + ;
427:                        " datas   = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
428:                        " tabds   = " + EscaparSQL(THIS.this_cTabds) + "," + ;

--- BO Linhas 419 a 429 ---
419:         LOCAL loc_lResultado, loc_cSQL
420:         loc_lResultado = .F.
421:         TRY
422:             loc_cSQL = "UPDATE SigMvPec SET" + ;
423:                        " grupoos = " + EscaparSQL(THIS.this_cGrupoOs) + "," + ;
424:                        " contaos = " + EscaparSQL(THIS.this_cContaOs) + "," + ;
425:                        " grupods = " + EscaparSQL(THIS.this_cGrupoDs) + "," + ;
426:                        " contads = " + EscaparSQL(THIS.this_cContaDs) + "," + ;
427:                        " datas   = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
428:                        " tabds   = " + EscaparSQL(THIS.this_cTabds) + "," + ;
429:                        " notas   = " + EscaparSQL(THIS.this_cNotas) + "," + ;

--- BO Linhas 420 a 430 ---
420:         loc_lResultado = .F.
421:         TRY
422:             loc_cSQL = "UPDATE SigMvPec SET" + ;
423:                        " grupoos = " + EscaparSQL(THIS.this_cGrupoOs) + "," + ;
424:                        " contaos = " + EscaparSQL(THIS.this_cContaOs) + "," + ;
425:                        " grupods = " + EscaparSQL(THIS.this_cGrupoDs) + "," + ;
426:                        " contads = " + EscaparSQL(THIS.this_cContaDs) + "," + ;
427:                        " datas   = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
428:                        " tabds   = " + EscaparSQL(THIS.this_cTabds) + "," + ;
429:                        " notas   = " + EscaparSQL(THIS.this_cNotas) + "," + ;
430:                        " vends   = " + EscaparSQL(THIS.this_cVends) + "," + ;

--- BO Linhas 421 a 431 ---
421:         TRY
422:             loc_cSQL = "UPDATE SigMvPec SET" + ;
423:                        " grupoos = " + EscaparSQL(THIS.this_cGrupoOs) + "," + ;
424:                        " contaos = " + EscaparSQL(THIS.this_cContaOs) + "," + ;
425:                        " grupods = " + EscaparSQL(THIS.this_cGrupoDs) + "," + ;
426:                        " contads = " + EscaparSQL(THIS.this_cContaDs) + "," + ;
427:                        " datas   = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
428:                        " tabds   = " + EscaparSQL(THIS.this_cTabds) + "," + ;
429:                        " notas   = " + EscaparSQL(THIS.this_cNotas) + "," + ;
430:                        " vends   = " + EscaparSQL(THIS.this_cVends) + "," + ;
431:                        " grvends = " + EscaparSQL(THIS.this_cGrvends) + "," + ;

--- BO Linhas 423 a 433 ---
423:                        " grupoos = " + EscaparSQL(THIS.this_cGrupoOs) + "," + ;
424:                        " contaos = " + EscaparSQL(THIS.this_cContaOs) + "," + ;
425:                        " grupods = " + EscaparSQL(THIS.this_cGrupoDs) + "," + ;
426:                        " contads = " + EscaparSQL(THIS.this_cContaDs) + "," + ;
427:                        " datas   = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
428:                        " tabds   = " + EscaparSQL(THIS.this_cTabds) + "," + ;
429:                        " notas   = " + EscaparSQL(THIS.this_cNotas) + "," + ;
430:                        " vends   = " + EscaparSQL(THIS.this_cVends) + "," + ;
431:                        " grvends = " + EscaparSQL(THIS.this_cGrvends) + "," + ;
432:                        " prazoents = " + FormatarDataSQL(THIS.this_dPrazoents) + ;
433:                        " WHERE empdopnums = " + EscaparSQL(THIS.this_cEmpdopnums)

--- BO Linhas 424 a 434 ---
424:                        " contaos = " + EscaparSQL(THIS.this_cContaOs) + "," + ;
425:                        " grupods = " + EscaparSQL(THIS.this_cGrupoDs) + "," + ;
426:                        " contads = " + EscaparSQL(THIS.this_cContaDs) + "," + ;
427:                        " datas   = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
428:                        " tabds   = " + EscaparSQL(THIS.this_cTabds) + "," + ;
429:                        " notas   = " + EscaparSQL(THIS.this_cNotas) + "," + ;
430:                        " vends   = " + EscaparSQL(THIS.this_cVends) + "," + ;
431:                        " grvends = " + EscaparSQL(THIS.this_cGrvends) + "," + ;
432:                        " prazoents = " + FormatarDataSQL(THIS.this_dPrazoents) + ;
433:                        " WHERE empdopnums = " + EscaparSQL(THIS.this_cEmpdopnums)
434:             IF SQLEXEC(gnConnHandle, loc_cSQL) > 0

--- BO Linhas 425 a 435 ---
425:                        " grupods = " + EscaparSQL(THIS.this_cGrupoDs) + "," + ;
426:                        " contads = " + EscaparSQL(THIS.this_cContaDs) + "," + ;
427:                        " datas   = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
428:                        " tabds   = " + EscaparSQL(THIS.this_cTabds) + "," + ;
429:                        " notas   = " + EscaparSQL(THIS.this_cNotas) + "," + ;
430:                        " vends   = " + EscaparSQL(THIS.this_cVends) + "," + ;
431:                        " grvends = " + EscaparSQL(THIS.this_cGrvends) + "," + ;
432:                        " prazoents = " + FormatarDataSQL(THIS.this_dPrazoents) + ;
433:                        " WHERE empdopnums = " + EscaparSQL(THIS.this_cEmpdopnums)
434:             IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
435:                 THIS.RegistrarAuditoria("UPDATE")

--- BO Linhas 426 a 436 ---
426:                        " contads = " + EscaparSQL(THIS.this_cContaDs) + "," + ;
427:                        " datas   = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
428:                        " tabds   = " + EscaparSQL(THIS.this_cTabds) + "," + ;
429:                        " notas   = " + EscaparSQL(THIS.this_cNotas) + "," + ;
430:                        " vends   = " + EscaparSQL(THIS.this_cVends) + "," + ;
431:                        " grvends = " + EscaparSQL(THIS.this_cGrvends) + "," + ;
432:                        " prazoents = " + FormatarDataSQL(THIS.this_dPrazoents) + ;
433:                        " WHERE empdopnums = " + EscaparSQL(THIS.this_cEmpdopnums)
434:             IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
435:                 THIS.RegistrarAuditoria("UPDATE")
436:                 loc_lResultado = .T.

--- BO Linhas 427 a 437 ---
427:                        " datas   = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
428:                        " tabds   = " + EscaparSQL(THIS.this_cTabds) + "," + ;
429:                        " notas   = " + EscaparSQL(THIS.this_cNotas) + "," + ;
430:                        " vends   = " + EscaparSQL(THIS.this_cVends) + "," + ;
431:                        " grvends = " + EscaparSQL(THIS.this_cGrvends) + "," + ;
432:                        " prazoents = " + FormatarDataSQL(THIS.this_dPrazoents) + ;
433:                        " WHERE empdopnums = " + EscaparSQL(THIS.this_cEmpdopnums)
434:             IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
435:                 THIS.RegistrarAuditoria("UPDATE")
436:                 loc_lResultado = .T.
437:             ELSE


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\cadastros\Formsigpres2.prg
- BO: C:\4c\projeto\app\classes\sigpres2BO.prg
