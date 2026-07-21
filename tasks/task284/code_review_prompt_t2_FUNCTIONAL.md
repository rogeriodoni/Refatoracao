# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (12)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Referência Fornecedor, Parcelas, Preço, Preço De. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Referência Fornecedor, Parcelas, Preço, Preço De. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Qtde' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Referência Fornecedor, Parcelas, Preço, Preço De. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Opt_Tipo' (parent: SIGPRETQ): Top original=431 vs migrado 'obj_4c_Opt_Tipo' Top=10 (diff=421px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Impressora' (parent: SIGPRETQ): Top original=431 vs migrado 'obj_4c_Opt_Impressora' Top=52 (diff=379px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Impressora' (parent: SIGPRETQ): Left original=260 vs migrado 'obj_4c_Opt_Impressora' Left=9 (diff=251px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptOrdem' (parent: SIGPRETQ): Top original=589 vs migrado 'obj_4c_OptOrdem' Top=4 (diff=585px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptOrdem' (parent: SIGPRETQ): Left original=601 vs migrado 'obj_4c_OptOrdem' Left=5 (diff=596px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optCompos' (parent: SIGPRETQ): Top original=562 vs migrado 'obj_4c_OptCompos' Top=5 (diff=557px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optCompos' (parent: SIGPRETQ): Left original=601 vs migrado 'obj_4c_OptCompos' Left=5 (diff=596px, tolerancia=30px)
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEtq.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2585 linhas total):

*-- Linhas 25 a 145:
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
65: 			THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
66: 			THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
67: 			THIS.TornarControlesVisiveis(THIS)
68: 
69: 			IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
70: 				THIS.this_oBusinessObject.CarregarConfiguracoes()
71: 				THIS.PopularTiposEtiqueta()
72: 				THIS.AplicarConfiguracoes()
73: 			ENDIF
74: 
75: 			loc_lSucesso = .T.
76: 
77: 		CATCH TO loc_oErro
78: 			MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
79: 			        " PROC=" + loc_oErro.Procedure, "Erro ao inicializar")
80: 			loc_lSucesso = .F.
81: 		ENDTRY
82: 
83: 		RETURN loc_lSucesso
84: 	ENDPROC
85: 
86: 	*====================================================================
87: 	* ConfigurarPageFrame - Orquestrador de layout do form OPERACIONAL
88: 	* Form SIGPRETQ nao tem PageFrame no SCX legado (form flat).
89: 	* Este metodo prepara a superficie do form (Picture de fundo) e
90: 	* delega para as sub-configuracoes: cabecalho e botoes de acao.
91: 	* Containers de trabalho (grid, filtros, impressora) serao criados
92: 	* nas proximas fases (4-8).
93: 	*====================================================================
94: 	PROTECTED PROCEDURE ConfigurarPageFrame()
95: 		THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
96: 		THIS.ConfigurarCabecalho()
97: 		THIS.ConfigurarBotoesAcao()
98: 		THIS.ConfigurarPaginaLista()
99: 		THIS.ConfigurarPaginaDados()
100: 	ENDPROC
101: 
102: 	*====================================================================
103: 	* ConfigurarCabecalho - Cabecalho cinza superior com titulo
104: 	*====================================================================
105: 	PROTECTED PROCEDURE ConfigurarCabecalho()
106: 		THIS.AddObject("cnt_4c_Cabecalho", "Container")
107: 		WITH THIS.cnt_4c_Cabecalho
108: 			.Top = 0
109: 			.Left = 0
110: 			.Width = THIS.Width
111: 			.Height = 80
112: 			.BackStyle = 1
113: 			.BackColor = RGB(100, 100, 100)
114: 			.BorderWidth = 0
115: 			.Visible = .T.
116: 
117: 			.AddObject("lbl_4c_Sombra", "Label")
118: 			WITH .lbl_4c_Sombra
119: 				.AutoSize = .F.
120: 				.FontBold = .T.
121: 				.FontName = "Tahoma"
122: 				.FontSize = 18
123: 				.WordWrap = .T.
124: 				.Alignment = 0
125: 				.BackStyle = 0
126: 				.Caption = "Impress" + CHR(227) + "o de Etiquetas Selecionadas"
127: 				.Height = 40
128: 				.Left = 10
129: 				.Top = 18
130: 				.Width = THIS.Width
131: 				.ForeColor = RGB(0, 0, 0)
132: 			ENDWITH
133: 
134: 			.AddObject("lbl_4c_Titulo", "Label")
135: 			WITH .lbl_4c_Titulo
136: 				.AutoSize = .F.
137: 				.FontBold = .T.
138: 				.FontName = "Tahoma"
139: 				.FontSize = 18
140: 				.WordWrap = .T.
141: 				.Alignment = 0
142: 				.BackStyle = 0
143: 				.Caption = "Impress" + CHR(227) + "o de Etiquetas Selecionadas"
144: 				.Height = 46
145: 				.Left = 10

*-- Linhas 153 a 196:
153: 	*====================================================================
154: 	* ConfigurarBotoesAcao - CommandGroup Imprimir + Encerrar
155: 	*====================================================================
156: 	PROTECTED PROCEDURE ConfigurarBotoesAcao()
157: 		THIS.AddObject("cmg_4c_BtnReport", "CommandGroup")
158: 		WITH THIS.cmg_4c_BtnReport
159: 			.Top = -2
160: 			.Left = THIS.Width - 162
161: 			.Width = 162
162: 			.Height = 85
163: 			.BackStyle = 0
164: 			.BorderStyle = 0
165: 			.SpecialEffect = 1
166: 			.ButtonCount = 2
167: 			.Themes = .F.
168: 			.ZOrder(0)
169: 
170: 			WITH .Buttons(1)
171: 				.Top = 5
172: 				.Left = 5
173: 				.Height = 75
174: 				.Width = 75
175: 				.FontBold = .T.
176: 				.FontItalic = .T.
177: 				.WordWrap = .T.
178: 				.Picture = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
179: 				.Caption = "\<Imprimir"
180: 				.ForeColor = RGB(90, 90, 90)
181: 				.BackColor = RGB(255, 255, 255)
182: 				.Themes = .F.
183: 			ENDWITH
184: 
185: 			WITH .Buttons(2)
186: 				.Top = 5
187: 				.Left = 81
188: 				.Height = 75
189: 				.Width = 75
190: 				.FontBold = .T.
191: 				.FontItalic = .T.
192: 				.FontName = "Tahoma"
193: 				.FontSize = 8
194: 				.WordWrap = .T.
195: 				.Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
196: 				.Cancel = .T.

