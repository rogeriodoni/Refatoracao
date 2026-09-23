# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [BINDEVENT-PARAMS] Handler 'CodigoLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE CodigoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'DescricaoLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE DescricaoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'DiasPorSemanaLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE DiasPorSemanaLostFocus(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormUpd.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1460 linhas total):

*-- Linhas 22 a 153:
22:     this_cModoAtual       = "LISTA"
23: 
24:     *-- Guardas de lookup (Problema 45: evita reabrir picker sem o valor mudar)
25:     this_cUltimoCodigoFaseValidado    = ""
26:     this_cUltimaDescricaoFaseValidada = ""
27: 
28:     *===========================================================================
29:     * Init - Inicializa o formulario
30:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
31:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
32:     *===========================================================================
33:     PROCEDURE Init()
34:         RETURN DODEFAULT()
35:     ENDPROC
36: 
37:     *===========================================================================
38:     * InicializarForm - Configura estrutura completa
39:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
40:     *===========================================================================
41:     PROTECTED PROCEDURE InicializarForm()
42:         LOCAL loc_lSucesso
43:         loc_lSucesso = .F.
44: 
45:         TRY
46:             THIS.this_oBusinessObject = CREATEOBJECT("UpdBO")
47: 
48:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
49:                 MostrarErro("Erro ao criar UpdBO" + CHR(13) + ;
50:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
51:                     "FormUpd.InicializarForm")
52:             ELSE
53:                 THIS.ConfigurarPageFrame()
54:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
55:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
56:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
57:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
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
68: 
69:         CATCH TO loException
70:             MostrarErro("Erro ao inicializar FormUpd:" + CHR(13) + ;
71:                 loException.Message + CHR(13) + ;
72:                 "Linha: " + TRANSFORM(loException.LineNo), ;
73:                 "FormUpd.InicializarForm")
74:         ENDTRY
75: 
76:         RETURN loc_lSucesso
77:     ENDPROC
78: 
79:     *===========================================================================
80:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
81:     * Top=-29 para esconder abas; controles compensam +29 no Top
82:     *===========================================================================
83:     PROTECTED PROCEDURE ConfigurarPageFrame()
84:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
85: 
86:         WITH THIS.pgf_4c_Paginas
87:             .PageCount = 2
88:             .Top       = -29
89:             .Left      = 0
90:             .Width     = THIS.Width
91:             .Height    = THIS.Height + 29
92:             .Tabs      = .F.
93:             .Visible   = .T.
94: 
95:             .Page1.Caption   = "Lista"
96:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
97:             .Page1.BackColor = RGB(255, 255, 255)
98: 
99:             .Page2.Caption   = "Dados"
100:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101:             .Page2.BackColor = RGB(255, 255, 255)
102:         ENDWITH
103: 
104:         THIS.ConfigurarPaginaLista()
105:         THIS.ConfigurarPaginaDados()
106:     ENDPROC
107: 
108:     *===========================================================================
109:     * ConfigurarPaginaLista - Configura Page1 com Grid e botoes CRUD completos
110:     * Colunas do grid (cursor_4c_Dados do UpdBO.Buscar): codigos, uniprdts,
111:     * descrs, ordems - transcrito de SIGCDUPD.Init() (AddCursor/pColuna)
112:     *===========================================================================
113:     PROTECTED PROCEDURE ConfigurarPaginaLista()
114:         LOCAL loc_oPagina
115:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
116: 
117:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
118: 
119:         *-- Container Cabecalho (cntSombra no legado) - PRIMEIRO AddObject da pagina
120:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
121:         WITH loc_oPagina.cnt_4c_Cabecalho
122:             .Top         = 29
123:             .Left        = 0
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
152:             .Width     = 769
153:             .Height    = 46

*-- Linhas 196 a 418:
196:             .AutoSize        = .F.
197:             .Visible         = .T.
198:         ENDWITH
199:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
200: 
201:         *-- Botao Visualizar (Left=80)
202:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
203:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
204:             .Caption         = "Visualizar"
205:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
206:             .PicturePosition = 13
207:             .Top             = 5
208:             .Left            = 80
209:             .Width           = 75
210:             .Height          = 75
211:             .FontName        = "Tahoma"
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
226:         *-- Botao Alterar (Left=155)
227:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
228:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
229:             .Caption         = "Alterar"
230:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
231:             .PicturePosition = 13
232:             .Top             = 5
233:             .Left            = 155
234:             .Width           = 75
235:             .Height          = 75
236:             .FontName        = "Tahoma"
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
251:         *-- Botao Excluir (Left=230)
252:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
253:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
254:             .Caption         = "Excluir"
255:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
256:             .PicturePosition = 13
257:             .Top             = 5
258:             .Left            = 230
259:             .Width           = 75
260:             .Height          = 75
261:             .FontName        = "Tahoma"
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
276:         *-- Botao Buscar (Left=305)
277:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
278:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
279:             .Caption         = "Buscar"
280:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
281:             .PicturePosition = 13
282:             .Top             = 5
283:             .Left            = 305
284:             .Width           = 75
285:             .Height          = 75
286:             .FontName        = "Tahoma"
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
301:         *-- Container Saida - PADRAO CANONICO (prevalece sobre legado per CLAUDE.md regra #10)
302:         *-- Legado: Grupo_Saida.Left=726, Top=0. Canonico: Left=917, Top=29, Width=90
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
314:         *-- Botao Encerrar - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
315:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
316:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
317:             .Caption         = "Encerrar"
318:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
319:             .PicturePosition = 13
320:             .Top             = 5
321:             .Left            = 5
322:             .Width           = 75
323:             .Height          = 75
324:             .FontName        = "Tahoma"
325:             .FontBold        = .T.
326:             .FontItalic      = .T.
327:             .FontSize        = 8
328:             .ForeColor       = RGB(90, 90, 90)
329:             .BackColor       = RGB(255, 255, 255)
330:             .Themes          = .F.
331:             .SpecialEffect   = 0
332:             .MousePointer    = 15
333:             .WordWrap        = .T.
334:             .AutoSize        = .F.
335:             .Visible         = .T.
336:         ENDWITH
337:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
338: 
339:         *-- Grid de listagem de unidades produtivas
340:         *-- Original: Grade.Top=88, Left varia (Framework padrao)
341:         *-- Canonico framework: Top=117 (88+29 compensacao), Left=26, Width=880, Height=498
342:         *-- Width=880: nao sobrepoe cnt_4c_Saida (Left=917), margem de 11px
343:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
344:         *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
345:         loc_oPagina.grd_4c_Lista.ColumnCount = 4
346:         WITH loc_oPagina.grd_4c_Lista
347:             .Top                = 117
348:             .Left               = 26
349:             .Width              = 880
350:             .Height             = 498
351:             .FontName           = "Verdana"
352:             .FontSize           = 8
353:             .ForeColor          = RGB(90, 90, 90)
354:             .BackColor          = RGB(255, 255, 255)
355:             .GridLineColor      = RGB(238, 238, 238)
356:             .HighlightBackColor = RGB(255, 255, 255)
357:             .HighlightForeColor = RGB(15, 41, 104)
358:             .HighlightStyle     = 2
359:             .DeleteMark         = .F.
360:             .RecordMark         = .F.
361:             .RowHeight          = 16
362:             .ScrollBars         = 2
363:             .GridLines          = 3
364:             .Visible            = .T.
365:         ENDWITH
366:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
367: 
368:         THIS.TornarControlesVisiveis(loc_oPagina)
369:     ENDPROC
370: 
371:     *===========================================================================
372:     * CarregarLista - Carrega dados no grid da Page1
373:     * OBRIGATORIO: Reconfigura ControlSource e Headers APOS RecordSource (Problema 2/48)
374:     * OBRIGATORIO: RecordSource FORA do WITH (Problema 36)
375:     * Colunas transcritas de SIGCDUPD.Init(): Codigos="Fase", UniPrdts=
376:     * "Unid. Produtiva", Descrs="Descricao", Ordems="Ordem"
377:     *===========================================================================
378:     PROCEDURE CarregarLista()
379:         LOCAL loc_lResultado, loc_oGrid
380:         loc_lResultado = .F.
381: 
382:         TRY
383:             IF !THIS.this_oBusinessObject.Buscar("")
384:                 loc_lResultado = .F.
385:             ELSE
386:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
387: 
388:                 *-- PROBLEMA 48: RecordSource ANTES de ControlSource (FORA do WITH per Problema 36)
389:                 loc_oGrid.ColumnCount = 4
390:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
391: 
392:                 *-- PROBLEMA 48: ControlSource APOS RecordSource (auto-bind seria sobrescrito)
393:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
394:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.uniprdts"
395:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.descrs"
396:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.ordems"
397: 
398:                 loc_oGrid.Column1.Width = 80
399:                 loc_oGrid.Column2.Width = 150
400:                 loc_oGrid.Column3.Width = 590
401:                 loc_oGrid.Column4.Width = 60
402: 
403:                 *-- PROBLEMA 2/32: Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
404:                 loc_oGrid.Column1.Header1.Caption = "Fase"
405:                 loc_oGrid.Column2.Header1.Caption = "Unid. Produtiva"
406:                 loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
407:                 loc_oGrid.Column4.Header1.Caption = "Ordem"
408: 
409:                 THIS.FormatarGridLista(loc_oGrid)
410:                 loc_lResultado = .T.
411:             ENDIF
412: 
413:         CATCH TO loException
414:             MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message + CHR(13) + ;
415:                 "Linha: " + TRANSFORM(loException.LineNo), ;
416:                 "FormUpd.CarregarLista")
417:             loc_lResultado = .F.
418:         ENDTRY

