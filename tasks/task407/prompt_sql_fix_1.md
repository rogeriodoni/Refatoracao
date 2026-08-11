CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~2478: INSERT coluna 'entrabs' NAO EXISTE na tabela 'sigcdnec'
- [SQL-SCHEMA] Linha ~2478: INSERT coluna 'usulins' NAO EXISTE na tabela 'sigcdnec'


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigcdnec
CREATE TABLE [dbo].[SigCdNec](
	[chksubn] [bit] NOT NULL,
	[contads] [char](10) NOT NULL,
	[contaos] [char](10) NOT NULL,
	[datars] [datetime] NULL,
	[datas] [datetime] NULL,
	[datatrans] [datetime] NULL,
	[dopps] [char](20) NOT NULL,
	[emps] [char](3) NOT NULL,
	[grupods] [char](10) NOT NULL,
	[grupoos] [char](10) NOT NULL,
	[grvends] [char](10) NOT NULL,
	[imprs] [bit] NOT NULL,
	[lccs] [bit] NOT NULL,
	[numps] [numeric](10, 0) NOT NULL,
	[obss] [text] NULL,
	[procbals] [bit] NOT NULL,
	[procdbal] [bit] NOT NULL,
	[totpesos] [numeric](11, 3) NOT NULL,
	[usuars] [char](10) NOT NULL,
	[vends] [char](10) NOT NULL,
	[docus] [char](10) NOT NULL,
	[locals] [char](10) NOT NULL,
	[ntrans] [numeric](6, 0) NOT NULL,
	[nops] [numeric](10, 0) NOT NULL,
	[naceites] [numeric](10, 0) NOT NULL,
	[retrabs] [bit] NOT NULL,
	[cidchaves] [char](20) NOT NULL,
	[empdnps] [char](33) NOT NULL,
	[autos] [bit] NOT NULL,
	[libprods] [char](10) NOT NULL,
	[codnconfs] [char](10) NOT NULL,
	[numbalds] [numeric](6, 0) NOT NULL,
	[numbals] [numeric](6, 0) NOT NULL,
	[codobs] [numeric](3, 0) NOT NULL,
	[empds] [char](3) NOT NULL,
	[nconforms] [bit] NOT NULL,
	[nlotes] [numeric](10, 0) NOT NULL,
	[jobs] [char](10) NOT NULL,
	[pesolancs] [numeric](11, 3) NOT NULL,
	[usulibs] [char](10) NOT NULL,
	[chkbaixa] [numeric](1, 0) NOT NULL,
	[usuconfs] [char](10) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\cadastros\Formepd.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\epdBO.prg):

--- BO Linhas 199 a 209 ---
199:             loc_cSQL = "INSERT INTO SigCdNec" + ;
200:                        " (emps, dopps, numps, datas," + ;
201:                        "  grupoos, contaos, grupods, contads," + ;
202:                        "  grvends, vends, empdnps, cidchaves, usuars," + ;
203:                        "  chksubn, totpesos, imprs, lccs, procbals, procdbal," + ;
204:                        "  docus, locals, ntrans, nops, naceites, entrabs," + ;
205:                        "  autos, libprods, codnconfs, numbalds, numbals, codobs," + ;
206:                        "  empds, nconforms, nlotes, jobs, pesolancs, usulins," + ;
207:                        "  chkbaixa, usuconfs)" + ;
208:                        " VALUES (" + ;
209:                        EscaparSQL(THIS.this_cEmps)    + "," + ;

--- BO Linhas 201 a 211 ---
201:                        "  grupoos, contaos, grupods, contads," + ;
202:                        "  grvends, vends, empdnps, cidchaves, usuars," + ;
203:                        "  chksubn, totpesos, imprs, lccs, procbals, procdbal," + ;
204:                        "  docus, locals, ntrans, nops, naceites, entrabs," + ;
205:                        "  autos, libprods, codnconfs, numbalds, numbals, codobs," + ;
206:                        "  empds, nconforms, nlotes, jobs, pesolancs, usulins," + ;
207:                        "  chkbaixa, usuconfs)" + ;
208:                        " VALUES (" + ;
209:                        EscaparSQL(THIS.this_cEmps)    + "," + ;
210:                        EscaparSQL(THIS.this_cDopps)   + "," + ;
211:                        FormatarNumeroSQL(THIS.this_nNumps) + "," + ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\cadastros\Formepd.prg
- BO: C:\4c\projeto\app\classes\epdBO.prg
