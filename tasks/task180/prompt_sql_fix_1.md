CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1089: INSERT coluna 'chaveprimaria' NAO EXISTE na tabela 'logauditoria'
- [SQL-SCHEMA] Linha ~1089: INSERT coluna 'descricao' NAO EXISTE na tabela 'logauditoria'


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
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormSIGPREST.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SIGPRESTBO.prg):

--- BO Linhas 353 a 363 ---
353:             IF !EMPTY(THIS.this_cDirAtual)
354:                 loc_cDescricao = loc_cDescricao + " | Dir=" + ALLTRIM(THIS.this_cDirAtual)
355:             ENDIF
356: 
357:             loc_cSQL = "INSERT INTO LogAuditoria" + ;
358:                        " (Usuario, DataHora, Operacao, Tabela, ChavePrimaria, Descricao)" + ;
359:                        " VALUES (" + ;
360:                        EscaparSQL(loc_cUsuario) + ", " + ;
361:                        "GETDATE(), " + ;
362:                        EscaparSQL(loc_cOperacao) + ", " + ;
363:                        EscaparSQL("SIGPREST") + ", " + ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormSIGPREST.prg
- BO: C:\4c\projeto\app\classes\SIGPRESTBO.prg
