# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (5)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.AbrirLookupCanonico()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.CriarBarraProgresso()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Produtos' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprccp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3514 linhas total):

*-- Linhas 11 a 357:
11: *   CODE -> arquitetura em camadas (FormBase / sigprccpBO)
12: *
13: * CHAMADA:
14: *   loForm = CREATEOBJECT("Formsigprccp", lAutomatico)
15: *   loForm.Show()
16: *==============================================================================*
17: 
18: DEFINE CLASS Formsigprccp AS FormBase
19: 
20: 	*-- Dimensoes identicas ao legado
21: 	Height       = 600
22: 	Width        = 1000
23: 	BorderStyle  = 2
24: 	AutoCenter   = .T.
25: 	TitleBar     = 0
26: 	ShowWindow   = 1
27: 	WindowType   = 1
28: 	ControlBox   = .F.
29: 	Closable     = .F.
30: 	MaxButton    = .F.
31: 	MinButton    = .F.
32: 	ClipControls = .F.
33: 	DataSession  = 2
34: 	ShowTips     = .T.
35: 
36: 	*-- Propriedades do Form
37: 	this_cTituloForm = ""
38: 
39: 	*-- Flag operacional (mirror do "automatico" do legado - controla o modo
40: 	*-- ProcessaAutomatico, percorrendo os presets de SigCdCcp sem interacao)
41: 	this_lAutomatico = .F.
42: 
43: 	*-- Guarda de disparo unico do lote automatico. O legado chama
44: 	*-- "=ThisForm.ProcessaAutomatico()" na ULTIMA linha do Init, mas ali esse
45: 	*-- metodo termina em "Sair.Cancela.Click()" -> Release: liberar o form
46: 	*-- DENTRO do Init derrubaria a referencia e CREATEOBJECT devolveria .F.,
47: 	*-- fazendo o menu acusar "erro ao criar formulario" no fim de um lote que
48: 	*-- rodou certo. Por isso o disparo fica no Activate (primeira ativacao,
49: 	*-- depois do Show), onde o Release fecha a tela normalmente - mesmo
50: 	*-- comportamento observavel: abre, processa o lote, fecha sozinho.
51: 	this_lAutomaticoDisparado = .F.
52: 
53: 	*====================================================================
54: 	* Init - Recebe o flag Automatico (equivalente a "Parameters pAuto"
55: 	* do legado) e delega o restante para FormBase.Init()/InicializarForm()
56: 	*====================================================================
57: 	PROCEDURE Init()
58: 		LPARAMETERS par_lAutomatico
59: 
60: 		THIS.this_lAutomatico = IIF(VARTYPE(par_lAutomatico) = "L", par_lAutomatico, .F.)
61: 		THIS.this_cTituloForm = "Rec" + CHR(225) + "lculo de Pre" + CHR(231) + "os"
62: 
63: 		*-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
64: 		RETURN DODEFAULT()
65: 	ENDPROC
66: 
67: 	*====================================================================
68: 	* Activate - Dispara o lote automatico UMA unica vez, na primeira
69: 	* ativacao da janela. Equivale a "If ThisForm.Automatico /
70: 	* =ThisForm.ProcessaAutomatico()" da ultima linha do Init legado (ver
71: 	* this_lAutomaticoDisparado para o motivo de nao ser no Init).
72: 	*
73: 	* O lote nao roda em modo de teste/validacao automatizada: ali nao ha
74: 	* conexao valida e o objetivo eh apenas instanciar o form.
75: 	*====================================================================
76: 	PROCEDURE Activate()
77: 		IF THIS.this_lAutomatico AND !THIS.this_lAutomaticoDisparado
78: 			THIS.this_lAutomaticoDisparado = .T.
79: 
80: 			IF !((TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
81: 					(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI))
82: 				THIS.ProcessaAutomatico()
83: 			ENDIF
84: 		ENDIF
85: 	ENDPROC
86: 
87: 	*====================================================================
88: 	* InicializarForm - Cria o Business Object e monta a estrutura base
89: 	* (background + faixa de cabecalho). Grid, filtros e botoes ficam
90: 	* para as proximas fases.
91: 	*====================================================================
92: 	PROTECTED PROCEDURE InicializarForm()
93: 		LOCAL loc_lSucesso, loc_oErro
94: 		loc_lSucesso = .F.
95: 
96: 		TRY
97: 			*-- DataSession = 2 nasce com os SETs no DEFAULT do VFP9: o
98: 			*-- FormBase.Init() repoe apenas DATE/CENTURY, entao os dois SETs
99: 			*-- de que ESTE form depende tem de ser repostos aqui, DENTRO da
100: 			*-- datasession privada:
101: 			*--   SAFETY  - com SAFETY ON (default), o "Zap In cursor_4c_Produtos"
102: 			*--             de Processar/Atualizar abre o dialogo modal "Zap ...
103: 			*--             Are you sure?" e CONGELA a tela (o SET SAFETY OFF do
104: 			*--             main.prg roda na sessao 1 e nao alcanca esta).
105: 			*--   DELETED - com DELETED OFF (default), o "Delete For PVarias ..."
106: 			*--             do filtro de Variacao marca a linha mas ela CONTINUA
107: 			*--             aparecendo na grade (o SET DELETED ON do config.prg
108: 			*--             tambem so vale na sessao 1).
109: 			SET SAFETY OFF
110: 			SET DELETED ON
111: 
112: 			THIS.this_oBusinessObject = CREATEOBJECT("sigprccpBO")
113: 
114: 			IF VARTYPE(THIS.this_oBusinessObject) != "O"
115: 				MsgErro("Falha ao criar sigprccpBO", "Erro")
116: 			ELSE
117: 				THIS.this_oBusinessObject.this_lAutomatico = THIS.this_lAutomatico
118: 
119: 				THIS.ConfigurarPageFrame()
120: 				THIS.ConfigurarCabecalho()
121: 
122: 				THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.this_cTituloForm
123: 				THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.this_cTituloForm
124: 
125: 				*-- Campos de filtro (area "Filtros" do legado, acima da grade) -
126: 				*-- Fase 5 trouxe a 1a metade (Fornecedor/Linha/Grande Grupo/
127: 				*-- Grupo Venda/Grupo/Markup/Subgrupo/Encargo); Fase 6 completa
128: 				*-- a 2a metade (Unidade/Moeda/Variacao/Feitio/OpcaoMoeda/
129: 				*-- Situacao/Compra) + a area "Dados" (Reajuste/NovoMarkup/
130: 				*-- NovoEncargo/AtualizaVenda/Recalcula/NovoMkp) + TODOS os
131: 				*-- lookups (F4/Enter/Tab) das duas metades.
132: 				THIS.ConfigurarFiltrosParte1()
133: 				THIS.ConfigurarFiltrosParte2()
134: 				THIS.ConfigurarDados()
135: 				THIS.ConfigurarLookupsFiltros()
136: 
137: 				*-- Sincroniza a tela com os defaults que o BO declara
138: 				*-- (this_nOpcaoMoeda=1 / this_nSituacao=1 / this_nOpcaoCompra=3
139: 				*-- / this_nTipoRecalculo=1 / this_nAtualizaVenda=2, os mesmos
140: 				*-- valores que o SCX legado traz nos OptionGroups). Com isso o
141: 				*-- BO fica FONTE UNICA dos defaults e nao ha como tela e BO
142: 				*-- divergirem em silencio. BOParaForm termina chamando
143: 				*-- AtualizarEstadoCalculo, que aplica as regras de When do
144: 				*-- legado sobre Reajuste/NovoMarkup/Variacao/NovoMkp.
145: 				THIS.BOParaForm()
146: 
147: 				*-- Grade de produtos (Grd_Produto no legado) + botoes de acao
148: 				*-- (Sair/Impress?o/cmdSelemp/CmdApgEmp no legado) - criados
149: 				*-- DEPOIS do cabecalho para desenhar por cima dele na faixa
150: 				*-- superior (Top negativo dos botoes, igual ao SCX legado)
151: 				THIS.ConfigurarGridProdutos()
152: 				THIS.ConfigurarBotoesAcao()
153: 
154: 				*-- Foto do produto da linha corrente (Image FigJpg do legado).
155: 				*-- Criada DEPOIS da grade porque depende dela para ligar o
156: 				*-- AfterRowColChange que recarrega a imagem a cada linha.
157: 				THIS.ConfigurarFotoProduto()
158: 
159: 				*-- Estado inicial dos botoes de acao: "ThisForm.Sair.Atualiza.
160: 				*-- Enabled = .F." + "ThisForm.Impress?o.Enabled = .f." das duas
161: 				*-- ultimas linhas do Init legado. Passa pelo FUNIL para nao
162: 				*-- existir mais de um lugar decidindo o Enabled desses botoes.
163: 				THIS.this_cModoAtual = "LISTA"
164: 				THIS.AjustarBotoesPorModo()
165: 
166: 				THIS.TornarControlesVisiveis()
167: 				THIS.Refresh()
168: 
169: 				loc_lSucesso = .T.
170: 			ENDIF
171: 		CATCH TO loc_oErro
172: 			MsgErro("Erro ao inicializar Formsigprccp: " + loc_oErro.Message + ;
173: 				" Ln=" + TRANSFORM(loc_oErro.LineNo) + ;
174: 				" Proc=" + loc_oErro.Procedure, "Erro")
175: 		ENDTRY
176: 
177: 		RETURN loc_lSucesso
178: 	ENDPROC
179: 
180: 	*====================================================================
181: 	* ConfigurarPageFrame - Este form NAO tem PageFrame (o legado SIGPRCCP
182: 	* nao usa Pagina.Lista/Pagina.Dados - todos os controles sao filhos
183: 	* diretos do form). Metodo mantido apenas para aplicar o background
184: 	* do Framework legado (Picture = new_background.jpg no SCX).
185: 	*====================================================================
186: 	PROTECTED PROCEDURE ConfigurarPageFrame()
187: 		LOCAL loc_cImg
188: 		loc_cImg = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
189: 
190: 		IF FILE(loc_cImg)
191: 			THIS.Picture = loc_cImg
192: 		ENDIF
193: 	ENDPROC
194: 
195: 	*====================================================================
196: 	* ConfigurarCabecalho - Faixa cinza do topo (cntSombra no legado),
197: 	* com os dois labels sobrepostos (sombra preta + titulo branco).
198: 	* Valores identicos ao legado: Top=0, Left=0, Height=80.
199: 	*====================================================================
200: 	PROTECTED PROCEDURE ConfigurarCabecalho()
201: 		THIS.AddObject("cnt_4c_Cabecalho", "Container")
202: 		WITH THIS.cnt_4c_Cabecalho
203: 			.Top         = 0
204: 			.Left        = 0
205: 			.Width       = THIS.Width
206: 			.Height      = 80
207: 			.BackStyle   = 1
208: 			.BackColor   = RGB(100, 100, 100)
209: 			.BorderWidth = 0
210: 			.Visible     = .T.
211: 
212: 			.AddObject("lbl_4c_Sombra", "Label")
213: 			WITH .lbl_4c_Sombra
214: 				.AutoSize  = .F.
215: 				.Top       = 18
216: 				.Left      = 10
217: 				.Width     = THIS.Width
218: 				.Height    = 40
219: 				.FontBold  = .T.
220: 				.FontName  = "Tahoma"
221: 				.FontSize  = 18
222: 				.BackStyle = 0
223: 				.ForeColor = RGB(0, 0, 0)
224: 				.Caption   = " "
225: 			ENDWITH
226: 
227: 			.AddObject("lbl_4c_Titulo", "Label")
228: 			WITH .lbl_4c_Titulo
229: 				.AutoSize  = .F.
230: 				.Top       = 17
231: 				.Left      = 10
232: 				.Width     = THIS.Width
233: 				.Height    = 46
234: 				.FontBold  = .T.
235: 				.FontName  = "Tahoma"
236: 				.FontSize  = 18
237: 				.BackStyle = 0
238: 				.ForeColor = RGB(255, 255, 255)
239: 				.Caption   = " "
240: 			ENDWITH
241: 		ENDWITH
242: 	ENDPROC
243: 
244: 	*====================================================================
245: 	* TornarControlesVisiveis - Torna visiveis todos os controles do form
246: 	* e de seus containers, recursivamente. AddObject cria com Visible=.F.
247: 	* por padrao.
248: 	*====================================================================
249: 	PROTECTED PROCEDURE TornarControlesVisiveis()
250: 		LOCAL loc_nI, loc_oCtrl
251: 
252: 		FOR loc_nI = 1 TO THIS.ControlCount
253: 			loc_oCtrl = THIS.Controls(loc_nI)
254: 
255: 			*-- Controles cuja visibilidade NAO eh decidida aqui:
256: 			*--   IMG_4C_FIGJPG    - nasce OCULTA no legado (FigJpg.Visible =
257: 			*--                      .F.) e so aparece quando o produto da linha
258: 			*--                      corrente tem foto; quem decide eh
259: 			*--                      GrdProdutosAfterRowColChange. Mostrar aqui
260: 			*--                      deixaria um retangulo vazio permanente.
261: 			*--   CMD_4C_IMPRIMIR  - Visible vem de fChecaAcesso("SigPrCcp",
262: 			*--   SHP_4C_SHAPE2      "IMPRIMIR"), igual ao legado
263: 			*--                      (Impress?o.Visible = fChecaAcesso(...) no
264: 			*--                      Init); o Shape acompanha o botao. Forcar
265: 			*--                      .T. aqui REVERTERIA o controle de acesso e
266: 			*--                      exibiria o botao para quem nao pode
267: 			*--                      imprimir - sem erro nenhum na tela.
268: 			IF INLIST(UPPER(loc_oCtrl.Name), "IMG_4C_FIGJPG", "CMD_4C_IMPRIMIR", "SHP_4C_SHAPE2")
269: 				LOOP
270: 			ENDIF
271: 
272: 			IF PEMSTATUS(loc_oCtrl, "Visible", 5)
273: 				loc_oCtrl.Visible = .T.
274: 			ENDIF
275: 
276: 			IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
277: 				THIS.TornarSubControlesVisiveis(loc_oCtrl)
278: 			ENDIF
279: 		ENDFOR
280: 	ENDPROC
281: 
282: 	*====================================================================
283: 	* TornarSubControlesVisiveis - Recursao auxiliar de TornarControlesVisiveis
284: 	*====================================================================
285: 	PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
286: 		LOCAL loc_nI, loc_oCtrl
287: 
288: 		FOR loc_nI = 1 TO par_oContainer.ControlCount
289: 			loc_oCtrl = par_oContainer.Controls(loc_nI)
290: 
291: 			IF PEMSTATUS(loc_oCtrl, "Visible", 5)
292: 				loc_oCtrl.Visible = .T.
293: 			ENDIF
294: 
295: 			IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
296: 				THIS.TornarSubControlesVisiveis(loc_oCtrl)
297: 			ENDIF
298: 		ENDFOR
299: 	ENDPROC
300: 
301: 	*====================================================================
302: 	* ConfigurarFiltrosParte1 - Metade dos campos de filtro da area
303: 	* "Filtros" do legado (Label1, Top=94, acima da grade). Cada TextBox
304: 	* mapeia 1:1 para uma propriedade this_c*/this_n* ja declarada em
305: 	* sigprccpBO (Fases 1/2) e consumida por MontarWhereFiltros/
306: 	* AcrescentarFaixa. Posicoes/legendas EXATAS do layout.json (form flat
307: 	* 1000x600, sem PageFrame - nao ha offset de compensacao a aplicar).
308: 	*
309: 	* Nomes dos controles seguem o SIGNIFICADO exibido na tela (rotulo),
310: 	* nao a abreviacao do objeto legado - Say17 "Grupo Venda :" rotula
311: 	* GetColi/GetColf, que apesar do nome persistem como this_cColecaoI/F
312: 	* no BO (coluna real "Colecoes" da tabela SigCdCol).
313: 	*
314: 	* Sem BINDEVENT de lookup (F4/Enter/Tab) nesta fase - fica para a fase
315: 	* de lookups, quando as duas metades de campos ja existirem.
316: 	*====================================================================
317: 	PROTECTED PROCEDURE ConfigurarFiltrosParte1()
318: 		LOCAL loc_cFonte
319: 		loc_cFonte = "Tahoma"
320: 
321: 		*-- Titulo da secao "Filtros" (Label1 do legado) - Tahoma 12 Bold,
322: 		*-- ForeColor(90,90,90) EXATOS do dump (nao 36,84,155 - essa cor eh
323: 		*-- so para titulo de secao COM declaracao explicita no SCX legado)
324: 		THIS.AddObject("lbl_4c_TituloFiltros", "Label")
325: 		WITH THIS.lbl_4c_TituloFiltros
326: 			.Top       = 94
327: 			.Left      = 11
328: 			.Width     = 53
329: 			.Height    = 21
330: 			.AutoSize  = .F.
331: 			.BackStyle = 0
332: 			.FontName  = "Tahoma"
333: 			.FontSize  = 12
334: 			.FontBold  = .T.
335: 			.ForeColor = RGB(90, 90, 90)
336: 			.Caption   = "Filtros"
337: 		ENDWITH
338: 
339: 		*-- Fornecedor (getCFornecs/getDFornecs) - SigCdPro.ifors char(10).
340: 		*-- Lookup (fAcessoContas no legado) fica para fase posterior -
341: 		*-- txt_4c_DescFornecedor eh somente-leitura (When retorna .F. no
342: 		*-- legado: getDFornecs so eh preenchido pelo lookup).
343: 		THIS.AddObject("lbl_4c_Fornecedor", "Label")
344: 		WITH THIS.lbl_4c_Fornecedor
345: 			.Top       = 92
346: 			.Left      = 79
347: 			.Width     = 64
348: 			.Height    = 15
349: 			.AutoSize  = .F.
350: 			.BackStyle = 0
351: 			.FontName  = loc_cFonte
352: 			.FontSize  = 8
353: 			.ForeColor = RGB(90, 90, 90)
354: 			.Caption   = "Fornecedor :"
355: 		ENDWITH
356: 
357: 		THIS.AddObject("txt_4c_Fornecedor", "TextBox")

*-- Linhas 768 a 811:
768: 	* (Opc_Compra). Posicoes/legendas EXATAS do layout.json/dump do
769: 	* legado (form flat 1000x600, sem PageFrame - sem offset a aplicar).
770: 	*====================================================================
771: 	PROTECTED PROCEDURE ConfigurarFiltrosParte2()
772: 		LOCAL loc_cFonte
773: 		loc_cFonte = "Tahoma"
774: 
775: 		*-- Unidade (getCunii/getCunif) - SigCdPro.unids char(3)
776: 		THIS.AddObject("txt_4c_UnidadeI", "TextBox")
777: 		WITH THIS.txt_4c_UnidadeI
778: 			.Top       = 189
779: 			.Left      = 145
780: 			.Width     = 31
781: 			.Height    = 23
782: 			.FontName  = loc_cFonte
783: 			.FontSize  = 8
784: 			.MaxLength = 3
785: 			.Value     = ""
786: 		ENDWITH
787: 
788: 		THIS.AddObject("lbl_4c_Unidade", "Label")
789: 		WITH THIS.lbl_4c_Unidade
790: 			.Top       = 193
791: 			.Left      = 95
792: 			.Width     = 48
793: 			.Height    = 15
794: 			.AutoSize  = .F.
795: 			.BackStyle = 0
796: 			.FontName  = loc_cFonte
797: 			.FontSize  = 8
798: 			.ForeColor = RGB(90, 90, 90)
799: 			.Caption   = "Unidade :"
800: 		ENDWITH
801: 
802: 		THIS.AddObject("lbl_4c_AteUnidade", "Label")
803: 		WITH THIS.lbl_4c_AteUnidade
804: 			.Top       = 193
805: 			.Left      = 179
806: 			.Width     = 20
807: 			.Height    = 15
808: 			.AutoSize  = .F.
809: 			.BackStyle = 0
810: 			.FontName  = loc_cFonte
811: 			.FontSize  = 8

*-- Linhas 938 a 1022:
938: 
939: 		*-- Opcao de Moeda para a faixa acima (fwoption1 no legado):
940: 		*-- Ideal (Moedas) / Venda (Moevs) - Value=1 default ("Ideal")
941: 		THIS.AddObject("obj_4c_OpcaoMoeda", "OptionGroup")
942: 		WITH THIS.obj_4c_OpcaoMoeda
943: 			.Top         = 211
944: 			.Left        = 234
945: 			.Width       = 106
946: 			.Height      = 26
947: 			.ButtonCount = 2
948: 			.Value       = 1
949: 
950: 			WITH .Buttons(1)
951: 				.Caption  = "Ideal"
952: 				.Top      = 5
953: 				.Left     = 5
954: 				.FontName = loc_cFonte
955: 				.FontSize = 8
956: 			ENDWITH
957: 			WITH .Buttons(2)
958: 				.Caption  = "Venda"
959: 				.Top      = 6
960: 				.Left     = 53
961: 				.Width    = 48
962: 				.FontName = loc_cFonte
963: 				.FontSize = 8
964: 			ENDWITH
965: 		ENDWITH
966: 
967: 		*-- Situacao (Opc_situacao) - Ativos/Inativos/Todos - Value=1 default
968: 		THIS.AddObject("lbl_4c_Situacao", "Label")
969: 		WITH THIS.lbl_4c_Situacao
970: 			.Top       = 217
971: 			.Left      = 486
972: 			.Width     = 58
973: 			.Height    = 15
974: 			.AutoSize  = .F.
975: 			.BackStyle = 0
976: 			.FontName  = loc_cFonte
977: 			.FontSize  = 8
978: 			.ForeColor = RGB(90, 90, 90)
979: 			.Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
980: 		ENDWITH
981: 
982: 		THIS.AddObject("obj_4c_Situacao", "OptionGroup")
983: 		WITH THIS.obj_4c_Situacao
984: 			.Top         = 214
985: 			.Left        = 536
986: 			.Width       = 189
987: 			.Height      = 21
988: 			.ButtonCount = 3
989: 			.Value       = 1
990: 
991: 			WITH .Buttons(1)
992: 				.Caption  = "Ativos"
993: 				.Top      = 3
994: 				.Left     = 5
995: 				.FontName = loc_cFonte
996: 				.FontSize = 8
997: 			ENDWITH
998: 			WITH .Buttons(2)
999: 				.Caption  = "Inativos"
1000: 				.Top      = 2
1001: 				.Left     = 59
1002: 				.FontName = loc_cFonte
1003: 				.FontSize = 8
1004: 			ENDWITH
1005: 			WITH .Buttons(3)
1006: 				.Caption   = "Todos"
1007: 				.Top       = 2
1008: 				.Left      = 125
1009: 				.Width     = 61
1010: 				.Height    = 17
1011: 				.FontName  = loc_cFonte
1012: 				.FontSize  = 8
1013: 				.ForeColor = RGB(90, 90, 90)
1014: 			ENDWITH
1015: 		ENDWITH
1016: 
1017: 		*-- Compra (Opc_Compra) - Comprar/Nao Comprar/Todos - Value=3
1018: 		*-- default ("Todos") - EXATO do dump legado
1019: 		THIS.AddObject("lbl_4c_Compra", "Label")
1020: 		WITH THIS.lbl_4c_Compra
1021: 			.Top       = 237
1022: 			.Left      = 490

