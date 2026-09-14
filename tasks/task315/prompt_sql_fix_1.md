CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1669: INSERT coluna 'tabelaauditada' NAO EXISTE na tabela 'logauditoria'
- [SQL-SCHEMA] Linha ~1669: INSERT coluna 'chaveprimaria' NAO EXISTE na tabela 'logauditoria'


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
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormSIGPRNSE.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SIGPRNSEBO.prg):

--- BO Linhas 247 a 257 ---
247:         TRY
248:             loc_cOperacao = IIF(TYPE("par_cOperacao") = "C", ALLTRIM(par_cOperacao), "OPERACAO")
249:             loc_cChave    = THIS.ObterChavePrimaria()
250: 
251:             loc_cSQL = "INSERT INTO LogAuditoria " + ;
252:                        "(TabelaAuditada, ChavePrimaria, Operacao, Usuario, DataHora) " + ;
253:                        "VALUES (" + ;
254:                        EscaparSQL(THIS.this_cTabela) + ", " + ;
255:                        EscaparSQL(loc_cChave) + ", " + ;
256:                        EscaparSQL(loc_cOperacao) + ", " + ;
257:                        EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 30)) + ", " + ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormSIGPRNSE.prg
- BO: C:\4c\projeto\app\classes\SIGPRNSEBO.prg
