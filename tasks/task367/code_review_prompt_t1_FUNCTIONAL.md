# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (16)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterJuroCarts()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-HEADER] Header Caption 'Lote' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agenc, Nº Conta, Nº Cheque, Vencimento, Valor, Observação, CPF/CNPJ, Nome Terceiro. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agenc, Nº Conta, Nº Cheque, Vencimento, Valor, Observação, CPF/CNPJ, Nome Terceiro. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Operação' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agenc, Nº Conta, Nº Cheque, Vencimento, Valor, Observação, CPF/CNPJ, Nome Terceiro. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Total' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agenc, Nº Conta, Nº Cheque, Vencimento, Valor, Observação, CPF/CNPJ, Nome Terceiro. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Juros' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agenc, Nº Conta, Nº Cheque, Vencimento, Valor, Observação, CPF/CNPJ, Nome Terceiro. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Dt. Transporte' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agenc, Nº Conta, Nº Cheque, Vencimento, Valor, Observação, CPF/CNPJ, Nome Terceiro. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Lote' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agenc, Nº Conta, Nº Cheque, Vencimento, Valor, Observação, CPF/CNPJ, Nome Terceiro. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agenc, Nº Conta, Nº Cheque, Vencimento, Valor, Observação, CPF/CNPJ, Nome Terceiro. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Operação' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agenc, Nº Conta, Nº Cheque, Vencimento, Valor, Observação, CPF/CNPJ, Nome Terceiro. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Total' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agenc, Nº Conta, Nº Cheque, Vencimento, Valor, Observação, CPF/CNPJ, Nome Terceiro. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Juros' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agenc, Nº Conta, Nº Cheque, Vencimento, Valor, Observação, CPF/CNPJ, Nome Terceiro. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Dt. Transporte' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agenc, Nº Conta, Nº Cheque, Vencimento, Valor, Observação, CPF/CNPJ, Nome Terceiro. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDCHE.Pagina.Lista.cntFiltros.Cnt_periodo): Top original=10 vs migrado 'lbl_4c_Label13' Top=74 (diff=64px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDCHE.Pagina.Lista.cntFiltros.Cnt_periodo): Left original=12 vs migrado 'lbl_4c_Label13' Left=380 (diff=368px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formche.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3327 linhas total):

*-- Linhas 37 a 164:
37:     this_nNumLoteAtual = 0
38: 
39:     *--------------------------------------------------------------------------
40:     * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
41:     * DataSession=2: FormBase.Init define SET DATE BRITISH + SET CENTURY ON
42:     *--------------------------------------------------------------------------
43:     PROCEDURE Init()
44:         LOCAL loc_lResultado
45:         loc_lResultado = .F.
46: 
47:         TRY
48:             loc_lResultado = DODEFAULT()
49:         CATCH TO loc_oErro
50:             MsgErro(loc_oErro.Message, "Formche.Init")
51:         ENDTRY
52: 
53:         RETURN loc_lResultado
54:     ENDPROC
55: 
56:     *--------------------------------------------------------------------------
57:     * InicializarForm - Configura estrutura basica do form
58:     * Chamado automaticamente pelo FormBase.Init()
59:     *--------------------------------------------------------------------------
60:     PROTECTED PROCEDURE InicializarForm()
61:         LOCAL loc_lResultado
62:         loc_lResultado = .F.
63: 
64:         TRY
65:             THIS.this_oBusinessObject = CREATEOBJECT("cheBO")
66: 
67:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
68:                 MsgErro("Falha ao criar cheBO", "Formche.InicializarForm")
69:             ELSE
70:                 THIS.ConfigurarPageFrame()
71: 
72:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
73:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
74: 
75:                 THIS.pgf_4c_Paginas.Visible    = .T.
76:                 THIS.pgf_4c_Paginas.ActivePage = 1
77:                 THIS.this_cModoAtual = "LISTA"
78: 
79:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
80:                     THIS.CarregarLista()
81:                 ENDIF
82: 
83:                 loc_lResultado = .T.
84:             ENDIF
85:         CATCH TO loc_oErro
86:             MsgErro(loc_oErro.Message, "Formche.InicializarForm")
87:         ENDTRY
88: 
89:         RETURN loc_lResultado
90:     ENDPROC
91: 
92:     *--------------------------------------------------------------------------
93:     * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista, Dados)
94:     *--------------------------------------------------------------------------
95:     PROTECTED PROCEDURE ConfigurarPageFrame()
96:         LOCAL loc_oPgf
97:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
98:         loc_oPgf = THIS.pgf_4c_Paginas
99: 
100:         WITH loc_oPgf
101:             .PageCount = 2
102:             .Top       = -29
103:             .Left      = 0
104:             .Width     = THIS.Width
105:             .Height    = THIS.Height + 29
106:             .Tabs      = .F.
107:             .Visible   = .T.
108:             .Page1.Caption   = "Lista"
109:             .Page1.BackColor = RGB(100, 100, 100)
110:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
111:             .Page2.Caption   = "Dados"
112:             .Page2.BackColor = RGB(100, 100, 100)
113:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
114:         ENDWITH
115: 
116:         THIS.ConfigurarPaginaLista()
117:         THIS.ConfigurarPaginaDados()
118:     ENDPROC
119: 
120:     *--------------------------------------------------------------------------
121:     * ConfigurarPaginaLista - Page1: cabecalho + botoes CRUD + filtros + grid
122:     * Compensacao +29 em todos os Top pelo PageFrame.Top=-29
123:     *--------------------------------------------------------------------------
124:     PROTECTED PROCEDURE ConfigurarPaginaLista()
125:         LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oFiltros, loc_oGrid
126: 
127:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
128: 
129:         *-- Cabecalho cinza (Top=2+29=31)
130:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
131:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
132:         WITH loc_oCab
133:             .Top         = 31
134:             .Left        = 0
135:             .Width       = THIS.Width
136:             .Height      = 80
137:             .BackColor   = RGB(100, 100, 100)
138:             .BorderWidth = 0
139:             .Visible     = .T.
140:         ENDWITH
141: 
142:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
143:         WITH loc_oCab.lbl_4c_Sombra
144:             .Caption   = THIS.Caption
145:             .AutoSize  = .F.
146:             .Width     = THIS.Width
147:             .Height    = 40
148:             .Top       = 15
149:             .Left      = 10
150:             .FontName  = "Tahoma"
151:             .FontSize  = 16
152:             .FontBold  = .T.
153:             .ForeColor = RGB(0, 0, 0)
154:             .BackStyle = 0
155:             .Visible   = .T.
156:         ENDWITH
157: 
158:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
159:         WITH loc_oCab.lbl_4c_Titulo
160:             .Caption   = THIS.Caption
161:             .AutoSize  = .F.
162:             .Width     = THIS.Width
163:             .Height    = 46
164:             .Top       = 18

*-- Linhas 207 a 598:
207:             .MousePointer    = 15
208:             .Visible         = .T.
209:         ENDWITH
210:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
211: 
212:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
213:         WITH loc_oBotoes.cmd_4c_Visualizar
214:             .Top             = 5
215:             .Left            = 80
216:             .Width           = 75
217:             .Height          = 75
218:             .Caption         = "Visualizar"
219:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
220:             .PicturePosition = 13
221:             .FontName        = "Comic Sans MS"
222:             .FontBold        = .T.
223:             .FontItalic      = .T.
224:             .FontSize        = 8
225:             .ForeColor       = RGB(90, 90, 90)
226:             .BackColor       = RGB(255, 255, 255)
227:             .Themes          = .F.
228:             .SpecialEffect   = 0
229:             .WordWrap        = .T.
230:             .AutoSize        = .F.
231:             .MousePointer    = 15
232:             .Visible         = .T.
233:         ENDWITH
234:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
235: 
236:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
237:         WITH loc_oBotoes.cmd_4c_Alterar
238:             .Top             = 5
239:             .Left            = 155
240:             .Width           = 75
241:             .Height          = 75
242:             .Caption         = "Alterar"
243:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
244:             .PicturePosition = 13
245:             .FontName        = "Comic Sans MS"
246:             .FontBold        = .T.
247:             .FontItalic      = .T.
248:             .FontSize        = 8
249:             .ForeColor       = RGB(90, 90, 90)
250:             .BackColor       = RGB(255, 255, 255)
251:             .Themes          = .F.
252:             .SpecialEffect   = 0
253:             .WordWrap        = .T.
254:             .AutoSize        = .F.
255:             .MousePointer    = 15
256:             .Visible         = .T.
257:         ENDWITH
258:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
259: 
260:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
261:         WITH loc_oBotoes.cmd_4c_Excluir
262:             .Top             = 5
263:             .Left            = 230
264:             .Width           = 75
265:             .Height          = 75
266:             .Caption         = "Excluir"
267:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
268:             .PicturePosition = 13
269:             .FontName        = "Comic Sans MS"
270:             .FontBold        = .T.
271:             .FontItalic      = .T.
272:             .FontSize        = 8
273:             .ForeColor       = RGB(90, 90, 90)
274:             .BackColor       = RGB(255, 255, 255)
275:             .Themes          = .F.
276:             .SpecialEffect   = 0
277:             .WordWrap        = .T.
278:             .AutoSize        = .F.
279:             .MousePointer    = 15
280:             .Visible         = .T.
281:         ENDWITH
282:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
283: 
284:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
285:         WITH loc_oBotoes.cmd_4c_Buscar
286:             .Top             = 5
287:             .Left            = 305
288:             .Width           = 75
289:             .Height          = 75
290:             .Caption         = "Buscar"
291:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
292:             .PicturePosition = 13
293:             .FontName        = "Comic Sans MS"
294:             .FontBold        = .T.
295:             .FontItalic      = .T.
296:             .FontSize        = 8
297:             .ForeColor       = RGB(90, 90, 90)
298:             .BackColor       = RGB(255, 255, 255)
299:             .Themes          = .F.
300:             .SpecialEffect   = 0
301:             .WordWrap        = .T.
302:             .AutoSize        = .F.
303:             .MousePointer    = 15
304:             .Visible         = .T.
305:         ENDWITH
306:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
307: 
308:         *-- Container Saida canonico (Left=917, Width=90, Top=29)
309:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
310:         loc_oSaida = loc_oPg1.cnt_4c_Saida
311:         WITH loc_oSaida
312:             .Top         = 29
313:             .Left        = 917
314:             .Width       = 90
315:             .Height      = 85
316:             .BackStyle   = 0
317:             .BorderWidth = 0
318:             .Visible     = .T.
319:         ENDWITH
320: 
321:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
322:         WITH loc_oSaida.cmd_4c_Encerrar
323:             .Top             = 5
324:             .Left            = 5
325:             .Width           = 75
326:             .Height          = 75
327:             .Caption         = "Encerrar"
328:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
329:             .PicturePosition = 13
330:             .FontName        = "Comic Sans MS"
331:             .FontBold        = .T.
332:             .FontItalic      = .T.
333:             .FontSize        = 8
334:             .ForeColor       = RGB(90, 90, 90)
335:             .BackColor       = RGB(255, 255, 255)
336:             .Themes          = .F.
337:             .SpecialEffect   = 0
338:             .Visible         = .T.
339:         ENDWITH
340:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
341: 
342:         *-- Container filtros de periodo (original: cntFiltros, top=82+29=111)
343:         loc_oPg1.AddObject("cnt_4c_Filtros", "Container")
344:         loc_oFiltros = loc_oPg1.cnt_4c_Filtros
345:         WITH loc_oFiltros
346:             .Top         = 111
347:             .Left        = 2
348:             .Width       = 420
349:             .Height      = 40
350:             .BackStyle   = 0
351:             .BorderWidth = 0
352:             .Visible     = .T.
353:         ENDWITH
354: 
355:         loc_oFiltros.AddObject("lbl_4c_Periodo", "Label")
356:         WITH loc_oFiltros.lbl_4c_Periodo
357:             .Caption   = "Per" + CHR(237) + "odo : "
358:             .Top       = 10
359:             .Left      = 12
360:             .Width     = 48
361:             .Height    = 15
362:             .FontName  = "Tahoma"
363:             .FontSize  = 8
364:             .ForeColor = RGB(255, 255, 255)
365:             .BackStyle = 0
366:             .Visible   = .T.
367:         ENDWITH
368: 
369:         loc_oFiltros.AddObject("txt_4c_DtInicial", "TextBox")
370:         WITH loc_oFiltros.txt_4c_DtInicial
371:             .Top         = 6
372:             .Left        = 62
373:             .Width       = 80
374:             .Height      = 23
375:             .Value       = {}
376:             .Format      = "D"
377:             .FontName    = "Tahoma"
378:             .FontSize    = 8
379:             .BorderStyle = 1
380:             .Visible     = .T.
381:         ENDWITH
382:         BINDEVENT(loc_oFiltros.txt_4c_DtInicial, "KeyPress", THIS, "DtInicialLostFocus")
383: 
384:         loc_oFiltros.AddObject("lbl_4c_Sep", "Label")
385:         WITH loc_oFiltros.lbl_4c_Sep
386:             .Caption   = "a"
387:             .Top       = 10
388:             .Left      = 149
389:             .FontName  = "Tahoma"
390:             .FontSize  = 8
391:             .ForeColor = RGB(255, 255, 255)
392:             .BackStyle = 0
393:             .Visible   = .T.
394:         ENDWITH
395: 
396:         loc_oFiltros.AddObject("txt_4c_DtFinal", "TextBox")
397:         WITH loc_oFiltros.txt_4c_DtFinal
398:             .Top         = 6
399:             .Left        = 162
400:             .Width       = 80
401:             .Height      = 23
402:             .Value       = {}
403:             .Format      = "D"
404:             .FontName    = "Tahoma"
405:             .FontSize    = 8
406:             .BorderStyle = 1
407:             .Visible     = .T.
408:         ENDWITH
409:         BINDEVENT(loc_oFiltros.txt_4c_DtFinal, "KeyPress", THIS, "DtFinalLostFocus")
410: 
411:         *-- Botao LimpaDT: original top=85+29=114, left=290 (Limpar Data Transporte)
412:         loc_oPg1.AddObject("cmd_4c_LimpaDT", "CommandButton")
413:         WITH loc_oPg1.cmd_4c_LimpaDT
414:             .Top         = 114
415:             .Left        = 290
416:             .Width       = 120
417:             .Height      = 40
418:             .Caption     = "Limpar Data"
419:             .FontName    = "Tahoma"
420:             .FontSize    = 8
421:             .Visible     = .T.
422:         ENDWITH
423:         BINDEVENT(loc_oPg1.cmd_4c_LimpaDT, "Click", THIS, "BtnLimpaDTClick")
424: 
425:         *-- Grid lista de lotes (grd_4c_Dados) - RecordSource definido em CarregarLista
426:         *-- ColumnCount e RecordSource FORA do WITH (Problema 36)
427:         loc_oPg1.AddObject("grd_4c_Dados", "Grid")
428:         loc_oGrid             = loc_oPg1.grd_4c_Dados
429:         loc_oGrid.Top         = 156
430:         loc_oGrid.Left        = 2
431:         loc_oGrid.Width       = 910
432:         loc_oGrid.Height      = 385
433:         loc_oGrid.ColumnCount = 6
434: 
435:         WITH loc_oGrid
436:             .FontName           = "Verdana"
437:             .FontSize           = 8
438:             .ForeColor          = RGB(90, 90, 90)
439:             .BackColor          = RGB(255, 255, 255)
440:             .GridLineColor      = RGB(238, 238, 238)
441:             .GridLines          = 3
442:             .HighlightBackColor = RGB(255, 255, 255)
443:             .HighlightForeColor = RGB(15, 41, 104)
444:             .HighlightStyle     = 2
445:             .DeleteMark         = .F.
446:             .RecordMark         = .F.
447:             .RowHeight          = 16
448:             .ScrollBars         = 2
449:             .ReadOnly           = .T.
450:             .Visible            = .T.
451:             .Column1.Width      = 55
452:             .Column2.Width      = 82
453:             .Column3.Width      = 130
454:             .Column3.Alignment  = 2
455:             .Column4.Width      = 105
456:             .Column4.Alignment  = 1
457:             .Column5.Width      = 100
458:             .Column5.Alignment  = 1
459:             .Column6.Width      = 100
460:             .Column1.Header1.Caption = "Lote"
461:             .Column2.Header1.Caption = "Data"
462:             .Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
463:             .Column4.Header1.Caption = "Total"
464:             .Column5.Header1.Caption = "Juros"
465:             .Column6.Header1.Caption = "Dt. Transporte"
466:         ENDWITH
467: 
468:         THIS.TornarControlesVisiveis(loc_oPg1)
469:     ENDPROC
470: 
471:     *--------------------------------------------------------------------------
472:     * ConfigurarPaginaDados - Page2: Fase 5/8
473:     * Campos adicionados: BotoesAcao, Imprime, Shapes, cabecalho do lote,
474:     * totais, moeda, GradeCheque (9 cols), ExcCheque, leitor cheque
475:     *--------------------------------------------------------------------------
476:     PROTECTED PROCEDURE ConfigurarPaginaDados()
477:         LOCAL loc_oPg2, loc_oBotoesAcao, loc_oGrid
478: 
479:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
480: 
481:         *-- Container botoes de acao: Confirmar / Cancelar (Top=4+29=33)
482:         loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
483:         loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
484:         WITH loc_oBotoesAcao
485:             .Top         = 33
486:             .Left        = 842
487:             .Width       = 160
488:             .Height      = 85
489:             .BackStyle   = 0
490:             .Visible     = .T.
491:         ENDWITH
492: 
493:         loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
494:         WITH loc_oBotoesAcao.cmd_4c_Confirmar
495:             .Top             = 5
496:             .Left            = 5
497:             .Width           = 75
498:             .Height          = 75
499:             .Caption         = "Confirmar"
500:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
501:             .PicturePosition = 13
502:             .FontName        = "Comic Sans MS"
503:             .FontBold        = .T.
504:             .FontItalic      = .T.
505:             .FontSize        = 8
506:             .ForeColor       = RGB(90, 90, 90)
507:             .BackColor       = RGB(255, 255, 255)
508:             .Themes          = .F.
509:             .SpecialEffect   = 0
510:             .WordWrap        = .T.
511:             .AutoSize        = .F.
512:             .MousePointer    = 15
513:             .Visible         = .T.
514:         ENDWITH
515:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
516: 
517:         loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
518:         WITH loc_oBotoesAcao.cmd_4c_Cancelar
519:             .Top             = 5
520:             .Left            = 80
521:             .Width           = 75
522:             .Height          = 75
523:             .Caption         = "Encerrar"
524:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
525:             .PicturePosition = 13
526:             .FontName        = "Comic Sans MS"
527:             .FontBold        = .T.
528:             .FontItalic      = .T.
529:             .FontSize        = 8
530:             .ForeColor       = RGB(90, 90, 90)
531:             .BackColor       = RGB(255, 255, 255)
532:             .Themes          = .F.
533:             .SpecialEffect   = 0
534:             .WordWrap        = .T.
535:             .AutoSize        = .F.
536:             .MousePointer    = 15
537:             .Visible         = .T.
538:         ENDWITH
539:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
540: 
541:         *-- Botao Imprime (top=4+29=33, left=696, original: 75x75)
542:         loc_oPg2.AddObject("cmd_4c_Imprime", "CommandButton")
543:         WITH loc_oPg2.cmd_4c_Imprime
544:             .Top           = 33
545:             .Left          = 696
546:             .Width         = 75
547:             .Height        = 75
548:             .Caption       = "\<Relat" + CHR(243) + "rio"
549:             .FontName      = "Tahoma"
550:             .FontBold      = .T.
551:             .FontSize      = 8
552:             .ForeColor     = RGB(90, 90, 90)
553:             .BackColor     = RGB(255, 255, 255)
554:             .Themes        = .F.
555:             .SpecialEffect = 0
556:             .Visible       = .T.
557:         ENDWITH
558:         BINDEVENT(loc_oPg2.cmd_4c_Imprime, "Click", THIS, "BtnImprimeClick")
559: 
560:         *-- Botao Protocolo (hidden, top=4+29=33, left=771)
561:         loc_oPg2.AddObject("cmd_4c_Protocolos", "CommandButton")
562:         WITH loc_oPg2.cmd_4c_Protocolos
563:             .Top     = 33
564:             .Left    = 771
565:             .Width   = 75
566:             .Height  = 75
567:             .Caption = "\<Protocolo"
568:             .FontName = "Tahoma"
569:             .FontSize = 8
570:             .Visible  = .F.
571:         ENDWITH
572: 
573:         *-- Shapes decorativos (top=8+29=37)
574:         loc_oPg2.AddObject("shp_4c_Shape1", "Shape")
575:         WITH loc_oPg2.shp_4c_Shape1
576:             .Top         = 37
577:             .Left        = 9
578:             .Width       = 620
579:             .Height      = 112
580:             .BackStyle   = 0
581:             .BorderColor = RGB(150, 150, 150)
582:             .Visible     = .T.
583:         ENDWITH
584: 
585:         loc_oPg2.AddObject("shp_4c_Shape2", "Shape")
586:         WITH loc_oPg2.shp_4c_Shape2
587:             .Top         = 37
588:             .Left        = 719
589:             .Width       = 92
590:             .Height      = 53
591:             .BackStyle   = 0
592:             .BorderColor = RGB(150, 150, 150)
593:             .Visible     = .T.
594:         ENDWITH
595: 
596:         *-- Lote (readonly): lbl_4c_Label3 (top=19+29=48), txt_4c_Lote (top=15+29=44)
597:         loc_oPg2.AddObject("lbl_4c_Label3", "Label")
598:         WITH loc_oPg2.lbl_4c_Label3

