CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~3092: INSERT coluna 'empresa' NAO EXISTE na tabela 'logauditoria'
- [SQL-SCHEMA] Linha ~3092: INSERT coluna 'chaveprimaria' NAO EXISTE na tabela 'logauditoria'


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
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\relatorios\Formsigredoc.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\sigredocBO.prg):

--- BO Linhas 1854 a 1864 ---
1854:             loc_cEmpresa  = ""
1855:             IF TYPE("go_4c_Sistema") = "O" AND !ISNULL(go_4c_Sistema)
1856:                 loc_cEmpresa = go_4c_Sistema.cCodEmpresa
1857:             ENDIF
1858: 
1859:             loc_cSQL = "INSERT INTO LogAuditoria (DataHora, Usuario, Empresa, Tabela, ChavePrimaria, Operacao)" + ;
1860:                        " VALUES (" + FormatarDataSQL(DATETIME()) + ", " + ;
1861:                        EscaparSQL(loc_cUsuario) + ", " + EscaparSQL(loc_cEmpresa) + ", " + ;
1862:                        EscaparSQL(THIS.this_cTabela) + ", " + EscaparSQL(loc_cChave) + ", " + ;
1863:                        EscaparSQL(par_cOperacao) + ")"
1864: 


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\relatorios\Formsigredoc.prg
- BO: C:\4c\projeto\app\classes\sigredocBO.prg
