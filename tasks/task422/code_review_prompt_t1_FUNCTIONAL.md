# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [BINDEVENT-PARAMS] Handler 'txt_4c_InfosLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE txt_4c_InfosLostFocus(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFornecedor.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1027 linhas total):

*-- Linhas 25 a 148:
25:     *=========================================================================
26:     * Init - Inicializa o formulario
27:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
28:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
29:     *=========================================================================
30:     PROCEDURE Init()
31:         RETURN DODEFAULT()
32:     ENDPROC
33: 
34:     *=========================================================================
35:     * InicializarForm - Configura estrutura completa
36:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
37:     *=========================================================================
38:     PROTECTED PROCEDURE InicializarForm()
39:         LOCAL loc_lSucesso
40:         loc_lSucesso = .F.
41: 
42:         TRY
43:             THIS.this_oBusinessObject = CREATEOBJECT("FornecedorBO")
44: 
45:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
46:                 MostrarErro("Erro ao criar FornecedorBO" + CHR(13) + ;
47:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
48:                     "FormFornecedor.InicializarForm")
49:             ELSE
50:                 THIS.ConfigurarPageFrame()
51:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
52:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
53:                 THIS.pgf_4c_Paginas.Visible    = .T.
54:                 THIS.pgf_4c_Paginas.ActivePage = 1
55:                 THIS.this_cModoAtual = "LISTA"
56: 
57:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
58:                     THIS.CarregarLista()
59:                 ENDIF
60: 
61:                 loc_lSucesso = .T.
62:             ENDIF
63: 
64:         CATCH TO loException
65:             MostrarErro("Erro ao inicializar FormFornecedor:" + CHR(13) + ;
66:                 loException.Message + CHR(13) + ;
67:                 "Linha: " + TRANSFORM(loException.LineNo), ;
68:                 "FormFornecedor.InicializarForm")
69:         ENDTRY
70: 
71:         RETURN loc_lSucesso
72:     ENDPROC
73: 
74:     *=========================================================================
75:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
76:     * Top=-29 para esconder abas; controles compensam +29 no Top
77:     *=========================================================================
78:     PROTECTED PROCEDURE ConfigurarPageFrame()
79:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
80: 
81:         WITH THIS.pgf_4c_Paginas
82:             .PageCount = 2
83:             .Top       = -29
84:             .Left      = 0
85:             .Width     = THIS.Width
86:             .Height    = THIS.Height + 29
87:             .Tabs      = .F.
88:             .Visible   = .T.
89: 
90:             .Page1.Caption   = "Lista"
91:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
92:             .Page1.BackColor = RGB(255, 255, 255)
93: 
94:             .Page2.Caption   = "Dados"
95:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
96:             .Page2.BackColor = RGB(255, 255, 255)
97:         ENDWITH
98: 
99:         THIS.ConfigurarPaginaLista()
100:         THIS.ConfigurarPaginaDados()
101:     ENDPROC
102: 
103:     *=========================================================================
104:     * ConfigurarPaginaLista - Configura Page1 com containers principais
105:     * Fase 3: cnt_4c_Cabecalho (com labels), cnt_4c_Botoes (vazio), cnt_4c_Saida
106:     * Fase 4 adiciona: grid grd_4c_Lista + botoes CRUD em cnt_4c_Botoes
107:     *=========================================================================
108:     PROTECTED PROCEDURE ConfigurarPaginaLista()
109:         LOCAL loc_oPagina
110:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
111: 
112:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
113: 
114:         *-- Container Cabecalho (cntSombra no legado)
115:         *-- Original: Top=1. Com compensacao PageFrame +29: Top=31
116:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
117:         WITH loc_oPagina.cnt_4c_Cabecalho
118:             .Top         = 31
119:             .Left        = 0
120:             .Width       = THIS.Width
121:             .Height      = 80
122:             .BackColor   = RGB(100, 100, 100)
123:             .BorderWidth = 0
124:             .Visible     = .T.
125:         ENDWITH
126: 
127:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
128:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
129:             .Caption   = THIS.Caption
130:             .Top       = 15
131:             .Left      = 10
132:             .Width     = 769
133:             .Height    = 40
134:             .FontName  = "Tahoma"
135:             .FontSize  = 16
136:             .FontBold  = .T.
137:             .ForeColor = RGB(0, 0, 0)
138:             .BackStyle = 0
139:             .AutoSize  = .F.
140:             .Visible   = .T.
141:         ENDWITH
142: 
143:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
144:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
145:             .Caption   = THIS.Caption
146:             .Top       = 18
147:             .Left      = 10
148:             .Width     = 769

