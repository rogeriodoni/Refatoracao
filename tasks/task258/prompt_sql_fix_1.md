CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1331: INSERT coluna 'chave' NAO EXISTE na tabela 'logauditoria'


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
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormSigPrAop.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SigPrAopBO.prg):

--- BO Linhas 14 a 24 ---
14:     this_nNops     = 0
15: 
16:     *-- Codigo do produto da OP
17:     this_cCodPds   = ""
18: 
19:     *-- Chave composta: cCodEmpresa + DoppPads + Str(Nops,10)
20:     this_cEmpDNps  = ""
21: 
22:     *-- Parametros carregados de SigCdPam
23:     this_cDoppPads = ""
24:     this_cMascNums = ""

--- BO Linhas 82 a 92 ---
82:         IF par_nNops = 0
83:             RETURN .F.
84:         ENDIF
85: 
86:         TRY
87:             *-- Monta chave EmpDNps: cCodEmpresa + DoppPads + Str(Nops,10)
88:             loc_cEmpDNps = go_4c_Sistema.cCodEmpresa + THIS.this_cDoppPads + STR(par_nNops, 10)
89:             THIS.this_cEmpDNps = loc_cEmpDNps
90:             THIS.this_nNops    = par_nNops
91: 
92:             *-- Valida OP em SigCdNec (verifica existencia e se nao foi encerrada)

--- BO Linhas 365 a 375 ---
365:     *---------------------------------------------------------------------------
366:     PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
367:     *---------------------------------------------------------------------------
368:         LOCAL loc_cSql, loc_oErro
369:         TRY
370:             loc_cSql = "INSERT INTO LogAuditoria (Tabela, Chave, Operacao, Usuario, DataHora) " + ;
371:                        "VALUES (" + ;
372:                        EscaparSQL("SigOpPic") + ", " + ;
373:                        EscaparSQL(THIS.ObterChavePrimaria()) + ", " + ;
374:                        EscaparSQL(par_cOperacao) + ", " + ;
375:                        EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormSigPrAop.prg
- BO: C:\4c\projeto\app\classes\SigPrAopBO.prg
