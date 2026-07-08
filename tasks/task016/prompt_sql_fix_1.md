CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~4284: INSERT coluna '" + loc_ccols + "' NAO EXISTE na tabela 'sigcdgcr'


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigcdgcr
CREATE TABLE [dbo].[SigCdGcr](
	[gerbals] [numeric](1, 0) NOT NULL,
	[cargos] [numeric](1, 0) NOT NULL,
	[cepobris] [numeric](1, 0) NOT NULL,
	[classes] [char](10) NOT NULL,
	[codigos] [char](10) NOT NULL,
	[coletors] [numeric](2, 0) NOT NULL,
	[comis] [numeric](1, 0) NOT NULL,
	[cpfobrigs] [numeric](1, 0) NOT NULL,
	[dadcoms] [numeric](1, 0) NOT NULL,
	[descrs] [char](40) NOT NULL,
	[dgcods] [char](1) NOT NULL,
	[fiscais] [numeric](1, 0) NOT NULL,
	[followups] [numeric](1, 0) NOT NULL,
	[internos] [char](20) NOT NULL,
	[limcres] [numeric](1, 0) NOT NULL,
	[pessoais] [numeric](1, 0) NOT NULL,
	[refbancs] [numeric](1, 0) NOT NULL,
	[respos] [numeric](1, 0) NOT NULL,
	[tpcads] [numeric](1, 0) NOT NULL,
	[tpcods] [numeric](1, 0) NOT NULL,
	[tpemps] [numeric](1, 0) NOT NULL,
	[mfotos] [numeric](1, 0) NOT NULL,
	[grufals] [char](10) NOT NULL,
	[contconts] [char](9) NOT NULL,
	[intconts] [numeric](1, 0) NOT NULL,
	[contabs] [numeric](1, 0) NOT NULL,
	[empresas] [numeric](1, 0) NOT NULL,
	[estoques] [numeric](1, 0) NOT NULL,
	[calcsalds] [numeric](1, 0) NOT NULL,
	[unifbals] [numeric](1, 0) NOT NULL,
	[complems] [numeric](1, 0) NOT NULL,
	[emprelevs] [numeric](1, 0) NOT NULL,
	[balfalpers] [numeric](1, 0) NOT NULL,
	[limestoqs] [numeric](1, 0) NOT NULL,
	[blqdivops] [numeric](1, 0) NOT NULL,
	[ccustos] [numeric](1, 0) NOT NULL,
	[ddfutus] [numeric](5, 0) NOT NULL,
	[ddretros] [numeric](5, 0) NOT NULL,
	[verests] [numeric](1, 0) NOT NULL,
	[blqcongvs] [numeric](1, 0) NOT NULL,
	[tipoinvs] [numeric](1, 0) NOT NULL,
	[caracteris] [numeric](1, 0) NOT NULL,
	[observas] [numeric](1, 0) NOT NULL,
	[chklimcrds] [numeric](1, 0) NOT NULL,
	[chklimests] [numeric](1, 0) NOT NULL,
	[infcads] [numeric](1, 0) NOT NULL,
	[osalfuns] [char](3) NOT NULL,
	[patrietqs] [numeric](1, 0) NOT NULL,
	[rgobrigs] [numeric](1, 0) NOT NULL,
	[calcimeds] [numeric](1, 0) NOT NULL,
	[ddsems] [numeric](1, 0) NOT NULL,
	[hordd] [numeric](4, 2) NOT NULL,
	[tpprecos] [numeric](1, 0) NOT NULL,
	[commoedas] [char](3) NOT NULL,
	[chktits] [numeric](1, 0) NOT NULL,
	[ospends] [numeric](1, 0) NOT NULL,
	[compagrus] [numeric](1, 0) NOT NULL,
	[trfpesas] [numeric](1, 0) NOT NULL,
	[difpesags] [numeric](9, 3) NOT NULL,
	[fichatecs] [numeric](1, 0) NOT NULL,
	[pqs] [char](1) NOT NULL,
	[sinals] [numeric](1, 0) NOT NULL,
	[grupolms] [char](10) NOT NULL,
	[agrupas] [char](10) NULL,
	[rodrelcc] [text] NULL,
	[padpgrecs] [numeric](1, 0) NOT NULL,
	[chkendds] [numeric](1, 0) NOT NULL,
	[chkendrs] [numeric](1, 0) NOT NULL,
	[ctrlotes] [numeric](1, 0) NOT NULL,
	[cfgcdgcr] [char](40) NOT NULL,
	[cfgfiscos] [char](50) NOT NULL,
	[cfgfiscss] [char](50) NOT NULL,
	[cfgfisics] [char](50) NOT NULL,
	[cfgfisiis] [char](50) NOT NULL,
	[cfgfisins] [char](50) NOT NULL,
	[cfgfisips] [char](50) NOT NULL,
	[cfgfisirs] [char](50) NOT NULL,
	[cfgfisiss] [char](50) NOT NULL,
	[cfgfispis] [char](50) NOT NULL,
	[titbaixado] [numeric](1, 0) NOT
-- (truncado)


## Trechos relevantes do Form (C:\4c\projeto\app\forms\cadastros\Formccr.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\ccrBO.prg):


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\cadastros\Formccr.prg
- BO: C:\4c\projeto\app\classes\ccrBO.prg
