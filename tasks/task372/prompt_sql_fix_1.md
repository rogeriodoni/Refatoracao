CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~2738: INSERT coluna '" + loc_ccols + "' NAO EXISTE na tabela 'sigcdcli'


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

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


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormCliente.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\ClienteBO.prg):


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormCliente.prg
- BO: C:\4c\projeto\app\classes\ClienteBO.prg
