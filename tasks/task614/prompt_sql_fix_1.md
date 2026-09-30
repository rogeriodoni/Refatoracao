CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1666: INSERT na tabela 'sigtempd' OMITE coluna(s) NOT NULL sem DEFAULT: dpros. O SQL Server recusa o INSERT inteiro. Acrescentar as colunas que faltam (NAO trocar as existentes - cuidado com colunas gemeas de nome parecido). Preenchimento: cidchaves/pkchaves = EscaparSQL(fUniqueIds()) (NUNCA string vazia); usuars/usualts = gc_4c_UsuarioLogado; com property no BO = a property; char sem property = EscaparSQL(''); numeric = FormatarNumeroSQL(0, <decimais>); bit = 0; datetime = sentinela '19000101'.
- [SQL-SCHEMA] Linha ~1680: INSERT na tabela 'sigtempd' OMITE coluna(s) NOT NULL sem DEFAULT: dpros. O SQL Server recusa o INSERT inteiro. Acrescentar as colunas que faltam (NAO trocar as existentes - cuidado com colunas gemeas de nome parecido). Preenchimento: cidchaves/pkchaves = EscaparSQL(fUniqueIds()) (NUNCA string vazia); usuars/usualts = gc_4c_UsuarioLogado; com property no BO = a property; char sem property = EscaparSQL(''); numeric = FormatarNumeroSQL(0, <decimais>); bit = 0; datetime = sentinela '19000101'.


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigtempd
CREATE TABLE [dbo].[SIGTEMPD](
	[cbars] [int] NULL,
	[cgrus] [char](3) NULL,
	[cidchaves] [char](64) NOT NULL,
	[cidquerys] [char](20) NULL,
	[cpros] [char](10) NULL,
	[empdopnums] [char](29) NULL,
	[empos] [char](3) NULL,
	[qtds] [numeric](11, 2) NULL,
	[cmoes] [char](3) NULL,
	[cnsuadms] [char](20) NULL,
	[codobs] [numeric](3, 0) NULL,
	[contas] [char](10) NULL,
	[datas] [datetime] NULL,
	[dgopes] [char](20) NULL,
	[dopes] [char](20) NULL,
	[dpros] [char](65) NOT NULL,
	[dtalts] [datetime] NULL,
	[empdopnum2] [char](29) NULL,
	[empgruests] [char](23) NULL,
	[emps] [char](3) NULL,
	[grupos] [char](10) NULL,
	[mascnum] [char](10) NULL,
	[nopers] [numeric](7, 0) NULL,
	[numes] [numeric](6, 0) NULL,
	[obss] [text] NULL,
	[opers] [char](1) NULL,
	[razas] [char](40) NULL,
	[valors] [numeric](15, 2) NULL,
	[valpres] [numeric](10, 0) NULL,
	[descrs] [char](80) NULL,
	[newfld] [char](10) NULL,
	[vars] [numeric](9, 4) NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormSigPrGl2.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SigPrGl2BO.prg):


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormSigPrGl2.prg
- BO: C:\4c\projeto\app\classes\SigPrGl2BO.prg