*-- Linhas 704 a 747:
704:             .BorderStyle = 1
705:             .Visible     = .T.
706:         ENDWITH
707:         BINDEVENT(loc_oPg2.txt_4c_OperL, "KeyPress", THIS, "ValidarOperL")
708: 
709:         *-- Operacao (S/N, readonly): lbl_4c_Label5 (top=45+29=74), txt_4c_Opera (top=41+29=70)
710:         loc_oPg2.AddObject("lbl_4c_Label5", "Label")
711:         WITH loc_oPg2.lbl_4c_Label5
712:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
713:             .Top       = 74
714:             .Left      = 253
715:             .FontName  = "Tahoma"
716:             .FontSize  = 8
717:             .ForeColor = RGB(255, 255, 255)
718:             .BackStyle = 0
719:             .AutoSize  = .T.
720:             .Visible   = .T.
721:         ENDWITH
722: 
723:         loc_oPg2.AddObject("txt_4c_Opera", "TextBox")
724:         WITH loc_oPg2.txt_4c_Opera
725:             .Top         = 70
726:             .Left        = 311
727:             .Width       = 17
728:             .Height      = 23
729:             .Value       = ""
730:             .ReadOnly    = .T.
731:             .FontName    = "Tahoma"
732:             .FontSize    = 8
733:             .BorderStyle = 1
734:             .Visible     = .T.
735:         ENDWITH
736: 
737:         *-- Limpar Carteira (hidden): lbl_4c_Label13, txt_4c_LimCart
738:         loc_oPg2.AddObject("lbl_4c_Label13", "Label")
739:         WITH loc_oPg2.lbl_4c_Label13
740:             .Caption   = "Limpar Carteira :"
741:             .Top       = 74
742:             .Left      = 380
743:             .FontName  = "Tahoma"
744:             .FontSize  = 8
745:             .ForeColor = RGB(255, 255, 255)
746:             .BackStyle = 0
747:             .AutoSize  = .T.

*-- Linhas 800 a 843:
800:             .BorderStyle = 1
801:             .Visible     = .T.
802:         ENDWITH
803:         BINDEVENT(loc_oPg2.txt_4c_GrupoT, "KeyPress", THIS, "ValidarGrupoT")
804: 
805:         loc_oPg2.AddObject("txt_4c_DGrupoT", "TextBox")
806:         WITH loc_oPg2.txt_4c_DGrupoT
807:             .Top         = 96
808:             .Left        = 200
809:             .Width       = 300
810:             .Height      = 23
811:             .Value       = ""
812:             .ReadOnly    = .T.
813:             .FontName    = "Tahoma"
814:             .FontSize    = 8
815:             .BorderStyle = 1
816:             .Visible     = .T.
817:         ENDWITH
818: 
819:         *-- Total Bruto (readonly): lbl_4c_Label8 (top=97+29=126), txt_4c_Valor (top=93+29=122)
820:         loc_oPg2.AddObject("lbl_4c_Label8", "Label")
821:         WITH loc_oPg2.lbl_4c_Label8
822:             .Caption   = "Total Bruto :"
823:             .Top       = 126
824:             .Left      = 47
825:             .FontName  = "Tahoma"
826:             .FontSize  = 8
827:             .ForeColor = RGB(255, 255, 255)
828:             .BackStyle = 0
829:             .AutoSize  = .T.
830:             .Visible   = .T.
831:         ENDWITH
832: 
833:         loc_oPg2.AddObject("txt_4c_Valor", "TextBox")
834:         WITH loc_oPg2.txt_4c_Valor
835:             .Top         = 122
836:             .Left        = 111
837:             .Width       = 124
838:             .Height      = 23
839:             .Value       = 0
840:             .Format      = "Z"
841:             .InputMask   = "999,999,999.99"
842:             .ReadOnly    = .T.
843:             .FontName    = "Tahoma"

*-- Linhas 932 a 1005:
932:             .BorderStyle = 1
933:             .Visible     = .T.
934:         ENDWITH
935:         BINDEVENT(loc_oPg2.txt_4c_Moeda, "KeyPress", THIS, "ValidarMoeda")
936: 
937:         *-- Cotacao: lbl_4c_Cotacao (top=431+29=460), txt_4c_Cotacao (top=427+29=456)
938:         loc_oPg2.AddObject("lbl_4c_Cotacao", "Label")
939:         WITH loc_oPg2.lbl_4c_Cotacao
940:             .Caption   = "Cota" + CHR(231) + CHR(227) + "o :"
941:             .Top       = 460
942:             .Left      = 582
943:             .FontName  = "Tahoma"
944:             .FontSize  = 8
945:             .ForeColor = RGB(255, 255, 255)
946:             .BackStyle = 0
947:             .AutoSize  = .T.
948:             .Visible   = .T.
949:         ENDWITH
950: 
951:         loc_oPg2.AddObject("txt_4c_Cotacao", "TextBox")
952:         WITH loc_oPg2.txt_4c_Cotacao
953:             .Top         = 456
954:             .Left        = 633
955:             .Width       = 118
956:             .Height      = 23
957:             .Value       = 0
958:             .Format      = "Z"
959:             .InputMask   = "99,999.9999"
960:             .FontName    = "Tahoma"
961:             .FontSize    = 8
962:             .BorderStyle = 1
963:             .Visible     = .T.
964:         ENDWITH
965:         BINDEVENT(loc_oPg2.txt_4c_Cotacao, "KeyPress", THIS, "CotacaoLostFocus")
966: 
967:         *-- Valor Convertido (readonly): lbl_4c_Label20 (top=456+29=485), txt_4c_ValConv (top=452+29=481)
968:         loc_oPg2.AddObject("lbl_4c_Label20", "Label")
969:         WITH loc_oPg2.lbl_4c_Label20
970:             .Caption   = "Valor Conv :"
971:             .Top       = 485
972:             .Left      = 570
973:             .FontName  = "Tahoma"
974:             .FontSize  = 8
975:             .ForeColor = RGB(255, 255, 255)
976:             .BackStyle = 0
977:             .AutoSize  = .T.
978:             .Visible   = .T.
979:         ENDWITH
980: 
981:         loc_oPg2.AddObject("txt_4c_ValConv", "TextBox")
982:         WITH loc_oPg2.txt_4c_ValConv
983:             .Top         = 481
984:             .Left        = 633
985:             .Width       = 118
986:             .Height      = 23
987:             .Value       = 0
988:             .Format      = "Z"
989:             .InputMask   = "999,999,999.99"
990:             .ReadOnly    = .T.
991:             .FontName    = "Tahoma"
992:             .FontSize    = 8
993:             .BorderStyle = 1
994:             .Visible     = .T.
995:         ENDWITH
996: 
997:         *-- GradeCheque: grid de cheques (top=130+29=159), 9 colunas
998:         *-- ColumnCount FORA do WITH; ControlSource/RecordSource definidos em CarregarPaginaDados
999:         loc_oPg2.AddObject("grd_4c_GradeCheque", "Grid")
1000:         loc_oGrid             = loc_oPg2.grd_4c_GradeCheque
1001:         loc_oGrid.Top         = 159
1002:         loc_oGrid.Left        = 9
1003:         loc_oGrid.Width       = 985
1004:         loc_oGrid.Height      = 244
1005:         loc_oGrid.ColumnCount = 9

*-- Linhas 1055 a 1098:
1055:             .SpecialEffect = 0
1056:             .Visible       = .T.
1057:         ENDWITH
1058:         BINDEVENT(loc_oPg2.cmd_4c_ExcCheque, "Click", THIS, "BtnExcChequeClick")
1059: 
1060:         *-- Get_Cheque: campo para leitora magnetica / digitacao (top=393+29=422, left=115)
1061:         loc_oPg2.AddObject("txt_4c_Cheque", "TextBox")
1062:         WITH loc_oPg2.txt_4c_Cheque
1063:             .Top         = 422
1064:             .Left        = 115
1065:             .Width       = 252
1066:             .Height      = 24
1067:             .Value       = ""
1068:             .FontName    = "Tahoma"
1069:             .FontSize    = 8
1070:             .BorderStyle = 1
1071:             .Visible     = .T.
1072:         ENDWITH
1073: 
1074:         *-- Labels AvisoPorta M/T/S (ocultos - visiveis conforme tipo de operacao)
1075:         loc_oPg2.AddObject("lbl_4c_AvisoPortaM", "Label")
1076:         WITH loc_oPg2.lbl_4c_AvisoPortaM
1077:             .Top       = 96
1078:             .Left      = 544
1079:             .Width     = 22
1080:             .Height    = 18
1081:             .Caption   = "M"
1082:             .FontName  = "Tahoma"
1083:             .FontSize  = 8
1084:             .FontBold  = .T.
1085:             .ForeColor = RGB(0, 0, 192)
1086:             .AutoSize  = .F.
1087:             .Visible   = .F.
1088:         ENDWITH
1089: 
1090:         loc_oPg2.AddObject("lbl_4c_AvisoPortaT", "Label")
1091:         WITH loc_oPg2.lbl_4c_AvisoPortaT
1092:             .Top       = 96
1093:             .Left      = 570
1094:             .Width     = 22
1095:             .Height    = 18
1096:             .Caption   = "T"
1097:             .FontName  = "Tahoma"
1098:             .FontSize  = 8

