# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [BINDEVENT-PARAMS] Handler 'ValidarTipoCor' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarTipoCor(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCor.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1200 linhas total):

*-- Linhas 24 a 144:
24:     *===========================================================================
25:     * Init - Inicializa o formulario
26:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
27:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
28:     *===========================================================================
29:     PROCEDURE Init()
30:         RETURN DODEFAULT()
31:     ENDPROC
32: 
33:     *===========================================================================
34:     * InicializarForm - Configura estrutura completa
35:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
36:     *===========================================================================
37:     PROTECTED PROCEDURE InicializarForm()
38:         LOCAL loc_lSucesso
39:         loc_lSucesso = .F.
40: 
41:         TRY
42:             THIS.this_oBusinessObject = CREATEOBJECT("CorBO")
43: 
44:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
45:                 MostrarErro("Erro ao criar CorBO" + CHR(13) + ;
46:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
47:                     "FormCor.InicializarForm")
48:             ELSE
49:                 THIS.ConfigurarPageFrame()
50:                 THIS.pgf_4c_Paginas.Visible = .T.
51:                 THIS.pgf_4c_Paginas.ActivePage = 1
52:                 THIS.this_cModoAtual = "LISTA"
53: 
54:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
55:                     THIS.CarregarLista()
56:                 ENDIF
57: 
58:                 loc_lSucesso = .T.
59:             ENDIF
60: 
61:         CATCH TO loException
62:             MostrarErro("Erro ao inicializar FormCor:" + CHR(13) + ;
63:                 loException.Message + CHR(13) + ;
64:                 "Linha: " + TRANSFORM(loException.LineNo), ;
65:                 "FormCor.InicializarForm")
66:         ENDTRY
67: 
68:         RETURN loc_lSucesso
69:     ENDPROC
70: 
71:     *===========================================================================
72:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
73:     * Top=-29 para esconder abas; controles compensam +29 no Top
74:     *===========================================================================
75:     PROTECTED PROCEDURE ConfigurarPageFrame()
76:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
77: 
78:         WITH THIS.pgf_4c_Paginas
79:             .PageCount = 2
80:             .Top       = -29
81:             .Left      = 0
82:             .Width     = THIS.Width
83:             .Height    = THIS.Height + 29
84:             .Tabs      = .F.
85:             .Visible   = .T.
86: 
87:             .Page1.Caption   = "Lista"
88:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
89:             .Page1.BackColor = RGB(255, 255, 255)
90: 
91:             .Page2.Caption   = "Dados"
92:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
93:             .Page2.BackColor = RGB(255, 255, 255)
94:         ENDWITH
95: 
96:         THIS.ConfigurarPaginaLista()
97:         THIS.ConfigurarPaginaDados()
98:     ENDPROC
99: 
100:     *===========================================================================
101:     * ConfigurarPaginaLista - Configura Page1 com Grid e botoes CRUD completos
102:     * Colunas do grid: cods, descs, varias, Pesos (cursor_4c_Dados do CorBO.Buscar)
103:     *===========================================================================
104:     PROTECTED PROCEDURE ConfigurarPaginaLista()
105:         LOCAL loc_oPagina
106:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
107: 
108:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
109: 
110:         *-- Container Cabecalho (cntSombra no legado)
111:         *-- Original: Top=1. Com compensacao +29: Top=31
112:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
113:         WITH loc_oPagina.cnt_4c_Cabecalho
114:             .Top         = 31
115:             .Left        = 0
116:             .Width       = THIS.Width
117:             .Height      = 80
118:             .BackColor   = RGB(100, 100, 100)
119:             .BorderWidth = 0
120:             .Visible     = .T.
121:         ENDWITH
122: 
123:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
124:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
125:             .Caption   = THIS.Caption
126:             .Top       = 15
127:             .Left      = 10
128:             .Width     = 769
129:             .Height    = 40
130:             .FontName  = "Tahoma"
131:             .FontSize  = 16
132:             .FontBold  = .T.
133:             .ForeColor = RGB(0, 0, 0)
134:             .BackStyle = 0
135:             .AutoSize  = .F.
136:             .Visible   = .T.
137:         ENDWITH
138: 
139:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
140:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
141:             .Caption   = THIS.Caption
142:             .Top       = 18
143:             .Left      = 10
144:             .Width     = 769

