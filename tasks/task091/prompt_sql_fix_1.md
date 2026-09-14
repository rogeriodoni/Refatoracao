CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~2741: Coluna 'sqtds' NAO EXISTE na tabela 'sigopetq' (referenciada como a.sqtds)


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigopetq
CREATE TABLE [dbo].[SigOpEtq](
	[cbars] [numeric](14, 0) NOT NULL,
	[contas] [char](10) NOT NULL,
	[cpros] [char](14) NOT NULL,
	[datas] [datetime] NULL,
	[dopeos] [char](20) NOT NULL,
	[dopes] [char](20) NOT NULL,
	[empos] [char](3) NOT NULL,
	[emps] [char](3) NOT NULL,
	[grupos] [char](10) NOT NULL,
	[nops] [numeric](10, 0) NOT NULL,
	[numeos] [numeric](6, 0) NOT NULL,
	[numes] [numeric](6, 0) NOT NULL,
	[pesos] [numeric](9, 3) NOT NULL,
	[qtds] [numeric](9, 3) NOT NULL,
	[transps] [bit] NOT NULL,
	[usados] [bit] NOT NULL,
	[usuars] [char](10) NOT NULL,
	[datatrans] [datetime] NULL,
	[locals] [char](10) NOT NULL,
	[ntrans] [numeric](6, 0) NOT NULL,
	[obsetiqs] [char](10) NOT NULL,
	[codcors] [char](4) NOT NULL,
	[codtams] [char](4) NOT NULL,
	[localizas] [char](10) NOT NULL,
	[dtmovs] [datetime] NULL,
	[dtbals] [datetime] NULL,
	[peso2s] [numeric](9, 3) NOT NULL,
	[empdopnums] [char](29) NOT NULL,
	[dtincs] [datetime] NULL,
	[pesoms] [numeric](9, 3) NOT NULL,
	[usulibs] [char](10) NOT NULL,
	[apesos] [numeric](9, 3) NOT NULL,
	[aqtds] [numeric](9, 3) NOT NULL,
	[codamss] [char](24) NOT NULL,
	[custofs] [numeric](10, 2) NOT NULL,
	[vlrpromo] [numeric](12, 2) NOT NULL,
	[moedapromo] [char](3) NOT NULL,
	[moeentrada] [char](3) NOT NULL,
	[moesaida] [char](3) NOT NULL,
	[vlrentrada] [numeric](15, 4) NOT NULL,
	[vlrsaida] [numeric](15, 4) NOT NULL,
	[cotentrada] [numeric](15, 6) NOT NULL,
	[cotsaida] [numeric](15, 6) NOT NULL,
	[vlrconvert] [numeric](15, 4) NOT NULL,
	[cotconvert] [numeric](15, 6) NOT NULL,
	[moeconvert] [char](3) NOT NULL,
	[tbdwbi] [char](20) NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\relatorios\FormSigReEtl.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SigReEtlBO.prg):

--- BO Linhas 287 a 297 ---
287:                     "FROM SigOpEtq A " + ;
288:                     "LEFT JOIN (SELECT Cpros,Cgrus,Mercs,Colecoes,SGrus,IFors FROM SigCdPro) B " + ;
289:                     "ON b.cpros = a.cpros " + ;
290:                     "WHERE " + loc_cWhere + "GROUP BY A.localizas"
291: 
292:                 loc_cSQL2 = "SELECT a.locals, SUM(a.sqtds) AS qtde, 1 AS agrupar, SPACE(100) AS Descrs " + ;
293:                     "FROM SigMvesl a, SigCdpro b " + ;
294:                     "WHERE a.CPros = b.Cpros AND " + loc_cWhere2 + ;
295:                     "AND a.Locals NOT IN(" + ;
296:                     "SELECT localizas FROM SigOpEtq A " + ;
297:                     "LEFT JOIN (SELECT Cpros,Cgrus,Mercs,Colecoes,SGrus,IFors FROM SigCdPro) B " + ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\relatorios\FormSigReEtl.prg
- BO: C:\4c\projeto\app\classes\SigReEtlBO.prg