*-- Linhas 194 a 481:
194:             .AutoSize        = .F.
195:             .Visible         = .T.
196:         ENDWITH
197:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
198: 
199:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
200:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
201:             .Caption         = "Visualizar"
202:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
203:             .PicturePosition = 13
204:             .Top             = 5
205:             .Left            = 80
206:             .Width           = 75
207:             .Height          = 75
208:             .FontName        = "Comic Sans MS"
209:             .FontBold        = .T.
210:             .FontItalic      = .T.
211:             .FontSize        = 8
212:             .ForeColor       = RGB(90, 90, 90)
213:             .BackColor       = RGB(255, 255, 255)
214:             .Themes          = .F.
215:             .SpecialEffect   = 0
216:             .MousePointer    = 15
217:             .WordWrap        = .T.
218:             .AutoSize        = .F.
219:             .Visible         = .T.
220:         ENDWITH
221:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
222: 
223:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
224:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
225:             .Caption         = "Alterar"
226:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
227:             .PicturePosition = 13
228:             .Top             = 5
229:             .Left            = 155
230:             .Width           = 75
231:             .Height          = 75
232:             .FontName        = "Comic Sans MS"
233:             .FontBold        = .T.
234:             .FontItalic      = .T.
235:             .FontSize        = 8
236:             .ForeColor       = RGB(90, 90, 90)
237:             .BackColor       = RGB(255, 255, 255)
238:             .Themes          = .F.
239:             .SpecialEffect   = 0
240:             .MousePointer    = 15
241:             .WordWrap        = .T.
242:             .AutoSize        = .F.
243:             .Visible         = .T.
244:         ENDWITH
245:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
246: 
247:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
248:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
249:             .Caption         = "Excluir"
250:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
251:             .PicturePosition = 13
252:             .Top             = 5
253:             .Left            = 230
254:             .Width           = 75
255:             .Height          = 75
256:             .FontName        = "Comic Sans MS"
257:             .FontBold        = .T.
258:             .FontItalic      = .T.
259:             .FontSize        = 8
260:             .ForeColor       = RGB(90, 90, 90)
261:             .BackColor       = RGB(255, 255, 255)
262:             .Themes          = .F.
263:             .SpecialEffect   = 0
264:             .MousePointer    = 15
265:             .WordWrap        = .T.
266:             .AutoSize        = .F.
267:             .Visible         = .T.
268:         ENDWITH
269:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
270: 
271:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
272:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
273:             .Caption         = "Buscar"
274:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
275:             .PicturePosition = 13
276:             .Top             = 5
277:             .Left            = 305
278:             .Width           = 75
279:             .Height          = 75
280:             .FontName        = "Comic Sans MS"
281:             .FontBold        = .T.
282:             .FontItalic      = .T.
283:             .FontSize        = 8
284:             .ForeColor       = RGB(90, 90, 90)
285:             .BackColor       = RGB(255, 255, 255)
286:             .Themes          = .F.
287:             .SpecialEffect   = 0
288:             .MousePointer    = 15
289:             .WordWrap        = .T.
290:             .AutoSize        = .F.
291:             .Visible         = .T.
292:         ENDWITH
293:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
294: 
295:         *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10)
296:         *-- Legado: Grupo_Saida.Left=719, Top=-1. Canonico: Left=917, Top=29, Width=90
297:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
298:         WITH loc_oPagina.cnt_4c_Saida
299:             .Top         = 29
300:             .Left        = 917
301:             .Width       = 90
302:             .Height      = 85
303:             .BackStyle   = 0
304:             .BorderWidth = 0
305:             .Visible     = .T.
306:         ENDWITH
307: 
308:         *-- Botao Encerrar - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
309:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
310:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
311:             .Caption         = "Encerrar"
312:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
313:             .PicturePosition = 13
314:             .Top             = 5
315:             .Left            = 5
316:             .Width           = 75
317:             .Height          = 75
318:             .FontName        = "Tahoma"
319:             .FontBold        = .T.
320:             .FontItalic      = .T.
321:             .FontSize        = 8
322:             .ForeColor       = RGB(90, 90, 90)
323:             .BackColor       = RGB(255, 255, 255)
324:             .Themes          = .F.
325:             .SpecialEffect   = 0
326:             .MousePointer    = 15
327:             .WordWrap        = .T.
328:             .AutoSize        = .F.
329:             .Visible         = .T.
330:         ENDWITH
331:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
332: 
333:         *-- Grid de lista (grade no legado: Top=121, Left=12, 1 coluna Formas w=94)
334:         *-- Framework canonico: Top=117(88+29), Left=26, Width=890, Height=498
335:         *-- Problema 36: ColumnCount FORA do WITH; ControlSource definido em CarregarLista()
336:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
337:         loc_oPagina.grd_4c_Lista.ColumnCount = 2
338:         WITH loc_oPagina.grd_4c_Lista
339:             .Top                = 117
340:             .Left               = 26
341:             .Width              = 890
342:             .Height             = 498
343:             .FontName           = "Verdana"
344:             .FontSize           = 8
345:             .ForeColor          = RGB(90, 90, 90)
346:             .BackColor          = RGB(255, 255, 255)
347:             .GridLineColor      = RGB(238, 238, 238)
348:             .HighlightBackColor = RGB(255, 255, 255)
349:             .HighlightForeColor = RGB(15, 41, 104)
350:             .HighlightStyle     = 2
351:             .DeleteMark         = .F.
352:             .RecordMark         = .F.
353:             .RowHeight          = 16
354:             .ScrollBars         = 2
355:             .GridLines          = 3
356:             .Visible            = .T.
357:             .Column1.Width      = 200
358:             .Column2.Width      = 400
359:             .Column1.Header1.Caption = "Forma de Pagamento"
360:             .Column2.Header1.Caption = "Inf. Complementar"
361:         ENDWITH
362: 
363:         THIS.TornarControlesVisiveis(loc_oPagina)
364:     ENDPROC
365: 
366:     *=========================================================================
367:     * ConfigurarPaginaDados - Configura Page2 com containers principais
368:     * Fase 3: cnt_4c_BotoesAcao (vazio)
369:     * Fase 4 adiciona: botoes Confirmar/Cancelar em cnt_4c_BotoesAcao
370:     * Fases 5-6 adicionam: txt_4c_Formas, lbl_4c_FormasPgto,
371:     *                       txt_4c_Infos, lbl_4c_InfComplementar
372:     *=========================================================================
373:     PROTECTED PROCEDURE ConfigurarPaginaDados()
374:         LOCAL loc_oPagina
375:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
376: 
377:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
378: 
379:         *-- Container BotoesAcao (Grupo_Salva no legado: Salva.Left=5, Cancelar.Left=81)
380:         *-- Canonico framework: Top=4+29=33, Left=842, Width=160, Height=85
381:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
382:         WITH loc_oPagina.cnt_4c_BotoesAcao
383:             .Top         = 33
384:             .Left        = 842
385:             .Width       = 160
386:             .Height      = 85
387:             .BackStyle = 1
388:             .BackColor   = RGB(255, 255, 255)
389:             .BorderWidth = 0
390:             .Visible     = .T.
391:         ENDWITH
392: 
393:         *-- Botao Confirmar (Salvar) - Left=5 conforme legado Grupo_Salva
394:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
395:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
396:             .Caption         = "Confirmar"
397:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
398:             .PicturePosition = 13
399:             .Top             = 5
400:             .Left            = 5
401:             .Width           = 75
402:             .Height          = 75
403:             .FontName        = "Comic Sans MS"
404:             .FontBold        = .T.
405:             .FontItalic      = .T.
406:             .FontSize        = 8
407:             .ForeColor       = RGB(90, 90, 90)
408:             .BackColor       = RGB(255, 255, 255)
409:             .Themes          = .F.
410:             .SpecialEffect   = 0
411:             .MousePointer    = 15
412:             .WordWrap        = .T.
413:             .AutoSize        = .F.
414:             .Visible         = .T.
415:         ENDWITH
416:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
417: 
418:         *-- Botao Cancelar - Left=80 conforme legado Grupo_Salva
419:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
420:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
421:             .Caption         = "Encerrar"
422:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
423:             .PicturePosition = 13
424:             .Top             = 5
425:             .Left            = 80
426:             .Width           = 75
427:             .Height          = 75
428:             .FontName        = "Comic Sans MS"
429:             .FontBold        = .T.
430:             .FontItalic      = .T.
431:             .FontSize        = 8
432:             .ForeColor       = RGB(90, 90, 90)
433:             .BackColor       = RGB(255, 255, 255)
434:             .Themes          = .F.
435:             .SpecialEffect   = 0
436:             .MousePointer    = 15
437:             .WordWrap        = .T.
438:             .AutoSize        = .F.
439:             .Visible         = .T.
440:         ENDWITH
441:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
442: 
443:         *-- Label "Forma de Pagamento : " (Say8 original: Top=173, Left=196; +29 compensacao)
444:         *-- ForeColor=RGB(90,90,90) copiado do original
445:         loc_oPagina.AddObject("lbl_4c_FormasPgto", "Label")
446:         WITH loc_oPagina.lbl_4c_FormasPgto
447:             .Caption   = "Forma de Pagamento : "
448:             .Top       = 202
449:             .Left      = 196
450:             .Width     = 110
451:             .Height    = 17
452:             .FontName  = "Tahoma"
453:             .FontSize  = 8
454:             .FontBold  = .F.
455:             .ForeColor = RGB(90, 90, 90)
456:             .BackStyle = 0
457:             .AutoSize  = .F.
458:             .Visible   = .T.
459:         ENDWITH
460: 
461:         *-- TextBox Forma de Pagamento - PK C12 (Get_formas original: Top=169, Left=311, Width=94; +29)
462:         *-- When do legado: retorna .F. se nao em INSERIR/PROCURAR -> gerenciado por HabilitarCampos
463:         loc_oPagina.AddObject("txt_4c_Formas", "TextBox")
464:         WITH loc_oPagina.txt_4c_Formas
465:             .Value         = ""
466:             .Top           = 198
467:             .Left          = 311
468:             .Width         = 94
469:             .Height        = 20
470:             .FontName      = "Tahoma"
471:             .FontSize      = 8
472:             .ForeColor     = RGB(0, 0, 0)
473:             .BackColor     = RGB(255, 255, 255)
474:             .MaxLength     = 12
475:             .TabIndex      = 1
476:             .Visible       = .T.
477:         ENDWITH
478: 
479:         *-- Label "Inf. Complementar : " (Say7 original: Top=197, Left=208; +29 compensacao)
480:         *-- ForeColor=RGB(90,90,90) copiado do original
481:         loc_oPagina.AddObject("lbl_4c_InfComplementar", "Label")