*-- Linhas 203 a 288:
203: 	ENDPROC
204: 
205: 	*====================================================================
206: 	* TornarControlesVisiveis - Torna controles visiveis recursivamente
207: 	* obj_4c_Opt_Impressora: skip Visible mas recursa filhos (Pattern #109)
208: 	*====================================================================
209: 	PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
210: 		LOCAL loc_i, loc_oControl
211: 		IF VARTYPE(par_oContainer) != "O"
212: 			RETURN
213: 		ENDIF
214: 		FOR loc_i = 1 TO par_oContainer.ControlCount
215: 			loc_oControl = par_oContainer.Controls(loc_i)
216: 			IF VARTYPE(loc_oControl) != "O"
217: 				LOOP
218: 			ENDIF
219: 			IF INLIST(UPPER(loc_oControl.Name), "OBJ_4C_OPT_IMPRESSORA", "CNT_4C_CABECALHO")
220: 				THIS.TornarControlesVisiveis(loc_oControl)
221: 				LOOP
222: 			ENDIF
223: 			IF PEMSTATUS(loc_oControl, "Visible", 5)
224: 				loc_oControl.Visible = .T.
225: 			ENDIF
226: 			IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
227: 				THIS.TornarControlesVisiveis(loc_oControl)
228: 			ENDIF
229: 		ENDFOR
230: 	ENDPROC
231: 
232: 	*====================================================================
233: 	* Destroy - Libera BO e cursor local
234: 	*====================================================================
235: 	PROCEDURE Destroy()
236: 		IF VARTYPE(THIS.this_oBusinessObject) = "O"
237: 			THIS.this_oBusinessObject = .NULL.
238: 		ENDIF
239: 		IF USED("cursor_4c_Etiquetas")
240: 			USE IN cursor_4c_Etiquetas
241: 		ENDIF
242: 		DODEFAULT()
243: 	ENDPROC
244: 
245: 	*====================================================================
246: 	* ConfigurarPaginaLista - Filtros, grid e botoes de acao
247: 	*====================================================================
248: 	PROTECTED PROCEDURE ConfigurarPaginaLista()
249: 		LOCAL loc_nTop
250: 
251: 		*-- Linha 1: Empresa / Operacao (top=88)
252: 		loc_nTop = 88
253: 
254: 		THIS.AddObject("lbl_4c_LEmps", "Label")
255: 		WITH THIS.lbl_4c_LEmps
256: 			.AutoSize  = .F.
257: 			.Caption   = "Empresa:"
258: 			.Top       = loc_nTop + 3
259: 			.Left      = 12
260: 			.Width     = 58
261: 			.Height    = 18
262: 			.FontName  = "Tahoma"
263: 			.FontSize  = 8
264: 			.BackStyle = 0
265: 			.ForeColor = RGB(255, 255, 255)
266: 		ENDWITH
267: 
268: 		THIS.AddObject("txt_4c_Emps", "TextBox")
269: 		WITH THIS.txt_4c_Emps
270: 			.Top       = loc_nTop
271: 			.Left      = 73
272: 			.Width     = 36
273: 			.Height    = 22
274: 			.FontName  = "Tahoma"
275: 			.FontSize  = 8
276: 			.MaxLength = 3
277: 		ENDWITH
278: 
279: 		THIS.AddObject("lbl_4c_DEmps", "Label")
280: 		WITH THIS.lbl_4c_DEmps
281: 			.AutoSize  = .F.
282: 			.Caption   = ""
283: 			.Top       = loc_nTop + 3
284: 			.Left      = 112
285: 			.Width     = 200
286: 			.Height    = 18
287: 			.FontName  = "Tahoma"
288: 			.FontSize  = 8

*-- Linhas 642 a 1207:
642: 			APPEND BLANK
643: 		ENDIF
644: 
645: 		*-- BINDEVENTs
646: 		BINDEVENT(THIS.txt_4c_Emps,                  "KeyPress", THIS, "TxtEmpsKeyPress")
647: 		BINDEVENT(THIS.txt_4c_Dopes,                 "KeyPress", THIS, "TxtDopesKeyPress")
648: 		BINDEVENT(THIS.txt_4c_Cpros,                 "KeyPress", THIS, "TxtCprosKeyPress")
649: 		BINDEVENT(THIS.txt_4c_Dpros,                 "KeyPress", THIS, "TxtDprosKeyPress")
650: 		BINDEVENT(THIS.txt_4c_Qtds,                  "KeyPress", THIS, "TxtQtdsKeyPress")
651: 		BINDEVENT(THIS.txt_4c_Lpreco,                "KeyPress", THIS, "TxtLprecoKeyPress")
652: 		BINDEVENT(THIS.txt_4c_LPreco2,               "KeyPress", THIS, "TxtLPreco2KeyPress")
653: 		BINDEVENT(THIS.cmd_4c_BtnCarregar,           "Click",    THIS, "CmdBtnCarregarClick")
654: 		BINDEVENT(THIS.cmd_4c_BtnExcluir,            "Click",    THIS, "CmdBtnExcluirClick")
655: 		BINDEVENT(THIS.grd_4c_Etiquetas,             "KeyPress", THIS, "GrdEtiquetasKeyPress")
656: 		BINDEVENT(THIS.cmg_4c_BtnReport.Buttons(1), "Click",    THIS, "BtnImprimirClick")
657: 		BINDEVENT(THIS.cmg_4c_BtnReport.Buttons(2), "Click",    THIS, "BtnEncerrarClick")
658: 		BINDEVENT(THIS.txt_4c_Numes,                 "KeyPress", THIS, "TxtNumesKeyPress")
659: 		BINDEVENT(THIS.chk_4c_Lista,                 "Click",    THIS, "ChkListaClick")
660: 		BINDEVENT(THIS.chk_4c_Precio,                "Click",    THIS, "ChkPrecioClick")
661: 	ENDPROC
662: 
663: 	*====================================================================
664: 	* AlternarPagina - Stub (form flat, sem PageFrame)
665: 	*====================================================================
666: 	PROTECTED PROCEDURE AlternarPagina(par_nPagina)
667: 		RETURN
668: 	ENDPROC
669: 
670: 	*====================================================================
671: 	* GrdEtiquetasKeyPress - Enter na coluna 4 (Reffs) abre busca por ref
672: 	*====================================================================
673: 	PROCEDURE GrdEtiquetasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
674: 		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
675: 			RETURN
676: 		ENDIF
677: 		IF THIS.grd_4c_Etiquetas.ActiveColumn = 4
678: 			THIS.AbrirBuscaProdutoRef()
679: 		ENDIF
680: 	ENDPROC
681: 
682: 	*====================================================================
683: 	* TxtEmpsKeyPress - Valida ou abre busca de empresa
684: 	*====================================================================
685: 	PROCEDURE TxtEmpsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
686: 		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
687: 			RETURN
688: 		ENDIF
689: 		LOCAL loc_cEmps, loc_nRet, loc_oBusca
690: 		loc_cEmps = ALLTRIM(NVL(THIS.txt_4c_Emps.Value, ""))
691: 		IF !EMPTY(loc_cEmps)
692: 			loc_nRet = SQLEXEC(gnConnHandle, ;
693: 				"SELECT TOP 1 Emps, DEmps FROM SigCdEmp WHERE RTRIM(Emps)=" + EscaparSQL(loc_cEmps), ;
694: 				"cursor_4c_BuscaEmp")
695: 			IF loc_nRet > 0 AND USED("cursor_4c_BuscaEmp") AND RECCOUNT("cursor_4c_BuscaEmp") > 0
696: 				SELECT cursor_4c_BuscaEmp
697: 				THIS.lbl_4c_DEmps.Caption = ALLTRIM(cursor_4c_BuscaEmp.DEmps)
698: 				USE IN cursor_4c_BuscaEmp
699: 				THIS.txt_4c_Dopes.SetFocus()
700: 				RETURN
701: 			ENDIF
702: 			IF USED("cursor_4c_BuscaEmp")
703: 				USE IN cursor_4c_BuscaEmp
704: 			ENDIF
705: 		ENDIF
706: 		loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
707: 			"SigCdEmp", "cursor_4c_BuscaEmp", "Emps", ;
708: 			loc_cEmps, "Empresa", .T., .T., "")
709: 		IF VARTYPE(loc_oBusca) = "O"
710: 			IF !loc_oBusca.this_lAchouRegistro
711: 				loc_oBusca.mAddColuna("Emps",  "", "C" + CHR(243) + "d.")
712: 				loc_oBusca.mAddColuna("DEmps", "", "Empresa")
713: 				loc_oBusca.Show()
714: 			ENDIF
715: 			IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
716: 				SELECT cursor_4c_BuscaEmp
717: 				THIS.txt_4c_Emps.Value     = ALLTRIM(cursor_4c_BuscaEmp.Emps)
718: 				THIS.lbl_4c_DEmps.Caption  = ALLTRIM(cursor_4c_BuscaEmp.DEmps)
719: 				USE IN cursor_4c_BuscaEmp
720: 				THIS.txt_4c_Dopes.SetFocus()
721: 			ENDIF
722: 		ENDIF
723: 	ENDPROC
724: 
725: 	*====================================================================
726: 	* TxtDopesKeyPress - Valida ou abre busca de operacao (SigCdOpe)
727: 	*====================================================================
728: 	PROCEDURE TxtDopesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
729: 		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
730: 			RETURN
731: 		ENDIF
732: 		LOCAL loc_cDopes, loc_nRet, loc_oBusca
733: 		loc_cDopes = ALLTRIM(NVL(THIS.txt_4c_Dopes.Value, ""))
734: 		IF !EMPTY(loc_cDopes)
735: 			loc_nRet = SQLEXEC(gnConnHandle, ;
736: 				"SELECT TOP 1 Dopes FROM SigCdOpe WHERE RTRIM(Dopes)=" + EscaparSQL(loc_cDopes), ;
737: 				"cursor_4c_BuscaOpe")
738: 			IF loc_nRet > 0 AND USED("cursor_4c_BuscaOpe") AND RECCOUNT("cursor_4c_BuscaOpe") > 0
739: 				USE IN cursor_4c_BuscaOpe
740: 				THIS.txt_4c_Cpros.SetFocus()
741: 				RETURN
742: 			ENDIF
743: 			IF USED("cursor_4c_BuscaOpe")
744: 				USE IN cursor_4c_BuscaOpe
745: 			ENDIF
746: 		ENDIF
747: 		loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
748: 			"SigCdOpe", "cursor_4c_BuscaOpe", "Dopes", ;
749: 			loc_cDopes, "Opera" + CHR(231) + CHR(227) + "o", .T., .T., "")
750: 		IF VARTYPE(loc_oBusca) = "O"
751: 			IF !loc_oBusca.this_lAchouRegistro
752: 				loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
753: 				loc_oBusca.Show()
754: 			ENDIF
755: 			IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
756: 				SELECT cursor_4c_BuscaOpe
757: 				THIS.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
758: 				USE IN cursor_4c_BuscaOpe
759: 				THIS.txt_4c_Cpros.SetFocus()
760: 			ENDIF
761: 		ENDIF
762: 	ENDPROC
763: 
764: 	*====================================================================
765: 	* TxtCprosKeyPress - Busca produto por codigo, EAN13 ou codigo de barras
766: 	*====================================================================
767: 	PROCEDURE TxtCprosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
768: 		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
769: 			RETURN
770: 		ENDIF
771: 		LOCAL loc_cCodigo, loc_nRet
772: 		loc_cCodigo = ALLTRIM(NVL(THIS.txt_4c_Cpros.Value, ""))
773: 		IF !EMPTY(loc_cCodigo)
774: 			loc_nRet = SQLEXEC(gnConnHandle, ;
775: 				"SELECT TOP 1 Cpros, DPros FROM SigCdPro " + ;
776: 				"WHERE RTRIM(Cpros)=" + EscaparSQL(loc_cCodigo) + ;
777: 				" OR RTRIM(Ean13)="  + EscaparSQL(loc_cCodigo) + ;
778: 				" OR RTRIM(CBars)="  + EscaparSQL(loc_cCodigo), ;
779: 				"cursor_4c_BuscaProd")
780: 			IF loc_nRet > 0 AND USED("cursor_4c_BuscaProd") AND RECCOUNT("cursor_4c_BuscaProd") > 0
781: 				SELECT cursor_4c_BuscaProd
782: 				THIS.txt_4c_Cpros.Value = ALLTRIM(cursor_4c_BuscaProd.Cpros)
783: 				THIS.txt_4c_Dpros.Value = ALLTRIM(cursor_4c_BuscaProd.DPros)
784: 				USE IN cursor_4c_BuscaProd
785: 				THIS.txt_4c_Qtds.SetFocus()
786: 				RETURN
787: 			ENDIF
788: 			IF USED("cursor_4c_BuscaProd")
789: 				USE IN cursor_4c_BuscaProd
790: 			ENDIF
791: 		ENDIF
792: 		THIS.AbrirBuscaProdutoCodigo()
793: 	ENDPROC
794: 
795: 	*====================================================================
796: 	* TxtDprosKeyPress - Busca produto por descricao
797: 	*====================================================================
798: 	PROCEDURE TxtDprosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
799: 		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
800: 			RETURN
801: 		ENDIF
802: 		LOCAL loc_cDesc, loc_nRet
803: 		loc_cDesc = ALLTRIM(NVL(THIS.txt_4c_Dpros.Value, ""))
804: 		IF !EMPTY(loc_cDesc)
805: 			loc_nRet = SQLEXEC(gnConnHandle, ;
806: 				"SELECT TOP 1 Cpros, DPros FROM SigCdPro " + ;
807: 				"WHERE RTRIM(DPros)=" + EscaparSQL(loc_cDesc), ;
808: 				"cursor_4c_BuscaProd")
809: 			IF loc_nRet > 0 AND USED("cursor_4c_BuscaProd") AND RECCOUNT("cursor_4c_BuscaProd") > 0
810: 				SELECT cursor_4c_BuscaProd
811: 				THIS.txt_4c_Cpros.Value = ALLTRIM(cursor_4c_BuscaProd.Cpros)
812: 				THIS.txt_4c_Dpros.Value = ALLTRIM(cursor_4c_BuscaProd.DPros)
813: 				USE IN cursor_4c_BuscaProd
814: 				THIS.txt_4c_Qtds.SetFocus()
815: 				RETURN
816: 			ENDIF
817: 			IF USED("cursor_4c_BuscaProd")
818: 				USE IN cursor_4c_BuscaProd
819: 			ENDIF
820: 		ENDIF
821: 		THIS.AbrirBuscaProdutoDescricao()
822: 	ENDPROC
823: 
824: 	*====================================================================
825: 	* TxtQtdsKeyPress - Valida qtde e adiciona produto ao grid
826: 	*====================================================================
827: 	PROCEDURE TxtQtdsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
828: 		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
829: 			RETURN
830: 		ENDIF
831: 		LOCAL loc_cCpros, loc_nQtds
832: 		loc_cCpros = ALLTRIM(NVL(THIS.txt_4c_Cpros.Value, ""))
833: 		loc_nQtds  = NVL(THIS.txt_4c_Qtds.Value, 0)
834: 		IF EMPTY(loc_cCpros)
835: 			MsgAviso("Informe o c" + CHR(243) + "digo do produto.", "Aten" + CHR(231) + CHR(227) + "o")
836: 			THIS.txt_4c_Cpros.SetFocus()
837: 			RETURN
838: 		ENDIF
839: 		IF loc_nQtds <= 0
840: 			MsgAviso("Quantidade deve ser maior que zero.", "Aten" + CHR(231) + CHR(227) + "o")
841: 			THIS.txt_4c_Qtds.SetFocus()
842: 			RETURN
843: 		ENDIF
844: 		SELECT cursor_4c_Etiquetas
845: 		GO BOTTOM
846: 		IF !EMPTY(cursor_4c_Etiquetas.Cpros)
847: 			APPEND BLANK
848: 		ENDIF
849: 		REPLACE Cpros WITH loc_cCpros, ;
850: 		        DPros WITH ALLTRIM(NVL(THIS.txt_4c_Dpros.Value, "")), ;
851: 		        Qtds  WITH loc_nQtds
852: 		THIS.CarregarPrecoProduto(loc_cCpros)
853: 		IF THIS.chk_4c_Lista.Value = 1 AND !EMPTY(ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value, "")))
854: 			THIS.AtualizarPrecoPorLista(loc_cCpros)
855: 		ENDIF
856: 		APPEND BLANK
857: 		THIS.txt_4c_Cpros.Value = ""
858: 		THIS.txt_4c_Dpros.Value = ""
859: 		THIS.txt_4c_Qtds.Value  = 0
860: 		THIS.grd_4c_Etiquetas.Refresh()
861: 		THIS.txt_4c_Cpros.SetFocus()
862: 	ENDPROC
863: 
864: 	*====================================================================
865: 	* TxtLprecoKeyPress - Valida ou abre busca de lista de precos
866: 	*====================================================================
867: 	PROCEDURE TxtLprecoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
868: 		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
869: 			RETURN
870: 		ENDIF
871: 		LOCAL loc_cLpreco, loc_nRet, loc_oBusca
872: 		loc_cLpreco = ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value, ""))
873: 		IF !EMPTY(loc_cLpreco)
874: 			loc_nRet = SQLEXEC(gnConnHandle, ;
875: 				"SELECT TOP 1 LPrecos, DLPrecos FROM SigCdLpc " + ;
876: 				"WHERE RTRIM(LPrecos)=" + EscaparSQL(loc_cLpreco), ;
877: 				"cursor_4c_BuscaLpc")
878: 			IF loc_nRet > 0 AND USED("cursor_4c_BuscaLpc") AND RECCOUNT("cursor_4c_BuscaLpc") > 0
879: 				SELECT cursor_4c_BuscaLpc
880: 				THIS.txt_4c_Lpreco.Value  = ALLTRIM(cursor_4c_BuscaLpc.LPrecos)
881: 				THIS.txt_4c_LPreco2.Value = ALLTRIM(cursor_4c_BuscaLpc.DLPrecos)
882: 				USE IN cursor_4c_BuscaLpc
883: 				THIS.chk_4c_Lista.SetFocus()
884: 				RETURN
885: 			ENDIF
886: 			IF USED("cursor_4c_BuscaLpc")
887: 				USE IN cursor_4c_BuscaLpc
888: 			ENDIF
889: 		ENDIF
890: 		loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
891: 			"SigCdLpc", "cursor_4c_BuscaLpc", "LPrecos", ;
892: 			loc_cLpreco, "Lista de Pre" + CHR(231) + "os", .T., .T., "")
893: 		IF VARTYPE(loc_oBusca) = "O"
894: 			IF !loc_oBusca.this_lAchouRegistro
895: 				loc_oBusca.mAddColuna("LPrecos",  "", "C" + CHR(243) + "digo")
896: 				loc_oBusca.mAddColuna("DLPrecos", "", "Descri" + CHR(231) + CHR(227) + "o")
897: 				loc_oBusca.Show()
898: 			ENDIF
899: 			IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLpc")
900: 				SELECT cursor_4c_BuscaLpc
901: 				THIS.txt_4c_Lpreco.Value  = ALLTRIM(cursor_4c_BuscaLpc.LPrecos)
902: 				THIS.txt_4c_LPreco2.Value = ALLTRIM(cursor_4c_BuscaLpc.DLPrecos)
903: 				USE IN cursor_4c_BuscaLpc
904: 				THIS.chk_4c_Lista.SetFocus()
905: 			ENDIF
906: 		ENDIF
907: 	ENDPROC
908: 
909: 	*====================================================================
910: 	* TxtLPreco2KeyPress - ReadOnly, redireciona foco para txt_4c_Lpreco
911: 	*====================================================================
912: 	PROCEDURE TxtLPreco2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
913: 		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
914: 			RETURN
915: 		ENDIF
916: 		THIS.txt_4c_Lpreco.SetFocus()
917: 	ENDPROC
918: 
919: 	*====================================================================
920: 	* AbrirBuscaProdutoCodigo - Picker de produto por codigo
921: 	*====================================================================
922: 	PROTECTED PROCEDURE AbrirBuscaProdutoCodigo()
923: 		LOCAL loc_oBusca
924: 		loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
925: 			"SigCdPro", "cursor_4c_BuscaProd", "Cpros", ;
926: 			ALLTRIM(NVL(THIS.txt_4c_Cpros.Value, "")), ;
927: 			"Busca de Produto", .T., .T., "")
928: 		IF VARTYPE(loc_oBusca) = "O"
929: 			IF !loc_oBusca.this_lAchouRegistro
930: 				loc_oBusca.mAddColuna("Cpros", "", "C" + CHR(243) + "digo")
931: 				loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
932: 				loc_oBusca.Show()
933: 			ENDIF
934: 			IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
935: 				SELECT cursor_4c_BuscaProd
936: 				THIS.txt_4c_Cpros.Value = ALLTRIM(cursor_4c_BuscaProd.Cpros)
937: 				THIS.txt_4c_Dpros.Value = ALLTRIM(cursor_4c_BuscaProd.DPros)
938: 				USE IN cursor_4c_BuscaProd
939: 				THIS.txt_4c_Qtds.SetFocus()
940: 			ENDIF
941: 		ENDIF
942: 	ENDPROC
943: 
944: 	*====================================================================
945: 	* AbrirBuscaProdutoDescricao - Picker de produto por descricao
946: 	*====================================================================
947: 	PROTECTED PROCEDURE AbrirBuscaProdutoDescricao()
948: 		LOCAL loc_oBusca
949: 		loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
950: 			"SigCdPro", "cursor_4c_BuscaProd", "DPros", ;
951: 			ALLTRIM(NVL(THIS.txt_4c_Dpros.Value, "")), ;
952: 			"Busca de Produto", .T., .T., "")
953: 		IF VARTYPE(loc_oBusca) = "O"
954: 			IF !loc_oBusca.this_lAchouRegistro
955: 				loc_oBusca.mAddColuna("Cpros", "", "C" + CHR(243) + "digo")
956: 				loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
957: 				loc_oBusca.Show()
958: 			ENDIF
959: 			IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
960: 				SELECT cursor_4c_BuscaProd
961: 				THIS.txt_4c_Cpros.Value = ALLTRIM(cursor_4c_BuscaProd.Cpros)
962: 				THIS.txt_4c_Dpros.Value = ALLTRIM(cursor_4c_BuscaProd.DPros)
963: 				USE IN cursor_4c_BuscaProd
964: 				THIS.txt_4c_Qtds.SetFocus()
965: 			ENDIF
966: 		ENDIF
967: 	ENDPROC
968: 
969: 	*====================================================================
970: 	* AbrirBuscaProdutoRef - Picker de produto por referencia (DPro2s)
971: 	*====================================================================
972: 	PROTECTED PROCEDURE AbrirBuscaProdutoRef()
973: 		LOCAL loc_cRef, loc_oBusca
974: 		loc_cRef = ""
975: 		IF USED("cursor_4c_Etiquetas") AND !EOF("cursor_4c_Etiquetas")
976: 			loc_cRef = ALLTRIM(NVL(cursor_4c_Etiquetas.Reffs, ""))
977: 		ENDIF
978: 		loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
979: 			"SigCdPro", "cursor_4c_BuscaProd", "DPro2s", ;
980: 			loc_cRef, "Busca por Refer" + CHR(234) + "ncia", .T., .T., "")
981: 		IF VARTYPE(loc_oBusca) = "O"
982: 			IF !loc_oBusca.this_lAchouRegistro
983: 				loc_oBusca.mAddColuna("Cpros",  "", "C" + CHR(243) + "digo")
984: 				loc_oBusca.mAddColuna("DPros",  "", "Descri" + CHR(231) + CHR(227) + "o")
985: 				loc_oBusca.mAddColuna("DPro2s", "", "Refer" + CHR(234) + "ncia")
986: 				loc_oBusca.Show()
987: 			ENDIF
988: 			IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
989: 				SELECT cursor_4c_BuscaProd
990: 				LOCAL loc_cCpros, loc_cDPros, loc_cDPro2s
991: 				loc_cCpros  = ALLTRIM(cursor_4c_BuscaProd.Cpros)
992: 				loc_cDPros  = ALLTRIM(cursor_4c_BuscaProd.DPros)
993: 				loc_cDPro2s = ALLTRIM(cursor_4c_BuscaProd.DPro2s)
994: 				USE IN cursor_4c_BuscaProd
995: 				SELECT cursor_4c_Etiquetas
996: 				REPLACE Cpros WITH loc_cCpros, ;
997: 				        DPros WITH loc_cDPros, ;
998: 				        Reffs WITH loc_cDPro2s
999: 				THIS.CarregarPrecoProduto(loc_cCpros)
1000: 				THIS.grd_4c_Etiquetas.Refresh()
1001: 			ENDIF
1002: 		ENDIF
1003: 	ENDPROC
1004: 
1005: 	*====================================================================
1006: 	* CarregarPrecoProduto - Carrega PVens/PrecoDe/Pesos/DPro2s na linha
1007: 	*====================================================================
1008: 	PROTECTED PROCEDURE CarregarPrecoProduto(par_cCpros)
1009: 		LOCAL loc_nRet, loc_nPVens, loc_nPrecoDe, loc_nPesos, loc_cDPro2s
1010: 		IF EMPTY(par_cCpros)
1011: 			RETURN
1012: 		ENDIF
1013: 		loc_nRet = SQLEXEC(gnConnHandle, ;
1014: 			"SELECT TOP 1 PVens, PrecoDe, PesoMs, DPro2s " + ;
1015: 			"FROM SigCdPro WHERE RTRIM(Cpros)=" + EscaparSQL(par_cCpros), ;
1016: 			"cursor_4c_PrecosProd")
1017: 		IF loc_nRet > 0 AND USED("cursor_4c_PrecosProd") AND RECCOUNT("cursor_4c_PrecosProd") > 0
1018: 			SELECT cursor_4c_PrecosProd
1019: 			loc_nPVens   = NVL(cursor_4c_PrecosProd.PVens,   0)
1020: 			loc_nPrecoDe = NVL(cursor_4c_PrecosProd.PrecoDe,  0)
1021: 			loc_nPesos   = NVL(cursor_4c_PrecosProd.PesoMs,  0)
1022: 			loc_cDPro2s  = ALLTRIM(NVL(cursor_4c_PrecosProd.DPro2s, ""))
1023: 			USE IN cursor_4c_PrecosProd
1024: 			SELECT cursor_4c_Etiquetas
1025: 			IF THIS.chk_4c_Precio.Value = 1
1026: 				REPLACE PVens   WITH loc_nPVens, ;
1027: 				        PrecoDe WITH loc_nPrecoDe, ;
1028: 				        Pesos   WITH loc_nPesos, ;
1029: 				        DPro2s  WITH loc_cDPro2s
1030: 			ELSE
1031: 				REPLACE Pesos  WITH loc_nPesos, ;
1032: 				        DPro2s WITH loc_cDPro2s
1033: 			ENDIF
1034: 		ENDIF
1035: 		IF USED("cursor_4c_PrecosProd")
1036: 			USE IN cursor_4c_PrecosProd
1037: 		ENDIF
1038: 	ENDPROC
1039: 
1040: 	*====================================================================
1041: 	* AtualizarPrecoPorLista - Substitui PVens/PrecoDe pelo preco da lista
1042: 	*====================================================================
1043: 	PROTECTED PROCEDURE AtualizarPrecoPorLista(par_cCpros)
1044: 		LOCAL loc_cLpreco, loc_nRet
1045: 		loc_cLpreco = ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value, ""))
1046: 		IF EMPTY(loc_cLpreco) OR EMPTY(par_cCpros)
1047: 			RETURN
1048: 		ENDIF
1049: 		loc_nRet = SQLEXEC(gnConnHandle, ;
1050: 			"SELECT TOP 1 PVens, PrecoDe FROM SigCdLpi " + ;
1051: 			"WHERE RTRIM(LPrecos)=" + EscaparSQL(loc_cLpreco) + ;
1052: 			" AND RTRIM(CPros)=" + EscaparSQL(par_cCpros), ;
1053: 			"cursor_4c_PrecoLista")
1054: 		IF loc_nRet > 0 AND USED("cursor_4c_PrecoLista") AND RECCOUNT("cursor_4c_PrecoLista") > 0
1055: 			SELECT cursor_4c_PrecoLista
1056: 			LOCAL loc_nPVens, loc_nPrecoDe
1057: 			loc_nPVens   = NVL(cursor_4c_PrecoLista.PVens,   0)
1058: 			loc_nPrecoDe = NVL(cursor_4c_PrecoLista.PrecoDe, 0)
1059: 			USE IN cursor_4c_PrecoLista
1060: 			SELECT cursor_4c_Etiquetas
1061: 			REPLACE PVens   WITH loc_nPVens, ;
1062: 			        PrecoDe WITH loc_nPrecoDe
1063: 		ENDIF
1064: 		IF USED("cursor_4c_PrecoLista")
1065: 			USE IN cursor_4c_PrecoLista
1066: 		ENDIF
1067: 	ENDPROC
1068: 
1069: 	*====================================================================
1070: 	* CarregarItensDaLista - Popula grid com todos itens de SigCdLpi
1071: 	*====================================================================
1072: 	PROTECTED PROCEDURE CarregarItensDaLista()
1073: 		LOCAL loc_cLpreco, loc_nRet
1074: 		loc_cLpreco = ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value, ""))
1075: 		IF EMPTY(loc_cLpreco)
1076: 			MsgAviso("Informe a lista de pre" + CHR(231) + "os.", "Aten" + CHR(231) + CHR(227) + "o")
1077: 			THIS.txt_4c_Lpreco.SetFocus()
1078: 			RETURN
1079: 		ENDIF
1080: 		loc_nRet = SQLEXEC(gnConnHandle, ;
1081: 			"SELECT i.CPros AS iCPros, p.DPros AS iDPros, p.DPro2s AS iDPro2s, " + ;
1082: 			" i.PVens AS iPVens, i.PrecoDe AS iPrecoDe, p.PesoMs AS iPesoMs " + ;
1083: 			"FROM SigCdLpi i " + ;
1084: 			"INNER JOIN SigCdPro p ON RTRIM(p.Cpros)=RTRIM(i.CPros) " + ;
1085: 			"WHERE RTRIM(i.LPrecos)=" + EscaparSQL(loc_cLpreco) + ;
1086: 			" ORDER BY i.CPros", ;
1087: 			"cursor_4c_ItensList")
1088: 		IF loc_nRet <= 0 OR !USED("cursor_4c_ItensList") OR RECCOUNT("cursor_4c_ItensList") = 0
1089: 			IF USED("cursor_4c_ItensList")
1090: 				USE IN cursor_4c_ItensList
1091: 			ENDIF
1092: 			MsgAviso("Nenhum item encontrado para a lista selecionada.", "Aten" + CHR(231) + CHR(227) + "o")
1093: 			RETURN
1094: 		ENDIF
1095: 		LOCAL loc_cCpros, loc_cDPros, loc_cDPro2s, loc_nPVens, loc_nPrecoDe, loc_nPesos
1096: 		SELECT cursor_4c_Etiquetas
1097: 		ZAP
1098: 		SELECT cursor_4c_ItensList
1099: 		SCAN
1100: 			loc_cCpros   = ALLTRIM(cursor_4c_ItensList.iCPros)
1101: 			loc_cDPros   = ALLTRIM(cursor_4c_ItensList.iDPros)
1102: 			loc_cDPro2s  = ALLTRIM(cursor_4c_ItensList.iDPro2s)
1103: 			loc_nPVens   = NVL(cursor_4c_ItensList.iPVens,   0)
1104: 			loc_nPrecoDe = NVL(cursor_4c_ItensList.iPrecoDe, 0)
1105: 			loc_nPesos   = NVL(cursor_4c_ItensList.iPesoMs,  0)
1106: 			SELECT cursor_4c_Etiquetas
1107: 			APPEND BLANK
1108: 			REPLACE Cpros   WITH loc_cCpros, ;
1109: 			        DPros   WITH loc_cDPros, ;
1110: 			        DPro2s  WITH loc_cDPro2s, ;
1111: 			        PVens   WITH loc_nPVens, ;
1112: 			        PrecoDe WITH loc_nPrecoDe, ;
1113: 			        Pesos   WITH loc_nPesos, ;
1114: 			        Qtds    WITH 1
1115: 			SELECT cursor_4c_ItensList
1116: 		ENDSCAN
1117: 		USE IN cursor_4c_ItensList
1118: 		SELECT cursor_4c_Etiquetas
1119: 		APPEND BLANK
1120: 		GO TOP
1121: 		THIS.grd_4c_Etiquetas.Refresh()
1122: 	ENDPROC
1123: 
1124: 	*====================================================================
1125: 	* CmdBtnCarregarClick - Carrega itens de SigMvItn por empresa/operacao
1126: 	*====================================================================
1127: 	PROCEDURE CmdBtnCarregarClick()
1128: 		LOCAL loc_cEmps, loc_cDopes, loc_nNumes, loc_cLpreco, loc_nRet
1129: 		loc_cEmps   = ALLTRIM(NVL(THIS.txt_4c_Emps.Value,  ""))
1130: 		loc_cDopes  = ALLTRIM(NVL(THIS.txt_4c_Dopes.Value, ""))
1131: 		loc_nNumes  = IIF(PEMSTATUS(THIS, "txt_4c_Numes", 5) AND VARTYPE(THIS.txt_4c_Numes) = "O", ;
1132: 		                  NVL(THIS.txt_4c_Numes.Value, 0), 0)
1133: 		loc_cLpreco = ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value,""))
1134: 		IF EMPTY(loc_cEmps)
1135: 			MsgAviso("Informe a empresa.", "Aten" + CHR(231) + CHR(227) + "o")
1136: 			THIS.txt_4c_Emps.SetFocus()
1137: 			RETURN
1138: 		ENDIF
1139: 		IF EMPTY(loc_cDopes)
1140: 			MsgAviso("Informe a opera" + CHR(231) + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
1141: 			THIS.txt_4c_Dopes.SetFocus()
1142: 			RETURN
1143: 		ENDIF
1144: 		IF loc_nNumes <= 0
1145: 			MsgAviso("Informe o n" + CHR(250) + "mero do documento.", "Aten" + CHR(231) + CHR(227) + "o")
1146: 			IF PEMSTATUS(THIS, "txt_4c_Numes", 5) AND VARTYPE(THIS.txt_4c_Numes) = "O"
1147: 				THIS.txt_4c_Numes.SetFocus()
1148: 			ENDIF
1149: 			RETURN
1150: 		ENDIF
1151: 		loc_nRet = SQLEXEC(gnConnHandle, ;
1152: 			"SELECT i.CPros AS iCPros, p.DPros AS iDPros, p.DPro2s AS iDPro2s, " + ;
1153: 			" i.Qtds AS iQtds, i.Citens AS iCitens, i.Numes AS iNumes, " + ;
1154: 			" i.Emps AS iEmps, i.Dopes AS iDopes, " + ;
1155: 			" p.PVens AS iPVens, p.PrecoDe AS iPrecoDe, p.PesoMs AS iPesoMs " + ;
1156: 			"FROM SigMvItn i " + ;
1157: 			"LEFT JOIN SigCdPro p ON RTRIM(p.Cpros)=RTRIM(i.CPros) " + ;
1158: 			"WHERE RTRIM(i.Emps)=" + EscaparSQL(loc_cEmps) + ;
1159: 			" AND RTRIM(i.Dopes)=" + EscaparSQL(loc_cDopes) + ;
1160: 			" AND i.Numes = " + FormatarNumeroSQL(loc_nNumes, 0) + ;
1161: 			" ORDER BY i.CPros", ;
1162: 			"cursor_4c_SigMvItn")
1163: 		IF loc_nRet <= 0 OR !USED("cursor_4c_SigMvItn") OR RECCOUNT("cursor_4c_SigMvItn") = 0
1164: 			IF USED("cursor_4c_SigMvItn")
1165: 				USE IN cursor_4c_SigMvItn
1166: 			ENDIF
1167: 			MsgAviso("Nenhum item encontrado para empresa/opera" + CHR(231) + CHR(227) + "o informada.", ;
1168: 			         "Aten" + CHR(231) + CHR(227) + "o")
1169: 			RETURN
1170: 		ENDIF
1171: 		LOCAL loc_cCpros, loc_cDPros, loc_cDPro2s
1172: 		LOCAL loc_nQtds, loc_nCitens, loc_nNumes
1173: 		LOCAL loc_cIEmps, loc_cIDopes
1174: 		LOCAL loc_nPVens, loc_nPrecoDe, loc_nPesos
1175: 		LOCAL loc_cEmpDoNum, loc_nRetLpi
1176: 		SELECT cursor_4c_Etiquetas
1177: 		ZAP
1178: 		SELECT cursor_4c_SigMvItn
1179: 		SCAN
1180: 			loc_cCpros   = ALLTRIM(cursor_4c_SigMvItn.iCPros)
1181: 			loc_cDPros   = ALLTRIM(NVL(cursor_4c_SigMvItn.iDPros,  ""))
1182: 			loc_cDPro2s  = ALLTRIM(NVL(cursor_4c_SigMvItn.iDPro2s, ""))
1183: 			loc_nQtds    = NVL(cursor_4c_SigMvItn.iQtds,    0)
1184: 			loc_nCitens  = NVL(cursor_4c_SigMvItn.iCitens,  0)
1185: 			loc_nNumes   = NVL(cursor_4c_SigMvItn.iNumes,   0)
1186: 			loc_cIEmps   = ALLTRIM(NVL(cursor_4c_SigMvItn.iEmps,   ""))
1187: 			loc_cIDopes  = ALLTRIM(NVL(cursor_4c_SigMvItn.iDopes,  ""))
1188: 			loc_nPVens   = NVL(cursor_4c_SigMvItn.iPVens,   0)
1189: 			loc_nPrecoDe = NVL(cursor_4c_SigMvItn.iPrecoDe,  0)
1190: 			loc_nPesos   = NVL(cursor_4c_SigMvItn.iPesoMs,  0)
1191: 			*-- Aplica lista de precos se habilitada
1192: 			IF THIS.chk_4c_Lista.Value = 1 AND !EMPTY(loc_cLpreco)
1193: 				loc_nRetLpi = SQLEXEC(gnConnHandle, ;
1194: 					"SELECT TOP 1 PVens, PrecoDe FROM SigCdLpi " + ;
1195: 					"WHERE RTRIM(LPrecos)=" + EscaparSQL(loc_cLpreco) + ;
1196: 					" AND RTRIM(CPros)=" + EscaparSQL(loc_cCpros), ;
1197: 					"cursor_4c_Lpi")
1198: 				IF loc_nRetLpi > 0 AND USED("cursor_4c_Lpi") AND RECCOUNT("cursor_4c_Lpi") > 0
1199: 					SELECT cursor_4c_Lpi
1200: 					loc_nPVens   = NVL(cursor_4c_Lpi.PVens,   loc_nPVens)
1201: 					loc_nPrecoDe = NVL(cursor_4c_Lpi.PrecoDe, loc_nPrecoDe)
1202: 				ENDIF
1203: 				IF USED("cursor_4c_Lpi")
1204: 					USE IN cursor_4c_Lpi
1205: 				ENDIF
1206: 			ENDIF
1207: 			loc_cEmpDoNum = PADR(loc_cIEmps, 3) + PADR(loc_cIDopes, 20) + STR(loc_nNumes, 6, 0)

*-- Linhas 1230 a 1441:
1230: 	*====================================================================
1231: 	* CmdBtnExcluirClick - Remove linha selecionada do grid
1232: 	*====================================================================
1233: 	PROCEDURE CmdBtnExcluirClick()
1234: 		IF !USED("cursor_4c_Etiquetas") OR RECCOUNT("cursor_4c_Etiquetas") <= 1
1235: 			RETURN
1236: 		ENDIF
1237: 		SELECT cursor_4c_Etiquetas
1238: 		IF EOF() OR BOF() OR EMPTY(cursor_4c_Etiquetas.Cpros)
1239: 			RETURN
1240: 		ENDIF
1241: 		DELETE
1242: 		PACK
1243: 		IF RECCOUNT("cursor_4c_Etiquetas") = 0
1244: 			APPEND BLANK
1245: 		ENDIF
1246: 		GO TOP
1247: 		THIS.grd_4c_Etiquetas.Refresh()
1248: 	ENDPROC
1249: 
1250: 	*====================================================================
1251: 	* BtnIncluirClick - Adiciona linha em branco no grid para o usuario
1252: 	* preencher manualmente (produto/quantidade). Adaptacao CRUD do
1253: 	* fluxo OPERACIONAL: nao ha modo de edicao separado, o grid eh
1254: 	* editavel diretamente.
1255: 	*====================================================================
1256: 	PROCEDURE BtnIncluirClick()
1257: 		IF !USED("cursor_4c_Etiquetas")
1258: 			MsgAviso("Grid n" + CHR(227) + "o inicializado.", "Aten" + CHR(231) + CHR(227) + "o")
1259: 			RETURN
1260: 		ENDIF
1261: 		SELECT cursor_4c_Etiquetas
1262: 		*-- Se ja existe linha em branco no final, apenas posiciona nela
1263: 		GO BOTTOM
1264: 		IF EMPTY(cursor_4c_Etiquetas.Cpros)
1265: 			THIS.grd_4c_Etiquetas.Refresh()
1266: 			THIS.grd_4c_Etiquetas.SetFocus()
1267: 			RETURN
1268: 		ENDIF
1269: 		*-- Adiciona nova linha em branco para digitacao
1270: 		APPEND BLANK
1271: 		GO BOTTOM
1272: 		THIS.grd_4c_Etiquetas.Refresh()
1273: 		THIS.grd_4c_Etiquetas.SetFocus()
1274: 	ENDPROC
1275: 
1276: 	*====================================================================
1277: 	* BtnAlterarClick - Coloca o foco no campo Cpros (produto) da linha
1278: 	* corrente do grid, permitindo alterar quantidade/produto. Adaptacao
1279: 	* CRUD do fluxo OPERACIONAL - a edicao eh inline no grid.
1280: 	*====================================================================
1281: 	PROCEDURE BtnAlterarClick()
1282: 		IF !USED("cursor_4c_Etiquetas") OR RECCOUNT("cursor_4c_Etiquetas") = 0
1283: 			MsgAviso("Nenhum item para alterar.", "Aten" + CHR(231) + CHR(227) + "o")
1284: 			RETURN
1285: 		ENDIF
1286: 		SELECT cursor_4c_Etiquetas
1287: 		IF EOF() OR BOF()
1288: 			GO TOP
1289: 		ENDIF
1290: 		THIS.grd_4c_Etiquetas.Refresh()
1291: 		THIS.grd_4c_Etiquetas.SetFocus()
1292: 		*-- Tenta focar na primeira coluna editavel (Cpros)
1293: 		IF PEMSTATUS(THIS.grd_4c_Etiquetas, "Column1", 5) AND ;
1294: 		   VARTYPE(THIS.grd_4c_Etiquetas.Column1) = "O"
1295: 			IF PEMSTATUS(THIS.grd_4c_Etiquetas.Column1, "Text1", 5) AND ;
1296: 			   VARTYPE(THIS.grd_4c_Etiquetas.Column1.Text1) = "O"
1297: 				THIS.grd_4c_Etiquetas.Column1.Text1.SetFocus()
1298: 			ENDIF
1299: 		ENDIF
1300: 	ENDPROC
1301: 
1302: 	*====================================================================
1303: 	* BtnVisualizarClick - Reposiciona no topo do grid, atualiza contagem
1304: 	* e mostra resumo dos itens carregados. Adaptacao CRUD do fluxo
1305: 	* OPERACIONAL - equivale a visualizar a lista selecionada.
1306: 	*====================================================================
1307: 	PROCEDURE BtnVisualizarClick()
1308: 		LOCAL loc_nTotal, loc_nQtdTotal, loc_cMensagem
1309: 		IF !USED("cursor_4c_Etiquetas") OR RECCOUNT("cursor_4c_Etiquetas") = 0
1310: 			MsgAviso("Nenhum item na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1311: 			RETURN
1312: 		ENDIF
1313: 		SELECT cursor_4c_Etiquetas
1314: 		loc_nTotal    = 0
1315: 		loc_nQtdTotal = 0
1316: 		SCAN FOR !EMPTY(cursor_4c_Etiquetas.Cpros)
1317: 			loc_nTotal    = loc_nTotal + 1
1318: 			loc_nQtdTotal = loc_nQtdTotal + NVL(cursor_4c_Etiquetas.Qtds, 0)
1319: 		ENDSCAN
1320: 		GO TOP
1321: 		THIS.grd_4c_Etiquetas.Refresh()
1322: 		THIS.grd_4c_Etiquetas.SetFocus()
1323: 		loc_cMensagem = "Itens selecionados: " + TRANSFORM(loc_nTotal) + CHR(13) + ;
1324: 		                "Quantidade total: " + TRANSFORM(loc_nQtdTotal, "@Z 9,999,999.999")
1325: 		MsgInfo(loc_cMensagem, "Resumo da Sele" + CHR(231) + CHR(227) + "o")
1326: 	ENDPROC
1327: 
1328: 	*====================================================================
1329: 	* BtnExcluirClick - Remove linha selecionada do grid (com confirmacao).
1330: 	* Delega para CmdBtnExcluirClick que faz a exclusao efetiva.
1331: 	*====================================================================
1332: 	PROCEDURE BtnExcluirClick()
1333: 		IF !USED("cursor_4c_Etiquetas") OR RECCOUNT("cursor_4c_Etiquetas") <= 1
1334: 			MsgAviso("Nenhum item para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
1335: 			RETURN
1336: 		ENDIF
1337: 		SELECT cursor_4c_Etiquetas
1338: 		IF EOF() OR BOF() OR EMPTY(cursor_4c_Etiquetas.Cpros)
1339: 			MsgAviso("Selecione um item v" + CHR(225) + "lido para excluir.", ;
1340: 			         "Aten" + CHR(231) + CHR(227) + "o")
1341: 			RETURN
1342: 		ENDIF
1343: 		IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do item selecionado?", ;
1344: 		                "Confirma" + CHR(231) + CHR(227) + "o")
1345: 			RETURN
1346: 		ENDIF
1347: 		THIS.CmdBtnExcluirClick()
1348: 	ENDPROC
1349: 
1350: 	*====================================================================
1351: 	* BtnImprimirClick - Coleta parametros dos controles e chama BO
1352: 	*====================================================================
1353: 	PROCEDURE BtnImprimirClick()
1354: 		IF !USED("cursor_4c_Etiquetas")
1355: 			MsgAviso("Nenhum item na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1356: 			RETURN
1357: 		ENDIF
1358: 		SELECT cursor_4c_Etiquetas
1359: 		LOCATE FOR EMPTY(cursor_4c_Etiquetas.Cpros)
1360: 		IF FOUND()
1361: 			DELETE
1362: 			PACK
1363: 		ENDIF
1364: 		IF RECCOUNT("cursor_4c_Etiquetas") = 0
1365: 			MsgAviso("Nenhum produto adicionado para impress" + CHR(227) + "o.", ;
1366: 			         "Aten" + CHR(231) + CHR(227) + "o")
1367: 			APPEND BLANK
1368: 			RETURN
1369: 		ENDIF
1370: 		GO TOP
1371: 
1372: 		*-- Coleta parametros dos controles de configuracao
1373: 		LOCAL loc_nImpPreco, loc_lImpSepar, loc_lImpPeso, loc_lCompo
1374: 		LOCAL loc_nTpEti, loc_nTpImp, loc_nAjVerts, loc_nAjHorzs
1375: 		LOCAL loc_nAjDenss, loc_nAjVelos, loc_cNomeImp, loc_nOrdem
1376: 		LOCAL loc_cLp1, loc_cLp2
1377: 
1378: 		*-- Defaults do BO
1379: 		loc_nImpPreco = 1
1380: 		loc_lImpSepar = .T.
1381: 		loc_lImpPeso  = .T.
1382: 		loc_lCompo    = .T.
1383: 		loc_nTpEti    = 1
1384: 		loc_nTpImp    = 1
1385: 		loc_nAjVerts  = 0
1386: 		loc_nAjHorzs  = 0
1387: 		loc_nAjDenss  = 20
1388: 		loc_nAjVelos  = 3
1389: 		loc_cNomeImp  = ""
1390: 		loc_nOrdem    = 1
1391: 		loc_cLp1      = ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value,  ""))
1392: 		loc_cLp2      = ALLTRIM(NVL(THIS.txt_4c_LPreco2.Value, ""))
1393: 
1394: 		*-- Tipo de etiqueta (obj_4c_Opt_Tipo)
1395: 		IF PEMSTATUS(THIS, "obj_4c_Opt_Tipo", 5) AND VARTYPE(THIS.obj_4c_Opt_Tipo) = "O"
1396: 			loc_nTpEti = NVL(THIS.obj_4c_Opt_Tipo.Value, 1)
1397: 		ENDIF
1398: 
1399: 		*-- Configuracoes da impressora (cnt_4c_Impressora)
1400: 		IF PEMSTATUS(THIS, "cnt_4c_Impressora", 5) AND VARTYPE(THIS.cnt_4c_Impressora) = "O"
1401: 			*-- Tipo impressora (OptionGroup OpcaoImp)
1402: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "obj_4c_OpcaoImp", 5) AND ;
1403: 			   VARTYPE(THIS.cnt_4c_Impressora.obj_4c_OpcaoImp) = "O"
1404: 				loc_nTpImp = NVL(THIS.cnt_4c_Impressora.obj_4c_OpcaoImp.Value, 1)
1405: 			ENDIF
1406: 			*-- Ajustes (spinners)
1407: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjVerts", 5) AND ;
1408: 			   VARTYPE(THIS.cnt_4c_Impressora.spn_4c_AjVerts) = "O"
1409: 				loc_nAjVerts = NVL(THIS.cnt_4c_Impressora.spn_4c_AjVerts.Value, 0)
1410: 			ENDIF
1411: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjHorzs", 5) AND ;
1412: 			   VARTYPE(THIS.cnt_4c_Impressora.spn_4c_AjHorzs) = "O"
1413: 				loc_nAjHorzs = NVL(THIS.cnt_4c_Impressora.spn_4c_AjHorzs.Value, 0)
1414: 			ENDIF
1415: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjDenss", 5) AND ;
1416: 			   VARTYPE(THIS.cnt_4c_Impressora.spn_4c_AjDenss) = "O"
1417: 				loc_nAjDenss = NVL(THIS.cnt_4c_Impressora.spn_4c_AjDenss.Value, 20)
1418: 			ENDIF
1419: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjVelos", 5) AND ;
1420: 			   VARTYPE(THIS.cnt_4c_Impressora.spn_4c_AjVelos) = "O"
1421: 				loc_nAjVelos = NVL(THIS.cnt_4c_Impressora.spn_4c_AjVelos.Value, 3)
1422: 			ENDIF
1423: 		ENDIF
1424: 
1425: 		*-- Nome da impressora (cbo_4c_GetPrinter)
1426: 		IF PEMSTATUS(THIS, "cbo_4c_GetPrinter", 5) AND VARTYPE(THIS.cbo_4c_GetPrinter) = "O"
1427: 			loc_cNomeImp = ALLTRIM(NVL(THIS.cbo_4c_GetPrinter.Value, ""))
1428: 		ENDIF
1429: 
1430: 		*-- Opcoes de impressao da Fase 6 (opt_separador, opt_Preco, opt_peso, optCompos, OptOrdem)
1431: 		IF PEMSTATUS(THIS, "obj_4c_OptSeparador", 5) AND VARTYPE(THIS.obj_4c_OptSeparador) = "O"
1432: 			loc_lImpSepar = (THIS.obj_4c_OptSeparador.Value = 1)
1433: 		ENDIF
1434: 		IF PEMSTATUS(THIS, "obj_4c_OptPreco", 5) AND VARTYPE(THIS.obj_4c_OptPreco) = "O"
1435: 			loc_nImpPreco = NVL(THIS.obj_4c_OptPreco.Value, 1)
1436: 		ENDIF
1437: 		IF PEMSTATUS(THIS, "obj_4c_OptPeso", 5) AND VARTYPE(THIS.obj_4c_OptPeso) = "O"
1438: 			loc_lImpPeso = (THIS.obj_4c_OptPeso.Value = 1)
1439: 		ENDIF
1440: 		IF PEMSTATUS(THIS, "obj_4c_OptCompos", 5) AND VARTYPE(THIS.obj_4c_OptCompos) = "O"
1441: 			loc_lCompo = (THIS.obj_4c_OptCompos.Value = 1)

