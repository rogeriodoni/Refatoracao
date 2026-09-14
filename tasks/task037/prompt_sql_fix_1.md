CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~2084: INSERT coluna 'ctabela' NAO EXISTE na tabela 'logauditoria'
- [SQL-SCHEMA] Linha ~2084: INSERT coluna 'coperacao' NAO EXISTE na tabela 'logauditoria'
- [SQL-SCHEMA] Linha ~2084: INSERT coluna 'cchave' NAO EXISTE na tabela 'logauditoria'
- [SQL-SCHEMA] Linha ~2084: INSERT coluna 'cusuario' NAO EXISTE na tabela 'logauditoria'
- [SQL-SCHEMA] Linha ~2084: INSERT coluna 'ddatahora' NAO EXISTE na tabela 'logauditoria'


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
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\relatorios\Formsigrebal.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\sigrebalBO.prg):

--- BO Linhas 807 a 817 ---
807:         loc_lSucesso = .F.
808:         TRY
809:             loc_cChave   = THIS.ObterChavePrimaria()
810:             loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
811:                                ALLTRIM(gc_4c_UsuarioLogado), "")
812:             loc_cSQL = "INSERT INTO LogAuditoria (cTabela, cOperacao, cChave, cUsuario, dDataHora) " + ;
813:                        "VALUES (" + ;
814:                        EscaparSQL("SigMvCcr") + ", " + ;
815:                        EscaparSQL(par_cOperacao) + ", " + ;
816:                        EscaparSQL(loc_cChave) + ", " + ;
817:                        EscaparSQL(loc_cUsuario) + ", GETDATE())"


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\relatorios\Formsigrebal.prg
- BO: C:\4c\projeto\app\classes\sigrebalBO.prg
