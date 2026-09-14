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

### FORM (C:\4c\projeto\app\forms\cadastros\FormMtp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1518 linhas total):

*-- Linhas 26 a 150:
26:     *===========================================================================
27:     * Init - Inicializa o formulario
28:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
29:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
30:     *===========================================================================
31:     PROCEDURE Init()
32:         RETURN DODEFAULT()
33:     ENDPROC
34: 
35:     *===========================================================================
36:     * InicializarForm - Configura estrutura completa do formulario
37:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
38:     *===========================================================================
39:     PROTECTED PROCEDURE InicializarForm()
40:         LOCAL loc_lSucesso
41:         loc_lSucesso = .F.
42: 
43:         TRY
44:             THIS.Caption = "Modelos de Trabalho de Produ" + CHR(231) + CHR(227) + "o"
45: 
46:             THIS.this_oBusinessObject = CREATEOBJECT("MtpBO")
47: 
48:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
49:                 MostrarErro("Erro ao criar MtpBO" + CHR(13) + ;
50:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
51:                     "FormMtp.InicializarForm")
52:             ELSE
53:                 THIS.ConfigurarPageFrame()
54:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
55:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
56:                 THIS.pgf_4c_Paginas.Visible   = .T.
57:                 THIS.pgf_4c_Paginas.ActivePage = 1
58:                 THIS.this_cModoAtual           = "LISTA"
59: 
60:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
61:                     THIS.CarregarLista()
62:                 ENDIF
63: 
64:                 loc_lSucesso = .T.
65:             ENDIF
66: 
67:         CATCH TO loException
68:             MostrarErro("Erro ao inicializar FormMtp:" + CHR(13) + ;
69:                 loException.Message + CHR(13) + ;
70:                 "Linha: " + TRANSFORM(loException.LineNo), ;
71:                 "FormMtp.InicializarForm")
72:         ENDTRY
73: 
74:         RETURN loc_lSucesso
75:     ENDPROC
76: 
77:     *===========================================================================
78:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
79:     * Top=-29 para esconder abas; controles compensam +29 no Top
80:     *===========================================================================
81:     PROTECTED PROCEDURE ConfigurarPageFrame()
82:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
83: 
84:         WITH THIS.pgf_4c_Paginas
85:             .PageCount = 2
86:             .Top       = -29
87:             .Left      = 0
88:             .Width     = THIS.Width
89:             .Height    = THIS.Height + 29
90:             .Tabs      = .F.
91:             .Visible   = .T.
92: 
93:             .Page1.Caption   = "Lista"
94:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
95:             .Page1.BackColor = RGB(255, 255, 255)
96: 
97:             .Page2.Caption   = "Dados"
98:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
99:             .Page2.BackColor = RGB(255, 255, 255)
100:         ENDWITH
101: 
102:         THIS.ConfigurarPaginaLista()
103:         THIS.ConfigurarPaginaDados()
104:     ENDPROC
105: 
106:     *===========================================================================
107:     * ConfigurarPaginaLista - Configura Page1: cabecalho, 5 botoes CRUD,
108:     * botao Encerrar e grid de listagem com 3 colunas (Tipos/Descs/Limites)
109:     *===========================================================================
110:     PROTECTED PROCEDURE ConfigurarPaginaLista()
111:         LOCAL loc_oPagina, loc_oGrid
112:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
113: 
114:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
115:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
116: 
117:         *-- Container Cabecalho (cntSombra no legado)
118:         *-- Original Top=1; com compensacao +29 para PageFrame.Top=-29: Top=31
119:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
120:         WITH loc_oPagina.cnt_4c_Cabecalho
121:             .Top         = 31
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
135:             .Width     = 769
136:             .Height    = 40
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

*-- Linhas 195 a 376:
195:             .AutoSize        = .F.
196:             .Visible         = .T.
197:         ENDWITH
198:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
199: 
200:         *-- Botao Visualizar (Consultar no legado: Left=81, Top=5)
201:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
202:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
203:             .Caption         = "Visualizar"
204:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
205:             .PicturePosition = 13
206:             .Top             = 5
207:             .Left            = 80
208:             .Width           = 75
209:             .Height          = 75
210:             .FontName        = "Tahoma"
211:             .FontBold        = .T.
212:             .FontItalic      = .T.
213:             .FontSize        = 8
214:             .ForeColor       = RGB(90, 90, 90)
215:             .BackColor       = RGB(255, 255, 255)
216:             .Themes          = .F.
217:             .SpecialEffect   = 0
218:             .MousePointer    = 15
219:             .WordWrap        = .T.
220:             .AutoSize        = .F.
221:             .Visible         = .T.
222:         ENDWITH
223:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
224: 
225:         *-- Botao Alterar (Alterar no legado: Left=157, Top=5)
226:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
227:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
228:             .Caption         = "Alterar"
229:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
230:             .PicturePosition = 13
231:             .Top             = 5
232:             .Left            = 155
233:             .Width           = 75
234:             .Height          = 75
235:             .FontName        = "Tahoma"
236:             .FontBold        = .T.
237:             .FontItalic      = .T.
238:             .FontSize        = 8
239:             .ForeColor       = RGB(90, 90, 90)
240:             .BackColor       = RGB(255, 255, 255)
241:             .Themes          = .F.
242:             .SpecialEffect   = 0
243:             .MousePointer    = 15
244:             .WordWrap        = .T.
245:             .AutoSize        = .F.
246:             .Visible         = .T.
247:         ENDWITH
248:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
249: 
250:         *-- Botao Excluir (Excluir no legado: Left=233, Top=5)
251:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
252:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
253:             .Caption         = "Excluir"
254:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
255:             .PicturePosition = 13
256:             .Top             = 5
257:             .Left            = 230
258:             .Width           = 75
259:             .Height          = 75
260:             .FontName        = "Tahoma"
261:             .FontBold        = .T.
262:             .FontItalic      = .T.
263:             .FontSize        = 8
264:             .ForeColor       = RGB(90, 90, 90)
265:             .BackColor       = RGB(255, 255, 255)
266:             .Themes          = .F.
267:             .SpecialEffect   = 0
268:             .MousePointer    = 15
269:             .WordWrap        = .T.
270:             .AutoSize        = .F.
271:             .Visible         = .T.
272:         ENDWITH
273:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
274: 
275:         *-- Botao Buscar (Procurar no legado: Left=309, Top=5)
276:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
277:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
278:             .Caption         = "Buscar"
279:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
280:             .PicturePosition = 13
281:             .Top             = 5
282:             .Left            = 305
283:             .Width           = 75
284:             .Height          = 75
285:             .FontName        = "Tahoma"
286:             .FontBold        = .T.
287:             .FontItalic      = .T.
288:             .FontSize        = 8
289:             .ForeColor       = RGB(90, 90, 90)
290:             .BackColor       = RGB(255, 255, 255)
291:             .Themes          = .F.
292:             .SpecialEffect   = 0
293:             .MousePointer    = 15
294:             .WordWrap        = .T.
295:             .AutoSize        = .F.
296:             .Visible         = .T.
297:         ENDWITH
298:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
299: 
300:         *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10, prevalece sobre legado)
301:         *-- Legado: Grupo_Saida.Left=719, Top=-1. Canonico: Left=917, Top=29, Width=90
302:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
303:         WITH loc_oPagina.cnt_4c_Saida
304:             .Top         = 29
305:             .Left        = 917
306:             .Width       = 90
307:             .Height      = 85
308:             .BackStyle   = 0
309:             .BorderWidth = 0
310:             .Visible     = .T.
311:         ENDWITH
312: 
313:         *-- Botao Encerrar (Sair no legado: Left=5, Top=5 dentro de Grupo_Saida)
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
338:         *-- Grid de lista (Grade no legado: FontName=Tahoma, FontSize=8, ForeColor=90,90,90)
339:         *-- Colunas originais: Tipos (Codigo), descs (Descricao), limites (Prod. Minima)
340:         *-- Top=88+29=117 (compensacao PageFrame), Width=890 (nao sobrepoe cnt_4c_Saida)
341:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
342:         loc_oGrid              = loc_oPagina.grd_4c_Lista
343:         loc_oGrid.Top          = 117
344:         loc_oGrid.Left         = 26
345:         loc_oGrid.Width        = 890
346:         loc_oGrid.Height       = 498
347:         loc_oGrid.ColumnCount  = 3
348:         loc_oGrid.RecordSource = ""
349:         loc_oGrid.FontName     = "Tahoma"
350:         loc_oGrid.FontSize     = 8
351:         loc_oGrid.ForeColor    = RGB(90, 90, 90)
352:         loc_oGrid.BackColor    = RGB(255, 255, 255)
353:         loc_oGrid.RowHeight    = 16
354:         loc_oGrid.GridLines    = 3
355:         loc_oGrid.GridLineColor      = RGB(238, 238, 238)
356:         loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
357:         loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
358:         loc_oGrid.HighlightStyle     = 2
359:         loc_oGrid.DeleteMark   = .F.
360:         loc_oGrid.RecordMark   = .F.
361:         loc_oGrid.ScrollBars   = 2
362:         loc_oGrid.Visible      = .T.
363: 
364:         WITH loc_oGrid.Column1
365:             .Width     = 80
366:             .Alignment = 0
367:         ENDWITH
368:         WITH loc_oGrid.Column1.Header1
369:             .Caption  = "C" + CHR(243) + "digo"
370:             .FontName = "Tahoma"
371:             .FontSize = 8
372:         ENDWITH
373: 
374:         WITH loc_oGrid.Column2
375:             .Width     = 440
376:             .Alignment = 0

