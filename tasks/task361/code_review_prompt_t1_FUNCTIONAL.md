# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (5)
- [BINDEVENT-PARAMS] Handler 'ValidarGrupo' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGrupo(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarConta' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarConta(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarEmps' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarEmps(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDEmps' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDEmps(par_nKeyCode, par_nShiftAltCtrl)
- [GRID-WITH] Bloco WITH ENDWITH define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDWITH.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCeg.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1570 linhas total):

*-- Linhas 30 a 156:
30:     this_cCidchavesAtual = ""
31: 
32:     *--------------------------------------------------------------------------
33:     * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
34:     *--------------------------------------------------------------------------
35:     PROCEDURE Init()
36:         LOCAL loc_lResultado
37:         loc_lResultado = .F.
38: 
39:         TRY
40:             loc_lResultado = DODEFAULT()
41:         CATCH TO loc_oErro
42:             MsgErro(loc_oErro.Message, "FormCeg.Init")
43:         ENDTRY
44: 
45:         RETURN loc_lResultado
46:     ENDPROC
47: 
48:     *--------------------------------------------------------------------------
49:     * InicializarForm - Configura estrutura completa
50:     * Chamado automaticamente pelo FormBase.Init()
51:     *--------------------------------------------------------------------------
52:     PROTECTED PROCEDURE InicializarForm()
53:         LOCAL loc_lResultado
54:         loc_lResultado = .F.
55: 
56:         TRY
57:             THIS.this_oBusinessObject = CREATEOBJECT("CegBO")
58: 
59:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
60:                 MsgErro("Falha ao criar CegBO", "Erro")
61:             ELSE
62:                 THIS.ConfigurarPageFrame()
63: 
64:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
65:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
66:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
67:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
68: 
69:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
70:                     THIS.CarregarLista()
71:                 ENDIF
72: 
73:                 THIS.pgf_4c_Paginas.Visible   = .T.
74:                 THIS.pgf_4c_Paginas.ActivePage = 1
75:                 THIS.this_cModoAtual = "LISTA"
76:                 loc_lResultado = .T.
77:             ENDIF
78:         CATCH TO loc_oErro
79:             MsgErro(loc_oErro.Message, "FormCeg.InicializarForm")
80:         ENDTRY
81: 
82:         RETURN loc_lResultado
83:     ENDPROC
84: 
85:     *--------------------------------------------------------------------------
86:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
87:     *--------------------------------------------------------------------------
88:     PROTECTED PROCEDURE ConfigurarPageFrame()
89:         LOCAL loc_oPgf
90:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
91:         loc_oPgf = THIS.pgf_4c_Paginas
92: 
93:         WITH loc_oPgf
94:             .PageCount       = 2
95:             .Top             = -29
96:             .Left            = 0
97:             .Width           = THIS.Width
98:             .Height          = THIS.Height + 29
99:             .Tabs            = .F.
100:             .Visible         = .T.
101:             .Page1.Caption   = "Lista"
102:             .Page1.BackColor = RGB(100, 100, 100)
103:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:             .Page2.Caption   = "Dados"
105:             .Page2.BackColor = RGB(100, 100, 100)
106:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
107:         ENDWITH
108: 
109:         THIS.ConfigurarPaginaLista()
110:         THIS.ConfigurarPaginaDados()
111:     ENDPROC
112: 
113:     *--------------------------------------------------------------------------
114:     * ConfigurarPaginaLista - Configura Page1: cabecalho + botoes + grid
115:     *--------------------------------------------------------------------------
116:     PROTECTED PROCEDURE ConfigurarPaginaLista()
117:         LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid
118: 
119:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
120: 
121:         *-- Container cabecalho cinza (Top = 2 + 29 = 31)
122:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
123:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
124:         WITH loc_oCab
125:             .Top         = 31
126:             .Left        = 0
127:             .Width       = THIS.Width
128:             .Height      = 80
129:             .BackColor   = RGB(100, 100, 100)
130:             .BorderWidth = 0
131:             .Visible     = .T.
132:         ENDWITH
133: 
134:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
135:         WITH loc_oCab.lbl_4c_Sombra
136:             .AutoSize  = .F.
137:             .Caption   = THIS.Caption
138:             .Top       = 15
139:             .Left      = 10
140:             .Width     = THIS.Width
141:             .Height    = 40
142:             .FontName  = "Tahoma"
143:             .FontSize  = 16
144:             .FontBold  = .T.
145:             .ForeColor = RGB(0, 0, 0)
146:             .BackStyle = 0
147:             .Visible   = .T.
148:         ENDWITH
149: 
150:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
151:         WITH loc_oCab.lbl_4c_Titulo
152:             .AutoSize  = .F.
153:             .Caption   = THIS.Caption
154:             .Top       = 18
155:             .Left      = 10
156:             .Width     = THIS.Width

*-- Linhas 200 a 426:
200:             .AutoSize        = .F.
201:             .Visible         = .T.
202:         ENDWITH
203:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
204: 
205:         *-- Botao Visualizar
206:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
207:         WITH loc_oBotoes.cmd_4c_Visualizar
208:             .Caption         = "Visualizar"
209:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
210:             .PicturePosition = 13
211:             .Top             = 5
212:             .Left            = 80
213:             .Width           = 75
214:             .Height          = 75
215:             .BackColor       = RGB(255, 255, 255)
216:             .ForeColor       = RGB(90, 90, 90)
217:             .FontName        = "Comic Sans MS"
218:             .FontSize        = 8
219:             .FontBold        = .T.
220:             .FontItalic      = .T.
221:             .Themes          = .F.
222:             .SpecialEffect   = 0
223:             .MousePointer    = 15
224:             .WordWrap        = .T.
225:             .AutoSize        = .F.
226:             .Visible         = .T.
227:         ENDWITH
228:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
229: 
230:         *-- Botao Alterar
231:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
232:         WITH loc_oBotoes.cmd_4c_Alterar
233:             .Caption         = "Alterar"
234:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
235:             .PicturePosition = 13
236:             .Top             = 5
237:             .Left            = 155
238:             .Width           = 75
239:             .Height          = 75
240:             .BackColor       = RGB(255, 255, 255)
241:             .ForeColor       = RGB(90, 90, 90)
242:             .FontName        = "Comic Sans MS"
243:             .FontSize        = 8
244:             .FontBold        = .T.
245:             .FontItalic      = .T.
246:             .Themes          = .F.
247:             .SpecialEffect   = 0
248:             .MousePointer    = 15
249:             .WordWrap        = .T.
250:             .AutoSize        = .F.
251:             .Visible         = .T.
252:         ENDWITH
253:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
254: 
255:         *-- Botao Excluir
256:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
257:         WITH loc_oBotoes.cmd_4c_Excluir
258:             .Caption         = "Excluir"
259:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
260:             .PicturePosition = 13
261:             .Top             = 5
262:             .Left            = 230
263:             .Width           = 75
264:             .Height          = 75
265:             .BackColor       = RGB(255, 255, 255)
266:             .ForeColor       = RGB(90, 90, 90)
267:             .FontName        = "Comic Sans MS"
268:             .FontSize        = 8
269:             .FontBold        = .T.
270:             .FontItalic      = .T.
271:             .Themes          = .F.
272:             .SpecialEffect   = 0
273:             .MousePointer    = 15
274:             .WordWrap        = .T.
275:             .AutoSize        = .F.
276:             .Visible         = .T.
277:         ENDWITH
278:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
279: 
280:         *-- Botao Buscar
281:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
282:         WITH loc_oBotoes.cmd_4c_Buscar
283:             .Caption         = "Buscar"
284:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
285:             .PicturePosition = 13
286:             .Top             = 5
287:             .Left            = 305
288:             .Width           = 75
289:             .Height          = 75
290:             .BackColor       = RGB(255, 255, 255)
291:             .ForeColor       = RGB(90, 90, 90)
292:             .FontName        = "Comic Sans MS"
293:             .FontSize        = 8
294:             .FontBold        = .T.
295:             .FontItalic      = .T.
296:             .Themes          = .F.
297:             .SpecialEffect   = 0
298:             .MousePointer    = 15
299:             .WordWrap        = .T.
300:             .AutoSize        = .F.
301:             .Visible         = .T.
302:         ENDWITH
303:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
304: 
305:         *-- Container Saida - canonico: Top=29 (0+29), Left=917, Width=90, Height=85
306:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
307:         loc_oSaida = loc_oPg1.cnt_4c_Saida
308:         WITH loc_oSaida
309:             .Top         = 29
310:             .Left        = 917
311:             .Width       = 90
312:             .Height      = 85
313:             .BackStyle   = 0
314:             .BorderWidth = 0
315:             .Visible     = .T.
316:         ENDWITH
317: 
318:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
319:         WITH loc_oSaida.cmd_4c_Encerrar
320:             .Caption         = "Encerrar"
321:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
322:             .PicturePosition = 13
323:             .Top             = 5
324:             .Left            = 5
325:             .Width           = 75
326:             .Height          = 75
327:             .BackColor       = RGB(255, 255, 255)
328:             .ForeColor       = RGB(90, 90, 90)
329:             .FontName        = "Comic Sans MS"
330:             .FontSize        = 8
331:             .FontBold        = .T.
332:             .FontItalic      = .T.
333:             .Themes          = .F.
334:             .SpecialEffect   = 0
335:             .MousePointer    = 15
336:             .WordWrap        = .T.
337:             .AutoSize        = .F.
338:             .Visible         = .T.
339:         ENDWITH
340:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
341: 
342:         *-- Grid de lista - Top=117 (88+29), Left=26, Width=890, Height=498
343:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
344:         loc_oGrid = loc_oPg1.grd_4c_Lista
345:         loc_oGrid.ColumnCount = 5
346:         WITH loc_oGrid
347:             .Top                = 117
348:             .Left               = 26
349:             .Width              = 890
350:             .Height             = 498
351:             .FontName           = "Verdana"
352:             .FontSize           = 8
353:             .ForeColor          = RGB(90, 90, 90)
354:             .BackColor          = RGB(255, 255, 255)
355:             .GridLineColor      = RGB(238, 238, 238)
356:             .HighlightBackColor = RGB(255, 255, 255)
357:             .HighlightForeColor = RGB(15, 41, 104)
358:             .HighlightStyle     = 2
359:             .DeleteMark         = .F.
360:             .RecordMark         = .F.
361:             .RowHeight          = 16
362:             .ScrollBars         = 2
363:             .GridLines          = 3
364:             .Visible            = .T.
365:             .Column1.Width      = 70
366:             .Column2.Width      = 120
367:             .Column3.Width      = 120
368:             .Column4.Width      = 60
369:             .Column5.Width      = 490
370:             .Column1.Header1.Caption = "Prioridade"
371:             .Column2.Header1.Caption = "Grupo"
372:             .Column3.Header1.Caption = "Conta"
373:             .Column4.Header1.Caption = "Empresa"
374:             .Column5.Header1.Caption = "Nome Empresa"
375:             .Column1.Alignment  = 2
376:             .Column4.Alignment  = 2
377:         ENDWITH
378: 
379:         THIS.TornarControlesVisiveis(loc_oPg1)
380:     ENDPROC
381: 
382:     *--------------------------------------------------------------------------
383:     * ConfigurarPaginaDados - Configura Page2: cabecalho + botoes acao
384:     * Campos de dados (txt_4c_*) adicionados na Fase 5
385:     *--------------------------------------------------------------------------
386:     PROTECTED PROCEDURE ConfigurarPaginaDados()
387:         LOCAL loc_oPg2, loc_oCab, loc_oBotoesAcao
388: 
389:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
390: 
391:         *-- Container cabecalho cinza (Top = 2 + 29 = 31)
392:         loc_oPg2.AddObject("cnt_4c_Cabecalho", "Container")
393:         loc_oCab = loc_oPg2.cnt_4c_Cabecalho
394:         WITH loc_oCab
395:             .Top         = 31
396:             .Left        = 0
397:             .Width       = THIS.Width
398:             .Height      = 80
399:             .BackColor   = RGB(100, 100, 100)
400:             .BorderWidth = 0
401:             .Visible     = .T.
402:         ENDWITH
403: 
404:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
405:         WITH loc_oCab.lbl_4c_Sombra
406:             .AutoSize  = .F.
407:             .Caption   = THIS.Caption
408:             .Top       = 15
409:             .Left      = 10
410:             .Width     = THIS.Width
411:             .Height    = 40
412:             .FontName  = "Tahoma"
413:             .FontSize  = 16
414:             .FontBold  = .T.
415:             .ForeColor = RGB(0, 0, 0)
416:             .BackStyle = 0
417:             .Visible   = .T.
418:         ENDWITH
419: 
420:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
421:         WITH loc_oCab.lbl_4c_Titulo
422:             .AutoSize  = .F.
423:             .Caption   = THIS.Caption
424:             .Top       = 18
425:             .Left      = 10
426:             .Width     = THIS.Width

*-- Linhas 469 a 607:
469:             .AutoSize        = .F.
470:             .Visible         = .T.
471:         ENDWITH
472:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
473: 
474:         *-- Botao Cancelar
475:         loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
476:         WITH loc_oBotoesAcao.cmd_4c_Cancelar
477:             .Caption         = "Encerrar"
478:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
479:             .PicturePosition = 13
480:             .Top             = 5
481:             .Left            = 80
482:             .Width           = 75
483:             .Height          = 75
484:             .BackColor       = RGB(255, 255, 255)
485:             .ForeColor       = RGB(90, 90, 90)
486:             .FontName        = "Comic Sans MS"
487:             .FontSize        = 8
488:             .FontBold        = .T.
489:             .FontItalic      = .T.
490:             .Themes          = .F.
491:             .SpecialEffect   = 0
492:             .MousePointer    = 15
493:             .WordWrap        = .T.
494:             .AutoSize        = .F.
495:             .Visible         = .T.
496:         ENDWITH
497:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
498: 
499:         *-- Label e TextBox: Grupo (Say1 / Get_Grupo no legado - Top=192+29=221)
500:         loc_oPg2.AddObject("lbl_4c_Grupo", "Label")
501:         WITH loc_oPg2.lbl_4c_Grupo
502:             .AutoSize  = .F.
503:             .Caption   = "Grupo :"
504:             .Top       = 221
505:             .Left      = 139
506:             .Width     = 44
507:             .Height    = 17
508:             .FontName  = "Tahoma"
509:             .FontSize  = 8
510:             .FontBold  = .F.
511:             .ForeColor = RGB(90, 90, 90)
512:             .BackStyle = 0
513:             .Alignment = 1
514:             .Visible   = .T.
515:         ENDWITH
516: 
517:         loc_oPg2.AddObject("txt_4c_Grupo", "TextBox")
518:         WITH loc_oPg2.txt_4c_Grupo
519:             .Value     = ""
520:             .Top       = 219
521:             .Left      = 183
522:             .Width     = 80
523:             .Height    = 23
524:             .FontName  = "Tahoma"
525:             .FontSize  = 8
526:             .ForeColor = RGB(0, 0, 0)
527:             .MaxLength = 15
528:             .Enabled   = .T.
529:             .Visible   = .T.
530:         ENDWITH
531:         BINDEVENT(loc_oPg2.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupo")
532:         BINDEVENT(loc_oPg2.txt_4c_Grupo, "KeyPress",  THIS, "TeclaGrupo")
533: 
534:         *-- Label e TextBox: Conta (Say3 / get_Conta no legado - Top=224+29=253)
535:         loc_oPg2.AddObject("lbl_4c_Conta", "Label")
536:         WITH loc_oPg2.lbl_4c_Conta
537:             .AutoSize  = .F.
538:             .Caption   = "Conta :"
539:             .Top       = 253
540:             .Left      = 139
541:             .Width     = 44
542:             .Height    = 17
543:             .FontName  = "Tahoma"
544:             .FontSize  = 8
545:             .FontBold  = .F.
546:             .ForeColor = RGB(90, 90, 90)
547:             .BackStyle = 0
548:             .Alignment = 1
549:             .Visible   = .T.
550:         ENDWITH
551: 
552:         loc_oPg2.AddObject("txt_4c_Conta", "TextBox")
553:         WITH loc_oPg2.txt_4c_Conta
554:             .Value     = ""
555:             .Top       = 250
556:             .Left      = 183
557:             .Width     = 80
558:             .Height    = 23
559:             .FontName  = "Tahoma"
560:             .FontSize  = 8
561:             .ForeColor = RGB(0, 0, 0)
562:             .MaxLength = 15
563:             .Enabled   = .T.
564:             .Visible   = .T.
565:         ENDWITH
566:         BINDEVENT(loc_oPg2.txt_4c_Conta, "KeyPress", THIS, "ValidarConta")
567:         BINDEVENT(loc_oPg2.txt_4c_Conta, "KeyPress",  THIS, "TeclaConta")
568: 
569:         *-- Label e TextBox: Prioridade (Say2 / Get_codigo no legado - Top=252+29=281)
570:         loc_oPg2.AddObject("lbl_4c_Priors", "Label")
571:         WITH loc_oPg2.lbl_4c_Priors
572:             .AutoSize  = .F.
573:             .Caption   = "Prioridade :"
574:             .Top       = 281
575:             .Left      = 120
576:             .Width     = 63
577:             .Height    = 17
578:             .FontName  = "Tahoma"
579:             .FontSize  = 8
580:             .FontBold  = .F.
581:             .ForeColor = RGB(90, 90, 90)
582:             .BackStyle = 0
583:             .Alignment = 1
584:             .Visible   = .T.
585:         ENDWITH
586: 
587:         loc_oPg2.AddObject("txt_4c_Priors", "TextBox")
588:         WITH loc_oPg2.txt_4c_Priors
589:             .Value     = 0
590:             .Top       = 279
591:             .Left      = 183
592:             .Width     = 24
593:             .Height    = 23
594:             .FontName  = "Tahoma"
595:             .FontSize  = 8
596:             .ForeColor = RGB(0, 0, 0)
597:             .InputMask = "99"
598:             .MaxLength = 2
599:             .Enabled   = .T.
600:             .Visible   = .T.
601:         ENDWITH
602: 
603:         *-- Label e TextBox: Empresa (Say22/Get_Emps no legado - Top=281+29=310 / 277+29=306)
604:         loc_oPg2.AddObject("lbl_4c_Empresa", "Label")
605:         WITH loc_oPg2.lbl_4c_Empresa
606:             .AutoSize  = .F.
607:             .Caption   = "Empresa :"

*-- Linhas 634 a 719:
634:             .Enabled           = .T.
635:             .Visible           = .T.
636:         ENDWITH
637:         BINDEVENT(loc_oPg2.txt_4c_Emps, "KeyPress", THIS, "ValidarEmps")
638:         BINDEVENT(loc_oPg2.txt_4c_Emps, "KeyPress",  THIS, "TeclaEmps")
639: 
640:         *-- TextBox: Nome da empresa (Get_DEmps no legado - Top=277+29=306, Left=215)
641:         *-- Editavel em INCLUIR/ALTERAR quando Emps estiver vazio (busca por nome)
642:         loc_oPg2.AddObject("txt_4c_DEmps", "TextBox")
643:         WITH loc_oPg2.txt_4c_DEmps
644:             .Value     = ""
645:             .Top       = 306
646:             .Left      = 215
647:             .Width     = 290
648:             .Height    = 23
649:             .FontName  = "Tahoma"
650:             .FontSize  = 8
651:             .ForeColor = RGB(0, 0, 0)
652:             .MaxLength = 40
653:             .Enabled   = .T.
654:             .Visible   = .T.
655:         ENDWITH
656:         BINDEVENT(loc_oPg2.txt_4c_DEmps, "KeyPress", THIS, "ValidarDEmps")
657:         BINDEVENT(loc_oPg2.txt_4c_DEmps, "KeyPress",  THIS, "TeclaDEmps")
658: 
659:         *-- Label: Tipo (Say4 no legado - Top=309+29=338)
660:         loc_oPg2.AddObject("lbl_4c_TpCad", "Label")
661:         WITH loc_oPg2.lbl_4c_TpCad
662:             .AutoSize  = .F.
663:             .Caption   = "Tipo :"
664:             .Top       = 338
665:             .Left      = 148
666:             .Width     = 35
667:             .Height    = 17
668:             .FontName  = "Tahoma"
669:             .FontSize  = 8
670:             .FontBold  = .F.
671:             .ForeColor = RGB(90, 90, 90)
672:             .BackStyle = 0
673:             .Alignment = 1
674:             .Visible   = .T.
675:         ENDWITH
676: 
677:         *-- OptionGroup: Tipo de cadastro (Opc_TpCad no legado - Top=305+29=334)
678:         *-- Value=2 default (Globalizacao selecionado)
679:         loc_oPg2.AddObject("opt_4c_TpCad", "OptionGroup")
680:         WITH loc_oPg2.opt_4c_TpCad
681:             .ButtonCount = 3
682:             .AutoSize    = .F.
683:             .BackStyle   = 0
684:             .BorderStyle = 0
685:             .Value       = 2
686:             .Top         = 334
687:             .Left        = 177
688:             .Width       = 322
689:             .Height      = 28
690:             .Visible     = .T.
691:             WITH .Buttons(1)
692:                 .Caption   = "\<Pedido Autom" + CHR(225) + "tico"
693:                 .Left      = 5
694:                 .Top       = 5
695:                 .Height    = 15
696:                 .AutoSize  = .T.
697:                 .BackStyle = 0
698:                 .ForeColor = RGB(90, 90, 90)
699:                 .Themes    = .F.
700:             ENDWITH
701:             WITH .Buttons(2)
702:                 .Caption   = "\<Globaliza" + CHR(231) + CHR(227) + "o"
703:                 .Left      = 134
704:                 .Top       = 5
705:                 .Height    = 15
706:                 .AutoSize  = .T.
707:                 .FontName  = "Tahoma"
708:                 .FontSize  = 8
709:                 .BackStyle = 0
710:                 .ForeColor = RGB(90, 90, 90)
711:                 .Themes    = .F.
712:             ENDWITH
713:             WITH .Buttons(3)
714:                 .Caption   = "Distribui" + CHR(231) + CHR(227) + "o"
715:                 .Left      = 233
716:                 .Top       = 5
717:                 .Height    = 15
718:                 .Width     = 73
719:                 .AutoSize  = .T.

*-- Linhas 725 a 1109:
725:             ENDWITH
726:         ENDWITH
727: 
728:         THIS.TornarControlesVisiveis(loc_oPg2)
729:     ENDPROC
730: 
731:     *--------------------------------------------------------------------------
732:     * CarregarLista - Carrega dados no grid de Page1
733:     *--------------------------------------------------------------------------
734:     PROCEDURE CarregarLista()
735:         LOCAL loc_lResultado, loc_oGrid
736:         loc_lResultado = .F.
737: 
738:         TRY
739:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
740:                 loc_lResultado = .T.
741:             ELSE
742:                 IF VARTYPE(THIS.this_oBusinessObject) != "O"
743:                 MsgErro("Business Object n" + CHR(227) + "o inicializado", "FormCeg.CarregarLista")
744:             ELSE
745:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
746:                 *-- Desconectar RecordSource antes do SQLEXEC para preservar colunas do grid
747:                 loc_oGrid.RecordSource = ""
748:                 IF THIS.this_oBusinessObject.Buscar("")
749:                     loc_oGrid.ColumnCount = 5
750:                     loc_oGrid.RecordSource         = "cursor_4c_Dados"
751:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.priors"
752:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.grupos"
753:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.contas"
754:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.emps"
755:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Razas"
756:                     *-- Redefinir cabecalhos apos RecordSource (VFP reseta headers)
757:                     loc_oGrid.Column1.Header1.Caption = "Prioridade"
758:                     loc_oGrid.Column2.Header1.Caption = "Grupo"
759:                     loc_oGrid.Column3.Header1.Caption = "Conta"
760:                     loc_oGrid.Column4.Header1.Caption = "Empresa"
761:                     loc_oGrid.Column5.Header1.Caption = "Nome Empresa"
762:                     THIS.FormatarGridLista(loc_oGrid)
763:                     loc_lResultado = .T.
764:                 ENDIF
765:                 ENDIF
766:             ENDIF
767:         CATCH TO loc_oErro
768:             MsgErro(loc_oErro.Message, "FormCeg.CarregarLista")
769:         ENDTRY
770: 
771:         RETURN loc_lResultado
772:     ENDPROC
773: 
774:     *--------------------------------------------------------------------------
775:     * AlternarPagina - Navega entre Page1 (lista) e Page2 (dados)
776:     *--------------------------------------------------------------------------
777:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
778:         LOCAL loc_lResultado
779:         loc_lResultado = .F.
780: 
781:         TRY
782:             IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
783:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
784:                 IF par_nPagina = 1
785:                     THIS.this_cModoAtual = "LISTA"
786:                     THIS.CarregarLista()
787:                 ENDIF
788:                 loc_lResultado = .T.
789:             ENDIF
790:         CATCH TO loc_oErro
791:             MsgErro(loc_oErro.Message, "FormCeg.AlternarPagina")
792:         ENDTRY
793: 
794:         RETURN loc_lResultado
795:     ENDPROC
796: 
797:     *--------------------------------------------------------------------------
798:     * BtnIncluirClick - Prepara novo registro e navega para Page2
799:     *--------------------------------------------------------------------------
800:     PROCEDURE BtnIncluirClick()
801:         LOCAL loc_lResultado
802:         loc_lResultado = .F.
803: 
804:         TRY
805:             THIS.this_oBusinessObject.NovoRegistro()
806:             THIS.this_cCidchavesAtual = ""
807:             THIS.this_cModoAtual      = "INCLUIR"
808:             THIS.LimparCampos()
809:             THIS.HabilitarCampos(.T.)
810:             THIS.AlternarPagina(2)
811:             loc_lResultado = .T.
812:         CATCH TO loc_oErro
813:             MsgErro(loc_oErro.Message, "FormCeg.BtnIncluirClick")
814:         ENDTRY
815: 
816:         RETURN loc_lResultado
817:     ENDPROC
818: 
819:     *--------------------------------------------------------------------------
820:     * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
821:     *--------------------------------------------------------------------------
822:     PROCEDURE BtnVisualizarClick()
823:         LOCAL loc_lResultado, loc_cCidchaves
824:         loc_lResultado = .F.
825: 
826:         TRY
827:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
828:                 MsgAviso("Nenhum registro selecionado para visualizar.", "Aviso")
829:             ELSE
830:                 SELECT cursor_4c_Dados
831:                 loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
832:                 IF EMPTY(loc_cCidchaves)
833:                     MsgAviso("Nenhum registro selecionado para visualizar.", "Aviso")
834:                 ELSE
835:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
836:                     THIS.this_cCidchavesAtual = loc_cCidchaves
837:                     THIS.this_cModoAtual      = "VISUALIZAR"
838:                     THIS.BOParaForm()
839:                     THIS.HabilitarCampos(.F.)
840:                     THIS.AlternarPagina(2)
841:                     loc_lResultado = .T.
842:                     ENDIF
843:                 ENDIF
844:             ENDIF
845:         CATCH TO loc_oErro
846:             MsgErro(loc_oErro.Message, "FormCeg.BtnVisualizarClick")
847:         ENDTRY
848: 
849:         RETURN loc_lResultado
850:     ENDPROC
851: 
852:     *--------------------------------------------------------------------------
853:     * BtnAlterarClick - Carrega registro selecionado para edicao
854:     *--------------------------------------------------------------------------
855:     PROCEDURE BtnAlterarClick()
856:         LOCAL loc_lResultado, loc_cCidchaves
857:         loc_lResultado = .F.
858: 
859:         TRY
860:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
861:                 MsgAviso("Nenhum registro selecionado para alterar.", "Aviso")
862:             ELSE
863:                 SELECT cursor_4c_Dados
864:                 loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
865:                 IF EMPTY(loc_cCidchaves)
866:                     MsgAviso("Nenhum registro selecionado para alterar.", "Aviso")
867:                 ELSE
868:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
869:                     THIS.this_oBusinessObject.EditarRegistro()
870:                     THIS.this_cCidchavesAtual = loc_cCidchaves
871:                     THIS.this_cModoAtual      = "ALTERAR"
872:                     THIS.BOParaForm()
873:                     THIS.HabilitarCampos(.T.)
874:                     THIS.AlternarPagina(2)
875:                     loc_lResultado = .T.
876:                     ENDIF
877:                 ENDIF
878:             ENDIF
879:         CATCH TO loc_oErro
880:             MsgErro(loc_oErro.Message, "FormCeg.BtnAlterarClick")
881:         ENDTRY
882: 
883:         RETURN loc_lResultado
884:     ENDPROC
885: 
886:     *--------------------------------------------------------------------------
887:     * BtnExcluirClick - Confirma e exclui registro selecionado
888:     *--------------------------------------------------------------------------
889:     PROCEDURE BtnExcluirClick()
890:         LOCAL loc_lResultado, loc_cCidchaves, loc_lConfirma
891:         loc_lResultado = .F.
892: 
893:         TRY
894:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
895:                 MsgAviso("Nenhum registro selecionado para excluir.", "Aviso")
896:             ELSE
897:                 SELECT cursor_4c_Dados
898:                 loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
899:                 IF EMPTY(loc_cCidchaves)
900:                     MsgAviso("Nenhum registro selecionado para excluir.", "Aviso")
901:                 ELSE
902:                     loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro selecionado?", ;
903:                                                 "Confirmar Exclus" + CHR(227) + "o")
904:                     IF loc_lConfirma
905:                         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
906:                             IF THIS.this_oBusinessObject.Excluir()
907:                                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
908:                                 THIS.CarregarLista()
909:                                 loc_lResultado = .T.
910:                             ENDIF
911:                         ENDIF
912:                     ENDIF
913:                 ENDIF
914:             ENDIF
915:         CATCH TO loc_oErro
916:             MsgErro(loc_oErro.Message, "FormCeg.BtnExcluirClick")
917:         ENDTRY
918: 
919:         RETURN loc_lResultado
920:     ENDPROC
921: 
922:     *--------------------------------------------------------------------------
923:     * BtnBuscarClick - Filtra lista por grupo
924:     *--------------------------------------------------------------------------
925:     PROCEDURE BtnBuscarClick()
926:         LOCAL loc_lResultado, loc_cFiltro, loc_oGrid
927:         loc_lResultado = .F.
928: 
929:         TRY
930:             loc_cFiltro = INPUTBOX("Filtrar por Grupo (vazio = todos):", ;
931:                                    "Buscar Prioridades", "")
932:             IF TYPE("loc_cFiltro") = "C"
933:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
934:                 *-- Desconectar RecordSource antes do SQLEXEC
935:                 loc_oGrid.RecordSource = ""
936:                 IF THIS.this_oBusinessObject.Buscar(ALLTRIM(loc_cFiltro))
937:                     loc_oGrid.ColumnCount = 5
938:                     loc_oGrid.RecordSource         = "cursor_4c_Dados"
939:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.priors"
940:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.grupos"
941:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.contas"
942:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.emps"
943:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Razas"
944:                     loc_oGrid.Column1.Header1.Caption = "Prioridade"
945:                     loc_oGrid.Column2.Header1.Caption = "Grupo"
946:                     loc_oGrid.Column3.Header1.Caption = "Conta"
947:                     loc_oGrid.Column4.Header1.Caption = "Empresa"
948:                     loc_oGrid.Column5.Header1.Caption = "Nome Empresa"
949:                     loc_lResultado = .T.
950:                 ENDIF
951:             ENDIF
952:         CATCH TO loc_oErro
953:             MsgErro(loc_oErro.Message, "FormCeg.BtnBuscarClick")
954:         ENDTRY
955: 
956:         RETURN loc_lResultado
957:     ENDPROC
958: 
959:     *--------------------------------------------------------------------------
960:     * BtnEncerrarClick - Fecha o formulario
961:     *--------------------------------------------------------------------------
962:     PROCEDURE BtnEncerrarClick()
963:         TRY
964:             THIS.Release()
965:         CATCH TO loc_oErro
966:             MsgErro(loc_oErro.Message, "FormCeg.BtnEncerrarClick")
967:         ENDTRY
968:     ENDPROC
969: 
970:     *--------------------------------------------------------------------------
971:     * BtnSalvarClick - Valida, transfere Form->BO e salva registro
972:     *--------------------------------------------------------------------------
973:     PROCEDURE BtnSalvarClick()
974:         LOCAL loc_lResultado, loc_oPg2, loc_cGrupo, loc_cConta, loc_nTpCads
975:         loc_lResultado = .F.
976:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
977: 
978:         *-- Ler valores do form (com guards para controles de fases posteriores)
979:         loc_cGrupo  = ""
980:         loc_cConta  = ""
981:         loc_nTpCads = THIS.this_oBusinessObject.this_nTpCads
982:         IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo", 5)
983:             loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
984:         ENDIF
985:         IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
986:             loc_cConta = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
987:         ENDIF
988:         IF PEMSTATUS(loc_oPg2, "opt_4c_TpCad", 5)
989:             loc_nTpCads = loc_oPg2.opt_4c_TpCad.Value
990:         ENDIF
991: 
992:         *-- Validacoes FORA do TRY (regra critica: RETURN fora de TRY)
993:         IF EMPTY(loc_cGrupo)
994:             MsgAviso("Grupo n" + CHR(227) + "o pode ficar em branco!", "Campo Obrigat" + CHR(243) + "rio")
995:             RETURN .F.
996:         ENDIF
997:         IF loc_nTpCads > 2 AND EMPTY(loc_cConta)
998:             MsgAviso("Conta n" + CHR(227) + "o pode ficar em branco para este tipo!", "Campo Obrigat" + CHR(243) + "rio")
999:             RETURN .F.
1000:         ENDIF
1001: 
1002:         TRY
1003:             THIS.FormParaBO()
1004:             IF THIS.this_oBusinessObject.Salvar()
1005:                 MsgInfo("Registro salvo com sucesso!", "Sucesso")
1006:                 THIS.AlternarPagina(1)
1007:                 loc_lResultado = .T.
1008:             ENDIF
1009:         CATCH TO loc_oErro
1010:             MsgErro(loc_oErro.Message, "FormCeg.BtnSalvarClick")
1011:         ENDTRY
1012: 
1013:         RETURN loc_lResultado
1014:     ENDPROC
1015: 
1016:     *--------------------------------------------------------------------------
1017:     * BtnCancelarClick - Descarta alteracoes e volta para lista
1018:     *--------------------------------------------------------------------------
1019:     PROCEDURE BtnCancelarClick()
1020:         THIS.AlternarPagina(1)
1021:     ENDPROC
1022: 
1023:     *--------------------------------------------------------------------------
1024:     * FormParaBO - Transfere valores do formulario para o Business Object
1025:     *--------------------------------------------------------------------------
1026:     PROTECTED PROCEDURE FormParaBO()
1027:         LOCAL loc_oPg2, loc_oCtrl
1028:         TRY
1029:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1030: 
1031:             IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo", 5)
1032:                 loc_oCtrl = loc_oPg2.txt_4c_Grupo
1033:                 IF VARTYPE(loc_oCtrl) = "O"
1034:                     THIS.this_oBusinessObject.this_cGrupos = ALLTRIM(loc_oCtrl.Value)
1035:                 ENDIF
1036:             ENDIF
1037:             IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
1038:                 loc_oCtrl = loc_oPg2.txt_4c_Conta
1039:                 IF VARTYPE(loc_oCtrl) = "O"
1040:                     THIS.this_oBusinessObject.this_cContas = ALLTRIM(loc_oCtrl.Value)
1041:                 ENDIF
1042:             ENDIF
1043:             IF PEMSTATUS(loc_oPg2, "txt_4c_Priors", 5)
1044:                 loc_oCtrl = loc_oPg2.txt_4c_Priors
1045:                 IF VARTYPE(loc_oCtrl) = "O"
1046:                     THIS.this_oBusinessObject.this_nPriors = loc_oCtrl.Value
1047:                 ENDIF
1048:             ENDIF
1049:             IF PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5)
1050:                 loc_oCtrl = loc_oPg2.txt_4c_Emps
1051:                 IF VARTYPE(loc_oCtrl) = "O"
1052:                     THIS.this_oBusinessObject.this_cEmps = ALLTRIM(loc_oCtrl.Value)
1053:                 ENDIF
1054:             ENDIF
1055:             IF PEMSTATUS(loc_oPg2, "opt_4c_TpCad", 5)
1056:                 loc_oCtrl = loc_oPg2.opt_4c_TpCad
1057:                 IF VARTYPE(loc_oCtrl) = "O"
1058:                     THIS.this_oBusinessObject.this_nTpCads = loc_oCtrl.Value
1059:                 ENDIF
1060:             ENDIF
1061:         CATCH TO loc_oErro
1062:             MsgErro(loc_oErro.Message, "FormCeg.FormParaBO")
1063:         ENDTRY
1064:     ENDPROC
1065: 
1066:     *--------------------------------------------------------------------------
1067:     * BOParaForm - Transfere valores do Business Object para o formulario
1068:     *--------------------------------------------------------------------------
1069:     PROTECTED PROCEDURE BOParaForm()
1070:         LOCAL loc_oPg2, loc_oCtrl
1071:         TRY
1072:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1073: 
1074:             IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo", 5)
1075:                 loc_oCtrl = loc_oPg2.txt_4c_Grupo
1076:                 IF VARTYPE(loc_oCtrl) = "O"
1077:                     loc_oCtrl.Value = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
1078:                 ENDIF
1079:             ENDIF
1080:             IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
1081:                 loc_oCtrl = loc_oPg2.txt_4c_Conta
1082:                 IF VARTYPE(loc_oCtrl) = "O"
1083:                     loc_oCtrl.Value = ALLTRIM(THIS.this_oBusinessObject.this_cContas)
1084:                 ENDIF
1085:             ENDIF
1086:             IF PEMSTATUS(loc_oPg2, "txt_4c_Priors", 5)
1087:                 loc_oCtrl = loc_oPg2.txt_4c_Priors
1088:                 IF VARTYPE(loc_oCtrl) = "O"
1089:                     loc_oCtrl.Value = THIS.this_oBusinessObject.this_nPriors
1090:                 ENDIF
1091:             ENDIF
1092:             IF PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5)
1093:                 loc_oCtrl = loc_oPg2.txt_4c_Emps
1094:                 IF VARTYPE(loc_oCtrl) = "O"
1095:                     loc_oCtrl.Value = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
1096:                 ENDIF
1097:             ENDIF
1098:             IF PEMSTATUS(loc_oPg2, "txt_4c_DEmps", 5)
1099:                 loc_oCtrl = loc_oPg2.txt_4c_DEmps
1100:                 IF VARTYPE(loc_oCtrl) = "O"
1101:                     loc_oCtrl.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDEmps)
1102:                 ENDIF
1103:             ENDIF
1104:             IF PEMSTATUS(loc_oPg2, "opt_4c_TpCad", 5)
1105:                 loc_oCtrl = loc_oPg2.opt_4c_TpCad
1106:                 IF VARTYPE(loc_oCtrl) = "O"
1107:                     loc_oCtrl.Value = THIS.this_oBusinessObject.this_nTpCads
1108:                 ENDIF
1109:             ENDIF

