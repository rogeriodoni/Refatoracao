CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1347: INSERT coluna 'chave' NAO EXISTE na tabela 'logauditoria'


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
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormSIGPRCOT.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SIGPRCOTBO.prg):

--- BO Linhas 12 a 22 ---
12:     *-- Campos de SigCdCot (schema: docs/schema.sql)
13:     this_cMoes      = ""   && char(3)       - codigo da moeda
14:     this_dDatas     = {}   && date NULL      - data da cotacao
15:     this_cHoras     = ""   && char(8)        - hora da cotacao
16:     this_nValos     = 0    && numeric(11,6)  - valor da cotacao
17:     this_cCidChaves = ""   && char(20)       - chave unica (PK)
18:     this_dDtAlts    = {}   && date NULL      - data da ultima alteracao
19:     this_cUsuars    = ""   && char(10)       - usuario que inseriu/alterou
20: 
21:     *-- Nome do cursor de trabalho (grid de cotacoes)
22:     this_cCursorCotacoes = "cursor_4c_Cotacoes"

--- BO Linhas 20 a 30 ---
20: 
21:     *-- Nome do cursor de trabalho (grid de cotacoes)
22:     this_cCursorCotacoes = "cursor_4c_Cotacoes"
23: 
24:     *--------------------------------------------------------------------------
25:     * Init - Configura tabela e chave primaria
26:     *--------------------------------------------------------------------------
27:     PROCEDURE Init()
28:         THIS.this_cTabela     = "SigCdCot"
29:         THIS.this_cCampoChave = "cidchaves"
30:         DODEFAULT()

--- BO Linhas 29 a 39 ---
29:         THIS.this_cCampoChave = "cidchaves"
30:         DODEFAULT()
31:     ENDPROC
32: 
33:     *--------------------------------------------------------------------------
34:     * ObterChavePrimaria - Retorna chave primaria do registro atual
35:     *--------------------------------------------------------------------------
36:     PROTECTED PROCEDURE ObterChavePrimaria()
37:         RETURN THIS.this_cCidChaves
38:     ENDPROC
39: 

--- BO Linhas 75 a 85 ---
75:         ENDIF
76:         RETURN .T.
77:     ENDPROC
78: 
79:     *--------------------------------------------------------------------------
80:     * GerarChaveUnica - Gera chave unica char(20) para cidchaves
81:     *--------------------------------------------------------------------------
82:     PROTECTED PROCEDURE GerarChaveUnica()
83:         RETURN LEFT(SYS(2015) + SYS(2015), 20)
84:     ENDPROC
85: 

--- BO Linhas 170 a 180 ---
170:             LOCATE FOR ALLTRIM(cmoes) = ALLTRIM(par_cMoeda) AND datas = loc_dHoje
171:             IF FOUND()
172:                 MsgAviso("J" + CHR(225) + " existe cota" + CHR(231) + CHR(227) + ;
173:                     "o cadastrada para hoje.", "Aten" + CHR(231) + CHR(227) + "o")
174:             ELSE
175:                 *-- Gerar chave unica
176:                 loc_cCidChave = THIS.GerarChaveUnica()
177: 
178:                 *-- INSERT no SQL Server (valos=0 inicialmente; usuario edita no grid)
179:                 loc_cSQL = "INSERT INTO SigCdCot " + ;
180:                     "(cmoes, datas, horas, valos, cidchaves, dtalts, usuars) " + ;

--- BO Linhas 461 a 471 ---
461:     *--------------------------------------------------------------------------
462:     PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
463:         LOCAL loc_cSQL, loc_oErro
464:         TRY
465:             loc_cSQL = "INSERT INTO LogAuditoria " + ;
466:                 "(Tabela, Operacao, Chave, Usuario, DataHora) VALUES (" + ;
467:                 EscaparSQL("SigCdCot") + ", " + ;
468:                 EscaparSQL(par_cOperacao) + ", " + ;
469:                 EscaparSQL(THIS.this_cCidChaves) + ", " + ;
470:                 EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
471:                 "GETDATE())"


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormSIGPRCOT.prg
- BO: C:\4c\projeto\app\classes\SIGPRCOTBO.prg
