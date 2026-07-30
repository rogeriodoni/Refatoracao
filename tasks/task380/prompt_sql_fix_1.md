CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~2310: Coluna 'cemps' NAO EXISTE na tabela 'sigcmcab' (referenciada como a.cemps)
- [SQL-SCHEMA] Linha ~2350: Coluna 'cemps' NAO EXISTE na tabela 'sigcmcab' (referenciada como a.cemps)


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigcmcab
CREATE TABLE [dbo].[sigcmcab](
	[cods] [char](40) NOT NULL,
	[datas] [datetime] NULL,
	[dtalts] [datetime] NULL,
	[dtfims] [datetime] NULL,
	[dtinis] [datetime] NULL,
	[dtprocs] [datetime] NULL,
	[emps] [char](3) NOT NULL,
	[metaemps] [numeric](15, 2) NOT NULL,
	[pctvd1] [numeric](5, 2) NOT NULL,
	[pctvd2] [numeric](5, 2) NOT NULL,
	[pkchaves] [char](20) NOT NULL,
	[usualts] [char](10) NOT NULL,
	[usuars] [char](10) NOT NULL,
	[usuprocs] [char](10) NOT NULL,
	[moedas] [char](3) NOT NULL,
	[CodGerente] [char](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[pkchaves] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SigCmGri]    Script Date: 08/12/2025 10:07:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



## Trechos relevantes do Form (C:\4c\projeto\app\forms\cadastros\FormCOM.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\COMBO.prg):

--- BO Linhas 77 a 87 ---
77: 
78:             loc_cSQL = "SELECT a.pkchaves, a.cods, a.emps, a.dtinis, a.dtfims," + ;
79:                        " a.metaemps, a.pctvd1, a.pctvd2, a.moedas, a.CodGerente," + ;
80:                        " ISNULL(b.Razas, '') AS Razas" + ;
81:                        " FROM sigcmcab a" + ;
82:                        " LEFT JOIN SigCdEmp b ON b.Cemps = a.cemps" + ;
83:                        loc_cWhere + ;
84:                        " ORDER BY a.cods"
85: 
86:             IF USED("cursor_4c_Dados")
87:                 USE IN cursor_4c_Dados

--- BO Linhas 117 a 127 ---
117:         TRY
118:             loc_cSQL = "SELECT a.pkchaves, a.cods, a.emps, a.dtinis, a.dtfims," + ;
119:                        " a.metaemps, a.pctvd1, a.pctvd2, a.moedas, a.CodGerente," + ;
120:                        " ISNULL(b.Razas, '') AS Razas, ISNULL(c.DMoes, '') AS DMoes" + ;
121:                        " FROM sigcmcab a" + ;
122:                        " LEFT JOIN SigCdEmp b ON b.Cemps = a.cemps" + ;
123:                        " LEFT JOIN SigCdMoe c ON c.CMoes = a.moedas" + ;
124:                        " WHERE a.pkchaves = " + EscaparSQL(par_cCodigo)
125: 
126:             IF USED("cursor_4c_Carrega")
127:                 USE IN cursor_4c_Carrega


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\cadastros\FormCOM.prg
- BO: C:\4c\projeto\app\classes\COMBO.prg