*-- Linhas 1115 a 1158:
1115:     *--------------------------------------------------------------------------
1116:     * LimparCampos - Limpa valores dos campos de Page2
1117:     *--------------------------------------------------------------------------
1118:     PROTECTED PROCEDURE LimparCampos()
1119:         LOCAL loc_oPg2, loc_oCtrl
1120:         TRY
1121:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1122: 
1123:             IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo", 5)
1124:                 loc_oCtrl = loc_oPg2.txt_4c_Grupo
1125:                 IF VARTYPE(loc_oCtrl) = "O"
1126:                     loc_oCtrl.Value = ""
1127:                 ENDIF
1128:             ENDIF
1129:             IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
1130:                 loc_oCtrl = loc_oPg2.txt_4c_Conta
1131:                 IF VARTYPE(loc_oCtrl) = "O"
1132:                     loc_oCtrl.Value = ""
1133:                 ENDIF
1134:             ENDIF
1135:             IF PEMSTATUS(loc_oPg2, "txt_4c_Priors", 5)
1136:                 loc_oCtrl = loc_oPg2.txt_4c_Priors
1137:                 IF VARTYPE(loc_oCtrl) = "O"
1138:                     loc_oCtrl.Value = 0
1139:                 ENDIF
1140:             ENDIF
1141:             IF PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5)
1142:                 loc_oCtrl = loc_oPg2.txt_4c_Emps
1143:                 IF VARTYPE(loc_oCtrl) = "O"
1144:                     loc_oCtrl.Value = ""
1145:                 ENDIF
1146:             ENDIF
1147:             IF PEMSTATUS(loc_oPg2, "txt_4c_DEmps", 5)
1148:                 loc_oCtrl = loc_oPg2.txt_4c_DEmps
1149:                 IF VARTYPE(loc_oCtrl) = "O"
1150:                     loc_oCtrl.Value = ""
1151:                 ENDIF
1152:             ENDIF
1153:             IF PEMSTATUS(loc_oPg2, "opt_4c_TpCad", 5)
1154:                 loc_oCtrl = loc_oPg2.opt_4c_TpCad
1155:                 IF VARTYPE(loc_oCtrl) = "O"
1156:                     loc_oCtrl.Value = 1
1157:                 ENDIF
1158:             ENDIF

