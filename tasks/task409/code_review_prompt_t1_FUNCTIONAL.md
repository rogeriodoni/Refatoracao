# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [BINDEVENT-PARAMS] Handler 'ValidarGrupoEve' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGrupoEve(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarContaEve' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarContaEve(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormEVE.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1274 linhas total):

*-- Linhas 28 a 153:
28:     this_cModoAtual      = "LISTA"
29: 
30:     *--------------------------------------------------------------------------
31:     * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
32:     *--------------------------------------------------------------------------
33:     PROCEDURE Init()
34:         LOCAL loc_lResultado
35:         loc_lResultado = .F.
36: 
37:         TRY
38:             loc_lResultado = DODEFAULT()
39:         CATCH TO loc_oErro
40:             MsgErro(loc_oErro.Message, "FormEVE.Init")
41:         ENDTRY
42: 
43:         RETURN loc_lResultado
44:     ENDPROC
45: 
46:     *--------------------------------------------------------------------------
47:     * InicializarForm - Configura estrutura completa
48:     * Chamado automaticamente pelo FormBase.Init()
49:     *--------------------------------------------------------------------------
50:     PROTECTED PROCEDURE InicializarForm()
51:         LOCAL loc_lResultado
52:         loc_lResultado = .F.
53: 
54:         TRY
55:             THIS.this_oBusinessObject = CREATEOBJECT("EVEBO")
56: 
57:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
58:                 MsgErro("Falha ao criar EVEBO", "FormEVE.InicializarForm")
59:             ELSE
60:                 THIS.ConfigurarPageFrame()
61: 
62:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
63:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
64: 
65:                 THIS.pgf_4c_Paginas.Visible   = .T.
66:                 THIS.pgf_4c_Paginas.ActivePage = 1
67:                 THIS.this_cModoAtual           = "LISTA"
68: 
69:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
70:                     THIS.CarregarLista()
71:                 ENDIF
72: 
73:                 loc_lResultado                 = .T.
74:             ENDIF
75:         CATCH TO loc_oErro
76:             MsgErro(loc_oErro.Message, "FormEVE.InicializarForm")
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
111:     * ConfigurarPaginaLista - Configura Page1: cabecalho, botoes CRUD e grid
112:     *--------------------------------------------------------------------------
113:     PROTECTED PROCEDURE ConfigurarPaginaLista()
114:         LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid
115:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
116: 
117:         *-- Container cabecalho (cntSombra: Top=1+29=30)
118:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
119:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
120:         WITH loc_oCab
121:             .Top         = 30
122:             .Left        = 0
123:             .Width       = THIS.Width
124:             .Height      = 80
125:             .BackColor   = RGB(100, 100, 100)
126:             .BorderWidth = 0
127:             .Visible     = .T.
128:         ENDWITH
129: 
130:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
131:         WITH loc_oCab.lbl_4c_Sombra
132:             .AutoSize  = .F.
133:             .Caption   = THIS.Caption
134:             .Top       = 15
135:             .Left      = 10
136:             .Width     = THIS.Width
137:             .Height    = 40
138:             .FontName  = "Tahoma"
139:             .FontSize  = 16
140:             .FontBold  = .T.
141:             .ForeColor = RGB(0, 0, 0)
142:             .BackStyle = 0
143:             .Visible   = .T.
144:         ENDWITH
145: 
146:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
147:         WITH loc_oCab.lbl_4c_Titulo
148:             .AutoSize  = .F.
149:             .Caption   = THIS.Caption
150:             .Top       = 18
151:             .Left      = 10
152:             .Width     = THIS.Width
153:             .Height    = 46

