CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1723: INSERT coluna 'chaveprimaria' NAO EXISTE na tabela 'logauditoria'
- [SQL-SCHEMA] Linha ~1723: INSERT coluna 'detalhes' NAO EXISTE na tabela 'logauditoria'


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
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\relatorios\Formsigrectc.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\sigrectcBO.prg):

--- BO Linhas 567 a 577 ---
567:         LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cOperacao
568:         loc_lSucesso = .F.
569:         loc_cOperacao = IIF(VARTYPE(par_cOperacao) = "C" AND !EMPTY(par_cOperacao), ;
570:                             par_cOperacao, "VISUALIZAR")
571:         TRY
572:             loc_cSQL = "INSERT INTO LogAuditoria (Operacao, Tabela, ChavePrimaria, Usuario, DataHora, Detalhes) " + ;
573:                        "VALUES (" + ;
574:                        EscaparSQL(loc_cOperacao) + "," + ;
575:                        EscaparSQL("RELATORIO_CARTOES") + "," + ;
576:                        EscaparSQL(THIS.ObterChavePrimaria()) + "," + ;
577:                        EscaparSQL(gc_4c_UsuarioLogado) + "," + ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\relatorios\Formsigrectc.prg
- BO: C:\4c\projeto\app\classes\sigrectcBO.prg
