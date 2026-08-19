# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [BINDEVENT-PARAMS] Handler 'ValidarConexao' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarConexao(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDiretorioDbfs' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDiretorioDbfs(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormLOC.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1065 linhas total):

*-- Linhas 25 a 148:
25:     *==========================================================================
26:     * Init - Inicializa o formulario
27:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
28:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar!
29:     *==========================================================================
30:     PROCEDURE Init()
31:         RETURN DODEFAULT()
32:     ENDPROC
33: 
34:     *==========================================================================
35:     * InicializarForm - Configura estrutura completa
36:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
37:     *==========================================================================
38:     PROTECTED PROCEDURE InicializarForm()
39:         LOCAL loc_lSucesso
40:         loc_lSucesso = .F.
41: 
42:         TRY
43:             THIS.this_oBusinessObject = CREATEOBJECT("LOCBO")
44: 
45:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
46:                 MostrarErro("Erro ao criar LOCBO" + CHR(13) + ;
47:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
48:                     "FormLOC.InicializarForm")
49:             ELSE
50:                 THIS.ConfigurarPageFrame()
51:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
52:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
53:                 THIS.pgf_4c_Paginas.Visible   = .T.
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
65:             MostrarErro("Erro ao inicializar FormLOC:" + CHR(13) + ;
66:                 loException.Message + CHR(13) + ;
67:                 "Linha: " + TRANSFORM(loException.LineNo), ;
68:                 "FormLOC.InicializarForm")
69:         ENDTRY
70: 
71:         RETURN loc_lSucesso
72:     ENDPROC
73: 
74:     *==========================================================================
75:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
76:     * Top=-29 para esconder abas; controles compensam +29 no Top
77:     *==========================================================================
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
103:     *==========================================================================
104:     * ConfigurarPaginaLista - Configura Page1: cabecalho, botoes CRUD e grid
105:     * Botoes: Incluir, Visualizar, Alterar, Excluir, Buscar, Encerrar
106:     * Grid: 3 colunas (cods, cidconns, drives) | RecordSource em CarregarLista
107:     *==========================================================================
108:     PROTECTED PROCEDURE ConfigurarPaginaLista()
109:         LOCAL loc_oPagina
110:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
111: 
112:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
113: 
114:         *-- Container Cabecalho (cntSombra no legado)
115:         *-- Legado: cntSombra.Top=1. Com compensacao PageFrame.Top=-29: Top=30 (1+29)
116:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
117:         WITH loc_oPagina.cnt_4c_Cabecalho
118:             .Top         = 30
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

