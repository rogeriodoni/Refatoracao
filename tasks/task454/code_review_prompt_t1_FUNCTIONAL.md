# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (5)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_BOTOESACAO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [CONTAINER-TOGGLE] Container 'CNT_4C_COPIAMES' eh flutuante (Visible=.F. toggled por botao) mas TornarControlesVisiveis NAO o filtra. Adicionar verificacao INLIST/IF para pular este container no loop.
- [BINDEVENT-PARAMS] Handler 'ValidarCodCli' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarCodCli(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDesCli' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDesCli(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarCodCgo' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarCodCgo(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormJrn.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2089 linhas total):

*-- Linhas 34 a 170:
34:     this_cMesAtual = ""
35: 
36:     *==========================================================================
37:     * Init - FormBase.Init() ja chama InicializarForm() automaticamente
38:     *==========================================================================
39:     PROCEDURE Init()
40:         RETURN DODEFAULT()
41:     ENDPROC
42: 
43:     *==========================================================================
44:     * InicializarForm - Configura estrutura completa (chamado por FormBase)
45:     *==========================================================================
46:     PROTECTED PROCEDURE InicializarForm()
47:         LOCAL loc_lSucesso
48:         loc_lSucesso = .F.
49: 
50:         TRY
51:             THIS.this_oBusinessObject = CREATEOBJECT("JrnBO")
52: 
53:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
54:                 THIS.ConfigurarPageFrame()
55: 
56:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
57:                     THIS.CarregarLista()
58:                 ENDIF
59: 
60:                 THIS.pgf_4c_Paginas.Visible = .T.
61:                 THIS.pgf_4c_Paginas.ActivePage = 1
62:                 THIS.this_cModoAtual = "LISTA"
63:                 loc_lSucesso = .T.
64:             ELSE
65:                 MsgErro("Erro ao criar JrnBO." + CHR(13) + ;
66:                         "VARTYPE: " + VARTYPE(THIS.this_oBusinessObject), ;
67:                         "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
68:             ENDIF
69:         CATCH TO loc_oErro
70:             MsgErro("Erro em FormJrn.InicializarForm:" + CHR(13) + ;
71:                     loc_oErro.Message + CHR(13) + ;
72:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
73:         ENDTRY
74: 
75:         RETURN loc_lSucesso
76:     ENDPROC
77: 
78:     *==========================================================================
79:     * ConfigurarPageFrame - PageFrame Top=-29 oculta abas (compensar +29 no Top)
80:     *==========================================================================
81:     PROTECTED PROCEDURE ConfigurarPageFrame()
82:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
83: 
84:         WITH THIS.pgf_4c_Paginas
85:             .PageCount  = 2
86:             .Top        = -29
87:             .Left       = 0
88:             .Width      = THIS.Width
89:             .Height     = THIS.Height + 29
90:             .Tabs       = .F.
91:             .TabStretch = 1
92:             .Visible    = .T.
93:         ENDWITH
94: 
95:         WITH THIS.pgf_4c_Paginas.Page1
96:             .Caption   = "Lista"
97:             .BackColor = RGB(255, 255, 255)
98:         ENDWITH
99: 
100:         WITH THIS.pgf_4c_Paginas.Page2
101:             .Caption   = "Dados"
102:             .BackColor = RGB(255, 255, 255)
103:         ENDWITH
104: 
105:         THIS.ConfigurarPaginaLista()
106:         THIS.ConfigurarPaginaDados()
107:     ENDPROC
108: 
109:     *==========================================================================
110:     * ConfigurarPaginaLista - Page1 com cabecalho, botoes CRUD e Grid
111:     *
112:     * Referencia legado (SIGCDJRN 834px):
113:     *   cntSombra   : Top=1,  Left=-1, Width=840, Height=80
114:     *   Grupo_Op    : Top=-1, Left=375 (Width~390)  -> canonico Left=542
115:     *   Grupo_Saida : Top=-1, Left=750               -> canonico Left=917
116:     *   Command1    : Top=4,  Left=305 ("Copia Mes") -> Left=462 (proporcional)
117:     *   Grade       : Top=96, Left=32, Width=783, Height=470
118:     * Compensacao PageFrame (+29): grade.Top = 96+29 = 125
119:     *==========================================================================
120:     PROTECTED PROCEDURE ConfigurarPaginaLista()
121:         LOCAL loc_oPagina, loc_oGrid
122:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
123: 
124:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
125: 
126:         *-- Cabecalho cinza (cntSombra.Top=1 -> 1+29=30)
127:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
128:         WITH loc_oPagina.cnt_4c_Cabecalho
129:             .Top         = 30
130:             .Left        = 0
131:             .Width       = THIS.Width
132:             .Height      = 80
133:             .BackColor   = RGB(100, 100, 100)
134:             .BorderWidth = 0
135:             .Visible     = .T.
136:         ENDWITH
137: 
138:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
139:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
140:             .Caption   = "Jornadas de Trabalho"
141:             .Top       = 15
142:             .Left      = 11
143:             .Width     = THIS.Width - 20
144:             .Height    = 40
145:             .FontName  = "Tahoma"
146:             .FontSize  = 16
147:             .FontBold  = .T.
148:             .ForeColor = RGB(0, 0, 0)
149:             .BackStyle = 0
150:             .AutoSize  = .F.
151:             .Visible   = .T.
152:         ENDWITH
153: 
154:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
155:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
156:             .Caption   = "Jornadas de Trabalho"
157:             .Top       = 18
158:             .Left      = 10
159:             .Width     = THIS.Width - 20
160:             .Height    = 46
161:             .FontName  = "Tahoma"
162:             .FontSize  = 16
163:             .FontBold  = .T.
164:             .ForeColor = RGB(255, 255, 255)
165:             .BackStyle = 0
166:             .AutoSize  = .F.
167:             .Visible   = .T.
168:         ENDWITH
169: 
170:         *----------------------------------------------------------------------

*-- Linhas 205 a 416:
205:             .AutoSize        = .F.
206:             .Visible         = .T.
207:         ENDWITH
208:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
209: 
210:         *-- Visualizar (Consultar.Left=80)
211:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
212:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
213:             .Caption         = "Visualizar"
214:             .Top             = 5
215:             .Left            = 80
216:             .Width           = 75
217:             .Height          = 75
218:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
219:             .PicturePosition = 13
220:             .FontName        = "Comic Sans MS"
221:             .FontSize        = 8
222:             .FontBold        = .T.
223:             .FontItalic      = .T.
224:             .ForeColor       = RGB(90, 90, 90)
225:             .BackColor       = RGB(255, 255, 255)
226:             .Themes          = .F.
227:             .SpecialEffect   = 0
228:             .MousePointer    = 15
229:             .WordWrap        = .T.
230:             .AutoSize        = .F.
231:             .Visible         = .T.
232:         ENDWITH
233:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
234: 
235:         *-- Alterar (Left=155)
236:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
237:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
238:             .Caption         = "Alterar"
239:             .Top             = 5
240:             .Left            = 155
241:             .Width           = 75
242:             .Height          = 75
243:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
244:             .PicturePosition = 13
245:             .FontName        = "Comic Sans MS"
246:             .FontSize        = 8
247:             .FontBold        = .T.
248:             .FontItalic      = .T.
249:             .ForeColor       = RGB(90, 90, 90)
250:             .BackColor       = RGB(255, 255, 255)
251:             .Themes          = .F.
252:             .SpecialEffect   = 0
253:             .MousePointer    = 15
254:             .WordWrap        = .T.
255:             .AutoSize        = .F.
256:             .Visible         = .T.
257:         ENDWITH
258:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
259: 
260:         *-- Excluir (Left=230)
261:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
262:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
263:             .Caption         = "Excluir"
264:             .Top             = 5
265:             .Left            = 230
266:             .Width           = 75
267:             .Height          = 75
268:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
269:             .PicturePosition = 13
270:             .FontName        = "Comic Sans MS"
271:             .FontSize        = 8
272:             .FontBold        = .T.
273:             .FontItalic      = .T.
274:             .ForeColor       = RGB(90, 90, 90)
275:             .BackColor       = RGB(255, 255, 255)
276:             .Themes          = .F.
277:             .SpecialEffect   = 0
278:             .MousePointer    = 15
279:             .WordWrap        = .T.
280:             .AutoSize        = .F.
281:             .Visible         = .T.
282:         ENDWITH
283:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
284: 
285:         *-- Buscar (Procurar.Left=305)
286:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
287:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
288:             .Caption         = "Buscar"
289:             .Top             = 5
290:             .Left            = 305
291:             .Width           = 75
292:             .Height          = 75
293:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
294:             .PicturePosition = 13
295:             .FontName        = "Comic Sans MS"
296:             .FontSize        = 8
297:             .FontBold        = .T.
298:             .FontItalic      = .T.
299:             .ForeColor       = RGB(90, 90, 90)
300:             .BackColor       = RGB(255, 255, 255)
301:             .Themes          = .F.
302:             .SpecialEffect   = 0
303:             .MousePointer    = 15
304:             .WordWrap        = .T.
305:             .AutoSize        = .F.
306:             .Visible         = .T.
307:         ENDWITH
308:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
309: 
310:         *----------------------------------------------------------------------
311:         * Container saida - padrao canonico CLAUDE.md #10
312:         * Grupo_Saida.Left=750, Top=-1 -> canonico Left=917, Top=28
313:         *----------------------------------------------------------------------
314:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
315:         WITH loc_oPagina.cnt_4c_Saida
316:             .Top         = 28
317:             .Left        = 917
318:             .Width       = 90
319:             .Height      = 85
320:             .BackStyle   = 0
321:             .BorderWidth = 0
322:             .Visible     = .T.
323:         ENDWITH
324: 
325:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
326:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
327:             .Caption         = "Encerrar"
328:             .Top             = 5
329:             .Left            = 5
330:             .Width           = 75
331:             .Height          = 75
332:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
333:             .PicturePosition = 13
334:             .FontName        = "Comic Sans MS"
335:             .FontSize        = 8
336:             .FontBold        = .T.
337:             .FontItalic      = .T.
338:             .ForeColor       = RGB(90, 90, 90)
339:             .BackColor       = RGB(255, 255, 255)
340:             .Themes          = .F.
341:             .SpecialEffect   = 0
342:             .MousePointer    = 15
343:             .WordWrap        = .T.
344:             .AutoSize        = .F.
345:             .Visible         = .T.
346:         ENDWITH
347:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
348: 
349:         *----------------------------------------------------------------------
350:         * Botao "Copia Mes" (Command1 standalone no legado)
351:         * Original: Top=4, Left=305 em form 834px
352:         * Novo:     Top=4+29=33, Left proporcional ~462 (a esquerda de 542)
353:         *----------------------------------------------------------------------
354:         loc_oPagina.AddObject("cmd_4c_CopiarMes", "CommandButton")
355:         WITH loc_oPagina.cmd_4c_CopiarMes
356:             .Caption         = "Copia M" + CHR(234) + "s"
357:             .Top             = 33
358:             .Left            = 462
359:             .Width           = 75
360:             .Height          = 75
361:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
362:             .PicturePosition = 13
363:             .FontName        = "Comic Sans MS"
364:             .FontSize        = 8
365:             .FontBold        = .T.
366:             .FontItalic      = .T.
367:             .ForeColor       = RGB(90, 90, 90)
368:             .BackColor       = RGB(255, 255, 255)
369:             .Themes          = .F.
370:             .SpecialEffect   = 0
371:             .MousePointer    = 15
372:             .WordWrap        = .T.
373:             .AutoSize        = .F.
374:             .Visible         = .T.
375:         ENDWITH
376:         BINDEVENT(loc_oPagina.cmd_4c_CopiarMes, "Click", THIS, "BtnCopiarMesClick")
377: 
378:         *----------------------------------------------------------------------
379:         * Grid (Grade no legado: Top=96, Left=32, Width=783, Height=470)
380:         * Novo: Top=96+29=125, Left=32, Width=880 (ate cnt_4c_Saida.Left=917)
381:         * 14 colunas: iclis, cargos, refers, hora01-04, cDom-cSab
382:         *
383:         * ColumnCount FORA do WITH (Problema 36: nao criar colunas dentro de WITH)
384:         * ControlSource redefinido em CarregarLista apos RecordSource (Problema 48)
385:         *----------------------------------------------------------------------
386:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
387:         loc_oGrid = loc_oPagina.grd_4c_Lista
388: 
389:         loc_oGrid.ColumnCount = 14
390: 
391:         WITH loc_oGrid
392:             .Top                = 125
393:             .Left               = 32
394:             .Width              = 880
395:             .Height             = 470
396:             .FontName           = "Verdana"
397:             .FontSize           = 8
398:             .ForeColor          = RGB(90, 90, 90)
399:             .BackColor          = RGB(255, 255, 255)
400:             .GridLineColor      = RGB(238, 238, 238)
401:             .HighlightBackColor = RGB(255, 255, 255)
402:             .HighlightForeColor = RGB(15, 41, 104)
403:             .HighlightStyle     = 2
404:             .DeleteMark         = .F.
405:             .RecordMark         = .F.
406:             .RowHeight          = 16
407:             .ScrollBars         = 2
408:             .GridLines          = 3
409:             .Visible            = .T.
410: 
411:             .Column1.Width           = 80
412:             .Column1.Alignment       = 0
413:             .Column1.Header1.Caption = "Funcion" + CHR(225) + "rio"
414: 
415:             .Column2.Width           = 80
416:             .Column2.Alignment       = 0

*-- Linhas 468 a 671:
468:         *----------------------------------------------------------------------
469:         * Painel flutuante "Copiar Jornada do Mes" (Problema 26: iniciar oculto)
470:         * Original cntCopiaMes: Top=233, Left=280, Width=273, Height=136
471:         * Com compensacao PageFrame +29: Top=262
472:         *----------------------------------------------------------------------
473:         loc_oPagina.AddObject("cnt_4c_CopiaMes", "Container")
474:         WITH loc_oPagina.cnt_4c_CopiaMes
475:             .Top         = 262
476:             .Left        = 280
477:             .Width       = 273
478:             .Height      = 136
479:             .BackStyle   = 1
480:             .BackColor   = RGB(240, 240, 240)
481:             .BorderColor = RGB(100, 100, 100)
482:             .Visible     = .F.
483:         ENDWITH
484: 
485:         loc_oPagina.cnt_4c_CopiaMes.AddObject("shp_4c_HeaderCopia", "Shape")
486:         WITH loc_oPagina.cnt_4c_CopiaMes.shp_4c_HeaderCopia
487:             .Top         = 0
488:             .Left        = 0
489:             .Width       = 274
490:             .Height      = 25
491:             .BackStyle   = 1
492:             .BackColor   = RGB(53, 53, 53)
493:             .BorderStyle = 0
494:             .Visible     = .T.
495:         ENDWITH
496: 
497:         loc_oPagina.cnt_4c_CopiaMes.AddObject("lbl_4c_TituloCopiaMes", "Label")
498:         WITH loc_oPagina.cnt_4c_CopiaMes.lbl_4c_TituloCopiaMes
499:             .Caption   = "  Copiar Jornada do M" + CHR(234) + "s"
500:             .Top       = 4
501:             .Left      = 2
502:             .Width     = 197
503:             .Height    = 21
504:             .FontName  = "Tahoma"
505:             .FontSize  = 8
506:             .FontBold  = .T.
507:             .ForeColor = RGB(255, 255, 255)
508:             .BackStyle = 0
509:             .AutoSize  = .F.
510:             .Visible   = .T.
511:         ENDWITH
512: 
513:         loc_oPagina.cnt_4c_CopiaMes.AddObject("lbl_4c_De", "Label")
514:         WITH loc_oPagina.cnt_4c_CopiaMes.lbl_4c_De
515:             .Caption   = "De :"
516:             .Top       = 57
517:             .Left      = 44
518:             .Height    = 15
519:             .Width     = 25
520:             .FontName  = "Tahoma"
521:             .FontSize  = 8
522:             .BackStyle = 0
523:             .ForeColor = RGB(0, 0, 0)
524:             .AutoSize  = .F.
525:             .Visible   = .T.
526:         ENDWITH
527: 
528:         loc_oPagina.cnt_4c_CopiaMes.AddObject("cbo_4c_De", "ComboBox")
529:         WITH loc_oPagina.cnt_4c_CopiaMes.cbo_4c_De
530:             .Top           = 53
531:             .Left          = 71
532:             .Width         = 100
533:             .Height        = 24
534:             .ColumnCount   = 2
535:             .ColumnWidths  = "95,0"
536:             .BoundColumn   = 2
537:             .RowSourceType = 1
538:             .RowSource     = ""
539:             .Style         = 2
540:             .FontName      = "Tahoma"
541:             .FontSize      = 8
542:             .Visible       = .T.
543:         ENDWITH
544: 
545:         loc_oPagina.cnt_4c_CopiaMes.AddObject("lbl_4c_Para", "Label")
546:         WITH loc_oPagina.cnt_4c_CopiaMes.lbl_4c_Para
547:             .Caption   = "Para :"
548:             .Top       = 87
549:             .Left      = 31
550:             .Height    = 15
551:             .Width     = 35
552:             .FontName  = "Tahoma"
553:             .FontSize  = 8
554:             .BackStyle = 0
555:             .ForeColor = RGB(0, 0, 0)
556:             .AutoSize  = .F.
557:             .Visible   = .T.
558:         ENDWITH
559: 
560:         loc_oPagina.cnt_4c_CopiaMes.AddObject("cbo_4c_Para", "ComboBox")
561:         WITH loc_oPagina.cnt_4c_CopiaMes.cbo_4c_Para
562:             .Top           = 82
563:             .Left          = 71
564:             .Width         = 100
565:             .Height        = 24
566:             .ColumnCount   = 2
567:             .ColumnWidths  = "95,0"
568:             .BoundColumn   = 2
569:             .RowSourceType = 1
570:             .RowSource     = ""
571:             .Style         = 2
572:             .FontName      = "Tahoma"
573:             .FontSize      = 8
574:             .Visible       = .T.
575:         ENDWITH
576: 
577:         *-- Botao Confirmar (Command2 no legado: Top=39, Left=213, Width=40, Height=40)
578:         loc_oPagina.cnt_4c_CopiaMes.AddObject("cmd_4c_CopiarMesOK", "CommandButton")
579:         WITH loc_oPagina.cnt_4c_CopiaMes.cmd_4c_CopiarMesOK
580:             .Caption       = "OK"
581:             .Top           = 39
582:             .Left          = 213
583:             .Width         = 40
584:             .Height        = 40
585:             .FontName      = "Tahoma"
586:             .FontSize      = 8
587:             .FontBold      = .T.
588:             .ForeColor     = RGB(0, 100, 0)
589:             .BackColor     = RGB(255, 255, 255)
590:             .Themes        = .F.
591:             .SpecialEffect = 0
592:             .Visible       = .T.
593:         ENDWITH
594:         BINDEVENT(loc_oPagina.cnt_4c_CopiaMes.cmd_4c_CopiarMesOK, "Click", THIS, "CopiaMesConfirmarClick")
595: 
596:         *-- Botao Cancelar (Command1 no legado: Top=80, Left=213, Width=40, Height=40)
597:         loc_oPagina.cnt_4c_CopiaMes.AddObject("cmd_4c_CopiarMesX", "CommandButton")
598:         WITH loc_oPagina.cnt_4c_CopiaMes.cmd_4c_CopiarMesX
599:             .Caption       = "X"
600:             .Top           = 80
601:             .Left          = 213
602:             .Width         = 40
603:             .Height        = 40
604:             .FontName      = "Tahoma"
605:             .FontSize      = 8
606:             .FontBold      = .T.
607:             .ForeColor     = RGB(180, 0, 0)
608:             .BackColor     = RGB(255, 255, 255)
609:             .Themes        = .F.
610:             .SpecialEffect = 0
611:             .Visible       = .T.
612:         ENDWITH
613:         BINDEVENT(loc_oPagina.cnt_4c_CopiaMes.cmd_4c_CopiarMesX, "Click", THIS, "CopiaMesCancelarClick")
614: 
615:         THIS.TornarControlesVisiveis(loc_oPagina)
616:     ENDPROC
617: 
618:     *==========================================================================
619:     * ConfigurarPaginaDados - Page2 completa com todos os campos
620:     *
621:     * Referencia legado (834px, sem compensacao +29):
622:     *   Grupo_Salva : Left=635, Top=13  -> novo: Left=760, Top=42 (13+29)
623:     *   getCodCli   : Left=148, Top=163 -> Top=192 (+29)
624:     *   getDesCli   : Left=232, Top=163 -> Top=192 (+29), Width=360
625:     *   getCodCgo   : Left=148, Top=189 -> Top=218 (+29)
626:     *   cboMes/Ano  : Left=148/232, Top=136 -> Top=165 (+29)
627:     *   getHora01-04: Top=246 -> Top=275 (+29)
628:     *   checkboxes  : Top=295/318 -> Top=324/347 (+29)
629:     *   Shape(dias) : Top=287  -> Top=316 (+29), Width=433, Height=57
630:     *==========================================================================
631:     PROTECTED PROCEDURE ConfigurarPaginaDados()
632:         LOCAL loc_oPagina, loc_cAnos, loc_n, loc_cRowMes
633:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
634:         loc_cAnos   = ""
635:         loc_cRowMes = "Janeiro,01,Fevereiro,02,Mar" + CHR(231) + "o,03,Abril,04,Maio,05," + ;
636:                       "Junho,06,Julho,07,Agosto,08,Setembro,09,Outubro,10," + ;
637:                       "Novembro,11,Dezembro,12"
638: 
639:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
640: 
641:         *-- Anos: lista dinamica (ano-5 ate ano+5)
642:         FOR loc_n = YEAR(DATE()) - 5 TO YEAR(DATE()) + 5
643:             IF !EMPTY(loc_cAnos)
644:                 loc_cAnos = loc_cAnos + ","
645:             ENDIF
646:             loc_cAnos = loc_cAnos + STR(loc_n, 4)
647:         ENDFOR
648: 
649:         *----------------------------------------------------------------------
650:         * Container botoes acao (Grupo_Salva: Left=635->760, Top=13->42)
651:         * Confirmar.Left=5, Cancelar.Left=85, ambos Width=75, Height=75
652:         *----------------------------------------------------------------------
653:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
654:         WITH loc_oPagina.cnt_4c_BotoesAcao
655:             .Top         = 42
656:             .Left        = 760
657:             .Width       = 165
658:             .Height      = 85
659:             .BackStyle = 0
660:             .BorderWidth = 0
661:             .Visible     = .T.
662:         ENDWITH
663: 
664:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
665:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
666:             .Caption         = "Confirmar"
667:             .Top             = 5
668:             .Left            = 5
669:             .Width           = 75
670:             .Height          = 75
671:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"

*-- Linhas 683 a 750:
683:             .AutoSize        = .F.
684:             .Visible         = .T.
685:         ENDWITH
686:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
687: 
688:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
689:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
690:             .Caption         = "Encerrar"
691:             .Top             = 5
692:             .Left            = 85
693:             .Width           = 75
694:             .Height          = 75
695:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
696:             .PicturePosition = 13
697:             .FontName        = "Comic Sans MS"
698:             .FontSize        = 8
699:             .FontBold        = .T.
700:             .FontItalic      = .T.
701:             .ForeColor       = RGB(90, 90, 90)
702:             .BackColor       = RGB(255, 255, 255)
703:             .Themes          = .F.
704:             .SpecialEffect   = 0
705:             .MousePointer    = 15
706:             .WordWrap        = .T.
707:             .AutoSize        = .F.
708:             .Visible         = .T.
709:         ENDWITH
710:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
711: 
712:         *----------------------------------------------------------------------
713:         * Referencia: label + combo Mes + combo Ano
714:         * Label8 "Referencia :" Left=83, Top=139 -> Top=168
715:         * cboMes: Left=148, Top=136 -> Top=165
716:         * cboAno: Left=232, Top=136 -> Top=165
717:         *----------------------------------------------------------------------
718:         loc_oPagina.AddObject("lbl_4c_LblReferencia", "Label")
719:         WITH loc_oPagina.lbl_4c_LblReferencia
720:             .Caption   = "Refer" + CHR(234) + "ncia :"
721:             .Top       = 168
722:             .Left      = 83
723:             .Height    = 15
724:             .Width     = 65
725:             .FontName  = "Tahoma"
726:             .FontSize  = 8
727:             .BackStyle = 0
728:             .ForeColor = RGB(0, 90, 90)
729:             .AutoSize  = .F.
730:             .Visible   = .T.
731:         ENDWITH
732: 
733:         loc_oPagina.AddObject("cbo_4c_CboMes", "ComboBox")
734:         WITH loc_oPagina.cbo_4c_CboMes
735:             .Top             = 165
736:             .Left            = 148
737:             .Width           = 80
738:             .Height          = 24
739:             .BoundColumn     = 2
740:             .ColumnCount     = 2
741:             .ColumnWidths    = "0,70"
742:             .RowSourceType   = 1
743:             .RowSource       = loc_cRowMes
744:             .Style           = 2
745:             .FontName        = "Tahoma"
746:             .FontSize        = 8
747:             .Visible         = .T.
748:         ENDWITH
749: 
750:         loc_oPagina.AddObject("cbo_4c_CboAno", "ComboBox")

*-- Linhas 797 a 894:
797:             .BackColor           = RGB(255, 255, 255)
798:             .Visible             = .T.
799:         ENDWITH
800:         BINDEVENT(loc_oPagina.txt_4c_CodCli, "KeyPress", THIS, "ValidarCodCli")
801:         BINDEVENT(loc_oPagina.txt_4c_CodCli, "KeyPress",  THIS, "TeclaLookupCodCli")
802: 
803:         loc_oPagina.AddObject("txt_4c_DesCli", "TextBox")
804:         WITH loc_oPagina.txt_4c_DesCli
805:             .Top                 = 192
806:             .Left                = 232
807:             .Width               = 360
808:             .Height              = 23
809:             .Value               = ""
810:             .Alignment           = 0
811:             .FontName            = "Tahoma"
812:             .FontSize            = 8
813:             .DisabledBackColor   = RGB(255, 255, 255)
814:             .BackColor           = RGB(255, 255, 255)
815:             .Visible             = .T.
816:         ENDWITH
817:         BINDEVENT(loc_oPagina.txt_4c_DesCli, "KeyPress", THIS, "ValidarDesCli")
818:         BINDEVENT(loc_oPagina.txt_4c_DesCli, "KeyPress",  THIS, "TeclaLookupDesCli")
819: 
820:         *----------------------------------------------------------------------
821:         * Cargo: label + codigo
822:         * Label3 "Cargo :" Left=106, Top=192 -> Top=221
823:         * getCodCgo: Left=148, Top=189 -> Top=218, Width=80, Height=23
824:         *----------------------------------------------------------------------
825:         loc_oPagina.AddObject("lbl_4c_LblCargo", "Label")
826:         WITH loc_oPagina.lbl_4c_LblCargo
827:             .Caption   = "Cargo :"
828:             .Top       = 221
829:             .Left      = 106
830:             .Height    = 15
831:             .Width     = 40
832:             .FontName  = "Tahoma"
833:             .FontSize  = 8
834:             .BackStyle = 0
835:             .ForeColor = RGB(0, 90, 90)
836:             .AutoSize  = .F.
837:             .Visible   = .T.
838:         ENDWITH
839: 
840:         loc_oPagina.AddObject("txt_4c_CodCgo", "TextBox")
841:         WITH loc_oPagina.txt_4c_CodCgo
842:             .Top                 = 218
843:             .Left                = 148
844:             .Width               = 80
845:             .Height              = 23
846:             .Value               = ""
847:             .FontName            = "Tahoma"
848:             .FontSize            = 8
849:             .DisabledBackColor   = RGB(255, 255, 255)
850:             .BackColor           = RGB(255, 255, 255)
851:             .Visible             = .T.
852:         ENDWITH
853:         BINDEVENT(loc_oPagina.txt_4c_CodCgo, "KeyPress", THIS, "ValidarCodCgo")
854:         BINDEVENT(loc_oPagina.txt_4c_CodCgo, "KeyPress",  THIS, "TeclaLookupCodCgo")
855: 
856:         *----------------------------------------------------------------------
857:         * Horarios: labels + 4 campos HH:MM
858:         * Label7 "Horarios :" Left=95, Top=249 -> Top=278
859:         * Labels Inicio/Intervalo/Fim: Top=225 -> Top=254
860:         * getHora01-04: Top=246 -> Top=275, Width=45
861:         *   Left: 148 / 205 / 262 / 320
862:         *----------------------------------------------------------------------
863:         loc_oPagina.AddObject("lbl_4c_LblHorarios", "Label")
864:         WITH loc_oPagina.lbl_4c_LblHorarios
865:             .Caption   = "Hor" + CHR(225) + "rios :"
866:             .Top       = 278
867:             .Left      = 95
868:             .Height    = 15
869:             .Width     = 52
870:             .FontName  = "Tahoma"
871:             .FontSize  = 8
872:             .BackStyle = 0
873:             .ForeColor = RGB(0, 90, 90)
874:             .AutoSize  = .F.
875:             .Visible   = .T.
876:         ENDWITH
877: 
878:         loc_oPagina.AddObject("lbl_4c_LblInicio", "Label")
879:         WITH loc_oPagina.lbl_4c_LblInicio
880:             .Caption   = "In" + CHR(237) + "cio"
881:             .Top       = 254
882:             .Left      = 155
883:             .Height    = 15
884:             .Width     = 30
885:             .FontName  = "Tahoma"
886:             .FontSize  = 8
887:             .BackStyle = 0
888:             .ForeColor = RGB(0, 90, 90)
889:             .AutoSize  = .F.
890:             .Visible   = .T.
891:         ENDWITH
892: 
893:         loc_oPagina.AddObject("lbl_4c_LblIntervalo", "Label")
894:         WITH loc_oPagina.lbl_4c_LblIntervalo

*-- Linhas 1140 a 1246:
1140:             .Visible   = .T.
1141:         ENDWITH
1142: 
1143:         THIS.TornarControlesVisiveis(loc_oPagina)
1144:     ENDPROC
1145: 
1146:     *==========================================================================
1147:     * CarregarLista - Busca dados no BO e vincula ao grid
1148:     * Sequencia obrigatoria: Buscar -> RecordSource (fora WITH) -> AtualizarBinding
1149:     *==========================================================================
1150:     PROCEDURE CarregarLista()
1151:         LOCAL loc_lSucesso, loc_oGrid
1152:         loc_lSucesso = .F.
1153: 
1154:         TRY
1155:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1156:                 loc_lSucesso = .T.
1157:             ELSE
1158:                 IF THIS.this_oBusinessObject.Buscar("")
1159:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1160: 
1161:                     *-- RecordSource e ColumnCount FORA do WITH (Problema 36/48)
1162:                     loc_oGrid.ColumnCount = 3
1163:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1164:                     loc_oGrid.ColumnCount  = 14
1165: 
1166:                     *-- Redefine ControlSource + Headers apos RecordSource (Problema 48)
1167:                     THIS.AtualizarBindingGrid(loc_oGrid)
1168:                     THIS.FormatarGridLista(loc_oGrid)
1169:                     loc_oGrid.Refresh()
1170:                     loc_lSucesso = .T.
1171:                 ENDIF
1172:             ENDIF
1173:         CATCH TO loc_oErro
1174:             MsgErro("Erro em FormJrn.CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
1175:         ENDTRY
1176: 
1177:         RETURN loc_lSucesso
1178:     ENDPROC
1179: 
1180:     *==========================================================================
1181:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
1182:     *==========================================================================
1183:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1184:         LOCAL loc_lSucesso
1185:         loc_lSucesso = .F.
1186: 
1187:         TRY
1188:             IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
1189:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1190:                 IF par_nPagina = 1
1191:                     THIS.CarregarLista()
1192:                 ENDIF
1193:                 loc_lSucesso = .T.
1194:             ENDIF
1195:         CATCH TO loc_oErro
1196:             MsgErro("Erro em FormJrn.AlternarPagina:" + CHR(13) + loc_oErro.Message, "Erro")
1197:         ENDTRY
1198: 
1199:         RETURN loc_lSucesso
1200:     ENDPROC
1201: 
1202:     *==========================================================================
1203:     * AtualizarBindingGrid - Redefine ControlSource, Width e Header das 14 colunas
1204:     * Chamado apos RecordSource (Problema 48: auto-bind reseta ControlSource)
1205:     *==========================================================================
1206:     PROTECTED PROCEDURE AtualizarBindingGrid(par_oGrid)
1207:         WITH par_oGrid
1208:             .Column1.ControlSource   = "cursor_4c_Dados.iclis"
1209:             .Column1.Width           = 80
1210:             .Column1.Alignment       = 0
1211:             .Column1.Header1.Caption = "Funcion" + CHR(225) + "rio"
1212: 
1213:             .Column2.ControlSource   = "cursor_4c_Dados.cargos"
1214:             .Column2.Width           = 80
1215:             .Column2.Alignment       = 0
1216:             .Column2.Header1.Caption = "Cargo"
1217: 
1218:             .Column3.ControlSource   = "cursor_4c_Dados.refers"
1219:             .Column3.Width           = 52
1220:             .Column3.Alignment       = 0
1221:             .Column3.Header1.Caption = "Ano/M" + CHR(234) + "s"
1222: 
1223:             .Column4.ControlSource   = "cursor_4c_Dados.hora01"
1224:             .Column4.Width           = 45
1225:             .Column4.Alignment       = 0
1226:             .Column4.Header1.Caption = "Inicio"
1227: 
1228:             .Column5.ControlSource   = "cursor_4c_Dados.hora02"
1229:             .Column5.Width           = 45
1230:             .Column5.Alignment       = 0
1231:             .Column5.Header1.Caption = "Intervalo"
1232: 
1233:             .Column6.ControlSource   = "cursor_4c_Dados.hora03"
1234:             .Column6.Width           = 45
1235:             .Column6.Alignment       = 0
1236:             .Column6.Header1.Caption = "Intervalo"
1237: 
1238:             .Column7.ControlSource   = "cursor_4c_Dados.hora04"
1239:             .Column7.Width           = 45
1240:             .Column7.Alignment       = 0
1241:             .Column7.Header1.Caption = "Fim"
1242: 
1243:             .Column8.ControlSource   = "cursor_4c_Dados.cDom"
1244:             .Column8.Width           = 20
1245:             .Column8.Alignment       = 2
1246:             .Column8.Header1.Caption = "Dom"

*-- Linhas 1280 a 1333:
1280:     *==========================================================================
1281:     * FormatarGridLista - Padroniza fonte de todas as colunas
1282:     *==========================================================================
1283:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1284:         WITH par_oGrid
1285:             .FontName = "Tahoma"
1286:             .FontSize = 8
1287:         ENDWITH
1288:     ENDPROC
1289: 
1290:     *==========================================================================
1291:     * BOParaForm - Copia propriedades do BO para os controles de Page2
1292:     *==========================================================================
1293:     PROTECTED PROCEDURE BOParaForm()
1294:         LOCAL loc_lSucesso, loc_oPagina
1295:         loc_lSucesso = .F.
1296: 
1297:         TRY
1298:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1299: 
1300:             *-- Referencia: extrai ano (4) e mes (2) da string refers
1301:             IF LEN(ALLTRIM(THIS.this_oBusinessObject.this_cRefers)) = 6
1302:                 loc_oPagina.cbo_4c_CboAno.Value = SUBSTR(ALLTRIM(THIS.this_oBusinessObject.this_cRefers), 1, 4)
1303:                 loc_oPagina.cbo_4c_CboMes.Value = SUBSTR(ALLTRIM(THIS.this_oBusinessObject.this_cRefers), 5, 2)
1304:             ELSE
1305:                 loc_oPagina.cbo_4c_CboAno.Value = STR(YEAR(DATE()), 4)
1306:                 loc_oPagina.cbo_4c_CboMes.Value = PADL(LTRIM(STR(MONTH(DATE()))), 2, "0")
1307:             ENDIF
1308: 
1309:             *-- Funcionario
1310:             loc_oPagina.txt_4c_CodCli.Value = ALLTRIM(THIS.this_oBusinessObject.this_cIclis)
1311:             loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescri)
1312: 
1313:             *-- Cargo
1314:             loc_oPagina.txt_4c_CodCgo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCargos)
1315: 
1316:             *-- Horarios
1317:             loc_oPagina.txt_4c_Hora01.Value = ALLTRIM(THIS.this_oBusinessObject.this_cHora01)
1318:             loc_oPagina.txt_4c_Hora02.Value = ALLTRIM(THIS.this_oBusinessObject.this_cHora02)
1319:             loc_oPagina.txt_4c_Hora03.Value = ALLTRIM(THIS.this_oBusinessObject.this_cHora03)
1320:             loc_oPagina.txt_4c_Hora04.Value = ALLTRIM(THIS.this_oBusinessObject.this_cHora04)
1321: 
1322:             *-- Dias da semana (BO = logical, CheckBox.Value = numeric 0/1)
1323:             loc_oPagina.chk_4c_ChkDom.Value = IIF(THIS.this_oBusinessObject.this_lDom, 1, 0)
1324:             loc_oPagina.chk_4c_ChkSeg.Value = IIF(THIS.this_oBusinessObject.this_lSeg, 1, 0)
1325:             loc_oPagina.chk_4c_ChkTer.Value = IIF(THIS.this_oBusinessObject.this_lTer, 1, 0)
1326:             loc_oPagina.chk_4c_ChkQua.Value = IIF(THIS.this_oBusinessObject.this_lQua, 1, 0)
1327:             loc_oPagina.chk_4c_ChkQui.Value = IIF(THIS.this_oBusinessObject.this_lQui, 1, 0)
1328:             loc_oPagina.chk_4c_ChkSex.Value = IIF(THIS.this_oBusinessObject.this_lSex, 1, 0)
1329:             loc_oPagina.chk_4c_ChkSab.Value = IIF(THIS.this_oBusinessObject.this_lSab, 1, 0)
1330: 
1331:             loc_lSucesso = .T.
1332:         CATCH TO loc_oErro
1333:             MsgErro("Erro em FormJrn.BOParaForm:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 1339 a 1975:
1339:     *==========================================================================
1340:     * FormParaBO - Copia valores dos controles de Page2 para o BO
1341:     *==========================================================================
1342:     PROTECTED PROCEDURE FormParaBO()
1343:         LOCAL loc_lSucesso, loc_oPagina, loc_cAno, loc_cMes
1344:         loc_lSucesso = .F.
1345: 
1346:         TRY
1347:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1348: 
1349:             *-- Referencia: combina ano e mes
1350:             loc_cAno = ALLTRIM(NVL(loc_oPagina.cbo_4c_CboAno.Value, ""))
1351:             loc_cMes = ALLTRIM(NVL(loc_oPagina.cbo_4c_CboMes.Value, ""))
1352:             THIS.this_oBusinessObject.this_cRefers = loc_cAno + loc_cMes
1353: 
1354:             *-- Funcionario
1355:             THIS.this_oBusinessObject.this_cIclis  = ALLTRIM(loc_oPagina.txt_4c_CodCli.Value)
1356:             THIS.this_oBusinessObject.this_cDescri = ALLTRIM(loc_oPagina.txt_4c_DesCli.Value)
1357: 
1358:             *-- Cargo
1359:             THIS.this_oBusinessObject.this_cCargos = ALLTRIM(loc_oPagina.txt_4c_CodCgo.Value)
1360: 
1361:             *-- Horarios
1362:             THIS.this_oBusinessObject.this_cHora01 = ALLTRIM(loc_oPagina.txt_4c_Hora01.Value)
1363:             THIS.this_oBusinessObject.this_cHora02 = ALLTRIM(loc_oPagina.txt_4c_Hora02.Value)
1364:             THIS.this_oBusinessObject.this_cHora03 = ALLTRIM(loc_oPagina.txt_4c_Hora03.Value)
1365:             THIS.this_oBusinessObject.this_cHora04 = ALLTRIM(loc_oPagina.txt_4c_Hora04.Value)
1366: 
1367:             *-- Dias da semana (CheckBox.Value = 0/1 numeric -> logical via comparacao)
1368:             THIS.this_oBusinessObject.this_lDom = (loc_oPagina.chk_4c_ChkDom.Value = 1)
1369:             THIS.this_oBusinessObject.this_lSeg = (loc_oPagina.chk_4c_ChkSeg.Value = 1)
1370:             THIS.this_oBusinessObject.this_lTer = (loc_oPagina.chk_4c_ChkTer.Value = 1)
1371:             THIS.this_oBusinessObject.this_lQua = (loc_oPagina.chk_4c_ChkQua.Value = 1)
1372:             THIS.this_oBusinessObject.this_lQui = (loc_oPagina.chk_4c_ChkQui.Value = 1)
1373:             THIS.this_oBusinessObject.this_lSex = (loc_oPagina.chk_4c_ChkSex.Value = 1)
1374:             THIS.this_oBusinessObject.this_lSab = (loc_oPagina.chk_4c_ChkSab.Value = 1)
1375: 
1376:             loc_lSucesso = .T.
1377:         CATCH TO loc_oErro
1378:             MsgErro("Erro em FormJrn.FormParaBO:" + CHR(13) + loc_oErro.Message, "Erro")
1379:         ENDTRY
1380: 
1381:         RETURN loc_lSucesso
1382:     ENDPROC
1383: 
1384:     *==========================================================================
1385:     * LimparCampos - Limpa todos os campos de Page2 para novo registro
1386:     *==========================================================================
1387:     PROTECTED PROCEDURE LimparCampos()
1388:         LOCAL loc_oPagina, loc_cMesAtual, loc_cAnoAtual
1389: 
1390:         TRY
1391:             loc_oPagina   = THIS.pgf_4c_Paginas.Page2
1392:             loc_cMesAtual = PADL(LTRIM(STR(MONTH(DATE()))), 2, "0")
1393:             loc_cAnoAtual = STR(YEAR(DATE()), 4)
1394: 
1395:             loc_oPagina.cbo_4c_CboMes.Value    = loc_cMesAtual
1396:             loc_oPagina.cbo_4c_CboAno.Value    = loc_cAnoAtual
1397:             loc_oPagina.txt_4c_CodCli.Value    = ""
1398:             loc_oPagina.txt_4c_DesCli.Value    = ""
1399:             loc_oPagina.txt_4c_CodCgo.Value    = ""
1400:             loc_oPagina.txt_4c_Hora01.Value    = ""
1401:             loc_oPagina.txt_4c_Hora02.Value    = ""
1402:             loc_oPagina.txt_4c_Hora03.Value    = ""
1403:             loc_oPagina.txt_4c_Hora04.Value    = ""
1404:             loc_oPagina.chk_4c_ChkDom.Value   = 0
1405:             loc_oPagina.chk_4c_ChkSeg.Value   = 0
1406:             loc_oPagina.chk_4c_ChkTer.Value   = 0
1407:             loc_oPagina.chk_4c_ChkQua.Value   = 0
1408:             loc_oPagina.chk_4c_ChkQui.Value   = 0
1409:             loc_oPagina.chk_4c_ChkSex.Value   = 0
1410:             loc_oPagina.chk_4c_ChkSab.Value   = 0
1411:         CATCH TO loc_oErro
1412:             MsgErro("Erro em FormJrn.LimparCampos:" + CHR(13) + loc_oErro.Message, "Erro")
1413:         ENDTRY
1414:     ENDPROC
1415: 
1416:     *==========================================================================
1417:     * HabilitarCampos - Habilita/desabilita campos de edicao em Page2
1418:     * par_lHabilitar = .T.: INCLUIR/ALTERAR | .F.: VISUALIZAR
1419:     *==========================================================================
1420:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1421:         LOCAL loc_oPagina, loc_lReadOnly
1422: 
1423:         TRY
1424:             loc_oPagina   = THIS.pgf_4c_Paginas.Page2
1425:             loc_lReadOnly = !par_lHabilitar
1426: 
1427:             loc_oPagina.cbo_4c_CboMes.Enabled   = par_lHabilitar
1428:             loc_oPagina.cbo_4c_CboAno.Enabled   = par_lHabilitar
1429:             loc_oPagina.txt_4c_CodCli.ReadOnly  = loc_lReadOnly
1430:             loc_oPagina.txt_4c_DesCli.ReadOnly  = loc_lReadOnly
1431:             loc_oPagina.txt_4c_CodCgo.ReadOnly  = loc_lReadOnly
1432:             loc_oPagina.txt_4c_Hora01.ReadOnly  = loc_lReadOnly
1433:             loc_oPagina.txt_4c_Hora02.ReadOnly  = loc_lReadOnly
1434:             loc_oPagina.txt_4c_Hora03.ReadOnly  = loc_lReadOnly
1435:             loc_oPagina.txt_4c_Hora04.ReadOnly  = loc_lReadOnly
1436:             loc_oPagina.chk_4c_ChkDom.Enabled  = par_lHabilitar
1437:             loc_oPagina.chk_4c_ChkSeg.Enabled  = par_lHabilitar
1438:             loc_oPagina.chk_4c_ChkTer.Enabled  = par_lHabilitar
1439:             loc_oPagina.chk_4c_ChkQua.Enabled  = par_lHabilitar
1440:             loc_oPagina.chk_4c_ChkQui.Enabled  = par_lHabilitar
1441:             loc_oPagina.chk_4c_ChkSex.Enabled  = par_lHabilitar
1442:             loc_oPagina.chk_4c_ChkSab.Enabled  = par_lHabilitar
1443:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
1444:         CATCH TO loc_oErro
1445:             MsgErro("Erro em FormJrn.HabilitarCampos:" + CHR(13) + loc_oErro.Message, "Erro")
1446:         ENDTRY
1447:     ENDPROC
1448: 
1449:     *==========================================================================
1450:     * BtnIncluirClick - Inicia inclusao de novo registro
1451:     *==========================================================================
1452:     PROCEDURE BtnIncluirClick()
1453:         THIS.this_oBusinessObject.NovoRegistro()
1454:         THIS.this_cModoAtual = "INCLUIR"
1455:         THIS.LimparCampos()
1456:         THIS.HabilitarCampos(.T.)
1457:         THIS.AjustarBotoesPorModo()
1458:         THIS.pgf_4c_Paginas.ActivePage = 2
1459:     ENDPROC
1460: 
1461:     *==========================================================================
1462:     * BtnVisualizarClick - Abre registro selecionado em modo leitura
1463:     *==========================================================================
1464:     PROCEDURE BtnVisualizarClick()
1465:         LOCAL loc_cPkChave
1466:         loc_cPkChave = ""
1467: 
1468:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1469:             SELECT cursor_4c_Dados
1470:             loc_cPkChave = ALLTRIM(cursor_4c_Dados.pkchave)
1471:         ENDIF
1472: 
1473:         IF EMPTY(loc_cPkChave)
1474:             MsgAviso("Selecione um registro na lista.")
1475:             RETURN
1476:         ENDIF
1477: 
1478:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPkChave)
1479:             THIS.this_cModoAtual = "VISUALIZAR"
1480:             THIS.BOParaForm()
1481:             THIS.HabilitarCampos(.F.)
1482:             THIS.AjustarBotoesPorModo()
1483:             THIS.pgf_4c_Paginas.ActivePage = 2
1484:         ENDIF
1485:     ENDPROC
1486: 
1487:     *==========================================================================
1488:     * BtnAlterarClick - Abre registro selecionado em modo edicao
1489:     *==========================================================================
1490:     PROCEDURE BtnAlterarClick()
1491:         LOCAL loc_cPkChave
1492:         loc_cPkChave = ""
1493: 
1494:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1495:             SELECT cursor_4c_Dados
1496:             loc_cPkChave = ALLTRIM(cursor_4c_Dados.pkchave)
1497:         ENDIF
1498: 
1499:         IF EMPTY(loc_cPkChave)
1500:             MsgAviso("Selecione um registro na lista.")
1501:             RETURN
1502:         ENDIF
1503: 
1504:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPkChave)
1505:             THIS.this_oBusinessObject.EditarRegistro()
1506:             THIS.this_cModoAtual = "ALTERAR"
1507:             THIS.BOParaForm()
1508:             THIS.HabilitarCampos(.T.)
1509:             THIS.AjustarBotoesPorModo()
1510:             THIS.pgf_4c_Paginas.ActivePage = 2
1511:         ENDIF
1512:     ENDPROC
1513: 
1514:     *==========================================================================
1515:     * BtnExcluirClick - Confirma e executa exclusao do registro selecionado
1516:     *==========================================================================
1517:     PROCEDURE BtnExcluirClick()
1518:         LOCAL loc_cPkChave
1519:         loc_cPkChave = ""
1520: 
1521:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1522:             SELECT cursor_4c_Dados
1523:             loc_cPkChave = ALLTRIM(cursor_4c_Dados.pkchave)
1524:         ENDIF
1525: 
1526:         IF EMPTY(loc_cPkChave)
1527:             MsgAviso("Selecione um registro na lista.")
1528:             RETURN
1529:         ENDIF
1530: 
1531:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Excluir")
1532:             RETURN
1533:         ENDIF
1534: 
1535:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPkChave)
1536:             IF THIS.this_oBusinessObject.Excluir()
1537:                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
1538:                 THIS.CarregarLista()
1539:             ENDIF
1540:         ENDIF
1541:     ENDPROC
1542: 
1543:     *==========================================================================
1544:     * BtnBuscarClick - Filtra lista por funcionario, cargo ou referencia
1545:     *==========================================================================
1546:     PROCEDURE BtnBuscarClick()
1547:         LOCAL loc_cBusca, loc_cFiltro, loc_oGrid
1548:         loc_cBusca  = ""
1549:         loc_cFiltro = ""
1550: 
1551:         TRY
1552:             loc_cBusca = INPUTBOX("Buscar por funcion" + CHR(225) + ;
1553:                                   "rio, cargo ou refer" + CHR(234) + "ncia (AAAAMM):", ;
1554:                                   "Buscar Jornadas", "")
1555: 
1556:             IF VARTYPE(loc_cBusca) = "C"
1557:                 loc_cBusca = ALLTRIM(CHRTRAN(loc_cBusca, "'", ""))
1558: 
1559:                 IF !EMPTY(loc_cBusca)
1560:                     loc_cFiltro = "(a.iclis LIKE '%" + loc_cBusca + "%'" + ;
1561:                                   " OR a.cargos LIKE '%" + loc_cBusca + "%'" + ;
1562:                                   " OR a.refers LIKE '%" + loc_cBusca + "%'" + ;
1563:                                   " OR b.rclis LIKE '%" + loc_cBusca + "%')"
1564:                 ENDIF
1565: 
1566:                 IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
1567:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1568:                     loc_oGrid.ColumnCount = 3
1569:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1570:                     loc_oGrid.ColumnCount  = 14
1571:                     THIS.AtualizarBindingGrid(loc_oGrid)
1572:                     THIS.FormatarGridLista(loc_oGrid)
1573:                     loc_oGrid.Refresh()
1574:                 ENDIF
1575:             ENDIF
1576:         CATCH TO loc_oErro
1577:             MsgErro("Erro em FormJrn.BtnBuscarClick:" + CHR(13) + loc_oErro.Message, "Erro")
1578:         ENDTRY
1579:     ENDPROC
1580: 
1581:     *==========================================================================
1582:     * BtnEncerrarClick - Fecha o formulario
1583:     *==========================================================================
1584:     PROCEDURE BtnEncerrarClick()
1585:         THIS.Release()
1586:     ENDPROC
1587: 
1588:     *==========================================================================
1589:     * BtnCancelarClick - Cancela edicao e volta para lista
1590:     *==========================================================================
1591:     PROCEDURE BtnCancelarClick()
1592:         THIS.this_oBusinessObject.CancelarEdicao()
1593:         THIS.this_cModoAtual = "LISTA"
1594:         THIS.AlternarPagina(1)
1595:     ENDPROC
1596: 
1597:     *==========================================================================
1598:     * BtnSalvarClick - Salva o registro atual (Confirmar em Page2)
1599:     * Chama FormParaBO() + BO.Salvar() (que ja valida internamente)
1600:     *==========================================================================
1601:     PROCEDURE BtnSalvarClick()
1602:         TRY
1603:             IF THIS.FormParaBO()
1604:                 IF THIS.this_oBusinessObject.Salvar()
1605:                     MsgInfo("Registro salvo com sucesso!", "Sucesso")
1606:                     THIS.this_cModoAtual = "LISTA"
1607:                     THIS.AlternarPagina(1)
1608:                 ENDIF
1609:             ENDIF
1610:         CATCH TO loc_oErro
1611:             MsgErro("Erro em FormJrn.BtnSalvarClick:" + CHR(13) + loc_oErro.Message, "Erro")
1612:         ENDTRY
1613:     ENDPROC
1614: 
1615:     *==========================================================================
1616:     * BtnCopiarMesClick - Prepara painel de copia de jornada para outro mes
1617:     * Equivale ao Command1.Click na Page.Lista do legado
1618:     * Captura ano/mes do registro selecionado e exibe cnt_4c_CopiaMes
1619:     *==========================================================================
1620:     PROCEDURE BtnCopiarMesClick()
1621:         LOCAL loc_cRefers, loc_cIclis, loc_cCargos, loc_cPkChave, loc_oPagina
1622:         loc_cRefers  = ""
1623:         loc_cIclis   = ""
1624:         loc_cCargos  = ""
1625:         loc_cPkChave = ""
1626: 
1627:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1628:             SELECT cursor_4c_Dados
1629:             loc_cRefers  = ALLTRIM(cursor_4c_Dados.refers)
1630:             loc_cIclis   = ALLTRIM(cursor_4c_Dados.iclis)
1631:             loc_cCargos  = ALLTRIM(cursor_4c_Dados.cargos)
1632:             loc_cPkChave = ALLTRIM(cursor_4c_Dados.pkchave)
1633:         ENDIF
1634: 
1635:         IF EMPTY(loc_cRefers)
1636:             MsgAviso("Selecione um registro na lista para copiar.")
1637:             RETURN
1638:         ENDIF
1639: 
1640:         *-- Carregar BO com o registro selecionado (CopiarParaMes precisa dos dados do BO)
1641:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPkChave)
1642:             RETURN
1643:         ENDIF
1644: 
1645:         THIS.this_cAnoAtual = SUBSTR(loc_cRefers, 1, 4)
1646:         THIS.this_cMesAtual = SUBSTR(loc_cRefers, 5, 2)
1647: 
1648:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1649: 
1650:         THIS.this_oBusinessObject.BuscarMesesDisponiveis(loc_cIclis, loc_cCargos)
1651:         THIS.PopularCombosCopiaMes()
1652: 
1653:         loc_oPagina.cmd_4c_CopiarMes.Enabled = .F.
1654:         loc_oPagina.cnt_4c_Saida.Enabled     = .F.
1655:         loc_oPagina.cnt_4c_Botoes.Enabled    = .F.
1656:         loc_oPagina.grd_4c_Lista.Enabled     = .F.
1657:         loc_oPagina.cnt_4c_CopiaMes.Visible  = .T.
1658:         loc_oPagina.cnt_4c_CopiaMes.SetFocus()
1659:     ENDPROC
1660: 
1661:     *==========================================================================
1662:     * Lookup Cargo (txt_4c_CodCgo -> SigCdCrg)
1663:     *==========================================================================
1664:     PROCEDURE AbrirLookupCargo()
1665:         LOCAL loc_oPagina, loc_cValor, loc_oForm
1666:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1667:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_CodCgo.Value)
1668: 
1669:         TRY
1670:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1671:                 "SigCdCrg", "cursor_4c_Busca", "ccargs", loc_cValor, ;
1672:                 "Sele" + CHR(231) + CHR(227) + "o de Cargos")
1673: 
1674:             IF VARTYPE(loc_oForm) = "O"
1675:                 IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1676:                     loc_oPagina.txt_4c_CodCgo.Value = ALLTRIM(cursor_4c_Busca.ccargs)
1677:                 ELSE
1678:                     IF !loc_oForm.this_lAchouRegistro
1679:                     loc_oForm.mAddColuna("ccargs", "", "C" + CHR(243) + "digo")
1680:                     loc_oForm.mAddColuna("dcargs", "", "Descri" + CHR(231) + CHR(227) + "o")
1681:                     loc_oForm.Show()
1682:                     IF loc_oForm.this_lSelecionou
1683:                         loc_oPagina.txt_4c_CodCgo.Value = ALLTRIM(cursor_4c_Busca.ccargs)
1684:                     ENDIF
1685:                     ENDIF
1686:                 ENDIF
1687:                 IF USED("cursor_4c_Busca")
1688:                     USE IN cursor_4c_Busca
1689:                 ENDIF
1690:                 loc_oForm.Release()
1691:             ENDIF
1692:         CATCH TO loc_oErro
1693:             MsgErro("Erro em FormJrn.AbrirLookupCargo:" + CHR(13) + loc_oErro.Message, "Erro")
1694:         ENDTRY
1695:     ENDPROC
1696: 
1697:     PROCEDURE ValidarCodCgo(par_nKeyCode, par_nShiftAltCtrl)
1698:         LOCAL loc_oPagina, loc_cValor, loc_cSQL, loc_nResult
1699:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1700:         loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_CodCgo.Value))
1701: 
1702:         IF EMPTY(loc_cValor)
1703:             RETURN
1704:         ENDIF
1705: 
1706:         TRY
1707:             loc_cSQL    = "SELECT ccargs FROM SigCdCrg WHERE ccargs = " + EscaparSQL(loc_cValor)
1708:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValCgo")
1709: 
1710:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ValCgo") > 0
1711:                 loc_oPagina.txt_4c_CodCgo.Value = ALLTRIM(cursor_4c_ValCgo.ccargs)
1712:             ELSE
1713:                 MsgAviso("Cargo n" + CHR(227) + "o encontrado.")
1714:                 loc_oPagina.txt_4c_CodCgo.Value = ""
1715:                 THIS.AbrirLookupCargo()
1716:             ENDIF
1717: 
1718:             IF USED("cursor_4c_ValCgo")
1719:                 USE IN cursor_4c_ValCgo
1720:             ENDIF
1721:         CATCH TO loc_oErro
1722:             MsgErro("Erro em FormJrn.ValidarCodCgo:" + CHR(13) + loc_oErro.Message, "Erro")
1723:             IF USED("cursor_4c_ValCgo")
1724:                 USE IN cursor_4c_ValCgo
1725:             ENDIF
1726:         ENDTRY
1727:     ENDPROC
1728: 
1729:     PROCEDURE TeclaLookupCodCgo(par_nKeyCode, par_nShiftAltCtrl)
1730:         IF INLIST(par_nKeyCode, 115, 116)
1731:             THIS.AbrirLookupCargo()
1732:         ENDIF
1733:     ENDPROC
1734: 
1735:     *==========================================================================
1736:     * Lookup Funcionario por codigo (txt_4c_CodCli -> SigCdCli.iclis)
1737:     *==========================================================================
1738:     PROCEDURE AbrirLookupFuncionario()
1739:         LOCAL loc_oPagina, loc_cValor, loc_oForm
1740:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1741:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_CodCli.Value)
1742: 
1743:         TRY
1744:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1745:                 "SigCdCli", "cursor_4c_BuscaCli", "iclis", loc_cValor, ;
1746:                 "Sele" + CHR(231) + CHR(227) + "o de Funcion" + CHR(225) + "rios")
1747: 
1748:             IF VARTYPE(loc_oForm) = "O"
1749:                 IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1750:                     loc_oPagina.txt_4c_CodCli.Value = ALLTRIM(cursor_4c_BuscaCli.iclis)
1751:                     loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(cursor_4c_BuscaCli.rclis)
1752:                 ELSE
1753:                     IF !loc_oForm.this_lAchouRegistro
1754:                     loc_oForm.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1755:                     loc_oForm.mAddColuna("rclis", "", "Nome")
1756:                     loc_oForm.Show()
1757:                     IF loc_oForm.this_lSelecionou
1758:                         loc_oPagina.txt_4c_CodCli.Value = ALLTRIM(cursor_4c_BuscaCli.iclis)
1759:                         loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(cursor_4c_BuscaCli.rclis)
1760:                     ENDIF
1761:                     ENDIF
1762:                 ENDIF
1763:                 IF USED("cursor_4c_BuscaCli")
1764:                     USE IN cursor_4c_BuscaCli
1765:                 ENDIF
1766:                 loc_oForm.Release()
1767:             ENDIF
1768:         CATCH TO loc_oErro
1769:             MsgErro("Erro em FormJrn.AbrirLookupFuncionario:" + CHR(13) + loc_oErro.Message, "Erro")
1770:         ENDTRY
1771:     ENDPROC
1772: 
1773:     PROCEDURE ValidarCodCli(par_nKeyCode, par_nShiftAltCtrl)
1774:         LOCAL loc_oPagina, loc_cValor, loc_cSQL, loc_nResult
1775:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1776:         loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_CodCli.Value))
1777: 
1778:         IF EMPTY(loc_cValor)
1779:             loc_oPagina.txt_4c_DesCli.Value = ""
1780:             RETURN
1781:         ENDIF
1782: 
1783:         TRY
1784:             loc_cSQL    = "SELECT iclis, rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cValor)
1785:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValCli")
1786: 
1787:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ValCli") > 0
1788:                 loc_oPagina.txt_4c_CodCli.Value = ALLTRIM(cursor_4c_ValCli.iclis)
1789:                 loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(cursor_4c_ValCli.rclis)
1790:             ELSE
1791:                 MsgAviso("Funcion" + CHR(225) + "rio n" + CHR(227) + "o encontrado.")
1792:                 loc_oPagina.txt_4c_CodCli.Value = ""
1793:                 loc_oPagina.txt_4c_DesCli.Value = ""
1794:                 THIS.AbrirLookupFuncionario()
1795:             ENDIF
1796: 
1797:             IF USED("cursor_4c_ValCli")
1798:                 USE IN cursor_4c_ValCli
1799:             ENDIF
1800:         CATCH TO loc_oErro
1801:             MsgErro("Erro em FormJrn.ValidarCodCli:" + CHR(13) + loc_oErro.Message, "Erro")
1802:             IF USED("cursor_4c_ValCli")
1803:                 USE IN cursor_4c_ValCli
1804:             ENDIF
1805:         ENDTRY
1806:     ENDPROC
1807: 
1808:     PROCEDURE TeclaLookupCodCli(par_nKeyCode, par_nShiftAltCtrl)
1809:         IF INLIST(par_nKeyCode, 115, 116)
1810:             THIS.AbrirLookupFuncionario()
1811:         ENDIF
1812:     ENDPROC
1813: 
1814:     *==========================================================================
1815:     * Lookup Funcionario por nome (txt_4c_DesCli -> SigCdCli.rclis)
1816:     *==========================================================================
1817:     PROCEDURE AbrirLookupFuncionarioPorNome()
1818:         LOCAL loc_oPagina, loc_cValor, loc_oForm
1819:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1820:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_DesCli.Value)
1821: 
1822:         TRY
1823:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1824:                 "SigCdCli", "cursor_4c_BuscaCli", "rclis", loc_cValor, ;
1825:                 "Sele" + CHR(231) + CHR(227) + "o de Funcion" + CHR(225) + "rios")
1826: 
1827:             IF VARTYPE(loc_oForm) = "O"
1828:                 IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1829:                     loc_oPagina.txt_4c_CodCli.Value = ALLTRIM(cursor_4c_BuscaCli.iclis)
1830:                     loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(cursor_4c_BuscaCli.rclis)
1831:                 ELSE
1832:                     IF !loc_oForm.this_lAchouRegistro
1833:                     loc_oForm.mAddColuna("rclis", "", "Nome")
1834:                     loc_oForm.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1835:                     loc_oForm.Show()
1836:                     IF loc_oForm.this_lSelecionou
1837:                         loc_oPagina.txt_4c_CodCli.Value = ALLTRIM(cursor_4c_BuscaCli.iclis)
1838:                         loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(cursor_4c_BuscaCli.rclis)
1839:                     ENDIF
1840:                     ENDIF
1841:                 ENDIF
1842:                 IF USED("cursor_4c_BuscaCli")
1843:                     USE IN cursor_4c_BuscaCli
1844:                 ENDIF
1845:                 loc_oForm.Release()
1846:             ENDIF
1847:         CATCH TO loc_oErro
1848:             MsgErro("Erro em FormJrn.AbrirLookupFuncionarioPorNome:" + CHR(13) + loc_oErro.Message, "Erro")
1849:         ENDTRY
1850:     ENDPROC
1851: 
1852:     PROCEDURE ValidarDesCli(par_nKeyCode, par_nShiftAltCtrl)
1853:         LOCAL loc_oPagina, loc_cValor, loc_cSQL, loc_nResult
1854:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1855:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_DesCli.Value)
1856: 
1857:         IF EMPTY(loc_cValor)
1858:             loc_oPagina.txt_4c_CodCli.Value = ""
1859:             RETURN
1860:         ENDIF
1861: 
1862:         TRY
1863:             loc_cSQL    = "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE rclis LIKE " + ;
1864:                           EscaparSQL(loc_cValor + "%") + " ORDER BY rclis"
1865:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValDes")
1866: 
1867:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ValDes") > 0
1868:                 loc_oPagina.txt_4c_CodCli.Value = ALLTRIM(cursor_4c_ValDes.iclis)
1869:                 loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(cursor_4c_ValDes.rclis)
1870:             ELSE
1871:                 MsgAviso("Funcion" + CHR(225) + "rio n" + CHR(227) + "o encontrado.")
1872:                 loc_oPagina.txt_4c_DesCli.Value = ""
1873:                 loc_oPagina.txt_4c_CodCli.Value = ""
1874:                 THIS.AbrirLookupFuncionarioPorNome()
1875:             ENDIF
1876: 
1877:             IF USED("cursor_4c_ValDes")
1878:                 USE IN cursor_4c_ValDes
1879:             ENDIF
1880:         CATCH TO loc_oErro
1881:             MsgErro("Erro em FormJrn.ValidarDesCli:" + CHR(13) + loc_oErro.Message, "Erro")
1882:             IF USED("cursor_4c_ValDes")
1883:                 USE IN cursor_4c_ValDes
1884:             ENDIF
1885:         ENDTRY
1886:     ENDPROC
1887: 
1888:     PROCEDURE TeclaLookupDesCli(par_nKeyCode, par_nShiftAltCtrl)
1889:         IF INLIST(par_nKeyCode, 115, 116)
1890:             THIS.AbrirLookupFuncionarioPorNome()
1891:         ENDIF
1892:     ENDPROC
1893: 
1894:     *==========================================================================
1895:     * TornarControlesVisiveis - Torna todos controles visiveis recursivamente
1896:     * Necessario pois AddObject() cria controles com Visible=.F. por padrao
1897:     *==========================================================================
1898:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1899:         LOCAL loc_i, loc_oObjeto, loc_p, loc_cNome
1900: 
1901:         FOR loc_i = 1 TO par_oContainer.ControlCount
1902:             loc_oObjeto = par_oContainer.Controls(loc_i)
1903: 
1904:             IF VARTYPE(loc_oObjeto) = "O"
1905:                 loc_cNome = UPPER(loc_oObjeto.Name)
1906: 
1907:                 *-- Problema 26: Containers flutuantes que devem iniciar ocultos
1908:                 *-- Recursao nos filhos (controles internos precisam ficar visiveis quando exibidos)
1909:                 IF INLIST(loc_cNome, "CNT_4C_COPIARMES")
1910:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1911:                     LOOP
1912:                 ENDIF
1913: 
1914:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1915:                     loc_oObjeto.Visible = .T.
1916:                 ENDIF
1917: 
1918:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1919:                     FOR loc_p = 1 TO loc_oObjeto.PageCount
1920:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_p))
1921:                     ENDFOR
1922:                 ENDIF
1923: 
1924:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
1925:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1926:                 ENDIF
1927:             ENDIF
1928:         ENDFOR
1929:     ENDPROC
1930: 
1931:     *==========================================================================
1932:     * PopularCombosCopiaMes - Popula combos De/Para a partir de cursor_4c_Meses
1933:     * Cursor deve ser criado por JrnBO.BuscarMesesDisponiveis antes de chamar
1934:     *==========================================================================
1935:     PROTECTED PROCEDURE PopularCombosCopiaMes()
1936:         LOCAL loc_oCnt, loc_cMesCombo, loc_cMesRef, loc_cNomeMes
1937:         loc_oCnt      = THIS.pgf_4c_Paginas.Page1.cnt_4c_CopiaMes
1938:         loc_cMesCombo = ""
1939:         loc_cNomeMes  = ""
1940: 
1941:         TRY
1942:             IF USED("cursor_4c_Meses") AND RECCOUNT("cursor_4c_Meses") > 0
1943:                 SELECT cursor_4c_Meses
1944:                 GO TOP
1945:                 SCAN
1946:                     loc_cMesRef = SUBSTR(ALLTRIM(refers), 5, 2)
1947:                     DO CASE
1948:                         CASE loc_cMesRef = "01"
1949:                             loc_cNomeMes = "Janeiro"
1950:                         CASE loc_cMesRef = "02"
1951:                             loc_cNomeMes = "Fevereiro"
1952:                         CASE loc_cMesRef = "03"
1953:                             loc_cNomeMes = "Mar" + CHR(231) + "o"
1954:                         CASE loc_cMesRef = "04"
1955:                             loc_cNomeMes = "Abril"
1956:                         CASE loc_cMesRef = "05"
1957:                             loc_cNomeMes = "Maio"
1958:                         CASE loc_cMesRef = "06"
1959:                             loc_cNomeMes = "Junho"
1960:                         CASE loc_cMesRef = "07"
1961:                             loc_cNomeMes = "Julho"
1962:                         CASE loc_cMesRef = "08"
1963:                             loc_cNomeMes = "Agosto"
1964:                         CASE loc_cMesRef = "09"
1965:                             loc_cNomeMes = "Setembro"
1966:                         CASE loc_cMesRef = "10"
1967:                             loc_cNomeMes = "Outubro"
1968:                         CASE loc_cMesRef = "11"
1969:                             loc_cNomeMes = "Novembro"
1970:                         CASE loc_cMesRef = "12"
1971:                             loc_cNomeMes = "Dezembro"
1972:                         OTHERWISE
1973:                             loc_cNomeMes = "M" + CHR(234) + "s " + loc_cMesRef
1974:                     ENDCASE
1975:                     IF !EMPTY(loc_cMesCombo)

