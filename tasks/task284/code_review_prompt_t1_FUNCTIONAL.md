# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (16)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Referência Fornecedor, Parcelas, Preço, Preço De. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Referência Fornecedor, Parcelas, Preço, Preço De. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Qtde' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Referência Fornecedor, Parcelas, Preço, Preço De. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Referência' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Referência Fornecedor, Parcelas, Preço, Preço De. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'P.Venda' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Referência Fornecedor, Parcelas, Preço, Preço De. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Opt_Tipo' (parent: SIGPRETQ): Top original=431 vs migrado 'obj_4c_Opt_Tipo' Top=10 (diff=421px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Impressora' (parent: SIGPRETQ): Top original=431 vs migrado 'obj_4c_Opt_Impressora' Top=52 (diff=379px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Impressora' (parent: SIGPRETQ): Left original=260 vs migrado 'obj_4c_Opt_Impressora' Left=9 (diff=251px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnCarregar' (parent: SIGPRETQ): Left original=373 vs migrado 'cmd_4c_BtnCarregar' Left=565 (diff=192px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptOrdem' (parent: SIGPRETQ): Top original=589 vs migrado 'obj_4c_OptOrdem' Top=4 (diff=585px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptOrdem' (parent: SIGPRETQ): Left original=601 vs migrado 'obj_4c_OptOrdem' Left=5 (diff=596px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optCompos' (parent: SIGPRETQ): Top original=562 vs migrado 'obj_4c_OptCompos' Top=5 (diff=557px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optCompos' (parent: SIGPRETQ): Left original=601 vs migrado 'obj_4c_OptCompos' Left=5 (diff=596px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnexcluir' (parent: SIGPRETQ): Left original=21 vs migrado 'cmd_4c_BtnExcluir' Left=596 (diff=575px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblTitulo' (parent: SIGPRETQ.cntSombra): Top original=17 vs migrado 'lbl_4c_LblTituloGrd' Top=375 (diff=358px, tolerancia=30px)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES FUNCIONAIS
- [CONTAINER-VISIVEL] TornarControlesVisiveis nao filtra containers ocultos (Visible=.F.). Adicionar INLIST
- [BUSCA-CURSOR] FormBuscaAuxiliar sem this_cCursorDestino no Modo 2
- [OPTIONGROUP-LEFT] Buttons sobrepostos - definir .Left, .Top, .AutoSize em CADA Button
- [CARGA-DADOS] Validar* sem chamada de carga / OptionGroup sem InteractiveChange
- [BINDEVENT-PARAMS] Handler sem LPARAMETERS (AfterRowColChange(par_nColIndex), KeyPress(par_nKeyCode, par_nShift))
- [STUB-MSGAVISO] Btn*Click com MsgAviso placeholder ao inves de logica real
- [LOSTFOCUS-SEM-GUARDIA] Handler abre busca sem verificar se valor mudou
- [INIT-DUPLICADO] Init() chama DODEFAULT() + InicializarForm() (duplicado)
- [METODO-INEXISTENTE] THIS.Metodo() chamado mas nao definido no Form. LLM pode ter inventado. IMPLEMENTAR ou REMOVER.

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEtq.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2566 linhas total):

*-- Linhas 25 a 143:
25: 	this_oBusinessObject = .NULL.
26: 
27: 	*====================================================================
28: 	* Init - DODEFAULT chama FormBase.Init -> InicializarForm
29: 	*====================================================================
30: 	PROCEDURE Init()
31: 		RETURN DODEFAULT()
32: 	ENDPROC
33: 
34: 	*====================================================================
35: 	* InicializarForm - Cria BO, cursor local e componentes
36: 	*====================================================================
37: 	PROTECTED PROCEDURE InicializarForm()
38: 		LOCAL loc_lSucesso, loc_oErro
39: 		loc_lSucesso = .F.
40: 
41: 		TRY
42: 			THIS.this_oBusinessObject = CREATEOBJECT("SigPrEtqBO")
43: 			IF VARTYPE(THIS.this_oBusinessObject) != "O"
44: 				MsgErro("Erro ao criar SigPrEtqBO", "Erro")
45: 				loc_lSucesso = .F.
46: 			ENDIF
47: 
48: 			SET NULL ON
49: 			CREATE CURSOR cursor_4c_Etiquetas ;
50: 				(Cpros C(14) NULL, DPros C(40) NULL, Reffs C(40) NULL, ;
51: 				 Qtds N(10,3) NULL, QtdeEtiq N(10,3) NULL, ;
52: 				 Pedido C(30) NULL, Obs C(10) NULL, PVens N(12,2) NULL, ;
53: 				 PrecoDe N(12,2) NULL, Parcelas N(2,0) NULL, ;
54: 				 Cpros2 C(14) NULL, Cpros3 C(14) NULL, Cpros4 C(14) NULL, ;
55: 				 empos C(3) NULL, empdopnums C(29) NULL, ;
56: 				 citens N(10,0) NULL, Pesos N(12,2) NULL, ;
57: 				 CodTams C(4) NULL, DPro2s C(45) NULL)
58: 			SET NULL OFF
59: 
60: 			INDEX ON Cpros TAG Cpros
61: 			INDEX ON RECNO() TAG Registros
62: 			SET ORDER TO
63: 
64: 			THIS.ConfigurarPageFrame()
65: 			THIS.TornarControlesVisiveis(THIS)
66: 
67: 			IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
68: 				THIS.this_oBusinessObject.CarregarConfiguracoes()
69: 				THIS.PopularTiposEtiqueta()
70: 				THIS.AplicarConfiguracoes()
71: 			ENDIF
72: 
73: 			loc_lSucesso = .T.
74: 
75: 		CATCH TO loc_oErro
76: 			MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
77: 			        " PROC=" + loc_oErro.Procedure, "Erro ao inicializar")
78: 			loc_lSucesso = .F.
79: 		ENDTRY
80: 
81: 		RETURN loc_lSucesso
82: 	ENDPROC
83: 
84: 	*====================================================================
85: 	* ConfigurarPageFrame - Orquestrador de layout do form OPERACIONAL
86: 	* Form SIGPRETQ nao tem PageFrame no SCX legado (form flat).
87: 	* Este metodo prepara a superficie do form (Picture de fundo) e
88: 	* delega para as sub-configuracoes: cabecalho e botoes de acao.
89: 	* Containers de trabalho (grid, filtros, impressora) serao criados
90: 	* nas proximas fases (4-8).
91: 	*====================================================================
92: 	PROTECTED PROCEDURE ConfigurarPageFrame()
93: 		THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
94: 		THIS.ConfigurarCabecalho()
95: 		THIS.ConfigurarBotoesAcao()
96: 		THIS.ConfigurarPaginaLista()
97: 		THIS.ConfigurarPaginaDados()
98: 	ENDPROC
99: 
100: 	*====================================================================
101: 	* ConfigurarCabecalho - Cabecalho cinza superior com titulo
102: 	*====================================================================
103: 	PROTECTED PROCEDURE ConfigurarCabecalho()
104: 		THIS.AddObject("cnt_4c_Cabecalho", "Container")
105: 		WITH THIS.cnt_4c_Cabecalho
106: 			.Top = 0
107: 			.Left = 0
108: 			.Width = THIS.Width
109: 			.Height = 80
110: 			.BackStyle = 1
111: 			.BackColor = RGB(100, 100, 100)
112: 			.BorderWidth = 0
113: 
114: 			.AddObject("lbl_4c_Sombra", "Label")
115: 			WITH .lbl_4c_Sombra
116: 				.AutoSize = .F.
117: 				.FontBold = .T.
118: 				.FontName = "Tahoma"
119: 				.FontSize = 18
120: 				.WordWrap = .T.
121: 				.Alignment = 0
122: 				.BackStyle = 0
123: 				.Caption = "Impress" + CHR(227) + "o de Etiquetas Selecionadas"
124: 				.Height = 40
125: 				.Left = 10
126: 				.Top = 18
127: 				.Width = THIS.Width
128: 				.ForeColor = RGB(0, 0, 0)
129: 			ENDWITH
130: 
131: 			.AddObject("lbl_4c_Titulo", "Label")
132: 			WITH .lbl_4c_Titulo
133: 				.AutoSize = .F.
134: 				.FontBold = .T.
135: 				.FontName = "Tahoma"
136: 				.FontSize = 18
137: 				.WordWrap = .T.
138: 				.Alignment = 0
139: 				.BackStyle = 0
140: 				.Caption = "Impress" + CHR(227) + "o de Etiquetas Selecionadas"
141: 				.Height = 46
142: 				.Left = 10
143: 				.Top = 17

*-- Linhas 150 a 193:
150: 	*====================================================================
151: 	* ConfigurarBotoesAcao - CommandGroup Imprimir + Encerrar
152: 	*====================================================================
153: 	PROTECTED PROCEDURE ConfigurarBotoesAcao()
154: 		THIS.AddObject("cmg_4c_BtnReport", "CommandGroup")
155: 		WITH THIS.cmg_4c_BtnReport
156: 			.Top = -2
157: 			.Left = THIS.Width - 162
158: 			.Width = 162
159: 			.Height = 85
160: 			.BackStyle = 0
161: 			.BorderStyle = 0
162: 			.SpecialEffect = 1
163: 			.ButtonCount = 2
164: 			.Themes = .F.
165: 			.ZOrder(0)
166: 
167: 			WITH .Buttons(1)
168: 				.Top = 5
169: 				.Left = 5
170: 				.Height = 75
171: 				.Width = 75
172: 				.FontBold = .T.
173: 				.FontItalic = .T.
174: 				.WordWrap = .T.
175: 				.Picture = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
176: 				.Caption = "\<Imprimir"
177: 				.ForeColor = RGB(90, 90, 90)
178: 				.BackColor = RGB(255, 255, 255)
179: 				.Themes = .F.
180: 			ENDWITH
181: 
182: 			WITH .Buttons(2)
183: 				.Top = 5
184: 				.Left = 81
185: 				.Height = 75
186: 				.Width = 75
187: 				.FontBold = .T.
188: 				.FontItalic = .T.
189: 				.FontName = "Comic Sans MS"
190: 				.FontSize = 8
191: 				.WordWrap = .T.
192: 				.Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
193: 				.Cancel = .T.

