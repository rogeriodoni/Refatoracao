CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1887: Coluna 'empsubns' NAO EXISTE na tabela 'sigopdev' (referenciada como a.EmpSubns)


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
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormSigMvSbn.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SigMvSbnBO.prg):

--- BO Linhas 209 a 219 ---
209: 						"FROM SigMvPec a " + ;
210: 						"JOIN SigMvCab b ON a.EmpDopnums = b.EmpDopNums " + ;
211: 						"JOIN SigCdOpe c ON b.Dopes = c.Dopes " + ;
212: 						"LEFT JOIN SigStats d ON b.pstatus = d.cods " + ;
213: 						"WHERE a.Codigos = " + STR(loc_nCodigo, 10) + ;
214: 						" AND a.EmpSubns = " + EscaparSQL(ALLTRIM(par_cEmps)) + " " + ;
215: 						"UNION ALL " + ;
216: 						"SELECT a.Emps, a.Dopes, a.Numes, b.Datas, b.Notas, b.Valos, b.ValInis, b.Usuars, " + ;
217: 						"b.Nops, b.Datars, c.Ordes, b.PrazoEnts, b.pstatus, ISNULL(d.descs, SPACE(20)) AS Descs " + ;
218: 						"FROM SigOpDev a " + ;
219: 						"JOIN SigMvCab b ON a.EmpDopnums = b.EmpDopNums " + ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormSigMvSbn.prg
- BO: C:\4c\projeto\app\classes\SigMvSbnBO.prg
