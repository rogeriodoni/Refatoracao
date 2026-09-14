# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (5)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-HEADER] Header Caption 'Conta' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: UF, Município, Código, Descrição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Nome' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: UF, Município, Código, Descrição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Conta' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: UF, Município, Código, Descrição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Nome' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: UF, Município, Código, Descrição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formrst.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2010 linhas total):

*-- Linhas 23 a 159:
23:     this_cModoAtual      = "LISTA"
24: 
25:     *===========================================================================
26:     * Init - Apenas DODEFAULT (FormBase.Init chama InicializarForm)
27:     * REGRA CRITICA: NAO chamar THIS.InicializarForm() aqui - evita chamada dupla
28:     *===========================================================================
29:     PROCEDURE Init()
30:         RETURN DODEFAULT()
31:     ENDPROC
32: 
33:     *===========================================================================
34:     * InicializarForm - Configura estrutura completa do formulario
35:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
36:     *===========================================================================
37:     PROTECTED PROCEDURE InicializarForm()
38:         LOCAL loc_lSucesso
39:         loc_lSucesso = .F.
40: 
41:         TRY
42:             THIS.this_oBusinessObject = CREATEOBJECT("rstBO")
43: 
44:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
45:                 MostrarErro("Erro ao criar rstBO" + CHR(13) + ;
46:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
47:                     "Formrst.InicializarForm")
48:             ELSE
49:                 THIS.ConfigurarPageFrame()
50:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
51:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
52:                 THIS.pgf_4c_Paginas.Visible   = .T.
53:                 THIS.pgf_4c_Paginas.ActivePage = 1
54:                 THIS.this_cModoAtual = "LISTA"
55: 
56:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
57:                     THIS.CarregarLista()
58:                 ENDIF
59: 
60:                 loc_lSucesso = .T.
61:             ENDIF
62: 
63:         CATCH TO loException
64:             MostrarErro("Erro ao inicializar Formrst:" + CHR(13) + ;
65:                 loException.Message + CHR(13) + ;
66:                 "Linha: " + TRANSFORM(loException.LineNo), ;
67:                 "Formrst.InicializarForm")
68:         ENDTRY
69: 
70:         RETURN loc_lSucesso
71:     ENDPROC
72: 
73:     *===========================================================================
74:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
75:     * PageFrame.Top = -29 para esconder abas
76:     * Todos os controles internos compensam +29 no Top
77:     *===========================================================================
78:     PROTECTED PROCEDURE ConfigurarPageFrame()
79:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
80: 
81:         WITH THIS.pgf_4c_Paginas
82:             .PageCount = 2
83:             .Top       = -29
84:             .Left      = 0
85:             .Width     = THIS.Width
86:             .Height    = THIS.Height + 29
87:             .Tabs      = .F.
88:             .Visible   = .T.
89: 
90:             .Page1.Caption   = "Lista"
91:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
92:             .Page1.BackColor = RGB(255, 255, 255)
93: 
94:             .Page2.Caption   = "Dados"
95:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
96:             .Page2.BackColor = RGB(255, 255, 255)
97:         ENDWITH
98: 
99:         THIS.ConfigurarPaginaLista()
100:         THIS.ConfigurarPaginaDados()
101:     ENDPROC
102: 
103:     *===========================================================================
104:     * ConfigurarPaginaLista - Configura Page1 (Lista) com Grid e botoes CRUD
105:     * Cabecalho, cnt_4c_Botoes (5 botoes), cnt_4c_Saida (Encerrar), grd_4c_Lista
106:     *===========================================================================
107:     PROTECTED PROCEDURE ConfigurarPaginaLista()
108:         LOCAL loc_oPagina, loc_oGrid
109:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
110: 
111:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
112:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
113: 
114:         *-- Container Cabecalho escuro com titulo (cntSombra no legado)
115:         *-- Top original=2; compensacao PageFrame +29 -> Top=31
116:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
117:         WITH loc_oPagina.cnt_4c_Cabecalho
118:             .Top         = 31
119:             .Left        = 0
120:             .Width       = THIS.Width
121:             .Height      = 80
122:             .BackColor   = RGB(100, 100, 100)
123:             .BorderWidth = 0
124:             .Visible     = .T.
125:         ENDWITH
126: 
127:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
128:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
129:             .Caption   = THIS.Caption
130:             .Top       = 15
131:             .Left      = 10
132:             .Width     = 769
133:             .Height    = 40
134:             .FontName  = "Tahoma"
135:             .FontSize  = 16
136:             .FontBold  = .T.
137:             .ForeColor = RGB(0, 0, 0)
138:             .BackStyle = 0
139:             .AutoSize  = .F.
140:             .Visible   = .T.
141:         ENDWITH
142: 
143:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
144:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
145:             .Caption   = THIS.Caption
146:             .Top       = 18
147:             .Left      = 10
148:             .Width     = 769
149:             .Height    = 46
150:             .FontName  = "Tahoma"
151:             .FontSize  = 16
152:             .FontBold  = .T.
153:             .ForeColor = RGB(255, 255, 255)
154:             .BackStyle = 0
155:             .AutoSize  = .F.
156:             .Visible   = .T.
157:         ENDWITH
158: 
159:         *-- Container Botoes CRUD (Grupo_op no legado - lado direito)

*-- Linhas 192 a 427:
192:             .AutoSize        = .F.
193:             .Visible         = .T.
194:         ENDWITH
195:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
196: 
197:         *-- Botao Visualizar
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
209:             .FontName        = "Tahoma"
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
222:         *-- Botao Alterar
223:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
224:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
225:             .Caption         = "Alterar"
226:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
227:             .PicturePosition = 13
228:             .Top             = 5
229:             .Left            = 155
230:             .Width           = 75
231:             .Height          = 75
232:             .BackColor       = RGB(255, 255, 255)
233:             .ForeColor       = RGB(90, 90, 90)
234:             .FontName        = "Tahoma"
235:             .FontBold        = .T.
236:             .FontItalic      = .T.
237:             .FontSize        = 8
238:             .Themes          = .F.
239:             .SpecialEffect   = 0
240:             .MousePointer    = 15
241:             .WordWrap        = .T.
242:             .AutoSize        = .F.
243:             .Visible         = .T.
244:         ENDWITH
245:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
246: 
247:         *-- Botao Excluir
248:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
249:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
250:             .Caption         = "Excluir"
251:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
252:             .PicturePosition = 13
253:             .Top             = 5
254:             .Left            = 230
255:             .Width           = 75
256:             .Height          = 75
257:             .BackColor       = RGB(255, 255, 255)
258:             .ForeColor       = RGB(90, 90, 90)
259:             .FontName        = "Tahoma"
260:             .FontBold        = .T.
261:             .FontItalic      = .T.
262:             .FontSize        = 8
263:             .Themes          = .F.
264:             .SpecialEffect   = 0
265:             .MousePointer    = 15
266:             .WordWrap        = .T.
267:             .AutoSize        = .F.
268:             .Visible         = .T.
269:         ENDWITH
270:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
271: 
272:         *-- Botao Buscar
273:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
274:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
275:             .Caption         = "Buscar"
276:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
277:             .PicturePosition = 13
278:             .Top             = 5
279:             .Left            = 305
280:             .Width           = 75
281:             .Height          = 75
282:             .BackColor       = RGB(255, 255, 255)
283:             .ForeColor       = RGB(90, 90, 90)
284:             .FontName        = "Tahoma"
285:             .FontBold        = .T.
286:             .FontItalic      = .T.
287:             .FontSize        = 8
288:             .Themes          = .F.
289:             .SpecialEffect   = 0
290:             .MousePointer    = 15
291:             .WordWrap        = .T.
292:             .AutoSize        = .F.
293:             .Visible         = .T.
294:         ENDWITH
295:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
296: 
297:         *-- Container Saida (Grupo_Saida - padrao canonico: Left=917, Width=90)
298:         *-- Transparente sobre a Page - NAO subtrair da largura do cabecalho/grade
299:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
300:         WITH loc_oPagina.cnt_4c_Saida
301:             .Top         = 29
302:             .Left        = 917
303:             .Width       = 90
304:             .Height      = 85
305:             .BackStyle   = 0
306:             .BorderWidth = 0
307:             .Visible     = .T.
308:         ENDWITH
309: 
310:         *-- Botao Encerrar
311:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
312:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
313:             .Caption         = "Encerrar"
314:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
315:             .PicturePosition = 13
316:             .Top             = 5
317:             .Left            = 5
318:             .Width           = 75
319:             .Height          = 75
320:             .BackColor       = RGB(255, 255, 255)
321:             .ForeColor       = RGB(90, 90, 90)
322:             .FontName        = "Tahoma"
323:             .FontBold        = .T.
324:             .FontItalic      = .T.
325:             .FontSize        = 8
326:             .Themes          = .F.
327:             .SpecialEffect   = 0
328:             .MousePointer    = 15
329:             .WordWrap        = .T.
330:             .AutoSize        = .F.
331:             .Visible         = .T.
332:         ENDWITH
333:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
334: 
335:         *-- Grid grd_4c_Lista - exibe SigCdRst + SigCdCli
336:         *-- Top=88+29=117 (compensacao PageFrame); Width=890; Height=483
337:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
338:         loc_oGrid = loc_oPagina.grd_4c_Lista
339: 
340:         loc_oGrid.RecordSource  = ""
341:         loc_oGrid.ColumnCount   = 2
342: 
343:         WITH loc_oGrid
344:             .Top                = 117
345:             .Left               = 26
346:             .Width              = 890
347:             .Height             = 483
348:             .DeleteMark         = .F.
349:             .RecordMark         = .F.
350:             .RowHeight          = 16
351:             .ScrollBars         = 2
352:             .GridLines          = 3
353:             .FontName           = "Verdana"
354:             .FontSize           = 8
355:             .ForeColor          = RGB(90, 90, 90)
356:             .BackColor          = RGB(255, 255, 255)
357:             .GridLineColor      = RGB(238, 238, 238)
358:             .HighlightBackColor = RGB(255, 255, 255)
359:             .HighlightForeColor = RGB(15, 41, 104)
360:             .HighlightStyle     = 2
361:             .Visible            = .T.
362:         ENDWITH
363: 
364:         WITH loc_oGrid.Column1
365:             .Width              = 100
366:             .Resizable          = .T.
367:             .Header1.Caption    = "Conta"
368:         ENDWITH
369: 
370:         WITH loc_oGrid.Column2
371:             .Width              = 450
372:             .Resizable          = .T.
373:             .Header1.Caption    = "Nome"
374:         ENDWITH
375: 
376:         BINDEVENT(loc_oGrid, "DblClick", THIS, "BtnVisualizarClick")
377: 
378:         THIS.TornarControlesVisiveis(loc_oPagina)
379:     ENDPROC
380: 
381:     *===========================================================================
382:     * ConfigurarPaginaDados - Configura Page2 (Dados)
383:     * Fase 5: cnt_4c_Salva + labels + TextBoxes + OptionGroup + Shape + Image
384:     * Fase 6: GradMuni + GradProd (grids com botoes inline)
385:     * Top de todos os controles = Top_original_legado + 29 (compensacao PageFrame)
386:     *===========================================================================
387:     PROTECTED PROCEDURE ConfigurarPaginaDados()
388:         LOCAL loc_oPagina
389:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
390: 
391:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
392:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
393: 
394:         *-- ===================================================================
395:         *-- cnt_4c_Salva (Grupo_Salva) - Confirmar + Cancelar
396:         *-- Canonico: Top=4+29=33, Left=842, Width=160, Height=85
397:         *-- ===================================================================
398:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
399:         WITH loc_oPagina.cnt_4c_Salva
400:             .Top         = 33
401:             .Left        = 842
402:             .Width       = 160
403:             .Height      = 85
404:             .BackStyle   = 0
405:             .BorderWidth = 0
406:             .Visible     = .T.
407:         ENDWITH
408: 
409:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
410:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
411:             .Caption         = "Confirmar"
412:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
413:             .PicturePosition = 13
414:             .Top             = 5
415:             .Left            = 5
416:             .Width           = 75
417:             .Height          = 75
418:             .BackColor       = RGB(255, 255, 255)
419:             .ForeColor       = RGB(90, 90, 90)
420:             .FontName        = "Tahoma"
421:             .FontBold        = .T.
422:             .FontItalic      = .T.
423:             .FontSize        = 8
424:             .Themes          = .F.
425:             .SpecialEffect   = 0
426:             .MousePointer    = 15
427:             .WordWrap        = .T.

