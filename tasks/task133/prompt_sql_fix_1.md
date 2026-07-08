CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~2073: INSERT coluna 'chaveprimaria' NAO EXISTE na tabela 'logauditoria'
- [SQL-SCHEMA] Linha ~2073: INSERT coluna 'empresa' NAO EXISTE na tabela 'logauditoria'


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
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormSigReJur.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SigReJurBO.prg):

--- BO Linhas 393 a 403 ---
393:             loc_cChave = ALLTRIM(THIS.this_cGrupo) + "|" + ;
394:                          ALLTRIM(THIS.this_cConta) + "|" + ;
395:                          DTOC(THIS.this_dData)
396: 
397:             loc_cSQL = "INSERT INTO LogAuditoria " + ;
398:                        "(Tabela, ChavePrimaria, Operacao, Usuario, DataHora, Empresa) " + ;
399:                        "VALUES (" + ;
400:                        EscaparSQL("crTmpJuros") + ", " + ;
401:                        EscaparSQL(loc_cChave) + ", " + ;
402:                        EscaparSQL(par_cOperacao) + ", " + ;
403:                        EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormSigReJur.prg
- BO: C:\4c\projeto\app\classes\SigReJurBO.prg