*-- Linhas 191 a 467:
191:             .WordWrap        = .T.
192:             .AutoSize        = .F.
193:         ENDWITH
194:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
195: 
196:         *-- Botao Visualizar
197:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
198:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
199:             .Caption         = "Visualizar"
200:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
201:             .PicturePosition = 13
202:             .Top             = 5
203:             .Left            = 80
204:             .Width           = 75
205:             .Height          = 75
206:             .FontName        = "Comic Sans MS"
207:             .FontBold        = .T.
208:             .FontItalic      = .T.
209:             .FontSize        = 8
210:             .ForeColor       = RGB(90, 90, 90)
211:             .BackColor       = RGB(255, 255, 255)
212:             .Themes          = .F.
213:             .SpecialEffect   = 0
214:             .MousePointer    = 15
215:             .WordWrap        = .T.
216:             .AutoSize        = .F.
217:         ENDWITH
218:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
219: 
220:         *-- Botao Alterar
221:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
222:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
223:             .Caption         = "Alterar"
224:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
225:             .PicturePosition = 13
226:             .Top             = 5
227:             .Left            = 155
228:             .Width           = 75
229:             .Height          = 75
230:             .FontName        = "Comic Sans MS"
231:             .FontBold        = .T.
232:             .FontItalic      = .T.
233:             .FontSize        = 8
234:             .ForeColor       = RGB(90, 90, 90)
235:             .BackColor       = RGB(255, 255, 255)
236:             .Themes          = .F.
237:             .SpecialEffect   = 0
238:             .MousePointer    = 15
239:             .WordWrap        = .T.
240:             .AutoSize        = .F.
241:         ENDWITH
242:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
243: 
244:         *-- Botao Excluir
245:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
246:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
247:             .Caption         = "Excluir"
248:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
249:             .PicturePosition = 13
250:             .Top             = 5
251:             .Left            = 230
252:             .Width           = 75
253:             .Height          = 75
254:             .FontName        = "Comic Sans MS"
255:             .FontBold        = .T.
256:             .FontItalic      = .T.
257:             .FontSize        = 8
258:             .ForeColor       = RGB(90, 90, 90)
259:             .BackColor       = RGB(255, 255, 255)
260:             .Themes          = .F.
261:             .SpecialEffect   = 0
262:             .MousePointer    = 15
263:             .WordWrap        = .T.
264:             .AutoSize        = .F.
265:         ENDWITH
266:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
267: 
268:         *-- Botao Buscar
269:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
270:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
271:             .Caption         = "Buscar"
272:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
273:             .PicturePosition = 13
274:             .Top             = 5
275:             .Left            = 305
276:             .Width           = 75
277:             .Height          = 75
278:             .FontName        = "Comic Sans MS"
279:             .FontBold        = .T.
280:             .FontItalic      = .T.
281:             .FontSize        = 8
282:             .ForeColor       = RGB(90, 90, 90)
283:             .BackColor       = RGB(255, 255, 255)
284:             .Themes          = .F.
285:             .SpecialEffect   = 0
286:             .MousePointer    = 15
287:             .WordWrap        = .T.
288:             .AutoSize        = .F.
289:         ENDWITH
290:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
291: 
292:         *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10)
293:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
294:         WITH loc_oPagina.cnt_4c_Saida
295:             .Top         = 29
296:             .Left        = 917
297:             .Width       = 90
298:             .Height      = 85
299:             .BackStyle   = 0
300:             .BorderWidth = 0
301:             .Visible     = .T.
302:         ENDWITH
303: 
304:         *-- Botao Encerrar - PADRAO CANONICO (CLAUDE.md regra #10)
305:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
306:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
307:             .Caption         = "Encerrar"
308:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
309:             .PicturePosition = 13
310:             .Top             = 5
311:             .Left            = 5
312:             .Width           = 75
313:             .Height          = 75
314:             .FontName        = "Comic Sans MS"
315:             .FontBold        = .T.
316:             .FontItalic      = .T.
317:             .FontSize        = 8
318:             .ForeColor       = RGB(90, 90, 90)
319:             .BackColor       = RGB(255, 255, 255)
320:             .Themes          = .F.
321:             .SpecialEffect   = 0
322:             .MousePointer    = 15
323:             .WordWrap        = .T.
324:             .AutoSize        = .F.
325:         ENDWITH
326:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
327: 
328:         *-- Grid de Lista (Grade no legado: top=121, left=12, width=940)
329:         *-- Com compensacao PageFrame.Top=-29: Top = 121 + 29 = 150
330:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
331:         WITH loc_oPagina.grd_4c_Lista
332:             .Top                = 150
333:             .Left               = 12
334:             .Width              = 940
335:             .Height             = 469
336:             .FontName           = "Verdana"
337:             .FontSize           = 8
338:             .ForeColor          = RGB(90, 90, 90)
339:             .BackColor          = RGB(255, 255, 255)
340:             .GridLineColor      = RGB(238, 238, 238)
341:             .HighlightBackColor = RGB(255, 255, 255)
342:             .HighlightForeColor = RGB(15, 41, 104)
343:             .HighlightStyle     = 2
344:             .DeleteMark         = .F.
345:             .RecordMark         = .F.
346:             .RowHeight          = 16
347:             .ScrollBars         = 2
348:             .GridLines          = 3
349:             .ReadOnly           = .T.
350:             .Visible            = .T.
351:         ENDWITH
352: 
353:         THIS.TornarControlesVisiveis(loc_oPagina)
354:     ENDPROC
355: 
356:     *==========================================================================
357:     * ConfigurarPaginaDados - Configura Page2: botoes + campos de edicao
358:     * Campos: getCods(Codigo), getConexao(Conexao), getDbfs(CaminhoDrives)
359:     * Fase 5/8: botoes + Label1/Codigo + Label3/Conexao
360:     *==========================================================================
361:     PROTECTED PROCEDURE ConfigurarPaginaDados()
362:         LOCAL loc_oPagina
363:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
364: 
365:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
366: 
367:         *-- Container BotoesAcao (Grupo_Salva: Top=9, Left=842, Width=160, Height=85)
368:         *-- Com compensacao PageFrame +29: Top=38 (9+29)
369:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
370:         WITH loc_oPagina.cnt_4c_BotoesAcao
371:             .Top         = 38
372:             .Left        = 842
373:             .Width       = 160
374:             .Height      = 85
375:             .BackStyle = 0
376:             .BackColor   = RGB(255, 255, 255)
377:             .BorderWidth = 0
378:             .Visible     = .T.
379:         ENDWITH
380: 
381:         *-- Botao Confirmar (Salva.Left=5, Top=5)
382:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
383:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
384:             .Caption         = "Confirmar"
385:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
386:             .PicturePosition = 13
387:             .Top             = 5
388:             .Left            = 5
389:             .Width           = 75
390:             .Height          = 75
391:             .FontName        = "Comic Sans MS"
392:             .FontBold        = .T.
393:             .FontItalic      = .T.
394:             .FontSize        = 8
395:             .ForeColor       = RGB(90, 90, 90)
396:             .BackColor       = RGB(255, 255, 255)
397:             .Themes          = .F.
398:             .SpecialEffect   = 0
399:             .MousePointer    = 15
400:             .WordWrap        = .T.
401:             .AutoSize        = .F.
402:         ENDWITH
403:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
404: 
405:         *-- Botao Cancelar (Cancelar.Left=88, Top=5)
406:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
407:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
408:             .Caption         = "Encerrar"
409:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
410:             .PicturePosition = 13
411:             .Top             = 5
412:             .Left            = 80
413:             .Width           = 75
414:             .Height          = 75
415:             .FontName        = "Comic Sans MS"
416:             .FontBold        = .T.
417:             .FontItalic      = .T.
418:             .FontSize        = 8
419:             .ForeColor       = RGB(90, 90, 90)
420:             .BackColor       = RGB(255, 255, 255)
421:             .Themes          = .F.
422:             .SpecialEffect   = 0
423:             .MousePointer    = 15
424:             .WordWrap        = .T.
425:             .AutoSize        = .F.
426:         ENDWITH
427:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
428: 
429:         *-- Label1: " Codigo " (Top=126+29=155, Left=112, Width=50)
430:         *-- ForeColor=RGB(36,84,155), FontName="Verdana", FontSize=8 - EXATO do original
431:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
432:         WITH loc_oPagina.lbl_4c_Label1
433:             .Caption   = " C" + CHR(243) + "digo "
434:             .Top       = 155
435:             .Left      = 112
436:             .Width     = 50
437:             .Height    = 15
438:             .FontName  = "Verdana"
439:             .FontSize  = 8
440:             .FontBold  = .F.
441:             .FontItalic = .F.
442:             .ForeColor = RGB(36, 84, 155)
443:             .BackStyle = 0
444:             .AutoSize  = .F.
445:             .Visible   = .T.
446:         ENDWITH
447: 
448:         *-- getCods -> txt_4c_Codigo (Top=142+29=171, Left=112, Width=80, TabIndex=1)
449:         *-- When no legado: editavel apenas no modo INSERIR -> HabilitarCampos() controla
450:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
451:         WITH loc_oPagina.txt_4c_Codigo
452:             .Value     = ""
453:             .Top       = 171
454:             .Left      = 112
455:             .Width     = 80
456:             .Height    = 23
457:             .FontName  = "Tahoma"
458:             .FontSize  = 8
459:             .MaxLength = 10
460:             .TabIndex  = 1
461:             .Visible   = .T.
462:         ENDWITH
463: 
464:         *-- Label3: " Conexao em SQL " (Top=174+29=203, Left=112, Width=114)
465:         *-- ForeColor=RGB(36,84,155), FontName="Verdana", FontSize=8 - EXATO do original
466:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
467:         WITH loc_oPagina.lbl_4c_Label3

*-- Linhas 495 a 584:
495:             .TabIndex  = 2
496:             .Visible   = .T.
497:         ENDWITH
498:         BINDEVENT(loc_oPagina.txt_4c_Conexao, "KeyPress", THIS, "ValidarConexao")
499: 
500:         *-- Label2: " Caminho dos Arquivos em .DBF " (Top=225+29=254, Left=112, Width=192)
501:         *-- ForeColor=RGB(36,84,155), FontName="Verdana", FontSize=8 - EXATO do original
502:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
503:         WITH loc_oPagina.lbl_4c_Label2
504:             .Caption   = " Caminho dos Arquivos em .DBF "
505:             .Top       = 254
506:             .Left      = 112
507:             .Width     = 192
508:             .Height    = 15
509:             .FontName  = "Verdana"
510:             .FontSize  = 8
511:             .FontBold  = .F.
512:             .FontItalic = .F.
513:             .ForeColor = RGB(36, 84, 155)
514:             .BackStyle = 0
515:             .AutoSize  = .F.
516:             .Visible   = .T.
517:         ENDWITH
518: 
519:         *-- getDbfs -> txt_4c_Dbfs (Top=242+29=271, Left=112, Width=570, TabIndex=3)
520:         *-- Valid no legado: verifica barra final + FILE(SigCdLoc.DBF) -> ValidarDiretorioDbfs()
521:         loc_oPagina.AddObject("txt_4c_Dbfs", "TextBox")
522:         WITH loc_oPagina.txt_4c_Dbfs
523:             .Value     = ""
524:             .Top       = 271
525:             .Left      = 112
526:             .Width     = 570
527:             .Height    = 23
528:             .FontName  = "Tahoma"
529:             .FontSize  = 8
530:             .MaxLength = 250
531:             .TabIndex  = 3
532:             .Visible   = .T.
533:         ENDWITH
534:         BINDEVENT(loc_oPagina.txt_4c_Dbfs, "KeyPress", THIS, "ValidarDiretorioDbfs")
535: 
536:         THIS.TornarControlesVisiveis(loc_oPagina)
537:     ENDPROC
538: 
539:     *==========================================================================
540:     * CarregarLista - Carrega dados no grid da Page1 (cursor_4c_Dados do LOCBO)
541:     * Grid (3 colunas): cods(80), cidconns(150), drives(400)
542:     * Guarda PEMSTATUS: grid adicionado na Fase 4; ate la retorna .T. sem acao
543:     *==========================================================================
544:     PROCEDURE CarregarLista()
545:         LOCAL loc_lResultado, loc_oGrid
546:         loc_lResultado = .F.
547: 
548:         IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
549:             RETURN .T.
550:         ENDIF
551: 
552:         TRY
553:             IF !THIS.this_oBusinessObject.Buscar("")
554:                 loc_lResultado = .F.
555:             ELSE
556:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
557: 
558:                 *-- RecordSource e ColumnCount FORA do WITH (Problema 36)
559:                 loc_oGrid.ColumnCount  = 3
560:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
561: 
562:                 *-- ControlSource APOS RecordSource (Problema 48: auto-bind seria sobrescrito)
563:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
564:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.cidconns"
565:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.drives"
566: 
567:                 loc_oGrid.Column1.Width = 80
568:                 loc_oGrid.Column2.Width = 150
569:                 loc_oGrid.Column3.Width = 400
570: 
571:                 *-- Headers APOS RecordSource (Problema 2/32: RecordSource reseta captions)
572:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
573:                 loc_oGrid.Column2.Header1.Caption = "Conex" + CHR(227) + "o"
574:                 loc_oGrid.Column3.Header1.Caption = "Caminho Para Tabelas"
575: 
576:                 THIS.FormatarGridLista(loc_oGrid)
577:                 loc_lResultado = .T.
578:             ENDIF
579: 
580:         CATCH TO loException
581:             MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message + CHR(13) + ;
582:                 "Linha: " + TRANSFORM(loException.LineNo), ;
583:                 "FormLOC.CarregarLista")
584:             loc_lResultado = .F.

