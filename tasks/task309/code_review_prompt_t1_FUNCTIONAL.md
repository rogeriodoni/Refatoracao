# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (4)
- [BINDEVENT-PARAMS] Handler 'ValidarGrupoLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGrupoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarContaLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarContaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [GRID-HEADER] Header Caption 'Grupo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ocorrência, Descrição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Conta' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ocorrência, Descrição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSIGPRLNC.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1599 linhas total):

*-- Linhas 27 a 155:
27:     this_cGruContasAtual = ""
28: 
29:     *--------------------------------------------------------------------------
30:     * Init - DODEFAULT() ja chama InicializarForm() via FormBase.Init()
31:     *--------------------------------------------------------------------------
32:     PROCEDURE Init()
33:         RETURN DODEFAULT()
34:     ENDPROC
35: 
36:     *--------------------------------------------------------------------------
37:     * InicializarForm - Configuracao completa do formulario
38:     *--------------------------------------------------------------------------
39:     PROTECTED PROCEDURE InicializarForm()
40:         LOCAL loc_lSucesso
41:         loc_lSucesso = .F.
42: 
43:         TRY
44:             *-- Criar cursor local para lista de ocorrencias (equivalente ao csSigClLan do legado)
45:             IF USED("cursor_4c_OcoLocal")
46:                 USE IN cursor_4c_OcoLocal
47:             ENDIF
48:             SET NULL ON
49:             CREATE CURSOR cursor_4c_OcoLocal (Grupos C(10), Contas C(10), Cocos C(2), descs C(30))
50:             SET NULL OFF
51:             INDEX ON Cocos TAG Cocos
52: 
53:             THIS.this_oBusinessObject = CREATEOBJECT("SIGPRLNCBO")
54: 
55:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
56:                 MostrarErro("Erro ao criar SIGPRLNCBO", "Erro Cr" + CHR(237) + "tico")
57:             ELSE
58:                 THIS.Caption = "Cadastro de Lan" + CHR(231) + "amentos"
59: 
60:                 THIS.ConfigurarPageFrame()
61:                 THIS.ConfigurarPaginaLista()
62:                 THIS.ConfigurarPaginaDados()
63: 
64:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
65: 
66:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
67:                     IF !THIS.CarregarLista()
68:                         *-- Falha ao carregar nao impede abertura do formulario
69:                     ENDIF
70:                 ENDIF
71: 
72:                 THIS.pgf_4c_Paginas.Visible    = .T.
73:                 THIS.pgf_4c_Paginas.ActivePage = 1
74:                 THIS.this_cModoAtual           = "LISTA"
75:                 loc_lSucesso = .T.
76:             ENDIF
77: 
78:         CATCH TO loException
79:             MostrarErro("Erro ao inicializar FormSIGPRLNC:" + CHR(13) + ;
80:                         "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
81:                         loException.Message, "Erro")
82:             loc_lSucesso = .F.
83:         ENDTRY
84: 
85:         RETURN loc_lSucesso
86:     ENDPROC
87: 
88:     *--------------------------------------------------------------------------
89:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
90:     *--------------------------------------------------------------------------
91:     PROTECTED PROCEDURE ConfigurarPageFrame()
92:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
93:         WITH THIS.pgf_4c_Paginas
94:             .Top        = -29
95:             .Left       = 0
96:             .Width      = 1003
97:             .Height     = 629
98:             .PageCount  = 2
99:             .Tabs       = .F.
100:             .Visible    = .T.
101: 
102:             .Page1.Caption   = "Lista"
103:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:             .Page1.BackColor = RGB(255, 255, 255)
105: 
106:             .Page2.Caption   = "Dados"
107:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
108:             .Page2.BackColor = RGB(255, 255, 255)
109:         ENDWITH
110:     ENDPROC
111: 
112:     *--------------------------------------------------------------------------
113:     * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD e grid de lancamentos
114:     *--------------------------------------------------------------------------
115:     PROTECTED PROCEDURE ConfigurarPaginaLista()
116:         LOCAL loc_oPagina
117:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
118: 
119:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
120: 
121:         *-- Container cabecalho escuro (cntSombra: Top=2+29=31)
122:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
123:         WITH loc_oPagina.cnt_4c_Cabecalho
124:             .Top         = 31
125:             .Left        = 0
126:             .Width       = 1020
127:             .Height      = 80
128:             .BackColor   = RGB(100, 100, 100)
129:             .BackStyle   = 1
130:             .BorderWidth = 0
131:             .Visible     = .T.
132:         ENDWITH
133: 
134:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
135:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
136:             .Caption   = "Cadastro de Lan" + CHR(231) + "amentos"
137:             .Top       = 15
138:             .Left      = 10
139:             .Width     = THIS.Width
140:             .Height    = 40
141:             .AutoSize  = .F.
142:             .FontName  = "Tahoma"
143:             .FontSize  = 16
144:             .FontBold  = .T.
145:             .BackStyle = 0
146:             .ForeColor = RGB(0, 0, 0)
147:             .Visible   = .T.
148:         ENDWITH
149: 
150:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
151:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
152:             .Caption   = "Cadastro de Lan" + CHR(231) + "amentos"
153:             .Top       = 18
154:             .Left      = 10
155:             .Width     = THIS.Width