*-- Linhas 1164 a 1207:
1164:     *--------------------------------------------------------------------------
1165:     * HabilitarCampos - Habilita ou desabilita campos editaveis de Page2
1166:     *--------------------------------------------------------------------------
1167:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1168:         LOCAL loc_oPg2, loc_oCtrl, loc_lGrupoEditavel
1169:         TRY
1170:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1171:             *-- Grupo e Conta: editaveis apenas em INCLUIR (PK composta)
1172:             loc_lGrupoEditavel = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
1173: 
1174:             IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo", 5)
1175:                 loc_oCtrl = loc_oPg2.txt_4c_Grupo
1176:                 IF VARTYPE(loc_oCtrl) = "O"
1177:                     loc_oCtrl.Enabled = loc_lGrupoEditavel
1178:                 ENDIF
1179:             ENDIF
1180:             IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
1181:                 loc_oCtrl = loc_oPg2.txt_4c_Conta
1182:                 IF VARTYPE(loc_oCtrl) = "O"
1183:                     loc_oCtrl.Enabled = loc_lGrupoEditavel
1184:                 ENDIF
1185:             ENDIF
1186:             IF PEMSTATUS(loc_oPg2, "txt_4c_Priors", 5)
1187:                 loc_oCtrl = loc_oPg2.txt_4c_Priors
1188:                 IF VARTYPE(loc_oCtrl) = "O"
1189:                     loc_oCtrl.Enabled = par_lHabilitar
1190:                 ENDIF
1191:             ENDIF
1192:             IF PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5)
1193:                 loc_oCtrl = loc_oPg2.txt_4c_Emps
1194:                 IF VARTYPE(loc_oCtrl) = "O"
1195:                     loc_oCtrl.Enabled = par_lHabilitar
1196:                 ENDIF
1197:             ENDIF
1198:             IF PEMSTATUS(loc_oPg2, "txt_4c_DEmps", 5)
1199:                 loc_oCtrl = loc_oPg2.txt_4c_DEmps
1200:                 IF VARTYPE(loc_oCtrl) = "O"
1201:                     *-- DEmps editavel em INCLUIR/ALTERAR quando Emps estiver vazio (busca por nome)
1202:                     IF PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5) AND VARTYPE(loc_oPg2.txt_4c_Emps) = "O"
1203:                         loc_oCtrl.Enabled = par_lHabilitar AND EMPTY(ALLTRIM(loc_oPg2.txt_4c_Emps.Value))
1204:                     ELSE
1205:                         loc_oCtrl.Enabled = par_lHabilitar
1206:                     ENDIF
1207:                 ENDIF