*-- Linhas 1030 a 1115:
1030: 			.Caption   = "Compra :"
1031: 		ENDWITH
1032: 
1033: 		THIS.AddObject("obj_4c_Compra", "OptionGroup")
1034: 		WITH THIS.obj_4c_Compra
1035: 			.Top         = 234
1036: 			.Left        = 536
1037: 			.Width       = 204
1038: 			.Height      = 21
1039: 			.ButtonCount = 3
1040: 			.Value       = 3
1041: 
1042: 			WITH .Buttons(1)
1043: 				.Caption  = "Comprar"
1044: 				.Top      = 3
1045: 				.Left     = 5
1046: 				.FontName = loc_cFonte
1047: 				.FontSize = 8
1048: 			ENDWITH
1049: 			WITH .Buttons(2)
1050: 				.Caption  = "N" + CHR(227) + "o Comprar"
1051: 				.Top      = 3
1052: 				.Left     = 67
1053: 				.FontName = loc_cFonte
1054: 				.FontSize = 8
1055: 			ENDWITH
1056: 			WITH .Buttons(3)
1057: 				.Caption   = "Todos"
1058: 				.Top       = 2
1059: 				.Left      = 152
1060: 				.Width     = 61
1061: 				.Height    = 17
1062: 				.FontName  = loc_cFonte
1063: 				.FontSize  = 8
1064: 				.ForeColor = RGB(90, 90, 90)
1065: 			ENDWITH
1066: 		ENDWITH
1067: 	ENDPROC
1068: 
1069: 	*====================================================================
1070: 	* ConfigurarDados - Area "Dados" do legado (Label2, abaixo da linha
1071: 	* separadora Line1): Reajuste, Novo Markup, Novo Encargo, Atualiza
1072: 	* Val.Venda (Opc_pven), Recalcula (Opc_Recalc, 8 opcoes) e Novo MKP
1073: 	* (getNewMkp - so habilitado quando Recalcula = Markup Custo/Venda).
1074: 	*====================================================================
1075: 	PROTECTED PROCEDURE ConfigurarDados()
1076: 		LOCAL loc_cFonte
1077: 		loc_cFonte = "Tahoma"
1078: 
1079: 		*-- Linha separadora (Line1 do legado)
1080: 		THIS.AddObject("lin_4c_Separador", "Line")
1081: 		WITH THIS.lin_4c_Separador
1082: 			.Top    = 258
1083: 			.Left   = 13
1084: 			.Width  = 738
1085: 			.Height = 0
1086: 		ENDWITH
1087: 
1088: 		*-- Titulo da secao "Dados" (Label2 do legado)
1089: 		THIS.AddObject("lbl_4c_TituloDados", "Label")
1090: 		WITH THIS.lbl_4c_TituloDados
1091: 			.Top       = 270
1092: 			.Left      = 12
1093: 			.Width     = 52
1094: 			.Height    = 21
1095: 			.AutoSize  = .F.
1096: 			.BackStyle = 0
1097: 			.FontName  = "Tahoma"
1098: 			.FontSize  = 12
1099: 			.FontBold  = .T.
1100: 			.ForeColor = RGB(90, 90, 90)
1101: 			.Caption   = "Dados"
1102: 		ENDWITH
1103: 
1104: 		*-- Reajuste (Get_Reajuste) - percentual de reajuste (1 + Value/100)
1105: 		THIS.AddObject("lbl_4c_Reajuste", "Label")
1106: 		WITH THIS.lbl_4c_Reajuste
1107: 			.Top       = 304
1108: 			.Left      = 91
1109: 			.Width     = 52
1110: 			.Height    = 15
1111: 			.AutoSize  = .F.
1112: 			.BackStyle = 0
1113: 			.FontName  = loc_cFonte
1114: 			.FontSize  = 8
1115: 			.ForeColor = RGB(90, 90, 90)

*-- Linhas 1173 a 1216:
1173: 			.Caption   = "Atualiza Val.Venda :"
1174: 		ENDWITH
1175: 
1176: 		THIS.AddObject("obj_4c_AtualizaVenda", "OptionGroup")
1177: 		WITH THIS.obj_4c_AtualizaVenda
1178: 			.Top         = 298
1179: 			.Left        = 544
1180: 			.Width       = 102
1181: 			.Height      = 27
1182: 			.ButtonCount = 2
1183: 			.Value       = 2
1184: 
1185: 			WITH .Buttons(1)
1186: 				.Caption  = "Sim"
1187: 				.Top      = 5
1188: 				.Left     = 5
1189: 				.FontName = loc_cFonte
1190: 				.FontSize = 8
1191: 			ENDWITH
1192: 			WITH .Buttons(2)
1193: 				.Caption   = "N" + CHR(227) + "o"
1194: 				.Top       = 5
1195: 				.Left      = 53
1196: 				.Width     = 44
1197: 				.Height    = 17
1198: 				.FontName  = loc_cFonte
1199: 				.FontSize  = 8
1200: 			ENDWITH
1201: 		ENDWITH
1202: 
1203: 		*-- Novo Markup (GetnMrk)
1204: 		THIS.AddObject("lbl_4c_NovoMarkup", "Label")
1205: 		WITH THIS.lbl_4c_NovoMarkup
1206: 			.Top       = 330
1207: 			.Left      = 71
1208: 			.Width     = 72
1209: 			.Height    = 15
1210: 			.AutoSize  = .F.
1211: 			.BackStyle = 0
1212: 			.FontName  = loc_cFonte
1213: 			.FontSize  = 8
1214: 			.ForeColor = RGB(90, 90, 90)
1215: 			.Caption   = "Novo Markup :"
1216: 		ENDWITH

*-- Linhas 1273 a 1316:
1273: 			.Caption   = "Recalcula :"
1274: 		ENDWITH
1275: 
1276: 		THIS.AddObject("obj_4c_Recalcula", "OptionGroup")
1277: 		WITH THIS.obj_4c_Recalcula
1278: 			.Top         = 258
1279: 			.Left        = 142
1280: 			.Width       = 439
1281: 			.Height      = 41
1282: 			.ButtonCount = 8
1283: 			.Value       = 1
1284: 
1285: 			WITH .Buttons(1)
1286: 				.Caption   = "Composi" + CHR(231) + CHR(227) + "o"
1287: 				.Top       = 5
1288: 				.Left      = 5
1289: 				.FontName  = loc_cFonte
1290: 				.FontSize  = 8
1291: 				.ForeColor = RGB(90, 90, 90)
1292: 			ENDWITH
1293: 			WITH .Buttons(2)
1294: 				.Caption   = "Custo Venda"
1295: 				.Top       = 5
1296: 				.Left      = 98
1297: 				.FontName  = loc_cFonte
1298: 				.FontSize  = 8
1299: 				.ForeColor = RGB(90, 90, 90)
1300: 			ENDWITH
1301: 			WITH .Buttons(3)
1302: 				.Caption   = "Ambos"
1303: 				.Top       = 5
1304: 				.Left      = 213
1305: 				.Width     = 50
1306: 				.Height    = 15
1307: 				.FontName  = loc_cFonte
1308: 				.FontSize  = 8
1309: 				.ForeColor = RGB(90, 90, 90)
1310: 			ENDWITH
1311: 			WITH .Buttons(4)
1312: 				.Caption   = "Peso Componentes"
1313: 				.Top       = 4
1314: 				.Left      = 312
1315: 				.Width     = 110
1316: 				.Height    = 15

