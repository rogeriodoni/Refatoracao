# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [METODO-INEXISTENTE] Metodo 'THIS.Caption()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'Opt_Concilia' (parent: SIGOPBLO): Top original=216 vs migrado 'obj_4c_Opt_Concilia' Top=0 (diff=216px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpBlo.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (918 linhas total):

*-- Linhas 11 a 312:
11: *
12: * Form OPERACIONAL - layout CUSTOMIZADO (flat, SEM PageFrame): o SCX
13: * legado (SIGOPBLO) nao tem Page1/Page2 - Shapes, Labels, TextBoxes,
14: * OptionGroup e o CommandGroup "Salvamento" sao TODOS filhos diretos
15: * do Form (layout.json nao declara pageframe nenhum). CLAUDE.md: forms
16: * OPERACIONAIS nao seguem o padrao Lista/Dados do CRUD - layout vem do
17: * original (tasks\task647\SigOpBlo_form_codigo_fonte.txt).
18: *
19: * FASE 3/8 - ESTRUTURA BASE: cria o Business Object (SigOpBloBO,
20: * Fases 1-2) e monta so o elemento decorativo do layout (faixa do
21: * cabecalho cnt_4c_Sombra, equivalente ao cntSombra legado - o Init
22: * legado so faz ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
23: * e o mesmo para lblTitulo, reproduzido aqui via THIS.Caption). O
24: * carregamento do registro unico (equivalente ao
25: * AddCursor/Requery/Insert-se-vazio do Init legado), os campos de
26: * dados (Shapes/Labels/TextBoxes/OptionGroup) e o CommandGroup
27: * "Salvamento" ficam para as fases seguintes do roteiro.
28: *
29: * FASE 4/8 (CONCLUIDA COMO NO-OP JUSTIFICADO): nao ha Grid nem botoes
30: *           CRUD a acrescentar - analise.json confirma temGrid=false e
31: *           layout.json nao declara PageFrame nenhum (o SCX legado
32: *           SIGOPBLO nao tem Page1/Page2: Shapes, Labels, TextBoxes,
33: *           OptionGroup e o CommandGroup "Salvamento" sao TODOS filhos
34: *           diretos do Form). Este eh um dialogo FLAT de PARAMETROS
35: *           (registro UNICO, sem lista) - mesma familia do
36: *           SIGOPATU/FormSigOpAtu e do SIGOPBIN/FormSIGOPBIN,
37: *           documentada no gate da Fase 4 do OrquestradorMigracao.ps1
38: *           (ramo "layout captura"/dialogo sem lista). Inventar
39: *           Page1/Grid/6 botoes CRUD aqui violaria o PILAR 1 (o legado
40: *           eh um popup de 500x271 com 1 registro de parametros, nao
41: *           um cadastro) e a regra "NUNCA inventar" (CLAUDE.md).
42: *
43: *           O CommandGroup "Salvamento" do legado (Command1="Salvar",
44: *           Command2="Abortar" - mapeamento.json: SIGOPBLO.Salvamento
45: *           -> obj_4c_Salvamento) eh o equivalente funcional dos
46: *           botoes de acao, mas fica para a fase dos CAMPOS (junto com
47: *           Shapes/Labels/TextBoxes/OptionGroup e o carregamento do
48: *           registro unico): os dois botoes operam sobre os mesmos
49: *           campos que ainda nao existem na tela, e criar o
50: *           CommandGroup agora, sem Click real, seria o stub que o
51: *           pipeline proibe.
52: *
53: * FASE 5/8 (CAMPOS - PARTE 1/2): ConfigurarPaginaDados() acrescenta a
54: *           primeira metade dos controles de dados do SCX legado -
55: *           bloco "Periodo do Bloqueio" (Get_datini/Get_datfin + Say1
56: *           + Shape1) e bloco "Bloqueio Automatico" (get_ddr/get_ddf +
57: *           Say3/Say4/Say5 + Shape2). Todos filhos DIRETOS de THIS,
58: *           como no SCX (form FLAT, sem PageFrame - ver comentario da
59: *           Fase 3). Shapes/Labels/TextBoxes preservam Top/Left/Width
60: *           EXATOS do dump (tasks\task647\SigOpBlo_form_codigo_fonte.txt).
61: *           O bloco "Bloqueio Contabil"/"Conciliacao" (Shape3/Shape4/
62: *           Say6/Say7/Get_DtCont/Opt_Concilia) e o BINDEVENT de
63: *           validacao de Get_datfin ficam para a Fase 6. FormParaBO/
64: *           BOParaForm (ligacao com this_dDatais/this_dDatafs/
65: *           this_nDdretros/this_nDdfutus do BO) e o carregamento do
66: *           registro unico tambem ficam para fase propria - aqui so a
67: *           estrutura visual eh montada.
68: *
69: * FASE 6/8 (CAMPOS RESTANTES + BOTOES - CONCLUIDA): completa
70: *           ConfigurarPaginaDados() com a segunda metade do dump -
71: *           bloco "Bloqueio Contabil" (Shape4/Say6/Get_DtCont, ligado a
72: *           this_dDtiConts) e bloco "Conciliacao" (Shape3/Say7/
73: *           Opt_Concilia, ligado a this_nChkConcs). "TODOS os lookups"
74: *           desta fase eh NO-OP JUSTIFICADO: o dump
75: *           (SigOpBlo_form_codigo_fonte.txt) nao tem NENHUM
76: *           CreateObject('fwBuscaExt'/'fwBuscaSel'/'fwBuscaInt',...)
77: *           nem sigacess() - eh um dialogo de PARAMETROS (datas,
78: *           numeros, OptionGroup), sem campo-codigo que precise de
79: *           F4/F5 (mesma logica da Fase 4, que ja descartou Grid/CRUD
80: *           por nao existirem no legado). O UNICO evento de validacao
81: *           do dump (Get_datfin.Valid) e o UNICO bloco de botoes
82: *           (CommandGroup "Salvamento") entram aqui:
83: *
84: *   - DatfinLostFocus: equivalente do Get_datfin.Valid ("If (This.Value
85: *     < Thisform.get_datini.Value) / Messagebox('Entrada Invalida!!!',
86: *     0+48,'') / Return 0") - "LostFocus" e nao "Valid" porque BINDEVENT
87: *     em "Valid" nao dispara de forma confiavel em TextBox (regra #34).
88: *     Sem equivalente ao "Return 0" do VFP classico (que mantinha o
89: *     foco no campo); aqui o SetFocus() de volta reproduz o mesmo
90: *     efeito pratico (usuario nao sai do campo invalido).
91: *
92: *   - cmg_4c_Salvamento (Salvamento/commandgroup do legado,
93: *     mapeamento.json: SIGOPBLO.Salvamento -> obj_4c_Salvamento;
94: *     renomeado para cmg_4c_ por convencao de CommandGroup do projeto -
95: *     ver FormSigOpArq.cmg_4c_Botoes): Buttons(1) = Salva/"Confirmar",
96: *     Buttons(2) = Aborta/"Encerrar". BtnConfirmarClick/
97: *     BtnEncerrarClick saem desta fase com Click JA implementado (sem
98: *     stub) - inclui o carregamento do registro unico (equivalente ao
99: *     AddCursor/Requery/Insert-se-vazio do Init legado, via
100: *     SigOpBloBO.CarregarRegistroUnico()) e FormParaBO/BOParaForm, que
101: *     nao fariam sentido como metodos vazios sem os botoes que os
102: *     disparam. Ver cada metodo para a transcricao literal do
103: *     Salva.Click/Aborta.Click legado.
104: *
105: * FASE 7/8 (EVENTOS PRINCIPAIS - NO-OP JUSTIFICADO): os quatro nomes
106: *           BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/
107: *           BtnExcluirClick sao convencao de form CRUD (barra
108: *           Incluir/Alterar/Visualizar/Excluir da Page1 de Lista de um
109: *           frmcadastro). O SIGOPBLO legado herda de `form` generico
110: *           (layout.json: form.class="form", sem Page1/Page2), NAO tem
111: *           "frmcadastro" nem "Grupo_Op" em
112: *           tasks\task647\SigOpBlo_form_codigo_fonte.txt (grep
113: *           confirmado: zero ocorrencias de frmcadastro/Grupo_Op/
114: *           Incluir/Alterar/Visualizar/Excluir/pcEscolha no dump
115: *           inteiro) - eh um dialogo de PARAMETROS UNICOS (registro
116: *           unico de SigSyBlq), sem conceito de "varios registros" que
117: *           justifique Incluir/Alterar/Visualizar/Excluir. Criar esses
118: *           4 metodos aqui seria INVENTAR botoes que o legado nao tem
119: *           (viola o PILAR 1 e a regra "NUNCA inventar" do CLAUDE.md)
120: *           ou criar stubs vazios so para o nome existir (proibido pela
121: *           regra de completude) - mesma familia de excecao ja
122: *           documentada no gate da Fase 7 do OrquestradorMigracao.ps1
123: *           (ramo "legado sem botao CRUD").
124: *
125: *           Os "eventos principais dos botoes" que o legado REALMENTE
126: *           tem (Salvamento: Buttons(1)="Confirmar"/Buttons(2)=
127: *           "Encerrar", ButtonCount=2) ja saem da Fase 6 com Click
128: *           implementado - BtnConfirmarClick (grava via
129: *           this_oBusinessObject.Salvar()) e BtnEncerrarClick (fecha
130: *           sem gravar), ambos no padrao PROCEDURE Cmd*/Btn*Click que o
131: *           proprio gate audita (piso de 2 handlers para os 2 botoes do
132: *           CommandGroup legado - satisfeito).
133: *
134: * FASE 8/8 (EVENTOS AUXILIARES E CONSOLIDACAO FINAL - NO-OP JUSTIFICADO
135: *           nos nomes CRUD, consolidacao real feita): o roteiro padrao
136: *           desta fase pede BtnBuscarClick/BtnSalvarClick/
137: *           BtnCancelarClick/HabilitarCampos/LimparCampos/CarregarLista/
138: *           AjustarBotoesPorModo - convencao de form CRUD (Page1=Lista
139: *           com grid + botoes Incluir/Alterar/Excluir/Buscar, Page2=
140: *           Dados com Salvar/Cancelar). Mesma exclusao ja fundamentada
141: *           nas Fases 4 e 7: o SIGOPBLO legado eh um dialogo MODAL de
142: *           PARAMETROS UNICOS (1 registro de SigSyBlq, sem grid, sem
143: *           PageFrame, sem "varios registros" para buscar/listar) - os
144: *           equivalentes REAIS desses nomes ja existem desde a Fase 6/7
145: *           sob os nomes do proprio CommandGroup legado:
146: *
147: *             BtnSalvarClick/BtnConfirmarClick -> BtnConfirmarClick
148: *                 (FormParaBO + this_oBusinessObject.Salvar() + Release)
149: *             BtnCancelarClick/BtnEncerrarClick -> BtnEncerrarClick
150: *                 (Release sem gravar)
151: *             CarregarLista                    -> N/A (sem grid; o
152: *                 equivalente e CarregarRegistroUnico(), chamado em
153: *                 InicializarForm desde a Fase 6)
154: *             HabilitarCampos/AjustarBotoesPorModo -> N/A (os dois
155: *                 botoes do CommandGroup ficam sempre habilitados, como
156: *                 no legado - nao ha modo LISTA/INCLUIR/ALTERAR/
157: *                 VISUALIZAR neste dialogo de parametro unico)
158: *             LimparCampos                     -> N/A (nao ha "novo
159: *                 registro" a preparar em branco; o unico registro de
160: *                 SigSyBlq e sempre carregado via BOParaForm)
161: *             BtnBuscarClick                   -> N/A (sem lookup de
162: *                 codigo digitado - confirmado nas Fases 6/7, dump sem
163: *                 CreateObject('fwBusca*'...)/sigacess())
164: *
165: *           Consolidacao REAL desta fase: integracao no menu (popup
166: *           popMovimentos, bar "Bloqueio de Periodo") via
167: *           PROCEDURE AbrirFormSigOpBlo() em menu.prg - CREATEOBJECT()
168: *           dentro de TRY, Show() FORA do TRY (regra #29, forms modais).
169: *           ADIR() de config.prg ja carrega FormSigOpBlo.prg/
170: *           SigOpBloBO.prg automaticamente (nao precisa SET PROCEDURE
171: *           manual). FormParaBO/BOParaForm (Fase 6) ja cobrem as SEIS
172: *           properties de tela do BO (this_dDatais/this_dDatafs/
173: *           this_nDdretros/this_nDdfutus/this_dDtiConts/this_nChkConcs)
174: *           nos dois sentidos - paridade confirmada contra
175: *           SigOpBloBO.prg (this_cCidChaves e this_dDtgdmis/this_dDtgeras
176: *           sao colunas internas de auditoria, nao exibidas na tela,
177: *           conforme Fase 1).
178: *
179: * Herda de: FormBase
180: *====================================================================
181: 
182: DEFINE CLASS FormSigOpBlo AS FormBase
183: 
184:     *-- Propriedades visuais (PILAR 1 - valores exatos do SCX SIGOPBLO)
185:     this_cMensagemErro = ""
186:     Width       = 500
187:     Height      = 271
188:     Caption     = "Bloqueio"
189:     AutoCenter  = .T.
190:     BorderStyle = 2
191:     ControlBox  = .F.
192:     Closable    = .F.
193:     MaxButton   = .F.
194:     MinButton   = .F.
195:     Movable     = .F.
196:     TitleBar    = 0
197:     Themes      = .F.
198:     ShowWindow  = 1
199:     WindowType  = 1
200: 
201:     *-- DataSession = 2 no legado (fweditdata/fwoption/fSqlConector
202:     *-- isolados por form). FormBase.Init() ja compensa o reset de
203:     *-- SET DATE/CENTURY desta datasession privada (regra #9.4).
204:     DataSession = 2
205: 
206:     *====================================================================
207:     * Init
208:     *====================================================================
209:     PROCEDURE Init()
210:         RETURN DODEFAULT()
211:     ENDPROC
212: 
213:     *====================================================================
214:     * InicializarForm - cria o Business Object e monta a faixa do
215:     * cabecalho (cnt_4c_Sombra). Carga do registro unico, campos de
216:     * dados e botoes de acao entram nas fases seguintes.
217:     *====================================================================
218:     PROTECTED PROCEDURE InicializarForm()
219:         LOCAL loc_lSucesso, loc_oErro
220:         loc_lSucesso = .F.
221: 
222:         TRY
223:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpBloBO")
224: 
225:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
226:                 THIS.ConfigurarPageFrame()
227:                 THIS.ConfigurarPaginaDados()
228:                 THIS.ConfigurarBotoes()
229:                 THIS.ConfigurarEventos()
230: 
231:                 *-- Equivalente ao AddCursor/Requery/Insert-se-vazio do
232:                 *-- Init legado: carrega o registro unico se ja existir
233:                 *-- em SigSyBlq, ou prepara um novo (fUniqueIds via
234:                 *-- InicializarValoresPadrao) quando a tabela ainda
235:                 *-- estiver vazia.
236:                 IF THIS.this_oBusinessObject.CarregarRegistroUnico()
237:                     THIS.this_oBusinessObject.EditarRegistro()
238:                 ELSE
239:                     THIS.this_oBusinessObject.NovoRegistro()
240:                 ENDIF
241:                 THIS.BOParaForm()
242: 
243:                 THIS.TornarControlesVisiveis(THIS)
244:                 loc_lSucesso = .T.
245:             ELSE
246:                 THIS.this_cMensagemErro = "Erro ao criar SigOpBloBO." + CHR(13) + ;
247:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject)
248:                 MsgErro(THIS.this_cMensagemErro, "FormSigOpBlo.InicializarForm")
249:             ENDIF
250:         CATCH TO loc_oErro
251:             THIS.this_cMensagemErro = loc_oErro.Message
252:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
253:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao inicializar Bloqueio")
254:             loc_lSucesso = .F.
255:         ENDTRY
256: 
257:         RETURN loc_lSucesso
258:     ENDPROC
259: 
260:     *====================================================================
261:     * ConfigurarPageFrame - fundo (Picture do legado) e faixa do
262:     * cabecalho (cnt_4c_Sombra, equivalente ao cntSombra legado).
263:     * Form FLAT (sem PageFrame/Page - o SCX nao tem nenhuma): nome do
264:     * metodo mantido por convencao do orquestrador de migracao, mas
265:     * nenhum AddObject("pgf_4c_...") eh feito aqui.
266:     *
267:     * lblSombra/lblTitulo: Init legado faz
268:     * ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption e o mesmo
269:     * para lblTitulo - reproduzido direto via THIS.Caption (dinamico,
270:     * nao precisa repetir o literal "Bloqueio").
271:     *====================================================================
272:     PROTECTED PROCEDURE ConfigurarPageFrame()
273:         THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
274: 
275:         THIS.AddObject("cnt_4c_Sombra", "Container")
276:         WITH THIS.cnt_4c_Sombra
277:             .Top         = 0
278:             .Left        = 0
279:             .Width       = THIS.Width
280:             .Height      = 80
281:             .BorderWidth = 0
282:             .BackStyle   = 1
283:             .BackColor   = RGB(100, 100, 100)
284:             .Visible     = .T.
285:         ENDWITH
286: 
287:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
288:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
289:             .FontBold      = .T.
290:             .FontName      = "Tahoma"
291:             .FontSize      = 18
292:             .FontUnderline = .F.
293:             .WordWrap      = .T.
294:             .AutoSize      = .F.
295:             .Alignment     = 0
296:             .BackStyle     = 0
297:             .Caption       = THIS.Caption
298:             .Height        = 40
299:             .Left          = 10
300:             .Top           = 18
301:             .Width         = 769
302:             .ForeColor     = RGB(0, 0, 0)
303:             .Visible       = .T.
304:         ENDWITH
305: 
306:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
307:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
308:             .FontBold  = .T.
309:             .FontName  = "Tahoma"
310:             .FontSize  = 18
311:             .WordWrap  = .T.
312:             .AutoSize  = .F.

*-- Linhas 329 a 383:
329:     * arquivo). FASE 5/8: primeira metade - bloco "Periodo do
330:     * Bloqueio" (Get_datini/Get_datfin) e bloco "Bloqueio Automatico"
331:     * (get_ddr/get_ddf). Bloco "Bloqueio Contabil"/"Conciliacao"
332:     * (Get_DtCont/Opt_Concilia) e o BINDEVENT de validacao de
333:     * Get_datfin.Valid ficam para a Fase 6. Top/Left/Width EXATOS do
334:     * dump legado - Say sem Width/Alignment no dump = classe say
335:     * AutoSize (regra #23): aqui com .Alignment = 0 + .Width explicita
336:     * que caiba o texto (AutoSize = .T. eh no-op em Label por
337:     * AddObject).
338:     *
339:     * .Value inicial eh so o neutro do TIPO da coluna (DATE vazio /
340:     * 0 numerico) - a carga do registro unico (BOParaForm) fica para a
341:     * fase de dados/gravacao.
342:     *====================================================================
343:     PROTECTED PROCEDURE ConfigurarPaginaDados()
344: 
345:         *-- Shape2 -> shp_4c_Shape2 (linha divisoria sob "Bloqueio Automatico")
346:         THIS.AddObject("shp_4c_Shape2", "Shape")
347:         WITH THIS.shp_4c_Shape2
348:             .Top           = 153
349:             .Left          = 9
350:             .Width         = 291
351:             .Height        = 2
352:             .BorderWidth   = 2
353:             .Curvature     = 0
354:             .SpecialEffect = 0
355:             .BorderColor   = RGB(100, 100, 100)
356:             .Visible       = .T.
357:         ENDWITH
358: 
359:         *-- Shape1 -> shp_4c_Shape1 (linha divisoria sob "Periodo do Bloqueio")
360:         THIS.AddObject("shp_4c_Shape1", "Shape")
361:         WITH THIS.shp_4c_Shape1
362:             .Top           = 98
363:             .Left          = 9
364:             .Width         = 291
365:             .Height        = 2
366:             .BorderWidth   = 2
367:             .Curvature     = 0
368:             .SpecialEffect = 0
369:             .BorderColor   = RGB(100, 100, 100)
370:             .Visible       = .T.
371:         ENDWITH
372: 
373:         *-- Say2 -> lbl_4c_Label2 (" Periodo do Bloqueio ")
374:         THIS.AddObject("lbl_4c_Label2", "Label")
375:         WITH THIS.lbl_4c_Label2
376:             .FontBold  = .T.
377:             .FontName  = "Tahoma"
378:             .FontSize  = 8
379:             .BackStyle = 0
380:             .Alignment = 0
381:             .AutoSize  = .F.
382:             .Caption   = " Per" + CHR(237) + "odo do Bloqueio "
383:             .Left      = 15

*-- Linhas 406 a 449:
406: 
407:         *-- Get_datfin -> txt_4c_Datfin (data final do periodo de bloqueio - this_dDatafs)
408:         *-- Valid legado (Get_datfin < Get_datini -> MsgErro) fica para a
409:         *-- Fase 6, via BINDEVENT "LostFocus" (CLAUDE.md: BINDEVENT "Valid"
410:         *-- nao funciona em TextBox).
411:         THIS.AddObject("txt_4c_Datfin", "TextBox")
412:         WITH THIS.txt_4c_Datfin
413:             .Alignment = 3
414:             .Format    = "E"
415:             .InputMask = "99/99/9999"
416:             .Left      = 116
417:             .Top       = 104
418:             .Width     = 80
419:             .Height    = 18
420:             .MaxLength = 10
421:             .TabIndex  = 2
422:             .Value     = {}
423:             .Visible   = .T.
424:         ENDWITH
425: 
426:         *-- Say1 -> lbl_4c_Label1 ("a", entre as duas datas)
427:         THIS.AddObject("lbl_4c_Label1", "Label")
428:         WITH THIS.lbl_4c_Label1
429:             .FontName  = "Tahoma"
430:             .FontSize  = 8
431:             .BackStyle = 0
432:             .Alignment = 0
433:             .AutoSize  = .F.
434:             .Caption   = "a"
435:             .Left      = 100
436:             .Top       = 107
437:             .Width     = 15
438:             .Height    = 15
439:             .ForeColor = RGB(90, 90, 90)
440:             .Visible   = .T.
441:         ENDWITH
442: 
443:         *-- Say3 -> lbl_4c_Label3 ("Dias Retroativo : ")
444:         THIS.AddObject("lbl_4c_Label3", "Label")
445:         WITH THIS.lbl_4c_Label3
446:             .FontName  = "Tahoma"
447:             .FontSize  = 8
448:             .BackStyle = 0
449:             .Alignment = 0

*-- Linhas 608 a 655:
608:         *-- Opt_Concilia -> obj_4c_Opt_Concilia (opcao de conciliacao -
609:         *-- this_nChkConcs: 1=Checar Bloqueio, 2=Liberar Data, 3=Nenhum).
610:         *-- Legenda/ordem/Top de cada botao TRANSCRITOS do dump (regra
611:         *-- #45 - OptionGroup: nunca inventar). ControlSource direto do
612:         *-- legado ("CrBloqueio.ChkConcs") -> coluna numeric(1,0) cujo
613:         *-- VALOR gravado eh o proprio indice do botao (1/2/3, sem
614:         *-- +1/-1) - mapeamento feito em FormParaBO/BOParaForm.
615:         THIS.AddObject("obj_4c_Opt_Concilia", "OptionGroup")
616:         WITH THIS.obj_4c_Opt_Concilia
617:             .Top         = 216
618:             .Left        = 15
619:             .Width       = 119
620:             .Height      = 53
621:             .ButtonCount = 3
622:             .BackStyle   = 0
623:             .BorderStyle = 0
624:             .TabIndex    = 6
625: 
626:             WITH .Buttons(1)
627:                 .FontName  = "Comic Sans MS"
628:                 .FontSize  = 8
629:                 .BackStyle = 0
630:                 .Caption   = "Checar Bloqueio"
631:                 .Left      = 5
632:                 .Top       = 0
633:                 .Width     = 95
634:                 .Height    = 15
635:                 .ForeColor = RGB(90, 90, 90)
636:                 .Visible   = .T.
637:             ENDWITH
638: 
639:             WITH .Buttons(2)
640:                 .FontName  = "Comic Sans MS"
641:                 .FontSize  = 8
642:                 .BackStyle = 0
643:                 .Caption   = "Liberar Data"
644:                 .Left      = 5
645:                 .Top       = 18
646:                 .Width     = 77
647:                 .Height    = 15
648:                 .ForeColor = RGB(90, 90, 90)
649:                 .Visible   = .T.
650:             ENDWITH
651: 
652:             WITH .Buttons(3)
653:                 .FontName  = "Comic Sans MS"
654:                 .FontSize  = 8
655:                 .BackStyle = 0

*-- Linhas 681 a 724:
681:     * Command1.Click/Command2.Click do legado: CADA botao do
682:     * Commandgroup tem handler PROPRIO (nao um Click unico do grupo).
683:     *====================================================================
684:     PROTECTED PROCEDURE ConfigurarBotoes()
685:         THIS.AddObject("cmg_4c_Salvamento", "CommandGroup")
686:         WITH THIS.cmg_4c_Salvamento
687:             .Top           = 3
688:             .Left          = 340
689:             .Width         = 161
690:             .Height        = 81
691:             .ButtonCount   = 2
692:             .BackStyle     = 0
693:             .BorderStyle   = 0
694:             .SpecialEffect = 1
695:             .BorderColor   = RGB(136, 189, 188)
696:             .Themes        = .F.
697:             .TabIndex      = 13
698: 
699:             WITH .Buttons(1)
700:                 .Top        = 0
701:                 .Left       = 10
702:                 .Width      = 75
703:                 .Height     = 75
704:                 .FontBold   = .T.
705:                 .FontItalic = .T.
706:                 .FontName   = "Comic Sans MS"
707:                 .FontSize   = 8
708:                 .WordWrap   = .T.
709:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
710:                 .Caption    = "\<Confirmar"
711:                 .ToolTipText = "Salva as altera" + CHR(231) + CHR(245) + "es"
712:                 .ForeColor  = RGB(90, 90, 90)
713:                 .BackColor  = RGB(255, 255, 255)
714:                 .Themes     = .F.
715:                 .Visible    = .T.
716:             ENDWITH
717: 
718:             WITH .Buttons(2)
719:                 .Top        = 0
720:                 .Left       = 85
721:                 .Width      = 75
722:                 .Height     = 75
723:                 .FontBold   = .T.
724:                 .FontItalic = .T.

*-- Linhas 738 a 849:
738:             .Visible = .T.
739:         ENDWITH
740: 
741:         BINDEVENT(THIS.cmg_4c_Salvamento.Buttons(1), "Click", THIS, "BtnConfirmarClick")
742:         BINDEVENT(THIS.cmg_4c_Salvamento.Buttons(2), "Click", THIS, "BtnEncerrarClick")
743:     ENDPROC
744: 
745:     *====================================================================
746:     * ConfigurarEventos - Get_datfin.Valid do legado. "LostFocus" e nao
747:     * "Valid" porque BINDEVENT em "Valid" nao dispara de forma confiavel
748:     * em TextBox (regra #34). Chamado DEPOIS de ConfigurarPaginaDados
749:     * (precisa de txt_4c_Datini/txt_4c_Datfin ja criados).
750:     *====================================================================
751:     PROTECTED PROCEDURE ConfigurarEventos()
752:         BINDEVENT(THIS.txt_4c_Datfin, "LostFocus", THIS, "DatfinLostFocus")
753:     ENDPROC
754: 
755:     *====================================================================
756:     * DatfinLostFocus - Get_datfin.Valid do legado:
757:     *
758:     *   If (This.Value < Thisform.get_datini.Value)
759:     *       =Messagebox('Entrada Invalida!!!', 0+48, '')
760:     *       Return 0
761:     *   EndIf
762:     *
763:     * MESSAGEBOX(...,0+48,'') -> MsgAviso (mesmo icone 48; MESSAGEBOX
764:     * direto eh proibido no projeto). O "Return 0" classico mantinha o
765:     * foco no campo; aqui o SetFocus() de volta reproduz o mesmo efeito
766:     * (BINDEVENT "LostFocus" nao pode cancelar a troca de foco que ja
767:     * aconteceu, so reconduzi-la).
768:     *====================================================================
769:     PROCEDURE DatfinLostFocus()
770:         IF THIS.txt_4c_Datfin.Value < THIS.txt_4c_Datini.Value
771:             MsgAviso("Entrada Inv" + CHR(225) + "lida!!!")
772:             THIS.txt_4c_Datfin.SetFocus()
773:         ENDIF
774:     ENDPROC
775: 
776:     *====================================================================
777:     * FormParaBO - Copia os campos de tela para as properties do BO
778:     * (this_dDatais/this_dDatafs/this_nDdretros/this_nDdfutus/
779:     * this_dDtiConts/this_nChkConcs). PROTECTED como na regra #51 - a
780:     * base nao declara este hook, mas e chamado so de dentro da classe
781:     * (BtnConfirmarClick).
782:     *====================================================================
783:     PROTECTED FUNCTION FormParaBO()
784:         LOCAL loc_lResultado
785:         loc_lResultado = .F.
786: 
787:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
788:             THIS.this_oBusinessObject.this_dDatais   = THIS.txt_4c_Datini.Value
789:             THIS.this_oBusinessObject.this_dDatafs   = THIS.txt_4c_Datfin.Value
790:             THIS.this_oBusinessObject.this_nDdretros = THIS.txt_4c__ddr.Value
791:             THIS.this_oBusinessObject.this_nDdfutus  = THIS.txt_4c__ddf.Value
792:             THIS.this_oBusinessObject.this_dDtiConts = THIS.txt_4c_DtCont.Value
793:             THIS.this_oBusinessObject.this_nChkConcs = THIS.obj_4c_Opt_Concilia.Value
794:             loc_lResultado = .T.
795:         ENDIF
796: 
797:         RETURN loc_lResultado
798:     ENDFUNC
799: 
800:     *====================================================================
801:     * BOParaForm - Contraparte do FormParaBO: leva as properties do BO
802:     * para os campos de tela. Chamado por InicializarForm depois de
803:     * carregar (ou preparar) o registro unico.
804:     *
805:     * OptionGroup.Value eh indice 1-based que bate DIRETO com a coluna
806:     * chkconcs (1=Checar Bloqueio, 2=Liberar Data, 3=Nenhum - regra
807:     * #188, sem +1/-1). Registro novo (this_nChkConcs = 0, default da
808:     * property) cai em "Nenhum" (3) - o MESMO default que o proprio SCX
809:     * legado grava na OptionGroup (Opt_Concilia.Value = 3 no dump).
810:     *====================================================================
811:     PROTECTED FUNCTION BOParaForm()
812:         LOCAL loc_lResultado, loc_nChkConcs
813:         loc_lResultado = .F.
814: 
815:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
816:             THIS.txt_4c_Datini.Value = THIS.this_oBusinessObject.this_dDatais
817:             THIS.txt_4c_Datfin.Value = THIS.this_oBusinessObject.this_dDatafs
818:             THIS.txt_4c__ddr.Value   = THIS.this_oBusinessObject.this_nDdretros
819:             THIS.txt_4c__ddf.Value   = THIS.this_oBusinessObject.this_nDdfutus
820:             THIS.txt_4c_DtCont.Value = THIS.this_oBusinessObject.this_dDtiConts
821: 
822:             loc_nChkConcs = THIS.this_oBusinessObject.this_nChkConcs
823:             THIS.obj_4c_Opt_Concilia.Value = IIF(BETWEEN(loc_nChkConcs, 1, 3), loc_nChkConcs, 3)
824: 
825:             THIS.txt_4c_Datini.Refresh()
826:             THIS.txt_4c_Datfin.Refresh()
827:             THIS.txt_4c__ddr.Refresh()
828:             THIS.txt_4c__ddf.Refresh()
829:             THIS.txt_4c_DtCont.Refresh()
830:             THIS.obj_4c_Opt_Concilia.Refresh()
831: 
832:             loc_lResultado = .T.
833:         ENDIF
834: 
835:         RETURN loc_lResultado
836:     ENDFUNC
837: 
838:     *====================================================================
839:     * BtnConfirmarClick - Salva.Click do legado:
840:     *
841:     *   lcBloqueio = 'BLOQUEIO DE '+Nvl(Dtoc(Thisform.Get_datini.Value),'')+
842:     *                ' a '+Nvl(Dtoc(ThisForm.Get_datfin.Value),'')+
843:     *                ' - Ret.:'+Alltrim(Str(ThisForm.Get_ddr.Value))+
844:     *                ' - Fut.:'+Alltrim(Str(ThisForm.Get_ddf.Value))
845:     *   =fGravarLog('B', 'SIGOPBLO', 'ALTERACAO', lcBloqueio, USUAR)
846:     *   ThisForm.poDataMgr.Update('crBloqueio')
847:     *   Thisform.poDataMgr.Commit()
848:     *   ThisForm.Release
849:     *

*-- Linhas 856 a 918:
856:     *
857:     * Update('crBloqueio')+Commit() do DataManager legado = Salvar() do
858:     * BusinessBase, que decide INSERT/UPDATE por this_lNovoRegistro
859:     * (setado em InicializarForm, conforme o registro de SigSyBlq ja
860:     * existisse ou nao).
861:     *
862:     * Falha de Salvar() NAO precisa de ELSE aqui - BusinessBase.Salvar()
863:     * ja chama ExibirFalha() em todo caminho de erro (regra #20); a tela
864:     * so permanece aberta para o usuario corrigir.
865:     *====================================================================
866:     PROCEDURE BtnConfirmarClick()
867:         THIS.FormParaBO()
868: 
869:         IF THIS.this_oBusinessObject.Salvar()
870:             THIS.Release()
871:         ENDIF
872:     ENDPROC
873: 
874:     *====================================================================
875:     * BtnEncerrarClick - Aborta.Click do legado: fecha sem gravar
876:     * ("Thisform.Release").
877:     *====================================================================
878:     PROCEDURE BtnEncerrarClick()
879:         THIS.Release()
880:     ENDPROC
881: 
882:     *====================================================================
883:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
884:     * (AddObject cria com Visible=.F.)
885:     *====================================================================
886:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
887:         LOCAL loc_i, loc_oControl, loc_oErro
888: 
889:         TRY
890:             FOR loc_i = 1 TO par_oContainer.ControlCount
891:                 loc_oControl = par_oContainer.Controls(loc_i)
892:                 IF VARTYPE(loc_oControl) = "O"
893:                     IF PEMSTATUS(loc_oControl, "Visible", 5)
894:                         loc_oControl.Visible = .T.
895:                     ENDIF
896:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
897:                             loc_oControl.ControlCount > 0
898:                         THIS.TornarControlesVisiveis(loc_oControl)
899:                     ENDIF
900:                 ENDIF
901:             ENDFOR
902:         CATCH TO loc_oErro
903:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
904:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, "FormSigOpBlo.TornarControlesVisiveis")
905:         ENDTRY
906:     ENDPROC
907: 
908:     *====================================================================
909:     * Destroy - delega ao FormBase, que libera o Business Object e
910:     * rebuilda os popups do menu principal (fix menu-shrinks de forms
911:     * modais, regra #145). Fases seguintes podem acrescentar liberacao
912:     * de recursos proprios ANTES do DODEFAULT().
913:     *====================================================================
914:     PROCEDURE Destroy()
915:         DODEFAULT()
916:     ENDPROC
917: 
918: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpBloBO.prg):
*------------------------------------------------------------------------------
* SigOpBloBO.prg - Business Object para Bloqueio de Periodo (SigSyBlq)
* Herda de: BusinessBase
* Tabela: SigSyBlq (registro unico de configuracao de bloqueio)
*------------------------------------------------------------------------------
DEFINE CLASS SigOpBloBO AS BusinessBase

    *-- Propriedades da tabela SigSyBlq
    this_cCidChaves = ""    && cidchaves  CHAR(20) NOT NULL - Chave " + CHR(250) + "nica (fUniqueIds)
    this_dDatais    = {}    && datais     DATETIME - Data inicial do per" + CHR(237) + "odo de bloqueio
    this_dDatafs    = {}    && datafs     DATETIME - Data final do per" + CHR(237) + "odo de bloqueio
    this_nDdretros  = 0     && ddretros   NUMERIC(5,0) NOT NULL - Dias retroativos de bloqueio autom" + CHR(225) + "tico
    this_nDdfutus   = 0     && ddfutus    NUMERIC(5,0) NOT NULL - Dias futuros de bloqueio autom" + CHR(225) + "tico
    this_dDtiConts  = {}    && DTICONTS   DATETIME - Data in" + CHR(237) + "cio do bloqueio cont" + CHR(225) + "bil
    this_nChkConcs  = 0     && chkconcs   NUMERIC(1,0) NOT NULL - Op" + CHR(231) + CHR(227) + "o de concilia" + CHR(231) + CHR(227) + "o (1=Checar Bloqueio,2=Liberar Data,3=Nenhum)
    this_dDtgdmis   = {}    && dtgdmis    DATETIME - Data de gera" + CHR(231) + CHR(227) + "o/modifica" + CHR(231) + CHR(227) + "o (n" + CHR(227) + "o exibido na tela)
    this_dDtgeras   = {}    && dtgeras    DATETIME - Data de gera" + CHR(231) + CHR(227) + "o do registro (n" + CHR(227) + "o exibido na tela)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigSyBlq"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarValoresPadrao - Gera a chave unica (fUniqueIds) para o
    * registro novo, igual ao legado (SIGOPBLO.Init: "Insert Into crBloqueio
    * (cIdChaves) Values (fUniqueIds())" quando o cursor vinha vazio)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarValoresPadrao()
        IF EMPTY(ALLTRIM(NVL(THIS.this_cCidChaves, "")))
            THIS.this_cCidChaves = fUniqueIds()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarRegistroUnico - Carrega o registro UNICO de parametros de
    * bloqueio (equivalente ao AddCursor + Requery do Init legado:
    * "lcQryBloqueio = [Select * From SigSyBlq]" + ".AddCursor(...)").
    * SigSyBlq tem no maximo 1 linha (parametros globais do sistema, nao
    * filtrados por codigo digitado pelo usuario - por isso NAO ha
    * CarregarPorCodigo(codigo) como nos BOs de cadastro). PUBLIC (sem
    * PROTECTED) porque o form chama este metodo direto (regra #51).
    *
    * Retorna .T. se encontrou e carregou um registro existente (quem
    * chama decide EditarRegistro()); .F. se a tabela esta vazia -
    * primeira execucao do sistema, quem chama decide NovoRegistro(),
    * que aciona InicializarValoresPadrao() (gera o fUniqueIds()).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarRegistroUnico()
        LOCAL loc_cSQL, loc_lResultado, loc_nResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 cidchaves, datais, datafs, ddretros, " + ;
                "ddfutus, DtiConts, chkconcs, dtgdmis, dtgeras FROM SigSyBlq"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_Carrega") AND RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar par" + CHR(226) + "metros de bloqueio:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao carregar par" + CHR(226) + "metros de bloqueio:" + ;
                CHR(13) + loc_oErro.Message, "SigOpBloBO.CarregarRegistroUnico")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Get_datfin.Valid do legado, repetido aqui como
    * ultimo portao antes de gravar (o campo ja valida no LostFocus -
    * FormSigOpBlo.DatfinLostFocus - mas guards de regra de negocio
    * fazem parte da formula, regra #17, e tem de sobreviver mesmo se
    * o usuario nunca passar pelo campo em tela):
    *
    *   If (This.Value < Thisform.get_datini.Value)
    *       =Messagebox('Entrada Invalida!!!', 0+48, '')
    *       Return 0
    *   EndIf
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        IF THIS.this_dDatafs < THIS.this_dDatais
            THIS.this_cMensagemErro = "Entrada Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    * REGRA CRITICA: 2o argumento de TratarNulo eh o VALOR padrao do TIPO da
    * coluna ("" / 0 / {}), NUNCA o codigo de tipo "C"/"N"/"D"
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = TratarNulo(cidchaves, "")
                THIS.this_dDatais    = TratarNulo(datais,    {})
                THIS.this_dDatafs    = TratarNulo(datafs,    {})
                THIS.this_nDdretros  = TratarNulo(ddretros,  0)
                THIS.this_nDdfutus   = TratarNulo(ddfutus,   0)
                THIS.this_dDtiConts  = TratarNulo(DtiConts,  {})
                THIS.this_nChkConcs  = TratarNulo(chkconcs,  0)
                THIS.this_dDtgdmis   = TratarNulo(dtgdmis,   {})
                THIS.this_dDtgeras   = TratarNulo(dtgeras,   {})
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "SigOpBloBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere o registro unico de parametros de bloqueio em SigSyBlq
    * Cobre TODAS as colunas NOT NULL (cidchaves, ddretros, ddfutus, chkconcs)
    * dtgeras/dtgdmis sao colunas internas de auditoria (nao exibidas na
    * tela, conforme Fase 1) - gravadas com GETDATE() na inclusao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cCidChaves, "")))
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigSyBlq (cidchaves, datais, datafs, ddretros, ddfutus,
                    DtiConts, chkconcs, dtgdmis, dtgeras)
                VALUES (
                    <<EscaparSQL(THIS.this_cCidChaves)>>,
                    <<FormatarDataSQL(THIS.this_dDatais)>>,
                    <<FormatarDataSQL(THIS.this_dDatafs)>>,
                    <<FormatarNumeroSQL(THIS.this_nDdretros, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nDdfutus, 0)>>,
                    <<FormatarDataSQL(THIS.this_dDtiConts)>>,
                    <<FormatarNumeroSQL(THIS.this_nChkConcs, 0)>>,
                    GETDATE(),
                    GETDATE()
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir par" + CHR(226) + "metros de bloqueio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SigOpBloBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza o registro unico de parametros de bloqueio
    * dtgdmis (data de modificacao) eh sempre regravada com GETDATE();
    * dtgeras (data de geracao original) nunca eh tocada no UPDATE
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigSyBlq
                SET datais    = <<FormatarDataSQL(THIS.this_dDatais)>>,
                    datafs    = <<FormatarDataSQL(THIS.this_dDatafs)>>,
                    ddretros  = <<FormatarNumeroSQL(THIS.this_nDdretros, 0)>>,
                    ddfutus   = <<FormatarNumeroSQL(THIS.this_nDdfutus, 0)>>,
                    DtiConts  = <<FormatarDataSQL(THIS.this_dDtiConts)>>,
                    chkconcs  = <<FormatarNumeroSQL(THIS.this_nChkConcs, 0)>>,
                    dtgdmis   = GETDATE()
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar par" + CHR(226) + "metros de bloqueio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SigOpBloBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

