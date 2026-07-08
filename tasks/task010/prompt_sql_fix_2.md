CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~4681: INSERT coluna '" + ;                 "codigos' NAO EXISTE na tabela 'sigcdcfo'
- [SQL-SCHEMA] Linha ~4681: INSERT coluna '" + ;                 " icms' NAO EXISTE na tabela 'sigcdcfo'
- [SQL-SCHEMA] Linha ~4681: INSERT coluna '" + ;                 " cfosts' NAO EXISTE na tabela 'sigcdcfo'
- [SQL-SCHEMA] Linha ~4681: INSERT coluna '" + ;                 " incicmnfs' NAO EXISTE na tabela 'sigcdcfo'
- [SQL-SCHEMA] Linha ~4681: INSERT coluna '" + ;                 " ipis' NAO EXISTE na tabela 'sigcdcfo'
- [SQL-SCHEMA] Linha ~4681: INSERT coluna '" + ;                 " acresipis' NAO EXISTE na tabela 'sigcdcfo'
- [SQL-SCHEMA] Linha ~4681: INSERT coluna '" + ;                 " ipicst' NAO EXISTE na tabela 'sigcdcfo'
- [SQL-SCHEMA] Linha ~4681: INSERT coluna '" + ;                 " ctissqn' NAO EXISTE na tabela 'sigcdcfo'
- [SQL-SCHEMA] Linha ~4681: INSERT coluna '" + ;                 " contvcds' NAO EXISTE na tabela 'sigcdcfo'
- [SQL-SCHEMA] Linha ~4681: INSERT coluna '" + ;                 " contfrt' NAO EXISTE na tabela 'sigcdcfo'
- [SQL-SCHEMA] Linha ~4681: INSERT coluna '" + ;                 " pontedescs' NAO EXISTE na tabela 'sigcdcfo'
- [SQL-SCHEMA] Linha ~4681: INSERT coluna '" + ;                 " intvlrcont' NAO EXISTE na tabela 'sigcdcfo'
- [SQL-SCHEMA] Linha ~4681: INSERT coluna '" + ;                 " transps' NAO EXISTE na tabela 'sigcdcfo'
- [SQL-SCHEMA] Linha ~4681: INSERT coluna 'obspads" + ;                 "' NAO EXISTE na tabela 'sigcdcfo'


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigcdcfo
CREATE TABLE [dbo].[SIGCDCFO](
	[contconts] [char](1) NOT NULL,
	[aliqipis] [numeric](4, 2) NOT NULL,
	[codigos] [char](10) NOT NULL,
	[contribs] [char](1) NOT NULL,
	[descricaos] [char](60) NOT NULL,
	[icms] [char](1) NOT NULL,
	[ipis] [char](1) NOT NULL,
	[operacaos] [char](1) NOT NULL,
	[contvcds] [char](9) NOT NULL,
	[contvccs] [char](9) NOT NULL,
	[contipcs] [char](9) NOT NULL,
	[contipds] [char](9) NOT NULL,
	[conticcs] [char](9) NOT NULL,
	[conticds] [char](9) NOT NULL,
	[coddests] [char](10) NOT NULL,
	[ipincreds] [numeric](1, 0) NOT NULL,
	[pontedescs] [numeric](1, 0) NOT NULL,
	[sittribs] [char](3) NOT NULL,
	[aliqivcs] [numeric](4, 2) NOT NULL,
	[ndigitos] [numeric](2, 0) NOT NULL,
	[ipi_icms] [char](1) NOT NULL,
	[inclicms] [numeric](1, 0) NOT NULL,
	[cgergia1s] [char](1) NOT NULL,
	[transps] [numeric](1, 0) NOT NULL,
	[agrupas] [numeric](1, 0) NOT NULL,
	[zeradas] [numeric](1, 0) NOT NULL,
	[icmsdscs] [numeric](1, 0) NOT NULL,
	[inclipis] [numeric](1, 0) NOT NULL,
	[situas] [numeric](1, 0) NOT NULL,
	[bcipis] [char](1) NOT NULL,
	[cfosts] [char](10) NOT NULL,
	[desicms] [numeric](1, 0) NOT NULL,
	[desipis] [numeric](1, 0) NOT NULL,
	[frticms] [numeric](1, 0) NOT NULL,
	[frtipis] [numeric](1, 0) NOT NULL,
	[pbcipis] [numeric](5, 2) NOT NULL,
	[pbcsts] [numeric](5, 2) NOT NULL,
	[segicms] [numeric](1, 0) NOT NULL,
	[segipis] [numeric](1, 0) NOT NULL,
	[subtribs] [char](1) NOT NULL,
	[acresipis] [char](1) NOT NULL,
	[ipiimpors] [char](1) NOT NULL,
	[dtintfis] [numeric](1, 0) NOT NULL,
	[ipiom2s] [char](1) NOT NULL,
	[unitimps] [char](1) NOT NULL,
	[desc2s] [char](60) NOT NULL,
	[intvlrcont] [numeric](1, 0) NOT NULL,
	[intvlricms] [numeric](1, 0) NOT NULL,
	[intvlripi] [numeric](1, 0) NOT NULL,
	[icmsincs] [numeric](1, 0) NOT NULL,
	[incicmnfs] [numeric](1, 0) NOT NULL,
	[tipos] [numeric](1, 0) NOT NULL,
	[utilvars] [numeric](1, 0) NOT NULL,
	[contda] [char](9) NOT NULL,
	[contfrt] [char](9) NOT NULL,
	[contseg] [char](9) NOT NULL,
	[indmov] [numeric](1, 0) NOT NULL,
	[indpagto] [numeric](1, 0) NOT NULL,
	[tiporecs] [numeric](1, 0) NOT NULL,
	[ipicst] [char](2) NOT NULL,
	[piscst] [char](2) NOT NULL,
	[cofcst] [char](2) NOT NULL,
	[issqnl] [char](5) NOT NULL,
	[aliqcofins] [numeric](5, 2) NOT NULL,
	[aliqpis] [numeric](5, 2) NOT NULL,
	[aliqissqn] [numeric](5, 2) NOT NULL,
	[ctissqn] [numeric](1, 0) NOT NULL,
	[rettribs] [numeric](1, 0) NOT NULL,
	[aliqii] [numeric](5, 2) NOT NULL,
	[cfost60s] [char](10) NOT NULL,
	[obspads] [numeric](3, 0) NOT NULL,
	[ipienq] [char](3) NOT NULL,
	[somaicmfrete] [numeric](1, 0) NOT NULL,
	[motdeson] [char](2) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\cadastros\Formcfo.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\cfoBO.prg):


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\cadastros\Formcfo.prg
- BO: C:\4c\projeto\app\classes\cfoBO.prg
