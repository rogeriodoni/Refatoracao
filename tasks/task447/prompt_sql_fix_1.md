CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1411: Coluna 'cemps' NAO EXISTE na tabela 'sigcdcmi' (referenciada como a.cemps)
- [SQL-SCHEMA] Linha ~1448: Coluna 'cemps' NAO EXISTE na tabela 'sigcdcmi' (referenciada como a.cemps)


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigcdcmi
CREATE TABLE [dbo].[SigCdCmi](
	[cargos] [char](10) NOT NULL,
	[comiss] [numeric](4, 2) NOT NULL,
	[dtfins] [datetime] NULL,
	[dtinis] [datetime] NULL,
	[emps] [char](3) NOT NULL,
	[tabdes] [char](10) NOT NULL,
	[cidchaves] [char](20) NOT NULL,
	[dtalts] [datetime] NULL,
	[fpags] [char](12) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\cadastros\FormICM.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\ICMBO.prg):

--- BO Linhas 60 a 70 ---
60:                        " a.dtinis, a.dtfins, a.comiss, a.dtalts," + ;
61:                        " ISNULL(b.razas, '') AS razas," + ;
62:                        " ISNULL(c.dcargs, '') AS dcargs," + ;
63:                        " ISNULL(d.descrs, '') AS descrs_tabdes" + ;
64:                        " FROM SigCdCmi a" + ;
65:                        " LEFT JOIN SigCdEmp b ON b.cemps = a.cemps" + ;
66:                        " LEFT JOIN SigCdCrg c ON c.ccargs = a.cargos" + ;
67:                        " LEFT JOIN SigOpTdz d ON d.codigos = a.tabdes" + ;
68:                        loc_cWhere + ;
69:                        " ORDER BY a.emps, a.tabdes, a.cargos, a.fpags"
70: 

--- BO Linhas 97 a 107 ---
97:                        " a.dtinis, a.dtfins, a.comiss, a.dtalts," + ;
98:                        " ISNULL(b.razas, '') AS razas," + ;
99:                        " ISNULL(c.dcargs, '') AS dcargs," + ;
100:                        " ISNULL(d.descrs, '') AS descrs_tabdes" + ;
101:                        " FROM SigCdCmi a" + ;
102:                        " LEFT JOIN SigCdEmp b ON b.cemps = a.cemps" + ;
103:                        " LEFT JOIN SigCdCrg c ON c.ccargs = a.cargos" + ;
104:                        " LEFT JOIN SigOpTdz d ON d.codigos = a.tabdes" + ;
105:                        " WHERE a.cidchaves = " + EscaparSQL(ALLTRIM(par_cIdChaves))
106: 
107:             IF USED("cursor_4c_Carrega")


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\cadastros\FormICM.prg
- BO: C:\4c\projeto\app\classes\ICMBO.prg
