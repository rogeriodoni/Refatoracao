# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (6)
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH ENDWITH define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDWITH.RecordSource).
- [LAYOUT-POSITION] Controle 'optProvs' (parent: SIGCDESP.Pagina.Dados): Top original=185 vs migrado 'opt_4c_OptProvs' Top=5 (diff=180px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optProvs' (parent: SIGCDESP.Pagina.Dados): Left original=319 vs migrado 'opt_4c_OptProvs' Left=5 (diff=314px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptObrigs' (parent: SIGCDESP.Pagina.Dados): Top original=209 vs migrado 'opt_4c_OptObrigs' Top=5 (diff=204px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptObrigs' (parent: SIGCDESP.Pagina.Dados): Left original=319 vs migrado 'opt_4c_OptObrigs' Left=5 (diff=314px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormEsp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1098 linhas total):

*-- Linhas 26 a 154:
26:     *==========================================================================
27:     * Init - Inicializa o formulario
28:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
29:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
30:     *==========================================================================
31:     PROCEDURE Init()
32:         RETURN DODEFAULT()
33:     ENDPROC
34: 
35:     *==========================================================================
36:     * InicializarForm - Configura estrutura completa
37:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
38:     *==========================================================================
39:     PROTECTED PROCEDURE InicializarForm()
40:         LOCAL loc_lSucesso
41:         loc_lSucesso = .F.
42: 
43:         TRY
44:             THIS.Caption = "Cadastro de Esp" + CHR(233) + "cies"
45:             THIS.this_oBusinessObject = CREATEOBJECT("EspBO")
46: 
47:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
48:                 MostrarErro("Erro ao criar EspBO" + CHR(13) + ;
49:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
50:                     "FormEsp.InicializarForm")
51:             ELSE
52:                 THIS.ConfigurarPageFrame()
53:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
54:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
55:                 THIS.pgf_4c_Paginas.Visible  = .T.
56:                 THIS.pgf_4c_Paginas.ActivePage = 1
57:                 THIS.this_cModoAtual = "LISTA"
58: 
59:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
60:                     THIS.CarregarLista()
61:                 ENDIF
62: 
63:                 loc_lSucesso = .T.
64:             ENDIF
65: 
66:         CATCH TO loc_oErro
67:             MostrarErro("Erro ao inicializar FormEsp:" + CHR(13) + ;
68:                 loc_oErro.Message + CHR(13) + ;
69:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
70:                 "FormEsp.InicializarForm")
71:         ENDTRY
72: 
73:         RETURN loc_lSucesso
74:     ENDPROC
75: 
76:     *==========================================================================
77:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
78:     * Top=-29 esconde abas; controles compensam +29 no Top
79:     *==========================================================================
80:     PROTECTED PROCEDURE ConfigurarPageFrame()
81:         LOCAL loc_nFormWidth, loc_nFormHeight
82:         loc_nFormWidth  = THIS.Width
83:         loc_nFormHeight = THIS.Height
84:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
85: 
86:         WITH THIS.pgf_4c_Paginas
87:             .PageCount = 2
88:             .Top       = -29
89:             .Left      = 0
90:             .Width     = loc_nFormWidth
91:             .Height    = loc_nFormHeight + 29
92:             .Tabs      = .F.
93:             .Visible   = .T.
94: 
95:             .Page1.Caption   = "Lista"
96:             .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
97:             .Page1.BackColor = RGB(255, 255, 255)
98: 
99:             .Page2.Caption   = "Dados"
100:             .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
101:             .Page2.BackColor = RGB(255, 255, 255)
102:         ENDWITH
103: 
104:         THIS.ConfigurarPaginaLista()
105:         THIS.ConfigurarPaginaDados()
106:     ENDPROC
107: 
108:     *==========================================================================
109:     * ConfigurarPaginaLista - Configura Page1 com containers base
110:     * Legado: cntSombra.Top=1, Grupo_op.Top=-1, Grupo_Saida.Top=-1 (Left=918)
111:     * Compensacao PageFrame: +29 em todos os Tops
112:     * Canonical Saida: Left=917 (CLAUDE.md regra #10 prevalece sobre legado)
113:     *==========================================================================
114:     PROTECTED PROCEDURE ConfigurarPaginaLista()
115:         LOCAL loc_oPagina, loc_oGrid, loc_nFormWidth
116:         loc_oPagina    = THIS.pgf_4c_Paginas.Page1
117:         loc_nFormWidth = THIS.Width
118: 
119:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
120:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
121: 
122:         *-- Container Cabecalho (cntSombra no legado: Top=1, Left=-1, Width=1008, Height=80)
123:         *-- Compensado: Top=1+29=30. Width=THIS.Width (canonical: nao subtrair por cnt_4c_Saida)
124:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
125:         WITH loc_oPagina.cnt_4c_Cabecalho
126:             .Top         = 30
127:             .Left        = -1
128:             .Width       = loc_nFormWidth
129:             .Height      = 80
130:             .BackColor   = RGB(100, 100, 100)
131:             .BorderWidth = 0
132:             .Visible     = .T.
133:         ENDWITH
134: 
135:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
136:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
137:             .Caption   = THIS.Caption
138:             .Top       = 15
139:             .Left      = 10
140:             .Width     = 769
141:             .Height    = 40
142:             .FontName  = "Tahoma"
143:             .FontSize  = 16
144:             .FontBold  = .T.
145:             .ForeColor = RGB(0, 0, 0)
146:             .BackStyle = 0
147:             .AutoSize  = .F.
148:             .Visible   = .T.
149:         ENDWITH
150: 
151:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
152:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
153:             .Caption   = THIS.Caption
154:             .Top       = 18

*-- Linhas 200 a 484:
200:             .AutoSize        = .F.
201:             .Visible         = .T.
202:         ENDWITH
203:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
204: 
205:         *-- Botao Visualizar
206:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
207:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
208:             .Caption         = "Visualizar"
209:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
210:             .PicturePosition = 13
211:             .Top             = 5
212:             .Left            = 80
213:             .Width           = 75
214:             .Height          = 75
215:             .FontName        = "Tahoma"
216:             .FontBold        = .T.
217:             .FontItalic      = .T.
218:             .FontSize        = 8
219:             .ForeColor       = RGB(90, 90, 90)
220:             .BackColor       = RGB(255, 255, 255)
221:             .Themes          = .F.
222:             .SpecialEffect   = 0
223:             .MousePointer    = 15
224:             .WordWrap        = .T.
225:             .AutoSize        = .F.
226:             .Visible         = .T.
227:         ENDWITH
228:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
229: 
230:         *-- Botao Alterar
231:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
232:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
233:             .Caption         = "Alterar"
234:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
235:             .PicturePosition = 13
236:             .Top             = 5
237:             .Left            = 155
238:             .Width           = 75
239:             .Height          = 75
240:             .FontName        = "Tahoma"
241:             .FontBold        = .T.
242:             .FontItalic      = .T.
243:             .FontSize        = 8
244:             .ForeColor       = RGB(90, 90, 90)
245:             .BackColor       = RGB(255, 255, 255)
246:             .Themes          = .F.
247:             .SpecialEffect   = 0
248:             .MousePointer    = 15
249:             .WordWrap        = .T.
250:             .AutoSize        = .F.
251:             .Visible         = .T.
252:         ENDWITH
253:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
254: 
255:         *-- Botao Excluir
256:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
257:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
258:             .Caption         = "Excluir"
259:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
260:             .PicturePosition = 13
261:             .Top             = 5
262:             .Left            = 230
263:             .Width           = 75
264:             .Height          = 75
265:             .FontName        = "Tahoma"
266:             .FontBold        = .T.
267:             .FontItalic      = .T.
268:             .FontSize        = 8
269:             .ForeColor       = RGB(90, 90, 90)
270:             .BackColor       = RGB(255, 255, 255)
271:             .Themes          = .F.
272:             .SpecialEffect   = 0
273:             .MousePointer    = 15
274:             .WordWrap        = .T.
275:             .AutoSize        = .F.
276:             .Visible         = .T.
277:         ENDWITH
278:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
279: 
280:         *-- Botao Buscar
281:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
282:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
283:             .Caption         = "Buscar"
284:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
285:             .PicturePosition = 13
286:             .Top             = 5
287:             .Left            = 305
288:             .Width           = 75
289:             .Height          = 75
290:             .FontName        = "Tahoma"
291:             .FontBold        = .T.
292:             .FontItalic      = .T.
293:             .FontSize        = 8
294:             .ForeColor       = RGB(90, 90, 90)
295:             .BackColor       = RGB(255, 255, 255)
296:             .Themes          = .F.
297:             .SpecialEffect   = 0
298:             .MousePointer    = 15
299:             .WordWrap        = .T.
300:             .AutoSize        = .F.
301:             .Visible         = .T.
302:         ENDWITH
303:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
304: 
305:         *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10 prevalece sobre legado)
306:         *-- Legado: Grupo_Saida.Left=918, Top=-1. Canonico: Left=917, Top=29, Width=90
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
327:             .FontName        = "Tahoma"
328:             .FontBold        = .T.
329:             .FontItalic      = .T.
330:             .FontSize        = 8
331:             .ForeColor       = RGB(90, 90, 90)
332:             .BackColor       = RGB(255, 255, 255)
333:             .Themes          = .F.
334:             .SpecialEffect   = 0
335:             .MousePointer    = 15
336:             .WordWrap        = .T.
337:             .AutoSize        = .F.
338:             .Visible         = .T.
339:         ENDWITH
340:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
341: 
342:         *-- Grid de listagem (Grade no legado: Top=121, Left=12, Width=971, Height=470)
343:         *-- Compensado: Top=121+29=150. Width ajustado para nao sobrepor cnt_4c_Saida (Left=917)
344:         *-- Colunas: Especies (150) e Descs (290) conforme layout original
345:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
346:         loc_oGrid = loc_oPagina.grd_4c_Lista
347:         loc_oGrid.Top         = 150
348:         loc_oGrid.Left        = 12
349:         loc_oGrid.Width       = 900
350:         loc_oGrid.Height      = 470
351:         loc_oGrid.ColumnCount = 2
352:         WITH loc_oGrid
353:             .FontName           = "Verdana"
354:             .FontSize           = 8
355:             .ForeColor          = RGB(90, 90, 90)
356:             .BackColor          = RGB(255, 255, 255)
357:             .GridLineColor      = RGB(238, 238, 238)
358:             .GridLines          = 3
359:             .HighlightBackColor = RGB(255, 255, 255)
360:             .HighlightForeColor = RGB(15, 41, 104)
361:             .HighlightStyle     = 2
362:             .DeleteMark         = .F.
363:             .RecordMark         = .F.
364:             .RowHeight          = 16
365:             .ScrollBars         = 2
366:             .Visible            = .T.
367:         ENDWITH
368: 
369:         THIS.TornarControlesVisiveis(loc_oPagina)
370:     ENDPROC
371: 
372:     *==========================================================================
373:     * ConfigurarPaginaDados - Configura Page2: botoes + campos (Fases 5-6)
374:     * Legado: Grupo_Salva.Left=836, Top=-6, Width=161, Height=85
375:     * Compensacao PageFrame: +29 em todos os Tops
376:     *==========================================================================
377:     PROTECTED PROCEDURE ConfigurarPaginaDados()
378:         LOCAL loc_oPagina
379:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
380: 
381:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
382:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
383: 
384:         *-- Container BotoesAcao (Grupo_Salva: Left=836, Top=-6; compensado: Top=23)
385:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
386:         WITH loc_oPagina.cnt_4c_BotoesAcao
387:             .Top         = 23
388:             .Left        = 836
389:             .Width       = 161
390:             .Height      = 85
391:             .BackStyle   = 0
392:             .BorderWidth = 0
393:             .Visible     = .T.
394:         ENDWITH
395: 
396:         *-- Botao Confirmar (Salva: Left=5, Top=5)
397:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
398:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
399:             .Caption         = "Confirmar"
400:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
401:             .PicturePosition = 13
402:             .Top             = 5
403:             .Left            = 5
404:             .Width           = 75
405:             .Height          = 75
406:             .FontName        = "Tahoma"
407:             .FontBold        = .T.
408:             .FontItalic      = .T.
409:             .FontSize        = 8
410:             .ForeColor       = RGB(90, 90, 90)
411:             .BackColor       = RGB(255, 255, 255)
412:             .Themes          = .F.
413:             .SpecialEffect   = 0
414:             .MousePointer    = 15
415:             .WordWrap        = .T.
416:             .AutoSize        = .F.
417:             .Visible         = .T.
418:         ENDWITH
419:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
420: 
421:         *-- Botao Cancelar (Cancelar: Left=81, Top=5)
422:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
423:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
424:             .Caption         = "Encerrar"
425:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
426:             .PicturePosition = 13
427:             .Top             = 5
428:             .Left            = 81
429:             .Width           = 75
430:             .Height          = 75
431:             .FontName        = "Tahoma"
432:             .FontBold        = .T.
433:             .FontItalic      = .T.
434:             .FontSize        = 8
435:             .ForeColor       = RGB(90, 90, 90)
436:             .BackColor       = RGB(255, 255, 255)
437:             .Themes          = .F.
438:             .SpecialEffect   = 0
439:             .MousePointer    = 15
440:             .WordWrap        = .T.
441:             .AutoSize        = .F.
442:             .Visible         = .T.
443:         ENDWITH
444:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
445: 
446:         *-- Label Codigo (Say1: Top=136, Left=278, Width=42, Height=15; compensado Top=165)
447:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
448:         WITH loc_oPagina.lbl_4c_Label1
449:             .Caption   = "C" + CHR(243) + "digo :"
450:             .Top       = 165
451:             .Left      = 278
452:             .Width     = 42
453:             .Height    = 15
454:             .FontName  = "Tahoma"
455:             .FontSize  = 8
456:             .FontBold  = .F.
457:             .ForeColor = RGB(90, 90, 90)
458:             .BackStyle = 0
459:             .AutoSize  = .F.
460:             .Visible   = .T.
461:         ENDWITH
462: 
463:         *-- TextBox Codigo (getCodigo: Top=133, Left=323, Width=52; compensado Top=162)
464:         *-- Format=K! (uppercase+select), MaxLength=6, SpecialEffect=1 (flat border)
465:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
466:         WITH loc_oPagina.txt_4c_Codigo
467:             .Value         = ""
468:             .Top           = 162
469:             .Left          = 323
470:             .Width         = 52
471:             .Height        = 23
472:             .MaxLength     = 6
473:             .Format        = "K!"
474:             .SpecialEffect = 1
475:             .FontName      = "Tahoma"
476:             .FontSize      = 8
477:             .ForeColor     = RGB(0, 0, 0)
478:             .Enabled       = .F.
479:             .Visible       = .T.
480:         ENDWITH
481: 
482:         *-- Label Descricao (Say2: Top=162, Left=265, Width=55, Height=15; compensado Top=191)
483:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
484:         WITH loc_oPagina.lbl_4c_Label2

*-- Linhas 532 a 1098:
532:             .Visible   = .T.
533:         ENDWITH
534: 
535:         *-- OptionGroup Provs (optProvs: Top=185, Left=319; compensado Top=214)
536:         *-- ControlSource=crSigCdEsp.Provs; Option1=Com Provisao(Left=5), Option2=Sem Provisao(Left=110)
537:         loc_oPagina.AddObject("opt_4c_OptProvs", "OptionGroup")
538:         WITH loc_oPagina.opt_4c_OptProvs
539:             .ButtonCount = 2
540:             .AutoSize    = .T.
541:             .BackStyle   = 0
542:             .BorderStyle = 0
543:             .Enabled     = .F.
544:             .Visible     = .T.
545:             WITH .Buttons(1)
546:                 .Caption   = "Com Provis" + CHR(227) + "o"
547:                 .Left      = 5
548:                 .Top       = 5
549:                 .AutoSize  = .T.
550:                 .ForeColor = RGB(90, 90, 90)
551:                 .Themes    = .F.
552:             ENDWITH
553:             WITH .Buttons(2)
554:                 .Caption   = "Sem Provis" + CHR(227) + "o"
555:                 .Left      = 110
556:                 .Top       = 5
557:                 .AutoSize  = .T.
558:                 .FontName  = "Tahoma"
559:                 .FontSize  = 8
560:                 .ForeColor = RGB(90, 90, 90)
561:                 .Themes    = .F.
562:             ENDWITH
563:         ENDWITH
564:         loc_oPagina.opt_4c_OptProvs.Top  = 214
565:         loc_oPagina.opt_4c_OptProvs.Left = 319
566: 
567:         *-- Label Obrigatorio Dados Bancarios (Say4: Top=214, Left=175, Width=145, Height=15; compensado Top=243)
568:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
569:         WITH loc_oPagina.lbl_4c_Label4
570:             .Caption   = "Obrigat" + CHR(243) + "rio Dados Banc" + CHR(225) + "rios :"
571:             .Top       = 243
572:             .Left      = 175
573:             .Width     = 145
574:             .Height    = 15
575:             .FontName  = "Tahoma"
576:             .FontSize  = 8
577:             .FontBold  = .F.
578:             .ForeColor = RGB(90, 90, 90)
579:             .BackStyle = 0
580:             .AutoSize  = .F.
581:             .Visible   = .T.
582:         ENDWITH
583: 
584:         *-- OptionGroup Obrigs (OptObrigs: Top=209, Left=319; compensado Top=238)
585:         *-- ControlSource=crSigCdEsp.Obrigs; Option1=Sim(Left=5), Option2=Nao(Left=58)
586:         loc_oPagina.AddObject("opt_4c_OptObrigs", "OptionGroup")
587:         WITH loc_oPagina.opt_4c_OptObrigs
588:             .ButtonCount = 2
589:             .AutoSize    = .T.
590:             .BackStyle   = 0
591:             .BorderStyle = 0
592:             .Enabled     = .F.
593:             .Visible     = .T.
594:             WITH .Buttons(1)
595:                 .Caption   = "Sim"
596:                 .Left      = 5
597:                 .Top       = 5
598:                 .AutoSize  = .T.
599:                 .ForeColor = RGB(90, 90, 90)
600:                 .Themes    = .F.
601:             ENDWITH
602:             WITH .Buttons(2)
603:                 .Caption   = "N" + CHR(227) + "o"
604:                 .Left      = 58
605:                 .Top       = 5
606:                 .AutoSize  = .T.
607:                 .FontName  = "Tahoma"
608:                 .FontSize  = 8
609:                 .ForeColor = RGB(90, 90, 90)
610:                 .Themes    = .F.
611:             ENDWITH
612:         ENDWITH
613:         loc_oPagina.opt_4c_OptObrigs.Top  = 238
614:         loc_oPagina.opt_4c_OptObrigs.Left = 319
615: 
616:         THIS.TornarControlesVisiveis(loc_oPagina)
617:     ENDPROC
618: 
619:     *==========================================================================
620:     * CarregarLista - Carrega dados no grid via BO.Buscar()
621:     * Cursor: cursor_4c_Dados (criado pelo BO)
622:     * Colunas: especies (150px), descs (290px) conforme layout original
623:     *==========================================================================
624:     PROCEDURE CarregarLista()
625:         LOCAL loc_lResultado, loc_oGrid
626:         loc_lResultado = .F.
627: 
628:         TRY
629:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
630:                 loc_lResultado = .T.
631:             ELSE
632:                 IF THIS.this_oBusinessObject.Buscar("")
633:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
634:                     loc_oGrid.ColumnCount = 2
635:                     loc_oGrid.RecordSource             = "cursor_4c_Dados"
636:                     loc_oGrid.ColumnCount = 2
637:                     loc_oGrid.Column1.ControlSource    = "cursor_4c_Dados.especies"
638:                     loc_oGrid.Column2.ControlSource    = "cursor_4c_Dados.descs"
639:                     loc_oGrid.Column1.Width            = 150
640:                     loc_oGrid.Column2.Width            = 290
641:                     loc_oGrid.Column1.Header1.Caption  = "Esp" + CHR(233) + "cie"
642:                     loc_oGrid.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
643:                     THIS.FormatarGridLista(loc_oGrid)
644:                     loc_lResultado = .T.
645:                 ENDIF
646:             ENDIF
647:         CATCH TO loc_oErro
648:             MsgErro("Erro em CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
649:             loc_lResultado = .F.
650:         ENDTRY
651: 
652:         RETURN loc_lResultado
653:     ENDPROC
654: 
655:     *==========================================================================
656:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
657:     *==========================================================================
658:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
659:         LOCAL loc_lResultado
660:         loc_lResultado = .F.
661: 
662:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
663:             RETURN .F.
664:         ENDIF
665: 
666:         TRY
667:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
668: 
669:             IF par_nPagina = 1
670:                 THIS.this_cModoAtual = "LISTA"
671:                 THIS.CarregarLista()
672:             ENDIF
673: 
674:             loc_lResultado = .T.
675:         CATCH TO loc_oErro
676:             MsgErro("Erro em AlternarPagina:" + CHR(13) + loc_oErro.Message, "Erro")
677:         ENDTRY
678: 
679:         RETURN loc_lResultado
680:     ENDPROC
681: 
682:     *==========================================================================
683:     * BtnEncerrarClick - Fecha o formulario
684:     *==========================================================================
685:     PROCEDURE BtnEncerrarClick()
686:         THIS.Release()
687:     ENDPROC
688: 
689:     *==========================================================================
690:     * BtnIncluirClick - Prepara Page2 para inclusao de novo registro
691:     * Legado: pcEscolha=[INSERIR], foca getCodigo
692:     *==========================================================================
693:     PROCEDURE BtnIncluirClick()
694:         LOCAL loc_lResultado
695:         loc_lResultado = .F.
696: 
697:         TRY
698:             THIS.this_oBusinessObject.NovoRegistro()
699:             THIS.this_cModoAtual = "INCLUIR"
700:             THIS.LimparCampos()
701:             THIS.HabilitarCampos(.T.)
702:             THIS.AlternarPagina(2)
703:             loc_lResultado = .T.
704:         CATCH TO loc_oErro
705:             MsgErro("Erro em BtnIncluirClick:" + CHR(13) + loc_oErro.Message, "Erro")
706:         ENDTRY
707: 
708:         RETURN loc_lResultado
709:     ENDPROC
710: 
711:     *==========================================================================
712:     * BtnVisualizarClick - Carrega registro selecionado em modo leitura
713:     * Legado: pcEscolha=[CONSULTAR], foca Grupo_Salva.Salva
714:     *==========================================================================
715:     PROCEDURE BtnVisualizarClick()
716:         LOCAL loc_lResultado, loc_cCodigo
717:         loc_lResultado = .F.
718: 
719:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
720:             MsgAviso("Nenhum registro selecionado para visualizar.", ;
721:                      "Aten" + CHR(231) + CHR(227) + "o")
722:             RETURN .F.
723:         ENDIF
724: 
725:         TRY
726:             SELECT cursor_4c_Dados
727:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.especies)
728: 
729:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
730:                 THIS.this_cModoAtual = "VISUALIZAR"
731:                 THIS.BOParaForm()
732:                 THIS.HabilitarCampos(.F.)
733:                 THIS.AlternarPagina(2)
734:                 loc_lResultado = .T.
735:             ELSE
736:                 MsgAviso("Registro n" + CHR(227) + "o encontrado.", ;
737:                          "Aten" + CHR(231) + CHR(227) + "o")
738:             ENDIF
739:         CATCH TO loc_oErro
740:             MsgErro("Erro em BtnVisualizarClick:" + CHR(13) + loc_oErro.Message, "Erro")
741:         ENDTRY
742: 
743:         RETURN loc_lResultado
744:     ENDPROC
745: 
746:     *==========================================================================
747:     * BtnAlterarClick - Carrega registro selecionado para edicao
748:     * Legado: pcEscolha=[ALTERAR], foca getDescs
749:     *==========================================================================
750:     PROCEDURE BtnAlterarClick()
751:         LOCAL loc_lResultado, loc_cCodigo
752:         loc_lResultado = .F.
753: 
754:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
755:             MsgAviso("Nenhum registro selecionado para alterar.", ;
756:                      "Aten" + CHR(231) + CHR(227) + "o")
757:             RETURN .F.
758:         ENDIF
759: 
760:         TRY
761:             SELECT cursor_4c_Dados
762:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.especies)
763: 
764:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
765:                 THIS.this_oBusinessObject.EditarRegistro()
766:                 THIS.this_cModoAtual = "ALTERAR"
767:                 THIS.BOParaForm()
768:                 THIS.HabilitarCampos(.T.)
769:                 THIS.AlternarPagina(2)
770:                 loc_lResultado = .T.
771:             ELSE
772:                 MsgAviso("Registro n" + CHR(227) + "o encontrado.", ;
773:                          "Aten" + CHR(231) + CHR(227) + "o")
774:             ENDIF
775:         CATCH TO loc_oErro
776:             MsgErro("Erro em BtnAlterarClick:" + CHR(13) + loc_oErro.Message, "Erro")
777:         ENDTRY
778: 
779:         RETURN loc_lResultado
780:     ENDPROC
781: 
782:     *==========================================================================
783:     * BtnExcluirClick - Confirma e exclui registro selecionado
784:     * Legado: pcEscolha=[EXCLUIR], verifica uso em SigMvCcr e SigCdOpe antes de excluir
785:     *==========================================================================
786:     PROCEDURE BtnExcluirClick()
787:         LOCAL loc_lResultado, loc_cCodigo
788: 
789:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
790:             MsgAviso("Nenhum registro selecionado para excluir.", ;
791:                      "Aten" + CHR(231) + CHR(227) + "o")
792:             RETURN .F.
793:         ENDIF
794: 
795:         SELECT cursor_4c_Dados
796:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.especies)
797: 
798:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da esp" + CHR(233) + ;
799:                         "cie '" + loc_cCodigo + "'?", ;
800:                         "Confirmar Exclus" + CHR(227) + "o")
801:             RETURN .F.
802:         ENDIF
803: 
804:         loc_lResultado = .F.
805: 
806:         TRY
807:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
808:                 IF THIS.this_oBusinessObject.Excluir()
809:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
810:                     THIS.CarregarLista()
811:                     loc_lResultado = .T.
812:                 ENDIF
813:             ELSE
814:                 MsgAviso("Registro n" + CHR(227) + "o encontrado.", ;
815:                          "Aten" + CHR(231) + CHR(227) + "o")
816:             ENDIF
817:         CATCH TO loc_oErro
818:             MsgErro("Erro em BtnExcluirClick:" + CHR(13) + loc_oErro.Message, "Erro")
819:         ENDTRY
820: 
821:         RETURN loc_lResultado
822:     ENDPROC
823: 
824:     *==========================================================================
825:     * BtnBuscarClick - Recarrega lista com todos os registros
826:     *==========================================================================
827:     PROCEDURE BtnBuscarClick()
828:         LOCAL loc_lResultado
829:         loc_lResultado = .F.
830: 
831:         TRY
832:             loc_lResultado = THIS.CarregarLista()
833:         CATCH TO loc_oErro
834:             MsgErro("Erro em BtnBuscarClick:" + CHR(13) + loc_oErro.Message, "Erro")
835:         ENDTRY
836: 
837:         RETURN loc_lResultado
838:     ENDPROC
839: 
840:     *==========================================================================
841:     * BtnSalvarClick - Valida e salva o registro (Confirmar na Page2)
842:     * Legado: ChkRegister([SigCdEsp]) apos validar Especies, Descs, Provs
843:     *==========================================================================
844:     PROCEDURE BtnSalvarClick()
845:         LOCAL loc_lResultado
846:         loc_lResultado = .F.
847: 
848:         THIS.FormParaBO()
849: 
850:         IF !THIS.this_oBusinessObject.Validar()
851:             RETURN .F.
852:         ENDIF
853: 
854:         IF THIS.this_cModoAtual = "INCLUIR"
855:             IF THIS.this_oBusinessObject.VerificarDuplicidade()
856:                 RETURN .F.
857:             ENDIF
858:         ENDIF
859: 
860:         TRY
861:             IF THIS.this_oBusinessObject.Salvar()
862:                 MsgInfo("Registro salvo com sucesso!", "Sucesso")
863:                 THIS.this_cModoAtual = "LISTA"
864:                 THIS.AlternarPagina(1)
865:                 loc_lResultado = .T.
866:             ENDIF
867:         CATCH TO loc_oErro
868:             MsgErro("Erro ao salvar:" + CHR(13) + loc_oErro.Message, "Erro")
869:         ENDTRY
870: 
871:         RETURN loc_lResultado
872:     ENDPROC
873: 
874:     *==========================================================================
875:     * BtnCancelarClick - Cancela operacao e volta para lista
876:     *==========================================================================
877:     PROCEDURE BtnCancelarClick()
878:         THIS.this_cModoAtual = "LISTA"
879:         THIS.AlternarPagina(1)
880:         THIS.CarregarLista()
881:     ENDPROC
882: 
883:     *==========================================================================
884:     * FormParaBO - Transfere valores dos campos do Form para o BO
885:     * Legado: ChkRegister le do cursor crSigCdEsp via ControlSource
886:     *==========================================================================
887:     PROTECTED PROCEDURE FormParaBO()
888:         LOCAL loc_oPagina
889:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
890: 
891:         TRY
892:             IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
893:                 THIS.this_oBusinessObject.this_cEspecies = ;
894:                     ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
895:             ENDIF
896: 
897:             IF PEMSTATUS(loc_oPagina, "txt_4c_Descricao", 5)
898:                 THIS.this_oBusinessObject.this_cDescs = ;
899:                     ALLTRIM(loc_oPagina.txt_4c_Descricao.Value)
900:             ENDIF
901: 
902:             IF PEMSTATUS(loc_oPagina, "opt_4c_OptProvs", 5)
903:                 THIS.this_oBusinessObject.this_nProvs = ;
904:                     loc_oPagina.opt_4c_OptProvs.Value
905:             ENDIF
906: 
907:             IF PEMSTATUS(loc_oPagina, "opt_4c_OptObrigs", 5)
908:                 THIS.this_oBusinessObject.this_nObrigs = ;
909:                     loc_oPagina.opt_4c_OptObrigs.Value
910:             ENDIF
911:         CATCH TO loc_oErro
912:             MsgErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message, "Erro")
913:         ENDTRY
914:     ENDPROC
915: 
916:     *==========================================================================
917:     * BOParaForm - Transfere valores do BO para os campos do Form
918:     *==========================================================================
919:     PROTECTED PROCEDURE BOParaForm()
920:         LOCAL loc_oPagina
921:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
922: 
923:         TRY
924:             IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
925:                 loc_oPagina.txt_4c_Codigo.Value = ;
926:                     ALLTRIM(THIS.this_oBusinessObject.this_cEspecies)
927:             ENDIF
928: 
929:             IF PEMSTATUS(loc_oPagina, "txt_4c_Descricao", 5)
930:                 loc_oPagina.txt_4c_Descricao.Value = ;
931:                     ALLTRIM(THIS.this_oBusinessObject.this_cDescs)
932:             ENDIF
933: 
934:             IF PEMSTATUS(loc_oPagina, "opt_4c_OptProvs", 5)
935:                 loc_oPagina.opt_4c_OptProvs.Value = ;
936:                     THIS.this_oBusinessObject.this_nProvs
937:             ENDIF
938: 
939:             IF PEMSTATUS(loc_oPagina, "opt_4c_OptObrigs", 5)
940:                 loc_oPagina.opt_4c_OptObrigs.Value = ;
941:                     THIS.this_oBusinessObject.this_nObrigs
942:             ENDIF
943:         CATCH TO loc_oErro
944:             MsgErro("Erro em BOParaForm:" + CHR(13) + loc_oErro.Message, "Erro")
945:         ENDTRY
946:     ENDPROC
947: 
948:     *==========================================================================
949:     * LimparCampos - Limpa valores dos campos da Page2
950:     *==========================================================================
951:     PROTECTED PROCEDURE LimparCampos()
952:         LOCAL loc_oPagina
953:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
954: 
955:         TRY
956:             IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
957:                 loc_oPagina.txt_4c_Codigo.Value = ""
958:             ENDIF
959: 
960:             IF PEMSTATUS(loc_oPagina, "txt_4c_Descricao", 5)
961:                 loc_oPagina.txt_4c_Descricao.Value = ""
962:             ENDIF
963: 
964:             IF PEMSTATUS(loc_oPagina, "opt_4c_OptProvs", 5)
965:                 loc_oPagina.opt_4c_OptProvs.Value = 1
966:             ENDIF
967: 
968:             IF PEMSTATUS(loc_oPagina, "opt_4c_OptObrigs", 5)
969:                 loc_oPagina.opt_4c_OptObrigs.Value = 1
970:             ENDIF
971:         CATCH TO loc_oErro
972:             MsgErro("Erro em LimparCampos:" + CHR(13) + loc_oErro.Message, "Erro")
973:         ENDTRY
974:     ENDPROC
975: 
976:     *==========================================================================
977:     * HabilitarCampos - Habilita ou desabilita campos da Page2
978:     * Legado: When events por modo (INSERIR/ALTERAR/CONSULTAR)
979:     * getCodigo: habilitado em INCLUIR; getDescs/optProvs/optObrigs: INCLUIR e ALTERAR
980:     *==========================================================================
981:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
982:         LOCAL loc_oPagina, loc_lHabCodigo, loc_lHabDados
983:         loc_oPagina   = THIS.pgf_4c_Paginas.Page2
984:         loc_lHabCodigo = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
985:         loc_lHabDados  = par_lHabilitar AND ;
986:                          (THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR")
987: 
988:         TRY
989:             IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
990:                 loc_oPagina.txt_4c_Codigo.Enabled = loc_lHabCodigo
991:             ENDIF
992: 
993:             IF PEMSTATUS(loc_oPagina, "txt_4c_Descricao", 5)
994:                 loc_oPagina.txt_4c_Descricao.Enabled = loc_lHabDados
995:             ENDIF
996: 
997:             IF PEMSTATUS(loc_oPagina, "opt_4c_OptProvs", 5)
998:                 loc_oPagina.opt_4c_OptProvs.Enabled = loc_lHabDados
999:             ENDIF
1000: 
1001:             IF PEMSTATUS(loc_oPagina, "opt_4c_OptObrigs", 5)
1002:                 loc_oPagina.opt_4c_OptObrigs.Enabled = loc_lHabDados
1003:             ENDIF
1004: 
1005:             IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
1006:                 IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1007:                     loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lHabDados
1008:                 ENDIF
1009:             ENDIF
1010:         CATCH TO loc_oErro
1011:             MsgErro("Erro em HabilitarCampos:" + CHR(13) + loc_oErro.Message, "Erro")
1012:         ENDTRY
1013:     ENDPROC
1014: 
1015:     *==========================================================================
1016:     * FormatarGridLista - Formata visual do grid da lista
1017:     *==========================================================================
1018:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1019:         WITH par_oGrid
1020:             .FontName = "Tahoma"
1021:             .FontSize = 8
1022:         ENDWITH
1023:     ENDPROC
1024: 
1025:     *==========================================================================
1026:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1027:     * Itera Pages de PageFrames e Controls de Containers
1028:     *==========================================================================
1029:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1030:         LOCAL loc_nI, loc_oObjeto, loc_nP
1031: 
1032:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1033:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1034: 
1035:             IF VARTYPE(loc_oObjeto) = "O"
1036:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1037:                     loc_oObjeto.Visible = .T.
1038:                 ENDIF
1039: 
1040:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1041:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1042:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1043:                     ENDFOR
1044:                 ENDIF
1045: 
1046:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1047:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1048:                 ENDIF
1049:             ENDIF
1050:         ENDFOR
1051:     ENDPROC
1052: 
1053:     *==========================================================================
1054:     * AjustarBotoesPorModo - Habilita/desabilita botoes conforme o modo atual
1055:     * Page1: Alterar/Excluir/Visualizar habilitados somente se houver registro
1056:     * Page2: Confirmar habilitado somente em INCLUIR ou ALTERAR
1057:     *==========================================================================
1058:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1059:         LOCAL loc_oPagina1, loc_oPagina2, loc_lTemRegistro
1060:         loc_oPagina1    = THIS.pgf_4c_Paginas.Page1
1061:         loc_oPagina2    = THIS.pgf_4c_Paginas.Page2
1062:         loc_lTemRegistro = USED("cursor_4c_Dados") AND ;
1063:                            !EOF("cursor_4c_Dados") AND ;
1064:                            RECCOUNT("cursor_4c_Dados") > 0
1065: 
1066:         TRY
1067:             IF PEMSTATUS(loc_oPagina1, "cnt_4c_Botoes", 5)
1068:                 IF PEMSTATUS(loc_oPagina1.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
1069:                     loc_oPagina1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled = loc_lTemRegistro
1070:                 ENDIF
1071:                 IF PEMSTATUS(loc_oPagina1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
1072:                     loc_oPagina1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled = loc_lTemRegistro
1073:                 ENDIF
1074:                 IF PEMSTATUS(loc_oPagina1.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
1075:                     loc_oPagina1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
1076:                 ENDIF
1077:             ENDIF
1078: 
1079:             IF PEMSTATUS(loc_oPagina2, "cnt_4c_BotoesAcao", 5)
1080:                 IF PEMSTATUS(loc_oPagina2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1081:                     loc_oPagina2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = ;
1082:                         INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1083:                 ENDIF
1084:             ENDIF
1085:         CATCH TO loc_oErro
1086:             MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "Erro")
1087:         ENDTRY
1088:     ENDPROC
1089: 
1090:     *==========================================================================
1091:     * Destroy - Libera recursos
1092:     *==========================================================================
1093:     PROCEDURE Destroy()
1094:         THIS.this_oBusinessObject = .NULL.
1095:         DODEFAULT()
1096:     ENDPROC
1097: 
1098: ENDDEFINE


### BO (C:\4c\projeto\app\classes\EspBO.prg):
*==============================================================================
* EspBO.prg - Business Object para Cadastro de Especies
* Tabela: SigCdEsp
* Herda de: BusinessBase
*==============================================================================
DEFINE CLASS EspBO AS BusinessBase

    *-- Propriedades de configuracao da tabela
    this_cTabela      = "SigCdEsp"
    this_cCampoChave  = "especies"

    *-- Propriedades de dados (mapeiam colunas de SigCdEsp)
    this_cEspecies    = ""    && char(6) - PK
    this_cDescs       = ""    && char(40)
    this_nProvs       = 1     && numeric(1,0) - 1=Com Provisao, 2=Sem Provisao
    this_nObrigs      = 1     && numeric(1,0) - 1=Sim, 2=Nao

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdEsp"
        THIS.this_cCampoChave = "especies"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cEspecies
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cEspecies = TratarNulo(especies, "C")
            THIS.this_cDescs    = TratarNulo(descs,    "C")
            THIS.this_nProvs    = TratarNulo(provs,    "N")
            THIS.this_nObrigs   = TratarNulo(obrigs,   "N")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega lista de registros em cursor_4c_Dados
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT especies, descs, provs, obrigs" + ;
                       " FROM SigCdEsp" + ;
                       " ORDER BY especies"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = "SELECT especies, descs, provs, obrigs" + ;
                           " FROM SigCdEsp" + ;
                           " WHERE especies LIKE " + EscaparSQL(par_cFiltro + "%") + ;
                           " ORDER BY especies"
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado > 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar esp" + CHR(233) + "cies:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo codigo da especie
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT especies, descs, provs, obrigs" + ;
                       " FROM SigCdEsp" + ;
                       " WHERE especies = " + EscaparSQL(par_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdEsp (PROTECTED - chamado por Salvar)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdEsp (especies, descs, provs, obrigs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cEspecies) + ", " + ;
                       EscaparSQL(THIS.this_cDescs)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nProvs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nObrigs) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir esp" + CHR(233) + "cie:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdEsp (PROTECTED - chamado por Salvar)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdEsp SET" + ;
                       " descs  = " + EscaparSQL(THIS.this_cDescs)          + ", " + ;
                       " provs  = " + FormatarNumeroSQL(THIS.this_nProvs)   + ", " + ;
                       " obrigs = " + FormatarNumeroSQL(THIS.this_nObrigs)  + ;
                       " WHERE especies = " + EscaparSQL(THIS.this_cEspecies)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar esp" + CHR(233) + "cie:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdEsp (PROTECTED - chamado por Excluir)
    * Valida uso em SigMvCcr (EspecieNfs) e SigCdOpe (Especies) antes de excluir
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- Verificar uso em SigMvCcr
            loc_cSQL = "SELECT TOP 1 cIdChaves FROM SigMvCcr" + ;
                       " WHERE EspecieNfs = " + EscaparSQL(THIS.this_cEspecies)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkMvCcr")
                TABLEREVERT(.T., "cursor_4c_ChkMvCcr")
                USE IN cursor_4c_ChkMvCcr
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkMvCcr")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkMvCcr") > 0
                MsgAviso("A Esp" + CHR(233) + "cie Est" + CHR(225) + " Em Uso Nos T" + ;
                         CHR(237) + "tulos e N" + CHR(227) + "o Pode Ser Exclu" + ;
                         CHR(237) + "da!!!", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                *-- Verificar uso em SigCdOpe
                loc_cSQL = "SELECT TOP 1 Dopes FROM SigCdOpe" + ;
                           " WHERE Especies = " + EscaparSQL(THIS.this_cEspecies)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_ChkOpe")
                    TABLEREVERT(.T., "cursor_4c_ChkOpe")
                    USE IN cursor_4c_ChkOpe
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkOpe")

                IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkOpe") > 0
                    SELECT cursor_4c_ChkOpe
                    GO TOP
                    MsgAviso("A Esp" + CHR(233) + "cie Est" + CHR(225) + " Em Uso Na Opera" + ;
                             CHR(231) + CHR(227) + "o " + CHR(34) + ;
                             ALLTRIM(cursor_4c_ChkOpe.Dopes) + CHR(34) + ;
                             " e N" + CHR(227) + "o Pode Ser Exclu" + CHR(237) + "da!!!", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    *-- Sem dependencias - executar exclusao
                    loc_cSQL = "DELETE FROM SigCdEsp" + ;
                               " WHERE especies = " + EscaparSQL(THIS.this_cEspecies)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado > 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lResultado = .T.
                    ELSE
                        MsgErro("Erro ao excluir esp" + CHR(233) + "cie:" + CHR(13) + ;
                                CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF

                IF USED("cursor_4c_ChkOpe")
                    USE IN cursor_4c_ChkOpe
                ENDIF
            ENDIF

            IF USED("cursor_4c_ChkMvCcr")
                USE IN cursor_4c_ChkMvCcr
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Validar - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    FUNCTION Validar()
        LOCAL loc_lResultado
        loc_lResultado = .T.

        IF EMPTY(ALLTRIM(THIS.this_cEspecies))
            MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido!!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        IF loc_lResultado AND EMPTY(ALLTRIM(THIS.this_cDescs))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        IF loc_lResultado AND THIS.this_nProvs = 0
            MsgAviso("Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + ;
                     "bil Inv" + CHR(225) + "lida!!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Verifica se codigo ja existe (para INSERT)
    *--------------------------------------------------------------------------
    FUNCTION VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 especies FROM SigCdEsp" + ;
                       " WHERE especies = " + EscaparSQL(THIS.this_cEspecies)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkDup")
                TABLEREVERT(.T., "cursor_4c_ChkDup")
                USE IN cursor_4c_ChkDup
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDup")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkDup") > 0
                loc_lExiste = .T.
                MsgAviso("C" + CHR(243) + "digo J" + CHR(225) + " Cadastrado!!!", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF

            IF USED("cursor_4c_ChkDup")
                USE IN cursor_4c_ChkDup
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em VerificarDuplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

ENDDEFINE