*-- Linhas 1132 a 1434:
1132:             .Themes        = .F.
1133:             .SpecialEffect = 0
1134:         ENDWITH
1135:         BINDEVENT(loc_oPg2.cmd_4c_Command3, "Click", THIS, "BtnCommand3Click")
1136: 
1137:         *-- cmd_4c_BotConsulta PGV consulta lote (top=405, left=884)
1138:         loc_oPg2.AddObject("cmd_4c_BotConsulta", "CommandButton")
1139:         WITH loc_oPg2.cmd_4c_BotConsulta
1140:             .Top           = 405
1141:             .Left          = 884
1142:             .Width         = 55
1143:             .Height        = 53
1144:             .Caption       = "PGV"
1145:             .FontName      = "Tahoma"
1146:             .FontSize      = 8
1147:             .ForeColor     = RGB(90, 90, 90)
1148:             .BackColor     = RGB(255, 255, 255)
1149:             .Themes        = .F.
1150:             .SpecialEffect = 0
1151:         ENDWITH
1152:         BINDEVENT(loc_oPg2.cmd_4c_BotConsulta, "Click", THIS, "BtnBotConsultaClick")
1153: 
1154:         *-- Grupo Origem (top=456, left=9/115/197)
1155:         loc_oPg2.AddObject("lbl_4c_LblGrupoOs", "Label")
1156:         WITH loc_oPg2.lbl_4c_LblGrupoOs
1157:             .Top      = 459
1158:             .Left     = 9
1159:             .Width    = 100
1160:             .Height   = 18
1161:             .Caption  = "Grupo Orig.:"
1162:             .FontName = "Tahoma"
1163:             .FontSize = 8
1164:             .AutoSize = .F.
1165:         ENDWITH
1166: 
1167:         loc_oPg2.AddObject("txt_4c_GrupoOs", "TextBox")
1168:         WITH loc_oPg2.txt_4c_GrupoOs
1169:             .Top         = 456
1170:             .Left        = 115
1171:             .Width       = 75
1172:             .Height      = 24
1173:             .Value       = ""
1174:             .FontName    = "Tahoma"
1175:             .FontSize    = 8
1176:             .BorderStyle = 1
1177:         ENDWITH
1178:         BINDEVENT(loc_oPg2.txt_4c_GrupoOs, "KeyPress", THIS, "ValidarGrupoOs")
1179: 
1180:         loc_oPg2.AddObject("txt_4c_DGrupoOs", "TextBox")
1181:         WITH loc_oPg2.txt_4c_DGrupoOs
1182:             .Top         = 456
1183:             .Left        = 197
1184:             .Width       = 298
1185:             .Height      = 24
1186:             .Value       = ""
1187:             .FontName    = "Tahoma"
1188:             .FontSize    = 8
1189:             .BorderStyle = 0
1190:             .ReadOnly    = .T.
1191:         ENDWITH
1192: 
1193:         *-- cmd_4c_Command1 PGV Origem (top=456, left=500, cobre linha Grupo+Conta Orig)
1194:         loc_oPg2.AddObject("cmd_4c_Command1", "CommandButton")
1195:         WITH loc_oPg2.cmd_4c_Command1
1196:             .Top           = 456
1197:             .Left          = 500
1198:             .Width         = 31
1199:             .Height        = 48
1200:             .Caption       = "PGV"
1201:             .FontName      = "Tahoma"
1202:             .FontSize      = 7
1203:             .ForeColor     = RGB(90, 90, 90)
1204:             .BackColor     = RGB(255, 255, 255)
1205:             .Themes        = .F.
1206:             .SpecialEffect = 0
1207:         ENDWITH
1208:         BINDEVENT(loc_oPg2.cmd_4c_Command1, "Click", THIS, "BtnCommand1Click")
1209: 
1210:         *-- Conta Origem (top=481, left=9/115/197)
1211:         loc_oPg2.AddObject("lbl_4c_LblContaOs", "Label")
1212:         WITH loc_oPg2.lbl_4c_LblContaOs
1213:             .Top      = 484
1214:             .Left     = 9
1215:             .Width    = 100
1216:             .Height   = 18
1217:             .Caption  = "Conta Orig.:"
1218:             .FontName = "Tahoma"
1219:             .FontSize = 8
1220:             .AutoSize = .F.
1221:         ENDWITH
1222: 
1223:         loc_oPg2.AddObject("txt_4c_ContaOs", "TextBox")
1224:         WITH loc_oPg2.txt_4c_ContaOs
1225:             .Top         = 481
1226:             .Left        = 115
1227:             .Width       = 75
1228:             .Height      = 24
1229:             .Value       = ""
1230:             .FontName    = "Tahoma"
1231:             .FontSize    = 8
1232:             .BorderStyle = 1
1233:         ENDWITH
1234:         BINDEVENT(loc_oPg2.txt_4c_ContaOs, "KeyPress", THIS, "ValidarContaOs")
1235: 
1236:         loc_oPg2.AddObject("txt_4c_DCONTAOs", "TextBox")
1237:         WITH loc_oPg2.txt_4c_DCONTAOs
1238:             .Top         = 481
1239:             .Left        = 197
1240:             .Width       = 298
1241:             .Height      = 24
1242:             .Value       = ""
1243:             .FontName    = "Tahoma"
1244:             .FontSize    = 8
1245:             .BorderStyle = 0
1246:             .ReadOnly    = .T.
1247:         ENDWITH
1248: 
1249:         *-- Grupo Destino (top=506, left=9/115/197)
1250:         loc_oPg2.AddObject("lbl_4c_LblGrupoDs", "Label")
1251:         WITH loc_oPg2.lbl_4c_LblGrupoDs
1252:             .Top      = 509
1253:             .Left     = 9
1254:             .Width    = 100
1255:             .Height   = 18
1256:             .Caption  = "Grupo Dest.:"
1257:             .FontName = "Tahoma"
1258:             .FontSize = 8
1259:             .AutoSize = .F.
1260:         ENDWITH
1261: 
1262:         loc_oPg2.AddObject("txt_4c_GrupoDs", "TextBox")
1263:         WITH loc_oPg2.txt_4c_GrupoDs
1264:             .Top         = 506
1265:             .Left        = 115
1266:             .Width       = 75
1267:             .Height      = 24
1268:             .Value       = ""
1269:             .FontName    = "Tahoma"
1270:             .FontSize    = 8
1271:             .BorderStyle = 1
1272:         ENDWITH
1273:         BINDEVENT(loc_oPg2.txt_4c_GrupoDs, "KeyPress", THIS, "ValidarGrupoDs")
1274: 
1275:         loc_oPg2.AddObject("txt_4c_DGrupoDs", "TextBox")
1276:         WITH loc_oPg2.txt_4c_DGrupoDs
1277:             .Top         = 506
1278:             .Left        = 197
1279:             .Width       = 298
1280:             .Height      = 24
1281:             .Value       = ""
1282:             .FontName    = "Tahoma"
1283:             .FontSize    = 8
1284:             .BorderStyle = 0
1285:             .ReadOnly    = .T.
1286:         ENDWITH
1287: 
1288:         *-- cmd_4c_Command2 PGV Destino (top=506, left=500, cobre linha Grupo+Conta Dest)
1289:         loc_oPg2.AddObject("cmd_4c_Command2", "CommandButton")
1290:         WITH loc_oPg2.cmd_4c_Command2
1291:             .Top           = 506
1292:             .Left          = 500
1293:             .Width         = 31
1294:             .Height        = 48
1295:             .Caption       = "PGV"
1296:             .FontName      = "Tahoma"
1297:             .FontSize      = 7
1298:             .ForeColor     = RGB(90, 90, 90)
1299:             .BackColor     = RGB(255, 255, 255)
1300:             .Themes        = .F.
1301:             .SpecialEffect = 0
1302:         ENDWITH
1303:         BINDEVENT(loc_oPg2.cmd_4c_Command2, "Click", THIS, "BtnCommand2Click")
1304: 
1305:         *-- Conta Destino (top=531, left=9/115/197)
1306:         loc_oPg2.AddObject("lbl_4c_LblContaDs", "Label")
1307:         WITH loc_oPg2.lbl_4c_LblContaDs
1308:             .Top      = 534
1309:             .Left     = 9
1310:             .Width    = 100
1311:             .Height   = 18
1312:             .Caption  = "Conta Dest.:"
1313:             .FontName = "Tahoma"
1314:             .FontSize = 8
1315:             .AutoSize = .F.
1316:         ENDWITH
1317: 
1318:         loc_oPg2.AddObject("txt_4c_ContaDs", "TextBox")
1319:         WITH loc_oPg2.txt_4c_ContaDs
1320:             .Top         = 531
1321:             .Left        = 115
1322:             .Width       = 75
1323:             .Height      = 24
1324:             .Value       = ""
1325:             .FontName    = "Tahoma"
1326:             .FontSize    = 8
1327:             .BorderStyle = 1
1328:         ENDWITH
1329:         BINDEVENT(loc_oPg2.txt_4c_ContaDs, "KeyPress", THIS, "ValidarContaDs")
1330: 
1331:         loc_oPg2.AddObject("txt_4c_DCONTADs", "TextBox")
1332:         WITH loc_oPg2.txt_4c_DCONTADs
1333:             .Top         = 531
1334:             .Left        = 197
1335:             .Width       = 298
1336:             .Height      = 24
1337:             .Value       = ""
1338:             .FontName    = "Tahoma"
1339:             .FontSize    = 8
1340:             .BorderStyle = 0
1341:             .ReadOnly    = .T.
1342:         ENDWITH
1343: 
1344:         *-- Taxa a.m.% label + textbox (top=506, left=548/633)
1345:         loc_oPg2.AddObject("lbl_4c_LblTaxa", "Label")
1346:         WITH loc_oPg2.lbl_4c_LblTaxa
1347:             .Top      = 509
1348:             .Left     = 548
1349:             .Width    = 80
1350:             .Height   = 18
1351:             .Caption  = "Taxa a.m.%:"
1352:             .FontName = "Tahoma"
1353:             .FontSize = 8
1354:             .AutoSize = .F.
1355:         ENDWITH
1356: 
1357:         loc_oPg2.AddObject("txt_4c_Taxa", "TextBox")
1358:         WITH loc_oPg2.txt_4c_Taxa
1359:             .Top         = 506
1360:             .Left        = 633
1361:             .Width       = 66
1362:             .Height      = 24
1363:             .Value       = 0
1364:             .FontName    = "Tahoma"
1365:             .FontSize    = 8
1366:             .BorderStyle = 1
1367:         ENDWITH
1368:         BINDEVENT(loc_oPg2.txt_4c_Taxa, "KeyPress", THIS, "TaxaLostFocus")
1369: 
1370:         *-- Taxa a.d.% label + textbox (top=531, left=548/633)
1371:         loc_oPg2.AddObject("lbl_4c_LblTaxaDia", "Label")
1372:         WITH loc_oPg2.lbl_4c_LblTaxaDia
1373:             .Top      = 534
1374:             .Left     = 548
1375:             .Width    = 80
1376:             .Height   = 18
1377:             .Caption  = "Taxa a.d.%:"
1378:             .FontName = "Tahoma"
1379:             .FontSize = 8
1380:             .AutoSize = .F.
1381:         ENDWITH
1382: 
1383:         loc_oPg2.AddObject("txt_4c_TaxaDia", "TextBox")
1384:         WITH loc_oPg2.txt_4c_TaxaDia
1385:             .Top         = 531
1386:             .Left        = 633
1387:             .Width       = 66
1388:             .Height      = 24
1389:             .Value       = 0
1390:             .FontName    = "Tahoma"
1391:             .FontSize    = 8
1392:             .BorderStyle = 1
1393:         ENDWITH
1394:         BINDEVENT(loc_oPg2.txt_4c_TaxaDia, "KeyPress", THIS, "TaxaDiaLostFocus")
1395: 
1396:         *-- Indicadores S (Simples) / C (Composto) entre Taxa dia e IOF (top=552, left=717/743)
1397:         loc_oPg2.AddObject("lbl_4c_TpJuroS", "Label")
1398:         WITH loc_oPg2.lbl_4c_TpJuroS
1399:             .Top       = 552
1400:             .Left      = 717
1401:             .Width     = 20
1402:             .Height    = 18
1403:             .Caption   = "S"
1404:             .FontName  = "Tahoma"
1405:             .FontSize  = 8
1406:             .FontBold  = .T.
1407:             .ForeColor = RGB(128, 128, 128)
1408:             .AutoSize  = .F.
1409:         ENDWITH
1410: 
1411:         loc_oPg2.AddObject("lbl_4c_TpJuroC", "Label")
1412:         WITH loc_oPg2.lbl_4c_TpJuroC
1413:             .Top       = 552
1414:             .Left      = 743
1415:             .Width     = 20
1416:             .Height    = 18
1417:             .Caption   = "C"
1418:             .FontName  = "Tahoma"
1419:             .FontSize  = 8
1420:             .FontBold  = .T.
1421:             .ForeColor = RGB(128, 128, 128)
1422:             .AutoSize  = .F.
1423:         ENDWITH
1424: 
1425:         *-- Grupo Juros (top=556, left=9/115/197)
1426:         loc_oPg2.AddObject("lbl_4c_LblGruJuro", "Label")
1427:         WITH loc_oPg2.lbl_4c_LblGruJuro
1428:             .Top      = 559
1429:             .Left     = 9
1430:             .Width    = 100
1431:             .Height   = 18
1432:             .Caption  = "Grupo Juros:"
1433:             .FontName = "Tahoma"
1434:             .FontSize = 8

*-- Linhas 1446 a 1584:
1446:             .FontSize    = 8
1447:             .BorderStyle = 1
1448:         ENDWITH
1449:         BINDEVENT(loc_oPg2.txt_4c_GruJuro, "KeyPress", THIS, "ValidarGruJuro")
1450: 
1451:         loc_oPg2.AddObject("txt_4c_DGruJuro", "TextBox")
1452:         WITH loc_oPg2.txt_4c_DGruJuro
1453:             .Top         = 556
1454:             .Left        = 197
1455:             .Width       = 298
1456:             .Height      = 24
1457:             .Value       = ""
1458:             .FontName    = "Tahoma"
1459:             .FontSize    = 8
1460:             .BorderStyle = 0
1461:             .ReadOnly    = .T.
1462:         ENDWITH
1463: 
1464:         *-- IOF a.m.% label + textbox (top=556, left=548/633)
1465:         loc_oPg2.AddObject("lbl_4c_LblTaxaIof", "Label")
1466:         WITH loc_oPg2.lbl_4c_LblTaxaIof
1467:             .Top      = 559
1468:             .Left     = 548
1469:             .Width    = 80
1470:             .Height   = 18
1471:             .Caption  = "IOF a.m.%:"
1472:             .FontName = "Tahoma"
1473:             .FontSize = 8
1474:             .AutoSize = .F.
1475:         ENDWITH
1476: 
1477:         loc_oPg2.AddObject("txt_4c_TaxaIof", "TextBox")
1478:         WITH loc_oPg2.txt_4c_TaxaIof
1479:             .Top         = 556
1480:             .Left        = 633
1481:             .Width       = 66
1482:             .Height      = 24
1483:             .Value       = 0
1484:             .FontName    = "Tahoma"
1485:             .FontSize    = 8
1486:             .BorderStyle = 1
1487:         ENDWITH
1488:         BINDEVENT(loc_oPg2.txt_4c_TaxaIof, "KeyPress", THIS, "TaxaIofLostFocus")
1489: 
1490:         *-- Conta Juros (top=581, left=9/115/197)
1491:         loc_oPg2.AddObject("lbl_4c_LblConJuro", "Label")
1492:         WITH loc_oPg2.lbl_4c_LblConJuro
1493:             .Top      = 584
1494:             .Left     = 9
1495:             .Width    = 100
1496:             .Height   = 18
1497:             .Caption  = "Conta Juros:"
1498:             .FontName = "Tahoma"
1499:             .FontSize = 8
1500:             .AutoSize = .F.
1501:         ENDWITH
1502: 
1503:         loc_oPg2.AddObject("txt_4c_ConJuro", "TextBox")
1504:         WITH loc_oPg2.txt_4c_ConJuro
1505:             .Top         = 581
1506:             .Left        = 115
1507:             .Width       = 75
1508:             .Height      = 24
1509:             .Value       = ""
1510:             .FontName    = "Tahoma"
1511:             .FontSize    = 8
1512:             .BorderStyle = 1
1513:         ENDWITH
1514:         BINDEVENT(loc_oPg2.txt_4c_ConJuro, "KeyPress", THIS, "ValidarConJuro")
1515: 
1516:         loc_oPg2.AddObject("txt_4c_DJuro", "TextBox")
1517:         WITH loc_oPg2.txt_4c_DJuro
1518:             .Top         = 581
1519:             .Left        = 197
1520:             .Width       = 298
1521:             .Height      = 24
1522:             .Value       = ""
1523:             .FontName    = "Tahoma"
1524:             .FontSize    = 8
1525:             .BorderStyle = 0
1526:             .ReadOnly    = .T.
1527:         ENDWITH
1528: 
1529:         THIS.TornarControlesVisiveis(loc_oPg2)
1530: 
1531:         *-- Re-ocultar controles que devem iniciar invisiveis (TornarControlesVisiveis seta Visible=.T. em tudo)
1532:         loc_oPg2.lbl_4c_Label13.Visible    = .F.
1533:         loc_oPg2.txt_4c_LimCart.Visible    = .F.
1534:         loc_oPg2.lbl_4c_Label14.Visible    = .F.
1535:         loc_oPg2.cmd_4c_Protocolos.Visible = .F.
1536:         loc_oPg2.lbl_4c_AvisoPortaM.Visible = .F.
1537:         loc_oPg2.lbl_4c_AvisoPortaT.Visible = .F.
1538:         loc_oPg2.lbl_4c_AvisoPortaS.Visible = .F.
1539:     ENDPROC
1540: 
1541:     *--------------------------------------------------------------------------
1542:     * CarregarLista - Busca lotes no periodo e vincula grid
1543:     *--------------------------------------------------------------------------
1544:     PROCEDURE CarregarLista()
1545:         LOCAL loc_lResultado, loc_cFiltro, loc_cDataIni, loc_cDataFim, loc_oGrid
1546:         loc_lResultado = .F.
1547: 
1548:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1549:             RETURN .T.
1550:         ENDIF
1551: 
1552:         TRY
1553:             *-- Montar filtro de periodo
1554:             loc_cFiltro = ""
1555: 
1556:             IF !EMPTY(THIS.this_dDataIni)
1557:                 loc_cDataIni = FormatarDataSQL(THIS.this_dDataIni)
1558:                 loc_cFiltro  = loc_cFiltro + " AND a.datas >= " + loc_cDataIni
1559:             ENDIF
1560: 
1561:             IF !EMPTY(THIS.this_dDataFim)
1562:                 loc_cDataFim = FormatarDataSQL(THIS.this_dDataFim)
1563:                 loc_cFiltro  = loc_cFiltro + " AND a.datas <= " + loc_cDataFim
1564:             ENDIF
1565: 
1566:             IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
1567:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
1568: 
1569:                 *-- RecordSource FORA do WITH (Problema 36)
1570:                 loc_oGrid.ColumnCount = 3
1571:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
1572: 
1573:                 WITH loc_oGrid
1574:                     .Column1.ControlSource = "cursor_4c_Dados.numlotes"
1575:                     .Column2.ControlSource = "cursor_4c_Dados.datas"
1576:                     .Column3.ControlSource = "cursor_4c_Dados.operas"
1577:                     .Column4.ControlSource = "cursor_4c_Dados.valtots"
1578:                     .Column5.ControlSource = "cursor_4c_Dados.valtjuros"
1579:                     .Column6.ControlSource = "cursor_4c_Dados.datatrans"
1580:                     *-- Re-setar headers apos RecordSource (VFP9 reseta captions)
1581:                     .Column1.Header1.Caption = "Lote"
1582:                     .Column2.Header1.Caption = "Data"
1583:                     .Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1584:                     .Column4.Header1.Caption = "Total"

