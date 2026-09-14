# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [BINDEVENT-PARAMS] Handler 'ValidarCodigo' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarCodigo(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDescricao' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDescricao(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormRec.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (986 linhas total):

*-- Linhas 25 a 152:
25: 
26:     *==========================================================================
27:     * Init - REGRA CRITICA: Apenas RETURN DODEFAULT()
28:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
29:     *==========================================================================
30:     PROCEDURE Init()
31:         RETURN DODEFAULT()
32:     ENDPROC
33: 
34:     *==========================================================================
35:     * InicializarForm - Chamado pelo FormBase.Init() via DODEFAULT()
36:     *==========================================================================
37:     PROTECTED PROCEDURE InicializarForm()
38:         LOCAL loc_lSucesso
39:         loc_lSucesso = .F.
40: 
41:         TRY
42:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
43:                 THIS.ConfigurarPageFrame()
44:                 THIS.pgf_4c_Paginas.Visible   = .T.
45:                 THIS.pgf_4c_Paginas.ActivePage = 1
46:                 THIS.this_cModoAtual = "LISTA"
47:                 loc_lSucesso = .T.
48:             ELSE
49:                 THIS.this_oBusinessObject = CREATEOBJECT("RecBO")
50: 
51:                 IF VARTYPE(THIS.this_oBusinessObject) != "O"
52:                     MostrarErro("Erro ao criar RecBO" + CHR(13) + ;
53:                         "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
54:                         "FormRec.InicializarForm")
55:                 ELSE
56:                     THIS.ConfigurarPageFrame()
57: 
58:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
59:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
60: 
61:                     THIS.pgf_4c_Paginas.Visible   = .T.
62:                     THIS.pgf_4c_Paginas.ActivePage = 1
63:                     THIS.this_cModoAtual = "LISTA"
64: 
65:                     THIS.CarregarLista()
66:                     loc_lSucesso = .T.
67:                 ENDIF
68:             ENDIF
69: 
70:         CATCH TO loException
71:             MostrarErro("Erro ao inicializar FormRec:" + CHR(13) + ;
72:                 loException.Message + CHR(13) + ;
73:                 "Linha: " + TRANSFORM(loException.LineNo), ;
74:                 "FormRec.InicializarForm")
75:         ENDTRY
76: 
77:         RETURN loc_lSucesso
78:     ENDPROC
79: 
80:     *==========================================================================
81:     * ConfigurarPageFrame - Cria PageFrame (Top=-29 esconde abas)
82:     * Todos os controles dentro das Pages compensam +29 no Top
83:     *==========================================================================
84:     PROTECTED PROCEDURE ConfigurarPageFrame()
85:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
86: 
87:         WITH THIS.pgf_4c_Paginas
88:             .PageCount = 2
89:             .Top       = -29
90:             .Left      = 0
91:             .Width     = THIS.Width
92:             .Height    = THIS.Height + 29
93:             .Tabs      = .F.
94:             .Visible   = .T.
95: 
96:             .Page1.Caption   = "Lista"
97:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
98:             .Page1.BackColor = RGB(255, 255, 255)
99: 
100:             .Page2.Caption   = "Dados"
101:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
102:             .Page2.BackColor = RGB(255, 255, 255)
103:         ENDWITH
104: 
105:         THIS.ConfigurarPaginaLista()
106:         THIS.ConfigurarPaginaDados()
107:     ENDPROC
108: 
109:     *==========================================================================
110:     * ConfigurarPaginaLista - Page1: Cabecalho + Botoes CRUD + Grid
111:     *==========================================================================
112:     PROTECTED PROCEDURE ConfigurarPaginaLista()
113:         LOCAL loc_oPagina
114:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
115: 
116:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
117: 
118:         *-- Container Cabecalho - Top=30 (1+29 compensacao PageFrame)
119:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
120:         WITH loc_oPagina.cnt_4c_Cabecalho
121:             .Top         = 30
122:             .Left        = 0
123:             .Width       = THIS.Width
124:             .Height      = 80
125:             .BackColor   = RGB(100, 100, 100)
126:             .BorderWidth = 0
127:             .Visible     = .T.
128:         ENDWITH
129: 
130:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
131:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
132:             .Caption   = THIS.Caption
133:             .Top       = 15
134:             .Left      = 10
135:             .Width     = THIS.Width - 20
136:             .Height    = 46
137:             .FontName  = "Tahoma"
138:             .FontSize  = 16
139:             .FontBold  = .T.
140:             .ForeColor = RGB(0, 0, 0)
141:             .BackStyle = 0
142:             .AutoSize  = .F.
143:             .Visible   = .T.
144:         ENDWITH
145: 
146:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
147:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
148:             .Caption   = THIS.Caption
149:             .Top       = 18
150:             .Left      = 10
151:             .Width     = THIS.Width - 20
152:             .Height    = 46

*-- Linhas 193 a 468:
193:             .AutoSize        = .F.
194:             .Visible         = .T.
195:         ENDWITH
196:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
197: 
198:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
199:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
200:             .Caption         = "Visualizar"
201:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
202:             .PicturePosition = 13
203:             .Top             = 5
204:             .Left            = 80
205:             .Width           = 75
206:             .Height          = 75
207:             .BackColor       = RGB(255, 255, 255)
208:             .ForeColor       = RGB(90, 90, 90)
209:             .FontName        = "Comic Sans MS"
210:             .FontBold        = .T.
211:             .FontItalic      = .T.
212:             .FontSize        = 8
213:             .Themes          = .F.
214:             .SpecialEffect   = 0
215:             .MousePointer    = 15
216:             .WordWrap        = .T.
217:             .AutoSize        = .F.
218:             .Visible         = .T.
219:         ENDWITH
220:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
221: 
222:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
223:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
224:             .Caption         = "Alterar"
225:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
226:             .PicturePosition = 13
227:             .Top             = 5
228:             .Left            = 155
229:             .Width           = 75
230:             .Height          = 75
231:             .BackColor       = RGB(255, 255, 255)
232:             .ForeColor       = RGB(90, 90, 90)
233:             .FontName        = "Comic Sans MS"
234:             .FontBold        = .T.
235:             .FontItalic      = .T.
236:             .FontSize        = 8
237:             .Themes          = .F.
238:             .SpecialEffect   = 0
239:             .MousePointer    = 15
240:             .WordWrap        = .T.
241:             .AutoSize        = .F.
242:             .Visible         = .T.
243:         ENDWITH
244:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
245: 
246:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
247:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
248:             .Caption         = "Excluir"
249:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
250:             .PicturePosition = 13
251:             .Top             = 5
252:             .Left            = 230
253:             .Width           = 75
254:             .Height          = 75
255:             .BackColor       = RGB(255, 255, 255)
256:             .ForeColor       = RGB(90, 90, 90)
257:             .FontName        = "Comic Sans MS"
258:             .FontBold        = .T.
259:             .FontItalic      = .T.
260:             .FontSize        = 8
261:             .Themes          = .F.
262:             .SpecialEffect   = 0
263:             .MousePointer    = 15
264:             .WordWrap        = .T.
265:             .AutoSize        = .F.
266:             .Visible         = .T.
267:         ENDWITH
268:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
269: 
270:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
271:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
272:             .Caption         = "Buscar"
273:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
274:             .PicturePosition = 13
275:             .Top             = 5
276:             .Left            = 305
277:             .Width           = 75
278:             .Height          = 75
279:             .BackColor       = RGB(255, 255, 255)
280:             .ForeColor       = RGB(90, 90, 90)
281:             .FontName        = "Comic Sans MS"
282:             .FontBold        = .T.
283:             .FontItalic      = .T.
284:             .FontSize        = 8
285:             .Themes          = .F.
286:             .SpecialEffect   = 0
287:             .MousePointer    = 15
288:             .WordWrap        = .T.
289:             .AutoSize        = .F.
290:             .Visible         = .T.
291:         ENDWITH
292:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
293: 
294:         *-- Container Saida - valores canonicos CLAUDE.md regra #10
295:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
296:         WITH loc_oPagina.cnt_4c_Saida
297:             .Top         = 29
298:             .Left        = 917
299:             .Width       = 90
300:             .Height      = 85
301:             .BackStyle   = 0
302:             .BorderWidth = 0
303:             .Visible     = .T.
304:         ENDWITH
305: 
306:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
307:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
308:             .Caption         = "Encerrar"
309:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
310:             .PicturePosition = 13
311:             .Top             = 5
312:             .Left            = 5
313:             .Width           = 75
314:             .Height          = 75
315:             .BackColor       = RGB(255, 255, 255)
316:             .ForeColor       = RGB(90, 90, 90)
317:             .FontName        = "Comic Sans MS"
318:             .FontBold        = .T.
319:             .FontItalic      = .T.
320:             .FontSize        = 8
321:             .Themes          = .F.
322:             .SpecialEffect   = 0
323:             .MousePointer    = 15
324:             .WordWrap        = .T.
325:             .AutoSize        = .F.
326:             .Visible         = .T.
327:         ENDWITH
328:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
329: 
330:         *-- Grid de listagem: Top=117 (88+29), Left=26, Width=890, Height=498
331:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
332:         WITH loc_oPagina.grd_4c_Lista
333:             .Top                = 117
334:             .Left               = 26
335:             .Width              = 890
336:             .Height             = 498
337:             .ColumnCount        = 2
338:             .FontName           = "Verdana"
339:             .FontSize           = 8
340:             .ForeColor          = RGB(90, 90, 90)
341:             .BackColor          = RGB(255, 255, 255)
342:             .GridLineColor      = RGB(238, 238, 238)
343:             .GridLines          = 3
344:             .HighlightBackColor = RGB(255, 255, 255)
345:             .HighlightForeColor = RGB(15, 41, 104)
346:             .HighlightStyle     = 2
347:             .DeleteMark         = .F.
348:             .RecordMark         = .F.
349:             .RowHeight          = 16
350:             .ScrollBars         = 2
351:             .Visible            = .T.
352:         ENDWITH
353: 
354:         THIS.TornarControlesVisiveis(loc_oPagina)
355:     ENDPROC
356: 
357:     *==========================================================================
358:     * ConfigurarPaginaDados - Page2: Botoes Confirmar/Cancelar + campos do form
359:     * Campos: txt_4c_CdGrupo (codigos char(10)) + txt_4c_DsGrupo (descrs char(40))
360:     * Legado: get_cd_grupo (top=193, left=253) e get_ds_grupo (top=193, left=335)
361:     * Compensacao PageFrame +29: todos os tops recebem +29
362:     *==========================================================================
363:     PROTECTED PROCEDURE ConfigurarPaginaDados()
364:         LOCAL loc_oPagina
365:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
366: 
367:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
368: 
369:         *-- Container botoes Confirmar/Cancelar - Top=33 (4+29 compensacao PageFrame)
370:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
371:         WITH loc_oPagina.cnt_4c_BotoesAcao
372:             .Top         = 33
373:             .Left        = 842
374:             .Width       = 160
375:             .Height      = 85
376:             .BackStyle = 1
377:             .BackColor = RGB(255, 255, 255)
378:             .BorderWidth = 0
379:             .Visible     = .T.
380:         ENDWITH
381: 
382:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
383:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
384:             .Caption         = "Confirmar"
385:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
386:             .PicturePosition = 13
387:             .Top             = 5
388:             .Left            = 5
389:             .Width           = 75
390:             .Height          = 75
391:             .BackColor       = RGB(255, 255, 255)
392:             .ForeColor       = RGB(90, 90, 90)
393:             .FontName        = "Comic Sans MS"
394:             .FontBold        = .T.
395:             .FontItalic      = .T.
396:             .FontSize        = 8
397:             .Themes          = .F.
398:             .SpecialEffect   = 0
399:             .MousePointer    = 15
400:             .WordWrap        = .T.
401:             .AutoSize        = .F.
402:             .Visible         = .T.
403:         ENDWITH
404:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
405: 
406:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
407:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
408:             .Caption         = "Encerrar"
409:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
410:             .PicturePosition = 13
411:             .Top             = 5
412:             .Left            = 80
413:             .Width           = 75
414:             .Height          = 75
415:             .BackColor       = RGB(255, 255, 255)
416:             .ForeColor       = RGB(90, 90, 90)
417:             .FontName        = "Comic Sans MS"
418:             .FontBold        = .T.
419:             .FontItalic      = .T.
420:             .FontSize        = 8
421:             .Themes          = .F.
422:             .SpecialEffect   = 0
423:             .MousePointer    = 15
424:             .WordWrap        = .T.
425:             .AutoSize        = .F.
426:             .Visible         = .T.
427:         ENDWITH
428:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
429: 
430:         *-- Label titulo secao (lbl_cadastro legado: top=175, left=255; compensado +29=204)
431:         loc_oPagina.AddObject("lbl_4c_Cadastro", "Label")
432:         WITH loc_oPagina.lbl_4c_Cadastro
433:             .Caption   = "Cadastro de Contas a Receber"
434:             .Top       = 204
435:             .Left      = 255
436:             .Width     = 280
437:             .Height    = 17
438:             .FontName  = "Tahoma"
439:             .FontSize  = 8
440:             .FontBold  = .F.
441:             .ForeColor = RGB(90, 90, 90)
442:             .BackStyle = 0
443:             .Visible   = .T.
444:         ENDWITH
445: 
446:         *-- Label "Grupo :" (lbl_grupo legado: top=198, left=206, width=38; compensado +29=227)
447:         loc_oPagina.AddObject("lbl_4c_Grupo", "Label")
448:         WITH loc_oPagina.lbl_4c_Grupo
449:             .Caption   = "Grupo :"
450:             .Top       = 227
451:             .Left      = 206
452:             .Width     = 38
453:             .Height    = 17
454:             .FontName  = "Tahoma"
455:             .FontSize  = 8
456:             .FontBold  = .F.
457:             .ForeColor = RGB(90, 90, 90)
458:             .BackStyle = 0
459:             .Visible   = .T.
460:         ENDWITH
461: 
462:         *-- TextBox Codigo do Grupo (get_cd_grupo legado: top=193,left=253,w=79,h=23; +29=222)
463:         *-- SigCdGcr.codigos char(10); editavel apenas no modo INCLUIR (get_cd_grupo.When)
464:         loc_oPagina.AddObject("txt_4c_CdGrupo", "TextBox")
465:         WITH loc_oPagina.txt_4c_CdGrupo
466:             .Value     = ""
467:             .Top       = 222
468:             .Left      = 253

*-- Linhas 474 a 986:
474:             .ReadOnly  = .T.
475:             .Visible   = .T.
476:         ENDWITH
477:         BINDEVENT(loc_oPagina.txt_4c_CdGrupo, "KeyPress", THIS, "ValidarCodigo")
478:         BINDEVENT(loc_oPagina.txt_4c_CdGrupo, "KeyPress", THIS, "CdGrupoKeyPress")
479:         BINDEVENT(loc_oPagina.txt_4c_CdGrupo, "DblClick", THIS, "CdGrupoDblClick")
480: 
481:         *-- TextBox Descricao do Grupo (get_ds_grupo legado: top=193,left=335,w=150,h=23; +29=222)
482:         *-- SigCdGcr.descrs char(40); editavel apenas no modo INCLUIR (get_ds_grupo.When)
483:         loc_oPagina.AddObject("txt_4c_DsGrupo", "TextBox")
484:         WITH loc_oPagina.txt_4c_DsGrupo
485:             .Value     = ""
486:             .Top       = 222
487:             .Left      = 335
488:             .Width     = 150
489:             .Height    = 23
490:             .FontName  = "Tahoma"
491:             .FontSize  = 8
492:             .MaxLength = 40
493:             .ReadOnly  = .T.
494:             .Visible   = .T.
495:         ENDWITH
496:         BINDEVENT(loc_oPagina.txt_4c_DsGrupo, "KeyPress", THIS, "ValidarDescricao")
497:         BINDEVENT(loc_oPagina.txt_4c_DsGrupo, "KeyPress", THIS, "DsGrupoKeyPress")
498:         BINDEVENT(loc_oPagina.txt_4c_DsGrupo, "DblClick", THIS, "DsGrupoDblClick")
499: 
500:         THIS.TornarControlesVisiveis(loc_oPagina)
501:     ENDPROC
502: 
503:     *==========================================================================
504:     * CarregarLista - Carrega cursor_4c_Dados no Grid da Page1
505:     *==========================================================================
506:     PROCEDURE CarregarLista()
507:         LOCAL loc_lResultado, loc_oGrid
508:         loc_lResultado = .F.
509: 
510:         TRY
511:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
512:                 loc_lResultado = .T.
513:             ELSE
514:                 IF THIS.this_oBusinessObject.Buscar("")
515:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
516: 
517:                     *-- RecordSource e ColumnCount FORA do WITH (Problema 36)
518:                     loc_oGrid.ColumnCount = 3
519:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
520:                     loc_oGrid.ColumnCount  = 2
521: 
522:                     WITH loc_oGrid
523:                         .Column1.ControlSource   = "cursor_4c_Dados.grupos"
524:                         .Column1.Width           = 100
525:                         .Column1.Header1.Caption = "Grupo"
526: 
527:                         .Column2.ControlSource   = "cursor_4c_Dados.descrs"
528:                         .Column2.Width           = 780
529:                         .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
530:                     ENDWITH
531: 
532:                     THIS.FormatarGridLista(loc_oGrid)
533:                     loc_lResultado = .T.
534:                 ELSE
535:                     loc_lResultado = .F.
536:                 ENDIF
537:             ENDIF
538:         CATCH TO loException
539:             MsgErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "Erro")
540:         ENDTRY
541: 
542:         RETURN loc_lResultado
543:     ENDPROC
544: 
545:     *==========================================================================
546:     * FormatarGridLista - Aplica formatacao visual ao grid da lista
547:     *==========================================================================
548:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
549:         WITH par_oGrid
550:             .FontName = "Verdana"
551:             .FontSize = 8
552:         ENDWITH
553:     ENDPROC
554: 
555:     *==========================================================================
556:     * AlternarPagina - Alterna entre Page1=Lista(1) e Page2=Dados(2)
557:     *==========================================================================
558:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
559:         LOCAL loc_lResultado
560:         loc_lResultado = .F.
561: 
562:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
563:             RETURN .F.
564:         ENDIF
565: 
566:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
567: 
568:         IF par_nPagina = 1
569:             THIS.CarregarLista()
570:         ENDIF
571: 
572:         loc_lResultado = .T.
573:         RETURN loc_lResultado
574:     ENDPROC
575: 
576:     *==========================================================================
577:     * BtnEncerrarClick - Fecha o formulario (PUBLIC para BINDEVENT)
578:     *==========================================================================
579:     PROCEDURE BtnEncerrarClick()
580:         THIS.Release()
581:     ENDPROC
582: 
583:     *==========================================================================
584:     * BtnIncluirClick - Inicia inclusao de novo registro (PUBLIC para BINDEVENT)
585:     *==========================================================================
586:     PROCEDURE BtnIncluirClick()
587:         THIS.this_oBusinessObject.NovoRegistro()
588:         THIS.LimparCampos()
589:         THIS.this_cModoAtual = "INCLUIR"
590:         THIS.HabilitarCampos(.T.)
591:         THIS.AjustarBotoesPorModo()
592:         THIS.AlternarPagina(2)
593:     ENDPROC
594: 
595:     *==========================================================================
596:     * BtnVisualizarClick - Visualiza registro selecionado (PUBLIC para BINDEVENT)
597:     *==========================================================================
598:     PROCEDURE BtnVisualizarClick()
599:         LOCAL loc_cGrupo
600:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
601:             MsgAviso("Nenhum registro selecionado!", "Visualizar")
602:             RETURN
603:         ENDIF
604:         SELECT cursor_4c_Dados
605:         loc_cGrupo = ALLTRIM(cursor_4c_Dados.grupos)
606:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupo)
607:             THIS.BOParaForm()
608:             THIS.this_cModoAtual = "VISUALIZAR"
609:             THIS.HabilitarCampos(.F.)
610:             THIS.AjustarBotoesPorModo()
611:             THIS.AlternarPagina(2)
612:         ENDIF
613:     ENDPROC
614: 
615:     *==========================================================================
616:     * BtnAlterarClick - Edita registro selecionado (PUBLIC para BINDEVENT)
617:     * Legado: em ALTERAR, campos ficam somente leitura (legado nao habilitava edicao)
618:     *==========================================================================
619:     PROCEDURE BtnAlterarClick()
620:         LOCAL loc_cGrupo
621:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
622:             MsgAviso("Nenhum registro selecionado!", "Alterar")
623:             RETURN
624:         ENDIF
625:         SELECT cursor_4c_Dados
626:         loc_cGrupo = ALLTRIM(cursor_4c_Dados.grupos)
627:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupo)
628:             THIS.this_oBusinessObject.EditarRegistro()
629:             THIS.BOParaForm()
630:             THIS.this_cModoAtual = "ALTERAR"
631:             THIS.HabilitarCampos(.F.)
632:             THIS.AjustarBotoesPorModo()
633:             THIS.AlternarPagina(2)
634:         ENDIF
635:     ENDPROC
636: 
637:     *==========================================================================
638:     * BtnExcluirClick - Exclui registro selecionado (PUBLIC para BINDEVENT)
639:     *==========================================================================
640:     PROCEDURE BtnExcluirClick()
641:         LOCAL loc_cGrupo, loc_lConfirma
642:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
643:             MsgAviso("Nenhum registro selecionado!", "Excluir")
644:             RETURN
645:         ENDIF
646:         SELECT cursor_4c_Dados
647:         loc_cGrupo = ALLTRIM(cursor_4c_Dados.grupos)
648:         loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o do grupo '" + ;
649:             loc_cGrupo + "'?", "Excluir Recebimento")
650:         IF loc_lConfirma
651:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupo)
652:                 IF THIS.this_oBusinessObject.Excluir()
653:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
654:                     THIS.CarregarLista()
655:                 ENDIF
656:             ENDIF
657:         ENDIF
658:     ENDPROC
659: 
660:     *==========================================================================
661:     * BtnBuscarClick - Localiza registro via FormBuscaAuxiliar (PUBLIC para BINDEVENT)
662:     *==========================================================================
663:     PROCEDURE BtnBuscarClick()
664:         LOCAL loc_oBusca, loc_cGrupo, loc_lSelecionou
665:         loc_lSelecionou = .F.
666:         loc_cGrupo = ""
667: 
668:         TRY
669:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
670:                 "SIGCDREC", "cursor_4c_BuscaRec", "grupos", "", ;
671:                 "Buscar Recebimento")
672: 
673:             IF VARTYPE(loc_oBusca) = "O"
674:                 loc_oBusca.mAddColuna("grupos", "", "Grupo")
675:                 loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
676:                 loc_oBusca.Show()
677: 
678:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaRec")
679:                     SELECT cursor_4c_BuscaRec
680:                     loc_cGrupo      = ALLTRIM(cursor_4c_BuscaRec.grupos)
681:                     loc_lSelecionou = .T.
682:                 ENDIF
683: 
684:                 loc_oBusca.Release()
685:             ENDIF
686:         CATCH TO loException
687:             MsgErro("Erro na busca:" + CHR(13) + loException.Message, "Erro")
688:         ENDTRY
689: 
690:         IF USED("cursor_4c_BuscaRec")
691:             USE IN cursor_4c_BuscaRec
692:         ENDIF
693: 
694:         IF loc_lSelecionou AND USED("cursor_4c_Dados")
695:             SELECT cursor_4c_Dados
696:             LOCATE FOR ALLTRIM(grupos) = loc_cGrupo
697:             THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
698:         ENDIF
699:     ENDPROC
700: 
701:     *==========================================================================
702:     * BtnSalvarClick - Salva o registro (PUBLIC para BINDEVENT, chamado de Page2)
703:     *==========================================================================
704:     PROCEDURE BtnSalvarClick()
705:         LOCAL loc_lSucesso
706:         loc_lSucesso = .F.
707: 
708:         *-- Validacao ANTES do TRY (CLAUDE.md regra critica)
709:         IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_CdGrupo.Value))
710:             MsgAviso("Grupo n" + CHR(227) + "o pode ficar em branco!", ;
711:                 "Valida" + CHR(231) + CHR(227) + "o")
712:             THIS.pgf_4c_Paginas.Page2.txt_4c_CdGrupo.SetFocus()
713:             RETURN loc_lSucesso
714:         ENDIF
715: 
716:         *-- Verificar duplicidade apenas no INCLUIR (legado: ChkRegister)
717:         IF THIS.this_cModoAtual = "INCLUIR"
718:             IF THIS.this_oBusinessObject.VerificarCodigoExiste( ;
719:                 ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_CdGrupo.Value))
720:                 MsgAviso("Grupo j" + CHR(225) + " cadastrado!", ;
721:                     "Valida" + CHR(231) + CHR(227) + "o")
722:                 THIS.pgf_4c_Paginas.Page2.txt_4c_CdGrupo.SetFocus()
723:                 RETURN loc_lSucesso
724:             ENDIF
725:         ENDIF
726: 
727:         TRY
728:             THIS.FormParaBO()
729:             IF THIS.this_oBusinessObject.Salvar()
730:                 MsgInfo("Registro salvo com sucesso!", "Salvar")
731:                 THIS.this_cModoAtual = "LISTA"
732:                 THIS.AlternarPagina(1)
733:                 loc_lSucesso = .T.
734:             ENDIF
735:         CATCH TO loException
736:             MsgErro("Erro ao salvar:" + CHR(13) + loException.Message, "Erro")
737:         ENDTRY
738: 
739:         RETURN loc_lSucesso
740:     ENDPROC
741: 
742:     *==========================================================================
743:     * BtnCancelarClick - Cancela edicao e volta a lista (PUBLIC para BINDEVENT)
744:     *==========================================================================
745:     PROCEDURE BtnCancelarClick()
746:         THIS.this_cModoAtual = "LISTA"
747:         THIS.AlternarPagina(1)
748:     ENDPROC
749: 
750:     *==========================================================================
751:     * FormParaBO - Transfere campos do form para o BO antes de salvar
752:     *==========================================================================
753:     PROTECTED PROCEDURE FormParaBO()
754:         LOCAL loc_oPagina
755:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
756: 
757:         THIS.this_oBusinessObject.this_cGrupos = ALLTRIM(loc_oPagina.txt_4c_CdGrupo.Value)
758:         THIS.this_oBusinessObject.this_cDescrs = ALLTRIM(loc_oPagina.txt_4c_DsGrupo.Value)
759:     ENDPROC
760: 
761:     *==========================================================================
762:     * BOParaForm - Transfere propriedades do BO para os campos do form
763:     *==========================================================================
764:     PROTECTED PROCEDURE BOParaForm()
765:         LOCAL loc_oPagina
766:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
767: 
768:         loc_oPagina.txt_4c_CdGrupo.Value = THIS.this_oBusinessObject.this_cGrupos
769:         loc_oPagina.txt_4c_DsGrupo.Value = THIS.this_oBusinessObject.this_cDescrs
770:     ENDPROC
771: 
772:     *==========================================================================
773:     * LimparCampos - Limpa valores dos campos da Page2
774:     *==========================================================================
775:     PROTECTED PROCEDURE LimparCampos()
776:         LOCAL loc_oPagina
777:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
778: 
779:         loc_oPagina.txt_4c_CdGrupo.Value = ""
780:         loc_oPagina.txt_4c_DsGrupo.Value = ""
781:     ENDPROC
782: 
783:     *==========================================================================
784:     * HabilitarCampos - Habilita/desabilita campos por modo
785:     * Legado: get_cd_grupo.When = INSERIR|PROCURAR; get_ds_grupo.When = INSERIR
786:     * Ambos os campos somente editaveis em INCLUIR
787:     *==========================================================================
788:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
789:         LOCAL loc_oPagina
790:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
791: 
792:         loc_oPagina.txt_4c_CdGrupo.ReadOnly = !(THIS.this_cModoAtual = "INCLUIR")
793:         loc_oPagina.txt_4c_DsGrupo.ReadOnly = !(THIS.this_cModoAtual = "INCLUIR")
794:     ENDPROC
795: 
796:     *==========================================================================
797:     * AjustarBotoesPorModo - Ajusta botoes da Page2 conforme modo atual
798:     *==========================================================================
799:     PROTECTED PROCEDURE AjustarBotoesPorModo()
800:         LOCAL loc_oPagina
801:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
802: 
803:         DO CASE
804:             CASE THIS.this_cModoAtual = "VISUALIZAR"
805:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
806:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
807:             CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
808:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
809:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
810:             OTHERWISE
811:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
812:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
813:         ENDCASE
814:     ENDPROC
815: 
816:     *==========================================================================
817:     * CdGrupoKeyPress - F4 em txt_4c_CdGrupo abre lookup SigCdGcr
818:     * PUBLIC obrigatorio: BINDEVENT requer PUBLIC (CLAUDE.md regra #3)
819:     *==========================================================================
820:     PROCEDURE CdGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
821:         IF par_nKeyCode = 28  && F4 em VFP9
822:             THIS.AbrirBuscaGrupo("")
823:         ENDIF
824:     ENDPROC
825: 
826:     *==========================================================================
827:     * CdGrupoDblClick - DblClick em txt_4c_CdGrupo abre lookup SigCdGcr
828:     * PUBLIC obrigatorio: BINDEVENT requer PUBLIC (CLAUDE.md regra #3)
829:     *==========================================================================
830:     PROCEDURE CdGrupoDblClick()
831:         THIS.AbrirBuscaGrupo("")
832:     ENDPROC
833: 
834:     *==========================================================================
835:     * DsGrupoKeyPress - F4 em txt_4c_DsGrupo abre lookup SigCdGcr por descricao
836:     * PUBLIC obrigatorio: BINDEVENT requer PUBLIC (CLAUDE.md regra #3)
837:     *==========================================================================
838:     PROCEDURE DsGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
839:         LOCAL loc_cDesc
840:         IF par_nKeyCode = 28  && F4 em VFP9
841:             loc_cDesc = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_DsGrupo.Value)
842:             THIS.AbrirBuscaGrupo(loc_cDesc)
843:         ENDIF
844:     ENDPROC
845: 
846:     *==========================================================================
847:     * DsGrupoDblClick - DblClick em txt_4c_DsGrupo abre lookup SigCdGcr por descricao
848:     * PUBLIC obrigatorio: BINDEVENT requer PUBLIC (CLAUDE.md regra #3)
849:     *==========================================================================
850:     PROCEDURE DsGrupoDblClick()
851:         LOCAL loc_cDesc
852:         loc_cDesc = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_DsGrupo.Value)
853:         THIS.AbrirBuscaGrupo(loc_cDesc)
854:     ENDPROC
855: 
856:     *==========================================================================
857:     * ValidarCodigo - LostFocus de txt_4c_CdGrupo: busca descricao em SigCdGcr
858:     * Equivale a get_cd_grupo.Valid (fAcessoContab 'C') do legado
859:     * PUBLIC obrigatorio: BINDEVENT requer metodo PUBLIC (CLAUDE.md regra #3)
860:     *==========================================================================
861:     PROCEDURE ValidarCodigo(par_nKeyCode, par_nShiftAltCtrl)
862:         LOCAL loc_cCodigo, loc_oPagina
863:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
864:         loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdGrupo.Value)
865: 
866:         IF EMPTY(loc_cCodigo)
867:             loc_oPagina.txt_4c_DsGrupo.Value = ""
868:             RETURN
869:         ENDIF
870: 
871:         IF THIS.this_oBusinessObject.BuscarGrupoGcr(loc_cCodigo, "C")
872:             IF USED("cursor_4c_BuscaGcr") AND RECCOUNT("cursor_4c_BuscaGcr") > 0
873:                 SELECT cursor_4c_BuscaGcr
874:                 IF ALLTRIM(UPPER(cursor_4c_BuscaGcr.codigos)) = UPPER(loc_cCodigo)
875:                     loc_oPagina.txt_4c_DsGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
876:                 ELSE
877:                     THIS.AbrirBuscaGrupo(loc_cCodigo)
878:                 ENDIF
879:             ELSE
880:                 THIS.AbrirBuscaGrupo(loc_cCodigo)
881:             ENDIF
882:         ENDIF
883:     ENDPROC
884: 
885:     *==========================================================================
886:     * ValidarDescricao - LostFocus de txt_4c_DsGrupo: busca codigo em SigCdGcr
887:     * Equivale a get_ds_grupo.Valid (fAcessoContab 'D') do legado
888:     * PUBLIC obrigatorio: BINDEVENT requer metodo PUBLIC (CLAUDE.md regra #3)
889:     *==========================================================================
890:     PROCEDURE ValidarDescricao(par_nKeyCode, par_nShiftAltCtrl)
891:         LOCAL loc_cDesc, loc_oPagina
892:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
893:         loc_cDesc = ALLTRIM(loc_oPagina.txt_4c_DsGrupo.Value)
894: 
895:         IF EMPTY(loc_cDesc)
896:             loc_oPagina.txt_4c_CdGrupo.Value = ""
897:             RETURN
898:         ENDIF
899: 
900:         IF THIS.this_oBusinessObject.BuscarGrupoGcr(loc_cDesc, "D")
901:             IF USED("cursor_4c_BuscaGcr") AND RECCOUNT("cursor_4c_BuscaGcr") > 0
902:                 SELECT cursor_4c_BuscaGcr
903:                 IF RECCOUNT("cursor_4c_BuscaGcr") = 1
904:                     loc_oPagina.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.codigos)
905:                     loc_oPagina.txt_4c_DsGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
906:                 ELSE
907:                     THIS.AbrirBuscaGrupo(loc_cDesc)
908:                 ENDIF
909:             ELSE
910:                 THIS.AbrirBuscaGrupo(loc_cDesc)
911:             ENDIF
912:         ENDIF
913:     ENDPROC
914: 
915:     *==========================================================================
916:     * AbrirBuscaGrupo - Abre FormBuscaAuxiliar para selecao em SigCdGcr
917:     *==========================================================================
918:     PROTECTED PROCEDURE AbrirBuscaGrupo(par_cFiltro)
919:         LOCAL loc_oBusca, loc_oPagina
920:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
921: 
922:         TRY
923:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
924:                 "SigCdGcr", "cursor_4c_BuscaGcr", "codigos", par_cFiltro, ;
925:                 "Selecionar Grupo Cont" + CHR(225) + "bil")
926: 
927:             IF VARTYPE(loc_oBusca) = "O"
928:                 loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
929:                 loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
930:                 loc_oBusca.Show()
931: 
932:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
933:                     SELECT cursor_4c_BuscaGcr
934:                     loc_oPagina.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.codigos)
935:                     loc_oPagina.txt_4c_DsGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
936:                 ELSE
937:                     loc_oPagina.txt_4c_CdGrupo.Value = ""
938:                     loc_oPagina.txt_4c_DsGrupo.Value = ""
939:                 ENDIF
940: 
941:                 loc_oBusca.Release()
942:             ENDIF
943:         CATCH TO loException
944:             MsgErro("Erro ao abrir busca de grupo:" + CHR(13) + loException.Message, "Erro")
945:         ENDTRY
946:     ENDPROC
947: 
948:     *==========================================================================
949:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
950:     * Necessario pois AddObject() cria controles com Visible=.F. por padrao
951:     *==========================================================================
952:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
953:         LOCAL loc_nI, loc_oObjeto, loc_nP
954: 
955:         FOR loc_nI = 1 TO par_oContainer.ControlCount
956:             loc_oObjeto = par_oContainer.Controls(loc_nI)
957: 
958:             IF VARTYPE(loc_oObjeto) = "O"
959:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
960:                     loc_oObjeto.Visible = .T.
961:                 ENDIF
962: 
963:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
964:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
965:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
966:                     ENDFOR
967:                 ENDIF
968: 
969:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
970:                     THIS.TornarControlesVisiveis(loc_oObjeto)
971:                 ENDIF
972:             ENDIF
973:         ENDFOR
974:     ENDPROC
975: 
976:     *==========================================================================
977:     * Destroy - Libera recursos
978:     *==========================================================================
979:     PROCEDURE Destroy()
980:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
981:             THIS.this_oBusinessObject = .NULL.
982:         ENDIF
983:         DODEFAULT()
984:     ENDPROC
985: 
986: ENDDEFINE


### BO (C:\4c\projeto\app\classes\RecBO.prg):
*====================================================================
* RecBO.prg
*
* Business Object para Cadastro Financeiro de Recebimentos
* Tabela: SIGCDREC
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS RecBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SIGCDREC)
    this_cGrupos    = ""    && grupos char(10) - PK (FK -> SigCdGcr.codigos)
    this_cDescrs    = ""    && descrs char(20)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SIGCDREC"
            THIS.this_cCampoChave = "grupos"
            loc_lSucesso = .T.
        CATCH TO loException
            MsgErro("Erro ao inicializar RecBO:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna PK atual para auditoria (PROTECTED)
    *====================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cGrupos
    ENDFUNC

    *====================================================================
    * Buscar - SELECT todos os registros (PUBLIC)
    *====================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT grupos, descrs" + ;
                       " FROM SIGCDREC" + ;
                       " ORDER BY grupos"

            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar recebimentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar recebimentos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pelo PK (PUBLIC)
    *====================================================================
    FUNCTION CarregarPorCodigo(par_cGrupos)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT grupos, descrs" + ;
                       " FROM SIGCDREC" + ;
                       " WHERE grupos = " + EscaparSQL(par_cGrupos)

            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar recebimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar recebimento:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Popula propriedades a partir de cursor (PROTECTED)
    *====================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cGrupos = TratarNulo(grupos, "C")
            THIS.this_cDescrs = TratarNulo(descrs, "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * Inserir - INSERT na tabela SIGCDREC (PROTECTED)
    *====================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SIGCDREC (grupos, descrs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cGrupos) + ", " + ;
                       EscaparSQL(THIS.this_cDescrs) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir recebimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir recebimento:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * Atualizar - UPDATE na tabela SIGCDREC (PROTECTED)
    *====================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SIGCDREC SET" + ;
                       " descrs = " + EscaparSQL(THIS.this_cDescrs) + ;
                       " WHERE grupos = " + EscaparSQL(THIS.this_cGrupos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar recebimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar recebimento:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * ExecutarExclusao - DELETE na tabela SIGCDREC (PROTECTED)
    *====================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SIGCDREC" + ;
                       " WHERE grupos = " + EscaparSQL(THIS.this_cGrupos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir recebimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir recebimento:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * ValidarDados - Valida regras de negocio antes de salvar (PUBLIC)
    *====================================================================
    FUNCTION ValidarDados()
        LOCAL loc_lResultado
        loc_lResultado = .T.

        IF EMPTY(ALLTRIM(THIS.this_cGrupos))
            MsgAviso("Grupo n" + CHR(227) + "o pode ficar em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * VerificarCodigoExiste - Verifica se grupo ja cadastrado em SIGCDREC (PUBLIC)
    * Equivalente ao ChkRegister('SigCdRec','grupos',...) do legado
    *====================================================================
    FUNCTION VerificarCodigoExiste(par_cGrupos)
        LOCAL loc_lExiste, loc_cSQL, loc_nResult
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT grupos FROM SIGCDREC" + ;
                       " WHERE grupos = " + EscaparSQL(par_cGrupos)

            IF USED("cursor_4c_ChkCod")
                TABLEREVERT(.T., "cursor_4c_ChkCod")
                USE IN cursor_4c_ChkCod
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkCod") > 0
                loc_lExiste = .T.
            ENDIF

            IF USED("cursor_4c_ChkCod")
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ChkCod")
                USE IN cursor_4c_ChkCod
            ENDIF
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

    *====================================================================
    * BuscarGrupoGcr - Busca grupo em SigCdGcr por codigo ou descricao (PUBLIC)
    * Equivalente ao fAcessoContab() do legado
    * par_cTipo = 'C' busca por codigo, 'D' busca por descricao
    *====================================================================
    FUNCTION BuscarGrupoGcr(par_cValor, par_cTipo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF par_cTipo = "C"
                loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr" + ;
                           " WHERE codigos = " + EscaparSQL(par_cValor) + ;
                           " ORDER BY codigos"
            ELSE
                loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr" + ;
                           " WHERE descrs LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%") + ;
                           " ORDER BY descrs"
            ENDIF

            IF USED("cursor_4c_BuscaGcr")
                TABLEREVERT(.T., "cursor_4c_BuscaGcr")
                USE IN cursor_4c_BuscaGcr
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGcr")

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * Destroy - Libera cursores
    *====================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF
        IF USED("cursor_4c_ChkCod")
            USE IN cursor_4c_ChkCod
        ENDIF
        IF USED("cursor_4c_BuscaGcr")
            USE IN cursor_4c_BuscaGcr
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