*-- Linhas 196 a 501:
196:             .WordWrap        = .T.
197:             .Visible         = .T.
198:         ENDWITH
199:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
200: 
201:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
202:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
203:             .Caption         = "Visualizar"
204:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
205:             .PicturePosition = 13
206:             .Top             = 5
207:             .Left            = 80
208:             .Width           = 75
209:             .Height          = 75
210:             .BackColor       = RGB(255, 255, 255)
211:             .ForeColor       = RGB(90, 90, 90)
212:             .FontName        = "Comic Sans MS"
213:             .FontSize        = 8
214:             .FontBold        = .T.
215:             .FontItalic      = .T.
216:             .Themes          = .F.
217:             .SpecialEffect   = 0
218:             .MousePointer    = 15
219:             .WordWrap        = .T.
220:             .Visible         = .T.
221:         ENDWITH
222:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
223: 
224:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
225:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
226:             .Caption         = "Alterar"
227:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
228:             .PicturePosition = 13
229:             .Top             = 5
230:             .Left            = 155
231:             .Width           = 75
232:             .Height          = 75
233:             .BackColor       = RGB(255, 255, 255)
234:             .ForeColor       = RGB(90, 90, 90)
235:             .FontName        = "Comic Sans MS"
236:             .FontSize        = 8
237:             .FontBold        = .T.
238:             .FontItalic      = .T.
239:             .Themes          = .F.
240:             .SpecialEffect   = 0
241:             .MousePointer    = 15
242:             .WordWrap        = .T.
243:             .Visible         = .T.
244:         ENDWITH
245:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
246: 
247:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
248:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
249:             .Caption         = "Excluir"
250:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
251:             .PicturePosition = 13
252:             .Top             = 5
253:             .Left            = 230
254:             .Width           = 75
255:             .Height          = 75
256:             .BackColor       = RGB(255, 255, 255)
257:             .ForeColor       = RGB(90, 90, 90)
258:             .FontName        = "Comic Sans MS"
259:             .FontSize        = 8
260:             .FontBold        = .T.
261:             .FontItalic      = .T.
262:             .Themes          = .F.
263:             .SpecialEffect   = 0
264:             .MousePointer    = 15
265:             .WordWrap        = .T.
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
282:             .FontSize        = 8
283:             .FontBold        = .T.
284:             .FontItalic      = .T.
285:             .Themes          = .F.
286:             .SpecialEffect   = 0
287:             .MousePointer    = 15
288:             .WordWrap        = .T.
289:             .Visible         = .T.
290:         ENDWITH
291:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
292: 
293:         *-- Container saida canonico (Left=917, Width=90, cmd_4c_Encerrar 75x75)
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
308:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
309:             .PicturePosition = 13
310:             .Top             = 5
311:             .Left            = 5
312:             .Width           = 75
313:             .Height          = 75
314:             .BackColor       = RGB(255, 255, 255)
315:             .ForeColor       = RGB(90, 90, 90)
316:             .FontName        = "Comic Sans MS"
317:             .FontSize        = 8
318:             .FontBold        = .T.
319:             .FontItalic      = .T.
320:             .Themes          = .F.
321:             .SpecialEffect   = 0
322:             .MousePointer    = 15
323:             .WordWrap        = .T.
324:             .Visible         = .T.
325:         ENDWITH
326:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
327: 
328:         *-- Grid de lancamentos: Grupos/Contas distintos de SigClLan
329:         *-- Top=117 (abaixo do cabecalho h=80 em top=31, com margem)
330:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
331:         WITH loc_oPagina.grd_4c_Lista
332:             .Top                = 117
333:             .Left               = 2
334:             .Width              = 950
335:             .Height             = 452
336:             .ColumnCount        = 2
337:             .FontName           = "Verdana"
338:             .FontSize           = 8
339:             .ForeColor          = RGB(90, 90, 90)
340:             .BackColor          = RGB(255, 255, 255)
341:             .GridLineColor      = RGB(238, 238, 238)
342:             .HighlightBackColor = RGB(255, 255, 255)
343:             .HighlightForeColor = RGB(15, 41, 104)
344:             .HighlightStyle     = 2
345:             .DeleteMark         = .F.
346:             .RecordMark         = .F.
347:             .RowHeight          = 16
348:             .ScrollBars         = 2
349:             .GridLines          = 3
350:             .Visible            = .T.
351:         ENDWITH
352: 
353:         THIS.TornarControlesVisiveis(loc_oPagina)
354:     ENDPROC
355: 
356:     *--------------------------------------------------------------------------
357:     * ConfigurarPaginaDados - Page2: campos de identificacao (Grupo/Conta) e botoes
358:     * Fase 5/8: Container botoes + labels/textboxes de Grupo e Conta
359:     *--------------------------------------------------------------------------
360:     PROTECTED PROCEDURE ConfigurarPaginaDados()
361:         LOCAL loc_oPagina
362:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
363: 
364:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
365: 
366:         *-- Container botoes de acao (Grupo_Salva: Left=844, Top=-3+29=26 -> canonico 38)
367:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
368:         WITH loc_oPagina.cnt_4c_BotoesAcao
369:             .Top         = 38
370:             .Left        = 819
371:             .Width       = 165
372:             .Height      = 85
373:             .BackStyle = 1
374:             .BackColor   = RGB(255, 255, 255)
375:             .BorderWidth = 0
376:             .Visible     = .T.
377:         ENDWITH
378: 
379:         *-- Botao Salvar (Grupo_Salva.Salva: Left=5, Top=5)
380:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
381:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
382:             .Caption         = "Salvar"
383:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
384:             .PicturePosition = 13
385:             .Top             = 5
386:             .Left            = 5
387:             .Width           = 75
388:             .Height          = 75
389:             .BackColor       = RGB(255, 255, 255)
390:             .ForeColor       = RGB(90, 90, 90)
391:             .FontName        = "Comic Sans MS"
392:             .FontSize        = 8
393:             .FontBold        = .T.
394:             .FontItalic      = .T.
395:             .Themes          = .F.
396:             .SpecialEffect   = 0
397:             .MousePointer    = 15
398:             .WordWrap        = .T.
399:             .Visible         = .T.
400:         ENDWITH
401:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
402: 
403:         *-- Botao Cancelar (Grupo_Salva.Cancelar: Left=80, Top=5)
404:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
405:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
406:             .Caption         = "Encerrar"
407:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
408:             .PicturePosition = 13
409:             .Top             = 5
410:             .Left            = 80
411:             .Width           = 75
412:             .Height          = 75
413:             .BackColor       = RGB(255, 255, 255)
414:             .ForeColor       = RGB(90, 90, 90)
415:             .FontName        = "Comic Sans MS"
416:             .FontSize        = 8
417:             .FontBold        = .T.
418:             .FontItalic      = .T.
419:             .Themes          = .F.
420:             .SpecialEffect   = 0
421:             .MousePointer    = 15
422:             .WordWrap        = .T.
423:             .Visible         = .T.
424:         ENDWITH
425:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
426: 
427:         *-- Label "Grupo : " (Say2: Top=130+29=159, Left=257)
428:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
429:         WITH loc_oPagina.lbl_4c_Label2
430:             .Caption   = "Grupo : "
431:             .Top       = 159
432:             .Left      = 257
433:             .Width     = 80
434:             .Height    = 18
435:             .AutoSize  = .F.
436:             .FontName  = "Tahoma"
437:             .FontSize  = 8
438:             .FontBold  = .F.
439:             .BackStyle = 0
440:             .ForeColor = RGB(90, 90, 90)
441:             .Visible   = .T.
442:         ENDWITH
443: 
444:         *-- TextBox Grupo (Get_Grupos: Top=127+29=156, Left=300, Width=80)
445:         loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
446:         WITH loc_oPagina.txt_4c_Grupo
447:             .Value         = ""
448:             .Top           = 156
449:             .Left          = 300
450:             .Width         = 80
451:             .Height        = 23
452:             .FontName      = "Tahoma"
453:             .FontSize      = 8
454:             .ForeColor     = RGB(0, 0, 0)
455:             .BorderColor   = RGB(100, 100, 100)
456:             .SpecialEffect = 1
457:             .Visible       = .T.
458:         ENDWITH
459:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupoLostFocus")
460:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "GrupoKeyPress")
461:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "DblClick", THIS, "GrupoDblClick")
462: 
463:         *-- TextBox Descricao do Grupo (Get_Desc_Gru: Top=127+29=156, Left=382, Width=360)
464:         loc_oPagina.AddObject("txt_4c_Desc_Gru", "TextBox")
465:         WITH loc_oPagina.txt_4c_Desc_Gru
466:             .Value         = ""
467:             .Top           = 156
468:             .Left          = 382
469:             .Width         = 360
470:             .Height        = 23
471:             .FontName      = "Tahoma"
472:             .FontSize      = 8
473:             .ForeColor     = RGB(0, 0, 0)
474:             .BorderColor   = RGB(100, 100, 100)
475:             .SpecialEffect = 1
476:             .ReadOnly      = .T.
477:             .Visible       = .T.
478:         ENDWITH
479: 
480:         *-- Label "Conta : " (Say3: Top=155+29=184, Left=257)
481:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
482:         WITH loc_oPagina.lbl_4c_Label3
483:             .Caption   = "Conta : "
484:             .Top       = 184
485:             .Left      = 257
486:             .Width     = 80
487:             .Height    = 18
488:             .AutoSize  = .F.
489:             .FontName  = "Tahoma"
490:             .FontSize  = 8
491:             .FontBold  = .F.
492:             .BackStyle = 0
493:             .ForeColor = RGB(90, 90, 90)
494:             .Visible   = .T.
495:         ENDWITH
496: 
497:         *-- TextBox Conta (Get_Contas: Top=152+29=181, Left=300, Width=80)
498:         loc_oPagina.AddObject("txt_4c_Contas", "TextBox")
499:         WITH loc_oPagina.txt_4c_Contas
500:             .Value         = ""
501:             .Top           = 181

*-- Linhas 509 a 617:
509:             .SpecialEffect = 1
510:             .Visible       = .T.
511:         ENDWITH
512:         BINDEVENT(loc_oPagina.txt_4c_Contas, "KeyPress", THIS, "ValidarContaLostFocus")
513:         BINDEVENT(loc_oPagina.txt_4c_Contas, "KeyPress", THIS, "ContaKeyPress")
514:         BINDEVENT(loc_oPagina.txt_4c_Contas, "DblClick", THIS, "ContaDblClick")
515: 
516:         *-- TextBox Descricao da Conta (Get_Desc_Con: Top=152+29=181, Left=382, Width=360)
517:         loc_oPagina.AddObject("txt_4c_Desc_Con", "TextBox")
518:         WITH loc_oPagina.txt_4c_Desc_Con
519:             .Value         = ""
520:             .Top           = 181
521:             .Left          = 382
522:             .Width         = 360
523:             .Height        = 23
524:             .FontName      = "Tahoma"
525:             .FontSize      = 8
526:             .ForeColor     = RGB(0, 0, 0)
527:             .BorderColor   = RGB(100, 100, 100)
528:             .SpecialEffect = 1
529:             .ReadOnly      = .T.
530:             .Visible       = .T.
531:         ENDWITH
532: 
533:         *-- Botao Inserir Ocorrencia (inserir: Top=335+29=364, Left=629, 40x40)
534:         loc_oPagina.AddObject("cmd_4c_InserirOco", "CommandButton")
535:         WITH loc_oPagina.cmd_4c_InserirOco
536:             .Caption         = ""
537:             .Picture         = gc_4c_CaminhoIcones + "geral_selecionar_26.jpg"
538:             .PicturePosition = 7
539:             .Top             = 364
540:             .Left            = 629
541:             .Width           = 40
542:             .Height          = 40
543:             .FontName        = "Arial"
544:             .FontSize        = 9
545:             .FontBold        = .T.
546:             .BackColor       = RGB(255, 255, 255)
547:             .ForeColor       = RGB(0, 128, 0)
548:             .Themes          = .T.
549:             .SpecialEffect   = 0
550:             .MousePointer    = 15
551:             .ToolTipText     = "Inserir"
552:             .Visible         = .T.
553:         ENDWITH
554:         BINDEVENT(loc_oPagina.cmd_4c_InserirOco, "Click", THIS, "BtnInserirOcoClick")
555: 
556:         *-- Botao Excluir Ocorrencia (excluir: Top=375+29=404, Left=629, 40x40)
557:         loc_oPagina.AddObject("cmd_4c_ExcluirOco", "CommandButton")
558:         WITH loc_oPagina.cmd_4c_ExcluirOco
559:             .Caption         = ""
560:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
561:             .PicturePosition = 7
562:             .Top             = 404
563:             .Left            = 629
564:             .Width           = 40
565:             .Height          = 40
566:             .FontName        = "Arial"
567:             .FontSize        = 9
568:             .FontBold        = .T.
569:             .BackColor       = RGB(255, 255, 255)
570:             .ForeColor       = RGB(255, 0, 0)
571:             .Themes          = .T.
572:             .SpecialEffect   = 0
573:             .MousePointer    = 15
574:             .ToolTipText     = "Excluir"
575:             .Visible         = .T.
576:         ENDWITH
577:         BINDEVENT(loc_oPagina.cmd_4c_ExcluirOco, "Click", THIS, "BtnExcluirOcoClick")
578: 
579:         *-- Grid de Ocorrencias (Gradeoco: Top=181+29=210, Left=300, Width=324, Height=403)
580:         LOCAL loc_oGrid
581:         loc_oPagina.AddObject("grd_4c_Ocorrencias", "Grid")
582:         loc_oGrid = loc_oPagina.grd_4c_Ocorrencias
583:         loc_oGrid.ColumnCount = 3
584:         loc_oGrid.RecordSource = "cursor_4c_OcoLocal"
585:         loc_oGrid.ColumnCount  = 2
586:         WITH loc_oGrid
587:             .Top                = 210
588:             .Left               = 300
589:             .Width              = 324
590:             .Height             = 403
591:             .FontName           = "Verdana"
592:             .FontSize           = 8
593:             .Panel              = 1
594:             .RowHeight          = 16
595:             .ScrollBars         = 2
596:             .GridLines          = 3
597:             .GridLineColor      = RGB(238, 238, 238)
598:             .DeleteMark         = .F.
599:             .RecordMark         = .F.
600:             .HighlightStyle     = 2
601:             .HighlightBackColor = RGB(255, 255, 255)
602:             .HighlightForeColor = RGB(15, 41, 104)
603:             .Visible            = .T.
604: 
605:             .Column1.ControlSource     = "cursor_4c_OcoLocal.Cocos"
606:             .Column1.Width             = 70
607:             .Column1.Movable           = .F.
608:             .Column1.Resizable         = .F.
609:             .Column1.Visible           = .T.
610:             .Column1.Sparse            = .F.
611:             .Column1.Header1.Caption   = "Ocorr" + CHR(234) + "ncia"
612:             .Column1.Header1.FontName  = "Tahoma"
613:             .Column1.Header1.FontSize  = 8
614:             .Column1.Header1.Alignment = 2
615:             .Column1.Text1.FontName    = "Verdana"
616:             .Column1.Text1.FontSize    = 8
617:             .Column1.Text1.BorderStyle = 0