*-- Linhas 1462 a 1548:
1462: 	*====================================================================
1463: 	* BtnEncerrarClick - Fecha o formulario
1464: 	*====================================================================
1465: 	PROCEDURE BtnEncerrarClick()
1466: 		THIS.Release()
1467: 	ENDPROC
1468: 
1469: 	*====================================================================
1470: 	* ConfigurarPaginaDados - Secao inferior: tipo etiqueta e impressora
1471: 	*====================================================================
1472: 	PROTECTED PROCEDURE ConfigurarPaginaDados()
1473: 
1474: 		*-- Label titulo secao (sobre o grid)
1475: 		THIS.AddObject("lbl_4c_LblTituloGrd", "Label")
1476: 		WITH THIS.lbl_4c_LblTituloGrd
1477: 			.AutoSize  = .F.
1478: 			.Caption   = " \<Etiquetas Selecionadas "
1479: 			.Top       = 375
1480: 			.Left      = 10
1481: 			.Width     = 210
1482: 			.Height    = 15
1483: 			.FontBold  = .T.
1484: 			.FontName  = "Tahoma"
1485: 			.FontSize  = 8
1486: 			.BackStyle = 0
1487: 			.ForeColor = RGB(90, 90, 90)
1488: 		ENDWITH
1489: 
1490: 		*-- Label "Tipo de Etiqueta"
1491: 		THIS.AddObject("lbl_4c_TipoEtq", "Label")
1492: 		WITH THIS.lbl_4c_TipoEtq
1493: 			.AutoSize  = .F.
1494: 			.FontBold  = .T.
1495: 			.FontName  = "Tahoma"
1496: 			.FontSize  = 8
1497: 			.BackStyle = 0
1498: 			.Caption   = " Tipo de Etiqueta "
1499: 			.Height    = 15
1500: 			.Left      = 23
1501: 			.Top       = 415
1502: 			.Width     = 110
1503: 			.ForeColor = RGB(90, 90, 90)
1504: 		ENDWITH
1505: 
1506: 		*-- OptionGroup Tipo Etiqueta (1 botao inicial: Rabicho)
1507: 		*-- PopularTiposEtiqueta() adiciona botoes dinamicamente via BO.CarregarTiposEtiqueta()
1508: 		THIS.AddObject("obj_4c_Opt_Tipo", "OptionGroup")
1509: 		WITH THIS.obj_4c_Opt_Tipo
1510: 			.ButtonCount   = 1
1511: 			.BackStyle     = 0
1512: 			.Value         = 1
1513: 			.Height        = 182
1514: 			.Left          = 13
1515: 			.SpecialEffect = 1
1516: 			.Top           = 431
1517: 			.Width         = 240
1518: 			.Themes        = .F.
1519: 			WITH .Buttons(1)
1520: 				.BackStyle = 0
1521: 				.Caption   = "Rabicho"
1522: 				.Height    = 16
1523: 				.Left      = 9
1524: 				.Style     = 0
1525: 				.Top       = 10
1526: 				.Width     = 197
1527: 				.ForeColor = RGB(90, 90, 90)
1528: 			ENDWITH
1529: 		ENDWITH
1530: 
1531: 		*-- Shape3 (borda visual do bloco impressora)
1532: 		THIS.AddObject("shp_4c_Shape3", "Shape")
1533: 		WITH THIS.shp_4c_Shape3
1534: 			.Top           = 431
1535: 			.Left          = 260
1536: 			.Height        = 106
1537: 			.Width         = 254
1538: 			.BackStyle     = 0
1539: 			.BorderWidth   = 1
1540: 			.SpecialEffect = 1
1541: 		ENDWITH
1542: 
1543: 		*-- Label "Impressora"
1544: 		THIS.AddObject("lbl_4c_LImpressora", "Label")
1545: 		WITH THIS.lbl_4c_LImpressora
1546: 			.AutoSize  = .F.
1547: 			.FontBold  = .T.
1548: 			.FontName  = "Tahoma"

