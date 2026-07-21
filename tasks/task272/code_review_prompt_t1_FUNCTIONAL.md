# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [BINDEVENT-PARAMS] Handler 'CmoesLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE CmoesLostFocus(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSigPrCtc.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1398 linhas total):

*-- Linhas 36 a 200:
36:     this_lHouveExclusao  = .F.
37: 
38:     *--------------------------------------------------------------------------
39:     * Init - Apenas delega para FormBase (que chama InicializarForm)
40:     * Parametros opcionais para chamada modal a partir de outros forms:
41:     *   par_oParentForm : referencia ao form chamador (sera desabilitado)
42:     *   par_cEscolha    : permissoes de INSERIR/ALTERAR/EXCLUIR
43:     *   par_cEmps       : codigo da empresa
44:     *   par_cDopes      : codigo da operacao (tipo)
45:     *   par_nNumes      : numero da operacao
46:     *--------------------------------------------------------------------------
47:     PROCEDURE Init()
48:         LPARAMETERS par_oParentForm, par_cEscolha, par_cEmps, par_cDopes, par_nNumes
49: 
50:         LOCAL loc_lSucesso
51:         loc_lSucesso = .F.
52: 
53:         TRY
54:             IF VARTYPE(par_oParentForm) = "O"
55:                 THIS.this_oParentForm = par_oParentForm
56:                 par_oParentForm.Enabled = .F.
57:             ENDIF
58: 
59:             IF VARTYPE(par_cEscolha) = "C"
60:                 THIS.this_cEscolha = ALLTRIM(par_cEscolha)
61:             ENDIF
62: 
63:             IF VARTYPE(par_cEmps) = "C" AND VARTYPE(par_cDopes) = "C" AND VARTYPE(par_nNumes) = "N"
64:                 THIS.this_cEmpDopNums = ALLTRIM(par_cEmps) + ALLTRIM(par_cDopes) + STR(par_nNumes, 6)
65:                 THIS.Caption = "Cota" + CHR(231) + CHR(245) + "es " + ;
66:                                ALLTRIM(PROPER(THIS.this_cEmpDopNums))
67:             ENDIF
68: 
69:             loc_lSucesso = DODEFAULT()
70:         CATCH TO loc_oErro
71:             MsgErro("Erro em FormSigPrCtc.Init:" + CHR(13) + loc_oErro.Message + ;
72:                     " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
73:         ENDTRY
74: 
75:         RETURN loc_lSucesso
76:     ENDPROC
77: 
78:     *--------------------------------------------------------------------------
79:     * InicializarForm - Cria BO e monta estrutura visual completa
80:     * Chamado por FormBase.Init() via DODEFAULT()
81:     *--------------------------------------------------------------------------
82:     PROTECTED PROCEDURE InicializarForm()
83:         LOCAL loc_lSucesso
84:         loc_lSucesso = .F.
85: 
86:         TRY
87:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrCtcBO")
88: 
89:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
90:                 MsgErro("Erro ao criar SigPrCtcBO", "Erro")
91:             ELSE
92:                 THIS.ConfigurarPageFrame()
93:                 THIS.ConfigurarPaginaLista()
94:                 THIS.ConfigurarPaginaDados()
95:                 THIS.ControlarBotoesPorEscolha()
96: 
97:                 *-- Carrega dados na grade (requer this_cEmpDopNums setado em Init)
98:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
99:                     THIS.CarregarLista()
100:                 ENDIF
101: 
102:                 *-- Propaga Caption para labels do cabecalho (fase 4 cria os labels)
103:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Cabecalho", 5)
104:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho, "lbl_4c_Sombra", 5)
105:                         THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
106:                     ENDIF
107:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho, "lbl_4c_Titulo", 5)
108:                         THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
109:                     ENDIF
110:                 ENDIF
111: 
112:                 THIS.pgf_4c_Paginas.Visible    = .T.
113:                 THIS.pgf_4c_Paginas.ActivePage = 1
114:                 THIS.this_cModoAtual = "LISTA"
115: 
116:                 SET DATE TO BRITISH
117:                 SET CENTURY ON
118: 
119:                 loc_lSucesso = .T.
120:             ENDIF
121:         CATCH TO loc_oErro
122:             MsgErro("Erro em InicializarForm:" + CHR(13) + loc_oErro.Message + ;
123:                     " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
124:         ENDTRY
125: 
126:         RETURN loc_lSucesso
127:     ENDPROC
128: 
129:     *--------------------------------------------------------------------------
130:     * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista e Dados)
131:     *--------------------------------------------------------------------------
132:     PROTECTED PROCEDURE ConfigurarPageFrame()
133:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
134: 
135:         WITH THIS.pgf_4c_Paginas
136:             .PageCount = 2
137:             .Top       = -29
138:             .Left      = 0
139:             .Width     = 1003
140:             .Height    = 631
141:             .Tabs      = .F.
142:         ENDWITH
143: 
144:         THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
145:         THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)
146:         THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
147: 
148:         THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
149:         THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
150:         THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
151:     ENDPROC
152: 
153:     *--------------------------------------------------------------------------
154:     * ConfigurarPaginaLista - Cria containers vazios da Page1 (Lista)
155:     * cnt_4c_Cabecalho: barra cinza superior com titulo
156:     * cnt_4c_Botoes   : container de botoes CRUD (populado na Fase 4)
157:     * cnt_4c_Saida    : container flutuante do botao Encerrar
158:     * Grid e botoes CRUD sao adicionados na Fase 4
159:     *--------------------------------------------------------------------------
160:     PROTECTED PROCEDURE ConfigurarPaginaLista()
161:         LOCAL loc_oPagina, loc_oGrid
162:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
163: 
164:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
165: 
166:         *-- Container do cabecalho (cntSombra: Top=2+29, W=THIS.Width, H=80)
167:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
168:         WITH loc_oPagina.cnt_4c_Cabecalho
169:             .Top         = 31
170:             .Left        = 0
171:             .Width       = THIS.Width
172:             .Height      = 80
173:             .BackColor   = RGB(100, 100, 100)
174:             .BorderWidth = 0
175:             .Visible     = .T.
176:         ENDWITH
177: 
178:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
179:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
180:             .AutoSize  = .F.
181:             .Caption   = THIS.Caption
182:             .Top       = 15
183:             .Left      = 10
184:             .Width     = THIS.Width - 20
185:             .Height    = 40
186:             .FontName  = "Tahoma"
187:             .FontSize  = 16
188:             .FontBold  = .T.
189:             .ForeColor = RGB(0, 0, 0)
190:             .BackStyle = 0
191:             .Visible   = .T.
192:         ENDWITH
193: 
194:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
195:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
196:             .AutoSize  = .F.
197:             .Caption   = THIS.Caption
198:             .Top       = 18
199:             .Left      = 10
200:             .Width     = THIS.Width - 20