*-- Linhas 1600 a 1955:
1600:     *--------------------------------------------------------------------------
1601:     * AlternarPagina - Navega entre Page1 (Lista) e Page2 (Dados)
1602:     *--------------------------------------------------------------------------
1603:     PROCEDURE AlternarPagina(par_nPagina)
1604:         LOCAL loc_lResultado
1605:         loc_lResultado = .F.
1606: 
1607:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
1608:             RETURN .F.
1609:         ENDIF
1610: 
1611:         TRY
1612:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1613: 
1614:             IF par_nPagina = 1
1615:                 THIS.this_cModoAtual = "LISTA"
1616:                 THIS.CarregarLista()
1617:             ELSE
1618:                 IF par_nPagina = 2
1619:                     THIS.CarregarPaginaDados()
1620:                 ENDIF
1621:             ENDIF
1622: 
1623:             loc_lResultado = .T.
1624:         CATCH TO loc_oErro
1625:             MsgErro(loc_oErro.Message, "Formche.AlternarPagina")
1626:         ENDTRY
1627: 
1628:         RETURN loc_lResultado
1629:     ENDPROC
1630: 
1631:     *--------------------------------------------------------------------------
1632:     * BtnEncerrarClick - Fecha o formulario
1633:     *--------------------------------------------------------------------------
1634:     PROCEDURE BtnEncerrarClick()
1635:         THIS.Release()
1636:     ENDPROC
1637: 
1638:     *--------------------------------------------------------------------------
1639:     * BtnIncluirClick - Abre Page2 para inclusao de novo lote
1640:     *--------------------------------------------------------------------------
1641:     PROCEDURE BtnIncluirClick()
1642:         LOCAL loc_lResultado
1643:         loc_lResultado = .F.
1644: 
1645:         TRY
1646:             THIS.this_oBusinessObject.NovoRegistro()
1647:             THIS.this_nNumLoteAtual = 0
1648:             THIS.this_cModoAtual    = "INCLUIR"
1649:             THIS.LimparCampos()
1650:             THIS.HabilitarCampos(.T.)
1651:             THIS.AlternarPagina(2)
1652:             loc_lResultado = .T.
1653:         CATCH TO loc_oErro
1654:             MsgErro(loc_oErro.Message, "Formche.BtnIncluirClick")
1655:         ENDTRY
1656: 
1657:         RETURN loc_lResultado
1658:     ENDPROC
1659: 
1660:     *--------------------------------------------------------------------------
1661:     * BtnVisualizarClick - Abre Page2 em modo somente leitura
1662:     *--------------------------------------------------------------------------
1663:     PROCEDURE BtnVisualizarClick()
1664:         LOCAL loc_lResultado, loc_nLote
1665:         loc_lResultado = .F.
1666: 
1667:         *-- Validacao FORA do TRY (Regra Critica VFP9 #1: RETURN nunca dentro de TRY)
1668:         loc_nLote = 0
1669:         IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1670:             loc_nLote = cursor_4c_Dados.numlotes
1671:         ENDIF
1672: 
1673:         IF loc_nLote = 0
1674:             MsgAviso("Selecione um lote na lista.", "Carteira de Cheques")
1675:             RETURN .F.
1676:         ENDIF
1677: 
1678:         TRY
1679:             THIS.this_nNumLoteAtual = loc_nLote
1680: 
1681:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nLote)
1682:                 THIS.this_cModoAtual = "VISUALIZAR"
1683:                 THIS.BOParaForm()
1684:                 THIS.HabilitarCampos(.F.)
1685:                 THIS.AlternarPagina(2)
1686:                 loc_lResultado = .T.
1687:             ENDIF
1688:         CATCH TO loc_oErro
1689:             MsgErro(loc_oErro.Message, "Formche.BtnVisualizarClick")
1690:         ENDTRY
1691: 
1692:         RETURN loc_lResultado
1693:     ENDPROC
1694: 
1695:     *--------------------------------------------------------------------------
1696:     * BtnAlterarClick - Abre Page2 em modo edicao
1697:     *--------------------------------------------------------------------------
1698:     PROCEDURE BtnAlterarClick()
1699:         LOCAL loc_lResultado, loc_nLote
1700:         loc_lResultado = .F.
1701: 
1702:         *-- Validacao FORA do TRY (Regra Critica VFP9 #1: RETURN nunca dentro de TRY)
1703:         loc_nLote = 0
1704:         IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1705:             loc_nLote = cursor_4c_Dados.numlotes
1706:         ENDIF
1707: 
1708:         IF loc_nLote = 0
1709:             MsgAviso("Selecione um lote na lista.", "Carteira de Cheques")
1710:             RETURN .F.
1711:         ENDIF
1712: 
1713:         TRY
1714:             THIS.this_nNumLoteAtual = loc_nLote
1715: 
1716:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nLote)
1717:                 THIS.this_oBusinessObject.EditarRegistro()
1718:                 THIS.this_cModoAtual = "ALTERAR"
1719:                 THIS.BOParaForm()
1720:                 THIS.HabilitarCampos(.T.)
1721:                 THIS.AlternarPagina(2)
1722:                 loc_lResultado = .T.
1723:             ENDIF
1724:         CATCH TO loc_oErro
1725:             MsgErro(loc_oErro.Message, "Formche.BtnAlterarClick")
1726:         ENDTRY
1727: 
1728:         RETURN loc_lResultado
1729:     ENDPROC
1730: 
1731:     *--------------------------------------------------------------------------
1732:     * BtnExcluirClick - Exclui lote selecionado apos confirmacao
1733:     *--------------------------------------------------------------------------
1734:     PROCEDURE BtnExcluirClick()
1735:         LOCAL loc_lResultado, loc_nLote
1736:         loc_lResultado = .F.
1737: 
1738:         *-- Validacao FORA do TRY (Regra Critica VFP9 #1: RETURN nunca dentro de TRY)
1739:         loc_nLote = 0
1740:         IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1741:             loc_nLote = cursor_4c_Dados.numlotes
1742:         ENDIF
1743: 
1744:         IF loc_nLote = 0
1745:             MsgAviso("Selecione um lote na lista.", "Carteira de Cheques")
1746:             RETURN .F.
1747:         ENDIF
1748: 
1749:         TRY
1750:             IF MsgConfirma("Excluir o lote " + LTRIM(STR(loc_nLote)) + "?")
1751:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nLote)
1752:                     IF THIS.this_oBusinessObject.Excluir()
1753:                         THIS.CarregarLista()
1754:                         loc_lResultado = .T.
1755:                     ENDIF
1756:                 ENDIF
1757:             ENDIF
1758:         CATCH TO loc_oErro
1759:             MsgErro(loc_oErro.Message, "Formche.BtnExcluirClick")
1760:         ENDTRY
1761: 
1762:         RETURN loc_lResultado
1763:     ENDPROC
1764: 
1765:     *--------------------------------------------------------------------------
1766:     * BtnBuscarClick - Aplica filtro de periodo e recarrega lista
1767:     *--------------------------------------------------------------------------
1768:     PROCEDURE BtnBuscarClick()
1769:         TRY
1770:             THIS.this_dDataIni = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtInicial.Value
1771:             THIS.this_dDataFim = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtFinal.Value
1772:             THIS.CarregarLista()
1773:         CATCH TO loc_oErro
1774:             MsgErro(loc_oErro.Message, "Formche.BtnBuscarClick")
1775:         ENDTRY
1776:     ENDPROC
1777: 
1778:     *--------------------------------------------------------------------------
1779:     * BtnLimpaDTClick - Limpa data de transporte do lote selecionado
1780:     *--------------------------------------------------------------------------
1781:     PROCEDURE BtnLimpaDTClick()
1782:         LOCAL loc_lResultado, loc_nLote, loc_nRet
1783:         loc_lResultado = .F.
1784: 
1785:         TRY
1786:             loc_nLote = 0
1787:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1788:                 loc_nLote = cursor_4c_Dados.numlotes
1789:             ENDIF
1790: 
1791:             IF loc_nLote = 0
1792:                 MsgAviso("Selecione um lote na lista.", "Limpar Data Transporte")
1793:                 loc_lResultado = .F.
1794:             ENDIF
1795: 
1796:             IF MsgConfirma("Limpar data de transporte do lote " + LTRIM(STR(loc_nLote)) + "?")
1797:                 loc_nRet = SQLEXEC(gnConnHandle, ;
1798:                     "UPDATE SigCqLcm SET datatrans = NULL WHERE NumLotes = " + ;
1799:                     FormatarNumeroSQL(loc_nLote))
1800: 
1801:                 IF loc_nRet > 0
1802:                     SQLEXEC(gnConnHandle, ;
1803:                         "UPDATE SigCcChm SET datatrans = NULL WHERE numlotes = " + ;
1804:                         FormatarNumeroSQL(loc_nLote))
1805:                 ENDIF
1806: 
1807:                 THIS.CarregarLista()
1808:                 loc_lResultado = .T.
1809:             ENDIF
1810:         CATCH TO loc_oErro
1811:             MsgErro(loc_oErro.Message, "Formche.BtnLimpaDTClick")
1812:         ENDTRY
1813: 
1814:         RETURN loc_lResultado
1815:     ENDPROC
1816: 
1817:     *--------------------------------------------------------------------------
1818:     * DtInicialLostFocus - Valida data inicial e recarrega lista
1819:     *--------------------------------------------------------------------------
1820:     PROCEDURE DtInicialLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1821:         LOCAL loc_dIni
1822:         TRY
1823:             loc_dIni = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtInicial.Value
1824: 
1825:             IF VARTYPE(loc_dIni) = "D"
1826:                 THIS.this_dDataIni = loc_dIni
1827:             ELSE
1828:                 THIS.this_dDataIni = {}
1829:             ENDIF
1830: 
1831:             IF !EMPTY(THIS.this_dDataIni) AND !EMPTY(THIS.this_dDataFim)
1832:                 IF THIS.this_dDataIni > THIS.this_dDataFim
1833:                     MsgAviso("Data inicial maior que a data final.", ;
1834:                         "Per" + CHR(237) + "odo")
1835:                     THIS.this_dDataIni = {}
1836:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtInicial.Value = {}
1837:                     RETURN
1838:                 ENDIF
1839:             ENDIF
1840: 
1841:             THIS.CarregarLista()
1842:         CATCH TO loc_oErro
1843:             MsgErro(loc_oErro.Message, "Formche.DtInicialLostFocus")
1844:         ENDTRY
1845:     ENDPROC
1846: 
1847:     *--------------------------------------------------------------------------
1848:     * DtFinalLostFocus - Valida data final e recarrega lista
1849:     *--------------------------------------------------------------------------
1850:     PROCEDURE DtFinalLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1851:         LOCAL loc_dFim
1852:         TRY
1853:             loc_dFim = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtFinal.Value
1854: 
1855:             IF VARTYPE(loc_dFim) = "D"
1856:                 THIS.this_dDataFim = loc_dFim
1857:             ELSE
1858:                 THIS.this_dDataFim = {}
1859:             ENDIF
1860: 
1861:             IF !EMPTY(THIS.this_dDataIni) AND !EMPTY(THIS.this_dDataFim)
1862:                 IF THIS.this_dDataFim < THIS.this_dDataIni
1863:                     MsgAviso("Data final menor que a data inicial.", ;
1864:                         "Per" + CHR(237) + "odo")
1865:                     THIS.this_dDataFim = {}
1866:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtFinal.Value = {}
1867:                     RETURN
1868:                 ENDIF
1869:             ENDIF
1870: 
1871:             THIS.CarregarLista()
1872:         CATCH TO loc_oErro
1873:             MsgErro(loc_oErro.Message, "Formche.DtFinalLostFocus")
1874:         ENDTRY
1875:     ENDPROC
1876: 
1877:     *--------------------------------------------------------------------------
1878:     * HabilitarCampos - Habilita/desabilita campos de edicao (expandido na Fase 5)
1879:     *--------------------------------------------------------------------------
1880:     PROCEDURE HabilitarCampos(par_lHabilitar)
1881:         LOCAL loc_oPg2
1882:         TRY
1883:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1884:             WITH loc_oPg2
1885:                 .txt_4c_OperL.ReadOnly           = !par_lHabilitar
1886:                 .txt_4c_Data.ReadOnly            = !par_lHabilitar
1887:                 .txt_4c_GrupoT.ReadOnly          = !par_lHabilitar
1888:                 .txt_4c_Moeda.ReadOnly           = !par_lHabilitar
1889:                 .txt_4c_Cotacao.ReadOnly         = !par_lHabilitar
1890:                 .grd_4c_GradeCheque.ReadOnly     = !par_lHabilitar
1891:                 .cmd_4c_ExcCheque.Enabled        = par_lHabilitar
1892:                 .txt_4c_GrupoOs.ReadOnly         = !par_lHabilitar
1893:                 .txt_4c_ContaOs.ReadOnly         = !par_lHabilitar
1894:                 .txt_4c_GrupoDs.ReadOnly         = !par_lHabilitar
1895:                 .txt_4c_ContaDs.ReadOnly         = !par_lHabilitar
1896:                 .txt_4c_GruJuro.ReadOnly         = !par_lHabilitar
1897:                 .txt_4c_ConJuro.ReadOnly         = !par_lHabilitar
1898:                 .txt_4c_Taxa.ReadOnly            = !par_lHabilitar
1899:                 .txt_4c_TaxaDia.ReadOnly         = !par_lHabilitar
1900:                 .txt_4c_TaxaIof.ReadOnly         = !par_lHabilitar
1901:                 .cmd_4c_BotConsulta.Enabled      = par_lHabilitar
1902:                 .cmd_4c_Command1.Enabled         = par_lHabilitar
1903:                 .cmd_4c_Command2.Enabled         = par_lHabilitar
1904:                 .cmd_4c_Command3.Enabled         = par_lHabilitar
1905:                 .cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
1906:             ENDWITH
1907:         CATCH TO loc_oErro
1908:             MsgErro(loc_oErro.Message, "Formche.HabilitarCampos")
1909:         ENDTRY
1910:     ENDPROC
1911: 
1912:     *--------------------------------------------------------------------------
1913:     * LimparCampos - Reseta estado do lote corrente
1914:     *--------------------------------------------------------------------------
1915:     PROCEDURE LimparCampos()
1916:         LOCAL loc_oPg2
1917:         TRY
1918:             THIS.this_nNumLoteAtual = 0
1919:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1920:             WITH loc_oPg2
1921:                 .txt_4c_Lote.Value    = 0
1922:                 .txt_4c_Data.Value    = {}
1923:                 .txt_4c_DtMovs.Value  = {}
1924:                 .txt_4c_OperL.Value   = ""
1925:                 .txt_4c_Opera.Value   = ""
1926:                 .txt_4c_LimCart.Value = ""
1927:                 .txt_4c_GrupoT.Value  = ""
1928:                 .txt_4c_DGrupoT.Value = ""
1929:                 .txt_4c_Valor.Value   = 0
1930:                 .txt_4c_TJUROS.Value  = 0
1931:                 .txt_4c_TLiq.Value    = 0
1932:                 .txt_4c_Moeda.Value   = ""
1933:                 .txt_4c_Cotacao.Value = 0
1934:                 .txt_4c_ValConv.Value = 0
1935:                 .txt_4c_GrupoOs.Value  = ""
1936:                 .txt_4c_DGrupoOs.Value = ""
1937:                 .txt_4c_ContaOs.Value  = ""
1938:                 .txt_4c_DCONTAOs.Value = ""
1939:                 .txt_4c_GrupoDs.Value  = ""
1940:                 .txt_4c_DGrupoDs.Value = ""
1941:                 .txt_4c_ContaDs.Value  = ""
1942:                 .txt_4c_DCONTADs.Value = ""
1943:                 .txt_4c_GruJuro.Value  = ""
1944:                 .txt_4c_DGruJuro.Value = ""
1945:                 .txt_4c_ConJuro.Value  = ""
1946:                 .txt_4c_DJuro.Value    = ""
1947:                 .txt_4c_Taxa.Value     = 0
1948:                 .txt_4c_TaxaDia.Value  = 0
1949:                 .txt_4c_TaxaIof.Value  = 0
1950:             ENDWITH
1951:             IF USED("TempChq")
1952:                 SELECT TempChq
1953:                 SET ORDER TO
1954:                 ZAP
1955:             ENDIF

*-- Linhas 1961 a 2004:
1961:     *--------------------------------------------------------------------------
1962:     * BOParaForm - Copia dados do BO para controles do form (expandido na Fase 5)
1963:     *--------------------------------------------------------------------------
1964:     PROCEDURE BOParaForm()
1965:         LOCAL loc_oPg2, loc_oBO, loc_nRet
1966:         TRY
1967:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1968:                 loc_oBO  = THIS.this_oBusinessObject
1969:                 loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1970:                 THIS.this_nNumLoteAtual = loc_oBO.this_nNumLote
1971:                 WITH loc_oPg2
1972:                     .txt_4c_Lote.Value    = loc_oBO.this_nNumLote
1973:                     .txt_4c_Data.Value    = loc_oBO.this_dData
1974:                     .txt_4c_DtMovs.Value  = loc_oBO.this_dDtMovs
1975:                     .txt_4c_OperL.Value   = ALLTRIM(loc_oBO.this_cOperL)
1976:                     .txt_4c_Opera.Value   = ALLTRIM(loc_oBO.this_cOpera)
1977:                     .txt_4c_LimCart.Value = ALLTRIM(loc_oBO.this_cLimCart)
1978:                     .txt_4c_GrupoT.Value  = ALLTRIM(loc_oBO.this_cGrupoT)
1979:                     .txt_4c_DGrupoT.Value = ALLTRIM(loc_oBO.this_cDGrupoT)
1980:                     .txt_4c_Valor.Value   = loc_oBO.this_nValor
1981:                     .txt_4c_TJUROS.Value  = loc_oBO.this_nTJuros
1982:                     .txt_4c_TLiq.Value    = loc_oBO.this_nTLiq
1983:                     .txt_4c_Moeda.Value   = ALLTRIM(loc_oBO.this_cMoeda)
1984:                     .txt_4c_Cotacao.Value = loc_oBO.this_nCotacao
1985:                     .txt_4c_ValConv.Value = loc_oBO.this_nValConv
1986:                     .txt_4c_GrupoOs.Value  = ALLTRIM(loc_oBO.this_cGrupoOs)
1987:                     .txt_4c_ContaOs.Value  = ALLTRIM(loc_oBO.this_cContaOs)
1988:                     .txt_4c_GrupoDs.Value  = ALLTRIM(loc_oBO.this_cGrupoDs)
1989:                     .txt_4c_ContaDs.Value  = ALLTRIM(loc_oBO.this_cContaDs)
1990:                     .txt_4c_GruJuro.Value  = ALLTRIM(loc_oBO.this_cGruJuro)
1991:                     .txt_4c_ConJuro.Value  = ALLTRIM(loc_oBO.this_cConJuro)
1992:                     .txt_4c_Taxa.Value     = loc_oBO.this_nTaxaMes
1993:                     .txt_4c_TaxaDia.Value  = loc_oBO.this_nTaxaDia
1994:                     .txt_4c_TaxaIof.Value  = loc_oBO.this_nTaxaIof
1995:                 ENDWITH
1996:                 *-- Buscar descricao do Grupo Terceiro se codigo preenchido
1997:                 IF !EMPTY(ALLTRIM(loc_oBO.this_cGrupoT))
1998:                     IF USED("cursor_4c_GrupoTDesc")
1999:                         USE IN cursor_4c_GrupoTDesc
2000:                     ENDIF
2001:                     loc_nRet = SQLEXEC(gnConnHandle, ;
2002:                         "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
2003:                         EscaparSQL(ALLTRIM(loc_oBO.this_cGrupoT)), ;
2004:                         "cursor_4c_GrupoTDesc")

