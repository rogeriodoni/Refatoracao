# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [BINDEVENT-PARAMS] Handler 'EmpPadLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE EmpPadLostFocus(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormNcf.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1128 linhas total):

*-- Linhas 27 a 153:
27:     this_cModoAtual      = "LISTA"
28: 
29:     *--------------------------------------------------------------------------
30:     * Init - Retorna DODEFAULT (FormBase.Init chama InicializarForm)
31:     *--------------------------------------------------------------------------
32:     PROCEDURE Init()
33:         LOCAL loc_lResultado
34:         loc_lResultado = .F.
35: 
36:         TRY
37:             loc_lResultado = DODEFAULT()
38:         CATCH TO loc_oErro
39:             MsgErro(loc_oErro.Message, "FormNcf.Init")
40:         ENDTRY
41: 
42:         RETURN loc_lResultado
43:     ENDPROC
44: 
45:     *--------------------------------------------------------------------------
46:     * InicializarForm - Configura estrutura completa
47:     * Chamado automaticamente pelo FormBase.Init()
48:     *--------------------------------------------------------------------------
49:     PROTECTED PROCEDURE InicializarForm()
50:         LOCAL loc_lResultado
51:         loc_lResultado = .F.
52: 
53:         TRY
54:             THIS.Caption = "Cadastro de N" + CHR(227) + "o-Conformidades"
55: 
56:             THIS.this_oBusinessObject = CREATEOBJECT("NcfBO")
57: 
58:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
59:                 MsgErro("Falha ao criar NcfBO", "Erro")
60:             ELSE
61:                 THIS.ConfigurarPageFrame()
62: 
63:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
64:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
65: 
66:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
67:                     THIS.CarregarLista()
68:                 ENDIF
69: 
70:                 THIS.pgf_4c_Paginas.Visible   = .T.
71:                 THIS.pgf_4c_Paginas.ActivePage = 1
72:                 THIS.this_cModoAtual           = "LISTA"
73:                 loc_lResultado                 = .T.
74:             ENDIF
75:         CATCH TO loc_oErro
76:             MsgErro(loc_oErro.Message, "FormNcf.InicializarForm")
77:         ENDTRY
78: 
79:         RETURN loc_lResultado
80:     ENDPROC
81: 
82:     *--------------------------------------------------------------------------
83:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
84:     *--------------------------------------------------------------------------
85:     PROTECTED PROCEDURE ConfigurarPageFrame()
86:         LOCAL loc_oPgf
87:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
88:         loc_oPgf = THIS.pgf_4c_Paginas
89: 
90:         WITH loc_oPgf
91:             .PageCount       = 2
92:             .Top             = -29
93:             .Left            = 0
94:             .Width           = THIS.Width
95:             .Height          = THIS.Height + 29
96:             .Tabs            = .F.
97:             .Visible         = .T.
98:             .Page1.Caption   = "Lista"
99:             .Page1.BackColor = RGB(100, 100, 100)
100:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101:             .Page2.Caption   = "Dados"
102:             .Page2.BackColor = RGB(100, 100, 100)
103:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:         ENDWITH
105: 
106:         THIS.ConfigurarPaginaLista()
107:         THIS.ConfigurarPaginaDados()
108:     ENDPROC
109: 
110:     *--------------------------------------------------------------------------
111:     * ConfigurarPaginaLista - Configura Page1: cabecalho + botoes CRUD + grid
112:     *--------------------------------------------------------------------------
113:     PROTECTED PROCEDURE ConfigurarPaginaLista()
114:         LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid
115: 
116:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
117: 
118:         *-- Container cabecalho cinza escuro (Top = 2 + 29 compensacao PageFrame)
119:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
120:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
121:         WITH loc_oCab
122:             .Top         = 31
123:             .Left        = 0
124:             .Width       = THIS.Width
125:             .Height      = 80
126:             .BackColor   = RGB(100, 100, 100)
127:             .BorderWidth = 0
128:             .Visible     = .T.
129:         ENDWITH
130: 
131:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
132:         WITH loc_oCab.lbl_4c_Sombra
133:             .AutoSize  = .F.
134:             .Caption   = THIS.Caption
135:             .Top       = 15
136:             .Left      = 10
137:             .Width     = THIS.Width
138:             .Height    = 40
139:             .FontName  = "Tahoma"
140:             .FontSize  = 16
141:             .FontBold  = .T.
142:             .ForeColor = RGB(0, 0, 0)
143:             .BackStyle = 0
144:             .Visible   = .T.
145:         ENDWITH
146: 
147:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
148:         WITH loc_oCab.lbl_4c_Titulo
149:             .AutoSize  = .F.
150:             .Caption   = THIS.Caption
151:             .Top       = 18
152:             .Left      = 10
153:             .Width     = THIS.Width