*-- Linhas 488 a 574:
488:             .BorderStyle = 1
489:             .Visible     = .T.
490:         ENDWITH
491:         BINDEVENT(loc_oPagina.txt_4c_Codigo, "KeyPress", THIS, "ValidarContaCodigo")
492: 
493:         *-- Get_Desc: txt_4c_Desc - Top=47+29=76, Left=212, Width=290
494:         *-- When original: EMPTY(get_codigo) AND pcescolha='INSERIR'
495:         loc_oPagina.AddObject("txt_4c_Desc", "TextBox")
496:         WITH loc_oPagina.txt_4c_Desc
497:             .Value       = ""
498:             .Top         = 76
499:             .Left        = 212
500:             .Width       = 290
501:             .Height      = 25
502:             .MaxLength   = 40
503:             .FontName    = "Tahoma"
504:             .FontSize    = 8
505:             .ForeColor   = RGB(90, 90, 90)
506:             .BackColor   = RGB(255, 255, 255)
507:             .BorderStyle = 1
508:             .Visible     = .T.
509:         ENDWITH
510:         BINDEVENT(loc_oPagina.txt_4c_Desc, "KeyPress", THIS, "ValidarContaDescricao")
511: 
512:         *-- ===================================================================
513:         *-- Say11: "Checa Matriz :" - Top=79+29=108, Left=42, Width=71
514:         *-- ===================================================================
515:         loc_oPagina.AddObject("lbl_4c_ChkMatrix", "Label")
516:         WITH loc_oPagina.lbl_4c_ChkMatrix
517:             .Caption   = "Checa Matriz :"
518:             .Top       = 108
519:             .Left      = 42
520:             .Width     = 80
521:             .Height    = 17
522:             .FontName  = "Tahoma"
523:             .FontSize  = 8
524:             .ForeColor = RGB(90, 90, 90)
525:             .BackStyle = 0
526:             .AutoSize  = .F.
527:             .Alignment = 1
528:             .Visible   = .T.
529:         ENDWITH
530: 
531:         *-- op_con: opt_4c_ChkMatrix - Top=77+29=106, Left=124, Width=98, Height=22
532:         *-- Value=1 = Sim (this_nChkMatrs=1), Value=2 = Nao (this_nChkMatrs=0)
533:         *-- When original: INLIST(pcEscolha,'INSERIR','ALTERAR')
534:         loc_oPagina.AddObject("opt_4c_ChkMatrix", "OptionGroup")
535:         WITH loc_oPagina.opt_4c_ChkMatrix
536:             .ButtonCount = 2
537:             .Top         = 106
538:             .Left        = 124
539:             .Width       = 103
540:             .Height      = 22
541:             .BackStyle   = 0
542:             .BorderStyle = 0
543:             .Value       = 2
544:             .Visible     = .T.
545:         ENDWITH
546:         WITH loc_oPagina.opt_4c_ChkMatrix.Buttons(1)
547:             .Caption   = "Sim"
548:             .BackStyle = 0
549:             .Left      = 5
550:             .Top       = 3
551:             .Width     = 42
552:             .AutoSize  = .T.
553:             .FontName  = "Tahoma"
554:             .FontSize  = 8
555:             .ForeColor = RGB(90, 90, 90)
556:             .Themes    = .F.
557:         ENDWITH
558:         WITH loc_oPagina.opt_4c_ChkMatrix.Buttons(2)
559:             .Caption   = "N" + CHR(227) + "o"
560:             .BackStyle = 0
561:             .Left      = 50
562:             .Top       = 3
563:             .Width     = 43
564:             .AutoSize  = .T.
565:             .FontName  = "Tahoma"
566:             .FontSize  = 8
567:             .ForeColor = RGB(90, 90, 90)
568:             .Themes    = .F.
569:         ENDWITH
570: 
571:         *-- ===================================================================
572:         *-- Shape4: shp_4c_Shape4 - borda decorativa em volta da imagem do produto
573:         *-- Top=10+29=39, Left=648, Width=163, Height=111
574:         *-- ===================================================================

*-- Linhas 595 a 638:
595:             .Stretch = 2
596:             .Visible = .F.
597:         ENDWITH
598:         BINDEVENT(loc_oPagina.img_4c_ImgProds, "Click", THIS, "ImgProdsClick")
599: 
600:         *-- ===================================================================
601:         *-- Say3: "Municípios pertencentes a esta restrição:"
602:         *-- Top=116+29=145, Left=44, Width=199, Height=15
603:         *-- ===================================================================
604:         loc_oPagina.AddObject("lbl_4c_TituloMunis", "Label")
605:         WITH loc_oPagina.lbl_4c_TituloMunis
606:             .Caption   = "Munic" + CHR(237) + "pios pertencentes a esta restri" + CHR(231) + CHR(227) + "o:"
607:             .Top       = 145
608:             .Left      = 44
609:             .Width     = 199
610:             .Height    = 15
611:             .FontName  = "Tahoma"
612:             .FontSize  = 8
613:             .ForeColor = RGB(90, 90, 90)
614:             .BackStyle = 0
615:             .AutoSize  = .F.
616:             .Visible   = .T.
617:         ENDWITH
618: 
619:         *-- ===================================================================
620:         *-- Say4: "Produtos restringidos:"
621:         *-- Top=116+29=145, Left=418, Width=108, Height=15
622:         *-- ===================================================================
623:         loc_oPagina.AddObject("lbl_4c_TituloProds", "Label")
624:         WITH loc_oPagina.lbl_4c_TituloProds
625:             .Caption   = "Produtos restringidos:"
626:             .Top       = 145
627:             .Left      = 418
628:             .Width     = 108
629:             .Height    = 15
630:             .FontName  = "Tahoma"
631:             .FontSize  = 8
632:             .ForeColor = RGB(90, 90, 90)
633:             .BackStyle = 0
634:             .AutoSize  = .F.
635:             .Visible   = .T.
636:         ENDWITH
637: 
638:         *-- ===================================================================

*-- Linhas 678 a 744:
678:             .SpecialEffect   = 0
679:             .Visible         = .T.
680:         ENDWITH
681:         BINDEVENT(loc_oPagina.cmd_4c_InserirMuni, "Click", THIS, "BtnInserirMuniClick")
682: 
683:         *-- cmd_4c_ExcluirMuni - Excluir linha do GradMuni (excluir do legado)
684:         *-- Top=350+29=379, Left=356, Width=45, Height=45
685:         loc_oPagina.AddObject("cmd_4c_ExcluirMuni", "CommandButton")
686:         WITH loc_oPagina.cmd_4c_ExcluirMuni
687:             .Caption         = ""
688:             .ToolTipText     = "Excluir Munic" + CHR(237) + "pio"
689:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
690:             .PicturePosition = 0
691:             .Top             = 379
692:             .Left            = 356
693:             .Width           = 45
694:             .Height          = 45
695:             .FontBold        = .T.
696:             .FontName        = "Verdana"
697:             .FontSize        = 8
698:             .ForeColor       = RGB(36, 84, 155)
699:             .BackColor       = RGB(255, 255, 255)
700:             .Themes          = .F.
701:             .SpecialEffect   = 0
702:             .Visible         = .T.
703:         ENDWITH
704:         BINDEVENT(loc_oPagina.cmd_4c_ExcluirMuni, "Click", THIS, "BtnExcluirMuniClick")
705: 
706:         *-- ===================================================================
707:         *-- grd_4c_Munis (GradMuni) - Grade de Municipios
708:         *-- Top=133+29=162, Left=41, Width=309, Height=456
709:         *-- Col1=UF(24), Col2=Municipio(263)
710:         *-- ===================================================================
711:         loc_oPagina.AddObject("grd_4c_Munis", "Grid")
712:         loc_oPagina.grd_4c_Munis.ColumnCount = 3
713:         loc_oPagina.grd_4c_Munis.RecordSource = "cursor_4c_Munis"
714:         loc_oPagina.grd_4c_Munis.ColumnCount  = 2
715: 
716:         WITH loc_oPagina.grd_4c_Munis
717:             .Top                = 162
718:             .Left               = 41
719:             .Width              = 309
720:             .Height             = 456
721:             .DeleteMark         = .F.
722:             .RecordMark         = .F.
723:             .RowHeight          = 16
724:             .ScrollBars         = 2
725:             .GridLines          = 3
726:             .GridLineColor      = RGB(238, 238, 238)
727:             .HeaderHeight       = 20
728:             .FontName           = "Tahoma"
729:             .FontSize           = 8
730:             .ForeColor          = RGB(0, 0, 0)
731:             .BackColor          = RGB(255, 255, 255)
732:             .HighlightBackColor = RGB(255, 255, 255)
733:             .HighlightForeColor = RGB(15, 41, 104)
734:             .HighlightStyle     = 2
735:             .Visible            = .T.
736: 
737:             .Column1.ControlSource     = "cursor_4c_Munis.uf"
738:             .Column1.Width             = 24
739:             .Column1.FontName          = "Tahoma"
740:             .Column1.FontSize          = 8
741:             .Column1.Resizable         = .T.
742:             .Column1.Header1.Caption   = "UF"
743:             .Column1.Header1.Alignment = 2
744: 

*-- Linhas 751 a 843:
751:             .Column2.Header1.Alignment = 2
752:         ENDWITH
753: 
754:         BINDEVENT(loc_oPagina.grd_4c_Munis.Column1.Text1, "KeyPress", THIS, "GradMuniUFLostFocus")
755:         BINDEVENT(loc_oPagina.grd_4c_Munis.Column2.Text1, "KeyPress", THIS, "GradMuniMunLostFocus")
756: 
757:         *-- ===================================================================
758:         *-- cmd_4c_InserirProd - Inserir linha no GradProd (InserirV do legado)
759:         *-- Top=305+29=334, Left=912, Width=45, Height=45
760:         *-- ===================================================================
761:         loc_oPagina.AddObject("cmd_4c_InserirProd", "CommandButton")
762:         WITH loc_oPagina.cmd_4c_InserirProd
763:             .Caption         = ""
764:             .ToolTipText     = "Inserir Produto"
765:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
766:             .PicturePosition = 0
767:             .Top             = 334
768:             .Left            = 912
769:             .Width           = 45
770:             .Height          = 45
771:             .FontBold        = .T.
772:             .FontName        = "Verdana"
773:             .FontSize        = 8
774:             .ForeColor       = RGB(36, 84, 155)
775:             .BackColor       = RGB(255, 255, 255)
776:             .Themes          = .F.
777:             .SpecialEffect   = 0
778:             .Visible         = .T.
779:         ENDWITH
780:         BINDEVENT(loc_oPagina.cmd_4c_InserirProd, "Click", THIS, "BtnInserirProdClick")
781: 
782:         *-- cmd_4c_ExcluirProd - Excluir linha do GradProd (ExcluirV do legado)
783:         *-- Top=350+29=379, Left=912, Width=45, Height=45
784:         loc_oPagina.AddObject("cmd_4c_ExcluirProd", "CommandButton")
785:         WITH loc_oPagina.cmd_4c_ExcluirProd
786:             .Caption         = ""
787:             .ToolTipText     = "Excluir Produto"
788:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
789:             .PicturePosition = 0
790:             .Top             = 379
791:             .Left            = 912
792:             .Width           = 45
793:             .Height          = 45
794:             .FontBold        = .T.
795:             .FontName        = "Verdana"
796:             .FontSize        = 8
797:             .ForeColor       = RGB(36, 84, 155)
798:             .BackColor       = RGB(255, 255, 255)
799:             .Themes          = .F.
800:             .SpecialEffect   = 0
801:             .Visible         = .T.
802:         ENDWITH
803:         BINDEVENT(loc_oPagina.cmd_4c_ExcluirProd, "Click", THIS, "BtnExcluirProdClick")
804: 
805:         *-- ===================================================================
806:         *-- grd_4c_Prods (GradProd) - Grade de Produtos
807:         *-- Top=133+29=162, Left=417, Width=490, Height=456
808:         *-- Col1=Codigo(108), Col2=Descricao(360)
809:         *-- ===================================================================
810:         loc_oPagina.AddObject("grd_4c_Prods", "Grid")
811:         loc_oPagina.grd_4c_Prods.ColumnCount = 3
812:         loc_oPagina.grd_4c_Prods.RecordSource = "cursor_4c_Prods"
813:         loc_oPagina.grd_4c_Prods.ColumnCount  = 2
814: 
815:         WITH loc_oPagina.grd_4c_Prods
816:             .Top                = 162
817:             .Left               = 417
818:             .Width              = 490
819:             .Height             = 456
820:             .DeleteMark         = .F.
821:             .RecordMark         = .F.
822:             .RowHeight          = 16
823:             .ScrollBars         = 2
824:             .GridLines          = 3
825:             .GridLineColor      = RGB(238, 238, 238)
826:             .HeaderHeight       = 20
827:             .FontName           = "Tahoma"
828:             .FontSize           = 8
829:             .ForeColor          = RGB(0, 0, 0)
830:             .BackColor          = RGB(255, 255, 255)
831:             .HighlightBackColor = RGB(255, 255, 255)
832:             .HighlightForeColor = RGB(15, 41, 104)
833:             .HighlightStyle     = 2
834:             .Visible            = .T.
835: 
836:             .Column1.ControlSource     = "cursor_4c_Prods.cpros"
837:             .Column1.Width             = 108
838:             .Column1.FontName          = "Tahoma"
839:             .Column1.FontSize          = 8
840:             .Column1.Resizable         = .T.
841:             .Column1.Header1.Caption   = "C" + CHR(243) + "digo"
842:             .Column1.Header1.Alignment = 2
843: 