*-- Linhas 424 a 690:
424:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
425:     * Ao voltar para Page1, recarrega a lista
426:     *===========================================================================
427:     PROCEDURE AlternarPagina(par_nPagina)
428:         LOCAL loc_lResultado
429:         loc_lResultado = .F.
430: 
431:         TRY
432:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
433:                 MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
434:             ELSE
435:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
436: 
437:                 IF par_nPagina = 1
438:                     THIS.this_cModoAtual = "LISTA"
439:                     THIS.CarregarLista()
440:                 ENDIF
441: 
442:                 loc_lResultado = .T.
443:             ENDIF
444: 
445:         CATCH TO loException
446:             MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, ;
447:                 "FormUpd.AlternarPagina")
448:         ENDTRY
449: 
450:         RETURN loc_lResultado
451:     ENDPROC
452: 
453:     *===========================================================================
454:     * FormatarGridLista - Formata visual do grid de lista (FontName/FontSize)
455:     *===========================================================================
456:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
457:         TRY
458:             WITH par_oGrid
459:                 .FontName = "Tahoma"
460:                 .FontSize = 8
461:             ENDWITH
462:         CATCH TO loException
463:             MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
464:                 "FormUpd.FormatarGridLista")
465:         ENDTRY
466:     ENDPROC
467: 
468:     *===========================================================================
469:     * BtnIncluirClick - Abre Page2 para incluir novo registro
470:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
471:     *===========================================================================
472:     PROCEDURE BtnIncluirClick()
473:         THIS.this_oBusinessObject.NovoRegistro()
474:         THIS.LimparCampos()
475:         THIS.this_cModoAtual = "INCLUIR"
476:         THIS.HabilitarCampos(.T.)
477:         THIS.AlternarPagina(2)
478:         THIS.AjustarBotoesPorModo()
479:     ENDPROC
480: 
481:     *===========================================================================
482:     * BtnVisualizarClick - Abre Page2 em modo somente leitura
483:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
484:     *===========================================================================
485:     PROCEDURE BtnVisualizarClick()
486:         LOCAL loc_cIdChaves
487:         loc_cIdChaves = ""
488: 
489:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
490:             SELECT cursor_4c_Dados
491:             loc_cIdChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
492:         ENDIF
493: 
494:         IF EMPTY(loc_cIdChaves)
495:             MsgAviso("Selecione um registro para visualizar.")
496:         ELSE
497:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
498:                 THIS.BOParaForm()
499:                 THIS.this_cModoAtual = "VISUALIZAR"
500:                 THIS.HabilitarCampos(.F.)
501:                 THIS.AlternarPagina(2)
502:                 THIS.AjustarBotoesPorModo()
503:             ENDIF
504:         ENDIF
505:     ENDPROC
506: 
507:     *===========================================================================
508:     * BtnAlterarClick - Abre Page2 para alterar registro selecionado
509:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
510:     *===========================================================================
511:     PROCEDURE BtnAlterarClick()
512:         LOCAL loc_cIdChaves
513:         loc_cIdChaves = ""
514: 
515:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
516:             SELECT cursor_4c_Dados
517:             loc_cIdChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
518:         ENDIF
519: 
520:         IF EMPTY(loc_cIdChaves)
521:             MsgAviso("Selecione um registro para alterar.")
522:         ELSE
523:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
524:                 THIS.this_oBusinessObject.EditarRegistro()
525:                 THIS.BOParaForm()
526:                 THIS.this_cModoAtual = "ALTERAR"
527:                 THIS.HabilitarCampos(.T.)
528:                 THIS.AlternarPagina(2)
529:                 THIS.AjustarBotoesPorModo()
530:             ENDIF
531:         ENDIF
532:     ENDPROC
533: 
534:     *===========================================================================
535:     * BtnExcluirClick - Exclui registro selecionado com confirmacao
536:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
537:     *===========================================================================
538:     PROCEDURE BtnExcluirClick()
539:         LOCAL loc_cIdChaves, loc_cFase
540:         loc_cIdChaves = ""
541:         loc_cFase     = ""
542: 
543:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
544:             SELECT cursor_4c_Dados
545:             loc_cIdChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
546:             loc_cFase     = ALLTRIM(cursor_4c_Dados.codigos) + "/" + ALLTRIM(cursor_4c_Dados.uniprdts)
547:         ENDIF
548: 
549:         IF EMPTY(loc_cIdChaves)
550:             MsgAviso("Selecione um registro para excluir.")
551:         ELSE
552:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
553:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da unidade produtiva [" + loc_cFase + "]?", ;
554:                     "Confirmar Exclus" + CHR(227) + "o")
555:                     IF THIS.this_oBusinessObject.Excluir()
556:                         MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
557:                         THIS.CarregarLista()
558:                     ENDIF
559:                 ENDIF
560:             ENDIF
561:         ENDIF
562:     ENDPROC
563: 
564:     *===========================================================================
565:     * BtnBuscarClick - Abre picker para localizar registro na lista
566:     * Apos selecao, posiciona o cursor no registro encontrado
567:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
568:     *===========================================================================
569:     PROCEDURE BtnBuscarClick()
570:         LOCAL loc_oBusca, loc_cCodigo
571:         loc_cCodigo = ""
572: 
573:         TRY
574:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
575:                 "SigCdGcr", "cursor_4c_BuscaUpd", "Codigos", "", ;
576:                 "Buscar Fase")
577: 
578:             IF VARTYPE(loc_oBusca) = "O"
579:                 loc_oBusca.mAddColuna("Codigos", "", "Fase")
580:                 loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
581:                 loc_oBusca.Show()
582: 
583:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUpd")
584:                     SELECT cursor_4c_BuscaUpd
585:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaUpd.Codigos)
586:                 ENDIF
587: 
588:                 loc_oBusca.Release()
589:             ENDIF
590: 
591:             IF USED("cursor_4c_BuscaUpd")
592:                 USE IN cursor_4c_BuscaUpd
593:             ENDIF
594: 
595:             IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
596:                 SELECT cursor_4c_Dados
597:                 LOCATE FOR ALLTRIM(codigos) == loc_cCodigo
598:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
599:             ENDIF
600: 
601:         CATCH TO loException
602:             MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "FormUpd.BtnBuscarClick")
603:             IF USED("cursor_4c_BuscaUpd")
604:                 USE IN cursor_4c_BuscaUpd
605:             ENDIF
606:         ENDTRY
607:     ENDPROC
608: 
609:     *===========================================================================
610:     * BtnEncerrarClick - Fecha o formulario
611:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
612:     *===========================================================================
613:     PROCEDURE BtnEncerrarClick()
614:         THIS.Release()
615:     ENDPROC
616: 
617:     *===========================================================================
618:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
619:     * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)
620:     *===========================================================================
621:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
622:         LOCAL loc_nI, loc_oObjeto, loc_nP
623: 
624:         FOR loc_nI = 1 TO par_oContainer.ControlCount
625:             loc_oObjeto = par_oContainer.Controls(loc_nI)
626: 
627:             IF VARTYPE(loc_oObjeto) = "O"
628:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
629:                     loc_oObjeto.Visible = .T.
630:                 ENDIF
631: 
632:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
633:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
634:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
635:                     ENDFOR
636:                 ENDIF
637: 
638:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
639:                     THIS.TornarControlesVisiveis(loc_oObjeto)
640:                 ENDIF
641:             ENDIF
642:         ENDFOR
643:     ENDPROC
644: 
645:     *===========================================================================
646:     * ConfigurarPaginaDados - Estrutura base de Page2 (Dados)
647:     * Campos e botoes de acao sao adicionados nas proximas fases - aqui ficam
648:     * apenas os containers vazios (cabecalho + moldura de botoes de acao)
649:     *===========================================================================
650:     PROTECTED PROCEDURE ConfigurarPaginaDados()
651:         LOCAL loc_oPagina
652:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
653: 
654:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
655: 
656:         *-- Container Cabecalho (faixa nas DUAS paginas - CLAUDE.md regra #11)
657:         *-- PRIMEIRO AddObject da pagina
658:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
659:         WITH loc_oPagina.cnt_4c_Cabecalho
660:             .Top         = 29
661:             .Left        = 0
662:             .Width       = THIS.Width
663:             .Height      = 80
664:             .BackColor   = RGB(100, 100, 100)
665:             .BorderWidth = 0
666:             .Visible     = .T.
667:         ENDWITH
668: 
669:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
670:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
671:             .Caption   = THIS.Caption
672:             .Top       = 15
673:             .Left      = 10
674:             .Width     = 769
675:             .Height    = 40
676:             .FontName  = "Tahoma"
677:             .FontSize  = 16
678:             .FontBold  = .T.
679:             .ForeColor = RGB(0, 0, 0)
680:             .BackStyle = 0
681:             .AutoSize  = .F.
682:             .Visible   = .T.
683:         ENDWITH
684: 
685:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
686:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
687:             .Caption   = THIS.Caption
688:             .Top       = 18
689:             .Left      = 10
690:             .Width     = 769

*-- Linhas 750 a 821:
750:             .Visible       = .T.
751:         ENDWITH
752:         *-- Lookup Fase (SigCdGcr, filtro GerBals=1) - transcrito de getCodigos.Valid
753:         BINDEVENT(loc_oPagina.txt_4c_Codigo, "KeyPress", THIS, "CodigoLostFocus")
754:         BINDEVENT(loc_oPagina.txt_4c_Codigo, "KeyPress",  THIS, "CodigoKeyPress")
755:         BINDEVENT(loc_oPagina.txt_4c_Codigo, "DblClick",  THIS, "CodigoDblClick")
756: 
757:         *-- Descricao da Fase: preenchida pelo lookup OU digitada para buscar
758:         *-- a Fase pela descricao (legado: When = Empty(getCodigos.Value)).
759:         *-- Enabled alternado dinamicamente por AtualizarEstadoDescricao()
760:         *-- em vez de ReadOnly fixo, para preservar a busca reversa do legado.
761:         loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
762:         WITH loc_oPagina.txt_4c_Descricao
763:             .Value         = ""
764:             .Top           = 234
765:             .Left          = 383
766:             .Width         = 194
767:             .Height        = 23
768:             .FontName      = "Tahoma"
769:             .FontSize      = 8
770:             .ForeColor     = RGB(90, 90, 90)
771:             .BackColor     = RGB(255, 255, 255)
772:             .BorderStyle   = 1
773:             .SpecialEffect = 0
774:             .MaxLength     = 20
775:             .Enabled       = .T.
776:             .Visible       = .T.
777:         ENDWITH
778:         *-- Lookup reverso por Descricao - transcrito de GetDescrs.Valid
779:         BINDEVENT(loc_oPagina.txt_4c_Descricao, "KeyPress", THIS, "DescricaoLostFocus")
780:         BINDEVENT(loc_oPagina.txt_4c_Descricao, "KeyPress",  THIS, "DescricaoKeyPress")
781:         BINDEVENT(loc_oPagina.txt_4c_Descricao, "DblClick",  THIS, "DescricaoDblClick")
782: 
783:         *===================================================================
784:         * CAMPOS - LINHA 2: Unidade Produtiva
785:         * Legado: Say2.Top=233/Left=193, getUnidade.Top=230/Left=297/Width=84
786:         *===================================================================
787:         loc_oPagina.AddObject("lbl_4c_UnidadeProdutiva", "Label")
788:         WITH loc_oPagina.lbl_4c_UnidadeProdutiva
789:             .Caption   = "Unidade Produtiva :"
790:             .Top       = 262
791:             .Left      = 193
792:             .Width     = 100
793:             .Height    = 17
794:             .AutoSize  = .F.
795:             .FontName  = "Tahoma"
796:             .FontSize  = 8
797:             .ForeColor = RGB(90, 90, 90)
798:             .BackStyle = 0
799:             .Alignment = 0
800:             .Visible   = .T.
801:         ENDWITH
802: 
803:         loc_oPagina.AddObject("txt_4c_UnidadeProdutiva", "TextBox")
804:         WITH loc_oPagina.txt_4c_UnidadeProdutiva
805:             .Value         = ""
806:             .Top           = 259
807:             .Left          = 297
808:             .Width         = 84
809:             .Height        = 23
810:             .FontName      = "Tahoma"
811:             .FontSize      = 8
812:             .ForeColor     = RGB(90, 90, 90)
813:             .BackColor     = RGB(255, 255, 255)
814:             .BorderStyle   = 1
815:             .SpecialEffect = 0
816:             .MaxLength     = 10
817:             .Visible       = .T.
818:         ENDWITH
819: 
820:         *===================================================================
821:         * CAMPOS - LINHA 3: Quantidade

*-- Linhas 949 a 992:
949:             .Visible       = .T.
950:         ENDWITH
951:         *-- Validacao transcrita de get_ddf.Valid: Dias por Semana entre 0 e 7
952:         BINDEVENT(loc_oPagina.txt_4c_DiasPorSemana, "KeyPress", THIS, "DiasPorSemanaLostFocus")
953: 
954:         loc_oPagina.AddObject("lbl_4c_1a7", "Label")
955:         WITH loc_oPagina.lbl_4c_1a7
956:             .Caption   = "(1-7)"
957:             .Top       = 339
958:             .Left      = 318
959:             .Width     = 26
960:             .Height    = 15
961:             .AutoSize  = .F.
962:             .FontName  = "Tahoma"
963:             .FontSize  = 8
964:             .ForeColor = RGB(90, 90, 90)
965:             .BackStyle = 0
966:             .Alignment = 0
967:             .Visible   = .T.
968:         ENDWITH
969: 
970:         *===================================================================
971:         * CAMPOS - LINHA 6: Ordem no Mapa
972:         * Legado: Say4.Top=334/Left=205, GET_ORDEM.Top=331/Left=297/Width=24
973:         * InputMask="99" (ordems numeric(2,0))
974:         *===================================================================
975:         loc_oPagina.AddObject("lbl_4c_OrdemMapa", "Label")
976:         WITH loc_oPagina.lbl_4c_OrdemMapa
977:             .Caption   = "Ordem no Mapa :"
978:             .Top       = 363
979:             .Left      = 205
980:             .Width     = 100
981:             .Height    = 17
982:             .AutoSize  = .F.
983:             .FontName  = "Tahoma"
984:             .FontSize  = 8
985:             .ForeColor = RGB(90, 90, 90)
986:             .BackStyle = 0
987:             .Alignment = 0
988:             .Visible   = .T.
989:         ENDWITH
990: 
991:         loc_oPagina.AddObject("txt_4c_Ordem", "TextBox")
992:         WITH loc_oPagina.txt_4c_Ordem

*-- Linhas 1031 a 1460:
1031:             .AutoSize        = .F.
1032:             .Visible         = .T.
1033:         ENDWITH
1034:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
1035: 
1036:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
1037:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
1038:             .Caption         = "Encerrar"
1039:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
1040:             .PicturePosition = 13
1041:             .Top             = 5
1042:             .Left            = 80
1043:             .Width           = 75
1044:             .Height          = 75
1045:             .FontName        = "Tahoma"
1046:             .FontBold        = .T.
1047:             .FontItalic      = .T.
1048:             .FontSize        = 8
1049:             .ForeColor       = RGB(90, 90, 90)
1050:             .BackColor       = RGB(255, 255, 255)
1051:             .Themes          = .F.
1052:             .SpecialEffect   = 0
1053:             .MousePointer    = 15
1054:             .WordWrap        = .T.
1055:             .AutoSize        = .F.
1056:             .Visible         = .T.
1057:         ENDWITH
1058:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
1059: 
1060:         THIS.TornarControlesVisiveis(loc_oPagina)
1061:     ENDPROC
1062: 
1063:     *===========================================================================
1064:     * FormParaBO - Transfere valores do Form (Page2) para o Business Object
1065:     * PUBLIC: chamado por BtnSalvarClick (BINDEVENT no botao Confirmar)
1066:     *===========================================================================
1067:     PROCEDURE FormParaBO()
1068:         LOCAL loc_oPagina
1069:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1070: 
1071:         WITH THIS.this_oBusinessObject
1072:             .this_cCodigo           = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
1073:             .this_cUnidadeProdutiva = ALLTRIM(loc_oPagina.txt_4c_UnidadeProdutiva.Value)
1074:             .this_nQuantidade       = loc_oPagina.txt_4c_Quantidade.Value
1075:             .this_nHorasDia         = loc_oPagina.txt_4c_HorasPorDia.Value
1076:             .this_nDiasSemana       = loc_oPagina.txt_4c_DiasPorSemana.Value
1077:             .this_nOrdem            = loc_oPagina.txt_4c_Ordem.Value
1078:         ENDWITH
1079:     ENDPROC
1080: 
1081:     *===========================================================================
1082:     * BOParaForm - Transfere valores do Business Object para o Form (Page2)
1083:     * this_cDescricaoFase vem do JOIN com SigCdGcr (BO.CarregarDoCursor)
1084:     * PUBLIC: chamado por BtnVisualizarClick/BtnAlterarClick
1085:     *===========================================================================
1086:     PROCEDURE BOParaForm()
1087:         LOCAL loc_oPagina
1088:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1089: 
1090:         WITH THIS.this_oBusinessObject
1091:             loc_oPagina.txt_4c_Codigo.Value           = .this_cCodigo
1092:             loc_oPagina.txt_4c_Descricao.Value        = .this_cDescricaoFase
1093:             loc_oPagina.txt_4c_UnidadeProdutiva.Value = .this_cUnidadeProdutiva
1094:             loc_oPagina.txt_4c_Quantidade.Value       = .this_nQuantidade
1095:             loc_oPagina.txt_4c_HorasPorDia.Value      = .this_nHorasDia
1096:             loc_oPagina.txt_4c_DiasPorSemana.Value    = .this_nDiasSemana
1097:             loc_oPagina.txt_4c_Ordem.Value             = .this_nOrdem
1098:         ENDWITH
1099: 
1100:         THIS.this_cUltimoCodigoFaseValidado    = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
1101:         THIS.this_cUltimaDescricaoFaseValidada = ALLTRIM(loc_oPagina.txt_4c_Descricao.Value)
1102:         THIS.AtualizarEstadoDescricao()
1103:     ENDPROC
1104: 
1105:     *===========================================================================
1106:     * LimparCampos - Limpa os campos da Page2 (usado no modo INCLUIR)
1107:     * PUBLIC: chamado por BtnIncluirClick
1108:     *===========================================================================
1109:     PROCEDURE LimparCampos()
1110:         LOCAL loc_oPagina
1111:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1112: 
1113:         loc_oPagina.txt_4c_Codigo.Value           = ""
1114:         loc_oPagina.txt_4c_Descricao.Value        = ""
1115:         loc_oPagina.txt_4c_UnidadeProdutiva.Value = ""
1116:         loc_oPagina.txt_4c_Quantidade.Value       = 0
1117:         loc_oPagina.txt_4c_HorasPorDia.Value      = 0
1118:         loc_oPagina.txt_4c_DiasPorSemana.Value    = 0
1119:         loc_oPagina.txt_4c_Ordem.Value            = 0
1120: 
1121:         THIS.this_cUltimoCodigoFaseValidado    = ""
1122:         THIS.this_cUltimaDescricaoFaseValidada = ""
1123:         THIS.AtualizarEstadoDescricao()
1124:     ENDPROC
1125: 
1126:     *===========================================================================
1127:     * HabilitarCampos - Habilita/desabilita os campos de dados da Page2
1128:     * Transcrito das clausulas When do legado: getCodigos/getUnidade permitem
1129:     * INSERIR/ALTERAR/PROCURAR; GET_ORDEM/GetQtdes/get_ddr/get_ddf permitem
1130:     * apenas INSERIR/ALTERAR - ou seja, em CONSULTAR (Visualizar) a tela
1131:     * inteira fica somente leitura. cmd_4c_Confirmar tambem eh desabilitado
1132:     * em Visualizar (nao ha nada a gravar).
1133:     *===========================================================================
1134:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1135:         LOCAL loc_oPagina
1136:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1137: 
1138:         loc_oPagina.txt_4c_Codigo.Enabled                       = par_lHabilitar
1139:         loc_oPagina.txt_4c_UnidadeProdutiva.Enabled             = par_lHabilitar
1140:         loc_oPagina.txt_4c_Quantidade.Enabled                   = par_lHabilitar
1141:         loc_oPagina.txt_4c_HorasPorDia.Enabled                  = par_lHabilitar
1142:         loc_oPagina.txt_4c_DiasPorSemana.Enabled                = par_lHabilitar
1143:         loc_oPagina.txt_4c_Ordem.Enabled                        = par_lHabilitar
1144:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled  = par_lHabilitar
1145: 
1146:         IF par_lHabilitar
1147:             THIS.AtualizarEstadoDescricao()
1148:         ELSE
1149:             loc_oPagina.txt_4c_Descricao.Enabled = .F.
1150:         ENDIF
1151:     ENDPROC
1152: 
1153:     *===========================================================================
1154:     * AjustarBotoesPorModo - Habilita/desabilita Confirmar e posiciona o foco
1155:     * conforme this_cModoAtual (INCLUIR/ALTERAR/VISUALIZAR)
1156:     * PUBLIC: chamado diretamente por TesteAutomatico.prg (CLAUDE.md regra #3)
1157:     *===========================================================================
1158:     PROCEDURE AjustarBotoesPorModo()
1159:         LOCAL loc_oPg2
1160:         TRY
1161:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1162: 
1163:             DO CASE
1164:                 CASE THIS.this_cModoAtual = "INCLUIR"
1165:                     loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
1166:                     IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
1167:                         loc_oPg2.txt_4c_Codigo.SetFocus()
1168:                     ENDIF
1169:                 CASE THIS.this_cModoAtual = "ALTERAR"
1170:                     loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
1171:                     IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
1172:                         loc_oPg2.txt_4c_UnidadeProdutiva.SetFocus()
1173:                     ENDIF
1174:                 OTHERWISE
1175:                     loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
1176:                     IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
1177:                         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus()
1178:                     ENDIF
1179:             ENDCASE
1180:         CATCH TO loException
1181:             MostrarErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + loException.Message, ;
1182:                 "FormUpd.AjustarBotoesPorModo")
1183:         ENDTRY
1184:     ENDPROC
1185: 
1186:     *===========================================================================
1187:     * AtualizarEstadoDescricao - Alterna Enabled de txt_4c_Descricao
1188:     * Transcrito de GetDescrs.When: Return(... And Empty(getCodigos.Value))
1189:     * so permite digitar/buscar pela Descricao quando o Codigo esta vazio
1190:     *===========================================================================
1191:     PROTECTED PROCEDURE AtualizarEstadoDescricao()
1192:         LOCAL loc_oPagina
1193:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1194:         loc_oPagina.txt_4c_Descricao.Enabled = EMPTY(ALLTRIM(loc_oPagina.txt_4c_Codigo.Value))
1195:     ENDPROC
1196: 
1197:     *===========================================================================
1198:     * AbrirLookupFase - Lookup de Fase por Codigo (SigCdGcr, GerBals=1)
1199:     * Transcrito de getCodigos.Valid: busca exata primeiro; se nao achar,
1200:     * abre o picker (FormBuscaAuxiliar). Preenche Codigo E Descricao.
1201:     *===========================================================================
1202:     PROTECTED PROCEDURE AbrirLookupFase()
1203:         LOCAL loc_oBusca, loc_oPagina, loc_cValor
1204:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1205: 
1206:         IF !loc_oPagina.txt_4c_Codigo.Enabled
1207:             RETURN
1208:         ENDIF
1209: 
1210:         loc_cValor = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
1211: 
1212:         TRY
1213:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1214:                 "SigCdGcr", "cursor_4c_BuscaFase", "Codigos", loc_cValor, ;
1215:                 "Fases", .F., .F., "GerBals = 1")
1216: 
1217:             IF VARTYPE(loc_oBusca) = "O"
1218:                 IF !loc_oBusca.this_lAchouRegistro
1219:                     loc_oBusca.mAddColuna("Codigos", "", "Fase")
1220:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1221:                     loc_oBusca.Show()
1222:                 ENDIF
1223: 
1224:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFase")
1225:                     SELECT cursor_4c_BuscaFase
1226:                     loc_oPagina.txt_4c_Codigo.Value    = ALLTRIM(cursor_4c_BuscaFase.Codigos)
1227:                     loc_oPagina.txt_4c_Descricao.Value = ALLTRIM(cursor_4c_BuscaFase.Descrs)
1228:                     THIS.this_cUltimoCodigoFaseValidado = ALLTRIM(cursor_4c_BuscaFase.Codigos)
1229:                 ELSE
1230:                     loc_oPagina.txt_4c_Codigo.Value     = ""
1231:                     loc_oPagina.txt_4c_Descricao.Value  = ""
1232:                     THIS.this_cUltimoCodigoFaseValidado = ""
1233:                 ENDIF
1234: 
1235:                 loc_oBusca.Release()
1236:             ENDIF
1237: 
1238:             IF USED("cursor_4c_BuscaFase")
1239:                 USE IN cursor_4c_BuscaFase
1240:             ENDIF
1241: 
1242:         CATCH TO loException
1243:             MostrarErro("Erro ao buscar Fase:" + CHR(13) + loException.Message, "FormUpd.AbrirLookupFase")
1244:             IF USED("cursor_4c_BuscaFase")
1245:                 USE IN cursor_4c_BuscaFase
1246:             ENDIF
1247:         ENDTRY
1248: 
1249:         THIS.AtualizarEstadoDescricao()
1250:     ENDPROC
1251: 
1252:     *===========================================================================
1253:     * CodigoLostFocus - Dispara o lookup de Fase ao sair do campo (Problema 45:
1254:     * guarda contra reabrir o picker quando o valor nao mudou)
1255:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
1256:     *===========================================================================
1257:     PROCEDURE CodigoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1258:         LOCAL loc_cValor
1259:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.Value)
1260: 
1261:         IF loc_cValor == THIS.this_cUltimoCodigoFaseValidado
1262:             RETURN
1263:         ENDIF
1264:         THIS.this_cUltimoCodigoFaseValidado = loc_cValor
1265: 
1266:         IF EMPTY(loc_cValor)
1267:             RETURN
1268:         ENDIF
1269: 
1270:         THIS.AbrirLookupFase()
1271:     ENDPROC
1272: 
1273:     *===========================================================================
1274:     * CodigoKeyPress - F4 abre o lookup de Fase explicitamente
1275:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
1276:     *===========================================================================
1277:     PROCEDURE CodigoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1278:         IF par_nKeyCode = 28
1279:             THIS.AbrirLookupFase()
1280:         ENDIF
1281:     ENDPROC
1282: 
1283:     *===========================================================================
1284:     * CodigoDblClick - Duplo clique abre o lookup de Fase
1285:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
1286:     *===========================================================================
1287:     PROCEDURE CodigoDblClick()
1288:         THIS.AbrirLookupFase()
1289:     ENDPROC
1290: 
1291:     *===========================================================================
1292:     * AbrirLookupFasePorDescricao - Lookup de Fase por Descricao (SigCdGcr,
1293:     * GerBals=1). Transcrito de GetDescrs.Valid - busca reversa: preenche
1294:     * Descricao E Codigo.
1295:     *===========================================================================
1296:     PROTECTED PROCEDURE AbrirLookupFasePorDescricao()
1297:         LOCAL loc_oBusca, loc_oPagina, loc_cValor
1298:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1299: 
1300:         IF !loc_oPagina.txt_4c_Descricao.Enabled
1301:             RETURN
1302:         ENDIF
1303: 
1304:         loc_cValor = ALLTRIM(loc_oPagina.txt_4c_Descricao.Value)
1305: 
1306:         TRY
1307:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1308:                 "SigCdGcr", "cursor_4c_BuscaFaseDesc", "Descrs", loc_cValor, ;
1309:                 "Fases", .F., .F., "GerBals = 1")
1310: 
1311:             IF VARTYPE(loc_oBusca) = "O"
1312:                 IF !loc_oBusca.this_lAchouRegistro
1313:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1314:                     loc_oBusca.mAddColuna("Codigos", "", "Fase")
1315:                     loc_oBusca.Show()
1316:                 ENDIF
1317: 
1318:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFaseDesc")
1319:                     SELECT cursor_4c_BuscaFaseDesc
1320:                     loc_oPagina.txt_4c_Descricao.Value     = ALLTRIM(cursor_4c_BuscaFaseDesc.Descrs)
1321:                     loc_oPagina.txt_4c_Codigo.Value         = ALLTRIM(cursor_4c_BuscaFaseDesc.Codigos)
1322:                     THIS.this_cUltimaDescricaoFaseValidada = ALLTRIM(cursor_4c_BuscaFaseDesc.Descrs)
1323:                     THIS.this_cUltimoCodigoFaseValidado    = ALLTRIM(cursor_4c_BuscaFaseDesc.Codigos)
1324:                 ELSE
1325:                     loc_oPagina.txt_4c_Descricao.Value     = ""
1326:                     THIS.this_cUltimaDescricaoFaseValidada = ""
1327:                 ENDIF
1328: 
1329:                 loc_oBusca.Release()
1330:             ENDIF
1331: 
1332:             IF USED("cursor_4c_BuscaFaseDesc")
1333:                 USE IN cursor_4c_BuscaFaseDesc
1334:             ENDIF
1335: 
1336:         CATCH TO loException
1337:             MostrarErro("Erro ao buscar Fase por descri" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
1338:                 loException.Message, "FormUpd.AbrirLookupFasePorDescricao")
1339:             IF USED("cursor_4c_BuscaFaseDesc")
1340:                 USE IN cursor_4c_BuscaFaseDesc
1341:             ENDIF
1342:         ENDTRY
1343: 
1344:         THIS.AtualizarEstadoDescricao()
1345:     ENDPROC
1346: 
1347:     *===========================================================================
1348:     * DescricaoLostFocus - Dispara o lookup reverso ao sair do campo
1349:     * (Problema 45: guarda contra reabrir o picker quando o valor nao mudou)
1350:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
1351:     *===========================================================================
1352:     PROCEDURE DescricaoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1353:         LOCAL loc_cValor
1354: 
1355:         IF !THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.Enabled
1356:             RETURN
1357:         ENDIF
1358: 
1359:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.Value)
1360: 
1361:         IF loc_cValor == THIS.this_cUltimaDescricaoFaseValidada
1362:             RETURN
1363:         ENDIF
1364:         THIS.this_cUltimaDescricaoFaseValidada = loc_cValor
1365: 
1366:         IF EMPTY(loc_cValor)
1367:             RETURN
1368:         ENDIF
1369: 
1370:         THIS.AbrirLookupFasePorDescricao()
1371:     ENDPROC
1372: 
1373:     *===========================================================================
1374:     * DescricaoKeyPress - F4 abre o lookup reverso explicitamente
1375:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
1376:     *===========================================================================
1377:     PROCEDURE DescricaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1378:         IF par_nKeyCode = 28
1379:             THIS.AbrirLookupFasePorDescricao()
1380:         ENDIF
1381:     ENDPROC
1382: 
1383:     *===========================================================================
1384:     * DescricaoDblClick - Duplo clique abre o lookup reverso
1385:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
1386:     *===========================================================================
1387:     PROCEDURE DescricaoDblClick()
1388:         THIS.AbrirLookupFasePorDescricao()
1389:     ENDPROC
1390: 
1391:     *===========================================================================
1392:     * DiasPorSemanaLostFocus - Valida faixa 0-7 ao sair do campo
1393:     * Transcrito literalmente de get_ddf.Valid
1394:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
1395:     *===========================================================================
1396:     PROCEDURE DiasPorSemanaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1397:         LOCAL loc_oCampo
1398:         loc_oCampo = THIS.pgf_4c_Paginas.Page2.txt_4c_DiasPorSemana
1399: 
1400:         IF loc_oCampo.Value < 0 OR loc_oCampo.Value > 7
1401:             MsgAviso("A Semana s" + CHR(243) + " pode ter no m" + CHR(225) + "ximo 7 dias...")
1402:             loc_oCampo.Value = 0
1403:         ENDIF
1404:     ENDPROC
1405: 
1406:     *===========================================================================
1407:     * BtnSalvarClick - Confirma inclusao/alteracao do registro
1408:     * Transcrito de Pagina.Dados.Grupo_Salva.Salva.Click: BO.ValidarDados cobre
1409:     * o codigo obrigatorio + duplicidade (INCLUIR) + faixa de dias da semana;
1410:     * BO.DepoisDeGravar sincroniza Ordem em todas as unidades da mesma Fase.
1411:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
1412:     *===========================================================================
1413:     PROCEDURE BtnSalvarClick()
1414:         THIS.FormParaBO()
1415: 
1416:         IF THIS.this_oBusinessObject.Salvar()
1417:             MsgInfo("Registro salvo com sucesso!")
1418:             THIS.AlternarPagina(1)
1419:         ELSE
1420:             IF !THIS.this_oBusinessObject.this_lErroExibido
1421:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o registro.", "Confirmar")
1422:             ENDIF
1423:         ENDIF
1424:     ENDPROC
1425: 
1426:     *===========================================================================
1427:     * BtnCancelarClick - Cancela edicao e volta para a lista
1428:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
1429:     *===========================================================================
1430:     PROCEDURE BtnCancelarClick()
1431:         THIS.this_oBusinessObject.CancelarEdicao()
1432:         THIS.AlternarPagina(1)
1433:     ENDPROC
1434: 
1435:     *===========================================================================
1436:     * Destroy - Libera referencias do formulario
1437:     *===========================================================================
1438:     PROCEDURE Destroy()
1439:         THIS.this_oBusinessObject = .NULL.
1440: 
1441:         IF USED("cursor_4c_Dados")
1442:             USE IN cursor_4c_Dados
1443:         ENDIF
1444: 
1445:         IF USED("cursor_4c_BuscaUpd")
1446:             USE IN cursor_4c_BuscaUpd
1447:         ENDIF
1448: 
1449:         IF USED("cursor_4c_BuscaFase")
1450:             USE IN cursor_4c_BuscaFase
1451:         ENDIF
1452: 
1453:         IF USED("cursor_4c_BuscaFaseDesc")
1454:             USE IN cursor_4c_BuscaFaseDesc
1455:         ENDIF
1456: 
1457:         DODEFAULT()
1458:     ENDPROC
1459: 
1460: ENDDEFINE


