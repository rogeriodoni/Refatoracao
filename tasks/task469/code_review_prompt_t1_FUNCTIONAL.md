# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [BINDEVENT-PARAMS] Handler 'ValidarGrupo' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGrupo(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarMoedaPorCodigo' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarMoedaPorCodigo(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarMoedaPorDescricao' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarMoedaPorDescricao(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormMtp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1513 linhas total):

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
210:             .FontName        = "Comic Sans MS"
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
235:             .FontName        = "Comic Sans MS"
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
260:             .FontName        = "Comic Sans MS"
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
285:             .FontName        = "Comic Sans MS"
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
323:             .FontName        = "Comic Sans MS"
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
431:             .FontName        = "Comic Sans MS"
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
456:             .FontName        = "Comic Sans MS"
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

*-- Linhas 726 a 1513:
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
900:         LOCAL loc_cChave
901: 
902:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
903:             MsgAviso("Nenhum registro selecionado.", "Visualizar")
904:             RETURN
905:         ENDIF
906: 
907:         SELECT cursor_4c_Dados
908:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
909: 
910:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
911:             THIS.this_cModoAtual = "VISUALIZAR"
912:             THIS.BOParaForm()
913:             THIS.HabilitarCampos(.F.)
914:             THIS.AlternarPagina(2)
915:             THIS.AjustarBotoesPorModo()
916:         ENDIF
917:     ENDPROC
918: 
919:     *===========================================================================
920:     * BtnAlterarClick - Carrega registro selecionado em modo ALTERAR
921:     *===========================================================================
922:     PROCEDURE BtnAlterarClick()
923:         LOCAL loc_cChave
924: 
925:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
926:             MsgAviso("Nenhum registro selecionado.", "Alterar")
927:             RETURN
928:         ENDIF
929: 
930:         SELECT cursor_4c_Dados
931:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
932: 
933:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
934:             THIS.this_oBusinessObject.EditarRegistro()
935:             THIS.this_cModoAtual = "ALTERAR"
936:             THIS.BOParaForm()
937:             THIS.HabilitarCampos(.T.)
938:             THIS.AlternarPagina(2)
939:             THIS.AjustarBotoesPorModo()
940:         ENDIF
941:     ENDPROC
942: 
943:     *===========================================================================
944:     * BtnExcluirClick - Confirma e exclui registro selecionado
945:     *===========================================================================
946:     PROCEDURE BtnExcluirClick()
947:         LOCAL loc_cChave, loc_lConfirma
948: 
949:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
950:             MsgAviso("Nenhum registro selecionado.", "Excluir")
951:             RETURN
952:         ENDIF
953: 
954:         SELECT cursor_4c_Dados
955:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
956: 
957:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", ;
958:             "Excluir")
959: 
960:         IF loc_lConfirma
961:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
962:                 IF THIS.this_oBusinessObject.Excluir()
963:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", ;
964:                         "Exclus" + CHR(227) + "o")
965:                     THIS.CarregarLista()
966:                 ENDIF
967:             ENDIF
968:         ENDIF
969:     ENDPROC
970: 
971:     *===========================================================================
972:     * BtnBuscarClick - Abre busca (FormBuscaAuxiliar) e posiciona grid no resultado
973:     *===========================================================================
974:     PROCEDURE BtnBuscarClick()
975:         LOCAL loc_oBusca, loc_cChave, loc_nResult
976:         loc_cChave = ""
977: 
978:         TRY
979:             loc_nResult = SQLEXEC(gnConnHandle, ;
980:                 "SELECT cidchaves, tipos, grupos, descs, limites" + ;
981:                 " FROM SigIdPcp ORDER BY tipos, grupos", ;
982:                 "cursor_4c_Busca")
983: 
984:             IF loc_nResult >= 0
985:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
986:                 IF VARTYPE(loc_oBusca) = "O"
987:                     loc_oBusca.DefinirCursor("cursor_4c_Busca", "tipos", "descs", ;
988:                         "Buscar Modelo de Produ" + CHR(231) + CHR(227) + "o")
989:                     loc_oBusca.mAddColuna("limites", "", "Prod. M" + CHR(237) + "nima")
990:                     IF loc_oBusca.Mostrar()
991:                         IF USED("cursor_4c_Busca")
992:                             SELECT cursor_4c_Busca
993:                             loc_cChave = ALLTRIM(cursor_4c_Busca.cidchaves)
994:                             IF !EMPTY(loc_cChave) AND USED("cursor_4c_Dados")
995:                                 SELECT cursor_4c_Dados
996:                                 LOCATE FOR ALLTRIM(cidchaves) == loc_cChave
997:                             ENDIF
998:                         ENDIF
999:                     ENDIF
1000:                     loc_oBusca.Release()
1001:                 ENDIF
1002:             ELSE
1003:                 MsgErro("Erro ao buscar modelos: " + CapturarErroSQL(), "Erro SQL")
1004:             ENDIF
1005:         CATCH TO loException
1006:             MsgErro("Erro na busca:" + CHR(13) + loException.Message, ;
1007:                 "FormMtp.BtnBuscarClick")
1008:         ENDTRY
1009: 
1010:         IF USED("cursor_4c_Busca")
1011:             USE IN cursor_4c_Busca
1012:         ENDIF
1013:     ENDPROC
1014: 
1015:     *===========================================================================
1016:     * BtnSalvarClick - Salva o registro atual (INCLUIR ou ALTERAR)
1017:     * Validacoes: Tipos e Grupos obrigatorios; duplicidade Tipos+Grupos no INCLUIR
1018:     *===========================================================================
1019:     PROCEDURE BtnSalvarClick()
1020:         LOCAL loc_lSucesso, loc_oPag2, loc_cTipos, loc_cGrupos, loc_cSQL, loc_nResult
1021:         loc_lSucesso = .F.
1022:         loc_oPag2    = THIS.pgf_4c_Paginas.Page2
1023:         loc_cTipos   = ALLTRIM(loc_oPag2.txt_4c_Tipos.Value)
1024:         loc_cGrupos  = ALLTRIM(loc_oPag2.txt_4c_Grupo.Value)
1025: 
1026:         *-- Validacoes obrigatorias no modo INCLUIR (replicado do Salva.Click legado)
1027:         IF THIS.this_cModoAtual == "INCLUIR"
1028:             IF EMPTY(loc_cTipos)
1029:                 MsgAviso("Obrigat" + CHR(243) + "rio Informar o C" + CHR(243) + "digo...", "")
1030:                 loc_oPag2.txt_4c_Tipos.SetFocus()
1031:                 RETURN .F.
1032:             ENDIF
1033:             IF EMPTY(loc_cGrupos)
1034:                 MsgAviso("Obrigat" + CHR(243) + "rio Informar o Grupo...", "")
1035:                 loc_oPag2.txt_4c_Grupo.SetFocus()
1036:                 RETURN .F.
1037:             ENDIF
1038: 
1039:             *-- Verificar duplicidade de Tipos+Grupos
1040:             loc_cSQL = "SELECT Tipos, Grupos FROM SigIdPcp" + ;
1041:                 " WHERE Tipos=" + EscaparSQL(loc_cTipos) + ;
1042:                 " AND Grupos=" + EscaparSQL(loc_cGrupos)
1043:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PesqDup")
1044:             IF loc_nResult >= 0 AND USED("cursor_4c_PesqDup") AND !EOF("cursor_4c_PesqDup")
1045:                 MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado...", "")
1046:                 loc_oPag2.txt_4c_Grupo.SetFocus()
1047:                 USE IN cursor_4c_PesqDup
1048:                 RETURN .F.
1049:             ENDIF
1050:             IF USED("cursor_4c_PesqDup")
1051:                 USE IN cursor_4c_PesqDup
1052:             ENDIF
1053:         ENDIF
1054: 
1055:         TRY
1056:             THIS.FormParaBO()
1057:             loc_lSucesso = THIS.this_oBusinessObject.Salvar()
1058:             IF loc_lSucesso
1059:                 THIS.AlternarPagina(1)
1060:             ENDIF
1061:         CATCH TO loException
1062:             MsgErro("Erro ao salvar:" + CHR(13) + loException.Message, ;
1063:                 "FormMtp.BtnSalvarClick")
1064:         ENDTRY
1065: 
1066:         RETURN loc_lSucesso
1067:     ENDPROC
1068: 
1069:     *===========================================================================
1070:     * BtnCancelarClick - Volta para Page1 sem salvar
1071:     *===========================================================================
1072:     PROCEDURE BtnCancelarClick()
1073:         THIS.AlternarPagina(1)
1074:     ENDPROC
1075: 
1076:     *===========================================================================
1077:     * ValidarGrupo - LostFocus de txt_4c_Grupo: valida em SigCdGcr (gerbals=1)
1078:     *===========================================================================
1079:     PROCEDURE ValidarGrupo(par_nKeyCode, par_nShiftAltCtrl)
1080:         LOCAL loc_cValor, loc_oBusca
1081:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value)
1082: 
1083:         IF EMPTY(loc_cValor)
1084:             RETURN
1085:         ENDIF
1086: 
1087:         TRY
1088:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1089:                 "SigCdGcr", "cursor_4c_Gcr", "codigos", loc_cValor, ;
1090:                 "Selecionar Grupo", .F., .F., "gerbals=1")
1091: 
1092:             IF VARTYPE(loc_oBusca) = "O"
1093:                 IF !loc_oBusca.this_lAchouRegistro
1094:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
1095:                     loc_oBusca.mAddColuna("descrs",   "", "Descri" + CHR(231) + CHR(227) + "o")
1096:                     loc_oBusca.Show()
1097: 
1098:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Gcr")
1099:                         SELECT cursor_4c_Gcr
1100:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_Gcr.codigos)
1101:                     ELSE
1102:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value = ""
1103:                     ENDIF
1104:                 ENDIF
1105:                 loc_oBusca.Release()
1106:             ENDIF
1107:         CATCH TO loException
1108:             MsgErro("Erro ao validar grupo:" + CHR(13) + loException.Message, ;
1109:                 "FormMtp.ValidarGrupo")
1110:         ENDTRY
1111: 
1112:         IF USED("cursor_4c_Gcr")
1113:             USE IN cursor_4c_Gcr
1114:         ENDIF
1115:     ENDPROC
1116: 
1117:     *===========================================================================
1118:     * ValidarMoedaPorCodigo - LostFocus de txt_4c_Moedas: valida Cmoes em SigCdMoe
1119:     * Se encontrado, preenche txt_4c_DescMoe; se nao, abre picker
1120:     *===========================================================================
1121:     PROCEDURE ValidarMoedaPorCodigo(par_nKeyCode, par_nShiftAltCtrl)
1122:         LOCAL loc_oPag2, loc_cValor, loc_oBusca
1123:         loc_oPag2  = THIS.pgf_4c_Paginas.Page2
1124:         loc_cValor = ALLTRIM(loc_oPag2.txt_4c_Moedas.Value)
1125: 
1126:         IF EMPTY(loc_cValor)
1127:             loc_oPag2.txt_4c_DescMoe.Value = ""
1128:             loc_oPag2.txt_4c_DescMoe.ReadOnly = !((THIS.this_cModoAtual == "INCLUIR" OR ;
1129:                 THIS.this_cModoAtual == "ALTERAR"))
1130:             RETURN
1131:         ENDIF
1132: 
1133:         TRY
1134:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1135:                 "SigCdMoe", "cursor_4c_Moe", "cmoes", loc_cValor, ;
1136:                 "Selecionar Moeda")
1137: 
1138:             IF VARTYPE(loc_oBusca) = "O"
1139:                 IF loc_oBusca.this_lAchouRegistro
1140:                     IF USED("cursor_4c_Moe")
1141:                         SELECT cursor_4c_Moe
1142:                         loc_oPag2.txt_4c_DescMoe.Value   = ALLTRIM(cursor_4c_Moe.dmoes)
1143:                         loc_oPag2.txt_4c_DescMoe.ReadOnly = .T.
1144:                     ENDIF
1145:                 ELSE
1146:                     loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
1147:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1148:                     loc_oBusca.Show()
1149: 
1150:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Moe")
1151:                         SELECT cursor_4c_Moe
1152:                         loc_oPag2.txt_4c_Moedas.Value    = ALLTRIM(cursor_4c_Moe.cmoes)
1153:                         loc_oPag2.txt_4c_DescMoe.Value   = ALLTRIM(cursor_4c_Moe.dmoes)
1154:                         loc_oPag2.txt_4c_DescMoe.ReadOnly = .T.
1155:                     ELSE
1156:                         loc_oPag2.txt_4c_Moedas.Value  = ""
1157:                         loc_oPag2.txt_4c_DescMoe.Value = ""
1158:                         loc_oPag2.txt_4c_DescMoe.ReadOnly = .F.
1159:                     ENDIF
1160:                 ENDIF
1161:                 loc_oBusca.Release()
1162:             ENDIF
1163:         CATCH TO loException
1164:             MsgErro("Erro ao validar moeda:" + CHR(13) + loException.Message, ;
1165:                 "FormMtp.ValidarMoedaPorCodigo")
1166:         ENDTRY
1167: 
1168:         IF USED("cursor_4c_Moe")
1169:             USE IN cursor_4c_Moe
1170:         ENDIF
1171:     ENDPROC
1172: 
1173:     *===========================================================================
1174:     * ValidarMoedaPorDescricao - LostFocus de txt_4c_DescMoe: busca Dmoes em SigCdMoe
1175:     * Se encontrado exato, preenche Moedas; se nao, abre picker
1176:     *===========================================================================
1177:     PROCEDURE ValidarMoedaPorDescricao(par_nKeyCode, par_nShiftAltCtrl)
1178:         LOCAL loc_oPag2, loc_cValor, loc_oBusca
1179:         loc_oPag2  = THIS.pgf_4c_Paginas.Page2
1180:         loc_cValor = ALLTRIM(loc_oPag2.txt_4c_DescMoe.Value)
1181: 
1182:         IF EMPTY(loc_cValor)
1183:             RETURN
1184:         ENDIF
1185: 
1186:         TRY
1187:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1188:                 "SigCdMoe", "cursor_4c_Moe", "dmoes", loc_cValor, ;
1189:                 "Selecionar Moeda")
1190: 
1191:             IF VARTYPE(loc_oBusca) = "O"
1192:                 IF loc_oBusca.this_lAchouRegistro
1193:                     IF USED("cursor_4c_Moe")
1194:                         SELECT cursor_4c_Moe
1195:                         loc_oPag2.txt_4c_Moedas.Value    = ALLTRIM(cursor_4c_Moe.cmoes)
1196:                         loc_oPag2.txt_4c_DescMoe.Value   = ALLTRIM(cursor_4c_Moe.dmoes)
1197:                         loc_oPag2.txt_4c_DescMoe.ReadOnly = .T.
1198:                     ENDIF
1199:                 ELSE
1200:                     loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
1201:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1202:                     loc_oBusca.Show()
1203: 
1204:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Moe")
1205:                         SELECT cursor_4c_Moe
1206:                         loc_oPag2.txt_4c_Moedas.Value    = ALLTRIM(cursor_4c_Moe.cmoes)
1207:                         loc_oPag2.txt_4c_DescMoe.Value   = ALLTRIM(cursor_4c_Moe.dmoes)
1208:                         loc_oPag2.txt_4c_DescMoe.ReadOnly = .T.
1209:                     ELSE
1210:                         loc_oPag2.txt_4c_Moedas.Value  = ""
1211:                         loc_oPag2.txt_4c_DescMoe.Value = ""
1212:                     ENDIF
1213:                 ENDIF
1214:                 loc_oBusca.Release()
1215:             ENDIF
1216:         CATCH TO loException
1217:             MsgErro("Erro ao validar moeda por descri" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
1218:                 loException.Message, "FormMtp.ValidarMoedaPorDescricao")
1219:         ENDTRY
1220: 
1221:         IF USED("cursor_4c_Moe")
1222:             USE IN cursor_4c_Moe
1223:         ENDIF
1224:     ENDPROC
1225: 
1226:     *===========================================================================
1227:     * FormParaBO - Transfere valores dos controles para propriedades do BO
1228:     *===========================================================================
1229:     PROTECTED PROCEDURE FormParaBO()
1230:         LOCAL loc_oPag2
1231:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
1232: 
1233:         THIS.this_oBusinessObject.this_cTipos   = ALLTRIM(loc_oPag2.txt_4c_Tipos.Value)
1234:         THIS.this_oBusinessObject.this_cGrupos  = ALLTRIM(loc_oPag2.txt_4c_Grupo.Value)
1235:         THIS.this_oBusinessObject.this_cDescs   = ALLTRIM(loc_oPag2.txt_4c_Descricao.Value)
1236:         THIS.this_oBusinessObject.this_nLimites = loc_oPag2.txt_4c_Limites.Value
1237:         THIS.this_oBusinessObject.this_nFmaxs   = loc_oPag2.txt_4c_Fmaxs.Value
1238:         THIS.this_oBusinessObject.this_nValors  = loc_oPag2.txt_4c_Valors.Value
1239:         THIS.this_oBusinessObject.this_cMoedas  = ALLTRIM(loc_oPag2.txt_4c_Moedas.Value)
1240:         THIS.this_oBusinessObject.this_lGanhos  = loc_oPag2.chk_4c_Ganhos.Value
1241:     ENDPROC
1242: 
1243:     *===========================================================================
1244:     * BOParaForm - Transfere propriedades do BO para os controles do formulario
1245:     *===========================================================================
1246:     PROTECTED PROCEDURE BOParaForm()
1247:         LOCAL loc_oPag2
1248:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
1249: 
1250:         loc_oPag2.txt_4c_Tipos.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cTipos)
1251:         loc_oPag2.txt_4c_Grupo.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
1252:         loc_oPag2.txt_4c_Descricao.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescs)
1253:         loc_oPag2.txt_4c_Limites.Value   = THIS.this_oBusinessObject.this_nLimites
1254:         loc_oPag2.txt_4c_Fmaxs.Value     = THIS.this_oBusinessObject.this_nFmaxs
1255:         loc_oPag2.txt_4c_Valors.Value    = THIS.this_oBusinessObject.this_nValors
1256:         loc_oPag2.txt_4c_Moedas.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cMoedas)
1257:         loc_oPag2.txt_4c_DescMoe.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cDescMoe)
1258:         loc_oPag2.chk_4c_Ganhos.Value    = THIS.this_oBusinessObject.this_lGanhos
1259:     ENDPROC
1260: 
1261:     *===========================================================================
1262:     * HabilitarCampos - Habilita/desabilita controles conforme o modo atual
1263:     *   tipos/grupos: editaveis apenas em INCLUIR
1264:     *   campos gerais: editaveis em INCLUIR e ALTERAR
1265:     *   txt_4c_DescMoe: editavel apenas quando Moedas esta vazio
1266:     *===========================================================================
1267:     PROCEDURE HabilitarCampos(par_lHabilitar)
1268:         LOCAL loc_oPag2, loc_lIncluir, loc_lDescMoeHab
1269:         loc_oPag2    = THIS.pgf_4c_Paginas.Page2
1270:         loc_lIncluir = (THIS.this_cModoAtual == "INCLUIR")
1271: 
1272:         loc_oPag2.txt_4c_Tipos.ReadOnly      = !(par_lHabilitar AND loc_lIncluir)
1273:         loc_oPag2.txt_4c_Grupo.ReadOnly      = !(par_lHabilitar AND loc_lIncluir)
1274: 
1275:         loc_oPag2.txt_4c_Descricao.ReadOnly  = !par_lHabilitar
1276:         loc_oPag2.txt_4c_Limites.ReadOnly    = !par_lHabilitar
1277:         loc_oPag2.txt_4c_Fmaxs.ReadOnly     = !par_lHabilitar
1278:         loc_oPag2.txt_4c_Valors.ReadOnly     = !par_lHabilitar
1279:         loc_oPag2.txt_4c_Moedas.ReadOnly     = !par_lHabilitar
1280: 
1281:         loc_lDescMoeHab = par_lHabilitar AND EMPTY(ALLTRIM(loc_oPag2.txt_4c_Moedas.Value))
1282:         loc_oPag2.txt_4c_DescMoe.ReadOnly    = !loc_lDescMoeHab
1283: 
1284:         loc_oPag2.chk_4c_Ganhos.Enabled     = par_lHabilitar
1285: 
1286:         IF VARTYPE(loc_oPag2.cnt_4c_Salva) = "O"
1287:             loc_oPag2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar
1288:         ENDIF
1289:     ENDPROC
1290: 
1291:     *===========================================================================
1292:     * LimparCampos - Limpa todos os campos de Page2 para valores defaults
1293:     *===========================================================================
1294:     PROTECTED PROCEDURE LimparCampos()
1295:         LOCAL loc_oPag2
1296:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
1297: 
1298:         loc_oPag2.txt_4c_Tipos.Value     = ""
1299:         loc_oPag2.txt_4c_Grupo.Value     = ""
1300:         loc_oPag2.txt_4c_Descricao.Value = ""
1301:         loc_oPag2.txt_4c_Limites.Value   = 0
1302:         loc_oPag2.txt_4c_Fmaxs.Value     = 0
1303:         loc_oPag2.txt_4c_Valors.Value    = 0
1304:         loc_oPag2.txt_4c_Moedas.Value    = ""
1305:         loc_oPag2.txt_4c_DescMoe.Value   = ""
1306:         loc_oPag2.chk_4c_Ganhos.Value    = 0
1307:     ENDPROC
1308: 
1309:     *===========================================================================
1310:     * GrupoKeyPress - Handler KeyPress de txt_4c_Grupo: abre lookup no F4
1311:     *===========================================================================
1312:     PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1313:         IF par_nKeyCode = 28  && F4
1314:             THIS.AbrirLookupGrupo()
1315:         ENDIF
1316:     ENDPROC
1317: 
1318:     *===========================================================================
1319:     * GrupoDblClick - Handler DblClick de txt_4c_Grupo
1320:     *===========================================================================
1321:     PROCEDURE GrupoDblClick()
1322:         THIS.AbrirLookupGrupo()
1323:     ENDPROC
1324: 
1325:     *===========================================================================
1326:     * AbrirLookupGrupo - FormBuscaAuxiliar para SigCdGcr (gerbals=1)
1327:     * Campos: codigos (Codigo), descrs (Descricao)
1328:     *===========================================================================
1329:     PROCEDURE AbrirLookupGrupo()
1330:         LOCAL loc_oBusca, loc_oPag2
1331:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
1332: 
1333:         IF loc_oPag2.txt_4c_Grupo.ReadOnly
1334:             RETURN
1335:         ENDIF
1336: 
1337:         TRY
1338:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1339:                 "SigCdGcr", "cursor_4c_Gcr", "codigos", "", ;
1340:                 "Selecionar Grupo", .F., .F., "gerbals=1")
1341: 
1342:             IF VARTYPE(loc_oBusca) = "O"
1343:                 loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
1344:                 loc_oBusca.mAddColuna("descrs",   "", "Descri" + CHR(231) + CHR(227) + "o")
1345:                 loc_oBusca.Show()
1346: 
1347:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Gcr")
1348:                     SELECT cursor_4c_Gcr
1349:                     loc_oPag2.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_Gcr.codigos)
1350:                 ENDIF
1351:                 loc_oBusca.Release()
1352:             ENDIF
1353:         CATCH TO loException
1354:             MsgErro("Erro ao abrir lookup de grupo:" + CHR(13) + loException.Message, ;
1355:                 "FormMtp.AbrirLookupGrupo")
1356:         ENDTRY
1357: 
1358:         IF USED("cursor_4c_Gcr")
1359:             USE IN cursor_4c_Gcr
1360:         ENDIF
1361:     ENDPROC
1362: 
1363:     *===========================================================================
1364:     * MoedasKeyPress - Handler KeyPress de txt_4c_Moedas: abre lookup no F4
1365:     *===========================================================================
1366:     PROCEDURE MoedasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1367:         IF par_nKeyCode = 28  && F4
1368:             THIS.AbrirLookupMoedaCodigo()
1369:         ENDIF
1370:     ENDPROC
1371: 
1372:     *===========================================================================
1373:     * MoedasDblClick - Handler DblClick de txt_4c_Moedas
1374:     *===========================================================================
1375:     PROCEDURE MoedasDblClick()
1376:         THIS.AbrirLookupMoedaCodigo()
1377:     ENDPROC
1378: 
1379:     *===========================================================================
1380:     * AbrirLookupMoedaCodigo - FormBuscaAuxiliar para SigCdMoe por CMOES
1381:     * Campos: cmoes (Codigo), dmoes (Descricao)
1382:     *===========================================================================
1383:     PROCEDURE AbrirLookupMoedaCodigo()
1384:         LOCAL loc_oBusca, loc_oPag2
1385:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
1386: 
1387:         IF loc_oPag2.txt_4c_Moedas.ReadOnly
1388:             RETURN
1389:         ENDIF
1390: 
1391:         TRY
1392:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1393:                 "SigCdMoe", "cursor_4c_Moe", "cmoes", "", ;
1394:                 "Selecionar Moeda")
1395: 
1396:             IF VARTYPE(loc_oBusca) = "O"
1397:                 loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
1398:                 loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1399:                 loc_oBusca.Show()
1400: 
1401:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Moe")
1402:                     SELECT cursor_4c_Moe
1403:                     loc_oPag2.txt_4c_Moedas.Value     = ALLTRIM(cursor_4c_Moe.cmoes)
1404:                     loc_oPag2.txt_4c_DescMoe.Value    = ALLTRIM(cursor_4c_Moe.dmoes)
1405:                     loc_oPag2.txt_4c_DescMoe.ReadOnly = .T.
1406:                 ELSE
1407:                     loc_oPag2.txt_4c_Moedas.Value  = ""
1408:                     loc_oPag2.txt_4c_DescMoe.Value = ""
1409:                     loc_oPag2.txt_4c_DescMoe.ReadOnly = .F.
1410:                 ENDIF
1411:                 loc_oBusca.Release()
1412:             ENDIF
1413:         CATCH TO loException
1414:             MsgErro("Erro ao abrir lookup de moeda:" + CHR(13) + loException.Message, ;
1415:                 "FormMtp.AbrirLookupMoedaCodigo")
1416:         ENDTRY
1417: 
1418:         IF USED("cursor_4c_Moe")
1419:             USE IN cursor_4c_Moe
1420:         ENDIF
1421:     ENDPROC
1422: 
1423:     *===========================================================================
1424:     * DescMoeKeyPress - Handler KeyPress de txt_4c_DescMoe: abre lookup no F4
1425:     *===========================================================================
1426:     PROCEDURE DescMoeKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1427:         IF par_nKeyCode = 28  && F4
1428:             THIS.AbrirLookupMoedaDescricao()
1429:         ENDIF
1430:     ENDPROC
1431: 
1432:     *===========================================================================
1433:     * DescMoeDblClick - Handler DblClick de txt_4c_DescMoe
1434:     *===========================================================================
1435:     PROCEDURE DescMoeDblClick()
1436:         THIS.AbrirLookupMoedaDescricao()
1437:     ENDPROC
1438: 
1439:     *===========================================================================
1440:     * AbrirLookupMoedaDescricao - FormBuscaAuxiliar para SigCdMoe por DMOES
1441:     * Campos: cmoes (Codigo), dmoes (Descricao)
1442:     *===========================================================================
1443:     PROCEDURE AbrirLookupMoedaDescricao()
1444:         LOCAL loc_oBusca, loc_oPag2
1445:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
1446: 
1447:         IF loc_oPag2.txt_4c_DescMoe.ReadOnly
1448:             RETURN
1449:         ENDIF
1450: 
1451:         TRY
1452:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1453:                 "SigCdMoe", "cursor_4c_Moe", "dmoes", "", ;
1454:                 "Selecionar Moeda")
1455: 
1456:             IF VARTYPE(loc_oBusca) = "O"
1457:                 loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
1458:                 loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1459:                 loc_oBusca.Show()
1460: 
1461:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Moe")
1462:                     SELECT cursor_4c_Moe
1463:                     loc_oPag2.txt_4c_Moedas.Value     = ALLTRIM(cursor_4c_Moe.cmoes)
1464:                     loc_oPag2.txt_4c_DescMoe.Value    = ALLTRIM(cursor_4c_Moe.dmoes)
1465:                     loc_oPag2.txt_4c_DescMoe.ReadOnly = .T.
1466:                 ELSE
1467:                     loc_oPag2.txt_4c_Moedas.Value  = ""
1468:                     loc_oPag2.txt_4c_DescMoe.Value = ""
1469:                     loc_oPag2.txt_4c_DescMoe.ReadOnly = .F.
1470:                 ENDIF
1471:                 loc_oBusca.Release()
1472:             ENDIF
1473:         CATCH TO loException
1474:             MsgErro("Erro ao abrir lookup de moeda por descri" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
1475:                 loException.Message, "FormMtp.AbrirLookupMoedaDescricao")
1476:         ENDTRY
1477: 
1478:         IF USED("cursor_4c_Moe")
1479:             USE IN cursor_4c_Moe
1480:         ENDIF
1481:     ENDPROC
1482: 
1483:     *===========================================================================
1484:     * AjustarBotoesPorModo - Ajusta foco conforme o modo atual
1485:     * Legado: INSERIR->get_Tipos, ALTERAR->get_descs, CONSULTAR->salva.cancelar
1486:     *===========================================================================
1487:     PROCEDURE AjustarBotoesPorModo()
1488:         LOCAL loc_oPag2
1489:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
1490: 
1491:         DO CASE
1492:         CASE THIS.this_cModoAtual == "INCLUIR"
1493:             loc_oPag2.txt_4c_Tipos.SetFocus()
1494:         CASE THIS.this_cModoAtual == "ALTERAR"
1495:             loc_oPag2.txt_4c_Descricao.SetFocus()
1496:         CASE THIS.this_cModoAtual == "VISUALIZAR"
1497:             IF VARTYPE(loc_oPag2.cnt_4c_Salva) = "O"
1498:                 loc_oPag2.cnt_4c_Salva.cmd_4c_Cancelar.SetFocus()
1499:             ENDIF
1500:         ENDCASE
1501:     ENDPROC
1502: 
1503:     *===========================================================================
1504:     * Destroy - Libera recursos do formulario
1505:     *===========================================================================
1506:     PROCEDURE Destroy()
1507:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1508:             THIS.this_oBusinessObject = .NULL.
1509:         ENDIF
1510:         DODEFAULT()
1511:     ENDPROC
1512: 
1513: ENDDEFINE