*-- Linhas 850 a 911:
850:             .Column2.Header1.Alignment = 2
851:         ENDWITH
852: 
853:         BINDEVENT(loc_oPagina.grd_4c_Prods.Column1.Text1, "KeyPress", THIS, "GradProdCodLostFocus")
854:         BINDEVENT(loc_oPagina.grd_4c_Prods.Column2.Text1, "KeyPress", THIS, "GradProdDescLostFocus")
855:         BINDEVENT(loc_oPagina.grd_4c_Prods, "AfterRowColChange", THIS, "GradProdAfterRowColChange")
856: 
857:         *-- BINDEVENTs para Confirmar e Cancelar (criados acima no cnt_4c_Salva)
858:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
859:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
860: 
861:         THIS.TornarControlesVisiveis(loc_oPagina)
862: 
863:         *-- img_4c_ImgProds inicia oculta (TornarControlesVisiveis setou .T. acima)
864:         loc_oPagina.img_4c_ImgProds.Visible = .F.
865:     ENDPROC
866: 
867:     *===========================================================================
868:     * CarregarLista - Carrega dados no grid da Page1 via BO
869:     * Vincula RecordSource, ControlSource e Header1.Caption apos Buscar()
870:     *===========================================================================
871:     PROCEDURE CarregarLista()
872:         LOCAL loc_lResultado, loc_oGrid
873:         loc_lResultado = .F.
874: 
875:         TRY
876:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
877:                 loc_lResultado = .T.
878:             ELSE
879:                 IF !THIS.this_oBusinessObject.Buscar("")
880:                     loc_lResultado = .F.
881:                 ELSE
882:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
883: 
884:                     loc_oGrid.ColumnCount = 3
885:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
886:                     loc_oGrid.ColumnCount  = 2
887: 
888:                     *-- Reconfigurar ControlSource e Headers apos RecordSource
889:                     *-- (RecordSource reseta essas propriedades - Problema #2 FORMCOR_LICOES)
890:                     WITH loc_oGrid
891:                         .Column1.ControlSource   = "cursor_4c_Dados.iclis"
892:                         .Column1.Width           = 100
893:                         .Column1.Header1.Caption = "Conta"
894: 
895:                         .Column2.ControlSource   = "cursor_4c_Dados.Rclis"
896:                         .Column2.Width           = 450
897:                         .Column2.Header1.Caption = "Nome"
898:                     ENDWITH
899: 
900:                     THIS.FormatarGridLista(loc_oGrid)
901: 
902:                     IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
903:                         GO TOP IN cursor_4c_Dados
904:                     ENDIF
905: 
906:                     loc_lResultado = .T.
907:                 ENDIF
908:             ENDIF
909:         CATCH TO loException
910:             MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, ;
911:                 "Formrst.CarregarLista")

