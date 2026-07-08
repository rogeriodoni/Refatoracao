CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1201: INSERT coluna 'chaveprimaria' NAO EXISTE na tabela 'logauditoria'
- [SQL-SCHEMA] Linha ~1201: INSERT coluna 'empresa' NAO EXISTE na tabela 'logauditoria'


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: logauditoria
CREATE TABLE [dbo].[LogAuditoria](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Tabela] [varchar](100) NOT NULL,
	[Operacao] [varchar](10) NOT NULL,
	[ChaveRegistro] [varchar](100) NOT NULL,
	[Usuario] [varchar](50) NOT NULL,
	[DataHora] [datetime] NOT NULL,
	[DadosAnteriores] [nvarchar](max) NULL,
	[DadosNovos] [nvarchar](max) NULL,
	[IP] [varchar](50) NULL,
	[Estacao] [varchar](100) NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\relatorios\Formsigrecog.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\sigrecogBO.prg):

--- BO Linhas 11 a 21 ---
11: 
12:     *-- Filtros de periodo
13:     this_dDtInicial      = {}
14:     this_dDtFinal        = {}
15: 
16:     *-- Filtro de empresa
17:     this_cEmpresa        = ""
18:     this_cRazaEmpresa    = ""
19: 
20:     *-- Filtro de vendedor
21:     this_cVendedor       = ""

--- BO Linhas 90 a 100 ---
90:         TRY
91:             loc_cChave   = THIS.ObterChavePrimaria()
92:             loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
93:                                gc_4c_UsuarioLogado, "SISTEMA")
94: 
95:             loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChavePrimaria, " + ;
96:                        "Usuario, DataHora, Empresa) VALUES (" + ;
97:                        EscaparSQL("SigReCog") + ", " + ;
98:                        EscaparSQL(par_cOperacao) + ", " + ;
99:                        EscaparSQL(loc_cChave) + ", " + ;
100:                        EscaparSQL(loc_cUsuario) + ", " + ;

--- BO Linhas 91 a 101 ---
91:             loc_cChave   = THIS.ObterChavePrimaria()
92:             loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
93:                                gc_4c_UsuarioLogado, "SISTEMA")
94: 
95:             loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChavePrimaria, " + ;
96:                        "Usuario, DataHora, Empresa) VALUES (" + ;
97:                        EscaparSQL("SigReCog") + ", " + ;
98:                        EscaparSQL(par_cOperacao) + ", " + ;
99:                        EscaparSQL(loc_cChave) + ", " + ;
100:                        EscaparSQL(loc_cUsuario) + ", " + ;
101:                        "GETDATE(), " + ;

--- BO Linhas 134 a 144 ---
134: 
135:                 loc_cEmpresa  = ALLTRIM(THIS.this_cEmpresa)
136:                 loc_cVendedor = ALLTRIM(THIS.this_cVendedor)
137:                 loc_cCmoeda   = PADR(ALLTRIM(THIS.this_cCmoeda), 3)
138: 
139:                 *-- 1. Busca nome da empresa no cabecalho
140:                 loc_cNomeEmpresa = ""
141:                 IF !EMPTY(loc_cEmpresa)
142:                     loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
143:                                "WHERE Cemps = " + EscaparSQL(loc_cEmpresa)
144:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "crCogEmp") > 0 AND ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\relatorios\Formsigrecog.prg
- BO: C:\4c\projeto\app\classes\sigrecogBO.prg