*-- Linhas 1359 a 1869:
1359: 				.ForeColor = RGB(90, 90, 90)
1360: 			ENDWITH
1361: 		ENDWITH
1362: 		BINDEVENT(THIS.obj_4c_Recalcula, "InteractiveChange", THIS, "RecalculaValorAlterado")
1363: 		BINDEVENT(THIS.obj_4c_Recalcula, "Click", THIS, "RecalculaValorAlterado")
1364: 	ENDPROC
1365: 
1366: 	*====================================================================
1367: 	* ConfigurarLookupsFiltros - Registra os BINDEVENT de KeyPress
1368: 	* (Enter/Tab/F4) de TODOS os campos de filtro com lookup - das duas
1369: 	* metades (Fase 5 e Fase 6). Feito num metodo unico (em vez de dentro
1370: 	* de cada ConfigurarFiltrosParteN) para manter os lookups juntos e
1371: 	* faceis de auditar.
1372: 	*====================================================================
1373: 	PROTECTED PROCEDURE ConfigurarLookupsFiltros()
1374: 		*-- Fornecedor (getCFornecs/getDFornecs) - substitui fAcessoContas
1375: 		*-- (regra: fAcessoContas NAO deve ser usado como lookup de UX)
1376: 		BINDEVENT(THIS.txt_4c_Fornecedor, "KeyPress", THIS, "FornecedorKeyPress")
1377: 
1378: 		*-- Grupo (getCgrui/getCgruf) - SigCdGrp
1379: 		BINDEVENT(THIS.txt_4c_GrupoI, "KeyPress", THIS, "GrupoIKeyPress")
1380: 		BINDEVENT(THIS.txt_4c_GrupoF, "KeyPress", THIS, "GrupoFKeyPress")
1381: 
1382: 		*-- Grande Grupo (getMercI/getMercF) - SigCdGpr
1383: 		BINDEVENT(THIS.txt_4c_GrandeGrupoI, "KeyPress", THIS, "GrandeGrupoIKeyPress")
1384: 		BINDEVENT(THIS.txt_4c_GrandeGrupoF, "KeyPress", THIS, "GrandeGrupoFKeyPress")
1385: 
1386: 		*-- Grupo Venda / Colecao (GetColi/GetColf) - SigCdCol
1387: 		BINDEVENT(THIS.txt_4c_ColecaoI, "KeyPress", THIS, "ColecaoIKeyPress")
1388: 		BINDEVENT(THIS.txt_4c_ColecaoF, "KeyPress", THIS, "ColecaoFKeyPress")
1389: 
1390: 		*-- Subgrupo (getSgruI/getSgruF) - SigCdPsg
1391: 		BINDEVENT(THIS.txt_4c_SubGrupoI, "KeyPress", THIS, "SubGrupoIKeyPress")
1392: 		BINDEVENT(THIS.txt_4c_SubGrupoF, "KeyPress", THIS, "SubGrupoFKeyPress")
1393: 
1394: 		*-- Linha (GetLini/GetLinf) - SigCdLin
1395: 		BINDEVENT(THIS.txt_4c_LinhaI, "KeyPress", THIS, "LinhaIKeyPress")
1396: 		BINDEVENT(THIS.txt_4c_LinhaF, "KeyPress", THIS, "LinhaFKeyPress")
1397: 
1398: 		*-- Unidade (getCunii/getCunif) - SigCdUni
1399: 		BINDEVENT(THIS.txt_4c_UnidadeI, "KeyPress", THIS, "UnidadeIKeyPress")
1400: 		BINDEVENT(THIS.txt_4c_UnidadeF, "KeyPress", THIS, "UnidadeFKeyPress")
1401: 
1402: 		*-- Moeda (GetMoedai/GetMoedaf) - SigCdMoe
1403: 		BINDEVENT(THIS.txt_4c_MoedaI, "KeyPress", THIS, "MoedaIKeyPress")
1404: 		BINDEVENT(THIS.txt_4c_MoedaF, "KeyPress", THIS, "MoedaFKeyPress")
1405: 
1406: 		*-- Feitio (Get_Feitio) e Novo MKP (getNewMkp) - SigPrFti
1407: 		BINDEVENT(THIS.txt_4c_Feitio, "KeyPress", THIS, "FeitioKeyPress")
1408: 		BINDEVENT(THIS.txt_4c_NovoMkp, "KeyPress", THIS, "NovoMkpKeyPress")
1409: 
1410: 		*-- Reajuste/Novo Markup/Variacao - exclusao mutua (Valid legado)
1411: 		BINDEVENT(THIS.txt_4c_Reajuste, "KeyPress", THIS, "ReajusteKeyPress")
1412: 		BINDEVENT(THIS.txt_4c_NovoMarkup, "KeyPress", THIS, "NovoMarkupKeyPress")
1413: 		BINDEVENT(THIS.txt_4c_Variacao, "KeyPress", THIS, "VariacaoKeyPress")
1414: 
1415: 		*-- Novo Encargo - validacao simples (>= 0)
1416: 		BINDEVENT(THIS.txt_4c_NovoEncargo, "KeyPress", THIS, "NovoEncargoKeyPress")
1417: 	ENDPROC
1418: 
1419: 	*====================================================================
1420: 	* ExecutarLookupFiltro - Helper compartilhado pelos campos de faixa
1421: 	* que tem SOMENTE codigo na tela (sem TextBox de descricao ao lado):
1422: 	* tenta match EXATO por SQL e, sem achar, delega para o picker
1423: 	* canonico (AbrirLookupCanonico, FormBase.prg) filtrado pelo prefixo
1424: 	* digitado - equivalente ao fwBuscaExt(...) do legado.
1425: 	*====================================================================
1426: 	PROTECTED PROCEDURE ExecutarLookupFiltro(par_oTxt, par_cTabela, par_cCampoCod, par_cCampoDesc, par_cTitulo)
1427: 		LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_cCursor
1428: 		loc_cValor = ALLTRIM(UPPER(TratarNulo(par_oTxt.Value, "")))
1429: 
1430: 		IF EMPTY(loc_cValor)
1431: 			RETURN
1432: 		ENDIF
1433: 
1434: 		loc_cCursor = "cursor_4c_LkpFiltro"
1435: 		IF USED(loc_cCursor)
1436: 			USE IN (loc_cCursor)
1437: 		ENDIF
1438: 
1439: 		loc_cSQL = "SELECT " + par_cCampoCod + " FROM " + par_cTabela + ;
1440: 			" WHERE " + par_cCampoCod + " = " + EscaparSQL(loc_cValor)
1441: 		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)
1442: 
1443: 		IF loc_nResultado > 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
1444: 			par_oTxt.Value = ALLTRIM(EVALUATE(loc_cCursor + "." + par_cCampoCod))
1445: 			USE IN (loc_cCursor)
1446: 		ELSE
1447: 			IF USED(loc_cCursor)
1448: 				USE IN (loc_cCursor)
1449: 			ENDIF
1450: 			THIS.AbrirLookupCanonico(par_cTabela, par_cCampoCod, par_cCampoDesc, par_cTitulo, loc_cValor, par_oTxt)
1451: 		ENDIF
1452: 
1453: 		par_oTxt.Refresh()
1454: 	ENDPROC
1455: 
1456: 	*====================================================================
1457: 	* ExecutarLookupFeitio - Helper compartilhado por Get_Feitio/getNewMkp
1458: 	* (ambos consultam SigPrFti.Cods; getNewMkp acrescenta "Tipos = 1").
1459: 	*====================================================================
1460: 	PROTECTED PROCEDURE ExecutarLookupFeitio(par_oTxt, par_cFiltroExtra, par_cTitulo)
1461: 		LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_cCursor, loc_cWhere
1462: 		loc_cValor = ALLTRIM(UPPER(TratarNulo(par_oTxt.Value, "")))
1463: 
1464: 		IF EMPTY(loc_cValor)
1465: 			RETURN
1466: 		ENDIF
1467: 
1468: 		loc_cCursor = "cursor_4c_LkpFeitio"
1469: 		IF USED(loc_cCursor)
1470: 			USE IN (loc_cCursor)
1471: 		ENDIF
1472: 
1473: 		loc_cWhere = "Cods = " + EscaparSQL(loc_cValor)
1474: 		IF VARTYPE(par_cFiltroExtra) = "C" AND !EMPTY(par_cFiltroExtra)
1475: 			loc_cWhere = loc_cWhere + " AND " + par_cFiltroExtra
1476: 		ENDIF
1477: 
1478: 		loc_cSQL = "SELECT Cods FROM SigPrFti WHERE " + loc_cWhere
1479: 		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)
1480: 
1481: 		IF loc_nResultado > 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
1482: 			par_oTxt.Value = ALLTRIM(EVALUATE(loc_cCursor + ".Cods"))
1483: 			USE IN (loc_cCursor)
1484: 		ELSE
1485: 			IF USED(loc_cCursor)
1486: 				USE IN (loc_cCursor)
1487: 			ENDIF
1488: 			THIS.AbrirLookupCanonico("SigPrFti", "Cods", "Descs", par_cTitulo, loc_cValor, par_oTxt, .NULL., par_cFiltroExtra)
1489: 		ENDIF
1490: 
1491: 		par_oTxt.Refresh()
1492: 	ENDPROC
1493: 
1494: 	*====================================================================
1495: 	* AbrirLookup<Campo> - Ponto de entrada canonico de lookup, um por
1496: 	* campo com fwBuscaExt/fwBuscaInt no legado (17 no total). Cada um
1497: 	* carrega a tabela/coluna/titulo EXATOS do CreateObject legado e
1498: 	* delega para o motor compartilhado, que tenta o match exato e, sem
1499: 	* achar, abre o picker filtrado pelo prefixo digitado.
1500: 	* Todos PUBLIC: sao chamados pelos handlers de KeyPress ligados por
1501: 	* BINDEVENT (CLAUDE.md regra #3).
1502: 	*====================================================================
1503: 	PROCEDURE AbrirLookupGrupoI()
1504: 		THIS.ExecutarLookupFiltro(THIS.txt_4c_GrupoI, "SigCdGrp", "CGrus", "DGrus", "Grupo")
1505: 	ENDPROC
1506: 
1507: 	PROCEDURE AbrirLookupGrupoF()
1508: 		THIS.ExecutarLookupFiltro(THIS.txt_4c_GrupoF, "SigCdGrp", "CGrus", "DGrus", "Grupo")
1509: 	ENDPROC
1510: 
1511: 	PROCEDURE AbrirLookupGrandeGrupoI()
1512: 		THIS.ExecutarLookupFiltro(THIS.txt_4c_GrandeGrupoI, "SigCdGpr", "Codigos", "Descs", "Grande Grupo")
1513: 	ENDPROC
1514: 
1515: 	PROCEDURE AbrirLookupGrandeGrupoF()
1516: 		THIS.ExecutarLookupFiltro(THIS.txt_4c_GrandeGrupoF, "SigCdGpr", "Codigos", "Descs", "Grande Grupo")
1517: 	ENDPROC
1518: 
1519: 	PROCEDURE AbrirLookupColecaoI()
1520: 		THIS.ExecutarLookupFiltro(THIS.txt_4c_ColecaoI, "SigCdCol", "Colecoes", "Descs", "Grupo Venda")
1521: 	ENDPROC
1522: 
1523: 	PROCEDURE AbrirLookupColecaoF()
1524: 		THIS.ExecutarLookupFiltro(THIS.txt_4c_ColecaoF, "SigCdCol", "Colecoes", "Descs", "Grupo Venda")
1525: 	ENDPROC
1526: 
1527: 	PROCEDURE AbrirLookupSubGrupoI()
1528: 		THIS.ExecutarLookupFiltro(THIS.txt_4c_SubGrupoI, "SigCdPsg", "Codigos", "Descricaos", "Subgrupo")
1529: 	ENDPROC
1530: 
1531: 	PROCEDURE AbrirLookupSubGrupoF()
1532: 		THIS.ExecutarLookupFiltro(THIS.txt_4c_SubGrupoF, "SigCdPsg", "Codigos", "Descricaos", "Subgrupo")
1533: 	ENDPROC
1534: 
1535: 	PROCEDURE AbrirLookupLinhaI()
1536: 		THIS.ExecutarLookupFiltro(THIS.txt_4c_LinhaI, "SigCdLin", "Linhas", "Descs", "Linha")
1537: 	ENDPROC
1538: 
1539: 	PROCEDURE AbrirLookupLinhaF()
1540: 		THIS.ExecutarLookupFiltro(THIS.txt_4c_LinhaF, "SigCdLin", "Linhas", "Descs", "Linha")
1541: 	ENDPROC
1542: 
1543: 	PROCEDURE AbrirLookupUnidadeI()
1544: 		THIS.ExecutarLookupFiltro(THIS.txt_4c_UnidadeI, "SigCdUni", "CUnis", "DUnis", "Unidade")
1545: 	ENDPROC
1546: 
1547: 	PROCEDURE AbrirLookupUnidadeF()
1548: 		THIS.ExecutarLookupFiltro(THIS.txt_4c_UnidadeF, "SigCdUni", "CUnis", "DUnis", "Unidade")
1549: 	ENDPROC
1550: 
1551: 	PROCEDURE AbrirLookupMoedaI()
1552: 		THIS.ExecutarLookupFiltro(THIS.txt_4c_MoedaI, "SigCdMoe", "CMoes", "DMoes", "Moeda")
1553: 	ENDPROC
1554: 
1555: 	PROCEDURE AbrirLookupMoedaF()
1556: 		THIS.ExecutarLookupFiltro(THIS.txt_4c_MoedaF, "SigCdMoe", "CMoes", "DMoes", "Moeda")
1557: 	ENDPROC
1558: 
1559: 	PROCEDURE AbrirLookupFeitio()
1560: 		THIS.ExecutarLookupFeitio(THIS.txt_4c_Feitio, "", "Feitios")
1561: 	ENDPROC
1562: 
1563: 	PROCEDURE AbrirLookupNovoMkp()
1564: 		THIS.ExecutarLookupFeitio(THIS.txt_4c_NovoMkp, "Tipos = 1", "Feitios de Venda")
1565: 	ENDPROC
1566: 
1567: 	*====================================================================
1568: 	* AbrirLookupFornecedor - Lookup de Fornecedor (getCFornecs/getDFornecs).
1569: 	* O legado usa fAcessoContas(Usuar, [], 'C', This.Value, This,
1570: 	* ThisForm.getDFornecs) - PROIBIDO como lookup de UX (auto-preenche com
1571: 	* o 1o match PARCIAL sem o usuario escolher). Substituido pelo padrao
1572: 	* canonico: match exato em SigCdCli.Iclis e, sem achar, picker filtrado
1573: 	* por prefixo. Unico lookup do form que preenche DOIS controles
1574: 	* (codigo + razao social).
1575: 	*====================================================================
1576: 	PROCEDURE AbrirLookupFornecedor()
1577: 		LOCAL loc_cValor, loc_cSQL, loc_nResultado
1578: 
1579: 		loc_cValor = ALLTRIM(UPPER(TratarNulo(THIS.txt_4c_Fornecedor.Value, "")))
1580: 
1581: 		IF EMPTY(loc_cValor)
1582: 			THIS.txt_4c_DescFornecedor.Value = ""
1583: 			THIS.txt_4c_DescFornecedor.Refresh()
1584: 			RETURN
1585: 		ENDIF
1586: 
1587: 		IF USED("cursor_4c_LkpFornecedor")
1588: 			USE IN cursor_4c_LkpFornecedor
1589: 		ENDIF
1590: 
1591: 		loc_cSQL = "SELECT Iclis, Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cValor)
1592: 		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpFornecedor")
1593: 
1594: 		IF loc_nResultado > 0 AND USED("cursor_4c_LkpFornecedor") AND ;
1595: 				RECCOUNT("cursor_4c_LkpFornecedor") > 0
1596: 			THIS.txt_4c_Fornecedor.Value     = ALLTRIM(cursor_4c_LkpFornecedor.Iclis)
1597: 			THIS.txt_4c_DescFornecedor.Value = ALLTRIM(cursor_4c_LkpFornecedor.Rclis)
1598: 			USE IN cursor_4c_LkpFornecedor
1599: 		ELSE
1600: 			IF USED("cursor_4c_LkpFornecedor")
1601: 				USE IN cursor_4c_LkpFornecedor
1602: 			ENDIF
1603: 			THIS.AbrirLookupCanonico("SigCdCli", "Iclis", "Rclis", ;
1604: 				"Sele" + CHR(231) + CHR(227) + "o de Fornecedor", loc_cValor, ;
1605: 				THIS.txt_4c_Fornecedor, THIS.txt_4c_DescFornecedor)
1606: 		ENDIF
1607: 
1608: 		THIS.txt_4c_Fornecedor.Refresh()
1609: 		THIS.txt_4c_DescFornecedor.Refresh()
1610: 	ENDPROC
1611: 
1612: 	*====================================================================
1613: 	* Handlers de KeyPress dos lookups de faixa - todos PUBLIC (alvo de
1614: 	* BINDEVENT, CLAUDE.md regra #3), todos com o mesmo guard Enter(13)/
1615: 	* Tab(9)/F4(115), delegando para ExecutarLookupFiltro.
1616: 	*====================================================================
1617: 	PROCEDURE GrupoIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1618: 		IF INLIST(par_nKeyCode, 13, 9, 115)
1619: 			THIS.ExecutarLookupFiltro(THIS.txt_4c_GrupoI, "SigCdGrp", "CGrus", "DGrus", "Grupo")
1620: 		ENDIF
1621: 	ENDPROC
1622: 
1623: 	PROCEDURE GrupoFKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1624: 		IF INLIST(par_nKeyCode, 13, 9, 115)
1625: 			THIS.ExecutarLookupFiltro(THIS.txt_4c_GrupoF, "SigCdGrp", "CGrus", "DGrus", "Grupo")
1626: 		ENDIF
1627: 	ENDPROC
1628: 
1629: 	PROCEDURE GrandeGrupoIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1630: 		IF INLIST(par_nKeyCode, 13, 9, 115)
1631: 			THIS.ExecutarLookupFiltro(THIS.txt_4c_GrandeGrupoI, "SigCdGpr", "Codigos", "Descs", "Grande Grupo")
1632: 		ENDIF
1633: 	ENDPROC
1634: 
1635: 	PROCEDURE GrandeGrupoFKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1636: 		IF INLIST(par_nKeyCode, 13, 9, 115)
1637: 			THIS.ExecutarLookupFiltro(THIS.txt_4c_GrandeGrupoF, "SigCdGpr", "Codigos", "Descs", "Grande Grupo")
1638: 		ENDIF
1639: 	ENDPROC
1640: 
1641: 	PROCEDURE ColecaoIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1642: 		IF INLIST(par_nKeyCode, 13, 9, 115)
1643: 			THIS.ExecutarLookupFiltro(THIS.txt_4c_ColecaoI, "SigCdCol", "Colecoes", "Descs", "Grupo Venda")
1644: 		ENDIF
1645: 	ENDPROC
1646: 
1647: 	PROCEDURE ColecaoFKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1648: 		IF INLIST(par_nKeyCode, 13, 9, 115)
1649: 			THIS.ExecutarLookupFiltro(THIS.txt_4c_ColecaoF, "SigCdCol", "Colecoes", "Descs", "Grupo Venda")
1650: 		ENDIF
1651: 	ENDPROC
1652: 
1653: 	PROCEDURE SubGrupoIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1654: 		IF INLIST(par_nKeyCode, 13, 9, 115)
1655: 			THIS.ExecutarLookupFiltro(THIS.txt_4c_SubGrupoI, "SigCdPsg", "Codigos", "Descricaos", "Subgrupo")
1656: 		ENDIF
1657: 	ENDPROC
1658: 
1659: 	PROCEDURE SubGrupoFKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1660: 		IF INLIST(par_nKeyCode, 13, 9, 115)
1661: 			THIS.ExecutarLookupFiltro(THIS.txt_4c_SubGrupoF, "SigCdPsg", "Codigos", "Descricaos", "Subgrupo")
1662: 		ENDIF
1663: 	ENDPROC
1664: 
1665: 	PROCEDURE LinhaIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1666: 		IF INLIST(par_nKeyCode, 13, 9, 115)
1667: 			THIS.ExecutarLookupFiltro(THIS.txt_4c_LinhaI, "SigCdLin", "Linhas", "Descs", "Linha")
1668: 		ENDIF
1669: 	ENDPROC
1670: 
1671: 	PROCEDURE LinhaFKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1672: 		IF INLIST(par_nKeyCode, 13, 9, 115)
1673: 			THIS.ExecutarLookupFiltro(THIS.txt_4c_LinhaF, "SigCdLin", "Linhas", "Descs", "Linha")
1674: 		ENDIF
1675: 	ENDPROC
1676: 
1677: 	PROCEDURE UnidadeIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1678: 		IF INLIST(par_nKeyCode, 13, 9, 115)
1679: 			THIS.ExecutarLookupFiltro(THIS.txt_4c_UnidadeI, "SigCdUni", "CUnis", "DUnis", "Unidade")
1680: 		ENDIF
1681: 	ENDPROC
1682: 
1683: 	PROCEDURE UnidadeFKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1684: 		IF INLIST(par_nKeyCode, 13, 9, 115)
1685: 			THIS.ExecutarLookupFiltro(THIS.txt_4c_UnidadeF, "SigCdUni", "CUnis", "DUnis", "Unidade")
1686: 		ENDIF
1687: 	ENDPROC
1688: 
1689: 	PROCEDURE MoedaIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1690: 		IF INLIST(par_nKeyCode, 13, 9, 115)
1691: 			THIS.ExecutarLookupFiltro(THIS.txt_4c_MoedaI, "SigCdMoe", "CMoes", "DMoes", "Moeda")
1692: 		ENDIF
1693: 	ENDPROC
1694: 
1695: 	PROCEDURE MoedaFKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1696: 		IF INLIST(par_nKeyCode, 13, 9, 115)
1697: 			THIS.ExecutarLookupFiltro(THIS.txt_4c_MoedaF, "SigCdMoe", "CMoes", "DMoes", "Moeda")
1698: 		ENDIF
1699: 	ENDPROC
1700: 
1701: 	PROCEDURE FeitioKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1702: 		IF INLIST(par_nKeyCode, 13, 9, 115)
1703: 			THIS.ExecutarLookupFeitio(THIS.txt_4c_Feitio, "", "Feitios")
1704: 		ENDIF
1705: 	ENDPROC
1706: 
1707: 	PROCEDURE NovoMkpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1708: 		IF INLIST(par_nKeyCode, 13, 9, 115)
1709: 			THIS.ExecutarLookupFeitio(THIS.txt_4c_NovoMkp, "Tipos = 1", "Feitios de Venda")
1710: 		ENDIF
1711: 	ENDPROC
1712: 
1713: 	*====================================================================
1714: 	* FornecedorKeyPress - PUBLIC (BINDEVENT KeyPress em txt_4c_Fornecedor).
1715: 	* Guard Enter(13)/Tab(9)/F4(115) e delega para AbrirLookupFornecedor.
1716: 	*====================================================================
1717: 	PROCEDURE FornecedorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1718: 		IF INLIST(par_nKeyCode, 13, 9, 115)
1719: 			THIS.AbrirLookupFornecedor()
1720: 		ENDIF
1721: 	ENDPROC
1722: 
1723: 	*====================================================================
1724: 	* ReajusteKeyPress/NovoMarkupKeyPress/VariacaoKeyPress - exclusao
1725: 	* mutua transcrita literalmente do Valid do legado: informar um
1726: 	* zera os outros campos concorrentes, e o estado Enabled dos tres eh
1727: 	* recalculado (ver AtualizarEstadoCalculo) porque GetnMrk/Get_Variacao
1728: 	* so ficam habilitados quando Get_Reajuste = 0.
1729: 	*====================================================================
1730: 	PROCEDURE ReajusteKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1731: 		IF !INLIST(par_nKeyCode, 13, 9)
1732: 			RETURN
1733: 		ENDIF
1734: 		IF THIS.txt_4c_Reajuste.Value > 0
1735: 			THIS.txt_4c_NovoMarkup.Value = 0
1736: 			THIS.txt_4c_NovoMarkup.Refresh()
1737: 		ENDIF
1738: 		THIS.AtualizarEstadoCalculo()
1739: 	ENDPROC
1740: 
1741: 	PROCEDURE NovoMarkupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1742: 		IF !INLIST(par_nKeyCode, 13, 9)
1743: 			RETURN
1744: 		ENDIF
1745: 		IF THIS.txt_4c_NovoMarkup.Value > 0
1746: 			THIS.txt_4c_Reajuste.Value = 0
1747: 			THIS.txt_4c_Reajuste.Refresh()
1748: 		ENDIF
1749: 		THIS.AtualizarEstadoCalculo()
1750: 	ENDPROC
1751: 
1752: 	PROCEDURE VariacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1753: 		IF !INLIST(par_nKeyCode, 13, 9)
1754: 			RETURN
1755: 		ENDIF
1756: 		IF THIS.txt_4c_Variacao.Value > 0
1757: 			THIS.txt_4c_Reajuste.Value = 0
1758: 			THIS.txt_4c_Reajuste.Refresh()
1759: 		ENDIF
1760: 		THIS.AtualizarEstadoCalculo()
1761: 	ENDPROC
1762: 
1763: 	*====================================================================
1764: 	* NovoEncargoKeyPress - Espelha o Valid de get_Encargo do legado
1765: 	* (rejeita valor negativo).
1766: 	*====================================================================
1767: 	PROCEDURE NovoEncargoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1768: 		IF !INLIST(par_nKeyCode, 13, 9)
1769: 			RETURN
1770: 		ENDIF
1771: 		IF THIS.txt_4c_NovoEncargo.Value < 0
1772: 			MsgAviso("Valor Invalido!!!", "Aten" + CHR(231) + CHR(227) + "o")
1773: 			THIS.txt_4c_NovoEncargo.Value = 0
1774: 			THIS.txt_4c_NovoEncargo.Refresh()
1775: 			THIS.txt_4c_NovoEncargo.SetFocus()
1776: 		ENDIF
1777: 	ENDPROC
1778: 
1779: 	*====================================================================
1780: 	* RecalculaValorAlterado - PUBLIC (BINDEVENT Click/InteractiveChange
1781: 	* em obj_4c_Recalcula). So delega para AtualizarEstadoCalculo, que
1782: 	* concentra as regras "When" do legado.
1783: 	*====================================================================
1784: 	PROCEDURE RecalculaValorAlterado()
1785: 		THIS.AtualizarEstadoCalculo()
1786: 	ENDPROC
1787: 
1788: 	*====================================================================
1789: 	* AtualizarEstadoCalculo - Reproduz os "When" do legado que ligam o
1790: 	* Enabled de Reajuste/Novo Markup/Variacao/Novo MKP ao tipo de
1791: 	* recalculo escolhido (obj_4c_Recalcula) e ao valor de Reajuste:
1792: 	*   Get_Reajuste.When    = Opc_Recalc.Value <> 2
1793: 	*   GetnMrk.When         = (Get_Reajuste.Value = 0) And (Opc_Recalc.Value <> 2)
1794: 	*   Get_Variacao.When    = (Get_Reajuste.Value = 0) And (Opc_Recalc.Value <> 2)
1795: 	*   getNewMkp.When       = InList(Opc_Recalc.Value, 7, 8)
1796: 	*====================================================================
1797: 	PROTECTED PROCEDURE AtualizarEstadoCalculo()
1798: 		LOCAL loc_nTipoRecalculo, loc_lReajusteZerado
1799: 
1800: 		loc_nTipoRecalculo  = THIS.obj_4c_Recalcula.Value
1801: 		loc_lReajusteZerado = (THIS.txt_4c_Reajuste.Value = 0)
1802: 
1803: 		THIS.txt_4c_Reajuste.Enabled   = (loc_nTipoRecalculo <> 2)
1804: 		THIS.txt_4c_NovoMarkup.Enabled = loc_lReajusteZerado AND (loc_nTipoRecalculo <> 2)
1805: 		THIS.txt_4c_Variacao.Enabled   = loc_lReajusteZerado AND (loc_nTipoRecalculo <> 2)
1806: 		THIS.txt_4c_NovoMkp.Enabled    = INLIST(loc_nTipoRecalculo, 7, 8)
1807: 
1808: 		THIS.txt_4c_Reajuste.Refresh()
1809: 		THIS.txt_4c_NovoMarkup.Refresh()
1810: 		THIS.txt_4c_Variacao.Refresh()
1811: 		THIS.txt_4c_NovoMkp.Refresh()
1812: 	ENDPROC
1813: 
1814: 	*====================================================================
1815: 	* ConfigurarGridProdutos - Grade de recalculo (Grd_Produto no legado):
1816: 	* 9 colunas (Column1 = checkbox de selecao/lMarca, Column2..Column9
1817: 	* somente leitura), cria o cursor local que a alimenta e liga o
1818: 	* RecordSource - transcricao literal do "Create Cursor CrProdutos(...)"
1819: 	* + WITH ThisForm.Grd_Produto do Init legado. Dimensoes/mascaras/
1820: 	* captions EXATAS do SCX (form flat 1000x600, sem PageFrame - nao ha
1821: 	* compensacao de offset a aplicar).
1822: 	*
1823: 	* cursor_4c_Produtos carrega 5 colunas ALEM das 9 da grade (pvideals/
1824: 	* fcustos/fvendas/moecs/moevs): sao os demais campos que
1825: 	* this_oBusinessObject.Atualizar() grava em SigCdPro. Sem guarda-las
1826: 	* aqui, BtnAtualizarClick teria de gravar esses campos com o default
1827: 	* (0/vazio) e apagaria dado que nao veio para a tela.
1828: 	*====================================================================
1829: 	PROTECTED PROCEDURE ConfigurarGridProdutos()
1830: 		THIS.AddObject("grd_4c_Produtos", "Grid")
1831: 		WITH THIS.grd_4c_Produtos
1832: 			.Top         = 351
1833: 			.Left        = 12
1834: 			.Width       = 935
1835: 			.Height      = 244
1836: 			.FontName    = "Tahoma"
1837: 			.FontSize    = 8
1838: 			.RowHeight   = 16
1839: 			.ScrollBars  = 2
1840: 			.DeleteMark  = .F.
1841: 			.RecordMark  = .F.
1842: 			.ColumnCount = 9
1843: 
1844: 			.Column1.FontName        = "Tahoma"
1845: 			.Column1.FontSize        = 8
1846: 			.Column1.Alignment       = 3
1847: 			.Column1.Width           = 17
1848: 			.Column1.Movable         = .F.
1849: 			.Column1.Resizable       = .F.
1850: 			.Column1.Sparse          = .F.
1851: 			.Column1.Header1.Caption = ""
1852: 
1853: 			*-- Coluna checkbox (Check1 no legado) - regra #18: precisa de
1854: 			*-- AddObject + CurrentControl para o controle realmente aparecer
1855: 			.Column1.AddObject("chk_4c_Marca", "CheckBox")
1856: 			.Column1.chk_4c_Marca.Caption = ""
1857: 			.Column1.chk_4c_Marca.Visible = .T.
1858: 			.Column1.CurrentControl       = "chk_4c_Marca"
1859: 			.Column1.ReadOnly             = .F.
1860: 
1861: 			.Column2.FontName          = "Tahoma"
1862: 			.Column2.FontSize          = 8
1863: 			.Column2.Width             = 108
1864: 			.Column2.Movable           = .F.
1865: 			.Column2.Resizable         = .F.
1866: 			.Column2.ReadOnly          = .T.
1867: 			.Column2.Header1.FontName  = "Tahoma"
1868: 			.Column2.Header1.FontSize  = 8
1869: 			.Column2.Header1.Alignment = 2

*-- Linhas 1965 a 2014:
1965: 			.Column9.Text1.ForeColor   = RGB(0, 0, 0)
1966: 			.Column9.Text1.BackColor   = RGB(255, 255, 255)
1967: 		ENDWITH
1968: 
1969: 		*-- Cursor local da grade (Create Cursor CrProdutos(...) do legado)
1970: 		IF USED("cursor_4c_Produtos")
1971: 			USE IN cursor_4c_Produtos
1972: 		ENDIF
1973: 
1974: 		*-- Os 9 primeiros campos sao os do "Create Cursor CrProdutos" legado, na
1975: 		*-- MESMA ordem (as 9 colunas da grade). Os seguintes nao existem no
1976: 		*-- legado porque la o registro recalculado ficava em CrSigCdPro: aqui
1977: 		*-- viajam junto com a linha para que AtualizarPrecos() grave sem
1978: 		*-- reconsultar SigCdPro (cgrus eh usado na reclassificacao de subgrupo
1979: 		*-- por faixa, e nao aparece na grade).
1980: 		CREATE CURSOR cursor_4c_Produtos (lMarca N(1), cpros C(14), dpros C(40), ;
1981: 			valant N(14,2), valatu N(14,2), custoafs N(12,4), custofs N(12,4), ;
1982: 			pvarias N(8,2), cvarias N(8,2), pvideals N(14,5), fcustos N(11,5), ;
1983: 			fvendas N(7,3), moecs C(3), moevs C(3), cgrus C(3))
1984: 		INDEX ON cpros TAG cpros
1985: 		SELECT cursor_4c_Produtos
1986: 		SET ORDER TO
1987: 		GO TOP
1988: 
1989: 		THIS.grd_4c_Produtos.ColumnCount = 9
1990: 		THIS.grd_4c_Produtos.RecordSource          = "cursor_4c_Produtos"
1991: 		THIS.grd_4c_Produtos.Column1.ControlSource  = "cursor_4c_Produtos.lMarca"
1992: 		THIS.grd_4c_Produtos.Column2.ControlSource  = "cursor_4c_Produtos.cpros"
1993: 		THIS.grd_4c_Produtos.Column3.ControlSource  = "cursor_4c_Produtos.dpros"
1994: 		THIS.grd_4c_Produtos.Column4.ControlSource  = "cursor_4c_Produtos.valant"
1995: 		THIS.grd_4c_Produtos.Column5.ControlSource  = "cursor_4c_Produtos.valatu"
1996: 		THIS.grd_4c_Produtos.Column6.ControlSource  = "cursor_4c_Produtos.pvarias"
1997: 		THIS.grd_4c_Produtos.Column7.ControlSource  = "cursor_4c_Produtos.custoafs"
1998: 		THIS.grd_4c_Produtos.Column8.ControlSource  = "cursor_4c_Produtos.custofs"
1999: 		THIS.grd_4c_Produtos.Column9.ControlSource  = "cursor_4c_Produtos.cvarias"
2000: 
2001: 		*-- RecordSource/ControlSource resetam Width e Header1.Caption -
2002: 		*-- reconfigurar SEMPRE depois de vincular (CLAUDE.md Problema 48)
2003: 		THIS.grd_4c_Produtos.Column1.Width           = 17
2004: 		THIS.grd_4c_Produtos.Column2.Width           = 108
2005: 		THIS.grd_4c_Produtos.Column2.Header1.Caption = "Produto"
2006: 		THIS.grd_4c_Produtos.Column3.Width           = 290
2007: 		THIS.grd_4c_Produtos.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2008: 		THIS.grd_4c_Produtos.Column4.Width           = 80
2009: 		THIS.grd_4c_Produtos.Column4.Header1.Caption = "Venda Ant."
2010: 		THIS.grd_4c_Produtos.Column5.Width           = 80
2011: 		THIS.grd_4c_Produtos.Column5.Header1.Caption = "Venda Atual"
2012: 		THIS.grd_4c_Produtos.Column6.Width           = 80
2013: 		THIS.grd_4c_Produtos.Column6.Header1.Caption = "Varia" + CHR(231) + CHR(227) + "o (%)"
2014: 		THIS.grd_4c_Produtos.Column7.Width           = 80

*-- Linhas 2026 a 2114:
2026: 		*-- CheckBox de coluna de Grid nao alterna pelo binding nativo: os 4
2027: 		*-- eventos tem de ser ligados (KeyPress alterna; Click/MouseDown/
2028: 		*-- MouseUp suprimem o toggle padrao para nao alternar duas vezes)
2029: 		BINDEVENT(THIS.grd_4c_Produtos.Column1.chk_4c_Marca, "KeyPress", THIS, "ChkMarcaKeyPress")
2030: 		BINDEVENT(THIS.grd_4c_Produtos.Column1.chk_4c_Marca, "MouseUp", THIS, "ChkMarcaMouseUp")
2031: 		BINDEVENT(THIS.grd_4c_Produtos.Column1.chk_4c_Marca, "MouseDown", THIS, "ChkMarcaMouseDown")
2032: 		BINDEVENT(THIS.grd_4c_Produtos.Column1.chk_4c_Marca, "Click", THIS, "ChkMarcaClick")
2033: 
2034: 		THIS.grd_4c_Produtos.Refresh()
2035: 	ENDPROC
2036: 
2037: 	*====================================================================
2038: 	* ConfigurarFotoProduto - Image FigJpg do legado (foto do produto da
2039: 	* linha corrente da grade): Top=128, Left=764, Width=223, Height=190,
2040: 	* Stretch=1, Visible=.F. - nasce OCULTA e so aparece quando o produto
2041: 	* selecionado tem imagem (identico ao SCX).
2042: 	*
2043: 	* Liga os dois eventos que o legado tem em volta dela:
2044: 	*   Grd_Produto.AfterRowColChange -> recarrega a foto da nova linha
2045: 	*   FigJpg.DblClick               -> abre a foto ampliada (SigOpZom)
2046: 	*====================================================================
2047: 	PROTECTED PROCEDURE ConfigurarFotoProduto()
2048: 		THIS.AddObject("img_4c_FigJpg", "Image")
2049: 		WITH THIS.img_4c_FigJpg
2050: 			.Top     = 128
2051: 			.Left    = 764
2052: 			.Width   = 223
2053: 			.Height  = 190
2054: 			.Stretch = 1
2055: 			.Picture = ""
2056: 			.Visible = .F.
2057: 		ENDWITH
2058: 
2059: 		BINDEVENT(THIS.grd_4c_Produtos, "AfterRowColChange", THIS, "GrdProdutosAfterRowColChange")
2060: 		BINDEVENT(THIS.img_4c_FigJpg, "DblClick", THIS, "FigJpgDblClick")
2061: 	ENDPROC
2062: 
2063: 	*====================================================================
2064: 	* GrdProdutosAfterRowColChange - PUBLIC e com o parametro do evento
2065: 	* declarado (CLAUDE.md regra #3: handler de AfterRowColChange precisa
2066: 	* receber par_nColIndex, senao BINDEVENT falha em runtime).
2067: 	*
2068: 	* Transcricao do AfterRowColChange legado: le SigCdPro.FigJpgs do
2069: 	* produto da linha corrente, decodifica o base64 (STRCONV(...,14) UMA
2070: 	* unica vez - decodificar duas vezes corrompe o JPEG), grava num
2071: 	* arquivo temporario e aponta a Image para ele. Sem foto, a Image volta
2072: 	* a ficar oculta - igual ao legado, que sempre limpa antes de tentar.
2073: 	*====================================================================
2074: 	PROCEDURE GrdProdutosAfterRowColChange(par_nColIndex)
2075: 		LOCAL loc_cCpros, loc_cSQL, loc_nResultado, loc_cFigJpgs
2076: 		LOCAL loc_cArqTemp, loc_cFoto, loc_oErro, loc_lProsseguir
2077: 		loc_lProsseguir = .T.
2078: 
2079: 		TRY
2080: 			*-- Legado sempre ESCONDE antes de tentar carregar
2081: 			THIS.img_4c_FigJpg.Visible = .F.
2082: 			THIS.img_4c_FigJpg.Picture = ""
2083: 
2084: 			IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
2085: 				loc_lProsseguir = .F.
2086: 			ENDIF
2087: 
2088: 			IF loc_lProsseguir
2089: 				loc_cCpros = ALLTRIM(TratarNulo(cursor_4c_Produtos.cpros, ""))
2090: 				IF EMPTY(loc_cCpros)
2091: 					loc_lProsseguir = .F.
2092: 				ENDIF
2093: 			ENDIF
2094: 
2095: 			IF loc_lProsseguir
2096: 				IF USED("cursor_4c_TmpFoto")
2097: 					USE IN cursor_4c_TmpFoto
2098: 				ENDIF
2099: 				loc_cSQL = "SELECT FigJpgs FROM SigCdPro WHERE Cpros = " + EscaparSQL(loc_cCpros)
2100: 				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpFoto")
2101: 
2102: 				IF loc_nResultado < 1 OR !USED("cursor_4c_TmpFoto") OR ;
2103: 						RECCOUNT("cursor_4c_TmpFoto") = 0
2104: 					loc_lProsseguir = .F.
2105: 				ENDIF
2106: 			ENDIF
2107: 
2108: 			IF loc_lProsseguir
2109: 				SELECT cursor_4c_TmpFoto
2110: 				GO TOP
2111: 				loc_cFigJpgs = TratarNulo(cursor_4c_TmpFoto.FigJpgs, "")
2112: 				USE IN cursor_4c_TmpFoto
2113: 
2114: 				IF !EMPTY(loc_cFigJpgs)

*-- Linhas 2136 a 2192:
2136: 			MsgErro("Erro ao carregar a foto do produto:" + CHR(13) + ;
2137: 				loc_oErro.Message + CHR(13) + ;
2138: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2139: 				"Procedure: " + loc_oErro.Procedure, "Erro")
2140: 		ENDTRY
2141: 	ENDPROC
2142: 
2143: 	*====================================================================
2144: 	* FigJpgDblClick - PUBLIC (BINDEVENT DblClick em img_4c_FigJpg).
2145: 	* Transcricao do DblClick legado: reextrai a foto do produto corrente
2146: 	* para um arquivo temporario proprio e abre o visualizador ampliado
2147: 	* (o legado faz "Do Form SigOpZom With lcArquivo, titulo, ' '").
2148: 	* FormSigOpZom ainda nao foi migrado - o fallback abre a imagem no
2149: 	* visualizador do Windows (ShellExecute), padrao canonico ja usado em
2150: 	* FormSigPrCtr/Formsigmvdis.
2151: 	*====================================================================
2152: 	PROCEDURE FigJpgDblClick()
2153: 		LOCAL loc_cCpros, loc_cDpros, loc_cSQL, loc_nResultado, loc_cFigJpgs
2154: 		LOCAL loc_cArqTemp, loc_cFoto, loc_cCaption, loc_oErro, loc_lProsseguir
2155: 		loc_lProsseguir = .T.
2156: 
2157: 		TRY
2158: 			IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
2159: 				loc_lProsseguir = .F.
2160: 			ENDIF
2161: 
2162: 			IF loc_lProsseguir
2163: 				loc_cCpros = ALLTRIM(TratarNulo(cursor_4c_Produtos.cpros, ""))
2164: 				loc_cDpros = ALLTRIM(TratarNulo(cursor_4c_Produtos.dpros, ""))
2165: 				IF EMPTY(loc_cCpros)
2166: 					loc_lProsseguir = .F.
2167: 				ENDIF
2168: 			ENDIF
2169: 
2170: 			IF loc_lProsseguir
2171: 				IF USED("cursor_4c_TmpFotoZom")
2172: 					USE IN cursor_4c_TmpFotoZom
2173: 				ENDIF
2174: 				loc_cSQL = "SELECT a.Cpros, a.FigJpgs FROM SigCdPro a WHERE a.Cpros = " + ;
2175: 					EscaparSQL(loc_cCpros)
2176: 				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpFotoZom")
2177: 
2178: 				IF loc_nResultado < 1 OR !USED("cursor_4c_TmpFotoZom") OR ;
2179: 						RECCOUNT("cursor_4c_TmpFotoZom") = 0
2180: 					loc_lProsseguir = .F.
2181: 				ENDIF
2182: 			ENDIF
2183: 
2184: 			IF loc_lProsseguir
2185: 				SELECT cursor_4c_TmpFotoZom
2186: 				GO TOP
2187: 				loc_cFigJpgs = TratarNulo(cursor_4c_TmpFotoZom.FigJpgs, "")
2188: 				USE IN cursor_4c_TmpFotoZom
2189: 
2190: 				IF !EMPTY(loc_cFigJpgs)
2191: 					loc_cArqTemp = SYS(2023) + "\" + SYS(2015) + ".jpg"
2192: 					loc_cFoto = STRCONV( ;

*-- Linhas 2223 a 2312:
2223: 			MsgErro("Erro ao ampliar a foto do produto:" + CHR(13) + ;
2224: 				loc_oErro.Message + CHR(13) + ;
2225: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2226: 				"Procedure: " + loc_oErro.Procedure, "Erro")
2227: 		ENDTRY
2228: 	ENDPROC
2229: 
2230: 	*====================================================================
2231: 	* Toggle do CheckBox da coluna 1 da grade (Column1.Check1 do legado).
2232: 	* CheckBox em coluna de Grid NAO alterna pelo binding nativo: o valor
2233: 	* tem de ser trocado por codigo, e os tres eventos de mouse precisam
2234: 	* suprimir o comportamento padrao (NODEFAULT) para nao alternar duas
2235: 	* vezes. Os quatro handlers sao PUBLIC (alvo de BINDEVENT).
2236: 	*
2237: 	* O gate vem do "When" legado (Return(!Empty(CrProdutos.CPros))): a
2238: 	* celula so aceita marcacao em linha que tenha produto - por isso ele
2239: 	* mora DENTRO do KeyPress, nao num When ligado por BINDEVENT (BINDEVENT
2240: 	* descarta o retorno do delegate e um When assim nao bloquearia nada).
2241: 	*====================================================================
2242: 	PROCEDURE ChkMarcaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2243: 		IF INLIST(par_nKeyCode, 13, 32) AND USED("cursor_4c_Produtos") AND ;
2244: 				!EOF("cursor_4c_Produtos") AND ;
2245: 				!EMPTY(TratarNulo(cursor_4c_Produtos.cpros, ""))
2246: 			REPLACE lMarca WITH IIF(cursor_4c_Produtos.lMarca = 0, 1, 0) IN cursor_4c_Produtos
2247: 			THIS.grd_4c_Produtos.Refresh()
2248: 			NODEFAULT
2249: 		ENDIF
2250: 	ENDPROC
2251: 
2252: 	PROCEDURE ChkMarcaMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
2253: 		THIS.ChkMarcaKeyPress(13, 0)
2254: 		NODEFAULT
2255: 	ENDPROC
2256: 
2257: 	PROCEDURE ChkMarcaMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
2258: 		NODEFAULT
2259: 	ENDPROC
2260: 
2261: 	PROCEDURE ChkMarcaClick()
2262: 		NODEFAULT
2263: 	ENDPROC
2264: 
2265: 	*====================================================================
2266: 	* ConfigurarBotoesAcao - Botoes de acao do legado: CommandGroup Sair
2267: 	* (Processar/Atualizar/Encerrar), Impress?o (abre o relatorio
2268: 	* FormSIGPRCCR ja migrado - "Do Form SigPrCcr" no legado) e
2269: 	* cmdSelemp/CmdApgEmp (Selecionar/Desmarcar Tudo, ao lado da grade).
2270: 	* Posicoes/icones EXATOS do SCX (form 1000x600, sem PageFrame).
2271: 	*====================================================================
2272: 	PROTECTED PROCEDURE ConfigurarBotoesAcao()
2273: 		LOCAL loc_cIcones
2274: 		loc_cIcones = IIF(TYPE("gc_4c_CaminhoIcones") = "C", gc_4c_CaminhoIcones, "")
2275: 
2276: 		*-- CommandGroup Sair do legado -> Processar / Atualizar / Encerrar
2277: 		THIS.AddObject("cmg_4c_Acoes", "CommandGroup")
2278: 		WITH THIS.cmg_4c_Acoes
2279: 			.Top         = -2
2280: 			.Left        = 770
2281: 			.Width       = 235
2282: 			.Height      = 85
2283: 			.BackStyle   = 0
2284: 			.BorderStyle = 0
2285: 			.ButtonCount = 3
2286: 			.Themes      = .F.
2287: 			.Value       = 1
2288: 
2289: 			WITH .Buttons(1)
2290: 				.Top        = 5
2291: 				.Left       = 5
2292: 				.Width      = 75
2293: 				.Height     = 75
2294: 				.Caption    = "Processar"
2295: 				.Picture    = loc_cIcones + "geral_processar_60.jpg"
2296: 				.FontName   = "Comic Sans MS"
2297: 				.FontBold   = .T.
2298: 				.FontItalic = .T.
2299: 				.FontSize   = 8
2300: 				.ForeColor  = RGB(90, 90, 90)
2301: 				.BackColor  = RGB(255, 255, 255)
2302: 				.Themes     = .F.
2303: 				.WordWrap   = .T.
2304: 			ENDWITH
2305: 
2306: 			WITH .Buttons(2)
2307: 				.Top        = 5
2308: 				.Left       = 80
2309: 				.Width      = 75
2310: 				.Height     = 75
2311: 				.Caption    = "Atualizar"
2312: 				.Picture    = loc_cIcones + "cadastro_salvar_60.jpg"

*-- Linhas 2339 a 2651:
2339: 				.WordWrap   = .T.
2340: 			ENDWITH
2341: 		ENDWITH
2342: 		BINDEVENT(THIS.cmg_4c_Acoes.Buttons(1), "Click", THIS, "BtnProcessarClick")
2343: 		BINDEVENT(THIS.cmg_4c_Acoes.Buttons(2), "Click", THIS, "BtnAtualizarClick")
2344: 		BINDEVENT(THIS.cmg_4c_Acoes.Buttons(3), "Click", THIS, "BtnEncerrarClick")
2345: 
2346: 		*-- Decorativo (Shape2 do legado) - acompanha a visibilidade do Imprimir
2347: 		THIS.AddObject("shp_4c_Shape2", "Shape")
2348: 		WITH THIS.shp_4c_Shape2
2349: 			.Top         = 6
2350: 			.Left        = 650
2351: 			.Width       = 10
2352: 			.Height      = 6
2353: 			.BackStyle   = 0
2354: 			.BorderStyle = 0
2355: 			.BorderColor = RGB(136, 189, 188)
2356: 		ENDWITH
2357: 
2358: 		*-- Imprimir (Impress?o no legado) - abre o relatorio ja migrado
2359: 		*-- (FormSIGPRCCR), equivalente a "Do Form SigPrCcr". Comeca
2360: 		*-- desabilitado ate o 1o Processar bem sucedido (Init legado:
2361: 		*-- Impress?o.Enabled = .f.)
2362: 		THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
2363: 		WITH THIS.cmd_4c_Imprimir
2364: 			.Top             = 3
2365: 			.Left            = 700
2366: 			.Width           = 75
2367: 			.Height          = 75
2368: 			.Caption         = "Imprimir"
2369: 			.Picture         = loc_cIcones + "geral_impressora_normal_60.jpg"
2370: 			.DisabledPicture = loc_cIcones + "geral_impressora_normal_60.jpg"
2371: 			.Themes          = .T.
2372: 			.FontName        = "Comic Sans MS"
2373: 			.FontBold        = .T.
2374: 			.FontItalic      = .T.
2375: 			.FontSize        = 8
2376: 			.ForeColor       = RGB(90, 90, 90)
2377: 			.BackColor       = RGB(255, 255, 255)
2378: 			.SpecialEffect   = 0
2379: 			.PicturePosition = 13
2380: 			.MousePointer    = 15
2381: 			.WordWrap        = .T.
2382: 			.AutoSize        = .F.
2383: 			.Enabled         = .F.
2384: 			.Visible         = fChecaAcesso("SigPrCcp", "IMPRIMIR")
2385: 		ENDWITH
2386: 		BINDEVENT(THIS.cmd_4c_Imprimir, "Click", THIS, "BtnImprimirClick")
2387: 		THIS.shp_4c_Shape2.Visible = THIS.cmd_4c_Imprimir.Visible
2388: 
2389: 		*-- Selecionar/Desmarcar Tudo (cmdSelemp/CmdApgEmp no legado)
2390: 		THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
2391: 		WITH THIS.cmd_4c_SelTudo
2392: 			.Top             = 433
2393: 			.Left            = 955
2394: 			.Width           = 33
2395: 			.Height          = 33
2396: 			.Caption         = ""
2397: 			.Picture         = loc_cIcones + "geral_adicao_26.jpg"
2398: 			.DisabledPicture = loc_cIcones + "geral_adicao_26.jpg"
2399: 			.Themes          = .T.
2400: 			.ToolTipText     = "Selecionar Tudo"
2401: 			.TabStop         = .F.
2402: 		ENDWITH
2403: 		BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "BtnSelTudoClick")
2404: 
2405: 		THIS.AddObject("cmd_4c_Apaga", "CommandButton")
2406: 		WITH THIS.cmd_4c_Apaga
2407: 			.Top             = 473
2408: 			.Left            = 955
2409: 			.Width           = 33
2410: 			.Height          = 33
2411: 			.Caption         = ""
2412: 			.Picture         = loc_cIcones + "cadastro_excluir_26.jpg"
2413: 			.DisabledPicture = loc_cIcones + "cadastro_excluir_26.jpg"
2414: 			.Themes          = .T.
2415: 			.ToolTipText     = "Desmarcar Tudo"
2416: 			.TabStop         = .F.
2417: 		ENDWITH
2418: 		BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "BtnApagaClick")
2419: 	ENDPROC
2420: 
2421: 	*====================================================================
2422: 	* FormParaBO - Hook canonico de FormBase: copia o Value de TODOS os
2423: 	* campos/grupos da tela (area "Filtros" + area "Dados") para as
2424: 	* propriedades this_c*/this_n* de this_oBusinessObject, consumidas por
2425: 	* MontarWhereFiltros/BuscarProdutosFiltrados/Atualizar. Espelha o bloco
2426: 	* inicial do metodo "processar" legado (lcMercI = Thisform.getMercI.
2427: 	* Value, etc.) - chamado SEMPRE antes de BuscarProdutosFiltrados, senao
2428: 	* os filtros digitados na tela nunca chegam ao SQL (o BO ficaria so com
2429: 	* os defaults de Init).
2430: 	*
2431: 	* PROTECTED porque o hook homonimo de FormBase eh PROTECTED e subclasse
2432: 	* NAO pode alargar o escopo herdado.
2433: 	*
2434: 	* Inverso exato de BOParaForm() - ao acrescentar campo, mexer NOS DOIS.
2435: 	*====================================================================
2436: 	PROTECTED PROCEDURE FormParaBO()
2437: 		WITH THIS.this_oBusinessObject
2438: 			.this_cFornecs    = ALLTRIM(THIS.txt_4c_Fornecedor.Value)
2439: 			.this_cDFornecs   = ALLTRIM(THIS.txt_4c_DescFornecedor.Value)
2440: 
2441: 			.this_cMercI      = ALLTRIM(THIS.txt_4c_GrandeGrupoI.Value)
2442: 			.this_cMercF      = ALLTRIM(THIS.txt_4c_GrandeGrupoF.Value)
2443: 			.this_cGrupoI     = ALLTRIM(THIS.txt_4c_GrupoI.Value)
2444: 			.this_cGrupoF     = ALLTRIM(THIS.txt_4c_GrupoF.Value)
2445: 			.this_cSubGrupoI  = ALLTRIM(THIS.txt_4c_SubGrupoI.Value)
2446: 			.this_cSubGrupoF  = ALLTRIM(THIS.txt_4c_SubGrupoF.Value)
2447: 			.this_cUnidadeI   = ALLTRIM(THIS.txt_4c_UnidadeI.Value)
2448: 			.this_cUnidadeF   = ALLTRIM(THIS.txt_4c_UnidadeF.Value)
2449: 			.this_cLinhaI     = ALLTRIM(THIS.txt_4c_LinhaI.Value)
2450: 			.this_cLinhaF     = ALLTRIM(THIS.txt_4c_LinhaF.Value)
2451: 			.this_cColecaoI   = ALLTRIM(THIS.txt_4c_ColecaoI.Value)
2452: 			.this_cColecaoF   = ALLTRIM(THIS.txt_4c_ColecaoF.Value)
2453: 			.this_cMoedaI     = ALLTRIM(THIS.txt_4c_MoedaI.Value)
2454: 			.this_cMoedaF     = ALLTRIM(THIS.txt_4c_MoedaF.Value)
2455: 
2456: 			.this_nMarkupI    = THIS.txt_4c_MarkupI.Value
2457: 			.this_nMarkupF    = THIS.txt_4c_MarkupF.Value
2458: 			.this_nEncargoI   = THIS.txt_4c_EncargoI.Value
2459: 			.this_nEncargoF   = THIS.txt_4c_EncargoF.Value
2460: 			.this_nVariacao   = THIS.txt_4c_Variacao.Value
2461: 
2462: 			.this_cFeitio     = ALLTRIM(THIS.txt_4c_Feitio.Value)
2463: 			.this_cNovoFeitio = ALLTRIM(THIS.txt_4c_NovoMkp.Value)
2464: 
2465: 			.this_nOpcaoMoeda    = THIS.obj_4c_OpcaoMoeda.Value
2466: 			.this_nSituacao      = THIS.obj_4c_Situacao.Value
2467: 			.this_nOpcaoCompra   = THIS.obj_4c_Compra.Value
2468: 			.this_nTipoRecalculo = THIS.obj_4c_Recalcula.Value
2469: 			.this_nAtualizaVenda = THIS.obj_4c_AtualizaVenda.Value
2470: 
2471: 			.this_nReajuste      = THIS.txt_4c_Reajuste.Value
2472: 			.this_nNovoMarkup    = THIS.txt_4c_NovoMarkup.Value
2473: 			.this_nNovoEncargo   = THIS.txt_4c_NovoEncargo.Value
2474: 		ENDWITH
2475: 	ENDPROC
2476: 
2477: 	*====================================================================
2478: 	* BOParaForm - Hook canonico de FormBase, INVERSO exato de FormParaBO:
2479: 	* joga as propriedades de filtro/dados do BO nos controles da tela, na
2480: 	* mesma ordem e com os mesmos pares.
2481: 	*
2482: 	* Usado no fim da montagem (InicializarForm) para que os DEFAULTS
2483: 	* venham de um lugar so - o DEFINE CLASS do sigprccpBO - em vez de
2484: 	* ficarem repetidos nos AddObject dos OptionGroups; e por LimparCampos,
2485: 	* que devolve a tela ao estado inicial resetando o BO.
2486: 	*
2487: 	* Os OptionGroups passam por AplicarValorOptionGroup porque .Value eh o
2488: 	* INDICE do botao (1..ButtonCount) e o VFP9 recusa indice fora da
2489: 	* faixa - o valor pode ter vindo de SigCdCcp, que eh dado de usuario.
2490: 	*
2491: 	* PROTECTED porque o hook homonimo de FormBase eh PROTECTED e subclasse
2492: 	* NAO pode alargar o escopo herdado.
2493: 	*====================================================================
2494: 	PROTECTED PROCEDURE BOParaForm()
2495: 		IF VARTYPE(THIS.this_oBusinessObject) != "O"
2496: 			RETURN
2497: 		ENDIF
2498: 
2499: 		WITH THIS.this_oBusinessObject
2500: 			*-- Filtros
2501: 			THIS.txt_4c_Fornecedor.Value     = ALLTRIM(.this_cFornecs)
2502: 			THIS.txt_4c_DescFornecedor.Value = ALLTRIM(.this_cDFornecs)
2503: 
2504: 			THIS.txt_4c_GrandeGrupoI.Value   = ALLTRIM(.this_cMercI)
2505: 			THIS.txt_4c_GrandeGrupoF.Value   = ALLTRIM(.this_cMercF)
2506: 			THIS.txt_4c_GrupoI.Value         = ALLTRIM(.this_cGrupoI)
2507: 			THIS.txt_4c_GrupoF.Value         = ALLTRIM(.this_cGrupoF)
2508: 			THIS.txt_4c_SubGrupoI.Value      = ALLTRIM(.this_cSubGrupoI)
2509: 			THIS.txt_4c_SubGrupoF.Value      = ALLTRIM(.this_cSubGrupoF)
2510: 			THIS.txt_4c_UnidadeI.Value       = ALLTRIM(.this_cUnidadeI)
2511: 			THIS.txt_4c_UnidadeF.Value       = ALLTRIM(.this_cUnidadeF)
2512: 			THIS.txt_4c_LinhaI.Value         = ALLTRIM(.this_cLinhaI)
2513: 			THIS.txt_4c_LinhaF.Value         = ALLTRIM(.this_cLinhaF)
2514: 			THIS.txt_4c_ColecaoI.Value       = ALLTRIM(.this_cColecaoI)
2515: 			THIS.txt_4c_ColecaoF.Value       = ALLTRIM(.this_cColecaoF)
2516: 			THIS.txt_4c_MoedaI.Value         = ALLTRIM(.this_cMoedaI)
2517: 			THIS.txt_4c_MoedaF.Value         = ALLTRIM(.this_cMoedaF)
2518: 
2519: 			THIS.txt_4c_MarkupI.Value        = .this_nMarkupI
2520: 			THIS.txt_4c_MarkupF.Value        = .this_nMarkupF
2521: 			THIS.txt_4c_EncargoI.Value       = .this_nEncargoI
2522: 			THIS.txt_4c_EncargoF.Value       = .this_nEncargoF
2523: 			THIS.txt_4c_Variacao.Value       = .this_nVariacao
2524: 
2525: 			THIS.txt_4c_Feitio.Value         = ALLTRIM(.this_cFeitio)
2526: 			THIS.txt_4c_NovoMkp.Value        = ALLTRIM(.this_cNovoFeitio)
2527: 
2528: 			*-- Dados
2529: 			THIS.txt_4c_Reajuste.Value       = .this_nReajuste
2530: 			THIS.txt_4c_NovoMarkup.Value     = .this_nNovoMarkup
2531: 			THIS.txt_4c_NovoEncargo.Value    = .this_nNovoEncargo
2532: 		ENDWITH
2533: 
2534: 		*-- OptionGroups FORA do WITH, com o caminho escrito por inteiro: um
2535: 		*-- WITH aberto sequestra a resolucao de todo nome que comeca por ponto,
2536: 		*-- e chamada de metodo do form com argumentos ".this_n*" dentro dele eh
2537: 		*-- justamente o que produz "Property X is not found" (CLAUDE.md #33).
2538: 		THIS.AplicarValorOptionGroup(THIS.obj_4c_OpcaoMoeda, ;
2539: 			THIS.this_oBusinessObject.this_nOpcaoMoeda)
2540: 		THIS.AplicarValorOptionGroup(THIS.obj_4c_Situacao, ;
2541: 			THIS.this_oBusinessObject.this_nSituacao)
2542: 		THIS.AplicarValorOptionGroup(THIS.obj_4c_Compra, ;
2543: 			THIS.this_oBusinessObject.this_nOpcaoCompra)
2544: 		THIS.AplicarValorOptionGroup(THIS.obj_4c_Recalcula, ;
2545: 			THIS.this_oBusinessObject.this_nTipoRecalculo)
2546: 		THIS.AplicarValorOptionGroup(THIS.obj_4c_AtualizaVenda, ;
2547: 			THIS.this_oBusinessObject.this_nAtualizaVenda)
2548: 
2549: 		*-- Recalcula comanda o Enabled de Reajuste/NovoMarkup/Variacao/NovoMkp
2550: 		*-- (as clausulas When do legado) - tem de rodar DEPOIS dos valores.
2551: 		THIS.AtualizarEstadoCalculo()
2552: 	ENDPROC
2553: 
2554: 	*====================================================================
2555: 	* LimparCampos - Hook canonico de FormBase. Aqui NAO limpa os filtros
2556: 	* digitados (o legado nunca os apaga - eles ficam na tela para o
2557: 	* usuario reprocessar variando um parametro so); limpa o RESULTADO:
2558: 	* zera o cursor da grade, esconde a foto do produto e devolve a tela ao
2559: 	* modo "LISTA", que desabilita Atualizar/Imprimir.
2560: 	*
2561: 	* Eh a transcricao do "Zap In CrProdutos" que o legado repete em tres
2562: 	* lugares - no inicio de Processa.Click (antes de reprocessar), no fim
2563: 	* de "atualizar" (junto dos Zap dos demais cursores de trabalho) e em
2564: 	* cada volta do Scan de "processaautomatico".
2565: 	*
2566: 	* ZAP, nunca USE IN + CREATE CURSOR: recriar o cursor derrubaria
2567: 	* RecordSource/ControlSource do Grid (e com eles Column.Width,
2568: 	* Header1.Caption, Sparse e CurrentControl do CheckBox).
2569: 	*
2570: 	* PROTECTED porque o hook homonimo de FormBase eh PROTECTED e subclasse
2571: 	* NAO pode alargar o escopo herdado.
2572: 	*====================================================================
2573: 	PROTECTED PROCEDURE LimparCampos()
2574: 		IF USED("cursor_4c_Produtos")
2575: 			ZAP IN cursor_4c_Produtos
2576: 		ENDIF
2577: 
2578: 		*-- "ThisForm.FigJpg.Visible = .F. / .Picture = ''" do legado: sem
2579: 		*-- linha na grade nao ha produto, logo nao ha foto a exibir.
2580: 		IF PEMSTATUS(THIS, "img_4c_FigJpg", 5)
2581: 			THIS.img_4c_FigJpg.Visible = .F.
2582: 			THIS.img_4c_FigJpg.Picture = ""
2583: 		ENDIF
2584: 
2585: 		THIS.this_cModoAtual = "LISTA"
2586: 		THIS.AjustarBotoesPorModo()
2587: 
2588: 		IF PEMSTATUS(THIS, "grd_4c_Produtos", 5)
2589: 			THIS.grd_4c_Produtos.Refresh()
2590: 		ENDIF
2591: 	ENDPROC
2592: 
2593: 	*====================================================================
2594: 	* HabilitarCampos - Liga/desliga em bloco TODOS os campos de entrada da
2595: 	* tela (area "Filtros" + area "Dados" + os dois botoes de marcacao da
2596: 	* grade). Existe porque AtualizarPrecos roda um lote longo com barra de
2597: 	* progresso, e a barra faz o VFP processar eventos: sem travar a
2598: 	* entrada, o usuario consegue reescrever um filtro ou (re)marcar linhas
2599: 	* NO MEIO da gravacao, e a partir dai a tela deixa de descrever o que
2600: 	* esta sendo gravado.
2601: 	*
2602: 	* Ao REABILITAR, as regras condicionais do legado sao repostas por
2603: 	* AtualizarEstadoCalculo (clausulas When de Reajuste/NovoMarkup/
2604: 	* Variacao/NovoMkp) e a Descricao do Fornecedor volta a ser somente
2605: 	* leitura - ela tem "Return .F." no When do legado (getDFornecs), isto
2606: 	* eh, NUNCA recebe foco.
2607: 	*
2608: 	* PUBLIC - chamado de fora da classe pelo harness de teste (CLAUDE.md
2609: 	* regra #3).
2610: 	*====================================================================
2611: 	PROCEDURE HabilitarCampos(par_lHabilitar)
2612: 		LOCAL loc_lLiga, loc_nI, loc_aCampos[1]
2613: 
2614: 		loc_lLiga = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
2615: 
2616: 		*-- Campos de FILTRO
2617: 		DIMENSION loc_aCampos[28]
2618: 		loc_aCampos[ 1] = "txt_4c_Fornecedor"
2619: 		loc_aCampos[ 2] = "txt_4c_DescFornecedor"
2620: 		loc_aCampos[ 3] = "txt_4c_GrandeGrupoI"
2621: 		loc_aCampos[ 4] = "txt_4c_GrandeGrupoF"
2622: 		loc_aCampos[ 5] = "txt_4c_GrupoI"
2623: 		loc_aCampos[ 6] = "txt_4c_GrupoF"
2624: 		loc_aCampos[ 7] = "txt_4c_SubGrupoI"
2625: 		loc_aCampos[ 8] = "txt_4c_SubGrupoF"
2626: 		loc_aCampos[ 9] = "txt_4c_UnidadeI"
2627: 		loc_aCampos[10] = "txt_4c_UnidadeF"
2628: 		loc_aCampos[11] = "txt_4c_LinhaI"
2629: 		loc_aCampos[12] = "txt_4c_LinhaF"
2630: 		loc_aCampos[13] = "txt_4c_ColecaoI"
2631: 		loc_aCampos[14] = "txt_4c_ColecaoF"
2632: 		loc_aCampos[15] = "txt_4c_MoedaI"
2633: 		loc_aCampos[16] = "txt_4c_MoedaF"
2634: 		loc_aCampos[17] = "txt_4c_MarkupI"
2635: 		loc_aCampos[18] = "txt_4c_MarkupF"
2636: 		loc_aCampos[19] = "txt_4c_EncargoI"
2637: 		loc_aCampos[20] = "txt_4c_EncargoF"
2638: 		loc_aCampos[21] = "txt_4c_Variacao"
2639: 		loc_aCampos[22] = "txt_4c_Feitio"
2640: 		loc_aCampos[23] = "obj_4c_OpcaoMoeda"
2641: 		loc_aCampos[24] = "obj_4c_Situacao"
2642: 		loc_aCampos[25] = "obj_4c_Compra"
2643: 		*-- Campos da area DADOS
2644: 		loc_aCampos[26] = "txt_4c_NovoMkp"
2645: 		loc_aCampos[27] = "obj_4c_AtualizaVenda"
2646: 		loc_aCampos[28] = "obj_4c_Recalcula"
2647: 
2648: 		FOR loc_nI = 1 TO ALEN(loc_aCampos)
2649: 			IF PEMSTATUS(THIS, loc_aCampos[loc_nI], 5)
2650: 				STORE loc_lLiga TO ("THIS." + loc_aCampos[loc_nI] + ".Enabled")
2651: 			ENDIF

*-- Linhas 2707 a 2862:
2707: 	* PUBLIC - chamado de fora da classe pelo harness de teste (CLAUDE.md
2708: 	* regra #3).
2709: 	*====================================================================
2710: 	PROCEDURE AjustarBotoesPorModo()
2711: 		LOCAL loc_lProcessado, loc_nLinhas
2712: 
2713: 		loc_nLinhas = 0
2714: 		IF USED("cursor_4c_Produtos")
2715: 			loc_nLinhas = RECCOUNT("cursor_4c_Produtos")
2716: 		ENDIF
2717: 
2718: 		loc_lProcessado = (THIS.this_cModoAtual == "PROCESSADO") AND (loc_nLinhas > 0)
2719: 
2720: 		IF PEMSTATUS(THIS, "cmg_4c_Acoes", 5)
2721: 			THIS.cmg_4c_Acoes.Buttons(2).Enabled = loc_lProcessado
2722: 			THIS.cmg_4c_Acoes.Buttons(2).Refresh()
2723: 		ENDIF
2724: 
2725: 		IF PEMSTATUS(THIS, "cmd_4c_Imprimir", 5)
2726: 			THIS.cmd_4c_Imprimir.Enabled = loc_lProcessado
2727: 			THIS.cmd_4c_Imprimir.Refresh()
2728: 		ENDIF
2729: 	ENDPROC
2730: 
2731: 	*====================================================================
2732: 	* CarregarLista - Consulta os produtos que atendem aos filtros
2733: 	* correntes (this_oBusinessObject.BuscarProdutosFiltrados, que
2734: 	* transcreve a fase de consulta do metodo "processar" legado) e
2735: 	* transfere o resultado para o cursor da grade - espelha o
2736: 	* "Insert Into crProdutos (Cpros, DPros, ValAnt, CustoAfs) Values
2737: 	* (CrSigCdPro.Cpros, CrSigCdPro.DPros, CrSigCdPro.Pvens,
2738: 	* CrSigCdPro.CustoFs)" do Scan principal do legado.
2739: 	*
2740: 	* PUBLIC (nao PROTECTED) - TesteAutomatico.prg chama metodos do form
2741: 	* direto de fora da classe (CLAUDE.md regra #3).
2742: 	*====================================================================
2743: 	PROCEDURE CarregarLista()
2744: 		LOCAL loc_lSucesso
2745: 		loc_lSucesso = .F.
2746: 
2747: 		IF VARTYPE(THIS.this_oBusinessObject) != "O"
2748: 			RETURN loc_lSucesso
2749: 		ENDIF
2750: 
2751: 		THIS.FormParaBO()
2752: 
2753: 		*-- Guard transcrito do inicio de "processar" legado: Recalcula
2754: 		*-- Markup Custo/Venda (7/8) exige o Novo Codigo do MKP
2755: 		IF INLIST(THIS.this_oBusinessObject.this_nTipoRecalculo, 7, 8) AND ;
2756: 				EMPTY(THIS.this_oBusinessObject.this_cNovoFeitio)
2757: 			IF !THIS.this_lAutomatico
2758: 				MsgAviso("Favor Informar o Novo C" + CHR(243) + "digo do MKP!!!", "Aten" + CHR(231) + CHR(227) + "o")
2759: 				THIS.txt_4c_NovoMkp.SetFocus()
2760: 			ENDIF
2761: 			RETURN loc_lSucesso
2762: 		ENDIF
2763: 
2764: 		IF THIS.this_oBusinessObject.BuscarProdutosFiltrados()
2765: 			IF USED("cursor_4c_Produtos")
2766: 				ZAP IN cursor_4c_Produtos
2767: 			ENDIF
2768: 
2769: 			IF USED("cursor_4c_ProdutosSQL")
2770: 				SELECT cursor_4c_ProdutosSQL
2771: 				SCAN
2772: 					INSERT INTO cursor_4c_Produtos ;
2773: 						(lMarca, cpros, dpros, valant, valatu, custoafs, custofs, ;
2774: 						 pvarias, cvarias, pvideals, fcustos, fvendas, moecs, moevs, cgrus) ;
2775: 					VALUES ;
2776: 						(0, ;
2777: 						 cursor_4c_ProdutosSQL.cpros, ;
2778: 						 cursor_4c_ProdutosSQL.dpros, ;
2779: 						 TratarNulo(cursor_4c_ProdutosSQL.pvens, 0), ;
2780: 						 TratarNulo(cursor_4c_ProdutosSQL.pvens, 0), ;
2781: 						 TratarNulo(cursor_4c_ProdutosSQL.custofs, 0), ;
2782: 						 TratarNulo(cursor_4c_ProdutosSQL.custofs, 0), ;
2783: 						 0, ;
2784: 						 0, ;
2785: 						 TratarNulo(cursor_4c_ProdutosSQL.pvideals, 0), ;
2786: 						 TratarNulo(cursor_4c_ProdutosSQL.fcustos, 0), ;
2787: 						 TratarNulo(cursor_4c_ProdutosSQL.fvendas, 0), ;
2788: 						 TratarNulo(cursor_4c_ProdutosSQL.moecs, ""), ;
2789: 						 TratarNulo(cursor_4c_ProdutosSQL.moevs, ""), ;
2790: 						 TratarNulo(cursor_4c_ProdutosSQL.cgrus, ""))
2791: 				ENDSCAN
2792: 				USE IN cursor_4c_ProdutosSQL
2793: 			ENDIF
2794: 
2795: 			SELECT cursor_4c_Produtos
2796: 			SET ORDER TO cpros
2797: 			GO TOP
2798: 
2799: 			THIS.grd_4c_Produtos.Refresh()
2800: 			loc_lSucesso = .T.
2801: 		ENDIF
2802: 
2803: 		RETURN loc_lSucesso
2804: 	ENDPROC
2805: 
2806: 	*====================================================================
2807: 	* BtnProcessarClick - Espelha Sair.Processa.Click do legado: confirma
2808: 	* reprocessamento se ja existem dados na grade, zera o cursor e chama
2809: 	* CarregarLista(). Ao terminar com sucesso, habilita Atualizar e
2810: 	* Imprimir (This.Parent.Atualiza.Enabled = .T. / ThisForm.Impress?o.
2811: 	* Enabled = .T. do legado) e devolve o foco para a coluna de selecao.
2812: 	*
2813: 	* PUBLIC - alvo de BINDEVENT (CLAUDE.md regra #3).
2814: 	*====================================================================
2815: 	PROCEDURE BtnProcessarClick()
2816: 		*-- "If Thisform.Automatico / =ThisForm.ProcessaAutomatico()" - no modo
2817: 		*-- automatico o botao NAO processa a tela: delega o lote de presets.
2818: 		IF THIS.this_lAutomatico
2819: 			THIS.ProcessaAutomatico()
2820: 			RETURN
2821: 		ENDIF
2822: 
2823: 		IF USED("cursor_4c_Produtos")
2824: 			SELECT cursor_4c_Produtos
2825: 			IF RECCOUNT() > 0
2826: 				IF !MsgConfirma("Existem Dados Gerados. Deseja Reprocessar?", ;
2827: 						"Aten" + CHR(231) + CHR(227) + "o")
2828: 					RETURN
2829: 				ENDIF
2830: 			ENDIF
2831: 		ENDIF
2832: 
2833: 		*-- "Zap In CrProdutos" do legado: descarta o resultado anterior antes
2834: 		*-- de reprocessar (e com ele a foto e o estado dos botoes de acao).
2835: 		THIS.LimparCampos()
2836: 
2837: 		IF THIS.CarregarLista()
2838: 			*-- Filtro de Variacao (%) aplicado DEPOIS do processamento, sobre
2839: 			*-- as linhas ja calculadas - transcricao literal do legado:
2840: 			*--   lnVaria = Thisform.Get_Variacao.Value
2841: 			*--   If lnVaria > 0 -> Delete For PVarias < lnVaria
2842: 			*--   If lnVaria < 0 -> Delete For PVarias > lnVaria
2843: 			*-- O SINAL eh regra: variacao negativa mantem as QUEDAS de preco
2844: 			*-- (descarta o que subiu mais que o limite) e vice-versa.
2845: 			THIS.AplicarFiltroVariacao()
2846: 
2847: 			SELECT cursor_4c_Produtos
2848: 			SET ORDER TO cpros
2849: 			GO TOP
2850: 
2851: 			*-- "This.Parent.Atualiza.Enabled = .T. / Thisform.Impress?o.
2852: 			*-- Enabled = .T." do legado, pelo FUNIL - que tambem recusa
2853: 			*-- habilitar quando o filtro de Variacao apagou TODAS as linhas
2854: 			*-- (grade vazia nao tem o que gravar nem o que imprimir).
2855: 			THIS.this_cModoAtual = "PROCESSADO"
2856: 			THIS.AjustarBotoesPorModo()
2857: 
2858: 			THIS.grd_4c_Produtos.Column1.SetFocus()
2859: 			THIS.grd_4c_Produtos.Refresh()
2860: 		ENDIF
2861: 	ENDPROC
2862: 

*-- Linhas 2871 a 3036:
2871: 	*
2872: 	* Variacao ZERO nao filtra nada (o legado nao tem ramo para ela).
2873: 	* O DELETE so faz a linha desaparecer com SET DELETED ON, reposto em
2874: 	* InicializarForm porque DataSession = 2 nasce com DELETED OFF.
2875: 	*
2876: 	* PUBLIC - chamado tambem por ProcessaAutomatico.
2877: 	*====================================================================
2878: 	PROCEDURE AplicarFiltroVariacao()
2879: 		LOCAL loc_nVariacao
2880: 
2881: 		IF !USED("cursor_4c_Produtos")
2882: 			RETURN
2883: 		ENDIF
2884: 
2885: 		loc_nVariacao = THIS.txt_4c_Variacao.Value
2886: 
2887: 		SELECT cursor_4c_Produtos
2888: 		IF loc_nVariacao > 0
2889: 			DELETE FOR cursor_4c_Produtos.pvarias < loc_nVariacao
2890: 		ENDIF
2891: 		IF loc_nVariacao < 0
2892: 			DELETE FOR cursor_4c_Produtos.pvarias > loc_nVariacao
2893: 		ENDIF
2894: 	ENDPROC
2895: 
2896: 	*====================================================================
2897: 	* BtnAtualizarClick - Espelha Sair.Atualiza.Click do legado, que eh
2898: 	* apenas o disparo do metodo de gravacao:
2899: 	*     If Not ThisForm.Atualizar()
2900: 	*         Return .F.
2901: 	*     EndIf
2902: 	* Toda a logica fica em AtualizarPrecos(), igual ao legado, porque o
2903: 	* modo Automatico tambem a chama direto (sem passar pelo botao).
2904: 	*
2905: 	* PUBLIC - alvo de BINDEVENT (CLAUDE.md regra #3).
2906: 	*====================================================================
2907: 	PROCEDURE BtnAtualizarClick()
2908: 		THIS.AtualizarPrecos()
2909: 	ENDPROC
2910: 
2911: 	*====================================================================
2912: 	* AtualizarPrecos - Transcricao do metodo "atualizar" legado. Grava os
2913: 	* produtos MARCADOS na grade, na ordem exata do legado:
2914: 	*
2915: 	*   1. Confirma "Atualiza ???"                (Automatico assume Sim)
2916: 	*   2. Confirma "Impressao das Etiquetas?"    (Automatico assume Nao)
2917: 	*   3. Exige ao menos um produto marcado      (lMarca = 1)
2918: 	*   4. Le SigCdPaC.nchksubgrs (liga a reclassificacao de subgrupo)
2919: 	*   5. Por produto, DENTRO de uma transacao:
2920: 	*        a) SigCdPrc  <- retrato do registro ANTES da gravacao
2921: 	*        b) SigPrCp2  <- retrato da composicao corrente
2922: 	*        c) SigPrPrt  -> apaga os precos de tabela, agora defasados
2923: 	*        d) SigCdPro  -> grava preco/custo novos + ImpEtiqs (+ sGrus)
2924: 	*   6. Commit se TUDO gravou; Rollback em qualquer falha
2925: 	*   7. Zera a grade e desabilita o proprio botao Atualizar
2926: 	*
2927: 	* A ORDEM de (a)/(b) antes de (d) eh regra, nao detalhe: o historico
2928: 	* guarda o valor ANTIGO. No legado isso acontece porque os cursores
2929: 	* remotos so sao descarregados no poDataMgr.Update() do fim; aqui, como
2930: 	* cada passo grava na hora, inverter (a) e (d) faria o historico
2931: 	* registrar o preco NOVO - errado e sem nenhum sintoma visivel.
2932: 	*
2933: 	* PUBLIC - alvo de BINDEVENT e chamado por ProcessaAutomatico.
2934: 	*====================================================================
2935: 	PROCEDURE AtualizarPrecos()
2936: 		LOCAL loc_lRetorno, loc_lConfirma, loc_nImpEtiq, loc_nMarcados
2937: 		LOCAL loc_oBarra, loc_oBarraFim, loc_nChkSub, loc_cSubGru, loc_nVenda
2938: 		LOCAL loc_lTudoOk, loc_nGravados, loc_cCpros, loc_lProsseguir, loc_oErro
2939: 		LOCAL loc_cAvisoRollback, loc_oErroRb
2940: 
2941: 		loc_lRetorno = .F.
2942: 
2943: 		IF !USED("cursor_4c_Produtos") OR VARTYPE(THIS.this_oBusinessObject) != "O"
2944: 			RETURN loc_lRetorno
2945: 		ENDIF
2946: 
2947: 		*-- 1) "Atualiza ???" - no modo Automatico o legado assume Sim (lnOk = 6)
2948: 		IF THIS.this_lAutomatico
2949: 			loc_lConfirma = .T.
2950: 		ELSE
2951: 			loc_lConfirma = MsgConfirma("Atualiza ???", ;
2952: 				"Altera" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os")
2953: 		ENDIF
2954: 
2955: 		IF !loc_lConfirma
2956: 			RETURN loc_lRetorno
2957: 		ENDIF
2958: 
2959: 		*-- 2) "Confirma a Impressao das Etiquetas?" - o legado grava a resposta
2960: 		*-- em SigCdPro.impetiqs de CADA produto atualizado (m.ImpEtiqs =
2961: 		*-- llImpEtiq) e assume Nao no modo Automatico. NUMERICO 0/1 porque
2962: 		*-- impetiqs eh bit e comparar Logico com 1 estoura type mismatch.
2963: 		IF THIS.this_lAutomatico
2964: 			loc_nImpEtiq = 0
2965: 		ELSE
2966: 			loc_nImpEtiq = IIF(MsgConfirma("Confirma a Impress" + CHR(227) + ;
2967: 				"o das Etiquetas?", "Etiquetas"), 1, 0)
2968: 		ENDIF
2969: 
2970: 		*-- 3) Exige selecao - legado: "Select * From CrProdutos Where lMarca = 1
2971: 		*-- Order By CPros Into Cursor CsProdutos" + "If Eof()"
2972: 		SELECT cursor_4c_Produtos
2973: 		SET ORDER TO cpros
2974: 		COUNT FOR lMarca = 1 TO loc_nMarcados
2975: 
2976: 		IF loc_nMarcados = 0
2977: 			IF !THIS.this_lAutomatico
2978: 				MsgAviso("Nenhum Produto Selecionado !!!", ;
2979: 					"Sele" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
2980: 				THIS.grd_4c_Produtos.Column1.SetFocus()
2981: 			ENDIF
2982: 			RETURN loc_lRetorno
2983: 		ENDIF
2984: 
2985: 		*-- 4) Parametro que liga a reclassificacao de subgrupo por faixa
2986: 		*-- (legado: If crSigCdPac.nChkSubGrs = 1, no fim de "atualizar")
2987: 		loc_nChkSub = THIS.this_oBusinessObject.ObterChkSubGrupos()
2988: 
2989: 		loc_lTudoOk    = .T.
2990: 		loc_nGravados  = 0
2991: 		loc_lProsseguir = .T.
2992: 		loc_oBarra     = .NULL.
2993: 		loc_oBarraFim  = .NULL.
2994: 
2995: 		TRY
2996: 			*-- Trava a entrada durante o lote: a barra de progresso faz o VFP
2997: 			*-- processar eventos, e sem isso o usuario consegue reescrever um
2998: 			*-- filtro ou desmarcar linhas NO MEIO da gravacao - a partir dai a
2999: 			*-- tela deixa de descrever o que esta sendo gravado. Reabilitado
3000: 			*-- DEPOIS do ENDTRY, para valer tambem quando o CATCH dispara.
3001: 			THIS.HabilitarCampos(.F.)
3002: 
3003: 			*-- Barra "Atualizando os Precos..." (loBarra do legado)
3004: 			loc_oBarra = THIS.CriarBarraProgresso("Atualizando os Pre" + CHR(231) + ;
3005: 				"os...", loc_nMarcados)
3006: 
3007: 			IF !THIS.this_oBusinessObject.IniciarTransacao()
3008: 				MsgErro("Sem conex" + CHR(227) + "o com o banco de dados. " + ;
3009: 					"Favor Reinicializar o Processo!!!", "Erro")
3010: 				loc_lProsseguir = .F.
3011: 				loc_lTudoOk     = .F.
3012: 			ENDIF
3013: 
3014: 			IF loc_lProsseguir
3015: 				THIS.this_oBusinessObject.this_nImpEtiqs = loc_nImpEtiq
3016: 
3017: 				SELECT cursor_4c_Produtos
3018: 				SET ORDER TO cpros
3019: 				GO TOP
3020: 				SCAN FOR lMarca = 1
3021: 					loc_cCpros = ALLTRIM(cursor_4c_Produtos.cpros)
3022: 
3023: 					IF VARTYPE(loc_oBarra) = "O"
3024: 						loc_oBarra.Update("Produto: " + loc_cCpros)
3025: 					ENDIF
3026: 
3027: 					WITH THIS.this_oBusinessObject
3028: 						*-- (a) historico do preco ANTIGO + (b) da composicao
3029: 						*-- corrente + (c) expurgo dos precos de tabela: tudo
3030: 						*-- ANTES do UPDATE de SigCdPro
3031: 						IF !.GravarHistoricoPreco(loc_cCpros)
3032: 							loc_lTudoOk = .F.
3033: 						ENDIF
3034: 
3035: 						IF loc_lTudoOk AND !.GravarHistoricoComposicao(loc_cCpros)
3036: 							loc_lTudoOk = .F.

*-- Linhas 3043 a 3203:
3043: 						IF loc_lTudoOk
3044: 							*-- Reclassificacao de subgrupo por faixa de preco.
3045: 							*-- Legado: "If crSigCdPro.pVens = 0 -> lnPVens =
3046: 							*-- grSigCdPro.pvideals / Else lnPVens = grSigCdPro.pVens"
3047: 							IF loc_nChkSub = 1
3048: 								loc_nVenda = IIF(cursor_4c_Produtos.valatu = 0, ;
3049: 									cursor_4c_Produtos.pvideals, cursor_4c_Produtos.valatu)
3050: 								loc_cSubGru = .ResolverSubGrupoPorFaixa( ;
3051: 									ALLTRIM(cursor_4c_Produtos.cgrus), loc_nVenda)
3052: 								.this_cSubGrupo          = loc_cSubGru
3053: 								.this_lAtualizarSubGrupo = !EMPTY(loc_cSubGru)
3054: 							ELSE
3055: 								.this_cSubGrupo          = ""
3056: 								.this_lAtualizarSubGrupo = .F.
3057: 							ENDIF
3058: 
3059: 							*-- (d) preco/custo novos em SigCdPro
3060: 							.this_cCpros            = cursor_4c_Produtos.cpros
3061: 							.this_cDescricaoProduto = cursor_4c_Produtos.dpros
3062: 							.this_nCustoAtual       = cursor_4c_Produtos.custofs
3063: 							.this_nVendaAtual       = cursor_4c_Produtos.valatu
3064: 							.this_nVendaIdeal       = cursor_4c_Produtos.pvideals
3065: 							.this_nFatorCusto       = cursor_4c_Produtos.fcustos
3066: 							.this_nFatorVenda       = cursor_4c_Produtos.fvendas
3067: 							.this_cMoedaCusto       = cursor_4c_Produtos.moecs
3068: 							.this_cMoedaVenda       = cursor_4c_Produtos.moevs
3069: 
3070: 							*-- BusinessBase.Salvar ja reporta a falha sozinho
3071: 							*-- (CLAUDE.md regra #20) - nao repetir a mensagem
3072: 							IF .EditarRegistro() AND .Salvar()
3073: 								loc_nGravados = loc_nGravados + 1
3074: 							ELSE
3075: 								loc_lTudoOk = .F.
3076: 							ENDIF
3077: 						ENDIF
3078: 					ENDWITH
3079: 
3080: 					IF !loc_lTudoOk
3081: 						EXIT
3082: 					ENDIF
3083: 
3084: 					SELECT cursor_4c_Produtos
3085: 				ENDSCAN
3086: 			ENDIF
3087: 
3088: 			IF VARTYPE(loc_oBarra) = "O"
3089: 				loc_oBarra.Complete(.T.)
3090: 				loc_oBarra = .NULL.
3091: 			ENDIF
3092: 
3093: 			IF loc_lProsseguir
3094: 				*-- Barra "Atualizando Fisicamente os Arquivos..." (loBarraFim)
3095: 				loc_oBarraFim = THIS.CriarBarraProgresso("Atualizando Fisicamente " + ;
3096: 					"os Arquivos...", 2)
3097: 
3098: 				IF loc_lTudoOk
3099: 					IF VARTYPE(loc_oBarraFim) = "O"
3100: 						loc_oBarraFim.Update("Confirmando a grava" + CHR(231) + CHR(227) + "o...")
3101: 					ENDIF
3102: 
3103: 					loc_lTudoOk = THIS.this_oBusinessObject.ConfirmarTransacao()
3104: 
3105: 					IF !loc_lTudoOk AND !THIS.this_lAutomatico
3106: 						MsgAviso("Falha na Atualiza" + CHR(231) + CHR(227) + ;
3107: 							"o. Reinicie o Processo !!!", "Confirma" + CHR(231) + CHR(227) + "o")
3108: 					ENDIF
3109: 				ELSE
3110: 					IF VARTYPE(loc_oBarraFim) = "O"
3111: 						loc_oBarraFim.Update("Desfazendo a grava" + CHR(231) + CHR(227) + "o...")
3112: 					ENDIF
3113: 
3114: 					THIS.this_oBusinessObject.DesfazerTransacao()
3115: 
3116: 					IF !THIS.this_lAutomatico
3117: 						MsgAviso("Falha na Atualiza" + CHR(231) + CHR(227) + ;
3118: 							"o. Reinicie o Processo !!!", "Confirma" + CHR(231) + CHR(227) + "o")
3119: 					ENDIF
3120: 				ENDIF
3121: 
3122: 				IF VARTYPE(loc_oBarraFim) = "O"
3123: 					loc_oBarraFim.Complete(.T.)
3124: 					loc_oBarraFim = .NULL.
3125: 				ENDIF
3126: 
3127: 				IF loc_lTudoOk AND !THIS.this_lAutomatico
3128: 					MsgInfo("Processamento Finalizado com Sucesso !!!", "Confirmar")
3129: 				ENDIF
3130: 
3131: 				*-- 7) O legado zera TODOS os cursores de trabalho no fim, com
3132: 				*-- sucesso OU com falha (os Zap ficam fora do If llOk). Aqui so
3133: 				*-- existe o cursor local da grade, e quem o zera eh
3134: 				*-- LimparCampos - que faz o ZAP (nao USE IN + CREATE CURSOR,
3135: 				*-- que derrubaria RecordSource/ControlSource do Grid), esconde a
3136: 				*-- foto e devolve a tela ao modo "LISTA", desabilitando
3137: 				*-- Atualizar/Imprimir junto ("ThisForm.Sair.Atualiza.Enabled =
3138: 				*-- .F." do Init, repetido na ultima linha de "atualizar").
3139: 				THIS.LimparCampos()
3140: 
3141: 				loc_lRetorno = loc_lTudoOk
3142: 			ENDIF
3143: 		CATCH TO loc_oErro
3144: 			*-- Qualquer excecao no meio do lote desfaz TUDO: gravacao parcial de
3145: 			*-- preco eh pior que gravacao nenhuma. O rollback vai num TRY
3146: 			*-- proprio porque ele tambem pode falhar (conexao caida) e nesse
3147: 			*-- caso o que interessa reportar eh o erro ORIGINAL - mas a falha
3148: 			*-- do rollback entra na mensagem, senao ninguem fica sabendo que
3149: 			*-- a gravacao ficou incompleta.
3150: 			loc_cAvisoRollback = ""
3151: 			TRY
3152: 				THIS.this_oBusinessObject.DesfazerTransacao()
3153: 			CATCH TO loc_oErroRb
3154: 				loc_cAvisoRollback = CHR(13) + "ATEN" + CHR(199) + CHR(195) + ;
3155: 					"O: falha ao desfazer a grava" + CHR(231) + CHR(227) + "o (" + ;
3156: 					loc_oErroRb.Message + ") - conferir os pre" + CHR(231) + ;
3157: 					"os dos produtos marcados."
3158: 			ENDTRY
3159: 
3160: 			MsgErro("Erro ao atualizar os pre" + CHR(231) + "os:" + CHR(13) + ;
3161: 				loc_oErro.Message + CHR(13) + ;
3162: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3163: 				"Procedure: " + loc_oErro.Procedure + loc_cAvisoRollback, "Erro")
3164: 
3165: 			loc_lRetorno = .F.
3166: 		ENDTRY
3167: 
3168: 		*-- Libera as barras tambem quando o CATCH disparou no meio
3169: 		IF VARTYPE(loc_oBarra) = "O"
3170: 			loc_oBarra.Release()
3171: 		ENDIF
3172: 		IF VARTYPE(loc_oBarraFim) = "O"
3173: 			loc_oBarraFim.Release()
3174: 		ENDIF
3175: 
3176: 		*-- Devolve a entrada ao usuario. Fica aqui, junto da liberacao das
3177: 		*-- barras, para valer TAMBEM quando o CATCH disparou: deixar a tela
3178: 		*-- travada depois de um erro seria pior que o erro.
3179: 		THIS.HabilitarCampos(.T.)
3180: 
3181: 		*-- "This.Enabled = .F. / This.Refresh" do fim do metodo legado.
3182: 		*--
3183: 		*-- DIVERGENCIA DELIBERADA, em dois pontos, por bug do legado:
3184: 		*--
3185: 		*-- 1) ALVO. "atualizar" eh metodo do FORM, entao ali "This" eh o FORM,
3186: 		*--    nao o botao. Medido no VFP9 (2026-09-26): Form.Enabled = .F. eh
3187: 		*--    aceito e NAO mexe no Enabled dos filhos - o form simplesmente
3188: 		*--    para de receber input. Como esta tela eh modal com TitleBar = 0,
3189: 		*--    ControlBox = .F. e Closable = .F., reproduzir isso ao pe da letra
3190: 		*--    deixaria o usuario SEM SAIDA (nem Encerrar responderia) e nada no
3191: 		*--    legado reabilita o form. O alvo pretendido eh o BOTAO Atualizar:
3192: 		*--    "Processa.Click" faz "This.Parent.Atualiza.Enabled = .T.", isto
3193: 		*--    eh, so o botao Atualizar eh reabilitado - Processar/Atualizar
3194: 		*--    formam um ciclo coerente, Processar/Form nao formam nenhum.
3195: 		*--
3196: 		*-- 2) ALCANCE. No legado a linha fica FORA do "If lnOk = 6", entao
3197: 		*--    recusar "Atualiza ???" ou nao ter produto marcado tambem
3198: 		*--    desabilitava - travando a tela sem ter gravado nada. Aqui os
3199: 		*--    caminhos de recusa saem ANTES (RETURN acima do TRY) e nada muda:
3200: 		*--    so desabilita quando a gravacao realmente rodou, que eh quando a
3201: 		*--    grade foi zerada e de fato nao ha mais o que gravar.
3202: 		*--
3203: 		*-- Passa pelo FUNIL (e nao por atribuicao direta ao Enabled do botao)