*-- Linhas 1995 a 2089:
1995:     * CopiaMesCancelarClick - Fecha painel CopiaMes e reabilita controles da lista
1996:     * Equivale ao Command1.Click de cntCopiaMes no legado
1997:     *==========================================================================
1998:     PROCEDURE CopiaMesCancelarClick()
1999:         LOCAL loc_oPagina
2000:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
2001: 
2002:         TRY
2003:             loc_oPagina.cnt_4c_CopiaMes.Visible  = .F.
2004:             loc_oPagina.cmd_4c_CopiarMes.Enabled = .T.
2005:             loc_oPagina.cnt_4c_Saida.Enabled     = .T.
2006:             loc_oPagina.cnt_4c_Botoes.Enabled    = .T.
2007:             loc_oPagina.grd_4c_Lista.Enabled     = .T.
2008:             loc_oPagina.grd_4c_Lista.SetFocus()
2009:             loc_oPagina.grd_4c_Lista.Refresh()
2010:         CATCH TO loc_oErro
2011:             MsgErro("Erro em FormJrn.CopiaMesCancelarClick:" + CHR(13) + loc_oErro.Message, "Erro")
2012:         ENDTRY
2013:     ENDPROC
2014: 
2015:     *==========================================================================
2016:     * CopiaMesConfirmarClick - Executa copia da jornada para o mes selecionado
2017:     * Equivale ao Command2.Click de cntCopiaMes no legado
2018:     * Usa JrnBO.CopiarParaMes(ano, mes) com o registro carregado em BtnCopiarMesClick
2019:     *==========================================================================
2020:     PROCEDURE CopiaMesConfirmarClick()
2021:         LOCAL loc_oPagina, loc_cMesPara, loc_cRefsDest
2022:         loc_oPagina  = THIS.pgf_4c_Paginas.Page1
2023:         loc_cMesPara = ALLTRIM(NVL(loc_oPagina.cnt_4c_CopiaMes.cbo_4c_Para.Value, ""))
2024: 
2025:         IF EMPTY(loc_cMesPara)
2026:             MsgAviso("Selecione o m" + CHR(234) + "s destino.", ;
2027:                     "Valida" + CHR(231) + CHR(227) + "o")
2028:             RETURN
2029:         ENDIF
2030: 
2031:         loc_cRefsDest = THIS.this_cAnoAtual + loc_cMesPara
2032: 
2033:         IF loc_cRefsDest == THIS.this_cAnoAtual + THIS.this_cMesAtual
2034:             MsgErro("O m" + CHR(234) + "s destino " + CHR(233) + " igual ao de origem.", ;
2035:                     "Valida" + CHR(231) + CHR(227) + "o")
2036:             RETURN
2037:         ENDIF
2038: 
2039:         IF MsgConfirma("Confirma c" + CHR(243) + "pia da jornada para " + ;
2040:                        SUBSTR(loc_cRefsDest, 5, 2) + "/" + SUBSTR(loc_cRefsDest, 1, 4) + "?", ;
2041:                        "Copiar Jornada")
2042:             IF THIS.this_oBusinessObject.CopiarParaMes(THIS.this_cAnoAtual, loc_cMesPara)
2043:                 MsgInfo("Jornada copiada com sucesso!", "Sucesso")
2044:                 THIS.CopiaMesCancelarClick()
2045:                 THIS.CarregarLista()
2046:             ENDIF
2047:         ENDIF
2048:     ENDPROC
2049: 
2050:     *==========================================================================
2051:     * AjustarBotoesPorModo - Ajusta habilitacao dos botoes conforme this_cModoAtual
2052:     * LISTA    : sem efeito (Page1 visivel)
2053:     * INCLUIR  : Confirmar=habilitado, Cancelar=habilitado
2054:     * ALTERAR  : Confirmar=habilitado, Cancelar=habilitado
2055:     * VISUALIZAR: Confirmar=desabilitado, Cancelar=habilitado
2056:     *==========================================================================
2057:     PROTECTED PROCEDURE AjustarBotoesPorModo()
2058:         LOCAL loc_oPagina, loc_lEdicao
2059:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2060:         loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2061: 
2062:         TRY
2063:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEdicao
2064:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
2065:         CATCH TO loc_oErro
2066:             MsgErro("Erro em FormJrn.AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "Erro")
2067:         ENDTRY
2068:     ENDPROC
2069: 
2070:     *==========================================================================
2071:     * Destroy - Libera recursos do formulario
2072:     *==========================================================================
2073:     PROCEDURE Destroy()
2074:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2075:             THIS.this_oBusinessObject = .NULL.
2076:         ENDIF
2077:         IF USED("cursor_4c_Dados")
2078:             USE IN cursor_4c_Dados
2079:         ENDIF
2080:         IF USED("cursor_4c_Meses")
2081:             USE IN cursor_4c_Meses
2082:         ENDIF
2083:         IF USED("cursor_4c_BuscaCli")
2084:             USE IN cursor_4c_BuscaCli
2085:         ENDIF
2086:         DODEFAULT()
2087:     ENDPROC
2088: 
2089: ENDDEFINE


### BO (C:\4c\projeto\app\classes\JrnBO.prg):
*==============================================================================
* JrnBO.prg - Business Object para Cadastro de Jornadas (SigCdJrn)
* Herda de BusinessBase
* Tabela: SigCdJrn
* PK: pkchave (composto: refers + cargos_padded + iclis_padded)
*==============================================================================

DEFINE CLASS JrnBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da tabela SigCdJrn
    *--------------------------------------------------------------------------

    *-- Chave primaria composta (calculada)
    this_cPkChave    = ""  && pkchave  char - refers + cargos(0pad) + iclis(0pad)

    *-- Campos de identificacao do registro
    this_cRefers     = ""  && refers   char(6)  - periodo referencia (YYYYMM)
    this_cIclis      = ""  && iclis    char     - codigo do funcionario (FK SigCdCli)
    this_cCargos     = ""  && cargos   char     - codigo do cargo (FK SigCdCrg.ccargs)

    *-- Campo dias (string 7 chars: dom/seg/ter/qua/qui/sex/sab = 'X' ou ' ')
    this_cDias       = "       "  && dias  char(7)

    *-- Horarios (formato HH:MM)
    this_cHora01     = ""  && hora01  char(5) - inicio
    this_cHora02     = ""  && hora02  char(5) - inicio intervalo
    this_cHora03     = ""  && hora03  char(5) - fim intervalo
    this_cHora04     = ""  && hora04  char(5) - fim

    *-- Flags de dias da semana (computados de this_cDias)
    this_lDom        = .F.  && Domingo    (posicao 1 de dias)
    this_lSeg        = .F.  && Segunda    (posicao 2 de dias)
    this_lTer        = .F.  && Terca      (posicao 3 de dias)
    this_lQua        = .F.  && Quarta     (posicao 4 de dias)
    this_lQui        = .F.  && Quinta     (posicao 5 de dias)
    this_lSex        = .F.  && Sexta      (posicao 6 de dias)
    this_lSab        = .F.  && Sabado     (posicao 7 de dias)

    *-- Auditoria de criacao
    this_dDatas      = {}   && datas   datetime - data/hora de inclusao
    this_cUsuars     = ""   && usuars  char     - usuario que incluiu

    *-- Auditoria de alteracao
    this_dDtalts     = {}   && dtalts  datetime - data/hora da ultima alteracao
    this_cUsualts    = ""   && usualts char     - usuario da ultima alteracao

    *-- Descricao do funcionario (calculada via JOIN com SigCdCli)
    this_cDescri     = ""   && descri  char - rclis do funcionario (nao eh campo fisico)

    *--------------------------------------------------------------------------
    * Configuracao da classe
    *--------------------------------------------------------------------------

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdJrn"
        THIS.this_cCampoChave = "pkchave"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - retorna chave para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cPkChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * CalcularPkChave - constroi a PK composta a partir dos campos
    * refers(6) + cargos(substituindo espacos por "0") + iclis(idem)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CalcularPkChave()
        LOCAL loc_cPk
        loc_cPk = ALLTRIM(THIS.this_cRefers) + ;
                  STRTRAN(THIS.this_cCargos, " ", "0") + ;
                  STRTRAN(THIS.this_cIclis,  " ", "0")
        RETURN loc_cPk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConstruirDias - constroi string dias (7 chars) a partir dos flags logicos
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ConstruirDias()
        LOCAL loc_cDias
        loc_cDias = IIF(THIS.this_lDom, "X", " ") + ;
                    IIF(THIS.this_lSeg, "X", " ") + ;
                    IIF(THIS.this_lTer, "X", " ") + ;
                    IIF(THIS.this_lQua, "X", " ") + ;
                    IIF(THIS.this_lQui, "X", " ") + ;
                    IIF(THIS.this_lSex, "X", " ") + ;
                    IIF(THIS.this_lSab, "X", " ")
        RETURN loc_cDias
    ENDFUNC

    *--------------------------------------------------------------------------
    * ParsearDias - converte string dias para flags logicos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ParsearDias(par_cDias)
        LOCAL loc_cStr
        loc_cStr = PADR(NVL(par_cDias, "       "), 7)
        THIS.this_lDom = (SUBSTR(loc_cStr, 1, 1) == "X")
        THIS.this_lSeg = (SUBSTR(loc_cStr, 2, 1) == "X")
        THIS.this_lTer = (SUBSTR(loc_cStr, 3, 1) == "X")
        THIS.this_lQua = (SUBSTR(loc_cStr, 4, 1) == "X")
        THIS.this_lQui = (SUBSTR(loc_cStr, 5, 1) == "X")
        THIS.this_lSex = (SUBSTR(loc_cStr, 6, 1) == "X")
        THIS.this_lSab = (SUBSTR(loc_cStr, 7, 1) == "X")
        THIS.this_cDias = loc_cStr
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - carrega propriedades a partir de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cPkChave   = TratarNulo(pkchave, "C")
            THIS.this_cRefers    = TratarNulo(refers,  "C")
            THIS.this_cIclis     = TratarNulo(iclis,   "C")
            THIS.this_cCargos    = TratarNulo(cargos,  "C")
            THIS.this_cHora01    = TratarNulo(hora01,  "C")
            THIS.this_cHora02    = TratarNulo(hora02,  "C")
            THIS.this_cHora03    = TratarNulo(hora03,  "C")
            THIS.this_cHora04    = TratarNulo(hora04,  "C")
            THIS.this_dDatas     = TratarNulo(datas,   "D")
            THIS.this_cUsuars    = TratarNulo(usuars,  "C")
            THIS.this_dDtalts    = TratarNulo(dtalts,  "D")
            THIS.this_cUsualts   = TratarNulo(usualts, "C")
            THIS.ParsearDias(TratarNulo(dias, "C"))
            *-- descri eh calculado via JOIN - carrega se existir no cursor
            IF TYPE("descri") != "U"
                THIS.this_cDescri = TratarNulo(descri, "C")
            ENDIF
            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT geral com JOIN para descricao do funcionario
    * par_cFiltro: condicao WHERE adicional (sem a palavra WHERE)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = "SELECT a.pkchave, a.refers, a.iclis, a.cargos," + ;
                       " a.dias, a.hora01, a.hora02, a.hora03, a.hora04," + ;
                       " a.datas, a.usuars, a.dtalts, a.usualts," + ;
                       " ISNULL(b.rclis, '') AS descri," + ;
                       " SUBSTRING(a.dias,1,1) AS cDom," + ;
                       " CASE WHEN SUBSTRING(a.dias,1,1)='X' THEN 1 ELSE 0 END AS dom," + ;
                       " SUBSTRING(a.dias,2,1) AS cSeg," + ;
                       " CASE WHEN SUBSTRING(a.dias,2,1)='X' THEN 1 ELSE 0 END AS seg," + ;
                       " SUBSTRING(a.dias,3,1) AS cTer," + ;
                       " CASE WHEN SUBSTRING(a.dias,3,1)='X' THEN 1 ELSE 0 END AS ter," + ;
                       " SUBSTRING(a.dias,4,1) AS cQua," + ;
                       " CASE WHEN SUBSTRING(a.dias,4,1)='X' THEN 1 ELSE 0 END AS qua," + ;
                       " SUBSTRING(a.dias,5,1) AS cQui," + ;
                       " CASE WHEN SUBSTRING(a.dias,5,1)='X' THEN 1 ELSE 0 END AS qui," + ;
                       " SUBSTRING(a.dias,6,1) AS cSex," + ;
                       " CASE WHEN SUBSTRING(a.dias,6,1)='X' THEN 1 ELSE 0 END AS sex," + ;
                       " SUBSTRING(a.dias,7,1) AS cSab," + ;
                       " CASE WHEN SUBSTRING(a.dias,7,1)='X' THEN 1 ELSE 0 END AS sab" + ;
                       " FROM SigCdJrn a" + ;
                       " LEFT JOIN SigCdCli b ON b.iclis = a.iclis" + ;
                       loc_cWhere + ;
                       " ORDER BY a.pkchave"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar jornadas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - carrega registro pelo pkchave
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cPkChave)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.pkchave, a.refers, a.iclis, a.cargos," + ;
                       " a.dias, a.hora01, a.hora02, a.hora03, a.hora04," + ;
                       " a.datas, a.usuars, a.dtalts, a.usualts," + ;
                       " ISNULL(b.rclis, '') AS descri" + ;
                       " FROM SigCdJrn a" + ;
                       " LEFT JOIN SigCdCli b ON b.iclis = a.iclis" + ;
                       " WHERE a.pkchave = " + EscaparSQL(par_cPkChave)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ELSE
                IF loc_nResult <= 0
                    MsgErro("Erro ao carregar jornada:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdJrn
    * Constroi pkchave composto e registra auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cPkChave, loc_cDias
        loc_lSucesso = .F.

        TRY
            loc_cPkChave = THIS.CalcularPkChave()
            loc_cDias    = THIS.ConstruirDias()

            loc_cSQL = "INSERT INTO SigCdJrn" + ;
                       " (pkchave, refers, iclis, cargos, dias," + ;
                       "  hora01, hora02, hora03, hora04," + ;
                       "  datas, usuars)" + ;
                       " VALUES (" + ;
                       EscaparSQL(loc_cPkChave) + ", " + ;
                       EscaparSQL(THIS.this_cRefers) + ", " + ;
                       EscaparSQL(THIS.this_cIclis) + ", " + ;
                       EscaparSQL(THIS.this_cCargos) + ", " + ;
                       EscaparSQL(loc_cDias) + ", " + ;
                       EscaparSQL(THIS.this_cHora01) + ", " + ;
                       EscaparSQL(THIS.this_cHora02) + ", " + ;
                       EscaparSQL(THIS.this_cHora03) + ", " + ;
                       EscaparSQL(THIS.this_cHora04) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.this_cPkChave = loc_cPkChave
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao incluir jornada:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdJrn
    * Altera apenas: dias, refers, dtalts, usualts (conforme logica original)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cDias
        loc_lSucesso = .F.

        TRY
            loc_cDias = THIS.ConstruirDias()

            loc_cSQL = "UPDATE SigCdJrn SET" + ;
                       " refers  = " + EscaparSQL(THIS.this_cRefers) + "," + ;
                       " dias    = " + EscaparSQL(loc_cDias) + "," + ;
                       " hora01  = " + EscaparSQL(THIS.this_cHora01) + "," + ;
                       " hora02  = " + EscaparSQL(THIS.this_cHora02) + "," + ;
                       " hora03  = " + EscaparSQL(THIS.this_cHora03) + "," + ;
                       " hora04  = " + EscaparSQL(THIS.this_cHora04) + "," + ;
                       " dtalts  = GETDATE()," + ;
                       " usualts = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " WHERE pkchave = " + EscaparSQL(THIS.this_cPkChave)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao alterar jornada:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCdJrn
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdJrn" + ;
                       " WHERE pkchave = " + EscaparSQL(THIS.this_cPkChave)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir jornada:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CopiarParaMes - copia a jornada do registro atual para outro mes/ano
    * par_cAno:  ano destino (4 chars, ex: "2025")
    * par_cMes:  mes destino (2 chars, ex: "03")
    * Retorna .T. se copiou com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CopiarParaMes(par_cAno, par_cMes)
        LOCAL loc_cNovoRefers, loc_cNovoPk, loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cAno)) OR EMPTY(ALLTRIM(par_cMes))
                MsgErro("Ano e m" + CHR(234) + "s s" + CHR(227) + "o obrigat" + ;
                        CHR(243) + "rios para copiar jornada.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            loc_cNovoRefers = ALLTRIM(par_cAno) + ALLTRIM(par_cMes)
            loc_cNovoPk     = loc_cNovoRefers + ;
                              STRTRAN(THIS.this_cCargos, " ", "0") + ;
                              STRTRAN(THIS.this_cIclis,  " ", "0")

            *-- Verifica se ja existe registro para o mes destino
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdJrn WHERE pkchave = " + ;
                       EscaparSQL(loc_cNovoPk)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCopia") > 0
                SELECT cursor_4c_ChkCopia
                IF cursor_4c_ChkCopia.qtd > 0
                    *-- Registro existente: UPDATE
                    loc_cSQL = "UPDATE SigCdJrn SET" + ;
                               " refers  = " + EscaparSQL(loc_cNovoRefers) + "," + ;
                               " dias    = " + EscaparSQL(THIS.ConstruirDias()) + "," + ;
                               " hora01  = " + EscaparSQL(THIS.this_cHora01) + "," + ;
                               " hora02  = " + EscaparSQL(THIS.this_cHora02) + "," + ;
                               " hora03  = " + EscaparSQL(THIS.this_cHora03) + "," + ;
                               " hora04  = " + EscaparSQL(THIS.this_cHora04) + "," + ;
                               " dtalts  = GETDATE()," + ;
                               " usualts = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                               " WHERE pkchave = " + EscaparSQL(loc_cNovoPk)
                ELSE
                    *-- Registro novo: INSERT
                    loc_cSQL = "INSERT INTO SigCdJrn" + ;
                               " (pkchave, refers, iclis, cargos, dias," + ;
                               "  hora01, hora02, hora03, hora04," + ;
                               "  datas, usuars)" + ;
                               " VALUES (" + ;
                               EscaparSQL(loc_cNovoPk) + ", " + ;
                               EscaparSQL(loc_cNovoRefers) + ", " + ;
                               EscaparSQL(THIS.this_cIclis) + ", " + ;
                               EscaparSQL(THIS.this_cCargos) + ", " + ;
                               EscaparSQL(THIS.ConstruirDias()) + ", " + ;
                               EscaparSQL(THIS.this_cHora01) + ", " + ;
                               EscaparSQL(THIS.this_cHora02) + ", " + ;
                               EscaparSQL(THIS.this_cHora03) + ", " + ;
                               EscaparSQL(THIS.this_cHora04) + ", " + ;
                               "GETDATE(), " + ;
                               EscaparSQL(gc_4c_UsuarioLogado) + ")"
                ENDIF
                USE IN cursor_4c_ChkCopia
            ELSE
                MsgErro("Erro ao verificar registro destino:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                IF USED("cursor_4c_ChkCopia")
                    USE IN cursor_4c_ChkCopia
                ENDIF
                loc_lSucesso = .F.
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao copiar jornada:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.CopiarParaMes:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ChkCopia")
                USE IN cursor_4c_ChkCopia
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarMesesDisponiveis - retorna cursor com meses existentes para
    * funcionario/cargo especificados (para o painel Copiar Mes)
    * par_cIclis:  codigo do funcionario (pode ser vazio = todos)
    * par_cCargos: codigo do cargo (pode ser vazio = todos)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarMesesDisponiveis(par_cIclis, par_cCargos)
        LOCAL loc_cSQL, loc_cWhere, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Meses")
                USE IN cursor_4c_Meses
            ENDIF

            loc_cWhere = " WHERE (iclis = " + EscaparSQL(par_cIclis) + ;
                         " OR " + EscaparSQL(par_cIclis) + " = '')" + ;
                         " AND (cargos = " + EscaparSQL(par_cCargos) + ;
                         " OR " + EscaparSQL(par_cCargos) + " = '')"

            loc_cSQL = "SELECT refers FROM SigCdJrn" + ;
                       loc_cWhere + ;
                       " ORDER BY refers ASC"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Meses")

            IF loc_nResult > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar meses:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.BuscarMesesDisponiveis:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - valida campos obrigatorios antes de salvar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cRefers))
            MsgErro("Refer" + CHR(234) + "ncia (Ano/M" + CHR(234) + "s) " + ;
                    CHR(233) + " obrigat" + CHR(243) + "ria.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cIclis)) AND EMPTY(ALLTRIM(THIS.this_cCargos))
            MsgAviso("Informe o Funcion" + CHR(225) + "rio ou o Cargo.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido
            IF EMPTY(ALLTRIM(THIS.this_cHora01)) OR EMPTY(ALLTRIM(THIS.this_cHora02)) OR ;
               EMPTY(ALLTRIM(THIS.this_cHora03)) OR EMPTY(ALLTRIM(THIS.this_cHora04))
                MsgAviso("Aten" + CHR(231) + CHR(227) + "o!! Todos os hor" + CHR(225) + ;
                        "rios devem ser preenchidos.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - limpeza de cursores
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF
        IF USED("cursor_4c_Meses")
            USE IN cursor_4c_Meses
        ENDIF
        IF USED("cursor_4c_ChkCopia")
            USE IN cursor_4c_ChkCopia
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