*-- Linhas 391 a 509:
391:             .FontSize = 8
392:         ENDWITH
393: 
394:         THIS.TornarControlesVisiveis(loc_oPagina)
395:     ENDPROC
396: 
397:     *===========================================================================
398:     * ConfigurarPaginaDados - Configura Page2 com todos os campos do formulario
399:     * Campos: Tipos, Grupos, Descs, Limites, Fmaxs, Valors, Moedas+DescMoe, Ganhos
400:     * Tops originais do legado compensados em +29 (PageFrame.Top=-29)
401:     *===========================================================================
402:     PROTECTED PROCEDURE ConfigurarPaginaDados()
403:         LOCAL loc_oPagina
404:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
405: 
406:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
407:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
408: 
409:         *-- Container Salva/Cancelar (Grupo_Salva no legado: Left=842, Top=4+29=33)
410:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
411:         WITH loc_oPagina.cnt_4c_Salva
412:             .Top         = 33
413:             .Left        = 842
414:             .Width       = 160
415:             .Height      = 85
416:             .BackStyle   = 0
417:             .BorderWidth = 0
418:             .Visible     = .T.
419:         ENDWITH
420: 
421:         *-- Botao Confirmar (Salva.Left=5, Top=5 no legado)
422:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
423:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
424:             .Caption         = "Confirmar"
425:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
426:             .PicturePosition = 13
427:             .Top             = 5
428:             .Left            = 5
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
444:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
445: 
446:         *-- Botao Cancelar (Cancelar.Left=81, Top=5 no legado)
447:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
448:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
449:             .Caption         = "Encerrar"
450:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
451:             .PicturePosition = 13
452:             .Top             = 5
453:             .Left            = 80
454:             .Width           = 75
455:             .Height          = 75
456:             .FontName        = "Tahoma"
457:             .FontBold        = .T.
458:             .FontItalic      = .T.
459:             .FontSize        = 8
460:             .ForeColor       = RGB(90, 90, 90)
461:             .BackColor       = RGB(255, 255, 255)
462:             .Themes          = .F.
463:             .SpecialEffect   = 0
464:             .MousePointer    = 15
465:             .WordWrap        = .T.
466:             .AutoSize        = .F.
467:             .Visible         = .T.
468:         ENDWITH
469:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
470: 
471:         *-- === LINHA 1: Codigo (Say1.Top=147->176 / Get_tipos.Top=144->173) ===
472:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
473:         WITH loc_oPagina.lbl_4c_Codigo
474:             .Caption   = "C" + CHR(243) + "digo : "
475:             .Top       = 176
476:             .Left      = 250
477:             .Height    = 17
478:             .Width     = 49
479:             .FontName  = "Tahoma"
480:             .FontSize  = 8
481:             .FontBold  = .F.
482:             .ForeColor = RGB(90, 90, 90)
483:             .BackStyle = 0
484:             .Alignment = 1
485:             .AutoSize  = .F.
486:             .Visible   = .T.
487:         ENDWITH
488: 
489:         loc_oPagina.AddObject("txt_4c_Tipos", "TextBox")
490:         WITH loc_oPagina.txt_4c_Tipos
491:             .Value     = ""
492:             .Top       = 173
493:             .Left      = 299
494:             .Width     = 24
495:             .Height    = 20
496:             .FontName  = "Tahoma"
497:             .FontSize  = 8
498:             .BackColor = RGB(255, 255, 255)
499:             .ForeColor = RGB(90, 90, 90)
500:             .Alignment = 0
501:             .MaxLength = 5
502:             .TabIndex  = 1
503:             .Visible   = .T.
504:         ENDWITH
505: 
506:         *-- === LINHA 2: Grupo (Say8.Top=174->203 / Get_grupo.Top=171->200) ===
507:         loc_oPagina.AddObject("lbl_4c_Grupo", "Label")
508:         WITH loc_oPagina.lbl_4c_Grupo
509:             .Caption   = "Grupo : "

*-- Linhas 537 a 582:
537:             .TabIndex  = 2
538:             .Visible   = .T.
539:         ENDWITH
540:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupo")
541:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress",  THIS, "GrupoKeyPress")
542:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "DblClick",  THIS, "GrupoDblClick")
543: 
544:         *-- === LINHA 3: Descricao (Say2.Top=202->231 / Get_Descs.Top=199->228) ===
545:         loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
546:         WITH loc_oPagina.lbl_4c_Descricao
547:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
548:             .Top       = 231
549:             .Left      = 237
550:             .Height    = 17
551:             .Width     = 62
552:             .FontName  = "Tahoma"
553:             .FontSize  = 8
554:             .FontBold  = .F.
555:             .ForeColor = RGB(90, 90, 90)
556:             .BackStyle = 0
557:             .Alignment = 1
558:             .AutoSize  = .F.
559:             .Visible   = .T.
560:         ENDWITH
561: 
562:         loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
563:         WITH loc_oPagina.txt_4c_Descricao
564:             .Value     = ""
565:             .Top       = 228
566:             .Left      = 299
567:             .Width     = 80
568:             .Height    = 20
569:             .FontName  = "Tahoma"
570:             .FontSize  = 8
571:             .BackColor = RGB(255, 255, 255)
572:             .ForeColor = RGB(90, 90, 90)
573:             .Alignment = 0
574:             .TabIndex  = 3
575:             .Visible   = .T.
576:         ENDWITH
577: 
578:         *-- === LINHA 4: Producao Minima (Say3.Top=229->258 / Get_limites.Top=226->255) ===
579:         loc_oPagina.AddObject("lbl_4c_ProdMinima", "Label")
580:         WITH loc_oPagina.lbl_4c_ProdMinima
581:             .Caption   = "Produ" + CHR(231) + CHR(227) + "o M" + CHR(237) + "nima : "
582:             .Top       = 258