*-- Linhas 197 a 478:
197:             .AutoSize        = .F.
198:             .Visible         = .T.
199:         ENDWITH
200:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
201: 
202:         *-- Botao Visualizar
203:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
204:         WITH loc_oBotoes.cmd_4c_Visualizar
205:             .Caption         = "Visualizar"
206:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
207:             .PicturePosition = 13
208:             .Top             = 5
209:             .Left            = 80
210:             .Width           = 75
211:             .Height          = 75
212:             .BackColor       = RGB(255, 255, 255)
213:             .ForeColor       = RGB(90, 90, 90)
214:             .FontName        = "Comic Sans MS"
215:             .FontSize        = 8
216:             .FontBold        = .T.
217:             .FontItalic      = .T.
218:             .Themes          = .F.
219:             .SpecialEffect   = 0
220:             .MousePointer    = 15
221:             .WordWrap        = .T.
222:             .AutoSize        = .F.
223:             .Visible         = .T.
224:         ENDWITH
225:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
226: 
227:         *-- Botao Alterar
228:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
229:         WITH loc_oBotoes.cmd_4c_Alterar
230:             .Caption         = "Alterar"
231:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
232:             .PicturePosition = 13
233:             .Top             = 5
234:             .Left            = 155
235:             .Width           = 75
236:             .Height          = 75
237:             .BackColor       = RGB(255, 255, 255)
238:             .ForeColor       = RGB(90, 90, 90)
239:             .FontName        = "Comic Sans MS"
240:             .FontSize        = 8
241:             .FontBold        = .T.
242:             .FontItalic      = .T.
243:             .Themes          = .F.
244:             .SpecialEffect   = 0
245:             .MousePointer    = 15
246:             .WordWrap        = .T.
247:             .AutoSize        = .F.
248:             .Visible         = .T.
249:         ENDWITH
250:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
251: 
252:         *-- Botao Excluir
253:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
254:         WITH loc_oBotoes.cmd_4c_Excluir
255:             .Caption         = "Excluir"
256:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
257:             .PicturePosition = 13
258:             .Top             = 5
259:             .Left            = 230
260:             .Width           = 75
261:             .Height          = 75
262:             .BackColor       = RGB(255, 255, 255)
263:             .ForeColor       = RGB(90, 90, 90)
264:             .FontName        = "Comic Sans MS"
265:             .FontSize        = 8
266:             .FontBold        = .T.
267:             .FontItalic      = .T.
268:             .Themes          = .F.
269:             .SpecialEffect   = 0
270:             .MousePointer    = 15
271:             .WordWrap        = .T.
272:             .AutoSize        = .F.
273:             .Visible         = .T.
274:         ENDWITH
275:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
276: 
277:         *-- Botao Buscar
278:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
279:         WITH loc_oBotoes.cmd_4c_Buscar
280:             .Caption         = "Buscar"
281:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
282:             .PicturePosition = 13
283:             .Top             = 5
284:             .Left            = 305
285:             .Width           = 75
286:             .Height          = 75
287:             .BackColor       = RGB(255, 255, 255)
288:             .ForeColor       = RGB(90, 90, 90)
289:             .FontName        = "Comic Sans MS"
290:             .FontSize        = 8
291:             .FontBold        = .T.
292:             .FontItalic      = .T.
293:             .Themes          = .F.
294:             .SpecialEffect   = 0
295:             .MousePointer    = 15
296:             .WordWrap        = .T.
297:             .AutoSize        = .F.
298:             .Visible         = .T.
299:         ENDWITH
300:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
301: 
302:         *-- Container saida canonico (Left=917, Width=90, transparente)
303:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
304:         loc_oSaida = loc_oPg1.cnt_4c_Saida
305:         WITH loc_oSaida
306:             .Top         = 29
307:             .Left        = 917
308:             .Width       = 90
309:             .Height      = 85
310:             .BackStyle   = 0
311:             .BorderWidth = 0
312:             .Visible     = .T.
313:         ENDWITH
314: 
315:         *-- Botao Encerrar (canonico)
316:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
317:         WITH loc_oSaida.cmd_4c_Encerrar
318:             .Caption         = "Encerrar"
319:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
320:             .PicturePosition = 13
321:             .Top             = 5
322:             .Left            = 5
323:             .Width           = 75
324:             .Height          = 75
325:             .BackColor       = RGB(255, 255, 255)
326:             .ForeColor       = RGB(90, 90, 90)
327:             .FontName        = "Comic Sans MS"
328:             .FontSize        = 8
329:             .FontBold        = .T.
330:             .FontItalic      = .T.
331:             .Themes          = .F.
332:             .SpecialEffect   = 0
333:             .MousePointer    = 15
334:             .WordWrap        = .T.
335:             .AutoSize        = .F.
336:             .Visible         = .T.
337:         ENDWITH
338:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
339: 
340:         *-- Grid de lista: top=121+29=150 (compensacao PageFrame), left=12, width=940, height=470
341:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
342:         loc_oGrid = loc_oPg1.grd_4c_Lista
343:         loc_oGrid.RecordSource = ""
344:         loc_oGrid.ColumnCount  = 2
345:         WITH loc_oGrid
346:             .Top                = 150
347:             .Left               = 12
348:             .Width              = 940
349:             .Height             = 470
350:             .FontName           = "Verdana"
351:             .FontSize           = 8
352:             .ForeColor          = RGB(90, 90, 90)
353:             .BackColor          = RGB(255, 255, 255)
354:             .GridLineColor      = RGB(238, 238, 238)
355:             .GridLines          = 3
356:             .HighlightBackColor = RGB(255, 255, 255)
357:             .HighlightForeColor = RGB(15, 41, 104)
358:             .HighlightStyle     = 2
359:             .DeleteMark         = .F.
360:             .RecordMark         = .F.
361:             .RowHeight          = 16
362:             .ScrollBars         = 2
363:             .ReadOnly           = .T.
364:             .Visible            = .T.
365:         ENDWITH
366: 
367:         THIS.TornarControlesVisiveis(loc_oPg1)
368:     ENDPROC
369: 
370:     *--------------------------------------------------------------------------
371:     * ConfigurarPaginaDados - Configura Page2: botoes + campos Codigo e Descricao
372:     *--------------------------------------------------------------------------
373:     PROTECTED PROCEDURE ConfigurarPaginaDados()
374:         LOCAL loc_oPg2, loc_oSalva
375:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
376: 
377:         *-- Container botoes Salvar/Cancelar (Grupo_Salva original: Top=23, Left=616 -> Top=52 com +29)
378:         loc_oPg2.AddObject("cnt_4c_Salva", "Container")
379:         loc_oSalva = loc_oPg2.cnt_4c_Salva
380:         WITH loc_oSalva
381:             .Top         = 52
382:             .Left        = 616
383:             .Width       = 160
384:             .Height      = 85
385:             .BackStyle   = 0
386:             .BorderWidth = 0
387:             .Visible     = .T.
388:         ENDWITH
389: 
390:         *-- Botao Confirmar (Salva original: Left=5, Top=5)
391:         loc_oSalva.AddObject("cmd_4c_Confirmar", "CommandButton")
392:         WITH loc_oSalva.cmd_4c_Confirmar
393:             .Caption         = "Confirmar"
394:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
395:             .PicturePosition = 13
396:             .Top             = 5
397:             .Left            = 5
398:             .Width           = 75
399:             .Height          = 75
400:             .BackColor       = RGB(255, 255, 255)
401:             .ForeColor       = RGB(90, 90, 90)
402:             .FontName        = "Comic Sans MS"
403:             .FontSize        = 8
404:             .FontBold        = .T.
405:             .FontItalic      = .T.
406:             .Themes          = .F.
407:             .SpecialEffect   = 0
408:             .MousePointer    = 15
409:             .WordWrap        = .T.
410:             .AutoSize        = .F.
411:             .Visible         = .T.
412:         ENDWITH
413:         BINDEVENT(loc_oSalva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
414: 
415:         *-- Botao Cancelar (Cancelar original: Left=80, Top=5)
416:         loc_oSalva.AddObject("cmd_4c_Cancelar", "CommandButton")
417:         WITH loc_oSalva.cmd_4c_Cancelar
418:             .Caption         = "Encerrar"
419:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
420:             .PicturePosition = 13
421:             .Top             = 5
422:             .Left            = 80
423:             .Width           = 75
424:             .Height          = 75
425:             .BackColor       = RGB(255, 255, 255)
426:             .ForeColor       = RGB(90, 90, 90)
427:             .FontName        = "Comic Sans MS"
428:             .FontSize        = 8
429:             .FontBold        = .T.
430:             .FontItalic      = .T.
431:             .Themes          = .F.
432:             .SpecialEffect   = 0
433:             .MousePointer    = 15
434:             .WordWrap        = .T.
435:             .AutoSize        = .F.
436:             .Visible         = .T.
437:         ENDWITH
438:         BINDEVENT(loc_oSalva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
439: 
440:         *-- Label Codigo (Label2: Top=237+29=266, Left=184, Width=42, Height=15)
441:         loc_oPg2.AddObject("lbl_4c_Label2", "Label")
442:         WITH loc_oPg2.lbl_4c_Label2
443:             .AutoSize  = .T.
444:             .Caption   = "C" + CHR(243) + "digo :"
445:             .Top       = 266
446:             .Left      = 184
447:             .Width     = 42
448:             .Height    = 15
449:             .FontName  = "Tahoma"
450:             .FontSize  = 8
451:             .BackStyle = 0
452:             .ForeColor = RGB(90, 90, 90)
453:             .Visible   = .T.
454:         ENDWITH
455: 
456:         *-- TextBox Codigo (getCods: Top=234+29=263, Left=234, Width=80, MaxLength=10)
457:         loc_oPg2.AddObject("txt_4c_Codigo", "TextBox")
458:         WITH loc_oPg2.txt_4c_Codigo
459:             .Value     = ""
460:             .Top       = 263
461:             .Left      = 234
462:             .Width     = 80
463:             .Height    = 23
464:             .FontName  = "Tahoma"
465:             .FontSize  = 8
466:             .ForeColor = RGB(0, 0, 0)
467:             .MaxLength = 10
468:             .Visible   = .T.
469:         ENDWITH
470: 
471:         *-- Label Descricao (Label1: Top=262+29=291, Left=171, Width=55, Height=15)
472:         loc_oPg2.AddObject("lbl_4c_Label1", "Label")
473:         WITH loc_oPg2.lbl_4c_Label1
474:             .AutoSize  = .T.
475:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
476:             .Top       = 291
477:             .Left      = 171
478:             .Width     = 55

*-- Linhas 513 a 557:
513:             .Visible   = .T.
514:         ENDWITH
515: 
516:         *-- OptionGroup Descricao Fixa (Opt_Menu: fixos 1=Sim/2=Nao, Top=284+29=313, Left=231)
517:         loc_oPg2.AddObject("opt_4c_OptMenu", "OptionGroup")
518:         WITH loc_oPg2.opt_4c_OptMenu
519:             .ButtonCount   = 2
520:             .Value         = 2
521:             .Top           = 313
522:             .Left          = 231
523:             .Width         = 89
524:             .Height        = 20
525:             .SpecialEffect = 0
526:             .BackStyle     = 0
527:             .BorderStyle   = 0
528:             .Visible       = .T.
529:         ENDWITH
530:         WITH loc_oPg2.opt_4c_OptMenu.Buttons(1)
531:             .Caption   = "Sim"
532:             .BackStyle = 0
533:             .Left      = 4
534:             .Top       = 2
535:             .AutoSize  = .T.
536:             .Alignment = 0
537:             .FontName  = "Tahoma"
538:             .FontSize  = 8
539:             .ForeColor = RGB(90, 90, 90)
540:             .Themes    = .F.
541:             .Visible   = .T.
542:         ENDWITH
543:         WITH loc_oPg2.opt_4c_OptMenu.Buttons(2)
544:             .Caption   = "N" + CHR(227) + "o"
545:             .BackStyle = 0
546:             .Left      = 43
547:             .Top       = 2
548:             .AutoSize  = .T.
549:             .FontName  = "Tahoma"
550:             .FontSize  = 8
551:             .ForeColor = RGB(90, 90, 90)
552:             .Themes    = .F.
553:             .Visible   = .T.
554:         ENDWITH
555: 
556:         *-- Label "Tipo :" (Say1: Top=306+29=335, Left=197)
557:         loc_oPg2.AddObject("lbl_4c_LabelTipo", "Label")

*-- Linhas 567 a 611:
567:             .Visible   = .T.
568:         ENDWITH
569: 
570:         *-- OptionGroup Tipo (get_tipo: tipos 1-4, Top=304+29=333, Left=231, Width=279, Height=43)
571:         loc_oPg2.AddObject("opt_4c_GetTipo", "OptionGroup")
572:         WITH loc_oPg2.opt_4c_GetTipo
573:             .ButtonCount   = 4
574:             .Value         = 1
575:             .Top           = 333
576:             .Left          = 231
577:             .Width         = 279
578:             .Height        = 43
579:             .SpecialEffect = 0
580:             .BackStyle     = 0
581:             .BorderStyle   = 0
582:             .Visible       = .T.
583:         ENDWITH
584:         WITH loc_oPg2.opt_4c_GetTipo.Buttons(1)
585:             .Caption   = "N" + CHR(227) + "o Conforme"
586:             .Left      = 4
587:             .Top       = 2
588:             .AutoSize  = .T.
589:             .Alignment = 0
590:             .FontName  = "Tahoma"
591:             .FontSize  = 8
592:             .BackStyle = 0
593:             .ForeColor = RGB(90, 90, 90)
594:             .Themes    = .F.
595:             .Visible   = .T.
596:         ENDWITH
597:         WITH loc_oPg2.opt_4c_GetTipo.Buttons(2)
598:             .Caption   = "Limite Qtd"
599:             .Left      = 115
600:             .Top       = 2
601:             .AutoSize  = .T.
602:             .FontName  = "Tahoma"
603:             .FontSize  = 8
604:             .BackStyle = 0
605:             .ForeColor = RGB(90, 90, 90)
606:             .Themes    = .F.
607:             .Visible   = .T.
608:         ENDWITH
609:         WITH loc_oPg2.opt_4c_GetTipo.Buttons(3)
610:             .Caption   = "Varia" + CHR(231) + CHR(227) + "o Peso"
611:             .Left      = 4

*-- Linhas 666 a 1128:
666:             .MaxLength = 3
667:             .Visible   = .T.
668:         ENDWITH
669:         BINDEVENT(loc_oPg2.txt_4c_EmpPad, "KeyPress", THIS, "EmpPadLostFocus")
670:         BINDEVENT(loc_oPg2.txt_4c_EmpPad, "DblClick",  THIS, "EmpPadDblClick")
671: 
672:         THIS.TornarControlesVisiveis(loc_oPg2)
673:     ENDPROC
674: 
675:     *--------------------------------------------------------------------------
676:     * CarregarLista - Carrega registros no grid da Page1
677:     *--------------------------------------------------------------------------
678:     PROCEDURE CarregarLista()
679:         LOCAL loc_lResultado, loc_oGrid
680:         loc_lResultado = .F.
681: 
682:         TRY
683:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
684:                 loc_lResultado = .T.
685:             ELSE
686:                 IF THIS.this_oBusinessObject.Buscar("")
687:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
688:                     loc_oGrid.ColumnCount = 2
689:                     loc_oGrid.RecordSource          = "cursor_4c_Dados"
690:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
691:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
692:                     loc_oGrid.Column1.Width         = 80
693:                     loc_oGrid.Column2.Width         = 290
694:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
695:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
696:                     THIS.FormatarGridLista(loc_oGrid)
697:                     loc_lResultado = .T.
698:                 ENDIF
699:             ENDIF
700:         CATCH TO loc_oErro
701:             MsgErro(loc_oErro.Message, "FormNcf.CarregarLista")
702:         ENDTRY
703: 
704:         RETURN loc_lResultado
705:     ENDPROC
706: 
707:     *--------------------------------------------------------------------------
708:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
709:     *--------------------------------------------------------------------------
710:     PROCEDURE AlternarPagina(par_nPagina)
711:         LOCAL loc_lResultado
712:         loc_lResultado = .F.
713: 
714:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
715:             RETURN .F.
716:         ENDIF
717: 
718:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
719: 
720:         IF par_nPagina = 1
721:             THIS.CarregarLista()
722:         ENDIF
723: 
724:         loc_lResultado = .T.
725: 
726:         RETURN loc_lResultado
727:     ENDPROC
728: 
729:     *--------------------------------------------------------------------------
730:     * FormatarGridLista - Formata visual do grid da lista
731:     *--------------------------------------------------------------------------
732:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
733:         WITH par_oGrid
734:             .FontName = "Verdana"
735:             .FontSize = 8
736:         ENDWITH
737:     ENDPROC
738: 
739:     *--------------------------------------------------------------------------
740:     * BtnIncluirClick - Inicia inclusao de novo registro
741:     *--------------------------------------------------------------------------
742:     PROCEDURE BtnIncluirClick()
743:         THIS.this_oBusinessObject.NovoRegistro()
744:         THIS.this_cModoAtual = "INCLUIR"
745:         THIS.LimparCampos()
746:         THIS.HabilitarCampos(.T.)
747:         THIS.AjustarBotoesPorModo()
748:         THIS.AlternarPagina(2)
749:         THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus
750:     ENDPROC
751: 
752:     *--------------------------------------------------------------------------
753:     * BtnVisualizarClick - Carrega registro selecionado para visualizacao
754:     *--------------------------------------------------------------------------
755:     PROCEDURE BtnVisualizarClick()
756:         LOCAL loc_cCodigo
757:         loc_cCodigo = ""
758: 
759:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
760:             SELECT cursor_4c_Dados
761:             loc_cCodigo = ALLTRIM(cods)
762:         ENDIF
763: 
764:         IF EMPTY(loc_cCodigo)
765:             MsgAviso("Selecione um registro na lista.", "Visualizar")
766:             RETURN
767:         ENDIF
768: 
769:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
770:             THIS.this_cModoAtual = "VISUALIZAR"
771:             THIS.HabilitarCampos(.F.)
772:             THIS.BOParaForm()
773:             THIS.AjustarBotoesPorModo()
774:             THIS.AlternarPagina(2)
775:         ENDIF
776:     ENDPROC
777: 
778:     *--------------------------------------------------------------------------
779:     * BtnAlterarClick - Carrega registro selecionado para alteracao
780:     *--------------------------------------------------------------------------
781:     PROCEDURE BtnAlterarClick()
782:         LOCAL loc_cCodigo
783:         loc_cCodigo = ""
784: 
785:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
786:             SELECT cursor_4c_Dados
787:             loc_cCodigo = ALLTRIM(cods)
788:         ENDIF
789: 
790:         IF EMPTY(loc_cCodigo)
791:             MsgAviso("Selecione um registro na lista.", "Alterar")
792:             RETURN
793:         ENDIF
794: 
795:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
796:             THIS.this_oBusinessObject.EditarRegistro()
797:             THIS.this_cModoAtual = "ALTERAR"
798:             THIS.HabilitarCampos(.T.)
799:             THIS.BOParaForm()
800:             THIS.AjustarBotoesPorModo()
801:             THIS.AlternarPagina(2)
802:             THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus
803:         ENDIF
804:     ENDPROC
805: 
806:     *--------------------------------------------------------------------------
807:     * BtnExcluirClick - Confirma e exclui registro selecionado
808:     *--------------------------------------------------------------------------
809:     PROCEDURE BtnExcluirClick()
810:         LOCAL loc_cCodigo, loc_cDescricao, loc_lConfirma
811:         loc_cCodigo   = ""
812:         loc_cDescricao = ""
813: 
814:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
815:             SELECT cursor_4c_Dados
816:             loc_cCodigo    = ALLTRIM(cods)
817:             loc_cDescricao = ALLTRIM(descs)
818:         ENDIF
819: 
820:         IF EMPTY(loc_cCodigo)
821:             MsgAviso("Selecione um registro na lista.", "Excluir")
822:             RETURN
823:         ENDIF
824: 
825:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o da N" + CHR(227) + "o-Conformidade?" + ;
826:                                     CHR(13) + CHR(13) + ;
827:                                     "C" + CHR(243) + "digo: " + loc_cCodigo + CHR(13) + ;
828:                                     "Descri" + CHR(231) + CHR(227) + "o: " + loc_cDescricao, ;
829:                                     "Confirmar Exclus" + CHR(227) + "o")
830: 
831:         IF !loc_lConfirma
832:             RETURN
833:         ENDIF
834: 
835:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
836:             IF THIS.this_oBusinessObject.Excluir()
837:                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
838:                 THIS.CarregarLista()
839:             ENDIF
840:         ENDIF
841:     ENDPROC
842: 
843:     *--------------------------------------------------------------------------
844:     * BtnBuscarClick - Filtra registros na lista
845:     *--------------------------------------------------------------------------
846:     PROCEDURE BtnBuscarClick()
847:         LOCAL loc_cFiltro, loc_oGrid
848:         loc_cFiltro = INPUTBOX("Buscar por c" + CHR(243) + "digo ou descri" + CHR(231) + CHR(227) + "o:", ;
849:                                "Buscar N" + CHR(227) + "o-Conformidade", "")
850: 
851:         IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
852:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
853:             loc_oGrid.ColumnCount = 2
854:             loc_oGrid.RecordSource          = "cursor_4c_Dados"
855:             loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
856:             loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
857:             loc_oGrid.Column1.Width         = 80
858:             loc_oGrid.Column2.Width         = 290
859:             loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
860:             loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
861:             THIS.FormatarGridLista(loc_oGrid)
862:             loc_oGrid.Refresh()
863:         ENDIF
864:     ENDPROC
865: 
866:     *--------------------------------------------------------------------------
867:     * BtnEncerrarClick - Fecha o formulario
868:     *--------------------------------------------------------------------------
869:     PROCEDURE BtnEncerrarClick()
870:         THIS.Release()
871:     ENDPROC
872: 
873:     *--------------------------------------------------------------------------
874:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
875:     *--------------------------------------------------------------------------
876:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
877:         LOCAL loc_i, loc_oControl, loc_nP
878: 
879:         FOR loc_i = 1 TO par_oContainer.ControlCount
880:             loc_oControl = par_oContainer.Controls(loc_i)
881: 
882:             IF VARTYPE(loc_oControl) = "O"
883:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
884:                     loc_oControl.Visible = .T.
885:                 ENDIF
886: 
887:                 IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
888:                     FOR loc_nP = 1 TO loc_oControl.PageCount
889:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
890:                     ENDFOR
891:                 ENDIF
892: 
893:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5)
894:                     THIS.TornarControlesVisiveis(loc_oControl)
895:                 ENDIF
896:             ENDIF
897:         ENDFOR
898:     ENDPROC
899: 
900:     *--------------------------------------------------------------------------
901:     * BtnSalvarClick - Valida e salva registro (Confirmar)
902:     *--------------------------------------------------------------------------
903:     PROCEDURE BtnSalvarClick()
904:         LOCAL loc_oPg2, loc_cCodigo, loc_cDescricao
905:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
906: 
907:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
908:             loc_cCodigo    = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
909:             loc_cDescricao = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
910: 
911:             IF EMPTY(loc_cCodigo)
912:                 MsgAviso("Obrigat" + CHR(243) + "rio Informar o C" + CHR(243) + "digo!!!", "")
913:                 loc_oPg2.txt_4c_Codigo.SetFocus
914:                 RETURN
915:             ENDIF
916: 
917:             IF EMPTY(loc_cDescricao)
918:                 MsgAviso("Obrigat" + CHR(243) + "rio Informar a Descri" + CHR(231) + CHR(227) + "o!!!", "")
919:                 loc_oPg2.txt_4c_Descricao.SetFocus
920:                 RETURN
921:             ENDIF
922:         ENDIF
923: 
924:         THIS.FormParaBO()
925: 
926:         IF THIS.this_oBusinessObject.Salvar()
927:             MsgInfo("Registro salvo com sucesso!", "Salvar")
928:             THIS.AlternarPagina(1)
929:         ENDIF
930:     ENDPROC
931: 
932:     *--------------------------------------------------------------------------
933:     * BtnCancelarClick - Cancela edicao e volta para lista
934:     *--------------------------------------------------------------------------
935:     PROCEDURE BtnCancelarClick()
936:         THIS.this_cModoAtual = "LISTA"
937:         THIS.AlternarPagina(1)
938:     ENDPROC
939: 
940:     *--------------------------------------------------------------------------
941:     * EmpPadLostFocus / EmpPadDblClick - Handlers BINDEVENT para txt_4c_EmpPad
942:     *--------------------------------------------------------------------------
943:     PROCEDURE EmpPadLostFocus(par_nKeyCode, par_nShiftAltCtrl)
944:         THIS.ValidarEmpPad()
945:     ENDPROC
946: 
947:     PROCEDURE EmpPadDblClick()
948:         THIS.AbrirLookupEmpPad()
949:     ENDPROC
950: 
951:     *--------------------------------------------------------------------------
952:     * ValidarEmpPad - Valida empresa no LostFocus; abre busca se nao encontrada
953:     *--------------------------------------------------------------------------
954:     PROTECTED PROCEDURE ValidarEmpPad()
955:         LOCAL loc_oPg2, loc_cValor, loc_nResult, loc_lEncontrou
956:         loc_oPg2       = THIS.pgf_4c_Paginas.Page2
957:         loc_lEncontrou = .F.
958: 
959:         IF !loc_oPg2.txt_4c_EmpPad.Enabled
960:             RETURN
961:         ENDIF
962: 
963:         loc_cValor = ALLTRIM(loc_oPg2.txt_4c_EmpPad.Value)
964: 
965:         IF EMPTY(loc_cValor)
966:             RETURN
967:         ENDIF
968: 
969:         TRY
970:             loc_nResult = SQLEXEC(gnConnHandle, ;
971:                 "SELECT CEmps FROM SigCdEmp WHERE CEmps = " + EscaparSQL(loc_cValor), ;
972:                 "cursor_4c_ValidaEmp")
973: 
974:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ValidaEmp") > 0
975:                 loc_lEncontrou = .T.
976:             ENDIF
977:         CATCH TO loc_oErro
978:             MsgErro(loc_oErro.Message, "FormNcf.ValidarEmpPad")
979:         ENDTRY
980: 
981:         IF USED("cursor_4c_ValidaEmp")
982:             USE IN cursor_4c_ValidaEmp
983:         ENDIF
984: 
985:         IF !loc_lEncontrou
986:             THIS.AbrirLookupEmpPad()
987:         ENDIF
988:     ENDPROC
989: 
990:     *--------------------------------------------------------------------------
991:     * AbrirLookupEmpPad - Abre FormBuscaAuxiliar para SigCdEmp
992:     *--------------------------------------------------------------------------
993:     PROCEDURE AbrirLookupEmpPad()
994:         LOCAL loc_oPg2, loc_nResult, loc_oBusca
995:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
996: 
997:         IF !loc_oPg2.txt_4c_EmpPad.Enabled
998:             RETURN
999:         ENDIF
1000: 
1001:         TRY
1002:             loc_nResult = SQLEXEC(gnConnHandle, ;
1003:                 "SELECT CEmps, Razas FROM SigCdEmp ORDER BY CEmps", ;
1004:                 "cursor_4c_BuscaEmp")
1005: 
1006:             IF loc_nResult < 0
1007:                 MsgErro("Erro ao carregar empresas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1008:             ELSE
1009:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1010: 
1011:                 IF VARTYPE(loc_oBusca) = "O"
1012:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmp"
1013:                     loc_oBusca.this_cTitulo        = "Empresas"
1014:                     loc_oBusca.mAddColuna("CEmps", "", "C" + CHR(243) + "digo")
1015:                     loc_oBusca.mAddColuna("Razas", "", "Descri" + CHR(231) + CHR(227) + "o")
1016:                     loc_oBusca.Show()
1017: 
1018:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
1019:                         SELECT cursor_4c_BuscaEmp
1020:                         loc_oPg2.txt_4c_EmpPad.Value = ALLTRIM(CEmps)
1021:                     ENDIF
1022: 
1023:                     loc_oBusca.Release()
1024:                 ENDIF
1025:             ENDIF
1026:         CATCH TO loc_oErro
1027:             MsgErro(loc_oErro.Message, "FormNcf.AbrirLookupEmpPad")
1028:         ENDTRY
1029: 
1030:         IF USED("cursor_4c_BuscaEmp")
1031:             USE IN cursor_4c_BuscaEmp
1032:         ENDIF
1033:     ENDPROC
1034: 
1035:     *--------------------------------------------------------------------------
1036:     * FormParaBO - Transfere valores do Form para o BO (Fase 5: Codigo + Descricao)
1037:     *--------------------------------------------------------------------------
1038:     PROTECTED PROCEDURE FormParaBO()
1039:         LOCAL loc_oPg2
1040:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1041: 
1042:         THIS.this_oBusinessObject.this_cCodigo    = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
1043:         THIS.this_oBusinessObject.this_cDescricao = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
1044:         THIS.this_oBusinessObject.this_nFixos     = loc_oPg2.opt_4c_OptMenu.Value
1045:         THIS.this_oBusinessObject.this_nTipos     = loc_oPg2.opt_4c_GetTipo.Value
1046:         THIS.this_oBusinessObject.this_cEmps      = ALLTRIM(loc_oPg2.txt_4c_EmpPad.Value)
1047:     ENDPROC
1048: 
1049:     *--------------------------------------------------------------------------
1050:     * BOParaForm - Transfere valores do BO para o Form (Fase 5: Codigo + Descricao)
1051:     *--------------------------------------------------------------------------
1052:     PROTECTED PROCEDURE BOParaForm()
1053:         LOCAL loc_oPg2, loc_nFixos, loc_nTipos
1054:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1055:         loc_nFixos = THIS.this_oBusinessObject.this_nFixos
1056:         loc_nTipos = THIS.this_oBusinessObject.this_nTipos
1057: 
1058:         loc_oPg2.txt_4c_Codigo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
1059:         loc_oPg2.txt_4c_Descricao.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescricao)
1060:         loc_oPg2.opt_4c_OptMenu.Value   = IIF(loc_nFixos >= 1 AND loc_nFixos <= 2, loc_nFixos, 2)
1061:         loc_oPg2.opt_4c_GetTipo.Value   = IIF(loc_nTipos >= 1 AND loc_nTipos <= 4, loc_nTipos, 1)
1062:         loc_oPg2.txt_4c_EmpPad.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
1063:     ENDPROC
1064: 
1065:     *--------------------------------------------------------------------------
1066:     * HabilitarCampos - Habilita/desabilita campos de edicao (Fase 5: Codigo + Descricao)
1067:     *--------------------------------------------------------------------------
1068:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1069:         LOCAL loc_oPg2
1070:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1071: 
1072:         *-- Codigo: editavel apenas na inclusao (getCods When: apenas INSERIR/PROCURAR)
1073:         loc_oPg2.txt_4c_Codigo.Enabled    = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
1074:         loc_oPg2.txt_4c_Descricao.Enabled = par_lHabilitar
1075:         *-- Opt_Menu/get_tipo/EmpPad: apenas INSERIR/ALTERAR (When: INSERIR/ALTERAR)
1076:         loc_oPg2.opt_4c_OptMenu.Enabled   = par_lHabilitar
1077:         loc_oPg2.opt_4c_GetTipo.Enabled   = par_lHabilitar
1078:         loc_oPg2.txt_4c_EmpPad.Enabled    = par_lHabilitar
1079:     ENDPROC
1080: 
1081:     *--------------------------------------------------------------------------
1082:     * LimparCampos - Limpa campos do formulario (Fase 5: Codigo + Descricao)
1083:     *--------------------------------------------------------------------------
1084:     PROTECTED PROCEDURE LimparCampos()
1085:         LOCAL loc_oPg2
1086:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1087: 
1088:         loc_oPg2.txt_4c_Codigo.Value    = ""
1089:         loc_oPg2.txt_4c_Descricao.Value = ""
1090:         loc_oPg2.opt_4c_OptMenu.Value   = 2
1091:         loc_oPg2.opt_4c_GetTipo.Value   = 1
1092:         loc_oPg2.txt_4c_EmpPad.Value    = ""
1093:     ENDPROC
1094: 
1095:     *--------------------------------------------------------------------------
1096:     * AjustarBotoesPorModo - Habilita/desabilita botao Confirmar por modo
1097:     * VISUALIZAR: Confirmar disabled, Cancelar enabled
1098:     * INCLUIR/ALTERAR: ambos enabled
1099:     *--------------------------------------------------------------------------
1100:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1101:         LOCAL loc_oSalva
1102:         loc_oSalva = THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva
1103: 
1104:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1105:             loc_oSalva.cmd_4c_Confirmar.Enabled = .T.
1106:         ELSE
1107:             loc_oSalva.cmd_4c_Confirmar.Enabled = .F.
1108:         ENDIF
1109: 
1110:         loc_oSalva.cmd_4c_Cancelar.Enabled = .T.
1111:     ENDPROC
1112: 
1113:     *--------------------------------------------------------------------------
1114:     * Destroy - Libera recursos
1115:     *--------------------------------------------------------------------------
1116:     PROCEDURE Destroy()
1117:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1118:             THIS.this_oBusinessObject = .NULL.
1119:         ENDIF
1120: 
1121:         IF USED("cursor_4c_Dados")
1122:             USE IN cursor_4c_Dados
1123:         ENDIF
1124: 
1125:         DODEFAULT()
1126:     ENDPROC
1127: 
1128: ENDDEFINE