*-- Linhas 200 a 285:
200: 	ENDPROC
201: 
202: 	*====================================================================
203: 	* TornarControlesVisiveis - Torna controles visiveis recursivamente
204: 	* obj_4c_Opt_Impressora: skip Visible mas recursa filhos (Pattern #109)
205: 	*====================================================================
206: 	PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
207: 		LOCAL loc_i, loc_oControl
208: 		IF VARTYPE(par_oContainer) != "O"
209: 			RETURN
210: 		ENDIF
211: 		FOR loc_i = 1 TO par_oContainer.ControlCount
212: 			loc_oControl = par_oContainer.Controls(loc_i)
213: 			IF VARTYPE(loc_oControl) != "O"
214: 				LOOP
215: 			ENDIF
216: 			IF UPPER(loc_oControl.Name) = "OBJ_4C_OPT_IMPRESSORA"
217: 				THIS.TornarControlesVisiveis(loc_oControl)
218: 				LOOP
219: 			ENDIF
220: 			IF PEMSTATUS(loc_oControl, "Visible", 5)
221: 				loc_oControl.Visible = .T.
222: 			ENDIF
223: 			IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
224: 				THIS.TornarControlesVisiveis(loc_oControl)
225: 			ENDIF
226: 		ENDFOR
227: 	ENDPROC
228: 
229: 	*====================================================================
230: 	* Destroy - Libera BO e cursor local
231: 	*====================================================================
232: 	PROCEDURE Destroy()
233: 		IF VARTYPE(THIS.this_oBusinessObject) = "O"
234: 			THIS.this_oBusinessObject = .NULL.
235: 		ENDIF
236: 		IF USED("cursor_4c_Etiquetas")
237: 			USE IN cursor_4c_Etiquetas
238: 		ENDIF
239: 		DODEFAULT()
240: 	ENDPROC
241: 
242: 	*====================================================================
243: 	* ConfigurarPaginaLista - Filtros, grid e botoes de acao
244: 	*====================================================================
245: 	PROTECTED PROCEDURE ConfigurarPaginaLista()
246: 		LOCAL loc_nTop
247: 
248: 		*-- Linha 1: Empresa / Operacao (top=88)
249: 		loc_nTop = 88
250: 
251: 		THIS.AddObject("lbl_4c_LEmps", "Label")
252: 		WITH THIS.lbl_4c_LEmps
253: 			.AutoSize  = .F.
254: 			.Caption   = "Empresa:"
255: 			.Top       = loc_nTop + 3
256: 			.Left      = 12
257: 			.Width     = 58
258: 			.Height    = 18
259: 			.FontName  = "Tahoma"
260: 			.FontSize  = 8
261: 			.BackStyle = 0
262: 			.ForeColor = RGB(255, 255, 255)
263: 		ENDWITH
264: 
265: 		THIS.AddObject("txt_4c_Emps", "TextBox")
266: 		WITH THIS.txt_4c_Emps
267: 			.Top       = loc_nTop
268: 			.Left      = 73
269: 			.Width     = 36
270: 			.Height    = 22
271: 			.FontName  = "Tahoma"
272: 			.FontSize  = 8
273: 			.MaxLength = 3
274: 		ENDWITH
275: 
276: 		THIS.AddObject("lbl_4c_DEmps", "Label")
277: 		WITH THIS.lbl_4c_DEmps
278: 			.AutoSize  = .F.
279: 			.Caption   = ""
280: 			.Top       = loc_nTop + 3
281: 			.Left      = 112
282: 			.Width     = 200
283: 			.Height    = 18
284: 			.FontName  = "Tahoma"
285: 			.FontSize  = 8

*-- Linhas 399 a 433:
399: 			.FontName  = "Tahoma"
400: 			.FontSize  = 8
401: 			.Value     = 0
402: 		ENDWITH
403: 
404: 		THIS.AddObject("cmd_4c_BtnCarregar", "CommandButton")
405: 		WITH THIS.cmd_4c_BtnCarregar
406: 			.Top             = loc_nTop
407: 			.Left            = 565
408: 			.Width           = 26
409: 			.Height          = 26
410: 			.Caption         = ""
411: 			.Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
412: 			.DisabledPicture = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
413: 			.ToolTipText     = "Carregar de movimento"
414: 			.Themes          = .T.
415: 		ENDWITH
416: 
417: 		THIS.AddObject("cmd_4c_BtnExcluir", "CommandButton")
418: 		WITH THIS.cmd_4c_BtnExcluir
419: 			.Top             = loc_nTop
420: 			.Left            = 596
421: 			.Width           = 26
422: 			.Height          = 26
423: 			.Caption         = ""
424: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
425: 			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
426: 			.ToolTipText     = "Excluir linha selecionada"
427: 			.Themes          = .T.
428: 		ENDWITH
429: 
430: 		*-- Linha 3: Lista de Precos (top=144)
431: 		loc_nTop = 144
432: 
433: 		THIS.AddObject("lbl_4c_LLpreco", "Label")

*-- Linhas 623 a 1188:
623: 			APPEND BLANK
624: 		ENDIF
625: 
626: 		*-- BINDEVENTs
627: 		BINDEVENT(THIS.txt_4c_Emps,                  "KeyPress", THIS, "TxtEmpsKeyPress")
628: 		BINDEVENT(THIS.txt_4c_Dopes,                 "KeyPress", THIS, "TxtDopesKeyPress")
629: 		BINDEVENT(THIS.txt_4c_Cpros,                 "KeyPress", THIS, "TxtCprosKeyPress")
630: 		BINDEVENT(THIS.txt_4c_Dpros,                 "KeyPress", THIS, "TxtDprosKeyPress")
631: 		BINDEVENT(THIS.txt_4c_Qtds,                  "KeyPress", THIS, "TxtQtdsKeyPress")
632: 		BINDEVENT(THIS.txt_4c_Lpreco,                "KeyPress", THIS, "TxtLprecoKeyPress")
633: 		BINDEVENT(THIS.txt_4c_LPreco2,               "KeyPress", THIS, "TxtLPreco2KeyPress")
634: 		BINDEVENT(THIS.cmd_4c_BtnCarregar,           "Click",    THIS, "CmdBtnCarregarClick")
635: 		BINDEVENT(THIS.cmd_4c_BtnExcluir,            "Click",    THIS, "CmdBtnExcluirClick")
636: 		BINDEVENT(THIS.grd_4c_Etiquetas,             "KeyPress", THIS, "GrdEtiquetasKeyPress")
637: 		BINDEVENT(THIS.cmg_4c_BtnReport.Buttons(1), "Click",    THIS, "BtnImprimirClick")
638: 		BINDEVENT(THIS.cmg_4c_BtnReport.Buttons(2), "Click",    THIS, "BtnEncerrarClick")
639: 		BINDEVENT(THIS.txt_4c_Numes,                 "KeyPress", THIS, "TxtNumesKeyPress")
640: 		BINDEVENT(THIS.chk_4c_Lista,                 "Click",    THIS, "ChkListaClick")
641: 		BINDEVENT(THIS.chk_4c_Precio,                "Click",    THIS, "ChkPrecioClick")
642: 	ENDPROC
643: 
644: 	*====================================================================
645: 	* AlternarPagina - Stub (form flat, sem PageFrame)
646: 	*====================================================================
647: 	PROTECTED PROCEDURE AlternarPagina(par_nPagina)
648: 		RETURN
649: 	ENDPROC
650: 
651: 	*====================================================================
652: 	* GrdEtiquetasKeyPress - Enter na coluna 4 (Reffs) abre busca por ref
653: 	*====================================================================
654: 	PROCEDURE GrdEtiquetasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
655: 		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
656: 			RETURN
657: 		ENDIF
658: 		IF THIS.grd_4c_Etiquetas.ActiveColumn = 4
659: 			THIS.AbrirBuscaProdutoRef()
660: 		ENDIF
661: 	ENDPROC
662: 
663: 	*====================================================================
664: 	* TxtEmpsKeyPress - Valida ou abre busca de empresa
665: 	*====================================================================
666: 	PROCEDURE TxtEmpsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
667: 		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
668: 			RETURN
669: 		ENDIF
670: 		LOCAL loc_cEmps, loc_nRet, loc_oBusca
671: 		loc_cEmps = ALLTRIM(NVL(THIS.txt_4c_Emps.Value, ""))
672: 		IF !EMPTY(loc_cEmps)
673: 			loc_nRet = SQLEXEC(gnConnHandle, ;
674: 				"SELECT TOP 1 Emps, DEmps FROM SigCdEmp WHERE RTRIM(Emps)=" + EscaparSQL(loc_cEmps), ;
675: 				"cursor_4c_BuscaEmp")
676: 			IF loc_nRet > 0 AND USED("cursor_4c_BuscaEmp") AND RECCOUNT("cursor_4c_BuscaEmp") > 0
677: 				SELECT cursor_4c_BuscaEmp
678: 				THIS.lbl_4c_DEmps.Caption = ALLTRIM(cursor_4c_BuscaEmp.DEmps)
679: 				USE IN cursor_4c_BuscaEmp
680: 				THIS.txt_4c_Dopes.SetFocus()
681: 				RETURN
682: 			ENDIF
683: 			IF USED("cursor_4c_BuscaEmp")
684: 				USE IN cursor_4c_BuscaEmp
685: 			ENDIF
686: 		ENDIF
687: 		loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
688: 			"SigCdEmp", "cursor_4c_BuscaEmp", "Emps", ;
689: 			loc_cEmps, "Empresa", .T., .T., "")
690: 		IF VARTYPE(loc_oBusca) = "O"
691: 			IF !loc_oBusca.this_lAchouRegistro
692: 				loc_oBusca.mAddColuna("Emps",  "", "C" + CHR(243) + "d.")
693: 				loc_oBusca.mAddColuna("DEmps", "", "Empresa")
694: 				loc_oBusca.Show()
695: 			ENDIF
696: 			IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
697: 				SELECT cursor_4c_BuscaEmp
698: 				THIS.txt_4c_Emps.Value     = ALLTRIM(cursor_4c_BuscaEmp.Emps)
699: 				THIS.lbl_4c_DEmps.Caption  = ALLTRIM(cursor_4c_BuscaEmp.DEmps)
700: 				USE IN cursor_4c_BuscaEmp
701: 				THIS.txt_4c_Dopes.SetFocus()
702: 			ENDIF
703: 		ENDIF
704: 	ENDPROC
705: 
706: 	*====================================================================
707: 	* TxtDopesKeyPress - Valida ou abre busca de operacao (SigCdOpe)
708: 	*====================================================================
709: 	PROCEDURE TxtDopesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
710: 		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
711: 			RETURN
712: 		ENDIF
713: 		LOCAL loc_cDopes, loc_nRet, loc_oBusca
714: 		loc_cDopes = ALLTRIM(NVL(THIS.txt_4c_Dopes.Value, ""))
715: 		IF !EMPTY(loc_cDopes)
716: 			loc_nRet = SQLEXEC(gnConnHandle, ;
717: 				"SELECT TOP 1 Dopes FROM SigCdOpe WHERE RTRIM(Dopes)=" + EscaparSQL(loc_cDopes), ;
718: 				"cursor_4c_BuscaOpe")
719: 			IF loc_nRet > 0 AND USED("cursor_4c_BuscaOpe") AND RECCOUNT("cursor_4c_BuscaOpe") > 0
720: 				USE IN cursor_4c_BuscaOpe
721: 				THIS.txt_4c_Cpros.SetFocus()
722: 				RETURN
723: 			ENDIF
724: 			IF USED("cursor_4c_BuscaOpe")
725: 				USE IN cursor_4c_BuscaOpe
726: 			ENDIF
727: 		ENDIF
728: 		loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
729: 			"SigCdOpe", "cursor_4c_BuscaOpe", "Dopes", ;
730: 			loc_cDopes, "Opera" + CHR(231) + CHR(227) + "o", .T., .T., "")
731: 		IF VARTYPE(loc_oBusca) = "O"
732: 			IF !loc_oBusca.this_lAchouRegistro
733: 				loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
734: 				loc_oBusca.Show()
735: 			ENDIF
736: 			IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
737: 				SELECT cursor_4c_BuscaOpe
738: 				THIS.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
739: 				USE IN cursor_4c_BuscaOpe
740: 				THIS.txt_4c_Cpros.SetFocus()
741: 			ENDIF
742: 		ENDIF
743: 	ENDPROC
744: 
745: 	*====================================================================
746: 	* TxtCprosKeyPress - Busca produto por codigo, EAN13 ou codigo de barras
747: 	*====================================================================
748: 	PROCEDURE TxtCprosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
749: 		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
750: 			RETURN
751: 		ENDIF
752: 		LOCAL loc_cCodigo, loc_nRet
753: 		loc_cCodigo = ALLTRIM(NVL(THIS.txt_4c_Cpros.Value, ""))
754: 		IF !EMPTY(loc_cCodigo)
755: 			loc_nRet = SQLEXEC(gnConnHandle, ;
756: 				"SELECT TOP 1 Cpros, DPros FROM SigCdPro " + ;
757: 				"WHERE RTRIM(Cpros)=" + EscaparSQL(loc_cCodigo) + ;
758: 				" OR RTRIM(Ean13)="  + EscaparSQL(loc_cCodigo) + ;
759: 				" OR RTRIM(CBars)="  + EscaparSQL(loc_cCodigo), ;
760: 				"cursor_4c_BuscaProd")
761: 			IF loc_nRet > 0 AND USED("cursor_4c_BuscaProd") AND RECCOUNT("cursor_4c_BuscaProd") > 0
762: 				SELECT cursor_4c_BuscaProd
763: 				THIS.txt_4c_Cpros.Value = ALLTRIM(cursor_4c_BuscaProd.Cpros)
764: 				THIS.txt_4c_Dpros.Value = ALLTRIM(cursor_4c_BuscaProd.DPros)
765: 				USE IN cursor_4c_BuscaProd
766: 				THIS.txt_4c_Qtds.SetFocus()
767: 				RETURN
768: 			ENDIF
769: 			IF USED("cursor_4c_BuscaProd")
770: 				USE IN cursor_4c_BuscaProd
771: 			ENDIF
772: 		ENDIF
773: 		THIS.AbrirBuscaProdutoCodigo()
774: 	ENDPROC
775: 
776: 	*====================================================================
777: 	* TxtDprosKeyPress - Busca produto por descricao
778: 	*====================================================================
779: 	PROCEDURE TxtDprosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
780: 		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
781: 			RETURN
782: 		ENDIF
783: 		LOCAL loc_cDesc, loc_nRet
784: 		loc_cDesc = ALLTRIM(NVL(THIS.txt_4c_Dpros.Value, ""))
785: 		IF !EMPTY(loc_cDesc)
786: 			loc_nRet = SQLEXEC(gnConnHandle, ;
787: 				"SELECT TOP 1 Cpros, DPros FROM SigCdPro " + ;
788: 				"WHERE RTRIM(DPros)=" + EscaparSQL(loc_cDesc), ;
789: 				"cursor_4c_BuscaProd")
790: 			IF loc_nRet > 0 AND USED("cursor_4c_BuscaProd") AND RECCOUNT("cursor_4c_BuscaProd") > 0
791: 				SELECT cursor_4c_BuscaProd
792: 				THIS.txt_4c_Cpros.Value = ALLTRIM(cursor_4c_BuscaProd.Cpros)
793: 				THIS.txt_4c_Dpros.Value = ALLTRIM(cursor_4c_BuscaProd.DPros)
794: 				USE IN cursor_4c_BuscaProd
795: 				THIS.txt_4c_Qtds.SetFocus()
796: 				RETURN
797: 			ENDIF
798: 			IF USED("cursor_4c_BuscaProd")
799: 				USE IN cursor_4c_BuscaProd
800: 			ENDIF
801: 		ENDIF
802: 		THIS.AbrirBuscaProdutoDescricao()
803: 	ENDPROC
804: 
805: 	*====================================================================
806: 	* TxtQtdsKeyPress - Valida qtde e adiciona produto ao grid
807: 	*====================================================================
808: 	PROCEDURE TxtQtdsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
809: 		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
810: 			RETURN
811: 		ENDIF
812: 		LOCAL loc_cCpros, loc_nQtds
813: 		loc_cCpros = ALLTRIM(NVL(THIS.txt_4c_Cpros.Value, ""))
814: 		loc_nQtds  = NVL(THIS.txt_4c_Qtds.Value, 0)
815: 		IF EMPTY(loc_cCpros)
816: 			MsgAviso("Informe o c" + CHR(243) + "digo do produto.", "Aten" + CHR(231) + CHR(227) + "o")
817: 			THIS.txt_4c_Cpros.SetFocus()
818: 			RETURN
819: 		ENDIF
820: 		IF loc_nQtds <= 0
821: 			MsgAviso("Quantidade deve ser maior que zero.", "Aten" + CHR(231) + CHR(227) + "o")
822: 			THIS.txt_4c_Qtds.SetFocus()
823: 			RETURN
824: 		ENDIF
825: 		SELECT cursor_4c_Etiquetas
826: 		GO BOTTOM
827: 		IF !EMPTY(cursor_4c_Etiquetas.Cpros)
828: 			APPEND BLANK
829: 		ENDIF
830: 		REPLACE Cpros WITH loc_cCpros, ;
831: 		        DPros WITH ALLTRIM(NVL(THIS.txt_4c_Dpros.Value, "")), ;
832: 		        Qtds  WITH loc_nQtds
833: 		THIS.CarregarPrecoProduto(loc_cCpros)
834: 		IF THIS.chk_4c_Lista.Value = 1 AND !EMPTY(ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value, "")))
835: 			THIS.AtualizarPrecoPorLista(loc_cCpros)
836: 		ENDIF
837: 		APPEND BLANK
838: 		THIS.txt_4c_Cpros.Value = ""
839: 		THIS.txt_4c_Dpros.Value = ""
840: 		THIS.txt_4c_Qtds.Value  = 0
841: 		THIS.grd_4c_Etiquetas.Refresh()
842: 		THIS.txt_4c_Cpros.SetFocus()
843: 	ENDPROC
844: 
845: 	*====================================================================
846: 	* TxtLprecoKeyPress - Valida ou abre busca de lista de precos
847: 	*====================================================================
848: 	PROCEDURE TxtLprecoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
849: 		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
850: 			RETURN
851: 		ENDIF
852: 		LOCAL loc_cLpreco, loc_nRet, loc_oBusca
853: 		loc_cLpreco = ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value, ""))
854: 		IF !EMPTY(loc_cLpreco)
855: 			loc_nRet = SQLEXEC(gnConnHandle, ;
856: 				"SELECT TOP 1 LPrecos, DLPrecos FROM SigCdLpc " + ;
857: 				"WHERE RTRIM(LPrecos)=" + EscaparSQL(loc_cLpreco), ;
858: 				"cursor_4c_BuscaLpc")
859: 			IF loc_nRet > 0 AND USED("cursor_4c_BuscaLpc") AND RECCOUNT("cursor_4c_BuscaLpc") > 0
860: 				SELECT cursor_4c_BuscaLpc
861: 				THIS.txt_4c_Lpreco.Value  = ALLTRIM(cursor_4c_BuscaLpc.LPrecos)
862: 				THIS.txt_4c_LPreco2.Value = ALLTRIM(cursor_4c_BuscaLpc.DLPrecos)
863: 				USE IN cursor_4c_BuscaLpc
864: 				THIS.chk_4c_Lista.SetFocus()
865: 				RETURN
866: 			ENDIF
867: 			IF USED("cursor_4c_BuscaLpc")
868: 				USE IN cursor_4c_BuscaLpc
869: 			ENDIF
870: 		ENDIF
871: 		loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
872: 			"SigCdLpc", "cursor_4c_BuscaLpc", "LPrecos", ;
873: 			loc_cLpreco, "Lista de Pre" + CHR(231) + "os", .T., .T., "")
874: 		IF VARTYPE(loc_oBusca) = "O"
875: 			IF !loc_oBusca.this_lAchouRegistro
876: 				loc_oBusca.mAddColuna("LPrecos",  "", "C" + CHR(243) + "digo")
877: 				loc_oBusca.mAddColuna("DLPrecos", "", "Descri" + CHR(231) + CHR(227) + "o")
878: 				loc_oBusca.Show()
879: 			ENDIF
880: 			IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLpc")
881: 				SELECT cursor_4c_BuscaLpc
882: 				THIS.txt_4c_Lpreco.Value  = ALLTRIM(cursor_4c_BuscaLpc.LPrecos)
883: 				THIS.txt_4c_LPreco2.Value = ALLTRIM(cursor_4c_BuscaLpc.DLPrecos)
884: 				USE IN cursor_4c_BuscaLpc
885: 				THIS.chk_4c_Lista.SetFocus()
886: 			ENDIF
887: 		ENDIF
888: 	ENDPROC
889: 
890: 	*====================================================================
891: 	* TxtLPreco2KeyPress - ReadOnly, redireciona foco para txt_4c_Lpreco
892: 	*====================================================================
893: 	PROCEDURE TxtLPreco2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
894: 		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
895: 			RETURN
896: 		ENDIF
897: 		THIS.txt_4c_Lpreco.SetFocus()
898: 	ENDPROC
899: 
900: 	*====================================================================
901: 	* AbrirBuscaProdutoCodigo - Picker de produto por codigo
902: 	*====================================================================
903: 	PROTECTED PROCEDURE AbrirBuscaProdutoCodigo()
904: 		LOCAL loc_oBusca
905: 		loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
906: 			"SigCdPro", "cursor_4c_BuscaProd", "Cpros", ;
907: 			ALLTRIM(NVL(THIS.txt_4c_Cpros.Value, "")), ;
908: 			"Busca de Produto", .T., .T., "")
909: 		IF VARTYPE(loc_oBusca) = "O"
910: 			IF !loc_oBusca.this_lAchouRegistro
911: 				loc_oBusca.mAddColuna("Cpros", "", "C" + CHR(243) + "digo")
912: 				loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
913: 				loc_oBusca.Show()
914: 			ENDIF
915: 			IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
916: 				SELECT cursor_4c_BuscaProd
917: 				THIS.txt_4c_Cpros.Value = ALLTRIM(cursor_4c_BuscaProd.Cpros)
918: 				THIS.txt_4c_Dpros.Value = ALLTRIM(cursor_4c_BuscaProd.DPros)
919: 				USE IN cursor_4c_BuscaProd
920: 				THIS.txt_4c_Qtds.SetFocus()
921: 			ENDIF
922: 		ENDIF
923: 	ENDPROC
924: 
925: 	*====================================================================
926: 	* AbrirBuscaProdutoDescricao - Picker de produto por descricao
927: 	*====================================================================
928: 	PROTECTED PROCEDURE AbrirBuscaProdutoDescricao()
929: 		LOCAL loc_oBusca
930: 		loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
931: 			"SigCdPro", "cursor_4c_BuscaProd", "DPros", ;
932: 			ALLTRIM(NVL(THIS.txt_4c_Dpros.Value, "")), ;
933: 			"Busca de Produto", .T., .T., "")
934: 		IF VARTYPE(loc_oBusca) = "O"
935: 			IF !loc_oBusca.this_lAchouRegistro
936: 				loc_oBusca.mAddColuna("Cpros", "", "C" + CHR(243) + "digo")
937: 				loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
938: 				loc_oBusca.Show()
939: 			ENDIF
940: 			IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
941: 				SELECT cursor_4c_BuscaProd
942: 				THIS.txt_4c_Cpros.Value = ALLTRIM(cursor_4c_BuscaProd.Cpros)
943: 				THIS.txt_4c_Dpros.Value = ALLTRIM(cursor_4c_BuscaProd.DPros)
944: 				USE IN cursor_4c_BuscaProd
945: 				THIS.txt_4c_Qtds.SetFocus()
946: 			ENDIF
947: 		ENDIF
948: 	ENDPROC
949: 
950: 	*====================================================================
951: 	* AbrirBuscaProdutoRef - Picker de produto por referencia (DPro2s)
952: 	*====================================================================
953: 	PROTECTED PROCEDURE AbrirBuscaProdutoRef()
954: 		LOCAL loc_cRef, loc_oBusca
955: 		loc_cRef = ""
956: 		IF USED("cursor_4c_Etiquetas") AND !EOF("cursor_4c_Etiquetas")
957: 			loc_cRef = ALLTRIM(NVL(cursor_4c_Etiquetas.Reffs, ""))
958: 		ENDIF
959: 		loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
960: 			"SigCdPro", "cursor_4c_BuscaProd", "DPro2s", ;
961: 			loc_cRef, "Busca por Refer" + CHR(234) + "ncia", .T., .T., "")
962: 		IF VARTYPE(loc_oBusca) = "O"
963: 			IF !loc_oBusca.this_lAchouRegistro
964: 				loc_oBusca.mAddColuna("Cpros",  "", "C" + CHR(243) + "digo")
965: 				loc_oBusca.mAddColuna("DPros",  "", "Descri" + CHR(231) + CHR(227) + "o")
966: 				loc_oBusca.mAddColuna("DPro2s", "", "Refer" + CHR(234) + "ncia")
967: 				loc_oBusca.Show()
968: 			ENDIF
969: 			IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
970: 				SELECT cursor_4c_BuscaProd
971: 				LOCAL loc_cCpros, loc_cDPros, loc_cDPro2s
972: 				loc_cCpros  = ALLTRIM(cursor_4c_BuscaProd.Cpros)
973: 				loc_cDPros  = ALLTRIM(cursor_4c_BuscaProd.DPros)
974: 				loc_cDPro2s = ALLTRIM(cursor_4c_BuscaProd.DPro2s)
975: 				USE IN cursor_4c_BuscaProd
976: 				SELECT cursor_4c_Etiquetas
977: 				REPLACE Cpros WITH loc_cCpros, ;
978: 				        DPros WITH loc_cDPros, ;
979: 				        Reffs WITH loc_cDPro2s
980: 				THIS.CarregarPrecoProduto(loc_cCpros)
981: 				THIS.grd_4c_Etiquetas.Refresh()
982: 			ENDIF
983: 		ENDIF
984: 	ENDPROC
985: 
986: 	*====================================================================
987: 	* CarregarPrecoProduto - Carrega PVens/PrecoDe/Pesos/DPro2s na linha
988: 	*====================================================================
989: 	PROTECTED PROCEDURE CarregarPrecoProduto(par_cCpros)
990: 		LOCAL loc_nRet, loc_nPVens, loc_nPrecoDe, loc_nPesos, loc_cDPro2s
991: 		IF EMPTY(par_cCpros)
992: 			RETURN
993: 		ENDIF
994: 		loc_nRet = SQLEXEC(gnConnHandle, ;
995: 			"SELECT TOP 1 PVens, PecoDe, PesoMs, DPro2s " + ;
996: 			"FROM SigCdPro WHERE RTRIM(Cpros)=" + EscaparSQL(par_cCpros), ;
997: 			"cursor_4c_PrecosProd")
998: 		IF loc_nRet > 0 AND USED("cursor_4c_PrecosProd") AND RECCOUNT("cursor_4c_PrecosProd") > 0
999: 			SELECT cursor_4c_PrecosProd
1000: 			loc_nPVens   = NVL(cursor_4c_PrecosProd.PVens,   0)
1001: 			loc_nPrecoDe = NVL(cursor_4c_PrecosProd.PecoDe,  0)
1002: 			loc_nPesos   = NVL(cursor_4c_PrecosProd.PesoMs,  0)
1003: 			loc_cDPro2s  = ALLTRIM(NVL(cursor_4c_PrecosProd.DPro2s, ""))
1004: 			USE IN cursor_4c_PrecosProd
1005: 			SELECT cursor_4c_Etiquetas
1006: 			IF THIS.chk_4c_Precio.Value = 1
1007: 				REPLACE PVens   WITH loc_nPVens, ;
1008: 				        PrecoDe WITH loc_nPrecoDe, ;
1009: 				        Pesos   WITH loc_nPesos, ;
1010: 				        DPro2s  WITH loc_cDPro2s
1011: 			ELSE
1012: 				REPLACE Pesos  WITH loc_nPesos, ;
1013: 				        DPro2s WITH loc_cDPro2s
1014: 			ENDIF
1015: 		ENDIF
1016: 		IF USED("cursor_4c_PrecosProd")
1017: 			USE IN cursor_4c_PrecosProd
1018: 		ENDIF
1019: 	ENDPROC
1020: 
1021: 	*====================================================================
1022: 	* AtualizarPrecoPorLista - Substitui PVens/PrecoDe pelo preco da lista
1023: 	*====================================================================
1024: 	PROTECTED PROCEDURE AtualizarPrecoPorLista(par_cCpros)
1025: 		LOCAL loc_cLpreco, loc_nRet
1026: 		loc_cLpreco = ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value, ""))
1027: 		IF EMPTY(loc_cLpreco) OR EMPTY(par_cCpros)
1028: 			RETURN
1029: 		ENDIF
1030: 		loc_nRet = SQLEXEC(gnConnHandle, ;
1031: 			"SELECT TOP 1 PVens, PrecoDe FROM SigCdLpi " + ;
1032: 			"WHERE RTRIM(LPrecos)=" + EscaparSQL(loc_cLpreco) + ;
1033: 			" AND RTRIM(CPros)=" + EscaparSQL(par_cCpros), ;
1034: 			"cursor_4c_PrecoLista")
1035: 		IF loc_nRet > 0 AND USED("cursor_4c_PrecoLista") AND RECCOUNT("cursor_4c_PrecoLista") > 0
1036: 			SELECT cursor_4c_PrecoLista
1037: 			LOCAL loc_nPVens, loc_nPrecoDe
1038: 			loc_nPVens   = NVL(cursor_4c_PrecoLista.PVens,   0)
1039: 			loc_nPrecoDe = NVL(cursor_4c_PrecoLista.PrecoDe, 0)
1040: 			USE IN cursor_4c_PrecoLista
1041: 			SELECT cursor_4c_Etiquetas
1042: 			REPLACE PVens   WITH loc_nPVens, ;
1043: 			        PrecoDe WITH loc_nPrecoDe
1044: 		ENDIF
1045: 		IF USED("cursor_4c_PrecoLista")
1046: 			USE IN cursor_4c_PrecoLista
1047: 		ENDIF
1048: 	ENDPROC
1049: 
1050: 	*====================================================================
1051: 	* CarregarItensDaLista - Popula grid com todos itens de SigCdLpi
1052: 	*====================================================================
1053: 	PROTECTED PROCEDURE CarregarItensDaLista()
1054: 		LOCAL loc_cLpreco, loc_nRet
1055: 		loc_cLpreco = ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value, ""))
1056: 		IF EMPTY(loc_cLpreco)
1057: 			MsgAviso("Informe a lista de pre" + CHR(231) + "os.", "Aten" + CHR(231) + CHR(227) + "o")
1058: 			THIS.txt_4c_Lpreco.SetFocus()
1059: 			RETURN
1060: 		ENDIF
1061: 		loc_nRet = SQLEXEC(gnConnHandle, ;
1062: 			"SELECT i.CPros AS iCPros, p.DPros AS iDPros, p.DPro2s AS iDPro2s, " + ;
1063: 			" i.PVens AS iPVens, i.PrecoDe AS iPrecoDe, p.PesoMs AS iPesoMs " + ;
1064: 			"FROM SigCdLpi i " + ;
1065: 			"INNER JOIN SigCdPro p ON RTRIM(p.Cpros)=RTRIM(i.CPros) " + ;
1066: 			"WHERE RTRIM(i.LPrecos)=" + EscaparSQL(loc_cLpreco) + ;
1067: 			" ORDER BY i.CPros", ;
1068: 			"cursor_4c_ItensList")
1069: 		IF loc_nRet <= 0 OR !USED("cursor_4c_ItensList") OR RECCOUNT("cursor_4c_ItensList") = 0
1070: 			IF USED("cursor_4c_ItensList")
1071: 				USE IN cursor_4c_ItensList
1072: 			ENDIF
1073: 			MsgAviso("Nenhum item encontrado para a lista selecionada.", "Aten" + CHR(231) + CHR(227) + "o")
1074: 			RETURN
1075: 		ENDIF
1076: 		LOCAL loc_cCpros, loc_cDPros, loc_cDPro2s, loc_nPVens, loc_nPrecoDe, loc_nPesos
1077: 		SELECT cursor_4c_Etiquetas
1078: 		ZAP
1079: 		SELECT cursor_4c_ItensList
1080: 		SCAN
1081: 			loc_cCpros   = ALLTRIM(cursor_4c_ItensList.iCPros)
1082: 			loc_cDPros   = ALLTRIM(cursor_4c_ItensList.iDPros)
1083: 			loc_cDPro2s  = ALLTRIM(cursor_4c_ItensList.iDPro2s)
1084: 			loc_nPVens   = NVL(cursor_4c_ItensList.iPVens,   0)
1085: 			loc_nPrecoDe = NVL(cursor_4c_ItensList.iPrecoDe, 0)
1086: 			loc_nPesos   = NVL(cursor_4c_ItensList.iPesoMs,  0)
1087: 			SELECT cursor_4c_Etiquetas
1088: 			APPEND BLANK
1089: 			REPLACE Cpros   WITH loc_cCpros, ;
1090: 			        DPros   WITH loc_cDPros, ;
1091: 			        DPro2s  WITH loc_cDPro2s, ;
1092: 			        PVens   WITH loc_nPVens, ;
1093: 			        PrecoDe WITH loc_nPrecoDe, ;
1094: 			        Pesos   WITH loc_nPesos, ;
1095: 			        Qtds    WITH 1
1096: 			SELECT cursor_4c_ItensList
1097: 		ENDSCAN
1098: 		USE IN cursor_4c_ItensList
1099: 		SELECT cursor_4c_Etiquetas
1100: 		APPEND BLANK
1101: 		GO TOP
1102: 		THIS.grd_4c_Etiquetas.Refresh()
1103: 	ENDPROC
1104: 
1105: 	*====================================================================
1106: 	* CmdBtnCarregarClick - Carrega itens de SigMvItn por empresa/operacao
1107: 	*====================================================================
1108: 	PROCEDURE CmdBtnCarregarClick()
1109: 		LOCAL loc_cEmps, loc_cDopes, loc_nNumes, loc_cLpreco, loc_nRet
1110: 		loc_cEmps   = ALLTRIM(NVL(THIS.txt_4c_Emps.Value,  ""))
1111: 		loc_cDopes  = ALLTRIM(NVL(THIS.txt_4c_Dopes.Value, ""))
1112: 		loc_nNumes  = IIF(PEMSTATUS(THIS, "txt_4c_Numes", 5) AND VARTYPE(THIS.txt_4c_Numes) = "O", ;
1113: 		                  NVL(THIS.txt_4c_Numes.Value, 0), 0)
1114: 		loc_cLpreco = ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value,""))
1115: 		IF EMPTY(loc_cEmps)
1116: 			MsgAviso("Informe a empresa.", "Aten" + CHR(231) + CHR(227) + "o")
1117: 			THIS.txt_4c_Emps.SetFocus()
1118: 			RETURN
1119: 		ENDIF
1120: 		IF EMPTY(loc_cDopes)
1121: 			MsgAviso("Informe a opera" + CHR(231) + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
1122: 			THIS.txt_4c_Dopes.SetFocus()
1123: 			RETURN
1124: 		ENDIF
1125: 		IF loc_nNumes <= 0
1126: 			MsgAviso("Informe o n" + CHR(250) + "mero do documento.", "Aten" + CHR(231) + CHR(227) + "o")
1127: 			IF PEMSTATUS(THIS, "txt_4c_Numes", 5) AND VARTYPE(THIS.txt_4c_Numes) = "O"
1128: 				THIS.txt_4c_Numes.SetFocus()
1129: 			ENDIF
1130: 			RETURN
1131: 		ENDIF
1132: 		loc_nRet = SQLEXEC(gnConnHandle, ;
1133: 			"SELECT i.CPros AS iCPros, p.DPros AS iDPros, p.DPro2s AS iDPro2s, " + ;
1134: 			" i.Qtds AS iQtds, i.Citens AS iCitens, i.Numes AS iNumes, " + ;
1135: 			" i.Emps AS iEmps, i.Dopes AS iDopes, " + ;
1136: 			" p.PVens AS iPVens, p.PecoDe AS iPecoDe, p.PesoMs AS iPesoMs " + ;
1137: 			"FROM SigMvItn i " + ;
1138: 			"LEFT JOIN SigCdPro p ON RTRIM(p.Cpros)=RTRIM(i.CPros) " + ;
1139: 			"WHERE RTRIM(i.Emps)=" + EscaparSQL(loc_cEmps) + ;
1140: 			" AND RTRIM(i.Dopes)=" + EscaparSQL(loc_cDopes) + ;
1141: 			" AND i.Numes = " + FormatarNumeroSQL(loc_nNumes, 0) + ;
1142: 			" ORDER BY i.CPros", ;
1143: 			"cursor_4c_SigMvItn")
1144: 		IF loc_nRet <= 0 OR !USED("cursor_4c_SigMvItn") OR RECCOUNT("cursor_4c_SigMvItn") = 0
1145: 			IF USED("cursor_4c_SigMvItn")
1146: 				USE IN cursor_4c_SigMvItn
1147: 			ENDIF
1148: 			MsgAviso("Nenhum item encontrado para empresa/opera" + CHR(231) + CHR(227) + "o informada.", ;
1149: 			         "Aten" + CHR(231) + CHR(227) + "o")
1150: 			RETURN
1151: 		ENDIF
1152: 		LOCAL loc_cCpros, loc_cDPros, loc_cDPro2s
1153: 		LOCAL loc_nQtds, loc_nCitens, loc_nNumes
1154: 		LOCAL loc_cIEmps, loc_cIDopes
1155: 		LOCAL loc_nPVens, loc_nPrecoDe, loc_nPesos
1156: 		LOCAL loc_cEmpDoNum, loc_nRetLpi
1157: 		SELECT cursor_4c_Etiquetas
1158: 		ZAP
1159: 		SELECT cursor_4c_SigMvItn
1160: 		SCAN
1161: 			loc_cCpros   = ALLTRIM(cursor_4c_SigMvItn.iCPros)
1162: 			loc_cDPros   = ALLTRIM(NVL(cursor_4c_SigMvItn.iDPros,  ""))
1163: 			loc_cDPro2s  = ALLTRIM(NVL(cursor_4c_SigMvItn.iDPro2s, ""))
1164: 			loc_nQtds    = NVL(cursor_4c_SigMvItn.iQtds,    0)
1165: 			loc_nCitens  = NVL(cursor_4c_SigMvItn.iCitens,  0)
1166: 			loc_nNumes   = NVL(cursor_4c_SigMvItn.iNumes,   0)
1167: 			loc_cIEmps   = ALLTRIM(NVL(cursor_4c_SigMvItn.iEmps,   ""))
1168: 			loc_cIDopes  = ALLTRIM(NVL(cursor_4c_SigMvItn.iDopes,  ""))
1169: 			loc_nPVens   = NVL(cursor_4c_SigMvItn.iPVens,   0)
1170: 			loc_nPrecoDe = NVL(cursor_4c_SigMvItn.iPecoDe,  0)
1171: 			loc_nPesos   = NVL(cursor_4c_SigMvItn.iPesoMs,  0)
1172: 			*-- Aplica lista de precos se habilitada
1173: 			IF THIS.chk_4c_Lista.Value = 1 AND !EMPTY(loc_cLpreco)
1174: 				loc_nRetLpi = SQLEXEC(gnConnHandle, ;
1175: 					"SELECT TOP 1 PVens, PrecoDe FROM SigCdLpi " + ;
1176: 					"WHERE RTRIM(LPrecos)=" + EscaparSQL(loc_cLpreco) + ;
1177: 					" AND RTRIM(CPros)=" + EscaparSQL(loc_cCpros), ;
1178: 					"cursor_4c_Lpi")
1179: 				IF loc_nRetLpi > 0 AND USED("cursor_4c_Lpi") AND RECCOUNT("cursor_4c_Lpi") > 0
1180: 					SELECT cursor_4c_Lpi
1181: 					loc_nPVens   = NVL(cursor_4c_Lpi.PVens,   loc_nPVens)
1182: 					loc_nPrecoDe = NVL(cursor_4c_Lpi.PrecoDe, loc_nPrecoDe)
1183: 				ENDIF
1184: 				IF USED("cursor_4c_Lpi")
1185: 					USE IN cursor_4c_Lpi
1186: 				ENDIF
1187: 			ENDIF
1188: 			loc_cEmpDoNum = PADR(loc_cIEmps, 3) + PADR(loc_cIDopes, 20) + STR(loc_nNumes, 6, 0)

*-- Linhas 1211 a 1422:
1211: 	*====================================================================
1212: 	* CmdBtnExcluirClick - Remove linha selecionada do grid
1213: 	*====================================================================
1214: 	PROCEDURE CmdBtnExcluirClick()
1215: 		IF !USED("cursor_4c_Etiquetas") OR RECCOUNT("cursor_4c_Etiquetas") <= 1
1216: 			RETURN
1217: 		ENDIF
1218: 		SELECT cursor_4c_Etiquetas
1219: 		IF EOF() OR BOF() OR EMPTY(cursor_4c_Etiquetas.Cpros)
1220: 			RETURN
1221: 		ENDIF
1222: 		DELETE
1223: 		PACK
1224: 		IF RECCOUNT("cursor_4c_Etiquetas") = 0
1225: 			APPEND BLANK
1226: 		ENDIF
1227: 		GO TOP
1228: 		THIS.grd_4c_Etiquetas.Refresh()
1229: 	ENDPROC
1230: 
1231: 	*====================================================================
1232: 	* BtnIncluirClick - Adiciona linha em branco no grid para o usuario
1233: 	* preencher manualmente (produto/quantidade). Adaptacao CRUD do
1234: 	* fluxo OPERACIONAL: nao ha modo de edicao separado, o grid eh
1235: 	* editavel diretamente.
1236: 	*====================================================================
1237: 	PROCEDURE BtnIncluirClick()
1238: 		IF !USED("cursor_4c_Etiquetas")
1239: 			MsgAviso("Grid n" + CHR(227) + "o inicializado.", "Aten" + CHR(231) + CHR(227) + "o")
1240: 			RETURN
1241: 		ENDIF
1242: 		SELECT cursor_4c_Etiquetas
1243: 		*-- Se ja existe linha em branco no final, apenas posiciona nela
1244: 		GO BOTTOM
1245: 		IF EMPTY(cursor_4c_Etiquetas.Cpros)
1246: 			THIS.grd_4c_Etiquetas.Refresh()
1247: 			THIS.grd_4c_Etiquetas.SetFocus()
1248: 			RETURN
1249: 		ENDIF
1250: 		*-- Adiciona nova linha em branco para digitacao
1251: 		APPEND BLANK
1252: 		GO BOTTOM
1253: 		THIS.grd_4c_Etiquetas.Refresh()
1254: 		THIS.grd_4c_Etiquetas.SetFocus()
1255: 	ENDPROC
1256: 
1257: 	*====================================================================
1258: 	* BtnAlterarClick - Coloca o foco no campo Cpros (produto) da linha
1259: 	* corrente do grid, permitindo alterar quantidade/produto. Adaptacao
1260: 	* CRUD do fluxo OPERACIONAL - a edicao eh inline no grid.
1261: 	*====================================================================
1262: 	PROCEDURE BtnAlterarClick()
1263: 		IF !USED("cursor_4c_Etiquetas") OR RECCOUNT("cursor_4c_Etiquetas") = 0
1264: 			MsgAviso("Nenhum item para alterar.", "Aten" + CHR(231) + CHR(227) + "o")
1265: 			RETURN
1266: 		ENDIF
1267: 		SELECT cursor_4c_Etiquetas
1268: 		IF EOF() OR BOF()
1269: 			GO TOP
1270: 		ENDIF
1271: 		THIS.grd_4c_Etiquetas.Refresh()
1272: 		THIS.grd_4c_Etiquetas.SetFocus()
1273: 		*-- Tenta focar na primeira coluna editavel (Cpros)
1274: 		IF PEMSTATUS(THIS.grd_4c_Etiquetas, "Column1", 5) AND ;
1275: 		   VARTYPE(THIS.grd_4c_Etiquetas.Column1) = "O"
1276: 			IF PEMSTATUS(THIS.grd_4c_Etiquetas.Column1, "Text1", 5) AND ;
1277: 			   VARTYPE(THIS.grd_4c_Etiquetas.Column1.Text1) = "O"
1278: 				THIS.grd_4c_Etiquetas.Column1.Text1.SetFocus()
1279: 			ENDIF
1280: 		ENDIF
1281: 	ENDPROC
1282: 
1283: 	*====================================================================
1284: 	* BtnVisualizarClick - Reposiciona no topo do grid, atualiza contagem
1285: 	* e mostra resumo dos itens carregados. Adaptacao CRUD do fluxo
1286: 	* OPERACIONAL - equivale a visualizar a lista selecionada.
1287: 	*====================================================================
1288: 	PROCEDURE BtnVisualizarClick()
1289: 		LOCAL loc_nTotal, loc_nQtdTotal, loc_cMensagem
1290: 		IF !USED("cursor_4c_Etiquetas") OR RECCOUNT("cursor_4c_Etiquetas") = 0
1291: 			MsgAviso("Nenhum item na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1292: 			RETURN
1293: 		ENDIF
1294: 		SELECT cursor_4c_Etiquetas
1295: 		loc_nTotal    = 0
1296: 		loc_nQtdTotal = 0
1297: 		SCAN FOR !EMPTY(cursor_4c_Etiquetas.Cpros)
1298: 			loc_nTotal    = loc_nTotal + 1
1299: 			loc_nQtdTotal = loc_nQtdTotal + NVL(cursor_4c_Etiquetas.Qtds, 0)
1300: 		ENDSCAN
1301: 		GO TOP
1302: 		THIS.grd_4c_Etiquetas.Refresh()
1303: 		THIS.grd_4c_Etiquetas.SetFocus()
1304: 		loc_cMensagem = "Itens selecionados: " + TRANSFORM(loc_nTotal) + CHR(13) + ;
1305: 		                "Quantidade total: " + TRANSFORM(loc_nQtdTotal, "@Z 9,999,999.999")
1306: 		MsgInfo(loc_cMensagem, "Resumo da Sele" + CHR(231) + CHR(227) + "o")
1307: 	ENDPROC
1308: 
1309: 	*====================================================================
1310: 	* BtnExcluirClick - Remove linha selecionada do grid (com confirmacao).
1311: 	* Delega para CmdBtnExcluirClick que faz a exclusao efetiva.
1312: 	*====================================================================
1313: 	PROCEDURE BtnExcluirClick()
1314: 		IF !USED("cursor_4c_Etiquetas") OR RECCOUNT("cursor_4c_Etiquetas") <= 1
1315: 			MsgAviso("Nenhum item para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
1316: 			RETURN
1317: 		ENDIF
1318: 		SELECT cursor_4c_Etiquetas
1319: 		IF EOF() OR BOF() OR EMPTY(cursor_4c_Etiquetas.Cpros)
1320: 			MsgAviso("Selecione um item v" + CHR(225) + "lido para excluir.", ;
1321: 			         "Aten" + CHR(231) + CHR(227) + "o")
1322: 			RETURN
1323: 		ENDIF
1324: 		IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do item selecionado?", ;
1325: 		                "Confirma" + CHR(231) + CHR(227) + "o")
1326: 			RETURN
1327: 		ENDIF
1328: 		THIS.CmdBtnExcluirClick()
1329: 	ENDPROC
1330: 
1331: 	*====================================================================
1332: 	* BtnImprimirClick - Coleta parametros dos controles e chama BO
1333: 	*====================================================================
1334: 	PROCEDURE BtnImprimirClick()
1335: 		IF !USED("cursor_4c_Etiquetas")
1336: 			MsgAviso("Nenhum item na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1337: 			RETURN
1338: 		ENDIF
1339: 		SELECT cursor_4c_Etiquetas
1340: 		LOCATE FOR EMPTY(cursor_4c_Etiquetas.Cpros)
1341: 		IF FOUND()
1342: 			DELETE
1343: 			PACK
1344: 		ENDIF
1345: 		IF RECCOUNT("cursor_4c_Etiquetas") = 0
1346: 			MsgAviso("Nenhum produto adicionado para impress" + CHR(227) + "o.", ;
1347: 			         "Aten" + CHR(231) + CHR(227) + "o")
1348: 			APPEND BLANK
1349: 			RETURN
1350: 		ENDIF
1351: 		GO TOP
1352: 
1353: 		*-- Coleta parametros dos controles de configuracao
1354: 		LOCAL loc_nImpPreco, loc_lImpSepar, loc_lImpPeso, loc_lCompo
1355: 		LOCAL loc_nTpEti, loc_nTpImp, loc_nAjVerts, loc_nAjHorzs
1356: 		LOCAL loc_nAjDenss, loc_nAjVelos, loc_cNomeImp, loc_nOrdem
1357: 		LOCAL loc_cLp1, loc_cLp2
1358: 
1359: 		*-- Defaults do BO
1360: 		loc_nImpPreco = 1
1361: 		loc_lImpSepar = .T.
1362: 		loc_lImpPeso  = .T.
1363: 		loc_lCompo    = .T.
1364: 		loc_nTpEti    = 1
1365: 		loc_nTpImp    = 1
1366: 		loc_nAjVerts  = 0
1367: 		loc_nAjHorzs  = 0
1368: 		loc_nAjDenss  = 20
1369: 		loc_nAjVelos  = 3
1370: 		loc_cNomeImp  = ""
1371: 		loc_nOrdem    = 1
1372: 		loc_cLp1      = ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value,  ""))
1373: 		loc_cLp2      = ALLTRIM(NVL(THIS.txt_4c_LPreco2.Value, ""))
1374: 
1375: 		*-- Tipo de etiqueta (obj_4c_Opt_Tipo)
1376: 		IF PEMSTATUS(THIS, "obj_4c_Opt_Tipo", 5) AND VARTYPE(THIS.obj_4c_Opt_Tipo) = "O"
1377: 			loc_nTpEti = NVL(THIS.obj_4c_Opt_Tipo.Value, 1)
1378: 		ENDIF
1379: 
1380: 		*-- Configuracoes da impressora (cnt_4c_Impressora)
1381: 		IF PEMSTATUS(THIS, "cnt_4c_Impressora", 5) AND VARTYPE(THIS.cnt_4c_Impressora) = "O"
1382: 			*-- Tipo impressora (OptionGroup OpcaoImp)
1383: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "obj_4c_OpcaoImp", 5) AND ;
1384: 			   VARTYPE(THIS.cnt_4c_Impressora.obj_4c_OpcaoImp) = "O"
1385: 				loc_nTpImp = NVL(THIS.cnt_4c_Impressora.obj_4c_OpcaoImp.Value, 1)
1386: 			ENDIF
1387: 			*-- Ajustes (spinners)
1388: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjVerts", 5) AND ;
1389: 			   VARTYPE(THIS.cnt_4c_Impressora.spn_4c_AjVerts) = "O"
1390: 				loc_nAjVerts = NVL(THIS.cnt_4c_Impressora.spn_4c_AjVerts.Value, 0)
1391: 			ENDIF
1392: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjHorzs", 5) AND ;
1393: 			   VARTYPE(THIS.cnt_4c_Impressora.spn_4c_AjHorzs) = "O"
1394: 				loc_nAjHorzs = NVL(THIS.cnt_4c_Impressora.spn_4c_AjHorzs.Value, 0)
1395: 			ENDIF
1396: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjDenss", 5) AND ;
1397: 			   VARTYPE(THIS.cnt_4c_Impressora.spn_4c_AjDenss) = "O"
1398: 				loc_nAjDenss = NVL(THIS.cnt_4c_Impressora.spn_4c_AjDenss.Value, 20)
1399: 			ENDIF
1400: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjVelos", 5) AND ;
1401: 			   VARTYPE(THIS.cnt_4c_Impressora.spn_4c_AjVelos) = "O"
1402: 				loc_nAjVelos = NVL(THIS.cnt_4c_Impressora.spn_4c_AjVelos.Value, 3)
1403: 			ENDIF
1404: 		ENDIF
1405: 
1406: 		*-- Nome da impressora (cbo_4c_GetPrinter)
1407: 		IF PEMSTATUS(THIS, "cbo_4c_GetPrinter", 5) AND VARTYPE(THIS.cbo_4c_GetPrinter) = "O"
1408: 			loc_cNomeImp = ALLTRIM(NVL(THIS.cbo_4c_GetPrinter.Value, ""))
1409: 		ENDIF
1410: 
1411: 		*-- Opcoes de impressao da Fase 6 (opt_separador, opt_Preco, opt_peso, optCompos, OptOrdem)
1412: 		IF PEMSTATUS(THIS, "obj_4c_OptSeparador", 5) AND VARTYPE(THIS.obj_4c_OptSeparador) = "O"
1413: 			loc_lImpSepar = (THIS.obj_4c_OptSeparador.Value = 1)
1414: 		ENDIF
1415: 		IF PEMSTATUS(THIS, "obj_4c_OptPreco", 5) AND VARTYPE(THIS.obj_4c_OptPreco) = "O"
1416: 			loc_nImpPreco = NVL(THIS.obj_4c_OptPreco.Value, 1)
1417: 		ENDIF
1418: 		IF PEMSTATUS(THIS, "obj_4c_OptPeso", 5) AND VARTYPE(THIS.obj_4c_OptPeso) = "O"
1419: 			loc_lImpPeso = (THIS.obj_4c_OptPeso.Value = 1)
1420: 		ENDIF
1421: 		IF PEMSTATUS(THIS, "obj_4c_OptCompos", 5) AND VARTYPE(THIS.obj_4c_OptCompos) = "O"
1422: 			loc_lCompo = (THIS.obj_4c_OptCompos.Value = 1)

