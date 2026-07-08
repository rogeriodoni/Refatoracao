CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~3627: INSERT coluna 'chaveprimaria' NAO EXISTE na tabela 'logauditoria'
- [SQL-SCHEMA] Linha ~3627: INSERT coluna 'detalhes' NAO EXISTE na tabela 'logauditoria'


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
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\relatorios\Formsigrecmc.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\sigrecmcBO.prg):

--- BO Linhas 1558 a 1568 ---
1558:             loc_cChave   = THIS.ObterChavePrimaria()
1559:             loc_cUsuario = IIF(VARTYPE(gc_4c_UsuarioLogado) = "C", ;
1560:                 ALLTRIM(gc_4c_UsuarioLogado), "SISTEMA")
1561: 
1562:             loc_cSQL = "INSERT INTO LogAuditoria " + ;
1563:                 "(Usuario, DataHora, Tabela, Operacao, ChavePrimaria, Detalhes) " + ;
1564:                 "VALUES (" + ;
1565:                 EscaparSQL(loc_cUsuario) + ", " + ;
1566:                 "GETDATE(), " + ;
1567:                 EscaparSQL("SIGRECMC") + ", " + ;
1568:                 EscaparSQL(ALLTRIM(par_cOperacao)) + ", " + ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\relatorios\Formsigrecmc.prg
- BO: C:\4c\projeto\app\classes\sigrecmcBO.prg
