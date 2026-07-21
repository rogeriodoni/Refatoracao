# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (6)
- [BINDEVENT-PARAMS] Handler 'ValidarDataInicial' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDataInicial(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDataFinal' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDataFinal(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarGrupo' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGrupo(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarProduto' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarProduto(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarCPros' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarCPros(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarMoeda' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarMoeda(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigprpre.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1480 linhas total):

*-- Linhas 29 a 145:
29:     *--------------------------------------------------------------------------
30:     * Init
31:     *--------------------------------------------------------------------------
32:     PROCEDURE Init()
33:         LOCAL loc_lResultado
34:         loc_lResultado = .F.
35:         TRY
36:             loc_lResultado = DODEFAULT()
37:         CATCH TO loc_oErro
38:             MsgErro(loc_oErro.Message, "Formsigprpre.Init")
39:         ENDTRY
40:         RETURN loc_lResultado
41:     ENDPROC
42: 
43:     *--------------------------------------------------------------------------
44:     * InicializarForm - Chamado pelo FormBase.Init()
45:     *--------------------------------------------------------------------------
46:     PROTECTED PROCEDURE InicializarForm()
47:         LOCAL loc_lSucesso
48:         loc_lSucesso = .F.
49:         TRY
50:             THIS.Caption   = "Cadastro de Altera" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os"
51:             THIS.BackColor = RGB(100, 100, 100)
52: 
53:             THIS.this_oBusinessObject = CREATEOBJECT("sigprpreBO")
54:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
55:                 MsgErro("Erro ao criar sigprpreBO", "InicializarForm")
56:             ELSE
57:                 THIS.ConfigurarPageFrame()
58:                 THIS.pgf_4c_Paginas.Visible = .T.
59:                 THIS.pgf_4c_Paginas.ActivePage = 1
60:                 THIS.this_cModoAtual = "LISTA"
61: 
62:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
63:                     THIS.CarregarLista()
64:                 ENDIF
65: 
66:                 loc_lSucesso = .T.
67:             ENDIF
68:         CATCH TO loc_oErro
69:             MsgErro(loc_oErro.Message, "InicializarForm")
70:         ENDTRY
71:         RETURN loc_lSucesso
72:     ENDPROC
73: 
74:     *--------------------------------------------------------------------------
75:     * ConfigurarPageFrame - Cria PageFrame principal com 2 paginas
76:     *--------------------------------------------------------------------------
77:     PROTECTED PROCEDURE ConfigurarPageFrame()
78:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
79:         WITH THIS.pgf_4c_Paginas
80:             .PageCount = 2
81:             .Top       = -29
82:             .Left      = 0
83:             .Width     = THIS.Width
84:             .Height    = THIS.Height + 29
85:             .Tabs      = .F.
86:             .Visible   = .T.
87: 
88:             WITH .Page1
89:                 .Caption   = "Lista"
90:             ENDWITH
91: 
92:             WITH .Page2
93:                 .Caption   = "Dados"
94:                 .BackColor = RGB(100, 100, 100)
95:             ENDWITH
96:         ENDWITH
97: 
98:         THIS.ConfigurarPaginaLista()
99:         THIS.ConfigurarPaginaDados()
100:     ENDPROC
101: 
102:     *--------------------------------------------------------------------------
103:     * ConfigurarPaginaLista - Pagina 1: Grid e botoes CRUD completos
104:     *--------------------------------------------------------------------------
105:     PROTECTED PROCEDURE ConfigurarPaginaLista()
106:         LOCAL loc_oPagina, loc_oCnt, loc_oGrid
107:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
108: 
109:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
110:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
111: 
112:         *-- Container Cabecalho (cntSombra) - Top compensado: 2+29=31
113:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
114:         WITH loc_oPagina.cnt_4c_Cabecalho
115:             .Top         = 31
116:             .Left        = 0
117:             .Width       = THIS.Width
118:             .Height      = 80
119:             .BackColor   = RGB(100, 100, 100)
120:             .BackStyle   = 1
121:             .BorderWidth = 0
122:             .Visible     = .T.
123:         ENDWITH
124:         loc_oCnt = loc_oPagina.cnt_4c_Cabecalho
125:         loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
126:         WITH loc_oCnt.lbl_4c_Sombra
127:             .AutoSize  = .F.
128:             .Caption   = "Cadastro de Altera" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os"
129:             .Top       = 15
130:             .Left      = 10
131:             .Width     = 769
132:             .Height    = 40
133:             .FontName  = "Tahoma"
134:             .FontSize  = 16
135:             .FontBold  = .T.
136:             .ForeColor = RGB(0, 0, 0)
137:             .BackStyle = 0
138:         ENDWITH
139:         loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
140:         WITH loc_oCnt.lbl_4c_Titulo
141:             .AutoSize  = .F.
142:             .Caption   = "Cadastro de Altera" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os"
143:             .Top       = 18
144:             .Left      = 10
145:             .Width     = 769

*-- Linhas 186 a 615:
186:             .WordWrap        = .T.
187:             .AutoSize        = .F.
188:         ENDWITH
189:         BINDEVENT(loc_oCnt.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
190: 
191:         loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
192:         WITH loc_oCnt.cmd_4c_Visualizar
193:             .Caption         = "Visualizar"
194:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
195:             .PicturePosition = 13
196:             .Top             = 5
197:             .Left            = 80
198:             .Width           = 75
199:             .Height          = 75
200:             .FontName        = "Comic Sans MS"
201:             .FontSize        = 8
202:             .FontBold        = .T.
203:             .FontItalic      = .T.
204:             .ForeColor       = RGB(90, 90, 90)
205:             .BackColor       = RGB(255, 255, 255)
206:             .Themes          = .F.
207:             .SpecialEffect   = 0
208:             .MousePointer    = 15
209:             .WordWrap        = .T.
210:             .AutoSize        = .F.
211:         ENDWITH
212:         BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
213: 
214:         loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
215:         WITH loc_oCnt.cmd_4c_Alterar
216:             .Caption         = "Alterar"
217:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
218:             .PicturePosition = 13
219:             .Top             = 5
220:             .Left            = 155
221:             .Width           = 75
222:             .Height          = 75
223:             .FontName        = "Comic Sans MS"
224:             .FontSize        = 8
225:             .FontBold        = .T.
226:             .FontItalic      = .T.
227:             .ForeColor       = RGB(90, 90, 90)
228:             .BackColor       = RGB(255, 255, 255)
229:             .Themes          = .F.
230:             .SpecialEffect   = 0
231:             .MousePointer    = 15
232:             .WordWrap        = .T.
233:             .AutoSize        = .F.
234:         ENDWITH
235:         BINDEVENT(loc_oCnt.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
236: 
237:         loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
238:         WITH loc_oCnt.cmd_4c_Excluir
239:             .Caption         = "Excluir"
240:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
241:             .PicturePosition = 13
242:             .Top             = 5
243:             .Left            = 230
244:             .Width           = 75
245:             .Height          = 75
246:             .FontName        = "Comic Sans MS"
247:             .FontSize        = 8
248:             .FontBold        = .T.
249:             .FontItalic      = .T.
250:             .ForeColor       = RGB(90, 90, 90)
251:             .BackColor       = RGB(255, 255, 255)
252:             .Themes          = .F.
253:             .SpecialEffect   = 0
254:             .MousePointer    = 15
255:             .WordWrap        = .T.
256:             .AutoSize        = .F.
257:         ENDWITH
258:         BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
259: 
260:         loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
261:         WITH loc_oCnt.cmd_4c_Buscar
262:             .Caption         = "Buscar"
263:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
264:             .PicturePosition = 13
265:             .Top             = 5
266:             .Left            = 305
267:             .Width           = 75
268:             .Height          = 75
269:             .FontName        = "Comic Sans MS"
270:             .FontSize        = 8
271:             .FontBold        = .T.
272:             .FontItalic      = .T.
273:             .ForeColor       = RGB(90, 90, 90)
274:             .BackColor       = RGB(255, 255, 255)
275:             .Themes          = .F.
276:             .SpecialEffect   = 0
277:             .MousePointer    = 15
278:             .WordWrap        = .T.
279:             .AutoSize        = .F.
280:         ENDWITH
281:         BINDEVENT(loc_oCnt.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
282: 
283:         *-- Container Saida (canonico: Left=917, Width=90) - transparente
284:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
285:         WITH loc_oPagina.cnt_4c_Saida
286:             .Top         = 29
287:             .Left        = 917
288:             .Width       = 90
289:             .Height      = 85
290:             .BackStyle   = 0
291:             .BorderWidth = 0
292:             .Visible     = .T.
293:         ENDWITH
294:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
295:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
296:             .Caption         = "Encerrar"
297:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
298:             .PicturePosition = 13
299:             .Top             = 5
300:             .Left            = 5
301:             .Width           = 75
302:             .Height          = 75
303:             .FontName        = "Comic Sans MS"
304:             .FontSize        = 8
305:             .FontBold        = .T.
306:             .FontItalic      = .T.
307:             .ForeColor       = RGB(90, 90, 90)
308:             .BackColor       = RGB(255, 255, 255)
309:             .Themes          = .F.
310:             .SpecialEffect   = 0
311:             .MousePointer    = 15
312:             .WordWrap        = .T.
313:             .AutoSize        = .F.
314:         ENDWITH
315:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
316: 
317:         *-- Container Filtro Periodo (CntPeriodo) - Top compensado: 90+29=119
318:         loc_oPagina.AddObject("cnt_4c_Periodo", "Container")
319:         WITH loc_oPagina.cnt_4c_Periodo
320:             .Top         = 119
321:             .Left        = 701
322:             .Width       = 266
323:             .Height      = 27
324:             .BackStyle   = 0
325:             .BorderWidth = 0
326:             .Visible     = .T.
327:         ENDWITH
328:         loc_oCnt = loc_oPagina.cnt_4c_Periodo
329: 
330:         loc_oCnt.AddObject("lbl_4c_Periodo", "Label")
331:         WITH loc_oCnt.lbl_4c_Periodo
332:             .Caption   = "Per" + CHR(237) + "odo : "
333:             .Top       = 6
334:             .Left      = 15
335:             .Width     = 48
336:             .Height    = 15
337:             .FontName  = "Tahoma"
338:             .FontSize  = 8
339:             .ForeColor = RGB(90, 90, 90)
340:             .BackStyle = 0
341:         ENDWITH
342: 
343:         loc_oCnt.AddObject("txt_4c_Dt_inicial", "TextBox")
344:         WITH loc_oCnt.txt_4c_Dt_inicial
345:             .Top      = 2
346:             .Left     = 65
347:             .Width    = 80
348:             .Height   = 23
349:             .Format   = "D"
350:             .Value    = DATE()
351:             .FontName = "Tahoma"
352:             .FontSize = 8
353:         ENDWITH
354:         BINDEVENT(loc_oCnt.txt_4c_Dt_inicial, "KeyPress", THIS, "ValidarDataInicial")
355: 
356:         loc_oCnt.AddObject("lbl_4c_Sep", "Label")
357:         WITH loc_oCnt.lbl_4c_Sep
358:             .Caption   = "-"
359:             .Top       = 6
360:             .Left      = 151
361:             .Width     = 10
362:             .Height    = 15
363:             .FontName  = "Tahoma"
364:             .FontSize  = 8
365:             .ForeColor = RGB(90, 90, 90)
366:             .BackStyle = 0
367:         ENDWITH
368: 
369:         loc_oCnt.AddObject("txt_4c_Dt_final", "TextBox")
370:         WITH loc_oCnt.txt_4c_Dt_final
371:             .Top      = 2
372:             .Left     = 165
373:             .Width    = 80
374:             .Height   = 23
375:             .Format   = "D"
376:             .Value    = DATE()
377:             .FontName = "Tahoma"
378:             .FontSize = 8
379:         ENDWITH
380:         BINDEVENT(loc_oCnt.txt_4c_Dt_final, "KeyPress", THIS, "ValidarDataFinal")
381: 
382:         *-- Container Filtro Produto/Grupo (cntProd) - Top compensado: 89+29=118
383:         loc_oPagina.AddObject("cnt_4c_Prod", "Container")
384:         WITH loc_oPagina.cnt_4c_Prod
385:             .Top         = 118
386:             .Left        = 16
387:             .Width       = 641
388:             .Height      = 27
389:             .BackStyle   = 0
390:             .BorderWidth = 0
391:             .Visible     = .T.
392:         ENDWITH
393:         loc_oCnt = loc_oPagina.cnt_4c_Prod
394: 
395:         loc_oCnt.AddObject("lbl_4c_GrupoProd", "Label")
396:         WITH loc_oCnt.lbl_4c_GrupoProd
397:             .Caption   = "Grupo/Produto : "
398:             .Top       = 7
399:             .Left      = 38
400:             .Width     = 83
401:             .Height    = 15
402:             .FontName  = "Tahoma"
403:             .FontSize  = 8
404:             .ForeColor = RGB(90, 90, 90)
405:             .BackStyle = 0
406:         ENDWITH
407: 
408:         loc_oCnt.AddObject("txt_4c_Grupo", "TextBox")
409:         WITH loc_oCnt.txt_4c_Grupo
410:             .Top      = 3
411:             .Left     = 123
412:             .Width    = 69
413:             .Height   = 23
414:             .Value    = ""
415:             .FontName = "Tahoma"
416:             .FontSize = 8
417:         ENDWITH
418:         BINDEVENT(loc_oCnt.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupo")
419: 
420:         loc_oCnt.AddObject("txt_4c_Prod", "TextBox")
421:         WITH loc_oCnt.txt_4c_Prod
422:             .Top      = 3
423:             .Left     = 197
424:             .Width    = 115
425:             .Height   = 23
426:             .Value    = ""
427:             .FontName = "Tahoma"
428:             .FontSize = 8
429:         ENDWITH
430:         BINDEVENT(loc_oCnt.txt_4c_Prod, "KeyPress", THIS, "ValidarProduto")
431: 
432:         loc_oCnt.AddObject("txt_4c_DProd", "TextBox")
433:         WITH loc_oCnt.txt_4c_DProd
434:             .Top      = 3
435:             .Left     = 317
436:             .Width    = 317
437:             .Height   = 23
438:             .Value    = ""
439:             .Enabled  = .F.
440:             .FontName = "Tahoma"
441:             .FontSize = 8
442:         ENDWITH
443: 
444:         *-- Grid de Lista (Grade) - Top compensado: 126+29=155
445:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
446:         loc_oGrid = loc_oPagina.grd_4c_Lista
447:         loc_oGrid.Top                = 155
448:         loc_oGrid.Left               = 29
449:         loc_oGrid.Width              = 940
450:         loc_oGrid.Height             = 459
451:         loc_oGrid.ColumnCount        = 8
452:         loc_oGrid.FontName           = "Verdana"
453:         loc_oGrid.FontSize           = 8
454:         loc_oGrid.ForeColor          = RGB(90, 90, 90)
455:         loc_oGrid.BackColor          = RGB(255, 255, 255)
456:         loc_oGrid.GridLineColor      = RGB(238, 238, 238)
457:         loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
458:         loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
459:         loc_oGrid.HighlightStyle     = 2
460:         loc_oGrid.DeleteMark         = .F.
461:         loc_oGrid.RecordMark         = .F.
462:         loc_oGrid.RowHeight          = 16
463:         loc_oGrid.ScrollBars         = 2
464:         loc_oGrid.GridLines          = 3
465:         loc_oGrid.ReadOnly           = .T.
466:         WITH loc_oGrid
467:             .Column1.Width = 80
468:             .Column2.Width = 200
469:             .Column3.Width = 90
470:             .Column4.Width = 100
471:             .Column5.Width = 60
472:             .Column6.Width = 100
473:             .Column7.Width = 100
474:             .Column8.Width = 120
475:         ENDWITH
476: 
477:         THIS.TornarControlesVisiveis(loc_oPagina)
478:     ENDPROC
479: 
480:     *--------------------------------------------------------------------------
481:     * ConfigurarPaginaDados - Pagina 2: Botoes + primeiros 50% dos campos
482:     *--------------------------------------------------------------------------
483:     PROTECTED PROCEDURE ConfigurarPaginaDados()
484:         LOCAL loc_oPagina, loc_oCnt
485:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
486: 
487:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
488:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
489: 
490:         *-- Container botoes Confirmar/Cancelar - Top compensado: 4+29=33
491:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
492:         WITH loc_oPagina.cnt_4c_BotoesAcao
493:             .Top         = 33
494:             .Left        = 842
495:             .Width       = 160
496:             .Height      = 85
497:             .BackStyle   = 0
498:             .BorderWidth = 0
499:             .Visible     = .T.
500:         ENDWITH
501:         loc_oCnt = loc_oPagina.cnt_4c_BotoesAcao
502: 
503:         loc_oCnt.AddObject("cmd_4c_Confirmar", "CommandButton")
504:         WITH loc_oCnt.cmd_4c_Confirmar
505:             .Caption         = "Confirmar"
506:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
507:             .PicturePosition = 13
508:             .Top             = 5
509:             .Left            = 5
510:             .Width           = 75
511:             .Height          = 75
512:             .FontName        = "Comic Sans MS"
513:             .FontSize        = 8
514:             .FontBold        = .T.
515:             .FontItalic      = .T.
516:             .ForeColor       = RGB(90, 90, 90)
517:             .BackColor       = RGB(255, 255, 255)
518:             .Themes          = .F.
519:             .SpecialEffect   = 0
520:             .MousePointer    = 15
521:             .WordWrap        = .T.
522:             .AutoSize        = .F.
523:         ENDWITH
524:         BINDEVENT(loc_oCnt.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
525: 
526:         loc_oCnt.AddObject("cmd_4c_Cancelar", "CommandButton")
527:         WITH loc_oCnt.cmd_4c_Cancelar
528:             .Caption         = "Encerrar"
529:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
530:             .PicturePosition = 13
531:             .Top             = 5
532:             .Left            = 80
533:             .Width           = 75
534:             .Height          = 75
535:             .FontName        = "Comic Sans MS"
536:             .FontSize        = 8
537:             .FontBold        = .T.
538:             .FontItalic      = .T.
539:             .ForeColor       = RGB(90, 90, 90)
540:             .BackColor       = RGB(255, 255, 255)
541:             .Themes          = .F.
542:             .SpecialEffect   = 0
543:             .MousePointer    = 15
544:             .WordWrap        = .T.
545:             .AutoSize        = .F.
546:         ENDWITH
547:         BINDEVENT(loc_oCnt.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
548: 
549:         *-- [CAMPO 1/5 - Fase 5] Codigo do Produto (CPros) + Descricao (DPros readonly)
550:         loc_oPagina.AddObject("lbl_4c_CPros", "Label")
551:         WITH loc_oPagina.lbl_4c_CPros
552:             .Caption   = "Produto :"
553:             .Top       = 133
554:             .Left      = 30
555:             .Width     = 100
556:             .Height    = 17
557:             .FontName  = "Tahoma"
558:             .FontSize  = 8
559:             .ForeColor = RGB(90, 90, 90)
560:             .BackStyle = 0
561:             .Alignment = 1
562:         ENDWITH
563: 
564:         loc_oPagina.AddObject("txt_4c_CPros", "TextBox")
565:         WITH loc_oPagina.txt_4c_CPros
566:             .Top           = 129
567:             .Left          = 135
568:             .Width         = 100
569:             .Height        = 23
570:             .Value         = ""
571:             .FontName      = "Tahoma"
572:             .FontSize      = 8
573:             .SpecialEffect = 1
574:         ENDWITH
575:         BINDEVENT(loc_oPagina.txt_4c_CPros, "KeyPress", THIS, "ValidarCPros")
576: 
577:         loc_oPagina.AddObject("txt_4c_DPros", "TextBox")
578:         WITH loc_oPagina.txt_4c_DPros
579:             .Top           = 129
580:             .Left          = 240
581:             .Width         = 400
582:             .Height        = 23
583:             .Value         = ""
584:             .Enabled       = .F.
585:             .FontName      = "Tahoma"
586:             .FontSize      = 8
587:             .SpecialEffect = 1
588:         ENDWITH
589: 
590:         *-- [CAMPO 2/5 - Fase 5] Data
591:         loc_oPagina.AddObject("lbl_4c_Datas", "Label")
592:         WITH loc_oPagina.lbl_4c_Datas
593:             .Caption   = "Data :"
594:             .Top       = 163
595:             .Left      = 30
596:             .Width     = 100
597:             .Height    = 17
598:             .FontName  = "Tahoma"
599:             .FontSize  = 8
600:             .ForeColor = RGB(90, 90, 90)
601:             .BackStyle = 0
602:             .Alignment = 1
603:         ENDWITH
604: 
605:         loc_oPagina.AddObject("txt_4c_Datas", "TextBox")
606:         WITH loc_oPagina.txt_4c_Datas
607:             .Top           = 159
608:             .Left          = 135
609:             .Width         = 80
610:             .Height        = 23
611:             .Format        = "D"
612:             .Value         = DATE()
613:             .FontName      = "Tahoma"
614:             .FontSize      = 8
615:             .SpecialEffect = 1

*-- Linhas 641 a 717:
641:             .FontSize      = 8
642:             .SpecialEffect = 1
643:         ENDWITH
644:         BINDEVENT(loc_oPagina.txt_4c_Moevs, "KeyPress", THIS, "ValidarMoeda")
645: 
646:         loc_oPagina.AddObject("lbl_4c_MoevsAnt", "Label")
647:         WITH loc_oPagina.lbl_4c_MoevsAnt
648:             .Caption   = "Moeda Ant. :"
649:             .Top       = 193
650:             .Left      = 220
651:             .Width     = 100
652:             .Height    = 17
653:             .FontName  = "Tahoma"
654:             .FontSize  = 8
655:             .ForeColor = RGB(90, 90, 90)
656:             .BackStyle = 0
657:             .Alignment = 1
658:         ENDWITH
659: 
660:         loc_oPagina.AddObject("txt_4c_MoevsAnt", "TextBox")
661:         WITH loc_oPagina.txt_4c_MoevsAnt
662:             .Top           = 189
663:             .Left          = 325
664:             .Width         = 60
665:             .Height        = 23
666:             .Value         = ""
667:             .Enabled       = .F.
668:             .FontName      = "Tahoma"
669:             .FontSize      = 8
670:             .SpecialEffect = 1
671:         ENDWITH
672: 
673:         *-- BINDEVENT F4 e DblClick para campos com lookup na Page2
674:         BINDEVENT(loc_oPagina.txt_4c_CPros, "KeyPress", THIS, "CProsKeyPress")
675:         BINDEVENT(loc_oPagina.txt_4c_CPros, "DblClick", THIS, "CProsDblClick")
676:         BINDEVENT(loc_oPagina.txt_4c_Moevs, "KeyPress", THIS, "MoevsKeyPress")
677:         BINDEVENT(loc_oPagina.txt_4c_Moevs, "DblClick", THIS, "MoevsDblClick")
678: 
679:         *-- [CAMPO 4/6 - Fase 6] Preco Atual (PVens) + Preco Anterior (PVensAnt readonly)
680:         loc_oPagina.AddObject("lbl_4c_PVens", "Label")
681:         WITH loc_oPagina.lbl_4c_PVens
682:             .Caption   = "Pre" + CHR(231) + "o Atual :"
683:             .Top       = 223
684:             .Left      = 30
685:             .Width     = 100
686:             .Height    = 17
687:             .FontName  = "Tahoma"
688:             .FontSize  = 8
689:             .ForeColor = RGB(90, 90, 90)
690:             .BackStyle = 0
691:             .Alignment = 1
692:         ENDWITH
693: 
694:         loc_oPagina.AddObject("txt_4c_PVens", "TextBox")
695:         WITH loc_oPagina.txt_4c_PVens
696:             .Top           = 219
697:             .Left          = 135
698:             .Width         = 100
699:             .Height        = 23
700:             .Value         = 0
701:             .InputMask     = "9,999,999.99"
702:             .FontName      = "Tahoma"
703:             .FontSize      = 8
704:             .SpecialEffect = 1
705:         ENDWITH
706: 
707:         loc_oPagina.AddObject("lbl_4c_PVensAnt", "Label")
708:         WITH loc_oPagina.lbl_4c_PVensAnt
709:             .Caption   = "Pre" + CHR(231) + "o Ant. :"
710:             .Top       = 223
711:             .Left      = 250
712:             .Width     = 100
713:             .Height    = 17
714:             .FontName  = "Tahoma"
715:             .FontSize  = 8
716:             .ForeColor = RGB(90, 90, 90)
717:             .BackStyle = 0

*-- Linhas 775 a 824:
775:             .BackStyle = 0
776:         ENDWITH
777: 
778:         THIS.TornarControlesVisiveis(loc_oPagina)
779:     ENDPROC
780: 
781:     *--------------------------------------------------------------------------
782:     * CarregarLista - Carrega dados no Grid com filtros de periodo/produto/grupo
783:     *--------------------------------------------------------------------------
784:     PROCEDURE CarregarLista()
785:         LOCAL loc_lResultado, loc_oPagina, loc_oGrid, loc_oCntPeriodo, loc_oCntProd
786:         loc_lResultado = .F.
787: 
788:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
789:             RETURN .T.
790:         ENDIF
791: 
792:         TRY
793:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
794:             loc_oGrid   = loc_oPagina.grd_4c_Lista
795: 
796:             *-- Transferir filtros de periodo para o BO
797:             IF PEMSTATUS(loc_oPagina, "cnt_4c_Periodo", 5)
798:                 loc_oCntPeriodo = loc_oPagina.cnt_4c_Periodo
799:                 THIS.this_oBusinessObject.this_dDataInicio = loc_oCntPeriodo.txt_4c_Dt_inicial.Value
800:                 THIS.this_oBusinessObject.this_dDataFim    = loc_oCntPeriodo.txt_4c_Dt_final.Value
801:             ELSE
802:                 THIS.this_oBusinessObject.this_dDataInicio = DATE()
803:                 THIS.this_oBusinessObject.this_dDataFim    = DATE()
804:             ENDIF
805: 
806:             *-- Transferir filtros de produto/grupo para o BO
807:             IF PEMSTATUS(loc_oPagina, "cnt_4c_Prod", 5)
808:                 loc_oCntProd = loc_oPagina.cnt_4c_Prod
809:                 THIS.this_oBusinessObject.this_cFiltroCPro = ALLTRIM(loc_oCntProd.txt_4c_Prod.Value)
810:                 THIS.this_oBusinessObject.this_cFiltroGru  = ALLTRIM(loc_oCntProd.txt_4c_Grupo.Value)
811:             ELSE
812:                 THIS.this_oBusinessObject.this_cFiltroCPro = ""
813:                 THIS.this_oBusinessObject.this_cFiltroGru  = ""
814:             ENDIF
815: 
816:             IF THIS.this_oBusinessObject.Buscar("")
817:                 *-- Vincular grid ao cursor (nome legado crSigPrPre)
818:                 loc_oGrid.RecordSource          = "crSigPrPre"
819:                 loc_oGrid.Column1.ControlSource = "crSigPrPre.cpros"
820:                 loc_oGrid.Column2.ControlSource = "crSigPrPre.dpros"
821:                 loc_oGrid.Column3.ControlSource = "crSigPrPre.cgrus"
822:                 loc_oGrid.Column4.ControlSource = "crSigPrPre.datas"
823:                 loc_oGrid.Column5.ControlSource = "crSigPrPre.moevs"
824:                 loc_oGrid.Column6.ControlSource = "crSigPrPre.pvensant"

*-- Linhas 848 a 1462:
848:     *--------------------------------------------------------------------------
849:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
850:     *--------------------------------------------------------------------------
851:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
852:         LOCAL loc_lResultado
853:         loc_lResultado = .F.
854:         TRY
855:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
856:                 MsgErro("Parametro invalido em AlternarPagina: " + TRANSFORM(par_nPagina), "Erro")
857:             ELSE
858:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
859:                 IF par_nPagina = 1
860:                     THIS.CarregarLista()
861:                 ENDIF
862:                 loc_lResultado = .T.
863:             ENDIF
864:         CATCH TO loc_oErro
865:             MsgErro(loc_oErro.Message, "AlternarPagina")
866:         ENDTRY
867:         RETURN loc_lResultado
868:     ENDPROC
869: 
870:     *--------------------------------------------------------------------------
871:     * BtnIncluirClick - Incluir novo registro
872:     *--------------------------------------------------------------------------
873:     PROCEDURE BtnIncluirClick()
874:         THIS.this_oBusinessObject.NovoRegistro()
875:         THIS.LimparCampos()
876:         THIS.this_cModoAtual = "INCLUIR"
877:         THIS.HabilitarCampos(.T.)
878:         THIS.pgf_4c_Paginas.ActivePage = 2
879:     ENDPROC
880: 
881:     *--------------------------------------------------------------------------
882:     * BtnVisualizarClick - Visualizar registro selecionado (somente leitura)
883:     *--------------------------------------------------------------------------
884:     PROCEDURE BtnVisualizarClick()
885:         LOCAL loc_cCidChaves
886:         IF !USED("crSigPrPre") OR EOF("crSigPrPre")
887:             MsgAviso("Nenhum registro selecionado.", "Visualizar")
888:             RETURN
889:         ENDIF
890:         SELECT crSigPrPre
891:         loc_cCidChaves = ALLTRIM(crSigPrPre.cidchaves)
892:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
893:             THIS.this_cModoAtual = "VISUALIZAR"
894:             THIS.BOParaForm()
895:             THIS.HabilitarCampos(.F.)
896:             THIS.pgf_4c_Paginas.ActivePage = 2
897:         ENDIF
898:     ENDPROC
899: 
900:     *--------------------------------------------------------------------------
901:     * BtnAlterarClick - Alterar registro selecionado
902:     *--------------------------------------------------------------------------
903:     PROCEDURE BtnAlterarClick()
904:         LOCAL loc_cCidChaves
905:         IF !USED("crSigPrPre") OR EOF("crSigPrPre")
906:             MsgAviso("Nenhum registro selecionado.", "Alterar")
907:             RETURN
908:         ENDIF
909:         SELECT crSigPrPre
910:         loc_cCidChaves = ALLTRIM(crSigPrPre.cidchaves)
911:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
912:             THIS.this_oBusinessObject.EditarRegistro()
913:             THIS.this_cModoAtual = "ALTERAR"
914:             THIS.BOParaForm()
915:             THIS.HabilitarCampos(.T.)
916:             THIS.pgf_4c_Paginas.ActivePage = 2
917:         ENDIF
918:     ENDPROC
919: 
920:     *--------------------------------------------------------------------------
921:     * BtnExcluirClick - Excluir registro selecionado
922:     *--------------------------------------------------------------------------
923:     PROCEDURE BtnExcluirClick()
924:         LOCAL loc_cCidChaves, loc_lConfirma
925:         IF !USED("crSigPrPre") OR EOF("crSigPrPre")
926:             MsgAviso("Nenhum registro selecionado.", "Excluir")
927:             RETURN
928:         ENDIF
929:         SELECT crSigPrPre
930:         loc_cCidChaves = ALLTRIM(crSigPrPre.cidchaves)
931:         loc_lConfirma  = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Excluir")
932:         IF loc_lConfirma
933:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
934:                 IF THIS.this_oBusinessObject.Excluir()
935:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
936:                     THIS.CarregarLista()
937:                 ENDIF
938:             ENDIF
939:         ENDIF
940:     ENDPROC
941: 
942:     *--------------------------------------------------------------------------
943:     * BtnBuscarClick - Atualiza lista com filtros atuais
944:     *--------------------------------------------------------------------------
945:     PROCEDURE BtnBuscarClick()
946:         THIS.CarregarLista()
947:     ENDPROC
948: 
949:     *--------------------------------------------------------------------------
950:     * BtnEncerrarClick - Fechar formulario
951:     *--------------------------------------------------------------------------
952:     PROCEDURE BtnEncerrarClick()
953:         THIS.Release()
954:     ENDPROC
955: 
956:     *--------------------------------------------------------------------------
957:     * BtnSalvarClick - Salvar registro (Page2)
958:     *--------------------------------------------------------------------------
959:     PROCEDURE BtnSalvarClick()
960:         LOCAL loc_lValido
961:         loc_lValido = THIS.ValidarCampos()
962:         IF loc_lValido
963:             THIS.FormParaBO()
964:             IF THIS.this_oBusinessObject.Salvar()
965:                 MsgInfo("Registro salvo com sucesso!")
966:                 THIS.this_cModoAtual = "LISTA"
967:                 THIS.AlternarPagina(1)
968:             ENDIF
969:         ENDIF
970:     ENDPROC
971: 
972:     *--------------------------------------------------------------------------
973:     * BtnCancelarClick - Cancelar e voltar para lista
974:     *--------------------------------------------------------------------------
975:     PROCEDURE BtnCancelarClick()
976:         THIS.this_cModoAtual = "LISTA"
977:         THIS.AlternarPagina(1)
978:         THIS.CarregarLista()
979:     ENDPROC
980: 
981:     *--------------------------------------------------------------------------
982:     * ValidarDataInicial - Valida data inicial e recarrega lista (LostFocus)
983:     *--------------------------------------------------------------------------
984:     PROCEDURE ValidarDataInicial(par_nKeyCode, par_nShiftAltCtrl)
985:         LOCAL loc_oCntPeriodo
986:         TRY
987:             loc_oCntPeriodo = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo
988:             IF loc_oCntPeriodo.txt_4c_Dt_inicial.Value > loc_oCntPeriodo.txt_4c_Dt_final.Value
989:                 loc_oCntPeriodo.txt_4c_Dt_final.Value = loc_oCntPeriodo.txt_4c_Dt_inicial.Value
990:             ENDIF
991:             THIS.CarregarLista()
992:         CATCH TO loc_oErro
993:             MsgErro(loc_oErro.Message, "ValidarDataInicial")
994:         ENDTRY
995:     ENDPROC
996: 
997:     *--------------------------------------------------------------------------
998:     * ValidarDataFinal - Valida data final e recarrega lista (LostFocus)
999:     *--------------------------------------------------------------------------
1000:     PROCEDURE ValidarDataFinal(par_nKeyCode, par_nShiftAltCtrl)
1001:         LOCAL loc_oCntPeriodo
1002:         TRY
1003:             loc_oCntPeriodo = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo
1004:             IF loc_oCntPeriodo.txt_4c_Dt_final.Value < loc_oCntPeriodo.txt_4c_Dt_inicial.Value
1005:                 loc_oCntPeriodo.txt_4c_Dt_inicial.Value = loc_oCntPeriodo.txt_4c_Dt_final.Value
1006:             ENDIF
1007:             THIS.CarregarLista()
1008:         CATCH TO loc_oErro
1009:             MsgErro(loc_oErro.Message, "ValidarDataFinal")
1010:         ENDTRY
1011:     ENDPROC
1012: 
1013:     *--------------------------------------------------------------------------
1014:     * ValidarGrupo - Lookup de grupo de produtos (LostFocus em txt_4c_Grupo)
1015:     *--------------------------------------------------------------------------
1016:     PROCEDURE ValidarGrupo(par_nKeyCode, par_nShiftAltCtrl)
1017:         LOCAL loc_cGrupo, loc_oBusca, loc_oCntProd
1018:         TRY
1019:             loc_oCntProd = THIS.pgf_4c_Paginas.Page1.cnt_4c_Prod
1020:             loc_cGrupo   = ALLTRIM(loc_oCntProd.txt_4c_Grupo.Value)
1021: 
1022:             IF EMPTY(loc_cGrupo)
1023:                 THIS.CarregarLista()
1024:             ELSE
1025:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1026:                     "SigCdGrp", "cursor_4c_BuscaGrp", "CGrus", loc_cGrupo, ;
1027:                     "Grupos")
1028:                 IF VARTYPE(loc_oBusca) = "O"
1029:                     IF !loc_oBusca.this_lAchouRegistro
1030:                         loc_oBusca.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
1031:                         loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1032:                         loc_oBusca.mAddColuna("Mercs", "", "Gde. Grupo")
1033:                         loc_oBusca.Show()
1034:                     ENDIF
1035:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
1036:                         SELECT cursor_4c_BuscaGrp
1037:                         loc_oCntProd.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1038:                     ELSE
1039:                         IF !loc_oBusca.this_lAchouRegistro AND !loc_oBusca.this_lSelecionou
1040:                         loc_oCntProd.txt_4c_Grupo.Value = ""
1041:                         ENDIF
1042:                     ENDIF
1043:                     loc_oBusca.Release()
1044:                 ENDIF
1045:                 IF USED("cursor_4c_BuscaGrp")
1046:                     USE IN cursor_4c_BuscaGrp
1047:                 ENDIF
1048:                 THIS.CarregarLista()
1049:             ENDIF
1050:         CATCH TO loc_oErro
1051:             MsgErro(loc_oErro.Message, "ValidarGrupo")
1052:         ENDTRY
1053:     ENDPROC
1054: 
1055:     *--------------------------------------------------------------------------
1056:     * ValidarProduto - Lookup de produto (LostFocus em txt_4c_Prod)
1057:     *--------------------------------------------------------------------------
1058:     PROCEDURE ValidarProduto(par_nKeyCode, par_nShiftAltCtrl)
1059:         LOCAL loc_cProd, loc_oBusca, loc_oCntProd
1060:         TRY
1061:             loc_oCntProd = THIS.pgf_4c_Paginas.Page1.cnt_4c_Prod
1062:             loc_cProd    = ALLTRIM(loc_oCntProd.txt_4c_Prod.Value)
1063: 
1064:             IF EMPTY(loc_cProd)
1065:                 loc_oCntProd.txt_4c_DProd.Value = ""
1066:                 THIS.CarregarLista()
1067:             ELSE
1068:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1069:                     "SigCdPro", "cursor_4c_BuscaPro", "CPros", loc_cProd, ;
1070:                     "Sele" + CHR(231) + CHR(227) + "o")
1071:                 IF VARTYPE(loc_oBusca) = "O"
1072:                     IF !loc_oBusca.this_lAchouRegistro
1073:                         loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
1074:                         loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
1075:                         loc_oBusca.Show()
1076:                     ENDIF
1077:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPro")
1078:                         SELECT cursor_4c_BuscaPro
1079:                         loc_oCntProd.txt_4c_Prod.Value  = ALLTRIM(cursor_4c_BuscaPro.CPros)
1080:                         loc_oCntProd.txt_4c_DProd.Value = ALLTRIM(cursor_4c_BuscaPro.DPros)
1081:                     ELSE
1082:                         IF !loc_oBusca.this_lAchouRegistro AND !loc_oBusca.this_lSelecionou
1083:                         loc_oCntProd.txt_4c_Prod.Value  = ""
1084:                         loc_oCntProd.txt_4c_DProd.Value = ""
1085:                         ENDIF
1086:                     ENDIF
1087:                     loc_oBusca.Release()
1088:                 ENDIF
1089:                 IF USED("cursor_4c_BuscaPro")
1090:                     USE IN cursor_4c_BuscaPro
1091:                 ENDIF
1092:                 THIS.CarregarLista()
1093:             ENDIF
1094:         CATCH TO loc_oErro
1095:             MsgErro(loc_oErro.Message, "ValidarProduto")
1096:         ENDTRY
1097:     ENDPROC
1098: 
1099:     *--------------------------------------------------------------------------
1100:     * ValidarCPros - Lookup de produto no campo CPros da Page2 (LostFocus)
1101:     *--------------------------------------------------------------------------
1102:     PROCEDURE ValidarCPros(par_nKeyCode, par_nShiftAltCtrl)
1103:         LOCAL loc_cProd, loc_oBusca, loc_oPagina
1104:         TRY
1105:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1106:             loc_cProd   = ALLTRIM(loc_oPagina.txt_4c_CPros.Value)
1107: 
1108:             IF EMPTY(loc_cProd)
1109:                 IF PEMSTATUS(loc_oPagina, "txt_4c_DPros", 5)
1110:                     loc_oPagina.txt_4c_DPros.Value = ""
1111:                 ENDIF
1112:                 THIS.this_oBusinessObject.this_cDPros = ""
1113:             ELSE
1114:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1115:                     "SigCdPro", "cursor_4c_BuscaPro2", "CPros", loc_cProd, ;
1116:                     "Sele" + CHR(231) + CHR(227) + "o")
1117:                 IF VARTYPE(loc_oBusca) = "O"
1118:                     IF !loc_oBusca.this_lAchouRegistro
1119:                         loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
1120:                         loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
1121:                         loc_oBusca.Show()
1122:                     ENDIF
1123:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPro2")
1124:                         SELECT cursor_4c_BuscaPro2
1125:                         loc_oPagina.txt_4c_CPros.Value = ALLTRIM(cursor_4c_BuscaPro2.CPros)
1126:                         IF PEMSTATUS(loc_oPagina, "txt_4c_DPros", 5)
1127:                             loc_oPagina.txt_4c_DPros.Value = ALLTRIM(cursor_4c_BuscaPro2.DPros)
1128:                         ENDIF
1129:                         THIS.this_oBusinessObject.this_cDPros = ALLTRIM(cursor_4c_BuscaPro2.DPros)
1130:                     ELSE
1131:                         IF !loc_oBusca.this_lAchouRegistro AND !loc_oBusca.this_lSelecionou
1132:                         loc_oPagina.txt_4c_CPros.Value = ""
1133:                         IF PEMSTATUS(loc_oPagina, "txt_4c_DPros", 5)
1134:                             loc_oPagina.txt_4c_DPros.Value = ""
1135:                         ENDIF
1136:                         THIS.this_oBusinessObject.this_cDPros = ""
1137:                         ENDIF
1138:                     ENDIF
1139:                     loc_oBusca.Release()
1140:                 ENDIF
1141:                 IF USED("cursor_4c_BuscaPro2")
1142:                     USE IN cursor_4c_BuscaPro2
1143:                 ENDIF
1144:             ENDIF
1145:         CATCH TO loc_oErro
1146:             MsgErro(loc_oErro.Message, "ValidarCPros")
1147:         ENDTRY
1148:     ENDPROC
1149: 
1150:     *--------------------------------------------------------------------------
1151:     * ValidarMoeda - Lookup de moeda no campo Moevs da Page2 (LostFocus)
1152:     *--------------------------------------------------------------------------
1153:     PROCEDURE ValidarMoeda(par_nKeyCode, par_nShiftAltCtrl)
1154:         LOCAL loc_cMoeda, loc_oBusca, loc_oPagina
1155:         TRY
1156:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1157:             loc_cMoeda  = ALLTRIM(loc_oPagina.txt_4c_Moevs.Value)
1158: 
1159:             IF !EMPTY(loc_cMoeda)
1160:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1161:                     "SigCdMoe", "cursor_4c_BuscaMoe", "moevs", loc_cMoeda, ;
1162:                     "Moeda")
1163:                 IF VARTYPE(loc_oBusca) = "O"
1164:                     IF !loc_oBusca.this_lAchouRegistro
1165:                         loc_oBusca.mAddColuna("moevs", "", "C" + CHR(243) + "digo")
1166:                         loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1167:                         loc_oBusca.Show()
1168:                     ENDIF
1169:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
1170:                         SELECT cursor_4c_BuscaMoe
1171:                         loc_oPagina.txt_4c_Moevs.Value = ALLTRIM(cursor_4c_BuscaMoe.moevs)
1172:                     ELSE
1173:                         IF !loc_oBusca.this_lAchouRegistro AND !loc_oBusca.this_lSelecionou
1174:                         loc_oPagina.txt_4c_Moevs.Value = ""
1175:                         ENDIF
1176:                     ENDIF
1177:                     loc_oBusca.Release()
1178:                 ENDIF
1179:                 IF USED("cursor_4c_BuscaMoe")
1180:                     USE IN cursor_4c_BuscaMoe
1181:                 ENDIF
1182:             ENDIF
1183:         CATCH TO loc_oErro
1184:             MsgErro(loc_oErro.Message, "ValidarMoeda")
1185:         ENDTRY
1186:     ENDPROC
1187: 
1188:     *--------------------------------------------------------------------------
1189:     * FormParaBO - Transfere valores do Form para o BO
1190:     *--------------------------------------------------------------------------
1191:     PROTECTED PROCEDURE FormParaBO()
1192:         LOCAL loc_oPagina
1193:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1194:         IF PEMSTATUS(loc_oPagina, "txt_4c_CPros", 5)
1195:             THIS.this_oBusinessObject.this_cCPros    = ALLTRIM(loc_oPagina.txt_4c_CPros.Value)
1196:         ENDIF
1197:         IF PEMSTATUS(loc_oPagina, "txt_4c_Datas", 5)
1198:             THIS.this_oBusinessObject.this_dDatas    = loc_oPagina.txt_4c_Datas.Value
1199:         ENDIF
1200:         IF PEMSTATUS(loc_oPagina, "txt_4c_Moevs", 5)
1201:             THIS.this_oBusinessObject.this_cMoevs    = ALLTRIM(loc_oPagina.txt_4c_Moevs.Value)
1202:         ENDIF
1203:         IF PEMSTATUS(loc_oPagina, "txt_4c_MoevsAnt", 5)
1204:             THIS.this_oBusinessObject.this_cMoevsAnt = ALLTRIM(loc_oPagina.txt_4c_MoevsAnt.Value)
1205:         ENDIF
1206:         IF PEMSTATUS(loc_oPagina, "txt_4c_PVens", 5)
1207:             THIS.this_oBusinessObject.this_nPVens    = loc_oPagina.txt_4c_PVens.Value
1208:         ENDIF
1209:         IF PEMSTATUS(loc_oPagina, "txt_4c_PVensAnt", 5)
1210:             THIS.this_oBusinessObject.this_nPVensAnt = loc_oPagina.txt_4c_PVensAnt.Value
1211:         ENDIF
1212:         THIS.this_oBusinessObject.this_cUsuals = ALLTRIM(gc_4c_UsuarioLogado)
1213:         IF PEMSTATUS(loc_oPagina, "chk_4c_CKAtuSite", 5)
1214:             THIS.this_oBusinessObject.this_nCKAtuSite = IIF(loc_oPagina.chk_4c_CKAtuSite.Value, 1, 0)
1215:         ENDIF
1216:     ENDPROC
1217: 
1218:     *--------------------------------------------------------------------------
1219:     * BOParaForm - Transfere valores do BO para o Form
1220:     *--------------------------------------------------------------------------
1221:     PROTECTED PROCEDURE BOParaForm()
1222:         LOCAL loc_oPagina
1223:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1224:         IF PEMSTATUS(loc_oPagina, "txt_4c_CPros", 5)
1225:             loc_oPagina.txt_4c_CPros.Value    = THIS.this_oBusinessObject.this_cCPros
1226:         ENDIF
1227:         IF PEMSTATUS(loc_oPagina, "txt_4c_DPros", 5)
1228:             loc_oPagina.txt_4c_DPros.Value    = THIS.this_oBusinessObject.this_cDPros
1229:         ENDIF
1230:         IF PEMSTATUS(loc_oPagina, "txt_4c_Datas", 5)
1231:             loc_oPagina.txt_4c_Datas.Value    = THIS.this_oBusinessObject.this_dDatas
1232:         ENDIF
1233:         IF PEMSTATUS(loc_oPagina, "txt_4c_Moevs", 5)
1234:             loc_oPagina.txt_4c_Moevs.Value    = THIS.this_oBusinessObject.this_cMoevs
1235:         ENDIF
1236:         IF PEMSTATUS(loc_oPagina, "txt_4c_MoevsAnt", 5)
1237:             loc_oPagina.txt_4c_MoevsAnt.Value = THIS.this_oBusinessObject.this_cMoevsAnt
1238:         ENDIF
1239:         IF PEMSTATUS(loc_oPagina, "txt_4c_PVens", 5)
1240:             loc_oPagina.txt_4c_PVens.Value    = THIS.this_oBusinessObject.this_nPVens
1241:         ENDIF
1242:         IF PEMSTATUS(loc_oPagina, "txt_4c_PVensAnt", 5)
1243:             loc_oPagina.txt_4c_PVensAnt.Value = THIS.this_oBusinessObject.this_nPVensAnt
1244:         ENDIF
1245:         IF PEMSTATUS(loc_oPagina, "txt_4c_Usuals", 5)
1246:             loc_oPagina.txt_4c_Usuals.Value   = THIS.this_oBusinessObject.this_cUsuals
1247:         ENDIF
1248:         IF PEMSTATUS(loc_oPagina, "chk_4c_CKAtuSite", 5)
1249:             loc_oPagina.chk_4c_CKAtuSite.Value = (THIS.this_oBusinessObject.this_nCKAtuSite .Value = IIF(THIS.this_oBusinessObject.this_nCKAtuSite = 1, 1, 0))
1250:         ENDIF
1251:     ENDPROC
1252: 
1253:     *--------------------------------------------------------------------------
1254:     * HabilitarCampos - Habilita/desabilita campos da Page2 conforme modo
1255:     *--------------------------------------------------------------------------
1256:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1257:         LOCAL loc_oPagina
1258:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1259:         IF PEMSTATUS(loc_oPagina, "txt_4c_CPros", 5)
1260:             loc_oPagina.txt_4c_CPros.Enabled    = par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR"
1261:         ENDIF
1262:         IF PEMSTATUS(loc_oPagina, "txt_4c_Datas", 5)
1263:             loc_oPagina.txt_4c_Datas.Enabled    = par_lHabilitar
1264:         ENDIF
1265:         IF PEMSTATUS(loc_oPagina, "txt_4c_Moevs", 5)
1266:             loc_oPagina.txt_4c_Moevs.Enabled    = par_lHabilitar
1267:         ENDIF
1268:         IF PEMSTATUS(loc_oPagina, "txt_4c_MoevsAnt", 5)
1269:             loc_oPagina.txt_4c_MoevsAnt.Enabled = par_lHabilitar
1270:         ENDIF
1271:         IF PEMSTATUS(loc_oPagina, "txt_4c_PVens", 5)
1272:             loc_oPagina.txt_4c_PVens.Enabled    = par_lHabilitar
1273:         ENDIF
1274:         IF PEMSTATUS(loc_oPagina, "txt_4c_PVensAnt", 5)
1275:             loc_oPagina.txt_4c_PVensAnt.Enabled = par_lHabilitar
1276:         ENDIF
1277:         IF PEMSTATUS(loc_oPagina, "chk_4c_CKAtuSite", 5)
1278:             loc_oPagina.chk_4c_CKAtuSite.Enabled = par_lHabilitar
1279:         ENDIF
1280:         IF PEMSTATUS(loc_oPagina, "txt_4c_DPros", 5)
1281:             loc_oPagina.txt_4c_DPros.Enabled  = .F.
1282:         ENDIF
1283:         IF PEMSTATUS(loc_oPagina, "txt_4c_Usuals", 5)
1284:             loc_oPagina.txt_4c_Usuals.Enabled = .F.
1285:         ENDIF
1286:     ENDPROC
1287: 
1288:     *--------------------------------------------------------------------------
1289:     * LimparCampos - Limpa valores dos campos da Page2
1290:     *--------------------------------------------------------------------------
1291:     PROTECTED PROCEDURE LimparCampos()
1292:         LOCAL loc_oPagina
1293:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1294:         IF PEMSTATUS(loc_oPagina, "txt_4c_CPros", 5)
1295:             loc_oPagina.txt_4c_CPros.Value    = ""
1296:         ENDIF
1297:         IF PEMSTATUS(loc_oPagina, "txt_4c_DPros", 5)
1298:             loc_oPagina.txt_4c_DPros.Value    = ""
1299:         ENDIF
1300:         IF PEMSTATUS(loc_oPagina, "txt_4c_Datas", 5)
1301:             loc_oPagina.txt_4c_Datas.Value    = DATE()
1302:         ENDIF
1303:         IF PEMSTATUS(loc_oPagina, "txt_4c_Moevs", 5)
1304:             loc_oPagina.txt_4c_Moevs.Value    = ""
1305:         ENDIF
1306:         IF PEMSTATUS(loc_oPagina, "txt_4c_MoevsAnt", 5)
1307:             loc_oPagina.txt_4c_MoevsAnt.Value = ""
1308:         ENDIF
1309:         IF PEMSTATUS(loc_oPagina, "txt_4c_PVens", 5)
1310:             loc_oPagina.txt_4c_PVens.Value    = 0
1311:         ENDIF
1312:         IF PEMSTATUS(loc_oPagina, "txt_4c_PVensAnt", 5)
1313:             loc_oPagina.txt_4c_PVensAnt.Value = 0
1314:         ENDIF
1315:         IF PEMSTATUS(loc_oPagina, "txt_4c_Usuals", 5)
1316:             loc_oPagina.txt_4c_Usuals.Value   = ""
1317:         ENDIF
1318:         IF PEMSTATUS(loc_oPagina, "chk_4c_CKAtuSite", 5)
1319:             loc_oPagina.chk_4c_CKAtuSite.Value = 0
1320:         ENDIF
1321:     ENDPROC
1322: 
1323:     *--------------------------------------------------------------------------
1324:     * ValidarCampos - Valida campos obrigatorios antes de salvar
1325:     *--------------------------------------------------------------------------
1326:     PROTECTED PROCEDURE ValidarCampos()
1327:         LOCAL loc_oPagina, loc_lValido
1328:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1329:         loc_lValido = .T.
1330: 
1331:         IF PEMSTATUS(loc_oPagina, "txt_4c_CPros", 5)
1332:             IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_CPros.Value))
1333:                 MsgAviso("Informe o c" + CHR(243) + "digo do produto.", "Valida" + CHR(231) + CHR(227) + "o")
1334:                 loc_oPagina.txt_4c_CPros.SetFocus()
1335:                 loc_lValido = .F.
1336:             ENDIF
1337:         ENDIF
1338: 
1339:         IF loc_lValido AND PEMSTATUS(loc_oPagina, "txt_4c_Moevs", 5)
1340:             IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Moevs.Value))
1341:                 MsgAviso("Informe a moeda.", "Valida" + CHR(231) + CHR(227) + "o")
1342:                 loc_oPagina.txt_4c_Moevs.SetFocus()
1343:                 loc_lValido = .F.
1344:             ENDIF
1345:         ENDIF
1346: 
1347:         RETURN loc_lValido
1348:     ENDPROC
1349: 
1350:     *--------------------------------------------------------------------------
1351:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1352:     *--------------------------------------------------------------------------
1353:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1354:         LOCAL loc_nI, loc_oObjeto, loc_nP
1355: 
1356:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1357:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1358: 
1359:             IF VARTYPE(loc_oObjeto) = "O"
1360:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1361:                     loc_oObjeto.Visible = .T.
1362:                 ENDIF
1363: 
1364:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1365:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1366:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1367:                     ENDFOR
1368:                 ENDIF
1369: 
1370:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
1371:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1372:                 ENDIF
1373:             ENDIF
1374:         ENDFOR
1375:     ENDPROC
1376: 
1377:     *--------------------------------------------------------------------------
1378:     * FormatarGridLista - Formata visual do grid da lista
1379:     *--------------------------------------------------------------------------
1380:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1381:         WITH par_oGrid
1382:             .FontName = "Tahoma"
1383:             .FontSize = 8
1384:         ENDWITH
1385:     ENDPROC
1386: 
1387:     *--------------------------------------------------------------------------
1388:     * CProsKeyPress - Handler KeyPress para campo CPros na Page2 (F4 abre lookup)
1389:     *--------------------------------------------------------------------------
1390:     PROCEDURE CProsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1391:         IF par_nKeyCode = 28  && F4
1392:             THIS.ValidarCPros()
1393:         ENDIF
1394:     ENDPROC
1395: 
1396:     *--------------------------------------------------------------------------
1397:     * CProsDblClick - Handler DblClick para campo CPros na Page2
1398:     *--------------------------------------------------------------------------
1399:     PROCEDURE CProsDblClick()
1400:         THIS.ValidarCPros()
1401:     ENDPROC
1402: 
1403:     *--------------------------------------------------------------------------
1404:     * MoevsKeyPress - Handler KeyPress para campo Moevs na Page2 (F4 abre lookup)
1405:     *--------------------------------------------------------------------------
1406:     PROCEDURE MoevsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1407:         IF par_nKeyCode = 28  && F4
1408:             THIS.ValidarMoeda()
1409:         ENDIF
1410:     ENDPROC
1411: 
1412:     *--------------------------------------------------------------------------
1413:     * MoevsDblClick - Handler DblClick para campo Moevs na Page2
1414:     *--------------------------------------------------------------------------
1415:     PROCEDURE MoevsDblClick()
1416:         THIS.ValidarMoeda()
1417:     ENDPROC
1418: 
1419:     *--------------------------------------------------------------------------
1420:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
1421:     *--------------------------------------------------------------------------
1422:     PROCEDURE AjustarBotoesPorModo()
1423:         LOCAL loc_oPagina, loc_oCnt, loc_lEmEdicao
1424:         TRY
1425:             loc_lEmEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "VISUALIZAR")
1426:             loc_oPagina   = THIS.pgf_4c_Paginas.Page1
1427: 
1428:             IF PEMSTATUS(loc_oPagina, "cnt_4c_Botoes", 5)
1429:                 loc_oCnt = loc_oPagina.cnt_4c_Botoes
1430:                 IF PEMSTATUS(loc_oCnt, "cmd_4c_Incluir", 5)
1431:                     loc_oCnt.cmd_4c_Incluir.Enabled    = !loc_lEmEdicao
1432:                 ENDIF
1433:                 IF PEMSTATUS(loc_oCnt, "cmd_4c_Visualizar", 5)
1434:                     loc_oCnt.cmd_4c_Visualizar.Enabled = !loc_lEmEdicao
1435:                 ENDIF
1436:                 IF PEMSTATUS(loc_oCnt, "cmd_4c_Alterar", 5)
1437:                     loc_oCnt.cmd_4c_Alterar.Enabled    = !loc_lEmEdicao
1438:                 ENDIF
1439:                 IF PEMSTATUS(loc_oCnt, "cmd_4c_Excluir", 5)
1440:                     loc_oCnt.cmd_4c_Excluir.Enabled    = !loc_lEmEdicao
1441:                 ENDIF
1442:                 IF PEMSTATUS(loc_oCnt, "cmd_4c_Buscar", 5)
1443:                     loc_oCnt.cmd_4c_Buscar.Enabled     = !loc_lEmEdicao
1444:                 ENDIF
1445:             ENDIF
1446: 
1447:             IF PEMSTATUS(loc_oPagina, "cnt_4c_Saida", 5)
1448:                 IF PEMSTATUS(loc_oPagina.cnt_4c_Saida, "cmd_4c_Encerrar", 5)
1449:                     loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar.Enabled = !loc_lEmEdicao
1450:                 ENDIF
1451:             ENDIF
1452: 
1453:             IF THIS.pgf_4c_Paginas.PageCount >= 2
1454:                 loc_oPagina = THIS.pgf_4c_Paginas.Page2
1455:                 IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
1456:                     loc_oCnt = loc_oPagina.cnt_4c_BotoesAcao
1457:                     IF PEMSTATUS(loc_oCnt, "cmd_4c_Confirmar", 5)
1458:                         loc_oCnt.cmd_4c_Confirmar.Enabled = (THIS.this_cModoAtual != "VISUALIZAR")
1459:                     ENDIF
1460:                     IF PEMSTATUS(loc_oCnt, "cmd_4c_Cancelar", 5)
1461:                         loc_oCnt.cmd_4c_Cancelar.Enabled = loc_lEmEdicao
1462:                     ENDIF