*-- Linhas 1443 a 1529:
1443: 	*====================================================================
1444: 	* BtnEncerrarClick - Fecha o formulario
1445: 	*====================================================================
1446: 	PROCEDURE BtnEncerrarClick()
1447: 		THIS.Release()
1448: 	ENDPROC
1449: 
1450: 	*====================================================================
1451: 	* ConfigurarPaginaDados - Secao inferior: tipo etiqueta e impressora
1452: 	*====================================================================
1453: 	PROTECTED PROCEDURE ConfigurarPaginaDados()
1454: 
1455: 		*-- Label titulo secao (sobre o grid)
1456: 		THIS.AddObject("lbl_4c_LblTituloGrd", "Label")
1457: 		WITH THIS.lbl_4c_LblTituloGrd
1458: 			.AutoSize  = .F.
1459: 			.Caption   = " \<Etiquetas Selecionadas "
1460: 			.Top       = 375
1461: 			.Left      = 10
1462: 			.Width     = 210
1463: 			.Height    = 15
1464: 			.FontBold  = .T.
1465: 			.FontName  = "Tahoma"
1466: 			.FontSize  = 8
1467: 			.BackStyle = 0
1468: 			.ForeColor = RGB(90, 90, 90)
1469: 		ENDWITH
1470: 
1471: 		*-- Label "Tipo de Etiqueta"
1472: 		THIS.AddObject("lbl_4c_TipoEtq", "Label")
1473: 		WITH THIS.lbl_4c_TipoEtq
1474: 			.AutoSize  = .F.
1475: 			.FontBold  = .T.
1476: 			.FontName  = "Tahoma"
1477: 			.FontSize  = 8
1478: 			.BackStyle = 0
1479: 			.Caption   = " Tipo de Etiqueta "
1480: 			.Height    = 15
1481: 			.Left      = 23
1482: 			.Top       = 415
1483: 			.Width     = 110
1484: 			.ForeColor = RGB(90, 90, 90)
1485: 		ENDWITH
1486: 
1487: 		*-- OptionGroup Tipo Etiqueta (1 botao inicial: Rabicho)
1488: 		*-- PopularTiposEtiqueta() adiciona botoes dinamicamente via BO.CarregarTiposEtiqueta()
1489: 		THIS.AddObject("obj_4c_Opt_Tipo", "OptionGroup")
1490: 		WITH THIS.obj_4c_Opt_Tipo
1491: 			.ButtonCount   = 1
1492: 			.BackStyle     = 0
1493: 			.Value         = 1
1494: 			.Height        = 182
1495: 			.Left          = 13
1496: 			.SpecialEffect = 1
1497: 			.Top           = 431
1498: 			.Width         = 240
1499: 			.Themes        = .F.
1500: 			WITH .Buttons(1)
1501: 				.BackStyle = 0
1502: 				.Caption   = "Rabicho"
1503: 				.Height    = 16
1504: 				.Left      = 9
1505: 				.Style     = 0
1506: 				.Top       = 10
1507: 				.Width     = 197
1508: 				.ForeColor = RGB(90, 90, 90)
1509: 			ENDWITH
1510: 		ENDWITH
1511: 
1512: 		*-- Shape3 (borda visual do bloco impressora)
1513: 		THIS.AddObject("shp_4c_Shape3", "Shape")
1514: 		WITH THIS.shp_4c_Shape3
1515: 			.Top           = 431
1516: 			.Left          = 260
1517: 			.Height        = 106
1518: 			.Width         = 254
1519: 			.BackStyle     = 0
1520: 			.BorderWidth   = 1
1521: 			.SpecialEffect = 1
1522: 		ENDWITH
1523: 
1524: 		*-- Label "Impressora"
1525: 		THIS.AddObject("lbl_4c_LImpressora", "Label")
1526: 		WITH THIS.lbl_4c_LImpressora
1527: 			.AutoSize  = .F.
1528: 			.FontBold  = .T.
1529: 			.FontName  = "Tahoma"