### BO (C:\4c\projeto\app\classes\UpdBO.prg):
*====================================================================
* UpdBO.prg
*
* Business Object para Upd (Cadastro de Unidade Produtiva)
* Tabela: SigCdUpd (PK: cidchaves - Fortyus)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS UpdBO AS BusinessBase

	*-- Propriedades da entidade (colunas de SigCdUpd - docs/schema.sql)
	this_cIdChaves          = ""   && cidchaves char(20) - PK (Fortyus)
	this_cCodigo             = ""   && codigos   char(10) - Fase (FK SigCdGcr.Codigos)
	this_nDiasSemana         = 0    && ddsems    numeric(1,0) - Dias por Semana (0-7)
	this_nHorasDia           = 0    && hordds    numeric(4,2) - Horas Por Dia
	this_cUnidadeProdutiva   = ""   && uniprdts  char(10) - Unidade Produtiva
	this_nOrdem              = 0    && ordems    numeric(2,0) - Ordem no Mapa
	this_nQuantidade         = 0    && qtdes     numeric(2,0) - Quantidade

	*-- Propriedade de exibicao (NAO existe em SigCdUpd - vem do JOIN com
	*-- SigCdGcr.Descrs em Buscar()/CarregarPorCodigo(); NUNCA gravar esta
	*-- coluna em Inserir/Atualizar, pois SigCdUpd nao tem campo descrs)
	this_cDescricaoFase      = ""   && SigCdGcr.descrs (JOIN, somente leitura)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.
		TRY
			DODEFAULT()
			THIS.this_cTabela     = "SigCdUpd"
			THIS.this_cCampoChave = "cidchaves"
			loc_lSucesso = .T.
		CATCH TO loException
			MostrarErro(loException, "UpdBO.Init")
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	FUNCTION ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cIdChaves)
	ENDFUNC

	*====================================================================
	* CarregarDoCursor - Carrega propriedades do BO a partir de cursor
	* REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
	* this_cDescricaoFase vem do JOIN com SigCdGcr.Descrs (somente leitura)
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cIdChaves         = TratarNulo(cidchaves, "C")
				THIS.this_cCodigo           = TratarNulo(codigos,   "C")
				THIS.this_nDiasSemana       = TratarNulo(ddsems,    "N")
				THIS.this_nHorasDia         = TratarNulo(hordds,    "N")
				THIS.this_cUnidadeProdutiva = TratarNulo(uniprdts,  "C")
				THIS.this_nOrdem            = TratarNulo(ordems,    "N")
				THIS.this_nQuantidade       = TratarNulo(qtdes,     "N")
				THIS.this_cDescricaoFase    = TratarNulo(descrs,    "C")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "UpdBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ValidarDados - Valida dados antes de salvar
	* Transcrito do legado (Pagina.Dados.Grupo_Salva.Salva.Click):
	* - Codigo (Fase) obrigatorio
	* - Duplicidade Codigos+UniPrdts bloqueada SOMENTE na INCLUSAO
	* Transcrito do legado (get_ddf.Valid): Dias por Semana entre 0 e 7
	*====================================================================
	PROTECTED PROCEDURE ValidarDados()
		LOCAL loc_lValido
		loc_lValido = .T.

		IF EMPTY(ALLTRIM(THIS.this_cCodigo))
			THIS.this_cMensagemErro = "C" + CHR(243) + "digo Inv" + CHR(225) + "lido!!!"
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND (THIS.this_nDiasSemana < 0 OR THIS.this_nDiasSemana > 7)
			THIS.this_cMensagemErro = "A Semana s" + CHR(243) + " pode ter no m" + CHR(225) + "ximo 7 dias..."
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND THIS.this_lNovoRegistro
			IF THIS.VerificarUnidadeExistente(THIS.this_cCodigo, THIS.this_cUnidadeProdutiva)
				THIS.this_cMensagemErro = "Unidade J" + CHR(225) + " Cadastrada!!!"
				loc_lValido = .F.
			ENDIF
		ENDIF

		RETURN loc_lValido
	ENDPROC

	*====================================================================
	* VerificarUnidadeExistente - Verifica se ja existe registro com o
	* mesmo par Codigos+UniPrdts (transcrito de Salva.Click, ramo INSERIR)
	*====================================================================
	PROCEDURE VerificarUnidadeExistente(par_cCodigo, par_cUnidade)
		LOCAL loc_cSQL, loc_nResultado, loc_lExiste
		loc_lExiste = .F.

		TRY
			loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdUpd" + ;
				" WHERE codigos = " + EscaparSQL(par_cCodigo) + ;
				" AND uniprdts = " + EscaparSQL(par_cUnidade)
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkUpd")
			IF loc_nResultado >= 0 AND USED("cursor_4c_ChkUpd")
				SELECT cursor_4c_ChkUpd
				loc_lExiste = (cursor_4c_ChkUpd.qtd > 0)
				USE IN cursor_4c_ChkUpd
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao verificar unidade:" + CHR(13) + loException.Message, "UpdBO.VerificarUnidadeExistente")
		ENDTRY

		RETURN loc_lExiste
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro na tabela SigCdUpd
	* cidchaves (PK Fortyus) gerado via fUniqueIds() se nao vier preenchido
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(THIS.this_cIdChaves)
				THIS.this_cIdChaves = fUniqueIds()
			ENDIF

			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				INSERT INTO SigCdUpd (cidchaves, codigos, ddsems, hordds, uniprdts, ordems, qtdes)
				VALUES (
					<<EscaparSQL(THIS.this_cIdChaves)>>,
					<<EscaparSQL(THIS.this_cCodigo)>>,
					<<FormatarNumeroSQL(THIS.this_nDiasSemana, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nHorasDia, 2)>>,
					<<EscaparSQL(THIS.this_cUnidadeProdutiva)>>,
					<<FormatarNumeroSQL(THIS.this_nOrdem, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nQuantidade, 0)>>
				)
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao inserir unidade produtiva:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "UpdBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro existente na tabela SigCdUpd
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigCdUpd
				SET codigos  = <<EscaparSQL(THIS.this_cCodigo)>>,
					ddsems   = <<FormatarNumeroSQL(THIS.this_nDiasSemana, 0)>>,
					hordds   = <<FormatarNumeroSQL(THIS.this_nHorasDia, 2)>>,
					uniprdts = <<EscaparSQL(THIS.this_cUnidadeProdutiva)>>,
					ordems   = <<FormatarNumeroSQL(THIS.this_nOrdem, 0)>>,
					qtdes    = <<FormatarNumeroSQL(THIS.this_nQuantidade, 0)>>
				WHERE cidchaves = <<EscaparSQL(THIS.this_cIdChaves)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao atualizar unidade produtiva:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "UpdBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* DepoisDeGravar - Transcrito de Salva.Click (apos DoDefault()):
	* o legado sincroniza Ordems em TODAS as unidades produtivas da MESMA
	* Fase (Codigos), nao so no registro corrente - Ordem eh atributo da
	* Fase, exibido/editado em cada unidade mas compartilhado entre elas.
	*====================================================================
	PROTECTED PROCEDURE DepoisDeGravar()
		LOCAL loc_cSQL
		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigCdUpd SET ordems = <<FormatarNumeroSQL(THIS.this_nOrdem, 0)>>
				WHERE codigos = <<EscaparSQL(THIS.this_cCodigo)>>
			ENDTEXT
			SQLEXEC(gnConnHandle, loc_cSQL)
		CATCH TO loException
			MostrarErro("Erro ao sincronizar ordem:" + CHR(13) + loException.Message, "UpdBO.DepoisDeGravar")
		ENDTRY
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui registro da tabela SigCdUpd
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdUpd WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao excluir unidade produtiva:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "UpdBO.ExecutarExclusao")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Buscar - Busca registros com filtro opcional
	* Transcrito de PROCEDURE Init:
	*   Select a.*, b.Descrs From SigCdUpd a Inner Join SigCdGcr b
	*     on a.Codigos = b.Codigos
	* Retorna cursor_4c_Dados com as colunas da grade do legado
	* (Codigos="Fase", UniPrdts="Unid. Produtiva", Descrs="Descricao",
	*  Ordems="Ordem")
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
				IF !USED("cursor_4c_Dados")
					SET NULL ON
					CREATE CURSOR cursor_4c_Dados (cidchaves C(20), codigos C(10), uniprdts C(10), descrs C(40), ordems N(2,0), ddsems N(1,0), hordds N(4,2), qtdes N(2,0))
					SET NULL OFF
				ENDIF
				loc_lSucesso = .T.
			ELSE
				loc_cSQL = "SELECT a.cidchaves, a.codigos, a.uniprdts, b.descrs," + ;
					" a.ordems, a.ddsems, a.hordds, a.qtdes" + ;
					" FROM SigCdUpd a INNER JOIN SigCdGcr b ON a.codigos = b.codigos"

				IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
					loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
				ENDIF

				loc_cSQL = loc_cSQL + " ORDER BY a.codigos, a.uniprdts"

				IF USED("cursor_4c_Dados")
					USE IN cursor_4c_Dados
				ENDIF
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
				IF loc_nResultado >= 0
					loc_lSucesso = .T.
				ELSE
					MostrarErro("Erro ao buscar unidades produtivas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "UpdBO.Buscar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				SELECT a.cidchaves, a.codigos, a.uniprdts, b.descrs,
					a.ordems, a.ddsems, a.hordds, a.qtdes
				FROM SigCdUpd a INNER JOIN SigCdGcr b ON a.codigos = b.codigos
				WHERE a.cidchaves = <<EscaparSQL(par_cCodigo)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_Carrega") > 0
					loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
					THIS.this_lNovoRegistro = .F.
				ELSE
					MsgAviso("Unidade produtiva n" + CHR(227) + "o encontrada!")
				ENDIF

				IF USED("cursor_4c_Carrega")
					USE IN cursor_4c_Carrega
				ENDIF
			ELSE
				MostrarErro("Erro ao carregar unidade produtiva:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "UpdBO.CarregarPorCodigo")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

