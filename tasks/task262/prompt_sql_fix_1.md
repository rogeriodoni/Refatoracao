CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~4841: Tabela 'SigCdCcp' NAO EXISTE no banco. Verificar nome correto no schema.sql ou codigo original.
- [SQL-SCHEMA] Linha ~4918: Tabela 'SigCdCcp' NAO EXISTE no banco. Verificar nome correto no schema.sql ou codigo original.
- [SQL-SCHEMA] Linha ~4992: Tabela 'SigCdCcp' NAO EXISTE no banco. Verificar nome correto no schema.sql ou codigo original.
- [SQL-SCHEMA] Linha ~5056: INSERT coluna 'empresa' NAO EXISTE na tabela 'logauditoria'


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
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\Formsigprccp.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\sigprccpBO.prg):

--- BO Linhas 2008 a 2018 ---
2008:                     loc_cEmpresa = ALLTRIM(THIS.this_cEmpresa)
2009:                 ENDIF
2010:                 loc_cChave = THIS.ObterChavePrimaria()
2011: 
2012:                 loc_cSQL = "INSERT INTO LogAuditoria " + ;
2013:                     "(DataHora, Usuario, Empresa, Tabela, Operacao, ChaveRegistro) " + ;
2014:                     "VALUES (GETDATE(), " + ;
2015:                     EscaparSQL(loc_cUsuario) + ", " + ;
2016:                     EscaparSQL(loc_cEmpresa) + ", " + ;
2017:                     EscaparSQL("SigCdCcp") + ", " + ;
2018:                     EscaparSQL(par_cOperacao) + ", " + ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\Formsigprccp.prg
- BO: C:\4c\projeto\app\classes\sigprccpBO.prg