*-- Linhas 1538 a 1581:
1538: 		ENDWITH
1539: 
1540: 		*-- Opt_Impressora (legado - Visible=.F., mantido por compatibilidade)
1541: 		THIS.AddObject("obj_4c_Opt_Impressora", "OptionGroup")
1542: 		WITH THIS.obj_4c_Opt_Impressora
1543: 			.ButtonCount   = 1
1544: 			.BackStyle     = 0
1545: 			.Value         = 1
1546: 			.Height        = 47
1547: 			.Left          = 260
1548: 			.SpecialEffect = 1
1549: 			.Top           = 431
1550: 			.Width         = 254
1551: 			.Themes        = .F.
1552: 			.Visible       = .F.
1553: 			WITH .Buttons(1)
1554: 				.BackStyle = 0
1555: 				.Caption   = "Gen" + CHR(233) + "rico/Somente Texto"
1556: 				.Height    = 16
1557: 				.Left      = 9
1558: 				.Style     = 0
1559: 				.Top       = 52
1560: 				.Width     = 210
1561: 				.ForeColor = RGB(36, 84, 155)
1562: 			ENDWITH
1563: 		ENDWITH
1564: 
1565: 		*-- Label "Sistema" (impressora sistema)
1566: 		THIS.AddObject("lbl_4c_LSistema", "Label")
1567: 		WITH THIS.lbl_4c_LSistema
1568: 			.AutoSize  = .F.
1569: 			.FontName  = "Tahoma"
1570: 			.FontSize  = 8
1571: 			.BackStyle = 0
1572: 			.Caption   = "Sistema"
1573: 			.Height    = 15
1574: 			.Left      = 270
1575: 			.Top       = 437
1576: 			.Width     = 55
1577: 			.ForeColor = RGB(90, 90, 90)
1578: 		ENDWITH
1579: 
1580: 		*-- Label "Windows" (impressora Windows)
1581: 		THIS.AddObject("lbl_4c_LWindows", "Label")

*-- Linhas 1619 a 1663:
1619: 			.BackStyle   = 0
1620: 			.BorderWidth = 0
1621: 
1622: 			*-- OptionGroup tipo impressora: 1=Allegro 2=Zebra ZPL 3=Zebra EPL
1623: 			.AddObject("obj_4c_OpcaoImp", "OptionGroup")
1624: 			WITH .obj_4c_OpcaoImp
1625: 				.ButtonCount = 3
1626: 				.Height      = 24
1627: 				.Left        = 5
1628: 				.Top         = 3
1629: 				.Width       = 241
1630: 				WITH .Buttons(1)
1631: 					.Caption   = "Allegro"
1632: 					.Left      = 2
1633: 					.Top       = 4
1634: 					.Width     = 51
1635: 					.AutoSize  = .F.
1636: 					.ForeColor = RGB(90, 90, 90)
1637: 					.BackStyle = 0
1638: 				ENDWITH
1639: 				WITH .Buttons(2)
1640: 					.Caption   = "Zebra ZPL"
1641: 					.Left      = 75
1642: 					.Top       = 4
1643: 					.Width     = 70
1644: 					.AutoSize  = .F.
1645: 					.FontName  = "Tahoma"
1646: 					.FontSize  = 8
1647: 					.ForeColor = RGB(90, 90, 90)
1648: 					.BackStyle = 0
1649: 				ENDWITH
1650: 				WITH .Buttons(3)
1651: 					.Caption   = "Zebra EPL"
1652: 					.Left      = 164
1653: 					.Top       = 4
1654: 					.Width     = 70
1655: 					.AutoSize  = .F.
1656: 					.Height    = 15
1657: 					.FontName  = "Tahoma"
1658: 					.FontSize  = 8
1659: 					.BackStyle = 0
1660: 					.ForeColor = RGB(90, 90, 90)
1661: 				ENDWITH
1662: 			ENDWITH
1663: 

