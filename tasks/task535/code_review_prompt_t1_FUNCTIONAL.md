# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [BINDEVENT-PARAMS] Handler 'ValidarNivel' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarNivel(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormTgp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1224 linhas total):

*-- Linhas 27 a 153:
27:     *-- Propriedades de estado
28:     this_oBusinessObject       = .NULL.
29:     this_cModoAtual            = "LISTA"
30:     this_cUltimoNivelValidado  = ""
31: 
32:     *===========================================================================
33:     * Init - Inicializa o formulario
34:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
35:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
36:     *===========================================================================
37:     PROCEDURE Init()
38:         RETURN DODEFAULT()
39:     ENDPROC
40: 
41:     *===========================================================================
42:     * InicializarForm - Configura estrutura completa
43:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
44:     *===========================================================================
45:     PROTECTED PROCEDURE InicializarForm()
46:         LOCAL loc_lSucesso
47:         loc_lSucesso = .F.
48: 
49:         TRY
50:             THIS.this_oBusinessObject = CREATEOBJECT("TgpBO")
51: 
52:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
53:                 MostrarErro("Erro ao criar TgpBO" + CHR(13) + ;
54:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
55:                     "FormTgp.InicializarForm")
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
68: 
69:         CATCH TO loException
70:             MostrarErro("Erro ao inicializar FormTgp:" + CHR(13) + ;
71:                 loException.Message + CHR(13) + ;
72:                 "Linha: " + TRANSFORM(loException.LineNo), ;
73:                 "FormTgp.InicializarForm")
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
109:     * ConfigurarPaginaLista - Configura Page1 (Grid + Botoes CRUD)
110:     * REGRA CLAUDE.md #11: cnt_4c_Cabecalho DEVE ser o PRIMEIRO AddObject da pagina
111:     * REGRA CLAUDE.md #10: cnt_4c_Saida/cmd_4c_Encerrar seguem o padrao canonico
112:     *===========================================================================
113:     PROTECTED PROCEDURE ConfigurarPaginaLista()
114:         LOCAL loc_oPagina
115:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
116: 
117:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
118: 
119:         *-- Container Cabecalho (cntSombra no legado)
120:         *-- Canonico CLAUDE.md #11: Top=29, Left=0, Width=THIS.Width, Height=80
121:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
122:         WITH loc_oPagina.cnt_4c_Cabecalho
123:             .Top         = 29
124:             .Left        = 0
125:             .Width       = THIS.Width
126:             .Height      = 80
127:             .BackColor   = RGB(100, 100, 100)
128:             .BorderWidth = 0
129:             .Visible     = .T.
130:         ENDWITH
131: 
132:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
133:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
134:             .Caption   = THIS.Caption
135:             .Top       = 15
136:             .Left      = 10
137:             .Width     = THIS.Width - 20
138:             .Height    = 40
139:             .FontName  = "Tahoma"
140:             .FontSize  = 16
141:             .FontBold  = .T.
142:             .ForeColor = RGB(0, 0, 0)
143:             .BackStyle = 0
144:             .AutoSize  = .F.
145:             .Visible   = .T.
146:         ENDWITH
147: 
148:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
149:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
150:             .Caption   = THIS.Caption
151:             .Top       = 18
152:             .Left      = 10
153:             .Width     = THIS.Width - 20

