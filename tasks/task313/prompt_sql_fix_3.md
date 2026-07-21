CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1315: INSERT coluna '" + ;                        loc_ccols1 + loc_ccols2 + loc_ccols3 + loc_ccols4 + "' NAO EXISTE na tabela 'sigmlitn'


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigmlitn
CREATE TABLE [dbo].[SigMlItn](
	[anivfs] [char](5) NOT NULL,
	[anivis] [char](5) NOT NULL,
	[ativos] [bit] NOT NULL,
	[cadas] [char](10) NOT NULL,
	[cemps] [char](3) NOT NULL,
	[cepfs] [char](5) NOT NULL,
	[cepis] [char](5) NOT NULL,
	[cidades] [char](30) NOT NULL,
	[ckanis] [bit] NOT NULL,
	[ckcads] [bit] NOT NULL,
	[ckceps] [bit] NOT NULL,
	[ckcids] [bit] NOT NULL,
	[ckemps] [bit] NOT NULL,
	[ckests] [bit] NOT NULL,
	[ckfnoms] [bit] NOT NULL,
	[cknomes] [bit] NOT NULL,
	[ckprofs] [bit] NOT NULL,
	[ckrsocs] [bit] NOT NULL,
	[cksexs] [bit] NOT NULL,
	[ckults] [bit] NOT NULL,
	[codigos] [char](10) NOT NULL,
	[datalts] [datetime] NULL,
	[datins] [datetime] NULL,
	[demps] [char](40) NOT NULL,
	[descs] [char](30) NOT NULL,
	[destis] [numeric](1, 0) NOT NULL,
	[espelhos] [char](8) NOT NULL,
	[ests] [char](2) NOT NULL,
	[faixafs] [char](20) NOT NULL,
	[faixais] [char](20) NOT NULL,
	[nomes] [char](30) NOT NULL,
	[nregis] [numeric](8, 0) NOT NULL,
	[opsexs] [numeric](1, 0) NOT NULL,
	[optceps] [numeric](1, 0) NOT NULL,
	[optnrs] [numeric](1, 0) NOT NULL,
	[optults] [numeric](1, 0) NOT NULL,
	[profs] [char](30) NOT NULL,
	[rsocs] [char](30) NOT NULL,
	[ults] [datetime] NULL,
	[usualts] [char](10) NOT NULL,
	[usuins] [char](10) NOT NULL,
	[ckclass] [bit] NOT NULL,
	[cksituas] [bit] NOT NULL,
	[classifis] [char](10) NOT NULL,
	[classifss] [char](10) NOT NULL,
	[situas] [numeric](1, 0) NOT NULL,
	[ckregis] [bit] NOT NULL,
	[cksitua] [bit] NOT NULL,
	[opsitua] [numeric](1, 0) NOT NULL,
	[regifs] [char](10) NOT NULL,
	[regiis] [char](10) NOT NULL,
	[situa] [char](3) NOT NULL,
	[linhas] [char](10) NOT NULL,
	[ckcivils] [bit] NOT NULL,
	[opanis] [numeric](1, 0) NOT NULL,
	[ckdtents] [bit] NOT NULL,
	[dtents] [datetime] NULL,
	[cklinhas] [bit] NOT NULL,
	[tabufs] [char](8) NOT NULL,
	[opcivis] [numeric](1, 0) NOT NULL,
	[bairs] [char](40) NOT NULL,
	[ckbairs] [bit] NOT NULL,
	[estados] [char](60) NOT NULL,
	[unificas] [text] NULL,
	[ckvends] [bit] NOT NULL,
	[vends] [char](10) NOT NULL,
	[cclaemp1s] [char](15) NULL,
	[cclaemp2s] [char](15) NULL,
	[cgrpemp1s] [char](15) NULL,
	[cgrpemp2s] [char](15) NULL,
	[cidchaves] [char](20) NOT NULL,
	[ckclagemps] [bit] NULL,
	[ckidade] [bit] NOT NULL,
	[idadefs] [numeric](3, 0) NOT NULL,
	[idadeis] [numeric](3, 0) NOT NULL,
	[opidade] [numeric](1, 0) NOT NULL,
	[cparents] [char](10) NOT NULL,
	[ckdtatus] [bit] NOT NULL,
	[dtatus] [datetime] NULL,
	[opendes] [numeric](1, 0) NOT NULL,
	[cktlmk] [bit] NOT NULL,
	[optlmk] [numeric](1, 0) NOT NULL,
	[ckncomp] [bit] NOT NULL,
	[ckultcom] [bit] NOT NULL,
	[dtultcom] [datetime] NULL,
	[ckpais] [bit] NOT NULL,
	[paises] [char](30) NOT NULL,
	[ckmov] [bit] NOT NULL,
	[datasf] [datetime] NULL,
	[datasi] [datetime] NULL,
	[dopes] [char](20) NOT NULL,
	[endigual] [numeric](1, 0) NOT NULL,
	[mtipomovs] [text] NULL,
	[valosf] [numeric](11, 2) NOT NULL,
	[valosi] [numeric](11, 2) NOT NULL,
	[ckc
-- (truncado)


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormSigPrMlu.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SigPrMluBO.prg):


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormSigPrMlu.prg
- BO: C:\4c\projeto\app\classes\SigPrMluBO.prg
