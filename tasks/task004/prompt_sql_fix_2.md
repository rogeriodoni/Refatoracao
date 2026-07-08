CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~2980: INSERT coluna '" + ;                 "emps' NAO EXISTE na tabela 'sigmvccr'
- [SQL-SCHEMA] Linha ~2980: INSERT coluna '" + ;                 " datas' NAO EXISTE na tabela 'sigmvccr'
- [SQL-SCHEMA] Linha ~2980: INSERT coluna '" + ;                 " opers' NAO EXISTE na tabela 'sigmvccr'
- [SQL-SCHEMA] Linha ~2980: INSERT coluna '" + ;                 " sopers' NAO EXISTE na tabela 'sigmvccr'
- [SQL-SCHEMA] Linha ~2980: INSERT coluna '" + ;                 " hists' NAO EXISTE na tabela 'sigmvccr'
- [SQL-SCHEMA] Linha ~2980: INSERT coluna '" + ;                 " jobs' NAO EXISTE na tabela 'sigmvccr'
- [SQL-SCHEMA] Linha ~2980: INSERT coluna '" + ;                 " usualts' NAO EXISTE na tabela 'sigmvccr'
- [SQL-SCHEMA] Linha ~2980: INSERT coluna '" + ;                 " usuconcs' NAO EXISTE na tabela 'sigmvccr'
- [SQL-SCHEMA] Linha ~2980: INSERT coluna '" + ;                 " contapgs' NAO EXISTE na tabela 'sigmvccr'
- [SQL-SCHEMA] Linha ~2980: INSERT coluna '" + ;                 " cotusus' NAO EXISTE na tabela 'sigmvccr'
- [SQL-SCHEMA] Linha ~2980: INSERT coluna '" + ;                 " locals' NAO EXISTE na tabela 'sigmvccr'
- [SQL-SCHEMA] Linha ~2980: INSERT coluna '" + ;                 " titulos' NAO EXISTE na tabela 'sigmvccr'
- [SQL-SCHEMA] Linha ~2980: INSERT coluna '" + ;                 " bcontas' NAO EXISTE na tabela 'sigmvccr'
- [SQL-SCHEMA] Linha ~2980: INSERT coluna '" + ;                 " saldos' NAO EXISTE na tabela 'sigmvccr'
- [SQL-SCHEMA] Linha ~2980: INSERT coluna '" + ;                 " empdopncs' NAO EXISTE na tabela 'sigmvccr'
- [SQL-SCHEMA] Linha ~2980: INSERT coluna '" + ;                 " titcancs' NAO EXISTE na tabela 'sigmvccr'
- [SQL-SCHEMA] Linha ~2980: INSERT coluna '" + ;                 " impostos' NAO EXISTE na tabela 'sigmvccr'
- [SQL-SCHEMA] Linha ~2980: INSERT coluna '" + ;                 " compet' NAO EXISTE na tabela 'sigmvccr'
- [SQL-SCHEMA] Linha ~2980: INSERT coluna '" + ;                 " nlancs' NAO EXISTE na tabela 'sigmvccr'
- [SQL-SCHEMA] Linha ~2980: INSERT coluna 'usuexcs" + ;                 "' NAO EXISTE na tabela 'sigmvccr'


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigmvccr
CREATE TABLE [dbo].[SigMvCcr](
	[autos] [bit] NOT NULL,
	[concs] [bit] NOT NULL,
	[contages] [char](10) NOT NULL,
	[contas] [char](10) NOT NULL,
	[contems] [char](10) NOT NULL,
	[cotacaos] [numeric](15, 7) NOT NULL,
	[datalts] [datetime] NULL,
	[datas] [datetime] NULL,
	[dataconcs] [datetime] NULL,
	[datatrans] [datetime] NULL,
	[datexcs] [datetime] NULL,
	[docus] [char](10) NOT NULL,
	[dopes] [char](20) NOT NULL,
	[dtemis] [datetime] NULL,
	[emps] [char](3) NOT NULL,
	[grupages] [char](10) NOT NULL,
	[grupems] [char](10) NOT NULL,
	[grupos] [char](10) NOT NULL,
	[hists] [char](60) NULL,
	[locals] [char](10) NOT NULL,
	[moedas] [char](3) NOT NULL,
	[nfs] [char](10) NOT NULL,
	[nlancs] [numeric](6, 0) NOT NULL,
	[nopers] [numeric](7, 0) NOT NULL,
	[ntrans] [numeric](6, 0) NOT NULL,
	[numes] [numeric](6, 0) NOT NULL,
	[opers] [char](1) NOT NULL,
	[saldocs] [numeric](15, 2) NOT NULL,
	[saldons] [numeric](15, 2) NOT NULL,
	[saldos] [numeric](15, 2) NOT NULL,
	[scontas] [char](10) NOT NULL,
	[scotacaos] [numeric](15, 7) NOT NULL,
	[sgrupos] [char](10) NOT NULL,
	[shists] [char](40) NOT NULL,
	[smoedas] [char](3) NOT NULL,
	[sopers] [char](1) NOT NULL,
	[svalors] [numeric](11, 2) NOT NULL,
	[tipos] [char](1) NOT NULL,
	[titbans] [char](12) NOT NULL,
	[titulos] [char](10) NOT NULL,
	[usualts] [char](10) NOT NULL,
	[usuexcs] [char](10) NOT NULL,
	[valliqs] [numeric](11, 2) NOT NULL,
	[valocurs] [numeric](11, 2) NOT NULL,
	[valors] [numeric](11, 2) NOT NULL,
	[valpags] [numeric](11, 2) NOT NULL,
	[vencs] [datetime] NULL,
	[vlancs] [char](10) NOT NULL,
	[vopers] [char](13) NOT NULL,
	[contapgs] [numeric](1, 0) NOT NULL,
	[dopcs] [char](20) NOT NULL,
	[numcs] [numeric](6, 0) NOT NULL,
	[cotusus] [char](10) NOT NULL,
	[bcontas] [char](10) NOT NULL,
	[bgrupos] [char](10) NOT NULL,
	[borderos] [numeric](6, 0) NOT NULL,
	[hist2s] [char](80) NULL,
	[intconts] [numeric](6, 0) NOT NULL,
	[usuconcs] [char](10) NOT NULL,
	[auditors] [char](10) NOT NULL,
	[dtaudits] [datetime] NULL,
	[valprev] [numeric](11, 2) NOT NULL,
	[cidchaves] [char](20) NOT NULL,
	[empdopncs] [char](29) NOT NULL,
	[empdopnums] [char](29) NOT NULL,
	[gruconmoes] [char](23) NOT NULL,
	[pagos] [char](1) NOT NULL,
	[dopotps] [char](23) NOT NULL,
	[usupagos] [char](10) NOT NULL,
	[titcancs] [numeric](1, 0) NOT NULL,
	[dtconfs] [datetime] NULL,
	[usuconfs] [char](10) NOT NULL,
	[nopercancs] [numeric](7, 0) NOT NULL,
	[especienfs] [char](6) NOT NULL,
	[jobs] [char](10) NOT NULL,
	[impostos] [numeric](11, 2) NOT NULL,
	[tpimpostos] [numeric](2, 0) NOT NULL,
	[titpais] [char](10) NOT NULL,
	[empccs] [char](3) NOT NULL,
	[recor] [numeric](1, 0) NOT NULL,
	[compet] [char](7) NOT NULL,
	[empos] [char](3) NOT NULL,
	[oridopnums] [char](29) NOT NULL,
	[pastas] [text] NULL,
	[rcontas] [char](10) NOT NULL,
	[tpdocnf] [char](2) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\cadastros\Formsigmvccr.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\sigmvccrBO.prg):


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\cadastros\Formsigmvccr.prg
- BO: C:\4c\projeto\app\classes\sigmvccrBO.prg