*-- Linhas 919 a 1657:
919:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
920:     * Ao voltar para Page1 recarrega a lista automaticamente
921:     *===========================================================================
922:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
923:         LOCAL loc_lResultado
924:         loc_lResultado = .F.
925: 
926:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
927:             RETURN .F.
928:         ENDIF
929: 
930:         TRY
931:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
932:             IF par_nPagina = 1
933:                 THIS.CarregarLista()
934:             ENDIF
935:             loc_lResultado = .T.
936:         CATCH TO loException
937:             MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + ;
938:                 loException.Message, "Formrst.AlternarPagina")
939:             loc_lResultado = .F.
940:         ENDTRY
941: 
942:         RETURN loc_lResultado
943:     ENDPROC
944: 
945:     *===========================================================================
946:     * BtnIncluirClick - Prepara modo INCLUIR e navega para Page2
947:     *===========================================================================
948:     PROCEDURE BtnIncluirClick()
949:         THIS.this_oBusinessObject.NovoRegistro()
950:         THIS.this_cModoAtual = "INCLUIR"
951:         THIS.LimparCampos()
952:         THIS.InicializarGradesVazias()
953:         THIS.HabilitarCampos(.T.)
954:         THIS.AlternarPagina(2)
955:         THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus()
956:     ENDPROC
957: 
958:     *===========================================================================
959:     * BtnVisualizarClick - Carrega registro selecionado em modo VISUALIZAR
960:     *===========================================================================
961:     PROCEDURE BtnVisualizarClick()
962:         LOCAL loc_cSkChaves
963:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
964:             MsgAviso("Selecione um registro na lista.", "Aviso")
965:             RETURN
966:         ENDIF
967:         SELECT cursor_4c_Dados
968:         loc_cSkChaves = ALLTRIM(cursor_4c_Dados.skchaves)
969:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSkChaves)
970:             THIS.this_cModoAtual = "VISUALIZAR"
971:             THIS.BOParaForm()
972:             THIS.CarregarGrades(loc_cSkChaves)
973:             THIS.HabilitarCampos(.F.)
974:             THIS.AlternarPagina(2)
975:         ENDIF
976:     ENDPROC
977: 
978:     *===========================================================================
979:     * BtnAlterarClick - Carrega registro selecionado em modo ALTERAR
980:     *===========================================================================
981:     PROCEDURE BtnAlterarClick()
982:         LOCAL loc_cSkChaves
983:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
984:             MsgAviso("Selecione um registro na lista.", "Aviso")
985:             RETURN
986:         ENDIF
987:         SELECT cursor_4c_Dados
988:         loc_cSkChaves = ALLTRIM(cursor_4c_Dados.skchaves)
989:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSkChaves)
990:             THIS.this_oBusinessObject.EditarRegistro()
991:             THIS.this_cModoAtual = "ALTERAR"
992:             THIS.BOParaForm()
993:             THIS.CarregarGrades(loc_cSkChaves)
994:             THIS.HabilitarCampos(.T.)
995:             THIS.AlternarPagina(2)
996:         ENDIF
997:     ENDPROC
998: 
999:     *===========================================================================
1000:     * BtnExcluirClick - Exclui registro selecionado com confirmacao
1001:     *===========================================================================
1002:     PROCEDURE BtnExcluirClick()
1003:         LOCAL loc_cSkChaves, loc_cIclis
1004:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
1005:             MsgAviso("Selecione um registro na lista.", "Aviso")
1006:             RETURN
1007:         ENDIF
1008:         SELECT cursor_4c_Dados
1009:         loc_cSkChaves = ALLTRIM(cursor_4c_Dados.skchaves)
1010:         loc_cIclis    = ALLTRIM(cursor_4c_Dados.iclis)
1011:         IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da exclusividade" + CHR(13) + ;
1012:                 "da conta: " + loc_cIclis + " ?", "Excluir")
1013:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSkChaves)
1014:                 IF THIS.this_oBusinessObject.Excluir()
1015:                     MsgInfo("Exclusividade exclu" + CHR(237) + "da com sucesso!")
1016:                     THIS.CarregarLista()
1017:                 ENDIF
1018:             ENDIF
1019:         ENDIF
1020:     ENDPROC
1021: 
1022:     *===========================================================================
1023:     * BtnBuscarClick - Recarrega a lista completa (reset de filtro)
1024:     *===========================================================================
1025:     PROCEDURE BtnBuscarClick()
1026:         THIS.CarregarLista()
1027:     ENDPROC
1028: 
1029:     *===========================================================================
1030:     * BtnEncerrarClick - Fecha o formulario
1031:     *===========================================================================
1032:     PROCEDURE BtnEncerrarClick()
1033:         THIS.Release()
1034:     ENDPROC
1035: 
1036:     *===========================================================================
1037:     * Destroy - Limpa cursores e recursos ao fechar o formulario
1038:     *===========================================================================
1039:     PROCEDURE Destroy()
1040:         IF USED("cursor_4c_Dados")
1041:             USE IN cursor_4c_Dados
1042:         ENDIF
1043:         IF USED("cursor_4c_Munis")
1044:             USE IN cursor_4c_Munis
1045:         ENDIF
1046:         IF USED("cursor_4c_Prods")
1047:             USE IN cursor_4c_Prods
1048:         ENDIF
1049:         THIS.this_oBusinessObject = .NULL.
1050:         DODEFAULT()
1051:     ENDPROC
1052: 
1053:     *===========================================================================
1054:     * TornarControlesVisiveis - Torna todos os controles do container visiveis
1055:     * Percorre Pages de PageFrames e controles de Containers recursivamente
1056:     *===========================================================================
1057:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1058:         LOCAL loc_nI, loc_oObjeto, loc_nP
1059: 
1060:         IF VARTYPE(par_oContainer) != "O"
1061:             RETURN
1062:         ENDIF
1063: 
1064:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1065:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1066: 
1067:             IF VARTYPE(loc_oObjeto) = "O"
1068:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1069:                     IF !INLIST(UPPER(ALLTRIM(loc_oObjeto.Name)), "CNT_4C_CABECALHO")
1070:                         loc_oObjeto.Visible = .T.
1071:                     ENDIF
1072:                 ENDIF
1073: 
1074:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1075:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1076:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1077:                     ENDFOR
1078:                 ENDIF
1079: 
1080:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1081:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1082:                 ENDIF
1083:             ENDIF
1084:         ENDFOR
1085:     ENDPROC
1086: 
1087:     *===========================================================================
1088:     * FormatarGridLista - Formata visual do grid da lista (fonte padrao)
1089:     *===========================================================================
1090:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1091:         IF VARTYPE(par_oGrid) != "O"
1092:             RETURN
1093:         ENDIF
1094: 
1095:         WITH par_oGrid
1096:             .FontName = "Tahoma"
1097:             .FontSize = 8
1098:         ENDWITH
1099:     ENDPROC
1100: 
1101:     *===========================================================================
1102:     * ValidarContaCodigo - Handler LostFocus txt_4c_Codigo
1103:     * Valida conta por codigo via fAcessoContas (sigacess.PRG)
1104:     * Equivalente ao Get_codigo.Valid do legado SIGCDRST
1105:     *===========================================================================
1106:     PROCEDURE ValidarContaCodigo
1107:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1108:         LOCAL loc_cCodigo, loc_oPg2, loc_cGrupo, loc_nResult
1109:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1110:         loc_cCodigo = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
1111: 
1112:         IF EMPTY(loc_cCodigo)
1113:             loc_oPg2.txt_4c_Desc.Value = ""
1114:             RETURN
1115:         ENDIF
1116: 
1117:         loc_cGrupo = ""
1118:         TRY
1119:             *-- fAcessoContas: busca por codigo ('C'), preenche ambos os controles
1120:             IF !fAcessoContas(Usuar, loc_cGrupo, "C", loc_cCodigo, ;
1121:                               loc_oPg2.txt_4c_Codigo, loc_oPg2.txt_4c_Desc)
1122:                 MsgAviso("Acesso Negado !!", "Aviso")
1123:                 loc_oPg2.txt_4c_Codigo.Value = ""
1124:                 loc_oPg2.txt_4c_Desc.Value   = ""
1125:                 loc_oPg2.txt_4c_Codigo.SetFocus()
1126:             ENDIF
1127:         CATCH TO loException
1128:             *-- fAcessoContas indisponivel: busca direta em SigCdCli
1129:             loc_nResult = SQLEXEC(gnConnHandle, ;
1130:                 "SELECT TOP 1 Iclis, Rclis FROM SigCdCli" + ;
1131:                 " WHERE Iclis = " + EscaparSQL(loc_cCodigo), ;
1132:                 "cursor_4c_BuscaCli")
1133:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaCli") > 0
1134:                 loc_oPg2.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1135:                 loc_oPg2.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1136:             ELSE
1137:                 MsgAviso("Conta n" + CHR(227) + "o encontrada.", "Aviso")
1138:                 loc_oPg2.txt_4c_Codigo.Value = ""
1139:                 loc_oPg2.txt_4c_Desc.Value   = ""
1140:                 loc_oPg2.txt_4c_Codigo.SetFocus()
1141:             ENDIF
1142:             IF USED("cursor_4c_BuscaCli")
1143:                 USE IN cursor_4c_BuscaCli
1144:             ENDIF
1145:         ENDTRY
1146:     ENDPROC
1147: 
1148:     *===========================================================================
1149:     * ValidarContaDescricao - Handler LostFocus txt_4c_Desc
1150:     * Valida conta por descricao via fAcessoContas (sigacess.PRG)
1151:     * Equivalente ao Get_Desc.Valid do legado SIGCDRST
1152:     *===========================================================================
1153:     PROCEDURE ValidarContaDescricao
1154:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1155:         LOCAL loc_cDesc, loc_oPg2, loc_cGrupo, loc_nResult
1156:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1157:         loc_cDesc  = ALLTRIM(loc_oPg2.txt_4c_Desc.Value)
1158: 
1159:         IF EMPTY(loc_cDesc)
1160:             loc_oPg2.txt_4c_Codigo.Value = ""
1161:             RETURN
1162:         ENDIF
1163: 
1164:         loc_cGrupo = ""
1165:         TRY
1166:             *-- fAcessoContas: busca por descricao ('D'), preenche ambos os controles
1167:             IF !fAcessoContas(Usuar, loc_cGrupo, "D", loc_cDesc, ;
1168:                               loc_oPg2.txt_4c_Codigo, loc_oPg2.txt_4c_Desc)
1169:                 MsgAviso("Acesso Negado !!", "Aviso")
1170:                 loc_oPg2.txt_4c_Desc.Value   = ""
1171:                 loc_oPg2.txt_4c_Codigo.Value = ""
1172:                 loc_oPg2.txt_4c_Desc.SetFocus()
1173:             ENDIF
1174:         CATCH TO loException
1175:             *-- fAcessoContas indisponivel: busca direta em SigCdCli por nome
1176:             loc_nResult = SQLEXEC(gnConnHandle, ;
1177:                 "SELECT TOP 1 Iclis, Rclis FROM SigCdCli" + ;
1178:                 " WHERE Rclis LIKE " + EscaparSQL(loc_cDesc + "%"), ;
1179:                 "cursor_4c_BuscaCli")
1180:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaCli") > 0
1181:                 loc_oPg2.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1182:                 loc_oPg2.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1183:             ELSE
1184:                 MsgAviso("Conta n" + CHR(227) + "o encontrada.", "Aviso")
1185:                 loc_oPg2.txt_4c_Desc.Value   = ""
1186:                 loc_oPg2.txt_4c_Codigo.Value = ""
1187:                 loc_oPg2.txt_4c_Desc.SetFocus()
1188:             ENDIF
1189:             IF USED("cursor_4c_BuscaCli")
1190:                 USE IN cursor_4c_BuscaCli
1191:             ENDIF
1192:         ENDTRY
1193:     ENDPROC
1194: 
1195:     *===========================================================================
1196:     * ImgProdsClick - Handler Click em img_4c_ImgProds
1197:     * Recarrega imagem do produto selecionado em GradProd (cursor_4c_Prods)
1198:     * Equivalente ao imgProds.Click do legado SIGCDRST
1199:     *===========================================================================
1200:     PROCEDURE ImgProdsClick()
1201:         LOCAL loc_cCodPro, loc_nResult, loc_cArquivo, loc_cFoto, loc_oPg2
1202:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1203: 
1204:         IF !USED("cursor_4c_Prods") OR EOF("cursor_4c_Prods")
1205:             RETURN
1206:         ENDIF
1207: 
1208:         SELECT cursor_4c_Prods
1209:         loc_cCodPro = ALLTRIM(cursor_4c_Prods.cpros)
1210:         IF EMPTY(loc_cCodPro)
1211:             RETURN
1212:         ENDIF
1213: 
1214:         TRY
1215:             loc_nResult = SQLEXEC(gnConnHandle, ;
1216:                 "SELECT a.cpros, a.FigJpgs FROM SigCdPro a" + ;
1217:                 " WHERE a.cpros = " + EscaparSQL(loc_cCodPro), ;
1218:                 "cursor_4c_ImgPro")
1219:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ImgPro") > 0
1220:                 SELECT cursor_4c_ImgPro
1221:                 IF !EMPTY(NVL(cursor_4c_ImgPro.FigJpgs, "")) AND !ISNULL(cursor_4c_ImgPro.FigJpgs)
1222:                     loc_cArquivo = SYS(2023) + "\" + goSistema.Sys2015Tmp + SYS(2015) + ".jpg"
1223:                     loc_cFoto    = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_ImgPro.FigJpgs, ;
1224:                         "data:image/png;base64,", ""), ;
1225:                         "data:image/jpeg;base64,", ""), ;
1226:                         "data:image/jpg;base64,", ""), 14)
1227:                     STRTOFILE(loc_cFoto, loc_cArquivo)
1228:                     loc_oPg2.img_4c_ImgProds.Picture = loc_cArquivo
1229:                     loc_oPg2.img_4c_ImgProds.Visible = .T.
1230:                 ENDIF
1231:             ENDIF
1232:             IF USED("cursor_4c_ImgPro")
1233:                 USE IN cursor_4c_ImgPro
1234:             ENDIF
1235:         CATCH TO loException
1236:             MsgErro("Erro ao exibir imagem:" + CHR(13) + loException.Message, ;
1237:                 "Formrst.ImgProdsClick")
1238:             IF USED("cursor_4c_ImgPro")
1239:                 USE IN cursor_4c_ImgPro
1240:             ENDIF
1241:         ENDTRY
1242:     ENDPROC
1243: 
1244:     *===========================================================================
1245:     * BtnSalvarClick - Valida e persiste o registro (INCLUIR ou ALTERAR)
1246:     * Chamado via BINDEVENT cnt_4c_Salva.cmd_4c_Confirmar Click
1247:     *===========================================================================
1248:     PROCEDURE BtnSalvarClick()
1249:         LOCAL loc_lResultado, loc_cIclis, loc_nQtdProd, loc_oPg2, loc_lValido, loc_nRec
1250:         loc_lResultado = .F.
1251:         loc_lValido    = .F.
1252:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1253: 
1254:         TRY
1255:             *-- Validar conta obrigatoria
1256:             loc_cIclis = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
1257:             IF EMPTY(loc_cIclis)
1258:                 MsgAviso("Conta obrigat" + CHR(243) + "ria.", "Aviso")
1259:                 loc_oPg2.txt_4c_Codigo.SetFocus()
1260:             ELSE
1261:                 *-- Contar produtos com cpros valido
1262:                 loc_nQtdProd = 0
1263:                 IF USED("cursor_4c_Prods")
1264:                     SELECT cursor_4c_Prods
1265:                     loc_nRec = RECNO()
1266:                     GO TOP
1267:                     SCAN FOR !DELETED()
1268:                         IF !EMPTY(ALLTRIM(cpros))
1269:                             loc_nQtdProd = loc_nQtdProd + 1
1270:                         ENDIF
1271:                     ENDSCAN
1272:                     IF loc_nRec > 0 AND loc_nRec <= RECCOUNT("cursor_4c_Prods")
1273:                         GO (loc_nRec) IN cursor_4c_Prods
1274:                     ENDIF
1275:                 ENDIF
1276:                 IF loc_nQtdProd = 0
1277:                     MsgAviso("Informe ao menos um produto.", "Aviso")
1278:                 ELSE
1279:                     IF THIS.this_cModoAtual = "INCLUIR"
1280:                         IF THIS.this_oBusinessObject.VerificarContaCadastrada(loc_cIclis)
1281:                             MsgAviso("Esta conta j" + CHR(225) + " possui exclusividade cadastrada.", "Aviso")
1282:                             loc_oPg2.txt_4c_Codigo.SetFocus()
1283:                         ELSE
1284:                             loc_lValido = .T.
1285:                         ENDIF
1286:                     ELSE
1287:                         loc_lValido = .T.
1288:                     ENDIF
1289:                 ENDIF
1290:             ENDIF
1291: 
1292:             IF loc_lValido
1293:                 THIS.FormParaBO()
1294:                 IF THIS.this_oBusinessObject.Salvar()
1295:                     MsgInfo("Exclusividade gravada com sucesso!")
1296:                     THIS.this_cModoAtual = "LISTA"
1297:                     THIS.AlternarPagina(1)
1298:                     loc_lResultado = .T.
1299:                 ENDIF
1300:             ENDIF
1301:         CATCH TO loException
1302:             MsgErro("Erro ao salvar:" + CHR(13) + loException.Message, "Formrst.BtnSalvarClick")
1303:         ENDTRY
1304:     ENDPROC
1305: 
1306:     *===========================================================================
1307:     * BtnCancelarClick - Cancela edicao e retorna para lista
1308:     * Chamado via BINDEVENT cnt_4c_Salva.cmd_4c_Cancelar Click
1309:     *===========================================================================
1310:     PROCEDURE BtnCancelarClick()
1311:         THIS.this_cModoAtual = "LISTA"
1312:         THIS.AlternarPagina(1)
1313:     ENDPROC
1314: 
1315:     *===========================================================================
1316:     * FormParaBO - Transfere valores dos controles para propriedades do BO
1317:     *===========================================================================
1318:     PROTECTED PROCEDURE FormParaBO()
1319:         LOCAL loc_oPg2
1320:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1321:         THIS.this_oBusinessObject.this_cIclis    = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
1322:         THIS.this_oBusinessObject.this_cRclis    = ALLTRIM(loc_oPg2.txt_4c_Desc.Value)
1323:         THIS.this_oBusinessObject.this_nChkMatrs = IIF(loc_oPg2.opt_4c_ChkMatrix.Value = 1, 1, 0)
1324:     ENDPROC
1325: 
1326:     *===========================================================================
1327:     * BOParaForm - Transfere propriedades do BO para controles do formulario
1328:     *===========================================================================
1329:     PROTECTED PROCEDURE BOParaForm()
1330:         LOCAL loc_oPg2
1331:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1332:         loc_oPg2.txt_4c_Codigo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cIclis)
1333:         loc_oPg2.txt_4c_Desc.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cRclis)
1334:         loc_oPg2.opt_4c_ChkMatrix.Value = IIF(THIS.this_oBusinessObject.this_nChkMatrs = 1, 1, 2)
1335:     ENDPROC
1336: 
1337:     *===========================================================================
1338:     * HabilitarCampos - Liga/desliga edicao dos controles da Page2
1339:     * par_lHabilitar=.T.: INCLUIR/ALTERAR; .F.: VISUALIZAR (somente leitura)
1340:     *===========================================================================
1341:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1342:         LOCAL loc_oPg2
1343:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1344:         loc_oPg2.txt_4c_Codigo.ReadOnly      = !par_lHabilitar
1345:         loc_oPg2.opt_4c_ChkMatrix.Enabled    = par_lHabilitar
1346:         loc_oPg2.grd_4c_Munis.ReadOnly       = !par_lHabilitar
1347:         loc_oPg2.grd_4c_Prods.ReadOnly       = !par_lHabilitar
1348:     ENDPROC
1349: 
1350:     *===========================================================================
1351:     * LimparCampos - Reseta controles da Page2 para estado inicial
1352:     *===========================================================================
1353:     PROTECTED PROCEDURE LimparCampos()
1354:         LOCAL loc_oPg2
1355:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1356:         loc_oPg2.txt_4c_Codigo.Value     = ""
1357:         loc_oPg2.txt_4c_Desc.Value       = ""
1358:         loc_oPg2.opt_4c_ChkMatrix.Value  = 2
1359:         loc_oPg2.img_4c_ImgProds.Visible = .F.
1360:     ENDPROC
1361: 
1362:     *===========================================================================
1363:     * CarregarGrades - Popula ambas as grids via BO para o skChaves dado
1364:     *===========================================================================
1365:     PROTECTED PROCEDURE CarregarGrades(par_cSkChaves)
1366:         THIS.this_oBusinessObject.BuscarMunicipios(par_cSkChaves)
1367:         THIS.this_oBusinessObject.BuscarProdutos(par_cSkChaves)
1368:         THIS.RefreshGridMunis()
1369:         THIS.RefreshGridProds()
1370:     ENDPROC
1371: 
1372:     *===========================================================================
1373:     * InicializarGradesVazias - Cria cursores locais vazios (1 linha em branco)
1374:     * Usado em modo INCLUIR para permitir digitacao imediata nas grades
1375:     *===========================================================================
1376:     PROTECTED PROCEDURE InicializarGradesVazias()
1377:         IF USED("cursor_4c_Munis")
1378:             USE IN cursor_4c_Munis
1379:         ENDIF
1380:         SET NULL ON
1381:         CREATE CURSOR cursor_4c_Munis (skchaves C(20), pkchaves C(20), codibges C(7), ;
1382:             tipos C(1), UFIBGEs N(2,0), munici C(40), uf C(2))
1383:         SET NULL OFF
1384:         APPEND BLANK IN cursor_4c_Munis
1385:         GO TOP IN cursor_4c_Munis
1386: 
1387:         IF USED("cursor_4c_Prods")
1388:             USE IN cursor_4c_Prods
1389:         ENDIF
1390:         SET NULL ON
1391:         CREATE CURSOR cursor_4c_Prods (skchaves C(20), pkchaves C(20), cpros C(14), ;
1392:             dpros C(40), tipos C(1))
1393:         SET NULL OFF
1394:         APPEND BLANK IN cursor_4c_Prods
1395:         GO TOP IN cursor_4c_Prods
1396: 
1397:         THIS.RefreshGridMunis()
1398:         THIS.RefreshGridProds()
1399:     ENDPROC
1400: 
1401:     *===========================================================================
1402:     * RefreshGridMunis - Rebinda grd_4c_Munis ao cursor_4c_Munis
1403:     * Necessario apos BuscarMunicipios() recriar o cursor (Problema #2/#48)
1404:     *===========================================================================
1405:     PROTECTED PROCEDURE RefreshGridMunis()
1406:         LOCAL loc_oGrid
1407:         TRY
1408:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Munis
1409:             loc_oGrid.ColumnCount = 3
1410:             loc_oGrid.RecordSource = "cursor_4c_Munis"
1411:             loc_oGrid.ColumnCount  = 2
1412:             WITH loc_oGrid
1413:                 .Column1.ControlSource   = "cursor_4c_Munis.uf"
1414:                 .Column1.Width           = 24
1415:                 .Column1.Header1.Caption = "UF"
1416:                 .Column2.ControlSource   = "cursor_4c_Munis.munici"
1417:                 .Column2.Width           = 263
1418:                 .Column2.Header1.Caption = "Munic" + CHR(237) + "pio"
1419:             ENDWITH
1420:             loc_oGrid.Refresh()
1421:         CATCH TO loException
1422:             MsgErro("Erro ao atualizar grade munic" + CHR(237) + "pios:" + CHR(13) + ;
1423:                 loException.Message, "Formrst.RefreshGridMunis")
1424:         ENDTRY
1425:     ENDPROC
1426: 
1427:     *===========================================================================
1428:     * RefreshGridProds - Rebinda grd_4c_Prods ao cursor_4c_Prods
1429:     * Necessario apos BuscarProdutos() recriar o cursor (Problema #2/#48)
1430:     *===========================================================================
1431:     PROTECTED PROCEDURE RefreshGridProds()
1432:         LOCAL loc_oGrid
1433:         TRY
1434:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Prods
1435:             loc_oGrid.ColumnCount = 3
1436:             loc_oGrid.RecordSource = "cursor_4c_Prods"
1437:             loc_oGrid.ColumnCount  = 2
1438:             WITH loc_oGrid
1439:                 .Column1.ControlSource   = "cursor_4c_Prods.cpros"
1440:                 .Column1.Width           = 108
1441:                 .Column1.Header1.Caption = CHR(67) + CHR(243) + "digo"
1442:                 .Column2.ControlSource   = "cursor_4c_Prods.dpros"
1443:                 .Column2.Width           = 360
1444:                 .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1445:             ENDWITH
1446:             loc_oGrid.Refresh()
1447:         CATCH TO loException
1448:             MsgErro("Erro ao atualizar grade produtos:" + CHR(13) + loException.Message, ;
1449:                 "Formrst.RefreshGridProds")
1450:         ENDTRY
1451:     ENDPROC
1452: 
1453:     *===========================================================================
1454:     * GradMuniUFLostFocus - Valida UF digitada na Column1 de grd_4c_Munis
1455:     * Busca em SigCdUfs; se nao encontrado abre FormBuscaAuxiliar
1456:     *===========================================================================
1457:     PROCEDURE GradMuniUFLostFocus
1458:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1459:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1460:             RETURN
1461:         ENDIF
1462:         LOCAL loc_cUF, loc_nResult, loc_oBusca
1463: 
1464:         IF !USED("cursor_4c_Munis") OR EOF("cursor_4c_Munis") OR BOF("cursor_4c_Munis")
1465:             RETURN
1466:         ENDIF
1467: 
1468:         SELECT cursor_4c_Munis
1469:         loc_cUF = ALLTRIM(cursor_4c_Munis.uf)
1470: 
1471:         IF EMPTY(loc_cUF)
1472:             RETURN
1473:         ENDIF
1474: 
1475:         TRY
1476:             loc_nResult = SQLEXEC(gnConnHandle, ;
1477:                 "SELECT TOP 1 estados, ufibges FROM SigCdUfs" + ;
1478:                 " WHERE estados = " + EscaparSQL(loc_cUF), ;
1479:                 "cursor_4c_BuscaUf")
1480:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaUf") > 0
1481:                 SELECT cursor_4c_Munis
1482:                 REPLACE uf      WITH ALLTRIM(cursor_4c_BuscaUf.estados), ;
1483:                         UFIBGEs WITH cursor_4c_BuscaUf.ufibges
1484:             ELSE
1485:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1486:                     "SELECT estados AS codigo, estados AS descricao FROM SigCdUfs" + ;
1487:                     " WHERE estados LIKE " + EscaparSQL(loc_cUF + "%") + ;
1488:                     " ORDER BY estados", ;
1489:                     "cursor_4c_BuscaUfs")
1490:                 IF loc_nResult < 0 OR RECCOUNT("cursor_4c_BuscaUfs") = 0
1491:                     IF USED("cursor_4c_BuscaUfs")
1492:                         USE IN cursor_4c_BuscaUfs
1493:                     ENDIF
1494:                     SQLEXEC(gnConnHandle, ;
1495:                         "SELECT estados AS codigo, estados AS descricao FROM SigCdUfs ORDER BY estados", ;
1496:                         "cursor_4c_BuscaUfs")
1497:                 ENDIF
1498:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1499:                 IF VARTYPE(loc_oBusca) = "O"
1500:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaUfs"
1501:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaUfs", "codigo", "descricao", "UF")
1502:                     loc_oBusca.Mostrar()
1503:                     IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
1504:                         loc_nResult = SQLEXEC(gnConnHandle, ;
1505:                             "SELECT TOP 1 estados, ufibges FROM SigCdUfs" + ;
1506:                             " WHERE estados = " + EscaparSQL(ALLTRIM(loc_oBusca.cCodigoSelecionado)), ;
1507:                             "cursor_4c_UfSel")
1508:                         IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_UfSel") > 0
1509:                             SELECT cursor_4c_Munis
1510:                             REPLACE uf      WITH ALLTRIM(cursor_4c_UfSel.estados), ;
1511:                                     UFIBGEs WITH cursor_4c_UfSel.ufibges
1512:                         ENDIF
1513:                         IF USED("cursor_4c_UfSel")
1514:                             USE IN cursor_4c_UfSel
1515:                         ENDIF
1516:                     ELSE
1517:                         SELECT cursor_4c_Munis
1518:                         REPLACE uf WITH "", UFIBGEs WITH 0
1519:                     ENDIF
1520:                     IF USED("cursor_4c_BuscaUfs")
1521:                         USE IN cursor_4c_BuscaUfs
1522:                     ENDIF
1523:                 ENDIF
1524:             ENDIF
1525:             IF USED("cursor_4c_BuscaUf")
1526:                 USE IN cursor_4c_BuscaUf
1527:             ENDIF
1528:             THIS.pgf_4c_Paginas.Page2.grd_4c_Munis.Refresh()
1529:         CATCH TO loException
1530:             MsgErro("Erro ao validar UF:" + CHR(13) + loException.Message, ;
1531:                 "Formrst.GradMuniUFLostFocus")
1532:             IF USED("cursor_4c_BuscaUf")
1533:                 USE IN cursor_4c_BuscaUf
1534:             ENDIF
1535:             IF USED("cursor_4c_BuscaUfs")
1536:                 USE IN cursor_4c_BuscaUfs
1537:             ENDIF
1538:         ENDTRY
1539:     ENDPROC
1540: 
1541:     *===========================================================================
1542:     * GradMuniMunLostFocus - Valida municipio digitado na Column2 de grd_4c_Munis
1543:     * Verifica duplicidade + busca em SigCdMun; se nao encontrado abre picker
1544:     *===========================================================================
1545:     PROCEDURE GradMuniMunLostFocus
1546:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1547:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1548:             RETURN
1549:         ENDIF
1550:         LOCAL loc_cMunici, loc_cUF, loc_nContagem, loc_nResult, loc_oBusca, loc_nRec
1551: 
1552:         IF !USED("cursor_4c_Munis") OR EOF("cursor_4c_Munis") OR BOF("cursor_4c_Munis")
1553:             RETURN
1554:         ENDIF
1555: 
1556:         SELECT cursor_4c_Munis
1557:         loc_cMunici = ALLTRIM(cursor_4c_Munis.munici)
1558:         loc_cUF     = ALLTRIM(cursor_4c_Munis.uf)
1559: 
1560:         IF EMPTY(loc_cMunici)
1561:             RETURN
1562:         ENDIF
1563: 
1564:         TRY
1565:             *-- Verificar duplicidade: mesmo uf + munici em outra linha
1566:             SELECT cursor_4c_Munis
1567:             loc_nRec = RECNO()
1568:             GO TOP
1569:             loc_nContagem = 0
1570:             SCAN FOR !DELETED()
1571:                 IF ALLTRIM(uf) = loc_cUF AND ALLTRIM(munici) = loc_cMunici
1572:                     loc_nContagem = loc_nContagem + 1
1573:                 ENDIF
1574:             ENDSCAN
1575:             IF loc_nRec > 0 AND loc_nRec <= RECCOUNT("cursor_4c_Munis")
1576:                 GO (loc_nRec) IN cursor_4c_Munis
1577:             ENDIF
1578: 
1579:             IF loc_nContagem > 1
1580:                 MsgAviso("Munic" + CHR(237) + "pio j" + CHR(225) + ;
1581:                     " adicionado para este estado.", "Aviso")
1582:                 SELECT cursor_4c_Munis
1583:                 REPLACE munici WITH "", codibges WITH "", UFIBGEs WITH 0, uf WITH ""
1584:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Munis.Refresh()
1585:             ELSE
1586:                 *-- Busca exata em SigCdMun pelo nome do municipio
1587:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1588:                     "SELECT TOP 1 a.codigos, a.descs," + ;
1589:                     " ISNULL(b.estados,'') AS uf, ISNULL(b.ufibges,0) AS UFIBGEs" + ;
1590:                     " FROM SigCdMun a" + ;
1591:                     " LEFT JOIN SigCdUfs b ON b.ufibges = a.ufibges" + ;
1592:                     " WHERE a.descs = " + EscaparSQL(loc_cMunici), ;
1593:                     "cursor_4c_BuscaMun")
1594:                 IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaMun") > 0
1595:                     SELECT cursor_4c_Munis
1596:                     REPLACE codibges WITH ALLTRIM(cursor_4c_BuscaMun.codigos), ;
1597:                             munici   WITH ALLTRIM(cursor_4c_BuscaMun.descs), ;
1598:                             uf       WITH ALLTRIM(cursor_4c_BuscaMun.uf), ;
1599:                             UFIBGEs  WITH cursor_4c_BuscaMun.UFIBGEs
1600:                 ELSE
1601:                     *-- Abrir picker de municipios
1602:                     loc_nResult = SQLEXEC(gnConnHandle, ;
1603:                         "SELECT a.codigos AS codigo, a.descs AS descricao" + ;
1604:                         " FROM SigCdMun a" + ;
1605:                         " WHERE a.descs LIKE " + EscaparSQL(loc_cMunici + "%") + ;
1606:                         " ORDER BY a.descs", ;
1607:                         "cursor_4c_BuscaMuns")
1608:                     IF loc_nResult < 0 OR RECCOUNT("cursor_4c_BuscaMuns") = 0
1609:                         IF USED("cursor_4c_BuscaMuns")
1610:                             USE IN cursor_4c_BuscaMuns
1611:                         ENDIF
1612:                         SQLEXEC(gnConnHandle, ;
1613:                             "SELECT a.codigos AS codigo, a.descs AS descricao" + ;
1614:                             " FROM SigCdMun a ORDER BY a.descs", ;
1615:                             "cursor_4c_BuscaMuns")
1616:                     ENDIF
1617:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1618:                     IF VARTYPE(loc_oBusca) = "O"
1619:                         loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaMuns"
1620:                         loc_oBusca.DefinirCursor("cursor_4c_BuscaMuns", "codigo", "descricao", ;
1621:                             "Munic" + CHR(237) + "pio")
1622:                         loc_oBusca.Mostrar()
1623:                         IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
1624:                             loc_nResult = SQLEXEC(gnConnHandle, ;
1625:                                 "SELECT TOP 1 a.codigos, a.descs," + ;
1626:                                 " ISNULL(b.estados,'') AS uf, ISNULL(b.ufibges,0) AS UFIBGEs" + ;
1627:                                 " FROM SigCdMun a" + ;
1628:                                 " LEFT JOIN SigCdUfs b ON b.ufibges = a.ufibges" + ;
1629:                                 " WHERE a.codigos = " + ;
1630:                                 EscaparSQL(ALLTRIM(loc_oBusca.cCodigoSelecionado)), ;
1631:                                 "cursor_4c_MunSel")
1632:                             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_MunSel") > 0
1633:                                 SELECT cursor_4c_Munis
1634:                                 REPLACE codibges WITH ALLTRIM(cursor_4c_MunSel.codigos), ;
1635:                                         munici   WITH ALLTRIM(cursor_4c_MunSel.descs), ;
1636:                                         uf       WITH ALLTRIM(cursor_4c_MunSel.uf), ;
1637:                                         UFIBGEs  WITH cursor_4c_MunSel.UFIBGEs
1638:                             ENDIF
1639:                             IF USED("cursor_4c_MunSel")
1640:                                 USE IN cursor_4c_MunSel
1641:                             ENDIF
1642:                         ELSE
1643:                             SELECT cursor_4c_Munis
1644:                             REPLACE munici WITH "", codibges WITH "", UFIBGEs WITH 0, uf WITH ""
1645:                         ENDIF
1646:                         IF USED("cursor_4c_BuscaMuns")
1647:                             USE IN cursor_4c_BuscaMuns
1648:                         ENDIF
1649:                     ENDIF
1650:                 ENDIF
1651:                 IF USED("cursor_4c_BuscaMun")
1652:                     USE IN cursor_4c_BuscaMun
1653:                 ENDIF
1654:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Munis.Refresh()
1655:             ENDIF
1656:         CATCH TO loException
1657:             MsgErro("Erro ao validar munic" + CHR(237) + "pio:" + CHR(13) + loException.Message, ;

*-- Linhas 1667 a 1891:
1667: 
1668:     *===========================================================================
1669:     * GradProdCodLostFocus - Valida codigo de produto (cpros) na Column1 de grd_4c_Prods
1670:     * Busca em SigCdPro; se nao encontrado abre FormBuscaAuxiliar
1671:     *===========================================================================
1672:     PROCEDURE GradProdCodLostFocus
1673:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1674:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1675:             RETURN
1676:         ENDIF
1677:         LOCAL loc_cCpros, loc_nResult, loc_oBusca
1678: 
1679:         IF !USED("cursor_4c_Prods") OR EOF("cursor_4c_Prods") OR BOF("cursor_4c_Prods")
1680:             RETURN
1681:         ENDIF
1682: 
1683:         SELECT cursor_4c_Prods
1684:         loc_cCpros = ALLTRIM(cursor_4c_Prods.cpros)
1685: 
1686:         IF EMPTY(loc_cCpros)
1687:             RETURN
1688:         ENDIF
1689: 
1690:         TRY
1691:             loc_nResult = SQLEXEC(gnConnHandle, ;
1692:                 "SELECT TOP 1 a.cpros, a.dpros FROM SigCdPro a" + ;
1693:                 " WHERE a.cpros = " + EscaparSQL(loc_cCpros), ;
1694:                 "cursor_4c_BuscaPro")
1695:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaPro") > 0
1696:                 SELECT cursor_4c_Prods
1697:                 REPLACE cpros WITH ALLTRIM(cursor_4c_BuscaPro.cpros), ;
1698:                         dpros WITH ALLTRIM(cursor_4c_BuscaPro.dpros)
1699:             ELSE
1700:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1701:                     "SELECT a.cpros AS codigo, a.dpros AS descricao FROM SigCdPro a" + ;
1702:                     " WHERE a.cpros LIKE " + EscaparSQL(loc_cCpros + "%") + ;
1703:                     " ORDER BY a.cpros", ;
1704:                     "cursor_4c_BuscaPros")
1705:                 IF loc_nResult < 0 OR RECCOUNT("cursor_4c_BuscaPros") = 0
1706:                     IF USED("cursor_4c_BuscaPros")
1707:                         USE IN cursor_4c_BuscaPros
1708:                     ENDIF
1709:                     SQLEXEC(gnConnHandle, ;
1710:                         "SELECT a.cpros AS codigo, a.dpros AS descricao FROM SigCdPro a" + ;
1711:                         " ORDER BY a.cpros", ;
1712:                         "cursor_4c_BuscaPros")
1713:                 ENDIF
1714:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1715:                 IF VARTYPE(loc_oBusca) = "O"
1716:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaPros"
1717:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaPros", "codigo", "descricao", ;
1718:                         CHR(67) + CHR(243) + "digo do Produto")
1719:                     loc_oBusca.Mostrar()
1720:                     IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
1721:                         loc_nResult = SQLEXEC(gnConnHandle, ;
1722:                             "SELECT TOP 1 a.cpros, a.dpros FROM SigCdPro a" + ;
1723:                             " WHERE a.cpros = " + EscaparSQL(ALLTRIM(loc_oBusca.cCodigoSelecionado)), ;
1724:                             "cursor_4c_ProSel")
1725:                         IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ProSel") > 0
1726:                             SELECT cursor_4c_Prods
1727:                             REPLACE cpros WITH ALLTRIM(cursor_4c_ProSel.cpros), ;
1728:                                     dpros WITH ALLTRIM(cursor_4c_ProSel.dpros)
1729:                         ENDIF
1730:                         IF USED("cursor_4c_ProSel")
1731:                             USE IN cursor_4c_ProSel
1732:                         ENDIF
1733:                     ELSE
1734:                         SELECT cursor_4c_Prods
1735:                         REPLACE cpros WITH "", dpros WITH ""
1736:                     ENDIF
1737:                     IF USED("cursor_4c_BuscaPros")
1738:                         USE IN cursor_4c_BuscaPros
1739:                     ENDIF
1740:                 ENDIF
1741:             ENDIF
1742:             IF USED("cursor_4c_BuscaPro")
1743:                 USE IN cursor_4c_BuscaPro
1744:             ENDIF
1745:             THIS.pgf_4c_Paginas.Page2.grd_4c_Prods.Refresh()
1746:         CATCH TO loException
1747:             MsgErro("Erro ao validar produto:" + CHR(13) + loException.Message, ;
1748:                 "Formrst.GradProdCodLostFocus")
1749:             IF USED("cursor_4c_BuscaPro")
1750:                 USE IN cursor_4c_BuscaPro
1751:             ENDIF
1752:             IF USED("cursor_4c_BuscaPros")
1753:                 USE IN cursor_4c_BuscaPros
1754:             ENDIF
1755:         ENDTRY
1756:     ENDPROC
1757: 
1758:     *===========================================================================
1759:     * GradProdDescLostFocus - Valida descricao (dpros) na Column2 de grd_4c_Prods
1760:     * Verifica duplicidade de cpros + busca em SigCdPro por descricao
1761:     *===========================================================================
1762:     PROCEDURE GradProdDescLostFocus
1763:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1764:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1765:             RETURN
1766:         ENDIF
1767:         LOCAL loc_cDpros, loc_cCpros, loc_nContagem, loc_nResult, loc_oBusca, loc_nRec
1768: 
1769:         IF !USED("cursor_4c_Prods") OR EOF("cursor_4c_Prods") OR BOF("cursor_4c_Prods")
1770:             RETURN
1771:         ENDIF
1772: 
1773:         SELECT cursor_4c_Prods
1774:         loc_cDpros = ALLTRIM(cursor_4c_Prods.dpros)
1775:         loc_cCpros = ALLTRIM(cursor_4c_Prods.cpros)
1776: 
1777:         IF EMPTY(loc_cDpros)
1778:             RETURN
1779:         ENDIF
1780: 
1781:         TRY
1782:             IF !EMPTY(loc_cCpros)
1783:                 *-- Verificar duplicidade: mesmo cpros em outra linha
1784:                 SELECT cursor_4c_Prods
1785:                 loc_nRec = RECNO()
1786:                 GO TOP
1787:                 loc_nContagem = 0
1788:                 SCAN FOR !DELETED()
1789:                     IF ALLTRIM(cpros) = loc_cCpros
1790:                         loc_nContagem = loc_nContagem + 1
1791:                     ENDIF
1792:                 ENDSCAN
1793:                 IF loc_nRec > 0 AND loc_nRec <= RECCOUNT("cursor_4c_Prods")
1794:                     GO (loc_nRec) IN cursor_4c_Prods
1795:                 ENDIF
1796:                 IF loc_nContagem > 1
1797:                     MsgAviso("Produto j" + CHR(225) + " adicionado a esta exclusividade.", "Aviso")
1798:                     SELECT cursor_4c_Prods
1799:                     REPLACE cpros WITH "", dpros WITH ""
1800:                 ENDIF
1801:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Prods.Refresh()
1802:             ELSE
1803:                 *-- cpros vazio: buscar produto por descricao digitada
1804:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1805:                     "SELECT a.cpros AS codigo, a.dpros AS descricao FROM SigCdPro a" + ;
1806:                     " WHERE a.dpros LIKE " + EscaparSQL(loc_cDpros + "%") + ;
1807:                     " ORDER BY a.dpros", ;
1808:                     "cursor_4c_BuscaDpros")
1809:                 IF loc_nResult < 0 OR RECCOUNT("cursor_4c_BuscaDpros") = 0
1810:                     IF USED("cursor_4c_BuscaDpros")
1811:                         USE IN cursor_4c_BuscaDpros
1812:                     ENDIF
1813:                     SQLEXEC(gnConnHandle, ;
1814:                         "SELECT a.cpros AS codigo, a.dpros AS descricao FROM SigCdPro a" + ;
1815:                         " ORDER BY a.dpros", ;
1816:                         "cursor_4c_BuscaDpros")
1817:                 ENDIF
1818:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1819:                 IF VARTYPE(loc_oBusca) = "O"
1820:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaDpros"
1821:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaDpros", "codigo", "descricao", ;
1822:                         "Descri" + CHR(231) + CHR(227) + "o do Produto")
1823:                     loc_oBusca.Mostrar()
1824:                     IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
1825:                         SELECT cursor_4c_Prods
1826:                         REPLACE cpros WITH ALLTRIM(loc_oBusca.cCodigoSelecionado), ;
1827:                                 dpros WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
1828:                     ELSE
1829:                         SELECT cursor_4c_Prods
1830:                         REPLACE cpros WITH "", dpros WITH ""
1831:                     ENDIF
1832:                     IF USED("cursor_4c_BuscaDpros")
1833:                         USE IN cursor_4c_BuscaDpros
1834:                     ENDIF
1835:                 ENDIF
1836:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Prods.Refresh()
1837:             ENDIF
1838:         CATCH TO loException
1839:             MsgErro("Erro ao validar descri" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
1840:                 loException.Message, "Formrst.GradProdDescLostFocus")
1841:             IF USED("cursor_4c_BuscaDpros")
1842:                 USE IN cursor_4c_BuscaDpros
1843:             ENDIF
1844:         ENDTRY
1845:     ENDPROC
1846: 
1847:     *===========================================================================
1848:     * GradProdAfterRowColChange - Exibe imagem do produto selecionado em grd_4c_Prods
1849:     * LPARAMETERS obrigatorio para AfterRowColChange via BINDEVENT
1850:     *===========================================================================
1851:     PROCEDURE GradProdAfterRowColChange(par_nColIndex)
1852:         LOCAL loc_cCodPro, loc_nResult, loc_cArquivo, loc_cFoto, loc_oPg2, loc_lTemImagem
1853:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1854: 
1855:         IF !USED("cursor_4c_Prods") OR EOF("cursor_4c_Prods") OR BOF("cursor_4c_Prods")
1856:             loc_oPg2.img_4c_ImgProds.Visible = .F.
1857:             RETURN
1858:         ENDIF
1859: 
1860:         SELECT cursor_4c_Prods
1861:         loc_cCodPro = ALLTRIM(cursor_4c_Prods.cpros)
1862: 
1863:         IF EMPTY(loc_cCodPro)
1864:             loc_oPg2.img_4c_ImgProds.Visible = .F.
1865:             RETURN
1866:         ENDIF
1867: 
1868:         TRY
1869:             loc_lTemImagem = .F.
1870:             loc_nResult = SQLEXEC(gnConnHandle, ;
1871:                 "SELECT a.FigJpgs FROM SigCdPro a WHERE a.cpros = " + EscaparSQL(loc_cCodPro), ;
1872:                 "cursor_4c_ImgArc")
1873:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ImgArc") > 0
1874:                 SELECT cursor_4c_ImgArc
1875:                 IF !EMPTY(NVL(cursor_4c_ImgArc.FigJpgs, "")) AND !ISNULL(cursor_4c_ImgArc.FigJpgs)
1876:                     loc_cArquivo = SYS(2023) + "\" + goSistema.Sys2015Tmp + SYS(2015) + ".jpg"
1877:                     loc_cFoto    = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_ImgArc.FigJpgs, ;
1878:                         "data:image/png;base64,", ""), ;
1879:                         "data:image/jpeg;base64,", ""), ;
1880:                         "data:image/jpg;base64,", ""), 14)
1881:                     STRTOFILE(loc_cFoto, loc_cArquivo)
1882:                     loc_oPg2.img_4c_ImgProds.Picture = loc_cArquivo
1883:                     loc_oPg2.img_4c_ImgProds.Visible = .T.
1884:                     loc_lTemImagem = .T.
1885:                 ENDIF
1886:             ENDIF
1887:             IF USED("cursor_4c_ImgArc")
1888:                 USE IN cursor_4c_ImgArc
1889:             ENDIF
1890:             IF !loc_lTemImagem
1891:                 loc_oPg2.img_4c_ImgProds.Visible = .F.

