# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDFTI.Pagina.Dados): Top original=12 vs migrado 'lbl_4c_Label11' Top=119 (diff=107px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDFTI.Pagina.Dados): Left original=121 vs migrado 'lbl_4c_Label11' Left=442 (diff=321px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFti.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2436 linhas total):

*-- Linhas 27 a 186:
27:     this_cAntValue       = ""
28: 
29:     *==========================================================================
30:     * Init - Inicializacao delegada ao FormBase (que chama InicializarForm)
31:     *==========================================================================
32:     PROCEDURE Init()
33:         LOCAL loc_lResultado
34:         loc_lResultado = .F.
35:         TRY
36:             loc_lResultado = DODEFAULT()
37:         CATCH TO loException
38:             MsgErro("Erro em FormFti.Init:" + CHR(13) + loException.Message + ;
39:                     CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
40:         ENDTRY
41:         RETURN loc_lResultado
42:     ENDPROC
43: 
44:     *==========================================================================
45:     * InicializarForm - Chamado por FormBase.Init()
46:     *==========================================================================
47:     PROTECTED PROCEDURE InicializarForm()
48:         LOCAL loc_lResultado
49:         loc_lResultado = .F.
50: 
51:         TRY
52:             THIS.this_oBusinessObject = CREATEOBJECT("FtiBO")
53:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
54:                 THIS.CriarCursoresGrade()
55:                 THIS.ConfigurarPageFrame()
56:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
57:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
58: 
59:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
60:                     IF !THIS.this_oBusinessObject.CarregarParametros()
61:                         MsgErro("Erro ao carregar par" + CHR(226) + "metros de feitios", "Erro")
62:                     ENDIF
63:                     THIS.CarregarLista()
64:                 ENDIF
65: 
66:                 THIS.pgf_4c_Paginas.Visible = .T.
67:                 THIS.pgf_4c_Paginas.ActivePage = 1
68:                 THIS.this_cModoAtual = "LISTA"
69:                 loc_lResultado = .T.
70:             ELSE
71:                 MsgErro("Erro ao criar FtiBO", "Erro")
72:             ENDIF
73:         CATCH TO loException
74:             MsgErro("Erro em FormFti.InicializarForm:" + CHR(13) + loException.Message + ;
75:                     CHR(13) + "Linha: " + TRANSFORM(loException.LineNo) + ;
76:                     CHR(13) + "Proc: " + loException.Procedure, "Erro")
77:         ENDTRY
78: 
79:         RETURN loc_lResultado
80:     ENDPROC
81: 
82:     *==========================================================================
83:     * CriarCursoresGrade - Cria cursores csGrade e csCusto (locais, sem SQL Server)
84:     *==========================================================================
85:     PROTECTED PROCEDURE CriarCursoresGrade()
86:         IF USED("csGrade")
87:             USE IN csGrade
88:         ENDIF
89:         SET NULL ON
90:         CREATE CURSOR csGrade (Cgrus C(3), CPros C(14), Dgrus C(20), Coefs N(8,4), Ordem N(1,0))
91:         SET NULL OFF
92:         SELECT csGrade
93:         INDEX ON CPros TAG CPros
94: 
95:         IF USED("csCusto")
96:             USE IN csCusto
97:         ENDIF
98:         SET NULL ON
99:         CREATE CURSOR csCusto (Cpros C(14), Dpros C(40), Seqs N(5), Coefs N(8,4))
100:         SET NULL OFF
101:     ENDPROC
102: 
103:     *==========================================================================
104:     * ConfigurarPageFrame - Cria PageFrame principal com 2 paginas
105:     *==========================================================================
106:     PROTECTED PROCEDURE ConfigurarPageFrame()
107:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
108:         WITH THIS.pgf_4c_Paginas
109:             .Top       = -29
110:             .Left      = 0
111:             .Width     = THIS.Width
112:             .Height    = THIS.Height + 29
113:             .PageCount = 2
114:             .Tabs      = .F.
115:             .Visible   = .T.
116:         ENDWITH
117: 
118:         THIS.pgf_4c_Paginas.Page1.BackColor = RGB(200, 200, 200)
119:         THIS.pgf_4c_Paginas.Page2.BackColor = RGB(200, 200, 200)
120: 
121:         IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
122:             THIS.pgf_4c_Paginas.Page1.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
123:             THIS.pgf_4c_Paginas.Page2.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
124:         ENDIF
125: 
126:         THIS.ConfigurarPaginaLista()
127:         THIS.ConfigurarPaginaDados()
128:     ENDPROC
129: 
130:     *==========================================================================
131:     * ConfigurarPaginaLista - Estrutura da Page1 (Lista)
132:     * Criados aqui: cntSombra, cnt_4c_Botoes(shell), cnt_4c_Saida, XML buttons
133:     * Grid e botoes CRUD: Fase 4
134:     *==========================================================================
135:     PROTECTED PROCEDURE ConfigurarPaginaLista()
136:         LOCAL loc_oPagina
137:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
138: 
139:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
140:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
141: 
142:         *-- Cabecalho cinza (cntSombra: Top=1, Left=-1, Width=1008, H=80 -> comp +29)
143:         loc_oPagina.AddObject("cnt_4c_Sombra", "Container")
144:         WITH loc_oPagina.cnt_4c_Sombra
145:             .Top         = 30
146:             .Left        = 0
147:             .Width       = THIS.Width
148:             .Height      = 80
149:             .BackColor   = RGB(100, 100, 100)
150:             .BorderWidth = 0
151:             .Visible     = .T.
152:         ENDWITH
153: 
154:         loc_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
155:         WITH loc_oPagina.cnt_4c_Sombra.lbl_4c_Sombra
156:             .Top       = 15
157:             .Left      = 10
158:             .Width     = 769
159:             .Height    = 40
160:             .AutoSize  = .F.
161:             .Caption   = "Cadastro de Feitios"
162:             .FontName  = "Tahoma"
163:             .FontSize  = 16
164:             .FontBold  = .T.
165:             .ForeColor = RGB(0, 0, 0)
166:             .BackStyle = 0
167:             .Visible   = .T.
168:         ENDWITH
169: 
170:         loc_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
171:         WITH loc_oPagina.cnt_4c_Sombra.lbl_4c_Titulo
172:             .Top       = 18
173:             .Left      = 10
174:             .Width     = 769
175:             .Height    = 46
176:             .AutoSize  = .F.
177:             .Caption   = "Cadastro de Feitios"
178:             .FontName  = "Tahoma"
179:             .FontSize  = 16
180:             .FontBold  = .T.
181:             .ForeColor = RGB(255, 255, 255)
182:             .BackStyle = 0
183:             .Visible   = .T.
184:         ENDWITH
185: 
186:         *-- Container botoes CRUD (Grupo_op: Left=543, Top=-1+29=28, W=385, H=85)

*-- Linhas 230 a 321:
230:             .MousePointer    = 15
231:             .Visible         = .T.
232:         ENDWITH
233:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
234: 
235:         *-- Botao Exporta XML (Top=83+29=112, Left=712, W=105, H=45)
236:         loc_oPagina.AddObject("cmd_4c_BtnExpXML", "CommandButton")
237:         WITH loc_oPagina.cmd_4c_BtnExpXML
238:             .Caption         = "Exporta XML"
239:             .Top             = 112
240:             .Left            = 712
241:             .Width           = 105
242:             .Height          = 45
243:             .Picture         = gc_4c_CaminhoIcones + "exportar_48.png"
244:             .PicturePosition = 1
245:             .FontName        = "Tahoma"
246:             .FontSize        = 8
247:             .FontBold        = .T.
248:             .FontItalic      = .T.
249:             .ForeColor       = RGB(90, 90, 90)
250:             .BackColor       = RGB(255, 255, 255)
251:             .Themes          = .F.
252:             .SpecialEffect   = 0
253:             .WordWrap        = .T.
254:             .ToolTipText     = "Exporta Opera" + CHR(231) + CHR(227) + "o Para Um Arquivo XML"
255:             .Visible         = .T.
256:         ENDWITH
257:         BINDEVENT(loc_oPagina.cmd_4c_BtnExpXML, "Click", THIS, "BtnExpXMLClick")
258: 
259:         *-- Botao Importa XML (Top=83+29=112, Left=818, W=105, H=45)
260:         loc_oPagina.AddObject("cmd_4c_BtnImpXML", "CommandButton")
261:         WITH loc_oPagina.cmd_4c_BtnImpXML
262:             .Caption         = "Importa XML"
263:             .Top             = 112
264:             .Left            = 818
265:             .Width           = 105
266:             .Height          = 45
267:             .Picture         = gc_4c_CaminhoIcones + "importar_48.png"
268:             .PicturePosition = 1
269:             .FontName        = "Tahoma"
270:             .FontSize        = 8
271:             .FontBold        = .T.
272:             .FontItalic      = .T.
273:             .ForeColor       = RGB(90, 90, 90)
274:             .BackColor       = RGB(255, 255, 255)
275:             .Themes          = .F.
276:             .SpecialEffect   = 0
277:             .WordWrap        = .T.
278:             .ToolTipText     = "Importa Opera" + CHR(231) + CHR(227) + "o De Um Arquivo XML"
279:             .Visible         = .T.
280:         ENDWITH
281:         BINDEVENT(loc_oPagina.cmd_4c_BtnImpXML, "Click", THIS, "BtnImpXMLClick")
282: 
283:         *-- Grid principal de lista (Grade: Top=133+29=162, Left=12, W=940, H=458)
284:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
285:         WITH loc_oPagina.grd_4c_Lista
286:             .Top               = 162
287:             .Left              = 12
288:             .Width             = 940
289:             .Height            = 458
290:             .ColumnCount       = 2
291:             .FontName          = "Verdana"
292:             .FontSize          = 8
293:             .ForeColor         = RGB(90, 90, 90)
294:             .GridLineColor     = RGB(90, 90, 90)
295:             .RowHeight         = 16
296:             .HeaderHeight      = 16
297:             .AllowHeaderSizing = .F.
298:             .AllowRowSizing    = .F.
299:             .DeleteMark        = .F.
300:             .RecordMark        = .F.
301:             .ScrollBars        = 2
302:             .ReadOnly          = .T.
303:             .Visible           = .T.
304:         ENDWITH
305:         WITH loc_oPagina.grd_4c_Lista.Column1
306:             .ControlSource = "cursor_4c_Dados.cods"
307:             .Width         = 50
308:             .Movable       = .F.
309:             .Resizable     = .F.
310:         ENDWITH
311:         loc_oPagina.grd_4c_Lista.Column1.Header1.Caption = "C" + CHR(243) + "digo"
312:         WITH loc_oPagina.grd_4c_Lista.Column2
313:             .ControlSource = "cursor_4c_Dados.descs"
314:             .Width         = 270
315:             .Movable       = .F.
316:             .Resizable     = .F.
317:         ENDWITH
318:         loc_oPagina.grd_4c_Lista.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
319:         THIS.FormatarGridLista(loc_oPagina.grd_4c_Lista)
320: 
321:         *-- Botoes CRUD dentro de cnt_4c_Botoes (Left=5/80/155/230/305, Top=5, W=75, H=75)

*-- Linhas 340 a 586:
340:             .MousePointer    = 15
341:             .Visible         = .T.
342:         ENDWITH
343:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
344: 
345:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
346:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
347:             .Caption         = "Visualizar"
348:             .Top             = 5
349:             .Left            = 80
350:             .Width           = 75
351:             .Height          = 75
352:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
353:             .PicturePosition = 13
354:             .FontName        = "Tahoma"
355:             .FontSize        = 8
356:             .FontBold        = .T.
357:             .FontItalic      = .T.
358:             .ForeColor       = RGB(90, 90, 90)
359:             .BackColor       = RGB(255, 255, 255)
360:             .Themes          = .F.
361:             .SpecialEffect   = 0
362:             .WordWrap        = .T.
363:             .MousePointer    = 15
364:             .Visible         = .T.
365:         ENDWITH
366:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
367: 
368:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
369:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
370:             .Caption         = "Alterar"
371:             .Top             = 5
372:             .Left            = 155
373:             .Width           = 75
374:             .Height          = 75
375:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
376:             .PicturePosition = 13
377:             .FontName        = "Tahoma"
378:             .FontSize        = 8
379:             .FontBold        = .T.
380:             .FontItalic      = .T.
381:             .ForeColor       = RGB(90, 90, 90)
382:             .BackColor       = RGB(255, 255, 255)
383:             .Themes          = .F.
384:             .SpecialEffect   = 0
385:             .WordWrap        = .T.
386:             .MousePointer    = 15
387:             .Visible         = .T.
388:         ENDWITH
389:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
390: 
391:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
392:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
393:             .Caption         = "Excluir"
394:             .Top             = 5
395:             .Left            = 230
396:             .Width           = 75
397:             .Height          = 75
398:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
399:             .PicturePosition = 13
400:             .FontName        = "Tahoma"
401:             .FontSize        = 8
402:             .FontBold        = .T.
403:             .FontItalic      = .T.
404:             .ForeColor       = RGB(90, 90, 90)
405:             .BackColor       = RGB(255, 255, 255)
406:             .Themes          = .F.
407:             .SpecialEffect   = 0
408:             .WordWrap        = .T.
409:             .MousePointer    = 15
410:             .Visible         = .T.
411:         ENDWITH
412:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
413: 
414:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
415:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
416:             .Caption         = "Buscar"
417:             .Top             = 5
418:             .Left            = 305
419:             .Width           = 75
420:             .Height          = 75
421:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
422:             .PicturePosition = 13
423:             .FontName        = "Tahoma"
424:             .FontSize        = 8
425:             .FontBold        = .T.
426:             .FontItalic      = .T.
427:             .ForeColor       = RGB(90, 90, 90)
428:             .BackColor       = RGB(255, 255, 255)
429:             .Themes          = .F.
430:             .SpecialEffect   = 0
431:             .WordWrap        = .T.
432:             .MousePointer    = 15
433:             .Visible         = .T.
434:         ENDWITH
435:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
436: 
437:         THIS.TornarControlesVisiveis(loc_oPagina)
438:     ENDPROC
439: 
440:     *==========================================================================
441:     * ConfigurarPaginaDados - Estrutura da Page2 (Dados)
442:     * Criados aqui: cnt_4c_Salva, cnt_4c_BotoesLinha, pgf_4c_Configuracao(shell)
443:     * TextBoxes e OptionGroups: Fases 5-6
444:     * Grids de configuracao: Fase 4
445:     *==========================================================================
446:     PROTECTED PROCEDURE ConfigurarPaginaDados()
447:         LOCAL loc_oPagina
448:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
449: 
450:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
451:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
452: 
453:         *-- Container Salvar/Cancelar (Grupo_Salva: Left=818, Top=10+29=39, W=160, H=85)
454:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
455:         WITH loc_oPagina.cnt_4c_Salva
456:             .Top         = 39
457:             .Left        = 818
458:             .Width       = 160
459:             .Height      = 85
460:             .BackStyle = 1
461:             .BackColor = RGB(255, 255, 255)
462:             .BorderWidth = 0
463:             .Visible     = .T.
464:         ENDWITH
465: 
466:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
467:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
468:             .Caption         = "Confirmar"
469:             .Top             = 5
470:             .Left            = 5
471:             .Width           = 75
472:             .Height          = 75
473:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
474:             .PicturePosition = 13
475:             .FontName        = "Tahoma"
476:             .FontSize        = 8
477:             .FontBold        = .T.
478:             .FontItalic      = .T.
479:             .ForeColor       = RGB(90, 90, 90)
480:             .BackColor       = RGB(255, 255, 255)
481:             .Themes          = .F.
482:             .SpecialEffect   = 0
483:             .WordWrap        = .T.
484:             .MousePointer    = 15
485:             .Visible         = .T.
486:         ENDWITH
487:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
488: 
489:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
490:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
491:             .Caption         = "Encerrar"
492:             .Top             = 5
493:             .Left            = 80
494:             .Width           = 75
495:             .Height          = 75
496:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
497:             .PicturePosition = 13
498:             .FontName        = "Tahoma"
499:             .FontSize        = 8
500:             .FontBold        = .T.
501:             .FontItalic      = .T.
502:             .ForeColor       = RGB(90, 90, 90)
503:             .BackColor       = RGB(255, 255, 255)
504:             .Themes          = .F.
505:             .SpecialEffect   = 0
506:             .WordWrap        = .T.
507:             .MousePointer    = 15
508:             .Visible         = .T.
509:         ENDWITH
510:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
511: 
512:         *-- Container botao Excluir Linha da grade (cmdBotoes: Top=361+29=390, Left=755, W=85)
513:         loc_oPagina.AddObject("cnt_4c_BotoesLinha", "Container")
514:         WITH loc_oPagina.cnt_4c_BotoesLinha
515:             .Top         = 390
516:             .Left        = 755
517:             .Width       = 85
518:             .Height      = 85
519:             .BackStyle = 1
520:             .BackColor = RGB(255, 255, 255)
521:             .BorderWidth = 0
522:             .Visible     = .T.
523:         ENDWITH
524: 
525:         loc_oPagina.cnt_4c_BotoesLinha.AddObject("cmd_4c_ExcluirLinha", "CommandButton")
526:         WITH loc_oPagina.cnt_4c_BotoesLinha.cmd_4c_ExcluirLinha
527:             .Caption         = "Excluir"
528:             .Top             = 5
529:             .Left            = 5
530:             .Width           = 75
531:             .Height          = 75
532:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
533:             .PicturePosition = 13
534:             .FontName        = "Tahoma"
535:             .FontSize        = 8
536:             .FontBold        = .T.
537:             .FontItalic      = .T.
538:             .ForeColor       = RGB(90, 90, 90)
539:             .BackColor       = RGB(255, 255, 255)
540:             .Themes          = .F.
541:             .SpecialEffect   = 0
542:             .WordWrap        = .T.
543:             .MousePointer    = 15
544:             .Visible         = .T.
545:         ENDWITH
546:         BINDEVENT(loc_oPagina.cnt_4c_BotoesLinha.cmd_4c_ExcluirLinha, "Click", THIS, "BtnExcluirLinhaClick")
547: 
548:         *-- PageFrame Configuracao aninhado (Top=184+29=213, Left=-2, W=1003, H=420)
549:         loc_oPagina.AddObject("pgf_4c_Configuracao", "PageFrame")
550:         WITH loc_oPagina.pgf_4c_Configuracao
551:             .Top       = 213
552:             .Left      = -2
553:             .Width     = 1003
554:             .Height    = 420
555:             .PageCount = 2
556:             .Tabs      = .T.
557:             .Visible   = .T.
558:         ENDWITH
559:         loc_oPagina.pgf_4c_Configuracao.Page1.Caption = "Grupos de Produto"
560:         loc_oPagina.pgf_4c_Configuracao.Page2.Caption = "Custos Fixo"
561: 
562:         *-- =================================================================
563:         *-- CAMPOS PRINCIPAIS DA PAGE2 - PARTE 1 (Fase 5/8)
564:         *-- =================================================================
565: 
566:         *-- Label1: "Código : " (top=12+29=41, left=121, W=45, H=15)
567:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
568:         WITH loc_oPagina.lbl_4c_Label1
569:             .Caption   = "C" + CHR(243) + "digo : "
570:             .Top       = 41
571:             .Left      = 121
572:             .Width     = 45
573:             .Height    = 15
574:             .AutoSize  = .F.
575:             .FontName  = "Tahoma"
576:             .FontSize  = 8
577:             .FontBold  = .F.
578:             .ForeColor = RGB(90, 90, 90)
579:             .BackStyle = 0
580:             .Alignment = 1
581:             .Visible   = .T.
582:         ENDWITH
583: 
584:         *-- txt_4c_Codigo: (top=8+29=37, left=166, W=34, H=23)
585:         *-- When original: InList(ThisForm.pcEscolha,'INSERIR','PROCURAR') -> so editavel em INCLUIR
586:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")

*-- Linhas 664 a 808:
664:         ENDWITH
665: 
666:         *-- opt_4c_TpFtio: (top=33+29=62, left=316, W=283, H=27, 3 buttons)
667:         *-- InteractiveChange: Value=3 (Sem Feitio) zera Valor e Acrescimo
668:         loc_oPagina.AddObject("opt_4c_TpFtio", "OptionGroup")
669:         WITH loc_oPagina.opt_4c_TpFtio
670:             .ButtonCount = 3
671:             .Top         = 62
672:             .Left        = 316
673:             .Width       = 283
674:             .Height      = 27
675:             .BackStyle   = 0
676:             .BorderStyle = 0
677:             .Value       = 1
678:             .Visible     = .T.
679:         ENDWITH
680:         WITH loc_oPagina.opt_4c_TpFtio.Buttons(1)
681:             .Caption   = "Por Peso"
682:             .BackStyle = 0
683:             .Left      = 5
684:             .Top       = 5
685:             .Width     = 70
686:             .AutoSize  = .T.
687:             .FontName  = "Tahoma"
688:             .FontSize  = 8
689:             .ForeColor = RGB(90, 90, 90)
690:             .Themes    = .F.
691:         ENDWITH
692:         WITH loc_oPagina.opt_4c_TpFtio.Buttons(2)
693:             .Caption   = "Valor Adicional"
694:             .BackStyle = 0
695:             .Left      = 80
696:             .Top       = 5
697:             .Width     = 65
698:             .AutoSize  = .T.
699:             .FontName  = "Tahoma"
700:             .FontSize  = 8
701:             .ForeColor = RGB(90, 90, 90)
702:             .Themes    = .F.
703:         ENDWITH
704:         WITH loc_oPagina.opt_4c_TpFtio.Buttons(3)
705:             .Caption   = "Informativo"
706:             .BackStyle = 0
707:             .Left      = 160
708:             .Top       = 5
709:             .Width     = 75
710:             .AutoSize  = .T.
711:             .FontName  = "Tahoma"
712:             .FontSize  = 8
713:             .ForeColor = RGB(90, 90, 90)
714:             .Themes    = .F.
715:         ENDWITH
716:         BINDEVENT(loc_oPagina.opt_4c_TpFtio, "InteractiveChange", THIS, "TpFtioChanged")
717: 
718:         *-- Label4: "Moeda : " (top=64+29=93, left=122, W=44, H=15)
719:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
720:         WITH loc_oPagina.lbl_4c_Label4
721:             .Caption   = "Moeda : "
722:             .Top       = 93
723:             .Left      = 122
724:             .Width     = 44
725:             .Height    = 15
726:             .AutoSize  = .F.
727:             .FontName  = "Tahoma"
728:             .FontSize  = 8
729:             .FontBold  = .F.
730:             .ForeColor = RGB(90, 90, 90)
731:             .BackStyle = 0
732:             .Alignment = 1
733:             .Visible   = .T.
734:         ENDWITH
735: 
736:         *-- txt_4c_CdMoeda: codigo moeda (top=60+29=89, left=166, W=32, H=23)
737:         *-- When original: INSERIR E moeda vazia  |  Valid: fwbuscaext SigCdMoe por cmoes
738:         loc_oPagina.AddObject("txt_4c_CdMoeda", "TextBox")
739:         WITH loc_oPagina.txt_4c_CdMoeda
740:             .Value     = ""
741:             .Top       = 89
742:             .Left      = 166
743:             .Width     = 32
744:             .Height    = 23
745:             .FontName  = "Tahoma"
746:             .FontSize  = 8
747:             .ForeColor = RGB(90, 90, 90)
748:             .MaxLength = 6
749:             .Visible   = .T.
750:         ENDWITH
751:         BINDEVENT(loc_oPagina.txt_4c_CdMoeda, "KeyPress", THIS, "ValidarCdMoeda")
752: 
753:         *-- txt_4c_DsMoeda: descricao moeda (top=60+29=89, left=201, W=115, H=23)
754:         *-- When original: INSERIR E moeda vazia  |  Valid: fwbuscaext SigCdMoe por dmoes
755:         loc_oPagina.AddObject("txt_4c_DsMoeda", "TextBox")
756:         WITH loc_oPagina.txt_4c_DsMoeda
757:             .Value     = ""
758:             .Top       = 89
759:             .Left      = 201
760:             .Width     = 115
761:             .Height    = 23
762:             .FontName  = "Tahoma"
763:             .FontSize  = 8
764:             .ForeColor = RGB(90, 90, 90)
765:             .MaxLength = 20
766:             .Visible   = .T.
767:         ENDWITH
768:         BINDEVENT(loc_oPagina.txt_4c_DsMoeda, "KeyPress", THIS, "ValidarDsMoeda")
769: 
770:         *-- Label5: "Multiplicador : " (top=64+29=93, left=401, W=71, H=15)
771:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
772:         WITH loc_oPagina.lbl_4c_Label5
773:             .Caption   = "Multiplicador : "
774:             .Top       = 93
775:             .Left      = 401
776:             .Width     = 71
777:             .Height    = 15
778:             .AutoSize  = .F.
779:             .FontName  = "Tahoma"
780:             .FontSize  = 8
781:             .FontBold  = .F.
782:             .ForeColor = RGB(90, 90, 90)
783:             .BackStyle = 0
784:             .Alignment = 0
785:             .Visible   = .T.
786:         ENDWITH
787: 
788:         *-- txt_4c_Acrescimo: Multiplicador (top=60+29=89, left=474, W=94, H=23)
789:         loc_oPagina.AddObject("txt_4c_Acrescimo", "TextBox")
790:         WITH loc_oPagina.txt_4c_Acrescimo
791:             .Value     = 0
792:             .Top       = 89
793:             .Left      = 474
794:             .Width     = 94
795:             .Height    = 23
796:             .FontName  = "Tahoma"
797:             .FontSize  = 8
798:             .ForeColor = RGB(90, 90, 90)
799:             .InputMask = "999.9999"
800:             .Visible   = .T.
801:         ENDWITH
802: 
803:         *-- Label12: "sem uso :" (top=14+29=43, left=586, W=59) - OCULTO (Visible=.F. no original)
804:         loc_oPagina.AddObject("lbl_4c_Label12", "Label")
805:         WITH loc_oPagina.lbl_4c_Label12
806:             .Caption   = "sem uso :"
807:             .Top       = 43
808:             .Left      = 586

*-- Linhas 954 a 997:
954:         ENDWITH
955: 
956:         *-- opt_4c_CusVenda: Custo/Venda (top=112+29=141, left=161, W=158, H=17, Value=2)
957:         loc_oPagina.AddObject("opt_4c_CusVenda", "OptionGroup")
958:         WITH loc_oPagina.opt_4c_CusVenda
959:             .ButtonCount   = 2
960:             .Top           = 141
961:             .Left          = 161
962:             .Width         = 158
963:             .Height        = 17
964:             .BackStyle     = 0
965:             .BorderStyle   = 0
966:             .SpecialEffect = 0
967:             .Value         = 2
968:             .Visible       = .T.
969:         ENDWITH
970:         WITH loc_oPagina.opt_4c_CusVenda.Buttons(1)
971:             .Caption   = "Custo"
972:             .BackStyle = 0
973:             .Left      = 5
974:             .Top       = 1
975:             .AutoSize  = .T.
976:             .FontName  = "Tahoma"
977:             .FontSize  = 8
978:             .ForeColor = RGB(90, 90, 90)
979:             .Themes    = .F.
980:         ENDWITH
981:         WITH loc_oPagina.opt_4c_CusVenda.Buttons(2)
982:             .Caption   = "Venda"
983:             .BackStyle = 0
984:             .Left      = 98
985:             .Top       = 1
986:             .AutoSize  = .T.
987:             .FontName  = "Tahoma"
988:             .FontSize  = 8
989:             .ForeColor = RGB(90, 90, 90)
990:             .Themes    = .F.
991:         ENDWITH
992: 
993:         *-- lbl_4c_Label13: "Utilizado na Etiqueta : " (top=114+29=143, left=359)
994:         loc_oPagina.AddObject("lbl_4c_Label13", "Label")
995:         WITH loc_oPagina.lbl_4c_Label13
996:             .Caption   = "Utilizado na Etiqueta : "
997:             .Top       = 143

*-- Linhas 1008 a 1051:
1008:         ENDWITH
1009: 
1010:         *-- opt_4c_Etiquetas: Sim/Sim-AU/Não (top=108+29=137, left=474, W=182, H=25, Value=3)
1011:         loc_oPagina.AddObject("opt_4c_Etiquetas", "OptionGroup")
1012:         WITH loc_oPagina.opt_4c_Etiquetas
1013:             .ButtonCount   = 3
1014:             .Top           = 137
1015:             .Left          = 474
1016:             .Width         = 182
1017:             .Height        = 25
1018:             .BackStyle     = 0
1019:             .BorderStyle   = 0
1020:             .SpecialEffect = 0
1021:             .Value         = 3
1022:             .Visible       = .T.
1023:         ENDWITH
1024:         WITH loc_oPagina.opt_4c_Etiquetas.Buttons(1)
1025:             .Caption   = "Sim"
1026:             .BackStyle = 0
1027:             .Left      = 5
1028:             .Top       = 5
1029:             .AutoSize  = .T.
1030:             .FontName  = "Tahoma"
1031:             .FontSize  = 8
1032:             .ForeColor = RGB(90, 90, 90)
1033:             .Themes    = .F.
1034:         ENDWITH
1035:         WITH loc_oPagina.opt_4c_Etiquetas.Buttons(2)
1036:             .Caption   = "Sim - AU"
1037:             .BackStyle = 0
1038:             .Left      = 60
1039:             .Top       = 5
1040:             .AutoSize  = .T.
1041:             .FontName  = "Tahoma"
1042:             .FontSize  = 8
1043:             .ForeColor = RGB(90, 90, 90)
1044:             .Themes    = .F.
1045:         ENDWITH
1046:         WITH loc_oPagina.opt_4c_Etiquetas.Buttons(3)
1047:             .Caption   = "N" + CHR(227) + "o"
1048:             .BackStyle = 0
1049:             .Left      = 140
1050:             .Top       = 5
1051:             .AutoSize  = .T.

*-- Linhas 1073 a 1116:
1073:         ENDWITH
1074: 
1075:         *-- opt_4c_Cfixo: Multiplicador/Divisor (top=132+29=161, left=161, W=162, H=17, Value=1)
1076:         loc_oPagina.AddObject("opt_4c_Cfixo", "OptionGroup")
1077:         WITH loc_oPagina.opt_4c_Cfixo
1078:             .ButtonCount   = 2
1079:             .Top           = 161
1080:             .Left          = 161
1081:             .Width         = 162
1082:             .Height        = 17
1083:             .BackStyle     = 0
1084:             .BorderStyle   = 0
1085:             .SpecialEffect = 0
1086:             .Value         = 1
1087:             .Visible       = .T.
1088:         ENDWITH
1089:         WITH loc_oPagina.opt_4c_Cfixo.Buttons(1)
1090:             .Caption   = "Multiplicador"
1091:             .BackStyle = 0
1092:             .Left      = 5
1093:             .Top       = 1
1094:             .AutoSize  = .T.
1095:             .FontName  = "Tahoma"
1096:             .FontSize  = 8
1097:             .ForeColor = RGB(90, 90, 90)
1098:             .Themes    = .F.
1099:         ENDWITH
1100:         WITH loc_oPagina.opt_4c_Cfixo.Buttons(2)
1101:             .Caption   = "Divisor"
1102:             .BackStyle = 0
1103:             .Left      = 98
1104:             .Top       = 1
1105:             .AutoSize  = .T.
1106:             .FontName  = "Tahoma"
1107:             .FontSize  = 8
1108:             .ForeColor = RGB(90, 90, 90)
1109:             .Themes    = .F.
1110:         ENDWITH
1111: 
1112:         *-- lbl_4c_Label10: "Aplicar Sobre Custo : " (top=153+29=182, left=60)
1113:         loc_oPagina.AddObject("lbl_4c_Label10", "Label")
1114:         WITH loc_oPagina.lbl_4c_Label10
1115:             .Caption   = "Aplicar Sobre Custo : "
1116:             .Top       = 182

*-- Linhas 1127 a 1214:
1127:         ENDWITH
1128: 
1129:         *-- opt_4c_Fwoption1: Sim/Não (top=151+29=180, left=161, W=144, H=19, Value=2)
1130:         loc_oPagina.AddObject("opt_4c_Fwoption1", "OptionGroup")
1131:         WITH loc_oPagina.opt_4c_Fwoption1
1132:             .ButtonCount   = 2
1133:             .Top           = 180
1134:             .Left          = 161
1135:             .Width         = 144
1136:             .Height        = 19
1137:             .BackStyle     = 0
1138:             .BorderStyle   = 0
1139:             .SpecialEffect = 0
1140:             .Value         = 2
1141:             .Visible       = .T.
1142:         ENDWITH
1143:         WITH loc_oPagina.opt_4c_Fwoption1.Buttons(1)
1144:             .Caption   = "Sim"
1145:             .BackStyle = 0
1146:             .Left      = 5
1147:             .Top       = 2
1148:             .AutoSize  = .T.
1149:             .FontName  = "Tahoma"
1150:             .FontSize  = 8
1151:             .ForeColor = RGB(90, 90, 90)
1152:             .Themes    = .F.
1153:         ENDWITH
1154:         WITH loc_oPagina.opt_4c_Fwoption1.Buttons(2)
1155:             .Caption   = "N" + CHR(227) + "o"
1156:             .BackStyle = 0
1157:             .Left      = 98
1158:             .Top       = 2
1159:             .AutoSize  = .T.
1160:             .FontName  = "Tahoma"
1161:             .FontSize  = 8
1162:             .ForeColor = RGB(90, 90, 90)
1163:             .Themes    = .F.
1164:         ENDWITH
1165: 
1166:         THIS.ConfigurarPgPage1()
1167:         THIS.ConfigurarPgPage2()
1168:         THIS.TornarControlesVisiveis(loc_oPagina)
1169:     ENDPROC
1170: 
1171:     *==========================================================================
1172:     * ConfigurarPgPage1 - Configura grd_4c_Grade (Grupos de Produto) do pgf_4c_Configuracao.Page1
1173:     *==========================================================================
1174:     PROTECTED PROCEDURE ConfigurarPgPage1()
1175:         LOCAL loc_oPgGrupos
1176:         loc_oPgGrupos = THIS.pgf_4c_Paginas.Page2.pgf_4c_Configuracao.Page1
1177: 
1178:         *-- grd_4c_Grade (Grupos de Produto: Top=16, Left=234, W=521, H=371, RecordSource=csGrade)
1179:         loc_oPgGrupos.AddObject("grd_4c_Grade", "Grid")
1180:         WITH loc_oPgGrupos.grd_4c_Grade
1181:             .Top               = 16
1182:             .Left              = 234
1183:             .Width             = 521
1184:             .Height            = 371
1185:             .ColumnCount       = 5
1186:             .FontName          = "Tahoma"
1187:             .FontSize          = 8
1188:             .AllowHeaderSizing = .F.
1189:             .AllowRowSizing    = .F.
1190:             .DeleteMark        = .F.
1191:             .RecordMark        = .F.
1192:             .HeaderHeight      = 16
1193:             .RowHeight         = 16
1194:             .ScrollBars        = 2
1195:             .GridLineColor     = RGB(238, 238, 238)
1196:             .RecordSource      = "csGrade"
1197:             .Visible           = .T.
1198:         ENDWITH
1199:         WITH loc_oPgGrupos.grd_4c_Grade.Column1
1200:             .ColumnOrder   = 2
1201:             .ControlSource = "csGrade.Cgrus"
1202:             .Width         = 42
1203:             .Movable       = .F.
1204:             .Resizable     = .F.
1205:         ENDWITH
1206:         loc_oPgGrupos.grd_4c_Grade.Column1.Header1.Caption = "Grupo"
1207:         WITH loc_oPgGrupos.grd_4c_Grade.Column2
1208:             .ColumnOrder   = 4
1209:             .ControlSource = "csGrade.Dgrus"
1210:             .Width         = 224
1211:             .Movable       = .F.
1212:             .Resizable     = .F.
1213:         ENDWITH
1214:         loc_oPgGrupos.grd_4c_Grade.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

*-- Linhas 1240 a 1295:
1240:         ENDWITH
1241:         loc_oPgGrupos.grd_4c_Grade.Column5.Header1.Caption = "Ordem"
1242:         loc_oPgGrupos.grd_4c_Grade.Column2.ReadOnly = .T.
1243:         BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column1.Text1, "When",      THIS, "GradeGrupoCol1When")
1244:         BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column1.Text1, "Valid",     THIS, "GradeGrupoCol1Valid")
1245:         BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column3.Text1, "When",      THIS, "GradeGrupoCol3When")
1246:         BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column3.Text1, "KeyPress", THIS, "GradeGrupoCol3LostFocus")
1247:         BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column4.Text1, "When",      THIS, "GradeGrupoCol4When")
1248:         BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column4.Text1, "Valid",     THIS, "GradeGrupoCol4Valid")
1249:     ENDPROC
1250: 
1251:     *==========================================================================
1252:     * ConfigurarPgPage2 - Configura grd_4c_Custo (Custos Fixo) do pgf_4c_Configuracao.Page2
1253:     * Original: SIGCDFTI.Pagina.Dados.Configuracao.Page2 - 4 colunas: Cpros/Dpros/Coefs/Seqs
1254:     *==========================================================================
1255:     PROTECTED PROCEDURE ConfigurarPgPage2()
1256:         LOCAL loc_oPgCusto
1257:         loc_oPgCusto = THIS.pgf_4c_Paginas.Page2.pgf_4c_Configuracao.Page2
1258: 
1259:         *-- grd_4c_Custo (Custo Fixo: Top=16, Left=278, W=478, H=371, RecordSource=csCusto)
1260:         loc_oPgCusto.AddObject("grd_4c_Custo", "Grid")
1261:         WITH loc_oPgCusto.grd_4c_Custo
1262:             .Top               = 16
1263:             .Left              = 278
1264:             .Width             = 478
1265:             .Height            = 371
1266:             .ColumnCount       = 4
1267:             .FontName          = "Tahoma"
1268:             .FontSize          = 8
1269:             .AllowHeaderSizing = .F.
1270:             .AllowRowSizing    = .F.
1271:             .DeleteMark        = .F.
1272:             .RecordMark        = .F.
1273:             .HeaderHeight      = 16
1274:             .RowHeight         = 16
1275:             .ScrollBars        = 2
1276:             .GridLineColor     = RGB(238, 238, 238)
1277:             .RecordSource      = "csCusto"
1278:             .Visible           = .T.
1279:         ENDWITH
1280:         WITH loc_oPgCusto.grd_4c_Custo.Column1
1281:             .ControlSource = "csCusto.Cpros"
1282:             .Width         = 108
1283:             .Movable       = .F.
1284:             .Resizable     = .F.
1285:         ENDWITH
1286:         loc_oPgCusto.grd_4c_Custo.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1287:         WITH loc_oPgCusto.grd_4c_Custo.Column2
1288:             .ControlSource = "csCusto.Dpros"
1289:             .Width         = 190
1290:             .Movable       = .F.
1291:             .Resizable     = .F.
1292:         ENDWITH
1293:         loc_oPgCusto.grd_4c_Custo.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1294:         loc_oPgCusto.grd_4c_Custo.Column2.ReadOnly = .T.
1295:         WITH loc_oPgCusto.grd_4c_Custo.Column3

