# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [BINDEVENT-PARAMS] Handler 'ValidarMovAutDop' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarMovAutDop(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormObs.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1499 linhas total):

*-- Linhas 6 a 165:
6: * Tipo: CRUD (frmcadastro)
7: * BO: ObsBO
8: *
9: * Fase 3: DEFINE CLASS + Init + InicializarForm + ConfigurarPageFrame + Destroy
10: *==============================================================================
11: 
12: DEFINE CLASS FormObs AS FormBase
13: 
14:     *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
15:     Height      = 600
16:     Width       = 1000
17:     Caption     = "Cadastro de Observacoes"
18:     AutoCenter  = .T.
19:     ShowWindow  = 1
20:     WindowType  = 1
21:     ControlBox  = .F.
22:     Closable    = .F.
23:     MaxButton   = .F.
24:     TitleBar    = 0
25:     Themes      = .F.
26:     BorderStyle = 2
27:     DataSession = 2
28: 
29:     *-- Propriedades de estado
30:     this_oBusinessObject = .NULL.
31:     this_cModoAtual      = "LISTA"
32: 
33:     *--------------------------------------------------------------------------
34:     * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
35:     *--------------------------------------------------------------------------
36:     PROCEDURE Init()
37:         LOCAL loc_lResultado
38:         loc_lResultado = .F.
39: 
40:         TRY
41:             loc_lResultado = DODEFAULT()
42:         CATCH TO loc_oErro
43:             MsgErro(loc_oErro.Message, "FormObs.Init")
44:         ENDTRY
45: 
46:         RETURN loc_lResultado
47:     ENDPROC
48: 
49:     *--------------------------------------------------------------------------
50:     * InicializarForm - Configura estrutura completa
51:     * Chamado automaticamente pelo FormBase.Init()
52:     *--------------------------------------------------------------------------
53:     PROTECTED PROCEDURE InicializarForm()
54:         LOCAL loc_lResultado
55:         loc_lResultado = .F.
56: 
57:         TRY
58:             THIS.Caption = "Cadastro de Observa" + CHR(231) + CHR(245) + "es"
59: 
60:             THIS.this_oBusinessObject = CREATEOBJECT("ObsBO")
61: 
62:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
63:                 MsgErro("Falha ao criar ObsBO", "Erro")
64:             ELSE
65:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
66:                     SQLEXEC(gnConnHandle, ;
67:                         "SELECT Dopes, Cmoes, nFiscals, Abrevs FROM SigCdOpe" + ;
68:                         " ORDER BY Dopes", ;
69:                         "cursor_4c_Nivel")
70:                 ENDIF
71: 
72:                 THIS.ConfigurarPageFrame()
73: 
74:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
75:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
76: 
77:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
78:                     THIS.CarregarLista()
79:                 ENDIF
80: 
81:                 THIS.pgf_4c_Paginas.Visible  = .T.
82:                 THIS.pgf_4c_Paginas.ActivePage = 1
83:                 THIS.this_cModoAtual = "LISTA"
84:                 loc_lResultado = .T.
85:             ENDIF
86:         CATCH TO loc_oErro
87:             MsgErro(loc_oErro.Message, "FormObs.InicializarForm")
88:         ENDTRY
89: 
90:         RETURN loc_lResultado
91:     ENDPROC
92: 
93:     *--------------------------------------------------------------------------
94:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
95:     *--------------------------------------------------------------------------
96:     PROTECTED PROCEDURE ConfigurarPageFrame()
97:         LOCAL loc_oPgf
98:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
99:         loc_oPgf = THIS.pgf_4c_Paginas
100: 
101:         WITH loc_oPgf
102:             .PageCount = 2
103:             .Top       = -29
104:             .Left      = 0
105:             .Width     = THIS.Width
106:             .Height    = THIS.Height + 29
107:             .Tabs      = .F.
108:             .Visible   = .T.
109:             .Page1.Caption   = "Lista"
110:             .Page1.BackColor = RGB(100, 100, 100)
111:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
112:             .Page2.Caption   = "Dados"
113:             .Page2.BackColor = RGB(100, 100, 100)
114:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
115:         ENDWITH
116: 
117:         THIS.ConfigurarPaginaLista()
118:         THIS.ConfigurarPaginaDados()
119:     ENDPROC
120: 
121:     *--------------------------------------------------------------------------
122:     * ConfigurarPaginaLista - Cria estrutura completa da Page1
123:     * Cabecalho + Botoes CRUD + Grid + Encerrar
124:     *--------------------------------------------------------------------------
125:     PROTECTED PROCEDURE ConfigurarPaginaLista()
126:         LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid
127:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
128: 
129:         *-- Container cabecalho (cntSombra.Top=1 no original + 29 compensacao = 30)
130:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
131:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
132:         WITH loc_oCab
133:             .Top         = 30
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
144:             .AutoSize  = .F.
145:             .Caption   = THIS.Caption
146:             .Top       = 15
147:             .Left      = 10
148:             .Width     = THIS.Width
149:             .Height    = 40
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
160:             .AutoSize  = .F.
161:             .Caption   = THIS.Caption
162:             .Top       = 18
163:             .Left      = 10
164:             .Width     = THIS.Width
165:             .Height    = 46

