CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~3455: INSERT coluna '" + loc_ccols + "' NAO EXISTE na tabela 'sigcdope'


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigcdope
CREATE TABLE [dbo].[SigCdOpe](
	[pedclis] [numeric](1, 0) NOT NULL,
	[zerqtds] [numeric](1, 0) NOT NULL,
	[valinotas] [numeric](1, 0) NOT NULL,
	[dopeetrfs] [char](20) NOT NULL,
	[valitems] [numeric](1, 0) NOT NULL,
	[exibsits] [numeric](1, 0) NOT NULL,
	[chkqtds] [numeric](1, 0) NOT NULL,
	[dtcontab] [numeric](1, 0) NOT NULL,
	[abrevs] [char](3) NOT NULL,
	[altdescs] [numeric](1, 0) NOT NULL,
	[antecs] [numeric](1, 0) NOT NULL,
	[aptpfats] [numeric](1, 0) NOT NULL,
	[arreds] [numeric](1, 0) NOT NULL,
	[baixasns] [numeric](1, 0) NOT NULL,
	[bxautos] [numeric](1, 0) NOT NULL,
	[bxparcials] [numeric](1, 0) NOT NULL,
	[cadclis] [numeric](1, 0) NOT NULL,
	[caixas] [numeric](1, 0) NOT NULL,
	[calcfecs] [numeric](1, 0) NOT NULL,
	[carnes] [numeric](1, 0) NOT NULL,
	[ccentrals] [char](2) NOT NULL,
	[ccomis] [numeric](1, 0) NOT NULL,
	[cdesps] [numeric](1, 0) NOT NULL,
	[chdtentrs] [numeric](1, 0) NOT NULL,
	[cheqs] [numeric](1, 0) NOT NULL,
	[cmoes] [char](3) NOT NULL,
	[cnopes] [char](10) NOT NULL,
	[codbars] [numeric](1, 0) NOT NULL,
	[comcargs] [numeric](1, 0) NOT NULL,
	[condests] [char](10) NOT NULL,
	[condsubs] [numeric](1, 0) NOT NULL,
	[confes] [numeric](1, 0) NOT NULL,
	[conorigs] [char](10) NOT NULL,
	[conosubs] [numeric](1, 0) NOT NULL,
	[consclis] [numeric](1, 0) NOT NULL,
	[consers] [numeric](1, 0) NOT NULL,
	[consgs] [numeric](1, 0) NOT NULL,
	[contas] [char](10) NOT NULL,
	[copers] [numeric](1, 0) NOT NULL,
	[crepls] [numeric](1, 0) NOT NULL,
	[ctipos] [numeric](1, 0) NOT NULL,
	[cupfis] [numeric](1, 0) NOT NULL,
	[datatrans] [datetime] NULL,
	[deacrs] [numeric](1, 0) NOT NULL,
	[desmembs] [numeric](1, 0) NOT NULL,
	[destinos] [numeric](1, 0) NOT NULL,
	[dfpags] [numeric](1, 0) NOT NULL,
	[digdoc] [numeric](1, 0) NOT NULL,
	[digitens] [numeric](1, 0) NOT NULL,
	[digobs] [numeric](1, 0) NOT NULL,
	[docus] [numeric](2, 0) NOT NULL,
	[dopes] [char](20) NOT NULL,
	[dtentrs] [numeric](1, 0) NOT NULL,
	[edcotas] [numeric](1, 0) NOT NULL,
	[edtpfats] [numeric](1, 0) NOT NULL,
	[efators] [numeric](1, 0) NOT NULL,
	[emppads] [char](3) NOT NULL,
	[epesos] [numeric](1, 0) NOT NULL,
	[eprecos] [numeric](1, 0) NOT NULL,
	[estdests] [numeric](1, 0) NOT NULL,
	[estoqs] [numeric](1, 0) NOT NULL,
	[estorigs] [numeric](1, 0) NOT NULL,
	[expends] [numeric](1, 0) NOT NULL,
	[fatauts] [numeric](1, 0) NOT NULL,
	[fixcdests] [bit] NOT NULL,
	[fixcnopes] [bit] NOT NULL,
	[fixcorigs] [bit] NOT NULL,
	[fixgdests] [bit] NOT NULL,
	[fixgorigs] [bit] NOT NULL,
	[fixgropes] [bit] NOT NULL,
	[fixgvends] [bit] NOT NULL,
	[globalizas] [numeric](1, 0) NOT NULL,
	[grudests] [char](10) NOT NULL,
	[gruorigs] [char](10) NOT NULL,
	[grupos] [char](10) NOT NULL,
	[grvends] [char](20) NOT NULL,
	[imagems] [numeric](1, 0) NOT NULL,
	[itautos] [numeric](2, 0) NOT NULL,
	[itemalfas] [numeric](1, 0) NOT NULL,
	[itemzeros] [numeric](1, 0) NOT NULL,
	[limcres] [numeric](1, 0) NOT NULL,
	[limpauts] [numer
-- (truncado)


## Trechos relevantes do Form (C:\4c\projeto\app\forms\cadastros\FormOPE.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\OPEBO.prg):


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\cadastros\FormOPE.prg
- BO: C:\4c\projeto\app\classes\OPEBO.prg
