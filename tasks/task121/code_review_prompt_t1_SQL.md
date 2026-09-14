# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (22)
- [SQL-ASPAS] Linha 103: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "WHERE EmpDopNums = '" + loc_lcEdn + "'"
- [SQL-ASPAS] Linha 120: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "WHERE a.EmpDopNums = '" + loc_lcEdn + "' " + ;
- [SQL-ASPAS] Linha 138: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "WHERE a.EmpDopNums = '" + loc_lcEdn + "' " + ;
- [SQL-ASPAS] Linha 150: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "WHERE a.EmpDopNums = '" + loc_lcEdn + "' " + ;
- [SQL-ASPAS] Linha 164: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "WHERE EmpDopNums = '" + loc_lcEdn + "'"
- [SQL-ASPAS] Linha 176: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "WHERE a.EmpDopNums = '" + loc_lcEdn + "' " + ;
- [SQL-ASPAS] Linha 704: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: loc_cSQL = "SELECT Descs FROM SigCdCor WHERE Cods = '" + loc_lcCor + "'"
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, LCSQL, IDIOMA, DOPES, PBRUS, PLIQS, VLFRETES, VLSEGUROS, CITENS, CPROS, MATS, CGRUS, FPAGS, UNICOMPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, LCSQL, IDIOMA, DOPES, PBRUS, PLIQS, VLFRETES, VLSEGUROS, CITENS, CPROS, MATS, CGRUS, FPAGS, UNICOMPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CHKENDOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, LCSQL, IDIOMA, DOPES, PBRUS, PLIQS, VLFRETES, VLSEGUROS, CITENS, CPROS, MATS, CGRUS, FPAGS, UNICOMPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CHKENDDS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, LCSQL, IDIOMA, DOPES, PBRUS, PLIQS, VLFRETES, VLSEGUROS, CITENS, CPROS, MATS, CGRUS, FPAGS, UNICOMPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ITRAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, LCSQL, IDIOMA, DOPES, PBRUS, PLIQS, VLFRETES, VLSEGUROS, CITENS, CPROS, MATS, CGRUS, FPAGS, UNICOMPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CHKEMIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, LCSQL, IDIOMA, DOPES, PBRUS, PLIQS, VLFRETES, VLSEGUROS, CITENS, CPROS, MATS, CGRUS, FPAGS, UNICOMPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CHKPAIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, LCSQL, IDIOMA, DOPES, PBRUS, PLIQS, VLFRETES, VLSEGUROS, CITENS, CPROS, MATS, CGRUS, FPAGS, UNICOMPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CHKESPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, LCSQL, IDIOMA, DOPES, PBRUS, PLIQS, VLFRETES, VLSEGUROS, CITENS, CPROS, MATS, CGRUS, FPAGS, UNICOMPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CHKQTDS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, LCSQL, IDIOMA, DOPES, PBRUS, PLIQS, VLFRETES, VLSEGUROS, CITENS, CPROS, MATS, CGRUS, FPAGS, UNICOMPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CHKPESOBS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, LCSQL, IDIOMA, DOPES, PBRUS, PLIQS, VLFRETES, VLSEGUROS, CITENS, CPROS, MATS, CGRUS, FPAGS, UNICOMPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CHKPESOLS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, LCSQL, IDIOMA, DOPES, PBRUS, PLIQS, VLFRETES, VLSEGUROS, CITENS, CPROS, MATS, CGRUS, FPAGS, UNICOMPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CHKFRETE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, LCSQL, IDIOMA, DOPES, PBRUS, PLIQS, VLFRETES, VLSEGUROS, CITENS, CPROS, MATS, CGRUS, FPAGS, UNICOMPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CHKSEGURO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, LCSQL, IDIOMA, DOPES, PBRUS, PLIQS, VLFRETES, VLSEGUROS, CITENS, CPROS, MATS, CGRUS, FPAGS, UNICOMPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, LCSQL, IDIOMA, DOPES, PBRUS, PLIQS, VLFRETES, VLSEGUROS, CITENS, CPROS, MATS, CGRUS, FPAGS, UNICOMPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CHKTOTS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, LCSQL, IDIOMA, DOPES, PBRUS, PLIQS, VLFRETES, VLSEGUROS, CITENS, CPROS, MATS, CGRUS, FPAGS, UNICOMPOS

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
lcQuery = [Select a.CItens, a.CodBarras, a.CPros, a.DPros, a.Units, a.Pesos, a.Qtds, a.Totas ] + ;
		    [From SigMvItn a ] + ;