*-- Linhas 208 a 503:
208:             .AutoSize        = .F.
209:             .Visible         = .T.
210:         ENDWITH
211:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
212: 
213:         *-- Botao Visualizar
214:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
215:         WITH loc_oBotoes.cmd_4c_Visualizar
216:             .Caption         = "Visualizar"
217:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
218:             .PicturePosition = 13
219:             .Top             = 5
220:             .Left            = 80
221:             .Width           = 75
222:             .Height          = 75
223:             .BackColor       = RGB(255, 255, 255)
224:             .ForeColor       = RGB(90, 90, 90)
225:             .FontName        = "Comic Sans MS"
226:             .FontSize        = 8
227:             .FontBold        = .T.
228:             .FontItalic      = .T.
229:             .Themes          = .F.
230:             .SpecialEffect   = 0
231:             .MousePointer    = 15
232:             .WordWrap        = .T.
233:             .AutoSize        = .F.
234:             .Visible         = .T.
235:         ENDWITH
236:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
237: 
238:         *-- Botao Alterar
239:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
240:         WITH loc_oBotoes.cmd_4c_Alterar
241:             .Caption         = "Alterar"
242:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
243:             .PicturePosition = 13
244:             .Top             = 5
245:             .Left            = 155
246:             .Width           = 75
247:             .Height          = 75
248:             .BackColor       = RGB(255, 255, 255)
249:             .ForeColor       = RGB(90, 90, 90)
250:             .FontName        = "Comic Sans MS"
251:             .FontSize        = 8
252:             .FontBold        = .T.
253:             .FontItalic      = .T.
254:             .Themes          = .F.
255:             .SpecialEffect   = 0
256:             .MousePointer    = 15
257:             .WordWrap        = .T.
258:             .AutoSize        = .F.
259:             .Visible         = .T.
260:         ENDWITH
261:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
262: 
263:         *-- Botao Excluir
264:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
265:         WITH loc_oBotoes.cmd_4c_Excluir
266:             .Caption         = "Excluir"
267:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
268:             .PicturePosition = 13
269:             .Top             = 5
270:             .Left            = 230
271:             .Width           = 75
272:             .Height          = 75
273:             .BackColor       = RGB(255, 255, 255)
274:             .ForeColor       = RGB(90, 90, 90)
275:             .FontName        = "Comic Sans MS"
276:             .FontSize        = 8
277:             .FontBold        = .T.
278:             .FontItalic      = .T.
279:             .Themes          = .F.
280:             .SpecialEffect   = 0
281:             .MousePointer    = 15
282:             .WordWrap        = .T.
283:             .AutoSize        = .F.
284:             .Visible         = .T.
285:         ENDWITH
286:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
287: 
288:         *-- Botao Buscar
289:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
290:         WITH loc_oBotoes.cmd_4c_Buscar
291:             .Caption         = "Buscar"
292:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
293:             .PicturePosition = 13
294:             .Top             = 5
295:             .Left            = 305
296:             .Width           = 75
297:             .Height          = 75
298:             .BackColor       = RGB(255, 255, 255)
299:             .ForeColor       = RGB(90, 90, 90)
300:             .FontName        = "Comic Sans MS"
301:             .FontSize        = 8
302:             .FontBold        = .T.
303:             .FontItalic      = .T.
304:             .Themes          = .F.
305:             .SpecialEffect   = 0
306:             .MousePointer    = 15
307:             .WordWrap        = .T.
308:             .AutoSize        = .F.
309:             .Visible         = .T.
310:         ENDWITH
311:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
312: 
313:         *-- Container Encerrar - padrao canonico (CLAUDE.md regra #10)
314:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
315:         loc_oSaida = loc_oPg1.cnt_4c_Saida
316:         WITH loc_oSaida
317:             .Top         = 29
318:             .Left        = 917
319:             .Width       = 90
320:             .Height      = 85
321:             .BackStyle   = 0
322:             .BorderWidth = 0
323:             .Visible     = .T.
324:         ENDWITH
325: 
326:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
327:         WITH loc_oSaida.cmd_4c_Encerrar
328:             .Caption         = "Encerrar"
329:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
330:             .PicturePosition = 13
331:             .Top             = 5
332:             .Left            = 5
333:             .Width           = 75
334:             .Height          = 75
335:             .BackColor       = RGB(255, 255, 255)
336:             .ForeColor       = RGB(90, 90, 90)
337:             .FontName        = "Comic Sans MS"
338:             .FontSize        = 8
339:             .FontBold        = .T.
340:             .FontItalic      = .T.
341:             .Themes          = .F.
342:             .SpecialEffect   = 0
343:             .MousePointer    = 15
344:             .WordWrap        = .T.
345:             .AutoSize        = .F.
346:             .Visible         = .T.
347:         ENDWITH
348:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
349: 
350:         *-- Grid de listagem (Top=117: 88+29 compensacao, Left=12 do original)
351:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
352:         loc_oGrid = loc_oPg1.grd_4c_Lista
353:         WITH loc_oGrid
354:             .Top                = 117
355:             .Left               = 12
356:             .Width              = 894
357:             .Height             = 455
358:             .DeleteMark         = .F.
359:             .RecordMark         = .F.
360:             .RowHeight          = 16
361:             .ScrollBars         = 2
362:             .GridLines          = 3
363:             .HighlightStyle     = 2
364:             .HighlightBackColor = RGB(255, 255, 255)
365:             .HighlightForeColor = RGB(15, 41, 104)
366:             .GridLineColor      = RGB(238, 238, 238)
367:             .BackColor          = RGB(255, 255, 255)
368:             .FontName           = "Tahoma"
369:             .FontSize           = 8
370:             .Visible            = .T.
371:         ENDWITH
372: 
373:         *-- ColumnCount FORA de WITH (Problema 36: colunas precisam existir antes de acessar)
374:         loc_oGrid.ColumnCount = 5
375: 
376:         WITH loc_oGrid
377:             .Column1.Width           = 50
378:             .Column1.Alignment       = 2
379:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
380:             .Column2.Width           = 450
381:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(245) + "es"
382:             .Column3.Width           = 90
383:             .Column3.Alignment       = 2
384:             .Column3.Header1.Caption = "Pg.Comiss" + CHR(227) + "o"
385:             .Column4.Width           = 80
386:             .Column4.Header1.Caption = "Grupo"
387:             .Column5.Width           = 80
388:             .Column5.Header1.Caption = "Agrupam."
389:         ENDWITH
390: 
391:         THIS.TornarControlesVisiveis(loc_oPg1)
392:     ENDPROC
393: 
394:     *--------------------------------------------------------------------------
395:     * ConfigurarPaginaDados - Fase 5/8: botoes Confirmar/Cancelar +
396:     * Row1 (Codigo/Grupo/Agrupas/MovAutDop) + Row2 (Observacao)
397:     *--------------------------------------------------------------------------
398:     PROTECTED PROCEDURE ConfigurarPaginaDados()
399:         LOCAL loc_oPg2, loc_oBotoesAcao
400:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
401: 
402:         *-- Container botoes Confirmar/Cancelar (Grupo_Salva.Left=819, Top=7+29=36)
403:         loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
404:         loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
405:         WITH loc_oBotoesAcao
406:             .Top         = 36
407:             .Left        = 819
408:             .Width       = 165
409:             .Height      = 85
410:             .BackStyle   = 0
411:             .BorderWidth = 0
412:             .Visible     = .T.
413:         ENDWITH
414: 
415:         *-- Botao Confirmar (salva.Left=5, Top=5)
416:         loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
417:         WITH loc_oBotoesAcao.cmd_4c_Confirmar
418:             .Caption         = "Confirmar"
419:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
420:             .PicturePosition = 13
421:             .Top             = 5
422:             .Left            = 5
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
438:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
439: 
440:         *-- Botao Cancelar (cancelar.Left=81, Top=5)
441:         loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
442:         WITH loc_oBotoesAcao.cmd_4c_Cancelar
443:             .Caption         = "Encerrar"
444:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
445:             .PicturePosition = 13
446:             .Top             = 5
447:             .Left            = 81
448:             .Width           = 75
449:             .Height          = 75
450:             .BackColor       = RGB(255, 255, 255)
451:             .ForeColor       = RGB(90, 90, 90)
452:             .FontName        = "Comic Sans MS"
453:             .FontSize        = 8
454:             .FontBold        = .T.
455:             .FontItalic      = .T.
456:             .Themes          = .F.
457:             .SpecialEffect   = 0
458:             .MousePointer    = 15
459:             .WordWrap        = .T.
460:             .AutoSize        = .F.
461:             .Visible         = .T.
462:         ENDWITH
463:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
464: 
465:         *-- ===== ROW 1: Codigo | Grupo | Agrupamento | Movimentacao Automatica =====
466:         *-- Compensacao PageFrame.Top=-29: Tops originais + 29
467: 
468:         *-- Label Codigo (Say1: Left=55, Top=31 -> 60)
469:         loc_oPg2.AddObject("lbl_4c_Codigo", "Label")
470:         WITH loc_oPg2.lbl_4c_Codigo
471:             .Caption   = "C" + CHR(243) + "digo :"
472:             .Left      = 55
473:             .Top       = 60
474:             .Width     = 40
475:             .Height    = 17
476:             .FontName  = "Tahoma"
477:             .FontSize  = 8
478:             .ForeColor = RGB(90, 90, 90)
479:             .BackStyle = 0
480:             .Visible   = .T.
481:         ENDWITH
482: 
483:         *-- TextBox Codigos (Get_Codigos: Left=100, Top=28->57, Width=37, InputMask="999", numeric)
484:         loc_oPg2.AddObject("txt_4c_Codigos", "TextBox")
485:         WITH loc_oPg2.txt_4c_Codigos
486:             .Value         = 0
487:             .InputMask     = "999"
488:             .Alignment     = 3
489:             .Left          = 100
490:             .Top           = 57
491:             .Width         = 37
492:             .Height        = 23
493:             .FontName      = "Tahoma"
494:             .FontSize      = 8
495:             .ForeColor     = RGB(90, 90, 90)
496:             .SpecialEffect = 1
497:             .Visible       = .T.
498:         ENDWITH
499: 
500:         *-- Label Grupo (Say7: Left=154, Top=31 -> 60)
501:         loc_oPg2.AddObject("lbl_4c_Grupo", "Label")
502:         WITH loc_oPg2.lbl_4c_Grupo
503:             .Caption   = "Grupo :"

*-- Linhas 588 a 631:
588:             .SpecialEffect = 1
589:             .Visible       = .T.
590:         ENDWITH
591:         BINDEVENT(loc_oPg2.txt_4c_MovAutDop, "KeyPress", THIS, "ValidarMovAutDop")
592: 
593:         *-- ===== ROW 2: Observacao (EditBox/memo) =====
594: 
595:         *-- Label Observacao (Say2: Left=30, Top=56 -> 85)
596:         loc_oPg2.AddObject("lbl_4c_Observacao", "Label")
597:         WITH loc_oPg2.lbl_4c_Observacao
598:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
599:             .Left      = 30
600:             .Top       = 85
601:             .Width     = 65
602:             .Height    = 17
603:             .FontName  = "Tahoma"
604:             .FontSize  = 8
605:             .ForeColor = RGB(90, 90, 90)
606:             .BackStyle = 0
607:             .Visible   = .T.
608:         ENDWITH
609: 
610:         *-- EditBox Observas (fwmemo_Observas: Left=100, Top=56->85, Width=713, Height=179)
611:         loc_oPg2.AddObject("edt_4c_Observas", "EditBox")
612:         WITH loc_oPg2.edt_4c_Observas
613:             .Value         = ""
614:             .Left          = 100
615:             .Top           = 85
616:             .Width         = 713
617:             .Height        = 179
618:             .FontName      = "Tahoma"
619:             .FontSize      = 8
620:             .ForeColor     = RGB(90, 90, 90)
621:             .SpecialEffect = 1
622:             .Visible       = .T.
623:         ENDWITH
624: 
625:         *-- ===== ROW 3: Descricao =====
626: 
627:         *-- Label Descricao (Say5: Left=42, Top=241 -> 270)
628:         loc_oPg2.AddObject("lbl_4c_Descricao", "Label")
629:         WITH loc_oPg2.lbl_4c_Descricao
630:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
631:             .Left      = 42

*-- Linhas 671 a 715:
671:             .Visible   = .T.
672:         ENDWITH
673: 
674:         *-- OptionGroup getPagaComiss (Left=200, Top=267->296, Width=96, Height=27, ButtonCount=2)
675:         loc_oPg2.AddObject("opt_4c_PagaComiss", "OptionGroup")
676:         WITH loc_oPg2.opt_4c_PagaComiss
677:             .AutoSize    = .F.
678:             .BackStyle   = 0
679:             .BorderStyle = 0
680:             .Height      = 27
681:             .Left        = 200
682:             .Top         = 296
683:             .Width       = 101
684:             .Value       = 1
685:             .Visible     = .T.
686:         ENDWITH
687:         WITH loc_oPg2.opt_4c_PagaComiss.Buttons(1)
688:             .Caption   = "Sim"
689:             .Height    = 17
690:             .Left      = 5
691:             .Top       = 5
692:             .Width     = 40
693:             .AutoSize  = .F.
694:             .FontName  = "Tahoma"
695:             .FontSize  = 8
696:             .ForeColor = RGB(90, 90, 90)
697:             .BackStyle = 0
698:         ENDWITH
699:         WITH loc_oPg2.opt_4c_PagaComiss.Buttons(2)
700:             .Caption   = "N" + CHR(227) + "o"
701:             .Height    = 17
702:             .Left      = 51
703:             .Top       = 5
704:             .Width     = 40
705:             .AutoSize  = .F.
706:             .FontName  = "Tahoma"
707:             .FontSize  = 8
708:             .ForeColor = RGB(90, 90, 90)
709:             .BackStyle = 0
710:         ENDWITH
711: 
712:         *-- Label Classificacao (Say6: Left=391, Top=272 -> 301)
713:         loc_oPg2.AddObject("lbl_4c_Classificacao", "Label")
714:         WITH loc_oPg2.lbl_4c_Classificacao
715:             .Caption   = "Classifica" + CHR(231) + CHR(227) + "o : "

*-- Linhas 724 a 768:
724:             .Visible   = .T.
725:         ENDWITH
726: 
727:         *-- OptionGroup Opc_Classif (Left=465, Top=267->296, Width=200, Height=27, ButtonCount=3)
728:         loc_oPg2.AddObject("opt_4c_Classif", "OptionGroup")
729:         *-- ButtonCount=3 FORA de WITH para garantir que Buttons(3) existe (analogia ColumnCount grid)
730:         loc_oPg2.opt_4c_Classif.ButtonCount = 3
731:         WITH loc_oPg2.opt_4c_Classif
732:             .AutoSize    = .F.
733:             .BackStyle   = 0
734:             .BorderStyle = 0
735:             .Height      = 27
736:             .Left        = 465
737:             .Top         = 296
738:             .Width       = 205
739:             .Value       = 1
740:             .Visible     = .T.
741:         ENDWITH
742:         WITH loc_oPg2.opt_4c_Classif.Buttons(1)
743:             .Caption   = "Grave"
744:             .Height    = 15
745:             .Left      = 5
746:             .Top       = 5
747:             .Width     = 47
748:             .AutoSize  = .T.
749:             .FontName  = "Tahoma"
750:             .FontSize  = 8
751:             .ForeColor = RGB(90, 90, 90)
752:             .BackStyle = 0
753:         ENDWITH
754:         WITH loc_oPg2.opt_4c_Classif.Buttons(2)
755:             .Caption   = "Leve"
756:             .Height    = 15
757:             .Left      = 75
758:             .Top       = 5
759:             .Width     = 41
760:             .AutoSize  = .T.
761:             .FontName  = "Tahoma"
762:             .FontSize  = 8
763:             .ForeColor = RGB(90, 90, 90)
764:             .BackStyle = 0
765:         ENDWITH
766:         WITH loc_oPg2.opt_4c_Classif.Buttons(3)
767:             .Caption   = "Interno"
768:             .Height    = 17

*-- Linhas 986 a 1092:
986:             .Visible   = .T.
987:         ENDWITH
988: 
989:         THIS.TornarControlesVisiveis(loc_oPg2)
990:     ENDPROC
991: 
992:     *--------------------------------------------------------------------------
993:     * Destroy - Libera recursos
994:     *--------------------------------------------------------------------------
995:     PROCEDURE Destroy()
996:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
997:             THIS.this_oBusinessObject = .NULL.
998:         ENDIF
999: 
1000:         IF USED("cursor_4c_Dados")
1001:             USE IN cursor_4c_Dados
1002:         ENDIF
1003: 
1004:         IF USED("cursor_4c_Nivel")
1005:             USE IN cursor_4c_Nivel
1006:         ENDIF
1007: 
1008:         DODEFAULT()
1009:     ENDPROC
1010: 
1011:     *--------------------------------------------------------------------------
1012:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1013:     *--------------------------------------------------------------------------
1014:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1015:         LOCAL loc_nI, loc_oObjeto
1016: 
1017:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1018:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1019: 
1020:             IF VARTYPE(loc_oObjeto) = "O"
1021:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1022:                     loc_oObjeto.Visible = .T.
1023:                 ENDIF
1024: 
1025:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1026:                     LOCAL loc_nP
1027:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1028:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1029:                     ENDFOR
1030:                 ENDIF
1031: 
1032:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1033:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1034:                 ENDIF
1035:             ENDIF
1036:         ENDFOR
1037:     ENDPROC
1038: 
1039:     *--------------------------------------------------------------------------
1040:     * FormatarGridLista - Formata visual do grid da lista
1041:     *--------------------------------------------------------------------------
1042:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1043:         WITH par_oGrid
1044:             .FontName = "Tahoma"
1045:             .FontSize = 8
1046:         ENDWITH
1047:     ENDPROC
1048: 
1049:     *--------------------------------------------------------------------------
1050:     * CarregarLista - Carrega dados no grid da Page1 via ObsBO.Buscar()
1051:     *--------------------------------------------------------------------------
1052:     PROCEDURE CarregarLista()
1053:         LOCAL loc_lResultado, loc_oGrid
1054:         loc_lResultado = .F.
1055: 
1056:         TRY
1057:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1058:                 loc_lResultado = .T.
1059:             ELSE
1060:                 IF !THIS.this_oBusinessObject.Buscar("")
1061:                     loc_lResultado = .F.
1062:                 ELSE
1063:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1064: 
1065:                     *-- RecordSource e ColumnCount FORA de WITH (Problema 36)
1066:                     loc_oGrid.ColumnCount = 5
1067:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1068:                     loc_oGrid.ColumnCount  = 5
1069: 
1070:                     *-- ControlSource APOS RecordSource (Problema 48)
1071:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
1072:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
1073:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.PgComissao"
1074:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Grupos"
1075:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Agrupas"
1076: 
1077:                     *-- Larguras e Headers APOS RecordSource (Problema 32)
1078:                     loc_oGrid.Column1.Width           = 50
1079:                     loc_oGrid.Column1.Alignment       = 2
1080:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1081:                     loc_oGrid.Column2.Width           = 450
1082:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(245) + "es"
1083:                     loc_oGrid.Column3.Width           = 90
1084:                     loc_oGrid.Column3.Alignment       = 2
1085:                     loc_oGrid.Column3.Header1.Caption = "Pg.Comiss" + CHR(227) + "o"
1086:                     loc_oGrid.Column4.Width           = 80
1087:                     loc_oGrid.Column4.Header1.Caption = "Grupo"
1088:                     loc_oGrid.Column5.Width           = 80
1089:                     loc_oGrid.Column5.Header1.Caption = "Agrupam."
1090: 
1091:                     THIS.FormatarGridLista(loc_oGrid)
1092:                     loc_lResultado = .T.

*-- Linhas 1103 a 1499:
1103:     *--------------------------------------------------------------------------
1104:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
1105:     *--------------------------------------------------------------------------
1106:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1107:         LOCAL loc_lResultado
1108:         loc_lResultado = .F.
1109: 
1110:         TRY
1111:             IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
1112:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1113:                 IF par_nPagina = 1
1114:                     THIS.this_cModoAtual = "LISTA"
1115:                     THIS.CarregarLista()
1116:                 ENDIF
1117:                 loc_lResultado = .T.
1118:             ENDIF
1119:         CATCH TO loc_oErro
1120:             MsgErro(loc_oErro.Message, "FormObs.AlternarPagina")
1121:         ENDTRY
1122: 
1123:         RETURN loc_lResultado
1124:     ENDPROC
1125: 
1126:     *--------------------------------------------------------------------------
1127:     * BtnEncerrarClick - Fecha o formulario
1128:     *--------------------------------------------------------------------------
1129:     PROCEDURE BtnEncerrarClick()
1130:         THIS.Release()
1131:     ENDPROC
1132: 
1133:     *--------------------------------------------------------------------------
1134:     * ValidarMovAutDop - Valida Movimentacao Automatica ao sair do campo
1135:     * Busca em cursor_4c_Nivel (SigCdOpe por Dopes); abre busca se nao encontrado
1136:     * Handler PUBLIC para BINDEVENT (Problema 17)
1137:     *--------------------------------------------------------------------------
1138:     PROCEDURE ValidarMovAutDop(par_nKeyCode, par_nShiftAltCtrl)
1139:         LOCAL loc_lResultado, loc_cValor, loc_oBusca
1140:         loc_lResultado = .F.
1141: 
1142:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1143:             RETURN .T.
1144:         ENDIF
1145: 
1146:         TRY
1147:             loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_MovAutDop.Value)
1148: 
1149:             IF EMPTY(loc_cValor)
1150:                 loc_lResultado = .T.
1151:             ELSE
1152:                 IF USED("cursor_4c_Nivel")
1153:                 SELECT Dopes, Cmoes, nFiscals, Abrevs ;
1154:                     FROM cursor_4c_Nivel ;
1155:                     WHERE !EMPTY(ALLTRIM(Abrevs)) ;
1156:                     INTO CURSOR cursor_4c_NivelSel READWRITE
1157: 
1158:                 SELECT cursor_4c_NivelSel
1159:                 LOCATE FOR ALLTRIM(Dopes) = loc_cValor
1160:                 IF EOF()
1161:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1162:                     IF VARTYPE(loc_oBusca) = "O"
1163:                         loc_oBusca.this_cCursorDestino = "cursor_4c_NivelSel"
1164:                         loc_oBusca.this_cTitulo = "Opera" + CHR(231) + CHR(245) + "es"
1165:                         loc_oBusca.mAddColuna("Dopes", "", "C" + CHR(243) + "digo")
1166:                         loc_oBusca.Show()
1167: 
1168:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_NivelSel")
1169:                             THIS.pgf_4c_Paginas.Page2.txt_4c_MovAutDop.Value = ;
1170:                                 ALLTRIM(cursor_4c_NivelSel.Dopes)
1171:                         ELSE
1172:                             THIS.pgf_4c_Paginas.Page2.txt_4c_MovAutDop.Value = ""
1173:                         ENDIF
1174:                         loc_oBusca.Release()
1175:                     ENDIF
1176:                 ENDIF
1177: 
1178:                 IF USED("cursor_4c_NivelSel")
1179:                     USE IN cursor_4c_NivelSel
1180:                 ENDIF
1181: 
1182:                 loc_lResultado = .T.
1183:             ELSE
1184:                 loc_lResultado = .T.
1185:                 ENDIF
1186:             ENDIF
1187:         CATCH TO loc_oErro
1188:             MsgErro(loc_oErro.Message, "FormObs.ValidarMovAutDop")
1189:         ENDTRY
1190: 
1191:         RETURN loc_lResultado
1192:     ENDPROC
1193: 
1194:     *--------------------------------------------------------------------------
1195:     * FormParaBO - Transfere valores do Form para o BO
1196:     *--------------------------------------------------------------------------
1197:     PROTECTED PROCEDURE FormParaBO()
1198:         LOCAL loc_oPg2
1199:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1200: 
1201:         THIS.this_oBusinessObject.this_nCodigos   = loc_oPg2.txt_4c_Codigos.Value
1202:         THIS.this_oBusinessObject.this_cDescrs    = ALLTRIM(loc_oPg2.txt_4c_Descrs.Value)
1203:         THIS.this_oBusinessObject.this_cObservas  = loc_oPg2.edt_4c_Observas.Value
1204:         THIS.this_oBusinessObject.this_cGrupos    = ALLTRIM(loc_oPg2.txt_4c_Grupos.Value)
1205:         THIS.this_oBusinessObject.this_cAgrupas   = ALLTRIM(loc_oPg2.txt_4c_Agrupas.Value)
1206:         THIS.this_oBusinessObject.this_cMovAutDop = ALLTRIM(loc_oPg2.txt_4c_MovAutDop.Value)
1207:         THIS.this_oBusinessObject.this_nComiss    = loc_oPg2.opt_4c_PagaComiss.Value
1208:         THIS.this_oBusinessObject.this_nClassifs  = loc_oPg2.opt_4c_Classif.Value
1209:     ENDPROC
1210: 
1211:     *--------------------------------------------------------------------------
1212:     * BOParaForm - Transfere valores do BO para o Form
1213:     *--------------------------------------------------------------------------
1214:     PROTECTED PROCEDURE BOParaForm()
1215:         LOCAL loc_oPg2, loc_nComiss, loc_nClassifs
1216:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1217: 
1218:         loc_oPg2.txt_4c_Codigos.Value   = THIS.this_oBusinessObject.this_nCodigos
1219:         loc_oPg2.txt_4c_Descrs.Value    = THIS.this_oBusinessObject.this_cDescrs
1220:         loc_oPg2.edt_4c_Observas.Value  = THIS.this_oBusinessObject.this_cObservas
1221:         loc_oPg2.txt_4c_Grupos.Value    = THIS.this_oBusinessObject.this_cGrupos
1222:         loc_oPg2.txt_4c_Agrupas.Value   = THIS.this_oBusinessObject.this_cAgrupas
1223:         loc_oPg2.txt_4c_MovAutDop.Value = THIS.this_oBusinessObject.this_cMovAutDop
1224: 
1225:         *-- Comiss=1=Sim(Button1), Comiss=2=Nao(Button2)
1226:         loc_nComiss = THIS.this_oBusinessObject.this_nComiss
1227:         loc_oPg2.opt_4c_PagaComiss.Value = IIF(loc_nComiss >= 1 AND loc_nComiss <= 2, loc_nComiss, 1)
1228: 
1229:         *-- Classifs: 1=Grave, 2=Leve, 3=Interno
1230:         loc_nClassifs = THIS.this_oBusinessObject.this_nClassifs
1231:         loc_oPg2.opt_4c_Classif.Value = IIF(loc_nClassifs >= 1 AND loc_nClassifs <= 3, loc_nClassifs, 1)
1232:     ENDPROC
1233: 
1234:     *--------------------------------------------------------------------------
1235:     * LimparCampos - Limpa todos os campos da Page2
1236:     *--------------------------------------------------------------------------
1237:     PROTECTED PROCEDURE LimparCampos()
1238:         LOCAL loc_oPg2
1239:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1240: 
1241:         loc_oPg2.txt_4c_Codigos.Value    = 0
1242:         loc_oPg2.txt_4c_Descrs.Value     = ""
1243:         loc_oPg2.edt_4c_Observas.Value   = ""
1244:         loc_oPg2.txt_4c_Grupos.Value     = ""
1245:         loc_oPg2.txt_4c_Agrupas.Value    = ""
1246:         loc_oPg2.txt_4c_MovAutDop.Value  = ""
1247:         loc_oPg2.opt_4c_PagaComiss.Value = 1
1248:         loc_oPg2.opt_4c_Classif.Value    = 1
1249:     ENDPROC
1250: 
1251:     *--------------------------------------------------------------------------
1252:     * HabilitarCampos - Habilita ou desabilita campos conforme modo
1253:     * par_lHabilitar=.T. -> INCLUIR/ALTERAR; par_lHabilitar=.F. -> VISUALIZAR
1254:     *--------------------------------------------------------------------------
1255:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1256:         LOCAL loc_oPg2
1257:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1258: 
1259:         *-- Codigo: somente editavel em INCLUIR (PK nao se altera em ALTERAR)
1260:         loc_oPg2.txt_4c_Codigos.ReadOnly = !(par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
1261: 
1262:         loc_oPg2.txt_4c_Descrs.ReadOnly    = !par_lHabilitar
1263:         loc_oPg2.edt_4c_Observas.ReadOnly  = !par_lHabilitar
1264:         loc_oPg2.txt_4c_Grupos.ReadOnly    = !par_lHabilitar
1265:         loc_oPg2.txt_4c_Agrupas.ReadOnly   = !par_lHabilitar
1266:         loc_oPg2.txt_4c_MovAutDop.ReadOnly = !par_lHabilitar
1267: 
1268:         loc_oPg2.opt_4c_PagaComiss.Enabled = par_lHabilitar
1269:         loc_oPg2.opt_4c_Classif.Enabled    = par_lHabilitar
1270: 
1271:         *-- Confirmar: disponivel apenas em INCLUIR/ALTERAR
1272:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
1273:     ENDPROC
1274: 
1275:     *--------------------------------------------------------------------------
1276:     * AjustarBotoesPorModo - Ajusta estado dos botoes CRUD da Page1
1277:     *--------------------------------------------------------------------------
1278:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1279:         LOCAL loc_oPg1, loc_lTemRegistro
1280:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1281: 
1282:         loc_lTemRegistro = USED("cursor_4c_Dados") AND ;
1283:                            RECCOUNT("cursor_4c_Dados") > 0 AND ;
1284:                            !EOF("cursor_4c_Dados")
1285: 
1286:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = .T.
1287:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
1288:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
1289:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
1290:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = .T.
1291:     ENDPROC
1292: 
1293:     *--------------------------------------------------------------------------
1294:     * BtnIncluirClick - Inicia inclusao de novo registro
1295:     * Handler PUBLIC para BINDEVENT (Problema 17)
1296:     *--------------------------------------------------------------------------
1297:     PROCEDURE BtnIncluirClick()
1298:         THIS.this_oBusinessObject.NovoRegistro()
1299:         THIS.LimparCampos()
1300:         THIS.this_cModoAtual = "INCLUIR"
1301:         THIS.HabilitarCampos(.T.)
1302:         THIS.AlternarPagina(2)
1303: 
1304:         TRY
1305:             THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus()
1306:         CATCH
1307:         ENDTRY
1308:     ENDPROC
1309: 
1310:     *--------------------------------------------------------------------------
1311:     * BtnAlterarClick - Carrega e abre registro selecionado para edicao
1312:     * Foco vai para edt_4c_Observas (replica original: ALTERAR -> fwmemo_Observas)
1313:     * Handler PUBLIC para BINDEVENT (Problema 17)
1314:     *--------------------------------------------------------------------------
1315:     PROCEDURE BtnAlterarClick()
1316:         LOCAL loc_nCodigo
1317:         loc_nCodigo = 0
1318: 
1319:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
1320:             MsgAviso("Selecione um registro para alterar.", "Alterar")
1321:             RETURN
1322:         ENDIF
1323: 
1324:         SELECT cursor_4c_Dados
1325:         loc_nCodigo = cursor_4c_Dados.Codigos
1326: 
1327:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
1328:             MsgErro("Registro n" + CHR(227) + "o encontrado.", "Alterar")
1329:             RETURN
1330:         ENDIF
1331: 
1332:         THIS.this_oBusinessObject.EditarRegistro()
1333:         THIS.this_cModoAtual = "ALTERAR"
1334:         THIS.BOParaForm()
1335:         THIS.HabilitarCampos(.T.)
1336:         THIS.AlternarPagina(2)
1337: 
1338:         TRY
1339:             THIS.pgf_4c_Paginas.Page2.edt_4c_Observas.SetFocus()
1340:         CATCH
1341:         ENDTRY
1342:     ENDPROC
1343: 
1344:     *--------------------------------------------------------------------------
1345:     * BtnVisualizarClick - Carrega registro selecionado em modo leitura
1346:     * Handler PUBLIC para BINDEVENT (Problema 17)
1347:     *--------------------------------------------------------------------------
1348:     PROCEDURE BtnVisualizarClick()
1349:         LOCAL loc_nCodigo
1350:         loc_nCodigo = 0
1351: 
1352:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
1353:             MsgAviso("Selecione um registro para visualizar.", "Visualizar")
1354:             RETURN
1355:         ENDIF
1356: 
1357:         SELECT cursor_4c_Dados
1358:         loc_nCodigo = cursor_4c_Dados.Codigos
1359: 
1360:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
1361:             MsgErro("Registro n" + CHR(227) + "o encontrado.", "Visualizar")
1362:             RETURN
1363:         ENDIF
1364: 
1365:         THIS.this_cModoAtual = "VISUALIZAR"
1366:         THIS.BOParaForm()
1367:         THIS.HabilitarCampos(.F.)
1368:         THIS.AlternarPagina(2)
1369: 
1370:         TRY
1371:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus()
1372:         CATCH
1373:         ENDTRY
1374:     ENDPROC
1375: 
1376:     *--------------------------------------------------------------------------
1377:     * BtnExcluirClick - Exclui registro selecionado apos confirmacao
1378:     * Handler PUBLIC para BINDEVENT (Problema 17)
1379:     *--------------------------------------------------------------------------
1380:     PROCEDURE BtnExcluirClick()
1381:         LOCAL loc_nCodigo
1382: 
1383:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
1384:             MsgAviso("Selecione um registro para excluir.", "Excluir")
1385:             RETURN
1386:         ENDIF
1387: 
1388:         SELECT cursor_4c_Dados
1389:         loc_nCodigo = cursor_4c_Dados.Codigos
1390: 
1391:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da observa" + CHR(231) + ;
1392:                 CHR(227) + "o " + TRANSFORM(loc_nCodigo) + "?", "Excluir")
1393:             RETURN
1394:         ENDIF
1395: 
1396:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
1397:             MsgErro("Registro n" + CHR(227) + "o encontrado.", "Excluir")
1398:             RETURN
1399:         ENDIF
1400: 
1401:         IF THIS.this_oBusinessObject.Excluir()
1402:             MsgInfo("Observa" + CHR(231) + CHR(227) + "o exclu" + CHR(237) + "da com sucesso!", "Excluir")
1403:             THIS.CarregarLista()
1404:             THIS.AjustarBotoesPorModo()
1405:         ENDIF
1406:     ENDPROC
1407: 
1408:     *--------------------------------------------------------------------------
1409:     * BtnBuscarClick - Modo PROCURAR: navega para Page2 com apenas Codigos editavel
1410:     * Replica comportamento original (pcEscolha='PROCURAR' -> focus Get_Codigos)
1411:     * Handler PUBLIC para BINDEVENT (Problema 17)
1412:     *--------------------------------------------------------------------------
1413:     PROCEDURE BtnBuscarClick()
1414:         LOCAL loc_oPg2
1415:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1416: 
1417:         THIS.LimparCampos()
1418:         THIS.this_cModoAtual = "PROCURAR"
1419: 
1420:         *-- Em PROCURAR: somente Codigos editavel para busca por codigo
1421:         loc_oPg2.txt_4c_Codigos.ReadOnly           = .F.
1422:         loc_oPg2.txt_4c_Descrs.ReadOnly            = .T.
1423:         loc_oPg2.edt_4c_Observas.ReadOnly          = .T.
1424:         loc_oPg2.txt_4c_Grupos.ReadOnly            = .T.
1425:         loc_oPg2.txt_4c_Agrupas.ReadOnly           = .T.
1426:         loc_oPg2.txt_4c_MovAutDop.ReadOnly         = .T.
1427:         loc_oPg2.opt_4c_PagaComiss.Enabled         = .F.
1428:         loc_oPg2.opt_4c_Classif.Enabled            = .F.
1429:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
1430: 
1431:         THIS.AlternarPagina(2)
1432: 
1433:         TRY
1434:             loc_oPg2.txt_4c_Codigos.SetFocus()
1435:         CATCH
1436:         ENDTRY
1437:     ENDPROC
1438: 
1439:     *--------------------------------------------------------------------------
1440:     * BtnSalvarClick - Salva registro (INCLUIR/ALTERAR) ou localiza (PROCURAR)
1441:     * Handler PUBLIC para BINDEVENT (Problema 17)
1442:     *--------------------------------------------------------------------------
1443:     PROCEDURE BtnSalvarClick()
1444:         LOCAL loc_oPg2, loc_nCodigo, loc_nVerif
1445: 
1446:         *-- Modo PROCURAR: localizar codigo no grid e retornar para lista
1447:         IF THIS.this_cModoAtual = "PROCURAR"
1448:             loc_nCodigo = THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.Value
1449:             IF loc_nCodigo > 0 AND USED("cursor_4c_Dados")
1450:                 SELECT cursor_4c_Dados
1451:                 LOCATE FOR Codigos = loc_nCodigo
1452:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1453:             ENDIF
1454:             THIS.AlternarPagina(1)
1455:             RETURN
1456:         ENDIF
1457: 
1458:         *-- Modo VISUALIZAR: Confirmar nao deveria estar habilitado, mas por seguranca cancela
1459:         IF THIS.this_cModoAtual = "VISUALIZAR"
1460:             THIS.BtnCancelarClick()
1461:             RETURN
1462:         ENDIF
1463: 
1464:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1465:         loc_nCodigo = loc_oPg2.txt_4c_Codigos.Value
1466: 
1467:         *-- Validacoes ANTES do TRY/CATCH (Regra critica CLAUDE.md: NUNCA RETURN dentro de TRY)
1468:         IF loc_nCodigo <= 0
1469:             MsgAviso("Informe o c" + CHR(243) + "digo da observa" + CHR(231) + CHR(227) + "o.", "Salvar")
1470:             loc_oPg2.txt_4c_Codigos.SetFocus()
1471:             RETURN
1472:         ENDIF
1473: 
1474:         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Descrs.Value))
1475:             MsgAviso("Informe a descri" + CHR(231) + CHR(227) + "o.", "Salvar")
1476:             loc_oPg2.txt_4c_Descrs.SetFocus()
1477:             RETURN
1478:         ENDIF
1479: 
1480:         THIS.FormParaBO()
1481: 
1482:         IF THIS.this_oBusinessObject.Salvar()
1483:             MsgInfo("Observa" + CHR(231) + CHR(227) + "o salva com sucesso!", "Salvar")
1484:             THIS.AlternarPagina(1)
1485:             THIS.AjustarBotoesPorModo()
1486:         ENDIF
1487:     ENDPROC
1488: 
1489:     *--------------------------------------------------------------------------
1490:     * BtnCancelarClick - Cancela edicao e retorna para lista
1491:     * Handler PUBLIC para BINDEVENT (Problema 17)
1492:     *--------------------------------------------------------------------------
1493:     PROCEDURE BtnCancelarClick()
1494:         THIS.LimparCampos()
1495:         THIS.AlternarPagina(1)
1496:         THIS.AjustarBotoesPorModo()
1497:     ENDPROC
1498: 
1499: ENDDEFINE


