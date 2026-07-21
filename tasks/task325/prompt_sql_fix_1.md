CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~3626: INSERT coluna 'chaveprimaria' NAO EXISTE na tabela 'logauditoria'
- [SQL-SCHEMA] Linha ~3626: INSERT coluna 'detalhes' NAO EXISTE na tabela 'logauditoria'


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
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormSigPrRet.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SigPrRetBO.prg):

--- BO Linhas 300 a 310 ---
300:                            " DtI=" + DTOC(THIS.this_dDtInicial) + ;
301:                            " DtF=" + DTOC(THIS.this_dDtFinal) + ;
302:                            " EtqI=" + ALLTRIM(STR(THIS.this_nEtiqIni, 14)) + ;
303:                            " EtqF=" + ALLTRIM(STR(THIS.this_nEtiqFim, 14))
304:             loc_cSQL = "INSERT INTO LogAuditoria " + ;
305:                        "(Usuario, DataHora, Tabela, ChavePrimaria, Operacao, Detalhes) " + ;
306:                        "VALUES (" + ;
307:                        EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
308:                        "GETDATE(), " + ;
309:                        EscaparSQL("SigPrRet") + ", " + ;
310:                        EscaparSQL("") + ", " + ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormSigPrRet.prg
- BO: C:\4c\projeto\app\classes\SigPrRetBO.prg
