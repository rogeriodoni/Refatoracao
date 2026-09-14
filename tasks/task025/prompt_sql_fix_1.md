CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1610: INSERT coluna 'chaveprimaria' NAO EXISTE na tabela 'logauditoria'
- [SQL-SCHEMA] Linha ~1610: INSERT coluna 'observacao' NAO EXISTE na tabela 'logauditoria'


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
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\relatorios\FormSigReAac.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SigReAacBO.prg):

--- BO Linhas 415 a 425 ---
415:             IF EMPTY(loc_cUsuario)
416:                 loc_cUsuario = "SISTEMA"
417:             ENDIF
418: 
419:             loc_cSQL = "INSERT INTO LogAuditoria " + ;
420:                        "(DataHora, Usuario, Operacao, Tabela, ChavePrimaria, Observacao) " + ;
421:                        "VALUES (" + ;
422:                        FormatarDataSQL(DATETIME()) + ", " + ;
423:                        EscaparSQL(loc_cUsuario) + ", " + ;
424:                        EscaparSQL(NVL(par_cOperacao, "RELATORIO")) + ", " + ;
425:                        EscaparSQL("SigOpLog") + ", " + ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\relatorios\FormSigReAac.prg
- BO: C:\4c\projeto\app\classes\SigReAacBO.prg