*-- Linhas 510 a 1027:
510:             .MaxLength   = 1
511:             .ToolTipText = "<C>Cheque <T>Cart" + CHR(227) + "o Cr" + CHR(233) + "dito <N>Carne <O>Outras  <R>Conta Corrente"
512:             .TabIndex    = 2
513:             .Visible     = .T.
514:         ENDWITH
515:         BINDEVENT(loc_oPagina.txt_4c_Infos, "KeyPress", THIS, "txt_4c_InfosLostFocus")
516:         BINDEVENT(loc_oPagina.txt_4c_Infos, "KeyPress",  THIS, "txt_4c_InfosKeyPress")
517: 
518:         THIS.TornarControlesVisiveis(loc_oPagina)
519:     ENDPROC
520: 
521:     *=========================================================================
522:     * CarregarLista - Carrega dados no grid da Page1 via FornecedorBO.Buscar
523:     * Grid (grd_4c_Lista) adicionado na Fase 4; usa PEMSTATUS para compatibilidade
524:     * Colunas: formas (Forma de Pagamento), descrs (Inf. Complementar via JOIN)
525:     *=========================================================================
526:     PROCEDURE CarregarLista()
527:         LOCAL loc_lResultado, loc_oPagina, loc_oGrid
528:         loc_lResultado = .F.
529: 
530:         TRY
531:             IF !THIS.this_oBusinessObject.Buscar("")
532:                 loc_lResultado = .F.
533:             ELSE
534:                 loc_oPagina = THIS.pgf_4c_Paginas.Page1
535: 
536:                 IF PEMSTATUS(loc_oPagina, "grd_4c_Lista", 5)
537:                     loc_oGrid = loc_oPagina.grd_4c_Lista
538: 
539:                     *-- Problema 36: RecordSource e ColumnCount FORA do WITH
540:                     *-- Problema 48: ControlSource APOS RecordSource
541:                     loc_oGrid.ColumnCount  = 2
542:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
543: 
544:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.formas"
545:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
546: 
547:                     loc_oGrid.Column1.Width = 200
548:                     loc_oGrid.Column2.Width = 400
549: 
550:                     *-- Problema 2/32: Headers APOS RecordSource (RecordSource reseta captions)
551:                     loc_oGrid.Column1.Header1.Caption = "Forma de Pagamento"
552:                     loc_oGrid.Column2.Header1.Caption = "Inf. Complementar"
553: 
554:                     THIS.FormatarGridLista(loc_oGrid)
555:                 ENDIF
556: 
557:                 loc_lResultado = .T.
558:             ENDIF
559: 
560:         CATCH TO loException
561:             MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message + CHR(13) + ;
562:                 "Linha: " + TRANSFORM(loException.LineNo), ;
563:                 "FormFornecedor.CarregarLista")
564:             loc_lResultado = .F.
565:         ENDTRY
566: 
567:         RETURN loc_lResultado
568:     ENDPROC
569: 
570:     *=========================================================================
571:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
572:     * Ao voltar para Page1, recarrega a lista automaticamente
573:     *=========================================================================
574:     PROCEDURE AlternarPagina(par_nPagina)
575:         LOCAL loc_lResultado
576:         loc_lResultado = .F.
577: 
578:         TRY
579:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
580:                 MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
581:             ELSE
582:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
583: 
584:                 IF par_nPagina = 1
585:                     THIS.this_cModoAtual = "LISTA"
586:                     THIS.CarregarLista()
587:                 ENDIF
588: 
589:                 loc_lResultado = .T.
590:             ENDIF
591: 
592:         CATCH TO loException
593:             MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, ;
594:                 "FormFornecedor.AlternarPagina")
595:         ENDTRY
596: 
597:         RETURN loc_lResultado
598:     ENDPROC
599: 
600:     *=========================================================================
601:     * FormatarGridLista - Formata visual do grid de lista (FontName/FontSize)
602:     *=========================================================================
603:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
604:         TRY
605:             WITH par_oGrid
606:                 .FontName = "Tahoma"
607:                 .FontSize = 8
608:             ENDWITH
609:         CATCH TO loException
610:             MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
611:                 "FormFornecedor.FormatarGridLista")
612:         ENDTRY
613:     ENDPROC
614: 
615:     *=========================================================================
616:     * BtnIncluirClick - Abre Page2 para incluir nova forma de pagamento
617:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
618:     *=========================================================================
619:     PROCEDURE BtnIncluirClick()
620:         THIS.this_oBusinessObject.NovoRegistro()
621:         THIS.LimparCampos()
622:         THIS.this_cModoAtual = "INCLUIR"
623:         THIS.HabilitarCampos(.T.)
624:         THIS.AjustarBotoesPorModo()
625:         THIS.AlternarPagina(2)
626:     ENDPROC
627: 
628:     *=========================================================================
629:     * BtnVisualizarClick - Abre Page2 em modo somente leitura
630:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
631:     *=========================================================================
632:     PROCEDURE BtnVisualizarClick()
633:         LOCAL loc_cFormas
634:         loc_cFormas = ""
635: 
636:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
637:             SELECT cursor_4c_Dados
638:             loc_cFormas = ALLTRIM(cursor_4c_Dados.formas)
639:         ENDIF
640: 
641:         IF EMPTY(loc_cFormas)
642:             MsgAviso("Selecione uma forma de pagamento para visualizar.")
643:         ELSE
644:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cFormas)
645:                 THIS.this_cModoAtual = "VISUALIZAR"
646:                 THIS.BOParaForm()
647:                 THIS.HabilitarCampos(.F.)
648:                 THIS.AjustarBotoesPorModo()
649:                 THIS.AlternarPagina(2)
650:             ENDIF
651:         ENDIF
652:     ENDPROC
653: 
654:     *=========================================================================
655:     * BtnAlterarClick - Abre Page2 para alterar forma de pagamento selecionada
656:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
657:     *=========================================================================
658:     PROCEDURE BtnAlterarClick()
659:         LOCAL loc_cFormas
660:         loc_cFormas = ""
661: 
662:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
663:             SELECT cursor_4c_Dados
664:             loc_cFormas = ALLTRIM(cursor_4c_Dados.formas)
665:         ENDIF
666: 
667:         IF EMPTY(loc_cFormas)
668:             MsgAviso("Selecione uma forma de pagamento para alterar.")
669:         ELSE
670:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cFormas)
671:                 THIS.this_oBusinessObject.EditarRegistro()
672:                 THIS.this_cModoAtual = "ALTERAR"
673:                 THIS.BOParaForm()
674:                 THIS.HabilitarCampos(.T.)
675:                 THIS.AjustarBotoesPorModo()
676:                 THIS.AlternarPagina(2)
677:             ENDIF
678:         ENDIF
679:     ENDPROC
680: 
681:     *=========================================================================
682:     * BtnExcluirClick - Exclui forma de pagamento selecionada com confirmacao
683:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
684:     *=========================================================================
685:     PROCEDURE BtnExcluirClick()
686:         LOCAL loc_cFormas
687:         loc_cFormas = ""
688: 
689:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
690:             SELECT cursor_4c_Dados
691:             loc_cFormas = ALLTRIM(cursor_4c_Dados.formas)
692:         ENDIF
693: 
694:         IF EMPTY(loc_cFormas)
695:             MsgAviso("Selecione uma forma de pagamento para excluir.")
696:         ELSE
697:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cFormas)
698:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da forma [" + loc_cFormas + "]?", ;
699:                     "Confirmar Exclus" + CHR(227) + "o")
700:                     IF THIS.this_oBusinessObject.Excluir()
701:                         MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
702:                         THIS.CarregarLista()
703:                     ENDIF
704:                 ENDIF
705:             ENDIF
706:         ENDIF
707:     ENDPROC
708: 
709:     *=========================================================================
710:     * BtnBuscarClick - Abre picker para localizar forma de pagamento na lista
711:     * Apos selecao, posiciona cursor no registro encontrado
712:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
713:     *=========================================================================
714:     PROCEDURE BtnBuscarClick()
715:         LOCAL loc_oBusca, loc_cFormas
716:         loc_cFormas = ""
717: 
718:         TRY
719:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
720:                 "SigCdFrm", "cursor_4c_BuscaFor", "formas", "", ;
721:                 "Buscar Forma de Pagamento")
722: 
723:             IF VARTYPE(loc_oBusca) = "O"
724:                 loc_oBusca.mAddColuna("formas", "", "Forma de Pagamento")
725:                 loc_oBusca.Show()
726: 
727:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFor")
728:                     SELECT cursor_4c_BuscaFor
729:                     loc_cFormas = ALLTRIM(cursor_4c_BuscaFor.formas)
730:                 ENDIF
731: 
732:                 loc_oBusca.Release()
733:             ENDIF
734: 
735:             IF USED("cursor_4c_BuscaFor")
736:                 USE IN cursor_4c_BuscaFor
737:             ENDIF
738: 
739:             IF !EMPTY(loc_cFormas) AND USED("cursor_4c_Dados")
740:                 SELECT cursor_4c_Dados
741:                 LOCATE FOR ALLTRIM(formas) == loc_cFormas
742:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
743:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
744:                 ENDIF
745:             ENDIF
746: 
747:         CATCH TO loException
748:             MostrarErro("Erro na busca:" + CHR(13) + loException.Message, ;
749:                 "FormFornecedor.BtnBuscarClick")
750:             IF USED("cursor_4c_BuscaFor")
751:                 USE IN cursor_4c_BuscaFor
752:             ENDIF
753:         ENDTRY
754:     ENDPROC
755: 
756:     *=========================================================================
757:     * BtnEncerrarClick - Fecha o formulario
758:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
759:     *=========================================================================
760:     PROCEDURE BtnEncerrarClick()
761:         THIS.Release()
762:     ENDPROC
763: 
764:     *=========================================================================
765:     * BtnSalvarClick - Confirma e salva o registro atual
766:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
767:     *=========================================================================
768:     PROCEDURE BtnSalvarClick()
769:         LOCAL loc_oPagina
770:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
771: 
772:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
773:             RETURN
774:         ENDIF
775: 
776:         THIS.FormParaBO()
777: 
778:         IF THIS.this_oBusinessObject.Salvar()
779:             MsgInfo("Registro salvo com sucesso!")
780:             THIS.AlternarPagina(1)
781:         ELSE
782:             *-- Replica legado: focar em Formas apos falha de validacao (vazio ou duplicado)
783:             IF PEMSTATUS(loc_oPagina, "txt_4c_Formas", 5) AND loc_oPagina.txt_4c_Formas.Enabled
784:                 loc_oPagina.txt_4c_Formas.SetFocus()
785:             ENDIF
786:         ENDIF
787:     ENDPROC
788: 
789:     *=========================================================================
790:     * BtnCancelarClick - Cancela edicao e volta para lista
791:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
792:     *=========================================================================
793:     PROCEDURE BtnCancelarClick()
794:         THIS.AlternarPagina(1)
795:         THIS.this_cModoAtual = "LISTA"
796:         THIS.CarregarLista()
797:     ENDPROC
798: 
799:     *=========================================================================
800:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
801:     * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)
802:     *=========================================================================
803:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
804:         LOCAL loc_nI, loc_oObjeto, loc_nP
805: 
806:         FOR loc_nI = 1 TO par_oContainer.ControlCount
807:             loc_oObjeto = par_oContainer.Controls(loc_nI)
808: 
809:             IF VARTYPE(loc_oObjeto) = "O"
810:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
811:                     loc_oObjeto.Visible = .T.
812:                 ENDIF
813: 
814:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
815:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
816:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
817:                     ENDFOR
818:                 ENDIF
819: 
820:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
821:                     THIS.TornarControlesVisiveis(loc_oObjeto)
822:                 ENDIF
823:             ENDIF
824:         ENDFOR
825:     ENDPROC
826: 
827:     *=========================================================================
828:     * FormParaBO - Transfere dados do Form para o BO antes de salvar
829:     * Campos: formas (PK C12), infos (Inf. Complementar C1)
830:     * PEMSTATUS: campos adicionados na Fase 5; guards garantem compatibilidade
831:     *=========================================================================
832:     PROTECTED PROCEDURE FormParaBO()
833:         LOCAL loc_oPagina
834:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
835: 
836:         IF PEMSTATUS(loc_oPagina, "txt_4c_Formas", 5)
837:             THIS.this_oBusinessObject.this_cFormas = ALLTRIM(loc_oPagina.txt_4c_Formas.Value)
838:         ENDIF
839:         IF PEMSTATUS(loc_oPagina, "txt_4c_Infos", 5)
840:             THIS.this_oBusinessObject.this_cInfos  = ALLTRIM(loc_oPagina.txt_4c_Infos.Value)
841:         ENDIF
842:     ENDPROC
843: 
844:     *=========================================================================
845:     * BOParaForm - Transfere dados do BO para o Form apos carregar registro
846:     * Campos: formas (PK C12), infos (Inf. Complementar C1)
847:     *=========================================================================
848:     PROTECTED PROCEDURE BOParaForm()
849:         LOCAL loc_oPagina
850:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
851: 
852:         IF PEMSTATUS(loc_oPagina, "txt_4c_Formas", 5)
853:             loc_oPagina.txt_4c_Formas.Value = THIS.this_oBusinessObject.this_cFormas
854:         ENDIF
855:         IF PEMSTATUS(loc_oPagina, "txt_4c_Infos", 5)
856:             loc_oPagina.txt_4c_Infos.Value  = THIS.this_oBusinessObject.this_cInfos
857:         ENDIF
858:     ENDPROC
859: 
860:     *=========================================================================
861:     * HabilitarCampos - Habilita ou desabilita campos de edicao da Page2
862:     * formas (PK): somente leitura no Alterar/Visualizar (legado: When do Get_formas
863:     *   retorna .F. exceto em INSERIR/PROCURAR)
864:     * infos: editavel em INCLUIR e ALTERAR
865:     *=========================================================================
866:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
867:         LOCAL loc_oPagina, loc_lFormasReadOnly
868:         loc_oPagina         = THIS.pgf_4c_Paginas.Page2
869:         loc_lFormasReadOnly = (THIS.this_cModoAtual != "INCLUIR")
870: 
871:         IF PEMSTATUS(loc_oPagina, "txt_4c_Formas", 5)
872:             loc_oPagina.txt_4c_Formas.Enabled = par_lHabilitar AND !loc_lFormasReadOnly
873:         ENDIF
874:         IF PEMSTATUS(loc_oPagina, "txt_4c_Infos", 5)
875:             loc_oPagina.txt_4c_Infos.Enabled  = par_lHabilitar
876:         ENDIF
877:     ENDPROC
878: 
879:     *=========================================================================
880:     * LimparCampos - Limpa todos os campos da Page2 para novo registro
881:     *=========================================================================
882:     PROTECTED PROCEDURE LimparCampos()
883:         LOCAL loc_oPagina
884:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
885: 
886:         IF PEMSTATUS(loc_oPagina, "txt_4c_Formas", 5)
887:             loc_oPagina.txt_4c_Formas.Value = ""
888:         ENDIF
889:         IF PEMSTATUS(loc_oPagina, "txt_4c_Infos", 5)
890:             loc_oPagina.txt_4c_Infos.Value  = ""
891:         ENDIF
892:     ENDPROC
893: 
894:     *=========================================================================
895:     * AjustarBotoesPorModo - Ajusta estado dos botoes da Page2 conforme modo
896:     * INCLUIR/ALTERAR: Confirmar habilitado | VISUALIZAR: Confirmar desabilitado
897:     *=========================================================================
898:     PROCEDURE AjustarBotoesPorModo()
899:         LOCAL loc_oPagina, loc_lEditando
900:         loc_oPagina   = THIS.pgf_4c_Paginas.Page2
901:         loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
902: 
903:         IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
904:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
905:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
906:             ENDIF
907:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
908:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
909:             ENDIF
910:         ENDIF
911:     ENDPROC
912: 
913:     *=========================================================================
914:     * txt_4c_InfosLostFocus - Handler LostFocus de txt_4c_Infos
915:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
916:     * Replica PROCEDURE Valid do Get_INFO legado: valida SigPrInf ao sair do campo
917:     *=========================================================================
918:     PROCEDURE txt_4c_InfosLostFocus()
919:         LOCAL loc_cValor, loc_oPagina
920:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
921:         loc_cValor  = ""
922: 
923:         IF PEMSTATUS(loc_oPagina, "txt_4c_Infos", 5)
924:             loc_cValor = ALLTRIM(loc_oPagina.txt_4c_Infos.Value)
925:         ENDIF
926: 
927:         IF !EMPTY(loc_cValor)
928:             THIS.AbrirLookupInfos()
929:         ENDIF
930:     ENDPROC
931: 
932:     *=========================================================================
933:     * txt_4c_InfosKeyPress - Handler KeyPress de txt_4c_Infos (F4=28 abre lookup)
934:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
935:     *=========================================================================
936:     PROCEDURE txt_4c_InfosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
937:         IF par_nKeyCode = 28    && F4
938:             THIS.AbrirLookupInfos()
939:         ENDIF
940:     ENDPROC
941: 
942:     *=========================================================================
943:     * AbrirLookupInfos - Lookup para campo Infos (Inf. Complementar) em SigPrInf
944:     * Replica logica do Get_INFO.Valid legado (fwBuscaExt para SigPrInf)
945:     * SigPrInf colunas: Infos (C1 PK codigo), descrs (descricao)
946:     *=========================================================================
947:     PROTECTED PROCEDURE AbrirLookupInfos()
948:         LOCAL loc_oBusca, loc_cValor, loc_oPagina
949:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
950: 
951:         IF !PEMSTATUS(loc_oPagina, "txt_4c_Infos", 5)
952:             RETURN
953:         ENDIF
954: 
955:         IF !loc_oPagina.txt_4c_Infos.Enabled
956:             RETURN
957:         ENDIF
958: 
959:         loc_cValor = ALLTRIM(loc_oPagina.txt_4c_Infos.Value)
960: 
961:         IF EMPTY(loc_cValor)
962:             RETURN
963:         ENDIF
964: 
965:         TRY
966:             *-- FormBuscaAuxiliar: busca match exato em SigPrInf.Infos
967:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
968:                 "SigPrInf", "cursor_4c_BuscaInf", "Infos", loc_cValor, ;
969:                 "Inf. Complementares")
970: 
971:             IF VARTYPE(loc_oBusca) = "O"
972:                 *-- Se nao achou match exato: mostrar picker (replica legado !plAchouRegistro -> Show())
973:                 IF !loc_oBusca.this_lAchouRegistro
974:                     loc_oBusca.mAddColuna("Infos",  "", "C" + CHR(243) + "digo")
975:                     loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
976:                     loc_oBusca.Show()
977:                 ENDIF
978: 
979:                 *-- Achou exato OU usuario selecionou no picker: usar valor do cursor
980:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaInf")
981:                     SELECT cursor_4c_BuscaInf
982:                     loc_oPagina.txt_4c_Infos.Value = ALLTRIM(cursor_4c_BuscaInf.Infos)
983:                 ELSE
984:                     *-- ESC no picker ou nao encontrou: limpar campo (replica legado This.Value='')
985:                     loc_oPagina.txt_4c_Infos.Value = ""
986:                 ENDIF
987: 
988:                 loc_oBusca.Release()
989:             ENDIF
990: 
991:             IF USED("cursor_4c_BuscaInf")
992:                 USE IN cursor_4c_BuscaInf
993:             ENDIF
994: 
995:         CATCH TO loException
996:             MostrarErro("Erro ao abrir lookup Inf. Complementar:" + CHR(13) + ;
997:                 loException.Message, "FormFornecedor.AbrirLookupInfos")
998:             IF USED("cursor_4c_BuscaInf")
999:                 USE IN cursor_4c_BuscaInf
1000:             ENDIF
1001:         ENDTRY
1002:     ENDPROC
1003: 
1004:     *=========================================================================
1005:     * Destroy - Libera recursos ao fechar o formulario
1006:     *=========================================================================
1007:     PROCEDURE Destroy()
1008:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1009:             THIS.this_oBusinessObject = .NULL.
1010:         ENDIF
1011: 
1012:         IF USED("cursor_4c_Dados")
1013:             USE IN cursor_4c_Dados
1014:         ENDIF
1015: 
1016:         IF USED("cursor_4c_BuscaFor")
1017:             USE IN cursor_4c_BuscaFor
1018:         ENDIF
1019: 
1020:         IF USED("cursor_4c_BuscaInf")
1021:             USE IN cursor_4c_BuscaInf
1022:         ENDIF
1023: 
1024:         DODEFAULT()
1025:     ENDPROC
1026: 
1027: ENDDEFINE