*-- Linhas 194 a 501:
194:             .WordWrap        = .T.
195:             .Visible         = .T.
196:         ENDWITH
197:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
198: 
199:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
200:         WITH loc_oBotoes.cmd_4c_Visualizar
201:             .Caption         = "Visualizar"
202:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
203:             .PicturePosition = 13
204:             .Top             = 5
205:             .Left            = 80
206:             .Width           = 75
207:             .Height          = 75
208:             .FontName        = "Comic Sans MS"
209:             .FontSize        = 8
210:             .FontBold        = .T.
211:             .FontItalic      = .T.
212:             .ForeColor       = RGB(90, 90, 90)
213:             .BackColor       = RGB(255, 255, 255)
214:             .Themes          = .F.
215:             .SpecialEffect   = 0
216:             .MousePointer    = 15
217:             .WordWrap        = .T.
218:             .Visible         = .T.
219:         ENDWITH
220:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
221: 
222:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
223:         WITH loc_oBotoes.cmd_4c_Alterar
224:             .Caption         = "Alterar"
225:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
226:             .PicturePosition = 13
227:             .Top             = 5
228:             .Left            = 155
229:             .Width           = 75
230:             .Height          = 75
231:             .FontName        = "Comic Sans MS"
232:             .FontSize        = 8
233:             .FontBold        = .T.
234:             .FontItalic      = .T.
235:             .ForeColor       = RGB(90, 90, 90)
236:             .BackColor       = RGB(255, 255, 255)
237:             .Themes          = .F.
238:             .SpecialEffect   = 0
239:             .MousePointer    = 15
240:             .WordWrap        = .T.
241:             .Visible         = .T.
242:         ENDWITH
243:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
244: 
245:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
246:         WITH loc_oBotoes.cmd_4c_Excluir
247:             .Caption         = "Excluir"
248:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
249:             .PicturePosition = 13
250:             .Top             = 5
251:             .Left            = 230
252:             .Width           = 75
253:             .Height          = 75
254:             .FontName        = "Comic Sans MS"
255:             .FontSize        = 8
256:             .FontBold        = .T.
257:             .FontItalic      = .T.
258:             .ForeColor       = RGB(90, 90, 90)
259:             .BackColor       = RGB(255, 255, 255)
260:             .Themes          = .F.
261:             .SpecialEffect   = 0
262:             .MousePointer    = 15
263:             .WordWrap        = .T.
264:             .Visible         = .T.
265:         ENDWITH
266:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
267: 
268:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
269:         WITH loc_oBotoes.cmd_4c_Buscar
270:             .Caption         = "Buscar"
271:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
272:             .PicturePosition = 13
273:             .Top             = 5
274:             .Left            = 305
275:             .Width           = 75
276:             .Height          = 75
277:             .FontName        = "Comic Sans MS"
278:             .FontSize        = 8
279:             .FontBold        = .T.
280:             .FontItalic      = .T.
281:             .ForeColor       = RGB(90, 90, 90)
282:             .BackColor       = RGB(255, 255, 255)
283:             .Themes          = .F.
284:             .SpecialEffect   = 0
285:             .MousePointer    = 15
286:             .WordWrap        = .T.
287:             .Visible         = .T.
288:         ENDWITH
289:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
290: 
291:         *-- Container Encerrar (canonico: Left=917, Width=90)
292:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
293:         loc_oSaida = loc_oPg1.cnt_4c_Saida
294:         WITH loc_oSaida
295:             .Top         = 29
296:             .Left        = 917
297:             .Width       = 90
298:             .Height      = 85
299:             .BackStyle   = 0
300:             .BorderWidth = 0
301:             .Visible     = .T.
302:         ENDWITH
303: 
304:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
305:         WITH loc_oSaida.cmd_4c_Encerrar
306:             .Caption         = "Encerrar"
307:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
308:             .PicturePosition = 13
309:             .Top             = 5
310:             .Left            = 5
311:             .Width           = 75
312:             .Height          = 75
313:             .FontName        = "Comic Sans MS"
314:             .FontSize        = 8
315:             .FontBold        = .T.
316:             .FontItalic      = .T.
317:             .ForeColor       = RGB(90, 90, 90)
318:             .BackColor       = RGB(255, 255, 255)
319:             .Themes          = .F.
320:             .SpecialEffect   = 0
321:             .MousePointer    = 15
322:             .WordWrap        = .T.
323:             .Visible         = .T.
324:         ENDWITH
325:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
326: 
327:         *-- Grid de listagem (Grade legado: Top=88+29=117, Left=26)
328:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
329:         loc_oGrid = loc_oPg1.grd_4c_Lista
330: 
331:         loc_oGrid.ColumnCount = 4
332: 
333:         WITH loc_oGrid
334:             .Top                = 117
335:             .Left               = 26
336:             .Width              = 880
337:             .Height             = 460
338:             .FontName           = "Verdana"
339:             .FontSize           = 8
340:             .ForeColor          = RGB(90, 90, 90)
341:             .BackColor          = RGB(255, 255, 255)
342:             .GridLineColor      = RGB(238, 238, 238)
343:             .HighlightBackColor = RGB(255, 255, 255)
344:             .HighlightForeColor = RGB(15, 41, 104)
345:             .HighlightStyle     = 2
346:             .DeleteMark         = .F.
347:             .RecordMark         = .F.
348:             .RowHeight          = 16
349:             .ScrollBars         = 2
350:             .GridLines          = 3
351:             .Visible            = .T.
352:             .Column1.Width      = 80
353:             .Column2.Width      = 400
354:             .Column3.Width      = 100
355:             .Column4.Width      = 100
356:         ENDWITH
357: 
358:         THIS.TornarControlesVisiveis(loc_oPg1)
359:     ENDPROC
360: 
361:     *--------------------------------------------------------------------------
362:     * ConfigurarPaginaDados - Configura Page2: botoes e todos os campos
363:     * Campos: Codigo, Nome, Evento, Grupo+DGrupo, Conta+DConta, Status
364:     *--------------------------------------------------------------------------
365:     PROTECTED PROCEDURE ConfigurarPaginaDados()
366:         LOCAL loc_oPg2, loc_oBotoes
367:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
368: 
369:         *-- Container botoes salvar/cancelar (Grupo_Salva: Left=817, Top=11+29=40)
370:         loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
371:         loc_oBotoes = loc_oPg2.cnt_4c_BotoesAcao
372:         WITH loc_oBotoes
373:             .Top         = 40
374:             .Left        = 817
375:             .Width       = 160
376:             .Height      = 85
377:             .BackStyle   = 0
378:             .BorderWidth = 0
379:             .Visible     = .T.
380:         ENDWITH
381: 
382:         loc_oBotoes.AddObject("cmd_4c_Confirmar", "CommandButton")
383:         WITH loc_oBotoes.cmd_4c_Confirmar
384:             .Caption         = "Confirmar"
385:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
386:             .PicturePosition = 13
387:             .Top             = 5
388:             .Left            = 5
389:             .Width           = 75
390:             .Height          = 75
391:             .FontName        = "Comic Sans MS"
392:             .FontSize        = 8
393:             .FontBold        = .T.
394:             .FontItalic      = .T.
395:             .ForeColor       = RGB(90, 90, 90)
396:             .BackColor       = RGB(255, 255, 255)
397:             .Themes          = .F.
398:             .SpecialEffect   = 0
399:             .MousePointer    = 15
400:             .WordWrap        = .T.
401:             .Visible         = .T.
402:         ENDWITH
403:         BINDEVENT(loc_oBotoes.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
404: 
405:         loc_oBotoes.AddObject("cmd_4c_Cancelar", "CommandButton")
406:         WITH loc_oBotoes.cmd_4c_Cancelar
407:             .Caption         = "Encerrar"
408:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
409:             .PicturePosition = 13
410:             .Top             = 5
411:             .Left            = 81
412:             .Width           = 75
413:             .Height          = 75
414:             .FontName        = "Comic Sans MS"
415:             .FontSize        = 8
416:             .FontBold        = .T.
417:             .FontItalic      = .T.
418:             .ForeColor       = RGB(90, 90, 90)
419:             .BackColor       = RGB(255, 255, 255)
420:             .Themes          = .F.
421:             .SpecialEffect   = 0
422:             .MousePointer    = 15
423:             .WordWrap        = .T.
424:             .Visible         = .T.
425:         ENDWITH
426:         BINDEVENT(loc_oBotoes.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
427: 
428:         *-- ================================================================
429:         *-- CAMPO 1: Codigo
430:         *-- Say1: Top=141+29=170, Left=319 | getCodigo: Top=136+29=165
431:         *-- ================================================================
432:         loc_oPg2.AddObject("lbl_4c_Codigo", "Label")
433:         WITH loc_oPg2.lbl_4c_Codigo
434:             .Caption   = "C" + CHR(243) + "digo :"
435:             .Top       = 170
436:             .Left      = 319
437:             .FontName  = "Tahoma"
438:             .FontSize  = 8
439:             .FontBold  = .F.
440:             .ForeColor = RGB(90, 90, 90)
441:             .BackStyle = 0
442:             .Visible   = .T.
443:         ENDWITH
444: 
445:         loc_oPg2.AddObject("txt_4c_Codigo", "TextBox")
446:         WITH loc_oPg2.txt_4c_Codigo
447:             .Value         = ""
448:             .Format        = "K!"
449:             .Top           = 165
450:             .Left          = 365
451:             .Width         = 96
452:             .Height        = 24
453:             .SpecialEffect = 1
454:             .FontName      = "Tahoma"
455:             .FontSize      = 8
456:             .BackColor     = RGB(255, 255, 255)
457:             .ForeColor     = RGB(90, 90, 90)
458:             .MaxLength     = 10
459:             .Visible       = .T.
460:         ENDWITH
461:         BINDEVENT(loc_oPg2.txt_4c_Codigo, "KeyPress", THIS, "CodigoKeyPress")
462: 
463:         *-- ================================================================
464:         *-- CAMPO 2: Nome
465:         *-- Say2: Top=167+29=196, Left=325 | getNome: Top=163+29=192
466:         *-- ================================================================
467:         loc_oPg2.AddObject("lbl_4c_Nome", "Label")
468:         WITH loc_oPg2.lbl_4c_Nome
469:             .Caption   = "Nome :"
470:             .Top       = 196
471:             .Left      = 325
472:             .FontName  = "Tahoma"
473:             .FontSize  = 8
474:             .FontBold  = .F.
475:             .ForeColor = RGB(90, 90, 90)
476:             .BackStyle = 0
477:             .Visible   = .T.
478:         ENDWITH
479: 
480:         loc_oPg2.AddObject("txt_4c_Nome", "TextBox")
481:         WITH loc_oPg2.txt_4c_Nome
482:             .Value         = ""
483:             .Format        = "K!"
484:             .Top           = 192
485:             .Left          = 365
486:             .Width         = 336
487:             .Height        = 24
488:             .SpecialEffect = 1
489:             .FontName      = "Tahoma"
490:             .FontSize      = 8
491:             .BackColor     = RGB(255, 255, 255)
492:             .ForeColor     = RGB(90, 90, 90)
493:             .MaxLength     = 100
494:             .Visible       = .T.
495:         ENDWITH
496: 
497:         *-- ================================================================
498:         *-- CAMPO 3: Descricao/Evento
499:         *-- Say3: Top=194+29=223, Left=306 | GetEvento: Top=190+29=219
500:         *-- ================================================================
501:         loc_oPg2.AddObject("lbl_4c_Descricao", "Label")

*-- Linhas 561 a 605:
561:             .ForeColor     = RGB(90, 90, 90)
562:             .Visible       = .T.
563:         ENDWITH
564:         BINDEVENT(loc_oPg2.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupoEve")
565:         BINDEVENT(loc_oPg2.txt_4c_Grupo, "KeyPress",  THIS, "GrupoKeyPress")
566: 
567:         loc_oPg2.AddObject("txt_4c_DGrupo", "TextBox")
568:         WITH loc_oPg2.txt_4c_DGrupo
569:             .Value         = ""
570:             .ReadOnly      = .T.
571:             .Top           = 246
572:             .Left          = 447
573:             .Width         = 290
574:             .Height        = 23
575:             .SpecialEffect = 1
576:             .FontName      = "Tahoma"
577:             .FontSize      = 8
578:             .BackColor     = RGB(200, 200, 200)
579:             .ForeColor     = RGB(90, 90, 90)
580:             .Visible       = .T.
581:         ENDWITH
582: 
583:         *-- ================================================================
584:         *-- CAMPO 5: Conta (codigo + descricao na mesma linha)
585:         *-- getConta: Top=243+29=272, Left=365, Width=80 (ref SigCdCli.Iclis)
586:         *-- getDConta: Left=447, Width=290, ReadOnly (exibe SigCdCli.Rclis)
587:         *-- ================================================================
588:         loc_oPg2.AddObject("lbl_4c_Conta", "Label")
589:         WITH loc_oPg2.lbl_4c_Conta
590:             .AutoSize  = .T.
591:             .Caption   = "Conta :"
592:             .Top       = 275
593:             .Left      = 323
594:             .FontName  = "Tahoma"
595:             .FontSize  = 8
596:             .FontBold  = .F.
597:             .ForeColor = RGB(90, 90, 90)
598:             .BackStyle = 0
599:             .Visible   = .T.
600:         ENDWITH
601: 
602:         loc_oPg2.AddObject("txt_4c_Conta", "TextBox")
603:         WITH loc_oPg2.txt_4c_Conta
604:             .Value         = ""
605:             .Top           = 272

*-- Linhas 614 a 658:
614:             .MaxLength     = 10
615:             .Visible       = .T.
616:         ENDWITH
617:         BINDEVENT(loc_oPg2.txt_4c_Conta, "KeyPress", THIS, "ValidarContaEve")
618:         BINDEVENT(loc_oPg2.txt_4c_Conta, "KeyPress",  THIS, "ContaKeyPress")
619: 
620:         loc_oPg2.AddObject("txt_4c_DConta", "TextBox")
621:         WITH loc_oPg2.txt_4c_DConta
622:             .Value         = ""
623:             .ReadOnly      = .T.
624:             .Top           = 272
625:             .Left          = 447
626:             .Width         = 290
627:             .Height        = 23
628:             .SpecialEffect = 1
629:             .FontName      = "Tahoma"
630:             .FontSize      = 8
631:             .BackColor     = RGB(200, 200, 200)
632:             .ForeColor     = RGB(90, 90, 90)
633:             .Visible       = .T.
634:         ENDWITH
635: 
636:         *-- ================================================================
637:         *-- CAMPO 6: Status
638:         *-- GetStatus: Top=269+29=298, Left=365, Width=184, MaxLength=50
639:         *-- ================================================================
640:         loc_oPg2.AddObject("lbl_4c_Status", "Label")
641:         WITH loc_oPg2.lbl_4c_Status
642:             .AutoSize  = .T.
643:             .Caption   = "Status :"
644:             .Top       = 302
645:             .Left      = 319
646:             .FontName  = "Tahoma"
647:             .FontSize  = 8
648:             .FontBold  = .F.
649:             .ForeColor = RGB(90, 90, 90)
650:             .BackStyle = 0
651:             .Visible   = .T.
652:         ENDWITH
653: 
654:         loc_oPg2.AddObject("txt_4c_Status", "TextBox")
655:         WITH loc_oPg2.txt_4c_Status
656:             .Value         = ""
657:             .Top           = 298
658:             .Left          = 365

*-- Linhas 667 a 1274:
667:             .Visible       = .T.
668:         ENDWITH
669: 
670:         THIS.TornarControlesVisiveis(loc_oPg2)
671:     ENDPROC
672: 
673:     *--------------------------------------------------------------------------
674:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
675:     *--------------------------------------------------------------------------
676:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
677:         LOCAL loc_nI, loc_oObjeto, loc_nP
678: 
679:         FOR loc_nI = 1 TO par_oContainer.ControlCount
680:             loc_oObjeto = par_oContainer.Controls(loc_nI)
681: 
682:             IF VARTYPE(loc_oObjeto) = "O"
683:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
684:                     loc_oObjeto.Visible = .T.
685:                 ENDIF
686: 
687:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
688:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
689:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
690:                     ENDFOR
691:                 ENDIF
692: 
693:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
694:                     THIS.TornarControlesVisiveis(loc_oObjeto)
695:                 ENDIF
696:             ENDIF
697:         ENDFOR
698:     ENDPROC
699: 
700:     *--------------------------------------------------------------------------
701:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
702:     *--------------------------------------------------------------------------
703:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
704:         LOCAL loc_lResultado
705:         loc_lResultado = .F.
706: 
707:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
708:             RETURN .F.
709:         ENDIF
710: 
711:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
712: 
713:         IF par_nPagina = 1
714:             THIS.this_cModoAtual = "LISTA"
715:             THIS.CarregarLista()
716:         ENDIF
717: 
718:         loc_lResultado = .T.
719:         RETURN loc_lResultado
720:     ENDPROC
721: 
722:     *--------------------------------------------------------------------------
723:     * CarregarLista - Carrega dados no grid da Page1 via EVEBO.Buscar
724:     *--------------------------------------------------------------------------
725:     PROCEDURE CarregarLista()
726:         LOCAL loc_lResultado, loc_oGrid
727:         loc_lResultado = .F.
728: 
729:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
730:             RETURN .T.
731:         ENDIF
732: 
733:         TRY
734:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
735: 
736:             IF THIS.this_oBusinessObject.Buscar("")
737:                 loc_oGrid.ColumnCount = 4
738:                 loc_oGrid.RecordSource            = "cursor_4c_Dados"
739:                 loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.Codigo"
740:                 loc_oGrid.Column1.Width           = 80
741:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
742:                 loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.Nome"
743:                 loc_oGrid.Column2.Width           = 400
744:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
745:                 loc_oGrid.Column3.ControlSource   = "cursor_4c_Dados.Grupo"
746:                 loc_oGrid.Column3.Width           = 100
747:                 loc_oGrid.Column3.Header1.Caption = "Grupo"
748:                 loc_oGrid.Column4.ControlSource   = "cursor_4c_Dados.Conta"
749:                 loc_oGrid.Column4.Width           = 100
750:                 loc_oGrid.Column4.Header1.Caption = "Conta"
751:                 THIS.FormatarGridLista(loc_oGrid)
752:                 loc_lResultado = .T.
753:             ENDIF
754:         CATCH TO loc_oErro
755:             MsgErro(loc_oErro.Message, "FormEVE.CarregarLista")
756:         ENDTRY
757: 
758:         RETURN loc_lResultado
759:     ENDPROC
760: 
761:     *--------------------------------------------------------------------------
762:     * FormatarGridLista - Formata visual do grid da lista
763:     *--------------------------------------------------------------------------
764:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
765:         WITH par_oGrid
766:             .FontName = "Tahoma"
767:             .FontSize = 8
768:         ENDWITH
769:     ENDPROC
770: 
771:     *--------------------------------------------------------------------------
772:     * BtnIncluirClick - Inicia inclusao de novo registro
773:     *--------------------------------------------------------------------------
774:     PROCEDURE BtnIncluirClick()
775:         THIS.this_oBusinessObject.NovoRegistro()
776:         THIS.LimparCampos()
777:         THIS.this_cModoAtual = "INCLUIR"
778:         THIS.HabilitarCampos(.T.)
779:         THIS.AjustarBotoesPorModo()
780:         THIS.pgf_4c_Paginas.ActivePage = 2
781:         THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus()
782:     ENDPROC
783: 
784:     *--------------------------------------------------------------------------
785:     * BtnVisualizarClick - Carrega registro selecionado para visualizacao
786:     *--------------------------------------------------------------------------
787:     PROCEDURE BtnVisualizarClick()
788:         LOCAL loc_cCodigo
789:         loc_cCodigo = ""
790: 
791:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
792:             MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
793:             RETURN
794:         ENDIF
795: 
796:         SELECT cursor_4c_Dados
797:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigo)
798: 
799:         IF EMPTY(loc_cCodigo)
800:             MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
801:             RETURN
802:         ENDIF
803: 
804:         TRY
805:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
806:                 THIS.this_cModoAtual = "VISUALIZAR"
807:                 THIS.BOParaForm()
808:                 THIS.HabilitarCampos(.F.)
809:                 THIS.AjustarBotoesPorModo()
810:                 THIS.pgf_4c_Paginas.ActivePage = 2
811:             ENDIF
812:         CATCH TO loc_oErro
813:             MsgErro(loc_oErro.Message, "FormEVE.BtnVisualizarClick")
814:         ENDTRY
815:     ENDPROC
816: 
817:     *--------------------------------------------------------------------------
818:     * BtnAlterarClick - Carrega registro selecionado para edicao
819:     *--------------------------------------------------------------------------
820:     PROCEDURE BtnAlterarClick()
821:         LOCAL loc_cCodigo
822:         loc_cCodigo = ""
823: 
824:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
825:             MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
826:             RETURN
827:         ENDIF
828: 
829:         SELECT cursor_4c_Dados
830:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigo)
831: 
832:         IF EMPTY(loc_cCodigo)
833:             MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
834:             RETURN
835:         ENDIF
836: 
837:         TRY
838:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
839:                 THIS.this_oBusinessObject.EditarRegistro()
840:                 THIS.this_cModoAtual = "ALTERAR"
841:                 THIS.BOParaForm()
842:                 THIS.HabilitarCampos(.T.)
843:                 THIS.AjustarBotoesPorModo()
844:                 THIS.pgf_4c_Paginas.ActivePage = 2
845:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Nome.SetFocus()
846:             ENDIF
847:         CATCH TO loc_oErro
848:             MsgErro(loc_oErro.Message, "FormEVE.BtnAlterarClick")
849:         ENDTRY
850:     ENDPROC
851: 
852:     *--------------------------------------------------------------------------
853:     * BtnExcluirClick - Exclui registro selecionado
854:     *--------------------------------------------------------------------------
855:     PROCEDURE BtnExcluirClick()
856:         LOCAL loc_cCodigo, loc_cNome
857:         loc_cCodigo = ""
858:         loc_cNome   = ""
859: 
860:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
861:             MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
862:             RETURN
863:         ENDIF
864: 
865:         SELECT cursor_4c_Dados
866:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigo)
867:         loc_cNome   = ALLTRIM(cursor_4c_Dados.Nome)
868: 
869:         IF EMPTY(loc_cCodigo)
870:             RETURN
871:         ENDIF
872: 
873:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do evento " + loc_cNome + "?", ;
874:                         "Confirmar Exclus" + CHR(227) + "o")
875:             RETURN
876:         ENDIF
877: 
878:         TRY
879:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
880:                 IF THIS.this_oBusinessObject.Excluir()
881:                     MsgInfo("Evento exclu" + CHR(237) + "do com sucesso!", "Sucesso")
882:                     THIS.CarregarLista()
883:                 ENDIF
884:             ENDIF
885:         CATCH TO loc_oErro
886:             MsgErro(loc_oErro.Message, "FormEVE.BtnExcluirClick")
887:         ENDTRY
888:     ENDPROC
889: 
890:     *--------------------------------------------------------------------------
891:     * BtnBuscarClick - Abre picker para buscar/navegar ate registro
892:     *--------------------------------------------------------------------------
893:     PROCEDURE BtnBuscarClick()
894:         LOCAL loc_oBusca, loc_cCodigo, loc_cCodigoSel
895:         loc_cCodigo    = ""
896:         loc_cCodigoSel = ""
897: 
898:         TRY
899:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
900:                 SELECT cursor_4c_Dados
901:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigo)
902:             ENDIF
903: 
904:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
905:                 "SigCdEve", "cursor_4c_BuscaEve", "Codigo", loc_cCodigo, ;
906:                 "Buscar Evento")
907: 
908:             IF VARTYPE(loc_oBusca) = "O"
909:                 IF !loc_oBusca.this_lAchouRegistro
910:                     loc_oBusca.mAddColuna("Codigo", "", "C" + CHR(243) + "digo")
911:                     loc_oBusca.mAddColuna("Nome",   "", "Descri" + CHR(231) + CHR(227) + "o")
912:                     loc_oBusca.mAddColuna("Grupo",  "", "Grupo")
913:                     loc_oBusca.mAddColuna("Conta",  "", "Conta")
914:                     loc_oBusca.Show()
915:                 ENDIF
916: 
917:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEve")
918:                     SELECT cursor_4c_BuscaEve
919:                     loc_cCodigoSel = ALLTRIM(cursor_4c_BuscaEve.Codigo)
920:                     SELECT cursor_4c_Dados
921:                     LOCATE FOR ALLTRIM(Codigo) = loc_cCodigoSel
922:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
923:                 ENDIF
924: 
925:                 loc_oBusca.Release()
926:             ENDIF
927: 
928:             IF USED("cursor_4c_BuscaEve")
929:                 USE IN cursor_4c_BuscaEve
930:             ENDIF
931:         CATCH TO loc_oErro
932:             MsgErro(loc_oErro.Message, "FormEVE.BtnBuscarClick")
933:             IF USED("cursor_4c_BuscaEve")
934:                 USE IN cursor_4c_BuscaEve
935:             ENDIF
936:         ENDTRY
937:     ENDPROC
938: 
939:     *--------------------------------------------------------------------------
940:     * BtnEncerrarClick - Fecha o formulario
941:     *--------------------------------------------------------------------------
942:     PROCEDURE BtnEncerrarClick()
943:         THIS.Release()
944:     ENDPROC
945: 
946:     *--------------------------------------------------------------------------
947:     * Destroy - Libera recursos do formulario
948:     *--------------------------------------------------------------------------
949:     PROCEDURE Destroy()
950:         TRY
951:             IF USED("cursor_4c_Dados")
952:                 USE IN cursor_4c_Dados
953:             ENDIF
954:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
955:                 THIS.this_oBusinessObject = .NULL.
956:             ENDIF
957:         CATCH TO loc_oErro
958:             MsgErro(loc_oErro.Message, "FormEVE.Destroy")
959:         ENDTRY
960: 
961:         DODEFAULT()
962:     ENDPROC
963: 
964:     *--------------------------------------------------------------------------
965:     * BtnSalvarClick - Valida campos e salva o registro
966:     *--------------------------------------------------------------------------
967:     PROCEDURE BtnSalvarClick()
968:         LOCAL loc_oPg2
969:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
970: 
971:         IF THIS.this_cModoAtual = "VISUALIZAR"
972:             MsgAviso("Modo somente leitura. Use Alterar para modificar.", "")
973:             RETURN
974:         ENDIF
975: 
976:         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Codigo.Value))
977:             MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido!", ;
978:                 "Aten" + CHR(231) + CHR(227) + "o")
979:             loc_oPg2.txt_4c_Codigo.SetFocus()
980:             RETURN
981:         ENDIF
982: 
983:         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Nome.Value))
984:             MsgAviso("Descri" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida!", ;
985:                 "Aten" + CHR(231) + CHR(227) + "o")
986:             loc_oPg2.txt_4c_Nome.SetFocus()
987:             RETURN
988:         ENDIF
989: 
990:         TRY
991:             THIS.FormParaBO()
992:             IF THIS.this_oBusinessObject.Salvar()
993:                 MsgInfo("Registro salvo com sucesso!", "Sucesso")
994:                 THIS.AlternarPagina(1)
995:             ENDIF
996:         CATCH TO loc_oErro
997:             MsgErro(loc_oErro.Message, "FormEVE.BtnSalvarClick")
998:         ENDTRY
999:     ENDPROC
1000: 
1001:     *--------------------------------------------------------------------------
1002:     * BtnCancelarClick - Cancela edicao e volta para lista
1003:     *--------------------------------------------------------------------------
1004:     PROCEDURE BtnCancelarClick()
1005:         THIS.AlternarPagina(1)
1006:     ENDPROC
1007: 
1008:     *--------------------------------------------------------------------------
1009:     * LimparCampos - Limpa valores de todos os campos de Page2
1010:     *--------------------------------------------------------------------------
1011:     PROTECTED PROCEDURE LimparCampos()
1012:         LOCAL loc_oPg2
1013:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1014: 
1015:         TRY
1016:             loc_oPg2.txt_4c_Codigo.Value  = ""
1017:             loc_oPg2.txt_4c_Nome.Value    = ""
1018:             loc_oPg2.txt_4c_Evento.Value  = ""
1019:             loc_oPg2.txt_4c_Grupo.Value   = ""
1020:             loc_oPg2.txt_4c_DGrupo.Value  = ""
1021:             loc_oPg2.txt_4c_Conta.Value   = ""
1022:             loc_oPg2.txt_4c_DConta.Value  = ""
1023:             loc_oPg2.txt_4c_Status.Value  = ""
1024:         CATCH TO loc_oErro
1025:             MsgErro(loc_oErro.Message, "FormEVE.LimparCampos")
1026:         ENDTRY
1027:     ENDPROC
1028: 
1029:     *--------------------------------------------------------------------------
1030:     * FormParaBO - Transfere todos os campos do form para o BO antes de salvar
1031:     *--------------------------------------------------------------------------
1032:     PROTECTED PROCEDURE FormParaBO()
1033:         LOCAL loc_oPg2, loc_oBO
1034:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1035:         loc_oBO  = THIS.this_oBusinessObject
1036: 
1037:         loc_oBO.this_cCodigo  = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
1038:         loc_oBO.this_cNome    = ALLTRIM(loc_oPg2.txt_4c_Nome.Value)
1039:         loc_oBO.this_cEvento  = ALLTRIM(loc_oPg2.txt_4c_Evento.Value)
1040:         loc_oBO.this_cGrupo   = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
1041:         loc_oBO.this_cConta   = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
1042:         loc_oBO.this_cStatus  = ALLTRIM(loc_oPg2.txt_4c_Status.Value)
1043:     ENDPROC
1044: 
1045:     *--------------------------------------------------------------------------
1046:     * BOParaForm - Popula todos os campos do form com dados do BO
1047:     *--------------------------------------------------------------------------
1048:     PROTECTED PROCEDURE BOParaForm()
1049:         LOCAL loc_oPg2, loc_oBO
1050:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1051:         loc_oBO  = THIS.this_oBusinessObject
1052: 
1053:         TRY
1054:             loc_oPg2.txt_4c_Codigo.Value  = ALLTRIM(loc_oBO.this_cCodigo)
1055:             loc_oPg2.txt_4c_Nome.Value    = ALLTRIM(loc_oBO.this_cNome)
1056:             loc_oPg2.txt_4c_Evento.Value  = ALLTRIM(loc_oBO.this_cEvento)
1057:             loc_oPg2.txt_4c_Grupo.Value   = ALLTRIM(loc_oBO.this_cGrupo)
1058:             loc_oPg2.txt_4c_DGrupo.Value  = loc_oBO.ObterDescricaoGrupo(ALLTRIM(loc_oBO.this_cGrupo))
1059:             loc_oPg2.txt_4c_Conta.Value   = ALLTRIM(loc_oBO.this_cConta)
1060:             loc_oPg2.txt_4c_DConta.Value  = loc_oBO.ObterDescricaoConta(ALLTRIM(loc_oBO.this_cConta))
1061:             loc_oPg2.txt_4c_Status.Value  = ALLTRIM(loc_oBO.this_cStatus)
1062:         CATCH TO loc_oErro
1063:             MsgErro(loc_oErro.Message, "FormEVE.BOParaForm")
1064:         ENDTRY
1065:     ENDPROC
1066: 
1067:     *--------------------------------------------------------------------------
1068:     * CodigoKeyPress - Bloqueia edicao do Codigo fora do modo INCLUIR
1069:     * Replica getCodigo.When: Return InList(pcEscolha, 'INSERIR', 'PROCURAR')
1070:     *--------------------------------------------------------------------------
1071:     PROCEDURE CodigoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1072:         IF THIS.this_cModoAtual = "ALTERAR" OR THIS.this_cModoAtual = "VISUALIZAR"
1073:             NODEFAULT
1074:         ENDIF
1075:     ENDPROC
1076: 
1077:     *--------------------------------------------------------------------------
1078:     * ValidarGrupoEve - LostFocus de txt_4c_Grupo: valida e popula descricao
1079:     * Replica getGrupo.Valid: fAcessoContab('C', Grupo, ...) -> popula DGrupo
1080:     *--------------------------------------------------------------------------
1081:     PROCEDURE ValidarGrupoEve(par_nKeyCode, par_nShiftAltCtrl)
1082:         LOCAL loc_oPg2, loc_cGrupo, loc_cDesc
1083:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1084:         loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
1085: 
1086:         IF EMPTY(loc_cGrupo)
1087:             loc_oPg2.txt_4c_DGrupo.Value = ""
1088:             RETURN
1089:         ENDIF
1090: 
1091:         TRY
1092:             loc_cDesc = THIS.this_oBusinessObject.ObterDescricaoGrupo(loc_cGrupo)
1093:             IF EMPTY(loc_cDesc)
1094:                 MsgAviso("Grupo n" + CHR(227) + "o encontrado!", "Aten" + CHR(231) + CHR(227) + "o")
1095:                 loc_oPg2.txt_4c_Grupo.Value  = ""
1096:                 loc_oPg2.txt_4c_DGrupo.Value = ""
1097:                 loc_oPg2.txt_4c_Grupo.SetFocus()
1098:             ELSE
1099:                 loc_oPg2.txt_4c_DGrupo.Value = loc_cDesc
1100:             ENDIF
1101:         CATCH TO loc_oErro
1102:             MsgErro(loc_oErro.Message, "FormEVE.ValidarGrupoEve")
1103:         ENDTRY
1104:     ENDPROC
1105: 
1106:     *--------------------------------------------------------------------------
1107:     * GrupoKeyPress - F4 em txt_4c_Grupo abre picker de Grupos (SigCdGcr)
1108:     *--------------------------------------------------------------------------
1109:     PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1110:         LOCAL loc_oPg2, loc_oBusca, loc_cGrupoSel
1111: 
1112:         IF par_nKeyCode != 63
1113:             RETURN
1114:         ENDIF
1115: 
1116:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1117: 
1118:         TRY
1119:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1120:                 "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", ;
1121:                 ALLTRIM(loc_oPg2.txt_4c_Grupo.Value), ;
1122:                 "Buscar Grupo")
1123: 
1124:             IF VARTYPE(loc_oBusca) = "O"
1125:                 IF !loc_oBusca.this_lAchouRegistro
1126:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1127:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1128:                     loc_oBusca.Show()
1129:                 ENDIF
1130: 
1131:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
1132:                     SELECT cursor_4c_BuscaGrupo
1133:                     loc_cGrupoSel                = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1134:                     loc_oPg2.txt_4c_Grupo.Value  = loc_cGrupoSel
1135:                     loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
1136:                 ENDIF
1137: 
1138:                 loc_oBusca.Release()
1139:             ENDIF
1140: 
1141:             IF USED("cursor_4c_BuscaGrupo")
1142:                 USE IN cursor_4c_BuscaGrupo
1143:             ENDIF
1144:         CATCH TO loc_oErro
1145:             MsgErro(loc_oErro.Message, "FormEVE.GrupoKeyPress")
1146:             IF USED("cursor_4c_BuscaGrupo")
1147:                 USE IN cursor_4c_BuscaGrupo
1148:             ENDIF
1149:         ENDTRY
1150:     ENDPROC
1151: 
1152:     *--------------------------------------------------------------------------
1153:     * ValidarContaEve - LostFocus de txt_4c_Conta: valida e popula descricao
1154:     * Replica getConta.Valid: fAcessoContas -> SQL em SigCdCli + DConta
1155:     *--------------------------------------------------------------------------
1156:     PROCEDURE ValidarContaEve(par_nKeyCode, par_nShiftAltCtrl)
1157:         LOCAL loc_oPg2, loc_cConta, loc_cDesc
1158:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1159:         loc_cConta = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
1160: 
1161:         IF EMPTY(loc_cConta)
1162:             loc_oPg2.txt_4c_DConta.Value = ""
1163:             RETURN
1164:         ENDIF
1165: 
1166:         TRY
1167:             loc_cDesc = THIS.this_oBusinessObject.ObterDescricaoConta(loc_cConta)
1168:             IF EMPTY(loc_cDesc)
1169:                 MsgAviso("Conta n" + CHR(227) + "o encontrada!", "Aten" + CHR(231) + CHR(227) + "o")
1170:                 loc_oPg2.txt_4c_Conta.Value  = ""
1171:                 loc_oPg2.txt_4c_DConta.Value = ""
1172:                 loc_oPg2.txt_4c_Conta.SetFocus()
1173:             ELSE
1174:                 loc_oPg2.txt_4c_DConta.Value = loc_cDesc
1175:             ENDIF
1176:         CATCH TO loc_oErro
1177:             MsgErro(loc_oErro.Message, "FormEVE.ValidarContaEve")
1178:         ENDTRY
1179:     ENDPROC
1180: 
1181:     *--------------------------------------------------------------------------
1182:     * ContaKeyPress - F4 em txt_4c_Conta abre picker de Contas (SigCdCli)
1183:     *--------------------------------------------------------------------------
1184:     PROCEDURE ContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1185:         LOCAL loc_oPg2, loc_oBusca, loc_cContaSel
1186: 
1187:         IF par_nKeyCode != 63
1188:             RETURN
1189:         ENDIF
1190: 
1191:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1192: 
1193:         TRY
1194:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1195:                 "SigCdCli", "cursor_4c_BuscaConta", "Iclis", ;
1196:                 ALLTRIM(loc_oPg2.txt_4c_Conta.Value), ;
1197:                 "Buscar Conta")
1198: 
1199:             IF VARTYPE(loc_oBusca) = "O"
1200:                 IF !loc_oBusca.this_lAchouRegistro
1201:                     loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1202:                     loc_oBusca.mAddColuna("Rclis", "", "Raz" + CHR(227) + "o Social")
1203:                     loc_oBusca.Show()
1204:                 ENDIF
1205: 
1206:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1207:                     SELECT cursor_4c_BuscaConta
1208:                     loc_cContaSel                = ALLTRIM(cursor_4c_BuscaConta.Iclis)
1209:                     loc_oPg2.txt_4c_Conta.Value  = loc_cContaSel
1210:                     loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.Rclis)
1211:                 ENDIF
1212: 
1213:                 loc_oBusca.Release()
1214:             ENDIF
1215: 
1216:             IF USED("cursor_4c_BuscaConta")
1217:                 USE IN cursor_4c_BuscaConta
1218:             ENDIF
1219:         CATCH TO loc_oErro
1220:             MsgErro(loc_oErro.Message, "FormEVE.ContaKeyPress")
1221:             IF USED("cursor_4c_BuscaConta")
1222:                 USE IN cursor_4c_BuscaConta
1223:             ENDIF
1224:         ENDTRY
1225:     ENDPROC
1226: 
1227:     *--------------------------------------------------------------------------
1228:     * HabilitarCampos - Habilita ou desabilita campos de edicao de Page2
1229:     * Codigo somente editavel no modo INCLUIR (replicando getCodigo.When do legado)
1230:     *--------------------------------------------------------------------------
1231:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1232:         LOCAL loc_oPg2, loc_lHabilitarCodigo
1233:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1234: 
1235:         *-- Codigo somente editavel no modo INCLUIR (legado: InList(pcEscolha,'INSERIR','PROCURAR'))
1236:         loc_lHabilitarCodigo = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
1237: 
1238:         TRY
1239:             loc_oPg2.txt_4c_Codigo.ReadOnly  = !loc_lHabilitarCodigo
1240:             loc_oPg2.txt_4c_Codigo.BackColor = IIF(loc_lHabilitarCodigo, RGB(255,255,255), RGB(200,200,200))
1241:             loc_oPg2.txt_4c_Nome.ReadOnly     = !par_lHabilitar
1242:             loc_oPg2.txt_4c_Nome.BackColor    = IIF(par_lHabilitar, RGB(255,255,255), RGB(200,200,200))
1243:             loc_oPg2.txt_4c_Evento.ReadOnly   = !par_lHabilitar
1244:             loc_oPg2.txt_4c_Evento.BackColor  = IIF(par_lHabilitar, RGB(255,255,255), RGB(200,200,200))
1245:             loc_oPg2.txt_4c_Grupo.ReadOnly    = !par_lHabilitar
1246:             loc_oPg2.txt_4c_Grupo.BackColor   = IIF(par_lHabilitar, RGB(255,255,255), RGB(200,200,200))
1247:             loc_oPg2.txt_4c_Conta.ReadOnly    = !par_lHabilitar
1248:             loc_oPg2.txt_4c_Conta.BackColor   = IIF(par_lHabilitar, RGB(255,255,255), RGB(200,200,200))
1249:             loc_oPg2.txt_4c_Status.ReadOnly   = !par_lHabilitar
1250:             loc_oPg2.txt_4c_Status.BackColor  = IIF(par_lHabilitar, RGB(255,255,255), RGB(200,200,200))
1251:             *-- DGrupo e DConta sao sempre ReadOnly (preenchidos automaticamente pelo lookup)
1252:         CATCH TO loc_oErro
1253:             MsgErro(loc_oErro.Message, "FormEVE.HabilitarCampos")
1254:         ENDTRY
1255:     ENDPROC
1256: 
1257:     *--------------------------------------------------------------------------
1258:     * AjustarBotoesPorModo - Ajusta estado dos botoes Confirmar/Cancelar de Page2
1259:     * Confirmar habilitado apenas em INCLUIR e ALTERAR
1260:     *--------------------------------------------------------------------------
1261:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1262:         LOCAL loc_oPg2, loc_lEditando
1263:         loc_oPg2      = THIS.pgf_4c_Paginas.Page2
1264:         loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1265: 
1266:         TRY
1267:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
1268:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1269:         CATCH TO loc_oErro
1270:             MsgErro(loc_oErro.Message, "FormEVE.AjustarBotoesPorModo")
1271:         ENDTRY
1272:     ENDPROC
1273: 
1274: ENDDEFINE


