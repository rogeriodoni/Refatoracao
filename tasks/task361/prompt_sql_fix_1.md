CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1620: Coluna 'cemps' NAO EXISTE na tabela 'sigcdceg' (referenciada como a.cemps)
- [SQL-SCHEMA] Linha ~1653: Coluna 'cemps' NAO EXISTE na tabela 'sigcdceg' (referenciada como a.cemps)


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigcdceg
CREATE TABLE [dbo].[SIGCDCEG](
	[cidchaves] [char](20) NOT NULL,
	[contas] [char](10) NOT NULL,
	[grupos] [char](10) NOT NULL,
	[priors] [numeric](2, 0) NOT NULL,
	[emps] [char](3) NOT NULL,
	[tpcads] [numeric](1, 0) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\cadastros\FormCeg.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\CegBO.prg):

--- BO Linhas 10 a 20 ---
10: 
11: 	*-- Propriedades da entidade (SigCdCeg)
12: 	this_cCidchaves   = ""   && cidchaves char(?)      - PK (gerado por fUniqueIds)
13: 	this_cGrupos      = ""   && grupos char(?)         - Grupo (FK SigCdGcr.Codigos)
14: 	this_cContas      = ""   && contas char(?)         - Conta (via fAcessoContas)
15: 	this_cEmps        = ""   && Cemps char(3)           - Empresa (FK SigCdEmp.CEmps)
16: 	this_nPriors      = 0    && priors numeric(2,0)    - Prioridade (InputMask "99")
17: 	this_nTpCads      = 0    && TpCads numeric(1,0)    - Tipo (OptionGroup 3 opcoes)
18: 
19: 	*-- Propriedade auxiliar de exibicao (NAO persiste no banco)
20: 	this_cDEmps       = ""   && descricao da empresa (SigCdEmp.Razas - display only)

--- BO Linhas 45 a 55 ---
45: 
46: 		TRY
47: 			loc_cSQL = "SELECT a.cidchaves, a.priors, a.grupos, a.contas, a.emps," + ;
48: 			           " ISNULL(b.Razas, '') AS Razas" + ;
49: 			           " FROM SIGCDCEG a" + ;
50: 			           " LEFT JOIN SigCdEmp b ON RTRIM(b.Cemps) = RTRIM(a.cemps)"
51: 
52: 			IF !EMPTY(par_cFiltro)
53: 				loc_cSQL = loc_cSQL + " WHERE RTRIM(a.grupos) LIKE " + ;
54: 				           EscaparSQL(ALLTRIM(par_cFiltro) + "%")
55: 			ENDIF

--- BO Linhas 79 a 89 ---
79: 		TRY
80: 			loc_cSQL = "SELECT a.cidchaves, a.contas, a.grupos, a.priors," + ;
81: 			           " a.emps, a.tpcads," + ;
82: 			           " ISNULL(b.Razas, '') AS Razas" + ;
83: 			           " FROM SIGCDCEG a" + ;
84: 			           " LEFT JOIN SigCdEmp b ON RTRIM(b.Cemps) = RTRIM(a.cemps)" + ;
85: 			           " WHERE RTRIM(a.cidchaves) = " + EscaparSQL(ALLTRIM(par_cCidchaves))
86: 
87: 			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
88: 			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
89: 				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\cadastros\FormCeg.prg
- BO: C:\4c\projeto\app\classes\CegBO.prg