### BO (C:\4c\projeto\app\classes\MtpBO.prg):
*==============================================================================
* MtpBO.prg - Business Object para Modelos de Trabalho de Producao
* Tabela: SigIdPcp
* Migrado de: SigCdMtp.SCX
*==============================================================================

DEFINE CLASS MtpBO AS BusinessBase

    *-- Chave primaria (gerada internamente no INSERT)
    this_cIdChaves = ""

    *-- Chave de negocio composta: Tipos + Grupos
    this_cTipos    = ""
    this_cGrupos   = ""

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
        THIS.this_cCampoChave = "cIdChaves"
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cIdChaves)
    ENDFUNC

    *==========================================================================
    * Buscar - Lista registros de SigIdPcp com JOIN para descricao de moeda
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.tipos, a.grupos, a.descs," + ;
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
    * CarregarPorCodigo - Carrega um registro pelo cidchaves (PK)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cIdChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.tipos, a.grupos, a.descs," + ;
                       " a.limites, a.fmaxs, a.valors, a.moedas, a.ganhos," + ;
                       " ISNULL(b.dmoes, '') AS desc_moe" + ;
                       " FROM SigIdPcp a" + ;
                       " LEFT JOIN SigCdMoe b ON a.moedas = b.cmoes" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(par_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar modelo de trabalho:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
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
            loc_cSQL = "SELECT a.cidchaves, a.tipos, a.grupos, a.descs," + ;
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
            loc_cSQL = "SELECT cidchaves FROM SigIdPcp" + ;
                       " WHERE tipos = " + EscaparSQL(THIS.this_cTipos) + ;
                       " AND grupos = " + EscaparSQL(THIS.this_cGrupos)

            IF !EMPTY(ALLTRIM(THIS.this_cIdChaves))
                loc_cSQL = loc_cSQL + " AND cidchaves <> " + EscaparSQL(THIS.this_cIdChaves)
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
            THIS.this_cIdChaves = ALLTRIM(NVL(cidchaves, ""))
            THIS.this_cTipos    = ALLTRIM(NVL(tipos,     ""))
            THIS.this_cGrupos   = ALLTRIM(NVL(grupos,    ""))
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
    * Gera cidchaves via fUniqueIds()
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
                        THIS.this_cIdChaves = fUniqueIds()

                        loc_cSQL = "INSERT INTO SigIdPcp" + ;
                                   " (cidchaves, tipos, grupos, descs," + ;
                                   " limites, fmaxs, valors, moedas, ganhos)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(THIS.this_cIdChaves)           + ", " + ;
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
    * Atualizar - UPDATE na tabela SigIdPcp (cidchaves e chave, nao alterar)
    * tipos e grupos podem ser alterados (nao sao a PK tecnica)
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
                           " WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
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
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

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

