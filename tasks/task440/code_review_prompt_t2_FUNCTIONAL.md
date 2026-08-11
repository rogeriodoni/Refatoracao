# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formgpr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1986 linhas total):

*-- Linhas 24 a 157:
24:     this_cModoAtual      = "LISTA"
25: 
26:     *--------------------------------------------------------------------------
27:     * Init - DODEFAULT() ja chama InicializarForm() via FormBase.Init()
28:     *--------------------------------------------------------------------------
29:     PROCEDURE Init()
30:         RETURN DODEFAULT()
31:     ENDPROC
32: 
33:     *--------------------------------------------------------------------------
34:     * InicializarForm - Configuracao completa do formulario
35:     *--------------------------------------------------------------------------
36:     PROTECTED PROCEDURE InicializarForm()
37:         LOCAL loc_lSucesso
38:         loc_lSucesso = .F.
39: 
40:         TRY
41:             THIS.this_oBusinessObject = CREATEOBJECT("gprBO")
42: 
43:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
44:                 MostrarErro("Erro ao criar gprBO", "Erro Cr" + CHR(237) + "tico")
45:             ELSE
46:                 THIS.ConfigurarPageFrame()
47:                 THIS.ConfigurarPaginaLista()
48:                 THIS.ConfigurarPaginaDados()
49: 
50:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
51:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
52: 
53:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
54:                     IF !THIS.CarregarLista()
55:                         *-- Falha ao carregar nao impede abertura do formulario
56:                     ENDIF
57:                 ENDIF
58: 
59:                 THIS.pgf_4c_Paginas.Visible    = .T.
60:                 THIS.pgf_4c_Paginas.ActivePage = 1
61:                 THIS.this_cModoAtual           = "LISTA"
62:                 loc_lSucesso = .T.
63:             ENDIF
64: 
65:         CATCH TO loException
66:             MostrarErro("Erro ao inicializar Formgpr:" + CHR(13) + ;
67:                         "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
68:                         loException.Message, "Erro")
69:             loc_lSucesso = .F.
70:         ENDTRY
71: 
72:         RETURN loc_lSucesso
73:     ENDPROC
74: 
75:     *--------------------------------------------------------------------------
76:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
77:     * PageFrame.Top = -29 (canonico) para esconder abas
78:     *--------------------------------------------------------------------------
79:     PROTECTED PROCEDURE ConfigurarPageFrame()
80:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
81:         WITH THIS.pgf_4c_Paginas
82:             .Top       = -29
83:             .Left      = 0
84:             .Width     = 1003
85:             .Height    = 629
86:             .PageCount = 2
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
98:     ENDPROC
99: 
100:     *--------------------------------------------------------------------------
101:     * ConfigurarPaginaLista - Page1: cabecalho, container botoes e saida
102:     * Todos os Top compensados +29 (PageFrame.Top=-29)
103:     * Original: cntSombra.Top=1, Grupo_op.Top=0, Grupo_Saida.Left=918
104:     *--------------------------------------------------------------------------
105:     PROTECTED PROCEDURE ConfigurarPaginaLista()
106:         LOCAL loc_oPagina
107:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
108: 
109:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
110:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
111: 
112:         *-- Container cabecalho escuro (cntSombra: Top=1+29=30, Width=1008 do original)
113:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
114:         WITH loc_oPagina.cnt_4c_Cabecalho
115:             .Top         = 30
116:             .Left        = 0
117:             .Width       = 1008
118:             .Height      = 80
119:             .BackColor   = RGB(100, 100, 100)
120:             .BackStyle   = 1
121:             .BorderWidth = 0
122:             .Visible     = .T.
123:         ENDWITH
124: 
125:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
126:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
127:             .Caption   = "Cadastro de Grande Grupo"
128:             .Top       = 15
129:             .Left      = 10
130:             .Width     = THIS.Width
131:             .Height    = 40
132:             .AutoSize  = .F.
133:             .FontName  = "Tahoma"
134:             .FontSize  = 16
135:             .FontBold  = .T.
136:             .BackStyle = 0
137:             .ForeColor = RGB(0, 0, 0)
138:             .Visible   = .T.
139:         ENDWITH
140: 
141:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
142:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
143:             .Caption   = "Cadastro de Grande Grupo"
144:             .Top       = 18
145:             .Left      = 10
146:             .Width     = THIS.Width
147:             .Height    = 46
148:             .AutoSize  = .F.
149:             .FontName  = "Tahoma"
150:             .FontSize  = 16
151:             .FontBold  = .T.
152:             .BackStyle = 0
153:             .ForeColor = RGB(255, 255, 255)
154:             .Visible   = .T.
155:         ENDWITH
156: 
157:         *-- Container botoes CRUD (Grupo_op: Left=512, Top=0+29=29, Width=414, Height=85)