*-- Linhas 1795 a 1839:
1795: 			.ForeColor = RGB(90, 90, 90)
1796: 		ENDWITH
1797: 
1798: 		*-- OptionGroup Separadora (opt_separador): 1=Sim 2=Nao
1799: 		THIS.AddObject("obj_4c_OptSeparador", "OptionGroup")
1800: 		WITH THIS.obj_4c_OptSeparador
1801: 			.ButtonCount   = 2
1802: 			.BackStyle     = 0
1803: 			.Value         = 1
1804: 			.Height        = 25
1805: 			.Left          = 601
1806: 			.SpecialEffect = 1
1807: 			.Top           = 412
1808: 			.Width         = 198
1809: 			.Themes        = .F.
1810: 			WITH .Buttons(1)
1811: 				.BackStyle = 0
1812: 				.Caption   = "Sim"
1813: 				.Height    = 15
1814: 				.Left      = 5
1815: 				.Top       = 5
1816: 				.Width     = 34
1817: 				.AutoSize  = .F.
1818: 				.ForeColor = RGB(90, 90, 90)
1819: 			ENDWITH
1820: 			WITH .Buttons(2)
1821: 				.FontName  = "Tahoma"
1822: 				.FontSize  = 8
1823: 				.BackStyle = 0
1824: 				.Caption   = "N" + CHR(227) + "o"
1825: 				.Height    = 15
1826: 				.Left      = 70
1827: 				.Top       = 5
1828: 				.Width     = 37
1829: 				.AutoSize  = .F.
1830: 				.ForeColor = RGB(90, 90, 90)
1831: 			ENDWITH
1832: 		ENDWITH
1833: 
1834: 		*-- Label "Preco"
1835: 		THIS.AddObject("lbl_4c_LblPreco", "Label")
1836: 		WITH THIS.lbl_4c_LblPreco
1837: 			.AutoSize  = .F.
1838: 			.FontName  = "Tahoma"
1839: 			.FontSize  = 8

*-- Linhas 1846 a 1890:
1846: 			.ForeColor = RGB(90, 90, 90)
1847: 		ENDWITH
1848: 
1849: 		*-- OptionGroup Preco (opt_Preco): 1=Sim 2=Nao 3=Ideal 4=Atual 5=PrecoDe/Por 6=Parcelamento
1850: 		THIS.AddObject("obj_4c_OptPreco", "OptionGroup")
1851: 		WITH THIS.obj_4c_OptPreco
1852: 			.ButtonCount   = 6
1853: 			.BackStyle     = 0
1854: 			.Value         = 1
1855: 			.Height        = 95
1856: 			.Left          = 601
1857: 			.SpecialEffect = 1
1858: 			.Top           = 439
1859: 			.Width         = 198
1860: 			.Themes        = .F.
1861: 			WITH .Buttons(1)
1862: 				.BackStyle = 0
1863: 				.Caption   = "Sim"
1864: 				.Height    = 15
1865: 				.Left      = 8
1866: 				.Top       = 7
1867: 				.Width     = 34
1868: 				.AutoSize  = .F.
1869: 				.ForeColor = RGB(90, 90, 90)
1870: 			ENDWITH
1871: 			WITH .Buttons(2)
1872: 				.FontName  = "Tahoma"
1873: 				.FontSize  = 8
1874: 				.BackStyle = 0
1875: 				.Caption   = "N" + CHR(227) + "o"
1876: 				.Height    = 15
1877: 				.Left      = 61
1878: 				.Top       = 7
1879: 				.Width     = 37
1880: 				.AutoSize  = .F.
1881: 				.ForeColor = RGB(90, 90, 90)
1882: 			ENDWITH
1883: 			WITH .Buttons(3)
1884: 				.FontName  = "Tahoma"
1885: 				.FontSize  = 8
1886: 				.BackStyle = 0
1887: 				.Caption   = "Ideal"
1888: 				.Height    = 15
1889: 				.Left      = 8
1890: 				.Top       = 28

*-- Linhas 1945 a 1989:
1945: 			.ForeColor = RGB(90, 90, 90)
1946: 		ENDWITH
1947: 
1948: 		*-- OptionGroup Peso (opt_peso): 1=Sim 2=Nao
1949: 		THIS.AddObject("obj_4c_OptPeso", "OptionGroup")
1950: 		WITH THIS.obj_4c_OptPeso
1951: 			.ButtonCount   = 2
1952: 			.BackStyle     = 0
1953: 			.Value         = 1
1954: 			.Height        = 25
1955: 			.Left          = 601
1956: 			.SpecialEffect = 1
1957: 			.Top           = 535
1958: 			.Width         = 198
1959: 			.Themes        = .F.
1960: 			WITH .Buttons(1)
1961: 				.BackStyle = 0
1962: 				.Caption   = "Sim"
1963: 				.Height    = 15
1964: 				.Left      = 5
1965: 				.Top       = 5
1966: 				.Width     = 41
1967: 				.AutoSize  = .F.
1968: 				.ForeColor = RGB(90, 90, 90)
1969: 			ENDWITH
1970: 			WITH .Buttons(2)
1971: 				.FontName  = "Tahoma"
1972: 				.FontSize  = 8
1973: 				.BackStyle = 0
1974: 				.Caption   = "N" + CHR(227) + "o"
1975: 				.Height    = 15
1976: 				.Left      = 70
1977: 				.Top       = 5
1978: 				.Width     = 41
1979: 				.AutoSize  = .F.
1980: 				.ForeColor = RGB(90, 90, 90)
1981: 			ENDWITH
1982: 		ENDWITH
1983: 
1984: 		*-- Label "Composicao"
1985: 		THIS.AddObject("lbl_4c_LblCompos", "Label")
1986: 		WITH THIS.lbl_4c_LblCompos
1987: 			.AutoSize  = .F.
1988: 			.FontName  = "Tahoma"
1989: 			.FontSize  = 8

*-- Linhas 1996 a 2040:
1996: 			.ForeColor = RGB(90, 90, 90)
1997: 		ENDWITH
1998: 
1999: 		*-- OptionGroup Composicao (optCompos): 1=Sim 2=Nao
2000: 		THIS.AddObject("obj_4c_OptCompos", "OptionGroup")
2001: 		WITH THIS.obj_4c_OptCompos
2002: 			.ButtonCount   = 2
2003: 			.BackStyle     = 0
2004: 			.Value         = 1
2005: 			.Height        = 25
2006: 			.Left          = 601
2007: 			.SpecialEffect = 1
2008: 			.Top           = 562
2009: 			.Width         = 198
2010: 			.Themes        = .F.
2011: 			WITH .Buttons(1)
2012: 				.BackStyle = 0
2013: 				.Caption   = "Sim"
2014: 				.Height    = 15
2015: 				.Left      = 5
2016: 				.Top       = 5
2017: 				.Width     = 41
2018: 				.AutoSize  = .F.
2019: 				.ForeColor = RGB(90, 90, 90)
2020: 			ENDWITH
2021: 			WITH .Buttons(2)
2022: 				.FontName  = "Tahoma"
2023: 				.FontSize  = 8
2024: 				.BackStyle = 0
2025: 				.Caption   = "N" + CHR(227) + "o"
2026: 				.Height    = 15
2027: 				.Left      = 70
2028: 				.Top       = 5
2029: 				.Width     = 41
2030: 				.AutoSize  = .F.
2031: 				.ForeColor = RGB(90, 90, 90)
2032: 			ENDWITH
2033: 		ENDWITH
2034: 
2035: 		*-- Label "Ordem"
2036: 		THIS.AddObject("lbl_4c_LblOrdem", "Label")
2037: 		WITH THIS.lbl_4c_LblOrdem
2038: 			.AutoSize  = .F.
2039: 			.FontName  = "Tahoma"
2040: 			.FontSize  = 8

*-- Linhas 2047 a 2340:
2047: 			.ForeColor = RGB(90, 90, 90)
2048: 		ENDWITH
2049: 
2050: 		*-- OptionGroup Ordem (OptOrdem): 1=Produto 2=Nenhuma
2051: 		THIS.AddObject("obj_4c_OptOrdem", "OptionGroup")
2052: 		WITH THIS.obj_4c_OptOrdem
2053: 			.ButtonCount   = 2
2054: 			.BackStyle     = 0
2055: 			.Value         = 1
2056: 			.Height        = 25
2057: 			.Left          = 601
2058: 			.SpecialEffect = 1
2059: 			.Top           = 589
2060: 			.Width         = 198
2061: 			.Themes        = .F.
2062: 			WITH .Buttons(1)
2063: 				.BackStyle = 0
2064: 				.Caption   = "Produto"
2065: 				.Height    = 15
2066: 				.Left      = 5
2067: 				.Top       = 4
2068: 				.Width     = 56
2069: 				.AutoSize  = .F.
2070: 				.ForeColor = RGB(90, 90, 90)
2071: 			ENDWITH
2072: 			WITH .Buttons(2)
2073: 				.FontName  = "Tahoma"
2074: 				.FontSize  = 8
2075: 				.BackStyle = 0
2076: 				.Caption   = "Nenhuma"
2077: 				.Height    = 15
2078: 				.Left      = 70
2079: 				.Top       = 4
2080: 				.Width     = 63
2081: 				.AutoSize  = .F.
2082: 				.ForeColor = RGB(90, 90, 90)
2083: 			ENDWITH
2084: 		ENDWITH
2085: 
2086: 		*-- BINDEVENTs (handlers sao PUBLIC - obrigatorio para BINDEVENT)
2087: 		BINDEVENT(THIS.obj_4c_Opt_Tipo, "InteractiveChange", THIS, "ObjOptTipoChange")
2088: 		BINDEVENT(THIS.cnt_4c_Impressora.obj_4c_OpcaoImp, "InteractiveChange", THIS, "ObjOpcaoImpChange")
2089: 		BINDEVENT(THIS.cbo_4c_GetPrinter, "InteractiveChange", THIS, "CboGetPrinterChange")
2090: 	ENDPROC
2091: 
2092: 	*====================================================================
2093: 	* PopularTiposEtiqueta - Adiciona botoes ao obj_4c_Opt_Tipo via BO
2094: 	*====================================================================
2095: 	PROTECTED PROCEDURE PopularTiposEtiqueta()
2096: 		IF VARTYPE(THIS.this_oBusinessObject) != "O"
2097: 			RETURN
2098: 		ENDIF
2099: 		IF !PEMSTATUS(THIS, "obj_4c_Opt_Tipo", 5) OR VARTYPE(THIS.obj_4c_Opt_Tipo) != "O"
2100: 			RETURN
2101: 		ENDIF
2102: 		THIS.this_oBusinessObject.CarregarTiposEtiqueta()
2103: 		IF !USED("cursor_4c_TiposEtq")
2104: 			RETURN
2105: 		ENDIF
2106: 		SELECT cursor_4c_TiposEtq
2107: 		LOCAL loc_nCount, loc_nTopo, loc_i, loc_cCaption
2108: 		loc_nCount = RECCOUNT("cursor_4c_TiposEtq")
2109: 		IF loc_nCount = 0
2110: 			RETURN
2111: 		ENDIF
2112: 		*-- Adiciona botoes conforme tipos retornados pelo BO (1 por linha)
2113: 		WITH THIS.obj_4c_Opt_Tipo
2114: 			.ButtonCount = loc_nCount
2115: 			loc_nTopo    = 10
2116: 			GO TOP IN cursor_4c_TiposEtq
2117: 			FOR loc_i = 1 TO loc_nCount
2118: 				SELECT cursor_4c_TiposEtq
2119: 				loc_cCaption = ALLTRIM(NVL(cursor_4c_TiposEtq.cEtiquetas, "Tipo " + TRANSFORM(loc_i)))
2120: 				WITH .Buttons(loc_i)
2121: 					.BackStyle = 0
2122: 					.Caption   = loc_cCaption
2123: 					.Tag       = TRANSFORM(NVL(cursor_4c_TiposEtq.nTipos, loc_i))
2124: 					.Height    = 16
2125: 					.Left      = 9
2126: 					.Style     = 0
2127: 					.Top       = loc_nTopo
2128: 					.Width     = 197
2129: 					.ForeColor = RGB(90, 90, 90)
2130: 				ENDWITH
2131: 				loc_nTopo = loc_nTopo + 18
2132: 				SKIP IN cursor_4c_TiposEtq
2133: 			ENDFOR
2134: 			.Height = loc_nTopo + 10
2135: 		ENDWITH
2136: 		USE IN cursor_4c_TiposEtq
2137: 	ENDPROC
2138: 
2139: 	*====================================================================
2140: 	* AplicarConfiguracoes - Carrega impressoras e preenche controles
2141: 	*====================================================================
2142: 	PROTECTED PROCEDURE AplicarConfiguracoes()
2143: 		IF VARTYPE(THIS.this_oBusinessObject) != "O"
2144: 			RETURN
2145: 		ENDIF
2146: 		*-- Carrega lista de impressoras no ComboBox
2147: 		THIS.this_oBusinessObject.CarregarImpressoras()
2148: 		IF PEMSTATUS(THIS, "cbo_4c_GetPrinter", 5) AND VARTYPE(THIS.cbo_4c_GetPrinter) = "O"
2149: 			THIS.cbo_4c_GetPrinter.RowSourceType = 2
2150: 			THIS.cbo_4c_GetPrinter.RowSource     = "cursor_4c_SigCdmp"
2151: 			IF USED("cursor_4c_SigCdmp") AND RECCOUNT("cursor_4c_SigCdmp") > 0
2152: 				THIS.cbo_4c_GetPrinter.Requery()
2153: 			ENDIF
2154: 			*-- Seleciona impressora padrao do BO
2155: 			IF !EMPTY(THIS.this_oBusinessObject.this_cNomeImp)
2156: 				THIS.cbo_4c_GetPrinter.Value = ALLTRIM(THIS.this_oBusinessObject.this_cNomeImp)
2157: 			ENDIF
2158: 		ENDIF
2159: 		*-- Preenche spinners com valores das configuracoes lidas pelo BO
2160: 		IF PEMSTATUS(THIS, "cnt_4c_Impressora", 5) AND VARTYPE(THIS.cnt_4c_Impressora) = "O"
2161: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjVerts", 5)
2162: 				THIS.cnt_4c_Impressora.spn_4c_AjVerts.Value = THIS.this_oBusinessObject.this_nAjVerts
2163: 			ENDIF
2164: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjHorzs", 5)
2165: 				THIS.cnt_4c_Impressora.spn_4c_AjHorzs.Value = THIS.this_oBusinessObject.this_nAjHorzs
2166: 			ENDIF
2167: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjDenss", 5)
2168: 				THIS.cnt_4c_Impressora.spn_4c_AjDenss.Value = THIS.this_oBusinessObject.this_nAjDenss
2169: 			ENDIF
2170: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjVelos", 5)
2171: 				THIS.cnt_4c_Impressora.spn_4c_AjVelos.Value = THIS.this_oBusinessObject.this_nAjVelos
2172: 			ENDIF
2173: 			*-- Tipo de impressora
2174: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "obj_4c_OpcaoImp", 5) AND ;
2175: 			   VARTYPE(THIS.cnt_4c_Impressora.obj_4c_OpcaoImp) = "O"
2176: 				THIS.cnt_4c_Impressora.obj_4c_OpcaoImp.Value = THIS.this_oBusinessObject.this_nTpImp
2177: 			ENDIF
2178: 		ENDIF
2179: 		*-- Tipo de etiqueta padrao
2180: 		IF PEMSTATUS(THIS, "obj_4c_Opt_Tipo", 5) AND VARTYPE(THIS.obj_4c_Opt_Tipo) = "O"
2181: 			THIS.obj_4c_Opt_Tipo.Value = THIS.this_oBusinessObject.this_nTpEtiPadrao
2182: 		ENDIF
2183: 		*-- Separadora padrao (EtqSeps de SigCdPac, carregado em CarregarConfiguracoes)
2184: 		IF PEMSTATUS(THIS, "obj_4c_OptSeparador", 5) AND VARTYPE(THIS.obj_4c_OptSeparador) = "O"
2185: 			THIS.obj_4c_OptSeparador.Value = IIF(THIS.this_oBusinessObject.this_lImpSepar, 1, 2)
2186: 		ENDIF
2187: 	ENDPROC
2188: 
2189: 	*====================================================================
2190: 	* ObjOptTipoChange - Atualiza tipo etiqueta no BO (PUBLIC p/ BINDEVENT)
2191: 	*====================================================================
2192: 	PROCEDURE ObjOptTipoChange()
2193: 		IF VARTYPE(THIS.this_oBusinessObject) != "O"
2194: 			RETURN
2195: 		ENDIF
2196: 		IF !PEMSTATUS(THIS, "obj_4c_Opt_Tipo", 5) OR VARTYPE(THIS.obj_4c_Opt_Tipo) != "O"
2197: 			RETURN
2198: 		ENDIF
2199: 		LOCAL loc_nSel, loc_cTag
2200: 		loc_nSel = THIS.obj_4c_Opt_Tipo.Value
2201: 		IF loc_nSel >= 1 AND loc_nSel <= THIS.obj_4c_Opt_Tipo.ButtonCount
2202: 			loc_cTag = ALLTRIM(NVL(THIS.obj_4c_Opt_Tipo.Buttons(loc_nSel).Tag, ""))
2203: 			IF !EMPTY(loc_cTag) AND VAL(loc_cTag) > 0
2204: 				THIS.this_oBusinessObject.this_nTpEti = VAL(loc_cTag)
2205: 			ELSE
2206: 				THIS.this_oBusinessObject.this_nTpEti = loc_nSel
2207: 			ENDIF
2208: 		ENDIF
2209: 	ENDPROC
2210: 
2211: 	*====================================================================
2212: 	* ObjOpcaoImpChange - Atualiza tipo impressora no BO (PUBLIC p/ BINDEVENT)
2213: 	*====================================================================
2214: 	PROCEDURE ObjOpcaoImpChange()
2215: 		IF VARTYPE(THIS.this_oBusinessObject) != "O"
2216: 			RETURN
2217: 		ENDIF
2218: 		IF !PEMSTATUS(THIS, "cnt_4c_Impressora", 5)
2219: 			RETURN
2220: 		ENDIF
2221: 		IF !PEMSTATUS(THIS.cnt_4c_Impressora, "obj_4c_OpcaoImp", 5)
2222: 			RETURN
2223: 		ENDIF
2224: 		THIS.this_oBusinessObject.this_nTpImp = ;
2225: 			NVL(THIS.cnt_4c_Impressora.obj_4c_OpcaoImp.Value, 1)
2226: 	ENDPROC
2227: 
2228: 	*====================================================================
2229: 	* CboGetPrinterChange - Atualiza impressora no BO (PUBLIC p/ BINDEVENT)
2230: 	*====================================================================
2231: 	PROCEDURE CboGetPrinterChange()
2232: 		IF VARTYPE(THIS.this_oBusinessObject) != "O"
2233: 			RETURN
2234: 		ENDIF
2235: 		IF !PEMSTATUS(THIS, "cbo_4c_GetPrinter", 5) OR VARTYPE(THIS.cbo_4c_GetPrinter) != "O"
2236: 			RETURN
2237: 		ENDIF
2238: 		THIS.this_oBusinessObject.this_cNomeImp = ;
2239: 			ALLTRIM(NVL(THIS.cbo_4c_GetPrinter.Value, ""))
2240: 	ENDPROC
2241: 
2242: 	*====================================================================
2243: 	* TxtNumesKeyPress - Valida numero do documento (PUBLIC p/ BINDEVENT)
2244: 	*====================================================================
2245: 	PROCEDURE TxtNumesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2246: 		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
2247: 			RETURN
2248: 		ENDIF
2249: 		IF !PEMSTATUS(THIS, "txt_4c_Numes", 5) OR VARTYPE(THIS.txt_4c_Numes) != "O"
2250: 			RETURN
2251: 		ENDIF
2252: 		LOCAL loc_nNumes
2253: 		loc_nNumes = NVL(THIS.txt_4c_Numes.Value, 0)
2254: 		IF loc_nNumes <= 0
2255: 			MsgAviso("Informe o n" + CHR(250) + "mero do documento.", ;
2256: 			         "Aten" + CHR(231) + CHR(227) + "o")
2257: 			THIS.txt_4c_Numes.SetFocus()
2258: 			RETURN
2259: 		ENDIF
2260: 		IF PEMSTATUS(THIS, "txt_4c_Lpreco", 5) AND VARTYPE(THIS.txt_4c_Lpreco) = "O"
2261: 			THIS.txt_4c_Lpreco.SetFocus()
2262: 		ENDIF
2263: 	ENDPROC
2264: 
2265: 	*====================================================================
2266: 	* ChkListaClick - Valida preenchimento da lista de precos (PUBLIC p/ BINDEVENT)
2267: 	*====================================================================
2268: 	PROCEDURE ChkListaClick()
2269: 		IF !PEMSTATUS(THIS, "chk_4c_Lista", 5) OR VARTYPE(THIS.chk_4c_Lista) != "O"
2270: 			RETURN
2271: 		ENDIF
2272: 		IF THIS.chk_4c_Lista.Value != 1
2273: 			RETURN
2274: 		ENDIF
2275: 		IF !PEMSTATUS(THIS, "txt_4c_Lpreco", 5) OR VARTYPE(THIS.txt_4c_Lpreco) != "O"
2276: 			RETURN
2277: 		ENDIF
2278: 		IF EMPTY(ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value, "")))
2279: 			MsgAviso("Informe a lista de pre" + CHR(231) + "os para usar este filtro.", ;
2280: 			         "Aten" + CHR(231) + CHR(227) + "o")
2281: 			THIS.txt_4c_Lpreco.SetFocus()
2282: 		ENDIF
2283: 	ENDPROC
2284: 
2285: 	*====================================================================
2286: 	* ChkPrecioClick - Recarrega precos ao ativar filtro (PUBLIC p/ BINDEVENT)
2287: 	*====================================================================
2288: 	PROCEDURE ChkPrecioClick()
2289: 		IF !PEMSTATUS(THIS, "chk_4c_Precio", 5) OR VARTYPE(THIS.chk_4c_Precio) != "O"
2290: 			RETURN
2291: 		ENDIF
2292: 		IF THIS.chk_4c_Precio.Value = 1
2293: 			THIS.AtualizarPrecoPorLista()
2294: 		ENDIF
2295: 	ENDPROC
2296: 
2297: 	*====================================================================
2298: 	* FormParaBO - Copia todos os campos do form para o BO
2299: 	*====================================================================
2300: 	PROCEDURE FormParaBO()
2301: 		IF VARTYPE(THIS.this_oBusinessObject) != "O"
2302: 			RETURN
2303: 		ENDIF
2304: 		THIS.this_oBusinessObject.this_cEmps  = ALLTRIM(NVL(THIS.txt_4c_Emps.Value,  ""))
2305: 		THIS.this_oBusinessObject.this_cDopes = ALLTRIM(NVL(THIS.txt_4c_Dopes.Value, ""))
2306: 		IF PEMSTATUS(THIS, "txt_4c_Numes", 5) AND VARTYPE(THIS.txt_4c_Numes) = "O"
2307: 			THIS.this_oBusinessObject.this_nNumes = NVL(THIS.txt_4c_Numes.Value, 0)
2308: 		ENDIF
2309: 		THIS.this_oBusinessObject.this_cLpreco  = ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value,  ""))
2310: 		THIS.this_oBusinessObject.this_cLpreco2 = ALLTRIM(NVL(THIS.txt_4c_LPreco2.Value, ""))
2311: 		IF PEMSTATUS(THIS, "obj_4c_Opt_Tipo", 5) AND VARTYPE(THIS.obj_4c_Opt_Tipo) = "O"
2312: 			THIS.this_oBusinessObject.this_nTpEti = NVL(THIS.obj_4c_Opt_Tipo.Value, 1)
2313: 		ENDIF
2314: 		IF PEMSTATUS(THIS, "cnt_4c_Impressora", 5) AND VARTYPE(THIS.cnt_4c_Impressora) = "O"
2315: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "obj_4c_OpcaoImp", 5)
2316: 				THIS.this_oBusinessObject.this_nTpImp = ;
2317: 					NVL(THIS.cnt_4c_Impressora.obj_4c_OpcaoImp.Value, 1)
2318: 			ENDIF
2319: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjVerts", 5)
2320: 				THIS.this_oBusinessObject.this_nAjVerts = ;
2321: 					NVL(THIS.cnt_4c_Impressora.spn_4c_AjVerts.Value, 0)
2322: 			ENDIF
2323: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjHorzs", 5)
2324: 				THIS.this_oBusinessObject.this_nAjHorzs = ;
2325: 					NVL(THIS.cnt_4c_Impressora.spn_4c_AjHorzs.Value, 0)
2326: 			ENDIF
2327: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjDenss", 5)
2328: 				THIS.this_oBusinessObject.this_nAjDenss = ;
2329: 					NVL(THIS.cnt_4c_Impressora.spn_4c_AjDenss.Value, 0)
2330: 			ENDIF
2331: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjVelos", 5)
2332: 				THIS.this_oBusinessObject.this_nAjVelos = ;
2333: 					NVL(THIS.cnt_4c_Impressora.spn_4c_AjVelos.Value, 0)
2334: 			ENDIF
2335: 		ENDIF
2336: 		IF PEMSTATUS(THIS, "cbo_4c_GetPrinter", 5) AND VARTYPE(THIS.cbo_4c_GetPrinter) = "O"
2337: 			THIS.this_oBusinessObject.this_cNomeImp = ;
2338: 				ALLTRIM(NVL(THIS.cbo_4c_GetPrinter.Value, ""))
2339: 		ENDIF
2340: 		IF PEMSTATUS(THIS, "obj_4c_OptPreco", 5) AND VARTYPE(THIS.obj_4c_OptPreco) = "O"