*-- Linhas 1225 a 1570:
1225:     ENDPROC
1226: 
1227:     *--------------------------------------------------------------------------
1228:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1229:     *--------------------------------------------------------------------------
1230:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1231:         LOCAL loc_nI, loc_oObjeto, loc_nP
1232: 
1233:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1234:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1235: 
1236:             IF VARTYPE(loc_oObjeto) = "O"
1237:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1238:                     loc_oObjeto.Visible = .T.
1239:                 ENDIF
1240: 
1241:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1242:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1243:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1244:                     ENDFOR
1245:                 ENDIF
1246: 
1247:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1248:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1249:                 ENDIF
1250:             ENDIF
1251:         ENDFOR
1252:     ENDPROC
1253: 
1254:     *--------------------------------------------------------------------------
1255:     * ValidarGrupo - LostFocus handler para txt_4c_Grupo
1256:     * Lookup em SigCdGcr (Grupos de Conta Corrente)
1257:     *--------------------------------------------------------------------------
1258:     PROCEDURE ValidarGrupo()
1259:         LOCAL loc_cGrupo, loc_oPg2
1260:         TRY
1261:             loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1262:             loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
1263:             IF !EMPTY(loc_cGrupo)
1264:                 THIS.AbrirBuscaGrupo(loc_cGrupo)
1265:             ENDIF
1266:         CATCH TO loc_oErro
1267:             MsgErro(loc_oErro.Message, "FormCeg.ValidarGrupo")
1268:         ENDTRY
1269:     ENDPROC
1270: 
1271:     *--------------------------------------------------------------------------
1272:     * TeclaGrupo - KeyPress handler para txt_4c_Grupo (F4 abre lookup)
1273:     *--------------------------------------------------------------------------
1274:     PROCEDURE TeclaGrupo(par_nKeyCode, par_nShiftAltCtrl)
1275:         IF par_nKeyCode = 63
1276:             THIS.AbrirBuscaGrupo(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value))
1277:         ENDIF
1278:     ENDPROC
1279: 
1280:     *--------------------------------------------------------------------------
1281:     * AbrirBuscaGrupo - Abre FormBuscaAuxiliar para SigCdGcr
1282:     * Campos: Codigos (PK) / Descrs (descricao do grupo)
1283:     *--------------------------------------------------------------------------
1284:     PROCEDURE AbrirBuscaGrupo(par_cValor)
1285:         LOCAL loc_oBusca, loc_oPg2
1286:         TRY
1287:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1288: 
1289:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1290:                 "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", par_cValor, ;
1291:                 "Grupos de Conta Corrente")
1292: 
1293:             IF VARTYPE(loc_oBusca) = "O"
1294:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1295:                     IF USED("cursor_4c_BuscaGrupo")
1296:                         loc_oPg2.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1297:                     ENDIF
1298:                 ELSE
1299:                     IF !loc_oBusca.this_lAchouRegistro
1300:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1301:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1302:                     loc_oBusca.Show()
1303:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
1304:                         loc_oPg2.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1305:                     ENDIF
1306:                     ENDIF
1307:                 ENDIF
1308:                 loc_oBusca.Release()
1309:             ENDIF
1310:         CATCH TO loc_oErro
1311:             MsgErro(loc_oErro.Message, "FormCeg.AbrirBuscaGrupo")
1312:         ENDTRY
1313: 
1314:         IF USED("cursor_4c_BuscaGrupo")
1315:             USE IN cursor_4c_BuscaGrupo
1316:         ENDIF
1317:     ENDPROC
1318: 
1319:     *--------------------------------------------------------------------------
1320:     * ValidarConta - LostFocus handler para txt_4c_Conta
1321:     * Lookup em SigCdCli (clientes - contas correntes via fAcessoContas)
1322:     *--------------------------------------------------------------------------
1323:     PROCEDURE ValidarConta()
1324:         LOCAL loc_cConta, loc_cGrupo, loc_oPg2
1325:         TRY
1326:             loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1327:             loc_cConta = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
1328:             loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
1329:             IF !EMPTY(loc_cConta)
1330:                 THIS.AbrirBuscaConta(loc_cGrupo, loc_cConta)
1331:             ENDIF
1332:         CATCH TO loc_oErro
1333:             MsgErro(loc_oErro.Message, "FormCeg.ValidarConta")
1334:         ENDTRY
1335:     ENDPROC
1336: 
1337:     *--------------------------------------------------------------------------
1338:     * TeclaConta - KeyPress handler para txt_4c_Conta (F4 abre lookup)
1339:     *--------------------------------------------------------------------------
1340:     PROCEDURE TeclaConta(par_nKeyCode, par_nShiftAltCtrl)
1341:         IF par_nKeyCode = 63
1342:             LOCAL loc_oPg2
1343:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1344:             THIS.AbrirBuscaConta(ALLTRIM(loc_oPg2.txt_4c_Grupo.Value), ;
1345:                                  ALLTRIM(loc_oPg2.txt_4c_Conta.Value))
1346:         ENDIF
1347:     ENDPROC
1348: 
1349:     *--------------------------------------------------------------------------
1350:     * AbrirBuscaConta - Abre FormBuscaAuxiliar para SigCdCli (contas correntes)
1351:     * Campos: Iclis (PK conta) / Rclis (razao social)
1352:     *--------------------------------------------------------------------------
1353:     PROCEDURE AbrirBuscaConta(par_cGrupo, par_cValor)
1354:         LOCAL loc_oBusca, loc_oPg2
1355:         TRY
1356:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1357: 
1358:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1359:                 "SigCdCli", "cursor_4c_BuscaConta", "Iclis", par_cValor, ;
1360:                 "Clientes / Contas")
1361: 
1362:             IF VARTYPE(loc_oBusca) = "O"
1363:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1364:                     IF USED("cursor_4c_BuscaConta")
1365:                         loc_oPg2.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaConta.Iclis)
1366:                     ENDIF
1367:                 ELSE
1368:                     IF !loc_oBusca.this_lAchouRegistro
1369:                     loc_oBusca.mAddColuna("Iclis",  "", "Conta")
1370:                     loc_oBusca.mAddColuna("Rclis",  "", "Nome")
1371:                     loc_oBusca.Show()
1372:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1373:                         loc_oPg2.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaConta.Iclis)
1374:                     ENDIF
1375:                     ENDIF
1376:                 ENDIF
1377:                 loc_oBusca.Release()
1378:             ENDIF
1379:         CATCH TO loc_oErro
1380:             MsgErro(loc_oErro.Message, "FormCeg.AbrirBuscaConta")
1381:         ENDTRY
1382: 
1383:         IF USED("cursor_4c_BuscaConta")
1384:             USE IN cursor_4c_BuscaConta
1385:         ENDIF
1386:     ENDPROC
1387: 
1388:     *--------------------------------------------------------------------------
1389:     * ValidarEmps - LostFocus handler para txt_4c_Emps
1390:     * Lookup em SigCdEmp por codigo (Cemps) - preenche tambem txt_4c_DEmps
1391:     *--------------------------------------------------------------------------
1392:     PROCEDURE ValidarEmps()
1393:         LOCAL loc_cEmps, loc_oPg2
1394:         TRY
1395:             loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1396:             loc_cEmps = ALLTRIM(loc_oPg2.txt_4c_Emps.Value)
1397:             IF !EMPTY(loc_cEmps)
1398:                 THIS.AbrirBuscaEmps(loc_cEmps)
1399:             ENDIF
1400:         CATCH TO loc_oErro
1401:             MsgErro(loc_oErro.Message, "FormCeg.ValidarEmps")
1402:         ENDTRY
1403:     ENDPROC
1404: 
1405:     *--------------------------------------------------------------------------
1406:     * TeclaEmps - KeyPress handler para txt_4c_Emps (F4 abre lookup)
1407:     *--------------------------------------------------------------------------
1408:     PROCEDURE TeclaEmps(par_nKeyCode, par_nShiftAltCtrl)
1409:         IF par_nKeyCode = 63
1410:             THIS.AbrirBuscaEmps(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Emps.Value))
1411:         ENDIF
1412:     ENDPROC
1413: 
1414:     *--------------------------------------------------------------------------
1415:     * AbrirBuscaEmps - Abre FormBuscaAuxiliar para SigCdEmp por codigo (Cemps)
1416:     * Preenche txt_4c_Emps (codigo) e txt_4c_DEmps (razao social/Razas)
1417:     *--------------------------------------------------------------------------
1418:     PROCEDURE AbrirBuscaEmps(par_cValor)
1419:         LOCAL loc_oBusca, loc_oPg2
1420:         TRY
1421:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1422: 
1423:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1424:                 "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", par_cValor, ;
1425:                 "Empresas")
1426: 
1427:             IF VARTYPE(loc_oBusca) = "O"
1428:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1429:                     IF USED("cursor_4c_BuscaEmp")
1430:                         loc_oPg2.txt_4c_Emps.Value  = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
1431:                         loc_oPg2.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
1432:                     ENDIF
1433:                 ELSE
1434:                     IF !loc_oBusca.this_lAchouRegistro
1435:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
1436:                     loc_oBusca.mAddColuna("Razas", "", "Nome")
1437:                     loc_oBusca.Show()
1438:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
1439:                         loc_oPg2.txt_4c_Emps.Value  = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
1440:                         loc_oPg2.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
1441:                     ENDIF
1442:                     ENDIF
1443:                 ENDIF
1444:                 loc_oBusca.Release()
1445:             ENDIF
1446:         CATCH TO loc_oErro
1447:             MsgErro(loc_oErro.Message, "FormCeg.AbrirBuscaEmps")
1448:         ENDTRY
1449: 
1450:         IF USED("cursor_4c_BuscaEmp")
1451:             USE IN cursor_4c_BuscaEmp
1452:         ENDIF
1453:     ENDPROC
1454: 
1455:     *--------------------------------------------------------------------------
1456:     * ValidarDEmps - LostFocus handler para txt_4c_DEmps
1457:     * Busca empresa por nome (Razas) - preenche tambem txt_4c_Emps
1458:     *--------------------------------------------------------------------------
1459:     PROCEDURE ValidarDEmps()
1460:         LOCAL loc_cDEmps, loc_oPg2
1461:         TRY
1462:             loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1463:             loc_cDEmps = ALLTRIM(loc_oPg2.txt_4c_DEmps.Value)
1464:             IF !EMPTY(loc_cDEmps)
1465:                 THIS.AbrirBuscaDEmps(loc_cDEmps)
1466:             ENDIF
1467:         CATCH TO loc_oErro
1468:             MsgErro(loc_oErro.Message, "FormCeg.ValidarDEmps")
1469:         ENDTRY
1470:     ENDPROC
1471: 
1472:     *--------------------------------------------------------------------------
1473:     * TeclaDEmps - KeyPress handler para txt_4c_DEmps (F4 abre lookup)
1474:     *--------------------------------------------------------------------------
1475:     PROCEDURE TeclaDEmps(par_nKeyCode, par_nShiftAltCtrl)
1476:         IF par_nKeyCode = 63
1477:             THIS.AbrirBuscaDEmps(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_DEmps.Value))
1478:         ENDIF
1479:     ENDPROC
1480: 
1481:     *--------------------------------------------------------------------------
1482:     * AbrirBuscaDEmps - Abre FormBuscaAuxiliar para SigCdEmp por nome (Razas)
1483:     * Preenche txt_4c_DEmps (nome) e txt_4c_Emps (codigo/Cemps)
1484:     *--------------------------------------------------------------------------
1485:     PROCEDURE AbrirBuscaDEmps(par_cValor)
1486:         LOCAL loc_oBusca, loc_oPg2
1487:         TRY
1488:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1489: 
1490:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1491:                 "SigCdEmp", "cursor_4c_BuscaDEmp", "Razas", par_cValor, ;
1492:                 "Empresas")
1493: 
1494:             IF VARTYPE(loc_oBusca) = "O"
1495:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1496:                     IF USED("cursor_4c_BuscaDEmp")
1497:                         loc_oPg2.txt_4c_Emps.Value  = ALLTRIM(cursor_4c_BuscaDEmp.Cemps)
1498:                         loc_oPg2.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_BuscaDEmp.Razas)
1499:                     ENDIF
1500:                 ELSE
1501:                     IF !loc_oBusca.this_lAchouRegistro
1502:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
1503:                     loc_oBusca.mAddColuna("Razas", "", "Nome")
1504:                     loc_oBusca.Show()
1505:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDEmp")
1506:                         loc_oPg2.txt_4c_Emps.Value  = ALLTRIM(cursor_4c_BuscaDEmp.Cemps)
1507:                         loc_oPg2.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_BuscaDEmp.Razas)
1508:                     ENDIF
1509:                     ENDIF
1510:                 ENDIF
1511:                 loc_oBusca.Release()
1512:             ENDIF
1513:         CATCH TO loc_oErro
1514:             MsgErro(loc_oErro.Message, "FormCeg.AbrirBuscaDEmps")
1515:         ENDTRY
1516: 
1517:         IF USED("cursor_4c_BuscaDEmp")
1518:             USE IN cursor_4c_BuscaDEmp
1519:         ENDIF
1520:     ENDPROC
1521: 
1522:     *--------------------------------------------------------------------------
1523:     * AjustarBotoesPorModo - Habilita/desabilita botoes CRUD da Page1 por modo
1524:     *--------------------------------------------------------------------------
1525:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1526:         LOCAL loc_oBotoes, loc_lTemRegistro
1527:         TRY
1528:             loc_oBotoes    = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
1529:             loc_lTemRegistro = USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1530: 
1531:             IF PEMSTATUS(loc_oBotoes, "cmd_4c_Visualizar", 5)
1532:                 loc_oBotoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
1533:             ENDIF
1534:             IF PEMSTATUS(loc_oBotoes, "cmd_4c_Alterar", 5)
1535:                 loc_oBotoes.cmd_4c_Alterar.Enabled = loc_lTemRegistro
1536:             ENDIF
1537:             IF PEMSTATUS(loc_oBotoes, "cmd_4c_Excluir", 5)
1538:                 loc_oBotoes.cmd_4c_Excluir.Enabled = loc_lTemRegistro
1539:             ENDIF
1540:         CATCH TO loc_oErro
1541:             MsgErro(loc_oErro.Message, "FormCeg.AjustarBotoesPorModo")
1542:         ENDTRY
1543:     ENDPROC
1544: 
1545:     *--------------------------------------------------------------------------
1546:     * FormatarGridLista - Aplica formatacao visual ao grid da lista
1547:     *--------------------------------------------------------------------------
1548:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1549:         WITH par_oGrid
1550:             .FontName = "Verdana"
1551:             .FontSize = 8
1552:         ENDWITH
1553:     ENDPROC
1554: 
1555:     *--------------------------------------------------------------------------
1556:     * Destroy - Libera recursos do formulario
1557:     *--------------------------------------------------------------------------
1558:     PROCEDURE Destroy()
1559:         TRY
1560:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1561:                 THIS.this_oBusinessObject = .NULL.
1562:             ENDIF
1563:         CATCH TO loc_oErro
1564:             MsgErro(loc_oErro.Message, "FormCeg.Destroy")
1565:         ENDTRY
1566: 
1567:         DODEFAULT()
1568:     ENDPROC
1569: 
1570: ENDDEFINE