*-- Linhas 188 a 477:
188:             .AutoSize        = .F.
189:             .Visible         = .T.
190:         ENDWITH
191:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
192: 
193:         *-- Botao Visualizar (Left=80)
194:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
195:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
196:             .Caption         = "Visualizar"
197:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
198:             .PicturePosition = 13
199:             .Top             = 5
200:             .Left            = 80
201:             .Width           = 75
202:             .Height          = 75
203:             .FontName        = "Comic Sans MS"
204:             .FontBold        = .T.
205:             .FontItalic      = .T.
206:             .FontSize        = 8
207:             .ForeColor       = RGB(90, 90, 90)
208:             .BackColor       = RGB(255, 255, 255)
209:             .Themes          = .F.
210:             .SpecialEffect   = 0
211:             .MousePointer    = 15
212:             .WordWrap        = .T.
213:             .AutoSize        = .F.
214:             .Visible         = .T.
215:         ENDWITH
216:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
217: 
218:         *-- Botao Alterar (Left=155)
219:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
220:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
221:             .Caption         = "Alterar"
222:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
223:             .PicturePosition = 13
224:             .Top             = 5
225:             .Left            = 155
226:             .Width           = 75
227:             .Height          = 75
228:             .FontName        = "Comic Sans MS"
229:             .FontBold        = .T.
230:             .FontItalic      = .T.
231:             .FontSize        = 8
232:             .ForeColor       = RGB(90, 90, 90)
233:             .BackColor       = RGB(255, 255, 255)
234:             .Themes          = .F.
235:             .SpecialEffect   = 0
236:             .MousePointer    = 15
237:             .WordWrap        = .T.
238:             .AutoSize        = .F.
239:             .Visible         = .T.
240:         ENDWITH
241:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
242: 
243:         *-- Botao Excluir (Left=230)
244:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
245:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
246:             .Caption         = "Excluir"
247:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
248:             .PicturePosition = 13
249:             .Top             = 5
250:             .Left            = 230
251:             .Width           = 75
252:             .Height          = 75
253:             .FontName        = "Comic Sans MS"
254:             .FontBold        = .T.
255:             .FontItalic      = .T.
256:             .FontSize        = 8
257:             .ForeColor       = RGB(90, 90, 90)
258:             .BackColor       = RGB(255, 255, 255)
259:             .Themes          = .F.
260:             .SpecialEffect   = 0
261:             .MousePointer    = 15
262:             .WordWrap        = .T.
263:             .AutoSize        = .F.
264:             .Visible         = .T.
265:         ENDWITH
266:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
267: 
268:         *-- Botao Buscar (Left=305)
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
289:             .Visible         = .T.
290:         ENDWITH
291:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
292: 
293:         *-- Container Saida - PADRAO CANONICO (prevalece sobre legado per CLAUDE.md regra #10)
294:         *-- Legado: Grupo_Saida.Left=918, Top=-1. Canonico: Left=917, Top=29, Width=90
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
306:         *-- Botao Encerrar - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
307:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
308:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
309:             .Caption         = "Encerrar"
310:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
311:             .PicturePosition = 13
312:             .Top             = 5
313:             .Left            = 5
314:             .Width           = 75
315:             .Height          = 75
316:             .FontName        = "Comic Sans MS"
317:             .FontBold        = .T.
318:             .FontItalic      = .T.
319:             .FontSize        = 8
320:             .ForeColor       = RGB(90, 90, 90)
321:             .BackColor       = RGB(255, 255, 255)
322:             .Themes          = .F.
323:             .SpecialEffect   = 0
324:             .MousePointer    = 15
325:             .WordWrap        = .T.
326:             .AutoSize        = .F.
327:             .Visible         = .T.
328:         ENDWITH
329:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
330: 
331:         *-- Grid de listagem de cores
332:         *-- Original: Grade.Top=121, Left=12, Width=940
333:         *-- Canonico framework: Top=117 (88+29 compensacao), Left=26, Width=880, Height=498
334:         *-- Width=880: nao sobrepoe cnt_4c_Saida (Left=917), margem de 11px
335:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
336:         *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
337:         loc_oPagina.grd_4c_Lista.ColumnCount = 4
338:         WITH loc_oPagina.grd_4c_Lista
339:             .Top                = 117
340:             .Left               = 26
341:             .Width              = 880
342:             .Height             = 498
343:             .FontName           = "Verdana"
344:             .FontSize           = 8
345:             .ForeColor          = RGB(90, 90, 90)
346:             .BackColor          = RGB(255, 255, 255)
347:             .GridLineColor      = RGB(238, 238, 238)
348:             .HighlightBackColor = RGB(255, 255, 255)
349:             .HighlightForeColor = RGB(15, 41, 104)
350:             .HighlightStyle     = 2
351:             .DeleteMark         = .F.
352:             .RecordMark         = .F.
353:             .RowHeight          = 16
354:             .ScrollBars         = 2
355:             .GridLines          = 3
356:             .Visible            = .T.
357:         ENDWITH
358:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
359: 
360:         THIS.TornarControlesVisiveis(loc_oPagina)
361:     ENDPROC
362: 
363:     *===========================================================================
364:     * ConfigurarPaginaDados - Configura Page2: botoes acao + campos (Fase 5 = 1a metade)
365:     * Campos por fase:
366:     *   Fase 5: cods, descs, varias, grupos
367:     *   Fase 6: Pesos, tpCors, DiasEnts + lookups
368:     *===========================================================================
369:     PROTECTED PROCEDURE ConfigurarPaginaDados()
370:         LOCAL loc_oPagina
371:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
372: 
373:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
374: 
375:         *-- Container BotoesAcao (Grupo_Salva legado: Left=819, Top=9, Width=160, Height=85)
376:         *-- Com compensacao PageFrame +29: Top=33 (4+29), Left=842
377:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
378:         WITH loc_oPagina.cnt_4c_BotoesAcao
379:             .Top         = 33
380:             .Left        = 842
381:             .Width       = 160
382:             .Height      = 85
383:             .BackStyle = 1
384:             .BackColor = RGB(255, 255, 255)
385:             .BorderWidth = 0
386:             .Visible     = .T.
387:         ENDWITH
388: 
389:         *-- Botao Confirmar (Salvar) - icone cadastro_salvar_60.jpg (Problema 16: NAO confirmar_60)
390:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
391:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
392:             .Caption         = "Confirmar"
393:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
394:             .PicturePosition = 13
395:             .Top             = 5
396:             .Left            = 5
397:             .Width           = 75
398:             .Height          = 75
399:             .FontName        = "Comic Sans MS"
400:             .FontBold        = .T.
401:             .FontItalic      = .T.
402:             .FontSize        = 8
403:             .ForeColor       = RGB(90, 90, 90)
404:             .BackColor       = RGB(255, 255, 255)
405:             .Themes          = .F.
406:             .SpecialEffect   = 0
407:             .MousePointer    = 15
408:             .WordWrap        = .T.
409:             .AutoSize        = .F.
410:             .Visible         = .T.
411:         ENDWITH
412:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
413: 
414:         *-- Botao Cancelar
415:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
416:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
417:             .Caption         = "Encerrar"
418:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
419:             .PicturePosition = 13
420:             .Top             = 5
421:             .Left            = 80
422:             .Width           = 75
423:             .Height          = 75
424:             .FontName        = "Comic Sans MS"
425:             .FontBold        = .T.
426:             .FontItalic      = .T.
427:             .FontSize        = 8
428:             .ForeColor       = RGB(90, 90, 90)
429:             .BackColor       = RGB(255, 255, 255)
430:             .Themes          = .F.
431:             .SpecialEffect   = 0
432:             .MousePointer    = 15
433:             .WordWrap        = .T.
434:             .AutoSize        = .F.
435:             .Visible         = .T.
436:         ENDWITH
437:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
438: 
439:         *----------------------------------------------------------------------
440:         * CAMPO 1: Codigo (cods) - Say1.top=131+29=160, Getcods.top=127+29=156
441:         *   Say1: left=338; Getcods: left=387, width=41, height=24
442:         *----------------------------------------------------------------------
443:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
444:         WITH loc_oPagina.lbl_4c_Codigo
445:             .Caption   = "C" + CHR(243) + "digo : "
446:             .Top       = 160
447:             .Left      = 338
448:             .Width     = 49
449:             .Height    = 17
450:             .FontName  = "Tahoma"
451:             .FontSize  = 8
452:             .FontBold  = .F.
453:             .ForeColor = RGB(90, 90, 90)
454:             .BackStyle = 0
455:             .AutoSize  = .F.
456:             .Alignment = 1
457:             .Visible   = .T.
458:         ENDWITH
459: 
460:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
461:         WITH loc_oPagina.txt_4c_Codigo
462:             .Value         = ""
463:             .Top           = 156
464:             .Left          = 387
465:             .Width         = 41
466:             .Height        = 24
467:             .FontName      = "Tahoma"
468:             .FontSize      = 8
469:             .MaxLength     = 20
470:             .BackColor     = RGB(255, 255, 255)
471:             .ForeColor     = RGB(0, 0, 0)
472:             .BorderStyle   = 1
473:             .SpecialEffect = 0
474:             .Visible       = .T.
475:         ENDWITH
476: 
477:         *----------------------------------------------------------------------

*-- Linhas 665 a 708:
665:             .SpecialEffect = 0
666:             .Visible       = .T.
667:         ENDWITH
668:         BINDEVENT(loc_oPagina.txt_4c_TipoCor, "KeyPress", THIS, "ValidarTipoCor")
669: 
670:         loc_oPagina.AddObject("lbl_4c_TipoCorSN", "Label")
671:         WITH loc_oPagina.lbl_4c_TipoCorSN
672:             .Caption   = "(S/N)"
673:             .Top       = 295
674:             .Left      = 413
675:             .Width     = 35
676:             .Height    = 17
677:             .FontName  = "Tahoma"
678:             .FontSize  = 8
679:             .FontBold  = .F.
680:             .ForeColor = RGB(90, 90, 90)
681:             .BackStyle = 0
682:             .AutoSize  = .F.
683:             .Visible   = .T.
684:         ENDWITH
685: 
686:         *----------------------------------------------------------------------
687:         * CAMPO 7: Dias Entrega (DiasEnts) - Say6.top=293+29=322, getDiasEnts.top=289+29=318
688:         *   Say6: left=274, "Adicionar na Entrega :"; getDiasEnts: left=386, width=31
689:         *   Say8: "Dias", top=322, left=422
690:         *----------------------------------------------------------------------
691:         loc_oPagina.AddObject("lbl_4c_DiasEntrega", "Label")
692:         WITH loc_oPagina.lbl_4c_DiasEntrega
693:             .Caption   = "Adicionar na Entrega :"
694:             .Top       = 322
695:             .Left      = 274
696:             .Width     = 113
697:             .Height    = 17
698:             .FontName  = "Tahoma"
699:             .FontSize  = 8
700:             .FontBold  = .F.
701:             .ForeColor = RGB(90, 90, 90)
702:             .BackStyle = 0
703:             .AutoSize  = .F.
704:             .Alignment = 1
705:             .Visible   = .T.
706:         ENDWITH
707: 
708:         loc_oPagina.AddObject("txt_4c_DiasEntrega", "TextBox")

*-- Linhas 738 a 789:
738:             .Visible   = .T.
739:         ENDWITH
740: 
741:         THIS.TornarControlesVisiveis(loc_oPagina)
742:     ENDPROC
743: 
744:     *===========================================================================
745:     * CarregarLista - Carrega dados no grid da Page1
746:     * OBRIGATORIO: Reconfigura ControlSource e Headers APOS RecordSource (Problema 2/48)
747:     * OBRIGATORIO: RecordSource FORA do WITH (Problema 36)
748:     *===========================================================================
749:     PROCEDURE CarregarLista()
750:         LOCAL loc_lResultado, loc_oGrid
751:         loc_lResultado = .F.
752: 
753:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
754:             RETURN .T.
755:         ENDIF
756: 
757:         TRY
758:             IF !THIS.this_oBusinessObject.Buscar("")
759:                 loc_lResultado = .F.
760:             ELSE
761:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
762: 
763:                 *-- PROBLEMA 48: RecordSource ANTES de ControlSource (FORA do WITH per Problema 36)
764:                 loc_oGrid.ColumnCount = 4
765:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
766: 
767:                 *-- PROBLEMA 48: ControlSource APOS RecordSource (auto-bind seria sobrescrito)
768:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
769:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
770:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.varias"
771:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Pesos"
772: 
773:                 loc_oGrid.Column1.Width = 75
774:                 loc_oGrid.Column2.Width = 301
775:                 loc_oGrid.Column3.Width = 100
776:                 loc_oGrid.Column4.Width = 100
777: 
778:                 *-- PROBLEMA 2/32: Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
779:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
780:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
781:                 loc_oGrid.Column3.Header1.Caption = "Varia" + CHR(231) + CHR(227) + "o Pre" + CHR(231) + "o"
782:                 loc_oGrid.Column4.Header1.Caption = "Varia" + CHR(231) + CHR(227) + "o Peso"
783: 
784:                 THIS.FormatarGridLista(loc_oGrid)
785:                 loc_lResultado = .T.
786:             ENDIF
787: 
788:         CATCH TO loException
789:             MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message + CHR(13) + ;

*-- Linhas 799 a 1200:
799:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
800:     * Ao voltar para Page1, recarrega a lista
801:     *===========================================================================
802:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
803:         LOCAL loc_lResultado
804:         loc_lResultado = .F.
805: 
806:         TRY
807:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
808:                 MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
809:             ELSE
810:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
811: 
812:                 IF par_nPagina = 1
813:                     THIS.this_cModoAtual = "LISTA"
814:                     THIS.CarregarLista()
815:                 ENDIF
816: 
817:                 loc_lResultado = .T.
818:             ENDIF
819: 
820:         CATCH TO loException
821:             MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, ;
822:                 "FormCor.AlternarPagina")
823:         ENDTRY
824: 
825:         RETURN loc_lResultado
826:     ENDPROC
827: 
828:     *===========================================================================
829:     * FormatarGridLista - Formata visual do grid de lista (FontName/FontSize)
830:     *===========================================================================
831:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
832:         TRY
833:             WITH par_oGrid
834:                 .FontName = "Tahoma"
835:                 .FontSize = 8
836:             ENDWITH
837:         CATCH TO loException
838:             MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
839:                 "FormCor.FormatarGridLista")
840:         ENDTRY
841:     ENDPROC
842: 
843:     *===========================================================================
844:     * BtnIncluirClick - Abre Page2 para incluir novo registro
845:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
846:     *===========================================================================
847:     PROCEDURE BtnIncluirClick()
848:         THIS.this_oBusinessObject.NovoRegistro()
849:         THIS.LimparCampos()
850:         THIS.this_cModoAtual = "INCLUIR"
851:         THIS.HabilitarCampos(.T.)
852:         THIS.AjustarBotoesPorModo()
853:         THIS.AlternarPagina(2)
854:     ENDPROC
855: 
856:     *===========================================================================
857:     * BtnVisualizarClick - Abre Page2 em modo somente leitura
858:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
859:     *===========================================================================
860:     PROCEDURE BtnVisualizarClick()
861:         LOCAL loc_cCodigo
862:         loc_cCodigo = ""
863: 
864:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
865:             SELECT cursor_4c_Dados
866:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
867:         ENDIF
868: 
869:         IF EMPTY(loc_cCodigo)
870:             MsgAviso("Selecione um registro para visualizar.")
871:         ELSE
872:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
873:                 THIS.this_cModoAtual = "VISUALIZAR"
874:                 THIS.BOParaForm()
875:                 THIS.HabilitarCampos(.F.)
876:                 THIS.AjustarBotoesPorModo()
877:                 THIS.AlternarPagina(2)
878:             ENDIF
879:         ENDIF
880:     ENDPROC
881: 
882:     *===========================================================================
883:     * BtnAlterarClick - Abre Page2 para alterar registro selecionado
884:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
885:     *===========================================================================
886:     PROCEDURE BtnAlterarClick()
887:         LOCAL loc_cCodigo
888:         loc_cCodigo = ""
889: 
890:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
891:             SELECT cursor_4c_Dados
892:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
893:         ENDIF
894: 
895:         IF EMPTY(loc_cCodigo)
896:             MsgAviso("Selecione um registro para alterar.")
897:         ELSE
898:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
899:                 THIS.this_oBusinessObject.EditarRegistro()
900:                 THIS.this_cModoAtual = "ALTERAR"
901:                 THIS.BOParaForm()
902:                 THIS.HabilitarCampos(.T.)
903:                 THIS.AjustarBotoesPorModo()
904:                 THIS.AlternarPagina(2)
905:             ENDIF
906:         ENDIF
907:     ENDPROC
908: 
909:     *===========================================================================
910:     * BtnExcluirClick - Exclui registro selecionado com confirmacao
911:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
912:     *===========================================================================
913:     PROCEDURE BtnExcluirClick()
914:         LOCAL loc_cCodigo
915:         loc_cCodigo = ""
916: 
917:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
918:             SELECT cursor_4c_Dados
919:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
920:         ENDIF
921: 
922:         IF EMPTY(loc_cCodigo)
923:             MsgAviso("Selecione um registro para excluir.")
924:         ELSE
925:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
926:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da cor [" + loc_cCodigo + "]?", ;
927:                     "Confirmar Exclus" + CHR(227) + "o")
928:                     IF THIS.this_oBusinessObject.Excluir()
929:                         MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
930:                         THIS.CarregarLista()
931:                     ENDIF
932:                 ENDIF
933:             ENDIF
934:         ENDIF
935:     ENDPROC
936: 
937:     *===========================================================================
938:     * BtnBuscarClick - Abre picker para localizar registro na lista
939:     * Apos selecao, posiciona o cursor no registro encontrado
940:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
941:     *===========================================================================
942:     PROCEDURE BtnBuscarClick()
943:         LOCAL loc_oBusca, loc_cCodigo
944:         loc_cCodigo = ""
945: 
946:         TRY
947:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
948:                 "SigCdCor", "cursor_4c_BuscaCor", "cods", "", ;
949:                 "Buscar Cor")
950: 
951:             IF VARTYPE(loc_oBusca) = "O"
952:                 loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
953:                 loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
954:                 loc_oBusca.Show()
955: 
956:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCor")
957:                     SELECT cursor_4c_BuscaCor
958:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaCor.cods)
959:                 ENDIF
960: 
961:                 loc_oBusca.Release()
962:             ENDIF
963: 
964:             IF USED("cursor_4c_BuscaCor")
965:                 USE IN cursor_4c_BuscaCor
966:             ENDIF
967: 
968:             IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
969:                 SELECT cursor_4c_Dados
970:                 LOCATE FOR ALLTRIM(cods) == loc_cCodigo
971:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
972:             ENDIF
973: 
974:         CATCH TO loException
975:             MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "FormCor.BtnBuscarClick")
976:             IF USED("cursor_4c_BuscaCor")
977:                 USE IN cursor_4c_BuscaCor
978:             ENDIF
979:         ENDTRY
980:     ENDPROC
981: 
982:     *===========================================================================
983:     * BtnEncerrarClick - Fecha o formulario
984:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
985:     *===========================================================================
986:     PROCEDURE BtnEncerrarClick()
987:         THIS.Release()
988:     ENDPROC
989: 
990:     *===========================================================================
991:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
992:     * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)
993:     *===========================================================================
994:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
995:         LOCAL loc_nI, loc_oObjeto, loc_nP
996: 
997:         FOR loc_nI = 1 TO par_oContainer.ControlCount
998:             loc_oObjeto = par_oContainer.Controls(loc_nI)
999: 
1000:             IF VARTYPE(loc_oObjeto) = "O"
1001:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1002:                     loc_oObjeto.Visible = .T.
1003:                 ENDIF
1004: 
1005:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1006:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1007:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1008:                     ENDFOR
1009:                 ENDIF
1010: 
1011:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1012:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1013:                 ENDIF
1014:             ENDIF
1015:         ENDFOR
1016:     ENDPROC
1017: 
1018:     *===========================================================================
1019:     * ValidarTipoCor - Valida que TipoCor e S, N ou branco (legado: Valid do Get_TpCor)
1020:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
1021:     *===========================================================================
1022:     PROCEDURE ValidarTipoCor()
1023:         LOCAL loc_oPagina, loc_cValor
1024:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1025: 
1026:         IF PEMSTATUS(loc_oPagina, "txt_4c_TipoCor", 5)
1027:             loc_cValor = UPPER(ALLTRIM(loc_oPagina.txt_4c_TipoCor.Value))
1028:             IF !EMPTY(loc_cValor) AND !INLIST(loc_cValor, "S", "N")
1029:                 MsgAviso("Tipo de Cor inv" + CHR(225) + "lido! Use S ou N.")
1030:                 loc_oPagina.txt_4c_TipoCor.Value = ""
1031:             ELSE
1032:                 loc_oPagina.txt_4c_TipoCor.Value = loc_cValor
1033:             ENDIF
1034:         ENDIF
1035:     ENDPROC
1036: 
1037:     *===========================================================================
1038:     * BtnSalvarClick - Confirma e salva o registro atual
1039:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
1040:     *===========================================================================
1041:     PROCEDURE BtnSalvarClick()
1042:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1043:             RETURN
1044:         ENDIF
1045: 
1046:         THIS.FormParaBO()
1047: 
1048:         IF THIS.this_oBusinessObject.Salvar()
1049:             MsgInfo("Registro salvo com sucesso!")
1050:             THIS.AlternarPagina(1)
1051:         ENDIF
1052:     ENDPROC
1053: 
1054:     *===========================================================================
1055:     * BtnCancelarClick - Cancela edicao e volta para lista
1056:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
1057:     *===========================================================================
1058:     PROCEDURE BtnCancelarClick()
1059:         THIS.AlternarPagina(1)
1060:         THIS.this_cModoAtual = "LISTA"
1061:         THIS.CarregarLista()
1062:     ENDPROC
1063: 
1064:     *===========================================================================
1065:     * FormParaBO - Transfere dados do Form para o BO antes de salvar
1066:     * Campos: cods, descs, varias, grupos, Pesos, tpCors, DiasEnts (todos)
1067:     *===========================================================================
1068:     PROTECTED PROCEDURE FormParaBO()
1069:         LOCAL loc_oPagina
1070:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1071: 
1072:         THIS.this_oBusinessObject.this_cCodigo        = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
1073:         THIS.this_oBusinessObject.this_cDescricao     = ALLTRIM(loc_oPagina.txt_4c_Descricao.Value)
1074:         THIS.this_oBusinessObject.this_nVariacaoPreco = loc_oPagina.txt_4c_VariacaoPreco.Value
1075:         THIS.this_oBusinessObject.this_cGrupo         = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1076:         THIS.this_oBusinessObject.this_nPeso          = loc_oPagina.txt_4c_Peso.Value
1077:         THIS.this_oBusinessObject.this_cTipoCor       = UPPER(ALLTRIM(loc_oPagina.txt_4c_TipoCor.Value))
1078:         THIS.this_oBusinessObject.this_nDiasEntrega   = loc_oPagina.txt_4c_DiasEntrega.Value
1079:     ENDPROC
1080: 
1081:     *===========================================================================
1082:     * BOParaForm - Transfere dados do BO para o Form apos carregar registro
1083:     * Campos: cods, descs, varias, grupos, Pesos, tpCors, DiasEnts (todos)
1084:     *===========================================================================
1085:     PROTECTED PROCEDURE BOParaForm()
1086:         LOCAL loc_oPagina
1087:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1088: 
1089:         loc_oPagina.txt_4c_Codigo.Value        = THIS.this_oBusinessObject.this_cCodigo
1090:         loc_oPagina.txt_4c_Descricao.Value     = THIS.this_oBusinessObject.this_cDescricao
1091:         loc_oPagina.txt_4c_VariacaoPreco.Value = THIS.this_oBusinessObject.this_nVariacaoPreco
1092:         loc_oPagina.txt_4c_Grupo.Value         = THIS.this_oBusinessObject.this_cGrupo
1093:         loc_oPagina.txt_4c_Peso.Value          = THIS.this_oBusinessObject.this_nPeso
1094:         loc_oPagina.txt_4c_TipoCor.Value       = THIS.this_oBusinessObject.this_cTipoCor
1095:         loc_oPagina.txt_4c_DiasEntrega.Value   = THIS.this_oBusinessObject.this_nDiasEntrega
1096:     ENDPROC
1097: 
1098:     *===========================================================================
1099:     * HabilitarCampos - Habilita ou desabilita campos de edicao da Page2
1100:     * Codigo somente leitura no Alterar/Visualizar (When do Getcods no legado)
1101:     * Campos: cods, descs, varias, grupos, Pesos, tpCors, DiasEnts (todos)
1102:     *===========================================================================
1103:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1104:         LOCAL loc_oPagina, loc_lCodReadOnly
1105:         loc_oPagina      = THIS.pgf_4c_Paginas.Page2
1106:         loc_lCodReadOnly = (THIS.this_cModoAtual != "INCLUIR")
1107: 
1108:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
1109:             loc_oPagina.txt_4c_Codigo.Enabled        = par_lHabilitar AND !loc_lCodReadOnly
1110:         ENDIF
1111:         IF PEMSTATUS(loc_oPagina, "txt_4c_Descricao", 5)
1112:             loc_oPagina.txt_4c_Descricao.Enabled     = par_lHabilitar
1113:         ENDIF
1114:         IF PEMSTATUS(loc_oPagina, "txt_4c_VariacaoPreco", 5)
1115:             loc_oPagina.txt_4c_VariacaoPreco.Enabled = par_lHabilitar
1116:         ENDIF
1117:         IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1118:             loc_oPagina.txt_4c_Grupo.Enabled         = par_lHabilitar
1119:         ENDIF
1120:         IF PEMSTATUS(loc_oPagina, "txt_4c_Peso", 5)
1121:             loc_oPagina.txt_4c_Peso.Enabled          = par_lHabilitar
1122:         ENDIF
1123:         IF PEMSTATUS(loc_oPagina, "txt_4c_TipoCor", 5)
1124:             loc_oPagina.txt_4c_TipoCor.Enabled       = par_lHabilitar
1125:         ENDIF
1126:         IF PEMSTATUS(loc_oPagina, "txt_4c_DiasEntrega", 5)
1127:             loc_oPagina.txt_4c_DiasEntrega.Enabled   = par_lHabilitar
1128:         ENDIF
1129:     ENDPROC
1130: 
1131:     *===========================================================================
1132:     * LimparCampos - Limpa todos os campos da Page2 para novo registro
1133:     * Campos: cods, descs, varias, grupos, Pesos, tpCors, DiasEnts (todos)
1134:     *===========================================================================
1135:     PROTECTED PROCEDURE LimparCampos()
1136:         LOCAL loc_oPagina
1137:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1138: 
1139:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
1140:             loc_oPagina.txt_4c_Codigo.Value        = ""
1141:         ENDIF
1142:         IF PEMSTATUS(loc_oPagina, "txt_4c_Descricao", 5)
1143:             loc_oPagina.txt_4c_Descricao.Value     = ""
1144:         ENDIF
1145:         IF PEMSTATUS(loc_oPagina, "txt_4c_VariacaoPreco", 5)
1146:             loc_oPagina.txt_4c_VariacaoPreco.Value = 0
1147:         ENDIF
1148:         IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1149:             loc_oPagina.txt_4c_Grupo.Value         = ""
1150:         ENDIF
1151:         IF PEMSTATUS(loc_oPagina, "txt_4c_Peso", 5)
1152:             loc_oPagina.txt_4c_Peso.Value          = 0
1153:         ENDIF
1154:         IF PEMSTATUS(loc_oPagina, "txt_4c_TipoCor", 5)
1155:             loc_oPagina.txt_4c_TipoCor.Value       = ""
1156:         ENDIF
1157:         IF PEMSTATUS(loc_oPagina, "txt_4c_DiasEntrega", 5)
1158:             loc_oPagina.txt_4c_DiasEntrega.Value   = 0
1159:         ENDIF
1160:     ENDPROC
1161: 
1162:     *===========================================================================
1163:     * AjustarBotoesPorModo - Ajusta estado dos botoes da Page2 conforme modo
1164:     * INCLUIR/ALTERAR: Confirmar habilitado | VISUALIZAR: Confirmar desabilitado
1165:     *===========================================================================
1166:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1167:         LOCAL loc_oPagina, loc_lEditando
1168:         loc_oPagina   = THIS.pgf_4c_Paginas.Page2
1169:         loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1170: 
1171:         IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
1172:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1173:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
1174:             ENDIF
1175:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
1176:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
1177:             ENDIF
1178:         ENDIF
1179:     ENDPROC
1180: 
1181:     *===========================================================================
1182:     * Destroy - Libera recursos ao fechar o formulario
1183:     *===========================================================================
1184:     PROCEDURE Destroy()
1185:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1186:             THIS.this_oBusinessObject = .NULL.
1187:         ENDIF
1188: 
1189:         IF USED("cursor_4c_Dados")
1190:             USE IN cursor_4c_Dados
1191:         ENDIF
1192: 
1193:         IF USED("cursor_4c_BuscaCor")
1194:             USE IN cursor_4c_BuscaCor
1195:         ENDIF
1196: 
1197:         DODEFAULT()
1198:     ENDPROC
1199: 
1200: ENDDEFINE