*-- Linhas 1557 a 1600:
1557: 		ENDWITH
1558: 
1559: 		*-- Opt_Impressora (legado - Visible=.F., mantido por compatibilidade)
1560: 		THIS.AddObject("obj_4c_Opt_Impressora", "OptionGroup")
1561: 		WITH THIS.obj_4c_Opt_Impressora
1562: 			.ButtonCount   = 1
1563: 			.BackStyle     = 0
1564: 			.Value         = 1
1565: 			.Height        = 47
1566: 			.Left          = 260
1567: 			.SpecialEffect = 1
1568: 			.Top           = 431
1569: 			.Width         = 254
1570: 			.Themes        = .F.
1571: 			.Visible       = .F.
1572: 			WITH .Buttons(1)
1573: 				.BackStyle = 0
1574: 				.Caption   = "Gen" + CHR(233) + "rico/Somente Texto"
1575: 				.Height    = 16
1576: 				.Left      = 9
1577: 				.Style     = 0
1578: 				.Top       = 52
1579: 				.Width     = 210
1580: 				.ForeColor = RGB(36, 84, 155)
1581: 			ENDWITH
1582: 		ENDWITH
1583: 
1584: 		*-- Label "Sistema" (impressora sistema)
1585: 		THIS.AddObject("lbl_4c_LSistema", "Label")
1586: 		WITH THIS.lbl_4c_LSistema
1587: 			.AutoSize  = .F.
1588: 			.FontName  = "Tahoma"
1589: 			.FontSize  = 8
1590: 			.BackStyle = 0
1591: 			.Caption   = "Sistema"
1592: 			.Height    = 15
1593: 			.Left      = 270
1594: 			.Top       = 437
1595: 			.Width     = 55
1596: 			.ForeColor = RGB(90, 90, 90)
1597: 		ENDWITH
1598: 
1599: 		*-- Label "Windows" (impressora Windows)
1600: 		THIS.AddObject("lbl_4c_LWindows", "Label")

