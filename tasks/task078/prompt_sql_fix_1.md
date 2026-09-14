CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~2896: INSERT coluna 'detalhe' NAO EXISTE na tabela 'logauditoria'


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
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\relatorios\FormSIGREDES.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SIGREDESBO.prg):

--- BO Linhas 781 a 791 ---
781:                 " - " + DTOC(THIS.this_dDtFinal) + ;
782:                 " | Empresa " + ALLTRIM(THIS.this_cEmpresa) + ;
783:                 " | Vend " + ALLTRIM(THIS.this_cVend) + ;
784:                 " | Visao " + IIF(THIS.this_nOpcao = 1, "Detalhada", "Resumida")
785: 
786:             loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, Usuario, DataHora, Detalhe) " + ;
787:                 "VALUES (" + EscaparSQL("SIGREDES") + ", " + ;
788:                 EscaparSQL(ALLTRIM(par_cOperacao)) + ", " + ;
789:                 EscaparSQL(loc_cUsuario) + ", " + ;
790:                 FormatarDataSQL(DATETIME()) + ", " + ;
791:                 EscaparSQL(loc_cDetalhe) + ")"


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\relatorios\FormSIGREDES.prg
- BO: C:\4c\projeto\app\classes\SIGREDESBO.prg