### BO (C:\4c\projeto\app\classes\EVEBO.prg):
*==============================================================================
* EVEBO.prg - Business Object para Eventos
* Tabela: SigCdEve
* Arquitetura: Camada de Negocio (BusinessBase)
*==============================================================================

DEFINE CLASS EVEBO AS BusinessBase

    *-- Chave primaria (gerada automaticamente no INSERT)
    this_cPkChaves   = ""   && pkChaves char(20) - PK

    *-- Campos da tabela SigCdEve
    this_cCodigo     = ""   && Codigo   char(10)
    this_cNome       = ""   && Nome     char(100)
    this_cEvento     = ""   && Evento   char(100)
    this_cStatus     = ""   && Status   char(50)
    this_cGrupo      = ""   && Grupo    char(10)  (ref SigCdGcr.Codigos)
    this_cConta      = ""   && Conta    char(10)  (ref SigCdCli.Iclis)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdEve"
            THIS.this_cCampoChave = "pkChaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "EVEBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cPkChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cPkChaves = TratarNulo(pkChaves, "C")
                THIS.this_cCodigo   = TratarNulo(Codigo,   "C")
                THIS.this_cNome     = TratarNulo(Nome,     "C")
                THIS.this_cEvento   = TratarNulo(Evento,   "C")
                THIS.this_cStatus   = TratarNulo(Status,   "C")
                THIS.this_cGrupo    = TratarNulo(Grupo,    "C")
                THIS.this_cConta    = TratarNulo(Conta,    "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "EVEBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigo)
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCodigo)
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " Cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cNome)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarCodigoExistente - Verifica se Codigo ja existe no banco
    *--------------------------------------------------------------------------
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdEve" + ;
                " WHERE Codigo = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                SELECT cursor_4c_ChkCod
                loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "EVEBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdEve
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cPkChaves = SYS(2015) + SYS(2015)

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdEve (pkChaves, Codigo, Nome, Evento, Status, Grupo, Conta)
                VALUES (
                    <<EscaparSQL(THIS.this_cPkChaves)>>,
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cNome)>>,
                    <<EscaparSQL(THIS.this_cEvento)>>,
                    <<EscaparSQL(THIS.this_cStatus)>>,
                    <<EscaparSQL(THIS.this_cGrupo)>>,
                    <<EscaparSQL(THIS.this_cConta)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir evento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "EVEBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCdEve
    * Nota: Codigo (chave de negocio) nao e alteravel pelo usuario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdEve
                SET Nome   = <<EscaparSQL(THIS.this_cNome)>>,
                    Evento = <<EscaparSQL(THIS.this_cEvento)>>,
                    Status = <<EscaparSQL(THIS.this_cStatus)>>,
                    Grupo  = <<EscaparSQL(THIS.this_cGrupo)>>,
                    Conta  = <<EscaparSQL(THIS.this_cConta)>>
                WHERE pkChaves = <<EscaparSQL(THIS.this_cPkChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar evento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "EVEBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCdEve
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdEve WHERE pkChaves = " + ;
                EscaparSQL(THIS.this_cPkChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir evento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "EVEBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com colunas do grid: Codigo, Nome, Grupo, Conta
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (pkChaves C(20), Codigo C(10), Nome C(100), Grupo C(10), Conta C(10))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT pkChaves, Codigo, Nome, Grupo, Conta FROM SigCdEve"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY Codigo"

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
                        MostrarErro("Erro ao buscar eventos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar eventos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "EVEBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo Codigo (chave de negocio)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT pkChaves, Codigo, Nome, Evento, Status, Grupo, Conta" + ;
                " FROM SigCdEve WHERE Codigo = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Evento n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar evento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "EVEBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterDescricaoGrupo - Obtem descricao do grupo em SigCdGcr
    * Chamado pelo Form em BOParaForm para popular txt_4c_DGrupo
    *--------------------------------------------------------------------------
    PROCEDURE ObterDescricaoGrupo(par_cGrupo)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao
        loc_cDescricao = ""

        IF EMPTY(par_cGrupo)
            RETURN loc_cDescricao
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 Descrs FROM SigCdGcr WHERE Codigos = " + ;
                EscaparSQL(par_cGrupo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoDesc")
            IF loc_nResultado >= 0 AND USED("cursor_4c_GrupoDesc")
                SELECT cursor_4c_GrupoDesc
                IF !EOF()
                    loc_cDescricao = TratarNulo(Descrs, "C")
                ENDIF
                USE IN cursor_4c_GrupoDesc
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao obter descri" + CHR(231) + CHR(227) + "o do grupo:" + CHR(13) + loException.Message, "EVEBO.ObterDescricaoGrupo")
        ENDTRY

        RETURN loc_cDescricao
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterDescricaoConta - Obtem descricao da conta em SigCdCli
    * Chamado pelo Form em BOParaForm para popular txt_4c_DConta
    *--------------------------------------------------------------------------
    PROCEDURE ObterDescricaoConta(par_cConta)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao
        loc_cDescricao = ""

        IF EMPTY(par_cConta)
            RETURN loc_cDescricao
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 Rclis FROM SigCdCli WHERE Iclis = " + ;
                EscaparSQL(par_cConta)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaDesc")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ContaDesc")
                SELECT cursor_4c_ContaDesc
                IF !EOF()
                    loc_cDescricao = TratarNulo(Rclis, "C")
                ENDIF
                USE IN cursor_4c_ContaDesc
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao obter descri" + CHR(231) + CHR(227) + "o da conta:" + CHR(13) + loException.Message, "EVEBO.ObterDescricaoConta")
        ENDTRY

        RETURN loc_cDescricao
    ENDPROC

ENDDEFINE