*-- Linhas 1638 a 1682:
1638: 			.BackStyle   = 0
1639: 			.BorderWidth = 0
1640: 
1641: 			*-- OptionGroup tipo impressora: 1=Allegro 2=Zebra ZPL 3=Zebra EPL
1642: 			.AddObject("obj_4c_OpcaoImp", "OptionGroup")
1643: 			WITH .obj_4c_OpcaoImp
1644: 				.ButtonCount = 3
1645: 				.Height      = 24
1646: 				.Left        = 5
1647: 				.Top         = 3
1648: 				.Width       = 241
1649: 				WITH .Buttons(1)
1650: 					.Caption   = "Allegro"
1651: 					.Left      = 2
1652: 					.Top       = 4
1653: 					.Width     = 51
1654: 					.AutoSize  = .F.
1655: 					.ForeColor = RGB(90, 90, 90)
1656: 					.BackStyle = 0
1657: 				ENDWITH
1658: 				WITH .Buttons(2)
1659: 					.Caption   = "Zebra ZPL"
1660: 					.Left      = 75
1661: 					.Top       = 4
1662: 					.Width     = 70
1663: 					.AutoSize  = .F.
1664: 					.FontName  = "Tahoma"
1665: 					.FontSize  = 8
1666: 					.ForeColor = RGB(90, 90, 90)
1667: 					.BackStyle = 0
1668: 				ENDWITH
1669: 				WITH .Buttons(3)
1670: 					.Caption   = "Zebra EPL"
1671: 					.Left      = 164
1672: 					.Top       = 4
1673: 					.Width     = 70
1674: 					.AutoSize  = .F.
1675: 					.Height    = 15
1676: 					.FontName  = "Tahoma"
1677: 					.FontSize  = 8
1678: 					.BackStyle = 0
1679: 					.ForeColor = RGB(90, 90, 90)
1680: 				ENDWITH
1681: 			ENDWITH
1682: 

