# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (4)
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [GRID-WITH] Bloco WITH loc_oGrid define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrid.RecordSource).
- [LAYOUT-POSITION] Controle 'Optiongroup1' (parent: SIGOPARQ): Top original=166 vs migrado 'obj_4c_Optiongroup1' Top=7 (diff=159px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup1' (parent: SIGOPARQ): Left original=202 vs migrado 'obj_4c_Optiongroup1' Left=5 (diff=197px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpArq.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (885 linhas total):

*-- Linhas 6 a 241:
6: *         Lparameters poForm, operando sobre o cursor crGerArq compartilhado
7: *         por DataSession com o form pai). Migrado standalone, com BO proprio
8: *         (SigOpArqBO) que busca os itens exportaveis (Linhas/Grupos de
9: *         Produto, conforme Optiongroup1) direto do SQL Server para
10: *         cursor_4c_Dados.
11: *
12: * Fase 3/8: estrutura base (DEFINE CLASS, Init, InicializarForm, cabecalho,
13: * Destroy, TornarControlesVisiveis).
14: *
15: * Fase 4/8: Grid1 (grd_4c_Dados, 3 colunas: marca/arquivo/descricao) e
16: * Commandgroup1 (cmg_4c_Botoes: Gerar/Encerrar) + CarregarLista(). Este
17: * form NAO eh CRUD - nao tem Page1=Lista/Page2=Dados nem botoes
18: * Incluir/Alterar/Excluir (o legado SIGOPARQ.SCX nao os tem).
19: *
20: * Fase 5/8: Optiongroup1 (obj_4c_Optiongroup1: Linha / Grupo de Produto) e
21: * Label1 (lbl_4c_Label1: "Exportacao do Setor :"). Sao os dois unicos
22: * objetos visuais que faltavam no legado (ja cobre 100% da arvore do
23: * dump).
24: *
25: * Fase 6/8: fiacao dos eventos interativos que faltavam. Este form NAO tem
26: * nenhum TextBox de campo digitavel (os Text1 das Columns2/3 sao so
27: * leitura) e o dump nao contem fwBuscaExt/fwBuscaSel/sigacess em lugar
28: * nenhum - NAO HA lookup F4/F5 para implementar (analise.json.lookups = []).
29: * O trabalho real desta fase eh completar os 4 PROCEDUREs do
30: * comportamento.json ainda sem handler no migrado:
31: *   - Grid1.Column1.Check1.InteractiveChange -> chk_4c_Marca (toggle manual
32: *     via KeyPress/MouseUp/MouseDown/Click + NODEFAULT, regra do projeto
33: *     para CheckBox dentro de Column de Grid nao alternar pelo binding
34: *     nativo quando a coluna destino eh NUMERIC)
35: *   - Optiongroup1.InteractiveChange -> obj_4c_Optiongroup1
36: *   - Commandgroup1.Command1.Click (Gerar) -> Buttons(1)
37: *   - Commandgroup1.Command2.Click (Encerrar) -> Buttons(2)
38: *
39: * A cadeia de validacao do destino que o legado embutia no proprio
40: * InteractiveChange (destino vazio -> pasta invalida -> nome ja informado)
41: * fica em ValidarArquivoDestino(), metodo nomeado e PUBLIC: eh o
42: * equivalente, neste layout flat sem Page2 de Dados, do Valid de celula
43: * que os forms com campo digitavel tem. A marcacao do item e as duas
44: * ultimas checagens continuam com FONTE UNICA no BO.
45: *
46: * Fase 7/8: eventos principais dos botoes - CONFIRMADO completo. O legado
47: * SIGOPARQ.SCX nao tem Incluir/Alterar/Visualizar/Excluir (nao eh CRUD);
48: * os unicos botoes de acao do form sao Commandgroup1.Command1 ("Gerar") e
49: * Commandgroup1.Command2 ("Encerrar"), e os dois ja tem handler completo
50: * (BtnGerarClick/BtnEncerrarClick, fiados na Fase 6 junto com o toggle do
51: * Check1 e o InteractiveChange do Optiongroup1). Nenhum evento principal
52: * adicional a implementar nesta fase.
53: *
54: * Fase 8/8: eventos auxiliares e consolidacao final. Entregas desta fase:
55: *   - FormParaBO()/BOParaForm(): os dois hooks canonicos, com conteudo REAL.
56: *     O unico campo editavel da tela (Optiongroup1 "Exportacao do Setor") vai
57: *     para SigOpArqBO.this_nTipos e volta dele - o destino que no legado era
58: *     ThisForm.ParentForm.pnTipos. FormParaBO virou a FONTE UNICA dessa
59: *     transferencia (OptTiposInteractiveChange e BtnConfirmarClick passam por
60: *     ele); BOParaForm roda na abertura, refletindo o this_nTipos = 1 com que
61: *     o BO nasce (o "ParentForm.pnTipos = 1" do Init legado).
62: *   - BtnConfirmarClick()/BtnCancelarClick(): o CORPO de cada um dos dois
63: *     Click do Commandgroup1, sem o fechamento da janela, devolvendo .T./.F.
64: *     Os handlers fiados no BINDEVENT continuam nomeados pelo botao do legado
65: *     (BtnGerarClick/BtnEncerrarClick, Captions "Gerar"/"Encerrar" intactos -
66: *     PILAR 1) e apenas decidem fechar conforme o resultado. O Command2 do
67: *     legado nao eh um "sair" puro: antes do Release Windows ele faz
68: *     "Replace All nMarcas With 0", isto eh, CANCELA a selecao da grade - dai
69: *     o nome canonico ter conteudo de verdade aqui.
70: *
71: * Conferencia contra comportamento.json (6 metodos do dump legado):
72: *   1) SIGOPARQ.Procedure (=fConfigGeral())  -> no-op global via
73: *      utils\fconfiggeral.prg (regra do projeto: so para p-code legado
74: *      compilado; FormBase AS form nosso nao herda VCX nenhum, entao este
75: *      form nem chega a chamar fConfigGeral - nao se aplica aqui).
76: *   2) SIGOPARQ.Init (Lparameters poForm / captions / DataSessionId /
77: *      ParentForm.pnTipos=1 / crGerArq Go Top) -> standalone no migrado
78: *      (sem ParentForm/crGerArq compartilhado): captions em
79: *      ConfigurarPageFrame(), this_nTipos=1 no Init do BO,
80: *      cursor_4c_Dados.Go Top em CarregarLista().
81: *   3) Grid1.Column1.Check1.InteractiveChange -> ChkMarca* (KeyPress/
82: *      MouseUp/MouseDown/Click) + ValidarArquivoDestino() + ChkMarcaToggleExec().
83: *   4) Commandgroup1.Command1.Click (Gerar)    -> BtnConfirmarClick()
84: *      (validar + confirmar) + BtnGerarClick() (fechar).
85: *   5) Commandgroup1.Command2.Click (Encerrar) -> BtnCancelarClick()
86: *      (confirmar + Replace All) + BtnEncerrarClick() (fechar).
87: *   6) Optiongroup1.InteractiveChange -> OptTiposInteractiveChange().
88: *
89: * O que NAO se aplica a este layout, e por que: este form OPERACIONAL eh um
90: * dialogo de 1 tela (grid + checkbox + optiongroup + 2 botoes) sem Page1=
91: * Lista/Page2=Dados, sem modo INCLUIR/ALTERAR/VISUALIZAR e sem campos de
92: * cadastro. O dump legado nao tem botao de busca, nem botao de gravar, nem
93: * troca de modo - logo BtnBuscarClick, BtnSalvarClick, HabilitarCampos,
94: * LimparCampos e AjustarBotoesPorModo nao tem a que se referir aqui.
95: * Cria-los seria inventar funcionalidade ausente no original (viola o
96: * PILAR 1) ou deixar metodo vazio (proibido pela regra de completude).
97: * CarregarLista() existe desde a Fase 4 e cobre o papel de popular a grade.
98: *==============================================================================
99: 
100: DEFINE CLASS FormSigOpArq AS FormBase
101: 
102:     *-- Layout (pixel-perfect do legado SIGOPARQ.SCX)
103:     Width       = 800
104:     Height      = 200
105:     AutoCenter  = .T.
106:     BorderStyle = 2
107:     TitleBar    = 0
108:     ControlBox  = .F.
109:     Closable    = .F.
110:     MaxButton   = .F.
111:     MinButton   = .F.
112:     WindowType  = 1
113:     ShowWindow  = 1
114:     Themes      = .F.
115: 
116:     *-- Propriedades de estado
117:     this_oBusinessObject = .NULL.
118:     this_cMensagemErro    = ""
119: 
120:     *==========================================================================
121:     * Init - APENAS DODEFAULT (FormBase chama InicializarForm)
122:     *==========================================================================
123:     PROCEDURE Init()
124:         RETURN DODEFAULT()
125:     ENDPROC
126: 
127:     *==========================================================================
128:     * InicializarForm - Construcao completa do form
129:     *==========================================================================
130:     PROTECTED PROCEDURE InicializarForm()
131:         LOCAL loc_lSucesso, loc_oErro
132:         loc_lSucesso = .F.
133: 
134:         TRY
135:             *-- Cria Business Object
136:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpArqBO")
137: 
138:             THIS.Caption = "Gera" + CHR(231) + CHR(227) + "o de Arquivos"
139: 
140:             *-- Constroi os controles visuais (cabecalho + Grid + botoes de
141:             *-- acao nesta fase; OptionGroup/Label entram na Fase 5-6)
142:             THIS.ConfigurarControles()
143: 
144:             *-- Torna visiveis os controles ja criados
145:             THIS.TornarControlesVisiveis(THIS)
146: 
147:             *-- Estado inicial do BO (SigOpArqBO.Init faz this_nTipos = 1, o
148:             *-- mesmo "ThisForm.ParentForm.pnTipos = 1" do Init legado) refletido
149:             *-- no unico campo editavel da tela. Chamado DEPOIS de
150:             *-- ConfigurarControles porque o Optiongroup1 so existe a partir dela.
151:             THIS.BOParaForm()
152: 
153:             *-- Popula a grade (pulado em validacao de UI/teste automatizado,
154:             *-- que nao tem conexao SQL - mesmo padrao de FormSigOpAlC)
155:             IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
156:                     (TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste)
157:                 THIS.CarregarLista()
158:             ENDIF
159: 
160:             loc_lSucesso = .T.
161: 
162:         CATCH TO loc_oErro
163:             MsgErro(loc_oErro.Message, "Erro em InicializarForm")
164:             loc_lSucesso = .F.
165:         ENDTRY
166: 
167:         RETURN loc_lSucesso
168:     ENDPROC
169: 
170:     *==========================================================================
171:     * ConfigurarControles - Ponto unico de construcao dos objetos visuais do
172:     * form. Cada fase da migracao acrescenta aqui dentro a sua parte.
173:     *==========================================================================
174:     PROTECTED PROCEDURE ConfigurarControles()
175:         *-- Frame fixo do topo (cabecalho)
176:         THIS.ConfigurarPageFrame()
177: 
178:         *-- Grid1 do legado: lista de itens exportaveis (Fase 4)
179:         THIS.ConfigurarGrid()
180: 
181:         *-- Commandgroup1 do legado: botoes Gerar/Encerrar (Fase 4). Criado
182:         *-- DEPOIS do cabecalho para desenhar por cima dele (regra #11),
183:         *-- igual ao padrao cnt_4c_Botoes dos forms CRUD.
184:         THIS.ConfigurarBotoes()
185: 
186:         *-- Optiongroup1/Label1 do legado: seletor do tipo de item exportavel
187:         *-- (Fase 5)
188:         THIS.ConfigurarCampos()
189:     ENDPROC
190: 
191:     *==========================================================================
192:     * ConfigurarGrid - Grid1 do legado (SIGOPARQ.Grid1): lista os itens
193:     * exportaveis (Linha ou Grupo de Produto, conforme Optiongroup1/
194:     * this_nTipos) com uma coluna de marcacao (Check1) e duas colunas de
195:     * texto (Column2 = arquivo de destino escolhido, Column3 = descricao
196:     * do item). Liga em cursor_4c_Dados - criado aqui como placeholder com
197:     * a MESMA estrutura que SigOpArqBO.CarregarItensGrade usa, para o
198:     * Column.ControlSource ja poder ser definido nesta fase (regra: nunca
199:     * ControlSource de cursor que ainda nao existe).
200:     *==========================================================================
201:     PROTECTED PROCEDURE ConfigurarGrid()
202:         LOCAL loc_oGrid
203: 
204:         IF !USED("cursor_4c_Dados")
205:             SET NULL ON
206:             CREATE CURSOR cursor_4c_Dados ;
207:                 (Codigos C(10), Descricao C(40), Marcas N(1,0), NomArqs C(254))
208:             SET NULL OFF
209:         ENDIF
210: 
211:         THIS.AddObject("grd_4c_Dados", "Grid")
212:         loc_oGrid = THIS.grd_4c_Dados
213: 
214:         WITH loc_oGrid
215:             .Top            = 85
216:             .Left           = 60
217:             .Width          = 469
218:             .Height         = 83
219:             .FontName       = "Tahoma"
220:             .FontSize       = 8
221:             .AllowRowSizing = .F.
222:             .DeleteMark     = .F.
223:             .RecordMark     = .F.
224:             .RowHeight      = 16
225:             .ScrollBars     = 2
226:             .GridLineColor  = RGB(238, 238, 238)
227:             .ColumnCount    = 3
228:             .RecordSource   = "cursor_4c_Dados"
229: 
230:             *-- Column1 = Check1 ("Marcas") - ColumnOrder=3, ou seja exibida
231:             *-- por ULTIMO (a direita), fiel ao dump do SCX legado
232:             .Column1.ControlSource = "cursor_4c_Dados.Marcas"
233:             .Column1.ColumnOrder   = 3
234:             .Column1.Width         = 20
235:             .Column1.Movable       = .F.
236:             .Column1.Resizable     = .F.
237:             .Column1.ReadOnly      = .F.
238:             .Column1.Sparse        = .F.
239:             .Column1.FontName      = "Tahoma"
240:             .Column1.FontSize      = 8
241:             .Column1.Header1.Caption   = ""

*-- Linhas 263 a 309:
263:             *-- nativo quando a coluna destino eh NUMERIC (Marcas N(1,0)) -
264:             *-- toggle manual via KeyPress/MouseUp, com MouseDown/Click so
265:             *-- para suprimir o toggle nativo (NODEFAULT nos 4).
266:             BINDEVENT(.Column1.chk_4c_Marca, "KeyPress",   THIS, "ChkMarcaKeyPress")
267:             BINDEVENT(.Column1.chk_4c_Marca, "MouseUp",    THIS, "ChkMarcaMouseUp")
268:             BINDEVENT(.Column1.chk_4c_Marca, "MouseDown",  THIS, "ChkMarcaMouseDown")
269:             BINDEVENT(.Column1.chk_4c_Marca, "Click",      THIS, "ChkMarcaClick")
270: 
271:             *-- Column2 = Text1 ("Arquivo") - ColumnOrder=1, exibida primeiro
272:             *-- (a esquerda). Mostra o caminho escolhido via PutFile ao
273:             *-- marcar o Check1 (NomArqs) - so leitura na grade.
274:             .Column2.ControlSource = "cursor_4c_Dados.NomArqs"
275:             .Column2.ColumnOrder   = 1
276:             .Column2.Width         = 111
277:             .Column2.Movable       = .F.
278:             .Column2.Resizable     = .F.
279:             .Column2.ReadOnly      = .T.
280:             .Column2.FontName      = "Tahoma"
281:             .Column2.FontSize      = 8
282:             .Column2.Header1.Caption   = "Arquivo"
283:             .Column2.Header1.Alignment = 2
284:             .Column2.Header1.FontName  = "Tahoma"
285:             .Column2.Header1.FontSize  = 8
286:             .Column2.Header1.ForeColor = RGB(36, 84, 155)
287:             .Column2.Text1.BorderStyle = 0
288:             .Column2.Text1.Margin      = 0
289:             .Column2.Text1.ForeColor   = RGB(0, 0, 0)
290:             .Column2.Text1.BackColor   = RGB(255, 255, 255)
291: 
292:             *-- Column3 = Text1 ("Nome do Arquivo") - ColumnOrder=2, exibida
293:             *-- ao centro. Mostra a descricao do item (Linha ou Grupo).
294:             .Column3.ControlSource = "cursor_4c_Dados.Descricao"
295:             .Column3.ColumnOrder   = 2
296:             .Column3.Width         = 338
297:             .Column3.Movable       = .F.
298:             .Column3.Resizable     = .F.
299:             .Column3.ReadOnly      = .T.
300:             .Column3.FontName      = "Tahoma"
301:             .Column3.FontSize      = 8
302:             .Column3.Header1.Caption   = "Nome do Arquivo"
303:             .Column3.Header1.Alignment = 2
304:             .Column3.Header1.FontName  = "Tahoma"
305:             .Column3.Header1.FontSize  = 8
306:             .Column3.Header1.ForeColor = RGB(36, 84, 155)
307:             .Column3.Text1.BorderStyle = 0
308:             .Column3.Text1.Margin      = 0
309:             .Column3.Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 319 a 362:
319:     * dialogo nao inclui/altera/exclui registro nenhum, so confirma ou
320:     * cancela a selecao de itens marcados na grade para exportacao.
321:     *==========================================================================
322:     PROTECTED PROCEDURE ConfigurarBotoes()
323:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
324:         WITH THIS.cmg_4c_Botoes
325:             .Top           = -2
326:             .Left          = 644
327:             .Width         = 160
328:             .Height        = 85
329:             .ButtonCount   = 2
330:             .BackStyle     = 0
331:             .BorderStyle   = 0
332:             .SpecialEffect = 1
333:             .BorderColor   = RGB(136, 189, 188)
334:             .Value         = 1
335: 
336:             WITH .Buttons(1)
337:                 .Top       = 5
338:                 .Left      = 5
339:                 .Width     = 75
340:                 .Height    = 75
341:                 .FontBold  = .T.
342:                 .FontItalic = .T.
343:                 .FontName  = "Comic Sans MS"
344:                 .FontSize  = 8
345:                 .WordWrap  = .T.
346:                 .Picture   = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
347:                 .Caption   = "Gerar"
348:                 .ForeColor = RGB(90, 90, 90)
349:                 .BackColor = RGB(255, 255, 255)
350:                 .Themes    = .F.
351:                 .Visible   = .T.
352:             ENDWITH
353: 
354:             WITH .Buttons(2)
355:                 .Top       = 5
356:                 .Left      = 80
357:                 .Width     = 75
358:                 .Height    = 75
359:                 .FontBold  = .T.
360:                 .FontItalic = .T.
361:                 .FontName  = "Comic Sans MS"
362:                 .FontSize  = 8

*-- Linhas 375 a 830:
375: 
376:         *-- Command1.Click/Command2.Click do legado: cada botao do
377:         *-- Commandgroup tem handler PROPRIO (nao um Click unico do grupo)
378:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnGerarClick")
379:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnEncerrarClick")
380:     ENDPROC
381: 
382:     *==========================================================================
383:     * ConfigurarCampos - Optiongroup1/Label1 do legado (SIGOPARQ.Optiongroup1
384:     * e SIGOPARQ.Label1): seletor do tipo de item exportavel para a grade
385:     * (1=Linha/SigCdLin, 2=Grupo de Produto/SigCdGrp - ver
386:     * SigOpArqBO.AtualizarTipoExportacao). Posicoes/legendas/largura
387:     * TRANSCRITAS do dump do SCX legado (regra #45 - OptionGroup: legenda,
388:     * ordem e Top de cada botao vem do dump, nunca inventados). Este form
389:     * nao usa PageFrame, entao os Tops do legado sao usados sem
390:     * compensacao de +29 (ja o caso dos demais controles deste form).
391:     *==========================================================================
392:     PROTECTED PROCEDURE ConfigurarCampos()
393:         THIS.AddObject("obj_4c_Optiongroup1", "OptionGroup")
394:         WITH THIS.obj_4c_Optiongroup1
395:             .Top           = 166
396:             .Left          = 202
397:             .Width         = 189
398:             .Height        = 28
399:             .ButtonCount   = 2
400:             .BackStyle     = 0
401:             .SpecialEffect = 1
402:             .BorderColor   = RGB(136, 189, 188)
403:             .Value         = 1
404: 
405:             *-- Buttons(1) = "Linha" (SigCdLin) - this_nTipos = 1
406:             WITH .Buttons(1)
407:                 .FontName  = "Comic Sans MS"
408:                 .FontSize  = 8
409:                 .BackStyle = 0
410:                 .Caption   = " Linha"
411:                 .Top       = 7
412:                 .Left      = 5
413:                 .Width     = 46
414:                 .Height    = 15
415:                 .AutoSize  = .T.
416:                 .ForeColor = RGB(90, 90, 90)
417:             ENDWITH
418: 
419:             *-- Buttons(2) = "Grupo de Produto" (SigCdGrp) - this_nTipos = 2
420:             WITH .Buttons(2)
421:                 .FontName  = "Comic Sans MS"
422:                 .FontSize  = 8
423:                 .BackStyle = 0
424:                 .Caption   = " Grupo de Produto"
425:                 .Top       = 7
426:                 .Left      = 63
427:                 .Width     = 106
428:                 .Height    = 15
429:                 .AutoSize  = .T.
430:                 .ForeColor = RGB(90, 90, 90)
431:             ENDWITH
432: 
433:             .Visible = .T.
434:         ENDWITH
435: 
436:         *-- Optiongroup1.InteractiveChange do legado (ThisForm.ParentForm.pnTipos
437:         *-- = This.Value): neste form standalone nao ha ParentForm, o
438:         *-- equivalente eh atualizar o tipo no BO e recarregar a grade.
439:         BINDEVENT(THIS.obj_4c_Optiongroup1, "InteractiveChange", THIS, "OptTiposInteractiveChange")
440: 
441:         *-- Label1 do legado: nao declara Width/Alignment no dump = classe
442:         *-- "say" pura (regra #23) -> AutoSize = .F. + Width/Height
443:         *-- transcritos do SCX (AutoSize = .T. e no-op em Label via AddObject)
444:         THIS.AddObject("lbl_4c_Label1", "Label")
445:         WITH THIS.lbl_4c_Label1
446:             .AutoSize  = .F.
447:             .Alignment = 0
448:             .FontName  = "Tahoma"
449:             .FontSize  = 8
450:             .BackStyle = 0
451:             .Caption   = "Exporta" + CHR(231) + CHR(227) + "o  do Setor :"
452:             .Top       = 172
453:             .Left      = 67
454:             .Width     = 111
455:             .Height    = 15
456:             .ForeColor = RGB(90, 90, 90)
457:             .Visible   = .T.
458:         ENDWITH
459:     ENDPROC
460: 
461:     *==========================================================================
462:     * CarregarLista - Popula cursor_4c_Dados via SigOpArqBO.Buscar() (SQL
463:     * para SigCdLin/SigCdGrp, conforme this_nTipos) e repinta a grade.
464:     * RecordSource/ControlSource ja foram definidos uma unica vez em
465:     * ConfigurarGrid() - aqui so GO TOP + Refresh (regra: popular cursor
466:     * nao repinta a grade sozinho).
467:     *==========================================================================
468:     PROCEDURE CarregarLista()
469:         LOCAL loc_lSucesso
470:         loc_lSucesso = .F.
471: 
472:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
473:             loc_lSucesso = THIS.this_oBusinessObject.Buscar("")
474:         ENDIF
475: 
476:         IF USED("cursor_4c_Dados")
477:             GO TOP IN cursor_4c_Dados
478:         ENDIF
479: 
480:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
481:             THIS.grd_4c_Dados.Refresh()
482:         ENDIF
483: 
484:         RETURN loc_lSucesso
485:     ENDPROC
486: 
487:     *==========================================================================
488:     * ValidarArquivoDestino - Cadeia de validacao do arquivo de destino, na
489:     * ordem EXATA de Grid1.Column1.Check1.InteractiveChange do legado:
490:     *
491:     *     If Not Empty(m.lcArqTxt)
492:     *         If Not fVerificaPasta(m.lcArqTxt,2) -> 'Local ou Arquivo Invalido !!!'
493:     *     Else                                    -> 'Destino Invalido !!!'
494:     *     Endif
495:     *     Locate for cNomArqs = m.lcArqTxt        -> 'Nome Arquivo Ja Informado !!!'
496:     *
497:     * Devolve .T. somente quando as TRES passam (e nesse caso o item ja fica
498:     * marcado com o destino escolhido, igual ao "Replace nMarcas With 1 /
499:     * cNomArqs With m.lcArqTxt" que fecha o metodo legado). Recusando,
500:     * devolve .F. e deixa em THIS.this_cMensagemErro a mensagem LITERAL do
501:     * legado, para o chamador exibir e desmarcar o item.
502:     *
503:     * PUBLIC de proposito: eh chamado pelos handlers de toggle do
504:     * chk_4c_Marca, que o BINDEVENT dispara de fora da classe (regra #3).
505:     *==========================================================================
506:     PROCEDURE ValidarArquivoDestino(par_cCaminhoArquivo)
507:         LOCAL loc_lValido
508:         loc_lValido = .F.
509:         THIS.this_cMensagemErro = ""
510: 
511:         DO CASE
512:             *-- Ramo "Else" do If Not Empty() legado: usuario cancelou o
513:             *-- PutFile (devolve string vazia) ou nao informou nome algum.
514:             CASE VARTYPE(par_cCaminhoArquivo) != "C" OR EMPTY(ALLTRIM(par_cCaminhoArquivo))
515:                 THIS.this_cMensagemErro = "Destino Inv" + CHR(225) + "lido !!!"
516: 
517:             CASE VARTYPE(THIS.this_oBusinessObject) != "O"
518:                 THIS.this_cMensagemErro = "Destino Inv" + CHR(225) + "lido !!!"
519: 
520:             *-- fVerificaPasta (pasta de destino) + "Locate for cNomArqs"
521:             *-- (nome ja informado em outra linha) + a marcacao do item: o BO
522:             *-- eh a FONTE UNICA das tres coisas e devolve em
523:             *-- this_cMensagemErro a mensagem exata do legado ao recusar.
524:             CASE !THIS.this_oBusinessObject.MarcarItemParaExportacao(par_cCaminhoArquivo)
525:                 THIS.this_cMensagemErro = THIS.this_oBusinessObject.this_cMensagemErro
526: 
527:             OTHERWISE
528:                 loc_lValido = .T.
529:         ENDCASE
530: 
531:         RETURN loc_lValido
532:     ENDPROC
533: 
534:     *==========================================================================
535:     * ChkMarcaToggleExec - Corpo unico chamado pelos 4 handlers de toggle do
536:     * chk_4c_Marca. Espelha Grid1.Column1.Check1.InteractiveChange do legado:
537:     * pede o arquivo de destino (PutFile) e submete a
538:     * THIS.ValidarArquivoDestino(); recusando, exibe a mensagem do legado e
539:     * deixa o item desmarcado, igual aos "Replace nMarcas With 0 / cNomArqs
540:     * With '' / This.Value = 0" de cada ramo de erro do metodo legado.
541:     *==========================================================================
542:     PROCEDURE ChkMarcaToggleExec()
543:         LOCAL loc_cArqTxt
544: 
545:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
546:             RETURN
547:         ENDIF
548: 
549:         loc_cArqTxt = PUTFILE("Arquivo :", "", "TXT")
550: 
551:         IF !THIS.ValidarArquivoDestino(loc_cArqTxt)
552:             *-- regra #20: o BO marca this_lErroExibido quando ele mesmo ja
553:             *-- exibiu a falha (CATCH com MsgErro) - repetir daria 2 dialogos
554:             IF VARTYPE(THIS.this_oBusinessObject) != "O" OR ;
555:                     !THIS.this_oBusinessObject.this_lErroExibido
556:                 MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
557:             ENDIF
558: 
559:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
560:                 THIS.this_oBusinessObject.DesmarcarItem()
561:             ENDIF
562:         ENDIF
563: 
564:         *-- "This.Parent.Refresh" do legado: sem isto a grade nao repinta a
565:         *-- marcacao nem o nome do arquivo recem-gravados no cursor (regra #21)
566:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
567:             THIS.grd_4c_Dados.Refresh()
568:         ENDIF
569:     ENDPROC
570: 
571:     PROCEDURE ChkMarcaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
572:         IF INLIST(par_nKeyCode, 13, 32)
573:             THIS.ChkMarcaToggleExec()
574:             NODEFAULT
575:         ENDIF
576:     ENDPROC
577: 
578:     PROCEDURE ChkMarcaMouseUp(par_nButton, par_nShiftAltCtrl, par_nRow, par_nColumn)
579:         THIS.ChkMarcaToggleExec()
580:         NODEFAULT
581:     ENDPROC
582: 
583:     PROCEDURE ChkMarcaMouseDown(par_nButton, par_nShiftAltCtrl, par_nRow, par_nColumn)
584:         NODEFAULT
585:     ENDPROC
586: 
587:     PROCEDURE ChkMarcaClick()
588:         NODEFAULT
589:     ENDPROC
590: 
591:     *==========================================================================
592:     * OptTiposInteractiveChange - Optiongroup1.InteractiveChange do legado.
593:     * Troca this_nTipos no BO (Linha/Grupo de Produto) e recarrega a grade
594:     * com o universo do tipo novo.
595:     *==========================================================================
596:     PROCEDURE OptTiposInteractiveChange()
597:         *-- FONTE UNICA da transferencia campo -> BO (ver FormParaBO abaixo)
598:         THIS.FormParaBO()
599: 
600:         THIS.CarregarLista()
601:     ENDPROC
602: 
603:     *==========================================================================
604:     * FormParaBO - Transfere o unico campo EDITAVEL da tela para o BO.
605:     *
606:     * Este dialogo nao tem campos de cadastro: o unico controle que o usuario
607:     * altera (alem da marcacao da grade, que o BO ja grava direto no cursor em
608:     * MarcarItemParaExportacao) eh o Optiongroup1 "Exportacao do Setor",
609:     * cujo Value o legado jogava em ThisForm.ParentForm.pnTipos. Migrado
610:     * standalone, o destino equivalente eh SigOpArqBO.this_nTipos, resolvido
611:     * por AtualizarTipoExportacao (que tambem acerta tabela/chave de origem).
612:     *
613:     * Value do OptionGroup eh o INDICE 1-based do botao marcado (regra #45):
614:     * 1 = Linha (SigCdLin), 2 = Grupo de Produto (SigCdGrp) - mapeamento
615:     * DIRETO, sem +1/-1.
616:     *
617:     * PROTECTED igual ao hook de FormBase (declarar sem modificador nao
618:     * alarga o escopo - o PROTECTED da classe base prevalece, regra #51);
619:     * chamado so de dentro desta classe, sempre com THIS.
620:     *==========================================================================
621:     PROTECTED PROCEDURE FormParaBO()
622:         LOCAL loc_lSucesso
623:         loc_lSucesso = .F.
624: 
625:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND PEMSTATUS(THIS, "obj_4c_Optiongroup1", 5)
626:             loc_lSucesso = THIS.this_oBusinessObject.AtualizarTipoExportacao(THIS.obj_4c_Optiongroup1.Value)
627:         ENDIF
628: 
629:         RETURN loc_lSucesso
630:     ENDPROC
631: 
632:     *==========================================================================
633:     * BOParaForm - Caminho inverso de FormParaBO: reflete this_nTipos do BO no
634:     * Optiongroup1. Usado na abertura (o Init do BO ja nasce com this_nTipos
635:     * = 1, o mesmo "ParentForm.pnTipos = 1" do Init legado).
636:     *
637:     * Guarda BETWEEN(...,1,2): OptionGroup eh 1-based e atribuir 0 deixaria o
638:     * grupo SEM botao marcado, estado que o legado nunca tem (Optiongroup1.
639:     * Value = 1 no SCX).
640:     *==========================================================================
641:     PROTECTED PROCEDURE BOParaForm()
642:         LOCAL loc_nTipos
643: 
644:         IF VARTYPE(THIS.this_oBusinessObject) != "O" OR !PEMSTATUS(THIS, "obj_4c_Optiongroup1", 5)
645:             RETURN .F.
646:         ENDIF
647: 
648:         loc_nTipos = THIS.this_oBusinessObject.this_nTipos
649:         IF VARTYPE(loc_nTipos) != "N" OR !BETWEEN(loc_nTipos, 1, 2)
650:             loc_nTipos = 1
651:         ENDIF
652: 
653:         THIS.obj_4c_Optiongroup1.Value = loc_nTipos
654: 
655:         RETURN .T.
656:     ENDPROC
657: 
658:     *==========================================================================
659:     * BtnGerarClick - Commandgroup1.Command1.Click (Gerar) do legado: exige
660:     * pelo menos um item marcado, confirma com o usuario e fecha o dialogo
661:     * ("Release Windows" no legado). A geracao real dos arquivos ficava a
662:     * cargo do form pai no legado (ver comentario de BtnGerarClick no BO);
663:     * quando este dialogo for aberto por um form pai com crSigCdBal aberto
664:     * (mesmo DataSession do legado), o codigo do balanco entra na mensagem
665:     * de confirmacao, igual ao legado - senao a confirmacao fica generica.
666:     *==========================================================================
667:     PROCEDURE BtnGerarClick()
668:         *-- "Release Windows" do legado so acontece quando a confirmacao passa
669:         IF THIS.BtnConfirmarClick()
670:             THIS.Release()
671:         ENDIF
672:     ENDPROC
673: 
674:     *==========================================================================
675:     * BtnConfirmarClick - CORPO de Commandgroup1.Command1.Click (Gerar), sem o
676:     * fechamento da janela. Eh a acao de verdade deste dialogo: exigir item
677:     * marcado e obter a confirmacao do usuario para a exportacao.
678:     *
679:     *     Locate for nMarcas = 1
680:     *     If Eof()  -> 'Geracao Nao Selecionada !!!' / Return
681:     *     If MessageBox('Confirma Exportacao do Inventario X?',36,'')==7 -> Return
682:     *     Release Windows
683:     *
684:     * O par Confirmar/Gerar espelha o par Cancelar/Encerrar logo abaixo: o
685:     * metodo nomeado pelo VERBO CANONICO carrega a regra (validar + confirmar)
686:     * e devolve .T./.F.; o metodo nomeado pelo BOTAO do legado (Caption
687:     * "Gerar", fiel ao PILAR 1) eh o que o BINDEVENT dispara e so decide
688:     * fechar. A separacao tambem deixa a confirmacao reutilizavel por quem
689:     * abrir este dialogo por programa, sem a janela no meio.
690:     *
691:     * PUBLIC: chamado por BtnGerarClick e podendo ser acionado de fora pelo
692:     * harness de teste (regra #3 - PEMSTATUS nao enxerga escopo).
693:     *==========================================================================
694:     PROCEDURE BtnConfirmarClick()
695:         LOCAL loc_lConfirmado, loc_cMsg
696:         loc_lConfirmado = .F.
697: 
698:         *-- O tipo escolhido no Optiongroup1 vai ao BO ANTES da acao (padrao
699:         *-- do projeto: FormParaBO abre todo caminho de acao)
700:         THIS.FormParaBO()
701: 
702:         DO CASE
703:             CASE VARTYPE(THIS.this_oBusinessObject) != "O" OR ;
704:                     !THIS.this_oBusinessObject.ExisteItemSelecionado()
705:                 MsgAviso("Gera" + CHR(231) + CHR(227) + "o N" + CHR(227) + "o Selecionada !!!", ;
706:                          "Aten" + CHR(231) + CHR(227) + "o")
707: 
708:             OTHERWISE
709:                 loc_cMsg = "Confirma Exporta" + CHR(231) + CHR(227) + "o do Invent" + CHR(225) + "rio"
710: 
711:                 *-- crSigCdBal eh o cursor do form PAI no legado (mesma
712:                 *-- DataSession). Aberto por quem chamou este dialogo, o
713:                 *-- codigo do balanco entra na mensagem igual ao legado;
714:                 *-- standalone, a confirmacao fica generica.
715:                 IF USED("crSigCdBal")
716:                     loc_cMsg = loc_cMsg + " " + ALLTRIM(STR(crSigCdBal.Codigos)) + "?"
717:                 ELSE
718:                     loc_cMsg = loc_cMsg + "?"
719:                 ENDIF
720: 
721:                 loc_lConfirmado = MsgConfirma(loc_cMsg, "Confirmar")
722:         ENDCASE
723: 
724:         RETURN loc_lConfirmado
725:     ENDPROC
726: 
727:     *==========================================================================
728:     * BtnEncerrarClick - Commandgroup1.Command2.Click (Encerrar) do legado:
729:     * se houver item marcado, confirma o cancelamento; confirmando (ou se
730:     * nao havia nada marcado), limpa todas as marcacoes e fecha o dialogo.
731:     *==========================================================================
732:     PROCEDURE BtnEncerrarClick()
733:         *-- "Release Windows" do legado so acontece quando o cancelamento eh
734:         *-- aceito (recusando, o legado faz Return e a tela CONTINUA aberta)
735:         IF THIS.BtnCancelarClick()
736:             THIS.Release()
737:         ENDIF
738:     ENDPROC
739: 
740:     *==========================================================================
741:     * BtnCancelarClick - CORPO de Commandgroup1.Command2.Click (Encerrar,
742:     * Cancel = .T. no SCX), sem o fechamento da janela.
743:     *
744:     *     Locate for nMarcas = 1
745:     *     If ! Eof()
746:     *         If MessageBox('Geracao Selecionada, Deseja Cancelar ???',36,'') = 7
747:     *             Return
748:     *     Replace All nMarcas With 0
749:     *     Release Windows
750:     *
751:     * O botao do legado NAO eh um "sair" puro: antes de fechar ele DESFAZ a
752:     * selecao inteira (Replace All nMarcas With 0) - ou seja, cancela o
753:     * trabalho feito na grade. Por isso o cancelamento tem metodo proprio com
754:     * o nome canonico, e BtnEncerrarClick (nome do botao no legado, Caption
755:     * "Encerrar" preservado pelo PILAR 1) so decide fechar conforme o
756:     * resultado.
757:     *
758:     * Devolve .F. quando o usuario recusa o cancelamento - nesse caso nada eh
759:     * desmarcado e a tela permanece aberta, exatamente como o Return do
760:     * legado.
761:     *==========================================================================
762:     PROCEDURE BtnCancelarClick()
763:         LOCAL loc_lCancelar
764:         loc_lCancelar = .T.
765: 
766:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND THIS.this_oBusinessObject.ExisteItemSelecionado()
767:             loc_lCancelar = MsgConfirma("Gera" + CHR(231) + CHR(227) + "o Selecionada, Deseja Cancelar ???", ;
768:                                         "Confirmar")
769:         ENDIF
770: 
771:         IF loc_lCancelar
772:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
773:                 THIS.this_oBusinessObject.LimparSelecoes()
774:             ENDIF
775: 
776:             *-- regra #21: limpar o cursor nao repinta a grade sozinho
777:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
778:                 THIS.grd_4c_Dados.Refresh()
779:             ENDIF
780:         ENDIF
781: 
782:         RETURN loc_lCancelar
783:     ENDPROC
784: 
785:     *==========================================================================
786:     * ConfigurarPageFrame - Container cabecalho (cntSombra do legado): fundo
787:     * cinza + labels de titulo. Forms OPERACIONAIS nao usam PageFrame de
788:     * abas CRUD; este metodo agrupa a faixa fixa do topo do form.
789:     *==========================================================================
790:     PROTECTED PROCEDURE ConfigurarPageFrame()
791:         THIS.AddObject("cnt_4c_Sombra", "Container")
792:         WITH THIS.cnt_4c_Sombra
793:             .Top         = 0
794:             .Left        = 0
795:             .Width       = THIS.Width
796:             .Height      = 80
797:             .BackStyle   = 1
798:             .BackColor   = RGB(100, 100, 100)
799:             .BorderWidth = 0
800:             .Visible     = .T.
801: 
802:             .AddObject("lbl_4c_Sombra", "Label")
803:             WITH .lbl_4c_Sombra
804:                 .Top       = 18
805:                 .Left      = 10
806:                 .Width     = THIS.Width
807:                 .Height    = 40
808:                 .FontBold  = .T.
809:                 .FontName  = "Tahoma"
810:                 .FontSize  = 18
811:                 .BackStyle = 0
812:                 .ForeColor = RGB(0, 0, 0)
813:                 .WordWrap  = .T.
814:                 .Alignment = 0
815:                 .Caption   = THIS.Caption
816:                 .Visible   = .T.
817:             ENDWITH
818: 
819:             .AddObject("lbl_4c_Titulo", "Label")
820:             WITH .lbl_4c_Titulo
821:                 .Top       = 17
822:                 .Left      = 10
823:                 .Width     = THIS.Width
824:                 .Height    = 46
825:                 .FontBold  = .T.
826:                 .FontName  = "Tahoma"
827:                 .FontSize  = 18
828:                 .BackStyle = 0
829:                 .ForeColor = RGB(255, 255, 255)
830:                 .WordWrap  = .T.

*-- Linhas 839 a 885:
839:     * Destroy - fecha cursores locais e preserva o fix de menu (DODEFAULT
840:     * chama FormBase.Destroy)
841:     *==========================================================================
842:     PROCEDURE Destroy()
843:         IF USED("cursor_4c_Dados")
844:             USE IN cursor_4c_Dados
845:         ENDIF
846:         IF USED("cursor_4c_ItensExpTemp")
847:             USE IN cursor_4c_ItensExpTemp
848:         ENDIF
849: 
850:         DODEFAULT()
851:     ENDPROC
852: 
853:     *==========================================================================
854:     * TornarControlesVisiveis - Torna visiveis todos os controles do form
855:     * recursivamente. Este form OPERACIONAL nao tem containers flutuantes
856:     * (Visible=.F. toggled por botao) no layout do legado - todos os
857:     * controles ficam visiveis desde a abertura.
858:     *==========================================================================
859:     PROCEDURE TornarControlesVisiveis(par_oContainer)
860:         LOCAL loc_nI, loc_nJ, loc_oObjeto
861: 
862:         IF VARTYPE(par_oContainer) != "O"
863:             RETURN
864:         ENDIF
865: 
866:         FOR loc_nI = 1 TO par_oContainer.ControlCount
867:             loc_oObjeto = par_oContainer.Controls(loc_nI)
868: 
869:             IF PEMSTATUS(loc_oObjeto, "Visible", 5)
870:                 loc_oObjeto.Visible = .T.
871:             ENDIF
872: 
873:             IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
874:                 THIS.TornarControlesVisiveis(loc_oObjeto)
875:             ENDIF
876: 
877:             IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
878:                 FOR loc_nJ = 1 TO loc_oObjeto.PageCount
879:                     THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nJ))
880:                 ENDFOR
881:             ENDIF
882:         ENDFOR
883:     ENDPROC
884: 
885: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpArqBO.prg):
*==============================================================================
* SigOpArqBO.prg - Business Object para Geracao de Arquivos (Exportacao)
* Form OPERACIONAL - nao segue padrao CRUD Page1=Lista/Page2=Dados
* Legado: SIGOPARQ.SCX (form filho, compartilhava DataSession com o form pai
*         via Lparameters poForm e operava sobre o cursor crGerArq)
* Tabela principal de referencia (dinamica conforme Tipos): SigCdLin / SigCdGrp
*==============================================================================

DEFINE CLASS SigOpArqBO AS BusinessBase

    *-- Tipo de exportacao selecionado (Optiongroup1.Value / ParentForm.pnTipos)
    *-- 1 = Linha (SigCdLin, chave linhas)
    *-- 2 = Grupo de Produto (SigCdGrp, chave cgrus)
    this_nTipos = 1

    *--------------------------------------------------------------------------
    * DECISAO DE PROJETO: BO somente-leitura no SQL Server
    *
    * O dump do legado (SigOpArq_form_codigo_fonte.txt) nao grava em nenhuma
    * tabela remota. Os unicos Replace do form (Check1.InteractiveChange e
    * Commandgroup1.Command2.Click) alteram so o cursor LOCAL crGerArq,
    * compartilhado por DataSession com o form pai (Lparameters poForm +
    * ThisForm.DataSessionId = poForm.DataSessionId). O botao "Gerar"
    * (Command1.Click) apenas valida a selecao e confirma com o usuario,
    * terminando em "Release Windows" - sem nenhum Insert/Update/Delete. A
    * gravacao real dos arquivos fica a cargo do form pai, depois deste
    * dialogo fechar.
    *
    * Por isso este BO nao sobrescreve Inserir()/Atualizar() - o
    * comportamento herdado de BusinessBase (que recusa a gravacao) ja eh o
    * correto aqui. CarregarDoCursor() so mapeia this_nTipos (abaixo). A
    * "gravacao" deste form inteira em cursor_4c_Dados (equivalente local a
    * crGerArq) acontece via MarcarItemParaExportacao/DesmarcarItem/
    * LimparSelecoes.
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * Init - Inicializa Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.AtualizarTipoExportacao(1)

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTipoExportacao - Troca o tipo de item exportavel (Optiongroup1)
    * e a tabela/chave correspondente. Espelha Optiongroup1.InteractiveChange
    * do legado (ThisForm.ParentForm.pnTipos = This.Value), mas resolve aqui
    * tambem a tabela de origem, que no legado o form pai conhecia de fora.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarTipoExportacao(par_nTipos)
        IF VARTYPE(par_nTipos) != "N" OR !INLIST(par_nTipos, 1, 2)
            RETURN .F.
        ENDIF

        THIS.this_nTipos = par_nTipos

        IF THIS.this_nTipos = 2
            THIS.this_cTabela     = "SigCdGrp"
            THIS.this_cCampoChave = "cgrus"
        ELSE
            THIS.this_cTabela     = "SigCdLin"
            THIS.this_cCampoChave = "linhas"
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega this_nTipos de um cursor externo (padrao
    * generico de BusinessBase). Este BO nao tem outras propriedades escalares
    * de entidade - os dados de grade vivem em cursor_4c_Dados, tratado pelos
    * metodos de Buscar/Marcar abaixo.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        IF TYPE(par_cAliasCursor + ".tipos") != "U"
            THIS.AtualizarTipoExportacao(NVL(EVALUATE(par_cAliasCursor + ".tipos"), 1))
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Popula cursor_4c_Dados com os itens exportaveis do tipo
    * corrente (this_nTipos). Nao ha conceito de filtro no legado (o Grid1
    * sempre lista o universo inteiro do tipo escolhido no Optiongroup1) -
    * par_cFiltro existe so para manter a assinatura canonica do projeto.
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        IF THIS.this_nTipos = 2
            RETURN THIS.BuscarGrupos()
        ENDIF

        RETURN THIS.BuscarLinhas()
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarLinhas - Itens exportaveis quando this_nTipos = 1 (SigCdLin)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarLinhas()
        LOCAL loc_cSQL
        loc_cSQL = "SELECT linhas AS Codigos, descs AS Descricao " + ;
                   "FROM SigCdLin " + ;
                   "ORDER BY descs"

        RETURN THIS.CarregarItensGrade(loc_cSQL)
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarGrupos - Itens exportaveis quando this_nTipos = 2 (SigCdGrp)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarGrupos()
        LOCAL loc_cSQL
        loc_cSQL = "SELECT cgrus AS Codigos, dgrus AS Descricao " + ;
                   "FROM SigCdGrp " + ;
                   "ORDER BY dgrus"

        RETURN THIS.CarregarItensGrade(loc_cSQL)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarItensGrade - Executa par_cSQL num cursor TEMPORARIO e rebalanca
    * cursor_4c_Dados a partir dele, preservando a estrutura (Marcas/NomArqs)
    * que o Grid da pagina usa - nunca SQLEXEC direto no alias do Grid (regra
    * do projeto: SQLEXEC sobre alias ligado a Grid zera o ColumnCount).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarItensGrade(par_cSQL)
        LOCAL loc_lResultado, loc_nResultado, loc_cCursorTemp
        loc_lResultado  = .F.
        loc_cCursorTemp = "cursor_4c_ItensExpTemp"

        TRY
            IF USED(loc_cCursorTemp)
                USE IN (loc_cCursorTemp)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, par_cSQL, loc_cCursorTemp)

            IF loc_nResultado >= 0
                IF USED("cursor_4c_Dados")
                    SELECT cursor_4c_Dados
                    ZAP
                    APPEND FROM DBF(loc_cCursorTemp)
                ELSE
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ;
                        (Codigos C(10), Descricao C(40), Marcas N(1,0), NomArqs C(254))
                    SET NULL OFF
                    SELECT cursor_4c_Dados
                    APPEND FROM DBF(loc_cCursorTemp)
                ENDIF

                REPLACE ALL Marcas WITH 0, NomArqs WITH "" IN cursor_4c_Dados
                GO TOP IN cursor_4c_Dados

                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar itens para exporta" + CHR(231) + CHR(227) + "o: " + CapturarErroSQL()
                MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

            IF USED(loc_cCursorTemp)
                USE IN (loc_cCursorTemp)
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro: " + loException.Message
            MostrarErro(THIS.this_cMensagemErro, "SigOpArqBO.CarregarItensGrade")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarItemParaExportacao - Espelha Check1.InteractiveChange do legado:
    * valida a pasta de destino (DIRECTORY()/MD direto - fverificapasta.prg eh
    * wrapper so para p-code legado compilado, regra do projeto), recusa nome
    * de arquivo repetido entre as linhas e marca o item corrente da grade.
    *--------------------------------------------------------------------------
    PROCEDURE MarcarItemParaExportacao(par_cCaminhoArquivo)
        LOCAL loc_lResultado, loc_cPasta, loc_nRecnoAtual, loc_cCaminho
        loc_lResultado = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            THIS.this_cMensagemErro = "Nenhum item selecionado na grade."
            RETURN .F.
        ENDIF

        IF VARTYPE(par_cCaminhoArquivo) != "C" OR EMPTY(ALLTRIM(par_cCaminhoArquivo))
            THIS.this_cMensagemErro = "Destino Inv" + CHR(225) + "lido !!!"
            RETURN .F.
        ENDIF

        loc_cCaminho = ALLTRIM(par_cCaminhoArquivo)
        loc_cPasta   = JUSTPATH(loc_cCaminho)

        TRY
            IF !EMPTY(loc_cPasta) AND !DIRECTORY(loc_cPasta)
                MD (loc_cPasta)
            ENDIF

            IF !EMPTY(loc_cPasta) AND !DIRECTORY(loc_cPasta)
                THIS.this_cMensagemErro = "Local ou Arquivo Inv" + CHR(225) + "lido !!!"
            ELSE
                SELECT cursor_4c_Dados
                loc_nRecnoAtual = RECNO()

                LOCATE FOR ALLTRIM(NomArqs) == loc_cCaminho AND RECNO() != loc_nRecnoAtual
                IF FOUND()
                    THIS.this_cMensagemErro = "Nome Arquivo J" + CHR(225) + " Informado !!!"
                    GOTO loc_nRecnoAtual
                ELSE
                    GOTO loc_nRecnoAtual
                    REPLACE Marcas WITH 1, NomArqs WITH loc_cCaminho
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao validar destino: " + loException.Message
            MsgErro(THIS.this_cMensagemErro, "SigOpArqBO.MarcarItemParaExportacao")
            *-- regra #20: ja mostrou a falha - o chamador nao deve repetir
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarItem - Desfaz a marcacao do item corrente da grade (usado
    * quando a validacao falha, espelhando os "Replace nMarcas With 0" do
    * legado dentro do proprio InteractiveChange).
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarItem()
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            RETURN .F.
        ENDIF

        REPLACE Marcas WITH 0, NomArqs WITH "" IN cursor_4c_Dados

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExisteItemSelecionado - Espelha "Locate for nMarcas = 1" do
    * Commandgroup1.Command1/Command2.Click (botoes Gerar/Encerrar).
    *--------------------------------------------------------------------------
    PROCEDURE ExisteItemSelecionado()
        LOCAL loc_nRecnoAtual, loc_lResultado
        loc_lResultado = .F.

        IF USED("cursor_4c_Dados")
            loc_nRecnoAtual = RECNO("cursor_4c_Dados")

            SELECT cursor_4c_Dados
            LOCATE FOR Marcas = 1
            loc_lResultado = FOUND()

            IF BETWEEN(loc_nRecnoAtual, 1, RECCOUNT("cursor_4c_Dados"))
                GOTO loc_nRecnoAtual
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparSelecoes - Espelha "Replace All nMarcas With 0" do
    * Commandgroup1.Command2.Click (Encerrar, apos confirmar o cancelamento).
    *--------------------------------------------------------------------------
    PROCEDURE LimparSelecoes()
        IF !USED("cursor_4c_Dados")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        REPLACE ALL Marcas WITH 0, NomArqs WITH ""
        GO TOP

        RETURN .T.
    ENDPROC

ENDDEFINE