*-- Linhas 726 a 1518:
726:             .TabIndex  = 7
727:             .Visible   = .T.
728:         ENDWITH
729:         BINDEVENT(loc_oPagina.txt_4c_Moedas, "KeyPress", THIS, "ValidarMoedaPorCodigo")
730:         BINDEVENT(loc_oPagina.txt_4c_Moedas, "KeyPress",  THIS, "MoedasKeyPress")
731:         BINDEVENT(loc_oPagina.txt_4c_Moedas, "DblClick",  THIS, "MoedasDblClick")
732: 
733:         loc_oPagina.AddObject("txt_4c_DescMoe", "TextBox")
734:         WITH loc_oPagina.txt_4c_DescMoe
735:             .Value     = ""
736:             .Top       = 337
737:             .Left      = 335
738:             .Width     = 115
739:             .Height    = 20
740:             .FontName  = "Tahoma"
741:             .FontSize  = 8
742:             .BackColor = RGB(255, 255, 255)
743:             .ForeColor = RGB(90, 90, 90)
744:             .Alignment = 0
745:             .TabIndex  = 8
746:             .Visible   = .T.
747:         ENDWITH
748:         BINDEVENT(loc_oPagina.txt_4c_DescMoe, "KeyPress", THIS, "ValidarMoedaPorDescricao")
749:         BINDEVENT(loc_oPagina.txt_4c_DescMoe, "KeyPress",  THIS, "DescMoeKeyPress")
750:         BINDEVENT(loc_oPagina.txt_4c_DescMoe, "DblClick",  THIS, "DescMoeDblClick")
751: 
752:         *-- === LINHA 8: Contabilizar Ganhos (fwcheckbox.Top=338->367) ===
753:         loc_oPagina.AddObject("chk_4c_Ganhos", "CheckBox")
754:         WITH loc_oPagina.chk_4c_Ganhos
755:             .Caption   = "Contabilizar Ganhos"
756:             .Value     = 0
757:             .Top       = 367
758:             .Left      = 298
759:             .Width     = 132
760:             .Height    = 17
761:             .FontName  = "Tahoma"
762:             .FontSize  = 8
763:             .ForeColor = RGB(90, 90, 90)
764:             .BackStyle = 0
765:             .Alignment = 0
766:             .TabIndex  = 9
767:             .Visible   = .T.
768:         ENDWITH
769: 
770:         THIS.TornarControlesVisiveis(loc_oPagina)
771:     ENDPROC
772: 
773:     *===========================================================================
774:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
775:     * Percorre Pages de PageFrames e Controls de Containers
776:     *===========================================================================
777:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
778:         LOCAL loc_nI, loc_oObjeto, loc_nP
779: 
780:         FOR loc_nI = 1 TO par_oContainer.ControlCount
781:             loc_oObjeto = par_oContainer.Controls(loc_nI)
782: 
783:             IF VARTYPE(loc_oObjeto) = "O"
784:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
785:                     loc_oObjeto.Visible = .T.
786:                 ENDIF
787: 
788:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
789:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
790:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
791:                     ENDFOR
792:                 ENDIF
793: 
794:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
795:                     THIS.TornarControlesVisiveis(loc_oObjeto)
796:                 ENDIF
797:             ENDIF
798:         ENDFOR
799:     ENDPROC
800: 
801:     *===========================================================================
802:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
803:     *===========================================================================
804:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
805:         LOCAL loc_lResultado
806:         loc_lResultado = .F.
807: 
808:         TRY
809:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
810:                 loc_lResultado = .F.
811:             ELSE
812:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
813:                 IF par_nPagina = 1
814:                     THIS.this_cModoAtual = "LISTA"
815:                     IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
816:                         THIS.CarregarLista()
817:                     ENDIF
818:                 ENDIF
819:                 loc_lResultado = .T.
820:             ENDIF
821:         CATCH TO loException
822:             MsgErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + ;
823:                 loException.Message, "FormMtp.AlternarPagina")
824:         ENDTRY
825: 
826:         RETURN loc_lResultado
827:     ENDPROC
828: 
829:     *===========================================================================
830:     * CarregarLista - Carrega dados do BO no grid da Page1
831:     * Colunas: tipos (Codigo), descs (Descricao), limites (Prod.Minima)
832:     *===========================================================================
833:     PROCEDURE CarregarLista()
834:         LOCAL loc_lResultado, loc_oGrid
835:         loc_lResultado = .F.
836: 
837:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
838:             loc_lResultado = .T.
839:         ELSE
840:             TRY
841:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
842: 
843:                 IF THIS.this_oBusinessObject.Buscar("")
844:                     loc_oGrid.ColumnCount = 3
845:                     loc_oGrid.RecordSource          = "cursor_4c_Dados"
846:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.tipos"
847:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
848:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.limites"
849: 
850:                     *-- Reconfigurar cabecalhos APOS ControlSource (VFP9 reseta ao alterar)
851:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
852:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
853:                     loc_oGrid.Column3.Header1.Caption = "Prod. M" + CHR(237) + "nima"
854: 
855:                     THIS.FormatarGridLista(loc_oGrid)
856:                     loc_lResultado = .T.
857:                 ENDIF
858:             CATCH TO loException
859:                 MsgErro("Erro ao carregar lista:" + CHR(13) + ;
860:                     loException.Message, "FormMtp.CarregarLista")
861:             ENDTRY
862:         ENDIF
863: 
864:         RETURN loc_lResultado
865:     ENDPROC
866: 
867:     *===========================================================================
868:     * FormatarGridLista - Formata visual do grid da lista (fonte Tahoma 8)
869:     *===========================================================================
870:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
871:         WITH par_oGrid
872:             .FontName = "Tahoma"
873:             .FontSize = 8
874:         ENDWITH
875:     ENDPROC
876: 
877:     *===========================================================================
878:     * BtnEncerrarClick - Fecha o formulario
879:     *===========================================================================
880:     PROCEDURE BtnEncerrarClick()
881:         THIS.Release()
882:     ENDPROC
883: 
884:     *===========================================================================
885:     * BtnIncluirClick - Navega para Page2 em modo INCLUIR
886:     *===========================================================================
887:     PROCEDURE BtnIncluirClick()
888:         THIS.this_oBusinessObject.NovoRegistro()
889:         THIS.LimparCampos()
890:         THIS.this_cModoAtual = "INCLUIR"
891:         THIS.HabilitarCampos(.T.)
892:         THIS.AlternarPagina(2)
893:         THIS.AjustarBotoesPorModo()
894:     ENDPROC
895: 
896:     *===========================================================================
897:     * BtnVisualizarClick - Carrega registro selecionado em modo VISUALIZAR
898:     *===========================================================================
899:     PROCEDURE BtnVisualizarClick()
900:         LOCAL loc_cTipos, loc_cGrupos
901: 
902:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
903:             MsgAviso("Nenhum registro selecionado.", "Visualizar")
904:             RETURN
905:         ENDIF
906: 
907:         SELECT cursor_4c_Dados
908:         loc_cTipos  = ALLTRIM(cursor_4c_Dados.tipos)
909:         loc_cGrupos = ALLTRIM(cursor_4c_Dados.grupos)
910: 
911:         IF THIS.this_oBusinessObject.CarregarPorTipoGrupo(loc_cTipos, loc_cGrupos)
912:             THIS.this_cModoAtual = "VISUALIZAR"
913:             THIS.BOParaForm()
914:             THIS.HabilitarCampos(.F.)
915:             THIS.AlternarPagina(2)
916:             THIS.AjustarBotoesPorModo()
917:         ENDIF
918:     ENDPROC
919: 
920:     *===========================================================================
921:     * BtnAlterarClick - Carrega registro selecionado em modo ALTERAR
922:     *===========================================================================
923:     PROCEDURE BtnAlterarClick()
924:         LOCAL loc_cTipos, loc_cGrupos
925: 
926:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
927:             MsgAviso("Nenhum registro selecionado.", "Alterar")
928:             RETURN
929:         ENDIF
930: 
931:         SELECT cursor_4c_Dados
932:         loc_cTipos  = ALLTRIM(cursor_4c_Dados.tipos)
933:         loc_cGrupos = ALLTRIM(cursor_4c_Dados.grupos)
934: 
935:         IF THIS.this_oBusinessObject.CarregarPorTipoGrupo(loc_cTipos, loc_cGrupos)
936:             THIS.this_oBusinessObject.EditarRegistro()
937:             THIS.this_cModoAtual = "ALTERAR"
938:             THIS.BOParaForm()
939:             THIS.HabilitarCampos(.T.)
940:             THIS.AlternarPagina(2)
941:             THIS.AjustarBotoesPorModo()
942:         ENDIF
943:     ENDPROC
944: 
945:     *===========================================================================
946:     * BtnExcluirClick - Confirma e exclui registro selecionado
947:     *===========================================================================
948:     PROCEDURE BtnExcluirClick()
949:         LOCAL loc_cTipos, loc_cGrupos, loc_lConfirma
950: 
951:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
952:             MsgAviso("Nenhum registro selecionado.", "Excluir")
953:             RETURN
954:         ENDIF
955: 
956:         SELECT cursor_4c_Dados
957:         loc_cTipos  = ALLTRIM(cursor_4c_Dados.tipos)
958:         loc_cGrupos = ALLTRIM(cursor_4c_Dados.grupos)
959: 
960:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", ;
961:             "Excluir")
962: 
963:         IF loc_lConfirma
964:             IF THIS.this_oBusinessObject.CarregarPorTipoGrupo(loc_cTipos, loc_cGrupos)
965:                 IF THIS.this_oBusinessObject.Excluir()
966:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", ;
967:                         "Exclus" + CHR(227) + "o")
968:                     THIS.CarregarLista()
969:                 ENDIF
970:             ENDIF
971:         ENDIF
972:     ENDPROC
973: 
974:     *===========================================================================
975:     * BtnBuscarClick - Abre busca (FormBuscaAuxiliar) e posiciona grid no resultado
976:     *===========================================================================
977:     PROCEDURE BtnBuscarClick()
978:         LOCAL loc_oBusca, loc_cTipos, loc_cGrupos, loc_nResult
979:         loc_cTipos  = ""
980:         loc_cGrupos = ""
981: 
982:         TRY
983:             loc_nResult = SQLEXEC(gnConnHandle, ;
984:                 "SELECT tipos, grupos, descs, limites" + ;
985:                 " FROM SigIdPcp ORDER BY tipos, grupos", ;
986:                 "cursor_4c_Busca")
987: 
988:             IF loc_nResult >= 0
989:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
990:                 IF VARTYPE(loc_oBusca) = "O"
991:                     loc_oBusca.DefinirCursor("cursor_4c_Busca", "tipos", "descs", ;
992:                         "Buscar Modelo de Produ" + CHR(231) + CHR(227) + "o")
993:                     loc_oBusca.mAddColuna("limites", "", "Prod. M" + CHR(237) + "nima")
994:                     IF loc_oBusca.Mostrar()
995:                         IF USED("cursor_4c_Busca")
996:                             SELECT cursor_4c_Busca
997:                             loc_cTipos  = ALLTRIM(cursor_4c_Busca.tipos)
998:                             loc_cGrupos = ALLTRIM(cursor_4c_Busca.grupos)
999:                             IF !EMPTY(loc_cTipos) AND USED("cursor_4c_Dados")
1000:                                 SELECT cursor_4c_Dados
1001:                                 LOCATE FOR ALLTRIM(tipos) == loc_cTipos AND ALLTRIM(grupos) == loc_cGrupos
1002:                             ENDIF
1003:                         ENDIF
1004:                     ENDIF
1005:                     loc_oBusca.Release()
1006:                 ENDIF
1007:             ELSE
1008:                 MsgErro("Erro ao buscar modelos: " + CapturarErroSQL(), "Erro SQL")
1009:             ENDIF
1010:         CATCH TO loException
1011:             MsgErro("Erro na busca:" + CHR(13) + loException.Message, ;
1012:                 "FormMtp.BtnBuscarClick")
1013:         ENDTRY
1014: 
1015:         IF USED("cursor_4c_Busca")
1016:             USE IN cursor_4c_Busca
1017:         ENDIF
1018:     ENDPROC
1019: 
1020:     *===========================================================================
1021:     * BtnSalvarClick - Salva o registro atual (INCLUIR ou ALTERAR)
1022:     * Validacoes: Tipos e Grupos obrigatorios; duplicidade Tipos+Grupos no INCLUIR
1023:     *===========================================================================
1024:     PROCEDURE BtnSalvarClick()
1025:         LOCAL loc_lSucesso, loc_oPag2, loc_cTipos, loc_cGrupos, loc_cSQL, loc_nResult
1026:         loc_lSucesso = .F.
1027:         loc_oPag2    = THIS.pgf_4c_Paginas.Page2
1028:         loc_cTipos   = ALLTRIM(loc_oPag2.txt_4c_Tipos.Value)
1029:         loc_cGrupos  = ALLTRIM(loc_oPag2.txt_4c_Grupo.Value)
1030: 
1031:         *-- Validacoes obrigatorias no modo INCLUIR (replicado do Salva.Click legado)
1032:         IF THIS.this_cModoAtual == "INCLUIR"
1033:             IF EMPTY(loc_cTipos)
1034:                 MsgAviso("Obrigat" + CHR(243) + "rio Informar o C" + CHR(243) + "digo...", "")
1035:                 loc_oPag2.txt_4c_Tipos.SetFocus()
1036:                 RETURN .F.
1037:             ENDIF
1038:             IF EMPTY(loc_cGrupos)
1039:                 MsgAviso("Obrigat" + CHR(243) + "rio Informar o Grupo...", "")
1040:                 loc_oPag2.txt_4c_Grupo.SetFocus()
1041:                 RETURN .F.
1042:             ENDIF
1043: 
1044:             *-- Verificar duplicidade de Tipos+Grupos
1045:             loc_cSQL = "SELECT Tipos, Grupos FROM SigIdPcp" + ;
1046:                 " WHERE Tipos=" + EscaparSQL(loc_cTipos) + ;
1047:                 " AND Grupos=" + EscaparSQL(loc_cGrupos)
1048:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PesqDup")
1049:             IF loc_nResult >= 0 AND USED("cursor_4c_PesqDup") AND !EOF("cursor_4c_PesqDup")
1050:                 MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado...", "")
1051:                 loc_oPag2.txt_4c_Grupo.SetFocus()
1052:                 USE IN cursor_4c_PesqDup
1053:                 RETURN .F.
1054:             ENDIF
1055:             IF USED("cursor_4c_PesqDup")
1056:                 USE IN cursor_4c_PesqDup
1057:             ENDIF
1058:         ENDIF
1059: 
1060:         TRY
1061:             THIS.FormParaBO()
1062:             loc_lSucesso = THIS.this_oBusinessObject.Salvar()
1063:             IF loc_lSucesso
1064:                 THIS.AlternarPagina(1)
1065:             ENDIF
1066:         CATCH TO loException
1067:             MsgErro("Erro ao salvar:" + CHR(13) + loException.Message, ;
1068:                 "FormMtp.BtnSalvarClick")
1069:         ENDTRY
1070: 
1071:         RETURN loc_lSucesso
1072:     ENDPROC
1073: 
1074:     *===========================================================================
1075:     * BtnCancelarClick - Volta para Page1 sem salvar
1076:     *===========================================================================
1077:     PROCEDURE BtnCancelarClick()
1078:         THIS.AlternarPagina(1)
1079:     ENDPROC
1080: 
1081:     *===========================================================================
1082:     * ValidarGrupo - LostFocus de txt_4c_Grupo: valida em SigCdGcr (gerbals=1)
1083:     *===========================================================================
1084:     PROCEDURE ValidarGrupo(par_nKeyCode, par_nShiftAltCtrl)
1085:         LOCAL loc_cValor, loc_oBusca
1086:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value)
1087: 
1088:         IF EMPTY(loc_cValor)
1089:             RETURN
1090:         ENDIF
1091: 
1092:         TRY
1093:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1094:                 "SigCdGcr", "cursor_4c_Gcr", "codigos", loc_cValor, ;
1095:                 "Selecionar Grupo", .F., .F., "gerbals=1")
1096: 
1097:             IF VARTYPE(loc_oBusca) = "O"
1098:                 IF !loc_oBusca.this_lAchouRegistro
1099:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
1100:                     loc_oBusca.mAddColuna("descrs",   "", "Descri" + CHR(231) + CHR(227) + "o")
1101:                     loc_oBusca.Show()
1102: 
1103:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Gcr")
1104:                         SELECT cursor_4c_Gcr
1105:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_Gcr.codigos)
1106:                     ELSE
1107:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value = ""
1108:                     ENDIF
1109:                 ENDIF
1110:                 loc_oBusca.Release()
1111:             ENDIF
1112:         CATCH TO loException
1113:             MsgErro("Erro ao validar grupo:" + CHR(13) + loException.Message, ;
1114:                 "FormMtp.ValidarGrupo")
1115:         ENDTRY
1116: 
1117:         IF USED("cursor_4c_Gcr")
1118:             USE IN cursor_4c_Gcr
1119:         ENDIF
1120:     ENDPROC
1121: 
1122:     *===========================================================================
1123:     * ValidarMoedaPorCodigo - LostFocus de txt_4c_Moedas: valida Cmoes em SigCdMoe
1124:     * Se encontrado, preenche txt_4c_DescMoe; se nao, abre picker
1125:     *===========================================================================
1126:     PROCEDURE ValidarMoedaPorCodigo(par_nKeyCode, par_nShiftAltCtrl)
1127:         LOCAL loc_oPag2, loc_cValor, loc_oBusca
1128:         loc_oPag2  = THIS.pgf_4c_Paginas.Page2
1129:         loc_cValor = ALLTRIM(loc_oPag2.txt_4c_Moedas.Value)
1130: 
1131:         IF EMPTY(loc_cValor)
1132:             loc_oPag2.txt_4c_DescMoe.Value = ""
1133:             loc_oPag2.txt_4c_DescMoe.ReadOnly = !((THIS.this_cModoAtual == "INCLUIR" OR ;
1134:                 THIS.this_cModoAtual == "ALTERAR"))
1135:             RETURN
1136:         ENDIF
1137: 
1138:         TRY
1139:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1140:                 "SigCdMoe", "cursor_4c_Moe", "cmoes", loc_cValor, ;
1141:                 "Selecionar Moeda")
1142: 
1143:             IF VARTYPE(loc_oBusca) = "O"
1144:                 IF loc_oBusca.this_lAchouRegistro
1145:                     IF USED("cursor_4c_Moe")
1146:                         SELECT cursor_4c_Moe
1147:                         loc_oPag2.txt_4c_DescMoe.Value   = ALLTRIM(cursor_4c_Moe.dmoes)
1148:                         loc_oPag2.txt_4c_DescMoe.ReadOnly = .T.
1149:                     ENDIF
1150:                 ELSE
1151:                     loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
1152:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1153:                     loc_oBusca.Show()
1154: 
1155:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Moe")
1156:                         SELECT cursor_4c_Moe
1157:                         loc_oPag2.txt_4c_Moedas.Value    = ALLTRIM(cursor_4c_Moe.cmoes)
1158:                         loc_oPag2.txt_4c_DescMoe.Value   = ALLTRIM(cursor_4c_Moe.dmoes)
1159:                         loc_oPag2.txt_4c_DescMoe.ReadOnly = .T.
1160:                     ELSE
1161:                         loc_oPag2.txt_4c_Moedas.Value  = ""
1162:                         loc_oPag2.txt_4c_DescMoe.Value = ""
1163:                         loc_oPag2.txt_4c_DescMoe.ReadOnly = .F.
1164:                     ENDIF
1165:                 ENDIF
1166:                 loc_oBusca.Release()
1167:             ENDIF
1168:         CATCH TO loException
1169:             MsgErro("Erro ao validar moeda:" + CHR(13) + loException.Message, ;
1170:                 "FormMtp.ValidarMoedaPorCodigo")
1171:         ENDTRY
1172: 
1173:         IF USED("cursor_4c_Moe")
1174:             USE IN cursor_4c_Moe
1175:         ENDIF
1176:     ENDPROC
1177: 
1178:     *===========================================================================
1179:     * ValidarMoedaPorDescricao - LostFocus de txt_4c_DescMoe: busca Dmoes em SigCdMoe
1180:     * Se encontrado exato, preenche Moedas; se nao, abre picker
1181:     *===========================================================================
1182:     PROCEDURE ValidarMoedaPorDescricao(par_nKeyCode, par_nShiftAltCtrl)
1183:         LOCAL loc_oPag2, loc_cValor, loc_oBusca
1184:         loc_oPag2  = THIS.pgf_4c_Paginas.Page2
1185:         loc_cValor = ALLTRIM(loc_oPag2.txt_4c_DescMoe.Value)
1186: 
1187:         IF EMPTY(loc_cValor)
1188:             RETURN
1189:         ENDIF
1190: 
1191:         TRY
1192:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1193:                 "SigCdMoe", "cursor_4c_Moe", "dmoes", loc_cValor, ;
1194:                 "Selecionar Moeda")
1195: 
1196:             IF VARTYPE(loc_oBusca) = "O"
1197:                 IF loc_oBusca.this_lAchouRegistro
1198:                     IF USED("cursor_4c_Moe")
1199:                         SELECT cursor_4c_Moe
1200:                         loc_oPag2.txt_4c_Moedas.Value    = ALLTRIM(cursor_4c_Moe.cmoes)
1201:                         loc_oPag2.txt_4c_DescMoe.Value   = ALLTRIM(cursor_4c_Moe.dmoes)
1202:                         loc_oPag2.txt_4c_DescMoe.ReadOnly = .T.
1203:                     ENDIF
1204:                 ELSE
1205:                     loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
1206:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1207:                     loc_oBusca.Show()
1208: 
1209:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Moe")
1210:                         SELECT cursor_4c_Moe
1211:                         loc_oPag2.txt_4c_Moedas.Value    = ALLTRIM(cursor_4c_Moe.cmoes)
1212:                         loc_oPag2.txt_4c_DescMoe.Value   = ALLTRIM(cursor_4c_Moe.dmoes)
1213:                         loc_oPag2.txt_4c_DescMoe.ReadOnly = .T.
1214:                     ELSE
1215:                         loc_oPag2.txt_4c_Moedas.Value  = ""
1216:                         loc_oPag2.txt_4c_DescMoe.Value = ""
1217:                     ENDIF
1218:                 ENDIF
1219:                 loc_oBusca.Release()
1220:             ENDIF
1221:         CATCH TO loException
1222:             MsgErro("Erro ao validar moeda por descri" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
1223:                 loException.Message, "FormMtp.ValidarMoedaPorDescricao")
1224:         ENDTRY
1225: 
1226:         IF USED("cursor_4c_Moe")
1227:             USE IN cursor_4c_Moe
1228:         ENDIF
1229:     ENDPROC
1230: 
1231:     *===========================================================================
1232:     * FormParaBO - Transfere valores dos controles para propriedades do BO
1233:     *===========================================================================
1234:     PROTECTED PROCEDURE FormParaBO()
1235:         LOCAL loc_oPag2
1236:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
1237: 
1238:         THIS.this_oBusinessObject.this_cTipos   = ALLTRIM(loc_oPag2.txt_4c_Tipos.Value)
1239:         THIS.this_oBusinessObject.this_cGrupos  = ALLTRIM(loc_oPag2.txt_4c_Grupo.Value)
1240:         THIS.this_oBusinessObject.this_cDescs   = ALLTRIM(loc_oPag2.txt_4c_Descricao.Value)
1241:         THIS.this_oBusinessObject.this_nLimites = loc_oPag2.txt_4c_Limites.Value
1242:         THIS.this_oBusinessObject.this_nFmaxs   = loc_oPag2.txt_4c_Fmaxs.Value
1243:         THIS.this_oBusinessObject.this_nValors  = loc_oPag2.txt_4c_Valors.Value
1244:         THIS.this_oBusinessObject.this_cMoedas  = ALLTRIM(loc_oPag2.txt_4c_Moedas.Value)
1245:         THIS.this_oBusinessObject.this_lGanhos  = loc_oPag2.chk_4c_Ganhos.Value
1246:     ENDPROC
1247: 
1248:     *===========================================================================
1249:     * BOParaForm - Transfere propriedades do BO para os controles do formulario
1250:     *===========================================================================
1251:     PROTECTED PROCEDURE BOParaForm()
1252:         LOCAL loc_oPag2
1253:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
1254: 
1255:         loc_oPag2.txt_4c_Tipos.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cTipos)
1256:         loc_oPag2.txt_4c_Grupo.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
1257:         loc_oPag2.txt_4c_Descricao.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescs)
1258:         loc_oPag2.txt_4c_Limites.Value   = THIS.this_oBusinessObject.this_nLimites
1259:         loc_oPag2.txt_4c_Fmaxs.Value     = THIS.this_oBusinessObject.this_nFmaxs
1260:         loc_oPag2.txt_4c_Valors.Value    = THIS.this_oBusinessObject.this_nValors
1261:         loc_oPag2.txt_4c_Moedas.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cMoedas)
1262:         loc_oPag2.txt_4c_DescMoe.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cDescMoe)
1263:         loc_oPag2.chk_4c_Ganhos.Value    = THIS.this_oBusinessObject.this_lGanhos
1264:     ENDPROC
1265: 
1266:     *===========================================================================
1267:     * HabilitarCampos - Habilita/desabilita controles conforme o modo atual
1268:     *   tipos/grupos: editaveis apenas em INCLUIR
1269:     *   campos gerais: editaveis em INCLUIR e ALTERAR
1270:     *   txt_4c_DescMoe: editavel apenas quando Moedas esta vazio
1271:     *===========================================================================
1272:     PROCEDURE HabilitarCampos(par_lHabilitar)
1273:         LOCAL loc_oPag2, loc_lIncluir, loc_lDescMoeHab
1274:         loc_oPag2    = THIS.pgf_4c_Paginas.Page2
1275:         loc_lIncluir = (THIS.this_cModoAtual == "INCLUIR")
1276: 
1277:         loc_oPag2.txt_4c_Tipos.ReadOnly      = !(par_lHabilitar AND loc_lIncluir)
1278:         loc_oPag2.txt_4c_Grupo.ReadOnly      = !(par_lHabilitar AND loc_lIncluir)
1279: 
1280:         loc_oPag2.txt_4c_Descricao.ReadOnly  = !par_lHabilitar
1281:         loc_oPag2.txt_4c_Limites.ReadOnly    = !par_lHabilitar
1282:         loc_oPag2.txt_4c_Fmaxs.ReadOnly     = !par_lHabilitar
1283:         loc_oPag2.txt_4c_Valors.ReadOnly     = !par_lHabilitar
1284:         loc_oPag2.txt_4c_Moedas.ReadOnly     = !par_lHabilitar
1285: 
1286:         loc_lDescMoeHab = par_lHabilitar AND EMPTY(ALLTRIM(loc_oPag2.txt_4c_Moedas.Value))
1287:         loc_oPag2.txt_4c_DescMoe.ReadOnly    = !loc_lDescMoeHab
1288: 
1289:         loc_oPag2.chk_4c_Ganhos.Enabled     = par_lHabilitar
1290: 
1291:         IF VARTYPE(loc_oPag2.cnt_4c_Salva) = "O"
1292:             loc_oPag2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar
1293:         ENDIF
1294:     ENDPROC
1295: 
1296:     *===========================================================================
1297:     * LimparCampos - Limpa todos os campos de Page2 para valores defaults
1298:     *===========================================================================
1299:     PROTECTED PROCEDURE LimparCampos()
1300:         LOCAL loc_oPag2
1301:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
1302: 
1303:         loc_oPag2.txt_4c_Tipos.Value     = ""
1304:         loc_oPag2.txt_4c_Grupo.Value     = ""
1305:         loc_oPag2.txt_4c_Descricao.Value = ""
1306:         loc_oPag2.txt_4c_Limites.Value   = 0
1307:         loc_oPag2.txt_4c_Fmaxs.Value     = 0
1308:         loc_oPag2.txt_4c_Valors.Value    = 0
1309:         loc_oPag2.txt_4c_Moedas.Value    = ""
1310:         loc_oPag2.txt_4c_DescMoe.Value   = ""
1311:         loc_oPag2.chk_4c_Ganhos.Value    = 0
1312:     ENDPROC
1313: 
1314:     *===========================================================================
1315:     * GrupoKeyPress - Handler KeyPress de txt_4c_Grupo: abre lookup no F4
1316:     *===========================================================================
1317:     PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1318:         IF par_nKeyCode = 28  && F4
1319:             THIS.AbrirLookupGrupo()
1320:         ENDIF
1321:     ENDPROC
1322: 
1323:     *===========================================================================
1324:     * GrupoDblClick - Handler DblClick de txt_4c_Grupo
1325:     *===========================================================================
1326:     PROCEDURE GrupoDblClick()
1327:         THIS.AbrirLookupGrupo()
1328:     ENDPROC
1329: 
1330:     *===========================================================================
1331:     * AbrirLookupGrupo - FormBuscaAuxiliar para SigCdGcr (gerbals=1)
1332:     * Campos: codigos (Codigo), descrs (Descricao)
1333:     *===========================================================================
1334:     PROCEDURE AbrirLookupGrupo()
1335:         LOCAL loc_oBusca, loc_oPag2
1336:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
1337: 
1338:         IF loc_oPag2.txt_4c_Grupo.ReadOnly
1339:             RETURN
1340:         ENDIF
1341: 
1342:         TRY
1343:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1344:                 "SigCdGcr", "cursor_4c_Gcr", "codigos", "", ;
1345:                 "Selecionar Grupo", .F., .F., "gerbals=1")
1346: 
1347:             IF VARTYPE(loc_oBusca) = "O"
1348:                 loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
1349:                 loc_oBusca.mAddColuna("descrs",   "", "Descri" + CHR(231) + CHR(227) + "o")
1350:                 loc_oBusca.Show()
1351: 
1352:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Gcr")
1353:                     SELECT cursor_4c_Gcr
1354:                     loc_oPag2.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_Gcr.codigos)
1355:                 ENDIF
1356:                 loc_oBusca.Release()
1357:             ENDIF
1358:         CATCH TO loException
1359:             MsgErro("Erro ao abrir lookup de grupo:" + CHR(13) + loException.Message, ;
1360:                 "FormMtp.AbrirLookupGrupo")
1361:         ENDTRY
1362: 
1363:         IF USED("cursor_4c_Gcr")
1364:             USE IN cursor_4c_Gcr
1365:         ENDIF
1366:     ENDPROC
1367: 
1368:     *===========================================================================
1369:     * MoedasKeyPress - Handler KeyPress de txt_4c_Moedas: abre lookup no F4
1370:     *===========================================================================
1371:     PROCEDURE MoedasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1372:         IF par_nKeyCode = 28  && F4
1373:             THIS.AbrirLookupMoedaCodigo()
1374:         ENDIF
1375:     ENDPROC
1376: 
1377:     *===========================================================================
1378:     * MoedasDblClick - Handler DblClick de txt_4c_Moedas
1379:     *===========================================================================
1380:     PROCEDURE MoedasDblClick()
1381:         THIS.AbrirLookupMoedaCodigo()
1382:     ENDPROC
1383: 
1384:     *===========================================================================
1385:     * AbrirLookupMoedaCodigo - FormBuscaAuxiliar para SigCdMoe por CMOES
1386:     * Campos: cmoes (Codigo), dmoes (Descricao)
1387:     *===========================================================================
1388:     PROCEDURE AbrirLookupMoedaCodigo()
1389:         LOCAL loc_oBusca, loc_oPag2
1390:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
1391: 
1392:         IF loc_oPag2.txt_4c_Moedas.ReadOnly
1393:             RETURN
1394:         ENDIF
1395: 
1396:         TRY
1397:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1398:                 "SigCdMoe", "cursor_4c_Moe", "cmoes", "", ;
1399:                 "Selecionar Moeda")
1400: 
1401:             IF VARTYPE(loc_oBusca) = "O"
1402:                 loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
1403:                 loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1404:                 loc_oBusca.Show()
1405: 
1406:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Moe")
1407:                     SELECT cursor_4c_Moe
1408:                     loc_oPag2.txt_4c_Moedas.Value     = ALLTRIM(cursor_4c_Moe.cmoes)
1409:                     loc_oPag2.txt_4c_DescMoe.Value    = ALLTRIM(cursor_4c_Moe.dmoes)
1410:                     loc_oPag2.txt_4c_DescMoe.ReadOnly = .T.
1411:                 ELSE
1412:                     loc_oPag2.txt_4c_Moedas.Value  = ""
1413:                     loc_oPag2.txt_4c_DescMoe.Value = ""
1414:                     loc_oPag2.txt_4c_DescMoe.ReadOnly = .F.
1415:                 ENDIF
1416:                 loc_oBusca.Release()
1417:             ENDIF
1418:         CATCH TO loException
1419:             MsgErro("Erro ao abrir lookup de moeda:" + CHR(13) + loException.Message, ;
1420:                 "FormMtp.AbrirLookupMoedaCodigo")
1421:         ENDTRY
1422: 
1423:         IF USED("cursor_4c_Moe")
1424:             USE IN cursor_4c_Moe
1425:         ENDIF
1426:     ENDPROC
1427: 
1428:     *===========================================================================
1429:     * DescMoeKeyPress - Handler KeyPress de txt_4c_DescMoe: abre lookup no F4
1430:     *===========================================================================
1431:     PROCEDURE DescMoeKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1432:         IF par_nKeyCode = 28  && F4
1433:             THIS.AbrirLookupMoedaDescricao()
1434:         ENDIF
1435:     ENDPROC
1436: 
1437:     *===========================================================================
1438:     * DescMoeDblClick - Handler DblClick de txt_4c_DescMoe
1439:     *===========================================================================
1440:     PROCEDURE DescMoeDblClick()
1441:         THIS.AbrirLookupMoedaDescricao()
1442:     ENDPROC
1443: 
1444:     *===========================================================================
1445:     * AbrirLookupMoedaDescricao - FormBuscaAuxiliar para SigCdMoe por DMOES
1446:     * Campos: cmoes (Codigo), dmoes (Descricao)
1447:     *===========================================================================
1448:     PROCEDURE AbrirLookupMoedaDescricao()
1449:         LOCAL loc_oBusca, loc_oPag2
1450:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
1451: 
1452:         IF loc_oPag2.txt_4c_DescMoe.ReadOnly
1453:             RETURN
1454:         ENDIF
1455: 
1456:         TRY
1457:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1458:                 "SigCdMoe", "cursor_4c_Moe", "dmoes", "", ;
1459:                 "Selecionar Moeda")
1460: 
1461:             IF VARTYPE(loc_oBusca) = "O"
1462:                 loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
1463:                 loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1464:                 loc_oBusca.Show()
1465: 
1466:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Moe")
1467:                     SELECT cursor_4c_Moe
1468:                     loc_oPag2.txt_4c_Moedas.Value     = ALLTRIM(cursor_4c_Moe.cmoes)
1469:                     loc_oPag2.txt_4c_DescMoe.Value    = ALLTRIM(cursor_4c_Moe.dmoes)
1470:                     loc_oPag2.txt_4c_DescMoe.ReadOnly = .T.
1471:                 ELSE
1472:                     loc_oPag2.txt_4c_Moedas.Value  = ""
1473:                     loc_oPag2.txt_4c_DescMoe.Value = ""
1474:                     loc_oPag2.txt_4c_DescMoe.ReadOnly = .F.
1475:                 ENDIF
1476:                 loc_oBusca.Release()
1477:             ENDIF
1478:         CATCH TO loException
1479:             MsgErro("Erro ao abrir lookup de moeda por descri" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
1480:                 loException.Message, "FormMtp.AbrirLookupMoedaDescricao")
1481:         ENDTRY
1482: 
1483:         IF USED("cursor_4c_Moe")
1484:             USE IN cursor_4c_Moe
1485:         ENDIF
1486:     ENDPROC
1487: 
1488:     *===========================================================================
1489:     * AjustarBotoesPorModo - Ajusta foco conforme o modo atual
1490:     * Legado: INSERIR->get_Tipos, ALTERAR->get_descs, CONSULTAR->salva.cancelar
1491:     *===========================================================================
1492:     PROCEDURE AjustarBotoesPorModo()
1493:         LOCAL loc_oPag2
1494:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
1495: 
1496:         DO CASE
1497:         CASE THIS.this_cModoAtual == "INCLUIR"
1498:             loc_oPag2.txt_4c_Tipos.SetFocus()
1499:         CASE THIS.this_cModoAtual == "ALTERAR"
1500:             loc_oPag2.txt_4c_Descricao.SetFocus()
1501:         CASE THIS.this_cModoAtual == "VISUALIZAR"
1502:             IF VARTYPE(loc_oPag2.cnt_4c_Salva) = "O"
1503:                 loc_oPag2.cnt_4c_Salva.cmd_4c_Cancelar.SetFocus()
1504:             ENDIF
1505:         ENDCASE
1506:     ENDPROC
1507: 
1508:     *===========================================================================
1509:     * Destroy - Libera recursos do formulario
1510:     *===========================================================================
1511:     PROCEDURE Destroy()
1512:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1513:             THIS.this_oBusinessObject = .NULL.
1514:         ENDIF
1515:         DODEFAULT()
1516:     ENDPROC
1517: 
1518: ENDDEFINE