*-- Linhas 633 a 757:
633:             .Column2.Text1.Margin      = 0
634:             .Column2.Text1.ReadOnly    = .T.
635:         ENDWITH
636:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GradeAfterRowColChange")
637: 
638:         THIS.TornarControlesVisiveis(loc_oPagina)
639:     ENDPROC
640: 
641:     *--------------------------------------------------------------------------
642:     * CarregarLista - Busca lancamentos distintos e vincula ao grd_4c_Lista
643:     *--------------------------------------------------------------------------
644:     PROCEDURE CarregarLista()
645:         LOCAL loc_lSucesso, loc_oGrid
646:         loc_lSucesso = .F.
647: 
648:         TRY
649:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
650:                 loc_lSucesso = .T.
651:             ELSE
652:                 IF THIS.this_oBusinessObject.Buscar("")
653:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
654: 
655:                     *-- RecordSource e ColumnCount ANTES do WITH (Problema 48/36)
656:                     loc_oGrid.ColumnCount = 3
657:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
658:                     loc_oGrid.ColumnCount  = 2
659: 
660:                     WITH loc_oGrid
661:                         .Column1.ControlSource   = "cursor_4c_Dados.grupos"
662:                         .Column1.Width           = 200
663:                         .Column1.Header1.Caption = "Grupo"
664: 
665:                         .Column2.ControlSource   = "cursor_4c_Dados.contas"
666:                         .Column2.Width           = 200
667:                         .Column2.Header1.Caption = "Conta"
668:                     ENDWITH
669: 
670:                     THIS.FormatarGridLista(loc_oGrid)
671:                     THIS.AjustarBotoesPorModo()
672:                     loc_lSucesso = .T.
673:                 ENDIF
674:             ENDIF
675:         CATCH TO loException
676:             MsgErro("Erro em FormSIGPRLNC.CarregarLista: " + loException.Message, "Erro")
677:             loc_lSucesso = .F.
678:         ENDTRY
679: 
680:         RETURN loc_lSucesso
681:     ENDPROC
682: 
683:     *--------------------------------------------------------------------------
684:     * AlternarPagina - Alterna entre Page1 (lista) e Page2 (dados)
685:     *--------------------------------------------------------------------------
686:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
687:         LOCAL loc_lSucesso
688:         loc_lSucesso = .F.
689: 
690:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
691:             RETURN .F.
692:         ENDIF
693: 
694:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
695: 
696:         IF par_nPagina = 1
697:             THIS.CarregarLista()
698:         ENDIF
699: 
700:         loc_lSucesso = .T.
701:         RETURN loc_lSucesso
702:     ENDPROC
703: 
704:     *--------------------------------------------------------------------------
705:     * FormatarGridLista - Aplica formatacao visual uniforme ao grid da Page1
706:     *--------------------------------------------------------------------------
707:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
708:         WITH par_oGrid
709:             .FontName = "Tahoma"
710:             .FontSize = 8
711:         ENDWITH
712:     ENDPROC
713: 
714:     *--------------------------------------------------------------------------
715:     * CarregarPaginaDados - Carrega campos de identificacao e ocorrencias na Page2
716:     *--------------------------------------------------------------------------
717:     PROTECTED PROCEDURE CarregarPaginaDados(par_cGruContas)
718:         LOCAL loc_lSucesso, loc_oPagina, loc_cGrupos, loc_cContas
719:         loc_lSucesso = .F.
720:         loc_oPagina  = THIS.pgf_4c_Paginas.Page2
721:         loc_cGrupos  = ALLTRIM(LEFT(par_cGruContas, 10))
722:         loc_cContas  = ALLTRIM(RIGHT(par_cGruContas, 10))
723: 
724:         TRY
725:             *-- Preencher campos de identificacao (criados na Fase 5)
726:             IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
727:                 loc_oPagina.txt_4c_Grupo.Value = loc_cGrupos
728:             ENDIF
729:             IF PEMSTATUS(loc_oPagina, "txt_4c_Contas", 5)
730:                 loc_oPagina.txt_4c_Contas.Value = loc_cContas
731:             ENDIF
732: 
733:             *-- Carregar descricoes via SQL
734:             THIS.IniciarDescricoes()
735: 
736:             *-- Carregar ocorrencias no cursor local (grid vinculado na Fase 6)
737:             IF USED("cursor_4c_OcoLocal")
738:                 ZAP IN cursor_4c_OcoLocal
739:             ENDIF
740: 
741:             IF THIS.this_oBusinessObject.BuscarOcorrencias(par_cGruContas)
742:                 *-- Copiar ocorrencias do cursor SQL para cursor local (preserva grid)
743:                 IF USED("cursor_4c_Ocorrencias") AND RECCOUNT("cursor_4c_Ocorrencias") > 0
744:                     SELECT cursor_4c_Ocorrencias
745:                     GO TOP
746:                     DO WHILE !EOF()
747:                         SELECT cursor_4c_OcoLocal
748:                         APPEND BLANK
749:                         REPLACE Grupos WITH ALLTRIM(cursor_4c_Ocorrencias.grupos)
750:                         REPLACE Contas WITH ALLTRIM(cursor_4c_Ocorrencias.contas)
751:                         REPLACE Cocos  WITH ALLTRIM(cursor_4c_Ocorrencias.cocos)
752:                         REPLACE descs  WITH ALLTRIM(cursor_4c_Ocorrencias.descs)
753:                         SELECT cursor_4c_Ocorrencias
754:                         SKIP
755:                     ENDDO
756:                 ENDIF
757:                 GO TOP IN cursor_4c_OcoLocal