*-- Linhas 254 a 472:
254:             .AutoSize        = .F.
255:             .Visible         = .T.
256:         ENDWITH
257:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
258: 
259:         *-- Botoes CRUD em cnt_4c_Botoes
260:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
261:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
262:             .Caption         = "Incluir"
263:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
264:             .PicturePosition = 13
265:             .Top             = 5
266:             .Left            = 5
267:             .Width           = 75
268:             .Height          = 75
269:             .BackColor       = RGB(255, 255, 255)
270:             .ForeColor       = RGB(90, 90, 90)
271:             .FontName        = "Comic Sans MS"
272:             .FontSize        = 8
273:             .FontBold        = .T.
274:             .FontItalic      = .T.
275:             .Themes          = .F.
276:             .SpecialEffect   = 0
277:             .MousePointer    = 15
278:             .WordWrap        = .T.
279:             .AutoSize        = .F.
280:             .Visible         = .T.
281:         ENDWITH
282:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
283: 
284:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
285:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
286:             .Caption         = "Visualizar"
287:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
288:             .PicturePosition = 13
289:             .Top             = 5
290:             .Left            = 80
291:             .Width           = 75
292:             .Height          = 75
293:             .BackColor       = RGB(255, 255, 255)
294:             .ForeColor       = RGB(90, 90, 90)
295:             .FontName        = "Comic Sans MS"
296:             .FontSize        = 8
297:             .FontBold        = .T.
298:             .FontItalic      = .T.
299:             .Themes          = .F.
300:             .SpecialEffect   = 0
301:             .MousePointer    = 15
302:             .WordWrap        = .T.
303:             .AutoSize        = .F.
304:             .Visible         = .T.
305:         ENDWITH
306:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
307: 
308:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
309:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
310:             .Caption         = "Alterar"
311:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
312:             .PicturePosition = 13
313:             .Top             = 5
314:             .Left            = 155
315:             .Width           = 75
316:             .Height          = 75
317:             .BackColor       = RGB(255, 255, 255)
318:             .ForeColor       = RGB(90, 90, 90)
319:             .FontName        = "Comic Sans MS"
320:             .FontSize        = 8
321:             .FontBold        = .T.
322:             .FontItalic      = .T.
323:             .Themes          = .F.
324:             .SpecialEffect   = 0
325:             .MousePointer    = 15
326:             .WordWrap        = .T.
327:             .AutoSize        = .F.
328:             .Visible         = .T.
329:         ENDWITH
330:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
331: 
332:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
333:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
334:             .Caption         = "Excluir"
335:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
336:             .PicturePosition = 13
337:             .Top             = 5
338:             .Left            = 230
339:             .Width           = 75
340:             .Height          = 75
341:             .BackColor       = RGB(255, 255, 255)
342:             .ForeColor       = RGB(90, 90, 90)
343:             .FontName        = "Comic Sans MS"
344:             .FontSize        = 8
345:             .FontBold        = .T.
346:             .FontItalic      = .T.
347:             .Themes          = .F.
348:             .SpecialEffect   = 0
349:             .MousePointer    = 15
350:             .WordWrap        = .T.
351:             .AutoSize        = .F.
352:             .Visible         = .T.
353:         ENDWITH
354:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
355: 
356:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
357:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
358:             .Caption         = "Buscar"
359:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
360:             .PicturePosition = 13
361:             .Top             = 5
362:             .Left            = 305
363:             .Width           = 75
364:             .Height          = 75
365:             .BackColor       = RGB(255, 255, 255)
366:             .ForeColor       = RGB(90, 90, 90)
367:             .FontName        = "Comic Sans MS"
368:             .FontSize        = 8
369:             .FontBold        = .T.
370:             .FontItalic      = .T.
371:             .Themes          = .F.
372:             .SpecialEffect   = 0
373:             .MousePointer    = 15
374:             .WordWrap        = .T.
375:             .AutoSize        = .F.
376:             .Visible         = .T.
377:         ENDWITH
378:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
379: 
380:         *-- Grid grd_4c_Dados (GradeSubN legado: Top=110, Left=85, Width=379 em form 550px)
381:         *-- Adaptado para form 1000px: Top=117 (+29 compensacao PageFrame), Left=12, Width=890
382:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
383:         loc_oGrid = loc_oPagina.grd_4c_Dados
384:         loc_oGrid.Top                = 117
385:         loc_oGrid.Left               = 12
386:         loc_oGrid.Width              = 890
387:         loc_oGrid.Height             = 498
388:         loc_oGrid.ColumnCount        = 3
389:         loc_oGrid.GridLines          = 3
390:         loc_oGrid.FontName           = "Verdana"
391:         loc_oGrid.FontSize           = 8
392:         loc_oGrid.ForeColor          = RGB(90, 90, 90)
393:         loc_oGrid.BackColor          = RGB(255, 255, 255)
394:         loc_oGrid.GridLineColor      = RGB(238, 238, 238)
395:         loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
396:         loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
397:         loc_oGrid.HighlightStyle     = 2
398:         loc_oGrid.DeleteMark         = .F.
399:         loc_oGrid.RecordMark         = .F.
400:         loc_oGrid.RowHeight          = 16
401:         loc_oGrid.ScrollBars         = 2
402:         loc_oGrid.Visible            = .T.
403: 
404:         WITH loc_oGrid.Column1
405:             .Width           = 100
406:             .Header1.Caption = "Moeda"
407:         ENDWITH
408: 
409:         WITH loc_oGrid.Column2
410:             .Width           = 550
411:             .ReadOnly        = .T.
412:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
413:         ENDWITH
414: 
415:         WITH loc_oGrid.Column3
416:             .Width           = 200
417:             .ReadOnly        = .T.
418:             .Header1.Caption = "Cota" + CHR(231) + CHR(227) + "o"
419:         ENDWITH
420: 
421:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
422: 
423:         THIS.TornarControlesVisiveis(loc_oPagina)
424:     ENDPROC
425: 
426:     *--------------------------------------------------------------------------
427:     * ConfigurarPaginaDados - Cria containers vazios da Page2 (Dados)
428:     * cnt_4c_Cabecalho: barra cinza superior com titulo
429:     * cnt_4c_BotoesAcao: container de botoes Confirmar/Cancelar (Fase 4)
430:     * TextBoxes/grid de detalhe sao adicionados nas Fases 5-6
431:     *--------------------------------------------------------------------------
432:     PROTECTED PROCEDURE ConfigurarPaginaDados()
433:         LOCAL loc_oPagina
434:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
435: 
436:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
437: 
438:         *-- Container do cabecalho da Page2 (mesmo layout da Page1)
439:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
440:         WITH loc_oPagina.cnt_4c_Cabecalho
441:             .Top         = 31
442:             .Left        = 0
443:             .Width       = THIS.Width
444:             .Height      = 80
445:             .BackColor   = RGB(100, 100, 100)
446:             .BorderWidth = 0
447:             .Visible     = .T.
448:         ENDWITH
449: 
450:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
451:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
452:             .AutoSize  = .F.
453:             .Caption   = THIS.Caption
454:             .Top       = 15
455:             .Left      = 10
456:             .Width     = THIS.Width - 20
457:             .Height    = 40
458:             .FontName  = "Tahoma"
459:             .FontSize  = 16
460:             .FontBold  = .T.
461:             .ForeColor = RGB(0, 0, 0)
462:             .BackStyle = 0
463:             .Visible   = .T.
464:         ENDWITH
465: 
466:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
467:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
468:             .AutoSize  = .F.
469:             .Caption   = THIS.Caption
470:             .Top       = 18
471:             .Left      = 10
472:             .Width     = THIS.Width - 20

*-- Linhas 513 a 580:
513:             .AutoSize        = .F.
514:             .Visible         = .T.
515:         ENDWITH
516:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
517: 
518:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
519:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
520:             .Caption         = "Encerrar"
521:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
522:             .PicturePosition = 13
523:             .Top             = 5
524:             .Left            = 80
525:             .Width           = 75
526:             .Height          = 75
527:             .BackColor       = RGB(255, 255, 255)
528:             .ForeColor       = RGB(90, 90, 90)
529:             .FontName        = "Comic Sans MS"
530:             .FontSize        = 8
531:             .FontBold        = .T.
532:             .FontItalic      = .T.
533:             .Themes          = .F.
534:             .SpecialEffect   = 0
535:             .MousePointer    = 15
536:             .WordWrap        = .T.
537:             .AutoSize        = .F.
538:             .Visible         = .T.
539:         ENDWITH
540:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
541: 
542:         *-- Primeiros 50% dos campos: Moeda (cmoes) e Descricao (Descrs)
543: 
544:         *-- Campo Moeda
545:         loc_oPagina.AddObject("lbl_4c_LblMoeda", "Label")
546:         WITH loc_oPagina.lbl_4c_LblMoeda
547:             .AutoSize  = .F.
548:             .Caption   = "Moeda :"
549:             .Top       = 133
550:             .Left      = 40
551:             .Width     = 100
552:             .Height    = 17
553:             .BackStyle = 0
554:             .FontName  = "Tahoma"
555:             .FontSize  = 8
556:             .ForeColor = RGB(90, 90, 90)
557:             .Alignment = 1
558:             .Visible   = .T.
559:         ENDWITH
560: 
561:         loc_oPagina.AddObject("txt_4c_Cmoes", "TextBox")
562:         WITH loc_oPagina.txt_4c_Cmoes
563:             .Value     = ""
564:             .Top       = 130
565:             .Left      = 150
566:             .Width     = 120
567:             .Height    = 23
568:             .MaxLength = 3
569:             .FontName  = "Tahoma"
570:             .FontSize  = 8
571:             .ForeColor = RGB(90, 90, 90)
572:             .BackColor = RGB(255, 255, 255)
573:             .Enabled   = .T.
574:             .Visible   = .T.
575:         ENDWITH
576: 
577:         *-- Campo Descricao (read-only, preenchido automaticamente pelo lookup de moeda)
578:         loc_oPagina.AddObject("lbl_4c_LblDescrs", "Label")
579:         WITH loc_oPagina.lbl_4c_LblDescrs
580:             .AutoSize  = .F.