*-- Linhas 197 a 594:
197:             .AutoSize        = .F.
198:             .Visible         = .T.
199:         ENDWITH
200:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
201: 
202:         *-- Botao Visualizar (Left=80)
203:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
204:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
205:             .Caption         = "Visualizar"
206:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
207:             .PicturePosition = 13
208:             .Top             = 5
209:             .Left            = 80
210:             .Width           = 75
211:             .Height          = 75
212:             .FontName        = "Comic Sans MS"
213:             .FontBold        = .T.
214:             .FontItalic      = .T.
215:             .FontSize        = 8
216:             .ForeColor       = RGB(90, 90, 90)
217:             .BackColor       = RGB(255, 255, 255)
218:             .Themes          = .F.
219:             .SpecialEffect   = 0
220:             .MousePointer    = 15
221:             .WordWrap        = .T.
222:             .AutoSize        = .F.
223:             .Visible         = .T.
224:         ENDWITH
225:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
226: 
227:         *-- Botao Alterar (Left=155)
228:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
229:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
230:             .Caption         = "Alterar"
231:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
232:             .PicturePosition = 13
233:             .Top             = 5
234:             .Left            = 155
235:             .Width           = 75
236:             .Height          = 75
237:             .FontName        = "Comic Sans MS"
238:             .FontBold        = .T.
239:             .FontItalic      = .T.
240:             .FontSize        = 8
241:             .ForeColor       = RGB(90, 90, 90)
242:             .BackColor       = RGB(255, 255, 255)
243:             .Themes          = .F.
244:             .SpecialEffect   = 0
245:             .MousePointer    = 15
246:             .WordWrap        = .T.
247:             .AutoSize        = .F.
248:             .Visible         = .T.
249:         ENDWITH
250:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
251: 
252:         *-- Botao Excluir (Left=230)
253:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
254:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
255:             .Caption         = "Excluir"
256:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
257:             .PicturePosition = 13
258:             .Top             = 5
259:             .Left            = 230
260:             .Width           = 75
261:             .Height          = 75
262:             .FontName        = "Comic Sans MS"
263:             .FontBold        = .T.
264:             .FontItalic      = .T.
265:             .FontSize        = 8
266:             .ForeColor       = RGB(90, 90, 90)
267:             .BackColor       = RGB(255, 255, 255)
268:             .Themes          = .F.
269:             .SpecialEffect   = 0
270:             .MousePointer    = 15
271:             .WordWrap        = .T.
272:             .AutoSize        = .F.
273:             .Visible         = .T.
274:         ENDWITH
275:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
276: 
277:         *-- Botao Buscar (Left=305)
278:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
279:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
280:             .Caption         = "Buscar"
281:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
282:             .PicturePosition = 13
283:             .Top             = 5
284:             .Left            = 305
285:             .Width           = 75
286:             .Height          = 75
287:             .FontName        = "Comic Sans MS"
288:             .FontBold        = .T.
289:             .FontItalic      = .T.
290:             .FontSize        = 8
291:             .ForeColor       = RGB(90, 90, 90)
292:             .BackColor       = RGB(255, 255, 255)
293:             .Themes          = .F.
294:             .SpecialEffect   = 0
295:             .MousePointer    = 15
296:             .WordWrap        = .T.
297:             .AutoSize        = .F.
298:             .Visible         = .T.
299:         ENDWITH
300:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
301: 
302:         *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10, prevalece sobre legado)
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
324:             .FontName        = "Comic Sans MS"
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
339:         *-- Grid de listagem (legado: Grade.pColuna('Codigos',...,80), pColuna('Descs',...,279))
340:         *-- Canonico framework: Top=117 (88+29 compensacao), Left=26, Width=880, Height=498
341:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
342:         *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
343:         loc_oPagina.grd_4c_Lista.ColumnCount = 2
344:         WITH loc_oPagina.grd_4c_Lista
345:             .Top                = 117
346:             .Left               = 26
347:             .Width              = 880
348:             .Height             = 498
349:             .FontName           = "Verdana"
350:             .FontSize           = 8
351:             .ForeColor          = RGB(90, 90, 90)
352:             .BackColor          = RGB(255, 255, 255)
353:             .GridLineColor      = RGB(238, 238, 238)
354:             .HighlightBackColor = RGB(255, 255, 255)
355:             .HighlightForeColor = RGB(15, 41, 104)
356:             .HighlightStyle     = 2
357:             .DeleteMark         = .F.
358:             .RecordMark         = .F.
359:             .RowHeight          = 16
360:             .ScrollBars         = 2
361:             .GridLines          = 3
362:             .Visible            = .T.
363:         ENDWITH
364:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
365: 
366:         THIS.TornarControlesVisiveis(loc_oPagina)
367:     ENDPROC
368: 
369:     *===========================================================================
370:     * CarregarLista - Carrega dados no Grid da Page1 (cursor_4c_Dados: codigos, descs)
371:     *===========================================================================
372:     PROCEDURE CarregarLista()
373:         LOCAL loc_lResultado, loc_oGrid
374:         loc_lResultado = .F.
375: 
376:         TRY
377:             IF !THIS.this_oBusinessObject.Buscar("")
378:                 loc_lResultado = .F.
379:             ELSE
380:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
381: 
382:                 *-- PROBLEMA 48: RecordSource ANTES de ControlSource (FORA do WITH per Problema 36)
383:                 loc_oGrid.ColumnCount = 2
384:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
385: 
386:                 *-- PROBLEMA 48: ControlSource APOS RecordSource (auto-bind seria sobrescrito)
387:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
388:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
389: 
390:                 loc_oGrid.Column1.Width = 100
391:                 loc_oGrid.Column2.Width = 770
392: 
393:                 *-- PROBLEMA 2/32: Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
394:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
395:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
396: 
397:                 THIS.FormatarGridLista(loc_oGrid)
398:                 loc_lResultado = .T.
399:             ENDIF
400: 
401:         CATCH TO loException
402:             MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message + CHR(13) + ;
403:                 "Linha: " + TRANSFORM(loException.LineNo), ;
404:                 "FormTgp.CarregarLista")
405:             loc_lResultado = .F.
406:         ENDTRY
407: 
408:         RETURN loc_lResultado
409:     ENDPROC
410: 
411:     *===========================================================================
412:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
413:     * PUBLIC: TesteAutomatico.prg chama direto de fora da classe (CLAUDE.md #3)
414:     *===========================================================================
415:     PROCEDURE AlternarPagina(par_nPagina)
416:         LOCAL loc_lResultado
417:         loc_lResultado = .F.
418: 
419:         TRY
420:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
421:                 MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
422:             ELSE
423:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
424: 
425:                 IF par_nPagina = 1
426:                     THIS.this_cModoAtual = "LISTA"
427:                     THIS.CarregarLista()
428:                 ENDIF
429: 
430:                 loc_lResultado = .T.
431:             ENDIF
432: 
433:         CATCH TO loException
434:             MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, ;
435:                 "FormTgp.AlternarPagina")
436:         ENDTRY
437: 
438:         RETURN loc_lResultado
439:     ENDPROC
440: 
441:     *===========================================================================
442:     * FormatarGridLista - Formata visual do grid de lista (FontName/FontSize)
443:     *===========================================================================
444:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
445:         TRY
446:             WITH par_oGrid
447:                 .FontName = "Tahoma"
448:                 .FontSize = 8
449:             ENDWITH
450:         CATCH TO loException
451:             MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
452:                 "FormTgp.FormatarGridLista")
453:         ENDTRY
454:     ENDPROC
455: 
456:     *===========================================================================
457:     * BtnIncluirClick - Prepara BO para novo registro e navega para Page2
458:     * PUBLIC (sem PROTECTED): BINDEVENT exige metodo PUBLIC (CLAUDE.md #2)
459:     *===========================================================================
460:     PROCEDURE BtnIncluirClick()
461:         THIS.this_oBusinessObject.NovoRegistro()
462:         THIS.this_cModoAtual = "INCLUIR"
463:         THIS.LimparCampos()
464:         THIS.HabilitarCampos(.T.)
465:         THIS.AjustarBotoesPorModo()
466:         THIS.pgf_4c_Paginas.ActivePage = 2
467:         THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus
468:     ENDPROC
469: 
470:     *===========================================================================
471:     * BtnVisualizarClick - Carrega registro selecionado (linha do grid) e
472:     * navega para Page2 em modo somente-leitura
473:     *===========================================================================
474:     PROCEDURE BtnVisualizarClick()
475:         LOCAL loc_cCodigo
476: 
477:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
478:             MsgAviso("Selecione um Tipo de Gera" + CHR(231) + CHR(227) + "o de O.P. para visualizar!", ;
479:                 "Aten" + CHR(231) + CHR(227) + "o")
480:             RETURN
481:         ENDIF
482: 
483:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
484: 
485:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
486:             THIS.this_cModoAtual = "VISUALIZAR"
487:             THIS.BOParaForm()
488:             THIS.HabilitarCampos(.F.)
489:             THIS.AjustarBotoesPorModo()
490:             THIS.pgf_4c_Paginas.ActivePage = 2
491:             THIS.pgf_4c_Paginas.Page2.txt_4c_Descrs.SetFocus
492:         ENDIF
493:     ENDPROC
494: 
495:     *===========================================================================
496:     * BtnAlterarClick - Carrega registro selecionado (linha do grid) e navega
497:     * para Page2 em modo edicao
498:     *===========================================================================
499:     PROCEDURE BtnAlterarClick()
500:         LOCAL loc_cCodigo
501: 
502:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
503:             MsgAviso("Selecione um Tipo de Gera" + CHR(231) + CHR(227) + "o de O.P. para alterar!", ;
504:                 "Aten" + CHR(231) + CHR(227) + "o")
505:             RETURN
506:         ENDIF
507: 
508:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
509: 
510:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
511:             THIS.this_oBusinessObject.EditarRegistro()
512:             THIS.this_cModoAtual = "ALTERAR"
513:             THIS.BOParaForm()
514:             THIS.HabilitarCampos(.T.)
515:             THIS.AjustarBotoesPorModo()
516:             THIS.pgf_4c_Paginas.ActivePage = 2
517:             THIS.pgf_4c_Paginas.Page2.txt_4c_Descrs.SetFocus
518:         ENDIF
519:     ENDPROC
520: 
521:     *===========================================================================
522:     * BtnExcluirClick - Confirma e exclui o registro selecionado (linha do grid)
523:     * Espelha comportamento.json: verificacao de registro selecionado + confirmacao
524:     *===========================================================================
525:     PROCEDURE BtnExcluirClick()
526:         LOCAL loc_cCodigo, loc_cDesc
527: 
528:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
529:             MsgAviso("Selecione um Tipo de Gera" + CHR(231) + CHR(227) + "o de O.P. para excluir!", ;
530:                 "Aten" + CHR(231) + CHR(227) + "o")
531:             RETURN
532:         ENDIF
533: 
534:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
535:         loc_cDesc   = ALLTRIM(cursor_4c_Dados.descs)
536: 
537:         IF MsgConfirma("Confirma exclus" + CHR(227) + "o do Tipo de Gera" + CHR(231) + CHR(227) + "o de O.P.:" + CHR(13) + ;
538:                 loc_cCodigo + " - " + loc_cDesc, "Excluir Tipo de Gera" + CHR(231) + CHR(227) + "o de O.P.")
539:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
540:                 IF THIS.this_oBusinessObject.Excluir()
541:                     MsgInfo("Tipo de Gera" + CHR(231) + CHR(227) + "o de O.P. exclu" + CHR(237) + "do com sucesso!", "Sucesso")
542:                     THIS.CarregarLista()
543:                 ENDIF
544:             ENDIF
545:         ENDIF
546:     ENDPROC
547: 
548:     *===========================================================================
549:     * ConfigurarPaginaDados - Configura Page2 (estrutura base)
550:     * Containers principais VAZIOS nesta fase: cnt_4c_Cabecalho, cnt_4c_BotoesAcao
551:     * Campos e botoes Confirmar/Cancelar entram nas proximas fases.
552:     * REGRA CLAUDE.md #11: cabecalho tambem na pagina Dados (Erro152)
553:     *===========================================================================
554:     PROTECTED PROCEDURE ConfigurarPaginaDados()
555:         LOCAL loc_oPagina
556:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
557: 
558:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
559: 
560:         *-- Container Cabecalho (identico ao da pagina Lista) - VAZIO nesta fase
561:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
562:         WITH loc_oPagina.cnt_4c_Cabecalho
563:             .Top         = 29
564:             .Left        = 0
565:             .Width       = THIS.Width
566:             .Height      = 80
567:             .BackColor   = RGB(100, 100, 100)
568:             .BorderWidth = 0
569:             .Visible     = .T.
570:         ENDWITH
571: 
572:         *-- Container BotoesAcao (Grupo_Salva legado: Left=615, Top=17, Width=160, Height=85)
573:         *-- Com compensacao PageFrame +29: Top=46
574:         *-- VAZIO nesta fase - botoes Confirmar/Cancelar entram na Fase 6
575:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
576:         WITH loc_oPagina.cnt_4c_BotoesAcao
577:             .Top         = 46
578:             .Left        = 615
579:             .Width       = 160
580:             .Height      = 85
581:             .BackStyle = 1
582:             .BackColor = RGB(255, 255, 255)
583:             .BorderWidth = 0
584:             .Visible     = .T.
585:         ENDWITH
586: 
587:         *-- Label Codigo (lblCodigos legado: Top=158, Left=254, Width=42)
588:         *-- Compensacao PageFrame +29: Top=158+29=187
589:         loc_oPagina.AddObject("lbl_4c_LblCodigos", "Label")
590:         WITH loc_oPagina.lbl_4c_LblCodigos
591:             .Caption   = "C" + CHR(243) + "digo :"
592:             .Top       = 158 + 29
593:             .Left      = 254
594:             .Width     = 42

*-- Linhas 687 a 752:
687:         ENDWITH
688: 
689:         *-- Lookup Operacao de Producao: F4 (KeyPress), DblClick e LostFocus
690:         *-- (espelha PROCEDURE Valid do legado, que dispara ao sair do campo)
691:         BINDEVENT(loc_oPagina.txt_4c_Nivel, "KeyPress", THIS, "NivelLookupKeyPress")
692:         BINDEVENT(loc_oPagina.txt_4c_Nivel, "DblClick", THIS, "NivelLookupDblClick")
693:         BINDEVENT(loc_oPagina.txt_4c_Nivel, "KeyPress", THIS, "ValidarNivel")
694: 
695:         *-- Label Gerar OP Sem Peso Medio (Say4 legado: Top=245, Left=160, Width=136)
696:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
697:         WITH loc_oPagina.lbl_4c_Label4
698:             .Caption   = "Gerar OP Sem Peso M" + CHR(233) + "dio : "
699:             .Top       = 245 + 29
700:             .Left      = 160
701:             .Width     = 136
702:             .Height    = 15
703:             .FontName  = "Tahoma"
704:             .FontSize  = 8
705:             .BackStyle = 0
706:             .ForeColor = RGB(90, 90, 90)
707:             .AutoSize  = .T.
708:             .Visible   = .T.
709:         ENDWITH
710: 
711:         *-- OptionGroup Gerar OP Sem Peso Medio (Optiongroup2 legado: ControlSource=opzers)
712:         loc_oPagina.AddObject("opt_4c_Opzers", "OptionGroup")
713:         WITH loc_oPagina.opt_4c_Opzers
714:             .ButtonCount = 2
715:             .Top         = 241 + 29
716:             .Left        = 299
717:             .Width       = 105
718:             .Height      = 26
719:             .BackStyle   = 0
720:             .BorderStyle = 0
721:             .Value       = 1
722:             .Visible     = .T.
723:         ENDWITH
724:         WITH loc_oPagina.opt_4c_Opzers.Buttons(1)
725:             .Caption   = "Sim"
726:             .BackStyle = 0
727:             .Left      = 5
728:             .Top       = 4
729:             .Width     = 34
730:             .Height    = 15
731:             .Style     = 0
732:             .AutoSize  = .T.
733:             .FontName  = "Tahoma"
734:             .FontSize  = 8
735:             .ForeColor = RGB(90, 90, 90)
736:             .Themes    = .F.
737:         ENDWITH
738:         WITH loc_oPagina.opt_4c_Opzers.Buttons(2)
739:             .Caption   = "N" + CHR(227) + "o"
740:             .BackStyle = 0
741:             .Left      = 58
742:             .Top       = 4
743:             .Width     = 37
744:             .Height    = 15
745:             .Style     = 0
746:             .AutoSize  = .T.
747:             .FontName  = "Tahoma"
748:             .FontSize  = 8
749:             .ForeColor = RGB(90, 90, 90)
750:             .Themes    = .F.
751:         ENDWITH
752: 

*-- Linhas 766 a 810:
766:             .Visible   = .T.
767:         ENDWITH
768: 
769:         *-- OptionGroup Gerar Entrada do Peso (Optiongroup1 legado: ControlSource=EntPes)
770:         loc_oPagina.AddObject("opt_4c_Entpes", "OptionGroup")
771:         WITH loc_oPagina.opt_4c_Entpes
772:             .ButtonCount = 2
773:             .Top         = 264 + 29
774:             .Left        = 299
775:             .Width       = 105
776:             .Height      = 26
777:             .BackStyle   = 0
778:             .BorderStyle = 0
779:             .Value       = 1
780:             .Visible     = .T.
781:         ENDWITH
782:         WITH loc_oPagina.opt_4c_Entpes.Buttons(1)
783:             .Caption   = "Sim"
784:             .BackStyle = 0
785:             .Left      = 5
786:             .Top       = 4
787:             .Width     = 34
788:             .Height    = 15
789:             .Style     = 0
790:             .AutoSize  = .T.
791:             .FontName  = "Tahoma"
792:             .FontSize  = 8
793:             .ForeColor = RGB(90, 90, 90)
794:             .Themes    = .F.
795:         ENDWITH
796:         WITH loc_oPagina.opt_4c_Entpes.Buttons(2)
797:             .Caption   = "N" + CHR(227) + "o"
798:             .BackStyle = 0
799:             .Left      = 58
800:             .Top       = 4
801:             .Width     = 37
802:             .Height    = 15
803:             .Style     = 0
804:             .AutoSize  = .T.
805:             .FontName  = "Tahoma"
806:             .FontSize  = 8
807:             .ForeColor = RGB(90, 90, 90)
808:             .Themes    = .F.
809:         ENDWITH
810: 

*-- Linhas 831 a 1224:
831:             .AutoSize        = .F.
832:             .Visible         = .T.
833:         ENDWITH
834:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
835: 
836:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
837:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
838:             .Caption         = "Encerrar"
839:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
840:             .PicturePosition = 13
841:             .Top             = 5
842:             .Left            = 80
843:             .Width           = 75
844:             .Height          = 75
845:             .FontName        = "Comic Sans MS"
846:             .FontBold        = .T.
847:             .FontItalic      = .T.
848:             .FontSize        = 8
849:             .ForeColor       = RGB(90, 90, 90)
850:             .BackColor       = RGB(255, 255, 255)
851:             .Themes          = .F.
852:             .SpecialEffect   = 0
853:             .MousePointer    = 15
854:             .WordWrap        = .T.
855:             .AutoSize        = .F.
856:             .Visible         = .T.
857:         ENDWITH
858:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
859: 
860:         THIS.TornarControlesVisiveis(loc_oPagina)
861:     ENDPROC
862: 
863:     *===========================================================================
864:     * NivelLookupKeyPress - F4 abre lookup de Operacao de Producao (SigCdOpd)
865:     *===========================================================================
866:     PROCEDURE NivelLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
867:         IF par_nKeyCode = 28
868:             THIS.AbrirLookupOperacao()
869:         ENDIF
870:     ENDPROC
871: 
872:     *===========================================================================
873:     * NivelLookupDblClick - Duplo clique abre lookup de Operacao de Producao
874:     *===========================================================================
875:     PROCEDURE NivelLookupDblClick()
876:         THIS.AbrirLookupOperacao()
877:     ENDPROC
878: 
879:     *===========================================================================
880:     * ValidarNivel - Espelha PROCEDURE Valid do Get_nivel legado: ao sair do
881:     * campo com valor preenchido, valida contra SigCdOpd e abre o picker se
882:     * nao encontrar exato. Guard this_cUltimoNivelValidado evita reabrir o
883:     * lookup em toda perda de foco (Problema 45).
884:     *===========================================================================
885:     PROCEDURE ValidarNivel()
886:         LOCAL loc_oTxt, loc_cValor
887: 
888:         loc_oTxt   = THIS.pgf_4c_Paginas.Page2.txt_4c_Nivel
889:         loc_cValor = ALLTRIM(loc_oTxt.Value)
890: 
891:         IF loc_cValor == THIS.this_cUltimoNivelValidado
892:             RETURN
893:         ENDIF
894:         THIS.this_cUltimoNivelValidado = loc_cValor
895: 
896:         IF EMPTY(loc_cValor)
897:             RETURN
898:         ENDIF
899: 
900:         THIS.AbrirLookupOperacao()
901:     ENDPROC
902: 
903:     *===========================================================================
904:     * AbrirLookupOperacao - Lookup COMPLETO de Operacao de Producao (SigCdOpd)
905:     * Legado: CreateObject('fwBuscaExt', ..., 'SigCdOpd', 'crListaRemota',
906:     * 'Dopps', This.Value, 'Opera??es de Produ??o', .T.)
907:     * SigCdOpd eh tabela single-column para este lookup: 'dopps' funciona
908:     * como codigo E descricao (nao ha coluna de descricao separada).
909:     *===========================================================================
910:     PROCEDURE AbrirLookupOperacao()
911:         LOCAL loc_oTxt, loc_oBusca, loc_cValorAtual
912: 
913:         loc_oTxt = THIS.pgf_4c_Paginas.Page2.txt_4c_Nivel
914: 
915:         IF !loc_oTxt.Enabled
916:             RETURN
917:         ENDIF
918: 
919:         loc_cValorAtual = ALLTRIM(loc_oTxt.Value)
920: 
921:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
922:             "SigCdOpd", ;
923:             "cursor_4c_BuscaOperacao", ;
924:             "dopps", ;
925:             loc_cValorAtual, ;
926:             "Opera" + CHR(231) + CHR(245) + "es de Produ" + CHR(231) + CHR(227) + "o")
927: 
928:         IF VARTYPE(loc_oBusca) = "O"
929:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
930:                 *-- Registro exato encontrado automaticamente pelo Init
931:                 IF USED("cursor_4c_BuscaOperacao")
932:                     loc_oTxt.Value = ALLTRIM(cursor_4c_BuscaOperacao.dopps)
933:                 ENDIF
934:             ELSE
935:                 *-- Nao encontrou exato (ou tabela vazia) - mostrar grid para selecao
936:                 loc_oBusca.mAddColuna("dopps", "", "Opera" + CHR(231) + CHR(227) + "o")
937:                 loc_oBusca.Show()
938: 
939:                 IF loc_oBusca.this_lSelecionou
940:                     IF USED("cursor_4c_BuscaOperacao")
941:                         loc_oTxt.Value = ALLTRIM(cursor_4c_BuscaOperacao.dopps)
942:                     ENDIF
943:                 ENDIF
944:             ENDIF
945: 
946:             loc_oBusca.Release()
947:         ENDIF
948: 
949:         IF USED("cursor_4c_BuscaOperacao")
950:             USE IN cursor_4c_BuscaOperacao
951:         ENDIF
952: 
953:         THIS.this_cUltimoNivelValidado = ALLTRIM(loc_oTxt.Value)
954:     ENDPROC
955: 
956:     *===========================================================================
957:     * BtnBuscarClick - Abre Page2 em modo BUSCAR (Codigo/Descricao como
958:     * criterio) - espelha o botao "Buscar" do grp_operacao legado, que
959:     * habilita Get_Codigos/Get_Descrs e aguarda o Confirmar para localizar
960:     * o registro na lista (comportamento.json: metodo Procedure de 23 linhas,
961:     * Seek por Codigos/Descs em CrSigInTgo)
962:     *===========================================================================
963:     PROCEDURE BtnBuscarClick()
964:         LOCAL loc_lResultado
965:         loc_lResultado = .F.
966: 
967:         TRY
968:             THIS.this_oBusinessObject.NovoRegistro()
969:             THIS.LimparCampos()
970:             THIS.this_cModoAtual = "BUSCAR"
971:             THIS.HabilitarCampos(.T.)
972:             THIS.AjustarBotoesPorModo()
973:             THIS.AlternarPagina(2)
974:             THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus
975:             loc_lResultado = .T.
976:         CATCH TO loException
977:             MostrarErro("Erro ao abrir busca:" + CHR(13) + loException.Message, ;
978:                 "FormTgp.BtnBuscarClick")
979:         ENDTRY
980: 
981:         RETURN loc_lResultado
982:     ENDPROC
983: 
984:     *===========================================================================
985:     * BtnEncerrarClick - Fecha o formulario
986:     * PADRAO CANONICO CLAUDE.md #10: NAO chamar Release() apos - FormBase cuida
987:     *===========================================================================
988:     PROCEDURE BtnEncerrarClick()
989:         THIS.Release()
990:     ENDPROC
991: 
992:     *===========================================================================
993:     * BtnSalvarClick - Salva o registro (INCLUIR/ALTERAR) ou localiza na lista
994:     * (modo BUSCAR). Validacoes de campo obrigatorio FORA do TRY (Problema 16).
995:     * Espelha comportamento.json (evento Click 49 linhas): Codigos e Descs
996:     * obrigatorios; TgpBO.ValidarDados() reforca a validacao (defesa em camada).
997:     *===========================================================================
998:     PROCEDURE BtnSalvarClick()
999:         LOCAL loc_oPg2, loc_cCodBusca, loc_cDescBusca, loc_lResultado
1000:         loc_lResultado = .F.
1001:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1002: 
1003:         *-- Validacoes de campo obrigatorio (FORA do TRY - Problema 16)
1004:         IF THIS.this_cModoAtual == "INCLUIR" AND EMPTY(ALLTRIM(loc_oPg2.txt_4c_Codigos.Value))
1005:             MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido !!!", "Campo Obrigat" + CHR(243) + "rio")
1006:             loc_oPg2.txt_4c_Codigos.SetFocus
1007:             RETURN .F.
1008:         ENDIF
1009: 
1010:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND EMPTY(ALLTRIM(loc_oPg2.txt_4c_Descrs.Value))
1011:             MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !!!", "Campo Obrigat" + CHR(243) + "rio")
1012:             loc_oPg2.txt_4c_Descrs.SetFocus
1013:             RETURN .F.
1014:         ENDIF
1015: 
1016:         TRY
1017:             IF THIS.this_cModoAtual == "BUSCAR"
1018:                 loc_cCodBusca  = ALLTRIM(loc_oPg2.txt_4c_Codigos.Value)
1019:                 loc_cDescBusca = ALLTRIM(loc_oPg2.txt_4c_Descrs.Value)
1020: 
1021:                 THIS.this_cModoAtual = "LISTA"
1022:                 THIS.AlternarPagina(1)
1023: 
1024:                 IF USED("cursor_4c_Dados") AND !EMPTY(loc_cCodBusca)
1025:                     SELECT cursor_4c_Dados
1026:                     LOCATE FOR ALLTRIM(cursor_4c_Dados.codigos) = loc_cCodBusca
1027:                     IF !FOUND()
1028:                         MsgAviso("Tipo de Gera" + CHR(231) + CHR(227) + "o de O.P. n" + CHR(227) + "o encontrado!", "Busca")
1029:                     ENDIF
1030:                 ELSE
1031:                     IF USED("cursor_4c_Dados") AND !EMPTY(loc_cDescBusca)
1032:                         SELECT cursor_4c_Dados
1033:                         LOCATE FOR UPPER(ALLTRIM(cursor_4c_Dados.descs)) = UPPER(loc_cDescBusca)
1034:                         IF !FOUND()
1035:                             MsgAviso("Tipo de Gera" + CHR(231) + CHR(227) + "o de O.P. n" + CHR(227) + "o encontrado!", "Busca")
1036:                         ENDIF
1037:                     ENDIF
1038:                 ENDIF
1039: 
1040:                 loc_lResultado = .T.
1041:             ELSE
1042:                 THIS.FormParaBO()
1043: 
1044:                 IF THIS.this_oBusinessObject.Salvar()
1045:                     MsgInfo("Tipo de Gera" + CHR(231) + CHR(227) + "o de O.P. salvo com sucesso!", "Sucesso")
1046:                     THIS.this_cModoAtual = "LISTA"
1047:                     THIS.AlternarPagina(1)
1048:                     loc_lResultado = .T.
1049:                 ELSE
1050:                     *-- ValidarDados() ja mostra MsgAviso especifico; so exibe generico
1051:                     *-- se o BO informou this_cMensagemErro (ex: falha AntesDeGravar/SQL)
1052:                     IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
1053:                         MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao Salvar")
1054:                     ENDIF
1055:                 ENDIF
1056:             ENDIF
1057: 
1058:         CATCH TO loException
1059:             MostrarErro("Erro ao salvar:" + CHR(13) + loException.Message + CHR(13) + ;
1060:                 "Linha: " + TRANSFORM(loException.LineNo), ;
1061:                 "FormTgp.BtnSalvarClick")
1062:         ENDTRY
1063: 
1064:         RETURN loc_lResultado
1065:     ENDPROC
1066: 
1067:     *===========================================================================
1068:     * BtnCancelarClick - Cancela edicao/busca e volta para a lista
1069:     * PROBLEMA 2: DEVE chamar CarregarLista() (via AlternarPagina(1)) para
1070:     * garantir que o grid seja recarregado/reformatado.
1071:     *===========================================================================
1072:     PROCEDURE BtnCancelarClick()
1073:         TRY
1074:             THIS.this_oBusinessObject.CancelarEdicao()
1075:             THIS.this_cModoAtual = "LISTA"
1076:             THIS.AlternarPagina(1)
1077:         CATCH TO loException
1078:             MostrarErro("Erro ao cancelar:" + CHR(13) + loException.Message, ;
1079:                 "FormTgp.BtnCancelarClick")
1080:         ENDTRY
1081:     ENDPROC
1082: 
1083:     *===========================================================================
1084:     * FormParaBO - Transfere valores do Form para o Business Object
1085:     * (executado antes de Salvar())
1086:     *===========================================================================
1087:     PROCEDURE FormParaBO()
1088:         LOCAL loc_oPg2
1089:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1090: 
1091:         THIS.this_oBusinessObject.this_cCodigos = ALLTRIM(loc_oPg2.txt_4c_Codigos.Value)
1092:         THIS.this_oBusinessObject.this_cDescs   = ALLTRIM(loc_oPg2.txt_4c_Descrs.Value)
1093:         THIS.this_oBusinessObject.this_nEntpes  = loc_oPg2.opt_4c_Entpes.Value
1094:         THIS.this_oBusinessObject.this_nOpzers  = loc_oPg2.opt_4c_Opzers.Value
1095:         THIS.this_oBusinessObject.this_cDopps   = ALLTRIM(loc_oPg2.txt_4c_Nivel.Value)
1096: 
1097:         RETURN .T.
1098:     ENDPROC
1099: 
1100:     *===========================================================================
1101:     * BOParaForm - Transfere valores do Business Object para o Form
1102:     * (executado apos CarregarPorCodigo())
1103:     *===========================================================================
1104:     PROCEDURE BOParaForm()
1105:         LOCAL loc_oPg2
1106:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1107: 
1108:         loc_oPg2.txt_4c_Codigos.Value = THIS.this_oBusinessObject.this_cCodigos
1109:         loc_oPg2.txt_4c_Descrs.Value  = THIS.this_oBusinessObject.this_cDescs
1110:         loc_oPg2.opt_4c_Entpes.Value  = IIF(INLIST(THIS.this_oBusinessObject.this_nEntpes, 1, 2), ;
1111:             THIS.this_oBusinessObject.this_nEntpes, 1)
1112:         loc_oPg2.opt_4c_Opzers.Value  = IIF(INLIST(THIS.this_oBusinessObject.this_nOpzers, 1, 2), ;
1113:             THIS.this_oBusinessObject.this_nOpzers, 1)
1114:         loc_oPg2.txt_4c_Nivel.Value   = THIS.this_oBusinessObject.this_cDopps
1115: 
1116:         THIS.this_cUltimoNivelValidado = ALLTRIM(THIS.this_oBusinessObject.this_cDopps)
1117: 
1118:         RETURN .T.
1119:     ENDPROC
1120: 
1121:     *===========================================================================
1122:     * LimparCampos - Limpa todos os campos da Page2 (valores default)
1123:     *===========================================================================
1124:     PROCEDURE LimparCampos()
1125:         LOCAL loc_oPg2
1126:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1127: 
1128:         loc_oPg2.txt_4c_Codigos.Value = ""
1129:         loc_oPg2.txt_4c_Descrs.Value  = ""
1130:         loc_oPg2.txt_4c_Nivel.Value   = ""
1131:         loc_oPg2.opt_4c_Entpes.Value  = 1
1132:         loc_oPg2.opt_4c_Opzers.Value  = 1
1133: 
1134:         THIS.this_cUltimoNivelValidado = ""
1135:     ENDPROC
1136: 
1137:     *===========================================================================
1138:     * HabilitarCampos - Habilita/desabilita campos da Page2 conforme modo
1139:     * Codigo (chave primaria): editavel apenas em INCLUIR/BUSCAR (espelha
1140:     * comportamento.json Get_Codigos.When: InList(pcEscolha,'INSERIR','PROCURAR'))
1141:     *===========================================================================
1142:     PROCEDURE HabilitarCampos(par_lHabilitar)
1143:         LOCAL loc_oPg2
1144:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1145: 
1146:         TRY
1147:             loc_oPg2.txt_4c_Codigos.Enabled = par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INCLUIR", "BUSCAR")
1148:             loc_oPg2.txt_4c_Descrs.Enabled  = par_lHabilitar
1149:             loc_oPg2.txt_4c_Nivel.Enabled   = par_lHabilitar
1150:             loc_oPg2.opt_4c_Entpes.Enabled  = par_lHabilitar
1151:             loc_oPg2.opt_4c_Opzers.Enabled  = par_lHabilitar
1152:         CATCH TO loException
1153:             MostrarErro("Erro ao habilitar campos:" + CHR(13) + loException.Message, ;
1154:                 "FormTgp.HabilitarCampos")
1155:         ENDTRY
1156:     ENDPROC
1157: 
1158:     *===========================================================================
1159:     * AjustarBotoesPorModo - Habilita/desabilita botoes de acao conforme modo
1160:     * Confirmar desabilitado em VISUALIZAR (padrao canonico dos forms CRUD)
1161:     *===========================================================================
1162:     PROCEDURE AjustarBotoesPorModo()
1163:         LOCAL loc_oBotoesAcao
1164:         loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
1165: 
1166:         TRY
1167:             loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")
1168:             loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1169:         CATCH TO loException
1170:             MostrarErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + loException.Message, ;
1171:                 "FormTgp.AjustarBotoesPorModo")
1172:         ENDTRY
1173:     ENDPROC
1174: 
1175:     *===========================================================================
1176:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1177:     * REGRA: Deve iterar Pages E Controls para PageFrames/Containers aninhados
1178:     *===========================================================================
1179:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1180:         LOCAL loc_nI, loc_oObjeto, loc_nP
1181: 
1182:         IF VARTYPE(par_oContainer) != "O"
1183:             RETURN
1184:         ENDIF
1185: 
1186:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1187:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1188: 
1189:             IF VARTYPE(loc_oObjeto) = "O"
1190:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1191:                     loc_oObjeto.Visible = .T.
1192:                 ENDIF
1193: 
1194:                 *-- Trata PageFrame - itera Pages
1195:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1196:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1197:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1198:                     ENDFOR
1199:                 ENDIF
1200: 
1201:                 *-- Trata containers com ControlCount
1202:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1203:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1204:                 ENDIF
1205:             ENDIF
1206:         ENDFOR
1207:     ENDPROC
1208: 
1209:     *===========================================================================
1210:     * Destroy - Libera recursos ao fechar o formulario
1211:     *===========================================================================
1212:     PROCEDURE Destroy()
1213:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1214:             THIS.this_oBusinessObject = .NULL.
1215:         ENDIF
1216: 
1217:         IF USED("cursor_4c_Dados")
1218:             USE IN cursor_4c_Dados
1219:         ENDIF
1220: 
1221:         DODEFAULT()
1222:     ENDPROC
1223: 
1224: ENDDEFINE