*-- Linhas 1903 a 2010:
1903:     *===========================================================================
1904:     * BtnInserirMuniClick - Adiciona linha em branco na grade de municipios
1905:     *===========================================================================
1906:     PROCEDURE BtnInserirMuniClick()
1907:         TRY
1908:             IF !USED("cursor_4c_Munis")
1909:                 THIS.InicializarGradesVazias()
1910:             ELSE
1911:                 SELECT cursor_4c_Munis
1912:                 APPEND BLANK
1913:                 REPLACE tipos    WITH "M", ;
1914:                         pkchaves WITH "", ;
1915:                         munici   WITH "", ;
1916:                         codibges WITH "", ;
1917:                         uf       WITH "", ;
1918:                         UFIBGEs  WITH 0
1919:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Munis.Refresh()
1920:             ENDIF
1921:         CATCH TO loException
1922:             MsgErro("Erro ao inserir munic" + CHR(237) + "pio:" + CHR(13) + loException.Message, ;
1923:                 "Formrst.BtnInserirMuniClick")
1924:         ENDTRY
1925:     ENDPROC
1926: 
1927:     *===========================================================================
1928:     * BtnExcluirMuniClick - Remove municipio selecionado da grade
1929:     *===========================================================================
1930:     PROCEDURE BtnExcluirMuniClick()
1931:         IF !USED("cursor_4c_Munis") OR EOF("cursor_4c_Munis") OR BOF("cursor_4c_Munis")
1932:             MsgAviso("Selecione um munic" + CHR(237) + "pio para excluir.", "Aviso")
1933:             RETURN
1934:         ENDIF
1935:         TRY
1936:             SELECT cursor_4c_Munis
1937:             DELETE
1938:             THIS.pgf_4c_Paginas.Page2.grd_4c_Munis.Refresh()
1939:         CATCH TO loException
1940:             MsgErro("Erro ao excluir munic" + CHR(237) + "pio:" + CHR(13) + loException.Message, ;
1941:                 "Formrst.BtnExcluirMuniClick")
1942:         ENDTRY
1943:     ENDPROC
1944: 
1945:     *===========================================================================
1946:     * BtnInserirProdClick - Adiciona linha em branco na grade de produtos
1947:     *===========================================================================
1948:     PROCEDURE BtnInserirProdClick()
1949:         TRY
1950:             IF !USED("cursor_4c_Prods")
1951:                 THIS.InicializarGradesVazias()
1952:             ELSE
1953:                 SELECT cursor_4c_Prods
1954:                 APPEND BLANK
1955:                 REPLACE tipos    WITH "P", ;
1956:                         pkchaves WITH "", ;
1957:                         cpros    WITH "", ;
1958:                         dpros    WITH ""
1959:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Prods.Refresh()
1960:             ENDIF
1961:         CATCH TO loException
1962:             MsgErro("Erro ao inserir produto:" + CHR(13) + loException.Message, ;
1963:                 "Formrst.BtnInserirProdClick")
1964:         ENDTRY
1965:     ENDPROC
1966: 
1967:     *===========================================================================
1968:     * BtnExcluirProdClick - Remove produto selecionado da grade
1969:     *===========================================================================
1970:     PROCEDURE BtnExcluirProdClick()
1971:         IF !USED("cursor_4c_Prods") OR EOF("cursor_4c_Prods") OR BOF("cursor_4c_Prods")
1972:             MsgAviso("Selecione um produto para excluir.", "Aviso")
1973:             RETURN
1974:         ENDIF
1975:         TRY
1976:             SELECT cursor_4c_Prods
1977:             DELETE
1978:             THIS.pgf_4c_Paginas.Page2.grd_4c_Prods.Refresh()
1979:         CATCH TO loException
1980:             MsgErro("Erro ao excluir produto:" + CHR(13) + loException.Message, ;
1981:                 "Formrst.BtnExcluirProdClick")
1982:         ENDTRY
1983:     ENDPROC
1984: 
1985:     *===========================================================================
1986:     * AjustarBotoesPorModo - Ajusta estado dos botoes de acao conforme modo atual
1987:     * INCLUIR/ALTERAR -> Confirmar habilitado; VISUALIZAR -> Confirmar desabilitado
1988:     *===========================================================================
1989:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1990:         LOCAL loc_oPg2, loc_lEditando
1991:         TRY
1992:             loc_oPg2      = THIS.pgf_4c_Paginas.Page2
1993:             loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1994: 
1995:             loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEditando OR (THIS.this_cModoAtual = "EXCLUIR")
1996:             loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
1997: 
1998:             loc_oPg2.cmd_4c_InserirMuni.Enabled = loc_lEditando
1999:             loc_oPg2.cmd_4c_ExcluirMuni.Enabled = loc_lEditando
2000:             loc_oPg2.cmd_4c_InserirProd.Enabled = loc_lEditando
2001:             loc_oPg2.cmd_4c_ExcluirProd.Enabled = loc_lEditando
2002:             loc_oPg2.grd_4c_Munis.ReadOnly       = !loc_lEditando
2003:             loc_oPg2.grd_4c_Prods.ReadOnly       = !loc_lEditando
2004:         CATCH TO loException
2005:             MsgErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + loException.Message, ;
2006:                 "Formrst.AjustarBotoesPorModo")
2007:         ENDTRY
2008:     ENDPROC
2009: 
2010: ENDDEFINE