*-- Linhas 1312 a 1755:
1312:         ENDWITH
1313:         loc_oPgCusto.grd_4c_Custo.Column4.Header1.Caption = "Sequencia"
1314:         loc_oPgCusto.grd_4c_Custo.Column4.Text1.InputMask = "99999"
1315:         BINDEVENT(loc_oPgCusto.grd_4c_Custo.Column1.Text1, "When",      THIS, "GradeCustoCol1When")
1316:         BINDEVENT(loc_oPgCusto.grd_4c_Custo.Column1.Text1, "Valid",     THIS, "GradeCustoCol1Valid")
1317:         BINDEVENT(loc_oPgCusto.grd_4c_Custo.Column3.Text1, "When",      THIS, "GradeCustoCol3When")
1318:         BINDEVENT(loc_oPgCusto.grd_4c_Custo.Column3.Text1, "KeyPress", THIS, "GradeCustoCol3LostFocus")
1319:         BINDEVENT(loc_oPgCusto.grd_4c_Custo.Column4.Text1, "When",      THIS, "GradeCustoCol4When")
1320:         BINDEVENT(loc_oPgCusto, "Activate", THIS, "ConfigPage2Activate")
1321:     ENDPROC
1322: 
1323:     *==========================================================================
1324:     * CarregarLista - Carrega dados no cursor da lista
1325:     * Grid e ControlSource: adicionados na Fase 4
1326:     *==========================================================================
1327:     PROCEDURE CarregarLista()
1328:         LOCAL loc_lResultado, loc_oGrid
1329:         loc_lResultado = .F.
1330: 
1331:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1332:             RETURN .T.
1333:         ENDIF
1334: 
1335:         TRY
1336:             IF !THIS.this_oBusinessObject.Buscar("")
1337:                 loc_lResultado = .F.
1338:             ELSE
1339:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
1340:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1341:                     loc_oGrid.ColumnCount = 2
1342:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1343:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
1344:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
1345:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1346:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1347:                     loc_oGrid.Refresh()
1348:                 ENDIF
1349:                 loc_lResultado = .T.
1350:             ENDIF
1351:         CATCH TO loException
1352:             MsgErro("Erro em FormFti.CarregarLista:" + CHR(13) + loException.Message + ;
1353:                     CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
1354:             loc_lResultado = .F.
1355:         ENDTRY
1356: 
1357:         RETURN loc_lResultado
1358:     ENDPROC
1359: 
1360:     *==========================================================================
1361:     * AlternarPagina - Navega entre Page1 (1=Lista) e Page2 (2=Dados)
1362:     *==========================================================================
1363:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1364:         LOCAL loc_lResultado
1365:         loc_lResultado = .F.
1366: 
1367:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
1368:             RETURN .F.
1369:         ENDIF
1370: 
1371:         TRY
1372:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1373:             IF par_nPagina = 1
1374:                 THIS.this_cModoAtual = "LISTA"
1375:                 THIS.CarregarLista()
1376:             ENDIF
1377:             loc_lResultado = .T.
1378:         CATCH TO loException
1379:             MsgErro("Erro em FormFti.AlternarPagina:" + CHR(13) + loException.Message, "Erro")
1380:         ENDTRY
1381: 
1382:         RETURN loc_lResultado
1383:     ENDPROC
1384: 
1385:     *==========================================================================
1386:     * BtnEncerrarClick - Fecha o formulario
1387:     *==========================================================================
1388:     PROCEDURE BtnEncerrarClick()
1389:         THIS.Release()
1390:     ENDPROC
1391: 
1392:     *==========================================================================
1393:     * BtnExpXMLClick - Exporta XML do feitio selecionado
1394:     *==========================================================================
1395:     PROCEDURE BtnExpXMLClick()
1396:         LOCAL loc_lResultado, loc_cCodigo
1397:         loc_lResultado = .F.
1398: 
1399:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1400:             MsgAviso("Selecione um feitio para exportar.", "Exportar XML")
1401:             RETURN .F.
1402:         ENDIF
1403: 
1404:         SELECT cursor_4c_Dados
1405:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
1406: 
1407:         IF EMPTY(loc_cCodigo)
1408:             MsgAviso("Selecione um feitio para exportar.", "Exportar XML")
1409:             RETURN .F.
1410:         ENDIF
1411: 
1412:         TRY
1413:             THIS.LockScreen = .T.
1414:             DO FORM SigOpXml WITH THIS, loc_cCodigo, "E", "FEITIO", 2
1415:             THIS.this_cUltCodigo = loc_cCodigo
1416:             THIS.AlternarPagina(1)
1417:             IF USED("cursor_4c_Dados")
1418:                 SELECT cursor_4c_Dados
1419:                 LOCATE FOR ALLTRIM(cods) == THIS.this_cUltCodigo
1420:             ENDIF
1421:             THIS.LockScreen = .F.
1422:             loc_lResultado = .T.
1423:         CATCH TO loException
1424:             THIS.LockScreen = .F.
1425:             MsgErro("Erro em FormFti.BtnExpXMLClick:" + CHR(13) + loException.Message, "Erro")
1426:         ENDTRY
1427: 
1428:         RETURN loc_lResultado
1429:     ENDPROC
1430: 
1431:     *==========================================================================
1432:     * BtnImpXMLClick - Importa XML de feitio
1433:     *==========================================================================
1434:     PROCEDURE BtnImpXMLClick()
1435:         LOCAL loc_lResultado, loc_cCodigo
1436:         loc_lResultado = .F.
1437: 
1438:         TRY
1439:             THIS.LockScreen = .T.
1440:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1441:                 SELECT cursor_4c_Dados
1442:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
1443:             ELSE
1444:                 loc_cCodigo = ""
1445:             ENDIF
1446: 
1447:             DO FORM SigOpXml WITH THIS, "", "I", "FEITIO", 2
1448:             THIS.this_cUltCodigo = loc_cCodigo
1449:             THIS.AlternarPagina(1)
1450:             IF USED("cursor_4c_Dados") AND !EMPTY(THIS.this_cUltCodigo)
1451:                 SELECT cursor_4c_Dados
1452:                 LOCATE FOR ALLTRIM(cods) == THIS.this_cUltCodigo
1453:             ENDIF
1454:             THIS.LockScreen = .F.
1455:             loc_lResultado = .T.
1456:         CATCH TO loException
1457:             THIS.LockScreen = .F.
1458:             MsgErro("Erro em FormFti.BtnImpXMLClick:" + CHR(13) + loException.Message, "Erro")
1459:         ENDTRY
1460: 
1461:         RETURN loc_lResultado
1462:     ENDPROC
1463: 
1464:     *==========================================================================
1465:     * BtnSalvarClick - Valida e salva registro + itens
1466:     *==========================================================================
1467:     PROCEDURE BtnSalvarClick()
1468:         LOCAL loc_lResultado, loc_oPg2, loc_cCodigo, loc_cDescricao
1469:         LOCAL loc_cCdMoeda, loc_nValor
1470:         loc_lResultado = .F.
1471: 
1472:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1473: 
1474:         *-- Validacoes obrigatorias fora do TRY (REGRA CRITICA: sem RETURN dentro TRY)
1475:         loc_cCodigo    = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
1476:         loc_cDescricao = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
1477:         loc_cCdMoeda   = ALLTRIM(loc_oPg2.txt_4c_CdMoeda.Value)
1478:         loc_nValor     = loc_oPg2.txt_4c_Valor.Value
1479: 
1480:         IF EMPTY(loc_cCodigo)
1481:             MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido!", "Valida" + CHR(231) + CHR(227) + "o")
1482:             loc_oPg2.txt_4c_Codigo.SetFocus
1483:             RETURN .F.
1484:         ENDIF
1485: 
1486:         IF EMPTY(loc_cDescricao)
1487:             MsgAviso("Descri" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida!", "Valida" + CHR(231) + CHR(227) + "o")
1488:             loc_oPg2.txt_4c_Descricao.SetFocus
1489:             RETURN .F.
1490:         ENDIF
1491: 
1492:         IF EMPTY(loc_cCdMoeda) AND loc_nValor <> 0
1493:             MsgAviso("Obrigat" + CHR(243) + "rio informar moeda!", "Valida" + CHR(231) + CHR(227) + "o")
1494:             loc_oPg2.txt_4c_CdMoeda.SetFocus
1495:             RETURN .F.
1496:         ENDIF
1497: 
1498:         IF THIS.this_cModoAtual = "INCLUIR"
1499:             IF THIS.this_oBusinessObject.VerificarCodigoExistente(loc_cCodigo)
1500:                 MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!", "Valida" + CHR(231) + CHR(227) + "o")
1501:                 loc_oPg2.txt_4c_Codigo.SetFocus
1502:                 RETURN .F.
1503:             ENDIF
1504:         ENDIF
1505: 
1506:         IF !THIS.this_oBusinessObject.ValidarDuplicidade()
1507:             RETURN .F.
1508:         ENDIF
1509: 
1510:         IF !THIS.this_oBusinessObject.ValidarFaixa()
1511:             RETURN .F.
1512:         ENDIF
1513: 
1514:         IF !THIS.this_oBusinessObject.ValidarConflitoCampos()
1515:             RETURN .F.
1516:         ENDIF
1517: 
1518:         TRY
1519:             THIS.FormParaBO()
1520: 
1521:             IF THIS.this_oBusinessObject.Salvar()
1522:                 IF THIS.this_oBusinessObject.SalvarItens(THIS.this_oBusinessObject.this_cCodigo)
1523:                     MsgInfo("Feitio salvo com sucesso!", "Salvo")
1524:                     THIS.AlternarPagina(1)
1525:                     loc_lResultado = .T.
1526:                 ELSE
1527:                     MsgErro("Erro ao salvar itens do feitio.", "Erro")
1528:                 ENDIF
1529:             ENDIF
1530:         CATCH TO loException
1531:             MsgErro("Erro em FormFti.BtnSalvarClick:" + CHR(13) + loException.Message + ;
1532:                     CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
1533:         ENDTRY
1534: 
1535:         RETURN loc_lResultado
1536:     ENDPROC
1537: 
1538:     *==========================================================================
1539:     * BtnCancelarClick - Cancela edicao e volta para lista
1540:     *==========================================================================
1541:     PROCEDURE BtnCancelarClick()
1542:         THIS.AlternarPagina(1)
1543:         THIS.this_cModoAtual = "LISTA"
1544:     ENDPROC
1545: 
1546:     *==========================================================================
1547:     * BtnExcluirLinhaClick - Exclui linha selecionada de csGrade ou csCusto
1548:     *==========================================================================
1549:     PROCEDURE BtnExcluirLinhaClick()
1550:         LOCAL loc_oPgConf, loc_cCursor, loc_nPos, loc_nTotal
1551:         LOCAL loc_lResultado
1552:         loc_lResultado = .F.
1553: 
1554:         loc_oPgConf = THIS.pgf_4c_Paginas.Page2.pgf_4c_Configuracao
1555:         loc_cCursor = IIF(loc_oPgConf.ActivePage = 1, "csGrade", "csCusto")
1556: 
1557:         IF !USED(loc_cCursor) OR EOF(loc_cCursor) OR BOF(loc_cCursor)
1558:             RETURN
1559:         ENDIF
1560: 
1561:         TRY
1562:             SELECT (loc_cCursor)
1563:             loc_nPos   = RECNO()
1564:             COUNT TO loc_nTotal
1565: 
1566:             IF loc_nTotal > 1
1567:                 IF MsgConfirma("Deseja excluir esta opera" + CHR(231) + CHR(227) + "o?", "Excluir Linha")
1568:                     SELECT (loc_cCursor)
1569:                     GO (loc_nPos)
1570:                     DELETE
1571:                     PACK
1572:                 ENDIF
1573:             ELSE
1574:                 MsgAviso("N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel excluir o " + ;
1575:                          CHR(250) + "nico registro.", "Excluir Linha")
1576:             ENDIF
1577:         CATCH TO loException
1578:             MsgErro("Erro em FormFti.BtnExcluirLinhaClick:" + CHR(13) + loException.Message, "Erro")
1579:         ENDTRY
1580:     ENDPROC
1581: 
1582:     *==========================================================================
1583:     * FormParaBO - Transfere valores do Form para o BO
1584:     *==========================================================================
1585:     PROTECTED PROCEDURE FormParaBO()
1586:         LOCAL loc_oPg2
1587:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1588: 
1589:         THIS.this_oBusinessObject.this_cCodigo       = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
1590:         THIS.this_oBusinessObject.this_cDescricao    = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
1591:         THIS.this_oBusinessObject.this_nValor        = loc_oPg2.txt_4c_Valor.Value
1592:         THIS.this_oBusinessObject.this_cMoeda        = ALLTRIM(loc_oPg2.txt_4c_CdMoeda.Value)
1593:         THIS.this_oBusinessObject.this_cDescMoeda    = ALLTRIM(loc_oPg2.txt_4c_DsMoeda.Value)
1594:         THIS.this_oBusinessObject.this_nAcrescimo    = loc_oPg2.txt_4c_Acrescimo.Value
1595:         THIS.this_oBusinessObject.this_nTipoFeitio   = loc_oPg2.opt_4c_TpFtio.Value
1596:         THIS.this_oBusinessObject.this_nFaixaInicial = loc_oPg2.txt_4c_FaixaI.Value
1597:         THIS.this_oBusinessObject.this_nFaixaFinal   = loc_oPg2.txt_4c_Faixaf.Value
1598:         THIS.this_oBusinessObject.this_nPerdas       = loc_oPg2.txt_4c_Perdas.Value
1599:         THIS.this_oBusinessObject.this_nDivMult      = loc_oPg2.opt_4c_Cfixo.Value
1600:         THIS.this_oBusinessObject.this_nTipo         = loc_oPg2.opt_4c_CusVenda.Value
1601:         THIS.this_oBusinessObject.this_nAplscus      = loc_oPg2.opt_4c_Fwoption1.Value
1602:         THIS.this_oBusinessObject.this_nEtiquetas    = loc_oPg2.opt_4c_Etiquetas.Value
1603:     ENDPROC
1604: 
1605:     *==========================================================================
1606:     * BOParaForm - Transfere valores do BO para o Form
1607:     *==========================================================================
1608:     PROTECTED PROCEDURE BOParaForm()
1609:         LOCAL loc_oPg2
1610:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1611: 
1612:         loc_oPg2.txt_4c_Codigo.Value    = THIS.this_oBusinessObject.this_cCodigo
1613:         loc_oPg2.txt_4c_Descricao.Value = THIS.this_oBusinessObject.this_cDescricao
1614:         loc_oPg2.txt_4c_Valor.Value     = THIS.this_oBusinessObject.this_nValor
1615:         loc_oPg2.txt_4c_CdMoeda.Value   = THIS.this_oBusinessObject.this_cMoeda
1616:         loc_oPg2.txt_4c_DsMoeda.Value   = THIS.this_oBusinessObject.this_cDescMoeda
1617:         loc_oPg2.txt_4c_Acrescimo.Value = THIS.this_oBusinessObject.this_nAcrescimo
1618:         loc_oPg2.opt_4c_TpFtio.Value    = THIS.this_oBusinessObject.this_nTipoFeitio
1619:         loc_oPg2.txt_4c_FaixaI.Value    = THIS.this_oBusinessObject.this_nFaixaInicial
1620:         loc_oPg2.txt_4c_Faixaf.Value    = THIS.this_oBusinessObject.this_nFaixaFinal
1621:         loc_oPg2.txt_4c_Perdas.Value    = THIS.this_oBusinessObject.this_nPerdas
1622:         loc_oPg2.opt_4c_Cfixo.Value     = THIS.this_oBusinessObject.this_nDivMult
1623:         loc_oPg2.opt_4c_CusVenda.Value  = THIS.this_oBusinessObject.this_nTipo
1624:         loc_oPg2.opt_4c_Fwoption1.Value = THIS.this_oBusinessObject.this_nAplscus
1625:         loc_oPg2.opt_4c_Etiquetas.Value = THIS.this_oBusinessObject.this_nEtiquetas
1626:     ENDPROC
1627: 
1628:     *==========================================================================
1629:     * LimparCampos - Limpa valores dos campos da Page2
1630:     *==========================================================================
1631:     PROTECTED PROCEDURE LimparCampos()
1632:         LOCAL loc_oPg2
1633:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1634: 
1635:         loc_oPg2.txt_4c_Codigo.Value    = ""
1636:         loc_oPg2.txt_4c_Descricao.Value = ""
1637:         loc_oPg2.txt_4c_Valor.Value     = 0
1638:         loc_oPg2.txt_4c_CdMoeda.Value   = ""
1639:         loc_oPg2.txt_4c_DsMoeda.Value   = ""
1640:         loc_oPg2.txt_4c_Acrescimo.Value = 0
1641:         loc_oPg2.opt_4c_TpFtio.Value    = 1
1642:         loc_oPg2.txt_4c_FaixaI.Value    = 0
1643:         loc_oPg2.txt_4c_Faixaf.Value    = 0
1644:         loc_oPg2.txt_4c_Perdas.Value    = 0
1645:         loc_oPg2.opt_4c_Cfixo.Value     = 1
1646:         loc_oPg2.opt_4c_CusVenda.Value  = 2
1647:         loc_oPg2.opt_4c_Fwoption1.Value = 2
1648:         loc_oPg2.opt_4c_Etiquetas.Value = 3
1649: 
1650:         IF USED("csGrade")
1651:             SELECT csGrade
1652:             ZAP
1653:         ENDIF
1654:         IF USED("csCusto")
1655:             SELECT csCusto
1656:             ZAP
1657:         ENDIF
1658:     ENDPROC
1659: 
1660:     *==========================================================================
1661:     * HabilitarCampos - Habilita ou desabilita campos editaveis
1662:     *==========================================================================
1663:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1664:         LOCAL loc_oPg2
1665:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1666: 
1667:         loc_oPg2.txt_4c_Codigo.Enabled    = (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
1668:         loc_oPg2.txt_4c_Descricao.Enabled = par_lHabilitar
1669:         loc_oPg2.txt_4c_Valor.Enabled     = par_lHabilitar
1670:         loc_oPg2.txt_4c_CdMoeda.Enabled   = par_lHabilitar
1671:         loc_oPg2.txt_4c_DsMoeda.Enabled   = par_lHabilitar
1672:         loc_oPg2.txt_4c_Acrescimo.Enabled = par_lHabilitar
1673:         loc_oPg2.opt_4c_TpFtio.Enabled    = par_lHabilitar
1674:         loc_oPg2.txt_4c_FaixaI.Enabled    = par_lHabilitar
1675:         loc_oPg2.txt_4c_Faixaf.Enabled    = par_lHabilitar
1676:         loc_oPg2.txt_4c_Perdas.Enabled    = par_lHabilitar
1677:         loc_oPg2.opt_4c_Cfixo.Enabled     = par_lHabilitar
1678:         loc_oPg2.opt_4c_CusVenda.Enabled  = par_lHabilitar
1679:         loc_oPg2.opt_4c_Fwoption1.Enabled = par_lHabilitar
1680:         loc_oPg2.opt_4c_Etiquetas.Enabled = par_lHabilitar
1681: 
1682:         loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar
1683:         loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
1684:         loc_oPg2.cnt_4c_BotoesLinha.cmd_4c_ExcluirLinha.Enabled = par_lHabilitar
1685: 
1686:         IF PEMSTATUS(loc_oPg2.pgf_4c_Configuracao.Page1, "grd_4c_Grade", 5)
1687:             loc_oPg2.pgf_4c_Configuracao.Page1.grd_4c_Grade.ReadOnly = !par_lHabilitar
1688:         ENDIF
1689:         IF PEMSTATUS(loc_oPg2.pgf_4c_Configuracao.Page2, "grd_4c_Custo", 5)
1690:             loc_oPg2.pgf_4c_Configuracao.Page2.grd_4c_Custo.ReadOnly = !par_lHabilitar
1691:         ENDIF
1692:     ENDPROC
1693: 
1694:     *==========================================================================
1695:     * AjustarBotoesPorModo - Ajusta botoes CRUD conforme modo atual
1696:     *==========================================================================
1697:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1698:         LOCAL loc_oBotoes, loc_lEditando, loc_lVisualizando
1699:         loc_oBotoes      = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
1700:         loc_lEditando    = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1701:         loc_lVisualizando = (THIS.this_cModoAtual = "VISUALIZAR")
1702: 
1703:         IF PEMSTATUS(loc_oBotoes, "cmd_4c_Incluir", 5)
1704:             loc_oBotoes.cmd_4c_Incluir.Enabled    = !loc_lEditando AND !loc_lVisualizando
1705:             loc_oBotoes.cmd_4c_Alterar.Enabled    = !loc_lEditando AND !loc_lVisualizando
1706:             loc_oBotoes.cmd_4c_Excluir.Enabled    = !loc_lEditando AND !loc_lVisualizando
1707:             loc_oBotoes.cmd_4c_Visualizar.Enabled = !loc_lEditando AND !loc_lVisualizando
1708:             loc_oBotoes.cmd_4c_Buscar.Enabled     = !loc_lEditando AND !loc_lVisualizando
1709:         ENDIF
1710:     ENDPROC
1711: 
1712:     *==========================================================================
1713:     * CarregarItensNaGrade - Carrega SigPrFto nos cursores csGrade e csCusto
1714:     *==========================================================================
1715:     PROTECTED PROCEDURE CarregarItensNaGrade(par_cCodigo)
1716:         LOCAL loc_lResultado
1717:         loc_lResultado = .F.
1718: 
1719:         TRY
1720:             IF USED("csGrade")
1721:                 SELECT csGrade
1722:                 ZAP
1723:             ENDIF
1724:             IF USED("csCusto")
1725:                 SELECT csCusto
1726:                 ZAP
1727:             ENDIF
1728: 
1729:             IF THIS.this_oBusinessObject.CarregarItens(par_cCodigo) AND USED("cursor_4c_Itens")
1730:                 SELECT cursor_4c_Itens
1731:                 GO TOP
1732:                 SCAN
1733:                     IF !EMPTY(ALLTRIM(cursor_4c_Itens.cgrus))
1734:                         INSERT INTO csGrade (Cgrus, CPros, Dgrus, Coefs, Ordem) ;
1735:                             VALUES (ALLTRIM(cursor_4c_Itens.cgrus), ;
1736:                                     ALLTRIM(cursor_4c_Itens.cpros), ;
1737:                                     "", ;
1738:                                     cursor_4c_Itens.coefs, ;
1739:                                     cursor_4c_Itens.ordem)
1740:                         IF USED("CrSigCdGrp")
1741:                             SELECT CrSigCdGrp
1742:                             IF SEEK(ALLTRIM(cursor_4c_Itens.cgrus), "CrSigCdGrp", "Cgrus")
1743:                                 SELECT csGrade
1744:                                 GO BOTTOM
1745:                                 REPLACE Dgrus WITH ALLTRIM(CrSigCdGrp.Dgrus)
1746:                             ENDIF
1747:                         ENDIF
1748:                     ELSE
1749:                         INSERT INTO csCusto (Cpros, Dpros, Seqs, Coefs) ;
1750:                             VALUES (ALLTRIM(cursor_4c_Itens.cpros), ;
1751:                                     "", ;
1752:                                     cursor_4c_Itens.seqs, ;
1753:                                     cursor_4c_Itens.coefs)
1754:                         IF USED("CrSigCdPro")
1755:                             SELECT CrSigCdPro

*-- Linhas 1787 a 2436:
1787:     ENDPROC
1788: 
1789:     *==========================================================================
1790:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1791:     *==========================================================================
1792:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1793:         LOCAL loc_nI, loc_oObjeto, loc_nP
1794: 
1795:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1796:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1797: 
1798:             IF VARTYPE(loc_oObjeto) = "O"
1799:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1800:                     IF !INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_SOMBRA")
1801:                         loc_oObjeto.Visible = .T.
1802:                     ENDIF
1803:                 ENDIF
1804: 
1805:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1806:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1807:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1808:                     ENDFOR
1809:                 ENDIF
1810: 
1811:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
1812:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1813:                 ENDIF
1814:             ENDIF
1815:         ENDFOR
1816:     ENDPROC
1817: 
1818:     *==========================================================================
1819:     * FormatarGridLista - Formata visual do grid da lista
1820:     *==========================================================================
1821:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1822:         WITH par_oGrid
1823:             .FontName = "Verdana"
1824:             .FontSize = 8
1825:         ENDWITH
1826:     ENDPROC
1827: 
1828:     *==========================================================================
1829:     * BtnIncluirClick - Abre Page2 para novo registro
1830:     *==========================================================================
1831:     PROCEDURE BtnIncluirClick()
1832:         THIS.this_cModoAtual = "INCLUIR"
1833:         THIS.this_oBusinessObject.NovoRegistro()
1834:         THIS.LimparCampos()
1835:         THIS.CriarCursoresGrade()
1836:         THIS.CarregarItensNaGrade("")
1837:         THIS.HabilitarCampos(.T.)
1838:         THIS.AjustarBotoesPorModo()
1839:         THIS.AlternarPagina(2)
1840:     ENDPROC
1841: 
1842:     *==========================================================================
1843:     * BtnVisualizarClick - Abre Page2 para visualizacao do registro selecionado
1844:     *==========================================================================
1845:     PROCEDURE BtnVisualizarClick()
1846:         LOCAL loc_cCodigo
1847:         loc_cCodigo = ""
1848: 
1849:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
1850:             MsgAviso("Selecione um registro.", "Visualizar")
1851:             RETURN
1852:         ENDIF
1853: 
1854:         SELECT cursor_4c_Dados
1855:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
1856: 
1857:         IF EMPTY(loc_cCodigo)
1858:             MsgAviso("Selecione um registro.", "Visualizar")
1859:             RETURN
1860:         ENDIF
1861: 
1862:         THIS.this_cUltCodigo = loc_cCodigo
1863:         THIS.this_cModoAtual = "VISUALIZAR"
1864:         THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1865:         THIS.BOParaForm()
1866:         THIS.CriarCursoresGrade()
1867:         THIS.CarregarItensNaGrade(loc_cCodigo)
1868:         THIS.HabilitarCampos(.F.)
1869:         THIS.AjustarBotoesPorModo()
1870:         THIS.AlternarPagina(2)
1871:     ENDPROC
1872: 
1873:     *==========================================================================
1874:     * BtnAlterarClick - Abre Page2 para edicao do registro selecionado
1875:     *==========================================================================
1876:     PROCEDURE BtnAlterarClick()
1877:         LOCAL loc_cCodigo
1878:         loc_cCodigo = ""
1879: 
1880:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
1881:             MsgAviso("Selecione um registro para alterar.", "Alterar")
1882:             RETURN
1883:         ENDIF
1884: 
1885:         SELECT cursor_4c_Dados
1886:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
1887: 
1888:         IF EMPTY(loc_cCodigo)
1889:             MsgAviso("Selecione um registro para alterar.", "Alterar")
1890:             RETURN
1891:         ENDIF
1892: 
1893:         THIS.this_cUltCodigo = loc_cCodigo
1894:         THIS.this_cModoAtual = "ALTERAR"
1895:         THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1896:         THIS.this_oBusinessObject.EditarRegistro()
1897:         THIS.BOParaForm()
1898:         THIS.CriarCursoresGrade()
1899:         THIS.CarregarItensNaGrade(loc_cCodigo)
1900:         THIS.HabilitarCampos(.T.)
1901:         THIS.AjustarBotoesPorModo()
1902:         THIS.AlternarPagina(2)
1903:     ENDPROC
1904: 
1905:     *==========================================================================
1906:     * BtnExcluirClick - Exclui registro selecionado apos confirmacao
1907:     *==========================================================================
1908:     PROCEDURE BtnExcluirClick()
1909:         LOCAL loc_cCodigo, loc_lResultado
1910:         loc_cCodigo    = ""
1911:         loc_lResultado = .F.
1912: 
1913:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
1914:             MsgAviso("Selecione um registro para excluir.", "Excluir")
1915:             RETURN
1916:         ENDIF
1917: 
1918:         SELECT cursor_4c_Dados
1919:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
1920: 
1921:         IF EMPTY(loc_cCodigo)
1922:             MsgAviso("Selecione um registro para excluir.", "Excluir")
1923:             RETURN
1924:         ENDIF
1925: 
1926:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do feitio '" + loc_cCodigo + "'?", "Excluir")
1927:             RETURN
1928:         ENDIF
1929: 
1930:         TRY
1931:             THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1932:             IF THIS.this_oBusinessObject.Excluir()
1933:                 THIS.this_cUltCodigo = ""
1934:                 THIS.CarregarLista()
1935:                 loc_lResultado = .T.
1936:             ENDIF
1937:         CATCH TO loException
1938:             MsgErro("Erro em FormFti.BtnExcluirClick:" + CHR(13) + loException.Message + ;
1939:                     CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
1940:         ENDTRY
1941:     ENDPROC
1942: 
1943:     *==========================================================================
1944:     * BtnBuscarClick - Filtra lista de feitios por codigo ou descricao
1945:     *==========================================================================
1946:     PROCEDURE BtnBuscarClick()
1947:         LOCAL loc_cFiltro, loc_cTexto, loc_oGrid
1948:         loc_cFiltro = ""
1949:         loc_cTexto  = INPUTBOX("Digite o c" + CHR(243) + "digo ou descri" + CHR(231) + CHR(227) + "o:", ;
1950:                                "Buscar Feitios", "")
1951: 
1952:         IF EMPTY(ALLTRIM(loc_cTexto))
1953:             THIS.CarregarLista()
1954:             RETURN
1955:         ENDIF
1956: 
1957:         loc_cFiltro = "cods LIKE " + EscaparSQL(ALLTRIM(loc_cTexto) + "%")
1958: 
1959:         TRY
1960:             IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
1961:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
1962:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1963:                     loc_oGrid.ColumnCount = 2
1964:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1965:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
1966:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
1967:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1968:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1969:                     loc_oGrid.Refresh()
1970:                 ENDIF
1971:                 IF RECCOUNT("cursor_4c_Dados") = 0
1972:                     MsgAviso("Nenhum registro encontrado.", "Buscar")
1973:                 ENDIF
1974:             ENDIF
1975:         CATCH TO loException
1976:             MsgErro("Erro em FormFti.BtnBuscarClick:" + CHR(13) + loException.Message, "Erro")
1977:         ENDTRY
1978:     ENDPROC
1979: 
1980:     *==========================================================================
1981:     * Destroy - Limpeza ao fechar
1982:     *==========================================================================
1983:     PROCEDURE Destroy()
1984:         LOCAL loc_aCursores(4), loc_i
1985:         loc_aCursores(1) = "csGrade"
1986:         loc_aCursores(2) = "csCusto"
1987:         loc_aCursores(3) = "TmpBranco"
1988:         loc_aCursores(4) = "CsDuplica"
1989: 
1990:         FOR loc_i = 1 TO ALEN(loc_aCursores)
1991:             IF USED(loc_aCursores(loc_i))
1992:                 USE IN (loc_aCursores(loc_i))
1993:             ENDIF
1994:         ENDFOR
1995: 
1996:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1997:             THIS.this_oBusinessObject = .NULL.
1998:         ENDIF
1999: 
2000:         DODEFAULT()
2001:     ENDPROC
2002: 
2003:     *==========================================================================
2004:     * TpFtioChanged - InteractiveChange do opt_4c_TpFtio
2005:     * Value=3 (Sem Feitio): zera txt_4c_Valor e txt_4c_Acrescimo
2006:     *==========================================================================
2007:     PROCEDURE TpFtioChanged()
2008:         LOCAL loc_oPg2
2009:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2010: 
2011:         IF PEMSTATUS(loc_oPg2, "opt_4c_TpFtio", 5) AND loc_oPg2.opt_4c_TpFtio.Value = 3
2012:             IF PEMSTATUS(loc_oPg2, "txt_4c_Valor", 5)
2013:                 loc_oPg2.txt_4c_Valor.Value = 0
2014:             ENDIF
2015:             IF PEMSTATUS(loc_oPg2, "txt_4c_Acrescimo", 5)
2016:                 loc_oPg2.txt_4c_Acrescimo.Value = 0
2017:             ENDIF
2018:         ENDIF
2019:     ENDPROC
2020: 
2021:     *==========================================================================
2022:     * ValidarCdMoeda - LostFocus de txt_4c_CdMoeda
2023:     * Lookup em SigCdMoe por cmoes (codigo); preenche txt_4c_DsMoeda
2024:     *==========================================================================
2025:     PROCEDURE ValidarCdMoeda(par_nKeyCode, par_nShiftAltCtrl)
2026:         LOCAL loc_cCd, loc_lResultado, loc_oBusca
2027:         loc_lResultado = .F.
2028:         loc_cCd        = ""
2029: 
2030:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_CdMoeda", 5)
2031:             loc_cCd = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_CdMoeda.Value)
2032:         ENDIF
2033: 
2034:         IF EMPTY(loc_cCd)
2035:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_DsMoeda", 5)
2036:                 THIS.pgf_4c_Paginas.Page2.txt_4c_DsMoeda.Value = ""
2037:             ENDIF
2038:             RETURN
2039:         ENDIF
2040: 
2041:         TRY
2042:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2043:                 "SigCdMoe", "CrMoedas", "cmoes", loc_cCd, "Moedas")
2044: 
2045:             IF VARTYPE(loc_oBusca) = "O"
2046:                 IF !loc_oBusca.this_lAchouRegistro
2047:                     loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
2048:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
2049:                     loc_oBusca.Show()
2050:                 ENDIF
2051: 
2052:                 IF loc_oBusca.this_lSelecionou AND USED("CrMoedas")
2053:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_CdMoeda", 5)
2054:                         THIS.pgf_4c_Paginas.Page2.txt_4c_CdMoeda.Value = ALLTRIM(CrMoedas.cmoes)
2055:                     ENDIF
2056:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_DsMoeda", 5)
2057:                         THIS.pgf_4c_Paginas.Page2.txt_4c_DsMoeda.Value = ALLTRIM(CrMoedas.dmoes)
2058:                     ENDIF
2059:                     loc_lResultado = .T.
2060:                 ENDIF
2061: 
2062:                 loc_oBusca.Release()
2063:             ENDIF
2064:         CATCH TO loException
2065:             MsgErro("Erro em FormFti.ValidarCdMoeda:" + CHR(13) + loException.Message, "Erro")
2066:         ENDTRY
2067: 
2068:         IF USED("CrMoedas")
2069:             USE IN CrMoedas
2070:         ENDIF
2071:     ENDPROC
2072: 
2073:     *==========================================================================
2074:     * ValidarDsMoeda - LostFocus de txt_4c_DsMoeda
2075:     * Lookup em SigCdMoe por dmoes (descricao); preenche txt_4c_CdMoeda
2076:     *==========================================================================
2077:     PROCEDURE ValidarDsMoeda(par_nKeyCode, par_nShiftAltCtrl)
2078:         LOCAL loc_cDs, loc_lResultado, loc_oBusca
2079:         loc_lResultado = .F.
2080:         loc_cDs        = ""
2081: 
2082:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_DsMoeda", 5)
2083:             loc_cDs = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_DsMoeda.Value)
2084:         ENDIF
2085: 
2086:         IF EMPTY(loc_cDs)
2087:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_CdMoeda", 5)
2088:                 THIS.pgf_4c_Paginas.Page2.txt_4c_CdMoeda.Value = ""
2089:             ENDIF
2090:             RETURN
2091:         ENDIF
2092: 
2093:         TRY
2094:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2095:                 "SigCdMoe", "CrMoedas", "dmoes", loc_cDs, "Moedas")
2096: 
2097:             IF VARTYPE(loc_oBusca) = "O"
2098:                 IF !loc_oBusca.this_lAchouRegistro
2099:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
2100:                     loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
2101:                     loc_oBusca.Show()
2102:                 ENDIF
2103: 
2104:                 IF loc_oBusca.this_lSelecionou AND USED("CrMoedas")
2105:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_DsMoeda", 5)
2106:                         THIS.pgf_4c_Paginas.Page2.txt_4c_DsMoeda.Value = ALLTRIM(CrMoedas.dmoes)
2107:                     ENDIF
2108:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_CdMoeda", 5)
2109:                         THIS.pgf_4c_Paginas.Page2.txt_4c_CdMoeda.Value = ALLTRIM(CrMoedas.cmoes)
2110:                     ENDIF
2111:                     loc_lResultado = .T.
2112:                 ENDIF
2113: 
2114:                 loc_oBusca.Release()
2115:             ENDIF
2116:         CATCH TO loException
2117:             MsgErro("Erro em FormFti.ValidarDsMoeda:" + CHR(13) + loException.Message, "Erro")
2118:         ENDTRY
2119: 
2120:         IF USED("CrMoedas")
2121:             USE IN CrMoedas
2122:         ENDIF
2123:     ENDPROC
2124: 
2125:     *==========================================================================
2126:     * ConfigPage2Activate - Atualiza caption Column3 do grd_4c_Custo (Page2.Activate)
2127:     *==========================================================================
2128:     PROCEDURE ConfigPage2Activate()
2129:         LOCAL loc_oPg2, loc_cCaption
2130:         loc_cCaption = "Coeficiente"
2131:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2132: 
2133:         IF PEMSTATUS(loc_oPg2, "opt_4c_Cfixo", 5)
2134:             IF loc_oPg2.opt_4c_Cfixo.Value = 2
2135:                 loc_cCaption = "( % )"
2136:             ENDIF
2137:         ENDIF
2138: 
2139:         IF PEMSTATUS(loc_oPg2.pgf_4c_Configuracao.Page2, "grd_4c_Custo", 5)
2140:             loc_oPg2.pgf_4c_Configuracao.Page2.grd_4c_Custo.Column3.Header1.Caption = loc_cCaption
2141:             loc_oPg2.pgf_4c_Configuracao.Page2.grd_4c_Custo.Column3.Header1.Refresh()
2142:         ENDIF
2143:     ENDPROC
2144: 
2145:     *==========================================================================
2146:     * GradeGrupoCol1When - When do Col1 (Cgrus) do grd_4c_Grade: salva AntValue
2147:     *==========================================================================
2148:     PROCEDURE GradeGrupoCol1When()
2149:         IF USED("csGrade") AND !EOF("csGrade") AND !BOF("csGrade")
2150:             THIS.this_cAntValue = ALLTRIM(csGrade.Cgrus)
2151:         ENDIF
2152:         RETURN .T.
2153:     ENDPROC
2154: 
2155:     *==========================================================================
2156:     * GradeGrupoCol1Valid - Valid do Col1 (Cgrus): valida grupo, preenche Dgrus+Coefs
2157:     *==========================================================================
2158:     PROCEDURE GradeGrupoCol1Valid()
2159:         LOCAL loc_lResultado, loc_cCodigo, loc_cSelecionado, loc_oBusca
2160:         loc_lResultado = .T.
2161: 
2162:         IF !USED("csGrade") OR EOF("csGrade") OR BOF("csGrade")
2163:             RETURN loc_lResultado
2164:         ENDIF
2165: 
2166:         loc_cCodigo = ALLTRIM(csGrade.Cgrus)
2167: 
2168:         IF EMPTY(loc_cCodigo) OR loc_cCodigo = THIS.this_cAntValue
2169:             RETURN loc_lResultado
2170:         ENDIF
2171: 
2172:         TRY
2173:             IF SEEK(loc_cCodigo, "CrSigCdGrp", "Cgrus")
2174:                 SELECT csGrade
2175:                 REPLACE Dgrus WITH ALLTRIM(CrSigCdGrp.Dgrus), ;
2176:                         Coefs WITH CrSigCdGrp.Coefs
2177:             ELSE
2178:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2179:                     "SigCdGrp", "cursor_4c_BuscaGrp", "Cgrus", loc_cCodigo, ;
2180:                     "Grupos de Produto")
2181:                 IF VARTYPE(loc_oBusca) = "O"
2182:                     IF !loc_oBusca.this_lAchouRegistro
2183:                         loc_oBusca.mAddColuna("Cgrus", "", "C" + CHR(243) + "digo")
2184:                         loc_oBusca.mAddColuna("Dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
2185:                         loc_oBusca.Show()
2186:                     ENDIF
2187:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
2188:                         loc_cSelecionado = ALLTRIM(cursor_4c_BuscaGrp.Cgrus)
2189:                         SELECT csGrade
2190:                         REPLACE Cgrus WITH loc_cSelecionado
2191:                         IF SEEK(loc_cSelecionado, "CrSigCdGrp", "Cgrus")
2192:                             SELECT csGrade
2193:                             REPLACE Dgrus WITH ALLTRIM(CrSigCdGrp.Dgrus), ;
2194:                                     Coefs WITH CrSigCdGrp.Coefs
2195:                         ENDIF
2196:                     ELSE
2197:                         SELECT csGrade
2198:                         REPLACE Cgrus WITH "", Dgrus WITH ""
2199:                     ENDIF
2200:                     loc_oBusca.Release()
2201:                 ENDIF
2202:                 IF USED("cursor_4c_BuscaGrp")
2203:                     USE IN cursor_4c_BuscaGrp
2204:                 ENDIF
2205:             ENDIF
2206:         CATCH TO loException
2207:             MsgErro("Erro em GradeGrupoCol1Valid:" + CHR(13) + loException.Message, "Erro")
2208:             loc_lResultado = .F.
2209:         ENDTRY
2210: 
2211:         RETURN loc_lResultado
2212:     ENDPROC
2213: 
2214:     *==========================================================================
2215:     * GradeGrupoCol3When - When do Col3 (Coefs) do grd_4c_Grade
2216:     *==========================================================================
2217:     PROCEDURE GradeGrupoCol3When()
2218:         SET CONFIRM ON
2219:         RETURN (!EMPTY(csGrade.Cgrus) OR !EMPTY(csGrade.Ordem))
2220:     ENDPROC
2221: 
2222:     *==========================================================================
2223:     * GradeGrupoCol3LostFocus - LostFocus do Col3: auto-insere linha apos Enter
2224:     *==========================================================================
2225:     PROCEDURE GradeGrupoCol3LostFocus(par_nKeyCode, par_nShiftAltCtrl)
2226:         LOCAL loc_oPag
2227:         loc_oPag = THIS.pgf_4c_Paginas.Page2.pgf_4c_Configuracao.Page1.grd_4c_Grade
2228: 
2229:         TRY
2230:             SELECT * FROM csGrade WHERE (EMPTY(Cgrus) AND Ordem <> 0) INTO CURSOR TmpBranco
2231:             IF RECCOUNT("TmpBranco") < 1 AND INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2232:                 SET CONFIRM OFF
2233:                 IF LASTKEY() = 13
2234:                     SELECT csGrade
2235:                     INSERT INTO csGrade (Cgrus) VALUES ("")
2236:                     loc_oPag.Refresh()
2237:                     loc_oPag.Column1.SetFocus()
2238:                     KEYBOARD "{DnArrow}"
2239:                 ENDIF
2240:             ENDIF
2241:         CATCH TO loException
2242:             MsgErro("Erro em GradeGrupoCol3LostFocus:" + CHR(13) + loException.Message, "Erro")
2243:         ENDTRY
2244: 
2245:         IF USED("TmpBranco")
2246:             USE IN TmpBranco
2247:         ENDIF
2248:     ENDPROC
2249: 
2250:     *==========================================================================
2251:     * GradeGrupoCol4When - When do Col4 (CPros) do grd_4c_Grade: salva AntValue
2252:     *==========================================================================
2253:     PROCEDURE GradeGrupoCol4When()
2254:         IF USED("csGrade") AND !EOF("csGrade") AND !BOF("csGrade")
2255:             THIS.this_cAntValue = ALLTRIM(csGrade.CPros)
2256:         ENDIF
2257:         RETURN .T.
2258:     ENDPROC
2259: 
2260:     *==========================================================================
2261:     * GradeGrupoCol4Valid - Valid do Col4 (CPros): abre picker SigCdPro se nao encontrado
2262:     *==========================================================================
2263:     PROCEDURE GradeGrupoCol4Valid()
2264:         LOCAL loc_lResultado, loc_cCodigo, loc_oBusca
2265:         loc_lResultado = .T.
2266: 
2267:         IF !USED("csGrade") OR EOF("csGrade") OR BOF("csGrade")
2268:             RETURN loc_lResultado
2269:         ENDIF
2270: 
2271:         loc_cCodigo = ALLTRIM(csGrade.CPros)
2272: 
2273:         IF EMPTY(loc_cCodigo) OR loc_cCodigo = THIS.this_cAntValue
2274:             RETURN loc_lResultado
2275:         ENDIF
2276: 
2277:         TRY
2278:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2279:                 "SigCdPro", "crListaRemota", "CPros", loc_cCodigo, ;
2280:                 "Sele" + CHR(231) + CHR(227) + "o")
2281:             IF VARTYPE(loc_oBusca) = "O"
2282:                 IF !loc_oBusca.this_lAchouRegistro
2283:                     loc_oBusca.mAddColuna("CPros", "", "Produto")
2284:                     loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
2285:                     loc_oBusca.Show()
2286:                 ENDIF
2287:                 IF loc_oBusca.this_lSelecionou AND USED("crListaRemota")
2288:                     SELECT csGrade
2289:                     REPLACE CPros WITH ALLTRIM(crListaRemota.CPros)
2290:                 ELSE
2291:                     IF LASTKEY() = 27
2292:                         SELECT csGrade
2293:                         REPLACE CPros WITH ""
2294:                     ENDIF
2295:                 ENDIF
2296:                 loc_oBusca.Release()
2297:             ENDIF
2298:             IF USED("crListaRemota")
2299:                 USE IN crListaRemota
2300:             ENDIF
2301:         CATCH TO loException
2302:             MsgErro("Erro em GradeGrupoCol4Valid:" + CHR(13) + loException.Message, "Erro")
2303:             loc_lResultado = .F.
2304:         ENDTRY
2305: 
2306:         RETURN loc_lResultado
2307:     ENDPROC
2308: 
2309:     *==========================================================================
2310:     * GradeCustoCol1When - When do Col1 (Cpros) do grd_4c_Custo: salva AntValue
2311:     *==========================================================================
2312:     PROCEDURE GradeCustoCol1When()
2313:         IF USED("csCusto") AND !EOF("csCusto") AND !BOF("csCusto")
2314:             THIS.this_cAntValue = ALLTRIM(csCusto.Cpros)
2315:         ENDIF
2316:         RETURN .T.
2317:     ENDPROC
2318: 
2319:     *==========================================================================
2320:     * GradeCustoCol1Valid - Valid do Col1 (Cpros): valida produto, preenche Dpros+Coefs+Seqs
2321:     *==========================================================================
2322:     PROCEDURE GradeCustoCol1Valid()
2323:         LOCAL loc_lResultado, loc_cCodigo, loc_cSelecionado, loc_oBusca, loc_cFiltro
2324:         loc_lResultado = .T.
2325: 
2326:         IF !USED("csCusto") OR EOF("csCusto") OR BOF("csCusto")
2327:             RETURN loc_lResultado
2328:         ENDIF
2329: 
2330:         loc_cCodigo = ALLTRIM(csCusto.Cpros)
2331: 
2332:         IF EMPTY(loc_cCodigo) OR loc_cCodigo = THIS.this_cAntValue
2333:             RETURN loc_lResultado
2334:         ENDIF
2335: 
2336:         TRY
2337:             IF SEEK(loc_cCodigo, "CrSigCdPro", "Cpros")
2338:                 SELECT csCusto
2339:                 REPLACE Dpros WITH ALLTRIM(CrSigCdPro.Dpros), ;
2340:                         Coefs WITH CrSigCdPro.pVens, ;
2341:                         Seqs  WITH RECNO("csCusto")
2342:             ELSE
2343:                 loc_cFiltro = ""
2344:                 IF USED("TmpParac") AND RECCOUNT("TmpParac") > 0
2345:                     SELECT TmpParac
2346:                     GO TOP
2347:                     IF !EMPTY(ALLTRIM(TmpParac.CgruCfxs))
2348:                         loc_cFiltro = "Cgrus = " + EscaparSQL(ALLTRIM(TmpParac.CgruCfxs))
2349:                     ENDIF
2350:                 ENDIF
2351:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2352:                     "SigCdPro", "cursor_4c_BuscaPro", "Cpros", loc_cCodigo, ;
2353:                     "Custos Fixo", .F., .T., loc_cFiltro)
2354:                 IF VARTYPE(loc_oBusca) = "O"
2355:                     IF !loc_oBusca.this_lAchouRegistro
2356:                         loc_oBusca.mAddColuna("Cpros", "", "C" + CHR(243) + "digo")
2357:                         loc_oBusca.mAddColuna("Dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
2358:                         loc_oBusca.Show()
2359:                     ENDIF
2360:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPro")
2361:                         loc_cSelecionado = ALLTRIM(cursor_4c_BuscaPro.Cpros)
2362:                         SELECT csCusto
2363:                         REPLACE Cpros WITH loc_cSelecionado
2364:                         IF SEEK(loc_cSelecionado, "CrSigCdPro", "Cpros")
2365:                             SELECT csCusto
2366:                             REPLACE Dpros WITH ALLTRIM(CrSigCdPro.Dpros), ;
2367:                                     Coefs WITH CrSigCdPro.pVens, ;
2368:                                     Seqs  WITH RECNO("csCusto")
2369:                         ELSE
2370:                             SELECT csCusto
2371:                             REPLACE Dpros WITH ALLTRIM(cursor_4c_BuscaPro.Dpros), ;
2372:                                     Coefs WITH cursor_4c_BuscaPro.pVens, ;
2373:                                     Seqs  WITH RECNO("csCusto")
2374:                         ENDIF
2375:                     ELSE
2376:                         SELECT csCusto
2377:                         REPLACE Cpros WITH "", Dpros WITH ""
2378:                     ENDIF
2379:                     loc_oBusca.Release()
2380:                 ENDIF
2381:                 IF USED("cursor_4c_BuscaPro")
2382:                     USE IN cursor_4c_BuscaPro
2383:                 ENDIF
2384:             ENDIF
2385:         CATCH TO loException
2386:             MsgErro("Erro em GradeCustoCol1Valid:" + CHR(13) + loException.Message, "Erro")
2387:             loc_lResultado = .F.
2388:         ENDTRY
2389: 
2390:         RETURN loc_lResultado
2391:     ENDPROC
2392: 
2393:     *==========================================================================
2394:     * GradeCustoCol3When - When do Col3 (Coefs) do grd_4c_Custo
2395:     *==========================================================================
2396:     PROCEDURE GradeCustoCol3When()
2397:         RETURN (!EMPTY(csCusto.Cpros))
2398:     ENDPROC
2399: 
2400:     *==========================================================================
2401:     * GradeCustoCol3LostFocus - LostFocus do Col3: auto-insere linha apos Enter
2402:     *==========================================================================
2403:     PROCEDURE GradeCustoCol3LostFocus(par_nKeyCode, par_nShiftAltCtrl)
2404:         LOCAL loc_oPag
2405:         loc_oPag = THIS.pgf_4c_Paginas.Page2.pgf_4c_Configuracao.Page2.grd_4c_Custo
2406: 
2407:         TRY
2408:             SELECT * FROM csCusto WHERE EMPTY(Cpros) INTO CURSOR TmpBranco
2409:             IF RECCOUNT("TmpBranco") < 1 AND INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2410:                 SELECT csCusto
2411:                 INSERT INTO csCusto (Cpros) VALUES ("")
2412:                 GO BOTTOM IN csCusto
2413:             ENDIF
2414:             IF LASTKEY() = 13
2415:                 SELECT csCusto
2416:                 loc_oPag.Refresh()
2417:                 loc_oPag.Column1.SetFocus()
2418:                 KEYBOARD "{DnArrow}"
2419:             ENDIF
2420:         CATCH TO loException
2421:             MsgErro("Erro em GradeCustoCol3LostFocus:" + CHR(13) + loException.Message, "Erro")
2422:         ENDTRY
2423: 
2424:         IF USED("TmpBranco")
2425:             USE IN TmpBranco
2426:         ENDIF
2427:     ENDPROC
2428: 
2429:     *==========================================================================
2430:     * GradeCustoCol4When - When do Col4 (Seqs) do grd_4c_Custo
2431:     *==========================================================================
2432:     PROCEDURE GradeCustoCol4When()
2433:         RETURN (!EMPTY(csCusto.Cpros))
2434:     ENDPROC
2435: 
2436: ENDDEFINE


### BO (C:\4c\projeto\app\classes\FtiBO.prg):
*==============================================================================
* FtiBO.prg - Business Object para Cadastro de Feitios
* Tabela principal : SigPrFti (cods = PK)
* Tabela de itens  : SigPrFto (cidchaves = PK)
* Gerado           : Fase 1/8 - Propriedades e Init
*==============================================================================

DEFINE CLASS FtiBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades herdadas (nomes CORRETOS do BusinessBase)
    *--------------------------------------------------------------------------
    this_cTabela      = "SigPrFti"
    this_cCampoChave  = "cods"

    *--------------------------------------------------------------------------
    * Campos de SigPrFti
    *--------------------------------------------------------------------------
    this_cCodigo      = ""    && cods       char(2)  PK
    this_cDescricao   = ""    && descs      char(20)
    this_nValor       = 0     && valors     numeric(11,2)
    this_cMoeda       = ""    && moedas     char(3)
    this_nAcrescimo   = 0     && acrescs    numeric(11,6)
    this_nTipoFeitio  = 1     && tpftios    numeric(1,0)  1=Por Peso 2=Valor Adicional 3=Informativo
    this_nFaixaInicial = 0    && faixais    numeric(11,6)
    this_nFaixaFinal  = 0     && faixafs    numeric(11,6)
    this_nPerdas      = 0     && perdas     numeric(3,1)
    this_nLucros      = 0     && lucros     numeric(5,2)
    this_nDivMult     = 1     && divmults   numeric(1,0)  1=Multiplicador 2=Divisor
    this_nTipo        = 2     && tipos      numeric(1,0)  1=Custo 2=Venda
    this_nAplscus     = 2     && aplscus    numeric(1,0)  1=Sim 2=Nao
    this_nEtiquetas   = 3     && etiquetas  numeric(1,0)  1=Sim 2=Sim-AU 3=Nao
    this_cMcustos     = ""    && mcustos    char(3)
    this_nVcustos     = 0     && vcustos    numeric(11,2)
    this_cUsuarios    = ""    && usuars     char(10)
    this_dDataRs      = {}    && datars     datetime

    *--------------------------------------------------------------------------
    * Propriedades auxiliares de controle
    *--------------------------------------------------------------------------
    this_cDescMoeda   = ""    && descricao da moeda (SigCdMoe.dmoes) - nao salvo
    this_lNovoRegistro = .F.

    *==========================================================================
    * Init - Configura tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigPrFti"
        THIS.this_cCampoChave = "cods"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *==========================================================================
    * NovoRegistro - Prepara BO para INSERT
    *==========================================================================
    PROCEDURE NovoRegistro()
        DODEFAULT()
        THIS.this_cCodigo       = ""
        THIS.this_cDescricao    = ""
        THIS.this_nValor        = 0
        THIS.this_cMoeda        = ""
        THIS.this_cDescMoeda    = ""
        THIS.this_nAcrescimo    = 0
        THIS.this_nTipoFeitio   = 1
        THIS.this_nFaixaInicial = 0
        THIS.this_nFaixaFinal   = 0
        THIS.this_nPerdas       = 0
        THIS.this_nLucros       = 0
        THIS.this_nDivMult      = 1
        THIS.this_nTipo         = 2
        THIS.this_nAplscus      = 2
        THIS.this_nEtiquetas    = 3
        THIS.this_cMcustos      = ""
        THIS.this_nVcustos      = 0
        THIS.this_cUsuarios     = ""
        THIS.this_dDataRs       = {}
        THIS.this_lNovoRegistro = .T.
    ENDPROC

    *==========================================================================
    * EditarRegistro - Prepara BO para UPDATE
    *==========================================================================
    PROCEDURE EditarRegistro()
        DODEFAULT()
        THIS.this_lNovoRegistro = .F.
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo       = ALLTRIM(TratarNulo(cods,      "C"))
            THIS.this_cDescricao    = ALLTRIM(TratarNulo(descs,     "C"))
            THIS.this_nValor        = TratarNulo(valors,    "N")
            THIS.this_cMoeda        = ALLTRIM(TratarNulo(moedas,    "C"))
            THIS.this_nAcrescimo    = TratarNulo(acrescs,   "N")
            THIS.this_nTipoFeitio   = TratarNulo(tpftios,   "N")
            THIS.this_nFaixaInicial = TratarNulo(faixais,   "N")
            THIS.this_nFaixaFinal   = TratarNulo(faixafs,   "N")
            THIS.this_nPerdas       = TratarNulo(perdas,    "N")
            THIS.this_nLucros       = TratarNulo(lucros,    "N")
            THIS.this_nDivMult      = TratarNulo(divmults,  "N")
            THIS.this_nTipo         = TratarNulo(tipos,     "N")
            THIS.this_nAplscus      = TratarNulo(aplscus,   "N")
            THIS.this_nEtiquetas    = TratarNulo(etiquetas, "N")
            THIS.this_cMcustos      = ALLTRIM(TratarNulo(mcustos,   "C"))
            THIS.this_nVcustos      = TratarNulo(vcustos,   "N")
            THIS.this_cUsuarios     = ALLTRIM(TratarNulo(usuars,    "C"))
            THIS.this_dDataRs       = TratarNulo(datars,    "D")
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Buscar - Lista registros de SigPrFti (PUBLIC)
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT cods, descs, valors, moedas, acrescs, tpftios" + ;
                       " FROM SigPrFti" + ;
                       " ORDER BY cods"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = "SELECT cods, descs, valors, moedas, acrescs, tpftios" + ;
                           " FROM SigPrFti" + ;
                           " WHERE " + par_cFiltro + ;
                           " ORDER BY cods"
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados") > 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar feitios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pelo codigo (PUBLIC)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT cods, descs, valors, moedas, acrescs, tpftios," + ;
                       " faixais, faixafs, perdas, lucros, divmults, tipos," + ;
                       " aplscus, etiquetas, mcustos, vcustos, usuars, datars" + ;
                       " FROM SigPrFti" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega") > 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ELSE
                MsgErro("Erro ao carregar feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir - INSERT em SigPrFti (PROTECTED - chamado por BusinessBase.Salvar)
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigPrFti" + ;
                       " (cods, descs, valors, moedas, acrescs, tpftios," + ;
                       "  faixais, faixafs, perdas, lucros, divmults, tipos," + ;
                       "  aplscus, etiquetas, mcustos, vcustos, usuars, datars)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo)                          + ", " + ;
                       EscaparSQL(THIS.this_cDescricao)                       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValor)                    + ", " + ;
                       EscaparSQL(THIS.this_cMoeda)                           + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAcrescimo)                + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipoFeitio)               + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFaixaInicial)             + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFaixaFinal)               + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPerdas)                   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLucros)                   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nDivMult)                  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipo)                     + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAplscus)                  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nEtiquetas)                + ", " + ;
                       EscaparSQL(THIS.this_cMcustos)                         + ", " + ;
                       FormatarNumeroSQL(THIS.this_nVcustos)                  + ", " + ;
                       EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado))               + ", " + ;
                       "GETDATE()" + ;
                       ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE em SigPrFti (PROTECTED - chamado por BusinessBase.Salvar)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigPrFti SET" + ;
                       "  descs    = " + EscaparSQL(THIS.this_cDescricao)          + ", " + ;
                       "  valors   = " + FormatarNumeroSQL(THIS.this_nValor)        + ", " + ;
                       "  moedas   = " + EscaparSQL(THIS.this_cMoeda)              + ", " + ;
                       "  acrescs  = " + FormatarNumeroSQL(THIS.this_nAcrescimo)    + ", " + ;
                       "  tpftios  = " + FormatarNumeroSQL(THIS.this_nTipoFeitio)   + ", " + ;
                       "  faixais  = " + FormatarNumeroSQL(THIS.this_nFaixaInicial) + ", " + ;
                       "  faixafs  = " + FormatarNumeroSQL(THIS.this_nFaixaFinal)   + ", " + ;
                       "  perdas   = " + FormatarNumeroSQL(THIS.this_nPerdas)       + ", " + ;
                       "  lucros   = " + FormatarNumeroSQL(THIS.this_nLucros)       + ", " + ;
                       "  divmults = " + FormatarNumeroSQL(THIS.this_nDivMult)      + ", " + ;
                       "  tipos    = " + FormatarNumeroSQL(THIS.this_nTipo)         + ", " + ;
                       "  aplscus  = " + FormatarNumeroSQL(THIS.this_nAplscus)      + ", " + ;
                       "  etiquetas= " + FormatarNumeroSQL(THIS.this_nEtiquetas)    + ", " + ;
                       "  mcustos  = " + EscaparSQL(THIS.this_cMcustos)            + ", " + ;
                       "  vcustos  = " + FormatarNumeroSQL(THIS.this_nVcustos)      + ", " + ;
                       "  usuars   = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado))  + ", " + ;
                       "  datars   = GETDATE()" + ;
                       " WHERE cods = " + EscaparSQL(THIS.this_cCodigo)

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE em SigPrFti + SigPrFto (PROTECTED)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrFto WHERE cods = " + EscaparSQL(THIS.this_cCodigo)
            IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                MsgErro("Erro ao excluir itens do feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_cSQL = "DELETE FROM SigPrFti WHERE cods = " + EscaparSQL(THIS.this_cCodigo)
                IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarItens - Carrega itens de SigPrFto para o cursor de grade (PUBLIC)
    * Popula cursores csGrade (grupos) e csCusto (custos fixo)
    *==========================================================================
    PROCEDURE CarregarItens(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Itens")
                USE IN cursor_4c_Itens
            ENDIF

            loc_cSQL = "SELECT cgrus, cpros, coefs, cidchaves, sgrus, ordem, seqs" + ;
                       " FROM SigPrFto" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo)) + ;
                       " ORDER BY seqs"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Itens") > 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar itens do feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.CarregarItens:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * SalvarItens - Persiste cursores csGrade e csCusto em SigPrFto (PUBLIC)
    * Deleta itens anteriores e reinsere (igual ao legado)
    *==========================================================================
    PROCEDURE SalvarItens(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            LOCAL loc_lErro
            loc_lErro = .F.

            loc_cSQL = "DELETE FROM SigPrFto WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo))
            IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                MsgErro("Erro ao limpar itens do feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lErro = .T.
            ENDIF

            IF USED("csGrade") AND !loc_lErro
                SELECT csGrade
                GO TOP
                SCAN
                    IF (!EMPTY(ALLTRIM(csGrade.Cgrus)) AND csGrade.Coefs <> 0) OR ;
                       (csGrade.Ordem <> 0 AND csGrade.Coefs <> 0)
                        loc_cSQL = "INSERT INTO SigPrFto" + ;
                                   " (cods, cgrus, cpros, coefs, cidchaves, ordem, seqs, calcfeitio, sgrus)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(ALLTRIM(par_cCodigo))      + ", " + ;
                                   EscaparSQL(ALLTRIM(csGrade.Cgrus))    + ", " + ;
                                   EscaparSQL(ALLTRIM(csGrade.CPros))    + ", " + ;
                                   FormatarNumeroSQL(csGrade.Coefs)      + ", " + ;
                                   EscaparSQL(fUniqueIds())              + ", " + ;
                                   FormatarNumeroSQL(csGrade.Ordem)      + ", " + ;
                                   "0"                                   + ", " + ;
                                   "0"                                   + ", " + ;
                                   "''" + ;
                                   ")"
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                            MsgErro("Erro ao inserir grupo no feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lErro = .T.
                            EXIT
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            IF USED("csCusto") AND !loc_lErro
                SELECT csCusto
                GO TOP
                SCAN
                    IF !EMPTY(ALLTRIM(csCusto.Cpros)) AND csCusto.Coefs <> 0
                        loc_cSQL = "INSERT INTO SigPrFto" + ;
                                   " (cods, cgrus, cpros, coefs, cidchaves, seqs, calcfeitio, sgrus, ordem)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(ALLTRIM(par_cCodigo))      + ", " + ;
                                   "''"                                  + ", " + ;
                                   EscaparSQL(ALLTRIM(csCusto.Cpros))    + ", " + ;
                                   FormatarNumeroSQL(csCusto.Coefs)      + ", " + ;
                                   EscaparSQL(fUniqueIds())              + ", " + ;
                                   FormatarNumeroSQL(csCusto.Seqs)       + ", " + ;
                                   "0"                                   + ", " + ;
                                   "''"                                  + ", " + ;
                                   "0" + ;
                                   ")"
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                            MsgErro("Erro ao inserir custo fixo no feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lErro = .T.
                            EXIT
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            IF !loc_lErro
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.SalvarItens:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarParametros - Carrega cursores auxiliares necessarios ao form (PUBLIC)
    * CrSigCdMoe (moedas), CrSigCdGrp (grupos produto), CrSigCdPro (produtos)
    *==========================================================================
    PROCEDURE CarregarParametros()
        LOCAL loc_lResultado, loc_cSQL, loc_cGrupoCfxs
        loc_lResultado = .F.

        TRY
            IF USED("CrSigCdMoe")
                USE IN CrSigCdMoe
            ENDIF
            loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdMoe") < 1
                MsgErro("Erro ao carregar moedas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ENDIF
            SELECT CrSigCdMoe
            INDEX ON cmoes TAG CMoes

            IF USED("TmpParac")
                USE IN TmpParac
            ENDIF
            loc_cSQL = "SELECT CgruCfxs FROM SigCdPac"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpParac") < 1
                MsgErro("Erro ao carregar parametros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ENDIF
            IF RECCOUNT("TmpParac") > 0
                SELECT TmpParac
                GO TOP
                loc_cGrupoCfxs = ALLTRIM(TmpParac.CgruCfxs)
            ELSE
                loc_cGrupoCfxs = ""
            ENDIF

            IF USED("CrSigCdGrp")
                USE IN CrSigCdGrp
            ENDIF
            loc_cSQL = "SELECT Cgrus, Dgrus, Coefs FROM SigCdGrp"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdGrp") < 1
                MsgErro("Erro ao carregar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ENDIF
            SELECT CrSigCdGrp
            INDEX ON Cgrus TAG Cgrus

            IF USED("CrSigCdPro")
                USE IN CrSigCdPro
            ENDIF
            IF !EMPTY(loc_cGrupoCfxs)
                loc_cSQL = "SELECT Cpros, Dpros, pVens FROM SigCdPro" + ;
                           " WHERE Cgrus = " + EscaparSQL(loc_cGrupoCfxs)
            ELSE
                loc_cSQL = "SELECT Cpros, Dpros, pVens FROM SigCdPro"
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdPro") < 1
                MsgErro("Erro ao carregar produtos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ENDIF
            SELECT CrSigCdPro
            INDEX ON cpros TAG Cpros

            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro em FtiBO.CarregarParametros:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarDuplicidade - Verifica duplicidade de grupos e custos na grade (PUBLIC)
    *==========================================================================
    PROCEDURE ValidarDuplicidade()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .T.

        TRY
            IF USED("CsDuplica")
                USE IN CsDuplica
            ENDIF

            SELECT Cgrus, CPros, SUM(1) AS Tot FROM csGrade ;
                WHERE Cgrus <> ' ' ;
                GROUP BY Cgrus, CPros ;
                INTO CURSOR CsDuplica ;
                HAVING SUM(1) > 1

            IF RECCOUNT("CsDuplica") > 0
                MsgAviso("Existem Grupos/Produtos configurados em duplicidade!", "Valida" + CHR(231) + CHR(227) + "o")
                USE IN CsDuplica
                loc_lResultado = .F.
            ENDIF
            IF USED("CsDuplica")
                USE IN CsDuplica
            ENDIF

            SELECT Cpros, SUM(1) AS Tot FROM csCusto ;
                WHERE Cpros <> ' ' ;
                GROUP BY Cpros ;
                INTO CURSOR CsDuplica ;
                HAVING SUM(1) > 1

            IF RECCOUNT("CsDuplica") > 0
                MsgAviso("Existem Custos Fixo configurados em duplicidade!", "Valida" + CHR(231) + CHR(227) + "o")
                USE IN CsDuplica
                loc_lResultado = .F.
            ENDIF
            IF USED("CsDuplica")
                USE IN CsDuplica
            ENDIF

            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro em FtiBO.ValidarDuplicidade:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarFaixa - Valida que o acrescimo esta dentro da faixa (PUBLIC)
    *==========================================================================
    PROCEDURE ValidarFaixa()
        IF THIS.this_nFaixaFinal > 0
            IF !BETWEEN(THIS.this_nAcrescimo, THIS.this_nFaixaInicial, THIS.this_nFaixaFinal)
                MsgAviso("O multiplicador tem que estar dentro da Faixa!", "Valida" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
        ENDIF
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ValidarConflitoCampos - Valida que Multiplicador/Valor nao coexistem com grade (PUBLIC)
    *==========================================================================
    PROCEDURE ValidarConflitoCampos()
        LOCAL loc_lResultado
        loc_lResultado = .T.

        TRY
            IF THIS.this_nAcrescimo <> 0 OR THIS.this_nValor <> 0
                IF USED("ChkDados")
                    USE IN ChkDados
                ENDIF

                SELECT " " AS Agrupar, SUM(1) AS Tot FROM csGrade ;
                    WHERE Cgrus <> ' ' AND Coefs <> 0 ;
                    INTO CURSOR ChkDados GROUP BY 1

                SELECT ChkDados
                GO TOP
                IF Tot > 0
                    MsgAviso("O Campo Multiplicador Ou Valor n" + CHR(227) + "o podem ser informados" + ;
                             CHR(13) + "em conjunto com grade de custos", "Valida" + CHR(231) + CHR(227) + "o")
                    USE IN ChkDados
                    loc_lResultado = .F.
                ENDIF

                SELECT " " AS Agrupar, SUM(1) AS Tot FROM csCusto ;
                    WHERE Cpros <> ' ' ;
                    INTO CURSOR ChkDados GROUP BY 1

                SELECT ChkDados
                GO TOP
                IF Tot > 0
                    MsgAviso("O Campo Multiplicador Ou Valor n" + CHR(227) + "o podem ser informados" + ;
                             CHR(13) + "em conjunto com grade de custos", "Valida" + CHR(231) + CHR(227) + "o")
                    USE IN ChkDados
                    loc_lResultado = .F.
                ENDIF

                IF USED("ChkDados")
                    USE IN ChkDados
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.ValidarConflitoCampos:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * VerificarCodigoExistente - Verifica se codigo ja existe (para INSERT) (PUBLIC)
    *==========================================================================
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_lExiste, loc_cSQL
        loc_lExiste = .F.

        TRY
            IF USED("cursor_4c_Chk")
                USE IN cursor_4c_Chk
            ENDIF

            loc_cSQL = "SELECT cods FROM SigPrFti WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Chk") > 0
                loc_lExiste = (RECCOUNT("cursor_4c_Chk") > 0)
            ENDIF

            IF USED("cursor_4c_Chk")
                USE IN cursor_4c_Chk
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.VerificarCodigoExistente:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *==========================================================================
    * Destroy
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_aCursores(9), loc_i
        loc_aCursores(1) = "cursor_4c_Dados"
        loc_aCursores(2) = "cursor_4c_Carrega"
        loc_aCursores(3) = "cursor_4c_Itens"
        loc_aCursores(4) = "cursor_4c_Chk"
        loc_aCursores(5) = "CrSigCdMoe"
        loc_aCursores(6) = "TmpParac"
        loc_aCursores(7) = "CrSigCdGrp"
        loc_aCursores(8) = "CrSigCdPro"
        loc_aCursores(9) = "ChkDados"

        FOR loc_i = 1 TO ALEN(loc_aCursores)
            IF USED(loc_aCursores(loc_i))
                USE IN (loc_aCursores(loc_i))
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

ENDDEFINE