*-- Linhas 642 a 754:
642:             .Visible   = .T.
643:         ENDWITH
644: 
645:         *-- BINDEVENT: lookup de moeda em txt_4c_Cmoes (F4, DblClick, LostFocus)
646:         BINDEVENT(loc_oPagina.txt_4c_Cmoes, "KeyPress",  THIS, "CmoesLookupKeyPress")
647:         BINDEVENT(loc_oPagina.txt_4c_Cmoes, "DblClick",  THIS, "CmoesLookupDblClick")
648:         BINDEVENT(loc_oPagina.txt_4c_Cmoes, "KeyPress", THIS, "CmoesLostFocus")
649: 
650:         THIS.TornarControlesVisiveis(loc_oPagina)
651:     ENDPROC
652: 
653:     *--------------------------------------------------------------------------
654:     * Destroy - Libera recursos, cursores locais e re-habilita o form pai
655:     *--------------------------------------------------------------------------
656:     PROCEDURE Destroy()
657:         TRY
658:             IF USED("cursor_4c_LocalCtMoe")
659:                 USE IN cursor_4c_LocalCtMoe
660:             ENDIF
661:             IF USED("cursor_4c_CtMoeTemp")
662:                 USE IN cursor_4c_CtMoeTemp
663:             ENDIF
664:             IF USED("cursor_4c_BuscaMoeda")
665:                 USE IN cursor_4c_BuscaMoeda
666:             ENDIF
667:             IF USED("cursor_4c_Totais")
668:                 USE IN cursor_4c_Totais
669:             ENDIF
670:             IF USED("cursor_4c_Dados")
671:                 USE IN cursor_4c_Dados
672:             ENDIF
673: 
674:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
675:                 THIS.this_oBusinessObject = .NULL.
676:             ENDIF
677: 
678:             IF VARTYPE(THIS.this_oParentForm) = "O"
679:                 THIS.this_oParentForm.Enabled = .T.
680:                 THIS.this_oParentForm = .NULL.
681:             ENDIF
682:         CATCH TO loc_oErro
683:             MsgErro("Erro em Destroy:" + CHR(13) + loc_oErro.Message, "Erro")
684:         ENDTRY
685: 
686:         DODEFAULT()
687:     ENDPROC
688: 
689:     *--------------------------------------------------------------------------
690:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
691:     *--------------------------------------------------------------------------
692:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
693:         LOCAL loc_lResultado
694:         loc_lResultado = .F.
695: 
696:         TRY
697:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
698:                 MsgErro("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + ;
699:                         TRANSFORM(par_nPagina), "Erro")
700:             ELSE
701:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
702:                 loc_lResultado = .T.
703:             ENDIF
704:         CATCH TO loc_oErro
705:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro AlternarPagina")
706:         ENDTRY
707: 
708:         RETURN loc_lResultado
709:     ENDPROC
710: 
711:     *--------------------------------------------------------------------------
712:     * CarregarLista - Carrega cursor local e configura grid da Page1
713:     *--------------------------------------------------------------------------
714:     PROCEDURE CarregarLista()
715:         LOCAL loc_lResultado, loc_oGrid
716:         loc_lResultado = .F.
717: 
718:         TRY
719:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
720:                 loc_lResultado = .T.
721:             ELSE
722:                 IF EMPTY(THIS.this_cEmpDopNums)
723:                 IF !USED("cursor_4c_LocalCtMoe")
724:                     SET NULL ON
725:                     CREATE CURSOR cursor_4c_LocalCtMoe ;
726:                         (empdopnums C(29), cmoes C(3), valos N(11,6), pkchaves C(20), Descrs C(15))
727:                     SET NULL OFF
728:                 ENDIF
729:                 loc_lResultado = .T.
730:             ELSE
731:                 IF THIS.this_oBusinessObject.CarregarParaEdicao(THIS.this_cEmpDopNums)
732:                 loc_lResultado = .T.
733:                 ENDIF
734:                 ENDIF
735:             ENDIF
736: 
737:             IF loc_lResultado AND USED("cursor_4c_LocalCtMoe")
738:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
739:                 loc_oGrid.ColumnCount = 3
740:                 loc_oGrid.RecordSource = "cursor_4c_LocalCtMoe"
741:                 loc_oGrid.ColumnCount  = 3
742: 
743:                 WITH loc_oGrid
744:                     .Column1.ControlSource   = "cursor_4c_LocalCtMoe.cmoes"
745:                     .Column1.Width           = 100
746:                     .Column1.Header1.Caption = "Moeda"
747: 
748:                     .Column2.ControlSource   = "cursor_4c_LocalCtMoe.Descrs"
749:                     .Column2.Width           = 550
750:                     .Column2.ReadOnly        = .T.
751:                     .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
752: 
753:                     .Column3.ControlSource   = "cursor_4c_LocalCtMoe.valos"
754:                     .Column3.Width           = 200