### BO (C:\4c\projeto\app\classes\FornecedorBO.prg):
*====================================================================
* FornecedorBO.prg
*
* Business Object para Cadastro de Formas de Pagamento
* Tabela: SigCdFrm
* Herda de: BusinessBase
*
* Origem: SIGCDFOR (SIG CaDastro FORmas de pagamento)
*====================================================================

DEFINE CLASS FornecedorBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdFrm)
    this_cFormas = ""    && formas char(12) NOT NULL - PK (Forma de Pagamento)
    this_cInfos  = ""    && infos  char(1)  NOT NULL - Inf. Complementar (FK SigPrInf.Infos)

    *====================================================================
    * Init - Inicializa Business Object
    *
    * Define nome da tabela e campo chave para uso pela BusinessBase
    * (Buscar, CarregarPorCodigo, Inserir, Atualizar, ExecutarExclusao,
    *  RegistrarAuditoria, etc.)
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdFrm"
            THIS.this_cCampoChave = "formas"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro("Erro ao inicializar FornecedorBO:" + CHR(13) + ;
                        loException.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cFormas)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cFormas = TratarNulo(formas, "C")
                THIS.this_cInfos  = TratarNulo(infos,  "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "FornecedorBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    * Logica original: formas nao pode ser vazio + check duplicata em INSERIR
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cFormas)
            MsgAviso("Forma de Pagamento Inv" + CHR(225) + "lida.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarFormaExistente(THIS.this_cFormas)
                MsgAviso("Forma de Pagamento j" + CHR(225) + " cadastrada.")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarFormaExistente - Verifica se formas ja existe no banco
    *====================================================================
    PROCEDURE VerificarFormaExistente(par_cFormas)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdFrm" + ;
                " WHERE formas = " + EscaparSQL(par_cFormas)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkFrm")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkFrm")
                SELECT cursor_4c_ChkFrm
                loc_lExiste = (cursor_4c_ChkFrm.qtd > 0)
                USE IN cursor_4c_ChkFrm
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar forma:" + CHR(13) + loException.Message, "FornecedorBO.VerificarFormaExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdFrm
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdFrm (formas, infos)
                VALUES (
                    <<EscaparSQL(THIS.this_cFormas)>>,
                    <<EscaparSQL(THIS.this_cInfos)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir Forma de Pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "FornecedorBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdFrm
    * Nota: formas e a PK e nao pode ser alterada
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdFrm
                SET infos = <<EscaparSQL(THIS.this_cInfos)>>
                WHERE formas = <<EscaparSQL(THIS.this_cFormas)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar Forma de Pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "FornecedorBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdFrm
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdFrm WHERE formas = " + EscaparSQL(THIS.this_cFormas)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir Forma de Pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "FornecedorBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com formas, infos, descrs (JOIN SigPrInf)
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (formas C(12), infos C(1), descrs C(15))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.formas, a.infos, ISNULL(b.descrs,'') AS descrs" + ;
                    " FROM SigCdFrm a" + ;
                    " LEFT JOIN SigPrInf b ON b.infos = a.infos"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY a.formas"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar Formas de Pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar Formas de Pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "FornecedorBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (formas)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT formas, infos FROM SigCdFrm" + ;
                " WHERE formas = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Forma de Pagamento n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar Forma de Pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "FornecedorBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