### BO (C:\4c\projeto\app\classes\NcfBO.prg):
*==============================================================================
* NcfBO.prg - Business Object para Nao-Conformidades
* Tabela: SigCdNcf
* Migrado de: SIGCDNCF.SCX (frmcadastro)
*==============================================================================
DEFINE CLASS NcfBO AS BusinessBase

    *-- Propriedades (this_* -> coluna SQL)
    this_cCodigo    = ""    && cods  char(10)  PK
    this_cDescricao = ""    && descs char(60)
    this_nFixos     = 2     && fixos numeric(1,0)  1=Sim / 2=Nao (Descricao Fixa)
    this_nTipos     = 1     && tipos numeric(1,0)  1=Nao Conforme / 2=Limite Qtd / 3=Variacao Peso / 4=Reposicao S/Composicao
    this_cEmps      = ""    && emps  char(3)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdNcf"
        THIS.this_cCampoChave = "cods"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT lista de registros para o grid
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cods, descs, fixos, tipos, emps" + ;
                       " FROM SigCdNcf" + ;
                       " WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " OR emps = ' '" + ;
                       " ORDER BY cods"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar N" + CHR(227) + "o-Conformidades:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao buscar N" + CHR(227) + "o-Conformidades:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo codigo (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cods, descs, fixos, tipos, emps" + ;
                       " FROM SigCdNcf" + ;
                       " WHERE cods = " + EscaparSQL(par_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar N" + CHR(227) + "o-Conformidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao carregar N" + CHR(227) + "o-Conformidade:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(cods,  "C")
            THIS.this_cDescricao = TratarNulo(descs, "C")
            THIS.this_nFixos     = TratarNulo(fixos, "N")
            THIS.this_nTipos     = TratarNulo(tipos, "N")
            THIS.this_cEmps      = TratarNulo(emps,  "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdNcf (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdNcf (cods, descs, fixos, tipos, emps)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo) + ", " + ;
                       EscaparSQL(THIS.this_cDescricao) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFixos) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipos) + ", " + ;
                       EscaparSQL(THIS.this_cEmps) + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir N" + CHR(227) + "o-Conformidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao inserir N" + CHR(227) + "o-Conformidade:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdNcf (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdNcf SET" + ;
                       " descs = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
                       " fixos = " + FormatarNumeroSQL(THIS.this_nFixos) + "," + ;
                       " tipos = " + FormatarNumeroSQL(THIS.this_nTipos) + "," + ;
                       " emps  = " + EscaparSQL(THIS.this_cEmps) + ;
                       " WHERE cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar N" + CHR(227) + "o-Conformidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao atualizar N" + CHR(227) + "o-Conformidade:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdNcf (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdNcf" + ;
                       " WHERE cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Delete")

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir N" + CHR(227) + "o-Conformidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao excluir N" + CHR(227) + "o-Conformidade:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