*-- Linhas 2112 a 2324:
2112:     *--------------------------------------------------------------------------
2113:     * FormParaBO - Copia dados dos controles para o BO (implementado na Fase 5)
2114:     *--------------------------------------------------------------------------
2115:     PROCEDURE FormParaBO()
2116:         LOCAL loc_oPg2, loc_oBO, loc_nTotal, loc_nJuros
2117:         TRY
2118:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2119:                 loc_oBO  = THIS.this_oBusinessObject
2120:                 loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2121:                 loc_oBO.this_dData    = loc_oPg2.txt_4c_Data.Value
2122:                 loc_oBO.this_cOperL   = ALLTRIM(loc_oPg2.txt_4c_OperL.Value)
2123:                 loc_oBO.this_cOpera   = ALLTRIM(loc_oPg2.txt_4c_Opera.Value)
2124:                 loc_oBO.this_cLimCart = ALLTRIM(loc_oPg2.txt_4c_LimCart.Value)
2125:                 loc_oBO.this_cGrupoT  = ALLTRIM(loc_oPg2.txt_4c_GrupoT.Value)
2126:                 loc_oBO.this_cMoeda   = ALLTRIM(loc_oPg2.txt_4c_Moeda.Value)
2127:                 loc_oBO.this_nCotacao = loc_oPg2.txt_4c_Cotacao.Value
2128:                 loc_oBO.this_nValConv = loc_oPg2.txt_4c_ValConv.Value
2129:                 loc_oBO.this_cGrupoOs = ALLTRIM(loc_oPg2.txt_4c_GrupoOs.Value)
2130:                 loc_oBO.this_cContaOs = ALLTRIM(loc_oPg2.txt_4c_ContaOs.Value)
2131:                 loc_oBO.this_cGrupoDs = ALLTRIM(loc_oPg2.txt_4c_GrupoDs.Value)
2132:                 loc_oBO.this_cContaDs = ALLTRIM(loc_oPg2.txt_4c_ContaDs.Value)
2133:                 loc_oBO.this_cGruJuro = ALLTRIM(loc_oPg2.txt_4c_GruJuro.Value)
2134:                 loc_oBO.this_cConJuro = ALLTRIM(loc_oPg2.txt_4c_ConJuro.Value)
2135:                 loc_oBO.this_nTaxaMes = loc_oPg2.txt_4c_Taxa.Value
2136:                 loc_oBO.this_nTaxaDia = loc_oPg2.txt_4c_TaxaDia.Value
2137:                 loc_oBO.this_nTaxaIof = loc_oPg2.txt_4c_TaxaIof.Value
2138:                 *-- Calcular totais a partir de TempChq
2139:                 loc_nTotal = 0
2140:                 loc_nJuros = 0
2141:                 IF USED("TempChq")
2142:                     SELECT TempChq
2143:                     SCAN
2144:                         IF !EMPTY(ALLTRIM(TempChq.Bancos)) OR !EMPTY(ALLTRIM(TempChq.NCheques))
2145:                             loc_nTotal = loc_nTotal + TempChq.Valors
2146:                             loc_nJuros = loc_nJuros + TempChq.Valjuros
2147:                         ENDIF
2148:                     ENDSCAN
2149:                 ENDIF
2150:                 loc_oBO.this_nValor  = loc_nTotal
2151:                 loc_oBO.this_nTJuros = loc_nJuros
2152:                 loc_oBO.this_nTLiq   = loc_nTotal - loc_nJuros
2153:             ENDIF
2154:         CATCH TO loc_oErro
2155:             MsgErro(loc_oErro.Message, "Formche.FormParaBO")
2156:         ENDTRY
2157:     ENDPROC
2158: 
2159:     *--------------------------------------------------------------------------
2160:     * Destroy - Libera recursos
2161:     *--------------------------------------------------------------------------
2162:     PROCEDURE Destroy()
2163:         TRY
2164:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2165:                 THIS.this_oBusinessObject = .NULL.
2166:             ENDIF
2167: 
2168:             IF USED("cursor_4c_Dados")
2169:                 USE IN cursor_4c_Dados
2170:             ENDIF
2171: 
2172:             IF USED("TempChq")
2173:                 USE IN TempChq
2174:             ENDIF
2175: 
2176:             DODEFAULT()
2177:         CATCH TO loc_oErro
2178:             MsgErro(loc_oErro.Message, "Formche.Destroy")
2179:         ENDTRY
2180:     ENDPROC
2181: 
2182:     *--------------------------------------------------------------------------
2183:     * FormatarGridLista - Formata visual do grid da lista
2184:     *--------------------------------------------------------------------------
2185:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
2186:         WITH par_oGrid
2187:             .FontName = "Tahoma"
2188:             .FontSize = 8
2189:         ENDWITH
2190:     ENDPROC
2191: 
2192:     *--------------------------------------------------------------------------
2193:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
2194:     *--------------------------------------------------------------------------
2195:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2196:         LOCAL loc_nI, loc_oObjeto, loc_nP
2197: 
2198:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2199:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2200: 
2201:             IF VARTYPE(loc_oObjeto) = "O"
2202:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2203:                     loc_oObjeto.Visible = .T.
2204:                 ENDIF
2205: 
2206:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2207:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2208:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2209:                     ENDFOR
2210:                 ENDIF
2211: 
2212:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2213:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2214:                 ENDIF
2215:             ENDIF
2216:         ENDFOR
2217:     ENDPROC
2218: 
2219:     *--------------------------------------------------------------------------
2220:     * BtnSalvarClick - Confirma e salva cabecalho do lote (SigCqLcm)
2221:     *--------------------------------------------------------------------------
2222:     PROCEDURE BtnSalvarClick()
2223:         LOCAL loc_lResultado, loc_oBO, loc_oPg2
2224:         loc_lResultado = .F.
2225: 
2226:         TRY
2227:             loc_oBO  = THIS.this_oBusinessObject
2228:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2229: 
2230:             IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_OperL.Value))
2231:                 MsgAviso("Opera" + CHR(231) + CHR(227) + "o de lote inv" + CHR(225) + "lida.", "Confirmar")
2232:                 loc_oPg2.txt_4c_OperL.SetFocus()
2233:                 loc_lResultado = .F.
2234:             ENDIF
2235: 
2236:             IF EMPTY(loc_oPg2.txt_4c_Data.Value)
2237:                 MsgAviso("Data base obrigat" + CHR(243) + "ria.", "Confirmar")
2238:                 loc_oPg2.txt_4c_Data.SetFocus()
2239:                 loc_lResultado = .F.
2240:             ENDIF
2241: 
2242:             IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Moeda.Value))
2243:                 MsgAviso("Moeda obrigat" + CHR(243) + "ria.", "Confirmar")
2244:                 loc_oPg2.txt_4c_Moeda.SetFocus()
2245:                 loc_lResultado = .F.
2246:             ENDIF
2247: 
2248:             IF !USED("TempChq") OR RECCOUNT("TempChq") = 0
2249:                 MsgAviso("Nenhum cheque adicionado ao lote.", "Confirmar")
2250:                 loc_lResultado = .F.
2251:             ENDIF
2252: 
2253:             THIS.FormParaBO()
2254: 
2255:             IF loc_oBO.Salvar()
2256:                 THIS.this_cModoAtual = "LISTA"
2257:                 THIS.AlternarPagina(1)
2258:                 loc_lResultado = .T.
2259:             ENDIF
2260:         CATCH TO loc_oErro
2261:             MsgErro(loc_oErro.Message, "Formche.BtnSalvarClick")
2262:         ENDTRY
2263: 
2264:         RETURN loc_lResultado
2265:     ENDPROC
2266: 
2267:     *--------------------------------------------------------------------------
2268:     * BtnCancelarClick - Cancela edicao e retorna para lista
2269:     *--------------------------------------------------------------------------
2270:     PROCEDURE BtnCancelarClick()
2271:         TRY
2272:             THIS.this_cModoAtual = "LISTA"
2273:             THIS.AlternarPagina(1)
2274:         CATCH TO loc_oErro
2275:             MsgErro(loc_oErro.Message, "Formche.BtnCancelarClick")
2276:         ENDTRY
2277:     ENDPROC
2278: 
2279:     *--------------------------------------------------------------------------
2280:     * CarregarPaginaDados - Cria/atualiza TempChq e vincula grd_4c_GradeCheque
2281:     * INCLUIR: grade vazia (1 linha em branco p/ empresa)
2282:     * VISUALIZAR/ALTERAR: carrega SigCcChm JOIN SigChe JOIN SigCdCli
2283:     *--------------------------------------------------------------------------
2284:     PROCEDURE CarregarPaginaDados()
2285:         LOCAL loc_lResultado, loc_cSQL, loc_nRet, loc_oGrid, loc_oPg2
2286:         loc_lResultado = .F.
2287: 
2288:         TRY
2289:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2290: 
2291:             IF USED("TempChq")
2292:                 SELECT TempChq
2293:                 SET ORDER TO
2294:                 ZAP
2295:             ELSE
2296:                 CREATE CURSOR TempChq ( ;
2297:                     Bancos    C(3),   Agencias  C(4),  NContas   C(10), NCheques C(6),  ;
2298:                     Vencs     D(8),   Valors    N(12,2), cpft     C(20), Nomet    C(40), ;
2299:                     Obss      C(40),  emps      C(3),  Iclis     C(10), Grclis   C(10), ;
2300:                     contas    C(10),  grupos    C(10), valpags   N(12,2), grucarts C(10), ;
2301:                     concarts  C(10),  valjuros  N(12,2), nums    C(8),  Protocolos C(8), ;
2302:                     grupoT    C(10),  contaT    C(10), leituras  C(34), devolvido C(1),  ;
2303:                     moeds     C(3),   cotas     N(11,4) )
2304:             ENDIF
2305: 
2306:             IF THIS.this_nNumLoteAtual > 0
2307:                 *-- Carregar cheques via JOIN SigCcChm x SigChe x SigCdCli
2308:                 loc_cSQL = ;
2309:                     "SELECT c.bancos, c.agencias, c.ncontas, c.ncheques, c.obss, c.emps," + ;
2310:                     " ISNULL(h.vencs,  NULL)    AS vencs,"    + ;
2311:                     " ISNULL(h.valors,  0)      AS valors,"   + ;
2312:                     " ISNULL(h.valpags, 0)      AS valpags,"  + ;
2313:                     " ISNULL(h.iclis,   '')     AS iclis,"    + ;
2314:                     " ISNULL(h.grclis,  '')     AS grclis,"   + ;
2315:                     " ISNULL(h.contas,  '')     AS contas,"   + ;
2316:                     " ISNULL(h.grupos,  '')     AS grupos,"   + ;
2317:                     " ISNULL(h.nums,    '')     AS nums,"     + ;
2318:                     " ISNULL(h.grupot,  '')     AS grupot,"   + ;
2319:                     " ISNULL(h.contat,  '')     AS contat,"   + ;
2320:                     " ISNULL(h.moeds,   '')     AS moeds,"    + ;
2321:                     " ISNULL(h.cotas,    0)     AS cotas,"    + ;
2322:                     " ISNULL(h.grucarts, '')    AS grucarts," + ;
2323:                     " ISNULL(h.concarts, '')    AS concarts," + ;
2324:                     " ISNULL(h.protocolos, '')  AS protocolos," + ;

*-- Linhas 2409 a 2575:
2409:     *--------------------------------------------------------------------------
2410:     * BtnExcChequeClick - Exclui cheque corrente de TempChq e atualiza grade
2411:     *--------------------------------------------------------------------------
2412:     PROCEDURE BtnExcChequeClick()
2413:         LOCAL loc_oGrid
2414:         TRY
2415:             IF USED("TempChq") AND !EOF("TempChq")
2416:                 SELECT TempChq
2417:                 DELETE
2418:                 SKIP
2419:                 IF EOF("TempChq")
2420:                     SKIP -1
2421:                     IF BOF("TempChq")
2422:                         APPEND BLANK
2423:                         REPLACE TempChq.emps WITH go_4c_Sistema.cCodEmpresa
2424:                         GO TOP
2425:                     ENDIF
2426:                 ENDIF
2427:             ENDIF
2428:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_GradeCheque
2429:             loc_oGrid.Refresh()
2430:         CATCH TO loc_oErro
2431:             MsgErro(loc_oErro.Message, "Formche.BtnExcChequeClick")
2432:         ENDTRY
2433:     ENDPROC
2434: 
2435:     *--------------------------------------------------------------------------
2436:     * BtnImprimeClick - Imprime relatorio SigMvChe para o lote corrente
2437:     *--------------------------------------------------------------------------
2438:     *-- ============================================================
2439:     *-- PROCEDURE ExecutarReportForm (Pattern #117 / #123)
2440:     *-- Executa REPORT FORM apenas se o FRX existir; caso contrario,
2441:     *-- exibe MostrarErro descritivo com o path faltante.
2442:     *-- Isola SET POINT/SEPARATOR/REPORTBEHAVIOR durante o REPORT FORM
2443:     *-- porque FRXs legados Fortyus (VFP6/7/8) foram desenhados com
2444:     *-- POINT="." + REPORTBEHAVIOR 80. Sem isolamento o modo 90 remede
2445:     *-- fontes em runtime e mostra asteriscos em campos numericos.
2446:     *-- par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
2447:     *-- par_cCursorDados: opcional. Se informado e cursor estiver vazio,
2448:     *--   mostra MsgAviso e retorna .F. sem abrir preview vazio.
2449:     *-- ============================================================
2450:     PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
2451:         LOCAL loc_cFRX
2452:         loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")
2453: 
2454:         IF NOT FILE(loc_cFRX)
2455:             MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
2456:                 loc_cFRX + CHR(13) + CHR(13) + ;
2457:                 "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
2458:             RETURN .F.
2459:         ENDIF
2460: 
2461:         *-- Guard cursor vazio: evita preview em branco / impressao vazia (Erro30)
2462:         IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
2463:             IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
2464:                 MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
2465:                     "Aten" + CHR(231) + CHR(227) + "o")
2466:                 RETURN .F.
2467:             ENDIF
2468:         ENDIF
2469: 
2470:         *-- Isolamento de locale + modo de renderizacao (Erro28)
2471:         LOCAL loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig
2472:         loc_cPointOrig    = SET("POINT")
2473:         loc_cSepOrig      = SET("SEPARATOR")
2474:         loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
2475:         SET POINT TO "."
2476:         SET SEPARATOR TO ","
2477:         SET REPORTBEHAVIOR 80
2478: 
2479:         DO CASE
2480:             CASE par_cModo == "PREVIEW"
2481:                 REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
2482:             CASE par_cModo == "PRINTER_PROMPT"
2483:                 REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
2484:             CASE par_cModo == "PRINTER"
2485:                 REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
2486:         ENDCASE
2487: 
2488:         SET POINT TO (loc_cPointOrig)
2489:         SET SEPARATOR TO (loc_cSepOrig)
2490:         SET REPORTBEHAVIOR (loc_nBehaviorOrig)
2491: 
2492:         *-- Restaurar menu (Erro63): REPORT FORM PREVIEW abre toolbar propria
2493:         *-- que corrompe cache visual do _MSYSMENU. Sem RELEASE + Criar aqui,
2494:         *-- popups renderizam encolhidos apos preview fechar. Mesmo fix do
2495:         *-- FormBase.Destroy (Erro58) precisa rodar no path REPORT PREVIEW.
2496:         TRY
2497:             SET SYSMENU TO DEFAULT
2498:             RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda
2499:             CriarMenuPrincipal()
2500:         CATCH
2501:             *-- CriarMenuPrincipal fora do escopo (teste automatizado) - silencioso
2502:         ENDTRY
2503: 
2504:         RETURN .T.
2505:     ENDPROC
2506: 
2507:     PROCEDURE BtnImprimeClick()
2508:         LOCAL loc_lResultado, loc_cSQL, loc_nRet, loc_cRel, loc_cPoint, loc_cSep
2509:         loc_lResultado = .F.
2510: 
2511:         TRY
2512:             IF THIS.this_nNumLoteAtual <= 0
2513:                 MsgAviso("Salve o lote antes de imprimir.", "Relat" + CHR(243) + "rio")
2514:                 loc_lResultado = .F.
2515:             ENDIF
2516: 
2517:             loc_cRel = gc_4c_CaminhoReports + "SigMvChe.frx"
2518: 
2519:             IF !FILE(loc_cRel)
2520:                 MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + ;
2521:                     CHR(13) + loc_cRel, "Imprimir")
2522:                 loc_lResultado = .F.
2523:             ENDIF
2524: 
2525:             loc_cSQL = "SELECT * FROM SigCcChm WHERE numlotes = " + ;
2526:                 FormatarNumeroSQL(THIS.this_nNumLoteAtual)
2527: 
2528:             IF USED("cursor_4c_Rel")
2529:                 USE IN cursor_4c_Rel
2530:             ENDIF
2531: 
2532:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Rel")
2533: 
2534:             IF loc_nRet < 0 OR !USED("cursor_4c_Rel") OR RECCOUNT("cursor_4c_Rel") = 0
2535:                 MsgAviso("Nenhum cheque encontrado para impress" + CHR(227) + "o.", "Imprimir")
2536:                 IF USED("cursor_4c_Rel")
2537:                     USE IN cursor_4c_Rel
2538:                 ENDIF
2539:                 loc_lResultado = .F.
2540:             ENDIF
2541: 
2542:             IF USED("cursor_4c_RelFinal")
2543:                 USE IN cursor_4c_RelFinal
2544:             ENDIF
2545: 
2546:             IF USED("TempChq") AND RECCOUNT("TempChq") > 0
2547:                 SELECT a.*, b.valjuros AS valjur ;
2548:                     FROM TempChq a, cursor_4c_Rel b ;
2549:                     WHERE a.bancos = b.bancos AND a.agencias = b.agencias ;
2550:                     AND a.ncontas = b.ncontas AND a.ncheques = b.ncheques ;
2551:                     INTO CURSOR cursor_4c_RelFinal
2552:             ELSE
2553:                 SELECT * FROM cursor_4c_Rel INTO CURSOR cursor_4c_RelFinal
2554:             ENDIF
2555: 
2556:             IF USED("cursor_4c_Rel")
2557:                 USE IN cursor_4c_Rel
2558:             ENDIF
2559: 
2560:             IF USED("cursor_4c_RelFinal") AND RECCOUNT("cursor_4c_RelFinal") > 0
2561:                 SELECT cursor_4c_RelFinal
2562:                 GO TOP
2563:                 loc_cPoint = SET("Point")
2564:                 loc_cSep   = SET("Separator")
2565:                 SET POINT TO "."
2566:                 SET SEPARATOR TO ","
2567:                 SET REPORTBEHAVIOR 80
2568:                 THIS.ExecutarReportForm("SigMvChe", "PREVIEW")
2569:                 SET POINT TO (loc_cPoint)
2570:                 SET SEPARATOR TO (loc_cSep)
2571:                 SET REPORTBEHAVIOR 90
2572:                 SET SYSMENU TO DEFAULT
2573:                 TRY
2574:                     CriarMenuPrincipal()
2575:                 CATCH TO loc_oErroMenu