*-- Linhas 3228 a 3514:
3228: 		ENDIF
3229: 
3230: 		TRY
3231: 			loc_oBarra = CREATEOBJECT("fwprogressbar", par_cTitulo, par_nTotal)
3232: 
3233: 			IF VARTYPE(loc_oBarra) = "O"
3234: 				loc_oBarra.Show()
3235: 			ELSE
3236: 				loc_oBarra = .NULL.
3237: 			ENDIF
3238: 		CATCH TO loc_oErro
3239: 			*-- Barra de progresso eh cosmetica: falhar em cria-la NAO pode
3240: 			*-- impedir a gravacao, mas tambem nao pode passar calado
3241: 			MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir a barra " + ;
3242: 				"de progresso (" + loc_oErro.Message + "). O processamento " + ;
3243: 				"continua sem ela.", "Aviso")
3244: 			loc_oBarra = .NULL.
3245: 		ENDTRY
3246: 
3247: 		RETURN loc_oBarra
3248: 	ENDFUNC
3249: 
3250: 	*====================================================================
3251: 	* ProcessaAutomatico - Transcricao do metodo "processaautomatico"
3252: 	* legado: percorre os presets ATIVOS de SigCdCcp (Inativas <> 1),
3253: 	* joga cada preset nos campos da tela, processa e ATUALIZA sem
3254: 	* interacao nenhuma; ao terminar, fecha o formulario.
3255: 	*
3256: 	* Aborta o lote no primeiro preset cuja atualizacao falhar - o "If Not
3257: 	* ThisForm.Atualizar() / Exit / EndIf" do legado - para nao seguir
3258: 	* gravando em cima de uma base em estado incerto.
3259: 	*
3260: 	* PUBLIC - chamado por BtnProcessarClick e pelo Init (par_lAutomatico).
3261: 	*====================================================================
3262: 	PROCEDURE ProcessaAutomatico()
3263: 		LOCAL loc_lRetorno, loc_oErro
3264: 		loc_lRetorno = .F.
3265: 
3266: 		IF VARTYPE(THIS.this_oBusinessObject) != "O"
3267: 			RETURN loc_lRetorno
3268: 		ENDIF
3269: 
3270: 		TRY
3271: 			IF USED("cursor_4c_Produtos")
3272: 				ZAP IN cursor_4c_Produtos
3273: 			ENDIF
3274: 
3275: 			IF THIS.this_oBusinessObject.BuscarPresetsAutomaticos() AND ;
3276: 					USED("cursor_4c_PresetsCcp")
3277: 
3278: 				loc_lRetorno = .T.
3279: 
3280: 				SELECT cursor_4c_PresetsCcp
3281: 				GO TOP
3282: 				SCAN
3283: 					IF USED("cursor_4c_Produtos")
3284: 						ZAP IN cursor_4c_Produtos
3285: 					ENDIF
3286: 
3287: 					SELECT cursor_4c_PresetsCcp
3288: 					THIS.AplicarPresetNaTela()
3289: 
3290: 					IF THIS.CarregarLista()
3291: 						THIS.AplicarFiltroVariacao()
3292: 
3293: 						SELECT cursor_4c_Produtos
3294: 						SET ORDER TO cpros
3295: 						GO TOP
3296: 
3297: 						*-- O legado marca implicitamente: "atualizar" grava so
3298: 						*-- lMarca = 1, e no modo automatico nao ha usuario para
3299: 						*-- clicar - "cmdSelemp.Click" (Update Set lMarca = 1) eh
3300: 						*-- o equivalente de "todos os produtos do preset"
3301: 						UPDATE cursor_4c_Produtos SET lMarca = 1
3302: 
3303: 						IF !THIS.AtualizarPrecos()
3304: 							loc_lRetorno = .F.
3305: 							EXIT
3306: 						ENDIF
3307: 					ENDIF
3308: 
3309: 					SELECT cursor_4c_PresetsCcp
3310: 				ENDSCAN
3311: 
3312: 				IF USED("cursor_4c_PresetsCcp")
3313: 					USE IN cursor_4c_PresetsCcp
3314: 				ENDIF
3315: 			ENDIF
3316: 		CATCH TO loc_oErro
3317: 			MsgErro("Erro no processamento autom" + CHR(225) + "tico:" + CHR(13) + ;
3318: 				loc_oErro.Message + CHR(13) + ;
3319: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3320: 				"Procedure: " + loc_oErro.Procedure, "Erro")
3321: 			loc_lRetorno = .F.
3322: 		ENDTRY
3323: 
3324: 		*-- "ThisForm.Sair.Cancela.Click()" da ultima linha do legado: o modo
3325: 		*-- automatico fecha a tela sozinho quando termina o lote
3326: 		THIS.BtnEncerrarClick()
3327: 
3328: 		RETURN loc_lRetorno
3329: 	ENDPROC
3330: 
3331: 	*====================================================================
3332: 	* AplicarPresetNaTela - Copia o preset corrente de cursor_4c_PresetsCcp
3333: 	* para os controles da tela, na ORDEM e com os PARES exatos do metodo
3334: 	* "processaautomatico" legado (Thisform.getCFornecs.Value =
3335: 	* crSigCdCcp.cfornecs, etc.). Escrever nos CONTROLES, e nao direto nas
3336: 	* properties do BO, eh o que o legado faz - e o que mantem a tela
3337: 	* coerente com o que esta sendo processado, alem de deixar
3338: 	* FormParaBO como fonte unica dos filtros.
3339: 	*
3340: 	* Opc_Compra NAO recebe nada: o legado tambem nao o inclui no preset
3341: 	* (SigCdCcp nao tem coluna para ele) - fica no valor corrente da tela.
3342: 	*
3343: 	* PUBLIC - chamado por ProcessaAutomatico.
3344: 	*====================================================================
3345: 	PROCEDURE AplicarPresetNaTela()
3346: 		IF !USED("cursor_4c_PresetsCcp")
3347: 			RETURN
3348: 		ENDIF
3349: 
3350: 		SELECT cursor_4c_PresetsCcp
3351: 
3352: 		*-- Filtros
3353: 		THIS.txt_4c_Fornecedor.Value    = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.cfornecs, ""))
3354: 		THIS.txt_4c_GrandeGrupoI.Value  = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.merci, ""))
3355: 		THIS.txt_4c_GrandeGrupoF.Value  = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.mercf, ""))
3356: 		THIS.txt_4c_GrupoI.Value        = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.cgrui, ""))
3357: 		THIS.txt_4c_GrupoF.Value        = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.cgruf, ""))
3358: 		THIS.txt_4c_SubGrupoI.Value     = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.sgrui, ""))
3359: 		THIS.txt_4c_SubGrupoF.Value     = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.sgruf, ""))
3360: 		THIS.txt_4c_UnidadeI.Value      = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.cunii, ""))
3361: 		THIS.txt_4c_UnidadeF.Value      = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.cunif, ""))
3362: 		THIS.txt_4c_LinhaI.Value        = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.lini, ""))
3363: 		THIS.txt_4c_LinhaF.Value        = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.linf, ""))
3364: 		THIS.txt_4c_ColecaoI.Value      = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.coli, ""))
3365: 		THIS.txt_4c_ColecaoF.Value      = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.colf, ""))
3366: 		THIS.txt_4c_MoedaI.Value        = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.moedai, ""))
3367: 		THIS.txt_4c_MoedaF.Value        = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.moedaf, ""))
3368: 		THIS.txt_4c_MarkupI.Value       = TratarNulo(cursor_4c_PresetsCcp.mrki, 0)
3369: 		THIS.txt_4c_MarkupF.Value       = TratarNulo(cursor_4c_PresetsCcp.mrkf, 0)
3370: 		THIS.txt_4c_EncargoI.Value      = TratarNulo(cursor_4c_PresetsCcp.enci, 0)
3371: 		THIS.txt_4c_EncargoF.Value      = TratarNulo(cursor_4c_PresetsCcp.encf, 0)
3372: 		THIS.txt_4c_Variacao.Value      = TratarNulo(cursor_4c_PresetsCcp.variacao, 0)
3373: 		THIS.txt_4c_Feitio.Value        = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.feitio, ""))
3374: 
3375: 		*-- Dados
3376: 		THIS.txt_4c_Reajuste.Value      = TratarNulo(cursor_4c_PresetsCcp.reajuste, 0)
3377: 		THIS.txt_4c_NovoEncargo.Value   = TratarNulo(cursor_4c_PresetsCcp.encargo, 0)
3378: 		THIS.txt_4c_NovoMarkup.Value    = TratarNulo(cursor_4c_PresetsCcp.nmrk, 0)
3379: 		THIS.txt_4c_NovoMkp.Value       = ALLTRIM(TratarNulo(cursor_4c_PresetsCcp.newmkp, ""))
3380: 
3381: 		*-- OptionGroups: Value eh o INDICE do botao (1..ButtonCount) e o VFP9
3382: 		*-- recusa indice fora da faixa, derrubando o lote inteiro por causa de
3383: 		*-- UM preset com valor invalido - por isso a normalizacao abaixo. Zero
3384: 		*-- eh legal e significa "nenhum botao marcado".
3385: 		THIS.AplicarValorOptionGroup(THIS.obj_4c_OpcaoMoeda, ;
3386: 			TratarNulo(cursor_4c_PresetsCcp.opcmoedatp, 0))
3387: 		THIS.AplicarValorOptionGroup(THIS.obj_4c_Situacao, ;
3388: 			TratarNulo(cursor_4c_PresetsCcp.opcsit, 0))
3389: 		THIS.AplicarValorOptionGroup(THIS.obj_4c_Recalcula, ;
3390: 			TratarNulo(cursor_4c_PresetsCcp.opcrecalc, 0))
3391: 		THIS.AplicarValorOptionGroup(THIS.obj_4c_AtualizaVenda, ;
3392: 			TratarNulo(cursor_4c_PresetsCcp.opcpven, 0))
3393: 
3394: 		*-- Recalcula comanda o Enabled de Reajuste/Markup/Variacao/NovoMkp
3395: 		THIS.AtualizarEstadoCalculo()
3396: 		THIS.Refresh()
3397: 	ENDPROC
3398: 
3399: 	*====================================================================
3400: 	* AplicarValorOptionGroup - Atribui o indice do botao marcado a um
3401: 	* OptionGroup, recusando indice fora da faixa 0..ButtonCount (o VFP9
3402: 	* dispara erro de propriedade invalida, e o valor vem de SigCdCcp, que
3403: 	* eh dado de usuario). Fora da faixa, mantem o valor corrente.
3404: 	*====================================================================
3405: 	PROTECTED PROCEDURE AplicarValorOptionGroup(par_oGrupo, par_nValor)
3406: 		IF VARTYPE(par_oGrupo) != "O" OR VARTYPE(par_nValor) != "N"
3407: 			RETURN
3408: 		ENDIF
3409: 
3410: 		IF BETWEEN(par_nValor, 0, par_oGrupo.ButtonCount)
3411: 			par_oGrupo.Value = par_nValor
3412: 		ENDIF
3413: 	ENDPROC
3414: 
3415: 	*====================================================================
3416: 	* BtnEncerrarClick - Espelha Sair.Cancela.Click (ThisForm.Release) do
3417: 	* legado. PUBLIC - alvo de BINDEVENT (CLAUDE.md regra #3).
3418: 	*====================================================================
3419: 	PROCEDURE BtnEncerrarClick()
3420: 		THIS.Release()
3421: 	ENDPROC
3422: 
3423: 	*====================================================================
3424: 	* BtnCancelarClick - Mesmo botao acima visto pelo OUTRO nome que o
3425: 	* legado lhe da: no SCX o objeto chama-se "Cancela" e tem Cancel = .T.,
3426: 	* isto eh, ESC cai nele; a Caption exibida eh "Encerrar". Nao ha um
3427: 	* segundo botao a migrar - esta tela nao tem Page2 de Dados nem modo de
3428: 	* edicao cancelavel, e o UNICO caminho de saida eh o Encerrar.
3429: 	*
3430: 	* Delega em vez de duplicar: a logica de saida tem de existir em um
3431: 	* lugar so, senao um dos dois caminhos fica para tras na proxima
3432: 	* mudanca.
3433: 	*
3434: 	* PUBLIC - alvo de BINDEVENT e do harness de teste (CLAUDE.md regra #3).
3435: 	*====================================================================
3436: 	PROCEDURE BtnCancelarClick()
3437: 		THIS.BtnEncerrarClick()
3438: 	ENDPROC
3439: 
3440: 	*====================================================================
3441: 	* BtnSelTudoClick - Espelha cmdSelemp.Click (Update CrProdutos Set
3442: 	* lMarca = 1) do legado. PUBLIC - alvo de BINDEVENT.
3443: 	*====================================================================
3444: 	PROCEDURE BtnSelTudoClick()
3445: 		IF USED("cursor_4c_Produtos")
3446: 			UPDATE cursor_4c_Produtos SET lMarca = 1
3447: 			THIS.grd_4c_Produtos.Refresh()
3448: 		ENDIF
3449: 	ENDPROC
3450: 
3451: 	*====================================================================
3452: 	* BtnApagaClick - Espelha CmdApgEmp.Click (Update CrProdutos Set
3453: 	* lMarca = 0) do legado. PUBLIC - alvo de BINDEVENT.
3454: 	*====================================================================
3455: 	PROCEDURE BtnApagaClick()
3456: 		IF USED("cursor_4c_Produtos")
3457: 			UPDATE cursor_4c_Produtos SET lMarca = 0
3458: 			THIS.grd_4c_Produtos.Refresh()
3459: 		ENDIF
3460: 	ENDPROC
3461: 
3462: 	*====================================================================
3463: 	* BtnImprimirClick - Espelha Impress?o.Click (Do Form SigPrCcr) do
3464: 	* legado, abrindo o relatorio ja migrado (FormSIGPRCCR).
3465: 	* PUBLIC - alvo de BINDEVENT.
3466: 	*====================================================================
3467: 	PROCEDURE BtnImprimirClick()
3468: 		LOCAL loc_oForm, loc_oErro, loc_lErroExibido
3469: 
3470: 		loc_oForm        = .NULL.
3471: 		loc_lErroExibido = .F.
3472: 
3473: 		*-- O TRY cobre SO a criacao. Com o Show() dentro dele, o relatorio eh
3474: 		*-- modal: a chamada BLOQUEIA e toda a vida daquela tela (cada Valid,
3475: 		*-- cada Click) passa a rodar dentro deste bloco - e em VFP9 o TRY tem
3476: 		*-- precedencia sobre ON ERROR em qualquer ponto da pilha, entao o
3477: 		*-- primeiro erro de runtime la dentro salta para o CATCH daqui,
3478: 		*-- abandona o TRY, derruba a referencia LOCAL e o relatorio se fecha
3479: 		*-- sozinho sem nada no log (CLAUDE.md regra #29).
3480: 		TRY
3481: 			loc_oForm = CREATEOBJECT("FormSIGPRCCR")
3482: 		CATCH TO loc_oErro
3483: 			MsgErro("Erro ao abrir relat" + CHR(243) + "rio:" + CHR(13) + ;
3484: 				loc_oErro.Message + CHR(13) + ;
3485: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3486: 				"Procedure: " + loc_oErro.Procedure, "Erro")
3487: 			loc_oForm        = .NULL.
3488: 			loc_lErroExibido = .T.
3489: 		ENDTRY
3490: 
3491: 		IF VARTYPE(loc_oForm) = "O"
3492: 			loc_oForm.Show()
3493: 		ELSE
3494: 			*-- Guarda contra mensagem DUPLA: o CATCH acima ja reportou a
3495: 			*-- excecao com linha e procedure. Aqui so avisa quando
3496: 			*-- CREATEOBJECT devolveu nao-objeto SEM disparar excecao (Init do
3497: 			*-- relatorio que devolve .F.).
3498: 			IF !loc_lErroExibido
3499: 				MsgErro("Erro ao abrir o relat" + CHR(243) + "rio de rec" + ;
3500: 					CHR(225) + "lculo.", "Erro")
3501: 			ENDIF
3502: 		ENDIF
3503: 	ENDPROC
3504: 
3505: 	*====================================================================
3506: 	* Destroy - o BO nao abre conexao temporaria propria (usa apenas
3507: 	* gnConnHandle global), entao nao ha recurso proprio para liberar
3508: 	* alem do que FormBase.Destroy() ja faz (menu-shrink fix).
3509: 	*====================================================================
3510: 	PROCEDURE Destroy()
3511: 		DODEFAULT()
3512: 	ENDPROC
3513: 
3514: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprccpBO.prg):
*====================================================================
* sigprccpBO.prg
*
* Business Object para sigprccp (Recalculo de Precos)
* Tabela principal atualizada pelo processamento: SigCdPro (cpros)
* Tabela de presets de filtro (somente LEITURA, nunca gravada por
* este form): SigCdCcp (cIdChaves)
*
* Form legado: SIGPRCCP - "Recalculo de Precos"
* Forma OPERACIONAL: recalcula Custo/Venda de produtos filtrados,
* grava o resultado em SigCdPro e registra o historico do calculo.
*====================================================================

DEFINE CLASS sigprccpBO AS BusinessBase

	*-- Modo de execucao (Automatico = .T. quando chamado via ProcessarAutomatico,
	*-- percorrendo os presets de SigCdCcp; .F. quando disparado manualmente)
	this_lAutomatico = .F.

	*-- Filtros - Fornecedor
	this_cFornecs = ""
	this_cDFornecs = ""

	*-- Filtros - Faixas de classificacao do produto (SigCdCcp.merci/mercf etc)
	this_cMercI = ""
	this_cMercF = ""
	this_cGrupoI = ""
	this_cGrupoF = ""
	this_cSubGrupoI = ""
	this_cSubGrupoF = ""
	this_cUnidadeI = ""
	this_cUnidadeF = ""
	this_cLinhaI = ""
	this_cLinhaF = ""
	this_cColecaoI = ""
	this_cColecaoF = ""
	this_cMoedaI = ""
	this_cMoedaF = ""

	*-- Filtros - Faixas numericas (Markup/Encargo/Variacao)
	this_nMarkupI = 0
	this_nMarkupF = 0
	this_nEncargoI = 0
	this_nEncargoF = 0
	this_nVariacao = 0

	*-- Filtros - Feitio (SigPrFti) usado como referencia de calculo
	this_cFeitio = ""

	*-- Opcoes de processamento (OptionGroups do form - valores 1-based).
	*-- this_nAtualizaVenda=2 ("Nao") e this_nOpcaoCompra=3 ("Todos") sao
	*-- os defaults EXATOS do SCX legado (Opc_pven.Value=2/Opc_Compra.Value=3)
	this_nOpcaoMoeda = 1
	this_nSituacao = 1
	this_nTipoRecalculo = 1
	this_nAtualizaVenda = 2
	this_nOpcaoCompra = 3

	*-- Dados de recalculo
	this_nReajuste = 0
	this_nNovoEncargo = 0
	this_nNovoMarkup = 0
	this_cNovoFeitio = ""

	*-- Produto corrente (linha da grade marcada para gravacao do preco
	*-- recalculado) - mapeia SigCdPro.cpros, o registro efetivamente
	*-- atualizado por Inserir/Atualizar/ObterChavePrimaria/CarregarDoCursor
	this_cCpros = ""                && cpros char(14) - PK
	this_cDescricaoProduto = ""     && dpros char(65) - somente referencia
	this_nCustoAtual = 0            && custofs numeric(11,3)
	this_nVendaAtual = 0            && pvens numeric(11,5)
	this_nVendaIdeal = 0            && pvideals numeric(11,5)
	this_nFatorCusto = 0            && fcustos numeric(11,5)
	this_nFatorVenda = 0            && fvendas numeric(7,3)
	this_cMoedaCusto = ""           && moecs char(3)
	this_cMoedaVenda = ""           && moevs char(3)

	*-- Flag "Confirma a Impressao das Etiquetas?" do metodo "atualizar"
	*-- legado (m.ImpEtiqs = llImpEtiq gravado junto com o preco novo).
	*-- NUMERICO 0/1 porque impetiqs eh bit e o CheckBox/confirmacao do
	*-- form trabalha com 0/1 (nunca .T./.F.)
	this_nImpEtiqs = 0              && impetiqs bit

	*-- Subgrupo recalculado por faixa de preco (SigCdPsg.nfaixafins),
	*-- aplicado somente quando SigCdPaC.nchksubgrs = 1 - transcricao do
	*-- bloco "If crSigCdPac.nChkSubGrs = 1 ... Replace sGrus With
	*-- csSigCdPsg.Codigos" do metodo "atualizar" legado.
	*-- this_lAtualizarSubGrupo controla se Atualizar() inclui sgrus no
	*-- UPDATE: o legado so troca o subgrupo quando acha a faixa.
	this_cSubGrupo = ""             && sgrus char(6)
	this_lAtualizarSubGrupo = .F.

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		*-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
		*-- Tabela efetivamente atualizada pelo processamento (SigCdPro),
		*-- pois SigCdCcp (presets de filtro) e somente LEITURA neste form.
		THIS.this_cTabela = "SigCdPro"
		THIS.this_cCampoChave = "cpros"

		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna a chave do produto sendo gravado
	* (usada por RegistrarAuditoria em Atualizar)
	*====================================================================
	FUNCTION ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCpros)
	ENDFUNC

	*====================================================================
	* CarregarDoCursor - Carrega os dados do produto (linha da grade de
	* recalculo) para as propriedades this_c*/this_n* correspondentes.
	* REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				*-- TratarNulo(valor, PADRAO): o 2o argumento eh o VALOR default do
				*-- tipo da coluna, NUNCA um codigo de tipo ("C"/"N") - com a coluna
				*-- NULL, "C" gravaria a string literal "C" na property e "N" poria
				*-- uma STRING numa property this_n*, estourando FormatarNumeroSQL.
				THIS.this_cCpros            = TratarNulo(cpros,    "")
				THIS.this_cDescricaoProduto = TratarNulo(dpros,    "")
				THIS.this_nCustoAtual       = TratarNulo(custofs,  0)
				THIS.this_nVendaAtual       = TratarNulo(pvens,    0)
				THIS.this_nVendaIdeal       = TratarNulo(pvideals, 0)
				THIS.this_nFatorCusto       = TratarNulo(fcustos,  0)
				THIS.this_nFatorVenda       = TratarNulo(fvendas,  0)
				THIS.this_cMoedaCusto       = TratarNulo(moecs,    "")
				THIS.this_cMoedaVenda       = TratarNulo(moevs,    "")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao carregar produto do cursor:" + CHR(13) + ;
				loException.Message, "sigprccpBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Grava o preco/custo recalculado de volta em SigCdPro
	* Equivalente a PROCEDURE atualizar do legado: Scatter/Gather do
	* registro com DataAlts/UsuaAlts atualizados e commit do preco novo.
	*
	* Inserir()/ExecutarExclusao() NAO sao sobrescritos neste BO: o
	* recalculo so ATUALIZA produtos ja cadastrados em SigCdPro - nunca
	* cria nem apaga produto - entao o comportamento herdado de
	* BusinessBase (recusar a operacao) ja eh o correto para os dois.
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_cSubGru, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- sgrus so entra no UPDATE quando a faixa de SigCdPsg foi
			*-- localizada (legado: "If ! Eof() / Replace sGrus With
			*-- csSigCdPsg.Codigos") - fora disso o subgrupo nao se mexe.
			loc_cSubGru = ""
			IF THIS.this_lAtualizarSubGrupo AND !EMPTY(ALLTRIM(THIS.this_cSubGrupo))
				loc_cSubGru = "sgrus = " + ;
					EscaparSQL(LEFT(ALLTRIM(THIS.this_cSubGrupo), 6)) + ","
			ENDIF

			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigCdPro
				SET custofs  = <<FormatarNumeroSQL(THIS.this_nCustoAtual, 3)>>,
					pvens    = <<FormatarNumeroSQL(THIS.this_nVendaAtual, 5)>>,
					pvideals = <<FormatarNumeroSQL(THIS.this_nVendaIdeal, 5)>>,
					fcustos  = <<FormatarNumeroSQL(THIS.this_nFatorCusto, 5)>>,
					fvendas  = <<FormatarNumeroSQL(THIS.this_nFatorVenda, 3)>>,
					moecs    = <<EscaparSQL(THIS.this_cMoedaCusto)>>,
					moevs    = <<EscaparSQL(THIS.this_cMoedaVenda)>>,
					impetiqs = <<FormatarNumeroSQL(IIF(THIS.this_nImpEtiqs = 1, 1, 0), 0)>>,
					<<loc_cSubGru>>
					dtalts   = GETDATE(),
					usuaalts = <<EscaparSQL(LEFT(gc_4c_UsuarioLogado, 20))>>
				WHERE cpros = <<EscaparSQL(THIS.this_cCpros)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao atualizar pre" + CHR(231) + "o do produto:" + ;
					CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "sigprccpBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* AcrescentarFaixa - Helper de MontarWhereFiltros: acrescenta a faixa
	* (BETWEEN/>=/<=) de UM campo a clausula WHERE em construcao. Espelha
	* o corpo do "For lnConta = 1 To 7" do metodo "processar" legado
	* (SIGPRCCP): so entra em ">= "/"<= "/"Between" quando pelo menos um
	* dos limites foi informado, e "And" so precede quando ja existe algo
	* acumulado em par_cWhereAtual.
	*====================================================================
	PROTECTED FUNCTION AcrescentarFaixa(par_cWhereAtual, par_cCampo, par_cInicio, par_cFim)
		LOCAL loc_cWhere, loc_cIni, loc_cFim
		loc_cWhere = par_cWhereAtual
		loc_cIni   = ALLTRIM(TratarNulo(par_cInicio, ""))
		loc_cFim   = ALLTRIM(TratarNulo(par_cFim, ""))

		IF !EMPTY(loc_cIni) OR !EMPTY(loc_cFim)
			IF !EMPTY(loc_cWhere)
				loc_cWhere = loc_cWhere + " And "
			ENDIF

			IF EMPTY(loc_cIni)
				loc_cWhere = loc_cWhere + par_cCampo + " <= " + EscaparSQL(loc_cFim)
			ELSE
				IF EMPTY(loc_cFim)
					loc_cWhere = loc_cWhere + par_cCampo + " >= " + EscaparSQL(loc_cIni)
				ELSE
					loc_cWhere = loc_cWhere + par_cCampo + " Between " + ;
						EscaparSQL(loc_cIni) + " And " + EscaparSQL(loc_cFim)
				ENDIF
			ENDIF
		ENDIF

		RETURN loc_cWhere
	ENDFUNC

	*====================================================================
	* MontarWhereFiltros - Constroi a clausula WHERE dos filtros de faixa
	* (Grande Grupo/Grupo/Subgrupo/Unidade/Linha/Colecao/Moeda), Situacao,
	* Fornecedor, Opcao de Compra, Markup, Encargo e Feitio - transcricao
	* literal do bloco de montagem de lcWhere do metodo "processar" legado
	* (laCampo/laVarias percorrendo os 7 pares de faixa, seguido dos IIF de
	* Situas/Ifors/ForaLinha/Margems/Encargos/cFtios+cFtioCs).
	*====================================================================
	PROTECTED FUNCTION MontarWhereFiltros()
		LOCAL loc_cWhere, loc_cCampoMoeda

		*-- laCampo[5] do legado: 'Moedas', ou 'Moevs' quando fwoption1.Value = 2
		loc_cCampoMoeda = IIF(THIS.this_nOpcaoMoeda = 2, "Moevs", "Moedas")

		loc_cWhere = ""
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, "CGrus",     THIS.this_cGrupoI,    THIS.this_cGrupoF)
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, "Cunis",     THIS.this_cUnidadeI,  THIS.this_cUnidadeF)
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, "Linhas",    THIS.this_cLinhaI,    THIS.this_cLinhaF)
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, "Colecoes",  THIS.this_cColecaoI,  THIS.this_cColecaoF)
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, loc_cCampoMoeda, THIS.this_cMoedaI, THIS.this_cMoedaF)
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, "SGrus",     THIS.this_cSubGrupoI, THIS.this_cSubGrupoF)
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, "Mercs",     THIS.this_cMercI,     THIS.this_cMercF)

		loc_cWhere = ALLTRIM(loc_cWhere)
		IF EMPTY(loc_cWhere)
			loc_cWhere = "1=1"
		ENDIF
		IF UPPER(RIGHT(loc_cWhere, 3)) == "AND"
			loc_cWhere = ALLTRIM(SUBSTR(loc_cWhere, 1, LEN(loc_cWhere) - 3))
		ENDIF

		*-- Situacao (Opc_situacao): 1=Ativos, 2=Inativos, 3=Todos (sem filtro)
		IF INLIST(THIS.this_nSituacao, 1, 2)
			loc_cWhere = loc_cWhere + " And Situas = " + FormatarNumeroSQL(THIS.this_nSituacao, 0)
		ENDIF

		*-- Fornecedor (getCFornecs)
		IF !EMPTY(ALLTRIM(TratarNulo(THIS.this_cFornecs, "")))
			loc_cWhere = loc_cWhere + " And Ifors = " + EscaparSQL(ALLTRIM(THIS.this_cFornecs))
		ENDIF

		*-- Opc_Compra: 1=Comprar (ForaLinha=0), 2=Nao Comprar (ForaLinha=1), 3=Todos
		IF INLIST(THIS.this_nOpcaoCompra, 1, 2)
			loc_cWhere = loc_cWhere + " And ForaLinha = " + IIF(THIS.this_nOpcaoCompra = 1, "0", "1")
		ENDIF

		*-- Faixa de Markup (GetMrki/GetMrkf)
		IF THIS.this_nMarkupI > 0
			loc_cWhere = loc_cWhere + " And Margems Between " + ;
				FormatarNumeroSQL(THIS.this_nMarkupI, 2) + " And " + FormatarNumeroSQL(THIS.this_nMarkupF, 2)
		ENDIF

		*-- Faixa de Encargo (Get_EncI/Get_Encf)
		IF THIS.this_nEncargoI > 0
			loc_cWhere = loc_cWhere + " And Encargos Between " + ;
				FormatarNumeroSQL(THIS.this_nEncargoI, 2) + " And " + FormatarNumeroSQL(THIS.this_nEncargoF, 2)
		ENDIF

		*-- Feitio (Get_Feitio) - casa tanto o feitio de venda quanto o de custo
		IF !EMPTY(ALLTRIM(TratarNulo(THIS.this_cFeitio, "")))
			loc_cWhere = loc_cWhere + " And (cFtios = " + EscaparSQL(ALLTRIM(THIS.this_cFeitio)) + ;
				" Or cFtioCs = " + EscaparSQL(ALLTRIM(THIS.this_cFeitio)) + ")"
		ENDIF

		RETURN loc_cWhere
	ENDFUNC

	*====================================================================
	* BuscarProdutosFiltrados - Consulta SigCdPro com a clausula WHERE de
	* MontarWhereFiltros (transcricao da fase de consulta do metodo
	* "processar" legado: "lcQuery = [Select * From SigCdPro Where ] +
	* lcWhere + ..."). O calculo de reajuste (conversao de moeda, peso de
	* composicao e markup de grupo) que o legado aplica DEPOIS desta
	* consulta usa this_nReajuste/this_nNovoMarkup/this_nNovoEncargo, que
	* espelham os controles Get_Reajuste/GetnMrk/Get_Encargo do formulario.
	*
	* Resultado fica em cursor_4c_ProdutosSQL (cpros/dpros/pvens/custofs/
	* pvideals/fcustos/fvendas/moecs/moevs) para o Form transferir para o
	* cursor da grade (cursor_4c_Produtos) em CarregarLista.
	*====================================================================
	FUNCTION BuscarProdutosFiltrados()
		LOCAL loc_cWhere, loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cWhere = THIS.MontarWhereFiltros()

			IF USED("cursor_4c_ProdutosSQL")
				USE IN cursor_4c_ProdutosSQL
			ENDIF

			*-- cgrus nao aparece na grade, mas viaja junto porque a
			*-- reclassificacao de subgrupo por faixa (ResolverSubGrupoPorFaixa)
			*-- precisa do grupo do produto na hora de gravar
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				SELECT cpros, dpros, pvens, custofs, pvideals, fcustos, fvendas,
					moecs, moevs, cgrus
				FROM SigCdPro
				WHERE <<loc_cWhere>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutosSQL")

			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao consultar produtos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao buscar produtos:" + CHR(13) + loException.Message, ;
				"sigprccpBO.BuscarProdutosFiltrados")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC


	*====================================================================
	* BuscarPresetsAutomaticos - Le os presets de recalculo ativos de
	* SigCdCcp para o modo Automatico. Transcricao literal da consulta do
	* metodo "processaautomatico" legado:
	*     lcQuery = [Select * From SigCdCcp Where Inativas <> 1]
	*
	* Resultado em cursor_4c_PresetsCcp (uma linha por preset, na ordem
	* natural da tabela - o legado nao ordena).
	*====================================================================
	FUNCTION BuscarPresetsAutomaticos()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_PresetsCcp")
				USE IN cursor_4c_PresetsCcp
			ENDIF

			loc_cSQL = "SELECT * FROM SigCdCcp WHERE Inativas <> 1"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PresetsCcp")

			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
					CapturarErroSQL(), "Falha na Conex" + CHR(227) + "o (SigCdCcp)")
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao ler presets de rec" + CHR(225) + "lculo:" + CHR(13) + ;
				loException.Message, "sigprccpBO.BuscarPresetsAutomaticos")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* ObterChkSubGrupos - Le SigCdPaC.nchksubgrs, o parametro que liga a
	* reclassificacao de subgrupo por faixa de preco no fim do metodo
	* "atualizar" legado (If crSigCdPac.nChkSubGrs = 1). O legado carrega
	* esse valor no Init (CursorQuery 'SigCdPaC' ... 'Calccusts,NCHKSUBGRS').
	*
	* Retorno: NUMERICO (0 quando o parametro nao existe ou a consulta
	* falha) - nchksubgrs eh numeric(1,0), nao bit, entao chega SEMPRE
	* numerico e nao precisa de teste de VARTYPE para Logico.
	*====================================================================
	FUNCTION ObterChkSubGrupos()
		LOCAL loc_cSQL, loc_nResultado, loc_nChk
		loc_nChk = 0

		TRY
			IF USED("cursor_4c_PacChk")
				USE IN cursor_4c_PacChk
			ENDIF

			loc_cSQL = "SELECT TOP 1 nchksubgrs FROM SigCdPaC"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PacChk")

			IF loc_nResultado >= 0 AND USED("cursor_4c_PacChk")
				SELECT cursor_4c_PacChk
				GO TOP
				IF !EOF()
					loc_nChk = TratarNulo(cursor_4c_PacChk.nchksubgrs, 0)
				ENDIF
			ENDIF

			IF USED("cursor_4c_PacChk")
				USE IN cursor_4c_PacChk
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao ler par" + CHR(226) + "metro de subgrupo:" + CHR(13) + ;
				loException.Message, "sigprccpBO.ObterChkSubGrupos")
		ENDTRY

		RETURN loc_nChk
	ENDFUNC

	*====================================================================
	* ResolverSubGrupoPorFaixa - Devolve o subgrupo (SigCdPsg.codigos) cuja
	* faixa comporta o preco de venda informado. Transcricao do bloco do
	* metodo "atualizar" legado:
	*     Select * From SigCdPsg Where CGrus = '<grupo>' Order By nFaixaFins
	*     Locate For nFaixaFins >= lnPVens
	*     If ! Eof() -> Replace sGrus With csSigCdPsg.Codigos
	* O "Locate" sobre o cursor ORDENADO por nFaixaFins pega a PRIMEIRA
	* faixa cujo limite superior alcanca o preco - equivalente exato ao
	* TOP 1 ... ORDER BY nfaixafins abaixo.
	*
	* Retorno: CHAR com o codigo do subgrupo, "" quando nao ha faixa
	* (caso em que o legado NAO troca o subgrupo).
	*====================================================================
	FUNCTION ResolverSubGrupoPorFaixa(par_cGrupo, par_nVenda)
		LOCAL loc_cSQL, loc_nResultado, loc_cCodigo
		loc_cCodigo = ""

		TRY
			IF !EMPTY(ALLTRIM(TratarNulo(par_cGrupo, "")))
				IF USED("cursor_4c_Psg")
					USE IN cursor_4c_Psg
				ENDIF

				TEXT TO loc_cSQL TEXTMERGE NOSHOW
					SELECT TOP 1 codigos
					FROM SigCdPsg
					WHERE cgrus = <<EscaparSQL(ALLTRIM(par_cGrupo))>>
						AND nfaixafins >= <<FormatarNumeroSQL(par_nVenda, 2)>>
					ORDER BY nfaixafins
				ENDTEXT

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Psg")

				IF loc_nResultado >= 0 AND USED("cursor_4c_Psg")
					SELECT cursor_4c_Psg
					GO TOP
					IF !EOF()
						loc_cCodigo = ALLTRIM(TratarNulo(cursor_4c_Psg.codigos, ""))
					ENDIF
				ENDIF

				IF USED("cursor_4c_Psg")
					USE IN cursor_4c_Psg
				ENDIF
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao resolver subgrupo por faixa:" + CHR(13) + ;
				loException.Message, "sigprccpBO.ResolverSubGrupoPorFaixa")
		ENDTRY

		RETURN loc_cCodigo
	ENDFUNC

	*====================================================================
	* ColunasComunsProPrc - Lista das 121 colunas presentes ao mesmo tempo
	* em SigCdPro e SigCdPrc (extraidas de docs/schema.sql). O legado copia
	* o registro INTEIRO com "Scatter Memvar Memo" + "Insert Into
	* CrSigCdPrc From MemVar", que preenche apenas os campos de nome igual
	* nas duas tabelas - esta lista eh exatamente esse conjunto.
	*
	* par_lOrigem = .T. devolve as EXPRESSOES do SELECT sobre SigCdPro,
	* com LEFT() nas 3 colunas que sao mais CURTAS no destino (locals
	* 10->6, sittricms 3->2, codtams 4->2); sem o LEFT o SQL Server recusa
	* o INSERT com "String or binary data would be truncated".
	* par_lOrigem = .F. devolve os nomes crus, para a lista de destino.
	*====================================================================
	PROTECTED FUNCTION ColunasComunsProPrc(par_lOrigem)
		LOCAL loc_c
		loc_c = ""
		loc_c = loc_c + "matprincs, dtcomps, cbars, cgrus, clfiscals, colecoes, comis, cpros, "
		loc_c = loc_c + "cunis, custofs, cvens, datas, datatrans, descfis, dpros, dtfilms, "
		loc_c = loc_c + "fcustos, figjpgs, flagctabs, fvendas, icms, ifors, linhas, "
		loc_c = loc_c + IIF(par_lOrigem, "LEFT(locals, 6)", "locals") + ", "
		loc_c = loc_c + "margems, moecs, moecusfs, moedas, moepcs, moepvs, moevs, notas, "
		loc_c = loc_c + "obspeds, obspes, origmercs, pcuss, pesoms, pvens, pvideals, qmins, "
		loc_c = loc_c + "reffs, "
		loc_c = loc_c + IIF(par_lOrigem, "LEFT(sittricms, 2)", "sittricms") + ", "
		loc_c = loc_c + "tcomps, tipos, transps, valors, varias, situas, "
		loc_c = loc_c + "dtincs, sgrus, metals, teors, cftios, codservs, mftios, pftios, "
		loc_c = loc_c + "codcors, "
		loc_c = loc_c + IIF(par_lOrigem, "LEFT(codtams, 2)", "codtams") + ", "
		loc_c = loc_c + "compos, montadescs, digimaxs, ordcompos, ean13, cproeqs, "
		loc_c = loc_c + "chkfunds, casas, impetiqs, qtdcpnts, dpro2s, dsccompras, encoms, obscompras, "
		loc_c = loc_c + "codacbs, cravcers, cunips, ipis, mercs, pesobs, tamhs, tamls, "
		loc_c = loc_c + "tamps, tptribs, volumes, obsetqs, ultcomps, vultcomps, multcomps, markupa, "
		loc_c = loc_c + "tinsts, cclass, cftiocs, figtecs, nivelqs, pftiocs, usuincs, diasinas, "
		loc_c = loc_c + "idecpros, fabrproprs, qtminfabs, tents, codfinp, codmatp, dpro3s, contaccus, "
		loc_c = loc_c + "gruccus, consigs, ltminsv, status, aliqipis, codgarras, descecfs, encargos, "
		loc_c = loc_c + "idpro, nidentfixa, pesobris, pesometal, pesopdrs, extipi, iats, dtsituas, "
		loc_c = loc_c + "conjunts"

		RETURN loc_c
	ENDFUNC

	*====================================================================
	* GravarHistoricoPreco - Registra em SigCdPrc o retrato do produto
	* ANTES da gravacao do preco novo. Transcricao do bloco do metodo
	* "atualizar" legado:
	*     lcSql = [Select * From SigCdPro Where Cpros = ']+m.cpros+[']
	*     Select TmpPro2 / Scatter Memvar Memo
	*     m.DataAlts = Datetime() / m.HoraAlts = Substr(Ttoc(...),12,8)
	*     m.UsuaAlts = Usuar / m.cIdChaves = fUniqueIds()
	*     m.Origem   = Ttoc(Datetime()) + [ SigPrCcp]
	*     Insert Into CrSigCdPrc From MemVar
	* Feito com INSERT ... SELECT (server-side) para nao trazer as 121
	* colunas para o VFP so para devolve-las.
	*
	* As 15 colunas NOT NULL que existem em SigCdPrc e NAO em SigCdPro
	* recebem o valor em branco do tipo - equivalente ao registro em
	* branco do cursor do legado, que o "Insert From Memvar" nao toca.
	* SigCdPrc nao tem nenhum DEFAULT, entao omitir qualquer uma delas
	* faria o SQL Server recusar o INSERT inteiro (CLAUDE.md regra #22).
	* figuras (image) fica de fora porque aceita NULL.
	*
	* IMPORTANTE: chamar ANTES de Salvar()/Atualizar(), senao o historico
	* guarda o preco NOVO em vez do antigo.
	*====================================================================
	FUNCTION GravarHistoricoPreco(par_cCpros)
		LOCAL loc_cSQL, loc_cDestino, loc_cOrigem, loc_cExtras, loc_cValores
		LOCAL loc_cHora, loc_cOrigemTxt, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- m.HoraAlts = Substr(Ttoc(m.DataAlts),12,8) do legado
			loc_cHora = SUBSTR(TTOC(DATETIME()), 12, 8)

			*-- m.Origem = Ttoc(Datetime()) + [ SigPrCcp] do legado
			loc_cOrigemTxt = LEFT(TTOC(DATETIME()) + " SigPrCcp", 30)

			loc_cExtras  = "codcpds, cbms, caracts, cunifors, custocvs, ltmins, markcvs, pesomts, " + ;
				"pidealcvs, qtdias, retiras, codccnjs, montagens, tmontas, codconc"
			loc_cValores = EscaparSQL("") + ", 0, " + EscaparSQL("") + ", " + EscaparSQL("") + ;
				", 0, 0, 0, 0, 0, 0, 0, " + EscaparSQL("") + ", 0, " + EscaparSQL("") + ;
				", " + EscaparSQL("")

			loc_cDestino = THIS.ColunasComunsProPrc(.F.)
			loc_cOrigem  = THIS.ColunasComunsProPrc(.T.)

			loc_cSQL = "INSERT INTO SigCdPrc " + ;
				"(dataalts, horaalts, usuaalts, cidchaves, origem, " + ;
				loc_cExtras + ", " + loc_cDestino + ") " + ;
				"SELECT GETDATE(), " + ;
				EscaparSQL(loc_cHora) + ", " + ;
				EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + ", " + ;
				EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + ;
				EscaparSQL(loc_cOrigemTxt) + ", " + ;
				loc_cValores + ", " + loc_cOrigem + " " + ;
				"FROM SigCdPro WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCpros))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = "Falha ao gravar hist" + CHR(243) + ;
					"rico de pre" + CHR(231) + "o (SigCdPrc) do produto " + ;
					ALLTRIM(par_cCpros) + ": " + CapturarErroSQL()
				MsgErro(THIS.this_cMensagemErro, "Erro SQL")
			ENDIF
		CATCH TO loException
			THIS.this_cMensagemErro = loException.Message
			MostrarErro("Erro ao gravar hist" + CHR(243) + "rico de pre" + CHR(231) + "o:" + ;
				CHR(13) + loException.Message, "sigprccpBO.GravarHistoricoPreco")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* GravarHistoricoComposicao - Copia a composicao corrente do produto
	* (SigPrCpo) para SigPrCp2. Transcricao do bloco do metodo "atualizar"
	* legado:
	*     Select * From SigPrCpo Where CPros = '<cpros>' -> TmpCompo
	*     Scan / Scatter MemVar Memo
	*        m.DataAlts/HoraAlts/UsuaAlts / m.cIdChaves = fUniqueIds()
	*        Insert Into CrSigPrCp2 From MemVar
	*     EndScan
	* Como o legado gera um cIdChaves NOVO por LINHA, a gravacao eh feita
	* linha a linha (um INSERT ... SELECT por cidchaves de origem) - um
	* unico INSERT em conjunto repetiria a mesma chave em todas as linhas
	* e colidiria no indice unico.
	*
	* SigPrCp2 = SigPrCpo menos PedraPrincipal, mais dataalts/horaalts/
	* usuaalts; dcompos eh char(30) contra char(40) na origem, por isso o
	* LEFT(dcompos, 30).
	*====================================================================
	FUNCTION GravarHistoricoComposicao(par_cCpros)
		LOCAL loc_cSQL, loc_cCols, loc_cColsOrig, loc_cHora, loc_cUsuario
		LOCAL loc_nResultado, loc_lSucesso, loc_lProsseguir
		loc_lSucesso    = .F.
		loc_lProsseguir = .T.

		TRY
			loc_cHora    = SUBSTR(TTOC(DATETIME()), 12, 8)
			loc_cUsuario = LEFT(gc_4c_UsuarioLogado, 10)

			loc_cCols = ""
			loc_cCols = loc_cCols + "cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, "
			loc_cCols = loc_cCols + "grupos, mats, moeds, obscompos, ordems, pcompos, qtds, "
			loc_cCols = loc_cCols + "qtscons, unicompos, compos, ordcompos, qtdcvs, vlrcvs, dtmovs, "
			loc_cCols = loc_cCols + "cunips, markcvs, pesos, totas, tpalts, vlrpvs, ordts, "
			loc_cCols = loc_cCols + "tipos, matriz, obsofs"

			*-- Mesma lista, com LEFT() na unica coluna mais curta no destino
			loc_cColsOrig = STRTRAN(loc_cCols, "dcompos,", "LEFT(dcompos, 30),")

			IF USED("cursor_4c_CompoOrig")
				USE IN cursor_4c_CompoOrig
			ENDIF

			loc_cSQL = "SELECT cidchaves FROM SigPrCpo WHERE cpros = " + ;
				EscaparSQL(ALLTRIM(par_cCpros))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CompoOrig")

			IF loc_nResultado < 0
				THIS.this_cMensagemErro = "Falha ao ler composi" + CHR(231) + CHR(227) + ;
					"o do produto " + ALLTRIM(par_cCpros) + ": " + CapturarErroSQL()
				MsgErro(THIS.this_cMensagemErro, "Erro SQL")
				loc_lProsseguir = .F.
			ENDIF

			IF loc_lProsseguir
				*-- Produto sem composicao: nada a historiar, e o legado
				*-- tambem apenas nao entra no Scan (sucesso)
				loc_lSucesso = .T.

				SELECT cursor_4c_CompoOrig
				SCAN
					loc_cSQL = "INSERT INTO SigPrCp2 " + ;
						"(dataalts, horaalts, usuaalts, cidchaves, " + loc_cCols + ") " + ;
						"SELECT GETDATE(), " + ;
						EscaparSQL(loc_cHora) + ", " + ;
						EscaparSQL(loc_cUsuario) + ", " + ;
						EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + ;
						loc_cColsOrig + " " + ;
						"FROM SigPrCpo WHERE cidchaves = " + ;
						EscaparSQL(ALLTRIM(cursor_4c_CompoOrig.cidchaves))

					IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
						THIS.this_cMensagemErro = "Falha ao gravar hist" + CHR(243) + ;
							"rico de composi" + CHR(231) + CHR(227) + "o (SigPrCp2) do produto " + ;
							ALLTRIM(par_cCpros) + ": " + CapturarErroSQL()
						MsgErro(THIS.this_cMensagemErro, "Erro SQL")
						loc_lSucesso = .F.
						EXIT
					ENDIF

					SELECT cursor_4c_CompoOrig
				ENDSCAN
			ENDIF

			IF USED("cursor_4c_CompoOrig")
				USE IN cursor_4c_CompoOrig
			ENDIF
		CATCH TO loException
			THIS.this_cMensagemErro = loException.Message
			MostrarErro("Erro ao gravar hist" + CHR(243) + "rico de composi" + ;
				CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, ;
				"sigprccpBO.GravarHistoricoComposicao")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* ExcluirPrecosTabela - Apaga os precos de tabela do produto, que
	* passam a estar defasados depois do recalculo. Transcricao literal do
	* metodo "atualizar" legado:
	*     [Delete From SigPrPrt Where CPros = '] + m.CPros + [' ]
	*====================================================================
	FUNCTION ExcluirPrecosTabela(par_cCpros)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigPrPrt WHERE cpros = " + ;
				EscaparSQL(ALLTRIM(par_cCpros))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = "Falha ao excluir pre" + CHR(231) + ;
					"os de tabela (SigPrPrt) do produto " + ALLTRIM(par_cCpros) + ;
					": " + CapturarErroSQL()
				MsgErro(THIS.this_cMensagemErro, "Erro SQL")
			ENDIF
		CATCH TO loException
			THIS.this_cMensagemErro = loException.Message
			MostrarErro("Erro ao excluir pre" + CHR(231) + "os de tabela:" + CHR(13) + ;
				loException.Message, "sigprccpBO.ExcluirPrecosTabela")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* IniciarTransacao / ConfirmarTransacao / DesfazerTransacao
	*
	* Equivalentes de ThisForm.poDataMgr.Commit() / .RollBack() do legado,
	* que existem porque o fSqlConector legado abre a conexao com
	* Transactions = 2 (manual). Neste ambiente a conexao JA nasce em
	* transacao manual (SQLGETPROP(0,"Transactions") = 2 num VFP9 virgem),
	* entao nao ha nada a abrir: IniciarTransacao apenas confere o handle e
	* limpa a mensagem de erro; o que importa eh o par SQLCOMMIT/
	* SQLROLLBACK no fim - sem eles a transacao nunca eh fechada e a
	* gravacao SOME se o processo morrer antes do disconnect limpo.
	*====================================================================
	FUNCTION IniciarTransacao()
		THIS.this_cMensagemErro = ""
		RETURN (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
	ENDFUNC

	FUNCTION ConfirmarTransacao()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_lSucesso = (SQLCOMMIT(gnConnHandle) > 0)
			IF !loc_lSucesso
				THIS.this_cMensagemErro = "Falha ao confirmar a transa" + CHR(231) + ;
					CHR(227) + "o: " + CapturarErroSQL()
			ENDIF
		CATCH TO loException
			THIS.this_cMensagemErro = loException.Message
			MostrarErro("Erro ao confirmar transa" + CHR(231) + CHR(227) + "o:" + ;
				CHR(13) + loException.Message, "sigprccpBO.ConfirmarTransacao")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	FUNCTION DesfazerTransacao()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_lSucesso = (SQLROLLBACK(gnConnHandle) > 0)
		CATCH TO loException
			MostrarErro("Erro ao desfazer transa" + CHR(231) + CHR(227) + "o:" + ;
				CHR(13) + loException.Message, "sigprccpBO.DesfazerTransacao")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC


ENDDEFINE

