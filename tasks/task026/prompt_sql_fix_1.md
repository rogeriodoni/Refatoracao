CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~2705: INSERT coluna 'dtoperacao' NAO EXISTE na tabela 'logauditoria'
- [SQL-SCHEMA] Linha ~2705: INSERT coluna 'cusuario' NAO EXISTE na tabela 'logauditoria'
- [SQL-SCHEMA] Linha ~2705: INSERT coluna 'ctabela' NAO EXISTE na tabela 'logauditoria'
- [SQL-SCHEMA] Linha ~2705: INSERT coluna 'coperacao' NAO EXISTE na tabela 'logauditoria'
- [SQL-SCHEMA] Linha ~2705: INSERT coluna 'cchave' NAO EXISTE na tabela 'logauditoria'


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
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\relatorios\FormSIGREADS.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SIGREADSBO.prg):

--- BO Linhas 921 a 931 ---
921:                          ";OPE=" + ALLTRIM(THIS.this_cNmOperacao) + ;
922:                          ";MOE=" + ALLTRIM(THIS.this_cMoeda) + ;
923:                          ";TR=" + ALLTRIM(STR(THIS.this_nTipoRel, 1))
924: 
925:             loc_cSQL = "INSERT INTO LogAuditoria " + ;
926:                        "(dtOperacao, cUsuario, cTabela, cOperacao, cChave) " + ;
927:                        "VALUES (GETDATE(), " + ;
928:                        EscaparSQL(loc_cUsuario) + ", " + ;
929:                        EscaparSQL("SigReAds") + ", " + ;
930:                        EscaparSQL(par_cOperacao) + ", " + ;
931:                        EscaparSQL(loc_cChave) + ")"


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\relatorios\FormSIGREADS.prg
- BO: C:\4c\projeto\app\classes\SIGREADSBO.prg
