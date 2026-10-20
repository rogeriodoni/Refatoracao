# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpArq.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (891 linhas total):

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
214:         *-- ColumnCount/RecordSource FORA do WITH (referencia explicita): o
215:         *-- WITH seguinte acessa .Column1/.Column2/.Column3, e as colunas so
216:         *-- existem depois que estas duas propriedades ja tiverem rodado.
217:         loc_oGrid.ColumnCount  = 3
218:         loc_oGrid.RecordSource = "cursor_4c_Dados"
219: 
220:         WITH loc_oGrid
221:             .Top            = 85
222:             .Left           = 60
223:             .Width          = 469
224:             .Height         = 83
225:             .FontName       = "Tahoma"
226:             .FontSize       = 8
227:             .AllowRowSizing = .F.
228:             .DeleteMark     = .F.
229:             .RecordMark     = .F.
230:             .RowHeight      = 16
231:             .ScrollBars     = 2
232:             .GridLineColor  = RGB(238, 238, 238)
233: 
234:             *-- Column1 = Check1 ("Marcas") - ColumnOrder=3, ou seja exibida
235:             *-- por ULTIMO (a direita), fiel ao dump do SCX legado
236:             .Column1.ControlSource = "cursor_4c_Dados.Marcas"
237:             .Column1.ColumnOrder   = 3
238:             .Column1.Width         = 20
239:             .Column1.Movable       = .F.
240:             .Column1.Resizable     = .F.
241:             .Column1.ReadOnly      = .F.

*-- Linhas 267 a 313:
267:             *-- nativo quando a coluna destino eh NUMERIC (Marcas N(1,0)) -
268:             *-- toggle manual via KeyPress/MouseUp, com MouseDown/Click so
269:             *-- para suprimir o toggle nativo (NODEFAULT nos 4).
270:             BINDEVENT(.Column1.chk_4c_Marca, "KeyPress",   THIS, "ChkMarcaKeyPress")
271:             BINDEVENT(.Column1.chk_4c_Marca, "MouseUp",    THIS, "ChkMarcaMouseUp")
272:             BINDEVENT(.Column1.chk_4c_Marca, "MouseDown",  THIS, "ChkMarcaMouseDown")
273:             BINDEVENT(.Column1.chk_4c_Marca, "Click",      THIS, "ChkMarcaClick")
274: 
275:             *-- Column2 = Text1 ("Arquivo") - ColumnOrder=1, exibida primeiro
276:             *-- (a esquerda). Mostra o caminho escolhido via PutFile ao
277:             *-- marcar o Check1 (NomArqs) - so leitura na grade.
278:             .Column2.ControlSource = "cursor_4c_Dados.NomArqs"
279:             .Column2.ColumnOrder   = 1
280:             .Column2.Width         = 111
281:             .Column2.Movable       = .F.
282:             .Column2.Resizable     = .F.
283:             .Column2.ReadOnly      = .T.
284:             .Column2.FontName      = "Tahoma"
285:             .Column2.FontSize      = 8
286:             .Column2.Header1.Caption   = "Arquivo"
287:             .Column2.Header1.Alignment = 2
288:             .Column2.Header1.FontName  = "Tahoma"
289:             .Column2.Header1.FontSize  = 8
290:             .Column2.Header1.ForeColor = RGB(36, 84, 155)
291:             .Column2.Text1.BorderStyle = 0
292:             .Column2.Text1.Margin      = 0
293:             .Column2.Text1.ForeColor   = RGB(0, 0, 0)
294:             .Column2.Text1.BackColor   = RGB(255, 255, 255)
295: 
296:             *-- Column3 = Text1 ("Nome do Arquivo") - ColumnOrder=2, exibida
297:             *-- ao centro. Mostra a descricao do item (Linha ou Grupo).
298:             .Column3.ControlSource = "cursor_4c_Dados.Descricao"
299:             .Column3.ColumnOrder   = 2
300:             .Column3.Width         = 338
301:             .Column3.Movable       = .F.
302:             .Column3.Resizable     = .F.
303:             .Column3.ReadOnly      = .T.
304:             .Column3.FontName      = "Tahoma"
305:             .Column3.FontSize      = 8
306:             .Column3.Header1.Caption   = "Nome do Arquivo"
307:             .Column3.Header1.Alignment = 2
308:             .Column3.Header1.FontName  = "Tahoma"
309:             .Column3.Header1.FontSize  = 8
310:             .Column3.Header1.ForeColor = RGB(36, 84, 155)
311:             .Column3.Text1.BorderStyle = 0
312:             .Column3.Text1.Margin      = 0
313:             .Column3.Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 323 a 366:
323:     * dialogo nao inclui/altera/exclui registro nenhum, so confirma ou
324:     * cancela a selecao de itens marcados na grade para exportacao.
325:     *==========================================================================
326:     PROTECTED PROCEDURE ConfigurarBotoes()
327:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
328:         WITH THIS.cmg_4c_Botoes
329:             .Top           = -2
330:             .Left          = 644
331:             .Width         = 160
332:             .Height        = 85
333:             .ButtonCount   = 2
334:             .BackStyle     = 0
335:             .BorderStyle   = 0
336:             .SpecialEffect = 1
337:             .BorderColor   = RGB(136, 189, 188)
338:             .Value         = 1
339: 
340:             WITH .Buttons(1)
341:                 .Top       = 5
342:                 .Left      = 5
343:                 .Width     = 75
344:                 .Height    = 75
345:                 .FontBold  = .T.
346:                 .FontItalic = .T.
347:                 .FontName  = "Comic Sans MS"
348:                 .FontSize  = 8
349:                 .WordWrap  = .T.
350:                 .Picture   = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
351:                 .Caption   = "Gerar"
352:                 .ForeColor = RGB(90, 90, 90)
353:                 .BackColor = RGB(255, 255, 255)
354:                 .Themes    = .F.
355:                 .Visible   = .T.
356:             ENDWITH
357: 
358:             WITH .Buttons(2)
359:                 .Top       = 5
360:                 .Left      = 80
361:                 .Width     = 75
362:                 .Height    = 75
363:                 .FontBold  = .T.
364:                 .FontItalic = .T.
365:                 .FontName  = "Comic Sans MS"
366:                 .FontSize  = 8