*-- Linhas 1814 a 1858:
1814: 			.ForeColor = RGB(90, 90, 90)
1815: 		ENDWITH
1816: 
1817: 		*-- OptionGroup Separadora (opt_separador): 1=Sim 2=Nao
1818: 		THIS.AddObject("obj_4c_OptSeparador", "OptionGroup")
1819: 		WITH THIS.obj_4c_OptSeparador
1820: 			.ButtonCount   = 2
1821: 			.BackStyle     = 0
1822: 			.Value         = 1
1823: 			.Height        = 25
1824: 			.Left          = 601
1825: 			.SpecialEffect = 1
1826: 			.Top           = 412
1827: 			.Width         = 198
1828: 			.Themes        = .F.
1829: 			WITH .Buttons(1)
1830: 				.BackStyle = 0
1831: 				.Caption   = "Sim"
1832: 				.Height    = 15
1833: 				.Left      = 5
1834: 				.Top       = 5
1835: 				.Width     = 34
1836: 				.AutoSize  = .F.
1837: 				.ForeColor = RGB(90, 90, 90)
1838: 			ENDWITH
1839: 			WITH .Buttons(2)
1840: 				.FontName  = "Tahoma"
1841: 				.FontSize  = 8
1842: 				.BackStyle = 0
1843: 				.Caption   = "N" + CHR(227) + "o"
1844: 				.Height    = 15
1845: 				.Left      = 70
1846: 				.Top       = 5
1847: 				.Width     = 37
1848: 				.AutoSize  = .F.
1849: 				.ForeColor = RGB(90, 90, 90)
1850: 			ENDWITH
1851: 		ENDWITH
1852: 
1853: 		*-- Label "Preco"
1854: 		THIS.AddObject("lbl_4c_LblPreco", "Label")
1855: 		WITH THIS.lbl_4c_LblPreco
1856: 			.AutoSize  = .F.
1857: 			.FontName  = "Tahoma"
1858: 			.FontSize  = 8

*-- Linhas 1865 a 1909:
1865: 			.ForeColor = RGB(90, 90, 90)
1866: 		ENDWITH
1867: 
1868: 		*-- OptionGroup Preco (opt_Preco): 1=Sim 2=Nao 3=Ideal 4=Atual 5=PrecoDe/Por 6=Parcelamento
1869: 		THIS.AddObject("obj_4c_OptPreco", "OptionGroup")
1870: 		WITH THIS.obj_4c_OptPreco
1871: 			.ButtonCount   = 6
1872: 			.BackStyle     = 0
1873: 			.Value         = 1
1874: 			.Height        = 95
1875: 			.Left          = 601
1876: 			.SpecialEffect = 1
1877: 			.Top           = 439
1878: 			.Width         = 198
1879: 			.Themes        = .F.
1880: 			WITH .Buttons(1)
1881: 				.BackStyle = 0
1882: 				.Caption   = "Sim"
1883: 				.Height    = 15
1884: 				.Left      = 8
1885: 				.Top       = 7
1886: 				.Width     = 34
1887: 				.AutoSize  = .F.
1888: 				.ForeColor = RGB(90, 90, 90)
1889: 			ENDWITH
1890: 			WITH .Buttons(2)
1891: 				.FontName  = "Tahoma"
1892: 				.FontSize  = 8
1893: 				.BackStyle = 0
1894: 				.Caption   = "N" + CHR(227) + "o"
1895: 				.Height    = 15
1896: 				.Left      = 61
1897: 				.Top       = 7
1898: 				.Width     = 37
1899: 				.AutoSize  = .F.
1900: 				.ForeColor = RGB(90, 90, 90)
1901: 			ENDWITH
1902: 			WITH .Buttons(3)
1903: 				.FontName  = "Tahoma"
1904: 				.FontSize  = 8
1905: 				.BackStyle = 0
1906: 				.Caption   = "Ideal"
1907: 				.Height    = 15
1908: 				.Left      = 8
1909: 				.Top       = 28

*-- Linhas 1964 a 2008:
1964: 			.ForeColor = RGB(90, 90, 90)
1965: 		ENDWITH
1966: 
1967: 		*-- OptionGroup Peso (opt_peso): 1=Sim 2=Nao
1968: 		THIS.AddObject("obj_4c_OptPeso", "OptionGroup")
1969: 		WITH THIS.obj_4c_OptPeso
1970: 			.ButtonCount   = 2
1971: 			.BackStyle     = 0
1972: 			.Value         = 1
1973: 			.Height        = 25
1974: 			.Left          = 601
1975: 			.SpecialEffect = 1
1976: 			.Top           = 535
1977: 			.Width         = 198
1978: 			.Themes        = .F.
1979: 			WITH .Buttons(1)
1980: 				.BackStyle = 0
1981: 				.Caption   = "Sim"
1982: 				.Height    = 15
1983: 				.Left      = 5
1984: 				.Top       = 5
1985: 				.Width     = 41
1986: 				.AutoSize  = .F.
1987: 				.ForeColor = RGB(90, 90, 90)
1988: 			ENDWITH
1989: 			WITH .Buttons(2)
1990: 				.FontName  = "Tahoma"
1991: 				.FontSize  = 8
1992: 				.BackStyle = 0
1993: 				.Caption   = "N" + CHR(227) + "o"
1994: 				.Height    = 15
1995: 				.Left      = 70
1996: 				.Top       = 5
1997: 				.Width     = 41
1998: 				.AutoSize  = .F.
1999: 				.ForeColor = RGB(90, 90, 90)
2000: 			ENDWITH
2001: 		ENDWITH
2002: 
2003: 		*-- Label "Composicao"
2004: 		THIS.AddObject("lbl_4c_LblCompos", "Label")
2005: 		WITH THIS.lbl_4c_LblCompos
2006: 			.AutoSize  = .F.
2007: 			.FontName  = "Tahoma"
2008: 			.FontSize  = 8

*-- Linhas 2015 a 2059:
2015: 			.ForeColor = RGB(90, 90, 90)
2016: 		ENDWITH
2017: 
2018: 		*-- OptionGroup Composicao (optCompos): 1=Sim 2=Nao
2019: 		THIS.AddObject("obj_4c_OptCompos", "OptionGroup")
2020: 		WITH THIS.obj_4c_OptCompos
2021: 			.ButtonCount   = 2
2022: 			.BackStyle     = 0
2023: 			.Value         = 1
2024: 			.Height        = 25
2025: 			.Left          = 601
2026: 			.SpecialEffect = 1
2027: 			.Top           = 562
2028: 			.Width         = 198
2029: 			.Themes        = .F.
2030: 			WITH .Buttons(1)
2031: 				.BackStyle = 0
2032: 				.Caption   = "Sim"
2033: 				.Height    = 15
2034: 				.Left      = 5
2035: 				.Top       = 5
2036: 				.Width     = 41
2037: 				.AutoSize  = .F.
2038: 				.ForeColor = RGB(90, 90, 90)
2039: 			ENDWITH
2040: 			WITH .Buttons(2)
2041: 				.FontName  = "Tahoma"
2042: 				.FontSize  = 8
2043: 				.BackStyle = 0
2044: 				.Caption   = "N" + CHR(227) + "o"
2045: 				.Height    = 15
2046: 				.Left      = 70
2047: 				.Top       = 5
2048: 				.Width     = 41
2049: 				.AutoSize  = .F.
2050: 				.ForeColor = RGB(90, 90, 90)
2051: 			ENDWITH
2052: 		ENDWITH
2053: 
2054: 		*-- Label "Ordem"
2055: 		THIS.AddObject("lbl_4c_LblOrdem", "Label")
2056: 		WITH THIS.lbl_4c_LblOrdem
2057: 			.AutoSize  = .F.
2058: 			.FontName  = "Tahoma"
2059: 			.FontSize  = 8