*-- Linhas 2360 a 2403:
2360: 	*====================================================================
2361: 	* BOParaForm - Aplica propriedades do BO nos controles do form
2362: 	*====================================================================
2363: 	PROCEDURE BOParaForm()
2364: 		IF VARTYPE(THIS.this_oBusinessObject) != "O"
2365: 			RETURN
2366: 		ENDIF
2367: 		THIS.txt_4c_Emps.Value  = NVL(THIS.this_oBusinessObject.this_cEmps,  "")
2368: 		THIS.txt_4c_Dopes.Value = NVL(THIS.this_oBusinessObject.this_cDopes, "")
2369: 		IF PEMSTATUS(THIS, "txt_4c_Numes", 5) AND VARTYPE(THIS.txt_4c_Numes) = "O"
2370: 			THIS.txt_4c_Numes.Value = NVL(THIS.this_oBusinessObject.this_nNumes, 0)
2371: 		ENDIF
2372: 		THIS.txt_4c_Lpreco.Value  = NVL(THIS.this_oBusinessObject.this_cLpreco,  "")
2373: 		THIS.txt_4c_LPreco2.Value = NVL(THIS.this_oBusinessObject.this_cLpreco2, "")
2374: 		IF PEMSTATUS(THIS, "obj_4c_Opt_Tipo", 5) AND VARTYPE(THIS.obj_4c_Opt_Tipo) = "O"
2375: 			THIS.obj_4c_Opt_Tipo.Value = NVL(THIS.this_oBusinessObject.this_nTpEti, 1)
2376: 		ENDIF
2377: 		IF PEMSTATUS(THIS, "cnt_4c_Impressora", 5) AND VARTYPE(THIS.cnt_4c_Impressora) = "O"
2378: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "obj_4c_OpcaoImp", 5)
2379: 				THIS.cnt_4c_Impressora.obj_4c_OpcaoImp.Value = ;
2380: 					NVL(THIS.this_oBusinessObject.this_nTpImp, 1)
2381: 			ENDIF
2382: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjVerts", 5)
2383: 				THIS.cnt_4c_Impressora.spn_4c_AjVerts.Value = ;
2384: 					NVL(THIS.this_oBusinessObject.this_nAjVerts, 0)
2385: 			ENDIF
2386: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjHorzs", 5)
2387: 				THIS.cnt_4c_Impressora.spn_4c_AjHorzs.Value = ;
2388: 					NVL(THIS.this_oBusinessObject.this_nAjHorzs, 0)
2389: 			ENDIF
2390: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjDenss", 5)
2391: 				THIS.cnt_4c_Impressora.spn_4c_AjDenss.Value = ;
2392: 					NVL(THIS.this_oBusinessObject.this_nAjDenss, 20)
2393: 			ENDIF
2394: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjVelos", 5)
2395: 				THIS.cnt_4c_Impressora.spn_4c_AjVelos.Value = ;
2396: 					NVL(THIS.this_oBusinessObject.this_nAjVelos, 3)
2397: 			ENDIF
2398: 		ENDIF
2399: 		IF PEMSTATUS(THIS, "cbo_4c_GetPrinter", 5) AND VARTYPE(THIS.cbo_4c_GetPrinter) = "O"
2400: 			THIS.cbo_4c_GetPrinter.Value = NVL(THIS.this_oBusinessObject.this_cNomeImp, "")
2401: 		ENDIF
2402: 		IF PEMSTATUS(THIS, "obj_4c_OptPreco", 5) AND VARTYPE(THIS.obj_4c_OptPreco) = "O"
2403: 			THIS.obj_4c_OptPreco.Value = NVL(THIS.this_oBusinessObject.this_nImpPreco, 1)

*-- Linhas 2422 a 2465:
2422: 	*====================================================================
2423: 	* HabilitarCampos - Habilita ou desabilita controles de entrada
2424: 	*====================================================================
2425: 	PROCEDURE HabilitarCampos(par_lHabilitar)
2426: 		IF PEMSTATUS(THIS, "txt_4c_Emps", 5) AND VARTYPE(THIS.txt_4c_Emps) = "O"
2427: 			THIS.txt_4c_Emps.Enabled = par_lHabilitar
2428: 		ENDIF
2429: 		IF PEMSTATUS(THIS, "txt_4c_Dopes", 5) AND VARTYPE(THIS.txt_4c_Dopes) = "O"
2430: 			THIS.txt_4c_Dopes.Enabled = par_lHabilitar
2431: 		ENDIF
2432: 		IF PEMSTATUS(THIS, "txt_4c_Numes", 5) AND VARTYPE(THIS.txt_4c_Numes) = "O"
2433: 			THIS.txt_4c_Numes.Enabled = par_lHabilitar
2434: 		ENDIF
2435: 		IF PEMSTATUS(THIS, "txt_4c_Lpreco", 5) AND VARTYPE(THIS.txt_4c_Lpreco) = "O"
2436: 			THIS.txt_4c_Lpreco.Enabled = par_lHabilitar
2437: 		ENDIF
2438: 		IF PEMSTATUS(THIS, "txt_4c_LPreco2", 5) AND VARTYPE(THIS.txt_4c_LPreco2) = "O"
2439: 			THIS.txt_4c_LPreco2.Enabled = par_lHabilitar
2440: 		ENDIF
2441: 		IF PEMSTATUS(THIS, "chk_4c_Lista", 5) AND VARTYPE(THIS.chk_4c_Lista) = "O"
2442: 			THIS.chk_4c_Lista.Enabled = par_lHabilitar
2443: 		ENDIF
2444: 		IF PEMSTATUS(THIS, "chk_4c_Precio", 5) AND VARTYPE(THIS.chk_4c_Precio) = "O"
2445: 			THIS.chk_4c_Precio.Enabled = par_lHabilitar
2446: 		ENDIF
2447: 		IF PEMSTATUS(THIS, "obj_4c_OptPreco", 5) AND VARTYPE(THIS.obj_4c_OptPreco) = "O"
2448: 			THIS.obj_4c_OptPreco.Enabled = par_lHabilitar
2449: 		ENDIF
2450: 		IF PEMSTATUS(THIS, "obj_4c_OptSeparador", 5) AND VARTYPE(THIS.obj_4c_OptSeparador) = "O"
2451: 			THIS.obj_4c_OptSeparador.Enabled = par_lHabilitar
2452: 		ENDIF
2453: 		IF PEMSTATUS(THIS, "obj_4c_OptPeso", 5) AND VARTYPE(THIS.obj_4c_OptPeso) = "O"
2454: 			THIS.obj_4c_OptPeso.Enabled = par_lHabilitar
2455: 		ENDIF
2456: 		IF PEMSTATUS(THIS, "obj_4c_OptCompos", 5) AND VARTYPE(THIS.obj_4c_OptCompos) = "O"
2457: 			THIS.obj_4c_OptCompos.Enabled = par_lHabilitar
2458: 		ENDIF
2459: 		IF PEMSTATUS(THIS, "obj_4c_OptOrdem", 5) AND VARTYPE(THIS.obj_4c_OptOrdem) = "O"
2460: 			THIS.obj_4c_OptOrdem.Enabled = par_lHabilitar
2461: 		ENDIF
2462: 		IF PEMSTATUS(THIS, "obj_4c_Opt_Tipo", 5) AND VARTYPE(THIS.obj_4c_Opt_Tipo) = "O"
2463: 			THIS.obj_4c_Opt_Tipo.Enabled = par_lHabilitar
2464: 		ENDIF
2465: 		IF PEMSTATUS(THIS, "cnt_4c_Impressora", 5) AND VARTYPE(THIS.cnt_4c_Impressora) = "O"

*-- Linhas 2473 a 2516:
2473: 	*====================================================================
2474: 	* LimparCampos - Reseta filtros e zera a lista de etiquetas
2475: 	*====================================================================
2476: 	PROCEDURE LimparCampos()
2477: 		IF PEMSTATUS(THIS, "txt_4c_Emps", 5) AND VARTYPE(THIS.txt_4c_Emps) = "O"
2478: 			THIS.txt_4c_Emps.Value = ""
2479: 		ENDIF
2480: 		IF PEMSTATUS(THIS, "txt_4c_Dopes", 5) AND VARTYPE(THIS.txt_4c_Dopes) = "O"
2481: 			THIS.txt_4c_Dopes.Value = ""
2482: 		ENDIF
2483: 		IF PEMSTATUS(THIS, "txt_4c_Numes", 5) AND VARTYPE(THIS.txt_4c_Numes) = "O"
2484: 			THIS.txt_4c_Numes.Value = 0
2485: 		ENDIF
2486: 		IF PEMSTATUS(THIS, "txt_4c_Lpreco", 5) AND VARTYPE(THIS.txt_4c_Lpreco) = "O"
2487: 			THIS.txt_4c_Lpreco.Value = ""
2488: 		ENDIF
2489: 		IF PEMSTATUS(THIS, "txt_4c_LPreco2", 5) AND VARTYPE(THIS.txt_4c_LPreco2) = "O"
2490: 			THIS.txt_4c_LPreco2.Value = ""
2491: 		ENDIF
2492: 		IF PEMSTATUS(THIS, "lbl_4c_DEmps", 5) AND VARTYPE(THIS.lbl_4c_DEmps) = "O"
2493: 			THIS.lbl_4c_DEmps.Caption = ""
2494: 		ENDIF
2495: 		IF PEMSTATUS(THIS, "chk_4c_Lista", 5) AND VARTYPE(THIS.chk_4c_Lista) = "O"
2496: 			THIS.chk_4c_Lista.Value = 0
2497: 		ENDIF
2498: 		IF PEMSTATUS(THIS, "chk_4c_Precio", 5) AND VARTYPE(THIS.chk_4c_Precio) = "O"
2499: 			THIS.chk_4c_Precio.Value = 0
2500: 		ENDIF
2501: 		IF PEMSTATUS(THIS, "txt_4c_Cpros", 5) AND VARTYPE(THIS.txt_4c_Cpros) = "O"
2502: 			THIS.txt_4c_Cpros.Value = ""
2503: 		ENDIF
2504: 		IF PEMSTATUS(THIS, "txt_4c_Dpros", 5) AND VARTYPE(THIS.txt_4c_Dpros) = "O"
2505: 			THIS.txt_4c_Dpros.Value = ""
2506: 		ENDIF
2507: 		IF PEMSTATUS(THIS, "txt_4c_Qtds", 5) AND VARTYPE(THIS.txt_4c_Qtds) = "O"
2508: 			THIS.txt_4c_Qtds.Value = 0
2509: 		ENDIF
2510: 		IF USED("cursor_4c_Etiquetas")
2511: 			SELECT cursor_4c_Etiquetas
2512: 			ZAP
2513: 			APPEND BLANK
2514: 			GO TOP
2515: 		ENDIF
2516: 		IF PEMSTATUS(THIS, "grd_4c_Etiquetas", 5) AND VARTYPE(THIS.grd_4c_Etiquetas) = "O"

