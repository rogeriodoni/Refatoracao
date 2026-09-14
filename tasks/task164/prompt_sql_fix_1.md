CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~2837: INSERT coluna 'ednests' NAO EXISTE na tabela 'sigpcool'
- [SQL-SCHEMA] Linha ~2876: UPDATE coluna 'ednests' NAO EXISTE na tabela 'sigpcool'


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigpcool
CREATE TABLE [dbo].[SigPcOoL](
	[tipos] [char](10) NOT NULL,
	[emps] [char](3) NOT NULL,
	[dopes] [char](20) NOT NULL,
	[numes] [numeric](6, 0) NOT NULL,
	[empds] [char](3) NOT NULL,
	[dopeds] [char](20) NOT NULL,
	[numeds] [numeric](11, 0) NOT NULL,
	[datas] [datetime] NULL,
	[usuars] [char](10) NOT NULL,
	[produtos] [text] NULL,
	[cidchaves] [char](20) NOT NULL,
	[edndests] [char](29) NOT NULL,
	[empdopnums] [char](29) NOT NULL,
	[processos] [char](20) NOT NULL,
	[nopers] [numeric](9, 0) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormSIGPRCNB.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SIGPRCNBBO.prg):

--- BO Linhas 62 a 72 ---
62:     this_cDopeds           = ""    && dopeds      CHAR(20)      - Referencia titulo (SigMvCcr.Titulos)
63:     this_nNumeds           = 0     && numeds      NUMERIC(11,0) - Numero sequencial CNAB
64:     this_dDataS            = {}    && datas       DATETIME      - Data/hora geracao
65:     this_cUsuars           = ""    && usuars      CHAR(10)      - Usuario que gerou
66:     this_cProdutos         = ""    && produtos    TEXT          - Conteudo linha CNAB gerada
67:     this_cEdndests         = ""    && ednests     CHAR(29)      - EmpDopNums origem
68:     this_cEmpDopNums       = ""    && empdopnums  CHAR(29)      - Chave EmpDopNums titulo
69:     this_cProcessos        = ""    && processos   CHAR(20)      - Processo ('CNAB')
70:     this_nNopers           = 0     && nopers      NUMERIC(9,0)  - Numero operacao SigMvCcr
71: 
72:     *-- -----------------------------------------------------------------------

--- BO Linhas 137 a 147 ---
137:                 THIS.this_cDopeds       = TratarNulo(dopeds,       "C")
138:                 THIS.this_nNumeds       = TratarNulo(numeds,       "N")
139:                 THIS.this_dDataS        = TratarNulo(datas,        "D")
140:                 THIS.this_cUsuars       = TratarNulo(usuars,       "C")
141:                 THIS.this_cProdutos     = TratarNulo(produtos,     "C")
142:                 THIS.this_cEdndests     = TratarNulo(ednests,      "C")
143:                 THIS.this_cEmpDopNums   = TratarNulo(empdopnums,   "C")
144:                 THIS.this_cProcessos    = TratarNulo(processos,    "C")
145:                 THIS.this_nNopers       = TratarNulo(nopers,       "N")
146:                 loc_lSucesso = .T.
147:             ENDIF

--- BO Linhas 179 a 189 ---
179:                 THIS.this_cCidChaves = PADR(LOWER(SYS(2015)) + LOWER(SYS(2015)), 20)
180:             ENDIF
181: 
182:             loc_cSQL = "INSERT INTO SigPcOol " + ;
183:                 "(cidchaves, tipos, emps, dopes, numes, empds, dopeds, numeds, " + ;
184:                 " datas, usuars, produtos, ednests, empdopnums, processos, nopers) " + ;
185:                 "VALUES (" + ;
186:                 EscaparSQL(THIS.this_cCidChaves)    + ", " + ;
187:                 EscaparSQL(THIS.this_cTipos)        + ", " + ;
188:                 EscaparSQL(THIS.this_cEmps)         + ", " + ;
189:                 EscaparSQL(THIS.this_cDopes)        + ", " + ;

--- BO Linhas 226 a 236 ---
226:                 "empds = "        + EscaparSQL(THIS.this_cEmpDs)         + ", " + ;
227:                 "dopeds = "       + EscaparSQL(THIS.this_cDopeds)        + ", " + ;
228:                 "numeds = "       + FormatarNumeroSQL(THIS.this_nNumeds)  + ", " + ;
229:                 "usuars = "       + EscaparSQL(gc_4c_UsuarioLogado)      + ", " + ;
230:                 "produtos = "     + EscaparSQL(THIS.this_cProdutos)      + ", " + ;
231:                 "ednests = "      + EscaparSQL(THIS.this_cEdndests)      + ", " + ;
232:                 "empdopnums = "   + EscaparSQL(THIS.this_cEmpDopNums)    + ", " + ;
233:                 "processos = "    + EscaparSQL(THIS.this_cProcessos)     + ", " + ;
234:                 "nopers = "       + FormatarNumeroSQL(THIS.this_nNopers) + ;
235:                 " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
236: 


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormSIGPRCNB.prg
- BO: C:\4c\projeto\app\classes\SIGPRCNBBO.prg