*-- Linhas 379 a 836:
379: 
380:         *-- Command1.Click/Command2.Click do legado: cada botao do
381:         *-- Commandgroup tem handler PROPRIO (nao um Click unico do grupo)
382:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnGerarClick")
383:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnEncerrarClick")
384:     ENDPROC
385: 
386:     *==========================================================================
387:     * ConfigurarCampos - Optiongroup1/Label1 do legado (SIGOPARQ.Optiongroup1
388:     * e SIGOPARQ.Label1): seletor do tipo de item exportavel para a grade
389:     * (1=Linha/SigCdLin, 2=Grupo de Produto/SigCdGrp - ver
390:     * SigOpArqBO.AtualizarTipoExportacao). Posicoes/legendas/largura
391:     * TRANSCRITAS do dump do SCX legado (regra #45 - OptionGroup: legenda,
392:     * ordem e Top de cada botao vem do dump, nunca inventados). Este form
393:     * nao usa PageFrame, entao os Tops do legado sao usados sem
394:     * compensacao de +29 (ja o caso dos demais controles deste form).
395:     *==========================================================================
396:     PROTECTED PROCEDURE ConfigurarCampos()
397:         THIS.AddObject("obj_4c_Optiongroup1", "OptionGroup")
398:         WITH THIS.obj_4c_Optiongroup1
399:             .Top           = 166
400:             .Left          = 202
401:             .Width         = 189
402:             .Height        = 28
403:             .ButtonCount   = 2
404:             .BackStyle     = 0
405:             .SpecialEffect = 1
406:             .BorderColor   = RGB(136, 189, 188)
407:             .Value         = 1
408: 
409:             *-- Buttons(1) = "Linha" (SigCdLin) - this_nTipos = 1
410:             WITH .Buttons(1)
411:                 .FontName  = "Comic Sans MS"
412:                 .FontSize  = 8
413:                 .BackStyle = 0
414:                 .Caption   = " Linha"
415:                 .Top       = 7
416:                 .Left      = 5
417:                 .Width     = 46
418:                 .Height    = 15
419:                 .AutoSize  = .T.
420:                 .ForeColor = RGB(90, 90, 90)
421:                 .Themes    = .F.
422:             ENDWITH
423: 
424:             *-- Buttons(2) = "Grupo de Produto" (SigCdGrp) - this_nTipos = 2
425:             WITH .Buttons(2)
426:                 .FontName  = "Comic Sans MS"
427:                 .FontSize  = 8
428:                 .BackStyle = 0
429:                 .Caption   = " Grupo de Produto"
430:                 .Top       = 7
431:                 .Left      = 63
432:                 .Width     = 106
433:                 .Height    = 15
434:                 .AutoSize  = .T.
435:                 .ForeColor = RGB(90, 90, 90)
436:                 .Themes    = .F.
437:             ENDWITH
438: 
439:             .Visible = .T.
440:         ENDWITH
441: 
442:         *-- Optiongroup1.InteractiveChange do legado (ThisForm.ParentForm.pnTipos
443:         *-- = This.Value): neste form standalone nao ha ParentForm, o
444:         *-- equivalente eh atualizar o tipo no BO e recarregar a grade.
445:         BINDEVENT(THIS.obj_4c_Optiongroup1, "InteractiveChange", THIS, "OptTiposInteractiveChange")
446: 
447:         *-- Label1 do legado: nao declara Width/Alignment no dump = classe
448:         *-- "say" pura (regra #23) -> AutoSize = .F. + Width/Height
449:         *-- transcritos do SCX (AutoSize = .T. e no-op em Label via AddObject)
450:         THIS.AddObject("lbl_4c_Label1", "Label")
451:         WITH THIS.lbl_4c_Label1
452:             .AutoSize  = .F.
453:             .Alignment = 0
454:             .FontName  = "Tahoma"
455:             .FontSize  = 8
456:             .BackStyle = 0
457:             .Caption   = "Exporta" + CHR(231) + CHR(227) + "o  do Setor :"
458:             .Top       = 172
459:             .Left      = 67
460:             .Width     = 111
461:             .Height    = 15
462:             .ForeColor = RGB(90, 90, 90)
463:             .Visible   = .T.
464:         ENDWITH
465:     ENDPROC
466: 
467:     *==========================================================================
468:     * CarregarLista - Popula cursor_4c_Dados via SigOpArqBO.Buscar() (SQL
469:     * para SigCdLin/SigCdGrp, conforme this_nTipos) e repinta a grade.
470:     * RecordSource/ControlSource ja foram definidos uma unica vez em
471:     * ConfigurarGrid() - aqui so GO TOP + Refresh (regra: popular cursor
472:     * nao repinta a grade sozinho).
473:     *==========================================================================
474:     PROCEDURE CarregarLista()
475:         LOCAL loc_lSucesso
476:         loc_lSucesso = .F.
477: 
478:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
479:             loc_lSucesso = THIS.this_oBusinessObject.Buscar("")
480:         ENDIF
481: 
482:         IF USED("cursor_4c_Dados")
483:             GO TOP IN cursor_4c_Dados
484:         ENDIF
485: 
486:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
487:             THIS.grd_4c_Dados.Refresh()
488:         ENDIF
489: 
490:         RETURN loc_lSucesso
491:     ENDPROC
492: 
493:     *==========================================================================
494:     * ValidarArquivoDestino - Cadeia de validacao do arquivo de destino, na
495:     * ordem EXATA de Grid1.Column1.Check1.InteractiveChange do legado:
496:     *
497:     *     If Not Empty(m.lcArqTxt)
498:     *         If Not fVerificaPasta(m.lcArqTxt,2) -> 'Local ou Arquivo Invalido !!!'
499:     *     Else                                    -> 'Destino Invalido !!!'
500:     *     Endif
501:     *     Locate for cNomArqs = m.lcArqTxt        -> 'Nome Arquivo Ja Informado !!!'
502:     *
503:     * Devolve .T. somente quando as TRES passam (e nesse caso o item ja fica
504:     * marcado com o destino escolhido, igual ao "Replace nMarcas With 1 /
505:     * cNomArqs With m.lcArqTxt" que fecha o metodo legado). Recusando,
506:     * devolve .F. e deixa em THIS.this_cMensagemErro a mensagem LITERAL do
507:     * legado, para o chamador exibir e desmarcar o item.
508:     *
509:     * PUBLIC de proposito: eh chamado pelos handlers de toggle do
510:     * chk_4c_Marca, que o BINDEVENT dispara de fora da classe (regra #3).
511:     *==========================================================================
512:     PROCEDURE ValidarArquivoDestino(par_cCaminhoArquivo)
513:         LOCAL loc_lValido
514:         loc_lValido = .F.
515:         THIS.this_cMensagemErro = ""
516: 
517:         DO CASE
518:             *-- Ramo "Else" do If Not Empty() legado: usuario cancelou o
519:             *-- PutFile (devolve string vazia) ou nao informou nome algum.
520:             CASE VARTYPE(par_cCaminhoArquivo) != "C" OR EMPTY(ALLTRIM(par_cCaminhoArquivo))
521:                 THIS.this_cMensagemErro = "Destino Inv" + CHR(225) + "lido !!!"
522: 
523:             CASE VARTYPE(THIS.this_oBusinessObject) != "O"
524:                 THIS.this_cMensagemErro = "Destino Inv" + CHR(225) + "lido !!!"
525: 
526:             *-- fVerificaPasta (pasta de destino) + "Locate for cNomArqs"
527:             *-- (nome ja informado em outra linha) + a marcacao do item: o BO
528:             *-- eh a FONTE UNICA das tres coisas e devolve em
529:             *-- this_cMensagemErro a mensagem exata do legado ao recusar.
530:             CASE !THIS.this_oBusinessObject.MarcarItemParaExportacao(par_cCaminhoArquivo)
531:                 THIS.this_cMensagemErro = THIS.this_oBusinessObject.this_cMensagemErro
532: 
533:             OTHERWISE
534:                 loc_lValido = .T.
535:         ENDCASE
536: 
537:         RETURN loc_lValido
538:     ENDPROC
539: 
540:     *==========================================================================
541:     * ChkMarcaToggleExec - Corpo unico chamado pelos 4 handlers de toggle do
542:     * chk_4c_Marca. Espelha Grid1.Column1.Check1.InteractiveChange do legado:
543:     * pede o arquivo de destino (PutFile) e submete a
544:     * THIS.ValidarArquivoDestino(); recusando, exibe a mensagem do legado e
545:     * deixa o item desmarcado, igual aos "Replace nMarcas With 0 / cNomArqs
546:     * With '' / This.Value = 0" de cada ramo de erro do metodo legado.
547:     *==========================================================================
548:     PROCEDURE ChkMarcaToggleExec()
549:         LOCAL loc_cArqTxt
550: 
551:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
552:             RETURN
553:         ENDIF
554: 
555:         loc_cArqTxt = PUTFILE("Arquivo :", "", "TXT")
556: 
557:         IF !THIS.ValidarArquivoDestino(loc_cArqTxt)
558:             *-- regra #20: o BO marca this_lErroExibido quando ele mesmo ja
559:             *-- exibiu a falha (CATCH com MsgErro) - repetir daria 2 dialogos
560:             IF VARTYPE(THIS.this_oBusinessObject) != "O" OR ;
561:                     !THIS.this_oBusinessObject.this_lErroExibido
562:                 MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
563:             ENDIF
564: 
565:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
566:                 THIS.this_oBusinessObject.DesmarcarItem()
567:             ENDIF
568:         ENDIF
569: 
570:         *-- "This.Parent.Refresh" do legado: sem isto a grade nao repinta a
571:         *-- marcacao nem o nome do arquivo recem-gravados no cursor (regra #21)
572:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
573:             THIS.grd_4c_Dados.Refresh()
574:         ENDIF
575:     ENDPROC
576: 
577:     PROCEDURE ChkMarcaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
578:         IF INLIST(par_nKeyCode, 13, 32)
579:             THIS.ChkMarcaToggleExec()
580:             NODEFAULT
581:         ENDIF
582:     ENDPROC
583: 
584:     PROCEDURE ChkMarcaMouseUp(par_nButton, par_nShiftAltCtrl, par_nRow, par_nColumn)
585:         THIS.ChkMarcaToggleExec()
586:         NODEFAULT
587:     ENDPROC
588: 
589:     PROCEDURE ChkMarcaMouseDown(par_nButton, par_nShiftAltCtrl, par_nRow, par_nColumn)
590:         NODEFAULT
591:     ENDPROC
592: 
593:     PROCEDURE ChkMarcaClick()
594:         NODEFAULT
595:     ENDPROC
596: 
597:     *==========================================================================
598:     * OptTiposInteractiveChange - Optiongroup1.InteractiveChange do legado.
599:     * Troca this_nTipos no BO (Linha/Grupo de Produto) e recarrega a grade
600:     * com o universo do tipo novo.
601:     *==========================================================================
602:     PROCEDURE OptTiposInteractiveChange()
603:         *-- FONTE UNICA da transferencia campo -> BO (ver FormParaBO abaixo)
604:         THIS.FormParaBO()
605: 
606:         THIS.CarregarLista()
607:     ENDPROC
608: 
609:     *==========================================================================
610:     * FormParaBO - Transfere o unico campo EDITAVEL da tela para o BO.
611:     *
612:     * Este dialogo nao tem campos de cadastro: o unico controle que o usuario
613:     * altera (alem da marcacao da grade, que o BO ja grava direto no cursor em
614:     * MarcarItemParaExportacao) eh o Optiongroup1 "Exportacao do Setor",
615:     * cujo Value o legado jogava em ThisForm.ParentForm.pnTipos. Migrado
616:     * standalone, o destino equivalente eh SigOpArqBO.this_nTipos, resolvido
617:     * por AtualizarTipoExportacao (que tambem acerta tabela/chave de origem).
618:     *
619:     * Value do OptionGroup eh o INDICE 1-based do botao marcado (regra #45):
620:     * 1 = Linha (SigCdLin), 2 = Grupo de Produto (SigCdGrp) - mapeamento
621:     * DIRETO, sem +1/-1.
622:     *
623:     * PROTECTED igual ao hook de FormBase (declarar sem modificador nao
624:     * alarga o escopo - o PROTECTED da classe base prevalece, regra #51);
625:     * chamado so de dentro desta classe, sempre com THIS.
626:     *==========================================================================
627:     PROTECTED PROCEDURE FormParaBO()
628:         LOCAL loc_lSucesso
629:         loc_lSucesso = .F.
630: 
631:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND PEMSTATUS(THIS, "obj_4c_Optiongroup1", 5)
632:             loc_lSucesso = THIS.this_oBusinessObject.AtualizarTipoExportacao(THIS.obj_4c_Optiongroup1.Value)
633:         ENDIF
634: 
635:         RETURN loc_lSucesso
636:     ENDPROC
637: 
638:     *==========================================================================
639:     * BOParaForm - Caminho inverso de FormParaBO: reflete this_nTipos do BO no
640:     * Optiongroup1. Usado na abertura (o Init do BO ja nasce com this_nTipos
641:     * = 1, o mesmo "ParentForm.pnTipos = 1" do Init legado).
642:     *
643:     * Guarda BETWEEN(...,1,2): OptionGroup eh 1-based e atribuir 0 deixaria o
644:     * grupo SEM botao marcado, estado que o legado nunca tem (Optiongroup1.
645:     * Value = 1 no SCX).
646:     *==========================================================================
647:     PROTECTED PROCEDURE BOParaForm()
648:         LOCAL loc_nTipos
649: 
650:         IF VARTYPE(THIS.this_oBusinessObject) != "O" OR !PEMSTATUS(THIS, "obj_4c_Optiongroup1", 5)
651:             RETURN .F.
652:         ENDIF
653: 
654:         loc_nTipos = THIS.this_oBusinessObject.this_nTipos
655:         IF VARTYPE(loc_nTipos) != "N" OR !BETWEEN(loc_nTipos, 1, 2)
656:             loc_nTipos = 1
657:         ENDIF
658: 
659:         THIS.obj_4c_Optiongroup1.Value = loc_nTipos
660: 
661:         RETURN .T.
662:     ENDPROC
663: 
664:     *==========================================================================
665:     * BtnGerarClick - Commandgroup1.Command1.Click (Gerar) do legado: exige
666:     * pelo menos um item marcado, confirma com o usuario e fecha o dialogo
667:     * ("Release Windows" no legado). A geracao real dos arquivos ficava a
668:     * cargo do form pai no legado (ver comentario de BtnGerarClick no BO);
669:     * quando este dialogo for aberto por um form pai com crSigCdBal aberto
670:     * (mesmo DataSession do legado), o codigo do balanco entra na mensagem
671:     * de confirmacao, igual ao legado - senao a confirmacao fica generica.
672:     *==========================================================================
673:     PROCEDURE BtnGerarClick()
674:         *-- "Release Windows" do legado so acontece quando a confirmacao passa
675:         IF THIS.BtnConfirmarClick()
676:             THIS.Release()
677:         ENDIF
678:     ENDPROC
679: 
680:     *==========================================================================
681:     * BtnConfirmarClick - CORPO de Commandgroup1.Command1.Click (Gerar), sem o
682:     * fechamento da janela. Eh a acao de verdade deste dialogo: exigir item
683:     * marcado e obter a confirmacao do usuario para a exportacao.
684:     *
685:     *     Locate for nMarcas = 1
686:     *     If Eof()  -> 'Geracao Nao Selecionada !!!' / Return
687:     *     If MessageBox('Confirma Exportacao do Inventario X?',36,'')==7 -> Return
688:     *     Release Windows
689:     *
690:     * O par Confirmar/Gerar espelha o par Cancelar/Encerrar logo abaixo: o
691:     * metodo nomeado pelo VERBO CANONICO carrega a regra (validar + confirmar)
692:     * e devolve .T./.F.; o metodo nomeado pelo BOTAO do legado (Caption
693:     * "Gerar", fiel ao PILAR 1) eh o que o BINDEVENT dispara e so decide
694:     * fechar. A separacao tambem deixa a confirmacao reutilizavel por quem
695:     * abrir este dialogo por programa, sem a janela no meio.
696:     *
697:     * PUBLIC: chamado por BtnGerarClick e podendo ser acionado de fora pelo
698:     * harness de teste (regra #3 - PEMSTATUS nao enxerga escopo).
699:     *==========================================================================
700:     PROCEDURE BtnConfirmarClick()
701:         LOCAL loc_lConfirmado, loc_cMsg
702:         loc_lConfirmado = .F.
703: 
704:         *-- O tipo escolhido no Optiongroup1 vai ao BO ANTES da acao (padrao
705:         *-- do projeto: FormParaBO abre todo caminho de acao)
706:         THIS.FormParaBO()
707: 
708:         DO CASE
709:             CASE VARTYPE(THIS.this_oBusinessObject) != "O" OR ;
710:                     !THIS.this_oBusinessObject.ExisteItemSelecionado()
711:                 MsgAviso("Gera" + CHR(231) + CHR(227) + "o N" + CHR(227) + "o Selecionada !!!", ;
712:                          "Aten" + CHR(231) + CHR(227) + "o")
713: 
714:             OTHERWISE
715:                 loc_cMsg = "Confirma Exporta" + CHR(231) + CHR(227) + "o do Invent" + CHR(225) + "rio"
716: 
717:                 *-- crSigCdBal eh o cursor do form PAI no legado (mesma
718:                 *-- DataSession). Aberto por quem chamou este dialogo, o
719:                 *-- codigo do balanco entra na mensagem igual ao legado;
720:                 *-- standalone, a confirmacao fica generica.
721:                 IF USED("crSigCdBal")
722:                     loc_cMsg = loc_cMsg + " " + ALLTRIM(STR(crSigCdBal.Codigos)) + "?"
723:                 ELSE
724:                     loc_cMsg = loc_cMsg + "?"
725:                 ENDIF
726: 
727:                 loc_lConfirmado = MsgConfirma(loc_cMsg, "Confirmar")
728:         ENDCASE
729: 
730:         RETURN loc_lConfirmado
731:     ENDPROC
732: 
733:     *==========================================================================
734:     * BtnEncerrarClick - Commandgroup1.Command2.Click (Encerrar) do legado:
735:     * se houver item marcado, confirma o cancelamento; confirmando (ou se
736:     * nao havia nada marcado), limpa todas as marcacoes e fecha o dialogo.
737:     *==========================================================================
738:     PROCEDURE BtnEncerrarClick()
739:         *-- "Release Windows" do legado so acontece quando o cancelamento eh
740:         *-- aceito (recusando, o legado faz Return e a tela CONTINUA aberta)
741:         IF THIS.BtnCancelarClick()
742:             THIS.Release()
743:         ENDIF
744:     ENDPROC
745: 
746:     *==========================================================================
747:     * BtnCancelarClick - CORPO de Commandgroup1.Command2.Click (Encerrar,
748:     * Cancel = .T. no SCX), sem o fechamento da janela.
749:     *
750:     *     Locate for nMarcas = 1
751:     *     If ! Eof()
752:     *         If MessageBox('Geracao Selecionada, Deseja Cancelar ???',36,'') = 7
753:     *             Return
754:     *     Replace All nMarcas With 0
755:     *     Release Windows
756:     *
757:     * O botao do legado NAO eh um "sair" puro: antes de fechar ele DESFAZ a
758:     * selecao inteira (Replace All nMarcas With 0) - ou seja, cancela o
759:     * trabalho feito na grade. Por isso o cancelamento tem metodo proprio com
760:     * o nome canonico, e BtnEncerrarClick (nome do botao no legado, Caption
761:     * "Encerrar" preservado pelo PILAR 1) so decide fechar conforme o
762:     * resultado.
763:     *
764:     * Devolve .F. quando o usuario recusa o cancelamento - nesse caso nada eh
765:     * desmarcado e a tela permanece aberta, exatamente como o Return do
766:     * legado.
767:     *==========================================================================
768:     PROCEDURE BtnCancelarClick()
769:         LOCAL loc_lCancelar
770:         loc_lCancelar = .T.
771: 
772:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND THIS.this_oBusinessObject.ExisteItemSelecionado()
773:             loc_lCancelar = MsgConfirma("Gera" + CHR(231) + CHR(227) + "o Selecionada, Deseja Cancelar ???", ;
774:                                         "Confirmar")
775:         ENDIF
776: 
777:         IF loc_lCancelar
778:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
779:                 THIS.this_oBusinessObject.LimparSelecoes()
780:             ENDIF
781: 
782:             *-- regra #21: limpar o cursor nao repinta a grade sozinho
783:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
784:                 THIS.grd_4c_Dados.Refresh()
785:             ENDIF
786:         ENDIF
787: 
788:         RETURN loc_lCancelar
789:     ENDPROC
790: 
791:     *==========================================================================
792:     * ConfigurarPageFrame - Container cabecalho (cntSombra do legado): fundo
793:     * cinza + labels de titulo. Forms OPERACIONAIS nao usam PageFrame de
794:     * abas CRUD; este metodo agrupa a faixa fixa do topo do form.
795:     *==========================================================================
796:     PROTECTED PROCEDURE ConfigurarPageFrame()
797:         THIS.AddObject("cnt_4c_Sombra", "Container")
798:         WITH THIS.cnt_4c_Sombra
799:             .Top         = 0
800:             .Left        = 0
801:             .Width       = THIS.Width
802:             .Height      = 80
803:             .BackStyle   = 1
804:             .BackColor   = RGB(100, 100, 100)
805:             .BorderWidth = 0
806:             .Visible     = .T.
807: 
808:             .AddObject("lbl_4c_Sombra", "Label")
809:             WITH .lbl_4c_Sombra
810:                 .Top       = 18
811:                 .Left      = 10
812:                 .Width     = THIS.Width
813:                 .Height    = 40
814:                 .FontBold  = .T.
815:                 .FontName  = "Tahoma"
816:                 .FontSize  = 18
817:                 .BackStyle = 0
818:                 .ForeColor = RGB(0, 0, 0)
819:                 .WordWrap  = .T.
820:                 .Alignment = 0
821:                 .Caption   = THIS.Caption
822:                 .Visible   = .T.
823:             ENDWITH
824: 
825:             .AddObject("lbl_4c_Titulo", "Label")
826:             WITH .lbl_4c_Titulo
827:                 .Top       = 17
828:                 .Left      = 10
829:                 .Width     = THIS.Width
830:                 .Height    = 46
831:                 .FontBold  = .T.
832:                 .FontName  = "Tahoma"
833:                 .FontSize  = 18
834:                 .BackStyle = 0
835:                 .ForeColor = RGB(255, 255, 255)
836:                 .WordWrap  = .T.

*-- Linhas 845 a 891:
845:     * Destroy - fecha cursores locais e preserva o fix de menu (DODEFAULT
846:     * chama FormBase.Destroy)
847:     *==========================================================================
848:     PROCEDURE Destroy()
849:         IF USED("cursor_4c_Dados")
850:             USE IN cursor_4c_Dados
851:         ENDIF
852:         IF USED("cursor_4c_ItensExpTemp")
853:             USE IN cursor_4c_ItensExpTemp
854:         ENDIF
855: 
856:         DODEFAULT()
857:     ENDPROC
858: 
859:     *==========================================================================
860:     * TornarControlesVisiveis - Torna visiveis todos os controles do form
861:     * recursivamente. Este form OPERACIONAL nao tem containers flutuantes
862:     * (Visible=.F. toggled por botao) no layout do legado - todos os
863:     * controles ficam visiveis desde a abertura.
864:     *==========================================================================
865:     PROCEDURE TornarControlesVisiveis(par_oContainer)
866:         LOCAL loc_nI, loc_nJ, loc_oObjeto
867: 
868:         IF VARTYPE(par_oContainer) != "O"
869:             RETURN
870:         ENDIF
871: 
872:         FOR loc_nI = 1 TO par_oContainer.ControlCount
873:             loc_oObjeto = par_oContainer.Controls(loc_nI)
874: 
875:             IF PEMSTATUS(loc_oObjeto, "Visible", 5)
876:                 loc_oObjeto.Visible = .T.
877:             ENDIF
878: 
879:             IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
880:                 THIS.TornarControlesVisiveis(loc_oObjeto)
881:             ENDIF
882: 
883:             IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
884:                 FOR loc_nJ = 1 TO loc_oObjeto.PageCount
885:                     THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nJ))
886:                 ENDFOR
887:             ENDIF
888:         ENDFOR
889:     ENDPROC
890: 
891: ENDDEFINE


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