*-- Linhas 2066 a 2359:
2066: 			.ForeColor = RGB(90, 90, 90)
2067: 		ENDWITH
2068: 
2069: 		*-- OptionGroup Ordem (OptOrdem): 1=Produto 2=Nenhuma
2070: 		THIS.AddObject("obj_4c_OptOrdem", "OptionGroup")
2071: 		WITH THIS.obj_4c_OptOrdem
2072: 			.ButtonCount   = 2
2073: 			.BackStyle     = 0
2074: 			.Value         = 1
2075: 			.Height        = 25
2076: 			.Left          = 601
2077: 			.SpecialEffect = 1
2078: 			.Top           = 589
2079: 			.Width         = 198
2080: 			.Themes        = .F.
2081: 			WITH .Buttons(1)
2082: 				.BackStyle = 0
2083: 				.Caption   = "Produto"
2084: 				.Height    = 15
2085: 				.Left      = 5
2086: 				.Top       = 4
2087: 				.Width     = 56
2088: 				.AutoSize  = .F.
2089: 				.ForeColor = RGB(90, 90, 90)
2090: 			ENDWITH
2091: 			WITH .Buttons(2)
2092: 				.FontName  = "Tahoma"
2093: 				.FontSize  = 8
2094: 				.BackStyle = 0
2095: 				.Caption   = "Nenhuma"
2096: 				.Height    = 15
2097: 				.Left      = 70
2098: 				.Top       = 4
2099: 				.Width     = 63
2100: 				.AutoSize  = .F.
2101: 				.ForeColor = RGB(90, 90, 90)
2102: 			ENDWITH
2103: 		ENDWITH
2104: 
2105: 		*-- BINDEVENTs (handlers sao PUBLIC - obrigatorio para BINDEVENT)
2106: 		BINDEVENT(THIS.obj_4c_Opt_Tipo, "InteractiveChange", THIS, "ObjOptTipoChange")
2107: 		BINDEVENT(THIS.cnt_4c_Impressora.obj_4c_OpcaoImp, "InteractiveChange", THIS, "ObjOpcaoImpChange")
2108: 		BINDEVENT(THIS.cbo_4c_GetPrinter, "InteractiveChange", THIS, "CboGetPrinterChange")
2109: 	ENDPROC
2110: 
2111: 	*====================================================================
2112: 	* PopularTiposEtiqueta - Adiciona botoes ao obj_4c_Opt_Tipo via BO
2113: 	*====================================================================
2114: 	PROTECTED PROCEDURE PopularTiposEtiqueta()
2115: 		IF VARTYPE(THIS.this_oBusinessObject) != "O"
2116: 			RETURN
2117: 		ENDIF
2118: 		IF !PEMSTATUS(THIS, "obj_4c_Opt_Tipo", 5) OR VARTYPE(THIS.obj_4c_Opt_Tipo) != "O"
2119: 			RETURN
2120: 		ENDIF
2121: 		THIS.this_oBusinessObject.CarregarTiposEtiqueta()
2122: 		IF !USED("cursor_4c_TiposEtq")
2123: 			RETURN
2124: 		ENDIF
2125: 		SELECT cursor_4c_TiposEtq
2126: 		LOCAL loc_nCount, loc_nTopo, loc_i, loc_cCaption
2127: 		loc_nCount = RECCOUNT("cursor_4c_TiposEtq")
2128: 		IF loc_nCount = 0
2129: 			RETURN
2130: 		ENDIF
2131: 		*-- Adiciona botoes conforme tipos retornados pelo BO (1 por linha)
2132: 		WITH THIS.obj_4c_Opt_Tipo
2133: 			.ButtonCount = loc_nCount
2134: 			loc_nTopo    = 10
2135: 			GO TOP IN cursor_4c_TiposEtq
2136: 			FOR loc_i = 1 TO loc_nCount
2137: 				SELECT cursor_4c_TiposEtq
2138: 				loc_cCaption = ALLTRIM(NVL(cursor_4c_TiposEtq.cEtiquetas, "Tipo " + TRANSFORM(loc_i)))
2139: 				WITH .Buttons(loc_i)
2140: 					.BackStyle = 0
2141: 					.Caption   = loc_cCaption
2142: 					.Tag       = TRANSFORM(NVL(cursor_4c_TiposEtq.nTipos, loc_i))
2143: 					.Height    = 16
2144: 					.Left      = 9
2145: 					.Style     = 0
2146: 					.Top       = loc_nTopo
2147: 					.Width     = 197
2148: 					.ForeColor = RGB(90, 90, 90)
2149: 				ENDWITH
2150: 				loc_nTopo = loc_nTopo + 18
2151: 				SKIP IN cursor_4c_TiposEtq
2152: 			ENDFOR
2153: 			.Height = loc_nTopo + 10
2154: 		ENDWITH
2155: 		USE IN cursor_4c_TiposEtq
2156: 	ENDPROC
2157: 
2158: 	*====================================================================
2159: 	* AplicarConfiguracoes - Carrega impressoras e preenche controles
2160: 	*====================================================================
2161: 	PROTECTED PROCEDURE AplicarConfiguracoes()
2162: 		IF VARTYPE(THIS.this_oBusinessObject) != "O"
2163: 			RETURN
2164: 		ENDIF
2165: 		*-- Carrega lista de impressoras no ComboBox
2166: 		THIS.this_oBusinessObject.CarregarImpressoras()
2167: 		IF PEMSTATUS(THIS, "cbo_4c_GetPrinter", 5) AND VARTYPE(THIS.cbo_4c_GetPrinter) = "O"
2168: 			THIS.cbo_4c_GetPrinter.RowSourceType = 2
2169: 			THIS.cbo_4c_GetPrinter.RowSource     = "cursor_4c_SigCdmp"
2170: 			IF USED("cursor_4c_SigCdmp") AND RECCOUNT("cursor_4c_SigCdmp") > 0
2171: 				THIS.cbo_4c_GetPrinter.Requery()
2172: 			ENDIF
2173: 			*-- Seleciona impressora padrao do BO
2174: 			IF !EMPTY(THIS.this_oBusinessObject.this_cNomeImp)
2175: 				THIS.cbo_4c_GetPrinter.Value = ALLTRIM(THIS.this_oBusinessObject.this_cNomeImp)
2176: 			ENDIF
2177: 		ENDIF
2178: 		*-- Preenche spinners com valores das configuracoes lidas pelo BO
2179: 		IF PEMSTATUS(THIS, "cnt_4c_Impressora", 5) AND VARTYPE(THIS.cnt_4c_Impressora) = "O"
2180: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjVerts", 5)
2181: 				THIS.cnt_4c_Impressora.spn_4c_AjVerts.Value = THIS.this_oBusinessObject.this_nAjVerts
2182: 			ENDIF
2183: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjHorzs", 5)
2184: 				THIS.cnt_4c_Impressora.spn_4c_AjHorzs.Value = THIS.this_oBusinessObject.this_nAjHorzs
2185: 			ENDIF
2186: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjDenss", 5)
2187: 				THIS.cnt_4c_Impressora.spn_4c_AjDenss.Value = THIS.this_oBusinessObject.this_nAjDenss
2188: 			ENDIF
2189: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjVelos", 5)
2190: 				THIS.cnt_4c_Impressora.spn_4c_AjVelos.Value = THIS.this_oBusinessObject.this_nAjVelos
2191: 			ENDIF
2192: 			*-- Tipo de impressora
2193: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "obj_4c_OpcaoImp", 5) AND ;
2194: 			   VARTYPE(THIS.cnt_4c_Impressora.obj_4c_OpcaoImp) = "O"
2195: 				THIS.cnt_4c_Impressora.obj_4c_OpcaoImp.Value = THIS.this_oBusinessObject.this_nTpImp
2196: 			ENDIF
2197: 		ENDIF
2198: 		*-- Tipo de etiqueta padrao
2199: 		IF PEMSTATUS(THIS, "obj_4c_Opt_Tipo", 5) AND VARTYPE(THIS.obj_4c_Opt_Tipo) = "O"
2200: 			THIS.obj_4c_Opt_Tipo.Value = THIS.this_oBusinessObject.this_nTpEtiPadrao
2201: 		ENDIF
2202: 		*-- Separadora padrao (EtqSeps de SigCdPac, carregado em CarregarConfiguracoes)
2203: 		IF PEMSTATUS(THIS, "obj_4c_OptSeparador", 5) AND VARTYPE(THIS.obj_4c_OptSeparador) = "O"
2204: 			THIS.obj_4c_OptSeparador.Value = IIF(THIS.this_oBusinessObject.this_lImpSepar, 1, 2)
2205: 		ENDIF
2206: 	ENDPROC
2207: 
2208: 	*====================================================================
2209: 	* ObjOptTipoChange - Atualiza tipo etiqueta no BO (PUBLIC p/ BINDEVENT)
2210: 	*====================================================================
2211: 	PROCEDURE ObjOptTipoChange()
2212: 		IF VARTYPE(THIS.this_oBusinessObject) != "O"
2213: 			RETURN
2214: 		ENDIF
2215: 		IF !PEMSTATUS(THIS, "obj_4c_Opt_Tipo", 5) OR VARTYPE(THIS.obj_4c_Opt_Tipo) != "O"
2216: 			RETURN
2217: 		ENDIF
2218: 		LOCAL loc_nSel, loc_cTag
2219: 		loc_nSel = THIS.obj_4c_Opt_Tipo.Value
2220: 		IF loc_nSel >= 1 AND loc_nSel <= THIS.obj_4c_Opt_Tipo.ButtonCount
2221: 			loc_cTag = ALLTRIM(NVL(THIS.obj_4c_Opt_Tipo.Buttons(loc_nSel).Tag, ""))
2222: 			IF !EMPTY(loc_cTag) AND VAL(loc_cTag) > 0
2223: 				THIS.this_oBusinessObject.this_nTpEti = VAL(loc_cTag)
2224: 			ELSE
2225: 				THIS.this_oBusinessObject.this_nTpEti = loc_nSel
2226: 			ENDIF
2227: 		ENDIF
2228: 	ENDPROC
2229: 
2230: 	*====================================================================
2231: 	* ObjOpcaoImpChange - Atualiza tipo impressora no BO (PUBLIC p/ BINDEVENT)
2232: 	*====================================================================
2233: 	PROCEDURE ObjOpcaoImpChange()
2234: 		IF VARTYPE(THIS.this_oBusinessObject) != "O"
2235: 			RETURN
2236: 		ENDIF
2237: 		IF !PEMSTATUS(THIS, "cnt_4c_Impressora", 5)
2238: 			RETURN
2239: 		ENDIF
2240: 		IF !PEMSTATUS(THIS.cnt_4c_Impressora, "obj_4c_OpcaoImp", 5)
2241: 			RETURN
2242: 		ENDIF
2243: 		THIS.this_oBusinessObject.this_nTpImp = ;
2244: 			NVL(THIS.cnt_4c_Impressora.obj_4c_OpcaoImp.Value, 1)
2245: 	ENDPROC
2246: 
2247: 	*====================================================================
2248: 	* CboGetPrinterChange - Atualiza impressora no BO (PUBLIC p/ BINDEVENT)
2249: 	*====================================================================
2250: 	PROCEDURE CboGetPrinterChange()
2251: 		IF VARTYPE(THIS.this_oBusinessObject) != "O"
2252: 			RETURN
2253: 		ENDIF
2254: 		IF !PEMSTATUS(THIS, "cbo_4c_GetPrinter", 5) OR VARTYPE(THIS.cbo_4c_GetPrinter) != "O"
2255: 			RETURN
2256: 		ENDIF
2257: 		THIS.this_oBusinessObject.this_cNomeImp = ;
2258: 			ALLTRIM(NVL(THIS.cbo_4c_GetPrinter.Value, ""))
2259: 	ENDPROC
2260: 
2261: 	*====================================================================
2262: 	* TxtNumesKeyPress - Valida numero do documento (PUBLIC p/ BINDEVENT)
2263: 	*====================================================================
2264: 	PROCEDURE TxtNumesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2265: 		IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
2266: 			RETURN
2267: 		ENDIF
2268: 		IF !PEMSTATUS(THIS, "txt_4c_Numes", 5) OR VARTYPE(THIS.txt_4c_Numes) != "O"
2269: 			RETURN
2270: 		ENDIF
2271: 		LOCAL loc_nNumes
2272: 		loc_nNumes = NVL(THIS.txt_4c_Numes.Value, 0)
2273: 		IF loc_nNumes <= 0
2274: 			MsgAviso("Informe o n" + CHR(250) + "mero do documento.", ;
2275: 			         "Aten" + CHR(231) + CHR(227) + "o")
2276: 			THIS.txt_4c_Numes.SetFocus()
2277: 			RETURN
2278: 		ENDIF
2279: 		IF PEMSTATUS(THIS, "txt_4c_Lpreco", 5) AND VARTYPE(THIS.txt_4c_Lpreco) = "O"
2280: 			THIS.txt_4c_Lpreco.SetFocus()
2281: 		ENDIF
2282: 	ENDPROC
2283: 
2284: 	*====================================================================
2285: 	* ChkListaClick - Valida preenchimento da lista de precos (PUBLIC p/ BINDEVENT)
2286: 	*====================================================================
2287: 	PROCEDURE ChkListaClick()
2288: 		IF !PEMSTATUS(THIS, "chk_4c_Lista", 5) OR VARTYPE(THIS.chk_4c_Lista) != "O"
2289: 			RETURN
2290: 		ENDIF
2291: 		IF THIS.chk_4c_Lista.Value != 1
2292: 			RETURN
2293: 		ENDIF
2294: 		IF !PEMSTATUS(THIS, "txt_4c_Lpreco", 5) OR VARTYPE(THIS.txt_4c_Lpreco) != "O"
2295: 			RETURN
2296: 		ENDIF
2297: 		IF EMPTY(ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value, "")))
2298: 			MsgAviso("Informe a lista de pre" + CHR(231) + "os para usar este filtro.", ;
2299: 			         "Aten" + CHR(231) + CHR(227) + "o")
2300: 			THIS.txt_4c_Lpreco.SetFocus()
2301: 		ENDIF
2302: 	ENDPROC
2303: 
2304: 	*====================================================================
2305: 	* ChkPrecioClick - Recarrega precos ao ativar filtro (PUBLIC p/ BINDEVENT)
2306: 	*====================================================================
2307: 	PROCEDURE ChkPrecioClick()
2308: 		IF !PEMSTATUS(THIS, "chk_4c_Precio", 5) OR VARTYPE(THIS.chk_4c_Precio) != "O"
2309: 			RETURN
2310: 		ENDIF
2311: 		IF THIS.chk_4c_Precio.Value = 1
2312: 			THIS.AtualizarPrecoPorLista()
2313: 		ENDIF
2314: 	ENDPROC
2315: 
2316: 	*====================================================================
2317: 	* FormParaBO - Copia todos os campos do form para o BO
2318: 	*====================================================================
2319: 	PROCEDURE FormParaBO()
2320: 		IF VARTYPE(THIS.this_oBusinessObject) != "O"
2321: 			RETURN
2322: 		ENDIF
2323: 		THIS.this_oBusinessObject.this_cEmps  = ALLTRIM(NVL(THIS.txt_4c_Emps.Value,  ""))
2324: 		THIS.this_oBusinessObject.this_cDopes = ALLTRIM(NVL(THIS.txt_4c_Dopes.Value, ""))
2325: 		IF PEMSTATUS(THIS, "txt_4c_Numes", 5) AND VARTYPE(THIS.txt_4c_Numes) = "O"
2326: 			THIS.this_oBusinessObject.this_nNumes = NVL(THIS.txt_4c_Numes.Value, 0)
2327: 		ENDIF
2328: 		THIS.this_oBusinessObject.this_cLpreco  = ALLTRIM(NVL(THIS.txt_4c_Lpreco.Value,  ""))
2329: 		THIS.this_oBusinessObject.this_cLpreco2 = ALLTRIM(NVL(THIS.txt_4c_LPreco2.Value, ""))
2330: 		IF PEMSTATUS(THIS, "obj_4c_Opt_Tipo", 5) AND VARTYPE(THIS.obj_4c_Opt_Tipo) = "O"
2331: 			THIS.this_oBusinessObject.this_nTpEti = NVL(THIS.obj_4c_Opt_Tipo.Value, 1)
2332: 		ENDIF
2333: 		IF PEMSTATUS(THIS, "cnt_4c_Impressora", 5) AND VARTYPE(THIS.cnt_4c_Impressora) = "O"
2334: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "obj_4c_OpcaoImp", 5)
2335: 				THIS.this_oBusinessObject.this_nTpImp = ;
2336: 					NVL(THIS.cnt_4c_Impressora.obj_4c_OpcaoImp.Value, 1)
2337: 			ENDIF
2338: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjVerts", 5)
2339: 				THIS.this_oBusinessObject.this_nAjVerts = ;
2340: 					NVL(THIS.cnt_4c_Impressora.spn_4c_AjVerts.Value, 0)
2341: 			ENDIF
2342: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjHorzs", 5)
2343: 				THIS.this_oBusinessObject.this_nAjHorzs = ;
2344: 					NVL(THIS.cnt_4c_Impressora.spn_4c_AjHorzs.Value, 0)
2345: 			ENDIF
2346: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjDenss", 5)
2347: 				THIS.this_oBusinessObject.this_nAjDenss = ;
2348: 					NVL(THIS.cnt_4c_Impressora.spn_4c_AjDenss.Value, 0)
2349: 			ENDIF
2350: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjVelos", 5)
2351: 				THIS.this_oBusinessObject.this_nAjVelos = ;
2352: 					NVL(THIS.cnt_4c_Impressora.spn_4c_AjVelos.Value, 0)
2353: 			ENDIF
2354: 		ENDIF
2355: 		IF PEMSTATUS(THIS, "cbo_4c_GetPrinter", 5) AND VARTYPE(THIS.cbo_4c_GetPrinter) = "O"
2356: 			THIS.this_oBusinessObject.this_cNomeImp = ;
2357: 				ALLTRIM(NVL(THIS.cbo_4c_GetPrinter.Value, ""))
2358: 		ENDIF
2359: 		IF PEMSTATUS(THIS, "obj_4c_OptPreco", 5) AND VARTYPE(THIS.obj_4c_OptPreco) = "O"

