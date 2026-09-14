CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~3993: INSERT coluna 'detalhes' NAO EXISTE na tabela 'logauditoria'


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
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormSigPrFem.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SigPrFemBO.prg):

--- BO Linhas 2176 a 2186 ---
2176:                                " Datai=" + DTOC(THIS.this_dDatai) + ;
2177:                                " Dataf=" + DTOC(THIS.this_dDataf) + ;
2178:                                " Emp=" + ALLTRIM(THIS.this_cEmpresa)
2179: 
2180:                 loc_cSQL = "INSERT INTO LogAuditoria " + ;
2181:                            "(Usuario, DataHora, Operacao, Tabela, ChaveRegistro, Detalhes) " + ;
2182:                            "VALUES (" + ;
2183:                            EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
2184:                            "GETDATE(), " + ;
2185:                            EscaparSQL(par_cOperacao) + ", " + ;
2186:                            EscaparSQL("SIGPRFEM") + ", " + ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormSigPrFem.prg
- BO: C:\4c\projeto\app\classes\SigPrFemBO.prg