*-- Linhas 2591 a 2688:
2591:     * ValidarOperL - LostFocus: lookup de operacao de carteira (SigCdOpt)
2592:     * Preenche txt_4c_Opera (S/E/' ') e txt_4c_Moeda default da operacao
2593:     *--------------------------------------------------------------------------
2594:     PROCEDURE ValidarOperL(par_nKeyCode, par_nShiftAltCtrl)
2595:         LOCAL loc_oLookup, loc_cVal, loc_oPg2
2596:         TRY
2597:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2598:             loc_cVal = ALLTRIM(loc_oPg2.txt_4c_OperL.Value)
2599: 
2600:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
2601:                 gnConnHandle, "SigCdOpt", "cursor_4c_OperLPick", ;
2602:                 "Operacaos", loc_cVal, ;
2603:                 "Opera" + CHR(231) + CHR(245) + "es")
2604: 
2605:             IF VARTYPE(loc_oLookup) != "O"
2606:                 RETURN
2607:             ENDIF
2608: 
2609:             IF !loc_oLookup.this_lSelecionou
2610:                 loc_oLookup.Show()
2611:                 IF !loc_oLookup.this_lSelecionou
2612:                     loc_oLookup.Release()
2613:                     RETURN
2614:                 ENDIF
2615:             ENDIF
2616: 
2617:             IF USED("cursor_4c_OperLPick") AND RECCOUNT("cursor_4c_OperLPick") > 0
2618:                 SELECT cursor_4c_OperLPick
2619:                 GO TOP
2620:                 loc_oPg2.txt_4c_OperL.Value = ALLTRIM(cursor_4c_OperLPick.Operacaos)
2621:                 *-- opera: S=entrada(DB), E=saida, ' '=transferencia(TR)
2622:                 loc_oPg2.txt_4c_Opera.Value = IIF(ALLTRIM(cursor_4c_OperLPick.tipos) = "TR", " ", ;
2623:                     IIF(ALLTRIM(cursor_4c_OperLPick.tipos) = "DB", "S", "E"))
2624:                 *-- Moeda default da operacao
2625:                 IF !EMPTY(ALLTRIM(cursor_4c_OperLPick.moeds))
2626:                     loc_oPg2.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_OperLPick.moeds)
2627:                 ENDIF
2628:             ENDIF
2629: 
2630:             IF USED("cursor_4c_OperLPick")
2631:                 USE IN cursor_4c_OperLPick
2632:             ENDIF
2633:             loc_oLookup.Release()
2634:         CATCH TO loc_oErro
2635:             MsgErro(loc_oErro.Message, "Formche.ValidarOperL")
2636:         ENDTRY
2637:     ENDPROC
2638: 
2639:     *--------------------------------------------------------------------------
2640:     * ValidarMoeda - LostFocus: lookup de moeda (SigCdMoe) + cotacao
2641:     *--------------------------------------------------------------------------
2642:     PROCEDURE ValidarMoeda(par_nKeyCode, par_nShiftAltCtrl)
2643:         LOCAL loc_oLookup, loc_cVal, loc_oPg2, loc_nRet
2644:         TRY
2645:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2646:             loc_cVal = ALLTRIM(loc_oPg2.txt_4c_Moeda.Value)
2647: 
2648:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
2649:                 gnConnHandle, "SigCdMoe", "cursor_4c_MoedaPick", ;
2650:                 "CMoes", loc_cVal, ;
2651:                 "Moedas")
2652: 
2653:             IF VARTYPE(loc_oLookup) != "O"
2654:                 RETURN
2655:             ENDIF
2656: 
2657:             IF !loc_oLookup.this_lSelecionou
2658:                 loc_oLookup.Show()
2659:                 IF !loc_oLookup.this_lSelecionou
2660:                     loc_oLookup.Release()
2661:                     RETURN
2662:                 ENDIF
2663:             ENDIF
2664: 
2665:             IF USED("cursor_4c_MoedaPick") AND RECCOUNT("cursor_4c_MoedaPick") > 0
2666:                 SELECT cursor_4c_MoedaPick
2667:                 GO TOP
2668:                 loc_oPg2.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_MoedaPick.CMoes)
2669:                 *-- Carregar cotacao mais recente
2670:                 IF USED("cursor_4c_CotacaoPick")
2671:                     USE IN cursor_4c_CotacaoPick
2672:                 ENDIF
2673:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2674:                     "SELECT TOP 1 CMoes, Valos FROM SigCdCot WHERE CMoes = " + ;
2675:                     EscaparSQL(ALLTRIM(cursor_4c_MoedaPick.CMoes)) + ;
2676:                     " ORDER BY Datas DESC, Horas DESC", ;
2677:                     "cursor_4c_CotacaoPick")
2678:                 IF loc_nRet > 0 AND USED("cursor_4c_CotacaoPick") AND RECCOUNT("cursor_4c_CotacaoPick") > 0
2679:                     SELECT cursor_4c_CotacaoPick
2680:                     loc_oPg2.txt_4c_Cotacao.Value = cursor_4c_CotacaoPick.Valos
2681:                 ELSE
2682:                     loc_oPg2.txt_4c_Cotacao.Value = 1
2683:                 ENDIF
2684:                 IF USED("cursor_4c_CotacaoPick")
2685:                     USE IN cursor_4c_CotacaoPick
2686:                 ENDIF
2687:                 THIS.CotacaoLostFocus()
2688:             ENDIF

*-- Linhas 2699 a 2766:
2699:     *--------------------------------------------------------------------------
2700:     * CotacaoLostFocus - LostFocus: recalcula ValConv = Valor / Cotacao
2701:     *--------------------------------------------------------------------------
2702:     PROCEDURE CotacaoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2703:         LOCAL loc_oPg2, loc_nCotacao
2704:         TRY
2705:             loc_oPg2     = THIS.pgf_4c_Paginas.Page2
2706:             loc_nCotacao = loc_oPg2.txt_4c_Cotacao.Value
2707:             IF loc_nCotacao != 0
2708:                 loc_oPg2.txt_4c_ValConv.Value = ROUND(loc_oPg2.txt_4c_Valor.Value / loc_nCotacao, 2)
2709:             ELSE
2710:                 loc_oPg2.txt_4c_ValConv.Value = 0
2711:             ENDIF
2712:         CATCH TO loc_oErro
2713:             MsgErro(loc_oErro.Message, "Formche.CotacaoLostFocus")
2714:         ENDTRY
2715:     ENDPROC
2716: 
2717:     *--------------------------------------------------------------------------
2718:     * ValidarGrupoT - LostFocus: lookup de grupo terceiro (SigCdGcr)
2719:     *--------------------------------------------------------------------------
2720:     PROCEDURE ValidarGrupoT(par_nKeyCode, par_nShiftAltCtrl)
2721:         LOCAL loc_oLookup, loc_cVal, loc_oPg2
2722:         TRY
2723:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2724:             loc_cVal = ALLTRIM(loc_oPg2.txt_4c_GrupoT.Value)
2725: 
2726:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
2727:                 gnConnHandle, "SigCdGcr", "cursor_4c_GrupoTPick", ;
2728:                 "codigos", loc_cVal, ;
2729:                 "Grupo Terceiro")
2730: 
2731:             IF VARTYPE(loc_oLookup) != "O"
2732:                 RETURN
2733:             ENDIF
2734: 
2735:             IF !loc_oLookup.this_lSelecionou
2736:                 loc_oLookup.Show()
2737:                 IF !loc_oLookup.this_lSelecionou
2738:                     loc_oLookup.Release()
2739:                     RETURN
2740:                 ENDIF
2741:             ENDIF
2742: 
2743:             IF USED("cursor_4c_GrupoTPick") AND RECCOUNT("cursor_4c_GrupoTPick") > 0
2744:                 SELECT cursor_4c_GrupoTPick
2745:                 GO TOP
2746:                 loc_oPg2.txt_4c_GrupoT.Value  = ALLTRIM(cursor_4c_GrupoTPick.codigos)
2747:                 loc_oPg2.txt_4c_DGrupoT.Value = ALLTRIM(cursor_4c_GrupoTPick.descrs)
2748:             ENDIF
2749: 
2750:             IF USED("cursor_4c_GrupoTPick")
2751:                 USE IN cursor_4c_GrupoTPick
2752:             ENDIF
2753:             loc_oLookup.Release()
2754:         CATCH TO loc_oErro
2755:             MsgErro(loc_oErro.Message, "Formche.ValidarGrupoT")
2756:         ENDTRY
2757:     ENDPROC
2758: 
2759:     *--------------------------------------------------------------------------
2760:     * ObterJuroCarts - Retorna tipo de juros da empresa (1=Simples, 2=Composto)
2761:     *--------------------------------------------------------------------------
2762:     PROTECTED FUNCTION ObterJuroCarts()
2763:         LOCAL loc_nJuroCarts, loc_nRet
2764:         loc_nJuroCarts = 1
2765: 
2766:         IF USED("cursor_4c_ParamJuro")

