CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~3786: Coluna 'descs' NAO EXISTE na tabela 'sigcdpro' (referenciada como a.descs)


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigcdpro
CREATE TABLE [dbo].[SigCdPro](
	[matprincs] [char](14) NOT NULL,
	[dtcomps] [datetime] NULL,
	[cbars] [numeric](14, 0) NOT NULL,
	[cgrus] [char](3) NOT NULL,
	[clfiscals] [char](10) NOT NULL,
	[colecoes] [char](10) NOT NULL,
	[comis] [numeric](5, 2) NOT NULL,
	[cpros] [char](14) NOT NULL,
	[cunis] [char](3) NOT NULL,
	[custofs] [numeric](11, 3) NOT NULL,
	[cvens] [char](10) NOT NULL,
	[datas] [datetime] NULL,
	[datatrans] [datetime] NULL,
	[descfis] [text] NULL,
	[dpros] [char](65) NOT NULL,
	[dtfilms] [datetime] NULL,
	[fcustos] [numeric](11, 5) NOT NULL,
	[figjpgs] [text] NULL,
	[flagctabs] [bit] NOT NULL,
	[fvendas] [numeric](7, 3) NOT NULL,
	[icms] [numeric](5, 2) NOT NULL,
	[ifors] [char](10) NOT NULL,
	[linhas] [char](10) NOT NULL,
	[locals] [char](10) NOT NULL,
	[margems] [numeric](9, 6) NOT NULL,
	[moecs] [char](3) NOT NULL,
	[moecusfs] [char](3) NOT NULL,
	[moedas] [char](3) NOT NULL,
	[moepcs] [char](3) NOT NULL,
	[moepvs] [char](3) NOT NULL,
	[moevs] [char](3) NOT NULL,
	[notas] [char](6) NOT NULL,
	[obspeds] [char](30) NOT NULL,
	[obspes] [char](30) NOT NULL,
	[origmercs] [char](1) NOT NULL,
	[pcuss] [numeric](11, 5) NOT NULL,
	[pesoms] [numeric](8, 3) NOT NULL,
	[pvens] [numeric](11, 5) NOT NULL,
	[pvideals] [numeric](11, 5) NOT NULL,
	[qmins] [numeric](9, 3) NOT NULL,
	[reffs] [char](40) NOT NULL,
	[sittricms] [char](3) NOT NULL,
	[tcomps] [bit] NOT NULL,
	[tipos] [char](1) NOT NULL,
	[transps] [bit] NOT NULL,
	[valors] [numeric](11, 2) NOT NULL,
	[varias] [numeric](1, 0) NOT NULL,
	[situas] [numeric](1, 0) NOT NULL,
	[dtincs] [datetime] NULL,
	[sgrus] [char](6) NOT NULL,
	[metals] [char](2) NOT NULL,
	[teors] [char](2) NOT NULL,
	[cftios] [char](2) NOT NULL,
	[codservs] [char](4) NOT NULL,
	[mftios] [char](3) NOT NULL,
	[pftios] [numeric](11, 3) NOT NULL,
	[codcors] [char](4) NOT NULL,
	[codtams] [char](4) NOT NULL,
	[compos] [char](30) NOT NULL,
	[montadescs] [numeric](1, 0) NOT NULL,
	[digimaxs] [numeric](2, 0) NOT NULL,
	[ordcompos] [numeric](2, 0) NOT NULL,
	[ean13] [numeric](13, 0) NOT NULL,
	[cproeqs] [char](14) NOT NULL,
	[qtdcpnts] [numeric](3, 0) NOT NULL,
	[impetiqs] [bit] NOT NULL,
	[chkfunds] [bit] NOT NULL,
	[casas] [numeric](2, 0) NOT NULL,
	[mercs] [char](3) NOT NULL,
	[pesobs] [numeric](7, 3) NOT NULL,
	[tamhs] [numeric](5, 2) NOT NULL,
	[tamls] [numeric](5, 2) NOT NULL,
	[tamps] [numeric](5, 2) NOT NULL,
	[tptribs] [char](4) NOT NULL,
	[volumes] [numeric](3, 0) NOT NULL,
	[ipis] [char](1) NOT NULL,
	[dpro2s] [char](45) NOT NULL,
	[dsccompras] [text] NULL,
	[encoms] [numeric](1, 0) NOT NULL,
	[figtecs] [text] NULL,
	[obscompras] [text] NULL,
	[codacbs] [char](3) NOT NULL,
	[cravcers] [numeric](1, 0) NOT NULL,
	[cunips] [char](3) NOT NULL,
	[obsetqs] [char](10) NOT NULL,
	[ultcomps] [datetime] NULL,
	[vultcomps] [numeric](11, 2) NOT NULL,
	[multcomps] [char](3) NOT NULL,
	[markupa] [numeric](11, 3) NOT NULL,
	[tinsts] [numeric](
-- (truncado)


## Trechos relevantes do Form (C:\4c\projeto\app\forms\cadastros\FormLin.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\LinBO.prg):

--- BO Linhas 58 a 68 ---
58: 
59:         TRY
60:             IF USED(par_cAliasCursor)
61:                 SELECT (par_cAliasCursor)
62:                 THIS.this_cLinhas     = TratarNulo(linhas,     "C")
63:                 THIS.this_cDescs      = TratarNulo(descs,      "C")
64:                 THIS.this_cCodCols    = TratarNulo(codcols,    "C")
65:                 THIS.this_cPedidos    = TratarNulo(pedidos,    "C")
66:                 THIS.this_cTpCustos   = TratarNulo(tpcustos,   "C")
67:                 THIS.this_cTpVendas   = TratarNulo(tpvendas,   "C")
68:                 THIS.this_cTpPesos    = TratarNulo(tppesos,    "C")

--- BO Linhas 91 a 101 ---
91:     PROCEDURE Buscar(par_cFiltro)
92:         LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
93:         loc_lSucesso = .F.
94: 
95:         TRY
96:             loc_cSQL = "SELECT linhas, descs, tpcustos, tpvendas" + ;
97:                        " FROM SigCdLin" + ;
98:                        " ORDER BY linhas"
99: 
100:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
101: 

--- BO Linhas 125 a 135 ---
125:             RETURN .F.
126:         ENDIF
127: 
128:         TRY
129: 
130:             loc_cSQL = "SELECT linhas, descs, codcols, pedidos," + ;
131:                        " tpcustos, tpvendas, tppesos," + ;
132:                        " teors, breservas, qtpcs, chkpesags," + ;
133:                        " ids, bonus, gernetiqs, vlrfixos, figjpgs" + ;
134:                        " FROM SigCdLin" + ;
135:                        " WHERE linhas = " + EscaparSQL(ALLTRIM(par_cLinhas))

--- BO Linhas 165 a 175 ---
165:         LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
166:         loc_lSucesso = .F.
167: 
168:         TRY
169:             loc_cSQL = "INSERT INTO SigCdLin" + ;
170:                        " (linhas, descs, codcols, pedidos," + ;
171:                        " tpcustos, tpvendas, tppesos," + ;
172:                        " teors, breservas, qtpcs, chkpesags," + ;
173:                        " ids, bonus, gernetiqs, vlrfixos)" + ;
174:                        " VALUES (" + ;
175:                        EscaparSQL(THIS.this_cLinhas)    + ", " + ;

--- BO Linhas 210 a 220 ---
210:         LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
211:         loc_lSucesso = .F.
212: 
213:         TRY
214:             loc_cSQL = "UPDATE SigCdLin SET" + ;
215:                        " descs       = " + EscaparSQL(THIS.this_cDescs)     + ", " + ;
216:                        " codcols     = " + EscaparSQL(THIS.this_cCodCols)   + ", " + ;
217:                        " pedidos     = " + EscaparSQL(THIS.this_cPedidos)   + ", " + ;
218:                        " tpcustos    = " + EscaparSQL(THIS.this_cTpCustos)  + ", " + ;
219:                        " tpvendas    = " + EscaparSQL(THIS.this_cTpVendas)  + ", " + ;
220:                        " tppesos     = " + EscaparSQL(THIS.this_cTpPesos)   + ", " + ;

--- BO Linhas 688 a 698 ---
688:     PROCEDURE CarregarMateriasPrimas()
689:         LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
690:         loc_lSucesso = .F.
691: 
692:         TRY
693:             loc_cSQL = "SELECT a.cpros AS CPros, a.descs AS DPros, a.cgrus AS CGrus" + ;
694:                        " FROM SigCdPro a" + ;
695:                        " ORDER BY a.cpros"
696: 
697:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crMtPrima")
698: 


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\cadastros\FormLin.prg
- BO: C:\4c\projeto\app\classes\LinBO.prg
