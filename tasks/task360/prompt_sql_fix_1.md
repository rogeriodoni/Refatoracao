CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1448: Coluna 'cemps' NAO EXISTE na tabela 'sigfichc' (referenciada como a.Cemps)
- [SQL-SCHEMA] Linha ~1481: Coluna 'cemps' NAO EXISTE na tabela 'sigfichc' (referenciada como a.Cemps)


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigfichc
CREATE TABLE [dbo].[SIGFICHC](
	[ctr] [char](100) NOT NULL,
	[emps] [char](3) NOT NULL,
	[logon] [char](8) NOT NULL,
	[nsenha] [char](8) NOT NULL,
	[rde] [char](100) NOT NULL,
	[rdelja] [char](100) NOT NULL,
	[senha] [char](8) NOT NULL,
	[tipos] [char](20) NOT NULL,
	[cidchaves] [char](20) NOT NULL,
	[vlrmin] [numeric](11, 2) NOT NULL,
	[vlrfixo] [numeric](11, 2) NOT NULL,
	[cipchps] [char](32) NULL,
	[nportachps] [int] NULL,
	[versao] [char](10) NOT NULL,
	[ctipos] [char](2) NOT NULL,
	[csenproxys] [char](20) NOT NULL,
	[cusuproxys] [char](64) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\cadastros\FormCec.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\CecBO.prg):

--- BO Linhas 5 a 15 ---
5: *==============================================================================
6: 
7: DEFINE CLASS CecBO AS BusinessBase
8: 
9:     *-- Campos de identificacao / chave composta funcional
10:     this_cEmps        = ""   && char(3)  Empresa (FK SigCdEmp.cEmps)
11:     this_cTipos       = ""   && char(20) Tipo de Consulta (CHEQUE PRE / SERASA / ACSP)
12: 
13:     *-- Campos de acesso CHEQUE PRE
14:     this_cCtr         = ""   && char(100) Contrato
15:     this_cRde         = ""   && char(100) Codigo da Rede

--- BO Linhas 62 a 72 ---
62:         TRY
63:             loc_cSQL = "SELECT a.Emps, a.Tipos, a.Ctr, a.Rde, a.RdeLja," + ;
64:                        " a.Logon, a.Senha, a.VlrMin, a.VlrFixo, a.cipchps, a.nPortachps," + ;
65:                        " a.cTipos, a.cUsuProxys, a.cSenProxys, b.Razas" + ;
66:                        " FROM SigFiChc a" + ;
67:                        " INNER JOIN SigCdEmp b ON a.Cemps = b.cEmps"
68: 
69:             IF !EMPTY(ALLTRIM(par_cFiltro))
70:                 loc_cSQL = loc_cSQL + " WHERE a.Emps = " + EscaparSQL(par_cFiltro)
71:             ENDIF
72: 

--- BO Linhas 95 a 105 ---
95:         TRY
96:             loc_cSQL = "SELECT a.Emps, a.Tipos, a.Ctr, a.Rde, a.RdeLja," + ;
97:                        " a.Logon, a.Senha, a.VlrMin, a.VlrFixo, a.cipchps, a.nPortachps," + ;
98:                        " a.cTipos, a.cUsuProxys, a.cSenProxys, b.Razas" + ;
99:                        " FROM SigFiChc a" + ;
100:                        " INNER JOIN SigCdEmp b ON a.Cemps = b.cEmps" + ;
101:                        " WHERE a.Emps = " + EscaparSQL(par_cEmps) + ;
102:                        " AND a.Tipos = " + EscaparSQL(par_cTipos)
103: 
104:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
105:             IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\cadastros\FormCec.prg
- BO: C:\4c\projeto\app\classes\CecBO.prg
