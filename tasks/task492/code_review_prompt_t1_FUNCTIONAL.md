# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (13)
- [BINDEVENT-PARAMS] Handler 'ValidarDiasVcto' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDiasVcto(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarMoeda' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarMoeda(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarGrpCad1s' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGrpCad1s(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarGrpCad2s' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGrpCad2s(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarGrpCad3s' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGrpCad3s(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarGrpCad4s' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGrpCad4s(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarClass1s' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarClass1s(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarClass2s' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarClass2s(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarClass3s' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarClass3s(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarClass4s' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarClass4s(par_nKeyCode, par_nShiftAltCtrl)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Dados' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [LAYOUT-POSITION] Controle 'Opt_CampoNf' (parent: SIGCDOTI.Pagina.Dados): Left original=136 vs migrado 'obj_4c_Opt_CampoNf' Left=683 (diff=547px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnPastasC' (parent: SIGCDOTI.Pagina.Dados): Left original=538 vs migrado 'cmd_4c_BtnPastasCl' Left=723 (diff=185px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormOTI.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (4395 linhas total):

*-- Linhas 23 a 145:
23:     this_cModoAtual      = "LISTA"
24: 
25:     *==========================================================================
26:     PROCEDURE Init()
27:     *==========================================================================
28:         LOCAL loc_lResultado
29:         loc_lResultado = .F.
30: 
31:         TRY
32:             loc_lResultado = DODEFAULT()
33:         CATCH TO loc_oErro
34:             MsgErro(loc_oErro.Message, "FormOTI.Init")
35:         ENDTRY
36: 
37:         RETURN loc_lResultado
38:     ENDPROC
39: 
40:     *==========================================================================
41:     PROTECTED PROCEDURE InicializarForm()
42:     *==========================================================================
43:         LOCAL loc_lResultado
44:         loc_lResultado = .F.
45: 
46:         TRY
47:             THIS.Caption = "Opera" + CHR(231) + CHR(245) + "es de T" + CHR(237) + "tulos"
48: 
49:             THIS.this_oBusinessObject = CREATEOBJECT("OTIBO")
50: 
51:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
52:                 MsgErro("Erro ao instanciar OTIBO.", "FormOTI")
53:             ELSE
54:                 THIS.ConfigurarPageFrame()
55:                 THIS.ConfigurarPaginaLista()
56:                 THIS.ConfigurarPaginaDados()
57: 
58:                 IF TYPE("gb_4c_ValidandoUI") # "L" OR !gb_4c_ValidandoUI
59:                     THIS.CarregarLista()
60:                 ENDIF
61: 
62:                 THIS.pgf_4c_Paginas.Visible = .T.
63:                 THIS.pgf_4c_Paginas.ActivePage = 1
64:                 THIS.this_cModoAtual = "LISTA"
65:                 loc_lResultado = .T.
66:             ENDIF
67: 
68:         CATCH TO loc_oErro
69:             MsgErro(loc_oErro.Message, "FormOTI.InicializarForm")
70:             loc_lResultado = .F.
71:         ENDTRY
72: 
73:         RETURN loc_lResultado
74:     ENDPROC
75: 
76:     *==========================================================================
77:     PROTECTED PROCEDURE ConfigurarPageFrame()
78:     *==========================================================================
79:         LOCAL loc_oPgf
80: 
81:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
82:         loc_oPgf = THIS.pgf_4c_Paginas
83: 
84:         loc_oPgf.PageCount = 2
85:         loc_oPgf.Top       = -29
86:         loc_oPgf.Left      = 0
87:         loc_oPgf.Width     = THIS.Width
88:         loc_oPgf.Height    = THIS.Height
89:         loc_oPgf.Tabs      = .F.
90:         loc_oPgf.TabStyle  = 0
91:         loc_oPgf.Visible   = .T.
92: 
93:         WITH loc_oPgf.Page1
94:             .Caption = "Lista"
95:             .Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
96:         ENDWITH
97: 
98:         WITH loc_oPgf.Page2
99:             .Caption = "Dados"
100:             .Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101:         ENDWITH
102:     ENDPROC
103: 
104:     *==========================================================================
105:     PROTECTED PROCEDURE ConfigurarPaginaLista()
106:     *==========================================================================
107:         LOCAL loc_oPagina, loc_oCab, loc_oCnt, loc_oGrid
108: 
109:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
110: 
111:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
112:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
113: 
114:         *-- Container cabecalho
115:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
116:         loc_oCab = loc_oPagina.cnt_4c_Cabecalho
117:         WITH loc_oCab
118:             .Top         = 31
119:             .Left        = 0
120:             .Width       = THIS.Width
121:             .Height      = 80
122:             .BackColor   = RGB(100, 100, 100)
123:             .BorderWidth = 0
124:             .Visible     = .T.
125:         ENDWITH
126: 
127:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
128:         WITH loc_oCab.lbl_4c_Sombra
129:             .Top       = 16
130:             .Left      = 11
131:             .Width     = 869
132:             .Height    = 46
133:             .Caption   = THIS.Caption
134:             .FontName  = "Tahoma"
135:             .FontSize  = 16
136:             .FontBold  = .T.
137:             .ForeColor = RGB(0, 0, 0)
138:             .BackStyle = 0
139:             .Alignment = 0
140:             .Visible   = .T.
141:         ENDWITH
142: 
143:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
144:         WITH loc_oCab.lbl_4c_Titulo
145:             .Top       = 15

*-- Linhas 192 a 367:
192:             .AutoSize        = .F.
193:             .Visible         = .T.
194:         ENDWITH
195:         BINDEVENT(loc_oCnt.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
196: 
197:         loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
198:         WITH loc_oCnt.cmd_4c_Visualizar
199:             .Caption         = "Visualizar"
200:             .Top             = 5
201:             .Left            = 80
202:             .Width           = 75
203:             .Height          = 75
204:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
205:             .PicturePosition = 13
206:             .FontName        = "Comic Sans MS"
207:             .FontSize        = 8
208:             .FontBold        = .T.
209:             .FontItalic      = .T.
210:             .ForeColor       = RGB(90, 90, 90)
211:             .BackColor       = RGB(255, 255, 255)
212:             .Themes          = .F.
213:             .SpecialEffect   = 0
214:             .MousePointer    = 15
215:             .WordWrap        = .T.
216:             .AutoSize        = .F.
217:             .Visible         = .T.
218:         ENDWITH
219:         BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
220: 
221:         loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
222:         WITH loc_oCnt.cmd_4c_Alterar
223:             .Caption         = "Alterar"
224:             .Top             = 5
225:             .Left            = 155
226:             .Width           = 75
227:             .Height          = 75
228:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
229:             .PicturePosition = 13
230:             .FontName        = "Comic Sans MS"
231:             .FontSize        = 8
232:             .FontBold        = .T.
233:             .FontItalic      = .T.
234:             .ForeColor       = RGB(90, 90, 90)
235:             .BackColor       = RGB(255, 255, 255)
236:             .Themes          = .F.
237:             .SpecialEffect   = 0
238:             .MousePointer    = 15
239:             .WordWrap        = .T.
240:             .AutoSize        = .F.
241:             .Visible         = .T.
242:         ENDWITH
243:         BINDEVENT(loc_oCnt.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
244: 
245:         loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
246:         WITH loc_oCnt.cmd_4c_Excluir
247:             .Caption         = "Excluir"
248:             .Top             = 5
249:             .Left            = 230
250:             .Width           = 75
251:             .Height          = 75
252:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
253:             .PicturePosition = 13
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
264:             .AutoSize        = .F.
265:             .Visible         = .T.
266:         ENDWITH
267:         BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
268: 
269:         loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
270:         WITH loc_oCnt.cmd_4c_Buscar
271:             .Caption         = "Buscar"
272:             .Top             = 5
273:             .Left            = 305
274:             .Width           = 75
275:             .Height          = 75
276:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
277:             .PicturePosition = 13
278:             .FontName        = "Comic Sans MS"
279:             .FontSize        = 8
280:             .FontBold        = .T.
281:             .FontItalic      = .T.
282:             .ForeColor       = RGB(90, 90, 90)
283:             .BackColor       = RGB(255, 255, 255)
284:             .Themes          = .F.
285:             .SpecialEffect   = 0
286:             .MousePointer    = 15
287:             .WordWrap        = .T.
288:             .AutoSize        = .F.
289:             .Visible         = .T.
290:         ENDWITH
291:         BINDEVENT(loc_oCnt.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
292: 
293:         *-- Container saida (padrao canonico)
294:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
295:         WITH loc_oPagina.cnt_4c_Saida
296:             .Top         = 29
297:             .Left        = 917
298:             .Width       = 90
299:             .Height      = 85
300:             .BackStyle   = 0
301:             .BorderWidth = 0
302:             .Visible     = .T.
303:         ENDWITH
304: 
305:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
306:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
307:             .Caption         = "Encerrar"
308:             .Top             = 5
309:             .Left            = 5
310:             .Width           = 75
311:             .Height          = 75
312:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
313:             .PicturePosition = 13
314:             .FontName        = "Comic Sans MS"
315:             .FontSize        = 8
316:             .FontBold        = .T.
317:             .FontItalic      = .T.
318:             .ForeColor       = RGB(90, 90, 90)
319:             .BackColor       = RGB(255, 255, 255)
320:             .Themes          = .F.
321:             .SpecialEffect   = 0
322:             .MousePointer    = 15
323:             .WordWrap        = .T.
324:             .AutoSize        = .F.
325:             .Visible         = .T.
326:         ENDWITH
327:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
328: 
329:         *-- Grid de listagem
330:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
331:         loc_oGrid = loc_oPagina.grd_4c_Lista
332:         loc_oGrid.Top         = 117
333:         loc_oGrid.Left        = 12
334:         loc_oGrid.Width       = 895
335:         loc_oGrid.Height      = 483
336:         loc_oGrid.ColumnCount = 3
337:         WITH loc_oGrid
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
351:             .ReadOnly           = .T.
352:             .Visible            = .T.
353:         ENDWITH
354: 
355:         WITH loc_oGrid.Column1
356:             .Width           = 60
357:             .Alignment       = 0
358:             .Header1.Caption = "N" + CHR(186)
359:             .Resizable       = .T.
360:         ENDWITH
361: 
362:         WITH loc_oGrid.Column2
363:             .Width           = 250
364:             .Alignment       = 0
365:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
366:             .Resizable       = .T.
367:         ENDWITH

*-- Linhas 373 a 580:
373:             .Resizable       = .T.
374:         ENDWITH
375: 
376:         THIS.TornarControlesVisiveis(loc_oPagina)
377:     ENDPROC
378: 
379:     *==========================================================================
380:     PROTECTED PROCEDURE ConfigurarPaginaDados()
381:     *==========================================================================
382:         LOCAL loc_oPagina
383: 
384:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
385: 
386:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
387:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
388: 
389:         *----------------------------------------------------------------------
390:         *-- Container bot" + CHR(245) + "es Confirmar / Cancelar
391:         *----------------------------------------------------------------------
392:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
393:         WITH loc_oPagina.cnt_4c_BotoesAcao
394:             .Top         = 33
395:             .Left        = 842
396:             .Width       = 160
397:             .Height      = 85
398:             .BackStyle   = 0
399:             .BorderWidth = 0
400:             .Visible     = .T.
401:         ENDWITH
402: 
403:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
404:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
405:             .Caption         = "Confirmar"
406:             .Top             = 5
407:             .Left            = 5
408:             .Width           = 75
409:             .Height          = 75
410:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
411:             .PicturePosition = 13
412:             .FontName        = "Comic Sans MS"
413:             .FontSize        = 8
414:             .FontBold        = .T.
415:             .FontItalic      = .T.
416:             .ForeColor       = RGB(90, 90, 90)
417:             .BackColor       = RGB(255, 255, 255)
418:             .Themes          = .F.
419:             .SpecialEffect   = 0
420:             .MousePointer    = 15
421:             .WordWrap        = .T.
422:             .AutoSize        = .F.
423:             .Visible         = .T.
424:         ENDWITH
425:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
426: 
427:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
428:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
429:             .Caption         = "Encerrar"
430:             .Top             = 5
431:             .Left            = 80
432:             .Width           = 75
433:             .Height          = 75
434:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
435:             .PicturePosition = 13
436:             .FontName        = "Comic Sans MS"
437:             .FontSize        = 8
438:             .FontBold        = .T.
439:             .FontItalic      = .T.
440:             .ForeColor       = RGB(90, 90, 90)
441:             .BackColor       = RGB(255, 255, 255)
442:             .Themes          = .F.
443:             .SpecialEffect   = 0
444:             .MousePointer    = 15
445:             .WordWrap        = .T.
446:             .AutoSize        = .F.
447:             .Visible         = .T.
448:         ENDWITH
449:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
450: 
451:         *----------------------------------------------------------------------
452:         *-- Linha 1: N" + CHR(186) + " Opera" + CHR(231) + CHR(227) + "o (readonly) + Descri" + CHR(231) + CHR(227) + "o + Cancelamento
453:         *----------------------------------------------------------------------
454: 
455:         loc_oPagina.AddObject("txt_4c_Ndope", "TextBox")
456:         WITH loc_oPagina.txt_4c_Ndope
457:             .Value    = 0
458:             .Top      = 65
459:             .Left     = 688
460:             .Width    = 80
461:             .Height   = 23
462:             .ReadOnly = .T.
463:             .Enabled  = .T.
464:             .FontName = "Tahoma"
465:             .FontSize = 8
466:             .Visible  = .T.
467:         ENDWITH
468: 
469:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
470:         WITH loc_oPagina.lbl_4c_Label3
471:             .Caption   = "N" + CHR(186) + " Opera" + CHR(231) + CHR(227) + "o :"
472:             .Top       = 69
473:             .Left      = 605
474:             .Width     = 80
475:             .Height    = 15
476:             .FontName  = "Tahoma"
477:             .FontSize  = 8
478:             .BackStyle = 0
479:             .Visible   = .T.
480:         ENDWITH
481: 
482:         loc_oPagina.AddObject("chk_4c_Chk_Inativar", "CheckBox")
483:         WITH loc_oPagina.chk_4c_Chk_Inativar
484:             .Caption   = "Cancelamento"
485:             .Top       = 70
486:             .Left      = 298
487:             .Width     = 99
488:             .Height    = 15
489:             .Value     = 0
490:             .FontName  = "Tahoma"
491:             .FontSize  = 8
492:             .BackStyle = 0
493:             .Visible   = .T.
494:         ENDWITH
495:         BINDEVENT(loc_oPagina.chk_4c_Chk_Inativar, "InteractiveChange", THIS, "ChkInativarChanged")
496: 
497:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
498:         WITH loc_oPagina.lbl_4c_Label1
499:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
500:             .Top       = 71
501:             .Left      = 73
502:             .Width     = 63
503:             .Height    = 15
504:             .FontName  = "Tahoma"
505:             .FontSize  = 8
506:             .BackStyle = 0
507:             .Visible   = .T.
508:         ENDWITH
509: 
510:         loc_oPagina.AddObject("txt_4c_Dope", "TextBox")
511:         WITH loc_oPagina.txt_4c_Dope
512:             .Value     = ""
513:             .Top       = 67
514:             .Left      = 140
515:             .Width     = 150
516:             .Height    = 23
517:             .MaxLength = 50
518:             .FontName  = "Tahoma"
519:             .FontSize  = 8
520:             .Visible   = .T.
521:         ENDWITH
522: 
523:         *----------------------------------------------------------------------
524:         *-- Linha 2: Opera" + CHR(231) + CHR(227) + "o CR/DB + Opera" + CHR(231) + CHR(227) + "o de Dep" + CHR(243) + "sito
525:         *----------------------------------------------------------------------
526: 
527:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
528:         WITH loc_oPagina.lbl_4c_Label2
529:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
530:             .Top       = 93
531:             .Left      = 77
532:             .Width     = 59
533:             .Height    = 15
534:             .FontName  = "Tahoma"
535:             .FontSize  = 8
536:             .BackStyle = 0
537:             .Visible   = .T.
538:         ENDWITH
539: 
540:         loc_oPagina.AddObject("obj_4c_Opcao_oper", "OptionGroup")
541:         WITH loc_oPagina.obj_4c_Opcao_oper
542:             .ButtonCount = 2
543:             .Top         = 90
544:             .Left        = 135
545:             .Width       = 142
546:             .Height      = 21
547:             .BackStyle   = 0
548:             .BorderStyle = 0
549:             .Visible     = .T.
550:         ENDWITH
551:         WITH loc_oPagina.obj_4c_Opcao_oper.Buttons(1)
552:             .Caption   = "Cr" + CHR(233) + "dito"
553:             .BackStyle = 0
554:             .Left      = 5
555:             .Top       = 3
556:             .Width     = 62
557:             .AutoSize  = .F.
558:             .ForeColor = RGB(90, 90, 90)
559:             .FontName  = "Tahoma"
560:             .FontSize  = 8
561:         ENDWITH
562:         WITH loc_oPagina.obj_4c_Opcao_oper.Buttons(2)
563:             .Caption   = "D" + CHR(233) + "bito"
564:             .BackStyle = 0
565:             .Left      = 70
566:             .Top       = 3
567:             .Width     = 62
568:             .AutoSize  = .F.
569:             .ForeColor = RGB(90, 90, 90)
570:             .FontName  = "Tahoma"
571:             .FontSize  = 8
572:         ENDWITH
573: 
574:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
575:         WITH loc_oPagina.lbl_4c_Label4
576:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o de Dep" + CHR(243) + "sito :"
577:             .Top       = 94
578:             .Left      = 567
579:             .Width     = 116
580:             .Height    = 15

*-- Linhas 596 a 684:
596:             .FontSize  = 8
597:             .Visible   = .T.
598:         ENDWITH
599:         BINDEVENT(loc_oPagina.txt_4c_Opdepo, "KeyPress", THIS, "ValidarOpdepo")
600: 
601:         *----------------------------------------------------------------------
602:         *-- Linha 3: Hist" + CHR(243) + "rico Padr" + CHR(227) + "o + Pend" + CHR(234) + "ncias
603:         *----------------------------------------------------------------------
604: 
605:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
606:         WITH loc_oPagina.lbl_4c_Label5
607:             .Caption   = "Hist" + CHR(243) + "rico Padr" + CHR(227) + "o :"
608:             .Top       = 113
609:             .Left      = 49
610:             .Width     = 87
611:             .Height    = 15
612:             .FontName  = "Tahoma"
613:             .FontSize  = 8
614:             .BackStyle = 0
615:             .Visible   = .T.
616:         ENDWITH
617: 
618:         loc_oPagina.AddObject("txt_4c_Hists", "TextBox")
619:         WITH loc_oPagina.txt_4c_Hists
620:             .Value     = ""
621:             .Top       = 109
622:             .Left      = 140
623:             .Width     = 223
624:             .Height    = 23
625:             .MaxLength = 100
626:             .FontName  = "Tahoma"
627:             .FontSize  = 8
628:             .Visible   = .T.
629:         ENDWITH
630: 
631:         loc_oPagina.AddObject("lbl_4c_Label24", "Label")
632:         WITH loc_oPagina.lbl_4c_Label24
633:             .Caption   = "Pend" + CHR(234) + "ncias :"
634:             .Top       = 116
635:             .Left      = 622
636:             .Width     = 61
637:             .Height    = 15
638:             .FontName  = "Tahoma"
639:             .FontSize  = 8
640:             .BackStyle = 0
641:             .Visible   = .T.
642:         ENDWITH
643: 
644:         loc_oPagina.AddObject("obj_4c_Opc_Pend", "OptionGroup")
645:         WITH loc_oPagina.obj_4c_Opc_Pend
646:             .ButtonCount = 2
647:             .Top         = 113
648:             .Left        = 683
649:             .Width       = 128
650:             .Height      = 21
651:             .BackStyle   = 0
652:             .BorderStyle = 0
653:             .Visible     = .T.
654:         ENDWITH
655:         WITH loc_oPagina.obj_4c_Opc_Pend.Buttons(1)
656:             .Caption   = "Sim"
657:             .BackStyle = 0
658:             .Left      = 5
659:             .Top       = 3
660:             .Width     = 55
661:             .AutoSize  = .F.
662:             .ForeColor = RGB(90, 90, 90)
663:             .FontName  = "Tahoma"
664:             .FontSize  = 8
665:         ENDWITH
666:         WITH loc_oPagina.obj_4c_Opc_Pend.Buttons(2)
667:             .Caption   = "N" + CHR(227) + "o"
668:             .BackStyle = 0
669:             .Left      = 63
670:             .Top       = 3
671:             .Width     = 55
672:             .AutoSize  = .F.
673:             .ForeColor = RGB(90, 90, 90)
674:             .FontName  = "Tahoma"
675:             .FontSize  = 8
676:         ENDWITH
677: 
678:         *----------------------------------------------------------------------
679:         *-- Linha 4: Valor Previsto + Complemento Hist" + CHR(243) + "rico (5 op" + CHR(231) + CHR(245) + "es)
680:         *----------------------------------------------------------------------
681: 
682:         loc_oPagina.AddObject("lbl_4c_Label19", "Label")
683:         WITH loc_oPagina.lbl_4c_Label19
684:             .Caption   = "Valor Previsto :"

*-- Linhas 692 a 782:
692:             .Visible   = .T.
693:         ENDWITH
694: 
695:         loc_oPagina.AddObject("obj_4c_Opc_valprev", "OptionGroup")
696:         WITH loc_oPagina.obj_4c_Opc_valprev
697:             .ButtonCount = 2
698:             .Top         = 129
699:             .Left        = 683
700:             .Width       = 128
701:             .Height      = 21
702:             .BackStyle   = 0
703:             .BorderStyle = 0
704:             .Visible     = .T.
705:         ENDWITH
706:         WITH loc_oPagina.obj_4c_Opc_valprev.Buttons(1)
707:             .Caption   = "Sim"
708:             .BackStyle = 0
709:             .Left      = 5
710:             .Top       = 3
711:             .Width     = 55
712:             .AutoSize  = .F.
713:             .ForeColor = RGB(90, 90, 90)
714:             .FontName  = "Tahoma"
715:             .FontSize  = 8
716:         ENDWITH
717:         WITH loc_oPagina.obj_4c_Opc_valprev.Buttons(2)
718:             .Caption   = "N" + CHR(227) + "o"
719:             .BackStyle = 0
720:             .Left      = 63
721:             .Top       = 3
722:             .Width     = 55
723:             .AutoSize  = .F.
724:             .ForeColor = RGB(90, 90, 90)
725:             .FontName  = "Tahoma"
726:             .FontSize  = 8
727:         ENDWITH
728: 
729:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
730:         WITH loc_oPagina.lbl_4c_Label6
731:             .Caption   = "Compl. Hist" + CHR(243) + "rico :"
732:             .Top       = 137
733:             .Left      = 50
734:             .Width     = 86
735:             .Height    = 15
736:             .FontName  = "Tahoma"
737:             .FontSize  = 8
738:             .BackStyle = 0
739:             .Visible   = .T.
740:         ENDWITH
741: 
742:         loc_oPagina.AddObject("obj_4c_Opc_Compl", "OptionGroup")
743:         WITH loc_oPagina.obj_4c_Opc_Compl
744:             .ButtonCount = 5
745:             .Top         = 134
746:             .Left        = 135
747:             .Width       = 206
748:             .Height      = 53
749:             .BackStyle   = 0
750:             .BorderStyle = 0
751:             .Visible     = .T.
752:         ENDWITH
753:         WITH loc_oPagina.obj_4c_Opc_Compl.Buttons(1)
754:             .Caption   = "Nenhum"
755:             .BackStyle = 0
756:             .Left      = 5
757:             .Top       = 3
758:             .Width     = 75
759:             .AutoSize  = .F.
760:             .ForeColor = RGB(90, 90, 90)
761:             .FontName  = "Tahoma"
762:             .FontSize  = 8
763:         ENDWITH
764:         WITH loc_oPagina.obj_4c_Opc_Compl.Buttons(2)
765:             .Caption   = "Emitente"
766:             .BackStyle = 0
767:             .Left      = 5
768:             .Top       = 28
769:             .Width     = 75
770:             .AutoSize  = .F.
771:             .ForeColor = RGB(90, 90, 90)
772:             .FontName  = "Tahoma"
773:             .FontSize  = 8
774:         ENDWITH
775:         WITH loc_oPagina.obj_4c_Opc_Compl.Buttons(3)
776:             .Caption   = "Portador"
777:             .BackStyle = 0
778:             .Left      = 83
779:             .Top       = 3
780:             .Width     = 75
781:             .AutoSize  = .F.
782:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 823 a 866:
823:             .Visible   = .T.
824:         ENDWITH
825: 
826:         loc_oPagina.AddObject("obj_4c_Opc_blqcc", "OptionGroup")
827:         WITH loc_oPagina.obj_4c_Opc_blqcc
828:             .ButtonCount = 2
829:             .Top         = 146
830:             .Left        = 683
831:             .Width       = 128
832:             .Height      = 21
833:             .BackStyle   = 0
834:             .BorderStyle = 0
835:             .Visible     = .T.
836:         ENDWITH
837:         WITH loc_oPagina.obj_4c_Opc_blqcc.Buttons(1)
838:             .Caption   = "Sim"
839:             .BackStyle = 0
840:             .Left      = 5
841:             .Top       = 3
842:             .Width     = 55
843:             .AutoSize  = .F.
844:             .ForeColor = RGB(90, 90, 90)
845:             .FontName  = "Tahoma"
846:             .FontSize  = 8
847:         ENDWITH
848:         WITH loc_oPagina.obj_4c_Opc_blqcc.Buttons(2)
849:             .Caption   = "N" + CHR(227) + "o"
850:             .BackStyle = 0
851:             .Left      = 63
852:             .Top       = 3
853:             .Width     = 55
854:             .AutoSize  = .F.
855:             .ForeColor = RGB(90, 90, 90)
856:             .FontName  = "Tahoma"
857:             .FontSize  = 8
858:         ENDWITH
859: 
860:         *----------------------------------------------------------------------
861:         *-- Linha 6: Realizar Apenas Autorizados
862:         *----------------------------------------------------------------------
863: 
864:         loc_oPagina.AddObject("lbl_4c_Label27", "Label")
865:         WITH loc_oPagina.lbl_4c_Label27
866:             .Caption   = "Realizar Apenas Autorizados :"

*-- Linhas 874 a 917:
874:             .Visible   = .T.
875:         ENDWITH
876: 
877:         loc_oPagina.AddObject("obj_4c_Opc_Transporte", "OptionGroup")
878:         WITH loc_oPagina.obj_4c_Opc_Transporte
879:             .ButtonCount = 2
880:             .Top         = 162
881:             .Left        = 683
882:             .Width       = 128
883:             .Height      = 21
884:             .BackStyle   = 0
885:             .BorderStyle = 0
886:             .Visible     = .T.
887:         ENDWITH
888:         WITH loc_oPagina.obj_4c_Opc_Transporte.Buttons(1)
889:             .Caption   = "Sim"
890:             .BackStyle = 0
891:             .Left      = 5
892:             .Top       = 3
893:             .Width     = 55
894:             .AutoSize  = .F.
895:             .ForeColor = RGB(90, 90, 90)
896:             .FontName  = "Tahoma"
897:             .FontSize  = 8
898:         ENDWITH
899:         WITH loc_oPagina.obj_4c_Opc_Transporte.Buttons(2)
900:             .Caption   = "N" + CHR(227) + "o"
901:             .BackStyle = 0
902:             .Left      = 63
903:             .Top       = 3
904:             .Width     = 55
905:             .AutoSize  = .F.
906:             .ForeColor = RGB(90, 90, 90)
907:             .FontName  = "Tahoma"
908:             .FontSize  = 8
909:         ENDWITH
910: 
911:         *----------------------------------------------------------------------
912:         *-- Linha 7: Outros T" + CHR(237) + "tulos Auto + Identificador + N" + CHR(186) + " T" + CHR(237) + "tulo Autom" + CHR(225) + "tico
913:         *----------------------------------------------------------------------
914: 
915:         loc_oPagina.AddObject("lbl_4c_Label31", "Label")
916:         WITH loc_oPagina.lbl_4c_Label31
917:             .Caption   = "Outros Titulos (Auto) :"

*-- Linhas 925 a 1015:
925:             .Visible   = .T.
926:         ENDWITH
927: 
928:         loc_oPagina.AddObject("obj_4c_Get_OutroTit", "OptionGroup")
929:         WITH loc_oPagina.obj_4c_Get_OutroTit
930:             .ButtonCount = 2
931:             .Top         = 179
932:             .Left        = 683
933:             .Width       = 128
934:             .Height      = 21
935:             .BackStyle   = 0
936:             .BorderStyle = 0
937:             .Visible     = .T.
938:         ENDWITH
939:         WITH loc_oPagina.obj_4c_Get_OutroTit.Buttons(1)
940:             .Caption   = "Sim"
941:             .BackStyle = 0
942:             .Left      = 5
943:             .Top       = 3
944:             .Width     = 55
945:             .AutoSize  = .F.
946:             .ForeColor = RGB(90, 90, 90)
947:             .FontName  = "Tahoma"
948:             .FontSize  = 8
949:         ENDWITH
950:         WITH loc_oPagina.obj_4c_Get_OutroTit.Buttons(2)
951:             .Caption   = "N" + CHR(227) + "o"
952:             .BackStyle = 0
953:             .Left      = 63
954:             .Top       = 3
955:             .Width     = 55
956:             .AutoSize  = .F.
957:             .ForeColor = RGB(90, 90, 90)
958:             .FontName  = "Tahoma"
959:             .FontSize  = 8
960:         ENDWITH
961: 
962:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
963:         WITH loc_oPagina.lbl_4c_Label7
964:             .Caption   = "N" + CHR(186) + " titulo autom" + CHR(225) + "tico :"
965:             .Top       = 188
966:             .Left      = 32
967:             .Width     = 104
968:             .Height    = 15
969:             .FontName  = "Tahoma"
970:             .FontSize  = 8
971:             .BackStyle = 0
972:             .Visible   = .T.
973:         ENDWITH
974: 
975:         loc_oPagina.AddObject("obj_4c_Opc_Numtit", "OptionGroup")
976:         WITH loc_oPagina.obj_4c_Opc_Numtit
977:             .ButtonCount = 2
978:             .Top         = 185
979:             .Left        = 135
980:             .Width       = 110
981:             .Height      = 21
982:             .BackStyle   = 0
983:             .BorderStyle = 0
984:             .Visible     = .T.
985:         ENDWITH
986:         WITH loc_oPagina.obj_4c_Opc_Numtit.Buttons(1)
987:             .Caption   = "Sim"
988:             .BackStyle = 0
989:             .Left      = 5
990:             .Top       = 3
991:             .Width     = 46
992:             .AutoSize  = .F.
993:             .ForeColor = RGB(90, 90, 90)
994:             .FontName  = "Tahoma"
995:             .FontSize  = 8
996:         ENDWITH
997:         WITH loc_oPagina.obj_4c_Opc_Numtit.Buttons(2)
998:             .Caption   = "N" + CHR(227) + "o"
999:             .BackStyle = 0
1000:             .Left      = 54
1001:             .Top       = 3
1002:             .Width     = 46
1003:             .AutoSize  = .F.
1004:             .ForeColor = RGB(90, 90, 90)
1005:             .FontName  = "Tahoma"
1006:             .FontSize  = 8
1007:         ENDWITH
1008: 
1009:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
1010:         WITH loc_oPagina.lbl_4c_Label8
1011:             .Caption   = "Identificador :"
1012:             .Top       = 188
1013:             .Left      = 303
1014:             .Width     = 70
1015:             .Height    = 15

*-- Linhas 1049 a 1170:
1049:             .Visible   = .T.
1050:         ENDWITH
1051: 
1052:         loc_oPagina.AddObject("obj_4c_Opc_realprev", "OptionGroup")
1053:         WITH loc_oPagina.obj_4c_Opc_realprev
1054:             .ButtonCount = 2
1055:             .Top         = 197
1056:             .Left        = 683
1057:             .Width       = 128
1058:             .Height      = 21
1059:             .BackStyle   = 0
1060:             .BorderStyle = 0
1061:             .Visible     = .T.
1062:         ENDWITH
1063:         WITH loc_oPagina.obj_4c_Opc_realprev.Buttons(1)
1064:             .Caption   = "C/C"
1065:             .BackStyle = 0
1066:             .Left      = 5
1067:             .Top       = 3
1068:             .Width     = 55
1069:             .AutoSize  = .F.
1070:             .ForeColor = RGB(90, 90, 90)
1071:             .FontName  = "Tahoma"
1072:             .FontSize  = 8
1073:         ENDWITH
1074:         WITH loc_oPagina.obj_4c_Opc_realprev.Buttons(2)
1075:             .Caption   = "Previsto"
1076:             .BackStyle = 0
1077:             .Left      = 63
1078:             .Top       = 3
1079:             .Width     = 55
1080:             .AutoSize  = .F.
1081:             .ForeColor = RGB(90, 90, 90)
1082:             .FontName  = "Tahoma"
1083:             .FontSize  = 8
1084:         ENDWITH
1085:         BINDEVENT(loc_oPagina.obj_4c_Opc_realprev, "InteractiveChange", THIS, "OpcRealprevChanged")
1086: 
1087:         loc_oPagina.AddObject("lbl_4c_Label16", "Label")
1088:         WITH loc_oPagina.lbl_4c_Label16
1089:             .Caption   = "Qtd. Vias Boleto :"
1090:             .Top       = 213
1091:             .Left      = 287
1092:             .Width     = 86
1093:             .Height    = 15
1094:             .FontName  = "Tahoma"
1095:             .FontSize  = 8
1096:             .BackStyle = 0
1097:             .Visible   = .T.
1098:         ENDWITH
1099: 
1100:         loc_oPagina.AddObject("txt_4c_Vias", "TextBox")
1101:         WITH loc_oPagina.txt_4c_Vias
1102:             .Value    = 0
1103:             .Top      = 208
1104:             .Left     = 378
1105:             .Width    = 24
1106:             .Height   = 24
1107:             .FontName = "Tahoma"
1108:             .FontSize = 8
1109:             .Visible  = .T.
1110:         ENDWITH
1111:         BINDEVENT(loc_oPagina.txt_4c_Vias, "KeyPress", THIS, "ValidarVias")
1112: 
1113:         *----------------------------------------------------------------------
1114:         *-- Linha 9: Imprime Boleto + Opera" + CHR(231) + CHR(227) + "o Realizado
1115:         *----------------------------------------------------------------------
1116: 
1117:         loc_oPagina.AddObject("lbl_4c_Label15", "Label")
1118:         WITH loc_oPagina.lbl_4c_Label15
1119:             .Caption   = "Imprime Boleto :"
1120:             .Top       = 213
1121:             .Left      = 56
1122:             .Width     = 80
1123:             .Height    = 15
1124:             .FontName  = "Tahoma"
1125:             .FontSize  = 8
1126:             .BackStyle = 0
1127:             .Visible   = .T.
1128:         ENDWITH
1129: 
1130:         loc_oPagina.AddObject("obj_4c_Opc_Impbol", "OptionGroup")
1131:         WITH loc_oPagina.obj_4c_Opc_Impbol
1132:             .ButtonCount = 2
1133:             .Top         = 210
1134:             .Left        = 135
1135:             .Width       = 110
1136:             .Height      = 21
1137:             .BackStyle   = 0
1138:             .BorderStyle = 0
1139:             .Visible     = .T.
1140:         ENDWITH
1141:         WITH loc_oPagina.obj_4c_Opc_Impbol.Buttons(1)
1142:             .Caption   = "Sim"
1143:             .BackStyle = 0
1144:             .Left      = 5
1145:             .Top       = 3
1146:             .Width     = 46
1147:             .AutoSize  = .F.
1148:             .ForeColor = RGB(90, 90, 90)
1149:             .FontName  = "Tahoma"
1150:             .FontSize  = 8
1151:         ENDWITH
1152:         WITH loc_oPagina.obj_4c_Opc_Impbol.Buttons(2)
1153:             .Caption   = "N" + CHR(227) + "o"
1154:             .BackStyle = 0
1155:             .Left      = 54
1156:             .Top       = 3
1157:             .Width     = 46
1158:             .AutoSize  = .F.
1159:             .ForeColor = RGB(90, 90, 90)
1160:             .FontName  = "Tahoma"
1161:             .FontSize  = 8
1162:         ENDWITH
1163: 
1164:         loc_oPagina.AddObject("lbl_4c_Label18", "Label")
1165:         WITH loc_oPagina.lbl_4c_Label18
1166:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o Realizado :"
1167:             .Top       = 220
1168:             .Left      = 578
1169:             .Width     = 105
1170:             .Height    = 15

*-- Linhas 1186 a 1248:
1186:             .FontSize  = 8
1187:             .Visible   = .T.
1188:         ENDWITH
1189:         BINDEVENT(loc_oPagina.txt_4c_DopReal, "KeyPress", THIS, "ValidarDopReal")
1190: 
1191:         *----------------------------------------------------------------------
1192:         *-- Linha 10: Imprime Documento + Opera" + CHR(231) + CHR(227) + "o Cancelamento
1193:         *----------------------------------------------------------------------
1194: 
1195:         loc_oPagina.AddObject("lbl_4c_Label28", "Label")
1196:         WITH loc_oPagina.lbl_4c_Label28
1197:             .Caption   = "Imprime Documento :"
1198:             .Top       = 234
1199:             .Left      = 32
1200:             .Width     = 104
1201:             .Height    = 15
1202:             .FontName  = "Tahoma"
1203:             .FontSize  = 8
1204:             .BackStyle = 0
1205:             .Visible   = .T.
1206:         ENDWITH
1207: 
1208:         loc_oPagina.AddObject("obj_4c_Opc_imprimedoc", "OptionGroup")
1209:         WITH loc_oPagina.obj_4c_Opc_imprimedoc
1210:             .ButtonCount = 2
1211:             .Top         = 231
1212:             .Left        = 135
1213:             .Width       = 110
1214:             .Height      = 21
1215:             .BackStyle   = 0
1216:             .BorderStyle = 0
1217:             .Visible     = .T.
1218:         ENDWITH
1219:         WITH loc_oPagina.obj_4c_Opc_imprimedoc.Buttons(1)
1220:             .Caption   = "Sim"
1221:             .BackStyle = 0
1222:             .Left      = 5
1223:             .Top       = 3
1224:             .Width     = 46
1225:             .AutoSize  = .F.
1226:             .ForeColor = RGB(90, 90, 90)
1227:             .FontName  = "Tahoma"
1228:             .FontSize  = 8
1229:         ENDWITH
1230:         WITH loc_oPagina.obj_4c_Opc_imprimedoc.Buttons(2)
1231:             .Caption   = "N" + CHR(227) + "o"
1232:             .BackStyle = 0
1233:             .Left      = 54
1234:             .Top       = 3
1235:             .Width     = 46
1236:             .AutoSize  = .F.
1237:             .ForeColor = RGB(90, 90, 90)
1238:             .FontName  = "Tahoma"
1239:             .FontSize  = 8
1240:         ENDWITH
1241: 
1242:         loc_oPagina.AddObject("lbl_4c_Label30", "Label")
1243:         WITH loc_oPagina.lbl_4c_Label30
1244:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o Cancelamento :"
1245:             .Top       = 245
1246:             .Left      = 556
1247:             .Width     = 127
1248:             .Height    = 15

*-- Linhas 1264 a 1373:
1264:             .FontSize  = 8
1265:             .Visible   = .T.
1266:         ENDWITH
1267:         BINDEVENT(loc_oPagina.txt_4c_DopCanc, "KeyPress", THIS, "ValidarDopCanc")
1268: 
1269:         *----------------------------------------------------------------------
1270:         *-- Linha 10: Dados Pagamento + Campo NF
1271:         *----------------------------------------------------------------------
1272: 
1273:         loc_oPagina.AddObject("lbl_4c_Label32", "Label")
1274:         WITH loc_oPagina.lbl_4c_Label32
1275:             .Caption   = "Dados Pagamento :"
1276:             .Top       = 273
1277:             .Left      = 37
1278:             .Width     = 99
1279:             .Height    = 15
1280:             .FontName  = "Tahoma"
1281:             .FontSize  = 8
1282:             .BackStyle = 0
1283:             .Visible   = .T.
1284:         ENDWITH
1285: 
1286:         loc_oPagina.AddObject("obj_4c_Opc_DadosPg", "OptionGroup")
1287:         WITH loc_oPagina.obj_4c_Opc_DadosPg
1288:             .ButtonCount = 2
1289:             .Top         = 270
1290:             .Left        = 135
1291:             .Width       = 110
1292:             .Height      = 21
1293:             .BackStyle   = 0
1294:             .BorderStyle = 0
1295:             .Visible     = .T.
1296:         ENDWITH
1297:         WITH loc_oPagina.obj_4c_Opc_DadosPg.Buttons(1)
1298:             .Caption   = "Sim"
1299:             .BackStyle = 0
1300:             .Left      = 5
1301:             .Top       = 3
1302:             .Width     = 46
1303:             .AutoSize  = .F.
1304:             .ForeColor = RGB(90, 90, 90)
1305:             .FontName  = "Tahoma"
1306:             .FontSize  = 8
1307:         ENDWITH
1308:         WITH loc_oPagina.obj_4c_Opc_DadosPg.Buttons(2)
1309:             .Caption   = "N" + CHR(227) + "o"
1310:             .BackStyle = 0
1311:             .Left      = 54
1312:             .Top       = 3
1313:             .Width     = 46
1314:             .AutoSize  = .F.
1315:             .ForeColor = RGB(90, 90, 90)
1316:             .FontName  = "Tahoma"
1317:             .FontSize  = 8
1318:         ENDWITH
1319: 
1320:         loc_oPagina.AddObject("lbl_4c_Label33", "Label")
1321:         WITH loc_oPagina.lbl_4c_Label33
1322:             .Caption   = "Campo NF :"
1323:             .Top       = 273
1324:             .Left      = 583
1325:             .Width     = 65
1326:             .Height    = 15
1327:             .FontName  = "Tahoma"
1328:             .FontSize  = 8
1329:             .BackStyle = 0
1330:             .Visible   = .T.
1331:         ENDWITH
1332: 
1333:         loc_oPagina.AddObject("obj_4c_Opt_CampoNf", "OptionGroup")
1334:         WITH loc_oPagina.obj_4c_Opt_CampoNf
1335:             .ButtonCount = 2
1336:             .Top         = 270
1337:             .Left        = 683
1338:             .Width       = 128
1339:             .Height      = 21
1340:             .BackStyle   = 0
1341:             .BorderStyle = 0
1342:             .Visible     = .T.
1343:         ENDWITH
1344:         WITH loc_oPagina.obj_4c_Opt_CampoNf.Buttons(1)
1345:             .Caption   = "Sim"
1346:             .BackStyle = 0
1347:             .Left      = 5
1348:             .Top       = 3
1349:             .Width     = 55
1350:             .AutoSize  = .F.
1351:             .ForeColor = RGB(90, 90, 90)
1352:             .FontName  = "Tahoma"
1353:             .FontSize  = 8
1354:         ENDWITH
1355:         WITH loc_oPagina.obj_4c_Opt_CampoNf.Buttons(2)
1356:             .Caption   = "N" + CHR(227) + "o"
1357:             .BackStyle = 0
1358:             .Left      = 63
1359:             .Top       = 3
1360:             .Width     = 55
1361:             .AutoSize  = .F.
1362:             .ForeColor = RGB(90, 90, 90)
1363:             .FontName  = "Tahoma"
1364:             .FontSize  = 8
1365:         ENDWITH
1366: 
1367:         *----------------------------------------------------------------------
1368:         *-- Linha 11: Emitente=Portador + Compet" + CHR(234) + "ncia
1369:         *----------------------------------------------------------------------
1370: 
1371:         loc_oPagina.AddObject("lbl_4c_Label34", "Label")
1372:         WITH loc_oPagina.lbl_4c_Label34
1373:             .Caption   = "Emit.=Portador :"

*-- Linhas 1381 a 1471:
1381:             .Visible   = .T.
1382:         ENDWITH
1383: 
1384:         loc_oPagina.AddObject("obj_4c_Opc_EmiPor", "OptionGroup")
1385:         WITH loc_oPagina.obj_4c_Opc_EmiPor
1386:             .ButtonCount = 2
1387:             .Top         = 292
1388:             .Left        = 135
1389:             .Width       = 110
1390:             .Height      = 21
1391:             .BackStyle   = 0
1392:             .BorderStyle = 0
1393:             .Visible     = .T.
1394:         ENDWITH
1395:         WITH loc_oPagina.obj_4c_Opc_EmiPor.Buttons(1)
1396:             .Caption   = "Sim"
1397:             .BackStyle = 0
1398:             .Left      = 5
1399:             .Top       = 3
1400:             .Width     = 46
1401:             .AutoSize  = .F.
1402:             .ForeColor = RGB(90, 90, 90)
1403:             .FontName  = "Tahoma"
1404:             .FontSize  = 8
1405:         ENDWITH
1406:         WITH loc_oPagina.obj_4c_Opc_EmiPor.Buttons(2)
1407:             .Caption   = "N" + CHR(227) + "o"
1408:             .BackStyle = 0
1409:             .Left      = 54
1410:             .Top       = 3
1411:             .Width     = 46
1412:             .AutoSize  = .F.
1413:             .ForeColor = RGB(90, 90, 90)
1414:             .FontName  = "Tahoma"
1415:             .FontSize  = 8
1416:         ENDWITH
1417: 
1418:         loc_oPagina.AddObject("lbl_4c_Label35", "Label")
1419:         WITH loc_oPagina.lbl_4c_Label35
1420:             .Caption   = "Compet" + CHR(234) + "ncia :"
1421:             .Top       = 295
1422:             .Left      = 574
1423:             .Width     = 75
1424:             .Height    = 15
1425:             .FontName  = "Tahoma"
1426:             .FontSize  = 8
1427:             .BackStyle = 0
1428:             .Visible   = .T.
1429:         ENDWITH
1430: 
1431:         loc_oPagina.AddObject("obj_4c_Opc_Compet", "OptionGroup")
1432:         WITH loc_oPagina.obj_4c_Opc_Compet
1433:             .ButtonCount = 2
1434:             .Top         = 292
1435:             .Left        = 683
1436:             .Width       = 128
1437:             .Height      = 21
1438:             .BackStyle   = 0
1439:             .BorderStyle = 0
1440:             .Visible     = .T.
1441:         ENDWITH
1442:         WITH loc_oPagina.obj_4c_Opc_Compet.Buttons(1)
1443:             .Caption   = "Sim"
1444:             .BackStyle = 0
1445:             .Left      = 5
1446:             .Top       = 3
1447:             .Width     = 55
1448:             .AutoSize  = .F.
1449:             .ForeColor = RGB(90, 90, 90)
1450:             .FontName  = "Tahoma"
1451:             .FontSize  = 8
1452:         ENDWITH
1453:         WITH loc_oPagina.obj_4c_Opc_Compet.Buttons(2)
1454:             .Caption   = "N" + CHR(227) + "o"
1455:             .BackStyle = 0
1456:             .Left      = 63
1457:             .Top       = 3
1458:             .Width     = 55
1459:             .AutoSize  = .F.
1460:             .ForeColor = RGB(90, 90, 90)
1461:             .FontName  = "Tahoma"
1462:             .FontSize  = 8
1463:         ENDWITH
1464: 
1465:         *----------------------------------------------------------------------
1466:         *-- Linha 12: Filtra Conta p/ Grupo + Jobs
1467:         *----------------------------------------------------------------------
1468: 
1469:         loc_oPagina.AddObject("lbl_4c_Label36", "Label")
1470:         WITH loc_oPagina.lbl_4c_Label36
1471:             .Caption   = "Filtra Conta p/ Grupo :"

*-- Linhas 1479 a 1569:
1479:             .Visible   = .T.
1480:         ENDWITH
1481: 
1482:         loc_oPagina.AddObject("obj_4c_Opc_FiltContas", "OptionGroup")
1483:         WITH loc_oPagina.obj_4c_Opc_FiltContas
1484:             .ButtonCount = 2
1485:             .Top         = 314
1486:             .Left        = 135
1487:             .Width       = 110
1488:             .Height      = 21
1489:             .BackStyle   = 0
1490:             .BorderStyle = 0
1491:             .Visible     = .T.
1492:         ENDWITH
1493:         WITH loc_oPagina.obj_4c_Opc_FiltContas.Buttons(1)
1494:             .Caption   = "Sim"
1495:             .BackStyle = 0
1496:             .Left      = 5
1497:             .Top       = 3
1498:             .Width     = 46
1499:             .AutoSize  = .F.
1500:             .ForeColor = RGB(90, 90, 90)
1501:             .FontName  = "Tahoma"
1502:             .FontSize  = 8
1503:         ENDWITH
1504:         WITH loc_oPagina.obj_4c_Opc_FiltContas.Buttons(2)
1505:             .Caption   = "N" + CHR(227) + "o"
1506:             .BackStyle = 0
1507:             .Left      = 54
1508:             .Top       = 3
1509:             .Width     = 46
1510:             .AutoSize  = .F.
1511:             .ForeColor = RGB(90, 90, 90)
1512:             .FontName  = "Tahoma"
1513:             .FontSize  = 8
1514:         ENDWITH
1515: 
1516:         loc_oPagina.AddObject("lbl_4c_Label37", "Label")
1517:         WITH loc_oPagina.lbl_4c_Label37
1518:             .Caption   = "Jobs :"
1519:             .Top       = 317
1520:             .Left      = 633
1521:             .Width     = 36
1522:             .Height    = 15
1523:             .FontName  = "Tahoma"
1524:             .FontSize  = 8
1525:             .BackStyle = 0
1526:             .Visible   = .T.
1527:         ENDWITH
1528: 
1529:         loc_oPagina.AddObject("obj_4c_Opt_Jobs", "OptionGroup")
1530:         WITH loc_oPagina.obj_4c_Opt_Jobs
1531:             .ButtonCount = 2
1532:             .Top         = 314
1533:             .Left        = 683
1534:             .Width       = 128
1535:             .Height      = 21
1536:             .BackStyle   = 0
1537:             .BorderStyle = 0
1538:             .Visible     = .T.
1539:         ENDWITH
1540:         WITH loc_oPagina.obj_4c_Opt_Jobs.Buttons(1)
1541:             .Caption   = "Sim"
1542:             .BackStyle = 0
1543:             .Left      = 5
1544:             .Top       = 3
1545:             .Width     = 55
1546:             .AutoSize  = .F.
1547:             .ForeColor = RGB(90, 90, 90)
1548:             .FontName  = "Tahoma"
1549:             .FontSize  = 8
1550:         ENDWITH
1551:         WITH loc_oPagina.obj_4c_Opt_Jobs.Buttons(2)
1552:             .Caption   = "N" + CHR(227) + "o"
1553:             .BackStyle = 0
1554:             .Left      = 63
1555:             .Top       = 3
1556:             .Width     = 55
1557:             .AutoSize  = .F.
1558:             .ForeColor = RGB(90, 90, 90)
1559:             .FontName  = "Tahoma"
1560:             .FontSize  = 8
1561:         ENDWITH
1562: 
1563:         *----------------------------------------------------------------------
1564:         *-- Linha 13: Limite Cr" + CHR(233) + "dito
1565:         *----------------------------------------------------------------------
1566: 
1567:         loc_oPagina.AddObject("lbl_4c_Label38", "Label")
1568:         WITH loc_oPagina.lbl_4c_Label38
1569:             .Caption   = "Limite Cr" + CHR(233) + "dito :"

*-- Linhas 1577 a 1620:
1577:             .Visible   = .T.
1578:         ENDWITH
1579: 
1580:         loc_oPagina.AddObject("obj_4c_Opc_Limcres", "OptionGroup")
1581:         WITH loc_oPagina.obj_4c_Opc_Limcres
1582:             .ButtonCount = 2
1583:             .Top         = 336
1584:             .Left        = 135
1585:             .Width       = 110
1586:             .Height      = 21
1587:             .BackStyle   = 0
1588:             .BorderStyle = 0
1589:             .Visible     = .T.
1590:         ENDWITH
1591:         WITH loc_oPagina.obj_4c_Opc_Limcres.Buttons(1)
1592:             .Caption   = "Sim"
1593:             .BackStyle = 0
1594:             .Left      = 5
1595:             .Top       = 3
1596:             .Width     = 46
1597:             .AutoSize  = .F.
1598:             .ForeColor = RGB(90, 90, 90)
1599:             .FontName  = "Tahoma"
1600:             .FontSize  = 8
1601:         ENDWITH
1602:         WITH loc_oPagina.obj_4c_Opc_Limcres.Buttons(2)
1603:             .Caption   = "N" + CHR(227) + "o"
1604:             .BackStyle = 0
1605:             .Left      = 54
1606:             .Top       = 3
1607:             .Width     = 46
1608:             .AutoSize  = .F.
1609:             .ForeColor = RGB(90, 90, 90)
1610:             .FontName  = "Tahoma"
1611:             .FontSize  = 8
1612:         ENDWITH
1613: 
1614:         *----------------------------------------------------------------------
1615:         *-- Linha 14: CheckBoxes
1616:         *----------------------------------------------------------------------
1617: 
1618:         loc_oPagina.AddObject("chk_4c_Congvs", "CheckBox")
1619:         WITH loc_oPagina.chk_4c_Congvs
1620:             .Caption   = "Cong" + CHR(234) + "neres"

*-- Linhas 1767 a 1810:
1767:             .FontSize  = 8
1768:             .Visible   = .T.
1769:         ENDWITH
1770:         BINDEVENT(loc_oPagina.txt_4c_DiasVcto, "KeyPress", THIS, "ValidarDiasVcto")
1771: 
1772:         loc_oPagina.AddObject("lbl_4c_Label41", "Label")
1773:         WITH loc_oPagina.lbl_4c_Label41
1774:             .Caption   = "Juros Di" + CHR(225) + "rio(%) :"
1775:             .Top       = 387
1776:             .Left      = 296
1777:             .Width     = 90
1778:             .Height    = 15
1779:             .FontName  = "Tahoma"
1780:             .FontSize  = 8
1781:             .BackStyle = 0
1782:             .Visible   = .T.
1783:         ENDWITH
1784: 
1785:         loc_oPagina.AddObject("txt_4c_Juros", "TextBox")
1786:         WITH loc_oPagina.txt_4c_Juros
1787:             .Value     = 0.0
1788:             .Top       = 383
1789:             .Left      = 390
1790:             .Width     = 55
1791:             .Height    = 23
1792:             .FontName  = "Tahoma"
1793:             .FontSize  = 8
1794:             .Visible   = .T.
1795:         ENDWITH
1796: 
1797:         loc_oPagina.AddObject("lbl_4c_Label42", "Label")
1798:         WITH loc_oPagina.lbl_4c_Label42
1799:             .Caption   = "Moeda :"
1800:             .Top       = 387
1801:             .Left      = 452
1802:             .Width     = 47
1803:             .Height    = 15
1804:             .FontName  = "Tahoma"
1805:             .FontSize  = 8
1806:             .BackStyle = 0
1807:             .Visible   = .T.
1808:         ENDWITH
1809: 
1810:         loc_oPagina.AddObject("txt_4c_Moeda", "TextBox")

*-- Linhas 1819 a 1862:
1819:             .FontSize  = 8
1820:             .Visible   = .T.
1821:         ENDWITH
1822:         BINDEVENT(loc_oPagina.txt_4c_Moeda, "KeyPress", THIS, "ValidarMoeda")
1823: 
1824:         loc_oPagina.AddObject("lbl_4c_Label43", "Label")
1825:         WITH loc_oPagina.lbl_4c_Label43
1826:             .Caption   = "Vlr.Lim.Aprov. :"
1827:             .Top       = 387
1828:             .Left      = 544
1829:             .Width     = 100
1830:             .Height    = 15
1831:             .FontName  = "Tahoma"
1832:             .FontSize  = 8
1833:             .BackStyle = 0
1834:             .Visible   = .T.
1835:         ENDWITH
1836: 
1837:         loc_oPagina.AddObject("txt_4c_VlrLimApv", "TextBox")
1838:         WITH loc_oPagina.txt_4c_VlrLimApv
1839:             .Value     = 0.0
1840:             .Top       = 383
1841:             .Left      = 648
1842:             .Width     = 95
1843:             .Height    = 23
1844:             .FontName  = "Tahoma"
1845:             .FontSize  = 8
1846:             .Visible   = .T.
1847:         ENDWITH
1848: 
1849:         *----------------------------------------------------------------------
1850:         *-- Linha 16: Pasta(s)
1851:         *----------------------------------------------------------------------
1852: 
1853:         loc_oPagina.AddObject("lbl_4c_Label44", "Label")
1854:         WITH loc_oPagina.lbl_4c_Label44
1855:             .Caption   = "Pasta(s) :"
1856:             .Top       = 412
1857:             .Left      = 37
1858:             .Width     = 58
1859:             .Height    = 15
1860:             .FontName  = "Tahoma"
1861:             .FontSize  = 8
1862:             .BackStyle = 0

*-- Linhas 1874 a 1931:
1874:             .FontName  = "Tahoma"
1875:             .FontSize  = 8
1876:             .Visible   = .T.
1877:         ENDWITH
1878: 
1879:         loc_oPagina.AddObject("cmd_4c_BtnPastasCl", "CommandButton")
1880:         WITH loc_oPagina.cmd_4c_BtnPastasCl
1881:             .Caption       = "..."
1882:             .Top           = 408
1883:             .Left          = 723
1884:             .Width         = 25
1885:             .Height        = 23
1886:             .FontName      = "Tahoma"
1887:             .FontSize      = 8
1888:             .SpecialEffect = 0
1889:             .Visible       = .T.
1890:         ENDWITH
1891:         BINDEVENT(loc_oPagina.cmd_4c_BtnPastasCl, "Click", THIS, "BtnPastasCClick")
1892: 
1893:         *----------------------------------------------------------------------
1894:         *-- Linha 17: Grupos Padr" + CHR(227) + "o (Emitente/Portador/C.Custo/Ag.Cobrador)
1895:         *----------------------------------------------------------------------
1896: 
1897:         loc_oPagina.AddObject("lbl_4c_Label45", "Label")
1898:         WITH loc_oPagina.lbl_4c_Label45
1899:             .Caption   = "Gr.Emitente :"
1900:             .Top       = 437
1901:             .Left      = 10
1902:             .Width     = 82
1903:             .Height    = 15
1904:             .FontName  = "Tahoma"
1905:             .FontSize  = 8
1906:             .BackStyle = 0
1907:             .Visible   = .T.
1908:         ENDWITH
1909: 
1910:         loc_oPagina.AddObject("txt_4c_Grupo1", "TextBox")
1911:         WITH loc_oPagina.txt_4c_Grupo1
1912:             .Value     = ""
1913:             .Top       = 433
1914:             .Left      = 97
1915:             .Width     = 85
1916:             .Height    = 23
1917:             .MaxLength = 10
1918:             .FontName  = "Tahoma"
1919:             .FontSize  = 8
1920:             .Visible   = .T.
1921:         ENDWITH
1922: 
1923:         loc_oPagina.AddObject("lbl_4c_Label46", "Label")
1924:         WITH loc_oPagina.lbl_4c_Label46
1925:             .Caption   = "Gr.Portador :"
1926:             .Top       = 437
1927:             .Left      = 193
1928:             .Width     = 80
1929:             .Height    = 15
1930:             .FontName  = "Tahoma"
1931:             .FontSize  = 8

*-- Linhas 2135 a 2791:
2135:             .FontSize  = 8
2136:             .Visible   = .T.
2137:         ENDWITH
2138:         BINDEVENT(loc_oPagina.txt_4c_GrpCad1, "KeyPress", THIS, "ValidarGrpCad1s")
2139: 
2140:         loc_oPagina.AddObject("txt_4c_DGrpCad1", "TextBox")
2141:         WITH loc_oPagina.txt_4c_DGrpCad1
2142:             .Value     = ""
2143:             .Top       = 483
2144:             .Left      = 150
2145:             .Width     = 200
2146:             .Height    = 23
2147:             .ReadOnly  = .T.
2148:             .Enabled   = .T.
2149:             .FontName  = "Tahoma"
2150:             .FontSize  = 8
2151:             .Visible   = .T.
2152:         ENDWITH
2153: 
2154:         loc_oPagina.AddObject("lbl_4c_Label54", "Label")
2155:         WITH loc_oPagina.lbl_4c_Label54
2156:             .Caption   = "Gr.Cad.2 :"
2157:             .Top       = 487
2158:             .Left      = 365
2159:             .Width     = 66
2160:             .Height    = 15
2161:             .FontName  = "Tahoma"
2162:             .FontSize  = 8
2163:             .BackStyle = 0
2164:             .Visible   = .T.
2165:         ENDWITH
2166: 
2167:         loc_oPagina.AddObject("txt_4c_GrpCad2", "TextBox")
2168:         WITH loc_oPagina.txt_4c_GrpCad2
2169:             .Value     = ""
2170:             .Top       = 483
2171:             .Left      = 436
2172:             .Width     = 65
2173:             .Height    = 23
2174:             .MaxLength = 10
2175:             .FontName  = "Tahoma"
2176:             .FontSize  = 8
2177:             .Visible   = .T.
2178:         ENDWITH
2179:         BINDEVENT(loc_oPagina.txt_4c_GrpCad2, "KeyPress", THIS, "ValidarGrpCad2s")
2180: 
2181:         loc_oPagina.AddObject("txt_4c_DGrpCad2", "TextBox")
2182:         WITH loc_oPagina.txt_4c_DGrpCad2
2183:             .Value     = ""
2184:             .Top       = 483
2185:             .Left      = 506
2186:             .Width     = 200
2187:             .Height    = 23
2188:             .ReadOnly  = .T.
2189:             .Enabled   = .T.
2190:             .FontName  = "Tahoma"
2191:             .FontSize  = 8
2192:             .Visible   = .T.
2193:         ENDWITH
2194: 
2195:         loc_oPagina.AddObject("lbl_4c_Label55", "Label")
2196:         WITH loc_oPagina.lbl_4c_Label55
2197:             .Caption   = "Gr.Cad.3 :"
2198:             .Top       = 511
2199:             .Left      = 10
2200:             .Width     = 66
2201:             .Height    = 15
2202:             .FontName  = "Tahoma"
2203:             .FontSize  = 8
2204:             .BackStyle = 0
2205:             .Visible   = .T.
2206:         ENDWITH
2207: 
2208:         loc_oPagina.AddObject("txt_4c_GrpCad3", "TextBox")
2209:         WITH loc_oPagina.txt_4c_GrpCad3
2210:             .Value     = ""
2211:             .Top       = 507
2212:             .Left      = 80
2213:             .Width     = 65
2214:             .Height    = 23
2215:             .MaxLength = 10
2216:             .FontName  = "Tahoma"
2217:             .FontSize  = 8
2218:             .Visible   = .T.
2219:         ENDWITH
2220:         BINDEVENT(loc_oPagina.txt_4c_GrpCad3, "KeyPress", THIS, "ValidarGrpCad3s")
2221: 
2222:         loc_oPagina.AddObject("txt_4c_DGrpCad3", "TextBox")
2223:         WITH loc_oPagina.txt_4c_DGrpCad3
2224:             .Value     = ""
2225:             .Top       = 507
2226:             .Left      = 150
2227:             .Width     = 200
2228:             .Height    = 23
2229:             .ReadOnly  = .T.
2230:             .Enabled   = .T.
2231:             .FontName  = "Tahoma"
2232:             .FontSize  = 8
2233:             .Visible   = .T.
2234:         ENDWITH
2235: 
2236:         loc_oPagina.AddObject("lbl_4c_Label56", "Label")
2237:         WITH loc_oPagina.lbl_4c_Label56
2238:             .Caption   = "Gr.Cad.4 :"
2239:             .Top       = 511
2240:             .Left      = 365
2241:             .Width     = 66
2242:             .Height    = 15
2243:             .FontName  = "Tahoma"
2244:             .FontSize  = 8
2245:             .BackStyle = 0
2246:             .Visible   = .T.
2247:         ENDWITH
2248: 
2249:         loc_oPagina.AddObject("txt_4c_GrpCad4", "TextBox")
2250:         WITH loc_oPagina.txt_4c_GrpCad4
2251:             .Value     = ""
2252:             .Top       = 507
2253:             .Left      = 436
2254:             .Width     = 65
2255:             .Height    = 23
2256:             .MaxLength = 10
2257:             .FontName  = "Tahoma"
2258:             .FontSize  = 8
2259:             .Visible   = .T.
2260:         ENDWITH
2261:         BINDEVENT(loc_oPagina.txt_4c_GrpCad4, "KeyPress", THIS, "ValidarGrpCad4s")
2262: 
2263:         loc_oPagina.AddObject("txt_4c_DGrpCad4", "TextBox")
2264:         WITH loc_oPagina.txt_4c_DGrpCad4
2265:             .Value     = ""
2266:             .Top       = 507
2267:             .Left      = 506
2268:             .Width     = 200
2269:             .Height    = 23
2270:             .ReadOnly  = .T.
2271:             .Enabled   = .T.
2272:             .FontName  = "Tahoma"
2273:             .FontSize  = 8
2274:             .Visible   = .T.
2275:         ENDWITH
2276: 
2277:         *----------------------------------------------------------------------
2278:         *-- Linhas 21-22: Classes Cont" + CHR(225) + "beis 1-4 com Obrigatoriedade
2279:         *----------------------------------------------------------------------
2280: 
2281:         loc_oPagina.AddObject("lbl_4c_Label57", "Label")
2282:         WITH loc_oPagina.lbl_4c_Label57
2283:             .Caption   = "Classe 1 :"
2284:             .Top       = 538
2285:             .Left      = 10
2286:             .Width     = 60
2287:             .Height    = 15
2288:             .FontName  = "Tahoma"
2289:             .FontSize  = 8
2290:             .BackStyle = 0
2291:             .Visible   = .T.
2292:         ENDWITH
2293: 
2294:         loc_oPagina.AddObject("txt_4c_Class1", "TextBox")
2295:         WITH loc_oPagina.txt_4c_Class1
2296:             .Value     = ""
2297:             .Top       = 534
2298:             .Left      = 74
2299:             .Width     = 30
2300:             .Height    = 23
2301:             .MaxLength = 1
2302:             .FontName  = "Tahoma"
2303:             .FontSize  = 8
2304:             .Visible   = .T.
2305:         ENDWITH
2306:         BINDEVENT(loc_oPagina.txt_4c_Class1, "KeyPress", THIS, "ValidarClass1s")
2307: 
2308:         loc_oPagina.AddObject("chk_4c_ObrigC1", "CheckBox")
2309:         WITH loc_oPagina.chk_4c_ObrigC1
2310:             .Caption   = "Obrigat" + CHR(243) + "ria"
2311:             .Top       = 536
2312:             .Left      = 109
2313:             .Width     = 80
2314:             .Height    = 17
2315:             .Value     = 0
2316:             .FontName  = "Tahoma"
2317:             .FontSize  = 8
2318:             .BackStyle = 0
2319:             .Visible   = .T.
2320:         ENDWITH
2321: 
2322:         loc_oPagina.AddObject("lbl_4c_Label58", "Label")
2323:         WITH loc_oPagina.lbl_4c_Label58
2324:             .Caption   = "Classe 2 :"
2325:             .Top       = 538
2326:             .Left      = 200
2327:             .Width     = 60
2328:             .Height    = 15
2329:             .FontName  = "Tahoma"
2330:             .FontSize  = 8
2331:             .BackStyle = 0
2332:             .Visible   = .T.
2333:         ENDWITH
2334: 
2335:         loc_oPagina.AddObject("txt_4c_Class2", "TextBox")
2336:         WITH loc_oPagina.txt_4c_Class2
2337:             .Value     = ""
2338:             .Top       = 534
2339:             .Left      = 264
2340:             .Width     = 30
2341:             .Height    = 23
2342:             .MaxLength = 1
2343:             .FontName  = "Tahoma"
2344:             .FontSize  = 8
2345:             .Visible   = .T.
2346:         ENDWITH
2347:         BINDEVENT(loc_oPagina.txt_4c_Class2, "KeyPress", THIS, "ValidarClass2s")
2348: 
2349:         loc_oPagina.AddObject("chk_4c_ObrigC2", "CheckBox")
2350:         WITH loc_oPagina.chk_4c_ObrigC2
2351:             .Caption   = "Obrigat" + CHR(243) + "ria"
2352:             .Top       = 536
2353:             .Left      = 299
2354:             .Width     = 80
2355:             .Height    = 17
2356:             .Value     = 0
2357:             .FontName  = "Tahoma"
2358:             .FontSize  = 8
2359:             .BackStyle = 0
2360:             .Visible   = .T.
2361:         ENDWITH
2362: 
2363:         loc_oPagina.AddObject("lbl_4c_Label59", "Label")
2364:         WITH loc_oPagina.lbl_4c_Label59
2365:             .Caption   = "Classe 3 :"
2366:             .Top       = 538
2367:             .Left      = 395
2368:             .Width     = 60
2369:             .Height    = 15
2370:             .FontName  = "Tahoma"
2371:             .FontSize  = 8
2372:             .BackStyle = 0
2373:             .Visible   = .T.
2374:         ENDWITH
2375: 
2376:         loc_oPagina.AddObject("txt_4c_Class3", "TextBox")
2377:         WITH loc_oPagina.txt_4c_Class3
2378:             .Value     = ""
2379:             .Top       = 534
2380:             .Left      = 459
2381:             .Width     = 30
2382:             .Height    = 23
2383:             .MaxLength = 1
2384:             .FontName  = "Tahoma"
2385:             .FontSize  = 8
2386:             .Visible   = .T.
2387:         ENDWITH
2388:         BINDEVENT(loc_oPagina.txt_4c_Class3, "KeyPress", THIS, "ValidarClass3s")
2389: 
2390:         loc_oPagina.AddObject("chk_4c_ObrigC3", "CheckBox")
2391:         WITH loc_oPagina.chk_4c_ObrigC3
2392:             .Caption   = "Obrigat" + CHR(243) + "ria"
2393:             .Top       = 536
2394:             .Left      = 494
2395:             .Width     = 80
2396:             .Height    = 17
2397:             .Value     = 0
2398:             .FontName  = "Tahoma"
2399:             .FontSize  = 8
2400:             .BackStyle = 0
2401:             .Visible   = .T.
2402:         ENDWITH
2403: 
2404:         loc_oPagina.AddObject("lbl_4c_Label60", "Label")
2405:         WITH loc_oPagina.lbl_4c_Label60
2406:             .Caption   = "Classe 4 :"
2407:             .Top       = 538
2408:             .Left      = 590
2409:             .Width     = 60
2410:             .Height    = 15
2411:             .FontName  = "Tahoma"
2412:             .FontSize  = 8
2413:             .BackStyle = 0
2414:             .Visible   = .T.
2415:         ENDWITH
2416: 
2417:         loc_oPagina.AddObject("txt_4c_Class4", "TextBox")
2418:         WITH loc_oPagina.txt_4c_Class4
2419:             .Value     = ""
2420:             .Top       = 534
2421:             .Left      = 654
2422:             .Width     = 30
2423:             .Height    = 23
2424:             .MaxLength = 1
2425:             .FontName  = "Tahoma"
2426:             .FontSize  = 8
2427:             .Visible   = .T.
2428:         ENDWITH
2429:         BINDEVENT(loc_oPagina.txt_4c_Class4, "KeyPress", THIS, "ValidarClass4s")
2430: 
2431:         loc_oPagina.AddObject("chk_4c_ObrigC4", "CheckBox")
2432:         WITH loc_oPagina.chk_4c_ObrigC4
2433:             .Caption   = "Obrigat" + CHR(243) + "ria"
2434:             .Top       = 536
2435:             .Left      = 689
2436:             .Width     = 80
2437:             .Height    = 17
2438:             .Value     = 0
2439:             .FontName  = "Tahoma"
2440:             .FontSize  = 8
2441:             .BackStyle = 0
2442:             .Visible   = .T.
2443:         ENDWITH
2444: 
2445:         THIS.TornarControlesVisiveis(loc_oPagina)
2446:     ENDPROC
2447: 
2448:     *==========================================================================
2449:     PROCEDURE CarregarLista()
2450:     *==========================================================================
2451:         LOCAL loc_lResultado, loc_oGrid
2452:         loc_lResultado = .F.
2453: 
2454:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
2455:             loc_lResultado = .T.
2456:         ELSE
2457:             TRY
2458:                 IF THIS.this_oBusinessObject.Buscar("")
2459:                     loc_lResultado = .T.
2460: 
2461:                     IF TYPE("THIS.pgf_4c_Paginas.Page1.grd_4c_Lista") = "O"
2462:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
2463:                         loc_oGrid.ColumnCount = 3
2464:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
2465:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Ndopes"
2466:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Dopes"
2467:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Opers"
2468:                         loc_oGrid.Column1.Header1.Caption = "N" + CHR(186)
2469:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2470:                         loc_oGrid.Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
2471:                         THIS.FormatarGridLista(loc_oGrid)
2472:                     ENDIF
2473:                 ENDIF
2474:             CATCH TO loc_oErro
2475:                 MsgErro(loc_oErro.Message, "FormOTI.CarregarLista")
2476:                 loc_lResultado = .F.
2477:             ENDTRY
2478:         ENDIF
2479: 
2480:         RETURN loc_lResultado
2481:     ENDPROC
2482: 
2483:     *==========================================================================
2484:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
2485:     *==========================================================================
2486:         LOCAL loc_lResultado
2487:         loc_lResultado = .F.
2488: 
2489:         TRY
2490:             IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
2491:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
2492:                 IF par_nPagina = 1
2493:                     THIS.CarregarLista()
2494:                 ENDIF
2495:                 loc_lResultado = .T.
2496:             ENDIF
2497:         CATCH TO loc_oErro
2498:             MsgErro(loc_oErro.Message, "FormOTI.AlternarPagina")
2499:             loc_lResultado = .F.
2500:         ENDTRY
2501: 
2502:         RETURN loc_lResultado
2503:     ENDPROC
2504: 
2505:     *==========================================================================
2506:     PROCEDURE BtnEncerrarClick()
2507:     *==========================================================================
2508:         THIS.Release()
2509:     ENDPROC
2510: 
2511:     *==========================================================================
2512:     PROCEDURE BtnIncluirClick()
2513:     *==========================================================================
2514:         LOCAL loc_lResultado, loc_nNdope, loc_nResult
2515:         loc_lResultado = .F.
2516: 
2517:         TRY
2518:             *-- Gerar pr" + CHR(243) + "ximo Ndope via MAX+1
2519:             loc_nResult = SQLEXEC(gnConnHandle, ;
2520:                 "SELECT ISNULL(MAX(Ndopes),0)+1 AS ProxNdope FROM SigOpOpe", ;
2521:                 "cursor_4c_NdopeTmp")
2522:             IF loc_nResult > 0 AND !EOF("cursor_4c_NdopeTmp")
2523:                 loc_nNdope = cursor_4c_NdopeTmp.ProxNdope
2524:             ELSE
2525:                 loc_nNdope = 1
2526:             ENDIF
2527:             IF USED("cursor_4c_NdopeTmp")
2528:                 USE IN cursor_4c_NdopeTmp
2529:             ENDIF
2530: 
2531:             THIS.this_oBusinessObject.NovoRegistro()
2532:             THIS.this_oBusinessObject.this_nNdopes = loc_nNdope
2533:             THIS.LimparCampos()
2534:             THIS.this_cModoAtual = "INCLUIR"
2535:             THIS.HabilitarCampos(.T.)
2536:             THIS.AjustarBotoesPorModo()
2537: 
2538:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Ndope", 5)
2539:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Ndope.Value = loc_nNdope
2540:             ENDIF
2541: 
2542:             THIS.pgf_4c_Paginas.ActivePage = 2
2543:             loc_lResultado = .T.
2544:         CATCH TO loc_oErro
2545:             MsgErro(loc_oErro.Message, "FormOTI.BtnIncluirClick")
2546:         ENDTRY
2547: 
2548:         IF USED("cursor_4c_NdopeTmp")
2549:             USE IN cursor_4c_NdopeTmp
2550:         ENDIF
2551: 
2552:         RETURN loc_lResultado
2553:     ENDPROC
2554: 
2555:     *==========================================================================
2556:     PROCEDURE BtnVisualizarClick()
2557:     *==========================================================================
2558:         LOCAL loc_lResultado, loc_nNdopes
2559:         loc_lResultado = .F.
2560: 
2561:         TRY
2562:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
2563:                 MsgAviso("Selecione um registro na lista.", "Visualizar")
2564:             ELSE
2565:                 SELECT cursor_4c_Dados
2566:                 loc_nNdopes = cursor_4c_Dados.Ndopes
2567:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nNdopes)
2568:                     THIS.this_cModoAtual = "VISUALIZAR"
2569:                     THIS.HabilitarCampos(.F.)
2570:                     THIS.AjustarBotoesPorModo()
2571:                     THIS.BOParaForm()
2572:                     THIS.pgf_4c_Paginas.ActivePage = 2
2573:                     loc_lResultado = .T.
2574:                 ELSE
2575:                     MsgErro("Erro ao carregar registro para visualiza" + CHR(231) + CHR(227) + "o.", "FormOTI")
2576:                 ENDIF
2577:             ENDIF
2578:         CATCH TO loc_oErro
2579:             MsgErro(loc_oErro.Message, "FormOTI.BtnVisualizarClick")
2580:         ENDTRY
2581: 
2582:         RETURN loc_lResultado
2583:     ENDPROC
2584: 
2585:     *==========================================================================
2586:     PROCEDURE BtnAlterarClick()
2587:     *==========================================================================
2588:         LOCAL loc_lResultado, loc_nNdopes
2589:         loc_lResultado = .F.
2590: 
2591:         TRY
2592:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
2593:                 MsgAviso("Selecione um registro na lista.", "Alterar")
2594:             ELSE
2595:                 SELECT cursor_4c_Dados
2596:                 loc_nNdopes = cursor_4c_Dados.Ndopes
2597:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nNdopes)
2598:                     THIS.this_oBusinessObject.EditarRegistro()
2599:                     THIS.this_cModoAtual = "ALTERAR"
2600:                     THIS.HabilitarCampos(.T.)
2601:                     THIS.AjustarBotoesPorModo()
2602:                     THIS.BOParaForm()
2603:                     THIS.pgf_4c_Paginas.ActivePage = 2
2604:                     loc_lResultado = .T.
2605:                 ELSE
2606:                     MsgErro("Erro ao carregar registro para altera" + CHR(231) + CHR(227) + "o.", "FormOTI")
2607:                 ENDIF
2608:             ENDIF
2609:         CATCH TO loc_oErro
2610:             MsgErro(loc_oErro.Message, "FormOTI.BtnAlterarClick")
2611:         ENDTRY
2612: 
2613:         RETURN loc_lResultado
2614:     ENDPROC
2615: 
2616:     *==========================================================================
2617:     PROCEDURE BtnExcluirClick()
2618:     *==========================================================================
2619:         LOCAL loc_lResultado, loc_nNdopes, loc_lConfirma
2620:         loc_lResultado = .F.
2621: 
2622:         TRY
2623:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
2624:                 MsgAviso("Selecione um registro na lista.", "Excluir")
2625:             ELSE
2626:                 SELECT cursor_4c_Dados
2627:                 loc_nNdopes   = cursor_4c_Dados.Ndopes
2628:                 loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o da opera" + CHR(231) + CHR(227) + "o selecionada?", "Excluir")
2629:                 IF loc_lConfirma
2630:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nNdopes)
2631:                         IF THIS.this_oBusinessObject.Excluir()
2632:                             MsgInfo("Opera" + CHR(231) + CHR(227) + "o exclu" + CHR(237) + "da com sucesso!", "Excluir")
2633:                             THIS.CarregarLista()
2634:                             loc_lResultado = .T.
2635:                         ELSE
2636:                             MsgErro("Erro ao excluir opera" + CHR(231) + CHR(227) + "o.", "FormOTI")
2637:                         ENDIF
2638:                     ELSE
2639:                         MsgErro("Erro ao localizar registro para exclus" + CHR(227) + "o.", "FormOTI")
2640:                     ENDIF
2641:                 ENDIF
2642:             ENDIF
2643:         CATCH TO loc_oErro
2644:             MsgErro(loc_oErro.Message, "FormOTI.BtnExcluirClick")
2645:         ENDTRY
2646: 
2647:         RETURN loc_lResultado
2648:     ENDPROC
2649: 
2650:     *==========================================================================
2651:     PROCEDURE BtnBuscarClick()
2652:     *==========================================================================
2653:         LOCAL loc_lResultado, loc_oBusca, loc_nNdope, loc_oGrid
2654:         loc_lResultado = .F.
2655: 
2656:         TRY
2657:             LOCAL loc_nResult
2658:             loc_nResult = SQLEXEC(gnConnHandle, ;
2659:                 "SELECT Ndopes, Dopes, Opers FROM SigOpOpe ORDER BY Dopes", ;
2660:                 "cursor_4c_BuscaOpe")
2661: 
2662:             IF loc_nResult > 0
2663:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2664:             ENDIF
2665: 
2666:             IF VARTYPE(loc_oBusca) = "O"
2667:                 loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaOpe"
2668:                 loc_oBusca.mAddColuna("Ndopes", "", "N" + CHR(186))
2669:                 loc_oBusca.mAddColuna("Dopes",  "", "Descri" + CHR(231) + CHR(227) + "o")
2670:                 loc_oBusca.mAddColuna("Opers",  "", "Opera" + CHR(231) + CHR(227) + "o")
2671:                 loc_oBusca.Show()
2672: 
2673:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
2674:                     loc_nNdope = cursor_4c_BuscaOpe.Ndopes
2675:                     THIS.CarregarLista()
2676:                     IF USED("cursor_4c_Dados")
2677:                         SELECT cursor_4c_Dados
2678:                         LOCATE FOR cursor_4c_Dados.Ndopes = loc_nNdope
2679:                     ENDIF
2680:                     loc_lResultado = .T.
2681:                 ENDIF
2682: 
2683:                 loc_oBusca.Release()
2684:             ENDIF
2685:         CATCH TO loc_oErro
2686:             MsgErro(loc_oErro.Message, "FormOTI.BtnBuscarClick")
2687:         ENDTRY
2688: 
2689:         IF USED("cursor_4c_BuscaOpe")
2690:             USE IN cursor_4c_BuscaOpe
2691:         ENDIF
2692: 
2693:         RETURN loc_lResultado
2694:     ENDPROC
2695: 
2696:     *==========================================================================
2697:     PROCEDURE BtnSalvarClick()
2698:     *==========================================================================
2699:         LOCAL loc_lResultado, loc_oPg2
2700:         loc_lResultado = .F.
2701:         loc_oPg2       = THIS.pgf_4c_Paginas.Page2
2702: 
2703:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2704:             IF PEMSTATUS(loc_oPg2, "txt_4c_Dope", 5)
2705:                 IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Dope.Value))
2706:                     MsgAviso("Descri" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria!", "Salvar")
2707:                     loc_oPg2.txt_4c_Dope.SetFocus()
2708:                     RETURN .F.
2709:                 ENDIF
2710:             ENDIF
2711:         ENDIF
2712: 
2713:         TRY
2714:             THIS.FormParaBO()
2715: 
2716:             IF THIS.this_oBusinessObject.Salvar()
2717:                 MsgInfo("Opera" + CHR(231) + CHR(227) + "o salva com sucesso!", "Salvar")
2718:                 THIS.this_cModoAtual = "LISTA"
2719:                 THIS.AlternarPagina(1)
2720:                 loc_lResultado = .T.
2721:             ELSE
2722:                 MsgErro("Erro ao salvar opera" + CHR(231) + CHR(227) + "o.", "FormOTI")
2723:             ENDIF
2724: 
2725:         CATCH TO loc_oErro
2726:             MsgErro(loc_oErro.Message, "FormOTI.BtnSalvarClick")
2727:         ENDTRY
2728: 
2729:         RETURN loc_lResultado
2730:     ENDPROC
2731: 
2732:     *==========================================================================
2733:     PROCEDURE BtnCancelarClick()
2734:     *==========================================================================
2735:         LOCAL loc_lResultado
2736:         loc_lResultado = .F.
2737: 
2738:         TRY
2739:             THIS.this_oBusinessObject.CancelarEdicao()
2740:             THIS.this_cModoAtual = "LISTA"
2741:             THIS.AlternarPagina(1)
2742:             loc_lResultado = .T.
2743:         CATCH TO loc_oErro
2744:             MsgErro(loc_oErro.Message, "FormOTI.BtnCancelarClick")
2745:         ENDTRY
2746: 
2747:         RETURN loc_lResultado
2748:     ENDPROC
2749: 
2750:     *==========================================================================
2751:     PROTECTED PROCEDURE FormParaBO()
2752:     *==========================================================================
2753:         LOCAL loc_oPg2, loc_oBO
2754:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2755:         loc_oBO  = THIS.this_oBusinessObject
2756: 
2757:         TRY
2758:             IF PEMSTATUS(loc_oPg2, "txt_4c_Ndope", 5)
2759:                 loc_oBO.this_nNdopes = loc_oPg2.txt_4c_Ndope.Value
2760:             ENDIF
2761:             IF PEMSTATUS(loc_oPg2, "txt_4c_Dope", 5)
2762:                 loc_oBO.this_cDopes = ALLTRIM(loc_oPg2.txt_4c_Dope.Value)
2763:             ENDIF
2764:             IF PEMSTATUS(loc_oPg2, "obj_4c_Opcao_oper", 5)
2765:                 loc_oBO.this_cOpers = IIF(loc_oPg2.obj_4c_Opcao_oper.Value = 1, "CR", "DB")
2766:             ENDIF
2767:             IF PEMSTATUS(loc_oPg2, "chk_4c_Chk_Inativar", 5)
2768:                 loc_oBO.this_nOpeCancs = IIF(loc_oPg2.chk_4c_Chk_Inativar.Value, 1, 0)
2769:             ENDIF
2770:             IF PEMSTATUS(loc_oPg2, "txt_4c_Hists", 5)
2771:                 loc_oBO.this_cHists = ALLTRIM(loc_oPg2.txt_4c_Hists.Value)
2772:             ENDIF
2773:             IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Compl", 5)
2774:                 loc_oBO.this_nTpHists = loc_oPg2.obj_4c_Opc_Compl.Value
2775:             ENDIF
2776:             IF PEMSTATUS(loc_oPg2, "txt_4c_Ident", 5)
2777:                 loc_oBO.this_cIdentifics = ALLTRIM(loc_oPg2.txt_4c_Ident.Value)
2778:             ENDIF
2779:             IF PEMSTATUS(loc_oPg2, "txt_4c_Opdepo", 5)
2780:                 loc_oBO.this_cOpdepos = ALLTRIM(loc_oPg2.txt_4c_Opdepo.Value)
2781:             ENDIF
2782:             IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Pend", 5)
2783:                 loc_oBO.this_nPendencias = loc_oPg2.obj_4c_Opc_Pend.Value
2784:             ENDIF
2785:             IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_valprev", 5)
2786:                 loc_oBO.this_nValprev = loc_oPg2.obj_4c_Opc_valprev.Value
2787:             ENDIF
2788:             IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_blqcc", 5)
2789:                 loc_oBO.this_nBlqccs = loc_oPg2.obj_4c_Opc_blqcc.Value
2790:             ENDIF
2791:             IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Transporte", 5)

*-- Linhas 2942 a 2985:
2942:     ENDPROC
2943: 
2944:     *==========================================================================
2945:     PROTECTED PROCEDURE BOParaForm()
2946:     *==========================================================================
2947:         LOCAL loc_oPg2, loc_oBO
2948:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2949:         loc_oBO  = THIS.this_oBusinessObject
2950: 
2951:         TRY
2952:             IF PEMSTATUS(loc_oPg2, "txt_4c_Ndope", 5)
2953:                 loc_oPg2.txt_4c_Ndope.Value = loc_oBO.this_nNdopes
2954:             ENDIF
2955:             IF PEMSTATUS(loc_oPg2, "txt_4c_Dope", 5)
2956:                 loc_oPg2.txt_4c_Dope.Value = loc_oBO.this_cDopes
2957:             ENDIF
2958:             IF PEMSTATUS(loc_oPg2, "obj_4c_Opcao_oper", 5)
2959:                 loc_oPg2.obj_4c_Opcao_oper.Value = IIF(loc_oBO.this_cOpers = "CR", 1, 2)
2960:             ENDIF
2961:             IF PEMSTATUS(loc_oPg2, "chk_4c_Chk_Inativar", 5)
2962:                 loc_oPg2.chk_4c_Chk_Inativar.Value = IIF(loc_oBO.this_nOpeCancs = 1, 1, 0)
2963:             ENDIF
2964:             IF PEMSTATUS(loc_oPg2, "txt_4c_Hists", 5)
2965:                 loc_oPg2.txt_4c_Hists.Value = loc_oBO.this_cHists
2966:             ENDIF
2967:             IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Compl", 5)
2968:                 loc_oPg2.obj_4c_Opc_Compl.Value = loc_oBO.this_nTpHists
2969:             ENDIF
2970:             IF PEMSTATUS(loc_oPg2, "txt_4c_Ident", 5)
2971:                 loc_oPg2.txt_4c_Ident.Value = loc_oBO.this_cIdentifics
2972:             ENDIF
2973:             IF PEMSTATUS(loc_oPg2, "txt_4c_Opdepo", 5)
2974:                 loc_oPg2.txt_4c_Opdepo.Value = loc_oBO.this_cOpdepos
2975:             ENDIF
2976:             IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Pend", 5)
2977:                 loc_oPg2.obj_4c_Opc_Pend.Value = loc_oBO.this_nPendencias
2978:             ENDIF
2979:             IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_valprev", 5)
2980:                 loc_oPg2.obj_4c_Opc_valprev.Value = loc_oBO.this_nValprev
2981:             ENDIF
2982:             IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_blqcc", 5)
2983:                 loc_oPg2.obj_4c_Opc_blqcc.Value = loc_oBO.this_nBlqccs
2984:             ENDIF
2985:             IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Transporte", 5)

*-- Linhas 3151 a 3194:
3151:     ENDPROC
3152: 
3153:     *==========================================================================
3154:     PROTECTED PROCEDURE LimparCampos()
3155:     *==========================================================================
3156:         LOCAL loc_oPg2
3157:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3158: 
3159:         TRY
3160:             IF PEMSTATUS(loc_oPg2, "txt_4c_Ndope", 5)
3161:                 loc_oPg2.txt_4c_Ndope.Value = 0
3162:             ENDIF
3163:             IF PEMSTATUS(loc_oPg2, "txt_4c_Dope", 5)
3164:                 loc_oPg2.txt_4c_Dope.Value = ""
3165:             ENDIF
3166:             IF PEMSTATUS(loc_oPg2, "obj_4c_Opcao_oper", 5)
3167:                 loc_oPg2.obj_4c_Opcao_oper.Value = 1
3168:             ENDIF
3169:             IF PEMSTATUS(loc_oPg2, "chk_4c_Chk_Inativar", 5)
3170:                 loc_oPg2.chk_4c_Chk_Inativar.Value = 0
3171:             ENDIF
3172:             IF PEMSTATUS(loc_oPg2, "txt_4c_Opdepo", 5)
3173:                 loc_oPg2.txt_4c_Opdepo.Value = ""
3174:             ENDIF
3175:             IF PEMSTATUS(loc_oPg2, "txt_4c_Hists", 5)
3176:                 loc_oPg2.txt_4c_Hists.Value = ""
3177:             ENDIF
3178:             IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Compl", 5)
3179:                 loc_oPg2.obj_4c_Opc_Compl.Value = 2
3180:             ENDIF
3181:             IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Pend", 5)
3182:                 loc_oPg2.obj_4c_Opc_Pend.Value = 1
3183:             ENDIF
3184:             IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_valprev", 5)
3185:                 loc_oPg2.obj_4c_Opc_valprev.Value = 2
3186:             ENDIF
3187:             IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_blqcc", 5)
3188:                 loc_oPg2.obj_4c_Opc_blqcc.Value = 2
3189:             ENDIF
3190:             IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Transporte", 5)
3191:                 loc_oPg2.obj_4c_Opc_Transporte.Value = 1
3192:             ENDIF
3193:             IF PEMSTATUS(loc_oPg2, "obj_4c_Get_OutroTit", 5)
3194:                 loc_oPg2.obj_4c_Get_OutroTit.Value = 2

*-- Linhas 3358 a 3401:
3358:     ENDPROC
3359: 
3360:     *==========================================================================
3361:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
3362:     *==========================================================================
3363:         LOCAL loc_oPg2, loc_nTipo
3364:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
3365:         loc_nTipo = 1
3366: 
3367:         TRY
3368:             IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_realprev", 5)
3369:                 loc_nTipo = loc_oPg2.obj_4c_Opc_realprev.Value
3370:             ENDIF
3371: 
3372:             IF PEMSTATUS(loc_oPg2, "txt_4c_Dope", 5)
3373:                 loc_oPg2.txt_4c_Dope.Enabled = par_lHabilitar
3374:             ENDIF
3375:             IF PEMSTATUS(loc_oPg2, "obj_4c_Opcao_oper", 5)
3376:                 loc_oPg2.obj_4c_Opcao_oper.Enabled = par_lHabilitar
3377:             ENDIF
3378:             IF PEMSTATUS(loc_oPg2, "chk_4c_Chk_Inativar", 5)
3379:                 loc_oPg2.chk_4c_Chk_Inativar.Enabled = par_lHabilitar
3380:             ENDIF
3381:             IF PEMSTATUS(loc_oPg2, "txt_4c_Opdepo", 5)
3382:                 loc_oPg2.txt_4c_Opdepo.Enabled = par_lHabilitar
3383:             ENDIF
3384:             IF PEMSTATUS(loc_oPg2, "txt_4c_Hists", 5)
3385:                 loc_oPg2.txt_4c_Hists.Enabled = par_lHabilitar
3386:             ENDIF
3387:             IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Compl", 5)
3388:                 loc_oPg2.obj_4c_Opc_Compl.Enabled = par_lHabilitar
3389:             ENDIF
3390:             IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Pend", 5)
3391:                 loc_oPg2.obj_4c_Opc_Pend.Enabled = par_lHabilitar
3392:             ENDIF
3393:             IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_valprev", 5)
3394:                 loc_oPg2.obj_4c_Opc_valprev.Enabled = par_lHabilitar
3395:             ENDIF
3396:             IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_blqcc", 5)
3397:                 loc_oPg2.obj_4c_Opc_blqcc.Enabled = par_lHabilitar
3398:             ENDIF
3399:             IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Transporte", 5)
3400:                 loc_oPg2.obj_4c_Opc_Transporte.Enabled = par_lHabilitar
3401:             ENDIF

*-- Linhas 3486 a 3507:
3486:                 loc_oPg2.txt_4c_VlrLimApv.Enabled = par_lHabilitar
3487:             ENDIF
3488:             IF PEMSTATUS(loc_oPg2, "txt_4c_Pasta", 5)
3489:                 loc_oPg2.txt_4c_Pasta.Enabled = par_lHabilitar
3490:             ENDIF
3491:             IF PEMSTATUS(loc_oPg2, "cmd_4c_BtnPastasCl", 5)
3492:                 loc_oPg2.cmd_4c_BtnPastasCl.Enabled = par_lHabilitar
3493:             ENDIF
3494:             IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo1", 5)
3495:                 loc_oPg2.txt_4c_Grupo1.Enabled = par_lHabilitar
3496:             ENDIF
3497:             IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo2", 5)
3498:                 loc_oPg2.txt_4c_Grupo2.Enabled = par_lHabilitar
3499:             ENDIF
3500:             IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo3", 5)
3501:                 loc_oPg2.txt_4c_Grupo3.Enabled = par_lHabilitar
3502:             ENDIF
3503:             IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo4", 5)
3504:                 loc_oPg2.txt_4c_Grupo4.Enabled = par_lHabilitar
3505:             ENDIF
3506:             IF PEMSTATUS(loc_oPg2, "txt_4c_Txt01", 5)
3507:                 loc_oPg2.txt_4c_Txt01.Enabled = par_lHabilitar

*-- Linhas 3564 a 4395:
3564:     ENDPROC
3565: 
3566:     *==========================================================================
3567:     PROCEDURE OpcRealprevChanged()
3568:     *==========================================================================
3569:         LOCAL loc_oPg2, loc_nTipo, loc_lHabilitar
3570:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3571: 
3572:         TRY
3573:             IF !PEMSTATUS(loc_oPg2, "obj_4c_Opc_realprev", 5)
3574:                 RETURN
3575:             ENDIF
3576: 
3577:             loc_nTipo      = loc_oPg2.obj_4c_Opc_realprev.Value
3578:             loc_lHabilitar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3579: 
3580:             IF PEMSTATUS(loc_oPg2, "txt_4c_DopCanc", 5)
3581:                 loc_oPg2.txt_4c_DopCanc.Enabled = loc_lHabilitar AND (loc_nTipo = 1)
3582:                 IF loc_nTipo # 1
3583:                     loc_oPg2.txt_4c_DopCanc.Value = ""
3584:                 ENDIF
3585:             ENDIF
3586:             IF PEMSTATUS(loc_oPg2, "txt_4c_DopReal", 5)
3587:                 loc_oPg2.txt_4c_DopReal.Enabled = loc_lHabilitar AND (loc_nTipo = 2)
3588:                 IF loc_nTipo # 2
3589:                     loc_oPg2.txt_4c_DopReal.Value = ""
3590:                 ENDIF
3591:             ENDIF
3592: 
3593:         CATCH TO loc_oErro
3594:             MsgErro(loc_oErro.Message, "FormOTI.OpcRealprevChanged")
3595:         ENDTRY
3596:     ENDPROC
3597: 
3598:     *==========================================================================
3599:     PROCEDURE ChkInativarChanged()
3600:     *==========================================================================
3601:         LOCAL loc_oPg2
3602:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3603: 
3604:         TRY
3605:             IF !PEMSTATUS(loc_oPg2, "chk_4c_Chk_Inativar", 5)
3606:                 RETURN
3607:             ENDIF
3608: 
3609:             IF loc_oPg2.chk_4c_Chk_Inativar.Value
3610:                 IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_realprev", 5)
3611:                     loc_oPg2.obj_4c_Opc_realprev.Value = 1
3612:                 ENDIF
3613:                 IF PEMSTATUS(loc_oPg2, "txt_4c_DopCanc", 5)
3614:                     loc_oPg2.txt_4c_DopCanc.Value   = ""
3615:                     loc_oPg2.txt_4c_DopCanc.Enabled = .F.
3616:                 ENDIF
3617:                 IF PEMSTATUS(loc_oPg2, "txt_4c_DopReal", 5)
3618:                     loc_oPg2.txt_4c_DopReal.Value   = ""
3619:                     loc_oPg2.txt_4c_DopReal.Enabled = .F.
3620:                 ENDIF
3621:             ENDIF
3622: 
3623:         CATCH TO loc_oErro
3624:             MsgErro(loc_oErro.Message, "FormOTI.ChkInativarChanged")
3625:         ENDTRY
3626:     ENDPROC
3627: 
3628:     *==========================================================================
3629:     PROCEDURE ValidarOpdepo(par_nKeyCode, par_nShiftAltCtrl)
3630:     *==========================================================================
3631:         LOCAL loc_oPg2, loc_cOpdepo, loc_oBusca, loc_cSQL, loc_nResult
3632:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3633: 
3634:         TRY
3635:             IF !PEMSTATUS(loc_oPg2, "txt_4c_Opdepo", 5)
3636:                 RETURN
3637:             ENDIF
3638:             loc_cOpdepo = ALLTRIM(loc_oPg2.txt_4c_Opdepo.Value)
3639:             IF EMPTY(loc_cOpdepo)
3640:                 RETURN
3641:             ENDIF
3642: 
3643:             *-- Testa match exato
3644:             loc_cSQL    = "SELECT TOP 1 Operacaos FROM SigCdOpt WHERE Operacaos = " + EscaparSQL(loc_cOpdepo)
3645:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOpt")
3646:             IF loc_nResult > 0 AND !EOF("cursor_4c_BuscaOpt")
3647:                 RETURN
3648:             ENDIF
3649: 
3650:             *-- Sem match exato - abre picker com todos registros
3651:             IF USED("cursor_4c_BuscaOpt")
3652:                 USE IN cursor_4c_BuscaOpt
3653:             ENDIF
3654:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
3655:                 "SELECT Operacaos, Descrs FROM SigCdOpt ORDER BY Operacaos", ;
3656:                 "cursor_4c_BuscaOpt")
3657:             IF VARTYPE(loc_oBusca) = "O"
3658:                 loc_oBusca.mAddColuna("Operacaos", "", "C" + CHR(243) + "digo")
3659:                 loc_oBusca.mAddColuna("Descrs",    "", "Descri" + CHR(231) + CHR(227) + "o")
3660:                 loc_oBusca.Show()
3661:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpt")
3662:                     loc_oPg2.txt_4c_Opdepo.Value = ALLTRIM(cursor_4c_BuscaOpt.Operacaos)
3663:                 ELSE
3664:                     loc_oPg2.txt_4c_Opdepo.Value = ""
3665:                 ENDIF
3666:                 loc_oBusca.Release()
3667:             ENDIF
3668: 
3669:         CATCH TO loc_oErro
3670:             MsgErro(loc_oErro.Message, "FormOTI.ValidarOpdepo")
3671:         ENDTRY
3672: 
3673:         IF USED("cursor_4c_BuscaOpt")
3674:             USE IN cursor_4c_BuscaOpt
3675:         ENDIF
3676:     ENDPROC
3677: 
3678:     *==========================================================================
3679:     PROCEDURE ValidarDopReal(par_nKeyCode, par_nShiftAltCtrl)
3680:     *==========================================================================
3681:         LOCAL loc_oPg2, loc_cDopReal, loc_cSQL, loc_nResult, loc_oBusca
3682:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3683: 
3684:         TRY
3685:             IF !PEMSTATUS(loc_oPg2, "txt_4c_DopReal", 5)
3686:                 RETURN
3687:             ENDIF
3688:             loc_cDopReal = ALLTRIM(loc_oPg2.txt_4c_DopReal.Value)
3689:             IF EMPTY(loc_cDopReal)
3690:                 RETURN
3691:             ENDIF
3692: 
3693:             loc_cSQL    = "SELECT Dopes FROM SigOpOpe WHERE RealPrevs <> 2"
3694:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpeR")
3695: 
3696:             IF loc_nResult > 0
3697:                 SELECT cursor_4c_TmpOpeR
3698:                 LOCATE FOR ALLTRIM(cursor_4c_TmpOpeR.Dopes) == ALLTRIM(loc_cDopReal)
3699:                 IF FOUND("cursor_4c_TmpOpeR")
3700:                     loc_oPg2.txt_4c_DopReal.Value = ALLTRIM(cursor_4c_TmpOpeR.Dopes)
3701:                 ELSE
3702:                     GO TOP IN cursor_4c_TmpOpeR
3703:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3704:                     IF VARTYPE(loc_oBusca) = "O"
3705:                         loc_oBusca.this_cCursorDestino = "cursor_4c_TmpOpeR"
3706:                         loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
3707:                         loc_oBusca.Show()
3708:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_TmpOpeR")
3709:                             loc_oPg2.txt_4c_DopReal.Value = ALLTRIM(cursor_4c_TmpOpeR.Dopes)
3710:                         ELSE
3711:                             loc_oPg2.txt_4c_DopReal.Value = ""
3712:                         ENDIF
3713:                         loc_oBusca.Release()
3714:                     ENDIF
3715:                 ENDIF
3716:             ENDIF
3717: 
3718:         CATCH TO loc_oErro
3719:             MsgErro(loc_oErro.Message, "FormOTI.ValidarDopReal")
3720:         ENDTRY
3721: 
3722:         IF USED("cursor_4c_TmpOpeR")
3723:             USE IN cursor_4c_TmpOpeR
3724:         ENDIF
3725:     ENDPROC
3726: 
3727:     *==========================================================================
3728:     PROCEDURE ValidarDopCanc(par_nKeyCode, par_nShiftAltCtrl)
3729:     *==========================================================================
3730:         LOCAL loc_oPg2, loc_cDopCanc, loc_cSQL, loc_nResult, loc_oBusca
3731:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3732: 
3733:         TRY
3734:             IF !PEMSTATUS(loc_oPg2, "txt_4c_DopCanc", 5)
3735:                 RETURN
3736:             ENDIF
3737:             loc_cDopCanc = ALLTRIM(loc_oPg2.txt_4c_DopCanc.Value)
3738:             IF EMPTY(loc_cDopCanc)
3739:                 RETURN
3740:             ENDIF
3741: 
3742:             loc_cSQL    = "SELECT Dopes FROM SigOpOpe WHERE OpeCancs = 1"
3743:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCanc")
3744: 
3745:             IF loc_nResult > 0
3746:                 SELECT cursor_4c_TmpCanc
3747:                 LOCATE FOR ALLTRIM(cursor_4c_TmpCanc.Dopes) == ALLTRIM(loc_cDopCanc)
3748:                 IF FOUND("cursor_4c_TmpCanc")
3749:                     loc_oPg2.txt_4c_DopCanc.Value = ALLTRIM(cursor_4c_TmpCanc.Dopes)
3750:                 ELSE
3751:                     GO TOP IN cursor_4c_TmpCanc
3752:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3753:                     IF VARTYPE(loc_oBusca) = "O"
3754:                         loc_oBusca.this_cCursorDestino = "cursor_4c_TmpCanc"
3755:                         loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
3756:                         loc_oBusca.Show()
3757:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_TmpCanc")
3758:                             loc_oPg2.txt_4c_DopCanc.Value = ALLTRIM(cursor_4c_TmpCanc.Dopes)
3759:                         ELSE
3760:                             loc_oPg2.txt_4c_DopCanc.Value = ""
3761:                         ENDIF
3762:                         loc_oBusca.Release()
3763:                     ENDIF
3764:                 ENDIF
3765:             ENDIF
3766: 
3767:         CATCH TO loc_oErro
3768:             MsgErro(loc_oErro.Message, "FormOTI.ValidarDopCanc")
3769:         ENDTRY
3770: 
3771:         IF USED("cursor_4c_TmpCanc")
3772:             USE IN cursor_4c_TmpCanc
3773:         ENDIF
3774:     ENDPROC
3775: 
3776:     *==========================================================================
3777:     PROCEDURE ValidarVias(par_nKeyCode, par_nShiftAltCtrl)
3778:     *==========================================================================
3779:         LOCAL loc_oPg2
3780:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3781: 
3782:         TRY
3783:             IF PEMSTATUS(loc_oPg2, "txt_4c_Vias", 5)
3784:                 IF loc_oPg2.txt_4c_Vias.Value < 0
3785:                     MsgAviso("Valor Inv" + CHR(225) + "lido ...", "Vias Boleto")
3786:                     loc_oPg2.txt_4c_Vias.Value = 0
3787:                 ENDIF
3788:             ENDIF
3789:         CATCH TO loc_oErro
3790:             MsgErro(loc_oErro.Message, "FormOTI.ValidarVias")
3791:         ENDTRY
3792:     ENDPROC
3793: 
3794:     *==========================================================================
3795:     PROCEDURE ValidarDiasVcto(par_nKeyCode, par_nShiftAltCtrl)
3796:     *==========================================================================
3797:         LOCAL loc_oPg2, loc_oErro
3798:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3799: 
3800:         TRY
3801:             IF PEMSTATUS(loc_oPg2, "txt_4c_DiasVcto", 5)
3802:                 IF loc_oPg2.txt_4c_DiasVcto.Value < 0
3803:                     MsgAviso("Valor Inv" + CHR(225) + "lido ...", "Dias Vencimento")
3804:                     loc_oPg2.txt_4c_DiasVcto.Value = 0
3805:                 ENDIF
3806:             ENDIF
3807:         CATCH TO loc_oErro
3808:             MsgErro(loc_oErro.Message, "FormOTI.ValidarDiasVcto")
3809:         ENDTRY
3810:     ENDPROC
3811: 
3812:     *==========================================================================
3813:     PROCEDURE ValidarMoeda(par_nKeyCode, par_nShiftAltCtrl)
3814:     *==========================================================================
3815:         LOCAL loc_oPg2, loc_cMoeda, loc_cSQL, loc_nResult, loc_oBusca, loc_oErro
3816:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3817: 
3818:         TRY
3819:             IF !PEMSTATUS(loc_oPg2, "txt_4c_Moeda", 5)
3820:                 RETURN
3821:             ENDIF
3822:             loc_cMoeda = ALLTRIM(loc_oPg2.txt_4c_Moeda.Value)
3823:             IF EMPTY(loc_cMoeda)
3824:                 RETURN
3825:             ENDIF
3826: 
3827:             loc_cSQL    = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
3828:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoe")
3829:             IF loc_nResult > 0
3830:                 SELECT cursor_4c_BuscaMoe
3831:                 LOCATE FOR ALLTRIM(cursor_4c_BuscaMoe.CMoes) == ALLTRIM(loc_cMoeda)
3832:                 IF FOUND("cursor_4c_BuscaMoe")
3833:                     loc_oPg2.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
3834:                 ELSE
3835:                     GO TOP IN cursor_4c_BuscaMoe
3836:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3837:                     IF VARTYPE(loc_oBusca) = "O"
3838:                         loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaMoe"
3839:                         loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
3840:                         loc_oBusca.mAddColuna("DMoes", "", "Moeda")
3841:                         loc_oBusca.Show()
3842:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
3843:                             loc_oPg2.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
3844:                         ELSE
3845:                             loc_oPg2.txt_4c_Moeda.Value = ""
3846:                         ENDIF
3847:                         loc_oBusca.Release()
3848:                     ENDIF
3849:                 ENDIF
3850:             ENDIF
3851: 
3852:         CATCH TO loc_oErro
3853:             MsgErro(loc_oErro.Message, "FormOTI.ValidarMoeda")
3854:         ENDTRY
3855: 
3856:         IF USED("cursor_4c_BuscaMoe")
3857:             USE IN cursor_4c_BuscaMoe
3858:         ENDIF
3859:     ENDPROC
3860: 
3861:     *==========================================================================
3862:     PROCEDURE BtnPastasCClick()
3863:     *==========================================================================
3864:         LOCAL loc_oPg2, loc_cPasta, loc_oErro
3865:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3866: 
3867:         TRY
3868:             loc_cPasta = GETDIR("", "Selecione a Pasta")
3869:             IF !EMPTY(loc_cPasta)
3870:                 IF PEMSTATUS(loc_oPg2, "txt_4c_Pasta", 5)
3871:                     loc_oPg2.txt_4c_Pasta.Value = loc_cPasta
3872:                 ENDIF
3873:             ENDIF
3874:         CATCH TO loc_oErro
3875:             MsgErro(loc_oErro.Message, "FormOTI.BtnPastasCClick")
3876:         ENDTRY
3877:     ENDPROC
3878: 
3879:     *==========================================================================
3880:     PROCEDURE ValidarGrpCad1s(par_nKeyCode, par_nShiftAltCtrl)
3881:     *==========================================================================
3882:         LOCAL loc_oPg2, loc_cCod, loc_cDesc, loc_cSQL, loc_nResult, loc_oBusca, loc_oErro
3883:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3884: 
3885:         TRY
3886:             IF !PEMSTATUS(loc_oPg2, "txt_4c_GrpCad1", 5)
3887:                 RETURN
3888:             ENDIF
3889:             loc_cCod = ALLTRIM(loc_oPg2.txt_4c_GrpCad1.Value)
3890:             IF EMPTY(loc_cCod)
3891:                 IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad1", 5)
3892:                     loc_oPg2.txt_4c_DGrpCad1.Value = ""
3893:                 ENDIF
3894:                 RETURN
3895:             ENDIF
3896: 
3897:             loc_cDesc = THIS.this_oBusinessObject.BuscarDescricaoGrpCad(loc_cCod)
3898:             IF !EMPTY(loc_cDesc)
3899:                 IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad1", 5)
3900:                     loc_oPg2.txt_4c_DGrpCad1.Value = loc_cDesc
3901:                 ENDIF
3902:                 RETURN
3903:             ENDIF
3904: 
3905:             loc_cSQL    = "SELECT Codigos, Descrs FROM SigCdGcr ORDER BY Codigos"
3906:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGcr1")
3907:             IF loc_nResult > 0
3908:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3909:                 IF VARTYPE(loc_oBusca) = "O"
3910:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGcr1"
3911:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
3912:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
3913:                     loc_oBusca.Show()
3914:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr1")
3915:                         loc_oPg2.txt_4c_GrpCad1.Value = ALLTRIM(cursor_4c_BuscaGcr1.Codigos)
3916:                         IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad1", 5)
3917:                             loc_oPg2.txt_4c_DGrpCad1.Value = ALLTRIM(cursor_4c_BuscaGcr1.Descrs)
3918:                         ENDIF
3919:                     ELSE
3920:                         loc_oPg2.txt_4c_GrpCad1.Value = ""
3921:                         IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad1", 5)
3922:                             loc_oPg2.txt_4c_DGrpCad1.Value = ""
3923:                         ENDIF
3924:                     ENDIF
3925:                     loc_oBusca.Release()
3926:                 ENDIF
3927:             ENDIF
3928: 
3929:         CATCH TO loc_oErro
3930:             MsgErro(loc_oErro.Message, "FormOTI.ValidarGrpCad1s")
3931:         ENDTRY
3932: 
3933:         IF USED("cursor_4c_BuscaGcr1")
3934:             USE IN cursor_4c_BuscaGcr1
3935:         ENDIF
3936:     ENDPROC
3937: 
3938:     *==========================================================================
3939:     PROCEDURE ValidarGrpCad2s(par_nKeyCode, par_nShiftAltCtrl)
3940:     *==========================================================================
3941:         LOCAL loc_oPg2, loc_cCod, loc_cDesc, loc_cSQL, loc_nResult, loc_oBusca, loc_oErro
3942:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3943: 
3944:         TRY
3945:             IF !PEMSTATUS(loc_oPg2, "txt_4c_GrpCad2", 5)
3946:                 RETURN
3947:             ENDIF
3948:             loc_cCod = ALLTRIM(loc_oPg2.txt_4c_GrpCad2.Value)
3949:             IF EMPTY(loc_cCod)
3950:                 IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad2", 5)
3951:                     loc_oPg2.txt_4c_DGrpCad2.Value = ""
3952:                 ENDIF
3953:                 RETURN
3954:             ENDIF
3955: 
3956:             loc_cDesc = THIS.this_oBusinessObject.BuscarDescricaoGrpCad(loc_cCod)
3957:             IF !EMPTY(loc_cDesc)
3958:                 IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad2", 5)
3959:                     loc_oPg2.txt_4c_DGrpCad2.Value = loc_cDesc
3960:                 ENDIF
3961:                 RETURN
3962:             ENDIF
3963: 
3964:             loc_cSQL    = "SELECT Codigos, Descrs FROM SigCdGcr ORDER BY Codigos"
3965:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGcr2")
3966:             IF loc_nResult > 0
3967:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3968:                 IF VARTYPE(loc_oBusca) = "O"
3969:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGcr2"
3970:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
3971:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
3972:                     loc_oBusca.Show()
3973:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr2")
3974:                         loc_oPg2.txt_4c_GrpCad2.Value = ALLTRIM(cursor_4c_BuscaGcr2.Codigos)
3975:                         IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad2", 5)
3976:                             loc_oPg2.txt_4c_DGrpCad2.Value = ALLTRIM(cursor_4c_BuscaGcr2.Descrs)
3977:                         ENDIF
3978:                     ELSE
3979:                         loc_oPg2.txt_4c_GrpCad2.Value = ""
3980:                         IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad2", 5)
3981:                             loc_oPg2.txt_4c_DGrpCad2.Value = ""
3982:                         ENDIF
3983:                     ENDIF
3984:                     loc_oBusca.Release()
3985:                 ENDIF
3986:             ENDIF
3987: 
3988:         CATCH TO loc_oErro
3989:             MsgErro(loc_oErro.Message, "FormOTI.ValidarGrpCad2s")
3990:         ENDTRY
3991: 
3992:         IF USED("cursor_4c_BuscaGcr2")
3993:             USE IN cursor_4c_BuscaGcr2
3994:         ENDIF
3995:     ENDPROC
3996: 
3997:     *==========================================================================
3998:     PROCEDURE ValidarGrpCad3s(par_nKeyCode, par_nShiftAltCtrl)
3999:     *==========================================================================
4000:         LOCAL loc_oPg2, loc_cCod, loc_cDesc, loc_cSQL, loc_nResult, loc_oBusca, loc_oErro
4001:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4002: 
4003:         TRY
4004:             IF !PEMSTATUS(loc_oPg2, "txt_4c_GrpCad3", 5)
4005:                 RETURN
4006:             ENDIF
4007:             loc_cCod = ALLTRIM(loc_oPg2.txt_4c_GrpCad3.Value)
4008:             IF EMPTY(loc_cCod)
4009:                 IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad3", 5)
4010:                     loc_oPg2.txt_4c_DGrpCad3.Value = ""
4011:                 ENDIF
4012:                 RETURN
4013:             ENDIF
4014: 
4015:             loc_cDesc = THIS.this_oBusinessObject.BuscarDescricaoGrpCad(loc_cCod)
4016:             IF !EMPTY(loc_cDesc)
4017:                 IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad3", 5)
4018:                     loc_oPg2.txt_4c_DGrpCad3.Value = loc_cDesc
4019:                 ENDIF
4020:                 RETURN
4021:             ENDIF
4022: 
4023:             loc_cSQL    = "SELECT Codigos, Descrs FROM SigCdGcr ORDER BY Codigos"
4024:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGcr3")
4025:             IF loc_nResult > 0
4026:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4027:                 IF VARTYPE(loc_oBusca) = "O"
4028:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGcr3"
4029:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
4030:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
4031:                     loc_oBusca.Show()
4032:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr3")
4033:                         loc_oPg2.txt_4c_GrpCad3.Value = ALLTRIM(cursor_4c_BuscaGcr3.Codigos)
4034:                         IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad3", 5)
4035:                             loc_oPg2.txt_4c_DGrpCad3.Value = ALLTRIM(cursor_4c_BuscaGcr3.Descrs)
4036:                         ENDIF
4037:                     ELSE
4038:                         loc_oPg2.txt_4c_GrpCad3.Value = ""
4039:                         IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad3", 5)
4040:                             loc_oPg2.txt_4c_DGrpCad3.Value = ""
4041:                         ENDIF
4042:                     ENDIF
4043:                     loc_oBusca.Release()
4044:                 ENDIF
4045:             ENDIF
4046: 
4047:         CATCH TO loc_oErro
4048:             MsgErro(loc_oErro.Message, "FormOTI.ValidarGrpCad3s")
4049:         ENDTRY
4050: 
4051:         IF USED("cursor_4c_BuscaGcr3")
4052:             USE IN cursor_4c_BuscaGcr3
4053:         ENDIF
4054:     ENDPROC
4055: 
4056:     *==========================================================================
4057:     PROCEDURE ValidarGrpCad4s(par_nKeyCode, par_nShiftAltCtrl)
4058:     *==========================================================================
4059:         LOCAL loc_oPg2, loc_cCod, loc_cDesc, loc_cSQL, loc_nResult, loc_oBusca, loc_oErro
4060:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4061: 
4062:         TRY
4063:             IF !PEMSTATUS(loc_oPg2, "txt_4c_GrpCad4", 5)
4064:                 RETURN
4065:             ENDIF
4066:             loc_cCod = ALLTRIM(loc_oPg2.txt_4c_GrpCad4.Value)
4067:             IF EMPTY(loc_cCod)
4068:                 IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad4", 5)
4069:                     loc_oPg2.txt_4c_DGrpCad4.Value = ""
4070:                 ENDIF
4071:                 RETURN
4072:             ENDIF
4073: 
4074:             loc_cDesc = THIS.this_oBusinessObject.BuscarDescricaoGrpCad(loc_cCod)
4075:             IF !EMPTY(loc_cDesc)
4076:                 IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad4", 5)
4077:                     loc_oPg2.txt_4c_DGrpCad4.Value = loc_cDesc
4078:                 ENDIF
4079:                 RETURN
4080:             ENDIF
4081: 
4082:             loc_cSQL    = "SELECT Codigos, Descrs FROM SigCdGcr ORDER BY Codigos"
4083:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGcr4")
4084:             IF loc_nResult > 0
4085:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4086:                 IF VARTYPE(loc_oBusca) = "O"
4087:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGcr4"
4088:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
4089:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
4090:                     loc_oBusca.Show()
4091:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr4")
4092:                         loc_oPg2.txt_4c_GrpCad4.Value = ALLTRIM(cursor_4c_BuscaGcr4.Codigos)
4093:                         IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad4", 5)
4094:                             loc_oPg2.txt_4c_DGrpCad4.Value = ALLTRIM(cursor_4c_BuscaGcr4.Descrs)
4095:                         ENDIF
4096:                     ELSE
4097:                         loc_oPg2.txt_4c_GrpCad4.Value = ""
4098:                         IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad4", 5)
4099:                             loc_oPg2.txt_4c_DGrpCad4.Value = ""
4100:                         ENDIF
4101:                     ENDIF
4102:                     loc_oBusca.Release()
4103:                 ENDIF
4104:             ENDIF
4105: 
4106:         CATCH TO loc_oErro
4107:             MsgErro(loc_oErro.Message, "FormOTI.ValidarGrpCad4s")
4108:         ENDTRY
4109: 
4110:         IF USED("cursor_4c_BuscaGcr4")
4111:             USE IN cursor_4c_BuscaGcr4
4112:         ENDIF
4113:     ENDPROC
4114: 
4115:     *==========================================================================
4116:     PROCEDURE ValidarClass1s(par_nKeyCode, par_nShiftAltCtrl)
4117:     *==========================================================================
4118:         LOCAL loc_oPg2, loc_cCod, loc_cSQL, loc_nResult, loc_oBusca, loc_oErro
4119:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4120: 
4121:         TRY
4122:             IF !PEMSTATUS(loc_oPg2, "txt_4c_Class1", 5)
4123:                 RETURN
4124:             ENDIF
4125:             loc_cCod = ALLTRIM(loc_oPg2.txt_4c_Class1.Value)
4126:             IF EMPTY(loc_cCod)
4127:                 RETURN
4128:             ENDIF
4129: 
4130:             loc_cSQL    = "SELECT Classes, Descrs FROM SigCdCss WHERE LEN(RTRIM(Classes))=1 ORDER BY Classes"
4131:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCss1")
4132:             IF loc_nResult > 0
4133:                 SELECT cursor_4c_BuscaCss1
4134:                 LOCATE FOR ALLTRIM(cursor_4c_BuscaCss1.Classes) == ALLTRIM(loc_cCod)
4135:                 IF FOUND("cursor_4c_BuscaCss1")
4136:                     loc_oPg2.txt_4c_Class1.Value = ALLTRIM(cursor_4c_BuscaCss1.Classes)
4137:                 ELSE
4138:                     GO TOP IN cursor_4c_BuscaCss1
4139:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4140:                     IF VARTYPE(loc_oBusca) = "O"
4141:                         loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCss1"
4142:                         loc_oBusca.mAddColuna("Classes", "", "C" + CHR(243) + "digo")
4143:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
4144:                         loc_oBusca.Show()
4145:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCss1")
4146:                             loc_oPg2.txt_4c_Class1.Value = ALLTRIM(cursor_4c_BuscaCss1.Classes)
4147:                         ELSE
4148:                             loc_oPg2.txt_4c_Class1.Value = ""
4149:                         ENDIF
4150:                         loc_oBusca.Release()
4151:                     ENDIF
4152:                 ENDIF
4153:             ENDIF
4154: 
4155:         CATCH TO loc_oErro
4156:             MsgErro(loc_oErro.Message, "FormOTI.ValidarClass1s")
4157:         ENDTRY
4158: 
4159:         IF USED("cursor_4c_BuscaCss1")
4160:             USE IN cursor_4c_BuscaCss1
4161:         ENDIF
4162:     ENDPROC
4163: 
4164:     *==========================================================================
4165:     PROCEDURE ValidarClass2s(par_nKeyCode, par_nShiftAltCtrl)
4166:     *==========================================================================
4167:         LOCAL loc_oPg2, loc_cCod, loc_cSQL, loc_nResult, loc_oBusca, loc_oErro
4168:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4169: 
4170:         TRY
4171:             IF !PEMSTATUS(loc_oPg2, "txt_4c_Class2", 5)
4172:                 RETURN
4173:             ENDIF
4174:             loc_cCod = ALLTRIM(loc_oPg2.txt_4c_Class2.Value)
4175:             IF EMPTY(loc_cCod)
4176:                 RETURN
4177:             ENDIF
4178: 
4179:             loc_cSQL    = "SELECT Classes, Descrs FROM SigCdCss WHERE LEN(RTRIM(Classes))=1 ORDER BY Classes"
4180:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCss2")
4181:             IF loc_nResult > 0
4182:                 SELECT cursor_4c_BuscaCss2
4183:                 LOCATE FOR ALLTRIM(cursor_4c_BuscaCss2.Classes) == ALLTRIM(loc_cCod)
4184:                 IF FOUND("cursor_4c_BuscaCss2")
4185:                     loc_oPg2.txt_4c_Class2.Value = ALLTRIM(cursor_4c_BuscaCss2.Classes)
4186:                 ELSE
4187:                     GO TOP IN cursor_4c_BuscaCss2
4188:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4189:                     IF VARTYPE(loc_oBusca) = "O"
4190:                         loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCss2"
4191:                         loc_oBusca.mAddColuna("Classes", "", "C" + CHR(243) + "digo")
4192:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
4193:                         loc_oBusca.Show()
4194:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCss2")
4195:                             loc_oPg2.txt_4c_Class2.Value = ALLTRIM(cursor_4c_BuscaCss2.Classes)
4196:                         ELSE
4197:                             loc_oPg2.txt_4c_Class2.Value = ""
4198:                         ENDIF
4199:                         loc_oBusca.Release()
4200:                     ENDIF
4201:                 ENDIF
4202:             ENDIF
4203: 
4204:         CATCH TO loc_oErro
4205:             MsgErro(loc_oErro.Message, "FormOTI.ValidarClass2s")
4206:         ENDTRY
4207: 
4208:         IF USED("cursor_4c_BuscaCss2")
4209:             USE IN cursor_4c_BuscaCss2
4210:         ENDIF
4211:     ENDPROC
4212: 
4213:     *==========================================================================
4214:     PROCEDURE ValidarClass3s(par_nKeyCode, par_nShiftAltCtrl)
4215:     *==========================================================================
4216:         LOCAL loc_oPg2, loc_cCod, loc_cSQL, loc_nResult, loc_oBusca, loc_oErro
4217:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4218: 
4219:         TRY
4220:             IF !PEMSTATUS(loc_oPg2, "txt_4c_Class3", 5)
4221:                 RETURN
4222:             ENDIF
4223:             loc_cCod = ALLTRIM(loc_oPg2.txt_4c_Class3.Value)
4224:             IF EMPTY(loc_cCod)
4225:                 RETURN
4226:             ENDIF
4227: 
4228:             loc_cSQL    = "SELECT Classes, Descrs FROM SigCdCss WHERE LEN(RTRIM(Classes))=1 ORDER BY Classes"
4229:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCss3")
4230:             IF loc_nResult > 0
4231:                 SELECT cursor_4c_BuscaCss3
4232:                 LOCATE FOR ALLTRIM(cursor_4c_BuscaCss3.Classes) == ALLTRIM(loc_cCod)
4233:                 IF FOUND("cursor_4c_BuscaCss3")
4234:                     loc_oPg2.txt_4c_Class3.Value = ALLTRIM(cursor_4c_BuscaCss3.Classes)
4235:                 ELSE
4236:                     GO TOP IN cursor_4c_BuscaCss3
4237:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4238:                     IF VARTYPE(loc_oBusca) = "O"
4239:                         loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCss3"
4240:                         loc_oBusca.mAddColuna("Classes", "", "C" + CHR(243) + "digo")
4241:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
4242:                         loc_oBusca.Show()
4243:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCss3")
4244:                             loc_oPg2.txt_4c_Class3.Value = ALLTRIM(cursor_4c_BuscaCss3.Classes)
4245:                         ELSE
4246:                             loc_oPg2.txt_4c_Class3.Value = ""
4247:                         ENDIF
4248:                         loc_oBusca.Release()
4249:                     ENDIF
4250:                 ENDIF
4251:             ENDIF
4252: 
4253:         CATCH TO loc_oErro
4254:             MsgErro(loc_oErro.Message, "FormOTI.ValidarClass3s")
4255:         ENDTRY
4256: 
4257:         IF USED("cursor_4c_BuscaCss3")
4258:             USE IN cursor_4c_BuscaCss3
4259:         ENDIF
4260:     ENDPROC
4261: 
4262:     *==========================================================================
4263:     PROCEDURE ValidarClass4s(par_nKeyCode, par_nShiftAltCtrl)
4264:     *==========================================================================
4265:         LOCAL loc_oPg2, loc_cCod, loc_cSQL, loc_nResult, loc_oBusca, loc_oErro
4266:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4267: 
4268:         TRY
4269:             IF !PEMSTATUS(loc_oPg2, "txt_4c_Class4", 5)
4270:                 RETURN
4271:             ENDIF
4272:             loc_cCod = ALLTRIM(loc_oPg2.txt_4c_Class4.Value)
4273:             IF EMPTY(loc_cCod)
4274:                 RETURN
4275:             ENDIF
4276: 
4277:             loc_cSQL    = "SELECT Classes, Descrs FROM SigCdCss WHERE LEN(RTRIM(Classes))=1 ORDER BY Classes"
4278:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCss4")
4279:             IF loc_nResult > 0
4280:                 SELECT cursor_4c_BuscaCss4
4281:                 LOCATE FOR ALLTRIM(cursor_4c_BuscaCss4.Classes) == ALLTRIM(loc_cCod)
4282:                 IF FOUND("cursor_4c_BuscaCss4")
4283:                     loc_oPg2.txt_4c_Class4.Value = ALLTRIM(cursor_4c_BuscaCss4.Classes)
4284:                 ELSE
4285:                     GO TOP IN cursor_4c_BuscaCss4
4286:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4287:                     IF VARTYPE(loc_oBusca) = "O"
4288:                         loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCss4"
4289:                         loc_oBusca.mAddColuna("Classes", "", "C" + CHR(243) + "digo")
4290:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
4291:                         loc_oBusca.Show()
4292:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCss4")
4293:                             loc_oPg2.txt_4c_Class4.Value = ALLTRIM(cursor_4c_BuscaCss4.Classes)
4294:                         ELSE
4295:                             loc_oPg2.txt_4c_Class4.Value = ""
4296:                         ENDIF
4297:                         loc_oBusca.Release()
4298:                     ENDIF
4299:                 ENDIF
4300:             ENDIF
4301: 
4302:         CATCH TO loc_oErro
4303:             MsgErro(loc_oErro.Message, "FormOTI.ValidarClass4s")
4304:         ENDTRY
4305: 
4306:         IF USED("cursor_4c_BuscaCss4")
4307:             USE IN cursor_4c_BuscaCss4
4308:         ENDIF
4309:     ENDPROC
4310: 
4311:     *==========================================================================
4312:     PROTECTED PROCEDURE AjustarBotoesPorModo()
4313:     *==========================================================================
4314:         LOCAL loc_oPg2, loc_oCnt, loc_lEdicao
4315:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
4316:         loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
4317: 
4318:         TRY
4319:             IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
4320:                 loc_oCnt = loc_oPg2.cnt_4c_BotoesAcao
4321: 
4322:                 IF PEMSTATUS(loc_oCnt, "cmd_4c_Confirmar", 5)
4323:                     loc_oCnt.cmd_4c_Confirmar.Enabled = loc_lEdicao
4324:                 ENDIF
4325: 
4326:                 IF PEMSTATUS(loc_oCnt, "cmd_4c_Cancelar", 5)
4327:                     loc_oCnt.cmd_4c_Cancelar.Enabled = .T.
4328:                 ENDIF
4329:             ENDIF
4330:         CATCH TO loc_oErro
4331:             MsgErro(loc_oErro.Message, "FormOTI.AjustarBotoesPorModo")
4332:         ENDTRY
4333:     ENDPROC
4334: 
4335:     *==========================================================================
4336:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
4337:     *==========================================================================
4338:         LOCAL loc_nI, loc_nP, loc_oObjeto
4339: 
4340:         IF VARTYPE(par_oContainer) # "O"
4341:             RETURN
4342:         ENDIF
4343: 
4344:         FOR loc_nI = 1 TO par_oContainer.ControlCount
4345:             loc_oObjeto = par_oContainer.Controls(loc_nI)
4346: 
4347:             IF VARTYPE(loc_oObjeto) = "O"
4348:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
4349:                     loc_oObjeto.Visible = .T.
4350:                 ENDIF
4351: 
4352:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
4353:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
4354:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
4355:                     ENDFOR
4356:                 ENDIF
4357: 
4358:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
4359:                     THIS.TornarControlesVisiveis(loc_oObjeto)
4360:                 ENDIF
4361:             ENDIF
4362:         ENDFOR
4363:     ENDPROC
4364: 
4365:     *==========================================================================
4366:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
4367:     *==========================================================================
4368:         IF VARTYPE(par_oGrid) # "O"
4369:             RETURN
4370:         ENDIF
4371: 
4372:         WITH par_oGrid
4373:             .FontName = "Verdana"
4374:             .FontSize = 8
4375:         ENDWITH
4376:     ENDPROC
4377: 
4378:     *==========================================================================
4379:     PROCEDURE Destroy()
4380:     *==========================================================================
4381:         TRY
4382:             IF USED("cursor_4c_Dados")
4383:                 USE IN cursor_4c_Dados
4384:             ENDIF
4385:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
4386:                 THIS.this_oBusinessObject = .NULL.
4387:             ENDIF
4388:         CATCH TO loc_oErro
4389:             MsgErro(loc_oErro.Message, "FormOTI.Destroy")
4390:         ENDTRY
4391: 
4392:         DODEFAULT()
4393:     ENDPROC
4394: 
4395: ENDDEFINE


### BO (C:\4c\projeto\app\classes\OTIBO.prg):
*==============================================================================
* OTIBO.prg - Business Object para Opera" + CHR(231) + CHR(245) + "es de T" + CHR(237) + "tulos
* Tabela principal: SigOpOpe (PK: dopes char(20))
* Tabela secund" + CHR(225) + "ria: SigCdPrg (acessos por opera" + CHR(231) + CHR(227) + "o)
* Migrado de: sigCDOTI.SCX
*==============================================================================

DEFINE CLASS OTIBO AS BusinessBase

    *-- Identifica" + CHR(231) + CHR(227) + "o do registro
    this_cDopes      = ""   && dopes      PK char(20) - descri" + CHR(231) + CHR(227) + "o da opera" + CHR(231) + CHR(227) + "o
    this_nNdopes     = 0    && ndopes     auto-gerado numeric(10,0)
    this_cOpers      = "CR" && opers      CR=cr" + CHR(233) + "dito / DB=d" + CHR(233) + "bito char(2)
    this_nOpeCancs   = 0    && opecancs   0=Ativo / 1=Cancelado numeric(1,0)

    *-- Opera" + CHR(231) + CHR(245) + "es relacionadas
    this_cDopereals  = ""   && dopereals  opera" + CHR(231) + CHR(227) + "o Realizado char(20)
    this_cDopCancs   = ""   && dopcancs   opera" + CHR(231) + CHR(227) + "o Cancelamento char(20)
    this_cOpdepos    = ""   && opdepos    opera" + CHR(231) + CHR(227) + "o Dep" + CHR(243) + "sito char(15)

    *-- Hist" + CHR(243) + "rico e texto
    this_cHists      = ""   && hists      hist" + CHR(243) + "rico padr" + CHR(227) + "o char(30)
    this_nTpHists    = 2    && tphists    tipo hist" + CHR(243) + "rico numeric(1,0)
    this_cIdentifics = ""   && identifics identificador char(1)
    this_cPastas     = ""   && pastas     caminho pasta (text NULL)

    *-- Configura" + CHR(231) + CHR(227) + "o do t" + CHR(237) + "tulo
    this_nDiasVcto   = 0    && diasvcto   dias vencimento numeric(2,0)
    this_nQtdBols    = 0    && qtdbols    qtd vias boleto numeric(2,0)
    this_cCnMascaras = ""   && cnmascaras m" + CHR(225) + "scara NF char(10)
    this_nJuros      = 0    && juros      juros di" + CHR(225) + "rio (%) numeric(4,2)
    this_cMoedas     = ""   && moedas     moeda totalizador char(3)
    this_nVlrLimApv  = 0    && vlrlimapv  valor limite aprova" + CHR(231) + CHR(227) + "o numeric(11,2)

    *-- Op" + CHR(231) + CHR(245) + "es (OptionGroups, valor 1-indexed)
    this_nDadosPgs   = 1    && dadospgs   dados pagamento numeric(1,0)
    this_nCampoNfs   = 1    && camponfs   campo NF numeric(1,0)
    this_nBlqccs     = 2    && blqccs     bloquear C/C numeric(1,0)
    this_nPendencias = 1    && pendencias pend" + CHR(234) + "ncias numeric(1,0)
    this_nRealprevs  = 1    && realprevs  real/previsto numeric(1,0)
    this_nEmiPorDesp = 2    && emipordesp emitente=portador numeric(1,0)
    this_nValprev    = 2    && valprev    valor previsto numeric(1,0)
    this_nTitauts    = 1    && titauts    n" + CHR(186) + " t" + CHR(237) + "tulo autom" + CHR(225) + "tico numeric(1,0)
    this_nImpbols    = 2    && impbols    imprime boleto numeric(1,0)
    this_nCompets    = 1    && compets    compet" + CHR(234) + "ncia numeric(1,0)
    this_nAltTrans   = 1    && alttrans   realizar apenas autorizados numeric(1,0)
    this_nOutTits    = 2    && outtits    outros t" + CHR(237) + "tulos auto numeric(1,0)
    this_nFiltContas = 2    && filtcontas filtra conta p/ grupo numeric(1,0)
    this_nJobs       = 2    && jobs       jobs numeric(1,0)
    this_nImpdocs    = 2    && impdocs    imprime documento numeric(1,0)
    this_nLimcres    = 2    && limcres    checar limite cr" + CHR(233) + "dito numeric(1,0)

    *-- Grupos padr" + CHR(227) + "o
    this_cGrupo1s    = ""   && grupo1s    emitente char(10)
    this_cGrupo2s    = ""   && grupo2s    portador char(10)
    this_cGrupo3s    = ""   && grupo3s    centro de custo char(10)
    this_cGrupo4s    = ""   && grupo4s    agente cobrador char(10)

    *-- Grupos cadastrais
    this_cGrpCad1s   = ""   && grpcad1s   grupo cadastral 1 char(10)
    this_cGrpCad2s   = ""   && grpcad2s   grupo cadastral 2 char(10)
    this_cGrpCad3s   = ""   && grpcad3s   grupo cadastral 3 char(10)
    this_cGrpCad4s   = ""   && grpcad4s   grupo cadastral 4 char(10)
    this_cDGrpCad1s  = ""   && descri" + CHR(231) + CHR(227) + "o exibi" + CHR(231) + CHR(227) + "o grupo cadastral 1
    this_cDGrpCad2s  = ""   && descri" + CHR(231) + CHR(227) + "o exibi" + CHR(231) + CHR(227) + "o grupo cadastral 2
    this_cDGrpCad3s  = ""   && descri" + CHR(231) + CHR(227) + "o exibi" + CHR(231) + CHR(227) + "o grupo cadastral 3
    this_cDGrpCad4s  = ""   && descri" + CHR(231) + CHR(227) + "o exibi" + CHR(231) + CHR(227) + "o grupo cadastral 4

    *-- Classes cont" + CHR(225) + "beis char(1) - armazenadas como char no banco
    this_cClass1s    = ""   && class1s    classe cont" + CHR(225) + "bil 1 char(1)
    this_cClass2s    = ""   && class2s    classe cont" + CHR(225) + "bil 2 char(1)
    this_cClass3s    = ""   && class3s    classe cont" + CHR(225) + "bil 3 char(1)
    this_cClass4s    = ""   && class4s    classe cont" + CHR(225) + "bil 4 char(1)

    *-- T" + CHR(237) + "tulos dos campos
    this_cTxt01      = ""   && txt01      t" + CHR(237) + "tulo campo emitente char(15)
    this_cTxt02      = ""   && txt02      t" + CHR(237) + "tulo campo portador char(15)
    this_cTxt03      = ""   && txt03      t" + CHR(237) + "tulo campo centro custo char(15)
    this_cTxt04      = ""   && txt04      t" + CHR(237) + "tulo campo agente cobrador char(15)

    *-- Checkboxes (l" + CHR(243) + "gico; congvs=bit no banco, demais=numeric 0/1)
    this_lCongvs     = .F.  && congvs     bit NOT NULL
    this_lBlqTits    = .F.  && blqtits    numeric(1,0) NOT NULL
    this_lEspobrigs  = .F.  && espobrigs  numeric(1,0) NOT NULL
    this_lLancCCEs   = .F.  && lancCCEs   numeric(1,0) NOT NULL
    this_lLancCCAs   = .F.  && lancCCAs   numeric(1,0) NOT NULL
    this_lObsobrigs  = .F.  && obsobrigs  numeric(1,0) NOT NULL
    this_lObrigC1    = .F.  && obrigc1    numeric(1,0) NOT NULL
    this_lObrigC2    = .F.  && obrigc2    numeric(1,0) NOT NULL
    this_lObrigC3    = .F.  && obrigc3    numeric(1,0) NOT NULL
    this_lObrigC4    = .F.  && obrigc4    numeric(1,0) NOT NULL
    this_lObrCompet  = .F.  && obrcompet  numeric(1,0) NOT NULL

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpOpe"
            THIS.this_cCampoChave = "NDopes"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "OTIBO.Init")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
    *==========================================================================
        RETURN ALLTRIM(TRANSFORM(THIS.this_nNdopes))
    ENDPROC

    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
    *==========================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_cWhere, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cWhere = ""
            IF !EMPTY(par_cFiltro)
                loc_cWhere = " WHERE UPPER(dopes) LIKE '%" + UPPER(par_cFiltro) + "%'"
            ENDIF

            loc_cSQL = "SELECT dopes, opers, ndopes FROM SigOpOpe" + loc_cWhere + " ORDER BY dopes"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                IF !USED("cursor_4c_Dados")
                    CREATE CURSOR cursor_4c_Dados (dopes C(20), opers C(2), ndopes N(10,0))
                ENDIF
                IF !EOF("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar opera" + CHR(231) + CHR(245) + "es."
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_nCodigo)
    *==========================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Reg")
                USE IN cursor_4c_Reg
            ENDIF

            loc_cSQL = "SELECT * FROM SigOpOpe WHERE NDopes = " + ALLTRIM(TRANSFORM(par_nCodigo))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Reg")

            IF loc_nResult >= 0 AND !EOF("cursor_4c_Reg")
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Reg")
                THIS.this_lNovoRegistro = .F.
            ELSE
                THIS.this_cMensagemErro = "Registro n" + CHR(227) + "o encontrado."
            ENDIF

            IF USED("cursor_4c_Reg")
                USE IN cursor_4c_Reg
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "OTIBO.CarregarPorCodigo")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)
            IF EOF()
                loc_lResultado = .F.
            ENDIF

            THIS.this_cDopes      = ALLTRIM(dopes)
            THIS.this_nNdopes     = ndopes
            THIS.this_cOpers      = ALLTRIM(opers)
            THIS.this_nOpeCancs   = opecancs
            THIS.this_cDopereals  = ALLTRIM(dopereals)
            THIS.this_cDopCancs   = ALLTRIM(dopcancs)
            THIS.this_cOpdepos    = ALLTRIM(opdepos)
            THIS.this_cHists      = ALLTRIM(hists)
            THIS.this_nTpHists    = tphists
            THIS.this_cIdentifics = ALLTRIM(identifics)
            THIS.this_cPastas     = IIF(ISNULL(pastas), "", ALLTRIM(pastas))
            THIS.this_nDiasVcto   = diasvcto
            THIS.this_nQtdBols    = qtdbols
            THIS.this_cCnMascaras = ALLTRIM(cnmascaras)
            THIS.this_nJuros      = juros
            THIS.this_cMoedas     = ALLTRIM(moedas)
            THIS.this_nVlrLimApv  = vlrlimapv
            THIS.this_nDadosPgs   = dadospgs
            THIS.this_nCampoNfs   = camponfs
            THIS.this_nBlqccs     = blqccs
            THIS.this_nPendencias = pendencias
            THIS.this_nRealprevs  = realprevs
            THIS.this_nEmiPorDesp = emipordesp
            THIS.this_nValprev    = valprev
            THIS.this_nTitauts    = titauts
            THIS.this_nImpbols    = impbols
            THIS.this_nCompets    = compets
            THIS.this_nAltTrans   = alttrans
            THIS.this_nOutTits    = outtits
            THIS.this_nFiltContas = filtcontas
            THIS.this_nJobs       = jobs
            THIS.this_nImpdocs    = impdocs
            THIS.this_nLimcres    = limcres
            THIS.this_cGrupo1s    = ALLTRIM(grupo1s)
            THIS.this_cGrupo2s    = ALLTRIM(grupo2s)
            THIS.this_cGrupo3s    = ALLTRIM(grupo3s)
            THIS.this_cGrupo4s    = ALLTRIM(grupo4s)
            THIS.this_cGrpCad1s   = ALLTRIM(grpcad1s)
            THIS.this_cGrpCad2s   = ALLTRIM(grpcad2s)
            THIS.this_cGrpCad3s   = ALLTRIM(grpcad3s)
            THIS.this_cGrpCad4s   = ALLTRIM(grpcad4s)
            THIS.this_cClass1s    = ALLTRIM(class1s)
            THIS.this_cClass2s    = ALLTRIM(class2s)
            THIS.this_cClass3s    = ALLTRIM(class3s)
            THIS.this_cClass4s    = ALLTRIM(class4s)
            THIS.this_cTxt01      = ALLTRIM(txt01)
            THIS.this_cTxt02      = ALLTRIM(txt02)
            THIS.this_cTxt03      = ALLTRIM(txt03)
            THIS.this_cTxt04      = ALLTRIM(txt04)
            THIS.this_lCongvs     = (congvs <> 0)
            THIS.this_lBlqTits    = (blqtits <> 0)
            THIS.this_lEspobrigs  = (espobrigs <> 0)
            THIS.this_lLancCCEs   = (lancCCEs <> 0)
            THIS.this_lLancCCAs   = (lancCCAs <> 0)
            THIS.this_lObsobrigs  = (obsobrigs <> 0)
            THIS.this_lObrigC1    = (obrigc1 <> 0)
            THIS.this_lObrigC2    = (obrigc2 <> 0)
            THIS.this_lObrigC3    = (obrigc3 <> 0)
            THIS.this_lObrigC4    = (obrigc4 <> 0)
            THIS.this_lObrCompet  = (obrcompet <> 0)

            THIS.this_cDGrpCad1s  = THIS.BuscarDescricaoGrpCad(THIS.this_cGrpCad1s)
            THIS.this_cDGrpCad2s  = THIS.BuscarDescricaoGrpCad(THIS.this_cGrpCad2s)
            THIS.this_cDGrpCad3s  = THIS.BuscarDescricaoGrpCad(THIS.this_cGrpCad3s)
            THIS.this_cDGrpCad4s  = THIS.BuscarDescricaoGrpCad(THIS.this_cGrpCad4s)

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    FUNCTION ValidarDados()
    *==========================================================================
        IF EMPTY(THIS.this_cDopes)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o da Opera" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria.")
            RETURN .F.
        ENDIF
        IF THIS.this_nRealprevs = 2 AND EMPTY(THIS.this_cDopereals)
            MsgAviso("Opera" + CHR(231) + CHR(227) + "o Realizado obrigat" + CHR(243) + "ria quando tipo Previsto.")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *==========================================================================
    FUNCTION VerificarCodigoDuplicado()
    *==========================================================================
        LOCAL loc_nCount, loc_nResult
        loc_nCount = 0

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT COUNT(*) AS total FROM SigOpOpe WHERE dopes = " + ;
                EscaparSQL(ALLTRIM(THIS.this_cDopes)), ;
                "cursor_4c_Dup")
            IF loc_nResult >= 0 AND !EOF("cursor_4c_Dup")
                loc_nCount = cursor_4c_Dup.total
            ENDIF
            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN (loc_nCount > 0)
    ENDPROC

    *==========================================================================
    PROTECTED FUNCTION ObterProximoNdopes()
    *==========================================================================
        LOCAL loc_nProximo, loc_nResult
        loc_nProximo = 1

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT ISNULL(MAX(ndopes),0)+1 AS proximo FROM SigOpOpe", ;
                "cursor_4c_NxtN")
            IF loc_nResult >= 0 AND !EOF("cursor_4c_NxtN")
                loc_nProximo = cursor_4c_NxtN.proximo
            ENDIF
            IF USED("cursor_4c_NxtN")
                USE IN cursor_4c_NxtN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nProximo
    ENDPROC

    *==========================================================================
    FUNCTION BuscarDescricaoGrpCad(par_cCodigo)
    *==========================================================================
        LOCAL loc_cDescr, loc_nResult
        loc_cDescr = ""

        IF EMPTY(par_cCodigo)
            RETURN ""
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 descrs FROM SigCdGcr WHERE Codigos = " + ;
                EscaparSQL(ALLTRIM(par_cCodigo)), ;
                "cursor_4c_Gcr")
            IF loc_nResult >= 0 AND !EOF("cursor_4c_Gcr")
                loc_cDescr = ALLTRIM(cursor_4c_Gcr.descrs)
            ENDIF
            IF USED("cursor_4c_Gcr")
                USE IN cursor_4c_Gcr
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cDescr
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InserirSigCdPrgSeNaoExiste(par_cProg, par_cParam, par_cDesc, par_cBarraForms)
    *==========================================================================
        LOCAL loc_nCount, loc_nResult, loc_cSQL
        loc_nCount = 0

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT COUNT(*) AS total FROM SigCdPrg " + ;
                "WHERE Programas = " + EscaparSQL(par_cProg) + ;
                " AND RTRIM(Parametros) = " + EscaparSQL(RTRIM(par_cParam)), ;
                "cursor_4c_ChkPrg")
            IF loc_nResult >= 0 AND !EOF("cursor_4c_ChkPrg")
                loc_nCount = cursor_4c_ChkPrg.total
            ENDIF
            IF USED("cursor_4c_ChkPrg")
                USE IN cursor_4c_ChkPrg
            ENDIF

            IF loc_nCount = 0
                loc_cSQL = "INSERT INTO SigCdPrg " + ;
                    "(Descricaos, Parametros, Programas, pkChaves, barraforms, barrapict) VALUES (" + ;
                    EscaparSQL(par_cDesc)       + ", " + ;
                    EscaparSQL(par_cParam)      + ", " + ;
                    EscaparSQL(par_cProg)       + ", " + ;
                    EscaparSQL(fUniqueIds())    + ", " + ;
                    EscaparSQL(par_cBarraForms) + ", " + ;
                    "''" + ")"
                SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CriarEntradasSigCdPrg(par_cDopes, par_nNdopes)
    *==========================================================================
        LOCAL loc_cProg, loc_cDesc, loc_cBarra
        loc_cProg  = "C" + PADL(TRANSFORM(par_nNdopes), 8, "0")
        loc_cDesc  = "Menu - Financeiro - T" + CHR(237) + "tulos - " + PROPER(ALLTRIM(par_cDopes))
        loc_cBarra = "SIGPGTIT WITH '" + ALLTRIM(par_cDopes) + "'"

        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "",          loc_cDesc,                                                                               loc_cBarra)
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "INSERIR",   loc_cDesc + " - [Inserir]",                                                             "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "ALTERAR",   loc_cDesc + " - [Alterar]",                                                             "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "EXCLUIR",   loc_cDesc + " - [Excluir]",                                                             "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "LISTAR",    loc_cDesc + " - [Listar]",                                                              "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "TITULO",    loc_cDesc + " - [T" + CHR(237) + "tulo]",                                               "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "OCORR",     loc_cDesc + " - [Ocorr" + CHR(234) + "ncias]",                                          "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "ALTDATAS",  loc_cDesc + " - [Alterar Datas]",                                                       "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "LIBVENCS",  loc_cDesc + " - [N" + CHR(227) + "o Checa Vcto. X Emiss" + CHR(227) + "o]",             "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "TRFREAL",   loc_cDesc + " - [Transfere para C/C]",                                                  "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "LISTAGERAL",loc_cDesc + " - [Lista Geral]",                                                         "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "TRFPREV",   loc_cDesc + " - [Transfere p/ Previs" + CHR(227) + "o]",                                "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "ALTCC",     loc_cDesc + " - [Altera Centro de Custo]",                                              "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "CANCELA",   loc_cDesc + " - [Cancelamento do T" + CHR(237) + "tulo ]",                              "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "PRORROGAR", loc_cDesc + " - [Prorrogar T" + CHR(237) + "tulo ]",                                    "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "CONFERIR",  loc_cDesc + " - [Conferir T" + CHR(237) + "tulo ]",                                     "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "ALTERAAGC", loc_cDesc + " - [Altera Agente Cobrador]",                                              "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "AUTOBLQ",   loc_cDesc + " - [Inibir Alerta de Fora do Per" + CHR(237) + "odo]",                     "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "LIMPADTT",  loc_cDesc + " - [Desmarca Transporte]",                                                 "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "SUBSTITUI", loc_cDesc + " - [Substitui" + CHR(231) + CHR(227) + "o de T" + CHR(237) + "tulo]",      "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "FOLLOWUP",  loc_cDesc + " - [Follow up de Conta]",                                                  "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "FOLLOWUPI", loc_cDesc + " - [Follow up de Lan" + CHR(231) + "amento]",                              "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "BLOQVENCS", loc_cDesc + " - [Bloqueio de T" + CHR(237) + "tulos Vencidos]",                         "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "ALTARQCON", loc_cDesc + " - [Altera Arq. Relac. na Consulta]",                                      "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "BLQDTLANC", loc_cDesc + " - [N" + CHR(227) + "o Altera Data de Lan" + CHR(231) + "amento]",         "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "MULTIAPROV",loc_cDesc + " - [Permite Aprovar Mais de um T" + CHR(237) + "tulo]",                    "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "APVVLRSUP", loc_cDesc + " - [Permite Aprovar Um T" + CHR(237) + "tulo Com Valor Acima do Permitido.]","")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "ALTERAVENC",loc_cDesc + " - [Permite Prorrogar o Vencimento.]",                                     "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "OUTRESPONS",loc_cDesc + " - [Permite Aprovar T" + CHR(237) + "tulos de Outros Respons" + CHR(225) + "veis.]","")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "OBSRESUMO", loc_cDesc + " - [Observa" + CHR(231) + CHR(227) + "o resumida.]",                       "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "LIBAPROV",  loc_cDesc + " - [Permite Alterar T" + CHR(237) + "tulos Aprovados.]",                   "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "LIBCARTAO", loc_cDesc + " - [Libera Visualizar Cart" + CHR(245) + "es.]",                           "")
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Inserir()
    *==========================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            THIS.this_nNdopes = THIS.ObterProximoNdopes()

            loc_cSQL = "INSERT INTO SigOpOpe (" + ;
                "dopes, ndopes, ordes, datas, opers, " + ;
                "opdepos, hists, tphists, fixgrupes, grupoeps, identifics, " + ;
                "titauts, txt01, txt02, txt03, txt04, impbols, " + ;
                "grupo1s, grupo2s, grupo3s, grupo4s, " + ;
                "grpcad1s, grpcad2s, grpcad3s, grpcad4s, " + ;
                "valprev, qtdbols, compets, congvs, " + ;
                "dopereals, pendencias, realprevs, blqccs, alttrans, bloqueios, " + ;
                "impdocs, cnmascaras, dopcancs, opecancs, " + ;
                "blqtits, outtits, soldocs, camponfs, dadospgs, espobrigs, " + ;
                "juros, filtcontas, lancCCAs, lancCCEs, obsobrigs, jobs, " + ;
                "class1s, class2s, class3s, class4s, buscanome, " + ;
                "diasvcto, emipordesp, limcres, moedas, obrcompet, " + ;
                "obrigc1, obrigc2, obrigc3, obrigc4, " + ;
                "pastas, vlrlimapv, InibEmpHst, edthists, rateiocf" + ;
                ") VALUES (" + ;
                EscaparSQL(ALLTRIM(THIS.this_cDopes))      + ", " + ;
                FormatarNumeroSQL(THIS.this_nNdopes)        + ", " + ;
                "0, GETDATE(), "                           + ;
                EscaparSQL(ALLTRIM(THIS.this_cOpers))       + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cOpdepos))     + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cHists))       + ", " + ;
                FormatarNumeroSQL(THIS.this_nTpHists)       + ", " + ;
                "0, '', "                                  + ;
                EscaparSQL(ALLTRIM(THIS.this_cIdentifics))  + ", " + ;
                FormatarNumeroSQL(THIS.this_nTitauts)       + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cTxt01))       + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cTxt02))       + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cTxt03))       + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cTxt04))       + ", " + ;
                FormatarNumeroSQL(THIS.this_nImpbols)       + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupo1s))     + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupo2s))     + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupo3s))     + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupo4s))     + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrpCad1s))    + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrpCad2s))    + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrpCad3s))    + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrpCad4s))    + ", " + ;
                FormatarNumeroSQL(THIS.this_nValprev)       + ", " + ;
                FormatarNumeroSQL(THIS.this_nQtdBols)       + ", " + ;
                FormatarNumeroSQL(THIS.this_nCompets)       + ", " + ;
                IIF(THIS.this_lCongvs,   "1", "0")         + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cDopereals))   + ", " + ;
                FormatarNumeroSQL(THIS.this_nPendencias)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nRealprevs)     + ", " + ;
                FormatarNumeroSQL(THIS.this_nBlqccs)        + ", " + ;
                FormatarNumeroSQL(THIS.this_nAltTrans)      + ", " + ;
                "0, "                                      + ;
                FormatarNumeroSQL(THIS.this_nImpdocs)       + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cCnMascaras))  + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cDopCancs))    + ", " + ;
                FormatarNumeroSQL(THIS.this_nOpeCancs)      + ", " + ;
                IIF(THIS.this_lBlqTits,   "1", "0")        + ", " + ;
                FormatarNumeroSQL(THIS.this_nOutTits)       + ", " + ;
                "0, "                                      + ;
                FormatarNumeroSQL(THIS.this_nCampoNfs)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nDadosPgs)      + ", " + ;
                IIF(THIS.this_lEspobrigs, "1", "0")        + ", " + ;
                FormatarNumeroSQL(THIS.this_nJuros)         + ", " + ;
                FormatarNumeroSQL(THIS.this_nFiltContas)    + ", " + ;
                IIF(THIS.this_lLancCCAs,  "1", "0")        + ", " + ;
                IIF(THIS.this_lLancCCEs,  "1", "0")        + ", " + ;
                IIF(THIS.this_lObsobrigs, "1", "0")        + ", " + ;
                FormatarNumeroSQL(THIS.this_nJobs)          + ", " + ;
                EscaparSQL(THIS.this_cClass1s)              + ", " + ;
                EscaparSQL(THIS.this_cClass2s)              + ", " + ;
                EscaparSQL(THIS.this_cClass3s)              + ", " + ;
                EscaparSQL(THIS.this_cClass4s)              + ", " + ;
                "0, "                                      + ;
                FormatarNumeroSQL(THIS.this_nDiasVcto)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nEmiPorDesp)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nLimcres)       + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cMoedas))      + ", " + ;
                IIF(THIS.this_lObrCompet, "1", "0")        + ", " + ;
                IIF(THIS.this_lObrigC1,   "1", "0")        + ", " + ;
                IIF(THIS.this_lObrigC2,   "1", "0")        + ", " + ;
                IIF(THIS.this_lObrigC3,   "1", "0")        + ", " + ;
                IIF(THIS.this_lObrigC4,   "1", "0")        + ", " + ;
                IIF(EMPTY(THIS.this_cPastas), "NULL", EscaparSQL(THIS.this_cPastas)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVlrLimApv)    + ", " + ;
                "0, 0, 0)"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.CriarEntradasSigCdPrg(THIS.this_cDopes, THIS.this_nNdopes)
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir opera" + CHR(231) + CHR(227) + "o."
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
    *==========================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigOpOpe SET " + ;
                "opers       = " + EscaparSQL(ALLTRIM(THIS.this_cOpers))      + ", " + ;
                "opdepos     = " + EscaparSQL(ALLTRIM(THIS.this_cOpdepos))    + ", " + ;
                "hists       = " + EscaparSQL(ALLTRIM(THIS.this_cHists))      + ", " + ;
                "tphists     = " + FormatarNumeroSQL(THIS.this_nTpHists)      + ", " + ;
                "identifics  = " + EscaparSQL(ALLTRIM(THIS.this_cIdentifics)) + ", " + ;
                "titauts     = " + FormatarNumeroSQL(THIS.this_nTitauts)      + ", " + ;
                "txt01       = " + EscaparSQL(ALLTRIM(THIS.this_cTxt01))      + ", " + ;
                "txt02       = " + EscaparSQL(ALLTRIM(THIS.this_cTxt02))      + ", " + ;
                "txt03       = " + EscaparSQL(ALLTRIM(THIS.this_cTxt03))      + ", " + ;
                "txt04       = " + EscaparSQL(ALLTRIM(THIS.this_cTxt04))      + ", " + ;
                "impbols     = " + FormatarNumeroSQL(THIS.this_nImpbols)      + ", " + ;
                "grupo1s     = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo1s))    + ", " + ;
                "grupo2s     = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo2s))    + ", " + ;
                "grupo3s     = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo3s))    + ", " + ;
                "grupo4s     = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo4s))    + ", " + ;
                "grpcad1s    = " + EscaparSQL(ALLTRIM(THIS.this_cGrpCad1s))   + ", " + ;
                "grpcad2s    = " + EscaparSQL(ALLTRIM(THIS.this_cGrpCad2s))   + ", " + ;
                "grpcad3s    = " + EscaparSQL(ALLTRIM(THIS.this_cGrpCad3s))   + ", " + ;
                "grpcad4s    = " + EscaparSQL(ALLTRIM(THIS.this_cGrpCad4s))   + ", " + ;
                "valprev     = " + FormatarNumeroSQL(THIS.this_nValprev)      + ", " + ;
                "qtdbols     = " + FormatarNumeroSQL(THIS.this_nQtdBols)      + ", " + ;
                "compets     = " + FormatarNumeroSQL(THIS.this_nCompets)      + ", " + ;
                "congvs      = " + IIF(THIS.this_lCongvs,   "1", "0")        + ", " + ;
                "dopereals   = " + EscaparSQL(ALLTRIM(THIS.this_cDopereals))  + ", " + ;
                "pendencias  = " + FormatarNumeroSQL(THIS.this_nPendencias)   + ", " + ;
                "realprevs   = " + FormatarNumeroSQL(THIS.this_nRealprevs)    + ", " + ;
                "blqccs      = " + FormatarNumeroSQL(THIS.this_nBlqccs)       + ", " + ;
                "alttrans    = " + FormatarNumeroSQL(THIS.this_nAltTrans)     + ", " + ;
                "impdocs     = " + FormatarNumeroSQL(THIS.this_nImpdocs)      + ", " + ;
                "cnmascaras  = " + EscaparSQL(ALLTRIM(THIS.this_cCnMascaras)) + ", " + ;
                "dopcancs    = " + EscaparSQL(ALLTRIM(THIS.this_cDopCancs))   + ", " + ;
                "blqtits     = " + IIF(THIS.this_lBlqTits,   "1", "0")       + ", " + ;
                "outtits     = " + FormatarNumeroSQL(THIS.this_nOutTits)      + ", " + ;
                "camponfs    = " + FormatarNumeroSQL(THIS.this_nCampoNfs)     + ", " + ;
                "dadospgs    = " + FormatarNumeroSQL(THIS.this_nDadosPgs)     + ", " + ;
                "espobrigs   = " + IIF(THIS.this_lEspobrigs, "1", "0")       + ", " + ;
                "juros       = " + FormatarNumeroSQL(THIS.this_nJuros)        + ", " + ;
                "filtcontas  = " + FormatarNumeroSQL(THIS.this_nFiltContas)   + ", " + ;
                "lancCCAs    = " + IIF(THIS.this_lLancCCAs,  "1", "0")       + ", " + ;
                "lancCCEs    = " + IIF(THIS.this_lLancCCEs,  "1", "0")       + ", " + ;
                "obsobrigs   = " + IIF(THIS.this_lObsobrigs, "1", "0")       + ", " + ;
                "jobs        = " + FormatarNumeroSQL(THIS.this_nJobs)         + ", " + ;
                "class1s     = " + EscaparSQL(THIS.this_cClass1s)             + ", " + ;
                "class2s     = " + EscaparSQL(THIS.this_cClass2s)             + ", " + ;
                "class3s     = " + EscaparSQL(THIS.this_cClass3s)             + ", " + ;
                "class4s     = " + EscaparSQL(THIS.this_cClass4s)             + ", " + ;
                "diasvcto    = " + FormatarNumeroSQL(THIS.this_nDiasVcto)     + ", " + ;
                "emipordesp  = " + FormatarNumeroSQL(THIS.this_nEmiPorDesp)   + ", " + ;
                "limcres     = " + FormatarNumeroSQL(THIS.this_nLimcres)      + ", " + ;
                "moedas      = " + EscaparSQL(ALLTRIM(THIS.this_cMoedas))     + ", " + ;
                "obrcompet   = " + IIF(THIS.this_lObrCompet, "1", "0")       + ", " + ;
                "obrigc1     = " + IIF(THIS.this_lObrigC1,   "1", "0")       + ", " + ;
                "obrigc2     = " + IIF(THIS.this_lObrigC2,   "1", "0")       + ", " + ;
                "obrigc3     = " + IIF(THIS.this_lObrigC3,   "1", "0")       + ", " + ;
                "obrigc4     = " + IIF(THIS.this_lObrigC4,   "1", "0")       + ", " + ;
                "pastas      = " + IIF(EMPTY(THIS.this_cPastas), "NULL", EscaparSQL(THIS.this_cPastas)) + ", " + ;
                "vlrlimapv   = " + FormatarNumeroSQL(THIS.this_nVlrLimApv)   + ;
                " WHERE NDopes = " + ALLTRIM(TRANSFORM(THIS.this_nNdopes))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.CriarEntradasSigCdPrg(THIS.this_cDopes, THIS.this_nNdopes)
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar opera" + CHR(231) + CHR(227) + "o."
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
    *==========================================================================
        LOCAL loc_lResultado, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigOpOpe WHERE NDopes = " + ALLTRIM(TRANSFORM(THIS.this_nNdopes)))
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir opera" + CHR(231) + CHR(227) + "o."
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "OTIBO.ExecutarExclusao")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        LOCAL loc_aCursors[8], loc_i
        loc_aCursors[1] = "cursor_4c_Dados"
        loc_aCursors[2] = "cursor_4c_Reg"
        loc_aCursors[3] = "cursor_4c_Dup"
        loc_aCursors[4] = "cursor_4c_NxtN"
        loc_aCursors[5] = "cursor_4c_Gcr"
        loc_aCursors[6] = "cursor_4c_ChkPrg"
        loc_aCursors[7] = "cursor_4c_Lista"
        loc_aCursors[8] = "cursor_4c_Busca"
        FOR loc_i = 1 TO 8
            IF USED(loc_aCursors[loc_i])
                USE IN (loc_aCursors[loc_i])
            ENDIF
        ENDFOR
        DODEFAULT()
    ENDPROC

ENDDEFINE