*-- Linhas 1470 a 1480:
1470:     *--------------------------------------------------------------------------
1471:     * Destroy
1472:     *--------------------------------------------------------------------------
1473:     PROCEDURE Destroy()
1474:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1475:             THIS.this_oBusinessObject = .NULL.
1476:         ENDIF
1477:         DODEFAULT()
1478:     ENDPROC
1479: 
1480: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprpreBO.prg):
*=============================================================================
* sigprpreBO.prg - Business Object para Alteracao de Precos
* Herda de: BusinessBase
* Tabela: sigprpre (PK: cidchaves)
* Campos: cidchaves, cpros, datas, moevs, moevsant, pvens, pvensant,
*         usuals, ckatusite
* JOIN display: dpros, cgrus (de SigCdPro)
*=============================================================================

DEFINE CLASS sigprpreBO AS BusinessBase

    *-- Campos da tabela sigprpre
    this_cCidChaves  = ""   && cidchaves char(20) NOT NULL - PK
    this_cCPros      = ""   && cpros char(14) NOT NULL - Codigo do produto
    this_dDatas      = {}   && datas datetime NULL - Data da alteracao
    this_cMoevs      = ""   && moevs char(3) NOT NULL - Moeda atual
    this_cMoevsAnt   = ""   && moevsant char(3) NOT NULL - Moeda anterior
    this_nPVens      = 0    && pvens numeric(11,5) NOT NULL - Preco de venda atual
    this_nPVensAnt   = 0    && pvensant numeric(11,5) NOT NULL - Preco de venda anterior
    this_cUsuals     = ""   && usuals nvarchar(20) NULL - Usuario
    this_nCKAtuSite  = 0    && ckatusite numeric(1,0) NOT NULL - Flag atualizacao site

    *-- Campos auxiliares de exibicao (JOIN com SigCdPro)
    this_cDPros      = ""   && dpros - Descricao do produto
    this_cCGrus      = ""   && cgrus - Codigo do grupo do produto

    *-- Filtros de consulta (usados em Buscar)
    this_dDataInicio = {}   && Data de inicio do periodo
    this_dDataFim    = {}   && Data de fim do periodo
    this_cFiltroCPro = ""   && Filtro por codigo de produto
    this_cFiltroGru  = ""   && Filtro por codigo de grupo

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigprpre"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave para registro de auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
            THIS.this_cCPros      = TratarNulo(cpros,      "C")
            THIS.this_dDatas      = TratarNulo(datas,      "D")
            THIS.this_cMoevs      = TratarNulo(moevs,      "C")
            THIS.this_cMoevsAnt   = TratarNulo(moevsant,   "C")
            THIS.this_nPVens      = TratarNulo(pvens,      "N")
            THIS.this_nPVensAnt   = TratarNulo(pvensant,   "N")
            THIS.this_cUsuals     = TratarNulo(usuals,     "C")
            THIS.this_nCKAtuSite  = TratarNulo(ckatusite,  "N")
            IF TYPE("dpros") != "U"
                THIS.this_cDPros  = TratarNulo(dpros,      "C")
            ENDIF
            IF TYPE("cgrus") != "U"
                THIS.this_cCGrus  = TratarNulo(cgrus,      "C")
            ENDIF
            loc_lResultado = .T.
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT com filtros de periodo, produto e grupo
    * Cursor resultante: crSigPrPre (nome legado preservado para binding do grid)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_cDataIni, loc_cDataFim
        LOCAL loc_cProdF, loc_cGruF, loc_oErro
        loc_lResultado = .F.
        TRY
            *-- Calcular limites para filtros "entre" (padrao do legado)
            IF EMPTY(THIS.this_cFiltroCPro)
                loc_cProdF = "zzzzzzzzzzzzzz"
            ELSE
                loc_cProdF = ALLTRIM(THIS.this_cFiltroCPro)
            ENDIF
            IF EMPTY(THIS.this_cFiltroGru)
                loc_cGruF = "zzz"
            ELSE
                loc_cGruF = ALLTRIM(THIS.this_cFiltroGru)
            ENDIF

            *-- Formatar datas
            IF EMPTY(THIS.this_dDataInicio)
                loc_cDataIni = FormatarDataSQL(DATE())
            ELSE
                loc_cDataIni = FormatarDataSQL(THIS.this_dDataInicio)
            ENDIF
            IF EMPTY(THIS.this_dDataFim)
                loc_cDataFim = "'" + LEFT(DTOS(DATE()), 4) + "-" + SUBSTR(DTOS(DATE()),5,2) + "-" + RIGHT(DTOS(DATE()),2) + " 23:59:59'"
            ELSE
                loc_cDataFim = "'" + LEFT(DTOS(THIS.this_dDataFim), 4) + "-" + SUBSTR(DTOS(THIS.this_dDataFim),5,2) + "-" + RIGHT(DTOS(THIS.this_dDataFim),2) + " 23:59:59'"
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.cpros, a.datas, a.moevs, a.moevsant," + ;
                       " a.pvens, a.pvensant, a.usuals, a.ckatusite," + ;
                       " b.dpros, b.cgrus" + ;
                       " FROM sigprpre a" + ;
                       " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                       " WHERE a.datas BETWEEN " + loc_cDataIni + " AND " + loc_cDataFim + ;
                       " AND a.cpros BETWEEN " + EscaparSQL(ALLTRIM(THIS.this_cFiltroCPro)) + ;
                       " AND " + EscaparSQL(loc_cProdF) + ;
                       " AND b.cgrus BETWEEN " + EscaparSQL(ALLTRIM(THIS.this_cFiltroGru)) + ;
                       " AND " + EscaparSQL(loc_cGruF) + ;
                       " ORDER BY a.datas DESC, a.cpros"

            IF USED("crSigPrPre")
                USE IN crSigPrPre
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigPrPre") > 0
                IF USED("crSigPrPre")
                    SELECT crSigPrPre
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar altera" + CHR(231) + CHR(245) + "es de pre" + CHR(231) + "o."
                MsgErro(CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo cidchaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT a.cidchaves, a.cpros, a.datas, a.moevs, a.moevsant," + ;
                       " a.pvens, a.pvensant, a.usuals, a.ckatusite," + ;
                       " b.dpros, b.cgrus" + ;
                       " FROM sigprpre a" + ;
                       " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(ALLTRIM(par_cCidChaves))

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega") > 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    THIS.this_cMensagemErro = "Registro n" + CHR(227) + "o encontrado."
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar registro."
                MsgErro(CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO sigprpre
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro, loc_cChaveNova
        loc_lResultado = .F.
        TRY
            *-- Gerar chave unica para cidchaves (char 20)
            IF SQLEXEC(gnConnHandle, "SELECT CAST(NEWID() AS CHAR(36)) AS nid", "cursor_4c_NewId") > 0
                SELECT cursor_4c_NewId
                loc_cChaveNova = LEFT(ALLTRIM(nid), 20)
                USE IN cursor_4c_NewId
            ELSE
                loc_cChaveNova = LEFT(SYS(2015) + SYS(2015) + SYS(2015), 20)
            ENDIF
            THIS.this_cCidChaves = loc_cChaveNova

            loc_cSQL = "INSERT INTO sigprpre" + ;
                       " (cidchaves, cpros, datas, moevs, moevsant, pvens, pvensant, usuals, ckatusite)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cCPros)     + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       EscaparSQL(THIS.this_cMoevs)     + ", " + ;
                       EscaparSQL(THIS.this_cMoevsAnt)  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPVens)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPVensAnt) + ", " + ;
                       EscaparSQL(THIS.this_cUsuals)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCKAtuSite) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir altera" + CHR(231) + CHR(227) + "o de pre" + CHR(231) + "o."
                MsgErro(CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE sigprpre
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cSQL = "UPDATE sigprpre SET" + ;
                       " cpros    = " + EscaparSQL(THIS.this_cCPros)          + ", " + ;
                       " datas    = " + FormatarDataSQL(THIS.this_dDatas)     + ", " + ;
                       " moevs    = " + EscaparSQL(THIS.this_cMoevs)          + ", " + ;
                       " moevsant = " + EscaparSQL(THIS.this_cMoevsAnt)       + ", " + ;
                       " pvens    = " + FormatarNumeroSQL(THIS.this_nPVens)   + ", " + ;
                       " pvensant = " + FormatarNumeroSQL(THIS.this_nPVensAnt)+ ", " + ;
                       " usuals   = " + EscaparSQL(THIS.this_cUsuals)         + ", " + ;
                       " ckatusite= " + FormatarNumeroSQL(THIS.this_nCKAtuSite) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar altera" + CHR(231) + CHR(227) + "o de pre" + CHR(231) + "o."
                MsgErro(CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE FROM sigprpre
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM sigprpre WHERE cidchaves = " + ;
                       EscaparSQL(THIS.this_cCidChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir altera" + CHR(231) + CHR(227) + "o de pre" + CHR(231) + "o."
                MsgErro(CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