*-- Linhas 2379 a 2422:
2379: 	*====================================================================
2380: 	* BOParaForm - Aplica propriedades do BO nos controles do form
2381: 	*====================================================================
2382: 	PROCEDURE BOParaForm()
2383: 		IF VARTYPE(THIS.this_oBusinessObject) != "O"
2384: 			RETURN
2385: 		ENDIF
2386: 		THIS.txt_4c_Emps.Value  = NVL(THIS.this_oBusinessObject.this_cEmps,  "")
2387: 		THIS.txt_4c_Dopes.Value = NVL(THIS.this_oBusinessObject.this_cDopes, "")
2388: 		IF PEMSTATUS(THIS, "txt_4c_Numes", 5) AND VARTYPE(THIS.txt_4c_Numes) = "O"
2389: 			THIS.txt_4c_Numes.Value = NVL(THIS.this_oBusinessObject.this_nNumes, 0)
2390: 		ENDIF
2391: 		THIS.txt_4c_Lpreco.Value  = NVL(THIS.this_oBusinessObject.this_cLpreco,  "")
2392: 		THIS.txt_4c_LPreco2.Value = NVL(THIS.this_oBusinessObject.this_cLpreco2, "")
2393: 		IF PEMSTATUS(THIS, "obj_4c_Opt_Tipo", 5) AND VARTYPE(THIS.obj_4c_Opt_Tipo) = "O"
2394: 			THIS.obj_4c_Opt_Tipo.Value = NVL(THIS.this_oBusinessObject.this_nTpEti, 1)
2395: 		ENDIF
2396: 		IF PEMSTATUS(THIS, "cnt_4c_Impressora", 5) AND VARTYPE(THIS.cnt_4c_Impressora) = "O"
2397: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "obj_4c_OpcaoImp", 5)
2398: 				THIS.cnt_4c_Impressora.obj_4c_OpcaoImp.Value = ;
2399: 					NVL(THIS.this_oBusinessObject.this_nTpImp, 1)
2400: 			ENDIF
2401: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjVerts", 5)
2402: 				THIS.cnt_4c_Impressora.spn_4c_AjVerts.Value = ;
2403: 					NVL(THIS.this_oBusinessObject.this_nAjVerts, 0)
2404: 			ENDIF
2405: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjHorzs", 5)
2406: 				THIS.cnt_4c_Impressora.spn_4c_AjHorzs.Value = ;
2407: 					NVL(THIS.this_oBusinessObject.this_nAjHorzs, 0)
2408: 			ENDIF
2409: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjDenss", 5)
2410: 				THIS.cnt_4c_Impressora.spn_4c_AjDenss.Value = ;
2411: 					NVL(THIS.this_oBusinessObject.this_nAjDenss, 20)
2412: 			ENDIF
2413: 			IF PEMSTATUS(THIS.cnt_4c_Impressora, "spn_4c_AjVelos", 5)
2414: 				THIS.cnt_4c_Impressora.spn_4c_AjVelos.Value = ;
2415: 					NVL(THIS.this_oBusinessObject.this_nAjVelos, 3)
2416: 			ENDIF
2417: 		ENDIF
2418: 		IF PEMSTATUS(THIS, "cbo_4c_GetPrinter", 5) AND VARTYPE(THIS.cbo_4c_GetPrinter) = "O"
2419: 			THIS.cbo_4c_GetPrinter.Value = NVL(THIS.this_oBusinessObject.this_cNomeImp, "")
2420: 		ENDIF
2421: 		IF PEMSTATUS(THIS, "obj_4c_OptPreco", 5) AND VARTYPE(THIS.obj_4c_OptPreco) = "O"
2422: 			THIS.obj_4c_OptPreco.Value = NVL(THIS.this_oBusinessObject.this_nImpPreco, 1)

*-- Linhas 2441 a 2484:
2441: 	*====================================================================
2442: 	* HabilitarCampos - Habilita ou desabilita controles de entrada
2443: 	*====================================================================
2444: 	PROCEDURE HabilitarCampos(par_lHabilitar)
2445: 		IF PEMSTATUS(THIS, "txt_4c_Emps", 5) AND VARTYPE(THIS.txt_4c_Emps) = "O"
2446: 			THIS.txt_4c_Emps.Enabled = par_lHabilitar
2447: 		ENDIF
2448: 		IF PEMSTATUS(THIS, "txt_4c_Dopes", 5) AND VARTYPE(THIS.txt_4c_Dopes) = "O"
2449: 			THIS.txt_4c_Dopes.Enabled = par_lHabilitar
2450: 		ENDIF
2451: 		IF PEMSTATUS(THIS, "txt_4c_Numes", 5) AND VARTYPE(THIS.txt_4c_Numes) = "O"
2452: 			THIS.txt_4c_Numes.Enabled = par_lHabilitar
2453: 		ENDIF
2454: 		IF PEMSTATUS(THIS, "txt_4c_Lpreco", 5) AND VARTYPE(THIS.txt_4c_Lpreco) = "O"
2455: 			THIS.txt_4c_Lpreco.Enabled = par_lHabilitar
2456: 		ENDIF
2457: 		IF PEMSTATUS(THIS, "txt_4c_LPreco2", 5) AND VARTYPE(THIS.txt_4c_LPreco2) = "O"
2458: 			THIS.txt_4c_LPreco2.Enabled = par_lHabilitar
2459: 		ENDIF
2460: 		IF PEMSTATUS(THIS, "chk_4c_Lista", 5) AND VARTYPE(THIS.chk_4c_Lista) = "O"
2461: 			THIS.chk_4c_Lista.Enabled = par_lHabilitar
2462: 		ENDIF
2463: 		IF PEMSTATUS(THIS, "chk_4c_Precio", 5) AND VARTYPE(THIS.chk_4c_Precio) = "O"
2464: 			THIS.chk_4c_Precio.Enabled = par_lHabilitar
2465: 		ENDIF
2466: 		IF PEMSTATUS(THIS, "obj_4c_OptPreco", 5) AND VARTYPE(THIS.obj_4c_OptPreco) = "O"
2467: 			THIS.obj_4c_OptPreco.Enabled = par_lHabilitar
2468: 		ENDIF
2469: 		IF PEMSTATUS(THIS, "obj_4c_OptSeparador", 5) AND VARTYPE(THIS.obj_4c_OptSeparador) = "O"
2470: 			THIS.obj_4c_OptSeparador.Enabled = par_lHabilitar
2471: 		ENDIF
2472: 		IF PEMSTATUS(THIS, "obj_4c_OptPeso", 5) AND VARTYPE(THIS.obj_4c_OptPeso) = "O"
2473: 			THIS.obj_4c_OptPeso.Enabled = par_lHabilitar
2474: 		ENDIF
2475: 		IF PEMSTATUS(THIS, "obj_4c_OptCompos", 5) AND VARTYPE(THIS.obj_4c_OptCompos) = "O"
2476: 			THIS.obj_4c_OptCompos.Enabled = par_lHabilitar
2477: 		ENDIF
2478: 		IF PEMSTATUS(THIS, "obj_4c_OptOrdem", 5) AND VARTYPE(THIS.obj_4c_OptOrdem) = "O"
2479: 			THIS.obj_4c_OptOrdem.Enabled = par_lHabilitar
2480: 		ENDIF
2481: 		IF PEMSTATUS(THIS, "obj_4c_Opt_Tipo", 5) AND VARTYPE(THIS.obj_4c_Opt_Tipo) = "O"
2482: 			THIS.obj_4c_Opt_Tipo.Enabled = par_lHabilitar
2483: 		ENDIF
2484: 		IF PEMSTATUS(THIS, "cnt_4c_Impressora", 5) AND VARTYPE(THIS.cnt_4c_Impressora) = "O"

*-- Linhas 2492 a 2535:
2492: 	*====================================================================
2493: 	* LimparCampos - Reseta filtros e zera a lista de etiquetas
2494: 	*====================================================================
2495: 	PROCEDURE LimparCampos()
2496: 		IF PEMSTATUS(THIS, "txt_4c_Emps", 5) AND VARTYPE(THIS.txt_4c_Emps) = "O"
2497: 			THIS.txt_4c_Emps.Value = ""
2498: 		ENDIF
2499: 		IF PEMSTATUS(THIS, "txt_4c_Dopes", 5) AND VARTYPE(THIS.txt_4c_Dopes) = "O"
2500: 			THIS.txt_4c_Dopes.Value = ""
2501: 		ENDIF
2502: 		IF PEMSTATUS(THIS, "txt_4c_Numes", 5) AND VARTYPE(THIS.txt_4c_Numes) = "O"
2503: 			THIS.txt_4c_Numes.Value = 0
2504: 		ENDIF
2505: 		IF PEMSTATUS(THIS, "txt_4c_Lpreco", 5) AND VARTYPE(THIS.txt_4c_Lpreco) = "O"
2506: 			THIS.txt_4c_Lpreco.Value = ""
2507: 		ENDIF
2508: 		IF PEMSTATUS(THIS, "txt_4c_LPreco2", 5) AND VARTYPE(THIS.txt_4c_LPreco2) = "O"
2509: 			THIS.txt_4c_LPreco2.Value = ""
2510: 		ENDIF
2511: 		IF PEMSTATUS(THIS, "lbl_4c_DEmps", 5) AND VARTYPE(THIS.lbl_4c_DEmps) = "O"
2512: 			THIS.lbl_4c_DEmps.Caption = ""
2513: 		ENDIF
2514: 		IF PEMSTATUS(THIS, "chk_4c_Lista", 5) AND VARTYPE(THIS.chk_4c_Lista) = "O"
2515: 			THIS.chk_4c_Lista.Value = 0
2516: 		ENDIF
2517: 		IF PEMSTATUS(THIS, "chk_4c_Precio", 5) AND VARTYPE(THIS.chk_4c_Precio) = "O"
2518: 			THIS.chk_4c_Precio.Value = 0
2519: 		ENDIF
2520: 		IF PEMSTATUS(THIS, "txt_4c_Cpros", 5) AND VARTYPE(THIS.txt_4c_Cpros) = "O"
2521: 			THIS.txt_4c_Cpros.Value = ""
2522: 		ENDIF
2523: 		IF PEMSTATUS(THIS, "txt_4c_Dpros", 5) AND VARTYPE(THIS.txt_4c_Dpros) = "O"
2524: 			THIS.txt_4c_Dpros.Value = ""
2525: 		ENDIF
2526: 		IF PEMSTATUS(THIS, "txt_4c_Qtds", 5) AND VARTYPE(THIS.txt_4c_Qtds) = "O"
2527: 			THIS.txt_4c_Qtds.Value = 0
2528: 		ENDIF
2529: 		IF USED("cursor_4c_Etiquetas")
2530: 			SELECT cursor_4c_Etiquetas
2531: 			ZAP
2532: 			APPEND BLANK
2533: 			GO TOP
2534: 		ENDIF
2535: 		IF PEMSTATUS(THIS, "grd_4c_Etiquetas", 5) AND VARTYPE(THIS.grd_4c_Etiquetas) = "O"

*-- Linhas 2543 a 2585:
2543: 	*====================================================================
2544: 	* CarregarLista - Reposiciona no topo e atualiza grid (OPERACIONAL)
2545: 	*====================================================================
2546: 	PROCEDURE CarregarLista()
2547: 		IF !USED("cursor_4c_Etiquetas")
2548: 			RETURN
2549: 		ENDIF
2550: 		SELECT cursor_4c_Etiquetas
2551: 		GO TOP
2552: 		IF PEMSTATUS(THIS, "grd_4c_Etiquetas", 5) AND VARTYPE(THIS.grd_4c_Etiquetas) = "O"
2553: 			THIS.grd_4c_Etiquetas.Refresh()
2554: 		ENDIF
2555: 	ENDPROC
2556: 
2557: 	*====================================================================
2558: 	* AjustarBotoesPorModo - Stub (OPERACIONAL nao tem modos CRUD)
2559: 	*====================================================================
2560: 	PROCEDURE AjustarBotoesPorModo()
2561: 		RETURN
2562: 	ENDPROC
2563: 
2564: 	*====================================================================
2565: 	* BtnBuscarClick - Carrega itens da lista por empresa/operacao/numes
2566: 	*====================================================================
2567: 	PROCEDURE BtnBuscarClick()
2568: 		THIS.CarregarItensDaLista()
2569: 	ENDPROC
2570: 
2571: 	*====================================================================
2572: 	* BtnSalvarClick - Equivale a imprimir no contexto OPERACIONAL
2573: 	*====================================================================
2574: 	PROCEDURE BtnSalvarClick()
2575: 		THIS.BtnImprimirClick()
2576: 	ENDPROC
2577: 
2578: 	*====================================================================
2579: 	* BtnCancelarClick - Limpa campos e zera lista (OPERACIONAL)
2580: 	*====================================================================
2581: 	PROCEDURE BtnCancelarClick()
2582: 		THIS.LimparCampos()
2583: 	ENDPROC
2584: 
2585: ENDDEFINE


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

