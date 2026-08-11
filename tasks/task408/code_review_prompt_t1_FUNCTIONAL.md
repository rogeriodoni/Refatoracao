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

### FORM (C:\4c\projeto\app\forms\cadastros\FormEsp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1093 linhas total):

*-- Linhas 26 a 151:
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
81:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
82: 
83:         WITH THIS.pgf_4c_Paginas
84:             .PageCount = 2
85:             .Top       = -29
86:             .Left      = 0
87:             .Width     = THIS.Width
88:             .Height    = THIS.Height + 29
89:             .Tabs      = .F.
90:             .Visible   = .T.
91: 
92:             .Page1.Caption   = "Lista"
93:             .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
94:             .Page1.BackColor = RGB(255, 255, 255)
95: 
96:             .Page2.Caption   = "Dados"
97:             .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
98:             .Page2.BackColor = RGB(255, 255, 255)
99:         ENDWITH
100: 
101:         THIS.ConfigurarPaginaLista()
102:         THIS.ConfigurarPaginaDados()
103:     ENDPROC
104: 
105:     *==========================================================================
106:     * ConfigurarPaginaLista - Configura Page1 com containers base
107:     * Legado: cntSombra.Top=1, Grupo_op.Top=-1, Grupo_Saida.Top=-1 (Left=918)
108:     * Compensacao PageFrame: +29 em todos os Tops
109:     * Canonical Saida: Left=917 (CLAUDE.md regra #10 prevalece sobre legado)
110:     *==========================================================================
111:     PROTECTED PROCEDURE ConfigurarPaginaLista()
112:         LOCAL loc_oPagina, loc_oGrid
113:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
114: 
115:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
116:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
117: 
118:         *-- Container Cabecalho (cntSombra no legado: Top=1, Left=-1, Width=1008, Height=80)
119:         *-- Compensado: Top=1+29=30. Width=THIS.Width (canonical: nao subtrair por cnt_4c_Saida)
120:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
121:         WITH loc_oPagina.cnt_4c_Cabecalho
122:             .Top         = 30
123:             .Left        = -1
124:             .Width       = THIS.Width
125:             .Height      = 80
126:             .BackColor   = RGB(100, 100, 100)
127:             .BorderWidth = 0
128:             .Visible     = .T.
129:         ENDWITH
130: 
131:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
132:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
133:             .Caption   = THIS.Caption
134:             .Top       = 15
135:             .Left      = 10
136:             .Width     = 769
137:             .Height    = 40
138:             .FontName  = "Tahoma"
139:             .FontSize  = 16
140:             .FontBold  = .T.
141:             .ForeColor = RGB(0, 0, 0)
142:             .BackStyle = 0
143:             .AutoSize  = .F.
144:             .Visible   = .T.
145:         ENDWITH
146: 
147:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
148:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
149:             .Caption   = THIS.Caption
150:             .Top       = 18
151:             .Left      = 10

*-- Linhas 196 a 480:
196:             .AutoSize        = .F.
197:             .Visible         = .T.
198:         ENDWITH
199:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
200: 
201:         *-- Botao Visualizar
202:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
203:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
204:             .Caption         = "Visualizar"
205:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
206:             .PicturePosition = 13
207:             .Top             = 5
208:             .Left            = 80
209:             .Width           = 75
210:             .Height          = 75
211:             .FontName        = "Comic Sans MS"
212:             .FontBold        = .T.
213:             .FontItalic      = .T.
214:             .FontSize        = 8
215:             .ForeColor       = RGB(90, 90, 90)
216:             .BackColor       = RGB(255, 255, 255)
217:             .Themes          = .F.
218:             .SpecialEffect   = 0
219:             .MousePointer    = 15
220:             .WordWrap        = .T.
221:             .AutoSize        = .F.
222:             .Visible         = .T.
223:         ENDWITH
224:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
225: 
226:         *-- Botao Alterar
227:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
228:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
229:             .Caption         = "Alterar"
230:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
231:             .PicturePosition = 13
232:             .Top             = 5
233:             .Left            = 155
234:             .Width           = 75
235:             .Height          = 75
236:             .FontName        = "Comic Sans MS"
237:             .FontBold        = .T.
238:             .FontItalic      = .T.
239:             .FontSize        = 8
240:             .ForeColor       = RGB(90, 90, 90)
241:             .BackColor       = RGB(255, 255, 255)
242:             .Themes          = .F.
243:             .SpecialEffect   = 0
244:             .MousePointer    = 15
245:             .WordWrap        = .T.
246:             .AutoSize        = .F.
247:             .Visible         = .T.
248:         ENDWITH
249:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
250: 
251:         *-- Botao Excluir
252:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
253:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
254:             .Caption         = "Excluir"
255:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
256:             .PicturePosition = 13
257:             .Top             = 5
258:             .Left            = 230
259:             .Width           = 75
260:             .Height          = 75
261:             .FontName        = "Comic Sans MS"
262:             .FontBold        = .T.
263:             .FontItalic      = .T.
264:             .FontSize        = 8
265:             .ForeColor       = RGB(90, 90, 90)
266:             .BackColor       = RGB(255, 255, 255)
267:             .Themes          = .F.
268:             .SpecialEffect   = 0
269:             .MousePointer    = 15
270:             .WordWrap        = .T.
271:             .AutoSize        = .F.
272:             .Visible         = .T.
273:         ENDWITH
274:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
275: 
276:         *-- Botao Buscar
277:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
278:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
279:             .Caption         = "Buscar"
280:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
281:             .PicturePosition = 13
282:             .Top             = 5
283:             .Left            = 305
284:             .Width           = 75
285:             .Height          = 75
286:             .FontName        = "Comic Sans MS"
287:             .FontBold        = .T.
288:             .FontItalic      = .T.
289:             .FontSize        = 8
290:             .ForeColor       = RGB(90, 90, 90)
291:             .BackColor       = RGB(255, 255, 255)
292:             .Themes          = .F.
293:             .SpecialEffect   = 0
294:             .MousePointer    = 15
295:             .WordWrap        = .T.
296:             .AutoSize        = .F.
297:             .Visible         = .T.
298:         ENDWITH
299:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
300: 
301:         *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10 prevalece sobre legado)
302:         *-- Legado: Grupo_Saida.Left=918, Top=-1. Canonico: Left=917, Top=29, Width=90
303:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
304:         WITH loc_oPagina.cnt_4c_Saida
305:             .Top         = 29
306:             .Left        = 917
307:             .Width       = 90
308:             .Height      = 85
309:             .BackStyle   = 0
310:             .BorderWidth = 0
311:             .Visible     = .T.
312:         ENDWITH
313: 
314:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
315:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
316:             .Caption         = "Encerrar"
317:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
318:             .PicturePosition = 13
319:             .Top             = 5
320:             .Left            = 5
321:             .Width           = 75
322:             .Height          = 75
323:             .FontName        = "Tahoma"
324:             .FontBold        = .T.
325:             .FontItalic      = .T.
326:             .FontSize        = 8
327:             .ForeColor       = RGB(90, 90, 90)
328:             .BackColor       = RGB(255, 255, 255)
329:             .Themes          = .F.
330:             .SpecialEffect   = 0
331:             .MousePointer    = 15
332:             .WordWrap        = .T.
333:             .AutoSize        = .F.
334:             .Visible         = .T.
335:         ENDWITH
336:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
337: 
338:         *-- Grid de listagem (Grade no legado: Top=121, Left=12, Width=971, Height=470)
339:         *-- Compensado: Top=121+29=150. Width ajustado para nao sobrepor cnt_4c_Saida (Left=917)
340:         *-- Colunas: Especies (150) e Descs (290) conforme layout original
341:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
342:         loc_oGrid = loc_oPagina.grd_4c_Lista
343:         loc_oGrid.Top         = 150
344:         loc_oGrid.Left        = 12
345:         loc_oGrid.Width       = 900
346:         loc_oGrid.Height      = 470
347:         loc_oGrid.ColumnCount = 2
348:         WITH loc_oGrid
349:             .FontName           = "Verdana"
350:             .FontSize           = 8
351:             .ForeColor          = RGB(90, 90, 90)
352:             .BackColor          = RGB(255, 255, 255)
353:             .GridLineColor      = RGB(238, 238, 238)
354:             .GridLines          = 3
355:             .HighlightBackColor = RGB(255, 255, 255)
356:             .HighlightForeColor = RGB(15, 41, 104)
357:             .HighlightStyle     = 2
358:             .DeleteMark         = .F.
359:             .RecordMark         = .F.
360:             .RowHeight          = 16
361:             .ScrollBars         = 2
362:             .Visible            = .T.
363:         ENDWITH
364: 
365:         THIS.TornarControlesVisiveis(loc_oPagina)
366:     ENDPROC
367: 
368:     *==========================================================================
369:     * ConfigurarPaginaDados - Configura Page2: botoes + campos (Fases 5-6)
370:     * Legado: Grupo_Salva.Left=836, Top=-6, Width=161, Height=85
371:     * Compensacao PageFrame: +29 em todos os Tops
372:     *==========================================================================
373:     PROTECTED PROCEDURE ConfigurarPaginaDados()
374:         LOCAL loc_oPagina
375:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
376: 
377:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
378:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
379: 
380:         *-- Container BotoesAcao (Grupo_Salva: Left=836, Top=-6; compensado: Top=23)
381:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
382:         WITH loc_oPagina.cnt_4c_BotoesAcao
383:             .Top         = 23
384:             .Left        = 836
385:             .Width       = 161
386:             .Height      = 85
387:             .BackStyle   = 0
388:             .BorderWidth = 0
389:             .Visible     = .T.
390:         ENDWITH
391: 
392:         *-- Botao Confirmar (Salva: Left=5, Top=5)
393:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
394:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
395:             .Caption         = "Confirmar"
396:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
397:             .PicturePosition = 13
398:             .Top             = 5
399:             .Left            = 5
400:             .Width           = 75
401:             .Height          = 75
402:             .FontName        = "Comic Sans MS"
403:             .FontBold        = .T.
404:             .FontItalic      = .T.
405:             .FontSize        = 8
406:             .ForeColor       = RGB(90, 90, 90)
407:             .BackColor       = RGB(255, 255, 255)
408:             .Themes          = .F.
409:             .SpecialEffect   = 0
410:             .MousePointer    = 15
411:             .WordWrap        = .T.
412:             .AutoSize        = .F.
413:             .Visible         = .T.
414:         ENDWITH
415:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
416: 
417:         *-- Botao Cancelar (Cancelar: Left=81, Top=5)
418:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
419:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
420:             .Caption         = "Encerrar"
421:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
422:             .PicturePosition = 13
423:             .Top             = 5
424:             .Left            = 81
425:             .Width           = 75
426:             .Height          = 75
427:             .FontName        = "Comic Sans MS"
428:             .FontBold        = .T.
429:             .FontItalic      = .T.
430:             .FontSize        = 8
431:             .ForeColor       = RGB(90, 90, 90)
432:             .BackColor       = RGB(255, 255, 255)
433:             .Themes          = .F.
434:             .SpecialEffect   = 0
435:             .MousePointer    = 15
436:             .WordWrap        = .T.
437:             .AutoSize        = .F.
438:             .Visible         = .T.
439:         ENDWITH
440:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
441: 
442:         *-- Label Codigo (Say1: Top=136, Left=278, Width=42, Height=15; compensado Top=165)
443:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
444:         WITH loc_oPagina.lbl_4c_Label1
445:             .Caption   = "C" + CHR(243) + "digo :"
446:             .Top       = 165
447:             .Left      = 278
448:             .Width     = 42
449:             .Height    = 15
450:             .FontName  = "Tahoma"
451:             .FontSize  = 8
452:             .FontBold  = .F.
453:             .ForeColor = RGB(90, 90, 90)
454:             .BackStyle = 0
455:             .AutoSize  = .F.
456:             .Visible   = .T.
457:         ENDWITH
458: 
459:         *-- TextBox Codigo (getCodigo: Top=133, Left=323, Width=52; compensado Top=162)
460:         *-- Format=K! (uppercase+select), MaxLength=6, SpecialEffect=1 (flat border)
461:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
462:         WITH loc_oPagina.txt_4c_Codigo
463:             .Value         = ""
464:             .Top           = 162
465:             .Left          = 323
466:             .Width         = 52
467:             .Height        = 23
468:             .MaxLength     = 6
469:             .Format        = "K!"
470:             .SpecialEffect = 1
471:             .FontName      = "Tahoma"
472:             .FontSize      = 8
473:             .ForeColor     = RGB(0, 0, 0)
474:             .Enabled       = .F.
475:             .Visible       = .T.
476:         ENDWITH
477: 
478:         *-- Label Descricao (Say2: Top=162, Left=265, Width=55, Height=15; compensado Top=191)
479:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
480:         WITH loc_oPagina.lbl_4c_Label2

