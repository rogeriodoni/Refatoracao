CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1102: UPDATE coluna 'this_nvtexprodid' NAO EXISTE na tabela 'sigprvtx'


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigprvtx
CREATE TABLE [dbo].[sigprvtx](
	[cidchaves] [char](20) NOT NULL,
	[nomesku] [char](100) NOT NULL,
	[refsku] [char](40) NOT NULL,
	[skuativo] [char](3) NOT NULL,
	[skuid] [char](10) NOT NULL,
	[cpros] [char](14) NOT NULL,
	[descritivo] [char](45) NOT NULL,
	[tamanho] [char](4) NOT NULL,
	[qtd] [numeric](11, 3) NOT NULL,
	[bxqtd] [numeric](11, 3) NOT NULL,
	[chkatustock] [bit] NULL,
	[pvens] [numeric](11, 5) NOT NULL,
	[precode] [numeric](11, 5) NOT NULL,
	[ckvtexup] [bit] NULL,
	[ckatudesc] [bit] NULL,
	[vtexProdId] [int] NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormSIGPRVTX.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SIGPRVTXBO.prg):

--- BO Linhas 33 a 43 ---
33:     this_lChkAtuStock   = .F.   && chkatustock bit NULL
34:     this_nPvens         = 0     && pvens     numeric(11,5) NOT NULL
35:     this_nPrecode       = 0     && precode   numeric(11,5) NOT NULL
36:     this_lCkVtexUp      = .F.   && ckvtexup  bit NULL
37:     this_lCkAtuDesc     = .F.   && ckAtudesc bit NULL
38:     this_nVtexProdId    = 0     && vtexProdId int NULL
39: 
40:     *-- -----------------------------------------------------------------------
41:     *-- NOME DO CURSOR DA GRADE (padrao OPERACIONAL - cursor_4c_Grade)
42:     *-- -----------------------------------------------------------------------
43:     this_cCursorDados   = "cursor_4c_Grade"

--- BO Linhas 125 a 135 ---
125:                 IIF(THIS.this_lChkAtuStock, "1", "NULL") + ", " + ;
126:                 FormatarNumeroSQL(THIS.this_nPvens, 5) + ", " + ;
127:                 FormatarNumeroSQL(THIS.this_nPrecode, 5) + ", " + ;
128:                 IIF(THIS.this_lCkVtexUp, "1", "NULL") + ", " + ;
129:                 IIF(THIS.this_lCkAtuDesc, "1", "NULL") + ", " + ;
130:                 IIF(THIS.this_nVtexProdId = 0, "NULL", FormatarNumeroSQL(THIS.this_nVtexProdId, 0)) + ")"
131: 
132:             IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
133:                 THIS.RegistrarAuditoria("I")
134:                 loc_lSucesso = .T.
135:             ELSE

--- BO Linhas 164 a 174 ---
164:                 "chkatustock = " + IIF(THIS.this_lChkAtuStock, "1", "NULL") + ", " + ;
165:                 "pvens = "       + FormatarNumeroSQL(THIS.this_nPvens, 5) + ", " + ;
166:                 "precode = "     + FormatarNumeroSQL(THIS.this_nPrecode, 5) + ", " + ;
167:                 "ckvtexup = "    + IIF(THIS.this_lCkVtexUp, "1", "NULL") + ", " + ;
168:                 "ckAtudesc = "   + IIF(THIS.this_lCkAtuDesc, "1", "NULL") + ", " + ;
169:                 "vtexProdId = "  + IIF(THIS.this_nVtexProdId = 0, "NULL", ;
170:                                       FormatarNumeroSQL(THIS.this_nVtexProdId, 0)) + ;
171:                 " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
172: 
173:             IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
174:                 THIS.RegistrarAuditoria("A")

--- BO Linhas 165 a 175 ---
165:                 "pvens = "       + FormatarNumeroSQL(THIS.this_nPvens, 5) + ", " + ;
166:                 "precode = "     + FormatarNumeroSQL(THIS.this_nPrecode, 5) + ", " + ;
167:                 "ckvtexup = "    + IIF(THIS.this_lCkVtexUp, "1", "NULL") + ", " + ;
168:                 "ckAtudesc = "   + IIF(THIS.this_lCkAtuDesc, "1", "NULL") + ", " + ;
169:                 "vtexProdId = "  + IIF(THIS.this_nVtexProdId = 0, "NULL", ;
170:                                       FormatarNumeroSQL(THIS.this_nVtexProdId, 0)) + ;
171:                 " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
172: 
173:             IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
174:                 THIS.RegistrarAuditoria("A")
175:                 loc_lSucesso = .T.


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormSIGPRVTX.prg
- BO: C:\4c\projeto\app\classes\SIGPRVTXBO.prg
