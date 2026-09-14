# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormMrc.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1034 linhas total):

*-- Linhas 25 a 158:
25:     this_cCursorDados    = "cursor_4c_Dados"
26: 
27:     *--------------------------------------------------------------------------
28:     * Init - FormBase.Init() chama InicializarForm() automaticamente
29:     *--------------------------------------------------------------------------
30:     PROCEDURE Init()
31:         LOCAL loc_lSucesso
32:         loc_lSucesso = .F.
33:         TRY
34:             loc_lSucesso = DODEFAULT()
35:         CATCH TO loc_oErro
36:             MsgErro("Erro ao inicializar FormMrc:" + CHR(13) + loc_oErro.Message, "Erro")
37:         ENDTRY
38:         RETURN loc_lSucesso
39:     ENDPROC
40: 
41:     *--------------------------------------------------------------------------
42:     * InicializarForm - Configura estrutura completa do formulario
43:     * Chamado automaticamente pelo FormBase.Init()
44:     *--------------------------------------------------------------------------
45:     PROTECTED PROCEDURE InicializarForm()
46:         LOCAL loc_lSucesso
47:         loc_lSucesso = .F.
48: 
49:         TRY
50:             THIS.this_oBusinessObject = CREATEOBJECT("MrcBO")
51:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
52:                 MsgErro("Erro ao criar MrcBO.", "Erro")
53:             ELSE
54:                 THIS.ConfigurarPageFrame()
55: 
56:                 IF TYPE("THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra") = "O"
57:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
58:                 ENDIF
59:                 IF TYPE("THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo") = "O"
60:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
61:                 ENDIF
62: 
63:                 THIS.pgf_4c_Paginas.Visible = .T.
64:                 THIS.pgf_4c_Paginas.ActivePage = 1
65:                 THIS.this_cModoAtual = "LISTA"
66: 
67:                 IF THIS.DataSession = 2
68:                     SET DATE TO BRITISH
69:                     SET CENTURY ON
70:                 ENDIF
71: 
72:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
73:                     THIS.CarregarLista()
74:                 ENDIF
75: 
76:                 loc_lSucesso = .T.
77:             ENDIF
78:         CATCH TO loc_oErro
79:             MsgErro("Erro ao inicializar formulario:" + CHR(13) + loc_oErro.Message, "Erro")
80:             loc_lSucesso = .F.
81:         ENDTRY
82: 
83:         RETURN loc_lSucesso
84:     ENDPROC
85: 
86:     *--------------------------------------------------------------------------
87:     * ConfigurarPageFrame - Cria o PageFrame com 2 paginas
88:     *--------------------------------------------------------------------------
89:     PROTECTED PROCEDURE ConfigurarPageFrame()
90:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
91: 
92:         WITH THIS.pgf_4c_Paginas
93:             .PageCount = 2
94:             .Top       = -29
95:             .Left      = 0
96:             .Width     = THIS.Width
97:             .Height    = THIS.Height
98:             .Tabs      = .F.
99: 
100:             .Page1.BackColor = RGB(100, 100, 100)
101:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
102:             .Page1.Caption   = "Lista"
103:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104: 
105:             .Page2.BackColor = RGB(100, 100, 100)
106:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
107:             .Page2.Caption   = "Dados"
108:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
109:         ENDWITH
110: 
111:         THIS.ConfigurarPaginaLista()
112:         THIS.ConfigurarPaginaDados()
113:     ENDPROC
114: 
115:     *--------------------------------------------------------------------------
116:     * ConfigurarPaginaLista - Configura Page1 com cabecalho, botoes CRUD e grade
117:     *--------------------------------------------------------------------------
118:     PROTECTED PROCEDURE ConfigurarPaginaLista()
119:         LOCAL loc_oPagina
120:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
121: 
122:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
123:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
124: 
125:         *-- Cabecalho cinza escuro (cntSombra no legado)
126:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
127:         WITH loc_oPagina.cnt_4c_Cabecalho
128:             .Top         = 31
129:             .Left        = 0
130:             .Width       = THIS.Width
131:             .Height      = 80
132:             .BackColor   = RGB(100, 100, 100)
133:             .BorderWidth = 0
134:             .Visible     = .T.
135:         ENDWITH
136: 
137:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
138:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
139:             .Caption   = THIS.Caption
140:             .Top       = 15
141:             .Left      = 10
142:             .Width     = THIS.Width - 20
143:             .Height    = 40
144:             .FontName  = "Tahoma"
145:             .FontSize  = 16
146:             .FontBold  = .T.
147:             .ForeColor = RGB(0, 0, 0)
148:             .BackStyle = 0
149:             .AutoSize  = .F.
150:             .Visible   = .T.
151:         ENDWITH
152: 
153:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
154:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
155:             .Caption   = THIS.Caption
156:             .Top       = 18
157:             .Left      = 10
158:             .Width     = THIS.Width - 20

