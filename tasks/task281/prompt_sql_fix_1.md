CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~2597: INSERT coluna 'chaveprimaria' NAO EXISTE na tabela 'logauditoria'
- [SQL-SCHEMA] Linha ~2597: INSERT coluna 'detalhes' NAO EXISTE na tabela 'logauditoria'


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
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormSigPrEs1.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SigPrEs1BO.prg):

--- BO Linhas 481 a 491 ---
481:             loc_cDetalhes = "Empresa=" + ALLTRIM(THIS.this_cEmpresa) + ;
482:                 "; Operacao=" + ALLTRIM(THIS.this_cNmOperacao) + ;
483:                 "; Periodo=" + DTOC(THIS.this_dDtInicial) + ".." + DTOC(THIS.this_dDtFinal)
484: 
485:             loc_cSQL = "INSERT INTO LogAuditoria " + ;
486:                 "(Tabela, Operacao, ChavePrimaria, Usuario, DataHora, Detalhes) " + ;
487:                 "VALUES (" + ;
488:                 EscaparSQL("SigPrEs1") + ", " + ;
489:                 EscaparSQL(par_cOperacao) + ", " + ;
490:                 EscaparSQL(loc_cChave) + ", " + ;
491:                 EscaparSQL(loc_cUsuario) + ", " + ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormSigPrEs1.prg
- BO: C:\4c\projeto\app\classes\SigPrEs1BO.prg