If (loCnx.SqlExecute(lcQuery, [LocalMvItn]) < 1)
lcQuery = [Select a.CItens, a.CPros, a.CodBarras, a.Qtds, a.CodCors, a.CodTams ] + ;
		    [From SigMvIts a ] + ;
If (loCnx.SqlExecute(lcQuery, [LocalMvIts]) < 1)
lcQuery = [Select a.CItens, a.CPros, a.Mats, a.Pesos, a.Qtds, p.Varias, b.NTipoJoals ] + ;
		    [From SigSubMv a, SigCdPro p, SigCdGrp b ] + ;
If (loCnx.SqlExecute(lcQuery, [LocalSubMv]) < 1)
lcSql = [Select a.Fpags, a.MoeFpgs, a.Valos, b.Descrs, b.Trocos ] + ;
		  [From SigMvPar a, SigOpFp b ] + ;
loCnx.SqlExecute(lcSql, [LocalPar1])
	Select Sum(1) as Total, FPags, MoeFpgs, Valos, Descrs, Trocos ;
	  From LocalPar1 ;
	Select crInvoices
Delete File &lcArq.
		lcQuery = [Select Expressao, Traducao ] + ;
					[From SigCdDic ] + ;
		If (.poDataMgr.SqlExecute(lcQuery, [crSigCdDic]) < 1)
lcQuery = [Select CasQtds ] + ;
		    [From SigOpCdd ] + ;
If (loCnx.SqlExecute(lcQuery, [LocalOpe]) < 1)
Select LocalOpe
lcQuery = [Select * ] + ;
		    [From SigOpCdi ] + ;
If (loCnx.SqlExecute(lcQuery, [LocalIvOpe]) < 1)
Select LocalIvOpe
		Select crTmpCli
		Select crTmpCli
		Select [ ] as Agrupar,Sum(Qtds) as Qtds ;
		  From LocalMvItn ;
	Select [ ] as Agrupar, Sum(Totas) as Totas ;
	  From LocalMvItn ;
	Select LocalTPar2
	Select [ ] as Agrupar, Sum(Valos * Iif(Trocos=1, -1, 1)) as Valos ;
	  From LocalPar ;
	Select LocalTPar
	Select LocalPar
	Select crBranco
	Append Memo Branco From (lcBrc) Overwrite
	Select LocalMvItn
		Select Qtds, CodCors, CodTams ;
		  From LocalMvIts ;
		Select crItens
			Select Qtds, Space(4) as CodCors, Space(4) as CodTams ;
			  From LocalMvItn ;
		Select crItens
					Select crSigCdDic
					Select crSigCdDic
			Insert Into crInvoices (Dopes, chkTits, lblTits, chkLists, lblLists, ;
			Select LocalSubMv
				Select Mats, Qtds, Pesos as PCompos, Varias, NTipoJoals ;
				  From LocalSubMv ;
				lcQuery = [Select a.Mats, a.Qtds, a.Pesos as PCompos, p.Varias, b.NTipoJoals, u.Fators ] + ;
						    [From SigPrCpo a, SigCdPro p, SigCdGrp b, SigCdUni u ] + ;
				If (loCnx.SqlExecute(lcQuery, [LocalCompo]) < 1)
				Update LocalCompo ;
			Select LocalCompo
	Update crInvoices ;
Select crInvoices
Update crInvoices Set TotPag = _PageNo
Select crInvoices
	Select crInvoices
Delete File &lcArq.

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReIiv.prg) - TRECHOS RELEVANTES PARA PASS SQL (544 linhas total):