*-- Linhas 201 a 503:
201:             .AutoSize        = .F.
202:             .Visible         = .T.
203:         ENDWITH
204:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
205: 
206:         *-- Visualizar (Consultar no legado: Left=80, Top=5)
207:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
208:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
209:             .Caption         = "Visualizar"
210:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
211:             .PicturePosition = 13
212:             .Top             = 5
213:             .Left            = 80
214:             .Width           = 75
215:             .Height          = 75
216:             .BackColor       = RGB(255, 255, 255)
217:             .ForeColor       = RGB(90, 90, 90)
218:             .FontName        = "Comic Sans MS"
219:             .FontSize        = 8
220:             .FontBold        = .T.
221:             .FontItalic      = .T.
222:             .Themes          = .F.
223:             .SpecialEffect   = 0
224:             .MousePointer    = 15
225:             .WordWrap        = .T.
226:             .AutoSize        = .F.
227:             .Visible         = .T.
228:         ENDWITH
229:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
230: 
231:         *-- Alterar (Left=155, Top=5)
232:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
233:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
234:             .Caption         = "Alterar"
235:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
236:             .PicturePosition = 13
237:             .Top             = 5
238:             .Left            = 155
239:             .Width           = 75
240:             .Height          = 75
241:             .BackColor       = RGB(255, 255, 255)
242:             .ForeColor       = RGB(90, 90, 90)
243:             .FontName        = "Comic Sans MS"
244:             .FontSize        = 8
245:             .FontBold        = .T.
246:             .FontItalic      = .T.
247:             .Themes          = .F.
248:             .SpecialEffect   = 0
249:             .MousePointer    = 15
250:             .WordWrap        = .T.
251:             .AutoSize        = .F.
252:             .Visible         = .T.
253:         ENDWITH
254:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
255: 
256:         *-- Excluir (Left=230, Top=5)
257:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
258:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
259:             .Caption         = "Excluir"
260:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
261:             .PicturePosition = 13
262:             .Top             = 5
263:             .Left            = 230
264:             .Width           = 75
265:             .Height          = 75
266:             .BackColor       = RGB(255, 255, 255)
267:             .ForeColor       = RGB(90, 90, 90)
268:             .FontName        = "Comic Sans MS"
269:             .FontSize        = 8
270:             .FontBold        = .T.
271:             .FontItalic      = .T.
272:             .Themes          = .F.
273:             .SpecialEffect   = 0
274:             .MousePointer    = 15
275:             .WordWrap        = .T.
276:             .AutoSize        = .F.
277:             .Visible         = .T.
278:         ENDWITH
279:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
280: 
281:         *-- Buscar (Procurar no legado: Left=305, Top=5)
282:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
283:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
284:             .Caption         = "Buscar"
285:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
286:             .PicturePosition = 13
287:             .Top             = 5
288:             .Left            = 305
289:             .Width           = 75
290:             .Height          = 75
291:             .BackColor       = RGB(255, 255, 255)
292:             .ForeColor       = RGB(90, 90, 90)
293:             .FontName        = "Comic Sans MS"
294:             .FontSize        = 8
295:             .FontBold        = .T.
296:             .FontItalic      = .T.
297:             .Themes          = .F.
298:             .SpecialEffect   = 0
299:             .MousePointer    = 15
300:             .WordWrap        = .T.
301:             .AutoSize        = .F.
302:             .Visible         = .T.
303:         ENDWITH
304:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
305: 
306:         *-- Container Saida - padrao canonico (Grupo_Saida no legado: Left=718, Top=-1)
307:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
308:         WITH loc_oPagina.cnt_4c_Saida
309:             .Top         = 29
310:             .Left        = 917
311:             .Width       = 90
312:             .Height      = 85
313:             .BackStyle   = 0
314:             .BorderWidth = 0
315:             .Visible     = .T.
316:         ENDWITH
317: 
318:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
319:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
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
340:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
341: 
342:         *-- Botao Itens (Legado: Top=86, Left=347, Width=105, Height=45 -> Top compensado +29)
343:         loc_oPagina.AddObject("cmd_4c_Itens", "CommandButton")
344:         WITH loc_oPagina.cmd_4c_Itens
345:             .Caption         = "Itens"
346:             .Picture         = gc_4c_CaminhoIcones + "folder31.ico"
347:             .PicturePosition = 13
348:             .Top             = 115
349:             .Left            = 347
350:             .Width           = 105
351:             .Height          = 45
352:             .BackColor       = RGB(255, 255, 255)
353:             .ForeColor       = RGB(90, 90, 90)
354:             .FontName        = "Tahoma"
355:             .FontSize        = 8
356:             .FontBold        = .F.
357:             .Themes          = .F.
358:             .SpecialEffect   = 0
359:             .MousePointer    = 15
360:             .ToolTipText     = "Itens"
361:             .Visible         = .T.
362:         ENDWITH
363:         BINDEVENT(loc_oPagina.cmd_4c_Itens, "Click", THIS, "BtnItensClick")
364: 
365:         *-- Grade (Legado: Grade.Top=133, Left=32, Width=736, Height=433 -> Top +29=162)
366:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
367:         WITH loc_oPagina.grd_4c_Lista
368:             .Top                = 162
369:             .Left               = 32
370:             .Width              = 736
371:             .Height             = 433
372:             .FontName           = "Tahoma"
373:             .FontSize           = 8
374:             .ForeColor          = RGB(90, 90, 90)
375:             .BackColor          = RGB(255, 255, 255)
376:             .GridLineColor      = RGB(238, 238, 238)
377:             .HighlightBackColor = RGB(255, 255, 255)
378:             .HighlightForeColor = RGB(15, 41, 104)
379:             .HighlightStyle     = 2
380:             .DeleteMark         = .F.
381:             .RecordMark         = .F.
382:             .RowHeight          = 16
383:             .ScrollBars         = 2
384:             .GridLines          = 3
385:             .ReadOnly           = .T.
386:             .Visible            = .T.
387:         ENDWITH
388:         *-- ColumnCount FORA de WITH para criar colunas imediatamente (Problema 36)
389:         loc_oPagina.grd_4c_Lista.ColumnCount = 3
390: 
391:         THIS.TornarControlesVisiveis(loc_oPagina)
392:     ENDPROC
393: 
394:     *--------------------------------------------------------------------------
395:     * ConfigurarPaginaDados - Configura Page2: botoes Confirmar/Cancelar,
396:     * labels e campos (txt_4c_Balanco, txt_4c_Titulo, opt_4c_Impressao)
397:     *--------------------------------------------------------------------------
398:     PROTECTED PROCEDURE ConfigurarPaginaDados()
399:         LOCAL loc_oPagina
400:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
401: 
402:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
403:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
404: 
405:         *-- Container botoes Confirmar/Cancelar (Grupo_Salva no legado)
406:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
407:         WITH loc_oPagina.cnt_4c_BotoesAcao
408:             .Top         = 33
409:             .Left        = 842
410:             .Width       = 160
411:             .Height      = 85
412:             .BackStyle   = 0
413:             .BorderWidth = 0
414:             .Visible     = .T.
415:         ENDWITH
416: 
417:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
418:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
419:             .Caption         = "Confirmar"
420:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
421:             .PicturePosition = 13
422:             .Top             = 5
423:             .Left            = 5
424:             .Width           = 75
425:             .Height          = 75
426:             .BackColor       = RGB(255, 255, 255)
427:             .ForeColor       = RGB(90, 90, 90)
428:             .FontName        = "Comic Sans MS"
429:             .FontSize        = 8
430:             .FontBold        = .T.
431:             .FontItalic      = .T.
432:             .Themes          = .F.
433:             .SpecialEffect   = 0
434:             .MousePointer    = 15
435:             .WordWrap        = .T.
436:             .AutoSize        = .F.
437:             .Visible         = .T.
438:         ENDWITH
439:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
440: 
441:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
442:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
443:             .Caption         = "Encerrar"
444:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
445:             .PicturePosition = 13
446:             .Top             = 5
447:             .Left            = 80
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
463:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
464: 
465:         *-- Label: Demonstrativo (Say1: Top=195, Left=210, Height=15 -> Top +29=224)
466:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
467:         WITH loc_oPagina.lbl_4c_Label1
468:             .Caption   = "Demonstrativo : "
469:             .Top       = 224
470:             .Left      = 210
471:             .Height    = 15
472:             .Width     = 87
473:             .AutoSize  = .F.
474:             .FontName  = "Tahoma"
475:             .FontSize  = 8
476:             .ForeColor = RGB(90, 90, 90)
477:             .BackStyle = 0
478:             .Visible   = .T.
479:         ENDWITH
480: 
481:         *-- Label: Titulo (Say2: Top=220, Left=254 -> Top +29=249)
482:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
483:         WITH loc_oPagina.lbl_4c_Label2
484:             .Caption   = "T" + CHR(237) + "tulo : "
485:             .Top       = 249
486:             .Left      = 254
487:             .Height    = 15
488:             .Width     = 43
489:             .AutoSize  = .F.
490:             .FontName  = "Tahoma"
491:             .FontSize  = 8
492:             .ForeColor = RGB(90, 90, 90)
493:             .BackStyle = 0
494:             .Visible   = .T.
495:         ENDWITH
496: 
497:         *-- Label: Impressao (Say3: Top=247, Left=230 -> Top +29=276)
498:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
499:         WITH loc_oPagina.lbl_4c_Label3
500:             .Caption   = "Impress" + CHR(227) + "o : "
501:             .Top       = 276
502:             .Left      = 230
503:             .Height    = 15

*-- Linhas 547 a 637:
547:             .Visible   = .T.
548:         ENDWITH
549: 
550:         *-- OptionGroup Impressao (fwoption1: Top=242, Left=299, Width=239, Height=27 -> Top +29=271)
551:         *-- Option1="Plano de Contas" (Value=1), Option2="Mapa de Contas" (Value=2)
552:         *-- ATENCAO: NAO setar .Value em Buttons(N) - causa todos radios marcados
553:         loc_oPagina.AddObject("opt_4c_Impressao", "OptionGroup")
554:         loc_oPagina.opt_4c_Impressao.ButtonCount = 2
555:         WITH loc_oPagina.opt_4c_Impressao
556:             .Value       = 1
557:             .Top         = 271
558:             .Left        = 299
559:             .Width       = 246
560:             .Height      = 27
561:             .BackStyle   = 0
562:             .BorderStyle = 0
563:             .TabIndex    = 3
564:             .Visible     = .T.
565:         ENDWITH
566: 
567:         WITH loc_oPagina.opt_4c_Impressao.Buttons(1)
568:             .Caption   = "Plano de Contas"
569:             .Top       = 5
570:             .Left      = 5
571:             .Width     = 110
572:             .Height    = 17
573:             .FontName  = "Tahoma"
574:             .FontSize  = 8
575:             .ForeColor = RGB(90, 90, 90)
576:             .BackStyle = 0
577:         ENDWITH
578: 
579:         WITH loc_oPagina.opt_4c_Impressao.Buttons(2)
580:             .Caption   = "Mapa de Contas"
581:             .Top       = 5
582:             .Left      = 126
583:             .Width     = 110
584:             .Height    = 17
585:             .FontName  = "Tahoma"
586:             .FontSize  = 8
587:             .ForeColor = RGB(90, 90, 90)
588:             .BackStyle = 0
589:         ENDWITH
590: 
591:         THIS.TornarControlesVisiveis(loc_oPagina)
592:     ENDPROC
593: 
594:     *--------------------------------------------------------------------------
595:     * CarregarLista - Executa Buscar() e configura RecordSource/Colunas/Headers
596:     *--------------------------------------------------------------------------
597:     PROCEDURE CarregarLista()
598:         LOCAL loc_lSucesso, loc_oGrid
599:         loc_lSucesso = .F.
600: 
601:         TRY
602:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
603:                 loc_lSucesso = .T.
604:             ELSE
605:                 IF !THIS.this_oBusinessObject.Buscar("")
606:                     loc_lSucesso = .F.
607:                 ELSE
608:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
609: 
610:                     *-- RecordSource e ColumnCount FORA de WITH (Problema 36)
611:                     loc_oGrid.RecordSource = THIS.this_cCursorDados
612:                     loc_oGrid.ColumnCount  = 3
613: 
614:                     *-- ControlSources APOS RecordSource (Problema 48: auto-bind reseta)
615:                     loc_oGrid.Column1.ControlSource = THIS.this_cCursorDados + ".Balancos"
616:                     loc_oGrid.Column2.ControlSource = THIS.this_cCursorDados + ".Titulos"
617:                     loc_oGrid.Column3.ControlSource = ;
618:                         "IIF(cursor_4c_Dados.Mapas=2,'MAPA','PLANO')"
619: 
620:                     *-- Headers APOS RecordSource (Problema 6/32: VFP reseta headers)
621:                     loc_oGrid.Column1.Header1.Caption = "Demonstrativo"
622:                     loc_oGrid.Column2.Header1.Caption = "T" + CHR(237) + "tulo"
623:                     loc_oGrid.Column3.Header1.Caption = "Impress" + CHR(227) + "o"
624: 
625:                     *-- Larguras conforme legado
626:                     loc_oGrid.Column1.Width = 150
627:                     loc_oGrid.Column2.Width = 290
628:                     loc_oGrid.Column3.Width = 75
629: 
630:                     *-- DynamicForeColor: Mapa de Contas em azul, Plano em preto (legado)
631:                     loc_oGrid.SetAll("DynamicForeColor", ;
632:                         "IIF(cursor_4c_Dados.Mapas=2,RGB(0,0,255),RGB(0,0,0))", ;
633:                         "Column")
634: 
635:                     THIS.FormatarGridLista(loc_oGrid)
636:                     loc_oGrid.Refresh()
637:                     loc_lSucesso = .T.

