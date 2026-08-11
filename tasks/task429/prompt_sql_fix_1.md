CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1314: INSERT coluna 'chave' NAO EXISTE na tabela 'logauditoria'


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
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormFPP.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\FPPBO.prg):

--- BO Linhas 2 a 12 ---
2: * FPPBO.prg - Business Object: Desconto por No. de Parcelas
3: * Tabela: SigOpFpp
4: * Herda de: BusinessBase
5: *
6: * Colunas SigOpFpp (schema.sql):
7: *   cidchaves  char(20)       - Chave unica PK (gerada por SYS(2015))
8: *   descs      numeric(5,2)   - % Desconto
9: *   fpags      char(12)       - Codigo da condicao de pagamento (FK SigOpFp)
10: *   nparcs     numeric(2,0)   - No. de parcelas
11: *   parcdes    numeric(1,0)   - Qtd parcelas de desconto (P)
12: *   valmins    numeric(11,2)  - Valor minimo

--- BO Linhas 326 a 336 ---
326:     PROCEDURE RegistrarAuditoria(par_cOperacao)
327:         LOCAL loc_cSql, loc_oErro
328: 
329:         TRY
330:             loc_cSql = "INSERT INTO LogAuditoria " + ;
331:                        "(Usuario, Tabela, Operacao, Chave, DataHora) " + ;
332:                        "VALUES (" + ;
333:                        EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
334:                        EscaparSQL(THIS.this_cTabela) + ", " + ;
335:                        EscaparSQL(par_cOperacao) + ", " + ;
336:                        EscaparSQL(THIS.this_cFpags) + ", " + ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormFPP.prg
- BO: C:\4c\projeto\app\classes\FPPBO.prg