*-- Linhas 187 a 460:
187:             .WordWrap        = .T.
188:             .Visible         = .T.
189:         ENDWITH
190:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
191: 
192:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
193:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
194:             .Caption         = "Visualizar"
195:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
196:             .PicturePosition = 13
197:             .Top             = 5
198:             .Left            = 80
199:             .Width           = 75
200:             .Height          = 75
201:             .BackColor       = RGB(255, 255, 255)
202:             .ForeColor       = RGB(90, 90, 90)
203:             .FontName        = "Tahoma"
204:             .FontSize        = 8
205:             .FontBold        = .T.
206:             .FontItalic      = .T.
207:             .Themes          = .F.
208:             .SpecialEffect   = 0
209:             .MousePointer    = 15
210:             .WordWrap        = .T.
211:             .Visible         = .T.
212:         ENDWITH
213:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
214: 
215:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
216:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
217:             .Caption         = "Alterar"
218:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
219:             .PicturePosition = 13
220:             .Top             = 5
221:             .Left            = 155
222:             .Width           = 75
223:             .Height          = 75
224:             .BackColor       = RGB(255, 255, 255)
225:             .ForeColor       = RGB(90, 90, 90)
226:             .FontName        = "Tahoma"
227:             .FontSize        = 8
228:             .FontBold        = .T.
229:             .FontItalic      = .T.
230:             .Themes          = .F.
231:             .SpecialEffect   = 0
232:             .MousePointer    = 15
233:             .WordWrap        = .T.
234:             .Visible         = .T.
235:         ENDWITH
236:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
237: 
238:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
239:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
240:             .Caption         = "Excluir"
241:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
242:             .PicturePosition = 13
243:             .Top             = 5
244:             .Left            = 230
245:             .Width           = 75
246:             .Height          = 75
247:             .BackColor       = RGB(255, 255, 255)
248:             .ForeColor       = RGB(90, 90, 90)
249:             .FontName        = "Tahoma"
250:             .FontSize        = 8
251:             .FontBold        = .T.
252:             .FontItalic      = .T.
253:             .Themes          = .F.
254:             .SpecialEffect   = 0
255:             .MousePointer    = 15
256:             .WordWrap        = .T.
257:             .Visible         = .T.
258:         ENDWITH
259:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
260: 
261:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
262:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
263:             .Caption         = "Buscar"
264:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
265:             .PicturePosition = 13
266:             .Top             = 5
267:             .Left            = 305
268:             .Width           = 75
269:             .Height          = 75
270:             .BackColor       = RGB(255, 255, 255)
271:             .ForeColor       = RGB(90, 90, 90)
272:             .FontName        = "Tahoma"
273:             .FontSize        = 8
274:             .FontBold        = .T.
275:             .FontItalic      = .T.
276:             .Themes          = .F.
277:             .SpecialEffect   = 0
278:             .MousePointer    = 15
279:             .WordWrap        = .T.
280:             .Visible         = .T.
281:         ENDWITH
282:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
283: 
284:         *-- Container saida canonico (CLAUDE.md #10: Left=917, Width=90, Height=85)
285:         *-- Grupo_Saida.Left=918 no original -> usar 917 canonico
286:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
287:         WITH loc_oPagina.cnt_4c_Saida
288:             .Top         = 29
289:             .Left        = 917
290:             .Width       = 90
291:             .Height      = 85
292:             .BackStyle   = 0
293:             .BorderWidth = 0
294:             .Visible     = .T.
295:         ENDWITH
296: 
297:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
298:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
299:             .Caption         = "Encerrar"
300:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
301:             .PicturePosition = 13
302:             .Top             = 5
303:             .Left            = 5
304:             .Width           = 75
305:             .Height          = 75
306:             .BackColor       = RGB(255, 255, 255)
307:             .ForeColor       = RGB(90, 90, 90)
308:             .FontName        = "Tahoma"
309:             .FontSize        = 8
310:             .FontBold        = .T.
311:             .FontItalic      = .T.
312:             .Themes          = .F.
313:             .SpecialEffect   = 0
314:             .MousePointer    = 15
315:             .WordWrap        = .T.
316:             .Visible         = .T.
317:         ENDWITH
318:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
319: 
320:         *-- Grid de lista (Grade legado: top=121+29=150, left=12, width=939, height=470)
321:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
322:         WITH loc_oPagina.grd_4c_Lista
323:             .Top                = 150
324:             .Left               = 12
325:             .Width              = 939
326:             .Height             = 470
327:             .ColumnCount        = 3
328:             .FontName           = "Verdana"
329:             .FontSize           = 8
330:             .ForeColor          = RGB(90, 90, 90)
331:             .BackColor          = RGB(255, 255, 255)
332:             .GridLineColor      = RGB(238, 238, 238)
333:             .HighlightBackColor = RGB(255, 255, 255)
334:             .HighlightForeColor = RGB(15, 41, 104)
335:             .HighlightStyle     = 2
336:             .DeleteMark         = .F.
337:             .RecordMark         = .F.
338:             .RowHeight          = 16
339:             .ScrollBars         = 2
340:             .GridLines          = 3
341:             .ReadOnly           = .T.
342:             .Visible            = .T.
343:         ENDWITH
344:         loc_oPagina.grd_4c_Lista.Column1.Width = 79
345:         loc_oPagina.grd_4c_Lista.Column2.Width = 290
346:         loc_oPagina.grd_4c_Lista.Column3.Width = 80
347: 
348:         THIS.TornarControlesVisiveis(loc_oPagina)
349:     ENDPROC
350: 
351:     *--------------------------------------------------------------------------
352:     * ConfigurarPaginaDados - Page2: botoes + primeira metade dos campos
353:     * Grupo_Salva: Left=816, Top=9+29=38, Width=165, Height=85
354:     * Fase 5/8: txt_4c_Codigos ate opt_4c_AlteEtiq (Top original 85-225)
355:     * Todos os Top compensados +29 (PageFrame.Top=-29)
356:     *--------------------------------------------------------------------------
357:     PROTECTED PROCEDURE ConfigurarPaginaDados()
358:         LOCAL loc_oPagina
359:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
360: 
361:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
362:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
363: 
364:         *-- Container salvar/cancelar (Grupo_Salva: Left=816, Top=9+29=38)
365:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
366:         WITH loc_oPagina.cnt_4c_Salva
367:             .Top         = 38
368:             .Left        = 816
369:             .Width       = 165
370:             .Height      = 85
371:             .BackStyle   = 0
372:             .BorderWidth = 0
373:             .Visible     = .T.
374:         ENDWITH
375: 
376:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
377:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
378:             .Caption         = "Confirmar"
379:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
380:             .PicturePosition = 13
381:             .Top             = 5
382:             .Left            = 5
383:             .Width           = 75
384:             .Height          = 75
385:             .BackColor       = RGB(255, 255, 255)
386:             .ForeColor       = RGB(90, 90, 90)
387:             .FontName        = "Tahoma"
388:             .FontSize        = 8
389:             .FontBold        = .T.
390:             .FontItalic      = .T.
391:             .Themes          = .F.
392:             .SpecialEffect   = 0
393:             .MousePointer    = 15
394:             .WordWrap        = .T.
395:             .Visible         = .T.
396:         ENDWITH
397:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
398: 
399:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
400:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
401:             .Caption         = "Encerrar"
402:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
403:             .PicturePosition = 13
404:             .Top             = 5
405:             .Left            = 80
406:             .Width           = 75
407:             .Height          = 75
408:             .BackColor       = RGB(255, 255, 255)
409:             .ForeColor       = RGB(90, 90, 90)
410:             .FontName        = "Tahoma"
411:             .FontSize        = 8
412:             .FontBold        = .T.
413:             .FontItalic      = .T.
414:             .Themes          = .F.
415:             .SpecialEffect   = 0
416:             .MousePointer    = 15
417:             .WordWrap        = .T.
418:             .Visible         = .T.
419:         ENDWITH
420:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
421: 
422:         *======================================================================
423:         * FAIXA 1: Codigo e Descricao (original Top=85/90, compensado 114/119)
424:         *======================================================================
425: 
426:         *-- txt_4c_Codigos (getCodigos: top=85+29=114, left=294, width=30)
427:         loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
428:         WITH loc_oPagina.txt_4c_Codigos
429:             .Value         = ""
430:             .Top           = 114
431:             .Left          = 294
432:             .Width         = 30
433:             .Height        = 25
434:             .MaxLength     = 3
435:             .InputMask     = "XXX"
436:             .SpecialEffect = 1
437:             .FontName      = "Tahoma"
438:             .FontSize      = 8
439:             .Visible       = .T.
440:         ENDWITH
441: 
442:         *-- lbl_4c_Codigo (Say1: top=90+29=119, left=248)
443:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
444:         WITH loc_oPagina.lbl_4c_Codigo
445:             .Caption   = "C" + CHR(243) + "digo :"
446:             .Top       = 119
447:             .Left      = 248
448:             .Width     = 42
449:             .Height    = 15
450:             .FontName  = "Tahoma"
451:             .FontSize  = 8
452:             .ForeColor = RGB(90, 90, 90)
453:             .BackStyle = 0
454:             .AutoSize  = .F.
455:             .Visible   = .T.
456:         ENDWITH
457: 
458:         *-- txt_4c_Descricao (getDescs: top=85+29=114, left=405, width=290)
459:         loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
460:         WITH loc_oPagina.txt_4c_Descricao

*-- Linhas 505 a 633:
505:             .FontSize      = 8
506:             .Visible       = .T.
507:         ENDWITH
508:         BINDEVENT(loc_oPagina.txt_4c_CodConPads, "KeyPress", THIS, "AbrirLookupCodConPads")
509: 
510:         *-- lbl_4c_CodConPads (Say3: top=117+29=146, left=144)
511:         loc_oPagina.AddObject("lbl_4c_CodConPads", "Label")
512:         WITH loc_oPagina.lbl_4c_CodConPads
513:             .Caption   = "Produto Padr" + CHR(227) + "o de Conserto :"
514:             .Top       = 146
515:             .Left      = 144
516:             .Width     = 146
517:             .Height    = 15
518:             .FontName  = "Tahoma"
519:             .FontSize  = 8
520:             .ForeColor = RGB(90, 90, 90)
521:             .BackStyle = 0
522:             .AutoSize  = .F.
523:             .Visible   = .T.
524:         ENDWITH
525: 
526:         *-- txt_4c_DCodConPads (getDCodConPads: top=113+29=142, left=405, width=290)
527:         loc_oPagina.AddObject("txt_4c_DCodConPads", "TextBox")
528:         WITH loc_oPagina.txt_4c_DCodConPads
529:             .Value         = ""
530:             .Top           = 142
531:             .Left          = 405
532:             .Width         = 290
533:             .Height        = 25
534:             .MaxLength     = 40
535:             .SpecialEffect = 1
536:             .FontName      = "Tahoma"
537:             .FontSize      = 8
538:             .Visible       = .T.
539:         ENDWITH
540:         BINDEVENT(loc_oPagina.txt_4c_DCodConPads, "KeyPress", THIS, "AbrirLookupDCodConPads")
541: 
542:         *======================================================================
543:         * FAIXA 3: Linha Padrao de Cadastro (original Top=141/144, comp 170/173)
544:         * Lookup em SigCdLin (Linhas/Descs)
545:         *======================================================================
546: 
547:         *-- txt_4c_Lin (GetLin: top=141+29=170, left=294, width=108, height=23)
548:         loc_oPagina.AddObject("txt_4c_Lin", "TextBox")
549:         WITH loc_oPagina.txt_4c_Lin
550:             .Value         = ""
551:             .Top           = 170
552:             .Left          = 294
553:             .Width         = 108
554:             .Height        = 23
555:             .MaxLength     = 10
556:             .SpecialEffect = 1
557:             .FontName      = "Tahoma"
558:             .FontSize      = 8
559:             .Visible       = .T.
560:         ENDWITH
561:         BINDEVENT(loc_oPagina.txt_4c_Lin, "KeyPress", THIS, "AbrirLookupLin")
562: 
563:         *-- lbl_4c_Lin (Say16: top=144+29=173, left=157)
564:         loc_oPagina.AddObject("lbl_4c_Lin", "Label")
565:         WITH loc_oPagina.lbl_4c_Lin
566:             .Caption   = "Linha Padr" + CHR(227) + "o de Cadastro :"
567:             .Top       = 173
568:             .Left      = 157
569:             .Width     = 133
570:             .Height    = 15
571:             .FontName  = "Tahoma"
572:             .FontSize  = 8
573:             .ForeColor = RGB(90, 90, 90)
574:             .BackStyle = 0
575:             .AutoSize  = .F.
576:             .Visible   = .T.
577:         ENDWITH
578: 
579:         *-- txt_4c_DLin (GetDLin: top=141+29=170, left=405, width=290, height=23)
580:         loc_oPagina.AddObject("txt_4c_DLin", "TextBox")
581:         WITH loc_oPagina.txt_4c_DLin
582:             .Value         = ""
583:             .Top           = 170
584:             .Left          = 405
585:             .Width         = 290
586:             .Height        = 23
587:             .MaxLength     = 40
588:             .SpecialEffect = 1
589:             .FontName      = "Tahoma"
590:             .FontSize      = 8
591:             .Visible       = .T.
592:         ENDWITH
593:         BINDEVENT(loc_oPagina.txt_4c_DLin, "KeyPress", THIS, "AbrirLookupDLin")
594: 
595:         *======================================================================
596:         * FAIXA 4: Digito CodAut + Prioridade (original Top=167/172, comp 196/201)
597:         *======================================================================
598: 
599:         *-- txt_4c_CodAut (Get_CodAut: top=167+29=196, left=294, width=18)
600:         loc_oPagina.AddObject("txt_4c_CodAut", "TextBox")
601:         WITH loc_oPagina.txt_4c_CodAut
602:             .Value         = ""
603:             .Top           = 196
604:             .Left          = 294
605:             .Width         = 18
606:             .Height        = 25
607:             .MaxLength     = 1
608:             .SpecialEffect = 1
609:             .FontName      = "Tahoma"
610:             .FontSize      = 8
611:             .Visible       = .T.
612:         ENDWITH
613: 
614:         *-- lbl_4c_CodAut (Say6: top=172+29=201, left=105)
615:         loc_oPagina.AddObject("lbl_4c_CodAut", "Label")
616:         WITH loc_oPagina.lbl_4c_CodAut
617:             .Caption   = "D" + CHR(237) + "gito do Produto C" + CHR(243) + "digo Autom" + CHR(225) + "tico :"
618:             .Top       = 201
619:             .Left      = 105
620:             .Width     = 185
621:             .Height    = 15
622:             .FontName  = "Tahoma"
623:             .FontSize  = 8
624:             .ForeColor = RGB(90, 90, 90)
625:             .BackStyle = 0
626:             .AutoSize  = .F.
627:             .Visible   = .T.
628:         ENDWITH
629: 
630:         *-- txt_4c_Prioridade (Get_prioridade: top=167+29=196, left=522, width=17)
631:         loc_oPagina.AddObject("txt_4c_Prioridade", "TextBox")
632:         WITH loc_oPagina.txt_4c_Prioridade
633:             .Value         = 0

*-- Linhas 665 a 708:
665:         *======================================================================
666: 
667:         *-- opt_4c_BlqEtq (Get_BlqEtq: top=194+29=223, left=289, width=92)
668:         loc_oPagina.AddObject("opt_4c_BlqEtq", "OptionGroup")
669:         WITH loc_oPagina.opt_4c_BlqEtq
670:             .ButtonCount = 2
671:             .Value       = 2
672:             .Top         = 223
673:             .Left        = 289
674:             .Width       = 94
675:             .Height      = 25
676:             .BackStyle   = 0
677:             .BorderStyle = 0
678:             .Visible     = .T.
679:         ENDWITH
680:         WITH loc_oPagina.opt_4c_BlqEtq.Buttons(1)
681:             .Caption   = "Sim"
682:             .Left      = 5
683:             .Top       = 5
684:             .Width     = 34
685:             .Height    = 15
686:             .AutoSize  = .T.
687:             .FontName  = "Tahoma"
688:             .FontSize  = 8
689:             .ForeColor = RGB(90, 90, 90)
690:             .BackStyle = 0
691:         ENDWITH
692:         WITH loc_oPagina.opt_4c_BlqEtq.Buttons(2)
693:             .Caption   = "N" + CHR(227) + "o"
694:             .Left      = 50
695:             .Top       = 5
696:             .Width     = 34
697:             .Height    = 15
698:             .AutoSize  = .T.
699:             .FontName  = "Tahoma"
700:             .FontSize  = 8
701:             .ForeColor = RGB(90, 90, 90)
702:             .BackStyle = 0
703:         ENDWITH
704: 
705:         *-- lbl_4c_BlqEtq (Say10: top=199+29=228, left=98)
706:         loc_oPagina.AddObject("lbl_4c_BlqEtq", "Label")
707:         WITH loc_oPagina.lbl_4c_BlqEtq
708:             .Caption   = "Bloquear Altera" + CHR(231) + CHR(227) + "o Etiqueta Individual :"

*-- Linhas 724 a 767:
724:         *======================================================================
725: 
726:         *-- opt_4c_AlteEtiq (fwoption4: top=220+29=249, left=288, width=92)
727:         loc_oPagina.AddObject("opt_4c_AlteEtiq", "OptionGroup")
728:         WITH loc_oPagina.opt_4c_AlteEtiq
729:             .ButtonCount = 2
730:             .Value       = 2
731:             .Top         = 249
732:             .Left        = 288
733:             .Width       = 94
734:             .Height      = 25
735:             .BackStyle   = 0
736:             .BorderStyle = 0
737:             .Visible     = .T.
738:         ENDWITH
739:         WITH loc_oPagina.opt_4c_AlteEtiq.Buttons(1)
740:             .Caption   = "Sim"
741:             .Left      = 5
742:             .Top       = 5
743:             .Width     = 34
744:             .Height    = 15
745:             .AutoSize  = .T.
746:             .FontName  = "Tahoma"
747:             .FontSize  = 8
748:             .ForeColor = RGB(90, 90, 90)
749:             .BackStyle = 0
750:         ENDWITH
751:         WITH loc_oPagina.opt_4c_AlteEtiq.Buttons(2)
752:             .Caption   = "N" + CHR(227) + "o"
753:             .Left      = 50
754:             .Top       = 5
755:             .Width     = 34
756:             .Height    = 15
757:             .AutoSize  = .T.
758:             .FontName  = "Tahoma"
759:             .FontSize  = 8
760:             .ForeColor = RGB(90, 90, 90)
761:             .BackStyle = 0
762:         ENDWITH
763: 
764:         *-- lbl_4c_AlteEtiq (Say13: top=225+29=254, left=118)
765:         loc_oPagina.AddObject("lbl_4c_AlteEtiq", "Label")
766:         WITH loc_oPagina.lbl_4c_AlteEtiq
767:             .Caption   = "Permite Alterar Dados da Etiqueta :"

*-- Linhas 825 a 990:
825:             .FontSize      = 8
826:             .Visible       = .T.
827:         ENDWITH
828:         BINDEVENT(loc_oPagina.txt_4c_MatPrincs, "InteractiveChange", THIS, "AbrirLookupMatPrincs")
829:         BINDEVENT(loc_oPagina.txt_4c_MatPrincs, "KeyPress",          THIS, "AbrirLookupMatPrincs")
830: 
831:         *-- lbl_4c_MatPrincs (Say4: top=272+29=301, left=201, width=89)
832:         loc_oPagina.AddObject("lbl_4c_MatPrincs", "Label")
833:         WITH loc_oPagina.lbl_4c_MatPrincs
834:             .Caption   = "Material Principal :"
835:             .Top       = 301
836:             .Left      = 201
837:             .Width     = 89
838:             .Height    = 15
839:             .FontName  = "Tahoma"
840:             .FontSize  = 8
841:             .ForeColor = RGB(90, 90, 90)
842:             .BackStyle = 0
843:             .AutoSize  = .F.
844:             .Visible   = .T.
845:         ENDWITH
846: 
847:         *======================================================================
848:         * FAIXA 8: Controla por Qtde (Cpq)
849:         * Opc_Cpq: top=291+29=320, left=289; Sim(legado Value=0)=ativo, N" + CHR(227) + "o(legado Value=1); default Value=2
850:         * -> this_nCpqtds: opt.Value=1 -> 0, opt.Value=2 -> 1
851:         *======================================================================
852: 
853:         *-- opt_4c_Cpq (Opc_Cpq: top=291+29=320, left=289)
854:         loc_oPagina.AddObject("opt_4c_Cpq", "OptionGroup")
855:         WITH loc_oPagina.opt_4c_Cpq
856:             .Value       = 2
857:             .Top         = 320
858:             .Left        = 289
859:             .Width       = 100
860:             .Height      = 20
861:             .ButtonCount = 2
862:             .BackStyle   = 0
863:             .Visible     = .T.
864:             WITH .Buttons(1)
865:                 .Caption = "Sim"
866:                 .Width   = 46
867:                 .Height  = 20
868:             ENDWITH
869:             WITH .Buttons(2)
870:                 .Caption = "N" + CHR(227) + "o"
871:                 .Width   = 46
872:                 .Height  = 20
873:                 .Left    = 49
874:                 .FontName = "Tahoma"
875:                 .FontSize = 8
876:             ENDWITH
877:         ENDWITH
878: 
879:         *-- lbl_4c_Cpq (Say5: top=296+29=325, left=190, width=100)
880:         loc_oPagina.AddObject("lbl_4c_Cpq", "Label")
881:         WITH loc_oPagina.lbl_4c_Cpq
882:             .Caption   = "Controla por Qtde. :"
883:             .Top       = 325
884:             .Left      = 190
885:             .Width     = 100
886:             .Height    = 15
887:             .FontName  = "Tahoma"
888:             .FontSize  = 8
889:             .ForeColor = RGB(90, 90, 90)
890:             .BackStyle = 0
891:             .AutoSize  = .F.
892:             .Visible   = .T.
893:         ENDWITH
894: 
895:         *======================================================================
896:         * FAIXA 9: Aplica Falha Admitida (FalhaAdm) - INVERTIDO vs demais!
897:         * Opc_FalhaAdm: top=313+29=342, left=289; Sim=AplicFlhs 1, N" + CHR(227) + "o=AplicFlhs 0; default Value=1
898:         * -> this_nAplicflhs: opt.Value=1 -> 1, opt.Value=2 -> 0
899:         *======================================================================
900: 
901:         *-- opt_4c_FalhaAdm (Opc_FalhaAdm: top=313+29=342, left=289, default=1)
902:         loc_oPagina.AddObject("opt_4c_FalhaAdm", "OptionGroup")
903:         WITH loc_oPagina.opt_4c_FalhaAdm
904:             .Value       = 1
905:             .Top         = 342
906:             .Left        = 289
907:             .Width       = 100
908:             .Height      = 20
909:             .ButtonCount = 2
910:             .BackStyle   = 0
911:             .Visible     = .T.
912:             WITH .Buttons(1)
913:                 .Caption = "Sim"
914:                 .Width   = 46
915:                 .Height  = 20
916:             ENDWITH
917:             WITH .Buttons(2)
918:                 .Caption = "N" + CHR(227) + "o"
919:                 .Width   = 46
920:                 .Height  = 20
921:                 .Left    = 49
922:                 .FontName = "Tahoma"
923:                 .FontSize = 8
924:             ENDWITH
925:         ENDWITH
926: 
927:         *-- lbl_4c_FalhaAdm (Say7: top=318+29=347, left=180, width=110)
928:         loc_oPagina.AddObject("lbl_4c_FalhaAdm", "Label")
929:         WITH loc_oPagina.lbl_4c_FalhaAdm
930:             .Caption   = "Aplica Falha Admitida :"
931:             .Top       = 347
932:             .Left      = 180
933:             .Width     = 110
934:             .Height    = 15
935:             .FontName  = "Tahoma"
936:             .FontSize  = 8
937:             .ForeColor = RGB(90, 90, 90)
938:             .BackStyle = 0
939:             .AutoSize  = .F.
940:             .Visible   = .T.
941:         ENDWITH
942: 
943:         *======================================================================
944:         * FAIXA 10: OF Obrigat" + CHR(243) + "rio na Pesagem (PesEnvs)
945:         * fwoption1: top=334+29=363, left=289; Sim(legado Value=0), N" + CHR(227) + "o(legado Value=1); default Value=2
946:         * -> this_nPesenvs: opt.Value=1 -> 0, opt.Value=2 -> 1
947:         *======================================================================
948: 
949:         *-- opt_4c_PesEnvs (fwoption1: top=334+29=363, left=289)
950:         loc_oPagina.AddObject("opt_4c_PesEnvs", "OptionGroup")
951:         WITH loc_oPagina.opt_4c_PesEnvs
952:             .Value       = 2
953:             .Top         = 363
954:             .Left        = 289
955:             .Width       = 100
956:             .Height      = 20
957:             .ButtonCount = 2
958:             .BackStyle   = 0
959:             .Visible     = .T.
960:             WITH .Buttons(1)
961:                 .Caption = "Sim"
962:                 .Width   = 46
963:                 .Height  = 20
964:             ENDWITH
965:             WITH .Buttons(2)
966:                 .Caption = "N" + CHR(227) + "o"
967:                 .Width   = 46
968:                 .Height  = 20
969:                 .Left    = 49
970:                 .FontName = "Tahoma"
971:                 .FontSize = 8
972:             ENDWITH
973:         ENDWITH
974: 
975:         *-- lbl_4c_PesEnvs (Say8: top=339+29=368, left=149, width=141)
976:         loc_oPagina.AddObject("lbl_4c_PesEnvs", "Label")
977:         WITH loc_oPagina.lbl_4c_PesEnvs
978:             .Caption   = "OF Obrigat" + CHR(243) + "rio na Pesagem :"
979:             .Top       = 368
980:             .Left      = 149
981:             .Width     = 141
982:             .Height    = 15
983:             .FontName  = "Tahoma"
984:             .FontSize  = 8
985:             .ForeColor = RGB(90, 90, 90)
986:             .BackStyle = 0
987:             .AutoSize  = .F.
988:             .Visible   = .T.
989:         ENDWITH
990: 

*-- Linhas 997 a 1065:
997:         *======================================================================
998: 
999:         *-- opt_4c_SemUso2 (fwoption2 / Fchcxs - sem uso)
1000:         loc_oPagina.AddObject("opt_4c_SemUso2", "OptionGroup")
1001:         WITH loc_oPagina.opt_4c_SemUso2
1002:             .Value       = 2
1003:             .Top         = 558
1004:             .Left        = 527
1005:             .Width       = 100
1006:             .Height      = 20
1007:             .ButtonCount = 2
1008:             .BackStyle   = 0
1009:             .Visible     = .F.
1010:             .ForeColor   = RGB(255, 0, 0)
1011:             WITH .Buttons(1)
1012:                 .Caption = "Sim"
1013:                 .Width   = 46
1014:                 .Height  = 20
1015:             ENDWITH
1016:             WITH .Buttons(2)
1017:                 .Caption = "N" + CHR(227) + "o"
1018:                 .Width   = 46
1019:                 .Height  = 20
1020:                 .Left    = 49
1021:             ENDWITH
1022:         ENDWITH
1023: 
1024:         *-- opt_4c_SemUso3 (fwoption3 / nChkObjs - sem uso)
1025:         loc_oPagina.AddObject("opt_4c_SemUso3", "OptionGroup")
1026:         WITH loc_oPagina.opt_4c_SemUso3
1027:             .Value       = 2
1028:             .Top         = 582
1029:             .Left        = 491
1030:             .Width       = 100
1031:             .Height      = 20
1032:             .ButtonCount = 2
1033:             .BackStyle   = 0
1034:             .Visible     = .F.
1035:             .ForeColor   = RGB(255, 0, 0)
1036:             WITH .Buttons(1)
1037:                 .Caption = "Sim"
1038:                 .Width   = 46
1039:                 .Height  = 20
1040:             ENDWITH
1041:             WITH .Buttons(2)
1042:                 .Caption = "N" + CHR(227) + "o"
1043:                 .Width   = 46
1044:                 .Height  = 20
1045:                 .Left    = 49
1046:             ENDWITH
1047:         ENDWITH
1048: 
1049:         *-- lbl_4c_SemUso9 (Say9 "sem uso": top=533+29=562, left=475)
1050:         loc_oPagina.AddObject("lbl_4c_SemUso9", "Label")
1051:         WITH loc_oPagina.lbl_4c_SemUso9
1052:             .Caption   = "sem uso :"
1053:             .Top       = 562
1054:             .Left      = 475
1055:             .Width     = 50
1056:             .Height    = 15
1057:             .FontName  = "Verdana"
1058:             .FontSize  = 8
1059:             .ForeColor = RGB(255, 0, 0)
1060:             .BackStyle = 0
1061:             .AutoSize  = .F.
1062:             .Visible   = .F.
1063:         ENDWITH
1064: 
1065:         *-- lbl_4c_SemUso12 (Say12 "sem uso :": top=558+29=587, left=435)

*-- Linhas 1078 a 1986:
1078:             .Visible   = .F.
1079:         ENDWITH
1080: 
1081:         *-- BINDEVENT: Prioridade -> ValidarPrioridade (LostFocus)
1082:         BINDEVENT(loc_oPagina.txt_4c_Prioridade, "KeyPress", THIS, "ValidarPrioridade")
1083: 
1084:         THIS.TornarControlesVisiveis(loc_oPagina)
1085: 
1086:         *-- Reesconder campos "sem uso" (TornarControlesVisiveis forcou Visible=.T.)
1087:         loc_oPagina.opt_4c_SemUso2.Visible  = .F.
1088:         loc_oPagina.opt_4c_SemUso3.Visible  = .F.
1089:         loc_oPagina.lbl_4c_SemUso9.Visible  = .F.
1090:         loc_oPagina.lbl_4c_SemUso12.Visible = .F.
1091:     ENDPROC
1092: 
1093:     *--------------------------------------------------------------------------
1094:     * CarregarLista - Carrega dados no grid da Page1
1095:     * Grid e conexao do RecordSource serao configurados na Fase 4
1096:     *--------------------------------------------------------------------------
1097:     PROCEDURE CarregarLista()
1098:         LOCAL loc_lResultado, loc_oGrid
1099:         loc_lResultado = .F.
1100: 
1101:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1102:             loc_lResultado = .T.
1103:         ELSE
1104:             TRY
1105:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
1106:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1107:                     loc_lResultado = THIS.this_oBusinessObject.Buscar("")
1108:                     IF loc_lResultado AND USED("cursor_4c_Dados")
1109:                         loc_oGrid.ColumnCount = 3
1110:                         loc_oGrid.RecordSource          = "cursor_4c_Dados"
1111:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
1112:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
1113:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.linhas"
1114:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1115:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1116:                         loc_oGrid.Column3.Header1.Caption = "Linhas"
1117:                         THIS.FormatarGridLista(loc_oGrid)
1118:                         loc_oGrid.Refresh()
1119:                     ENDIF
1120:                 ENDIF
1121:             CATCH TO loException
1122:                 MostrarErro("Erro ao carregar lista:" + CHR(13) + ;
1123:                             "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
1124:                             loException.Message, "Formgpr.CarregarLista")
1125:                 loc_lResultado = .F.
1126:             ENDTRY
1127:         ENDIF
1128: 
1129:         RETURN loc_lResultado
1130:     ENDPROC
1131: 
1132:     *--------------------------------------------------------------------------
1133:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
1134:     *--------------------------------------------------------------------------
1135:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1136:         LOCAL loc_lResultado
1137:         loc_lResultado = .F.
1138: 
1139:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
1140:             RETURN .F.
1141:         ENDIF
1142: 
1143:         TRY
1144:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1145:             IF par_nPagina = 1
1146:                 THIS.CarregarLista()
1147:             ENDIF
1148:             loc_lResultado = .T.
1149:         CATCH TO loException
1150:             MostrarErro("Erro ao alternar pagina:" + CHR(13) + ;
1151:                         loException.Message, "Formgpr.AlternarPagina")
1152:             loc_lResultado = .F.
1153:         ENDTRY
1154: 
1155:         RETURN loc_lResultado
1156:     ENDPROC
1157: 
1158:     *--------------------------------------------------------------------------
1159:     * BtnEncerrarClick - Fecha o formulario
1160:     *--------------------------------------------------------------------------
1161:     PROCEDURE BtnEncerrarClick()
1162:         THIS.Release()
1163:     ENDPROC
1164: 
1165:     *--------------------------------------------------------------------------
1166:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1167:     * Itera Pages de PageFrames e Controls de Containers
1168:     *--------------------------------------------------------------------------
1169:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1170:         LOCAL loc_nI, loc_oObjeto, loc_nP
1171: 
1172:         IF VARTYPE(par_oContainer) != "O"
1173:             RETURN
1174:         ENDIF
1175: 
1176:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1177:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1178: 
1179:             IF VARTYPE(loc_oObjeto) = "O"
1180:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1181:                     IF !INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO")
1182:                         loc_oObjeto.Visible = .T.
1183:                     ENDIF
1184:                 ENDIF
1185: 
1186:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1187:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1188:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1189:                     ENDFOR
1190:                 ENDIF
1191: 
1192:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
1193:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1194:                 ENDIF
1195:             ENDIF
1196:         ENDFOR
1197:     ENDPROC
1198: 
1199:     *--------------------------------------------------------------------------
1200:     * AbrirLookupCodConPads - Lookup Produto Padrao de Conserto (por codigo)
1201:     * Original: getCodConPads Valid -> fwBuscaExt em SigCdPro (CPros/DPros)
1202:     *--------------------------------------------------------------------------
1203:     PROCEDURE AbrirLookupCodConPads(par_nKeyCode, par_nShiftAltCtrl)
1204:         LOCAL loc_oPg2, loc_cValor, loc_oBusca, loc_cCodigo, loc_cDesc
1205: 
1206:         IF PCOUNT() >= 1 AND TYPE("par_nKeyCode") = "N"
1207:             IF !INLIST(par_nKeyCode, 13, 9, 115)
1208:                 RETURN
1209:             ENDIF
1210:         ENDIF
1211: 
1212:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1213:         loc_cValor = ALLTRIM(loc_oPg2.txt_4c_CodConPads.Value)
1214: 
1215:         IF EMPTY(loc_cValor)
1216:             loc_oPg2.txt_4c_DCodConPads.Value = ""
1217:             RETURN
1218:         ENDIF
1219: 
1220:         TRY
1221:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1222:                 "SigCdPro", "cursor_4c_BuscaProd", "CPros", loc_cValor, ;
1223:                 "Produto Padr" + CHR(227) + "o de Conserto")
1224: 
1225:             IF VARTYPE(loc_oBusca) = "O"
1226:                 IF !loc_oBusca.this_lAchouRegistro
1227:                     loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
1228:                     loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
1229:                     loc_oBusca.Show()
1230:                 ENDIF
1231: 
1232:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
1233:                     SELECT cursor_4c_BuscaProd
1234:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaProd.CPros)
1235:                     loc_cDesc   = ALLTRIM(cursor_4c_BuscaProd.DPros)
1236:                     loc_oPg2.txt_4c_CodConPads.Value  = loc_cCodigo
1237:                     loc_oPg2.txt_4c_DCodConPads.Value = loc_cDesc
1238:                 ELSE
1239:                     IF !loc_oBusca.this_lSelecionou AND !loc_oBusca.this_lAchouRegistro
1240:                     loc_oPg2.txt_4c_CodConPads.Value  = ""
1241:                     loc_oPg2.txt_4c_DCodConPads.Value = ""
1242:                     ENDIF
1243:                 ENDIF
1244: 
1245:                 loc_oBusca.Release()
1246:             ENDIF
1247:         CATCH TO loException
1248:             MostrarErro("Erro no lookup produto:" + CHR(13) + loException.Message, "Formgpr.AbrirLookupCodConPads")
1249:         ENDTRY
1250: 
1251:         IF USED("cursor_4c_BuscaProd")
1252:             USE IN cursor_4c_BuscaProd
1253:         ENDIF
1254:     ENDPROC
1255: 
1256:     *--------------------------------------------------------------------------
1257:     * AbrirLookupDCodConPads - Lookup Produto Padrao de Conserto (por descricao)
1258:     * Original: getDCodConPads Valid -> fwBuscaExt em SigCdPro (DPros/CPros)
1259:     *--------------------------------------------------------------------------
1260:     PROCEDURE AbrirLookupDCodConPads(par_nKeyCode, par_nShiftAltCtrl)
1261:         LOCAL loc_oPg2, loc_cValor, loc_oBusca, loc_cCodigo, loc_cDesc
1262: 
1263:         IF PCOUNT() >= 1 AND TYPE("par_nKeyCode") = "N"
1264:             IF !INLIST(par_nKeyCode, 13, 9, 115)
1265:                 RETURN
1266:             ENDIF
1267:         ENDIF
1268: 
1269:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1270:         loc_cValor = ALLTRIM(loc_oPg2.txt_4c_DCodConPads.Value)
1271: 
1272:         IF EMPTY(loc_cValor)
1273:             loc_oPg2.txt_4c_CodConPads.Value = ""
1274:             RETURN
1275:         ENDIF
1276: 
1277:         TRY
1278:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1279:                 "SigCdPro", "cursor_4c_BuscaProd", "DPros", loc_cValor, ;
1280:                 "Produto Padr" + CHR(227) + "o de Conserto")
1281: 
1282:             IF VARTYPE(loc_oBusca) = "O"
1283:                 IF !loc_oBusca.this_lAchouRegistro
1284:                     loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
1285:                     loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
1286:                     loc_oBusca.Show()
1287:                 ENDIF
1288: 
1289:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
1290:                     SELECT cursor_4c_BuscaProd
1291:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaProd.CPros)
1292:                     loc_cDesc   = ALLTRIM(cursor_4c_BuscaProd.DPros)
1293:                     loc_oPg2.txt_4c_CodConPads.Value  = loc_cCodigo
1294:                     loc_oPg2.txt_4c_DCodConPads.Value = loc_cDesc
1295:                 ELSE
1296:                     IF !loc_oBusca.this_lSelecionou AND !loc_oBusca.this_lAchouRegistro
1297:                     loc_oPg2.txt_4c_CodConPads.Value  = ""
1298:                     loc_oPg2.txt_4c_DCodConPads.Value = ""
1299:                     ENDIF
1300:                 ENDIF
1301: 
1302:                 loc_oBusca.Release()
1303:             ENDIF
1304:         CATCH TO loException
1305:             MostrarErro("Erro no lookup produto:" + CHR(13) + loException.Message, "Formgpr.AbrirLookupDCodConPads")
1306:         ENDTRY
1307: 
1308:         IF USED("cursor_4c_BuscaProd")
1309:             USE IN cursor_4c_BuscaProd
1310:         ENDIF
1311:     ENDPROC
1312: 
1313:     *--------------------------------------------------------------------------
1314:     * AbrirLookupLin - Lookup Linha Padrao de Cadastro (por codigo)
1315:     * Original: GetLin Valid -> fwBuscaExt em SigCdLin (Linhas/Descs)
1316:     *--------------------------------------------------------------------------
1317:     PROCEDURE AbrirLookupLin(par_nKeyCode, par_nShiftAltCtrl)
1318:         LOCAL loc_oPg2, loc_cValor, loc_oBusca, loc_cCod, loc_cDesc
1319: 
1320:         IF PCOUNT() >= 1 AND TYPE("par_nKeyCode") = "N"
1321:             IF !INLIST(par_nKeyCode, 13, 9, 115)
1322:                 RETURN
1323:             ENDIF
1324:         ENDIF
1325: 
1326:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1327:         loc_cValor = ALLTRIM(loc_oPg2.txt_4c_Lin.Value)
1328: 
1329:         IF EMPTY(loc_cValor)
1330:             loc_oPg2.txt_4c_DLin.Value = ""
1331:             RETURN
1332:         ENDIF
1333: 
1334:         TRY
1335:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1336:                 "SigCdLin", "cursor_4c_BuscaLin", "Linhas", loc_cValor, ;
1337:                 "Linha Padr" + CHR(227) + "o de Cadastro")
1338: 
1339:             IF VARTYPE(loc_oBusca) = "O"
1340:                 IF !loc_oBusca.this_lAchouRegistro
1341:                     loc_oBusca.mAddColuna("Linhas", "", "C" + CHR(243) + "digo")
1342:                     loc_oBusca.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1343:                     loc_oBusca.Show()
1344:                 ENDIF
1345: 
1346:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLin")
1347:                     SELECT cursor_4c_BuscaLin
1348:                     loc_cCod  = ALLTRIM(cursor_4c_BuscaLin.Linhas)
1349:                     loc_cDesc = ALLTRIM(cursor_4c_BuscaLin.Descs)
1350:                     loc_oPg2.txt_4c_Lin.Value  = loc_cCod
1351:                     loc_oPg2.txt_4c_DLin.Value = loc_cDesc
1352:                 ELSE
1353:                     IF !loc_oBusca.this_lSelecionou AND !loc_oBusca.this_lAchouRegistro
1354:                     loc_oPg2.txt_4c_Lin.Value  = ""
1355:                     loc_oPg2.txt_4c_DLin.Value = ""
1356:                     ENDIF
1357:                 ENDIF
1358: 
1359:                 loc_oBusca.Release()
1360:             ENDIF
1361:         CATCH TO loException
1362:             MostrarErro("Erro no lookup linha:" + CHR(13) + loException.Message, "Formgpr.AbrirLookupLin")
1363:         ENDTRY
1364: 
1365:         IF USED("cursor_4c_BuscaLin")
1366:             USE IN cursor_4c_BuscaLin
1367:         ENDIF
1368:     ENDPROC
1369: 
1370:     *--------------------------------------------------------------------------
1371:     * AbrirLookupDLin - Lookup Linha Padrao de Cadastro (por descricao)
1372:     * Original: GetDLin Valid -> fwBuscaExt em SigCdLin (Descs/Linhas)
1373:     *--------------------------------------------------------------------------
1374:     PROCEDURE AbrirLookupDLin(par_nKeyCode, par_nShiftAltCtrl)
1375:         LOCAL loc_oPg2, loc_cValor, loc_oBusca, loc_cCod, loc_cDesc
1376: 
1377:         IF PCOUNT() >= 1 AND TYPE("par_nKeyCode") = "N"
1378:             IF !INLIST(par_nKeyCode, 13, 9, 115)
1379:                 RETURN
1380:             ENDIF
1381:         ENDIF
1382: 
1383:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1384:         loc_cValor = ALLTRIM(loc_oPg2.txt_4c_DLin.Value)
1385: 
1386:         IF EMPTY(loc_cValor)
1387:             loc_oPg2.txt_4c_Lin.Value = ""
1388:             RETURN
1389:         ENDIF
1390: 
1391:         TRY
1392:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1393:                 "SigCdLin", "cursor_4c_BuscaLin", "Descs", loc_cValor, ;
1394:                 "Linha Padr" + CHR(227) + "o de Cadastro")
1395: 
1396:             IF VARTYPE(loc_oBusca) = "O"
1397:                 IF !loc_oBusca.this_lAchouRegistro
1398:                     loc_oBusca.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1399:                     loc_oBusca.mAddColuna("Linhas", "", "C" + CHR(243) + "digo")
1400:                     loc_oBusca.Show()
1401:                 ENDIF
1402: 
1403:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLin")
1404:                     SELECT cursor_4c_BuscaLin
1405:                     loc_cCod  = ALLTRIM(cursor_4c_BuscaLin.Linhas)
1406:                     loc_cDesc = ALLTRIM(cursor_4c_BuscaLin.Descs)
1407:                     loc_oPg2.txt_4c_Lin.Value  = loc_cCod
1408:                     loc_oPg2.txt_4c_DLin.Value = loc_cDesc
1409:                 ELSE
1410:                     IF !loc_oBusca.this_lSelecionou AND !loc_oBusca.this_lAchouRegistro
1411:                     loc_oPg2.txt_4c_Lin.Value  = ""
1412:                     loc_oPg2.txt_4c_DLin.Value = ""
1413:                     ENDIF
1414:                 ENDIF
1415: 
1416:                 loc_oBusca.Release()
1417:             ENDIF
1418:         CATCH TO loException
1419:             MostrarErro("Erro no lookup linha:" + CHR(13) + loException.Message, "Formgpr.AbrirLookupDLin")
1420:         ENDTRY
1421: 
1422:         IF USED("cursor_4c_BuscaLin")
1423:             USE IN cursor_4c_BuscaLin
1424:         ENDIF
1425:     ENDPROC
1426: 
1427:     *--------------------------------------------------------------------------
1428:     * AbrirLookupMatPrincs - Lookup para Material Principal (SigCdPro)
1429:     * Acionado por InteractiveChange e KeyPress de txt_4c_MatPrincs
1430:     *--------------------------------------------------------------------------
1431:     PROCEDURE AbrirLookupMatPrincs(par_nKeyCode, par_nShiftAltCtrl)
1432:         LOCAL loc_oPg2, loc_cValAtual, loc_oBusca, loc_cCod, loc_cDesc
1433:         LOCAL loc_nVarias, loc_nRetSql, loc_cSql
1434: 
1435:         IF PCOUNT() >= 1 AND TYPE("par_nKeyCode") = "N"
1436:             IF !INLIST(par_nKeyCode, 13, 9, 115)
1437:                 RETURN
1438:             ENDIF
1439:         ENDIF
1440: 
1441:         TRY
1442:             loc_oPg2      = THIS.pgf_4c_Paginas.Page2
1443:             loc_cValAtual = ALLTRIM(loc_oPg2.txt_4c_MatPrincs.Value)
1444: 
1445:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1446:                 "SigCdPro", "cursor_4c_BuscaMatPrincs", "CPros", loc_cValAtual, ;
1447:                 "Selecionar Material Principal")
1448: 
1449:             IF VARTYPE(loc_oBusca) = "O"
1450:                 IF !loc_oBusca.this_lAchouRegistro
1451:                     loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
1452:                     loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
1453:                     loc_oBusca.Show()
1454:                 ENDIF
1455: 
1456:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMatPrincs")
1457:                     SELECT cursor_4c_BuscaMatPrincs
1458:                     loc_cCod = ALLTRIM(cursor_4c_BuscaMatPrincs.CPros)
1459: 
1460:                     *-- Verificar Varias (produto deve ter peso variavel = 1)
1461:                     loc_nVarias = 0
1462:                     IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1463:                         loc_cSql = "SELECT Varias FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCod)
1464:                         loc_nRetSql = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_VariasPro")
1465:                         IF loc_nRetSql > 0 AND USED("cursor_4c_VariasPro") AND !EOF("cursor_4c_VariasPro")
1466:                             loc_nVarias = cursor_4c_VariasPro.Varias
1467:                         ENDIF
1468:                         IF USED("cursor_4c_VariasPro")
1469:                             USE IN cursor_4c_VariasPro
1470:                         ENDIF
1471:                     ENDIF
1472: 
1473:                     IF loc_nVarias <> 1
1474:                         MsgAviso("Este Produto n" + CHR(227) + "o est" + CHR(225) + ;
1475:                                  " Configurado para Peso Vari" + CHR(225) + "vel!!!", ;
1476:                                  "Selecionar Material Principal")
1477:                         loc_oPg2.txt_4c_MatPrincs.Value = ""
1478:                     ELSE
1479:                         loc_oPg2.txt_4c_MatPrincs.Value = loc_cCod
1480:                     ENDIF
1481:                 ELSE
1482:                     IF !loc_oBusca.this_lSelecionou AND !loc_oBusca.this_lAchouRegistro
1483:                     loc_oPg2.txt_4c_MatPrincs.Value = ""
1484:                     ENDIF
1485:                 ENDIF
1486: 
1487:                 loc_oBusca.Release()
1488:             ENDIF
1489:         CATCH TO loException
1490:             MsgErro("Erro no lookup material principal:" + CHR(13) + loException.Message, ;
1491:                     "Formgpr.AbrirLookupMatPrincs")
1492:         ENDTRY
1493: 
1494:         IF USED("cursor_4c_BuscaMatPrincs")
1495:             USE IN cursor_4c_BuscaMatPrincs
1496:         ENDIF
1497:     ENDPROC
1498: 
1499:     *--------------------------------------------------------------------------
1500:     * ValidarPrioridade - Valida valor digitado em txt_4c_Prioridade (0 ou 1)
1501:     *--------------------------------------------------------------------------
1502:     PROCEDURE ValidarPrioridade(par_nKeyCode, par_nShiftAltCtrl)
1503:         LOCAL loc_oPg2, loc_nVal
1504: 
1505:         IF PCOUNT() >= 1 AND TYPE("par_nKeyCode") = "N"
1506:             IF !INLIST(par_nKeyCode, 13, 9, 115)
1507:                 RETURN
1508:             ENDIF
1509:         ENDIF
1510: 
1511:         TRY
1512:             loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1513:             loc_nVal  = loc_oPg2.txt_4c_Prioridade.Value
1514:             IF !INLIST(loc_nVal, 0, 1)
1515:                 MsgAviso("Prioridade Inv" + CHR(225) + "lida!!!" + CHR(13) + ;
1516:                          "Informe 0 ou 1.", "Prioridade")
1517:                 loc_oPg2.txt_4c_Prioridade.Value = 0
1518:                 loc_oPg2.txt_4c_Prioridade.SetFocus()
1519:             ENDIF
1520:         CATCH TO loException
1521:             MsgErro("Erro ao validar prioridade:" + CHR(13) + loException.Message, ;
1522:                     "Formgpr.ValidarPrioridade")
1523:         ENDTRY
1524:     ENDPROC
1525: 
1526:     *--------------------------------------------------------------------------
1527:     * FormParaBO - Transfere valores dos controles para o BO
1528:     *--------------------------------------------------------------------------
1529:     PROTECTED PROCEDURE FormParaBO()
1530:         LOCAL loc_lResultado, loc_oPg2, loc_oBO
1531:         loc_lResultado = .F.
1532:         TRY
1533:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1534:             loc_oBO  = THIS.this_oBusinessObject
1535: 
1536:             loc_oBO.this_cCodigos    = ALLTRIM(loc_oPg2.txt_4c_Codigos.Value)
1537:             loc_oBO.this_cDescs      = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
1538:             loc_oBO.this_cCodConPads = ALLTRIM(loc_oPg2.txt_4c_CodConPads.Value)
1539:             loc_oBO.this_cMatPrincs  = ALLTRIM(loc_oPg2.txt_4c_MatPrincs.Value)
1540:             loc_oBO.this_cDigauts    = ALLTRIM(loc_oPg2.txt_4c_CodAut.Value)
1541:             loc_oBO.this_cLinhas     = ALLTRIM(loc_oPg2.txt_4c_Lin.Value)
1542:             loc_oBO.this_nPriors     = loc_oPg2.txt_4c_Prioridade.Value
1543: 
1544:             *-- OptionGroups: opt.Value=1=Sim, opt.Value=2=Nao
1545:             *-- Bloquear Etiqueta Individual: Sim=0, Nao=1
1546:             loc_oBO.this_nBarrefs    = IIF(loc_oPg2.opt_4c_BlqEtq.Value = 1, 0, 1)
1547:             *-- Permite Alterar Dados da Etiqueta: Sim=0, Nao=1
1548:             loc_oBO.this_nAltetiqs   = IIF(loc_oPg2.opt_4c_AlteEtiq.Value = 1, 0, 1)
1549:             *-- Controla por Qtde: Sim=0, Nao=1
1550:             loc_oBO.this_nCpqtds    = IIF(loc_oPg2.opt_4c_Cpq.Value = 1, 0, 1)
1551:             *-- Aplica Falha Admitida: INVERTIDO - Sim=1, Nao=0
1552:             loc_oBO.this_nAplicflhs  = IIF(loc_oPg2.opt_4c_FalhaAdm.Value = 1, 1, 0)
1553:             *-- OF Obrigatorio na Pesagem: Sim=0, Nao=1
1554:             loc_oBO.this_nPesenvs   = IIF(loc_oPg2.opt_4c_PesEnvs.Value = 1, 0, 1)
1555: 
1556:             *-- Campos IDs e sem uso (mantidos com valores padrao / sem edicao direta)
1557:             *-- this_nIds, this_nNchkobjs, this_nFchcxs, this_nAltetiqs, this_nProdecomm
1558:             *-- Esses campos nao tem controles visiveis de edicao, sao mantidos pelo BO
1559: 
1560:             loc_lResultado = .T.
1561:         CATCH TO loException
1562:             MsgErro("Erro ao transferir form para BO:" + CHR(13) + ;
1563:                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
1564:                     loException.Message, "Formgpr.FormParaBO")
1565:         ENDTRY
1566:         RETURN loc_lResultado
1567:     ENDPROC
1568: 
1569:     *--------------------------------------------------------------------------
1570:     * BOParaForm - Transfere valores do BO para os controles
1571:     *--------------------------------------------------------------------------
1572:     PROTECTED PROCEDURE BOParaForm()
1573:         LOCAL loc_lResultado, loc_oPg2, loc_oBO, loc_cSql, loc_nRet
1574:         loc_lResultado = .F.
1575:         TRY
1576:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1577:             loc_oBO  = THIS.this_oBusinessObject
1578: 
1579:             loc_oPg2.txt_4c_Codigos.Value    = ALLTRIM(loc_oBO.this_cCodigos)
1580:             loc_oPg2.txt_4c_Descricao.Value  = ALLTRIM(loc_oBO.this_cDescs)
1581:             loc_oPg2.txt_4c_CodConPads.Value = ALLTRIM(loc_oBO.this_cCodConPads)
1582:             loc_oPg2.txt_4c_MatPrincs.Value  = ALLTRIM(loc_oBO.this_cMatPrincs)
1583:             loc_oPg2.txt_4c_CodAut.Value     = ALLTRIM(loc_oBO.this_cDigauts)
1584:             loc_oPg2.txt_4c_Lin.Value        = ALLTRIM(loc_oBO.this_cLinhas)
1585:             loc_oPg2.txt_4c_Prioridade.Value = loc_oBO.this_nPriors
1586: 
1587:             *-- Buscar descricao do CodConPads (DPros de SigCdPro)
1588:             loc_oPg2.txt_4c_DCodConPads.Value = ""
1589:             IF !EMPTY(loc_oBO.this_cCodConPads) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1590:                 loc_cSql = "SELECT DPros FROM SigCdPro WHERE CPros = " + ;
1591:                             EscaparSQL(ALLTRIM(loc_oBO.this_cCodConPads))
1592:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_DescPro")
1593:                 IF loc_nRet > 0 AND USED("cursor_4c_DescPro") AND !EOF("cursor_4c_DescPro")
1594:                     loc_oPg2.txt_4c_DCodConPads.Value = ALLTRIM(cursor_4c_DescPro.DPros)
1595:                 ENDIF
1596:                 IF USED("cursor_4c_DescPro")
1597:                     USE IN cursor_4c_DescPro
1598:                 ENDIF
1599:             ENDIF
1600: 
1601:             *-- Buscar descricao da Linha (Descs de SigCdLin)
1602:             loc_oPg2.txt_4c_DLin.Value = ""
1603:             IF !EMPTY(loc_oBO.this_cLinhas) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1604:                 loc_cSql = "SELECT Descs FROM SigCdLin WHERE Linhas = " + ;
1605:                             EscaparSQL(ALLTRIM(loc_oBO.this_cLinhas))
1606:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_DescLin")
1607:                 IF loc_nRet > 0 AND USED("cursor_4c_DescLin") AND !EOF("cursor_4c_DescLin")
1608:                     loc_oPg2.txt_4c_DLin.Value = ALLTRIM(cursor_4c_DescLin.Descs)
1609:                 ENDIF
1610:                 IF USED("cursor_4c_DescLin")
1611:                     USE IN cursor_4c_DescLin
1612:                 ENDIF
1613:             ENDIF
1614: 
1615:             *-- OptionGroups (Value=1=Sim, Value=2=Nao)
1616:             *-- Bloquear Etiqueta Individual: DB 0=Sim, DB 1=Nao
1617:             loc_oPg2.opt_4c_BlqEtq.Value    = IIF(loc_oBO.this_nBarrefs = 0, 1, 2)
1618:             *-- Permite Alterar Dados da Etiqueta: DB 0=Sim, DB 1=Nao
1619:             loc_oPg2.opt_4c_AlteEtiq.Value  = IIF(loc_oBO.this_nAltetiqs = 0, 1, 2)
1620:             *-- Controla por Qtde: DB 0=Sim, DB 1=Nao
1621:             loc_oPg2.opt_4c_Cpq.Value       = IIF(loc_oBO.this_nCpqtds = 0, 1, 2)
1622:             *-- Aplica Falha Admitida: INVERTIDO - DB 1=Sim, DB 0=Nao
1623:             loc_oPg2.opt_4c_FalhaAdm.Value  = IIF(loc_oBO.this_nAplicflhs = 1, 1, 2)
1624:             *-- OF Obrigatorio na Pesagem: DB 0=Sim, DB 1=Nao
1625:             loc_oPg2.opt_4c_PesEnvs.Value   = IIF(loc_oBO.this_nPesenvs = 0, 1, 2)
1626: 
1627:             loc_lResultado = .T.
1628:         CATCH TO loException
1629:             MsgErro("Erro ao transferir BO para form:" + CHR(13) + ;
1630:                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
1631:                     loException.Message, "Formgpr.BOParaForm")
1632:         ENDTRY
1633:         RETURN loc_lResultado
1634:     ENDPROC
1635: 
1636:     *--------------------------------------------------------------------------
1637:     * LimparCampos - Limpa todos os controles de edicao da Page2
1638:     *--------------------------------------------------------------------------
1639:     PROTECTED PROCEDURE LimparCampos()
1640:         LOCAL loc_lResultado, loc_oPg2
1641:         loc_lResultado = .F.
1642:         TRY
1643:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1644: 
1645:             loc_oPg2.txt_4c_Codigos.Value    = ""
1646:             loc_oPg2.txt_4c_Descricao.Value  = ""
1647:             loc_oPg2.txt_4c_CodConPads.Value = ""
1648:             loc_oPg2.txt_4c_DCodConPads.Value = ""
1649:             loc_oPg2.txt_4c_Lin.Value        = ""
1650:             loc_oPg2.txt_4c_DLin.Value       = ""
1651:             loc_oPg2.txt_4c_CodAut.Value     = ""
1652:             loc_oPg2.txt_4c_MatPrincs.Value  = ""
1653:             loc_oPg2.txt_4c_Prioridade.Value = 0
1654: 
1655:             loc_oPg2.opt_4c_BlqEtq.Value    = 2
1656:             loc_oPg2.opt_4c_AlteEtiq.Value  = 2
1657:             loc_oPg2.opt_4c_Cpq.Value       = 2
1658:             loc_oPg2.opt_4c_FalhaAdm.Value  = 1
1659:             loc_oPg2.opt_4c_PesEnvs.Value   = 2
1660: 
1661:             loc_lResultado = .T.
1662:         CATCH TO loException
1663:             MsgErro("Erro ao limpar campos:" + CHR(13) + loException.Message, "Formgpr.LimparCampos")
1664:         ENDTRY
1665:         RETURN loc_lResultado
1666:     ENDPROC
1667: 
1668:     *--------------------------------------------------------------------------
1669:     * HabilitarCampos - Habilita ou desabilita controles de edicao
1670:     *--------------------------------------------------------------------------
1671:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1672:         LOCAL loc_lResultado, loc_oPg2
1673:         loc_lResultado = .F.
1674:         TRY
1675:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1676: 
1677:             *-- Codigo so editavel em modo INCLUIR
1678:             loc_oPg2.txt_4c_Codigos.ReadOnly    = !par_lHabilitar OR !THIS.this_oBusinessObject.this_lNovoRegistro
1679:             loc_oPg2.txt_4c_Descricao.ReadOnly  = !par_lHabilitar
1680:             loc_oPg2.txt_4c_CodConPads.ReadOnly = !par_lHabilitar
1681:             loc_oPg2.txt_4c_Lin.ReadOnly        = !par_lHabilitar
1682:             loc_oPg2.txt_4c_CodAut.ReadOnly     = !par_lHabilitar
1683:             loc_oPg2.txt_4c_MatPrincs.ReadOnly  = !par_lHabilitar
1684:             loc_oPg2.txt_4c_Prioridade.ReadOnly = !par_lHabilitar
1685: 
1686:             *-- Campos descricao (lookup) sempre ReadOnly
1687:             loc_oPg2.txt_4c_DCodConPads.ReadOnly = .T.
1688:             loc_oPg2.txt_4c_DLin.ReadOnly        = .T.
1689: 
1690:             *-- OptionGroups
1691:             loc_oPg2.opt_4c_BlqEtq.Enabled    = par_lHabilitar
1692:             loc_oPg2.opt_4c_AlteEtiq.Enabled  = par_lHabilitar
1693:             loc_oPg2.opt_4c_Cpq.Enabled       = par_lHabilitar
1694:             loc_oPg2.opt_4c_FalhaAdm.Enabled  = par_lHabilitar
1695:             loc_oPg2.opt_4c_PesEnvs.Enabled   = par_lHabilitar
1696: 
1697:             loc_lResultado = .T.
1698:         CATCH TO loException
1699:             MsgErro("Erro ao habilitar campos:" + CHR(13) + loException.Message, "Formgpr.HabilitarCampos")
1700:         ENDTRY
1701:         RETURN loc_lResultado
1702:     ENDPROC
1703: 
1704:     *--------------------------------------------------------------------------
1705:     * AjustarBotoesPorModo - Ajusta estado dos botoes Confirmar/Cancelar (Page2)
1706:     * NORMAL = visualizacao: Confirmar desabilitado, Cancelar habilitado
1707:     * EDICAO = inclusao/alteracao: ambos habilitados
1708:     *--------------------------------------------------------------------------
1709:     PROTECTED PROCEDURE AjustarBotoesPorModo(par_cModo)
1710:         LOCAL loc_lResultado, loc_oCnt
1711:         loc_lResultado = .F.
1712:         TRY
1713:             loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva
1714: 
1715:             DO CASE
1716:             CASE par_cModo = "NORMAL"
1717:                 loc_oCnt.cmd_4c_Confirmar.Enabled = .F.
1718:                 loc_oCnt.cmd_4c_Cancelar.Enabled  = .T.
1719:             CASE par_cModo = "EDICAO"
1720:                 loc_oCnt.cmd_4c_Confirmar.Enabled = .T.
1721:                 loc_oCnt.cmd_4c_Cancelar.Enabled  = .T.
1722:             ENDCASE
1723: 
1724:             loc_lResultado = .T.
1725:         CATCH TO loException
1726:             MsgErro("Erro ao ajustar botoes:" + CHR(13) + loException.Message, "Formgpr.AjustarBotoesPorModo")
1727:         ENDTRY
1728:         RETURN loc_lResultado
1729:     ENDPROC
1730: 
1731:     *--------------------------------------------------------------------------
1732:     * FormatarGridLista - Aplica formatacao visual ao grid da Page1
1733:     *--------------------------------------------------------------------------
1734:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1735:         LOCAL loc_lResultado
1736:         loc_lResultado = .F.
1737:         TRY
1738:             WITH par_oGrid
1739:                 .GridLines       = 1
1740:                 .GridLineWidth   = 1
1741:                 .GridLineColor   = RGB(200, 200, 200)
1742:                 .HeaderHeight    = 22
1743:                 .RowHeight       = 20
1744:                 .AllowCellSelection = .F.
1745:                 .DeleteMark      = .F.
1746:                 .RecordMark      = .F.
1747:                 .ReadOnly        = .T.
1748: 
1749:                 WITH .Column1
1750:                     .Width   = 60
1751:                     .Alignment = 2
1752:                     .Header1.FontBold = .T.
1753:                 ENDWITH
1754:                 WITH .Column2
1755:                     .Width   = 300
1756:                     .Header1.FontBold = .T.
1757:                 ENDWITH
1758:                 WITH .Column3
1759:                     .Width   = 200
1760:                     .Header1.FontBold = .T.
1761:                 ENDWITH
1762:             ENDWITH
1763:             loc_lResultado = .T.
1764:         CATCH TO loException
1765:             MsgErro("Erro ao formatar grid:" + CHR(13) + loException.Message, "Formgpr.FormatarGridLista")
1766:         ENDTRY
1767:         RETURN loc_lResultado
1768:     ENDPROC
1769: 
1770:     *--------------------------------------------------------------------------
1771:     * BtnIncluirClick - Inicia inclusao de novo registro
1772:     *--------------------------------------------------------------------------
1773:     PROCEDURE BtnIncluirClick()
1774:         LOCAL loc_lResultado
1775:         loc_lResultado = .F.
1776:         TRY
1777:             THIS.this_oBusinessObject.NovoRegistro()
1778:             THIS.LimparCampos()
1779:             THIS.this_cModoAtual = "INCLUIR"
1780:             THIS.HabilitarCampos(.T.)
1781:             THIS.AjustarBotoesPorModo("EDICAO")
1782:             THIS.AlternarPagina(2)
1783:             THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus()
1784:             loc_lResultado = .T.
1785:         CATCH TO loException
1786:             MsgErro("Erro ao incluir:" + CHR(13) + loException.Message, "Formgpr.BtnIncluirClick")
1787:         ENDTRY
1788:         RETURN loc_lResultado
1789:     ENDPROC
1790: 
1791:     *--------------------------------------------------------------------------
1792:     * BtnAlterarClick - Inicia alteracao do registro selecionado
1793:     *--------------------------------------------------------------------------
1794:     PROCEDURE BtnAlterarClick()
1795:         LOCAL loc_lResultado, loc_cCodigo
1796:         loc_lResultado = .F.
1797:         TRY
1798:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1799:                 MsgAviso("Selecione um registro para alterar.", "Alterar")
1800:             ELSE
1801:                 SELECT cursor_4c_Dados
1802:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
1803:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1804:                     THIS.this_oBusinessObject.EditarRegistro()
1805:                     THIS.BOParaForm()
1806:                     THIS.this_cModoAtual = "ALTERAR"
1807:                     THIS.HabilitarCampos(.T.)
1808:                     THIS.AjustarBotoesPorModo("EDICAO")
1809:                     THIS.AlternarPagina(2)
1810:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus()
1811:                     loc_lResultado = .T.
1812:                 ENDIF
1813:             ENDIF
1814:         CATCH TO loException
1815:             MsgErro("Erro ao alterar:" + CHR(13) + loException.Message, "Formgpr.BtnAlterarClick")
1816:         ENDTRY
1817:         RETURN loc_lResultado
1818:     ENDPROC
1819: 
1820:     *--------------------------------------------------------------------------
1821:     * BtnVisualizarClick - Exibe registro selecionado em modo somente leitura
1822:     *--------------------------------------------------------------------------
1823:     PROCEDURE BtnVisualizarClick()
1824:         LOCAL loc_lResultado, loc_cCodigo
1825:         loc_lResultado = .F.
1826:         TRY
1827:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1828:                 MsgAviso("Selecione um registro para visualizar.", "Visualizar")
1829:             ELSE
1830:                 SELECT cursor_4c_Dados
1831:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
1832:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1833:                     THIS.BOParaForm()
1834:                     THIS.this_cModoAtual = "VISUALIZAR"
1835:                     THIS.HabilitarCampos(.F.)
1836:                     THIS.AjustarBotoesPorModo("NORMAL")
1837:                     THIS.AlternarPagina(2)
1838:                     loc_lResultado = .T.
1839:                 ENDIF
1840:             ENDIF
1841:         CATCH TO loException
1842:             MsgErro("Erro ao visualizar:" + CHR(13) + loException.Message, "Formgpr.BtnVisualizarClick")
1843:         ENDTRY
1844:         RETURN loc_lResultado
1845:     ENDPROC
1846: 
1847:     *--------------------------------------------------------------------------
1848:     * BtnExcluirClick - Exclui o registro selecionado
1849:     *--------------------------------------------------------------------------
1850:     PROCEDURE BtnExcluirClick()
1851:         LOCAL loc_lResultado, loc_cCodigo, loc_lConfirma
1852:         loc_lResultado = .F.
1853:         TRY
1854:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1855:                 MsgAviso("Selecione um registro para excluir.", "Excluir")
1856:             ELSE
1857:                 SELECT cursor_4c_Dados
1858:                 loc_cCodigo  = ALLTRIM(cursor_4c_Dados.codigos)
1859:                 loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do grande grupo '" + ;
1860:                                             loc_cCodigo + "'?", "Excluir")
1861:                 IF loc_lConfirma
1862:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1863:                         IF THIS.this_oBusinessObject.Excluir()
1864:                             MsgInfo("Grande grupo exclu" + CHR(237) + "do com sucesso.", "Excluir")
1865:                             THIS.CarregarLista()
1866:                         ENDIF
1867:                     ENDIF
1868:                     loc_lResultado = .T.
1869:                 ENDIF
1870:             ENDIF
1871:         CATCH TO loException
1872:             MsgErro("Erro ao excluir:" + CHR(13) + loException.Message, "Formgpr.BtnExcluirClick")
1873:         ENDTRY
1874:         RETURN loc_lResultado
1875:     ENDPROC
1876: 
1877:     *--------------------------------------------------------------------------
1878:     * BtnBuscarClick - Abre busca e navega ao registro localizado
1879:     *--------------------------------------------------------------------------
1880:     PROCEDURE BtnBuscarClick()
1881:         LOCAL loc_lResultado, loc_cCodigo
1882:         loc_lResultado = .F.
1883:         TRY
1884:             loc_cCodigo = ""
1885:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1886:                 SELECT cursor_4c_Dados
1887:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
1888:             ENDIF
1889: 
1890:             LOCAL loc_oBusca
1891:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1892:                 "SigCdGpr", "cursor_4c_BuscaGpr", "codigos", loc_cCodigo, ;
1893:                 "Buscar Grande Grupo")
1894: 
1895:             IF VARTYPE(loc_oBusca) = "O"
1896:                 IF !loc_oBusca.this_lAchouRegistro
1897:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
1898:                     loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
1899:                     loc_oBusca.Show()
1900:                 ENDIF
1901: 
1902:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGpr")
1903:                     SELECT cursor_4c_BuscaGpr
1904:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaGpr.codigos)
1905:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1906:                         THIS.BOParaForm()
1907:                         THIS.this_cModoAtual = "VISUALIZAR"
1908:                         THIS.HabilitarCampos(.F.)
1909:                         THIS.AjustarBotoesPorModo("NORMAL")
1910:                         THIS.AlternarPagina(2)
1911:                     ENDIF
1912:                     loc_lResultado = .T.
1913:                 ENDIF
1914: 
1915:                 loc_oBusca.Release()
1916:             ENDIF
1917:         CATCH TO loException
1918:             MsgErro("Erro ao buscar:" + CHR(13) + loException.Message, "Formgpr.BtnBuscarClick")
1919:         ENDTRY
1920: 
1921:         IF USED("cursor_4c_BuscaGpr")
1922:             USE IN cursor_4c_BuscaGpr
1923:         ENDIF
1924:         RETURN loc_lResultado
1925:     ENDPROC
1926: 
1927:     *--------------------------------------------------------------------------
1928:     * BtnSalvarClick - Salva o registro (inserir ou atualizar)
1929:     *--------------------------------------------------------------------------
1930:     PROCEDURE BtnSalvarClick()
1931:         LOCAL loc_lResultado, loc_oBO
1932:         loc_lResultado = .F.
1933:         TRY
1934:             loc_oBO = THIS.this_oBusinessObject
1935: 
1936:             IF !THIS.FormParaBO()
1937:                 loc_lResultado = .F.
1938:             ELSE
1939:                 loc_lResultado = loc_oBO.Salvar()
1940: 
1941:                 IF loc_lResultado
1942:                     MsgInfo("Grande grupo salvo com sucesso.", "Salvar")
1943:                     THIS.this_cModoAtual = "LISTA"
1944:                     THIS.HabilitarCampos(.F.)
1945:                     THIS.AjustarBotoesPorModo("NORMAL")
1946:                     THIS.AlternarPagina(1)
1947:                 ENDIF
1948:             ENDIF
1949:         CATCH TO loException
1950:             MsgErro("Erro ao salvar:" + CHR(13) + ;
1951:                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
1952:                     loException.Message, "Formgpr.BtnSalvarClick")
1953:         ENDTRY
1954:         RETURN loc_lResultado
1955:     ENDPROC
1956: 
1957:     *--------------------------------------------------------------------------
1958:     * BtnCancelarClick - Cancela a edicao atual e volta para a lista
1959:     *--------------------------------------------------------------------------
1960:     PROCEDURE BtnCancelarClick()
1961:         LOCAL loc_lResultado
1962:         loc_lResultado = .F.
1963:         TRY
1964:             THIS.LimparCampos()
1965:             THIS.this_cModoAtual = "LISTA"
1966:             THIS.HabilitarCampos(.F.)
1967:             THIS.AjustarBotoesPorModo("NORMAL")
1968:             THIS.AlternarPagina(1)
1969:             loc_lResultado = .T.
1970:         CATCH TO loException
1971:             MsgErro("Erro ao cancelar:" + CHR(13) + loException.Message, "Formgpr.BtnCancelarClick")
1972:         ENDTRY
1973:         RETURN loc_lResultado
1974:     ENDPROC
1975: 
1976:     *--------------------------------------------------------------------------
1977:     * Destroy - Libera recursos do formulario
1978:     *--------------------------------------------------------------------------
1979:     PROCEDURE Destroy()
1980:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1981:             THIS.this_oBusinessObject = .NULL.
1982:         ENDIF
1983:         DODEFAULT()
1984:     ENDPROC
1985: 
1986: ENDDEFINE