*-- Linhas 648 a 1034:
648:     *--------------------------------------------------------------------------
649:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
650:     *--------------------------------------------------------------------------
651:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
652:         LOCAL loc_lSucesso
653:         loc_lSucesso = .F.
654: 
655:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
656:             loc_lSucesso = .F.
657:         ELSE
658:             TRY
659:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
660: 
661:                 IF par_nPagina = 1
662:                     THIS.this_cModoAtual = "LISTA"
663:                     THIS.CarregarLista()
664:                 ENDIF
665: 
666:                 loc_lSucesso = .T.
667:             CATCH TO loc_oErro
668:                 MsgErro("Erro ao alternar pagina:" + CHR(13) + loc_oErro.Message, "Erro")
669:                 loc_lSucesso = .F.
670:             ENDTRY
671:         ENDIF
672: 
673:         RETURN loc_lSucesso
674:     ENDPROC
675: 
676:     *--------------------------------------------------------------------------
677:     * BtnIncluirClick - Prepara BO para INSERT e navega para Page2
678:     *--------------------------------------------------------------------------
679:     PROCEDURE BtnIncluirClick()
680:         THIS.this_oBusinessObject.NovoRegistro()
681:         THIS.LimparCampos()
682:         THIS.this_cModoAtual = "INCLUIR"
683:         THIS.HabilitarCampos(.T.)
684:         THIS.AjustarBotoesPorModo()
685:         THIS.AlternarPagina(2)
686:         IF TYPE("THIS.pgf_4c_Paginas.Page2.txt_4c_Balanco") = "O"
687:             THIS.pgf_4c_Paginas.Page2.txt_4c_Balanco.SetFocus
688:         ENDIF
689:     ENDPROC
690: 
691:     *--------------------------------------------------------------------------
692:     * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
693:     *--------------------------------------------------------------------------
694:     PROCEDURE BtnVisualizarClick()
695:         IF !USED(THIS.this_cCursorDados) OR EOF(THIS.this_cCursorDados) OR ;
696:            RECCOUNT(THIS.this_cCursorDados) = 0
697:             MsgAviso("Selecione um registro na lista.", "Visualizar")
698:             RETURN
699:         ENDIF
700: 
701:         LOCAL loc_cBalanco
702:         SELECT cursor_4c_Dados
703:         loc_cBalanco = ALLTRIM(cursor_4c_Dados.Balancos)
704: 
705:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cBalanco)
706:             THIS.this_cModoAtual = "VISUALIZAR"
707:             THIS.BOParaForm()
708:             THIS.HabilitarCampos(.F.)
709:             THIS.AjustarBotoesPorModo()
710:             THIS.AlternarPagina(2)
711:             IF TYPE("THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar") = "O"
712:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus
713:             ENDIF
714:         ENDIF
715:     ENDPROC
716: 
717:     *--------------------------------------------------------------------------
718:     * BtnAlterarClick - Carrega registro para edicao e navega para Page2
719:     *--------------------------------------------------------------------------
720:     PROCEDURE BtnAlterarClick()
721:         IF !USED(THIS.this_cCursorDados) OR EOF(THIS.this_cCursorDados) OR ;
722:            RECCOUNT(THIS.this_cCursorDados) = 0
723:             MsgAviso("Selecione um registro na lista.", "Alterar")
724:             RETURN
725:         ENDIF
726: 
727:         LOCAL loc_cBalanco
728:         SELECT cursor_4c_Dados
729:         loc_cBalanco = ALLTRIM(cursor_4c_Dados.Balancos)
730: 
731:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cBalanco)
732:             THIS.this_oBusinessObject.EditarRegistro()
733:             THIS.this_cModoAtual = "ALTERAR"
734:             THIS.BOParaForm()
735:             THIS.HabilitarCampos(.T.)
736:             THIS.AjustarBotoesPorModo()
737:             THIS.AlternarPagina(2)
738:             IF TYPE("THIS.pgf_4c_Paginas.Page2.txt_4c_Titulo") = "O"
739:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Titulo.SetFocus
740:             ENDIF
741:         ENDIF
742:     ENDPROC
743: 
744:     *--------------------------------------------------------------------------
745:     * BtnExcluirClick - Carrega registro para confirmacao de exclusao
746:     *--------------------------------------------------------------------------
747:     PROCEDURE BtnExcluirClick()
748:         IF !USED(THIS.this_cCursorDados) OR EOF(THIS.this_cCursorDados) OR ;
749:            RECCOUNT(THIS.this_cCursorDados) = 0
750:             MsgAviso("Selecione um registro na lista.", "Excluir")
751:             RETURN
752:         ENDIF
753: 
754:         LOCAL loc_cBalanco
755:         SELECT cursor_4c_Dados
756:         loc_cBalanco = ALLTRIM(cursor_4c_Dados.Balancos)
757: 
758:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cBalanco)
759:             THIS.this_cModoAtual = "EXCLUIR"
760:             THIS.BOParaForm()
761:             THIS.HabilitarCampos(.F.)
762:             THIS.AjustarBotoesPorModo()
763:             THIS.AlternarPagina(2)
764:             IF TYPE("THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar") = "O"
765:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
766:             ENDIF
767:         ENDIF
768:     ENDPROC
769: 
770:     *--------------------------------------------------------------------------
771:     * BtnBuscarClick - Abre picker e posiciona grade no registro selecionado
772:     * Pattern A canonico: SQL no caller + DefinirCursor + Mostrar
773:     *--------------------------------------------------------------------------
774:     PROCEDURE BtnBuscarClick()
775:         LOCAL loc_nSQL, loc_cBalanco, loc_oBusca
776:         loc_cBalanco = ""
777: 
778:         TRY
779:             loc_nSQL = SQLEXEC(gnConnHandle, ;
780:                 "SELECT Balancos, Titulos FROM SigCdMrr ORDER BY Balancos", ;
781:                 "cursor_4c_BuscaMrc")
782: 
783:             IF loc_nSQL >= 0
784:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
785:                 IF VARTYPE(loc_oBusca) = "O"
786:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaMrc", "Balancos", "Titulos", ;
787:                         "Buscar Demonstrativo")
788:                     IF loc_oBusca.Mostrar()
789:                         loc_cBalanco = ALLTRIM(loc_oBusca.cCodigoSelecionado)
790:                     ENDIF
791:                     loc_oBusca.Release()
792:                 ENDIF
793:             ELSE
794:                 MsgErro("Erro ao buscar demonstrativos: " + CapturarErroSQL(), "Erro SQL")
795:             ENDIF
796:         CATCH TO loc_oErro
797:             MsgErro("Erro ao buscar demonstrativo:" + CHR(13) + loc_oErro.Message, "Erro")
798:         ENDTRY
799: 
800:         IF USED("cursor_4c_BuscaMrc")
801:             USE IN cursor_4c_BuscaMrc
802:         ENDIF
803: 
804:         IF !EMPTY(loc_cBalanco) AND USED(THIS.this_cCursorDados)
805:             SELECT cursor_4c_Dados
806:             LOCATE FOR ALLTRIM(Balancos) == loc_cBalanco
807:             THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
808:         ENDIF
809:     ENDPROC
810: 
811:     *--------------------------------------------------------------------------
812:     * BtnEncerrarClick - Fecha o formulario
813:     *--------------------------------------------------------------------------
814:     PROCEDURE BtnEncerrarClick()
815:         THIS.Release()
816:     ENDPROC
817: 
818:     *--------------------------------------------------------------------------
819:     * BtnItensClick - Abre formulario de Itens do Demonstrativo (SigCdCmr)
820:     * Legado: do form SigCdCmr with Thisform,thisform.datasessionid
821:     *--------------------------------------------------------------------------
822:     PROCEDURE BtnItensClick()
823:         IF !USED(THIS.this_cCursorDados) OR EOF(THIS.this_cCursorDados) OR ;
824:            RECCOUNT(THIS.this_cCursorDados) = 0
825:             MsgAviso("Selecione um demonstrativo para visualizar seus itens.", "Itens")
826:             RETURN
827:         ENDIF
828: 
829:         LOCAL loc_cBalanco, loc_oItens
830:         SELECT cursor_4c_Dados
831:         loc_cBalanco = ALLTRIM(cursor_4c_Dados.Balancos)
832: 
833:         TRY
834:             loc_oItens = CREATEOBJECT("FormCmr", loc_cBalanco)
835:             IF VARTYPE(loc_oItens) = "O"
836:                 loc_oItens.Show()
837:             ELSE
838:                 MsgErro("Erro ao criar formul" + CHR(225) + "rio de Itens." + CHR(13) + ;
839:                     "VARTYPE retornou: " + VARTYPE(loc_oItens), "Erro")
840:             ENDIF
841:         CATCH TO loc_oErro
842:             LOCAL loc_cMsg
843:             loc_cMsg = "Erro ao abrir Itens do Demonstrativo:" + CHR(13) + CHR(13) + ;
844:                        "Erro: " + loc_oErro.Message + CHR(13) + ;
845:                        "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
846:                        "Procedure: " + loc_oErro.Procedure
847:             MsgErro(loc_cMsg, "Erro Detalhado")
848:         ENDTRY
849:     ENDPROC
850: 
851:     *--------------------------------------------------------------------------
852:     * BtnSalvarClick - Confirmar na Page2: salva em INCLUIR/ALTERAR, exclui em EXCLUIR
853:     *--------------------------------------------------------------------------
854:     PROCEDURE BtnSalvarClick()
855:         *-- VISUALIZAR: apenas voltar para lista
856:         IF THIS.this_cModoAtual = "VISUALIZAR"
857:             THIS.this_cModoAtual = "LISTA"
858:             THIS.AlternarPagina(1)
859:             RETURN
860:         ENDIF
861: 
862:         *-- EXCLUIR: confirmar e executar exclusao cascade (SigCdMri + SigCdMrr)
863:         IF THIS.this_cModoAtual = "EXCLUIR"
864:             IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do demonstrativo?" + CHR(13) + ;
865:                 "Todos os itens associados tamb" + CHR(233) + "m ser" + CHR(227) + "o exclu" + ;
866:                 CHR(237) + "dos.", "Excluir")
867:                 RETURN
868:             ENDIF
869:             IF THIS.this_oBusinessObject.Excluir()
870:                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.")
871:                 THIS.this_cModoAtual = "LISTA"
872:                 THIS.AlternarPagina(1)
873:             ENDIF
874:             RETURN
875:         ENDIF
876: 
877:         *-- INCLUIR / ALTERAR: validar campo obrigatorio Balancos
878:         IF TYPE("THIS.pgf_4c_Paginas.Page2.txt_4c_Balanco") = "O"
879:             IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Balanco.Value))
880:                 MsgAviso("Demonstrativo " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
881:                     "Valida" + CHR(231) + CHR(227) + "o")
882:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Balanco.SetFocus
883:                 RETURN
884:             ENDIF
885:         ENDIF
886: 
887:         THIS.FormParaBO()
888: 
889:         IF !THIS.this_oBusinessObject.ValidarDados()
890:             IF TYPE("THIS.pgf_4c_Paginas.Page2.txt_4c_Balanco") = "O"
891:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Balanco.SetFocus
892:             ENDIF
893:             RETURN
894:         ENDIF
895: 
896:         IF THIS.this_oBusinessObject.Salvar()
897:             MsgInfo("Registro salvo com sucesso.")
898:             THIS.this_cModoAtual = "LISTA"
899:             THIS.AlternarPagina(1)
900:         ENDIF
901:     ENDPROC
902: 
903:     *--------------------------------------------------------------------------
904:     * BtnCancelarClick - Cancela edicao e retorna para lista
905:     *--------------------------------------------------------------------------
906:     PROCEDURE BtnCancelarClick()
907:         THIS.this_cModoAtual = "LISTA"
908:         THIS.AlternarPagina(1)
909:     ENDPROC
910: 
911:     *--------------------------------------------------------------------------
912:     * FormParaBO - Transfere valores dos campos do Form para as propriedades do BO
913:     *--------------------------------------------------------------------------
914:     PROTECTED PROCEDURE FormParaBO()
915:         LOCAL loc_oPagina
916:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
917: 
918:         IF TYPE("loc_oPagina.txt_4c_Balanco") = "O"
919:             THIS.this_oBusinessObject.this_cBalanco = ALLTRIM(loc_oPagina.txt_4c_Balanco.Value)
920:             THIS.this_oBusinessObject.this_cTitulo  = ALLTRIM(loc_oPagina.txt_4c_Titulo.Value)
921:             THIS.this_oBusinessObject.this_nMapa    = loc_oPagina.opt_4c_Impressao.Value
922:         ENDIF
923:     ENDPROC
924: 
925:     *--------------------------------------------------------------------------
926:     * BOParaForm - Transfere propriedades do BO para os campos do Form
927:     *--------------------------------------------------------------------------
928:     PROTECTED PROCEDURE BOParaForm()
929:         LOCAL loc_oPagina
930:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
931: 
932:         IF TYPE("loc_oPagina.txt_4c_Balanco") = "O"
933:             loc_oPagina.txt_4c_Balanco.Value   = THIS.this_oBusinessObject.this_cBalanco
934:             loc_oPagina.txt_4c_Titulo.Value    = THIS.this_oBusinessObject.this_cTitulo
935:             loc_oPagina.opt_4c_Impressao.Value = THIS.this_oBusinessObject.this_nMapa
936:         ENDIF
937:     ENDPROC
938: 
939:     *--------------------------------------------------------------------------
940:     * LimparCampos - Limpa valores dos campos da Page2
941:     *--------------------------------------------------------------------------
942:     PROTECTED PROCEDURE LimparCampos()
943:         LOCAL loc_oPagina
944:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
945: 
946:         IF TYPE("loc_oPagina.txt_4c_Balanco") = "O"
947:             loc_oPagina.txt_4c_Balanco.Value   = ""
948:             loc_oPagina.txt_4c_Titulo.Value    = ""
949:             loc_oPagina.opt_4c_Impressao.Value = 1
950:         ENDIF
951:     ENDPROC
952: 
953:     *--------------------------------------------------------------------------
954:     * HabilitarCampos - Habilita ou desabilita campos editaveis da Page2
955:     *--------------------------------------------------------------------------
956:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
957:         LOCAL loc_oPagina
958:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
959: 
960:         IF TYPE("loc_oPagina.txt_4c_Balanco") = "O"
961:             *-- Balanco editavel apenas em INCLUIR (chave primaria nao pode ser alterada)
962:             loc_oPagina.txt_4c_Balanco.Enabled   = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
963:             loc_oPagina.txt_4c_Titulo.Enabled    = par_lHabilitar
964:             loc_oPagina.opt_4c_Impressao.Enabled = par_lHabilitar
965:         ENDIF
966:     ENDPROC
967: 
968:     *--------------------------------------------------------------------------
969:     * AjustarBotoesPorModo - Habilita Confirmar apenas em modos que permitem acao
970:     *--------------------------------------------------------------------------
971:     PROTECTED PROCEDURE AjustarBotoesPorModo()
972:         LOCAL loc_oPg2
973:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
974: 
975:         IF TYPE("loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar") = "O"
976:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = ;
977:                 INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "EXCLUIR")
978:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
979:         ENDIF
980:     ENDPROC
981: 
982:     *--------------------------------------------------------------------------
983:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
984:     *--------------------------------------------------------------------------
985:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
986:         LOCAL loc_nI, loc_oObjeto, loc_nP
987: 
988:         FOR loc_nI = 1 TO par_oContainer.ControlCount
989:             loc_oObjeto = par_oContainer.Controls(loc_nI)
990: 
991:             IF VARTYPE(loc_oObjeto) = "O"
992:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
993:                     loc_oObjeto.Visible = .T.
994:                 ENDIF
995: 
996:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
997:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
998:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
999:                     ENDFOR
1000:                 ENDIF
1001: 
1002:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
1003:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1004:                 ENDIF
1005:             ENDIF
1006:         ENDFOR
1007:     ENDPROC
1008: 
1009:     *--------------------------------------------------------------------------
1010:     * FormatarGridLista - Formata visual da grade (Tahoma 8 conforme legado)
1011:     *--------------------------------------------------------------------------
1012:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1013:         WITH par_oGrid
1014:             .FontName = "Tahoma"
1015:             .FontSize = 8
1016:         ENDWITH
1017:     ENDPROC
1018: 
1019:     *--------------------------------------------------------------------------
1020:     * Destroy - Libera recursos ao fechar o formulario
1021:     *--------------------------------------------------------------------------
1022:     PROCEDURE Destroy()
1023:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1024:             THIS.this_oBusinessObject = .NULL.
1025:         ENDIF
1026: 
1027:         IF USED(THIS.this_cCursorDados)
1028:             USE IN (THIS.this_cCursorDados)
1029:         ENDIF
1030: 
1031:         DODEFAULT()
1032:     ENDPROC
1033: 
1034: ENDDEFINE