*-- Linhas 768 a 1018:
768:     *--------------------------------------------------------------------------
769:     * LimparCampos - Zera propriedades do BO e campos da Page2 para modo de inclusao
770:     *--------------------------------------------------------------------------
771:     PROTECTED PROCEDURE LimparCampos()
772:         LOCAL loc_oPagina
773:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
774: 
775:         THIS.this_oBusinessObject.this_cGrupos    = ""
776:         THIS.this_oBusinessObject.this_cContas    = ""
777:         THIS.this_oBusinessObject.this_cCocos     = ""
778:         THIS.this_oBusinessObject.this_cCidChaves = ""
779:         THIS.this_oBusinessObject.this_cGruContas = ""
780: 
781:         IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
782:             loc_oPagina.txt_4c_Grupo.Value    = ""
783:             loc_oPagina.txt_4c_Desc_Gru.Value = ""
784:             loc_oPagina.txt_4c_Contas.Value   = ""
785:             loc_oPagina.txt_4c_Desc_Con.Value = ""
786:         ENDIF
787: 
788:         IF USED("cursor_4c_OcoLocal")
789:             ZAP IN cursor_4c_OcoLocal
790:         ENDIF
791:     ENDPROC
792: 
793:     *--------------------------------------------------------------------------
794:     * BtnIncluirClick - Navega para Page2 em modo de inclusao de novo grupo+conta
795:     *--------------------------------------------------------------------------
796:     PROCEDURE BtnIncluirClick()
797:         THIS.this_oBusinessObject.NovoRegistro()
798:         THIS.this_cModoAtual      = "INSERIR"
799:         THIS.this_cGrupoAtual     = ""
800:         THIS.this_cContaAtual     = ""
801:         THIS.this_cGruContasAtual = ""
802:         THIS.LimparCampos()
803:         THIS.HabilitarCampos(.T.)
804:         THIS.AlternarPagina(2)
805:     ENDPROC
806: 
807:     *--------------------------------------------------------------------------
808:     * BtnVisualizarClick - Navega para Page2 em modo consulta (somente leitura)
809:     *--------------------------------------------------------------------------
810:     PROCEDURE BtnVisualizarClick()
811:         LOCAL loc_cGrupos, loc_cContas, loc_cGruContas
812:         loc_cGrupos    = ""
813:         loc_cContas    = ""
814:         loc_cGruContas = ""
815: 
816:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
817:             SELECT cursor_4c_Dados
818:             loc_cGrupos    = ALLTRIM(grupos)
819:             loc_cContas    = ALLTRIM(contas)
820:             loc_cGruContas = ALLTRIM(grucontas)
821:         ELSE
822:             MsgAviso("Selecione um registro na lista.", "Selecionar")
823:             RETURN
824:         ENDIF
825: 
826:         THIS.this_cModoAtual      = "PROCURAR"
827:         THIS.this_cGrupoAtual     = loc_cGrupos
828:         THIS.this_cContaAtual     = loc_cContas
829:         THIS.this_cGruContasAtual = loc_cGruContas
830:         THIS.HabilitarCampos(.T.)
831: 
832:         THIS.CarregarPaginaDados(loc_cGruContas)
833:         THIS.AlternarPagina(2)
834:     ENDPROC
835: 
836:     *--------------------------------------------------------------------------
837:     * BtnAlterarClick - Navega para Page2 em modo de alteracao
838:     *--------------------------------------------------------------------------
839:     PROCEDURE BtnAlterarClick()
840:         LOCAL loc_cGrupos, loc_cContas, loc_cGruContas
841:         loc_cGrupos    = ""
842:         loc_cContas    = ""
843:         loc_cGruContas = ""
844: 
845:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
846:             SELECT cursor_4c_Dados
847:             loc_cGrupos    = ALLTRIM(grupos)
848:             loc_cContas    = ALLTRIM(contas)
849:             loc_cGruContas = ALLTRIM(grucontas)
850:         ELSE
851:             MsgAviso("Selecione um registro na lista.", "Selecionar")
852:             RETURN
853:         ENDIF
854: 
855:         THIS.this_cModoAtual      = "ALTERAR"
856:         THIS.this_cGrupoAtual     = loc_cGrupos
857:         THIS.this_cContaAtual     = loc_cContas
858:         THIS.this_cGruContasAtual = loc_cGruContas
859:         THIS.HabilitarCampos(.T.)
860: 
861:         THIS.CarregarPaginaDados(loc_cGruContas)
862:         THIS.AlternarPagina(2)
863:     ENDPROC
864: 
865:     *--------------------------------------------------------------------------
866:     * BtnExcluirClick - Exclui todos os lancamentos do grupo+conta selecionado
867:     *--------------------------------------------------------------------------
868:     PROCEDURE BtnExcluirClick()
869:         LOCAL loc_cGrupos, loc_cContas, loc_cGruContas, loc_lConfirmar
870:         loc_cGrupos    = ""
871:         loc_cContas    = ""
872:         loc_cGruContas = ""
873:         loc_lConfirmar = .F.
874: 
875:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
876:             SELECT cursor_4c_Dados
877:             loc_cGrupos    = ALLTRIM(grupos)
878:             loc_cContas    = ALLTRIM(contas)
879:             loc_cGruContas = ALLTRIM(grucontas)
880:         ELSE
881:             MsgAviso("Selecione um registro na lista.", "Selecionar")
882:             RETURN
883:         ENDIF
884: 
885:         loc_lConfirmar = MsgConfirma("Confirma a exclus" + CHR(227) + "o de todos os lan" + CHR(231) + "amentos" + CHR(13) + ;
886:                                      "do grupo '" + loc_cGrupos + "' / conta '" + loc_cContas + "'?", ;
887:                                      "Confirmar Exclus" + CHR(227) + "o")
888: 
889:         IF loc_lConfirmar
890:             IF THIS.this_oBusinessObject.ExcluirPorGruContas(loc_cGruContas)
891:                 MsgInfo("Lan" + CHR(231) + "amentos exclu" + CHR(237) + "dos com sucesso!", "Sucesso")
892:                 THIS.CarregarLista()
893:             ENDIF
894:         ENDIF
895:     ENDPROC
896: 
897:     *--------------------------------------------------------------------------
898:     * BtnBuscarClick - Recarrega a lista aplicando filtro atual
899:     *--------------------------------------------------------------------------
900:     PROCEDURE BtnBuscarClick()
901:         THIS.CarregarLista()
902:     ENDPROC
903: 
904:     *--------------------------------------------------------------------------
905:     * BtnEncerrarClick - Fecha o formulario
906:     *--------------------------------------------------------------------------
907:     PROCEDURE BtnEncerrarClick()
908:         THIS.Release()
909:     ENDPROC
910: 
911:     *--------------------------------------------------------------------------
912:     * BtnSalvarClick - Salva ocorrencias do grupo+conta (modo INSERIR/ALTERAR)
913:     *                  ou habilita grid de pesquisa (modo PROCURAR)
914:     *--------------------------------------------------------------------------
915:     PROCEDURE BtnSalvarClick()
916:         LOCAL loc_oPagina, loc_cGrupos, loc_cContas, loc_cGruContas
917:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
918:         loc_cGrupos = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
919:         loc_cContas = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)
920: 
921:         IF THIS.this_cModoAtual = "PROCURAR"
922:             IF !EMPTY(loc_cGrupos) AND EMPTY(loc_cContas)
923:                 MsgAviso("Aten" + CHR(231) + CHR(227) + "o ! Para pesquisar " + CHR(233) + ;
924:                          " necess" + CHR(225) + "rio escolher tamb" + CHR(233) + "m a Conta.", ;
925:                          "Aten" + CHR(231) + CHR(227) + "o")
926:                 loc_oPagina.txt_4c_Contas.SetFocus
927:                 RETURN
928:             ENDIF
929:             *-- Recarregar ocorrencias para o grupo+conta informado
930:             loc_cGruContas = PADR(loc_cGrupos, 10) + PADR(loc_cContas, 10)
931:             THIS.this_cGruContasAtual = loc_cGruContas
932:             THIS.CarregarPaginaDados(loc_cGruContas)
933:             *-- Habilitar grid para visualizacao (criado na Fase 6)
934:             IF PEMSTATUS(loc_oPagina, "grd_4c_Ocorrencias", 5)
935:                 loc_oPagina.grd_4c_Ocorrencias.Enabled = .T.
936:             ENDIF
937:             RETURN
938:         ENDIF
939: 
940:         IF INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
941:             IF EMPTY(loc_cGrupos)
942:                 MsgAviso("Obrigat" + CHR(243) + "rio Informar o Grupo", "Aten" + CHR(231) + CHR(227) + "o")
943:                 loc_oPagina.txt_4c_Grupo.SetFocus
944:                 RETURN
945:             ENDIF
946:             IF EMPTY(loc_cContas)
947:                 MsgAviso("Obrigat" + CHR(243) + "rio Informar a Conta", "Aten" + CHR(231) + CHR(227) + "o")
948:                 loc_oPagina.txt_4c_Contas.SetFocus
949:                 RETURN
950:             ENDIF
951: 
952:             IF THIS.this_oBusinessObject.SalvarOcorrencias(loc_cGrupos, loc_cContas, "cursor_4c_OcoLocal")
953:                 MsgInfo("Lan" + CHR(231) + "amentos salvos com sucesso!", "Sucesso")
954:                 THIS.this_cModoAtual = "LISTA"
955:                 THIS.AlternarPagina(1)
956:             ENDIF
957:         ENDIF
958:     ENDPROC
959: 
960:     *--------------------------------------------------------------------------
961:     * BtnCancelarClick - Cancela a operacao e volta para a lista (Page1)
962:     *--------------------------------------------------------------------------
963:     PROCEDURE BtnCancelarClick()
964:         THIS.this_cModoAtual      = "LISTA"
965:         THIS.this_cGrupoAtual     = ""
966:         THIS.this_cContaAtual     = ""
967:         THIS.this_cGruContasAtual = ""
968:         IF USED("cursor_4c_OcoLocal")
969:             ZAP IN cursor_4c_OcoLocal
970:         ENDIF
971:         THIS.AlternarPagina(1)
972:     ENDPROC
973: 
974:     *--------------------------------------------------------------------------
975:     * IniciarDescricoes - Carrega descricoes de Grupo (SigCdGcr) e Conta (SigCdCli)
976:     * Equivalente ao procedure inicdesc do legado
977:     *--------------------------------------------------------------------------
978:     PROCEDURE IniciarDescricoes()
979:         LOCAL loc_oPagina, loc_cGrupo, loc_cConta, loc_nRes, loc_cSQL
980:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
981: 
982:         IF NOT PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
983:             RETURN
984:         ENDIF
985: 
986:         loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
987:         loc_cConta = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)
988: 
989:         *-- Busca descricao do grupo em SigCdGcr (Codigos/Descrs com 'r')
990:         IF !EMPTY(loc_cGrupo)
991:             TRY
992:                 loc_cSQL = "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo)
993:                 IF USED("cursor_4c_TmpGrupo")
994:                     USE IN cursor_4c_TmpGrupo
995:                 ENDIF
996:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpGrupo")
997:                 IF loc_nRes >= 0 AND USED("cursor_4c_TmpGrupo") AND RECCOUNT("cursor_4c_TmpGrupo") > 0
998:                     SELECT cursor_4c_TmpGrupo
999:                     loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
1000:                 ELSE
1001:                     loc_oPagina.txt_4c_Desc_Gru.Value = ""
1002:                 ENDIF
1003:             CATCH TO loException
1004:                 MsgErro("Erro ao carregar descri" + CHR(231) + CHR(227) + "o do grupo: " + loException.Message, "Erro")
1005:             ENDTRY
1006:             IF USED("cursor_4c_TmpGrupo")
1007:                 USE IN cursor_4c_TmpGrupo
1008:             ENDIF
1009:         ELSE
1010:             loc_oPagina.txt_4c_Desc_Gru.Value = ""
1011:         ENDIF
1012: 
1013:         *-- Busca descricao da conta em SigCdCli (Iclis/Rclis)
1014:         IF !EMPTY(loc_cConta)
1015:             TRY
1016:                 loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta)
1017:                 IF USED("cursor_4c_TmpConta")
1018:                     USE IN cursor_4c_TmpConta