*-- Linhas 89 a 192:
89:             IF loc_lContinuar
90:                 THIS.ConfigurarCabecalho()
91:                 THIS.ConfigurarBotoes()
92:                 THIS.ConfigurarPageFrame()
93:                 THIS.ConfigurarPaginaLista()
94:                 THIS.ConfigurarPaginaDados()
95: 
96:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
97:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
98:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
99:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
100: 
101:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
102:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
103:                 THIS.Visible  = .T.
104:                 loc_lSucesso  = .T.
105:             ENDIF
106:         CATCH TO loc_oErro
107:             THIS.this_cMensagemErro = loc_oErro.Message
108:             MsgErro(loc_oErro.Message + CHR(13) + ;
109:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
110:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
111:         ENDTRY
112:         RETURN loc_lSucesso
113:     ENDPROC
114: 
115:     *--------------------------------------------------------------------------
116:     * ConfigurarCabecalho - Container escuro superior com t[i]tulo do relat[o]rio
117:     *--------------------------------------------------------------------------
118:     PROTECTED PROCEDURE ConfigurarCabecalho()
119:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
120:         WITH THIS.cnt_4c_Cabecalho
121:             .Top         = 0
122:             .Left        = 0
123:             .Width       = THIS.Width
124:             .Height      = 80
125:             .BackStyle   = 1
126:             .BackColor   = RGB(100, 100, 100)
127:             .BorderWidth = 0
128:             .Visible     = .T.
129: 
130:             .AddObject("lbl_4c_Sombra", "Label")
131:             WITH .lbl_4c_Sombra
132:                 .Top       = 22
133:                 .Left      = 22
134:                 .Width     = THIS.Width
135:                 .Height    = 30
136:                 .Caption   = THIS.Caption
137:                 .FontName  = "Tahoma"
138:                 .FontSize  = 14
139:                 .FontBold  = .T.
140:                 .ForeColor = RGB(0, 0, 0)
141:                 .BackStyle = 0
142:                 .Visible   = .T.
143:             ENDWITH
144: 
145:             .AddObject("lbl_4c_Titulo", "Label")
146:             WITH .lbl_4c_Titulo
147:                 .Top       = 20
148:                 .Left      = 20
149:                 .Width     = THIS.Width
150:                 .Height    = 30
151:                 .Caption   = THIS.Caption
152:                 .FontName  = "Tahoma"
153:                 .FontSize  = 14
154:                 .FontBold  = .T.
155:                 .ForeColor = RGB(255, 255, 255)
156:                 .BackStyle = 0
157:                 .Visible   = .T.
158:             ENDWITH
159:         ENDWITH
160:     ENDPROC
161: 
162:     *--------------------------------------------------------------------------
163:     * ConfigurarBotoes - CommandGroup com 4 bot[o]es de relat[o]rio
164:     *   Geometria EXATA do framework frmrelatorio:
165:     *     Top=0, Left=529, Width=273, Height=80, ButtonCount=4
166:     *   Bot[o]es: Visualizar(1)/Imprimir(2)/Excel(3)/Encerrar(4)
167:     *--------------------------------------------------------------------------
168:     PROTECTED PROCEDURE ConfigurarBotoes()
169:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
170:         WITH THIS.cmg_4c_Botoes
171:             .Top           = 0
172:             .Left          = 529
173:             .Width         = 273
174:             .Height        = 80
175:             .ButtonCount   = 4
176:             .BackStyle     = 0
177:             .BorderStyle   = 0
178:             .BorderColor   = RGB(136, 189, 188)
179:             .SpecialEffect = 1
180:             .Themes        = .F.
181:             .Visible       = .T.
182: 
183:             WITH .Buttons(1)
184:                 .Top             = 5
185:                 .Left            = 5
186:                 .Width           = 65
187:                 .Height          = 70
188:                 .Caption         = "Visualizar"
189:                 .FontBold        = .T.
190:                 .FontItalic      = .T.
191:                 .BackColor       = RGB(255, 255, 255)
192:                 .ForeColor       = RGB(90, 90, 90)

*-- Linhas 690 a 544:

