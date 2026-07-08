CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1861: INSERT coluna 'chaveprimaria' NAO EXISTE na tabela 'logauditoria'


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
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormSIGPRCPR.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SIGPRCPRBO.prg):

--- BO Linhas 764 a 774 ---
764:     *--------------------------------------------------------------------------
765:     PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
766:         LOCAL loc_cSQL, loc_oErro
767: 
768:         TRY
769:             loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChavePrimaria, Usuario, DataHora) " + ;
770:                        "VALUES (" + ;
771:                        EscaparSQL(THIS.this_cTabela) + ", " + ;
772:                        EscaparSQL(ALLTRIM(par_cOperacao)) + ", " + ;
773:                        EscaparSQL(THIS.ObterChavePrimaria()) + ", " + ;
774:                        EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormSIGPRCPR.prg
- BO: C:\4c\projeto\app\classes\SIGPRCPRBO.prg