*-- Linhas 1037 a 1599:
1037: 
1038:     *--------------------------------------------------------------------------
1039:     * ValidarGrupoLostFocus - Valida/lookup do codigo de Grupo ao sair do campo
1040:     * Substitui fAcessoContab() do legado usando SQL + FormBuscaAuxiliar
1041:     *--------------------------------------------------------------------------
1042:     PROCEDURE ValidarGrupoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1043:         LOCAL loc_oPagina, loc_cGrupo, loc_cSQL, loc_nRes, loc_oBusca
1044:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1045:         loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1046: 
1047:         IF EMPTY(loc_cGrupo)
1048:             loc_oPagina.txt_4c_Desc_Gru.Value = ""
1049:             RETURN
1050:         ENDIF
1051: 
1052:         TRY
1053:             loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo)
1054:             IF USED("cursor_4c_BuscaGrupo")
1055:                 USE IN cursor_4c_BuscaGrupo
1056:             ENDIF
1057:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")
1058: 
1059:             IF loc_nRes >= 0 AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
1060:                 SELECT cursor_4c_BuscaGrupo
1061:                 loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
1062:                 loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
1063:             ELSE
1064:                 IF USED("cursor_4c_BuscaGrupo")
1065:                     USE IN cursor_4c_BuscaGrupo
1066:                 ENDIF
1067:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1068:                     "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cGrupo, ;
1069:                     "Grupo de Conta Corrente")
1070:                 IF VARTYPE(loc_oBusca) = "O"
1071:                     IF !loc_oBusca.this_lAchouRegistro
1072:                         loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1073:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1074:                         loc_oBusca.Show()
1075:                     ENDIF
1076:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
1077:                         SELECT cursor_4c_BuscaGrupo
1078:                         loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
1079:                         loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
1080:                     ELSE
1081:                         loc_oPagina.txt_4c_Grupo.Value    = ""
1082:                         loc_oPagina.txt_4c_Desc_Gru.Value = ""
1083:                     ENDIF
1084:                     loc_oBusca.Release()
1085:                 ENDIF
1086:             ENDIF
1087:         CATCH TO loException
1088:             MsgErro("Erro ao validar grupo: " + loException.Message, "Erro")
1089:         ENDTRY
1090: 
1091:         IF USED("cursor_4c_BuscaGrupo")
1092:             USE IN cursor_4c_BuscaGrupo
1093:         ENDIF
1094:     ENDPROC
1095: 
1096:     *--------------------------------------------------------------------------
1097:     * ValidarContaLostFocus - Valida/lookup do codigo de Conta ao sair do campo
1098:     * Substitui fAcessoContas() do legado usando SQL + FormBuscaAuxiliar
1099:     *--------------------------------------------------------------------------
1100:     PROCEDURE ValidarContaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1101:         LOCAL loc_oPagina, loc_cConta, loc_cSQL, loc_nRes, loc_oBusca
1102:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1103:         loc_cConta  = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)
1104: 
1105:         IF EMPTY(loc_cConta)
1106:             loc_oPagina.txt_4c_Desc_Con.Value = ""
1107:             RETURN
1108:         ENDIF
1109: 
1110:         TRY
1111:             loc_cSQL = "SELECT Iclis, Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta)
1112:             IF USED("cursor_4c_BuscaConta")
1113:                 USE IN cursor_4c_BuscaConta
1114:             ENDIF
1115:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
1116: 
1117:             IF loc_nRes >= 0 AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
1118:                 SELECT cursor_4c_BuscaConta
1119:                 loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
1120:                 loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
1121:             ELSE
1122:                 IF USED("cursor_4c_BuscaConta")
1123:                     USE IN cursor_4c_BuscaConta
1124:                 ENDIF
1125:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1126:                     "SigCdCli", "cursor_4c_BuscaConta", "Iclis", loc_cConta, ;
1127:                     "Conta Corrente")
1128:                 IF VARTYPE(loc_oBusca) = "O"
1129:                     IF !loc_oBusca.this_lAchouRegistro
1130:                         loc_oBusca.mAddColuna("Iclis",  "", "Conta")
1131:                         loc_oBusca.mAddColuna("Rclis",  "", "Nome")
1132:                         loc_oBusca.Show()
1133:                     ENDIF
1134:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
1135:                         SELECT cursor_4c_BuscaConta
1136:                         loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
1137:                         loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
1138:                     ELSE
1139:                         loc_oPagina.txt_4c_Contas.Value   = ""
1140:                         loc_oPagina.txt_4c_Desc_Con.Value = ""
1141:                     ENDIF
1142:                     loc_oBusca.Release()
1143:                 ENDIF
1144:             ENDIF
1145:         CATCH TO loException
1146:             MsgErro("Erro ao validar conta: " + loException.Message, "Erro")
1147:         ENDTRY
1148: 
1149:         IF USED("cursor_4c_BuscaConta")
1150:             USE IN cursor_4c_BuscaConta
1151:         ENDIF
1152:     ENDPROC
1153: 
1154:     *--------------------------------------------------------------------------
1155:     * HabilitarCampos - Habilita/desabilita campos e botoes de acordo com o modo
1156:     *--------------------------------------------------------------------------
1157:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1158:         LOCAL loc_oPagina, loc_lEditarIdentif, loc_lEditarOco
1159:         loc_oPagina        = THIS.pgf_4c_Paginas.Page2
1160:         loc_lEditarIdentif = par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INSERIR", "PROCURAR")
1161:         loc_lEditarOco     = par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
1162: 
1163:         IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1164:             loc_oPagina.txt_4c_Grupo.Enabled = loc_lEditarIdentif
1165:         ENDIF
1166:         IF PEMSTATUS(loc_oPagina, "txt_4c_Contas", 5)
1167:             loc_oPagina.txt_4c_Contas.Enabled = loc_lEditarIdentif
1168:         ENDIF
1169:         IF PEMSTATUS(loc_oPagina, "txt_4c_Desc_Gru", 5)
1170:             loc_oPagina.txt_4c_Desc_Gru.ReadOnly = .T.
1171:         ENDIF
1172:         IF PEMSTATUS(loc_oPagina, "txt_4c_Desc_Con", 5)
1173:             loc_oPagina.txt_4c_Desc_Con.ReadOnly = .T.
1174:         ENDIF
1175: 
1176:         *-- Grid de ocorrencias: editavel apenas em INSERIR/ALTERAR
1177:         IF PEMSTATUS(loc_oPagina, "grd_4c_Ocorrencias", 5)
1178:             IF loc_lEditarOco
1179:                 loc_oPagina.grd_4c_Ocorrencias.ReadOnly = .F.
1180:                 loc_oPagina.grd_4c_Ocorrencias.Enabled  = .T.
1181:             ELSE
1182:                 loc_oPagina.grd_4c_Ocorrencias.ReadOnly = .T.
1183:                 loc_oPagina.grd_4c_Ocorrencias.Enabled  = .F.
1184:             ENDIF
1185:         ENDIF
1186: 
1187:         *-- Botoes inserir/excluir de ocorrencias: visiveis apenas em INSERIR/ALTERAR
1188:         IF PEMSTATUS(loc_oPagina, "cmd_4c_InserirOco", 5)
1189:             loc_oPagina.cmd_4c_InserirOco.Visible = loc_lEditarOco
1190:         ENDIF
1191:         IF PEMSTATUS(loc_oPagina, "cmd_4c_ExcluirOco", 5)
1192:             loc_oPagina.cmd_4c_ExcluirOco.Visible = loc_lEditarOco
1193:         ENDIF
1194:     ENDPROC
1195: 
1196:     *--------------------------------------------------------------------------
1197:     * GradeAfterRowColChange - Valida ocorrencia (Cocos) ao mover na grade
1198:     * Lookup em SigCcCco; verifica duplicidade; preenche descs automaticamente
1199:     *--------------------------------------------------------------------------
1200:     PROCEDURE GradeAfterRowColChange
1201:         LPARAMETERS par_nColIndex
1202:         LOCAL loc_cCocos, loc_cDescs, loc_cSQL, loc_nRes
1203:         LOCAL loc_cCocosOk, loc_cDescsOk, loc_oBusca
1204:         LOCAL loc_nPonteiro, loc_lDuplicado
1205: 
1206:         *-- Processar lookup apenas quando o usuario editou Column1 (Cocos - campo editavel)
1207:         IF par_nColIndex != 1
1208:             RETURN
1209:         ENDIF
1210: 
1211:         IF !USED("cursor_4c_OcoLocal") OR EOF("cursor_4c_OcoLocal")
1212:             RETURN
1213:         ENDIF
1214: 
1215:         SELECT cursor_4c_OcoLocal
1216:         loc_cCocos = ALLTRIM(cursor_4c_OcoLocal.Cocos)
1217:         loc_cDescs = ALLTRIM(cursor_4c_OcoLocal.descs)
1218: 
1219:         *-- Cocos vazio: limpar descs e sair
1220:         IF EMPTY(loc_cCocos)
1221:             IF !EMPTY(loc_cDescs)
1222:                 REPLACE descs WITH ""
1223:             ENDIF
1224:             RETURN
1225:         ENDIF
1226: 
1227:         loc_cCocosOk = ""
1228:         loc_cDescsOk = ""
1229: 
1230:         TRY
1231:             loc_cSQL = "SELECT Cods, Descs FROM SigCcCco WHERE Cods = " + EscaparSQL(loc_cCocos)
1232:             IF USED("cursor_4c_BuscaCoco")
1233:                 USE IN cursor_4c_BuscaCoco
1234:             ENDIF
1235:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCoco")
1236: 
1237:             IF loc_nRes >= 0 AND USED("cursor_4c_BuscaCoco") AND RECCOUNT("cursor_4c_BuscaCoco") > 0
1238:                 SELECT cursor_4c_BuscaCoco
1239:                 loc_cCocosOk = ALLTRIM(Cods)
1240:                 loc_cDescsOk = ALLTRIM(Descs)
1241:             ELSE
1242:                 IF USED("cursor_4c_BuscaCoco")
1243:                     USE IN cursor_4c_BuscaCoco
1244:                 ENDIF
1245:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1246:                     "SigCcCco", "cursor_4c_BuscaCoco", "Cods", loc_cCocos, ;
1247:                     "Sele" + CHR(231) + CHR(227) + "o")
1248:                 IF VARTYPE(loc_oBusca) = "O"
1249:                     IF !loc_oBusca.this_lAchouRegistro
1250:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
1251:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1252:                         loc_oBusca.Show()
1253:                     ENDIF
1254:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCoco") AND RECCOUNT("cursor_4c_BuscaCoco") > 0
1255:                         SELECT cursor_4c_BuscaCoco
1256:                         loc_cCocosOk = ALLTRIM(Cods)
1257:                         loc_cDescsOk = ALLTRIM(Descs)
1258:                     ELSE
1259:                         loc_cCocosOk = ""
1260:                         loc_cDescsOk = ""
1261:                     ENDIF
1262:                     loc_oBusca.Release()
1263:                 ENDIF
1264:             ENDIF
1265: 
1266:             *-- Verificar duplicidade de cocos no cursor local
1267:             SELECT cursor_4c_OcoLocal
1268:             loc_nPonteiro  = RECNO()
1269:             loc_lDuplicado = .F.
1270: 
1271:             IF !EMPTY(loc_cCocosOk)
1272:                 SET ORDER TO Cocos
1273:                 IF SEEK(PADR(loc_cCocosOk, 2))
1274:                     IF RECNO() != loc_nPonteiro
1275:                         loc_lDuplicado = .T.
1276:                     ENDIF
1277:                 ENDIF
1278:                 SET ORDER TO
1279:                 GO loc_nPonteiro
1280:             ENDIF
1281: 
1282:             IF loc_lDuplicado
1283:                 MsgAviso("J" + CHR(225) + " existe um registro com esta ocorr" + CHR(234) + "ncia!", ;
1284:                          "Aten" + CHR(231) + CHR(227) + "o")
1285:                 REPLACE Cocos WITH ""
1286:                 REPLACE descs WITH ""
1287:             ELSE
1288:                 REPLACE Cocos WITH loc_cCocosOk
1289:                 REPLACE descs WITH loc_cDescsOk
1290:             ENDIF
1291: 
1292:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Ocorrencias", 5)
1293:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Ocorrencias.Refresh()
1294:             ENDIF
1295: 
1296:         CATCH TO loException
1297:             MsgErro("Erro ao validar ocorr" + CHR(234) + "ncia: " + loException.Message, "Erro")
1298:         ENDTRY
1299: 
1300:         IF USED("cursor_4c_BuscaCoco")
1301:             USE IN cursor_4c_BuscaCoco
1302:         ENDIF
1303:     ENDPROC
1304: 
1305:     *--------------------------------------------------------------------------
1306:     * BtnInserirOcoClick - Insere linha em branco no cursor de ocorrencias
1307:     *--------------------------------------------------------------------------
1308:     PROCEDURE BtnInserirOcoClick()
1309:         LOCAL loc_oPagina, loc_cGrupos, loc_cContas
1310:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1311: 
1312:         IF NOT INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
1313:             RETURN
1314:         ENDIF
1315: 
1316:         IF NOT PEMSTATUS(loc_oPagina, "grd_4c_Ocorrencias", 5)
1317:             RETURN
1318:         ENDIF
1319: 
1320:         loc_cGrupos = ""
1321:         loc_cContas = ""
1322:         IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1323:             loc_cGrupos = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1324:             loc_cContas = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)
1325:         ENDIF
1326: 
1327:         TRY
1328:             SELECT cursor_4c_OcoLocal
1329:             APPEND BLANK
1330:             REPLACE Grupos WITH loc_cGrupos
1331:             REPLACE Contas WITH loc_cContas
1332:             loc_oPagina.grd_4c_Ocorrencias.Refresh()
1333:             loc_oPagina.grd_4c_Ocorrencias.Column1.SetFocus
1334:         CATCH TO loException
1335:             MsgErro("Erro ao inserir ocorr" + CHR(234) + "ncia: " + loException.Message, "Erro")
1336:         ENDTRY
1337:     ENDPROC
1338: 
1339:     *--------------------------------------------------------------------------
1340:     * BtnExcluirOcoClick - Exclui linha corrente do cursor de ocorrencias
1341:     * Mantem ao menos uma linha em branco para nova entrada (padrao legado)
1342:     *--------------------------------------------------------------------------
1343:     PROCEDURE BtnExcluirOcoClick()
1344:         LOCAL loc_oPagina, loc_cGrupos, loc_cContas
1345:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1346: 
1347:         IF NOT INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
1348:             RETURN
1349:         ENDIF
1350: 
1351:         IF NOT PEMSTATUS(loc_oPagina, "grd_4c_Ocorrencias", 5)
1352:             RETURN
1353:         ENDIF
1354: 
1355:         IF NOT USED("cursor_4c_OcoLocal") OR RECCOUNT("cursor_4c_OcoLocal") = 0
1356:             RETURN
1357:         ENDIF
1358: 
1359:         loc_cGrupos = ""
1360:         loc_cContas = ""
1361:         IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1362:             loc_cGrupos = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1363:             loc_cContas = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)
1364:         ENDIF
1365: 
1366:         TRY
1367:             SELECT cursor_4c_OcoLocal
1368:             DELETE
1369:             GO BOTTOM
1370:             IF EOF()
1371:                 APPEND BLANK
1372:                 REPLACE Grupos WITH loc_cGrupos
1373:                 REPLACE Contas WITH loc_cContas
1374:             ENDIF
1375:             loc_oPagina.grd_4c_Ocorrencias.Refresh()
1376:             loc_oPagina.grd_4c_Ocorrencias.Column1.SetFocus
1377:         CATCH TO loException
1378:             MsgErro("Erro ao excluir ocorr" + CHR(234) + "ncia: " + loException.Message, "Erro")
1379:         ENDTRY
1380:     ENDPROC
1381: 
1382:     *--------------------------------------------------------------------------
1383:     * GrupoKeyPress - Handler KeyPress de txt_4c_Grupo: F4 abre lookup
1384:     *--------------------------------------------------------------------------
1385:     PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1386:         IF par_nKeyCode = 28  && F4
1387:             THIS.AbrirLookupGrupo()
1388:         ENDIF
1389:     ENDPROC
1390: 
1391:     *--------------------------------------------------------------------------
1392:     * GrupoDblClick - Handler DblClick de txt_4c_Grupo
1393:     *--------------------------------------------------------------------------
1394:     PROCEDURE GrupoDblClick()
1395:         THIS.AbrirLookupGrupo()
1396:     ENDPROC
1397: 
1398:     *--------------------------------------------------------------------------
1399:     * AbrirLookupGrupo - Abre FormBuscaAuxiliar para Grupo (SigCdGcr)
1400:     *--------------------------------------------------------------------------
1401:     PROCEDURE AbrirLookupGrupo()
1402:         LOCAL loc_oPagina
1403:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1404:         IF NOT PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1405:             RETURN
1406:         ENDIF
1407:         IF NOT loc_oPagina.txt_4c_Grupo.Enabled
1408:             RETURN
1409:         ENDIF
1410: 
1411:         LOCAL loc_oBusca
1412:         TRY
1413:             IF USED("cursor_4c_BuscaGrupo")
1414:                 USE IN cursor_4c_BuscaGrupo
1415:             ENDIF
1416:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1417:                 "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", "", ;
1418:                 "Grupo de Conta Corrente")
1419: 
1420:             IF VARTYPE(loc_oBusca) = "O"
1421:                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1422:                 loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1423:                 loc_oBusca.Show()
1424:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
1425:                     SELECT cursor_4c_BuscaGrupo
1426:                     loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
1427:                     loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
1428:                 ENDIF
1429:                 loc_oBusca.Release()
1430:             ENDIF
1431:         CATCH TO loException
1432:             MsgErro("Erro ao abrir lookup de Grupo: " + loException.Message, "Erro")
1433:         ENDTRY
1434: 
1435:         IF USED("cursor_4c_BuscaGrupo")
1436:             USE IN cursor_4c_BuscaGrupo
1437:         ENDIF
1438:     ENDPROC
1439: 
1440:     *--------------------------------------------------------------------------
1441:     * ContaKeyPress - Handler KeyPress de txt_4c_Contas: F4 abre lookup
1442:     *--------------------------------------------------------------------------
1443:     PROCEDURE ContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1444:         IF par_nKeyCode = 28  && F4
1445:             THIS.AbrirLookupConta()
1446:         ENDIF
1447:     ENDPROC
1448: 
1449:     *--------------------------------------------------------------------------
1450:     * ContaDblClick - Handler DblClick de txt_4c_Contas
1451:     *--------------------------------------------------------------------------
1452:     PROCEDURE ContaDblClick()
1453:         THIS.AbrirLookupConta()
1454:     ENDPROC
1455: 
1456:     *--------------------------------------------------------------------------
1457:     * AbrirLookupConta - Abre FormBuscaAuxiliar para Conta (SigCdCli)
1458:     *--------------------------------------------------------------------------
1459:     PROCEDURE AbrirLookupConta()
1460:         LOCAL loc_oPagina
1461:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1462:         IF NOT PEMSTATUS(loc_oPagina, "txt_4c_Contas", 5)
1463:             RETURN
1464:         ENDIF
1465:         IF NOT loc_oPagina.txt_4c_Contas.Enabled
1466:             RETURN
1467:         ENDIF
1468: 
1469:         LOCAL loc_oBusca
1470:         TRY
1471:             IF USED("cursor_4c_BuscaConta")
1472:                 USE IN cursor_4c_BuscaConta
1473:             ENDIF
1474:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1475:                 "SigCdCli", "cursor_4c_BuscaConta", "Iclis", "", ;
1476:                 "Conta Corrente")
1477: 
1478:             IF VARTYPE(loc_oBusca) = "O"
1479:                 loc_oBusca.mAddColuna("Iclis",  "", "Conta")
1480:                 loc_oBusca.mAddColuna("Rclis",  "", "Nome")
1481:                 loc_oBusca.Show()
1482:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
1483:                     SELECT cursor_4c_BuscaConta
1484:                     loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
1485:                     loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
1486:                 ENDIF
1487:                 loc_oBusca.Release()
1488:             ENDIF
1489:         CATCH TO loException
1490:             MsgErro("Erro ao abrir lookup de Conta: " + loException.Message, "Erro")
1491:         ENDTRY
1492: 
1493:         IF USED("cursor_4c_BuscaConta")
1494:             USE IN cursor_4c_BuscaConta
1495:         ENDIF
1496:     ENDPROC
1497: 
1498:     *--------------------------------------------------------------------------
1499:     * TornarControlesVisiveis - Percorre controles recursivamente definindo Visible=.T.
1500:     *--------------------------------------------------------------------------
1501:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1502:         LOCAL loc_nI, loc_oObjeto, loc_nP
1503: 
1504:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1505:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1506: 
1507:             IF VARTYPE(loc_oObjeto) = "O"
1508:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1509:                     loc_oObjeto.Visible = .T.
1510:                 ENDIF
1511: 
1512:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1513:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1514:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1515:                     ENDFOR
1516:                 ENDIF
1517: 
1518:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1519:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1520:                 ENDIF
1521:             ENDIF
1522:         ENDFOR
1523:     ENDPROC
1524: 
1525:     *--------------------------------------------------------------------------
1526:     * FormParaBO - Transfere valores dos campos da Page2 para as propriedades do BO
1527:     *--------------------------------------------------------------------------
1528:     PROTECTED PROCEDURE FormParaBO()
1529:         LOCAL loc_oPagina
1530:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1531: 
1532:         IF NOT PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1533:             RETURN
1534:         ENDIF
1535: 
1536:         THIS.this_oBusinessObject.this_cGrupos    = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1537:         THIS.this_oBusinessObject.this_cContas    = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)
1538:         THIS.this_oBusinessObject.this_cGruContas = PADR(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value), 10) + ;
1539:                                                     PADR(ALLTRIM(loc_oPagina.txt_4c_Contas.Value), 10)
1540:     ENDPROC
1541: 
1542:     *--------------------------------------------------------------------------
1543:     * BOParaForm - Transfere valores do BO para os campos da Page2
1544:     *--------------------------------------------------------------------------
1545:     PROTECTED PROCEDURE BOParaForm()
1546:         LOCAL loc_oPagina
1547:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1548: 
1549:         IF NOT PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1550:             RETURN
1551:         ENDIF
1552: 
1553:         loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
1554:         loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cContas)
1555:         loc_oPagina.txt_4c_Desc_Gru.Value = ""
1556:         loc_oPagina.txt_4c_Desc_Con.Value = ""
1557:         THIS.IniciarDescricoes()
1558:     ENDPROC
1559: 
1560:     *--------------------------------------------------------------------------
1561:     * AjustarBotoesPorModo - Habilita/desabilita botoes de Page1 conforme dados
1562:     *--------------------------------------------------------------------------
1563:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1564:         LOCAL loc_oPagina, loc_lTemRegistro
1565:         loc_oPagina      = THIS.pgf_4c_Paginas.Page1
1566:         loc_lTemRegistro = USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1567: 
1568:         IF NOT PEMSTATUS(loc_oPagina, "cnt_4c_Botoes", 5)
1569:             RETURN
1570:         ENDIF
1571: 
1572:         IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
1573:             loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir.Enabled = .T.
1574:         ENDIF
1575:         IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
1576:             loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
1577:         ENDIF
1578:         IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
1579:             loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar.Enabled = loc_lTemRegistro
1580:         ENDIF
1581:         IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
1582:             loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir.Enabled = loc_lTemRegistro
1583:         ENDIF
1584:         IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Buscar", 5)
1585:             loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar.Enabled = .T.
1586:         ENDIF
1587:     ENDPROC
1588: 
1589:     *--------------------------------------------------------------------------
1590:     * Destroy - Libera o Business Object e chama destruicao da classe pai
1591:     *--------------------------------------------------------------------------
1592:     PROCEDURE Destroy()
1593:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1594:             THIS.this_oBusinessObject = .NULL.
1595:         ENDIF
1596:         DODEFAULT()
1597:     ENDPROC
1598: 
1599: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRLNCBO.prg):
*==============================================================================
* SIGPRLNCBO.prg - Business Object para Lancamentos de Conta Corrente
* Tabela: SigClLan (grupos, contas, cocos, cidchaves, grucontas)
* Auxiliar: SIGCCCCO (cods, descs) - descricoes de ocorrencias
*==============================================================================
DEFINE CLASS SIGPRLNCBO AS BusinessBase

    *-- Campos de SigClLan
    this_cGrupos    = ""    && char(10) - Grupo da conta corrente
    this_cContas    = ""    && char(10) - Conta corrente
    this_cCocos     = ""    && char(2)  - Codigo da ocorrencia
    this_cCidChaves = ""    && char(20) - Chave primaria (gerada por fUniqueIds)
    this_cGruContas = ""    && char(20) - Concatenacao grupos+contas (indice)

    *-- Campo auxiliar (descricao da ocorrencia, vem de SIGCCCCO)
    this_cDescs     = ""    && char(30) - Descricao da ocorrencia (SIGCCCCO.descs)

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO configurando tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigClLan"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor existente
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cGrupos    = TratarNulo(grupos,    "C")
            THIS.this_cContas    = TratarNulo(contas,    "C")
            THIS.this_cCocos     = TratarNulo(cocos,     "C")
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_cGruContas = TratarNulo(grucontas, "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista todos os registros agrupados de SigClLan
    * Retorna cursor cursor_4c_Dados com grupos, contas e uma ocorrencia por linha
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT DISTINCT a.grupos, a.contas, a.grucontas" + ;
                       " FROM SigClLan a" + ;
                       " ORDER BY a.grupos, a.contas"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar lan" + CHR(231) + "amentos: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SIGPRLNCBO.Buscar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarOcorrencias - Busca ocorrencias para um grupo+conta especifico
    * par_cGruContas = grupos(10) + contas(10) concatenados
    * Retorna cursor cursor_4c_Ocorrencias
    *--------------------------------------------------------------------------
    PROCEDURE BuscarOcorrencias(par_cGruContas)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Ocorrencias")
                USE IN cursor_4c_Ocorrencias
            ENDIF

            loc_cSQL = "SELECT a.grupos, a.contas, a.cocos, a.cidchaves," + ;
                       " a.grucontas, b.descs" + ;
                       " FROM SigClLan a LEFT JOIN SIGCCCCO b ON b.cods = a.cocos" + ;
                       " WHERE a.grucontas = " + EscaparSQL(par_cGruContas) + ;
                       " ORDER BY a.cocos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ocorrencias")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar ocorr" + CHR(234) + "ncias: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SIGPRLNCBO.BuscarOcorrencias: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarDescricaoOcorrencia - Busca descricao de uma ocorrencia pelo codigo
    * Retorna string com descricao ou vazio se nao encontrado
    *--------------------------------------------------------------------------
    FUNCTION BuscarDescricaoOcorrencia(par_cCodOco)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao
        loc_cDescricao = ""

        TRY
            IF USED("cursor_4c_DescOco")
                USE IN cursor_4c_DescOco
            ENDIF

            loc_cSQL = "SELECT cods, descs FROM SIGCCCCO" + ;
                       " WHERE cods = " + EscaparSQL(par_cCodOco)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescOco")

            IF loc_nResultado >= 0 AND USED("cursor_4c_DescOco") AND RECCOUNT("cursor_4c_DescOco") > 0
                SELECT cursor_4c_DescOco
                loc_cDescricao = ALLTRIM(descs)
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarDescricaoOcorrencia: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_DescOco")
            USE IN cursor_4c_DescOco
        ENDIF

        RETURN loc_cDescricao
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo cidchaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.grupos, a.contas, a.cocos, a.cidchaves, a.grucontas" + ;
                       " FROM SigClLan a" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(par_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND USED("cursor_4c_Carrega") AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                IF loc_lSucesso
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SIGPRLNCBO.CarregarPorCodigo: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigClLan (PROTECTED - chamado por Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidChaves  = ALLTRIM(fUniqueIds())
            THIS.this_cGruContas  = PADR(ALLTRIM(THIS.this_cGrupos), 10) + ;
                                    PADR(ALLTRIM(THIS.this_cContas), 10)

            loc_cSQL = "INSERT INTO SigClLan (grupos, contas, cocos, cidchaves, grucontas)" + ;
                       " VALUES (" + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cGrupos), 10))    + ", " + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cContas), 10))    + ", " + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cCocos), 2))      + ", " + ;
                       EscaparSQL(THIS.this_cCidChaves)                    + ", " + ;
                       EscaparSQL(THIS.this_cGruContas)                    + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir lan" + CHR(231) + "amento: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SIGPRLNCBO.Inserir: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigClLan (PROTECTED - chamado por Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cGruContas = PADR(ALLTRIM(THIS.this_cGrupos), 10) + ;
                                   PADR(ALLTRIM(THIS.this_cContas), 10)

            loc_cSQL = "UPDATE SigClLan SET" + ;
                       " grupos    = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cGrupos), 10)) + ;
                       ", contas   = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cContas), 10)) + ;
                       ", cocos    = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCocos), 2))   + ;
                       ", grucontas= " + EscaparSQL(THIS.this_cGruContas)                 + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar lan" + CHR(231) + "amento: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SIGPRLNCBO.Atualizar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigClLan (PROTECTED - chamado por Excluir)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigClLan WHERE cidchaves = " + ;
                       EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir lan" + CHR(231) + "amento: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SIGPRLNCBO.ExecutarExclusao: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirPorGruContas - Remove TODOS os lancamentos de um grupo+conta
    * Usado ao salvar conjunto de ocorrencias (limpa e re-insere)
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirPorGruContas(par_cGruContas)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigClLan WHERE grucontas = " + ;
                       EscaparSQL(par_cGruContas)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir lan" + CHR(231) + "amentos: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SIGPRLNCBO.ExcluirPorGruContas: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarOcorrencias - Salva lista de ocorrencias do cursor local para SQL Server
    * par_cGrupos    = codigo do grupo (char 10)
    * par_cContas    = codigo da conta (char 10)
    * par_cCursorOco = nome do cursor VFP com a lista de ocorrencias (campo cocos)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarOcorrencias(par_cGrupos, par_cContas, par_cCursorOco)
        LOCAL loc_cGruContas, loc_lSucesso, loc_cCocos, loc_lAbortar
        LOCAL loc_cSQLIns, loc_nResIns
        loc_lSucesso = .F.
        loc_lAbortar = .F.

        TRY
            loc_cGruContas = PADR(ALLTRIM(par_cGrupos), 10) + PADR(ALLTRIM(par_cContas), 10)

            IF !THIS.ExcluirPorGruContas(loc_cGruContas)
                loc_lAbortar = .T.
            ENDIF

            IF !loc_lAbortar
                IF !USED(par_cCursorOco) OR RECCOUNT(par_cCursorOco) = 0
                    loc_lSucesso = .T.
                    loc_lAbortar = .T.
                ENDIF
            ENDIF

            IF !loc_lAbortar
                SELECT (par_cCursorOco)
                GO TOP

                DO WHILE !EOF() AND !loc_lAbortar
                    SELECT (par_cCursorOco)
                    loc_cCocos = ALLTRIM(cocos)

                    IF !EMPTY(loc_cCocos)
                        THIS.this_cGrupos    = par_cGrupos
                        THIS.this_cContas    = par_cContas
                        THIS.this_cCocos     = loc_cCocos
                        THIS.this_cGruContas = loc_cGruContas
                        THIS.this_cCidChaves = ALLTRIM(fUniqueIds())

                        loc_cSQLIns = "INSERT INTO SigClLan (grupos, contas, cocos, cidchaves, grucontas)" + ;
                                      " VALUES (" + ;
                                      EscaparSQL(PADR(ALLTRIM(THIS.this_cGrupos), 10))    + ", " + ;
                                      EscaparSQL(PADR(ALLTRIM(THIS.this_cContas), 10))    + ", " + ;
                                      EscaparSQL(PADR(ALLTRIM(THIS.this_cCocos), 2))      + ", " + ;
                                      EscaparSQL(THIS.this_cCidChaves)                    + ", " + ;
                                      EscaparSQL(THIS.this_cGruContas)                    + ;
                                      ")"

                        loc_nResIns = SQLEXEC(gnConnHandle, loc_cSQLIns)

                        IF loc_nResIns < 0
                            MsgErro("Erro ao inserir ocorr" + CHR(234) + "ncia '" + loc_cCocos + "': " + CapturarErroSQL(), "Erro SQL")
                            loc_lAbortar = .T.
                        ENDIF
                    ENDIF

                    IF !loc_lAbortar
                        SELECT (par_cCursorOco)
                        SKIP
                    ENDIF
                ENDDO

                IF !loc_lAbortar
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SIGPRLNCBO.SalvarOcorrencias: " + loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