### BO (C:\4c\projeto\app\classes\CorBO.prg):
*====================================================================
* CorBO.prg
*
* Business Object para Cadastro de Cores
* Tabela: SigCdCor
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS CorBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdCor)
    this_cCodigo        = ""    && cods char(4) - PK
    this_cDescricao     = ""    && descs char(40)
    this_nVariacaoPreco = 0     && varias numeric(6,2)
    this_cGrupo         = ""    && grupos char(10)
    this_nPeso          = 0     && pesos numeric(8,2)
    this_cTipoCor       = ""    && tpcors char(1) - S/N
    this_nDiasEntrega   = 0     && diasents numeric(3,0)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdCor"
            THIS.this_cCampoChave = "cods"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "CorBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo        = TratarNulo(cods,     "C")
                THIS.this_cDescricao     = TratarNulo(descs,    "C")
                THIS.this_nVariacaoPreco = TratarNulo(varias,   "N")
                THIS.this_cGrupo         = TratarNulo(grupos,   "C")
                THIS.this_nPeso          = TratarNulo(Pesos,    "N")
                THIS.this_cTipoCor       = TratarNulo(tpCors,   "C")
                THIS.this_nDiasEntrega   = TratarNulo(DiasEnts, "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "CorBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigo)
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCodigo)
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " Cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDescricao)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND !EMPTY(THIS.this_cTipoCor)
            IF !INLIST(THIS.this_cTipoCor, "S", "N", " ")
                MsgAviso("Tipo de Cor inv" + CHR(225) + "lido! Use S ou N.")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarCodigoExistente - Verifica se cods ja existe no banco
    *====================================================================
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdCor" + ;
                " WHERE cods = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                SELECT cursor_4c_ChkCod
                loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "CorBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdCor
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdCor (cods, descs, varias, grupos, Pesos, tpCors, DiasEnts)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cDescricao)>>,
                    <<FormatarNumeroSQL(THIS.this_nVariacaoPreco, 2)>>,
                    <<EscaparSQL(THIS.this_cGrupo)>>,
                    <<FormatarNumeroSQL(THIS.this_nPeso, 2)>>,
                    <<EscaparSQL(THIS.this_cTipoCor)>>,
                    <<FormatarNumeroSQL(THIS.this_nDiasEntrega, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir cor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "CorBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdCor
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdCor
                SET descs    = <<EscaparSQL(THIS.this_cDescricao)>>,
                    varias   = <<FormatarNumeroSQL(THIS.this_nVariacaoPreco, 2)>>,
                    grupos   = <<EscaparSQL(THIS.this_cGrupo)>>,
                    Pesos    = <<FormatarNumeroSQL(THIS.this_nPeso, 2)>>,
                    tpCors   = <<EscaparSQL(THIS.this_cTipoCor)>>,
                    DiasEnts = <<FormatarNumeroSQL(THIS.this_nDiasEntrega, 0)>>
                WHERE cods = <<EscaparSQL(THIS.this_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar cor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "CorBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdCor
    * Verifica uso em fichas tecnicas (SigPrPrr x SigCdPro) antes de excluir
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso
        loc_lSucesso = .F.
        loc_nUso     = 0

        TRY
            *-- Verificar se cor esta sendo usada em fichas tecnicas
            loc_cSQL = "SELECT COUNT(*) AS nNreg1s" + ;
                " FROM SigPrPrr a INNER JOIN SigCdPro b ON b.cPros = a.cPros" + ;
                " WHERE a.CodCors = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCors")

            IF loc_nResultado < 0
                MostrarErro("Erro ao verificar depend" + CHR(234) + "ncias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_ChkCors")
                    SELECT cursor_4c_ChkCors
                    loc_nUso = NVL(cursor_4c_ChkCors.nNreg1s, 0)
                    USE IN cursor_4c_ChkCors
                ENDIF

                IF loc_nUso > 0
                    MsgAviso("Cor Sendo Utilizada Em Fichas T" + CHR(233) + "cnicas!!!")
                ELSE
                    loc_cSQL = "DELETE FROM SigCdCor WHERE cods = " + EscaparSQL(THIS.this_cCodigo)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao excluir cor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "CorBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com cods, descs, varias, Pesos
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (cods C(20), descs C(40), varias N(6,2), Pesos N(8,2))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT cods, descs, varias, Pesos FROM SigCdCor"

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
                        MostrarErro("Erro ao buscar cores:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar cores:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "CorBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cods)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cods, descs, varias, grupos, Pesos, tpCors, DiasEnts" + ;
                " FROM SigCdCor WHERE cods = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Cor n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar cor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "CorBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

