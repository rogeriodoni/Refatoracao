CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~817: Coluna 'empsubns' NAO EXISTE na tabela 'sigopdev' (referenciada como a.EmpSubns)
- [SQL-SCHEMA] Linha ~870: Coluna 'empsubns' NAO EXISTE na tabela 'sigopdev' (referenciada como a.EmpSubns)


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigopdev
CREATE TABLE [dbo].[SigOpDev](
	[tpcodigos] [numeric](1, 0) NOT NULL,
	[valobxs] [numeric](11, 2) NOT NULL,
	[emps] [char](3) NOT NULL,
	[dopes] [char](20) NOT NULL,
	[numes] [numeric](6, 0) NOT NULL,
	[codigos] [numeric](10, 0) NOT NULL,
	[datatrans] [datetime] NULL,
	[ntrans] [numeric](6, 0) NOT NULL,
	[locals] [char](10) NOT NULL,
	[cidchaves] [char](20) NOT NULL,
	[empdopnums] [char](29) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\relatorios\FormSigReJob.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SigReJobBO.prg):

--- BO Linhas 212 a 222 ---
212:         loc_lcQuery = "SELECT a.Emps, a.Dopes, a.Numes, b.Datas, b.Resps, d.RClis, " + ;
213:                       "b.Datars, c.TitOpes " + ;
214:                       "FROM SigMvPec a, SigMvCab b, SigCdOpe c, SigCdCli d " + ;
215:                       "WHERE a.Codigos = " + ALLTRIM(STR(loc_lnCod, 10)) + " AND " + ;
216:                       "a.EmpDopNums = b.EmpDopNums AND " + ;
217:                       "a.EmpSubns = '" + ALLTRIM(TprMvCab.Emps) + "' AND " + ;
218:                       "b.Dopes = c.Dopes AND b.Resps = d.IClis " + ;
219:                       "UNION ALL " + ;
220:                       "SELECT a.Emps, a.Dopes, a.Numes, b.Datas, b.Resps, d.RClis, " + ;
221:                       "b.Datars, c.TitOpes " + ;
222:                       "FROM SigOpDev a, SigMvCab b, SigCdOpe c, SigCdCli d " + ;

--- BO Linhas 265 a 275 ---
265:                 loc_lcQuery = "SELECT a.Emps, a.Dopes, a.Numes, b.Datas, b.Resps, d.RClis, " + ;
266:                               "b.Datars, c.TitOpes " + ;
267:                               "FROM SigMvPec a, SigMvCab b, SigCdOpe c, SigCdCli d " + ;
268:                               "WHERE a.Codigos = " + ALLTRIM(STR(loc_lnCod, 10)) + " AND " + ;
269:                               "a.EmpDopNums = b.EmpDopNums AND " + ;
270:                               "a.EmpSubns = '" + ALLTRIM(TprMvCab.Emps) + "' AND " + ;
271:                               "b.Dopes = c.Dopes AND b.Resps = d.IClis " + ;
272:                               "UNION ALL " + ;
273:                               "SELECT a.Emps, a.Dopes, a.Numes, b.Datas, b.Resps, d.RClis, " + ;
274:                               "b.Datars, c.TitOpes " + ;
275:                               "FROM SigOpDev a, SigMvCab b, SigCdOpe c, SigCdCli d " + ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\relatorios\FormSigReJob.prg
- BO: C:\4c\projeto\app\classes\SigReJobBO.prg
