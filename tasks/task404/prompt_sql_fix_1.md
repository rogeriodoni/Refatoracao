CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~6942: INSERT coluna '" + loc_ccols + "' NAO EXISTE na tabela 'sigcdemp'


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigcdemp
CREATE TABLE [dbo].[sigcdemp](
	[codemps] [numeric](4, 0) NOT NULL,
	[bairs] [char](40) NOT NULL,
	[cautos] [char](1) NOT NULL,
	[cemps] [char](3) NOT NULL,
	[ceps] [char](9) NOT NULL,
	[cidas] [char](30) NOT NULL,
	[comiss] [numeric](1, 0) NOT NULL,
	[dircolins] [char](254) NOT NULL,
	[dircolouts] [char](254) NOT NULL,
	[dirs] [char](30) NOT NULL,
	[drivels] [char](60) NOT NULL,
	[drivers] [char](60) NOT NULL,
	[drivets] [char](60) NOT NULL,
	[empofs] [char](3) NOT NULL,
	[endes] [char](60) NOT NULL,
	[estas] [char](2) NOT NULL,
	[etpads] [numeric](1, 0) NOT NULL,
	[faxs] [char](20) NOT NULL,
	[impcars] [char](1) NOT NULL,
	[modems] [numeric](1, 0) NOT NULL,
	[naudits] [numeric](6, 0) NOT NULL,
	[nums] [char](21) NOT NULL,
	[obs] [char](150) NOT NULL,
	[obsetiqs] [char](1) NOT NULL,
	[paths] [char](60) NOT NULL,
	[prget1s] [char](8) NOT NULL,
	[prget2s] [char](8) NOT NULL,
	[prins] [char](15) NOT NULL,
	[razas] [char](40) NOT NULL,
	[rectrans] [numeric](4, 0) NOT NULL,
	[tel1s] [char](20) NOT NULL,
	[tel2s] [char](20) NOT NULL,
	[tiponfs] [numeric](1, 0) NOT NULL,
	[tipos] [char](10) NOT NULL,
	[transps] [numeric](4, 0) NOT NULL,
	[verests] [numeric](1, 0) NOT NULL,
	[cgcs] [char](20) NOT NULL,
	[emplivros] [char](3) NOT NULL,
	[pfiscals] [char](15) NOT NULL,
	[altmovtrs] [numeric](1, 0) NOT NULL,
	[ativas] [numeric](1, 0) NOT NULL,
	[empconts] [char](3) NOT NULL,
	[razsocs] [char](50) NOT NULL,
	[adics] [numeric](2, 0) NOT NULL,
	[arqcnabs] [char](20) NOT NULL,
	[clrarqs] [numeric](3, 0) NOT NULL,
	[colexes] [char](80) NOT NULL,
	[dirftpls] [char](60) NOT NULL,
	[dirftpts] [char](60) NOT NULL,
	[dope_int] [char](20) NOT NULL,
	[ftpdel] [bit] NOT NULL,
	[ftpend] [char](50) NOT NULL,
	[ftpsenha] [char](20) NOT NULL,
	[ftpusuario] [char](20) NOT NULL,
	[ies] [char](15) NOT NULL,
	[lnaotransp] [bit] NOT NULL,
	[locdel] [bit] NOT NULL,
	[nemps] [numeric](3, 0) NOT NULL,
	[numeros] [char](10) NOT NULL,
	[supervs] [char](10) NOT NULL,
	[tpconexao] [char](1) NOT NULL,
	[tpemps] [numeric](1, 0) NOT NULL,
	[agencs] [char](5) NOT NULL,
	[anavends] [numeric](1, 0) NOT NULL,
	[bancs] [char](4) NOT NULL,
	[calccustos] [numeric](1, 0) NOT NULL,
	[cfis_int] [char](10) NOT NULL,
	[class] [char](15) NOT NULL,
	[confranqs] [char](10) NOT NULL,
	[contas] [char](11) NOT NULL,
	[contfins] [char](50) NOT NULL,
	[ddd1s] [char](4) NOT NULL,
	[ddd2s] [char](4) NOT NULL,
	[difpes] [char](1) NOT NULL,
	[divnotas] [numeric](1, 0) NOT NULL,
	[ean13] [numeric](13, 0) NOT NULL,
	[empbxfs] [char](3) NOT NULL,
	[grufranqs] [char](10) NOT NULL,
	[grupo] [char](15) NOT NULL,
	[ims] [char](15) NOT NULL,
	[nfshora1s] [numeric](3, 0) NOT NULL,
	[ordems] [numeric](3, 0) NOT NULL,
	[perccrs] [numeric](5, 2) NOT NULL,
	[pplinha1s] [char](16) NOT NULL,
	[pplinha2s] [char](16) NOT NULL,
	[ramal1s] [char](4) NOT NULL,
	[ramal2s] [char](4) NOT NULL,
	[regiaos] [char](10) NOT NULL,
	[resp_cargo] [char](
-- (truncado)


## Trechos relevantes do Form (C:\4c\projeto\app\forms\cadastros\Formemp.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\empBO.prg):


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\cadastros\Formemp.prg
- BO: C:\4c\projeto\app\classes\empBO.prg