*-- Linhas 2524 a 2566:
2524: 	*====================================================================
2525: 	* CarregarLista - Reposiciona no topo e atualiza grid (OPERACIONAL)
2526: 	*====================================================================
2527: 	PROCEDURE CarregarLista()
2528: 		IF !USED("cursor_4c_Etiquetas")
2529: 			RETURN
2530: 		ENDIF
2531: 		SELECT cursor_4c_Etiquetas
2532: 		GO TOP
2533: 		IF PEMSTATUS(THIS, "grd_4c_Etiquetas", 5) AND VARTYPE(THIS.grd_4c_Etiquetas) = "O"
2534: 			THIS.grd_4c_Etiquetas.Refresh()
2535: 		ENDIF
2536: 	ENDPROC
2537: 
2538: 	*====================================================================
2539: 	* AjustarBotoesPorModo - Stub (OPERACIONAL nao tem modos CRUD)
2540: 	*====================================================================
2541: 	PROCEDURE AjustarBotoesPorModo()
2542: 		RETURN
2543: 	ENDPROC
2544: 
2545: 	*====================================================================
2546: 	* BtnBuscarClick - Carrega itens da lista por empresa/operacao/numes
2547: 	*====================================================================
2548: 	PROCEDURE BtnBuscarClick()
2549: 		THIS.CarregarItensDaLista()
2550: 	ENDPROC
2551: 
2552: 	*====================================================================
2553: 	* BtnSalvarClick - Equivale a imprimir no contexto OPERACIONAL
2554: 	*====================================================================
2555: 	PROCEDURE BtnSalvarClick()
2556: 		THIS.BtnImprimirClick()
2557: 	ENDPROC
2558: 
2559: 	*====================================================================
2560: 	* BtnCancelarClick - Limpa campos e zera lista (OPERACIONAL)
2561: 	*====================================================================
2562: 	PROCEDURE BtnCancelarClick()
2563: 		THIS.LimparCampos()
2564: 	ENDPROC
2565: 
2566: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrEtqBO.prg):
*==============================================================================
* SigPrEtqBO.prg - Business Object para Impressao de Etiquetas Selecionadas
* Herda de: BusinessBase
*==============================================================================
DEFINE CLASS SigPrEtqBO AS BusinessBase

    *-- Identificacao (sem tabela primaria - form OPERACIONAL)
    this_cTabela      = ""
    this_cCampoChave  = ""

    *-- Filtros do cabecalho (campos de selecao do form)
    this_cEmps        = ""    && Empresa (C3)
    this_cDopes       = ""    && Operacao (C20)
    this_nNumes       = 0     && Numero da operacao (N6)
    this_cLpreco      = ""    && Lista de Precos 1 (C30)
    this_cLpreco2     = ""    && Lista de Precos 2 (C30)

    *-- Configuracoes de impressao (lidas de SigCdPam / SigCdPac)
    this_nTpEti       = 0     && Tipo de etiqueta selecionado
    this_nTpImp       = 1     && Tipo de impressora (1=Allegro, 2=ZPL, 3=EPL)
    this_nAjVerts     = 0     && Ajuste vertical
    this_nAjHorzs     = 0     && Ajuste horizontal
    this_nAjDenss     = 20    && Densidade
    this_nAjVelos     = 1     && Velocidade
    this_cNomeImp     = ""    && Nome da impressora selecionada
    this_nMaxTpEtis   = 7     && Maximo de tipos de etiqueta (de SigCdPam)
    this_nTpEtiPadrao = 1     && Tipo padrao (TpEtiPads em SigCdPam)

    *-- Opcoes de impressao selecionadas pelo usuario
    this_nImpPreco    = 1     && Opcao de preco (1=Sim, 2=Nao, 3=Ideal, 4=Atual, 5=PrecoDe/Por, 6=Parcelamento)
    this_lImpSepar    = .T.   && Imprimir separadora (opt_separador)
    this_lImpPeso     = .T.   && Imprimir peso (opt_peso)
    this_lCompo       = .T.   && Imprimir composicao (optCompos)
    this_nOrdem       = 1     && Ordenacao (1=Produto, 2=Nenhuma)

    *-- Estado interno
    this_lCarregouItens = .F. && Flag: itens foram carregados no cursor
    this_cBop           = ""  && Codigo BOP para impressao (Ndopes padded + Numes padded)

    *-- Item corrente do grid (cursor_4c_Etiquetas - campos de dbImpressao)
    this_cItemCpros      = ""    && Codigo produto (C14)
    this_cItemDpros      = ""    && Descricao produto (C40)
    this_cItemDpro2s     = ""    && Descritivo/Referencia fornecedor (C45)
    this_cItemReffs      = ""    && Referencia interna (C40)
    this_nItemQtds       = 0     && Quantidade (N10,3)
    this_nItemQtdeEtiq   = 0     && Quantidade de etiquetas (N10,3)
    this_cItemObs        = ""    && Observacao/codigo lista de precos (C10)
    this_cItemPedido     = ""    && Pedido (C30)
    this_nItemPvens      = 0     && Preco de venda (N12,2)
    this_nItemPrecoDe    = 0     && Preco DE (N12,2)
    this_nItemParcelas   = 0     && Parcelas (N2,0)
    this_cItemEmpos      = ""    && Empresa (C3)
    this_cItemEmpdopnums = ""    && Chave EmpDopNums (C29)
    this_nItemCitens     = 0     && Numero do item/citens (N10)
    this_nItemPesos      = 0     && Peso medio (N12,2)
    this_cItemCodTams    = ""    && Codigo tamanho (C4)
    this_cItemCpros2     = ""    && Produto alternativo 2 (C14)
    this_cItemCpros3     = ""    && Produto alternativo 3 (C14)
    this_cItemCpros4     = ""    && Produto alternativo 4 (C14)

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna codigo do produto atual como chave de auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cItemCpros)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarConfiguracoes - Le SigCdPam e SigCdPac para configurar impressora
    * Retorna .T. se leu com sucesso
    *--------------------------------------------------------------------------
    FUNCTION CarregarConfiguracoes()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            LOCAL loc_cSql, loc_cCpos

            loc_cCpos = "nMaxTpEtis, TpEtiPads, nMaxImpEti, ImpEtis, TpInstalas, AjVerts, AjHorzs, TpCBars"
            loc_cSql = "SELECT " + loc_cCpos + " FROM SigCdPam"

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_Pam") > 0
                IF USED("cursor_4c_Pam") AND !EOF("cursor_4c_Pam")
                    SELECT cursor_4c_Pam
                    GO TOP
                    THIS.this_nMaxTpEtis   = NVL(cursor_4c_Pam.nMaxTpEtis, 7)
                    THIS.this_nTpEtiPadrao = NVL(cursor_4c_Pam.TpEtiPads, 1)
                    THIS.this_nAjVerts     = NVL(cursor_4c_Pam.AjVerts, 0)
                    THIS.this_nAjHorzs     = NVL(cursor_4c_Pam.AjHorzs, 0)
                    THIS.this_nTpImp       = IIF(NVL(cursor_4c_Pam.ImpEtis, 0) <> 0, NVL(cursor_4c_Pam.ImpEtis, 1), 1)
                ENDIF
            ENDIF

            LOCAL loc_cSqlPac
            loc_cSqlPac = "SELECT AjDens, AjVelos, EtqSeps FROM SigCdPac"

            IF SQLEXEC(gnConnHandle, loc_cSqlPac, "cursor_4c_Pac") > 0
                IF USED("cursor_4c_Pac") AND !EOF("cursor_4c_Pac")
                    SELECT cursor_4c_Pac
                    GO TOP
                    THIS.this_nAjDenss = IIF(EMPTY(cursor_4c_Pac.AjDens), 20, NVL(cursor_4c_Pac.AjDens, 20))
                    THIS.this_nAjVelos = IIF(EMPTY(cursor_4c_Pac.AjVelos), 1, NVL(cursor_4c_Pac.AjVelos, 1))
                    THIS.this_lImpSepar = (NVL(cursor_4c_Pac.EtqSeps, 1) = 1)
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar configura" + CHR(231) + CHR(245) + "es")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarTiposEtiqueta - Le SigCdTpe e retorna cursor cursor_4c_TiposEtq
    * Retorna contagem de tipos ativos ou -1 em erro
    *--------------------------------------------------------------------------
    FUNCTION CarregarTiposEtiqueta()
        LOCAL loc_nTipos, loc_oErro
        loc_nTipos = -1

        TRY
            LOCAL loc_cSql
            loc_cSql = "SELECT nTipos, cEtiquetas, cOrdems, nSituas " + ;
                       "FROM SigCdTpe " + ;
                       "WHERE nSituas = 1 " + ;
                       "ORDER BY cOrdems, cEtiquetas"

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_TiposEtq") > 0
                IF USED("cursor_4c_TiposEtq")
                    loc_nTipos = RECCOUNT("cursor_4c_TiposEtq")
                ELSE
                    loc_nTipos = 0
                ENDIF
            ELSE
                loc_nTipos = 0
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar tipos de etiqueta")
            loc_nTipos = -1
        ENDTRY

        RETURN loc_nTipos
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarImpressoras - Le impressoras do sistema e do Windows
    * Preenche cursor_4c_Impressoras com IDupla, impres, impresS
    * Retorna contagem de impressoras ou -1 em erro
    *--------------------------------------------------------------------------
    FUNCTION CarregarImpressoras()
        LOCAL loc_nImpressoras, loc_oErro
        loc_nImpressoras = -1

        TRY
            LOCAL loc_cSql, loc_cSqlGrupo

            *-- Impressoras do sistema autorizadas ao usuario via usuario direto
            loc_cSql = "SELECT b.Impres " + ;
                       "FROM SigSyImp a, SigCdmp b " + ;
                       "WHERE a.UsuAcess = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " AND a.CImps = b.Impres AND b.nTpImpres = 2 " + ;
                       "UNION ALL " + ;
                       "SELECT c.Impres " + ;
                       "FROM SigCdAcG a, SigSyImp b, SigCdmp c " + ;
                       "WHERE a.Usuarios = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " AND a.Grupos = b.GrAcess " + ;
                       "AND b.CImps = c.Impres AND c.nTpImpres = 2"

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_TmpCimp") <= 0
                *-- Fallback: todas as impressoras de etiqueta
                LOCAL loc_cSqlAll
                loc_cSqlAll = "SELECT DISTINCT Impres FROM SigCdmp WHERE nTpImpres = 2 ORDER BY Impres"
                IF SQLEXEC(gnConnHandle, loc_cSqlAll, "cursor_4c_TmpCimp") < 1
                    loc_nImpressoras = 0
                    loc_lSucesso = loc_nImpressoras
                ENDIF
            ENDIF

            *-- Obtem impressoras distintas autorizadas
            IF USED("cursor_4c_TmpCimp") AND RECCOUNT("cursor_4c_TmpCimp") > 0
                SELECT DISTINCT Impres FROM cursor_4c_TmpCimp ORDER BY Impres INTO CURSOR cursor_4c_SigCdmp READWRITE
            ELSE
                LOCAL loc_cSqlAll2
                loc_cSqlAll2 = "SELECT DISTINCT Impres FROM SigCdmp WHERE nTpImpres = 2 ORDER BY Impres"
                IF SQLEXEC(gnConnHandle, loc_cSqlAll2, "cursor_4c_SigCdmp") < 1
                    loc_nImpressoras = 0
                    loc_lSucesso = loc_nImpressoras
                ENDIF
            ENDIF

            IF USED("cursor_4c_TmpCimp")
                USE IN cursor_4c_TmpCimp
            ENDIF

            loc_nImpressoras = IIF(USED("cursor_4c_SigCdmp"), RECCOUNT("cursor_4c_SigCdmp"), 0)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar impressoras")
            loc_nImpressoras = -1
        ENDTRY

        RETURN loc_nImpressoras
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarProdutoPorCodigo - Busca produto por CPros em SigCdPro
    * Preenche cursor_4c_Produto com dados do produto
    * Retorna .T. se encontrou
    *--------------------------------------------------------------------------
    FUNCTION BuscarProdutoPorCodigo(par_cCodigo)
        LOCAL loc_lEncontrou, loc_oErro
        loc_lEncontrou = .F.

        TRY
            IF USED("cursor_4c_Produto")
                USE IN cursor_4c_Produto
            ENDIF

            LOCAL loc_cSql
            loc_cSql = "SELECT CPros, DPros, Dpro2s, PVens, PrecoDe, PesoMs, CUnis, Ean13, CBars " + ;
                       "FROM SigCdPro " + ;
                       "WHERE CPros = " + EscaparSQL(PADR(par_cCodigo, 14))

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_Produto") > 0
                IF USED("cursor_4c_Produto") AND !EOF("cursor_4c_Produto")
                    loc_lEncontrou = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar produto")
        ENDTRY

        RETURN loc_lEncontrou
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarProdutoPorDescricao - Busca produto por DPros em SigCdPro
    * Preenche cursor_4c_ProdutoBusca
    * Retorna .T. se encontrou exato, .F. se abriu picker
    *--------------------------------------------------------------------------
    FUNCTION BuscarProdutoPorDescricao(par_cDescricao)
        LOCAL loc_lEncontrou, loc_oErro
        loc_lEncontrou = .F.

        TRY
            IF USED("cursor_4c_ProdutoBusca")
                USE IN cursor_4c_ProdutoBusca
            ENDIF

            LOCAL loc_cSql
            loc_cSql = "SELECT TOP 1 CPros, DPros, Dpro2s " + ;
                       "FROM SigCdPro " + ;
                       "WHERE DPros = " + EscaparSQL(par_cDescricao)

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_ProdutoBusca") > 0
                IF USED("cursor_4c_ProdutoBusca") AND !EOF("cursor_4c_ProdutoBusca")
                    loc_lEncontrou = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar produto por descri" + CHR(231) + CHR(227) + "o")
        ENDTRY

        RETURN loc_lEncontrou
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarProdutoPorEan - Busca produto por EAN13/codigo de barras
    * Retorna CPros encontrado ou "" se nao encontrou
    *--------------------------------------------------------------------------
    FUNCTION BuscarProdutoPorEan(par_nEan)
        LOCAL loc_cCodigo, loc_oErro
        loc_cCodigo = ""

        TRY
            LOCAL loc_cSql
            loc_cSql = "SELECT CPros FROM SigCdPro WHERE Ean13 = " + FormatarNumeroSQL(par_nEan, 0)

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_ProdEan") > 0
                IF USED("cursor_4c_ProdEan") AND !EOF("cursor_4c_ProdEan")
                    loc_cCodigo = ALLTRIM(cursor_4c_ProdEan.CPros)
                ENDIF
            ENDIF

            IF USED("cursor_4c_ProdEan")
                USE IN cursor_4c_ProdEan
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar EAN")
        ENDTRY

        RETURN loc_cCodigo
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarProdutoPorCodigoBarras - Busca por CBars (codigo de barras numerico)
    * Retorna CPros encontrado ou "" se nao encontrou
    *--------------------------------------------------------------------------
    FUNCTION BuscarProdutoPorCodigoBarras(par_nCBars)
        LOCAL loc_cCodigo, loc_oErro
        loc_cCodigo = ""

        TRY
            LOCAL loc_cSql
            loc_cSql = "SELECT CPros FROM SigCdPro WHERE CBars = " + FormatarNumeroSQL(INT(VAL(TRANSFORM(par_nCBars))), 0)

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_ProdCBars") > 0
                IF USED("cursor_4c_ProdCBars") AND !EOF("cursor_4c_ProdCBars")
                    loc_cCodigo = ALLTRIM(cursor_4c_ProdCBars.CPros)
                ENDIF
            ENDIF

            IF USED("cursor_4c_ProdCBars")
                USE IN cursor_4c_ProdCBars
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar por c" + CHR(243) + "digo de barras")
        ENDTRY

        RETURN loc_cCodigo
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarUnidadeProduto - Verifica se produto usa etiqueta individual
    * Retorna .T. se produto PODE ser impresso em etiqueta selecionada
    * Retorna .F. se deve usar reimp. individual (Etiqs='S' e EtiqDups<>1)
    *--------------------------------------------------------------------------
    FUNCTION ValidarUnidadeProduto(par_cCpros, par_cCUnis)
        LOCAL loc_lPermitido, loc_oErro
        loc_lPermitido = .T.

        TRY
            IF EMPTY(par_cCUnis)
                loc_lSucesso = .T.
            ENDIF

            LOCAL loc_cSql
            loc_cSql = "SELECT Etiqs, EtiqDups FROM SigCdUni WHERE CUnis = " + EscaparSQL(par_cCUnis)

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_Unidade") > 0
                IF USED("cursor_4c_Unidade") AND !EOF("cursor_4c_Unidade")
                    SELECT cursor_4c_Unidade
                    IF ALLTRIM(cursor_4c_Unidade.Etiqs) = "S" AND NVL(cursor_4c_Unidade.EtiqDups, 0) <> 1
                        loc_lPermitido = .F.
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_Unidade")
                USE IN cursor_4c_Unidade
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar unidade do produto")
        ENDTRY

        RETURN loc_lPermitido
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarListaPrecos - Busca em SigCdLpc por codigo de lista
    * Preenche cursor_4c_ListaPrecos
    * Retorna .T. se encontrou
    *--------------------------------------------------------------------------
    FUNCTION BuscarListaPrecos(par_cLista)
        LOCAL loc_lEncontrou, loc_oErro
        loc_lEncontrou = .F.

        TRY
            IF USED("cursor_4c_ListaPrecos")
                USE IN cursor_4c_ListaPrecos
            ENDIF

            LOCAL loc_cSql
            loc_cSql = "SELECT LPrecos FROM SigCdLpc WHERE LPrecos = " + EscaparSQL(par_cLista)

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_ListaPrecos") > 0
                IF USED("cursor_4c_ListaPrecos") AND !EOF("cursor_4c_ListaPrecos")
                    loc_lEncontrou = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar lista de pre" + CHR(231) + "os")
        ENDTRY

        RETURN loc_lEncontrou
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarItensDaLista - Carrega itens de SigCdLpi para dbImpressao
    * par_cLista: codigo da lista de precos (C30)
    * Preenche cursor cursor_4c_ItensDaLista
    * Retorna contagem de itens carregados
    *--------------------------------------------------------------------------
    FUNCTION CarregarItensDaLista(par_cLista)
        LOCAL loc_nItens, loc_oErro
        loc_nItens = 0

        TRY
            IF USED("cursor_4c_ItensDaLista")
                USE IN cursor_4c_ItensDaLista
            ENDIF

            LOCAL loc_cSql
            loc_cSql = "SELECT LPrecos, CPros, DPros, PVens, Precode, VencIs, VencFs " + ;
                       "FROM SigCdLpi " + ;
                       "WHERE LPrecos = " + EscaparSQL(PADR(par_cLista, 30))

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_ItensDaLista") > 0
                IF USED("cursor_4c_ItensDaLista")
                    loc_nItens = RECCOUNT("cursor_4c_ItensDaLista")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar itens da lista de pre" + CHR(231) + "os")
        ENDTRY

        RETURN loc_nItens
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarPrecoListaPorProduto - Busca preco de lista especifica para produto
    * Retorna .T. se encontrou registro valido
    *--------------------------------------------------------------------------
    FUNCTION BuscarPrecoListaPorProduto(par_cLista, par_cCpros)
        LOCAL loc_lEncontrou, loc_oErro
        loc_lEncontrou = .F.

        TRY
            IF USED("cursor_4c_PrecoLista")
                USE IN cursor_4c_PrecoLista
            ENDIF

            LOCAL loc_cSql
            loc_cSql = "SELECT LPrecos, CPros, DPros, PVens, PrecoDe, VencIs, VencFs " + ;
                       "FROM SigCdLpi " + ;
                       "WHERE LPrecos = " + EscaparSQL(PADR(par_cLista, 30)) + ;
                       " AND CPros = " + EscaparSQL(PADR(par_cCpros, 14))

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_PrecoLista") > 0
                IF USED("cursor_4c_PrecoLista") AND !EOF("cursor_4c_PrecoLista")
                    loc_lEncontrou = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar pre" + CHR(231) + "o da lista")
        ENDTRY

        RETURN loc_lEncontrou
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarItensDaOperacao - Carrega itens de SigMvItn por EmpDopNums
    * par_cEdn: chave concatenada Emps(3)+Dopes(20)+Numes(6)
    * Preenche cursor_4c_ItensOp
    * Retorna contagem de itens ou -1 em erro
    *--------------------------------------------------------------------------
    FUNCTION CarregarItensDaOperacao(par_cEdn)
        LOCAL loc_nItens, loc_oErro
        loc_nItens = -1

        TRY
            IF USED("cursor_4c_ItensOp")
                USE IN cursor_4c_ItensOp
            ENDIF

            LOCAL loc_cSql
            loc_cSql = "SELECT CPros, DPros, Units, Qtds, Citens " + ;
                       "FROM SigMvItn " + ;
                       "WHERE EmpDopNums = " + EscaparSQL(par_cEdn)

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_ItensOp") > 0
                IF USED("cursor_4c_ItensOp")
                    loc_nItens = RECCOUNT("cursor_4c_ItensOp")
                ELSE
                    loc_nItens = 0
                ENDIF
            ELSE
                loc_nItens = 0
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar itens da opera" + CHR(231) + CHR(227) + "o")
            loc_nItens = -1
        ENDTRY

        RETURN loc_nItens
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarDadosProdutoParaImpressao - Le PVens, PrecoDe, PesoMs de SigCdPro
    * Retorna .T. se encontrou
    *--------------------------------------------------------------------------
    FUNCTION BuscarDadosProdutoParaImpressao(par_cCpros)
        LOCAL loc_lEncontrou, loc_oErro
        loc_lEncontrou = .F.

        TRY
            IF USED("cursor_4c_DadosProd")
                USE IN cursor_4c_DadosProd
            ENDIF

            LOCAL loc_cSql
            loc_cSql = "SELECT PVens, PrecoDe, PesoMs " + ;
                       "FROM SigCdPro " + ;
                       "WHERE CPros = " + EscaparSQL(PADR(par_cCpros, 14))

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_DadosProd") > 0
                IF USED("cursor_4c_DadosProd") AND !EOF("cursor_4c_DadosProd")
                    loc_lEncontrou = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar dados do produto para impress" + CHR(227) + "o")
        ENDTRY

        RETURN loc_lEncontrou
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarNumeracaoOperacao - Busca NDopes em SigCdOpe para montar lcBop
    * par_cDopes: codigo da operacao (C20)
    * Retorna NDopes ou "" se nao encontrou
    *--------------------------------------------------------------------------
    FUNCTION BuscarNumeracaoOperacao(par_cDopes)
        LOCAL loc_cNDopes, loc_oErro
        loc_cNDopes = ""

        TRY
            LOCAL loc_cSql
            loc_cSql = "SELECT NDopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(par_cDopes)

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_Ope") > 0
                IF USED("cursor_4c_Ope") AND !EOF("cursor_4c_Ope")
                    loc_cNDopes = ALLTRIM(NVL(cursor_4c_Ope.NDopes, ""))
                ENDIF
            ENDIF

            IF USED("cursor_4c_Ope")
                USE IN cursor_4c_Ope
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar opera" + CHR(231) + CHR(227) + "o")
        ENDTRY

        RETURN loc_cNDopes
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarCodigoBop - Monta codigo BOP para chamada SigOpEtq
    * par_cDopes: operacao, par_nNumes: numero
    * Seta this_cBop e retorna valor
    *--------------------------------------------------------------------------
    FUNCTION MontarCodigoBop(par_cDopes, par_nNumes)
        LOCAL loc_cBop, loc_cNDopes

        loc_cBop = ""

        IF !EMPTY(par_cDopes) AND par_nNumes > 0
            loc_cNDopes = THIS.BuscarNumeracaoOperacao(par_cDopes)
            IF !EMPTY(loc_cNDopes)
                loc_cBop = PADL(loc_cNDopes, 4, "0") + PADL(TRANSFORM(par_nNumes), 6, "0")
            ENDIF
        ENDIF

        THIS.this_cBop = loc_cBop
        RETURN loc_cBop
    ENDFUNC

    *--------------------------------------------------------------------------
    * FecharCursoresTemporarios - Fecha cursores auxiliares usados durante carga
    *--------------------------------------------------------------------------
    PROCEDURE FecharCursoresTemporarios()
        LOCAL loc_aCursores(15), loc_i

        loc_aCursores(1)  = "cursor_4c_Pam"
        loc_aCursores(2)  = "cursor_4c_Pac"
        loc_aCursores(3)  = "cursor_4c_TiposEtq"
        loc_aCursores(4)  = "cursor_4c_SigCdmp"
        loc_aCursores(5)  = "cursor_4c_TmpCimp"
        loc_aCursores(6)  = "cursor_4c_Produto"
        loc_aCursores(7)  = "cursor_4c_ProdutoBusca"
        loc_aCursores(8)  = "cursor_4c_ProdEan"
        loc_aCursores(9)  = "cursor_4c_ProdCBars"
        loc_aCursores(10) = "cursor_4c_Unidade"
        loc_aCursores(11) = "cursor_4c_ListaPrecos"
        loc_aCursores(12) = "cursor_4c_ItensDaLista"
        loc_aCursores(13) = "cursor_4c_PrecoLista"
        loc_aCursores(14) = "cursor_4c_ItensOp"
        loc_aCursores(15) = "cursor_4c_DadosProd"

        FOR loc_i = 1 TO 15
            IF USED(loc_aCursores(loc_i))
                USE IN (loc_aCursores(loc_i))
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia TODAS as 19 colunas do cursor para propriedades
    * par_cAlias: nome do cursor (normalmente "cursor_4c_Etiquetas")
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAlias)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAlias)
            SELECT (par_cAlias)
            THIS.this_cItemCpros      = ALLTRIM(NVL(Cpros,      ""))
            THIS.this_cItemDpros      = ALLTRIM(NVL(DPros,      ""))
            THIS.this_cItemDpro2s     = ALLTRIM(NVL(DPro2s,     ""))
            THIS.this_cItemReffs      = ALLTRIM(NVL(Reffs,      ""))
            THIS.this_nItemQtds       = NVL(Qtds,       0)
            THIS.this_nItemQtdeEtiq   = NVL(QtdeEtiq,   0)
            THIS.this_cItemObs        = ALLTRIM(NVL(Obs,        ""))
            THIS.this_cItemPedido     = ALLTRIM(NVL(Pedido,     ""))
            THIS.this_nItemPvens      = NVL(PVens,      0)
            THIS.this_nItemPrecoDe    = NVL(PrecoDe,    0)
            THIS.this_nItemParcelas   = NVL(Parcelas,   0)
            THIS.this_cItemEmpos      = ALLTRIM(NVL(empos,      ""))
            THIS.this_cItemEmpdopnums = ALLTRIM(NVL(empdopnums, ""))
            THIS.this_nItemCitens     = NVL(citens,     0)
            THIS.this_nItemPesos      = NVL(Pesos,      0)
            THIS.this_cItemCodTams    = ALLTRIM(NVL(CodTams,    ""))
            THIS.this_cItemCpros2     = ALLTRIM(NVL(Cpros2,     ""))
            THIS.this_cItemCpros3     = ALLTRIM(NVL(Cpros3,     ""))
            THIS.this_cItemCpros4     = ALLTRIM(NVL(Cpros4,     ""))
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida propriedades do item antes de Inserir/Atualizar
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(THIS.this_cItemCpros))
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto n" + CHR(227) + "o informado."
            RETURN .F.
        ENDIF

        IF THIS.this_nItemQtds <= 0
            THIS.this_cMensagemErro = "Quantidade inv" + CHR(225) + "lida. Informe valor maior que zero."
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO cursor_4c_Etiquetas com todos os campos do item
    * Equivalente ao Insert Into dbImpressao do legado
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF

            IF !USED("cursor_4c_Etiquetas")
                THIS.this_cMensagemErro = "Cursor de etiquetas n" + CHR(227) + "o est" + CHR(225) + " aberto."
                loc_lSucesso = .F.
            ENDIF

            INSERT INTO cursor_4c_Etiquetas ;
                (Cpros, DPros, Reffs, Qtds, QtdeEtiq, ;
                 Pedido, Obs, PVens, PrecoDe, Parcelas, ;
                 Cpros2, Cpros3, Cpros4, empos, empdopnums, ;
                 citens, Pesos, CodTams, DPro2s) ;
                VALUES ;
                (PADR(THIS.this_cItemCpros, 14), ;
                 LEFT(THIS.this_cItemDpros, 40), ;
                 LEFT(THIS.this_cItemReffs, 40), ;
                 THIS.this_nItemQtds, ;
                 THIS.this_nItemQtdeEtiq, ;
                 LEFT(THIS.this_cItemPedido, 30), ;
                 LEFT(THIS.this_cItemObs, 10), ;
                 THIS.this_nItemPvens, ;
                 THIS.this_nItemPrecoDe, ;
                 INT(THIS.this_nItemParcelas), ;
                 PADR(THIS.this_cItemCpros2, 14), ;
                 PADR(THIS.this_cItemCpros3, 14), ;
                 PADR(THIS.this_cItemCpros4, 14), ;
                 LEFT(THIS.this_cItemEmpos, 3), ;
                 LEFT(THIS.this_cItemEmpdopnums, 29), ;
                 THIS.this_nItemCitens, ;
                 THIS.this_nItemPesos, ;
                 LEFT(THIS.this_cItemCodTams, 4), ;
                 LEFT(THIS.this_cItemDpro2s, 45))

            THIS.RegistrarAuditoria("INCLUIR")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao inserir etiqueta")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - REPLACE na linha corrente de cursor_4c_Etiquetas
    * Equivalente ao Replace ... In dbImpressao do legado
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF

            IF !USED("cursor_4c_Etiquetas")
                THIS.this_cMensagemErro = "Cursor de etiquetas n" + CHR(227) + "o est" + CHR(225) + " aberto."
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_Etiquetas
            REPLACE Cpros      WITH PADR(THIS.this_cItemCpros, 14), ;
                    DPros      WITH LEFT(THIS.this_cItemDpros, 40), ;
                    Reffs      WITH LEFT(THIS.this_cItemReffs, 40), ;
                    Qtds       WITH THIS.this_nItemQtds, ;
                    QtdeEtiq   WITH THIS.this_nItemQtdeEtiq, ;
                    Pedido     WITH LEFT(THIS.this_cItemPedido, 30), ;
                    Obs        WITH LEFT(THIS.this_cItemObs, 10), ;
                    PVens      WITH THIS.this_nItemPvens, ;
                    PrecoDe    WITH THIS.this_nItemPrecoDe, ;
                    Parcelas   WITH INT(THIS.this_nItemParcelas), ;
                    Cpros2     WITH PADR(THIS.this_cItemCpros2, 14), ;
                    Cpros3     WITH PADR(THIS.this_cItemCpros3, 14), ;
                    Cpros4     WITH PADR(THIS.this_cItemCpros4, 14), ;
                    empos      WITH LEFT(THIS.this_cItemEmpos, 3), ;
                    empdopnums WITH LEFT(THIS.this_cItemEmpdopnums, 29), ;
                    citens     WITH THIS.this_nItemCitens, ;
                    Pesos      WITH THIS.this_nItemPesos, ;
                    CodTams    WITH LEFT(THIS.this_cItemCodTams, 4), ;
                    DPro2s     WITH LEFT(THIS.this_cItemDpro2s, 45) ;
                    IN cursor_4c_Etiquetas

            THIS.RegistrarAuditoria("ALTERAR")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao atualizar etiqueta")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararImpressao - Orquestra a impressao de etiquetas
    * Chamado pelo Form apos confirmacao do usuario (Imprime.Click)
    * Reordena cursor, monta lcBop e chama SigOpEtq (funcao legado)
    * par_nImpPreco: opcao de preco (1=Sim,2=Nao,3=Ideal,4=Atual,5=PrecoDe/Por,6=Parcelamento)
    * par_lImpSepar: .T. = imprimir separadora
    * par_lImpPeso : .T. = imprimir peso
    * par_lCompo   : .T. = imprimir composicao
    * par_nTpEti   : tipo de etiqueta (INT do .Tag do botao Opt_Tipo selecionado)
    * par_nTpImp   : tipo de impressora (1=Allegro, 2=ZPL, 3=EPL)
    * par_nAjVerts : ajuste vertical
    * par_nAjHorzs : ajuste horizontal
    * par_nAjDenss : densidade
    * par_nAjVelos : velocidade
    * par_cNomeImp : nome da impressora (de crImpreV.impres)
    * par_nOrdem   : ordenacao (1=Produto, 2=Nenhuma/por insercao)
    * par_cLp1     : lista de precos 1 (get_lpreco)
    * par_cLp2     : lista de precos 2 (getLPreco2)
    * Retorna .T. se impressao concluida
    *--------------------------------------------------------------------------
    FUNCTION PrepararImpressao(par_nImpPreco, par_lImpSepar, par_lImpPeso, par_lCompo, ;
                                par_nTpEti, par_nTpImp, par_nAjVerts, par_nAjHorzs, ;
                                par_nAjDenss, par_nAjVelos, par_cNomeImp, ;
                                par_nOrdem, par_cLp1, par_cLp2)
        LOCAL loc_lSucesso, loc_oErro, loc_cBop, loc_nItens
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Etiquetas")
                THIS.this_cMensagemErro = "Sem itens para imprimir."
                loc_lSucesso = .F.
            ENDIF

            *-- Remove itens com quantidade zero ou negativa
            SELECT cursor_4c_Etiquetas
            DELETE FROM cursor_4c_Etiquetas WHERE Qtds <= 0

            *-- Conta itens validos
            SELECT cursor_4c_Etiquetas
            loc_nItens = 0
            COUNT TO loc_nItens FOR !DELETED()

            IF loc_nItens = 0
                THIS.this_cMensagemErro = "Nenhum item v" + CHR(225) + "lido para imprimir."
                loc_lSucesso = .F.
            ENDIF

            *-- Reordena cursor conforme opcao (1=por Produto, 2=por insercao)
            IF par_nOrdem = 1
                SELECT cursor_4c_Etiquetas
                SET ORDER TO Cpros
            ELSE
                SELECT cursor_4c_Etiquetas
                SET ORDER TO Registros
            ENDIF

            *-- Copia para cursor ordenado preservando a ordem escolhida
            SELECT * FROM cursor_4c_Etiquetas WHERE !DELETED() ;
                INTO CURSOR cursor_4c_EtqOrdenado READWRITE

            SET ORDER TO

            SELECT cursor_4c_Etiquetas
            ZAP

            SELECT cursor_4c_EtqOrdenado
            SCAN
                SCATTER MEMVAR MEMO
                SELECT cursor_4c_Etiquetas
                INSERT INTO cursor_4c_Etiquetas FROM MEMVAR
            ENDSCAN

            IF USED("cursor_4c_EtqOrdenado")
                USE IN cursor_4c_EtqOrdenado
            ENDIF

            *-- Monta codigo BOP se operacao e numero informados
            loc_cBop = ""
            IF !EMPTY(THIS.this_cDopes) AND THIS.this_nNumes > 0
                loc_cBop = THIS.MontarCodigoBop(THIS.this_cDopes, THIS.this_nNumes)
            ENDIF

            *-- Posiciona no cursor_4c_Etiquetas (SigOpEtq usa area de trabalho corrente)
            SELECT cursor_4c_Etiquetas
            GO TOP

            *-- Chama funcao de impressao do sistema legado (dbImpressao=cursor_4c_Etiquetas)
            =SigOpEtq(gnConnHandle, par_nImpPreco, par_lImpSepar, par_nTpEti, par_nTpImp, ;
                      par_nAjVerts, par_nAjHorzs, par_nAjDenss, .F., .F., .F., ;
                      par_cNomeImp, .F., .F., par_nAjVelos, par_lImpPeso, ;
                      loc_cBop, par_cLp1, par_cLp2, .F., .F., par_lCompo)

            THIS.RegistrarAuditoria("IMPRIMIR")

            *-- Limpa grid apos impressao bem-sucedida
            SELECT cursor_4c_Etiquetas
            ZAP
            APPEND BLANK IN cursor_4c_Etiquetas
            GO TOP IN cursor_4c_Etiquetas

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao imprimir etiquetas")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