### BO (C:\4c\projeto\app\classes\gprBO.prg):
*==============================================================================
* gprBO.prg
*
* Business Object para Grande Grupo de Produto (SigCdGpr)
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS gprBO AS BusinessBase

    *-- Propriedades da tabela SigCdGpr
    this_cCodigos     = ""    && codigos    char(3)      PK
    this_cDescs       = ""    && descs      char(40)
    this_cCodConPads  = ""    && codconpads char(14)     Produto Padrao de Conserto
    this_cMatPrincs   = ""    && matprincs  char(14)     Material Principal
    this_nCpqtds      = 0     && cpqtds     numeric(1,0) Controla por Qtde
    this_cDigauts     = ""    && digauts    char(1)      Digito Codigo Automatico
    this_nIds         = 0     && ids        numeric(10,0)
    this_nAplicflhs   = 0     && aplicflhs  numeric(1,0) Aplica Falha Admitida
    this_nBarrefs     = 0     && barrefs    numeric(1,0) Bloquear Alteracao Etiqueta Individual
    this_nDigbars     = 0     && digbars    numeric(1,0)
    this_nPesenvs     = 0     && pesenvs    numeric(1,0) OF Obrigatorio na Pesagem
    this_cLinhas      = ""    && linhas     char(10)     Linha Padrao de Cadastro
    this_nFchcxs      = 0     && fchcxs     numeric(1,0)
    this_nPriors      = 0     && priors     numeric(1,0) Prioridade Recalculo Saldo
    this_nAltetiqs    = 0     && altetiqs   numeric(1,0) Permite Alterar Dados Etiqueta
    this_nNchkobjs    = 0     && nchkobjs   numeric(1,0)
    this_nProdecomm   = 0     && prodecomm  numeric(1,0)

    *-- Campos de exibicao (nao persistidos na tabela)
    this_cDescConPads = ""    && Descricao do Produto Padrao de Conserto (SigCdPro.DPros)
    this_cDescLin     = ""    && Descricao da Linha Padrao (SigCdLin.Descs)

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdGpr"
            THIS.this_cCampoChave = "codigos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "gprBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDFUNC

    *==========================================================================
    * ValidarDados - Valida dados antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigos)
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCodigos)
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " Cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDescs)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND !INLIST(THIS.this_nPriors, 0, 1)
            MsgAviso("Prioridade Inv" + CHR(225) + "lida!!! Use 0 ou 1.")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * VerificarCodigoExistente - Verifica se codigos ja existe em SigCdGpr
    *==========================================================================
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdGpr" + ;
                " WHERE codigos = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                SELECT cursor_4c_ChkCod
                loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "gprBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigos     = TratarNulo(codigos,    "C")
                THIS.this_cDescs       = TratarNulo(descs,      "C")
                THIS.this_cCodConPads  = TratarNulo(CodConPads, "C")
                THIS.this_cMatPrincs   = TratarNulo(Matprincs,  "C")
                THIS.this_nCpqtds      = TratarNulo(cpqtds,     "N")
                THIS.this_cDigauts     = TratarNulo(digauts,    "C")
                THIS.this_nIds         = TratarNulo(ids,        "N")
                THIS.this_nAplicflhs   = TratarNulo(AplicFlhs,  "N")
                THIS.this_nBarrefs     = TratarNulo(Barrefs,    "N")
                THIS.this_nDigbars     = TratarNulo(digbars,    "N")
                THIS.this_nPesenvs     = TratarNulo(PesEnvs,    "N")
                THIS.this_cLinhas      = TratarNulo(linhas,     "C")
                THIS.this_nFchcxs      = TratarNulo(Fchcxs,     "N")
                THIS.this_nPriors      = TratarNulo(priors,     "N")
                THIS.this_nAltetiqs    = TratarNulo(AltEtiqs,   "N")
                THIS.this_nNchkobjs    = TratarNulo(nChkObjs,   "N")
                THIS.this_nProdecomm   = TratarNulo(prodecomm,  "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "gprBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Insere novo registro na tabela SigCdGpr
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdGpr (codigos, descs, CodConPads, Matprincs,
                    cpqtds, digauts, AplicFlhs, Barrefs, PesEnvs,
                    linhas, priors, AltEtiqs, nChkObjs, Fchcxs, digbars, prodecomm)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigos)>>,
                    <<EscaparSQL(THIS.this_cDescs)>>,
                    <<EscaparSQL(THIS.this_cCodConPads)>>,
                    <<EscaparSQL(THIS.this_cMatPrincs)>>,
                    <<FormatarNumeroSQL(THIS.this_nCpqtds, 0)>>,
                    <<EscaparSQL(THIS.this_cDigauts)>>,
                    <<FormatarNumeroSQL(THIS.this_nAplicflhs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nBarrefs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nPesenvs, 0)>>,
                    <<EscaparSQL(THIS.this_cLinhas)>>,
                    <<FormatarNumeroSQL(THIS.this_nPriors, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nAltetiqs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nNchkobjs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nFchcxs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nDigbars, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nProdecomm, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir grande grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "gprBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdGpr
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdGpr
                SET descs      = <<EscaparSQL(THIS.this_cDescs)>>,
                    CodConPads = <<EscaparSQL(THIS.this_cCodConPads)>>,
                    Matprincs  = <<EscaparSQL(THIS.this_cMatPrincs)>>,
                    cpqtds     = <<FormatarNumeroSQL(THIS.this_nCpqtds, 0)>>,
                    digauts    = <<EscaparSQL(THIS.this_cDigauts)>>,
                    AplicFlhs  = <<FormatarNumeroSQL(THIS.this_nAplicflhs, 0)>>,
                    Barrefs    = <<FormatarNumeroSQL(THIS.this_nBarrefs, 0)>>,
                    PesEnvs    = <<FormatarNumeroSQL(THIS.this_nPesenvs, 0)>>,
                    linhas     = <<EscaparSQL(THIS.this_cLinhas)>>,
                    priors     = <<FormatarNumeroSQL(THIS.this_nPriors, 0)>>,
                    AltEtiqs   = <<FormatarNumeroSQL(THIS.this_nAltetiqs, 0)>>,
                    nChkObjs   = <<FormatarNumeroSQL(THIS.this_nNchkobjs, 0)>>,
                    Fchcxs     = <<FormatarNumeroSQL(THIS.this_nFchcxs, 0)>>,
                    digbars    = <<FormatarNumeroSQL(THIS.this_nDigbars, 0)>>,
                    prodecomm  = <<FormatarNumeroSQL(THIS.this_nProdecomm, 0)>>
                WHERE codigos = <<EscaparSQL(THIS.this_cCodigos)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar grande grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "gprBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdGpr
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdGpr WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir grande grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "gprBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com codigos, descs, linhas (colunas do grid)
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (codigos C(3), descs C(40), linhas C(10))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.codigos, a.descs, a.linhas FROM SigCdGpr a"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY a.codigos"

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
                        MostrarErro("Erro ao buscar grandes grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar grandes grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "gprBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (codigos)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.codigos, a.descs, a.CodConPads, a.Matprincs," + ;
                " a.cpqtds, a.digauts, a.ids, a.AplicFlhs, a.Barrefs," + ;
                " a.digbars, a.PesEnvs, a.linhas, a.Fchcxs, a.priors," + ;
                " a.AltEtiqs, a.nChkObjs, a.prodecomm" + ;
                " FROM SigCdGpr a WHERE a.codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Grande Grupo n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar grande grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "gprBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