*-- Linhas 768 a 1398:
768:     ENDPROC
769: 
770:     *--------------------------------------------------------------------------
771:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
772:     *--------------------------------------------------------------------------
773:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
774:         LOCAL loc_nI, loc_oObjeto
775: 
776:         FOR loc_nI = 1 TO par_oContainer.ControlCount
777:             loc_oObjeto = par_oContainer.Controls(loc_nI)
778: 
779:             IF VARTYPE(loc_oObjeto) = "O"
780:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
781:                     loc_oObjeto.Visible = .T.
782:                 ENDIF
783: 
784:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
785:                     LOCAL loc_nP
786:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
787:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
788:                     ENDFOR
789:                 ENDIF
790: 
791:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
792:                     THIS.TornarControlesVisiveis(loc_oObjeto)
793:                 ENDIF
794:             ENDIF
795:         ENDFOR
796:     ENDPROC
797: 
798:     *--------------------------------------------------------------------------
799:     * FormatarGridLista - Formata visual do grid
800:     *--------------------------------------------------------------------------
801:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
802:         WITH par_oGrid
803:             .FontName = "Tahoma"
804:             .FontSize = 8
805:         ENDWITH
806:     ENDPROC
807: 
808:     *==========================================================================
809:     * Handlers dos botoes CRUD (PUBLIC para BINDEVENT funcionar)
810:     *==========================================================================
811: 
812:     *--------------------------------------------------------------------------
813:     * BtnIncluirClick - Insere nova linha vazia no cursor local
814:     *--------------------------------------------------------------------------
815:     PROCEDURE BtnIncluirClick()
816:         LOCAL loc_lSucesso
817:         loc_lSucesso = .F.
818: 
819:         TRY
820:             IF THIS.this_oBusinessObject.InserirLinhaLocal(THIS.this_cEmpDopNums)
821:                 SELECT cursor_4c_LocalCtMoe
822:                 GO BOTTOM
823:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
824:                 THIS.this_cModoAtual = "INCLUIR"
825:                 THIS.LimparCampos()
826:                 THIS.HabilitarCampos(.T.)
827:                 loc_lSucesso = .T.
828:             ENDIF
829:         CATCH TO loc_oErro
830:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BtnIncluirClick")
831:         ENDTRY
832: 
833:         IF loc_lSucesso
834:             THIS.AlternarPagina(2)
835:         ENDIF
836:     ENDPROC
837: 
838:     *--------------------------------------------------------------------------
839:     * BtnVisualizarClick - Navega para Page2 exibindo dados da linha selecionada
840:     *--------------------------------------------------------------------------
841:     PROCEDURE BtnVisualizarClick()
842:         IF USED("cursor_4c_LocalCtMoe") AND !EOF("cursor_4c_LocalCtMoe") AND ;
843:            !DELETED("cursor_4c_LocalCtMoe")
844:             THIS.this_cModoAtual = "VISUALIZAR"
845:             THIS.BOParaForm()
846:             THIS.HabilitarCampos(.F.)
847:             THIS.AlternarPagina(2)
848:         ELSE
849:             MsgAviso("Nenhum registro selecionado para visualizar.", "Visualizar")
850:         ENDIF
851:     ENDPROC
852: 
853:     *--------------------------------------------------------------------------
854:     * BtnAlterarClick - Posiciona foco no grid para edicao inline
855:     *--------------------------------------------------------------------------
856:     PROCEDURE BtnAlterarClick()
857:         IF USED("cursor_4c_LocalCtMoe") AND !EOF("cursor_4c_LocalCtMoe") AND ;
858:            !DELETED("cursor_4c_LocalCtMoe")
859:             THIS.this_cModoAtual = "ALTERAR"
860:             THIS.BOParaForm()
861:             THIS.HabilitarCampos(.T.)
862:             THIS.AlternarPagina(2)
863:         ELSE
864:             MsgAviso("Nenhum registro selecionado para alterar.", "Alterar")
865:         ENDIF
866:     ENDPROC
867: 
868:     *--------------------------------------------------------------------------
869:     * BtnExcluirClick - Exclui linha corrente do cursor local
870:     *--------------------------------------------------------------------------
871:     PROCEDURE BtnExcluirClick()
872:         TRY
873:             IF !USED("cursor_4c_LocalCtMoe") OR EOF("cursor_4c_LocalCtMoe")
874:                 MsgAviso("Nenhum registro selecionado para excluir.", "Excluir")
875:             ELSE
876:                 IF MsgConfirma("Deseja excluir a cota" + CHR(231) + CHR(227) + ;
877:                                "o selecionada?", ;
878:                                "Confirmar Exclus" + CHR(227) + "o")
879:                 IF THIS.this_oBusinessObject.ExcluirLinhaLocal()
880:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
881:                 ENDIF
882:                 ENDIF
883:             ENDIF
884:         CATCH TO loc_oErro
885:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BtnExcluirClick")
886:         ENDTRY
887:     ENDPROC
888: 
889:     *--------------------------------------------------------------------------
890:     * BtnBuscarClick - Abre picker de moeda e posiciona no grid
891:     *--------------------------------------------------------------------------
892:     PROCEDURE BtnBuscarClick()
893:         LOCAL loc_oBusca, loc_cCmoes
894:         loc_cCmoes = ""
895: 
896:         TRY
897:             IF USED("cursor_4c_BuscaMoeda")
898:                 USE IN cursor_4c_BuscaMoeda
899:             ENDIF
900: 
901:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
902:                             "SigCdMoe", "cursor_4c_BuscaMoeda", ;
903:                             "cmoes", "", "Selecionar Moeda")
904: 
905:             IF VARTYPE(loc_oBusca) = "O"
906:                 loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
907:                 loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
908:                 loc_oBusca.Show()
909: 
910:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
911:                     SELECT cursor_4c_BuscaMoeda
912:                     loc_cCmoes = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
913:                 ENDIF
914:                 loc_oBusca.Release()
915:             ENDIF
916:         CATCH TO loc_oErro
917:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BtnBuscarClick")
918:         ENDTRY
919: 
920:         IF !EMPTY(loc_cCmoes) AND USED("cursor_4c_LocalCtMoe")
921:             SELECT cursor_4c_LocalCtMoe
922:             LOCATE FOR ALLTRIM(UPPER(cmoes)) == UPPER(loc_cCmoes) AND !DELETED()
923:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
924:         ENDIF
925: 
926:         IF USED("cursor_4c_BuscaMoeda")
927:             USE IN cursor_4c_BuscaMoeda
928:         ENDIF
929:     ENDPROC
930: 
931:     *--------------------------------------------------------------------------
932:     * BtnEncerrarClick - Valida, salva cotacoes e fecha o formulario
933:     * Equivalente ao cmdSair.Click do legado (SIGPRCTC)
934:     *--------------------------------------------------------------------------
935:     PROCEDURE BtnEncerrarClick()
936:         LOCAL loc_lPodeSair, loc_lHouveAlteracao
937:         loc_lPodeSair       = .F.
938:         loc_lHouveAlteracao = THIS.this_oBusinessObject.this_lHouveInsercao OR ;
939:                               THIS.this_oBusinessObject.this_lHouveExclusao
940: 
941:         TRY
942:             IF loc_lHouveAlteracao
943:                 IF THIS.this_oBusinessObject.SalvarCotacoes(THIS.this_cEmpDopNums)
944:                     THIS.this_lHouveInsercao = THIS.this_oBusinessObject.this_lHouveInsercao
945:                     THIS.this_lHouveExclusao = THIS.this_oBusinessObject.this_lHouveExclusao
946:                     loc_lPodeSair = .T.
947:                 ENDIF
948:             ELSE
949:                 loc_lPodeSair = .T.
950:             ENDIF
951:         CATCH TO loc_oErro
952:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
953:                     "Erro BtnEncerrarClick")
954:         ENDTRY
955: 
956:         IF loc_lPodeSair
957:             THIS.Release()
958:         ENDIF
959:     ENDPROC
960: 
961:     *--------------------------------------------------------------------------
962:     * GrdDadosAfterRowColChange - Valida moeda ao sair da Coluna 1
963:     * par_nColIndex: coluna ANTERIOR (ativa antes da mudanca de coluna)
964:     *--------------------------------------------------------------------------
965:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
966:         LOCAL loc_cCmoes
967:         loc_cCmoes = ""
968: 
969:         TRY
970:             IF par_nColIndex = 1 AND USED("cursor_4c_LocalCtMoe") AND ;
971:                !EOF("cursor_4c_LocalCtMoe") AND !DELETED("cursor_4c_LocalCtMoe")
972:                 SELECT cursor_4c_LocalCtMoe
973:                 loc_cCmoes = ALLTRIM(cmoes)
974:                 IF EMPTY(loc_cCmoes)
975:                     REPLACE Descrs WITH SPACE(15)
976:                 ELSE
977:                     THIS.AbrirBuscaMoeda(loc_cCmoes)
978:                 ENDIF
979:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
980:             ENDIF
981:         CATCH TO loc_oErro
982:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
983:                     "Erro GrdDadosAfterRowColChange")
984:         ENDTRY
985:     ENDPROC
986: 
987:     *--------------------------------------------------------------------------
988:     * AbrirBuscaMoeda - Valida codigo ou abre picker para selecao de moeda
989:     * Equivalente ao Valid do Column1.Text1 do legado (fwbuscaext -> SigCdMoe)
990:     *--------------------------------------------------------------------------
991:     PROTECTED PROCEDURE AbrirBuscaMoeda(par_cValor)
992:         LOCAL loc_oBusca, loc_cCmoes, loc_cDescrs
993:         loc_cCmoes  = ""
994:         loc_cDescrs = ""
995: 
996:         TRY
997:             IF USED("cursor_4c_BuscaMoeda")
998:                 USE IN cursor_4c_BuscaMoeda
999:             ENDIF
1000: 
1001:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1002:                             "SigCdMoe", "cursor_4c_BuscaMoeda", ;
1003:                             "cmoes", ALLTRIM(par_cValor), "Moeda")
1004: 
1005:             IF VARTYPE(loc_oBusca) = "O"
1006:                 IF loc_oBusca.this_lAchouRegistro AND loc_oBusca.this_lSelecionou
1007:                     IF USED("cursor_4c_BuscaMoeda")
1008:                         SELECT cursor_4c_BuscaMoeda
1009:                         loc_cCmoes  = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
1010:                         loc_cDescrs = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
1011:                     ENDIF
1012:                 ELSE
1013:                     IF !loc_oBusca.this_lAchouRegistro
1014:                     loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
1015:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1016:                     loc_oBusca.Show()
1017:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
1018:                         SELECT cursor_4c_BuscaMoeda
1019:                         loc_cCmoes  = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
1020:                         loc_cDescrs = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
1021:                     ENDIF
1022:                     ENDIF
1023:                 ENDIF
1024:                 loc_oBusca.Release()
1025:             ENDIF
1026:         CATCH TO loc_oErro
1027:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro AbrirBuscaMoeda")
1028:         ENDTRY
1029: 
1030:         IF !EMPTY(loc_cCmoes) AND USED("cursor_4c_LocalCtMoe") AND ;
1031:            !EOF("cursor_4c_LocalCtMoe") AND !DELETED("cursor_4c_LocalCtMoe")
1032:             SELECT cursor_4c_LocalCtMoe
1033:             REPLACE cmoes  WITH PADR(loc_cCmoes,  3)
1034:             REPLACE Descrs WITH PADR(loc_cDescrs, 15)
1035:         ENDIF
1036: 
1037:         IF USED("cursor_4c_BuscaMoeda")
1038:             USE IN cursor_4c_BuscaMoeda
1039:         ENDIF
1040:     ENDPROC
1041: 
1042:     *--------------------------------------------------------------------------
1043:     * BtnSalvarClick - Persiste campos da Page2 no cursor local e volta para lista
1044:     *--------------------------------------------------------------------------
1045:     PROCEDURE BtnSalvarClick()
1046:         LOCAL loc_cCmoes, loc_nValos, loc_oPg2
1047:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1048:         loc_cCmoes = ""
1049:         loc_nValos = 0
1050: 
1051:         *-- Em modo visualizar, apenas volta para lista (botao vira "Fechar")
1052:         IF THIS.this_cModoAtual = "VISUALIZAR"
1053:             THIS.HabilitarCampos(.T.)
1054:             THIS.AlternarPagina(1)
1055:             THIS.CarregarLista()
1056:             RETURN
1057:         ENDIF
1058: 
1059:         IF PEMSTATUS(loc_oPg2, "txt_4c_Cmoes", 5)
1060:             loc_cCmoes = ALLTRIM(loc_oPg2.txt_4c_Cmoes.Value)
1061:         ENDIF
1062:         IF PEMSTATUS(loc_oPg2, "txt_4c_Valos", 5)
1063:             loc_nValos = loc_oPg2.txt_4c_Valos.Value
1064:         ENDIF
1065: 
1066:         IF EMPTY(loc_cCmoes)
1067:             MsgAviso("C" + CHR(243) + "digo da moeda obrigat" + CHR(243) + "rio.", "Salvar")
1068:         ELSE
1069:             IF USED("cursor_4c_LocalCtMoe") AND !EOF("cursor_4c_LocalCtMoe") AND ;
1070:                !DELETED("cursor_4c_LocalCtMoe")
1071:             THIS.FormParaBO()
1072:             THIS.this_oBusinessObject.this_lHouveInsercao = .T.
1073:             THIS.AlternarPagina(1)
1074:             THIS.CarregarLista()
1075:             ENDIF
1076:         ENDIF
1077:     ENDPROC
1078: 
1079:     *--------------------------------------------------------------------------
1080:     * BtnCancelarClick - Cancela edicao e volta para lista sem salvar
1081:     *--------------------------------------------------------------------------
1082:     PROCEDURE BtnCancelarClick()
1083:         THIS.AlternarPagina(1)
1084:         THIS.CarregarLista()
1085:     ENDPROC
1086: 
1087:     *--------------------------------------------------------------------------
1088:     * BOParaForm - Carrega linha corrente do cursor local nos campos da Page2
1089:     *--------------------------------------------------------------------------
1090:     PROTECTED PROCEDURE BOParaForm()
1091:         LOCAL loc_oPg2, loc_cCmoes, loc_cDescrs, loc_nValos
1092:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1093:         loc_cCmoes  = ""
1094:         loc_cDescrs = ""
1095:         loc_nValos  = 0
1096: 
1097:         TRY
1098:             IF USED("cursor_4c_LocalCtMoe") AND !EOF("cursor_4c_LocalCtMoe") AND ;
1099:                !DELETED("cursor_4c_LocalCtMoe")
1100:                 SELECT cursor_4c_LocalCtMoe
1101:                 loc_cCmoes  = ALLTRIM(NVL(cmoes,  ""))
1102:                 loc_cDescrs = ALLTRIM(NVL(Descrs, ""))
1103:                 loc_nValos  = NVL(valos, 0)
1104:             ENDIF
1105: 
1106:             IF PEMSTATUS(loc_oPg2, "txt_4c_Cmoes", 5)
1107:                 loc_oPg2.txt_4c_Cmoes.Value = loc_cCmoes
1108:             ENDIF
1109:             IF PEMSTATUS(loc_oPg2, "txt_4c_Descrs", 5)
1110:                 loc_oPg2.txt_4c_Descrs.Value = loc_cDescrs
1111:             ENDIF
1112:             IF PEMSTATUS(loc_oPg2, "txt_4c_Valos", 5)
1113:                 loc_oPg2.txt_4c_Valos.Value = loc_nValos
1114:             ENDIF
1115:         CATCH TO loc_oErro
1116:             MsgErro("Erro em BOParaForm:" + CHR(13) + loc_oErro.Message + ;
1117:                     " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
1118:         ENDTRY
1119:     ENDPROC
1120: 
1121:     *--------------------------------------------------------------------------
1122:     * FormParaBO - Transfere campos editados da Page2 de volta para cursor local
1123:     *--------------------------------------------------------------------------
1124:     PROTECTED PROCEDURE FormParaBO()
1125:         LOCAL loc_oPg2, loc_cCmoes, loc_nValos
1126:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1127:         loc_cCmoes = ""
1128:         loc_nValos = 0
1129: 
1130:         TRY
1131:             IF PEMSTATUS(loc_oPg2, "txt_4c_Cmoes", 5)
1132:                 loc_cCmoes = ALLTRIM(loc_oPg2.txt_4c_Cmoes.Value)
1133:             ENDIF
1134:             IF PEMSTATUS(loc_oPg2, "txt_4c_Valos", 5)
1135:                 loc_nValos = loc_oPg2.txt_4c_Valos.Value
1136:             ENDIF
1137: 
1138:             IF USED("cursor_4c_LocalCtMoe") AND !EOF("cursor_4c_LocalCtMoe") AND ;
1139:                !DELETED("cursor_4c_LocalCtMoe")
1140:                 SELECT cursor_4c_LocalCtMoe
1141:                 REPLACE cmoes WITH PADR(loc_cCmoes, 3), valos WITH loc_nValos
1142:             ENDIF
1143:         CATCH TO loc_oErro
1144:             MsgErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message + ;
1145:                     " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
1146:         ENDTRY
1147:     ENDPROC
1148: 
1149:     *--------------------------------------------------------------------------
1150:     * CmoesLookupKeyPress - Handler de KeyPress do txt_4c_Cmoes (Page2)
1151:     * Abre picker de moeda ao pressionar F4 (keycode 28)
1152:     *--------------------------------------------------------------------------
1153:     PROCEDURE CmoesLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1154:         IF par_nKeyCode = 28
1155:             THIS.AbrirBuscaMoedaPage2()
1156:         ENDIF
1157:     ENDPROC
1158: 
1159:     *--------------------------------------------------------------------------
1160:     * CmoesLookupDblClick - Handler de DblClick do txt_4c_Cmoes (Page2)
1161:     *--------------------------------------------------------------------------
1162:     PROCEDURE CmoesLookupDblClick()
1163:         THIS.AbrirBuscaMoedaPage2()
1164:     ENDPROC
1165: 
1166:     *--------------------------------------------------------------------------
1167:     * CmoesLostFocus - Handler de LostFocus do txt_4c_Cmoes (Page2)
1168:     * Valida o codigo digitado e atualiza descricao; se vazio, limpa descricao
1169:     *--------------------------------------------------------------------------
1170:     PROCEDURE CmoesLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1171:         LOCAL loc_oPg2, loc_cCmoes
1172:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1173:         loc_cCmoes = ""
1174: 
1175:         TRY
1176:             IF PEMSTATUS(loc_oPg2, "txt_4c_Cmoes", 5)
1177:                 loc_cCmoes = ALLTRIM(loc_oPg2.txt_4c_Cmoes.Value)
1178:             ENDIF
1179: 
1180:             IF EMPTY(loc_cCmoes)
1181:                 IF PEMSTATUS(loc_oPg2, "txt_4c_Descrs", 5)
1182:                     loc_oPg2.txt_4c_Descrs.Value = ""
1183:                 ENDIF
1184:             ELSE
1185:                 THIS.AbrirBuscaMoedaPage2()
1186:             ENDIF
1187:         CATCH TO loc_oErro
1188:             MsgErro("Erro em CmoesLostFocus:" + CHR(13) + loc_oErro.Message + ;
1189:                     " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
1190:         ENDTRY
1191:     ENDPROC
1192: 
1193:     *--------------------------------------------------------------------------
1194:     * AbrirBuscaMoedaPage2 - Valida/busca moeda e preenche campos na Page2
1195:     * Equivalente ao Valid de GradeSubN.Column1.Text1 do SIGPRCTC original
1196:     * adaptado para uso em Page2 (fora do grid)
1197:     *--------------------------------------------------------------------------
1198:     PROTECTED PROCEDURE AbrirBuscaMoedaPage2()
1199:         LOCAL loc_oPg2, loc_cCmoes, loc_oBusca, loc_cDescrs, loc_lExecutar
1200:         loc_oPg2      = THIS.pgf_4c_Paginas.Page2
1201:         loc_cCmoes    = ""
1202:         loc_cDescrs   = ""
1203:         loc_lExecutar = .F.
1204: 
1205:         IF PEMSTATUS(loc_oPg2, "txt_4c_Cmoes", 5)
1206:             loc_cCmoes = ALLTRIM(loc_oPg2.txt_4c_Cmoes.Value)
1207:         ENDIF
1208: 
1209:         IF !EMPTY(loc_cCmoes)
1210:             loc_lExecutar = .T.
1211:         ENDIF
1212: 
1213:         IF loc_lExecutar
1214:             TRY
1215:                 IF USED("cursor_4c_BuscaMoeda")
1216:                     USE IN cursor_4c_BuscaMoeda
1217:                 ENDIF
1218: 
1219:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1220:                                 "SigCdMoe", "cursor_4c_BuscaMoeda", ;
1221:                                 "cmoes", loc_cCmoes, "Moeda")
1222: 
1223:                 IF VARTYPE(loc_oBusca) = "O"
1224:                     IF loc_oBusca.this_lAchouRegistro AND loc_oBusca.this_lSelecionou
1225:                         IF USED("cursor_4c_BuscaMoeda")
1226:                             SELECT cursor_4c_BuscaMoeda
1227:                             loc_cCmoes  = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
1228:                             loc_cDescrs = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
1229:                         ENDIF
1230:                     ELSE
1231:                         IF !loc_oBusca.this_lAchouRegistro
1232:                         loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
1233:                         loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1234:                         loc_oBusca.Show()
1235:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
1236:                             SELECT cursor_4c_BuscaMoeda
1237:                             loc_cCmoes  = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
1238:                             loc_cDescrs = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
1239:                         ENDIF
1240:                         ENDIF
1241:                     ENDIF
1242:                     loc_oBusca.Release()
1243:                 ENDIF
1244:             CATCH TO loc_oErro
1245:                 MsgErro("Erro em AbrirBuscaMoedaPage2:" + CHR(13) + loc_oErro.Message + ;
1246:                         " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
1247:             ENDTRY
1248: 
1249:             IF !EMPTY(loc_cCmoes) AND PEMSTATUS(loc_oPg2, "txt_4c_Cmoes", 5)
1250:                 loc_oPg2.txt_4c_Cmoes.Value = loc_cCmoes
1251:             ENDIF
1252:             IF PEMSTATUS(loc_oPg2, "txt_4c_Descrs", 5)
1253:                 loc_oPg2.txt_4c_Descrs.Value = loc_cDescrs
1254:             ENDIF
1255: 
1256:             IF USED("cursor_4c_BuscaMoeda")
1257:                 USE IN cursor_4c_BuscaMoeda
1258:             ENDIF
1259:         ENDIF
1260:     ENDPROC
1261: 
1262:     *--------------------------------------------------------------------------
1263:     * LimparCampos - Limpa todos os campos editaveis da Page2
1264:     *--------------------------------------------------------------------------
1265:     PROTECTED PROCEDURE LimparCampos()
1266:         LOCAL loc_oPg2
1267:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1268: 
1269:         TRY
1270:             IF PEMSTATUS(loc_oPg2, "txt_4c_Cmoes", 5)
1271:                 loc_oPg2.txt_4c_Cmoes.Value = ""
1272:             ENDIF
1273:             IF PEMSTATUS(loc_oPg2, "txt_4c_Descrs", 5)
1274:                 loc_oPg2.txt_4c_Descrs.Value = ""
1275:             ENDIF
1276:             IF PEMSTATUS(loc_oPg2, "txt_4c_Valos", 5)
1277:                 loc_oPg2.txt_4c_Valos.Value = 0
1278:             ENDIF
1279:         CATCH TO loc_oErro
1280:             MsgErro("Erro em LimparCampos:" + CHR(13) + loc_oErro.Message + ;
1281:                     " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
1282:         ENDTRY
1283:     ENDPROC
1284: 
1285:     *--------------------------------------------------------------------------
1286:     * HabilitarCampos - Habilita ou desabilita campos editaveis da Page2
1287:     * par_lHabilitar: .T. = editar (INCLUIR/ALTERAR), .F. = somente leitura (VISUALIZAR)
1288:     * Em VISUALIZAR: muda botao Confirmar para "Fechar" com icone de saida
1289:     *--------------------------------------------------------------------------
1290:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1291:         LOCAL loc_oPg2
1292:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1293: 
1294:         TRY
1295:             IF PEMSTATUS(loc_oPg2, "txt_4c_Cmoes", 5)
1296:                 loc_oPg2.txt_4c_Cmoes.Enabled   = par_lHabilitar
1297:                 loc_oPg2.txt_4c_Cmoes.BackColor = IIF(par_lHabilitar, ;
1298:                                                        RGB(255,255,255), RGB(240,240,240))
1299:             ENDIF
1300:             IF PEMSTATUS(loc_oPg2, "txt_4c_Valos", 5)
1301:                 loc_oPg2.txt_4c_Valos.Enabled   = par_lHabilitar
1302:                 loc_oPg2.txt_4c_Valos.BackColor = IIF(par_lHabilitar, ;
1303:                                                        RGB(255,255,255), RGB(240,240,240))
1304:             ENDIF
1305:             IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
1306:                 IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1307:                     IF par_lHabilitar
1308:                         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Caption = "Confirmar"
1309:                         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Picture = ;
1310:                             gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
1311:                     ELSE
1312:                         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Caption = "Fechar"
1313:                         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Picture = ;
1314:                             gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1315:                     ENDIF
1316:                 ENDIF
1317:             ENDIF
1318:         CATCH TO loc_oErro
1319:             MsgErro("Erro em HabilitarCampos:" + CHR(13) + loc_oErro.Message + ;
1320:                     " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
1321:         ENDTRY
1322:     ENDPROC
1323: 
1324:     *--------------------------------------------------------------------------
1325:     * AjustarBotoesPorModo - Habilita/desabilita botoes conforme estado do cursor
1326:     * Chamado apos CarregarLista() para refletir se ha registros selecionaveis
1327:     *--------------------------------------------------------------------------
1328:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1329:         LOCAL loc_oPg1, loc_lTemRegistro, loc_lPodeInserir, loc_lPodeExcluir
1330:         loc_oPg1         = THIS.pgf_4c_Paginas.Page1
1331:         loc_lTemRegistro = USED("cursor_4c_LocalCtMoe") AND !EOF("cursor_4c_LocalCtMoe") AND ;
1332:                            RECCOUNT("cursor_4c_LocalCtMoe") > 0
1333:         loc_lPodeInserir = .T.
1334:         loc_lPodeExcluir = .T.
1335: 
1336:         TRY
1337:             IF !EMPTY(THIS.this_cEscolha)
1338:                 loc_lPodeInserir = INLIST(UPPER(ALLTRIM(THIS.this_cEscolha)), "INSERIR", "ALTERAR")
1339:                 loc_lPodeExcluir = INLIST(UPPER(ALLTRIM(THIS.this_cEscolha)), "INSERIR", "ALTERAR")
1340:             ENDIF
1341: 
1342:             IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
1343:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled = loc_lPodeInserir
1344:             ENDIF
1345:             IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
1346:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
1347:             ENDIF
1348:             IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
1349:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled = loc_lTemRegistro
1350:             ENDIF
1351:             IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
1352:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled = loc_lTemRegistro AND loc_lPodeExcluir
1353:             ENDIF
1354:             IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Buscar", 5)
1355:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled = .T.
1356:             ENDIF
1357:         CATCH TO loc_oErro
1358:             MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message + ;
1359:                     " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
1360:         ENDTRY
1361:     ENDPROC
1362: 
1363:     *--------------------------------------------------------------------------
1364:     * ControlarBotoesPorEscolha - Exibe/oculta Incluir e Excluir conforme pcEscolha
1365:     * Equivalente ao mCtrlBotoes + fChecaAcesso do SIGPRCTC original:
1366:     * Se pcEscolha = 'INSERIR' ou 'ALTERAR': mostra Incluir e Excluir
1367:     * Se pcEscolha = 'EXCLUIR' ou outro: oculta ambos
1368:     * Se pcEscolha = '' (nao fornecido): mostra ambos (modo standalone)
1369:     *--------------------------------------------------------------------------
1370:     PROTECTED PROCEDURE ControlarBotoesPorEscolha()
1371:         LOCAL loc_oPg1, loc_lPodeInserir, loc_lPodeExcluir
1372:         loc_oPg1         = THIS.pgf_4c_Paginas.Page1
1373:         loc_lPodeInserir = .T.
1374:         loc_lPodeExcluir = .T.
1375: 
1376:         TRY
1377:             IF !EMPTY(THIS.this_cEscolha)
1378:                 loc_lPodeInserir = INLIST(UPPER(ALLTRIM(THIS.this_cEscolha)), ;
1379:                                           "INSERIR", "ALTERAR")
1380:                 loc_lPodeExcluir = INLIST(UPPER(ALLTRIM(THIS.this_cEscolha)), ;
1381:                                           "INSERIR", "ALTERAR")
1382:             ENDIF
1383: 
1384:             IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
1385:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Visible = loc_lPodeInserir
1386:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled = loc_lPodeInserir
1387:             ENDIF
1388:             IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
1389:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Visible = loc_lPodeExcluir
1390:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled = loc_lPodeExcluir
1391:             ENDIF
1392:         CATCH TO loc_oErro
1393:             MsgErro("Erro em ControlarBotoesPorEscolha:" + CHR(13) + loc_oErro.Message + ;
1394:                     " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
1395:         ENDTRY
1396:     ENDPROC
1397: 
1398: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrCtcBO.prg):
*==============================================================================
* SigPrCtcBO.prg - Business Object para Cotacoes por Operacoes
* Herda de BusinessBase
* Tabela principal: sigprctc
* PK: pkchaves (char 20)
* Fase 1: Propriedades e Init()
*==============================================================================

DEFINE CLASS SigPrCtcBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Identificador composto da operacao (pcEmps + pcDopes + STR(pnNumes,6))
    * Chave de agrupamento de todas as cotacoes da operacao
    *--------------------------------------------------------------------------
    this_cEmpDopNums = ""    && empdopnums char(29) - chave da operacao

    *--------------------------------------------------------------------------
    * Campos da linha corrente de sigprctc
    *--------------------------------------------------------------------------
    this_cCmoes      = ""    && cmoes    char(3)       - codigo da moeda (FK SigCdMoe)
    this_nValos      = 0     && valos    numeric(11,6) - cotacao da moeda
    this_cPkChaves   = ""    && pkchaves char(20)      - chave primaria (PK)
    this_dDtalts     = {}    && dtalts   datetime NULL - data/hora alteracao
    this_cUsuars     = ""    && usuars   char(10)      - usuario que gravou

    *--------------------------------------------------------------------------
    * Campo auxiliar vindo do JOIN com SigCdMoe (nao persistido em sigprctc)
    *--------------------------------------------------------------------------
    this_cDescrs     = ""    && dmoes char(15) - descricao da moeda (SigCdMoe.dmoes)

    *--------------------------------------------------------------------------
    * Controle interno de estado da colecao
    *--------------------------------------------------------------------------
    this_lHouveInsercao  = .F.  && .T. se alguma linha foi inserida na sessao
    this_lHouveExclusao  = .F.  && .T. se alguma linha foi removida na sessao

    *==========================================================================
    * Init - Configura tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela     = "sigprctc"
            THIS.this_cCampoChave = "pkchaves"

            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCtcBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da chave primaria (auditoria)
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades de uma linha do cursor
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmpDopNums = TratarNulo(empdopnums, "C")
                THIS.this_cCmoes      = TratarNulo(cmoes,      "C")
                THIS.this_nValos      = TratarNulo(valos,      "N")
                THIS.this_cPkChaves   = TratarNulo(pkchaves,   "C")
                THIS.this_cDescrs     = TratarNulo(Descrs,     "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarParaEdicao - Carrega cotacoes da operacao em cursor VFP local
    * par_cEmpDopNums: chave da operacao (emps+dopes+numes, 29 chars)
    * Cria cursor_4c_LocalCtMoe para edicao em memoria
    *==========================================================================
    PROCEDURE CarregarParaEdicao(par_cEmpDopNums)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_LocalCtMoe")
                USE IN cursor_4c_LocalCtMoe
            ENDIF
            IF USED("cursor_4c_CtMoeTemp")
                USE IN cursor_4c_CtMoeTemp
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_LocalCtMoe ;
                (empdopnums C(29), cmoes C(3), valos N(11,6), pkchaves C(20), Descrs C(15))
            SET NULL OFF

            loc_cSQL = "SELECT a.empdopnums, a.cmoes, a.valos, a.pkchaves," + ;
                       " ISNULL(b.dmoes,'') AS Descrs" + ;
                       " FROM sigprctc a" + ;
                       " LEFT JOIN SigCdMoe b ON b.cmoes = a.cmoes" + ;
                       " WHERE a.empdopnums = " + EscaparSQL(ALLTRIM(par_cEmpDopNums))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CtMoeTemp")

            IF loc_nResult > 0 AND USED("cursor_4c_CtMoeTemp") AND RECCOUNT("cursor_4c_CtMoeTemp") > 0
                SELECT cursor_4c_LocalCtMoe
                APPEND FROM DBF("cursor_4c_CtMoeTemp")
            ENDIF

            IF USED("cursor_4c_CtMoeTemp")
                USE IN cursor_4c_CtMoeTemp
            ENDIF

            SELECT cursor_4c_LocalCtMoe
            GO TOP

            THIS.this_lHouveInsercao = .F.
            THIS.this_lHouveExclusao = .F.

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarParaEdicao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InserirLinhaLocal - Insere nova linha em branco no cursor local
    * par_cEmpDopNums: chave da operacao para preencher o campo de agrupamento
    *==========================================================================
    PROCEDURE InserirLinhaLocal(par_cEmpDopNums)
        LOCAL loc_lSucesso, loc_cPkChave
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_LocalCtMoe")
                MsgErro("Cursor de edi" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o iniciado.", "Erro")
            ELSE
                SELECT cursor_4c_LocalCtMoe
                LOCATE FOR EMPTY(cmoes) AND !DELETED()
                IF EOF()
                    loc_cPkChave = LEFT(SYS(2015) + PADR(TRANSFORM(RECCOUNT("cursor_4c_LocalCtMoe") + 1), 10, "0"), 20)
                    INSERT INTO cursor_4c_LocalCtMoe (empdopnums, cmoes, valos, pkchaves, Descrs) ;
                        VALUES (ALLTRIM(par_cEmpDopNums), SPACE(3), 0, loc_cPkChave, SPACE(15))
                    GO BOTTOM
                ELSE
                    GO RECNO()
                ENDIF
                THIS.this_lHouveInsercao = .T.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro InserirLinhaLocal")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExcluirLinhaLocal - Remove linha corrente do cursor local (marca deleted)
    *==========================================================================
    PROCEDURE ExcluirLinhaLocal()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_LocalCtMoe")
                MsgErro("Cursor de edi" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o iniciado.", "Erro")
            ELSE
                IF !EOF("cursor_4c_LocalCtMoe")
                SELECT cursor_4c_LocalCtMoe
                DELETE
                SKIP
                IF EOF()
                    SKIP -1
                ENDIF
                THIS.this_lHouveExclusao = .T.
                loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ExcluirLinhaLocal")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDuplicidade - Verifica se ha moedas duplicadas no cursor local
    * Retorna .T. se valido (sem duplicatas), .F. se ha moedas repetidas
    *==========================================================================
    PROCEDURE ValidarDuplicidade()
        LOCAL loc_lValido, loc_cMoesDup
        loc_lValido  = .F.
        loc_cMoesDup = ""

        TRY
            IF !USED("cursor_4c_LocalCtMoe")
                MsgErro("Cursor de edi" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o iniciado.", "Erro")
            ELSE
                IF USED("cursor_4c_Totais")
                    USE IN cursor_4c_Totais
                ENDIF

                SELECT cmoes, SUM(1) AS tt FROM cursor_4c_LocalCtMoe ;
                    WHERE !DELETED() AND !EMPTY(ALLTRIM(cmoes)) ;
                    GROUP BY cmoes ;
                    INTO CURSOR cursor_4c_Totais

                IF USED("cursor_4c_Totais")
                    SELECT cursor_4c_Totais
                    SCAN
                        IF tt > 1
                            IF !EMPTY(loc_cMoesDup)
                                loc_cMoesDup = loc_cMoesDup + ", "
                            ENDIF
                            loc_cMoesDup = loc_cMoesDup + ALLTRIM(cmoes)
                        ENDIF
                    ENDSCAN
                    USE IN cursor_4c_Totais
                ENDIF

                IF !EMPTY(loc_cMoesDup)
                    MsgErro("Moeda(s) digitada(s) em duplicidade: " + loc_cMoesDup, ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lValido = .F.
                ELSE
                    loc_lValido = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ValidarDuplicidade")
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * BuscarMoeda - Busca moeda por codigo em SigCdMoe
    * par_cCodigo: codigo da moeda (cmoes)
    * Popula cursor_4c_BuscaMoeda; retorna .T. se encontrou codigo exato
    *==========================================================================
    PROCEDURE BuscarMoeda(par_cCodigo)
        LOCAL loc_lEncontrou, loc_cSQL, loc_nResult
        loc_lEncontrou = .F.

        TRY
            IF USED("cursor_4c_BuscaMoeda")
                USE IN cursor_4c_BuscaMoeda
            ENDIF

            loc_cSQL = "SELECT cmoes, dmoes AS Descrs FROM SigCdMoe" + ;
                       " WHERE cmoes LIKE " + EscaparSQL(ALLTRIM(par_cCodigo) + "%") + ;
                       " ORDER BY cmoes"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoeda")

            IF loc_nResult > 0 AND USED("cursor_4c_BuscaMoeda") AND RECCOUNT("cursor_4c_BuscaMoeda") > 0
                SELECT cursor_4c_BuscaMoeda
                GO TOP
                IF RECCOUNT("cursor_4c_BuscaMoeda") = 1 AND ;
                   UPPER(ALLTRIM(cursor_4c_BuscaMoeda.cmoes)) == UPPER(ALLTRIM(par_cCodigo))
                    THIS.this_cCmoes  = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
                    THIS.this_cDescrs = ALLTRIM(cursor_4c_BuscaMoeda.Descrs)
                    loc_lEncontrou = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BuscarMoeda")
        ENDTRY

        RETURN loc_lEncontrou
    ENDPROC

    *==========================================================================
    * AtualizarDescricaoMoeda - Atualiza campo Descrs na linha corrente do cursor local
    *==========================================================================
    PROCEDURE AtualizarDescricaoMoeda(par_cDescrs)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_LocalCtMoe") AND !EOF("cursor_4c_LocalCtMoe")
                SELECT cursor_4c_LocalCtMoe
                REPLACE Descrs WITH PADR(ALLTRIM(par_cDescrs), 15)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro AtualizarDescricaoMoeda")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * SalvarCotacoes - Persiste cotacoes no SQL Server (DELETE all + INSERT validas)
    * par_cEmpDopNums: chave da operacao
    * Logica: deleta todos da operacao, re-insere linhas validas do cursor local
    *==========================================================================
    PROCEDURE SalvarCotacoes(par_cEmpDopNums)
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL, loc_nLinha, loc_cPkChave
        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarDuplicidade()
                *-- mensagem ja exibida por ValidarDuplicidade
            ELSE
                IF !USED("cursor_4c_LocalCtMoe")
                MsgErro("Cursor de edi" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o iniciado.", "Erro")
            ELSE
                *-- Passo 1: Remove todos os registros da operacao no SQL Server
                loc_cSQL = "DELETE FROM sigprctc WHERE empdopnums = " + ;
                           EscaparSQL(ALLTRIM(par_cEmpDopNums))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
                IF USED("cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF

                IF loc_nResult < 0
                    MsgErro("Erro ao excluir cota" + CHR(231) + CHR(245) + "es anteriores:" + ;
                            CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    *-- Passo 2: Re-insere todas as linhas validas do cursor local
                    SELECT cursor_4c_LocalCtMoe
                    GO TOP
                    loc_lSucesso = .T.
                    loc_nLinha   = 0

                    SCAN WHILE loc_lSucesso
                        IF DELETED()
                            LOOP
                        ENDIF
                        IF EMPTY(ALLTRIM(cmoes))
                            LOOP
                        ENDIF

                        loc_nLinha   = loc_nLinha + 1
                        loc_cPkChave = LEFT(SYS(2015) + PADR(TRANSFORM(loc_nLinha), 10, "0"), 20)

                        loc_cSQL = "INSERT INTO sigprctc (empdopnums, cmoes, valos, pkchaves, dtalts, usuars)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(ALLTRIM(par_cEmpDopNums)) + "," + ;
                                   EscaparSQL(ALLTRIM(cmoes)) + "," + ;
                                   FormatarNumeroSQL(valos) + "," + ;
                                   EscaparSQL(loc_cPkChave) + "," + ;
                                   "GETDATE()," + ;
                                   EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ;
                                   ")"

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
                        IF USED("cursor_4c_Ins")
                            USE IN cursor_4c_Ins
                        ENDIF

                        IF loc_nResult < 0
                            MsgErro("Erro ao inserir cota" + CHR(231) + CHR(227) + "o da moeda " + ;
                                    ALLTRIM(cmoes) + ":" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                        ENDIF
                    ENDSCAN

                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("SALVAR_COTACOES")
                    ENDIF
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SalvarCotacoes")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