### BO (C:\4c\projeto\app\classes\MtpBO.prg):
*==============================================================================
* MtpBO.prg - Business Object para Modelos de Trabalho de Producao
* Tabela: SigIdPcp
* Migrado de: SigCdMtp.SCX
*==============================================================================

DEFINE CLASS MtpBO AS BusinessBase

    *-- Chave de negocio composta: Tipos + Grupos
    this_cTipos          = ""
    this_cGrupos         = ""
    this_cTiposOriginal  = ""
    this_cGruposOriginal = ""

    *-- Dados principais
    this_cDescs    = ""
    this_nLimites  = 0
    this_nFmaxs    = 0
    this_nValors   = 0
    this_cMoedas   = ""
    this_lGanhos   = .F.

    *-- Exibicao (nao persistido na tabela SigIdPcp)
    this_cDescMoe  = ""

    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigIdPcp"
        THIS.this_cCampoChave = "tipos"
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cTipos) + "-" + ALLTRIM(THIS.this_cGrupos)
    ENDFUNC

    *==========================================================================
    * Buscar - Lista registros de SigIdPcp com JOIN para descricao de moeda
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.tipos, a.grupos, a.descs," + ;
                       " a.limites, a.fmaxs, a.valors, a.moedas, a.ganhos," + ;
                       " ISNULL(b.dmoes, '') AS desc_moe" + ;
                       " FROM SigIdPcp a" + ;
                       " LEFT JOIN SigCdMoe b ON a.moedas = b.cmoes"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE a.tipos LIKE " + EscaparSQL(par_cFiltro + "%")
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.tipos, a.grupos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar modelos de trabalho:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar modelos de trabalho:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorTipoGrupo - Carrega registro pela chave de negocio tipos+grupos
    *==========================================================================
    PROCEDURE CarregarPorTipoGrupo(par_cTipos, par_cGrupos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.tipos, a.grupos, a.descs," + ;
                       " a.limites, a.fmaxs, a.valors, a.moedas, a.ganhos," + ;
                       " ISNULL(b.dmoes, '') AS desc_moe" + ;
                       " FROM SigIdPcp a" + ;
                       " LEFT JOIN SigCdMoe b ON a.moedas = b.cmoes" + ;
                       " WHERE a.tipos = " + EscaparSQL(par_cTipos) + ;
                       " AND a.grupos = " + EscaparSQL(par_cGrupos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar modelo por tipo/grupo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * VerificarDuplicidade - Verifica se ja existe registro com tipos+grupos
    *==========================================================================
    PROCEDURE VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT tipos FROM SigIdPcp" + ;
                       " WHERE tipos = " + EscaparSQL(THIS.this_cTipos) + ;
                       " AND grupos = " + EscaparSQL(THIS.this_cGrupos)

            IF !EMPTY(THIS.this_cTiposOriginal)
                loc_cSQL = loc_cSQL + ;
                           " AND NOT (tipos = " + EscaparSQL(THIS.this_cTiposOriginal) + ;
                           " AND grupos = " + EscaparSQL(THIS.this_cGruposOriginal) + ")"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dupl")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Dupl") > 0
                loc_lExiste = .T.
            ENDIF

            IF USED("cursor_4c_Dupl")
                USE IN cursor_4c_Dupl
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Dupl")
                USE IN cursor_4c_Dupl
            ENDIF
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cTipos         = ALLTRIM(NVL(tipos,  ""))
            THIS.this_cGrupos        = ALLTRIM(NVL(grupos, ""))
            THIS.this_cTiposOriginal  = THIS.this_cTipos
            THIS.this_cGruposOriginal = THIS.this_cGrupos
            THIS.this_cDescs    = ALLTRIM(NVL(descs,     ""))
            THIS.this_nLimites  = NVL(limites, 0)
            THIS.this_nFmaxs    = NVL(fmaxs,   0)
            THIS.this_nValors   = NVL(valors,  0)
            THIS.this_cMoedas   = ALLTRIM(NVL(moedas,   ""))
            IF VARTYPE(ganhos) = "L"
                THIS.this_lGanhos = ganhos
            ELSE
                THIS.this_lGanhos = (NVL(ganhos, 0) = 1)
            ENDIF
            THIS.this_cDescMoe  = ALLTRIM(NVL(desc_moe, ""))
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - INSERT na tabela SigIdPcp
    * Chave composta: tipos + grupos
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cTipos))
                MsgAviso("C" + CHR(243) + "digo do tipo obrigat" + CHR(243) + "rio!", "Erro de valida" + CHR(231) + CHR(227) + "o")
            ELSE
                IF EMPTY(ALLTRIM(THIS.this_cGrupos))
                    MsgErro("Grupo obrigat" + CHR(243) + "rio!", "Erro de valida" + CHR(231) + CHR(227) + "o")
                ELSE
                    IF THIS.VerificarDuplicidade()
                        MsgErro("J" + CHR(225) + " existe registro com este Tipo e Grupo!", "Erro de valida" + CHR(231) + CHR(227) + "o")
                    ELSE
                        loc_cSQL = "INSERT INTO SigIdPcp" + ;
                                   " (tipos, grupos, descs," + ;
                                   " limites, fmaxs, valors, moedas, ganhos)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(THIS.this_cTipos)              + ", " + ;
                                   EscaparSQL(THIS.this_cGrupos)             + ", " + ;
                                   EscaparSQL(THIS.this_cDescs)              + ", " + ;
                                   FormatarNumeroSQL(THIS.this_nLimites, 2)  + ", " + ;
                                   FormatarNumeroSQL(THIS.this_nFmaxs,   2)  + ", " + ;
                                   FormatarNumeroSQL(THIS.this_nValors,  2)  + ", " + ;
                                   EscaparSQL(THIS.this_cMoedas)             + ", " + ;
                                   IIF(THIS.this_lGanhos, "1", "0")          + ;
                                   ")"

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResultado >= 0
                            THIS.this_cTiposOriginal  = THIS.this_cTipos
                            THIS.this_cGruposOriginal = THIS.this_cGrupos
                            THIS.RegistrarAuditoria("INSERT")
                            loc_lSucesso = .T.
                        ELSE
                            MsgErro("Erro ao inserir modelo de trabalho:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir modelo de trabalho:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE na tabela SigIdPcp (tipos+grupos sao a chave composta)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.VerificarDuplicidade()
                MsgErro("J" + CHR(225) + " existe outro registro com este Tipo e Grupo!", "Erro de valida" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_cSQL = "UPDATE SigIdPcp SET" + ;
                           " tipos   = " + EscaparSQL(THIS.this_cTipos)             + ", " + ;
                           " grupos  = " + EscaparSQL(THIS.this_cGrupos)            + ", " + ;
                           " descs   = " + EscaparSQL(THIS.this_cDescs)             + ", " + ;
                           " limites = " + FormatarNumeroSQL(THIS.this_nLimites, 2) + ", " + ;
                           " fmaxs   = " + FormatarNumeroSQL(THIS.this_nFmaxs,   2) + ", " + ;
                           " valors  = " + FormatarNumeroSQL(THIS.this_nValors,  2) + ", " + ;
                           " moedas  = " + EscaparSQL(THIS.this_cMoedas)            + ", " + ;
                           " ganhos  = " + IIF(THIS.this_lGanhos, "1", "0") + ;
                           " WHERE tipos = " + EscaparSQL(THIS.this_cTiposOriginal) + ;
                           " AND grupos = " + EscaparSQL(THIS.this_cGruposOriginal)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.this_cTiposOriginal  = THIS.this_cTipos
                    THIS.this_cGruposOriginal = THIS.this_cGrupos
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao atualizar modelo de trabalho:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar modelo de trabalho:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE da tabela SigIdPcp
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigIdPcp" + ;
                       " WHERE tipos = " + EscaparSQL(THIS.this_cTiposOriginal) + ;
                       " AND grupos = " + EscaparSQL(THIS.this_cGruposOriginal)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir modelo de trabalho:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir modelo de trabalho:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

