CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~2204: INSERT coluna 'chaveprimaria' NAO EXISTE na tabela 'logauditoria'


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
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormSigPrIct.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SigPrIctBO.prg):

--- BO Linhas 1392 a 1402 ---
1392:         TRY
1393:             loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")
1394: 
1395:             loc_cChave = "Periodo: " + DTOC(THIS.this_dDataI) + " a " + DTOC(THIS.this_dDataF)
1396: 
1397:             loc_cQuery = "INSERT INTO LogAuditoria (Tabela, ChavePrimaria, Operacao, Usuario, DataHora) " + ;
1398:                 "VALUES (" + ;
1399:                 EscaparSQL("SigPrIct") + ", " + ;
1400:                 EscaparSQL(loc_cChave) + ", " + ;
1401:                 EscaparSQL(par_cOperacao) + ", " + ;
1402:                 EscaparSQL(loc_cUsuario) + ", GETDATE())"


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormSigPrIct.prg
- BO: C:\4c\projeto\app\classes\SigPrIctBO.prg