*-- Linhas 591 a 1065:
591:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
592:     * Ao voltar para Page1, recarrega a lista
593:     *==========================================================================
594:     PROCEDURE AlternarPagina(par_nPagina)
595:         LOCAL loc_lResultado
596:         loc_lResultado = .F.
597: 
598:         TRY
599:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
600:                 MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
601:             ELSE
602:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
603: 
604:                 IF par_nPagina = 1
605:                     THIS.this_cModoAtual = "LISTA"
606:                     THIS.CarregarLista()
607:                 ENDIF
608: 
609:                 loc_lResultado = .T.
610:             ENDIF
611: 
612:         CATCH TO loException
613:             MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, ;
614:                 "FormLOC.AlternarPagina")
615:         ENDTRY
616: 
617:         RETURN loc_lResultado
618:     ENDPROC
619: 
620:     *==========================================================================
621:     * FormatarGridLista - Formata visual do grid de lista (FontName/FontSize)
622:     *==========================================================================
623:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
624:         TRY
625:             WITH par_oGrid
626:                 .FontName = "Tahoma"
627:                 .FontSize = 8
628:             ENDWITH
629:         CATCH TO loException
630:             MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
631:                 "FormLOC.FormatarGridLista")
632:         ENDTRY
633:     ENDPROC
634: 
635:     *==========================================================================
636:     * BtnIncluirClick - Abre Page2 para incluir novo registro
637:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
638:     *==========================================================================
639:     PROCEDURE BtnIncluirClick()
640:         THIS.this_oBusinessObject.NovoRegistro()
641:         THIS.LimparCampos()
642:         THIS.this_cModoAtual = "INCLUIR"
643:         THIS.HabilitarCampos(.T.)
644:         THIS.AjustarBotoesPorModo()
645:         THIS.AlternarPagina(2)
646:     ENDPROC
647: 
648:     *==========================================================================
649:     * BtnVisualizarClick - Abre Page2 em modo somente leitura
650:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
651:     *==========================================================================
652:     PROCEDURE BtnVisualizarClick()
653:         LOCAL loc_cCodigo
654:         loc_cCodigo = ""
655: 
656:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
657:             SELECT cursor_4c_Dados
658:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
659:         ENDIF
660: 
661:         IF EMPTY(loc_cCodigo)
662:             MsgAviso("Selecione um registro para visualizar.")
663:         ELSE
664:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
665:                 THIS.this_cModoAtual = "VISUALIZAR"
666:                 THIS.BOParaForm()
667:                 THIS.HabilitarCampos(.F.)
668:                 THIS.AjustarBotoesPorModo()
669:                 THIS.AlternarPagina(2)
670:             ENDIF
671:         ENDIF
672:     ENDPROC
673: 
674:     *==========================================================================
675:     * BtnAlterarClick - Abre Page2 para alterar registro selecionado
676:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
677:     *==========================================================================
678:     PROCEDURE BtnAlterarClick()
679:         LOCAL loc_cCodigo
680:         loc_cCodigo = ""
681: 
682:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
683:             SELECT cursor_4c_Dados
684:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
685:         ENDIF
686: 
687:         IF EMPTY(loc_cCodigo)
688:             MsgAviso("Selecione um registro para alterar.")
689:         ELSE
690:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
691:                 THIS.this_oBusinessObject.EditarRegistro()
692:                 THIS.this_cModoAtual = "ALTERAR"
693:                 THIS.BOParaForm()
694:                 THIS.HabilitarCampos(.T.)
695:                 THIS.AjustarBotoesPorModo()
696:                 THIS.AlternarPagina(2)
697:             ENDIF
698:         ENDIF
699:     ENDPROC
700: 
701:     *==========================================================================
702:     * BtnExcluirClick - Exclui registro selecionado com confirmacao
703:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
704:     *==========================================================================
705:     PROCEDURE BtnExcluirClick()
706:         LOCAL loc_cCodigo
707:         loc_cCodigo = ""
708: 
709:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
710:             SELECT cursor_4c_Dados
711:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
712:         ENDIF
713: 
714:         IF EMPTY(loc_cCodigo)
715:             MsgAviso("Selecione um registro para excluir.")
716:         ELSE
717:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
718:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do local [" + loc_cCodigo + "]?", ;
719:                     "Confirmar Exclus" + CHR(227) + "o")
720:                     IF THIS.this_oBusinessObject.Excluir()
721:                         MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
722:                         THIS.CarregarLista()
723:                     ENDIF
724:                 ENDIF
725:             ENDIF
726:         ENDIF
727:     ENDPROC
728: 
729:     *==========================================================================
730:     * BtnBuscarClick - Abre picker para localizar registro na lista
731:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
732:     *==========================================================================
733:     PROCEDURE BtnBuscarClick()
734:         LOCAL loc_oBusca, loc_cCodigo
735:         loc_cCodigo = ""
736: 
737:         TRY
738:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
739:                 "SigCdLoc", "cursor_4c_BuscaLoc", "cods", "", ;
740:                 "Buscar Local")
741: 
742:             IF VARTYPE(loc_oBusca) = "O"
743:                 loc_oBusca.mAddColuna("cods",     "", "C" + CHR(243) + "digo")
744:                 loc_oBusca.mAddColuna("cidconns", "", "Conex" + CHR(227) + "o")
745:                 loc_oBusca.mAddColuna("drives",   "", "Caminho Para Tabelas")
746:                 loc_oBusca.Show()
747: 
748:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLoc")
749:                     SELECT cursor_4c_BuscaLoc
750:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaLoc.cods)
751:                 ENDIF
752: 
753:                 loc_oBusca.Release()
754:             ENDIF
755: 
756:             IF USED("cursor_4c_BuscaLoc")
757:                 USE IN cursor_4c_BuscaLoc
758:             ENDIF
759: 
760:             IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
761:                 SELECT cursor_4c_Dados
762:                 LOCATE FOR ALLTRIM(cods) == loc_cCodigo
763:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
764:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
765:                 ENDIF
766:             ENDIF
767: 
768:         CATCH TO loException
769:             MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "FormLOC.BtnBuscarClick")
770:             IF USED("cursor_4c_BuscaLoc")
771:                 USE IN cursor_4c_BuscaLoc
772:             ENDIF
773:         ENDTRY
774:     ENDPROC
775: 
776:     *==========================================================================
777:     * BtnEncerrarClick - Fecha o formulario
778:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
779:     *==========================================================================
780:     PROCEDURE BtnEncerrarClick()
781:         THIS.Release()
782:     ENDPROC
783: 
784:     *==========================================================================
785:     * BtnSalvarClick - Confirma e salva o registro atual
786:     * Validacoes do legado Salva.Click: Codigo e Conexao obrigatorios no INCLUIR
787:     * Validacoes FORA do TRY (Problema 16); Salvar() SEM parametro (Problema 4)
788:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
789:     *==========================================================================
790:     PROCEDURE BtnSalvarClick()
791:         LOCAL loc_oPagina
792:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
793: 
794:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
795:             RETURN
796:         ENDIF
797: 
798:         *-- Validacoes obrigatorias no modo INCLUIR (replica logica do Salva.Click original)
799:         IF THIS.this_cModoAtual = "INCLUIR"
800:             IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5) AND ;
801:                EMPTY(ALLTRIM(loc_oPagina.txt_4c_Codigo.Value))
802:                 MsgAviso("Obrigat" + CHR(243) + "rio Informar o C" + CHR(243) + "digo!!!")
803:                 loc_oPagina.txt_4c_Codigo.SetFocus()
804:                 RETURN
805:             ENDIF
806: 
807:             IF PEMSTATUS(loc_oPagina, "txt_4c_Conexao", 5) AND ;
808:                EMPTY(ALLTRIM(loc_oPagina.txt_4c_Conexao.Value))
809:                 MsgAviso("Obrigat" + CHR(243) + "rio Informar a Conex" + CHR(227) + "o!!!")
810:                 loc_oPagina.txt_4c_Conexao.SetFocus()
811:                 RETURN
812:             ENDIF
813:         ENDIF
814: 
815:         THIS.FormParaBO()
816: 
817:         IF THIS.this_oBusinessObject.Salvar()
818:             MsgInfo("Registro salvo com sucesso!")
819:             THIS.AlternarPagina(1)
820:         ENDIF
821:     ENDPROC
822: 
823:     *==========================================================================
824:     * BtnCancelarClick - Cancela edicao e volta para lista
825:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
826:     *==========================================================================
827:     PROCEDURE BtnCancelarClick()
828:         THIS.AlternarPagina(1)
829:         THIS.this_cModoAtual = "LISTA"
830:         THIS.CarregarLista()
831:     ENDPROC
832: 
833:     *==========================================================================
834:     * ValidarConexao - Valida campo Conexao e abre lookup se nao encontrado
835:     * Legado: getConexao.Valid -> fwBuscaExt -> SigConn.cIdConns
836:     * PUBLIC: BINDEVENT requer metodo publico
837:     *==========================================================================
838:     PROCEDURE ValidarConexao()
839:         LOCAL loc_oPagina, loc_cConexao, loc_oBusca
840:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
841: 
842:         IF !PEMSTATUS(loc_oPagina, "txt_4c_Conexao", 5)
843:             RETURN
844:         ENDIF
845: 
846:         loc_cConexao = ALLTRIM(loc_oPagina.txt_4c_Conexao.Value)
847: 
848:         IF EMPTY(loc_cConexao)
849:             RETURN
850:         ENDIF
851: 
852:         TRY
853:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
854:                 "SigConn", "cursor_4c_BuscaConn", "cIdConns", loc_cConexao, ;
855:                 "Selecionar Conex" + CHR(227) + "o")
856: 
857:             IF VARTYPE(loc_oBusca) = "O"
858:                 IF !loc_oBusca.this_lAchouRegistro
859:                     loc_oBusca.mAddColuna("cIdConns", "", "Conex" + CHR(227) + "o")
860:                     loc_oBusca.Show()
861:                 ENDIF
862: 
863:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConn")
864:                     SELECT cursor_4c_BuscaConn
865:                     loc_oPagina.txt_4c_Conexao.Value = ALLTRIM(cursor_4c_BuscaConn.cIdConns)
866:                 ENDIF
867: 
868:                 loc_oBusca.Release()
869:             ENDIF
870: 
871:             IF USED("cursor_4c_BuscaConn")
872:                 USE IN cursor_4c_BuscaConn
873:             ENDIF
874: 
875:         CATCH TO loException
876:             MostrarErro("Erro ao validar conex" + CHR(227) + "o:" + CHR(13) + loException.Message, ;
877:                 "FormLOC.ValidarConexao")
878:             IF USED("cursor_4c_BuscaConn")
879:                 USE IN cursor_4c_BuscaConn
880:             ENDIF
881:         ENDTRY
882:     ENDPROC
883: 
884:     *==========================================================================
885:     * ValidarDiretorioDbfs - Valida campo Drives (caminho dos arquivos .DBF)
886:     * Legado: getDbfs.Valid -> FILE check para SigCdLoc.DBF no diretorio
887:     * PUBLIC: BINDEVENT requer metodo publico
888:     *==========================================================================
889:     PROCEDURE ValidarDiretorioDbfs()
890:         LOCAL loc_oPagina, loc_cCaminho, loc_cDestino
891:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
892: 
893:         IF !PEMSTATUS(loc_oPagina, "txt_4c_Dbfs", 5)
894:             RETURN
895:         ENDIF
896: 
897:         loc_cCaminho = ALLTRIM(loc_oPagina.txt_4c_Dbfs.Value)
898: 
899:         IF EMPTY(loc_cCaminho)
900:             RETURN
901:         ENDIF
902: 
903:         IF RIGHT(loc_cCaminho, 1) <> "\"
904:             loc_cCaminho = loc_cCaminho + "\"
905:         ENDIF
906: 
907:         loc_cDestino = loc_cCaminho + "SigCdLoc.DBF"
908: 
909:         IF !FILE(loc_cDestino)
910:             MsgAviso("O Diret" + CHR(243) + "rio de Destino " + CHR(34) + loc_cCaminho + CHR(34) + ;
911:                 " N" + CHR(227) + "o " + CHR(233) + " Um Diret" + CHR(243) + "rio V" + CHR(225) + "lido!!!" + CHR(13) + ;
912:                 "O Mesmo Pode N" + CHR(227) + "o Existir, N" + CHR(227) + "o Estar Acess" + CHR(237) + "vel" + ;
913:                 " ou N" + CHR(227) + "o Conter o Arquivo " + CHR(34) + "SigCdLoc.DBF" + CHR(34) + "!!!")
914:         ELSE
915:             loc_oPagina.txt_4c_Dbfs.Value = loc_cCaminho
916:         ENDIF
917:     ENDPROC
918: 
919:     *==========================================================================
920:     * FormParaBO - Transfere dados do Form para o BO antes de salvar
921:     * Campos: cods (txt_4c_Codigo), cidconns (txt_4c_Conexao), drives (txt_4c_Dbfs)
922:     *==========================================================================
923:     PROTECTED PROCEDURE FormParaBO()
924:         LOCAL loc_oPagina
925:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
926: 
927:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
928:             THIS.this_oBusinessObject.this_cCodigo  = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
929:         ENDIF
930:         IF PEMSTATUS(loc_oPagina, "txt_4c_Conexao", 5)
931:             THIS.this_oBusinessObject.this_cConexao = ALLTRIM(loc_oPagina.txt_4c_Conexao.Value)
932:         ENDIF
933:         IF PEMSTATUS(loc_oPagina, "txt_4c_Dbfs", 5)
934:             THIS.this_oBusinessObject.this_cDrives  = ALLTRIM(loc_oPagina.txt_4c_Dbfs.Value)
935:         ENDIF
936:     ENDPROC
937: 
938:     *==========================================================================
939:     * BOParaForm - Transfere dados do BO para o Form apos carregar registro
940:     * Campos: cods (txt_4c_Codigo), cidconns (txt_4c_Conexao), drives (txt_4c_Dbfs)
941:     *==========================================================================
942:     PROTECTED PROCEDURE BOParaForm()
943:         LOCAL loc_oPagina
944:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
945: 
946:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
947:             loc_oPagina.txt_4c_Codigo.Value  = THIS.this_oBusinessObject.this_cCodigo
948:         ENDIF
949:         IF PEMSTATUS(loc_oPagina, "txt_4c_Conexao", 5)
950:             loc_oPagina.txt_4c_Conexao.Value = THIS.this_oBusinessObject.this_cConexao
951:         ENDIF
952:         IF PEMSTATUS(loc_oPagina, "txt_4c_Dbfs", 5)
953:             loc_oPagina.txt_4c_Dbfs.Value    = THIS.this_oBusinessObject.this_cDrives
954:         ENDIF
955:     ENDPROC
956: 
957:     *==========================================================================
958:     * HabilitarCampos - Habilita ou desabilita campos de edicao da Page2
959:     * getCods.When: readonly no Alterar/Visualizar (enabled so no INCLUIR)
960:     *==========================================================================
961:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
962:         LOCAL loc_oPagina, loc_lCodReadOnly
963:         loc_oPagina      = THIS.pgf_4c_Paginas.Page2
964:         loc_lCodReadOnly = (THIS.this_cModoAtual != "INCLUIR")
965: 
966:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
967:             loc_oPagina.txt_4c_Codigo.Enabled  = par_lHabilitar AND !loc_lCodReadOnly
968:         ENDIF
969:         IF PEMSTATUS(loc_oPagina, "txt_4c_Conexao", 5)
970:             loc_oPagina.txt_4c_Conexao.Enabled = par_lHabilitar
971:         ENDIF
972:         IF PEMSTATUS(loc_oPagina, "txt_4c_Dbfs", 5)
973:             loc_oPagina.txt_4c_Dbfs.Enabled    = par_lHabilitar
974:         ENDIF
975:     ENDPROC
976: 
977:     *==========================================================================
978:     * LimparCampos - Limpa todos os campos da Page2 para novo registro
979:     *==========================================================================
980:     PROTECTED PROCEDURE LimparCampos()
981:         LOCAL loc_oPagina
982:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
983: 
984:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
985:             loc_oPagina.txt_4c_Codigo.Value  = ""
986:         ENDIF
987:         IF PEMSTATUS(loc_oPagina, "txt_4c_Conexao", 5)
988:             loc_oPagina.txt_4c_Conexao.Value = ""
989:         ENDIF
990:         IF PEMSTATUS(loc_oPagina, "txt_4c_Dbfs", 5)
991:             loc_oPagina.txt_4c_Dbfs.Value    = ""
992:         ENDIF
993:     ENDPROC
994: 
995:     *==========================================================================
996:     * AjustarBotoesPorModo - Ajusta estado dos botoes da Page2 conforme modo
997:     * INCLUIR/ALTERAR: Confirmar habilitado | VISUALIZAR: Confirmar desabilitado
998:     *==========================================================================
999:     PROCEDURE AjustarBotoesPorModo()
1000:         LOCAL loc_oPagina, loc_lEditando
1001:         loc_oPagina   = THIS.pgf_4c_Paginas.Page2
1002:         loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1003: 
1004:         IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
1005:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1006:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
1007:             ENDIF
1008:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
1009:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
1010:             ENDIF
1011:         ENDIF
1012:     ENDPROC
1013: 
1014:     *==========================================================================
1015:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1016:     * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)
1017:     *==========================================================================
1018:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1019:         LOCAL loc_nI, loc_oObjeto, loc_nP
1020: 
1021:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1022:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1023: 
1024:             IF VARTYPE(loc_oObjeto) = "O"
1025:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1026:                     loc_oObjeto.Visible = .T.
1027:                 ENDIF
1028: 
1029:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1030:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1031:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1032:                     ENDFOR
1033:                 ENDIF
1034: 
1035:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1036:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1037:                 ENDIF
1038:             ENDIF
1039:         ENDFOR
1040:     ENDPROC
1041: 
1042:     *==========================================================================
1043:     * Destroy - Libera recursos ao fechar o formulario
1044:     *==========================================================================
1045:     PROCEDURE Destroy()
1046:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1047:             THIS.this_oBusinessObject = .NULL.
1048:         ENDIF
1049: 
1050:         IF USED("cursor_4c_Dados")
1051:             USE IN cursor_4c_Dados
1052:         ENDIF
1053: 
1054:         IF USED("cursor_4c_BuscaLoc")
1055:             USE IN cursor_4c_BuscaLoc
1056:         ENDIF
1057: 
1058:         IF USED("cursor_4c_BuscaConn")
1059:             USE IN cursor_4c_BuscaConn
1060:         ENDIF
1061: 
1062:         DODEFAULT()
1063:     ENDPROC
1064: 
1065: ENDDEFINE