*-- Linhas 528 a 1093:
528:             .Visible   = .T.
529:         ENDWITH
530: 
531:         *-- OptionGroup Provs (optProvs: Top=185, Left=319; compensado Top=214)
532:         *-- ControlSource=crSigCdEsp.Provs; Option1=Com Provisao(Left=5), Option2=Sem Provisao(Left=110)
533:         loc_oPagina.AddObject("opt_4c_OptProvs", "OptionGroup")
534:         WITH loc_oPagina.opt_4c_OptProvs
535:             .ButtonCount = 2
536:             .Top         = 214
537:             .Left        = 319
538:             .AutoSize    = .T.
539:             .BackStyle   = 0
540:             .BorderStyle = 0
541:             .Enabled     = .F.
542:             .Visible     = .T.
543:             WITH .Buttons(1)
544:                 .Caption   = "Com Provis" + CHR(227) + "o"
545:                 .Left      = 5
546:                 .Top       = 5
547:                 .AutoSize  = .T.
548:                 .ForeColor = RGB(90, 90, 90)
549:                 .Themes    = .F.
550:             ENDWITH
551:             WITH .Buttons(2)
552:                 .Caption   = "Sem Provis" + CHR(227) + "o"
553:                 .Left      = 110
554:                 .Top       = 5
555:                 .AutoSize  = .T.
556:                 .FontName  = "Tahoma"
557:                 .FontSize  = 8
558:                 .ForeColor = RGB(90, 90, 90)
559:                 .Themes    = .F.
560:             ENDWITH
561:         ENDWITH
562: 
563:         *-- Label Obrigatorio Dados Bancarios (Say4: Top=214, Left=175, Width=145, Height=15; compensado Top=243)
564:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
565:         WITH loc_oPagina.lbl_4c_Label4
566:             .Caption   = "Obrigat" + CHR(243) + "rio Dados Banc" + CHR(225) + "rios :"
567:             .Top       = 243
568:             .Left      = 175
569:             .Width     = 145
570:             .Height    = 15
571:             .FontName  = "Tahoma"
572:             .FontSize  = 8
573:             .FontBold  = .F.
574:             .ForeColor = RGB(90, 90, 90)
575:             .BackStyle = 0
576:             .AutoSize  = .F.
577:             .Visible   = .T.
578:         ENDWITH
579: 
580:         *-- OptionGroup Obrigs (OptObrigs: Top=209, Left=319; compensado Top=238)
581:         *-- ControlSource=crSigCdEsp.Obrigs; Option1=Sim(Left=5), Option2=Nao(Left=58)
582:         loc_oPagina.AddObject("opt_4c_OptObrigs", "OptionGroup")
583:         WITH loc_oPagina.opt_4c_OptObrigs
584:             .ButtonCount = 2
585:             .Top         = 238
586:             .Left        = 319
587:             .AutoSize    = .T.
588:             .BackStyle   = 0
589:             .BorderStyle = 0
590:             .Enabled     = .F.
591:             .Visible     = .T.
592:             WITH .Buttons(1)
593:                 .Caption   = "Sim"
594:                 .Left      = 5
595:                 .Top       = 5
596:                 .AutoSize  = .T.
597:                 .ForeColor = RGB(90, 90, 90)
598:                 .Themes    = .F.
599:             ENDWITH
600:             WITH .Buttons(2)
601:                 .Caption   = "N" + CHR(227) + "o"
602:                 .Left      = 58
603:                 .Top       = 5
604:                 .AutoSize  = .T.
605:                 .FontName  = "Tahoma"
606:                 .FontSize  = 8
607:                 .ForeColor = RGB(90, 90, 90)
608:                 .Themes    = .F.
609:             ENDWITH
610:         ENDWITH
611: 
612:         THIS.TornarControlesVisiveis(loc_oPagina)
613:     ENDPROC
614: 
615:     *==========================================================================
616:     * CarregarLista - Carrega dados no grid via BO.Buscar()
617:     * Cursor: cursor_4c_Dados (criado pelo BO)
618:     * Colunas: especies (150px), descs (290px) conforme layout original
619:     *==========================================================================
620:     PROCEDURE CarregarLista()
621:         LOCAL loc_lResultado, loc_oGrid
622:         loc_lResultado = .F.
623: 
624:         TRY
625:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
626:                 loc_lResultado = .T.
627:             ELSE
628:                 IF THIS.this_oBusinessObject.Buscar("")
629:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
630:                     loc_oGrid.ColumnCount = 2
631:                     loc_oGrid.RecordSource             = "cursor_4c_Dados"
632:                     loc_oGrid.Column1.ControlSource    = "cursor_4c_Dados.especies"
633:                     loc_oGrid.Column2.ControlSource    = "cursor_4c_Dados.descs"
634:                     loc_oGrid.Column1.Width            = 150
635:                     loc_oGrid.Column2.Width            = 290
636:                     loc_oGrid.Column1.Header1.Caption  = "Esp" + CHR(233) + "cie"
637:                     loc_oGrid.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
638:                     THIS.FormatarGridLista(loc_oGrid)
639:                     loc_lResultado = .T.
640:                 ENDIF
641:             ENDIF
642:         CATCH TO loc_oErro
643:             MsgErro("Erro em CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
644:             loc_lResultado = .F.
645:         ENDTRY
646: 
647:         RETURN loc_lResultado
648:     ENDPROC
649: 
650:     *==========================================================================
651:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
652:     *==========================================================================
653:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
654:         LOCAL loc_lResultado
655:         loc_lResultado = .F.
656: 
657:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
658:             RETURN .F.
659:         ENDIF
660: 
661:         TRY
662:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
663: 
664:             IF par_nPagina = 1
665:                 THIS.this_cModoAtual = "LISTA"
666:                 THIS.CarregarLista()
667:             ENDIF
668: 
669:             loc_lResultado = .T.
670:         CATCH TO loc_oErro
671:             MsgErro("Erro em AlternarPagina:" + CHR(13) + loc_oErro.Message, "Erro")
672:         ENDTRY
673: 
674:         RETURN loc_lResultado
675:     ENDPROC
676: 
677:     *==========================================================================
678:     * BtnEncerrarClick - Fecha o formulario
679:     *==========================================================================
680:     PROCEDURE BtnEncerrarClick()
681:         THIS.Release()
682:     ENDPROC
683: 
684:     *==========================================================================
685:     * BtnIncluirClick - Prepara Page2 para inclusao de novo registro
686:     * Legado: pcEscolha=[INSERIR], foca getCodigo
687:     *==========================================================================
688:     PROCEDURE BtnIncluirClick()
689:         LOCAL loc_lResultado
690:         loc_lResultado = .F.
691: 
692:         TRY
693:             THIS.this_oBusinessObject.NovoRegistro()
694:             THIS.this_cModoAtual = "INCLUIR"
695:             THIS.LimparCampos()
696:             THIS.HabilitarCampos(.T.)
697:             THIS.AlternarPagina(2)
698:             loc_lResultado = .T.
699:         CATCH TO loc_oErro
700:             MsgErro("Erro em BtnIncluirClick:" + CHR(13) + loc_oErro.Message, "Erro")
701:         ENDTRY
702: 
703:         RETURN loc_lResultado
704:     ENDPROC
705: 
706:     *==========================================================================
707:     * BtnVisualizarClick - Carrega registro selecionado em modo leitura
708:     * Legado: pcEscolha=[CONSULTAR], foca Grupo_Salva.Salva
709:     *==========================================================================
710:     PROCEDURE BtnVisualizarClick()
711:         LOCAL loc_lResultado, loc_cCodigo
712:         loc_lResultado = .F.
713: 
714:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
715:             MsgAviso("Nenhum registro selecionado para visualizar.", ;
716:                      "Aten" + CHR(231) + CHR(227) + "o")
717:             RETURN .F.
718:         ENDIF
719: 
720:         TRY
721:             SELECT cursor_4c_Dados
722:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.especies)
723: 
724:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
725:                 THIS.this_cModoAtual = "VISUALIZAR"
726:                 THIS.BOParaForm()
727:                 THIS.HabilitarCampos(.F.)
728:                 THIS.AlternarPagina(2)
729:                 loc_lResultado = .T.
730:             ELSE
731:                 MsgAviso("Registro n" + CHR(227) + "o encontrado.", ;
732:                          "Aten" + CHR(231) + CHR(227) + "o")
733:             ENDIF
734:         CATCH TO loc_oErro
735:             MsgErro("Erro em BtnVisualizarClick:" + CHR(13) + loc_oErro.Message, "Erro")
736:         ENDTRY
737: 
738:         RETURN loc_lResultado
739:     ENDPROC
740: 
741:     *==========================================================================
742:     * BtnAlterarClick - Carrega registro selecionado para edicao
743:     * Legado: pcEscolha=[ALTERAR], foca getDescs
744:     *==========================================================================
745:     PROCEDURE BtnAlterarClick()
746:         LOCAL loc_lResultado, loc_cCodigo
747:         loc_lResultado = .F.
748: 
749:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
750:             MsgAviso("Nenhum registro selecionado para alterar.", ;
751:                      "Aten" + CHR(231) + CHR(227) + "o")
752:             RETURN .F.
753:         ENDIF
754: 
755:         TRY
756:             SELECT cursor_4c_Dados
757:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.especies)
758: 
759:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
760:                 THIS.this_oBusinessObject.EditarRegistro()
761:                 THIS.this_cModoAtual = "ALTERAR"
762:                 THIS.BOParaForm()
763:                 THIS.HabilitarCampos(.T.)
764:                 THIS.AlternarPagina(2)
765:                 loc_lResultado = .T.
766:             ELSE
767:                 MsgAviso("Registro n" + CHR(227) + "o encontrado.", ;
768:                          "Aten" + CHR(231) + CHR(227) + "o")
769:             ENDIF
770:         CATCH TO loc_oErro
771:             MsgErro("Erro em BtnAlterarClick:" + CHR(13) + loc_oErro.Message, "Erro")
772:         ENDTRY
773: 
774:         RETURN loc_lResultado
775:     ENDPROC
776: 
777:     *==========================================================================
778:     * BtnExcluirClick - Confirma e exclui registro selecionado
779:     * Legado: pcEscolha=[EXCLUIR], verifica uso em SigMvCcr e SigCdOpe antes de excluir
780:     *==========================================================================
781:     PROCEDURE BtnExcluirClick()
782:         LOCAL loc_lResultado, loc_cCodigo
783: 
784:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
785:             MsgAviso("Nenhum registro selecionado para excluir.", ;
786:                      "Aten" + CHR(231) + CHR(227) + "o")
787:             RETURN .F.
788:         ENDIF
789: 
790:         SELECT cursor_4c_Dados
791:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.especies)
792: 
793:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da esp" + CHR(233) + ;
794:                         "cie '" + loc_cCodigo + "'?", ;
795:                         "Confirmar Exclus" + CHR(227) + "o")
796:             RETURN .F.
797:         ENDIF
798: 
799:         loc_lResultado = .F.
800: 
801:         TRY
802:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
803:                 IF THIS.this_oBusinessObject.Excluir()
804:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
805:                     THIS.CarregarLista()
806:                     loc_lResultado = .T.
807:                 ENDIF
808:             ELSE
809:                 MsgAviso("Registro n" + CHR(227) + "o encontrado.", ;
810:                          "Aten" + CHR(231) + CHR(227) + "o")
811:             ENDIF
812:         CATCH TO loc_oErro
813:             MsgErro("Erro em BtnExcluirClick:" + CHR(13) + loc_oErro.Message, "Erro")
814:         ENDTRY
815: 
816:         RETURN loc_lResultado
817:     ENDPROC
818: 
819:     *==========================================================================
820:     * BtnBuscarClick - Recarrega lista com todos os registros
821:     *==========================================================================
822:     PROCEDURE BtnBuscarClick()
823:         LOCAL loc_lResultado
824:         loc_lResultado = .F.
825: 
826:         TRY
827:             loc_lResultado = THIS.CarregarLista()
828:         CATCH TO loc_oErro
829:             MsgErro("Erro em BtnBuscarClick:" + CHR(13) + loc_oErro.Message, "Erro")
830:         ENDTRY
831: 
832:         RETURN loc_lResultado
833:     ENDPROC
834: 
835:     *==========================================================================
836:     * BtnSalvarClick - Valida e salva o registro (Confirmar na Page2)
837:     * Legado: ChkRegister([SigCdEsp]) apos validar Especies, Descs, Provs
838:     *==========================================================================
839:     PROCEDURE BtnSalvarClick()
840:         LOCAL loc_lResultado
841:         loc_lResultado = .F.
842: 
843:         THIS.FormParaBO()
844: 
845:         IF !THIS.this_oBusinessObject.Validar()
846:             RETURN .F.
847:         ENDIF
848: 
849:         IF THIS.this_cModoAtual = "INCLUIR"
850:             IF THIS.this_oBusinessObject.VerificarDuplicidade()
851:                 RETURN .F.
852:             ENDIF
853:         ENDIF
854: 
855:         TRY
856:             IF THIS.this_oBusinessObject.Salvar()
857:                 MsgInfo("Registro salvo com sucesso!", "Sucesso")
858:                 THIS.this_cModoAtual = "LISTA"
859:                 THIS.AlternarPagina(1)
860:                 loc_lResultado = .T.
861:             ENDIF
862:         CATCH TO loc_oErro
863:             MsgErro("Erro ao salvar:" + CHR(13) + loc_oErro.Message, "Erro")
864:         ENDTRY
865: 
866:         RETURN loc_lResultado
867:     ENDPROC
868: 
869:     *==========================================================================
870:     * BtnCancelarClick - Cancela operacao e volta para lista
871:     *==========================================================================
872:     PROCEDURE BtnCancelarClick()
873:         THIS.this_cModoAtual = "LISTA"
874:         THIS.AlternarPagina(1)
875:         THIS.CarregarLista()
876:     ENDPROC
877: 
878:     *==========================================================================
879:     * FormParaBO - Transfere valores dos campos do Form para o BO
880:     * Legado: ChkRegister le do cursor crSigCdEsp via ControlSource
881:     *==========================================================================
882:     PROTECTED PROCEDURE FormParaBO()
883:         LOCAL loc_oPagina
884:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
885: 
886:         TRY
887:             IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
888:                 THIS.this_oBusinessObject.this_cEspecies = ;
889:                     ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
890:             ENDIF
891: 
892:             IF PEMSTATUS(loc_oPagina, "txt_4c_Descricao", 5)
893:                 THIS.this_oBusinessObject.this_cDescs = ;
894:                     ALLTRIM(loc_oPagina.txt_4c_Descricao.Value)
895:             ENDIF
896: 
897:             IF PEMSTATUS(loc_oPagina, "opt_4c_OptProvs", 5)
898:                 THIS.this_oBusinessObject.this_nProvs = ;
899:                     loc_oPagina.opt_4c_OptProvs.Value
900:             ENDIF
901: 
902:             IF PEMSTATUS(loc_oPagina, "opt_4c_OptObrigs", 5)
903:                 THIS.this_oBusinessObject.this_nObrigs = ;
904:                     loc_oPagina.opt_4c_OptObrigs.Value
905:             ENDIF
906:         CATCH TO loc_oErro
907:             MsgErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message, "Erro")
908:         ENDTRY
909:     ENDPROC
910: 
911:     *==========================================================================
912:     * BOParaForm - Transfere valores do BO para os campos do Form
913:     *==========================================================================
914:     PROTECTED PROCEDURE BOParaForm()
915:         LOCAL loc_oPagina
916:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
917: 
918:         TRY
919:             IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
920:                 loc_oPagina.txt_4c_Codigo.Value = ;
921:                     ALLTRIM(THIS.this_oBusinessObject.this_cEspecies)
922:             ENDIF
923: 
924:             IF PEMSTATUS(loc_oPagina, "txt_4c_Descricao", 5)
925:                 loc_oPagina.txt_4c_Descricao.Value = ;
926:                     ALLTRIM(THIS.this_oBusinessObject.this_cDescs)
927:             ENDIF
928: 
929:             IF PEMSTATUS(loc_oPagina, "opt_4c_OptProvs", 5)
930:                 loc_oPagina.opt_4c_OptProvs.Value = ;
931:                     THIS.this_oBusinessObject.this_nProvs
932:             ENDIF
933: 
934:             IF PEMSTATUS(loc_oPagina, "opt_4c_OptObrigs", 5)
935:                 loc_oPagina.opt_4c_OptObrigs.Value = ;
936:                     THIS.this_oBusinessObject.this_nObrigs
937:             ENDIF
938:         CATCH TO loc_oErro
939:             MsgErro("Erro em BOParaForm:" + CHR(13) + loc_oErro.Message, "Erro")
940:         ENDTRY
941:     ENDPROC
942: 
943:     *==========================================================================
944:     * LimparCampos - Limpa valores dos campos da Page2
945:     *==========================================================================
946:     PROTECTED PROCEDURE LimparCampos()
947:         LOCAL loc_oPagina
948:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
949: 
950:         TRY
951:             IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
952:                 loc_oPagina.txt_4c_Codigo.Value = ""
953:             ENDIF
954: 
955:             IF PEMSTATUS(loc_oPagina, "txt_4c_Descricao", 5)
956:                 loc_oPagina.txt_4c_Descricao.Value = ""
957:             ENDIF
958: 
959:             IF PEMSTATUS(loc_oPagina, "opt_4c_OptProvs", 5)
960:                 loc_oPagina.opt_4c_OptProvs.Value = 1
961:             ENDIF
962: 
963:             IF PEMSTATUS(loc_oPagina, "opt_4c_OptObrigs", 5)
964:                 loc_oPagina.opt_4c_OptObrigs.Value = 1
965:             ENDIF
966:         CATCH TO loc_oErro
967:             MsgErro("Erro em LimparCampos:" + CHR(13) + loc_oErro.Message, "Erro")
968:         ENDTRY
969:     ENDPROC
970: 
971:     *==========================================================================
972:     * HabilitarCampos - Habilita ou desabilita campos da Page2
973:     * Legado: When events por modo (INSERIR/ALTERAR/CONSULTAR)
974:     * getCodigo: habilitado em INCLUIR; getDescs/optProvs/optObrigs: INCLUIR e ALTERAR
975:     *==========================================================================
976:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
977:         LOCAL loc_oPagina, loc_lHabCodigo, loc_lHabDados
978:         loc_oPagina   = THIS.pgf_4c_Paginas.Page2
979:         loc_lHabCodigo = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
980:         loc_lHabDados  = par_lHabilitar AND ;
981:                          (THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR")
982: 
983:         TRY
984:             IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
985:                 loc_oPagina.txt_4c_Codigo.Enabled = loc_lHabCodigo
986:             ENDIF
987: 
988:             IF PEMSTATUS(loc_oPagina, "txt_4c_Descricao", 5)
989:                 loc_oPagina.txt_4c_Descricao.Enabled = loc_lHabDados
990:             ENDIF
991: 
992:             IF PEMSTATUS(loc_oPagina, "opt_4c_OptProvs", 5)
993:                 loc_oPagina.opt_4c_OptProvs.Enabled = loc_lHabDados
994:             ENDIF
995: 
996:             IF PEMSTATUS(loc_oPagina, "opt_4c_OptObrigs", 5)
997:                 loc_oPagina.opt_4c_OptObrigs.Enabled = loc_lHabDados
998:             ENDIF
999: 
1000:             IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
1001:                 IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1002:                     loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lHabDados
1003:                 ENDIF
1004:             ENDIF
1005:         CATCH TO loc_oErro
1006:             MsgErro("Erro em HabilitarCampos:" + CHR(13) + loc_oErro.Message, "Erro")
1007:         ENDTRY
1008:     ENDPROC
1009: 
1010:     *==========================================================================
1011:     * FormatarGridLista - Formata visual do grid da lista
1012:     *==========================================================================
1013:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1014:         WITH par_oGrid
1015:             .FontName = "Tahoma"
1016:             .FontSize = 8
1017:         ENDWITH
1018:     ENDPROC
1019: 
1020:     *==========================================================================
1021:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1022:     * Itera Pages de PageFrames e Controls de Containers
1023:     *==========================================================================
1024:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1025:         LOCAL loc_nI, loc_oObjeto, loc_nP
1026: 
1027:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1028:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1029: 
1030:             IF VARTYPE(loc_oObjeto) = "O"
1031:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1032:                     loc_oObjeto.Visible = .T.
1033:                 ENDIF
1034: 
1035:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1036:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1037:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1038:                     ENDFOR
1039:                 ENDIF
1040: 
1041:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1042:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1043:                 ENDIF
1044:             ENDIF
1045:         ENDFOR
1046:     ENDPROC
1047: 
1048:     *==========================================================================
1049:     * AjustarBotoesPorModo - Habilita/desabilita botoes conforme o modo atual
1050:     * Page1: Alterar/Excluir/Visualizar habilitados somente se houver registro
1051:     * Page2: Confirmar habilitado somente em INCLUIR ou ALTERAR
1052:     *==========================================================================
1053:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1054:         LOCAL loc_oPagina1, loc_oPagina2, loc_lTemRegistro
1055:         loc_oPagina1    = THIS.pgf_4c_Paginas.Page1
1056:         loc_oPagina2    = THIS.pgf_4c_Paginas.Page2
1057:         loc_lTemRegistro = USED("cursor_4c_Dados") AND ;
1058:                            !EOF("cursor_4c_Dados") AND ;
1059:                            RECCOUNT("cursor_4c_Dados") > 0
1060: 
1061:         TRY
1062:             IF PEMSTATUS(loc_oPagina1, "cnt_4c_Botoes", 5)
1063:                 IF PEMSTATUS(loc_oPagina1.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
1064:                     loc_oPagina1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled = loc_lTemRegistro
1065:                 ENDIF
1066:                 IF PEMSTATUS(loc_oPagina1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
1067:                     loc_oPagina1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled = loc_lTemRegistro
1068:                 ENDIF
1069:                 IF PEMSTATUS(loc_oPagina1.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
1070:                     loc_oPagina1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
1071:                 ENDIF
1072:             ENDIF
1073: 
1074:             IF PEMSTATUS(loc_oPagina2, "cnt_4c_BotoesAcao", 5)
1075:                 IF PEMSTATUS(loc_oPagina2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1076:                     loc_oPagina2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = ;
1077:                         INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1078:                 ENDIF
1079:             ENDIF
1080:         CATCH TO loc_oErro
1081:             MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "Erro")
1082:         ENDTRY
1083:     ENDPROC
1084: 
1085:     *==========================================================================
1086:     * Destroy - Libera recursos
1087:     *==========================================================================
1088:     PROCEDURE Destroy()
1089:         THIS.this_oBusinessObject = .NULL.
1090:         DODEFAULT()
1091:     ENDPROC
1092: 
1093: ENDDEFINE


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