*-- Linhas 2788 a 3327:
2788:     *--------------------------------------------------------------------------
2789:     * ValidarGrupoOs - LostFocus: lookup grupo contabil de origem (SigCdGcr)
2790:     *--------------------------------------------------------------------------
2791:     PROCEDURE ValidarGrupoOs(par_nKeyCode, par_nShiftAltCtrl)
2792:         LOCAL loc_oLookup, loc_cVal, loc_oPg2
2793:         TRY
2794:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2795:             loc_cVal = ALLTRIM(loc_oPg2.txt_4c_GrupoOs.Value)
2796: 
2797:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
2798:                 gnConnHandle, "SigCdGcr", "cursor_4c_GrupoOsPick", ;
2799:                 "codigos", loc_cVal, ;
2800:                 "Grupo Origem")
2801: 
2802:             IF VARTYPE(loc_oLookup) != "O"
2803:                 RETURN
2804:             ENDIF
2805: 
2806:             IF !loc_oLookup.this_lSelecionou
2807:                 loc_oLookup.Show()
2808:                 IF !loc_oLookup.this_lSelecionou
2809:                     loc_oLookup.Release()
2810:                     RETURN
2811:                 ENDIF
2812:             ENDIF
2813: 
2814:             IF USED("cursor_4c_GrupoOsPick") AND RECCOUNT("cursor_4c_GrupoOsPick") > 0
2815:                 SELECT cursor_4c_GrupoOsPick
2816:                 GO TOP
2817:                 loc_oPg2.txt_4c_GrupoOs.Value  = ALLTRIM(cursor_4c_GrupoOsPick.codigos)
2818:                 loc_oPg2.txt_4c_DGrupoOs.Value = ALLTRIM(cursor_4c_GrupoOsPick.descrs)
2819:                 loc_oPg2.txt_4c_ContaOs.Value  = ""
2820:                 loc_oPg2.txt_4c_DCONTAOs.Value = ""
2821:             ENDIF
2822: 
2823:             IF USED("cursor_4c_GrupoOsPick")
2824:                 USE IN cursor_4c_GrupoOsPick
2825:             ENDIF
2826:             loc_oLookup.Release()
2827:         CATCH TO loc_oErro
2828:             MsgErro(loc_oErro.Message, "Formche.ValidarGrupoOs")
2829:         ENDTRY
2830:     ENDPROC
2831: 
2832:     *--------------------------------------------------------------------------
2833:     * ValidarContaOs - LostFocus: valida conta de origem (SigCdCli, filtro grupo)
2834:     *--------------------------------------------------------------------------
2835:     PROCEDURE ValidarContaOs(par_nKeyCode, par_nShiftAltCtrl)
2836:         LOCAL loc_cVal, loc_cGrupo, loc_oPg2, loc_nRet
2837:         TRY
2838:             loc_oPg2   = THIS.pgf_4c_Paginas.Page2
2839:             loc_cVal   = ALLTRIM(loc_oPg2.txt_4c_ContaOs.Value)
2840:             loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_GrupoOs.Value)
2841: 
2842:             IF EMPTY(loc_cGrupo)
2843:                 MsgAviso("Informe o Grupo de Origem antes da Conta.", "Conta Origem")
2844:                 loc_oPg2.txt_4c_GrupoOs.SetFocus()
2845:                 RETURN
2846:             ENDIF
2847: 
2848:             IF EMPTY(loc_cVal)
2849:                 loc_oPg2.txt_4c_DCONTAOs.Value = ""
2850:                 RETURN
2851:             ENDIF
2852: 
2853:             IF USED("cursor_4c_ContaOsVal")
2854:                 USE IN cursor_4c_ContaOsVal
2855:             ENDIF
2856:             loc_nRet = SQLEXEC(gnConnHandle, ;
2857:                 "SELECT TOP 1 Iclis, Rclis FROM SigCdCli WHERE iclis = " + ;
2858:                 EscaparSQL(loc_cVal) + " AND grupos = " + EscaparSQL(loc_cGrupo), ;
2859:                 "cursor_4c_ContaOsVal")
2860: 
2861:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ContaOsVal") > 0
2862:                 SELECT cursor_4c_ContaOsVal
2863:                 GO TOP
2864:                 loc_oPg2.txt_4c_ContaOs.Value  = ALLTRIM(cursor_4c_ContaOsVal.Iclis)
2865:                 loc_oPg2.txt_4c_DCONTAOs.Value = ALLTRIM(cursor_4c_ContaOsVal.Rclis)
2866:             ELSE
2867:                 MsgAviso("Conta n" + CHR(227) + "o encontrada no Grupo de Origem.", ;
2868:                     "Conta Origem")
2869:                 loc_oPg2.txt_4c_ContaOs.Value  = ""
2870:                 loc_oPg2.txt_4c_DCONTAOs.Value = ""
2871:                 loc_oPg2.txt_4c_ContaOs.SetFocus()
2872:             ENDIF
2873: 
2874:             IF USED("cursor_4c_ContaOsVal")
2875:                 USE IN cursor_4c_ContaOsVal
2876:             ENDIF
2877:         CATCH TO loc_oErro
2878:             MsgErro(loc_oErro.Message, "Formche.ValidarContaOs")
2879:         ENDTRY
2880:     ENDPROC
2881: 
2882:     *--------------------------------------------------------------------------
2883:     * ValidarGrupoDs - LostFocus: lookup grupo contabil de destino (SigCdGcr)
2884:     *--------------------------------------------------------------------------
2885:     PROCEDURE ValidarGrupoDs(par_nKeyCode, par_nShiftAltCtrl)
2886:         LOCAL loc_oLookup, loc_cVal, loc_oPg2
2887:         TRY
2888:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2889:             loc_cVal = ALLTRIM(loc_oPg2.txt_4c_GrupoDs.Value)
2890: 
2891:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
2892:                 gnConnHandle, "SigCdGcr", "cursor_4c_GrupoDsPick", ;
2893:                 "codigos", loc_cVal, ;
2894:                 "Grupo Destino")
2895: 
2896:             IF VARTYPE(loc_oLookup) != "O"
2897:                 RETURN
2898:             ENDIF
2899: 
2900:             IF !loc_oLookup.this_lSelecionou
2901:                 loc_oLookup.Show()
2902:                 IF !loc_oLookup.this_lSelecionou
2903:                     loc_oLookup.Release()
2904:                     RETURN
2905:                 ENDIF
2906:             ENDIF
2907: 
2908:             IF USED("cursor_4c_GrupoDsPick") AND RECCOUNT("cursor_4c_GrupoDsPick") > 0
2909:                 SELECT cursor_4c_GrupoDsPick
2910:                 GO TOP
2911:                 loc_oPg2.txt_4c_GrupoDs.Value  = ALLTRIM(cursor_4c_GrupoDsPick.codigos)
2912:                 loc_oPg2.txt_4c_DGrupoDs.Value = ALLTRIM(cursor_4c_GrupoDsPick.descrs)
2913:                 loc_oPg2.txt_4c_ContaDs.Value  = ""
2914:                 loc_oPg2.txt_4c_DCONTADs.Value = ""
2915:             ENDIF
2916: 
2917:             IF USED("cursor_4c_GrupoDsPick")
2918:                 USE IN cursor_4c_GrupoDsPick
2919:             ENDIF
2920:             loc_oLookup.Release()
2921:         CATCH TO loc_oErro
2922:             MsgErro(loc_oErro.Message, "Formche.ValidarGrupoDs")
2923:         ENDTRY
2924:     ENDPROC
2925: 
2926:     *--------------------------------------------------------------------------
2927:     * ValidarContaDs - LostFocus: valida conta de destino (SigCdCli, filtro grupo)
2928:     *--------------------------------------------------------------------------
2929:     PROCEDURE ValidarContaDs(par_nKeyCode, par_nShiftAltCtrl)
2930:         LOCAL loc_cVal, loc_cGrupo, loc_oPg2, loc_nRet
2931:         TRY
2932:             loc_oPg2   = THIS.pgf_4c_Paginas.Page2
2933:             loc_cVal   = ALLTRIM(loc_oPg2.txt_4c_ContaDs.Value)
2934:             loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_GrupoDs.Value)
2935: 
2936:             IF EMPTY(loc_cGrupo)
2937:                 MsgAviso("Informe o Grupo de Destino antes da Conta.", "Conta Destino")
2938:                 loc_oPg2.txt_4c_GrupoDs.SetFocus()
2939:                 RETURN
2940:             ENDIF
2941: 
2942:             IF EMPTY(loc_cVal)
2943:                 loc_oPg2.txt_4c_DCONTADs.Value = ""
2944:                 RETURN
2945:             ENDIF
2946: 
2947:             IF USED("cursor_4c_ContaDsVal")
2948:                 USE IN cursor_4c_ContaDsVal
2949:             ENDIF
2950:             loc_nRet = SQLEXEC(gnConnHandle, ;
2951:                 "SELECT TOP 1 Iclis, Rclis FROM SigCdCli WHERE iclis = " + ;
2952:                 EscaparSQL(loc_cVal) + " AND grupos = " + EscaparSQL(loc_cGrupo), ;
2953:                 "cursor_4c_ContaDsVal")
2954: 
2955:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ContaDsVal") > 0
2956:                 SELECT cursor_4c_ContaDsVal
2957:                 GO TOP
2958:                 loc_oPg2.txt_4c_ContaDs.Value  = ALLTRIM(cursor_4c_ContaDsVal.Iclis)
2959:                 loc_oPg2.txt_4c_DCONTADs.Value = ALLTRIM(cursor_4c_ContaDsVal.Rclis)
2960:             ELSE
2961:                 MsgAviso("Conta n" + CHR(227) + "o encontrada no Grupo de Destino.", ;
2962:                     "Conta Destino")
2963:                 loc_oPg2.txt_4c_ContaDs.Value  = ""
2964:                 loc_oPg2.txt_4c_DCONTADs.Value = ""
2965:                 loc_oPg2.txt_4c_ContaDs.SetFocus()
2966:             ENDIF
2967: 
2968:             IF USED("cursor_4c_ContaDsVal")
2969:                 USE IN cursor_4c_ContaDsVal
2970:             ENDIF
2971:         CATCH TO loc_oErro
2972:             MsgErro(loc_oErro.Message, "Formche.ValidarContaDs")
2973:         ENDTRY
2974:     ENDPROC
2975: 
2976:     *--------------------------------------------------------------------------
2977:     * ValidarGruJuro - LostFocus: lookup grupo contabil de juros (SigCdGcr)
2978:     *--------------------------------------------------------------------------
2979:     PROCEDURE ValidarGruJuro(par_nKeyCode, par_nShiftAltCtrl)
2980:         LOCAL loc_oLookup, loc_cVal, loc_oPg2
2981:         TRY
2982:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2983:             loc_cVal = ALLTRIM(loc_oPg2.txt_4c_GruJuro.Value)
2984: 
2985:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
2986:                 gnConnHandle, "SigCdGcr", "cursor_4c_GruJuroPick", ;
2987:                 "codigos", loc_cVal, ;
2988:                 "Grupo Juros")
2989: 
2990:             IF VARTYPE(loc_oLookup) != "O"
2991:                 RETURN
2992:             ENDIF
2993: 
2994:             IF !loc_oLookup.this_lSelecionou
2995:                 loc_oLookup.Show()
2996:                 IF !loc_oLookup.this_lSelecionou
2997:                     loc_oLookup.Release()
2998:                     RETURN
2999:                 ENDIF
3000:             ENDIF
3001: 
3002:             IF USED("cursor_4c_GruJuroPick") AND RECCOUNT("cursor_4c_GruJuroPick") > 0
3003:                 SELECT cursor_4c_GruJuroPick
3004:                 GO TOP
3005:                 loc_oPg2.txt_4c_GruJuro.Value  = ALLTRIM(cursor_4c_GruJuroPick.codigos)
3006:                 loc_oPg2.txt_4c_DGruJuro.Value = ALLTRIM(cursor_4c_GruJuroPick.descrs)
3007:                 loc_oPg2.txt_4c_ConJuro.Value  = ""
3008:                 loc_oPg2.txt_4c_DJuro.Value    = ""
3009:             ENDIF
3010: 
3011:             IF USED("cursor_4c_GruJuroPick")
3012:                 USE IN cursor_4c_GruJuroPick
3013:             ENDIF
3014:             loc_oLookup.Release()
3015:         CATCH TO loc_oErro
3016:             MsgErro(loc_oErro.Message, "Formche.ValidarGruJuro")
3017:         ENDTRY
3018:     ENDPROC
3019: 
3020:     *--------------------------------------------------------------------------
3021:     * ValidarConJuro - LostFocus: valida conta de juros (SigCdCli, filtro grupo)
3022:     *--------------------------------------------------------------------------
3023:     PROCEDURE ValidarConJuro(par_nKeyCode, par_nShiftAltCtrl)
3024:         LOCAL loc_cVal, loc_cGrupo, loc_oPg2, loc_nRet
3025:         TRY
3026:             loc_oPg2   = THIS.pgf_4c_Paginas.Page2
3027:             loc_cVal   = ALLTRIM(loc_oPg2.txt_4c_ConJuro.Value)
3028:             loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_GruJuro.Value)
3029: 
3030:             IF EMPTY(loc_cGrupo)
3031:                 MsgAviso("Informe o Grupo de Juros antes da Conta.", "Conta Juros")
3032:                 loc_oPg2.txt_4c_GruJuro.SetFocus()
3033:                 RETURN
3034:             ENDIF
3035: 
3036:             IF EMPTY(loc_cVal)
3037:                 loc_oPg2.txt_4c_DJuro.Value = ""
3038:                 RETURN
3039:             ENDIF
3040: 
3041:             IF USED("cursor_4c_ConJuroVal")
3042:                 USE IN cursor_4c_ConJuroVal
3043:             ENDIF
3044:             loc_nRet = SQLEXEC(gnConnHandle, ;
3045:                 "SELECT TOP 1 Iclis, Rclis FROM SigCdCli WHERE iclis = " + ;
3046:                 EscaparSQL(loc_cVal) + " AND grupos = " + EscaparSQL(loc_cGrupo), ;
3047:                 "cursor_4c_ConJuroVal")
3048: 
3049:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ConJuroVal") > 0
3050:                 SELECT cursor_4c_ConJuroVal
3051:                 GO TOP
3052:                 loc_oPg2.txt_4c_ConJuro.Value = ALLTRIM(cursor_4c_ConJuroVal.Iclis)
3053:                 loc_oPg2.txt_4c_DJuro.Value   = ALLTRIM(cursor_4c_ConJuroVal.Rclis)
3054:             ELSE
3055:                 MsgAviso("Conta n" + CHR(227) + "o encontrada no Grupo de Juros.", ;
3056:                     "Conta Juros")
3057:                 loc_oPg2.txt_4c_ConJuro.Value = ""
3058:                 loc_oPg2.txt_4c_DJuro.Value   = ""
3059:                 loc_oPg2.txt_4c_ConJuro.SetFocus()
3060:             ENDIF
3061: 
3062:             IF USED("cursor_4c_ConJuroVal")
3063:                 USE IN cursor_4c_ConJuroVal
3064:             ENDIF
3065:         CATCH TO loc_oErro
3066:             MsgErro(loc_oErro.Message, "Formche.ValidarConJuro")
3067:         ENDTRY
3068:     ENDPROC
3069: 
3070:     *--------------------------------------------------------------------------
3071:     * TaxaLostFocus - LostFocus: calcula TaxaDia a partir de TaxaMes
3072:     * Composto (JuroCarts=2): TaxaDia = ((1+Taxa/100)^(1/30)-1)*100
3073:     * Simples: TaxaDia = Taxa/30
3074:     *--------------------------------------------------------------------------
3075:     PROCEDURE TaxaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3076:         LOCAL loc_oPg2, loc_nTaxa, loc_nTaxaDia, loc_nJuroCarts
3077:         TRY
3078:             loc_oPg2       = THIS.pgf_4c_Paginas.Page2
3079:             loc_nTaxa      = loc_oPg2.txt_4c_Taxa.Value
3080:             loc_nJuroCarts = THIS.ObterJuroCarts()
3081: 
3082:             IF loc_nJuroCarts = 2
3083:                 IF loc_nTaxa > 0
3084:                     loc_nTaxaDia = ROUND(((1 + loc_nTaxa/100)^(1/30) - 1) * 100, 4)
3085:                 ELSE
3086:                     loc_nTaxaDia = 0
3087:                 ENDIF
3088:                 loc_oPg2.lbl_4c_TpJuroC.ForeColor = RGB(0, 0, 192)
3089:                 loc_oPg2.lbl_4c_TpJuroS.ForeColor = RGB(128, 128, 128)
3090:             ELSE
3091:                 loc_nTaxaDia = ROUND(loc_nTaxa / 30, 4)
3092:                 loc_oPg2.lbl_4c_TpJuroS.ForeColor = RGB(0, 0, 192)
3093:                 loc_oPg2.lbl_4c_TpJuroC.ForeColor = RGB(128, 128, 128)
3094:             ENDIF
3095: 
3096:             loc_oPg2.txt_4c_TaxaDia.Value = loc_nTaxaDia
3097:         CATCH TO loc_oErro
3098:             MsgErro(loc_oErro.Message, "Formche.TaxaLostFocus")
3099:         ENDTRY
3100:     ENDPROC
3101: 
3102:     *--------------------------------------------------------------------------
3103:     * TaxaDiaLostFocus - LostFocus: calcula TaxaMes (inverso) a partir de TaxaDia
3104:     * Composto: TaxaMes = ((1+TaxaDia/100)^30 - 1)*100
3105:     * Simples: TaxaMes = TaxaDia*30
3106:     *--------------------------------------------------------------------------
3107:     PROCEDURE TaxaDiaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3108:         LOCAL loc_oPg2, loc_nTaxaDia, loc_nTaxaMes, loc_nJuroCarts
3109:         TRY
3110:             loc_oPg2       = THIS.pgf_4c_Paginas.Page2
3111:             loc_nTaxaDia   = loc_oPg2.txt_4c_TaxaDia.Value
3112:             loc_nJuroCarts = THIS.ObterJuroCarts()
3113: 
3114:             IF loc_nJuroCarts = 2
3115:                 IF loc_nTaxaDia > 0
3116:                     loc_nTaxaMes = ROUND(((1 + loc_nTaxaDia/100)^30 - 1) * 100, 4)
3117:                 ELSE
3118:                     loc_nTaxaMes = 0
3119:                 ENDIF
3120:                 loc_oPg2.lbl_4c_TpJuroC.ForeColor = RGB(0, 0, 192)
3121:                 loc_oPg2.lbl_4c_TpJuroS.ForeColor = RGB(128, 128, 128)
3122:             ELSE
3123:                 loc_nTaxaMes = ROUND(loc_nTaxaDia * 30, 4)
3124:                 loc_oPg2.lbl_4c_TpJuroS.ForeColor = RGB(0, 0, 192)
3125:                 loc_oPg2.lbl_4c_TpJuroC.ForeColor = RGB(128, 128, 128)
3126:             ENDIF
3127: 
3128:             loc_oPg2.txt_4c_Taxa.Value = loc_nTaxaMes
3129:         CATCH TO loc_oErro
3130:             MsgErro(loc_oErro.Message, "Formche.TaxaDiaLostFocus")
3131:         ENDTRY
3132:     ENDPROC
3133: 
3134:     *--------------------------------------------------------------------------
3135:     * TaxaIofLostFocus - LostFocus: valida taxa IOF (nao pode ser negativa)
3136:     *--------------------------------------------------------------------------
3137:     PROCEDURE TaxaIofLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3138:         LOCAL loc_oPg2
3139:         TRY
3140:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3141:             IF loc_oPg2.txt_4c_TaxaIof.Value < 0
3142:                 loc_oPg2.txt_4c_TaxaIof.Value = 0
3143:                 MsgAviso("Taxa IOF n" + CHR(227) + "o pode ser negativa.", "IOF")
3144:             ENDIF
3145:         CATCH TO loc_oErro
3146:             MsgErro(loc_oErro.Message, "Formche.TaxaIofLostFocus")
3147:         ENDTRY
3148:     ENDPROC
3149: 
3150:     *--------------------------------------------------------------------------
3151:     * BtnBotConsultaClick - Consulta PGV: exibe resumo de cheques do lote
3152:     *--------------------------------------------------------------------------
3153:     PROCEDURE BtnBotConsultaClick()
3154:         LOCAL loc_nRet, loc_cSQL, loc_cMsg, loc_nTotal
3155:         TRY
3156:             IF THIS.this_nNumLoteAtual <= 0
3157:                 MsgAviso("Salve o lote antes de consultar o PGV.", "Consulta PGV")
3158:                 RETURN
3159:             ENDIF
3160: 
3161:             IF USED("cursor_4c_PgvConsulta")
3162:                 USE IN cursor_4c_PgvConsulta
3163:             ENDIF
3164: 
3165:             loc_cSQL = "SELECT c.bancos, c.agencias, c.ncontas, c.ncheques," + ;
3166:                 " ISNULL(h.valors, 0) AS valors" + ;
3167:                 " FROM SigCcChm c" + ;
3168:                 " LEFT JOIN SigChe h ON h.bancos=c.bancos AND h.agencias=c.agencias" + ;
3169:                 " AND h.ncontas=c.ncontas AND h.ncheques=c.ncheques" + ;
3170:                 " WHERE c.numlotes = " + FormatarNumeroSQL(THIS.this_nNumLoteAtual) + ;
3171:                 " ORDER BY c.bancos, c.ncheques"
3172: 
3173:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PgvConsulta")
3174: 
3175:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_PgvConsulta") > 0
3176:                 SELECT cursor_4c_PgvConsulta
3177:                 loc_nTotal = RECCOUNT("cursor_4c_PgvConsulta")
3178:                 GO TOP
3179:                 loc_cMsg = "PGV - Lote " + LTRIM(STR(THIS.this_nNumLoteAtual)) + ;
3180:                     " (" + LTRIM(STR(loc_nTotal)) + " cheque(s))" + CHR(13) + CHR(13)
3181:                 SCAN
3182:                     loc_cMsg = loc_cMsg + ;
3183:                         ALLTRIM(cursor_4c_PgvConsulta.bancos) + "/" + ;
3184:                         ALLTRIM(cursor_4c_PgvConsulta.ncontas) + ;
3185:                         " Ch:" + ALLTRIM(cursor_4c_PgvConsulta.ncheques) + CHR(13)
3186:                 ENDSCAN
3187:                 MsgInfo(loc_cMsg, "Consulta PGV")
3188:             ELSE
3189:                 MsgAviso("Nenhum cheque registrado neste lote.", "Consulta PGV")
3190:             ENDIF
3191: 
3192:             IF USED("cursor_4c_PgvConsulta")
3193:                 USE IN cursor_4c_PgvConsulta
3194:             ENDIF
3195:         CATCH TO loc_oErro
3196:             MsgErro(loc_oErro.Message, "Formche.BtnBotConsultaClick")
3197:         ENDTRY
3198:     ENDPROC
3199: 
3200:     *--------------------------------------------------------------------------
3201:     * BtnCommand1Click - PGV Origem: picker de Conta Origem filtrado por grupo
3202:     *--------------------------------------------------------------------------
3203:     PROCEDURE BtnCommand1Click()
3204:         LOCAL loc_oPg2, loc_cGrupo, loc_cConta, loc_nRet, loc_oLookup1
3205:         TRY
3206:             loc_oPg2   = THIS.pgf_4c_Paginas.Page2
3207:             loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_GrupoOs.Value)
3208:             loc_cConta = ALLTRIM(loc_oPg2.txt_4c_ContaOs.Value)
3209: 
3210:             IF EMPTY(loc_cGrupo)
3211:                 MsgAviso("Informe o Grupo de Origem.", "PGV Origem")
3212:                 loc_oPg2.txt_4c_GrupoOs.SetFocus()
3213:                 RETURN
3214:             ENDIF
3215: 
3216:             loc_oLookup1 = CREATEOBJECT("FormBuscaAuxiliar", ;
3217:                 gnConnHandle, "SigCdCli", "cursor_4c_ContaOsBtn", ;
3218:                 "Iclis", loc_cConta, ;
3219:                 "Conta Origem - Grupo: " + loc_cGrupo)
3220: 
3221:             IF VARTYPE(loc_oLookup1) = "O"
3222:                 loc_oLookup1.Show()
3223:                 IF USED("cursor_4c_ContaOsBtn") AND RECCOUNT("cursor_4c_ContaOsBtn") > 0
3224:                     SELECT cursor_4c_ContaOsBtn
3225:                     GO TOP
3226:                     loc_oPg2.txt_4c_ContaOs.Value  = ALLTRIM(cursor_4c_ContaOsBtn.Iclis)
3227:                     loc_oPg2.txt_4c_DCONTAOs.Value = ALLTRIM(cursor_4c_ContaOsBtn.Rclis)
3228:                 ENDIF
3229:                 IF USED("cursor_4c_ContaOsBtn")
3230:                     USE IN cursor_4c_ContaOsBtn
3231:                 ENDIF
3232:                 loc_oLookup1.Release()
3233:             ENDIF
3234:         CATCH TO loc_oErro
3235:             MsgErro(loc_oErro.Message, "Formche.BtnCommand1Click")
3236:         ENDTRY
3237:     ENDPROC
3238: 
3239:     *--------------------------------------------------------------------------
3240:     * BtnCommand2Click - PGV Destino: picker de Conta Destino filtrado por grupo
3241:     *--------------------------------------------------------------------------
3242:     PROCEDURE BtnCommand2Click()
3243:         LOCAL loc_oPg2, loc_cGrupo, loc_cConta, loc_nRet, loc_oLookup2
3244:         TRY
3245:             loc_oPg2   = THIS.pgf_4c_Paginas.Page2
3246:             loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_GrupoDs.Value)
3247:             loc_cConta = ALLTRIM(loc_oPg2.txt_4c_ContaDs.Value)
3248: 
3249:             IF EMPTY(loc_cGrupo)
3250:                 MsgAviso("Informe o Grupo de Destino.", "PGV Destino")
3251:                 loc_oPg2.txt_4c_GrupoDs.SetFocus()
3252:                 RETURN
3253:             ENDIF
3254: 
3255:             loc_oLookup2 = CREATEOBJECT("FormBuscaAuxiliar", ;
3256:                 gnConnHandle, "SigCdCli", "cursor_4c_ContaDsBtn", ;
3257:                 "Iclis", loc_cConta, ;
3258:                 "Conta Destino - Grupo: " + loc_cGrupo)
3259: 
3260:             IF VARTYPE(loc_oLookup2) = "O"
3261:                 loc_oLookup2.Show()
3262:                 IF USED("cursor_4c_ContaDsBtn") AND RECCOUNT("cursor_4c_ContaDsBtn") > 0
3263:                     SELECT cursor_4c_ContaDsBtn
3264:                     GO TOP
3265:                     loc_oPg2.txt_4c_ContaDs.Value  = ALLTRIM(cursor_4c_ContaDsBtn.Iclis)
3266:                     loc_oPg2.txt_4c_DCONTADs.Value = ALLTRIM(cursor_4c_ContaDsBtn.Rclis)
3267:                 ENDIF
3268:                 IF USED("cursor_4c_ContaDsBtn")
3269:                     USE IN cursor_4c_ContaDsBtn
3270:                 ENDIF
3271:                 loc_oLookup2.Release()
3272:             ENDIF
3273:         CATCH TO loc_oErro
3274:             MsgErro(loc_oErro.Message, "Formche.BtnCommand2Click")
3275:         ENDTRY
3276:     ENDPROC
3277: 
3278:     *--------------------------------------------------------------------------
3279:     * BtnCommand3Click - Historico: exibe audit log do lote
3280:     *--------------------------------------------------------------------------
3281:     PROCEDURE BtnCommand3Click()
3282:         LOCAL loc_nRet, loc_cSQL, loc_cMsg, loc_nLote
3283:         TRY
3284:             loc_nLote = THIS.this_nNumLoteAtual
3285: 
3286:             IF loc_nLote <= 0
3287:                 MsgAviso("Nenhum lote selecionado.", "Hist" + CHR(243) + "rico")
3288:                 RETURN
3289:             ENDIF
3290: 
3291:             IF USED("cursor_4c_Hist")
3292:                 USE IN cursor_4c_Hist
3293:             ENDIF
3294: 
3295:             loc_cSQL = "SELECT TOP 20 operacaos, datatrans, usuarios" + ;
3296:                 " FROM LogAuditoria" + ;
3297:                 " WHERE tabelas = 'SigCqLcm' AND codigos = " + ;
3298:                 FormatarNumeroSQL(loc_nLote) + ;
3299:                 " ORDER BY datatrans DESC"
3300: 
3301:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Hist")
3302: 
3303:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_Hist") > 0
3304:                 SELECT cursor_4c_Hist
3305:                 GO TOP
3306:                 loc_cMsg = "Hist" + CHR(243) + "rico - Lote " + ;
3307:                     LTRIM(STR(loc_nLote)) + CHR(13) + CHR(13)
3308:                 SCAN
3309:                     loc_cMsg = loc_cMsg + ;
3310:                         ALLTRIM(cursor_4c_Hist.operacaos) + " - " + ;
3311:                         ALLTRIM(cursor_4c_Hist.usuarios) + CHR(13)
3312:                 ENDSCAN
3313:                 MsgInfo(loc_cMsg, "Hist" + CHR(243) + "rico")
3314:             ELSE
3315:                 MsgAviso("Nenhum hist" + CHR(243) + "rico encontrado para este lote.", ;
3316:                     "Hist" + CHR(243) + "rico")
3317:             ENDIF
3318: 
3319:             IF USED("cursor_4c_Hist")
3320:                 USE IN cursor_4c_Hist
3321:             ENDIF
3322:         CATCH TO loc_oErro
3323:             MsgErro(loc_oErro.Message, "Formche.BtnCommand3Click")
3324:         ENDTRY
3325:     ENDPROC
3326: 
3327: ENDDEFINE


