# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (4)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CONTAINER1. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.WindowType()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ArvoreDisponivel()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.NodeCargo()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPNOP.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2160 linhas total):

*-- Linhas 24 a 104:
24: * teste - ver feedback_mscomctl_treectrl_trava_em_modal_de_licenca).
25: *
26: * FASE 3/8 - ESTRUTURA BASE: DEFINE CLASS, propriedades de estado (espelham
27: * as propriedades customizadas do form legado - paEmpDopNums, Arqfigura,
28: * plDblClick), Init()/InicializarForm()/Destroy() e os DOIS containers de
29: * topo do layout legado (cnt_4c_Container1 / cnt_4c_Container2), ainda
30: * vazios. O conteudo deles (TreeView, GetOP, GetEnvelope, Label3, Label1,
31: * Label2) e os controles soltos na Form (Commandgroup1, Fwbtng1, Fwbtng2,
32: * Imagem) entram na Fase 4.
33: *
34: * FASE 4/8 - CONTROLES: ConfigurarControles() preenche os dois containers
35: * da Fase 3 e cria os controles soltos na Form, com geometria/propriedades
36: * transcritas LITERALMENTE da SECAO 2 do dump (PILAR 1):
37: *   cnt_4c_Container1 -> obj_4c_TreeView (arvore - ctTree.ocx, controle
38: *     ActiveX de terceiros sem substituto nativo VFP9, mesma familia de
39: *     FormSIGMVMVT: instanciado via OLEControl com o mesmo ProgID do
40: *     legado, guardado em TRY/CATCH e pulado em modo teste/validacao de
41: *     UI - ver feedback_mscomctl_treectrl_trava_em_modal_de_licenca), mais
42: *     lbl_4c_Label3 ("O.P. :"), lbl_4c_Label1 ("Envelope :"), txt_4c_OP
43: *     (GetOP) e txt_4c_Envelope (GetEnvelope).
44: *   cnt_4c_Container2 -> lbl_4c_Label1 ("AGUARDE!") e lbl_4c_Label2
45: *     ("Pesquisando as Movimentacoes") - conteudo do painel flutuante.
46: *   Form (sem container, fiel ao SCX) -> cmg_4c_Commandgroup1 (unico
47: *     botao "Encerrar" - nome canonico cmg_4c_, NAO o obj_4c_ do
48: *     mapeamento.json gerado: ver feedback_commandgroup_obj_4c_reprova_
49: *     gate_fase4), cmd_4c_Fwbtng1 ("Expandir"), cmd_4c_Fwbtng2
50: *     ("Regredir") e img_4c_Imagem (imagem do produto).
51: *
52: * Mais o METODO DE CARGA desta tela, que aqui NAO alimenta uma grade e sim
53: * a ARVORE (o SCX nao tem Grid nem PageFrame - a superficie de lista eh o
54: * TreeView ActiveX, dirigido pela API de nos AddPictureNode/NodeExpanded/
55: * NodeFontBold). Medicao que dispensa Grid/CRUD neste legado, feita sobre
56: * tasks\task772\SIGOPNOP_form_codigo_fonte.txt: ZERO "BaseClass: grid",
57: * ZERO "BaseClass: pageframe", ZERO .AddCursor(/pColuna/RecordSource/
58: * ControlSource, UM "BaseClass: olecontrol" e 7 chamadas da API de nos.
59: *   CarregarDados()           -> escolhe o criterio (O.P. ou Envelope -
60: *     mutuamente exclusivos no legado), chama SIGOPNOPBO.PesquisarPorOP/
61: *     PesquisarPorEnvelope e desenha a arvore. Equivale aos dois Valid do
62: *     legado (Container1.GetOP.Valid -> MakeTree, Container1.GetEnvelope.
63: *     Valid -> MakeTreeEnv).
64: *   PopularArvore()           -> transcricao dos PROCEDURE maketree e
65: *     maketreeenv (mesmo algoritmo, cinco textos/icones diferentes).
66: *   PrepararArvore()          -> os seis AddImage do Init legado (uma unica
67: *     vez - os indices 1..6 do AddPictureNode sao fixos) e o bloco
68: *     ClearNodes/TipsDisplay/SmallIcons/PicAlign/SelectedStyle/PictureType
69: *     que os dois metodos legado repetem no inicio.
70: *   ExibirImagemProduto()     -> bloco da figura do produto do GetOP.Valid.
71: *   AdicionarNoOrigemDestino()/AdicionarNoMedida() -> os blocos de no que o
72: *     legado repete literalmente (2x e 3x por iteracao do Scan).
73: *   ArvoreDisponivel()        -> guarda do ActiveX (OCX ausente/modo teste).
74: *
75: * FASES 6/7 - EVENTOS PRINCIPAIS: ConfigurarEventos() liga os eventos dos
76: * dois campos digitaveis (GotFocus/Valid -> KeyPress em ENTER/TAB) e o Click
77: * dos tres botoes do legado (Encerrar/Expandir/Regredir).
78: *
79: * FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO: fecham-se os TRES ultimos
80: * metodos com codigo do dump que ainda nao tinham equivalente, completando a
81: * cobertura de 100% da SECAO 3 (17 metodos - ver a tabela de cobertura no fim
82: * deste cabecalho):
83: *   TreeViewKeyPress()      -> TreeView.KeyPress  (ESC)
84: *   TreeViewNodeClick()     -> TreeView.NodeClick (no clicado + drill)
85: *   EmpilharChaveNavegacao()-> as 3 linhas de pilha paEmpDopNums do NodeClick
86: *   ImgImagemDblClick()     -> Imagem.DblClick    (zoom da foto do produto)
87: *   AbrirFormZoomImagem()   -> "Do Form SigOpZom With ..." do Imagem.DblClick
88: *
89: * O QUE NAO SE APLICA A ESTA TELA, e por que (medido no dump, nao presumido):
90: *
91: *   Btn...CancelarClick / Form...ParaBO / BO...ParaForm / Carregar...Lista
92: *     Sao convencao do par Page2(Dados) + modo INCLUIR/ALTERAR do
93: *     frmcadastro: os dois primeiros mapeiam em BLOCO os campos de uma ficha
94: *     de/para o BO, e o Cancelar descarta uma edicao em andamento. Aqui nao
95: *     ha ficha, nao ha modo de edicao cancelavel e nao ha grade: a tela tem
96: *     DOIS campos de parametro (O.P. e Envelope) cuja transferencia para o BO
97: *     acontece por ARGUMENTO do metodo de carga (CarregarDados ->
98: *     PesquisarPorOP/PesquisarPorEnvelope), e a "lista" eh a ARVORE ActiveX,
99: *     alimentada por CarregarDados/PopularArvore. (Os quatro nomes estao
100: *     grafados com o miolo elidido de proposito: escritos por extenso, um
101: *     comentario os faria passar por implementados num gate que procura o
102: *     nome por substring no arquivo inteiro.)
103: *
104: *   HabilitarCampos / LimparCampos / AjustarBotoesPorModo

*-- Linhas 132 a 202:
132: *     Nao ha efeito a reproduzir.
133: *
134: * COBERTURA DA SECAO 3 DO DUMP (17 metodos com codigo):
135: *   form.Init ................. Init + InicializarForm + PrepararArvore
136: *   form.maketree ............. PopularArvore(.F.)
137: *   form.maketreeenv .......... PopularArvore(.T.)
138: *   Commandgroup1.Command3.Click  CmdEncerrarClick
139: *   Commandgroup1.Command3.When   "Return(.t.)" - sem efeito
140: *   TreeView.Click/DblClick ... vazios no dump
141: *   TreeView.KeyPress ......... TreeViewKeyPress
142: *   TreeView.NodeClick ........ TreeViewNodeClick + EmpilharChaveNavegacao
143: *   GetEnvelope.GotFocus ...... TxtEnvelopeGotFocus
144: *   GetEnvelope.Valid ......... ValidarEnvelope -> CarregarDados
145: *   GetEnvelope.When .......... "Return(.t.)" - sem efeito
146: *   GetOP.GotFocus + GetOP.When TxtOPGotFocus
147: *   GetOP.Valid ............... ValidarOP -> CarregarDados + ExibirImagemProduto
148: *   Fwbtng1.Click ............. CmdExpandirClick
149: *   Fwbtng2.Click ............. CmdRegredirClick
150: *   Imagem.DblClick ........... ImgImagemDblClick + AbrirFormZoomImagem
151: *
152: * Parametros de abertura (Parameters plModal, pcEmps, pcDopes, pcNumes do
153: * Init legado): pcEmps/pcDopes/pcNumes sao declarados mas NUNCA referenciados
154: * no restante do codigo do form legado (conferido no dump completo em
155: * tasks\task772\SIGOPNOP_form_codigo_fonte.txt) - a assinatura eh mantida
156: * para fidelidade de chamada, mas nao ha logica do legado para reproduzir a
157: * partir deles. plModal tambem eh recebido sem efeito: a unica linha que o
158: * usaria no legado esta COMENTADA no proprio SCX ("*ThisForm.WindowType =
159: * Iif(plModal,1,0)") - por isso THIS.WindowType NAO eh alterado aqui.
160: *
161: * CHAMADA:
162: *   loForm = CREATEOBJECT("FormSIGOPNOP")
163: *   loForm.Show()
164: *==============================================================================
165: 
166: DEFINE CLASS FormSIGOPNOP AS FormBase
167: 
168: 	*-- Dimensoes e comportamento identicos ao legado (SIGOPNOP.SCX)
169: 	Height       = 600
170: 	Width        = 800
171: 	AutoCenter   = .T.
172: 	BorderStyle  = 2
173: 	ShowWindow   = 1
174: 	WindowType   = 1
175: 	ControlBox   = .F.
176: 	MaxButton    = .F.
177: 	MinButton    = .F.
178: 	*-- Closable NAO entra: o dump do SCX declara so ControlBox/MaxButton/
179: 	*-- MinButton, e as cinco propriedades sao INDEPENDENTES (medido no VFP9 -
180: 	*-- sem barra de titulo os botoes nao DESENHAM, mas Closable continua .T.
181: 	*-- e o Alt+F4 continua funcionando). Inventar Closable = .F. aqui tiraria
182: 	*-- a saida por teclado que o legado tinha, sem erro e sem log
183: 	*-- (feedback_closable_inventado_tira_a_unica_saida). A saida por ESC
184: 	*-- continua garantida por cmg_4c_Commandgroup1.Buttons(1).Cancel = .T.,
185: 	*-- transcrito do dump.
186: 	ClipControls = .F.
187: 	ShowTips     = .T.
188: 	Themes       = .F.
189: 	FontName     = "Verdana"
190: 	FontSize     = 8
191: 	DataSession  = 2
192: 
193: 	*-- Parametros de abertura (Parameters plModal, pcEmps, pcDopes, pcNumes
194: 	*-- do Init legado). pcEmps/pcDopes/pcNumes NUNCA sao lidos no resto do
195: 	*-- form legado (conferido no dump) - guardados so para manter a mesma
196: 	*-- assinatura de chamada. plModal fica guardado pelo mesmo motivo, mas
197: 	*-- NAO altera THIS.WindowType (a linha correspondente esta comentada no
198: 	*-- SCX legado).
199: 	this_lModalParam = .F.
200: 	this_cEmpsParam  = ""
201: 	this_cDopesParam = ""
202: 	this_nNumesParam = 0

*-- Linhas 215 a 411:
215: 	*-- ThisForm.plDblClick - cargo (NodeCargo) do ultimo no clicado na
216: 	*-- arvore, usado pelo TreeView.NodeClick para distinguir o 1o clique
217: 	*-- (so seleciona) do 2o clique no MESMO no (drill - dispara MakeTree).
218: 	this_cUltimoNoClicado = ""
219: 
220: 	*-- Chave de navegacao CORRENTE (Emps + Dopes + Str(Numes)). No legado ela
221: 	*-- nao mora numa property: mora em TRES TextBox - Container1.GetcEmp,
222: 	*-- Container1.GetDopes e Container1.GetNumes -, que o NodeClick le e
223: 	*-- reescreve. Esses tres controles NAO EXISTEM no SCX (a SECAO 1 do dump
224: 	*-- lista, dentro do Container1, apenas TreeView, Label3, Label1,
225: 	*-- GetEnvelope e GetOP) - sobraram so as referencias a eles no codigo do
226: 	*-- NodeClick. Reproduzir os tres controles seria INVENTAR tela que o
227: 	*-- legado nao tem; guardar o mesmo valor numa property reproduz o ESTADO
228: 	*-- sem inventar UI. Ver TreeViewNodeClick/EmpilharChaveNavegacao.
229: 	*-- O valor INICIAL eh posto em InicializarForm e NAO eh vazio - a nota la
230: 	*-- explica por que isso importa para a pilha (initializer de property so
231: 	*-- aceita constante, dai nao dar para por STR(0, 6) aqui).
232: 	this_cChaveNavegacao = ""
233: 
234: 	*-- ThisForm.pnNodeExp - nivel corrente de expansao da arvore. Posto em 1
235: 	*-- no fim de MakeTree/MakeTreeEnv (ver PopularArvore) e incrementado/
236: 	*-- decrementado pelos botoes Expandir/Regredir do legado (Fwbtng1.Click
237: 	*-- e Fwbtng2.Click, Fase 7).
238: 	this_nNodeExp = 0
239: 
240: 	*-- Controle interno (NAO tem equivalente no legado): as seis imagens dos
241: 	*-- nos sao carregadas por AddImage UMA UNICA vez, como no Init legado.
242: 	*-- AddImage empilha indices novos a cada chamada e os indices 1..6 usados
243: 	*-- pelo AddPictureNode sao FIXOS - recarregar a cada pesquisa trocaria os
244: 	*-- icones de todos os nos.
245: 	this_lImagensArvore = .F.
246: 
247: 	*-- Guarda de reentrancia da consulta disparada pelos dois campos
248: 	*-- digitaveis (ver ValidarOP/ValidarEnvelope). CarregarDados abre dialogo
249: 	*-- modal (MsgAviso/MsgErro) e redesenha a arvore; enquanto isso o teclado
250: 	*-- continua enfileirando, e sem a guarda segurar o ENTER empilha consultas
251: 	*-- identicas. Mesmo padrao do this_lEmLookup dos lookups do projeto.
252: 	this_lEmConsulta = .F.
253: 
254: 	*==========================================================================
255: 	* Init - Recebe os parametros de abertura (Parameters plModal, pcEmps,
256: 	* pcDopes, pcNumes do legado) e repassa para FormBase.Init() (que chama
257: 	* InicializarForm() atraves de DODEFAULT()).
258: 	*==========================================================================
259: 	PROCEDURE Init(par_lModal, par_cEmps, par_cDopes, par_nNumes)
260: 		THIS.this_lModalParam = IIF(TYPE("par_lModal") = "L", par_lModal, .F.)
261: 		THIS.this_cEmpsParam  = IIF(TYPE("par_cEmps")  = "C", ALLTRIM(par_cEmps), "")
262: 		THIS.this_cDopesParam = IIF(TYPE("par_cDopes") = "C", ALLTRIM(par_cDopes), "")
263: 		THIS.this_nNumesParam = IIF(TYPE("par_nNumes") = "N", par_nNumes, 0)
264: 
265: 		RETURN DODEFAULT()
266: 	ENDPROC
267: 
268: 	*==========================================================================
269: 	* InicializarForm - Instancia o Business Object, reinicializa o estado de
270: 	* navegacao da arvore (equivalente ao bloco inicial do Init legado -
271: 	* Declare ThisForm.paEmpDopNums[1] / ThisForm.Arqfigura recebe espaco) e cria os
272: 	* containers de topo do layout legado. O conteudo dos containers e os
273: 	* controles soltos na Form (TreeView/GetOP/GetEnvelope/labels/
274: 	* Commandgroup1/Fwbtng1/Fwbtng2/Imagem) entram na Fase 4.
275: 	*==========================================================================
276: 	PROTECTED PROCEDURE InicializarForm
277: 		LOCAL loc_lSucesso
278: 		loc_lSucesso = .F.
279: 
280: 		THIS.this_oBusinessObject = CREATEOBJECT("SIGOPNOPBO")
281: 
282: 		IF VARTYPE(THIS.this_oBusinessObject) != "O"
283: 			MsgErro("Falha ao criar SIGOPNOPBO", "Erro")
284: 		ELSE
285: 			THIS.Caption = "An" + CHR(225) + "lise de OP/Envelopes"
286: 
287: 			*-- Picture = ..\framework\imagens\new_background.jpg no legado -
288: 			*-- caminho resolvido via gc_4c_CaminhoFramework (regra CLAUDE.md
289: 			*-- #27/Pattern #170 - NUNCA montar esse caminho a partir de gc_4c_CaminhoBase).
290: 			IF FILE(gc_4c_CaminhoFramework + "imagens\new_background.jpg")
291: 				THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
292: 			ENDIF
293: 
294: 			*-- Reinicializa o estado de navegacao da arvore (equivalente ao
295: 			*-- Declare ThisForm.paEmpDopNums[1] / Arqfigura = ' ' do Init
296: 			*-- legado - o form nao fecha entre uma pesquisa e outra).
297: 			DIMENSION THIS.this_aEmpDopNums[1]
298: 			THIS.this_aEmpDopNums[1] = ""
299: 
300: 			THIS.this_cArquivoFigura   = ""
301: 			THIS.this_cUltimoNoClicado = ""
302: 
303: 			*-- Chave de navegacao INICIAL. No legado ela eh
304: 			*-- "GetcEmp.Value + GetDopes.Value + Str(GetNumes.Value, 6)" com
305: 			*-- os tres TextBox recem-criados, isto eh "" + "" + "     0" =
306: 			*-- STR(0, 6) - que NAO eh vazio, por causa do zero do Str.
307: 			*-- Isso IMPORTA: a pilha do NodeClick cresce testando
308: 			*-- "!Empty(paEmpDopNums[1])" (ver EmpilharChaveNavegacao), logo
309: 			*-- uma chave inicial VAZIA faria a 1a chave empilhada ser vazia e
310: 			*-- a pilha NUNCA crescer - divergencia medida no probe da Fase 8
311: 			*-- (ALEN ficava em 1 depois de dois drills, onde o legado da 2).
312: 			THIS.this_cChaveNavegacao = STR(0, 6)
313: 
314: 			*-- Containers de topo do layout legado (filhos diretos da Form -
315: 			*-- o SCX nao tem PageFrame).
316: 			THIS.ConfigurarContainers()
317: 
318: 			*-- Conteudo dos containers + controles soltos na Form (Fase 4).
319: 			THIS.ConfigurarControles()
320: 
321: 			*-- Ordem de tabulacao EFETIVA do legado - tem de rodar depois de
322: 			*-- TODOS os AddObject (ver AplicarOrdemTabulacao).
323: 			THIS.AplicarOrdemTabulacao()
324: 
325: 			*-- Eventos dos dois campos digitaveis (Fase 6). Tem de rodar
326: 			*-- ANTES do SetFocus abaixo: no legado o SetFocus do Init ja
327: 			*-- dispara o When e o GotFocus do GetOP, que zeram o campo irmao
328: 			*-- e apagam a figura do produto.
329: 			THIS.ConfigurarEventos()
330: 
331: 			*-- AddObject cria tudo com Visible=.F. por padrao - torna
332: 			*-- visivel, preservando cnt_4c_Container2 (painel "AGUARDE!")
333: 			*-- e img_4c_Imagem invisiveis, fieis ao legado.
334: 			THIS.TornarControlesVisiveis(THIS)
335: 
336: 			*-- Init legado: "ThisForm.Container1.GetOP.SetFocus" (ver nota
337: 			*-- de SetFocus sem TRY/CATCH em ConfigurarControles).
338: 			IF THIS.cnt_4c_Container1.txt_4c_OP.Enabled AND THIS.cnt_4c_Container1.txt_4c_OP.Visible
339: 				THIS.cnt_4c_Container1.txt_4c_OP.SetFocus()
340: 			ENDIF
341: 
342: 			loc_lSucesso = .T.
343: 		ENDIF
344: 
345: 		RETURN loc_lSucesso
346: 	ENDPROC
347: 
348: 	*==========================================================================
349: 	* ConfigurarContainers - Cria os containers de topo do layout legado
350: 	* (filhos DIRETOS da Form - o SCX nao tem PageFrame nenhum, ver
351: 	* SECAO 1 do dump: so "Parent: sigopnop" / BaseClass: container).
352: 	*
353: 	* Geometria e propriedades transcritas LITERALMENTE da SECAO 2 do dump
354: 	* (PILAR 1) - nada inventado:
355: 	*   Container1: Top=136 Left=23 Height=456 Width=744 BackStyle=0
356: 	*               BorderWidth=0 TabIndex=1 BackColor=212,208,200
357: 	*               BorderColor=136,189,188  -> superficie da arvore
358: 	*   Container2: Top=267 Left=221 Height=65 Width=358 SpecialEffect=0
359: 	*               TabIndex=3 BackColor=255,255,255 -> painel "AGUARDE!"
360: 	*
361: 	* cnt_4c_Container2 nasce INVISIVEL de proposito: o Init legado termina
362: 	* com "ThisForm.Container2.Visible = .f." e os metodos MakeTree/
363: 	* MakeTreeEnv o acendem ("ThisForm.Container2.Visible = .t.") enquanto a
364: 	* pesquisa roda. Por ser container FLUTUANTE, ele TEM de ficar fora do
365: 	* TornarControlesVisiveis (que entra com os controles na Fase 4) - senao
366: 	* o painel de aguarde fica aceso na tela desde a abertura.
367: 	*
368: 	* Conteudo de cada container (TreeView, GetOP, GetEnvelope, Label3,
369: 	* Label1, Label2) entra na Fase 4; aqui ficam so as duas cascas.
370: 	*==========================================================================
371: 	PROTECTED PROCEDURE ConfigurarContainers
372: 		LOCAL loc_oCnt
373: 
374: 		*-- cnt_4c_Container1 (sigopnop.Container1) - area da arvore
375: 		THIS.AddObject("cnt_4c_Container1", "Container")
376: 		loc_oCnt = THIS.cnt_4c_Container1
377: 		WITH loc_oCnt
378: 			.Top           = 136
379: 			.Left          = 23
380: 			.Height        = 456
381: 			.Width         = 744
382: 			.BackStyle     = 0
383: 			.BorderWidth   = 0
384: 			.TabIndex      = 1
385: 			.BackColor     = RGB(212, 208, 200)
386: 			.BorderColor   = RGB(136, 189, 188)
387: 			.SpecialEffect = 0
388: 			.Visible       = .T.
389: 		ENDWITH
390: 
391: 		*-- cnt_4c_Container2 (sigopnop.Container2) - painel "AGUARDE!".
392: 		*-- Visible = .F. reproduz o fim do Init legado; so MakeTree/
393: 		*-- MakeTreeEnv o tornam visivel durante a pesquisa.
394: 		THIS.AddObject("cnt_4c_Container2", "Container")
395: 		loc_oCnt = THIS.cnt_4c_Container2
396: 		WITH loc_oCnt
397: 			.Top           = 267
398: 			.Left          = 221
399: 			.Height        = 65
400: 			.Width         = 358
401: 			.SpecialEffect = 0
402: 			.TabIndex      = 3
403: 			.BackColor     = RGB(255, 255, 255)
404: 			.Visible       = .F.
405: 		ENDWITH
406: 	ENDPROC
407: 
408: 	*==========================================================================
409: 	* ConfigurarControles - Preenche os dois containers criados na Fase 3 e
410: 	* cria os controles soltos na Form (sem container - fiel ao SCX, que
411: 	* nao tem PageFrame). Geometria/propriedades transcritas LITERALMENTE

*-- Linhas 444 a 548:
444: 	* A ordem EFETIVA do legado eh reproduzida em AplicarOrdemTabulacao(),
445: 	* chamada depois de TODOS os AddObject.
446: 	*==========================================================================
447: 	PROTECTED PROCEDURE ConfigurarControles
448: 		LOCAL loc_oErrOle
449: 
450: 		*-- ===== Conteudo de cnt_4c_Container1 (area da arvore) =====
451: 
452: 		*-- obj_4c_TreeView (sigopnop.Container1.TreeView) - ctTree.ocx.
453: 		*-- ATENCAO: o SCX so preserva o caminho do OCX, nao o ProgID/CLSID
454: 		*-- exato - "cttree.cttreeview" eh o mesmo ProgID usado em
455: 		*-- FormSIGMVMVT (mesmo controle de terceiros). Se a instanciacao
456: 		*-- falhar por ProgID incorreto (em vez de OCX ausente), conferir
457: 		*-- via OLEVIEW/regedit (HKCR\TypeLib) numa maquina com o legado.
458: 		IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
459: 		   (TYPE("gb_4c_ModoTeste")   != "L" OR !gb_4c_ModoTeste)
460: 			TRY
461: 				THIS.cnt_4c_Container1.AddObject("obj_4c_TreeView", "OLEControl", "cttree.cttreeview")
462: 				WITH THIS.cnt_4c_Container1.obj_4c_TreeView
463: 					.Top     = 28
464: 					.Left    = 9
465: 					.Height  = 421
466: 					.Width   = 725
467: 					.Visible = .T.
468: 				ENDWITH
469: 			CATCH TO loc_oErrOle
470: 				MsgErro("Controle de " + CHR(225) + "rvore (ctTree.ocx) indispon" + ;
471: 						CHR(237) + "vel nesta esta" + CHR(231) + CHR(227) + "o: " + ;
472: 						loc_oErrOle.Message, "Aviso")
473: 			ENDTRY
474: 		ENDIF
475: 
476: 		*-- lbl_4c_Label3 ("O.P. :") - AutoSize = .F. + Width/Height do dump
477: 		*-- (35x15). Ver nota de AutoSize em ConfigurarControles.
478: 		THIS.cnt_4c_Container1.AddObject("lbl_4c_Label3", "Label")
479: 		WITH THIS.cnt_4c_Container1.lbl_4c_Label3
480: 			.AutoSize  = .F.
481: 			.FontName  = "Verdana"
482: 			.FontSize  = 8
483: 			.BackStyle = 0
484: 			.Caption   = "O.P. :"
485: 			.Top       = 6
486: 			.Left      = 12
487: 			.Width     = 35
488: 			.Height    = 15
489: 			.ForeColor = RGB(36, 84, 155)
490: 			.Visible   = .T.
491: 		ENDWITH
492: 
493: 		*-- lbl_4c_Label1 ("Envelope :") - dump 63x15.
494: 		THIS.cnt_4c_Container1.AddObject("lbl_4c_Label1", "Label")
495: 		WITH THIS.cnt_4c_Container1.lbl_4c_Label1
496: 			.AutoSize  = .F.
497: 			.FontName  = "Verdana"
498: 			.FontSize  = 8
499: 			.BackStyle = 0
500: 			.Caption   = "Envelope :"
501: 			.Top       = 7
502: 			.Left      = 146
503: 			.Width     = 63
504: 			.Height    = 15
505: 			.ForeColor = RGB(36, 84, 155)
506: 			.Visible   = .T.
507: 		ENDWITH
508: 
509: 		*-- txt_4c_OP (GetOP) - numerico (Value=0), equivalente a
510: 		*-- SigCdNei.Nops/SigMvCab.Nops. Format/InputMask/MaxLength
511: 		*-- transcritos do dump (regra CLAUDE.md #49 - os dois valem).
512: 		THIS.cnt_4c_Container1.AddObject("txt_4c_OP", "TextBox")
513: 		WITH THIS.cnt_4c_Container1.txt_4c_OP
514: 			.Alignment         = 3
515: 			.Value             = 0
516: 			.Format            = "R"
517: 			.Height            = 23
518: 			.InputMask         = "9999999999"
519: 			.Left              = 49
520: 			.MaxLength         = 10
521: 			.SpecialEffect     = 1
522: 			.Top               = 2
523: 			.Width             = 86
524: 			.DisabledBackColor = RGB(255, 255, 255)
525: 			.DisabledForeColor = RGB(0, 0, 128)
526: 			.BorderColor       = RGB(36, 84, 155)
527: 			.Visible           = .T.
528: 		ENDWITH
529: 
530: 		*-- txt_4c_Envelope (GetEnvelope) - numerico (Value=0), equivalente
531: 		*-- a SigCdNei.Nenvs.
532: 		THIS.cnt_4c_Container1.AddObject("txt_4c_Envelope", "TextBox")
533: 		WITH THIS.cnt_4c_Container1.txt_4c_Envelope
534: 			.Alignment         = 3
535: 			.Value             = 0
536: 			.Format            = "R"
537: 			.Height            = 23
538: 			.InputMask         = "9999999999"
539: 			.Left              = 210
540: 			.MaxLength         = 10
541: 			.SpecialEffect     = 1
542: 			.Top               = 3
543: 			.Width             = 86
544: 			.DisabledBackColor = RGB(255, 255, 255)
545: 			.DisabledForeColor = RGB(0, 0, 128)
546: 			.BorderColor       = RGB(36, 84, 155)
547: 			.Visible           = .T.
548: 		ENDWITH

*-- Linhas 745 a 1274:
745: 	* teste/validacao de UI) - por isso a guarda ArvoreDisponivel(), sem a
746: 	* qual a atribuicao derrubaria o Init com "Unknown member OBJ_4C_TREEVIEW".
747: 	*==========================================================================
748: 	PROTECTED PROCEDURE AplicarOrdemTabulacao()
749: 		LOCAL loc_oCnt, loc_nSeq
750: 
751: 		*-- Nivel da Form: Container1(1) -> Commandgroup1(2) -> Container2(3).
752: 		*-- Fwbtng1/Fwbtng2/Imagem seguem em 4/5/6 pela ordem de criacao,
753: 		*-- como no legado.
754: 		THIS.cnt_4c_Container1.TabIndex    = 1
755: 		THIS.cmg_4c_Commandgroup1.TabIndex = 2
756: 		THIS.cnt_4c_Container2.TabIndex    = 3
757: 
758: 		*-- Nivel de Container1, so os focalizaveis:
759: 		*-- txt_4c_OP(1) -> obj_4c_TreeView(2) -> txt_4c_Envelope(3).
760: 		loc_oCnt = THIS.cnt_4c_Container1
761: 		loc_oCnt.txt_4c_OP.TabIndex = 1
762: 
763: 		loc_nSeq = 1
764: 		IF THIS.ArvoreDisponivel() AND ;
765: 		   PEMSTATUS(loc_oCnt.obj_4c_TreeView, "TabIndex", 5)
766: 			loc_nSeq = loc_nSeq + 1
767: 			loc_oCnt.obj_4c_TreeView.TabIndex = loc_nSeq
768: 		ENDIF
769: 
770: 		loc_nSeq = loc_nSeq + 1
771: 		loc_oCnt.txt_4c_Envelope.TabIndex = loc_nSeq
772: 	ENDPROC
773: 
774: 	*==========================================================================
775: 	* ConfigurarEventos - Liga os eventos dos DOIS campos digitaveis da tela
776: 	* (GetOP e GetEnvelope do legado). Roda depois de TODOS os AddObject e
777: 	* ANTES do SetFocus do Init.
778: 	*
779: 	* NAO HA LOOKUP NESTA TELA, e isso foi CONFERIDO no dump, nao presumido:
780: 	* tasks\task772\SIGOPNOP_form_codigo_fonte.txt nao casa NENHUM dos padroes
781: 	* de busca do legado - zero "fwBuscaExt"/"fwBuscaSel"/"fwBuscaInt", zero
782: 	* "mAddColuna", zero "sigacess(" e zero "Acesso<X>(" (AcessoCampos/
783: 	* Contab/Contas/Empresa/Grupos/MovInd/MovMto/Produto/Titulo). O unico
784: 	* CreateObject do form eh "fSqlConector" (gerente de conexao do legado,
785: 	* hoje gnConnHandle + DataAccess). Os dois campos sao NUMEROS digitados a
786: 	* mao (O.P. e Envelope) que o Valid consulta direto; nao existe tabela de
787: 	* apoio para escolher em grade. Criar aqui um AbrirBusca*/AbrirLookup*
788: 	* seria INVENTAR tabela de lookup que o legado nunca consulta - viola o
789: 	* PILAR 1 e a regra explicita "NUNCA inventar tabelas de lookup que nao
790: 	* existem no original".
791: 	*
792: 	* Pelo mesmo motivo nao existe container de Salvar/Cancelar: o SCX legado
793: 	* tem UM CommandGroup de um unico botao (Encerrar) e dois CommandButton de
794: 	* navegacao da arvore (Expandir/Regredir) - esta tela ANALISA, nao grava.
795: 	* Os Click dos tres tambem sao ligados aqui (CmdEncerrarClick,
796: 	* CmdExpandirClick e CmdRegredirClick): sao TODOS os botoes que o legado
797: 	* tem, e nenhum deles eh CRUD.
798: 	*
799: 	* Por que "KeyPress" e nao "LostFocus": o legado valida no Valid (ao SAIR
800: 	* do campo) e BINDEVENT em "Valid" NAO dispara de forma confiavel em
801: 	* TextBox. O substituto canonico eh "KeyPress" TESTANDO a tecla - ENTER(13)
802: 	* e TAB(9), as duas que saem do campo. "LostFocus" esta proibido aqui pela
803: 	* regra oposta: o handler chama CarregarDados (SQLEXEC + redesenho da
804: 	* arvore) e LostFocus dispara SEMPRE, inclusive pelo SetFocus de outro
805: 	* controle, o que produz recursao. A regra CLAUDE.md #47 (lookup tem de ir
806: 	* em LostFocus) NAO se aplica: ela trata de handler que abre PICKER sem
807: 	* testar a tecla - aqui nao ha picker e a tecla eh testada.
808: 	*
809: 	* GotFocus reproduz DUAS coisas do legado, que juntas fazem dos dois
810: 	* campos mutuamente exclusivos:
811: 	*   GetOP.GotFocus       -> "This.Parent.GetEnvelope.Value = 0"
812: 	*   GetEnvelope.GotFocus -> "This.Parent.GetOP.Value = 0"
813: 	* e, no caso do O.P., mais o When ("ThisForm.Imagem.Visible = .f."), cujo
814: 	* Return(.t.) esta COMENTADO no SCX - ou seja, o When legado so tem esse
815: 	* efeito colateral. Ele vai para o GotFocus por dois motivos: BINDEVENT
816: 	* DESCARTA o retorno do delegate (um When ligado por BINDEVENT nao
817: 	* bloquearia nada mesmo) e When/GotFocus disparam na MESMA entrada no
818: 	* campo, logo o efeito visivel eh identico. O When do GetEnvelope eh
819: 	* "Return(.t.)" puro - nao tem efeito nenhum a reproduzir.
820: 	*
821: 	* Os DEZ handlers sao PUBLIC (sem PROTECTED): BINDEVENT ignora metodo
822: 	* PROTECTED em silencio (regra CLAUDE.md #3).
823: 	*
824: 	* FASE 8 acrescenta os tres ultimos - os eventos que faltavam para cobrir
825: 	* cada metodo com codigo do dump: TreeView.KeyPress, TreeView.NodeClick e
826: 	* Imagem.DblClick. Evento de ActiveX chega pelo MESMO BINDEVENT dos
827: 	* controles nativos (padrao do form irmao FormSIGMVMVT), mas o controle so
828: 	* existe se o AddObject do OCX deu certo - dai a guarda ArvoreDisponivel().
829: 	*==========================================================================
830: 	PROCEDURE ConfigurarEventos()
831: 		LOCAL loc_oCnt
832: 
833: 		loc_oCnt = THIS.cnt_4c_Container1
834: 
835: 		*-- GetOP: GotFocus (zera o Envelope + apaga a figura) e Valid
836: 		*-- (consulta por O.P.), este ultimo via KeyPress ENTER/TAB.
837: 		BINDEVENT(loc_oCnt.txt_4c_OP, "GotFocus", THIS, "TxtOPGotFocus")
838: 		BINDEVENT(loc_oCnt.txt_4c_OP, "KeyPress", THIS, "ValidarOP")
839: 
840: 		*-- GetEnvelope: GotFocus (zera a O.P.) e Valid (consulta por
841: 		*-- Envelope).
842: 		BINDEVENT(loc_oCnt.txt_4c_Envelope, "GotFocus", THIS, "TxtEnvelopeGotFocus")
843: 		BINDEVENT(loc_oCnt.txt_4c_Envelope, "KeyPress", THIS, "ValidarEnvelope")
844: 
845: 		*-- Commandgroup1 ("Encerrar"): o BINDEVENT vai no BOTAO, nao no
846: 		*-- grupo - o legado poe o codigo em Command3.Click e o Click do
847: 		*-- GRUPO so dispararia se o botao nao tivesse codigo proprio.
848: 		BINDEVENT(THIS.cmg_4c_Commandgroup1.Buttons(1), "Click", THIS, "CmdEncerrarClick")
849: 
850: 		*-- Fwbtng1/Fwbtng2: navegacao de nivel da arvore (Expandir/Regredir).
851: 		*-- Sao CommandButton SOLTOS na Form no legado, nao membros de grupo.
852: 		BINDEVENT(THIS.cmd_4c_Fwbtng1, "Click", THIS, "CmdExpandirClick")
853: 		BINDEVENT(THIS.cmd_4c_Fwbtng2, "Click", THIS, "CmdRegredirClick")
854: 
855: 		*-- obj_4c_TreeView: KeyPress (ESC) e NodeClick (no selecionado) do
856: 		*-- TreeView legado. O DblClick do TreeView legado esta VAZIO no dump
857: 		*-- ("*** ActiveX Control Event ***" e mais nada), entao nao ha o que
858: 		*-- ligar nele - ligar um handler ali seria inventar comportamento.
859: 		IF THIS.ArvoreDisponivel()
860: 			BINDEVENT(loc_oCnt.obj_4c_TreeView, "KeyPress",  THIS, "TreeViewKeyPress")
861: 			BINDEVENT(loc_oCnt.obj_4c_TreeView, "NodeClick", THIS, "TreeViewNodeClick")
862: 		ENDIF
863: 
864: 		*-- img_4c_Imagem.DblClick - o proprio ToolTipText do legado anuncia
865: 		*-- ("Imagem do Produto (Clique Duplo Para Zoom)"): amplia a foto do
866: 		*-- produto da O.P. pesquisada.
867: 		BINDEVENT(THIS.img_4c_Imagem, "DblClick", THIS, "ImgImagemDblClick")
868: 	ENDPROC
869: 
870: 	*==========================================================================
871: 	* TxtOPGotFocus - GetOP.GotFocus + GetOP.When do legado:
872: 	*   This.Parent.GetEnvelope.Value = 0
873: 	*   ThisForm.Imagem.Visible = .f.
874: 	*
875: 	* A segunda linha eh o When (ver ConfigurarEventos): ao voltar para o
876: 	* campo da O.P., a figura do produto da pesquisa ANTERIOR sai da tela.
877: 	* Sem ela o usuario digitaria uma O.P. nova olhando a foto da antiga.
878: 	*==========================================================================
879: 	PROCEDURE TxtOPGotFocus()
880: 		THIS.cnt_4c_Container1.txt_4c_Envelope.Value = 0
881: 		THIS.img_4c_Imagem.Visible = .F.
882: 	ENDPROC
883: 
884: 	*==========================================================================
885: 	* TxtEnvelopeGotFocus - GetEnvelope.GotFocus do legado:
886: 	*   This.Parent.GetOP.Value = 0
887: 	*
888: 	* O When do GetEnvelope eh "Return(.t.)" puro - sem efeito a reproduzir, e
889: 	* por isso a figura NAO eh apagada aqui (o caminho do Envelope nunca mexe
890: 	* na Imagem, nem no legado).
891: 	*==========================================================================
892: 	PROCEDURE TxtEnvelopeGotFocus()
893: 		THIS.cnt_4c_Container1.txt_4c_OP.Value = 0
894: 	ENDPROC
895: 
896: 	*==========================================================================
897: 	* ValidarOP - GetOP.Valid do legado. A consulta (SELECT + UNION ALL +
898: 	* fallback de SigPdMvf + figura do produto) mora no SIGOPNOPBO e o desenho
899: 	* da arvore em PopularArvore; aqui fica so o GATILHO, com a guarda do
900: 	* legado e a do teclado.
901: 	*
902: 	* Os tres IF sao SEPARADOS de proposito: VFP9 NAO faz short-circuit em OR,
903: 	* entao juntar "VARTYPE(par_nKeyCode) != 'N' OR par_nKeyCode != 13"
904: 	* avaliaria a comparacao numerica tambem quando o argumento nao eh
905: 	* numerico, estourando "Operator/operand type mismatch".
906: 	*
907: 	* Os RETURN ficam todos FORA de qualquer TRY (regra CLAUDE.md #1).
908: 	*==========================================================================
909: 	PROCEDURE ValidarOP(par_nKeyCode, par_nShiftAltCtrl)
910: 		LOCAL loc_nValor, loc_oErro
911: 
912: 		*-- KeyPress passa SEMPRE os dois argumentos, mas o handler tambem eh
913: 		*-- alcancavel por chamada direta (harness de teste) - sem esta guarda
914: 		*-- a comparacao abaixo estouraria.
915: 		IF VARTYPE(par_nKeyCode) != "N"
916: 			RETURN
917: 		ENDIF
918: 
919: 		*-- So ENTER e TAB saem do campo. Sem este teste a consulta dispararia
920: 		*-- a CADA tecla, com o numero da O.P. pela metade.
921: 		IF par_nKeyCode != 13 AND par_nKeyCode != 9
922: 			RETURN
923: 		ENDIF
924: 
925: 		IF THIS.this_lEmConsulta
926: 			RETURN
927: 		ENDIF
928: 
929: 		loc_nValor = THIS.cnt_4c_Container1.txt_4c_OP.Value
930: 		loc_nValor = IIF(VARTYPE(loc_nValor) = "N", loc_nValor, 0)
931: 
932: 		*-- "If ! Empty(This.Value)" que envolve o Valid legado inteiro: campo
933: 		*-- zerado nao consulta e nao avisa nada.
934: 		IF loc_nValor != 0
935: 			THIS.this_lEmConsulta = .T.
936: 
937: 			TRY
938: 				THIS.CarregarDados()
939: 			CATCH TO loc_oErro
940: 				MsgErro("Falha ao consultar a O.P.: " + loc_oErro.Message + CHR(13) + ;
941: 						"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
942: 						"Procedure: " + loc_oErro.Procedure, "Erro")
943: 			ENDTRY
944: 
945: 			*-- Liberada DEPOIS do ENDTRY, para valer tambem quando o CATCH
946: 			*-- dispara - flag travada ligada MATARIA o campo pelo resto da
947: 			*-- vida do form (regra CLAUDE.md #47).
948: 			THIS.this_lEmConsulta = .F.
949: 		ENDIF
950: 	ENDPROC
951: 
952: 	*==========================================================================
953: 	* ValidarEnvelope - GetEnvelope.Valid do legado. Gemeo de ValidarOP (valem
954: 	* as mesmas notas de short-circuit, de guarda de reentrancia e de liberacao
955: 	* da flag depois do ENDTRY); a diferenca eh so o campo lido - e, portanto,
956: 	* o criterio que CarregarDados escolhe (loc_lPorEnvelope = (O.P. = 0)).
957: 	*
958: 	* O caminho do Envelope NAO toca na figura do produto: o Valid do
959: 	* GetEnvelope legado nao tem o bloco de Imagem/StrToFile que o GetOP tem.
960: 	*==========================================================================
961: 	PROCEDURE ValidarEnvelope(par_nKeyCode, par_nShiftAltCtrl)
962: 		LOCAL loc_nValor, loc_oErro
963: 
964: 		IF VARTYPE(par_nKeyCode) != "N"
965: 			RETURN
966: 		ENDIF
967: 
968: 		IF par_nKeyCode != 13 AND par_nKeyCode != 9
969: 			RETURN
970: 		ENDIF
971: 
972: 		IF THIS.this_lEmConsulta
973: 			RETURN
974: 		ENDIF
975: 
976: 		loc_nValor = THIS.cnt_4c_Container1.txt_4c_Envelope.Value
977: 		loc_nValor = IIF(VARTYPE(loc_nValor) = "N", loc_nValor, 0)
978: 
979: 		IF loc_nValor != 0
980: 			THIS.this_lEmConsulta = .T.
981: 
982: 			TRY
983: 				THIS.CarregarDados()
984: 			CATCH TO loc_oErro
985: 				MsgErro("Falha ao consultar o Envelope: " + loc_oErro.Message + CHR(13) + ;
986: 						"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
987: 						"Procedure: " + loc_oErro.Procedure, "Erro")
988: 			ENDTRY
989: 
990: 			THIS.this_lEmConsulta = .F.
991: 		ENDIF
992: 	ENDPROC
993: 
994: 	*==========================================================================
995: 	* CmdEncerrarClick - Commandgroup1.Command3.Click do legado, as DUAS
996: 	* linhas, NESTA ordem:
997: 	*   Delete File (ThisForm.Arqfigura)
998: 	*   ThisForm.Release
999: 	*
1000: 	* O botao eh o UNICO do CommandGroup (ButtonCount = 1, Caption "Encerrar",
1001: 	* Cancel = .T.) - por isso o BINDEVENT vai em .Buttons(1) e nao no grupo:
1002: 	* o legado poe o codigo no BOTAO (Command3.Click), e o Click do GRUPO so
1003: 	* dispararia se o botao nao tivesse codigo proprio.
1004: 	*
1005: 	* (a) O "Delete File" mora no BO (SIGOPNOPBO.ExcluirImagemTemporaria), que
1006: 	* eh quem conhece o caminho do .jpg temporario extraido de SigCdPro.FigJpgs
1007: 	* e ja traz as duas defesas que o legado nao tem: IF FILE() antes de apagar
1008: 	* e SET SAFETY OFF em volta do DELETE FILE (com SAFETY ON ele abre dialogo
1009: 	* de confirmacao, e dialogo modal travaria o pipeline). O legado apaga as
1010: 	* cegas - e no caminho em que o produto NAO tem foto o Arqfigura dele
1011: 	* aponta para arquivo que nunca foi criado (ou para o " " do Init), entao o
1012: 	* Delete File legado erra ali. A guarda eh desvio DELIBERADO e invisivel ao
1013: 	* usuario (PILAR 1 preservado).
1014: 	*
1015: 	* (b) .Picture = "" ANTES de apagar: o controle Image mantem o arquivo
1016: 	* preso enquanto aponta para ele, e o CLEAR RESOURCES do BO sozinho nao
1017: 	* solta essa referencia. Sem isto o DELETE FILE falha e o .jpg fica para
1018: 	* tras em SYS(2023) a cada pesquisa. Nao tem efeito visivel - a tela esta
1019: 	* fechando - entao tambem nao mexe com o PILAR 1.
1020: 	*
1021: 	* (c) O TRY cobre SO a limpeza, e o Release fica FORA dele: falha ao apagar
1022: 	* um temporario nao pode impedir a tela de fechar, que eh a razao de existir
1023: 	* do botao. O CATCH nao eh silencioso (CLAUDE.md #9).
1024: 	*
1025: 	* (d) Release() e nao Hide(): esta tela NAO devolve resultado a chamador
1026: 	* nenhum - conferido, nao presumido. O dump do SCX nao tem PROCEDURE Unload
1027: 	* (logo nao existe "DO FORM ... TO"), o form nao tem property de retorno, e
1028: 	* nao ha um unico call site de SIGOPNOP no acervo legado nem no projeto
1029: 	* migrado. A regra do Hide
1030: 	* (feedback_release_mata_referencia_dialogo_usa_hide) vale para dialogo
1031: 	* FILHO cujo pai le o resultado depois do Show(); aqui Hide() deixaria o
1032: 	* objeto vivo segurando a datasession privada e os cursores dela.
1033: 	*
1034: 	* O Release dispara Destroy -> SIGOPNOPBO.Destroy, que repete
1035: 	* ExcluirImagemTemporaria + FecharCursoresResultado. Repetir eh inocuo (o
1036: 	* BO zera this_cArquivoImagem e os dois metodos sao idempotentes) e eh a
1037: 	* rede de seguranca para quem fechar a tela por outro caminho - Alt+F4,
1038: 	* que continua valendo porque Closable segue .T. (ver o bloco de
1039: 	* propriedades da classe).
1040: 	*==========================================================================
1041: 	PROCEDURE CmdEncerrarClick()
1042: 		LOCAL loc_oErro
1043: 
1044: 		TRY
1045: 			*-- (b) solta a referencia do Image antes do DELETE FILE
1046: 			THIS.img_4c_Imagem.Picture = ""
1047: 			THIS.img_4c_Imagem.Visible = .F.
1048: 
1049: 			IF VARTYPE(THIS.this_oBusinessObject) = "O"
1050: 				THIS.this_oBusinessObject.ExcluirImagemTemporaria()
1051: 			ENDIF
1052: 
1053: 			*-- Espelho de ThisForm.Arqfigura: o arquivo acabou de ser
1054: 			*-- apagado, entao a property nao pode seguir apontando para ele.
1055: 			THIS.this_cArquivoFigura = ""
1056: 		CATCH TO loc_oErro
1057: 			MsgErro("Falha ao apagar a imagem tempor" + CHR(225) + "ria: " + ;
1058: 					loc_oErro.Message + CHR(13) + ;
1059: 					"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1060: 					"Procedure: " + loc_oErro.Procedure, "Erro")
1061: 		ENDTRY
1062: 
1063: 		*-- "ThisForm.Release" - FORA do TRY (ver nota (c) acima)
1064: 		THIS.Release()
1065: 	ENDPROC
1066: 
1067: 	*==========================================================================
1068: 	* CmdExpandirClick - Fwbtng1.Click do legado (ToolTipText "Expandir", seta
1069: 	* para baixo), transcrito linha a linha:
1070: 	*
1071: 	*   loTree1 = ThisForm.Container1.TreeView
1072: 	*   llExpande = .f.
1073: 	*   For lnNode = 0 To loTree1.lIstCount-1
1074: 	*       If ThisForm.pnNodeExp + 1 = loTree1.NodeLevel(lnNode)
1075: 	*           loTree1.NodeExpanded(lnNode) = .t.
1076: 	*           llExpande = .t.
1077: 	*       Endif
1078: 	*   EndFor
1079: 	*   If llExpande
1080: 	*       ThisForm.pnNodeExp = ThisForm.pnNodeExp + 1
1081: 	*   Endif
1082: 	*
1083: 	* Abre UM nivel por clique: expande todos os nos do nivel SEGUINTE ao
1084: 	* corrente (this_nNodeExp, posto em 1 no fim de PopularArvore) e so avanca
1085: 	* o contador se existia no naquele nivel - sem o llExpande, cliques
1086: 	* repetidos no fundo da arvore empurrariam o contador indefinidamente e o
1087: 	* botao Regredir precisaria do mesmo numero de cliques para voltar a ter
1088: 	* efeito.
1089: 	*
1090: 	* A arvore eh base ZERO (o laco vai de 0 a ListCount-1): transcrito do
1091: 	* legado, NAO convertido para 1..N.
1092: 	*
1093: 	* Nada de ReDraw/Refresh no fim: os dois Click do legado nao chamam nenhum
1094: 	* dos dois (so maketree/maketreeenv chamam, ja reproduzidos em
1095: 	* PopularArvore) - o proprio NodeExpanded repinta.
1096: 	*
1097: 	* ArvoreDisponivel() eh obrigatorio: sem o OCX registrado na estacao (ou em
1098: 	* modo teste/validacao de UI) o obj_4c_TreeView nao existe e a primeira
1099: 	* linha derrubaria o metodo com "Unknown member OBJ_4C_TREEVIEW". O RETURN
1100: 	* da guarda fica FORA de qualquer TRY (CLAUDE.md #1).
1101: 	*
1102: 	* PUBLIC (sem PROTECTED) porque eh alvo de BINDEVENT - metodo PROTECTED eh
1103: 	* ignorado em silencio (CLAUDE.md #3).
1104: 	*==========================================================================
1105: 	PROCEDURE CmdExpandirClick()
1106: 		LOCAL loc_lExpandiu, loc_nNo, loc_nTotal, loc_oErro
1107: 
1108: 		IF !THIS.ArvoreDisponivel()
1109: 			RETURN
1110: 		ENDIF
1111: 
1112: 		loc_lExpandiu = .F.
1113: 
1114: 		TRY
1115: 			WITH THIS.cnt_4c_Container1.obj_4c_TreeView
1116: 				loc_nTotal = .ListCount
1117: 
1118: 				FOR loc_nNo = 0 TO loc_nTotal - 1
1119: 					IF THIS.this_nNodeExp + 1 = .NodeLevel(loc_nNo)
1120: 						.NodeExpanded(loc_nNo) = .T.
1121: 						loc_lExpandiu = .T.
1122: 					ENDIF
1123: 				ENDFOR
1124: 			ENDWITH
1125: 
1126: 			IF loc_lExpandiu
1127: 				THIS.this_nNodeExp = THIS.this_nNodeExp + 1
1128: 			ENDIF
1129: 		CATCH TO loc_oErro
1130: 			MsgErro("Falha ao expandir a " + CHR(225) + "rvore: " + ;
1131: 					loc_oErro.Message + CHR(13) + ;
1132: 					"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1133: 					"Procedure: " + loc_oErro.Procedure, "Erro")
1134: 		ENDTRY
1135: 	ENDPROC
1136: 
1137: 	*==========================================================================
1138: 	* CmdRegredirClick - Fwbtng2.Click do legado (ToolTipText "Regredir", seta
1139: 	* para cima), transcrito linha a linha:
1140: 	*
1141: 	*   If Type('ThisForm.pnNodeExp') = 'N' And ThisForm.pnNodeExp > 0
1142: 	*       loTree1 = ThisForm.Container1.TreeView
1143: 	*       For lnNode = 0 To loTree1.lIstCount-1
1144: 	*           If ThisForm.pnNodeExp = loTree1.NodeLevel(lnNode)
1145: 	*               loTree1.NodeExpanded(lnNode) = .f.
1146: 	*           Endif
1147: 	*       EndFor
1148: 	*       ThisForm.pnNodeExp = ThisForm.pnNodeExp - 1
1149: 	*   EndIf
1150: 	*
1151: 	* Fecha o nivel CORRENTE e recua o contador - inverso do Expandir, que abre
1152: 	* o nivel SEGUINTE. A assimetria (um usa pnNodeExp + 1, o outro pnNodeExp)
1153: 	* eh do legado e NAO se uniformiza.
1154: 	*
1155: 	* As DUAS condicoes do IF legado estao reproduzidas, mas em IF SEPARADOS:
1156: 	* VFP9 nao faz short-circuit, entao "VARTYPE(...) = 'N' AND
1157: 	* THIS.this_nNodeExp > 0" avaliaria a comparacao numerica tambem quando a
1158: 	* property nao fosse numerica. O Type() do legado existe porque lah a
1159: 	* property eh criada em runtime; aqui this_nNodeExp eh DECLARADA numerica
1160: 	* no DEFINE CLASS, entao a guarda eh redundante - mantida por fidelidade e
1161: 	* porque custa nada.
1162: 	*
1163: 	* O "> 0" eh o que impede o contador de ficar negativo: zerado, o Regredir
1164: 	* nao faz nada (nem decrementa) e o Expandir volta a abrir o nivel 1.
1165: 	*
1166: 	* Diferente do Expandir, aqui o contador recua SEMPRE que a guarda passa -
1167: 	* mesmo que nenhum no do nivel corrente tenha sido encontrado. Tambem eh do
1168: 	* legado: neste Click nao existe llExpande.
1169: 	*==========================================================================
1170: 	PROCEDURE CmdRegredirClick()
1171: 		LOCAL loc_nNo, loc_nTotal, loc_oErro
1172: 
1173: 		IF !THIS.ArvoreDisponivel()
1174: 			RETURN
1175: 		ENDIF
1176: 
1177: 		*-- "Type('ThisForm.pnNodeExp') = 'N'" - 1a metade da guarda legado
1178: 		IF VARTYPE(THIS.this_nNodeExp) != "N"
1179: 			RETURN
1180: 		ENDIF
1181: 
1182: 		*-- "And ThisForm.pnNodeExp > 0" - 2a metade, em IF separado
1183: 		IF THIS.this_nNodeExp <= 0
1184: 			RETURN
1185: 		ENDIF
1186: 
1187: 		TRY
1188: 			WITH THIS.cnt_4c_Container1.obj_4c_TreeView
1189: 				loc_nTotal = .ListCount
1190: 
1191: 				FOR loc_nNo = 0 TO loc_nTotal - 1
1192: 					IF THIS.this_nNodeExp = .NodeLevel(loc_nNo)
1193: 						.NodeExpanded(loc_nNo) = .F.
1194: 					ENDIF
1195: 				ENDFOR
1196: 			ENDWITH
1197: 
1198: 			THIS.this_nNodeExp = THIS.this_nNodeExp - 1
1199: 		CATCH TO loc_oErro
1200: 			MsgErro("Falha ao regredir a " + CHR(225) + "rvore: " + ;
1201: 					loc_oErro.Message + CHR(13) + ;
1202: 					"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1203: 					"Procedure: " + loc_oErro.Procedure, "Erro")
1204: 		ENDTRY
1205: 	ENDPROC
1206: 
1207: 	*==========================================================================
1208: 	* TreeViewKeyPress - TreeView.KeyPress do legado. Evento de ActiveX recebe
1209: 	* UM unico argumento (keyascii), diferente do KeyPress nativo de TextBox,
1210: 	* que recebe dois - por isso o LPARAMETERS vai no CORPO e nao na linha do
1211: 	* PROCEDURE (mesma forma do form irmao FormSIGMVMVT.TreeViewKeyPress).
1212: 	*
1213: 	*   LPARAMETERS keyascii
1214: 	*   If KeyAscii = 27
1215: 	*       Release Windows
1216: 	*   Endif
1217: 	*
1218: 	* RELEASE WINDOWS eh transcricao LITERAL. Medido: o comando age sobre
1219: 	* janelas de DEFINE WINDOW, NAO sobre forms, e o projeto nao define
1220: 	* nenhuma - ou seja, no legado esta linha ja era inerte. Trocar por
1221: 	* THIS.Release() FECHARIA a tela ao ESC dentro da arvore, comportamento
1222: 	* que o legado NAO tem: o ESC desta tela eh o Cancel = .T. do botao
1223: 	* Encerrar (transcrito do dump), que alem de fechar ainda apaga o .jpg
1224: 	* temporario. Inventar um segundo caminho de fechamento aqui mudaria a UX
1225: 	* sem nenhuma linha do legado pedindo.
1226: 	*
1227: 	* A guarda de VARTYPE existe porque o handler tambem eh alcancavel por
1228: 	* chamada direta (harness de teste), onde o argumento pode chegar ausente;
1229: 	* sem ela a comparacao numerica estouraria "Operator/operand type
1230: 	* mismatch". O RETURN fica FORA de qualquer TRY (CLAUDE.md #1).
1231: 	*
1232: 	* PUBLIC (sem PROTECTED) porque eh alvo de BINDEVENT (CLAUDE.md #3).
1233: 	*==========================================================================
1234: 	PROCEDURE TreeViewKeyPress
1235: 		LPARAMETERS par_nKeyAscii
1236: 
1237: 		IF VARTYPE(par_nKeyAscii) != "N"
1238: 			RETURN
1239: 		ENDIF
1240: 
1241: 		IF par_nKeyAscii = 27
1242: 			RELEASE WINDOWS
1243: 		ENDIF
1244: 	ENDPROC
1245: 
1246: 	*==========================================================================
1247: 	* TreeViewNodeClick - TreeView.NodeClick do legado (ActiveX, LPARAMETERS
1248: 	* nindex, ncolumn), transcrito com a MESMA estrutura aninhada:
1249: 	*
1250: 	*   If ! Empty(Thisform.plDblClick)
1251: 	*       If This.NodeCargo(nIndex) = Thisform.plDblClick
1252: 	*           If !Empty(ThisForm.paEmpDopNums[1])
1253: 	*               Declare ThisForm.paEmpDopNums[Alen(ThisForm.paEmpDopNums)+1]
1254: 	*           EndIf
1255: 	*           ThisForm.paEmpDopNums[Alen(...)] = GetcEmp.Value + GetDopes.Value + Str(GetNumes.Value,6)
1256: 	*           GetcEmp.Value  = Left(This.NodeCargo(nIndex),3)
1257: 	*           GetDopes.Value = Substr(This.NodeCargo(nIndex),4,20)
1258: 	*           GetNumes.Value = Val(Alltrim(Substr(This.NodeCargo(nIndex),24)))
1259: 	*           ThisForm.Maketree()
1260: 	*       Else
1261: 	*           Thisform.plDblClick = This.NodeCargo(nIndex)
1262: 	*       Endif
1263: 	*   Else
1264: 	*       Thisform.plDblClick = This.NodeCargo(nIndex)
1265: 	*   EndIf
1266: 	*
1267: 	* O ramo de DRILL (2o clique no MESMO no) esta reproduzido no que EXISTE,
1268: 	* e duas coisas dele foram MEDIDAS no dump antes de decidir:
1269: 	*
1270: 	* (1) **Nenhum no recebe cargo.** "NodeCargo(" aparece 6 vezes em
1271: 	*     tasks\task772\SIGOPNOP_form_codigo_fonte.txt e TODAS as 6 sao
1272: 	*     LEITURA ("This.NodeCargo(nIndex)") - zero atribuicao. Os dois
1273: 	*     metodos que montam a arvore (maketree/maketreeenv) chamam
1274: 	*     AddPictureNode + NodeHeader/NodeExpanded/NodeShowChecks/

*-- Linhas 1299 a 1580:
1299: 	* Comparacao com "==" (e nao "="): exata em qualquer SET EXACT, e
1300: 	* equivalente ao "=" do legado sob o SET EXACT ON do config.prg.
1301: 	*
1302: 	* PUBLIC (sem PROTECTED) porque eh alvo de BINDEVENT (CLAUDE.md #3).
1303: 	*==========================================================================
1304: 	PROCEDURE TreeViewNodeClick
1305: 		LPARAMETERS par_nIndex, par_nColumn
1306: 		LOCAL loc_uCargo, loc_cCargo, loc_lLeu, loc_oErro
1307: 
1308: 		IF !THIS.ArvoreDisponivel()
1309: 			RETURN
1310: 		ENDIF
1311: 
1312: 		IF VARTYPE(par_nIndex) != "N"
1313: 			RETURN
1314: 		ENDIF
1315: 
1316: 		loc_cCargo = ""
1317: 		loc_lLeu   = .F.
1318: 
1319: 		TRY
1320: 			loc_uCargo = TratarNulo(THIS.cnt_4c_Container1.obj_4c_TreeView.NodeCargo(par_nIndex), "")
1321: 
1322: 			IF !EMPTY(loc_uCargo)
1323: 				loc_cCargo = ALLTRIM(TRANSFORM(loc_uCargo))
1324: 			ENDIF
1325: 
1326: 			loc_lLeu = .T.
1327: 		CATCH TO loc_oErro
1328: 			MsgErro("Falha ao ler o n" + CHR(243) + " clicado na " + CHR(225) + "rvore: " + ;
1329: 					loc_oErro.Message + CHR(13) + ;
1330: 					"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1331: 					"Procedure: " + loc_oErro.Procedure, "Erro")
1332: 		ENDTRY
1333: 
1334: 		*-- Leitura falhou: nao mexe no estado de navegacao (o RETURN fica
1335: 		*-- FORA do TRY - CLAUDE.md #1).
1336: 		IF !loc_lLeu
1337: 			RETURN
1338: 		ENDIF
1339: 
1340: 		*-- "If ! Empty(Thisform.plDblClick)"
1341: 		IF !EMPTY(THIS.this_cUltimoNoClicado)
1342: 			*-- "If This.NodeCargo(nIndex) = Thisform.plDblClick"
1343: 			IF loc_cCargo == THIS.this_cUltimoNoClicado
1344: 				*-- 2o clique no MESMO no - ramo de DRILL
1345: 				THIS.EmpilharChaveNavegacao()
1346: 				THIS.this_cChaveNavegacao = loc_cCargo
1347: 				THIS.PopularArvore(.F.)
1348: 			ELSE
1349: 				*-- "Thisform.plDblClick = This.NodeCargo(nIndex)"
1350: 				THIS.this_cUltimoNoClicado = loc_cCargo
1351: 			ENDIF
1352: 		ELSE
1353: 			*-- Mesmo ELSE do legado, no nivel de fora
1354: 			THIS.this_cUltimoNoClicado = loc_cCargo
1355: 		ENDIF
1356: 	ENDPROC
1357: 
1358: 	*==========================================================================
1359: 	* EmpilharChaveNavegacao - as tres linhas de pilha do NodeClick legado:
1360: 	*
1361: 	*   If !Empty(ThisForm.paEmpDopNums[1])
1362: 	*       Declare ThisForm.paEmpDopNums[Alen(ThisForm.paEmpDopNums)+1]
1363: 	*   EndIf
1364: 	*   ThisForm.paEmpDopNums[Alen(ThisForm.paEmpDopNums)] = <chave corrente>
1365: 	*
1366: 	* A 1a chave ocupa o elemento que o Init ja criou (DIMENSION [1] em
1367: 	* InicializarForm, espelho do "Declare ThisForm.paEmpDopNums[1]"); da 2a
1368: 	* em diante o array CRESCE um elemento por drill.
1369: 	*
1370: 	* O "!Empty(paEmpDopNums[1])" eh o jeito do legado de perguntar "o slot 1
1371: 	* ja esta ocupado?", e isso so funciona porque a chave empilhada NUNCA eh
1372: 	* vazia: ela termina em Str(<numero>, 6), que no pior caso vale "     0".
1373: 	* Por isso this_cChaveNavegacao NASCE com STR(0, 6) e nao com "" - ver a
1374: 	* nota em InicializarForm. Com chave inicial vazia a pilha nao crescia
1375: 	* nunca (medido no probe da Fase 8).
1376: 	*
1377: 	* A pilha eh WRITE-ONLY tambem no legado - conferido no dump: fora do
1378: 	* Init, "paEmpDopNums" so aparece nas tres linhas acima, nunca como
1379: 	* leitura. Nao existe "voltar um nivel" para reproduzir; reproduzi-la
1380: 	* assim eh fiel, e inventar o pop seria funcionalidade nova.
1381: 	*==========================================================================
1382: 	PROTECTED PROCEDURE EmpilharChaveNavegacao()
1383: 		LOCAL loc_nTopo
1384: 
1385: 		IF !EMPTY(THIS.this_aEmpDopNums[1])
1386: 			loc_nTopo = ALEN(THIS.this_aEmpDopNums) + 1
1387: 			DIMENSION THIS.this_aEmpDopNums[loc_nTopo]
1388: 		ENDIF
1389: 
1390: 		THIS.this_aEmpDopNums[ALEN(THIS.this_aEmpDopNums)] = THIS.this_cChaveNavegacao
1391: 	ENDPROC
1392: 
1393: 	*==========================================================================
1394: 	* ImgImagemDblClick - Imagem.DblClick do legado (ToolTipText "Imagem do
1395: 	* Produto (Clique Duplo Para Zoom)"):
1396: 	*
1397: 	*   lcArquivo = Sys(2023) + '\' + Sys(2015) + '.Jpg'
1398: 	*   Select crTmpPro
1399: 	*   If Not Empty(crTmpPro.FigJpgs) And Not IsNull(crTmpPro.FigJpgs)
1400: 	*       =StrToFile(crTmpPro.FigJpgs, lcArquivo)
1401: 	*   EndIf
1402: 	*   If File(lcArquivo)
1403: 	*       Do Form SigOpZom With lcArquivo, 'Produto : ' + crTmpPro.CPros + ' - ' + crTmpPro.DPros, ''
1404: 	*       Delete File (lcArquivo)
1405: 	*   EndIf
1406: 	*
1407: 	* O crTmpPro do legado eh o cursor_4c_Produto do BO (SIGOPNOPBO.
1408: 	* this_cCursorProduto), populado por BuscarImagemProduto no caminho da
1409: 	* O.P. - o mesmo SELECT cpros, dpros, FigJpgs From SigCdPro. O arquivo
1410: 	* daqui eh um temporario PROPRIO (SYS(2015) novo), separado do
1411: 	* this_cArquivoImagem que alimenta o img_4c_Imagem da tela: eh assim no
1412: 	* legado, e por isso ele apaga este e nao o outro.
1413: 	*
1414: 	* Tres desvios deliberados, nenhum visivel ao usuario:
1415: 	*   (a) a work area corrente eh salva e restaurada em volta do
1416: 	*       SELECT - o legado troca de area e nunca repoe;
1417: 	*   (b) STRTOFILE eh TESTADO (> 0) antes de tentar abrir o zoom, em vez de
1418: 	*       descartar o retorno com "=StrToFile(...)";
1419: 	*   (c) SET SAFETY OFF em volta do ERASE: com SAFETY ON o VFP9 abre
1420: 	*       dialogo de confirmacao, e dialogo modal trava o pipeline
1421: 	*       (CLAUDE.md #6). O legado apaga as cegas.
1422: 	*
1423: 	* NAO ha STRCONV/base64 aqui: o legado grava o memo FigJpgs direto com
1424: 	* StrToFile, e o BO desta task faz igual (SIGOPNOPBO.BuscarImagemProduto).
1425: 	* Acrescentar um STRCONV(...,14) decodificaria duas vezes a imagem de quem
1426: 	* grava JPG puro.
1427: 	*
1428: 	* PUBLIC (sem PROTECTED) porque eh alvo de BINDEVENT (CLAUDE.md #3).
1429: 	*==========================================================================
1430: 	PROCEDURE ImgImagemDblClick()
1431: 		LOCAL loc_cCursor, loc_cArquivo, loc_cProduto, loc_cDescProduto
1432: 		LOCAL loc_cFoto, loc_cAliasAnterior, loc_cSafety, loc_oErro
1433: 
1434: 		IF VARTYPE(THIS.this_oBusinessObject) != "O"
1435: 			RETURN
1436: 		ENDIF
1437: 
1438: 		loc_cCursor = THIS.this_oBusinessObject.this_cCursorProduto
1439: 
1440: 		*-- "Select crTmpPro": sem o cursor do produto nao ha foto a ampliar
1441: 		*-- (acontece quando a pesquisa foi por Envelope - esse caminho do
1442: 		*-- legado nunca consulta SigCdPro).
1443: 		IF !USED(loc_cCursor)
1444: 			RETURN
1445: 		ENDIF
1446: 
1447: 		loc_cArquivo     = ""
1448: 		loc_cProduto     = ""
1449: 		loc_cDescProduto = ""
1450: 		loc_cAliasAnterior = ALIAS()
1451: 
1452: 		TRY
1453: 			SELECT (loc_cCursor)
1454: 
1455: 			IF !EOF()
1456: 				loc_cProduto     = ALLTRIM(TratarNulo(EVALUATE(loc_cCursor + ".Cpros"), ""))
1457: 				loc_cDescProduto = ALLTRIM(TratarNulo(EVALUATE(loc_cCursor + ".Dpros"), ""))
1458: 
1459: 				*-- "If Not Empty(crTmpPro.FigJpgs) And Not IsNull(...)" -
1460: 				*-- TratarNulo cobre o IsNull (CLAUDE.md #27: EMPTY(.NULL.)
1461: 				*-- devolve .F., entao o EMPTY sozinho nao bastaria).
1462: 				loc_cFoto = TratarNulo(EVALUATE(loc_cCursor + ".FigJpgs"), "")
1463: 
1464: 				IF !EMPTY(loc_cFoto)
1465: 					loc_cArquivo = SYS(2023) + "\" + ALLTRIM(SYS(2015)) + ".Jpg"
1466: 
1467: 					IF STRTOFILE(loc_cFoto, loc_cArquivo) <= 0
1468: 						loc_cArquivo = ""
1469: 					ENDIF
1470: 				ENDIF
1471: 			ENDIF
1472: 		CATCH TO loc_oErro
1473: 			MsgErro("Falha ao extrair a imagem do produto: " + ;
1474: 					loc_oErro.Message + CHR(13) + ;
1475: 					"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1476: 					"Procedure: " + loc_oErro.Procedure, "Erro")
1477: 			loc_cArquivo = ""
1478: 		ENDTRY
1479: 
1480: 		*-- (a) repoe a area de trabalho do chamador
1481: 		IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1482: 			SELECT (loc_cAliasAnterior)
1483: 		ENDIF
1484: 
1485: 		*-- "If File(lcArquivo) / Do Form SigOpZom ... / Delete File". O
1486: 		*-- Show() do dialogo filho fica FORA de qualquer TRY (CLAUDE.md #29).
1487: 		IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
1488: 			THIS.AbrirFormZoomImagem(loc_cArquivo, loc_cProduto, loc_cDescProduto)
1489: 
1490: 			*-- (c) ERASE sem dialogo de confirmacao
1491: 			loc_cSafety = SET("SAFETY")
1492: 			SET SAFETY OFF
1493: 
1494: 			ERASE (loc_cArquivo)
1495: 
1496: 			IF loc_cSafety = "ON"
1497: 				SET SAFETY ON
1498: 			ENDIF
1499: 		ENDIF
1500: 	ENDPROC
1501: 
1502: 	*==========================================================================
1503: 	* AbrirFormZoomImagem - "Do Form SigOpZom With lcArquivo, 'Produto : ' +
1504: 	* crTmpPro.CPros + ' - ' + crTmpPro.DPros, ''" do legado (zoom da foto do
1505: 	* produto). O 3o argumento eh string VAZIA no legado - transcrito assim.
1506: 	*
1507: 	* NAO se escreve "DO FORM" no projeto novo: os forms migrados sao
1508: 	* DEFINE CLASS em .prg e nao existe .scx nenhum em projeto\, entao o
1509: 	* DO FORM estoura "File 'sigopzom.scx' does not exist" e o dialogo NUNCA
1510: 	* abre - alem de a classe filha nao entrar no indice de carga sob demanda,
1511: 	* que o GerarIndiceClasses monta lendo CREATEOBJECT/AddObject. A forma
1512: 	* canonica eh CREATEOBJECT com o nome LITERAL da classe migrada.
1513: 	*
1514: 	* SIGOPZOM esta FORA do escopo desta task (segue em ProximasMigracoes\) -
1515: 	* mesmo padrao ja adotado em FormSigMvSbn.AbrirFormZoomImagem e
1516: 	* FormSigPrCtr: o CREATEOBJECT vai guardado e a ausencia eh AVISADA ao
1517: 	* usuario, em vez de estourar "Class definition FORMSIGOPZOM is not
1518: 	* found" ou - pior - de o duplo clique na foto nao fazer nada e ninguem
1519: 	* descobrir. Ausencia de modulo tem de ficar VISIVEL. Quando SigOpZom for
1520: 	* migrado, esta chamada passa a funcionar sem nenhuma alteracao aqui.
1521: 	*
1522: 	* Show() FORA do TRY: form modal chamado DENTRO de TRY faz qualquer erro
1523: 	* de runtime da tela filha cair no CATCH do pai, a referencia LOCAL morrer
1524: 	* e a janela filha fechar sozinha (CLAUDE.md #29).
1525: 	*==========================================================================
1526: 	PROTECTED PROCEDURE AbrirFormZoomImagem(par_cArquivo, par_cProduto, par_cDescProduto)
1527: 		LOCAL loc_oForm, loc_cTitulo, loc_oErro
1528: 
1529: 		loc_cTitulo = "Produto : " + ALLTRIM(par_cProduto) + " - " + ALLTRIM(par_cDescProduto)
1530: 
1531: 		TRY
1532: 			loc_oForm = CREATEOBJECT("FormSigOpZom", par_cArquivo, loc_cTitulo, "")
1533: 		CATCH TO loc_oErro
1534: 			loc_oForm = .NULL.
1535: 		ENDTRY
1536: 
1537: 		IF VARTYPE(loc_oForm) = "O"
1538: 			loc_oForm.Show()
1539: 		ELSE
1540: 			MsgAviso("M" + CHR(243) + "dulo de Zoom de Imagem (SigOpZom) ainda n" + ;
1541: 					CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + "vel nesta " + ;
1542: 					"vers" + CHR(227) + "o.", "Aviso")
1543: 		ENDIF
1544: 	ENDPROC
1545: 
1546: 	*==========================================================================
1547: 	* ArvoreDisponivel - O obj_4c_TreeView so existe se o AddObject com o
1548: 	* ActiveX ctTree.ocx tiver dado certo em ConfigurarControles (o OCX pode
1549: 	* nao estar registrado na estacao, e em modo teste/validacao de UI ele nem
1550: 	* eh tentado). Sem esta guarda, TODA chamada a API de nos derrubaria o
1551: 	* metodo com "Unknown member OBJ_4C_TREEVIEW". Mesmo padrao de
1552: 	* FormSIGMVMVT.ArvoreDisponivel.
1553: 	*==========================================================================
1554: 	PROTECTED FUNCTION ArvoreDisponivel()
1555: 		RETURN PEMSTATUS(THIS.cnt_4c_Container1, "obj_4c_TreeView", 5) AND ;
1556: 		       VARTYPE(THIS.cnt_4c_Container1.obj_4c_TreeView) = "O"
1557: 	ENDFUNC
1558: 
1559: 	*==========================================================================
1560: 	* PrepararArvore - Reproduz (a) os seis AddImage do Init legado e (b) o
1561: 	* bloco de inicializacao que MakeTree e MakeTreeEnv repetem identicos no
1562: 	* inicio:
1563: 	*   loTree1.ClearNodes / TipsDisplay = .t. / ExpandOnDClick /
1564: 	*   SmallIcons = .t. / PicAlign = 0 / SelectedStyle = 2 / PictureType = 1
1565: 	*
1566: 	* As imagens entram UMA UNICA vez (this_lImagensArvore), como no Init
1567: 	* legado: AddImage empilha indices novos a cada chamada e os indices
1568: 	* 1..6 usados pelo AddPictureNode sao FIXOS no codigo do legado -
1569: 	* recarregar a cada pesquisa trocaria os icones de todos os nos (mesma
1570: 	* razao do flag em FormSIGMVMVT.PrepararArvore).
1571: 	*
1572: 	* Caminhos transcritos do Init legado, na MESMA ordem (eh a ordem que
1573: 	* define o indice). Cada linha do legado traz, COMENTADA ao lado, a versao
1574: 	* ANTERIOR do mesmo icone - que eh o alternativo usado aqui (ver abaixo):
1575: 	*   1 \imagens\geral_documento_26.jpg  (&&\vbmp\Form4.Ico)     raiz O.P.
1576: 	*   2 \imagens\geral_caixa_16.jpg      (&&\vbmp\depend3.bmp)   movim./material/medida
1577: 	*   3 \imagens\geral_pendencia_26.jpg  (&&\vbmp\OHist.Ico)     (reservado pelo legado)
1578: 	*   4 \imagens\geral_palete_26.jpg     (&&\vbmp\Replace.Ico)   material de SERVICO
1579: 	*   5 \vbmp\EnvMail.Bmp                (sem alternativo)       raiz Envelope
1580: 	*   6 \imagens\geral_subnivel_26.jpg   (&&\vbmp\Server15.Ico)  Origem/Destino

*-- Linhas 1600 a 1706:
1600: 	* ou sem: o que nao pode repetir eh o AddImage, que empilha indice novo e
1601: 	* deslocaria os indices fixos 1..6 do AddPictureNode.
1602: 	*==========================================================================
1603: 	PROTECTED PROCEDURE PrepararArvore()
1604: 		LOCAL loc_oErro
1605: 
1606: 		IF THIS.ArvoreDisponivel()
1607: 			IF !THIS.this_lImagensArvore
1608: 				THIS.CarregarImagemArvore("imagens\geral_documento_26.jpg", "Form4.Ico")
1609: 				THIS.CarregarImagemArvore("imagens\geral_caixa_16.jpg", "depend3.bmp")
1610: 				THIS.CarregarImagemArvore("imagens\geral_pendencia_26.jpg", "OHist.Ico")
1611: 				THIS.CarregarImagemArvore("imagens\geral_palete_26.jpg", "Replace.Ico")
1612: 				THIS.CarregarImagemArvore("", "EnvMail.Bmp")
1613: 				THIS.CarregarImagemArvore("imagens\geral_subnivel_26.jpg", "Server15.Ico")
1614: 
1615: 				THIS.this_lImagensArvore = .T.
1616: 			ENDIF
1617: 
1618: 			TRY
1619: 				WITH THIS.cnt_4c_Container1.obj_4c_TreeView
1620: 					.ClearNodes
1621: 					.TipsDisplay   = .T.
1622: 					.ExpandOnDClick
1623: 					.SmallIcons    = .T.
1624: 					.PicAlign      = 0
1625: 					.SelectedStyle = 2
1626: 					.PictureType   = 1
1627: 				ENDWITH
1628: 			CATCH TO loc_oErro
1629: 				MsgErro("Falha ao preparar a " + CHR(225) + "rvore: " + ;
1630: 						loc_oErro.Message + CHR(13) + ;
1631: 						"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1632: 						"Procedure: " + loc_oErro.Procedure, "Erro")
1633: 			ENDTRY
1634: 		ENDIF
1635: 	ENDPROC
1636: 
1637: 	*==========================================================================
1638: 	* CarregarImagemArvore - UM AddImage do Init legado. Tenta primeiro o
1639: 	* arquivo da linha ATIVA do legado (par_cRelativoFramework, dentro de
1640: 	* gc_4c_CaminhoFramework) e, falhando, o arquivo que o legado nomeia no
1641: 	* COMENTARIO da mesma linha (par_cAlternativoVbmp, dentro de
1642: 	* gc_4c_CaminhoIcones) - ver a medicao de LOADPICTURE x JPEG no cabecalho
1643: 	* de PrepararArvore.
1644: 	*
1645: 	* par_cRelativoFramework vazio significa que a linha do legado JA aponta
1646: 	* direto para \vbmp\ (caso do EnvMail.Bmp, indice 5).
1647: 	*
1648: 	* TRY por IMAGEM: uma falha nao pode impedir as outras cinco de entrar,
1649: 	* senao os indices 1..6 ficam deslocados. O AddImage eh chamado SEMPRE,
1650: 	* inclusive com a imagem nula, exatamente para o indice nao escorregar -
1651: 	* indice sem figura desenha no sem icone, o que eh degradacao visivel;
1652: 	* indice deslocado poria o icone ERRADO em todos os nos.
1653: 	*
1654: 	* NENHUM CATCH eh silencioso (CLAUDE.md #9): a falha do caminho PRINCIPAL
1655: 	* eh esperada e medida (LOADPICTURE x JPEG), entao ela so acumula a
1656: 	* mensagem; o erro so eh EXIBIDO quando o alternativo tambem falha - isto
1657: 	* eh, quando a imagem realmente nao entrou. Reportar a cada tentativa
1658: 	* produziria cinco dialogos por pesquisa.
1659: 	*==========================================================================
1660: 	PROTECTED PROCEDURE CarregarImagemArvore(par_cRelativoFramework, par_cAlternativoVbmp)
1661: 		LOCAL loc_oImagem, loc_oErro, loc_cPrincipal, loc_cAlternativo, loc_cFalhas
1662: 
1663: 		loc_oImagem      = .NULL.
1664: 		loc_cFalhas      = ""
1665: 		loc_cPrincipal   = IIF(EMPTY(par_cRelativoFramework), "", ;
1666: 							   gc_4c_CaminhoFramework + par_cRelativoFramework)
1667: 		loc_cAlternativo = IIF(EMPTY(par_cAlternativoVbmp), "", ;
1668: 							   gc_4c_CaminhoIcones + par_cAlternativoVbmp)
1669: 
1670: 		IF !EMPTY(loc_cPrincipal)
1671: 			TRY
1672: 				loc_oImagem = LOADPICTURE(loc_cPrincipal)
1673: 			CATCH TO loc_oErro
1674: 				loc_oImagem = .NULL.
1675: 				loc_cFalhas = loc_cFalhas + loc_cPrincipal + ": " + ;
1676: 					loc_oErro.Message + CHR(13)
1677: 			ENDTRY
1678: 		ENDIF
1679: 
1680: 		IF VARTYPE(loc_oImagem) != "O" AND !EMPTY(loc_cAlternativo)
1681: 			TRY
1682: 				loc_oImagem = LOADPICTURE(loc_cAlternativo)
1683: 			CATCH TO loc_oErro
1684: 				loc_oImagem = .NULL.
1685: 				loc_cFalhas = loc_cFalhas + loc_cAlternativo + ": " + ;
1686: 					loc_oErro.Message + CHR(13)
1687: 			ENDTRY
1688: 		ENDIF
1689: 
1690: 		TRY
1691: 			THIS.cnt_4c_Container1.obj_4c_TreeView.AddImage(loc_oImagem)
1692: 		CATCH TO loc_oErro
1693: 			loc_cFalhas = loc_cFalhas + "AddImage: " + loc_oErro.Message + CHR(13)
1694: 		ENDTRY
1695: 
1696: 		*-- Imagem obtida eh o caso normal (o alternativo do legado carrega) -
1697: 		*-- so avisa quando NENHUM dos dois caminhos entregou a figura.
1698: 		IF VARTYPE(loc_oImagem) != "O" AND !EMPTY(loc_cFalhas)
1699: 			MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar um " + ;
1700: 					"dos " + CHR(237) + "cones da " + CHR(225) + "rvore:" + CHR(13) + ;
1701: 					loc_cFalhas, "Erro")
1702: 		ENDIF
1703: 	ENDPROC
1704: 
1705: 	*==========================================================================
1706: 	* CarregarDados - METODO DE CARGA desta tela. Aqui a superficie de lista

*-- Linhas 1727 a 1913:
1727: 	* CRU do VFP no lugar do dialogo do sistema. RETURN unico, DEPOIS do
1728: 	* ENDTRY (CLAUDE.md #1).
1729: 	*==========================================================================
1730: 	PROCEDURE CarregarDados()
1731: 		LOCAL loc_lSucesso, loc_nOP, loc_nEnvelope, loc_lPorEnvelope
1732: 		LOCAL loc_lAchou, loc_oErro, loc_cMensagem
1733: 
1734: 		loc_lSucesso = .F.
1735: 
1736: 		IF VARTYPE(THIS.this_oBusinessObject) != "O"
1737: 			MsgErro("Business Object indispon" + CHR(237) + "vel - n" + CHR(227) + ;
1738: 					"o foi poss" + CHR(237) + "vel consultar.", "Erro")
1739: 		ELSE
1740: 			loc_nOP       = THIS.cnt_4c_Container1.txt_4c_OP.Value
1741: 			loc_nEnvelope = THIS.cnt_4c_Container1.txt_4c_Envelope.Value
1742: 
1743: 			loc_nOP       = IIF(VARTYPE(loc_nOP) = "N", loc_nOP, 0)
1744: 			loc_nEnvelope = IIF(VARTYPE(loc_nEnvelope) = "N", loc_nEnvelope, 0)
1745: 
1746: 			*-- "If ! Empty(This.Value)" dos dois Valid legado: campo em
1747: 			*-- branco nao dispara consulta nenhuma (e nao avisa).
1748: 			IF loc_nOP != 0 OR loc_nEnvelope != 0
1749: 				loc_lPorEnvelope = (loc_nOP = 0)
1750: 
1751: 				TRY
1752: 					IF loc_lPorEnvelope
1753: 						loc_lAchou = THIS.this_oBusinessObject.PesquisarPorEnvelope(loc_nEnvelope)
1754: 					ELSE
1755: 						loc_lAchou = THIS.this_oBusinessObject.PesquisarPorOP(loc_nOP)
1756: 					ENDIF
1757: 
1758: 					IF loc_lAchou
1759: 						*-- Bloco da figura do produto do GetOP.Valid legado -
1760: 						*-- so existe no caminho da O.P. (o Valid do
1761: 						*-- GetEnvelope nao toca na Imagem).
1762: 						IF !loc_lPorEnvelope
1763: 							THIS.ExibirImagemProduto()
1764: 						ENDIF
1765: 
1766: 						THIS.PopularArvore(loc_lPorEnvelope)
1767: 						loc_lSucesso = .T.
1768: 					ELSE
1769: 						*-- MessageBox do legado: "Envelope Nao Localizado !!!"
1770: 						*-- e "O.P. Nao Localizada !!!". Mensagem de validacao
1771: 						*-- usa MsgAviso (nao MsgErro).
1772: 						loc_cMensagem = ALLTRIM(THIS.this_oBusinessObject.this_cMensagemErro)
1773: 
1774: 						IF EMPTY(loc_cMensagem)
1775: 							loc_cMensagem = IIF(loc_lPorEnvelope, ;
1776: 								"Envelope N" + CHR(227) + "o Localizado !!!", ;
1777: 								"O.P. N" + CHR(227) + "o Localizada !!!")
1778: 						ENDIF
1779: 
1780: 						MsgAviso(loc_cMensagem, "Aten" + CHR(231) + CHR(227) + "o")
1781: 					ENDIF
1782: 				CATCH TO loc_oErro
1783: 					MsgErro("Falha ao consultar as movimenta" + CHR(231) + CHR(245) + "es: " + ;
1784: 							loc_oErro.Message + CHR(13) + ;
1785: 							"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1786: 							"Procedure: " + loc_oErro.Procedure, "Erro")
1787: 				ENDTRY
1788: 			ENDIF
1789: 		ENDIF
1790: 
1791: 		RETURN loc_lSucesso
1792: 	ENDPROC
1793: 
1794: 	*==========================================================================
1795: 	* ExibirImagemProduto - Bloco da figura do produto do GetOP.Valid legado:
1796: 	*   Thisform.Arqfigura = lcArquivo
1797: 	*   Clear Resources
1798: 	*   ThisForm.Imagem.Picture = [] / ThisForm.Imagem.Visible = .f.
1799: 	*   If Not Empty(crTmpPro.FigJpgs) And Not IsNull(crTmpPro.FigJpgs)
1800: 	*       If (StrToFile(crTmpPro.FigJpgs, lcArquivo) > 0)
1801: 	*           ThisForm.Imagem.Picture = (lcArquivo) / .Visible = .t.
1802: 	*
1803: 	* O StrToFile (e a consulta a SigCdPro) ja rodaram em
1804: 	* SIGOPNOPBO.BuscarImagemProduto, que deixa o caminho do .jpg temporario
1805: 	* em this_cArquivoImagem APENAS quando a extracao deu certo - por isso o
1806: 	* teste aqui equivale ao "StrToFile(...) > 0" do legado.
1807: 	*
1808: 	* CLEAR RESOURCES eh transcricao literal, nao defesa inventada: sem ele o
1809: 	* VFP9 mantem o .jpg ANTERIOR em cache e a tela continua exibindo a figura
1810: 	* do produto da pesquisa passada.
1811: 	*==========================================================================
1812: 	PROTECTED PROCEDURE ExibirImagemProduto()
1813: 		LOCAL loc_cArquivo
1814: 
1815: 		loc_cArquivo = ALLTRIM(THIS.this_oBusinessObject.this_cArquivoImagem)
1816: 
1817: 		*-- ThisForm.Arqfigura = lcArquivo - apagado ao Encerrar ("Delete File
1818: 		*-- (ThisForm.Arqfigura)" no Click do Commandgroup1, Fase 7).
1819: 		THIS.this_cArquivoFigura = loc_cArquivo
1820: 
1821: 		CLEAR RESOURCES
1822: 
1823: 		THIS.img_4c_Imagem.Picture = ""
1824: 		THIS.img_4c_Imagem.Visible = .F.
1825: 
1826: 		IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
1827: 			THIS.img_4c_Imagem.Picture = loc_cArquivo
1828: 			THIS.img_4c_Imagem.Visible = .T.
1829: 		ENDIF
1830: 	ENDPROC
1831: 
1832: 	*==========================================================================
1833: 	* PopularArvore - Desenha os nos a partir do cursor que o BO acabou de
1834: 	* montar (this_cCursorArvore = o CrSigCdNei do legado). Transcricao dos
1835: 	* PROCEDURE maketree (par_lPorEnvelope = .F.) e maketreeenv
1836: 	* (par_lPorEnvelope = .T.), que sao o MESMO algoritmo com cinco textos/
1837: 	* icones diferentes - cada diferenca esta anotada abaixo e foi transcrita
1838: 	* LITERALMENTE, nao reescrita (CLAUDE.md #17).
1839: 	*
1840: 	* Hierarquia (nivel, icone):
1841: 	*   1 raiz             O.P. (icone 1) | Envelope (icone 5)
1842: 	*   2 movimentacao     icone 2 no maketree | icone 1 no maketreeenv
1843: 	*   3 Origem/Destino   icone 6 nos dois
1844: 	*   4 material         icone 4 se servico, 2 se material (nos dois)
1845: 	*   5 qtde / peso2 / peso   icone 2 nos tres
1846: 	*
1847: 	* Separado de CarregarDados para que a CONSULTA continue valendo quando o
1848: 	* ActiveX da arvore nao esta disponivel na estacao (mesma divisao de
1849: 	* FormSIGMVMVT.CarregarDados/PopularArvore).
1850: 	*
1851: 	* "Set Decimals To 3" do legado eh reproduzido em volta do laco (os
1852: 	* Transform de 3 decimais dependem dele) e restaurado DEPOIS do ENDTRY,
1853: 	* para valer tambem quando o CATCH dispara. SET("Decimals") devolve
1854: 	* NUMERICO - NUNCA envolver com VAL() (Pattern #152).
1855: 	*==========================================================================
1856: 	PROTECTED PROCEDURE PopularArvore(par_lPorEnvelope)
1857: 		LOCAL loc_lPorEnvelope, loc_cCursor, loc_oErro, loc_nDecimais
1858: 		LOCAL loc_nNo, loc_cTexto, loc_nIcone, loc_lServicos
1859: 		LOCAL loc_cChave, loc_cEmpDnPsAnt, loc_cOriDes, loc_cOriDesAnt
1860: 
1861: 		loc_lPorEnvelope = IIF(VARTYPE(par_lPorEnvelope) = "L", par_lPorEnvelope, .F.)
1862: 		loc_cCursor      = THIS.this_oBusinessObject.this_cCursorArvore
1863: 
1864: 		IF !USED(loc_cCursor) OR !THIS.ArvoreDisponivel()
1865: 			RETURN
1866: 		ENDIF
1867: 
1868: 		*-- "ThisForm.Container2.Visible = .t." - primeira linha dos dois
1869: 		*-- metodos legado: acende o painel "AGUARDE! / Pesquisando as
1870: 		*-- Movimentacoes" enquanto a arvore eh desenhada.
1871: 		THIS.cnt_4c_Container2.Visible = .T.
1872: 
1873: 		THIS.PrepararArvore()
1874: 
1875: 		loc_nDecimais = SET("Decimals")
1876: 		SET DECIMALS TO 3
1877: 
1878: 		TRY
1879: 			SELECT (loc_cCursor)
1880: 			GO TOP
1881: 
1882: 			*-- ===== Nivel 1 - no raiz =====
1883: 			*-- maketree:    [O.P. : ] + Str(nEnvs) + [ - ] + Cpros +
1884: 			*--              Iif(nOpMaes > 0, [ - O.P. Mae: ] + Str(nOpMaes), [ ])
1885: 			*-- maketreeenv: [Envelope : ] + Str(nEnvs)
1886: 			IF loc_lPorEnvelope
1887: 				loc_cTexto = "Envelope : " + ALLTRIM(STR(TratarNulo(Nenvs, 0)))
1888: 				loc_nIcone = 5
1889: 			ELSE
1890: 				loc_cTexto = "O.P. : " + ALLTRIM(STR(TratarNulo(Nenvs, 0))) + " - " + ;
1891: 					TratarNulo(Cpros, "") + ;
1892: 					IIF(TratarNulo(NopMaes, 0) > 0, ;
1893: 						" - O.P. M" + CHR(227) + "e: " + ALLTRIM(STR(TratarNulo(NopMaes, 0))), ;
1894: 						" ")
1895: 				loc_nIcone = 1
1896: 			ENDIF
1897: 
1898: 			WITH THIS.cnt_4c_Container1.obj_4c_TreeView
1899: 				loc_nNo = .AddPictureNode(loc_cTexto, 0, 1, loc_nIcone, 0, 0)
1900: 				.NodeHeader(loc_nNo)     = .T.
1901: 				.NodeExpanded(loc_nNo)   = .T.
1902: 				.NodeShowChecks(loc_nNo) = .F.
1903: 				.NodeFontBold(loc_nNo)   = 2
1904: 			ENDWITH
1905: 
1906: 			loc_cEmpDnPsAnt = ""
1907: 			loc_cOriDesAnt  = ""
1908: 
1909: 			SCAN
1910: 				*-- Servicos eh coluna bit no SQL Server e o SELECT do BO a
1911: 				*-- traz como CAST(... AS INT): chega NUMERICA ao cursor,
1912: 				*-- entao a comparacao tem de ser explicita (IIF exige logico
1913: 				*-- no 1o argumento - numerico estoura erro 11).

*-- Linhas 1937 a 1957:
1937: 						ALLTRIM(SUBSTR(loc_cChave, 4, 20)) + "/" + ;
1938: 						ALLTRIM(RIGHT(loc_cChave, 6)) + " - " + ;
1939: 						DTOC(ConverterParaData(Datas)) + " - " + ;
1940: 						TRANSFORM(TratarNulo(TotPesos, 0), "@Z 999,999.999") + " Gr"
1941: 
1942: 					WITH THIS.cnt_4c_Container1.obj_4c_TreeView
1943: 						loc_nNo = .AddPictureNode(loc_cTexto, 0, 2, ;
1944: 							IIF(loc_lPorEnvelope, 1, 2), 0, 0)
1945: 						.NodeHeader(loc_nNo)     = .F.
1946: 						.NodeExpanded(loc_nNo)   = .F.
1947: 						.NodeShowChecks(loc_nNo) = .F.
1948: 						.NodeFontBold(loc_nNo)   = 1
1949: 					ENDWITH
1950: 
1951: 					loc_cEmpDnPsAnt = loc_cChave
1952: 
1953: 					*-- Origem/Destino logo abaixo da movimentacao nova
1954: 					THIS.AdicionarNoOrigemDestino()
1955: 					loc_cOriDesAnt = loc_cOriDes
1956: 
1957: 					IF USED(loc_cCursor)

*-- Linhas 1979 a 1999:
1979: 							ALLTRIM(STR(TratarNulo(Nops, 0))) + " - "), ;
1980: 						"") + ;
1981: 					ALLTRIM(TratarNulo(Cmats, "")) + " - " + ;
1982: 					ALLTRIM(TratarNulo(Dpros, ""))
1983: 
1984: 				WITH THIS.cnt_4c_Container1.obj_4c_TreeView
1985: 					loc_nNo = .AddPictureNode(loc_cTexto, 0, 4, ;
1986: 						IIF(loc_lServicos, 4, 2), 0, 0)
1987: 					.NodeHeader(loc_nNo)     = .F.
1988: 					.NodeExpanded(loc_nNo)   = .F.
1989: 					.NodeShowChecks(loc_nNo) = .F.
1990: 					.NodeFontBold(loc_nNo)   = IIF(loc_lServicos, 2, 1)
1991: 				ENDWITH
1992: 
1993: 				*-- ===== Nivel 5 - quantidade =====
1994: 				*-- maketree:    Alltrim(Transform(Qtds,[999,999.999])) + [ ] +
1995: 				*--              Iif(qtds = 0, [], cUnis)
1996: 				*-- maketreeenv: Alltrim(Transform(Qtds,[999,999.999])) + [ ] + cUnis
1997: 				loc_cTexto = ALLTRIM(TRANSFORM(TratarNulo(Qtds, 0), "999,999.999")) + " " + ;
1998: 					IIF(loc_lPorEnvelope, ;
1999: 						TratarNulo(Cunis, ""), ;

*-- Linhas 2031 a 2160:
2031: 
2032: 				THIS.AdicionarNoMedida(loc_cTexto)
2033: 			ENDSCAN
2034: 
2035: 			*-- "loTree1.ReDraw(.t.) / loTree1.Refresh" do fim dos dois metodos
2036: 			WITH THIS.cnt_4c_Container1.obj_4c_TreeView
2037: 				.ReDraw(.T.)
2038: 				.Refresh()
2039: 			ENDWITH
2040: 
2041: 			*-- "ThisForm.pnNodeExp = 1" - nivel corrente de expansao, lido
2042: 			*-- pelos botoes Expandir/Regredir (Fwbtng1/Fwbtng2, Fase 7).
2043: 			THIS.this_nNodeExp = 1
2044: 		CATCH TO loc_oErro
2045: 			MsgErro("Falha ao montar a " + CHR(225) + "rvore: " + ;
2046: 					loc_oErro.Message + CHR(13) + ;
2047: 					"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2048: 					"Procedure: " + loc_oErro.Procedure, "Erro")
2049: 		ENDTRY
2050: 
2051: 		*-- Restauracao dos decimais e apagamento do painel ficam FORA do TRY,
2052: 		*-- para valerem tambem quando o CATCH dispara.
2053: 		SET DECIMALS TO loc_nDecimais
2054: 
2055: 		*-- "ThisForm.Container2.Visible = .F." do fim dos dois metodos
2056: 		THIS.cnt_4c_Container2.Visible = .F.
2057: 	ENDPROC
2058: 
2059: 	*==========================================================================
2060: 	* AdicionarNoOrigemDestino - No de nivel 3, icone 6. O legado repete este
2061: 	* bloco IDENTICO em dois pontos de cada metodo (quebra de movimentacao e
2062: 	* quebra de Origem/Destino dentro da mesma movimentacao), e identico entre
2063: 	* maketree e maketreeenv:
2064: 	*   [Origem : ] + Alltrim(GrupoOS) + [/] + Alltrim(ContaOS) + [ - ] +
2065: 	*   [Destino : ] + Alltrim(GrupoDS) + [/] + Alltrim(ContaDS)
2066: 	*
2067: 	* Le o registro CORRENTE do cursor da arvore, como o legado faz dentro do
2068: 	* Scan. Campo alcancado por NOME -> EVALUATE para LEITURA (CLAUDE.md #15).
2069: 	*==========================================================================
2070: 	PROTECTED PROCEDURE AdicionarNoOrigemDestino()
2071: 		LOCAL loc_cTexto, loc_nNo, loc_cCursor
2072: 
2073: 		loc_cCursor = THIS.this_oBusinessObject.this_cCursorArvore
2074: 
2075: 		IF !USED(loc_cCursor) OR !THIS.ArvoreDisponivel()
2076: 			RETURN
2077: 		ENDIF
2078: 
2079: 		loc_cTexto = "Origem : " + ;
2080: 			ALLTRIM(TratarNulo(EVALUATE(loc_cCursor + ".Grupoos"), "")) + "/" + ;
2081: 			ALLTRIM(TratarNulo(EVALUATE(loc_cCursor + ".Contaos"), "")) + " - " + ;
2082: 			"Destino : " + ;
2083: 			ALLTRIM(TratarNulo(EVALUATE(loc_cCursor + ".Grupods"), "")) + "/" + ;
2084: 			ALLTRIM(TratarNulo(EVALUATE(loc_cCursor + ".Contads"), ""))
2085: 
2086: 		WITH THIS.cnt_4c_Container1.obj_4c_TreeView
2087: 			loc_nNo = .AddPictureNode(loc_cTexto, 0, 3, 6, 0, 0)
2088: 			.NodeHeader(loc_nNo)     = .F.
2089: 			.NodeExpanded(loc_nNo)   = .F.
2090: 			.NodeShowChecks(loc_nNo) = .F.
2091: 			.NodeFontBold(loc_nNo)   = 1
2092: 		ENDWITH
2093: 	ENDPROC
2094: 
2095: 	*==========================================================================
2096: 	* AdicionarNoMedida - No de nivel 5, icone 2, com a guarda
2097: 	* "If ! Empty(lcDados)" que o legado repete nos TRES nos de medida
2098: 	* (quantidade, peso 2 e peso). O texto chega montado pelo chamador porque
2099: 	* cada um dos tres tem expressao propria - e duas delas diferem entre
2100: 	* maketree e maketreeenv.
2101: 	*==========================================================================
2102: 	PROTECTED PROCEDURE AdicionarNoMedida(par_cTexto)
2103: 		LOCAL loc_nNo
2104: 
2105: 		IF EMPTY(par_cTexto) OR !THIS.ArvoreDisponivel()
2106: 			RETURN
2107: 		ENDIF
2108: 
2109: 		WITH THIS.cnt_4c_Container1.obj_4c_TreeView
2110: 			loc_nNo = .AddPictureNode(par_cTexto, 0, 5, 2, 0, 0)
2111: 			.NodeHeader(loc_nNo)     = .F.
2112: 			.NodeExpanded(loc_nNo)   = .F.
2113: 			.NodeShowChecks(loc_nNo) = .F.
2114: 			.NodeFontBold(loc_nNo)   = 1
2115: 		ENDWITH
2116: 	ENDPROC
2117: 
2118: 	*==========================================================================
2119: 	* TornarControlesVisiveis - Torna os controles filhos visiveis apos o
2120: 	* AddObject (que os cria Visible=.F. por padrao), preservando as DUAS
2121: 	* excecoes fieis ao legado: cnt_4c_Container2 (painel "AGUARDE!" -
2122: 	* flutuante, Visible=.F. - ver ConfigurarContainers) e img_4c_Imagem
2123: 	* (sem produto pesquisado ainda, Visible=.F. no SCX). O container
2124: 	* flutuante tem os FILHOS tornados visiveis mesmo assim - pular com
2125: 	* LOOP sem recursar deixaria o painel aparecer vazio quando algum
2126: 	* metodo o acender mais adiante (Fase 7/8).
2127: 	*==========================================================================
2128: 	PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2129: 		LOCAL loc_nI, loc_oObjeto
2130: 
2131: 		FOR loc_nI = 1 TO par_oContainer.ControlCount
2132: 			loc_oObjeto = par_oContainer.Controls(loc_nI)
2133: 
2134: 			IF VARTYPE(loc_oObjeto) = "O"
2135: 				IF INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CONTAINER2", "IMG_4C_IMAGEM")
2136: 					IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
2137: 						THIS.TornarControlesVisiveis(loc_oObjeto)
2138: 					ENDIF
2139: 					LOOP
2140: 				ENDIF
2141: 
2142: 				IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2143: 					loc_oObjeto.Visible = .T.
2144: 				ENDIF
2145: 
2146: 				IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
2147: 					THIS.TornarControlesVisiveis(loc_oObjeto)
2148: 				ENDIF
2149: 			ENDIF
2150: 		ENDFOR
2151: 	ENDPROC
2152: 
2153: 	*==========================================================================
2154: 	* Destroy
2155: 	*==========================================================================
2156: 	PROCEDURE Destroy
2157: 		DODEFAULT()
2158: 	ENDPROC
2159: 
2160: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGOPNOPBO.prg):
*==============================================================================
* SIGOPNOPBO.PRG
* Business Object para FormSIGOPNOP - Analise de OP/Envelopes
*
* Form OPERACIONAL de consulta (sem tabela unica): pesquisa movimentacoes de
* producao por numero de Envelope (SigCdNei/SigCdNec) ou por numero de O.P.
* (SigCdNei/SigCdNec/SigOpPic/SigPdMvf), monta a arvore de resultado e exibe
* a figura do produto (SigCdPro.FigJpgs) extraida para arquivo temporario.
*==============================================================================

DEFINE CLASS SIGOPNOPBO AS BusinessBase

	*-- Criterios de pesquisa (espelham Container1.GetOP e Container1.GetEnvelope do legado)
	this_nNumeroOP = 0
	this_nNumeroEnvelope = 0

	*-- Cursores de resultado populados pelas pesquisas (Fase 2)
	this_cCursorArvore = "cursor_4c_Arvore"
	this_cCursorProduto = "cursor_4c_Produto"
	this_lRegistroEncontrado = .F.

	*-- Figura do produto extraida de SigCdPro.FigJpgs para arquivo temporario
	this_cArquivoImagem = ""

	*-- REGISTRO CORRENTE da arvore de resultado (THIS.this_cCursorArvore),
	*-- carregado por CarregarDoCursor(). Os nomes espelham as colunas do cursor
	*-- (que por sua vez espelham as colunas do legado lidas no Scan de
	*-- MakeTree/MakeTreeEnv sobre CrSigCdNei).
	this_cCidchaves = ""
	this_nNenvs = 0
	this_cEmpDnPs = ""
	this_dDatas = {}
	this_cGrupoos = ""
	this_cContaos = ""
	this_cGrupods = ""
	this_cContads = ""
	this_lServicos = .F.
	this_nNops = 0
	this_cCmats = ""
	this_cDpros = ""
	this_nQtds = 0
	this_cCunis = ""
	this_nPeso2s = 0
	this_cCunips = ""
	this_nPesos = 0
	this_nTotPesos = 0
	this_cCpros = ""
	this_nNopMaes = 0

	*-- Decomposicao POSICIONAL de EmpDnPs char(33) = Emps(3) + Dopps(20) +
	*-- Str(Numps, 10). O legado decompoe assim no TreeView.DblClick:
	*-- Left(NodeCargo,3) / Substr(NodeCargo,4,20) / Val(Alltrim(Substr(NodeCargo,24)))
	this_cEmps = ""
	this_cDopps = ""
	this_nNumps = 0

	*==============================================================================
	* Init - Inicializa Business Object
	*==============================================================================
	PROCEDURE Init()
		DODEFAULT()

		*-- Consulta multi-tabela (SigCdNei/SigCdNec/SigCdPro/SigOpPic/SigPdMvf):
		*-- nao existe tabela mestre unica. O registro eh identificado pela chave de
		*-- movimentacao EmpDnPs char(33), compartilhada pelas tabelas envolvidas.
		THIS.this_cTabela = ""
		THIS.this_cCampoChave = "EmpDnPs"

		THIS.this_nNumeroOP = 0
		THIS.this_nNumeroEnvelope = 0
		THIS.this_cCursorArvore = "cursor_4c_Arvore"
		THIS.this_cCursorProduto = "cursor_4c_Produto"
		THIS.this_lRegistroEncontrado = .F.
		THIS.this_cArquivoImagem = ""

		THIS.ResetarRegistroCorrente()

		RETURN .T.
	ENDPROC

	*==============================================================================
	* Inserir()/Atualizar()/ExecutarExclusao() do BusinessBase NAO sao
	* sobrescritos aqui: este form eh de CONSULTA (pesquisa movimentacoes de
	* producao por Envelope ou O.P. em SigCdNei/SigCdNec/SigCdPro/SigOpPic/
	* SigPdMvf), sem INSERT/UPDATE/DELETE no legado - o unico efeito colateral
	* eh a extracao da figura do produto para um arquivo temporario (apagado ao
	* Encerrar). O comportamento padrao herdado de BusinessBase para
	* Inserir/Atualizar/ExecutarExclusao/RegistrarAuditoria ja eh o correto para
	* este BO.
	*
	* Conferido no dump legado (SIGOPNOP_form_codigo_fonte.txt): ZERO ocorrencia
	* de TABLEUPDATE(, ZERO de .AddCursor( e ZERO alvo de Insert Into / Update /
	* Delete From. O unico Delete do legado eh "Delete File (ThisForm.Arqfigura)",
	* que apaga o arquivo temporario da figura e nao toca no banco - reproduzido
	* aqui em ExcluirImagemTemporaria(). Inventar um INSERT/UPDATE para este BO
	* exigiria adivinhar a lista de colunas, o que a regra #22 do CLAUDE.md
	* proibe (a lista vem do schema, nunca de adivinhacao).
	*
	* ObterChavePrimaria() SIM eh sobrescrito, porque a identidade do registro
	* corrente (EmpDnPs) nao eh derivavel de this_cTabela/this_cCampoChave.
	*==============================================================================

	*==============================================================================
	* PesquisarPorEnvelope - Pesquisa movimentacoes de producao por numero de
	* Envelope. Equivale ao PROCEDURE Valid de Container1.GetEnvelope no legado
	* (SigCdNei/SigCdNec/SigCdPro), que monta o cursor CrSigCdNei consumido pela
	* arvore (ThisForm.MakeTreeEnv no legado).
	*==============================================================================
	PROCEDURE PesquisarPorEnvelope(par_nNumeroEnvelope)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

		THIS.this_cMensagemErro = ""
		THIS.this_lRegistroEncontrado = .F.
		THIS.this_cArquivoImagem = ""
		loc_lSucesso = .F.

		IF VARTYPE(par_nNumeroEnvelope) != "N" OR par_nNumeroEnvelope = 0
			RETURN .F.
		ENDIF

		THIS.this_nNumeroEnvelope = par_nNumeroEnvelope

		loc_cSQL = "SELECT b.Cidchaves, a.Nenvs, a.EmpDnPs, b.Datas, b.Grupoos, b.Contaos, " + ;
			"b.Grupods, b.Contads, CAST(a.Servicos AS INT) AS Servicos, a.Nops, a.Cmats, c.Dpros, a.Qtds, c.Cunis, " + ;
			"a.Peso2s, c.Cunips, a.Pesos, SPACE(14) AS Cpros, 0 AS NopMaes " + ;
			"FROM SigCdNei a, SigCdNec b, SigCdPro c " + ;
			"WHERE a.Nenvs = " + FormatarNumeroSQL(par_nNumeroEnvelope, 0) + ;
			" AND a.EmpDnPs = b.EmpDnPs AND a.Cmats = c.Cpros " + ;
			"ORDER BY b.Cidchaves, a.Nops, a.Cmats"

		IF USED("cursor_4c_Nensi")
			USE IN cursor_4c_Nensi
		ENDIF

		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Nensi")

		IF loc_nResultado < 1
			THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + CapturarErroSQL()
			RETURN .F.
		ENDIF

		SELECT cursor_4c_Nensi
		GO TOP

		IF EOF("cursor_4c_Nensi")
			THIS.this_cMensagemErro = "Envelope N" + CHR(227) + "o Localizado !!!"
			USE IN cursor_4c_Nensi
			RETURN .F.
		ENDIF

		loc_lSucesso = THIS.MontarCursorArvore("cursor_4c_Nensi")

		IF USED("cursor_4c_Nensi")
			USE IN cursor_4c_Nensi
		ENDIF

		THIS.this_lRegistroEncontrado = loc_lSucesso

		RETURN loc_lSucesso
	ENDPROC

	*==============================================================================
	* PesquisarPorOP - Pesquisa movimentacoes de producao por numero de O.P.
	* Equivale ao PROCEDURE Valid de Container1.GetOP no legado: primeiro tenta a
	* consulta de movimentacao normal (SigCdNei/SigCdNec/SigCdPro/SigOpPic, nos
	* dois sentidos - O.P. propria e O.P. filha de um Envelope); se nao encontrar
	* nada, cai no fallback de O.P. ainda sem movimentacao gerada (SigPdMvf/
	* SigCdNec). Em qualquer dos dois casos, busca a figura do produto em
	* SigCdPro e extrai para arquivo temporario (THIS.this_cArquivoImagem).
	*==============================================================================
	PROCEDURE PesquisarPorOP(par_nNumeroOP)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cProduto

		THIS.this_cMensagemErro = ""
		THIS.this_lRegistroEncontrado = .F.
		THIS.this_cArquivoImagem = ""
		loc_lSucesso = .F.

		IF VARTYPE(par_nNumeroOP) != "N" OR par_nNumeroOP = 0
			RETURN .F.
		ENDIF

		THIS.this_nNumeroOP = par_nNumeroOP

		loc_cSQL = "SELECT DISTINCT b.Cidchaves, a.Nops AS Nenvs, a.EmpDnPs, b.Datas, " + ;
			"b.Grupoos, b.Contaos, b.Grupods, b.Contads, CAST(a.Servicos AS INT) AS Servicos, 0 AS Nops, " + ;
			"a.Cmats, c.Dpros, a.Qtds, c.Cunis, a.Peso2s, c.Cunips, a.Pesos, d.Cpros, d.NopMaes " + ;
			"FROM SigCdNei a, SigCdNec b, SigCdPro c, SigOpPic d " + ;
			"WHERE a.Nops = " + FormatarNumeroSQL(par_nNumeroOP, 0) + ;
			" AND a.EmpDnPs = b.EmpDnPs AND a.Cmats = c.Cpros AND a.Nops = d.Nops " + ;
			"UNION ALL " + ;
			"SELECT DISTINCT b.Cidchaves, a.Nenvs, a.EmpDnPs, b.Datas, " + ;
			"b.Grupoos, b.Contaos, b.Grupods, b.Contads, CAST(a.Servicos AS INT) AS Servicos, 0 AS Nops, " + ;
			"a.Cmats, c.Dpros, a.Qtds, c.Cunis, a.Peso2s, c.Cunips, a.Pesos, d.Cpros, d.NopMaes " + ;
			"FROM SigCdNei a, SigCdNec b, SigCdPro c, SigOpPic d " + ;
			"WHERE a.Nenvs = " + FormatarNumeroSQL(par_nNumeroOP, 0) + ;
			" AND a.Nops <> " + FormatarNumeroSQL(par_nNumeroOP, 0) + ;
			" AND a.EmpDnPs = b.EmpDnPs AND a.Cmats = c.Cpros AND a.Nenvs = d.Nops " + ;
			"ORDER BY b.Cidchaves, a.Nops, a.Cmats"

		IF USED("cursor_4c_Nensi")
			USE IN cursor_4c_Nensi
		ENDIF

		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Nensi")

		IF loc_nResultado < 1
			THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + CapturarErroSQL()
			RETURN .F.
		ENDIF

		SELECT cursor_4c_Nensi
		GO TOP

		IF EOF("cursor_4c_Nensi")
			*-- O.P. ainda sem movimentacao gerada - cai no fallback de SigPdMvf,
			*-- igual ao legado ("Nenhum" material agregado, pesos/qtds zerados)
			IF USED("cursor_4c_Nensi")
				USE IN cursor_4c_Nensi
			ENDIF

			loc_cSQL = "SELECT b.Cidchaves, a.Nops AS Nenvs, a.EmpDnPs, b.Datas, " + ;
				"b.Grupoos, b.Contaos, b.Grupods, b.Contads, 0 AS Servicos, " + ;
				"0 AS Nops, 'Nenhum        ' AS Cmats, " + ;
				"'Nenhum Material Agregado' AS Dpros, 0 AS Qtds, '   ' AS Cunis, " + ;
				"0 AS Peso2s, '   ' AS Cunips, 0 AS Pesos, a.CodPds AS Cpros, 0 AS NopMaes " + ;
				"FROM SigPdMvf a, SigCdNec b " + ;
				"WHERE a.Nops = " + FormatarNumeroSQL(par_nNumeroOP, 0) + ;
				" AND a.EmpDnPs = b.EmpDnPs " + ;
				"ORDER BY b.Cidchaves, a.Nops"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Nensi")

			IF loc_nResultado < 1
				THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + CapturarErroSQL()
				RETURN .F.
			ENDIF

			SELECT cursor_4c_Nensi
			GO TOP

			IF EOF("cursor_4c_Nensi")
				THIS.this_cMensagemErro = "O.P. N" + CHR(227) + "o Localizada !!!"
				USE IN cursor_4c_Nensi
				RETURN .F.
			ENDIF
		ENDIF

		loc_cProduto = ALLTRIM(cursor_4c_Nensi.Cpros)

		IF !THIS.BuscarImagemProduto(loc_cProduto)
			IF USED("cursor_4c_Nensi")
				USE IN cursor_4c_Nensi
			ENDIF
			RETURN .F.
		ENDIF

		loc_lSucesso = THIS.MontarCursorArvore("cursor_4c_Nensi")

		IF USED("cursor_4c_Nensi")
			USE IN cursor_4c_Nensi
		ENDIF

		THIS.this_lRegistroEncontrado = loc_lSucesso

		RETURN loc_lSucesso
	ENDPROC

	*==============================================================================
	* MontarCursorArvore - Agrupa os pesos por movimentacao (EmpDnPs, excluindo
	* linhas de servico) e junta o total (TotPesos) a cada linha do cursor de
	* origem, gravando o resultado em THIS.this_cCursorArvore. Equivale ao bloco
	* final repetido no Valid de GetEnvelope e de GetOP do legado (Select ...
	* Sum(Pesos) ... Group by 1 + Select a.*, b.TotPesos ... Into Cursor
	* CrSigCdNei Order by CidChaves, Nops, Cmats).
	*==============================================================================
	PROTECTED PROCEDURE MontarCursorArvore(par_cCursorOrigem)
		LOCAL loc_cCursorTotais

		loc_cCursorTotais = "cursor_4c_Totais"

		IF !USED(par_cCursorOrigem)
			RETURN .F.
		ENDIF

		IF USED(loc_cCursorTotais)
			USE IN (loc_cCursorTotais)
		ENDIF

		SELECT EmpDnPs, SUM(Pesos) AS TotPesos FROM (par_cCursorOrigem) WHERE Servicos = 0 ;
			INTO CURSOR (loc_cCursorTotais) GROUP BY 1

		IF USED(THIS.this_cCursorArvore)
			USE IN (THIS.this_cCursorArvore)
		ENDIF

		SELECT a.*, b.TotPesos FROM (par_cCursorOrigem) a, (loc_cCursorTotais) b ;
			WHERE a.EmpDnPs = b.EmpDnPs ;
			INTO CURSOR (THIS.this_cCursorArvore) READWRITE ;
			ORDER BY a.CidChaves, a.Nops, a.Cmats

		IF USED(loc_cCursorTotais)
			USE IN (loc_cCursorTotais)
		ENDIF

		RETURN USED(THIS.this_cCursorArvore) AND RECCOUNT(THIS.this_cCursorArvore) > 0
	ENDPROC

	*==============================================================================
	* BuscarImagemProduto - Localiza o produto em SigCdPro e extrai a figura
	* (FigJpgs) para um arquivo .jpg temporario, exatamente como o legado faz no
	* final do Valid de GetOP (StrToFile sobre o campo memo). Ausencia de figura
	* NAO eh erro - THIS.this_cArquivoImagem fica vazio e o Form nao exibe nada.
	*==============================================================================
	PROTECTED PROCEDURE BuscarImagemProduto(par_cProduto)
		LOCAL loc_cSQL, loc_nResultado, loc_cNomeArquivo

		THIS.this_cArquivoImagem = ""

		IF VARTYPE(par_cProduto) != "C" OR EMPTY(ALLTRIM(par_cProduto))
			RETURN .T.
		ENDIF

		IF USED(THIS.this_cCursorProduto)
			USE IN (THIS.this_cCursorProduto)
		ENDIF

		loc_cSQL = "SELECT Cpros, Dpros, FigJpgs FROM SigCdPro WHERE Cpros = " + ;
			EscaparSQL(par_cProduto)

		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorProduto)

		IF loc_nResultado < 1
			THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + CapturarErroSQL()
			RETURN .F.
		ENDIF

		IF USED(THIS.this_cCursorProduto)
			SELECT (THIS.this_cCursorProduto)
			GO TOP

			IF !EOF() ;
					AND !EMPTY(EVALUATE(THIS.this_cCursorProduto + ".FigJpgs")) ;
					AND !ISNULL(EVALUATE(THIS.this_cCursorProduto + ".FigJpgs"))

				loc_cNomeArquivo = SYS(2023) + "\" + ALLTRIM(SYS(2015)) + ".jpg"

				IF STRTOFILE(EVALUATE(THIS.this_cCursorProduto + ".FigJpgs"), loc_cNomeArquivo) > 0
					THIS.this_cArquivoImagem = loc_cNomeArquivo
				ENDIF
			ENDIF
		ENDIF

		RETURN .T.
	ENDPROC


	*==============================================================================
	* CarregarDoCursor - Carrega o registro CORRENTE do cursor da arvore para as
	* propriedades do BO. Eh o que o Form consome ao montar a arvore e ao tratar o
	* no selecionado: no legado, cada iteracao do "Scan" de MakeTree/MakeTreeEnv
	* le essas MESMAS colunas direto do cursor CrSigCdNei.
	*
	* Sem par_cAliasCursor assume THIS.this_cCursorArvore.
	*
	* A work area corrente eh SALVA e RESTAURADA: o Form chama este metodo de
	* dentro de lacos que percorrem o proprio cursor, e trocar a area sem repor
	* quebraria o SCAN do chamador. Por isso ha um unico RETURN, no fim.
	*==============================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_cAlias, loc_nAreaAnterior, loc_lSucesso, loc_cChave

		loc_lSucesso = .F.

		loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
			ALLTRIM(par_cAliasCursor), THIS.this_cCursorArvore)

		IF !USED(loc_cAlias)
			THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + "] n" + CHR(227) + ;
				"o est" + CHR(225) + " aberto."
		ELSE
			loc_nAreaAnterior = SELECT()
			SELECT (loc_cAlias)

			*-- Cursor em EOF/BOF nao eh falha: apenas nao ha registro corrente
			*-- para carregar (a arvore chama este metodo dentro de laco)
			IF !EOF() AND !BOF()
				THIS.this_cCidchaves = TratarNulo(Cidchaves, "")
				THIS.this_nNenvs     = TratarNulo(Nenvs, 0)
				THIS.this_cEmpDnPs   = TratarNulo(EmpDnPs, "")
				THIS.this_dDatas     = ConverterParaData(Datas)
				THIS.this_cGrupoos   = TratarNulo(Grupoos, "")
				THIS.this_cContaos   = TratarNulo(Contaos, "")
				THIS.this_cGrupods   = TratarNulo(Grupods, "")
				THIS.this_cContads   = TratarNulo(Contads, "")
				THIS.this_nNops      = TratarNulo(Nops, 0)
				THIS.this_cCmats     = TratarNulo(Cmats, "")
				THIS.this_cDpros     = TratarNulo(Dpros, "")
				THIS.this_nQtds      = TratarNulo(Qtds, 0)
				THIS.this_cCunis     = TratarNulo(Cunis, "")
				THIS.this_nPeso2s    = TratarNulo(Peso2s, 0)
				THIS.this_cCunips    = TratarNulo(Cunips, "")
				THIS.this_nPesos     = TratarNulo(Pesos, 0)
				THIS.this_cCpros     = TratarNulo(Cpros, "")
				THIS.this_nNopMaes   = TratarNulo(NopMaes, 0)

				*-- Servicos eh coluna bit no SQL Server. O SELECT do BO a traz
				*-- como CAST(... AS INT), entao chega SEMPRE numerica ao cursor.
				*-- A conversao aqui entrega um LOGICO de verdade ao Form, que
				*-- precisa dele para usar IIF() (IIF exige logico no 1o argumento).
				THIS.this_lServicos = ConverterParaLogico(TratarNulo(Servicos, 0))

				*-- TotPesos so existe no cursor da arvore (eh o total agregado por
				*-- movimentacao). Alias cru de SQLEXEC nao tem essa coluna, e nome
				*-- de campo inexistente estoura "Variable ... is not found" - por
				*-- isso o TYPE() antes (PEMSTATUS NAO serve para cursor).
				IF TYPE(loc_cAlias + ".TotPesos") = "N"
					THIS.this_nTotPesos = TratarNulo(EVALUATE(loc_cAlias + ".TotPesos"), 0)
				ELSE
					THIS.this_nTotPesos = 0
				ENDIF

				*-- EmpDnPs char(33) eh chave POSICIONAL: Emps(3) + Dopps(20) +
				*-- Str(Numps, 10). O legado decompoe exatamente nessas fatias
				*-- (Left / Substr / Val) no TreeView.DblClick. O PADR garante as
				*-- 33 posicoes antes de fatiar; NUNCA aplicar ALLTRIM nas partes
				*-- INTERIORES, porque o padding FAZ PARTE da chave.
				loc_cChave = PADR(THIS.this_cEmpDnPs, 33)
				THIS.this_cEmps  = LEFT(loc_cChave, 3)
				THIS.this_cDopps = SUBSTR(loc_cChave, 4, 20)
				THIS.this_nNumps = VAL(ALLTRIM(SUBSTR(loc_cChave, 24)))

				loc_lSucesso = .T.
			ENDIF

			IF loc_nAreaAnterior > 0
				SELECT (loc_nAreaAnterior)
			ENDIF
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*==============================================================================
	* MontarChaveEmpDnPs - Remonta a chave POSICIONAL EmpDnPs:
	*     Emps char(3) + Dopps char(20) + Str(Numps, 10) = char(33)
	* A largura do char(33) destino (SigCdNei / SigCdNec / SigPdMvf / SigOpPic) eh
	* a conferencia da montagem: 3 + 20 + 10 = 33.
	*
	* PADR EXPLICITO em cada parte. ALLTRIM nas partes INTERIORES encurtaria a
	* chave, ela nunca casaria no WHERE e o SELECT devolveria ZERO linhas em
	* SILENCIO - sem erro e sem log. Nao confiar no padding que o cursor por
	* acaso traz: as propriedades do BO podem ter vindo de um TextBox.
	*==============================================================================
	PROCEDURE MontarChaveEmpDnPs(par_cEmps, par_cDopps, par_nNumps)
		LOCAL loc_cEmps, loc_cDopps, loc_nNumps

		loc_cEmps  = IIF(VARTYPE(par_cEmps) = "C", par_cEmps, "")
		loc_cDopps = IIF(VARTYPE(par_cDopps) = "C", par_cDopps, "")
		loc_nNumps = IIF(VARTYPE(par_nNumps) = "N", par_nNumps, 0)

		RETURN PADR(loc_cEmps, 3) + PADR(loc_cDopps, 20) + STR(loc_nNumps, 10)
	ENDPROC

	*==============================================================================
	* ObterChavePrimaria - Identidade do registro corrente, usada pela auditoria
	* da BusinessBase. Nesta consulta nao existe tabela mestre unica: o registro
	* eh identificado pela chave de movimentacao EmpDnPs, coluna char(33) que
	* SigCdNei, SigCdNec, SigPdMvf e SigOpPic compartilham.
	*
	* ALLTRIM aqui eh na chave INTEIRA (no fim), nao nas partes - isso eh
	* inofensivo, porque char no SQL Server compara com blank-padding ANSI.
	*==============================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		LOCAL loc_cChave

		loc_cChave = ALLTRIM(THIS.this_cEmpDnPs)

		IF EMPTY(loc_cChave)
			loc_cChave = ALLTRIM(THIS.MontarChaveEmpDnPs(THIS.this_cEmps, ;
				THIS.this_cDopps, THIS.this_nNumps))
		ENDIF

		RETURN loc_cChave
	ENDPROC

	*==============================================================================
	* ResetarRegistroCorrente - Zera as propriedades do registro corrente da
	* arvore. Chamado pelo Init e pelo LimparDados: o Form nao eh fechado entre
	* uma pesquisa e outra, entao sem este reset a pesquisa seguinte exibiria
	* residuo da anterior quando o novo cursor viesse vazio.
	*==============================================================================
	PROTECTED PROCEDURE ResetarRegistroCorrente()
		THIS.this_cCidchaves = ""
		THIS.this_nNenvs     = 0
		THIS.this_cEmpDnPs   = ""
		THIS.this_dDatas     = {}
		THIS.this_cGrupoos   = ""
		THIS.this_cContaos   = ""
		THIS.this_cGrupods   = ""
		THIS.this_cContads   = ""
		THIS.this_lServicos  = .F.
		THIS.this_nNops      = 0
		THIS.this_cCmats     = ""
		THIS.this_cDpros     = ""
		THIS.this_nQtds      = 0
		THIS.this_cCunis     = ""
		THIS.this_nPeso2s    = 0
		THIS.this_cCunips    = ""
		THIS.this_nPesos     = 0
		THIS.this_nTotPesos  = 0
		THIS.this_cCpros     = ""
		THIS.this_nNopMaes   = 0
		THIS.this_cEmps      = ""
		THIS.this_cDopps     = ""
		THIS.this_nNumps     = 0

		RETURN .T.
	ENDPROC

	*==============================================================================
	* LimparDados - Zera criterios de pesquisa e registro corrente, fechando os
	* cursores de resultado. O Form chama isto ao limpar a tela (no legado os dois
	* TextBox se zeram mutuamente: GetOP.GotFocus zera GetEnvelope e o GotFocus de
	* GetEnvelope zera GetOP).
	*==============================================================================
	PROCEDURE LimparDados()
		DODEFAULT()

		THIS.this_nNumeroOP = 0
		THIS.this_nNumeroEnvelope = 0
		THIS.this_lRegistroEncontrado = .F.
		THIS.this_cMensagemErro = ""

		THIS.ResetarRegistroCorrente()
		THIS.FecharCursoresResultado()

		RETURN .T.
	ENDPROC

	*==============================================================================
	* FecharCursoresResultado - Fecha os cursores de resultado da consulta.
	*
	* O guard eh pelo BUFFERING, nao so pelo USED(): TABLEREVERT() EXIGE row ou
	* table buffering e, sem ele, dispara o erro 1586 em vez de ser no-op. Cursor
	* nascido de CREATE CURSOR ou de SELECT INTO CURSOR vem com Buffering = 1, e
	* nesse caso USE IN fecha o alias sozinho, mesmo com buffer sujo.
	*==============================================================================
	PROCEDURE FecharCursoresResultado()
		LOCAL ARRAY loc_aCursores[3]
		LOCAL loc_nI, loc_cCursor

		loc_aCursores[1] = THIS.this_cCursorArvore
		loc_aCursores[2] = THIS.this_cCursorProduto
		loc_aCursores[3] = "cursor_4c_Nensi"

		FOR loc_nI = 1 TO ALEN(loc_aCursores)
			loc_cCursor = loc_aCursores[loc_nI]

			IF VARTYPE(loc_cCursor) = "C" AND !EMPTY(loc_cCursor) AND USED(loc_cCursor)
				IF CURSORGETPROP("Buffering", loc_cCursor) > 1
					TABLEREVERT(.T., loc_cCursor)
				ENDIF
				USE IN (loc_cCursor)
			ENDIF
		ENDFOR

		RETURN .T.
	ENDPROC

	*==============================================================================
	* ExcluirImagemTemporaria - Apaga o .jpg que BuscarImagemProduto extraiu de
	* SigCdPro.FigJpgs. Equivale ao "Delete File (ThisForm.Arqfigura)" que o legado
	* executa no Click do botao de saida (Commandgroup1).
	*
	* CLEAR RESOURCES antes de apagar: o VFP mantem o bitmap em cache e o arquivo
	* fica preso enquanto o cache nao eh liberado (o legado faz o mesmo antes de
	* trocar a figura). SET SAFETY OFF em volta do DELETE FILE porque com SAFETY ON
	* ele abre dialogo de confirmacao, e dialogo modal travaria o pipeline.
	*==============================================================================
	PROCEDURE ExcluirImagemTemporaria()
		LOCAL loc_cArquivo, loc_cSafety

		loc_cArquivo = ALLTRIM(THIS.this_cArquivoImagem)
		THIS.this_cArquivoImagem = ""

		IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
			CLEAR RESOURCES

			loc_cSafety = SET("SAFETY")
			SET SAFETY OFF

			DELETE FILE (loc_cArquivo)

			IF loc_cSafety = "ON"
				SET SAFETY ON
			ENDIF
		ENDIF

		RETURN .T.
	ENDPROC

	*==============================================================================
	* Destroy - Libera os cursores de resultado e o arquivo temporario da figura.
	*==============================================================================
	PROCEDURE Destroy()
		THIS.ExcluirImagemTemporaria()
		THIS.FecharCursoresResultado()

		DODEFAULT()
	ENDPROC
ENDDEFINE