### BO (C:\4c\projeto\app\classes\LOCBO.prg):
*==============================================================================
* LOCBO.prg - Business Object para Cadastro de Locais
* Tabela: SigCdLoc
* PK: cods (char 10)
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS LOCBO AS BusinessBase

    *-- Propriedades de dados (this_c* = Character)
    this_cCodigo  = ""    && cods     char(10) PK
    this_cConexao = ""    && cidconns char(20)
    this_cDrives  = ""    && drives   char(80)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdLoc"
            THIS.this_cCampoChave = "cods"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "LOCBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparDados - Limpa propriedades de dados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()
        THIS.this_cCodigo  = ""
        THIS.this_cConexao = ""
        THIS.this_cDrives  = ""
    ENDPROC

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
                THIS.this_cCodigo  = TratarNulo(cods,     "C")
                THIS.this_cConexao = TratarNulo(cidconns, "C")
                THIS.this_cDrives  = TratarNulo(drives,   "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "LOCBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido, loc_cCaminho
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigo))
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCodigo)
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " Cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cConexao))
            MsgAviso("Obrigat" + CHR(243) + "rio Informar a Conex" + CHR(227) + "o!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND !EMPTY(ALLTRIM(THIS.this_cDrives))
            loc_cCaminho = ALLTRIM(THIS.this_cDrives)
            IF RIGHT(loc_cCaminho, 1) <> "\"
                loc_cCaminho = loc_cCaminho + "\"
            ENDIF
            IF !FILE(loc_cCaminho + "SigCdLoc.DBF")
                MsgAviso("O Diret" + CHR(243) + "rio de Destino " + CHR(34) + loc_cCaminho + CHR(34) + ;
                    " N" + CHR(227) + "o " + CHR(233) + " Um Diret" + CHR(243) + "rio V" + CHR(225) + "lido!!!" + CHR(13) + ;
                    "O Mesmo Pode N" + CHR(227) + "o Existir, N" + CHR(227) + "o Estar Acess" + CHR(237) + "vel" + ;
                    " ou N" + CHR(227) + "o Conter o Arquivo " + CHR(34) + "SigCdLoc.DBF" + CHR(34) + "!!!")
                loc_lValido = .F.
            ELSE
                THIS.this_cDrives = loc_cCaminho
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarCodigoExistente - Verifica se cods ja existe no banco
    *--------------------------------------------------------------------------
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdLoc" + ;
                " WHERE cods = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkLoc")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkLoc")
                SELECT cursor_4c_ChkLoc
                loc_lExiste = (cursor_4c_ChkLoc.qtd > 0)
                USE IN cursor_4c_ChkLoc
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "LOCBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdLoc
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdLoc (cods, cidconns, drives)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cConexao)>>,
                    <<EscaparSQL(THIS.this_cDrives)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir local:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "LOCBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCdLoc
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdLoc
                SET cidconns = <<EscaparSQL(THIS.this_cConexao)>>,
                    drives   = <<EscaparSQL(THIS.this_cDrives)>>
                WHERE cods = <<EscaparSQL(THIS.this_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar local:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "LOCBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCdLoc
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdLoc WHERE cods = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir local:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "LOCBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com cods, cidconns, drives
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (cods C(10), cidconns C(20), drives C(80))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT cods, cidconns, drives FROM SigCdLoc"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY cods"

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
                        MostrarErro("Erro ao buscar locais:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar locais:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "LOCBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria (cods)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cods, cidconns, drives FROM SigCdLoc" + ;
                " WHERE cods = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Local n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar local:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "LOCBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