### BO (C:\4c\projeto\app\classes\cheBO.prg):
DEFINE CLASS cheBO AS BusinessBase

    *-- SigCqLcm - cabecalho do lote
    this_nNumLote  = 0
    this_cOperL    = ""
    this_dData     = {}
    this_dDtMovs   = {}
    this_cOpera    = ""
    this_cLimCart  = ""

    *-- Moeda / conversao
    this_cMoeda    = ""
    this_nCotacao  = 0
    this_nValConv  = 0

    *-- Totais (Valtots, Valtjuros, calc TLiq)
    this_nValor    = 0
    this_nTJuros   = 0
    this_nTLiq     = 0

    *-- Taxas
    this_nTaxaDia  = 0
    this_nTaxaIof  = 0
    this_nTaxaMes  = 0

    *-- Grupo / Conta Destino
    this_cGrupoDs  = ""
    this_cDGrupoDs = ""
    this_cContaDs  = ""
    this_cDContaDs = ""

    *-- Grupo / Conta Origem
    this_cGrupoOs  = ""
    this_cDGrupoOs = ""
    this_cContaOs  = ""
    this_cDContaOs = ""

    *-- Grupo / Conta Terceiro
    this_cGrupoT   = ""
    this_cDGrupoT  = ""

    *-- Grupo / Conta Juros
    this_cGruJuro  = ""
    this_cDGruJuro = ""
    this_cConJuro  = ""
    this_cDJuro    = ""

    *-- Chave interna (GUID - cidchaves)
    this_cCidChave  = ""

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCqLcm"
        THIS.this_cCampoChave = "NumLotes"
        RETURN .T.
    ENDPROC

    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_nNumLote
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Carrega lista de lotes da carteira de cheques
    * par_cFiltro: WHERE adicional (ex: "AND datas BETWEEN '...' AND '...'")
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.numlotes, a.datas, a.dtmovs, a.codigos," + ;
                " a.operas, a.tipos, a.moeds, a.cotas, a.valtots," + ;
                " a.valtjuros, a.valconvs, a.grupoos, a.contaos," + ;
                " a.grupods, a.contads, a.grupocx, a.contacx," + ;
                " a.grujuros, a.conjuros, a.taxcarts, a.taxdias, a.taxiofs," + ;
                " a.emps, a.usuarios, a.datatrans, a.cidchaves" + ;
                " FROM SigCqLcm a" + ;
                " WHERE 1=1"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.numlotes"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar lotes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em cheBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega lote pelo numlotes
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_nNumLote)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.numlotes, a.datas, a.dtmovs, a.codigos," + ;
                " a.operas, a.tipos, a.moeds, a.cotas, a.valtots," + ;
                " a.valtjuros, a.valconvs, a.grupoos, a.contaos," + ;
                " a.grupods, a.contads, a.grupocx, a.contacx," + ;
                " a.grujuros, a.conjuros, a.taxcarts, a.taxdias, a.taxiofs," + ;
                " a.emps, a.usuarios, a.datatrans, a.cidchaves" + ;
                " FROM SigCqLcm a" + ;
                " WHERE a.numlotes = " + FormatarNumeroSQL(par_nNumLote)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em cheBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades a partir de cursor
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nNumLote   = TratarNulo(numlotes,  "N")
            THIS.this_cCidChave  = TratarNulo(cidchaves, "C")
            THIS.this_dData      = TratarNulo(datas,     "D")
            THIS.this_dDtMovs    = TratarNulo(dtmovs,    "D")
            THIS.this_cOperL     = TratarNulo(codigos,   "C")
            THIS.this_cOpera     = TratarNulo(operas,    "C")
            THIS.this_cLimCart   = TratarNulo(tipos,     "C")
            THIS.this_cMoeda     = TratarNulo(moeds,     "C")
            THIS.this_nCotacao   = TratarNulo(cotas,     "N")
            THIS.this_nValConv   = TratarNulo(valconvs,  "N")
            THIS.this_nValor     = TratarNulo(valtots,   "N")
            THIS.this_nTJuros    = TratarNulo(valtjuros, "N")
            THIS.this_nTLiq      = THIS.this_nValor - THIS.this_nTJuros
            THIS.this_nTaxaDia   = TratarNulo(taxdias,   "N")
            THIS.this_nTaxaIof   = TratarNulo(taxiofs,   "N")
            THIS.this_nTaxaMes   = TratarNulo(taxcarts,  "N")
            THIS.this_cGrupoDs   = TratarNulo(grupods,   "C")
            THIS.this_cContaDs   = TratarNulo(contads,   "C")
            THIS.this_cGrupoOs   = TratarNulo(grupoos,   "C")
            THIS.this_cContaOs   = TratarNulo(contaos,   "C")
            THIS.this_cGrupoT    = TratarNulo(grupocx,   "C")
            THIS.this_cGruJuro   = TratarNulo(grujuros,  "C")
            THIS.this_cConJuro   = TratarNulo(conjuros,  "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterProximoLote - Retorna proximo numlotes disponivel
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterProximoLote()
        LOCAL loc_cSQL, loc_nResult, loc_nProximo
        loc_nProximo = 1

        loc_cSQL = "SELECT ISNULL(MAX(numlotes), 0) + 1 AS proximo FROM SigCqLcm" + ;
            " WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

        IF USED("cursor_4c_ProxLote")
            USE IN cursor_4c_ProxLote
        ENDIF

        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxLote")

        IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ProxLote") > 0
            SELECT cursor_4c_ProxLote
            loc_nProximo = cursor_4c_ProxLote.proximo
        ENDIF

        IF USED("cursor_4c_ProxLote")
            USE IN cursor_4c_ProxLote
        ENDIF

        RETURN loc_nProximo
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCqLcm
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_nProximo, loc_cCidChave
        loc_lSucesso = .F.

        TRY
            loc_nProximo  = THIS.ObterProximoLote()
            loc_cCidChave = LEFT(go_4c_Sistema.cCodEmpresa + ;
                PADL(TRANSFORM(loc_nProximo), 17, "0"), 20)

            THIS.this_nNumLote  = loc_nProximo
            THIS.this_cCidChave = loc_cCidChave

            loc_cSQL = "INSERT INTO SigCqLcm (" + ;
                " numlotes, cidchaves, datas, dtmovs, codigos, operas, tipos," + ;
                " moeds, cotas, valtots, valtjuros, valconvs," + ;
                " grupoos, contaos, grupods, contads, grupocx, contacx," + ;
                " grujuros, conjuros, taxcarts, taxdias, taxiofs," + ;
                " emps, usuarios, dtsis, autos, locals, ntrans," + ;
                " nalineas, empdopnums, custodia)" + ;
                " VALUES (" + ;
                FormatarNumeroSQL(THIS.this_nNumLote) + "," + ;
                EscaparSQL(THIS.this_cCidChave) + "," + ;
                FormatarDataSQL(THIS.this_dData) + "," + ;
                FormatarDataSQL(THIS.this_dDtMovs) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cOperL)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cOpera)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cLimCart)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cMoeda)) + "," + ;
                FormatarNumeroSQL(THIS.this_nCotacao) + "," + ;
                FormatarNumeroSQL(THIS.this_nValor) + "," + ;
                FormatarNumeroSQL(THIS.this_nTJuros) + "," + ;
                FormatarNumeroSQL(THIS.this_nValConv) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupoOs)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cContaOs)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupoDs)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cContaDs)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupoT)) + "," + ;
                "''," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGruJuro)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cConJuro)) + "," + ;
                FormatarNumeroSQL(THIS.this_nTaxaMes) + "," + ;
                FormatarNumeroSQL(THIS.this_nTaxaDia) + "," + ;
                FormatarNumeroSQL(THIS.this_nTaxaIof) + "," + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa) + "," + ;
                EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + "," + ;
                "GETDATE()," + ;
                "0,'',0,0,'','')"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao inserir lote:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em cheBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCqLcm
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCqLcm SET" + ;
                " datas = "     + FormatarDataSQL(THIS.this_dData) + "," + ;
                " dtmovs = "    + FormatarDataSQL(THIS.this_dDtMovs) + "," + ;
                " operas = "    + EscaparSQL(ALLTRIM(THIS.this_cOpera)) + "," + ;
                " tipos = "     + EscaparSQL(ALLTRIM(THIS.this_cLimCart)) + "," + ;
                " moeds = "     + EscaparSQL(ALLTRIM(THIS.this_cMoeda)) + "," + ;
                " cotas = "     + FormatarNumeroSQL(THIS.this_nCotacao) + "," + ;
                " valtots = "   + FormatarNumeroSQL(THIS.this_nValor) + "," + ;
                " valtjuros = " + FormatarNumeroSQL(THIS.this_nTJuros) + "," + ;
                " valconvs = "  + FormatarNumeroSQL(THIS.this_nValConv) + "," + ;
                " grupoos = "   + EscaparSQL(ALLTRIM(THIS.this_cGrupoOs)) + "," + ;
                " contaos = "   + EscaparSQL(ALLTRIM(THIS.this_cContaOs)) + "," + ;
                " grupods = "   + EscaparSQL(ALLTRIM(THIS.this_cGrupoDs)) + "," + ;
                " contads = "   + EscaparSQL(ALLTRIM(THIS.this_cContaDs)) + "," + ;
                " grupocx = "   + EscaparSQL(ALLTRIM(THIS.this_cGrupoT)) + "," + ;
                " grujuros = "  + EscaparSQL(ALLTRIM(THIS.this_cGruJuro)) + "," + ;
                " conjuros = "  + EscaparSQL(ALLTRIM(THIS.this_cConJuro)) + "," + ;
                " taxcarts = "  + FormatarNumeroSQL(THIS.this_nTaxaMes) + "," + ;
                " taxdias = "   + FormatarNumeroSQL(THIS.this_nTaxaDia) + "," + ;
                " taxiofs = "   + FormatarNumeroSQL(THIS.this_nTaxaIof) + "," + ;
                " usuarios = "  + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;
                " WHERE numlotes = " + FormatarNumeroSQL(THIS.this_nNumLote)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar lote:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em cheBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCcChm (cheques) e SigCqLcm (lote)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.RegistrarAuditoria("DELETE")

            loc_cSQL = "DELETE FROM SigCcChm WHERE numlotes = " + ;
                FormatarNumeroSQL(THIS.this_nNumLote)
            SQLEXEC(gnConnHandle, loc_cSQL)

            loc_cSQL = "DELETE FROM SigCqLcm WHERE numlotes = " + ;
                FormatarNumeroSQL(THIS.this_nNumLote)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao excluir lote:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em cheBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