### BO (C:\4c\projeto\app\classes\MrcBO.prg):
*==============================================================================
* MrcBO.prg - Business Object para Cadastro de Demonstrativos
* Tabela principal: SigCdMrr (Demonstrativos)
* Tabela relacionada: SigCdMri (Itens do Demonstrativo)
*==============================================================================
DEFINE CLASS MrcBO AS BusinessBase

    *-- Propriedades da entidade SigCdMrr
    this_cBalanco   = ""   && balancos char(20) - chave primaria
    this_cTitulo    = ""   && titulos  char(40)
    this_nMapa      = 1    && mapas    numeric(1,0): 1=Plano de Contas, 2=Mapa de Contas

    *-- Nome do cursor principal
    this_cCursorDados = "cursor_4c_Dados"

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdMrr"
        THIS.this_cCampoChave = "Balancos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cBalanco
    ENDFUNC

    *--------------------------------------------------------------------------
    * NovoRegistro - Prepara BO para INSERT
    *--------------------------------------------------------------------------
    PROCEDURE NovoRegistro()
        DODEFAULT()
        THIS.this_cBalanco = ""
        THIS.this_cTitulo  = ""
        THIS.this_nMapa    = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * EditarRegistro - Prepara BO para UPDATE
    *--------------------------------------------------------------------------
    PROCEDURE EditarRegistro()
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cBalanco = TratarNulo(Balancos, "C")
            THIS.this_cTitulo  = TratarNulo(Titulos,  "C")
            THIS.this_nMapa    = TratarNulo(Mapas,    "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cBalanco))
            THIS.this_cMensagemErro = "Demonstrativo " + CHR(233) + " obrigat" + CHR(243) + "rio."
            MsgAviso(THIS.this_cMensagemErro, "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Seleciona registros de SigCdMrr para a grade
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE Balancos LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
            ENDIF

            loc_cSQL = "SELECT Balancos, Titulos, Mapas" + ;
                       " FROM SigCdMrr" + ;
                       loc_cWhere + ;
                       " ORDER BY Balancos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar demonstrativos: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao buscar demonstrativos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um demonstrativo pelo codigo (Balancos)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Balancos, Titulos, Mapas" + ;
                       " FROM SigCdMrr" + ;
                       " WHERE Balancos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                THIS.this_cMensagemErro = "Demonstrativo n" + CHR(227) + "o encontrado."
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao carregar demonstrativo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Verifica se Balancos ja existe em SigCdMrr
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdMrr" + ;
                       " WHERE Balancos = " + EscaparSQL(THIS.this_cBalanco)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupChk")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DupChk") > 0
                SELECT cursor_4c_DupChk
                loc_lExiste = (cursor_4c_DupChk.Total > 0)
            ENDIF

            IF USED("cursor_4c_DupChk")
                USE IN cursor_4c_DupChk
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_DupChk")
                USE IN cursor_4c_DupChk
            ENDIF
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo demonstrativo em SigCdMrr (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.VerificarDuplicidade()
                THIS.this_cMensagemErro = "Demonstrativo j" + CHR(225) + " cadastrado."
                MsgAviso(THIS.this_cMensagemErro, "Registro Duplicado")
                loc_lSucesso = .F.
            ELSE
                loc_cSQL = "INSERT INTO SigCdMrr (Balancos, Titulos, Mapas)" + ;
                           " VALUES (" + EscaparSQL(THIS.this_cBalanco) + ;
                           ", " + EscaparSQL(THIS.this_cTitulo) + ;
                           ", " + FormatarNumeroSQL(THIS.this_nMapa) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao inserir demonstrativo: " + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                ENDIF

                IF USED("cursor_4c_Ins")
                    USE IN cursor_4c_Ins
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inserir demonstrativo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza demonstrativo existente em SigCdMrr (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdMrr" + ;
                       " SET Titulos = " + EscaparSQL(THIS.this_cTitulo) + ;
                       ", Mapas = " + FormatarNumeroSQL(THIS.this_nMapa) + ;
                       " WHERE Balancos = " + EscaparSQL(THIS.this_cBalanco)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar demonstrativo: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao atualizar demonstrativo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui demonstrativo e seus itens (PROTECTED)
    * Cascade: DELETE SigCdMri primeiro, depois SigCdMrr
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- 1. Excluir itens do demonstrativo (SigCdMri) - cascade
            loc_cSQL = "DELETE FROM SigCdMri WHERE Balancos = " + EscaparSQL(THIS.this_cBalanco)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelMri")

            IF USED("cursor_4c_DelMri")
                USE IN cursor_4c_DelMri
            ENDIF

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Erro ao excluir itens: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                loc_lSucesso = .F.
            ELSE
                *-- 2. Excluir o demonstrativo principal (SigCdMrr)
                loc_cSQL = "DELETE FROM SigCdMrr WHERE Balancos = " + EscaparSQL(THIS.this_cBalanco)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelMrr")

                IF USED("cursor_4c_DelMrr")
                    USE IN cursor_4c_DelMrr
                ENDIF

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao excluir demonstrativo: " + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao excluir demonstrativo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_DelMri")
                USE IN cursor_4c_DelMri
            ENDIF
            IF USED("cursor_4c_DelMrr")
                USE IN cursor_4c_DelMrr
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

