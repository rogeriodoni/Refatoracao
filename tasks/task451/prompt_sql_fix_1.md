CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~2552: INSERT coluna 'chkchqf' NAO EXISTE na tabela 'sigcdmp'
- [SQL-SCHEMA] Linha ~2624: UPDATE coluna 'chkchqf' NAO EXISTE na tabela 'sigcdmp'


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigcdmp
CREATE TABLE [dbo].[SIGCDMP](
	[barcmds] [text] NULL,
	[barras] [numeric](2, 0) NOT NULL,
	[expas] [text] NULL,
	[expds] [text] NULL,
	[fonte2s] [text] NULL,
	[fontemp1s] [text] NULL,
	[fontemp2s] [text] NULL,
	[fontes] [text] NULL,
	[graficos] [bit] NOT NULL,
	[impres] [char](30) NOT NULL,
	[maxcols] [numeric](2, 0) NOT NULL,
	[tipos] [numeric](1, 0) NOT NULL,
	[titulos] [numeric](2, 0) NOT NULL,
	[exps] [bit] NOT NULL,
	[rates] [numeric](5, 2) NOT NULL,
	[finals] [text] NULL,
	[tpbarra] [numeric](2, 0) NOT NULL,
	[cpgchq1s] [text] NULL,
	[nchqfs] [numeric](1, 0) NOT NULL,
	[nclano1s] [numeric](5, 2) NOT NULL,
	[nclcid1s] [numeric](5, 2) NOT NULL,
	[ncldia1s] [numeric](5, 2) NOT NULL,
	[nclmes1s] [numeric](5, 2) NOT NULL,
	[nclnom1s] [numeric](5, 2) NOT NULL,
	[nclvext1s] [numeric](5, 2) NOT NULL,
	[nclvext2s] [numeric](5, 2) NOT NULL,
	[nclvl1s] [numeric](5, 2) NOT NULL,
	[nliano1s] [numeric](5, 2) NOT NULL,
	[nlicid1s] [numeric](5, 2) NOT NULL,
	[nlidia1s] [numeric](5, 2) NOT NULL,
	[nlimes1s] [numeric](5, 2) NOT NULL,
	[nlinom1s] [numeric](5, 2) NOT NULL,
	[nlivext1s] [numeric](5, 2) NOT NULL,
	[nlivext2s] [numeric](5, 2) NOT NULL,
	[nlivl1s] [numeric](5, 2) NOT NULL,
	[ntpimpres] [numeric](4, 0) NOT NULL,
	[cidchaves] [char](20) NOT NULL,
	[ajdens] [numeric](2, 0) NOT NULL,
	[ajhorzs] [numeric](3, 0) NOT NULL,
	[ajvelos] [numeric](1, 0) NOT NULL,
	[ajverts] [numeric](2, 0) NOT NULL,
	[cetiquetas] [numeric](3, 0) NOT NULL,
	[impetis] [numeric](1, 0) NOT NULL,
	[npadrao] [numeric](1, 0) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\cadastros\FormImp.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\ImpBO.prg):

--- BO Linhas 106 a 116 ---
106:                 THIS.this_nTitulos     = TratarNulo(titulos,    "N")
107:                 THIS.this_nBarras      = TratarNulo(barras,     "N")
108:                 THIS.this_nMaxcols     = TratarNulo(maxcols,    "N")
109:                 THIS.this_lExps        = (TratarNulo(exps,      "N") = 1)
110:                 THIS.this_lGraficos    = (TratarNulo(graficos,  "N") = 1)
111:                 THIS.this_lChkChqf     = (TratarNulo(chkChqf,   "N") = 1)
112:                 THIS.this_nTpImpres    = TratarNulo(nTpImpres,  "N")
113:                 THIS.this_nImpEtis     = TratarNulo(ImpEtis,    "N")
114:                 THIS.this_cTipos       = TratarNulo(Tipos,      "C")
115:                 THIS.this_cCetiquetas  = TratarNulo(cetiquetas, "C")
116:                 THIS.this_nAjVerts     = TratarNulo(AjVerts,    "N")

--- BO Linhas 203 a 213 ---
203:         TRY
204:             loc_cChave = fUniqueIds()
205:             THIS.this_cIdChaves = loc_cChave
206: 
207:             loc_cSQL = "INSERT INTO SigCdmp (impres, cIdChaves, rates, titulos, barras, maxcols," + ;
208:                 " exps, graficos, chkChqf, nTpImpres, ImpEtis, Tipos, cetiquetas," + ;
209:                 " AjVerts, AjHorzs, AjVelos, AjDens," + ;
210:                 " expds, expas, barcmds, fontes, fonte2s, fontemp1s," + ;
211:                 " nlivl1s, nclvl1s, nlivext1s, nclvext1s, nlivext2s, nclvext2s," + ;
212:                 " nlinom1s, nclnom1s, nlicid1s, nclcid1s," + ;
213:                 " nlidia1s, ncldia1s, nlimes1s, nclmes1s, nliano1s, nclano1s)" + ;

--- BO Linhas 281 a 291 ---
281:                 " titulos  = " + FormatarNumeroSQL(THIS.this_nTitulos, 0) + "," + ;
282:                 " barras   = " + FormatarNumeroSQL(THIS.this_nBarras,  0) + "," + ;
283:                 " maxcols  = " + FormatarNumeroSQL(THIS.this_nMaxcols, 0) + "," + ;
284:                 " exps     = " + IIF(THIS.this_lExps,     "1", "0") + "," + ;
285:                 " graficos = " + IIF(THIS.this_lGraficos, "1", "0") + "," + ;
286:                 " chkChqf  = " + IIF(THIS.this_lChkChqf,  "1", "0") + "," + ;
287:                 " nTpImpres = " + FormatarNumeroSQL(THIS.this_nTpImpres, 0) + "," + ;
288:                 " ImpEtis  = " + FormatarNumeroSQL(THIS.this_nImpEtis,   0) + "," + ;
289:                 " Tipos    = " + EscaparSQL(THIS.this_cTipos) + "," + ;
290:                 " cetiquetas = " + EscaparSQL(THIS.this_cCetiquetas) + "," + ;
291:                 " AjVerts  = " + FormatarNumeroSQL(THIS.this_nAjVerts, 0) + "," + ;

--- BO Linhas 421 a 431 ---
421:         LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
422:         loc_lSucesso = .F.
423: 
424:         TRY
425:             loc_cSQL = "SELECT impres, cIdChaves, rates, titulos, barras, maxcols," + ;
426:                 " exps, graficos, chkChqf, nTpImpres, ImpEtis, Tipos, cetiquetas," + ;
427:                 " AjVerts, AjHorzs, AjVelos, AjDens," + ;
428:                 " expds, expas, barcmds, fontes, fonte2s, fontemp1s," + ;
429:                 " nlivl1s, nclvl1s, nlivext1s, nclvext1s, nlivext2s, nclvext2s," + ;
430:                 " nlinom1s, nclnom1s, nlicid1s, nclcid1s," + ;
431:                 " nlidia1s, ncldia1s, nlimes1s, nclmes1s, nliano1s, nclano1s" + ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\cadastros\FormImp.prg
- BO: C:\4c\projeto\app\classes\ImpBO.prg
