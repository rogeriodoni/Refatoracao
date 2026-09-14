CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~3576: INSERT coluna 'chaveprimaria' NAO EXISTE na tabela 'logauditoria'


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
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\relatorios\FormSigReCmp.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SigReCmpBO.prg):

--- BO Linhas 855 a 865 ---
855:     PROCEDURE RegistrarAuditoria(par_cOperacao)
856:         LOCAL loc_lSucesso, loc_cSQL, loc_oErro
857:         loc_lSucesso = .F.
858:         TRY
859:             loc_cSQL = "INSERT INTO LogAuditoria " + ;
860:                        "(Usuario, DataHora, Operacao, Tabela, ChavePrimaria) " + ;
861:                        "VALUES (" + ;
862:                        EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
863:                        "GETDATE(), " + ;
864:                        EscaparSQL(par_cOperacao) + ", " + ;
865:                        EscaparSQL("SigReCmp") + ", " + ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\relatorios\FormSigReCmp.prg
- BO: C:\4c\projeto\app\classes\SigReCmpBO.prg