### BO (C:\4c\projeto\app\classes\TgpBO.prg):
*==============================================================================
* TGPBO.PRG
* Business Object para Tgp (Tipos de Geracao de O.P.)
* Tabela: SigInTgo
*
* PILAR 2 - BANCO: Nomes de tabela/colunas IDENTICOS ao legado (SigInTgo)
* PILAR 3 - CODIGO: Arquitetura em camadas, propriedades this_ tipadas
*==============================================================================

DEFINE CLASS TgpBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento 1:1 com colunas de SigInTgo)
    this_cCodigos = ""              && codigos  - char(10) NOT NULL - Chave primaria
    this_cDescs = ""                && descs    - char(30) NOT NULL - Descricao
    this_nEntpes = 0                && entpes   - numeric(1,0) NOT NULL - Gerar Entrada do Peso (OptionGroup 1/2)
    this_nOpzers = 0                && opzers   - numeric(1,0) NOT NULL - Gerar OP Sem Peso Medio (OptionGroup 1/2)
    this_cDopps = ""                && dopps    - char(20) NOT NULL - Operacao de Producao (lookup SigCdOpd)

    *--------------------------------------------------------------------------
    * Init - Inicializa Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        *-- CRITICO: Usar nomes CORRETOS das propriedades herdadas de BusinessBase
        THIS.this_cTabela = "SigInTgo"
        THIS.this_cCampoChave = "codigos"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDFUNC

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
                THIS.this_cCodigos = TratarNulo(codigos, "C")
                THIS.this_cDescs   = TratarNulo(descs,   "C")
                THIS.this_nEntpes  = TratarNulo(entpes,  "N")
                THIS.this_nOpzers  = TratarNulo(opzers,  "N")
                THIS.this_cDopps   = TratarNulo(dopps,   "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "TgpBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar (espelha PROCEDURE Click do
    * legado: Codigos e Descs obrigatorios + verificacao de codigo duplicado
    * apenas na inclusao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigos)
            MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido !!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDescs)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCodigos)
                MsgAviso("C" + CHR(243) + "digo J" + CHR(225) + " Cadastrado !!!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarCodigoExistente - Verifica se codigos ja existe no banco
    *--------------------------------------------------------------------------
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigInTgo" + ;
                " WHERE codigos = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                SELECT cursor_4c_ChkCod
                loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "TgpBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigInTgo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigInTgo (codigos, descs, entpes, opzers, dopps)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigos)>>,
                    <<EscaparSQL(THIS.this_cDescs)>>,
                    <<FormatarNumeroSQL(THIS.this_nEntpes, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nOpzers, 0)>>,
                    <<EscaparSQL(THIS.this_cDopps)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir tipo de gera" + CHR(231) + CHR(227) + "o de O.P.:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "TgpBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigInTgo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigInTgo
                SET descs  = <<EscaparSQL(THIS.this_cDescs)>>,
                    entpes = <<FormatarNumeroSQL(THIS.this_nEntpes, 0)>>,
                    opzers = <<FormatarNumeroSQL(THIS.this_nOpzers, 0)>>,
                    dopps  = <<EscaparSQL(THIS.this_cDopps)>>
                WHERE codigos = <<EscaparSQL(THIS.this_cCodigos)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar tipo de gera" + CHR(231) + CHR(227) + "o de O.P.:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "TgpBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigInTgo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigInTgo WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir tipo de gera" + CHR(231) + CHR(227) + "o de O.P.:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "TgpBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com codigos, descs (colunas do Grade legado:
    * pColuna('Codigos',...) + pColuna('Descs',...))
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (codigos C(10), descs C(30))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT codigos, descs FROM SigInTgo"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY codigos"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar tipos de gera" + CHR(231) + CHR(227) + "o de O.P.:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "TgpBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria (codigos)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descs, entpes, opzers, dopps" + ;
                " FROM SigInTgo WHERE codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Tipo de Gera" + CHR(231) + CHR(227) + "o de O.P. n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar tipo de gera" + CHR(231) + CHR(227) + "o de O.P.:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "TgpBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