### BO (C:\4c\projeto\app\classes\ObsBO.prg):
*====================================================================
* ObsBO.prg
*
* Business Object para Cadastro de Observacoes
* Tabela: SigCdObs
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS ObsBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdObs)
    this_nCodigos    = 0     && Codigos numeric(3,0) - PK
    this_cDescrs     = ""    && descrs  char
    this_cObservas   = ""    && Observas memo
    this_cGrupos     = ""    && grupos  char
    this_cAgrupas    = ""    && agrupas char
    this_nComiss     = 0     && Comiss  numeric (1=Sim, 2=Nao)
    this_nClassifs   = 0     && Classifs numeric (1=Grave, 2=Leve, 3=Interno)
    this_cMovAutDop  = ""    && MovAutDop char (lookup SigCdOpe.Dopes)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdObs"
            THIS.this_cCampoChave = "Codigos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "ObsBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna valor da PK para auditoria (PUBLIC)
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodigos)
    ENDFUNC

    *====================================================================
    * Buscar - Carrega lista de registros no cursor_4c_Dados (PUBLIC)
    * par_cFiltro: condicao WHERE sem "WHERE" (pode ser "")
    *====================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = "SELECT Codigos, Descrs," + ;
                       " CASE WHEN Comiss = 2 THEN 'NAO' ELSE 'SIM' END AS PgComissao," + ;
                       " Grupos, Agrupas" + ;
                       " FROM SigCdObs" + ;
                       loc_cWhere + ;
                       " ORDER BY Codigos"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar observa" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pelo codigo (PUBLIC)
    *====================================================================
    FUNCTION CarregarPorCodigo(par_nCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Codigos, Descrs, Observas, Comiss, Classifs," + ;
                       " Grupos, Agrupas, MovAutDop" + ;
                       " FROM SigCdObs" + ;
                       " WHERE Codigos = " + FormatarNumeroSQL(par_nCodigo)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar observa" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Popula propriedades a partir de cursor (PROTECTED)
    *====================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nCodigos   = TratarNulo(codigos,   "N")
                THIS.this_cDescrs    = TratarNulo(descrs,    "C")
                THIS.this_cObservas  = TratarNulo(observas,  "C")
                THIS.this_cGrupos    = TratarNulo(grupos,    "C")
                THIS.this_cAgrupas   = TratarNulo(agrupas,   "C")
                THIS.this_nComiss    = TratarNulo(comiss,    "N")
                THIS.this_nClassifs  = TratarNulo(classifs,  "N")
                THIS.this_cMovAutDop = TratarNulo(movautdop, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * Inserir - Insere novo registro na tabela (PROTECTED)
    * Chamado por BusinessBase.Salvar() quando this_lNovoRegistro=.T.
    *====================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdObs" + ;
                       " (Codigos, Descrs, Observas, Comiss, Classifs," + ;
                       "  Grupos, Agrupas, MovAutDop)" + ;
                       " VALUES (" + ;
                       FormatarNumeroSQL(THIS.this_nCodigos) + ", " + ;
                       EscaparSQL(THIS.this_cDescrs) + ", " + ;
                       EscaparSQL(THIS.this_cObservas) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nComiss) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClassifs) + ", " + ;
                       EscaparSQL(THIS.this_cGrupos) + ", " + ;
                       EscaparSQL(THIS.this_cAgrupas) + ", " + ;
                       EscaparSQL(THIS.this_cMovAutDop) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir observa" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * Atualizar - Atualiza registro existente (PROTECTED)
    * Chamado por BusinessBase.Salvar() quando this_lNovoRegistro=.F.
    *====================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdObs SET" + ;
                       " Descrs    = " + EscaparSQL(THIS.this_cDescrs) + "," + ;
                       " Observas  = " + EscaparSQL(THIS.this_cObservas) + "," + ;
                       " Comiss    = " + FormatarNumeroSQL(THIS.this_nComiss) + "," + ;
                       " Classifs  = " + FormatarNumeroSQL(THIS.this_nClassifs) + "," + ;
                       " Grupos    = " + EscaparSQL(THIS.this_cGrupos) + "," + ;
                       " Agrupas   = " + EscaparSQL(THIS.this_cAgrupas) + "," + ;
                       " MovAutDop = " + EscaparSQL(THIS.this_cMovAutDop) + ;
                       " WHERE Codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar observa" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ExecutarExclusao - Remove registro da tabela (PROTECTED)
    * Chamado internamente por BusinessBase.Excluir()
    *====================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdObs" + ;
                       " WHERE Codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir observa" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * BuscarOperacoesNivel - Carrega cursor para lookup de MovAutDop (PUBLIC)
    * Equivalente ao: Select Dopes,Cmoes,nFiscals,Abrevs From SigCdOpe
    * Usado pelo Form para popular o lookup de Movimentacao Automatica
    *====================================================================
    FUNCTION BuscarOperacoesNivel()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Nivel")
                USE IN cursor_4c_Nivel
            ENDIF

            loc_cSQL = "SELECT Dopes, Cmoes, NFiscals, Abrevs" + ;
                       " FROM SigCdOpe" + ;
                       " WHERE LTRIM(RTRIM(Abrevs)) <> ''" + ;
                       " ORDER BY Dopes"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Nivel")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "ObsBO.BuscarOperacoesNivel")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