### BO (C:\4c\projeto\app\classes\rstBO.prg):
*==============================================================================
* rstBO.prg - Business Object para Exclusividade Por Contas (SigCdRst/SigCdRsi)
* Herda de BusinessBase
*==============================================================================

DEFINE CLASS rstBO AS BusinessBase

    *-- SigCdRst - Propriedades principais
    this_cSkChaves  = ""    && skchaves  C(20) PK
    this_cIclis     = ""    && iclis     C(10) FK SigCdCli
    this_nChkMatrs  = 0     && chkmatrs  N(1,0) Checa Matriz (op_con)
    this_dDatas     = {}    && datas     D nullable
    this_dDtAlts    = {}    && dtalts    D nullable (auditoria)

    *-- Propriedade derivada (JOIN SigCdCli) - somente exibicao
    this_cRclis     = ""    && Rclis C(40) nome do cliente

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdRst"
            THIS.this_cCampoChave = "skChaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cSkChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - SELECT lista de exclusividades com nome do cliente
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            loc_cSQL = "SELECT a.skchaves, a.iclis, ISNULL(b.Rclis,'') AS Rclis," + ;
                       " a.chkmatrs, a.datas, a.dtalts" + ;
                       " FROM SigCdRst a" + ;
                       " LEFT JOIN SigCdCli b ON b.Iclis = a.Iclis" + ;
                       " ORDER BY b.Rclis"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar exclusividades:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados (skchaves C(20), iclis C(10), Rclis C(40), ;
                    chkmatrs N(1,0), datas T, dtalts T)
                SET NULL OFF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro SigCdRst por skChaves
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cSkChaves)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT a.skchaves, a.iclis, ISNULL(b.Rclis,'') AS Rclis," + ;
                       " a.chkmatrs, a.datas, a.dtalts" + ;
                       " FROM SigCdRst a" + ;
                       " LEFT JOIN SigCdCli b ON b.Iclis = a.Iclis" + ;
                       " WHERE a.skchaves = " + EscaparSQL(par_cSkChaves)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                MsgErro("Registro n" + CHR(227) + "o encontrado.", "Aviso")
            ENDIF
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cSkChaves = TratarNulo(skchaves, "C")
            THIS.this_cIclis    = TratarNulo(iclis,    "C")
            THIS.this_cRclis    = TratarNulo(Rclis,    "C")
            THIS.this_nChkMatrs = TratarNulo(chkmatrs, "N")
            THIS.this_dDatas    = TratarNulo(datas,    "D")
            THIS.this_dDtAlts   = TratarNulo(dtalts,   "D")
            loc_lResultado = .T.
        ENDIF
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarMunicipios - Carrega SigCdRsi tipo 'M' para o skChaves dado
    * Popula cursor_4c_Munis com: skchaves, pkchaves, codibges, tipos, UFIBGEs, munici, uf
    *--------------------------------------------------------------------------
    FUNCTION BuscarMunicipios(par_cSkChaves)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Munis")
                USE IN cursor_4c_Munis
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Munis (skchaves C(20), pkchaves C(20), codibges C(7), ;
                tipos C(1), UFIBGEs N(2,0), munici C(40), uf C(2))
            SET NULL OFF

            IF !EMPTY(par_cSkChaves)
                loc_cSQL = "SELECT DISTINCT a.skchaves, a.pkchaves, a.codibges, a.tipos," + ;
                           " a.ufibges AS UFIBGEs," + ;
                           " ISNULL(c.descs,'') AS munici, ISNULL(d.estados,'') AS uf" + ;
                           " FROM SigCdRsi a" + ;
                           " LEFT JOIN SigCdMun c ON c.codigos = a.codibges" + ;
                           " LEFT JOIN SigCdUfs d ON d.ufibges = a.ufibges" + ;
                           " WHERE a.skchaves = " + EscaparSQL(par_cSkChaves) + " AND a.tipos = 'M'"
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_MunisTmp")
                    TABLEREVERT(.T., "cursor_4c_MunisTmp")
                    USE IN cursor_4c_MunisTmp
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MunisTmp")
                IF loc_nResult >= 0
                    SELECT cursor_4c_MunisTmp
                    SCAN
                        SELECT cursor_4c_Munis
                        APPEND BLANK
                        REPLACE skchaves WITH ALLTRIM(NVL(cursor_4c_MunisTmp.skchaves, "")), ;
                                pkchaves WITH ALLTRIM(NVL(cursor_4c_MunisTmp.pkchaves, "")), ;
                                codibges WITH ALLTRIM(NVL(cursor_4c_MunisTmp.codibges, "")), ;
                                tipos    WITH ALLTRIM(NVL(cursor_4c_MunisTmp.tipos, "")), ;
                                UFIBGEs  WITH NVL(cursor_4c_MunisTmp.UFIBGEs, 0), ;
                                munici   WITH ALLTRIM(NVL(cursor_4c_MunisTmp.munici, "")), ;
                                uf       WITH ALLTRIM(NVL(cursor_4c_MunisTmp.uf, ""))
                        SELECT cursor_4c_MunisTmp
                    ENDSCAN
                    IF USED("cursor_4c_MunisTmp")
                        USE IN cursor_4c_MunisTmp
                    ENDIF
                ENDIF
            ENDIF

            SELECT cursor_4c_Munis
            IF RECCOUNT() = 0
                APPEND BLANK
            ENDIF
            GO TOP IN cursor_4c_Munis
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar munic" + CHR(237) + "pios:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_MunisTmp")
                USE IN cursor_4c_MunisTmp
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarProdutos - Carrega SigCdRsi tipo 'P' para o skChaves dado
    * Popula cursor_4c_Prods com: skchaves, pkchaves, cpros, dpros, tipos
    *--------------------------------------------------------------------------
    FUNCTION BuscarProdutos(par_cSkChaves)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Prods")
                USE IN cursor_4c_Prods
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Prods (skchaves C(20), pkchaves C(20), cpros C(14), ;
                dpros C(40), tipos C(1))
            SET NULL OFF

            IF !EMPTY(par_cSkChaves)
                loc_cSQL = "SELECT DISTINCT a.skchaves, a.pkchaves, a.cpros," + ;
                           " ISNULL(c.dpros,'') AS dpros, a.tipos" + ;
                           " FROM SigCdRsi a" + ;
                           " LEFT JOIN SigCdPro c ON c.cpros = a.cpros" + ;
                           " WHERE a.skchaves = " + EscaparSQL(par_cSkChaves) + " AND a.tipos = 'P'"
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_ProdsTmp")
                    TABLEREVERT(.T., "cursor_4c_ProdsTmp")
                    USE IN cursor_4c_ProdsTmp
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdsTmp")
                IF loc_nResult >= 0
                    SELECT cursor_4c_ProdsTmp
                    SCAN
                        SELECT cursor_4c_Prods
                        APPEND BLANK
                        REPLACE skchaves WITH ALLTRIM(NVL(cursor_4c_ProdsTmp.skchaves, "")), ;
                                pkchaves WITH ALLTRIM(NVL(cursor_4c_ProdsTmp.pkchaves, "")), ;
                                cpros    WITH ALLTRIM(NVL(cursor_4c_ProdsTmp.cpros, "")), ;
                                dpros    WITH ALLTRIM(NVL(cursor_4c_ProdsTmp.dpros, "")), ;
                                tipos    WITH ALLTRIM(NVL(cursor_4c_ProdsTmp.tipos, ""))
                        SELECT cursor_4c_ProdsTmp
                    ENDSCAN
                    IF USED("cursor_4c_ProdsTmp")
                        USE IN cursor_4c_ProdsTmp
                    ENDIF
                ENDIF
            ENDIF

            SELECT cursor_4c_Prods
            IF RECCOUNT() = 0
                APPEND BLANK
            ENDIF
            GO TOP IN cursor_4c_Prods
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar produtos:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ProdsTmp")
                USE IN cursor_4c_ProdsTmp
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarContaCadastrada - Checa se Iclis ja tem exclusividade em SigCdRst
    *--------------------------------------------------------------------------
    FUNCTION VerificarContaCadastrada(par_cIclis)
        LOCAL loc_lExiste, loc_nResult
        loc_lExiste = .F.
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 skchaves FROM SigCdRst WHERE iclis = " + EscaparSQL(par_cIclis), ;
                "cursor_4c_ChkRst")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkRst") > 0
                loc_lExiste = .T.
            ENDIF
            IF USED("cursor_4c_ChkRst")
                USE IN cursor_4c_ChkRst
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ChkRst")
                USE IN cursor_4c_ChkRst
            ENDIF
        ENDTRY
        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarChaveUnica - Gera chave C(20) via NEWID do SQL Server
    *--------------------------------------------------------------------------
    FUNCTION GerarChaveUnica()
        LOCAL loc_cChave, loc_nResult
        loc_cChave = ""
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT LEFT(REPLACE(CAST(NEWID() AS VARCHAR(36)),'-',''),20) AS novachave", ;
                "cursor_4c_NewId")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_NewId") > 0
                SELECT cursor_4c_NewId
                loc_cChave = ALLTRIM(novachave)
            ENDIF
            IF USED("cursor_4c_NewId")
                USE IN cursor_4c_NewId
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao gerar chave:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_NewId")
                USE IN cursor_4c_NewId
            ENDIF
        ENDTRY
        RETURN loc_cChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * InserirItensSigCdRsi - INSERT SigCdRsi de cursor_4c_Munis e cursor_4c_Prods
    * Metodo auxiliar compartilhado por Inserir() e Atualizar()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InserirItensSigCdRsi()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cPkChave
        loc_lResultado = .T.

        *-- INSERT municipios (tipo 'M')
        IF USED("cursor_4c_Munis")
            SELECT cursor_4c_Munis
            GO TOP
            SCAN
                IF !EMPTY(ALLTRIM(cursor_4c_Munis.codibges)) OR cursor_4c_Munis.UFIBGEs <> 0
                    loc_cPkChave = THIS.GerarChaveUnica()
                    IF EMPTY(loc_cPkChave)
                        loc_lResultado = .F.
                    ELSE
                        loc_cSQL = "INSERT INTO SigCdRsi" + ;
                                   " (skchaves, pkchaves, codibges, tipos, ufibges, cpros, dtalts)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(THIS.this_cSkChaves) + "," + ;
                                   EscaparSQL(loc_cPkChave) + "," + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Munis.codibges)) + "," + ;
                                   "'M'," + ;
                                   FormatarNumeroSQL(cursor_4c_Munis.UFIBGEs) + "," + ;
                                   "''," + ;
                                   "GETDATE())"
                        *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                        IF USED("cursor_4c_InsRsi")
                            TABLEREVERT(.T., "cursor_4c_InsRsi")
                            USE IN cursor_4c_InsRsi
                        ENDIF

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsRsi")
                        IF USED("cursor_4c_InsRsi")
                            USE IN cursor_4c_InsRsi
                        ENDIF
                        IF loc_nResult < 0
                            MsgErro("Erro ao inserir munic" + CHR(237) + "pio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                ENDIF
                SELECT cursor_4c_Munis
            ENDSCAN
        ENDIF

        *-- INSERT produtos (tipo 'P')
        IF USED("cursor_4c_Prods")
            SELECT cursor_4c_Prods
            GO TOP
            SCAN
                IF !EMPTY(ALLTRIM(cursor_4c_Prods.cpros))
                    loc_cPkChave = THIS.GerarChaveUnica()
                    IF EMPTY(loc_cPkChave)
                        loc_lResultado = .F.
                    ELSE
                        loc_cSQL = "INSERT INTO SigCdRsi" + ;
                                   " (skchaves, pkchaves, codibges, tipos, ufibges, cpros, dtalts)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(THIS.this_cSkChaves) + "," + ;
                                   EscaparSQL(loc_cPkChave) + "," + ;
                                   "''," + ;
                                   "'P'," + ;
                                   "0," + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Prods.cpros)) + "," + ;
                                   "GETDATE())"
                        *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                        IF USED("cursor_4c_InsRsi")
                            TABLEREVERT(.T., "cursor_4c_InsRsi")
                            USE IN cursor_4c_InsRsi
                        ENDIF

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsRsi")
                        IF USED("cursor_4c_InsRsi")
                            USE IN cursor_4c_InsRsi
                        ENDIF
                        IF loc_nResult < 0
                            MsgErro("Erro ao inserir produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                ENDIF
                SELECT cursor_4c_Prods
            ENDSCAN
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdRst + INSERT SigCdRsi de cursor_4c_Munis e cursor_4c_Prods
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            loc_cSQL = THIS.GerarChaveUnica()
            IF EMPTY(loc_cSQL)
                MsgErro("Erro ao gerar chave prim" + CHR(225) + "ria.", "Erro")
            ELSE
                THIS.this_cSkChaves = loc_cSQL

                loc_cSQL = "INSERT INTO SigCdRst (skchaves, iclis, chkmatrs, datas, dtalts)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cSkChaves) + "," + ;
                           EscaparSQL(THIS.this_cIclis) + "," + ;
                           FormatarNumeroSQL(THIS.this_nChkMatrs) + "," + ;
                           "GETDATE(), NULL)"
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_InsRst")
                    TABLEREVERT(.T., "cursor_4c_InsRst")
                    USE IN cursor_4c_InsRst
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsRst")
                IF USED("cursor_4c_InsRst")
                    USE IN cursor_4c_InsRst
                ENDIF

                IF loc_nResult >= 0
                    IF THIS.InserirItensSigCdRsi()
                        THIS.RegistrarAuditoria("INSERT")
                        loc_lResultado = .T.
                    ENDIF
                ELSE
                    MsgErro("Erro ao inserir exclusividade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigCdRst + DELETE SigCdRsi + INSERT SigCdRsi novos itens
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            *-- DELETE SigCdRsi antigos
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdRsi WHERE skchaves = " + EscaparSQL(THIS.this_cSkChaves), ;
                "cursor_4c_DelRsi")
            IF USED("cursor_4c_DelRsi")
                USE IN cursor_4c_DelRsi
            ENDIF

            IF loc_nResult >= 0
                *-- UPDATE SigCdRst
                loc_cSQL = "UPDATE SigCdRst SET" + ;
                           " iclis = " + EscaparSQL(THIS.this_cIclis) + "," + ;
                           " chkmatrs = " + FormatarNumeroSQL(THIS.this_nChkMatrs) + "," + ;
                           " dtalts = GETDATE()" + ;
                           " WHERE skchaves = " + EscaparSQL(THIS.this_cSkChaves)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_UpdRst")
                    TABLEREVERT(.T., "cursor_4c_UpdRst")
                    USE IN cursor_4c_UpdRst
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdRst")
                IF USED("cursor_4c_UpdRst")
                    USE IN cursor_4c_UpdRst
                ENDIF

                IF loc_nResult >= 0
                    IF THIS.InserirItensSigCdRsi()
                        THIS.RegistrarAuditoria("UPDATE")
                        loc_lResultado = .T.
                    ENDIF
                ELSE
                    MsgErro("Erro ao atualizar exclusividade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao limpar itens da exclusividade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE SigCdRsi e SigCdRst (nesta ordem - FK constraint)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_nResult
        loc_lResultado = .F.
        TRY
            *-- DELETE SigCdRsi primeiro (filho)
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdRsi WHERE skchaves = " + EscaparSQL(THIS.this_cSkChaves), ;
                "cursor_4c_DelRsi2")
            IF USED("cursor_4c_DelRsi2")
                USE IN cursor_4c_DelRsi2
            ENDIF

            IF loc_nResult >= 0
                *-- DELETE SigCdRst (pai)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigCdRst WHERE skchaves = " + EscaparSQL(THIS.this_cSkChaves), ;
                    "cursor_4c_DelRst")
                IF USED("cursor_4c_DelRst")
                    USE IN cursor_4c_DelRst
                ENDIF

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir exclusividade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao excluir itens da exclusividade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