### BO (C:\4c\projeto\app\classes\CegBO.prg):
*====================================================================
* CegBO.prg
*
* Business Object para Prioridade de Estoque p/Globaliza??o
* Tabela principal: SigCdCeg (cidchaves PK)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS CegBO AS BusinessBase

	*-- Propriedades da entidade (SigCdCeg)
	this_cCidchaves   = ""   && cidchaves char(?)      - PK (gerado por fUniqueIds)
	this_cGrupos      = ""   && grupos char(?)         - Grupo (FK SigCdGcr.Codigos)
	this_cContas      = ""   && contas char(?)         - Conta (via fAcessoContas)
	this_cEmps        = ""   && Cemps char(3)           - Empresa (FK SigCdEmp.CEmps)
	this_nPriors      = 0    && priors numeric(2,0)    - Prioridade (InputMask "99")
	this_nTpCads      = 0    && TpCads numeric(1,0)    - Tipo (OptionGroup 3 opcoes)

	*-- Propriedade auxiliar de exibicao (NAO persiste no banco)
	this_cDEmps       = ""   && descricao da empresa (SigCdEmp.Razas - display only)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCdCeg"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidchaves)
	ENDPROC

	*====================================================================
	* Buscar - Carrega lista de registros no cursor_4c_Dados
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT a.cidchaves, a.priors, a.grupos, a.contas, a.emps," + ;
			           " ISNULL(b.Razas, '') AS Razas" + ;
			           " FROM SIGCDCEG a" + ;
			           " LEFT JOIN SigCdEmp b ON RTRIM(b.Cemps) = RTRIM(a.cemps)"

			IF !EMPTY(par_cFiltro)
				loc_cSQL = loc_cSQL + " WHERE RTRIM(a.grupos) LIKE " + ;
				           EscaparSQL(ALLTRIM(par_cFiltro) + "%")
			ENDIF

			loc_cSQL = loc_cSQL + " ORDER BY a.grupos, a.contas, a.priors"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar prioridades:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar prioridades:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pela chave primaria
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCidchaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT a.cidchaves, a.contas, a.grupos, a.priors," + ;
			           " a.emps, a.tpcads," + ;
			           " ISNULL(b.Razas, '') AS Razas" + ;
			           " FROM SIGCDCEG a" + ;
			           " LEFT JOIN SigCdEmp b ON RTRIM(b.Cemps) = RTRIM(a.cemps)" + ;
			           " WHERE RTRIM(a.cidchaves) = " + EscaparSQL(ALLTRIM(par_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar prioridade:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
			THIS.this_cContas    = TratarNulo(contas, "C")
			THIS.this_cGrupos    = TratarNulo(grupos, "C")
			THIS.this_nPriors    = TratarNulo(priors, "N")
			THIS.this_cEmps      = TratarNulo(emps, "C")
			THIS.this_nTpCads    = TratarNulo(tpcads, "N")
			THIS.this_cDEmps     = TratarNulo(Razas, "C")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* VerificarDuplicidade - Verifica se grupos+contas ja existem (INSERT)
	*====================================================================
	PROCEDURE VerificarDuplicidade()
		LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
		loc_lDuplicado = .F.

		TRY
			loc_cSQL = "SELECT COUNT(*) AS Total FROM SIGCDCEG" + ;
			           " WHERE RTRIM(grupos) = " + EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + ;
			           " AND RTRIM(contas) = " + EscaparSQL(ALLTRIM(THIS.this_cContas))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Duplic")
			IF loc_nResultado >= 0 AND !EOF("cursor_4c_Duplic")
				loc_lDuplicado = (cursor_4c_Duplic.Total > 0)
			ENDIF

			IF USED("cursor_4c_Duplic")
				USE IN cursor_4c_Duplic
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Duplic")
				USE IN cursor_4c_Duplic
			ENDIF
		ENDTRY

		RETURN loc_lDuplicado
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SIGCDCEG
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)

			loc_cSQL = "INSERT INTO SIGCDCEG" + ;
			           " (cidchaves, contas, grupos, priors, emps, tpcads)" + ;
			           " VALUES (" + ;
			           EscaparSQL(THIS.this_cCidchaves) + "," + ;
			           EscaparSQL(LEFT(THIS.this_cContas, 10)) + "," + ;
			           EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + "," + ;
			           FormatarNumeroSQL(THIS.this_nPriors) + "," + ;
			           EscaparSQL(LEFT(THIS.this_cEmps, 3)) + "," + ;
			           FormatarNumeroSQL(THIS.this_nTpCads) + ;
			           ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir prioridade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir prioridade:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SIGCDCEG
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SIGCDCEG SET" + ;
			           " contas = " + EscaparSQL(LEFT(THIS.this_cContas, 10)) + "," + ;
			           " grupos = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + "," + ;
			           " priors = " + FormatarNumeroSQL(THIS.this_nPriors) + "," + ;
			           " emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + "," + ;
			           " tpcads = " + FormatarNumeroSQL(THIS.this_nTpCads) + ;
			           " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar prioridade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar prioridade:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE na tabela SIGCDCEG
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SIGCDCEG" + ;
			           " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir prioridade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir prioridade:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

