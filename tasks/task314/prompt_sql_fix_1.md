CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~2840: INSERT coluna 'chaveprimaria' NAO EXISTE na tabela 'logauditoria'


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
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\Formsigprnfe.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\sigprnfeBO.prg):

--- BO Linhas 628 a 638 ---
628:     *==========================================================================
629:     PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
630:         LOCAL loc_oErro, loc_cSQL, loc_nRet
631:         TRY
632:             loc_cSQL = "INSERT INTO LogAuditoria " + ;
633:                        "(Tabela, Operacao, ChavePrimaria, Usuario, DataHora) VALUES (" + ;
634:                        EscaparSQL("sigprnfe") + ", " + ;
635:                        EscaparSQL(LEFT(ALLTRIM(par_cOperacao), 1)) + ", " + ;
636:                        EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmpDopNums), 50)) + ", " + ;
637:                        EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 20)) + ", " + ;
638:                        "GETDATE())"


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\Formsigprnfe.prg
- BO: C:\4c\projeto\app\classes\sigprnfeBO.prg
